Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79573C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 07:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1729F10E008;
	Wed, 31 Jul 2024 07:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sq41FsxD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409F710E008
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 07:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH5lbBuinMc2713XSZSWlQZPhlZOGQy8LuXIKij4KqyznlDAmS1ah3wSHyJx9QQv3JLWxt9sbTYaMq3ljbE0MXmhQQRQZpJ8Lt2tWcRbusH0Ie4nC+uG3Cc4FJD9iBCD2TZFr11HW5humEyaqDTZeSsRW5H2PUjHZvuzMYpq5CO6anOGcHhmcMqZNa1VRMkkFATjP6UqMl5F0wLFAW0duEUGEA2j+1c9ZHHZjbrYS3CPhTUhOvfJ4YNw9mkE5wMod/dyNEaeYhIku1a/mHNH8pyCtcLDcyr2OAvzKnXw0qmz25HvuvD0pqe6qcZHxTvS+Ev0n8jteDhdk4L8zdnyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/rtvk9wE8LZezrm8SWLRqz0wL2aoDuoiQ7BwowH/4g=;
 b=pVBPEG4GQjLN1G3ePBf1WNYqp+y8HSVvz9SGHjtjapWqE5ACNDAxNoFQ0qwbesLMeYQfwJECfJLr1MkBZItf4N2uHIp41kXBYqpnikrzO7hDXBkZPSsbkY/tmNv2nQ9pAOqJ2IC8N5URgEhqrYkeDLLkAMNsEnVYLuMQhZZyL825Tq1iZolMJIdULIPVpw8HBXx3FZaPIHs+iM/cRf+4zGPWvZH7zvywp5uwu9xGC4wPABJWA+UtsoBu/uT3vIlEueyQLpPPS01nobTDB016LO+nOnrBhgo1DhYrtr0Dh6bQWeUmNSqS+BmDaSdzzJWlIMcyDBLe4o6YdFWceOgqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/rtvk9wE8LZezrm8SWLRqz0wL2aoDuoiQ7BwowH/4g=;
 b=sq41FsxDezfDXnmE0KLevArWjPCtoLd2WD67eEM5irO8125hPGV300maShMduTTINPPheuEJ1UFWdxZ5ZsC0E//mIZqJlqtJBwhiRPlGsEOmuprfe8EN2P/ZDgy8PcteEBTa7wfQvcSwwdFrtdlRS67lW6Zjm5rfnH6bHfEjoMM=
Received: from PH8PR21CA0015.namprd21.prod.outlook.com (2603:10b6:510:2ce::12)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 07:57:50 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::59) by PH8PR21CA0015.outlook.office365.com
 (2603:10b6:510:2ce::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5 via Frontend
 Transport; Wed, 31 Jul 2024 07:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 07:57:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 02:57:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 1/3] drm/amd/display: Add NULL check for function pointer in
 dcn20_set_output_transfer_func
