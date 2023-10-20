Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B7DC001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 18:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFF010E0FE;
	Fri, 20 Oct 2023 18:06:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7AB10E0FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 18:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdNjt8CKQ0P6brhg+6wN28O7H+DRNX4AVCydeTC5m1G/PzgSYDAtKxwnvTvIsaMpxkYsZoLwVOHpkTgN0ZoqwLXr4qgzljQqW8zHhmQ22jXQRCHqOMfBNZ7L3Tp8Pe8FbJ5pBirygLwtjA55dBB8uDBE3nNgk60vktULQFBj2dY/vZkALl8FlBZ2kmsiSa/jrymBiTXP2Phyu3rpG0TP13oqPxQYYiqNNMiHLDIg7wh/4VSwg5PUpSTEH1Fax2fQT+OnEFMwKZp82/GmWDCNygeJmXpxFbl+xjKOq/pLw9ivEIu13z4Rphwe5BPDO9fIDmG3LMP3ctZbt40S2wsVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOwFKNH2g7csFRUdRuMjVFu6Bdrvae4VfuVc6weoBNk=;
 b=LO5otk/YJfyIe3kpUai/o/cGZ2l4bQ6e27KLZRBUEcqUnHKbgKMiwzYcTimewtICrOdKXeeCR4jtnN+uZ2siClq0f3Wvtq7tNpqYP+jjIYVq5QhVlU4buuNY2LhnzmGJo9blM11wNX5TcgJ0mwWYiHY2y+6HUxvwaQ35TawR2xKzEhM3778w6FgfrP3FYAFrK9vHyphs2LO9SbKRqCWKf8q/eDNCiMa+qgDVr76hrTe1Fmi9DfnZfqxa/c8Ji5SVTrpRFzY++K4bwR088aIdjRh+LqrSt1iYiYr/JKXgwqosEBa+gXCkDKZ7efYZgPNc/LVv9MLf6llkdp1/ycLJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOwFKNH2g7csFRUdRuMjVFu6Bdrvae4VfuVc6weoBNk=;
 b=kH1m4Vr4v76+kbuGTbuoJ7vKhY2w69hYKgeajQvS/H4rr1qFVvUTS2IkIWKFwF7AGVaVC4Owb5DvU0mQsidGXJDuSS2TtXE4X4dyNFWnpqpC1SgxAgL14ycdDCcpaZWyOE1e1awQfRLnYpfulh7pOEVcbzN9uKwmDszvcZz95sY=
