Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8091D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5928A10E4C8;
	Mon,  1 Dec 2025 23:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nf91+a+x";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E9D10E4C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baVS0kfw2ucddbyAGlOvQ40iI8SM1F2xleiRIqLQQqx2vXwuDmRWR0wBvIf3lbh7rP9LYbRabzsvF/ycmQdAHOD8SUfDSsJES+yeqGfy2Hq1L9xBUfgaBlCu/B56aU4ks1G76nt8d4fEH0miPKp/kgT5TKD6ehddiUH6XC1je1wGGcenGyUbL8apF1U5wGto6qL143N1GTRLb5d5p1osdcCGjEJKVVTRxvsogGxscIMLWuAm/TCKloLoLsqMNsxGpAb+CxcK70pPP6HebMEoO1Obx+rmyy/qFXgTAGLljftAOGe6Nqq65iJOOhhVlhsWoM2/z/LBXWbiF5YS8Dd4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx+J2DwFSeJvMyfVGzWNNDYpQrQBIKiHs9QvTmSg2fw=;
 b=I/9vYNE2m183CpfsNki5jCBTc0/KqdRQXxQWC1QY97zta0iO5wBtfnQI9+TW54L0eYtQvH1ArkLYl67kSW//h3akNRR2EAtfaaJf8wiVYFQRp64P5hAA/G1hN2a8AXJBtd1qhHAT7vhQ29O8ZMqyZM58VSA9Opin1NrOYxPBvjAWbSFZRs4iDf0UDnjr0gKtGh/2rISRwqHKmkqwbP7dcvPrmHgrpNJ7xsXVtnKYxpYnFoXCle7esnwJ1kDJtmFjUdJbGi9i5gFGi2vahvcy1fL3px0gJMVkwWq/kvGB/FG2Jf4zL0Sp+MPIYWKM4oNYxNLG4rpSsW22okd5E807DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx+J2DwFSeJvMyfVGzWNNDYpQrQBIKiHs9QvTmSg2fw=;
 b=Nf91+a+x8Pnngx2vGbaiVamwAfZOgIdr2XK1G7Ct6g/ceJa2Xk6iEyv2EcmIIuRQWGvp2XKWvS9YvQWWxvOnmAeRf+NnQacDcKpLM4SYlHCwBF29xxxZq6NC/biVDgEv278GbsdBTasS/mnqK5GaUO4jmzdgkGMGWv9YTcYUKP4=
