Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6226C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 08:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6531C112D2C;
	Fri,  8 Jul 2022 08:54:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D622112D18
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 08:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsL/Pen2495srhha89kPIW7gCXdTPpG3xesr/s7oBLQ0v9yBaovlI4/nrHm2m3wXaP3utISeIciW1JQub9IMMRdFTdFuXvDxqC11UmQcVksak/yPInumdIyWmWpF+HZQ0wnIH1iWo/n/ZQT5c/c31W7tO/6DOIAAT30oBDdoRzkBrXUSPRaSf4kSlzTe3tEzlYJKBpzSB/yGqzcOrkkh1rE97u5cjmPHuhQxUXb7xBGt2qQuUBGh1H5bmzTHftVGnriF0CiMlHj0V2r+gt9qsio/9aQRVh2oCf82Ttz8mWT5JroW3Obo63jGSEPfdjlsIwJ0KMgvtTyRVnfOLQvXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5vvxrie3yziq0vpHZ4Ob4KbmmLCtjNK3oND0gw3lPY=;
 b=e6/bXA7Sn8kK4A/2ZRfYSqQBNeAiBQHawHho1k5DIaTOolKaLi1K+TDoojhaKreh+XupKkinOwS4ej8918pxYiXt9adKMcrER0UOE8ppoFchRawDQcI1LWdGwcYgOKCUoZf5Q+1/MayldTPzFdZifMUFNzzRZOrMlP72RyD5WpRpLA3gGzaoN464+3n0Tm5jnxCA31G8GPOCZNVRikn1Z6qwQyXkc667NT4xCWib1myqbUvkaanpdyk4EAh4W4lgQMBqaJCqv0guZSVs4k+vGlLX1ZbkQ7MXicHq4TaE4wamAjNyu+HIoY6lDVLOPaglasmmlxbd51fMLrCTXrUeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5vvxrie3yziq0vpHZ4Ob4KbmmLCtjNK3oND0gw3lPY=;
 b=ybVc8NuEJdrD8kZ1tEe9/DkqVNq3Usc99LfXI+myWgr9BOmCv8hxpHvR4BrnnjYXGKcp+di3B9N7KP3sIpbLMY5QF7jRj92bWVAsouT4SjS5/RFBH1VTB4PRZuvRQGgDZnCDwJbh+bu2dYFB5fek0wLpV90sKO1HOJDILSyM0Q4=
Received: from BN9PR03CA0269.namprd03.prod.outlook.com (2603:10b6:408:ff::34)
 by DM5PR12MB1244.namprd12.prod.outlook.com (2603:10b6:3:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Fri, 8 Jul
 2022 08:54:55 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::5c) by BN9PR03CA0269.outlook.office365.com
 (2603:10b6:408:ff::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Fri, 8 Jul 2022 08:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 08:54:53 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 03:54:51 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/mes: set correct mes ring ready flag
Date: Fri, 8 Jul 2022 16:54:26 +0800
Message-ID: <20220708085426.1857392-3-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708085426.1857392-1-Jack.Xiao@amd.com>
References: <20220708085426.1857392-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dece081-ecf3-40f9-05c5-08da60bf8647
X-MS-TrafficTypeDiagnostic: DM5PR12MB1244:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STOpV4kuywU18rBe/YJ8QQW/+DhzqSe+JyRzF3ZATzdTzsSiyASI9lblPxpC6PZQBXbJmSgP38kO4Bet85nOPZgXCiusTUGsp438kVgJQcOw9TT9eU8/52B2GG4usLPefT7ggvxazY6j2q8BVEqZgX7H7WhXL7deg5Py5o8hbv+ZQcg5AGbK1saNBDExg5ZtQZF499wKr2t6IgKtX/iajL9nOYLmIS4laaBu0GCnf0Vvh858oNQvAnz2pA884xzhVS/XGxP2nyhd1QW2lXE4f1fojuUkKI2aA1cfnAQYcBPiLJ1YGzmr/nehnJzB4sPg0aVimC6ylFaKudmT354h9cQLkKTmATOwG8JlOWtzqOtGjSTq3Jz6njaCzORA35G5tLwRi50D16E3d5CNjgCSokfMnUthA+01brdjgCdTKwiafwTSd/rNc2S8C5txXTXfqcMgZURN051F2goBKSda/pMx+DYC77whx/TX90KK4QOWRlrt+XnyQbcWe3hvN3UDnz8Sr2j5OzVYCTznVheGGRoCknbj5qVNGs9OWPUJNXQRq1zwDuJq+ldNiXfH4TBEeq+28Z3jsRSGw+/+64mBCu/mzG+oTnHbCNrWos1OSx60BcWQs2NDwZueDjmi57J2hK3ORVm1PIeTgQ7XAOAx9jugsqk/K9tamXqWJH+qiggBpzkaHO0qnqHytFPclRoTdwmoJPucXdwGt66vUCCN8Dy94ccpPmqVtK+0SfOGn5Ww04FDI4hoyljePMq4dbVH78Dfp46ZTe0UR9fgrb/e3ZPe2uaD1pl+4bOrdsHQWWVwuQlmpF7QSzX0/wDfqphFZfqaefCOvNJlBnT6C2tDnTZ86MgjQJcDwMteHhvsNELMlyQ2ErjhS1l0lMfKEfOb24zrOCLijZ3Z9pmmFtZORA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(40470700004)(82740400003)(5660300002)(110136005)(34020700004)(6636002)(26005)(6666004)(316002)(81166007)(41300700001)(86362001)(70586007)(8936002)(478600001)(356005)(70206006)(4326008)(8676002)(7696005)(47076005)(426003)(336012)(1076003)(16526019)(36860700001)(186003)(40480700001)(36756003)(40460700003)(2906002)(2616005)(82310400005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:54:53.3543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dece081-ecf3-40f9-05c5-08da60bf8647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set corresponding ready flag for mes ring when enable or disable
mes ring.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 75cf92d38d41..88317e77c0a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1124,6 +1124,7 @@ static int mes_v10_1_hw_init(void *handle)
 	 * with MES enabled.
 	 */
 	adev->gfx.kiq.ring.sched.ready = false;
+	adev->mes.ring.sched.ready = true;
 
 	return 0;
 
@@ -1136,6 +1137,8 @@ static int mes_v10_1_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->mes.ring.sched.ready = false;
+
 	mes_v10_1_enable(adev, false);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b78e09910c7c..8dbce32fd9cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1190,6 +1190,9 @@ static int mes_v11_0_hw_init(void *handle)
 
 static int mes_v11_0_hw_fini(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	adev->mes.ring.sched.ready = false;
 	return 0;
 }
 
-- 
2.35.1

