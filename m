Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE717CA601D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 15:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0955F89083;
	Fri,  9 Oct 2026 15:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jWyTOkSr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAA610E16B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 15:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxxoio/060wEUJ0cNIxLnRhlSUwuQY0oAYtGbYGOUdGa3lF0zP+YQEYqZLI8GDIsCnCbf3zL0DCiPhjlCieMdO7LqyCTp4FBEigJWIM/o0PY8ZuXx+KXCc/airB7ktFlJJ0MlDjiN20Z5iPS/AD5cLdUolsQZkX5/si5brvCEkpxfS0PTLmko6UTfisz/gBzRaehHLgoLY7+YS9tPFiWsr+2G2AjSePv4b2OFAlRyWVvRU/V+Nxco4CaDAA+A4e+0Ztl01dbrkw8uLJBtRhmQkAxClWuoNndTBHB9WMUicEFfW+p8Jhwck/P/RaTv3zU7lUSrbYAm0qsTdwnptJN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEXj1jaUAAqQ0yySqmzgmOErUWKpnBKuYlTS5RsIuX8=;
 b=xSF174x7KDRMweUOxXarf40KzLunvCwEOdAcxyBj7cTmGp2Q9J/shpPKbQi5JGsAXvAzwQ1Z2P9nY7MeCCF3GJ/vI4fq4ealuFo0QPNxzJtj0/o7kwxZKL0dQka3yoZxdCbvRFme1s8vAXARzyoj7dClobHZkySRdgHeLHjo7iGCfsm9jJqnFzrOAhl80cuypqmyd44M/1dNa8cnaJex62BIPNLYUgGfXzBxykLlkEaHLcqbMun/U4+Va0yivlTIW/HYpaH5sSmRct0Vkf1qVb4BEgFSB2Krmkp/txVuUmbHaaOx4Bas0J2CDWkqDqq6AhnjeOu+yNT0O+KUrSTEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEXj1jaUAAqQ0yySqmzgmOErUWKpnBKuYlTS5RsIuX8=;
 b=jWyTOkSr3i1xpvFqhQBBVh5+4Z/YKtQfx15/iuUd1N/Og87a/2mbumvBCVnuVN2qbI0ZKJ3+gUjb/2fHbB/2PG0rAjd8r9/gb7AxkG6UDHDQFFpv1tfMISZonEi8bKQz/o5k/QmYmrx8cOQm/MfQQf3f3fx8E3YaS+QK6nIeUaA=
