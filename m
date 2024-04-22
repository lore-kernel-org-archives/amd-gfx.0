Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89764C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93EC112C0B;
	Mon, 22 Apr 2024 15:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hn/LHPcM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E592A112C0B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBTvH2KT6EpdKa2UgzV4HfTehds0pbB+V8D8jZq2W5iTX5aEFi1MdglcQX1J/Zc9WIF01AfjKJmYE6OWyZyJvLQcKBoosQkjDT9BXj4cwrdMsOlZQaYor0ConolTcTFxDbo1GV9kTgogn/KUkDJRHSbI4BonxkAGbql/WGiliCrrl4Gfxgh0YNXbRTZOvO71Kp4MTCi3pu6kKiV/usEmQfGQpLNLEKppltmO21ZZhJljJvQ/fSiwwC3F0os/n9zAQoGZsitvyq4IKmQEzTXoj7f8F5PBNpAjldO+j1GBMmED1nx/fln2osWQOLEQela5gZxNUmbRE5qoLEix/Yz+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY91NEAbDUH1bAw5Fj78VtNIEPFpyjUEJHm+jQMrrmI=;
 b=jzEtYR+7D8DkII49iwgV76pkdHkwm8KnG6Y7Mz2j07lqt75yi+XkddO3bqk1vufHhB3icDy3NKRj1wNtSuGsqR5wwN8UaCK+kSyvLguuFoNsHVEqq6rw02sbssCVWRk+cWnqeFF1yDutob3KKn0b7SEGxjFufWAScSnZpXXIAB+FCIQ2x/l4XqtATl8utoOmQqTQyz9H6rvhX99tSaiGVYh9CUqzRGN0Icmu2l9UXMVSI/q6lOn+OvDTI9kWhhj+SOyu8MpHk/aA11N0MXBXAHqanC/9EUz4MW/zGI0QtVLQFSYCv+K8R0NcxvgKxVJrNBvEQQ8AKunl/9qzCiN4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY91NEAbDUH1bAw5Fj78VtNIEPFpyjUEJHm+jQMrrmI=;
 b=Hn/LHPcMAjx4s6j91vAtHmDEzrhcWb5NzqOJloNqCfSmGaPcaVXU40WcTjdesoaKgYrRCaoYEHdwD+MO2BAQvIF7MgLSDN7cC6DRaZY9VabUY0xfj8mKsIuOdLCWE5fJjKt8vVbM63xz4jXkzgteFE03E5ZBFJeJHyyl1b6weMs=
Received: from CH5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:1f1::25)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:32:05 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::6a) by CH5PR03CA0007.outlook.office365.com
 (2603:10b6:610:1f1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:32:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:32:05 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:31:59 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 37/37] drm/amd/display: 3.2.282
Date: Mon, 22 Apr 2024 11:27:46 -0400
Message-ID: <20240422152817.2765349-38-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b6bf27-4e99-4c1b-bfcf-08dc62e15d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q0KG9fTw6kEBiSDCZpJipVxZ2e3QgyG7Wz23+vK2y09sWKeqB5m+F75j1oPO?=
 =?us-ascii?Q?bvP+m+pJltV7K6i688h3IaURzhRLwmhXdOOVQAwI8Ai+5zQSD8cqvsXUnspz?=
 =?us-ascii?Q?zkgjikZ9WYyfRhxhFDhocJW1SapyU+z3nILOxTPYwIOow0z1yfLTBi0uQ5sz?=
 =?us-ascii?Q?KSGDcEUdC1SXhagy3JZELfEdVgBiI6vIOWCdXHU6vYi5C3NYTyLqM80N+9TZ?=
 =?us-ascii?Q?3R9lFN45iUyeciitlT95kKzqVLPlwvCoNOXAF6Rkt00+x1Eq08XKcqq+gzTE?=
 =?us-ascii?Q?Ay2WqeOjvfZSRU093vLndt5FPkA5Eab48XpOzUXmQSvw4iE/p0TYvCgDt6aS?=
 =?us-ascii?Q?6kp/2Ly3cLwtJCML7NQFJB6/wbHbaa0K7X88+O3FqoWVkj+GEeEb3Q5uSwvk?=
 =?us-ascii?Q?2vIFy3OhImfe6EheS2jl+cC65lLL8tLCSbp1wLHSdirtmJMJ/X9EtGdfQ78+?=
 =?us-ascii?Q?9NGO+TKzq1gfYT1J/zTUZq4jbdRZbxSqQWJ5m/UzRDHmCVaxPNjIyKOlVw3M?=
 =?us-ascii?Q?0+WVVUUi+jNO9NBl+prJarRh+fCzUPBKfS49XqXr/Zj1u6X9ooa+j59nCoS1?=
 =?us-ascii?Q?11JE3s2eEihgpxUS2uHpEYA6lnvzYBxZ0S6KUC+rjCbJaLXYv4dFDcAkqByR?=
 =?us-ascii?Q?CIw51B6jT/KYbLGyiha96qW8BCeeUWfPLIOHDp1UWH6MT7EThZCaBtLUtNjW?=
 =?us-ascii?Q?vk89Ur4HNQbzu7ZWCZiVhdhSqeDyLfsd6DQ7L60MdTON7gMNRQ4f86W0A17q?=
 =?us-ascii?Q?05GqT1UwRUb/MMEHsY1VnqKSLCsyyx6hmXOWX9sBLwzC5aPK3QhEKXL9waSK?=
 =?us-ascii?Q?L7PJk90Fsm3xf8L+kAEIp0ZSi9x/pFOrjD/cCQCMOLmApYKIoQXmHYNiWU71?=
 =?us-ascii?Q?sHUMRxGMBw8DCKnQZGPbORssCZ4pZSCqnfHFJjyBHfLHsqv6oTt/XInuv7QM?=
 =?us-ascii?Q?kZgrkh64jyJVypGtkKo9qJTz+z09y1GI/x+GF6rkFz6F/q3aiFNvSANV/G+E?=
 =?us-ascii?Q?f9UFyhNGo7DJSoQvGvCx12UcvSGhkDMv64eIM5YMop0fCwBT6it0NcgSBr6d?=
 =?us-ascii?Q?be+DSBHlpJks6PW8Cj3DnPJwRpET8LSphZCJP8ur9UfROFqgufsfck5tPlZP?=
 =?us-ascii?Q?PHFsJiTQIjYhsA8+PSbex/urhkCyxYWJYnBQk4EENIhjVkTH/d9XUHWB3FIk?=
 =?us-ascii?Q?MmBOPQjI8o0V9ejMeKypvv/eWyKP2gWdYf+WKd/QRQj7xQ3STISRDdT7ixUe?=
 =?us-ascii?Q?Zxw90Ot+x1rMlBZ6KKX2q8xpooJwY0KtrvPbxq0fOCdnb8nYVO5ftuoNRa+6?=
 =?us-ascii?Q?fMs5/p7bSDYwDd9wiCQP7bfqIQ5o8ieZoKXVLR/tmdCIUIqGTrUM5k4b4ZAb?=
 =?us-ascii?Q?Bx5p1Tk515OtaJsppf/j26BSmhn9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:32:05.4959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b6bf27-4e99-4c1b-bfcf-08dc62e15d7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
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

From: Aric Cyr <aric.cyr@amd.com>

Summary:

* Changes across DSC, MST, DMCUB, Panel Replay and misc fixes.
* Fixes to cursor programming sequence
* Add some missing register defs
* Formatting/Sytle fixes

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1e28a36a76e6..a3ebe4f00779 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.281"
+#define DC_VER "3.2.282"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.44.0

