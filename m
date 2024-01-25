Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D11C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 18:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACA910E71A;
	Thu, 25 Jan 2024 18:49:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4A010E71A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 18:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLRFPK/AdQ8hUY7dA22lP9nduTunprvgiJ7Peb+/kNZIO5ABST4sQTSPiK4BanlyRidUqg6N73JQc1vFv4Txn2ZUt2seHI8FJGOaX/fiTQvTvgF6kf5lDcs4P4OxjkYGJrYHg2ORCN4Jx+/yrfydLI3/0oGu53WDlKkWL7YNCvxbNgMjDgWja2SwHh6+nmJMz/p9zVym97U3mQkVFy8zBRG0kk2tT4vqCEyt3Js5/GgFhx9W1v7e6aFon5nhnV/bsKIvW28ifYDdU6jtapSuyrKmEHrToswBdS49WgHGgesqcBDJGbZaYZkhxGKyfADslmNkP01a0V0sJYwiDfwrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+NbRcxWWlWye2Jntjw/5RUDM3UitJELIKcJBa8Z5Us=;
 b=j1EainSIoa4k97VHpodvLOFE9cl56URDYejEdFaB4AfZbq/KEiFYChA7ZVsuFzlj7I6W0MbSFLeNMa6h5SsAQRgT7eZyV6DOwWOoXLKBsQAEtvs6oM8WhSCcPgNXN+DNcKlF44rh/Z2zvgFVaGZezR7wEm8c5G2RbD49r/pSbVEvmbMtBAk9aNwmTr5mx1ETbuzop5m6xjg4l7nKwKHImseJ9PwVbtDX7x+opTiwaKtGPdvQkC1SaEKFa8+XFwcKYVyzoRGPw9qeNHpGkn/Ni3yxBQ3rUsZyvitw/l3yj9tZNHXmnKXsJk7SnmjLf/HYgB5V6pOw5lBpzUPDqH9uoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+NbRcxWWlWye2Jntjw/5RUDM3UitJELIKcJBa8Z5Us=;
 b=PSjttQ74rQARajtDSN5RpWFxG4vSj9wLV0By+/WqXOr7mJfD685ic1W8WLA23MZjyfpTCYSmaJbbR18Esp26vxppzFyrQ1q6UO7A3omfi9NVip5bbcsav1c/9snLTRrLsYuAmOvpnuT0wQVAt82/iLwhqNYtMqDXHC1PyGScV+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 18:49:51 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::36bb:f12:cd0b:9e8e]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::36bb:f12:cd0b:9e8e%4]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 18:49:50 +0000
