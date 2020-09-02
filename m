Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11850C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 07:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CA42087D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 07:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MLXdY7Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CA42087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C466E913;
	Wed,  2 Sep 2020 07:10:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6786E913
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 07:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8H8+BN0vmquaSY8Hy4rELBlNkD4bqMPEc6Yc86H/+Ad88FXusc/JDKAoSv04P6sap8sJuVYtL6GwU14ZIAAhJMJcb2Y5QHPm8cmUYjqJTR1DoLSS7uojSh/7mKVQLHow0NGxkjIkJsk3aT67z4b/P97aJ+EKzegK+PVvaCUq/GkA27FwqAxMt7I8Dt+CA7XTP4SbrARaqrHtNBj8YJY+dhHDh3G0zKXB5dciyc/u08HQyh8OUM+VeTbisrQQvO4VLGpTZY9V6RtnsP+IcAvAzqrl4kEd5JeH2j4WXN3XEesvEVEYngsq3kGhuK1azHtWLxTXnrDSon8HDPpVQJrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNnYbSmJ5I7pY4ooxXTuoEf+y0a7v1hvRuDJNZbTq/g=;
 b=DVQRtUH5rM+TAJOC1MXcg2S3s7Q+jrj1/lYhEfRfoEQhr+UIyhLRPOWl7q1pUhHC+y84GZoXpJS0KVM+6sVAqRIaqPEMWtMBJ/VtnkqiB9/WljmhmVXNlB2DiT08sCiP6cNbwLKClswzs9trKLiVu4lVp7VH8lXK0pYYzI2v11+q+2tGwbgp2eQqQ9vgcSNFRIJgBb/e4ohEgTA1uaJTqL0yqdLMLymaaqirnpYUWjgeOzrwoKzWuIndNjbGhoW+sKHN3AP0LjDRghSOTPtMiEpW24mTzbEN/xTbhj52a+RYE9eTzch+kdRFrhjXIK7B7FWNm52gSGGO75BcdN/M0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNnYbSmJ5I7pY4ooxXTuoEf+y0a7v1hvRuDJNZbTq/g=;
 b=MLXdY7Ajpy1Zm9ri/eHXGdYydx4L5e+YZMeiwl4u5MVsJ4j0w547S/Ux3Ea30/j8VPdT9fSSA8/VRUTt/y6FANcO4n2wJO5E5GaOnnGoUJpLQzFF/L9SOiyh/3o8rXkLJUSHmFJdPuySptweZtQ8gmklk+74r0JePMUSbYcOWEw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 07:10:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 07:10:40 +0000
