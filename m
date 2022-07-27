Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB0DC04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 22:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44749C7E37;
	Wed, 27 Jul 2022 22:31:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966F3C78F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 22:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhEy6X2Fw91V44IT02INFbHkN6WuY5jMCp1CViKFasLDPpmvWSJ3PB0sdR6sMyOLFauLjve1+961SPHy5IpyvPZRsqihkLxPnR7HpSdpF3tjZPDWY/zrH+jnzv10+41YjGf5eGiVRnB0djj/k/sRO699W5Fj7F9iXbFmYuubHQ1O8GG5EjeK+efotXGirmaUmoIp79FqoAZCRRmIO8E17Wbu5lE6xRnwNgOuamLGdv1DDjD63ufFG/hpVTEMXHxzHZ1S8JryN4jnxuXGydfphQ/Uvabz3CBxcbHaqOruUIIZGFme/GZzO+s2zPxZtMSIktVy+L7DW9FsmbxQH4IYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGw7T8fKQCyIH3tGtWTtGyoBMhG7dvNVEwTs73U8yWM=;
 b=LmAytfvJHt1HdgkyfLIOVa+HoPfgCMLGUjMsHRvAJjoc/tlf7DYd/xVQvM7R/lTlf9WMb5D740aWbhIjDs1UmuRrOpsIJ5CDly1fhEvnS5Q0Erk2rcyNVYtFoy7m8yLQzVH7Sfi3vPuPFiQYft8YE6NG42m5SNJSUSDM2mA8QfLPWAGm5ESS1YPMWiYRJAdZk0+PCSqkbz6GNak+V95zu4R0hrdHQNJye61nS2UdLroULn1+qQS9kXyp98obCv+pLTOHlt5IKAkPNYQ/ih8yDJnQlnIv4balA9yuRUm6hBIsHJ9s/VEAa3PS/0OtAwKGcupFqiHqWsuqzHAj/Glo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGw7T8fKQCyIH3tGtWTtGyoBMhG7dvNVEwTs73U8yWM=;
 b=5QJIrMVfQ4vKzq3C8dt52g7RelP+JJMKEtPt/S9M65p1lo9kuCHcILU/3H+X9tigjZAsWrkW0I3jQTkwfUC6Ch2RU3LoQ5SKlQcu5uNNS+xLzcpTnTRlfSCc9AKJCwViLbG/Glj2xwwF4HU7xgXylnbihKUuZTaSirQ6OK1p9fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 22:31:06 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 22:31:06 +0000
