Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E23CF3197
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF9610E68A;
	Wed,  2 Oct 2024 04:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HHnrzK9+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBED10E68C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhnqiLebcgpuXwFr1A/m77eJ/uQVYQKgV0I0dD002TwxHAg+PfxmVGUtpnqw05hK0aqdlm89uOWEHzny2nounNKrylXtRvCBwaInHREpINZGtGZDHxf63WFa2gYD1jC3E+30Vcdqjj4AsCUCVTAo7HDu++G16mueDpArYSiu5hYczT8pc4V4NhhKr8Xk2nL2vKlkS6Upmhcy7NbaOh60DKjcQ1Vy8hID5UUETFxO44wg7yaP0SN4NAKqhuYXZ1yBi8mT6ssy1Gb3y8DDcHM7eWS8Kq4VfRRnt6cPY4n7pVNEyZdvu8JfbppaUpkOU4MJsld8VBibG9bgHD7gOR6NSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvrxgA1PuUiwo0VCaYzzEqixRjztzDqrNCsfyp7vB4Q=;
 b=d/Tna03FPEMnbL2utJqRVTW4Xv46DYwlhw10kZOKGw/1hE3CyGZalTUgRQix/wjoMVT0rZEPvTCjKtI8CvXawq4AGcJNXyg7+PSTOC9+PjtN6XEZW0nwI+cWAFQZOaHG0nAG4tjngTKPinnZw+8VtXrJJ6FrZqFrnm6zRUDJbjcmZoByXTy16hlkn2ZDAnjeYBQuO0aHnKiyBuR4oPysr/Bz4Py2M9mMRWK9n2CJxdPduXnPv07MB2dBAYZWjFwMXXtZdBJkR3jXn8T5yIp6MICu2cCQXw7E6jshGVZ56hPQyNMPBV85KK77zU9RCMaI9y1W38SYnrjzdqtIheTFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvrxgA1PuUiwo0VCaYzzEqixRjztzDqrNCsfyp7vB4Q=;
 b=HHnrzK9+Ew8yDlWM6csIvD9MBgIFX4eksGuCWZPLjZAixQDobpzqG/BNkEOqj9mUWK95uWO1Aso4b9gAyOvKL55TXygP4sDmAlJj4dSYWuokYOtchbF4QEdNH/y6SJ3IvFQRzw3jG9ZMShKqUnlOxNf9ST9vp9AgjyDQNWqCvkQ=
Received: from SJ0PR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:334::12)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 04:38:55 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::fd) by SJ0PR05CA0097.outlook.office365.com
 (2603:10b6:a03:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:55 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:50 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 11/18] drm/amdgpu: add set_powergating_state_instance