Received: from DM6PR13CA0049.namprd13.prod.outlook.com (2603:10b6:5:134::26)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 18:06:37 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:134:cafe::24) by DM6PR13CA0049.outlook.office365.com
 (2603:10b6:5:134::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Fri, 20 Oct 2023 18:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 18:06:36 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 13:06:32 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: Fix copyright notice in DC code
Date: Sat, 21 Oct 2023 02:06:24 +0800
Message-ID: <20231020180734.559121-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020180734.559121-1-stylon.wang@amd.com>
References: <20231020180734.559121-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f72059-67f8-44eb-1403-08dbd1974d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDFCxv9kiCfYIFwYwIKzgLD2OwWwYxwln7h3GWRrb0fDuSWKrFoXRppYc4rsLEb/MXvJo0iU1N4vMXIBcstP29ZVJNHO8hH3AtepaCVbgMF2vx3gdEa/lR/sYOJNfKA26jc+Q3msOaiT2wwcwfSVOjDM1PQWWqtPmIdelYJKT9A5BBp4O/1rk3DnbjgT2v8pfk4Hlgfdz8dTAMcBscyggbJIt1PobNtUwInI/u1wi5sPl5FPAlg+08nkKAONUu8fu8q2HnkMjRa3ksf4G6L4Xb2L8yonBYZjLNxoOlwm290JX5aOGe/xLF4Asn2m3V2SA2Zs7z36t3/yWn/+bbfYUvYti2BC7u7FF8CQ0h5GkFcubSjRyebIMJCn8x2QieoPogvPnh7DxfU2jBP4Qzms5pXAPRgo61I51seJk8qTmFt5AUCHs6CQXFhP48mLrrkbZgA9a4KBVD5+O21AH/0M7A5cN7lO6CxxQpRmJ8EgIqIlrKDEduXJRHPBVLmtItHvdVQ/eTIw89XKhLUJiHyDQPgRdxrzaLk1cWQYAep2Ec1igcqHLNQXjhMR3/Ypm+01zqHeFJ54LN5o1IkmUjVnDQlP/37ch0rCHgcWzZgV09JCgF+Kn7kgrTSJ+dvaIOhfaOzsZPXQtl3FK3L3Rb2Qil/FIeKiPY9DwfNe4O5It5f1wutlQRziuv6uv/liznlqalCzIIAMqLMBhzBV1kuNZv0hd9EnA4N6bmQHBUMQZnyBFKBNt0hdc4joBbs+JxKJ8vXDffznRWbAQ+tJnasc3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(66899024)(2906002)(47076005)(336012)(426003)(36860700001)(30864003)(5660300002)(4326008)(15650500001)(8936002)(83380400001)(41300700001)(44832011)(8676002)(26005)(16526019)(7696005)(2616005)(1076003)(6666004)(40480700001)(86362001)(36756003)(54906003)(356005)(70206006)(70586007)(478600001)(82740400003)(6916009)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:06:36.5507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f72059-67f8-44eb-1403-08dbd1974d11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
Fix incomplete copyright notice in DC code.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 .../drm/amd/display/dc/dcn303/dcn303_dccg.h   | 18 ++++++++++++++++++
 .../drm/amd/display/dc/dcn303/dcn303_init.c   | 18 ++++++++++++++++++
 .../drm/amd/display/dc/dcn303/dcn303_init.h   | 18 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.c   | 18 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.h   | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h  |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.h |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.c |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.h |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.c  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.h  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.c |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.h |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_resource.h |  2 ++
 drivers/gpu/drm/amd/display/dc/hdcp/Makefile  |  2 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c | 19 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.h | 19 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 ++
 .../dc/irq/dcn201/irq_service_dcn201.c        |  2 +-
 .../dc/irq/dcn303/irq_service_dcn303.c        | 19 +++++++++++++++++++
 .../dc/irq/dcn303/irq_service_dcn303.h        | 19 +++++++++++++++++++
 35 files changed, 215 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
index 294bd757bcb5..2e12fb643005 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
@@ -2,6 +2,24 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
  */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
index 39cf7a50bd26..edb4d68b8187 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
@@ -2,6 +2,24 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
  */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h
index 66b1e3604f07..4949981126d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h
@@ -2,6 +2,24 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
  */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 0d91291a54a9..d7fc46db83de 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -2,6 +2,24 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
  */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
index 9c7d79540900..37cf1525820b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
@@ -2,6 +2,24 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
  */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 996d8c1e9d2a..96e45c9efb46 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -1,5 +1,5 @@
 #
-# (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
+# Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
 #
 #  All rights reserved.  This notice is intended as a precaution against
 #  inadvertent publication and does not imply publication or any waiver
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
index 84a9afb7098a..3341ef71009b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "core_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h
index 17f5344994f0..09b84307cd9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DCN35_DPP_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c
index d7915c96bcd1..71d2dff9986d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dcn35_dsc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h
index c19c2e022f12..133ad38842cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DCN35_DSC_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h
index 877f93c8168e..886e727ed080 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DCN35_DWB_H
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
index f8e63bd541bc..339bf0c722dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
index d57ed580305e..54cf00ffceb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DC_HUBBUB_DCN35_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
index 2ae7b151b56c..1ed58660779e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dcn35_hubp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
index a8879c3db447..3d830f93141e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DC_HUBP_DCN35_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
index 534223dbe595..296bf3a38cb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dce110/dce110_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h
index ccfc28225cff..b67015032c35 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DC_DCN35_INIT_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c
index ea1042cdc88d..4317100564a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dcn35_mmhubbub.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h
index e7b5b6703e73..098e13e07272 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DCN35_MMHUBBUB_H
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c
index d79e8c6365c1..3542b51c9aac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dcn35_opp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h
index 9dd21b104287..a9a413527801 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DCN35_OPP_H
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
index b0c068240a94..a4a39f1638cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dcn35_optc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
index 7e7a5f4b85b0..1f422e4c468f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DC_OPTC_DCN35_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index e62a192c595e..0f60c40e1fc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
index d073ce5cc6f3..3de240884d22 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef _DCN35_PG_CNTL_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 99d55b958977..3edc57acab78 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dm_services.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h
index 5ec70d46a38f..99aea102e3f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef _DCN35_RESOURCE_H_
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/Makefile b/drivers/gpu/drm/amd/display/dc/hdcp/Makefile
index 4170b6eb9ec0..c1c47a6cefe1 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/Makefile
@@ -1,4 +1,4 @@
-# Copyright 2019 Advanced Micro Devices, Inc.
+# Copyright 2022 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
index b48b732aa647..3bc56ac346f3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
@@ -2,7 +2,26 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
+ *
  */
 
 #include "dcn303_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h
index 8b69a3b76c11..7fdfc4175f80 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h
@@ -2,7 +2,26 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
+ *
  */
 
 #ifndef __DC_HWSS_DCN303_H__
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 0e218f9e2a86..d3429134b2e3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #include "dm_services.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 14bbdb0fa634..0dff10d179b8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -20,6 +20,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
+ * Authors: AMD
+ *
  */
 
 #ifndef __DC_HWSS_DCN35_H__
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
index 5171d04519ee..4fb9cd6708d5 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
index e09ca4594ec3..262bb8b74b15 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
@@ -2,7 +2,26 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
+ *
  */
 
 #include "dm_services.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h
index fd64e3848ff3..be8fe836b3f1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h
@@ -2,7 +2,26 @@
 /*
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
  * Authors: AMD
+ *
  */
 
 #ifndef __DAL_IRQ_SERVICE_DCN303_H__
-- 
2.42.0

