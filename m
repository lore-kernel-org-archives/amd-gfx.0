Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02688C83F25
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 13:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2FD10E28B;
	Mon, 21 Jul 2025 13:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n7WhrAiM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B26D10E28B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 13:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVd4zbvEfLdx9QuRL+vECYQiKD5PkD2lsNE8HwdiSHK/iq3a34p4ToeiseYiO1yYTZtOrfYJFEJjf44nm+m0QE54rtG2BQvT2OPDFAKrVieSyuNYEYXID32cX/9p6XJQkl71cpPm58e1/PrIDF8DBBQ2XwXEZuMc6V5IqejZAurKL+KPsP3YEwPmJK2wYWSSkrvymSfLxRwiaJTyEVdANY0IaF/nO91ea9ZAcISnU9o/qQTgPQqMV1l/Gal+CQPoW/KrioR35RxLUXZPuwtGHsX0o5UUQURQBWqNb3aQNspi79Fp45zCRxzvT8oYbTRWJrNFb8fsBE67cxBqW8tW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhSUdXaXfVuz9B/ZZhOaKE5vx0XLzQ1BDyZ0ylbpnV4=;
 b=L4av894Qq/JmXn5xxiEHx4HNK+OaYKsPZJ5zdxyRAja2nkzYQIYrdiQI4AZdQ08l4nWnpNYsIHlv1cVk88r2z0x+iTKms8uxja1bYhSBuocZ5/osR2UGpznXorSiTWdB2AnHwp1j7rAZDK8qY5K478Z00T9SiSKCUQP+tJb4da6IrlSqoA5Orfvp4mCbyMVRlm8COxhcJE5o7hejnouCYLNpYK0N1O7xvnz42twlGWp7BGZ47/fUdY1JxemaVNT3d1ft1u5nB094azy54Iq4Ba1ZupKcy7RI0sPSXrV3UN0FXkkaZrQumsgE2Z51+ZwpbnwTk2HoClniCZU2kJ4O8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhSUdXaXfVuz9B/ZZhOaKE5vx0XLzQ1BDyZ0ylbpnV4=;
 b=n7WhrAiMp6zEJKHdaCWsYGx//3Hi4PjY1YQ6isyLU0VCV3/nw2u+dUadzMp397n7vqVb/imT4SzGEuGs1v2iSPaf/lQvHPtUZ4EqpndKIBMWCa/hzZBasioTVzE3jTCL3zF7nYNzGyl2xLvXIrHCTfyUdk0ZX+4aFxWekBTRHbA=
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 13:23:05 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::c3) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 13:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.1 via Frontend Transport; Mon, 21 Jul 2025 13:23:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Jul 2025 08:22:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Alvin Lee <alvin.lee2@amd.com>, "Dominik
 Kaszewski" <dominik.kaszewski@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH] drm/amd/display: Fix misuse of /** to /* in 'dce_i2c_hw.c'
