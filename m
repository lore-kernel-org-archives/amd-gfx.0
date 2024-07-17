Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B062C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3950D89266;
	Wed, 17 Jul 2024 19:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3PSx3izj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E4910E3A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hdtp3CnTHvzRCykiT4+aejGZ+9TLy90Tdem1uuv0WUG4pwAqOSPTOFMzonyD7yKgATbLM4b6NZlilpTUaQ/dgB5x9SDvfyc6UwvJIAVhT2ztUdYOsE4umCfmUW48WicwWDM/M5+bWZpuibTIjcEt65CrO5cv1aCyIFyYXdECCO4y2rEMuJbucsvZCJU6dkUWemYzjrYeN7Ra2q9ZX49F9HZ3Nn65z5v/JmYZfO1vPtdjMrG5MZOu/Xhk1yJrmLP9Hi8fw0zqimkccgIHEkQ0pxwh48Azv62LZSOc9RhZ5OsjSicN2cdb8YH9LcxwbxgjSmcCzsrIAfNvSHcAG2CQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azHJFlt/t5Ii9QfCMq5ppWUzeU6Vtn9UawNq1gvg/pA=;
 b=F7JLlAR0ixRPPqDwZcGQhGD99n5lPhCbzzIvc5NZ4hVxKz6UpmEhmo5pJKMDLcEKAXGZZ2NhBMG0Fls6M+1uaZjTzQfq4yXqzMJYTA8l5Mcx/FaCLFP9L6qUEPg4GS7QxnhdrskEaxxkN+g3OV6iZrxrgmW1+BBFK6mvY2/55ZPf7vkjrtU6yaCNwQFsI85Ccus3PLsWzLuqdyDHU+SUI3o/i4A/3+OswAqcHhV41b4YkRYat9GRT6P8Fs3jkhiLqnLrJ0c28K66uur/EO4oF8DRVCxUPsQsITHx+MjusMAGExgB71/gXWf7UJd3VcxM8AuHO7iTkKb1M938on2lHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azHJFlt/t5Ii9QfCMq5ppWUzeU6Vtn9UawNq1gvg/pA=;
 b=3PSx3izjDLXGiY/oDzQJnah78CBKRLYpF7F3W4YDxgtwGFeNICDT8QfLIUJID3u+E+q1tDEhNCzHaoRpxbWhLhS/mkbQEtUPrrl2ksdlI+stub1OCjbvY36tYQrsQcd4qtfjPSeO0VolzZuzF4x87Jnz4mL+40Oaqj3UJU54wfU=
