Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB1EC47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 23:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD32710E69B;
	Wed, 24 Jan 2024 23:22:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F088A10E69B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 23:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3/uzsbXOEqjzShpxp+oE+JB+euZ9bbGne7NQGme/ItyIACGIbmqZeF5GTInf/4XO+CB+K72qQmwDbKPgBU12bCqHyhX6zd9VmwK2TGB0eH1mDPuk7F8EYkJP7cW6fjtN+h4HVdrhjKyuU2zhWDyrTN2hzOnXESQb4PIgzEBP6awTWvy7kvrxoQ181R+rU0I8/1+l9fsS1mPkmbAjRESul+SRCvlG/TNqx5Au+97qJKrDIvy+4Y+yGtg/o3Gl1VpAQCKZtQUJAVa22cAGiBXNv2ELqK0Nwc4HIcgh+fl3+ekB4XhnxsG10HYYJR9Z8K9iozCOkQOw7vz2n+Rz0Y4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWOBcpl/fpGACgrrBwX3cdV5X1SybvEZhRHTtc/Mhks=;
 b=IqczSiZ3gY2ep4ReZsV+KvCFRBeJDX3qQwhwaMHt3G1J0VjMKyGkUQcqBkgTbQ4LYnNodTWldYjHero9DWh9AGvFwojCiW1zZAgjM6PYnfFbQ+35bl00NJrG70BgR6bso5kciNpOX7Ge7WcgR47RZlPTdckuY1CQdncStHjFuJWIXu2elT/DgBYKPh+pTzOKFCd50RgjHJB7iRjNeeUu8DCCziu5PUCe1SL2Zy2CnWl93N88N4FtPcj+YL8vZYJO+OssFksTafRyeCBInoGqhii14S7RjuMOGhntgnin0h3O6AaToPx/jQF7LOjYiYCwBUtbmpIstqPTfqWkIHf4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWOBcpl/fpGACgrrBwX3cdV5X1SybvEZhRHTtc/Mhks=;
 b=duuV5jbaCBEDPIspaMnF8K2Yd2enGM4hdO2vIfdKXb6GRZmu7G+VgMYEFfBcR3RjBvx4Vc7Yle8NkuLfuq4X2ADxu+QFNgK1MgO0mB9MZb5fRXeivetqucsnWOqzgo0jDBHWbMw/R4CsfsO4ZetAddONHyU9gZTPKgxDHBkDbsg=
