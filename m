Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B50DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 23:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79F510E9D2;
	Wed, 16 Mar 2022 23:32:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E48210E9D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 23:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFZRMDbEVCq7un2Rma0ur+O8yARBqatar7PPLIrGb6VUcBThtF/PYexY7Tyghl+xCvh8yYE3mfKjBEYvWqq/ZLSknNCbCr0enc4Cchp0GXG80YH4wfC0BUwY2PCPKMe8+YJKeKqM9Hl3n0v4OSTiJi7iPkd482USixK9pwc/15s2P5O14sXEJKwI9Vs2TwNaKVOy4sn623X02IbvJ03VOld3AsJENneboM4HtAyZQGDR2nFsaNRL6g0UiI2L9V75IktbZWI4P25M1ZbO/xlLZ7yFqrjBmkP6HdxTNr5dmDL9yUgvWtZFgcu3rukATg1pUAcDpEHNQGc++QLMuMhwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Afj4FpHuU7KxoT4fUlG0Sn8b3Efe+4kRKFcwO0slxv4=;
 b=DY9H/R28JhB6nXhdLngQL4uB7Wuh0/p/scaaoK1aoEHU1BpFMJ9tb8rrB/hzTMWH1M6funvpckXhjqFOH0g7o2XKjh+Gscj4cC/U3Dl5yJlJ8mGh0/4NUaRKZPU8RRh4Ye5qbnX5zhzYof+kfe50z+S5Xk3TOIH2yL1+0Ub4F1CK6G3DhibfSFCJlFvcsi/Awdg25dNtwX+vg6b6l4LmJju0+ja1qYh/DcdomkNPo0/LeyQn1vs9Q+LLcJgyZTSi8ZmrX5qV6oNDWcE6H51bFixkIbWeMnsGIWiDVOatoL0SnXLcSYGmDE5ss/V4uHz5nK3Hmv2oiO2/pLkKYEydGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afj4FpHuU7KxoT4fUlG0Sn8b3Efe+4kRKFcwO0slxv4=;
 b=LkJ5MFYNnGcnEFBtTEj4HCZoFWl7CXPmjlzj/KZaN2jX9GCwCyVCWiEMBJtFwmwnM8lM5ekqUFkf3lgLR1ihBchBDuVLKdxUYEiXuRWT+0HLjVSuIN/RBUWZKN6OQ3qQk/PPLROr8l9ai+/VlEotdH5bqUWGuLWhSR9vbZ1qLi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 23:32:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 23:32:32 +0000
