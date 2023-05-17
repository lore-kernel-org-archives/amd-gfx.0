Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B575C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 10:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00E510E3DA;
	Wed, 17 May 2023 10:08:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B0110E3DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 10:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly7YT1W/4DHrqYJdy5Pc1OPXh1K7DVyYx4LK7uUukqeFQ0xiLDUOaniR/DtdTRGI4U6AMua+4ndRqamZw1TwOXUmTt5xQIxKhdDA2js8noDsKtjchQlmZoF5PeNQsdhzlw/cVK10dEjFdxPlYtZ1wZnE2YERxiStQw9C3Nge7RjomMM9jMAwEvYDQg4ul9RNezuYk4H2C28gJn2irizV+5oPiUMIubeVKudwH4lSEncIDYcm1LfpO0bhYPJF3aldbGPU5maKqiFvvl9faNV1oV/bcElsJ5Ollzhb9M5gWxqKc/dONYggDMLhXqXSYEU6zslt4LIaoSfvM3u98GDG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUi6+esPep76ensRDRUqkggLrigKRBVx4V1H8bqvyhI=;
 b=RHbWNthyrthsMQYgq5Qimg0Isj0Mo5Ja2p/Y9OO5zJ6lLo8b16A5hOPj7e+tnBY5tQsQVXeJ/OdTcYZkoJC99UvzZMRVhmWa/07tpqnYfjwVLQu6+9AT/Dla0jHgK/RJcN9acjzuUgq1INrpCyPBR0J9duGCsGIPtEa9IJca6g7J3osks61ZeS1860xkVtjchT+2Kmkv3yjzKUvFUoDZ3+0ZLlUHQOiGGfIrx5dAradHHO0N3Hw19hLJTYb1YXkm4L7MO+uI8Tr37THVvr1RKaSoF2telHJosmVxFhIsV96NPv4WOVIAkAXOvly4uDWUeuAJMscZfhIs29/dka/Zhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUi6+esPep76ensRDRUqkggLrigKRBVx4V1H8bqvyhI=;
 b=GezbincnsOMaZ3XFpvjm4/I/WnLvkHdeRlromlis/TlDJKSSR+DFpwCxHh+ETtZJnr22mXDLzzSYyYs0zilVAvvG7GczgkNpNdtet8rxdcVzqBs8fl3es0BHFP984aC1fhI+JzD+CY7dAtEZaFRnzQ177I7Pjc+mEm6nDLEXhEQ=
