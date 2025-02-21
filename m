Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94392C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41AC910EAEB;
	Fri, 21 Feb 2025 16:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uut0MxoZ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5C910EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvGNNPxls+9ueTm2pyHEuY38i+G1H5fQBDijr1uLr4H/+y0JXguC5SjXiZUbrPky/1dXHaqyeOtp8XZAz0cVG3kQKABWizdtoBawcd71Pjb2q+xcDC/IgCcEDhWRETmMVixzC8zlvavhtjhMhIXqL5WjpGukX84uaeYsaDGuZeRwZaLLOK3PauMZzuYMxf1yIj8HQbxylJ2+ddGVqNUmexA9OQuKqXIgncpOZcUPDTXEz4a7mvZFic7gP8frXiKGGEn2Yjqv+Qq9f+kLMrQDRqq8DDqxZamF/fvFdjXthfIiNDCkQ/pk+DVqV5o8XsTgpJmZ8RZ62PtM9GHIHVIqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh0JUN+OM2YhIT6Pr7Hybji1Rtpn5uGSWWjZctFibWY=;
 b=tWjJLbPoFv/Aa25cAATCQjpIbiHKS+bNFXLQ/j7xMDBijRP4+3rvWhMrlIYQrPdFQIWYe3LnVn2OUTRq+iQgjUcbFk8IHfb89KyQ2h8dmEuOipvyCt+k6xo8SOLzssd2z8541nIZpIGD7bq9AXbOD2VwFwt96PC91Gih9QvUBBNkf+J3DyLhwq6jgAW/2kY/g2PREMSgN3o/tvyKoXmmH8TT3aeOO+X4knUwpWJJlO0B+Lx1vMEy7CEoSEjfqDKQbdXWSaDHi8BaPJ2pBub4/Xrj/9i83QjIiDvQ4b93kFVh4ZhKQTd4K+7URgi9i7e4aChYaQxgph7RaFXGcVYJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh0JUN+OM2YhIT6Pr7Hybji1Rtpn5uGSWWjZctFibWY=;
 b=uut0MxoZ4dY9y3xOo+OoJcYh3XgYy2xKpQLoFxAlzr0JNxKHQg08Ab0d2L7NFadZLpYfu1XmpeLNlmSHXwGg9epmfV/T2RNG2cp79/NUU3mpKGAnCxdWmgIqTXsr5l882QqXqQBZBwXfErUw0pUOhSCON2G5eWYnu3teyLOHZnY=
