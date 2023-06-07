Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EACC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 16:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717F810E0A6;
	Wed,  7 Jun 2023 16:31:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192CC10E0A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 16:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4hZbIf7MA3BmhnnWwk5gdRqGVXZvc7JJcZb/nL+cuCLDMNa78m7us4n83P9z/xJ+gxkyjzudml/ath9OmQN2kqJoROr3RyG7ZtBbC98umoyXPdBpaacgN2P5CAw0bDf1sr6q7Sy/23j2pxBV4rjIBM7PDXAoDqjvdKRCS/ry/VJA8z5/zK6fk/KK+m4oWrfezTnjpxCXiKC74jd+DIbzr+JV2c8199jHHDcZ46F/m6Cq7jKjrs0OfVwi1FAhk9yiJrBt9MrVS9/I8zJWJFLrjg3y83qFEe7yhNk2iky/YwXn1FqDL//GYqhwgMGYs36Ykc6Y0ITdqGBtRsEprJIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jm6+QdOxL2gQGXGJMW5x+fHVhUr9kbYMaLvVLwUk38=;
 b=oMoVRF/XUy4/0EsHjIXE18O6E2kMiK5H0b0pLD7MhyqvbEyL+7pN5qHXJc6XDbHMvmTNQqAVtwjCDwp+jTHZVRS6x3cQkIcrUZc0zFNrdSXo2ghN02Hk5AUhu0eIWU2Ndr73LaaH3NrlrouXHjvPH2WuphJ8b3vLLR8JGTlph0frmHlgS6eonmpYE99y6iirpoqW0ycIIxqUadP1qNnB3p6ZKqOMC8IRckBNN/aTN0ujaT0xa2kvI8imyBI2WJ2V33VhTksMEv48q0Qc60KyvxiJx0fpmZDtZv4asi8/bJOTSnOyeeabJ21Q9MSG0GIosCbSekH4/nDnJZDGXB3NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jm6+QdOxL2gQGXGJMW5x+fHVhUr9kbYMaLvVLwUk38=;
 b=465S/17hDRundH8056Hks21bDcBiQI8cilt3TmQDEXx7HnMmW5+CIgkLr2LQOlzdR1ncSn6UfRNx4LByp+zMGSv4BQlVvex7VyAdAl0Fm/Z1O0eAV3rjdyuhWcaPMAN2Y8kaJtymp6vCewKh8/bArVcg5B7iQT+yyx7SZCZ+Mdo=
Received: from SA9PR13CA0019.namprd13.prod.outlook.com (2603:10b6:806:21::24)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 7 Jun
 2023 16:31:49 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::c9) by SA9PR13CA0019.outlook.office365.com
 (2603:10b6:806:21::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 16:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 16:31:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 11:31:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sdma4: set align mask to 255
Date: Wed, 7 Jun 2023 12:31:36 -0400
Message-ID: <20230607163136.958994-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: ede2cd33-e4ea-4338-adab-08db6774b17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xr9hAdqj0t+62tyqIJLBKemPW79vpQsGhcr59bLS9VvDI8/4EzuBdNA9pPE0evzQXLOkGHqvXPW+vQO/8ImHooAN2WG0sjCqXq8+Ykz4AgrTGXap2Ix73w7ZeL9oERJ9j2IVoDxZo7zEXvNLaUb4B1i0ZbXkyv6+iwhY6Ef6NUcKGxNOgCTio/QWRXzn5NOTDJpTaOLQWxuW9JUC6PhYJ9rWZmJBGoUcFNSKXtuo8G57UwuWCT/wk3andZN10EHG+hiYGd796DoK4M+6f+2Pez7WbBPXdqjsIaSoK+NIo6hXx1pbn0poYh6XcRwFixDHMUItDD5lunN9706ZVDtN9ZdclExW39ZzWRjN+BjpyNog2ooZ32jEy2dy0vTovpvbT+uueGMduXhW2dV1sNF5MErLwBSJaSwoCDCTFq+M53VqjP6HfE3XysGVU54fdWopqozuTeiQi6qW/Zcin2lALWhpETUuVxTJNzenU9y6CccJbWW/h5JKugigPd8Icwh/62iL5WgQKNH9PV0TotnPymaBjiJX3NV63/OW4xVUzn5WmD0cmcLfpWBqL6vDZkgqesStVyN1OQVhw3CXH8ockm8Od3Hwdku56tBfaiVNDJFbPfH+KNGHL6uEbjp6Fr8hldRomXst/c8Y1Nf4rMB6DGESRdnM5bOhkIzzKr0hb2aYnZNwGWgch753ME7gVDlPxnT+dY0+eH2YeOotHxlFr5NgLUU1ME+Fuape6Assp3wg5+GgPjqr1B6YeZe1sXFM7vObzmoRw+NZK1liYEo/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(1076003)(26005)(2616005)(47076005)(336012)(8936002)(36860700001)(426003)(16526019)(2906002)(186003)(8676002)(83380400001)(478600001)(40460700003)(316002)(6666004)(82740400003)(356005)(41300700001)(7696005)(40480700001)(81166007)(70586007)(82310400005)(86362001)(70206006)(6916009)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 16:31:49.3972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede2cd33-e4ea-4338-adab-08db6774b17b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The wptr needs to be incremented at at least 64 dword intervals,
use 256 to align with windows.  This should fix potential hangs
with unaligned updates.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 1f83eebfc8a7..cd37f45e01a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2312,7 +2312,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
@@ -2344,7 +2344,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 8eebf9c2bbcd..05bb0691ee0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1823,7 +1823,7 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.get_rptr = sdma_v4_4_2_ring_get_rptr,
@@ -1854,7 +1854,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.get_rptr = sdma_v4_4_2_ring_get_rptr,
-- 
2.40.1

