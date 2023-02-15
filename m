Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51660C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 21:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F281110E2B3;
	Wed, 15 Feb 2023 21:06:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15A010E2B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 21:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVtxz4mObWDaf51wAPTTFvT4FNfVHgv7rWO6dPpP4ygsO3eBakV0dHpvpOk9km6k7LvAram1INrNQcDodQ+U8EGsFSg0rPbW3H7Nj3OnFlyflf7fFFk+acvNrQvZVHpCASHrBfYwjCRWEnEgzS+8Nn1k0BOmn72DcxyvtCzGfl5tSDCeKJy6mHpHZZLZDVit/02V5n9ylsQCQGB86FRNYWXDrwm1WiU0bdtKZVIx8RIRE6t0+/L1vKq2m9vylmF05wl3VP75SaSl6cPoWSaS7e9hnxDa+mch+sgws6c9j0uMvxGAWrNhVwu659O1S5SHbS3xRWBvOK2oEsPg+rD3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axzJ+iZiGF0oB8Jm3jdnOS39veX9tXY7rrmQ6aLgaWM=;
 b=TPbU24xds1F4c/pNOY0ZMU/sAywYvB/mGeZLKrax6h4DHyefXwmaCbvkTh3xKuAW1H2KlxbGXQV3MNGlEoo/UoIp0/grEgsQV9HVcxsFN8QE1ccjtLwRHjJz3PlvdWl25Rw8Puk0Og8H+Gg8V+jxvLP0qfEm1wOY91W7dzvAz8iri7A1nv/MSyxF8nwJQQBkGAq2y1jdfV4mMJeLq6+7w1L6PpKZYiFKYttiYSteC9+DQ3Xccn/CS2twGvWDQLfqsNMOdWO+RMoTMWaB+8z9KIQSTFVul+fco0d6YI7PVn50CnBcCGCJXW6NC7k5OavSt07ISz4PvTfvavM7GteOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axzJ+iZiGF0oB8Jm3jdnOS39veX9tXY7rrmQ6aLgaWM=;
 b=kxQpSEqqEcU99E2cHnQI8Xw5UImJO3Fy9+18Y78j789VUgLHJdFqbz2IGAa1MLxaSKEvz3CWyDmx2PApeoXhgXJg8D9X1qtwjhJtA5uFfu+dR8guq7vhsLsFHR865dr0AS+xLswRLkiG04ldn7TsvpEOWoQBiCIBrGboOKlqDdQ=
Received: from DS7PR05CA0043.namprd05.prod.outlook.com (2603:10b6:8:2f::22) by
 BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 21:06:33 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::c1) by DS7PR05CA0043.outlook.office365.com
 (2603:10b6:8:2f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12 via Frontend
 Transport; Wed, 15 Feb 2023 21:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 21:06:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 15:06:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 15:06:32 -0600
Received: from hwentlanrmb.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 15 Feb 2023 15:06:32 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Select DRM_DISPLAY_HDCP_HELPER in amdgpu
Date: Wed, 15 Feb 2023 16:06:29 -0500
Message-ID: <20230215210629.382482-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|BN9PR12MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: 60673436-66c4-4aff-4e74-08db0f98842b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euDcH+toJeuJtl83MWN+zIjYbgk+hwrhloPxCoR9kJgm7Cxz35S3BcgYirk3F75gqfCaZqdcUg3R5SyeUIjliDx11HAD4zZvzw+XRHJNxx4f0Fy4VY6kjQBJeZMtrkhrgeMiiB11NLVAJQuCP9jFXiVLjqIicfyI3n8rSDZzlDPdrVmbg5qIDQRquRHrJmlHejvb9ncAhPopzXkqTgZPX1xci6cgUQVCuGH0WEmUZ1w7RYHCf86j5JmFCQIMZLBcchi/aIoFyOQ5fR4I6XNmx0X9UWWXAbQh08n7p9eqs21MhPBOXt1eBH+QMVvWBz4sFHu38cruGX3rLiAuVEW6H2BTZY5v5vk2LydHp3ue6TnvvWab3SzjDJIUMKqSVfdTEygiKkZNNChtMnbxmOg541i8Ht7TZJAczT3GwVyf2xLS7NFMOVTPTvTqqwMrFnSj+Gwir60xRRRbm/gudYh8f3hC4cZtQzxTsXic2XAGhxHGFsYLW7mlVyaEdYgAqcFdV+RFQUuWPyrWCztFA8gmHzXyRbde5mDHf6XppXw1sFKNZEmSZjt/235IpRzFty+HPMwPs+pgeLYoH9EImUB/wlz7c0LE2QXZlUE7PFZGMJ8dQVH4ZPMGSCedxk8+5jbeWOPNnbLv5f3h6WLr42aWKFfmCytVA7PT6oMDt47QnWOy5E14aU9pnsXbRe98gNtKAAowIXlgZ+nmY2r3CttgX3mWsvj4mUx3S72tKghJLLQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(47076005)(336012)(2616005)(83380400001)(426003)(478600001)(186003)(7696005)(26005)(1076003)(6666004)(36756003)(86362001)(356005)(36860700001)(81166007)(82740400003)(82310400005)(41300700001)(40480700001)(44832011)(40460700003)(8936002)(70586007)(5660300002)(316002)(6916009)(70206006)(4326008)(8676002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 21:06:32.9152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60673436-66c4-4aff-4e74-08db0f98842b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5257
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
Cc: Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Keeps this selection with the rest of the DRM HELPER
selection.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig  | 1 +
 drivers/gpu/drm/amd/display/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 5fcd510f1abb..c9ef04158081 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -6,6 +6,7 @@ config DRM_AMDGPU
 	select FW_LOADER
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
+	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
 	select DRM_SCHED
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 1cdb379a90d7..195ad3ca5aa9 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -21,7 +21,6 @@ config DRM_AMD_DC_DCN
 config DRM_AMD_DC_HDCP
 	bool "Enable HDCP support in DC"
 	depends on DRM_AMD_DC
-	select DRM_DISPLAY_HDCP_HELPER
 	help
 	  Choose this option if you want to support HDCP authentication.
 
-- 
2.39.2

