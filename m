Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657BAE7F13D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC7010E447;
	Tue, 26 Sep 2023 21:54:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495AE10E442
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYbllYgjBYFsE65amDvXLHai8rhWNtlbmVjg3wmzO2zWBX/dEdhTVSHiwzZBOK25c/swhvdKgF3+tAucs/UdKzLs2mnqbhVJh7Hfjib2AKjjRKDieHy7PpM7Q+VUf6I2SL6q3LfAMs0MzGP0UqLuiDRytudKB6iPYHv/nRENMeVsNKlxISH8n7GDYsb23Ii9AopR/LfvsI25rFEoYhcXcO4phkpS6VGWi97SRI6dezC+4iQgttwMTsgk4F1fH4DlZn1JaX1xmUn/scpcga1OH7TeBzXuOa3ZzGFGl/sA+3WRzfLvSTqYthoCW63yn65Oy38fewwJ75T7lGC6AQp01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZE5t1qPIQvsDnpEO1oVTYSSl5Gd7CnzRz6A6tjWdt4=;
 b=j+piMlVBWuWh6mOhVYSzvI9cJQrbF/MgsXSfJjc4qiAUOZa8AXTfpdzqKnxKuAhpA/DqQ6dbfUDzdgzhq7wmoA1fzvowOGsQ9pXj2saUZWZf+bHu2ulQEUmNo/hiSleVzXAejwuvb+FYZjLNNnTJjCj2R0e8w5DahZb6fk3oDl1d33n2aEyvVZpR1zmF0A4xf4k0vDBqlzU6r5rBle8SyqdHiDgq76/Es2Q7HCyiWocrerqrm/1g8c/oP5LDU4mpR6DJL2TyO4+tUVYwRv8KvQG+8vxLBMQ0+Q3fDawVb/Yr3WRSol8hlHau5XLQjynJIe00Pcc15nIrfHaHrWVBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZE5t1qPIQvsDnpEO1oVTYSSl5Gd7CnzRz6A6tjWdt4=;
 b=4AWR9vZ5ZC9BIoQMzWwuEEODh9dzdyh28UqUMd4I16CHfx19FtBTgZzHkks31CBC0OBtOA6MQeGhJ/8J9w/ok06loniIfcr1lurMtP1BCT/Zh1wCWr+6/o2UxEI/rarjJcFyCEX2wJ5zC8IiaKtPdVvHOl3JYyJWjdclHAoRT90=
Received: from DM6PR11CA0004.namprd11.prod.outlook.com (2603:10b6:5:190::17)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 21:53:57 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::a7) by DM6PR11CA0004.outlook.office365.com
 (2603:10b6:5:190::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:56 -0500
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: 3.2.254
Date: Tue, 26 Sep 2023 17:47:05 -0400
Message-ID: <20230926215335.200765-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 970dacac-2ac1-4776-30ec-08dbbedb15af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2yL5Y8MkrS0z37j4GBHI35flUHOJYimTL/a31vMOxw+HTDd+nXs98ZgYj673Y1TemJtZKiRqctw8tXSV6aa/n73gCTBwv3WhFVPI8s9MEewqnigwJXAxlR3lOBWO/uW8TPrIaKRD88qLWBs8HN+C5n+Fd/iGrgN4CVFboCpKF0TmqlbY4/brm4qXruqIDeDxZ6EcFJFw7l+lrLYuVL4JvpFrcH1M0d1Ep0WYzhHF9EmLZXE/+UhEVQQKC5aKs2P12aFiubEhYJ1uvH7da9K3WFPD+2F4mMRMRXLwyTW269phjytZ5RAaoC0mlI37twibmYpYD8k5fM6eiZc1aAzVsM/Q3uQchqMLPI6Tb0mdni47uuBOQgDJLPfRxV7Ycf/xU9xX+CXFSUrYPvbCre9F3dAtxxMUSIoK6W89R8HYSzHXWIy47tcvkOfmJWiTvHXkzHdukZd0LN9h4Ed6NK9WRg1pjgNpVR2m0fgT5QpQxBIOGEPP9NdHBNeMhbfL7+RsulRjaSSMBaYYS6s2WE5Q1oyukSw0dgocjdUUh3tyCLV4Prc7Yp8nM/a1HxwADKprjH2yrxQzpeyUyZ4AHDm94yeN8mK4cq2gjaddemDlB2mxwBy5ec7CldROATsx8p0luoKgel24faheKep1G1OqhTof3nsWlFDKAbd5tB+UDjybP7GQ6DMZCHjiQx1DfDJHHhHxIp8zLSyRqbBKGiczi0UPtDp9IIJAFd0QNyuB0UUt5OROE7aXu4gyUpMC/X4UBZtk/aLjabV0mthUGXjbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(44832011)(356005)(5660300002)(36860700001)(54906003)(70586007)(316002)(70206006)(2906002)(8676002)(8936002)(81166007)(4326008)(6666004)(82740400003)(426003)(47076005)(478600001)(40480700001)(26005)(7696005)(6916009)(336012)(83380400001)(36756003)(40460700003)(86362001)(4744005)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:57.3194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970dacac-2ac1-4776-30ec-08dbbedb15af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 00710f784af3..7d1ce58d493b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.253"
+#define DC_VER "3.2.254"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.42.0

