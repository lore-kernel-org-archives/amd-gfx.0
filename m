Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D187C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 00:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D8A10E18F;
	Thu, 24 Feb 2022 00:54:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE7510E18F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 00:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMOgpzg4PLo/3gN0uLAZxn3yFa4FqkBelJskJqi34n9ilaSolQbsaw5xyC/H7Swb8g9rmXmmU7djWz5fnc6TViS6CB+HXqP7Fyq9aZv+1EJmztvvkwrIm9HL14tk57+3vUCuj9JgwMKhUhlibbzxifBPiMAEj6eBV723lQFFMJ+IH6E58fG3Nd/d0pmxH7dX4nSHiEsgb87bki9lYpQO0VdW+ZNOc0QtAJuapGN6wrfPbHzEUq0qffFfaT0X2qjrwcUQgjOeAsBSvChUBM5LF0wN+89oNFM34mGdOoDNYnbsVnTBOrYlJbhIRFsK6EkMh3m6gzt2J1yyoFzhBTpQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRhJMTX4xl4pOz8tYBk40W0BOqXB3kkJu6e7QvmIyOM=;
 b=OFE9wfFsL0Q7fSpO7djHBaqXfQWeemn9y/H4FWX73p7xnjcRZD0Bi/iZHUwujcp5z8DAoaPltVR2SzJ8IsBHMOwkUIuWaqxjDPxrMd5W30zMu5QZCBUEMK4ZzpkadIkDGujWLd5L5tD7Saiq0HPhpAbaEtztdAFVYQrC2T8/aTxG6/L7jyyI0FHemkOAj2yOCHiN4q1iMAj4US6rHKD9KzmLX2pDAHIsx8iW5NLqeSMmiLLc2Sn5M2+iOmeUPYDKbHEyW8KKGWF9qd5nnKPy74R3pY7A1b1Qj4eJ3ENrvYufE6U/D2nwLAoppkOVE1qzu+8O7FpcEvbJ8l1Frw63gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRhJMTX4xl4pOz8tYBk40W0BOqXB3kkJu6e7QvmIyOM=;
 b=qpkxUH9oxGJSjoTg734J7Kk7Ey6CydxAEM0WC2juR1wsm7SZ3ed9XMl8uq1PD8XS8X0Yrswq+5Qucsv8BOg8RNz5N7n4fwuTlvh/FXXzETGrXsBicGKsx2VOfd6KJkUqQbvySbihaBj/I+j6kuuAKCQ6xsDcGicIvAaRwUpquns=
Received: from DM6PR02CA0042.namprd02.prod.outlook.com (2603:10b6:5:177::19)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 00:54:36 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::aa) by DM6PR02CA0042.outlook.office365.com
 (2603:10b6:5:177::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 00:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 00:54:35 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 18:54:34 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add use_xgmi_p2p module parameter
Date: Wed, 23 Feb 2022 18:54:18 -0600
Message-ID: <20220224005418.23426-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <f55192e6-3f85-715e-6b5f-9b188a7ba949@amd.com>
References: <f55192e6-3f85-715e-6b5f-9b188a7ba949@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae6f76a3-8c8e-4fdb-9e58-08d9f7303a47
X-MS-TrafficTypeDiagnostic: BN9PR12MB5322:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53221C853683830086386CDEFD3D9@BN9PR12MB5322.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzK7GeEh8HNsh38irqf165X6IEt7nuedW9NRuWFgOuIWX6YH1Id7YxceBvnZ8iqr2Lw4mIBHesK6U2pC9UnfQ1XwHvdSZPv0kjvGLXvwO9TpT5RSxHzkUEePyu2zoJiVbiW+1peipwgflf1ZUBk1ZBGzj1CLlxc9FRvFiyUkq60wRAlVBX0CuQSCq8W6m8cF2NjDrxV7SGZ1GX59bFAv3CH3xS3J+9PJj9Tai8J/nRCZ1DayrlFfYZl47vI9+vPx54sUwfXe7BgzxPRrbSzAdB8uZAOxtut+ix/NZsuoqjnu2h6POt29tujI9fCs0N30CDE0Oufw7NnPm1+qR/7fhKoowMKz5sfdRm/OyaPcfD+1GgCCJlpeetuVGjr4cE2NaBxX8Z0O7JzK/cBGFyJlkQUkGxr4YlDXoh0DCCpCZqIeh8n/7XKiug9FTBsZiPhGAo4lAN/0FQdwxGm3L/AgxQIJ5W077+Y1Jty6Z1kSe17PoU3xFE4V7IJPlY769mv13uWtIX6wI/++f8RJ6DmtzwVuFC703EnjUXwpbCh5wFvS3MrsV4fqd9E11RAjVICyFKcyfjr9Pjw8CNiFJiiLkrUiI0TRVA9EGwV3ItXPi4CYMF1FS2ZDmdqjKmZqYmuXxWTalm+m+ZVyE3zo3N69ioN9MQw02EphvaKl5f0AGVaxP0vFMjX9k2fdHCVF7ATO/VA7Yc0+4Vtf41nbr8uPGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(47076005)(7696005)(6666004)(40460700003)(508600001)(2616005)(2906002)(36860700001)(86362001)(70206006)(16526019)(5660300002)(8676002)(54906003)(6916009)(4326008)(26005)(8936002)(316002)(82310400004)(426003)(44832011)(336012)(356005)(81166007)(83380400001)(70586007)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 00:54:35.6805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6f76a3-8c8e-4fdb-9e58-08d9f7303a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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
Cc: Alex Sierra <alex.sierra@amd.com>, jonathan.kim@amd.com,
 Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, luben.tuikov@amd.com,
 aurabindo.pillai@amd.com, alexdeucher@gmail.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This parameter controls xGMI p2p communication, which is enabled by
default. However, it can be disabled by setting it to 0. In case xGMI
p2p is disabled in a dGPU, PCIe p2p interface will be used instead.
This parameter is ignored in GPUs that do not support xGMI
p2p configuration.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f97848a0ed14..7e95d8bd2338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -217,6 +217,7 @@ extern int amdgpu_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
+extern int amdgpu_use_xgmi_p2p;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2f8eafb6cf22..2849972fd910 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -181,6 +181,7 @@ int amdgpu_tmz = -1; /* auto */
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
+int amdgpu_use_xgmi_p2p = 1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -677,6 +678,13 @@ MODULE_PARM_DESC(force_asic_type,
 	"A non negative value used to specify the asic type for all supported GPUs");
 module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
 
+/**
+ * DOC: use_xgmi_p2p (int)
+ * Enables/disables XGMI P2P interface (0 = disable, 1 = enable). The Default is 1 (enabled).
+ */
+MODULE_PARM_DESC(use_xgmi_p2p,
+	"Disable XGMI P2P interface (0 = disable; 1 = enable)");
+module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
 
 
 #ifdef CONFIG_HSA_AMD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 0afca51c3c0c..095921851fb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -66,7 +66,8 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		struct amdgpu_device *bo_adev)
 {
-	return (adev != bo_adev &&
+	return (amdgpu_use_xgmi_p2p &&
+		adev != bo_adev &&
 		adev->gmc.xgmi.hive_id &&
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
-- 
2.32.0

