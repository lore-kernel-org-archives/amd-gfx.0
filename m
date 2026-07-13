Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0F2C44508
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B98310EA83;
	Mon, 13 Jul 2026 18:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iJbuZ8ED";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30AFA10E64D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA6IBzGUgkTBuade/rwBHqQvYInKjhoJKR171aSsBLtOTm500uhZd3wvEEtcvpwrIQ/dCK435nd+rrZopqecnNh4LwoqRY2l/eyHGoSIDyzxpCUgOLiJ6R2XQp8LE/UnZW8KvjahKsl4gF1VtF7JPj8lzNt2g4WyXmuy3W+d/EmoyOtuydbrN8Q7RIPyHOyAgVPVi2oXkIzhtpxCNlrlW/7kj2hRlzEixiFO5mOZS6UaWdInYYaQU4xYGZxSqcfidgQdudn7DR33M5jVQb9N3G9XPllpbpIhq3kf6MZqzEwkV9ZPhC/vPHH3Rc7sy/aKDgZ7oW71X2MIS0X0EjamCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmGz3VMeqbb6C/IxR3Jklrog9FY33X5sBniOIFmqPcg=;
 b=HMsyoHSOKQ7kUalEzkCEoRZLKg0Tm+CzGEKoBVV9kjbQSz+gE97N7zfxZy8KpT38hTKWR6qBRt0R4Ar0Ypa1a8ErNvogjusDgOsYVXuvnGKXLGdXbkjJHa2dOWYkcKQPtBtdWcbwv1uuy8sfNv5yF3eTBjXrpM1TNfCIFLiYet9P9Qtm1fJ2IF7j09bQ6nqvM0yA6r52Y5RgGcBEDs4Chu8NTjw+dwJDptnhf1WDlFcqIvf7gV8llMvcQQPVKH+Zi7OLw6NkNdYtswS6roYzi31xO8/G7i7SEZMgKCQlF2N0SQuCyUZbrEe2RhksrLY0KkKPTwVSohryq/MwPWy31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmGz3VMeqbb6C/IxR3Jklrog9FY33X5sBniOIFmqPcg=;
 b=iJbuZ8EDqJjUwQNDZu/WjrVoZLjToOp+l+4MSs6Gu2ciEozOKzKQYl2gvb5k5bB2n0JENbo9tUWB5E+E9DeRlhzgOV/7VOgDqdi3UrC4a84h3eX8wM+CBmFTuEMWgdttO5Hoq2BLq2r13hkyJUQB5hxt1GueSZQit7isNlqiY9w=
Received: from SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::17)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:43 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::97) by SJ0P220CA0008.outlook.office365.com
 (2603:10b6:a03:41b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/14] drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
Date: Mon, 13 Jul 2026 14:27:20 -0400
Message-ID: <20260713182732.630947-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c256f8d-3d79-443c-b683-08dee10c6dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MmDwntEL17WNDvpJEqb+GvAmpq4oxW38gDAZhF2y9pw9t248yFl7k5ZCXM8yYnlveZ7XH3nKfQf9gm7qDgzdxPvwW+vroi6LPi5AqqSKkLRTYD7e4eWdPlkzA/9W4qXQ/vqvl6Wbf/+vsLUBbaYsYKhWU32GZi+eizIro9wHLe8BIUBZdsCRYdGmTwIXoab/Cq15IdFyImA52pVQUrEVJ+lxOpKXdzCUXZvfXnxB3tGAVhEl7swepeC9HOnAT+XoB40HqcthVe3j+lEyI24Pfzq0EBRjTwk5+ygBYX4Bmm6Ksi0oJrMifkUx8JeR8jYdfruHExY9TtluHOzHA3COY0Xk6JpYqe9GYwQqMi5i/0vZCgRQcOeonU7U+yiyCpw+aI1+wabh+ryVCw25RrPxc2S29zWPcpqPvw8lwMrauiay1dx0dAnYBrdHPNYj08cfavxRbLCPaUoQY/ykVexo1ZIJgM8r3eFfVqZphQkoWirwJn1Jo7xGSkAagxZHolFWaWLRMuAaQ+q33HKxm9b7dG0LFgNoCDCWYa+SNr4Xbb3xRJwiHu/Pan0Cw7vDmP3OPDeVH6cFXp0gFftkxyeQFMrdW2MLDKtZH1bbTKMf7nhQN+ZFRVglTdG6Psna8XA+T6W3XkUfqP7NzBhj7i5m/12DuMf73/HyPmRqPOrsab7TdOLclIsIzMlozb0SVnsQOm1Svu3uCyJzrh8pCjtifg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uSWXr/73irKZuoCVVwIhdNxYCLnRmiDyZzVN16kZCnUtrm01BsezIK/fxSezTRlorGUlVExRcfgZh2F5VMfdEU2Q0VFghYAkeljt4suCWYwYDtz06UH5AIHXTqsxq98zs3aMxftPNeO29ikhzLWOAr3dOcZgFMkukRdDQ30gRs5ttMLSyELd1aRiAAg+FYhTXnywYMnb2bMmrvRduUds5VK8kRaHJOBpyAs8TOI8e/GH7TQ8ZMXHybab2x1uVNe+FODqoJr6zsYc8rPJhitQsTAVworAGuc1gXqLDJp+z41Ur9IX+4xS/oPklJ2Lh21ZSv/sScrYazE5f/12Iq7Vm2yBhkS1MVx6rs7Es2w0v+NiuMHiFobRQqmS+dUV4PZvZvHZFw5LcDPsDEvzJPiBzT98z+TeDaLmh1eYEQ+eVR/NyHHOS60iJ17J9fFsM/CR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:42.9108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c256f8d-3d79-443c-b683-08dee10c6dbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6be2000c82614..cdbd0f74aeaf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -265,6 +265,10 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -313,6 +317,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (i >= adev->usec_timeout)
 		dev_err(adev->dev, "Timeout waiting for VM flush hub: %d!\n",
 			vmhub);
-- 
2.55.0

