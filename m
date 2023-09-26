Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7790BE7F128
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 20:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C668C10E434;
	Tue, 26 Sep 2023 20:43:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F100410E434
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 20:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay0imMZkeHUj34Nu/JKeiJQbl4gWR/ZnpaoNK7Unw2XCVA+erYWKv4/e/hw63EdpIDS33oDlJVyagTE5s/j3N91wiDy+9bAVmWuSGSN14eXnUN1qm0NKCT6YkEdLy6Mi4ESPV5pzAFgYEHAD9Akg6FolqTh+wXekQkOnBnwXJTJ7n6752Yx1/lVFft7Yi9HJ8iWdaCDDjJlyZkedIkItfJ1PxhRYoIOb1fBa56eddMBHBlP+rAlotiUr95istChuXPVdVPUIuBNrm/Uj+BsH+FKMPDk2ac5R1khCBDexvUqk1kGlrUhVitCsBWE2YloxODf2agzGrXc6er7++JcU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEkHuETMcqi3uCIwpKHvDER/oTzI96lEv98Bct6QhrE=;
 b=EWOpck64c7SRert0ySuv+TchtYnJ2ZmUjENONbCTQ+Tv3oAgxLqZHuLZFKdGDVA2tEK9uLqpVKxKHlGNvaGvJGd5o2h8DMO1Tdyf0Z3m5bz+7lgN4usnffz7BLmsnXXUu0o7A25PABtNkhqAVWjoA5gloFW2SJrlLsp4Y/CUsXB6PDl1qRYuaqzoiMe5KCAut5Llxnb8k5vz/ksAEzPzAAqFvjZPpVmgiQI0Z66c/Vg6ii2JiVLF3r7B5MYsWPA8zkqqY3dj7KhYMbknrjmjHfoaxFiSydOOPQ4Mu8MC23PnoZiKN1tyXXzLVhZijYNz7mFR8cDN1Ywi+jkh3aTg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEkHuETMcqi3uCIwpKHvDER/oTzI96lEv98Bct6QhrE=;
 b=TJzzN/QSE/bjF199D5KWU8BMxBBnmcfkPXkPbVu6+SRfp1AskopeXQdr6kphSJ79/UZe8YTRkXoSHsHR0d5zJREfSL5U/xcgoDHoK+KCWT8qMBkEnT6MJUcFmTtcg/pnyAHNmxAuB34VsAjZIR9t8SNA/5VI7BgRF0mDD8xUGNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 20:43:18 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 20:43:17 +0000