Received: from DM6PR07CA0118.namprd07.prod.outlook.com (2603:10b6:5:330::31)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 23:22:02 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::e7) by DM6PR07CA0118.outlook.office365.com
 (2603:10b6:5:330::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 23:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 23:22:01 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 17:22:01 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Support passing poison consumption ras block
 to SRIOV
Date: Wed, 24 Jan 2024 18:21:41 -0500
Message-ID: <20240124232143.7201-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: bef105b7-4905-4b37-fa5b-08dc1d334511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnI7qN+WChLC/Yo+pfW+vW7kN6v2U/iWiH3M9Kof93nf6I52wJA6pSC2l1fAc3sC/3tSJrknLakhoSqNJ+8wv6SJWhZH0vX/Z9BKtL9813yLpSb2sRI3RiTzujFqh+bMpYpPZ257ZVlPakB2H3cSm85WjLbyllCej9obkn40jA4iQ/ct3ljRB05ZHFRQQU4zIepUNjD32H/3U2KDGXOVqsAeUVUHo91V+ooHeB6jPWDqh1gOJ78kqkR5hJXHEAQUohcT3JaSlxhtSJCxgYy8svpOdXGTtckgASvSA+M4kurox6B6Nh839Bd5O4h4nkLO0zjwNgT70pnp/Tu37rgSN9W8ICI1erAC09CPnCb2XUg4XrhKlD/NmsUZlsYxJg+mjBqTjkZVkavGiLg+wCGrLJn/B/4Ew67OyPl6d5Z0HzzyWXrWdzTbWN7sdfIkENk81c5IIeKUsnq6kY2Ma0IYHW2kXNSlb7d6mOsT8EBr4X7LG2CyJP9M3DZLPY6E0+tmcdmBrF5HZjzAV/GkljaYGICSKDH/53iX20G5AvETWRJgTfL9a4dsld0ud2rGCF9v1KIaJ1nrbOEXUhKAVk2e3Dq6OMdaLmsC0HsAts8TH9b3cwwwJWMx9arrb8oDBDZa0Nt/EQsYOo2/7619GbkZIPGr0frMhjIOT5agnNlMfqi4PKVrylp1Mg1OXxxETKAAwT8J6sEeOsyG8BYeD5zkfVd75WLtFr7VfIpkhEvGFpumUPfeVNFaQKjVuDMScAa5EWE76yuUCgi4uK87pr6kgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(7696005)(426003)(336012)(26005)(16526019)(83380400001)(2616005)(1076003)(36756003)(8936002)(8676002)(4326008)(6916009)(316002)(2906002)(54906003)(30864003)(5660300002)(86362001)(70206006)(70586007)(6666004)(41300700001)(478600001)(36860700001)(40480700001)(40460700003)(47076005)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 23:22:01.8330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef105b7-4905-4b37-fa5b-08dc1d334511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
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
Cc: YiPeng.Chai@amd.com, Sashank.Saye@amd.com, Victor.Skvortsov@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: YiPeng Chai <YiPeng.Chai@amd.com>

Support passing poison consumption ras blocks
to SRIOV.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         | 23 +++++++++++++++----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  |  7 ++++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  7 ++++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  7 ++++--
 13 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 77e263660288..dfb93664e866 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -732,9 +732,10 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev)
 	amdgpu_device_flush_hdp(adev, NULL);
 }
 
-void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bool reset)
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
+	enum amdgpu_ras_block block, bool reset)
 {
-	amdgpu_umc_poison_handler(adev, reset);
+	amdgpu_umc_poison_handler(adev, block, reset);
 }
 
 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 584a0cea5572..50d3e0149032 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -334,7 +334,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
 int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
-				bool reset);
+			enum amdgpu_ras_block block, bool reset);
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebcd1cb60052..79bf6bd428a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2041,7 +2041,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 		}
 	}
 
-	amdgpu_umc_poison_handler(adev, false);
+	amdgpu_umc_poison_handler(adev, obj->head.block, false);
 
 	if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumption)
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index a6cdb69897f2..20436f81856a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -246,7 +246,8 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 	return 0;
 }
 
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
+			enum amdgpu_ras_block block, bool reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
 
@@ -297,7 +298,7 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 		}
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
-			adev->virt.ops->ras_poison_handler(adev);
+			adev->virt.ops->ras_poison_handler(adev, block);
 		else
 			dev_warn(adev->dev,
 				"No ras_poison_handler interface in SRIOV!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 83199296ed10..26d2ae498daf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -102,7 +102,8 @@ struct amdgpu_umc {
 
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset);
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
+			enum amdgpu_ras_block block, bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f4963330c772..f300d4a4457d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1189,7 +1189,7 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 		amdgpu_ras_interrupt_dispatch(adev, &ih_data);
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
-			adev->virt.ops->ras_poison_handler(adev);
+			adev->virt.ops->ras_poison_handler(adev, ras_if->block);
 		else
 			dev_warn(adev->dev,
 				"No ras_poison_handler interface in SRIOV for VCN!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 1b49c007ff62..fa7be5f277b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -88,7 +88,8 @@ struct amdgpu_virt_ops {
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
 			  u32 data1, u32 data2, u32 data3);
