Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B787606A320
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CeRQ389F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA7E10F88D;
	Tue, 27 Oct 2026 23:21:00 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE8B10F88D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts1/3f4YPb+LLJNHosP0lFFugAR2N+iKAEW9uN7NaSDBoGjd2TRK7a8NMuKY4FXYeGb+g8qC9eXW69waupk1homI91TvWozcl7xlHDV49AqHHNgrVHLPlA5Cp0tiggbHy2RrZQR/xEo+R7ZxfIgyAWlYshyiRczkm7CGpAw7bRVsCf7prRibp5lfjIy+cEYNcACoCYAmYF2S9GfpD+ot4hAYM4o+owV5XaPRc78fxF1vOGm/r/kEfnhLiy6JToK5cpoNwlaqyIgbm/j+3jOvaFApmWTaUyZZa1weNCKlFoh8B5JpBdg3YYZUEBY7OoCxWW9RktirjJWZMfDiCRtShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7v36OsZFB/ZdWjmDiM+h8qnDLQw/GJG9pJ/6Ph8w7I=;
 b=xlQHIMd0hCsQBJaOv4meG+pyGPaR8fg+OFueeA4QnRM1k4B5Oyp9FI1kFT9wjx25bKxubizDgXBUpQPsScXhSoqdhloAhYHKSm1w0pDRmFoZPvd51QxCLi6SdGYUZAN3Bk9rt6pSbtgdWlkMjdDQtFbx67PjJYkRfbc73rf216FmHiH0gM3koAiJz/GCNNPa5IrKmv+OrdSm6XHoPY6eJZLynWAWsAVFqqEULa9aT37EIrWpDI4E+WCow7IPOescg/nwXh8caaB031p5xv+m4CwvdnlNUYFQV58p0+of8rfyi3Qf8t1ukEYe3xmhD1+Bt+rrEVwzqustG3eTfaJwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7v36OsZFB/ZdWjmDiM+h8qnDLQw/GJG9pJ/6Ph8w7I=;
 b=CeRQ389Fs8OQ946QNV+9f1Fm3WkYo3UJewr9kGiSJjV9PfgSqQD52xRgDADiXrTl29tmxcZeZOGWgPlTuJFHhE5z24X6fqPFgA7tCcMYu6Z+lzJlQFbNJIq+d5PyJBKL4D9hBpkSB3lMgeau3wLa+e4sEF+O9IFdCU/bxWZXUNY=
Received: from BN9PR03CA0262.namprd03.prod.outlook.com (2603:10b6:408:ff::27)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:20:51 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::40) by BN9PR03CA0262.outlook.office365.com
 (2603:10b6:408:ff::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 27 Oct 2026 23:20:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:20:50 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:20:48 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Allen Li <Allen.Li@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 02/28] drm/amd/display: Allow bypassing link_off_frame_count
 check for replay debug mode
Date: Tue, 27 Oct 2026 17:16:58 -0600
Message-ID: <20261027232005.2879750-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cb631a-1aa7-4d52-291e-08df3480f0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|56012099006|261021121427099003|10067099003|3023799007|22082099003|10086099003|18002099003|18092099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: XrVAiXE+pq6Woi4v4NHbvigzdISiEDfNC4x4S2YD1CNiB57bPTPPfUXPbI3CrH7tS1wzp011TbMmPqB1nGvNAWVD4pTSnwtI/Jrw8TtNLhzzv368AaobUtOmOKxdp84GjlUIXjI3JhHdWi6HcQ1gosMDX256zym/jT153Q+O9Xl0xeqka9eEuihxrWbSsV3nE4jnrB4YeHXz5UagNHShlTa+tibYOAFUQoRxCiDcPVQ1lIEf/CcxXVa7Afc83Y+73AmVLDw2BfCCl5B/jlg6ziIBIdf5T0T90KdNjlNsgekG7qbt9vNLUf9qoTqDD3KV9vOtWMbOLxRwFXxpYGESz8bxhfg0WzbmJrerPaZ7IRjgY4MsXaZc3yRNHNqAGaNWhxNtznAW8Tn/Vy2PVWZY4sB6lPhFur46bCt0vuuSphqOGJPMJfGtSnFuxHAh5dyLEHuqSJoiJFjkr+6uV4ecGcltHmdublCvTpxYUTeuupf7E5LFuPALnwHnwE9Z5cVt2XclMvY07WxCkvQ5kT18a/HkyZ/U3DHHmLRq/1T/ObnoSm69fgh1rj8eo6FvUpxnYqfV4yw6YXke4yaj50bo3ggYWG11K2/hr7jU3g1b2CE9RQSHk/C3D+RNg499gKU3Hh9Xxzto6fy+KWAGJ7xI/xxBIHXp6YOneyqQLuW5UfB30x79apx7V7dlXhS9Ru3FEdyA0jTaOLFoA+lqvkdMEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(56012099006)(261021121427099003)(10067099003)(3023799007)(22082099003)(10086099003)(18002099003)(18092099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FP4/D2Xksyzu6jW1qL+5sGHcw9FLTDJVJzMVSakxBLBozfqlcBSTmwXtAASHBU/w9O8dHpoiucUKGiX/abxbrmWRkL1Vsb66GysoEPu85L+LUquXFxTJQ/JwDQoaV878ucArLeeuDo91RpyRV/hVdSckbArlNvymFVtPAK9Bic8zbxiXYnfxtDfnwunZMCXACckRPLLDbKpa2uVgLFwPO+Gyk+JqeyCuw+cxOx0mukPVaABxAZb+Q2Ys56ew3spbTq86mE3ylKsQsl/rfSUwhjSeqKCg9iiMjxJ2X95oTV4qCnNgptyxOJ9OibgzvyRQTPlflTKmSH0piE+Ln+/cl2Ya4wVxFc0lj7JyXZaV7S0p7AsHrcp/hLUxP+r6W1km1nQZyD2IwLyRenehO7HT8smw9fsRfDnn3L6ZjiKaamqhfPlNk/Mgd8ZEmXNrOHi7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:20:50.7251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cb631a-1aa7-4d52-291e-08df3480f0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Allen Li <Allen.Li@amd.com>

[WHY & HOW]
Provide a replay debug mode override to bypass the
link_off_frame_count check, enabling Replay when
link_off_frame_count is 0 on high refresh rate/high resolution panels.

Cc: Robin Chen <robin.chen@amd.com>
Signed-off-by: Allen Li <Allen.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index af241b2bd29a..45fa52011a7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1271,6 +1271,8 @@ struct replay_config {
 	bool received_frame_skipping_error_hpd;
 	/* Live capture with CVT is activated */
 	bool live_capture_with_cvt_activated;
+	/* Bypass link_off_frame_count == 0 check to allow Replay in general_ui scenario */
+	bool bypass_link_off_frame_cnt_check;
 };
 
 /* Replay feature flags*/
-- 
2.53.0

