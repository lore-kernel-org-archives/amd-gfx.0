Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A504C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD34810EB7F;
	Thu, 27 Apr 2023 15:02:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A2610EB7F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUjufAKfwzv0TtdIJTIoo6U6+Sm2yoTpSYvP7DneWlaYFZbH12kd2vk+QEgV3N5ywuEiSdW9jNW2GaMkiFBZLLkntfWpVeQDjBMshnkh54+B4BvNIpQRR03nolkW6qGv8sMHhTmapZfQLJ3uOFDKtRyDVx8/KR1BtrznF6jm/rgA1okx+/UfVHYVIFUylNQvYJ6mUapWJqu3Ig/Bzj3Cksel8+SwkuNLov2o48P4e9gJRAHL4p7IpJsbdabAeVUrblor7w5tIbWmq1EpW/6/OVmRkUyI3C4hBkkwTtjHlDvGAEw6SDbT5WL5WbYlOL1knuQHNpMMKQn646lg9E6rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=royUFqaiey9cqpzLYBZ7fZY4mvEVssEEfKede94bJWQ=;
 b=LH1tju7Q3p7mHGFPw44n5VTiWRwDn2kZRPslTkErO6xFKV4vm4W1jyBLWB1HDFY1qWrJ0NEB/ugYbnCzWQo0eJ7IQnUDs6Lju/02Gs2WDoUz1GWUsevweuFf6rnpTXpxH27XYgWnxpRG165W6yfpeSf4N+MtpR4ZK+TAROYk+BX0W9gtk6ShlCpsnirg2j+tTr7k97kWBVZcvvkcTaysqdLUKbC5X5WmPuZ8EjUNrAWbYc0SKshqQwYqOAl2CCnd89ayR5/chuGd0e9D5edeeZKv3pihqV0wo9LN1t3Nr+ND9W+3M7knFpsK1QYZ0siaXHNcAAi/+QDxgj/YV3F5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=royUFqaiey9cqpzLYBZ7fZY4mvEVssEEfKede94bJWQ=;
 b=OZA1oyuvx5cYC9Lyb8/AYgigkRQGt5OltqMsoKLWolg9Mn/eM850QBmqY5uutcTCZdnD5KuFW1v5+11vIIC2JPmwRB8So5qU5ocfwU00CrBanas3P7cnadcHe4P5o7G6cHpAFJ3ybt2A2ddVA0R36qspPAAnxrFcIelTm3ILYbE=
