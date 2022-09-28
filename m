Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D635BC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFD910E9B4;
	Wed, 28 Sep 2022 19:41:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542F010E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EONhMT2P/6ikoYc68CU7bEeGaDF4Xok5Hypf5F0fE+Vx1KSWTkAw7rcMvUSdm3VLUHWAV2LlptO1/xuTSasguMQzbSUxzZNh9+1opQ644YfnBzfY/YVxARygMj4rAF8iBwXrmgWlKguJjt6vhq9TtgLMyFgvTX11copj4/s+TddgJhMF9TKAD9Y0g4Uyt0+8/nAKtOQU+B+rhaxZnteR7fOPZtzeg65NIIxBZomMVgqINn7X5ozv8CVW1xwDvB2PsXLKk7PgIswkcNwfxi8rDKImOaKmLC4eu5JCQKZ1zBiHJj4d1MzB2IHNiSNd4hs/uH6EnI/pIaxhRcSVFdwPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpailNpd4zGw+F9gaIeRaOIeXc6hOb7pKdSWk1jLbCk=;
 b=UAPBTzYZ2Gpgkc11fwTZjchYgT4SFuDzotJM1rKBl/TBGIQxdY1xo2ICmVOCpHCBn8xLD1ejdQmfGm2h9JdKMev1Yrxz277E/bMXLsKrRsWxaaak+nnWjD376XKGIO7I+HT8+KKno6E0PlETTXwlw8yv439BZ9orNb0GF5cne8mJ8ziNhSS4l6dIfFycwujj52wv3hwRLJFC3nDi69LI31CU+evzbHAOqfoSD92ecWyx2FFrkeiiUoyjIGoXw3ioJk8va7bwJoO6ZYxYbwwCel2coi7ugEVrgoYwEGoYKc2kwrThT3IKfVrvi+VIZWrvUbs4gpj/m0FSJ71olcZ0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpailNpd4zGw+F9gaIeRaOIeXc6hOb7pKdSWk1jLbCk=;
 b=TCH5p+BJVbM+Gphh4veUHDdJKpo6lHCBAJIEaJHed4pmDgHqiDNPyNrtiRMNSVFkzV4ngxhGT204CrWelGIIPGh5yPdyQ0AE42PyJ4h8uKLDShJ1HJfiWOxSYo2F6xrooeWzL5TpA6Gj85xxLlLEtT6nCNBmKmIgqBPx1OxcQys=
Received: from BN9PR03CA0308.namprd03.prod.outlook.com (2603:10b6:408:112::13)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:40:51 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::e3) by BN9PR03CA0308.outlook.office365.com
 (2603:10b6:408:112::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:50 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:49 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/36] drm/amd/display: fix dcn315 dml detile overestimation
