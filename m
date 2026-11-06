Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16D606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ewV32mKQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111E210E425;
	Fri,  6 Nov 2026 15:52:49 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB2910E425
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 15:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6MKPYs5XdB1kDx/xCSyZ3xA3rXYY1nHB+2C67e81RZb3WT6woXHmgX8frhU4v2sgYk0OHEsnlrET8rR9THL2PwFafyEq1y8hrnmAFE8YOuEfR79XE0yYbckFALAzmcoX100S8FtCOHQZ/cpBomZRWNQD4Fqz2ADgYqf0KFP9IgL9CkGMv47RdBe0Q5PCocpu+AZsQIvzvPRgQn3kc4heWzwhRcRG6Ry+1K9X2OkCUD8scrAs9r2zNPlQSnvK+OY7HtosXeGgdEnlgahRJYRtqGRhcxgQKzPrQJHDT5O3l60rVJXSq8gLgKb0vfuPUkgyhguspGeZhaLP/8WxazqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I95BtP0JfoSNndBaCcMEV40iBCZG6sEngrsPVM6USjI=;
 b=sqiXq/VVSwgr0Mw/UDUpyW3xBvaBQ/wEqhC0xHJLLqlxKoL4B/+G/KVCSTbtETTfPi2hQZuk/ajOQPOpevzsXbECZCERxKfLVeqgcBZLkqKoOCwFQ2z9qoXohqEUVpPYvK4FgBxu4MHqFONEsU/rvbvdU+0jbVvImiSvlgK8OSIUbb1EXpkMomXALRZmLOAtRQMtf+64SgAnxBHMZWFgwrLzaZfahBaDnFQ9gKUsBaBAiHMg4sS+JcDJi2SWmDszcsIBNsk8GhvMgEm+ONRjo+698fM6YYfQiXfJv/JUvZXKEokroa62Q24SErgtQfZ0XUFk4DFLrYYiS/OwmQas0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I95BtP0JfoSNndBaCcMEV40iBCZG6sEngrsPVM6USjI=;
 b=ewV32mKQOfV8fx2anqGh5Her2o4pDvwYcf8KnLgpNwJMaMIqyNjvLnpqJA+coSnoBNrWQ6F30yy2itySk79AgAMfRgFuaXoePkF06oz5l+VJ8AW7ZtQj/QSKhwbTvIqWJtAojtRGPJhtbiz7bCQi3cNNp/qmVGPJmknyP1qr74w=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 15:52:36 +0000
Received: from MWH0EPF000D894E.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::5e) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 15:52:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894E.mail.protection.outlook.com (10.167.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 15:52:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 09:52:35 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 09:52:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: re-enable SPM updates in the the IB path
Date: Fri, 6 Nov 2026 10:52:18 -0500
Message-ID: <20261106155219.3329315-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894E:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ec842b-6b9d-4c23-626c-08df3c1dfa71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261102123227099003|11063799006|261022075727099003|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: DaKpNhId/dAeje/aYyX0MNt7D6TDeyAwi2U8b+v4jiokVModqAc1wkdeBOW2d8usSHleGLQPyRiyQElhyZM3KNBbICtyQXIeH9BjB4n8b3h1BPMdeo3KG79seRHunoUP9HcrYr6Mw4cx0eZR/VZRhfNmxgeNVn8jdSW/AKKz6H+7TtP2dTIqCP8PKu0/cQKT9yWy8ZUTNUTmA5lQLFN8KRH+h5X2lgD1gUF30RKmvUc/oGcZR24JBTSfYj0Toc615bv6bdwaGLKOriFSMIMce0iBHGVgRHS+aDwAvEVAk2LUH7cdeW4WtPcwof484Dyjr6O/4QUM+ZzbmH81KxoNLIoXtQuiJJuCtSuMXQ5JhQaGy8oh3Iyu+OM81MlQq1pQ7hnohsoof59U+oqgngZ3oy+mTW9KozlX4aORj7kbjfahcBEKbUav4VXK46vcrLJBe0AnuzIFLw9FE1tuV1tdJuvesmLE2g4YSDN48ieemm3PZldSDieqJAE4rcvRKan6+kK3mrH0HKr4VAuW9l+cn/dD3V8g5f+EueM/BsnSApLeXwnssWUIOYw497th7oGdffwoK6flpZW+UCK+IHlk1V0+F+hwzF4cn3s2rVoiSUWA1vrAjogUjcfHwyeg6CRU74JD4IUKpzPrDsiJ5GU8LWAXBeposGybhGMqMYv52ueflIBQU5B5P9vLS85UiGroxFWV9ElCO7DifF8n2NtQfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261102123227099003)(11063799006)(261022075727099003)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zy0NyLchDNJSA+CmLTPEBEoS0aYqzv9J/iDj90K+GSnN+APa19p+5BdVhJX/SRIRfi7Sa7Mul5BPYeFtyQaUY6NET00KvMKzC1OweQ8BiT4zJi3WJPi1xjXwSeCw317MOWB0JfTbGhJcXHjDXEv0xFRo2wwM3hdJmn9OzsB9cr2L+XWfdujgv0hqwGwIal5RgFC14ffXNeF7RkvqlnQ7Lcha2jVAWqNop7FD1U8N7cuhQ71n8sw/BNf+TJlk+kdk+mj+qpb77oHPhr6fdoj6cYPAy+BdiruiE6T6z6liXXV5aQvi71N4U7xRvYBWRWvpmPa+S4rkf0GgnoltUMIJqzRQXoytFS65b+Wq7HuR+7lnMoPR0nthe/N7r/CPQsLicdV1hsDTOrDam9tvcO2R1g5DXSWvCL5Kih+PwLpePFYA95G7r3CP8oD4dd+daT9O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:52:36.2003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ec842b-6b9d-4c23-626c-08df3c1dfa71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RLC SPM register is not properly saved and restored for GFXOFF
so reemit it in the IB path.

Fixes: 2fb5a4572c76 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f98a7c6797b3c..6210edf1937aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -121,6 +121,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool emit_spm_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
+		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		 ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
@@ -209,6 +212,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
+	if (emit_spm_needed)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
+						     adev->vm_manager.spm_vmid);
+
 	if (emit_gds_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 					    job->gds_size, job->gws_base,
-- 
2.56.0

