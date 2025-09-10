Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6AACA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD1E10E848;
	Wed, 10 Sep 2025 05:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AA61+bXZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66D610E848
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eN3Ch78Kp7qbh4cJIWFA1Xk2glIrFKzNZqK1ofzRDlSq02Ozlvzyda6j/utqJkvKZts7oljdpqVA7Z96iNn+4KIhumXZpf3JV6zZTfkCf2pUDqdAwNViuqw1NPZWNHguxnRUXV8P415lxZhfGf0A9uEXeue/agCfypBAL60cmIEgOtAEU9P+LtvFslWgq2rWyz/dwfpJlpiDTq8C/wwuO0o9AtuJjoIJKpVXq1+Z30pxWDVbDy0kD4c0+5GfIC+s/62VE+sZPY2eA2Q9bw4Cvxiqhi+McQanbScF79g+LbgYI21TNWgd7mHPKywhsvTb4AV95eBWvvBQhhAOAbGWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TPwCWtm5V7grYD0pF/viCmXn4x6TWw3ec4nLPjGPI0=;
 b=Fd7917bZaTavgvKSV3h4ReLRrbZ9OMwoFmR+mZ/hReWvmhkxnimyP1izMCXxsQpTeQv+HvxIlMZbRjpGDiY2HBCBSZe1ApmVNI4ifeCS699Uw1n6fRmADPXBEZFbAOf+nEjkXc5zHWN7biJ1iiW0tm/bgb48gFiWGhFVAT4djqWoBQlAS+k1e0CeN145bXTzZm25b+wwJcMXExvTiJUpkvPbZPVCk2T7xcCQCVVtjanc1wAfYgcN+5lKQn/OMXO5dgiTTjH4SrSwZIBJOmn4B+ZPR1eB3vCUYNHRjPWH8u/PuTx4CzjT4u1I+WH6LNVNOiLODydTNvnQdQpsjzG0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TPwCWtm5V7grYD0pF/viCmXn4x6TWw3ec4nLPjGPI0=;
 b=AA61+bXZ6AAiAnY75wNp6R9k6Jyq+oORt9sh757Ffo7YaSRGIiJy0SApdjjpjJdxFXenGYe4Jqa7gUFxzAB3vfJyunhWiRIeCMPBoQbfQoJCEUIDc2WZKVlKKTMmU7pgyHuAXOW2V/QFFXwYw0h09vdn/w52DZ5lRPayViePb4s=
Received: from BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::21)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:28 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::ac) by BL1P222CA0016.outlook.office365.com
 (2603:10b6:208:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:19 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:27:18 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:16 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <Dillon.Varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 10/15] drm/amd/display: re-enable
 disable_stutter_for_wm_program w/a
