Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392B0CA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 13:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1FC10E471;
	Mon, 25 Aug 2025 13:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C1vVfOX5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4DB10E471
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 13:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkLwkL6pn1GQwrHCtyjL+0IkTftSvXWScOKmcgK9INZrj4c2GKmGwyqjFt8M57Qq8jwy1DyvpXSm5yQeVEh0YFeGlDearmKrf7Cr2ajwEetHN+5d2ztm+7QWfdtIZqg5jQgKHjeQIoJznCASmurMXYfgM4u2n39d0C2WVFQTd5FZkXJlI957EjMr7/delww7mj3nldS0p0NEeEhzhlGRiti8W+p1TSNqTXKoCqNxF2zqtA3DCXBejgPvI/owpD6l46hlQPtOKZr5idtpq65pftbzn6Cnhntde8veddvJha58jsoRKcmkvzz8J9cri0MVZnJW336n/chf/iNObiCstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wOrsyYDbbNjAzTWRcWfHXzKOH7iCmyUoyv2AXiCD+0=;
 b=OJf2Pvj6e28jqOuUK5QjiagMRLTn7IPiwfFc//lb53XznLU7HivAsd4WJMBPvGZo7X+UMrzxdBiYpKeVmOVALUSI/POCn6HzS7R1otM8a/iVf2ZaD5Bx91Lv548NDnZIcg9bC8pRxeFJNM+ztGZvxQMsHUWYuwipC8GbQlbTYmnEeCJbQRTRRWel6s/RyJwdLUSFvj7zds2dV2ThORLMA1SXBZQuoySJh9YYjnFvZt7nSb+BdmF6NgCyoHBJ9RklwQC6C5QHYJSfpvzIdr9OV3L28SBPNMNNz8D8t8JEpF8iHv7PL2H1s8OM+BQiiyNh+BBE+pfd8Dth8zILkomRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wOrsyYDbbNjAzTWRcWfHXzKOH7iCmyUoyv2AXiCD+0=;
 b=C1vVfOX5ss3l3Mr192qQnnWlXFyeg4//WNj9gPt+ztEe4plUBXZ9JVZhNXP0IoigKEVYADzS1Kpzed6sUypDZPuyK6HNZFWefFBPyahiBDD2J/OQywRwqrFhDJejsl35sBNI+VwCfDLBod6eSnjI7jFM5XhuhAJ3Axrpqls7MT4=
