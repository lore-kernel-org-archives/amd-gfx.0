Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6C7C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 17:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185E910ED20;
	Fri, 14 Feb 2025 17:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f6+QVkQq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6303910ED20
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 17:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dn1VtmJJFQ40ID4DOudfZN4irLCNFXvvZ4sJgxsCOAYP1QTeFr1HZUuDagFDhqvYxhLtiWhSaQzN/C3RLJStgLvI9/jE8htygUxdggZspoI4KVTdCtfwqtpdOV0C3rQ/D5XRkl5O/8AYyKxbiHftLSTsaH47tc5iNVXCxd7lPOYhPWxsiCFLxLTLOYh8jd5GEOQ596nYwBNQBawrZWgAeRZX5N2mgH5nmMi/ZAwF8/fqIpbR4JHo9jeve/XfL382v5MRTxSz2skxt8E+2HRhssaGz+DEU3PyN2gqmoiMWLyBZ9XQu94PWmNbzpviX0Akdpp2wx2HJSp+DqgW9WAnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgFEu/ed+JUGmbR51GG3Vue88CCTBuPhdkK0Wq5kFDQ=;
 b=XoYG+14XiOKieF+muhCXRV6TSPuOTyJtHl6ZWj2HcNe/rqfPDwXKzP17/fMlFYbmGSWwBNhksVzJRIe5Xw3FoeSOhUGo7yQmgp+F2y23XgUca+KxbUU7C7NindQNklRlfteUN+px5iinn7RnKgFFQmA2CFf9NtUJRwoN9jx4L33gOvYmiixh/t0jpzjB0K9soUFX1p5zrQfE1yB3jZZ764jYhVG19XglYjFqquEArzKvrja1GTj3+coa9a7ruKXdmXnml8OUVTEVkslC4qotuyiywqy0Qou7ecQj71nIiM95Q0snjTfBPia86ZknsKncXZ6tr0P9BgDHmouz/NoqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgFEu/ed+JUGmbR51GG3Vue88CCTBuPhdkK0Wq5kFDQ=;
 b=f6+QVkQqWXEfkpKkNKknDBWN54hznW51SgXHZJ5aRUt2s2WHA5oNrWqtnpRnJBAOc84+IrGjE8XAIEA80gjBlVynSpIyre+ikc/SCOXu2cz55u28pOrdeFUFwJAw0mH9yI87kIiwDO2NT4Ar7EV4OS7TSwDN9TUvDvYC/eMxork=
