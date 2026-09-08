Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C810C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5B7A10EB46;
	Tue,  8 Sep 2026 11:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TALXxd7U";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3E510EB44
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVNzW+zZgx9+6uVEu7Q2dNyNtFVjl4KMSdFu2+mSComA7QOPePBmHBL/Xw5Wp1u2/q52B6SudoNCPZF4z1RIerBS20ZoXYy7XtHunu/b8FMpwjkNN17BgUYgbA/QoWrtJqhV1DA+lLusXmGw8CRdic3QC9zaaI87R2tQr856bVAxWvzsAM0BJFmEUbFGM+ngAGSYKMvpwMEuIg8Rtgp21fvNwv19Kw8w1scvS9VWUZFDdGGroiyxKpN4h8eyr1w5bwl5L6J5J8y/m0FFAaI2xV5GP/m6Ul7O07Ho1iKksP4u1gHY51kzoYi4Ycgsk+Xkxin/KMBIScbITWoJc8i0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95AWjnMKsNElchKrGCRAv55gIcBQk6giD8VSEtfy3qo=;
 b=B95a/Hv2FvRx5hJTMkG44xZAPRVpB3Kd43dKzUpNhhG0jQp1rukz1QxOxfL7vWTQq1sN6PFJgiuuRHqTzBCKlWalQ6XYgyJx747eXYBD1kHl2FIa/nPrPh7Uf1xfhTPeUeNzJQoxGUEAWHelFnM24UQaJuxOb8wBvsY0cTtjCWuR+vVyU0OthyS9R2qktP/yyV41meokXyM9pHNx1u7DQLwBmEqrG3ie/gaUrM8VoS5BjranpRcariDrnYHnnA2xIJKfF/zTGWsobKJllq9Zt+7tzwWIWzEHoiQBbZtEinh1UnzxF9hO5MQOTxS9XylZQS6xYBbicdO8ElKoSdfQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95AWjnMKsNElchKrGCRAv55gIcBQk6giD8VSEtfy3qo=;
 b=TALXxd7UZAcTxXgd5v4qkOzVz2W6pogxuBrSzizz3+g+QF0C59MRt/F8KNU6RHIHAYn6Y2fI33KRFIphPB3Q/G1c14YyqFRmkyqFedZmKX1qWU31DUmYsvA4fqnX0v0zwN+zDaAa3ViAhyPob7pRhQoUtvt46YC0z1c3X/4Zb+I=
Received: from BL1PR13CA0439.namprd13.prod.outlook.com (2603:10b6:208:2c3::24)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:36:27 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:208:2c3::4) by BL1PR13CA0439.outlook.office365.com
 (2603:10b6:208:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:36:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:26 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:36:18 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Yi-Ling Chen <yi-lchen@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 18/66] drm/amd/display: Add option for certain panels to
 disable FEC
Date: Tue, 8 Sep 2026 19:31:11 +0800
Message-ID: <20260908113338.2433445-19-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0127b045-ee98-45f6-7413-08df0d9d6b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u6r8Q01NDUNAns7Ptn87ucsJ9pNQQpCG6E/G6Oca67zYcEWQQCJcDs9f8CIcJumdcKDIZF9dqv0qllSYeZ5l5MJh16U116a179A9LAoFRagpjQdxHg3kzJz2ofcEWUwKbJTND99idqdOomRBcgnbTuHN+3RkkDNfM1mppDjndH9MPfowANsRoo7lIPxjcZZgt4DfuFUQdPAfDp0OG0k83GEG4dJ0zxBw6Rn6WTas89XLKmoB9jCZNEmOxi0gFT+cnEXr6n1Ac9/HEeggdUR33wakuLYO7QYuAoYrMvklgCxvgQl1ZWjy0MKLe/dN/eQxPpm8RbQuFD9dNQU5s4tthsKnX8dwcI8sCxaawHGk390OXA9EUSsfqoDFl4716b78f6CwvuV3OeCHUDB02Xa7Jo9ShUPVS+DmlNmScA0GfWamMjKp0W+dIITmNSBHqmCLrh3/GW0UUqnVoR5u23uvFjN7YS1gbSpFmPjL12O65fzuBk95DoWy4TNu4jiWfYLS6MxDxB0Ix9YEajWlziJ4Brr4mYGLyWkOWozq/KfB1XawUf/egiary1YbGnPay1XmLHJOHaZb+joatszO7rburoBvYLtplBCPjedi+hoA8aIX3xBGSYh6gES72N/i7hgnAtLy1berr+mVmbeLyOq4NA6d2FZSEjlF7LtmbV4wkssy51lrRMLdrbPS0t8LwaNDtSAlEMg8gq2BKiC15fwfmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y6cdU7lx1lcOPPOTHrpaJvkaLdJvOtnnXRUqwDhaQ/qLl2/b/DG+sUAWfZ6reM7MoDOoXwdByHkb6dxcyiA8rup0ZfVLREI/3lnoEeJPC88mGJSVyXN/18VJrOUAtZZoSYm8NJl+wINgep4TAqXt7WonLHjGSv1hASDx2ugVaOyhbRiMYnlpsaN+slJInjcTNXCxxhyr9caQuzpl38J+NE3b+Sgcxk5Q+2Gm0OCDJ0bn4mmM2Nf0bMmyC8s6lI9MRsjret3ouh4w0ATVD/nJmUOpcVM3B6IQIZRQ+8KsKEx/Zc9hGbMxyOinkiwiLnPK46iXqxxitH/B/RwnPzRlEh3/nnz7Hbd5maj/h/RXuEJVQzkWseAsVpoYKXJHv309XaCdupzL2KhzT4dhcnmxhfXZsoIxA6zPDAaKo1OBMvZBtaoOQB4fzn6iiekupmLK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:36:27.3332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0127b045-ee98-45f6-7413-08df0d9d6b74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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

From: Yi-Ling Chen <yi-lchen@amd.com>

[Why]
Disable FEC for certain panels.

[How]
To align FEC HW/SW status when enabling the option.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Yi-Ling Chen <yi-lchen@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8e8d221c2bc5..ab192291ed52 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1870,6 +1870,12 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
+	if (sink->edid_caps.panel_patch.disable_fec &&
+		(link->fec_state == dc_link_fec_enabled)) {
+		DC_LOG_DEBUG("boot timing validation failed due to FEC WA & FEC HW is active\n");
+		return false;
+	}
+
 	/* Check for enabled DIG to identify enabled display */
 	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 		DC_LOG_DEBUG("boot timing validation failed due to disabled DIG\n");
-- 
2.43.0

