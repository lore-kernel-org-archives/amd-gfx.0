Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553AFC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA3E10E4CE;
	Wed,  7 Jun 2023 12:16:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C81410E4CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExVDCxuR4+YQYTMzrQcruv75CGd2j8HvKy884k6pnpxrUJczVzXErXD9lgEQkwBPT7+d7WfG/NhrBxFgZtjfEdvnPyVW3IRobfWBSipJ0vra8vkyXa5j0Zvo++fiOv2Q9ncIOPz2PGXiQqENKLIjmM75h2/JcZGe/6xRf/07//Ppsbnbc58zUBLsjClKPcOnPqNy9N6akvROy3DNYGjYQiL6rykkRqBsmvrRMuY06zXlrFgZM6ZAlnw2IoRdeHdH9MA9cml0EmLkYO6AZSFx48VzUtylIttTXBs5LEwuraDIBsE+FLXBo21TSMlSl3dHb3aiZtwjIqL6A4E+pxdnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTg+2k61VKhfAvHLMD4mSM29UtepDKNrfc7ycDc9ri4=;
 b=K2YjMInFjgJxIQvBIQWPJ30Rea6TrGc43xUosHf88ZJKHgCs7GseFLuv+56ZPkyX4cQ9G2nFvleOTyfL/PgtAIaA3zqbJGjzKFqeRjZXtTQVN3fuXdxbXqNrawlGDK9Rp0xfzF63JwPfQVuVmx9BqaeXE1i7eeJiGj4ngy6FXtW9vzt3oDd5lAGjZuo6C0yUwsdUjWEbI3VXkLezG2ytSHQ9uV0L1b8URGz11GIYyDIXw3yc5USOkUBaZmuW95WL7B43bYKnLd8lk7SNHro2lR978Uj4O3X1SBeVXY66Jp6o7JsrOzqUj8RLeOOc8w4fWKKOBjIoNthRp323BlhkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTg+2k61VKhfAvHLMD4mSM29UtepDKNrfc7ycDc9ri4=;
 b=RfDLLfWNnKxty5ryVqUtZPS1SeUf4Ld5kZ2Sj1jpiffiCYLoPkB/LD0Z/utsUZSY91NwiP8eNeE/AxPyL8LnMiFy1K5yNUSZBU+bhvyns9BBL+MexYTJhy3o7UdymBiMxjUq1IwNcRMOYtXOL6N6FQu4vMOvDW/9LGIfkTlarvU=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:16:32 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::8f) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:31 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:27 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/20] drm/amd/display: Promote DAL to 3.2.238
Date: Wed, 7 Jun 2023 20:15:33 +0800
Message-ID: <20230607121548.1479290-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN2PR12MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: cad4e762-22f5-4afd-3515-08db67510797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+ZTVwV2HQv/ImSs6aAjggXauuhlcFWgfSHZZXchjRM2YqZmARD+cMX9dBua8W+IAhhReeTobTGj9frsZNN6+0biXkokuz95ei4/kzopE3haiQWD2gUKu76hB+Bs5W8AQwbKqmOtNJDAJ5J8ncIz1zWrIciXfvJYalKBlu96poJNyod6GiEVfp8ZxOPhfPM5fBl1+Bf1CKNbBVLdQDIML5P7GgXqVLaBGUtO3WD0ehfcVy2CAhRgiNNpPu5pER1SqO5ljFeznO/sZey0JJBUQch/wkP9SQ+hd5OVlVG1+lJ7aK0JLDeGh4fB9hYLPuyig1ETm3pWK2brR5/zslTUHCUsfYdIfQkcKwwmr88GPkRAOn8PjH86s7Zd0G8VDNOzwu7keI52zHjiUnt+z67gZ31CaS6M8co3LqXKXQA3o310dBgNN4zHJf5JDnPlM5Rf+8j2rvJhk7qc0VEt1v8N/Ok6PwmiZgwDeme2OWJK2IkdiEckD5ucma/dcbSBo6oMnuRED8aPl2P3HE6ewYqHgUZpBxk88AIQycTXsi2IA4J47p0AaMmCo4gTbrcosDJpdDT1Zh5UbRR8x7/bOINNApopLsKulsrz2Q2dujXp0Ew1ya/p0tFJ+3bWyGsi7PcPFW11ACaFpJ/LsTgKk8dZc2+eAGil4MroaVhlHxlYPVqaQkqh3XWP1LyWea+hnCjC4sRvzdm/hfiDsOYeGtF0jf4gCHJOBs15u6c4F49mbYZWs4aOEjZEtrYmQ1Ad1YRj4rHFxD9dKoyE7YN9ObTC8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(47076005)(83380400001)(336012)(426003)(478600001)(40480700001)(82740400003)(44832011)(40460700003)(8936002)(8676002)(316002)(41300700001)(356005)(54906003)(81166007)(70586007)(70206006)(6916009)(5660300002)(4326008)(4744005)(6666004)(36756003)(7696005)(2906002)(82310400005)(36860700001)(26005)(186003)(16526019)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:31.9325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad4e762-22f5-4afd-3515-08db67510797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7cf3e9510043..5c906b007e4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.237"
+#define DC_VER "3.2.238"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.40.1

