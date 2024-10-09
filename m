Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95394CEE342
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6F610E7DF;
	Wed,  9 Oct 2024 19:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="49NNRYTG";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7DE10E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv0ntz9qM1nLqq2CbSkcFp/qV9IbI0HDlzKPsDs87NhrRDGkXxwzmZN/ygOxjE+wHDHxaPoPp+OzbaQB4U9pzp+W6RYfHdLrxGYiS1syRceOX5wsshzXkVjNbsqLNFMC8tcqIlQ/7wzv3E0IDvNvdCmXcpfAY8cghVXg5m3baQPbgL8HsJaWd1/wMSVOKepKJ6FuMIZ8R11qnlzqo7KnB6rsnZPCM+N/pf/jgigilnSFcxpN7qXxf1+Vpo++5sTu33RC15kH2XHWvxoRZ4gZefxvWCYQIrtVLpGVzvshm5tqX9CDcVleYgLlrx2b8K8+jGSnkQQnFQ5c/sGY8YUMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Hop8Dsa9J7v4WTkgcyGS2vCTxkeAM3INjcp8lnfAVk=;
 b=pz/hEiIQAEEgooR95M48xr597Bx74m8sDFWfKCFbo9MqVoev+wfNpqqXcxpBum9bFzyI+wUmXUYJXbEu0Y6cgdWQ80Hi8glWRETwUFowH2h0toWEHm6OQbjV3lns6ec5331Dd2nFLkvrU4B8K7VMQPGYysBiVnDLyiFPwo/lkknTc8exNFUVmQY1Lcxgd2zztLlhIl5obr0Q01qvP4MOchZPfri4y34NvW1zxNFx20BA3H/SSm6iRru9Kn3hygLUMuT3AGAunHLNguFtuuNaOaH4YjgK/T4FwzBgvOscXd+zTAvVyKTjnADPNzjjo3G/Iz0asbPm+G/6VZ1l2ftYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Hop8Dsa9J7v4WTkgcyGS2vCTxkeAM3INjcp8lnfAVk=;
 b=49NNRYTGjyJez8ZwGvgY4ZbYc0XskE90Jir1VYn/vFzgw3JW++UnhQv4Wj2Zye9RJqm9RhIC4XlAzUBpCBFr4Sxbm77433DRWnCc8j2gqOWCcfb5eCWlczOnpQViVL38xXpRXnYxUbIgUUdxo+VHEA1nXmXwo8LQg2/rca8ZGK8=
