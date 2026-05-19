Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97012CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 03:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F4010E04C;
	Tue, 19 May 2026 03:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vbvnCMwa";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C3C10E04C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSu7O63WJMogRNWSGo4C6+tu16e7LFtHXH3CNDnD6pdJyxig//C1nCLYPNAozba6wNMngTyxew5nYN8T6Jdjf/3AN0mG3IeCRpSe8RBSKQdfduyxuN3jndRFnGerQv8wAetGaZXUNEgve+NgTMRkOnCzdRdXEid6XhGQpSuFAYNoQY8PzDN0SJdnlPgQdOWGs8Y32h9Rr8nbAM/oEyffVnY4Ujz6XsnDd0gIIu4aZuUbq6BRAMhXmP6ygte8dBxF/tAAZTcWuVFKt+5y1j7G/laupusP9RDZU6k2bpEgdpQXMRLOlZIEHAQ2F9QipsAGiGAfUR0B0rk7+4skMc1fJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40S64Yl63e5NjI/HyK6YsM50BrlVbIkfnVmb5BbqCoQ=;
 b=UTjbdzsrmOZ3llkG/gebnz5ReV7ZnlJEbKeMmInYO59ah0hDlDpukhWrR1Q3ML0/43+M2uRXKRmMVIZu0rp7km2FnKBPk1EDrIWib1w4QP8/e4sPxOi3MUSthF4KrJP/A1O9zP7FJL7n7NwZloOzPZVqZ85n2unaZ6/z65vnWBG1FL2SozfeotmQTTT5LwyjtKUrEqvrS940qOBqoxQ9yXkPwrBUJCFdy3UOE+tud56a2krbsCbqQ5uXVC8MMr+PwP2cQ3dHQPnJfa9439ZnG48a4UFgiefn8fU17D09aPt0CXWzw83AY7UFiXgZQPEkKofd+POFzS1PUVGtW1Xy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40S64Yl63e5NjI/HyK6YsM50BrlVbIkfnVmb5BbqCoQ=;
 b=vbvnCMwazFdjGFOjXVh2VTH2E8cIubZiyU1Azos+GM4TP84GKOYT8C0AWrLWVChNcPdQcXWeaudETkcdh4q5m/dUPIuOVM4lsfzd7alKfeRbl0cNmN4uKI3Z8nWSaHH+MMcHF9Jf4EvVCAecMxJuf2fWrFJK3mP+sd0lx/N+/oo=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:11:39 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::a0) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:11:39 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 22:11:36 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH v2] drm/amd/ras: bound CPER record fetch buffer size
Date: Tue, 19 May 2026 11:11:19 +0800
Message-ID: <20260519031119.941762-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c82df5e-d0d9-4ea6-86ac-08deb55457f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: ikGB4ehjGjPDN+BA2k8entBxjDAc3LatoYPsfRAS8GQQ8vDjcMuYLhg70ue3VUBoLruk6FAukaO7qYJ0haPWOf9R8meE1cpkSsnW0KA9xMFlKumuFdP61dsLsJLvohuBT2JQLlfM67xs/9b1SS5q0W8VqCoO7tIowQEI6gVD6SYcNnEUEN7ThHu0JhFKiszsd82C+UZpbOvTTXFoUIAo0U828apYjbUKCSFS+pdnSPi+fgJX95BrPsX4CoF/tASQOoF5O11XOMas0V7Rk0l/0Htcq9rNCNGD9TVwFTtA844CAiSD5Ff4/OHjOJiTmzJedK1LZAF8x1oirkYVeEhWcIUTT4NAf5AyIeqI/nSscwxl4XCqnIvCwPhhqgBLzhaB3HycNh7wNf6CSTMDu+RcO44SkwZKTPA8BHl5Px8trsfaWOBLpFOGasqH7E4G79fML7E6eJBNXHRdEdfE6IpuGGpi+qxR58fwgxVOL4/kC8JFytnOd4Bp1ORH/3J/hnwWy8htAzRoXg0x0nOwN7cbAO0D2jlX6hS8le18I9di108/AKBRvHgMIUioN8tCsyV53zKCaQcJT3kwsBHIV2fwScCS8e/gdhG/RTxQPvwVsFSjWWhVM/dzpmLBHNp7KPMO0wqAXGwTRublnNfT4/mJJIoItm5cfRfDpzy06gy2ahUhm2wRKBGp4C6HGBl0+zRFdF46iU8rlSim2d8Z0sIT7A2jVR6xZ6DlTBl9TFzw/RI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DP9VBdrZipvumgPfu5N8oBRTFd2o/zBmxsI4hHQOoHD47xff1AaylVCoG8V1SJb5Cj1i6hsEuPefZb/KxrFhFjopImeKzfByQDYDUA6apo3Z9VCHQTAHwBBJVZ5rTWR/seeb4WhBFmbvC2gQU69UlvrpucbLNBRDuoOzGr1GNxVa5Mco+jpkce/ivQYVUSZLJuke2CNCDttJZgPDwu88j3qOBYVaIniK9yWo8SdXCpYG/ZmeBUKjPOkrsyVCt+Zxyrh156sP3U3rmyKFi4j6vcLENRLuZPd99NP8tuN8s1nsTj5cs83QzhvjrCXisenhruSX0LGyDUITcPVeem6s/NWqwrPY3sPW2efKMcdzZhVOat1yyKMgVdTLHHu4t0Il5LDOCe86H+Goj+F+a2fibAYdO6FG28b6ZpOF0RzLvEcc3Q5U66UyLIx5ngHJgHWZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:11:39.0230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c82df5e-d0d9-4ea6-86ac-08deb55457f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

Bound CPER record fetch allocation by buffer size.

v2: Drop redundant cap on cper_num and raise
    GET_CPER_RECORD max buffer size.

Suggested-by: YiPeng Chai <YiPeng.Chai@amd.com>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 3 ++-
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c             | 3 ++-
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h             | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 7ec5287daf7f19..0f3e7c40f0dfd5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -264,7 +264,8 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	if (cmd->input_size != sizeof(struct ras_cmd_cper_record_req))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
-	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
+	if (!req->buf_size || !req->buf_ptr || !req->cper_num ||
+	    req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
 	trace = kcalloc(MAX_RECORD_PER_BATCH, sizeof(*trace), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 4f89810d85a15e..8303aecf91ba71 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -214,7 +214,8 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	if (cmd->input_size != sizeof(struct ras_cmd_cper_record_req))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
-	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
+	if (!req->buf_size || !req->buf_ptr || !req->cper_num ||
+	    req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
 	buffer = kzalloc(req->buf_size, GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index 7ea35a02898742..a1d4b8b028412b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -405,6 +405,9 @@ struct batch_ras_trace_info {
 
 #define RAS_CMD_MAX_BATCH_NUM  300
 #define RAS_CMD_MAX_TRACE_NUM  300
+
+/* Upper bounds for RAS_CMD__GET_CPER_RECORD to limit kernel allocations and work. */
+#define RAS_CMD_MAX_CPER_BUF_SZ	(2 * 1024U * 1024U) /* 2 MiB */
 struct ras_cmd_batch_trace_record_rsp {
 	uint32_t version;
 	uint16_t real_batch_num;
-- 
2.25.1

