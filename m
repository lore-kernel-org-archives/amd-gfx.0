Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63166D72369
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0341710EA8B;
	Fri, 23 Jan 2026 10:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KVmzkFE4";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B109310EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1ZVN2AVgTmPTMM2ArwEn95pVGJSTfsIv8MR/sZo+GVCL7KtXEZCDrGMZPccmZtIkCDtvvXDPPN1NWUbQ6gfH/yf3TAspyFSQMyH4kxXVBlTX98aY8hx+wXyWMbMhL4amFx7CpGTrKWaeAgTNpcsIbUOWq45zS734SxIZHSvzl8YclA80UFrP04YrzELLe2IAluGS/ORCSEyslSSoJQsnZdU9ANDhuHYLB8gwOcJVNP39x4UzAdo3puJJCu63HeQ6SFANKv2GBbJNWs/vtCYM8Nl2ZXgnToxw9+y4QEe4l7ZeTA7sEiF5GYr6Kc5k1CtDNsrCehJQWZJBwWxsyLxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89QUh3j8UeUZ24zSVRGHLRos774pRM6/3p5iQ2158pU=;
 b=PVaxwZaYj5xfkhENlPQ5PxkeebM4F76W7BbHq5oDaF5BsMqonBvCudE4vt83Wx/QE1EFzyai256IVJC9AtGjgEJDVkrpA3o7keAJoHHAhy/rfOljkcBUlP3iM/6W2IaNznFSrpQQDiZPcHmkfaooegXlKz2ijR303lT6TQXwCpDj1RFa447mYmoGJcznfjaFHQDBHwjCUQNF6IXNhRiTJRlbO/y9kQ41ryiBdWhB/QYq2+NOc7ji1OWThNl3ZE2G5mi02ZPKSFvSxGOUXco+od40vhJ1o9bV+OWu/BKu+zNyks2Tin/BbQ+aNBdPRww1vEMLiQ6gO8r29G6+C3wBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89QUh3j8UeUZ24zSVRGHLRos774pRM6/3p5iQ2158pU=;
 b=KVmzkFE4moD5Owa/cwjo4Ake9uqU8iYTgvM5GRX7MvbVUjzqM3WCQSyh3fYU514IXhSC/nehyJUoQoHI8efREBKLBHqZpC+cbmKVT9nAuAoR2Rc+BflqcylfQTeO8Xf9PwgEqlmk+uPm3msC+U8vjo/CJYnPPxLe2FyBHbSV3Lk=
