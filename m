Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB36BC7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4914610E30C;
	Tue,  6 Jun 2023 09:17:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E458210E30E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUkBrvhpAdMJrG6OCqw476Q4QqRrW9lL6Nkcr6LiWw77pfhDnu5pXrLnWas3uSjehz3EGSAX41ZrezBZFTjmiNuwOLwtzpRtJwzwDw18JSLVUKtlTzdV0C+tgxLNQ7ALNH3LCIQE0Rz4YSsML1pWmADfy9Cdg/CtwrLBVaKz9dtbnSn9CgcvcrV2qgui5CY3gTFU+/sUvP88I3VitBG7M2mby94MHa/OMzMX22W7jqHA0QhUNNIZl+qlwbP4d4ItqOcQDWZsZFijbPQjubLoVUS0imln9M0peO3vNeU7Pk8dH9QdWBy4S6DXg5sipQvQrSMBIjNMa9XZSbfiyPAu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fpv5ONOaMw1Gt4+ls3nl29wwhgfT+8sV4l9E8vU6DHI=;
 b=Oel55zjL7ifpUUzsQTNCQdiS4fIYVOaqLaFaWbrlRUWN7vObOlhFHS9Rf5oh3uMzmxCXa31g75NZvYpWGnwjJ+7WrOEeH8eMDj9RdA8e/Pdai+WFRge0kdoj/s0yEXgZQnKV3lkmM/IKK6HDCLftEpP96GeU3DeeuCAJgu3NQj8OdJnIQb2zLCBwnF52kMg3XzMnexHzMTrBocuJW/k+PMGNTy/MiV82K07nC5UcR9O/rBVmxJTE6PZChyvPfvx3bQO8K7oxEQtKwWqdN4tt7cRWLshZV3OJSyOiEw3HffGW6R3M0xN15SlKuqX5rjmWk/fUcER7vCXpa2lLgZtXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpv5ONOaMw1Gt4+ls3nl29wwhgfT+8sV4l9E8vU6DHI=;
 b=GSnmLw9C30Mn0YPxOCR8GSOuar8g5I5TxkRP4jVtjIsFkzSETezNWCWIqxWBoJPKD2/Z0Q25vLYus2ktxzu1kNuxSiSmL7TKZD5W336k63tVQR4vMpT88CEXWdEVKJJS4S5JQfBlIw9zreHdeT/bmYu3ofMywYH09W+guywXIgw=
Received: from MW4PR03CA0064.namprd03.prod.outlook.com (2603:10b6:303:b6::9)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:17:51 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::1d) by MW4PR03CA0064.outlook.office365.com
 (2603:10b6:303:b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Tue, 6 Jun 2023 09:17:50 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:48 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 05/17] gfx10+: fix SGPR counts
Date: Tue, 6 Jun 2023 11:17:13 +0200
Message-ID: <20230606091725.20080-6-nicolai.haehnle@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b28327-faae-4199-1396-08db666ee6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8JXtjiBGJtj+8T6GdIpjbjU09bRkkW+ZFgpw8Kkarh8jF/1BRb4brIagL248du6zYK8x+tx0dHro/618d/kC8y3Lfo4EaymFV7qFYFpJF64Wt8+slZM9nYDHMs5fD3Px4y+f1mUwI/u4mNfZCb1152ZpvmezNA7CS7qdtD34CuBUJJoXG7gPv+KkmwW9bcle6CNnc54+G1sm7tj8vleMIMp/U3o1ucSdj7yfoiGVYzJq7Cqri7fdhmcLUMfI7FrnbxDybG+LRNihHr6iYxIE3uC1dsnYD80Bt2BKBSBmJAGqVM5Q/TQyz5az9BnsFwvJgU3V0s6EOr++IkS7NWpRKedagZaOF/IPF4eoGw37WieqzuVE54PuAYsso5FK8rvDq9NL2PBl6rTlJ/lelyD7XVtbhp7S2PrNH/uz6kROwMHOJiLaiBjqzs2cf+w1LsBcf1QcIWbzbNQZmjv+WJ4w3Si9grE8YIPa0Bf/KztOC4rztFxIwRfrVbPg64UqiZPnqWfceO5R3qXSvri376RNcx/lhs5gGoeBZvwcAfVvOiwJhdUby/qntvqCG77Ja6vhccDObjUWCy1tsKtZy8uROHNrOhzExBUmIjzH7oF0lez1aPFsLQY7GgtbIzYc2vO0IMD/xB256r/BfbhcHMxbWTGCG+QN+5+jxeCRMEn7FkdztpbbvJyvYknyrX2viJMeg+/tMkL9BXS01o8pLsrK0Pf0f4JnNSDL0rhngaVAhG3/Dr2eUSD1tbc1866HVZFgnaisGucC9tSAEp1oz5frQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(7696005)(6666004)(82740400003)(2906002)(81166007)(356005)(70586007)(70206006)(110136005)(5660300002)(8936002)(36756003)(86362001)(8676002)(40480700001)(41300700001)(4326008)(6636002)(316002)(478600001)(40460700003)(426003)(336012)(2616005)(1076003)(26005)(16526019)(186003)(36860700001)(82310400005)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:50.8776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b28327-faae-4199-1396-08db666ee6f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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

