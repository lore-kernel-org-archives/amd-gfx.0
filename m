Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DE5C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E2310F2A0;
	Thu, 23 May 2024 19:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4RzRbqS9";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A25EC10F2B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsdFFPh8UF61En0TG+SHPiJwp5RsTqSXDy0B9deHxwSXDGV6NFts5GIX1OZMgzhexqrLEYCTVNHToxypEzQd5KaGXIpJOzCGUU/01f2dEDnW/YtLdwpuBNJ+FDYLyAnhrYaH2et3+pvQUTjnUvnkEp93hh9pYtsQcunU3qdkE8KYCGCVueOAN+a9iLedStCihTeF9ZwtQab6ExxbizbBFMSP7UHbxSLdbJ2iKM50/hHpj0bvW/5OlZHcBi7HUnk97B0YQp4jFJ6UmKK0PtqULvP0QnlTp+v0B/wZOIj3595Fhv/8gtqSqmBrJBiEUuTr6DjhRru035m7UY5PF/QZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V25eY3rDFUhv817EasUNrubuXVbsbsC6GlDG6jIx2vw=;
 b=HBCemc93y2B9O0MIFi2Du3zDcP/wtsAdy6nAQSssgvAYLiVnO1KEri263+sHkahALXHJWnZJqzythTiD+/Nm4EpDF/E7/JJdFaEzSG0bGvVZOeCGr4+aA16vtE7sf+KBRd/05paHnG/cJwepgzE8C6ykGmEF+5zcvdHAe1nUb3iFkS9/r2GXgcepnGeoeImF9VSCi7FNFjYbR77AHtt6fNr88y41RauZ0rapzfQNZ7Zxl5/6YKb3QaVwpcNZMobDgAeZEBnPfmemyWlqYLI5igy+Zt2JNvIzHFjsaGY0rWSzP0BruLlGPF2BcO9SlpKTsOuOT3FhUwnU/ip4Uk4SWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V25eY3rDFUhv817EasUNrubuXVbsbsC6GlDG6jIx2vw=;
 b=4RzRbqS9VYBeovSkeDwrJYNNYudEltcCg3wLzAMVhIZzlFYqxPTIkVI+xzw3FE941SAdHUH09GMF3nXXK+VozeOFg/iijNHBcje2XYnvzOCs2jRaeVZzKFqML2mV4j0hmgmJXhdkRp5k5sqoLMtVBLMj2f60SkizAPaDqzcLSWE=
Received: from PH7PR17CA0055.namprd17.prod.outlook.com (2603:10b6:510:325::16)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 19:21:25 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::a0) by PH7PR17CA0055.outlook.office365.com
 (2603:10b6:510:325::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 19:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:21:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:24 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:21:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH 12/13] drm/amd/display: Add new GPINT command definitions
