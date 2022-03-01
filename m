Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021E6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 18:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876A510E5E9;
	Tue,  1 Mar 2022 18:08:22 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB5510E5E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 18:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeOOO/Ukt070dnd6laikIHbP5W0ZtyhoqYqnA9rqwo067lCwuZqhJrXYEvMNOu1nNavsYUw/jppGN+P9gFTyGiWDW0yXKFY377PDOpEGZ7XL0QmXeclrd1czm/AupL3l2AKP0qyU+FZWcNmhbmC6FD2Zw5DDDmljPbDgRcytwknrFsVDBvDPnqOdOlStlZ0fUIcqf2NYqygdjuDVb1qNti4joTy+l2h5NI6KgcWEBA0rkDEnxD7a1cvoDnpH/o+ihQ0GMdIniNI+HADSGSlzlnM1qmV47if5rzP80QMlNiKA7vWXH/QDqAS/eC9hyFUPjUfpQuOg3hzKLQ5BgStV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvqmSLDPL3UJvVlg2EmH6divy1f9pLvGxVOuHUxzo7I=;
 b=lTvE7lBm5/uH6isEuRFmDApdO/meMcYJ9lFBLQPass9aL4r12U6CHAIFyIMDgzwlOOuN6kFEAjU+xS7k/fBe3TPOcUVtiAAw5y8XZpmuEtCABJJ8o3zX1j7CF2dWzkIRB2j6/kb18vIvym1TBQLGmjS4dbCrALOxr3Z17IQOdLK+OXOV6gu8BxeFpmZsycPTDhJANEvuabGP4HCoLvtv5aigQIiuBpBjoTpFoK3tX3YYYnBGzWqYapubOLjkKNHZtsATjtOcF36NW0xYJoT9/3pRtJO47mkkN5gTXwCsadX2HFasqxl1PExeCMqT+RhBQZFf4sQW88X67NSXyJ669A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvqmSLDPL3UJvVlg2EmH6divy1f9pLvGxVOuHUxzo7I=;
 b=PWbd+PYALRK/2iel/LzwtiyOc8GQQPWMJlAcvkE0bzJCp7hlkA++094FM0AS6pgVhLhieZDVpgFI4KTL6pQWIirmPd4swNSF4ysKAHqFl1U6Ru2v/wB2u0E4m4mji1hHruKkR0qkNQXmIaWTORupg467z7Z8nXZoGIThA8qfmy0=
Received: from DM6PR06CA0028.namprd06.prod.outlook.com (2603:10b6:5:120::41)
 by DM6PR12MB3354.namprd12.prod.outlook.com (2603:10b6:5:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 18:08:18 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::5c) by DM6PR06CA0028.outlook.office365.com
 (2603:10b6:5:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Tue, 1 Mar 2022 18:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 1 Mar 2022 18:08:18 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 1 Mar 2022 12:08:17 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Fix sigsev when accessing MMIO on hot unplug.
Date: Tue, 1 Mar 2022 13:07:59 -0500
Message-ID: <20220301180800.1781042-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cd6f453-1de4-41f4-3511-08d9fbae76b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3354:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3354342FC5556E8ED32D5B1CEA029@DM6PR12MB3354.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lo8aUAmQgj+23Wq3kczzwwtxhKUvo7e5THl9gYPlBv/QDu09Qr28BAGdyPOZpyRcFxIEX5v/ISfgUwqmjtUdW6vVKhR0HmeRsHFv/M3Y8rbh5jUc9SjET+5ud/tV8RCFZA1alJxYlgc8YiJtpDj+pISjimqyDM2rCgyTYXK945KjlqJvMqd03HIv3T19b4irxMMMZ9izEBbZIpEwKWWRzxyVf78mUzskhVuymIxkCGgXrOoTnFLSSV0pa8mmzw5Tqxu84Dk/z+IwkAWVchWJJvkQLpINwoizZhEgHjbEqAZ4hgtAVJy+s9lsWhi5a39LKKwxTGdbQ688JmJaVqtYfhumxZ+lgBvHS2zNYeV+KPUlOS1t8OgUtX94G+zzRfC/fAMDL1sozuejSs5WTgazBwCMfc4uBMtokDtlT/Ck1FyHL2FWs4BCGLAvo8totyHtC+pfjNTsoU+RES/58Q4zM+ittl+B1MyLw1GmB0R+9aVTMJTai7D9jvKCHr9m9eicg3WpyukD7ztCxYZFJFfjPqSwJwA2n3PAHh54UvDPZBvrHo8zNoddl8oPBSJ/ng5vrnTJSH5zG9uPAmB4iCQIemKtwXclrn3xIGABw//iZAtS1lAF7T8h1DRpuvzgyF0t5XnZ4BcykTdZjKvcOzDSKYiqcdBhKP0qW5FTPxsCtBSj3uPdV9Js69t3B1cLiFkHhaYchO2Yk8qynj1tqZNq1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(81166007)(4326008)(6666004)(82310400004)(70206006)(70586007)(8676002)(5660300002)(36756003)(6916009)(508600001)(356005)(40460700003)(86362001)(8936002)(47076005)(44832011)(54906003)(83380400001)(1076003)(2616005)(316002)(336012)(26005)(16526019)(186003)(426003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 18:08:18.2682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd6f453-1de4-41f4-3511-08d9fbae76b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3354
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Protect with drm_dev_enter/exit

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index f522b52725e4..4294f17cedcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -23,6 +23,7 @@
  */
 
 #include <drm/drm_auth.h>
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_sched.h"
 #include "amdgpu_ras.h"
@@ -339,7 +340,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
 	struct amdgpu_device *adev = ctx->adev;
-	unsigned i, j;
+	unsigned i, j, idx;
 
 	if (!adev)
 		return;
@@ -350,7 +351,12 @@ static void amdgpu_ctx_fini(struct kref *ref)
 			ctx->entities[i][j] = NULL;
 		}
 	}
-	amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
+
+	if (drm_dev_enter(&adev->ddev, &idx)) {
+		amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
+		drm_dev_exit(idx);
+	}
+
 	kfree(ctx);
 }
 
-- 
2.25.1

