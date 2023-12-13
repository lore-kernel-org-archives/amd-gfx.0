Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AC4C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 16:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED3110E7E1;
	Wed, 13 Dec 2023 16:55:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD0710E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 16:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzNo4ZVA0jgsNKu70zRnVm2R7ZZ1J1VuHrvIFPgUaWshOqtH7lwXFeUM5XyXwnYi9rAXBX9YF741LN01zBa1gaxpPJEm27273yk4NL5W9UK057FihsrsoljUSi8nlllcChPc0k7GXkLc4/kI9RvP0Q4T5biN08lrC0qtNus6oiEBg/TOW8wsElojeT7AlGgopVwgZzJmSz/DqxLGkeIqCSFOGd6dgjmduKKMSrYaRSlZ/TwO+PmRx5lmiqHgY2jJSvvrSW2ilbjm/thybsRaV6HpqA7reUlBn2ujCciCqA1Q308Tj8OvbXro7dIwF5TEEaIaomoWZNeIm8YCTYYzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzTZZ+SlLDdktJaJyWeEAIDMcIiCKluD87cjJgHR7/k=;
 b=oZa1+t3rVM2leGyE6oHfpbQBW9r7KovuOGTC46gPmqiswzj2WZulEUDG48ccftzMxNa+d+bVayAPas2yogKIRkubNKZR7V3ya/yYf7X8+eCBnWnK8qtxPY6ZQ3aKNmYetfRLCnA9yziqad+hojZ9M8J4oqzr3MJhbBSpsCqSFM+HyLFSPaMYeDfDOW+x6MjpF8FLxFjjNuLXf+Mie1kRXPe1ER0cU8sp7yncs1hr+LeAsjl5w0SXpetjDbdyaheT+GPEemfmAEbqyfn9YONLmingxf5zn3x2rkF2VluraJInQFm1awxRLuaQal6Zbmdz4FLZroop4l0kA4ddUja8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzTZZ+SlLDdktJaJyWeEAIDMcIiCKluD87cjJgHR7/k=;
 b=YZ7P6fPey4dcODqN3y7g6xMsqie629hTuW8sgUrGOOzOHFTpQFm+8VDVZCrXZxO0ziHGfv9NDhMfGki1agWNdtdhmSAeUywdY0Yf9+adyZwTg4yS7lDeLbWnAbaA1l8iaokxsQzpde2GjfO5mT2xuywLogcQFpghsb1RFq1zzoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:55:18 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 16:55:18 +0000
