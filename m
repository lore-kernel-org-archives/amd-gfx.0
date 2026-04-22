Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EC4F94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2155F10E1D3;
	Wed, 22 Apr 2026 03:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJa5e2h8";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6E710E1FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkbMzTAosmBQPnlSH+lE4wcb4R+rapl4VJHht0uVgQYkzgmin8favb3//QNYaLp0Vj/oyYQK4/6e/kLzLQi6q/lcDJPidhwLl8AQKgBwFfxbJBpKABqiqnuwBXzLIUttluKqEwz7IQg/Hwtzk6P81slVLbguZA0JK9Gw/9+Mlwn6McH3f7y5epKzWIWUJQQTTzl+0utS1eZEWnGPGVUJrmK/84Ivub1AKn0S9eS1WQnKm8i6SiuXvrCGy54uTtzH/oTndacEBjXd3i69lM5VcZymHtJz6VTQggCULmpjEhSsE0Rai6ameOcOqZYp699q6FymMJrPWEi0p16vkAZXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p17QErJMq3JXLpyFKAPiV4M+gdB0NvfEPGPJozi+ujE=;
 b=KUSxp5TOGUYghT230GCaJvFR8JxYnrIfKwDiWs4NYth/wj8saYO+nAOC0sQm8mrScGssEOTfQ+xOROIMu1Hwer8h7jdkQWrQTNkxYbvMkbmllLeAxeh+UsCFkJojvtyHhN9tW0JkEEasA5S8sz07eE94evrGxKKG1OP8hKUw4JWif3XfpWEZYpX+PKym1pCEeBxcAOfNyon7yDGATFDIzM9pP/Zqh5G05y7EBCveZXUBbzWHgetgMcHFtKdp+2QOGd4vRjgOWZpj8G2/ZEbXWEQfkAJ3pTOlMG4Oki55niaGg5ZJNzjbItMHmj1DTviupx3wl3PMb2k/JMoLCKRgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p17QErJMq3JXLpyFKAPiV4M+gdB0NvfEPGPJozi+ujE=;
 b=zJa5e2h8jMJHgW4QKnvBlJNztfpx4wDjNZDSJrMn0nR4RWi9OyiYQn0h+JtsKc1Rz7kkE1TkjN1nVMErbCwZmEOEQE66FzESGTaXxMFPrqKO0hw1kzOWRE2LCB5KY0uGD/SdxTBefZH05kYtzq6L6kAOEkq8rrHC7OKGd97ytUE=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 03:56:43 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::24) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.12 via Frontend Transport; Wed,
 22 Apr 2026 03:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:41 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:38 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Gaghik Khachatrian
 <gaghik.khachatrian@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 05/14] drm/amd/display: Fix implicit conversion warning
Date: Wed, 22 Apr 2026 11:52:43 +0800
Message-ID: <20260422035611.1870316-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e8709b-797a-45bb-54f9-08dea0232a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O3Nkcqhha+gbTRXzBoRun8UjCmVP7I5zi2paWqqvn6ZO44Mw/U+8MvjIEwe0TnG7aOp1neEIjSdBiUq43ZJVx+JAUrvkDEYnu7cNAvanVAd63w+dNjTciCpKge+6Z7sy2MRYwk7BeMdlbNYAZJcxi5j2b3jWotm17AS5xMjx72jvmu3h8YLy2XT2B5C1at7NnLNCf919qAtKj7h8gKZqAuhMaZBkiz87vcztDmlyWQ7x/kRdaLCYHJnaIar5GnDYOHmd8oOpvMgw2xO5/kTDdZThUMQzq0x3W7pZPqzv7y7UzWEn9UnLOh8Kfj1QCVAZ63e+fpJ1stBkmm5YeByuHdJpvW9/G3TKiRRlsDP8wI8tvioI4uZ2Ns2Z9BPnv6FyatvqpuTQ4HkgyioJWa1rjc4DqymnS0qp5KwlzpLqKEuXd5wdki9S8abjwi5Iubl1ppag15WhiM+6dh2Rq7oy6fbO0YWfuUWbJmaioP6K5gUhgeirnOftXwLczfW4MGmyMNNUUxVyQObSAuV2VqIoI82efrVG3CGdjH2gtR6+pXXGXoWYaBeQNtN3UkQeAPdqMQPT/a2Rm2I/toCvbbFsx3VmJySLG1iGodQ0b+eTyuv7VTSm+3jkVGyC+6TbbKzAYSEEYUTmG0Vp3ckHl3XuAHBcd72x7wCz45I/xomPBLnkmGXkbmaZmO6n1/Y8xSMRdee/9hUle6Jt3SGUU6bQpdIXbxnQn5m3BGUBYwSd0/E5GhWILn/3rPkrW3ukEO47skwHx1neaICr1rEscTOdmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NjZ48k3AIHiop/ej65KAI0lMC93qD9ivpm4UCHdrabkRGLwPGkoGMfJu1jhPFeKb51IxCYBvYzTIkVg1i9Wb5aLireUVWfU372Zsk0t5KKNU1bQhaCyF7WhC+vIs6FLAyliLL26wBoXSkHYjb/t9FVf9v/ls/TydTxz+z6Dizj2s2OhOGsU6rnPFA0AJfKifQg5dlQwbf9CNG1QKMn80zlJgcGuYkCWPaMkdkeclhsPDPp4vKoY0DEzQqfqEOjlGZkH0qBchqQpVE5XJypD/0wGpnQ/hKhJXojrZ2+Iq+I0MDGUd4OWuKoZ+jxD6DyXn5hmLkdChUQL4Byc1DF6cJsoI/oFECeeBbtmTC0o1c6lzy8PP2vi31LjhB2nOt8SqURhxH70bT3FJjNCqvbNA17ejFhNsOtNpHflbhOZAKN7pi4lsKE3GL8zgfIb5suXZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:42.3152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e8709b-797a-45bb-54f9-08dea0232a1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why & How]
Fix implicit narrowing conversion warnings.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index a347d3ff5e6e..42eb2885e737 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -3531,7 +3531,7 @@ void hwss_send_cursor_info_to_dmu(union block_sequence_params *params)
 	struct pipe_ctx *pipe_ctx = params->send_cursor_info_to_dmu_params.pipe_ctx;
 	int pipe_idx = params->send_cursor_info_to_dmu_params.pipe_idx;
 
-	dc_send_update_cursor_info_to_dmu(pipe_ctx, pipe_idx);
+	dc_send_update_cursor_info_to_dmu(pipe_ctx, (uint8_t)pipe_idx);
 }
 
 void hwss_set_cursor_attribute(union block_sequence_params *params)
-- 
2.43.0

