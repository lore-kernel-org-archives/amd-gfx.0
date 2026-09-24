Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA97C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 17:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C1710F6D0;
	Thu, 24 Sep 2026 17:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kS7nU9gu";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8E410F6D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9sJ3Vi9okhchyDNlDJu2PUUyJ1M0rWCsqifPsdh4XBhu0J29iPx/4hylANLFdi4UkAlGmt+eHCj5Wn+frVH4Bg0b00DRTCz64lj9CemgtOVehEo+TEMR/xxuwI8LSoQGOi4IAFjkFPYF/g8F3d/m1U9H38Q7+EwMQUxL+E2Rkm8GTAIiDlvmE9Cxl+yBJEu/2b9z7OkZ75hsiNsN/zol+fmeHztoP0VxHgzVk6Fnpa1hdknUpz0uX4N290SYSlwzlGQHRxNIwt124wyWKOcVREz9V6oFBsM2SN2YgiDMROGIPM5mO1r2f2jVnf84QAFAxV+CmkQLBDSkJF/1HhD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HKzM5GCMDuxrqg6F2+e5m7NWO3sP04P4J2yx/6HmNc=;
 b=DnqUglQdkoZeA2PdjvMPiMkC+o/+t5LAp1W4D2aLfURG7J9bmgnfnM9dl9o7Zgqj0pT30Hu4gK8Zktrug4Wk7Z+n6Y4iVrcqkGI6egrTmELqNxS3LcrMiorH8RMi8egwfxXuOvkCn5EzIUr1BOVqupgE/u//A8zhVPGbkNhFK/n0vuDVYBs5/yU4GGLvg2ov6PN4F4eKM0plXr0SMSX3JwQ7TEG2SKZZi6KXj47n9wocoRP7qGoDwoUS+KVK3E33CQr9iWJgQ0iWwVnVARv6H1xYVatfSFDkZ1qXZq6L0H6ueR/ZjRZwfbaWxcC52/gfxjwcKG/RC50hyN0sqMfpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HKzM5GCMDuxrqg6F2+e5m7NWO3sP04P4J2yx/6HmNc=;
 b=kS7nU9gu8X96mIWNWuHekW/FxeMK0lEdVY6PYJ66KSj28ucdD9lcJ7sIlKVllEiEkPEF88PmXD+0+kknYYb6iCAGjFhhis9+2iEOK+iWYPlZ7LPCIoU4aWyy4ywFlVajlaTtT2kD/a3yJVYlO/GYsiJx+KEPMCcXnd/Wg+uEf64=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:55:07 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::16) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 17:55:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:55:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:55:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gangliang Xie <ganglxie@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/ras: add support for psp v15_0_3
Date: Thu, 24 Sep 2026 13:54:42 -0400
Message-ID: <20260924175443.636193-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924175443.636193-1-alexander.deucher@amd.com>
References: <20260924175443.636193-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f08fbc9-0ca2-4efc-ee76-08df1a64f871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: jfoq6pFpVKOjzr/nl9OAhWT9ZGCmijYP5FMMY4dannL3IvTMjd3pScknvXcAN/G8+yiD36eDnnf2zKnA35L08TLKVQcuVpDr5YP3+aqpjEKPhcUJeLTmsZmekGFvCBbBlgJ+UPjFXKTBwMRJ5qFQm6clu1fooPhyRBGsWjlZqfyYLm56SzgoRoDD55nMi5iC9TCf/f953BoinEc3ShvtSRTcckyhNvGAXnBq223Ud6kxmjLv7Sf1CxPFXu/Ra/qhbuPbUlLzeiRjSHZPSW5II4Tu3mlf/EzNBS1oXYc/vF781Nw9Xg+DcCxEN+jpE2f8tZg0TJRR3IjSvvw6KKbyDQkVkA+XpZFlqxpMlcOnMZsn9DNI0itbGShFtwFI+8B/G6/btYGR7zKEv+YwUUSUhryVyaZD7XcBmSbrnq7H1pEZrsgADoIpNE5u4zp9hpxbUexvZOh466jeQh6UcY8TnVvwrsh8i7TC0wt33+hSLzP6rsjiThEsqMxjMGBDB+AXaib2z6X0Vhq9lWgE8DwOHOOM1bkWt/y/bVc+4ORE0CdVhGSA9/iWB+Ed4fMd8f3S/odoWUAMMgEss6nRaeX4HYTNcTqaPs0zzPLfbSdKMSQ4zsud2RQWsHX8+rRA3A3EHwLZwq0h+Xfp4sWTDeMcbjw4kIv+eoFzl+e/IMq+JTxQq8F50qDhU6/ws7AykODN5Ye/q/S83X8RRAzseVGKfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LOFRtwrcD7rN6YH+uqx6/a11BSDiimjGTkR7LuUd9kb96avXEoAErQleNerPr9vVxEIzwQwNh8JkouST5JBUwVfrcB9KqqhCiGD+znhiAM41+KyAV+5MT+gTnx1TzmQx/CMdKYmyG14PnC6DWGOAUWyH/Mxc6fL20NCQ8tGQsVdRc82jb1gPWSb01KCg/y31RKvaza7mz6hjX+PbWNy/5D2vGukJZS9rIK3knhMRhYZFThSj6LmYNGNnUk669zq+Ic9vYcu3JAV3C694Qflqm1ex1yjI3ZdhJroD9FUr+f6QDfgEVsL3nHHI1Ab4qQkQ6PVSbLbMjLmHxWnNs2gs5kMY+pQLufY2u/OTgWxiIyjvVLGhgB0uylF1/nlbP8V7NOhsfzbcyNa+0nz8PO2QyXAGkDn0VJfvcVEwndDD6R+Ygfxi7CL1kNXA9a2Y3fDx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:55:07.5873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f08fbc9-0ca2-4efc-ee76-08df1a64f871
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
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

From: Gangliang Xie <ganglxie@amd.com>

add uniras support for psp v15_0_3

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_psp.c           | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index ed53cd25d6bd3..f7416bf184ede 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -47,6 +47,7 @@ static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
 		return &ras_psp_v13_0;
+	case IP_VERSION(15, 0, 3):
 	case IP_VERSION(15, 0, 8):
 		return &ras_psp_v15_0;
 	default:
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 701b696a7836a..e4fc455c6e3f7 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -336,9 +336,10 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct ras_module_param *
 	if (param && !param->ras_feature_enable)
 		return 0;
 	else if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 8))
+		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
+		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 3) ||
+		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 8))
 		con->uniras_enabled = true;
 	else
 		return 0;
-- 
2.55.0

