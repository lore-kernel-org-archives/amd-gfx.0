Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7173C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9D810F32E;
	Fri, 21 Aug 2026 16:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S8UhaYFu";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CDB10F32E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/+7WFW37XU+Haibd2EKXUJbrDN8aPXd5mZ+yxFj9HaavrOniIzYI3KMJxtLmeT3qCVYf0aEmYycwfqhzc/8g801dHHK1gI5744JJwvrG2Hb1u0gO7OE/eg6O+wnZuR7M8dJrAKtHLTZcvUGFulVRbYReMGVdoVTWe0WCT5x/WBcCTSveBSHyys0H/U9BwCLiBQdBLnDHhyWbKb7Oss5TwTrLL5l7XzgIfZIkzSvK9FrWXSBtukeKOo7HtjIdMp0w2i355/xbqwar5Dp7RJ4J0dhI4zYWUh4M+czCs7XD7VA09myeA6w3aq4XXV4Zvv0yobVWuZQP1kBHlBSdxpkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx6G6w1CJKMdYmCrnfzO5BRimo0cgCf4scjcBW8s/Bs=;
 b=nhQ4SZWpQml1ebQ0ZXsrWaiCKK4Z0ig47GSTPHJo4jIejzCWVcscWj/W1vkbX0l3+WMUqeOxTFlQhg2i35sTi/SHkqPPFJ1WZKWfr0WU38WpjW6HERo1e73SYl1bhKcrdy24h++81BN73tAsTU0KZVJVGr1C5H0VNllZknsG6xu/VWtFIQ0RVPnrA8HVJoPr56T7tZ62bRyZW/jjKsXrSY5RLfg7zyvxzaCPM1hnotkMLmvjNw+BY8wMwfF2e4s/kOIpU4fotscXjehTqYNfD2N2vrU6roJHNheB7m5ZiC0Kx8xJleWwuNH9Rj3mhqvfgj+OmeMKQp4l2LY9Nn04kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx6G6w1CJKMdYmCrnfzO5BRimo0cgCf4scjcBW8s/Bs=;
 b=S8UhaYFuY2qUK7jSzcAHEjiONIBQ+3M9NSaaIbPAJ6HXyuLs2Irl7/zGLx23lAsegAviebx1cmnlsSOi5AVRKMy5aH6+NLmGC4CMVWTilx0TVmfirOqgdjv0p/xLQPN3M4HpkEPYrfbvc9KTdvlvBK5GOVjzvNIFLroQA4sNWig=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 16:02:21 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::aa) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 16:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:02:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:02:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:02:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: use GNU make rwildcard instead of find
Date: Fri, 21 Aug 2026 12:02:07 -0400
Message-ID: <20260821160207.751241-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 1723c45d-8262-48e3-45dd-08deff9d9477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: P9vyO0LNkyRK+xuUyNDY9X4uA5jxxUIxqB/VXDT1XsMEGMpAiNnt4VbXbxKsEhYydpRvgYikuBWuekYu8qXlE6Rj4lxuqE1JAF4Afs0K7UYMCqipu03enIhBy+fD0N+gW+tD+LyllQHWxw/cecu0gL+OY/8k2XI6s2m9PPu9XsjvqzKTZ5h2WipwRm/XDIYjtrOzX7c8baMywjQw950ocpgMX0Fzj5i/N0Ms8CI4oKMPzPUaSlLk8XfpTcwolWH0HEwCSezJyezNQyWqMlGSt5vwpfnb5wGYxzV2ti6DWeP2cEChgsIt++TIQgd44t/80ccju2n3x09lHJOuV4gytkG7WDA3tdK9GGp93B8gcr+Wz3YiouHxl1iT8TOifoJifXG8gA7KjEayJiiIOXK0+8xP1qXXgLagMi7XRsiyn8twPie5YCMqqTgoYq40uw1viXSAThZI8rsgV6iZbncCrtCjkCCo2xPk1+XhBUJE62N5TUgIPZYrJVJk+6lcOTViofLd5X8iQc6oDC7w8XdOgM8wr+KJn3oa0261ydLG+n4hgeEof4d9TDcGRn8Xw8TdZ9AUoii3GUvOsv8r94MWBna6NoD/ofulo7qm24GoxPRHlg3SIOpAwQzltwc0DptNOQMI394B1H9LUAqiqF6IjTWEg2uipM8PMuDrEZEdscXyAN/qlIrF62xDEQyb+fi3RMWn/59ZgJTpEejmu37myg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P7ilflk3MIGIJvLt0tLg4aY9x89Dk8UKF2xUXHnWBhEgw74x6r9JEygVD1bMxjYn72+t7tDAHiIq09YifZDRXt8t5r7Tidt5uSf7MQPO03Je6hKjegvMPyLjGGzS3jYS28prRohlt+TLWroR5ynO0DQyd7xaqZ5EbUsWc8DxkyxtaqaJyGkxqisrwSA+iK7lOvQnZxt++Y/+ykd2NdTyyKlo7JkKxhYmYDoM9DTqvy60DwuEI+JWdYQSAAQbpr5FH6z5QFVwzt1tZT+K/Nw+/Sh2bp2hO4tuVuG9Wms+TNiR4j16Jh3w4Yn2Tn0GS3nKt5GqAQLCm+exRbO1yYgHHyT3Z2tWDyQMF8LYUbj1eaMFOPgXMDEN1ofxEL/d73lIO7tNyClHCHmL4UksvOAz0ssCENsJTAvBl/jkfDVGHzn2aAQxHW3uuFD+n3+fpWkl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:02:19.7983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1723c45d-8262-48e3-45dd-08deff9d9477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960
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

Replace external find calls with GNU Make’s $(rwildcard …)
to collect files. Depending on ‘find’ can fail if it’s
unavailable or returns no matches, which left CFLAGS_*
unset. In that case, floating-point code was built
with -mno-sse, leading to build failures.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 5388bf094fbcd..b3e23dbf2ebfd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -62,7 +62,8 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/src/dml2_cga/
 THIS_MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
 DML2_ABS_PATH := $(patsubst %/,%,$(dir $(THIS_MAKEFILE_PATH)))
 
-DML2_C_FILES := $(shell find $(DML2_ABS_PATH) -name '*.c')
+rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$(2)) $(filter $(subst *,%,$(2)),$d))
+DML2_C_FILES := $(call rwildcard,$(DML2_ABS_PATH)/,*.c)
 
 # FPU flags step 2: Convert to .o and make paths relative to $(AMDDALPATH)/dc/dml2_0/
 DML2_RELATIVE_O_FILES := $(patsubst $(DML2_ABS_PATH)/%,dc/dml2_0/%,$(patsubst %.c,%.o,$(DML2_C_FILES)))
-- 
2.55.0

