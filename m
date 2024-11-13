Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D532FD637D0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E7510E748;
	Wed, 13 Nov 2024 21:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fu7EgbHP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D8B10E720
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR9CrBiud+TQuRpvlEK8JXhiTeK+6Zrj8w4Dmu/6CXJW4sKaFWngGINiYELSwizJuYO3Mx5MuJFEMkBxLXbPtQ91q9gSAlaggEl3KmcvnA/RVN3ZhZt1Ij/XpD/ep8jj83mXSBCdgXPMGcpFHhRuPG3iJKbX+GBvGF7FGvyWSCm9LS04onNMhESceD3YgcLDwkHVuufauce7mJyvm7wz+/IDJHhIJNaC9znTN2VgCz8DrJ/FcOeQhpS8dRQTn863TqWzjQRdRdZej+he/4SalnyN/wNvlpeVdlX2KhBfw7q+xVPGdzRQCPKAFKI2Sh0V4gzi18a2IhO+s8+qs7unSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBvY3wZ+OXr6xIyWxvVU/VMvkFLiASGdvYnJht+3JQk=;
 b=mUW5ysheivjgmAyfpPeOV3EmlLJD0cup0ApkODNINbvk6c/GYzhjaF6kZye0QifSCCxJHcITLQfy52DaioNdiIRDLFVxdGjqvwrdODwc0yfcekk36y749tmLAV3i8+ZUgbJssaaSgJeuwfGS7D55++dX01EjlEBajcu0dybbfa5bwj/7B4jGOSmBe2I437KKZaXfvna7vxdFYaB1Z+n9P1IVnHlGesU7+VOHLG/BQ/8XRGrRvsPs0gCm/BVp72w5FT74UBsLEnsKhTTOooKuM5za6CwVhPa9m4m2dVSuCVOqtzn0T0gnfS1Z3ph4bz0Y1TyUbklz1TpA9jGCpnahKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBvY3wZ+OXr6xIyWxvVU/VMvkFLiASGdvYnJht+3JQk=;
 b=Fu7EgbHPtFX04vnGLMorqOywcDi5kpbUNw0gxlK98GonDUe86b68ZZPvVtwX28WB9ycjuw0V6h3M8WSYfdSIs2n+Rehtkz3UKQlJtDY+mApGJ9G+h/Qg8UrTGX8gaRqQouvpw9amJzr1aDyOIk53zANKZSMtYPVcMLuVGXGkiuA=
Received: from SJ0PR05CA0165.namprd05.prod.outlook.com (2603:10b6:a03:339::20)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:45:19 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::d3) by SJ0PR05CA0165.outlook.office365.com
 (2603:10b6:a03:339::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.12 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/15] drm/amdgpu: add new IP callback for per instance
 powergating
