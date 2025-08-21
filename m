Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CCBCA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 19:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B33310E132;
	Thu, 21 Aug 2025 19:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZLr6XNW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A2E10E132
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 19:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg6v5B/aWTpVDXumj6qRr//JSZ7Cpr4O1YZkga2LngU+W+G1a/EkgnjUvYJjbcOa6hFC74IUT/fsoneQsijpAeUMOufgZ6crdLO21u/ZVV7q0oQaHaRfvwJ06TTTAD4X8GU6vFbVw/BNnCt7ixsBSfYu+xIq1BLulgo1UWUY1xoTZ+Icif0K1dGzmKMJ1/Nr7Zfb/Qn+GHwKkjUuxwbpWSwE/nzxDKFyG/7K607ssGmCsVN8HVCH7SgXL89XNsceSHl4kFQSdmTl2k7fIf8CPBhn8ehAowxqvMTAHOOJkSvOF22IaaEoLS/TosJxRaEYVO4TcV9INeeyWvfwDy4cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f0IQZVgDX3+DSTJnKJp7uMx29TzuXHdDGd+bIyxZok=;
 b=lu7Z7LCSJYJj2Q20rqJCmKNGwaSzacUaZMx85yOLhVFUpR5R+qMK6oHLVUlWnQtZzAxCFpFJTQ46MsBAtkR7aKmyyVi/OpAUD2B2YT+qUD+U7eQ7nMkXSnJgacbU6IATgQOuAn/yDeN2QwUE9JNoLn8F6xANe2VwRD1YQUi3ztbw5nyQDmwN2ICeHYOH1AFO19vRh8HzXg3ponQO/h1yZVCqhlzofI7R9eEe34iViMNqSo75aos8Lxytb9/Zy6RCpsWzsE5rznrIhqtrF0EVtTCCgZfqJw9OOqSFBPAyC3i66OdxMacaPgViSMz387UrSm9RkAnl3SV2w+gJ68QmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f0IQZVgDX3+DSTJnKJp7uMx29TzuXHdDGd+bIyxZok=;
 b=TZLr6XNWBXF+ZuAYemXMNqezACP3wWINjTpHk3yjMmpsb7uM/H4eSUkmOUbi+QD6Q2KD09Pj/BoGhhj87+OZmneN6Y53g8XfTdqln7+R209QCH1Sa7J/xYn5YLCmdcOwyQeGLovIeeKjZDEeBLSxW0mKf1NDvq0+U3qu6BnS02M=
