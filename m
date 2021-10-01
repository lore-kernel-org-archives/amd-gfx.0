Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D141C61381
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D141C61381
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729AA6ED87;
	Fri,  1 Oct 2021 14:41:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D026ED87
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za0m+43uZsUMm7dQsDXt228ePU4cK1YYIbJis/lHcgTqbF3n3XSShuR5Qgdl08VLinEbl6ecFgi9F0FUQJVEdqVejqAIrNoNUrc/DseDuxIHwilqJxxzDId0vOHa+MQDQX7ky8aERB9TD3zQxzKjfq1kGUAmTU3tqsGKNRK0yrjPeI5D7VLPA6VTNF1am66zRl/G8MmNyUCgPFBdPG5bnqC0/3y4r0MGQNd/A/ncHPG8hB469hnVUD4r5Or0sSPXgj3Jc2lbrFdhCInVMUzWvr+vSMHHDyvaqiXAbLlr/j7Gt0db42JTfJ9e9YBiIpKBakd2xJYkkCMtN7qsWdR4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNNpM1AbA8z6CyrylCAtTI4OxmGxZY+sT7Ooe+EV3Ig=;
 b=PCQuOzcl7h3trHLlrQt3LaG+C18j9fgnyRUfh43ePbYruid1fIsoaZWjzgRzmUIZ2ekUg7lVly7OcXPSMoqUXBDJnN9rTeoNembc+5Qj7coV5m4dJ36b+RBQ/coDN40lCb4g0W8xcmrlhkm1vLXn+VIucoKQzQ07Qaz7o9ESD7l2TJVQtJwQ/3OoU8O+PsLFQKxj8Ic/EeHOxUyypg+jcxBTHkZ+pryli71EbDJlLHwA9pfbtPbY5M4pOkCaC3HPs5sOfqBMTpdxl77O6EJWH3M1N+LmJplkf+snMdqIdXjhSA8XTD2fSPddrhzjzSPGdtrejfQLeTwUkmBX8aYDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNNpM1AbA8z6CyrylCAtTI4OxmGxZY+sT7Ooe+EV3Ig=;
 b=3S+PME44U2x++YH3rAJIjVRrNwHO9WuJWkUI33f6VuWI26B/fJncdTN79HLpMDbMq4wjfWE7OC6clYpGebcOMWv8qXt6Oq1Y4lJWzpAdR7fg/vVoHK45KwXgVLBRXv0mx1A4CCTCndl2lQ9tKlopDl/3e36K3J6EiAfXYmtRZF4=
