Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE82E9126B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A4010E7D2;
	Thu,  5 Feb 2026 06:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47WKBd+c";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7686E10E7C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8xiWXWyLO8tkqPzNM4tSn7+JtDFCMu9KItXYQiQw4OBU6wfGdjFOyB9U/sah84wzKN4oTL25SOEKtg+rOeAL1xd4q0SvYw4oFpz4aJSIN01RPOwvX0h1JVRbAknPUwt4FkjFTLlhbW3dCbl2E5xC7IH4JVejfulIi/aUkaGdTOaYGIpUsri0Vtp6EOfdnnb2zd8aG+Xg3VFVM6h1y4fm7HjB2t14JwKRZ50tdbfP8u5wiEHAnbUlKT8DavAu3M7wW5hj4pkN/FvNu816L5dy6bFrWPCRLD9evk590oWiDeTKFDV9uw2WOxuodLedl5PBQsA1QsJdtbnUSh04c1pBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXfZAMSi/EufYj0GDR7T3989CpT1XG1kZ+FxdZA35DY=;
 b=iatqtoC5Rksa4AMafE/ajeVG0MpWURP40A1fLd5C40PbhPRJAHZQkzX+TuXaBoDJTsxNQzE8sneNV6iXZFgTIZxEYwEyURbYATX7PuRQbjRBHAdNjvc47PlxabJ7kz+ibbYaY9ikx6xUxbVw2oviqnFV+BC7TAmEI3ux99Mo6/qo1US3HhuzACPAawuXcSHNS6aHxC4l0Ucuch0lqaKg0GxPQot85MhlrS7A/c2ETuzQKcqJn+mIoN3jE/87dX8FRddjjc0eeOlanZFxMxHAkVpPy2b3yB6kJcpuC4U2TBhx0kbV1+fE55WPohjB6BLXqhMejl8op/Rc5a/4hePvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXfZAMSi/EufYj0GDR7T3989CpT1XG1kZ+FxdZA35DY=;
 b=47WKBd+cxwHiudcx2Sbyrcwpq8lRVj3UjLebLiIsDdtr/N1g1fhd/lrfUtMJY3BQa4eJLQEE2z518YTXU+pgH8x2VTzXWgIZtMZGrdfFcWRAO1T56EYZMKp3kcp/MIFU+rASOC6g/fe40j76UQpExTOLKor23H4XYqMuASfqM4c=
Received: from PH7P221CA0051.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::21)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:52:10 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::34) by PH7P221CA0051.outlook.office365.com
 (2603:10b6:510:33c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 06:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:52:10 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:52:04 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 18/22] drm/amdgpu: clean up PTL structure member naming
 convention
