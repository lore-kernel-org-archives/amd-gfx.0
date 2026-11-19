Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7CE606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BKJfdsGk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9436610E186;
	Thu, 19 Nov 2026 19:12:27 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616F610E186
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jI2o4avBiF4ECl9r3Z7AEwT68m5vPDMxCYQ1aBwOHZVstwuaSqaPOs06RNXn7le/8ELu1XHTsOw++9FgaHYQa95KR1qP5lT83ZHRN8Wgu0UpBwqxNWrcrziPMepyhwDa9syyJ/knp1ydB+3bE6bGZLAHdi2tSB5u+kRDfOsV8wlXBNnTsG04Tr/AOB/mT6Q+Xd7z4TJzD2a7XGTtOB1ZiDW1/eZh0Mid6813uOladl5+iSnQdSC/2tJL0Fe+tTJZ7nYV4JoEQcmc/JsbZeAbUKCeu+NA8sfD5MANy+YGyKSrM8feDonrXAXSLHOo0tSeCVj06tkax2shjGcNg/04ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zekX6GsSNhmL4x8QlvxRVXZlQInOy3A23sA6vBnQfno=;
 b=eyKwneyfDwIPBXbeD1p1nB1oJcaciFbnaxgv4O6ruPOXcMx2W8YIV1UmBmthiUcq5kTsQInzX67Uhmd1mmtip8ELEMlEeVCS8jjrpETRzRkLZKbPZFH8TzEKMDMCDqK/VLpaEGqs6hWnWcP5GNkpsN1DoR+JmeAFd3royZMIzB1eD01HEtxZNgWm18B09wn0t8tNjfzOwjiXPDZFlIdUeghpEYWucsQjh8dczCiQJYHuvkK0EXgA5sn15ICxi9a65gvPGeGdQicdS1wduNxljkASJTknzU/0Kt0m9ULRn7ut2y7+8rxtOHzahZ21Jr9l8fv8/HNVtYaKsWyC590qCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zekX6GsSNhmL4x8QlvxRVXZlQInOy3A23sA6vBnQfno=;
 b=BKJfdsGkAgq0qIzlRpuQczVsWsXg1+6xWgiQubvOZO/EuYC8AhbPhWUyk8E+a4n4MSzW6b1LsxSqGjWf5KKTVBmYbKrIg8WanZPxEI5o1CuIUP2XcnKnoec3l3+39zYyCJwWq6Dd5Oqg15L/bndl5dzEiHN+nZZ5w4D4R98wlv0=
Received: from BN9PR03CA0664.namprd03.prod.outlook.com (2603:10b6:408:10e::9)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 19:12:14 +0000
Received: from MN1PEPF000793FE.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::6d) by BN9PR03CA0664.outlook.office365.com
 (2603:10b6:408:10e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 19:12:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF000793FE.mail.protection.outlook.com (10.167.249.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:12:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:12:11 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:12:11 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:12:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2] drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz
Date: Thu, 19 Nov 2026 14:12:02 -0500
Message-ID: <20261119191202.190939-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FE:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: fa43e5c4-6bf5-4e1a-4ebb-08df46710538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|261021123027099003|261009223027099003|261021121427099003|261102123227099003|261026121527099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: anHCp15iH3AqPsb50hFBmTkxMsjFIUTTMgYYSgxg0zSR9VsQk3G0JJ15XFbOUKPTGtcxb+89DIPxOQC/dYVaVZBn+6QNr4mt9sfGkj8Ynm5xJgOmyIQJifYhkum08eterZ/q2P1V+LZ95Q6spKBeIxGyz+eR2owSwcGZE0ZcjaPTUHPezuioOhhkv8YWHxoIN8z0gcXV+UhTNdQ9I+QxmYpfe1/iIuwN8sDC0+R7wKQZH6cA2pNp6l+5maoXzcuTsEWfLrKpZzWWouJ33NEtNrUKfQrj9/83BY9cntBcLLmaNjvhm8lXU3D+Xn0P1PsnHK03ZHCDthTQa3HqvprCaNHKumrhJsCMrDf1Pzdebw9UL8bqpIOE58C48KI7OXlYkXG/CPL/8lw2RdQ3JZAdxPzuVsqXxRewFs8loxkUi/W/JoKq+9itn71VQvqshWsjY1kF7rUI157OZuPHPd61CZk1ZIPhABLJjHJQC97SZVSO5KL1F4iWAQj7F9Ci7gpldB+J5qXPON77bnccILlw+2ftp5FWhjqvKSn5DliNdVK09pyPMXAnu0EKZr4RS38Iag0QJ50QwKwZDICvjgcVes+cKo8VBv9W/+R7OL6jLKtm/XNEwqqK0DceztUAU2M2+Njhvb6FZTrA0dQK+OxcpOwHqxnXhT8J1ASvcBBNKvKNTEhpSXelaf1rcCtTXI9zIDd4ZLCyro8tfB7SzilEjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 04+elHEC8fbDqfgyv0f6w3IXKShXOZNt9t+YRbSGH1KZg+JVZxzCbI16yyB4TEWM2pG+izIHboQApDtUQ9fDCWyzBqFxWFwves3ubDe7Jprx7nYUtQCMD48BgukUjgkLURXsG97PHEU7sZL6qeFRW5ESjwfaBvU2i0b4FV7ihH1RVLg/km5joysxm0IbIU30pFbbe11MWhnu9ZJHoseTMFlnF5JrRFSzN+5R9BWbcvH0jakClYGNu0ualAewEkumMm69rB1Mz8rA6JYI+39+gMl2T/bPMcwsRv0ya/PkrOXiogJn/qw7OND6oYh693fU9THc+amO3dSVCAj2RTutCJ5RfpNX5kqD6xVX/i1q8jMxVnL9GNiTZJBRzpijwbNhY7HU+Pde2bX1peg07gXzQYToKZsMWUWxae5vrIk61DnSz9IyqPJxO3PDietHWpb7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:12:14.2280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa43e5c4-6bf5-4e1a-4ebb-08df46710538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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

FW doesn't support tmz on pipe one.  Only use pipe 0 if
tmz is enabled.

v2: add check for num_pipe as well

Fixes: fec62b5e1425 ("drm/amdgpu/gfx11: enable gfx pipe1 hardware support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 570f0f3a2ea5e..16b211174c8dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1690,7 +1690,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 7, 0):
 	case IP_VERSION(11, 7, 1):
 		adev->gfx.me.num_me = 1;
-		if (adev->gfx.rs64_enable)
+		if (adev->gfx.rs64_enable ||
+		    adev->gmc.tmz_enabled)
 			adev->gfx.me.num_pipe_per_me = 1;
 		else
 			adev->gfx.me.num_pipe_per_me = 2;
@@ -5322,10 +5323,15 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.num_compute_rings = 0;
 	} else {
 		/* rs64 only supports one gfx pipe */
-		if (adev->gfx.rs64_enable)
+		if (adev->gfx.rs64_enable) {
 			adev->gfx.num_gfx_rings = 1;
-		else
-			adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		} else {
+			/* FW doesn't support TMZ on gfx pipe1 */
+			if (adev->gmc.tmz_enabled)
+				adev->gfx.num_gfx_rings = 1;
+			else
+				adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		}
 		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 						  AMDGPU_MAX_COMPUTE_RINGS);
 	}
-- 
2.56.1

