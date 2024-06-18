Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BC7C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 07:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433B610E271;
	Tue, 18 Jun 2024 07:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oh38Ht7a";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C3010E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 07:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/wTgLccTvqc4OdK2GpcyJbcA5k6HNZ42yXvfGXe/jq7AYowcfgvxHKyfSSpT/DWNcTc/UcK9vJ2qRgwxg896JYSXfkFy2zDNrUXrXfgOhplySyNt2W2nKp4z9ViBmv2K+R8x2esZa9yA4rdy9GQkctnQcSOAIt+K+4TB7QhYZfxTgITZdC1MLYwkhQwtrP4km/o1qWJh8YH0vvPmFrdimnLIKljUe/PXE/QpG8MnqNEMZlVw4VKxnDPgqSpN//mIY/TQK+XeWOLUWptG6CNC/QXyX0DuGhfveGv1+GICVZX+FERi3Hps6JeA/DvbFRdnb1O5miwgr6Q2eVUGGnO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I4yHQG1joHrS9wi8W/jpNdsBTO8JxcbJDSIN+siS5A=;
 b=dAu1Ghda3HV6dTO/Tg9cgFtOHXid5OFGJ1YGi6Fdop0b7yTf8KqhpnkUuqmob/pNUYaNDLgLLgKApwt13x/6M7ZaJuQs/v0WyJ9JJgO+xg8uRR29yokTjQoRIfgyzDdc+1NdU1cOMj4CeSjm4DLSZ266AlA79u9ID31WhLihRpOelWMpcNDJIV4ie2Y51fgjYg8mIXe+DnSXVqGpj7DcfrOnKFaiTR6JUPp4ldz6dEln8KLpYnKPgY8AGJDAiCUmvZcbFA+dXQjaTASP36CIQK//QknrW/xuN0lbqwg3hfjxjju3HBTsiPG/fbCJ4kRkfV7igW7AeaWJPHaZZMO8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I4yHQG1joHrS9wi8W/jpNdsBTO8JxcbJDSIN+siS5A=;
 b=oh38Ht7aMkaqUjqbF2uYBgsmWsddUV6J+DXWM2GXihGFljz9PbvgKH6tkaycYzBaqQOB4eauDxt6s22/BzP81VYWhU3j7uBlJ9ApeU5BwpSo4+bFDR37bG2hzjtPTCy0855XEw36DUrdNswP27j6DQOjxIh9oKlACgLIVfMm/eY=
