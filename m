Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABA4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 14:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D4B10EFB7;
	Thu, 31 Mar 2022 14:38:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C7F10EFB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 14:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbB0Xn+cyQMoJ7dscJtFJWsAFp8DGQTluQK6Nq7tmM8sQE/HfDsX8IXMf1UJRIclcPLaQwkOXvhf2XzAxYSGq5ttXkVC+/EC+P+/h6BenL/NObJ83MJoUjFg75q+4YPFnhjHMSYqwxbaSKYq2ne1pBmSCR26h2pHGEv3U3QWeuJmq/7JsXFUS0wGefHT396kRBMQCxIuYoFC7Qf6Kkq8v4YzHUGQPD7krL8sx1CKl7tLxTRSE3uk28XzyEzEXHSvW546VY4Y1qn/FcKizOBgJ8aDV086kcF5CmmBwqvooFK92gIJBiUvBYei7lXvfjuLx67TA4GcFt+GYaLx3Rq6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4IC0p+NhFyNe/scccqXCsxzC3b1+s1U+l8Aouaf228=;
 b=f0mgDILEZbaWSL0JACS+CVwA8o53I7hBbb1Tkh4PZc0tbXRhuMev7FNOvd8j9jPUE9ikTxyQxXT1mAxROIM0jy9L+46pEzwzMJiuJOEjMcY6QLcCQfrma+RmExCYiFHi0EODjDNmi/yUtzL3xmh7kr1uvbgSfBZ3+FOR53E5xLT1C6cECjqmHihKuzFMmVqoihZ6yHu4ckzUY4JsvhixOJ5c5ZaceVH8QU/RcgHaLWfjspSJFGLMbErn2a14gygeI6vrnWDmsMBfTVIKjbl2nANmOLwUbQM4FM3OaYhnGpYOWVVlMxEe+Pqjn1QpMrwiAcxZh+k35rlM+H4R/4kOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4IC0p+NhFyNe/scccqXCsxzC3b1+s1U+l8Aouaf228=;
 b=YgC8ycywukSvqEW+YeHAB99SZJmhLb1E0+EfzTrvPd9Z0o205iEiH8IIUSIuZbMD8FLanFKmjsE9PmCnKWT+r85zuTcc2C415nAvS58B68lsQfJ4cLG5SPIRBoP1KRR4k6RTkN+WXWa/BBfUwT92q2FZnQiPMa7WC2/OSNP0W3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR1201MB0230.namprd12.prod.outlook.com (2603:10b6:910:1e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 14:38:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%3]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 14:38:01 +0000
