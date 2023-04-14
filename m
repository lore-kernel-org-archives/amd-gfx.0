Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ED1C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D60E10EDF3;
	Fri, 14 Apr 2023 15:55:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFB410EDED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnFdLghkvHf5gUTdTUcsZAyH6sF2P13RduYb9MpPbbN43yjCRkf+QYr2Uoad462eLDu4EFtinbh1QOoHpy3HEOifkbqufp5p0ftFR/Adq06ufAUTAOLKaChpVa6wAcvn9cAv90Fw/8AmtK/BUDvP+Ld1GBrTZAx0zQt7kYsO1IScAipvA6nDm25ea8f6zF252BHoIvkYzUz88M6VN/KtZIf5E6fEEXyxAP6oeSO9E8mF/+pP6tXhCBfsVjmdYjEPkImfQbFLX8rXauq5Hba5OiiWK5Rf7eEmfJXXg3M1wYTGouZagSWSjygi/8fdRLY5i2buuHVo5ZdkvzKU2PHZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcuVBqEcuvYEYA2KyIKa/DLPpgrt+us7cMthu0lYLCI=;
 b=JHQpHXW2YAzSRErr2iXC65iIafBCMrmd1+1bj2KPNcGmsLjzsNkQabsOxl0mOQHAxZWOS3aQ4Lyo897khgrDrWGkvjt4MokKA7xDQeIQ/CArddqHRESapUb1RHea5BC7VJ0/Cmn2rI/tjGGcE13UAMs1FKHFHDSemXUaGFcr/IBMPk3XaORG1e6UWxYHXPBY7jR7DwLAKzin3NAjxpDnn8OazLQJzE+4um09r7e2H/1ysNbXX1rgV6jKcdvZPDH7yzaFlGaohcWBGvBVsnkeLbMB1gNgDYWlszJzYRAdvkDm2rL0t4bdBIdyQ1TwoJ8X8llfoeyTFPL89/np6ZUt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcuVBqEcuvYEYA2KyIKa/DLPpgrt+us7cMthu0lYLCI=;
 b=RnGWCxht6V4McN+mAUNQqVxHIMY0I9O5e0fFoMBDK5uD4XWjvVU0pb2aQsAzJIyFAv42H3KdDmeRjJc0XyMDrVPLf7fyqId8lmM+UVqvgVNzhl7J/OXslS4vVnkmgervrI6Gc0lPS6FZOS+8JI/Eotl2B+s6g6+0X5vqHHE8hoQ=
Received: from BN0PR04CA0117.namprd04.prod.outlook.com (2603:10b6:408:ec::32)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 14 Apr
 2023 15:55:10 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::58) by BN0PR04CA0117.outlook.office365.com
 (2603:10b6:408:ec::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:09 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:07 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 54/66] drm/amd/display: Limit nv21 dst_y
Date: Fri, 14 Apr 2023 11:53:18 -0400
Message-ID: <20230414155330.5215-55-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: ef73844d-eaae-4dac-55fb-08db3d009fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9okX4ece3hRRFbgjtw+70U0GK+vizsB3YBoMiyN0DzBZkGiYvfGDZkv4KUjXLLtpcUI9fQM8HANPBuR8EeJXrowfpZWwiVfIQZjcKIs/Fca7uLOPnOzlCyKIdQ4JbHfSepYizhrgmrcaXVvtu8AM3LYRyJ/VNaYaw/sCU/+cLtAwGJazWAvPCswZQVT3s/n/JftyfbIlj2oqNqX6llKOeyDZE11WmS78AR8ZyYsXAUCB07gB0GifXn154fGdqxrEiHnhyl5DI+41e3qNZTwkatbPqgPopGxHh7Y6vumMTjFBTNpiuD6YOj8QB9r2VwgoO+5aY99Rrnq/4zaNYNRun2BMR5wGVdzs6cH68SVnwsTvyMqeRZWcE1hcVy9DvCEBauRzUr4njPAxe06t6cfmx1lz/xc09FkD8nHScUmjT3vmwd9IVVAo4WNxZHxTgn4NjqylHuBFJGKMev5VdcGliDEcYJ0GG7Ij30Lw4XjhjKY/nQ65ZVrPXEtqcmg7mulbR4Xk3MN24QBVyo8ctP++nFR75QxuzppP6Rg34QdRWkTq1VcF3Oy2QIWgStRAm8h+/mQ5ocqUK97Y7Jh2yazOqjAlbaZOKzkD6hsjyiciLo6zy8YmnTyOMN4gtXl3xg4jziXRvQCGok375UXBVKKa+EWkAEM97BAmF9d2KU/cj9f2JaxfnkdJjb269DDxLRdTMpwqlI56A2sp062I6LKe1imFQvLpSxDVczSbnEwWKX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2616005)(16526019)(26005)(1076003)(426003)(336012)(2906002)(186003)(70586007)(83380400001)(47076005)(8676002)(70206006)(4326008)(6916009)(54906003)(41300700001)(316002)(478600001)(6666004)(5660300002)(36860700001)(40480700001)(8936002)(356005)(81166007)(82740400003)(82310400005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:09.2654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef73844d-eaae-4dac-55fb-08db3d009fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Dst_y can become negative in extreme odm 4to1 cases. While not strictly
invalid, this should be limited to 0 for rq/dlg/ttu calculation.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index cd3cfcb2a2b0..0497a5d74a62 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -980,7 +980,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 
 	unsigned int vstartup_start = 0;
 	unsigned int dst_x_after_scaler = 0;
-	unsigned int dst_y_after_scaler = 0;
+	int dst_y_after_scaler = 0;
 	double line_wait = 0;
 	double dst_y_prefetch = 0;
 	double dst_y_per_vm_vblank = 0;
@@ -1171,6 +1171,8 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 
 	dst_x_after_scaler = get_dst_x_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
 	dst_y_after_scaler = get_dst_y_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
+	if (dst_y_after_scaler < 0)
+		dst_y_after_scaler = 0;
 
 	// do some adjustment on the dst_after scaler to account for odm combine mode
 	dml_print("DML_DLG: %s: input dst_x_after_scaler                     = %d\n",
-- 
2.34.1

