Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85B4D39011
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FF710E685;
	Wed, 14 Jan 2026 20:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0/Zb43JC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9B410E685
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8FoGEtPNTdwjvDKsYOMFeyNmeuv7wP0OH8Ta5zsXoSd88pyTsxL5FfgARYDgVVbAN1du0S0wj1lOjFEwUEIdIMghoTqD2ATJAaL6cktADX4AIDlaR/3WNg2MphUvN9u+/RcoKWlN/22uwbuf11sqLoDBYnmNyrS39NkBXmo4idoEDOiSAJJ4qRi16exmY7XSg7XTcgd+l5GBg/t08xQIX2lGxHGIAhd/0BYbCPo+WW7+flFT65SMVLN7jmecOtgRS/JTeYi6g03SFd6BYpySFRXGeCV7esETlLizMafA+S3otm9dQvlfofGkU8Qn5iKQd1L/EBdSNXL2Kvuu/ESGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYGTDZsX+nVYwybtMS46TzF1O67kH4W6vUcfEgEDnOI=;
 b=E8p/juYZUcoDx4nNZE7ogXG+2Y7nbbxKy8TH8/2zJ2gINr77WU5Im3yke2HHM+jmu+4MuYv1qjq3kLkJhGhCN8ld6Xq1qI/iYIpRVf06mnwg6OLhjsiev/zFPUShJHj7ifUjWmzYNgHLY+ElhWy0SY2wDsbgqGcwNwmOOCGD16zxq5RqVMOFBBC8eqkGNMjnHKzbsu3UuaMNJzr97QRRXElXT5tsHJWWV7EfD0ah6Gim/MfWGL1W5eATv6f/5Rhg699fMWQ+7p/gJ5oZWPeBzvmwEAftzx7shkPfIBdtmF3X3y62t4kn70G7NgW8Wze/esDUaRAGkmjqTxGXmMfofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYGTDZsX+nVYwybtMS46TzF1O67kH4W6vUcfEgEDnOI=;
 b=0/Zb43JCzE8hfyiSQcVO+8JaW4Gb+4tQ42ViFqMhcw5SY1oTHjm/MWwWWiNrFcPIVvV01KbdB8yzMLSFy3/iuxKvD2+Tm0/f9v+uv4NfUCVqpM4UJGzczzhEKKp21JPyWjjQgCF7pnpz/G9r7u2ozwmgsCBShnVomgxB0KXdnWM=