Message-ID: <1d6af500-2a17-0f95-3c86-024cdded0fa9@amd.com>
Date: Tue, 26 Sep 2023 15:43:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Wait vm update fence after retry fault
 recovered
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230922213759.20904-1-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20230922213759.20904-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:408:e3::6) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 7450f53d-e8aa-4c7a-ff5a-08dbbed13690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vt3Hvba05cuKtC63QRpoU4uoBHbSG5yIQn3kCiKYZ9dP5Z392TwS8Y/2xvfWJrZxQk8UO0Wsgt6FlLRuXVv3eAa3nrBEiqhiQbJPWjWl5WIyp4fvuPY02EAcXfNOTDn1AfsiWLCDR68sJWu3D8DDh9shY7DoWpMTssxCqM2IZI38bDcIAzDuanjr8dkANkKiw6Om1vviydfTvzEzwTE5hn5DFBQSrTfNRrEaFIeGkjpJMvBd2xHXThlP/J1wqlHO9g8suEJfNK+5xq7vnwaktak9P0XZPoxAPdCg3AdzTP7mwxtNspU0s6rQw5fG56/fsaLmDOJB0Rhy4K45AmQbhXMFsMtdisQ+SvoPLxRa+XWozYTYt02NSKPXK4ghqsOm5vx8KTKwuGIFvhynzynuZrPVRk1GBmZhMvKZcdiByhCskNQJP7WeKm63nE8GRbae3QXTFjGz9jl5QPKFuZwH1QZ1uGxLkFESvP6mg+DinAB2OhL0G1fWjfi8FwRjsGnsBCD+0gWoFGZNY8c9zHszUN6vxiLP7bCFvc3iacbRsYu76wbqv3FbVqNJ8cZsb7Sc+8GAyzR+uh5AOXc7heI29E2cR9YKq7+ZAA0wqoUHu3TOAZd2oBgNJN/+Dw5c322B32D7ZwVwb2MgwQJm6wf9QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(31686004)(66946007)(41300700001)(316002)(66556008)(478600001)(66476007)(36756003)(38100700002)(2906002)(83380400001)(6666004)(6486002)(8936002)(8676002)(6506007)(5660300002)(4326008)(6512007)(53546011)(15650500001)(2616005)(26005)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUpJRmhmV0lNNTFRNkVyTEdjK0JzOGpRNFdXV0Jlc2JKWFBtK21Xd3p3NGZm?=
 =?utf-8?B?aXh1bXRPUER6K29kSlZEWlcxYmlvR1ZwMXlTbGNkMmppYVVQQVNjZjJGcXBn?=
 =?utf-8?B?K3VpaW9mRkhxS21UaGwrQTFyNXlJZ3NsWjkzNTVZMnhWcVVKS1hBM0gxZ09h?=
 =?utf-8?B?UFlUSm5PSkRVM1Zlb0xRQWpZenZHc21oNS9VbStJYTd2TjViMTlJN2RzSnhs?=
 =?utf-8?B?VDVHN1dVVlh6SVJEanBuOGZ4RUdyLzllR1BMb2kyZk9CZUhVTjUyM2poNmRY?=
 =?utf-8?B?SmFTVmtmd1MvYklxbWMxWXJ2dzY0V0dpWkdROTRuQ002azRGNDdGd2M2QVdr?=
 =?utf-8?B?SVEvcVZXckZXakdpVC9lTDdnMTFzOUZ2dndCUWNMZUYwbVh6RCs2WUE3dXFu?=
 =?utf-8?B?YTdodVJOR1plak92aFNiV2toczNJc1h6djdQbUI5bnl0eFU0OHg1QWVmdEkw?=
 =?utf-8?B?b1NOV2FkclQ1WUdITXFVcmhFbXZKUVNacVRQTVB6K09CODVIeDJSSlVvQ2Vn?=
 =?utf-8?B?MDFCMDJ3RFhXbUI3VXBBUGcybzcxSGEwVzdXTGFqVkZOYjBxZ2xzL1pobnpM?=
 =?utf-8?B?U2Y1dkdjM1FSQkoyMDlNY2lvYWNUMXZKdjdoY1FsMXM1NnpLR05wYjFFZWNZ?=
 =?utf-8?B?Q2N0dDBtc2JmbzEwTlgzblZZZDJ4WUVTaXZkdGRLUTJ3S3I5TURMS0FJUkFw?=
 =?utf-8?B?bUJBREFNNHVNNStVTTZuQkpnenF4cVpnSExxemZvWUQ3Rzc2VFJSemxrRWV5?=
 =?utf-8?B?NzZVQ2NnTGNEQkwyYlRiODZSZWtaZ3dwanQxVGpwbGRkWGJhZUMxc3l3N3Fq?=
 =?utf-8?B?T3dQeS9LRHBoTC9hZUU2cGE5OTVQN1dBeVhCbGNPV2tick9iUEZSNFRRQW1H?=
 =?utf-8?B?ZGxEaG1PeTVNQzY4WUtnNHVVWUhCSU8zbzFub215VUN1QzNhNWhGbW5ubWhm?=
 =?utf-8?B?dkhLNml4dTdsVDBsYno4d1Q3WTEzZUI0RkFvL0ltS3N5NUM2cjJGYzcrVkF0?=
 =?utf-8?B?MEhKdUowVlhpTmFhcEpSeW05VFkvU3dReU9oV0kzaTA0SXRRdUFYNmJlZjlR?=
 =?utf-8?B?RWxjRFIwNDNieVh3anpaZVM0KzNvNGdXTE10U0RGNHlVb000WGZrbXozaXlY?=
 =?utf-8?B?UG03UVVLVnY3VXJVU3ptcXdDenJxOVNNbjFsWjQ4eXdvaVhwUm56aVA1NGNT?=
 =?utf-8?B?Q3J4Nk5Fazh3R253bk81WVVlRklKOWNEQU8rTFBzWkNsSUNYcUJNV1QrQmIx?=
 =?utf-8?B?WFF3YkJLblM5cjN2bk45ZVZCV0pRZTA3ZjJwUzY1aVRvSjRhbWdJOVFrem53?=
 =?utf-8?B?MHJtZ3p5aXBLMzZmS2tZTTRoa1pmdlpZNXlFdkROTUdrMnVyQWdBeWw5RDR1?=
 =?utf-8?B?MHBrWm9Sb00xeFlNUXg1eTFsc1pVaXNOOWljNFVCeUttVk5BUEl4TUNVNzhD?=
 =?utf-8?B?N0w3OHplRnd4Uyt2TkJCMFk0NFVjVjEzK3AxMno1ZFFJWm5nc3FkRE1SZUFn?=
 =?utf-8?B?LzArUWpDa1gvUUIrMG5VR00ybHZDNHhyNEJxQmltK1Qwa1dzcnk0aDlPeTVN?=
 =?utf-8?B?RWVjNk5Rc0t1OW9qZW9CSnhwcmlBenJsb3Iyd1oxRURSdXdlYkNTSEZrdkVx?=
 =?utf-8?B?ZGkycUFpcFJyWGN3UUU2cEhvdHY0YkhEZzBZLzJFa0ZiRVVkcWV1U2pLaXhW?=
 =?utf-8?B?bnVDVjd2TU1wb0NZRzJzNEJRR1BqWmRsdVRTQUVFK0VISjJZR2V5Q0JyMmlV?=
 =?utf-8?B?YWtvWFdyQjc5VGMrenFVTXkwSndTRnpBc0pIMXNuOEJzSGx5UEh3UTdtTXNI?=
 =?utf-8?B?aWkvY2dkSlE0akx0TmtrL01PdEc5cGw1UzdPZjlDeGJIS2t6T2x6V09rYWxV?=
 =?utf-8?B?Z1FWZGlCWGZRTUVrNXRPR2RrUmIvRnpNOGpYbm05T2xIdjFrMzBaRURnRXpM?=
 =?utf-8?B?T0lpcFJCR0NrajMrWVdNa3VFZFV4MGYzUGxydm5wdnlBVTdySUJoalY1NC9Q?=
 =?utf-8?B?TGFPTTFpK2hlKzhzcTRTODRZb2RlY2NiUzVSSUtlK3ZSRDVxZnFFMU9zTGxj?=
 =?utf-8?B?anFVZTdCY1JFRWZvUjEwUUo1NW14ZFBhbXZPdzJoanE5K0RQVE5yb2tOZWN1?=
 =?utf-8?Q?3Nh0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7450f53d-e8aa-4c7a-ff5a-08dbbed13690
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 20:43:17.7375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkDh1NHIRn3iH09Xb01KnvGIBGtjGImA7BlJYcJedejN5I6rO7dMXhpUOZQyXMI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/22/2023 4:37 PM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Otherwise kfd flush tlb does nothing if vm update fence callback doesn't
> update vm->tlb_seq. H/W will generate retry fault again.
>
> This works now because retry fault keep coming, recover will update page
> table again after AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING timeout and flush
> tlb.