Received: from BN0PR04CA0156.namprd04.prod.outlook.com (2603:10b6:408:eb::11)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 10:08:05 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::6a) by BN0PR04CA0156.outlook.office365.com
 (2603:10b6:408:eb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.16 via Frontend
 Transport; Wed, 17 May 2023 10:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 10:08:05 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 05:08:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
Date: Wed, 17 May 2023 15:37:11 +0530
Message-ID: <20230517100711.1856524-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e47d43-70c5-4823-0e85-08db56be9b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6SLxPb+6xZE8CIZJOEti3p+LGzDZpMstGwdg3D+ucnPiWnOVv3nzqjF4rQCAnWByEv5kAKaDNjEwEe68/msc1SZD6CuZGsH1SKdJXlNYUkR+/nopzTVh34gbSZ1tQqy4zWIb18STmeETqktBA8W/MibOCBhvsQnTcvx9AvBGo4GOuT69dAd5wxUmjxLcTOVStzohGJoj4eJea87NMEUIKMbMAT1XZnuxQsukCIfByHBPnsOztj72IKBo3vbIhwnCnmbedPjEXzn7JjROpoULBGgu9jwunVTBxRNckDfkRonArwSSj0nRUvXPsl0kSULcl1QG9AQUfZszbRZp35CADQ1tiRf8e0NHUxCayuJL2srFo9wm/23/w4KVya/roKWc6B925uos+eqaDhrIWS3Ie9JHi4I3z6C+7bKSTpKqlWoI5rzfcJfdI5EIJ30I7NiYLc85azpiHMtNqtesTniJw6BTJTRum7Wa1J6Bn+P4C3P1qFsxAYjd8Y3s65LbYMpZnDvu5+4B+C7FpBB3C7SWi5b3R/2gXFSvM9F4lRV2/svlz+MLC2jyeDxQrYJRPbTPP/AsLspGY+I+G8PIbLNcnMYaiW4ZV02pWRsVRAn/ElpoZjuwb0rXxMkaFZOXLMsyQ5KCggmkdfbtiMMdeHqubENkj6HO8gYxVY3mbexgvb7speV4gwQa6wuv7kaXBFSvIhPQDTGfFtpVR/Nv9QllCTizu4GgQTuQDtMlzd4uljUeVvNRm2f9phBjJ6pUMN3PPyM5PqqpdUIgw/66KpQFvmRb5bJlo/0ucfMyF+dS6HIt0hLIWVZE4lDSqCLOPcg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(7696005)(316002)(110136005)(86362001)(54906003)(6636002)(70586007)(478600001)(70206006)(82310400005)(40480700001)(5660300002)(8936002)(44832011)(41300700001)(2906002)(6666004)(16526019)(82740400003)(356005)(81166007)(26005)(186003)(336012)(36860700001)(1076003)(426003)(47076005)(66574015)(4326008)(8676002)(2616005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 10:08:05.5093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e47d43-70c5-4823-0e85-08db56be9b7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
   - Avoid mulitple return statements in amdgpu_dig_monitor_is_duallink
     function without affecting functionality
   - Fix following warnings: 
        WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
	WARNING: Missing a blank line after declarations
#74: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c:74:
+                       struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
+                       amdgpu_encoder->active_device = amdgpu_encoder->devices & amdgpu_connector->devices;


 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c | 41 ++++++++++++--------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
index c96e458ed088..8c17a74f001a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
@@ -71,6 +71,7 @@ void amdgpu_encoder_set_active_device(struct drm_encoder *encoder)
 	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
 			struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
+
 			amdgpu_encoder->active_device = amdgpu_encoder->devices & amdgpu_connector->devices;
 			DRM_DEBUG_KMS("setting active device to %08x from %08x %08x for encoder %d\n",
 				  amdgpu_encoder->active_device, amdgpu_encoder->devices,
@@ -166,12 +167,12 @@ void amdgpu_panel_mode_fixup(struct drm_encoder *encoder,
 {
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_display_mode *native_mode = &amdgpu_encoder->native_mode;
-	unsigned hblank = native_mode->htotal - native_mode->hdisplay;
-	unsigned vblank = native_mode->vtotal - native_mode->vdisplay;
-	unsigned hover = native_mode->hsync_start - native_mode->hdisplay;
-	unsigned vover = native_mode->vsync_start - native_mode->vdisplay;
-	unsigned hsync_width = native_mode->hsync_end - native_mode->hsync_start;
-	unsigned vsync_width = native_mode->vsync_end - native_mode->vsync_start;
+	unsigned int hblank = native_mode->htotal - native_mode->hdisplay;
+	unsigned int vblank = native_mode->vtotal - native_mode->vdisplay;
+	unsigned int hover = native_mode->hsync_start - native_mode->hdisplay;
+	unsigned int vover = native_mode->vsync_start - native_mode->vdisplay;
+	unsigned int hsync_width = native_mode->hsync_end - native_mode->hsync_start;
+	unsigned int vsync_width = native_mode->vsync_end - native_mode->vsync_start;
 
 	adjusted_mode->clock = native_mode->clock;
 	adjusted_mode->flags = native_mode->flags;
@@ -208,6 +209,7 @@ bool amdgpu_dig_monitor_is_duallink(struct drm_encoder *encoder,
 	struct drm_connector *connector;
 	struct amdgpu_connector *amdgpu_connector;
 	struct amdgpu_connector_atom_dig *dig_connector;
+	bool ret;
 
 	connector = amdgpu_get_connector_for_encoder(encoder);
 	/* if we don't have an active device yet, just use one of
@@ -224,39 +226,44 @@ bool amdgpu_dig_monitor_is_duallink(struct drm_encoder *encoder,
 			/* HDMI 1.3 supports up to 340 Mhz over single link */
 			if (connector->display_info.is_hdmi) {
 				if (pixel_clock > 340000)
-					return true;
+					ret = true;
 				else
-					return false;
+					ret = false;
 			} else {
 				if (pixel_clock > 165000)
-					return true;
+					ret = true;
 				else
-					return false;
+					ret =  false;
 			}
 		} else
-			return false;
+			ret = false;
+		break;
 	case DRM_MODE_CONNECTOR_DVID:
 	case DRM_MODE_CONNECTOR_HDMIA:
 	case DRM_MODE_CONNECTOR_DisplayPort:
 		dig_connector = amdgpu_connector->con_priv;
 		if ((dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT) ||
 		    (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_eDP))
-			return false;
+			ret = false;
 		else {
 			/* HDMI 1.3 supports up to 340 Mhz over single link */
 			if (connector->display_info.is_hdmi) {
 				if (pixel_clock > 340000)
-					return true;
+					ret = true;
 				else
-					return false;
+					ret = false;
 			} else {
 				if (pixel_clock > 165000)
-					return true;
+					ret = true;
 				else
-					return false;
+					ret = false;
 			}
 		}
+		break;
 	default:
-		return false;
+		ret = false;
+		break;
 	}
+
+	return ret;
 }
-- 
2.25.1