Date: Thu, 5 Feb 2026 14:51:26 +0800
Message-ID: <20260205065130.654921-18-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 63215fbd-fd0b-4805-d56e-08de648315f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RRsQnZy4z9+VBn9yLo1xsr+BcTJprNlZy2Yb+NTWbN99rzdYhdqNsQ1GrGiB?=
 =?us-ascii?Q?NvsLWm7Do2X5phGuqiW/5hTUhM/mzgqJVe+iiNIBbWrgIfQg63YzJg7xH339?=
 =?us-ascii?Q?hZTRG/x+XfLyYLRUpy+MisBaUWOqPLEbzAGRKP3aB4+/oBQwmJVeqDGHa2s1?=
 =?us-ascii?Q?xAQD7iMG+V9/GynnfQmmTIXBMZgXTnTV32kEm/AVU1A7eoIawWK+BYGUSbYa?=
 =?us-ascii?Q?grV/jXRiYh1bdODTjVOF9UL6Zv7DoUOLiUW5BNuRJaAzBgG6Ugxw6AjuMcKs?=
 =?us-ascii?Q?3VwE3gPRwGgWz1/zcVmftt/Xhin1T6nigx5JIUUbhDUBmDtSfR3tPifKnDNg?=
 =?us-ascii?Q?IViuVk13kja0CYRHxHkXqb4swnIFWgtsiHdIFLwgh/JmIBBjBs5VWKpS4i8U?=
 =?us-ascii?Q?ntz7ETucDkVNjGqLkCdHijCF6sj+oNBpLj4boyraQy3bcDXMTIMDY7ypW9Ky?=
 =?us-ascii?Q?9rbphe0CGtzzt9geeCS4csp5Jq5H6Vdp0WjPu0Yo2o8jI6cp/LMZyJ5ltHO+?=
 =?us-ascii?Q?rocVY313KV+y24p2LCqcg/ImD2irm8lJtDLO/XV3yTip4jyho7fn7bim3kFa?=
 =?us-ascii?Q?tJwLCMXOJLTzSCUryIMcAFqyqUSfkT2UfCbMTmy7u9DVVdYzjpC22A83M3aB?=
 =?us-ascii?Q?OJHbN799bPUlgagrJzCCB1E7YyRiuJZfdw9XIzyFotyXkJlfqLCpMqewLojW?=
 =?us-ascii?Q?I8LPRT3aXB1u3WgfglzUPf1XKjgkUe49tvZ5X9dPeJqqqZ534Z3rIn/VuGiZ?=
 =?us-ascii?Q?yDO2tg3vhXEPWv+eo6CJR3qgkfsE7MtIFpKoa90In/serZX25cQtukMRgrxN?=
 =?us-ascii?Q?i+H8OEXGYEXCEd+Fcjl8GMzoXOSsiMmjUnphn1XTQ6Ba0gAtulcYaZrLKyPr?=
 =?us-ascii?Q?s+7l77T/q5prwrTaaOKzphYpR/+4IHTSwyB5KH2EhapM0fNSJ5X3b862E6t/?=
 =?us-ascii?Q?ABjX6GC/OJO73/EH1usN9E2OoqHk2/uw65s1KIifbF1P9Qcl0mtjOjhalXDH?=
 =?us-ascii?Q?ubI9ikOI2ps9W83Aq5Sb5Ft4ap/mEwXpFrx1PIuhkKPn9HjzRCMKQTlO5rr3?=
 =?us-ascii?Q?zHrD8PYLT3GRsriEGMzSDR1twWw714KMUQKOc54MBwbGGvn8fhotWZbgFioY?=
 =?us-ascii?Q?fK+r9qoyJBFtn0CrFRpkEDYApqI+O9wPvKqvwX1rdOxe8DAYNUIDNFHVEKQl?=
 =?us-ascii?Q?RkvyyxH6rDtGbiZDqepZPTVhms384dvCprgvaqq6q2tIxNxseHsLChmgnmDc?=
 =?us-ascii?Q?qascuidEggOrlJTxCkCcsFqRJVHv9AVZKc5c8uU4vYLFP/rUACkMMJ0NNPAi?=
 =?us-ascii?Q?BQVdnYyq0BE+JxPekVCN40S2kWacROJCNgLPKBYezPB/rcarx7gT+aCK4W/d?=
 =?us-ascii?Q?8jWDE+jrZ2IJzwIjAo30L4Lg87r867kNb+k3xl3Nr7UQhDPNMSqJ0L01nKcv?=
 =?us-ascii?Q?dd6fRs/5r2ODZytiNSeat9UcRTw9xSg8Y0JRIxCNVCHlqUR2NXQsCJafgO5t?=
 =?us-ascii?Q?viU1KaAdsPNDzaqqy9IJNwUv0FpDHvME9nEhxgVFaA75rj0SHi96jamA0YOB?=
 =?us-ascii?Q?VPLSWrtCI7QPjVsuG2d/zJJn8kLdDoyWBd0vCWld7kC4btxLXCI5Q4eK+Qzb?=
 =?us-ascii?Q?f0UPFX22xFxD0Z5s0AxzQVQ8MPWkQsKqbvdVL7ahpHBFwPhK2IkPhJAtjI9j?=
 =?us-ascii?Q?aMBydA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nppe8BJ1V+NUGXBAoWsooTcWnRhaQkegzIlCxYj/AfmrqVnBfrWww+tj4evhgcAQtcvOcUT0WeQcTouwmtsv15s9jVsbRW/XY222GkeEUMXOIOLlhnRQCe5KT6I5B53dit0BVYStbvAZFRAv9fRBUHAUTUW6/YQke7j+HzeR8ivIg0w2CC70lnPDt8bFfTSNtLDKot/ZK7bYra9MNCygukvhOujFaGPiUf2ZHoptgGOwOJROAACydwX20fIHH7joRhVzPUn0BysfqHN9hw6BthHe5uw2UrvSfhyuhahDBd/HNSFJ4xr2t8eW8q0OjAg0bBRVc+654BUZgLKH7qTf1eZzXOK9dzbDI0nq8QFNlWktSIEnPxAs4OIOBnZ59OEiX14ZcvnWY5R195SzGtC1bemriR6eZnisTAsTvHvJY1eNYyeO0THv9tx70+LSIXFu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:52:10.4132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63215fbd-fd0b-4805-d56e-08de648315f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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

