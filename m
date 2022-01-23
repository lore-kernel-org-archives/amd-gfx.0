Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96D6C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75E210E696;
	Sun, 23 Jan 2022 18:21:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA43110E696
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGsT0WWXZCwCeNIX03/T5OCXGCqqzR79zQgmj3cJw4Nq5+G3V2weEdJWTuGHC+t1Lyh2ey3TxDOxn2ff5c0HA4kIO51NxQBzukVZPfBzfZwXjDq5pulQerNrLjnNi2bu3QDXR0Sg85CwFeRVOdQ+JL3HLrJ3uXVZRfuc2owPLTHXTceYKYi/L4Cnlr4qIFGdMPbDCP3nz2+PsJVcG8F6ydr6yJtmARZ8ypNE8xkAHYRKvvVHTgpxMmTOxETa6B+V306O0ZFcQnF9EMoreGrf1hMXmrKO7kveiNW0ivTLE5PD26etqralibjBIU+QXtjQ+tmz5jD+gUNS0c5vpR7mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsFBVCZ4XnfoiuVQu6wZcJ8RVTkK6bPOeue93kkVVQs=;
 b=bWXgAIT/oPnVmVv1H5wu871NClWFM6IfLgP1mXj3vMhWvmmEMIb6yYqe0gBeIOjmWtHSrScbQK6FFCv9fg0msf3yk+TNU5dHyo/2T7F0sPCeaDEt3wwKneyeuHWQy9bJlPLnEBcbqPWHpXF6HSRZRQoO62cHKhM+4uRz3XT2drwGZK7iRR9cyWhuA8cc8yYmLZHD6w56/L60Ft2EK7xbBcUykYy+hbPuhoU4rgjazpYLLWgimr2bv21jknkW9Oe9ZQCaIWV/qpye4ORRYeH3o3PzLb+71G7ZcDKEaH8QpUb+tUtgbFQ/kYYKhuSeBu4x2MZ81hk1w/JRVRLsE7BxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsFBVCZ4XnfoiuVQu6wZcJ8RVTkK6bPOeue93kkVVQs=;
 b=t5ijGc83v9w6Tt9pNsJtXBr+TGup/MnQCRcDSI8axlXHrW8eFeLTVHQrRSruVSmgQEZCUwCQ342de9qa8/HoCMWs8n+MapQ/TIP4t+YCznaTkn+36HyVZgH3YdT0br/q8uSqJGCuNlzjeO0HlKEFh4tXsIQ91pOKFia/f6NwLII=
Received: from BN9PR03CA0970.namprd03.prod.outlook.com (2603:10b6:408:109::15)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sun, 23 Jan
 2022 18:21:14 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::af) by BN9PR03CA0970.outlook.office365.com
 (2603:10b6:408:109::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:13 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:09 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/24] drm/amd/display: [FW Promotion] Release 0.0.101.0
Date: Sun, 23 Jan 2022 13:20:13 -0500
Message-ID: <20220123182021.4154032-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 102d80e3-3598-48bf-41b3-08d9de9d239c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4231D530C82FFE0FCE147923985D9@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUqem/thHD4VpAKNaVla4E/dh24noEqlMaFTSjhKrndndC2bng7Noyg23Eb/GspENfxZyXrmDLCmJTVcgAuzYdS5KovYMRnbEHPkcpTSzK6nefP1HSmjlT4CnIF5CP1t2uzQtXH3zfEVSxA0jwZRT7kamInkMFOCYXpi1B8Aqt65TN+FmAGk+2Mz8Lt9Iv077vgvB1Snr80bMoCnXdXulZwzicdRmxXr7f1OQMvk1Z89fUWwlD9QXF2B8Ra7Migwa0aeLFHcoKDhNff2L+oc4Ia2g8IgrJLFyEHBfU1uEqKeaRC0VxwtZfYgiByJ8982K+KBLZIJPJjNDjRIIREeoPCzNvx46ct+fe9F39hgfRxrTazzYQ6DsIgSUe7ZIU2oB1hX/pwoUJs4BnAouyQjdAvNpP7ly9HQT6fsa8HlVEN0lz/0L2dnm/YTRVXvRds1FeeTzMbBmH0wzsa928J/7ZWZAjKQIbuuMMjPA4XZ2D2fNXPFtNvvB6a0yFXVbXAojJx2ki00Ya6zPke2jNGH7nwrIfxt2VgjNQft65UbXoLrILbWmMUSCWotlo0L0ZryD9Je8IJ7sXftXTaXx0EG2cvnQVu5LzbWHO85XQ9wTO553mUPh8kZu65uRnD5A8EJqvbyqLrPe5FDkKT46UwpIYE6vIFfMX3UB2nEXtTJPtuyg/N+3tgMKArcY9+NjrxUjnDQJtOFceuBF7MlU82pSqYOAMElVS0Yb8ntGWyRRCbIaHv6M3rhFZF2NZhI5VrI0ZMba3zpfpbytuPvv3fiMb8CcTq4CSuvFUIDXT9Lr4I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(86362001)(2616005)(6666004)(83380400001)(426003)(36756003)(82310400004)(47076005)(81166007)(40460700003)(36860700001)(5660300002)(26005)(6916009)(8676002)(54906003)(186003)(70586007)(356005)(70206006)(316002)(16526019)(2906002)(508600001)(1076003)(4326008)(336012)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:13.7998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102d80e3-3598-48bf-41b3-08d9de9d239c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

- Add Scr8 for GPINT messaging between driver and fw

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index eb152f5e3ec3..9f609829955d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x56a29f36
+#define DMUB_FW_VERSION_GIT_HASH 0x1288a7b7
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 100
+#define DMUB_FW_VERSION_REVISION 101
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -368,8 +368,9 @@ union dmub_fw_boot_options {
 		/**< 1 if all root clock gating is enabled and low power memory is enabled*/
 		uint32_t power_optimization: 1;
 		uint32_t diag_env: 1; /* 1 if diagnostic environment */
+		uint32_t gpint_scratch8: 1; /* 1 if GPINT is in scratch8*/
 
-		uint32_t reserved : 19; /**< reserved */
+		uint32_t reserved : 18; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
@@ -645,6 +646,7 @@ enum dmub_cmd_type {
 	 * Command type used for OUTBOX1 notification enable
 	 */
 	DMUB_CMD__OUTBOX1_ENABLE = 71,
+
 	/**
 	 * Command type used for all idle optimization commands.
 	 */
@@ -657,6 +659,7 @@ enum dmub_cmd_type {
 	 * Command type used for all panel control commands.
 	 */
 	DMUB_CMD__PANEL_CNTL = 74,
+
 	/**
 	 * Command type used for interfacing with DPIA.
 	 */
-- 
2.25.1

