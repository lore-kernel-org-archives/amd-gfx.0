Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 07:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86F410EA59;
	Tue, 14 Dec 2021 07:13:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D3510EA59
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 07:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVv80kawEwJXHKHHOlCFdD8uRSi5QaP+M6/ya/dcfaBRARWA8GzLHemsLl7J3CS6TDPll+JWP9gtzpJPPPUEbprVoHFZ2ztVarQ1qQMKRlixsijmmOzNvyThk6hmU7O4drZFvqeUlantTU1Z+6f+KW5IbXEZtf3axvuPmU/EH5DmpJnVNNKUj0F9pg+vhz8HpHWhwNfmbrzISacluz/O7pTOLugs3/xIayzRuDqbzo28DshRKjxEBQfyNed4BEZIqfxYCk2piuu4+6hXCgmtix6HQiKvQnveUTyA0vi0ig+7kejhUqFwiLxlT+GGa0uDV6wun4aF8DrK9k6/fBTC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwbbvGy9FgO1fSFJ8zKrRb1Cf4xM/nbdNFmc+RaAN5E=;
 b=D5fuiWZdXLc52wd72MlWTAClKTQCYWny4+ntO+n1tj4GvQ6xNPu9yrX/7SdSOqjldDhoF7J9zpOK25VDfz04PzR5ZhoT885YizU8xiG2vWxDj/Jr3KcNu1ewydGKHzZEb86QulYTDsg3Oj006vAbkc3dcJuHFkhsw/hZno4y43LBKAFtGAL7YAyiPnVUEElbqScsXBPAhjPQ2evb3VJlxfZcMRDO3pJJ6DKHshA0NqQN3UnMc2SF3ge/LDa3N8nyxdo5Cd2ZA69wfuByhmW31ozubfX2zzkPnM2CeJI2Y8JddovUjGc5hxaK5orMaeF/tdfRUkQ63K6INN0/fuCo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwbbvGy9FgO1fSFJ8zKrRb1Cf4xM/nbdNFmc+RaAN5E=;
 b=ueJ0tWmh2x25Y1HlRo68/vLzjTRruNWG9M8p72bNn4AvaMhDFKTyNfByj6+BABByYqRcJ9WjpLwTcTF88JdsuXP5bHHDeJxgJuV64EkUJTS+WnU1U5dssvHMM98/P5d6AFcIrmaCCDoaeI+uk5R9ykFVVY26tM8msk460gkKw5k=
Received: from DM5PR13CA0047.namprd13.prod.outlook.com (2603:10b6:3:7b::33) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Tue, 14 Dec 2021 07:13:17 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::d3) by DM5PR13CA0047.outlook.office365.com
 (2603:10b6:3:7b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7 via Frontend
 Transport; Tue, 14 Dec 2021 07:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 07:13:17 +0000
Received: from lijo-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 01:13:15 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Skip power state allocation
Date: Tue, 14 Dec 2021 15:12:59 +0800
Message-ID: <20211214071259.580602-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a3f88aa-8c45-45ea-3a13-08d9bed133ef
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2504:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2504DDB7A1DC81DFF5F1EF6797759@DM5PR1201MB2504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+jdBEdJbSOpKYwwkKGq1ibmatTR706axMyCwZXh8++EVtOXAYLTkAkZgRXnSiPrU+a5YK/Rfb7XpkEBwFzc70LMkPC5FysgZZZsu1N6ouV1fn6ZI+qtGGbfrAb9qPKi/LOEKzimZwT4pf4xp11XSLZWqzwfpE7pJh8kMvu8bq8repXaakAFjvWPkQ+4kZ6HGdyslWT+/qXlusmiMyYRxmDmAs138FtpOP8s8xTqM1O/1eX7o+NhPcNztKp2fQKK0j9qk+Opj1cPJ2QKcIyrslcQvH4bMFe6YaJ8KtKjUyEcBnhMDiWOPmp0p9r00k9w04T6dz2eyJzzwYCYXlemzaIr4ex5QWoHf9L7TRHVR234PnqOXD+lGCNymJeVUk5M4RuqWearLXBxbCJYhcA3iWYDnyfru4sqrg82/dhWheqONZjG+cs87WvSPxpoeS1oskmpfiQu6lqrV39b20uvksw9jiwxwkQPZSHZdLfUoeDinjZJVwErWD66p8IFG5ajpUd3ZkY3bPLEcy3QEI0XvFGA9wg/Q6c6TJinc9kAnQpH0wEPIX025nGm9tqtaqDqcUz6hJxUN6aoYdfr+6owEYugUxmUecgMO2DK33jL6FIgojuQwknB7AsQS++VrDDQE+SvJMeU1GKtmLSbcl0/mG1p61r6ntOTUzj6TPw+10fkVYZUFFwH4UwkxJG7A8RSiwsA3WgCJ0MrXw4AnarPWlFXPohvetenH/JIJOFdd6O/ClS2t6deVffLbfa1bUOnQCHqrAM3zXumt6GhnICV5jLYet18+PxFxsQ83MlmLLc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(336012)(44832011)(16526019)(36756003)(508600001)(4326008)(47076005)(186003)(70206006)(5660300002)(6666004)(426003)(70586007)(8676002)(26005)(2616005)(83380400001)(7696005)(36860700001)(2906002)(8936002)(81166007)(316002)(82310400004)(1076003)(356005)(54906003)(86362001)(40460700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 07:13:17.7612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3f88aa-8c45-45ea-3a13-08d9bed133ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
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
Cc: Alexander.Deucher@amd.com, Kevin1.Wang@amd.com, Evan.Quan@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Power states are not valid for arcturus and aldebaran, no need to
allocate memory.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 10 ----------
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 05defeee0c87..58bc387fb279 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -295,16 +295,6 @@ static int arcturus_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_11_0_dpm_context);
 
-	smu_dpm->dpm_current_power_state = kzalloc(sizeof(struct smu_power_state),
-				       GFP_KERNEL);
-	if (!smu_dpm->dpm_current_power_state)
-		return -ENOMEM;
-
-	smu_dpm->dpm_request_power_state = kzalloc(sizeof(struct smu_power_state),
-				       GFP_KERNEL);
-	if (!smu_dpm->dpm_request_power_state)
-		return -ENOMEM;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6e781cee8bb6..0907da022197 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -262,16 +262,6 @@ static int aldebaran_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
-	smu_dpm->dpm_current_power_state = kzalloc(sizeof(struct smu_power_state),
-						   GFP_KERNEL);
-	if (!smu_dpm->dpm_current_power_state)
-		return -ENOMEM;
-
-	smu_dpm->dpm_request_power_state = kzalloc(sizeof(struct smu_power_state),
-						   GFP_KERNEL);
-	if (!smu_dpm->dpm_request_power_state)
-		return -ENOMEM;
-
 	return 0;
 }
 
-- 
2.25.1

