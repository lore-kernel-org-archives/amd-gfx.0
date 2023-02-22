Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270FDC64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E32810E414;
	Wed, 22 Feb 2023 06:43:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F3310E414
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9XSlsHtVeaLjwNTe1QAEFEOkGRhikGqEUSBNbAGM6ihj507UMDsZdomNcptZ4HrTynAzQduJ91xHvrqKl5McfQe0zC7mpWw4KUGmfLEnsCa9jK/Tqh4W2oTXw7Oeu8rQ5dFNotP9SFBYfsK4L4vfhVgJHna4GI25A/Ap1/1rCiIgAYyPDRwxImdMk+F1YbijrZ4uQqo2zKYQBaH7/bDY1hLBpiX0N4hRo+r8WpAnd5ncbKCTpd9z4VUpDu+DI+62tHQhkwDQJMTe3q+XWFI09j6aVOEPqxXD8TXPNJTKMVwOTB7IEfU3NSIt5TPR1XBMDsMVavSXS4UJyxUMSFmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USwXdFgvia2qNkUuGzgOhozylaiz4hzYTSejSqXkk1Q=;
 b=SLVEHNbJipA+espx99fuN8mZgVz7BnhN4XIOi2ETACUmarNHo8g9iXpGDQoXkBvfFPAwBF3tG15twKzqRu66oIJzjNFj10FQWWdc91/wCyVl+n9xOqAoUSO+dqZJsJ22+4Q8IrbvpQiuiFFKo5gO20O5HCEfvflWxXLlh026qThEI5oEjh/e4OgBYfkEDmRx9p5jzJbJFzELhsTadSeu2F8LFhPV9DID7N+7HOgm7wHzvl3ydOP4R/Sg9jo5SXixE8JnDQWcbGNJIGEOgfMRVPEn34oFXsNAjON7SBQRWPRbpSy5dFlYBTliQe4EKbY4LB7tC0vUMIIhRi+gg8lWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USwXdFgvia2qNkUuGzgOhozylaiz4hzYTSejSqXkk1Q=;
 b=mnhwrJV9vxmuzF4d8D2K9etLXSiNsIvSGEOUVtNxUwn8L8vzq0fsNffZmKzoLJtYOrTqJXXQS1B4GBI3AQ43kS1lPmgHN8nln7ExHgkVEEqNZaartvfiTNpG45+b3XnIwa/QqP2UvM5L9FOYwBm72E5rxrTiB7T4UqtyOMWdCmU=
Received: from DM6PR10CA0028.namprd10.prod.outlook.com (2603:10b6:5:60::41) by
 BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Wed, 22 Feb 2023 06:43:12 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::a4) by DM6PR10CA0028.outlook.office365.com
 (2603:10b6:5:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Wed, 22 Feb 2023 06:43:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:43:03 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/20] drm/amd/display: remove empty dc_link.c
Date: Wed, 22 Feb 2023 01:40:38 -0500
Message-ID: <20230222064041.2824-18-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|BN9PR12MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 04357131-34c9-4e8a-b138-08db14a01121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQ/1S8X999JtMYe2AH/Lcf0a8FuZI3OdVCMZAmiKiNkbbpPW3Xxg8CBGKTQUN/0NIwDM/EAvjilEkf7C7sJ6cFqj+8rGL0mc0NiuBtGIgZX/S5hwp4HOm6Tu60qxhbULzfjP4PZj4pQtU5GvXQJz+VjTuXhxYQ5zkPwoyem2MVkffmzXCqvPGq1B7XEFlMqV1C7oaLhft9+I1IIAq5wnF4PyyF7jATEaIRKXyxzwxm5eCAccuTmHqwNiCNuqso3kG8SRtjSWZkRW5PiZpXLNrN7bTKvOZITI/4+gsdw7rmBUE08Y7vWVfhhOVLWOnBXcUfNt9vLE7C/gyx5O7QVihIai8qadVHWlCHFbxMqFxVlqgRnOEBGHBZR916hYQ4RjXJIc25C0T4lApyOGTGXbc73YumQCvQ7waAH2HSIspblIdHF9ebWIx8hXJi0IQ8FgOupip+F7dA2MhRkqzIHWmheps4eNUPL4kIQahcZRELE9aWOiWgc2zCI2I8bPhGJepxFMKaIY1lb3xl9aO9lrckrUAoUOa/e1/+eS3xpckExhDnnnQVQ1xAhnWMbUPZbwYM0REYX3Tt4sHj1YVo9fAb6aaxyU0LOdilfbkwxdiKPkuoN8YHhdtjowKlIaf5bhQJMo3z7Cg3yY2R48QscIVYK1Jt3j88SFD3YAIrMl+bb3FUPAEvDCAHFmyuCNCmFBxsNPIcAi+5N19fC6ISf6fVW6deui+szTZiHmkc3xT4A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(81166007)(36860700001)(2906002)(82740400003)(8936002)(66899018)(44832011)(5660300002)(54906003)(16526019)(26005)(186003)(82310400005)(83380400001)(41300700001)(8676002)(2616005)(336012)(6916009)(356005)(36756003)(47076005)(426003)(70206006)(4326008)(70586007)(478600001)(40480700001)(86362001)(6666004)(40460700003)(316002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:43:11.7019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04357131-34c9-4e8a-b138-08db14a01121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
We kept an empty dc_link.c file due to external
build dependency. Now the last build dependency has
been removed. We can safely delete this file.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 27 -------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link.c

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
deleted file mode 100644
index c26e7258a91c..000000000000
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-// TODO - remove this file after external build dependencies is resolved.
-/* NOTE: This file is pending to be removed, do not add new code to this file */
\ No newline at end of file
-- 
2.34.1