Received: from SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::14)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:27 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::e5) by SA1P222CA0046.outlook.office365.com
 (2603:10b6:806:2d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:26 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Init single mes instance if xcc_mask is unset
Date: Mon, 1 Dec 2025 18:15:03 -0500
Message-ID: <20251201231509.791954-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201231509.791954-1-alexander.deucher@amd.com>
References: <20251201231509.791954-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cf73f3-bd79-45e7-6477-08de312f8357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z9gI6zqEF30J4PUsHNBfpaosS8yu47VUv7gk1mO+ytTu2Hwwn9KXGtLI3u3q?=
 =?us-ascii?Q?rr/zYzOrvxlFhpPbOiu6nlCNYRiYLpe9Gw3BAVvAl9zh9dseJclcLb11NuSZ?=
 =?us-ascii?Q?ass7fDl4rGCvGdODetgJyDo3GeWtVJMPZxy5/1CoRFgxizaAT5JwkpxLJ0Do?=
 =?us-ascii?Q?dk+gLlMeR+qpSU9EfN+Eic5+onTzKTqgpDTStyjktsxr692qS/+HBH05jvv6?=
 =?us-ascii?Q?meipHG17IyCP2Xcr4HhkEE/xHh/9cqO9fqftkdSMgrIk4J9nHee7uJSmoNrd?=
 =?us-ascii?Q?8gTNj2QN3CPOhvA+CwLANxCLiQbyQTJpsyNcSOGUbKuuGGeeG0YGrTF8d52b?=
 =?us-ascii?Q?HsLffms2JmEar+wwUOdE9PqofBBRmiE6BDQ1RUcZ1ncPSH6fBDGLk7MR4bTI?=
 =?us-ascii?Q?Xs5dIzgXVu2On9Io4+UusNYHH95BNUgc6w3tGzNd+FQhjUcUr3uyvIgH2Bhz?=
 =?us-ascii?Q?3Hocdi56+ep10/Az8MioValUPKdE2HSmTRZYA9AYZsPFn0zpOuEOySOJrBtZ?=
 =?us-ascii?Q?tPDDl+9pc6gx8JRybm9izBhA9wwt+LDLC5sVwjComDJaU+NZUp/zLK18Kggn?=
 =?us-ascii?Q?AwgB5p56UAyMrrnEnOc0vijQrUhrAvdDgTN2mSNz56PFk1C0HHnS9DU/NuZS?=
 =?us-ascii?Q?VjF1MO1VsOFHwC3JSS5ZEupA35uRkdsOKwNKgODt7IXC5xuyZYcHpu3fzT4I?=
 =?us-ascii?Q?iwQaU1fyAx6U0ffn0ohstwJRd0GcSf+QbhKju4JOQC5usWx7AaoMT3+jSxO+?=
 =?us-ascii?Q?or4a9bpbZB+JdJ2LCmHCsePwFNPOi+YYiASEIJKGNtBKPObacLxb9gzB5GmV?=
 =?us-ascii?Q?qWlxGOK5ZNpHbi4jTL/Oanba35XzMuXlMJbF1OdxLLcb+6bbPWdWAg9/Ap3G?=
 =?us-ascii?Q?Tcgf16VoM0uH+u3HWORZ0olmyJTmpNPWu9RNuvNDuXsia+88Xop5cmVKLTKv?=
 =?us-ascii?Q?5INcikuBD+mf//SMx9okOyX694+hIWnwxcU5uRdamftjlEdBEbnal1mowdNa?=
 =?us-ascii?Q?amhsmrMx1t8tMwGTwNPI4ZTn8OkI0TruiEEf0S0B7CUS1TZvoHo5QJvhajT1?=
 =?us-ascii?Q?GKtFy7NDPlu3Ilf1N9I20gsTsQZUy1giuHtJ3xbzvspbe9zl7yErCN5vWpZq?=
 =?us-ascii?Q?A+ex2JJfaz88NbqpFAjVd+Ua11e90DUNc3f85LS7ilD7kAFZ7baCO5LuKFHJ?=
 =?us-ascii?Q?vsYBjVCSsagrwburFXsnTx3Hf4Ld5q4zQJVKY5ZvsDcUh2euEwD2TCxwnBup?=
 =?us-ascii?Q?zV5mpYQu77TTp2s+EyPkNHcz9Gmd67cq37y5mpBk6uwNUQEdxqMI/NutstNa?=
 =?us-ascii?Q?zjxVKQ1Rtz6iH7NqnslbMGSxmtl0asSEzP99f6NltpcdQDBESDtjPCEvcERq?=
 =?us-ascii?Q?6BiwmT8GSm2LcY9mmSGl7Ai4MslmOGZatnaRALzg0wp79RaMr+2e7iP5BJcl?=
 =?us-ascii?Q?SCxpe1NGS8JuD3UJ1thFT866dqHXHVTT2jI3Oa+IrCZrSRbmW7k3Oqkomzgz?=
 =?us-ascii?Q?V9AKa2AOCy2yex8o/5zjFI4jCD2F5cDlNvQpnZKtCWtwFqzwEfrqXh7q5+56?=
 =?us-ascii?Q?B93cdvZxdbQWTY0K6/A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:26.9301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cf73f3-bd79-45e7-6477-08de312f8357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Configure a single mes instance if the xcc_mask remains
uninitialized.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 895b841b9626d..59e6b6f5233f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -92,9 +92,9 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes;
-	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	u32 total_vmid_mask, reserved_vmid_mask;
 	u32 queue_mask, reserved_queue_mask;
+	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
 
 	adev->mes.adev = adev;
 
@@ -245,7 +245,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
-	int i, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int i;
+	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
 
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
 			      &adev->mes.event_log_gpu_addr,
-- 
2.51.1

