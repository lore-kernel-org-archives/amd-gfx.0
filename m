Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEB6C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F53810E405;
	Wed, 17 May 2023 11:40:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BF010E405
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwFhqSqo6HQ6BYfZ+JDLOGDoVowPRHqS9qWfVnYfFV4Swle7tgW5D51x32eCaTBxFUawGLhWk/jlYj1TNWaTqDWCCjm+3774tVuc3K/6iwYybKzEhpQFdFUxsWsfJ7VuFiqi8hRcro0MZSalmwN9ud7gPs2ydRAfxi6/ib0ayIPAJu6cnTp0KZ2jgk72DZw1YyPJ2l/C3YHjkdrO5K89Joj4D8iY/l9r2des6AfgOuAtqA8cpmTU11FxcZ7OcdGlhOOXQKVYFcEM0y6w9CIRPtbDS7NFqm8boceF9wXSBBFvVW+8eGh/DE7fGjsS3/MgPgLik1Tm1Vrlz6eXHJRFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMd/5+yT6faZGQemRQLLDba3y4oy/abR3ul8zIWcrd4=;
 b=hKVh8D1LvO1bDMuaEPZW13sXLtLbNNIQYJQfcJhzdGgcLdkzhjd/ZWuvBmNz84aLe9e17ueul63xbAjhGVSw6/PyVFxzWZ9pW03IeRDNNHnrv4fCglqX+9FQMULP49VKVVGfFQU9cMiBWABv38yzZdtVoJBFa9w1YmpBtEU+sG3MG39Gb0LBACbhOi5PwHRem0+ucsHl70b9QIHL8x0i8WtWgCR00raFPyaiO2qLIvhqJrmQUSJSXlq3K2Gr4C3SnGK9RHdp4xfB/UCzB+KBbY6bMaKYCEdMJP4UWyrNtlpkn84aOzTt0F0g4r/QQhY36AAfTbft9zgLAXUQbvMjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMd/5+yT6faZGQemRQLLDba3y4oy/abR3ul8zIWcrd4=;
 b=ZpWDtPb9bLb23IP1IgSeMPc7RvNOxQD+A6x30gbYz97SCIqPsDMO+IkFKNAX+LWjOYf67d8p53O8bnpqXNLa+8BMWye9UcdTeVVjK7qK19Om4SM9dzmpg09Oe3QAv+IAk8qwAetBNEYzWFKwC7Qef1pMUr0pVbUFAKPp1GiGdXU=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 11:40:34 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::74) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 11:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 11:40:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:40:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:40:32 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:40:22 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/18] drm/amd/display: Reorganize DCN30 Makefile
Date: Wed, 17 May 2023 19:37:21 +0800
Message-ID: <20230517113723.1757259-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1f350a-84fb-4f72-e0fa-08db56cb86d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lL/N1/TJmMBzqhC5TwUNvUpo6P7gTIk0t+HGbYkd6ouiQ+o7hTtFwGdwMRzhgBIMS1ejPORPBVINy36E3YhCmRWLsFukhy81I5HlDMJm9lShe4BYrsB0Z31DO2oC4RqO0XH2blWYsN+a/1O/MzEGS13k17POjVmMTk7ttMx0NziewBWnZqy/QDtyq37pCSk3ycwIipe+b1Sk4f+TuntzCJaV0mxRC6CbwR/0wRWxhNm5/vtEC0pMh1lV+oxEb4XQArjJzzQ71lavLA4F5oRA8S53+p/k5MIfPsyUn6WJhGDMDzFM+9thXkjUSge51kgr/DCAcWv8oiGfbVXkEVcXxzYufXkzn5GJVGSTrF7qjo6JwYVlUrIvfh0enQJjTtc8dOElmyPoz14hDlgSi+NsxKTcN1bVVRMsuZOemdU77YG3MtcJv54OrSzvIlYmhI6OQzz8a+DRtEzJaAZjoIjae/wcY/GIzC94lEj0WUb9CAodyZWyeRmT2FIYLmvmkZ0WQ/8s0BN5QeIkP/vEeEe5EL0wZ7wFymgDyI2BRZOV7PFFwyqPiPxrvWYvW8wkVeHoNVJmX6cUpUhGv5zqlcqqwJj77p7M7APokO/1JNoULq6M3DRtlNtyqOYgUs/7L9CT6xAzr20QTfHYr8Z2HpkWu8zLGII3xLBEwfD6DNl3mcbmrmpS6v2sIAzG+X5WL4McWBxDpfBXs8KT61zO0HWnBEwty676Tl+TBJ9nvqAj/g1RfsMD53XAs45ZV/JoryCjmblI0DXaVllhAoQGCWkpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(54906003)(478600001)(41300700001)(82740400003)(36860700001)(83380400001)(86362001)(1076003)(70206006)(26005)(70586007)(186003)(316002)(6916009)(8936002)(5660300002)(8676002)(356005)(40460700003)(4326008)(66899021)(36756003)(82310400005)(2616005)(2906002)(336012)(47076005)(40480700001)(426003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:40:34.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1f350a-84fb-4f72-e0fa-08db56cb86d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

DCN30 has a lot of files in the Makefile, and adding each one next to
the other makes it hard to read and can increase the chance of merge
conflicts. This commit just reorganize the Makefile to put each file
associated with DCN30 in its own line.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 38 +++++++++++++------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index b7c2ae9ddfda..4a3e9e47b6b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -1,16 +1,16 @@
-# 
+#
 # Copyright 2020 Advanced Micro Devices, Inc.
-# 
+#
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
 # to deal in the Software without restriction, including without limitation
 # the rights to use, copy, modify, merge, publish, distribute, sublicense,
 # and/or sell copies of the Software, and to permit persons to whom the
 # Software is furnished to do so, subject to the following conditions:
-# 
+#
 # The above copyright notice and this permission notice shall be included in
 # all copies or substantial portions of the Software.
-# 
+#
 # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 # IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 # FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
@@ -18,17 +18,31 @@
 # OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 # ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 # OTHER DEALINGS IN THE SOFTWARE.
-# 
+#
 # Authors: AMD
-# 
-# 
+#
+#
+
+DCN30 := \
+	dcn30_init.o \
+	dcn30_hubbub.o \
+	dcn30_hubp.o \
+	dcn30_dpp.o \
+	dcn30_optc.o \
+	dcn30_dccg.o \
+	dcn30_hwseq.o \
+	dcn30_mpc.o dcn30_vpg.o \
+	dcn30_afmt.o \
+	dcn30_dio_stream_encoder.o \
+	dcn30_dwb.o \
+	dcn30_dpp_cm.o \
+	dcn30_dwb_cm.o \
+	dcn30_cm_common.o \
+	dcn30_mmhubbub.o \
+	dcn30_resource.o \
+	dcn30_dio_link_encoder.o
 
 
-DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
-	dcn30_dccg.o dcn30_hwseq.o dcn30_mpc.o dcn30_vpg.o \
-	dcn30_afmt.o dcn30_dio_stream_encoder.o dcn30_dwb.o \
-	dcn30_dpp_cm.o dcn30_dwb_cm.o dcn30_cm_common.o dcn30_mmhubbub.o \
-	dcn30_dio_link_encoder.o dcn30_resource.o
 
 AMD_DAL_DCN30 = $(addprefix $(AMDDALPATH)/dc/dcn30/,$(DCN30))
 
-- 
2.25.1

