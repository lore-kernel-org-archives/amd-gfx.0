Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F607CFC273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A95F10E541;
	Tue, 15 Oct 2024 08:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIRUuFkd";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F6D10E541
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx0/Ous2pzCr2wuCJLLX1zSeyaG2gcxPyPZIcGVX/1SfS04BH4ygXbMYiSF4FTAVlE0iK7Wtmti+rfsUECkap7kkx6IaM1srkllNt1OzqOF/hu4N79ZO5NJP2yaFBOWvrXZUFyrNL3U9BzETobhMeSoGCXPIOPJzdp9LLd7+kQHVG3aawdnQQSyEORgE2P+6BumRq0wnF/kArl8Nunn6j6GVGRkPh1RwvVOa/Qcd9gCn1l+T5+AmPEV2NWE1UwGA/zesZG03lv+mRDPDV4q2uenThbFfFOm41XRPvG5HwlC9Ef0Thf22Cf5ls3Qfvid/AN+iaSENm1MxS5nSSxg/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKQgWvdfqmKP/NY1Cmjthsu+5MVXV0b2Mb00XEyar7Q=;
 b=smiml7Z4aEb8DtAJBk2tyM13mf4c/Zxft7KLyxnzYWf9+ZRM7Y4m1dRi89pG+ZfMrMkfhdcSli2sNjE3iLayMQSeoqSilcKWB8N3+LiDCs6inXSASYycsHuYwELnmaBHNoWa1Wa2RfmsJh494ZUbstK7Aa1KW25fQnfpCTF8MV76CTZlAmsW28FUf/XJgfL/uyBaJFiz6rI8dUQalJ/gKNruSFV2RhyikF9fiVTlblYPFMQk8BFO6bWYpknwpEKKqNv6iPslvhWbP4smDPQS7kuIMfwwVkNtcRXFJzhpIW/rcc8mJhgWM0EoASRGSZoFBAwu9cLnoKEeRvMaRnuo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKQgWvdfqmKP/NY1Cmjthsu+5MVXV0b2Mb00XEyar7Q=;
 b=uIRUuFkdMY1cb/E4c1OH6eTGo+AxJJPzOXaO/IHEHQQ69H8cWLwLkzdqdFPZmP+GWs7sqiZctXxLEgY9s9z5PeukK5l7DSMKfTrIMuMW8ZL/Tc8nWz9yWqYBzxKrujliStvmbpEkPlrDBotlNSPo/Xhri6hxb+344SKidxBH+Ls=
Received: from DM6PR02CA0054.namprd02.prod.outlook.com (2603:10b6:5:177::31)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 08:18:34 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::85) by DM6PR02CA0054.outlook.office365.com
 (2603:10b6:5:177::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 08:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:18:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:33 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:18:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Bhuvanachandra Pinninti <bpinnint@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 09/10] drm/amd/display: To change dcn301_init.h guard.