Received: from BL1PR13CA0114.namprd13.prod.outlook.com (2603:10b6:208:2b9::29)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 19:55:11 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::8f) by BL1PR13CA0114.outlook.office365.com
 (2603:10b6:208:2b9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.8 via Frontend Transport; Thu,
 21 Aug 2025 19:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 19:55:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 14:55:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vpe: add ring reset support
Date: Thu, 21 Aug 2025 15:54:51 -0400
Message-ID: <20250821195451.1063991-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ab9fc9-d097-4c7e-f75a-08dde0eca225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I6QcDfBgQQWb2uU9hf4C1g68JSMmnIS2ztpXv5hwj2j6q7BsI24ZFWgLaiIP?=
 =?us-ascii?Q?acVyScKiFYLdXSl43iZNHvLAdoJiMMP16Y9EAqRRIfOjPDVR3XeGH4da1rfP?=
 =?us-ascii?Q?WqXc3Mo7Ce9W4K3Lf6GTTP0hWQpX9M7WX5MBPogkiEpZjZH6zfigGw3qJjix?=
 =?us-ascii?Q?z06clSMj7LUSCtdNmKtN+KAKF6gU+OgeRHyuyBI9KqJ6+yLompa19cW8V8iN?=
 =?us-ascii?Q?6/NRC4ohaBFO3swdvL3rTwOYGthebZkzgGPTZUn5hL2kWZEPuDp9ABGYns9f?=
 =?us-ascii?Q?MM6n3r47fteZ5nO0etuCJcpfUnA7HOKr9SmrMnbWeJ4n7vHM3bb/xfG2Qwjb?=
 =?us-ascii?Q?EQU8PPyjhWHQvHVmeulM83xZV7ylHQjeUDEROb3TQ6E/aS1VEIXbhbJUT5DG?=
 =?us-ascii?Q?t9I2Jz9eScd9DC2xWCM93z7WkJ5n5hmUZoC5Et5Lu7D0AUAxwXSrAmKeTMKh?=
 =?us-ascii?Q?jruHttGI/cod/2sH7oImD+3oHUiT/eitao9jNVujcZMKgJa9561XNcXKq8lU?=
 =?us-ascii?Q?qra9WwDnJGdra/DMt3n3O2ZNsQRxIYKo9DLNkYhq9Ro+QgV7tnVfe71mlGMt?=
 =?us-ascii?Q?6YmQdLO6IVY4kbHHp/VYLxAuv8l7bSHNRf+pSDWq8T9yDzYoyjfTCPUwkISP?=
 =?us-ascii?Q?xasmkxqEmD+vd2qsAtvnloZd6H92Upi0y8/r4w+dgzjuMYBjUoOC1JZ0vFpT?=
 =?us-ascii?Q?mfuNqpzBXC8ehNlcxVhDt8WeACbK5mWqmp6ArZ0OElHiDF2AS5wPGSTnpmM9?=
 =?us-ascii?Q?nuJq8SdUVcv4O4CpLq1gl8kKNlv90eV1nvJ0PjTTbZQwWVztROgaWPSLiHWo?=
 =?us-ascii?Q?K0H9uDGf1V+hQJra8j2HIh9KINNcxCrOigIyNOXuhAxsvmQE6eD8oKrDgAoY?=
 =?us-ascii?Q?9RXQ7kyTfTxm80nmbLGJCHiyLjYc8ucXZ/C6MEHreCDakDcWhDRMYy5McNL1?=
 =?us-ascii?Q?Q2R4p5UwZuRKzoFQkKmXwiAKgIGc+ua9PCVMlSgSOXk5NvzGB7FEa2J1ZH98?=
 =?us-ascii?Q?DXm7d3Xy2niT4+4K//NpaW2nlc3s1zlY8y4JoaWwY3m4J8xhz3MC26VSOhp9?=
 =?us-ascii?Q?IF2hgqFtH7dYefjXauTzAAK8F3kxsCgfM5iAkeVDSVmlFZ2GAOyZSeVhAjpS?=
 =?us-ascii?Q?1CV1u0TzUnoUbm3p29ufpdPZi3tXUrm6G1sSAVfnqiae73IcxWm1xcMiagPE?=
 =?us-ascii?Q?lZpSWqx+AFFC7PHuPLBZKF3YmUvtrmJbVCbCeH6UOYdDVGdEgW0Mtlq7+ugg?=
 =?us-ascii?Q?M6P4hv6i70lF5cJFNabla7ybw81y1pp5IDmV6oG3rPSsje+PkWESdP8yN8zd?=
 =?us-ascii?Q?WVhHj+OmlITnKjy+QhuZO9gicUx9Uezr28GjlPGw6aBEG1mv+uRjpD4n21yJ?=
 =?us-ascii?Q?e1RP72+fmdRuR8sTS9lb1xkFF8CXfxgWZKz6auKDiYONdRVLBCUOue2QR392?=
 =?us-ascii?Q?VmYQx0tqySiJi0AToiTm6LO4H36WrPomFIUi8Pb9KWUrDt7m353KHp2fa/Ce?=
 =?us-ascii?Q?vckvr5j9b5Y8wDU2fZgyIKtdvkacJyGYYyu6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 19:55:09.3349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ab9fc9-d097-4c7e-f75a-08dde0eca225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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

Implement ring reset for VPE.  Similar to VCN and JPEG,
just powergate the the IP to reset it.

v2: Properly set per queue reset flag

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 121ee17b522bd..4cf5f273a3144 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -382,6 +382,8 @@ static int vpe_sw_init(struct amdgpu_ip_block *ip_block)
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->vpe.supported_reset =
 		 amdgpu_get_soft_full_reset_mask(&adev->vpe.ring);
+	if (!amdgpu_sriov_vf(adev))
+		adev->vpe.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	ret = amdgpu_vpe_sysfs_reset_mask_init(adev);
 	if (ret)
 		goto out;
@@ -874,6 +876,27 @@ static void vpe_ring_end_use(struct amdgpu_ring *ring)
 	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
+static int vpe_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	r = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
+						   AMD_PG_STATE_GATE);
+	if (r)
+		return r;
+	r = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
+						   AMD_PG_STATE_UNGATE);
+	if (r)
+		return r;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static ssize_t amdgpu_get_vpe_reset_mask(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
@@ -942,6 +965,7 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.preempt_ib = vpe_ring_preempt_ib,
 	.begin_use = vpe_ring_begin_use,
 	.end_use = vpe_ring_end_use,
+	.reset = vpe_ring_reset,
 };
 
 static void vpe_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.1

