Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A4EC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 18:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C43710E148;
	Mon, 10 Apr 2023 18:28:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D34A10E117
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 18:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhREAnakccgMxkJRUv5ZVKU7YZe/WdyWfu3OnwMKu+wTdskAQWbH0plCOE6Y1iR6m81YL4mpO7UaUYgdMWVwch5k2eSRLDdAi+6qEEhgW+ijvml430k/Eacb8GQJztd7SvNFhHy/T/cHMzhpiQUDWON5orYIRWEVaNBRJ6m3V//wHLq5E1CYu22oq0QHpo1iIKfsz0vHYkKJH1b5C93rHUgVhkYwZiXhpca1mEjHo+TTf0C7rx/pNphlX4bxfZQUn7y/lARAAgaTuffwLRm1smOgHhAaE8C1eAeinlLwpyUc+EAeHoFTU20gzhe1FMPupFO7cRleTl1Fj9g963OTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB13T6VpZCGoEXr2snVaiwwJKObEWKHSri36w9LmVY0=;
 b=j7pydKyvB25D8wVJfo1I9SAq2PEj5Whxq54x+IQcVATjQuQsugl880tt4Onh1Rt5//AhJtCaIpZHh2GVtuBRMxINVTh2UeA4wqPBpyal0D8ITvirEHynqDDs2i29uc8vb0KvUJQ57+7pB5KBW0tMmECoMvyGThQ+jigdvH8YaFD/idj9L9M7JflnDm8/1nj1IieWpUecKu/TAo2oDgHvCwIwqLOH+T4ursKXKuuxOULCaYD/e/eJjb8xdTVtvEhKTFf8nSRl+yfQikRc6zS+QnUXnzv3189akaj6oEsMsO4jigmKhNzg0GzDf3Iae1O/jntUmstpEAqYTZNlus7r9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB13T6VpZCGoEXr2snVaiwwJKObEWKHSri36w9LmVY0=;
 b=3v5KTvaSyJthV3W6OP+QWtbjq7tPmLJL0DFqhmmSfTOEoABP3K6nL25b9W5CG8mN0A9hWCUo8ejDEwR8LCXFl8EUcB2l1N4PWANzL5I1RBjtoB9GeOs2Zcd80fMA/CBqnHvS1ONN15ooFUt4irkx0OSWeWJEwEnPxKjOWbJcjVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Mon, 10 Apr
 2023 18:28:19 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d5f4:ed47:53c1:ef9c]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d5f4:ed47:53c1:ef9c%6]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 18:28:19 +0000
