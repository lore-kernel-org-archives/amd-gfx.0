Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5F3FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130CB10E6D9;
	Thu, 27 Oct 2022 18:42:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F2310E6D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGq6EK2Zv9iCsQbrBSDPO/b9ee28UcBDdQXsF2p9g6k3+WAQTJZaqc/nc+RhnFR+8/6lxKzSbhyG6EzuMYTvec8saOD4Po77gFI2E2uLFF+pYiy6TXTrV1HwJxCPpGQ6PEQP6iFejv78U+6Yh6l0C0sawX3G76wPH/Yf90XwKl3BGkB3D/TwOhBga8V+cNN4t6mjAhag/QatiqMiceK4oD6TzJIrwWjI+si0xHJGiubrbVqlB/z918gsQMH9fNhJf8mINi5gGYJp9mKtsNl70Rb6mvBDn5+HSu8wvK44do8OFXFrT8U+na0GQZT8wcz3TQR0nywRO6ybhjHE9EHjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2i50Qc6unS/Y7SpqlSZZ1gaXu7R3gZvxzS3bmBmV9E=;
 b=RN0bLNBhJO1iVyRCc2wiW7f/NHgPKSbgCFb6ZYIWQ1NXBqJL4aP7e1WMqCz+297E4vsGrgoWIG/qbjqIadtHicKTl/bMOXzu0jYtLWRy+5DihGP/DkQ//Ny+52/UAcDRBmDgfsc9fl0Bnw/A9+A23IevIBr3Q6fwoGcIJESHFGIRcclS+sTCIxDAh4/tMblxn9R/8GMKthLPtWTduE+uwIBR1VKe2eXHwC/sQiiPP7L8yIBBl4YWXapclj2m2qZa6rHf9oEjK4L34LZBxLVxHe2+yPq1VpWQ6xFq38L/UJl121T95It2NCkX5FUhSkEUvkF6aFpgClvR65WLLul8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2i50Qc6unS/Y7SpqlSZZ1gaXu7R3gZvxzS3bmBmV9E=;
 b=SvpVIii64hN/Q3mvL4Keiw14SoD0teouoDwu/hRnu5SupXw7F446n5t63ztcXndp0k81AcVfl3t5uofuKmssGQKMaocA2ADAFGQzVPEWzdVgocDz+usDawm1BGxEbfbqpwgpsoNyGzcWxhRV2RwzkM1olxpo/vKGU6xS2qUbJ2E=
Received: from BN8PR15CA0054.namprd15.prod.outlook.com (2603:10b6:408:80::31)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 18:41:53 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::59) by BN8PR15CA0054.outlook.office365.com
 (2603:10b6:408:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Thu, 27 Oct 2022 18:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:41:53 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:41:51 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/18] drm/amd/display: Round up DST_after_scaler to nearest
 int
Date: Thu, 27 Oct 2022 12:35:39 -0600
Message-ID: <20221027183543.1117976-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: cab0c0a2-90b0-4843-5fed-08dab84aeaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiUU/6FIfxkW5wF49Q8vdiwoR9YbFLFCn7xz8LDzzqDqgnQ02LhhZO1hSACNtZE322Jw40FUdVWfPAQ3BydtI4+qfery22+CWTOnqdN1T97+6SZItOFAE+V1jlwO3MM3tW4WPj1I1XFM1W+Hzd8JWrPwu3S5ZUhXw5E03rzs/9B9wehRm6zN/KM/UC+U5lc7iNBC4wWmdeO9idoNQS7+FdmpjXjapr1RXR7EQCIdUO0HouFkYfZ6DMcdo3HYBVERCRZCz4eZMss7Bgvb7/eC5hSdi5xW7Yap4cfdr1L4Y1xAiDPsqF+9PyJmKB3FTwhFBNN8UohxhLrtMEPG9a8Imi30on/XB626inIVutunJWqRNkIVXW0MqVxUDL3V1u/k51+SBlkapUoted5xUQX4JcrZl7tYEjjW5wMpXjlyhlc0Tx3HAskTGfcNeWEB++NPfkSYNJNUpkI9aetpaHYmvY68epWLQl78U8HScH46UtcoLkrXc0KV1f9RhgBKmHv3LfBCs+C2SzFHJ+wDmSd3z+l/rdqGbxV7F8QTi6Zw77MMiygiXl48b1Ft26WdkQHG8Uf8ZMQZVXxmmXxP+YQXB7lp3F6fZZa00/v7qBuJ2UJzNSIK46gou9+m1dhrrQebbRl5h+pqW/S0XyvxA0xQMsjtTOa8jegeZ7PWrmrGqnLGV+h2FX+JtouMzkwCfhTrBc07wJkjnFhaNTrMmfV8EQZ8JHV4zqh0wvEnybhTZSa/ndavGr+wqQwF6PZ5b4bxikn4M3znfMDQGGSR63INSVQ2M6iYbjqL7REztLuA6F8H+l8NH/S7PrLBXkJK0+cN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(6666004)(478600001)(86362001)(2906002)(40460700003)(82740400003)(36756003)(47076005)(36860700001)(7696005)(40480700001)(83380400001)(2616005)(186003)(426003)(356005)(82310400005)(4326008)(81166007)(8676002)(336012)(70586007)(316002)(70206006)(1076003)(5660300002)(16526019)(41300700001)(8936002)(54906003)(6916009)(44832011)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:41:53.4459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab0c0a2-90b0-4843-5fed-08dab84aeaee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The DST_after_scaler value that DML spreadsheet outputs is
generally the driver value round up to the nearest int.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
index a1276f6b9581..395ae8761980 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
@@ -291,8 +291,8 @@ void dml32_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 
 	dml_print("DML_DLG: %s: vready_after_vcount0 = %d\n", __func__, dlg_regs->vready_after_vcount0);
 
-	dst_x_after_scaler = get_dst_x_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
-	dst_y_after_scaler = get_dst_y_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
+	dst_x_after_scaler = dml_ceil(get_dst_x_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx), 1);
+	dst_y_after_scaler = dml_ceil(get_dst_y_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx), 1);
 
 	// do some adjustment on the dst_after scaler to account for odm combine mode
 	dml_print("DML_DLG: %s: input dst_x_after_scaler   = %d\n", __func__, dst_x_after_scaler);
-- 
2.38.1