Remove redundant 'ptl_' prefix from amdgpu_ptl structure members
since they are already accessed through a ptl pointer, making the
prefix redundant and verbose.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 57 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    | 12 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 12 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 26 +++++-----
 5 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 827fbdb81011..da7585d1c6e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4442,7 +4442,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
-	mutex_init(&adev->psp.ptl.ptl_mutex);
+	mutex_init(&adev->psp.ptl.mutex);
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 357357523347..95af5f1d8f5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1267,9 +1267,9 @@ static int psp_ptl_invoke(struct psp_context *psp, u32 req_code,
 		break;
 	case PSP_PTL_PERF_MON_SET:
 		/* Update cached state only on success */
-		ptl->ptl_enabled = *ptl_state;
-		ptl->ptl_fmt1    = *fmt1;
-		ptl->ptl_fmt2    = *fmt2;
+		ptl->enabled = *ptl_state;
+		ptl->fmt1    = *fmt1;
+		ptl->fmt2    = *fmt2;
 		break;
 	}
 
@@ -1285,7 +1285,7 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 {
 	uint32_t ptl_fmt1, ptl_fmt2;
 	struct psp_context *psp;
-	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	struct amdgpu_ptl *ptl;
 
 	if (!adev || !ptl_state || !fmt1 || !fmt2)
 		return -EINVAL;
@@ -1294,6 +1294,7 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 		return 0;
 
 	psp = &adev->psp;
+	ptl = &psp->ptl;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) ||
 			psp->sos.fw_version < 0x0036081a)
@@ -1308,9 +1309,9 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 	 * Add check to skip if state and formats are identical to current ones
 	 */
 	if (req_code == PSP_PTL_PERF_MON_SET &&
-			ptl->ptl_enabled == *ptl_state &&
-			ptl->ptl_fmt1 == ptl_fmt1 &&
-			ptl->ptl_fmt2 == ptl_fmt2)
+			ptl->enabled == *ptl_state &&
+			ptl->fmt1 == ptl_fmt1 &&
+			ptl->fmt2 == ptl_fmt2)
 		return 0;
 
 	return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_fmt2);
@@ -1354,33 +1355,33 @@ static ssize_t ptl_enable_store(struct device *dev,
 	uint32_t ptl_state, fmt1, fmt2;
 	int ret;
 
-	mutex_lock(&ptl->ptl_mutex);
+	mutex_lock(&ptl->mutex);
 	if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1")) {
 		enable = true;
 	} else if (sysfs_streq(buf, "disabled") || sysfs_streq(buf, "0")) {
 		enable = false;
 	} else {
-		mutex_unlock(&ptl->ptl_mutex);
+		mutex_unlock(&ptl->mutex);
 		return -EINVAL;
 	}
 
-	fmt1 = ptl->ptl_fmt1;
-	fmt2 = ptl->ptl_fmt2;
+	fmt1 = ptl->fmt1;
+	fmt2 = ptl->fmt2;
 	ptl_state = enable ? 1 : 0;
 
-	cur_enabled = READ_ONCE(psp->ptl_enabled);
+	cur_enabled = READ_ONCE(psp->enabled);
 	if (cur_enabled == enable) {
-		mutex_unlock(&psp->ptl_mutex);
+		mutex_unlock(&psp->mutex);
 		return count;
 	}
 
 	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to set PTL err = %d\n", ret);
-		mutex_unlock(&ptl->ptl_mutex);
+		mutex_unlock(&ptl->mutex);
 		return ret;
 	}
-	mutex_unlock(&ptl->ptl_mutex);
+	mutex_unlock(&ptl->mutex);
 
 	return count;
 }
