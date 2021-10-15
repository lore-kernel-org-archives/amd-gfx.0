Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A31E61041
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A31E61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81466EDCC;
	Fri, 15 Oct 2021 18:44:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C126EDCC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYwIsQUDUaSaZ281EQQQMVjwuu4Ktz5HwKQ51A2O7VJGtYPXFpH6vx8iz2qmDwtdAI5njU3nNzGXtjPEBoBGD2ofVYw/q7n4wZpRgnoetlK/DhwF/KLYFJpV6RG1QuctiVyUNcaHiaaG/Ql72htsiemVDhM7LIuJIdfKKHvOs0w/HKBZ+oBeO7/10nCZIcTKIbkO5Bn8lZSERC5yUuGOQ7LfNaV0EKzL1pP8NrRFp97R9qLWeSVgwXgrsBRYRdf3/V8b7N6mz1Z8BlQvq7aucHi6PbjuvVs0fArmZ8a6MuSbrRM3AYoyWyvZqvMRPXRF9rywkkr3ZmLZoSKiJjWviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+Gy5Z+LEMjeeri2eQSSaL84Kxh2teFUiHar6EDPKps=;
 b=IQVUm3qN/YIsLJxzuT3ZZCstx1bvWH8Y14BimFS+W5SmeA0osUhqSe6JND+mhbofFntE5TRcVK/M90ytSuEmPqg+OIEhYpx1NX0+TF5FqT2AMsLyajjrnZnQvz6BIwx9XNyJvdRmHmJ7T964b0rV4uPqkw1PZYKsMkzNh/Qu1L21KoxbpukN0FZVbGxvpP+kiYF5MAEgs5jH8ouggD8tGRiDEQJFYFztw7cNqf4+3f17wmoTeTLElW1kvIR0mozrZMm1XS2+XeeZYKiBd0OBU0rTGqouXgtZWRq/XvbAabcqcEeFtRACmjrDDYkzZbadfQ+6j9Ytyg3Gcqx+fXvPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Gy5Z+LEMjeeri2eQSSaL84Kxh2teFUiHar6EDPKps=;
 b=jKzUqTFRF9wo88itUkEIQ8GB+zGY+2mLNzrduCVP/b3O9ch/eQkhv9gK771vVT81DjcG7VAyuzzt1XvDKPMmVmkgpCaRKtM7lefI/7LzaMCOJx3BCL8NhO8lWi7ZzRm36TPi4GHyVVjhwuG4qb4dIr2vATERPDtrYjyJPRXLK+k=
Received: from DM6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:5:80::16) by
 BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 18:44:01 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::44) by DM6PR08CA0003.outlook.office365.com
 (2603:10b6:5:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:00 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:58 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Dmytro Laktyushkin
 <Dmytro.Laktyushkin@amd.com>
Subject: [PATCH 12/27] drm/amd/display: Fix prefetch bandwidth calculation for
 DCN3.1
Date: Fri, 15 Oct 2021 14:43:17 -0400
Message-ID: <20211015184332.221091-13-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58c1316a-9576-4b2d-6a40-08d9900bc0ff
X-MS-TrafficTypeDiagnostic: BY5PR12MB4225:
X-Microsoft-Antispam-PRVS: <BY5PR12MB422592640FFC8FF5B6964E94F5B99@BY5PR12MB4225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3R/9J47W93SowZovF/OyZ1n8MfK4ZxvKpZIvjGgsWRHbldrsYZ50QHs85M9JGisXfkTAhrP3gCVLA0rObN+NLbIXg0iGG1XunaIGg5QPP0EgMsaVW45nZH3tsMyTHCoO6XqecOGJ+NG3HNI/pfXTphKX41WKcbVl36w23Lu2HX7jUVQE1ixKmT5tLW3AFkOMKPWsSjkkO+G2eBW9fdL8ouR6xA0mvQYPPTD8znQHf5soLXA2SIPYCoq5I/WwCqbimFLGXe4gDbi5saiih+R54aSmHRTrFnlJG0OQXDTRynHBj/eJ/VbUSP4bkmYmk0aVmlSQkhum4sAbF0fwBjtx8n0PfXxJiLizeVYQL/MfokDKbc11nfQ3psq+0UnRnDwfjP7DnMOmMTLq5i7hF4kV7aokjggkLJqq5ikR/EjLOiO/L7Y3ZasIuMnngrYZFG4PVmkgbohVkwi+CEoNe7NelmPzbF1RWUS19YYO2lREwre2LXv393XUv34xuez+XenO9HKjMdgzt0X1b4ZlKviet55bS6VmA1XtUkeSxMZnP8hRVK745DHY1aSEw8POGnRwhOJV+N2LxTJ/L1TUB3JXSR9Rvlu297ZXLFgEc2RE9gVp7FqoiQoT8YPyY13fBicqnXhLrFuSWTCBAw8DRJbdYsmXIxfh6xN2Aje02PTqIW/y7wW78Qy7nkvFG8/yNd1D0/WmeMJOhih+URSo7EkIKDGzDP2vH2Sgsopf++aX/AaNg1At1/P+A/H/DlwTCU+4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(82310400003)(4326008)(47076005)(8676002)(1076003)(8936002)(44832011)(6916009)(6666004)(2906002)(83380400001)(36756003)(36860700001)(508600001)(5660300002)(336012)(316002)(54906003)(356005)(70206006)(16526019)(186003)(81166007)(426003)(26005)(86362001)(70586007)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:00.5816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c1316a-9576-4b2d-6a40-08d9900bc0ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Prefetch BW calculated is lower than the DML reference because of a
porting error that's excluding cursor and row bandwidth from the
pixel data bandwidth.

[How]
Change the dml_max4 to dml_max3 and include cursor and row bandwidth
in the same calculation as the rest of the pixel data during vactive.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index ce55c9caf9a2..d58925cff420 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5398,9 +5398,9 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 					v->MaximumReadBandwidthWithPrefetch =
 							v->MaximumReadBandwidthWithPrefetch
-									+ dml_max4(
-											v->VActivePixelBandwidth[i][j][k],
-											v->VActiveCursorBandwidth[i][j][k]
+									+ dml_max3(
+											v->VActivePixelBandwidth[i][j][k]
+													+ v->VActiveCursorBandwidth[i][j][k]
 													+ v->NoOfDPP[i][j][k]
 															* (v->meta_row_bandwidth[i][j][k]
 																	+ v->dpte_row_bandwidth[i][j][k]),
-- 
2.25.1

