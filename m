Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ABBC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11E210F2A6;
	Thu, 23 May 2024 19:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R/JWLzyW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B2E10F2A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTBHrjbseNy3JeoEyQdilB7FbyS4flwM/hpLWCJ/KyjYedr0X92W37GCi36trOGKUCzq6FEEGW8yd0C5C6f45rWlLb7coyt/L5IrKCXiZuG8Z6d2lIQGH3dD+BXzUAx7kiFGcEH/qPGXxNQnXnhfK0IwK48O7ox4T4Edh6P0C4d3wJR058Iwuc5QUDAz8Z2FOIznmxTcQcwWw1VL7D72bYQO0Sb3wgx4sycxlGfn9IierLv1XKAH0iKtP2Z4QNqOc259ViP8lGvK/xKJq+ykn1LJ767a2GLugYVb1QxrIwZJuuoYH5HSkFmMD1irYgZWtBahpafbAfEgi05jEtcDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKoQb6c0QVO4pxD89ja4KvIp5XwzwjPEEa5xVbuce3Q=;
 b=NwXnZGWw5Ii5k3If9JAIxemyTRLHdKN+HhYCg5mmbZAo8u26NVHS9DjRAoLWJodQAkYxeiknejhhuL3UMgYwjWBLP0fUMqhjZcbNhYEL49S/iwuqNXRJlmG49ocKDCyvKmipV0GDRKRKLRyeV0Kj1rRkv6jpnhfzOSPtEm7vrC1LDMKTIVWKlbqheOwRBlGOTFT5ofG9vu7rV7h5HZS9qroqpVK4IMvQtizTaHKFyyZd25Z8oepCNpmfGueY7dhfMdM6EMcZAlkjQxH74dzWdL9T18xIrosCZRvSN+yS4Q03ukXNcyfnv3GH43tWTXjAWUjuHikCHcQpGQEqQhx/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKoQb6c0QVO4pxD89ja4KvIp5XwzwjPEEa5xVbuce3Q=;
 b=R/JWLzyWRvLfXxB8+Od/1auSCNAiLg2cyJlKgfpI5C/hIGKy2nBoPf3YzBRU2udTnMgs3jJBmKKA/I/nfqGP/8cr6SruQmECBfJpA18C0PDKjz2xE253Dq5gX/s8P9RmwZSviwxm8N65jxCJRaVDgcHBK5VivrcRryhWV1ybku0=
Received: from MN2PR06CA0023.namprd06.prod.outlook.com (2603:10b6:208:23d::28)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 19:21:02 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::dc) by MN2PR06CA0023.outlook.office365.com
 (2603:10b6:208:23d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 19:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:21:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:01 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:20:56 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 06/13] drm/amd/display: Remove unnecessary HPD entry for DCN401
