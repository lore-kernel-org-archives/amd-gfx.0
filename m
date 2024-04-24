Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5967C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50043113968;
	Wed, 24 Apr 2024 08:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bxunM4E/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233EF113962
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDWVMn3x1BZEZh8VLcsBdEaupjLVE0DnWezkzDJuhop4j/1J82bgoxtvx4UlDRN3a5hVkGucYnqjUV2EmCXucc2EDxz9WH6qdaNCEWoOmuJqWxcLyIuoWoTgBrAinc5vpYHOmK90ifdLbhP4rZCcda3MqzADh52B4/rNoQ9Ancsyzjiyssau1ypsSGkaAwXzQDG8dh3GnkJnkpQCQgGBW35SIdUFq2DW9qDr5WJHVUn/PhHagn3e3GtwWWHnllm3QcnFY1MNxtg+Glosr3wqCFdG3DB/XXt4ydbb+8kUfDgQZh6ZloyICe54MiqownUPcc6431uWhFbwaXXAXO+Jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5IztlH7Laax3QCuxYkFaW1A4xP+CcT2oHVraTIsWis=;
 b=XorWVfclASU129T0M1KGdKQWEiDvpQdo3OFAsKWqCxXWGqW88NoG67WmIExr/RV/dWhyN5WMN9TdMNOfwe1jpu+wk9GYYe+o8H9/A+6Q0UCmTuHawkhuO5I1wzAmVBotkmfQx7T2xYZd2XyNXqHHoONELkHXy2L0V6dAQI8u8Q7pQXF5IAaCDMvob6UunIEa7gJyJf7KfeA91Y4jX41TjMYICDzUXfwgc0WxZ3TgaDlQ+rwFM1nVUYeAK8ju3ckBv6d6doS3EGlnajdDnUan260TnNBmHTb6NuPPua2mwfCBn3owAb2kWByOsp1TeYPE6RxqXDahDfIV+gH6SVSCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5IztlH7Laax3QCuxYkFaW1A4xP+CcT2oHVraTIsWis=;
 b=bxunM4E/r2ZIpaxzWcArOUQyZc/Y1J+H4HC7jQhJ7L2hf6sPDDMs9TFcJPfJiPL9Dev6gaRI9f5CVzzMYEwdAU8fhfX00IBy+f7Ba2K3i7QGsWUkwBPMgDSLuUSsf+AE7GqJsHFiGhbF37GvtSJQGBgqD2zBx2CJUBXyYxUk6Gs=
Received: from BN0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:408:ec::10)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:00 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::33) by BN0PR04CA0095.outlook.office365.com
 (2603:10b6:408:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:51:59 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 16/46] drm/amd/display: Enable legacy fast update for dcn301
Date: Wed, 24 Apr 2024 16:49:01 +0800
Message-ID: <20240424084931.2656128-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: b5235a76-2a7c-460a-4690-08dc643bcdf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?62oMgo8l0nwTgrgmLGaEyr6MthgQDYFNDYIU6Ooyo0eVIO5fFv3l1J6H+32x?=
 =?us-ascii?Q?lGRrBbWRqE2Egpo60hQn7A6hNpKWDHtKxXIyei7/o/vn40zvSzZuvzaK2tw6?=
 =?us-ascii?Q?q62Bpa1MlE5Ze2JWvNxqX7i4W+EhZ0Xmfp+2hZTMg3muhjY8OhkoaCFi0P9x?=
 =?us-ascii?Q?3Zf2LzWM87WJD8tTtN+NP5m8a/APrwTPPKZM1+WwNd6Pn26Gly2MetWnUTIM?=
 =?us-ascii?Q?wTyBuwub996a4cY6fs57Jlt72aLMvlUtYf8Koz2W41a8rPADIVbSaDx5g043?=
 =?us-ascii?Q?/yxMVsI5eSLyu4ghdNj0kmrXuWC+sz1uL2pI3pSLHI83NBmvYgJCyMin2J2R?=
 =?us-ascii?Q?IUTY9aEuW86Ics0OZnNRB/NPueym1Tsrnt8w3eFn5FQi6JwbgCG4+9IXJRZP?=
 =?us-ascii?Q?AJYDT5Oq9t/d5e51DNl5yj9M1ibmHRZcBN5eZeQxjkyJFsi6nNcY01kgh46d?=
 =?us-ascii?Q?Tw2cKt4J0gAQFd6zcAiig/LRNhZngdiaL5fKaDeF8kky2d2LJMsBxiUQSfR5?=
 =?us-ascii?Q?a4BT9KytSjY4FP6T/K2/PUIeh5/Gdb2E5PZrK3PRVDCZ41x6EqYTFpccd2eC?=
 =?us-ascii?Q?G/yGn4NEldHBdrizf66ay+Td90eetciTPERlylq9nylygZCHaBHwdQK8S/8A?=
 =?us-ascii?Q?mOLknzH+qEpoWQ2JTPa6WoWc0H6SsIVcvLM4+urnfYFM4fDuTrwPu9M6drB3?=
 =?us-ascii?Q?bAH0/hh10Otgo6ZgC8c8395otV7Dfi8txnUlSo1oRyy1q73i0JnHC6VY9dsp?=
 =?us-ascii?Q?rkUmIFA/RjLk8oWsYXSxUNmZWCWXLMb9MGctxK4wFuEGPC3XuWyrabi1glaR?=
 =?us-ascii?Q?/D70MHFFbbQ4B4Cqwr5eYWPGeINEzxm5aja0IhYCYENK/BX4hoWJTdpHHqBW?=
 =?us-ascii?Q?cVIBBibQCY56FL8YpEzDCWXa8p7nuZbhy2FJ2sVkJUTTDUxXVbSZtlTpMYdz?=
 =?us-ascii?Q?k6Pjfkugrbmvgh4BYMH9Zb0Ro2tAO9aAuYg9iC9/wJJVJMExOfhoDdEFKjM4?=
 =?us-ascii?Q?19JhbzGXM/MgO33p/uOFhhO+54oh/awGvaNyxfTr77ld6cUdiEEoeaezzwC2?=
 =?us-ascii?Q?eIwVrfFrQyRe4UutcQHJerw7GbLH5A1ZGhiA8MdUTURg3leQV3NtoTTz0tze?=
 =?us-ascii?Q?PfvohvURzpVryxyJ4jBuL5ORN/bzCDPUC9fxJANIdR477y17NVQiP9WT+kcq?=
 =?us-ascii?Q?HA2kqVH9sfZ87SGaSTyJv7vA8/UjVn8f76sUwWipedghpHBYLd1BlPzwWQhE?=
 =?us-ascii?Q?1rYnjOH/S/XFygMjycvG7b6NyfTwprqL3PtPImh/HxeU6Zhp3x6Vt664toLP?=
 =?us-ascii?Q?akZQRVXsVseAQqDdZfzopeNfoDLAZebKjkq+oJMILHXMjjwNgsKp402616E7?=
 =?us-ascii?Q?HZO3xOBGV4whbIjsG51T9n2gehoz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:00.0576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5235a76-2a7c-460a-4690-08dc643bcdf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

Set up to enable legacy fast update.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 346cec70de96..7d04739c3ba1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -702,6 +702,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dmub_command_table = true,
 	.use_max_lb = false,
 	.exit_idle_opt_for_cursor_updates = true,
+	.enable_legacy_fast_update = true,
 	.using_dml2 = false,
 };
 
-- 
2.37.3

