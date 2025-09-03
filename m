Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E19CA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 16:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E27C10E8F5;
	Wed,  3 Sep 2025 16:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdOlfIe+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA8F910E8F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 16:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjnxMi7B9J1NCAk00kKpPsMxypWz+cMbAfaTs90pN5caPyDB19VJxHk9fZHG3X+3poAjN4Chuy2vGbk7USW+svN1QyAMorcuJOE0l2vvngQMk2brmaX12xRbZ0S+hh0x6MiUkeuQ2LSyapGfCjxKHEejTJFUpQ5a8rsad5RuBWhKLbVNEtBfCbTCMxiGh2jKclCYhyPZhXf1mPbdPM1LMmA7KapSP6BQyuYvTquak3py8whUrIrYDua2xEb4lVtj+Qyk0SmrBnjadDvy84dcdxIVaHRmH/Kq73XI8i56VZCqgMszVriDjhmd9D5RORd3w6DODpLubnKMR3YX4r9pNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVBrpwpACCvNxPwG3cv1pnGrAKRAfOmT5H5q88F7An8=;
 b=UGjVZh/0ABtzBRb++f48F1cKjUTx40qbpw1JbLMMkAKX6EnY4DJcPrkj5Zgkada1Yz73BSKDNSBH7BAGZC8Iod/LvmTeirAd+LBx8dmePhS65JzCtPWrcolelkZXExhHftIAIzoB1usW4OcziOfeoFF6dPqBJHU/yiDiLYU2QZ4CmStTiIR9f8lm+QLqduSTDPFxZ84VKHmiFGS1WXGqW50XVvIuE/kAeq+o6wk1+AJnKxJjTdTGEXRobw6iFtNaERgcXQGIP4zBUUMdvHsBpuYuUOWkgFP3IDpVDhciouUIj2Ru/VCqheCA8bKYnApk/O9IaunY0GIJ8tbiACGfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVBrpwpACCvNxPwG3cv1pnGrAKRAfOmT5H5q88F7An8=;
 b=IdOlfIe+nlJs+v/fwnSMqGdNzRUikjtAfwlUtfc0SQRq2OEL+DUqOP2q/CJUvNTPoNM6GmAvAPyiOj0M/7gTIV3VXHLWgfezkZpaz1KvzR6mLk5x4MddKEmOmknwFixdMBY3C0kQuWiP1QnR2JeKPSMcQpvTTHvBX1XlVWNqhvc=
