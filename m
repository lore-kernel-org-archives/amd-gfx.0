Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11363CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 14:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8044210E8CD;
	Tue, 13 Oct 2026 14:55:55 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8655C10E8CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 14:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZvpoIZAo0t5fnRp6IgzKWzRVXGQftemlN6aKYhQiwjoQB1oOAxwL1mQeo1lJHbz6CqdMNYbUNV052l0VYhFvqL+z96u37M2w9PuZ04IdAKo1aVOypGzgtCgwXjRIrWyY2Jmw5qurb1Kh00foct1z4RPoPe2ETgGeLbkKj4eCqfoLwqE8DhI2bMQWM6qTBQ4a2KNO6/jTYmcGK2Wn/82XvslKEJNTAhtZw0kAZiQzpZ3imTilqs/vXNjfQp+XYo1lNpk3aMPUfvyxqDRJLg6KSu6DPkJ32e1oVYsbAPP4CFf4lkuAcVecYy3rsttpC3Nrk32cyRfydr+aQ6EVVf+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/150Z0Umd6tpgh9vjzTj0cJgxHvdCgcKtnt4wuIvzv0=;
 b=A3i2KLyumcye8Ta+rp0qBqZSReQLNuf0WemR2SLFJC69OxeeoxfWtWu6YR+A5F7Q1Ho2sEdZP3wd0BEHha0CkcJZYPhwAsR2fV5AcgYLJYYmR570I85bOTUPvkmWt+Oqg3L28Xd4z+s3x30hHHgIPt9arnM4c4hLY2z25MwvWXTaHSj+YZgfLfis/T0bDAO0U9u9qcQ2DXY3xlF1JuV42IZJzKlfzsq3RXsdHD38uPO6+CJSyC5E8cExlEV9okQoPTnBLkAk9LJjJBetG19Macaw9QNZ4VeIbdkvnKZ926V98WCcOKcKX3/I1oX74/ipoh/wzTmZdDTx4ahjmk4Ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/150Z0Umd6tpgh9vjzTj0cJgxHvdCgcKtnt4wuIvzv0=;
 b=rO/0D8geGkTxEiVRD0tBegwu/gCO4un2jJZyxTgQZ40a7TSZAYugAHeK+3sLtBpsa1OrI4OFSG4CXbCga5Iigm6USsyQRnZ9x7wYSwKBTcPV40n3OZV7yZDnQoRy4J/pHXYYRcM+ZqD7rIuWiJdEWORv9JVX8Dp1wmA3sze1zxg=
Received: from DS1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::10) by
 DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Tue, 13 Oct 2026 14:55:41 +0000
