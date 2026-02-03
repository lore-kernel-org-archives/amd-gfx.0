Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A64DE8784E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 17:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BB610E729;
	Tue,  3 Feb 2026 17:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S7w667jg";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F14C010E701
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 17:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvI3D8BCgLuf0dSuInfxHQPgswZISbVULwiQlx5L0tNSiLp0dubKICHRonELshWpEHKsBouUG2Y4Xw3BtkOUn9OteJpHpsclTAhW0VML6VNDxFQAM8JQXNwkFxZ/ECLv21F+B5rY/0fWcZLRCn/TgNjixArY4+h0HFS69JabZM+bUy/R9Iy8QZo19qOIPB7H6PCWabqjfqK6O4nba18IBKjB/rphAW5tDuAuW9qu3FbSZaXuq7t+rBLi6CZPZtmlvaaHnT8V2HON3XCO2ZhZ1m6HKy54CzrZunN/BT8JNFohoCe1mycwZYzS+PONQtgTNXcC6Ad4RiMPhlrQo4QAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYOuHVoGXpyoyYce72HY52kY169joHoHNAkqKU0Y84o=;
 b=J/E4vh4MhFkwZx+yY0J4hDgaEBS+WgZu1V7lXO4U2noA5nvMXOaI0U46MZHZC6OAA8InZNpgsTCn7s0iKOcXE5DFI1Hwimkh5Wt3Fpqyl5PQz/XsmsCQwtr0dd81XF8i2QJ5L+a67qdx55UF1zX0vwT2twGqA3Ctx0S8DXkRZ8RC9UtDy5PmZKV09ikKZblpyQrrArzcCBPE1jmdlLboNGqpGAuTg+ikA/yJ6WIW0nIcI2mF+gutIqf+oGUCqhOwgpT/xbeXXducvzb3jOAyxcN9JSNEUL2W4fBOw/j7SG3W3/SkLejCEGSS/QmKHW+E3WbMJz1Wn9uTToqmqFkQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYOuHVoGXpyoyYce72HY52kY169joHoHNAkqKU0Y84o=;
 b=S7w667jgKYO+CouafV4tCN9rqgbUcWPVKQHkdyqt6BGiRbTeXuDIxRYvptU2pbYZoYB45Hph7owF/O+7Z21gFtTvXyoEFNersrUdQOVx+RQ5zdMdx2zdfM3RXf1AvRDMf1X+PUtcoMsVhTpKS8rIteJyBRacN73DGyOQb1D44jw=
