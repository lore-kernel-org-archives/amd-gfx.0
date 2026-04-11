Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C092CF3ED40
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2026 16:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5240610EA26;
	Sat, 11 Apr 2026 16:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D2I2WTgm";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4124D10EA26
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Apr 2026 16:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6FzdnUUD8wzLZ5aMt1yjPS1xez78FXp8/92Z8RvicvsB1w2TSBqxV+IUGbme9XIwkGRgPNaaBD648x1kEKz6LHgD/ETWw0HGL/0mG6ua54gtq//4BHtA8ZB0IWy2mFKpFkmWIK0g0P30Bi8noUrT3ZSpjxdNagtmdCdVfTxJjaC/EiT60Ud5r0CrW/LJFuXUcFiRqIzrM7jgB9n24ysn2Ro3u5/YuMCUHQ7NfmZYk+Yr+HNl4vF1NRv0SyTG2S/S2xY8I9ma06mmPBycW8iJDl6iOlXzBuKVNwKNgqSTfKxZFak5bO3UsVtJpOULdieHVSL9/Z33+ojRziec+dXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J86PqF4zW4aRxBd7PHYpkSi6bYol+sELz/RFc4XxM6Q=;
 b=TW1UE7YJ83zO8/lauK+sWf3/+WsgHlHbgskc5BhOjRIAs2F7Dlxv+eLuBr4PRiqv05RR8uwGllilt2H5pu2nwNz2nkogUG57kFVAyM5NRJHWxwaJ1Y3r+6LnmoJQyuxPqq8ACzBnB26M/YpHNv2dWRQeRBiSeenQQuUQHzljxh3OBcDbOz7fD0Xy08vx3ZHIMf6WjYRN4eAl8K+hT99TC6qix+CSxHqxl4Huo8VJQelFOSHzHLyBZ9iEJrDfMRS30T/8fWHJUpIEQgLFUkM2EVzca9ekQs/M3mog1sNrcM6FuTo0CQ/Y1fH7H5AqBdjFNfGEInS6Q1HJh8vG3gq0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ubuntu.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J86PqF4zW4aRxBd7PHYpkSi6bYol+sELz/RFc4XxM6Q=;
 b=D2I2WTgmM9e4pWxrcQLO4xtYupurARcmRTPCWbY42aRQnPcqN5McBm/BE1Hz9MoRG8+57KPX6uINzlSJt1TYDm0N5vyz3oB2IHi1/TddM8wOaSxAaPrrqQWCNzH3IetlyDahysPoxmIZz19CvgOKAtIFQZtxxLlW0DuAH8yazJA=
Received: from SJ0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:a03:333::18)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 16:10:55 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::8) by SJ0PR03CA0103.outlook.office365.com
 (2603:10b6:a03:333::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Sat,
 11 Apr 2026 16:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sat, 11 Apr 2026 16:10:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Apr
 2026 11:10:47 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 11 Apr 2026 09:02:35 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] drm/amdgpu: Clear cached EDID pointer after drm_edid_free()
Date: Sat, 11 Apr 2026 21:32:12 +0530
Message-ID: <20260411160212.2305462-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7d023e-6aca-494d-5743-08de97e4e846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mYhNwIg7fc0q+NmB7EIXo0xDPsqWABXfJT/0U39poyT2oya1ngjyLgzkTe12RxX1iWEtNWdfvPzQm4DFm+W+D68gugoroGVq26LxZ8n3ErBW0vIhFm5bt7ZPCJ0vjtxsIWMI1XwEwU8+rxowIfL2ntHq/SYGOdGXChblxql+UCLG+EMXzX4qNbTiyQJ4vkHJ59SZvTQaK00Sod37mak/qNczb+UBl1xTykLsMG6XYFLc8iyOA8zQOHqd4BEbG4gYjZNaaiYVhYCYj0kWIIKwcqOgpGW/2xC2GbP/Qn5WaJmMTUS6rIX5nhbQ/F1a6p5dcYE4IJhCkGFsgiBwL0tz3JProdxMCjAOTa/w8b2bAQmmRAk0l4XeRjxm5Si5eyZ+yLEDzKf1hYy3uULSw2Dp2VghCiepNkmU3NspukvNEldmeC0PWDcfxjrGba/qVF+mJCkmGllLIYfuumCgnBGXDFgoD/ztRxlZp5v94W6gS38sDATO5At/qM//i9rAgIu3OCsoFdoKYhx+aaEGy/4EDnAKTt8IcY15ukMgzO4GrHzaLe3XbModQWcD+jQsCiKG0hzo4x1PDdrQ4qAxAdGsjIRsjOj9zkAeHk2ll7MY3TdZbzJeoC/t85FEMu/kitboeUteg7L+hCRyk2nrl1r/cKjE5gtOrnrBjnoXxKWIcA/BHBBHoOJ8+yj1EmyhLjUkfQYie29wxrx7f3k0XY+Le1OpfEMXlKmkphktR7VgfNFHlH7VzPhs+sCZqfNu2/2b+Y3lowqGF3pXKOWr1VBiCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9a1aUmSVpBo+E+aeX2TONpedfccEac/boxS09c78QC6QeRQonDG+Nfh3+iL2JFtroOflgQBGuIR0Kd6VSUgEg9xeVw+5ytaGehB+Rtb3kbSgYaamUsV+AYxI57tjZk7zN/7KHdvqg6uv+4WgWbPbJKuCjJPzW6X7B4cjPdyG1/Yv7go/ZI1hx4B6UsXa2E2/Jz3XFYqrwl79lVVfPsoAyemGFIClLuT6DoJzhhm+F8PApGep39GibGJOqnaAeCpXQK5KmtLFUZc09ZIy5QiHXJ5nHLtmwSa60IIOgry/N4Ep8NVV1iCS2vT/sJ8fva7amylu+PyO7y1UJhK1YqfhnMeUO63uEAFQU5dDjPqa+rSj3iL3zEjcLewDLukZcGgLZEb5dDNFeamu5KrkXhK0PXKptJ/my7af/Xm1xPWUMb2itsXhivk6yOdirk/38eWs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 16:10:53.7682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d023e-6aca-494d-5743-08de97e4e846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