Received: from CY7PEPF000000F6.namprd05.prod.outlook.com
 (2603:10b6:8:44c:cafe::42) by DS1P220CA0017.outlook.office365.com
 (2603:10b6:8:44c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 14:55:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F6.mail.protection.outlook.com (10.167.247.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 14:55:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 09:55:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 09:55:34 -0500
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Tue, 13 Oct 2026 09:55:33 -0500
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Dejan Andjelkovic
 <Dejan.Andjelkovic@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add support for FB carveout disablement
Date: Tue, 13 Oct 2026 16:55:25 +0200
Message-ID: <20261013145525.1251002-2-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013145525.1251002-1-Dejan.Andjelkovic@amd.com>
References: <20261013145525.1251002-1-Dejan.Andjelkovic@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F6:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a18cbd3-0b51-40fd-c806-08df293a0cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iBXTLBu6QWhOEOWGclPthAFy5HDVNPfGGeYv2z5QI6AzpqiMfP5iN+nM1YYOyrEpgpw2WSfaerbLWWgl1BNTuORgYOpVmGZx4H+GZ+DkDjXqpglM4O2s22acsBjL+3fDcXKBXs7LL7LW+zB1BRh29DcsBSFBozH6tAiTGv1eQT0yoTHTC4VBt3sbj/q9wkrOVI0hUeyQmIcyVWTYkNUGXazPIDyn+RRLgMCWNu89tTh2OM9LThuVqhuzpvJKPcFsktVUnJb5Y0WHYdh82YqGq9QxaMZCG1sau05gX3RioSyeZiMVwAVpSvYYp/xgPfrzStskgPO0VvU7IxUI1KKvtuGD9IWXPugrmdtwiIDhsOCj78dl8ZXuokOY2EdHLBrhsIfoVVfoJhtWbQpP6t/8mXDA5s8RzBUO81bfPMB+P5bdWgZs+E8jaffu8rAGS9VNysECteo1KkcXdXhzfxUnxEnD/utIZn/Mzbd3dwBVjj9BYeZ48vaTMYjB0jCAue0Cn15nWA6hkVYhJEo6nRrtFmITNTcLweC6rqjZMzXAeayNNuIFsnHuAsAS/aJkwUUbvglCvNEeEsIchEm1RYmiNXQB0OsCRyLSCbQlvR3HwsF04Cl1/a+yLjklKhJ7JejcKGZNQiej6DAz7i+e5FdrGZJulz4VhvO6Ar8wQu5f5sm0vnBquVkKua8Qz9Z97DB2VTOWB77bt4iN1m4tyMNTvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZtCXATL8hm+oIYd+fdgcLT3/ZIzKl/Ensaw/MCRNhFucCQb8nxQZTw/2SyU5rbSLHBwAlzvCIipOmNbWjdI9YXRQ/uv6yvLIzpNEPOUepmDpETdSdZqVqnJwNIsxuOkYBUf2hJSJSo+Vu4u6G4TlByk6V3lGojlj2Gs15rkmXkqKD4u1ty/XTC2hDT8yTYuYfImQ6DIZgHRBLyh/YViBHP+fYS1ZxexGSsmLPHRbdZ/tpHD6qHrHty++r0lDbqkUpCbqZ+wGg8wZR8qvZSri8SVRaQgmW6hyAM1SkW3hxeblqJZq9FKKffTlxOlqU5EqxnDZywvKKK+Z5vo3y1Yz7f2mNppnf0WPxNn/twzbbux2UXl+Zu4CC5dVAreM68ZnhGxkEL5hoJJEJMITxx8hK9BvCvmfpO17sSJGSJ1meVrO4guDsgaIE6o11s6VNxXA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:55:40.9002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a18cbd3-0b51-40fd-c806-08df293a0cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
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

Adds support to disable FB carveout via PSP mailbox for passthrough A+A.

Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3372de34149c..872af286e3d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -455,6 +455,19 @@ static int amdgpu_discovery_read_binary_from_psp_mailbox(struct amdgpu_device *a
 	return ret;
 }
 
+static int amdgpu_discovery_disable_fb_carveout(struct amdgpu_device *adev)
+{
+	int ret;
+
+	WREG32(mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT);
+
+	ret = amdgpu_discovery_wait_psp_gfx_ctrl_resp(adev);
+	if (ret)
+		dev_err(adev->dev, "disable_fb_carveout: PSP wait timed out\n");
+
+	return ret;
+}
+
 #define IP_DISCOVERY_V2		2
 #define IP_DISCOVERY_V4		4
 
@@ -823,6 +836,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		amdgpu_passthrough(adev)) {
 		drm_dbg(&adev->ddev, "use ip discovery information from psp mailbox");
 		r = amdgpu_discovery_read_binary_from_psp_mailbox(adev, discovery_bin);
+		if (r)
+			goto out;
+		r = amdgpu_discovery_disable_fb_carveout(adev);
 	}
 
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index bc777f53a193..7b4ed3bc23d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -50,6 +50,8 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
     GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000,   /**< Copy IP_DISCOVERY_DATA to host-specified address */
+    GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT = 0x00100000,   /**< message runtime VBL to disable FB carveout */
+    GFX_CTRL_CMD_ID_ENABLE_FB_CARVEOUT  = 0x00110000,   /**< message runtime VBL to enable FB carveout */
 
     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
 };
-- 
2.43.0

