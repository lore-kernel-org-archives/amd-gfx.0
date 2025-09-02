Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2378CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC2910E70E;
	Tue,  2 Sep 2025 13:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uxj29gjx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5B110E715
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F04qbZ71PHQMzo28OxYCpGfwe3RWTqNtzoArWWQ/vgvc1MwhN3t7niKw6BPD6CZyHc6dcTmclfUyGp4ELBPFDNsI9PZIOwVsadG2/8LDZeRlvFHq9xY+3+TOM29Gdewbdx7kp8Q/imxXOrbvrik0RpadSzmfX+679ICzGrSljAYtZlXghv2/fulRcBOvGo2XNHA7dwKnFR4x7MyX5EzKvTpjctRP+ruWE0t1kDPFHX4wiaM5ZV1gq7+UEZX3UNc2m8PgsfsZWilCjzhMEQX3vBshNJUSBO/+olUweOVRHnSAbwJ3rudZMq9RZItZp4lHmYwPsjuISfDCMNOEELuY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUWNCMBlHfuCjFzxmgj1NyjGIn5dy1CEL2vb8eyiEb4=;
 b=h2fGPwOZXSTT7f4Fdkfh1085ByvTjSsxquEI/6SH7tP9U13ZEeu67Otas9uewFL9s4xoMSK/bIRUkAQXV0lJxd6GyXOenxPUObO19W7cmzuUWQ42NSw1NtDKlEmq3OsS1aQ8pjWVkl088QP1+4N4b/0J1YbDkq3gtNU9x/iLM8g/l40B+j4cozbOSpiggE3YwQekgJnyS4Dho9wrGazch6L8ZlXv+bztma6IiqVy+6kKS+mwGVlRd/bJr6U9DXxgpwVWUYOpmY+WhytWBsxDtsbTPAIkyc/S2MR8dra/HxyDdhMV0BwwPpTAUzZhDj/sMqbG9J8IxLDHXwDbSQde/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUWNCMBlHfuCjFzxmgj1NyjGIn5dy1CEL2vb8eyiEb4=;
 b=Uxj29gjxifRfOr15rf7lP762cnfmufgInHK4sJlD7urtc2PSpo/tXj422klwQPABO7OqnXUwJAXcIKm2XSKSU19s1MDGjA2XJZnr5UR5tvfoZVk+8w5Ho2nl+/OG4OmqzqoxIFkbT4jYRKp6jboIBqMcs5VKEVkR5p8kzVBZUQw=