Message-ID: <39e4f758-bee7-4514-982b-01745c05e920@amd.com>
Date: Wed, 13 Dec 2023 11:55:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: increase hmm range get pages timeout
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231208230105.733781-1-James.Zhu@amd.com>
 <bc0fee8f-9e10-406a-a001-d4bd37c42c43@amd.com>
 <f4490496-3f63-4251-abcb-4761d9124c53@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <f4490496-3f63-4251-abcb-4761d9124c53@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::22) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: deb3848b-852e-4246-7246-08dbfbfc4900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vle3uZsqgHUn6XKz1ipzFw2/D+0mlMDpLior/xiAv4mEEDLxcE3pqH+Cw92LsEGY1FJ/nEAJ9gBzv8A7c2RuInyD8TEmWQ8AogNL9wIi7CH5nKXOCuI5nvYACrluFnxOMC82WOoVSZg7ygC4MLIK90G5E1ElyUMDa9MyGBhPxK18k1eLIvu6s4XlOathMk6BO/NTqKPD1qdoWung0WBpz29TRORr9GU7//shNxrG42Z4jQj4TWGQ6rCpTQ2XPasKO9/UySIuXNogE0fgAIARTug+j0KapAvzWJhfyJdLJZUGkZeT32uw23yxDjihXLzTVx/BzNL33QYjwtjvZXFTSalkYIPlx/sb9TurhC13TOzR9BT/7c6d01ipRey0KHv2yEwIQaS7pEYpRarne6zaAbceNfNragFFzMBl6kUHKxluYgvLY1zebZxncqpWg+oH4Y9efpMnteBLGVi2+r182VRFNG4XVRfSkL/CZj7Lx7ikTHJQPhL216O926ELw7MPYnRWyfv/S0JAhRZsCShfq+Ivn/mOT6d8zD/6ssVxPLkdZMcKjLjsIHBm3qjvQR6Ucr5dboqaA4fvz5TODbkQqT5Fy0MXFG1DAr1tan7eJAYfYkTTyk2MvhLkg1+VlZp3pGr7PYnuX2Szb2h0LPRijw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(6666004)(36916002)(478600001)(6486002)(6512007)(2616005)(6506007)(53546011)(4326008)(41300700001)(8936002)(8676002)(38100700002)(5660300002)(31686004)(36756003)(2906002)(66476007)(4001150100001)(66556008)(31696002)(66946007)(316002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZocXZiSnNCcmlMc0JNaVplenJDWkhFc3RBMnluVWtRWU43RVBXeThBUmRi?=
 =?utf-8?B?UXR2TTA2RXlTUUQ2dzB6dnRqT212dkJ0K1V0R29ZbEFjODNoN0NkTFJjWDFF?=
 =?utf-8?B?MEtGSTcxcE5hREtCLzZ2VU8xRU8xeHBhb0IxM2hrT3FPNjhNd0ZKbHFnbEx6?=
 =?utf-8?B?OWhZUmhHZklUSzB4eng2RUNSZVNzVm8xSVY1M3l3aVVBT2VsVjFlaU9iMFV6?=
 =?utf-8?B?UGNkbVBjb1VIbWd3YU1Mdlp1RTkxK1ozS2VGK25YTjMzVHdKN1k3SE5lQVNI?=
 =?utf-8?B?SjdKdDlmWWt1bHJTVVBhYStnTSs1QjVUQzBJbTI5WmdMSDZ5eURNWE02QWcy?=
 =?utf-8?B?a1FHQUswN2pUWUUvaC8rcWNJMWtTZklGaDEzd3Q3L2l1alFERjNLaksvS1Nu?=
 =?utf-8?B?WFBXR3Jac0s1OW81NS92VTdBU3dzVjNLNmp3YVNET0NBaWQ0U0ZjeXV1d09m?=
 =?utf-8?B?NXpCSkVQaWw4RmlIaU40UC9zcEJmQ3UvWlh1aVFIdHNHUVhyckJOWE92Z3Jh?=
 =?utf-8?B?eDRtNmhiUE00ZWMzeFRzZExJZ0JTN2ZRcXpIYjdEWXRvcDNyRkxta20vWlJw?=
 =?utf-8?B?RTR3S2hYdDRLQ3lyTjlpbWw5dkZLWlBNMk9KSmpkSnRkSEphcTNaN1ppUEJl?=
 =?utf-8?B?b0VCem1XNDRKY05TeEpLdFB1Mk5MYUM3Wkt5UE5jTU9aUnlQTXk3S3Qyankw?=
 =?utf-8?B?SUVsZWVlR09XWFE4Zjk0dzRjN2dEbWdhMEhDRjhsdjRndFBCVldvTXJzM1pG?=
 =?utf-8?B?dVRCSHZzaHk1R2kzbXpBZEFDVS9rQ1dsYXFxQWhPN0pCSEo3Tm9YVXcwMHV1?=
 =?utf-8?B?TWpDM05xNjZjd2xxZEM2VjZPclg5U1NnM2ViU1FzczE4QTIxQ0pDNjlYK3pW?=
 =?utf-8?B?WDNtT2xhQmxpQXZLcWQ4bVV3RkloSHhuMFBHQTlwSUNjaXZ6K0x6SThlNzVU?=
 =?utf-8?B?WE15Rmh5YUlsdlZMQW1MQm4xb29PVU4vUWVWZjhGZlg4aHJJV3JYNUQvNE5H?=
 =?utf-8?B?VlJ5RzJ1Rk9xb1JWQ2ZHNFhvTnRQOFFqYkNOdGwxWklDSXozbGZpUzB4bHhC?=
 =?utf-8?B?UWVrUlRBb3Y2WjVDRjRhZU9ZWWxNV08zRzBLSmpOWHQvVnVzZGRlRk44c0hs?=
 =?utf-8?B?R3BqdzhvSHZvR0NFZ1ZtclQvVCtSeXk3OXR3WFNLYjJ0TDAwTThFSDRXaTEv?=
 =?utf-8?B?OUljZTBUaFhMbGR6czFBcXFNUXRaazUrRXgrWEFzTmo3MmJ4dHQzcW82dW82?=
 =?utf-8?B?Y0dBMWJkN2pKK2ZmYkgyVWlsTlZISm1TdlF1NjQvZXJwcUtjQ1p1Y2dvQVhX?=
 =?utf-8?B?RGUwaFVKMEZvMndQZVRjZld1ZUE4dlJTZzFJNEQ0SUFzTHphSmlIR0NTem9O?=
 =?utf-8?B?LzFVRis0ZXF2ZVVLRFdxUWV3WTJtaC92Vko1bFJPK2xRTTVhbFAvTUFQQWhV?=
 =?utf-8?B?dmd4QWVWSkRYUmNRdXBRb25WSnhaTXo3aEZDTFZOMFp3bGIrVmFLK2JGd0w3?=
 =?utf-8?B?ZWJVR0VNQ0txZFRnanI1TURBc01Od0tHRFd6aUlRa0JtTFpXUmxzSHJHSXph?=
 =?utf-8?B?RTNJazg3MzlaWCtrcEtGaXhqVVAwOUNTZi9vYUVqcndOOVYzcmUrelg3RFhU?=
 =?utf-8?B?SjFHVnVtRFg4WVREYkpKUEFvNytCRW5qVnBnS2lONDVyRzR6NzdhT2VUdnBZ?=
 =?utf-8?B?aldLVHBydU1RMndCYU5PdUdtUXZvWHlCUjgxZUgyY1Ezc1ozUGwrckh4cnpL?=
 =?utf-8?B?cTk1d0poZDRCaUJzMjZUVWRsUmx2NloxaS9jVndPT2FDYlBzMmtLYkczZHRQ?=
 =?utf-8?B?NlFPM2VSVEo1WXBDaGtsYkFtbHRWUWt0eUtqcjEyVENvK2VJanZnbGhtYVZk?=
 =?utf-8?B?dXRqTGJzYnh2OEhGY2hMc3pKNUNjZXdkUitHdEphTXY3eVZSa3pkaWwvK0FS?=
 =?utf-8?B?NkdsK2MxSzhhY2lTNkN2M0pUU1hrL0N3ZWo2bXdmWXE2Q1N1ejI0SzFZdER3?=
 =?utf-8?B?TEFQWjFaSWhGbzdVYW1CaVpUb2JSTnh5YnM1YS9ZTkd2aVFxT1lPU21qS3pn?=
 =?utf-8?B?Vm5hSzFRMjVCdDRPVkY3amJTaVZJbWI4QitTRlhRVFAzcXJBTTI3Tk4vcmVp?=
 =?utf-8?Q?AfH/0gv8j2v3z7LOwcAt3toux?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb3848b-852e-4246-7246-08dbfbfc4900
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:55:18.0222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukF8c3w6AaogoxoUgtW7+g+s+x8KvtrIL50E/fJIo/67ZJPuqxAb8NO6WFPakZvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
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
Cc: Philip.Yang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-13 11:23, Felix Kuehling wrote:
>
> On 2023-12-13 10:24, James Zhu wrote:
>> Ping ...
>>
>> On 2023-12-08 18:01, James Zhu wrote:
>>> When application tries to allocate all system memory and cause memory
>>> to swap out. Needs more time for hmm_range_fault to validate the
>>> remaining page for allocation. To be safe, increase timeout value to
>>> 1 second for 64MB range.
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>
> This is not the first time we're incrementing this timeout. Eventually 
> we should get rid of that and find a way to make this work reliably 
> without a timeout. There can always be situations where faults take 
> longer, and we should not fail randomly in those cases.
>
> There are also some FIXMEs in this code that should be addressed at 
> the same time.
>
> That said, as a short-term fix, this patch is
[JZ] Yes, it is just a short-term fix. the root cause is still under study,
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index 081267161d40..b24eb5821fd1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -190,8 +190,8 @@ int amdgpu_hmm_range_get_pages(struct 
>>> mmu_interval_notifier *notifier,
>>>           pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>>>               hmm_range->start, hmm_range->end);
>>>   -        /* Assuming 128MB takes maximum 1 second to fault page 
>>> address */
>>> -        timeout = max((hmm_range->end - hmm_range->start) >> 27, 1UL);
>>> +        /* Assuming 64MB takes maximum 1 second to fault page 
>>> address */
>>> +        timeout = max((hmm_range->end - hmm_range->start) >> 26, 1UL);
>>>           timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
>>>           timeout = jiffies + msecs_to_jiffies(timeout);
