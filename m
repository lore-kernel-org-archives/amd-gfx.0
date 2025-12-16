Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F9ED5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005B010E709;
	Tue, 16 Dec 2025 09:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IFJ8u7/H";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99EB510E58C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjc6Vs1cHH54tlugC9fR0zKJa3Nu4mFbPc9qufODlNddMqwYM08tId9f6hoqHlQuCkC06zus+L+mIScMVUyjujJrAVlyFcHgCiSiSz1YTGPlAn4KWvS0aiANfJE+YpLjsZqevKLxc2nnQciX41rnkGnCueJQVlS6mhaWFBoulCNLUv6nRGEyIUonxQwpLEl4mhswlQ1Qq2T4xRC8KMYAq8YclhDUe/cxvSknNI9vlYis78mz+e1I4UKN6SPA+gMGt5ZA/3zTlxZIYAZnh87D2OuUKr5VNx5COiN3PU7lGOTqL13c+ng7CffayuuW/GZBGtgm9XQfjVvHXNbCwaABrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTLMNCCdDG8ScFLpQuu6Pe4cCVlc9HjUWGd9TlL6GG4=;
 b=QdABjy0XZDLii9+RXp88te181CTFTjR7RTBCIw2Qb6CDlRYVVLafQTa7UW8vMi9HtOa+r9fm2XtTY/yZaj2s7T9I2J5mE9f0fjbAIqcs6ufhVQMUN3tFcILj4q9bWCWQq8zushR6LLd6C2AX1sgBddz6eTvh0w3xAqGD0Ac5JpQQuzknaUHXxEwvqjVlhL/FFR8WgoT6GurZ0kYbNHNbsd13JpoZsK0N4e2UW0KFQ2kwOLy1wiQsEJgtRB6SsqpASMZQPXtNnAu+cZ+3Fsbqz7o8rxLoV/fn/7075x8i9AGq2Vhgvras1KtO8lEsRhHgKflZgO4wOUdgPaQZvrQ2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTLMNCCdDG8ScFLpQuu6Pe4cCVlc9HjUWGd9TlL6GG4=;
 b=IFJ8u7/HWarFMtT7Kdfo8v3wi3wj1tafkDT6wK1EPFK4A52AbIMSaUq75OoZ+6NJG/ZakNp00mXGCO8dtZ4r/BzlI8sgASIkuRU8QGeBTd05KD71RVw1qbxJZTVCm0lfKbwHw8dMI2gyrfEb+0UZhhHKZQwhg4kRxDAkjjXZ9XI=
