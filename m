Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AD3C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8189F10EA63;
	Fri, 21 Feb 2025 13:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BJwC/W+K";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D6210EA63
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 13:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boJdUJEDCXZ0F9JfDD9TUb9nzHQoJBhNhg650qs1JzFqdVbPBvn1Zgr1ayv8eJ10R923l3aCVVLEE5BnhHMnZkTgYFtyuKoger0wiOv5wVtyMzdPQT4bcCyuGz9lrYxOVwwdu1YYAKNKW5XNlBeGBYwFe+OMyRoH8MwybGS2SIIPfSWC1dFgou3+veeO8XAmOq4h5OZ1cxQUllwie0f8F1yYfZ7SkBuwU6rzVrzE3izQ/fN1Hsnn8NAusUnaHfxJmSTmfIE3qho0nUivyP/bgV8h5L+VgA7kE4+EsYJkMEWVmZ6C8NOj5pAQlb+J+eExZraE4H6f12cYorQSrj06AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7rH8112GbVyvpBTqZIqpFgPMOZRoc+AumW6vhn9oPQ=;
 b=Zr9rMIbHfZ6rYj4waw39IbFxfQZxW2AJthGP49p/b54YSiWBpuGRWxZSaJyjgJCKJUEWZSIYIe8vUu+2+pnJXJFpmYQQQui1T3ZMQiJV8c2f7AWV/FbaYNkiwiWzCfpoxpDS4xcweY9yjNszAgoN63qVQQek7ck/zbDYrz/LG57aifbzWpGvHFa/qFuho5Qi0Gu7onA3LUi+buwiQTrovksBVEywuhex6ttXmI8dPIiAe91Z2UKS2mIiSNcJA67UTm3BMa4rxx5G0ifIxCzZUvQh5FK7L4IPzZ0dp3aeqeIUixnDetXs7k/dV1sNhX2efl/z2BYJTOjFZN63B9vtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7rH8112GbVyvpBTqZIqpFgPMOZRoc+AumW6vhn9oPQ=;
 b=BJwC/W+KnVwEOl136mfgrkZNMNPLGNQUQwSr+taln8hITa1HFnTdune5SQzqvuvBjI7I4NVpjPxrg9eEKMIsbpGxOu1qSPx1V+PDEzg00kfHywINk6N6581WLCdVGKddh/iLwmc8egVIZtefUUUrLzBHWhcKWZWhe4mMy0TZ/kg=
