Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A655C83F25
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 07:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0182F10E768;
	Wed, 23 Jul 2025 07:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BPBnr/uF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957F910E768
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 07:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbpxzD+e89f9Nf94mvd8WIUD+1uFxM0RT+usgeTlZYF2amAYBaOiajzFG6gfoE1Td+DDPd+H/EgMA8b+pE4mQ9Xi2RqffSFPd28AEbIyKlwYMuNJIXBq/Q0Xn+eKVsLZU9IAGUYvBJsUvL+r0EltCiwr++EvCAtmTc64ogiwx/43ilURPodiyb5qrUYH26mlvHfFlEZq8aTZGMfTkhcEHZ4iLd0r0sVLzflAk1r4adDcQuUAe1ABEa2aBobuHd614tLy7satbRQLUoXSBOf7XTXKknXQYOS/qh7qU1muypDJSdsXZ7SHvuT6sYFk5hMRD1Z1SIEcXqh2CAqbLyNCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdudeKCGDNnmolIwnGenLQarAD/sKvtlG60NOV3x6uE=;
 b=W1XbyzEkVSGep7Ayh2ad22b2pk0vBRjVP+uFWhOXrDdn03CcD8PFv3B+JO4MGhoINdKox5rfUec1qy1tA33ZYAVTvaF7m1f3fRAJrD7Z2E3uGU/54AXzYb5x8ae/l0YjfAEaYrnQXKuRjt8TfC2BpBxw7tGPrDn/1JzUUkdL36m5J9o6zDxhF/VeMrS9/FAehN565c0hB0E66Wd0k8bBU1HtSiRclqWBBbbPO16FwFQBNEscbJywAe9YOIjkB+kp8md5x7WrUy85q6AGW/IxLP3EaZlr6ye6TubzvWiIuT0/GrflBWweNPgx3NM0/7pf0vIQCeQZlmlIXVvQmvDSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdudeKCGDNnmolIwnGenLQarAD/sKvtlG60NOV3x6uE=;
 b=BPBnr/uFPiJjQOAbhQoZu2GIljcnDduyeIoMIajib8czAhs+O0VIQMCGMA4qbc1P+IKsWTZhC1Od/j2Wx8xzYb6I6HCGgHYtL6LM1XlPyJNSk5yHaqIQwcaf9HTcYqTnI8ZIKl5I8yRTzQVRPh7Bj0Kn6TZzK4dh396v+h/jggw=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 07:38:45 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::41) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 07:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 07:38:44 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 02:38:41 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add critical address check for bad page
 retirement