Date: Mon, 21 Jul 2025 18:52:36 +0530
Message-ID: <20250721132236.1292535-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f5f6eb-0508-40b1-91e6-08ddc859b935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MmqR9Q0yQNamC3V7BfsnRMaJMKth9ME1dKB4KUsm3mkbiXK4Tg/QyBp2PyJc?=
 =?us-ascii?Q?YCUTFWYP1HztDlOvNyikEzaOM6ZwioYmIs2/kvgL8XIuDrbE06B4zvnPXX6R?=
 =?us-ascii?Q?uyrzTnxAgCu5jTsolaInnqktLZmtjwGWLtiJpmUBQTT47A8/95FRC/0Qv3Vs?=
 =?us-ascii?Q?9T7WLZ48V+zVF+QcksjIXz3kFbpNo3PkH+OpYvSWQayp43NlK6kKLzxwBkET?=
 =?us-ascii?Q?1l9UqV60g3KnqlyYzTADAjfW44FX/f7pg5Bn1xdRrFbjhMme8CNZm12O4GKh?=
 =?us-ascii?Q?SHOYMtXlbPGUohQHNbA5EKFE2udJJXorroj+8IM/cgZy83F76wWbTAkEt3xW?=
 =?us-ascii?Q?JZV+/tscpt8eeCqAZ34KWRxsscvh0v4swLZZ4Cj0YtqWV0TaYMzhiUcarick?=
 =?us-ascii?Q?U3vo0Rg9DlgfzqbVAeFXif3DbqI5nhAKMCq7jQX4yydmLa+2NplH2M1pB1c3?=
 =?us-ascii?Q?iigW26LyMWgpQIslNODdDQ34dRHfTL3BR4+NTCPsIRSdV9AsFfU6PPEIau9S?=
 =?us-ascii?Q?C+OiVoYnEM85zVQH6VH10LuuZTHmwLGFE2eCkB2OSzzql5NmqOwU5bNM39q4?=
 =?us-ascii?Q?K7Y8XIcb4KeOv1In0qG9fi48M+V0NSwiM6CUOVpW6jrK1EhJIvTKQbNHsklG?=
 =?us-ascii?Q?5hu2Zzq5SFWgPbS/qaqfXCgRdYyqW8O3FP8Q55+AA4rHS8hNZnCKjvMnIAA1?=
 =?us-ascii?Q?R52/84HiHQ9OtoNJONlFC323ChqPtVS8EC1YpKrEWvYLF/A3yY9rKDia/4Ee?=
 =?us-ascii?Q?Tz1PrnE4jOAb6nPUkyNOcXhRUaFZxAYPePWnYFaNZ8YO8LqN20NzTuezWSLA?=
 =?us-ascii?Q?7+CUbqFXgh1P8VgTMUhN31B2aT1g7mo3GZz3XLL85tHzWS/IbJD+jJSsvajd?=
 =?us-ascii?Q?2LAuo/3oe7iebvB7h0mquA+U8zCdKVdjnnJLqYNfdQ4gsQfYM1uBUocXRhA0?=
 =?us-ascii?Q?zeWVhJKUGyeHXgii06CGbN5o6zMtabrH7SNpAkWX+z88CCzVWnL7Q68WTucL?=
 =?us-ascii?Q?eMZ41tFMO0ydvwrAGLrck5nKXv76NF0rWojYFgbnrOA36d9YjeFg30+epdcF?=
 =?us-ascii?Q?lLTNWkZBVpWM1ngrTbgnYlGjOn1zJUnsEJDI9Mbn9T1ilW9DeZPzVlMl+/Ta?=
 =?us-ascii?Q?lQowgF9zuy4Bc2HiqmkHTNKTPb77TGJrntuYFdwiw8ZcvTdhTpiBu25fluPN?=
 =?us-ascii?Q?W/3bEOaxn2pESUok7u7h/9OCb6CcrFjrzMgZWO+Pq6S07iHoeOTXGYh8d7Xc?=
 =?us-ascii?Q?+x9pK/ZfHsrDmYzcGZsocLs111eRLdHHhJCP1F/69mXaMcxXBt7pj8M3y9vN?=
 =?us-ascii?Q?/dLqs9KCbt7mBpaza5z/xk5IBmwlYON/8YqFjp4UTDptDLoBuEfkkyxW5DpA?=
 =?us-ascii?Q?Wke+5kI5j9UOp6yrxqlDijpTXv4Ss+QecLBY6weOo/BsaQWNjZb2q+VheAO4?=
 =?us-ascii?Q?AoIp1pFh0x+Z9h/EWnfMmRpFJf7P63zOyBoXxm0t8O3/gA/fp3bEhxUx3Yd4?=
 =?us-ascii?Q?gB3iUaSswKxEUD4X6CHHD9JHGXr9u2TqpFKA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:23:04.0997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f5f6eb-0508-40b1-91e6-08ddc859b935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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

Fix the comment style before cntl_stuck_hw_workaround() by replacing
'/**' with '/*' since it is not a kdoc comment.

Fixes the below with gcc W=1:
display/dc/dce/dce_i2c_hw.c:380: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
* If we boot without an HDMI display, the I2C engine does not get
  initialized

Fixes: c9130176a41e ("drm/amd/display: Workaround for stuck I2C arbitrage")
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Dominik Kaszewski <dominik.kaszewski@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 4e06468a6284..0421b267a0b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -377,10 +377,16 @@ static bool setup_engine(
 }
 
 /**
+ * cntl_stuck_hw_workaround - Workaround for I2C engine stuck state
+ * @dce_i2c_hw: Pointer to dce_i2c_hw structure
+ *
  * If we boot without an HDMI display, the I2C engine does not get initialized
  * correctly. One of its symptoms is that SW_USE_I2C does not get cleared after
- * acquire, so that after setting SW_DONE_USING_I2C on release, the engine gets
+ * acquire. After setting SW_DONE_USING_I2C on release, the engine gets
  * immediately reacquired by SW, preventing DMUB from using it.
+ *
+ * This function checks the I2C arbitration status and applies a release
+ * workaround if necessary.
  */
 static void cntl_stuck_hw_workaround(struct dce_i2c_hw *dce_i2c_hw)
 {
-- 
2.34.1

