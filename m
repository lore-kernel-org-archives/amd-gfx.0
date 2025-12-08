Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F36D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C19210E0BF;
	Mon,  8 Dec 2025 17:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="42ojcvtq";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF8610E0BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vqb/22VtUkfGi8qMQZf63L1MKt3blUv1GUoGvk73L47iVl9j+sIcofPN4RjrqmefklgAs1C/daIMOUAGjGXDZFtLbBj55bxVDPC7ohNHwAPiJbSiHnzJaVgRq+g3Do0dy67MpOCmM8ZOC3WLnyG/oLXb5oBbZfgrxv4p7MHi2fymBVz50bapE3392avp/VUtMnR1KnwmCWxfYO8EFHzEa6oRXT6l2X+3z2cdr3Kc4WyBE3S9vynTpEr2n/B6HqTQxxRFWcBam5/VDTfyXgIBgpTe/Dn7UI2erncn1wyRArrxWn+Tc4G2tVzipPk6nbusdMgrOn++7XtqkVUP3I4bcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAeoWzkGa9I7OfX0OdYme7RiCUbSZ/T07/qYcfpnZG0=;
 b=Dfu2UGkz4bgzfym4DobDyeUaO6y0MG8McRux0DoaXeBClu7byqQq6qt6ikjFwYiVSOcGHhQh5W+htJ/V18BdAo3EXcCt5hkmXpqDNbYb8Bwcl2K/QdVa9AcFwhJLL1vWiVMPo9vctRsDbC51S6yy0xbK8wP01jld3h4T+XkbjdsZW35QFOAl01s1gN428cUrvtZYdz7gip2Q29zvsWubGPt6ToiabRXij0itxH3SLbk55+uS4NjWMta7NiBov9zbsEdZBt3pEDIXnntovZ5F5OBiFZVFH0Hu/5926UQqZANGuVAOpqfgGC6wx01HgsDn3WMZdOnvKO0T9FmCEkOXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAeoWzkGa9I7OfX0OdYme7RiCUbSZ/T07/qYcfpnZG0=;
 b=42ojcvtqA/458PPfrmhPRYmxp6RLxn8QSjeMZFW/JZboDMOjUKEZwCrGDqkUpHn92rZs9UVvrieA9nk/AVDamB87FAdhuV0w5HBAT2wZ5TgcSAX+OimWxm9SeSmvZuurbdQPUsV9Gf/t6z2yCz/Z3iY9UTdIQCFdtCEtAKie36Y=
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:42 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::57) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 17:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:41 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add UTCL2 Retry fault interrupt for GFX 12.1
Date: Mon, 8 Dec 2025 12:17:01 -0500
Message-ID: <20251208171720.153355-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbb2ad9-0247-4a92-5b7d-08de367db1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B4vMMhLJazfGgeHuC+SLzpDNI7VLanRrfbjfcsR0mCTTcHtD1N4aMFi8Atx1?=
 =?us-ascii?Q?wz8a8C+mwNYyyLUx6Asm3MSYqUV+7iKDM54DeqqC6f3h5k3VKCMuP0bJIbEd?=
 =?us-ascii?Q?gq3lgWglJIE/ZNxd4U/QMabhggKQfedSCcmUSrjJxX5Hzpj0aSTuU+DkzE/+?=
 =?us-ascii?Q?ZFcfmXmxvQ8Eo2qMzsBhThX8UVu3AkzTDdK+xlwTBt9IIXh/gCZpGgmkeOLn?=
 =?us-ascii?Q?uJYz+aoFYiDdL0aK2vr4KKiyP9ZahO31+OmmalomfOYlmr6M0/QQ10OAovTD?=
 =?us-ascii?Q?cLL/h6MXztoBB6JBtQs/C6aRCvQEO0izNQCz3RUbc2DeAhkpwAqeNeqvvEmy?=
 =?us-ascii?Q?YZOoE1fv7TMEdXYt0Y9cDHZhPL8kvpXadXPgooDeoFFT5YyG3gPEnJtDHtcP?=
 =?us-ascii?Q?A+pyWHuPHTELfgghCee8DELaAg6XfalFyzxWo04osSE6fE6bmI2nWEbwRTw4?=
 =?us-ascii?Q?eBHNP+nqOirFMuZ/i1EBBqMoh7N5ltMCZle91X+sgD3GmqoNsICCyxTscnrN?=
 =?us-ascii?Q?YprWqilSoe9znYt6s+aLHB9E/vDJ8574yukUK+ZO7ZQORIVcOJPLRZjOXdIV?=
 =?us-ascii?Q?uydbdb7t0pplcAOMX/vYznIo6tlaTt4jCXjIODqgLzJKQN4Dds5RW4HtJn3b?=
 =?us-ascii?Q?5mbb7pUeQeq4faTfhypnDcNM9F/nGIzfk93f4r/vEmGW2WrvNVszSH2vtVfO?=
 =?us-ascii?Q?l5zIxrG9iyl5VtmITgiKvtTJ7I4zgt4Tl15okKS0g7g+sOjSU9hAmCg7mWrU?=
 =?us-ascii?Q?eI6kiBcWhJ6tlm7rRhYcPLwtfXjUmb5urRGu84fMnMifR+ksFACeP0Y1XoV7?=
 =?us-ascii?Q?+aVsnTsCTTupHXHkcpF5ge1wMiXQpi1T/lL8pMmFun9egkw6XsN5QtFr86Ky?=
 =?us-ascii?Q?xrc9/P2bSnjzusV8Zt1jea9t+yjnAnj+GVXQgESKHZO4n0EY/qSOvBUigsBC?=
 =?us-ascii?Q?GWVPgdZnxhnKdE5hKVzZlX2X44CrYJL84YKzciu2JhtZteWkjKySWkZBI7AX?=
 =?us-ascii?Q?6mFZXK9Feu6JhAyMG9vzSR+NDOxCtf/oVDDCufDt+Nfaehk7eWU0gBJxl0U/?=
 =?us-ascii?Q?ZtfrNr7ER1Xuhl6BD1vwXKokHsLiV3zMUkpmRcx/OBym6TBFqMfq/8fCuXUV?=
 =?us-ascii?Q?Js/RsPH8KM7vaXORnJX/KiYJiDJ7ZhIeWTsEzeoK6bTpv4znobjgIhp+9POA?=
 =?us-ascii?Q?jFOs63OetQ19Fg88IFGMvKhYT3fbcRMO+w8B/HSmQ9EF84TfkdpvlYU04FJT?=
 =?us-ascii?Q?IeAaTbDXXv/7+f8mqX34PXQmkJQJ889a/qt/Okgs67W4l3QI/6/x4O7sMX/O?=
 =?us-ascii?Q?fN5zR7jb3lZTuePCRe1R7Zo0t5wPSDkIxZ/LoY+D/4QwRxjLVXLDlPhPQnEa?=
 =?us-ascii?Q?s8qzd136XWPF0EKcNxCEEpRByfJWP5QCwEaHtMIDXTbZoA+PXyi4ZlHcJLBp?=
 =?us-ascii?Q?NjpYfcari9yt4fiHTud57ggr1ZeXKT/tTQUthiFBlJDH79Ksla3BK0lKkmrz?=
 =?us-ascii?Q?GjwEWJ5m3XqweCAW9/1Yt+e41Hnmfjgk6uC4MsQ59vCl0LU6IPzHjySzxLC1?=
 =?us-ascii?Q?XSQOEbxBF2NB0lJu+HU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:41.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbb2ad9-0247-4a92-5b7d-08de367db1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add the UTCL2 retry fault interrupt for both GCVM and MMVM for GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        | 19 +++++++++++++++++--
 .../amd/include/ivsrcid/vmc/irqsrcs_vmc_1_0.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index efc519112ac45..1b1e2ddbc600a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -656,6 +656,7 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