On gfx10+, every wave has 106 regular SGPRs followed immediately by VCC,
meaning we should show 108 SGPRs by default.

They are followed by 16 TTMPs, for 124 in total.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/app/gui/commands.c                | 16 ++++++++--------
 src/app/print_waves.c                 |  4 ++--
 src/lib/lowlevel/linux/read_gprwave.c |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/app/gui/commands.c b/src/app/gui/commands.c
index 45bb9d4..b7b28a7 100644
--- a/src/app/gui/commands.c
+++ b/src/app/gui/commands.c
@@ -1626,29 +1626,29 @@ static void wave_to_json(struct umr_asic *asic, int is_halted, int include_shade
 		json_object_set_value(json_object(wave), "hw_id", hw_id);
 
 		JSON_Value *gpr_alloc = json_value_init_object();
 		json_object_set_number(json_object(gpr_alloc), "vgpr_base", wd->ws.gpr_alloc.vgpr_base);
 		json_object_set_number(json_object(gpr_alloc), "vgpr_size", wd->ws.gpr_alloc.vgpr_size);
 		json_object_set_number(json_object(gpr_alloc), "sgpr_base", wd->ws.gpr_alloc.sgpr_base);
 		json_object_set_number(json_object(gpr_alloc), "sgpr_size", wd->ws.gpr_alloc.sgpr_size);
 		json_object_set_value(json_object(wave), "gpr_alloc", gpr_alloc);
 
 		if (is_halted && wd->ws.gpr_alloc.value != 0xbebebeef) {
-			int shift;
-			if (asic->family <= FAMILY_CIK || asic->family >= FAMILY_NV)
-				shift = 3;
-			else
-				shift = 4;
-
-			int spgr_count = (wd->ws.gpr_alloc.sgpr_size + 1) << shift;
+			int sgpr_count;
+			if (asic->family <= FAMILY_AI) {
+				int shift = asic->family <= FAMILY_CIK ? 3 : 4;
+				sgpr_count = (wd->ws.gpr_alloc.sgpr_size + 1) << shift;
+			} else {
+				sgpr_count = 108; // regular SGPRs and VCC
+			}
 			JSON_Value *sgpr = json_value_init_array();
-			for (int x = 0; x < spgr_count; x++) {
+			for (int x = 0; x < sgpr_count; x++) {
 				json_array_append_number(json_array(sgpr), wd->sgprs[x]);
 			}
 			json_object_set_value(json_object(wave), "sgpr", sgpr);
 
 			JSON_Value *threads = json_value_init_array();
 			int num_threads = wd->num_threads;
 			for (int thread = 0; thread < num_threads; thread++) {
 				unsigned live = thread < 32 ? (wd->ws.exec_lo & (1u << thread))	: (wd->ws.exec_hi & (1u << (thread - 32)));
 				json_array_append_boolean(json_array(threads), live ? 1 : 0);
 			}
diff --git a/src/app/print_waves.c b/src/app/print_waves.c
index de93f93..04a4447 100644
--- a/src/app/print_waves.c
+++ b/src/app/print_waves.c
@@ -467,21 +467,21 @@ static void umr_print_waves_gfx_10_11(struct umr_asic *asic)
 					(unsigned)wd->ws.hw_id1.wave_id, // TODO: wgp printed out won't match geometry for now w.r.t. to SPI
 					(unsigned long)wd->ws.wave_status.value, (unsigned long)wd->ws.pc_hi, (unsigned long)wd->ws.pc_lo,
 					(unsigned long)wd->ws.wave_inst_dw0, (unsigned long)wd->ws.exec_hi, (unsigned long)wd->ws.exec_lo,
 					(unsigned long)wd->ws.hw_id1.value, (unsigned long)wd->ws.hw_id2.value, (unsigned long)wd->ws.gpr_alloc.value,
 					(unsigned long)wd->ws.lds_alloc.value, (unsigned long)wd->ws.trapsts.value,
 					(unsigned long)wd->ws.ib_sts.value, (unsigned long)wd->ws.ib_sts2.value, (unsigned long)wd->ws.ib_dbg1,
 					(unsigned long)wd->ws.m0, (unsigned long)wd->ws.mode.value);
 			}
 
 			if (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt) {
-				for (x = 0; x < 112; x += 4)
+				for (x = 0; x < 108; x += 4)
 					printf(">SGPRS[%u..%u] = { %08lx, %08lx, %08lx, %08lx }\n",
 						(unsigned)(x),
 						(unsigned)(x + 3),
 						(unsigned long)wd->sgprs[x],
 						(unsigned long)wd->sgprs[x+1],
 						(unsigned long)wd->sgprs[x+2],
 						(unsigned long)wd->sgprs[x+3]);
 
 
 				if (wd->ws.wave_status.trap_en || wd->ws.wave_status.priv) {
@@ -567,21 +567,21 @@ static void umr_print_waves_gfx_10_11(struct umr_asic *asic)
 			PP(hw_id2, vm_id);
 
 			Hv("GPR_ALLOC", wd->ws.gpr_alloc.value);
 			PP(gpr_alloc, vgpr_base);
 			PP(gpr_alloc, vgpr_size);
 			PP(gpr_alloc, sgpr_base);
 			PP(gpr_alloc, sgpr_size);
 
 			if (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt) {
 				printf("\n\nSGPRS:\n");
-				for (x = 0; x < 112; x += 4)
+				for (x = 0; x < 108; x += 4)
 					printf("\t[%4u..%4u] = { %08lx, %08lx, %08lx, %08lx }\n",
 						(unsigned)(x),
 						(unsigned)(x + 3),
 						(unsigned long)wd->sgprs[x],
 						(unsigned long)wd->sgprs[x+1],
 						(unsigned long)wd->sgprs[x+2],
 						(unsigned long)wd->sgprs[x+3]);
 
 				if (wd->ws.wave_status.trap_en || wd->ws.wave_status.priv) {
 					for (y  = 0, x = 0x6C; x < (16 + 0x6C); x += 4, y += 4) {
diff --git a/src/lib/lowlevel/linux/read_gprwave.c b/src/lib/lowlevel/linux/read_gprwave.c
index e861ee4..6d68b7e 100644
--- a/src/lib/lowlevel/linux/read_gprwave.c
+++ b/src/lib/lowlevel/linux/read_gprwave.c
@@ -99,21 +99,21 @@ static int read_gpr_gprwave(struct umr_asic *asic, int v_or_s, uint32_t thread,
 			id.gpr.thread = thread;
 			size = 4 * ((ws->gpr_alloc.vgpr_size + 1) << asic->parameters.vgpr_granularity);
 		}
 	} else {
 		id.se = ws->hw_id1.se_id;
 		id.sh = ws->hw_id1.sa_id;
 		id.cu = ((ws->hw_id1.wgp_id << 2) | ws->hw_id1.simd_id);
 		id.wave = ws->hw_id1.wave_id;
 		if (v_or_s == 0) {
 			id.gpr.thread = 0;
-			size = 4 * 112;
+			size = 4 * 124; // regular SGPRs, VCC, and TTMPs
 		} else {
 			id.gpr.thread = thread;
 			size = 4 * ((ws->gpr_alloc.vgpr_size + 1) << asic->parameters.vgpr_granularity);
 		}
 	}
 	id.gpr.vpgr_or_sgpr = v_or_s;
 	id.xcc_id = asic->options.vm_partition == -1 ? 0 : asic->options.vm_partition;
 
 	r = ioctl(asic->fd.gprwave, AMDGPU_DEBUGFS_GPRWAVE_IOC_SET_STATE, &id);
 	if (r)
-- 
2.40.0