Received: from CH2PR07CA0048.namprd07.prod.outlook.com (2603:10b6:610:5b::22)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:36:02 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::ab) by CH2PR07CA0048.outlook.office365.com
 (2603:10b6:610:5b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 13:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:36:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:36:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 06:36:00 -0700
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:36:00 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 7/8] drm/amd/display: [FW Promotion] Release 0.1.25.0
Date: Tue, 2 Sep 2025 09:33:36 -0400
Message-ID: <20250902133529.4144-8-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: f530dd5e-2791-4338-18d8-08ddea25a858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5W3ds3uvc/gO+4d0G4J0iIHFR2yddA9C4XjsFFQPaH9rYocyd4/r+6HeSjcy?=
 =?us-ascii?Q?eKAwet91525kPAfQukxU42YpyRSFmu3ua1tWEPJV7pZgoidVg3xooVdo8+BW?=
 =?us-ascii?Q?PKKE35e64LySB79jCALoPfXSItzcf7ayTYj5mZ+jjRfVvQyK21A9YNaYRntc?=
 =?us-ascii?Q?adiCVr+Cr7p3yKQ5pllrZpBj8qKWtqh0eGdfm+RmLoGEHtBm0WkYiVPoE1cu?=
 =?us-ascii?Q?9393g8G995FfLmNJ6cWhu7mUCIPA+AH0pvGIhlxAiBIgVDHHcuxeeCtL4xKp?=
 =?us-ascii?Q?eNgvXEIyUPz7TvYQrHJnzimAv4oQNR9s8FHNEkElXs/9redM6UTkGufg3qD6?=
 =?us-ascii?Q?12EEWKcIGrVOdMhzsMVddJx//97skkoXr/Vk2VwR0Wc1DTkYNwGiM14nPpPx?=
 =?us-ascii?Q?RcrZ7Tt3kWjw2jpywxSEEWXjhRe72c/ZaayXBFhm8+rQdhzQ/SMhqUBshePM?=
 =?us-ascii?Q?7gQQmEqZ+Dr/ralozWyMtLfzt53rLH9nhEv0vKqQxIwEporuQnR1KMKYm/tK?=
 =?us-ascii?Q?ONmtisGJIxeu8brpQWBDtPdcXjhEXZeBP1pem+N5f+itMeVfENQQJzsU5fj/?=
 =?us-ascii?Q?udRhqFX5biCIAPro8DCSmkvsi40HkZRkaP7VnK94hcFpz87wbKbdG7H9JpE4?=
 =?us-ascii?Q?i+vdfrCsNu43W+ce9oAzhgcE3hcVMCmpnw/QPtBr2xTbyQb78xXvYtAUSCE8?=
 =?us-ascii?Q?YQ7hTC/gaKXYx4x/EC23AwT6XW06zwalJDgbWhzn0Fs6VKP8xz64t2K8Ljdq?=
 =?us-ascii?Q?CzRDvyAkGVFjCKoNVgHVhs5ZWR5N8kdZYp+dpz8PTtNV8Uk/hPhSJNaY6PRh?=
 =?us-ascii?Q?o7S1LJvLPupls9BiLVYoQZ4g6j0RbQm4fAf+3G0hFeBFJQURydBiaN7lc1GA?=
 =?us-ascii?Q?i1YNHl8/ZO5On6Efg4M/r/jy7B2SpaSQLBpb42xlY0R+Ru6n6lZ3NJFbldmM?=
 =?us-ascii?Q?l26w3ba+esD3ZXGGSLdPymkQkLvWJm4JXo6nYCYBUDqLNFRdnzf7Rds8suuE?=
 =?us-ascii?Q?ZvTL1cHzHg/TF2nRdZVOjl9mWrg4TZ9kLOf+9u3QuFR0RmO345iDAmEEeTzq?=
 =?us-ascii?Q?1O26wxY1TielqqGfKkNfGDSxgCx8WCWz4MwTqq6shNYWtmjcTV1lnOL/cIbd?=
 =?us-ascii?Q?TvCycoRAhkIJPhe+kjzs52AH3BkJSf7DHtzCrBtBSllH7B2pAEHwhIj6sLUY?=
 =?us-ascii?Q?Rw8h+4NrSFBgsxzIofKt9ZptZmZDgkTZh3mTOMBBVoPwfFkkClHXmOBMSkMO?=
 =?us-ascii?Q?gsTFZuj+u3MHhlZ43wCbn2RRMyvOIq+UhTaDmS/SyZUJ0lJ2BqyGlla/CBQT?=
 =?us-ascii?Q?pS+6OS+9oh+NgKA2z2zkB/bjma6r07r6wq+O3eXuLl47l4zS7iTqArTigoKd?=
 =?us-ascii?Q?R2rEdJxib38d2A+EntResC5n4edh2u3+S1DSP58iskWL9oYjS5HqPHeURrmx?=
 =?us-ascii?Q?szgtFGuXCRoda8QHer7FIORFa95LJGEIYDYKrhl1LHtJjInDJ1mNOkEfAz4k?=
 =?us-ascii?Q?d+rklySuXf7kYM38Nm3OikI0pVn9rtABK6Zs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:36:01.4964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f530dd5e-2791-4338-18d8-08ddea25a858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b7d49a117fa7..02a4a20e3560 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2364,6 +2364,7 @@ struct dmub_cmd_fams2_global_config {
 	union dmub_fams2_global_feature_config features;
 	uint32_t recovery_timeout_us;
 	uint32_t hwfq_flip_programming_delay_us;
+	uint32_t max_allow_to_target_delta_us; // how early DCN could assert P-State allow compared to the P-State target
 };
 
 union dmub_cmd_fams2_config {
@@ -4170,6 +4171,12 @@ enum replay_version {
  * Data passed from driver to FW in a DMUB_CMD___SET_REPLAY_VERSION command.
  */
 struct dmub_cmd_replay_set_version_data {
+	/**
+	 * Panel Instance.
+	 * Panel instance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
 	/**
 	 * PSR version that FW should implement.
 	 */
@@ -4178,12 +4185,6 @@ struct dmub_cmd_replay_set_version_data {
 	 * PSR control version.
 	 */
 	uint8_t cmd_version;
-	/**
-	 * Panel Instance.
-	 * Panel instance to identify which psr_state to use
-	 * Currently the support is only for 0 or 1
-	 */
-	uint8_t panel_inst;
 	/**
 	 * Explicit padding to 4 byte boundary.
 	 */
-- 
2.43.0

