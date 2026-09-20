Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF30C982DA
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Sep 2026 12:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9EA10E275;
	Sun, 20 Sep 2026 12:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3WkifeUk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F5610E275
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Sep 2026 12:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkabNTuBzAPIT3k4GiMAiO+fZGRuNTOHwVty3nh8Xqx+wiH2B7GEYEoEJeEOscnSKsTGjvuUy6IjmHGL0JbUwN1YCXkezutaR8ZPn49ELci2Z0pumwtPzS69gNoiVDoqpOm/+UCzag3ZHWVmaZjWIi1kgABZEzX01aL7Ua0j66WvsfcDqKPVqN78YSTW87Y8MFSRB7I1JMICT9c8yXrOMUK3fgJuTbQcQozFqNaqwaUVbxr8r/RmlXzFgilSbhOlynZgzIxd1bjjiqyitv+1kGCz6EOoCNXOmnKXbKDnTBXQPduhi5QV8f4htAVg4Qzh9BaUlbhibn0KPNsAtyLB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRfo5424cudBE+yDSQ/035AsVFVb3URy5gHNc0rEzfg=;
 b=RIM3pWF6nhWqU+2HxJih3ptHLW/QvirrRgJbG2rgwjydDV9dTpSFAgCeC15tYuE4GIICapdaU5R9fNtHqaYgS6VKwjUUXhEsHSin3bgD7vvF/56gJyfnrHbcLe+DzlLviPmgnQDOyNagKPW/I+OfOheGdHrCPLWU3wws94s4Fy4QkjozTqDIPiVtaSp3y2uDYchFXnIF6h41FiKSecciHDFNqnyjVuqIhDI9BaVzzOrx1ORTchejnriTn2j2f9p/xcSthAlDge1AlE+Cj5SA1LVUa7UIlIYnrExLLIhE7wu8fKEI1C2NAnolRVlovwdeyVQfpgyygXKs4zD2h2aS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRfo5424cudBE+yDSQ/035AsVFVb3URy5gHNc0rEzfg=;
 b=3WkifeUkaPCTp2i6kdcwi7hGApOp6NjMw77Afo8PhEWKgUfJrYqr5dTsyeMebwlsGQ4dG/+ISp68ESGPnMB82uI+sgsY9mNLBX0MjrbI6cpmkuxUM25+sxo+iSAjJbkIJdJOMCqSS1UgpXomrZkA5s9ht0Up3sfOf5vA5iQORGA=
Received: from BN9PR03CA0327.namprd03.prod.outlook.com (2603:10b6:408:112::32)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:36:16 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::6f) by BN9PR03CA0327.outlook.office365.com
 (2603:10b6:408:112::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Sun,
 20 Sep 2026 12:36:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.0 via Frontend Transport; Sun, 20 Sep 2026 12:36:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 20 Sep
 2026 07:36:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Jun.Lei@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amd/display: fix dml-wrapper file discovery for
 out-of-tree builds
Date: Sun, 20 Sep 2026 20:35:55 +0800
Message-ID: <20260920123555.1843011-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: c969a109-9539-4455-a743-08df1713c374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: f33ilbUnLR+uscibvU0UJ0kKjAykLJzfZrSLfiJqHKD5v5FA6nKW2Eumv9M0yIz3SUVUSvEuFLtm3XFpt83CZiTCOTT3YgNpCHuq5I9KACXiBjl65xIigkKxuEgzC1fD9a1FQbiWWUG00mV+fY6MJOGRqHthlxCHPrKsJhrWOMfkQ3WFM6+AztyGTP52O4NOjdIZT4tA5VS3xVEJ41acv/FYUuefvuE712pymsMYqiRYqmtSP/smfiOcuw8WbRAU7+yusEBdNqutKbooynIEsktmjsif4GnTFM/eLWFNShakfje5+QZmPK8rn5Z/jdt/oHWdpdLeUkQo1TbG2IZDpzumHEzz7hbuGlbapxWdl0COBzI3nXF62a/gLH1jurTpuv7rhH9TSyNaOTa4eQ8y9+v3zDK8XatHA68jarlUCGpaoSZHTJCLim8zujIP+5pBE25p6tJj04gmmUuah8kYXzuVIYcn6jIqT6w0S+TVplSCfftjuB+CyWKrrAaUo5fj7VXovrevFKNpQ+LtpXpHApRSZHb8WeTHGZvrLSu240P0c2cIF+xjINQEW/KTvpkeFMuOg1ne/FqKaNEdKD2GBzxKTYTtYJyk6EPwLUaoZgwSEByJdUJIlsu7JM8hwSa4fuiFUDDGH0eFZuSRGmSKjzLWQlUxqu9KZKmMk+zACuWW1BpmRJKXEAh7BgfhJ5dwkGx4YmOCH0CneVI2Qkpr5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X6uyAwWLUb0+ZIgRP1hedTkqD2OmCcwgq/SjS/XAvX+XcyeKXMT8Z6OLeTTv8bi3RpvxGDI2b5wm0Vgmck7q29yF9sTLpMHN9vOc6/xRU8fL6ego+I+pb5NPTAexKgAO+bFEUnK26XiEMggyZqFUQIcNqO4MAoCeWYbpPRfu51msiQUsOPusbkdzI3P2UQ68lwFLPe1tY0ln2ydkpnyTKq04i01ea8gFUxhaiKhQrjH9+/rA8aInhb0Yn8zpkKvyozWpqAutfegPrKJggRISAz6Wc3+BgDknODmKaispp3+zsf9Xhsg3D1ZltKlv8ajNxQqA28diA/wHUfKrvHq3LAO5N1IQj2Kuk/htIr/hgnKyl84myToDLFSprdxu2lkmZXs8mecBC59TZLvzPMvrDiurjjFYXs6LX68eSp8hK7F7FyLuXWjES8WsftS6Ztpz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:36:16.0540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c969a109-9539-4455-a743-08df1713c374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
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

Anchor the object search to the DML wrapper top-level Makefile directory.
This allows source files in subdirectories to be properly discovered and
compiled with the required FPU CFLAGS, fixing SSE compilation errors.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
index f8a17d622c32..2c84233db00c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
@@ -32,8 +32,9 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_wrapper/dml21_wrapper
 
 # Add FPU flags to all dml2_wrapper files by default, remove NO_FPU flags.
 # FPU flags step 1: Find all .c files in dal/dc/dml2_wrapper and it's subfolders
-DML2_WRAPPER_ABS_PATH := $(FULL_AMD_DISPLAY_PATH)/dc/dml2_wrapper
-DML2_WRAPPER_C_FILES := $(shell find $(DML2_WRAPPER_ABS_PATH) -name '*.c' -type f)
+THIS_MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
+DML2_WRAPPER_ABS_PATH := $(patsubst %/,%,$(dir $(THIS_MAKEFILE_PATH)))
+DML2_WRAPPER_C_FILES := $(shell find $(DML2_WRAPPER_ABS_PATH) -name '*.c')
 
 # FPU flags step 2: Convert to .o and make paths relative to $(AMDDALPATH)/dc/dml2_wrapper/
 DML2_WRAPPER_RELATIVE_O_FILES := $(patsubst $(DML2_WRAPPER_ABS_PATH)/%,dc/dml2_wrapper/%,$(patsubst %.c,%.o,$(DML2_WRAPPER_C_FILES)))
-- 
2.34.1

