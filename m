Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573C5C43217
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 05:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CE810E127;
	Thu, 13 Oct 2022 05:47:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B151210E0AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 05:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYTd77JS/o06u/M1oYwzDKjPF0vwHjqWP/bNFtsM4t43NL8ac9/vBTPfaAvl0eVvbqzcNLsz3Us9WRjmdjerwMNP/oJWX6xaAe8Lmln8wZRt9Zj0rEjUjte2ooAOC/tHjjQSLE6M6DiNUDgWw+fjCDQb4RiBtNZ0up1gqIw7EG5B1nT9I1evXyXMKyZyMyyGXYPTDAZ0Ux7dqH2hgMpnQoT+LyLUxKkJ7GKdvPWtWOxL+TKVbTDXkBdXkg6u3DnEvWkR274bbOKgiVUsUIQ0GstXdXAXNLv0jy9mw+/lI8v/R7M3nwk1/j4CZ3RAFkD3RanXvhWdIgbRdDh7dNo2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+VC98TryD1s5U65P/Y/kd3CEx1RhXwwMYu2sBa8X3A=;
 b=lhxw2NhgvM8o99MAZXnmo1ilKyNxF2nBY1DFGk3LcLFPnWkjLvZHHDyKt2W1fSX3KmzP3MsCzj19WoK/a/nZs13TVlGwkwxF/ZA9G+Ho0bqo/kd7+JfqoeuCXOiD8pks606jOxwV9BM9hoyThxyj4b9MrOquCcBxNnecuOmOtUNKH2Slq1M3UasB7BYXUwlH7IpoYDKX1cmEfD2GsmlpFVjSpiyKELcfj/9Ib0uz0z3oKBdCijub52GJ2ed8RpdQvdRLQw1vIHe2nWbRYOLal9KVZ0nJeJiiww7GxSOf4gtnwcFCLyzBDWjAr/TPf9glhwg8Yk0eaK9My59+bPG1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+VC98TryD1s5U65P/Y/kd3CEx1RhXwwMYu2sBa8X3A=;
 b=gYGkSHIq4tkn74BR7VNLMpWfkM8po2F8iruVrTOxCBLimzM5MeG7OMi6KR+H85n5F4PelyzrfxZ5SxSaVT8LD4kmIBJ2zNKk8G//PE6wmzl5HqnNJsLEKwjGNgThjMcWdPBJycLDEFrlEo0I1EpeMPxfVLtT5Fyn7jlobJicuy4=
Received: from MW4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:303:16d::14)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 13 Oct
 2022 05:47:25 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::23) by MW4PR02CA0005.outlook.office365.com
 (2603:10b6:303:16d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 05:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 05:47:25 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 00:47:22 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: update SMU IP v13.0.4 driver interface version
Date: Thu, 13 Oct 2022 13:46:18 +0800
Message-ID: <20221013054619.3979464-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: c491bd7e-c163-46e3-2840-08daacde681f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iekxslYQwpXGi0zuJeA2QeIWoJNRRYlUW105JPIuDAYI5dSM/nHhCsP4rsucHH+gY0A19d6E1AESRnr5raymqXSQxbNUg5s8GOFEXS8UP1ASlYAzgT+Hq3cCHexJpvHKuT3CisBvZ8c4Y5BnHhXqr5Dp2BcgRP3DJ2KdK0aKpB7/J8tQdhsP0y5Sguk35FVcdwrnc3Dqsag/pTS47Z3SvIYi3ByfXZayZGqnYGJHRChMMNgbTUjNBz0wau39c2mpXoM9V7lH1wQ5HR1dxwhITb6mjLQ7xw9JmF8p6xhxaECC+Sx9qP8zibKJRenN9XuZNnkIj9/0l1UoNgEXRvLPjdJRS4Qi9KZnHPYP1bbnxpXsmX1lC+hdYVF7KTBVfVsFrZ+wVN4rjdeRms/eAif3Y9AIoaiDnlJirnBIf+Qe3j4P7Q0r43l3YXF+/CsuO253HD4Phm9J8KXCx5vfhWbFy5Owi25XCJ3a/Q8rjjCMpK0TKUeKnCciqUbarlrvuhWxYqP9/PuyRpZcMaBaigCSjrKVpNN0+trTkdu9EOETkt2f8BIXuepLksK88A7LAU9WkGfuviulbdYVGw3dBnzHZl2kdSQDh3+Ta6Pa9lzDYtDuLvxvxe2mF3upjSA47oLi1QrS+pH85Q/pg+U/OvjMyjWfRffvLHOn+Q8UyEWQLxXvaM7WKfm6CB2uJV69wWqdLG5gkCH+Ta4AxAHA5egxFp99YNxk3Rgx5/OsnPdP8h/clbdsnkjUaNhCP3L8dq4EJ0AxZMTmWJLgAawAtZDS3Vx7YEOPPGX85JX32PQBZ/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(36860700001)(316002)(54906003)(2616005)(2906002)(6916009)(41300700001)(5660300002)(82310400005)(70206006)(83380400001)(86362001)(70586007)(426003)(1076003)(356005)(36756003)(44832011)(81166007)(8936002)(478600001)(186003)(8676002)(16526019)(336012)(15650500001)(26005)(40460700003)(82740400003)(47076005)(6666004)(7696005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 05:47:25.4373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c491bd7e-c163-46e3-2840-08daacde681f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the SMU driver interface version to V7.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 .../swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
index ae2d337158f3..f77401709d83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define PMFW_DRIVER_IF_VERSION 5
+#define PMFW_DRIVER_IF_VERSION 7
 
 typedef struct {
   int32_t value;
@@ -163,8 +163,8 @@ typedef struct {
   uint16_t DclkFrequency;               //[MHz]
   uint16_t MemclkFrequency;             //[MHz]
   uint16_t spare;                       //[centi]
-  uint16_t UvdActivity;                 //[centi]
   uint16_t GfxActivity;                 //[centi]
+  uint16_t UvdActivity;                 //[centi]
 
   uint16_t Voltage[2];                  //[mV] indices: VDDCR_VDD, VDDCR_SOC
   uint16_t Current[2];                  //[mA] indices: VDDCR_VDD, VDDCR_SOC
@@ -199,6 +199,19 @@ typedef struct {
   uint16_t DeviceState;
   uint16_t CurTemp;                     //[centi-Celsius]
   uint16_t spare2;
+
+  uint16_t AverageGfxclkFrequency;
+  uint16_t AverageFclkFrequency;
+  uint16_t AverageGfxActivity;
+  uint16_t AverageSocclkFrequency;
+  uint16_t AverageVclkFrequency;
+  uint16_t AverageVcnActivity;
+  uint16_t AverageDRAMReads;          //Filtered DF Bandwidth::DRAM Reads
+  uint16_t AverageDRAMWrites;         //Filtered DF Bandwidth::DRAM Writes
+  uint16_t AverageSocketPower;        //Filtered value of CurrentSocketPower
+  uint16_t AverageCorePower;          //Filtered of [sum of CorePower[8]])
+  uint16_t AverageCoreC0Residency[8]; //Filtered of [average C0 residency %  per core]
+  uint32_t MetricsCounter;            //Counts the # of metrics table parameter reads per update to the metrics table, i.e. if the metrics table update happens every 1 second, this value could be up to 1000 if the smu collected metrics data every cycle, or as low as 0 if the smu was asleep the whole time. Reset to 0 after writing.
 } SmuMetrics_t;
 
 typedef struct {
-- 
2.25.1

