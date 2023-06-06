Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C3CC7EE2F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BAB10E322;
	Tue,  6 Jun 2023 09:18:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C836610E31D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/pfOBh1ozEfn5n8Z4rZqhs3PeJkRiOIQ5f/M/VOOWynXkBQRfG7laXii1arnx3RlF/bOAZmd1H0Zxzc9dyCb6071VMkpUtOcAOYUuzad2enZE2RLFpoOxX7vta/XBdWIUlRnZ6XDVJ9nfYq3jcNJd45+MpLvAybGivsk77gZM1jIFeHhIj230hi9VLK3p1Q17dd2PROapdqH+z8utB0OfkYhsIDn8/2Ol1RnNL0bLe606Mpt0Ni2GQvVGLRvykxGvwFXB78bswjwJDBE+Kv+z2GCWIfFBEvY1WhVkyJ0u8wCWXnns2jwx49+GFFSfkhWxW1/Y//2wvu8S8hyJ+6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYEwKEcYpy6JV6nk/9Yc9//nIscNc9Wn4kkcnTHidZU=;
 b=QhxqNNlrfYoeEYEQasNk04VkCmLW50i28sMi6VCVQe7TfLVebCTn0OOFUKvMRiQy4zPt2/0mnQcvUvPE0xc4LpjBEogDQMf41N4e9NRsJOcAz+tE4AmLLzk6i+StmQWhLGpUGSJTXBFaQJ4MvarvcwjilAF8czxIgIFtNpsIgUO2dj+M8Y6ZJlk8zQY2jex2/yuuYyue8llHAjyQwE8IR2jNJjE0mnTSzyHHxi1Adx+d4Y8XOIKHu8Hn1R6COGyPiV8LJzHmPKpMVV0EI4cn/ozhX+6BTvT6XcPnCoFRoSW+9UJwhFdGW5e+QuyNeow8+nawVPdTLCdrGq/KbQVYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYEwKEcYpy6JV6nk/9Yc9//nIscNc9Wn4kkcnTHidZU=;
 b=wAPYb4Ko1EA43Pl4c1cNpneCm0Kvr+9Vd5pDMPzZ9WD6IscufgWzF8vy/53Jzlt1KedRbC/b8smTkJ3vkl2n15/qusq8W19ymXSoxEcTe7kblR9N6e3HgaEqpBWQtpl9v07FWOcsiW9v71c1bled68oZ77L6CzY1Qn/Sd5ZwpbU=
Received: from MW4PR03CA0067.namprd03.prod.outlook.com (2603:10b6:303:b6::12)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:17:58 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::c7) by MW4PR03CA0067.outlook.office365.com
 (2603:10b6:303:b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Tue, 6 Jun 2023 09:17:57 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:56 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 13/17] server/waves: fix ring halt logic
Date: Tue, 6 Jun 2023 11:17:21 +0200
Message-ID: <20230606091725.20080-14-nicolai.haehnle@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a11ba55-e502-4976-615b-08db666eeafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oR4pMKrduTmw63f8mlDknToSOrRNGwy0Ox1+ulCF13pBMYS9KK/eZfd5AxW6LF2d3FW2pbezsLyU4eZF2JFTNh/mcGu1lTHoeHIbvUuV5Vm/3xy4L7LSL/JGqMos/K/pZTwzspqrNTGVjxZRAQvEG9xWXjf4YibTfAnSkcAP4GsAnP2JEIAyC5QuhqY1pgwhjPCFPKbw+QUTMrFPmWPK/oIv1k4ZG8CHAqRHoSEYxdT5rI9T0nqpMjfiGivt/mzb5UyXCuMLvfnFSRsBq8tJP3xqLJYMvleivO7286Td0M9xthyi4LumWQVu7RVY0EEQuCxoM36pq6FZNDXy7AQyTjAnKr3YW39cUD/60ezdS0NgTMX+GV/TKIFagsUwAKxFBCv1uUQ+uUyuq7V9wSz1ui6uxZ9EtCNs5N5Rk45hlmmZgPd0dJHPv1xFWddk8ZsuY+LMqXthZIh6C9j3t04LbUIbooYSDwasPSUFAXVXfeN9r0l5C79i0ASQ+y/5eEIb9Hmcu1e2SiG3whrOkijdA0wQBpRBS4h4AhRb58I9uAs6w+QJMcRMDIs8qRjAXqXgYJm/4BQr9MgwywHEzdm9CS77fs6uX76hBzyI2rcTazI32XV44WCPq8GLRAM0z/2SMUy9qGVUEnQGi6q1faWHxU36uHOS3TImzciWfkA2prOABiR2KEz6DDznMYk405s/SdJWxh3kngf/XixT0QFGf4R1+2tUopvVepLiFiANY/sYW3pWgVAbwmryHDgD9FkJIqn4ZtEeHrn9aZNeIxLULA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(66574015)(47076005)(83380400001)(336012)(426003)(478600001)(82740400003)(40480700001)(8676002)(8936002)(41300700001)(316002)(356005)(70586007)(81166007)(70206006)(5660300002)(4326008)(6636002)(86362001)(40460700003)(36756003)(6666004)(2906002)(7696005)(82310400005)(36860700001)(110136005)(26005)(1076003)(16526019)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:57.6273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a11ba55-e502-4976-615b-08db666eeafb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
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

