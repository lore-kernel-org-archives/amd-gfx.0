Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A1BC624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3E710EA58;
	Mon, 31 Aug 2026 18:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJeYrh3q";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD1310EA57
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTd6EL1AYMqU4i0iMznCDVduEy6rDUGctRoqQJrTnP9sNIod3Dz1c9nECn8UdpVLbJ31kTiqq7aUCJ3WP6NvowcZfNW7yO/ddv4Ifwj+tcjWmPFu3G+8sMftnOWACXBNP6DPqPSum1zUJNqZDiwMAGdUUJd+wzcImz5wbb0lzOHKvR5MIW+YgWt1rN/qzAiEAGXazapMknoHvCBWWHZbrRz6Yvlo68SYNgAAeXngfdK8O534deRrUcAxsDHPX40HQ0CamUssQW1PiJaY2+0aWN4J1YvLoZ5prIPpY13RHnCuP04R7R9Erb2t8D7Py7W04ljTXWStOdRkhE6TD3qqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbRigKiBU0IfwCSBuYdpKxYPvIkZ/TNKXAUIyE5MEYQ=;
 b=SlYyNza9gXr9odERQCxAP7MQcdEiFaI4v+fZq4T94sZdRGA94+AtKZfCvr0r04FAI4Q76N0n9zQL/FDC0yWcsM8OL7GitvCcGeZ2ixpnVfUEcgke6x8wNBdGrHX354IfWkjm+8TuBFpnhgRVmFst10y1nm16+OVNjp1FhwkoO6z+T8tKNabHZlIS/A5jg7d6mSkdc7uJrQU8n0SS0D2jkhFIbdg1tpYjAqDxFX1VI5qu79cBFcIJ/jUVJtQhJllPlfuwpsVQVdYNC8GmydrdbTHNfz+fVyW63K2FuN8QMDJx6VSlI0vmcmrq8e86+GQOkDT8xU5M08Omr68i4um6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbRigKiBU0IfwCSBuYdpKxYPvIkZ/TNKXAUIyE5MEYQ=;
 b=vJeYrh3qZEcDfLiEMk95929xrf2yILMYwGkf2J3dBZc6QAQJ97+dwTNYK5gxuVsiCIC5gnK2alsPDHKf1qV2xRGZNcbEiWK9vyuB+OHdXV7H1r/wKLFNfR2/6KWIEtlS1s8QVXFEv/0GQIKOj8+a+TK5AWqYtR+ChrzN95NuIDw=
Received: from BN0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:408:ea::29)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:35 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::6f) by BN0PR04CA0084.outlook.office365.com
 (2603:10b6:408:ea::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:20 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 21/95] drm/amdgpu: extend PSP command polling sleep range
Date: Mon, 31 Aug 2026 14:26:40 -0400
Message-ID: <20260831182754.1089811-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: fb599c61-4251-4776-f951-08df078daaf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 22Gbs+loaRyfrXC25upSGhvkXbeO/MXkyblor5EaEyOiiw6ifRMa795yZobKmUwJ0zu+vuBZnXDQtdoW+mLcrajFKeIQLeqzKdkNVZfugdu4Lw9EVUxUeIKwE3fjosW1S8u0EpPrBBp1ymx8z6sUi4QvljheQGck9ir+iwqOz8uRZeO5iHr0q2u91Ms2I2j28D4UY5/g4utHQg5xLTbnir2Yk3cvnQS/lM56S9P/cUiekd0shVbZi1FqUHS796SXjxCRLDXrOXSZj9KuhorjjvbTL39frl+sv7tAq5uWlbooHArkAU9BtiFKD6S9yiqPz213sahZoMBCtjhG/6BTwiO7szZ73i9oQII9e9i8T9RXezgsCQ7gRdJd0ISysArjhXOMQu9ga7cLQje6Dya+Q9RZ9JCBneHwTvCQ7N6r9Cbbw9QEoyNe4doybkbcTjVlJkbkGH6HxsAeuis9K+2fRnVtK4MG5w3u9ILp9J2GzC158kd6jR0mxsYb8LLwNOr08dvTJJs9Z9X4GDSsLCStG3yPfnyq03AEs1jyxTZMMxb8+pqi3zy2c8yaOYjOslq/6D2omjngbEKMT7lpJOhqV5s+R6t39edFXzotyeAwVEmuiHF10vwCgKU3bJ2kRE5Wy1sQZk4ICpvMMLWYL5nTAcf1r/25FWHVz0Wda+c7dW71DhnZ1/dgCaiBtSarx6AL1VLiGLJ4tpaIPXCGlDWlOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pgrmYDvpySb+4/YVP4lZ2BAID15zclozK5/Ds8oBlYKx8hY5oKEDN9H7a5kOHtNROeqn8phrjlTH4zebmQCYZJcw1H37PUC9yREeMg29n4bkmW/7DdGR0x7pp5+EDlP/H2ITkorSQV+sm9b7dqu5VT6rRLzaAYx3ImJcP5qx3q6NuYLWFLD4MjX2h+mrWutspi1atLpil41AKuIoZkVbr3xCjhFdzSSNOk0OHlzhMhZQrRyEd7cb7DVxzWUg5jQHLUKmkK1qJcISbJ3jIQFWSH/5FR7FRPLiim1kqvh4EBtaP70g4TuoYVQHFzwvpuhbyVJtF7MN5gvTUIXvdp3NEPQoVgTAJHWja0NJe1ThJgpkqNu3pZPzcD5XLCIFWfDLJkF9yYKG4X+ep3/ifTa5C1b+GBC+Cztqn4axAGlnuVLzTDBT0DKZQ8PLJulDylC9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:34.9239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb599c61-4251-4776-f951-08df078daaf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
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

From: Le Ma <le.ma@amd.com>

Increase the upper bound of the PSP command polling sleep range to allow
more time for commands such as UAL_SET_STATION_CONFIG to complete before
the next status check.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6a66a90c8e5b3..b8def8b7e1426 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -895,7 +895,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		ras_intr = amdgpu_ras_intr_triggered();
 		if (ras_intr)
 			break;
-		usleep_range(60, 100);
+		usleep_range(60, 150);
 		amdgpu_device_invalidate_hdp(psp->adev, NULL);
 	}
 
-- 
2.55.0

