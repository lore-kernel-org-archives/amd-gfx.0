Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7219EC77B6C
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 14:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D3610E3D5;
	Tue,  4 Apr 2023 14:36:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFAC010E3D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 14:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkaPJYVGSmECk6cf39dQfCcpTl6cJNsjxqiAM5Xsg/GD9nROCv8LLHwDPh9npjt4gq8tCIV+cCJiyu9Rwd2zRxglsOiTFZ3LbcgUvnqzsv5qXXNk7ZtSLANMtz2oZZmMzdRHxFOp1GDwZ2a44hqCKm0RXmFtwy9wO6nIC6qA3N6nSJymKx8l1And3TwByzR68wUj4aAMhKcAhugE9lNOGzD4MTCDWJJHZjQtz3t6rTVPDTSv8Val2vs7EjR8beQ/ICa5WpOgehti+ZjqKyItZ1g59T5msNnVfhzj0Y1DotEF2XPsiukE2MKLX/0gFb9R8MyN05Ebqpl2824Q7Gdfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rnmYus4uK/QZzS3Fqt/FBni2/y44fi32bhMicszd3Q=;
 b=BK22ZrE7dQ6xFQk4olsolzFlCbRF3u6+wzVE6ycWQdXo/cEN/IUjyBeF5C0NZJggKuOZE1foe/e5iU8sTVRcfpOb3mfW8iNOFZTKlkkvKu45kepp4PVDbACyBwqbUb4urLYa0xoNcaf3+OAEFIh3M/FEGqP4cFzfHeKnG8OXDtEqC1imrXq98oSh+TtY/wgtDQDcI0+nsPDcyn32nJdNcEpPohVEJ0rDhVxmt8EpnmmNBye/73HXVL5NG6Si+BCv5bnJS79pKlhnMnVwhuHhM5NnLkXrpX1ecF74U1AiCxzFg7VJ0V5MuKt1VojCctyeIFu7TO3ZSjReXuqyC3SNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rnmYus4uK/QZzS3Fqt/FBni2/y44fi32bhMicszd3Q=;
 b=KCoW+SSIqU1SEmSjsunQ2kn3amYbbzvu9AC14MUoB+V8i/qbknzjMWPxWY+RGn2/MasKmbZsQGY0ZFKzHsn5AOzRJ8EnlTHA852Vjfam+KMgj6getG+YpFu1jrc0dhRZs9VP9U8uNrp0YLLwCFFGzWTw/vT+K+rilOxw6H+Ks0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:36:10 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::bce1:3595:884b:df55]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::bce1:3595:884b:df55%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:36:10 +0000