Received: from PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::19)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 13:00:46 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::ad) by PH0P220CA0016.outlook.office365.com
 (2603:10b6:510:d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 13:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 13:00:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 07:00:42 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu/gfx12: Implement the gfx12 kgq pipe reset
Date: Fri, 21 Feb 2025 21:00:29 +0800
Message-ID: <20250221130030.3703750-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221130030.3703750-1-Prike.Liang@amd.com>
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acc1c0e-a73f-4114-1ff6-08dd5277c1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cvo+jq5UtPWygQ3F2u92bkTA6WExlLco0unRqO/uC/4RNaNiyTAKNtqHJkl1?=
 =?us-ascii?Q?l2f65z9L0hXAoFWkbn6/qlLxY6ymQHsY6O3if+N/4osAv9HiwIQLwCQjl45u?=
 =?us-ascii?Q?8+nNfGTXLgTi915hGkkKaA7s9qIVPjFMzqpyF3WqdXgQdt6A9mXKMataUEPJ?=
 =?us-ascii?Q?V2Zh+35hI5gEUEQJkmgCUwcSYlJt5e2TcFDYtsnC7jM4Z2ZVZvIfWxrpu2Y/?=
 =?us-ascii?Q?5iDB0ShLHNhtJb2xmSvrVHYMgW5k+adT6PMsBaJJhYE3fQ8f65EyFDZdiibU?=
 =?us-ascii?Q?5y9XNL5NpcEAmRgQ+cF4bkGAbkhEf4l+jmYWmvCRgiPul8d1ABUXlyfRopEx?=
 =?us-ascii?Q?cCPruWNeJGnqan2YvhunEw2qUv1RM0sAZl+QkU4YfcuTVS2PmC7SKLCCV02b?=
 =?us-ascii?Q?qRoBKaEymaPmGeVB5FIfjXSoJbXu2Nka0g+UWYbO9X3+1Zl+5XDYQTG65N2q?=
 =?us-ascii?Q?4Hcjla9+ABWy4zH9r4Lu8XI6MFOR33FBLQgHVdX136OMvlKrgcGJdeOGm8kK?=
 =?us-ascii?Q?UQgB2/fQ0FqZ0ZmsfTjd33kDFlHiLOQErhkzwQe0vOjt4x984YMzayxvM+jN?=
 =?us-ascii?Q?8T7w3pkV/tjy7vgFelDVXT++OFGVvBePB+YHO0eVFhtRF/Ie61rI5iEGG4Hu?=
 =?us-ascii?Q?Sdj74ou+ZfoiTijHm++M3RNIOlIQvBhG7gLRbEuI+DRo9/KgULXw+d6p85f3?=
 =?us-ascii?Q?tT4tV/Kf6QFOh/gKPHBJXhiQV2kDqUR4yIKIJ1s7uwoSsaaDhkN06v/KbLB8?=
 =?us-ascii?Q?2ZOTpMHLX2k/dm2cCCkTtp1Kx4qDQ7v3HD5efMHMrYhsgGBXKQGYVzCLZJBm?=
 =?us-ascii?Q?oT1rrz7psuPBlL9MXylzLlyhD2x9m3HCz3NF08dnAbs1jr9ebJ1/lDJE4gSg?=
 =?us-ascii?Q?x2C6ddZfl+molVizR66t2oHB+dceOwykg+cKVZcQatjWdKc6a2XNM5S2hjHK?=
 =?us-ascii?Q?qkcRB0kDqv/Stde2RmPhCv04N/2y5yWbomxscu1Ah9evIS+/36sJ+d4C0qfT?=
 =?us-ascii?Q?DU/gU479Q0iS97VEOhw7vJrSYNow21RUECXGSSbh7jJcTZc5Nn3Jdct50YvK?=
 =?us-ascii?Q?fJw9U0DEL8Xy40dcfItg1U4FMIsl5uw5SmO9DAZf291Y+CCj8lfTz4xD1sSM?=
 =?us-ascii?Q?4OGBuCMzPffJAtbRMUm6we7inYyVnZLw0rGWRX4eFErC6wq4U4y39Sscv8uY?=
 =?us-ascii?Q?MdrOiocy2n7JNdCdfcn9naraEvcFqCHFZr+7mpXZyLsAtf+luwAFa3Uno/TQ?=
 =?us-ascii?Q?Jy+BlE6Gv1IkPliSB2Y8fCLI2REJ3XyGzKjNEJYyCyLeNVzdxt2ZL7YQyglu?=
 =?us-ascii?Q?UBjFs9FC3LTgsY1OaFjAqIOgcXbqAABk98swPInC0/KIJwulgpIA0XjaGJ51?=
 =?us-ascii?Q?2VEmbft6VcepDJZ/tp2l9RiSLvJ7jSYNbw9vYoq00Ag2IjjtyjRm0QQ/w8/7?=
 =?us-ascii?Q?HTZ7gcVhPrV4U+mzPmCN+CDOis8PiQ1xzIW0i/PTXLyazvc8oCdfRQWHlwXy?=
 =?us-ascii?Q?c+jTC18YrPXE6NQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:00:46.0947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acc1c0e-a73f-4114-1ff6-08dd5277c1cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
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

Implement the GFX12 kgq pipe reset, and temporarily disable
the GFX12 pipe reset untill the CPFW fully support it.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 68 +++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 667c8013b773..79ae7d538844 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5248,6 +5248,68 @@ static void gfx_v12_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static bool gfx_v12_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+
+static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!gfx_v12_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	gfx_v12_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+	switch (ring->pipe) {
+	case 0:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 0);
+		break;
+	case 1:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 0);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
+
+	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) - RS64_FW_UC_START_ADDR_LO;
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v12_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev,"The ring %s pipe reset: %s\n", ring->name,
+			r == 0 ? "successfuly" : "failed");
+	/* Sometimes the ME start pc counter can't cache correctly, so the
+	 * PC check only as a reference and pipe reset result rely on the
+	 * later ring test.
+	 */
+	return 0;
+}
+
 static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5258,8 +5320,10 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
-		dev_err(adev->dev, "reset via MES failed %d\n", r);
-		return r;
+		dev_warn(adev->dev,"reset via MES failed and try pipe reset %d\n", r);
+		r = gfx_v12_reset_gfx_pipe(ring);
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

