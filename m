Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B18C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 06:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B44210E4EA;
	Thu, 15 Dec 2022 06:17:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B38510E093
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 06:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0NqwULg1VqUmssbvTJtFUJXwwD1Hbfl4WDMC6rUxc9YpZlUlCSLg9ni3LYGqukKeqsJOKfGtA6q1xqlyFWQBLZNelb7vkNW5Bl/fd0F8veuy4zYHY8sHuMo9nuehH01FfAqbvKxNcfsxo2j3HAIzHZfw+UnDU9xQbPds4LeEjuH0LITTbxVsDjZYXyA3Bak5lzYjc3rFlLGmzJuz1hO/FbRTIVbWxAO9Rtgzd4N4o9tGyXH55MrVIF2ZwILFLTIsffrJfF3h5G3yxfhzh2ziEBT5sSGAnC8U+KLveCB+/szTgFI9zQ1kJFSqjLKlfbIdXPDF4Gwx8t6OD9k73Nv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dttvfpjrDz+QIy+OogIWQAcoMjtfnW3oP49lUgeAvHM=;
 b=k5OWTNJ3/WKB6kIhgPHN5n3UUmjehfL60eClzwYiyi5avu20wHgWkaIKrpOHS9oFYmWpJrNH/u1rNY1luXKsr0BzUmqRuPvebDdxIdac8O287kmDqHgd5e4RxP2E5kJPP47B4JR/4DltTrWup3DfEvN1gR7EhR7eVe5l1GnkMmLeez+UrAeOBcfSGF+kvOgKnuL+jkE04rHZAAkKJo2a6TesWowEon4kiFQ12qf9N9kthFQdBDnUarkWKtXp57/U2aMzB26ru7ry2OPzH+NpU+r/OFgGWUiw2sZKp/bLHUc6Uhcf4iWrSVY+nIVR3jam+rNRDMUg9RVzBRzvR++LnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dttvfpjrDz+QIy+OogIWQAcoMjtfnW3oP49lUgeAvHM=;
 b=4YGIRaxbipsPr1jbkZFtfduKbXW70By7p3d0WZmx/3EsLL9VXhftB8+crIuAk6av6gKkK/E4Tq5aRHOAX2P/I5Yl6AHRxSTrlhdSiu5NBJ8M0xxbaUzFoYmElsiGan0ri+DFYaUgizn43l8J810rXERB7JV9po+BQtzdlFABS4A=
Received: from DS7PR03CA0296.namprd03.prod.outlook.com (2603:10b6:5:3ad::31)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 06:17:21 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::3) by DS7PR03CA0296.outlook.office365.com
 (2603:10b6:5:3ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 06:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 15 Dec 2022 06:17:19 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 00:17:17 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: add support for WINDOW3D profile mode on
 SMU13.0.0
Date: Thu, 15 Dec 2022 14:16:57 +0800
Message-ID: <20221215061658.3894208-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: d567cfac-d59d-432f-5641-08dade640552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYi+XDMZeIFQFQgv1sX29RRDJ+Vx38sbCJ29hRH0VOcxyEKVnzzHPF0onNRXrI0bjVofGk/7jeayF9RqZPi7OV52Bb7h9qT/K3XvhPV/+nPpOjqibOuV1WqhwWODGjq/KQwtI4PSnfiGRRrGir/62WDlXG+RuSkEqTh2mHpNr1aF5o2S9VgvoJselahwmxgpQ0nLGHDw/hcpZDj14EPweJpd4j5C21N5wNtXKUbon5zGksbAGHIR/0ug6dbMADwfOXjd9sW3CN+Mi/nQg4uHHNWiuqyUH2fKhkD3lZNXdCOi2Bl7ni07v4lcdrbmo+08ULa+L4odaDt7d3xFIefxYAyuk5vm0EcdXc981p8Caz29hY6CDzDRmVmHDOR1Mvw44zM2Uuv+dcujky2BAVE2InIZ9CHRU6O6SzvOR1iLY+M3OeNXtxCzJTTyfGbFLSypamhL6gth+pz3mpl69H/ykdcycjqG+VJc7ZOTaRWCEg34uPTygvjFyK/VvVtMgnyQoCwoDp10qM80kwstp0lRDP10T+Pfx5guk5mFcg2xlRDvyORM2JbHe3bIuwM2JwHjSWAi5fKDxmRH7GjAzLWpd8ioMMCJ2l1rWGMLh6TCzd1GL2MFEU3URWotrZEKjwKEFe+IqmVVDqqgIJFGvreAJl8IFkq6ml0OhdVDn0Ys2lw+c5eZj2bnKYhJk27Ts93Bu754wTIlZn5TM1iGPGz8va3JJdgGcyoAP5dfyid6NBWUP1mqPk8usYHTsHriFNWv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(26005)(6666004)(2906002)(1076003)(36756003)(86362001)(47076005)(7696005)(426003)(44832011)(6916009)(70206006)(4326008)(5660300002)(70586007)(8676002)(54906003)(316002)(41300700001)(83380400001)(16526019)(2616005)(36860700001)(356005)(40480700001)(186003)(81166007)(336012)(8936002)(40460700003)(82740400003)(82310400005)(478600001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 06:17:19.2474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d567cfac-d59d-432f-5641-08dade640552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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

Add the support for WINDOW3D profile mode as for other profile modes.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: If05d1c7cbe5b6bc9f9c3c5036c01f6580d534164
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 713fb6ad39f6..09a0b41088ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -240,6 +240,7 @@ static struct cmn2asic_mapping smu_v13_0_0_workload_map[PP_SMC_POWER_PROFILE_COU
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_WINDOW3D,		WORKLOAD_PPLIB_WINDOW_3D_BIT),
 };
 
 static const uint8_t smu_v13_0_0_throttler_map[] = {
@@ -1544,7 +1545,7 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9]);
 
-	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
+	for (i = 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
 		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
@@ -1606,7 +1607,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 
 	smu->power_profile_mode = input[size];
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
 	}
-- 
2.34.1

