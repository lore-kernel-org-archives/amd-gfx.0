Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A96BC3527C
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 09:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BC710E2BB;
	Mon, 28 Feb 2022 09:57:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5806210E2BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 09:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsDKnua/8xaqgvif1sOoRHo3e/HhUC9QNzwVIo+epM8sakwYhh1B/57hckRee+rhs76gcUfoDx453/flmlMTeL+Nc73/yoTdcEsnulahxkurutJ2BM5fhoI+gfWe0em/Ap87OqKsY1cX/H6jmtspq0TYhpA1/e31SQyA47FoNKoA4jvD1BwsK088g0Wgkv3ol9lfCEiXsHnE9MWU6phcvNLTm1dqhgGV13lYoVM4gq5/y3PS6Px7O7HCpVVmacxXO+L03kpquGEtpfvfc36Yy2jX2CmTeTfKLsCMTI+zPyL4fuOpGFZDGCHCEFlYmIJLHnD9DK3a9cn3Mnz/r0srZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrOQpLA5Ci3seu1VfEkQFoAPqmRio1e4NMCZVpW5B+U=;
 b=jk/V3DMMluCg3XdDflQzNIViqiTgRKfc3gHrJKAW/IWCN7moyKELVUa0R7Yp5HebjBdfxCLubezZ4hCYXtjJENaHkDD1WoTDXBmH4PNzkz4kAiKszTq3P6cb5Vmiuihc++avaNUgo0yiCA5/Bp82xEIBWSmy4G/EKc4YcUMnFap7FATnAYX8JjM0G2FrAkMXY8NRJ3I9JK4QcCoMIgcJ/9sY1qJX8JIrrWnHbwEDTZqB7oEMOIFMENbIfukeRac88N5vMld6pzUdR0kh+9xdD9uQlEYQuv80iFm9Hemxg5TG4FxTu03E0QCwCyUdFZdH27FH8AEaftRNg4gEwz7v7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrOQpLA5Ci3seu1VfEkQFoAPqmRio1e4NMCZVpW5B+U=;
 b=x3iR0DK5/7MOD/aZoGopBOnoaQe9KSiiTiQC6IqrVtQu1HzqWkPSG5tat8/n3Q98j2085VARGxP3EtUr5DpEjATVGNANq3l9ZcG8CWj1+4Wox1dPAYk0xJq7F87mZNYxP73CMHmgpG613erzG7u0iox3GKZV2BoHlUV2jJVYvD4=
Received: from CO1PR15CA0098.namprd15.prod.outlook.com (2603:10b6:101:21::18)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 09:57:43 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::38) by CO1PR15CA0098.outlook.office365.com
 (2603:10b6:101:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Mon, 28 Feb 2022 09:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 09:57:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 03:57:39 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
Date: Mon, 28 Feb 2022 15:27:23 +0530
Message-ID: <20220228095723.721786-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42ee3126-8f15-48df-02e5-08d9faa0c32e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4297CEB46E2A9DF99DCA85DE97019@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyMs0eKQ0kGmvW6zBW6rgDdJq4ITFqdbT7xMdVqP4VHFnCvSaIRhy5dDONvFE/swU+zccOlbj1zJDu8lRmMn4USuiiUwMO8pUvq2aXBJ2lSoXvUE7Fvh91wv8ewpkllbTg+ih2ZJvbyy/ir/0rQ64RhXSv50R2Ked5n49sgZmMkfqImZQqDO9Wr6Hcv+uaEAjKgiSjvb8bICsx7UAShOZibZJBWQRyeT1JTzWj21nhEiWuUTNfFMbcrxRLSUo2eETnUYLW8yN/EKiGUd8HgtyIDbXKUVhlplbAOhBRAaesmQ163oATP22GMC+k/HkkJdKLBlLCI2Hr8bpARvF6C6xsF61PqqB/I2mPYAoix7wb6rybIaYBuIlW5tWNogDdDhpd8Jru3WB2htPs0GvPgCj/Zzrg5D0kVyHGzYjE0EZdT8DE+Z6WUCDnp4grX7vxDeg7tMwYu7i/fLFH/J1YMIz3bl26N13qzpnKDJAoTliCvfCCUXMaQBOt3zdI9Bjlez+1LzmG+8+FFnFpFVvV4f2CInqhqckztco09Caq0RoLtLuL+tbJG0QyzoRY6uL8spORX9qUAMjIfWX9AAXNt7zm2RnXEe31punIKbGbB4SKLyvQpDyuzz1m2Zuvh9JPEuDt+r4zfJvyqS8ak/Fk0C+ULST+LaY2qy1wwmyojM1uV1sUXNnY2HMWK6irm7cT+WKOPjY/7o18ZracuJTk0ZDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(6666004)(70206006)(316002)(508600001)(82310400004)(6916009)(54906003)(70586007)(40460700003)(86362001)(8676002)(7696005)(4326008)(83380400001)(426003)(336012)(47076005)(8936002)(44832011)(2906002)(36860700001)(2616005)(81166007)(16526019)(26005)(186003)(356005)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 09:57:42.4044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ee3126-8f15-48df-02e5-08d9faa0c32e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP version and refactor reset logic to apply to a list of devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c    | 66 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  8 +--
 2 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index a545df4efce1..c6cc493a5486 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -31,6 +31,17 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_xgmi.h"
 
+static bool aldebaran_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+
+	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2) &&
+	     adev->gmc.xgmi.connected_to_cpu))
+		return true;
+
+	return false;
+}
+
 static struct amdgpu_reset_handler *
 aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 			    struct amdgpu_reset_context *reset_context)
