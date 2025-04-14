Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0029EC3601E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 06:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E91610E2F9;
	Mon, 14 Apr 2025 06:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGi3QNzu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759D310E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 06:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmVWWs8+mSpEhfpUEEG+zSVZgkURtuqpTaAcU/G5F/4RTURIoiV4bpllJVyBrgL42m6EPYavJwAyOfZtngxOib3cGN5AZjlBk2bZ3nXCcpdAwcs1D7Pt5y9cehHt85q1R1p1trI1LKTgrI6Z145rzq7UY8LvDnbIQ2YYeqrWblXVpqTFnTxr0urjINMqii7VYW2f1/ye8Z6sdjOmccD+sHfXSQv9V78qBx47MPakxLn/Brhffnqn6iHnpfMYNAzuwx0x3hULGmmoJxbbNZbjGN3z7Km2M15ZAlp9YmJjx2FZx0SNI0msU9Bu2xCcJ8OobLoPowxaR7Q3cAfKoIijsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzXNUSbXS/+JQ2g3wcYDo5Fa7h8HraPlk6PyJl75464=;
 b=GLF4R7D0RmeRx8w084uHUEjjjT3OwFlQt25wiAx4v8PvVJT062NpFqgr4Iy8GyyT9j3K5EbG9V5HOWhX5n5s4QoFMJsCM63s7KANBXwIVeR6eGz0BPTcnsdz2fFtfNvWgIuFfDJbUyM8Lj0CfSU+9P1fBQn/D6u3Zr52Rd2joCthJAsMN54nOSGk+p0a/U2j2so3ZDrTOO8DZ7haxqPkm2iW5pTB9yJLU2d0ufKqDddBHRTgffEYN3NrLDC2iiPF0pbAsnEOy4PhAYLSHxtl2Oyi6nWEKcfhp0el4esV5RCM3FMQrcc9Fx86pb2f+kcdmqjceSiL+YI4tnMdRw0QWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzXNUSbXS/+JQ2g3wcYDo5Fa7h8HraPlk6PyJl75464=;
 b=hGi3QNzu/YA+PfT/XYJ0tRKCP6MJisZTFoZ16wwWDKGUKR/k9iQxdxyc8VDkPlv++51WH6b+M2aOJ+reo+LCd+0xGxrFsdf5d7kwqb0d99PkzWvbnfy5rOBzpR1mJ38aE4s5X+JIGrmfrEnABfywkTrh7YOxnzBGUdPHYFiVtck=
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Mon, 14 Apr
 2025 06:38:12 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::f2) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Mon,
 14 Apr 2025 06:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 06:38:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 01:38:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 01:38:10 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 01:38:09 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Clear overflow for SRIOV