Date: Tue, 15 Oct 2024 16:17:12 +0800
Message-ID: <20241015081713.3042665-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: e10e8703-16e7-4dc6-816d-08dcecf1f68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rUsFPVnpQTb3utJMQDZW1Volu1rqIBpU0+4ciJJfajbDhXOlpCjv5Z3+qTgi?=
 =?us-ascii?Q?mFMRquOZTPoNSP27eO9YMKXBAJtaU5ch7qqnWhP1fFUM0D5QPSoiEmkEVjAi?=
 =?us-ascii?Q?T+X4e8tID/yBeVae+r8xQgiNgLpNxTxjDPSLgCAAAOSszNtxxL5sGEBZ0Zvg?=
 =?us-ascii?Q?2XNFQYGvKPDsy/AIWRZFQbL0frvlbUeYyNMfpyZ575YnIElgqVdOCBMqOEBf?=
 =?us-ascii?Q?xPvrq4EkdO6/+FtjevEZBwtx+eFUOPdmb3zO9bXrJMQaPHNNPf2BpTzuG/dl?=
 =?us-ascii?Q?2tKgrTS+X0QgMHRzFg9F9jmvOBPZfG1qaqsrMmQs+wgfqscIw82hm3Onkh5s?=
 =?us-ascii?Q?6zI1S08GDxuLBN9edVBdO5Y66HO1VUtCjFkQLk1QLHVPmI4Hj7aZb6kdgILt?=
 =?us-ascii?Q?ZSe2NopYF0Gqv7lZyIwjIFld1pRW0dfJtCEUQtQxcOC4u0wZ/RIs0Hpx7TGq?=
 =?us-ascii?Q?jKQV4xMQPQ9d983UCw369mL96aDBgy16LDtwYEmx2k5j+f3xHY1CV48rrUmD?=
 =?us-ascii?Q?HEflWWc8893MF20eVXVL07dM66ms1VOPODEUlJzutdvAbHlEMdvSl2BBYTx3?=
 =?us-ascii?Q?eikQehoy7M43lXffxCzPzvudJtMi+7fO9UJaxq47T9pcCDy0i2XpZG4e9iHK?=
 =?us-ascii?Q?8XvBR1aJTfVo03/RDGZ5CixTtyXGMGjOZN6BzJLCZXRuOcLMZn5c/Es+T62u?=
 =?us-ascii?Q?yogXB1/UbxFBX+9II6OFScbt1Tkbrx1ek84zl1ovmH52tsDO0kyy3JmHO/1e?=
 =?us-ascii?Q?jsgCbXgqd9GT76LfxSp4wPJ+khwmUNih7fll0BOBeen5Erm9hEvgodqtXj5l?=
 =?us-ascii?Q?2EgtRqsxU9/Z526teqzSXZDzbs/HghbnyIKH4qqBbN3Wi6YyA80RrdiMUIKc?=
 =?us-ascii?Q?O5x1k3NpU73Z9lvnGP9d6MjH5aUDLNnpuCqhyQUaUGapn+BZ3ve66jFIqwM4?=
 =?us-ascii?Q?XGTtdj9JiXzzGcMnMAEhNe3ca1R3GqyyVpA875fP2eyt9UG49OmuCsPEvHEo?=
 =?us-ascii?Q?FpRJpI1k30ZHetedKcI4fKdx77A69pCxhu9NwaFVmUpWdI5tA9pD1UourM3T?=
 =?us-ascii?Q?UkL6gg1F2MG/VGxVuYgVd/4qpBcw3ihWDrfwncxa22wigtFlMVzWtJJXt7/z?=
 =?us-ascii?Q?ZJ1p2J/BPJ8R4tjARVAb4z3GGoqHezQD6SWcCmkmix70N1ULccb5HqgVjii3?=
 =?us-ascii?Q?1P4K0WJbV7ErhKwBMaRJ0CakymAc4B2K/MOgfB2ZuSz6rwRrGBYIbNS9VNNk?=
 =?us-ascii?Q?5yEYupc61NKC5fdgF7vp0YNsfOHTVOOKSAF4XwjzVfcq7A9VLjF2TbuGlEmo?=
 =?us-ascii?Q?pA49TCyKp5i5VT3WYsza+I0jz8bN0HIGpTzs4FuiyQiTusm6CqtAdVMvZ+NQ?=
 =?us-ascii?Q?JB62BolnR9DjFtKC1csw3nN+Wxw1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:18:34.5660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10e8703-16e7-4dc6-816d-08dcecf1f68b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

[why & How]
The original guard is wrongly to be set as for dcn30.
Changed it from 30 to 301.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.h
index 0bca48ccbfa2..a6e0115a53ee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.h
@@ -23,8 +23,8 @@
  *
  */
 
-#ifndef __DC_DCN30_INIT_H__
-#define __DC_DCN30_INIT_H__
+#ifndef __DC_DCN301_INIT_H__
+#define __DC_DCN301_INIT_H__
 
 struct dc;
 
-- 
2.37.3

