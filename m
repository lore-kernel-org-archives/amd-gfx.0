Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491D0C48286
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 03:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D17811288B;
	Tue,  6 Feb 2024 03:47:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E6311288B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 03:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWVMJljUgjOd0DgqdMiIHK7D4lMV7FeN75gv839v8s0gBTdL2XYa0J1RqYL85jma1IwZF9uPBF9aRiH1fn0ISyBHkJEybR3VL73cSK8UEdjf1hofv9+VD6p85Q26dWOdeQ47X+feG5lqnh8RtsEkkFISWs/FTSCvU10P34LjxPYvmn/3fm3kdf1bo8sd/qpClGOHzodhjpzVLlPxrMNSEwDASx6ZswObgxGpyVT863O+vls5soI/NGbaXpsPy9Wp1K58QkGZBmTa+cXeUrJEOgNxxqOO6sQe5UpIIMxih4FnpD0GVEC+qLEiU8hB0Dk5X8dLvVrMoIrQ3lHJZ7oG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiO8MVnsKOUalLxCzYyuSi+5EvXDhERMwh3CRTbu3TQ=;
 b=jUIPztEsXWmsTtItxgPSxxxTNGRa7SfdM5lcfWoaI+RU7HgRYSUOv1O6nEWwX8r85J9u8VZYPgnNr678aZA8AwtUWknHIN5qCwZgyG0dolJrt2sEwzEB0BGeuH9n9thlJ3kXBCVBPoC9agdj6gQIuu9T4uc3kOPfMFq5PCbghAJZC1YcmHiQwTU2BrB2OgZMejV9WzaVLCAYpIgxDhKjGB4NAVL4mcBdNs4xA4JzAb2ZCD/Wk5EbJTsVBQ5v7P514Zfg+vdKnRdPTvEAsihbTXnkdi+BbrUD5zTXrG424OOrCeN0ZXTptWeKCWOXdqm5JWPdbAWTnVtUX7al4c+cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiO8MVnsKOUalLxCzYyuSi+5EvXDhERMwh3CRTbu3TQ=;
 b=P4XN7iDyoKaaPezNgGCmmB6gxsPI0O8AHI1ULoXyIWl+E8HRl4rP4xfj1BJ8XtNeNU3Knxtq91e2wpEqORLkUplsdqrO2IjJxM2SUKTOKfXMfhJjZEt4uhDoVZ/DzQtjA4JyV+00R5GX5qHswUuoVWN6ZcCjoe9r05iglUqu5/M=
Received: from CH2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:610:52::38)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 03:47:04 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::3b) by CH2PR04CA0028.outlook.office365.com
 (2603:10b6:610:52::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 03:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 03:47:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 5 Feb 2024 21:47:01 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Roman Li <Roman.Li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amd/display: Implement bounds check for stream encoder
 creation in DCN301
Date: Tue, 6 Feb 2024 09:16:48 +0530
Message-ID: <20240206034648.2957318-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205023449.2542171-1-srinivasan.shanmugam@amd.com>
References: <20240205023449.2542171-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f145d8-c32b-4fbd-8e19-08dc26c64863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZHiUh3b1T2Kb3CMM4Ilyr1otX6EQWT/wXXO1Ro06PPDW+BKYHU8mjFt8FS8id/gwYqqFSeKAKyJ7otrSIhFPqGCx/3JKEUoOJMtArA5xCt0124EUVKfgGnthwsSMLszYTtyMX04HEMnrYtkM39J5ZTSSOqzP90qJpLarcIswG6cHGjrLdJVYahIRDcvYSJ/Wap7FtrWAQQ2tB10D2itijaErOslw25VnRmKxUL2marrZXSKNmYtz647QhN4D29EP49iL0nbLI3TSMreDbyokndFtEfmetihG9fXkK/roOa17ONs2gD/hqPBlldaHlpTSP2iZkVm4VXVM9NXnBCYQq94A3mU1LXZuGgTv2+YcE0t8I1fyI0vQkvTDhXF8JIHBtaFDziRINf8kJRNXjE8aAbwmyLlSvD7hdCmt2Re2dwTfIPjmtNb34ngm7yWNjHcbBKdAcZwqA6e6vR5MLD17GX0fySv39iFTS0vm/suLrhbh/8HARPE6LOVXj/cWibe70Jpnrilr6WtcNu4aL7BqYv08B+ebeRq3SNwGDfpO5RWq/dZ8PosV5zgJBQhAa2UCvUPukwsF/oSv1ySvNj9ZZ/fluvcS3N52wBetjh4baWgZDO49VphSB0gqsLEhmqF86U8Y/z4kuZm1CYcUm5nHuMVBz0fn3qYrvAt0gxcFsw6rH2Kx8pW20po9udrfzdOVrgQ45abgjo1j30cLiZAYdN0bnOz09UHVVbs3h5dY5dwVOAxQ3nCsFPjoDPlw3DJy9QKz9RT8Q664g+t8UfUNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(478600001)(47076005)(26005)(16526019)(6636002)(2906002)(1076003)(2616005)(83380400001)(356005)(426003)(81166007)(82740400003)(6666004)(8676002)(54906003)(8936002)(70586007)(4326008)(336012)(7696005)(5660300002)(316002)(44832011)(36860700001)(70206006)(110136005)(86362001)(36756003)(41300700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 03:47:03.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f145d8-c32b-4fbd-8e19-08dc26c64863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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

'stream_enc_regs' array is an array of dcn10_stream_enc_registers
structures. The array is initialized with four elements, corresponding
to the four calls to stream_enc_regs() in the array initializer. This
means that valid indices for this array are 0, 1, 2, and 3.

The error message 'stream_enc_regs' 4 <= 5 below, is indicating that
there is an attempt to access this array with an index of 5, which is
out of bounds. This could lead to undefined behavior

Here, eng_id is used as an index to access the stream_enc_regs array. If
eng_id is 5, this would result in an out-of-bounds access on the
stream_enc_regs array.

Thus fixing Buffer overflow error in dcn301_stream_encoder_create
reported by Smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn301/dcn301_resource.c:1011 dcn301_stream_encoder_create() error: buffer overflow 'stream_enc_regs' 4 <= 5

Fixes: 3a83e4e64bb1 ("drm/amd/display: Add dcn3.01 support to DC (v2)")
Cc: Roman Li <Roman.Li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/resource/dcn301/dcn301_resource.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 511ff6b5b985..4a475a723191 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -999,7 +999,7 @@ static struct stream_encoder *dcn301_stream_encoder_create(enum engine_id eng_id
 	vpg = dcn301_vpg_create(ctx, vpg_inst);
 	afmt = dcn301_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
@@ -1007,10 +1007,9 @@ static struct stream_encoder *dcn301_stream_encoder_create(enum engine_id eng_id
 	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
-					eng_id, vpg, afmt,
-					&stream_enc_regs[eng_id],
-					&se_shift, &se_mask);
-
+					   eng_id, vpg, afmt,
+					   &stream_enc_regs[eng_id],
+					   &se_shift, &se_mask);
 	return &enc1->base;
 }
 
-- 
2.34.1