Received: from DM6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:5:bc::49) by
 SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.16; Mon, 25 Aug 2025 13:37:59 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:bc:cafe::f3) by DM6PR13CA0036.outlook.office365.com
 (2603:10b6:5:bc::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Mon,
 25 Aug 2025 13:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Mon, 25 Aug 2025 13:37:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 08:37:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vpe: cancel delayed work in hw_fini
Date: Mon, 25 Aug 2025 09:37:42 -0400
Message-ID: <20250825133742.1494754-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: d55f08b9-1ede-4ab6-5adf-08dde3dc9adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I3luV8MFnyYbtti9oihrCIrRcbde96qYl0vGvu6LNrerpsCZm6k1JwqwYTxv?=
 =?us-ascii?Q?DU6GWYAf/RPD8eundlARfyZ5upGcu6Rn631phOI1gQjxAE3Uh8b/OidBwGEd?=
 =?us-ascii?Q?7ejDH1C1OcWmF3i26O4MWKBk39FhQsZnEdofPmx8uV2en+6Piwe8k4SdpfOD?=
 =?us-ascii?Q?Pf2I6GbpwOI5YNH57wtTqr3TB/cAw2ZDx1QLnVkKfV/8VuueRJm+Czc6K7Kz?=
 =?us-ascii?Q?V4zUld0Jhd83NRysnkbb5SZOn6fwXW11/HmPzmgC2aTr4riHQUUANBK2NdHF?=
 =?us-ascii?Q?+Ddzpwedwjo2+EjEfs0hU2xntLYSE35g+1CYSq2xzuVyuttbKLNDKR61k88+?=
 =?us-ascii?Q?5x2JtqybaPCEV0++vixgXazhbyDna4RRn6wHUUg87kCgyqCTt5bk0jWOz1oI?=
 =?us-ascii?Q?YnX1qH0ibgEXGywIEEsXWhj9zkDNILQywUUWbI38pUPhqkYM/9NUk0yqQMHr?=
 =?us-ascii?Q?2MDvP/zP1KMEeMrZasSuArnGjqj0dzun/v7xN8E+eMQ4gSsgToPoRvqMQhwU?=
 =?us-ascii?Q?HnwgwXYd8G6VhKCsuEiiEiJZk4rlHg2+c1nnx3fwDHJe6JtlDHWxMseRwHR/?=
 =?us-ascii?Q?Q7ekvSvSCvrP8Bpv5YAT5/oPPqv/tNMMmpz1XbPiwM9IrQOmwhcRUd0K1xnl?=
 =?us-ascii?Q?KjrknP0FW32fXwQoRfaev4uX8U4GM41Vv9hzM6owH35J6JoC75bFciMaudxE?=
 =?us-ascii?Q?3CiBudctutiAd1NyIK9SdBpzOi8GhbqiomKgItayGrqmjGdftwyll0CpszSb?=
 =?us-ascii?Q?8b2am9ElVrOY+Xj2TC3fcWz/z5qXSF6NQoJhNU1H6lgFERNmCjD0zwHXC0de?=
 =?us-ascii?Q?BSudSnOSuLg4E2e3WuWEZRu2C4XP9yvD/wXz4FV6W+gPLlT8ZhpJHB1q/4zd?=
 =?us-ascii?Q?frWAo35nA6hy/fiDQzoQkuL0NZ+tn3ArVZyip+IHiAqD6H0E/zLrupaHFn/S?=
 =?us-ascii?Q?aIOOm1p0riyYYXs2Nm3Yc4Tlpx5NMjY2islh1EwxgGY/L6C0jIH5abPFAoTM?=
 =?us-ascii?Q?E4Esz8K7AdDstAYjbdG+qTyOd6OC63VfwE+P+Ehkb4kdaD9IMLWIOPpvHY9K?=
 =?us-ascii?Q?Guy0VkSHA1eNP8eWlBaYpnnUkluVXGV5MSMyWWXSgOIa0U3Qfv1YYoHh+g4g?=
 =?us-ascii?Q?wfHMlwvcloXXTTiF10ZaYwvtJnRc5sL3KfawfXYiGRtCWcNET2kRkjyk/QxC?=
 =?us-ascii?Q?68USGxY0YYAJK+B21nmos9CVytkYDxhH9Gk6RS31PnCA5PJ8mlMu4QxVFbdJ?=
 =?us-ascii?Q?kvv2ZHnULc7f9g9c+psJ6z11xQ1fVOAf+hfZlg/YX5MWiP8sruUwfYajO5Vu?=
 =?us-ascii?Q?0mmS3h4IOLcunE2CJb5CMpYfNfiagBLw0GVa2qJBRjCzm3Ki+1ltUxt/bXKo?=
 =?us-ascii?Q?iKw68UrwwkGxbEDfQADwN+qPpk+dwSQTEYt6FJjirBDeLWDFzcTY0xk0hByd?=
 =?us-ascii?Q?ZNFBdso+/ZNBmEhOiPLfhOTm8X6FtgBC1SA8tz7L+WWMu3MIGjcw8/0WiqLo?=
 =?us-ascii?Q?38LWdF8AM06idul73yFhSHqvK8rtBpuJCaU+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:37:58.6561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55f08b9-1ede-4ab6-5adf-08dde3dc9adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

We need to cancel any outstanding work at both suspend
and driver teardown. Move the cancel to hw_fini which
gets called in both cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 86573c8d9b91e..474bfe36c0c2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -436,6 +436,8 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vpe *vpe = &adev->vpe;
 
+	cancel_delayed_work_sync(&adev->vpe.idle_work);
+
 	vpe_ring_stop(vpe);
 
 	/* Power off VPE */
@@ -446,10 +448,6 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int vpe_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-
-	cancel_delayed_work_sync(&adev->vpe.idle_work);
-
 	return vpe_hw_fini(ip_block);
 }
 
-- 
2.51.0