@@ -48,7 +59,7 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 		}
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (aldebaran_is_mode2_default(reset_ctl)) {
 		list_for_each_entry(handler, &reset_ctl->reset_handlers,
 				     handler_list) {
 			if (handler->reset_method == AMD_RESET_METHOD_MODE2) {
@@ -136,18 +147,31 @@ static int
 aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 			      struct amdgpu_reset_context *reset_context)
 {
-	struct amdgpu_device *tmp_adev = NULL;
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	struct amdgpu_device *tmp_adev = NULL;
+	struct list_head reset_device_list;
 	int r = 0;
 
 	dev_dbg(adev->dev, "aldebaran perform hw reset\n");
-	if (reset_context->hive == NULL) {
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2) &&
+	    reset_context->hive == NULL) {
 		/* Wrong context, return error */
 		return -EINVAL;
 	}
 
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	INIT_LIST_HEAD(&reset_device_list);
+	if (reset_context->hive) {
+		list_for_each_entry (tmp_adev,
+				     &reset_context->hive->device_list,
+				     gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list,
+				      &reset_device_list);
+	} else {
+		list_add_tail(&reset_context->reset_req_dev->reset_list,
+			      &reset_device_list);
+	}
+
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		mutex_lock(&tmp_adev->reset_cntl->reset_lock);
 		tmp_adev->reset_cntl->active_reset = AMD_RESET_METHOD_MODE2;
 	}
@@ -155,8 +179,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 	 * Mode2 reset doesn't need any sync between nodes in XGMI hive, instead launch
 	 * them together so that they can be completed asynchronously on multiple nodes
 	 */
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
 		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 			if (!queue_work(system_unbound_wq,
@@ -174,9 +197,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 
 	/* For XGMI wait for all resets to complete before proceed */
 	if (!r) {
-		list_for_each_entry(tmp_adev,
-				     &reset_context->hive->device_list,
-				     gmc.xgmi.head) {
+		list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 				flush_work(&tmp_adev->reset_cntl->reset_work);
 				r = tmp_adev->asic_reset_res;
@@ -186,8 +207,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 		}
 	}
 
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
 		tmp_adev->reset_cntl->active_reset = AMD_RESET_METHOD_NONE;
 	}
@@ -319,16 +339,30 @@ static int
 aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 				  struct amdgpu_reset_context *reset_context)
 {
-	int r;
 	struct amdgpu_device *tmp_adev = NULL;
+	struct list_head reset_device_list;
+	int r;
 
-	if (reset_context->hive == NULL) {
+	if (reset_context->reset_req_dev->ip_versions[MP1_HWIP][0] ==
+		    IP_VERSION(13, 0, 2) &&
+	    reset_context->hive == NULL) {
 		/* Wrong context, return error */
 		return -EINVAL;
 	}
 
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	INIT_LIST_HEAD(&reset_device_list);
+	if (reset_context->hive) {
+		list_for_each_entry (tmp_adev,
+				     &reset_context->hive->device_list,
+				     gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list,
+				      &reset_device_list);
+	} else {
+		list_add_tail(&reset_context->reset_req_dev->reset_list,
+			      &reset_device_list);
+	}
+
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		dev_info(tmp_adev->dev,
 			 "GPU reset succeeded, trying to resume\n");
 		r = aldebaran_mode2_restore_ip(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 02afd4115675..e9b9ce80f7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -36,8 +36,8 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 2):
 		ret = aldebaran_reset_init(adev);
 		break;
 	default:
@@ -51,8 +51,8 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 2):
 		ret = aldebaran_reset_fini(adev);
 		break;
 	default:
-- 
2.25.1