Received: from SJ0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:33a::8)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Tue, 18 Jun
 2024 07:48:49 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::f6) by SJ0PR03CA0003.outlook.office365.com
 (2603:10b6:a03:33a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 07:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 07:48:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 02:48:46 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipechai@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: change bank cache lock type to
 spinlock"
Date: Tue, 18 Jun 2024 15:48:34 +0800
Message-ID: <20240618074835.1439008-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 667e4fa2-ca01-4bed-684d-08dc8f6b16d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1TPD6ulxKJrOjPbw/Ng5db5kGShITsgBi0rdfB8i+4PEfqKryZTPR8VDXWfw?=
 =?us-ascii?Q?XMgRoj9IcnLBTUkPcXhl9bo8gmnptUhL+c3p2Nq3kZffDCEBHYgw6rt9VzBP?=
 =?us-ascii?Q?SsWxmxKMuaXseXxPApUnhQECGsbZW3uHVPYMpZ6JpsDaTGVSNtMeohpN4sWP?=
 =?us-ascii?Q?tDgnxhsgo6Akq4XXtudXMkin5YUyISSK9R0KKtYY4X9/j+1vzTOSnOex2hsS?=
 =?us-ascii?Q?ndLcOuKP3VDlifGaaekYirlsALo1v/WXYP6pyB2TQHSnjldhq+Bs2PdoDiBt?=
 =?us-ascii?Q?ci2hPvp9UHoxfiu2id7J1va1xpPQwj2kjh8G+QronZSE57834cmq3LeiRqdL?=
 =?us-ascii?Q?HC3R4x5Xyo+MxWi1WvoMuxu+CkrBllx+K7KaFPjsqVbRY7Uj6Pof6O7q997j?=
 =?us-ascii?Q?RxwFqz58mr5pspZar2vsv9bEth/oNUhhH/vw0LOLIJldezukWyEvOv3d10GN?=
 =?us-ascii?Q?sc63wDT6wC17hECxDrnBX9BkDMuRPYYg2sW2QcKEMiCjopACyj0/GOAiXxSS?=
 =?us-ascii?Q?EzaDvxLNhhMDxwSbbRqYGS0mY5Darllf6k6FHlhXfR8Y695uPPqkuFSBno6R?=
 =?us-ascii?Q?MPxtU3XlYrWvN8kMFyg9B23q+rB44SdgeDgkd1QXhyA0aDD5QKoi3WDb+x2n?=
 =?us-ascii?Q?e/UpLFUZdcNRohNj7RL1CKWmUG8m6h9A/we3eQXh264veHQugbaokYVI3pWE?=
 =?us-ascii?Q?Z0b44B+gmfnabcE9l+7Lpn3TeuPSc+xCeiH+cGZRvR5WJ2wEEYKsihf7uQY3?=
 =?us-ascii?Q?3NNeh6jz2zEVnQJWETHu+nTE8o80/fe6SN4eFzga+DHD0aMPp2RXg2i7hGwK?=
 =?us-ascii?Q?5fveus+ZSDYrbDIU0IDFk/L17jHNp+LnaG4uuXRDa/exmh3l/5rdeEImBb0P?=
 =?us-ascii?Q?frvGaYALI9qaAsayjORDwtd29UdjKc0/Sfw6EwySXQOgyZHTAtZNfvgE5lPe?=
 =?us-ascii?Q?ZKFgijJnlPCXRbiDUTtzDo4tBwAZu8WLoz/39rkM/jDXiOFU/ewUAmC+V6Pk?=
 =?us-ascii?Q?jn8yNlviynjbtXxnUhpkOREGZCQb9hHR7hf6DrQnMZvuh+UiDCNQ2WTOdITr?=
 =?us-ascii?Q?an3PcqKY0Lpug/kzmzCvWJ7zvr3MRrl6CeKNJaVuH7LJKseSO06v4eUMAwQu?=
 =?us-ascii?Q?Ch40yNzHvHwOd+q442v8pbKh5R3nP4qyKYKae6lx/JDQ8dvsnS6Gm41uJeXt?=
 =?us-ascii?Q?+KuygVaHBghngGYCpjYGf7GogGyT98b6C06h01RS0g0+XimIw8ZAJPlcXH8W?=
 =?us-ascii?Q?s8NX8q4zwm8902JT/aaCMMQgkF5BAf9z8dvtz93XL22oMZwrui4JZZyI8RZW?=
 =?us-ascii?Q?EEdAWQ6k8jI3dI/3xH38EFuBdJDHOcsO9Nb6r0OWg9roz4xQEImyXUBnEW4B?=
 =?us-ascii?Q?cL6koW43FxFnsEKa0ZPx4PruzkOUmAQqZTt8YEn3i1efNn+i5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:48:48.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667e4fa2-ca01-4bed-684d-08dc8f6b16d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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

This reverts commit 379e6cd11499f35d67bbf8f0114b0a054b9f73d7

revert this patch to modify lock type back to 'mutex' to avoid kernel
calltrace issue.

[  602.668806] Workqueue: amdgpu-reset-dev amdgpu_ras_do_recovery [amdgpu]
[  602.668939] Call Trace:
[  602.668940]  <TASK>
[  602.668941]  dump_stack_lvl+0x4c/0x70
[  602.668945]  dump_stack+0x14/0x20
[  602.668946]  __schedule_bug+0x5a/0x70
[  602.668950]  __schedule+0x940/0xb30
[  602.668952]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.668955]  ? hrtimer_reprogram+0x77/0xb0
[  602.668957]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.668959]  ? hrtimer_start_range_ns+0x126/0x370
[  602.668961]  schedule+0x39/0xe0
[  602.668962]  schedule_hrtimeout_range_clock+0xb1/0x140
[  602.668964]  ? __pfx_hrtimer_wakeup+0x10/0x10
[  602.668966]  schedule_hrtimeout_range+0x17/0x20
[  602.668967]  usleep_range_state+0x69/0x90
[  602.668970]  psp_cmd_submit_buf+0x132/0x570 [amdgpu]
[  602.669066]  psp_ras_invoke+0x75/0x1a0 [amdgpu]
[  602.669156]  psp_ras_query_address+0x9c/0x120 [amdgpu]
[  602.669245]  umc_v12_0_update_ecc_status+0x16d/0x520 [amdgpu]
[  602.669337]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669339]  ? stack_depot_save+0x12/0x20
[  602.669342]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669343]  ? set_track_prepare+0x52/0x70
[  602.669346]  ? kmemleak_alloc+0x4f/0x90
[  602.669348]  ? __kmalloc_node+0x34b/0x450
[  602.669352]  amdgpu_umc_update_ecc_status+0x23/0x40 [amdgpu]
[  602.669438]  mca_umc_mca_get_err_count+0x85/0xc0 [amdgpu]
[  602.669554]  mca_smu_parse_mca_error_count+0x120/0x1d0 [amdgpu]
[  602.669655]  amdgpu_mca_dispatch_mca_set.part.0+0x141/0x250 [amdgpu]
[  602.669743]  ? kmemleak_free+0x36/0x60
[  602.669745]  ? kvfree+0x32/0x40
[  602.669747]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669749]  ? kfree+0x15d/0x2a0
[  602.669752]  amdgpu_mca_smu_log_ras_error+0x1f6/0x210 [amdgpu]
[  602.669839]  amdgpu_ras_query_error_status_helper+0x2ad/0x390 [amdgpu]
[  602.669924]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669925]  ? __call_rcu_common.constprop.0+0xa6/0x2b0
[  602.669929]  amdgpu_ras_query_error_status+0xf3/0x620 [amdgpu]
[  602.670014]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.670017]  amdgpu_ras_log_on_err_counter+0xe1/0x170 [amdgpu]
[  602.670103]  amdgpu_ras_do_recovery+0xd2/0x2c0 [amdgpu]
[  602.670187]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.670189]  ? __schedule+0x37d/0xb30
[  602.670191]  process_one_work+0x176/0x350
[  602.670194]  worker_thread+0x2f7/0x420
[  602.670197]  ?

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index c7e602d69f2c..9d3a3c778504 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -232,7 +232,7 @@ int amdgpu_mca_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
 		mca_cache = &mca->mca_caches[i];
