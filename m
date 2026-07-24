Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A45FC531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 02:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F381610E62E;
	Fri, 24 Jul 2026 02:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5C5NZGy";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707EF10E62E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 02:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O87QSeIw43PQMK11gsE3wVdpXeB2To8BcwFoPni3WOG2IV8A8kzT1gdSsI11hRGFrZ2XnfCVIUJiDMjFp+vCZcw5GtceQCmMrpPAuNsjCm44oKExfIrvQiWSxwffLSoBi2LlbafI+N9DD8NuipsyqalGQ8ef/4Yk+uWZUF/A6eh5DJZWrkEdtXze9OQXRSr/F2kihlshP82sEOIkv7WBy/AvEh4bWxjYGM6ZFsEDTADijL5BQwIw7Vccx11LC5iQWGxNWRYCOqPkiTj0eQbWg+9WgyVvpuC8zRCYX/WMPK+fj5I7l3GmsuysAGAtaYO5wElh366tzmw9/BgT/e7gAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnDpjeD/zGkl7sDibCCYWmgY+Bpljm+nAsThX2/+4Ks=;
 b=QIEcECQhL987Hee+G8pdqS/Gg1you2+pD5PooSsNKLfJidY16BJJCobtnG5a8mGCwpaC2BgEY2kzQoYSe7LKFnH8SdUcX1u3ITrhmtkM41EK76WS9GF27mbYN7ssYFcXHVicJKyxREyzIS17PQpMubrPMTz/CI9zmJ3G7iSKYnwTGUYVPxUKDk6fiju+O08xuEyiwYQCFQlB58gNoW+pMgMTGTtTtY1pf4yCaRXF8q/IENgXoA0ceW9ZMAL6IS/bSmgi4Mo/sXNeAsrt3AV8SBYHco2GpRonkt1a3MFwwcgVyoYJv7nxw0w77/rK6UC2JODaEvdHi6Z5GDBNjXmP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnDpjeD/zGkl7sDibCCYWmgY+Bpljm+nAsThX2/+4Ks=;
 b=m5C5NZGy/9jUP+W4yJGeqWet4Fnjce719peVjvR0720l1/p3uVZ/oWhc9U5XffPenJm3/5baIxbrXJWqAcFwb75wRTruoDMfAbrNRReLx6W4y1Lmvw8OWcrjraFpukiXt8Do65PmNhcQGqfxvI6ZmI3njX9NOLmRxx65h5gjM60=
