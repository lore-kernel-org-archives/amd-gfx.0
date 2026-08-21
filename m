Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E618C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D6010E340;
	Fri, 21 Aug 2026 19:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yNDrI+So";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644CF10E33E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnvZODkRqyCWjzWGxt42ceQAcMn67ICQNYYVfjIATXWzC4F+CzF7Nsj4xOo9Kds/PoicsJjPKJzTmFEgrNN17SdLoICWXy/sPTd8rT6guubrXtXr21ZODa5Mak7VTs3YsyWVIa7RlseyLzmyucZBrDktDWsWRMd0+VkTFXX+OSvqeAp2C7M5TMMNSkC0hWSaNJNHEcMEN9++1IY4pkeu9WP1/ReE95ZR+5yLdGYkfd7vJp6H5uka6KdX956uW59T+9sWSimNPwyhf15rX4DfD98x1RqSXc46WlLzdqWJC4401nNE4UCBN9fHn9G2LbmwEZ4sVYKkdN+aFOJtZQ9Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/9FlHsctoVPJr7D8ObMlhK5kriENISIk/skYDxJxfY=;
 b=eD+rHDWLuGJygcQfw5w7+CxhkpY3DjDuesaW0GrwG4vP+af06x78hYSZM9EEbzXnzm2sFJno1PrB6oHI6Ywdhkw9y75Ng7TeuwlBn4IkSghSqGEcdhfM1vzJ6xHJtVbYFkxVHO0vJXritUcd4glpLx6MJHGoGUhXClaw6sKvD9E0faKIQnzqXjfTTWTqnTH6vuhzsDOrtuEgdedakVLqE51+2wHd4to/fLVd8TWG3B3+EbYLks9eqOncEH7wqAoksvxtRkiXp4DPRdUtJAw/Ft9IE5T1hkER8KNid4rv+g8Gv1FHn1f6zn5V/fqcrOz7nib7weRycmD0WkwQSSzsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/9FlHsctoVPJr7D8ObMlhK5kriENISIk/skYDxJxfY=;
 b=yNDrI+SoRgwjGtNf3iO0fB3uRJFLLEjZZQ9AVltQvJGPETRXQqAh9ee4X+HWVj/oi4nUhEWNsXWGrtxI3v/j1fS/a1VPQ1az5e/Bkze2O67Zs0HF79ZwgkZNbqZnRUVxSyJ2r9wVTYz+dr3oJVkUfp28LtxcFggHdrLbVVj5xR4=
Received: from MW4PR04CA0047.namprd04.prod.outlook.com (2603:10b6:303:6a::22)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:24 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::7c) by MW4PR04CA0047.outlook.office365.com
 (2603:10b6:303:6a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/95] drm/amdgpu: Query initial UALink config from PSP
Date: Fri, 21 Aug 2026 15:33:32 -0400
Message-ID: <20260821193458.808626-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: b4899565-ccb3-46aa-0295-08deffbb5853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Zf5hsFajVJabrHD1pAUXpc/iTyErpRdoZnr6mvB5uRWWrN8SA1/mn1pu8cu/l8G0m2z4NP92xmtzDwi/pgmVs/PVYB9h9qCwf1D2ySpLEc4FuRQW6oRzvNGA7Guxvil1mlvPkDHrMMBGGaxzOsN5osUUDbODvUQsW3CgeOk5dUE5kz8ssj3UuwxC2JCw1gVeQrr9JWshqHX1PZjUJua5IG+C8zGw4N6G6jrU09pSvGXC/vbLx0fu5z+DyHBNllcodrzcHW2giWrVf8sEUvBEOMfTmwW69bDhBeF9RAhhs/RkQEgC77xURdf6MQ9H7kY7khAJB6mw3rqU12YmxjmraFl4cDRUGfEwZ6h0yNHqUdv+UiMbB28C7MVHSfdEq1TTbeEnjNSAKY434uX0+QaxYYU1V9QcXt/+t/JrxOWBkfn622L8vYN6z+60lswGM5Xki+vjAmRjijb4d6rWns0QvY5Fax5RDhpDIZL3AmqB0VbrsAfL7w4ot5U+tsEWa5ucus2Hc8o7OVkYau3ve0TlHWSPXG9wNoibzbWL+YOZscFkdiY61Ih5yUkaZBjOLVpottz+QOBucB+FFme64h43VwkXjm72AmpWFY6FoHHBzHH8UNIz5lo6cfzlZXMSRAoMKdj+bb7DScCoLCo1RQD5Ezcs3HURpfOZYIqtAobsaQrtVwViQ+A212BFCS95j2O8U6+mf8IOf5IXGrbnB5UF5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: euVP8DSykqRYJ4jwqMV08f+VriRe+vCnP231WSgxp67fqLBkMvY/c/H6mLHCzg89w6PgaL/Mnm/EucTp6JoTFwt0TlFHCbN9diFf5d8plOiMv8SA+qCR2xGzs/tLTUwtUn5Mo/pxSUzMNwLJedoHzXBS9mf0Fdf+rO1KoTLwqhgWV5jg7kHXrnMLTeTmT0iu6vPA6atnALCIavlkj92Tv+1KVwIqEY5h4mgODqqhKO2kWnNAw2yUY75qwybP6md6YRBDNSFB3KumFYf8t4a0EALCOY6zsFKc+zv7aWkTebyJE7BMR19M9C4eRlR+eUcRd/OulMV0OKaGI8szwEVV0bVahNDK/fK1zdd2FLudFIUwAb/3x2Bq0U9jcpbZo4rscLpe1+kVYEZKSyEccXamPeHoaj3btfTELVx9m0A0FSHeGKITkzMAfiSAKCYSQNMG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:23.7654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4899565-ccb3-46aa-0295-08deffbb5853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

From: Felix Kuehling <felix.kuehling@amd.com>

Query the initial UALink configuration info from PSP at driver
initialization time.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 30 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  5 ++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f5ff9f1e9ce0c..69d3f430f1f6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -29,6 +29,36 @@
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
+int amdgpu_ualink_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = psp_ual_get_interface_version(&adev->psp, &adev->ualink.psp_if_ver);
+	if (r) {
+		adev->ualink.psp_if_ver = 0xffffffff;
+		dev_err(adev->dev,
+			"UALink interface version detection failed: %d", r);
+		return r;
+	}
+	dev_info(adev->dev, "Found UALink interface version 0x%x\n",
+		 adev->ualink.psp_if_ver);
+
+	/* Query initial configuration from ASP */
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
+			       adev->ualink.info);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to query initial UALink config: %d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
+void amdgpu_ualink_fini(struct amdgpu_device *adev)
+{
+	/* empty */
+}
 
 /****************************************************************************
  * UALink info and configuration in sysfs
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index f2be71232813d..1cdf670673573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -129,6 +129,7 @@ struct amdgpu_ualink_connection {
 };
 
 struct amdgpu_ualink_mgr {
+	u32 psp_if_ver;
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
 	struct amdgpu_ualink_vpod_config *config;
@@ -162,6 +163,8 @@ struct amdgpu_ualink_mgr {
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
+int amdgpu_ualink_init(struct amdgpu_device *adev);
+void amdgpu_ualink_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index d5f945617f488..84cdb09f731e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -439,6 +439,9 @@ static int soc_v1_0_common_late_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
 
+	/* Depends on PSP being initialized */
+	amdgpu_ualink_init(adev);
+
 	return 0;
 }
 
@@ -472,6 +475,8 @@ static int soc_v1_0_common_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	amdgpu_ualink_fini(adev);
+
 	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
-- 
2.55.0

