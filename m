Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797EAC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 13:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DBB88CFA;
	Tue, 11 Oct 2022 13:42:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404E910E3E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 13:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9axBYbPQbTmf0SxTq/mCuV/X8gpV1DETHoRgoyr8UPBKi9bOidXIIDLRqul01xuAaX7LuiVC+j40MdeyVONtnB52WXLqbYtAKZjMByv1e9WwvYKj9f7htrGwR8K8ZPIpLheJheGlfFgQUR2fLKfNSJ77tN7JVUn6xSfFxtL4s2qIBLZwNRppaUE8cVTII4dJP6K8xwaJW3ziPtYMZeFd6mDqDuYAvGzPWaSJ8Sg/Ma0BTNDYYUO/Ta+bMJ861yxC8XONuC+ugqbj330zugJjENzuI+v+YrcpZhCh3Dr8FhxwIZE8tDsExqOvK2jLsOXoMO22I7+guYmgfTzJhiQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chH/k1pIwXZUgiym4YaSOeCtl4ihM87g/CQauDETwLo=;
 b=WbtxlxG1GIMshS+GboVHtsqyo5qUehnfHlW2JJek/pZOORJxhNqbu5gf1IufYYG+hvR+uqeOZVmaR9e15rpNxK9siryLscX2pB1ukIaVbvA+Pno4qxXrXOu7imy7TG5eP6etggFskW/o5mxBTPJpYdl77LKBdWdYuYo63/2OBnR1aWijj14UEcyC6NRGLPjgUqj3jKuVXmw/zJTSH1nbi9VpnsWQIuUNbFWuW39FnQi1gjBhgcbDVFfjeTz9sPef861exJEJJMuMJuEmL4aK+RvJMNNDXnhkgZbR52XPybdotYibfW+3qEt8D14B3iE7SWUdiVZfmsarODbmrN7U6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chH/k1pIwXZUgiym4YaSOeCtl4ihM87g/CQauDETwLo=;
 b=Yo7Hum8TTawck4JVLlr1MGQpdWpZ8KHTpGNUZTRGdQWGwATEmLP1e6GS6sexkiKCVD0iBm5BqHakXXdMRBlVeaHaT+1to0I7fT/B+4JH0ewaPi2dOAkHsUMOM+w0m6j2grNtRUEFuIdhaGrmN5GDUadMPEaOKjD5zDL9yG7rfSQ=
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.33; Tue, 11 Oct 2022 13:42:02 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::b1) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 13:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 13:42:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 08:42:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: make dcn32_split_stream_for_mpc_or_odm static
Date: Tue, 11 Oct 2022 09:41:48 -0400
Message-ID: <20221011134148.982341-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 407a66be-6998-4368-78a1-08daab8e60d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nl9CYRhDrRT2SJFXDpM9tKygYyrItU6kOwy/W+nUujJk1/Tn0obfG+MxBdZ3JWyJ6BEL9HMVKDlPVUvqu47HEPMJcM5B8zyjaEWzrVBV8qklfANG8QFiz0yjb9gOtgvF9HZFJo4ecjPfIXDOEhl/DMDZaDUOaRjEcLIIT1IypAyDyPeypz2GFI5NDALH0hC2DeMBduyHiq3ITfFUZk3RvQ36h2FEOmhA0pDE7SOA8V7zXB0S0Rgq4Oz8N3j2vM0ohUKrm4pGdRiC8l2Ki0OzjtiOjOt0ENofJRzNksFgPsNNyO43HXRThtyaY3zXfD3czs2E9hWnNrlaNUC8JWSy3MAc8311sjz4ExiQHurdG+ZiDwRPxqxTLowQb7QdGJlib+N5RPLu0quZUGWhl0me2DI/BwBSZpoIzPn0mgnAk3K8GqBWHpqIi+iXUkEyGLIuWZ+lATBBxi8F47SuEoZijFcubxe+lbbGCHFiUiP9EcICm+Or5i9aha9Gvy4eDX9RxBCLZUI04ykGtoRM2bYSUaq8xZjvTDMKK9kaDVmsu84QHf4uhz3TPGBO3aEB/I7ugRh/WhZf856Oh+9A6aLZOhm55GvNGzj2PGpbnNYR02eGreHp4GX1Dcg2U+my75K8mURDrqgy+jgEkf5p0yPEX6lQGlPVHDa21vSJkUds6omjzTx9Zt2K+VU9/f7LhMbfLe5PykmaCjK2I+yKtmanzUmXAZ/0DNOJ0cUwIqzrHn1dCFyOMxnnwZ1tNVfsjNjArQkJ7YGCvko9g3D/vTdz+3bhQqqVrp3hpxp7HXcrnQJVjuT5835qcYXwIoAzddG0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(356005)(16526019)(426003)(70586007)(81166007)(2616005)(47076005)(4744005)(6666004)(1076003)(5660300002)(186003)(83380400001)(336012)(316002)(8936002)(82310400005)(6916009)(41300700001)(40480700001)(2906002)(40460700003)(70206006)(8676002)(7696005)(26005)(4326008)(36756003)(478600001)(54906003)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 13:42:02.2674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407a66be-6998-4368-78a1-08daab8e60d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not used outside of dcn32_fpu.c.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 20dad3813b3c15 ("drm/amd/display: Add a helper to map ODM/MPC/Multi-Plane resources")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 2a3f5a485b2b..819de0f11012 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1372,7 +1372,7 @@ static struct pipe_ctx *dcn32_find_split_pipe(
 	return pipe;
 }
 
-bool dcn32_split_stream_for_mpc_or_odm(
+static bool dcn32_split_stream_for_mpc_or_odm(
 		const struct dc *dc,
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pri_pipe,
-- 
2.37.3

