Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712A0CC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 20:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D622A10EA32;
	Tue, 13 Oct 2026 20:11:15 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010002.outbound.protection.outlook.com
 [52.101.193.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A66410EA28
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 20:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Quc/G0fQpYMUDBhuvu85Xvm+U4LSMrC7VltiVxIkJ30SIhWeGfdM6jB0C6+Ff4rzoorDQ8Huev9tWzpc32DaaJOI11cJs2xY728v+iFkcoPxqY/eZ2eXkHKq3rQfXoqB5AU0ef9xMyxP1DLekrV3ZSL5Tu2sr0W+J1OekQHEOiYqQPu8zFVOFCv8bnkKOS14Mj7bO2i/Fv1dBCAy26G47Q6FeMt1iYwF6mXccsRqjCdejLMBCQ/v6TfNZ7xUt/Z48kSxmC3YKbFbA/j+/X+Wn95UbcHhKKGioKMNwIUWO2FOFlzsypI5ALfJKZ0f2+BrCq0XfqtiMIiMIj1Z+v5w9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFw4gDIkgvyBopZb4j8AaqvcwBJUULrtZiTrXAk5gaU=;
 b=G7yzE6Ob95v84O9E2QsziXbbIo8Zb8dFii2O7rM8E0CblTq05SWZEgfylTqmabWiNwJpdbWSmPFhi5q6J7y4FLYh4BLEbvlNjCXpe7nN7Npo907CXt7F7243AXFWSCCsDOSX64QeSJI3C8vfE+dfCeJy3pOTgCLfDpEVbr0/S0wGxPCsoOSjEdDVQQHUFf606JaVBk7dgG9MNdfeYndIA0ndz9/7QwnTo21ysLbx35E0odPt+OTrUfYpQBQCblFFTgSrkBCFc4SI6r6+KYD07Vn0bA6eesu4GmhwfqfdIAtqLGn/EB1USS87RI399VW3wh/6kWwDSH+TffoM7BXFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFw4gDIkgvyBopZb4j8AaqvcwBJUULrtZiTrXAk5gaU=;
 b=1XC3lVAnjlCXO1L9sLKaFv4D+mobtZvKOgUpHqbcjOO9nM70qq9yuORyQ973QA4vRhHaXmg03tetq/3TWthEwEyzfm8wzjBx0Jl6cLUw6OShaj3IxWkgRRiP1jUcFdudLDlGr9nept8br6Z9xt4uF1Gty7mBvPNukXM2yjMPQKg=
Received: from BN0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:408:ea::29)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 20:11:00 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::1e) by BN0PR04CA0084.outlook.office365.com
 (2603:10b6:408:ea::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 20:11:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 20:10:59 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 13 Oct 2026 15:10:53 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: log mes_dbgext from every MES pipe
Date: Tue, 13 Oct 2026 16:10:42 -0400
Message-ID: <20261013201042.2140720-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: a76b8bac-0adf-4394-3c94-08df29661946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 35x4+mbqwM2I7il1gR7a4+pfBYKdAHn9lorchtZcHUiUGlkAYRP97uwSWkjQdoG7s6WKuJPaV8BM1bSXm8Lh+vU7BChDOL1GPvM6D0E5uFa+8aN8+8lAT4Jca04ILhvFVxIL8qdpXyo9c5DfKgHY2dB0wBVALrB6b1H+FQrEsZNqcd6fW0u2l3uyG9t5cC9c3G+5KY5y6uctxr8GieuajBjYcF+KfNN+vgI8XJASM0gzfinm098bCzm18qpye5V7hk7uJY2rGS9hfmb+sPaKEIIL0SdMmtGPVMWx64Ky898jv87dtFLdWm0KjUvUbv0AJ/2z/TRkEf8dILdjvB9cH9BbPX1J76zA+zLenEaTSFM/jeNkG9VQI6nEhkOTU4q+2qUU6GPz/gN/ZnVuF8RIUHrfhBPfHzTBlyAwSspvvSRntv1sZjblOfHCHXoyyye/B8pEhnZVLstZ9cwNeaCyLiAjyHCggwx/ufdHMmrTMuHYzCjaMC3jCAwaxRV9AqxzaxHRNt5rs3gh4ObzK4JTIPzHCyu3HShoGqB0MiMdBi48f3ba5TuOpr8Sl9rVreQTEmKI3jiiGvFPsHR9PVt9mF/6kIr9WHri6RBkkRkSS7iZTo7/yu4LHEMZsTTlTFBoxWP+pv63ntt/uZATzDJ4cDsjOaehzNr6F6adHZ94Q/GCelVtg+YqAbEXAJkogmi+zR15Vo/WDojZuvsV+Xow9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2NXn4Xh1cwaIQgsb8zU/k05qJ9Z8HZdch+xMX71R3Ik5o15zWuB9ep5DqG6k7n7T8wbtFR8rI0A2qVcL/cLO+NG0Swblv8/Cs2jhzUSZM74C44ZmsIle/EZtWo/tTHJJZnjj3rbD+R3II8RoStbDb9auI+CDdZPlvyOukXyP2dR2s1RFPdchQEJ61+m/VHhWGprXHxxireyx3FyTsGFLXaL3+x5zeS01mU4SdKyx2wJQMHJ82mt/PDdPoFE/JBKs2e9NaMurRwE+fbSaKFFvFVGtQ/7FPhi+yBTQJg1PIgv3x+Hp3yieJZXTvMh9I5GdKd7gGDAqdSVzSXp0SFBoPRWsMFUi3ne+nrSR/sgIMu3oXleV3QGTAOjgEUDhXXs78sq5iBPhpHUs6feI9RQziScVHBvGSgIV/ptJjxs/b2rSDlADOv/Lgy+nzGzUqNzj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 20:10:59.6902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76b8bac-0adf-4394-3c94-08df29661946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
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

Under unified MES both pipes of each XCC run MES firmware, each with its
own scheduler context, and the firmware attaches the dbgext log buffer
only to the pipe that received SETUP_MES_DBGEXT. With a single region
per XCC only one pipe's messages were collected.

Give every (xcc, pipe) its own region in the log buffer, pass the target
pipe in the setup request, and arm, detach and drain every region. Tag
output with the source XCC and pipe ("0"-sched/"1"-kiq) when more than one
region is logged; single-region output is unchanged.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 157 ++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  10 +-
 2 files changed, 102 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8d813c68450b..05bbbd1afb63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1339,8 +1339,13 @@ static void mes_dbgext_buf_read(const u8 *buf, u32 buffer_size, u32 hdr_size,
 	}
 }
 