Received: from BLAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:335::20)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:31:28 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:335:cafe::8c) by BLAPR05CA0039.outlook.office365.com
 (2603:10b6:208:335::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 15:31:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 15:31:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:31:22 -0500
Received: from vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 10:31:22 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add missing GC 11.0.0 registers
Date: Fri, 9 Oct 2026 11:31:22 -0400
Message-ID: <20261009153122.532708-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1f6b24-f377-41e9-ce6a-08df261a62c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jRPHEwOQQXfggZZO9W3eJ+OPSb49U/iSbneUsJv9v2Ol0ggs+pT0N/WOpp+9ugFmUhX3rnRSjmgoDMkJqlttiVK1699VGIL7SPSj0zvAcjvTyidkApHa3ZrPnnfn62HWWLU89/ReP1LpXY1UwaqcwtawRi8DwqXPBLK6+tOTmRwblwwLHK56dUK8HGR8mPnhhzsQaceQ5ggMWqwszhDvapIgD/vZQttQ1BaYocvdb0cppP8oG6jS2QfDdy/fwzr7daHuAG43NHjmXU5sPwWAXbIZdsO3bIIVPnh/sxguPW33lVfs9TnKHoYWfwm9k7CDxBb163iUp6/M9TNTUTHGKI0Z/UrajzhHi7YEHe4NrD7CGs0LHScktZJ36HeEqJEfV5pspOLUusB4OjbeX64kyrc5KEJqpANszKOHVTy5AEMZRSZu+8QRhk/OoQKYZ3NFyfjNoJbecQ2YFByTfHqoAHFZ9m3QhAx6ffSoGEAKtDQH/IUDCeIhHXvzt/Xum42Bb9O6UV0Pv77qsLzF4OHzERBeMm090zSCsCRHltzpHWQZpZvW+HIDmyIr9Kiow9X56oqIChL0y+LgH87EKEUR52vmeUMf+PXp/DuBuX0wWiEsxTQKS61de9s/hGKgfxO7rx7bZlN8oVNqbdPdllNTZURqoF4kXoZSY4lioSKUBHq1yImiZF5hf4f7ddZMPtfHezwTQjfIfsb24KQf+fI1UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bC8eFAG5QFubQdE14R23AnKIlbo/w9X0faCCgKW2edaMnkuwuUqC4wMeVm/6DtnRoCpsT7qWwH/kR0l+AOFqI+aJmH9sxGzmeth5T7cpFlm8MNypOWD7BL+TsaUyUrhYRf2aiQGsXkLp+IfdPYwJXYeo0jN1tbgxTRlAEaD7IO4b4KYyIiWbGjIlw2cvOBYjY8V59Z5pHjFS9DUf73zPpBeHSbEhCSCCOZgYitZlFEHUUVG+tSYA9MpSTm6RtKsfPip5zpRjOhgVIxG0xCTfHRQrmaATH/uGMDdwgiLQYO0rSNnytr4Ve1N6Y30RVxF0BvlbanHyHYfevh+ocOFUW9GSzXIljGNNwiOVqEgYSCqJ+nlNkafg1bs0dtNYd5e/Mg5dG1yTuimEIKsZw17wR9o+7FwRKFTZiMksrzX9tfGJeqfd3FDAPdDdqN6kHQ7r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:31:27.7991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1f6b24-f377-41e9-ce6a-08df261a62c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

This adds the regCP_ME1_INT_STAT_DEBUG and regCP_ME2_INT_STAT_DEBUG registers that
were missing from the GC 11.0.0 headers but found in GC 11.0.3

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../include/asic_reg/gc/gc_11_0_0_offset.h    |  4 ++
 .../include/asic_reg/gc/gc_11_0_0_sh_mask.h   | 54 +++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
index a3bcdf632066..3dddaec23bcf 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
@@ -4261,6 +4261,10 @@
 #define regCP_ME2_PIPE2_INT_STATUS_BASE_IDX                                                             0
 #define regCP_ME2_PIPE3_INT_STATUS                                                                      0x1e34
 #define regCP_ME2_PIPE3_INT_STATUS_BASE_IDX                                                             0
+#define regCP_ME1_INT_STAT_DEBUG                                                                        0x1e35
+#define regCP_ME1_INT_STAT_DEBUG_BASE_IDX                                                               0
+#define regCP_ME2_INT_STAT_DEBUG                                                                        0x1e36
+#define regCP_ME2_INT_STAT_DEBUG_BASE_IDX                                                               0
 #define regCP_GFX_QUEUE_INDEX                                                                           0x1e37
 #define regCP_GFX_QUEUE_INDEX_BASE_IDX                                                                  0
 #define regCC_GC_EDC_CONFIG                                                                             0x1e38
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
index 3088a4a13cb5..1b64f157467d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
@@ -16187,6 +16187,60 @@
 #define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
 #define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
 #define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
+//CP_ME1_INT_STAT_DEBUG
+#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
+#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
+#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
+#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
+#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
+#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
+#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
+#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
+#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
+#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
+#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
+#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
+#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
+#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
+#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
+#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
+#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
+#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
+#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
+#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
+#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
+#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
+#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
+//CP_ME2_INT_STAT_DEBUG
+#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
+#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
+#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
+#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
+#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
+#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
+#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
+#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
+#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
+#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
+#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
+#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
+#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
+#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
+#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
+#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
+#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
+#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
+#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
+#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
+#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
+#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
+#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
 //CP_GFX_QUEUE_INDEX
 #define CP_GFX_QUEUE_INDEX__QUEUE_ACCESS__SHIFT                                                               0x0
 #define CP_GFX_QUEUE_INDEX__PIPE_ID__SHIFT                                                                    0x4
-- 
2.53.0

