Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703E7D3000A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 13:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E24A10E915;
	Fri, 18 Oct 2024 13:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a2wCPhu4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87F610E915
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 13:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSE+EiS1WpNzcriZlyt8kGUrA7H5HwUaJZa15tvyzFZmuTUyeQQ/9xva6LS6rVjef5IdGX3vuDQV2kq0SIBzJb3xzgKBszMlU0cArq/wwDfOe/Qlq7LIYmrHkdjcn+JuLifimxhdJVEwAWXfIf4A5eTHAvkhUpRF5vFPgg9EE7NrloULkAbfCUEcdc0mqqTT+LEcc3d9wScwkfQ7ll2rb1NswEjpSAqPtrGjVO4fKqCU+FdqHqN9DLbi0w1GKU84A65Rz2esNa5/s2/08lfiZVvGYmTuNwaC+kMAN0AJgZDAPKEEuTbl9EbvXbZu2jdZruQuY4ym6rtXpSITSWuuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNxn2pnUTab0ErMHlTPn1jGSOtKXM5AMsK3l+zV32BY=;
 b=jDlEnG69efRQS+3TlgC4GouIi5qHePcx51olAELx6llc3GWZBTQAMoLeTOXEgsgAKP45KWXFq5kepCyGkKeMSKbXm+XMX3n3XvFcLhjyOB83fbNxguhZqDggnDZhqVmqGzkOlB8ruppTNh68MWsWXC6y6Bop5i0WSFWvQ81JiOUcCa4NLpKznnPohgf0cxdCYbUIpJkdufdfe5gLXRkynUSkusyOG+qjP8+/IVkOLr8l7wl7GXNumTV4cUFmm7WL5Ifxjme565UwtNt9xR+hw/idUWMC5176A0dL+P3cNB1pMTI42JLUV9bJYjU/JDSqNcE8PDkzywfNOcAbRYWI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNxn2pnUTab0ErMHlTPn1jGSOtKXM5AMsK3l+zV32BY=;
 b=a2wCPhu462KmlyOSAFokEI4XEU2F3pAdjwdk8KOsjTGMWFSBsVW5DMh1HLQ9vZwO+iAhnq7CSPBentmaUG+NP6QIBBUNgDMGnw669sDFLORrVfz9UbcpABj3oacvqzS5pKEQ9HSYlV5zLlj2EsNtyqd87dSO5ds4Bthwfyqqds8=
