Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9B1CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 05:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F9210E009;
	Mon, 17 Nov 2025 05:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qnwq1Oqi";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359D110E009
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 05:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZrgd2u6N69kxBcAN8EGN/4UwAzQTE8SqJ2JnzxZYrezVBtVZSELOhQbfX9kepNrH9Zseho8oVsiR0dorGMmlcAPrfniYoHU1smrtnCX5NWeQyf8xci4wgL2Yl7opjaDRjwiiw+2DRy6PKeutsJexIM85KhJZUOxa9HHaApSmqYo03FIlUz4QiL0F4U3eBFiRbbBqkq/jq78wxuA0uOw8XR71gNL2GgjzcZVmzscWX9l1eOFNlggcqzqLU/5fyYrpe8N1fr81UCW5yMYApGg/DSujzfe+EkmRGnp9nJJUf43AjSwT2EKp8irqvTRkPmmwYhHDs4B/1+DmVw3GfXYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9Kr2OCf/5MBwhlzWgbGOU8IcFPRnBmqEmUP9GpPajE=;
 b=igHwGhcvGNyCKo1badPfOOIAA1n6RCmu1JlG2exejD5d0XJx+YcicWe3LwwtxFR5OoY2xbR1bkat2V6sHZQaLkmss8Mnqo+Po0tQScIdnZ6FGCAGhxFPVdgQP26wG2pU+Wp5+eAIm+oXozuVQDjPbukSXXe7KoKIfshiVM7Wxcey85TuCM5D8FNPsX/q+hl9fwV3V+domZjxqHCQVVz4MmudFHWr2TK7fsS3nnGS40fAjqFjXe7PfxUWjmjUGkrqt+zOLThHEc65raeIVB4q9ODNlz86X+CwVa9SUgrNX0etqTOhYgfA63nTChryhtmpjrCcCGNGyoYce0jk1JxXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9Kr2OCf/5MBwhlzWgbGOU8IcFPRnBmqEmUP9GpPajE=;
 b=Qnwq1Oqi7e4sl5QoVN88aCTH2aXVFiN9GXjpRfk4x9SQK0X5Yxd/39He8p79BWrTKvgdktCEh4VOMMErj5Ct/ZR9UiDM2Oulv4q4qe7tMoXArLf07Ic+iwW4bxs/eg37yNt8XzYn7V26A7zaw7fgv75EObA5smjz/Gm3kfLomJ4=