Message-ID: <04845a1f-c602-b796-eeba-c12a91d4401e@amd.com>
Date: Tue, 4 Apr 2023 10:36:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdkfd: Fix dmabuf's redundant eviction when unmapping
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230403175949.131530-1-jinhuieric.huang@amd.com>
 <91875e99-89f0-5a5e-03fc-d08d3240c869@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <91875e99-89f0-5a5e-03fc-d08d3240c869@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:610:4c::11) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: de96295b-f233-4a1f-b595-08db3519eeca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4o8evOTh+mOtQk9uTWRxl1EOU+mxlhVEl1Ir/7w6aCuJc8FqJD6Tu0uRrXVocgH/UcuqyUj0jWOoqJevfxDfovXktHLbQ/KJpHMhkpD3NFgDoUwuxyTn1uWkXfQiiD7WbEZ7/KKY9IscaMsGFn7WV+ePDIvnbqeV3Ag5CrN2V9CqVJAN2XymvxF/+OfMrqgXqLm2MOWhGzQWxEQxVmIZI1joh1C/j9RdwyAOQr/25eLykdcGs5fD+Yq5EIEG5a6AfmCdaVeHy6PRnpPUtyu83TfumIWVsCoFBW+I0s0mI1u/RtxO5ZsQOUuBE041BI7NaEwUL2opmt4ZtzR7s31G2zJGXtfJRd8NJOIORF3psg6iRFcwqndWRz7xUjrx8UKTbcDCzEJdDaZf+OjDdN6ulkEg5VIOIpb07I5FxYwdOU92njCtijDsK3zRHNMuTxp22VK+/uj5nov+lgrcy28Fpm88h5tNLG75L7iCmywdLJp2CGSxLvQzGqPUjSdDuWMBFJRTAtqDKgNPOKnrpwtK63y2e/+lgKjR2WBC0DFdsVf8lnYX5WZo8EMfRGYb93YnE2/7pdPo3B0r0CT7J0UOsMZ2SdKmVrxf1vOH2lnGW3l9qExqjfB5XvuZcyZVZmH2LnR0VqbrRHdk95HySamM6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(478600001)(316002)(110136005)(45080400002)(6636002)(66946007)(66476007)(8676002)(66556008)(6486002)(2906002)(6666004)(38100700002)(31696002)(41300700001)(5660300002)(8936002)(86362001)(36756003)(2616005)(6506007)(53546011)(6512007)(186003)(26005)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3kwb2crMThiMWVoSE45d0hwc0hlMFNFN1dXQkJtNmVGOEI5NE1DNWpGNTA4?=
 =?utf-8?B?UVVQSDM1a2ZVeWZHZGc5a0VKSGlSS0N4RkFQQ25hMlpadlFXdnczdnQ1RnJn?=
 =?utf-8?B?alVtYkVTNmR0ZHo4bjlwZE15RytzYjlHY2U3Mmg0WmgxdVJYMFlVQ2h6TkdX?=
 =?utf-8?B?ODhGVS9GaStIRlp2T1ZvYnoxMGdqcXdxSkM1Y1haM2s5S09uT0k0KytlaVk5?=
 =?utf-8?B?TVJHYk5oQjJBT3cxd0RscVlreVRrWnlnVEVNMTRqeWJXb0VYR2p6aUxaNGR3?=
 =?utf-8?B?WnlwUEtQZHBuQkVqSDBINEZla0hHcmRPbkVYMXQvZGg0Q1V1b0tQZlU2Nzg5?=
 =?utf-8?B?MEpJek9ZZkx6WGR1THh0WTlQNTRBdi84aXZNc0prYUNBL1pPVEQ4cmptMndt?=
 =?utf-8?B?REV2TjR4UXdub3c3ZG43bHpINnhmdmpJZEZnRW5Zb0FZd0VOZjdRTitnRitK?=
 =?utf-8?B?bFVIKzVrc29qbjFYWG5sTnhiVDEyQ21NRlVJeDh3Y3BZT2UzT1QvUVJFSzlR?=
 =?utf-8?B?U1JORHNqT1BxdDFxOXNRTjJRVUpOM1hDc2k3Yi80dWRsYmQ2OC9WaHlsSitm?=
 =?utf-8?B?b0VNUGZsbjR1RTRldHZWMzJ4a3dhdjZTd1ZJZ3BFeFRHZEcvQlZ4T3lNeVVI?=
 =?utf-8?B?UVhZTFp6RVpWamJDbElKS1NVZXB2YlFPaTlKZ2h0L2ZhanBLOThiNWIyOTJq?=
 =?utf-8?B?enhOM1RUT1p4SEpId3ZESVBLRkNsVExobCtMdU1Bdy9FNVNNV282M0ZOWGhY?=
 =?utf-8?B?aUx5UWIya3FkOTRHTWFtcVlrUkpSV05hYlNwUW96WDUwVW5NVURGM3IwdTBj?=
 =?utf-8?B?ODd4NmRyMTRrWUhZU052c1R5d28rV25yZEFXTThqU000UkNuQ3hIaGtSVVRZ?=
 =?utf-8?B?WEVGY1V1Qm0wM3Rqc20vdkFZaDgvZ3g1STBmNU82dDNpZmp3eUQ0aGlxeXpi?=
 =?utf-8?B?dG1Fd3BsOHdTbWdjYTIxb0ozZUdwNEc2SUtKeTNEdHFzZXdxZnVVZnUxbHU5?=
 =?utf-8?B?ZndudUFMMzFFZUJWWVNOL29rLzQzd3dSa0VZYW5EZWFEamwzZzhoTWNEMUM5?=
 =?utf-8?B?SnJiRFpDVjdnbDBMYU9VaFlxVWM1Uzd4aUtIaGFucVpwN0Y3SGxtdkkrMSsr?=
 =?utf-8?B?N0o0MXZNczBSS0xxdER5ejUvVUQrTjRpRHR0U1FPS2IxdVdOanl5Q3prSksy?=
 =?utf-8?B?amNIajJmd2dhT3I0ZHBVT3pnNFpSWUZQVHdQWFV0Q2V0cU1vZ296SFYvUUtI?=
 =?utf-8?B?U1o3T3dkV1M4MjhTR1JVbmpqM1NJWjJoaUpQMmcyZGJ6YkZEb0F5SnUxL1cy?=
 =?utf-8?B?Wm5WbkJkdmRKekFCNDhJcDE3ejc3U0llUFE2R3lHZ0kyNDljYXhrYzZFR2tq?=
 =?utf-8?B?MWpGVzlBelJMVUpUVjVFcUNqb2c5dFdrODU5alR6T1M3am5jbW9qUGljZmMx?=
 =?utf-8?B?QkRQZ2VxLzl5dzlXMHIrWlZpczJRTXp2ck5HVE5lWEQ5UHJMUUpUUTBndWFp?=
 =?utf-8?B?U2VpQ3Z6ZDZJbzdueTZpRFRHU0JOcEV3d1FBbzlFZ1orSXNCYkUwODJHVFZP?=
 =?utf-8?B?RE81eDRRZWltZ1RLVjk1cWJjZjBPelNRZDJrMGpBNDc2WXhmRUVINGpsN3NW?=
 =?utf-8?B?N01Wb2hvSGhvVW5jYVJoMUdIb0JNdkFuMVY4TXZUUGFld01FZWZzalB2eE5l?=
 =?utf-8?B?aUtaWXcvR0JwK0ZGdkRiYTZ2RXBGazdGTlBHaFZXdEpEckNobXFSRktzSWhn?=
 =?utf-8?B?dUIvaWNBNDhPaWFuR1IrOEhHQ0hURWdiWWRkWU9FNzhhVWRjME5MNkJPUmd0?=
 =?utf-8?B?TTIrajY0R0tSVGdNeDJjS1hMeWljeFZWN3c1SjhwM1EyQUFtOTdNN2hNeUZZ?=
 =?utf-8?B?c3A1Tko3NmdyQUJ2M25QKzRlK2hBVDl1NkMybVFwRzErZk5TZGc4cmJxNnZC?=
 =?utf-8?B?NHpwRDQrSTE3a2ZJTG5INUJ0d2JtL0M3RTNBWHo1NzhvRWtYYllsM3VOZktx?=
 =?utf-8?B?RmhnN3kvVUhqNFdKQ1J6eUpyekdGVjRvcW5NUEpuRmpQU0NSaUx0NkVxWkE3?=
 =?utf-8?B?ZWZ6bldFS05LN2EyQWg3bUlER1U5K0hqeFFoU0t6UmN6NE83dFF4T1NJM09Y?=
 =?utf-8?Q?EE0kKiTuHEqI0rXsJumhb+OTE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de96295b-f233-4a1f-b595-08db3519eeca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:36:10.1979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77JROT72LdaReVP9fSFgYq92tO6KjSlQi2989hdJ89m6HUJGmWtpliSHrFiic8gKjabxUZxNxvRHsp0eMMwByw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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

