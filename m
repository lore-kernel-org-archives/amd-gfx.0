Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4A3C44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5989110E64D;
	Mon, 13 Jul 2026 18:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OtZ63s4n";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2CB10E64D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkLAmI3hl9HFg4GMVWETXxNSGVfzQtxwX81ITMHbJ/VNOUtuEdshRlv+GuuZKQ3ji0pGB2bDOmzAjeiZcqO/vxyOsrJB0LXefA4cPLSG/hze3vape/KHn+guTaEMNRvRk9bGRLV4qXcgHFe9MKz6TrqB4mPMTVjmxihmCCLEVd2glUNxvyv/5ZhZKTthNBIMowl7by7Jpwr5PPG9r1x728YtUxRNkVFHgWHwaUpjFFVRR3eRQ6CqB+Lrz2syAHs33EzH1ZihMpU7nXLZkJGJDM44Vajp90ttycXd7yYUJop+M0czPLjjO9OmVD++yQy2cNBL12mqby7xdxpFh2uVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHSPlCKEF+sja88zj6Xv7Tuy58jWiRjAi4zKg46UUEM=;
 b=yp3/QznMFfO2fPt2Up8zR1k2CgXhUdPc63gBeg6r25VIGEfmNcpZ9W3ev/88GbhKWiJzPB5cPTkZybcrNEuCYYKGdQNmtJluFbjd6cU4AAC1D/ZjqoX71MEGpJBR0kfxu+d9nxcakcxIaqeeFfu5BucszHWU6bTtXymTY8qDXPfq9nFfRAj++3joNLQqNqtRWaFiqlfCyzdsUB0kdSRZhnsyqdiP4RANMFiW4/nsa3lLy1+Z6OZQBvK5XMOsmSAXGkwRyjHIhq6VRZ8CkMEe55tX6yYZizGHosUZkZ06/hkVdQrDJAdYnxeF3axLAx9T1uwdaofRs0SDToXKDBYvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHSPlCKEF+sja88zj6Xv7Tuy58jWiRjAi4zKg46UUEM=;
 b=OtZ63s4n2nK9LDk7uT1zUegFJZ9eB17iqCVxaoiwh5ZT3sB6QIuc19vU9hdAGr7o8YJjweqrdLlm41kBVXRPS46qOc3rzfHk59sw9QrdmzFR45KBGe1TCsgkZUX3+VhAo4039Xr89FRHXvlbh99uDkEDLOc9NEuUrL3X14pxwJQ=
Received: from PH7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:33d::17)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.22; Mon, 13 Jul 2026 18:27:45 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::9a) by PH7PR02CA0006.outlook.office365.com
 (2603:10b6:510:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 11:27:44 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/14] drm/amdgpu: add an buffer funcs callback for TLB
 invalidation
Date: Mon, 13 Jul 2026 14:27:23 -0400
Message-ID: <20260713182732.630947-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: fee5125f-0645-456d-badf-08dee10c6ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OPR/fCDdRvU6u/AQMhZRGtLvII7PRI/NcUDGpdvObTGmg0SbgNJ4BuX/Qq8jZ9aTpRd78ZLk3UGQzy2kn/8J2ef+TpjVyro051bpZ7g+RIJjhxX4jJn541vPHbcXYBs3eKCljdA8vcDXxKjUQns3zbp30xY91xyN5vfzyD6LfBhVm1mtY6Pwq1wFzlKS0cNjsNwNaRmtwx4S+/WsGnIwgssdSMca3OXBlKlvuI+2PAM/h9AdUddRVXvWQq1CeZU6nY5vCd0nEIu7j6IE2LOHZ7H+FhL2qlTUXDhghHs/tROL7wAFo2Jv2y+IgccLI7yo0xWp9RxNj6njgWKRFsIkYJH27Z2KyVsgM9CXRtgLlZzQm1Z+WcQG6XvotnYxwqqbbjdJxgAGoJc838ou9GCm/Ckc8lpmifOjbgA23ycBOSc/IAET5FHntdYlLZyqrqTmWsAmkqvSQ2nTY2UXIuB8Zt2W8EFA+VSVaYmcKYQXjkjz53IYXONAVKQ9xRVEeXEv+XMBMt9qNpVJfkyI1hbKu1jx3+0b98UmUC7Sxk+LGfUxS36mYN66HTekX/iaDBd70MZ2Cy48VgG4leHoXi/skACAB1YnjT9jZQHctbeb3KsYXgZJkIEoaVPKCcX/4Qe6QHTh/HimKc+X5RSVeFAf544lK4oCYO2vMy2yZpcQHjrtCg4IBO2dZ6es6R1BwWOc99VJ52mwpBqIFGTzyKvpvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sfTnpRO3b0DBeOvV2TkhnBmOVtWSlP/I0STKfFmNDAixrsf8B5Hkx3v3rPAMNjgOmyotXw5/+DoNy66pKLIrva0SyPhvQUl5S/x1SSSKBBXkCeB3Xho2xlhZ4JFKMwWZNpsV1+pKIEZfvw6zYJAED34Q7V/NI6xl2c83osZeFJoe618k5cW9/5Frbv5A1HFNHDdFUJLm2ElvamtWHZZK6I/x6hasXvoWl2VLCO+jMh6RZ8yBuh5xBO5i65xfr3ww9jAuRD2wS4+dmcemsUCSQ0MlWN4SkNkNseiELOPrmpNRLdajFV+4AM3uXcOP2y8zGaLFSrV+Ik49YfevB9498rgLr/p+CLv4LUbMR+3RGubQ/1osYaFE6cQXJdNpZ6nHJDV67eNGJiRhQckllLR+tsled83kKnKepF2YYWkD6QlVAU3eIpn0Se+5Q5rfXp10
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:44.7378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee5125f-0645-456d-badf-08dee10c6ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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

Use this interface to issue TLB invalidations using
SDMA.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 4f4e56022c970..4ab92d287675a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
 				 uint64_t dst_offset,
 				 /* number of byte to fill */
 				 uint32_t byte_count);
+
+	/* number of dw to reserve per operation */
+	unsigned	tlb_inv_num_dw;
+
+	/* used for buffer clearing */
+	void (*emit_tlb_inv)(struct amdgpu_device *adev,
+			     struct amdgpu_ib *ib,
+			     /* vmid to target */
+			     unsigned int vmid,
+			     /* vmhub to target */
+			     u32 vmhub,
+			     /* inv eng to target */
+			     u32 eng,
+			     /* flush type */
+			     u32 flush_type,
+			     /* XCC to target */
+			     u32 xcc_inst);
 };
 
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
@@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
+#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.buffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
 
 struct amdgpu_sdma_instance *
 amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
-- 
2.55.0