Received: from SA9PR13CA0019.namprd13.prod.outlook.com (2603:10b6:806:21::24)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 13:26:54 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::e8) by SA9PR13CA0019.outlook.office365.com
 (2603:10b6:806:21::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Fri, 18 Oct 2024 13:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 13:26:53 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 08:26:51 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Add gpu_addr support to seq64 allocation
Date: Fri, 18 Oct 2024 18:56:29 +0530
Message-ID: <20241018132629.190295-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c984b8c-7aad-4b32-e2ea-08dcef7887f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0cvl7rlaGePQ1udQ/LMMYnI6cAKYIfZAlro4m+6GRgM+subwific0KoHkRnf?=
 =?us-ascii?Q?pkitMyfN/0cP7yxbEUmL3t0THHhU+5D6JceAXhZ7Df3IcHnb9TdjXV2tfyf1?=
 =?us-ascii?Q?+qih2YtVI5J2kWgLd87pueqWL/YRokP2H3+0t0sKxDzNKzqvMA6YFLF5lKqt?=
 =?us-ascii?Q?ycpV15bzN9CIJCQplizfv5CsBSoT4yu3lexLCY31OGn+cz72cV0DdRsgD+tM?=
 =?us-ascii?Q?MWRuTceOLhz3gBAos0+B1NnaI5C+f2dDSCxi/Al3olud9jLbHbDz9xQMDwFw?=
 =?us-ascii?Q?Rb/ydIm4CHTuEx6Ia/Yg4uc+/CCB4kx8OVUVNmrm1RIRGMVfW2IhPVq3I/PL?=
 =?us-ascii?Q?54KQje5Fb4bRw4z/D6yWr3WO5zWInd/Evm7Cws9hOzDk8GfWbqzgb/G8Q8bk?=
 =?us-ascii?Q?OiS5T0OlwXxBlVFV93tvLMeSG+f495TUqBPp0c8obx/6uhShTGO23CMIowWF?=
 =?us-ascii?Q?zKQwCBiGymv4VGX5ZkdSsw+a5bWnSWgFl7S1TjV1UcFrPMj6DX/yeQZqd85N?=
 =?us-ascii?Q?zbaMZTBopltz+hdut4Cr5gUa4nop2iaeduY2hs1OjrWK6Rv7ZcCTwE4YX+cr?=
 =?us-ascii?Q?/pPto7TlcGIRMmxrBFqqVuCAEk1G4HY8pFRPdofSMIVyX6ZwA3p6QG+bewYI?=
 =?us-ascii?Q?1rPNM5bVCw9lnniy8T2mMvGF21yiR5tr0JJ1OY9Zsp9+4WHlG+SN2oT5d4h4?=
 =?us-ascii?Q?xL8PoT9bPDJyX/vDuF9epap2yhiUR9QQr04WVBNpImiXp6p8mLZ4dyehK3oN?=
 =?us-ascii?Q?Mfp0ofvqV2vdOT1NSNMfbpgIuOkLdblv2iC6kixIZyL2rhg7wxvLNLIMcq+b?=
 =?us-ascii?Q?wuBCmBevfGCcUUYfAgC9/e5bJoI4KbVzaJy3rQe3jCPBsvy74i5xA3PJkOHr?=
 =?us-ascii?Q?HSC/FOq6N11O6RqpuYS4SXv7SJcbHYg8sQ3r2Wt+4duwoVWZZAUymI+7CN54?=
 =?us-ascii?Q?lAsYSEkzKeKdwwRREWlZsVV+F1NpMsve+KDQZTm+uSANS1PAfQEGdeKubSNf?=
 =?us-ascii?Q?spvBQxdTvdRQKwVVy82Gw3bD6G+sXSEYHPOT1aoZiOFZjnXza2VVRogyJYOK?=
 =?us-ascii?Q?U8p/gtRqkC/0Wbjhz3CrmBhBUSIK70kzlZf22+CjeqeDxjRUfNPM0u5pm5jl?=
 =?us-ascii?Q?rD24TKMGnszXhkmVNhXbJ0i4EXSddBNtATcuG1KbZXCJQ32JX5WWjpYCz6xs?=
 =?us-ascii?Q?llaVJYFP9J342QVWErYxEnfp3XtFUG2Dy9qzU5A8AS04boLiDnxNYT4xlh/I?=
 =?us-ascii?Q?hWywly9j+uBc+rW0DObbUwYJG81CXfTj+NlrfqBHKGUdtyTd5jv0n8KaVjcO?=
 =?us-ascii?Q?PjZjlT6eTCyvahZJEExf9Mvfp55ldEYfOc67mtJjrtkNZuKRVy+dwzjhDk0C?=
 =?us-ascii?Q?GbjW4eK3MbK51S2nETh9YQmYR/xib3u68kqh/4cAxc2eKbQKJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:26:53.5245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c984b8c-7aad-4b32-e2ea-08dcef7887f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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

Add gpu address support to seq64 alloc function.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index e22cb2b5cd92..0defad71044c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -163,7 +163,8 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
  * Returns:
  * 0 on success or a negative error code on failure
  */
-int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
+int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
+		       u64 *gpu_addr, u64 **cpu_addr)
 {
 	unsigned long bit_pos;
 
@@ -172,7 +173,12 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
 		return -ENOSPC;
 
 	__set_bit(bit_pos, adev->seq64.used);
+
 	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
+
+	if (gpu_addr)
+		*gpu_addr = bit_pos * sizeof(u64) + adev->seq64.gpu_addr;
+
 	*cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
 
 	return 0;
@@ -233,7 +239,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
 	 */
 	r = amdgpu_bo_create_kernel(adev, AMDGPU_VA_RESERVED_SEQ64_SIZE,
 				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-				    &adev->seq64.sbo, NULL,
+				    &adev->seq64.sbo, &adev->seq64.gpu_addr,
 				    (void **)&adev->seq64.cpu_base_addr);
 	if (r) {
 		dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
index 4203b2ab318d..26a249aaaee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
@@ -32,13 +32,14 @@
 struct amdgpu_seq64 {
 	struct amdgpu_bo *sbo;
 	u32 num_sem;
+	u64 gpu_addr;
 	u64 *cpu_base_addr;
 	DECLARE_BITMAP(used, AMDGPU_MAX_SEQ64_SLOTS);
 };
 
 void amdgpu_seq64_fini(struct amdgpu_device *adev);
 int amdgpu_seq64_init(struct amdgpu_device *adev);
-int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
+int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 *gpu_addr, u64 **cpu_addr);
 void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_bo_va **bo_va);
-- 
2.25.1

