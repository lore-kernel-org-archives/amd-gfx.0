Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EBAC54EE3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E772A10EAAC;
	Wed, 21 May 2025 15:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+4MDslF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C29710E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Chhw547XeGvcj6pGZfWr/vocmF+kL1O7tH14eD3b9G7S2rliDZ0lEZp5ngT+QVjIaXPhKs3rSZub3dr4E+S46vxafUxQScDjZUk59ZKMftJxhwLeiwTupSe5936Vu2zXxCr1yAXaw53lPn96A+kOqOGvhUBU4IAIOpH0Ra2KPs2qTcE1cQncvPhX8nlrT97cPgD072fkzJeoSiy/fDBciE+JxyoFUFvHoDacuRiKOx7iv+AyZPfiGpL5oFxDfmXnnT3ErKOX3UojxgpIhQJNImrMQaZlO8u+kacuG4aisfq6LiHvkRPjHqfYyQjx53wlsucKRseC2MLppVWC0nOdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs0sKwpVKNfA7zpf0zO/cG91hGXwWQRsMxZHvzmqmyc=;
 b=GaeVNXzWqzJCTz/28XnfLVu6wPaWxavmYkYpwJbfgCNcCwyw5ftx8Ibbqv/jwu1o4WHfNgv+PW3wH3RT9V14+1LBX4N9dPyhSajHuE1j7M6QfXEERKkFJNj+BrlMW6TTWEEi8RijY+KVD7DcQ24dauYKaNuJzLNFsK6YeVwnbXPVnzG+3PIxgT1t0SQJu/u8nyAOfEFDOqeslmKo4w92M++hjTS77TYtTEaW+R5jW9NrYEjRBLl/M7Ijj0q/9+PDILjJR+94/qlmoC2wLplhTZf8JsivtZwx8AKoQHvaSbTb0ufI/6/NdSaqh9VOrOupbqrnwYuwvxtsqM3iqqEAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs0sKwpVKNfA7zpf0zO/cG91hGXwWQRsMxZHvzmqmyc=;
 b=T+4MDslFOnIzu9r436jAuMpujIWVENHL3BZNZrOA/pOVqnOiqasT4OVucoOcW7XD14v95Yupe6imIbcRbe3ztBOh1UHFXmqYlCNKo7Ip+Rv2y/7tcUtYDgqD/T9DMHt+/rw+uQ0UcX9Ik+MhfBs85ZrtWbAqIiiFQWDxWbCcnq8=
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Wed, 21 May
 2025 15:29:46 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::b6) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.9 via Frontend Transport; Wed,
 21 May 2025 15:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/10] drm/amdgpu/gfx12: enable legacy enforce isolation