Received: from SA0PR11CA0129.namprd11.prod.outlook.com (2603:10b6:806:131::14)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:57:50 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::63) by SA0PR11CA0129.outlook.office365.com
 (2603:10b6:806:131::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 09:57:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:44 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Dec
 2025 03:57:44 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:40 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Swapnil Patel <swapnil.patel@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Fix mismatched unlock for DMUB HW lock
 in HWSS fast path
Date: Tue, 16 Dec 2025 17:56:04 +0800
Message-ID: <20251216095723.39018-5-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: f360d6f0-fc5a-4db1-6a81-08de3c8991ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yx5UKIynmaoe7W8k9va13MDAdLEx8y64maSYz3MwC5WBrsap8Nyl7RfV8pup?=
 =?us-ascii?Q?rMJ/3WMi7YDQ6pduur3+bbS83jLWbxW289oTbaWRd8XaZDzeutw9Ud9g+4B6?=
 =?us-ascii?Q?RbxW4Cbnfgk0B2OOIlzSZ7lkVTRT1n+fRAHr8dKm6C3M6HqUCOZoHYJdRSaS?=
 =?us-ascii?Q?C0SBu8jsEE4frdjhknstbAPKnrip32kEh4ep8DThScGQPUIpIr8Balv5dF4i?=
 =?us-ascii?Q?hPdfQT6vKzuYlVmHxl2BG9KyegHmAlUm36YK2FlAIwMPaq5B7C4GyiPX33/g?=
 =?us-ascii?Q?myW2PpchdE0jzHi1mL+J39CEqPlbzZh+eIZAWcvtzHb+lx2vF7VCNIu7pmgf?=
 =?us-ascii?Q?QacEo9d53u/9kil9BEh39mfASXNFnswsK6aCMOfMzQpJ1MrEXKnZdFCIPcEu?=
 =?us-ascii?Q?V/8p5GqreNLE72vK9aVlIq6nJp+ZozROszuk3psYc+ALwX4cW+lYkajwEqx8?=
 =?us-ascii?Q?ppwXRTR8j1GdDcYk6Jza8OjNnll+cdp+zHSrMqTUZOqHhChtT6rbiZRZO5l0?=
 =?us-ascii?Q?wMAF8Oe6j6+bAFxNUP7/li2bfD/z2q8tAoTW9XICRDmhrn1+eBsp2Xb2mbR7?=
 =?us-ascii?Q?Httqbfu+94vHQfTKqvVDPQaiPE3BacQ7i44GiTFUP4vtEzluZYFTNDOa45bj?=
 =?us-ascii?Q?PouFYka71eLcCO+U7KPooDgat6MQDYDFA9nUWWhsGeOL/613MSgJLhNu6d9u?=
 =?us-ascii?Q?2bskSSA8rob+RhhQgnEWoHJbjyD4Xd5U/nehULmigzjtLGTQwdTgVdSk/IEj?=
 =?us-ascii?Q?MYYTbJ3af7obq7Yo71Ku0b5lqgR2z01FOyGvb8Xhsju9plMJe8z9zWN8k9A5?=
 =?us-ascii?Q?rY+tYo0koSl250YY933J+nC6qvyRpjlJhei9ZzW7xsrHuqJxmVyqL+xTtxd/?=
 =?us-ascii?Q?cILRwVr7AWSdf1unf17cYYkonMFpj2j1SiJsD6ax1j8T+UBY1InOGAgq2K3v?=
 =?us-ascii?Q?wH9ut9ziz6bOgreIychj5n+mhCpcvma1klMIdDqnJ7dHwLQ3Raf5PvhQFiX0?=
 =?us-ascii?Q?WQigjP3GAsP23Kg0sHtMiqVBv0AG81t+1ZcVUwQvrUS7MB0T6QKO2Xn8qWE+?=
 =?us-ascii?Q?VD4rdH271toiLtgfeF7LDrRYNMFrAs1ZCocIUhrcCiXoZGIB3V+SLVgez1OH?=
 =?us-ascii?Q?Ytjl4NpnWmRYKpGxO48LVzdRnisk5cjp7ZMw0yyacymeggKDRC/rd2RUI0k+?=
 =?us-ascii?Q?OQcG3Jc9Kyu/ZoeSuh0627igQA8Kd8dZPIrv/oOhTY59TI+0QlYNbkoEWyUK?=
 =?us-ascii?Q?xuLkp/nCieok7nOLNqBNjfDx9uIRHR/Rzy1rdEs+HUwZ596x7YjN/ai3Lj6M?=
 =?us-ascii?Q?7WhlQf9Jd7EJvUzPGXG0jUu0g3HhXPAOoY6ZFpwHdNsZhEaIuPuRqZB6H6yP?=
 =?us-ascii?Q?axB3qJudFnGsK88clTsd3agyfjM/rm117pnh0bayUU1K9B/GpN4pmx+gJF5R?=
 =?us-ascii?Q?r1lI2iAdASeubxyiR7jfIwu4gyhpgPCh9HVFeeANLFNrkVZ11mYGamI4biH/?=
 =?us-ascii?Q?wIUUqnuhkEaHHOlB8zqci46TWAP0JAXfO4XgodtHZG6ujAcUMVq5sn1no+vU?=
 =?us-ascii?Q?+cAm5DluVnckNI8po/s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:48.9292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f360d6f0-fc5a-4db1-6a81-08de3c8991ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The evaluation for whether we need to use the DMUB HW lock isn't the
same as whether we need to unlock which results in a hang when the
fast path is used for ASIC without FAMS support.

[How]
Store a flag that indicates whether we should use the lock and use
that same flag to specify whether unlocking is needed.

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index e2763b60482a..052d573408c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -741,6 +741,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 	struct dce_hwseq *hws = dc->hwseq;
 	struct pipe_ctx *current_pipe = NULL;
 	struct pipe_ctx *current_mpc_pipe = NULL;
+	bool is_dmub_lock_required = false;
 	unsigned int i = 0;
 
 	*num_steps = 0; // Initialize to 0
@@ -763,11 +764,12 @@ void hwss_build_fast_sequence(struct dc *dc,
 		(*num_steps)++;
 	}
 	if (dc->hwss.dmub_hw_control_lock_fast) {
+		is_dmub_lock_required = dc_state_is_fams2_in_use(dc, context) ||
+					dmub_hw_lock_mgr_does_link_require_lock(dc, stream->link);
+
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = true;
-		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required =
-			dc_state_is_fams2_in_use(dc, context) ||
-			dmub_hw_lock_mgr_does_link_require_lock(dc, stream->link);
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = is_dmub_lock_required;
 		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
@@ -906,7 +908,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 	if (dc->hwss.dmub_hw_control_lock_fast) {
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = false;
-		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = dc_state_is_fams2_in_use(dc, context);
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = is_dmub_lock_required;
 		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
-- 
2.43.0