Date: Wed, 23 Jul 2025 15:38:02 +0800
Message-ID: <20250723073802.1844148-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723073802.1844148-1-YiPeng.Chai@amd.com>
References: <20250723073802.1844148-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0f3afa-8459-443f-0674-08ddc9bbf42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ay2E2isaaI9JormUC956o4ulRKYGC6L2bhoiXxzd57h/P61bY8nQ4JG8bezc?=
 =?us-ascii?Q?8WjVlF6HMgMxWLZKKkGE9cBBK+IygN7//ioFA0e01Ty60RdUQku62/s4c5fZ?=
 =?us-ascii?Q?N3dHx7qIiGsOpbBHOamAaMH6TiPFmDMieDHA58fK39EOSp+Yard+VVmtDS3+?=
 =?us-ascii?Q?YirKfp9JBHfLm7dqDwSsFQO6fCjIqXzUCUAxsERxo+DXPgbbcSSNN8V8txym?=
 =?us-ascii?Q?779fdjC/2XVK4Okc0HwuBLpiGSDFKnUFNXDOYrunAs829d9isV5/WEQ6aE9U?=
 =?us-ascii?Q?GIlJkO67VZngi22FvWngQyh/Sq0VRDRTb1kLv6bp/HDJJtLLJ98f9dNDvLK3?=
 =?us-ascii?Q?KwI7/N1+mBDoloXpEoKfmVs3puyFeodv629AFReyI8X94x1tZpOA4b8DDwQt?=
 =?us-ascii?Q?q3kmKSAEiAk0yaMSzbMTPt8+laPVLjmEpy0wdqjnkjEEYnmTKdVWJJVnkvoa?=
 =?us-ascii?Q?u12N4ptOvOOae6uZulTB/nvIAACNWmrOznUNBBHov3NrEQusp1c2ShEz8xZ5?=
 =?us-ascii?Q?D3AVnhTt6oex83L9izEcblYcIedA+Ir/uLm5i1cwUA7KPvnZGnOjecSaJT2b?=
 =?us-ascii?Q?fBdYdeAyKJyJ3cBZ3xyugICSdqWMJyw2rCtEAhizNo4aY6vRCMFSCDq7HRw+?=
 =?us-ascii?Q?RBW9aFyiDotEUDddXuZQuurvXK0oancpgaorCuYRQNN/cNAXm2bVhTWXvaFS?=
 =?us-ascii?Q?q+nKrHQ1lXqZYhS0zXQwXHJ6CKjVhOktuzHiaiHNrKdlulImYT+HWI+src76?=
 =?us-ascii?Q?bh6YQfaXc0XIX7H9zE830WAUJlBBreZjtTbFEYlnLvD3YOCo4R8KkXcifwQY?=
 =?us-ascii?Q?N/sWm+lWviHNDhRymjlEgy3on6DmAbuYYtfNKjMMPwJKvfQIVNI9OJIwpJzO?=
 =?us-ascii?Q?hBQaBt4Na21o29N2qLT8oiQ2oAvdP1FA53Bu6s0vPGa17Kk98+v7gIhv+0HG?=
 =?us-ascii?Q?yaP60oamBX78Ikvc4bYrSQiJwbZRuLdnZw0ebzhFcz9QwycZinyi8DWdBxvm?=
 =?us-ascii?Q?xop94DTSmSgcCNYYlMPzfbUYJfmS8mRnW1hJoi8e7//YCiez7TZUPPQkebA5?=
 =?us-ascii?Q?7dcutSDEDIekrKahVskN2yEF+Jk3/9I284W4AakbcjlxMIAcpORnWtpk8QPF?=
 =?us-ascii?Q?Z1zm+AVCmEvvgeQuepuaxafIP81HhJQX2wUbuLVuGuVKNNkKW64WXOgDu/UO?=
 =?us-ascii?Q?z6vfwqoY6sXzpu8q7KkSv7rp9ohm40Dwke6YWHlY4c/u6ivtG5HmQ0/M5xLf?=
 =?us-ascii?Q?DX9OI60fxSUrcLBOGK90PqTMmziOSqMwl2CIJDXKvut1hCcGees+Nu3VgqXX?=
 =?us-ascii?Q?Do4grjULBOQsKnHI4TEj/aRtwSnLR780tmVEJg7FlL0vpc7zB2VR5Rd9WL4/?=
 =?us-ascii?Q?8AQkWIXgFBWM+SONXmnwp35BEaUQixOEOXs6eEpr1c8AaBSSU0EjejgQgfvg?=
 =?us-ascii?Q?f//Vnw3rxCSD1S6agsmPSCiL5YP0Z6t+SHFoSpIqaVHuAzWOnVKkBOASOHdF?=
 =?us-ascii?Q?5WF3/ab6sceU978TkC07U/MKTrhrrpeJ6blS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:38:44.8476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0f3afa-8459-443f-0674-08ddc9bbf42f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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

Add critical address check for bad page retirement.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0ad3a9eedfd2..a1062b23d0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2660,6 +2660,11 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
+
+		if (amdgpu_ras_check_critical_address(adev,
+			data->bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+			continue;
+
 		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
 				data->bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT);
 		if (status == -EBUSY)
@@ -5406,6 +5411,9 @@ int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn)
 	uint64_t start = pfn << AMDGPU_GPU_PAGE_SHIFT;
 	int ret = 0;
 
+	if (amdgpu_ras_check_critical_address(adev, start))
+		return 0;
+
 	mutex_lock(&con->page_rsv_lock);
 	ret = amdgpu_vram_mgr_query_page_status(mgr, start);
 	if (ret == -ENOENT)
-- 
2.34.1

