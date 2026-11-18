Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC560A3812
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wxDqbbgB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461741120A6;
	Wed, 18 Nov 2026 22:37:38 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E6D112098
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYoEbLny0LzLmMmU613TILubzQesh2GKtvRPOSM06SUPdoRELPa2cKExcLg9ZrOGRkjKGNa+riLPbDNqgxLZEngXmQgaYL7VO1/g+xPhFj9pSnICNzFB9Ynzxbad3hj0qf8YtetFu2dZGV3Yzescc7U8izxlfM6qLJFRd61VBZVyxsTpv0rtho1gr5vdDaIa5uHB4QvvAWkd4ySDM83TfgTPjCr3VC3ybjQolCDt9/Yi6yW0wfH5CWS+4jQ7WDurJX75AGYQJ3XNZtf2pKgY/2YZygtOb+yNkw+j90ge1IJGwpdAktHJYKt7n+OjA6Uvn1oUtBRgo9Mq7zNUXwRC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJkyrnnTvSH9v7WUwIhcPb+FWZxS+vwAykm+QCRLq7M=;
 b=cR8A4NGzLLXz5CtgTvJRDLMZxpsT6F6dvlqNCV8+CNHtP0/dmgi+eEuD0PWRrG5EM0C2cFPcqecwKXKyN1uFMmkSXxR+o2+gxvJ0RKUj5xSu4gMuRwBQwgbRi2xEvkEXekcVIw4zA/YbfNu4lTmw/Wn+NzlJ/IBfyl4Cx7Z+xgEXweCyuE8OGlVbwl0UGt8jX1CK/2K9CYEG87sO2+Foi1PHZ5LycQ+amu4U7ZMQfN70S+Ruy+T2KIcOFFIwMKpy59UB4HFcINQKI8ilvcx9B0E/0yQLgge88Ylm9sG3ZknKdnnCG+sQkFjnaNQ9wsPxeM7cAzBhCyxGcB1kX1qN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJkyrnnTvSH9v7WUwIhcPb+FWZxS+vwAykm+QCRLq7M=;
 b=wxDqbbgBef4h4IyBMcDwT/W1gHFCZe5D35crerONFZpInPjlhiAFj1SnPPzmy/ZAkrtkJUTsvfiD4itsWJxJ4/4YuvrGuSw0PrNm6iM5dXjrI+EFMmdhBLW68F7bX3AIOF9xC2juW0KPU9p6bi7154aX9mVTE0CcJekuCt6xGk4=
Received: from CY5PR15CA0127.namprd15.prod.outlook.com (2603:10b6:930:68::10)
 by SA1PR12MB999227.namprd12.prod.outlook.com (2603:10b6:806:4de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:37:28 +0000
Received: from MWH0EPF000D894D.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::30) by CY5PR15CA0127.outlook.office365.com
 (2603:10b6:930:68::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 22:37:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894D.mail.protection.outlook.com (10.167.249.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 22:37:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:26 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 04/11] drm/amdgpu/mes11: add support for setting gang submit
Date: Wed, 18 Nov 2026 17:37:05 -0500
Message-ID: <20261118223712.2518580-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894D:EE_|SA1PR12MB999227:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6c5c7e-e3a4-4dda-2425-08df45c48676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261022075727099003|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QDskHSnUgn+RMdE1EE17iKk0tkq8OfkJhkAhoKnZIkgunsfyyC8BAmUOkHxdXpMo1N2FWG5iw03/+m+C9pGj0aAgnk2RHfKhMlDHCCKCVE+2LEYUuurP7U3p5Ot5aNEBWZc6yGKEoD85hIFnrNVUzn+Etn/mwGsEpY9uJm+yxLZeiHtU51wPvBnEZJISuKMWgBqIG+1QMB5vl5K4p/6GCu4Ws8UKRopGzFuM68eYmI5YS+4JrlgeSSDPeYAvzkwjbL5ZereSr3koWYtnzP4qJ3FnXmXhBE+zxAoTW3LJcYaogx/auSZBHUnoL6N0jRXDJR+sYXoejacEsZXt1iOBLQjUsA7JL8NEF+KrHWNttxq8JYQXjpZf8rUHj/RCB6QPvhtGLmXMG9cuai/OUaLqXK8KhplNInw0pLVTbRD5raqo9qiNYw4Bf911B0nm3PKnWCFMWfgbN6sasBDn0oUNiIeTQT8CXAV5lAfCjIe4b7JXWvnrB8I02+sjyB9uVh88pr+DfZryrte6wK7ac6hQich8HtGgDwSqkgIGDojsl10mkp5gs5VnA7mN1W+3iQXKhDeU2VAoqsXJSzsMSAPv74nmr+1Li2Yug3AX/iO+FRKN66plqkJ+Roulff5b6OPylk/WzzFKNNDcnW1QG3pUzs56Crwi7YQ8QVH6Q1F4vLvCE6Qf2dA2OOOtFTdZwoimx3yRV8jkBx9TsK4G7kzLfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261022075727099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yULRstZnUXJJv3s1fe0lYI00juRSV2higTf4f0NUvxW5+SuvUBv6GCT0uUS5YsoeAcHNkTaSOsJV8ExwD6q/wIyhpE3TyryyF6UNJkAfLsLh7yh5VW7Jj0Z7By8jU4bwstxh9dH2SWfz6K5x0rQucFTxyNprZQgCUIXjmB1BJsf1sftZ+AvVIsCCPGTFepnP8ba5AWlEK78Y7iO9cM2yw88m661p2qxxACeyIkxVRXSbnjgEIALQFdpPWtOEkx9FUEGCV2qPHHVPvEzslJrm7n3Wu610y83/Q1hIPekjPYLe9wkg9Rx0MJr8a1FNy7yUhomLEepeh0OTiGjDWSEGpvt+R8w4Z8QbdmQbLGdxrimHAKg/lpb+DbJMaRtntZqNIoW+HGjmbL1HeC8lmpb5msjEk4Q9rBO1keGd8mE6i1UONzgZ/NGcsc3xAQ7i4uaH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:28.0339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6c5c7e-e3a4-4dda-2425-08df45c48676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999227
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable a primary and secondary queue that schedule together.

v2: fix offset of api_status (Prike)
v3: handle array indices

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 0242fe8135374..2be54f7dc6f25 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1283,6 +1283,31 @@ static int mes_v11_0_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
 	return 0;
 }
 
+static int mes_v11_0_set_gang_submit(struct amdgpu_mes *mes,
+				     struct mes_set_gang_submit_input *input)
+{
+	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+
+	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
+
+	mes_gang_submit_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_gang_submit_pkt.header.opcode = MES_SCH_API_SET_GANG_SUBMIT;
+	mes_gang_submit_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =
+		input->primary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
+		input->secondary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.gang_context_array_index =
+		input->primary_gang_context_array_idx;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_array_index =
+		input->secondary_gang_context_array_idx;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+			offsetof(union MESAPI__SET_GANG_SUBMIT, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -1294,6 +1319,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.enable_dbgext_irq = mes_v11_0_enable_dbgext_irq,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
 	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
+	.set_gang_submit = mes_v11_0_set_gang_submit,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.56.1