Message-ID: <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
Date: Thu, 31 Mar 2022 10:37:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: fix TLB flushing during eviction
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip.Yang@amd.com
References: <20220330090032.16218-1-christian.koenig@amd.com>
 <d1191314-478d-cacd-76b3-14a39157231c@amd.com>
 <e957191b-789d-af36-6951-049f038bc47c@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <e957191b-789d-af36-6951-049f038bc47c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a82499f8-21b5-408a-f836-08da13240ea1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0230:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02309A5B64FD4F5DC48E856492E19@CY4PR1201MB0230.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9MJo4n/sgkxH7XtNQbbVS2aWa+UJVlNkKMH0nWk1gYDfZf7gLXtgrcUHpRgpJxPAjxnNZDNlO2VOzkdt45WpGCVCorIw/eZMLK26Wkod97gD3vvbuc461LHfz6dZV/vGVfDBcpVeVW2ndNOO8pbPLK0I0rJWczuCD+U07kljxMmm5O0Vl/PzLJhnzfRgQVfkIGcAAtZ58Wsx61NXIIB6WIg/xUBhTXe11tz1ylrrIbbuV/+/IlesLBGZGebsfgrfOm8YGcVgOTPdGl8/f+3ensi2IZM8fCFwRaEEPk6yBdDyDSvKLZJtUHuohxSxeALtOpD+0GvTE9wOwMgqYn7zf12IRq1KqP5nhvS4YPDEtcK+caKEYb9ynhQiiC+q8mjHxGbvBYGdOcu2Vn/f97i4njdC21k+bgroTm6N9j68GiTXSemBaRPsOddn4Y3p47gsY9B9ruMX9/EeFQ7BeIjOkqKAa7/VeBhQkiJ1Qpnc2n/EH79wRK8iM4QAECZEi71xxlzYPMUFKYVBDwmbZ4I+a1smiV92fFeVMDdwXR+P1kohcD5CR6QnAsq4/GHienZY/CgV/PvGK7Of5rgCVsSuN5pLQNJkBAdtf9ZlTftE+zrb7PvgNgFMWY9fECAlPN0zeHet2RWFJlUDT6ljdY2elCrYQztGqb3CdSqFzwy98Qsv8sd/tzl+6qNDI/pc0J2fxkKMFJ8HoW9ENmBV4f/ANhtzXX1wSbV9u9yRrvwPuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(5660300002)(44832011)(30864003)(31696002)(53546011)(508600001)(86362001)(6512007)(6486002)(2906002)(6506007)(4326008)(8676002)(66476007)(66946007)(66556008)(186003)(26005)(2616005)(6636002)(110136005)(83380400001)(36756003)(66574015)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTF6N0lIZUFjbUpJa0JSY1d6T2tCT1JabmZGdzhSZmpoZzAwTjNsQVlPdmEv?=
 =?utf-8?B?UTlYWHpXZEtFTGFOY2hjQ0pNVjhJRDdocDNtRnN3Zm5aaW1WRThMbzZGUXNU?=
 =?utf-8?B?WmtZRWNDdFVHcDVPNVZ0WGFVTUsyQXlTUjhwcXpPcGg1OUNERzZ0d21QN283?=
 =?utf-8?B?bEpFTDFlMlBtZ2d4dUs3bkpudU1XQ1JycUdqUDM3VHZ5VWl0dGVYSTlkRVFB?=
 =?utf-8?B?N2dkQlhua1htcDlHQnR0WmgwNm9nRC9JbVhQVVBDMC8rVUJ2VUNORmZ0UW1w?=
 =?utf-8?B?MlpqOUlaa0g4OHpCMk1rZ0sycGU5cnhSZ0VpOVFiQzBoZExjanFtWjNta296?=
 =?utf-8?B?ajd2VVhvTlhxL2hYczhLVjhBa3dQL1ZoMWFZYVlkWVp4TXdCZDJIaDNtK255?=
 =?utf-8?B?YTZBNHd6S3h3ZUtTbHhrQUtHUGp0TGxqZzZKWTJTMzdNdkhzRFIzL1JHMkZu?=
 =?utf-8?B?aU1xNS8wc0RlbldpRzB0OEh4RUhPcVVzS1BtUkVtcW82NDRkY2xKTnpCdlln?=
 =?utf-8?B?a3FRK1BXL2o3M1lrTGxFWjZ4YlZ2YnBnNm5nSXNJWjZYajY4NWFxS2VJbFBU?=
 =?utf-8?B?UXhRV2hXYVJCMEF3TWpPbFRZL2ZESlAyMk16NXErdEMrY3c3NXJjbmlTMUh0?=
 =?utf-8?B?Vk03TU1hUDlkV0VjV2FWdVpkWjdCbzRJczRCUW14NllXc1RrbVFIZ0VkczlM?=
 =?utf-8?B?T2laVUF0ZTlIUzgxNHllOXlFOEh3RWtndk1kNCtNbE9zSExaMHRmVE5wQXhT?=
 =?utf-8?B?dTh6SitUc3FCSjFvTk5zZUhpcmIxM3oreDFCOTZjbjJvdWs5QW52Z3NDeWpI?=
 =?utf-8?B?M0dBdVR5NG4zTEtBU29hYmxFbmVaUDFGME1DZG41UVNDLytXYkFDTnR1bjRQ?=
 =?utf-8?B?dnVMVmZOdzV6YnZYcUdNbnl0TjB6TGZoQzFrdWplRDAzNjhrZFRoSmtwNXpn?=
 =?utf-8?B?cFNSSlVac3B6S2F3YkhhVThwMjcyTW5qUEgyZTZtWEgvYis4Q1FpckZaQjBO?=
 =?utf-8?B?d1RlZDZyL3FHeFNZaWVQamw2blU5OUdIZEZkMEFXNEQrVXRrYitRL0Ywcmxr?=
 =?utf-8?B?cHltWjExcUQzRlkrckU3cWxTdURVRWxmRXN0TG1TMmk0Y0I2YkcyZmVPQ3hK?=
 =?utf-8?B?djFlTERXZXVyK1VwdkxoQkhqQzZqVjZueEVwUXZ6akdHT213OFhVaVVZSFlS?=
 =?utf-8?B?UE1tY1JodTFBdFVsQkZrQmh3a05tLzlmTUlyc1owWXNSUVBOa2REZm14MThE?=
 =?utf-8?B?UlJ1T2o5Z21sV3JvbytCV3p5YnJOS20vdkR0czliS1JsUFptdjJoLzBtcnA0?=
 =?utf-8?B?SEZncmtvWVo3QUpKcXk1NW5QZkdOdkQ0eFByeUxEMVVIMWUrd1F0aE5jTU1K?=
 =?utf-8?B?dHlURldhdTB1UjMzOHlWN043KzN6WHJhRWlzZ2tJK0E2Y2dxbG1TblVVaWVC?=
 =?utf-8?B?Sml5SS9JTHdCbTVDVi9EWlhFbFNqaVBHbE1teXh3eDRlVEUvL1RYdEx2eHIx?=
 =?utf-8?B?dkZ4RHpLbDhvZGZHWThKZUhBa1VHa3k2Nnk5cUZYNDFFVWw3a1FrZUpJYWJF?=
 =?utf-8?B?ZGx4K0x5Y3hhRE0xRStXWUtsdlFnb0tQV1dvYURlNU5pM3M1c3k2MmJSSFBI?=
 =?utf-8?B?NERJdEt2ZWtlY0RKVXY4b2MyNmtQNjhyeGFZVmhWaFBVWjV5TTRDdVA1YVFU?=
 =?utf-8?B?WnNJQXJoN0lGU3ZrRUtIY1Axd0l3aGdSMndrREluTUcrNXJvTTJBT3ZDdXIr?=
 =?utf-8?B?NE1IbG1qNWZBNVNvTHJnSXhxZlk1QWdZaE1xazRPRVVUdGhKUlJGMUpneGVD?=
 =?utf-8?B?Z0hYZnJpUHFGZFNEY0kyTlNlTkE4aVQ3MkpZS2xGdlJ1cW0xVlFmZGZ5RGNV?=
 =?utf-8?B?ZVUxMERKbWFtNlNzR0xjYSs5QVloRFVJN0hPTFkzMjhCZkNsdFF6SlFPUDhO?=
 =?utf-8?B?YjMxVks2d09oeHptMFVxQ3RwSlByMlQ2TDFOMnQ4UHZnUWszVkJrV2NVcXg1?=
 =?utf-8?B?aGF4Mnl3NlRSSzBPUnVCK1dHMVpDdmZuTEdlOW44ZU1BNTV5Y2NiRU5ZZ3hY?=
 =?utf-8?B?SlNZeGVyYnNvSnE5czJjNGR3YUZHeGxpK2ZoMUZzelVZRCtYUlhnTm1JRHJY?=
 =?utf-8?B?M2pGMUc3am1uYnBGZWlrSENHejRRejJ3M1VveDlJTEVDNkpFTm93d3FpTnlJ?=
 =?utf-8?B?RnhBUWpsS1VZT3ZBeENWcUlEdVRhS1AxQmh4dUpKRGltTWlsM2pjdUg2L1NS?=
 =?utf-8?B?ZjJnQytHOXN4WE11MUtXaG9NdFJUZHg1RDAyTnVNam42TGFrZ1ZXK1prenB2?=
 =?utf-8?B?Z0RBVTBTbGZDREdNSEpXalgrRGJnY0ZuZDZjYjljdVlPOVBlQjh0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82499f8-21b5-408a-f836-08da13240ea1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:38:01.2530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQqCU211AjBLNihGB1UDtMee/LmVaiIcp8zT9uJ3066QU1y562KjSyutiJgLeL7QydRF90bcE3ny+4rrpB1G4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0230
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-03-31 um 02:27 schrieb Christian König:
> Am 30.03.22 um 22:51 schrieb philip yang:
>>
>>
>> On 2022-03-30 05:00, Christian König wrote:
>>> Testing the valid bit is not enough to figure out if we
>>> need to invalidate the TLB or not.
>>>
>>> During eviction it is quite likely that we move a BO from VRAM to 
>>> GTT and
>>> update the page tables immediately to the new GTT address.
>>>
>>> Rework the whole function to get all the necessary parameters 
>>> directly as
>>> value.
>>>
>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63 
>>> ++++++++++++++------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 18 ++++----
>>>   3 files changed, 48 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 9992a7311387..1cac90ee3318 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -793,18 +793,19 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>> dma_fence *fence,
>>>   }
>>>     /**
>>> - * amdgpu_vm_bo_update_mapping - update a mapping in the vm page table
>>> + * amdgpu_vm_update_range - update a range in the vm page table
>>>    *
>>> - * @adev: amdgpu_device pointer of the VM
>>> - * @bo_adev: amdgpu_device pointer of the mapped BO
>>> - * @vm: requested vm
>>> + * @adev: amdgpu_device pointer to use for commands
>>> + * @vm: the VM to update the range
>>>    * @immediate: immediate submission in a page fault
>>>    * @unlocked: unlocked invalidation during MM callback
>>> + * @flush_tlb: trigger tlb invalidation after update completed
>>>    * @resv: fences we need to sync to
>>>    * @start: start of mapped range
>>>    * @last: last mapped entry
>>>    * @flags: flags for the entries
>>>    * @offset: offset into nodes and pages_addr
>>> + * @vram_base: base for vram mappings
>>>    * @res: ttm_resource to map
>>>    * @pages_addr: DMA addresses to use for mapping
>>>    * @fence: optional resulting fence
>>> @@ -812,17 +813,14 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>> dma_fence *fence,
>>>    * Fill in the page table entries between @start and @last.
>>>    *
>>>    * Returns:
>>> - * 0 for success, -EINVAL for failure.
>>> + * 0 for success, negative erro code for failure.
>>>    */
>>> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>> -                struct amdgpu_device *bo_adev,
>>> -                struct amdgpu_vm *vm, bool immediate,
>>> -                bool unlocked, struct dma_resv *resv,
>>> -                uint64_t start, uint64_t last,
>>> -                uint64_t flags, uint64_t offset,
>>> -                struct ttm_resource *res,
>>> -                dma_addr_t *pages_addr,
>>> -                struct dma_fence **fence)
>>> +int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>> +               struct dma_resv *resv, uint64_t start, uint64_t last,
>>> +               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>> +               struct ttm_resource *res, dma_addr_t *pages_addr,
>>> +               struct dma_fence **fence)
>>>   {
>>>       struct amdgpu_vm_update_params params;
>>>       struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>>> @@ -910,8 +908,7 @@ int amdgpu_vm_bo_update_mapping(struct 
>>> amdgpu_device *adev,
>>>               }
>>>             } else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
>>> -            addr = bo_adev->vm_manager.vram_base_offset +
>>> -                cursor.start;
>>> +            addr = vram_base + cursor.start;
>>>           } else {
>>>               addr = 0;
>>>           }
>>> @@ -927,7 +924,7 @@ int amdgpu_vm_bo_update_mapping(struct 
>>> amdgpu_device *adev,
>>>         r = vm->update_funcs->commit(&params, fence);
>>>   -    if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {
>>> +    if (flush_tlb || params.table_freed) {
>>
>> All change look good to me, but when I look at previous changes 
>> again, kfd_ioctl_map_memory_to_gpu is not correct now, as this should 
>> flush TLB if (!kfd_flush_tlb_after_unmap(dev)).
>>
>
> That was intentionally dropped as Felix said it wouldn't be necessary 
> any more with the TLB flush rework.
>
> Is that really causing any trouble?

I discussed it with Philip offline. The TLB flushing in 
kfd_ioctl_map_memory_to_gpu is still there, but it is no longer 
conditional on !kfd_flush_tlb_after_unmap. Instead kfd_flush_tlb checks 
the sequence number to find out if the flush is needed (presumably 
because we didn't flush after unmap).

There is one case on Vega20+XGMI where PTEs get inadvertently cached in 
L2 texture cache. In that case, we probably need to flush more 
frequently because a cache line in L2 may contain stale invalid PTEs. So 
kfd_flush_tlb would need to ignore the sequence number and heavy-weight 
flush TLB unconditionally in this case.

Regards,
   Felix

>
> Christian.
>
>> To fix it, seems we need beow change, then pass flush_tlb flag via 
>> kfd_ioctl_map_memory_to_gpu -> map_bo_to_gpuvm -> update_gpuvm_pte -> 
>> amdgpu_vm_bo_update
>>
>> -int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct 
>> amdgpu_bo_va *bo_va,
>>             bool clear)
>>
>> -    bool flush_tlb = clear;
>>
>> +int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct 
>> amdgpu_bo_va *bo_va,
>>             bool clear, bool flush_tlb)
>>
>> + flush_tlb |= clear;
>>
>> Regards,
>>
>> Philip
>>
>>>           tlb_cb->vm = vm;
>>>           if (!fence || !*fence ||
>>>               dma_fence_add_callback(*fence, &tlb_cb->cb,
>>> @@ -1010,9 +1007,10 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>       dma_addr_t *pages_addr = NULL;
>>>       struct ttm_resource *mem;
>>>       struct dma_fence **last_update;
>>> +    bool flush_tlb = clear;
>>>       struct dma_resv *resv;
>>> +    uint64_t vram_base;
>>>       uint64_t flags;
>>> -    struct amdgpu_device *bo_adev = adev;
>>>       int r;
>>>         if (clear || !bo) {
>>> @@ -1037,14 +1035,18 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>       }
>>>         if (bo) {
>>> +        struct amdgpu_device *bo_adev = adev;
>>> +
>>>           flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
>>>             if (amdgpu_bo_encrypted(bo))
>>>               flags |= AMDGPU_PTE_TMZ;
>>>             bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>> +        vram_base = bo_adev->vm_manager.vram_base_offset;
>>>       } else {
>>>           flags = 0x0;
>>> +        vram_base = 0;
>>>       }
>>>         if (clear || (bo && bo->tbo.base.resv ==
>>> @@ -1054,7 +1056,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>           last_update = &bo_va->last_pt_update;
>>>         if (!clear && bo_va->base.moved) {
>>> -        bo_va->base.moved = false;
>>> +        flush_tlb = true;
>>>           list_splice_init(&bo_va->valids, &bo_va->invalids);
>>>         } else if (bo_va->cleared != clear) {
>>> @@ -1077,11 +1079,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>             trace_amdgpu_vm_bo_update(mapping);
>>>   -        r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, 
>>> false,
>>> -                        resv, mapping->start,
>>> -                        mapping->last, update_flags,
>>> -                        mapping->offset, mem,
>>> -                        pages_addr, last_update);
>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
>>> +                       resv, mapping->start, mapping->last,
>>> +                       update_flags, mapping->offset,
>>> +                       vram_base, mem, pages_addr,
>>> +                       last_update);
>>>           if (r)
>>>               return r;
>>>       }
>>> @@ -1104,6 +1106,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>         list_splice_init(&bo_va->invalids, &bo_va->valids);
>>>       bo_va->cleared = clear;
>>> +    bo_va->base.moved = false;
>>>         if (trace_amdgpu_vm_bo_mapping_enabled()) {
>>>           list_for_each_entry(mapping, &bo_va->valids, list)
>>> @@ -1272,10 +1275,10 @@ int amdgpu_vm_clear_freed(struct 
>>> amdgpu_device *adev,
>>>               mapping->start < AMDGPU_GMC_HOLE_START)
>>>               init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
>>>   -        r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, 
>>> false,
>>> -                        resv, mapping->start,
>>> -                        mapping->last, init_pte_value,
>>> -                        0, NULL, NULL, &f);
>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
>>> +                       mapping->start, mapping->last,
>>> +                       init_pte_value, 0, 0, NULL, NULL,
>>> +                       &f);
>>>           amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>           if (r) {
>>>               dma_fence_put(f);
>>> @@ -2519,8 +2522,8 @@ bool amdgpu_vm_handle_fault(struct 
>>> amdgpu_device *adev, u32 pasid,
>>>           goto error_unlock;
>>>       }
>>>   -    r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, 
>>> NULL, addr,
>>> -                    addr, flags, value, NULL, NULL, NULL);
>>> +    r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, 
>>> addr,
>>> +                   addr, flags, value, 0, NULL, NULL, NULL);
>>>       if (r)
>>>           goto error_unlock;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 6b7682fe84f8..1a814fbffff8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -402,15 +402,12 @@ int amdgpu_vm_handle_moved(struct 
>>> amdgpu_device *adev,
>>>                  struct amdgpu_vm *vm);
>>>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>>                   struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>>> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>> -                struct amdgpu_device *bo_adev,
>>> -                struct amdgpu_vm *vm, bool immediate,
>>> -                bool unlocked, struct dma_resv *resv,
>>> -                uint64_t start, uint64_t last,
>>> -                uint64_t flags, uint64_t offset,
>>> -                struct ttm_resource *res,
>>> -                dma_addr_t *pages_addr,
>>> -                struct dma_fence **fence);
>>> +int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>> +               struct dma_resv *resv, uint64_t start, uint64_t last,
>>> +               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>> +               struct ttm_resource *res, dma_addr_t *pages_addr,
>>> +               struct dma_fence **fence);
>>>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>>               struct amdgpu_bo_va *bo_va,
>>>               bool clear);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 27533f6057e0..907b02045824 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1188,9 +1188,9 @@ svm_range_unmap_from_gpu(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>         pr_debug("[0x%llx 0x%llx]\n", start, last);
>>>   -    return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, 
>>> true, NULL,
>>> -                       start, last, init_pte_value, 0,
>>> -                       NULL, NULL, fence);
>>> +    return amdgpu_vm_update_range(adev, vm, false, true, true, 
>>> NULL, start,
>>> +                      last, init_pte_value, 0, 0, NULL, NULL,
>>> +                      fence);
>>>   }
>>>     static int
>>> @@ -1277,12 +1277,12 @@ svm_range_map_to_gpu(struct 
>>> kfd_process_device *pdd, struct svm_range *prange,
>>>                (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>>>                pte_flags);
>>>   -        r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, 
>>> false,
>>> -                        NULL, last_start,
>>> -                        prange->start + i, pte_flags,
>>> -                        last_start - prange->start,
>>> -                        NULL, dma_addr,
>>> -                        &vm->last_update);
>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, false, 
>>> NULL,
>>> +                       last_start, prange->start + i,
>>> +                       pte_flags,
>>> +                       last_start - prange->start,
>>> + bo_adev->vm_manager.vram_base_offset,
>>> +                       NULL, dma_addr, &vm->last_update);
>>>             for (j = last_start - prange->start; j <= i; j++)
>>>               dma_addr[j] |= last_domain;
>
