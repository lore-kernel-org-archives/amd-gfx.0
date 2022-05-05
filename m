Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127AFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 13:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9233310E21B;
	Thu,  5 May 2022 13:54:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 683B010E21B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 13:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx4JcEPpPBDRKHZ8l+l0NhRLjtmipbfYzpwEnO+v6SrfjFippbdKn/QhcmrJIz/nLXOrOsL4eOr78X38ldTUVYaHkRGufnDBQObzzwbP7vITv5wk2Ajg5mJZmxTC+kB92RZ8XZr4pYlQB2fz8qb/aZrvxiJDugUV0sU/iXoIUKsFydywHRjs4P7aJh61NFguno4/EbEIPgVTsyUfggeyc2T9NlMdkJaW/zM50AWbAWcg3KgT1+cXLTSKOs6dq/K0L86Prs0zdQkUqiIV/VdQ9WWBvs6ycKYABnzTS0qOZM/lisUOT88kKViMXceUGgL4MR13ty2KXyA6j5oO0O9iNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzfyEw0PhHiC3YyyKtG7o4h+2I3k/FRaRbne8sP0fEk=;
 b=A8ufFbaozDg4gr7yh7GI+0p6yS5wEcL83z2aJI2Bv31MoMIiVt/iLmfioHecur2jKSZFLQLTYM+uxoClAe3aLrl0DHHd+lXnKfNChpvQeF7T+tQjwFoydYuT8mdqIPe29NrYp+I8+jM7Q4xV6LAehA2hAOKOeIWdAnt/6zIDVvNLXogGFUCWAvi2qdNOalhSkN8/osKqFfEfxU47AEURDMfijv3EXhlafRoyFMl3rBGTe5YJkjSH45rf6rmCXZYEshKu1A1f5SlhIR0Ofo6jY/yvlVnCY402kZaW1kCGLrDZ7IpBMT6ZCpCArqTwV3XsO5THu6hZjzIggYapH3+4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzfyEw0PhHiC3YyyKtG7o4h+2I3k/FRaRbne8sP0fEk=;
 b=4AqieUWmUHrzIMYluxTTOYnVnVJu2G6ck3Ndcmz1LuW9IfVLJOrrHeNyAjqcc0mCHCU9s69fGIbiy2RhSyjxB2tgSVSd/yftRbZ6LO4wMt3YrSiyYvK93MiyBnpVDN+ZdNU/5Xs61zRJ15notDrEy5uPGRDnUcyOv+vpTCv48Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 13:54:28 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5206.026; Thu, 5 May 2022
 13:54:28 +0000
