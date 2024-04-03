Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BA2CD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0B0112E91;
	Wed,  3 Apr 2024 19:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oU0i6i0M";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17F8112E8F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8kfrdvGLhUZs+diB5fVHHnbbpICzENdVGEKTqyzM0QJMPtBC86OOPitzYV92Ewe1kelhGKuVP0+Dbydk7lqM6Afz0oFC7Vvs1hpciRTKYNqPUhSALRPQ/ZzupD2jWtTgvVoaKun+LcR8CtIF4Z0YWYf2zbkJt3nnO56ntJX13pwhy4UQLH5nHV8c794nXeJ/tfp0LtNmoqvGLz7X47s6si66pRSjb8X+fnscM9ZIKWH2IJTtFxqY0B9+oLyyDeBJu80768sQ8dlbfd+08Jh5bg8aDASuYJX1m0WZF7biJnGGdl2teToCrrgNcxeIidxMXTjG8PQXms17zG6l6j9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8d/gWovWaGbYKO8N9ptmz9LQnDMbM2yuny/zQvn004c=;
 b=TrjyyTfSJuEUhaBYs1yX+AY3HMUyeHT3Vw8zoEXuWXzl1N1aGiLyIMuefkjlpB5jfWzvRRV5gaZ0S/f5Klq1U+Nv4kdPKEwQ44cf/zCU1QZSS1+AxmdGpi/LkgfiOIBUvBydnxnwRn8BTn+T9eU6puVIgxm9KABxmqKFyvC2+NnXHdRR5y7IqS5xHsEiF1tMTtQkQOdNXkTPP7fkHcHE7LjyhQuZZHfnR0ynJP5FXGzKR7oDjNLwKZgMx8SCdZPHsUyMx3yilpt9tMRL88QtsHMGUVWmI8ZIdj27WBHSAsw0p0L0mA1PjJcXvDQWyE5KybbtiOqcrFlR28cbP4Pv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d/gWovWaGbYKO8N9ptmz9LQnDMbM2yuny/zQvn004c=;
 b=oU0i6i0MKb09SnQQnT4B0rk1YApqrE7DdLnMRMj8VlpU92fOXRUoe8mMnirZCqNPRaRuMmq+LVeTyqmVVnIV4Lst2VDZcn4wkM00JzF9mmtZvfNwc6pQ78+LunP9PL/wQWzsQupJ//Y9ZAaRBMvvi+7SL582LQ/lNmQ3EAPiLGQ=
Received: from CH0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:610:74::9)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:53 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::26) by CH0PR04CA0064.outlook.office365.com
 (2603:10b6:610:74::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:53 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:50 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 23/28] drm/amd/display: Update DCN10 resource
Date: Wed, 3 Apr 2024 15:49:13 -0400
Message-ID: <20240403195116.25221-24-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: d6223189-3463-4069-dc2c-08dc541782f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ml1+NsPGKBHizVrUa/5DbsBLyaqiaRjz39XwZ3HuPC1/s3m4BF3YZI57irpsfwaRuzcFTB14KXigE3bs0g3z+M6Q4tCmjyWMHxwrjLs+iwG3NQo3t8jlCqWZtxYU4tXjuj3jVhoegcsdIzzmtnPEYtz5VFwmnphxRckczeLeCL1xnY16W/Y1f/qikurKulu+9nK1XpBInwvk92hql3/m9F9V2BsgpJE19S/XqCDeoxsnYdiz+ESZolSuydO8bKy6lXheii/26WNbiIOu1B2XtK4V/c+FN2hC63FMBKU9tst9gOA//BcMkUkF7VYpEeeqssTkJv8N22JEI6hjMO+C21uYeZAKVmjx+nL/vej7E5t2GQyUXeOPUx/Dc4MGg2hltmVwYZmDFEGkDgbMiouLmrbO7wzg8VIxjyC94Wjmg3o8tsXdQgJ+pQCjIYo4Oa2JReJe0DIKYdYTIMu2S30/BselBDMUJCcO0q9ZWjD1VtPTP2/4HTCu8l46vcyHnVgJeNJZXvMP7KOIntifxNS81piAYGlX4xiqyku5f1idH89TpJ1Qbng+QhjHGNP15moclWzxPmj283bpfBx2vDYtUr7JJ8l4+RLr6qnRfU7ri/rKFw0GAn2PyfwGC0X3rCJoATJRKI5oEJKK5JLt5x3f+vdAtVZt3qjeMudRs+HmzkOEFXP1iYqrPAEcHOtgRpmP0jeRQ7YRvHVMgUknqryg1B0krxEjdJUux3ksGI06hHGzF2rGJd1ckpjnyjkcuWWh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:53.7365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6223189-3463-4069-dc2c-08dc541782f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Update DCN10 to use legacy fast update and ensure that the MPCC count is
the same as the pipe_count.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 81fa2ac781f9..563c5eec83ff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -569,6 +569,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_pplib_clock_request = true,
 		.disable_pplib_wm_range = true,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
+		.enable_legacy_fast_update = true,
 };
 
 static void dcn10_dpp_destroy(struct dpp **dpp)
@@ -1631,6 +1632,7 @@ static bool dcn10_resource_construct(
 	/* valid pipe num */
 	pool->base.pipe_count = j;
 	pool->base.timing_generator_count = j;
+	pool->base.mpcc_count = j;
 
 	/* within dml lib, it is hard code to 4. If ASIC pipe is fused,
 	 * the value may be changed
-- 
2.44.0

