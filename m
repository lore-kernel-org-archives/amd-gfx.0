Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE38FF3ED50
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2026 16:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5531810EA27;
	Sat, 11 Apr 2026 16:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQw9ysaG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FCA10EA27
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Apr 2026 16:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3O4xgjC3a1HM+inFtvLconwQKQk4yrLkyCwjV5ry8VmqpuJh17JnxDWchZnMHYXWOzrGAOkP+KhHPf8XO+QcEROJ0bNxnRORa+8CsTvvBLi5iLkDefGcZ+lxdR3rC0eDGdzr0dYzqueB3HnLmfN34w445ssYOpEeIWjOb+R8kISaRk5u8mDc6lCo5JuEBDePj6ndJqpejJ4uanJJ1rwdV7lAsrE/HaxVKUMoPltsHCrVGBEjjWgD8MFWDIOUIhBqF/sQ3ribGBev0JnJTFEdfC2F0UX89dbFKfzqBuyoVlZPf9J9tbtyI3ugpYDgrhrLDG1+v6B8KgfvD2m99QOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J86PqF4zW4aRxBd7PHYpkSi6bYol+sELz/RFc4XxM6Q=;
 b=rUbnoGX7JOgkbj+mbHVOiT0wD05L2WWcN0CmJlhoVh7mEehHbpegvDF2ZwH/GqMspTArEh6fQEFUlgW4rONt/opYK0HKfDtUn86mir00+bmVmEwPX2XU6xUG/ZERB7R+beeh84GPFUFWmfi+3UnUHo1kmxv+yECeM+q+uOBdtDAT6s49YPUILkWsA9OS/cWx3o9zc5tZaCrjvzj9XyKbaMagC9XO+WIaned24w5ZBFgFCnzHXpKZ9+rVOqz9yaO3LgRC72aa/eU4RX1blioQY6i+x1k/Cx01SixqQVbLCPsyDiYcg+n9zJBoLco4I0I1hTre7MitgVSjLAc0EUnIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ubuntu.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J86PqF4zW4aRxBd7PHYpkSi6bYol+sELz/RFc4XxM6Q=;
 b=MQw9ysaGXe2U2qZIEc2memm18vvRkPH++n1WoS+/5ktgKJGkMxifL4RfnMBMDexFyUb8ES+cjq0CC/VWx/hhe/8iOqf0vyybRHKa/9FpJ8k6ODjHPg1at16nWyjlqcX9MEmRtR1DaJKRrwEqCCa+xwQJxWtvRqybellSML3cq+M=
Received: from CY8PR10CA0048.namprd10.prod.outlook.com (2603:10b6:930:4b::14)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.45; Sat, 11 Apr
 2026 16:11:01 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::f0) by CY8PR10CA0048.outlook.office365.com
 (2603:10b6:930:4b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Sat,
 11 Apr 2026 16:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sat, 11 Apr 2026 16:11:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Apr
 2026 11:10:52 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 11 Apr 2026 09:05:47 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] drm/amdgpu: Clear cached EDID pointer after drm_edid_free()