Received: from SJ0PR13CA0216.namprd13.prod.outlook.com (2603:10b6:a03:2c1::11)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 20:24:19 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::27) by SJ0PR13CA0216.outlook.office365.com
 (2603:10b6:a03:2c1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 20:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:14 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:14 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:14 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
Subject: [PATCH 13/14] drm/amd/display: Remove coverity comments and fix spaces
Date: Wed, 14 Jan 2026 15:21:54 -0500
Message-ID: <20260114202421.3654137-14-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6e76de-4567-48f7-eacf-08de53aae58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ehNzjq/BL3nrMi0wzur6zYf0SvWZ+jCBWx4NHjM/Ie9R8n6xfcYPHHGrk80s?=
 =?us-ascii?Q?5NqXgCAr6nUvZWzSZRfgfWS9ZRTwfJkTU7UjxsJdXkZJUQPZtmqnumrJYaUf?=
 =?us-ascii?Q?IYpgRuXdF/AYgiP8cx6vdouJe1+XW5uVw1SAKEMMBTVnQSv9135D1PnckC8Y?=
 =?us-ascii?Q?4yKVsx4wutOe+pYt3tTSSOL9wIzgNi/U/ObuKpRc0FZ4PYK0AMCZmpV2HcmR?=
 =?us-ascii?Q?xuqXAjvbIDneGEAh7haTSqZlDGpxFdgR8akJQwTN+++V6r7THHowFf9q8Ao7?=
 =?us-ascii?Q?EB/jKEO0qHtNXBOfSAlQcOkIpf1TIManyFgKZmkPlbsxLQ9rOfcUwv3tvcjl?=
 =?us-ascii?Q?eVKMvd8JNlen2SJZaJL3D5OXwWflL3OgBXgEZLItjsNhuSo6wlCPudYovVNR?=
 =?us-ascii?Q?ZGlfuNXv3KDdAtyMJYowwq7w6OwRjkj9f+YCxgj8wugs3hujke+9zNs5XB0C?=
 =?us-ascii?Q?O5JUc6TFCdJ+/XH3rsi+UtCiB+hGGJIqMhX/qSSnvxdESlIQ+xfbRNrFSzgh?=
 =?us-ascii?Q?gyUUWuACWD6nDSmQ1zx7ZgwDAB1twHDVviR+ElfNc5IKVoi1szcqlyfXWlEb?=
 =?us-ascii?Q?sqyFJuGT7t2IO9AYYHRaPPL//fhCnRQOEWo+QgkGFmbHLPPa8KdXja8s2ikv?=
 =?us-ascii?Q?MM5E9RVY6X7UnJWSBNCISVEBakZtsKKG1986lmj+Bb2swxGFeYTSIGcE/JBs?=
 =?us-ascii?Q?PmVRgTjCWj6oX1ePMNYaqAHEhbdlULMNybUG0edJtayVZNTUGjkeGSBQnDZJ?=
 =?us-ascii?Q?b2wVWSGq84YsPHaKwsreW8+ru4dgFhu/vjJTtTQqZjLHSA4VF1N3jDyALuoq?=
 =?us-ascii?Q?XPweZK4aWROFghbEHmpfigEbm6zo7WbR9b3utRkfS+J1TldUX/R+iUk5ftCt?=
 =?us-ascii?Q?fjKGUKDgqE6eYn/sHaRQGL7nBTRcd0h+Y/+T9WJOkiOe+VNu9xekAtj9Zjih?=
 =?us-ascii?Q?/d+yj0PtupDnAtSvGxg2yZTHfTaxk2oozi5/gzRYqGIYzJ4zMlp05swVa2a0?=
 =?us-ascii?Q?yz5Lc8Gi2KIVTnepDfc9TitH/vfxfgETBgjSH2qEABKJJyWjcJ7K91tq0BPw?=
 =?us-ascii?Q?XV7FSgPxaWNEgCpYqJiVbitrjpID7Gu/au9rZF/SEZR5dYUIa83ejIIM0JyR?=
 =?us-ascii?Q?I1u1uqprylWaFZEPsZjcLsP6BEnyrya3mhihngmE5u+m2hSA20s+5vGG2MWp?=
 =?us-ascii?Q?hJZgwgKkc972yGO9ygrVq5Pg2V+kRSYRIJhYm0T+f9fJJ7U3Wz2zEG4CgYel?=
 =?us-ascii?Q?6kv/Um7gbhTuOWqpI6oWWLcqJMc8tQT4yGnwF/yGD2SNvClAPkf/tGPAVlM1?=
 =?us-ascii?Q?bWJ71477vB7Sh964BcFYEB9vHjhCTHarR8VXrU84sKz1hOq/6/rh0lviyA4V?=
 =?us-ascii?Q?1OEBny9xvZVMvpIRGAh5ZxdZxAo6cqkA2qarK2NZEdXEaBZfTZo4+uEQzn/q?=
 =?us-ascii?Q?H5R8yWWJc9MA0ckk8iuuR6mkFIh2Gv6sY0Jk9FuOyx3kjB5Jo1fU0xGFPsuw?=
 =?us-ascii?Q?ela+a4CfFOSaKS+nRRqFuTtSlJOyEc9HW6prwXikwOtXL6SJ5GyzTfJuMVAR?=
 =?us-ascii?Q?UWJLiGZKlJom33hTP0g3MtuSPkUFMo/TiJm6IFfxEG7niS/d2psRR5Rf3zvJ?=
 =?us-ascii?Q?exg7c5gt3EU2ExRYdTWoihCtAgz9RiZjPjJIXxZDQaE/wZBJXRmu9EeLrYEq?=
 =?us-ascii?Q?2RmcZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:19.2739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6e76de-4567-48f7-eacf-08de53aae58e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Coverity annotation is useless and thus is removed along with other fixes
for spacing errors.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index cf23c57faf2b..86a40ce9a269 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1635,9 +1635,9 @@ union dmub_inbox0_cmd_lock_hw {
 		uint32_t lock_dig: 1;
 		uint32_t triple_buffer_lock: 1;
 
-		uint32_t lock: 1;				/**< Lock */
+		uint32_t lock: 1;			/**< Lock */
 		uint32_t should_release: 1;		/**< Release */
-		uint32_t reserved: 7; 			/**< Reserved for extending more clients, HW, etc. */
+		uint32_t reserved: 7;			/**< Reserved for extending more clients, HW, etc. */
 	} bits;
 	uint32_t all;
 };
@@ -2658,7 +2658,6 @@ struct dmub_cmd_fams2_global_config {
 
 union dmub_cmd_fams2_config {
 	struct dmub_cmd_fams2_global_config global;
-// coverity[cert_dcl37_c_violation:FALSE]  errno.h, stddef.h, stdint.h not included in atombios.h
 	struct dmub_fams2_stream_static_state stream; //v0
 	union {
 		struct dmub_fams2_cmd_stream_static_base_state base;
@@ -3678,7 +3677,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	/**
 	 * @ rate_control_caps : Indicate FreeSync PSR Sink Capabilities
 	 */
-	uint8_t rate_control_caps ;
+	uint8_t rate_control_caps;
 	/*
 	 * Force PSRSU always doing full frame update
 	 */
@@ -5176,8 +5175,8 @@ enum dmub_cmd_lsdma_type {
 	 */
 	DMUB_CMD__LSDMA_LINEAR_COPY = 1,
 	/**
-	* LSDMA copies data from source to destination linearly in sub window
-	*/
+	 * LSDMA copies data from source to destination linearly in sub window
+	 */
 	DMUB_CMD__LSDMA_LINEAR_SUB_WINDOW_COPY = 2,
 	/**
 	 * Send the tiled-to-tiled copy command
-- 
2.52.0

