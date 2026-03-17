Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F9CFEDA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F9910E66D;
	Tue, 17 Mar 2026 20:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OccMlDYm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5208210E69A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYKSlTwsMrHqG4yA72hwh6aVlu3unXG/EmiA26fwYIyo8PHd/secBdPcSNACXYecKwSN3rrp5JYv9BPfZT2MZ842hub3IyaFbruFEUjHW+JNm3HkGwhRLzio4uWuvd0Uyam+/hoUBgbZJVKrbTc+Cs4zcNEhgbdez6ICeTOImblaz7chz1h+Z55bDxAcb4b85mEifbjeTB0ZDSL21p989wHh0FHD5HAnHNkRWaUr5Xdi24nYlCUrleTcoPsvAFLERyOTZu8+0YtrW2L69lTQGhJaWISN61+i+uULOOh2dKX4Rh196R5KVZZzoW0k87bwGimfGYw3qKGf30gBehFqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQntL+bRDxGdksSY6L7YURbCLxANZWi5UWRNLGXTYvk=;
 b=MxglfCV2E7YkaMVN40v4HMTJtKBYHBoKVeFv2uBF7J3BtIcMblvFGtOJDKUUPWaJ5QuTI0eFld/w8+knOw4DHN2kTIHv4VovLrBYcwfoBFsSdBQXbA36PBPTdyH0yKmbYqmZv4C1tAvTvKZRTejBiaT0ahuMM5QdiiYSXm6g2JZS0jQQq1EwlAghxl4VkQSewaB7Lru+cuzaokqWfPy6XAm4guBtKU38p6oR5qncXp/uAuX1mZy35gj6UzmaYujinYz87VyoxzZjITz7Zaw8Adxh01TlKHTPlffQbinw3HgkkzchwKIWB+xsUQerdNreoI8ARNxRbb3M//8I43nxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQntL+bRDxGdksSY6L7YURbCLxANZWi5UWRNLGXTYvk=;
 b=OccMlDYmn10y3m3/2dz2fVDTjY7Pk5ialh6ltmFuOYM/ZdwH4N1OhOPzG4PEY7yojKv3bmhl4r1p5Z5GTXx+WUSQQgCJKb1X0N8SYfWR8UM1otzdbRnwPMaxFP/EJvUa0kH3y9YJ7x5sNSGIpgXgHhujGGcZP6QFgGNNjT8RXL0=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Tue, 17 Mar
 2026 20:13:28 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::34) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 20:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 24/25] drm/amdgpu: Add smu v15_0_8 ip block
Date: Tue, 17 Mar 2026 16:12:40 -0400
Message-ID: <20260317201242.3808136-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: 714a78e5-f1c8-43c9-a683-08de8461a75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rNzjcwbRNTwRgyb9RcmCl0q8sHwTk8xe+COy7oRcaBx/TMiqM8p42h8+kVLWWR8INfFA3QHqnsf+o5DFZcZMiD9rYx5ZvOgHMH7sKThpuUyFz4IFIr4hUk1ikgPyS1cLecx7adpGnGv54MsIlpm50vYRFf41NTATEc9JePmI1tBnCsYOtT81RqqDKtv0+WW2UtfdjlliQ5PshnS3B8B5wj66W8UoyuSJWEZSvLbiDVCaxy15YzxWCc1ofACCaD0HhYuTSdhHRbRubY7H7KUmfiLIBeESG0sXjTNAyGsQNhFfxqAS0oybv5I8AVyd4bWlmCrGfegzYukeOP36pMJEt/lQZDraT36FHgLWhbO6rfxLTsvIcVpqWmaWmeB2G7JwuJ/yPprjDtmSof8YHJj41owk0eSF9xXk3INjZF08CnevjllTgEh/PxNoPSDExYDFRxuKsA+mwMcdV8GT9akafUU4XuBPPEcVV1GptA0tqUuSOJ5pp1xTwQiMqFSVWtBIxoJGfjQZYEAkgLmT+hzltWIUvaPjxaf2Lu4CpH5bKs+korXHPrjlIFkbwudbfvQI6dvA9fiJdTTc8t0YPNVxA1cAUnsCbqbD8+1dD/Y103lKZosSh6XTMffN0+4agUhb5L2ggjwr6vrCu5g5FKXl2Z/9IOHKV1ddqTiE5cwnjuRsNCQNWs6g8UxEFPRJ3wdADXlAWJaAM8qYXnw3fqwMEREmGjZGR/OUMjGcPsOSpz8/4n5I/iItKlkxgoSdgdoTt0ULqz4IkVGDmBsBk7jx6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tyB1ufIVcvy0B/GH6RpqAaIe1ThLuV7R7nyhdyEc9qsZU0jht/VGaR31S7il9O7q7I5/hjE8F45RAmcIss0kMy+yhxBhJHZ6bKaNDPZ1f+3Td5bI4jcr98e+15VBtEs9DZijuZNlavPZFBYj6AEXEq9Q6DcqAvEubiV0vYLzHhe4CwS8nlCYzjvlK2y+bvmDZGn4K2BqUZEtcRoKmohIFHMFrdmrnPTWQrmqA2dHNY5nxK5Yr3OyUk4EUQn0tacF2oa/JcsShumBGLIhozx3WXzI+1ZxE8aJo7ZN4QeuKIqNx65TSfIzJxa24ufaueDo6N86taTcUa21FtDlr+BCtBR5Soh6oakYQsMMkohmPYzjS/ao36tUIGe0jO4/2d2FmSgmYz4/l30nAjjF8sF4P/jCWzCKbYZeZRd2LtSJs+6+YxbfwGBrXq2780p85fEF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:28.6314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714a78e5-f1c8-43c9-a683-08de8461a75b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add smu v15_0_8 ip block

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f7f37d93d0ce0..1cbe386c86c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2337,6 +2337,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 8):
 		amdgpu_device_ip_block_add(adev, &smu_v15_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6b31b5d173e71..de82eb0f59934 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -803,6 +803,9 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(15, 0, 0):
 		smu_v15_0_0_set_ppt_funcs(smu);
 		break;
+	case IP_VERSION(15, 0, 8):
+		smu_v15_0_8_set_ppt_funcs(smu);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.53.0

