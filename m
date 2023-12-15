Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC69C4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 19:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8017410EA7C;
	Fri, 15 Dec 2023 19:56:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149CA10EA7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 19:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMsBqTLlCFur6JHXh8qa4Zz6Ah90T1d75kkreYDAETkWKbKO7zIeXmYUI8EWnRwgayc0syjkXTsC61T2mH8H6lwl0LcxSh3SXmLtnuB4EeUVYBkZ3HMTMTabi+jDij8YDMIx5CBZa2lk0xdDk7hzTK7OxPVJUReKhSnCJ1EQ2kQNUKtowIeIhr03dIDygNwfnUZV3HDJNEmS1aeLxgT7WzEtqOKoC2ONc0npl0+zTx3OhXKdq1TRTaRuCYdBrK45iIETMxH22IozwlYjrAEEGiLPfl2UzQwyKJ+qr5/ub4iXfgNqQ1PbMOA8GHDWDPdPREwpYqEHJ++ttQcWz6LWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Jv3FUsqNB+b69WTWPlSNC2V6Kiwovw+BfomlgG6lV4=;
 b=gjtN3ATus4wBkSeXTOcnF9rGhRy55vy87ZA4da2AUzGVvz1d008yIJOT7nzG5G2/7uWJs4y6GsrvcIZjdsyV9Zx78fTx7RdZb6J5bcDZ8D492Pg69YAOBdEbKzpAo7sf4axAPioPzunZ/mvzlm/UyS50zOYV3fmRj+pLhZCBdt3rQ4Odf/RTDqW59AdBk98W4Vsx54nlyno6cGS6avH6CO+WIYyVzDyiHrjMzaUo885nBRVgrwuIUtuPnVVGvrs8dp9NlIFc+0tH3S8cXTRAodJcYpLRUZm2RbU07yPyKJi6N/2wzN5diaXvmdXEekGt2xdxg6832oyf7Ftu2uvVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jv3FUsqNB+b69WTWPlSNC2V6Kiwovw+BfomlgG6lV4=;
 b=uA/cWIlEtOvEV4BHwQwCRRxRzW7PuAbpbOR1XOfcC6vWOLQT1tMj6gVxpscnwnLMhLrPdFFfUJbqhBTfDIfe/jckyBD428sX0EUVOYdU5SACrI2K750TCNlVppo1GyEETqZQUuLjUdvoaZYSoUZhdfUOW+/je554CRpG+LVXD1Y=
Received: from MN2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:208:23c::16)
 by BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 19:56:18 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::86) by MN2PR18CA0011.outlook.office365.com
 (2603:10b6:208:23c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Fri, 15 Dec 2023 19:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 19:56:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 13:55:47 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/3] drm/amd: Return -EBUSY in read_sensor() if RAS
 interrupt triggered
Date: Fri, 15 Dec 2023 13:55:34 -0600
Message-ID: <20231215195536.20401-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|BL0PR12MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bc95df-25f4-4529-d7c6-08dbfda7e6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvTjlwjoB4c4l4XMTQVoqzqG+79woyc8I9f6cdlib+KItffxTjvn027Cpzxii+ef8LnmkhXd615vE9ZKRmC5/reOZSSLadX1FsAADwg8Q6Jc7U0F35Av86AiKTYOEyRB9E6nssSHtPwqhv0rrZZG32UvRi3LbSIbtu5kpUx36T8q7kELf25jTbpUis1gYHsl4XZiJv3K1oNlNvsIB1PORFGHyh512YPCZiYnr5ILkGvraw7Ghn0fX7VsKQo7mZoNWN/tnvpXv1+CG6WkgzHZq/WWm/aTibsPQ5kuWzouyOw3FoWq6JD1QnbrCU4OfqD2O24El6zUjQODUl0zWZ/PSMcJU5oOSG7TkHqhBDj46z+A3I2jYF8juzHBsFXWk3nDY2VIJ1edhw4kc+enhLNZTQeF4HdccLxODFGsSMrRi04i5UHRrTn6iTM8ZJERe+nvhA9b5JIs+e7VLuhA1ObaTul7tIYuiMGsnM2v37VROujE37rP+RnmIDhYQKnUUA5vIthnzl8R7wihzpJO+A2RR2r84TOHUJqW05UoxZBrbntpmwRHuIeX1jJMsgiNQ0P1EEHWWm/8jarRKwCer/7whcu4djz1XQsEamUkO7LKDD8LtyxUsBMNbXjED1rniFBmFkR/j2yxR+KaGPJtijdfo4Gy0EetreWIXbp7XCdApK4IjHPlI8Fj1ukas42+g1/mKLIMWHacuUobL/UPZKQVidrIvzKzZ50th4bQ0Kd2Cm/YTFMB9soTzlhwXLvXy/xPBi8YXwbWXy5M7iJ0CbdbEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(36860700001)(81166007)(356005)(47076005)(2616005)(16526019)(83380400001)(26005)(1076003)(336012)(426003)(40460700003)(36756003)(86362001)(82740400003)(7696005)(6666004)(478600001)(6916009)(316002)(54906003)(70206006)(70586007)(2906002)(8936002)(4326008)(44832011)(8676002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 19:56:17.9153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bc95df-25f4-4529-d7c6-08dbfda7e6fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
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
Cc: Lijo Lazar <Lijo.Lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Any callers to read_sensor() may get the wrong data if the RAS
interrupt has been triggered and no actual sensor read occurred.

Adjust the return code for this condition to be -EBUSY.

Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4cd43bbec910..1fa4c14326ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1059,7 +1059,7 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	int ret = 0;
 
 	if (amdgpu_ras_intr_triggered())
-		return 0;
+		return -EBUSY;
 
 	if (!data || !size)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f1440869d1ce..e1c561ece319 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1091,7 +1091,7 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 	int ret = 0;
 
 	if (amdgpu_ras_intr_triggered())
-		return 0;
+		return -EBUSY;
 
 	if (!data || !size)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3998c9b31d07..ac7982132951 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1296,7 +1296,7 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 	int ret = 0;
 
 	if (amdgpu_ras_intr_triggered())
-		return 0;
+		return -EBUSY;
 
 	if (!data || !size)
 		return -EINVAL;
-- 
2.34.1