Date: Wed, 10 Sep 2025 13:22:12 +0800
Message-ID: <20250910052620.2884581-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d862a08-26d7-4c8e-3bec-08ddf02abbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zImvMpU8fNIY1WMLN3DE6VMo0cUZhd7FQyYjcLZ9wbPbDIc/9QVlMijC8hza?=
 =?us-ascii?Q?EnSP+T3/6wwV6EEPSVlV7ZmXlmz2RT5TWp7B2hv/3IXNYdF/wlskGfKezewi?=
 =?us-ascii?Q?+K1eAzZhCdo2dm8Kmm+BYgGFVSBhPHGLgB+p7A6ocPCerfmzVXmYiRw/g3V/?=
 =?us-ascii?Q?x5JJ/VGTtymKcVE+hIzkBgVTbl5ckgzwjx0iBE8UZbhWak1QdVvXWLf1Y1az?=
 =?us-ascii?Q?T5nsH86n5SqYAWdJbOXfWBaCPT3/yosbOzcszTAOs7AT6PdkT9Q+pBPY8So0?=
 =?us-ascii?Q?ZQmPAhc6wJyEIMn5lf0CQu0fUyKgG2jIUCCK2iXuYqolJb1I6Hk/llQDiwzG?=
 =?us-ascii?Q?o7glIzUZNO9DfF1UV55B8fz9+fDjUuegBciqemXb67VDKMfQU7QvKFmYabdP?=
 =?us-ascii?Q?qUrgxnGKyVy4uCVTKKZGw7cEujL01omEJrSxF8RWLJnV9HBjadh8mAxnFMPB?=
 =?us-ascii?Q?uL+SjTeq+xEAhEU3WWk9VZntc1sRklYgHET5fhaaQCVlEyxVw3EuOTh8Ooqg?=
 =?us-ascii?Q?Ofh936sbR2GahXMvwI1ktPqsCVxdcbvzt244P51Ugv3gZmN0RDGVoOxPI18F?=
 =?us-ascii?Q?qXhLiypPAN033JJA2li02YPEV6/9WCiRB/gYUjIV4j7sE/gddXQ9mitYVmOd?=
 =?us-ascii?Q?AXFFJXxLQr7lWjk2NF+Qr9Xl9a1kwekJeyysMNufL06oan5Dx8j7lotAajhP?=
 =?us-ascii?Q?CikFEJ8PZ5kOjBRhqU17HVDg+bOjfM/6Naj85KJAeGGNy0XJrTR+UJ405LMq?=
 =?us-ascii?Q?9Mk/gx9meDs3ZLRASUeVTcj8cuhiyoK+MKgUDgBjvN4ELHaYPO1aMLwT+g0j?=
 =?us-ascii?Q?SQ9UgkCXd+J0HlI00/xCmP3cccvksDjO2WkLsf+3tKOd+yGQg7hftWOjHeG4?=
 =?us-ascii?Q?d/U4Xkuesm6nTwSc485lGLzqq+A4YfEjBTl2sYVvndNczPJoI8Cl0SySdcoD?=
 =?us-ascii?Q?DqbGeSdU5fErCTh7o6YLViWORnSFgpQmspc6q6QKXvfqi6cui1NcH4n9q6j5?=
 =?us-ascii?Q?Z0q2FO3TqyJGVA08pbWR58ikr+11xyEpF6GX+CIbdlQmxsXWOw2E27Dio/G8?=
 =?us-ascii?Q?HRWbBp1vRXFDfHbdhbytkg+UnJchkB7mV9pMcp+mpvxVYlbCpPo24yMSARJc?=
 =?us-ascii?Q?Wnm4ZDe8JDya9Qm1rU2ibT/AifRJrq8zubDCNlOjublyAhIZba7ev5hh708r?=
 =?us-ascii?Q?bOjElnfxyBWaCmhC8BF6kaSRVaclXB9jnbTklYmxrQXh981nm+Cl30UgdVx9?=
 =?us-ascii?Q?6dGtyBlDsksbp88ZnHw3qEeR7g+JqNzFsxWbZQNNC/6dezHWe2CkTi6dYIga?=
 =?us-ascii?Q?TuJyYELEK+atoFQuJcJy166r6ao7SPCGL6YyMODLDSLQu5ALQ82ALRF9WdbS?=
 =?us-ascii?Q?8T8zCq8c6YR2ZnuM0sIFUqqG+FUo2+nVDWVdcguDUyrJ3j3kf2BXe4ATonQd?=
 =?us-ascii?Q?Pd9179txlQTV03IfhyZNejWFkYezxiRzYYUR5WgtVA70YJKL4+v3DSQm+6B0?=
 =?us-ascii?Q?GaN3FAHq/D0Jkl24NPyZIor8Fgh+Xr15u1Za?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:28.6596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d862a08-26d7-4c8e-3bec-08ddf02abbd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Re-enable the w/a to disable stutter when reprogramming watermarks.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 8aad920544bc..ed639437ae6b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -739,7 +739,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
 	.enable_legacy_fast_update = false,
-	.disable_stutter_for_wm_program = false
+	.disable_stutter_for_wm_program = true
 };
 
 static struct dce_aux *dcn32_aux_engine_create(
-- 
2.43.0

