Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A90C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C4B10E732;
	Wed,  7 May 2025 02:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XgIdwXTE";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE43510E732
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDhpXjbRjAnl2T6NRPi0pgYfzHuC0mDqVGsaWiPQXVXbrypfZxXDdAKfWtavmLnhPfdnX0ZXb3qsM4ub00nqAFGeVDTQVBpN3dUphh9IDYHcEI73qnMGt7VMSN+M3QX220wFF12ieWlPQipAa9/pkvMGtHQXGmys3YeBELbPbcVr+/HyV8M68Ri8/maUtE5lbbifN0wHODiuLA+e6ggBFTM+5bt0NasLvpH6eoAw2BAqvGHUHKJeDgFDZhBHbDC70B38oTpgaBWkxvOQv5u51s5lsmE/4rRQBA+L1H2lmjD+RfzYrq7RfWOR2Atpw292ijyHsazN4me67tQuqzSw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94aMlJnNmOchEhnw5n3VxeRXfsn3pkFHTSpLxiDIA+0=;
 b=NkewkFTfaHAXa+4OEsctyHMEo+MyMx/mR1iyBlCmj0+mgsq/B4ENih+PurJxucuz1dIyZDnRk7mOWowEFft4GQocRo8x2oKUO9TKxfzeHFTscLkDI99aeBLP0/BqZPoqU2AWQ9pR6jY4Pj5xq3rm9p4/gLYEyK1wIreRZS8m5FSf4jdYN6a8Bbbuxhfx8sRsi8p3NVTWVBHu/AXsq0pbrMHY73kWssPubKDseVniqJisVfRBRUl7r8f4Slzw2JKLYXYfo9bCvzg0WtQtTpCPvhyOZyng3umje5Qq697SL7PAqdFP1nqkJiQrnfGkxUIBOhBpVFoAwJNASr91Et3aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94aMlJnNmOchEhnw5n3VxeRXfsn3pkFHTSpLxiDIA+0=;
 b=XgIdwXTEZBWQxsOvNr9HKec6cnb5+nvQ/HgT6AfmQ1gWZuV2J5mytMXi2D8nR/XIUmIO/dPul95ooSQctqFvEn54IHcS5JvkI1dimn5UR2vRZMi9QXSYsnWbfK+mQ+l7sMDIynu+1Hg1YcNsbqThNbhX4ivycLNL4vzZgZbV6A0=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 02:43:23 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::f1) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Wed,
 7 May 2025 02:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:08 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:05 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <Dillon.Varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 01/14] drm/amd/display: Backup and restore plane configuration
 only on update
Date: Wed, 7 May 2025 10:34:45 +0800
Message-ID: <20250507024242.1928299-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f58b8b-bc70-4c9f-89a3-08dd8d10ef57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5KQod9H66tHkQR6sK1dcSIoi/660f9ie5cv6p+bpazRF6iJBOE4TXWikNVRV?=
 =?us-ascii?Q?hK02C5MeqJ/V0W+UVN7SXiMynFLVlR0Mz6/a/09NsovtW/ijJ7E9LXO7Nohv?=
 =?us-ascii?Q?t7+3VuxrWvO0nUIu5DVV4O9QdfCX6UJclImYIRJYOSHP/wrPZX0s7Qq9G0IK?=
 =?us-ascii?Q?jVhiWEYAUKpPrqb8Ll5+qWM2c1DYv13Xgb/fd/6SXwdYugRWtES5r+LqS6ce?=
 =?us-ascii?Q?J2FGQihzeULuuQRdQorJYLgYgL3Bt4lJTBNnGpVs5A3HJc1TC7g55dbeZ0cm?=
 =?us-ascii?Q?s1m5DR5cYqy+OqzpSaV6rQdapB+SLKdBOrnvSTySAK85WHNb+OY86pkqcCRX?=
 =?us-ascii?Q?F4IVijSR5cWE0N1jZbqNUYOy3GZ9/j2zjDQjijLfMH01kiIWkxU8VhdjyOOq?=
 =?us-ascii?Q?RLCnlCNoOXQVw8Vf2pjZkWBeHP08hpt1MFrBPDFSjXno7HJVtMtjVd7iYXiJ?=
 =?us-ascii?Q?hEPx3UUja/nzQ29vbMfPOkzIm/FbT1ueMss4xVRVTxvZDNzSd4aAdYFGssrC?=
 =?us-ascii?Q?0w3vGPUfxBr4qGHkEZvfUroH1QFBM6lzAivWkJC9bDRZt20RVgp5YOYqCKOA?=
 =?us-ascii?Q?wMo3wARfnfYORMIPzdB5Itzuyvj/BjoHCoEu7D5cAg0gC99yTJrYawAs2OK/?=
 =?us-ascii?Q?FRkCq+8j23F+pdsB0Tf/TMiY0p+/lal0v3/YYhn7iqxW5iBGrySanAl+h6nL?=
 =?us-ascii?Q?zjRwZFGtjHmtysObDIuTCiYupXhICaCsS1CS/tih5T8reUa5DrQhzPkdjd/b?=
 =?us-ascii?Q?98wTzqvYBu7uF7Sipl7H2oXfFYweblwATz90a37q3NPRSfaEWzdVCQKQZxCq?=
 =?us-ascii?Q?BawxSLxyTKPFSBWlBKwHYEZcIjzcfzZCc9aQezUjiOIRphJTKx9uulPlV4ce?=
 =?us-ascii?Q?1vdnQjVO1VUpq/BxLuCKf42m54Gsb+fz4Q0RB9FQGXXA4RE9WkoqTkhziBIG?=
 =?us-ascii?Q?cLPA0RTm++c/+Cm1JVVoFpWEhTI4aCZYoTPgCr61XHrnTVETOV/pQBQRW8/u?=
 =?us-ascii?Q?xodEPogakZ2R9EBLlZvPyPvRCXV2q0egWiBT/OvoJMgkaEJ+lfnCTYSXXf+i?=
 =?us-ascii?Q?VrjzYTAjl95Ve7PjQqLcDOAp+WCfhc/JQ3t2HnnQuq1Pb1Ig0wGMZBh+0K3u?=
 =?us-ascii?Q?pbDy7w+VCieZBQ/ybk5LO6Nj510fno1Gr3i1plKqPx5btULpKcUd1wFgLMU8?=
 =?us-ascii?Q?hrnQgvNZai+pzDWvNBbQLIUVW96tLf+uUTlwBGgMeuq1TrYUOz5iu5De2NUs?=
 =?us-ascii?Q?ip2USDuMDkXzjDF+7+I5hcSdhiUBLa8Y7KNWL4tEBEs9pbrAoUkRD3Ie8z/U?=
 =?us-ascii?Q?scyQ40Jg/ZwpmuGsC6kng2+RtVJSTeo4tv4eYAtPzIBnUo5TH+mAJO7m1+9q?=
 =?us-ascii?Q?rvRFln1vsFTy9nHge923OW91THHIBDPISGiKdkqDf6cLqXmr8WJTILDecbFV?=
 =?us-ascii?Q?E5SKd86lCR++ErsjlEB4Dz7Rwd7ud7BlmwD+3+QGk9QhmEaDhMIBuCTGBfKc?=
 =?us-ascii?Q?MLxm12Uw/u6DGz4LPvsd5hjzdByGZk9T1nEk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:22.9507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f58b8b-bc70-4c9f-89a3-08dd8d10ef57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
