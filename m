Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3BDC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 03:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC83010FB00;
	Wed, 24 Apr 2024 03:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RpwnSiW0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5097E10FB00
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 03:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4ifJboakcXPf+mxNVeIn0yyw4AKu9+9bYf/l+DviUMURnyR8NqqlOU+jX2aTq851yNmYkYAqX72oIi1QZoqFe4nP+0rROn3rqUHEGSJsfwkxZBzsndpjFUojIwOYSXc7HReiLXt8UInr0Lrak8H8U8M7l2Y1uPrN4AebjJdjfHojonzZ7NCcKLRUJBIXB/bPGD+xYsQhvTePLsaRtvmVjwJYZypt6iuIlt2FRXL830zoOpdp4sIrsId4JPDtnd9hravIeXZEs4aUfd570OGinARMWuuLlrLxhNl0gecIwDCkUXNrQIs/1SCs41qBXnp0iqWZnr46h2Sopf4EHxFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgY7wZlhIb0wHzm6rTtYBUISJ2WBbX4tXQWyrna2V5c=;
 b=OQzYucZSjZMg9njNZxsI3Ddq0/AVwWKi1eE0oSyISfFTVWsnzpto1wfSa3s8KWVO+qrrRUE3n8KwemFPtiOVGCxP8gqxTQIBc0TT8a1JVMM98hVrrpMuEvLP8Iek2PZyOwuH+ZQpTwL0etrhYM05y/wjst6zEmhGZcYUPzxpUSncWEpkfgXAsigtEB2gjj+u5FLD20B7AM+e/2kYR+77Q1+vyPuxpTWADb3ORhUfK9h++1JEaOwRN5nqgq8KcstGsTiuFvgK6CGgQNV3MnLEVi3Li1NVm4EWtfYXlwLxG5A7VgiDd1tzXu0X+cGUXQKzPZvSj+4G0pT9xeU9vJ3ExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgY7wZlhIb0wHzm6rTtYBUISJ2WBbX4tXQWyrna2V5c=;
 b=RpwnSiW0FXZC3xD7h2J3SRycfhuM+oI5KNVJmZ/y8bm0vL33fXdu6cEMDEQzzfeZuPXFTfuL12Y3u6qyQhTPocVOS3VGXlCSsw8jCnIqqpQOZO33++/bqGkG45opC2VwSflzV80UEpD3JeSBi7eBeG7jFFO1IpMBOMIT92qftzo=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 03:45:41 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e4) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 03:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 03:45:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 22:45:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 22:45:39 -0500
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 22:45:29 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <jingwen.chen2@amd.com>, <jonathan.kim@amd.com>, <lincao12@amd.com>
Subject: [PATCH] drm/amdkfd: Check debug trap enable before write dbg_ev_file
Date: Wed, 24 Apr 2024 11:45:20 +0800
Message-ID: <20240424034520.266634-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: efded7b3-2398-4ed8-d827-08dc64110347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4AhPbe4jEnsTr07eoU+Xj0t14CB+WP5KM4MWbvVjdmUJbmhHbZAE2edvc+sk?=
 =?us-ascii?Q?WFNm7JJaHmM52fM5kp8bTyeOA37ns5vmFKwBnmvHZMzwF0E9H2ihpor4OZHf?=
 =?us-ascii?Q?Zf+B/VZHUsUAmtIuRXV0tqGlbq4PZc+cTtP+7r0pXFLLNW1Sq3YLIK4A8a8y?=
 =?us-ascii?Q?wnpzEx9r4652I7VQvg/w+rymOIdFUggjg1z4fIsodPeSwZiT3+kuxFgNd5Yx?=
 =?us-ascii?Q?THsOxahuTm0JuOs4zYxxlrplwXudMOP5pjKjCy+LWTqE83yR7D8gc7UVDCMg?=
 =?us-ascii?Q?Nn976zqDgKvMW8dcu7jDEiqdlECYbAV8ClMqOTXN740Yp9kSq3/r/QM4EoUY?=
 =?us-ascii?Q?pIFL8jtncEq5vZaTBc48AC15haaOVv58WpErmkhubiy40gaqHQXOrCJ0iU2G?=
 =?us-ascii?Q?za7bgBCCvc8eFRbJ0A5Uc5ziNTilvW1ASYsbcJMWJqLAduerA7m/jBb4g9+S?=
 =?us-ascii?Q?3yeekKMtVZ5h1tSqaMce7iwDz/VtQE/CWP6mQSg7940b7lp7qPeiVe9hqwsi?=
 =?us-ascii?Q?4SI5UPqyY4JHtdSlR6Zaf7/ppvFbxwmfL98+fbUtrViGpTnJhdJHC7dekhW/?=
 =?us-ascii?Q?ITD2KxsxI86TBKkcEqSeQxVLnmtGtGk8pgopEq8JK70Y4zE4DYZRErtGmVV6?=
 =?us-ascii?Q?8KL1BhEpxFQsHl1nN3Cfn63xbh8srCv2DOU21rtrPXWhw630ZOTxfE+2xitA?=
 =?us-ascii?Q?RZOqsFfPgyBVrkGHuPW7lOVA9mf1+s3x+T/Gaty8qzNaI3lBk9ABHN8qlY3q?=
 =?us-ascii?Q?595cUGhzLlhV4staOaiheRpJ/z431hdSGmwYIW6FrVuS5oBg0i0ZWxkN3Loz?=
 =?us-ascii?Q?b2U5p8xn7EKY75hSd09ITbzgFIhL7d6gGtSUrwUwkwMfSnYoiHdqDODvnTPp?=
 =?us-ascii?Q?HY3TqctQEPuSx8gDE+0SYNj5Vp9yN3CyMgw+D8rGSylSsjU7uEQxDbkJSoZV?=
 =?us-ascii?Q?4VYUAiRMdRa3btVLhh6CKNYnbf7gJEP+5qCkL7curuMIj8lhBCAsChpblh+I?=
 =?us-ascii?Q?QVkIxsexGiAOJUx5vi+zsgIio9W6nras2Iyw05B9zLr+cADYy5WckrOaa9fB?=
 =?us-ascii?Q?q4GkBhl4ttxb0X3ABPZcQnvPJNADdagB04pmTq//2RVIzKC1yLZyqTDNY93r?=
 =?us-ascii?Q?Vfmm44aflYfBPxJecXyRMUv8q/QARqLi1ECWhVIrR29sQUltqnhUIzSPj2bF?=
 =?us-ascii?Q?0qYhjqGnjEz5nI5Y1XMO1qOGdgiDqfblr8hsKRw8vsGobNiF2ERY2hHyWw9t?=
 =?us-ascii?Q?QBEcLWbDTJmj02oSjtAEiHmzbLk9DPsHWksHWRRRz5G8kjcjoCIRcOTFHGVU?=
 =?us-ascii?Q?RWXu3oeXH9OjyuX5NVjYXPTWw6fEN1yHH47f2OUG1dav6HAkH7IAinO+fyh8?=
 =?us-ascii?Q?bNZVRJivC2Tou9XuU6uOf6Wbd0ID?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 03:45:41.0779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efded7b3-2398-4ed8-d827-08dc64110347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

In interrupt context, write dbg_ev_file will be run by work queue. It
will cause write dbg_ev_file execution after debug_trap_disable, which
will cause NULL pointer access.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index d889e3545120..55ce50ba4be2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -103,7 +103,8 @@ void debug_event_write_work_handler(struct work_struct *work)
 			struct kfd_process,
 			debug_event_workarea);
 
-	kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
+	if (process->debug_trap_enabled && process->dbg_ev_file)
+		kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
 }
 
 /* update process/device/queue exception status, write to descriptor
-- 
2.25.1