Date: Thu, 23 May 2024 19:20:26 +0000
Message-ID: <20240523192027.50630-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fe6155-90a2-446d-14ab-08dc7b5d89b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mYr1TGwRcz8XqnrPJr8qIpYk6t6lx0H1HcfVyML3VOelpzvpyINVLgC4gc4k?=
 =?us-ascii?Q?URK8unaxvvcPl9KrmZ7qAYW8MueNQo37cCJFHDJf1Z1G7Oq+RI9luiktJ7RW?=
 =?us-ascii?Q?ir/WbJrueqhbdWo2rbSyulmQC+QWqbVhZwj4qLfz1sB/c+NlCuX2O/tSblPp?=
 =?us-ascii?Q?03/lWgPUwOo2UKrrs1BpABbzR13BUv+0ghnIrdHgUrMLsPH2fYgI64Yu1YsI?=
 =?us-ascii?Q?QQYHICduSTVtRpLFGFkrxkKPEec+iT5830VUS2O2XmLxSyF5PV4btzcbFIoT?=
 =?us-ascii?Q?NmGky9N6AJwB62eSGGC3ACevTVU2A12PoNAsLTxvMoA959hJ1uDsKBNgXicH?=
 =?us-ascii?Q?7El15/gNKQae8VGYtQV2BcUam6jnmgBuGbU6n1XpM8ImUtoeecioZmpZHd1D?=
 =?us-ascii?Q?i4cXRrap4urkDIod95cgBVjVoZLNjs+jjGqhCyJie35WUHQ7VQB2NRQAysiq?=
 =?us-ascii?Q?C9FhshFtlix79XeAgyeOdFIUdPGwq1nzm3HOMVS1ABnrpa5AFIA7TCqRumJO?=
 =?us-ascii?Q?IkwKGk3jWQ5wTKYYhX0mWYSHFcuK58PMI/ERbe6MzgQIPknU/BkEFLFf54do?=
 =?us-ascii?Q?ztRbatAXrbLk/lRe+c8AgutHhebIynyAboDRe6YifYUsPeKOJb4irnsiyW/Q?=
 =?us-ascii?Q?Befo3umM3MxNcZasqZWFpCZ/mDz9t6qs4rzxsB5ssgKvxk8Y3uqvqFINkXez?=
 =?us-ascii?Q?Trcgxp2ZvVaUUs6Wj9zIy9dZQ8C//0RvEtI1YP8NPMxabSWBOGRqtyZ5xFwg?=
 =?us-ascii?Q?tiyz9hOX4w4gtBo0qsYXjcjM5ZLKneXB9oE8Lff5VKVkEovDP1Kjd2s4W6f/?=
 =?us-ascii?Q?0lg9rGLSHBEzroZaEY5GA4utOr7rnrFEIpfUeNCChcvWQnZc4d5iJWdOtuxa?=
 =?us-ascii?Q?RhyIFBA6KWMHUCOE/V7W5QEIYPUCADMOtc3BT5lCwA/e/u1N5pwJGXJZo7Zt?=
 =?us-ascii?Q?XhkHsiV3JYjZm/uunplcpl6wz/7NOGDbjRXeQiG7nAgIE/Lo98y6ta7eVyhN?=
 =?us-ascii?Q?ugWxgNYkbNxCpbUJmF6PANSHzdxOZoJWmRxvP5CpDRY1m9zJBGtIhHG2rArX?=
 =?us-ascii?Q?/YJRAPPk6E1ij/JWs2QegOhzTWDk9Q4PvB4SwwIxDzKK35n4EzzPGN2vYFHv?=
 =?us-ascii?Q?o16oFWxeJA4YqqwvOS1NzChLwF/Au8zT5R7KjYhpkGgCrnKG6wg4Gc90B/1Q?=
 =?us-ascii?Q?lzOvNeNbfCVGpTse5q7mPBWVxTwboPRDBxWcJl5zCbbto27giyL+tmt3MXBk?=
 =?us-ascii?Q?Ryfyo21vacpr3Rs/1H7siRvc6nDuCHHmcx5E+6gLTvz6IGSiwEo1rPi4P4BO?=
 =?us-ascii?Q?l0pLz0i6MZugeQHJughRI7xfERtmizEQAgAnKAGikfN6cHl92pHI7sUeDACn?=
 =?us-ascii?Q?PPLslKWYgfG0oXjn5tS6/YHTbRBA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:21:25.1457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fe6155-90a2-446d-14ab-08dc7b5d89b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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

New commands for enabling copy of DC bounding box values from VBIOS DMUB

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index abf248d46b1c..f52716c54180 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -952,6 +952,37 @@ enum dmub_gpint_command {
 	 */
 	DMUB_GPINT__REPLAY_RESIDENCY = 14,
 
+	/**
+	 * DESC: Copy bounding box to the host.
+	 * ARGS: Version of bounding box to copy
+	 * RETURN: Result of copying bounding box
+	 */
+	DMUB_GPINT__BB_COPY = 96,
+
+	/**
+	 * DESC: Updates the host addresses bit48~bit63 for bounding box.
+	 * ARGS: The word3 for the 64 bit address
+	 */
+	DMUB_GPINT__SET_BB_ADDR_WORD3 = 97,
+
+	/**
+	 * DESC: Updates the host addresses bit32~bit47 for bounding box.
+	 * ARGS: The word2 for the 64 bit address
+	 */
+	DMUB_GPINT__SET_BB_ADDR_WORD2 = 98,
+
+	/**
+	 * DESC: Updates the host addresses bit16~bit31 for bounding box.
+	 * ARGS: The word1 for the 64 bit address
+	 */
+	DMUB_GPINT__SET_BB_ADDR_WORD1 = 99,
+
+	/**
+	 * DESC: Updates the host addresses bit0~bit15 for bounding box.
+	 * ARGS: The word0 for the 64 bit address
+	 */
+	DMUB_GPINT__SET_BB_ADDR_WORD0 = 100,
+
 	/**
 	 * DESC: Updates the trace buffer lower 32-bit mask.
 	 * ARGS: The new mask
-- 
2.39.2

