Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182C3C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 20:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9740C10E057;
	Tue,  4 Apr 2023 20:40:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB9C10E057
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 20:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6B1NHDvKt62wVQTp0cEb2PT3Hhs946PeQZIZGZDyYuQ1vL3q8tG9Uf80m0bqf60/B3bOnHpeZXd8wGDXyGf+MyWMy/tfKTqw3cVg0tMRcZhvhR68QM6wCYMqZcpkkzB/6U3K2Chw1xEsenKGhi73rTu7KdnR1VEnLInz3fEEHu4RhTRggDxs/HXkrCmqga8nA5raEoHivS7wOc/9gH9npIY7a0+urVAmCuIPhBcIzjNld5VZff/qQCIIfqOsWbXHBJDDLhdJhgVSEZLPKWw+BUJ4iVKzpY+wcYGo6J6PGx286V8JrWH1R1H5Ih0BzBiYZpP/0pYnetKFrvq+/UwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15OJPLXEUIxMrSSg97Mgob+OwS8Op4gAY2pU1zGeBMI=;
 b=VMQoCyE1D9QSw7tNMV9uNQC2CBW5+ASc9vNIQqV/sorxrZ2cJXbhCp2vGR6NJrE4uSDlPLRbHZvt0Jd5c7vSqmBH2EeeCfoW2HzqNUqphFeerObJ2geaEhnHZgM/tpqYJXAl5o4mTJBmY7Fi6o6AZ73V0abrLEqTWmJ0Gc7vsci5/AWLlYUhervJWAjfZOBB9JjG7oAsa0chJ3wMXLvHU8Jc6JySCSpaS2DY4KOz1NfqhIn+cszYII7IKKgDdhpsi3lACQRtH5FEJgQ3N8PQ89alqO/2vJW9MLdASIosBvah8qmxmrwIJ/h4A+kIxwGAno3si2ebjAC6prGpBieKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15OJPLXEUIxMrSSg97Mgob+OwS8Op4gAY2pU1zGeBMI=;
 b=wyIEUxwTYc7M2p8q4nUR1imeh+vUHakHM0FVdZr42ViAJW1dIPy+mwwFhY29nGJRwG4yE32KrkdDc6g3dKFm6tsQQXKVdNfIwRoqIsuijLJJGi/4BY4LlHDjBrYanIlbdWHpsasuLt/qiEikz8cuMFo+2+iHDZF+BXzOdYPscQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 20:40:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 20:40:11 +0000
Message-ID: <4a3bfe1e-2c8b-198d-23bd-035e6d78372e@amd.com>
Date: Tue, 4 Apr 2023 16:40:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix dmabuf's redundant eviction when unmapping
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230403175949.131530-1-jinhuieric.huang@amd.com>
 <91875e99-89f0-5a5e-03fc-d08d3240c869@amd.com>
 <04845a1f-c602-b796-eeba-c12a91d4401e@amd.com>
