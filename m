Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A4C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 02:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5531B10E112;
	Tue, 31 Oct 2023 02:56:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D9910E112
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 02:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY2Uvzu4QgKtU3JLaCpHWWYqld+ZxBhGfvO+dN/21pOVVekv+CepDsVRfomJLDZPhE3+/biuxPW8I/mx89NMJv1Mdq0F4qAKRyHlTp26jDapU5TgfIraO412tnBB3kLpjGnQJ8wyrMQAEc6YacwJfYwHru1DC6DzU0+ykGkSU/Sv0O2Z+WlvbtS0/d/5CSA9N1zLzbUGqh9JMiL94POmJT4CrwlPHwH3GcmmfRQMLGK5RqVxFwOs3iWDOrYrVM76cverP6n5q/tDg0vRsqj6B2i+QrDbQv7UDiJJLqyNTtuRpdcwxlfxl0zEfx4qCTPJRZ5GR/672gBgJwiAAx7bsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG30ncomTFoYBryRyWu0NGefyZo0bzqAdDyhsH8RGDg=;
 b=THkY55VJO4LPJBJy+hS2wmH7PknGe0FqLlcqfXBlxtxHWQyoWMF+zXE9ZZnyQ81W2rbyh6I3cvUZZQDH7FKMmyZs0SyHrK0TTJm2QhGZOSyE3kBMyXR9uiYmES1zNGtP6Wp+yG+hcvWpeIvWJCMvLLZ5hyD642XYeP1gj6MS0jAcmd0+vf2M65w6EJZNZv5OQ+P03L5npv3BSiV0JfSRrThXqyMocU5CfqtOtU+puzyAAXQIcUVtNfRkA/Nqr/yZ+6lMOfwrEB2+hBGbAfGP+lU63RztrgNWHSIwFPgn1USEIreZnjQ8nRLD0lB3djM+lIc6aB76751IwMubuLnN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG30ncomTFoYBryRyWu0NGefyZo0bzqAdDyhsH8RGDg=;
 b=o5PvPDI+n22n7tT7LWmKPfAyNSNE913wAhAWYWHYQtIrv1927L78j0jKWodjaEzbDzHOSU//kL3w6UQUkl9O5Ayw3RRt9EFFoq8PuvY8q+042XBuIZma6MI7uziZ/Ghj554/M2zLUXzBLOs6542ibZy2FksdDSKh7M0LXMlRezg=
Received: from CH0PR03CA0429.namprd03.prod.outlook.com (2603:10b6:610:10e::13)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 02:55:58 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::45) by CH0PR03CA0429.outlook.office365.com
 (2603:10b6:610:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 02:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Tue, 31 Oct 2023 02:55:57 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 21:55:56 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] /drm/amdgpu: correct chunk_ptr to a pointer to chunk.
Date: Tue, 31 Oct 2023 10:55:46 +0800
Message-ID: <20231031025546.574051-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 859c8592-48e6-4e58-8fd9-08dbd9bce81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ly/qTXRDc5Up7IUCe7MpIdlZu/+LUfyEqzdgeDC53JrZXtKWSswxzV2g/pc8IboshMwdIZOkxnN388o/LwqAR63xMj/ymc9GzZZjD5LspfLtNtBgR1dnWfX5nKj+Vwd+9bnAFQv1YjIpus+mt78Gs5wlzYNtVYssmZKTBmKDP92PC7nDX4hLfhNglPV/CnEa3YhhbvhIEre2ZtLH650JTOckf+HykIusL2j4DOsID9qMe2BeTRQagMM1bA6ZhMOL4444Oyu5jX3G4r4jLV8zZlNQPCx9cpvc66zQWWFgGmPHn47bPeMhoqW3l7LuUOwJeJhW62gWtkwycr9WxRMMm4OdEi3bka56fDrE5WGMNOxqyPcdySIlqGWOHXriecNDdHwppYgLfOQp9OlGXb338nHDH+NjRuF4urq4+Af4I/l8EUuFjF3FhJ1SapZs0SaLdvHpqOVZ0yHDVJOIWp57iKK/LOB+zb3vd5XoGbhNUy1nUwSEH1bbJiw6s5VdzTisisaO5L2C8FcmEL0xXZbIDKM6MWs19PPdMofH65WCXKncQLOxk+xZVgK50KHnLexqnSe0D706atylrFxWpf0ZYnL3ATkW/Am7MKYwbFyHB2PRgENaIXp0oi4x7C3VkJaJK6oF4WA9A9ka09gZSkf2KYG4GCBHRGoD/4KODe8J9z7grq7v0+vbvTM7q3zExhgttBrCohEdnfE4MA9vKLtUdR/OdQOj3qu766VNCDAe6di35n7XNYlKGP9Y51UQ7pWVOWCNNuLrePhOFkFGaV4pig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(86362001)(82740400003)(36756003)(40480700001)(2906002)(41300700001)(478600001)(4744005)(8676002)(8936002)(4326008)(7696005)(6666004)(83380400001)(26005)(2616005)(47076005)(1076003)(16526019)(40460700003)(5660300002)(6916009)(316002)(70206006)(426003)(70586007)(336012)(356005)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 02:55:57.3671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859c8592-48e6-4e58-8fd9-08dbd9bce81e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: YuanShang.Mao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The variable "chunk_ptr" should be a pointer pointing
to a struct drm_amdgpu_cs_chunk instead of to a pointer
of that.
Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 74769afaa33d..551b9466a441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -208,7 +208,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
-- 
2.25.1

