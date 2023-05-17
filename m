Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A49CC7EE30
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 13:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187EE10E15B;
	Wed, 17 May 2023 13:11:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C1210E15B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 13:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJL6JvYytTiQYtPs6fooI8TlYpXh3ZjepZvCeCq95s+HEX1JrNd6v8iXtosoX/7uhtA01AGlat4CS9+eJdblT9SS3uLegk6OSsqH8BrPY4z255gTkqzeqhGkwkS3zb9GBlXviCmh5YF0erjs9mXeiZTlI9JmDl0cpg8TrbS5kBB6Ogy84YR7CzMHn7KKAcaGghV2uasJj3CFT13gO5jwgsr24PnSeNspWDz6Jn4dhT2+4uUeMO5YPM0UZo+i4MMVttwBvXk8VYgnbCfVR+TxAuFtEQWcuQWQtrrFLL2krruhuoUmkYGb6t6iH+2AWBf2ZZzOAyTdKMLtsjMAfZsB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lidRYs9kBULcpHfVVqf0MkD+NDqycGSekcLheibBSio=;
 b=eSnJ1YcM+9EypkNCUo+Cy6Xb8UFdqW4rPsQBJMILkWBfe02IJhtiMkeXoN1a66yPMXLjDLoRW+gxGZRPF/uvLWnrBv3aWMNRJmLdGYhPeyiRiXR9pFD7P0lnZItQm7CqDh/Z6BvwDLIVcNj9J9u2HUAcfGo29rrvc2ZJVVsGCdBpHd1iwSTJ1c2lEkWeZrSzyj4Zwh5z8YchsNOQErX+EWGPpqN0SPmnwWHkO9EnTCePxFlxYPQS6WFxeTqG4gCGdh04cq87+Uoj+ucNehAt3buBy26GkhYolkxj5BFtZU98EE0hS/uEaxqT/VM7r9cHMBk2T790M6UNe9+LjvlVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lidRYs9kBULcpHfVVqf0MkD+NDqycGSekcLheibBSio=;
 b=JpgD2Gpas1tUlHLjdX5LGqnndBHOFAop7VxEF/iMbbvBT7YhHZW3POJIBf3p28O64dVM5LVOl26YtjtNSd/8q+IfvovCZX7bwh1scBgg4fBsdSa/TfUZO92XGob94hAgCmP1wRK4dknznIyY6rfOaaNCIwBYgs2NJjdYxzBM87w=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:11:48 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::54) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 13:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 13:11:47 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 08:11:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix warnings in amdgpu_encoders.c
Date: Wed, 17 May 2023 18:41:32 +0530
Message-ID: <20230517131132.2282628-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f9ed91-55b9-4d43-2c0d-08db56d84540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5DGPay1WcmRpfxexa0a6LHn4E8h4g8+MyuLpich654H4wUNw0poTSn+KYDhgbplztZzF+26bLQ+qK+w+qZraH7e130T5riJMGLlOJ604mYEl411qpUpGKd8VBpBS/Eql0zar/UvLh+I4DWAW9dfbncPJuEnupjD4TkQgph8y4TjhctNqBvM8D6sROiOYv6yyTu7XQF/2KC+nF4zLFzkHc2w9HW7dEXBlAzIGPEBFPWzNJkCYxMDW1DCLMdYsI+/flfSNInA27t4C58wgQgeoviTNMKr41RTXjyz1NINRiAI/Y7faJJckPdMDNX3UM0XnTwUwYtHX03zbZZ5l9lcGMSh9TFAHHR3TY7IFdVNRnWxYuWGG/JNVd97+NmYJgGcU6JYA0koFIYmdj4uigsUtftdkPBhkIczCrFhdeGkpSNZyc1yh4jGsGkZN6SD0LKRpjjWcFF4qd+BjZ0muiasWqY/YQx+xxE4Db5Ap4jJxChkEbrgMJIAUVRpPT1xfQbpUp/3T7Bmd1YPrRAhR4ocCdwL/K4WXWVIy41l3dph7t4nu0zuliNHYfyXumhNWQorLfaSNys1YBBeWFA+7Q8oVTFPvwmhH1EF+JK2CFGYu8q+61N1bZYAVGJxCbhkxIe6BMyMszdVn1bNswPoXeOFU2/4hba/G4iDF9+Dyfew1puqn44SHAZQ7xmPLRCxE7q8wZxRfEpdk8XJrjo7QGRWLGmkgCz2GahvQTSCMWzsaCJoUV90OzDpgsTHzMl1cx7hpCMMzNOoj5N56zjofytQ/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(7696005)(70586007)(70206006)(478600001)(4326008)(54906003)(316002)(110136005)(36756003)(86362001)(47076005)(83380400001)(66574015)(26005)(2616005)(16526019)(36860700001)(426003)(336012)(186003)(6636002)(6666004)(1076003)(41300700001)(5660300002)(8676002)(44832011)(8936002)(40480700001)(82310400005)(2906002)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:11:47.6409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f9ed91-55b9-4d43-2c0d-08db56d84540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
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

Fix below checkpatch warnings:

WARNING: Missing a blank line after declarations
+                       struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
+                       amdgpu_encoder->active_device = amdgpu_encoder->devices & amdgpu_connector->devices;

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
index c96e458ed088..93868ff01fb7 100644
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
-- 
2.25.1