Message-ID: <4aa3ad89-ed94-bf74-62ef-193bc3a5d6b3@amd.com>
Date: Mon, 10 Apr 2023 14:28:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdkfd: Fix dmabuf's redundant eviction when unmapping
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230403175949.131530-1-jinhuieric.huang@amd.com>
 <91875e99-89f0-5a5e-03fc-d08d3240c869@amd.com>
 <04845a1f-c602-b796-eeba-c12a91d4401e@amd.com>
 <4a3bfe1e-2c8b-198d-23bd-035e6d78372e@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <4a3bfe1e-2c8b-198d-23bd-035e6d78372e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf3a049-70df-47ba-5f60-08db39f15be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbmvhIOFe483b7VPLDnUf0ITwI+k/4/rwLenJc3bD5ZEhK7Z1ZIHiEjcix0bn3/EpbeweRH19yKMsZqPzqL7So4tdzYd8LAHGG+WLpl3PsyLQlCs5TkmqYcC7lFKM5YriqcVoqlLLxwT/WVnWVi9RI64SH6BsTikdLfZYh9lay8UQgAeKi9oXjPzVq/kvrrGv9nIYGfLr+r48hf2U1vK60BzMjXKgf9CfvvLixO0tgZ6GLkvE892G5jPfbQ7h4hcWoiowZ6Rvwl2df//tjjtmb6OjNqzJpBN+WJ+J89+WQn4t4UEZTbXUbYR35u9puCiO8S68ho4QzRh2BdtyuQIIHelGdFBSPvk+gjEbY3z3/m80Hb+3YCNEAZEYR2/kwMKQHHKI0ZwSxNtbWR3YU7LA4eBha/tTBJkGv/OKoeGufPnq8d2NYy+xvN51d7jEKotLwxW0qPCSF80H/eeEFKwc0Fw6lsw14xR1FIsgDjbMo7mnPeIyLwhfamc7V5ieaNBJRVDVGIdzTQbT7NXy22C+iHUPqQc42iSRj3jyCL2fJBEI1x/NQeXZbGbk6CVyaEpGYvD7wyg+IpAEY09cokH8rDzmw5mQx++a2rDCzzGyUy7JJ2K+yfbETQUYb8Nbg+PEYhadDGR5ZLhqGCGj2Q7Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(31686004)(26005)(38100700002)(110136005)(31696002)(6486002)(66946007)(66476007)(8676002)(41300700001)(66556008)(36756003)(6636002)(86362001)(478600001)(316002)(83380400001)(6506007)(186003)(53546011)(6512007)(5660300002)(2906002)(8936002)(2616005)(30864003)(45080400002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1oejVaVWJad3J3aVdFemJldDVHOFZsSmJtdXlKZUE2ZWVoN1ZKemxDSHI2?=
 =?utf-8?B?T012OU0wVFpUaGhiOXJIMm1EZkMvS0luRkpyV3kxaXV5VVdKcHhqQUF2M045?=
 =?utf-8?B?NVpUVkQ5Q3JYNTJlT3dUSTRvMmtPdmVDa1lTRStoSTZnYmRydVdIRzcrTHRY?=
 =?utf-8?B?UTRTN0ZDVGtrMFF3Q0RPeTRhMFJpQitJY2M1bi9oMTRCUU5xOWp2aHY4elhq?=
 =?utf-8?B?VDdhTXRWSXRKdjU0Qk15ckZJMjd4aTV2cjdMbHdMSUdOMks3TmExcFViTyt6?=
 =?utf-8?B?WFZVL3BpdmdybUNtbGxENWhNakh4eFluT05PbS9pTEZRZEFLbTcrMk9TWVA0?=
 =?utf-8?B?SlNPRUdXN2JMeXNZcTBKK3ZkTFIxK3NSZm5nYWlQeU1aMnpURGtyZG9yWFpR?=
 =?utf-8?B?SVUwNDZ5czVSUTFWSWR6U3RKUkl2MWV4NkMvbGhRbld1eXhVOEQxcTBQeDh6?=
 =?utf-8?B?OFRPUEtiS0tMOFlqL2oxT1dJOHM1bFBkM2d4azJ5Yjhxb3owb3FpOGpmZlNh?=
 =?utf-8?B?ZGUzY0xJaEFyY0YrWW1Ta09vNkJGUEM5dDJQbEVWekhCMUxKSUpFL2FuQlpW?=
 =?utf-8?B?Umd2YXRjem5TbVdKOEhQaG1LK200WGszOE4rQy9INXorWnBEQnNSc2pVdHVL?=
 =?utf-8?B?ZWVxRE1CVCt3Y1JBMGxDbklRcGdnUlp5bGNFWlJrM2NWZ2hlajBsNlI5dEVw?=
 =?utf-8?B?VGhRSkExc2hkb2xwRGU5OE14MmROdHp6bHRPajZWZitLaDZtNmhaaWoxeEM0?=
 =?utf-8?B?Vlc4a2FjTUtIbFkwQzBDVFM1aG1CMzJZVzhYajVVaXJLWHFwZTBvd1htbWRT?=
 =?utf-8?B?bEp2MUIyaU9RWlpRN3lIV2dETkZnTUFoVnlZbC8rNkV2SnNPRFp1Y05WbSsy?=
 =?utf-8?B?Qjh4Qnd3d0Z2N1RvdnYrNVQyQXJxdE42RWQyWGdTQ0NlZVJzOGppZXZWVyt2?=
 =?utf-8?B?dkVITVBXc2RUamhka3Y1bTV5OU11YU5qcnhldVZCZCt6TlEyK1NnYUdSNHU4?=
 =?utf-8?B?T2haYWNsMUZqZkpvd2hjR2wvMWEwUXpWdS9uYWF1Ujk3MkhIbzllT3JuTmZx?=
 =?utf-8?B?Y1ZxN3hNNHdHdGVxVkRldVR1YXZxOGFQdGRpL2ZQWHRLd2l4dGF3S3p3aXVS?=
 =?utf-8?B?YmVaMnBtYWtJTFBCWTRSQ3Z3Sll0NHZFTTQwT25Hbi9zaWloa0UrR2hnZENw?=
 =?utf-8?B?RzdRU0NtcW9FTjdFZmtHWlBrYUhMeTJSc01OR1Y3cDNFQVBGYlpYTW5Kc1FQ?=
 =?utf-8?B?TXJ4K0M0NEhMbHAyUjBjWUpVS0tnNGkwNnYzeVhkdmVoeTk2QmVkZGZJTDIv?=
 =?utf-8?B?Y0hpRUx4UE9tQkpUcnFMSjVrRWVHMHQ3czd1ZC9Ndyt0TE5yUjBNRFNKVnIw?=
 =?utf-8?B?R0FvMkVmdXg2YlE3U3RMQjcrbVVyV0RWc2pqZThnRzFVVFh0RUlDSE9YdHJu?=
 =?utf-8?B?d3E4WmdSa1ZHQkNSSVpLSG9oUFdLM21aQi9IdWlsQlIzUWdrK3lKTWU5S05i?=
 =?utf-8?B?VlBRckwrRGpMbVVZYjRiVmltZXFIRDgvNGFBdWpEdm5TYVVDM3FkQmJyamcw?=
 =?utf-8?B?RkdnUEFqYktQRW9Hb1g4UkN5Yzk1QzkyVFNTZ3d1UnhMaHo2anYySWVCNDlL?=
 =?utf-8?B?QURQTmh0NkdtQXpINGI3SkpiNVNLSXhKYWhhOFNLL2FTQ1pKdEp2d2NDbXMz?=
 =?utf-8?B?VzRqMUVrRzFwMHVsemlvYTNLaDZoWkp3a1c3YUJLVVZMajRHdTNMbks1d256?=
 =?utf-8?B?WmNBNWd5WU5xdVpHM2xldXpGWGRoY3R3VTVJbTBJN2Z5ZWlpSkh5ck5wV0t6?=
 =?utf-8?B?MS9vYU1HT0xYQU52RHpMS3pSVlVtQjhIYW0zZXVMWkN4T1MyTUphcUVOVkh3?=
 =?utf-8?B?RE5nNjRTbmFJQVhlcFNXemdkb1o1ZWNZY2Iva3E0QVJsVk9PY2IzM3F5M2Nk?=
 =?utf-8?B?RkdDcitQWFlBdFFRaEtob0ZwOE1nN1pNaE5HN3F6QTA5MGFOUy9CK3VyWlFm?=
 =?utf-8?B?UFlUTDNrbG5JamFoVDJZSkNTakFZeFN2WTdhWDBsRE52MFJhQWdObFZBSVB2?=
 =?utf-8?B?WEhRUWR2cU81cnZTTEdzSjgvU3hPOU9JNDZQM1ZnVkgwTXJvaG1WbXUrbXNM?=
 =?utf-8?Q?zpdfv/ts8v8CILqNPueAS3POP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3a049-70df-47ba-5f60-08db39f15be1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:28:19.7328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFS9Tm3S3UStdYu0IvR/PrmHCe+Oc6mHo0XUFyNqWrVVatbz/MaiyJPNZO+goB9UE1OfF3jCiV4f4qE7NruIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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