Date: Wed, 13 Nov 2024 16:44:49 -0500
Message-ID: <20241113214453.17081-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd6a6fe-9b46-45c4-83cc-08dd042c780a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X3EfsnrYFQMmYwGElGkQgXW0Gi3+r9OokrOpnwAiEmktUQpXG5EHyoArlH0H?=
 =?us-ascii?Q?NZs8IONat8Yr0cr7HE7OoX+p6NFOhzMO0h6CMUKFktsDpGuRqSy+loRqkYRW?=
 =?us-ascii?Q?mzauDnuWUZt+vmtIHiIabMw8GrwdccZcxEBUeYmEkll9SsZPQUs6HRFK6sQG?=
 =?us-ascii?Q?Pq4aVv3GnNXELchmJq9wEVBKRlxJR5SXEY2AA3P2qGulRWggocxfjkxDU+zd?=
 =?us-ascii?Q?J1vO46AjcjiDbQdxKJJnkZIIqylz90yNCy+SrqmaV0pnDIV6eJqru+Atdfo6?=
 =?us-ascii?Q?N9qyMLBSrrbjvn3bzbxrd//9Bs5q+/k2kTQh+oU2yC3xOt8cNXYPkLJDkM0P?=
 =?us-ascii?Q?VfqjbHxh76yRguqlt+CGr9aLww4ctrrAeUJGZjsuhHADZIRw/1MjTnVmJiqw?=
 =?us-ascii?Q?PoNLPz7kUwRhsd4HbiMcYqGscOsIcQUObkqCmpWPzCaGPpJHj762+b3kzXS9?=
 =?us-ascii?Q?/oDSf0NBOLKOk5M1rz/t4GgFmH8SmzpZt/f/llMKRwbiiu6GHrRqVq33kyGo?=
 =?us-ascii?Q?Iq7HL2VKxql26AclFpqf4JHp4/iz3rQe5k3V63wFZijlqAuJ0nntt1K3ON4d?=
 =?us-ascii?Q?aBIUJzRZ2hXt8JXq9UDxtuDgPyiIZx/BhiMNldjAiTVoWiaplNll6374PtNp?=
 =?us-ascii?Q?SxYOz99bXfDnEr5OKRh6PJJvqDdViInVsne2hQrVs/7LU28Y/St5Bfq/5hDf?=
 =?us-ascii?Q?86BDRlaVVzQBvht9DTZk/e9oiPGBlmR3Z8J/0qJYyPxjhZjCqAfF1zhiWiVH?=
 =?us-ascii?Q?PXRLAMJzcQSBdLQ/RLQM5uk0nVauIY3ZldxZoksciEB2kF2IMZuNAoGoJD4q?=
 =?us-ascii?Q?jTF4NE/xiUi457GQiAx6/X7Tt7j5gau2GNfKV62Owed1s7cES60SSYnMd8tb?=
 =?us-ascii?Q?Qqg9mW4MRrEK70F++oZOF5KYQZwOy2mfibOjgAakP6dLmN/LN97Ls76Zkok6?=
 =?us-ascii?Q?ynhyBiUAu4sLNS1/Wa+mn+J02iBCue6xunwt4l+KfFnN7kD9olmKDvN08V2t?=
 =?us-ascii?Q?YokycRZI8hJ0JQQ02x95HJ2AcQDzzJeMHAHXr5WxZFnpEePI512VMbJdB5yr?=
 =?us-ascii?Q?UaAR/ZbdsTptGC+MVjj9FHQa/twH0IdmM0OhAZ20h1kPqAGaLtIC/7gNv8QS?=
 =?us-ascii?Q?hkFMwmb/+BtMhsEhFKPpSDwG9Kw0Bh/1B6uX2fdaNfAp+rPAGirVxK2X8hOb?=
 =?us-ascii?Q?YcXMGpnnLeVpvXDoF0Fj4oPOarTijmAVXsI4uMxi0Slww6Gu2SMrANJ9G9RM?=
 =?us-ascii?Q?5LB39RbchPG6p/j6LErNhfxfsAzzYPo0Sj/CZAnrMU1ysDjOVhzGMWdcWjcO?=
 =?us-ascii?Q?EM8aP2ZLCrn0GmO8sE7fR/vRCw8VHNhrxBX+f48xSPQXZ+zAXKzCrdHBIG3i?=
 =?us-ascii?Q?1H0sF9kFGU5AhAgYJ3VtFnYetXRYONFx9KWtxkRQgEvZRF0UXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:19.2693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd6a6fe-9b46-45c4-83cc-08dd042c780a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

Entry point to powergate a particular instance of an IP.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  3 ++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index acb6d49bd00c..9a74cf9962f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -364,6 +364,10 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
 					   enum amd_powergating_state state);
+int amdgpu_device_ip_set_powergating_state_inst(void *dev,
+						enum amd_ip_block_type block_type,
+						enum amd_powergating_state state,
+						int inst);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 343c9f2ab1a0..6a1c6dae6309 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2164,6 +2164,42 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 	return r;
 }
 
+/**
+ * amdgpu_device_ip_set_powergating_state_inst - set the PG state for an instance of an IP
+ *
+ * @dev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ * @state: powergating state (gate or ungate)
+ * @inst: IP instance to target
+ *
+ * Sets the requested powergating state for the selected instance of
+ * the hardware IP specified.
+ * Returns the error code from the last instance.
+ */
+int amdgpu_device_ip_set_powergating_state_inst(void *dev,
+						enum amd_ip_block_type block_type,
+						enum amd_powergating_state state,
+						int inst)
+{
+	struct amdgpu_device *adev = dev;
+	int i, r = 0;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (adev->ip_blocks[i].version->type != block_type)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->set_powergating_state_inst)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->set_powergating_state_inst(
+			&adev->ip_blocks[i], state, inst);
+		if (r)
+			DRM_ERROR("set_powergating_state_inst of IP block <%s> %d failed %d\n",
+				  adev->ip_blocks[i].version->funcs->name, inst, r);
+	}
+	return r;
+}
+
 /**
  * amdgpu_device_ip_set_powergating_state - set the PG state
  *
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 98d9e840b0e2..a31a3018a5eb 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -405,6 +405,9 @@ struct amd_ip_funcs {
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state);
+	int (*set_powergating_state_inst)(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state,
+					  int inst);
 	void (*get_clockgating_state)(void *handle, u64 *flags);
 	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
 	void (*print_ip_state)(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
-- 
2.47.0