Message-ID: <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
Date: Thu, 5 May 2022 09:54:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
 <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
 <aec08997-9565-a596-f143-eccf92653a84@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <aec08997-9565-a596-f143-eccf92653a84@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::20) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9df3b6e-3db5-45fc-1790-08da2e9ec5c2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4101:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41011BA6737E7150A2F7C478EAC29@CH2PR12MB4101.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpmhMWgX9H3l0b+XbXJFsuofjaLW71kvNY7CEfWKVwvKzQ/ze+1o/PRvdSM15dEyuQtBwHBSU13ptxpz9JRDyPE4xFDhRkyn2+TTy93MPcIazy432Z1mnoUh5mTR3bQPBkoD+1F8mr3Esfxf8YC+yTYzH+mN6UMbDUjrKrWkvE3HlmPMqPjacCfFjJu3xbEiVDn3Wq3IdTTR/QZB6ytwLBxwJHlfC7TUvYGt23rAcxc5bdgUtrOWjR8/3LIywAAAS7EboFAihAoPmuWZwwGDxfhZyHoY4Fi398LT1S5JqglHRP5Xka1HY8ouMGWxf9NS8fD2n21hI7xSGkbzSghl91PIB37JVy71/E9AX/upErwDRW+buIuF/7H57+UYGdVSFjaVdEofKH7BxxIfROk39FvmDSzw5Z0xnpWzF4TxuhYZPSU6O7+MsbWiQxzndvNDqvIq4qnD7G2rjQglUhdAYHv+Np0ZZQ7zH7TljnFC4OVrk6RzOaKlwc2GNTZwEC7kbC2ASfiqXeYbgyfnNRM/26juDGSXzrRxR87DkM4+6WFRoYko9azVEoFdjyKjpjBgdTZwVyZEi3lJBYBfBisqGGj1Jet38SJ4UzeaCodikPxjojdlfItEL8cyLaBmyOX9YjyLXSuZ9tJBAYc8qnFG8Hny8Xi4FVcHzMG5FXS7GCw0T5DEtILhDa4Z50w6uj+KGK0b++gFoBgYnsUgj3DmdHx/wIK0Gp9a8oMMd6KElb/rnVBBWZSe1hQZv9U+lA/0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(38100700002)(6512007)(2906002)(53546011)(83380400001)(186003)(66574015)(8676002)(4326008)(2616005)(66556008)(5660300002)(66946007)(66476007)(6486002)(31686004)(36756003)(8936002)(508600001)(86362001)(31696002)(30864003)(44832011)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZBMzZGZ21rSGo5cjZialBSUWZWRVBha0FZWW95SHJ5QU1wcytDQml5THhm?=
 =?utf-8?B?d1lkOGViNkxqTUtkMXdtOXhMN0VuUkZYNi8vYmhYcDBocFVkK0RXbEZVV3lX?=
 =?utf-8?B?UUR2SjQ5RWhrN3lQcFgzcTRaM2srMGtLMzd6VHhJZUVYUlYyNEtYVExuZllR?=
 =?utf-8?B?RnNTWmRTVVE5N1lBSWZ5SzlsUENzQUtrenBOaHdtUmJ2TStDd1RXSkFoRGI1?=
 =?utf-8?B?ejMvMHBCRFFDL1RCZzFOaWFyTGdLNE12d25hNllxNzVYZFdpVjE0dE91Yjdk?=
 =?utf-8?B?TklWSGJMc0cxaVNBSEJFNFVqNjhzSE9ITEdhQ1BkOEJlZEVBZkdQZnRPQ01u?=
 =?utf-8?B?dnhydmQveENRaFdTeldTT2JJVUZaWElPblcyazl3dzF0VkFMOXEwVkM1ZFdK?=
 =?utf-8?B?REIwam9JOEY3c3ZOdWpGWDdYMVZGNEc5a3l4T0Z5aXQzQ1dpTW1qUTV4M1ZT?=
 =?utf-8?B?VE41RGZzTFhMV1dNNExqNGxwYndFMFJkaHBneGZzZFFGd1BlNkRlSTNmQWd1?=
 =?utf-8?B?TmV6enAxOHJZZlBiUEVlMDNPZFZ0UUI4M3dFUHJlMEs5d1d2YVcyQ0N2Z0tU?=
 =?utf-8?B?aWk0SHdwRGR6NXRFUU5lSTB3bm15RFRoUHI1RnNvWi85ak13Q2M5OGlDTWdi?=
 =?utf-8?B?cFVPYVFZS3ZZMkIvemozRmRCMXBZVCtvQTRPQlgvY1BBVEJ1bXFMajArRzVm?=
 =?utf-8?B?Y2VTUUJVYUUzN0FRUExrWklRQ3l2Nk9DclBJcU9wYkhJWDhmMEt4TndGbnht?=
 =?utf-8?B?Sjk0MzNDek5TVk1lZUI2amEwaFd6QVBFU0hWSXlTczZrOSsva0dObGZSTWw5?=
 =?utf-8?B?ZlFoNXplczFuc0lDM0w2TTk3aFZ1dUNzSHl6R3lsT1pFRmZBTnNEL2hSZGpC?=
 =?utf-8?B?SWdzR25sSzh3MVROeHBVc3hTOTgweWZYekN3VmU5MDZWVWhvSTBHeGQvbVA0?=
 =?utf-8?B?RnRCTTlNd1Y2NUZPay9nV3JKcmcrTTMzcnBSYTR0Z3NETjlkOWhkLzlCSkFq?=
 =?utf-8?B?TEJQU0pmQlNpMnY3T0VFQ0VJZElVd1VFV2VoTS9XN0F5eTFsR00yZEFacFBv?=
 =?utf-8?B?TDJ1LzZVSFBmcVBpZ2EzNUd5a25TUHJYSVR4VzlOc2gzRGdRTTVoTGJoQ3RS?=
 =?utf-8?B?K3ZZcXQzZ0lDdnUzMnlnd3lJenJrdnBncFVMMUlvczhDLytLRmgzOGxBV2g3?=
 =?utf-8?B?amM0WkM0eHB4TWNyd1RCYzExVzB0cVJyY3BRL1I0Q1EvQUFCN2E2ajJUZUFi?=
 =?utf-8?B?S2lIWWVnRTR2V0UwWHErdXFCdmV0NVFjc2V2S2l6R2RFejZPNExtRCtYUjJ1?=
 =?utf-8?B?OGlwZmJtQlE0WTFLdHNYYko2WU1LWGJob0gzK3dXdHUwR05UbGdyWjVqakJ3?=
 =?utf-8?B?eFhscytJQi9CZ1FZUWo2Y0RqK3NkZXdmRFJCNncvNUhmN2IzSkpmajFid1Y0?=
 =?utf-8?B?UFJWZWo4anBHS0p0ZDJIa2FJd0xMZ0tGdDlJRXU5bzZoMGpPS1dhajBYS3JB?=
 =?utf-8?B?L3hVMmVtbEJjQlNXeTZLTFNsL2dXZ1I3N0l2UC93SFRRbHBXR0V5Z3R1SGkr?=
 =?utf-8?B?bmJoclVWR2VKOFZCOTJQZmhLRzBYMEFweEJaUjlGS1djS2NmMngvQmIyUnho?=
 =?utf-8?B?Zjl6b3NPcjVQamZQL3ljaGY5STlkNmlQdnkzaVVsRkUvTVMreUMzTVY0R3B0?=
 =?utf-8?B?QzBsRFhXOXhKQlhxTnNXQUw1TzgwWUlScmdabEZySG5uQnRMU3h6Zy9hMnFn?=
 =?utf-8?B?QzF6bGU0aVhoYW1MRkkvTDNyT3FVMGZ2K1BFbUY3TFg2eG1oMnF2Qmw4ajNM?=
 =?utf-8?B?NjZGdEdFTWlPUUtqRWpSVXc4Z1ZjOWRKd21tLzgwUkRYY1NIWFdXbktFS3ps?=
 =?utf-8?B?MVMrSHRzc05WeWg1bGZwV0xERXQrdkppbkFSVlJiV3poa1k2bUMrbndaNEdx?=
 =?utf-8?B?eEYxR2tKU2s0ZE5NY0Jmbm1mNkRValRwWTBRZnR3UnoyK2Y1cVVBdHVCRnlU?=
 =?utf-8?B?ZHhremhET1lhVWZaa2tRd25TR2ZNc051UTQ0Z0JHam9MMTVtdy8rcysrWU5I?=
 =?utf-8?B?QzZuc2dRQXlBUlc0emp2NStBcDhDUnpqTUtyVFhWT0JBbGZoKzh3SjdDVHhm?=
 =?utf-8?B?UHZubGJkdm1Ndis0TlhUVUhFVDM1RUFTWndLcnhha29heC9aMHAzc0NKVHBV?=
 =?utf-8?B?MEhxK2N0c3hpMjNaNFNNcnhKVCthbzVob0s2UENuSnQ0blo3WlUvVWQvT1U4?=
 =?utf-8?B?Tmh3aHRxYng1enplc2pzTW5sNVJDL2F4NlZhSzFoYUlZL1hCZjNXWFY2WVdL?=
 =?utf-8?B?U0liL3RmVjhaYmN5eVY5Y21lREFiSzBlMVNvazNlcmdKOG11K0Rld1U4cmVU?=
 =?utf-8?Q?DolcZpL00I+gbot/EK4ey6QXeeASeyHEYihNCJbZUPO5U?=