@@ -1391,7 +1392,7 @@ static ssize_t ptl_enable_show(struct device *dev, struct device_attribute *attr
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct psp_context *psp = &adev->psp;
 
-	return sysfs_emit(buf, "%s\n", psp->ptl.ptl_enabled ? "enabled" : "disabled");
+	return sysfs_emit(buf, "%s\n", psp->ptl.enabled ? "enabled" : "disabled");
 }
 
 static ssize_t ptl_format_store(struct device *dev,
@@ -1408,13 +1409,13 @@ static ssize_t ptl_format_store(struct device *dev,
 	int ret;
 
 	/* Only allow format update when PTL is enabled */
-	if (!ptl->ptl_enabled)
+	if (!ptl->enabled)
 		return -EPERM;
 
-	mutex_lock(&ptl->ptl_mutex);
+	mutex_lock(&ptl->mutex);
 	/* Parse input, expecting "FMT1,FMT2" */
 	if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) != 2) {
-		mutex_unlock(&ptl->ptl_mutex);
+		mutex_unlock(&ptl->mutex);
 		return -EINVAL;
 	}
 
@@ -1424,20 +1425,20 @@ static ssize_t ptl_format_store(struct device *dev,
 	if (fmt1_enum >= AMDGPU_PTL_FMT_INVALID ||
 			fmt2_enum >= AMDGPU_PTL_FMT_INVALID ||
 			fmt1_enum == fmt2_enum) {
-		mutex_unlock(&ptl->ptl_mutex);
+		mutex_unlock(&ptl->mutex);
 		return -EINVAL;
 	}
 
-	ptl_state = ptl->ptl_enabled;
+	ptl_state = ptl->enabled;
 	fmt1 = fmt1_enum;
 	fmt2 = fmt2_enum;
 	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to update PTL err = %d\n", ret);
-		mutex_unlock(&ptl->ptl_mutex);
+		mutex_unlock(&ptl->mutex);
 		return ret;
 	}
-	mutex_unlock(&ptl->ptl_mutex);
+	mutex_unlock(&ptl->mutex);
 
 	return count;
 }
@@ -1449,8 +1450,8 @@ static ssize_t ptl_format_show(struct device *dev, struct device_attribute *attr
 	struct psp_context *psp = &adev->psp;
 
 	return sysfs_emit(buf, "%s,%s\n",
-			amdgpu_ptl_fmt_str[psp->ptl.ptl_fmt1],
-			amdgpu_ptl_fmt_str[psp->ptl.ptl_fmt2]);
+			amdgpu_ptl_fmt_str[psp->ptl.fmt1],
+			amdgpu_ptl_fmt_str[psp->ptl.fmt2]);
 }
 
 static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
@@ -1460,7 +1461,7 @@ static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *att
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
 	/* Only show PTL sysfs files if PTL hardware is supported */
-	if (!adev->psp.ptl.ptl_hw_supported)
+	if (!adev->psp.ptl.hw_supported)
 		return 0;
 
 	return attr->mode;
