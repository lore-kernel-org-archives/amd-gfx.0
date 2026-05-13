Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9F0CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD8A110EEE0;
	Wed, 13 May 2026 14:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3hgPpDws";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D746A10EEE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irf705dU9kqR3eHw7h3ilSyfMujxmxsPeOXOsVnb3D7RrQJEtE2QqmALoErX26v3k5bwo5Oqp6EnrvDaEX7+Au6LfnaBVCXzoifQLpOVS3yYmTw4HFLHzmHdLdE0W3SnvCwqNTOiwEOQA6MOYA1wpbMZoXnTnVVRqMA+1/UzEEwgJ0k5SHhAxt1L2x9QwwuOsBYZnIGc65Pd9afRj/lqP0nUYj0zrUZm9vMiL4vmmGodsv5EP79TGUmi9W1+/Ijj/q4oWmCk1N3KELLyzVCJwIJ9pxA1jBzNgYRpb+4JsSbDeOrLn5BCMjxL5T45pSFjYk3biSDQnhzBpfYc17k3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZpeztTNz337zGNGYPFA0KhAkJpN5YKWniAH4ZRTR/s=;
 b=YLYg7NnOqmifmCJ7v0GlEUFMViPeELOMsgdSdDE+myYBkjgBThAA/tS5kvd3IsfqXvdbFENObfAaL2ZbEqTAOXjTa65E0+B+R208WBZdTqx/023okzLA6PwJR+6KXmFd+B5G/w7dPW67BO+x/qkKd4x6H2fUK55g9iZ/jyYtvIa/XdcnIdXuHAtiRa1NrEWIsdI1Pv+XG7s4VpJTaCSxmxxR/7pd57PRegSnC2V8A4fJIsKhEkJH7oub1c1P1BVf4VIqeLNJcUiQwZKtKhdM4xJXho81AMpi4Rb4E3RWhUOVoyXefACYO7zaJl8T9WpvbzoRst3yYzX8fLC09QEmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZpeztTNz337zGNGYPFA0KhAkJpN5YKWniAH4ZRTR/s=;
 b=3hgPpDws0hiHL3F8Rpz5tdx0V18wYnZgKTHYJ87bZ/enr4rkijf3koaCpmhp6qpkAfiMSlq8ZnADkQw4lKS0V6on02A/kGeeHkG0CuRfHQ4Md20A2KZchK2V8Th5vqzU1+/DasvyGMnDIETT/Efuq7kbKGiBFF8ExkmhQ+EA+zw=
Received: from CH0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:610:b2::11)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:48 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::3d) by CH0PR13CA0036.outlook.office365.com
 (2603:10b6:610:b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 14:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 07:33:40 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:39 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 23/28] drm/amd/display: Validate GPIO pin LUT table size
 before iterating