-	void (*ras_poison_handler)(struct amdgpu_device *adev);
+	void (*ras_poison_handler)(struct amdgpu_device *adev,
+					enum amdgpu_ras_block block);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 26d6286d86c9..9e7ce1e6bc06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -69,7 +69,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
 		amdgpu_ras_interrupt_dispatch(adev, &ih_data);
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
-			adev->virt.ops->ras_poison_handler(adev);
+			adev->virt.ops->ras_poison_handler(adev, ras_if->block);
 		else
 			dev_warn(adev->dev,
 				"No ras_poison_handler interface in SRIOV for %s!\n", ras_if->name);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 63725b2ebc03..a2bd2c3b1ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -404,7 +404,8 @@ static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
 	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
 }
 
-static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev)
+static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev,
+					enum amdgpu_ras_block block)
 {
 	xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 6a68ee946f1c..d0a018da3c7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -152,14 +152,14 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 	xgpu_nv_mailbox_set_valid(adev, false);
 }
 
-static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
-					enum idh_request req)
+static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
+			enum idh_request req, u32 data1, u32 data2, u32 data3)
 {
 	int r, retry = 1;
 	enum idh_event event = -1;
 
 send_request:
-	xgpu_nv_mailbox_trans_msg(adev, req, 0, 0, 0);
+	xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
 
 	switch (req) {
 	case IDH_REQ_GPU_INIT_ACCESS:
@@ -206,6 +206,13 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
+					enum idh_request req)
+{
+	return xgpu_nv_send_access_requests_with_param(adev,
+						req, 0, 0, 0);
+}
+
 static int xgpu_nv_request_reset(struct amdgpu_device *adev)
 {
 	int ret, i = 0;
@@ -424,9 +431,15 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev)
 	amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
 }
 
-static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev)
+static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block)
 {
-	xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
+	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0)) {
+		xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
+	} else {
+		xgpu_nv_send_access_requests_with_param(adev,
+					IDH_RAS_POISON,	block, 0, 0);
+	}
 }
 
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index a7697ec8188e..9a06c6fb6605 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -132,6 +132,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 static void event_interrupt_poison_consumption(struct kfd_node *dev,
 				uint16_t pasid, uint16_t client_id)
 {
+	enum amdgpu_ras_block block = 0;
 	int old_poison, ret = -EINVAL;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
@@ -151,12 +152,14 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
 		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
+		block = AMDGPU_RAS_BLOCK__GFX;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
 	case SOC15_IH_CLIENTID_SDMA2:
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
+		block = AMDGPU_RAS_BLOCK__SDMA;
 		break;
 	default:
 		break;
@@ -171,12 +174,12 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, false);
 	} else {
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, true);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 2a65792fd116..c6d28e37ed46 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -191,6 +191,7 @@ static void print_sq_intr_info_error(uint32_t context_id0, uint32_t context_id1)
 static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
 				uint16_t pasid, uint16_t source_id)
 {
+	enum amdgpu_ras_block block = 0;
 	int ret = -EINVAL;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
@@ -210,8 +211,10 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
 	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
 		if (dev->dqm->ops.reset_queues)
 			ret = dev->dqm->ops.reset_queues(dev->dqm, pasid);
+		block = AMDGPU_RAS_BLOCK__GFX;
 		break;
 	case SOC21_INTSRC_SDMA_ECC:
+		block = AMDGPU_RAS_BLOCK__SDMA;
 	default:
 		break;
 	}
@@ -221,9 +224,9 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	   resetting queue fails, fallback to gpu reset solution */
 	if (!ret)
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, false);
 	else
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, true);
 }
 
 static bool event_interrupt_isr_v11(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 27cdaea40501..91dd5e045b51 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -143,6 +143,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 				uint16_t pasid, uint16_t client_id)
 {
+	enum amdgpu_ras_block block = 0;
 	int old_poison, ret = -EINVAL;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
@@ -162,12 +163,14 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
 		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
+		block = AMDGPU_RAS_BLOCK__GFX;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
 	case SOC15_IH_CLIENTID_SDMA2:
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
+		block = AMDGPU_RAS_BLOCK__SDMA;
 		break;
 	default:
 		break;
@@ -182,12 +185,12 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, false);
 	} else {
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, true);
 	}
 }
 
-- 
2.25.1

