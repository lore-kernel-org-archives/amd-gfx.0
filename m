Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EC1C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 08:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02D410E164;
	Mon, 12 Dec 2022 08:44:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F9510E16E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 08:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu8YF32EJJYjJdcVdcgX6akDjmlFEBM3WAteFQF+BdJEbOgxJWtcQ0YkVKJA4kK/oabSkjnl/WXX4BFkXp+p8l5aJ87awMc0UqAazHlB3Fc+creWKUq/jQu8NM2SK6V3R3zhXpytEDQr9hIqCJILbJ4v+cByS6Coi58ivUj7rcusLY7FEH+QIQ4rb/0U2LhrZdFnWZOtgW3rmqYGU6YLuqVDiW3y5H2tXs8KFi56XStw2zdCeP2nZBqjPmGh5t6TmhovYc9EYk7Cp8drNlIGvo0L5Ai4ZeUpDHLv30YWUzHIACaZo0gBScWuhBm2+Jj6tZerZ7SKwyB5c9YXsg0L9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHAEgo7r3bKHslwNsQeIss3TetEo+zrn3GJCgEYvAL4=;
 b=JZ5lkZX6n9TjbHkObHGeNDudjpfmT/H0Meniu+aKn/9pM3r2TdW4oMh5BeXcoKTdPl6/1Zii+8lL6Jdj1JukLQOhkCdSG3EmlM6HUgI5sB+aytxwjRGkwT3jw3PpcfFHShQ2gfGbEeIZc0OAcbDGWhQyX2qYNO5p0BMiqF6Erc1ZnoBEA4sq4J6rT4zBPckl1UDj16wRUlurI6zTtqvtN5bGq/zJczww7/zkYXiIvTeagXM+kEOQj2zo6Vbda3kfRjLHxbAz0ZYKbxhjEpENoPN7VyFTIiWuEsAwpImvgr9hDrz09RUUFCRzcCTiGQrj1whnCvRnGZv1nVkgzXaycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHAEgo7r3bKHslwNsQeIss3TetEo+zrn3GJCgEYvAL4=;
 b=rhf88/j7/SoSbwpaUmCPUemAdR+DvDOLknjTgQQ+bEVxHO2MpKYsM0cMASzmFpYQF7i3INx+H8w8ogdX0NISW5PL+Qetu2adaOHoxDte4v7ZYAmWftCTUMLmzmFCV8jOH4DuXPsT5eWrIgyYy4maARSI2brzI9IHRve+qONGE08=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 08:44:45 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:5:3ba:cafe::42) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 08:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.8 via Frontend Transport; Mon, 12 Dec 2022 08:44:45 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 02:44:43 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: add missing SMU13.0.0 mm_dpm feature mapping
Date: Mon, 12 Dec 2022 16:44:21 +0800
Message-ID: <20221212084422.3850479-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bb488e-2470-4c35-8d18-08dadc1d1ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldAFywXWlo/sSSgHqRSFsNy4lhUnntgZSreVucMQn322mBP59rANmU7jFs1GuPGqElgUvBVoAJyGH7YP/90HAA8AN6nrxo4qQkJzsztqzbCPKBSFNWKnNHW0Q6gwoZSUmQNJwiQvuOAo0nKjqKZZ+WSeXENUHC4X7n6emPJrdWEYhRMVIMOGqHCJ0gMtTxTTr30g16LkTC2NAEN86QcUSQ+9vq2NhhYVKwRTGQGdsJ3ZgmbNRGBOSesfOkUOuOpbkKTN527wWmhE5NBy+VSo9paRwg8WM3Dco2GkZY+s3ozSl5b+Jbtvaqks+KXzz24v0nbzbPDBvKgvm2uD4wWovx3Xb6/L7/G5jeSryuqJa/es7BcH0pqpXMuh566bRB3ixamotWKXGJxWmXttpxD//8D2Lh77J8ssS5/bPWyjiq+akIC815b6CZd5/JaXHOJ2LNeodWDmvWnd1rwfMYp3NLmASXiAemwuo0O2TNT4sHWzS0ADstzhUKsGIQmKLEvVnv53l3cA1fHb5y4J8Bic8WCKL8dtfIKHJMNcyP2JV2SmwFyGlcZyJFC23ttnG4Wu8id+vU8Vnt9hrTu1RPG28UdWV4sW4ZxIIzn2+6Vf60eFlDRi8hipfEKZcvnsqKqCMgT+zEb5spiw/4M1iZ3q/MLwjwK7J32Uwrh+23uUQmYO4T3PW3/I26cJkMG7mZD2KnU6FYBPg7BTUJzTDOmetBRSzThRO2YdYPyk1eGsjy8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(70586007)(36756003)(70206006)(2616005)(426003)(47076005)(8676002)(4326008)(16526019)(336012)(40480700001)(316002)(5660300002)(6916009)(54906003)(4744005)(1076003)(2906002)(86362001)(44832011)(82740400003)(40460700003)(41300700001)(81166007)(8936002)(356005)(6666004)(478600001)(82310400005)(26005)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 08:44:45.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bb488e-2470-4c35-8d18-08dadc1d1ea0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without this, the pp_dpm_vclk and pp_dpm_dclk outputs are not with
correct data.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ibb0df59a79db72379f245c3a929b33f5f85cf8e4
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 7840b8a9e7cc..822d03581c47 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -211,6 +211,8 @@ static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] =
 	FEA_MAP(MEM_TEMP_READ),
 	FEA_MAP(ATHUB_MMHUB_PG),
 	FEA_MAP(SOC_PCC),
+	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
+	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
-- 
2.34.1

