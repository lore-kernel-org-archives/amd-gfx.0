Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C678C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 18:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD26010E0FC;
	Fri, 20 Oct 2023 18:06:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBE910E0FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 18:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkr9wU4RycHpIOjGU3/O3tCLYpaKdGyMMiCrX1fiKfjPXvnsF4+DSKYYDOFUdKQ8rFrQXDt7WT/U9hh5fMVG4I5ujoRgpuh6WxGN/nhxCXQpLYaHKasRZxtMRKtGKkzuJMW1GaqCjAWX3WNqd+cGSKfXURrl9PkqTdqho2D12md3I+5WBQkl28cLFPGQxbGK/LwCQaKECfsS1oS22pkekPSOSEbzYLUVe2u3g4O5JKg5rRUVBlJ6v4+2XMvNKxVq+HixLQ2Kl0rPge6Lc/PurVmaF7/v0v1Nea4gDmhPRHAdYlDFnPlf2f4A5dgfs3Q0iPpvwvSv0hxx3wzAvQSdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLUMoIc0aSZxmD0ES8pyfIuuxmuLbJbBE3A/4UjQRyg=;
 b=JIEn/Yb1qcOuBKiIywG0scGAMpaY6jzWFbR4B3ExMDBkfAiVh8ytwFDlRIpq0AFvKMzIf0Xv/pCXs/LwG/HfKBUqH6OrxC0BAURnsrTCsBtganiYzJtSrkgd4D/nYvZRcgRlpt4H5QKE1DUq0/uDFIUlOl4YhBL9dwOYogSCvhGmzHqX1Mbz/4yufpda/XQybEwv7gTxrp5uN2t9QDeDPZxgh8rzEzlNcZggQHdrm01RoRTKHXYKjF8lrOwoP+wMfjNRoujVEN83u8o5TEDpppN9Fbzgn3dYwTsNy8d5NAwC3P+g7QOJfEud1C6/wn/DvJt1KRrrSrMD0AJB11idmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLUMoIc0aSZxmD0ES8pyfIuuxmuLbJbBE3A/4UjQRyg=;
 b=oxltyqjk2RsKQsIcADP3AiQNrth3xttot8NQKHfnjPNWWlsPWl7k++rYr7UD5tYO3dgKBLs4L5ukhwI5SGKhASmiJ1yP0/oID56dBssAc8EGU2B2oo3xq1d2khmacQFRQFkmPi+FAH7EEkpvaISnKDhewxOxBPqQltjKg0gHfY0=
Received: from CH2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:4e::21)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 18:06:29 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::ab) by CH2PR02CA0011.outlook.office365.com
 (2603:10b6:610:4e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Fri, 20 Oct 2023 18:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 18:06:29 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 13:06:25 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/display: Add missing copyright notice in DMUB
Date: Sat, 21 Oct 2023 02:06:22 +0800
Message-ID: <20231020180734.559121-2-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 53291aa4-1c02-49fc-8670-08dbd1974892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QPoIi8Hj2D7it4HhMTKWalsLczFIGIysaQyPvXlgSZ0Lcj1QNpaQChZa3Xbd2ZA/2igL3sQkGpDySaHWmDSidLbGE9IQGY61jS6XmCY+y77j3etNBKjpLRpKRDhu1cMBHd1hTAp6r04XVDwbPt+bANbRlsdRjB+ZCfGwi0cRRIqB/F12lwfWDrP170EdL76+XKGxYrb40b5lyj9xCo2C/QG19z3Q8rUPHxApz6/btYeQOiCpX89hiJt4zcsqQCd7xlRdc7WrRpzzAG6+u53B9pNQ5P+zsjSHvJheL5C01IK9DRfik/iW4nGNg0muxCVBQ/g7P24YkysL4RUAHrCLW9Tag45UojUu/yu6pjVUNGvSFcVmEUw7m+zQRluVjrHR0ExPortMxdDsBOn2o3VMsMGBo33Cvy0HyB0qg6SYEx2mkmzhJLZG7XVvVgfQSZq7APxPqHZF7feT0zWUm+iw8hXAHK3FNNcBV+qGupqchKUWJDyqb7+i70QqLxyVJ80+GWVTDLNzogojFUUAnAIpJcFHNbfFvwcg6Nk2SL93/CrzsRIOT8yNBafJstYaBY2DQ9gzPbf37wCFFPXvj4aHJchHRSCtQB04MPe4h/GzfATft4KTclFkCaj7nzBPI/cvMoN2edO3xWlMLkeJiWtI4lbevj702C//mxesCEnEspvegyZgloo//SACxcG/fHvnN+/RsOh2poY4N4iG7I7qFGD+E2DFVOkE6IcwE7j9nIbjtIicBJABNd+zV3YRWqOEG89u2ORyF0Qi7jQou9CYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(7696005)(86362001)(41300700001)(15650500001)(5660300002)(16526019)(47076005)(426003)(336012)(83380400001)(82740400003)(356005)(1076003)(81166007)(4326008)(36756003)(36860700001)(26005)(2616005)(44832011)(8676002)(40480700001)(66899024)(70206006)(8936002)(478600001)(6666004)(316002)(6916009)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:06:29.0104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53291aa4-1c02-49fc-8670-08dbd1974892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
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
Add missing/incomplete copyright notice in DMUB files

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 .../drm/amd/display/dmub/src/dmub_dcn303.c    | 19 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn303.h    | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
index b42369984473..878700160fa9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
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
 
 #include "../dmub_srv.h"
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h
index 84141d450256..abe087251cc1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h
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
 
 #ifndef _DMUB_DCN303_H_
-- 
2.42.0