Subject: Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: stop allocating dummy GTT
 nodes"
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200902034314.3987-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2b2eaa0d-4891-7bf8-7578-c0ec5eba6165@amd.com>
Date: Wed, 2 Sep 2020 09:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200902034314.3987-1-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.7 via Frontend Transport; Wed, 2 Sep 2020 07:10:39 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 671d7a57-0c53-42fb-882e-08d84f0f4cb2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42214CF0AAFE0F472A969A19832F0@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0nGkH9k/QYTouXEDYA6eKdhtze7xunpm1URCA+7on/LuIVi2GKVojcaKfUX+ckv1qX20zkDbQUkPyqqjIPrjXYbBcPJgsBuF/+giUZF4B0OVaJbYasHI4seWftMyaEg84gl8wB0l04BtS5EDWl23g60Dns9fJE7S3WjvrUQcx2j0V99ujrQI5GS81EiFIbN5GYzh1I/gd/cLnekbiMoCwqIcevc2NT8/HT6WXrzQuXMt5c6K++78bQrnoiFP80K7ckNjNMjCcotQo63AZbD0L8RZsJlG3jHTUdW8/JWHALLOm9lSW6wanNBuQTxIefnPTIPQh8pW4Wci7UmEIdzZIOYOdk8DkpnDTctnApioe9RCQz778PZdxHnLF8SUU4I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(478600001)(8936002)(86362001)(66476007)(66556008)(6666004)(8676002)(66946007)(31696002)(956004)(36756003)(186003)(52116002)(2616005)(83380400001)(5660300002)(6486002)(316002)(31686004)(45080400002)(16576012)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: G/BqvEoe8Rl29qM4eyqfBZQGZnTvjUWlc++7gwdZTx8AA9FUY/XzHdT5peoVHZdCp7C1Amgryve7DzSQIYIQjcMIznzWogG8nFosep8pSbrNZuNl2m+Rto+fYJUi0I/W9su5+gFb29x4qkAW0zTY13nrGQ6z1qnef1L6z3mIfU8XTTHzjvx6IMBww+7mp1A1/YUWMUyRXnb3IOsS3X1fciaM0oZvc1nAsPyyevgNzgZ/aHc7aOs8Oi1VZL1jVGKZWxobaL650iwQPX9oiWMQ581z9D5Zq0fXAHQuo3G/6MCk84GR474jlQfgSxhEgPZgzzgUwDtplDaP5AmnL70qwAjFcsu387tpoOTUbZMDMuR42HopAtXNd6DjEvC2xC0HBBoLymktk2relBcNV1ORqrXIqbD/JTC0vQuBH8EPv+FR9BFBEGb3cXaPeRsktQXYisWPvsev2Iy/iQvlzFpt6IPsscls/7j241wbSA8uxi4eJMxs8cqsucmn1ZUUudjuR8ZBDVAAE9dlb+gIkKkbAiYZA+gaPmIdoSYlgXtkRah3K56OF0nGeNixDbgeNMI3qE36w482oPPwCv1xtXzL7Q98Up378x+PyyIee6ca6ZjbFLrFSQvkJjIucvovvkxn4akvwoF0k3GJMiWV/rIPZKcrt1HK11Ju79ziOLZsgYAiawmm5BzKY/bzu7eVUXEMgEoQgvf8uIOlJIIq9daNxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d7a57-0c53-42fb-882e-08d84f0f4cb2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 07:10:40.5865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVe0JfxYA8XOxmCgskOlMtVTaerMwXU5cdY9f7sD9Cg7yfRHWcLcUDNdWOiysx9/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We got a bug report from upstream about this as well, but I couldn't 
reproduce it so far.

Why would we touch outside of the page table with this?

Regards,
Christian.

