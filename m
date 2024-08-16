Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FE3C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 22:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D8610E85B;
	Fri, 16 Aug 2024 22:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="19QqaRqX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D380610E85C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 22:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsGVs5teyO9rzG5ZMR7/n8lI1s84I5g4tJCTkzPEcK4oymw5py4PkdU7Iz+Zfy1dpTUrpnHMFQBMWpqQHOBmdIy6Ocw26mGSosA7zpiMrIOmHDPCrREu188Wi8qqIK3a+e8x82aasyyRX02NCXAu8kzgFXRQeV7lZZ4xxHoGuPJ673QR1AsY1R5s9cOWKWEX7e79TisVNFKZSrqOCWiv+RtxBfFB1iG8ZCxXmps0nnqmhJ2Vy4PeKOVfs8HIyob45Zo2GdGF4kx4lItRLifAt06MPVYF/rQlIfUEaKIr7/6EVr1If4ux3u4eI/IdcpbcbbP//Pb7Iv31DL9nLkxofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/kYMghmYSCWR39SfzRGfvZolGTxh1PRUI49Q4FnE9U=;
 b=A4063ounGj7hIuHclUYHpLQZDjHVHz+GqKWy5xIvtH+A5NMYupx29de/xaG6vIPrjZDGybAqCKFWsdl1bcAAusGH0KcYlJ9gQZjd6nwoaYC2eZbisgqmq//p3fzsaH1NJrGXUQlc9JKvMLuWsk6qdDswaWZIyMk6nyWYZByscvm4+5cTY8vVQsL01Hj4szT/FKC3MKxO94xO5bavGvLuhUbopLkOJK1ytni1FAh+I3lQcWxgDiqrhG95OXRGsllYfu+qmabguAAU+iZj8tpV84llJHbVf+yIy58qwkT3APe2qpeCwIQFTOYlBTxu2IFsy2em+RBdbrjz88/aiLR2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/kYMghmYSCWR39SfzRGfvZolGTxh1PRUI49Q4FnE9U=;
 b=19QqaRqXp9XBfCcExrd/QLweH0GGPQ4TwLj9K/MHNU6O8fm7lm9hhYFLHWPSFRZnn2Kh6bxeck/Qe4WiAIO9rcTPHIpyO12sojHruwrLIiCtfLlS4KDwfYjw9xIb5wSXS58v16vKKaaTV+zyJZ4zP7tq7+qa4aafiU098kfUBlA=
