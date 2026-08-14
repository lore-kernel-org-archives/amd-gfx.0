Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84BBC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8E910F745;
	Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wwbkN+tf";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A589710F73A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGRaXsmS23yKjVFgaeyUtSAI3qlfAIa3JBITFiLASNpem5WpdHw7NYCrn+y2IpQTpKuUPyidQUzZi2+nP+XA2W6Dy92GN2LE0D4a8j0lw5oEWmEyXaSBzbQKBLqbmFjUYoqA1ZJrZ0dNneNYy+1ZCtj1JFWTJOzIA19JNwKp7NnIA47J4zVtRmcYNMn7xeKtficJSqvuzXMoKkGEhwRqSILQGNPOmLul5yPGsvH/nof4VTTVdUyd1heiZvAVA4q3mhekHCO4i81DSUfrWRUzDEZZM70TbWUd6MEWZUMzjyXNpEEJSLSaLzxipVV3Sf4iybm3WlwA3E27jEO7SCSf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO98oA6s0lsXT34aVN6eEl15kJ3rT+nanHvPXq1RR3U=;
 b=PWBg2BAa0b0gCu9Dbkmf0pXivDZQADQ7nPkptGUZCHcta95iI1a+nOqmDMc6jM7f/378qmaH8Uh65WYTl42+Ys7BDcyOaYmEoqkulhgOiX9ThxdqQLjHSjfVi5R7AmHzVMQ7hyPEVatIVVa3VCCWLVfNDUbHrq9gWuOPoSwso1VeZvXb6PSweOeN7awXbExylBKcRGcb7geAn9XKdLHvoJatAZESxkP+EWni0lQ+tmwzy3JrtENoJUHeZU2D2fZB8Wa8JO22l/TJNdTGEDwkQL33vc/MIC5BKv2YDph5F9S8C1df/cXLsbRUcWytL7GrbUDQN4EDm+Ouj1dZok3OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO98oA6s0lsXT34aVN6eEl15kJ3rT+nanHvPXq1RR3U=;
 b=wwbkN+tfGiUo0uTVhj+4+JTvW/MSe37aV+G5oxfwiAu1oF0SSwoPkHAR++mmT20E006FtYvZSKGIIESoZdLlXv4Ox+O1HDcH57S9kJGGbIqoSjCk9oflZAOa4F5QsRMmDTdRbZxF6p/jwuT8VehZSf+8VeTGBQY7fhYP2CucP0w=
Received: from BN0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:141::30)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 21:04:07 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::9d) by BN0PR07CA0015.outlook.office365.com
 (2603:10b6:408:141::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:04:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:04:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:04:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 108/109] drm/amd/ras: assign BERT platform record ownership
Date: Fri, 14 Aug 2026 17:02:45 -0400
Message-ID: <20260814210246.3067612-109-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ee5b04-41fd-4fc3-437c-08defa47941c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: c/wSdVOpoehD71RvO0Yu4tB3XmTK/8HsmU/LNBf+//5bhQL0dfAVv6RLPSLMzXo0zjZ8FmyBW54YXYF+d2fbYnMVHwQxOf7ZWNVjkPdDtf9ugjYiBe+mo9ZqDesopWyspqotPh7W14/yqe9BDujz6uVSxQ5rdRr7xe74Ob2r7+X69Tyw6KiiWh0VRsLhmN9vJSc4AF5g6xQwlT+XXbsn1yn7PTRtXBGWs3KXBbE8xvgaetH1bhoYuz/ZSwZjAOrs8VrG6YN+OkBZ7wlhuMlcnH+mE8bUQpijljjonuad78XrLdWN8wnQlutVKGkUOHRt7vu7VFdruZM276d22KG4JrYuiSZC9qBR1P3kuwuZmiqyvQYVuGfilCv3vHQKSKn5blV/ieA7SNkQRABZayGfT7tkEgCMvVXkyZVLq62AZGXjKMYnVho4a1FExUn1uf1F4xkeDo1UPY64Lx2sVkvneXbOGVYVA+RqItD4iIUtvzgSzBw0Sh1IldT4suAg6zuOpy22BlucL0kdq8WxsuGJYNPmerZxbGj6HlKtAEQPDg1IuHXlNZOGvsYUK9huJSkj+OrBH7T16EgylsuunIteqWl6o3c19p5S0JWSb+AZWPgUGnaNGs3nGRyWQRmddHzZRYyOdp0TsqSNeQgHgcGFMAo8jbDs0oqm6PJWfmRxtQvQuV5cN/+SWaDx53qaX65IQ7BPOTiUg52EQ8Vg/vcYMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DQORv07B1IKeZTzqCqLvdvHL1k4ejcJpl0J/lgSPyzlJLgPLk6czTyRpSgh3Rv4drs6klG06Z7y1od07+oZq/MzjdR+yVz4WEvFsrWdYS/Wf4PAN6wg96ogFi/ySqRT80V2okYG0A3Fr04PsK6s/c1j1I1D4EqNXvs0o7+9CL5+CPP9M+1uNcAUrQhrcNrUL4AVAPKVqqL1wm8yxAwML380mngNVBiNr3FEvAdsOflvnPVwiQn0NMemDYE5Z6VgQly9U1E9wSB+/9zFRNvTnDNYZsn31hUGXNFH6ZLf+EFMD4WPSHJ8LFqV7DwbraxGO+T9RwNSqaj7rFE7onuT4aD+X3Jj8YMtTTFCBOuC865FlZfgjZ0+2arp62CAgKNlZCx7JLUX91CE1JtyjMlAEMR5bZ1bfXkbgYY1A4EL+bUs2GxAPcinng+hUda/dkIsQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:06.7253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ee5b04-41fd-4fc3-437c-08defa47941c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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

