Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628F8FD88E1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F5310E7B1;
	Wed, 11 Mar 2026 02:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AZHeP4cM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA0E10E2EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW3BEVJCmM23n+OvYCPsOA6vTw0bpNJwLPkFe91sGzHdjuhcSrGIVjp539tGeqnpwdNc1BYocbc4YX8Tz/S/sfC5Gva1wlogHgOv/DqIrAW/tknBNWvCpNpjZAGg0pgmpaNg4VF/D/Dac7q5x9oo3uVsYVK2HNt6qdHjN2eJqUsA3QqlgJEhy6Tuk1kGcYL72PdBsTSnZZRs4bkf1H9+YKozxiH1EGxo3iklW1Kmh6t2btGoH+Lo23cJ0fBgp/EFbYcdQ9G9jhE3YUYWT3dn47mxnjb2R87heaPQow0YtV26nyp3/fAfDnQH2SvNxHknKlpNN1oQ6hSrLcYLCs+joA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1oGtj1b/WdI7yrsoKTa0lry6PjoRDgofYio1L/27jw=;
 b=ierTKvBF03+T4cqP20tZz3KCoudK+uv9s1DeFtsWHJLIl/Dg8GMgnMYI4mGBLXibdoS2CRohQHzA68qlkLWRLpGwbVs0OViVrWC8bWU6WgOjagaHz5iIRm9iN+7E6bxzNpPXFt9n2q+wOMMUvg/jz1zo5U97r9vUQKt+YlCjY8lpfubLpO/94GR53fFHDFq7RJcLVDb5rmVu3V3sX1hPF2WPUEBr5lSV2cES7opoCRugeTKz76XFh76NDIbNX43UdiK+LmfM0NwhyuJsTPPu9u4XYSMn5DEdfANq+QBd2ta6dPiyc8VU5R4fxtKHeykextCmpHm+bZwcM60No115bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1oGtj1b/WdI7yrsoKTa0lry6PjoRDgofYio1L/27jw=;
 b=AZHeP4cMZ3Ennc6NQsFCvPmjU8fRAEh2PoYzeaEjXTIqdWSZPzOazOY3jCUmbHbOPkCSuV7+81+Bqi5VdIB+/H7Z13qgxpR93R4SWczLeSHa/fqiAsA7345l6mqNW+iiwsxntLTbWUlK8cP1fZJFI4FDvuS6JrqTeSXfYb6yVtw=
Received: from SJ0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:a03:2ef::25)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:45:41 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::e1) by SJ0PR03CA0200.outlook.office365.com
 (2603:10b6:a03:2ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 02:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 02:45:40 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:45:36 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 2/9] drm/amd/display: Fix number of opp
Date: Wed, 11 Mar 2026 10:40:34 +0800
Message-ID: <20260311024652.2668570-3-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
References: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: ca118344-e824-4218-4074-08de7f1848cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: k4WU64GYKnDUFwC83KhIn7NfFPmWRQDU1McHPF13x9kCMunhB2GzllrR/Xy6tWRuxNDcDMIi9F2ZsWHobs8v1eJi7BgA0t/rTGxN8hOKLFGFVQP/CEg8EED69sLalw2lvX6qz3U2V4BEh0Um8EIqZTjWczYUOal3n6c8IIXfmwlh43KoIyBQYflQjU94Xstq935M4iMQJBLOcEjVB9N0thF5sYU36TFs4vw+uSroMq2ZEyuHT+V1uQYe4t9l/qqAsueVzwoG5ca6yCfcH6D/q1rWdUnRPD7NvOHNLz3GouiOr5hBWDkP45l/GrMHav5HvyZaSBmDxt/Dj+//YQJVgognSK0+dUl5XXiWTO6qmdH7EVYYHJVUPRFEm74xwjkN2gRFqJ2YplYPdfVK5+TePDl4dJ5QcIMeucnpQaFW7joKlrLh31+T28PjCr4IxlQcje2El8pR1wrcFFGdS6mKaLhinhXv5qIfsl78+TnvGoP5pkAsrk66tURM7GAfQH6lAnbJil8SVESOatZqdkuCMpa5euTCzAE6IUsphH+aIZBaebuFKqGx28K6qEU/YkdW1XbwfPU8USjfh8hLmM4j5RHL/eRRJW8xYV9CmSzUqD3nnf/9A1cN1keiUVr8JVHC1PyJGCmvY+xr1B4LPV7COugHTOA4DsvYkfCNf7pQKdbMNJEnAejrkY6gjFxFBI6Q7shiRQSD3edVUh2q3pHwqL+FE4MuW43YLJjV557hA1aoc7G1C3fDwOst281SOqn3OwDJF3jH3lznnOIA/5SRxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wRkeLvOOe638NVZxpfSfO36AeLQt1Y08AAZryR48vwD15Q+A5fveGOLUQp2v1ujQCMA+E+w+ueK02DUrIHfRF0iojcxDp4PJi00B95+Fgo9Cqwj7hcVpm6ZLyaCr0ULZmFxnOkFhtK0qqzQyQkRB6CGBDptosrSdp2TnMMc8NJd6GkKigRFXpLDzDBjO3ULK+re5qOfEzBG8Eofw7aQn41doAdoef0SoNlDDZNgGAQ5h7yOpT7POk6Rmpd8QGI7y0r2OArKG/HkbKHkXr3VgoVknAv4ow58hbl1hEYo3lWYxY7+88AONCePp2wBKtB+MubkDfzOtDqgiqlQ3h/U8FLN+veGY8WzSkUIKVriIvIrIRhdnxnPWizGKvcI5cIAqhRYOTKE2Y1MXueKXfqU937SWfu+kaur3YfvnFSwF50eaOPd/epQNm33gZ9/uSt0c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:45:40.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca118344-e824-4218-4074-08de7f1848cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Patch number of opp based on IP caps

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 608b4a305c65..99fc2f0666e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -187,6 +187,7 @@ static void patch_ip_params_with_ip_caps(struct dml2_core_ip_params *ip_params,
 {
 	ip_params->max_num_dpp = ip_caps->pipe_count;
 	ip_params->max_num_otg = ip_caps->otg_count;
+	ip_params->max_num_opp = ip_caps->otg_count;
 	ip_params->num_dsc = ip_caps->num_dsc;
 	ip_params->max_num_dp2p0_streams = ip_caps->max_num_dp2p0_streams;
 	ip_params->max_num_dp2p0_outputs = ip_caps->max_num_dp2p0_outputs;
-- 
2.43.0

