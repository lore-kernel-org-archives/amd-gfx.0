Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DABC4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 19:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6C010EA87;
	Fri, 15 Dec 2023 19:56:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E5B10EA7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rdw8LRcuFqXOGwb4EErox5W+jA9biQt/C6aEpRglbFo=;
 b=XyynvIug8xSmqnPm0rRnT7EaIc1Zgvq9fWKZlorKi0XgPXkpuRCadE8+l4d/QA9AE/65Ex410Iv1AW6uKyqKTzlz/pRvmja2XugbeE1ENnp7+y7LBgo8wIlfk/DfJubPl6rLeqxoAeFAAXurPk/W6qOFxyTYR4isOBY2TzLy7XA=
Received: from MN2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:208:23c::13)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 19:56:18 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::f4) by MN2PR18CA0008.outlook.office365.com
 (2603:10b6:208:23c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
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
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 19:56:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 13:55:47 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] drm/amd: Make SW CTF handler cope with different
 read_sensor() results
Date: Fri, 15 Dec 2023 13:55:35 -0600
Message-ID: <20231215195536.20401-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215195536.20401-1-mario.limonciello@amd.com>
References: <20231215195536.20401-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: ea03de94-cd36-4b1a-86c9-08dbfda7e72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOInUGxUtrvq3erv9hu+F59GmrKr4+PSCmuWG/7Y210W0jDMo7DNfVRusEFw9A812SkOsZ+oTuuTEnRKUuGJDi+yjJJlGoLpwnfW08la/3z96f3RfytopsvJ1SbHbQf79oT4/bFmQDunZ/lKK/TT3aaTdjY3qDtmgA/xPWKCZ7M43yOIs+c8QltC43Vam0BMujwLBgEIlIwtPTHpSbDjLNwWLpNCIO5Wpw8Km9u35lxKEs9EmWRF353lU9Cw0UCtFHvf30J+H0TADrwh8azw+eCe+fRkx4T2x87aTNbhPTF1Oy2nbQxra3OqdItZCnS5MSMj+S2dYjOv/OeW2G62ox6Et8v+m1EiIbnzx3Tlgc7Sih25uc0BDYPoE9qbSGv54DvrOhV5FeYhP4rN3Ua4YR6H2LV3KCayjEF1XxC1JZApLjNzL87MVemV5Hd6/1ChM0Prl8OqwzqijL03aYQfPKBLADzPUjVTOOPiUl6S5990qQL5JP4AiwafOLQSLlFhqgPztkmjNhtpnjhYKeHIEBVBghGMXhBSFiadkYFQWfrTID8G4OcfxWrzhyzLsRvqPtxReusb+WFQhd4UDD0CXuOItXsRG4o9czJTFh8XNPpK9No50DCmhO5HWDwYwlgquR6Snz+EeBfJqGS9mLXOHyKZOyt2LBxYRmuPlrf8IAZavYweEbvQcFBzm1Te2tnZVsLsuGq2id5ycakxR8VwQOzkq6d7uaHflpYlbbk/u4Vsmz+DrkAqvAvPvjLHgQpIO8GEcYnKiNxg3ueQzD2PgehVMNlh3eTjIDwqF5KwzCXOX6r4bavmsHwI01IF60bX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(16526019)(26005)(426003)(336012)(7696005)(2616005)(1076003)(356005)(82740400003)(86362001)(36756003)(81166007)(47076005)(83380400001)(5660300002)(4326008)(44832011)(36860700001)(6666004)(70586007)(6916009)(316002)(70206006)(8676002)(8936002)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 19:56:18.2278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea03de94-cd36-4b1a-86c9-08dbfda7e72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
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

The SW CTF handler assumes that the read_sensor() call always succeeds
and has updated `hotspot_tmp`, but this may not be guaranteed.

For example some of the read_sensor() callbacks will return 0 when a RAS
interrupt is triggered in which case `hotspot_tmp` won't be updated.

Adjust the logic to catch this circumstance and output a warning.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Correctly handle fallthrough case
v1->v2:
 * Only show `Failed to read hotspot temperature` when sensor read fails
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 24 ++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d24fccf28f6a..963cf6e76935 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1165,21 +1165,27 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 	struct smu_temperature_range *range =
 				&smu->thermal_range;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t hotspot_tmp, size;
+	uint32_t hotspot_tmp = 0, size;
 
 	/*
 	 * If the hotspot temperature is confirmed as below SW CTF setting point
 	 * after the delay enforced, nothing will be done.
 	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
 	 */
-	if (range->software_shutdown_temp &&
-	    smu->ppt_funcs->read_sensor &&
-	    !smu->ppt_funcs->read_sensor(smu,
-					 AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
-					 &hotspot_tmp,
-					 &size) &&
-	    hotspot_tmp / 1000 < range->software_shutdown_temp)
-		return;
+	if (range->software_shutdown_temp && smu->ppt_funcs->read_sensor) {
+		int r = smu->ppt_funcs->read_sensor(smu,
+						    AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+						    &hotspot_tmp,
+						    &size);
+		switch (r) {
+		case 0:
+			if (hotspot_tmp / 1000 < range->software_shutdown_temp)
+				return;
+			break;
+		default:
+			dev_err(adev->dev, "Failed to read hotspot temperature: %d\n", r);
+		}
+	}
 
 	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
 	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-- 
2.34.1

