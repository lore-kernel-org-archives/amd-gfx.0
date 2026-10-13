Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183F8CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 13:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1CD10E836;
	Tue, 13 Oct 2026 13:05:03 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD33F10E82B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 13:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjiJZ3HsGjzdUTbZsMs9eLPhGTFwenI6kQ2/upatJbxa+pn5rJRbxtL7gJhoarGH8MLjuF8kxScjNnaAOqzWp+dzPGMsB7zRI/L11MqTRrbIT6FjKRp3Xc4sdW+ac8Y/B5aVMmvQmugM7s+wFE8NsZLtRHoqePJypVUkTZ2IlQ1tMHL9FYOJHMruAQ7sjZ28IJrXka07ir8ZvIPGmP/gkaM2OKuqMQOzj5sOrEk9GI9rx8hek230iXRZfDDnUGc9rU30dRjZDg8F5BGhHr53/UiGyYPHyZKb1Kisj8Yl5tjQAS4IzKOGWUBW9/+DkBDF6iZPyZREQEP5VRFWiPQ77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fsqG5eCPYOgot+WiOlAHHbgQbx6yzoAV1EXt000kUI=;
 b=o5r7RPegNDcE2Vb4+NiX2yFlnpelGYr87ZpNHXNIsC2+A2I75TmH8I211nvtehmDDotjiN08BQIwqYniq6rAn7DDhul8OV8f18MhvN5fLwlKWry6rWGc1qq7IAf4ascWoCxv4MdfyIKdPNDqKkitbL+av0xFgIpM8TRod2povC38IFc4hiBC/v92hj/B/K8W06+zAg8qfe6zPPq840hnfa7HJKwQKzO5ke5wAEvqpsSHaw3ST3r//kub3HXci21UsXudJ1Eq9ozL6lmXPQV9+j5hQ/XQm6LGht0H908+F20pCeHuF5HUjJ81NIdUsU+r9Ax58CBTohaInTUteiJNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fsqG5eCPYOgot+WiOlAHHbgQbx6yzoAV1EXt000kUI=;
 b=v15RH6lCzdXZxc9fI6EO9klET9RbmD2gVqx9DapdPfKDGgHeLu272RB628oX8AmjgLdq/Qf7YXMBvsbe1nXu6FfNSjWFSoYbvI0xuRa2r4/336cnerxa6xVMySVf4OoyP/dUu0ocjSKU3FuVV3JyM/A7DiKZq03N+5Q3z68CGwI=
Received: from BN9PR03CA0421.namprd03.prod.outlook.com (2603:10b6:408:113::6)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:04:53 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::11) by BN9PR03CA0421.outlook.office365.com
 (2603:10b6:408:113::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 13:04:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:04:52 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 13 Oct 2026 08:04:46 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: log mes_dbgext from every MES pipe
Date: Tue, 13 Oct 2026 09:04:06 -0400
Message-ID: <20261013130406.547026-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9567ae-36fd-4414-879f-08df292a9228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 4N0pEDwcTqP3J/2hVIFePptRTDZH028oteo+6I9ZihU81qoiI7ONCS1zJqMKjzleQX89Iv/NmdHHwo2RDqDcMrBx/tQnbm9rRyejlElrz1E6mavnYjiwMwWUBtoeMMVcV2Me74T81OAVZKNA9sVLS81SVeUc4J4cPCf0Rlk7pcAQDW3xQovSv4Yw+2YpPWvQL/ChhU85/F5jxn4PFckhXVVP+HmbEJ+6zg54HeXkaGiXC93/hBmNX6aFDGGVWYm3HnWSI1D7vjfWrFPLu8revXOXg//TeUhPdbpieSUm2keawcCJ8A6FF7eVJA3BGDdX4F3KXck/sp4pmatjwQqBMKAejxxjt8cOY1NijwyC4kz06xCNPo6LUiNv/LqV0UDg5eWjO9iTnoEarBFQMBJ2x3alLRUbLbC2cnIQofCHwc71uCt7r5igfY19U2o6No+0TIzAefgdrfRssyHtHorfOiq0LyrCAImKE16NI4sxfk0fC2uBOHtAYC6bc+FFzafnKXcxMlVPj28QBmyKr71To2UmnChNsK6s1fS47ZrR2NZdc099SIeKaDzkg4aA09k27cGBIQG39wIIBxN4xRas8IgRePPFezee2F0HwgDKKgTw4RCspnqPbvos7U+5YbM4WnS1k5kwevkvrb2AHynjdzQ777b6ubQJ5/Hnlhdho59Pgu4dNgT9WrUlq32YJmGBDsZLhJkrNZu4C0dtYJ/T+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: acMswz5BvIvnbHOW3aqIemBgylXApM7v8UJD4R1ic5DWRwPuEPFf5tjZpgsR6Aok/6lqj5lh2xTnX3wB+9SA+8e/sE4HAylvl0m/sEIaTK68Exjzaq/qhXllxu8wBk4B9coq5SaygwXB6SN2OE8BHx19gY/ZOkfP4W7Q+vTp+Zx9KgAdEDmM9KlcBnk60Zpx49oLNHpDihUJxpolvGn3yJEMtB0ssTGanWw3ifLnQbZrGQqLKgrlUspMItlDv1LOQ4PIGG9ZXun141yLbk9IZ7u6PyhiDiF6rkOixa3JRIHlKVI+RQiN02HPeDaUeATNOCimUOu3nAECLrQOHt7wU7wp3T0KaaoQx2Le/x1h15SDiO5edysRuhIWpd02EUcRDWR+O5W5axXdC8bXH80iydE9/FDCuXY/uU2FCLWSgkBWE1+itItOVHNUcBMekS4a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:04:52.6954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9567ae-36fd-4414-879f-08df292a9228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 159 ++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  10 +-
 2 files changed, 103 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8d813c68450b..a6308e343ac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1339,11 +1339,16 @@ static void mes_dbgext_buf_read(const u8 *buf, u32 buffer_size, u32 hdr_size,
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
-	char pfx[12] = "";
+	char pfx[24] = "";
 
 	/* Normalize to exactly one trailing newline: the gfx11 firmware appends
 	 * one to the text, the gfx12/mes_aux firmware does not.
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

