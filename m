Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1622C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 14:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4609E8F2FB;
	Mon, 22 Aug 2022 14:00:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A238C8F1D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K92/qFCFcVlt52kitWcKcwZ0xV/xjyZI8YE+E4Hf/F4XaDMKghRBBnSIPRYrUDMEiz6lYKTUvL3aFwWklgPVQVGIugUy3f3fT47wUzVO8upLlXqi8gNcbDfZz1uKRY4Aek+Q/456aBHIMfsC+mxsJ8OIisQh0OXtl7ZfCyb72mHh9P1vV3t8q+AHFu7tNNGt44ZUDmjYlcizqhp5Y8ihYxdYOOHtV0I0Sz58G5C26A/MSXPEtPA7X47clhiYD4S0Wpp9SstZlxHFDouAMxSqDWFsWQlpmUQj+pnx811HOe/S7Bbu0VKWo2Lufq+lvMTq9QERT78mu944Yxru4Z6uUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMK3cq7nvGZrshLNGz/4SYOOEPWSA5yYaCMnPim/DFc=;
 b=XYPTrV/yBYFJ2Em5BzfyyBXvlK1WrR1BY4qwRYrgga/9Ie6z29I7O2//9Qzd1TY01oPDg39Ge2woid8cwY+JRR1N92VISGFW3kUM164OYEskHMdBe0wzO1+cz2fgh7R78TaAk1iWSQokKn146YrH+IQm6pXtTkVTh/RFB4VTrz0UhapOfCx7Khr9SRysNjhTSUSKac4unbg+lGXh/BFVCSHu+IxRbmFKoo8mkp02P616B3W4aRKbTsalkE1bIpAM3l6fGi5gGWjvD4BZaASP5vQfZYCpAxnKVuGpXnZ29AXUZX5SstCuhw6XXUAUxHPJEjcKlNeB7aqrl+yh4HjxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMK3cq7nvGZrshLNGz/4SYOOEPWSA5yYaCMnPim/DFc=;
 b=VqfSqAEty2F+DOEYMj4hvMxemDwXSs9wFRBXZwIGxPOlg1J95iyZCb2PP35at07tCVaegsbL3Mzk+Fn87HGavU4abOt+0+ky0T9mqmZpm0HMvKE8m9p9qcKqYPVy/KiMUkNXyR88cs0jEyChcipUh4mREDBJZ4rJVHC2PV4qGFc=
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 13:59:41 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::13) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Mon, 22 Aug 2022 13:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:59:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:40 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:59:31
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: program k1/k2 divider for virtual
 signal for DCN32
Date: Mon, 22 Aug 2022 17:57:47 +0800
Message-ID: <20220822095752.3750614-10-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56243c5d-8496-4f36-b1ad-08da84468f2e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vK2iTjvDLEA674V/zauviqxu4G2s8XXbnBfCoDDX29JFGkMrROQBeZ3jKciM85A4/lnVagCvntJ7ef2QNJwAB4klLsKLKVzRI3yVg6feHfAbIAJHypGJGNlEZxpmW9wt9J/ziK62SxmklofV3ft1I7pd8KDEVTA8NJHrALuuAtkNuXETL4UcseQgoIpYdFaZggujvkGLF5pnCobMHvAfcuXWAeCDo/HmCv8iMLnMFRrxwYKBoyHluhjMTSgDswFusJItzUg3PV7stBNq9A8mdeTrMw+3BOL/xQ3BkFW1XFWqfQLlLnqQK5veS8ZZpFr5Q2O0JSgp278wua+o3KucSo1RmByhX64jFnMFzZMhoOb+WYY+0nZxmTqhI5UdhZyON64RYTqltLesmnhYfzd+fnBzifbiPQu9cAhqKpURinqdliHfazT5VvaeKwDplPElgZlAVou3EPK9zCaWJQKlsNy3K/pO4L/cVRpzqssYSBU2H+baANuslv5LhqALMJX/n6aY+o5MWJ0BrUhgzhjkZdPwHCbjrqaUDbekzao5o4EyMT95BuHcViVIAS258ot6i5YebpDDYOFUcimKJJiCKSPB4mZMM63O1bj6cmySPXmn+CC6atBjQpMUOZbrIYJi3jkYzcczZdzqxDm9YMwUWNh3zbevUaZo3llYYjcRvUTA2DfusE2FNsvl/ev2hz0v4X0cOuhyJF0PWRbZUu17hKSPdj5n+JkhjVOW8x38DXwd0dF0F5pTz9i1+RuLKAnzvID8S8ZRLhJBWD6VghODODJYZSs1F7BgTy6kidauv1yDkRsNqZoswOnurKsICq89hE4e0jxAlWFQLHZDxge07w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(40470700004)(478600001)(316002)(6916009)(26005)(5660300002)(6666004)(7696005)(8936002)(426003)(186003)(336012)(2616005)(2906002)(47076005)(1076003)(86362001)(41300700001)(54906003)(40480700001)(40460700003)(82310400005)(356005)(81166007)(83380400001)(8676002)(4326008)(70586007)(70206006)(36756003)(82740400003)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:59:41.0344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56243c5d-8496-4f36-b1ad-08da84468f2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
When using IGT, kms_bw multi display tests trigger an assert since
we ignore virtual signal type. k1/k2 dividers should be correctly
programmed if VSYNC needs to be correct. Add the appropriate condition
to the if arm to fix this.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index ebd3945c71f1..d1249fe1e412 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1133,7 +1133,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 			*k2_div = PIXEL_RATE_DIV_BY_2;
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal) || dc_is_virtual_signal(pipe_ctx->stream->signal)) {
 		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
-- 
2.25.1