Received: from PH7P220CA0152.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::10)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 22:58:16 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::bb) by PH7P220CA0152.outlook.office365.com
 (2603:10b6:510:33b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 22:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 22:58:16 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 17:58:15 -0500
From: <sunpeng.li@amd.com>
To: <chiahsuan.chung@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 5/5] drm/amd/display: Default to DMUB_IPS_DISABLE_DYNAMIC
Date: Fri, 16 Aug 2024 18:57:54 -0400
Message-ID: <20240816225754.156098-5-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816225754.156098-1-sunpeng.li@amd.com>
References: <20240816225754.156098-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a9d1d8-a6b9-4f2a-982e-08dcbe46ea2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qbq/rf+0GCF8e4iX1jJ37a4l+JYggKsik5zsWHxw+BmY4U1kJup6MUxITKQz?=
 =?us-ascii?Q?kYlBfuvUKA4xoDJXFgUvdjK8SxAjPtgXUnwgJdBsCjPceTNFU3DepxujrWu+?=
 =?us-ascii?Q?qz+j9Tl3o3UAcEnn1kIrFqEnoixJSZ3EnqQaIOhITQ0K4luW2lVZzd5Oec1r?=
 =?us-ascii?Q?sjlvpuC8OQZHyOftdTxig6LZBvsCnA7KEMoQzOhcS9XpxGvGRd46kuL7TV70?=
 =?us-ascii?Q?AL98RipVgto9vSu6NTPhBpwzJvsvh/7vYiKvJro76p8tZNLYntlZ9yHHWQTJ?=
 =?us-ascii?Q?qGnlejbTb8B6wSYUjfnxNiGDdO5OcEcy5VhNXzJcl8jj93n2nl13vmsq/bWn?=
 =?us-ascii?Q?HlwZdc61TgrsMHLW5LwOGEEzvyPL19okNvHHPssdXr11t0fqp3yaYQXRilmN?=
 =?us-ascii?Q?xQYDBnzaXf4q65yJ9eWpwZqDvz4UsXlS5Nvr8x6evX9kwCF84I/p3wrK7P5M?=
 =?us-ascii?Q?RfI/TEjBZ4ctoAJ/Fn3eOLCsnE7vI4NJFlnyGJ6+yHip3DGthFVabukW59vT?=
 =?us-ascii?Q?UKK1I1Ov3dtDQ+PcdvUjGrd1TY7porP7IDcN4MtQzm+RnZ4JhZpFkFKD28m9?=
 =?us-ascii?Q?QrxozPWfqXmXbzZeFn/vsuNoafCyJI9aguEEiyYMQDawM2e5dHsfLWjj3IqM?=
 =?us-ascii?Q?8OrFTLhVvw3ur7DGuCAhqoFYrSWBuC8SqkEDAFVv3QRn/eQt1o2n63GPpbVX?=
 =?us-ascii?Q?5AZTe/ubzIlrRb9fcVeYFlgzytaiYs1DIyss9N7m2w42TJQbFzsHP6kx02O+?=
 =?us-ascii?Q?9v712hHFx0mZ8U4m1fqpogqJWv0kTmhyhlSsDBXwypkPXF90aE9nEziy6pk9?=
 =?us-ascii?Q?Kf6rlj1PVZKff7am9S7D89xBN7riDxQpdMylC395Thtbp7TxY6ORhNspTBY9?=
 =?us-ascii?Q?a/R/BBUsi3KyxOR/9mitPhIaABt0tMUZkxX+K0WdyjBZJI3H7TYDC+sTtHmh?=
 =?us-ascii?Q?YcTsZ4p8GqyT0Yr39dbakPFhVTLAFn9SGTFZHoISM2RZch6Yjzo5qwU3sQYR?=
 =?us-ascii?Q?x84g3DLKIukGJICXkQJtIqgpL9KC/WLaWBZ7a5F+tB/lRl4uQowsXHGG96Wj?=
 =?us-ascii?Q?9084OMsGxNSU6IbR1LPBCCRZSdRwNK6KUREmIBjeYiwYpayWC2FL5Bpyu+L7?=
 =?us-ascii?Q?AHerkLZzOUGM1QvlnwkZR+2uLQML2ovhviYbzbocgNmXitF2GhfkGpPcys4N?=
 =?us-ascii?Q?0cIetis+AhpKczjY2fpnjk2SrWFKmgxTWeWOUnAJh42CVRFdTM/bCcExRi3W?=
 =?us-ascii?Q?+6CL+LBGO9Mpn5kRH1ITtobbkDF11scN2SZPCCSKcNX34gzg/5YYwqh/dGEp?=
 =?us-ascii?Q?a+b/lNHKtYSIr26GYmsx4MDlSU/D4JIHhtRNprMZEqkjUZakviVnEKR4O4Xi?=
 =?us-ascii?Q?Ze6sUma4QewR/tiheRuZ8TW9Kq2Ixl8+jnYp9R6G0oH6OkPS8TnDx3P+JIvN?=
 =?us-ascii?Q?akYiqmum3KStMeF2LWeuYYoG04OsAIYC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:58:16.4493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a9d1d8-a6b9-4f2a-982e-08dcbe46ea2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

There are currently known backlight and abm issues when IPS is enabled
on DCN35.

While the issues are being ironed out, let's default to
IPS_DISABLE_DYNAMIC so users will not experience hangs. When the issues
are resolved, this patch should be reverted.

[How]

Set the default IPS config to DMUB_IPS_DISABLE_DYNAMIC

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f9b5966746c73..b1794ced82172 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1907,7 +1907,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
 		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 	else
-		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
+		init_data.flags.disable_ips = DMUB_IPS_DISABLE_DYNAMIC;
 
 	init_data.flags.disable_ips_in_vpb = 0;
 
-- 
2.46.0