Received: from BL1PR13CA0254.namprd13.prod.outlook.com (2603:10b6:208:2ba::19)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 9 Oct
 2024 19:25:55 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::98) by BL1PR13CA0254.outlook.office365.com
 (2603:10b6:208:2ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 19:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:25:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:25:54 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:25:49 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Increase idle worker HPD detection time
Date: Wed, 9 Oct 2024 15:23:32 -0400
Message-ID: <20241009192344.650118-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: daa24b02-00a2-4f5b-bef4-08dce8983223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wDXTtKisJqMWYLBwD/QSiz/7HLr5zhg+NpttuyarWBhQn8Mq//T6w1hbamRG?=
 =?us-ascii?Q?F1j7ANdzT0lkvmoiPtrwpw04n8B4lUmCJc7NUBuADzD1EBncXcV5BKz5xZtG?=
 =?us-ascii?Q?7FpbqOS+754IiI8C1x5saEfSGDfM2kArmF8je8YpFLXmWwro3hZdne1Y8lWP?=
 =?us-ascii?Q?ZUxdcHmwGNwzqlymdcKfHG91pf6B42OkvMUWPLG6f+Btqtwuzw+kLCbA+bQP?=
 =?us-ascii?Q?Neb8x4aHw3vCuNUAtTianvaNshY//h7WeImeq+snNE8EqIS75JIUF9GZMMIa?=
 =?us-ascii?Q?ZKUnR0H+w+ZJ/JuhKkfIrP/oY+2lWl+PZATCR7Rq/2E6sD1TSdgfw1CUpJHw?=
 =?us-ascii?Q?vijvP4hq2ko9mPEGrqBPuEjvIitFhi05dBDDhefeP5F/e9VaLHC9a549x3FC?=
 =?us-ascii?Q?Hewzs5fQwjDb9kAGajGv9EmlUNIxS6h/O5I9zkFB74sz+9omaqNTiaHk6UZN?=
 =?us-ascii?Q?ja4Xdq+0FRCSNC058g9MhH/NOJ4lGqrH4jHJru4p9Mu3xgPMkpnA+k5XAQ6W?=
 =?us-ascii?Q?rxb99NFV3Uw61yANSJopmnu9rVtJqldk8lfovLbCm/QjzJi/5pBOJgTFkqYE?=
 =?us-ascii?Q?O26DRG46G7Xh7qG4PkBjit9mVeVT0fhYDNyyKERyYKHXkwyIhqp94F0tkDwD?=
 =?us-ascii?Q?ChQf8D5oS6Bdv3mcd3vXmzGRrl3KfUXgUxHvDqpReV4ON0lmOFctNupKuoVR?=
 =?us-ascii?Q?0ScNwKnTZajgsakriQLKsof7uhRfc7SXEi2YHJvfFZd1HCL2UFeDhEIP99eX?=
 =?us-ascii?Q?NHbF4YebPwXhAPg3KPJ+oDt9oH06L2Ep9ncWbTHNKxZAMiYaqZsY3wG5Drku?=
 =?us-ascii?Q?ues2g9Tx0sCtdKS2kaNGg2s2pbC+yx55LiQsV9CYRlRfKWdFDR/rcBo5hnaH?=
 =?us-ascii?Q?1eTDeiLuy8bp4/E3nwsDLpi746igt9WjU863ziDEFUd9ePtXiIJJmocqaNjM?=
 =?us-ascii?Q?HG0QFLa9RVXjz0iufR6AxXI57ZLkodNKSQwnuSLpDdEAOeD7FjRX0v+rhkZg?=
 =?us-ascii?Q?mzLNF62AHWzfyYfggm0H21VJ9aV3A4KMH4x/BUZFLumk6pybmFG08OzXwGID?=
 =?us-ascii?Q?G1kN5CeDLL6rFn4c3iAOxptsd3KHClVy/b/3aQZ36bIRMqQrGdAflJYALogR?=
 =?us-ascii?Q?FwMi3OltlVWYZ83GNLOZ9REfvfpLIZ9mfYeHRexWepWkBJDRmgVDbR5T+U3u?=
 =?us-ascii?Q?I5tDLVJ8IFxlbdLxWdV1k4z5YSLyEi43BJ2c6nVRr81TgKExKvzPB5iS8tzr?=
 =?us-ascii?Q?Y8U27C9odDt8CDQRmL1Dtu3+TsjFdjXPVg8MztQfOQTvXpZzB4SFsZ1yRgc4?=
 =?us-ascii?Q?iLHOvTpNVhyKDJ8Fgfx0ZeLqP5v5fkg4CS5Guu9RxbzhfJzxUILmIEZZv6QA?=
 =?us-ascii?Q?kXz0KpnSWC9Y4PtnRkL/YSlo2/dW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:25:55.3019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daa24b02-00a2-4f5b-bef4-08dce8983223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
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

From: Roman Li <Roman.Li@amd.com>

[Why]
Idle worker thread waits HPD_DETECTION_TIME for HPD processing complete.
Some displays require longer time for that.

[How]
Increase HPD_DETECTION_TIME to 100ms.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 32fa643cd899..ffa4d3965b4b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -36,7 +36,7 @@
 #include "amdgpu_dm_debugfs.h"
 
 #define HPD_DETECTION_PERIOD_uS 5000000
-#define HPD_DETECTION_TIME_uS 1000
+#define HPD_DETECTION_TIME_uS 100000
 
 void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
 {
-- 
2.34.1