+	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
 	return 0;
 }
@@ -822,14 +823,28 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
 		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_UTCL2,
 				      UTCL2_1_0__SRCID__FAULT,
 				      &adev->gmc.vm_fault);
-	else
+		if (r)
+			return r;
+		/* Add GCVM UTCL2 Retry fault */
+		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_UTCL2,
+				      UTCL2_1_0__SRCID__RETRY,
+				      &adev->gmc.vm_fault);
+		if (r)
+			return r;
+
+		/* Add MMVM UTCL2 Retry fault */
+		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_VMC,
+				      VMC_1_0__SRCID__VM_RETRY,
+				      &adev->gmc.vm_fault);
+	} else {
 		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
 				      UTCL2_1_0__SRCID__FAULT,
 				      &adev->gmc.vm_fault);
+	}
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vmc/irqsrcs_vmc_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vmc/irqsrcs_vmc_1_0.h
index d130936c99890..22075805e95c4 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/vmc/irqsrcs_vmc_1_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vmc/irqsrcs_vmc_1_0.h
@@ -28,10 +28,12 @@
 
 
 #define VMC_1_0__SRCID__VM_FAULT                            0
+#define VMC_1_0__SRCID__VM_RETRY                            1
 #define VMC_1_0__SRCID__VM_CONTEXT0_ALL                     256
 #define VMC_1_0__SRCID__VM_CONTEXT1_ALL                     257
 
 #define UTCL2_1_0__SRCID__FAULT                             0       /* UTC L2 has encountered a fault or retry scenario */
+#define UTCL2_1_0__SRCID__RETRY                             1       /* UTC L2 has encountered a retry scenario (GFX12.1) */
 
 
 #endif /* __IRQSRCS_VMC_1_0_H__ */
-- 
2.51.1