Am 02.09.20 um 05:43 schrieb xinhui pan:
> This reverts commit 1e691e2444871d1fde11b611653b5da9010dcec8.
>
> mem->mm_node now could be NULL with commit above. That makes
> amdgpu_vm_bo_split_mapping touchs outside of the page table as
> max_entries set to S64_MAX;
>
> before we fix that issue, revert commit above.
>
> [  978.955925] BUG: unable to handle page fault for address: ffff94dfc4bc0000
> [  978.963424] #PF: supervisor read access in kernel mode
> [  978.969034] #PF: error_code(0x0000) - not-present page
> [  978.974662] PGD 72e201067 P4D 72e201067 PUD 86a414067 PMD 86a3ee067 PTE 800ffff83b43f060
> [  978.983494] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
> [  978.988992] CPU: 0 PID: 12264 Comm: Xorg Tainted: G        W  O      5.9.0-rc2+ #46
> [  978.997394] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
> [  979.007495] RIP: 0010:amdgpu_vm_bo_update+0x5af/0x880 [amdgpu]
> [  979.013881] Code: ff ff ff ff ff 7f 48 8b 45 c0 4c 8d 04 d8 b8 01 00 00 00 eb 09 48 83 c0 01 48 39 c2 76 12 49 8b 74 c0 f8 48 81 c6 00 10 00 00 <49> 39 34 c0 74 e5 8b 75 b4 4c 8b 45 c8 48 38
> [  979.034354] RSP: 0018:ffffa94281403ba8 EFLAGS: 00010206
> [  979.040050] RAX: 0000000000000200 RBX: 0000000000000e00 RCX: 00000000001049e8
> [  979.047824] RDX: 7fffffffffffffff RSI: 00000007c5e00000 RDI: ffff94dfd5fc0000
> [  979.055644] RBP: ffffa94281403c40 R08: ffff94dfc4bbf000 R09: 0000000000000001
> [  979.063441] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000001047e8
> [  979.071279] R13: 0000000000000000 R14: 00000000001047e9 R15: ffff94dfc4e9af48
> [  979.079098] FS:  00007f19d3d00a80(0000) GS:ffff94e007e00000(0000) knlGS:0000000000000000
> [  979.087911] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  979.094240] CR2: ffff94dfc4bc0000 CR3: 00000007c408c005 CR4: 00000000003706f0
> [  979.102050] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  979.109868] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  979.117669] Call Trace:
> [  979.120393]  amdgpu_gem_va_ioctl+0x533/0x560 [amdgpu]
> [  979.125970]  ? amdgpu_gem_va_map_flags+0x70/0x70 [amdgpu]
> [  979.131914]  drm_ioctl_kernel+0xb4/0x100 [drm]
> [  979.136792]  drm_ioctl+0x241/0x400 [drm]
> [  979.141100]  ? amdgpu_gem_va_map_flags+0x70/0x70 [amdgpu]
> [  979.147003]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
> [  979.152446]  ? trace_hardirqs_on+0x2b/0xf0
> [  979.156977]  amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
> [  979.162033]  __x64_sys_ioctl+0x91/0xc0
> [  979.166117]  do_syscall_64+0x38/0x90
> [  979.170022]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  979.175537] RIP: 0033:0x7f19d405e37b
> [  979.179450] Code: 0f 1e fa 48 8b 05 15 3b 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 3a 08
> [  979.200034] RSP: 002b:00007ffe66c9e938 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  979.208330] RAX: ffffffffffffffda RBX: 00007ffe66c9e990 RCX: 00007f19d405e37b
> [  979.216147] RDX: 00007ffe66c9e990 RSI: 00000000c0286448 RDI: 0000000000000010
> [  979.223897] RBP: 00000000c0286448 R08: 00000001039e9000 R09: 000000000000000e
> [  979.231742] R10: 00005640dcedf010 R11: 0000000000000246 R12: 0000000000000000
> [  979.239555] R13: 0000000000000010 R14: 0000000000000001 R15: 00007ffe66c9ea58
> [  979.247358] Modules linked in: amdgpu(O) iommu_v2 gpu_sched(O) ttm(O) drm_kms_helper(O) cec i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt overlay binfmt_misc snd_sof_pci snd_sos
> [  979.247375]  x_tables autofs4 crc32_pclmul e1000e i2c_i801 i2c_smbus ahci libahci wmi video pinctrl_cannonlake pinctrl_intel
> [  979.354934] CR2: ffff94dfc4bc0000
> [  979.358566] ---[ end trace 5b622843e4242519 ]---
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 104 ++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  18 +---
>   2 files changed, 80 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index e1b66898cb76..295d6fbcda8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -150,7 +150,60 @@ static int amdgpu_gtt_mgr_fini(struct ttm_mem_type_manager *man)
>    */
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_mem_reg *mem)
>   {
> -	return mem->mm_node != NULL;
> +	struct amdgpu_gtt_node *node = mem->mm_node;
> +
> +	return (node->node.start != AMDGPU_BO_INVALID_OFFSET);
> +}
> +
> +/**
> + * amdgpu_gtt_mgr_alloc - allocate new ranges
> + *
> + * @man: TTM memory type manager
> + * @tbo: TTM BO we need this range for
> + * @place: placement flags and restrictions
> + * @mem: the resulting mem object
> + *
> + * Allocate the address space for a node.
> + */
> +static int amdgpu_gtt_mgr_alloc(struct ttm_mem_type_manager *man,
> +				struct ttm_buffer_object *tbo,
> +				const struct ttm_place *place,
> +				struct ttm_mem_reg *mem)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(man->bdev);
> +	struct amdgpu_gtt_mgr *mgr = man->priv;
> +	struct amdgpu_gtt_node *node = mem->mm_node;
> +	enum drm_mm_insert_mode mode;
> +	unsigned long fpfn, lpfn;
> +	int r;
> +
> +	if (amdgpu_gtt_mgr_has_gart_addr(mem))
> +		return 0;
> +
> +	if (place)
> +		fpfn = place->fpfn;
> +	else
> +		fpfn = 0;
> +
> +	if (place && place->lpfn)
> +		lpfn = place->lpfn;
> +	else
> +		lpfn = adev->gart.num_cpu_pages;
> +
> +	mode = DRM_MM_INSERT_BEST;
> +	if (place && place->flags & TTM_PL_FLAG_TOPDOWN)
> +		mode = DRM_MM_INSERT_HIGH;
> +
> +	spin_lock(&mgr->lock);
> +	r = drm_mm_insert_node_in_range(&mgr->mm, &node->node, mem->num_pages,
> +					mem->page_alignment, 0, fpfn, lpfn,
> +					mode);
> +	spin_unlock(&mgr->lock);
> +
> +	if (!r)
> +		mem->start = node->node.start;
> +
> +	return r;
>   }
>   
>   /**
> @@ -181,37 +234,29 @@ static int amdgpu_gtt_mgr_new(struct ttm_mem_type_manager *man,
>   	atomic64_sub(mem->num_pages, &mgr->available);
>   	spin_unlock(&mgr->lock);
>   
> -	if (!place->lpfn) {
> -		mem->mm_node = NULL;
> -		mem->start = AMDGPU_BO_INVALID_OFFSET;
> -		return 0;
> -	}
> -
>   	node = kzalloc(sizeof(*node), GFP_KERNEL);
>   	if (!node) {
>   		r = -ENOMEM;
>   		goto err_out;
>   	}
>   
> +	node->node.start = AMDGPU_BO_INVALID_OFFSET;
> +	node->node.size = mem->num_pages;
>   	node->tbo = tbo;
> -
> -	spin_lock(&mgr->lock);
> -	r = drm_mm_insert_node_in_range(&mgr->mm, &node->node, mem->num_pages,
> -					mem->page_alignment, 0, place->fpfn,
> -					place->lpfn, DRM_MM_INSERT_BEST);
> -	spin_unlock(&mgr->lock);
> -
> -	if (unlikely(r))
> -		goto err_free;
> -
>   	mem->mm_node = node;
> -	mem->start = node->node.start;
>   
> -	return 0;
> -
> -err_free:
> -	kfree(node);
> +	if (place->fpfn || place->lpfn || place->flags & TTM_PL_FLAG_TOPDOWN) {
> +		r = amdgpu_gtt_mgr_alloc(man, tbo, place, mem);
> +		if (unlikely(r)) {
> +			kfree(node);
> +			mem->mm_node = NULL;
> +			goto err_out;
> +		}
> +	} else {
> +		mem->start = node->node.start;
> +	}
>   
> +	return 0;
>   err_out:
>   	atomic64_add(mem->num_pages, &mgr->available);
>   
> @@ -232,14 +277,17 @@ static void amdgpu_gtt_mgr_del(struct ttm_mem_type_manager *man,
>   	struct amdgpu_gtt_mgr *mgr = man->priv;
>   	struct amdgpu_gtt_node *node = mem->mm_node;
>   
> -	if (node) {
> -		spin_lock(&mgr->lock);
> -		drm_mm_remove_node(&node->node);
> -		spin_unlock(&mgr->lock);
> -		kfree(node);
> -	}
> +	if (!node)
> +		return;
>   
> +	spin_lock(&mgr->lock);
> +	if (node->node.start != AMDGPU_BO_INVALID_OFFSET)
> +		drm_mm_remove_node(&node->node);
> +	spin_unlock(&mgr->lock);
>   	atomic64_add(mem->num_pages, &mgr->available);
> +
> +	kfree(node);
> +	mem->mm_node = NULL;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 63e541409549..cecda9d0d067 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -430,22 +430,12 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>   	}
>   
>   	src_offset = src->offset;
> -	if (src->mem->mm_node) {
> -		src_mm = amdgpu_find_mm_node(src->mem, &src_offset);
> -		src_node_size = (src_mm->size << PAGE_SHIFT) - src_offset;
> -	} else {
> -		src_mm = NULL;
> -		src_node_size = ULLONG_MAX;
> -	}
> +	src_mm = amdgpu_find_mm_node(src->mem, &src_offset);
> +	src_node_size = (src_mm->size << PAGE_SHIFT) - src_offset;
>   
>   	dst_offset = dst->offset;
> -	if (dst->mem->mm_node) {
> -		dst_mm = amdgpu_find_mm_node(dst->mem, &dst_offset);
> -		dst_node_size = (dst_mm->size << PAGE_SHIFT) - dst_offset;
> -	} else {
> -		dst_mm = NULL;
> -		dst_node_size = ULLONG_MAX;
> -	}
> +	dst_mm = amdgpu_find_mm_node(dst->mem, &dst_offset);
> +	dst_node_size = (dst_mm->size << PAGE_SHIFT) - dst_offset;
>   
>   	mutex_lock(&adev->mman.gtt_window_lock);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