From: Xiang Liu <xiang.liu@amd.com>

IA processor and Platform Memory BERT sections are system-wide records
and must not be copied into every GPU RAS ring. Per-socket GPU records
still need to be offered to each matching GPU.

Assign platform sections to the first eligible RAS instance and claim
each GPU socket before parsing its cached BERT data. Serialize ownership
with the shared mutex and retain the state until the final RAS device
exits.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
index 04490f5173c41..71e9c8d3c8476 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
@@ -34,7 +34,9 @@
 struct amdgpu_ras_bert_boot_err_state {
 	struct mutex lock; /* protects cached boot error state */
 	bool polled;
+	bool platform_written;
 	bool written[MAX_GPU_INSTANCE];
+	u32 users;
 	int poll_result;
 	u8 *raw_data;
 	u32 raw_data_len;
@@ -60,6 +62,7 @@ static int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
 		return -EPERM;
 
 	mutex_lock(&state->lock);
+	state->users++;
 
 	if (!state->polled) {
 		state->polled = true;
@@ -135,10 +138,13 @@ static int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
 		goto out_unlock;
 	}
 
+	ras_mgr->ras_core->bert_platform_owner = !state->platform_written;
+	if (ras_mgr->ras_core->bert_platform_owner)
+		state->platform_written = true;
+	state->written[socket_id] = true;
 	ret = ras_bert_process_records(ras_mgr->ras_core,
 				       state->raw_data, state->raw_data_len);
-	if (!ret)
-		state->written[socket_id] = true;
+	ras_mgr->ras_core->bert_platform_owner = false;
 
 out_unlock:
 	mutex_unlock(&state->lock);
@@ -146,17 +152,23 @@ static int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
 	return ret;
 }
 
-static void amdgpu_ras_bert_reset_boot_errors(void)
+static void amdgpu_ras_bert_release_boot_errors(void)
 {
 	struct amdgpu_ras_bert_boot_err_state *state = &boot_err_state;
 
 	mutex_lock(&state->lock);
+	if (!state->users || --state->users)
+		goto out_unlock;
+
 	memset(state->written, 0, sizeof(state->written));
+	state->platform_written = false;
 	kfree(state->raw_data);
 	state->raw_data = NULL;
 	state->raw_data_len = 0;
 	state->poll_result = 0;
 	state->polled = false;
+
+out_unlock:
 	mutex_unlock(&state->lock);
 }
 #endif
@@ -173,7 +185,7 @@ int amdgpu_ras_bert_sw_init(struct amdgpu_device *adev)
 int amdgpu_ras_bert_sw_fini(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
-	amdgpu_ras_bert_reset_boot_errors();
+	amdgpu_ras_bert_release_boot_errors();
 #endif
 	return 0;
 }
-- 
2.55.0