Hi Felix,

Thanks for your review and suggestion, but unfortunately the 
AMDGPU_GEM_DOMAIN_PREEMPTIBLE is not defined in amdgpu_drm.h. I 
understand we need the memory eviction on either kfd_mem_dmamap_dmabuf() 
or kfd_mem_dmaunmap_dmabuf() to update DMA address, so I am thinking to 
do it as simply as userptr memory does.

The purpose for this change is for non-MES HW scheduler we are using 
userptr/paged memory, but since GFX11 we will be using MES scheduler and 
it needs the memory to be allocated as GTT/non-paged memory, so we want 
all GPUs using GTT/non-paged memory, but there is performance drop, 
because of eviction in kfd_mem_dmaunmap_dmabuf.

Currently userptr memory is evicted in kfd_mem_dmamap_userptr as 
changing domain to GTT before calling ttm_bo_validate, and not evicted 
in kfd_mem_dmamap_userptr, so I think we can do the similar way for 
GTT/non-paged memory that setting domain to CPU in 
kfd_mem_dmamap_dmabuf, which will evict memory to update DMA address, 
and setting domain to GTT in kfd_mem_dmaunmap_dmabuf, which will not 
evict memory. The performance should be the same as userptr/paged memory.

Regards,
Eric

On 2023-04-04 16:40, Felix Kuehling wrote:
> [+Christian]
>
> OK, this comes from the ttm_bo_wait_ctx call in this section of 
> amdgpu_bo_move:
>
>         if ((old_mem->mem_type == TTM_PL_TT ||
>              old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>              new_mem->mem_type == TTM_PL_SYSTEM) {
>                 r = ttm_bo_wait_ctx(bo, ctx);
>                 if (r)
>                         return r;
>
>                 amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>                 ttm_resource_free(bo, &bo->resource);
>                 ttm_bo_assign_mem(bo, new_mem);
>                 goto out;
>         }
>
> We can't just remove this wait. It's not even specific to KFD or 
> DMABuf imports. We also can't just change it to avoid waiting for 
> eviction fences because it's also used for GTT BOs (e.g. before a BO 
> gets swapped under extreme memory pressure). So we also need to 
> trigger the eviction fence in general case.
>
> In the specific case of DMABuf imports, they share the reservation 
> object with the original BO. So waiting on the reservation triggers 
> the eviction fence on the original BO. I think we want to avoid the 
> waiting on eviction fences for all BOs where the underlying memory is 
> managed by some other BO, and at the same time also avoid ever 
> evicting the DMABuf import BO. That's what AMDGPU_PL_PREEMPT is for. 
> So I think a combination of two changes should to the trick:
>
> 1. Change kfd_mem_dmamap_dmabuf to use AMDGPU_GEM_DOMAIN_PREEMPTIBLE
> 2. Add a special case in the above if-block for old_mem->mem_type ==
>    AMDGPU_PL_PREEMPT: use amdgpu_bo_sync_wait with
>    owner=AMDGPU_FENCE_OWNER_KFD so that it doesn't wait for eviction 
> fences
>
> Regards,
>   Felix
>
>
> Am 2023-04-04 um 10:36 schrieb Eric Huang:
>> Here is the backtrace from Jira:
>>
>> Thu Nov 10 13:10:23 2022] Scheduling eviction of pid 97784 in 0 jiffies
>> [Thu Nov 10 13:10:23 2022] WARNING: CPU: 173 PID: 97784 at 
>> /var/lib/dkms/amdgpu/5.16.9.22.20-1438746~20.04/build/amd/amdgpu/../amdkfd/kfd_device.c:878 
>> kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
>> [Thu Nov 10 13:10:23 2022] Modules linked in: veth amdgpu(OE) 
>> amddrm_ttm_helper(OE) amdttm(OE) iommu_v2 amd_sched(OE) amdkcl(OE) 
>> xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user 
>> xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack 
>> nf_defrag_ipv6 nf_defrag_ipv4 bpfilter br_netfilter bridge stp llc 
>> aufs overlay binfmt_misc nls_iso8859_1 dm_multipath scsi_dh_rdac 
>> scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common amd64_edac 
>> edac_mce_amd kvm_amd kvm efi_pstore rapl ipmi_ssif ccp acpi_ipmi 
>> k10temp ipmi_si ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel msr 
>> ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 
>> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx 
>> xor raid6_pq libcrc32c raid1 raid0 multipath linear mlx5_ib ib_uverbs 
>> ib_core crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel 
>> crypto_simd cryptd ast drm_vram_helper drm_ttm_helper ttm mlx5_core 
>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
>> [Thu Nov 10 13:10:23 2022]  pci_hyperv_intf cec psample igb mlxfw 
>> rc_core dca ahci xhci_pci tls drm i2c_algo_bit libahci 
>> xhci_pci_renesas i2c_piix4
>> [Thu Nov 10 13:10:23 2022] CPU: 173 PID: 97784 Comm: onnxruntime_tes 
>> Tainted: G        W  OE     5.13.0-30-generic #33~20.04.1-Ubuntu
>> [Thu Nov 10 13:10:23 2022] Hardware name: GIGABYTE 
>> G482-Z53-YF/MZ52-G40-00, BIOS R12 05/13/2020
>> [Thu Nov 10 13:10:23 2022] RIP: 
>> 0010:kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
>> [Thu Nov 10 13:10:23 2022] Code: 5e 5d c3 4c 89 e7 e8 cb c6 44 df eb 
>> e7 49 8b 45 60 48 89 ca 48 c7 c7 38 8b d7 c1 48 89 4d e0 8b b0 20 09 
>> 00 00 e8 87 ee 7e df <0f> 0b 48 8b 4d e0 eb 9f 41 be ea ff ff ff eb 
>> ba 41 be ed ff ff ff
>> [Thu Nov 10 13:10:23 2022] RSP: 0018:ffffb25f2a173978 EFLAGS: 00010086
>> [Thu Nov 10 13:10:23 2022] RAX: 0000000000000000 RBX: 
>> 0000000000000001 RCX: 0000000000000027
>> [Thu Nov 10 13:10:23 2022] RDX: 0000000000000027 RSI: 
>> 00000000fffeffff RDI: ffff95d06e4a09c8
>> [Thu Nov 10 13:10:23 2022] RBP: ffffb25f2a173998 R08: 
>> ffff95d06e4a09c0 R09: ffffb25f2a173750
>> [Thu Nov 10 13:10:23 2022] R10: 0000000000000001 R11: 
>> 0000000000000001 R12: ffff95c371d74580
>> [Thu Nov 10 13:10:23 2022] R13: ffff95b1cd3f2000 R14: 
>> 0000000000000000 R15: ffff95c371d74580
>> [Thu Nov 10 13:10:23 2022] FS:  00007fcaff268b00(0000) 
>> GS:ffff95d06e480000(0000) knlGS:0000000000000000
>> [Thu Nov 10 13:10:23 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 
>> 0000000080050033
>> [Thu Nov 10 13:10:23 2022] CR2: 00007fc643980000 CR3: 
>> 00000003e9492000 CR4: 0000000000350ee0
>> [Thu Nov 10 13:10:23 2022] Call Trace:
>> [Thu Nov 10 13:10:23 2022]  <TASK>
>> [Thu Nov 10 13:10:23 2022]  amdkfd_fence_enable_signaling+0x46/0x50 
>> [amdgpu]
>> [Thu Nov 10 13:10:23 2022]  __dma_fence_enable_signaling+0x52/0xb0
>> [Thu Nov 10 13:10:23 2022]  dma_fence_default_wait+0xa9/0x200
>> [Thu Nov 10 13:10:23 2022]  dma_fence_wait_timeout+0xbd/0xe0
>> [Thu Nov 10 13:10:23 2022]  amddma_resv_wait_timeout+0x6f/0xd0 [amdkcl]
>> [Thu Nov 10 13:10:23 2022]  amdttm_bo_wait+0x39/0x50 [amdttm]
>> [Thu Nov 10 13:10:23 2022]  amdgpu_bo_move+0x41e/0x7b0 [amdgpu]
>> [Thu Nov 10 13:10:23 2022]  ? down_write+0x13/0x50
>> [Thu Nov 10 13:10:23 2022]  ? unmap_mapping_pages+0x68/0x130
>> [Thu Nov 10 13:10:23 2022]  ttm_bo_handle_move_mem+0x7f/0x120 [amdttm]
>> [Thu Nov 10 13:10:23 2022]  amdttm_bo_validate+0xbf/0x100 [amdttm]
>> [Thu Nov 10 13:10:23 2022]  kfd_mem_dmaunmap_attachment+0x131/0x140 
>> [amdgpu]
>> [Thu Nov 10 13:10:23 2022]  unmap_bo_from_gpuvm+0x67/0x80 [amdgpu]
>> [Thu Nov 10 13:10:23 2022] 
>>  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x114/0x220 [amdgpu]
>> [Thu Nov 10 13:10:23 2022]  ? __mod_memcg_lruvec_state+0x22/0xe0
>> [Thu Nov 10 13:10:23 2022] 
>>  kfd_ioctl_unmap_memory_from_gpu+0xe8/0x270 [amdgpu]
>> [Thu Nov 10 13:10:23 2022]  kfd_ioctl+0x23c/0x590 [amdgpu]
>> [Thu Nov 10 13:10:23 2022]  ? 
>> kfd_ioctl_get_process_apertures_new+0x330/0x330 [amdgpu]
>> [Thu Nov 10 13:10:23 2022]  ? exit_to_user_mode_prepare+0x3d/0x1c0
>> [Thu Nov 10 13:10:23 2022]  ? __fget_files+0xa7/0xd0
>> [Thu Nov 10 13:10:23 2022]  __x64_sys_ioctl+0x91/0xc0
>> [Thu Nov 10 13:10:23 2022]  do_syscall_64+0x61/0xb0
>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>> [Thu Nov 10 13:10:23 2022]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
>> [Thu Nov 10 13:10:23 2022]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [Thu Nov 10 13:10:23 2022] RIP: 0033:0x7fcaff57b3ab
>> [Thu Nov 10 13:10:23 2022] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 c7 
>> 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 
>> b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b5 7a 0d 
>> 00 f7 d8 64 89 01 48
>> [Thu Nov 10 13:10:23 2022] RSP: 002b:00007fffe41e0098 EFLAGS: 
>> 00000206 ORIG_RAX: 0000000000000010
>> [Thu Nov 10 13:10:23 2022] RAX: ffffffffffffffda RBX: 
>> 00007fcacc7f7f80 RCX: 00007fcaff57b3ab
>> [Thu Nov 10 13:10:23 2022] RDX: 00007fffe41e0120 RSI: 
>> 00000000c0184b19 RDI: 0000000000000003
>> [Thu Nov 10 13:10:23 2022] RBP: 00007fffe41e00d0 R08: 
>> 0000562e2d5730d0 R09: 0000000000000000
>> [Thu Nov 10 13:10:23 2022] R10: 0000562e2c928ec0 R11: 
>> 0000000000000206 R12: 0000000000000001
>> [Thu Nov 10 13:10:23 2022] R13: 00007fffe41e04b0 R14: 
>> 0000000000000000 R15: 0000562e2d3f5b20
>> [Thu Nov 10 13:10:23 2022]  </TASK>
>> [Thu Nov 10 13:10:23 2022] ---[ end trace 1464f08f6be60b30 ]---
>>
>> Regards,
>> Eric
>>
>> On 2023-04-04 10:11, Felix Kuehling wrote:
>>> If we keep the BO in the GTT domain, it means it will not be updated 
>>> if we validate it again later in kfd_mem_dmamap_dmabuf. This means 
>>> we'll use stale DMA addresses when we update the page tables after 
>>> evictions.
>>>
>>> I think we'll need to find a different way to avoid triggering the 
>>> eviction fence on the original BO when changing the placement of the 
>>> DMABuf import here. If you need help brainstorming here, please 
>>> share a backtrace from the eviction generated with the 
>>> debug_evictions module param.
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>> Am 2023-04-03 um 13:59 schrieb Eric Huang:
>>>> dmabuf is allocated/mapped as GTT domain, when dma-unmapping dmabuf
>>>> changing placement to CPU will trigger memory eviction after calling
>>>> ttm_bo_validate, and the eviction will cause performance drop.
>>>> Keeping the correct domain will solve the issue.
>>>>
>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index a3b09edfd1bf..17b708acb447 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -642,7 +642,7 @@ kfd_mem_dmaunmap_dmabuf(struct 
>>>> kfd_mem_attachment *attachment)
>>>>       struct ttm_operation_ctx ctx = {.interruptible = true};
>>>>       struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>>>>   -    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>>>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>>       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>   }
>>