+static const char *mes_dbgext_pipe_name(u32 pipe)
+{
+	return pipe == AMDGPU_MES_SCHED_PIPE ? "0" : "1";
+}
+
 static void mes_dbgext_print_item(struct amdgpu_device *adev, int xcc,
-				  u32 type, char *text)
+				  int pipe, u32 type, char *text)
 {
 	size_t n = strlen(text);
 	char pfx[12] = "";
@@ -1351,21 +1356,24 @@ static void mes_dbgext_print_item(struct amdgpu_device *adev, int xcc,
 	while (n && (text[n - 1] == '\n' || text[n - 1] == '\r'))
 		text[--n] = '\0';
 
-	/* Tag with the source XCC only when more than one is being logged, so
-	 * single-XCC (gfx11/gfx12) output is unchanged.
+	/* Tag with the source XCC and MES pipe (sched/kiq) only when more than
+	 * one region is being logged, so single-region output is unchanged.
 	 */
-	if (adev->mes.dbgext_num_xcc > 1)
-		snprintf(pfx, sizeof(pfx), " xcc%d", xcc);
+	if (adev->mes.dbgext_num_pipes > 1)
+		snprintf(pfx, sizeof(pfx), "(%d,%s)", xcc,
+			 mes_dbgext_pipe_name(pipe));
+	else if (adev->mes.dbgext_num_xcc > 1)
+		snprintf(pfx, sizeof(pfx), "(%d)", xcc);
 
 	switch (type) {
 	case MES_DBGEXT_MSG_ASSERT:
-		dev_err(adev->dev, "[mes_dbgext%s] ASSERT %s\n", pfx, text);
+		dev_err(adev->dev, "[mes_dbgext] %s ASSERT %s\n", pfx, text);
 		break;
 	case MES_DBGEXT_MSG:
-		dev_info(adev->dev, "[mes_dbgext%s] %s\n", pfx, text);
+		dev_info(adev->dev, "[mes_dbgext] %s %s\n", pfx, text);
 		break;
 	default:
-		dev_warn(adev->dev, "[mes_dbgext%s] %s\n", pfx, text);
+		dev_warn(adev->dev, "[mes_dbgext] %s %s\n", pfx, text);
 		break;
 	}
 }
@@ -1376,7 +1384,7 @@ static void mes_dbgext_print_item(struct amdgpu_device *adev, int xcc,
  * caller-provided scratch of at least MES_DBGEXT_MAX_ITEM_SIZE + 1 bytes.
  */
 static void mes_dbgext_process_zone(struct amdgpu_device *adev, u8 *zbase,
-				    u8 *item, int xcc)
+				    u8 *item, int xcc, int pipe)
 {
 	struct mes_dbgext_zone_header *zh =
 		(struct mes_dbgext_zone_header *)zbase;
@@ -1438,7 +1446,7 @@ static void mes_dbgext_process_zone(struct amdgpu_device *adev, u8 *zbase,
 			mes_dbgext_buf_read(zbase, buffer_size, hdr_size, rptr,
 					    item, len);
 			item[len] = '\0';
-			mes_dbgext_print_item(adev, xcc, type,
+			mes_dbgext_print_item(adev, xcc, pipe, type,
 				(char *)item + MES_DBGEXT_ITEM_HDR_SIZE);
 		}
 
@@ -1461,11 +1469,12 @@ static void mes_dbgext_process_zone(struct amdgpu_device *adev, u8 *zbase,
 }
 
 /*
- * Drain one per-XCC region: parse its zone table (a zone_count dword followed
- * by per-zone {offset,length} descriptors) and drain each zone.  @base points
- * at the region start; @xcc tags the output.
+ * Drain one per-(xcc, pipe) region: parse its zone table (a zone_count dword
+ * followed by per-zone {offset,length} descriptors) and drain each zone.
+ * @base points at the region start; @xcc and @pipe tag the output.
  */
-static void mes_dbgext_process_region(struct amdgpu_device *adev, u8 *base, int xcc)
+static void mes_dbgext_process_region(struct amdgpu_device *adev, u8 *base,
+				      int xcc, int pipe)
 {
 	struct amdgpu_mes *mes = &adev->mes;
 	u32 zone_count, hdr_len, z;
@@ -1499,32 +1508,41 @@ static void mes_dbgext_process_region(struct amdgpu_device *adev, u8 *base, int
 		    zlen > mes->dbgext_log_size - zoff)
 			continue;
 
-		mes_dbgext_process_zone(adev, base + zoff, item, xcc);
+		mes_dbgext_process_zone(adev, base + zoff, item, xcc, pipe);
 	}
 
 	kfree(item);
 }
 
+static u32 mes_dbgext_num_pipes(struct amdgpu_mes *mes)
+{
+	return mes->dbgext_num_pipes ? mes->dbgext_num_pipes : 1;
+}
+
+static u32 mes_dbgext_num_regions(struct amdgpu_mes *mes)
+{
+	return (mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1) *
+	       mes_dbgext_num_pipes(mes);
+}
+
 static void mes_dbgext_process_all(struct amdgpu_device *adev)
 {
 	struct amdgpu_mes *mes = &adev->mes;
-	u32 num_xcc = mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1;
+	u32 num_pipes = mes_dbgext_num_pipes(mes);
+	u32 num_regions = mes_dbgext_num_regions(mes);
 	u8 *buf = mes->dbgext_log_cpu_addr;
-	u32 xcc;
+	u32 i;
 
 	if (!buf)
 		return;
 
 	/*
-	 * The buffer holds num_xcc back-to-back per-XCC regions, each
-	 * dbgext_log_size bytes.  Drain each region and tag its output with the
-	 * source XCC (single-XCC ASICs have exactly one region).
+	 * Every armed (xcc, pipe) raises the same host interrupt, so drain all
+	 * regions; each is a no-op when it has no new data.
 	 */
-	for (xcc = 0; xcc < num_xcc; xcc++) {
-		u8 *base = buf + xcc * mes->dbgext_log_size;
-
-		mes_dbgext_process_region(adev, base, xcc);
-	}
+	for (i = 0; i < num_regions; i++)
+		mes_dbgext_process_region(adev, buf + i * mes->dbgext_log_size,
+					  i / num_pipes, i % num_pipes);
 }
 
 static int amdgpu_mes_dbgext_reader(void *param)
@@ -1577,7 +1595,8 @@ void amdgpu_mes_dbgext_notify(struct amdgpu_device *adev, u32 context_data)
 }
 
 static int amdgpu_mes_dbgext_setup_fw(struct amdgpu_device *adev, u32 xcc_id,
-				      u64 log_buffer_mc_addr, u64 log_options)
+				      u32 pipe, u64 log_buffer_mc_addr,
+				      u64 log_options)
 {
 	struct amdgpu_mes *mes = &adev->mes;
 	struct mes_misc_op_input op_input = {0};
@@ -1590,6 +1609,7 @@ static int amdgpu_mes_dbgext_setup_fw(struct amdgpu_device *adev, u32 xcc_id,
 	op_input.op = MES_MISC_OP_SETUP_MES_DBGEXT;
 	op_input.setup_mes_dbgext.log_buffer_mc_addr = log_buffer_mc_addr;
 	op_input.setup_mes_dbgext.log_options = log_options;
+	op_input.setup_mes_dbgext.pipe = pipe;
 
 	amdgpu_mes_lock(mes);
 	r = mes->funcs->misc_op(mes, &op_input);
@@ -1606,7 +1626,7 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	u64 fw_options;
 	u32 size;
 	u32 req_kb;
-	u32 num_xcc, xcc;
+	u32 num_xcc, num_pipes, num_regions, i;
 	int r;
 
 	/*
@@ -1636,15 +1656,21 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	}
 
 	/*
-	 * Log every XCC's MES firmware.  Each XCC runs its own MES and gets its
-	 * own per-XCC region within one buffer (see dbgext_num_xcc); single-XCC
-	 * ASICs (gfx11/gfx12) collapse to a single region.
+	 * Log every MES firmware instance: each XCC runs its own MES, and under
+	 * unified MES both pipes of each XCC run firmware with their own
+	 * context, so each (xcc, pipe) gets its own region within one buffer
+	 * (see dbgext_num_xcc/dbgext_num_pipes).  Without unified MES the KIQ
+	 * pipe is driven through the gfx KIQ ring and cannot take MES API
+	 * packets, so only the scheduler pipe is logged.
 	 */
 	num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	num_pipes = adev->enable_uni_mes ? AMDGPU_MAX_MES_PIPES : 1;
+	num_regions = num_xcc * num_pipes;
 	mes->dbgext_num_xcc = num_xcc;
+	mes->dbgext_num_pipes = num_pipes;
 
 	if (!mes->dbgext_log_gpu_obj) {
-		/* Clamp to a sane range (4 KB .. 1 MB), per XCC. */
+		/* Clamp to a sane range (4 KB .. 1 MB), per region. */
 		size = clamp(req_kb, 4U, 1024U);
 		size = ALIGN((u32)size * SZ_1K, PAGE_SIZE);
 		/*
@@ -1655,8 +1681,8 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 		if (size < SZ_8K)
 			size = SZ_8K;
 
-		/* One buffer holds num_xcc back-to-back per-XCC regions. */
-		r = amdgpu_bo_create_kernel(adev, size * num_xcc, PAGE_SIZE,
+		/* One buffer holds num_regions back-to-back regions. */
+		r = amdgpu_bo_create_kernel(adev, size * num_regions, PAGE_SIZE,
 					    AMDGPU_GEM_DOMAIN_GTT,
 					    &mes->dbgext_log_gpu_obj,
 					    &mes->dbgext_log_gpu_addr,
@@ -1678,13 +1704,13 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	}
 
 	/*
-	 * (Re)initialize each per-XCC region's header.  On resume the MES was
-	 * reset and re-lays its header, and the driver's rptr/wptr must restart
-	 * clean.  Clear the whole buffer once, then seed every region.
+	 * (Re)initialize each region's header.  On resume the MES was reset and
+	 * re-lays its header, and the driver's rptr/wptr must restart clean.
+	 * Clear the whole buffer once, then seed every region.
 	 */
-	memset(mes->dbgext_log_cpu_addr, 0, size * num_xcc);
-	for (xcc = 0; xcc < num_xcc; xcc++) {
-		u8 *base = (u8 *)mes->dbgext_log_cpu_addr + xcc * size;
+	memset(mes->dbgext_log_cpu_addr, 0, size * num_regions);
+	for (i = 0; i < num_regions; i++) {
+		u8 *base = (u8 *)mes->dbgext_log_cpu_addr + i * size;
 
 		/*
 		 * mes_aux: seed only the total region size in the first dword.
@@ -1736,18 +1762,20 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	if (use_irq)
 		mes->funcs->enable_dbgext_irq(mes, true);
 
-	/* Point each XCC's MES firmware at its own per-XCC region. */
-	for (xcc = 0; xcc < num_xcc; xcc++) {
-		r = amdgpu_mes_dbgext_setup_fw(adev, xcc,
-					       mes->dbgext_log_gpu_addr + xcc * size,
+	/* Point each (xcc, pipe) MES firmware at its own region. */
+	for (i = 0; i < num_regions; i++) {
+		r = amdgpu_mes_dbgext_setup_fw(adev, i / num_pipes, i % num_pipes,
+					       mes->dbgext_log_gpu_addr + i * size,
 					       fw_options);
 		if (r) {
 			dev_err(adev->dev,
-				"failed to setup mes_dbgext in FW on xcc%u (%d)\n",
-				xcc, r);
-			/* Detach the XCCs already armed before bailing. */
-			while (xcc--)
-				amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0);
+				"failed to setup mes_dbgext in FW on xcc%u %s pipe (%d)\n",
+				i / num_pipes,
+				mes_dbgext_pipe_name(i % num_pipes), r);
+			/* Detach the regions already armed before bailing. */
+			while (i--)
+				amdgpu_mes_dbgext_setup_fw(adev, i / num_pipes,
+							   i % num_pipes, 0, 0);
 			goto err_disable;
 		}
 	}
@@ -1775,8 +1803,8 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	}
 
 	dev_info(adev->dev,
-		 "mes_dbgext enabled: %u KB x %u xcc @ 0x%llx (%s, fw options 0x%llx)\n",
-		 size / SZ_1K, num_xcc, mes->dbgext_log_gpu_addr,
+		 "mes_dbgext enabled: %u KB x %u xcc x %u pipe @ 0x%llx (%s, fw options 0x%llx)\n",
+		 size / SZ_1K, num_xcc, num_pipes, mes->dbgext_log_gpu_addr,
 		 use_irq ? "interrupt" : "polling", fw_options);
 
 	/*
@@ -1792,8 +1820,9 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	return 0;
 
 err_fw_detach:
-	for (xcc = 0; xcc < num_xcc; xcc++)
-		amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0);
+	for (i = 0; i < num_regions; i++)
+		amdgpu_mes_dbgext_setup_fw(adev, i / num_pipes, i % num_pipes,
+					   0, 0);
 err_disable:
 	/* Undo the early arming done before setup_fw(). */
 	mes->dbgext_active = false;
@@ -1850,17 +1879,19 @@ static void amdgpu_mes_dbgext_stop_locked(struct amdgpu_device *adev)
 		return;
 
 	/*
-	 * Detach the firmware from the buffer before we free it, on every XCC we
-	 * armed.  Skip this across a suspend: the MES is being torn down anyway,
-	 * the buffer is kept for resume, and submitting a packet on the suspend
-	 * path is unnecessary.
+	 * Detach the firmware from the buffer before we free it, on every
+	 * (xcc, pipe) we armed.  Skip this across a suspend: the MES is being
+	 * torn down anyway, the buffer is kept for resume, and submitting a
+	 * packet on the suspend path is unnecessary.
 	 */
 	if (!adev->in_suspend) {
-		u32 num_xcc = mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1;
-		u32 xcc;
+		u32 num_pipes = mes_dbgext_num_pipes(mes);
+		u32 num_regions = mes_dbgext_num_regions(mes);
+		u32 i;
 
-		for (xcc = 0; xcc < num_xcc; xcc++)
-			amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0);
+		for (i = 0; i < num_regions; i++)
+			amdgpu_mes_dbgext_setup_fw(adev, i / num_pipes,
+						   i % num_pipes, 0, 0);
 	}
 
 	/* Make sure no drain work is still touching the buffer. */
@@ -1922,8 +1953,10 @@ static int amdgpu_debugfs_mes_dbgext_show(struct seq_file *m, void *unused)
 
 	mutex_lock(&mes->dbgext_lock);
 	seq_printf(m, "state:   %s\n", mes->dbgext_active ? "on" : "off");
-	seq_printf(m, "size:    %u KB x %u xcc\n", mes->dbgext_log_size / SZ_1K,
-		   mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1);
+	seq_printf(m, "size:    %u KB x %u xcc x %u pipe\n",
+		   mes->dbgext_log_size / SZ_1K,
+		   mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1,
+		   mes_dbgext_num_pipes(mes));
 	seq_printf(m, "mode:    %s\n",
 		   mes->dbgext_use_irq ? "interrupt" : "polling");
 	seq_printf(m, "options: 0x%llx\n", mes->dbgext_log_options);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 2b13a5b37539..b967b6c0b4c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -154,7 +154,7 @@ struct amdgpu_mes {
 	void				*event_log_cpu_addr;
 
 	/* MES firmware debug extension ("mes_dbgext") log buffer */
-	uint32_t			dbgext_log_size;	/* per-XCC region size */
+	uint32_t			dbgext_log_size;	/* per-region size */
 	uint64_t			dbgext_log_options;
 	struct amdgpu_bo		*dbgext_log_gpu_obj;
 	uint64_t			dbgext_log_gpu_addr;
@@ -162,10 +162,13 @@ struct amdgpu_mes {
 	bool				dbgext_use_irq;
 
 	/*
-	 * Number of per-XCC log regions packed back-to-back in the buffer above;
-	 * each is dbgext_log_size bytes.  1 on single-XCC ASICs (gfx11/gfx12).
+	 * The buffer above holds dbgext_num_xcc * dbgext_num_pipes back-to-back
+	 * log regions of dbgext_log_size bytes, one per (xcc, MES pipe), at
+	 * index xcc * dbgext_num_pipes + pipe.  dbgext_num_pipes is 2 under
+	 * unified MES (scheduler + KIQ pipe each run firmware), else 1.
 	 */
 	uint32_t			dbgext_num_xcc;
+	uint32_t			dbgext_num_pipes;
 
 	/* armed: FW attached + reader/irq running */
 	bool					dbgext_active;
@@ -453,6 +456,7 @@ struct mes_misc_op_input {
 		struct {
 			uint64_t log_buffer_mc_addr;
 			uint64_t log_options;
+			uint32_t pipe;
 		} setup_mes_dbgext;
 	};
 };
-- 
2.43.0

