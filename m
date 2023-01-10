Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98911C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DBC10E60A;
	Tue, 10 Jan 2023 16:56:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E000510E609
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgSbI/NpMsro6bTED+eKh36XsOlBJx9xhCT2kkZKaq/5I0tWqjJgiTnBoJTi1P5EaqNZnKOdkQGnSWWM/2QpNSo7fCc0kRIlrW2+QOLPrPAvWcD2yk4qzrzIc0HfoJwhL94kuYl/kOWyKD9XMeoJPd2n7xZPMQ51ef2V9oMv9YFcxs4rnel4F+v/RCAMcBWkphiHX9+Ek9mY9yzHbJSlybq+Vuj+3/tFLGLPZZNegqRjh15v5DWGJa6mJ7riKacCtqvFVsYP3Y/YYZe0xKMVH/tF+vMA2pnOERnuOPaON2e+qzL9VFKLKhzyniWgBpnzXpz8Gyr+uVHnSxdW/oYLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G50d/e/VGXa0ItaoWnajG6HDwZdyrYeNGndCm1Gq0dU=;
 b=gm3epn+QcXdBjqeT6p2HbvW/Lqx5gIkn9ABZCT5pJRJuQjfsyqDKYb/JTO4NpA1t8hrM5nozFsHA5i/nj9hXE7BOtM70c2MuoTvVWyM/dqzhxBMklxTFPb/DI9W9lglANr85iibI+GFYcvCdA4qy+tbC0pZRpgJcH3CCXjX8iUZ/GKqxx/MGiOdsvilnAzAhObiZnS14g/t/Hbn9M/av/s0InoVCuMnikbB1+6VvkZoRAhCzy+7blsBLF1/fnq6TDM7gDw1vEgUjqW7XB38PoOeBytvz/rnxo5yfjVQ8zBNqFtS/MD2uxpR6TR+DlAUD1FAQ+ECMlOOU/sOuXHn+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G50d/e/VGXa0ItaoWnajG6HDwZdyrYeNGndCm1Gq0dU=;
 b=KY1wvgSVndYBGnWuQZC8BSbXwK467g4oGDGVyEf6MnsjKY1uPsWA4c/jBA5pPoAv1JVhALsGhpaff03YOZORRLCUPJ9nYRr9mpYobV6NdHMVveXku3cTWLzLK58ccA/dmk5jeYjiWg9Z2MDpXIdsEUrHi/R9jUJcUqgaLEsJjYw=
Received: from MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:56:49 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::22) by MW4PR04CA0183.outlook.office365.com
 (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:56:48 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:56:46 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/37] drm/amd/display: Implement FIFO enable sequence on DCN32
Date: Tue, 10 Jan 2023 11:55:03 -0500
Message-ID: <20230110165535.3358492-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: b3255273-7330-42d0-2a65-08daf32baa1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2GLGi2BjS7mzRsxEbQi6pDLaxfwO+2G/P5LJN10mNMdY1RUoXp0QSOIQS10t59ZTK1Ut7nBpZ23ubPHX7QhfUiTyLzhYTp2GireR1nqF290eO/AKPHoGcDzMIc3iF/IeM8jxolVFVGAl01wrTptaGk0KIYGNU8Q2C+dQaCN9dYkmleqRPviSRVjIdqhtuSJ3F+8bYHQ3dxyMPvGaaSEOwYyvcPqnjfsXC7M+CITZ01Bk1Ct3pgIiiWWqhCsHAiVH4ORmvalmwV1HddGs1G2xdMWPBbED+18TWTdnHqUK5H/0AXx5kUa+meeM2uIAMUIQbxJb0tfoYQTVykmUA3M0VhQEoE9zrB4/c8QsCDJg8b7lDq5Ax5WmHMGdEJGjUfu1iaZYY1LbYzfhPza3vauh4YP2wzKIPEf/BWkYdJyJNhpDlsrTQo10VhhoFpCQ8NxALK/l9W1Tk5PY38VNbqMoz7kkiObJtT+8Ct+ENcsD0Ln2vdVRHSMcCFLJkZWmbqxJK9ptACPVhjJ9cVn/vyBPjhsWLTzLwRAhPaly66kHeTIfr+ifvmQGRSxawAs3OOLa1pXQcPvEznexRtmL1ibfFgNhHAWuP5BAAKyKNilVr2hDbb+zlws0lGXRkFySjlZjEIeLzBeBhM+0/8J1WfgcBu/9UoPcjjxyq43c2UhaAZUxkQm6Hc0ZD7LNv3i9fsXU6BmicckXro3UeRRNcwtOmYpzUhhe7sFq/CGeSiPENo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(40460700003)(41300700001)(426003)(47076005)(4326008)(2616005)(1076003)(8676002)(6916009)(336012)(36756003)(70586007)(54906003)(316002)(70206006)(82310400005)(40480700001)(86362001)(36860700001)(8936002)(356005)(81166007)(5660300002)(83380400001)(82740400003)(2906002)(16526019)(26005)(6666004)(186003)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:56:48.8252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3255273-7330-42d0-2a65-08daf32baa1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
FIFO enable sequence is incomplete as it is currently implemented in FW,
and requires reset to prevent the FIFO to be enabled in an invalid
state. This cannot be done until DIG FE is connected to the BE.

[HOW?]
Add FIFO enable sequence in driver for dcn32 with reset after DIG FE is
connected to BE.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index d19fc93dbc75..7d09c62a405a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -421,6 +421,33 @@ static void enc32_set_dig_input_mode(struct stream_encoder *enc, unsigned int pi
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, pix_per_container == 2 ? 0x1 : 0x0);
 }
 
+static void enc32_reset_fifo(struct stream_encoder *enc, bool reset)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	uint32_t reset_val = reset ? 1 : 0;
+	uint32_t is_symclk_on;
+
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, reset_val);
+	REG_GET(DIG_FE_CNTL, DIG_SYMCLK_FE_ON, &is_symclk_on);
+
+	if (is_symclk_on)
+		REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, reset_val, 10, 5000);
+	else
+		udelay(10);
+}
+
+static void enc32_enable_fifo(struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
+
+	enc32_reset_fifo(enc, true);
+	enc32_reset_fifo(enc, false);
+
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 1);
+}
+
 static const struct stream_encoder_funcs dcn32_str_enc_funcs = {
 	.dp_set_odm_combine =
 		enc32_dp_set_odm_combine,
@@ -466,6 +493,7 @@ static const struct stream_encoder_funcs dcn32_str_enc_funcs = {
 	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
 
 	.set_input_mode = enc32_set_dig_input_mode,
+	.enable_fifo = enc32_enable_fifo,
 };
 
 void dcn32_dio_stream_encoder_construct(
-- 
2.39.0

