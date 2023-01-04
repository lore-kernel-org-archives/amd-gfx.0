Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ED3C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 06:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03A410E077;
	Wed,  4 Jan 2023 06:36:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFE210E06C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 06:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duTtGltioo42Mz2EKnZrODcbFGz4YPv8vz4e3si24ijYgefDB/9AqDzsiDPH7v0bwV5wy4n1+Lm9YDU6m2qaoigxQEPWRqbbdFPMNAJrIBILNnSOsH0J5wOwkjJQAUNQULUYzzITL0I1kWr2zxL8sMVgz2vP8U6xmpaNplXxipzh6u7gqF7e5uM4ENcdDWT0biqF3CaClQOQ0hqk2IQngvsmN8xFb6RO6j8Q67otuyTmVmv+TMrP/6Bha5XMoLOIeExysR8VwGCtlX7VQPUyTN9QfcEgCK8GQAbPzQ4xOT71Qu2hUTmCrZq4JC2dDO0HDC5hw/ffI0RJjH+yjBUJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YecUTFwVcQ/QByJe88qfZPLADo/XEInPqI/I/stNQ6o=;
 b=B6OKYVmk9/MlvOrIJhs2wxvBkHbkR4/GPKfjmPoFBku8nnMLfk8eUixxzH5OzhVaEHucVNzV0ygOEcd6XhjIdeUWZcBPhl3uYioA/chkL1uzgR6Tr6e8mPZZ9f6iZjFop1r9yjKuU48b2FCFM3qkom0tYdjaSoNrTixGhrz4vunAv0bwFpZFynUClLNzLJ2ytTxG+qmmRKhrF0tZdFAySTgjsoNK0GeK//6QP7EARIvV4mkOUe9F9Wq5Oee3Bq6hY7wSBqleBUMY3EqACELUCQviG4jQjCkvSzLd/gvMlEL5UrYEH0/cA64vmq0IE4FKrgbQAxpUjk07LsfNZDNjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YecUTFwVcQ/QByJe88qfZPLADo/XEInPqI/I/stNQ6o=;
 b=V3V36qziF9e7XfIYDaBlRPdFL+zwxqaQgX6t7VthRMYsS8FRoRAVoE4yJZWRfPt5ZpWttA+6Ed3xtZKFqk9c0wXfOeXIyb8KiEE+4RXa4PSQ5lSP8/YRrMgMI25+q9wNXwxp74kLCGg1IqMKwvm7pqJ5KaLgTjiAseNsA7OGcJE=
Received: from DM6PR08CA0064.namprd08.prod.outlook.com (2603:10b6:5:1e0::38)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 06:36:49 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::9d) by DM6PR08CA0064.outlook.office365.com
 (2603:10b6:5:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 06:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Wed, 4 Jan 2023 06:36:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 00:36:47 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: add the missing mapping for PPT feature on
 SMU13.0.0 and 13.0.7
Date: Wed, 4 Jan 2023 14:36:23 +0800
Message-ID: <20230104063623.3674474-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104063623.3674474-1-evan.quan@amd.com>
References: <20230104063623.3674474-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: b1182650-66b0-4a46-7ff0-08daee1e0ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaCpxa2kbSIxbuPbl/ekkJl66PpsSBqKiaZnXEHsx2tl0ujfXKPQnJBMAzna8kPe3YrVsn6nPFh/bWyZKVIwq6cqGYH8/N153E7PNwHvZ1b0Ng+W9LashUCS4Wjqg31wYZi3kXElx28OlQ28l1aqusVQ6oBJ7n8rWFuGSwQo9SBUmdvEGehgwjQKWaJlUM73Ar8hAs1ucBVVQW8P1gMy6DLM5EqP29JE/SBOKT9aWdgB1QYgF46ZBkWQYCr6kRdeGS1VdlAuoHOzSHR6+F9oR0O/Psc0Bn1ZvtOHWO1y6IR5a7sCJxsagTL3xJhyZ0lwvYXiiuNW5kBZUtrxODrGdr3D83oMmyYyp2G7Qo5Bervq63W1hNOh8WXdFs0o6QBG4qTxpl0FOGCSXWihNc3uahs9Rql95awlDPGDKGLK41SB8vQevw21qgF6I0XTXL2Dpo7HUseUAPkZHnDiGRXO57Aqd7rpPKj7QwYlrn3so38ObHroFN8i0//51STXmNlWWeBOpDjLet7rt5w4be3maHBTfQt0vvIHH6JDRb1v8i1Q0VdrkaEY4qE3M5gGW15gYfEol12qD/MKvDjJe/BwigJ5rHfBfQ+ip4trWTQFGpI8BOvuPKEKkZsMvR7UNz4UsG30sV6YRVPYJVQuxE3ZJSJMLBVzefR4f3dBQzpFL2tfCPISiJwafpJoEz3Prfk796/DeOXzP9y5l0omqEkoNbk6EhSA13yXQN++03t4pgY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(81166007)(356005)(82740400003)(86362001)(70586007)(8676002)(70206006)(54906003)(4326008)(36860700001)(6916009)(41300700001)(40480700001)(426003)(2616005)(316002)(8936002)(2906002)(40460700003)(336012)(1076003)(44832011)(47076005)(82310400005)(5660300002)(16526019)(83380400001)(478600001)(7696005)(186003)(26005)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 06:36:48.7525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1182650-66b0-4a46-7ff0-08daee1e0ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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

Then we are able to set a new ppt limit via the hwmon interface(power1_cap).

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ife80277f89065aa8405715e7ae21fb20be7eb706
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index aebdd9747c37..969e5f965540 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -213,6 +213,7 @@ static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] =
 	FEA_MAP(SOC_PCC),
 	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
+	[SMU_FEATURE_PPT_BIT] = {1, FEATURE_THROTTLERS_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5c6c6ad011ca..e87db7e02e8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -192,6 +192,7 @@ static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATURE_COUNT] =
 	FEA_MAP(SOC_PCC),
 	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
+	[SMU_FEATURE_PPT_BIT] = {1, FEATURE_THROTTLERS_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
-- 
2.34.1

