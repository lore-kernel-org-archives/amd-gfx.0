Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D527C48BC4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 08:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0768710EB2E;
	Fri, 23 Feb 2024 08:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NvBFbHoy";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C72E10EB2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 08:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmVdHIXMiJjr78pK6FxM9qdWKD2Ipmz+OJ62ERKYKsQq7xSvuTJAVbIWBGkxngN8ADHHBAYIBfA1J0/AO01KaJ7oMWuQGsAJcWxESvXCXEYDE5vVZxjvIIuflG6mPXEV3aVThKgYpkZ29cMYI2IXtzA+2GoB8xTo9RwsECIsJAfw+QzR3OFzOqW/MFi2/PncrJ4mKy0UMTEK/AZbw0AArVgfFAOdWhtV5KBLzU1amcKrt47lhLuV6lhwlqIqx9kNCI8f+mTa+uFS2clpreUgsVyVhwfWnF61lRNrws66LERjq25935VFDtOzDtoCjxLyIlsz/0ByrKDY4K8xQwpfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEQKEN4PKdLoVJUfa/MRcapcvmsaEjwOkj0JhEtAd+w=;
 b=nnPFEXz81KpG5qbF6R9CsKOXZ6UlDqmRmBDnBx+X6zu8ZxMTRL9qaIdDvdXgz202uKyKDhOYa+/VF2wgjzhZdyqYPxw+BXHkTHxJuzuF0Jp3+no0PMvsaAPkdKrbAsmutkt6KDjm5lvQFYRQZxZ4ht5QJ2S/RpCCI5QFtgi92pOEXKWeC3IaEPnU+pF2ffBTFLKnV8AbqrL+gkjhmJnFwbUfF0o7sMTZp41z6fJLq/A+cf9jJusj9+a+uInTr73Dbe9fox0/qL1SoQUUXoECv3sY72SliRuzFsKOUfzNnuOA95CeNZfAOj7azok5+YmlR4MtlCteem2CA6HioieNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEQKEN4PKdLoVJUfa/MRcapcvmsaEjwOkj0JhEtAd+w=;
 b=NvBFbHoy3m/ELdC6l2XbePpa/tjyMljnkPCNPh4+qL/7iVW+eRUELHT4wEoX8gdms84Frvh0ViooqGD+WjQJceqti/98mrqTb6ljr7xxPmBhLTT3tvcE98HTnoJyoU3PD8Pt0FqbBh/WprRxLFUSD0CWDJXBOiyLXYyQXSCnXNo=
Received: from DM5PR07CA0070.namprd07.prod.outlook.com (2603:10b6:4:ad::35) by
 MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 08:24:05 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::e3) by DM5PR07CA0070.outlook.office365.com
 (2603:10b6:4:ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 08:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 08:24:04 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 02:24:03 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: retire gfx ras query_utcl2_poison_status
Date: Fri, 23 Feb 2024 16:23:50 +0800
Message-ID: <20240223082352.323583-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223082352.323583-1-tao.zhou1@amd.com>
References: <20240223082352.323583-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f74948-a1c8-44d8-c924-08dc3448cc35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OD7TjcyHDFnknCXWXhsGPum1TZ9bWu1g0Pn10NWvAMnqmpnXpvInE1RfZ7A579k5KCOdS8XcfkaphD/jLOXAD3VUIXqxbXEHj+Yjghj7biUElwvU5Ssqk+KKk5N0XAFJWRCX7k0y6SZgICjRYjQRNuCgqerMOFmqxy2atv4Y2EHI+nW3jNFhM82+adF734pY4djNtP6TApTUz+o/ocXgZzzVZvmDk24lNHpL1jDzqUycAPqDkv0xkVw/z0zmeQlSm6CwrHMkByfsOWl1s3CLsMgvLb7Y7qz0WiZj1gv0+xUf1NkarPpsdMA5JPj25ULMQddtmVdGQ7oa+djRTnPYA1nIusddfI5GtSVba7KMDo2YTkoJG+RIF8K4ms+JplCsyiRQIOcaNEjlq933dLTa4lXO2dGYmCWHBanG8tznyWZv2w8HZEw2XSofzozEmSvP+jNhLUXzRsoT5TYhwdulzUNMIbJSc1ymlg39YBAwyxrug83HISl1edX8T49dJfr4JxPoMR7tm3d7DKCYFzj8xvO4ZYu0OqzBDFmQCTswrW6hxQHhOvWTB8BBvlq7aJKAEFRXQl1kIPQY0qr8xOqq5B8rMZbfpbYgfgPrg7LzcWU2598yangfQvcstrYNlh+dyR0Dom+Vb3kZcw/isUFV23SfTykLX+fdonY0ggJQBSo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:24:04.7665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f74948-a1c8-44d8-c924-08dc3448cc35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

Replace it with related interface in gfxhub functions.

v2: replace node id with xcc id.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    | 12 ------------
 4 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f759a42def59..817464ee6a01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -776,10 +776,11 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
+bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
+			int xcc_id)
 {
-	if (adev->gfx.ras && adev->gfx.ras->query_utcl2_poison_status)
-		return adev->gfx.ras->query_utcl2_poison_status(adev);
+	if (adev->gfxhub.funcs->query_utcl2_poison_status)
+		return adev->gfxhub.funcs->query_utcl2_poison_status(adev, xcc_id);
 	else
 		return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b2990470d1c6..47d30f67f2b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -404,7 +404,8 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
-bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
+bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
+			int xcc_id);
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a36d153b2ff7..9fa580b85417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -268,7 +268,6 @@ struct amdgpu_cu_info {
 struct amdgpu_gfx_ras {
 	struct amdgpu_ras_block_object  ras_block;
 	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
-	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev);
 	int (*rlc_gc_fed_irq)(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 0d5b4133fdf7..e3ed568eaacc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1909,18 +1909,7 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-static bool gfx_v9_4_2_query_uctl2_poison_status(struct amdgpu_device *adev)
-{
-	u32 status = 0;
-	struct amdgpu_vmhub *hub;
-
-	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	status = RREG32(hub->vm_l2_pro_fault_status);
-	/* reset page fault status */
-	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
-	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-}
 
 struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops = {
 		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
@@ -1934,5 +1923,4 @@ struct amdgpu_gfx_ras gfx_v9_4_2_ras = {
 		.hw_ops = &gfx_v9_4_2_ras_ops,
 	},
 	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
-	.query_utcl2_poison_status = gfx_v9_4_2_query_uctl2_poison_status,
 };
-- 
2.34.1