Received: from BY5PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:1e0::35)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 17:05:17 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::60) by BY5PR03CA0025.outlook.office365.com
 (2603:10b6:a03:1e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 17:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 17:05:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:05:16 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:05:16 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 09:05:16 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/sdma5.2: enable queue resets unconditionally
Date: Tue, 3 Feb 2026 12:05:05 -0500
Message-ID: <20260203170506.21205-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203170506.21205-1-alexander.deucher@amd.com>
References: <20260203170506.21205-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 983ff1e3-b4c6-481f-dbe9-08de634667a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6PrVxtvJzM5AypzV+5ozzX+rdrbDNTrnh5Vf/pYbnP8Ht3OmK11kgWCwLoM5?=
 =?us-ascii?Q?3P+5ZHqYFOMpZrHWwn/VKeaUYQh1jg5zlsqi0eCoaBcvY7Na6Kcc1YsqXSWG?=
 =?us-ascii?Q?S0Lj+3++/H+lf+cwZ21DIatZSnTIbqzBuXQEyd0P2Sw4KreExOx0d6jLDWBv?=
 =?us-ascii?Q?QNrY0/AtFJutHnCEjlZaiLpXtchH+VH6fkYwVPmuwC6+aiv/JFc4Flfx00ml?=
 =?us-ascii?Q?gy+IfeTUlVm47Gji0OllRGPL2I2eVbFTihAim7IInJPygODi5aVmJjsKjEHG?=
 =?us-ascii?Q?meRBUsDLR+4gBD54SuinlsALZN/BVa/0ORQkhjeUjfJhxtL3NCQFLm13xpZq?=
 =?us-ascii?Q?NytmH5WZqtt3CeLb58AIc9k7MfjocHIeHkOeuWpzNVdcSGSJhR99vUknoiG/?=
 =?us-ascii?Q?fIIfdZ/yl/fVoErkCmLS8KpKFoX7MevIEK6h6jXBuS4eu2C0P/3ZSdGqSO72?=
 =?us-ascii?Q?iYxdyVSf6EDELJ2AwqmWZHn4FOdrYrenZu2gSBqDTjpCLSByXFCyGjeave8l?=
 =?us-ascii?Q?dPTduFh4lBaMq2GDXJoj20tUyxxKK6Q95Be5/AWY3e7jGQmQxvoQoShTh87p?=
 =?us-ascii?Q?LuJrcWHlsZ1/2ed42qtMpmpJK7uO2stapbsk7U7ZetJz4I/oCafUPhUr9jvn?=
 =?us-ascii?Q?wimi/Taa39d9b5CBhN3NV9AeAKpYAvBSxn/lltqJ4gxztvMHhxZMqrP//JIT?=
 =?us-ascii?Q?0JOC7wE8yFaIahN6tXwYtRZ7zLUzKmzWlIaFMOCaZqfMg8ybzQ3z7qLUJMy6?=
 =?us-ascii?Q?01r1VekDpdmh4QqHj4Y9Y15nDeh7+NqQYmt7OyQF7wlI7Sq6tOvH9/6IBSqJ?=
 =?us-ascii?Q?dd0J9Z7CD81E8bLFWkygJP96eazctCYQUYwKeB0DQ/O4CmAYMMv1x0V50tkM?=
 =?us-ascii?Q?zqHc0lWZdpBt7tuyLv6BfmJSXswYcVqlI1bi9fEq/NnbOBbPUbXJWUpfVM9V?=
 =?us-ascii?Q?RUSb6C5FomJTYXZe9xass8ykyVYbGSNLxWEn2Xm7AGdfZ4Ggmq70JoSQVtnL?=
 =?us-ascii?Q?1mrRdtq9i86o6OD5dKO7D3IuajCc+k/QaBphoG185ioOlQlfeqH7H1yqIcNP?=
 =?us-ascii?Q?W5zYyA+DjG17Yb/GdmcT/9D3ZbCN+JlK5rzzShuXbq8VmkLrVCRkankLC8tg?=
 =?us-ascii?Q?/gA5GKen2ehlWhlHkAtGU5zagmoGZHnc+e5lLZnTsr71oO2jl1UdW4ANI4CJ?=
 =?us-ascii?Q?o3Ojkl8G+Z46CeuQ15UoTMSwBQ2CJfBcTQ+W00n9Ahn+Jwh1C+KQnjmhHR9y?=
 =?us-ascii?Q?4iva2SfOcIGhBludbFrvyXF0sgyxxvm6mwaB5IthHp0tf/V7e4f6fb2M+rLZ?=
 =?us-ascii?Q?1EGCerZhveE/1fXI4grVQ1ZjZibhcSntqqL87zszxgxIcK8MVmmWNU5Np362?=
 =?us-ascii?Q?xk71Hyfflb1FNrZVele9mG/v8c/arZjgvy7mUVxlBJZUr0Ihd8LFIFp/DHb6?=
 =?us-ascii?Q?FS7Bht1aPKwhWy7W+vUkT1D0WPvu3my1dTWqkwxDNHxgB2bowuS+MdLmTQR+?=
 =?us-ascii?Q?oECWbxxE6Q8qWvxvDUSszI8S8XAj4TqHs8fWK1C3i8iRxnzf295ltL9oB48V?=
 =?us-ascii?Q?+MeMf86r1lBesWB0P2NfZwhgSB2Gt6qAwh7c7JvE3m5/AqpQggPJm3pqqqOU?=
 =?us-ascii?Q?XLgM4E4MHIeP5/2oMh7mCgsZL9nw2i8ljO0GuE3qtbmiQizi9/bef91KQS+p?=
 =?us-ascii?Q?uROYrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZeV6u8YYpLjCtjEojImcLyvRxlmhcQ5K7j1PfcUeQgQhghDQCOUCtw46uwdz3YWSBqV2BE9rXucV0zMs5mnDbDPpYX179g2uX5+50MMnFsyKAYbJuqcBuLASxxFLcWzG7GUu4SUneB/lbDt9tev4c979UavwjexKQTAqO+FSyQrb32VS+dalP23eCijuERcr7GzqmrXo6KOW1CePPQkVr9wLHPimhwuiBjItcUBXW+88jwfeF9+ZkhBMy+OL1VfB1aCmQyXHSIVxKgF+IN588oPim8Xu1tonxEaAtdKh5gMecqf1rSMssSPXbt1pWspVKJ13NBjqn6t+9bzkv77GQ/p3qmrzMHkyuKHtNTTGHO/tWPX/amAqvTFmfVcSGEYO2gbXXUCZsOPEFzGRs1mS4g49qg4hf0s7vex3r1PTwJ/YyuXfHM7x/TESLBMMgXyH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:05:16.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 983ff1e3-b4c6-481f-dbe9-08de634667a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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

There is no firmware version dependency.  This also
enables sdma queue resets on all SDMA 5.2.x based
chips.

Fixes: 59fd50b8663b ("drm/amdgpu: Add sysfs interface for sdma reset mask")
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a57fe976cccaf..d607906bf2119 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1346,25 +1346,9 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
-	case IP_VERSION(5, 2, 0):
-	case IP_VERSION(5, 2, 2):
-	case IP_VERSION(5, 2, 3):
-	case IP_VERSION(5, 2, 4):
-		if ((adev->sdma.instance[0].fw_version >= 76) &&
-		    !amdgpu_sriov_vf(adev) &&
-		    !adev->debug_disable_gpu_ring_reset)
-			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-		break;
-	case IP_VERSION(5, 2, 5):
-		if ((adev->sdma.instance[0].fw_version >= 34) &&
-		    !amdgpu_sriov_vf(adev) &&
-		    !adev->debug_disable_gpu_ring_reset)
-			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-		break;
-	default:
-		break;
-	}
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->debug_disable_gpu_ring_reset)
+		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
-- 
2.52.0