Date: Wed, 31 Jul 2024 13:27:31 +0530
Message-ID: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fb2791-0dc9-40e3-0fdd-08dcb1367972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BqIulVoE9GbKCTp5VV4f8qweNGwPfPmmwihOvI8aISwiGgMmLe5AeTjb5eJv?=
 =?us-ascii?Q?Hdzz58UdAM5th0ElBRYmd/HpH+lkkpVOt1GAVexNTZtW9dQ0uGDmP+c/82K5?=
 =?us-ascii?Q?4E6+ONFEVVHihDOjiCRE5bPCn/LvNYlCpgvoXxF6d8dH1smN2twgEZCp5mQd?=
 =?us-ascii?Q?ayUd9KTRW9TGU8nVBLU2qzK/Mza2srfZ1aPuUvfy1mFnGz8Mn/jZpVLh+aY/?=
 =?us-ascii?Q?xv6TSDdqk+UwwEX0wwr5Chb6VQlEiHaq2zhP6Bx4kgMDA5cBk48IZj56DXwA?=
 =?us-ascii?Q?bqJISxyY5e1MtASvg50CAKdLj/GcWyCzGVhMRcBxJKviePX2MexDzfYQJliL?=
 =?us-ascii?Q?gcrhj3JEjObCjASBKoAXnCz+YS8g2zZa4E0h1ikRT90hFx0Yr8RVTTbqfnda?=
 =?us-ascii?Q?eDkA4fLygqP5AYwr4QoKqPQS3gw3YeTPjFkViOuItPZSNOPn7Ds5AZRIz6nM?=
 =?us-ascii?Q?wDW79VLFGH5Jf1vt49GzADdJk1v1avtjE7wxiUxQuhDKmol0uq8Jgxqc6Ih6?=
 =?us-ascii?Q?dgXRnyWF+16+N89EKQIO8KB5gyremj9mQk06LaeHDQOkw6zWk4/VrbKGdnQu?=
 =?us-ascii?Q?Bun518p9I3OUZuEYIeufqLs0NOnd3BA3SkUPfGvDXbaCvzv7fLp9OfLXA5e+?=
 =?us-ascii?Q?tRvaMdPdAL98A6ettyXDpnwcGyIoXbjEUetWEMhW+72gxDG/p8RiXd3FnIPF?=
 =?us-ascii?Q?j6UBSzOdTlh7yBAj+NnuM7YTPkFgF5g3PqE0AkMrpKzJvjuYzpA6vCWTuhGk?=
 =?us-ascii?Q?Mv46NF79w+wb2naeiWDe3KWfEAwKUBf02FFfTm/SO9jm4wbuZv5EYymjtnNL?=
 =?us-ascii?Q?HRqjws04uXQzN1jN+XG9Hpz3OA1+lpqESEbX1g8mCF9r/JvIe/H9FLTC2wiB?=
 =?us-ascii?Q?dW0y3a/I+kbwh8uUY8hdnl2IsNbd7G5H/7oX5BnHEE+1C7Io7QuXYVUKLpGv?=
 =?us-ascii?Q?5sSbf39ebga7+7+Uhrvrmx3cOa14GTfk6MKMBWrgVZF4+Uqeo6YBG8g4Mns6?=
 =?us-ascii?Q?DmiryZEJIAZ9zmWq7aI56IVPqJP9GU9EgnDOMzPy4zaYBFz6AEjs7Xzi8Avn?=
 =?us-ascii?Q?Sj/SinMHaXN8qeSebYjBQhg+qj4sor7IlFeUXpsHBY2xToeUK/ly1ZX6C/Qq?=
 =?us-ascii?Q?AmRp8Yuv2XKepwQZUBQpLXl68iORTCLD8QkD1KiIMnM/xRLlhjAuZPVNqJ5d?=
 =?us-ascii?Q?JWztD5YplbuR/9lpKf/Vj/HtbJvf+5KmemKMfdW/ghwIqmaKUaknxjeL4owm?=
 =?us-ascii?Q?0HFEoBtASoVNH7EBJNph/UB7skkEcY6Lj20X6UuyRqJZpDtG4jS0yE5wywgr?=
 =?us-ascii?Q?B4Li/kxhQiMoqf1jTYw1Zu5qK3vsx4PD7I324R5W3byI02Gkq+gJM0FQQ1LF?=
 =?us-ascii?Q?0CORWJP7VGuw5bczcYEvyCXpS5Wl2HW1VNhN3YdCOK450ew6HHj12drab4l+?=
 =?us-ascii?Q?Rxb9DuYS4Upun0DaEvQBtsHFPXv1tMS1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 07:57:50.2386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fb2791-0dc9-40e3-0fdd-08dcb1367972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
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

This commit adds a null check for the set_output_gamma function pointer
in the dcn20_set_output_transfer_func function. Previously,
set_output_gamma was being checked for null at line 1030, but then it
was being dereferenced without any null check at line 1048. This could
potentially lead to a null pointer dereference error if set_output_gamma
is null.

To fix this, we now ensure that set_output_gamma is not null before
dereferencing it. We do this by adding a null check for set_output_gamma
before the call to set_output_gamma at line 1048.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 5a6064999033..425432ca497f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1045,7 +1045,8 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	/*
 	 * if above if is not executed then 'params' equal to 0 and set in bypass
 	 */
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
 
 	return true;
 }
-- 
2.34.1

