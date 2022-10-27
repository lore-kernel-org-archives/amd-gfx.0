Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B3BECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14D710E6C6;
	Thu, 27 Oct 2022 18:39:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA8910E6C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEUWKyiYsbGtBBxC0UxBAeEwIIaAjMorUwO8kWX529SQivCp93UGyC/NKH6YOnTxqXJts5CqpQI1Mje0L49JAOI+PeU+UhoTw9TNMCmSjC60cpR3qfhvzZnNAyBcPiz/S8uzvU+HKAO8Kaydk76TRPZhtftSII+NwspZgcbk+TeCI2tNN/5Y2/zjiiSZfxnVTpW69PYXkGcBVI++P3XooAHFd3S8kldLud1nvX3NQM9aA9D6HCY1wZkepxIA1eCspAtmQfIiqjEFr098YGkxQ3C/nY3zOdXHsZf17oRiDisRepG6IyhvnUQ/6q+8ED/l5B8gkP4od2kRTlOJ73zoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/tZiVK5jTdrJ/2PfBpSHqx+cR4sp4aSM0SMkOcuUEU=;
 b=QPPY93C1dGh/MLtu6FyX/UlCaAI9302ghrB2cny/yjgyrWk72Pc3L6ps08fmO/ANRdChBOGRVGB6RKRfBib9+6TV1b43Xhm73Qua1iTy2dDzmq6f7eDdjzr8XZsPqnFyUW8KrpadN/AWusIl/Y4rv0EnUW9NVy5l3SlcxQS3P8y9dLBxUUNP8Sq0c7cCVz/Y3cpm7t/o36Dvqkx9blrpNNp3hbak4fROMT7Opd9HbVEkAcQ4OkzWqAq4Qr+GCMLd+qs2+hfkE10i1bec+pp0jgl3zHKGTZQPPIuarB0tG8GXVLZJ+ffc/GlvbKjN2NP1z9xOdoCOPVD8N0JLu0VpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/tZiVK5jTdrJ/2PfBpSHqx+cR4sp4aSM0SMkOcuUEU=;
 b=0ABr2wwjDxE86UV045KlvWu75f7a88+NSBBiac2Ug1zwNBxEROlFoUUi4fJoXxy2tldy8SaLX6y7LFbSdZWqykJnQTmH5QeoImyf0lIHTeI+P458lF5kKL4gj5XnICRVNIYrChl6dqSyX4q5Ft1lyH2lAqRrecjlmrChUaSiNXM=
Received: from BN0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:e4::12)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Thu, 27 Oct
 2022 18:39:11 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::b2) by BN0PR02CA0007.outlook.office365.com
 (2603:10b6:408:e4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Thu, 27 Oct 2022 18:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:39:10 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:39:08 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/18] drm/amd/display: Include virtual signal to set k1 and
 k2 values
Date: Thu, 27 Oct 2022 12:35:27 -0600
Message-ID: <20221027183543.1117976-3-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 8439a729-0cc3-4fb3-b5e4-08dab84a89d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gURuOoFANttqh40IPDP+Qe6hPLtD7qGcc90FPcWRcLDPl0VKtOm4dZBnPpYL4L1aHoEInorIEnosHXHsfs+iEcWH1+vcIitPEbm1IIQtzTFxGwg6mBzDDgbz8vwUc936kja98nGkqTDE1tvxTW+dleBoeJqtg+ZCF7v1L5NX0Cqaro91oZbBk17j+qJIzWtNALb8Nmyt+2Dv/ObBo2t//ZlR7xtkrv1WdrHyMeOzsG+kfLmPlxHdlJlM3J7Bn9Ipykw4ZJfb/KWjAlP8PKI8o55aoGCrWQ7Vi6ezyevP2vnmESWyvc3+HVV4BqxcHl6oFZC9tRB9FkPZ//SmL86AliJp12pTUULGfwBcd6gWjNFPXiTqXDtf3vH/AcoZcmFEXJMz2YjNnoe3qQtFx8adTxoofVXIFWb4Qxp9emkQnNHW+q7LGIYSfQ1iTrF5vgyfthqviAACuNVhi1no3FDucAGDPN4CwrWj7dcR3LcjwbC+fdwCXqqS8SX2KJkOA7AUTBwawlWxBgCHsd/iQDsnEOk9cH8kvZ0WVTZs+uywLmcAx+MdQo9nOLlLpgzPuq8lOlKv4Gfc5yw/CgvgXruj5FrvybuX1j7zeoP3JcgVKG5OtzkIZm1IiHuN2YnRQlaFhUynpzxqK46yRz5O6JG29LLpTtcVzT/+6uk9OLF8QmOphIcQGcC0+KHUs2Erk/Sbwia6w1YWibghIxobyBE6UY3Nqe5Q1S+fOuV2rHotLWVmIrfnnT/ih5GsqDla2Lf8LVORai+2McDY5XWL8Pb8J+In4r0RwObz9JSTHEdvxKXzVeRWfsKDMVDcAiGFqB5j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(47076005)(186003)(83380400001)(1076003)(336012)(81166007)(2616005)(44832011)(70206006)(4326008)(8936002)(8676002)(70586007)(82740400003)(16526019)(356005)(5660300002)(41300700001)(36860700001)(2906002)(6916009)(316002)(86362001)(54906003)(40480700001)(426003)(6666004)(478600001)(40460700003)(26005)(82310400005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:39:10.5714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8439a729-0cc3-4fb3-b5e4-08dab84a89d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Eric Bernstein <eric.bernstein@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index cf5bd9713f54..aeb4822cebc8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1186,7 +1186,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 			*k2_div = PIXEL_RATE_DIV_BY_2;
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal) || dc_is_virtual_signal(pipe_ctx->stream->signal)) {
 		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
-- 
2.38.1