Received: from MN0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:52d::9)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:55:37 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::4f) by MN0PR04CA0005.outlook.office365.com
 (2603:10b6:208:52d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 02:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 02:55:37 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 21:55:35 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fix pptable use-after-free
Date: Fri, 24 Jul 2026 10:55:21 +0800
Message-ID: <20260724025522.800587-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: eb587cdd-43af-4fed-c20f-08dee92f09f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|3023799007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Srl2FDXQH4HJF1wNaIn3G6txpz8wpbLlKifM7OyGNbSk/yIsO7Ck/wSqrZuDnvmuFig/0t69WcrQOeWxNBk0joWKGQCUcUrtW0IQpMttIlhNJ4wgWVw/yJEL/WfQsxYiYe4yPz5KTuatFWB6mMWgl8F9SXW5LI/AYZCZhUUPv1qHnUdszw+7d/Bx7TT8+47gRys2WvViLcceklATzsYtENVnVpsagB39EzLGZMViZdMjVN3qSrci950smRDIti25mmdkfFQ1Lik56aKjRPU2azgOH5xcHyCn4yjgH2PRZykmIoDGyUsSfWYfad344wIcmdytCak77njHysv3JgqtaYKniYF04RcBRIewRs64KWbj8WelRPv9M3/o56Yj7Av9YkJ6h7rO4n8Ah/umOlEqnnkrkiVIQ7r0VqXaSt/m8piFYeCZLjfaHl5Kc3f5hwwPRUmDXg97iQ2t9MCdnvanQ3n3JzMma2v8DJasHfINJx8nY9cLuOaTd1/JwDbxD/pRG96x5V+i1wsFIWX5DlpL+eELx1Dnjbjm9gNOpxkfYnLzviODXpfhvUpPWiVo3M11sAYn0YnJAfyV3MoitHDV57xBStxSei9vhraUFi6Ua5LOpgPxystka4t8OVkFse42DkcL9ek61lSIcov6saq5mNbFr5ZqHgCZYTspdSuf+1MIWwAVr+lphMqbJvVPB4kHXR1zjDRbkOeymXB56S1klw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B7YZC+I1FXJfYKGVFImK2trAacYsOnxcKu2CSZSS4NLzhWpwfMBaJDRoUPkNp02QBpjdH/fyjbbmWRrUV37uFTjXEhLhWD2zntkjWqB0msTFb9Tb5aLhOqYCfpSUe2XgzUBiJ2PU8xVqe7U6m6OSUK69pfk7CnLMk+LWot6CAzHShMim07Z32IjnjSIDGDQpdJhsUY/xlmjYIJEZtQXb+mFI+uLJRXVJp00+HF7FGbEOJX28MQRqDIvdfDblsFHO5qqJ2Wh6J2pQgl4cwXvpYQzBds/B9eA/86YFCHfUOlmUlHLphYwfa11zx+O8Ouq3wacICF6l61qVNM/Kl+c8QjeZc1SwCqbpQ0qI47j09ZBmfnP84/EnvLjbSFICTYAxJQYUzq/MVXXJCk74QmsbwF/l7mTVJceSXZteVLliBlWpWZt6lVTtPdH1VHHqtyUW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:55:37.2529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb587cdd-43af-4fed-c20f-08dee92f09f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
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

amdgpu_dpm_get_pp_table() returns a pointer to a driver-owned power table
after dropping adev->pm.mutex. The sysfs path then copies from that pointer.
A concurrent pp_table write can replace and free the allocation during the
copy, causing a use-after-free.

Change the DPM interface to copy into caller-provided storage while the mutex
is held. Keep the size-only query for attribute discovery without exposing
the driver-owned pointer.

Fixes: 1684d3ba4885 ("drm/amd/amdgpu: change pptable output format from ASCII to binary")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 14 +++++++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 13 +++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  3 ++-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c09c60ad3f38..df863a451f26 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1183,12 +1183,14 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
+int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
+			    size_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	char *pptable = NULL;
 	int ret = 0;
 
-	if (!table)
+	if ((!table && size) || (table && !size))
 		return -EINVAL;
 
 	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
@@ -1196,7 +1198,13 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
-				     table);
+				     &pptable);
+	if (ret > 0 && !pptable) {
+		ret = -EINVAL;
+	} else if (ret > 0 && table) {
+		ret = min_t(size_t, ret, size);
+		memcpy(table, pptable, ret);
+	}
 	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f5a5d72b4108..d473976ddae5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -595,25 +595,19 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	char *table = NULL;
 	int size, ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
 	if (ret)
 		return ret;
 
-	size = amdgpu_dpm_get_pp_table(adev, &table);
+	size = amdgpu_dpm_get_pp_table(adev, buf, PAGE_SIZE - 1);
 
 	amdgpu_pm_put_access(adev);
 
 	if (size <= 0)
 		return size;
 
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
-
-	memcpy(buf, table, size);
-
 	return size;
 }
 
@@ -2733,10 +2727,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_table)) {
 		int ret;
-		char *tmp = NULL;
 
-		ret = amdgpu_dpm_get_pp_table(adev, &tmp);
-		if (ret == -EOPNOTSUPP || !tmp)
+		ret = amdgpu_dpm_get_pp_table(adev, NULL, 0);
+		if (ret <= 0)
 			*states = ATTR_STATE_UNSUPPORTED;
 		else
 			*states = ATTR_STATE_SUPPORTED;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index c7ea29385682..a1d1c9f5b1d4 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -487,7 +487,8 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 			      enum amd_pp_task task_id,
 			      enum amd_pm_state_type *user_state);
-int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table);
+int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
+			    size_t size);
 int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
 				      uint32_t type,
 				      long *input,
-- 
2.47.3

