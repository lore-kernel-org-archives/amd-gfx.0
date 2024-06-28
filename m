Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88229C30659
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 09:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D1D10E1B7;
	Fri, 28 Jun 2024 09:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UcyCp7/i";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3332110E1B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 09:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bby2qNzRTICPrjUL9JIvfLHXK6tP5zzYVG3OfG1sh+6W2/0Kjlgo1hLzzZcHWXhI89owju+Gb66p0XQbxdJkj3PnDOcj80qIVZk1jHprmyrWWBDZgW4zT13F5a43HTJfwhelWIqGRNOs6CuEqcREmjPcd/BlEN/llkA2Wu6+8JUVQL7KNR7N7JzVg4v6Pn5MVI0NQc0A5BxkuaXERLq7E2wnCLnG6NG8bQY80+Lfdp66N5MUohFAp82IW35zkp50VJAmUq9cBsH2fJdxM9V5aSQdJG2pBACZd7tFf8hT/2N3X/qLNcTSgcMbW4YZtVbJ7TFRycTgDfihPML5h/Bvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shZFQ1MGddesKtAFG5HYdnVZdgl44uz2+Ijfov7TXrE=;
 b=noSNZTu3ee8tZep3qTWE0HePqlvmYbUM94lLQAwBjz0hyCufZ1YXWrTJkCtuAyKjCxnFsxagKUAx+ink6/hm3IfdR21ni6S1d+swAmS7oIveX+bRPM/FkMa1bErs9rSAJd8aLYlcsZn+utvlg8Mxd1mlinb/Wga4pltZarNbwtNYzBZTXwWwwY77RrVKo6LY7tlT6KjS3D998l5CtmNl0RJ0rTYOciJ3JZOiEjN3hMw/8X1bmciNTxb0mM2d3xbYSEZvPMH7frwG83pwcNtB0B6VxNWR6aVHGDUVGnWPunGynvlU2VogpV0ChxKfnvQ4llDAbbQJA07aB69ef913GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shZFQ1MGddesKtAFG5HYdnVZdgl44uz2+Ijfov7TXrE=;
 b=UcyCp7/iSd3u9do72JngGf3dq6q0SeVg3AaDpHv/xhK9R0bt75y1bRWyGknBZJ054izpd4DC16OJ05j/fw913GOkst/bZn5Yl7rdjjwm3r5ZCi4oQOZU0qF4pasMapR6sQ08hu4RQ/EbEmk2PYSwwl4LqqyG6LxeUAUUpbcw+FI=