Received: from CH2PR07CA0026.namprd07.prod.outlook.com (2603:10b6:610:20::39)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 05:04:15 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::27) by CH2PR07CA0026.outlook.office365.com
 (2603:10b6:610:20::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 05:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 05:04:15 +0000
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 16 Nov 2025 21:04:13 -0800
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: Yifan Zha <Yifan.Zha@amd.com>
Subject: [PATCH v2] drm/amdgpu: Skip emit de meta data on gfx11 with rs64
 enabled
Date: Mon, 17 Nov 2025 13:03:12 +0800
Message-ID: <20251117050310.255283-3-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c946776-fa9b-4c72-e39c-08de2596c13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ezd+Z79XMSbSIFn5GohsaPL5Ee/kjYcWwusAnvN/2EcV/HohcMrsTpAaewbJ?=
 =?us-ascii?Q?f2kQX+HttHKALELbVl/BlxVLb+aRSnJeRwnz2Ro382WT0TVn2SJ7+20VypNE?=
 =?us-ascii?Q?YlmGNKoUa/qogddI7DGIdXQLJRKJUkEzdd8jJxsgeQsZldVPQa3jHEfTY//o?=
 =?us-ascii?Q?Ogzz6c8YBUZ+8OcvjxZESZySplpLoO5ZdMMEsKegX13kD21Xq8oPkxg8CBnd?=
 =?us-ascii?Q?iiHeeWa9Jv5sXOhQ6qV1ZyZQbUjy3kqoPFY5GH/R6oZiX12EToYmmJWJlvyj?=
 =?us-ascii?Q?BwGdC4MTD9MVZy8Rqwy/MBXwWFjxvjeb5r9SLxC1v7W9H6ma9rUzFrDjfZMm?=
 =?us-ascii?Q?0fvZ9mMcLjZTIZDYJdDSHgC8ayZOFuFMdQL7CUNy/tb3Tjyd3nT3E95yG7sM?=
 =?us-ascii?Q?ABTAZ81avSat8dZtnq0QRIDRGMKCuREJYwDyvF29fTiwg2wVZv+pMZBP0G66?=
 =?us-ascii?Q?cF1O5wV/8osdr56oXw73vnaYCz/RZhLNdePJ0ztgqt0eKcLY9ilV1JnroALg?=
 =?us-ascii?Q?BxKOFV/AURaAA2Df6mdkPuYXXyMA+Y/WyDiBWL9nEvI9/esFejzl90BM331E?=
 =?us-ascii?Q?FRXkVyTRXmYB5YEYXH3t9AqCUjcFFwDdfaOKlU7C+977f3jvwAWlNpexnTfr?=
 =?us-ascii?Q?C6qzc98tuZqq6maTMC16wXvdmaJe73SpIMKg5Jnt3XL5DEih3D2XXt0KvdBC?=
 =?us-ascii?Q?3AGb+MTRFg00Y1SWF0a8P72yJf8ur+0G53x53bPwpSVqBqY+6QUeqPZr7Sbk?=
 =?us-ascii?Q?L++Es3TeNM9AMx5KOjxi+mnzIUKaIrsIo+jUwm2ewf8BuHpUMD+VBfr2v0N1?=
 =?us-ascii?Q?MQ4RsQZOhrAvXhzy6mHeGom5RypaTwDrbsqc6Ze3Hz6w4Ra2urKhHHYG5TCZ?=
 =?us-ascii?Q?Ctgyz1edFPgRNx4Cc9xX+gxAQnQmr/t/8J94B/PL0xcbYRqXp8nyT5VWEbRr?=
 =?us-ascii?Q?hFysyLsxIZWSZ9FCB7OOOJfzejGXV0lFQzJMClQbYsvXAUVqL8fk7krMyg/0?=
 =?us-ascii?Q?QNVeo6NBJ2L7XKKWIi19Kb9PQl+LqwZs9HqpiqLS1xI/8mnDilFpE9aYW4gy?=
 =?us-ascii?Q?Hc153xr9wqqxx/VkbAe8YfH8DwJjaWvjo8pEaMcWf9H0dYoHFwkR4RncHZ4J?=
 =?us-ascii?Q?KWEhRy6zHqcJxgjTmbMBL0tfkPBCkkcZd+k5Y4Soc0QwYUkaPd0lx/WJ5FWx?=
 =?us-ascii?Q?ibjrEgWZo+hFiAzZdJuBoghZR5TU5vZUzuiuyrnBmZM8jtFmUXguasDEmzE5?=
 =?us-ascii?Q?3nBAQJzx4R9QQzTSe1DMiB/7AWUk3gpZirHp5PSUBWJl7K6KYoa8hxSb5He/?=
 =?us-ascii?Q?cnLfhf4zYTrxFDAYSKz/x5vKLBkLanlTuexs7oqwlPXPb7L31dJMSGTOHi8Q?=
 =?us-ascii?Q?C92j5iw3Qi/KSi0cugXNtfYHS6B+JB0sLpZ4dcO2UQO417djMgpQ1qoL/ZLg?=
 =?us-ascii?Q?nZTIy4ycHsQJvajE0Fnb8PQ+eKtgVpRurP33EghQK1O6WZSd4ASewxhvfdX9?=
 =?us-ascii?Q?sfdSXPXmttf64U+mf327NpMWsLchhsXMK2Y3D3XZOo9U3AQ9LWaO7Sao4lBL?=
 =?us-ascii?Q?fmT9bEfTEW8zvvePuoM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 05:04:15.0241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c946776-fa9b-4c72-e39c-08de2596c13d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
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

[Why]
Accoreding to CP updated to RS64 on gfx11,
WRITE_DATA with PREEMPTION_META_MEMORY(dst_sel=8) is illegal for CP FW.
That packet is used for MCBP on F32 based system.
So it would lead to incorrect GRBM write and FW is not handling that
extra case correctly.

[How]
With gfx11 rs64 enabled, skip emit de meta data.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 02d7cfae22bd..8a2ee2de390f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5874,9 +5874,9 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 		if (flags & AMDGPU_IB_PREEMPTED)
 			control |= INDIRECT_BUFFER_PRE_RESUME(1);
 
-		if (vmid)
+		if (vmid && !ring->adev->gfx.rs64_enable)
 			gfx_v11_0_ring_emit_de_meta(ring,
-				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
+				!amdgpu_sriov_vf(ring->adev) && (flags & AMDGPU_IB_PREEMPTED));
 	}
 
 	amdgpu_ring_write(ring, header);
-- 
2.43.0

