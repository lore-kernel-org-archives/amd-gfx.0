Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6111C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 17:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5652910EA6F;
	Fri, 15 Dec 2023 17:28:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A903410EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 17:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7cCXsEXW9mQ8vyLZ30wma9r9YMIa2mmTK0gYYDSxFa3qrbxXinYHLSiXnV+NRVB+DGH9X8zOzScq8K66nz9uVzDCHhT+KZvYYbbJrhHtxW+28grekSfrRC5sNY3v8SMwnpswL9o3hwDz2CWdQfEJOsOdufvIrXv7szL/frHRjgi1AITBxJgBR9QScNoLX5tNHVtskrgpxvKIBT/DVHy5Ge6WK9YWlRoZncuboDBVtqZSBqMB1Rp/7IomFojK2TjboPUhgbIcBzCKN07G1rwHO0iWCW5oV9hhPTAKgz/lpzA9ytfcWHkctoYqXoL7rkUqTj95B61+oZKDVzjyTz02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Jv3FUsqNB+b69WTWPlSNC2V6Kiwovw+BfomlgG6lV4=;
 b=PSVy2bxI6Jt247lzw8p3Y4dqi2CD5oXvsdi1FztMwOdYz5uiKpl/IeAossrcIAed+qdrNiu5yZIX33rRo3vhdfzS6RwHJ/o0Md9YWxpz8EAsomZlAtAfRQydXmV8o2H7Q9X8idSGE4vrXFfRVMnitMQgIvkJzuTVbqN13vHdoSxrCXpKGuUBUBypwwnOoIn1q3BHZDeObmTch9ape+r1jsummjkzm4sUDohhKQaP84OuAbsX49YEG5T0hEawsiNVsQAA6vCJilD7FTP8bS60K6YakHUc0G2nBJ2XPqg+QtYjfNrdMl/gQaP+V6JJhFTrXFhTVaLqTkNsWNyvdTcMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jv3FUsqNB+b69WTWPlSNC2V6Kiwovw+BfomlgG6lV4=;
 b=wPHhIB/kajjoH/MJUlmFRGmUR7yMRqd90NVv4xiEsspKW62xhsNaOl1eX5zUqfLU+wZLZZmG0ob+pig+YNNvPqLG4ylXKOA2DqfeQEZYdORMVfziy4V6DcbPIwRh++GgqccX2QHYu3wqeg6xj4rL9mbCbpQ5V8SFiS6TbX6LRsc=
Received: from BL1PR13CA0126.namprd13.prod.outlook.com (2603:10b6:208:2bb::11)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:28:01 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::6b) by BL1PR13CA0126.outlook.office365.com
 (2603:10b6:208:2bb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.13 via Frontend
 Transport; Fri, 15 Dec 2023 17:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 17:28:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 11:27:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amd: Return -EBUSY in read_sensor() if RAS
 interrupt triggered
Date: Fri, 15 Dec 2023 11:27:38 -0600
Message-ID: <20231215172740.15407-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc68180-6e2b-462b-9150-08dbfd933009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQdUKGWK59LMQDpgsD3bG8tRMZxUv99Xxu1+cFZWKsWTgVZcDwAM/mfaFCThPLWepB2v/jl6Q4UIyg+BGIb2m/bQibGxgCs4f7LucNQU5OIyH5rp1rV5iP0Ie1S2kNX8Gf4KguMXjGXaHvLFrjcC0yHKi6SHUj29cSIRc4TGPsxNqsDqFGiL/wWul5OJDBNbH9Hiu2LYWT3Js45l8fEisOu2vNn5aj+gA8wqgZZb5Nt4geWcvJbB1RbRB0R929Nh0lNmewRH1CBERNJTOFsuu0g4T3d58sRnlDN25shGE7mVdzRncnJosot15qphcRmwlFUUocibEXf1QejtPmaPq+fGeVKefDAqqDzsZ/iLCwj4QyKfQzz0Yva6GckHUGONnxh1T9jNR2VUX0dOM77OfEBeKm5cTW+3pTQLjXSR19plxPWTgNVYBFO8UGQPAi6AurI0Wmv3mN09zHj46LRSUstSepbD7+iBNebUbzNcRv/UPC+R5823Q9V6L2CusPiA+NZK50LSp/M2KfHwqZFP4eifF4wQaJJ/ulWOBuzbDimT1QfGjazOwahRISLnPe0+BTrwJPHEydy2s5WV0/IGG1kzxwy8TjxCAJeCZ8wOEC+CWNonHDp6pzjt+NVNQRzuWHN1utkmUoL46S857B9OC2zVUepzHyc9tE42+yM9m/l+PYKC0F4PySHYDMJZKB19yGvJ3x7IxlSLzLm6Ya8YKWli262WAVziPrtfs2zI1lo4QF6v11zHb7YxiaqgWR23ipn4F8VZI9yUHD89paM5Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(36756003)(5660300002)(83380400001)(336012)(6666004)(426003)(16526019)(1076003)(7696005)(26005)(2616005)(478600001)(6916009)(54906003)(70206006)(70586007)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:28:01.0541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc68180-6e2b-462b-9150-08dbfd933009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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