Received: from BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15) by
 SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 17:35:37 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::93) by BYAPR01CA0002.outlook.office365.com
 (2603:10b6:a02:80::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 17:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 17:35:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 11:35:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Shaoyun Liu
 <shaoyun.liu@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/mes: keep enforce isolation up to date
Date: Fri, 14 Feb 2025 12:35:22 -0500
Message-ID: <20250214173522.2373211-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd9e165-fabe-428a-4145-08dd4d1dfdfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZuME215r0R/sC0BvFnff+C02GuXtxhna+F+ZxDwMCKBcbElvOVEbguk3g0Bt?=
 =?us-ascii?Q?mQGGccAU+paofrggjIv5aYsfK/zjEVGm0pglBs1ReFe0ql2tfKVxdb99vcWC?=
 =?us-ascii?Q?aeqyrDhs/hZVl+XRJe7Ip5ZtXKje2oPnHCn8K8+5nFxHZHX0ytMnetaSZzwh?=
 =?us-ascii?Q?Hkii2XiDsnRofZNA1YqdPDPZ0+ACeTFKHbqdsvqtm9UxjkMAxq6Pc9YZoNpo?=
 =?us-ascii?Q?JEshiaiCTCzBsvggbfeM9JUKY9In6jfSxyXJW2dxNMzGpJiHnUcjFeWM5oVp?=
 =?us-ascii?Q?laOUBEFDtQyAVu5DHDmz0Tg0KhdcIPLkXt9MPe8/AtHH9xx1cH1crA4RfN79?=
 =?us-ascii?Q?xjEq4Oyomiw00GAu/hJMuffRdFswfG+AgnF7DNJHKkEErvAjm0yJN+/8zL61?=
 =?us-ascii?Q?/nLmxlmfD7VhTxBemAdcKx2AOMY6QgdW+Z9Geak3DQxXyJoJaAwvOT9bwuwz?=
 =?us-ascii?Q?Wa2YnGwDL5saUdOSya4suunQpRwitiVORk+hozoB/MCXkwlGQgLrfU6YqlB4?=
 =?us-ascii?Q?yFLb0qi5V+zxopbFS/FCKX05RDslAA9plkQdbgoYn+uMc0ZpQtNU2lXql+/t?=
 =?us-ascii?Q?VO2vxUzGfIk4g5yi6oIiH70zBov4wk9uQKnIuY8NCXT41uixLSpGa2zxalol?=
 =?us-ascii?Q?WjiQ32n+a/R1+AJFVbneJVl+J9NKGFSOQD8TMm9sHa2XFPip3vGgW+UQTvXE?=
 =?us-ascii?Q?pvA7QWv6jN2dKa55xCohak5fuX8XpoYBJ82RSgLNzSv1S9mgoKXmohi/TvaK?=
 =?us-ascii?Q?X7icL1r6rGDt+exfS8DG+xqoyFxGY+14EUp01/Vj7fRMMV7ELxWCCF+cFGeH?=
 =?us-ascii?Q?huhr1T4gfGNoj6GffTiKdQZA8lJcGIJ9/FYVDMlggS7LQ6Uu9Jd5/+pT1gL9?=
 =?us-ascii?Q?AE7FLMgesesdS5bIC+dQmJ40E4XMiw14UyXM9y4VIf5AxzKA5piRKC2PcjAs?=
 =?us-ascii?Q?M7CIpcNEWJQHl9ubUGUd4qQczAghELrVvt0O6nnqkYmFsHxRfRDAw9y0fQ6g?=
 =?us-ascii?Q?d7RHiNeiCOT1L1LN8oP2ay7KWHdMLjYzK/HRhpC/Z72VCmbNEY1XHI5HueP2?=
 =?us-ascii?Q?b+i3J6aDZicCJV1xV+iaHC6KK5uksP3QtMUJiX/EZEYeyJRLQCWFZWk0w6T8?=
 =?us-ascii?Q?Y4sqswrW1E3E0wNroY1WPrwRVMbz9j+qKIwmBHkN2mE7R/Nyz/17BFaauNeH?=
 =?us-ascii?Q?1fBK772Bgq9csYdBLHpiGrnHltT6Qtb5bniR85yJSabZ0cQm2vjduLlsHk8E?=
 =?us-ascii?Q?nprc2CaNjXLiCf0tB5pk/FRh/kPQkn44O0j1Vjy4WV2dIMN9U8FflGOlT0l2?=
 =?us-ascii?Q?JM8Un+I3mcGFK6n0zWInjU9LjXZxe5h1LIyZgsxQubumrhdN19TT9GyfY9Gz?=
 =?us-ascii?Q?lSfJwf9RMzaZ7Jtjvi7UkVYURDPkH/ywgkCYvV70ccNQdDmW7unILfxIxfcm?=
 =?us-ascii?Q?2rb4j0F4NJGXAXRhiMuQpUEp77+cZKulDjguB9/JmkZEQIXubX4rSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 17:35:36.5473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd9e165-fabe-428a-4145-08dd4d1dfdfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
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

Re-send the mes message on resume to make sure the
mes state is up to date.

Fixes: 8521e3c5f058 ("drm/amd/amdgpu: limit single process inside MES")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Shaoyun Liu <shaoyun.liu@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++++
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b9bd6654f3172..a194bf3347cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1665,24 +1665,19 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	}
 
 	mutex_lock(&adev->enforce_isolation_mutex);
-
 	for (i = 0; i < num_partitions; i++) {
-		if (adev->enforce_isolation[i] && !partition_values[i]) {
+		if (adev->enforce_isolation[i] && !partition_values[i])
 			/* Going from enabled to disabled */
 			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
-			if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
-				amdgpu_mes_set_enforce_isolation(adev, i, false);
-		} else if (!adev->enforce_isolation[i] && partition_values[i]) {
+		else if (!adev->enforce_isolation[i] && partition_values[i])
 			/* Going from disabled to enabled */
 			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
-			if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
-				amdgpu_mes_set_enforce_isolation(adev, i, true);
-		}
 		adev->enforce_isolation[i] = partition_values[i];
 	}
-
 	mutex_unlock(&adev->enforce_isolation_mutex);
 
+	amdgpu_mes_update_enforce_isolation(adev);
+
 	return count;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index cee38bb6cfaf2..ca076306adba4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1508,7 +1508,8 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 }
 
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
-int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable)
+static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
+					    uint32_t node_id, bool enable)
 {
 	struct mes_misc_op_input op_input = {0};
 	int r;
@@ -1530,6 +1531,23 @@ int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_i
 	return r;
 }
 
+int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
+{
+	int i, r = 0;
+
+	if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
+		mutex_lock(&adev->enforce_isolation_mutex);
+		for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
+			if (adev->enforce_isolation[i])
+				r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
+			else
+				r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
+		}
+		mutex_unlock(&adev->enforce_isolation_mutex);
+	}
+	return r;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 6a792ffc81e33..3a65c3788956d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -532,6 +532,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
 
 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
 
-int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable);
+int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 530371e6a7aee..fc7b17463cb4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1660,6 +1660,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 		goto failure;
 	}
 
+	r = amdgpu_mes_update_enforce_isolation(adev);
+	if (r)
+		goto failure;
+
 out:
 	/*
 	 * Disable KIQ ring usage from the driver once MES is enabled.
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6db88584dd529..ec91c78468f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1773,6 +1773,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 		goto failure;
 	}
 
+	r = amdgpu_mes_update_enforce_isolation(adev);
+	if (r)
+		goto failure;
+
 out:
 	/*
 	 * Disable KIQ ring usage from the driver once MES is enabled.
-- 
2.48.1