Received: from PH7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::7)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 09:04:19 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::98) by PH7P222CA0016.outlook.office365.com
 (2603:10b6:510:33a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Fri, 28 Jun 2024 09:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 09:04:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 04:04:16 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 04:04:15
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Correct register used to clear fault status
Date: Fri, 28 Jun 2024 17:04:13 +0800
Message-ID: <20240628090413.6621-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8e5bd3-046e-4568-39f8-08dc97514b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lsgX2QjvvFvYYlMtr1ZWspRZXjqmLxbYBZ2rYgFIpPZOfWzql86GJ0xObWjx?=
 =?us-ascii?Q?ZeaS+yxuZyTt8+bh31JQI6p1m7iu8nvA7IFH5nd0Wan3O+lt55LMwls9Z2gr?=
 =?us-ascii?Q?9TaZVdJvfGK9IHrPm7yqcZxE74cqbcdpOH8ooPj4tSc0qSkIuQ8ywjHazwQi?=
 =?us-ascii?Q?kAFUQS63A66/vZwWEEYCKrqw02jgDhlny7QPOKZwlytAgILfTtAM0uQYlklB?=
 =?us-ascii?Q?CUuCF2QGHNg38mq3uZrMemUQMaJEfIs4tTxdZrqtV0mIYpnKvez7cC6b87Xt?=
 =?us-ascii?Q?sQZVHBe326s1W/Mpmklfwt2MzXjtL1kM/AthtD9/C75H2OfvBmZXh5YuKo+E?=
 =?us-ascii?Q?U6/RehhcmAbTHrdRYiVz2qVmbxf+XI6R9rBrF14wgvWb+0nI7tRmOIBhpZPn?=
 =?us-ascii?Q?CRXvoDHfh6mI6EbtwH/wVzAt+0bTj6u1SExd62pZFAf7ZpVbVQWF5Pem8vRp?=
 =?us-ascii?Q?wr9VHWTIYY5HiQX00alFw86RknRQhaiQsK33SZgrnn8kOX5ZvH1YSx8bw0wN?=
 =?us-ascii?Q?iTVr37EFcxi4EgyAUk/k2pRrg5v8QPva7f5Z/oWdNRzV+PwyvswqOclDt016?=
 =?us-ascii?Q?kAG+p8tODMRvdJROuCgvyXYIy4R/0OMIOTJ/5jyR1rck6QqZ3U9XsiDG/NSl?=
 =?us-ascii?Q?lsV1rSFylywZ8h2XF6czs4f0GHe1Wwf/WpoESl5MuvpMrK+qjNA9G8499z9l?=
 =?us-ascii?Q?YD6XlJTGevNdxsSUa5dWWKg9PT5l9Tmp/8GDUiDwNHHTWmrPl9yvbzIennQ5?=
 =?us-ascii?Q?TO++DQskLy+JdDeJu0B25auCNennRrcxUDCy+eoAuo7WQL2R9taxywnsp0O+?=
 =?us-ascii?Q?/xEnqBjrBiG/uQECfEAu4B2M1fBHz0nuIp9ta/BBtfSL8NMz4itFPjCXVUgo?=
 =?us-ascii?Q?5eCqvSLhcG3aYY5YyWbKkK3AdSAVY3buAq3y30UddBM5Qei7204NlKwsQBkd?=
 =?us-ascii?Q?R3oI09qo2Le/2BCbNUgfD9t0gQifbeRGBiK9ZYbxpdlgDtew6ORIxyZ51wQd?=
 =?us-ascii?Q?W0JVTcpKDFneydcdSIVUFmwunTJyhijsaDn7fFQ4FjQrACRjB8RQAXatkayp?=
 =?us-ascii?Q?vWK6CLdpjKY0tcp0pxsAUEPcjOUz0A5OLSRw1HrSaUCCr0IITz049N37eX/T?=
 =?us-ascii?Q?Haen/YEwrSSbhcT5IotqGt+hY5g8tc4WllZEcZ9u56+oYLCJRP09M02G+Ufy?=
 =?us-ascii?Q?op+Te24zOc+RDf/qLxQBgHnc2iPvH8VH9MsZEspAOUNXWplQ+X/63Y0eYDqo?=
 =?us-ascii?Q?obacXvHV08BVG8A8QBoGab3KH80C46IMZAZhfgcaGK4hL5PEqH03R9THfoPT?=
 =?us-ascii?Q?xhHSWObI7KbrWRT67uhFlFJF2BA5U4NERX39bsWtn/dXtxu+EZnO58IyuskX?=
 =?us-ascii?Q?7aXnBaLzxk/Ea5HnvqeGpB7f74DgFSDtJmf0FmsBzzX9/rtgsb9rClSVSBxU?=
 =?us-ascii?Q?PDNapYuUZuJH9XHCePw4rUtdK9+NsURQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 09:04:18.8588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8e5bd3-046e-4568-39f8-08dc97514b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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

Driver should write to fault_cntl registers to do
one-shot address/status clear.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 8d7267a013d2..621761a17ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -569,7 +569,7 @@ static bool mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
 	if (!amdgpu_sriov_vf(adev)) {
 		/* clear page fault status and address */
 		WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
-			 regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+			 regVM_L2_PROTECTION_FAULT_CNTL), 1, ~1);
 	}
 
 	return fed;
-- 
2.17.1

