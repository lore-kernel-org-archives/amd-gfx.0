Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079C0C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E9D10EFFA;
	Thu, 30 Mar 2023 19:43:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12EE10EFEB
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRDNVm/HvEaWcmxqHCWP+Fg25kheVQrLA6pCzlwvg6/K7pFTtRQ9TZfmoK04Ln80mEx4YpyhxjeXr1lVgpelgZlsz8wJxeZ4Ts4PTbSvJROHO6cL60TYXNiGUINFKhl3SlJ+W9bwzTBaq4lC0eAC4ILgQyjIttfqkL8uTkbrsM+ZHnEF5vfu5tOrra8SK625azcXdPRt8THU1hVlJMp6zWZXN2u80UFb0aRqbzCPpBgqQszH+DwkaboU4oIcz70zfyOBYwkNxTt/O2KRc8k12YdsCQYA163VbASMu/t3We6G6Wi114swKtLt7LIOxomDCDKmEpxt0SDi4PmKG1p28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTwwzCs2tlC4sfXUlgV603GbpXw1ZuW9uKHBpWsaFqE=;
 b=Wa/Any3m3kN5kGifC1Wu6CU3daj8DTy3Irjv6s0NKGqfYFm0e1lU0a2pxy83YJrT2u1r+Z4zQpj9wcJx9pQhEEppjP5I7RsfZtzYoc3g2oMITEM2ID1IHINx154M1WajgdyZzvc9O4QogWsnbKmSqYd5KJU5/GJL7zPJ7wF6O8sOuFn7YRb7041KvSYIEg4Q23WS448l9Xcg1NrZyDtyfVhQZnv7vQs5D5/obTYpWu3FzEtICQ9urWswDC0qyVmeVyKS7DjQSfkBlK0Q6q6LTUm+3AP/9F91ilBxsFJ2FTCGPLf8b/KWtykc76i2DywkSjkj0ahwOqikdPQYrS65Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTwwzCs2tlC4sfXUlgV603GbpXw1ZuW9uKHBpWsaFqE=;
 b=lMTLYdA38g0ymgiiEBMNo/ozUeQ/a8uCYJNMfkIeuXNL4LSdnwAa8yBg/zau4zDkLGLdVhurGAE6ZNfvdDN0x1SqvYgMSMUZEphUvBeOHmO+/ufcXl44luLvoI8GKJBrYQU+yVkmByOGZbO4MRwMrpr/JYHkyrFMfD/TjSH4XUA=
Received: from DM6PR08CA0005.namprd08.prod.outlook.com (2603:10b6:5:80::18) by
 PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Thu, 30 Mar
 2023 19:42:54 +0000
Received: from DS1PEPF0000E63B.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::ed) by DM6PR08CA0005.outlook.office365.com
 (2603:10b6:5:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63B.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/23] drm/amdkfd: Update packet manager for GFX9.4.3
Date: Thu, 30 Mar 2023 15:42:20 -0400
Message-ID: <20230330194234.1135527-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63B:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 283d4a76-fabc-4ffa-1717-08db3156f45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVPocJhD2KIRshLcUBDo/hipjQ23FPzLmkmXrqE2a5Ityws/wkVe/RRa5qEJgWZcF6HTG76RVHvPwVYnlfVCRQcpTNVPvaN2952FBPVOIB134Dso13T/f+wvtWB7D8Ftp3Iytwx7ycM1lMWzBEy80kFCVjrj+8sVevOzp9x8zmbUnM27I2tk5gJ6fHBAk5PcfQfzyc1WESXyzyuQjNHskouokO462fULewSLMG8xEO2Vuop/6z5foLm5jgHxujKN869o2RwNoB21FDBOEcqmfpLiYK26eCx86TeXmhT4buX6eWk2R+Xgd3ZczntP7s18KsCLDxOoXXuyaYxypbeIHZtsftehKVsU0EntVZjQLP9ghYfNN8uLh0cQ7+rtvZmE7sAMFvWJEre1FBAQOW9E4kyjcf2eCxZ1BFuysRC8iAtmdt/rIYNJwDu4kxu2PhlT/ssjbLMYMnu9s6eyB32PNMszK6Um3KX5BEUG6Tq2OciwRrP4V5D/1c5y64yIlYRA8JNEbkeh1IMpmVeo8cGmq/zvGdIQlBrvhOIgW4ufjXZqTx44LueoE/uEtumMds16JqXzHNc6TCUBVAtc9cfjWDX9Jof5VTk54Zke+CboPIWaK98r2wmaQkvMrtOK+n2PPkkurw1TV18iiPjoWw7LaompH+D84RHQ1uZoP8cy5HAGOueI4BKLQrYOTslGC4Oguhb8zKAqU6U7ZVBfB99S9eHm7adj7Nph/4PLKpdCyC8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(478600001)(36860700001)(5660300002)(4326008)(316002)(8936002)(82740400003)(70206006)(7696005)(70586007)(41300700001)(356005)(54906003)(16526019)(8676002)(26005)(186003)(6916009)(1076003)(81166007)(83380400001)(6666004)(426003)(336012)(47076005)(2616005)(15650500001)(86362001)(82310400005)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:53.8769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283d4a76-fabc-4ffa-1717-08db3156f45a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

In GFX 9.4.3, there can be more than 8 SDMA engines.
As a result, extended_engine_sel and engine_sel fields
in MAP_QUEUES packet need to be updated to allow correct
mapping of SDMA queues to these SDMA engines.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c   | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h  |  3 ++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 54d7d4665ad2..44cf3a5f6fdb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -225,9 +225,19 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
 				engine_sel__mes_map_queues__sdma0_vi;
 		else {
-			packet->bitfields2.extended_engine_sel =
-				extended_engine_sel__mes_map_queues__sdma0_to_7_sel;
-			packet->bitfields2.engine_sel = q->properties.sdma_engine_id;
+			/*
+			 * For GFX9.4.3, SDMA engine id can be greater than 8.
+			 * For such cases, set extended_engine_sel to 2 and
+			 * ensure engine_sel lies between 0-7.
+			 */
+			if (q->properties.sdma_engine_id >= 8)
+				packet->bitfields2.extended_engine_sel =
+					extended_engine_sel__mes_map_queues__sdma8_to_15_sel;
+			else
+				packet->bitfields2.extended_engine_sel =
+					extended_engine_sel__mes_map_queues__sdma0_to_7_sel;
+
+			packet->bitfields2.engine_sel = q->properties.sdma_engine_id % 8;
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
index a666710ed403..2ad708c64012 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
@@ -263,7 +263,8 @@ enum mes_map_queues_engine_sel_enum {
 
 enum mes_map_queues_extended_engine_sel_enum {
 	extended_engine_sel__mes_map_queues__legacy_engine_sel = 0,
-	extended_engine_sel__mes_map_queues__sdma0_to_7_sel = 1
+	extended_engine_sel__mes_map_queues__sdma0_to_7_sel  = 1,
+	extended_engine_sel__mes_map_queues__sdma8_to_15_sel = 2
 };
 
 struct pm4_mes_map_queues {
-- 
2.39.2