Message-ID: <525659f9-bc04-de58-c416-ab000c1de9eb@amd.com>
Date: Wed, 16 Mar 2022 19:32:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdgpu: set noretry=1 for GFX 10.3.4
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20220302202014.2439629-1-Felix.Kuehling@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220302202014.2439629-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0015.prod.exchangelabs.com (2603:10b6:208:71::28)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2963d4de-45b6-4ec5-d970-08da07a53e54
X-MS-TrafficTypeDiagnostic: DS7PR12MB5981:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB59815453EEB956139F064F4B92119@DS7PR12MB5981.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dAoXsNs0lvIYEyxKAiIEh7tAsLc1cQvg7XJckuXdsuo6LPekQuhV3R6xvMpkjJgFylmpy+/vyA66gQNNSr/CtLKbsFHku7RmZO6MCerIC7KOp+pLQGlbx8/hRuAyvsyii5EEXUjJtt1CiQogtRp5tjxMC5UwcOlL80hseZ8U+XH0NTLgla4AdRAx4cNmtXflueoKX+LQpeARF+p5DuWVk8wruvqpUvSOp4iY7uu1ROyUGJRoQ7qMJpPDzXqIAFGKb4g5QeLo7xeNCGnfJZGdTvshucqd7KzznCDgOJqqPOE+ffacJEoYLqRm+yUdNR50z2VsJTbUFzVg6qOpawgY5k43phoqS/XEcfbsdbg1oyyvrhByeE8KHu7G3HNCwOKvx3DfycV8exwZxs3gSKskFSpRN8WOsfd/ExdOthHSOXLm8Vi4orOPSOgkAUx0ZV8LkyweCn97u8xsFqFnKbL1m6/wQ5LvzxfZjIyGzcPE7Y+uGu0IvtWHdZL32evlRXa0eHk9vCrATnTB4Xz1Jb3ul1hRoCcYAcP4H35r9Mq3Svh93XrmZuTd11HX3w17l19EmWdEWq6qyipCG0o+IJV+WYS+/0vf6x+3mAG7/7zUlqgkGsOiaw7oiAH0HebdO4fXXsizv0eeok4BPw2aP7Pbl+eicdAPn4TwWslZknmAN1XcUIcjB4Kps35Ju5eoCEEom9xr7UdjQT5HOQsjypQ8AOFvxLAFdye1NRyFmSVn32e0W4YbyDd+Z35tiD7ZglT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(8676002)(66476007)(36916002)(8936002)(66946007)(66556008)(38100700002)(53546011)(6916009)(6486002)(508600001)(86362001)(316002)(6506007)(31696002)(5660300002)(31686004)(6512007)(2616005)(36756003)(44832011)(2906002)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVE5a051S2o2VGF5SVNoT2Q5d2JUWWNRc1hkTWszN3VTZ2NYU1l3RXNRTS8w?=
 =?utf-8?B?ZERvTnRMVEk2UzFGbW5TUE4vbEdnSGtPa2hpNkNxOUVCM04zYkM0YnNQUnhU?=
 =?utf-8?B?ZEtqU2RTc1FFbjRhdW5LdFJ0OGRyZk94dkNaaE1JUnZPQXlra0NhRW5SRnkz?=
 =?utf-8?B?d0FtbTMwV0RkTnBoTzNObDJSTjlFZ2IyTDA2bmNPTlJ2TFIxUFpLVnB0TXlD?=
 =?utf-8?B?ZUVqYndzWVhhUUFRSHlKeEMxcjYxeE84WXd4ZHdtR2dpcllZam1GdTZCMzZX?=
 =?utf-8?B?cWZuNGJkQjUyMEZMeXRWM0RWMVJ0SkRiRUkrczR1Y3E2M1VCeUxucmpUK1RH?=
 =?utf-8?B?dUtXdzBLVjJQa042M0dYWGI1NWRJYmN5NnVHenhLY0NlOEU1ZDRJTGZSOVpx?=
 =?utf-8?B?UTZianQ3eUdPYk1NMVdVNkVFLzRxcVh4blh1K0duSmlEbXV2ZUxSTEpVUzZk?=
 =?utf-8?B?dnVpSWlVZU5NSkdHSm83WkVaeCtKMk0wOTBBQzRCRHNWdjNlcmZ0dFJaaCtP?=
 =?utf-8?B?VUpHSGJmV051NmtMeDVIeHVrYjNrbXh1WVZrYW1nejMrNDA5UkNPbS9Ed2hD?=
 =?utf-8?B?bGN6OEU1L3RtTkRpTDJYSzNkRjRBQkNYRXBKMStIejdwRWFRSUF4SDUrbXZD?=
 =?utf-8?B?RkRLZTA1S0dSTzVtTzgrN2xxZ1BQY3lUaEl3RVNEbUFlUm5mTnY0aWNzT09H?=
 =?utf-8?B?OUtGb1laTFpyUTF5c3grd21XaS82K3kydllQM056ekpPTlJMdWlpbmJGblFZ?=
 =?utf-8?B?bVc5bDVoanJZcG5EU0J1cU10bEVBOThHWEZvQU00VXRiTVc2NEZnV21aaVVi?=
 =?utf-8?B?UDZrcVVadC91NlU1NEIvM2VSTG9ZWVR4WVRicTVxOXA0SFc0bzk5cFRRalVT?=
 =?utf-8?B?NExTYkh2Q3YyVWVpVFcrSDZPbW5DSVRsZWhZbFpJZm9UTnV6R1BrQ2tPeG5H?=
 =?utf-8?B?SGt4aEIyMUxoMEw2dWlPblR4Q0VCVEJ0ZldCWVdsdGRabkVJaDZxTTR5VG1L?=
 =?utf-8?B?SThIeitGNEVVZmszQUtiaE1lcC9uQSt5dHpBT2ZzUnRDNE1UaXlrRC9aQ3NF?=
 =?utf-8?B?dGJrQWxWb2grRmxxK2tmUXJvQ3hyMjc4UUNVeUpRa0I1RUFUUnVUSG9QNm0w?=
 =?utf-8?B?T1ZJU1hwTktLSFRmRXYzS1RtL2JOMnpjWUI3TmVhQnZncUc2WDVmTlhDT09D?=
 =?utf-8?B?ZXNDYUZlLzNMMmJjTy93Zk5wYmRHZFBGTndMa0owMGhpZ0YwYUFMZ1grK3pE?=
 =?utf-8?B?aEZQZXVFMmkyeDBsekN6WWhpc2dCTC9MS0xLMW5MMmZaYVJXTW1ZUCsxcjF6?=
 =?utf-8?B?ek9pUVkwQUhpUUN5Q0pmejhDOHgydm9GZDAxb2hGdFNpWkZBMDNpcHVBdVdN?=
 =?utf-8?B?MEtUUU05akNwdGZiUVRrYUh1WmkwdTVjNXlTRmx1S3pjakNydXl5ajZXZGZU?=
 =?utf-8?B?VGhlS25MT2JaWURoc1RJQW5IVEhZY3V2em81N0dZRDI4UWRxaDN4SXhQazRz?=
 =?utf-8?B?RktZeVQxUllpaGRoaTB6K0JLSlRBamJHTU5zaGYyQWRsZ1F4WEt3dnozeDVW?=
 =?utf-8?B?bWh6SStVbVFzWXpheVJLV0wxa1JBeldUL3JjVUZPMVhoMzFtMG1vVDhwMk5u?=
 =?utf-8?B?cml1ZWhhbEhMdnFHbUhBR0lNODBKamkxVGxSTFpheDdjWEpJWE5UdW5WVkxz?=
 =?utf-8?B?cGUwdm5mRyt4K1lnS2RjRkRzblh6ZExmYU51SWdMajR1aWFPMVU0dWtYM1Rl?=
 =?utf-8?B?a3FET2tDUjUxbjhUSnZjR2tFNElLc2FmczhJUTF5ZEJxSkIzbTRianViNEpC?=
 =?utf-8?B?d1FJOWx5Sm51TC8ydkJwK0VoTUpuNFZPODV5bHQzUmhtaWJvMEcrNzQvUzQr?=
 =?utf-8?B?N0hablVKVHF6aEowcWpHWDRkMlZEQ3lueURMVzRpdTgzY2FUVXpOSnFHMjRJ?=
 =?utf-8?Q?dUZ0rVYa1Y0XeGzuZth5/DmhI0ScX/jc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2963d4de-45b6-4ec5-d970-08da07a53e54
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 23:32:32.4655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6xJQ/bg3tXJBONAGkdpXRDRiD0k3gqMFEm4GKDcHO0tMoI7jblCqgZdRztj30Na3k3ZGKvWt7dSM7mlJYUQcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?


On 2022-03-02 15:20, Felix Kuehling wrote:
> Retry faults are not supported on GFX 10.3.4.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 7c2a9555b7cc..622eeda9ea45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -568,6 +568,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>   	case IP_VERSION(10, 3, 3):
>   	case IP_VERSION(9, 3, 0):
>   	case IP_VERSION(10, 3, 6):
> +	case IP_VERSION(10, 3, 4):
>   		/*
>   		 * noretry = 0 will cause kfd page fault tests fail
>   		 * for some ASICs, so set default to 1 for these ASICs.