Date: Sat, 11 Apr 2026 21:35:39 +0530
Message-ID: <20260411160539.2305517-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 504da3b8-99e7-4b1a-eeb8-08de97e4ecd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ehl8li6wuxW1xmG3X2anb3cCmjUyx0Pe4PRV2Gg97evK5Z24II/wm+DaVWBGOluN+eS3tFtcHWgfZXWgDhHbWLr8nir5B05+DJaBVlSsMTZGzuCfFUfFoqG92/EdvA0TNION7sfK52hGtlk/hTBfTduwJO9bkiCxJL/dp1JBrC9b15DmTY1zZdpVdg6q8ZphsCOG8W121jb4qZAir1TVrFHfgQC1LhBOwgUzOWrh4CYLuP0mkc55EBRNTag3RpzbLzM/EgZNq7WM2X+LF5e32NCctN2AlNcaG33SuynNOsPAw7J6wjrBbQZ6D/CAdqBhI22VFxxShntd7JI0+ESkujFl4Y4zPGUt2R+W189kQjUgq7LdwH0yOUltxD43R14prU0KQN4HmtY1Xn4ANmoVuJKZ3aA9gRPwHn5klsTgY2dSVAa+d9UV+IsdO37YBi7YZji0oZTFIkorH1YG2+tKbcA/f/5+ImPvzaVXqEiA4q97mILsRjLYighDPFfUNqFokYKaOPufCf0xwAm5hPqIcyw+mfAb6xZXmfunATQliehQP0/FEX60WkMygbop7iQzRavLZFJPE9ciNDTtL36d4tW6hfoMA+8MUj2xyhxjeGgzqDLmMM3Hh4DVkeClTb2uslot/FnOW3c09ou94BKRAaUjw2u8yZC4kk4PeIH3MbMdjyVUE50rTzv0ZKZHAqv29SQA1SrpyizIvmm1nGwVLT852FevVxTvoOrE5A9PsvCjd3kHWy0iKwxZuzNXHxBGA+u73+A/ZC8g5IE8EXEGJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QBVb2elvgMRsv4uT6VzroTSWzN4dDS4t6aqphe366qEM0nzm3srjhf1tSELGNDwct8HIzxyorZaTxuY/YxcXfNGUlTBm12f7hQ5+kjXAMNse+GRVuylTaGnLU+Hpda6gVIYzLbdFyUIcc2eJTkic5x8IaveH0VOfdiC9BHTcDaaF5cn9G2vqJ7aElwrsQiDlxdnq9UAPg5FvIbqbtOcEJknOTF7SNXSvnmsZ5onNTrH84Zv9O4IET1RLsdGLobdlFQofk0b0fd/qUD+6oKTPgaqQa8TPHZtx032qjHCqLwkYr0ZXRy6Zl87dwcraqeR8T/MfxEbwLCKZxHlsmOaQi5YZWZAZavPs8yoA89EXpfmOlFLLXezTBtzNrGCFQMGKhMLbbXCY7HYo2A3Qqo6kGMTuh4TylZd5/lRJEnyUhfIQrqGFlzeRoK39gXsAekba
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 16:11:01.4037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504da3b8-99e7-4b1a-eeb8-08de97e4ecd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725
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

The driver stores EDID in amdgpu_connector->edid and uses it as a cache.

amdgpu_connector_get_edid() checks this pointer. If it is not NULL, it
assumes EDID is already present and does not read it again.

In some detect paths, the driver frees the EDID using drm_edid_free(),
but does not set the pointer to NULL. Because of this, the pointer still
looks valid even though the memory is already freed.

Later, when amdgpu_connector_get_edid() is called, it returns early and
does not read a new EDID. This can lead to using a freed pointer.

Fix this by setting amdgpu_connector->edid = NULL after drm_edid_free().

This makes sure the driver reads a fresh EDID and does not use invalid
memory.

Fixes: 289479173fb5 ("drm/amdgpu/amdgpu_connectors: remove amdgpu_connector_free_edid")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Joshua Peisach <jpeisach@ubuntu.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index a8ccc1602eb5..4d376d580dc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -866,6 +866,7 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 	if (dret) {
 		amdgpu_connector->detected_by_load = false;
 		drm_edid_free(amdgpu_connector->edid);
+		amdgpu_connector->edid = NULL;
 		amdgpu_connector_get_edid(connector);
 
 		if (!amdgpu_connector->edid) {
@@ -882,6 +883,7 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 			 */
 			if (amdgpu_connector->use_digital && amdgpu_connector->shared_ddc) {
 				drm_edid_free(amdgpu_connector->edid);
+				amdgpu_connector->edid = NULL;
 				ret = connector_status_disconnected;
 			} else {
 				ret = connector_status_connected;
@@ -977,6 +979,7 @@ static void amdgpu_connector_shared_ddc(enum drm_connector_status *status,
 					if (!amdgpu_display_hpd_sense(adev,
 								      amdgpu_connector->hpd.hpd)) {
 						drm_edid_free(amdgpu_connector->edid);
+						amdgpu_connector->edid = NULL;
 						*status = connector_status_disconnected;
 					}
 				}
@@ -1046,6 +1049,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 	if (dret) {
 		amdgpu_connector->detected_by_load = false;
 		drm_edid_free(amdgpu_connector->edid);
+		amdgpu_connector->edid = NULL;
 		amdgpu_connector_get_edid(connector);
 
 		if (!amdgpu_connector->edid) {
@@ -1062,6 +1066,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 			 */
 			if ((!amdgpu_connector->use_digital) && amdgpu_connector->shared_ddc) {
 				drm_edid_free(amdgpu_connector->edid);
+				amdgpu_connector->edid = NULL;
 				ret = connector_status_disconnected;
 			} else {
 				ret = connector_status_connected;
@@ -1412,6 +1417,7 @@ amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
 	}
 
 	drm_edid_free(amdgpu_connector->edid);
+	amdgpu_connector->edid = NULL;
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_eDP) ||
 	    (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)) {
-- 
2.34.1