Date: Mon, 14 Apr 2025 14:38:07 +0800
Message-ID: <20250414063807.1100508-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a9382d-7586-4eed-657b-08dd7b1eed24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XiLyS9JPudp4lchulp4aiP3EzPU11gH9Nxk9LOvIsGB3kGj1sgvgO5HrdtG2?=
 =?us-ascii?Q?wRv6DIJJoLkfStkmzTV/IpvOPSFYhpa+A7Y7kugYCRSWe0m8kbUnHOJ+iWJL?=
 =?us-ascii?Q?fMFgWrM8n/6AX5gmn/vaioEYdroe0O5GOtjfCRYqx5r0oLhfZaWzfc8Lv1LA?=
 =?us-ascii?Q?yP6v6pmPbcclZmOHvukBaS/mf0b5SskXxN/5a+GotJ6AwmxoN6QRDVzesNtX?=
 =?us-ascii?Q?2pAFs+j42ewDCdhmRFe7bJrLvW66U3IioWcmgX9AoT/Yg2GjA4qnQ0fvkZoq?=
 =?us-ascii?Q?hM9FABPz46GdgE5iFfnDHD7QosvB1OsQjxPj9BOqNP8oWQsw27AkI4zl5nsH?=
 =?us-ascii?Q?HZKyokA7fKLDYWVmtXLvUUJ3F1n7+8TQ1ew3RGRqnrZixlrVv5Mv4Lya0jNy?=
 =?us-ascii?Q?EWxqzYnZkdahE2DBLFaBFVmk2A3mVEJdC6jRcd/d/rHFiibX06razcq9OvtL?=
 =?us-ascii?Q?si6m0bIMsv9m115YTEW3OAe4hd2bDloZajCUABn3Sg+CqaobdFrRCWQAymzZ?=
 =?us-ascii?Q?blaJcNNHLLJXX4JTfUpD8/rQ1ctSoBzKtcEJkknCnAw+DYmmTLLZneZZux5z?=
 =?us-ascii?Q?jQzJ4hZln0ruaTe8aJG2xzP/UDYpR8qGC1erJTzHUURej0gCQI01XRgG2CLV?=
 =?us-ascii?Q?knfcgOWtLBYQYUR7zh70DG8SD8/GjH1z/6ZRspCRSH5SLSXtwMpg54fIQC5A?=
 =?us-ascii?Q?bfpDGfeMDI5J73KGxCgTpUT9QTa/7C4NI9k1JegUmA2UVS48ZNbT8BBK+1BT?=
 =?us-ascii?Q?zygpt5+aowzqHe1QBjfqcJ0JWY/w4lqfttgC5kCgGy+nTy+VjNkp4ib62ykO?=
 =?us-ascii?Q?ZPuaSjFoVKEOm0Ye1OrA4YufCCqJzBhwmtTN2ZCIQ6fgzdi2NteSOC92DnCB?=
 =?us-ascii?Q?i4GA2tEmykXHpRD5emDy1pxk1sPLZq84TV8IwZ148KdDRDAV8vCWJVWLgZGg?=
 =?us-ascii?Q?iQle67xxN/nATho2yvG2w3Wko5Pdsubmb6roTaTATHHB/RzpVbI+s1zCdHKf?=
 =?us-ascii?Q?1wvmLPiMImLZ74PG9ASewjPDQC71XCLRUHH4midcZlQYesZ2BUmeORzFr2Jz?=
 =?us-ascii?Q?rFhjzYgJXmKUTMelAxs9ycMz11vEe3QItlhjKyETEKJrgN6TWK7S5KE0rnCD?=
 =?us-ascii?Q?rj+sqsh7C0MwYj38xbdWp557HXYFIE31oPfqk+v0OxKRIhQBvxhsz+RISJCj?=
 =?us-ascii?Q?bNnaPtjRzjVZuC2WZHpYIv1J4rqkCpood5WqrR03eVFgvc177DFXOGtf9FNM?=
 =?us-ascii?Q?UrSXPYfNQ7kGvvmbA34R/zX/vzHZG8nLU1DNX6puzEk4vrAUHutK/NMJ1uTZ?=
 =?us-ascii?Q?OEMtYS8gUkFQJPxVZGmZo2RH/Hwvc4im96Vqy3/GBwySsIWGOtbo5vYZu7WW?=
 =?us-ascii?Q?PazXhypxjCOGc9gpHTJU1wJzrPyU4RSArUS/5V8l1sDzcTtuS9GeDUhnUepS?=
 =?us-ascii?Q?IGTykjNz0jUEJ+9WD203dh0WStcrxnAxGPIgv0iH35O05n+jpCGMnrvEDE/1?=
 =?us-ascii?Q?zLQTBh8JdfErgQhP3WJ3yWJSGQmuLFS+6BbU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:38:11.3518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a9382d-7586-4eed-657b-08dd7b1eed24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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

For VF, it doesn't have the permission to clear overflow, clear the bit
by reset.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 901f8b12c672..30f16968b578 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -25,6 +25,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ih.h"
+#include "amdgpu_reset.h"
 
 /**
  * amdgpu_ih_ring_init - initialize the IH state
@@ -227,13 +228,23 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 		ih->rptr &= ih->ptr_mask;
 	}
 
-	amdgpu_ih_set_rptr(adev, ih);
+	if (!ih->overflow)
+		amdgpu_ih_set_rptr(adev, ih);
+
 	wake_up_all(&ih->wait_process);
 
 	/* make sure wptr hasn't changed while processing */
 	wptr = amdgpu_ih_get_wptr(adev, ih);
 	if (wptr != ih->rptr)
-		goto restart_ih;
+		if (!ih->overflow)
+			goto restart_ih;
+
+	if (ih->overflow)
+		if (amdgpu_sriov_runtime(adev))
+			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
+				   &adev->virt.flr_work),
+				  "Failed to queue work! at %s",
+				  __func__);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index b0a88f92cd82..7f7ea046e209 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
 	uint64_t		processed_timestamp;
+	bool overflow;
 };
 
 /* return true if time stamp t2 is after t1 with 48bit wrap around */
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index f8a485164437..8d3ae88b96a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
 			if (ret)
 				return ret;
 		}
+		ih[i]->overflow = false;
 	}
 
 	/* update doorbell range for ih ring 0 */
@@ -446,7 +447,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
-	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	if (!amdgpu_sriov_vf(adev))
+		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	else
+		ih->overflow = true;
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index e9e3b2ed4b7b..2ad209406d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 			if (ret)
 				return ret;
 		}
+		ih[i]->overflow = false;
 	}
 
 	if (!amdgpu_sriov_vf(adev))
@@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
-	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	if (!amdgpu_sriov_vf(adev))
+		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	else
+		ih->overflow = true;
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
-- 
2.34.1