Received: from CY5PR13CA0041.namprd13.prod.outlook.com (2603:10b6:930:11::27)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 15:02:13 +0000
Received: from CY4PEPF0000C985.namprd02.prod.outlook.com
 (2603:10b6:930:11:cafe::2c) by CY5PR13CA0041.outlook.office365.com
 (2603:10b6:930:11::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.9 via Frontend
 Transport; Thu, 27 Apr 2023 15:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C985.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 15:02:13 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:02:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Simplify switch case statements in
 amdgpu_connectors.c
Date: Thu, 27 Apr 2023 20:31:54 +0530
Message-ID: <20230427150154.2073742-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C985:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bab6c1-5c56-44dc-9e20-08db4730620e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4patpeCtggqj8e4yeFbQKAwWfFMU5sKzZ9P2u/hsX8smLKSKggESdwM+Wp3xu7m2Qx5pEBb0S3kNqvNHjRDo2h4V6FWF3yMt0ueM4Ks/Ofgx+ZpMr5msqqWznxnyYdy7XTTrgADvDsQOavmzDKt3K2jzZT104TPudJ4iFleG9Sj7JCuUhhFI2wEZZphBOQlnawn13GoLAedJ5N2d8NXTblR4YXWr0fM6TZx1EU2xNzuT/yQhC2VwRsXi4ax01ZzMPfuz9Wnw6KhumuPaTEajKTFrfVOak6gjzkucpX2aw65Rr1yei9zy/ViZMKFM1u/80bbJ9M1sXt8kbX/hV0ir9sfTz8ktc5Oo8c/vGDYu4ixGN/9EdUTwjszXdvU190R7M+eNETxziELphsTDVZRKnMcVSXpBu+nr1H3jMqSKkmYmmjrUEw8Pb5vZHZbc1AdX93MWBG9Az9zKtWY5rfqlX1Cd4awZG7O4EWClhxFBCmfqV/LdbhoGmiFRAwzl5yRc3qJReJ1X9G+UWD+mBjHNbatGdKuNsqZOQ7HOTpUoaZPBdOvFNjCZcW9vSjjYvsPR1vbFiPMjHFdKJ57sFAg7MuNdE3nm+0zrwDaYdU39bNFggIlnFoFsDzQrac0HLZNYjt5PYtoHhsD/A5encjx3iQSLvNiMZufgTr73YczSCHUgKF89E4uR2zKT9Xg/8Mt5SGCJ7y52LJ64qZs7wNJvK54LJ3uOhbpMkc9j5yNgzE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(186003)(16526019)(26005)(1076003)(356005)(82740400003)(40480700001)(4326008)(5660300002)(41300700001)(70586007)(316002)(70206006)(6666004)(7696005)(36860700001)(66574015)(336012)(47076005)(83380400001)(426003)(2616005)(82310400005)(6636002)(40460700003)(110136005)(36756003)(54906003)(2906002)(8936002)(44832011)(8676002)(86362001)(478600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:02:13.1247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bab6c1-5c56-44dc-9e20-08db4730620e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C985.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following checkpatch errors:

ERROR: trailing statements should be on next line
ERROR: space required after that ',' (ctx:VxV)
ERROR: code indent should use tabs where possible

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 39 ++++++++++++++-----
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index d2abd334b1b5..08a37b7a34f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -591,11 +591,20 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 
 		switch (val) {
 		default:
-		case DRM_MODE_SCALE_NONE: rmx_type = RMX_OFF; break;
-		case DRM_MODE_SCALE_CENTER: rmx_type = RMX_CENTER; break;
-		case DRM_MODE_SCALE_ASPECT: rmx_type = RMX_ASPECT; break;
-		case DRM_MODE_SCALE_FULLSCREEN: rmx_type = RMX_FULL; break;
+		case DRM_MODE_SCALE_NONE:
+			rmx_type = RMX_OFF;
+			break;
+		case DRM_MODE_SCALE_CENTER:
+			rmx_type = RMX_CENTER;
+			break;
+		case DRM_MODE_SCALE_ASPECT:
+			rmx_type = RMX_ASPECT;
+			break;
+		case DRM_MODE_SCALE_FULLSCREEN:
+			rmx_type = RMX_FULL;
+			break;
 		}
+
 		if (amdgpu_encoder->rmx_type == rmx_type)
 			return 0;
 
@@ -797,12 +806,21 @@ static int amdgpu_connector_set_lcd_property(struct drm_connector *connector,
 	}
 
 	switch (value) {
-	case DRM_MODE_SCALE_NONE: rmx_type = RMX_OFF; break;
-	case DRM_MODE_SCALE_CENTER: rmx_type = RMX_CENTER; break;
-	case DRM_MODE_SCALE_ASPECT: rmx_type = RMX_ASPECT; break;
+	case DRM_MODE_SCALE_NONE:
+		rmx_type = RMX_OFF;
+		break;
+	case DRM_MODE_SCALE_CENTER:
+		rmx_type = RMX_CENTER;
+		break;
+	case DRM_MODE_SCALE_ASPECT:
+		rmx_type = RMX_ASPECT;
+		break;
 	default:
-	case DRM_MODE_SCALE_FULLSCREEN: rmx_type = RMX_FULL; break;
+	case DRM_MODE_SCALE_FULLSCREEN:
+		rmx_type = RMX_FULL;
+		break;
 	}
+
 	if (amdgpu_encoder->rmx_type == rmx_type)
 		return 0;
 
@@ -1125,7 +1143,8 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 					/* assume digital unless load detected otherwise */
 					amdgpu_connector->use_digital = true;
 					lret = encoder_funcs->detect(encoder, connector);
-					DRM_DEBUG_KMS("load_detect %x returned: %x\n",encoder->encoder_type,lret);
+					DRM_DEBUG_KMS("load_detect %x returned: %x\n",
+						      encoder->encoder_type, lret);
 					if (lret == connector_status_connected)
 						amdgpu_connector->use_digital = false;
 				}
@@ -1989,7 +2008,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 	if (amdgpu_connector->hpd.hpd == AMDGPU_HPD_NONE) {
 		if (i2c_bus->valid) {
 			connector->polled = DRM_CONNECTOR_POLL_CONNECT |
-			                    DRM_CONNECTOR_POLL_DISCONNECT;
+						DRM_CONNECTOR_POLL_DISCONNECT;
 		}
 	} else
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
-- 
2.25.1