Message-ID: <41e69e29-8434-06cb-d1a8-84ceef100cc3@amd.com>
Date: Wed, 27 Jul 2022 18:31:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] Revert reduce stack size for DML code
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220727221855.324361-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_MJnDcMr2-zQ2Uwcj-QVFubm8QAdfr5X6AP6ONkZA-cfA@mail.gmail.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <CADnq5_MJnDcMr2-zQ2Uwcj-QVFubm8QAdfr5X6AP6ONkZA-cfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:5a::29) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8004f6bf-55fa-4d21-4e10-08da701fb232
X-MS-TrafficTypeDiagnostic: DM6PR12MB4909:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1RdJVSuJJwWobpDoTld9Zca2HmLUwjF2MZxFtAcYwSWbS+Mgy2KWQfT7DVq1ZgHr2EEBZyA1/sVPLehX6a+ObPgFYZB/svuESSg1CCkP7w5I0smWv2ad0SGv/CmrHeMcy6J2RHuUH3rmsztF72qI+AA3IlklPBBU96eG+ILQIJMGz7nkzJLDENCHKitBYq6vgbaW1gCn1CrjNhETGRFBFk1DcsPJSfDSAo7lx/iNLrixizJMqFF6MdyA91xPPSMLvusVyFxko35Sh+TQrDbop3J+j4FhsY5zPunipm1qR/Yaui1GOIlvT6Arz3/qEItuJPB7N/Fw6MFcPQB0c3MKF3Vlysnd8nyvaWewMhYR+pKn3rfP8jbl2YSwI4yVHlZkzJ7Dxs+dp9HTtQ0bWnBFri7XDIB32pH7Afkhg2cUv9v25tpZ/AM6Y3LQ9Iueei7y6rebcoZTX6NF0yoSIKgLNjkV6Zkm9BNnQ0YU+ofDUy4v4rr+MFUQp8UL+0xKOxaU/fYG5V0xaC5AvDAPmNdXZ1b3CisG/Yzlt0i4bMXg7A/s/3PY/jRkTuUhbWyJoRsawqzkmhwPuZqiS2mLdiAUIv3PcfjRk16eYRvQh0+lYxShpUl8fes2O4PJYh6g/N42whvrKu9uZEWcjDBl37kHsNRpkx1uPUp6YIwl1VTKhyhJsVgjEMbhx1sx69y8vDiTtRgH9hPsH/Y3+u3wam8xyGvae/VS+/sJPK/o6LhjSDdy2DFtK8bZERS7T5niOyX22qHLFYrwNIRbLjsQ27OKtSnNlnsAtdM2TOazL1rKscqpr4Rvb+nmXCR1KTgpoNgO6WW1kPDGUXhmTdI6aL0mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(26005)(38100700002)(6916009)(6512007)(66556008)(66946007)(2906002)(66476007)(4326008)(54906003)(8676002)(6506007)(53546011)(41300700001)(478600001)(8936002)(6486002)(31696002)(86362001)(83380400001)(2616005)(19627235002)(186003)(36756003)(5660300002)(31686004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VFR1Z2azJJNUZlOEhVejNzVDNOV3JuV1NYZ2FpcGpPOHFyNlNQN0NWS1Fa?=
 =?utf-8?B?c0pJbThBYVFLZWtub0JDNUxPTllWSTZzQjlvbGFlQ2doVHI4elBHZzREZ09s?=
 =?utf-8?B?YVJmbFhiNVRoTlVyeHYwMU8wR2dSTUtaWGxnV1crV1FRUUZ0VGFkLzlJMFBJ?=
 =?utf-8?B?cTRpZFZyNkVqR1ZEUHZjQnZlMnNJQWNja2dXd0thcHhZZ0dBTnFwYjJzQjFy?=
 =?utf-8?B?TXlOSzVwQ0xIVEFnbkhEdGU5aER0NFlueTcwRHFTNS8xV3NMRVJ2VTRJOXkx?=
 =?utf-8?B?YTB4UGNMNlhLekdGQUh3ZnA0TzJpYU8xZDhLemZBajRiT0ZtL1hHNVphZ3dR?=
 =?utf-8?B?NUhBcE1BK2VkM2F0NkNPdzdNcDdKQW8xYmxtMlBXc3NESnR6cHpVUnpFeUVS?=
 =?utf-8?B?UnpDNk4xVUxsVjhVSU9FQkpWblhFdVdKQndYZ2RWQ09NTCs4TnlGUjQyak1l?=
 =?utf-8?B?cUlGZkwvek5kMWtKZEJhOWUwTmhYQmRCVUlXaXFvbDIrOHAweldFQTA1WEg3?=
 =?utf-8?B?bjZqSnFSTzlFWWZCZVNIU3BEZ0lMU2R5a3M1SzA5SG5aMjBnbi9SM1VzMHZ6?=
 =?utf-8?B?c0ErZksxb3ZNbWJPcmYzd296YytNUHlSVHFaUjdGVm1XVzVWLzhnTE9GdWts?=
 =?utf-8?B?UUQ0cTVmcmRuTGVJbFV1MzRyY0x5ZllKN1REZHdQaDhZWGgyaG95MXdEc1Vy?=
 =?utf-8?B?UEloWjcrVVVwdXozS3ZsN3d3ZzA0WWNWUG9tSjljaWFkQ3ZyNCtpa1BtZHVP?=
 =?utf-8?B?ZTAwTXE2dG15d0FTcHJHNDcrRHl2R29PWnVMdW5tMVpkSHUycExwZ2I3RU9T?=
 =?utf-8?B?eUNDYkQ1TWpsak1kWHlzVzRqa1VTWmlNUHV4L3ZhYWx2Q1hFU1lxOUoySUtz?=
 =?utf-8?B?TjAvVWJMakZDZ2VWZjVrRDhWY0tRTnV6MmdEaVQ1Sm5mM2NpNmRPUFlhbU5R?=
 =?utf-8?B?cFh3aFBjMTFlU3haM215RDFMcm8vdjcxQjU5bTNiSGUyeVVyYVE5eGhzNlZ4?=
 =?utf-8?B?b0ZIaGZmWlA3Z0N6ODliMmFnNG4zWENhakN4Skc3OVA2R2V4TU5WVlBuZUtH?=
 =?utf-8?B?Z2Q3ZDR6dU0rSGZ4N1RNNk0zSlFtZ2FPT0M0a1NkbmNMRzBjdjI5S3ZOOFd4?=
 =?utf-8?B?d0Zqd1J4N0Fid2JVaUhYSkpmSjV6Y2s4Um9QaU1hajlHWGRFcmpZL0loR3VS?=
 =?utf-8?B?RGtXME8xQ2xNSmREaVFqYlB3dVoxdGxyNHg5aU9MTFZ3aVZTV0d5UnMxdU5O?=
 =?utf-8?B?UXZ0UDdNN3hSMmlwSFF2VHpGVlRwMW56cEtYdjE3bko4UW1pYXNBMVd4cG1F?=
 =?utf-8?B?ZVJteGczTkpGWjFra0M0QXhqMnlQalVXNld0cmpia29qRlI1Z210SGpPOVFO?=
 =?utf-8?B?Y04wZXVyZ1FEam9JRk9qeTN2RktPSzFjNEVnWExYSklaeU1ReWo2MFh4UGF2?=
 =?utf-8?B?ZUhCMUR5eUhJT2R2WUZ1WXB4bDdLMklSb1RTNG93WDFJeWhVYk1SbzkyamNE?=
 =?utf-8?B?Z3k0c0g3NlV6WlZ5YUI0M0NJTlRNWUJlZENENVQwZ2xrM0NhUUZQS3FZVzcw?=
 =?utf-8?B?aDh6WDFhSm5yVTZMaEJCOS90UnlWblpMRnkvM3N0NXlKak9KS05KV0RaREJW?=
 =?utf-8?B?M2kyZkVyb1VhVXprR0N4MmxmTGNmLzJhWHVXWlpIWVRPT1JSQWErWVRNWXhz?=
 =?utf-8?B?UUpzVFh1cUY5Y0JLd1ZwMGx5Vm5OaHY3cnp1YUVVTTBtc2pjbitqY3NLaHZm?=
 =?utf-8?B?MFZHanhLL3BQNmNmbUowSnBOeWpVUmlzODMzOTZHTy9ud3lvMGgvMmhzb0lR?=
 =?utf-8?B?N2VHRm1lMVhZN05EeVNnaGkxMXkrMDlNdGY0YmM1amtjQWFEUmw5OXQyVjBT?=
 =?utf-8?B?U1h1WCtEMzFjY2VzQjM2WEtrcXN6VTh3Vk10OW5ZSzZtYUV4ditKM2FYRTZB?=
 =?utf-8?B?QUlIaURZS2VSREFrQ3ZlVmN5Nlhzd3o3RDROMkdOS3NiSnZQUGZmd0FIbHBm?=
 =?utf-8?B?R2tsNGlQZHkzUkdiQ3VabmhHRjVjWnZscVVkZmxYUWJVb0tidjdqUGNvZjFi?=
 =?utf-8?B?aW1GcllsaXY0QVQ0eUFWTktyZmNDV0lDSEM4bE8zWCttdlJZZGZOZmhtbmRt?=
 =?utf-8?Q?HSIG7X6SnQExE14V706J6tqMC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8004f6bf-55fa-4d21-4e10-08da701fb232
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 22:31:06.4159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7FmZomH5wxPL16cT07AUhCMXWE+krV661qiwK8ix44uvarZyYd3SjfFuxMletB+6oWDlEYu6+BMu/45mlQIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-07-27 18:22, Alex Deucher wrote:
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thanks Alex,

Patshet pushed to amd-staging-drm-next.

Best Regards
Siqueira

> 
> On Wed, Jul 27, 2022 at 6:19 PM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
>>
>> We had a stack size issue on DML, and we tried to fix it by moving some
>> of the local variables to some of the DML struct. In this process of
>> reducing the stack size, we sent some other patches that fixed the issue
>> reported by Stephen, and the below set of patches become unnecessary:
>>
>> 987949933127 drm/amd/display: reduce stack for dml32_CalculatePrefetchSchedule
>> 8f08cd32b767 drm/amd/display: reduce stack for dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport
>> 5d526d124fe3 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
>> f6ceebcc7825 drm/amd/display: reduce stack for dml32_CalculateSwathAndDETConfiguration
>>
>> For this reason, this patchset reverts all of the above patches.
>>
>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>
>> Thanks
>> Siqueira
>>
>> Rodrigo Siqueira (4):
>>    Revert "drm/amd/display: reduce stack for
>>      dml32_CalculatePrefetchSchedule"
>>    Revert "drm/amd/display: reduce stack for
>>      dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport"
>>    Revert "drm/amd/display: reduce stack for
>>      dml32_CalculateVMRowAndSwath"
>>    Revert "drm/amd/display: reduce stack for
>>      dml32_CalculateSwathAndDETConfiguration"
>>
>>   .../dc/dml/dcn32/display_mode_vba_32.c        |  12 +-
>>   .../dc/dml/dcn32/display_mode_vba_util_32.c   | 812 ++++++++++--------
>>   .../dc/dml/dcn32/display_mode_vba_util_32.h   |   5 -
>>   .../drm/amd/display/dc/dml/display_mode_vba.h | 106 ---
>>   4 files changed, 441 insertions(+), 494 deletions(-)
>>
>> --
>> 2.35.1
>>