X-MS-Exchange-AntiSpam-MessageData-1: FQ3Lvsoi2ao3oQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9df3b6e-3db5-45fc-1790-08da2e9ec5c2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 13:54:28.5763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uL+PM1icBt/AwBQeLs7vio4PUvCbOoQG1RUZku2uNYU6CvUBBAfPckOI6kZ1HZEmbgCoZyT1TJXyoEdvFXeb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
Cc: Bai Zoy <Zoy.Bai@amd.com>, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-05-05 09:23, Christian König wrote:
> Am 05.05.22 um 15:15 schrieb Andrey Grodzovsky:
>> On 2022-05-05 06:09, Christian König wrote:
>>
>>> Am 04.05.22 um 18:18 schrieb Andrey Grodzovsky:
>>>> Problem:
>>>> During hive reset caused by command timing out on a ring
>>>> extra resets are generated by triggered by KFD which is
>>>> unable to accesses registers on the resetting ASIC.
>>>>
>>>> Fix: Rework GPU reset to use a list of pending reset jobs
>>>> such that the first reset jobs that actaully resets the entire
>>>> reset domain will cancel all those pending redundant resets.
>>>>
>>>> This is in line with what we already do for redundant TDRs
>>>> in scheduler code.
>>>
>>> Mhm, why exactly do you need the extra linked list then?
>>>
>>> Let's talk about that on our call today.
>>
>>
>> Going to miss it as you know, and also this is the place to discuss 
>> technical questions anyway so -
>
> Good point.
>
>> It's needed because those other resets are not time out handlers that 
>> are governed by the scheduler
>> but rather external resets that are triggered by such clients as KFD, 
>> RAS and sysfs. Scheduler has no
>> knowledge of them (and should not have) but they are serialized into 
>> same wq as the TO handlers
>> from the scheduler. It just happens that TO triggered reset causes in 
>> turn another reset (from KFD in
>> this case) and we want to prevent this second reset from taking place 
>> just as we want to avoid multiple
>> TO resets to take place in scheduler code.
>
> Yeah, but why do you need multiple workers?
>
> You have a single worker for the GPU reset not triggered by the 
> scheduler in you adev and cancel that at the end of the reset procedure.
>
> If anybody things it needs to trigger another reset while in reset 
> (which is actually a small design bug separately) the reset will just 
> be canceled in the same way we cancel the scheduler resets.
>
> Christian.