-		spin_lock_init(&mca_cache->lock);
+		mutex_init(&mca_cache->lock);
 		amdgpu_mca_bank_set_init(&mca_cache->mca_set);
 	}
 
@@ -250,6 +250,7 @@ void amdgpu_mca_fini(struct amdgpu_device *adev)
 	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
 		mca_cache = &mca->mca_caches[i];
 		amdgpu_mca_bank_set_release(&mca_cache->mca_set);
+		mutex_destroy(&mca_cache->lock);
 	}
 }
 
@@ -454,9 +455,9 @@ static int amdgpu_mca_add_mca_set_to_cache(struct amdgpu_device *adev, enum amdg
 	struct mca_bank_cache *mca_cache = &adev->mca.mca_caches[type];
 	int ret;
 
-	spin_lock(&mca_cache->lock);
+	mutex_lock(&mca_cache->lock);
 	ret = amdgpu_mca_bank_set_merge(&mca_cache->mca_set, new);
-	spin_unlock(&mca_cache->lock);
+	mutex_unlock(&mca_cache->lock);
 
 	return ret;
 }
@@ -486,10 +487,10 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 	}
 
 	/* dispatch mca set again if mca cache has valid data */
-	spin_lock(&mca_cache->lock);
+	mutex_lock(&mca_cache->lock);
 	if (mca_cache->mca_set.nr_entries)
 		ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_cache->mca_set, err_data);
-	spin_unlock(&mca_cache->lock);
+	mutex_unlock(&mca_cache->lock);
 
 out_mca_release:
 	amdgpu_mca_bank_set_release(&mca_set);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index c3c184c88dad..e80323ff90c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -84,7 +84,7 @@ struct mca_bank_set {
 
 struct mca_bank_cache {
 	struct mca_bank_set mca_set;
-	spinlock_t lock;
+	struct mutex lock;
 };
 
 struct amdgpu_mca {
-- 
2.34.1

