Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FB7CD1284
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CBF112593;
	Wed, 10 Apr 2024 21:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q7mBVAEu";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930CB10FAAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOowHP3nIMFVbRonGGXp/sEm2CmZuyP1lCOLjB8Ba6lCjPQYSTHgFrtKI3IuzpXFw2O1HIkxf/0/ZGXRPDFzm3I8XzpyNUY06EsZYO/QuAY6cp9eghXFr0eMls41B9Smc5BRehvKaGD4tfeIGG6HUTarJHZ/uEt0Y96SVPfFtM+BV4Yb1xmD3Zs+2qKiQw5dw2lPxuyRqlq5/ZSPQ1O9JBB+ofwirmw2HZnSH5Zv8f27q28B4jRWeQnTLHZKerlcA8nwWWCLd6kTi2u+CW+5qZN/sJk4mGejQC3uWv2vauczaTWcXBy9prluvBZhSE+u05/z3bddylB3+VOI6JIVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wlMx60bfSqnj4mHiPfLJlqU+IGVFvEma6W9DWbp6xs=;
 b=TYF5szfy0pC8B4JfaKa0bOBQl/3NkkLMWI3Es04If1vqk71jLN8OUJR/TsP5oOowavs37G1mB9p3H7LLU+onEhsd2e941+2FIa6kAvszu+s9kxykGDfp1YuxS82bkmyMt48UCKGtQpDw6lTDtHI+Vk7s29OA1kMqwQtO4VF2dtN406MBiH7YHohfj/QEbtA5wJks0es+00sMq5uQgWAywWkLUz/5Hntnw7DyQxLB4VYhGA/9KMOM5aGRjE9oqqusQfcKeIPzRDj/aCuo3orlpm2ePU0i8/73ugOLEccPGCVUaDsA/cqI+MItOb+bZQh/3F0AVMSpJzGpbGmfF+RBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wlMx60bfSqnj4mHiPfLJlqU+IGVFvEma6W9DWbp6xs=;
 b=q7mBVAEuet9Aojr4YkGBSt8Opx6ICEdnBPDQlJD856W4zpf5ZF4wXjpCXCPb7kZuzU2h/3eprmI+2hOyGzDQ0Vou9+Wq4nFG8tzPYKbfRbWmK4w6P1NrA5iEzoyNSYDba5zbeRLwTSw2UEzE6nATmuRyiGr7sMrA+a9juewU8Oo=
Received: from BN9PR03CA0256.namprd03.prod.outlook.com (2603:10b6:408:ff::21)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:26 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::ac) by BN9PR03CA0256.outlook.office365.com
 (2603:10b6:408:ff::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:23 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 22/25] drm/amd/display: Update DCN201 link encoder registers
Date: Wed, 10 Apr 2024 15:26:11 -0600
Message-ID: <20240410212726.1312989-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c818e0c-60c0-4415-b2dd-08dc59a527f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1v+EF+kEBEnrF0nhZs0OzrTF47q12CB2CnkCCgdeslUOshRCKtpBq1yD8lXI2kgqWkFpfnZDp6jTx1UemBkBAoBT9PtVax9o74gtmZKNfJvO8B7wI4uljPyoHMbBVto5xvm0eheCvIMw6sVokgBL0dL7ryZuHr8Os57R1FXz/KY2IKCbgiztW346GqHMUn4ZsWpFS3/2aQ6tvcnhUYADE6EEdhPlao6IG1uGFfGW368VfDpua5zLS+psZsvXy/INZtrX+uMgfKOMFPAMhhre4wm9DsMnzMPFU7LWHfXj4/es3jsK8DlshyElAwm7Lr5duGjnOsyyEXYaiCGzMaRMkGCRyPyMwEATWjcGUufSSQpDLcDm7ZeEMePxQwVJw0t5Hoto17JqWRS1YOwM0CAsaynU/UfMRFED+E3Z3cVDDTmf845obf2WtJYbCaYrzY9G9FUL2ncUpOP2J/2gBRzb3nEUdORrV7ZB4OlOoHvHsqbZt3H58E0zneu6HUGCiyej8lDhGXLaZE9WAlHpYGL/wogrglLAml9KNDXSn0H1sYmRP5V0utkvGcfphL/7KM0x44Ubo/8U3SinXrNIhxaM6tZUXTGX707oCmo8oCPlcwz8qPyfDSM4OJoyMO1c/sz0vLgC6fuQ/sGirb8niUSnrmUh4PZEVNdfy4mlJ6s70v0UcXfvdumXQXQflrsSqcV4R9qArhCCb31hU9Gnyuv2VbrMs4XGMCU2C3yP40uONULp1cgHSOT/qCxbX26kDXA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:25.4163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c818e0c-60c0-4415-b2dd-08dc59a527f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178
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

Add some missing registers expansion in the dcn201_link_encoder file.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn201/dcn201_link_encoder.h    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h
index 8b95ef251332..be25e8dc0636 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h
@@ -30,6 +30,10 @@
 
 #define DPCS_DCN201_MASK_SH_LIST(mask_sh)\
 	DPCS_MASK_SH_LIST(mask_sh),\
+	LE_SF(DPCSSYS_CR0_RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_2, VCO_LD_VAL_OVRD, mask_sh),\
+	LE_SF(DPCSSYS_CR0_RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_2, VCO_LD_VAL_OVRD_EN, mask_sh),\
+	LE_SF(DPCSSYS_CR0_RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_3, REF_LD_VAL_OVRD, mask_sh),\
+	LE_SF(DPCSSYS_CR0_RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_3, REF_LD_VAL_OVRD_EN, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DPALT_DISABLE_ACK, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DPALT_DP4, mask_sh),\
@@ -44,7 +48,15 @@
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_DP_REF_CLK_EN, mask_sh)
 
 #define DPCS_DCN201_REG_LIST(id) \
-	DPCS_DCN2_CMN_REG_LIST(id)
+	DPCS_DCN2_CMN_REG_LIST(id), \
+	SRI_IX(RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_2, DPCSSYS_CR, id), \
+	SRI_IX(RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_3, DPCSSYS_CR, id), \
+	SRI_IX(RAWLANE1_DIG_PCS_XF_RX_OVRD_IN_2, DPCSSYS_CR, id), \
+	SRI_IX(RAWLANE1_DIG_PCS_XF_RX_OVRD_IN_3, DPCSSYS_CR, id), \
+	SRI_IX(RAWLANE2_DIG_PCS_XF_RX_OVRD_IN_2, DPCSSYS_CR, id), \
+	SRI_IX(RAWLANE2_DIG_PCS_XF_RX_OVRD_IN_3, DPCSSYS_CR, id), \
+	SRI_IX(RAWLANE3_DIG_PCS_XF_RX_OVRD_IN_2, DPCSSYS_CR, id), \
+	SRI_IX(RAWLANE3_DIG_PCS_XF_RX_OVRD_IN_3, DPCSSYS_CR, id)
 
 void dcn201_link_encoder_construct(
 	struct dcn20_link_encoder *enc20,
-- 
2.43.0