Received: from PH7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::35)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:35 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::5c) by PH7P220CA0036.outlook.office365.com
 (2603:10b6:510:32b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:34 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:26 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Samson Tam
 <samson.tam@amd.com>
Subject: [PATCH 19/24] drm/amd/display: Remove unused header
Date: Fri, 21 Feb 2025 11:01:40 -0500
Message-ID: <20250221160145.1730752-20-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efc3ac0-e29e-4710-004c-08dd529127c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FMWe1WJqFITtt1rBwMdlnJ0xWxQE0cOhBzRxedWFYOGBc7+2BmIW1tv4Hmqx?=
 =?us-ascii?Q?jyysRHkytvT7b5Q42oEdp0fYR0rWawJjNuZ9Mi2rLlmae2q+CEkdo7X9Q2Dr?=
 =?us-ascii?Q?vED+IwWeLeFjEPUnhaPheAp6PbISz8+d/TfH+pYweQxzkwplLV6xYS3gNWBe?=
 =?us-ascii?Q?6Nm6SfO1hVEVi/Tmvb2kIybUTnTJBblzkjA5e20uJFn8tvLsi0N1Cdp3UVhn?=
 =?us-ascii?Q?IRrfKWJ0VMf2tFhHyIKt5LXVqgycSv1bQ+8bgyWIkwrqEQSIZfvb1oPKyp1K?=
 =?us-ascii?Q?7Ti0rqhlISVOQUkGH4ZAcrdU0pQdU8lUzSfgpcghm+aA2KRd0PCHpFsUSEFp?=
 =?us-ascii?Q?3NXQeeWZU3SCGcm+ke+Qu04DmwBamKZP8lepg9kkAV2DvB9hQxkyJljc+0rQ?=
 =?us-ascii?Q?L9lNPZvPhNOaaUrbhlQe2gAGbPQoeasDz1rmwhj5xfLEdyb991IrrJfgY1XX?=
 =?us-ascii?Q?45y0+L5FAeoUi613P8Q7MGj3uV1coP400DOh0Kle/U5SG1faSSPKDHRap2n5?=
 =?us-ascii?Q?6XyWUwNyQfCPL0SUpLzhC4hVJOqxhSl9UrRU5KByAB7bQ1JzhOHdwkwWh6N3?=
 =?us-ascii?Q?CgueQ+tZLfthrnvgzisYCbyRce4LsBr7cxY+u7vHuwVulfjjz0eTWT/4Pi+E?=
 =?us-ascii?Q?op7QYr7EGEqq0B938PJE0iwByVgnv5UhAvq5LSjPxZRiKYKRDFgLFgarczX5?=
 =?us-ascii?Q?FNqu4JQXkRHpDX012tITQc9cAgWQt8rPho8oDHf8XSzfumZXkWr1thd2MOhe?=
 =?us-ascii?Q?B9/4O32j4uQWeCaKZCBcCXV+WreVlJ9TXt/BJ5r1+o8mIU2sYjpcubSShjZM?=
 =?us-ascii?Q?Q6xCTYKezXMPODulxbAizWaLhkmO2AdPJ8RXsMLtmV0/7HUJD7JKB6c83emT?=
 =?us-ascii?Q?Mylk8rGJHikA7UUALBDUHgnuhkSrxk7Q8idMFnSrhBvg0HO2ZcHqFKY2hxNV?=
 =?us-ascii?Q?K7Z6X3ktrz5YjqqzTYMWqlh7x6JhHnEZ+IrxMXwoiU/qa/HsGm1bUUbGJjXs?=
 =?us-ascii?Q?ka+7FX2v9eIbVPf05ti6PzwgQFhhKHiPL2hyPrKOVFpZJ30O+DKcoYCZfhq0?=
 =?us-ascii?Q?JZ8FFPBpFH238rM/5MDD4bdtDuv73SKkfg/ZNv7MAYewSrg+ssHfHCnOSVhp?=
 =?us-ascii?Q?jsv7tCEmhFCvOJlcf7I5QP0jLKj7aLV+HDof8NkDr32BBPFxlHa1n1z51sE5?=
 =?us-ascii?Q?rGlVXoBKr/ygmJrHW94wWoJguzLMJM5bIz5peO7f0z+Xepc6ONjludUTR7p3?=
 =?us-ascii?Q?Afh4P7zmIRke/FTrmQoljWEeHrw0hJILPj76MVpg+fNDozKx+nIhifRfYZWl?=
 =?us-ascii?Q?7eXNBkcXt+zoI3VrTvvRyuioK/FSG3bnfidD5hZ3nmJh1oqncq/65rGGptZv?=
 =?us-ascii?Q?XoGxSjjBXzdC4Z35lw6uYYA3b7pnFWaX63tAn9Up9XDdaXSPr2bu1m3SpWIK?=
 =?us-ascii?Q?d1OPWxNWoLNTedp/XEMf8WNqWWQExaSmanEupKuNOAmDkwWnkZdjo0jBHkNU?=
 =?us-ascii?Q?FBvysrjoowALOGk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:34.5676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efc3ac0-e29e-4710-004c-08dd529127c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810
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

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

[Why]
Removes unused header

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 8d80bce0738a..28348734d900 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -3,7 +3,6 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dc_spl.h"
-#include "dc_spl_scl_filters.h"
 #include "dc_spl_scl_easf_filters.h"
 #include "dc_spl_isharp_filters.h"
 #include "spl_debug.h"
-- 
2.34.1