Message-ID: <d122b1ed-cdaa-4a5b-950f-2c748c401635@amd.com>
Date: Thu, 25 Jan 2024 11:49:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Expand and improve AMDGPU documentation
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
 <45f7662f-8fb3-4605-abd0-0600a160fc62@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <45f7662f-8fb3-4605-abd0-0600a160fc62@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:408:e5::34) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: baa34d6f-d379-44a2-e319-08dc1dd66954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qaTKQU4WgRt1zv6gDD0P6E1hCDgZs5jav5jabburUn21pkC3Wz6ncgXuSl7N8qNBoe2lQnTwUBxzggOIQ+JoYOrMxoDd+kHfMowS90j3WQ2k4/pfMaxdWRRzFvt1EVCK6bU6rmr4eG4p7A/7MFTALo6njr0TN2cYLEpUTNdOw06m9E0Vz/CaBgGJnC6kwLMEIpQI0vJOXDpyIcElK6L8/3OdbH7hYe3u/JPPafaJ4c+ZcUc2oBuXdw+um10KoPtLXCNQsOnoBRHTzrMZwLs33w+LtMxRBchVgqETyTZktwL/zm7flF5vAM/0ZMXN/Pecem43FXeJT1TkCacktKnlu1c/TzzapfAMw5TlPBO0YR+OD4vtW8Wtsj6xKCyFncx0NKYAANWglblSXeQY0Za6vP9Tr5NIQZXTEpHubQomW9g4GpsvkwYi2XmTOMAvJnnt/4j75Eagq480kw6YYRIxDPf61PnbKBgANH09RGnngz7JMw6TBQ9YIQUa9Fkq1Ld6m2FU6ZvBzPXErJc9LaGgtjRcHJeflXR8UrP8VDwZIIIXjGEaYpVyN5uBWcbv4761hGdJe2T4/PfynTLdX6JXXqWMJmY2rDPE8DZH4NEXQlWCoVxHdXPMdWzBX/21qx4Gm4Oonx3bcxSE6HuuE0TEPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(36756003)(31686004)(6666004)(316002)(66476007)(66946007)(6486002)(6506007)(66556008)(110136005)(5660300002)(53546011)(41300700001)(83380400001)(2906002)(8676002)(4326008)(478600001)(2616005)(31696002)(8936002)(6512007)(26005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9jRk5ZSmFJc210a3hJcFVZeUdUL05BMUlnUkF3NDF4TjY2QnUzcHdCR1hO?=
 =?utf-8?B?UlBjZ1ZveW9GR2VRL3dUayt0QzBwUERIKy9Wd1U4bjNnTnYwVDZBZWlsTHJs?=
 =?utf-8?B?dzZvMU5NYnBEQ0R5Z29EMVNkVU8yNTdQaUFqL0hVTVgyZXNSWXo5b1I0MFl4?=
 =?utf-8?B?U2ZncVdGYTBkcndiUzlFRHlndmpiSUgrbE0wVEFLb0pDQ3oxMnJqbG4xYVdO?=
 =?utf-8?B?MTAreW5tNmtGZ1F6YytkSURCbzZZdkt6c0VuQmI3T2N3YlJxamZMMk9GYXdO?=
 =?utf-8?B?V25XbWwrUUtYcG05RGdPdVdxVmdnV1NSbmMyanRsZnNYZXJheDBDMTFDeXBK?=
 =?utf-8?B?d1YzRExYalkrU0JyU3ZkbmVxT3VvcG5Fbm9XR0RvcmJRdGxqY0s4cnpyN2pT?=
 =?utf-8?B?aE9XaGRjSGJVSHl5L3ZOZytzS1JRTG0wRWZTRWloS2U0TGZZVmUwNnpHQnkz?=
 =?utf-8?B?QmJsQ1pzMjdZSFFoNjJVRzJmVjFia3RvYjM3MW5lbDdOYmRLVmw4Y3cxNVFO?=
 =?utf-8?B?WWQ3bHAyR0c0R0RmamVNZG13TEczdkFuNDlUeGdWYTl5eEJYd3N3Umd2MUsx?=
 =?utf-8?B?UDhBWmJSeFBRTzVzbEw0Z2gzUHVWYTUwVEZObExlVTlMaHBvRVh6V3I1S1RN?=
 =?utf-8?B?c0EwUWIvOHNyaWdjSHRoL2pWd3NPSnFGV05TOUxMVDFqR3MyUGVhQThoQ2d3?=
 =?utf-8?B?WkRWSnRJcUdvM3hmeVFwcDI5RWtPdndzNGhKWm9rY2k0L3hVMVIxcVpzdDNW?=
 =?utf-8?B?Q1hzZjdiYUNtb0tIVmFJQkxLWVhucXoybkhLVlhpUmJodk9TZmU0eGZ0Q0Rj?=
 =?utf-8?B?VHJsMjYzR2dLcnpjZmZaZndtNmZOTzlZSDNzNURVMitmRkJSTWsvSnBsaCt5?=
 =?utf-8?B?NWppNzc5bkRVOU00M0xiY3BLREQ3bU5FRkkySWZDb29wNkwzRE5XS2t6YkZ3?=
 =?utf-8?B?eEJ1N3VzbFl0OS9sZDNyMVhEVEFHZ1oxRkZrQlRlZmttSXlzeXdqdjdRRnVz?=
 =?utf-8?B?LzF6VmlyL3dDbm1sTE5naVdYZVRFRVk5dUdJMXBFWXJTUHpwSVEyUEpHSHE0?=
 =?utf-8?B?KysrdUp6SDBCNlVUVjlxQTd3S0FUSnVFZmJLeUFhUVM1dlNiUGFxeTNwcExD?=
 =?utf-8?B?SC9uUFQyUTNIRmR4NEJkMDBJZnlwbUZDNmNlN0twSi9HQ0k1NFlLN2pCOUxI?=
 =?utf-8?B?UVpjSWw3c2pWbWlVbHdPaURhZ1BHM0pFdkdZRGJoZ1RkWTU0WVNicGhuQm0z?=
 =?utf-8?B?QUhqbDg5THJNUDYrODZSTjd2d0hjb21KVnl5MHU1azFyZ1JVRG9zeW0xRXNN?=
 =?utf-8?B?bVA0MFFTWGZnVGI0QTFUejUyaFNqdnRIWUQ5Zlc1ZEdaRGplaTQwMDY0bk9C?=
 =?utf-8?B?VjFEWjJ0Mkd5bmlVWXloaUgrNUFGbGJ6QXcwa2w1aGZkbzE3UUZPN2JqUnpQ?=
 =?utf-8?B?Y0F1K2FTcUFuMldrQTVXTjAvaWNETGR0S2xwVytrNEhQZWRCQWExZFRKaUl5?=
 =?utf-8?B?VFVCSytCUnAvT0RrSUxJN2IzZldnOWgxcGxZREJSdkJpVmRtVWQ5TGlWUnlU?=
 =?utf-8?B?Wk9JWlloTEhNeEw4V054aUJ3bjRhYis2VXhmcWVJa0pKSlFZU0p4MjB6ZUtl?=
 =?utf-8?B?L3phY1R2TWI1MjdBMm01eFFGS0M3anJZTGUxTU9aa3luNktnZEVSeEU5Vldi?=
 =?utf-8?B?ZkRqQ25rdzZIeFRPb3U4eVUyNGZmalEyc3lGVFNKc3E5ZGlRQk5RN2VnQmRJ?=
 =?utf-8?B?WGpTT2k4V0VrYUQ3emlNenRxSzFscmRKMGNubDhrTHF0ak4zaXN3NzZDL3Qz?=
 =?utf-8?B?aVNZR3FrSWx5bzNXNGNCaWRUT25aOXRzbk9TajNJZ1haaDNCdVRqQzZpcDE4?=
 =?utf-8?B?Z1htV0VqM0F3TURDaWtJY1ZzdDBIMVpsSFFOOGQ1SkJuNmNGZmZmZGxVN0lJ?=
 =?utf-8?B?dG5HMzB6Zkc3VEdCZERjS3hBeDRscmJGOU9LSWFwdTFlKzJqdFVEaFFibXU1?=
 =?utf-8?B?K2drVTA0NHhvQzlNZHJUZXZydjBCQWRPYlJFREEvMG95VDRneDZkb3REcVAy?=
 =?utf-8?B?cHBlQ1NKSU5JbzZOUkhBN2JBK1h3bTUxTVNGaThMdjgwY1pLd05UY1FOajJ5?=
 =?utf-8?Q?Q59OJy/rov93bN8vEV3Nt3msM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa34d6f-d379-44a2-e319-08dc1dd66954
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 18:49:50.8685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSoUzUXg5x6AiLwZXfMoZ8BATgDV0bZx3FNe/q10JuveLq0DVmkIZm0XQ1Fl4pWXuj57sH6jIUF2OVXZ4pHsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/23/24 09:19, Hamza Mahfooz wrote:
> On 1/22/24 16:24, Rodrigo Siqueira wrote:
>> This patchset improves how the AMDGPU display documentation is
>> organized, expands the kernel-doc to extract information from the
>> source, and adds more context about DC workflow. Finally, at the end of
>> this series, we also introduce a contribution section for those
>> interested in contributing to the display code.
>>
>> Changes since V1:
>> - Remove unprecise information about the DC process.
>> - Expand the contribution list.
>> - Rebase.
>>
>> Thanks
>> Siqueira
> 
> Series is:
> Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> 
>>
>> Rodrigo Siqueira (8):
>>    Documentation/gpu: Add basic page for HUBP
>>    Documentation/gpu: Add simple doc page for DCHUBBUB
>>    Documentation/gpu: Add kernel doc entry for DPP
>>    Documentation/gpu: Add kernel doc entry for MPC
>>    Documentation/gpu: Add entry for OPP in the kernel doc
>>    Documentation/gpu: Add entry for the DIO component
>>    Documentation/gpu: Add an explanation about the DC weekly patches
>>    Documentation/gpu: Introduce a simple contribution list for display
>>      code
>>
>>   .../gpu/amdgpu/display/dcn-blocks.rst         |  78 ++++++
>>   .../amdgpu/display/display-contributing.rst   | 168 ++++++++++++
>>   .../gpu/amdgpu/display/display-manager.rst    |   3 -
>>   Documentation/gpu/amdgpu/display/index.rst    |  78 +++++-
>>   drivers/gpu/drm/amd/display/TODO              | 110 --------
>>   .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   6 +
>>   drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  26 ++
>>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  13 +-
>>   drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 250 ++++++++++++------
>>   drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  16 ++
>>   .../amd/display/dc/link/hwss/link_hwss_dio.h  |  10 +
>>   11 files changed, 560 insertions(+), 198 deletions(-)
>>   create mode 100644 Documentation/gpu/amdgpu/display/dcn-blocks.rst
>>   create mode 100644 
>> Documentation/gpu/amdgpu/display/display-contributing.rst
>>   delete mode 100644 drivers/gpu/drm/amd/display/TODO
>>

Thanks!

Change pushed to amd-staging-drm-next.