Date: Wed, 28 Sep 2022 15:39:56 -0400
Message-ID: <20220928194028.144879-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e45c24-92ac-4b8e-bfc0-08daa1895955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsORxe+ljYZjyPCAh14E79E4n9atoyfWnyoXelJ6YJFfSg61DdqJM8QdcUkvFjWhJwT2ZbGRby1rcenMDm+0wuTXvlAdMLO1B+CoFHjJW1NN3RjeyMCicuvbvOzgcx+6qe7yIZO1q3XdO1d+VYf/beaPrWb0+78VSxmrGEEpVrufMZMSX6vPTpqCFwj19y8oCiWDT35g4IY7enpCdWnClHaBbtvH25FIxZ2wg2BpFznAmR7MQM3jTrKnw74jJjr23l1/qI5B5Wf6txL8y1EHZCHFPwEcdT8Za6PyQmyEcqyuWC6dEba+gqQrLKC5TLcDEeGrpEnDRO4ydycdMv42kcLIVH2l72v0tLgtVb3WVYbpkoWrzCknyqnY2PlOZGaEG31TaBtv5dUoN5YhpDCm8+BiyFZZhco31qxRxFRaw+2GfVSHabBQQuYH5zP5kb8cS9V9p0L09O5KtD3A+Y78f3nYPEMi20FCaWR8lRWTzrv7H5q0NN5TQfSkOHjKSEDPwum4G60I0WNcmRD3ILthLmmS/ZuxrztM+ihROeJhCI16AsB3FtwdMEWlOqS8unv8a/0rdBrxDQyCay7i+zycLzIxucr67JHHBNIXaooTlYVA9EhZ7T7mIzK5POMi3EVN2RcW2XMR5ZBADR3EvDrr963/8RLNhyB1YUBKHpa3LB9DeKyqrBXo9yk31MO82npExaneW4f9ZcZgTejnEs4cE3DGbtXJAuQyzlnle5na+J0hC8cOJ23N8dn4U5aJA55VaT38vWZxQcMzFdPbZ+eevUw8KneLJtTTSpUrIyb4z6N081K7gBeEXZyJ9MK9A3LqApXkTL/8/oSyb+ZZ/Tiomg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(26005)(336012)(8936002)(41300700001)(7696005)(16526019)(36756003)(426003)(186003)(40460700003)(44832011)(6916009)(1076003)(83380400001)(47076005)(36860700001)(81166007)(82310400005)(2616005)(356005)(316002)(82740400003)(6666004)(2906002)(54906003)(478600001)(70586007)(40480700001)(4326008)(86362001)(70206006)(8676002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:50.7104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e45c24-92ac-4b8e-bfc0-08daa1895955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Hamza
 Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

DML does not take the fact that dcn315 does not have enough detile
buffer to max all pipes. This change adds a workaround to apply
the same logic DC does when calculating detile buffer size in DML.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  2 +-
 .../display/dc/dml/dcn31/display_mode_vba_31.c    | 15 +++++++++++++++
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c |  1 +
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 5dbd363b275b..87bfc42bdaaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -692,7 +692,7 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	}
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31);
+		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN315);
 	else
 		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31_FPGA);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 8dfe639b6508..b612edb14417 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -43,6 +43,8 @@
 #define BPP_BLENDED_PIPE 0xffffffff
 #define DCN31_MAX_DSC_IMAGE_WIDTH 5184
 #define DCN31_MAX_FMT_420_BUFFER_WIDTH 4096
+#define DCN3_15_MIN_COMPBUF_SIZE_KB 128
+#define DCN3_15_MAX_DET_SIZE 384
 
 // For DML-C changes that hasn't been propagated to VBA yet
 //#define __DML_VBA_ALLOW_DELTA__
@@ -3775,6 +3777,17 @@ static noinline void CalculatePrefetchSchedulePerPlane(
 		&v->VReadyOffsetPix[k]);
 }
 
+static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int *DETBufferSizeInKByte)
+{
+	int i, total_pipes = 0;
+	for (i = 0; i < NumberOfActivePlanes; i++)
+		total_pipes += NoOfDPPThisState[i];
+	*DETBufferSizeInKByte = ((config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB) / 64 / total_pipes) * 64;
+	if (*DETBufferSizeInKByte > DCN3_15_MAX_DET_SIZE)
+		*DETBufferSizeInKByte = DCN3_15_MAX_DET_SIZE;
+}
+
+
 void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
@@ -4533,6 +4546,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->ODMCombineEnableThisState[k] = v->ODMCombineEnablePerState[i][k];
 			}
 
+			if (v->NumberOfActivePlanes > 1 && mode_lib->project == DML_PROJECT_DCN315)
+				PatchDETBufferSizeInKByte(v->NumberOfActivePlanes, v->NoOfDPPThisState, v->ip.config_return_buffer_size_in_kbytes, &v->DETBufferSizeInKByte[0]);
 			CalculateSwathAndDETConfiguration(
 					false,
 					v->NumberOfActivePlanes,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
index f5400eda07a5..4125d3d111d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
@@ -114,6 +114,7 @@ void dml_init_instance(struct display_mode_lib *lib,
 		break;
 	case DML_PROJECT_DCN31:
 	case DML_PROJECT_DCN31_FPGA:
+	case DML_PROJECT_DCN315:
 		lib->funcs = dml31_funcs;
 		break;
 	case DML_PROJECT_DCN314:
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
index b1878a1440e2..3d643d50c3eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
@@ -40,6 +40,7 @@ enum dml_project {
 	DML_PROJECT_DCN21,
 	DML_PROJECT_DCN30,
 	DML_PROJECT_DCN31,
+	DML_PROJECT_DCN315,
 	DML_PROJECT_DCN31_FPGA,
 	DML_PROJECT_DCN314,
 	DML_PROJECT_DCN32,
-- 
2.37.2