I think what this patch does is waiting vm->last_update fence at gpu 
page fault retry handler. I do not know what bug it tries to fix. h/w 
will keep generating retry fault as long as vm page table is not setup 
correctly, no matter kfd driver waits the fence or not. vm page table 
eventually will be setup.

There is a consequence I saw: if we wait vm page table update fence it 
will delay gpu page fault handler exit. Then more h/w interrupt vectors 
will be sent to sw ring, potentially cause the ring overflow.

Regards

Xiaogang

> Remove wait parameter in svm_range_validate_and_map because it is
> always called with true.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 70aa882636ab..61f4de1633a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1447,7 +1447,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   static int
>   svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>                        unsigned long npages, bool readonly,
> -                     unsigned long *bitmap, bool wait, bool flush_tlb)
> +                     unsigned long *bitmap, bool flush_tlb)
>   {
>          struct kfd_process_device *pdd;
>          struct amdgpu_device *bo_adev = NULL;
> @@ -1480,8 +1480,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>
>                  r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>                                           prange->dma_addr[gpuidx],
> -                                        bo_adev, wait ? &fence : NULL,
> -                                        flush_tlb);
> +                                        bo_adev, &fence, flush_tlb);
>                  if (r)
>                          break;
>
> @@ -1605,7 +1604,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>    */
>   static int svm_range_validate_and_map(struct mm_struct *mm,
>                                        struct svm_range *prange, int32_t gpuidx,
> -                                     bool intr, bool wait, bool flush_tlb)
> +                                     bool intr, bool flush_tlb)
>   {
>          struct svm_validate_context *ctx;
>          unsigned long start, end, addr;
> @@ -1729,7 +1728,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>
>                  if (!r)
>                          r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -                                                 ctx->bitmap, wait, flush_tlb);
> +                                                 ctx->bitmap, flush_tlb);
>
>                  if (!r && next == end)
>                          prange->mapped_to_gpu = true;
> @@ -1823,7 +1822,7 @@ static void svm_range_restore_work(struct work_struct *work)
>                  mutex_lock(&prange->migrate_mutex);
>
>                  r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -                                              false, true, false);
> +                                              false, false);
>                  if (r)
>                          pr_debug("failed %d to map 0x%lx to gpus\n", r,
>                                   prange->start);
> @@ -3064,7 +3063,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>                  }
>          }
>
> -       r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
> +       r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
>          if (r)
>                  pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>                           r, svms, prange->start, prange->last);
> @@ -3603,7 +3602,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>                  flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
>
>                  r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -                                              true, true, flush_tlb);
> +                                              true, flush_tlb);
>                  if (r)
>                          pr_debug("failed %d to map svm range\n", r);
>
> --
> 2.35.1
>
