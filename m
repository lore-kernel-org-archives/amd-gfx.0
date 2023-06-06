Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D13C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965FF10E323;
	Tue,  6 Jun 2023 09:18:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B85210E308
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kyu7tAqnlo4jYFdzrTEtQvqRM1A4ckMoRJUnFllz4O5Mg4pBXwRBwieSxSn82FnTvEQ5Qv3Oy8bMDdQ65XvLozeVsCheyjMbZirWWFsWhEtm1P8ttkOyWQTGfJdSBlRRXHDom2YM+2ws6QuTf54DNNomQKbkPvS3Gaxj9OvnPUQtdhqZrv1M59CMnyZ6YGul/g/A82F7hFWL/E7SLbo46b0y/VvpQjVuZl0vNhIslFtaJ8Qh8UT11dG3jdY7V9gUp2Zuc+bZn9G+4j6bEZlfgC/7duHh+6VeyXXM/8Mlidt8ogdQyVDhcysLoTw7Jv0gnHem8zeZ5T2SMDJwwc2xXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRgnbFu1qeSUmtNCZEpKsKpl+Y+jzHhW9IEkqdhWU0w=;
 b=BMPi7OSbtyzUCu2BN994Um2cYsZ2FpVu3ivjSVVSZ4BxHx41EDZyURy0X0/6h/kRMY8hzL7i6yBy7WIIbLZ3cg0qPQfxvsfDehctUiBv363OUwtJFDzwFxWBRVAP4Nop0UVLhctlxjw6VthKpZhSXz6/sV4ZdlPCME9R6R7AOMnQ7mXRBsIMhwzKwD8K7iHFH685W01PupkYkEdijukF++tTArw45PkC/2wlSpITfJoPSyFXjuuz9MqD/VTOfkg1hwQRm90B2MTgKwJxK94ufbpNfJBDorOzRB4thJn2g3wsO424whDY5Tx5BjYFhS6EMizcLzsxEBoB0dFwh02RXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRgnbFu1qeSUmtNCZEpKsKpl+Y+jzHhW9IEkqdhWU0w=;
 b=wFF2Rf5FasjCTlbAYNJKTmyKT6xXv7pRncQXcntiUXrk3amVvnszNexkU2AYuOVrqb41WgelcYymtuaCv6QROsWvP2lAEnnH2WD4BKlzPhuFkhf+E6JRtB28y+2FrZ+JC3kBUJ1F5TOEcMc0QqlhbcIifAYBVnIf8S3+g6qx+xI=
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Tue, 6 Jun
 2023 09:17:59 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::e) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:58 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:57 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 14/17] server/waves: pull out a wave_to_json function that
 deserves the name
Date: Tue, 6 Jun 2023 11:17:22 +0200
Message-ID: <20230606091725.20080-15-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: c29c7a6f-8ea1-4f3b-b150-08db666eeba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v2PvBJAPbRNkbb7fMY7soZyfnLAdcjlTq82nfn2SNJxnEJZ6ZzpIRAOjFGhEUlYO86n3RZoyyWjpOTFn8FQPS+qtPy3BHHsaMzf0XXaUJLnAWmNHDO9sBkAioTD9Kif9BfW2wasiipT5ELAXrUxGrGJY+y1hIIOV5vErOqh8lDIic45OrhG7ZF1IbTIBtnYTVxGZ7FvvRM0KAj1pqLy7gDiz9C4lyBU5BkIxkrJ7uiHYFYU7geIJCFWs9aO230vLXRJIzjHnyF4CBL9lfItjRypayXAURAn7F3zzhA12kkmIw9+CsD9hRNJZ7b9SYHZGD1nYmIFAE085bwND3tGjwo8vx6ykWrRTS+PQu/mRPlfTgbu1yokoZWyEBZMRuP3fytiS/+yCvYFjMaXvcKQgXln35adJez9FRvKnwK+7snDWmVgXuuvWMWo8xsetB9DdV4jRbO7HOyEXMDCmIoOhMoVIDagtLd6Z1vTaHKEuVT/OySxeEqID91H3ZiIjXFu64ee4tbuRVWnZq71nt7u82L+ayiUW9LibHJ6r1FvVbintjjNpeYT7TMJAdtIkH82oLkP2o8b4wpE2ZmtUKC6yP+fitxvW/QR/nP8VLz/Fl68t9P2ZzxyMOtySAPNxrrvcvt9SWBOGe3kKUL9mT17jfe5Ngu/bp973rR/BNu59VgJm0azD412+2Qc5w+9XtNUXvrkfbSEfQoeTnt0SYbwIXs1HrfRLwg721TcaSotB2aVavqwqr67X0a2uH2IQG62HXBmmOsdXge9bmdL2BqPhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(2616005)(8936002)(8676002)(30864003)(186003)(16526019)(41300700001)(2906002)(66574015)(5660300002)(26005)(1076003)(47076005)(426003)(83380400001)(336012)(7696005)(40480700001)(36860700001)(40460700003)(478600001)(110136005)(316002)(6666004)(81166007)(356005)(82740400003)(82310400005)(86362001)(70586007)(36756003)(70206006)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:58.7460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c29c7a6f-8ea1-4f3b-b150-08db666eeba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We will use this to send updates for an individual wave.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/app/gui/commands.c | 299 +++++++++++++++++++++--------------------
 1 file changed, 153 insertions(+), 146 deletions(-)

