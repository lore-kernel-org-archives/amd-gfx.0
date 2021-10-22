Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69566C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 07:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249A0610E7
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 07:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 249A0610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD3A6E8F0;
	Fri, 22 Oct 2021 07:44:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494096E8F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 07:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnwfQcQcQgJQjxq5b0+Ab653CLjHcVfsZbhVRnnD7CWkGtzxsG4+Nkxm30DijwdsUGzcpy7F65c66Crh3cOGbCec+pMDbuHtJ6xnrn/Fy4k43kukMeLhIFUi3Iw9LTPRb/ChEnOheE22iNaepiUvQAwblAwRYzdFQZuuosbYLAampHo13ovqPQFy3AE6vR6iZ6glUh1DgBrTQBhi+cbOhTRbuXzTsCJMFx56+eaOEpNdFS3LGYq/xO4fGE0d7OkkSyauekEJ9gtpmX7lRKoH8kHxEQR5QkNf90GOTRm+uUMsiMdRnAPLmeFAHnxZ36xpZLl3ek83ZJANf7ixwsvvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uJfLXNrJnVoadNS2R6CZBtjB65bqvi04QlyErHRdUw=;
 b=I3DwbaaFJCvfje8FjJJa58dmaIxxq0v9JIJVoauF8F2nw+QvricvQvX6USaLCIIbkU/CXO9ZVKKIQskCj3tg36zeGsdHLSDLsX/pcVzfxPJUrpqqXpj6F6xo/ABmyuzByMAe52OxrG21M78LLDUe9T/0oLy2KDMrK2kziDwNvmFsF7OhFU2XoTal59+fv3jcNxYh3dnBxfPiKL4tDbSfhMuqeN+Xmbj1cLKlkdySoDF6Law+c8cEGvr+HbrvMFEVjWJ2I3Ku0n00FfnMKkT0stk74zY7EqNtMNwLIuDtNmOxXQ+3iSPcuzp0Mtq7ose8UxoxJrlnqDggh+n509BszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uJfLXNrJnVoadNS2R6CZBtjB65bqvi04QlyErHRdUw=;
 b=UCabyCB1ZHE9mkuhHl7nPjCjaC1sEoXV5E22vbMjWHrAbM54Tcjl0qFVz7UlaQBogr9zUXhVD910g1cm7XlRce61P9Qv4ujrQHmQ39q6tGm/+1ghdpqv9Y9RmEIdK5Lk8KmTCxuivTBJhxvKEnsH9WPU9M3Ngo4mMlYcINmPFmk=
Received: from CO2PR04CA0161.namprd04.prod.outlook.com (2603:10b6:104:4::15)
 by BYAPR12MB2727.namprd12.prod.outlook.com (2603:10b6:a03:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 07:44:55 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::f2) by CO2PR04CA0161.outlook.office365.com
 (2603:10b6:104:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 07:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 07:44:54 +0000
Received: from lijo-u1804-kvm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 02:44:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: Disable fan control if not supported
Date: Fri, 22 Oct 2021 15:44:33 +0800
Message-ID: <20211022074433.29717-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bed002ea-f61f-494c-e3ec-08d9952fd667
X-MS-TrafficTypeDiagnostic: BYAPR12MB2727:
X-Microsoft-Antispam-PRVS: <BYAPR12MB272786BA940BBDEE5394AA8497809@BYAPR12MB2727.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDUO/7J2HZ3hhaPVZdFhFPOVbom7nBkr/N4ky7tMqQAHEbWUK70cDxtnKz4SJLAysTPmYrWUkmG46u0wO/1RMa3o6QOFwE2UtUTpj+nwA8mnvsGQimZkTHVKZu2A7dABlJI9VfUb5VKaQOO1+vGhNbs4Y3jZDQ02EsdXiJ0qAgExgLHJUQZ6aiJBd7hECQEhL5hWT36y/L2ZnNHWNm8BVr3DianDMsXtFO3jfskaBVWsrOe8WEyarPW1SGDh7HZC0WZg+VZUPlFfVcvx79Tr6Mbf0niQa1Ll3soJrUHJj8PD+3C6Afnj4glvBIse/0iZbk2n/LlToAU/F5Dlg1dfQb/B7U1f3eWvVzEFjWcWH/Le5OkCplHlOTKR3Q34Rtw2VzlLO/MljFoLYTCiNVad1rg+BupV7+Mr3Gf3Wluv6Gcg5CyLhZLP32bIadKEoWP8f0hhw1MK+55JYUM0lXUWoDYvZE4E19uJemPU+scdJblv38FUwqFQrMdN1LQ+NbJabIb5H4fjgHMiJaHcbh+xnIpoW6VuzNF+gBx5RGITQCzZtyAjujwDSV89rljkxjHd9k+uLITF4TeI6dfGY5rbFZKK2eKIMFAuLWCDlfiu/srzztgajkA1swiGsYQsdrvg+IIfEu7/u5/TYOZzwd3wItCkz26igMSgQvhis7YgfwrfiAZUSXxsw4j1mrXWlttpcxtv/uklHcY+iLMFzLY5Ai9+2yJVsMQHhgHLW9cgWK0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(2616005)(81166007)(186003)(426003)(83380400001)(7696005)(54906003)(8676002)(70206006)(356005)(16526019)(6916009)(36860700001)(4326008)(44832011)(47076005)(8936002)(5660300002)(86362001)(36756003)(70586007)(1076003)(2906002)(508600001)(26005)(336012)(316002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 07:44:54.1241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed002ea-f61f-494c-e3ec-08d9952fd667
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2727
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On arcturus, not all platforms use PMFW based fan control. On such
ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
knobs for fan control also as it is not possible to report or control
fan speed on such platforms through driver.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 082f01893f3d..fd1d30a93db5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -436,6 +436,19 @@ static void arcturus_check_bxco_support(struct smu_context *smu)
 	}
 }
 
+static void arcturus_check_fan_support(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+
+	/* No sort of fan control possible if PPTable has it disabled */
+	smu->adev->pm.no_fan =
+		!(pptable->FeaturesToRun[0] & FEATURE_FAN_CONTROL_MASK);
+	if (smu->adev->pm.no_fan)
+		dev_info_once(smu->adev->dev,
+			      "PMFW based fan control disabled");
+}
+
 static int arcturus_check_powerplay_table(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -443,6 +456,7 @@ static int arcturus_check_powerplay_table(struct smu_context *smu)
 		table_context->power_play_table;
 
 	arcturus_check_bxco_support(smu);
+	arcturus_check_fan_support(smu);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
-- 
2.17.1