Whether GPRs can be read or not only depends on the state of the individual
wave, not on the state of any ring.

Use ring_is_halted only to gate the logic that tries to extract shader
references from PM4 for more convenient disassembly.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/app/gui/commands.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/app/gui/commands.c b/src/app/gui/commands.c
index 1e5e854..fbb11fa 100644
--- a/src/app/gui/commands.c
+++ b/src/app/gui/commands.c
@@ -1537,21 +1537,21 @@ void init_asics() {
 			}
 
 			index++;
 		} else {
 			fclose(opt.test_log_fd);
 			free(ip_discovery_dump);
 		}
 	}
 }
 
-static void wave_to_json(struct umr_asic *asic, int is_halted, int include_shaders, JSON_Object *out) {
+static void wave_to_json(struct umr_asic *asic, int ring_is_halted, int include_shaders, JSON_Object *out) {
 	// TODO: This is using the deprecated API ...
 	struct umr_pm4_stream *stream = NULL; // umr_pm4_decode_ring(asic, asic->options.ring_name, 1, -1, -1);
 
 	struct umr_wave_data *wd = umr_scan_wave_data(asic);
 
 	JSON_Value *shaders = json_value_init_object();
 
 	JSON_Value *waves = json_value_init_array();
 	while (wd) {
 		uint64_t pgm_addr = (((uint64_t)wd->ws.pc_hi << 32) | wd->ws.pc_lo);
@@ -1633,21 +1633,21 @@ static void wave_to_json(struct umr_asic *asic, int is_halted, int include_shade
 		}
 		json_object_set_value(json_object(wave), "threads", threads);
 
 		JSON_Value *gpr_alloc = json_value_init_object();
 		json_object_set_number(json_object(gpr_alloc), "vgpr_base", wd->ws.gpr_alloc.vgpr_base);
 		json_object_set_number(json_object(gpr_alloc), "vgpr_size", wd->ws.gpr_alloc.vgpr_size);
 		json_object_set_number(json_object(gpr_alloc), "sgpr_base", wd->ws.gpr_alloc.sgpr_base);
 		json_object_set_number(json_object(gpr_alloc), "sgpr_size", wd->ws.gpr_alloc.sgpr_size);
 		json_object_set_value(json_object(wave), "gpr_alloc", gpr_alloc);
 
-		if (is_halted && wd->ws.gpr_alloc.value != 0xbebebeef) {
+		if (wd->ws.gpr_alloc.value != 0xbebebeef) {
 			int sgpr_count;
 			if (asic->family <= FAMILY_AI) {
 				int shift = asic->family <= FAMILY_CIK ? 3 : 4;
 				sgpr_count = (wd->ws.gpr_alloc.sgpr_size + 1) << shift;
 			} else {
 				sgpr_count = 108; // regular SGPRs and VCC
 			}
 			JSON_Value *sgpr = json_value_init_array();
 			for (int x = 0; x < sgpr_count; x++) {
 				json_array_append_number(json_array(sgpr), wd->sgprs[x]);
@@ -1663,23 +1663,27 @@ static void wave_to_json(struct umr_asic *asic, int is_halted, int include_shade
 					for (int thread = 0; thread < num_threads; thread++) {
 						json_array_append_number(json_array(v), wd->vgprs[thread * 256 + x]);
 					}
 					json_array_append_value(json_array(vgpr), v);
 				}
 				json_object_set_value(json_object(wave), "vgpr", vgpr);
 			}
 
 			/* */
 			if (include_shaders && (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt)) {
-				struct umr_shaders_pgm *shader = umr_find_shader_in_stream(stream, vmid, pgm_addr);
+				struct umr_shaders_pgm *shader = NULL;
 				uint32_t shader_size;
 				uint64_t shader_addr;
+
+				if (ring_is_halted)
+					shader = umr_find_shader_in_stream(stream, vmid, pgm_addr);
+
 				if (shader) {
 					shader_size = shader->size;
 					shader_addr = shader->addr;
 				} else {
 					#define NUM_OPCODE_WORDS 16
 					pgm_addr -= (NUM_OPCODE_WORDS*4)/2;
 					shader_addr = pgm_addr;
 					shader_size = NUM_OPCODE_WORDS * 4;
 					#undef NUM_OPCODE_WORDS
 				}
@@ -2013,25 +2017,25 @@ JSON_Value *umr_process_json_request(JSON_Object *request, void **raw_data, unsi
 		}
 
 		if (halt_waves) {
 			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_HALT);
 		}
 
 		asic->options.skip_gprs = 0;
 		asic->options.halt_waves = halt_waves;
 		asic->options.verbose = 0;
 
-		int is_halted = umr_ring_is_halted(asic, asic->options.ring_name);
+		int ring_is_halted = umr_ring_is_halted(asic, asic->options.ring_name);
 
 		answer = json_value_init_object();
 
-		wave_to_json(asic, is_halted, 1, json_object(answer));
+		wave_to_json(asic, ring_is_halted, 1, json_object(answer));
 
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