Received: from MWHPR22CA0071.namprd22.prod.outlook.com (2603:10b6:300:12a::33)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 14:41:42 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::fc) by MWHPR22CA0071.outlook.office365.com
 (2603:10b6:300:12a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:42 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:37 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Hansen
 <Hansen.Dsouza@amd.com>, Charlene Liu <Charlene.Liu@amd.com>
Subject: [PATCH 09/14] drm/amd/display: Fix detection of 4 lane for DPALT
Date: Fri, 1 Oct 2021 22:36:15 +0800
Message-ID: <20211001143620.192679-10-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ebad088-3af0-4073-6444-08d984e995c5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2809DC92A70BA3BC5E17211097AB9@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CcXhpOx3JQyO8pKlJUPhPc1ZkSOr7rIuu9XsbeKc1aZfS7QmS2gBnLnFin30Ijp+MQNoKi4kJ3dtFiHmyVojAQRXPv5TWTZlsF0TpR1cdvRY2fDLXByy6Lbm4b9pQJwMyjsuEoIZz6qYAwZcwcKnZn0CD2oHLbQl12icMpg0afJjAY/oSXg/H5HN9PnV3tm3CLCT1Buzs6EtODgS7kmBN4zwwQsSrXrpX62YpGrpxa8TynOXnx33udr6wZYeVE1dJnFSbMdSOZeEumWCjhHPI5WWQYd8juVrN7yItafHQYmVXGy3bYH0V0GwGbe84G7qsrJbK6VN8Ehmrt8Obzub2LaL3Qj4ljTo9SlgYGKGkKjOTS02nrWHkN7brMgRWnSNGn0MphxfrbQQKOhF2eupp+vojAwR5ib4U7l+8y1NFvo8rS6YmaOzry6oRyV7ISLctmhaVlKaVTK5GcDN2X22Ju6vGKD91VJ32fifOXg1FGP7RfxYMz85tyj2roc5v/1+HmX0QgEqLq15N0adUTa1KsmqeT2Um8OsJ88dUr860oyxWXAplCPLobbHdNh0CK4ePjXcEY36r2rttIFNqWc0Ag9eUK73n5oi0Vm7sUVLaOdyQVQqqQOQyU9DDSlNGRDOV5+U2K1HHOp0k3KtCUvA3/kNLvrxo/Z/aBSkm33TnycjVdxA8MjnBfzcOExChpDPSmFfJMOGTfGU7VAWnJRwPcYtA/hB9SemN3vTUfiznk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(82310400003)(2906002)(7696005)(356005)(47076005)(316002)(36860700001)(81166007)(8936002)(5660300002)(26005)(70586007)(508600001)(2616005)(44832011)(86362001)(8676002)(426003)(1076003)(336012)(70206006)(6666004)(4326008)(6916009)(36756003)(186003)(16526019)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:42.2702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebad088-3af0-4073-6444-08d984e995c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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

From: Hansen <Hansen.Dsouza@amd.com>

[Why]
DPALT detection for B0 PHY has its own set of RDPCSPIPE registers

[How]
Use RDPCSPIPE registers to detect if DPALT lane is 4 lane

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Hansen <Hansen.Dsouza@amd.com>
---
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 33 ++++++++++++++++++-
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |  3 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 4f0a0803db6c..616a48d72afa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -63,6 +63,10 @@
 #define AUX_REG_WRITE(reg_name, val) \
 			dm_write_reg(CTX, AUX_REG(reg_name), val)
 
+#ifndef MIN
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
+
 void dcn31_link_encoder_set_dio_phy_mux(
 	struct link_encoder *enc,
 	enum encoder_type_select sel,
@@ -217,7 +221,7 @@ static const struct link_encoder_funcs dcn31_link_enc_funcs = {
 	.get_dig_frontend = dcn10_get_dig_frontend,
 	.get_dig_mode = dcn10_get_dig_mode,
 	.is_in_alt_mode = dcn31_link_encoder_is_in_alt_mode,
-	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.get_max_link_cap = dcn31_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 };
 
@@ -439,3 +443,30 @@ bool dcn31_link_encoder_is_in_alt_mode(struct link_encoder *enc)
 
 	return is_usb_c_alt_mode;
 }
+
+void dcn31_link_encoder_get_max_link_cap(struct link_encoder *enc,
+										 struct dc_link_settings *link_settings)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	uint32_t is_in_usb_c_dp4_mode = 0;
+
+	dcn10_link_encoder_get_max_link_cap(enc, link_settings);
+
+	/* in usb c dp2 mode, max lane count is 2 */
+	if (enc->funcs->is_in_alt_mode && enc->funcs->is_in_alt_mode(enc)) {
+		if (enc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_B0) {
+			// [Note] no need to check hw_internal_rev once phy mux selection is ready
+			REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
+		} else {
+			if ((enc10->base.transmitter == TRANSMITTER_UNIPHY_A)
+					|| (enc10->base.transmitter == TRANSMITTER_UNIPHY_B)
+					|| (enc10->base.transmitter == TRANSMITTER_UNIPHY_E)) {
+				REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
+			} else {
+				REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
+			}
+		}
+		if (!is_in_usb_c_dp4_mode)
+			link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
index bec50e4402ff..3454f1e7c1f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
@@ -252,4 +252,7 @@ void dcn31_link_encoder_disable_output(
 bool dcn31_link_encoder_is_in_alt_mode(
 	struct link_encoder *enc);
 
+void dcn31_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings);
+
 #endif /* __DC_LINK_ENCODER__DCN31_H__ */
-- 
2.25.1