Date: Wed, 2 Oct 2024 00:36:20 -0400
Message-ID: <20241002043627.102414-12-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f60d51c-3389-4518-3721-08dce29c1f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7ZbbdG32rZarUK0QkENhQ3A++wYg3XUHCLQMjJIZqbe9Ut34irJa+Rd304X3?=
 =?us-ascii?Q?Y14BOhSiK7lkglPB3PPcivaoosunc8pTuHF3TwzyulySoYSAP0jKgFL+nQBU?=
 =?us-ascii?Q?9mPjH+D53yEzj9lQGyYzgZXAUksuQ/9P4CdkUb4CWyqS2DGMqA5jnPSiNF2W?=
 =?us-ascii?Q?DL2DkmQMDJPti/o6VrxEUj/oOj0fzLTZwbUSk8gAhQyFHy9ycV1/+DIVSNZx?=
 =?us-ascii?Q?qtAhg0+51F4hDmK6crvmYGMyknNbP1kPQLr9szbNArrEcVv8EEuESlimWh7s?=
 =?us-ascii?Q?N4BzibPpY1gdUouzAAyu6Zz5Cije3pA6kI+nGgaHsPDunaEWwUGE96tvG8ZX?=
 =?us-ascii?Q?ntIlsn+YZd2tYVnK6L9SvGoIMfhXMd0DNUvAWOl7lOLMVOnItuPdE0fNYTTG?=
 =?us-ascii?Q?JtqNxgFwrv0KZzJROCcnBDbG1h8PlhDHQ8SMFVZbQdIpgQ8TBeIDEgoLGrTL?=
 =?us-ascii?Q?x27cL/XVBRTjstxYbTJaOcMYRDQaP7fEsdrSo3iIHAhx3hYu2kEKzvLfDDEa?=
 =?us-ascii?Q?LN5jsHM7cvnBxVkYrDIK7cN6/lJkeNrvrFwiufSBOORX4Eres2gBnQzQVCRD?=
 =?us-ascii?Q?OtYBfyf2aXAiTWWQzQ5d1JdYONcheyvdRNHKYK3muayXBdfxozlkRjL4sljz?=
 =?us-ascii?Q?7+gp7f4scw8t7vn6BT87MtFaorxne5s4Eh3LP6RUGBujw0Tu1AkVwKJk+fzj?=
 =?us-ascii?Q?xVHzugIYBLzxh+MA5QEayyDDZaIHEYw05wFsXsnPMosCHd8qwvrblVMszTsp?=
 =?us-ascii?Q?BwqKZSOq3RWsvzbtiKhmsdRkLujEr8kjYE1rEwmK/0v8suby8X0GfDEh9GsT?=
 =?us-ascii?Q?3zFliNtaIhdsyv00cElxfvEDqiq0+WJZ2sbRN5D6uHkA8xc73m0Thft33MR1?=
 =?us-ascii?Q?/VKO3uVQiR2IvOg44LibD4qSur3LT5RGaa7e0h8Wf2pglrnQ5Uwr8/ckxlfn?=
 =?us-ascii?Q?5PoiGXDbXbwqrxbEOe6R3XMWk5TcD0m6WKb7N5h9gOF+ohUZPWwlIGOlhIiz?=
 =?us-ascii?Q?Q9/haTG9heuJOt6NNa8GwYMRJkZMGKMnLVfeAQMvLP6SrnfsptJTz61966dR?=
 =?us-ascii?Q?sHiN5Zkk190vhbr8syhH7roUik0+O/2Jc6wZ4ggg2v0SG6uge3BgtDhCABMv?=
 =?us-ascii?Q?6sDuc8X68ae0b9X8A3BKTrfNG2t6IoY56geEObRwq0XF24vw1pyoAM6MK8cP?=
 =?us-ascii?Q?62c0p6hHrCLoVJaXDyUPABNH6cNpCgs0f/FYfMDHD74lQiiuBkhlwJje/fDV?=
 =?us-ascii?Q?VxuijDqieQyAQ4yM+xLgXxPbH+tPS+y78MosByM4q+qzPSxRJdu5TmAIsvu4?=
 =?us-ascii?Q?s31gc+bL0nzKRjrTO8zJUrf4W0hB1o2I9ZZfyUaI3kMct2saxMK/uLjQkfMW?=
 =?us-ascii?Q?JBaTKu4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:55.1337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f60d51c-3389-4518-3721-08dce29c1f9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add a new function to allow setting requested powergating state for the
given instance. If the instance value doesn't match with the one inside
ip_block, then do nothing since this request is for other instances with
the same block type.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d77db73c71f7..a6a497844a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -357,6 +357,10 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
 					   enum amd_powergating_state state);
+int amdgpu_device_ip_set_powergating_state_instance(void *dev,
+					   enum amd_ip_block_type block_type,
+					   enum amd_powergating_state state,
+					   unsigned int inst);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4bc109a0d832..dfdb33833fc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2162,6 +2162,43 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 	return r;
 }
 
+/**
+ * amdgpu_device_ip_set_powergating_state_instance - set the PG state
+ *
+ * @dev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ * @state: powergating state (gate or ungate)
+ *
+ * Sets the requested powergating state for the given instance of
+ * the hardware IP specified.
+ * Returns the error code from the last instance.
+ */
+int amdgpu_device_ip_set_powergating_state_instance(void *dev,
+					   enum amd_ip_block_type block_type,
+					   enum amd_powergating_state state,
+					   unsigned int inst)
+{
+	struct amdgpu_device *adev = dev;
+	int i, r = 0;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (adev->ip_blocks[i].version->type != block_type)
+			continue;
+		if (adev->ip_blocks[i].instance != inst)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
+			(void *)&adev->ip_blocks[i], state);
+		if (r)
+			DRM_ERROR("set_powergating_state of IP block <%s> failed %d\n",
+				  adev->ip_blocks[i].version->funcs->name, r);
+	}
+	return r;
+}
+
 /**
  * amdgpu_device_ip_get_clockgating_state - get the CG state
  *
-- 
2.34.1

