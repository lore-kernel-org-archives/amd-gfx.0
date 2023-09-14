Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1F3EEAA62
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 19:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64EC9896F7;
	Thu, 14 Sep 2023 19:26:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DC410E2B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 19:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAjyxhjshIQoawbOq19V2P1V8BRXGLvlOY9hsESHOwlgvXwPzxPlQbFtQ+n2ecbvEgDF8JJukfvfi55VEUuOQ2XXynkRoeVKPHCUmJL3e+f44kjKGIXAwY7+SA0Ee70lTJSG4Ojdo1bfzVSDYCTIoaSm10j6JCqCvYAEuwz0LVTyXkfgsr5DrsjzP93c9qw9miQi5sLbiU8sxFwfLdntTyh0z3jFnVWRgSSHbphYqgmiUb4bsSWVGFgsRjlP09A3nF43LVEBGzJFBW7GrymDe1z5LIE+evkU8/dCPPmcE+192ye/BxnrNCUng5YffWB9ZX0Ga47LxlK00oT5yV3L6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZpouKqQVsem0tE6vMeD/4HHhhkoSm/g/6C2xrXXhKY=;
 b=V1D254aV2OFUI2YhhQ/rrO9YLYlaHv8nHf/4h7MR38NufMfp8UProcqKf+hGvb1CnfISezpPXNty+hgXkqsxpvuw54vdQHGD86s5iSO/8fH30Fnf8TwOKSKraW2w0T94+RPZiklE43dU8Y3anTeasHgDMql55AYqVcKuS4MA67odiP2x+VnaMyMVJxEAW/ytL99RrRzcGaRJqVoVbXKskmgqYTVmYjezq8CNre/TWteAZeVnyruowix3TECi6uJ8FlnLxtlRlHSXcFfAfBZ4ki+wLR2yN5Ja7zF+1+pJn8HN6vxhf77R1FhD2sciDHkTnf11gSVvDA7v2Aq2xCRSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZpouKqQVsem0tE6vMeD/4HHhhkoSm/g/6C2xrXXhKY=;
 b=DUNibIZOzCOiPJ9BMhhVt6B4vSkjb5KcMUz0WYFtrOLRlNuLLNsNVdW2PEzdsCIQQ5CbejyAu45yKVIB1gjVqyyYQ3dALL9YQYbz7EAoZU7kUxokXnL4SUIP7U6Dg514AEawOTnqZH+H8Q9OYQmarpfMPrhjJahCdV46hQPE06g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4905.namprd12.prod.outlook.com (2603:10b6:610:64::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 19:26:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 19:26:42 +0000
Message-ID: <5f19d4ae-bc8d-925e-710d-2ca94461275f@amd.com>
Date: Thu, 14 Sep 2023 15:26:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230911140430.106717-1-xiaogang.chen@amd.com>
 <725b7649-5d55-9d3e-cb66-43c8fe2a3e87@amd.com>
 <f249e6ca-1f66-5559-6778-83540860cba1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f249e6ca-1f66-5559-6778-83540860cba1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: fb58a674-bd69-4e9a-25be-08dbb55886b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeOhW5y5bKLC5odScQo+Lq234/78p+zT4C2FS6IKwajdS790ASe4KYeBVbUbtx4FLYPQZL8KNZ8FZpPQQXb2saNEM+/afGHJulLlTXQARkXNteegkVfeM1fXXoaZHiBfvaXyEzcF3dIbQBRaxgoDoGqQk4wjc+Yh9VJBcx+CiEq6aZHgTy/NfAMN+RxI0Mw9cfXkNUKebL3WOtkQToqKB3dlWrxSpKOucMTb8qJdH60WwZv7h86NQHorx4mb7Wi2HNfBx2wJCkRbXEUJAg3Jbn+kDCMtpq4ZPx8KZ/gawXzJ7yIIj3wVmhk1ggd+PyVqOju4kCFlXN35ivya5zYrPlxxfJ06T1j5JynJBSUcUj96K3ji+5pOo5LEIxfr464Rf9PZqDAw2C+HQh1q407rt3yaEWXRA5lFzKrCZcxafU5zV1QJW7tYiFBSMGhvI2ZrrpereW2GQoNFLwf9aQDqFnG/xHHVAh9uVQDe4EW6ozB70vMlq1QFrmnejtQHOfqK059DfyjLmQtKgbZfC4Z41kxTG1oKN6ITx3/WIbkA6P4Wt9rSMUhJyYIDP0R4QQ1Tjxx9M8RPPR+foI3UWgqOtnlKs2HbPPninqEtPHyETRjOx1ODAdJwcSd1HZqGSZk6zJbwq+kS2HFNPnc7R9F6e/UL30z5J2VcoU5eDuzjmRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(1800799009)(186009)(451199024)(2616005)(6666004)(478600001)(26005)(83380400001)(36756003)(86362001)(31696002)(38100700002)(6486002)(6506007)(6512007)(36916002)(53546011)(66556008)(66476007)(66946007)(316002)(41300700001)(30864003)(2906002)(44832011)(5660300002)(8676002)(4326008)(8936002)(31686004)(3714002)(43740500002)(45980500001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRsZFdoMzVveDBFRjlsMkNQNllRZXdpYjZjd2huNHc3K0VJWExiVW1aNWt3?=
 =?utf-8?B?SXdPdkVhazlPK1gwQTVwOEJjWVE2UWZCTHAzME02YlhRc0VKeVhzN0NnMDZM?=
 =?utf-8?B?dTFoaXE0dFhNQnEzQkRnVllWY3p6cmtBYkROcGJqOFh3YXowRW5SVjg0TS9n?=
 =?utf-8?B?MFJWVW9GNTlpTityRzVvclA1dE9sK3dlRVc0SmVhQisvUjcwemRrQ1QxVFdj?=
 =?utf-8?B?R3BVV01UREMwRWJwUnc3OVQ3dUF3RFc4V21COFBodUhlRjV2TFViS0xSSVFH?=
 =?utf-8?B?WnRKeFBWczJ4OW5mY1RrbWIyeGRtdW8vUGxmS1cvcmVVLytBdzgwTFpFNkFC?=
 =?utf-8?B?Q2NRR3ZBK1Baa3dsQzlSSFVDVzRacmhMcDR2ak40MGpBbnVRZVNiOEdOV1hk?=
 =?utf-8?B?YWlKR0plTjY4K0MvWkNVSjNzTkpmakkxWWJKY2Uya0xRbjBZdkprMUdQdXNn?=
 =?utf-8?B?UW1SZDI4SnpjeWVJd1JUcXAxeHcxSmFjMFYzM3Iza3JDTzZmeURLUzRtNjVS?=
 =?utf-8?B?dWNxLy9MOFNHYVc2M2ZZaERBTUYyVzV1M21JTDdsWDRDbGp5aUxJWVZIRDhE?=
 =?utf-8?B?Z3VHb2RadFI1MFE1MUlCUW1MVzEwbkdXWE9uRFluVVY3OEJZb21YeDhPM1o5?=
 =?utf-8?B?OUNXK2FTRmI5a04xYnpIL0RLd3dHV2ZiSldYdjhHV3I1bkU0RTJJRTVNa1VR?=
 =?utf-8?B?aDBCRG16aFhEVEdIcUxFeXd5dCtNNEJSbkR6TUNuRmZESWRiV0d1aTZIY3Js?=
 =?utf-8?B?SFpzNXFMTEVHcFpjdU1iRmF2eWUvVHJ4VWNpb0s5OThvamNCenpiUGF5RGNH?=
 =?utf-8?B?SHB1VnFMQVYrMVEyRUNyaktOZ0dwYzBtZGlvakE4b3E1eWNQUFBIYzZveXg4?=
 =?utf-8?B?TkhDNllDd0tIT01INllGWEg4cFBsU3hmYzZ2K29mak1va2UzOFVwNkhTTXpU?=
 =?utf-8?B?MGZTVkFGZzJjSFNCdnAya3FTbERSMFFqK0pINmQ4N0paLzNkUDQxTWE3VUc2?=
 =?utf-8?B?d2tBUi9ZMFJHblhNVXp5WlRUUDQ1QWtxc0NBejlyU0ZMallHNUNaZkp1UXVY?=
 =?utf-8?B?dEsrNE1aclBPUnVOWE5HczdUSUJZRjhkK3VrMWhIWTkvUWgxUFc0V3ZTVUo0?=
 =?utf-8?B?OGsyZGhFSTN3Q1N5VzQ2UUFlamhHZmFYaC8vb0RPQ3RXU3ZSd3NkM1JzWStX?=
 =?utf-8?B?LzVGQVJXa01nRG05TnFnUXgxME1FbVlyRk9SMkZIQTdLMXU1TDcyelU2dEV2?=
 =?utf-8?B?N2ExZENpTVQyb1dYemFpT0NiQlFhTGVZK3dBcEFvM1hWczhlQWRqa0NoTyto?=
 =?utf-8?B?Mmp1cHlVSVBJQTdWK200WkNXNU5HMkYrdFhZcyticXh1ZW9OU0lZZ0JIeTJj?=
 =?utf-8?B?SlFsbXIwYXUydG5UTkc1d1ZCaTR2VDBwNnpWU1FWeUJZaDdWWXpCM3lvSkJz?=
 =?utf-8?B?Z0JzOHhuNWZBd3hkQTVhVFVPSnpFY0t6Z2dCZXNYeE9xcERyOHNBK3hHdDVH?=
 =?utf-8?B?TVVQU1ExTEUvR1M4cUN3amF1RXA4V0xBL1dtUkFtWVIxMFhuT0MzTHJ2NGVN?=
 =?utf-8?B?SmVRdWVickMySkdWai96b0MzNEVORC9iOG9JY3VPWkFwVmhCNzBtaWV2OWJW?=
 =?utf-8?B?Zk1reHZ4VGt2cGExbVVDcXk0NjlybG82WEhFeHhRZmQ1b2N0QjlwV29OQXVa?=
 =?utf-8?B?OGlUSExhZFA2OGo1aWxVZENQK2pOUEVHM3BCWVkveUpna3ZkZXhXSVdLL3kz?=
 =?utf-8?B?NDNhNmZ2N2Fsc01mMk9iVDk5R1BTZCtmQ0tPdjcwclhPYkw1YXh2M1c1TG1z?=
 =?utf-8?B?a01TVURWdHNwY0NNU0J0MkR2MHZ4Y3BOWi8wdnRTZmRnczhnR00xd3FiVjZh?=
 =?utf-8?B?eFlYSjJObEcwL2J0Q2lpUFhURzYrdHJoTjFYTlJTSU9zUVgxaWRwTStHdmsw?=
 =?utf-8?B?RFBWc1V1V01IRWJFNjdQOXRURGFZck9aUUFKS09mR2xOWnR5ZmVmZFE4ZHRv?=
 =?utf-8?B?bndMYXNxdnBzTzJ1WlNDc1pOQm5vaEQ5T0FSZEw1YWttU2V2UEdzVmNRaUNW?=
 =?utf-8?B?dVpxZS9tb3R6bnlxOTNJN1lGdmVvTGFsS3dnVjBvN0t4dndiQjd5TmliZlR2?=
 =?utf-8?Q?vlwIgsyZc+xmgCeq4rproEwCo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb58a674-bd69-4e9a-25be-08dbb55886b3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 19:26:42.6242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4Zv3vKH/Ho2qSNrCN9Nub6M5g/aobww//i6SJ3xSWZsQMlpVSc2sWx4PU76e9ygjYL4ftbG8vXimOHRFpsnZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-14 10:59, Chen, Xiaogang wrote:
>
> On 9/13/2023 5:03 PM, Felix Kuehling wrote:
>> On 2023-09-11 10:04, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>>
>>> This patch implements partial migration in gpu page fault according 
>>> to migration
>>> granularity(default 2MB) and not split svm range in cpu page fault 
>>> handling.
>>> A svm range may include pages from both system ram and vram of one 
>>> gpu now.
>>> These chagnes are expected to improve migration performance and reduce
>>> mmu callback and TLB flush workloads.
>>>
>>> Signed-off-by: xiaogang chen<xiaogang.chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 151 
>>> ++++++++++++++---------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  88 ++++++++++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   7 +-
>>>   4 files changed, 171 insertions(+), 81 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index 7d82c7da223a..653a2edbaba4 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -445,7 +445,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>           pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>>
>> Should this message also be updated: migrated -> collected?
>>
> yes, it was left as original version. cpages is number of collected 
> pages from hmm. Will change to: pr_debug("partial migration, 
> 0x%lx/0x%llx pages collected\n",
>
>>>                cpages, npages);
>>>       else
>>> -        pr_debug("0x%lx pages migrated\n", cpages);
>>> +        pr_debug("0x%lx pages collected\n", cpages);
>>>         r = svm_migrate_copy_to_vram(node, prange, &migrate, 
>>> &mfence, scratch, ttm_res_offset);
>>>       migrate_vma_pages(&migrate);
>>> @@ -479,6 +479,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>    * svm_migrate_ram_to_vram - migrate svm range from system to device
>>>    * @prange: range structure
>>>    * @best_loc: the device to migrate to
>>> + * @start_mgr: start page to migrate
>>> + * @last_mgr: last page to migrate
>>>    * @mm: the process mm structure
>>>    * @trigger: reason of migration
>>>    *
>>> @@ -489,6 +491,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>    */
>>>   static int
>>>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>> +            unsigned long start_mgr, unsigned long last_mgr,
>>>               struct mm_struct *mm, uint32_t trigger)
>>>   {
>>>       unsigned long addr, start, end;
>>> @@ -498,23 +501,30 @@ svm_migrate_ram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>       unsigned long cpages = 0;
>>>       long r = 0;
>>>   -    if (prange->actual_loc == best_loc) {
>>> -        pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
>>> -             prange->svms, prange->start, prange->last, best_loc);
>>> +    if (!best_loc) {
>>> +        pr_debug("request svms 0x%p [0x%lx 0x%lx] migrate to sys 
>>> ram\n",
>>
>> This message seems incorrect. This function migrates to VRAM.
>>
> I think this message is for input checking: when migrate from ram to 
> varm and we see best_loc is sys ram this message indicates that the 
> caller try to migration to sys ram, not vram, then do nothing. It does 
> not indicate what this function does as pr_debug will add function 
> name at beginning.

OK, makes sense, I wasn't reading it carefully. No need to add the 
function name to the message, because dyn-debug can add the file name, 
function name and line number by itself.


>>
>>> +             prange->svms, start_mgr, last_mgr);
>>>           return 0;
>>>       }
>>>   +    if (start_mgr < prange->start || last_mgr > prange->last) {
>>> +        pr_debug("migration range [0x%lx 0x%lx] out prange [0x%lx 
>>> 0x%lx]\n",
>>> +                 start_mgr, last_mgr, prange->start, prange->last);
>>> +        return -EFAULT;
>>> +    }
>>> +
>>>       node = svm_range_get_node_by_id(prange, best_loc);
>>>       if (!node) {
>>>           pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>>>           return -ENODEV;
>>>       }
>>>   -    pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
>>> -         prange->start, prange->last, best_loc);
>>> +    pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
>>> +             prange->svms, start_mgr, last_mgr, prange->start, 
>>> prange->last,
>>> +             best_loc);
>>>   -    start = prange->start << PAGE_SHIFT;
>>> -    end = (prange->last + 1) << PAGE_SHIFT;
>>> +    start = start_mgr << PAGE_SHIFT;
>>> +    end = (last_mgr + 1) << PAGE_SHIFT;
>>>         r = svm_range_vram_node_new(node, prange, true);
>>>       if (r) {
>>> @@ -544,8 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>         if (cpages) {
>>>           prange->actual_loc = best_loc;
>>> -        svm_range_free_dma_mappings(prange, true);
>>> -    } else {
>>> +        prange->vram_pages = prange->vram_pages + cpages;
>>> +    } else if (!prange->actual_loc) {
>>> +        /* if no page migrated and all pages from prange are at
>>> +         * sys ram drop svm_bo got from svm_range_vram_node_new
>>> +         */
>>>           svm_range_vram_node_free(prange);
>>>       }
>>>   @@ -670,7 +683,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>   static long
>>>   svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range 
>>> *prange,
>>>                  struct vm_area_struct *vma, uint64_t start, 
>>> uint64_t end,
>>> -               uint32_t trigger, struct page *fault_page)
>>> +               uint32_t trigger, struct page *fault_page, unsigned 
>>> long *mpages)
>>>   {
>>>       struct kfd_process *p = container_of(prange->svms, struct 
>>> kfd_process, svms);
>>>       uint64_t npages = (end - start) >> PAGE_SHIFT;
>>> @@ -684,6 +697,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>       void *buf;
>>>       int r = -ENOMEM;
>>>   +    *mpages = 0;
>>>       memset(&migrate, 0, sizeof(migrate));
>>>       migrate.vma = vma;
>>>       migrate.start = start;
>>> @@ -728,7 +742,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>           pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>>>                cpages, npages);
>>>       else
>>> -        pr_debug("0x%lx pages migrated\n", cpages);
>>> +        pr_debug("0x%lx pages collected\n", cpages);
>>>         r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>>>                       scratch, npages);
>>> @@ -751,10 +765,12 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>       kvfree(buf);
>>>   out:
>>>       if (!r && cpages) {
>>> +        *mpages = cpages - upages;
>>>           pdd = svm_range_get_pdd_by_node(prange, node);
>>>           if (pdd)
>>> -            WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
>>> +            WRITE_ONCE(pdd->page_out, pdd->page_out + *mpages);
>>>       }
>>> +
>>>       return r ? r : upages;
>>>   }
>>>   @@ -762,6 +778,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>    * svm_migrate_vram_to_ram - migrate svm range from device to system
>>>    * @prange: range structure
>>>    * @mm: process mm, use current->mm if NULL
>>> + * @start_mgr: start page need be migrated to sys ram
>>> + * @last_mgr: last page need be migrated to sys ram
>>>    * @trigger: reason of migration
>>>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is 
>>> CPU page fault callback
>>>    *
>>> @@ -771,7 +789,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>    * 0 - OK, otherwise error code
>>>    */
>>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct 
>>> mm_struct *mm,
>>> -                uint32_t trigger, struct page *fault_page)
>>> +                    unsigned long start_mgr, unsigned long last_mgr,
>>> +                    uint32_t trigger, struct page *fault_page)
>>>   {
>>>       struct kfd_node *node;
>>>       struct vm_area_struct *vma;
>>> @@ -779,28 +798,37 @@ int svm_migrate_vram_to_ram(struct svm_range 
>>> *prange, struct mm_struct *mm,
>>>       unsigned long start;
>>>       unsigned long end;
>>>       unsigned long upages = 0;
>>> +    unsigned long mpages = 0;
>>>       long r = 0;
>>>   +    /* this pragne has no any vram page to migrate to sys ram */
>>>       if (!prange->actual_loc) {
>>>           pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
>>>                prange->start, prange->last);
>>>           return 0;
>>>       }
>>>   +    if (start_mgr < prange->start || last_mgr > prange->last) {
>>> +        pr_debug("migration range [0x%lx 0x%lx] out prange [0x%lx 
>>> 0x%lx]\n",
>>> +             start_mgr, last_mgr, prange->start, prange->last);
>>> +        return -EFAULT;
>>> +    }
>>> +
>>>       node = svm_range_get_node_by_id(prange, prange->actual_loc);
>>>       if (!node) {
>>>           pr_debug("failed to get kfd node by id 0x%x\n", 
>>> prange->actual_loc);
>>>           return -ENODEV;
>>>       }
>>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to 
>>> ram\n",
>>> -         prange->svms, prange, prange->start, prange->last,
>>> +         prange->svms, prange, start_mgr, last_mgr,
>>>            prange->actual_loc);
>>>   -    start = prange->start << PAGE_SHIFT;
>>> -    end = (prange->last + 1) << PAGE_SHIFT;
>>> +    start = start_mgr << PAGE_SHIFT;
>>> +    end = (last_mgr + 1) << PAGE_SHIFT;
>>>         for (addr = start; addr < end;) {
>>>           unsigned long next;
>>> +        unsigned long mpages_vma;
>>>             vma = vma_lookup(mm, addr);
>>>           if (!vma) {
>>> @@ -811,19 +839,29 @@ int svm_migrate_vram_to_ram(struct svm_range 
>>> *prange, struct mm_struct *mm,
>>>             next = min(vma->vm_end, end);
>>>           r = svm_migrate_vma_to_ram(node, prange, vma, addr, next, 
>>> trigger,
>>> -            fault_page);
>>> +            fault_page, &mpages_vma);
>>>           if (r < 0) {
>>>               pr_debug("failed %ld to migrate prange %p\n", r, prange);
>>>               break;
>>>           } else {
>>>               upages += r;
>>> +            mpages = mpages + mpages_vma;
>>
>>     mpages += mpages_vma;
>>
> ok.
>>
>>>           }
>>>           addr = next;
>>>       }
>>>   -    if (r >= 0 && !upages) {
>>> -        svm_range_vram_node_free(prange);
>>> -        prange->actual_loc = 0;
>>
>> Looks like we no longer need upages. Maybe instead of adding an 
>> mpages output parameter to svm_migrate_vma_to_ram, we could let the 
>> function return mpages instead of upages.
> Yes, upages is not needed here now as we use mpages to account number 
> of pages got migrated. We can change svm_migrate_vma_to_ram to let 
> return value mean:  positive number as migrated page number; negative 
> number means error.
>>
>>
>>
>>> +    if (r >= 0) {
>>> +        prange->vram_pages = prange->vram_pages - mpages;
>>> +
>>> +        /* prange dos not have vram page drop its svm_bo ref */
>>> +        if (prange->vram_pages == 0 && prange->ttm_res) {
>>> +
>>> +            svm_range_vram_node_free(prange);
>>> +            mutex_lock(&prange->lock);
>>> +            prange->svm_bo = NULL;
>>
>> This looks suspicious. Normally this is only done when the original 
>> BO is freed, so that we can reuse existing BOs shared by multiple 
>> ranges as long as they continue to exist.
>>
>>
> I  set " prange->svm_bo = NULL" here to prevent unref svm_bo when its 
> reference is zero:

svm_range_vram_node_free sets prange->ttm_res = NULL when releasing the 
BO. Unreffing a BO when prange->ttm_res is NULL would be a bug (double 
free). Maybe we need to add a check for that somewhere. Please don't 
unset prange->svm_bo. That should only be unset in svm_range_bo_release, 
when the BO is actually released.


> at svm_range_bo_unref we check if (svm_bo), then kref_put its 
> reference. If after svm_range_vram_node_free we do not set " 
> prange->svm_bo = NULL", inside svm_range_validate_and_map we also call 
> svm_range_vram_node_free on that prange, then would get WARNING as its 
> reference number is already zero. I think " prange->svm_bo = NULL" 
> here has no side effect since we know the prange has no vram page at 
> this stage, so set its svm_bo pointer to null.

That's not correct. If the BO is not freed yet (because another range is 
still using it), then we can keep reusing the same BO. But that only 
works if we don't unset prange->svm_bo.


>
> I will think if can avoid unref svm_bo when its reference number is 
> zero without "prange->svm_bo = NULL" here.
>
>>> +            prange->actual_loc = 0;
>>> +            mutex_unlock(&prange->lock);
>>> +        }
>>>       }
>>>         return r < 0 ? r : 0;
>>> @@ -833,17 +871,23 @@ int svm_migrate_vram_to_ram(struct svm_range 
>>> *prange, struct mm_struct *mm,
>>>    * svm_migrate_vram_to_vram - migrate svm range from device to device
>>>    * @prange: range structure
>>>    * @best_loc: the device to migrate to
>>> + * @start: start page need be migrated to sys ram
>>> + * @last: last page need be migrated to sys ram
>>>    * @mm: process mm, use current->mm if NULL
>>>    * @trigger: reason of migration
>>>    *
>>>    * Context: Process context, caller hold mmap read lock, svms 
>>> lock, prange lock
>>>    *
>>> + * migrate all vram pages in prange to sys ram, then migrate 
>>> [start, last] pages
>>> + * from sys ram to gpu node best_loc.
>>> + *
>>>    * Return:
>>>    * 0 - OK, otherwise error code
>>>    */
>>>   static int
>>>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>> -             struct mm_struct *mm, uint32_t trigger)
>>> +            unsigned long start, unsigned long last,
>>> +            struct mm_struct *mm, uint32_t trigger)
>>>   {
>>>       int r, retries = 3;
>>>   @@ -855,7 +899,8 @@ svm_migrate_vram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>       pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, 
>>> best_loc);
>>>         do {
>>> -        r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
>>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>>> prange->last,
>>> +                    trigger, NULL);
>>>           if (r)
>>>               return r;
>>>       } while (prange->actual_loc && --retries);
>>> @@ -863,18 +908,20 @@ svm_migrate_vram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>       if (prange->actual_loc)
>>>           return -EDEADLK;
>>>   -    return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>>> +    return svm_migrate_ram_to_vram(prange, best_loc, start, last, 
>>> mm, trigger);
>>>   }
>>>     int
>>>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>>> -            struct mm_struct *mm, uint32_t trigger)
>>> +        unsigned long start, unsigned long last,
>>> +        struct mm_struct *mm, uint32_t trigger)
>>>   {
>>> -    if  (!prange->actual_loc)
>>> -        return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>>> +    if  (!prange->actual_loc || prange->actual_loc == best_loc)
>>> +        return svm_migrate_ram_to_vram(prange, best_loc, start, last,
>>> +                    mm, trigger);
>>>       else
>>> -        return svm_migrate_vram_to_vram(prange, best_loc, mm, 
>>> trigger);
>>> -
>>> +        return svm_migrate_vram_to_vram(prange, best_loc, start, last,
>>> +                    mm, trigger);
>>>   }
>>>     /**
>>> @@ -889,10 +936,9 @@ svm_migrate_to_vram(struct svm_range *prange, 
>>> uint32_t best_loc,
>>>    */
>>>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>>>   {
>>> +    unsigned long start, last, size;
>>>       unsigned long addr = vmf->address;
>>>       struct svm_range_bo *svm_bo;
>>> -    enum svm_work_list_ops op;
>>> -    struct svm_range *parent;
>>>       struct svm_range *prange;
>>>       struct kfd_process *p;
>>>       struct mm_struct *mm;
>>> @@ -929,51 +975,34 @@ static vm_fault_t svm_migrate_to_ram(struct 
>>> vm_fault *vmf)
>>>         mutex_lock(&p->svms.lock);
>>>   -    prange = svm_range_from_addr(&p->svms, addr, &parent);
>>> +    prange = svm_range_from_addr(&p->svms, addr, NULL);
>>>       if (!prange) {
>>>           pr_debug("failed get range svms 0x%p addr 0x%lx\n", 
>>> &p->svms, addr);
>>>           r = -EFAULT;
>>>           goto out_unlock_svms;
>>>       }
>>>   -    mutex_lock(&parent->migrate_mutex);
>>> -    if (prange != parent)
>>> -        mutex_lock_nested(&prange->migrate_mutex, 1);
>>> +    mutex_lock(&prange->migrate_mutex);
>>>         if (!prange->actual_loc)
>>>           goto out_unlock_prange;
>>>   -    svm_range_lock(parent);
>>> -    if (prange != parent)
>>> -        mutex_lock_nested(&prange->lock, 1);
>>> -    r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
>>> -    if (prange != parent)
>>> -        mutex_unlock(&prange->lock);
>>> -    svm_range_unlock(parent);
>>> -    if (r) {
>>> -        pr_debug("failed %d to split range by granularity\n", r);
>>> -        goto out_unlock_prange;
>>> -    }
>>> +    /* Align migration range start and size to granularity size */
>>> +    size = 1UL << prange->granularity;
>>
>> I think this was broken before, but you probably need to change this to
>>
>>     size = 1UL << (prange->granularity + PAGE_SHIFT);
>>
>> because prange->granularity 0 corresponds to PAGE_SIZE, and I'm 
>> pretty sure prange->start/last are byte-addresses.
>>
> prange->granularity is "migration granularity, log2 num pages", 
> default is 9(512 pages). And prange->start/last:
>
> * @start:      range start address in pages
> * @last:       range last address in pages
>
> We use page number here, right?

Hmm, I couldn't remember and didn't see the comment and couldn't find 
any code that converts byte addresses from user mode into pages. I see 
it now in svm_ioctl:

         start >>= PAGE_SHIFT;
         size >>= PAGE_SHIFT;


>
>>
>>> +    start = ALIGN_DOWN(addr, size);
>>> +    last = ALIGN(addr + 1, size) - 1;
>>> +
>>> +    start = (start >= prange->start) ? start : prange->start;
>>> +    last = (last <= prange->last) ? last : prange->last;
>>
>> You can simplify this to
>>
>>     start = max(ALIGN_DOWN(addr, size), prange->start);
>>     last = min(ALIGN(addr + 1, size) - 1, prange->last);
>>
> ok, I used the (? :) form since max/min are macro that may have type 
> checking issue depending on how they are defined.

If the types don't match there is also min_t and max_t.


>>>   -    r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
>>> -                    vmf->page);
>>> +    r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
>>> +                KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
>>>       if (r)
>>>           pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 
>>> 0x%lx]\n",
>>> -             r, prange->svms, prange, prange->start, prange->last);
>>> -
>>> -    /* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
>>> -    if (p->xnack_enabled && parent == prange)
>>> -        op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
>>> -    else
>>> -        op = SVM_OP_UPDATE_RANGE_NOTIFIER;
>>> -    svm_range_add_list_work(&p->svms, parent, mm, op);
>>> -    schedule_deferred_list_work(&p->svms);
>>> +             r, prange->svms, prange, start, last);
>>>     out_unlock_prange:
>>> -    if (prange != parent)
>>> -        mutex_unlock(&prange->migrate_mutex);
>>> -    mutex_unlock(&parent->migrate_mutex);
>>> +    mutex_unlock(&prange->migrate_mutex);
>>>   out_unlock_svms:
>>>       mutex_unlock(&p->svms.lock);
>>>   out_unref_process:
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>> index 487f26368164..9e48d10e848e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>>> @@ -41,9 +41,13 @@ enum MIGRATION_COPY_DIR {
>>>   };
>>>     int svm_migrate_to_vram(struct svm_range *prange, uint32_t 
>>> best_loc,
>>> +            unsigned long start, unsigned long last,
>>>               struct mm_struct *mm, uint32_t trigger);
>>> +
>>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct 
>>> mm_struct *mm,
>>> -                uint32_t trigger, struct page *fault_page);
>>> +            unsigned long start, unsigned long last,
>>> +            uint32_t trigger, struct page *fault_page);
>>> +
>>>   unsigned long
>>>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long 
>>> addr);
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 841ba6102bbb..8243fbccdf2d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -270,8 +270,6 @@ void svm_range_free_dma_mappings(struct 
>>> svm_range *prange, bool unmap_dma)
>>>           dev = &pdd->dev->adev->pdev->dev;
>>>           if (unmap_dma)
>>>               svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
>>> -        kvfree(dma_addr);
>>> -        prange->dma_addr[gpuidx] = NULL;
>>
>> I'd recommend renaming this function to make its new purpose clearer: 
>> svm_range_dma_unmap. Then you can also remove the unmap_dma 
>> parameter. In cases where it was false, you won't need to call the 
>> function at all, now that it no longer frees the DMA address arrays.
>>
>> It would make sense to split that into a separate patch.
>>
>>
> ok, I will add a separated patch to address it as you recommend. It is 
> a general change, not related to partial migration.
>>>       }
>>>   }
>>>   @@ -279,6 +277,7 @@ static void svm_range_free(struct svm_range 
>>> *prange, bool do_unmap)
>>>   {
>>>       uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>>>       struct kfd_process *p = container_of(prange->svms, struct 
>>> kfd_process, svms);
>>> +    uint32_t gpuidx;
>>>         pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", 
>>> prange->svms, prange,
>>>            prange->start, prange->last);
>>> @@ -286,6 +285,14 @@ static void svm_range_free(struct svm_range 
>>> *prange, bool do_unmap)
>>>       svm_range_vram_node_free(prange);
>>>       svm_range_free_dma_mappings(prange, do_unmap);
>>
>> For example, this would become
>>
>>     if (do_unmap)
>>         svm_range_dma_unmap(prange);
>>
> yes, will do.
>>>   +    /* free dma_addr array for each gpu */
>>> +    for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
>>> +        if (prange->dma_addr[gpuidx]) {
>>> +            kvfree(prange->dma_addr[gpuidx]);
>>> +            prange->dma_addr[gpuidx] = NULL;
>>> +        }
>>> +    }
>>> +
>>>       if (do_unmap && !p->xnack_enabled) {
>>>           pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, 
>>> size);
>>>           amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>>> @@ -338,6 +345,7 @@ svm_range *svm_range_new(struct svm_range_list 
>>> *svms, uint64_t start,
>>>       INIT_LIST_HEAD(&prange->child_list);
>>>       atomic_set(&prange->invalid, 0);
>>>       prange->validate_timestamp = 0;
>>> +    prange->vram_pages = 0;
>>>       mutex_init(&prange->migrate_mutex);
>>>       mutex_init(&prange->lock);
>>>   @@ -384,6 +392,8 @@ static void svm_range_bo_release(struct kref 
>>> *kref)
>>>                prange->start, prange->last);
>>>           mutex_lock(&prange->lock);
>>>           prange->svm_bo = NULL;
>>> +        /* prange dose not hold vram page now */
>>
>> Typo: dose -> does
>>
> ok
>>
>>> +        prange->actual_loc = 0;
>>>           mutex_unlock(&prange->lock);
>>>             spin_lock(&svm_bo->list_lock);
>>> @@ -439,7 +449,8 @@ svm_range_validate_svm_bo(struct kfd_node *node, 
>>> struct svm_range *prange)
>>>           mutex_unlock(&prange->lock);
>>>           return false;
>>>       }
>>> -    if (prange->ttm_res) {
>>> +    /* requeset from same kfd_node and we still have reference to 
>>> it */
>>> +    if (prange->ttm_res && prange->svm_bo->node == node) {
>>
>> I think previously, the assumption was, that we migrate to system 
>> memory before we migrate to a different GPU. So we should have called 
>> svm_range_vram_node_free before trying to get a new VRAM BO.
>>
>> If this is no longer true, we need to fix that. Otherwise you leak a 
>> BO reference here.
>>
> With partial migration when call svm_range_validate_svm_bo the prange 
> may have some pages from vram, not like current case that all pages 
> are either vram or sys ram.  svm_range_validate_svm_bo ask if we can 
> still use vram pages from this node(kfd_node). The change check if the 
> prange still has svm_bo from the same node, not sure how the BO 
> reference got leaked here?

If prange->ttm_res and prange->svm_bo->node != node, it will fall 
through here and take another reference with svm_bo_ref_unless_zero. 
That's a reference leak because now the same range has two reference to 
the same svm_bo.

Also prange->ttm_res and prange->svm_bo->node != node indicates, that 
you still have some pages in VRAM on the wrong GPU. If this happens, 
something went wrong earlier. You're probably papering over some other 
problem if you find that this change is needed. Before allocating a BO 
on a new GPU, we should have migrated everything to system memory and 
freed the BO (setting prange->ttm_res = NULL in svm_range_vram_node_free).


>>
>>>           /* We still have a reference, all is well */
>>>           mutex_unlock(&prange->lock);
>>>           return true;
>>> @@ -458,6 +469,8 @@ svm_range_validate_svm_bo(struct kfd_node *node, 
>>> struct svm_range *prange)
>>> spin_unlock(&prange->svm_bo->list_lock);
>>>                 svm_range_bo_unref(prange->svm_bo);
>>> +            prange->ttm_res = NULL;
>>> +            prange->svm_bo = NULL;
>>
>> The only function that should update prange->svm_bo to NULL is 
>> svm_range_bo_release. And ttm_res is set to NULL in 
>> svm_range_vram_node_free. If you fix the above assumptions about 
>> calling svm_range_vram_node_free before allocating a BO on a 
>> different GPU, this hack will also not be needed.
>>
> Same concern as above to avoid unref smb_bo when its reference number 
> is zero. I will recheck if can avoid these two null settings here.
>>
>>>               return false;
>>>           }
>>>           if (READ_ONCE(prange->svm_bo->evicting)) {
>>> @@ -956,6 +969,10 @@ svm_range_split_nodes(struct svm_range *new, 
>>> struct svm_range *old,
>>>         new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>>       new->ttm_res = old->ttm_res;
>>> +    /* set new's vram_pages as old range's now, the acurate vram_pages
>>> +     * will be updated during mapping
>>> +     */
>>> +    new->vram_pages = old->vram_pages;
>>
>> This should be min(old->vram_pages, new->npages).
> ok, even we set new->vram_pages pessimistically, still should not more 
> than its new->npages.
>>
>>
>>> spin_lock(&new->svm_bo->list_lock);
>>>       list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>> @@ -1593,6 +1610,7 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>       struct svm_validate_context *ctx;
>>>       unsigned long start, end, addr;
>>>       struct kfd_process *p;
>>> +    uint32_t vram_pages;
>>
>> Should this be uint64_t? And why not 0-initialize this here?
>>
> ok, I thought 32 bit is enough for page number of one prange. I will 
> change it to 64 bit, also vram_pages of svm_range will be 64 bits as 
> you mentioned below.
>
> vram_pages is set to zeo when use it below.
>
>>
>>>       void *owner;
>>>       int32_t idx;
>>>       int r = 0;
>>> @@ -1661,6 +1679,7 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>           }
>>>       }
>>>   +    vram_pages = 0;
>>>       start = prange->start << PAGE_SHIFT;
>>>       end = (prange->last + 1) << PAGE_SHIFT;
>>>       for (addr = start; addr < end && !r; ) {
>>> @@ -1692,6 +1711,11 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>               goto unreserve_out;
>>>           }
>>>   +        for (int i = 0; i < npages; i++) {
>>> +            if 
>>> (is_zone_device_page(hmm_pfn_to_page(hmm_range->hmm_pfns[i])))
>>> +                vram_pages++;
>>> +        }
>>
>> Is there a way to do this only if it's needed (i.e. after a range was 
>> split). I suspect this could add unnecessary overhead if we do it all 
>> the time.
>
> At split case prange->vram_page was set "pessimistically" that 
> prange->vram_page is not accurate and more than vram pages that the 
> splitted prange really has.  It is why we need this accounting here. I 
> do not see there is a way to know whether prange->vram_page is 
> accurate before ask hmm.
>
> I will see if can put this accounting at svm_range_dma_map_dev as you 
> mentioned below.
>
>>
>>
>>> +
>>>           offset = (addr - start) >> PAGE_SHIFT;
>>>           r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>>>                         hmm_range->hmm_pfns);
>>
>> Or you could make it 0-additional-overhead by counting vram_pages it 
>> svm_range_dma_map_dev, which needs to iterate the pfn-array and 
>> determine the page type anyway.
>>
>>
> Yes, I will see if can have svm_range_dma_map_dev do it and return 
> real vram_pages value of prange.
>>> @@ -1724,6 +1748,15 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>       if (addr == end) {
>>>           prange->validated_once = true;
>>>           prange->mapped_to_gpu = true;
>>> +        prange->vram_pages = vram_pages;
>>> +
>>> +        /* if pragne does not include any vram page and it
>>> +         * has not released svm_bo drop its svm_bo reference
>>> +         */
>>> +        if (!vram_pages && prange->ttm_res) {
>>> +            svm_range_vram_node_free(prange);
>>> +            prange->actual_loc = 0;
>>> +        }
>>>       }
>>>     unreserve_out:
>>> @@ -1981,6 +2014,7 @@ static struct svm_range 
>>> *svm_range_clone(struct svm_range *old)
>>>       new->actual_loc = old->actual_loc;
>>>       new->granularity = old->granularity;
>>>       new->mapped_to_gpu = old->mapped_to_gpu;
>>> +    new->vram_pages = old->vram_pages;
>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>> MAX_GPU_INSTANCE);
>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>>   @@ -2888,6 +2922,7 @@ svm_range_restore_pages(struct amdgpu_device 
>>> *adev, unsigned int pasid,
>>>               uint32_t vmid, uint32_t node_id,
>>>               uint64_t addr, bool write_fault)
>>>   {
>>> +    unsigned long start, last, size;
>>>       struct mm_struct *mm = NULL;
>>>       struct svm_range_list *svms;
>>>       struct svm_range *prange;
>>> @@ -3023,11 +3058,21 @@ svm_range_restore_pages(struct amdgpu_device 
>>> *adev, unsigned int pasid,
>>>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>>                          write_fault, timestamp);
>>>   -    if (prange->actual_loc != best_loc) {
>>> +
>>> +    if (prange->actual_loc != 0 || best_loc != 0) {
>>
>> I think this misses cases where we need to migrate to system memory 
>> (i.e. prange->actual_loc != 0 and best_loc == 0). I think this 
>> condition should just be
>>
>>     if (prange->actual_loc != 0)
>>
> The condition "if (prange->actual_loc != 0 || best_loc != 0)" only 
> miss  the case "if (prange->actual_loc == 0 && best_loc == 0)" that 
> both actual and beset_loc are sys ram, then we do not need migration. 
> If best_loc is gpu we do migration.

You're right. I must have been tired when I reviewed this.


>> You could optimize this further to avoid unnecessary migrations when 
>> all pages are already in the correct VRAM location:
>>
>>     if (prange->actual_loc != 0 && (best_loc == 0 ||
>>         (best_loc != 0 && prange->vram_pages < prange->npages)))
>>
>>
> At this stage we do not know if prange->vram_pages is accurate(like 
> split prange case). We know it is accurate only during 
> svm_range_validate_and_map by using hmm function.
>
>>> +
>>>           migration = true;
>>> +        /* Align migration range start and size to granularity size */
>>> +        size = 1UL << prange->granularity;
>>> +        start = ALIGN_DOWN(addr, size);
>>> +        last = ALIGN(addr + 1, size) - 1;
>>> +
>>> +        start = (start >= prange->start) ? start : prange->start;
>>> +        last = (last <= prange->last) ? last : prange->last;
>>> +
>>>           if (best_loc) {
>>> -            r = svm_migrate_to_vram(prange, best_loc, mm,
>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>> +            r = svm_migrate_to_vram(prange, best_loc, start, last,
>>> +                            mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>>>               if (r) {
>>>                   pr_debug("svm_migrate_to_vram failed (%d) at %llx, 
>>> falling back to system memory\n",
>>>                        r, addr);
>>> @@ -3035,20 +3080,18 @@ svm_range_restore_pages(struct amdgpu_device 
>>> *adev, unsigned int pasid,
>>>                    * VRAM failed
>>>                    */
>>>                   if (prange->actual_loc)
>>
>> This condition needs to change now. If we're migrating to the same 
>> GPU, then a failed migration is no problem. We only need to migrate 
>> to system memory if the memory is in the wrong GPU and migration failed:
>>
>>                  if (prange->actual_loc && prange->actual_loc != 
>> best_loc)
> oh, yes, Thanks. I will update that next round.
>>
>>
>>> -                    r = svm_migrate_vram_to_ram(prange, mm,
>>> -                       KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>> -                       NULL);
>>> +                    r = svm_migrate_vram_to_ram(prange, mm, start, 
>>> last,
>>> + KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>                   else
>>>                       r = 0;
>>>               }
>>>           } else {
>>
>> See my comment above. You'll never get to this else branch unless you 
>> fix the condition above.
>>
>>
>>> -            r = svm_migrate_vram_to_ram(prange, mm,
>>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>>> -                    NULL);
>>> +            r = svm_migrate_vram_to_ram(prange, mm, start, last,
>>> +                        KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>>           }
>>>           if (r) {
>>>               pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
>>> -                 r, svms, prange->start, prange->last);
>>> +                 r, svms, start, last);
>>>               goto out_unlock_range;
>>>           }
>>>       }
>>> @@ -3402,18 +3445,24 @@ svm_range_trigger_migration(struct mm_struct 
>>> *mm, struct svm_range *prange,
>>>       *migrated = false;
>>>       best_loc = svm_range_best_prefetch_location(prange);
>>>   -    if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
>>> -        best_loc == prange->actual_loc)
>>> +    /* when best_loc is a gpu node and same as prange->actual_loc
>>> +     * we still need do migration as prange->actual_loc !=0 does
>>> +     * not mean all pages in prange are vram. hmm migrate will pick
>>> +     * up right pages during migration.
>>> +     */
>>> +    if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
>>> +        (best_loc == 0 && prange->actual_loc == 0))
>>
>> You could refine this to avoid unnecessary migrations if all pages 
>> are in VRAM already:
>>
>>         || (prange->actual_loc == best_loc && prange->vram_pages == 
>> prange->npages)
>>
>>
> Same concern that prange->vram_pages may not be accurate at this stage.

Hmm, we could cap vram_pages at prange->npages - 1 when splitting 
ranges. That way we'd never assume that everything is in VRAM after a 
split, and if we see prange->vram_pages == prange->npages, we'd know 
that this number is accurate. Anyway, that's maybe an optimization we 
can look into later.

Regards,
   Felix


>>>           return 0;
>>>         if (!best_loc) {
>>> -        r = svm_migrate_vram_to_ram(prange, mm,
>>> +        r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>>> prange->last,
>>>                       KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>>           *migrated = !r;
>>>           return r;
>>>       }
>>>   -    r = svm_migrate_to_vram(prange, best_loc, mm, 
>>> KFD_MIGRATE_TRIGGER_PREFETCH);
>>> +    r = svm_migrate_to_vram(prange, best_loc, prange->start, 
>>> prange->last,
>>> +                    mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>>>       *migrated = !r;
>>>         return r;
>>> @@ -3468,7 +3517,11 @@ static void 
>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>             mutex_lock(&prange->migrate_mutex);
>>>           do {
>>> +            /* migrate all vram pages in this prange to sys ram
>>> +             * after that prange->actual_loc should be zero
>>> +             */
>>>               r = svm_migrate_vram_to_ram(prange, mm,
>>> +                    prange->start, prange->last,
>>>                       KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>>>           } while (!r && prange->actual_loc && --retries);
>>>   @@ -3571,7 +3624,6 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>           bool migrated;
>>>             mutex_lock(&prange->migrate_mutex);
>>> -
>>>           r = svm_range_trigger_migration(mm, prange, &migrated);
>>>           if (r)
>>>               goto out_unlock_range;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index 9e668eeefb32..83acd4e8c4a1 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -88,7 +88,9 @@ struct svm_work_list_item {
>>>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>>>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>>>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
>>> - * @actual_loc: the actual location, 0 for CPU, or GPU id
>>> + * @actual_loc: this svm_range location. 0: all pages are from sys 
>>> ram;
>>> + *              GPU id: this svm_range may include vram pages from 
>>> GPU with
>>> + *              id actual_loc.
>>>    * @granularity:migration granularity, log2 num pages
>>>    * @invalid:    not 0 means cpu page table is invalidated
>>>    * @validate_timestamp: system timestamp when range is validated
>>> @@ -98,6 +100,7 @@ struct svm_work_list_item {
>>>    * @child_list: list header for split ranges which are not added 
>>> to svms yet
>>>    * @bitmap_access: index bitmap of GPUs which can access the range
>>>    * @bitmap_aip: index bitmap of GPUs which can access the range in 
>>> place
>>> + * @vram_pages: vram pages number in this svm_range
>>>    *
>>>    * Data structure for virtual memory range shared by CPU and GPUs, 
>>> it can be
>>>    * allocated from system memory ram or device vram, and migrate 
>>> from ram to vram
>>> @@ -135,6 +138,7 @@ struct svm_range {
>>>       bool                validated_once;
>>>       bool                mapped_to_gpu;
>>>       bool                is_error_flag;
>>> +    uint32_t            vram_pages;
>>
>> This should probably be uint64_t to be future proof. npages is also 
>> 64-bit. Maybe add this next to npages.
>>
> ok, will do.
>
> Thanks
>
> Xiaogang
>
>> Regards,
>>   Felix
>>
>>
>>>   };
>>>     static inline void svm_range_lock(struct svm_range *prange)
>>> @@ -184,6 +188,7 @@ void schedule_deferred_list_work(struct 
>>> svm_range_list *svms);
>>>   void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>>>                unsigned long offset, unsigned long npages);
>>>   void svm_range_free_dma_mappings(struct svm_range *prange, bool 
>>> unmap_dma);
>>> +
>>>   int svm_range_get_info(struct kfd_process *p, uint32_t 
>>> *num_svm_ranges,
>>>                  uint64_t *svm_priv_data_size);
>>>   int kfd_criu_checkpoint_svm(struct kfd_process *p,