diff --git a/src/app/gui/commands.c b/src/app/gui/commands.c
index fbb11fa..38ae44d 100644
--- a/src/app/gui/commands.c
+++ b/src/app/gui/commands.c
@@ -1537,175 +1537,182 @@ void init_asics() {
 			}
 
 			index++;
 		} else {
 			fclose(opt.test_log_fd);
 			free(ip_discovery_dump);
 		}
 	}
 }
 
-static void wave_to_json(struct umr_asic *asic, int ring_is_halted, int include_shaders, JSON_Object *out) {
-	// TODO: This is using the deprecated API ...
-	struct umr_pm4_stream *stream = NULL; // umr_pm4_decode_ring(asic, asic->options.ring_name, 1, -1, -1);
-
-	struct umr_wave_data *wd = umr_scan_wave_data(asic);
-
-	JSON_Value *shaders = json_value_init_object();
+static JSON_Value *wave_to_json(struct umr_asic *asic, struct umr_wave_data *wd, int include_shaders,
+				struct umr_pm4_stream *stream, JSON_Value *shaders) {
+	uint64_t pgm_addr = (((uint64_t)wd->ws.pc_hi << 32) | wd->ws.pc_lo);
+	unsigned vmid;
+
+	JSON_Value *wave = json_value_init_object();
+	json_object_set_number(json_object(wave), "se", wd->se);
+	json_object_set_number(json_object(wave), "sh", wd->sh);
+	json_object_set_number(json_object(wave), asic->family < FAMILY_NV ? "cu" : "wgp", wd->cu);
+	json_object_set_number(json_object(wave), "simd_id", wd->ws.hw_id1.simd_id);
+	json_object_set_number(json_object(wave), "wave_id", wd->ws.hw_id1.wave_id);
+	json_object_set_number(json_object(wave), "PC", pgm_addr);
+	json_object_set_number(json_object(wave), "wave_inst_dw0", wd->ws.wave_inst_dw0);
+	if (asic->family < FAMILY_NV)
+		json_object_set_number(json_object(wave), "wave_inst_dw1", wd->ws.wave_inst_dw1);
+
+	JSON_Value *status = json_value_init_object();
+	json_object_set_number(json_object(status), "value", wd->ws.wave_status.value);
+	json_object_set_number(json_object(status), "scc", wd->ws.wave_status.scc);
+	json_object_set_number(json_object(status), "execz", wd->ws.wave_status.execz);
+	json_object_set_number(json_object(status), "vccz", wd->ws.wave_status.vccz);
+	json_object_set_number(json_object(status), "in_tg", wd->ws.wave_status.in_tg);
+	json_object_set_number(json_object(status), "halt", wd->ws.wave_status.halt);
+	json_object_set_number(json_object(status), "valid", wd->ws.wave_status.valid);
+	json_object_set_number(json_object(status), "spi_prio", wd->ws.wave_status.spi_prio);
+	json_object_set_number(json_object(status), "wave_prio", wd->ws.wave_status.wave_prio);
+	json_object_set_number(json_object(status), "priv", wd->ws.wave_status.priv);
+	json_object_set_number(json_object(status), "trap_en", wd->ws.wave_status.trap_en);
+	json_object_set_number(json_object(status), "trap", wd->ws.wave_status.trap);
+	json_object_set_number(json_object(status), "ttrace_en", wd->ws.wave_status.ttrace_en);
+	json_object_set_number(json_object(status), "export_rdy", wd->ws.wave_status.export_rdy);
+	json_object_set_number(json_object(status), "in_barrier", wd->ws.wave_status.in_barrier);
+	json_object_set_number(json_object(status), "ecc_err", wd->ws.wave_status.ecc_err);
+	json_object_set_number(json_object(status), "skip_export", wd->ws.wave_status.skip_export);
+	json_object_set_number(json_object(status), "perf_en", wd->ws.wave_status.perf_en);
+	json_object_set_number(json_object(status), "cond_dbg_user", wd->ws.wave_status.cond_dbg_user);
+	json_object_set_number(json_object(status), "cond_dbg_sys", wd->ws.wave_status.cond_dbg_sys);
+	json_object_set_number(json_object(status), "allow_replay", wd->ws.wave_status.allow_replay);
+	json_object_set_number(json_object(status), "fatal_halt", asic->family >= FAMILY_AI && wd->ws.wave_status.fatal_halt);
+	json_object_set_number(json_object(status), "must_export", wd->ws.wave_status.must_export);
+
+	json_object_set_value(json_object(wave), "status", status);
+
+	JSON_Value *hw_id = json_value_init_object();
+	if (asic->family < FAMILY_NV) {
+		json_object_set_number(json_object(hw_id), "value", wd->ws.hw_id.value);
+		json_object_set_number(json_object(hw_id), "wave_id", wd->ws.hw_id.wave_id);
+		json_object_set_number(json_object(hw_id), "simd_id", wd->ws.hw_id.simd_id);
+		json_object_set_number(json_object(hw_id), "pipe_id", wd->ws.hw_id.pipe_id);
+		json_object_set_number(json_object(hw_id), "cu_id", wd->ws.hw_id.cu_id);
+		json_object_set_number(json_object(hw_id), "sh_id", wd->ws.hw_id.sh_id);
+		json_object_set_number(json_object(hw_id), "tg_id", wd->ws.hw_id.tg_id);
+		json_object_set_number(json_object(hw_id), "state_id", wd->ws.hw_id.state_id);
+		json_object_set_number(json_object(hw_id), "vm_id", wd->ws.hw_id.vm_id);
+		vmid = wd->ws.hw_id.vm_id;
+	} else {
+		json_object_set_number(json_object(hw_id), "value", wd->ws.hw_id1.value);
+		json_object_set_number(json_object(hw_id), "wave_id", wd->ws.hw_id1.wave_id);
+		json_object_set_number(json_object(hw_id), "simd_id", wd->ws.hw_id1.simd_id);
+		json_object_set_number(json_object(hw_id), "wgp_id", wd->ws.hw_id1.wgp_id);
+		json_object_set_number(json_object(hw_id), "se_id", wd->ws.hw_id1.se_id);
+		json_object_set_number(json_object(hw_id), "sa_id", wd->ws.hw_id1.sa_id);
+		json_object_set_number(json_object(hw_id), "queue_id", wd->ws.hw_id2.queue_id);
+		json_object_set_number(json_object(hw_id), "pipe_id", wd->ws.hw_id2.pipe_id);
+		json_object_set_number(json_object(hw_id), "me_id", wd->ws.hw_id2.me_id);
+		json_object_set_number(json_object(hw_id), "state_id", wd->ws.hw_id2.state_id);
+		json_object_set_number(json_object(hw_id), "wg_id", wd->ws.hw_id2.wg_id);
+		json_object_set_number(json_object(hw_id), "compat_level", wd->ws.hw_id2.compat_level);
+		json_object_set_number(json_object(hw_id), "vm_id", wd->ws.hw_id2.vm_id);
+		vmid = wd->ws.hw_id2.vm_id;
+	}
+	json_object_set_value(json_object(wave), "hw_id", hw_id);
 
-	JSON_Value *waves = json_value_init_array();
-	while (wd) {
-		uint64_t pgm_addr = (((uint64_t)wd->ws.pc_hi << 32) | wd->ws.pc_lo);
-		unsigned vmid;
-
-		JSON_Value *wave = json_value_init_object();
-		json_object_set_number(json_object(wave), "se", wd->se);
-		json_object_set_number(json_object(wave), "sh", wd->sh);
-		json_object_set_number(json_object(wave), asic->family < FAMILY_NV ? "cu" : "wgp", wd->cu);
-		json_object_set_number(json_object(wave), "simd_id", wd->ws.hw_id1.simd_id);
-		json_object_set_number(json_object(wave), "wave_id", wd->ws.hw_id1.wave_id);
-		json_object_set_number(json_object(wave), "PC", pgm_addr);
-		json_object_set_number(json_object(wave), "wave_inst_dw0", wd->ws.wave_inst_dw0);
-		if (asic->family < FAMILY_NV)
-			json_object_set_number(json_object(wave), "wave_inst_dw1", wd->ws.wave_inst_dw1);
-
-		JSON_Value *status = json_value_init_object();
-		json_object_set_number(json_object(status), "value", wd->ws.wave_status.value);
-		json_object_set_number(json_object(status), "scc", wd->ws.wave_status.scc);
-		json_object_set_number(json_object(status), "execz", wd->ws.wave_status.execz);
-		json_object_set_number(json_object(status), "vccz", wd->ws.wave_status.vccz);
-		json_object_set_number(json_object(status), "in_tg", wd->ws.wave_status.in_tg);
-		json_object_set_number(json_object(status), "halt", wd->ws.wave_status.halt);
-		json_object_set_number(json_object(status), "valid", wd->ws.wave_status.valid);
-		json_object_set_number(json_object(status), "spi_prio", wd->ws.wave_status.spi_prio);
-		json_object_set_number(json_object(status), "wave_prio", wd->ws.wave_status.wave_prio);
-		json_object_set_number(json_object(status), "priv", wd->ws.wave_status.priv);
-		json_object_set_number(json_object(status), "trap_en", wd->ws.wave_status.trap_en);
-		json_object_set_number(json_object(status), "trap", wd->ws.wave_status.trap);
-		json_object_set_number(json_object(status), "ttrace_en", wd->ws.wave_status.ttrace_en);
-		json_object_set_number(json_object(status), "export_rdy", wd->ws.wave_status.export_rdy);
-		json_object_set_number(json_object(status), "in_barrier", wd->ws.wave_status.in_barrier);
-		json_object_set_number(json_object(status), "ecc_err", wd->ws.wave_status.ecc_err);
-		json_object_set_number(json_object(status), "skip_export", wd->ws.wave_status.skip_export);
-		json_object_set_number(json_object(status), "perf_en", wd->ws.wave_status.perf_en);
-		json_object_set_number(json_object(status), "cond_dbg_user", wd->ws.wave_status.cond_dbg_user);
-		json_object_set_number(json_object(status), "cond_dbg_sys", wd->ws.wave_status.cond_dbg_sys);
-		json_object_set_number(json_object(status), "allow_replay", wd->ws.wave_status.allow_replay);
-		json_object_set_number(json_object(status), "fatal_halt", asic->family >= FAMILY_AI && wd->ws.wave_status.fatal_halt);
-		json_object_set_number(json_object(status), "must_export", wd->ws.wave_status.must_export);
-
-		json_object_set_value(json_object(wave), "status", status);
-
-		JSON_Value *hw_id = json_value_init_object();
-		if (asic->family < FAMILY_NV) {
-			json_object_set_number(json_object(hw_id), "value", wd->ws.hw_id.value);
-			json_object_set_number(json_object(hw_id), "wave_id", wd->ws.hw_id.wave_id);
-			json_object_set_number(json_object(hw_id), "simd_id", wd->ws.hw_id.simd_id);
-			json_object_set_number(json_object(hw_id), "pipe_id", wd->ws.hw_id.pipe_id);
-			json_object_set_number(json_object(hw_id), "cu_id", wd->ws.hw_id.cu_id);
-			json_object_set_number(json_object(hw_id), "sh_id", wd->ws.hw_id.sh_id);
-			json_object_set_number(json_object(hw_id), "tg_id", wd->ws.hw_id.tg_id);
-			json_object_set_number(json_object(hw_id), "state_id", wd->ws.hw_id.state_id);
-			json_object_set_number(json_object(hw_id), "vm_id", wd->ws.hw_id.vm_id);
-			vmid = wd->ws.hw_id.vm_id;
+	JSON_Value *threads = json_value_init_array();
+	int num_threads = wd->num_threads;
+	for (int thread = 0; thread < num_threads; thread++) {
+		unsigned live = thread < 32 ? (wd->ws.exec_lo & (1u << thread))	: (wd->ws.exec_hi & (1u << (thread - 32)));
+		json_array_append_boolean(json_array(threads), live ? 1 : 0);
+	}
+	json_object_set_value(json_object(wave), "threads", threads);
+
+	JSON_Value *gpr_alloc = json_value_init_object();
+	json_object_set_number(json_object(gpr_alloc), "vgpr_base", wd->ws.gpr_alloc.vgpr_base);
+	json_object_set_number(json_object(gpr_alloc), "vgpr_size", wd->ws.gpr_alloc.vgpr_size);
+	json_object_set_number(json_object(gpr_alloc), "sgpr_base", wd->ws.gpr_alloc.sgpr_base);
+	json_object_set_number(json_object(gpr_alloc), "sgpr_size", wd->ws.gpr_alloc.sgpr_size);
+	json_object_set_value(json_object(wave), "gpr_alloc", gpr_alloc);
+
+	if (wd->ws.gpr_alloc.value != 0xbebebeef) {
+		int sgpr_count;
+		if (asic->family <= FAMILY_AI) {
+			int shift = asic->family <= FAMILY_CIK ? 3 : 4;
+			sgpr_count = (wd->ws.gpr_alloc.sgpr_size + 1) << shift;
 		} else {
-			json_object_set_number(json_object(hw_id), "value", wd->ws.hw_id1.value);
-			json_object_set_number(json_object(hw_id), "wave_id", wd->ws.hw_id1.wave_id);
-			json_object_set_number(json_object(hw_id), "simd_id", wd->ws.hw_id1.simd_id);
-			json_object_set_number(json_object(hw_id), "wgp_id", wd->ws.hw_id1.wgp_id);
-			json_object_set_number(json_object(hw_id), "se_id", wd->ws.hw_id1.se_id);
-			json_object_set_number(json_object(hw_id), "sa_id", wd->ws.hw_id1.sa_id);
-			json_object_set_number(json_object(hw_id), "queue_id", wd->ws.hw_id2.queue_id);
-			json_object_set_number(json_object(hw_id), "pipe_id", wd->ws.hw_id2.pipe_id);
-			json_object_set_number(json_object(hw_id), "me_id", wd->ws.hw_id2.me_id);
-			json_object_set_number(json_object(hw_id), "state_id", wd->ws.hw_id2.state_id);
-			json_object_set_number(json_object(hw_id), "wg_id", wd->ws.hw_id2.wg_id);
-			json_object_set_number(json_object(hw_id), "compat_level", wd->ws.hw_id2.compat_level);
-			json_object_set_number(json_object(hw_id), "vm_id", wd->ws.hw_id2.vm_id);
-			vmid = wd->ws.hw_id2.vm_id;
-		}
-		json_object_set_value(json_object(wave), "hw_id", hw_id);
-
-		JSON_Value *threads = json_value_init_array();
-		int num_threads = wd->num_threads;
-		for (int thread = 0; thread < num_threads; thread++) {
-			unsigned live = thread < 32 ? (wd->ws.exec_lo & (1u << thread))	: (wd->ws.exec_hi & (1u << (thread - 32)));
-			json_array_append_boolean(json_array(threads), live ? 1 : 0);
-		}
-		json_object_set_value(json_object(wave), "threads", threads);
-
-		JSON_Value *gpr_alloc = json_value_init_object();
-		json_object_set_number(json_object(gpr_alloc), "vgpr_base", wd->ws.gpr_alloc.vgpr_base);
-		json_object_set_number(json_object(gpr_alloc), "vgpr_size", wd->ws.gpr_alloc.vgpr_size);
-		json_object_set_number(json_object(gpr_alloc), "sgpr_base", wd->ws.gpr_alloc.sgpr_base);
-		json_object_set_number(json_object(gpr_alloc), "sgpr_size", wd->ws.gpr_alloc.sgpr_size);
-		json_object_set_value(json_object(wave), "gpr_alloc", gpr_alloc);
-
-		if (wd->ws.gpr_alloc.value != 0xbebebeef) {
-			int sgpr_count;
-			if (asic->family <= FAMILY_AI) {
-				int shift = asic->family <= FAMILY_CIK ? 3 : 4;
-				sgpr_count = (wd->ws.gpr_alloc.sgpr_size + 1) << shift;
-			} else {
-				sgpr_count = 108; // regular SGPRs and VCC
-			}
-			JSON_Value *sgpr = json_value_init_array();
-			for (int x = 0; x < sgpr_count; x++) {
-				json_array_append_number(json_array(sgpr), wd->sgprs[x]);
-			}
-			json_object_set_value(json_object(wave), "sgpr", sgpr);
-
-			if (wd->have_vgprs) {
-				unsigned granularity = asic->parameters.vgpr_granularity;
-				unsigned vpgr_count = (wd->ws.gpr_alloc.vgpr_size + 1) << granularity;
-				JSON_Value *vgpr = json_value_init_array();
-				for (int x = 0; x < (int) vpgr_count; x++) {
-					JSON_Value *v = json_value_init_array();
-					for (int thread = 0; thread < num_threads; thread++) {
-						json_array_append_number(json_array(v), wd->vgprs[thread * 256 + x]);
-					}
-					json_array_append_value(json_array(vgpr), v);
+			sgpr_count = 108; // regular SGPRs and VCC
+		}
+		JSON_Value *sgpr = json_value_init_array();
+		for (int x = 0; x < sgpr_count; x++) {
+			json_array_append_number(json_array(sgpr), wd->sgprs[x]);
+		}
+		json_object_set_value(json_object(wave), "sgpr", sgpr);
+
+		if (wd->have_vgprs) {
+			unsigned granularity = asic->parameters.vgpr_granularity;
+			unsigned vpgr_count = (wd->ws.gpr_alloc.vgpr_size + 1) << granularity;
+			JSON_Value *vgpr = json_value_init_array();
+			for (int x = 0; x < (int) vpgr_count; x++) {
+				JSON_Value *v = json_value_init_array();
+				for (int thread = 0; thread < num_threads; thread++) {
+					json_array_append_number(json_array(v), wd->vgprs[thread * 256 + x]);
 				}
-				json_object_set_value(json_object(wave), "vgpr", vgpr);
+				json_array_append_value(json_array(vgpr), v);
 			}
+			json_object_set_value(json_object(wave), "vgpr", vgpr);
+		}
 
-			/* */
-			if (include_shaders && (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt)) {
-				struct umr_shaders_pgm *shader = NULL;
-				uint32_t shader_size;
-				uint64_t shader_addr;
+		/* */
+		if (include_shaders && (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt)) {
+			struct umr_shaders_pgm *shader = NULL;
+			uint32_t shader_size;
+			uint64_t shader_addr;
 
-				if (ring_is_halted)
-					shader = umr_find_shader_in_stream(stream, vmid, pgm_addr);
+			if (stream)
+				shader = umr_find_shader_in_stream(stream, vmid, pgm_addr);
 
-				if (shader) {
-					shader_size = shader->size;
-					shader_addr = shader->addr;
-				} else {
-					#define NUM_OPCODE_WORDS 16
-					pgm_addr -= (NUM_OPCODE_WORDS*4)/2;
-					shader_addr = pgm_addr;
-					shader_size = NUM_OPCODE_WORDS * 4;
-					#undef NUM_OPCODE_WORDS
-				}
+			if (shader) {
+				shader_size = shader->size;
+				shader_addr = shader->addr;
+			} else {
+				#define NUM_OPCODE_WORDS 16
+				pgm_addr -= (NUM_OPCODE_WORDS*4)/2;
+				shader_addr = pgm_addr;
+				shader_size = NUM_OPCODE_WORDS * 4;
+				#undef NUM_OPCODE_WORDS
+			}
 
-				char tmp[128];
-				sprintf(tmp, "%lx", shader_addr);
-				/* This given shader isn't there, so read it. */
-				if (json_object_get_value(json_object(shaders), tmp) == NULL) {
-					JSON_Value *shader = shader_pgm_to_json(asic, vmid, shader_addr, shader_size);
-					if (shader)
-						json_object_set_value(json_object(shaders), tmp, shader);
-				}
-				json_object_set_string(json_object(wave), "shader", tmp);
+			char tmp[128];
+			sprintf(tmp, "%lx", shader_addr);
+			/* This given shader isn't there, so read it. */
+			if (json_object_get_value(json_object(shaders), tmp) == NULL) {
+				JSON_Value *shader = shader_pgm_to_json(asic, vmid, shader_addr, shader_size);
+				if (shader)
+					json_object_set_value(json_object(shaders), tmp, shader);
 			}
+			json_object_set_string(json_object(wave), "shader", tmp);
 		}
+	}
+
+	return wave;
+}
+
+static void waves_to_json(struct umr_asic *asic, int ring_is_halted, int include_shaders, JSON_Object *out) {
+	// TODO: This is using the deprecated API ...
+	struct umr_pm4_stream *stream = NULL; // umr_pm4_decode_ring(asic, asic->options.ring_name, 1, -1, -1);
+
+	struct umr_wave_data *wd = umr_scan_wave_data(asic);
+
+	JSON_Value *shaders = json_value_init_object();
+
+	JSON_Value *waves = json_value_init_array();
+	while (wd) {
+		JSON_Value *wave = wave_to_json(asic, wd, include_shaders, ring_is_halted ? stream : NULL, shaders);
 
 		json_array_append_value(json_array(waves), wave);
 
 		struct umr_wave_data *old = wd;
 		wd = wd->next;
 		free(old);
 	}
 
 	json_object_set_value(out, "waves", waves);
 	if (include_shaders)
@@ -2021,21 +2028,21 @@ JSON_Value *umr_process_json_request(JSON_Object *request, void **raw_data, unsi
 		}
 
 		asic->options.skip_gprs = 0;
 		asic->options.halt_waves = halt_waves;
 		asic->options.verbose = 0;
 
 		int ring_is_halted = umr_ring_is_halted(asic, asic->options.ring_name);
 
 		answer = json_value_init_object();
 
-		wave_to_json(asic, ring_is_halted, 1, json_object(answer));
+		waves_to_json(asic, ring_is_halted, 1, json_object(answer));
 
 		if (disable_gfxoff && asic->fd.gfxoff >= 0) {
 			uint32_t value = 1;
 			write(asic->fd.gfxoff, &value, sizeof(value));
 		}
 		if (resume_waves)
 			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME);
 	} else if (strcmp(command, "resume-waves") == 0) {
 		strcpy(asic->options.ring_name, json_object_get_string(request, "ring"));
 		umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME);
-- 
2.40.0