Received: from SJ0PR03CA0133.namprd03.prod.outlook.com (2603:10b6:a03:33c::18)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 16:44:24 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::d0) by SJ0PR03CA0133.outlook.office365.com
 (2603:10b6:a03:33c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 16:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 16:44:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 11:44:21 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 09:44:21 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Wen Chen <Wen.Chen3@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: use udelay rather than fsleep
Date: Wed, 3 Sep 2025 12:44:02 -0400
Message-ID: <20250903164402.4002993-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: f5077875-fd89-4e4a-b674-08ddeb0922d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1lnLCM4GMSaiAAI8iREBIPPpgs/CHki6iI/0cr4fovlw/JoiVgNis0b5FVcn?=
 =?us-ascii?Q?JP2OANTRKO0yntbIRdkn58K6oagOfRYJA3BD4dWkq6zAhfIzPkxjgxleQ7z/?=
 =?us-ascii?Q?LrtVVhczlhBqVagofmsd4ULLASixkWIbbTi1gtqCXGqcMlPKjUHcHRl+2k4h?=
 =?us-ascii?Q?1POL4VXqnnezG3u0Q2uVK7BAPqG+VdbnQ/BGt1HNqnpG21+3G5tOgyUlo0AJ?=
 =?us-ascii?Q?B5bwELVcdjytO776MH5mjBqhP1fLyNjHFF/qdglFKAiM+Hu87XFPCvDc60vT?=
 =?us-ascii?Q?iKd8sRtn3TEvta3MqWZwSAAn9JNf9SAnwMB6aCZ43oC0r1N94j6e/RVeCt1C?=
 =?us-ascii?Q?u51T1eABr+6xMilW1YmYBmVcaL+XWTAFVI6RAcZrRUgFrSDsObAAB8kSxnda?=
 =?us-ascii?Q?JPiNPEW6jAWhFQ8GsSZLC1T/h9NkwoRFm9Mkcrnw0bWI5Fm9mqFNxYMQGq+a?=
 =?us-ascii?Q?cmH9/G6NuLSosJfIwTrDuJPPGU7nHVnA+ZtPEmdvZ8YOD/7zcF+SfFGwEaUh?=
 =?us-ascii?Q?0ekVE0nJMpiLUrEVrOiuZN90UkJkpfhTtVMki+LoRpCwtq55ogiqrKrhAtb/?=
 =?us-ascii?Q?mPDfJv72+5aPoTur0XjLoE1OHaRPLeP7O5zLFIHmR780Eydwp5tSgFI9fPnU?=
 =?us-ascii?Q?I9i+ZrXQW5JmLDhWKteCLUDHz54reyH2hCLkszd3kxI5/qKzhKEw1nuj8omX?=
 =?us-ascii?Q?2rdo+0gJKHx9nYVHvLshEVHUK10NVn1SGpHQqAfxyiMIvbp20PMxee+veKDD?=
 =?us-ascii?Q?C3wij+pkChuo7+IApF1A1hBJL2wghcSQ2+bnb44/LfzkjHZEs13kpGN9vMJh?=
 =?us-ascii?Q?+b6RQaRLMfJRfuQYdwhKqMfjiDXpgjnOidfuVdvZFy651R2oerVlVdzyJF7Z?=
 =?us-ascii?Q?dolSyGCIXNAfAvpV0w7c1HfPMcGzJ4Ptm43WwOlUvJJEgL1kH+Xyjpzs7Kyq?=
 =?us-ascii?Q?Ni95wzK2LyhSfrxqVcCrVWNtcl+QmT6d4k5wBtmqLjjNKacqJsFDfHxUc5kT?=
 =?us-ascii?Q?W4I1ukDDSUeVKECBhFtOQr2GpR04K+FvianfClO8jNv8UIhzZk/z0+c+yUXU?=
 =?us-ascii?Q?JtBKE/Q/+QCUMrl+cxNYxUl7XdElyEev1Qd8m3iAd8GqOYo3h/2cWby7V43w?=
 =?us-ascii?Q?p/2+Mx4HIp4tfXogtyXX4zcIDSIQFFbrBvg29WSjkVosHyusd48rIyqYVXSO?=
 =?us-ascii?Q?ELr59GEoVo4GUlMWYNHLkgd6tk/FayW6YA7VG7vvYDYtDVZLJh8UZurdrZ+G?=
 =?us-ascii?Q?IRNOIlO3WbmjlEsCPqLDRWJPD7nUV0rm0W9HgeVYaLw/3yHbi/7Uw8kda+M7?=
 =?us-ascii?Q?gy6d/D9tVaQ4hKZ2bxHYcwCPQkS/xjIyX6FUyvd5TXXYVvdc4H73AQvTpPoS?=
 =?us-ascii?Q?L37ucInReT6IWrIbpHh/po3s3/7McM6EfDC/uMMGYQ+w3i9FPu4yX8sOU3iW?=
 =?us-ascii?Q?o0c3mr05CdD6C9xZsVnae88n1Coxv+Ry5mbkxHXV4FbftbbfSmXQgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:44:22.6923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5077875-fd89-4e4a-b674-08ddeb0922d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
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

This function can be called from an atomic context so we can't use
fsleep().

Fixes: 01f60348d8fb ("drm/amd/display: Fix 'failed to blank crtc!'")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4549
Cc: Wen Chen <Wen.Chen3@amd.com>
Cc: Fangzhi Zuo <jerry.zuo@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 7d24fa1517bf1..cc377fcda6ff9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -955,7 +955,7 @@ enum dc_status dcn20_enable_stream_timing(
 		return DC_ERROR_UNEXPECTED;
 	}
 
-	fsleep(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
+	udelay(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
 
 	params.vertical_total_min = stream->adjust.v_total_min;
 	params.vertical_total_max = stream->adjust.v_total_max;
-- 
2.51.0

