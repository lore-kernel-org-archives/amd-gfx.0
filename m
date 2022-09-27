Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C7DC07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 02:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5271610E013;
	Tue, 27 Sep 2022 02:30:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C1A810E0A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 02:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TM8uoY4LuMxWbxd3fPleZh4rRZ1mknVNFkBnXNTirmUdtzux59dR+IrupeAFGxA7GK2qE204maLR6qyz1UgsOXGaoFetzqz0CWnbYtOHxLNvwW/5RTE+L5HaISL7mNKF5urxKFu3ZFrk5tHzKaFxWXM+kT+gLPYmceRvf6tt39tPOVbBCYKiVRTHl/NG0ld0Z+HpHGpi9vvIiesxLWL98X9dttURce9XKqAfOio80w6j1GMwJv99bJDLQxpSDExZO3wFiHV2q/U86VLi9JnZ6RwubAcYtmUnotVhSWaaggihs1ImLjEQ0LY3EH0Glgt05ZtkITgq4oJdAyVpxMeiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ihga96UMoC9WYxLKbFrgHl5PghkFXE1K92x3ZVNYgzA=;
 b=Dk7c0mWA1qdcgChrXIj0fwHBhTnczNMPvGTfOplG0aSVirstnbEvL6UoPBUflZF/prY5zRYDaWhaWwfIGtU867KS9HoM/d/0JG9Y27/Gh9zcZNkzJTAPVv2smBuleBoBEfdcr+4IC+QcX+4eHbpTvzG2SFSNqvAvbuApnWIHpTsBlwuNFpE8X+TKL/vR/f5yc7D1S321pL6FB1g4MwhrEyhjlx9Amp+3UWCwG8Coil9J7fLxUhAbT5Lg8zgagQI07/irm+L6qjCCqi5hlFfOYMWolUtEApPu8akQWFmblZwtPUp72ob+NzTgHVcggyi4QTNeD7b8XDpGBuww8pGKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ihga96UMoC9WYxLKbFrgHl5PghkFXE1K92x3ZVNYgzA=;
 b=fj+ldIYIVoQeR/IaO175T1x5GQXcVOJH21uk10D6/OUD5YSNkZKHKwdKQ6hi4CrZ/zC+SGU+KX7wxevupZYEHrTpS17dgjm53gt+8egzQ+tkPNYFaxSyvhq1zr3d0qH/mvAW0yEwJ9ImlGcQ16qqNFwqtvNdVldrd6RvSmtSXtQ=
Received: from DM5PR08CA0055.namprd08.prod.outlook.com (2603:10b6:4:60::44) by
 MN2PR12MB4582.namprd12.prod.outlook.com (2603:10b6:208:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 02:30:16 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::bf) by DM5PR08CA0055.outlook.office365.com
 (2603:10b6:4:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 02:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 02:30:15 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 26 Sep 2022 21:30:13 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: make rlc fw loading backward compatible with fw
Date: Tue, 27 Sep 2022 10:29:59 +0800
Message-ID: <20220927022959.12999-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|MN2PR12MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 3138a5cb-4931-4b18-35d6-08daa030367b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hU7Hi4olyyt8LUxZm4BqQTzoEJGMM2HbwxzyZYm70ItbHBhD+7KgssqN3jSbYFabX/yAT5IKnLUS5IVBWhEh/H4XiLHAxUXtgJpcyGvP1ZSswumM19TMx8Xdb8F32s1ZPcEXbuwLgpgeKyllkvyao2XU7Uj672XLkLk1fZASU2sXJI5jucWMEEPvAdPjjvp7zLTkT9wGvJbN81rPl6mDqzQXbh5VXGMo4xQo3X6bOw2IolZoyfaNjLKrRti1UMl1rOL7oT3WWx4z5z31BomWTaWICWdhNcKnHkTPKj4noTUvL6VO6mPMqOCrwxFfT31kXlR4O9kKXNzhhAQ5a6ec/rbKHm5ewv2RffyiftwZ0lFBgg7TgNZBBqlKbeVpig0vOtPbrWSte33ivUZOuN0DaM53Opk0FBAgMHj4RbP6blg8VsrLu7VWvIqFs5WZ2UAA65aU1+mmejRSRuQjAIeDBjBTsqpdjmSAi83fOuT670rLeT8XZvXeLm2tY4bfrvqhrbQO4tmAxqbYL4djyfk8Em4+QhVy/5TsuJG6lXJP32znVxGiOVpxGGflQaTB+iVMdSJCoUCUJ9IHyLiHVK0Ew4Ttu+F4jqnSgB4JCbzFvyWcxcx6uQseJvGj5CWlSC+iG3/Qf9Um80Ui9mK0/eazAciQWMQZezu1CJqhubUa31eF2GQe1stRBjj+KHQq7sfalU6FuIpufm8u97bTR5FkfLPJZ/qicn6vAQVKdqWLaWeX7Uc+ddNZTiuxS3jCw9+GIoUNCD2sJWvAZ71ef4K8BQsMm+SlyThXOvlJgm33I64lj6uHdXt3s4TIawCrcW25
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(6636002)(86362001)(1076003)(356005)(81166007)(5660300002)(36860700001)(82740400003)(47076005)(2616005)(110136005)(186003)(426003)(336012)(83380400001)(16526019)(6666004)(26005)(41300700001)(478600001)(4326008)(70206006)(70586007)(316002)(8676002)(7696005)(8936002)(40480700001)(2906002)(40460700003)(4744005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 02:30:15.8327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3138a5cb-4931-4b18-35d6-08daa030367b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4582
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow kernel change
drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_init_microcode
backward compatible with old rlc firmware

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 792333206362..012b72d00e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -537,9 +537,9 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 		amdgpu_gfx_rlc_init_microcode_v2_1(adev);
 	if (version_minor >= 2)
 		amdgpu_gfx_rlc_init_microcode_v2_2(adev);
-	if (version_minor >= 3)
+	if (version_minor == 3)
 		amdgpu_gfx_rlc_init_microcode_v2_3(adev);
-	if (version_minor >= 4)
+	if (version_minor == 4)
 		amdgpu_gfx_rlc_init_microcode_v2_4(adev);
 
 	return 0;
-- 
2.17.1

