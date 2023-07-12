Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB60EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 18:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF928916D;
	Wed, 12 Jul 2023 18:47:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0278916D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 18:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyN4Or2fUAIvo2ZywUi9XeI2viPGFXVWn6LTF53rX/cJEseROg7Lo/naGjDAmL3lp2d1wwmuSSBe4hfM72DNRswKB3PKKaM6OAdeYBDdhSQ88tglRCJbqYWJYbesSJ5KqUT8u24Zhs+bA/jd5+bEIEHcyn+2n/ttyUMBZ+qWUsmorHLTRSUwQfkD9AnZbDhT73MhnbdVCSRebHPEXfFybmGqSP3+lIfl4ASN6lgJs1qJyHTnJS6hRwUsYGWXNFgtLlm6gtoCjYoZzdWxiOsCzU7WcwlZTkKIy2CC+UiGkCt8X4zTNbADD1T4N/MGvodcKfCNdsJNKEU9ai08YYTTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+J96goJs7tRGcf73D7feJrHhW1C5j3IoppmEXrfUSc=;
 b=Dl1QcyGKGGWbjWKFnUHiOBIK+43BZt7B8E/93sH0ZmTcAnN214R4llFSWeu41yEowjSssYkcfSQ598cdFd9OmUpiDaGauWajhGU6OpSQqfs5rqOJi4Nj4AxinzUrWrqsP2N4yjsjXm5QdPdTwD9xsYj2wddvW0qobPE4oCT+fJjDFLhb3HXCSdmfu6XsK1EnumsmxTD9rgDTRmn/Pbd5Bk5zCLcqCHv6JgrmsIpocawy//jIPMWxDcvX/PNMhA2IAERk7+fevJL/cmDe8aWUPMU0tptgn04Pec6WxzMUCKqil6cyq0WVJDvYV39X9ahQReZJvsnyu2t+u9suHSkkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+J96goJs7tRGcf73D7feJrHhW1C5j3IoppmEXrfUSc=;
 b=aQGwvHbhz907lqDPaYSAea6NTRFUD232B5/qYEySwZNhvFEDuPVSuhhqsyTyAuth9LP6pBOr7ApgG5ysxJfJe2aUmrNwY/u2ZOqut9fH1X49hvSUQPk9wzUb39itv+wrzTndyTT6/o1VhBCJBRgw+HbyHHSpL7TPL+p+ujlgXxw=
Received: from DS7PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:3b5::21)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 18:47:05 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::b) by DS7PR03CA0046.outlook.office365.com
 (2603:10b6:5:3b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 18:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Wed, 12 Jul 2023 18:47:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 13:47:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: enable mcbp by default on gfx9"
Date: Wed, 12 Jul 2023 14:46:46 -0400
Message-ID: <20230712184646.7955-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df4532e-5020-49e4-d57c-08db83086364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysL2t7rsJ4fEpkpEt/jOiegkDyK3rk6yvSuOHaC11OdZKxKYT59JpWdRmPrFMCdnCc4N1X5hVkxVr3vlHjOUMZhYWTNA1fgMj1bchaPXqJ+E4/QB9sbfYJpYXCxTRaBstx3NbN+zEeBWwNBgxwKr+E1iNp1s+/I7S9+YbDdxtKv1wWrwYVnxDgDHuPX2goQqYBKemqWowW0rdbXwRmsE4eC3qZ0u0Uuiggpjsu4td3T1z1BVJiLqOHtocNl4Zy1CO9i6dwhCdgT7TNAlPLBuB4zmRA0WgPZUum4x9j0ZfILGCyuspIzIdtW78m/Q0UMLAN8acwhYNN5jXcnj4VJTNpHPZncdSpgfOkthJ1qgrkdE3RV6aOY0nSLpbO1NJv7JshP59jP4rgL7onrJYy5rDZlXPiNWN6DdLvEwNjnXrqbLW1TcfuhDZWFNV9Ou96zz56UxmvS6uRo6TbScYz7lg1w0rwjY7J/4XJq4m5ZJVBq4YVFtqv/e2yWdnJV32Rkwl69LZe8SNO5GHDILsHaNzk0Z4vdMJvxOENxMfD/GMvRqIAsqHiuAQHqsWrVwZDmAhq+K0DzxhRSfc4OxGJFfrfgNPh82+1abLTQhOVUcqn+cWz30sNrbmaOmruUs1Jk573YxaqSSmKbayKa8FkTGauvn/SZN9y2ZVAMVC+HGcUNZnTTRuo5gRM7AkSwdicbFmiqNKWRaEv08VuMY/JAa9oecU78MVrx0FqAa+0vedDGTGm4rvyu8ifIdPCjdnFJGLS9BsN4BaKbD8vn5wTQfHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(47076005)(7696005)(478600001)(83380400001)(86362001)(4326008)(70586007)(70206006)(54906003)(82740400003)(356005)(26005)(1076003)(16526019)(186003)(336012)(36860700001)(6916009)(81166007)(426003)(2616005)(5660300002)(316002)(8676002)(8936002)(40460700003)(2906002)(41300700001)(36756003)(40480700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 18:47:05.2805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df4532e-5020-49e4-d57c-08db83086364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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
Cc: Alex Deucher <alexander.deucher@amd.com>, candice.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 50a7c8765ca69543ffdbf855de0fd69aea769ccf.

This breaks some SQA tests on gfx9 dGPUs.  Chistian
also reported problems.

Cc: candice.li@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 6 +++---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bbe4ea93db611..3673015a7f93a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3699,11 +3699,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 	if (amdgpu_mcbp == 1)
 		adev->gfx.mcbp = true;
 
-	if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 0, 0)) &&
-	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
-	    adev->gfx.num_gfx_rings)
-		adev->gfx.mcbp = true;
-
 	if (amdgpu_sriov_vf(adev))
 		adev->gfx.mcbp = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 33e370d998a87..f829a80e52924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -180,7 +180,7 @@ uint amdgpu_dc_feature_mask = 2;
 uint amdgpu_dc_debug_mask;
 uint amdgpu_dc_visual_confirm;
 int amdgpu_async_gfx_ring = 1;
-int amdgpu_mcbp = -1;
+int amdgpu_mcbp;
 int amdgpu_discovery = -1;
 int amdgpu_mes;
 int amdgpu_mes_kiq;
@@ -635,10 +635,10 @@ module_param_named(async_gfx_ring, amdgpu_async_gfx_ring, int, 0444);
 
 /**
  * DOC: mcbp (int)
- * It is used to enable mid command buffer preemption. (0 = disabled, 1 = enabled, -1 auto (default))
+ * It is used to enable mid command buffer preemption. (0 = disabled (default), 1 = enabled)
  */
 MODULE_PARM_DESC(mcbp,
-	"Enable Mid-command buffer preemption (0 = disabled, 1 = enabled), -1 = auto (default)");
+	"Enable Mid-command buffer preemption (0 = disabled (default), 1 = enabled)");
 module_param_named(mcbp, amdgpu_mcbp, int, 0444);
 
 /**
-- 
2.41.0