When backing up and restoring plane states for minimal transition
cases, only configuration should be backed up and restored. Information
only relevant to the object/allocation (like refcount) should be
excluded. Also move this interface to dc_plane.h.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c         |  8 +++-----
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h        |  3 +++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index afd298e69d4e..528e6fd546c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -36,6 +36,7 @@
 #include "resource.h"
 #include "dc_state.h"
 #include "dc_state_priv.h"
+#include "dc_plane.h"
 #include "dc_plane_priv.h"
 #include "dc_stream_priv.h"
 
@@ -3320,7 +3321,7 @@ static void backup_planes_and_stream_state(
 		return;
 
 	for (i = 0; i < status->plane_count; i++) {
-		scratch->plane_states[i] = *status->plane_states[i];
+		dc_plane_copy_config(&scratch->plane_states[i], status->plane_states[i]);
 	}
 	scratch->stream_state = *stream;
 }
@@ -3336,10 +3337,7 @@ static void restore_planes_and_stream_state(
 		return;
 
 	for (i = 0; i < status->plane_count; i++) {
-		/* refcount will always be valid, restore everything else */
-		struct kref refcount = status->plane_states[i]->refcount;
-		*status->plane_states[i] = scratch->plane_states[i];
-		status->plane_states[i]->refcount = refcount;
+		dc_plane_copy_config(status->plane_states[i], &scratch->plane_states[i]);
 	}
 	*stream = scratch->stream_state;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index e6fcc21bb9bc..e98500665af3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -294,3 +294,17 @@ void dc_plane_force_dcc_and_tiling_disable(struct dc_plane_state *plane_state,
 			dc->hwss.clear_surface_dcc_and_tiling(pipe_ctx, plane_state, clear_tiling);
 	}
 }
+
+void dc_plane_copy_config(struct dc_plane_state *dst, const struct dc_plane_state *src)
+{
+	struct kref temp_refcount;
+
+	/* backup persistent info */
+	memcpy(&temp_refcount, &dst->refcount, sizeof(struct kref));
+
+	/* copy all configuration information */
+	memcpy(dst, src, sizeof(struct dc_plane_state));
+
+	/* restore persistent info */
+	memcpy(&dst->refcount, &temp_refcount, sizeof(struct kref));
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_plane.h b/drivers/gpu/drm/amd/display/dc/dc_plane.h
index e9413685ed4f..8fe385f52b18 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_plane.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_plane.h
@@ -37,4 +37,7 @@ void dc_plane_state_release(struct dc_plane_state *plane_state);
 void dc_plane_force_dcc_and_tiling_disable(struct dc_plane_state *plane_state,
 					   bool clear_tiling);
 
+
+void dc_plane_copy_config(struct dc_plane_state *dst, const struct dc_plane_state *src);
+
 #endif /* _DC_PLANE_H_ */
-- 
2.43.0