Date: Thu, 23 May 2024 19:20:20 +0000
Message-ID: <20240523192027.50630-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7a51af-64f8-4363-59c2-08dc7b5d7bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lYl4jvGnrZrLQ1e7LNbxDQiO+YGQ7zYnsYTinQoulY2kzJnpmxXVzgCS7VgF?=
 =?us-ascii?Q?c8RbNVA5nIdxqIjK9ePZu45gjYtN2G29ycV49WKv0A+VY7fatK92IGUj5If8?=
 =?us-ascii?Q?5CWbY0Q/7Zt76iUNrLi/dlQmf28twsTO7eWm3pvlI6kDgAKS4RyFapWoZtbc?=
 =?us-ascii?Q?1lEOEKKc3+t7/M3MNGV7VHmm1UVax2Bxo+UOZDIg2qa2aq2i8dCSbk6sFnd2?=
 =?us-ascii?Q?Nhzt0ciKgpt/5OKZvy+6ztKduU0bhA4NtLrH+mBa/yzTrOPxXzcurncvPbAk?=
 =?us-ascii?Q?piOAYkcGBH4ynarsk1W/Z/0kYirPv2rIvQ/7Kw6C+7PNIQ7u9s9vMfewIrPG?=
 =?us-ascii?Q?3eOELeui8Ni6mL6wHsTkbGZukYRb3/b/AcQ0i+s8194ISLVEe9SHNcUcGsj7?=
 =?us-ascii?Q?rp7LQPk3shq4WNkEwfltydiSp34CHba9e7YXbDEAzjlFYlpse3B58Mz7p0oh?=
 =?us-ascii?Q?nOrH+ukeyd4d/25pMV/VXv0Z485KZ+dZohnxFhcukCC5Ou8qkhxIJDPPh+rC?=
 =?us-ascii?Q?sCk2n6NMDUAeIcUcTX+UeUNhNYvWqMop71cKzhVS4hmo2NjxJKsb/PSPXwCe?=
 =?us-ascii?Q?id7XZsAHY4TGenEyPG7LEO33MrGgADh+N3QdakWE4skHBjEhDygEHN7pe5Wl?=
 =?us-ascii?Q?buxxxMsf9SEr0XJEfIvqqkiX2RAL5228cw6vbYlxZrQu+f77Vpjwv/YcBmaW?=
 =?us-ascii?Q?QWptp2XCdOKSkXgQwfr3p1Aq7/CCRW+sChP9JoXJArtrt+oW6hNYm6viUSZX?=
 =?us-ascii?Q?PNrKG9sagwOYg2FpSU5IaVTSyQG2HVd8RqsrBo5B9vWZfcu3ZKS7SDx944nm?=
 =?us-ascii?Q?T/xXw+anBg/NVuH7K7oX3q91MgPUja6dtWaevr9Ds2IDbpfzs/IP6QfO+ERC?=
 =?us-ascii?Q?lBDDyjK+TsMSlFVWeOUDJlJ97oHTSUjf3m+M5dxUBj4vDGTivVQuGOCgZdfB?=
 =?us-ascii?Q?5AAPT38gYEzXEX+kbN9gnHnPKILvbMGudDbFjSeKLW1GcpTWcCV76rjrjcVo?=
 =?us-ascii?Q?aqxJ6aRTS3v7qha5QB9aluW9MZUYsCrkIQUl0AzqQg6rlzzcMOqZEgE+ksyb?=
 =?us-ascii?Q?liy7rOUluLnGfBmLI6YpEKLCpYdHAeRwAH/g8ZYiBUIooN96Gu4wamEvG6xo?=
 =?us-ascii?Q?JGVS50qwWk+GYRp0Ul807JzkQq4ULTnB45vC89gQtnxnlbNcGHEF0N0Vs4el?=
 =?us-ascii?Q?y1EgmuPZ1ctmgXmgj+8hY/HwBHqQsOm1BhbDCt3ahmqLYPNp5Luah1h9ciG2?=
 =?us-ascii?Q?fvI1IscRSY1VZo1iH56Qo4GzOW0vKrKstYkNOirpxifBL0QTuc7wmnegKyYD?=
 =?us-ascii?Q?H3GiGVCa2jpSdW8ytn3LIpuCI+IFIBLY/XpDcEhor2bkbAX4xs8K2ibw1RPx?=
 =?us-ascii?Q?Spf14sCxFlbMnPbPqvZ/e5OvrCle?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:21:01.8398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7a51af-64f8-4363-59c2-08dc7b5d7bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
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

Drop the extra HPD irq entry for DCN401.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
index 0b3d4616b774..859d19360e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
@@ -301,12 +301,10 @@ irq_source_info_dcn401[DAL_IRQ_SOURCES_NUMBER] = {
 	hpd_int_entry(1),
 	hpd_int_entry(2),
 	hpd_int_entry(3),
-	hpd_int_entry(4),
 	hpd_rx_int_entry(0),
 	hpd_rx_int_entry(1),
 	hpd_rx_int_entry(2),
 	hpd_rx_int_entry(3),
-	hpd_rx_int_entry(4),
 	i2c_int_entry(1),
 	i2c_int_entry(2),
 	i2c_int_entry(3),
-- 
2.39.2

