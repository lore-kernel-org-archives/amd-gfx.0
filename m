Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04882C88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 08:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A06F10E8A2;
	Wed, 16 Sep 2026 08:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="33v4FEmF";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6EC10E8A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 08:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAM814v4MQGTMHhlyUlhD7QEiXW6MN2o4xRqoSM899P+pnQJtP4PSPjDUiasRYy3bZ/wbO5BaB+yDeYRDXnt3irFPac2LQQ1ZvrT+XlpwFvt/NTNgMpNyc3owGpEevgjXGh8lDR9+XarG2A6NsTiN+aDnlsTgnQWXwVXoSeSia3AxyCMR3hVCHh5h9vSV7sd1YFlQrEv++izQXM7enubJGyx0w6dismeDiMeJr37hLguRlWDj3x/SIGGnvk8Y1hxS1RFMGs+eDrQ6qFy0SnqOFU81/ye1XLWFsjO+VHNesyD/oceuagJc9bE+KWneFkFUJkfWDknj1Yo94rELMR6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzVznKSHHAGEug3AhJaib7gu4SgWy8NO0qJIPUs9c5A=;
 b=FoU1lsCI5j0h85Tbv328/WxcnTwN86sOBel2TbWUAeFEipKzYFAsY6+1su64muZp0GZNUoHm6G9ZND8CFQvNGZp933nFlzyKgJ9Td5ZBNTW/jgS9fB4QEKbEa7s8NYKSkW4e/2vs6TqaYHMUdcGEjeFj8bsZZvhRQzCBKWadAuuLT91aBpptcaUOIh9PScT/gHfRa6K2wUDRFbzz6NAj7uJJi/u9+ZypCnBanGicZcKse2+Sr1R5qtZaSNVt1N8fqGu7xgNoBJ5H1jW9ihd1MHviv40dliF1oGUjPFO33F2PmdBwDL9AQrYkC5BbBgYjPcFwRy7xWVWenqpin81mNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzVznKSHHAGEug3AhJaib7gu4SgWy8NO0qJIPUs9c5A=;
 b=33v4FEmFlKW+qQ+QoCSgXFbMrrjS7+RaGg72ObX5lT1YY+juUzvgu918EXbtPspeDcbR4z/llQEMmmGsPSkko9jsqdF3omqBj9bnAj0JPMvOe4jPwTdZj6DqHsmX3J+yKEeDOXSRDLBH3q1KvUMVXSJR4UrIH7WECgIkZ+rhK8A=
Received: from BN9PR03CA0675.namprd03.prod.outlook.com (2603:10b6:408:10e::20)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 08:44:33 +0000
Received: from BN2PEPF0000A800.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::75) by BN9PR03CA0675.outlook.office365.com
 (2603:10b6:408:10e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 08:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A800.mail.protection.outlook.com (10.167.245.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 08:44:32 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 03:44:31 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: fix GEM object leak on ENOMEM in userptr ioctl
Date: Wed, 16 Sep 2026 16:44:18 +0800
Message-ID: <20260916084419.2404075-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A800:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fe81a1-16fc-4ee3-4241-08df13cebae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: FILRwmZWPBbLZj51lCQau4T1GdOZVE3Gel8SibnlDW7S5U2LsRw7lkBHS4xq3fMYvUyLeAEVbyMyYNlgb9oes2X2g0VH4qoKEu9ACY1aw+W6rR+kQrIu5O0P8YxkpHEcd/xOTNTjRY353ov5RBp9ex2MSEJG/CGp/EyC5uc7Wbxj1eNNZRhOr8qtWvXytGIkzPUY6YyRNoPLLWTEpZ8P+wgBxyiBnyEgr36/IFCbV2vXS8/mug3MoUC7EKM1VSyB6Ry7R6Aky0myZiJwiwK2HvoW1B7C8VUUC7gne7fClU2Twr4O/0gkPVApmDzqlqjdS9cu/eCCHveKy/92x00cAmq5qh04IYJ9p415B2xJWnV8iddGR2EkMgT3dS6TOuCfawcY5XMQRSHGBKwqdgkXBXdFElzu0E2Dr9aeHn27AQx3hM+tSphWQ1EVVyU07j/ceYkuuJg4yTc6VosLG3kzz2X0cE0MWaym2zXSeKGbsNYWwpLUmrxq6L0nfu+U/pKnfG7hK4xpiZA1qXdLhqjB1IRUop8qILnHlK/02TJHcIeIPy/yS/I+qgWmv8PXCCGtK56+uVbNmebzuNFnAyxRIyg+AS6ennFXSxEnYEWqeZ+3nL6JtUa1xGv1cBAeO51xDpuC+6mIGYlVz4QqeiUHuLJvjvBGnaJIinij/3AtjC1wgpQnMF+Z0k2v4fV+h9ex6hmTw8d87ONkTg4xV79WJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CxfSU/HJkg4G6Y2ToF90KDFa+sgeVlpMSxkkrFev/rTB2TRr4lyLTPmBGeqe7fMn0KNKOpgO/PVuEtgwpm+3VvNXJYzohelYYhtArPEjju/GDtKw0d1ED62qWfJaa9jYICeQf6PcYhBW/Jq8dKfdpruWItQaUccI3nItejv/Ww7Q2mXZfMyvUKYGlI3dpJ7kPPIvcVrzP+RESdlsI8VOHrS/R/Ob1IrfY/P0qo8hb+pf3RDuz9lFNJ9zaK6IlVD7bGri4/CtwxsG8C7/rgKG26Uz9yHATlNROwBIasOKmHjF0Qn2PkriikNyR/GdBcy4kMcJCgVaN7abUuqff05GvCL3G+mW57JqdJgexX6eWbGGiI7dTKePRjQ2dxZy8i50jqxZ4jqVu64fiaKnIndkJ5fbkggfHd7q5tKeuVckda0IRWZRwEN98WdhaZgsl1ep
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:44:32.9054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fe81a1-16fc-4ee3-4241-08df13cebae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A800.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
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

When amdgpu_hmm_range_alloc() fails amdgpu_gem_userptr_ioctl() returns
-ENOMEM right away and skips the cleanup every other error path goes
through. The GEM object, the bo->parent reference on the VM root and the
MMU notifier registration are all left behind.

Use release_object here, not user_pages_done, range is still NULL at
this point.

Fixes: e095b55155ef ("drm/amdgpu: use user provided hmm_range buffer in amdgpu_ttm_tt_get_user_pages")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0d579517c03c..49080d2d6acb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -576,8 +576,10 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 
 	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
 		range = amdgpu_hmm_range_alloc(NULL);
-		if (unlikely(!range))
-			return -ENOMEM;
+		if (unlikely(!range)) {
+			r = -ENOMEM;
+			goto release_object;
+		}
 		r = amdgpu_ttm_tt_get_user_pages(bo, range);
 		if (r) {
 			amdgpu_hmm_range_free(range);
-- 
2.34.1

