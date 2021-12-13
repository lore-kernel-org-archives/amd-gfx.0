Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21004C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 15:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E00E910E718;
	Mon, 13 Dec 2021 15:08:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1FF10E718
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 15:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwS6S8nHj+l9bQT21yl7QMCMfCNXD5tqRxbYNv/o+mO+l+VDSyuU63gfBMKt3sFBW6bKks7wpH3hKcX/Q4o/qDdBpoWuhab1v00CRlI4s9gtjs0oWwsXurjz4Nz0WRlrjjuHRo4LhFrK3ljRkOLJoykfvCxXKJ/cD6Uu7uNeVOUr/jQwnAqrvbf/8gnLj2Z5O6T7B3YurBf1W3XSWyZZGBJKgJYtHfNJGK68WL3f85by0I1r9NTfVtQcsO6d9HJ8OhEW5vnxdnneWLnbcGO25+idisAW9rm0jSqWhnGMOwLhnc7CjoovlCCwNKtd6XosOeEIwzqwe2/18owC+wJqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPnaFoNtRpCF3ByHeAuh4p6xIZixDk+xj48tnXOfRus=;
 b=XBM5Vx1ampd08/5j6We9Z0erxBSv1BvptDE3Btvb9ZflzqdRbKwuLNaNko0cbqqgZmxvE3VGqQ7n4PLRSNg59S5M+kJO3FDqrz2ys9IfaHfJaxGDC6P/Q5xMfvwSiQ7WLbjSWvr1FgLxvpItj40t1UBTnitopxf0f+M8ZwJ1G0uJTv/KhYJ4TcnYUYCQALTt6Rc41jwFluRiPhGstl7NIWrWCBs7ha1ok/WFP7BKwmF26QcckOO0CZEGDgOrTp3vV+l2iKNRHPWdHH2om/4emCJTuPfchmC5evanrgAqOgRT3JPZbydttaUHQSP4y/VZB4JoxDyTYEXwFHtRchUU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPnaFoNtRpCF3ByHeAuh4p6xIZixDk+xj48tnXOfRus=;
 b=dEIpnwiUlF14HaOQY8Ddirx6OiAXNAbRtQt0SZ/5nKkHDf6WA9jiQS86mfczPRORB0TND+WMB2kqfuWlYNO35LSOkl1mfItEC6eKePV+RmWbhcc7h4wkzAGoKgv0+gnRi2ejlpHlADc3Ww2/0QE2lRKQA2fXtbWSuo96kXarqyE=
Received: from MW2PR2101CA0010.namprd21.prod.outlook.com (2603:10b6:302:1::23)
 by BN8PR12MB3217.namprd12.prod.outlook.com (2603:10b6:408:6e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 15:08:50 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::33) by MW2PR2101CA0010.outlook.office365.com
 (2603:10b6:302:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.6 via Frontend
 Transport; Mon, 13 Dec 2021 15:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 15:08:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 09:08:45 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Date: Mon, 13 Dec 2021 09:08:41 -0600
Message-ID: <20211213150842.21141-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47613d3a-f6cb-4243-a007-08d9be4a781a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3217:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32172D24EDB662291F6AB31EE2749@BN8PR12MB3217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Brcw6Bjv1wEAAH5YaZfJyWIQVL464dq5rzK1wmFF3U+eTW/BpC+g7oN9erN3UBsVUV5liR4ksa0ywLqy9ll5JbcaYlZKIAARSl51Cr674pZIEzAiOUhrP5wWhTY+gy9QynvuJn4BAmjggopMAoPF+X3aX+Vzbv4awRP/oOpyW7xnxDv8fw78+/Uq0XLFEAsAvQcubFYI2naKwi5ZxCoZ/GPzjZwMeWPboYxT7kGbsombhUUkHTIC5kCeT1E9WVPg3844KKiwE57YfUjcMfLVwdbsjHfYAFbv8Jz8oIWYN1qS6AzFYYownPvBt5x4rJLX6ERNsuMdpN7HEeDjalhlqUst/h4r6VZR0DVmguhfoeJxA4E1rDsrChcLS6HkRMO+5Kb8eB9tsicHTsZqs1F8IL2KGNy5kSwBFpZfWq/XLj9DVmNM7aIJjM7kNTN8vdrDW2L/4lmvS5Mg5yHUhSxnOtOLuFCOkd1ZwaWJBUThpSPZtL50himEbFLphSGBkhwrXH7hgMaDx+KYp/xW9xoD5WApo2dCVNQCq1XbcsnAG6Rr1ULtt2mwixpKsIerV5pSgwMu4mSwyVzjtQ/V8b7hXf3UmVHztdR6XYzf+loGwR7FjVawKBUnVdnRBGaUSQgzxpg03P48ryxQJi6oEJPohtVsyO7SajLc2tdZcgtG0Ebc3nIJRLCNTx5vNYz1eMckRUcL5NLvOAheQWDNr555x9V85HRRq7rNuooIAHEtUEeKafn6kpfhBU9NHLzsnnH4s2YdKaKovt7MQgNdKGwSUwWALnZs4HR7SHxc8117jwU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(47076005)(81166007)(8676002)(1076003)(2616005)(356005)(40460700001)(5660300002)(82310400004)(8936002)(86362001)(16526019)(7696005)(6916009)(336012)(426003)(316002)(186003)(70586007)(36756003)(6666004)(2906002)(70206006)(4326008)(44832011)(26005)(36860700001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 15:08:49.9941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47613d3a-f6cb-4243-a007-08d9be4a781a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3217
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This value does not get cached into adev->pm.fw_version during
startup for smu13 like it does for other SMU like smu12.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
* Run on all v13 APU to match v12 behavior
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 55421ea622fb..7fdb63da1316 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -196,6 +196,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 
 int smu_v13_0_check_fw_version(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version = 0xff, smu_version = 0xff;
 	uint16_t smu_major;
 	uint8_t smu_minor, smu_debug;
@@ -208,6 +209,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	smu_major = (smu_version >> 16) & 0xffff;
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
+	if (smu->is_apu)
+		adev->pm.fw_version = smu_version;
 
 	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
-- 
2.25.1