Received: from CH0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:610:11a::13)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 19:40:06 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::8e) by CH0PR03CA0351.outlook.office365.com
 (2603:10b6:610:11a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 19:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:40:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:05 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:59 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>
Subject: [PATCH 09/22] drm/amd/display: Check if Mode is Supported Before
 Returning Result
Date: Wed, 17 Jul 2024 19:38:48 +0000
Message-ID: <20240717193901.8821-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: fd667365-c140-469f-4cd8-08dca6984293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HnPNRn6AwcKNhGpQX1+J1WbdXz7hrC6iaWYD3N17IeVKnU8P3x99dX2owjp8?=
 =?us-ascii?Q?ymd/cRzaAacVJPYZ4wijWl3+RucZuGJ4kh4BSsfGEFd0QA7m+4mmshpUFgxt?=
 =?us-ascii?Q?QEBwOLf1X5Q0WCmvQWkarafX1DQ+RmFDZqSFawyJY6DFtouCYXTTmteebQ+R?=
 =?us-ascii?Q?qZxMOt2NLmRGYxFdFKN91nfiiMLR9wZLY1anG1j7LIvhw2nnCUrxex6Lww2w?=
 =?us-ascii?Q?CaWEIKQZomfXSqDYfylVFXrKRpnRC8/LNLXqMyBOiOaoZHxYhpaeXyiSv1h1?=
 =?us-ascii?Q?QaVlQ4CF5hMNSr43l2EBNpPqscuehjSrbKZuFSiVDSeIBQ+IMI66WAPHOqcV?=
 =?us-ascii?Q?b5qIelWzWm0iWyYs1AkRcG0UvhnBzPbY6iI2PJHB6IF00AO35mUO6qT7uK50?=
 =?us-ascii?Q?wt4Jd0ycH8+pOyCSYFa7V3+z3JBJReuht/cPK2i3VLjBr+D1pw9S/ejaxWT3?=
 =?us-ascii?Q?AS7KnGvK0+GJl60xnc3bEpK+PHwriCq12nWypZ1QUbYLEMJ1d7txqblNI6mv?=
 =?us-ascii?Q?8QXaVWT85+RmdVTKL4ji9ZvKnLTqZNaBqxzdE4FW1lAjH+3Bf0ZUx0d2pYbw?=
 =?us-ascii?Q?9GxAFp6gVN0gIRPad2FlGR+A51XRVTsBzPy3P5ljlJyhqPyPZZpsXU8DqRqf?=
 =?us-ascii?Q?cFnxC1zoY3AlEtLBBVQtxJCeMyUszuT64bhokxiL23wHY/fYI0gLr09OK7kP?=
 =?us-ascii?Q?ysHksgVo229VyYk4dAvGRPTJSspPPonMjVCnximHRZ/IjdI2QxbdIg9I8DFz?=
 =?us-ascii?Q?XmwJwMVoOD8rN1dhD+WYwUDm8HldqrRzDbX9Adu0qNrFSmBTp+0JPQCHn8dh?=
 =?us-ascii?Q?i3hazCfTPAaaPjo0PhgCjGtna5cUWMydyc3x1GWxwaX4oMPVwdwy1zeI/xe6?=
 =?us-ascii?Q?0jSWl+4JWDaVU732HnsSAlA1e3XxMYp+X8XFjSlmVsh75W59mN8x0SSHbvkM?=
 =?us-ascii?Q?H7ht9hrMLDlIEMG6Vz5nx6SPsTuV2QUVkKYTRKihzYdbXHFztDhgymM/jB4K?=
 =?us-ascii?Q?FyaT66MTr8xbSZiap7gf9jF21ERhBIjbtP5LSzxKJ0TPNDIaOTIaUV723gL1?=
 =?us-ascii?Q?g3pFlDYXvXWo8X17W179Kyzv/weIOC+wU7t3PDIPTlH23bKqpDUAFgYRq2D9?=
 =?us-ascii?Q?9GEj7VEFJQDRHNCo4fx/yfGpukxTMy3c8Bl/Ili0uWZaUXYZrScTsUwwblw1?=
 =?us-ascii?Q?LiYxQJ4F8yTuT5JBRpkf00DH8PRBeKhGxlSL4jYZxbdpTkTOKxh2e08bSAVW?=
 =?us-ascii?Q?LpDKfMrC4nzGcTzBm0NquS5gNxiLwwPdju0Zk2sHXiKHcsO1rfcsNAcU5tew?=
 =?us-ascii?Q?pORTnBXDp5ytM30GgzFT8Z8a8KUZF5TWbj6Bscj63vDtsE85zG5vQRgHXO7w?=
 =?us-ascii?Q?iNUj3T7IyAET3r76EVLCGKyk80R6dCmRcA1i7V6gkXUN3c41gbsdOd35BlMb?=
 =?us-ascii?Q?/Ctks3/VB5K6Ym1G2aSED0QuMZUYQQXL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:40:06.0707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd667365-c140-469f-4cd8-08dca6984293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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

From: Austin Zheng <austin.zheng@amd.com>

[Why]
Even if the mode is not supported dml2_check_mode_supported() would still return true.
This causes an unsupported mode to be programmed.

[How]
Check if the mode is supported or not and return the proper result.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
index 30d07cd1065f..e9b40a45ffdd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
@@ -138,8 +138,9 @@ bool dml2_check_mode_supported(struct dml2_check_mode_supported_in_out *in_out)
 	}
 
 	in_out->is_supported = mcache_success;
+	result = result && in_out->is_supported;
 
-	return true;
+	return result;
 }
 
 bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_out)
-- 
2.39.2

