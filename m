Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3570FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F0710E395;
	Fri,  8 Jul 2022 16:37:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C030710E335
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJi0spp/eosFvjKndcry+qj/Ohlh+5qRl5gX+zO9T4gYMXYHJbMwc1i80n/uEWsjBYjUusu07zzd+TUhBSTmkdYlBmkrTZPQ78qAJ+djEJ4+/UokviGy6PD8xk91skzMeQxsGsa+ANWehfw6td9B2kKz3dBwORUweHo5GoWYwq2iq2QH4SdejiUWEhDZUg+hF+FA2KaxjGvfu5JsisCFrxAq5ho4pwveaKHgCU9M3+DvCwpVBbwE9KTK0UyxQlvrXxN7S3UUZS6++r2ly8oDwDYif1iN0Xinsv+lOeWKHnLILU/e4VXqs1R0nUXWNyyo0kOpVjf7wEwFXZ18uRfGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y9DsnRxq0JvAiwfhcw02Tgj9+dIAKcT8QPtaqmOUsw=;
 b=EQ65ZTye64SUKcXeu+lVfXZGpf3Xl+odMEKJfNypg2nr6CwFk0KlH6JtkeYfyZimpz03kR1elp5JFVVvBQ8yn7d0vQikWfIeqXXEijWl54diCt7BbaTVOKtlU3lQHGfFsfhdb/Oyubafk6my5XKyQXLwRUqu3fd3P6S13byOQIg97IwEZoh+UseQ45EkszwyJ/I+2prCMhxUYzMn3sZh+uWwIRSp6oyEN23utLvzX+5mk4COB0n5RqEZxx83C2re7Lg6NXRyc6/K8jNDTbY6Ui9Kvyqz6r7Vdo9LNZYNFON9gQO5wLYPraol4yiA9LM/OsmUFZgVWMll/ZcyKlXllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y9DsnRxq0JvAiwfhcw02Tgj9+dIAKcT8QPtaqmOUsw=;
 b=IyAtSoN47tYpjqD/jbqH+GdOFS10o3t5n0mbpt9KqU4owyx0R6Rofy9MHWLm0wGR3d/iGdLgDxqdemygNB2GLmPv0zLFJRJ2b0tt8nIFk3uM2DirjDbuLnjfS3I3sRgFlzYOVzl/kjifzVuHZlfxzaiI1bGLcHgdTgBTvcEMNcc=
Received: from BN6PR1401CA0008.namprd14.prod.outlook.com
 (2603:10b6:405:4b::18) by MW4PR12MB5601.namprd12.prod.outlook.com
 (2603:10b6:303:168::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Fri, 8 Jul
 2022 16:36:59 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::96) by BN6PR1401CA0008.outlook.office365.com
 (2603:10b6:405:4b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:59 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:55 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/21] drm/amd/display: 3.2.193
Date: Sat, 9 Jul 2022 00:35:20 +0800
Message-ID: <20220708163529.3534276-13-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eee3016-fe57-477a-5079-08da6100146d
X-MS-TrafficTypeDiagnostic: MW4PR12MB5601:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJfL+oFYivAGI0GhEt7sAR+X45qKuB9gpHtNuiponEgM7qYrQk5MuUomJF0pP0psFdd3XvfWZTCBpCQJL0D9wEGmNBttl7sfmqAAo34DaITDlgI98P2KKoY3kbmVF3q4eDDxehTkTAsknSP9bE5eDdSTBT6eXD9UB27qXR+ebDLiNcSJLTyPsLfu/j+efRoCNVll7Wn/+LCnvWuVrtjNRE+JNav9WFoZvSsKDbAJ1/edexZGEOZi8mEpU99PS3ivYHFMfJZ2x6OOBa/VdNV2X/XobFo9InMXOv5mk8FK9q3gibWUa8IhgcA4ZverQ/u3hidWnofw7lloMGMK0ihJI2w80N16hHIeaJ0RkTzX5ulBJ0C/9rxkwucDT/8xh19rg+om+vNeOedmfVOpxZlE25+XlxIHJVMiAKo2nGRyIYSFgEv1/k9cA+peXcHe2PNJFlc4i8YLOsvSVVTy/BNKalyHf2PthVxkRGQ0pJOZDWdPI8yQnZOKBUpzIy0PykA+q1Jmg/ifrsSzrfKYQJK6Fzl1fcktD4yq41pz1seSVACfwMLvW1x5PY+45KQ4Wqua8lNL9AHPlMfRukd2ILrlxeiBMHSUWYhlvziAvWPQtGJbhFnYGuw9kdS/9vYcOfisrARLh0dOISgYeGvNJ1Y9zxW+FUQJzmmJVgv1ccgIa4303tFjXCUCRJ/9sGaBtMdLtb3TSaG5CzNByubDTfW3Aa734YFwo4mjJb14KSRBst+tOyzkPa5FfZE3aYYtrJp1ck2fJAUP/7KrdqWkXPu6jyNxbvGcFtVtd4hBp3IMh2pJBzGvRuLLs6nCe7mQCJVwrXDAb684shhZczCuR7eHhJi8jg+4DibJH+8+smpkpqN+xX8iDtkXn9eJClkXsREc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(40470700004)(36840700001)(8676002)(7696005)(16526019)(54906003)(186003)(5660300002)(1076003)(70586007)(81166007)(4326008)(44832011)(82740400003)(86362001)(26005)(8936002)(2616005)(4744005)(478600001)(2906002)(356005)(70206006)(40480700001)(6916009)(36756003)(41300700001)(316002)(36860700001)(426003)(47076005)(40460700003)(34020700004)(82310400005)(6666004)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:59.6324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eee3016-fe57-477a-5079-08da6100146d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a0812849794e..1dca016b5782 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.192"
+#define DC_VER "3.2.193"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