Here is the backtrace from Jira:

Thu Nov 10 13:10:23 2022] Scheduling eviction of pid 97784 in 0 jiffies
[Thu Nov 10 13:10:23 2022] WARNING: CPU: 173 PID: 97784 at 
/var/lib/dkms/amdgpu/5.16.9.22.20-1438746~20.04/build/amd/amdgpu/../amdkfd/kfd_device.c:878 
kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
[Thu Nov 10 13:10:23 2022] Modules linked in: veth amdgpu(OE) 
amddrm_ttm_helper(OE) amdttm(OE) iommu_v2 amd_sched(OE) amdkcl(OE) 
xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user 
xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 bpfilter br_netfilter bridge stp llc aufs 
overlay binfmt_misc nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd 
kvm_amd kvm efi_pstore rapl ipmi_ssif ccp acpi_ipmi k10temp ipmi_si 
ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel msr ip_tables x_tables 
autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
libcrc32c raid1 raid0 multipath linear mlx5_ib ib_uverbs ib_core 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel 
crypto_simd cryptd ast drm_vram_helper drm_ttm_helper ttm mlx5_core 
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
[Thu Nov 10 13:10:23 2022]  pci_hyperv_intf cec psample igb mlxfw 
rc_core dca ahci xhci_pci tls drm i2c_algo_bit libahci xhci_pci_renesas 
i2c_piix4
[Thu Nov 10 13:10:23 2022] CPU: 173 PID: 97784 Comm: onnxruntime_tes 
Tainted: G        W  OE     5.13.0-30-generic #33~20.04.1-Ubuntu
[Thu Nov 10 13:10:23 2022] Hardware name: GIGABYTE 
G482-Z53-YF/MZ52-G40-00, BIOS R12 05/13/2020
[Thu Nov 10 13:10:23 2022] RIP: 
0010:kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
[Thu Nov 10 13:10:23 2022] Code: 5e 5d c3 4c 89 e7 e8 cb c6 44 df eb e7 
49 8b 45 60 48 89 ca 48 c7 c7 38 8b d7 c1 48 89 4d e0 8b b0 20 09 00 00 
e8 87 ee 7e df <0f> 0b 48 8b 4d e0 eb 9f 41 be ea ff ff ff eb ba 41 be 
ed ff ff ff
[Thu Nov 10 13:10:23 2022] RSP: 0018:ffffb25f2a173978 EFLAGS: 00010086
[Thu Nov 10 13:10:23 2022] RAX: 0000000000000000 RBX: 0000000000000001 
RCX: 0000000000000027
[Thu Nov 10 13:10:23 2022] RDX: 0000000000000027 RSI: 00000000fffeffff 
RDI: ffff95d06e4a09c8
[Thu Nov 10 13:10:23 2022] RBP: ffffb25f2a173998 R08: ffff95d06e4a09c0 
R09: ffffb25f2a173750
[Thu Nov 10 13:10:23 2022] R10: 0000000000000001 R11: 0000000000000001 
R12: ffff95c371d74580
[Thu Nov 10 13:10:23 2022] R13: ffff95b1cd3f2000 R14: 0000000000000000 
R15: ffff95c371d74580
[Thu Nov 10 13:10:23 2022] FS:  00007fcaff268b00(0000) 
GS:ffff95d06e480000(0000) knlGS:0000000000000000
[Thu Nov 10 13:10:23 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Thu Nov 10 13:10:23 2022] CR2: 00007fc643980000 CR3: 00000003e9492000 
CR4: 0000000000350ee0
[Thu Nov 10 13:10:23 2022] Call Trace:
[Thu Nov 10 13:10:23 2022]  <TASK>
[Thu Nov 10 13:10:23 2022]  amdkfd_fence_enable_signaling+0x46/0x50 [amdgpu]
[Thu Nov 10 13:10:23 2022]  __dma_fence_enable_signaling+0x52/0xb0
[Thu Nov 10 13:10:23 2022]  dma_fence_default_wait+0xa9/0x200
[Thu Nov 10 13:10:23 2022]  dma_fence_wait_timeout+0xbd/0xe0
[Thu Nov 10 13:10:23 2022]  amddma_resv_wait_timeout+0x6f/0xd0 [amdkcl]
[Thu Nov 10 13:10:23 2022]  amdttm_bo_wait+0x39/0x50 [amdttm]
[Thu Nov 10 13:10:23 2022]  amdgpu_bo_move+0x41e/0x7b0 [amdgpu]
[Thu Nov 10 13:10:23 2022]  ? down_write+0x13/0x50
[Thu Nov 10 13:10:23 2022]  ? unmap_mapping_pages+0x68/0x130
[Thu Nov 10 13:10:23 2022]  ttm_bo_handle_move_mem+0x7f/0x120 [amdttm]
[Thu Nov 10 13:10:23 2022]  amdttm_bo_validate+0xbf/0x100 [amdttm]
[Thu Nov 10 13:10:23 2022]  kfd_mem_dmaunmap_attachment+0x131/0x140 [amdgpu]
[Thu Nov 10 13:10:23 2022]  unmap_bo_from_gpuvm+0x67/0x80 [amdgpu]
[Thu Nov 10 13:10:23 2022] 
  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x114/0x220 [amdgpu]