Had this in mind at first but then I realized that each client (RAS, KFD 
and sysfs) will want to fill his own data for the work (see 
amdgpu_device_gpu_recover) - for XGMI hive each will want to set his own 
adev (which is fine if you set a work per adev as you suggest) but also 
each client might want (they all put NULL there but in theory in the 
future) also set his own bad job value and here you might have a collision.
Also in general seems to me it's cleaner approach where this logic (the 
work items) are held and handled in reset_domain and are not split in 
each adev or any other entity. We might want in the future to even move 
the scheduler handling into reset domain since reset domain is supposed 
to be a generic things and not only or AMD.

Andrey


>
>>
>> Andrey
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  3 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 
>>>> +++++++++++++++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +-
>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  7 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  7 ++-
>>>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 4264abc5604d..99efd8317547 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -109,6 +109,7 @@
>>>>   #include "amdgpu_fdinfo.h"
>>>>   #include "amdgpu_mca.h"
>>>>   #include "amdgpu_ras.h"
>>>> +#include "amdgpu_reset.h"
>>>>     #define MAX_GPU_INSTANCE        16
>>>>   @@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
>>>>       bool grbm_indexed;
>>>>   };
>>>>   -enum amd_reset_method {
>>>> -    AMD_RESET_METHOD_NONE = -1,
>>>> -    AMD_RESET_METHOD_LEGACY = 0,
>>>> -    AMD_RESET_METHOD_MODE0,
>>>> -    AMD_RESET_METHOD_MODE1,
>>>> -    AMD_RESET_METHOD_MODE2,
>>>> -    AMD_RESET_METHOD_BACO,
>>>> -    AMD_RESET_METHOD_PCI,
>>>> -};
>>>> -
>>>>   struct amdgpu_video_codec_info {
>>>>       u32 codec_type;
>>>>       u32 max_width;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index e582f1044c0f..7fa82269c30f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -5201,6 +5201,12 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>> amdgpu_device *adev,
>>>>       }
>>>>         tmp_vram_lost_counter = 
>>>> atomic_read(&((adev)->vram_lost_counter));
>>>> +
>>>> +    /* Drop all pending resets since we will reset now anyway */
>>>> +    tmp_adev = list_first_entry(device_list_handle, struct 
>>>> amdgpu_device,
>>>> +                        reset_list);
>>>> +    amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>> +
>>>>       /* Actual ASIC resets if needed.*/
>>>>       /* Host driver will handle XGMI hive reset for SRIOV */
>>>>       if (amdgpu_sriov_vf(adev)) {
>>>> @@ -5296,7 +5302,7 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>> amdgpu_device *adev,
>>>>   }
>>>>     struct amdgpu_recover_work_struct {
>>>> -    struct work_struct base;
>>>> +    struct amdgpu_reset_work_struct base;
>>>>       struct amdgpu_device *adev;
>>>>       struct amdgpu_job *job;
>>>>       int ret;
>>>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>>>     static void amdgpu_device_queue_gpu_recover_work(struct 
>>>> work_struct *work)
>>>>   {
>>>> -    struct amdgpu_recover_work_struct *recover_work = 
>>>> container_of(work, struct amdgpu_recover_work_struct, base);
>>>> +    struct amdgpu_recover_work_struct *recover_work = 
>>>> container_of(work, struct amdgpu_recover_work_struct, base.base.work);
>>>>         recover_work->ret = 
>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>>>>   }
>>>> @@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct 
>>>> amdgpu_device *adev,
>>>>   {
>>>>       struct amdgpu_recover_work_struct work = {.adev = adev, .job 
>>>> = job};
>>>>   -    INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
>>>> +    INIT_DELAYED_WORK(&work.base.base, 
>>>> amdgpu_device_queue_gpu_recover_work);
>>>> +    INIT_LIST_HEAD(&work.base.node);
>>>>         if (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>> &work.base))
>>>>           return -EAGAIN;
>>>>   -    flush_work(&work.base);
>>>> +    flush_delayed_work(&work.base.base);
>>>> +
>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>> &work.base);
>>>>         return work.ret;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>> index c80af0889773..ffddd419c351 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>       init_rwsem(&reset_domain->sem);
>>>>   +    INIT_LIST_HEAD(&reset_domain->pending_works);
>>>> +    mutex_init(&reset_domain->reset_lock);
>>>> +
>>>>       return reset_domain;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>> @@ -24,7 +24,18 @@
>>>>   #ifndef __AMDGPU_RESET_H__
>>>>   #define __AMDGPU_RESET_H__
>>>>   -#include "amdgpu.h"
>>>> +
>>>> +#include <linux/atomic.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/list.h>
>>>> +#include <linux/kref.h>
>>>> +#include <linux/rwsem.h>
>>>> +#include <linux/workqueue.h>
>>>> +
>>>> +struct amdgpu_device;
>>>> +struct amdgpu_job;
>>>> +struct amdgpu_hive_info;
>>>> +
>>>>     enum AMDGPU_RESET_FLAGS {
>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>       AMDGPU_SKIP_HW_RESET = 1,
>>>>   };
>>>>   +
>>>> +enum amd_reset_method {
>>>> +    AMD_RESET_METHOD_NONE = -1,
>>>> +    AMD_RESET_METHOD_LEGACY = 0,
>>>> +    AMD_RESET_METHOD_MODE0,
>>>> +    AMD_RESET_METHOD_MODE1,
>>>> +    AMD_RESET_METHOD_MODE2,
>>>> +    AMD_RESET_METHOD_BACO,
>>>> +    AMD_RESET_METHOD_PCI,
>>>> +};
>>>> +
>>>>   struct amdgpu_reset_context {
>>>>       enum amd_reset_method method;
>>>>       struct amdgpu_device *reset_req_dev;
>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>       unsigned long flags;
>>>>   };
>>>>   +struct amdgpu_reset_control;
>>>> +
>>>>   struct amdgpu_reset_handler {
>>>>       enum amd_reset_method reset_method;
>>>>       struct list_head handler_list;
>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>       XGMI_HIVE
>>>>   };
>>>>   +
>>>> +struct amdgpu_reset_work_struct {
>>>> +    struct delayed_work base;
>>>> +    struct list_head node;
>>>> +};
>>>> +
>>>>   struct amdgpu_reset_domain {
>>>>       struct kref refcount;
>>>>       struct workqueue_struct *wq;
>>>>       enum amdgpu_reset_domain_type type;
>>>>       struct rw_semaphore sem;
>>>>       atomic_t in_gpu_reset;
>>>> +
>>>> +    struct list_head pending_works;
>>>> +    struct mutex reset_lock;
>>>>   };
>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>>>>   }
>>>>     static inline bool amdgpu_reset_domain_schedule(struct 
>>>> amdgpu_reset_domain *domain,
>>>> -                        struct work_struct *work)
>>>> +                        struct amdgpu_reset_work_struct *work)
>>>>   {
>>>> -    return queue_work(domain->wq, work);
>>>> +    mutex_lock(&domain->reset_lock);
>>>> +
>>>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>>>> +        mutex_unlock(&domain->reset_lock);
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    list_add_tail(&work->node, &domain->pending_works);
>>>> +    mutex_unlock(&domain->reset_lock);
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static inline void amdgpu_reset_domain_del_pendning_work(struct 
>>>> amdgpu_reset_domain *domain,
>>>> +                  struct amdgpu_reset_work_struct *work)
>>>> +{
>>>> +    mutex_lock(&domain->reset_lock);
>>>> +    list_del_init(&work->node);
>>>> +    mutex_unlock(&domain->reset_lock);
>>>> +}
>>>> +
>>>> +static inline void amdgpu_reset_pending_list(struct 
>>>> amdgpu_reset_domain *domain)
>>>> +{
>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>> +
>>>> +    mutex_lock(&domain->reset_lock);
>>>> +    list_for_each_entry_safe(entry, tmp, &domain->pending_works, 
>>>> node) {
>>>> +
>>>> +        list_del_init(&entry->node);
>>>> +
>>>> +        /* Stop any other related pending resets */
>>>> +        cancel_delayed_work(&entry->base);
>>>> +    }
>>>> +
>>>> +    mutex_unlock(&domain->reset_lock);
>>>>   }
>>>>     void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain 
>>>> *reset_domain);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>> index 239f232f9c02..574e870d3064 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>> @@ -25,6 +25,7 @@
>>>>   #define AMDGPU_VIRT_H
>>>>     #include "amdgv_sriovmsg.h"
>>>> +#include "amdgpu_reset.h"
>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is 
>>>> sr-iov ready */
>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
>>>> enabled on this GPU */
>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>       uint32_t            reg_val_offs;
>>>>       struct amdgpu_irq_src        ack_irq;
>>>>       struct amdgpu_irq_src        rcv_irq;
>>>> -    struct work_struct        flr_work;
>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>       struct amdgpu_mm_table        mm_table;
>>>>       const struct amdgpu_virt_ops    *ops;
>>>>       struct amdgpu_vf_error_buffer    vf_errors;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> index b81acf59870c..f3d1c2be9292 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> @@ -251,7 +251,7 @@ static int xgpu_ai_set_mailbox_ack_irq(struct 
>>>> amdgpu_device *adev,
>>>>     static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>>>>   {
>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>> amdgpu_virt, flr_work);
>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>> amdgpu_virt, flr_work.base.work);
>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>> amdgpu_device, virt);
>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>>>> amdgpu_device *adev)
>>>>           return r;
>>>>       }
>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>> xgpu_ai_mailbox_flr_work);
>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>         return 0;
>>>>   }
>>>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct 
>>>> amdgpu_device *adev)
>>>>   {
>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>> +
>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>> &adev->virt.flr_work);
>>>>   }
>>>>     static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>> @@ -275,7 +275,7 @@ static int xgpu_nv_set_mailbox_ack_irq(struct 
>>>> amdgpu_device *adev,
>>>>     static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>>>>   {
>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>> amdgpu_virt, flr_work);
>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>> amdgpu_virt, flr_work.base.work);
>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>> amdgpu_device, virt);
>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>>>> amdgpu_device *adev)
>>>>           return r;
>>>>       }
>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>> xgpu_nv_mailbox_flr_work);
>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>         return 0;
>>>>   }
>>>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct 
>>>> amdgpu_device *adev)
>>>>   {
>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>> +
>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>> &adev->virt.flr_work);
>>>>   }
>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>> @@ -512,7 +512,7 @@ static int xgpu_vi_set_mailbox_ack_irq(struct 
>>>> amdgpu_device *adev,
>>>>     static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>>>>   {
>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>> amdgpu_virt, flr_work);
>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>> amdgpu_virt, flr_work.base.work);
>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>> amdgpu_device, virt);
>>>>         /* wait until RCV_MSG become 3 */
>>>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct 
>>>> amdgpu_device *adev)
>>>>           return r;
>>>>       }
>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>> xgpu_vi_mailbox_flr_work);
>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>         return 0;
>>>>   }
>>>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct 
>>>> amdgpu_device *adev)
>>>>   {
>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>> +
>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>> &adev->virt.flr_work);
>>>>   }
>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>>>
>