@@ -1468,7 +1469,7 @@ static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *att
 
 int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev)
 {
-	if (!adev->psp.ptl.ptl_hw_supported)
+	if (!adev->psp.ptl.hw_supported)
 		return 0;
 
 	return sysfs_create_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
@@ -1476,7 +1477,7 @@ int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (!adev->psp.ptl.ptl_hw_supported)
+	if (!adev->psp.ptl.hw_supported)
 		return;
 
 	sysfs_remove_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d8591602b304..0997b13a5f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -383,13 +383,13 @@ struct psp_ptl_perf_req {
 };
 
 struct amdgpu_ptl {
-	enum amdgpu_ptl_fmt		ptl_fmt1;
-	enum amdgpu_ptl_fmt		ptl_fmt2;
-	bool				ptl_enabled;
-	bool				ptl_hw_supported;
+	enum amdgpu_ptl_fmt		fmt1;
+	enum amdgpu_ptl_fmt		fmt2;
+	bool				enabled;
+	bool				hw_supported;
 	/* PTL disable reference counting */
-	atomic_t			ptl_disable_ref;
-	struct mutex			ptl_mutex;
+	atomic_t			disable_ref;
+	struct mutex			mutex;
 };
 
 struct psp_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f53934edfd3b..13933e3ee096 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2380,12 +2380,12 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 	if (!adev->psp.funcs)
 		return -EOPNOTSUPP;
 
-	if (!ptl->ptl_hw_supported) {
+	if (!ptl->hw_supported) {
 		fmt1 = GFX_FTYPE_I8;
 		fmt2 = GFX_FTYPE_BF16;
 	} else {
-		fmt1 = ptl->ptl_fmt1;
-		fmt2 = ptl->ptl_fmt2;
+		fmt1 = ptl->fmt1;
+		fmt2 = ptl->fmt2;
 	}
 
 	/* initialize PTL with default formats: GFX_FTYPE_I8 & GFX_FTYPE_BF16 */
@@ -2394,9 +2394,9 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 	if (r)
 		return r;
 
-	ptl->ptl_hw_supported = true;
+	ptl->hw_supported = true;
 
-	atomic_set(&ptl->ptl_disable_ref, 0);
+	atomic_set(&ptl->disable_ref, 0);
 
 	return 0;
 }
@@ -2406,7 +2406,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, num_xcc;
 
-	if (adev->psp.ptl.ptl_hw_supported)
+	if (adev->psp.ptl.hw_supported)
 		gfx_v9_4_3_perf_monitor_ptl_init(adev, 0);
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index efdd19d6d6da..c276ef6801d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1768,12 +1768,12 @@ int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
-	enum amdgpu_ptl_fmt pref_format1 = ptl->ptl_fmt1;
-	enum amdgpu_ptl_fmt pref_format2 = ptl->ptl_fmt2;
+	enum amdgpu_ptl_fmt pref_format1 = ptl->fmt1;
+	enum amdgpu_ptl_fmt pref_format2 = ptl->fmt2;
 	uint32_t ptl_state = enable ? 1 : 0;
 	int ret;
 
-	if (!ptl->ptl_hw_supported)
+	if (!ptl->hw_supported)
 		return -EOPNOTSUPP;
 
 	if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
@@ -1800,15 +1800,15 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	int ret = 0;
 
-	mutex_lock(&ptl->ptl_mutex);
+	mutex_lock(&ptl->mutex);
 
 	if (pdd->ptl_disable_req)
 		goto out;
 
-	if (atomic_inc_return(&ptl->ptl_disable_ref) == 1) {
+	if (atomic_inc_return(&ptl->disable_ref) == 1) {
 		ret = kfd_ptl_control(pdd, false);
 		if (ret) {
-			atomic_dec(&ptl->ptl_disable_ref);
+			atomic_dec(&ptl->disable_ref);
 			dev_warn(pdd->dev->adev->dev,
 					"failed to disable PTL\n");
 			goto out;
@@ -1817,7 +1817,7 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 	pdd->ptl_disable_req = true;
 
 out:
-	mutex_unlock(&ptl->ptl_mutex);
+	mutex_unlock(&ptl->mutex);
 	return ret;
 }
 
@@ -1828,15 +1828,15 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	int ret = 0;
 
-	mutex_lock(&ptl->ptl_mutex);
+	mutex_lock(&ptl->mutex);
 
 	if (!pdd->ptl_disable_req)
 		goto out;
 
-	if (atomic_dec_return(&ptl->ptl_disable_ref) == 0) {
+	if (atomic_dec_return(&ptl->disable_ref) == 0) {
 		ret = kfd_ptl_control(pdd, true);
 		if (ret) {
-			atomic_inc(&ptl->ptl_disable_ref);
+			atomic_inc(&ptl->disable_ref);
 			dev_warn(adev->dev, "Failed to enable PTL on release: %d\n", ret);
 			goto out;
 		}
@@ -1845,7 +1845,7 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 	pdd->ptl_disable_req = false;
 
 out:
-	mutex_unlock(&ptl->ptl_mutex);
+	mutex_unlock(&ptl->mutex);
 	return ret;
 }
 
@@ -3338,7 +3338,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 			kfd->profiler_process = p;
 			status = 0;
 			mutex_unlock(&kfd->profiler_lock);
-			if (ptl->ptl_hw_supported) {
+			if (ptl->hw_supported) {
 				status = kfd_ptl_disable_request(pdd, p);
 				if (status != 0)
 					dev_err(kfd_device,
@@ -3356,7 +3356,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		status = 0;
 		mutex_unlock(&kfd->profiler_lock);
 
-		if (ptl->ptl_hw_supported) {
+		if (ptl->hw_supported) {
 			status = kfd_ptl_disable_release(pdd, p);
 			if (status)
 				dev_err(kfd_device,
-- 
2.34.1