Received: from BN9PR03CA0486.namprd03.prod.outlook.com (2603:10b6:408:130::11)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:10:58 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::cf) by BN9PR03CA0486.outlook.office365.com
 (2603:10b6:408:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 10:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Fri, 23 Jan 2026 10:10:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:10:57 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 02:02:52 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:02:46 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/gfx12: add CU mask support for compute MQD
 initialization
Date: Fri, 23 Jan 2026 18:01:22 +0800
Message-ID: <20260123100219.1693990-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e25024-d0af-49f0-26a7-08de5a67b3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BARr4SNkKHsTAyHZqxqto6i7nNGyKw3nQJ24p/1NvF1DEe0DCyQTKqd+OFhr?=
 =?us-ascii?Q?vD579YdZavGjwfe5x3sY118i5gT2miykFnnBySUK/6zGUM8p70FvovFxa01g?=
 =?us-ascii?Q?J9OIKehAzLHNULC3g/ePkDNWGOIgEH6yWStdI7kQCfZK/yCs/VyI9O1smwk8?=
 =?us-ascii?Q?XsBAYLhX8zSiTJLvHkWhQm3jUrL3QUCsvrCQ+6o4SPkdR+zSh1amlyIKhTfX?=
 =?us-ascii?Q?Y8fjG1jIPaEn4AGQyg5N9Af6nzAfW/36hMQKfDIzF8QMdOWL7wqiGLQcd0rw?=
 =?us-ascii?Q?f4U3KeP+yYFeBdUMbFIyVpDCDHZcrKNlHUhd6aNJpCYUSugUMKUwzdmySBk5?=
 =?us-ascii?Q?NDhaweZVlFHrGEwTiURepSmHEu/oScpCALkEbCjj2dhqAhO8QAxir6ua4iwl?=
 =?us-ascii?Q?6IofUW67QqMxp2YUe5ELJdI/v66f6jnuUoBCYqE5zSUPoGdb8dt6Cy7Q9z1p?=
 =?us-ascii?Q?bLrmTV1hV9znkmacPhRxml/qbzZv68A9aAPbQT2RCVRwHZsuDQnwbv7HSZCt?=
 =?us-ascii?Q?NIwrt9h2l5SRacuTAsXZMjfOJamACb6lP9Je9YBrK9NzvZg7KDO1XUeV58Cw?=
 =?us-ascii?Q?9WUcLnYiICTVYSbHiamJJBjEvWTgvUa49hUPXTNXVrcsLnKkQbTub+/Waebr?=
 =?us-ascii?Q?WyXY6AdRZ2ES+P1/pUjd4X+Bt25R1WQE6LxkVJccrBrt2K6l0RFpZrboXPZa?=
 =?us-ascii?Q?BXY75NvKsPZcKJSXWy2fVf1TPtXiYR2s6SjD9IAz5GScUHtBKXFETLx2Q5MX?=
 =?us-ascii?Q?G4ETp78MXC+z72KfvOeepwPinyjf3vrlPXmqSiiRuSjpbB5OGeMHBIDoQUMA?=
 =?us-ascii?Q?zDD6dBnx81+0zSGcJa293bOq+l8QZIuk400l4u07OUOs4ONT9hVZiplNVZrp?=
 =?us-ascii?Q?aesuebu/N1IPqvJDmTwrETsoyBPfhVzbuEhyKrebzUKkmyLwh80KL52JuUpa?=
 =?us-ascii?Q?9fmlMxPa9usoUHUu0vXTHZqbNHKzMXhe1jr57B+ud/Ngg35EAEHiXdcabWuI?=
 =?us-ascii?Q?HFpjxNUk+5kxE0dsS2dyCCh5YvrevgwwkmpSyfNi55EdG8J6X1r8a+o89LV4?=
 =?us-ascii?Q?RASGrTbqZr85oUMCqc4v8dMb7irTzi3Bsmh2caSIN9mghLuRmdc4gHbs7yRk?=
 =?us-ascii?Q?y6+ucVw3rP/RCw9S+wUtIIH1MD73IPdIgdcxDIrNTmfVs4PQgSNsyCdWObLl?=
 =?us-ascii?Q?bUV/TQOoqnwvz82Ei8gk8KoyV+1xcXbKybZQaPWAFoZudxCeEin0r0zTX779?=
 =?us-ascii?Q?Nax641XOWt8pxzxJHoCQK0Oj4SHoa4PYM3MfTS6DPyixMQJYfPeKlqAZhlIu?=
 =?us-ascii?Q?tfjYick9fJ5jCh/JDh8SNyFBgM/znKj0HBHB1s07afHNfVdNPBp9G8Qi8NNa?=
 =?us-ascii?Q?WqJsow9LnNDHXM9bskywQ/V1wd0sMvzOuWGf4kGSMfNi/mevfA9PNCc5em+e?=
 =?us-ascii?Q?/sqaq6xlXKY+rUwyE4/xlz93KklCIZj2i8XpYiVnpBy3bXLQp2sc61gTi/O6?=
 =?us-ascii?Q?ltCT27vXr6ANt0kDn/Uz3OBKxqckTaC+/r9uia2pKwVVnueLaUfKMdEqQeBA?=
 =?us-ascii?Q?HRZveX5LdaDArkxU0CvDg2fRob6KRVP/CU/85OvqNIhhbmlMvc4D9I2+tEtU?=
 =?us-ascii?Q?uWshg6FDd2KcKt/X5OOUi8TEZygyWLaHTjD1OMA15kNe6IlSe4JtiMNgyIDC?=
 =?us-ascii?Q?7x1kbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:10:58.0501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e25024-d0af-49f0-26a7-08de5a67b3fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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

Extend the GFX12 compute MQD initialization to support
Compute Unit (CU) masking for fine-grained resource allocation.
This allows compute queues to be limited to specific CUs for
performance isolation and debugging purposes.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c37..73478dd0f6ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3110,6 +3110,37 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v12_0_cp_gfx_start(adev);
 }
 
+static void gfx_v12_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
+					      struct v12_compute_mqd *mqd,
+					      struct amdgpu_mqd_prop *prop)
+{
+	uint32_t se_mask[8] = {0};
+	uint32_t wa_mask;
+	bool has_wa_flag = prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE |
+					  AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE);
+
+	if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
+		return;
+
+	if (has_wa_flag) {
+		wa_mask = (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE) ?
+			  0xffff : 0xffffffff;
+		mqd->compute_static_thread_mgmt_se0 = wa_mask;
+		mqd->compute_static_thread_mgmt_se1 = wa_mask;
+		mqd->compute_static_thread_mgmt_se2 = wa_mask;
+		mqd->compute_static_thread_mgmt_se3 = wa_mask;
+		return;
+	}
+
+	amdgpu_gfx_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
+						prop->cu_mask_count, se_mask);
+
+	mqd->compute_static_thread_mgmt_se0 = se_mask[0];
+	mqd->compute_static_thread_mgmt_se1 = se_mask[1];
+	mqd->compute_static_thread_mgmt_se2 = se_mask[2];
+	mqd->compute_static_thread_mgmt_se3 = se_mask[3];
+}
+
 static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 				      struct amdgpu_mqd_prop *prop)
 {
@@ -3243,6 +3274,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set UQ fenceaddress */
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
+	/* set CU mask */
+	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
 	return 0;
 }
-- 
2.49.0