Content-Language: en-US
Organization: AMD Inc.
In-Reply-To: <04845a1f-c602-b796-eeba-c12a91d4401e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ce93e0-148e-4cd5-2d51-08db354cc97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFORhaH2ig7AlcfliZtexnWzcn8RFWGaOxRkLG+K58MvX7jD4d0kAJax274GyQZJKwJkeA/pdLDw86N7jQhEhHi7dqiRDS9Qc76h4UwKL8oPGsq3PhxyNlbDlaUszTw6TYsDK9kBedvFebAL6J+EU+BR2n+49EcWv21NgVgxSc3kjSeDwtn1mRo/buj8Bdx4+8FBsGlflVF5gFMv19VV5AtXkXqOND/I1wx1nbxUK06LPLXXpk8g9j8Xgbg2hCUavmeY78oId82iANJguO/mPLAhDDnZwCrmdEAaCx1RJ7phRcodBs0gQecgFDbdUcb/lwW/kFf6pul5lzOjAHdfGMOsIODGXm02Z5c+4qTich2xd+DYivY5R6vhBKbWNPcvB3ataI0dZ1cwwKV/tx8H2By+xJc19yCjwDXGuPdCooI7Fmbg/2Xo4bTcMZUWq+kWoAtz57SXvyOEZimrj56VEotP6jL+7a6hbLOdge+p9sDLZMrfBmlbPWVzwWsesuSxfyi0nUhIwi7RAEvKEqpdB3pLyMn2XLVm10JNIKPj+RriEtoIqAKd9VrzUa2IiM/6vyrEVMW39lFSUi+LYMfuYZD7fnfV02KTUIbIfnx8e4utr6JeBoosA0+5oEH56ZK3Vau0QRdYHs7dN2sTdFzMLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36916002)(6486002)(83380400001)(36756003)(2616005)(86362001)(38100700002)(31696002)(53546011)(6512007)(186003)(26005)(6506007)(66476007)(66946007)(66556008)(6636002)(2906002)(41300700001)(8676002)(110136005)(8936002)(316002)(5660300002)(44832011)(31686004)(478600001)(45080400002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjNycGZxVVdjdndSaTdWRGlqODkzVVg4MXlKQzhCekM5clNjZk9YZzYycnY5?=
 =?utf-8?B?V20zdDZtaHVZcDBwQ2UzYURxNzhCUmJTNjQwZmkzMXRoSDNtb1RlYVlTQWtE?=
 =?utf-8?B?ekhUQnJPcWMxeEJ2NnhpSDVyaWltc3kwQVAyZ3hIMFByUnlFZ3l0bUVvOVdN?=
 =?utf-8?B?RDFVMXIxcnF2a0x5MG9yUU56emc0NHk2eGpIc0xySFhxa3dmMDlLTStmWmdB?=
 =?utf-8?B?K0hHeEwxWEVEOXZDVkpqRm0xSitXaEl3SDV1RHJTSUNQTVdYaDZDSW5nSUg3?=
 =?utf-8?B?RHBtUWtibWZ5aWRNK0dSUlVjZDlvNFg2N1YxYXdQUmw3Q05GVGFWRkxPalcw?=
 =?utf-8?B?b0RmWE1RTUhieTlFWi8yRTRjOVlsaGZjTHdKWWlDR2FSdXpkeUpOZ1RCRWJs?=
 =?utf-8?B?aDUzNGxaa3luVlVjSS9iQkVpeE95SllwUE1mYU5PVWc0NElUemtxditkQXhD?=
 =?utf-8?B?Yms2eGw4RW9YWGoyNHNJMUFtdUl6TVBla3NWS2R6Yi9nSVllajdRU2w2dlJT?=
 =?utf-8?B?Z3p1d3lqZndrOG41N0NhWFFiTHl2QjgvODQ2KzE5T0c4NkdzeGd6TkdZeXNr?=
 =?utf-8?B?cVVMWlduQ25LL3loV0piK29nWDFUWUtUWldKTzNJWEV1cWRvNVZkZHh5SFdM?=
 =?utf-8?B?eHlnOEQyK1VnUjVtcWMzd3hOdm03YUJjbUsxRVd0L0NxVWVXcUlsL3RqZ1FW?=
 =?utf-8?B?SkFLNE45ZGF6d1hYMTlzb3RTZHJDMDFxc29ZeU9KMk9vQVBpelcrdTd5dC9V?=
 =?utf-8?B?MUZieWxRVTF4dHpUSDZBUkNJbDU1NWNmQ3lXY09zK0hTZ3VyeTdCa1g4RGNo?=
 =?utf-8?B?bTJCZm55TE1qbEJRWDhVV0hqcTgxUDNxVytXY3dnVmd3by96YjFROVBBZnkz?=
 =?utf-8?B?NDVGVU5wVXhUVzdHVlRYNnBmSk1OWE1nYStqK29tcmFrU29hS3pIVFpJblV2?=
 =?utf-8?B?bzBzV2Z0ZHI4WVMrNE0rUlREQUNqbm1Uc3I3am9xZEJyY20wRTdxeU9DZ29i?=
 =?utf-8?B?dDdUWTBnb3JCQXZuVzBtTEQyWThwd3R2cFNUTFdqUUJFU3kxNytWR2hQdXg5?=
 =?utf-8?B?ckpTRnVZZW51M3pqSjlyWU9Kc3NtQUgrTVROYTdGcGZHbzc2ZGowQkhIaGt2?=
 =?utf-8?B?MnR0cys1OWhRamhWZ1YrL3p2cmpYTzBTd0xCQnh2VThSK3p2bEw0eWtTWDhR?=
 =?utf-8?B?bXM2eUxKa1hxWit4a09hZGsyR3NVaXZQWnNDV2p0bGI0RktWSHR4YzhaVmRz?=
 =?utf-8?B?MllOMFgvYVN6YmFldWhRV3dEcHhOcDhRWXlpcUovUTFBK3ZHbkQxaXlod3FD?=
 =?utf-8?B?NWNNN056RURwUWFNa2MxR0drUzdpTVYvd0p0V0dvZ0grdzRxTTg1WTE5UlhC?=
 =?utf-8?B?eXhrOStzaGJhQ2M4a0hVb040a0tsTmRWRzluNWhseHNHZDN1S01XSEsrOGVi?=
 =?utf-8?B?RXdnUk5iYUo4dkRNUWsvcmVDUjQveDFYdWIxWm9kY3RoVThmVDhrNzYyOE0y?=
 =?utf-8?B?S3hIQnF4UFJGRE9YVW4wSTJqajhFeVRkTlg5M25hUlVmUFE0d2RYam1LY0VE?=
 =?utf-8?B?OGJvOGYvbFFDa0dnUHE2N2NuY05adTNzWXVLc2tQa2R4SEVxeVJJRVpLWXIy?=
 =?utf-8?B?dVlTTGR1Z2FleWlFSEwyQlVyTGRIakRkdkpiaHdzUWVUdjBxb0FITWUraGIv?=
 =?utf-8?B?Nzl2VE5xQ3hTQmFEOHFQQlpwU3FIRHprWndmWnJ2K1hldW56TEozdEF2d0JI?=
 =?utf-8?B?Q3ZmZW8yLysvUnVNbnpCMlg5V1pVZENXb1VVWDNxZXZqNFZkdjVCL2lwMHM4?=
 =?utf-8?B?bFF6Sll1anJldzV5ZFBHalRibG9BbVhtcjlvcWNleVNseVFjNWZ2TlBWWGRS?=
 =?utf-8?B?WXQ4bWIxUXV3ak5qOGJ4OEErdGFmSUI3WUhHWXh6RzFaQlpISVhJeDJCVGw0?=
 =?utf-8?B?SEZqYkNKcDFib3UzZE0renVDVCtTc25VM0tWcXdTejEyeEU5RGZ5NWd2bzlM?=
 =?utf-8?B?L0tidW9PMnNxRXdHYkxiaTNTTGxKTnFxZUVXWFM1NGw1T3A3ckRHeUptdGY3?=
 =?utf-8?B?L2tSL2xhTVlaODZWRVZncklTWHowQ2ZMY2pSaHFGMStsa240ZkF2Y1RxWjJJ?=
 =?utf-8?Q?8QAdAzQjk1vUsVR2xmygNFznv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ce93e0-148e-4cd5-2d51-08db354cc97d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 20:40:11.9113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCWF2yVNDFIbRZa0CZQiZQFeH/SlQ43bg7ZOYlnJuXG3S8ee/G83FEmcd3ZYY6Ldgq3Uxvv352pKO8J6dKmn2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
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

[+Christian]

OK, this comes from the ttm_bo_wait_ctx call in this section of 
amdgpu_bo_move:

         if ((old_mem->mem_type == TTM_PL_TT ||
              old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
              new_mem->mem_type == TTM_PL_SYSTEM) {
                 r = ttm_bo_wait_ctx(bo, ctx);
                 if (r)
                         return r;

                 amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
                 ttm_resource_free(bo, &bo->resource);
                 ttm_bo_assign_mem(bo, new_mem);
                 goto out;
         }

We can't just remove this wait. It's not even specific to KFD or DMABuf 
imports. We also can't just change it to avoid waiting for eviction 
fences because it's also used for GTT BOs (e.g. before a BO gets swapped 
under extreme memory pressure). So we also need to trigger the eviction 
fence in general case.

In the specific case of DMABuf imports, they share the reservation 
object with the original BO. So waiting on the reservation triggers the 
eviction fence on the original BO. I think we want to avoid the waiting 
on eviction fences for all BOs where the underlying memory is managed by 
some other BO, and at the same time also avoid ever evicting the DMABuf 
import BO. That's what AMDGPU_PL_PREEMPT is for. So I think a 
combination of two changes should to the trick:

 1. Change kfd_mem_dmamap_dmabuf to use AMDGPU_GEM_DOMAIN_PREEMPTIBLE
 2. Add a special case in the above if-block for old_mem->mem_type ==
    AMDGPU_PL_PREEMPT: use amdgpu_bo_sync_wait with
    owner=AMDGPU_FENCE_OWNER_KFD so that it doesn't wait for eviction fences

Regards,
   Felix


Am 2023-04-04 um 10:36 schrieb Eric Huang:
> Here is the backtrace from Jira:
>
> Thu Nov 10 13:10:23 2022] Scheduling eviction of pid 97784 in 0 jiffies
> [Thu Nov 10 13:10:23 2022] WARNING: CPU: 173 PID: 97784 at 
> /var/lib/dkms/amdgpu/5.16.9.22.20-1438746~20.04/build/amd/amdgpu/../amdkfd/kfd_device.c:878 
> kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
> [Thu Nov 10 13:10:23 2022] Modules linked in: veth amdgpu(OE) 
> amddrm_ttm_helper(OE) amdttm(OE) iommu_v2 amd_sched(OE) amdkcl(OE) 
> xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user 
> xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack 
> nf_defrag_ipv6 nf_defrag_ipv4 bpfilter br_netfilter bridge stp llc 
> aufs overlay binfmt_misc nls_iso8859_1 dm_multipath scsi_dh_rdac 
> scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common amd64_edac 
> edac_mce_amd kvm_amd kvm efi_pstore rapl ipmi_ssif ccp acpi_ipmi 
> k10temp ipmi_si ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel msr 
> ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor 
> raid6_pq libcrc32c raid1 raid0 multipath linear mlx5_ib ib_uverbs 
> ib_core crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel 
> crypto_simd cryptd ast drm_vram_helper drm_ttm_helper ttm mlx5_core 
> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> [Thu Nov 10 13:10:23 2022]  pci_hyperv_intf cec psample igb mlxfw 
> rc_core dca ahci xhci_pci tls drm i2c_algo_bit libahci 
> xhci_pci_renesas i2c_piix4
> [Thu Nov 10 13:10:23 2022] CPU: 173 PID: 97784 Comm: onnxruntime_tes 
> Tainted: G        W  OE     5.13.0-30-generic #33~20.04.1-Ubuntu
> [Thu Nov 10 13:10:23 2022] Hardware name: GIGABYTE 
> G482-Z53-YF/MZ52-G40-00, BIOS R12 05/13/2020
> [Thu Nov 10 13:10:23 2022] RIP: 
> 0010:kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
> [Thu Nov 10 13:10:23 2022] Code: 5e 5d c3 4c 89 e7 e8 cb c6 44 df eb 
> e7 49 8b 45 60 48 89 ca 48 c7 c7 38 8b d7 c1 48 89 4d e0 8b b0 20 09 
> 00 00 e8 87 ee 7e df <0f> 0b 48 8b 4d e0 eb 9f 41 be ea ff ff ff eb ba 
> 41 be ed ff ff ff
> [Thu Nov 10 13:10:23 2022] RSP: 0018:ffffb25f2a173978 EFLAGS: 00010086
> [Thu Nov 10 13:10:23 2022] RAX: 0000000000000000 RBX: 0000000000000001 
> RCX: 0000000000000027
> [Thu Nov 10 13:10:23 2022] RDX: 0000000000000027 RSI: 00000000fffeffff 
> RDI: ffff95d06e4a09c8
> [Thu Nov 10 13:10:23 2022] RBP: ffffb25f2a173998 R08: ffff95d06e4a09c0 
> R09: ffffb25f2a173750
> [Thu Nov 10 13:10:23 2022] R10: 0000000000000001 R11: 0000000000000001 
> R12: ffff95c371d74580
> [Thu Nov 10 13:10:23 2022] R13: ffff95b1cd3f2000 R14: 0000000000000000 
> R15: ffff95c371d74580
> [Thu Nov 10 13:10:23 2022] FS:  00007fcaff268b00(0000) 
> GS:ffff95d06e480000(0000) knlGS:0000000000000000
> [Thu Nov 10 13:10:23 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 
> 0000000080050033
> [Thu Nov 10 13:10:23 2022] CR2: 00007fc643980000 CR3: 00000003e9492000 
> CR4: 0000000000350ee0
> [Thu Nov 10 13:10:23 2022] Call Trace:
> [Thu Nov 10 13:10:23 2022]  <TASK>
> [Thu Nov 10 13:10:23 2022]  amdkfd_fence_enable_signaling+0x46/0x50 
> [amdgpu]
> [Thu Nov 10 13:10:23 2022]  __dma_fence_enable_signaling+0x52/0xb0
> [Thu Nov 10 13:10:23 2022]  dma_fence_default_wait+0xa9/0x200
> [Thu Nov 10 13:10:23 2022]  dma_fence_wait_timeout+0xbd/0xe0
> [Thu Nov 10 13:10:23 2022]  amddma_resv_wait_timeout+0x6f/0xd0 [amdkcl]
> [Thu Nov 10 13:10:23 2022]  amdttm_bo_wait+0x39/0x50 [amdttm]
> [Thu Nov 10 13:10:23 2022]  amdgpu_bo_move+0x41e/0x7b0 [amdgpu]
> [Thu Nov 10 13:10:23 2022]  ? down_write+0x13/0x50
> [Thu Nov 10 13:10:23 2022]  ? unmap_mapping_pages+0x68/0x130
> [Thu Nov 10 13:10:23 2022]  ttm_bo_handle_move_mem+0x7f/0x120 [amdttm]
> [Thu Nov 10 13:10:23 2022]  amdttm_bo_validate+0xbf/0x100 [amdttm]
> [Thu Nov 10 13:10:23 2022]  kfd_mem_dmaunmap_attachment+0x131/0x140 
> [amdgpu]
> [Thu Nov 10 13:10:23 2022]  unmap_bo_from_gpuvm+0x67/0x80 [amdgpu]
> [Thu Nov 10 13:10:23 2022] 
>  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x114/0x220 [amdgpu]
> [Thu Nov 10 13:10:23 2022]  ? __mod_memcg_lruvec_state+0x22/0xe0
> [Thu Nov 10 13:10:23 2022]  kfd_ioctl_unmap_memory_from_gpu+0xe8/0x270 
> [amdgpu]
> [Thu Nov 10 13:10:23 2022]  kfd_ioctl+0x23c/0x590 [amdgpu]
> [Thu Nov 10 13:10:23 2022]  ? 
> kfd_ioctl_get_process_apertures_new+0x330/0x330 [amdgpu]
> [Thu Nov 10 13:10:23 2022]  ? exit_to_user_mode_prepare+0x3d/0x1c0
> [Thu Nov 10 13:10:23 2022]  ? __fget_files+0xa7/0xd0
> [Thu Nov 10 13:10:23 2022]  __x64_sys_ioctl+0x91/0xc0
> [Thu Nov 10 13:10:23 2022]  do_syscall_64+0x61/0xb0
> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
> [Thu Nov 10 13:10:23 2022]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
> [Thu Nov 10 13:10:23 2022]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [Thu Nov 10 13:10:23 2022] RIP: 0033:0x7fcaff57b3ab
> [Thu Nov 10 13:10:23 2022] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 c7 
> 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 
> b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b5 7a 0d 00 
> f7 d8 64 89 01 48
> [Thu Nov 10 13:10:23 2022] RSP: 002b:00007fffe41e0098 EFLAGS: 00000206 
> ORIG_RAX: 0000000000000010
> [Thu Nov 10 13:10:23 2022] RAX: ffffffffffffffda RBX: 00007fcacc7f7f80 
> RCX: 00007fcaff57b3ab
> [Thu Nov 10 13:10:23 2022] RDX: 00007fffe41e0120 RSI: 00000000c0184b19 
> RDI: 0000000000000003
> [Thu Nov 10 13:10:23 2022] RBP: 00007fffe41e00d0 R08: 0000562e2d5730d0 
> R09: 0000000000000000
> [Thu Nov 10 13:10:23 2022] R10: 0000562e2c928ec0 R11: 0000000000000206 
> R12: 0000000000000001
> [Thu Nov 10 13:10:23 2022] R13: 00007fffe41e04b0 R14: 0000000000000000 
> R15: 0000562e2d3f5b20
> [Thu Nov 10 13:10:23 2022]  </TASK>
> [Thu Nov 10 13:10:23 2022] ---[ end trace 1464f08f6be60b30 ]---
>
> Regards,
> Eric
>
> On 2023-04-04 10:11, Felix Kuehling wrote:
>> If we keep the BO in the GTT domain, it means it will not be updated 
>> if we validate it again later in kfd_mem_dmamap_dmabuf. This means 
>> we'll use stale DMA addresses when we update the page tables after 
>> evictions.
>>
>> I think we'll need to find a different way to avoid triggering the 
>> eviction fence on the original BO when changing the placement of the 
>> DMABuf import here. If you need help brainstorming here, please share 
>> a backtrace from the eviction generated with the debug_evictions 
>> module param.
>>
>> Regards,
>>   Felix
>>
>>
>> Am 2023-04-03 um 13:59 schrieb Eric Huang:
>>> dmabuf is allocated/mapped as GTT domain, when dma-unmapping dmabuf
>>> changing placement to CPU will trigger memory eviction after calling
>>> ttm_bo_validate, and the eviction will cause performance drop.
>>> Keeping the correct domain will solve the issue.
>>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index a3b09edfd1bf..17b708acb447 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -642,7 +642,7 @@ kfd_mem_dmaunmap_dmabuf(struct 
>>> kfd_mem_attachment *attachment)
>>>       struct ttm_operation_ctx ctx = {.interruptible = true};
>>>       struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>>>   -    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>   }
>