[Thu Nov 10 13:10:23 2022]  ? __mod_memcg_lruvec_state+0x22/0xe0
[Thu Nov 10 13:10:23 2022]  kfd_ioctl_unmap_memory_from_gpu+0xe8/0x270 
[amdgpu]
[Thu Nov 10 13:10:23 2022]  kfd_ioctl+0x23c/0x590 [amdgpu]
[Thu Nov 10 13:10:23 2022]  ? 
kfd_ioctl_get_process_apertures_new+0x330/0x330 [amdgpu]
[Thu Nov 10 13:10:23 2022]  ? exit_to_user_mode_prepare+0x3d/0x1c0
[Thu Nov 10 13:10:23 2022]  ? __fget_files+0xa7/0xd0
[Thu Nov 10 13:10:23 2022]  __x64_sys_ioctl+0x91/0xc0
[Thu Nov 10 13:10:23 2022]  do_syscall_64+0x61/0xb0
[Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
[Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
[Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
[Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
[Thu Nov 10 13:10:23 2022]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
[Thu Nov 10 13:10:23 2022]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[Thu Nov 10 13:10:23 2022] RIP: 0033:0x7fcaff57b3ab
[Thu Nov 10 13:10:23 2022] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 c7 00 
26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b5 7a 0d 00 f7 d8 
64 89 01 48
[Thu Nov 10 13:10:23 2022] RSP: 002b:00007fffe41e0098 EFLAGS: 00000206 
ORIG_RAX: 0000000000000010
[Thu Nov 10 13:10:23 2022] RAX: ffffffffffffffda RBX: 00007fcacc7f7f80 
RCX: 00007fcaff57b3ab
[Thu Nov 10 13:10:23 2022] RDX: 00007fffe41e0120 RSI: 00000000c0184b19 
RDI: 0000000000000003
[Thu Nov 10 13:10:23 2022] RBP: 00007fffe41e00d0 R08: 0000562e2d5730d0 
R09: 0000000000000000
[Thu Nov 10 13:10:23 2022] R10: 0000562e2c928ec0 R11: 0000000000000206 
R12: 0000000000000001
[Thu Nov 10 13:10:23 2022] R13: 00007fffe41e04b0 R14: 0000000000000000 
R15: 0000562e2d3f5b20
[Thu Nov 10 13:10:23 2022]  </TASK>
[Thu Nov 10 13:10:23 2022] ---[ end trace 1464f08f6be60b30 ]---

Regards,
Eric

On 2023-04-04 10:11, Felix Kuehling wrote:
> If we keep the BO in the GTT domain, it means it will not be updated 
> if we validate it again later in kfd_mem_dmamap_dmabuf. This means 
> we'll use stale DMA addresses when we update the page tables after 
> evictions.
>
> I think we'll need to find a different way to avoid triggering the 
> eviction fence on the original BO when changing the placement of the 
> DMABuf import here. If you need help brainstorming here, please share 
> a backtrace from the eviction generated with the debug_evictions 
> module param.
>
> Regards,
>   Felix
>
>
> Am 2023-04-03 um 13:59 schrieb Eric Huang:
>> dmabuf is allocated/mapped as GTT domain, when dma-unmapping dmabuf
>> changing placement to CPU will trigger memory eviction after calling
>> ttm_bo_validate, and the eviction will cause performance drop.
>> Keeping the correct domain will solve the issue.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index a3b09edfd1bf..17b708acb447 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -642,7 +642,7 @@ kfd_mem_dmaunmap_dmabuf(struct kfd_mem_attachment 
>> *attachment)
>>       struct ttm_operation_ctx ctx = {.interruptible = true};
>>       struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>>   -    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>   }