Date: Wed, 13 May 2026 10:29:45 -0400
Message-ID: <20260513143213.1852892-25-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a4311e-6c23-495b-9e0b-08deb0fca48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Urp/HliD5o7wGRkjlydZJ9ssmUzZyE8N0eZIqYhKIvJ0hghLfnAMQ/CdKrLzOWaSBLYGMreCBrkikf4InpC3v51fnIjQLhXemMuOjqSvW6hAfguPArUWj/vR986/GNXXBA5Zhk0Yqt008TLmJgGzkZlU+q0y5BXLD3H6I7A01rkhPuMPJBYwnv4MMo3PNvwwQJylbqOk7+oUzjNa9BqJGwnhk2iXHKCX7MEHJfAvaySddPX3JaJP5jThfkEUnN0MPKarE5It2vRQzOUnyXYaiUiFHgJUNY0bmcvrQbjc2Mm7GHNlt9tmKcG9gjHuap1h1eJEUPYbknex+FU2T0w7d3wLf/gAgkJmZNC4n9ySXeTsi6AUZ3hz8UMHrW4dFilo/bCzlcFLwF4EDhdHPCmahyGi+kzGJuqfNTeOw1cK+4ibMwOH8gcFNiIecJAAuk9BtVXuIIfHO/pn1Pq2qNf973C5hDms7CM9s1WB3SM5uZEanOxLJOrjVgSaMTjKxEBy5WvENArYefPMQQ2XRy90MyNpjJphSw+sPa/FELYu8f1BmZ8GV1v3NpsSARi5XSHKCi5vJUjtr0GaUCQgC+xhWV0NhauiJk2Icw2EQ+AXPADT5Xfe6BYfuCnWp9IGNqZY22uqH8caz8viSjNYXDNJZsv7khBeCAHPwIQG/G9ofCEyz0WWLnGiiPjCwHT1kHuBj+laekf/WMhGDLlJnk1PvUhQyosC+uRtcdsLDEnW5Mw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LGbDflMASZfA/QAbx5DUgARDELZJz+KNi+oGMlaqpd28HCjMBrAZp0wgESzmBDT2ccbAAJ3a+t0XnwDvWAvqxH0DkW++/PrBzaTgFqicX2A7WexY1EF+rEdjSoSVS529AOsPxfPLjJDfTfJLEel1qOyTj6haVRyHJ2kc1cqNfPqmHu24PcyWYONHt2b0O3NhyZCPkBPcnuo3y6dCD9eDtWwAdrPuWEtHaTF+vOPkyOtyPWQlfJi5wDIU1bXZ+5nYnIQPVYda77ESXtEfNPv7l3fC9jiqhU7pxkE3fZPoJuE18RE2qjUXB0Ac4kocTtuDAONUWZH4WpeIYN1qa9moZ6dQG6k6Zg8YWzrnghqwWr5c2GcyHYMkxEUk8yo06vEJG4yVJYw+EqUZdW5bQDnQeZAI2UeR13j5XZ+3xEr2QtK0QElNx8nOUQd5O8Gub0sg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:47.1726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a4311e-6c23-495b-9e0b-08deb0fca48a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800
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

From: Harry Wentland <harry.wentland@amd.com>

[Why&How]
The GPIO pin table parsers in get_gpio_i2c_info() and
bios_parser_get_gpio_pin_info() derive an element count from the VBIOS
table_header.structuresize field, then iterate over gpio_pin[] entries.
However, GET_IMAGE() only validates that the table header itself fits
within the BIOS image. If the VBIOS reports a structuresize larger than
the actual mapped data, the loop reads past the end of the BIOS image,
causing an out-of-bounds read.

Fix this by calling bios_get_image() to validate that the full claimed
structuresize is accessible within the BIOS image before entering the
loop in both functions.

Cc: stable@vger.kernel.org

Assisted-by: GitHub Copilot:claude-opus-4-6 Mythos

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index b4dd8219b8f0..39668db6d472 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -493,6 +493,10 @@ static enum bp_result get_gpio_i2c_info(
 			- sizeof(struct atom_common_table_header))
 				/ sizeof(struct atom_gpio_pin_assignment);
 
+	if (!bios_get_image(&bp->base, DATA_TABLES(gpio_pin_lut),
+			    le16_to_cpu(header->table_header.structuresize)))
+		return BP_RESULT_BADBIOSTABLE;
+
 	pin = (struct atom_gpio_pin_assignment *) header->gpio_pin;
 
 	for (table_index = 0; table_index < count; table_index++) {
@@ -681,6 +685,11 @@ static enum bp_result bios_parser_get_gpio_pin_info(
 	count = (le16_to_cpu(header->table_header.structuresize)
 			- sizeof(struct atom_common_table_header))
 				/ sizeof(struct atom_gpio_pin_assignment);
+
+	if (!bios_get_image(&bp->base, DATA_TABLES(gpio_pin_lut),
+			    le16_to_cpu(header->table_header.structuresize)))
+		return BP_RESULT_BADBIOSTABLE;
+
 	for (i = 0; i < count; ++i) {
 		if (header->gpio_pin[i].gpio_id != gpio_id)
 			continue;
-- 
2.43.0