Date: Wed, 21 May 2025 11:29:20 -0400
Message-ID: <20250521152923.401945-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cad53f1-6f41-4f8b-e90a-08dd987c5164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mT+GzKU+LXgISRo/US9fCVNs6cxctWSN+M8qVZIl2w8d0isOnWP6oSjy6ti3?=
 =?us-ascii?Q?Qz/gfA/AJkEvk81+SHfV6YZPNT4+7K1cpg/+m6RUBvoIGXwe1sGCBCRJpvqH?=
 =?us-ascii?Q?PUDEY4uwLHA3RWIfZfMIZh/coYCt2JKGf84HAxMSR6f9mNZvoV4Xnn02oGW1?=
 =?us-ascii?Q?9Rqehw90RMxSHemIy17dZb8WfiLZfaLH+86hVPaCi31sWnRvNcJ49m5ccZxC?=
 =?us-ascii?Q?XsbwrkZFavPRNhRh0lY2CJngWh51vDjlC2wbBnNT9rsXFkdYMGmN7SE4ncr1?=
 =?us-ascii?Q?RI2cNGdlcKc4drpilnt3AjQ7qLj36YfA61E3faa3l99hTOX/A3p5tiXW53R4?=
 =?us-ascii?Q?ae0+kQ1ZDWxvUUdF/8Qx9fVQwkW821Kfvqo7WYpzPnd6dVpQ3LFg9Bze5Smq?=
 =?us-ascii?Q?/hpmHiIRiMVvB8LVv50yb/XVUDhICaTFScxn9JGxsIj9J1dlaNLaAdxMsc1w?=
 =?us-ascii?Q?dSonf98KuDNpC0WzY8oxR8redL45tF6DjblE2K6Oo8NTpRG6accsJjuM1t3d?=
 =?us-ascii?Q?hGD4KHB68EcYievk5ufjttDajdSN3w0clpN22dCxnc66OwXGtIo4fw0givtD?=
 =?us-ascii?Q?R6ibt7H22pM5a9YIOERLVrIrAhozoH10cNNQK3HY983DwvUhGrrNpxSr6+vz?=
 =?us-ascii?Q?mWN7AwFZySB8qHuSwJ07kEUCVoXWjbIA4Y8in7YSRMgWpGnbVujzWc2/8nSe?=
 =?us-ascii?Q?funYUF2ePRjAt8nDEAa782alWljR8W30FF1YQaLOAghrf5bQQ7q0KoBIKlGH?=
 =?us-ascii?Q?foI1VRt2aLYQfRuskqU69ckYyFoFUbs+xk7Rj0JLx38QWxrYhVKmDmTbWuzc?=
 =?us-ascii?Q?AiyP3yLVJ+Ge55Ul7dv3ZRNsGfEwpTFhlhOXgcJqR2TxsBOxys+ZdRAA/mGS?=
 =?us-ascii?Q?AQg3cKn0e32rxUSftN/ytalJqTvmnlUUawnx075ONpu07VENfjWqFSeOV68+?=
 =?us-ascii?Q?KywkX3CprGJhPC8vnnaZiOAgyQk8krzW0MwU16XqbBa6TwKjdautEwPRvPof?=
 =?us-ascii?Q?AjAt6+J8OKyX1TrCaYcQ+IaBIp9EtDDPKiCP8hUePO19IDWp9lRVe/Zl+Xgr?=
 =?us-ascii?Q?hvk0BCyJNb/cc3bVSwtadpUfFFxgGZvIKEXQK8XRbWQt1+k33wD4+VEKdPxP?=
 =?us-ascii?Q?BKxGUNfi+SMOqXGvZlVo2aFozUuLkf57cOvwendJanAGwbQWNy2cejIQgMp+?=
 =?us-ascii?Q?iuKWJXkyt/CbfPNB1XQFIrtgCLrnvVmx4/2LfGzmk99fsMJ/a9sqog6JCo7Y?=
 =?us-ascii?Q?0iheeaNxFV8mJ7TRio7w2ABwroAwvcL2+RhmEPZPc6nWu9154+MES9GR63wq?=
 =?us-ascii?Q?Got5rBoTSRTt85e+Q2IayGVarrOzU0Yd5vWRNIaMOLtwafxFUgdyr6eiMC9v?=
 =?us-ascii?Q?885UKKW3wNQ7B19rSLsorsHOb9QreuJ+Rmmb2rPNepJsPWy8RWVrJJWr+guc?=
 =?us-ascii?Q?Hag7g9mmd2hF/Fs4kedeTtRqPMHv3sECzUcUhG74v3v4EaY2HVCO0eTHNPg8?=
 =?us-ascii?Q?6pOOHwKQHtGpGbW41rWzuZhaBkJtQF0ejpHW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:46.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cad53f1-6f41-4f8b-e90a-08dd987c5164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f09d96bfee16d..855aeb7b1a89d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3823,6 +3823,15 @@ static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	if (amdgpu_enforce_isolation == -1) {
+		for (i = 0; i < MAX_XCP; i++) {
+			/* enable legacy mode by default */
+                        adev->enforce_isolation[i] =
+                                AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+		}
+	}
 
 	switch (amdgpu_user_queue) {
 	case -1:
-- 
2.49.0

