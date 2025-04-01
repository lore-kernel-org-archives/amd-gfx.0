Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB490C36018
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 08:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636DB10E511;
	Tue,  1 Apr 2025 08:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGVl22qz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57E810E511
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 08:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmfEOr5dAqEF9pleOIvei8vBgY/ig2sFLzFg4YUw/mTKIp8wudSxc2mbPOOucbsj9c0aBeVSZiq/4axkXcIJK2pHzdmrrt1a1Usyko4QonK7sqLZgoYCSLUFP4WsMZ/1R6+vC9/oWoHKn2GSIeSmYy6kClvkCZAH31M5x3rNL8OoyTPwpoiDx2xI0pilVCny9KkZPKihmBm5j/xD6FY0X8JMx3yrSqQL1MZ0mCGS38OyN9eCtEOGJWZfVUkC9x98LH1kq/agTRfdyYsVDK1ocPuai7sNRwfD4rkuMVi1QR/q9dJtEb2OtH+QdWC7q8R+Ej3mBEvjksflpBrjxvd1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCfUAlwovRA6Y0hC3qjrchoUaWKwRwbva1yTt3OuHC4=;
 b=nWXC5ALPfnk41Y/2GtAT3NguhzYTV6R3VRdAtaNCMq5j7TPXWKDcF09GGd/z9kSHAXi8P7qLZv0fqQMYREx70X+hRcPWvxEBqyvEyvrZXqg/0eFnR/OQWfjuOD5UV4T1VovkRAAofw0hLuzw6PpX2mSrdH3IjfQkGdP1+gY5vbpLp3gT0aG6AiTUAuNSPrsXVIK/xYcQykMgrpDgtHNvhzBI8uQ3mfEnMIJR58PVvdWevhPqE17RehZBQMOiRqOAtDCjL6GDrocvuc7zDkp+hdBI4Ail09538N1A5DybihI9rutVDax75JeufrBr/CYU3W0JhBECxlQj/Xj+sXLjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCfUAlwovRA6Y0hC3qjrchoUaWKwRwbva1yTt3OuHC4=;
 b=XGVl22qzsvQCHXYP3m0bhCf/yd8kg3Bp+mfigXyL0FU5qVpnXUYkwOGg5bzcoHeJqwOmQAQ+eFBvU0HCJFchGc2yGE5uoFQMi0hwcDxcN8rQV0lOAsEd+A8aOGb5C5fE+lvLnqkE5NysvSa17K6DpPIthrHHNXCxzOB8gdN5Zio=
Received: from CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::8)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Tue, 1 Apr
 2025 08:07:49 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::93) by CH5P223CA0013.outlook.office365.com
 (2603:10b6:610:1f3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.39 via Frontend Transport; Tue,
 1 Apr 2025 08:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.2 via Frontend Transport; Tue, 1 Apr 2025 08:07:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 03:07:48 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 1 Apr 2025 03:07:47 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu: disable ASPM in some situations
Date: Tue, 1 Apr 2025 16:07:42 +0800
Message-ID: <20250401080742.816734-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401080742.816734-1-kenneth.feng@amd.com>
References: <20250401080742.816734-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: abd7b1a8-bdda-4eed-61d7-08dd70f44b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VljcGv2P/MiSSRmei+uPUbGONOEwY8WrMbkAPtYTh1bhjHedfmAv+h7g4Kaf?=
 =?us-ascii?Q?atWu7/FqozFs67Jp2Xn162fcl7++sfaVAS8zFhi8fydR6mSGA5BHOhra21va?=
 =?us-ascii?Q?PuaPx1CNBy5COmpbwaFMSWhXEelK1HxEA33U5oq7qVkIRNBTtTUfqaPkCnSx?=
 =?us-ascii?Q?vA4HJYL1S7YrM4iNgBSEiOZ5OCNydaTQgE8P45bC6qY0fss+ONmRfdAXiKlN?=
 =?us-ascii?Q?MCMoY++rUF3LhCAxKweBT8bjqYIfMFnQacgjmwaaDwDa5K0rCJatl8zBmWHF?=
 =?us-ascii?Q?ihc4UqysKABXyYYHLJszWwdrS0nQEnum/nPH82pasTs9s/ZguZrqBjvt2LDu?=
 =?us-ascii?Q?0XOYwiTp6FtRy978dY9sfmxdMZj9U8Xk4PYbgH4fNM9xMjJ92jw1y8nI7lOJ?=
 =?us-ascii?Q?eDBRogIF+L30iG1mowurCMRYYNaUSVb3IMHycVq+ECxJXAl46ToxHN+ty89w?=
 =?us-ascii?Q?LLg+avCZYkqNsH3QsA/pid09ftzozpMGi3GpN8yaxUycE+Fw2K7o2dDPIsL6?=
 =?us-ascii?Q?ZNWh1WyjDuZoBhgp3tDAnZTgkiJErWk6DwoH7+SH7I8a+YR9q47g/bri5/Zk?=
 =?us-ascii?Q?5J6ymBJJkxNrTL/h8h7MFibax4+BAUvBOrnEpy4GyuERaV+w9DgGfECMRtFI?=
 =?us-ascii?Q?CLPuD1d03lJuLnZyT7knrf17/xaRnCFJZtrZMXoi4XsYHkP1HnqOzCYoIpli?=
 =?us-ascii?Q?QKp3Oe4kmEsT4zl5vhlStUVs55O4jOuszFGtWfK075WKEm6QTDucm8bn/h6C?=
 =?us-ascii?Q?ch3GwEbrtTaj2I6zG4ZZTRM3VB03AFnjo8n9BUIE7JjjVQqGxqJU/5X9PSGe?=
 =?us-ascii?Q?so8C/flsi2MhUnjBUABWTynp9uEI/R66x8tg1ByJIv+AOxIfrXy4UhXURCcQ?=
 =?us-ascii?Q?jM47LJs/VZpSPb2gOeKvlloGM70fggvodmwPFGtRKa4Ilg5NcGL7R1onBeye?=
 =?us-ascii?Q?+lGPrZbylig9EmpTu8TA/ymaZIxTD+W+mBJvqzZTRBwdOYy1GrYxUyvwcF/B?=
 =?us-ascii?Q?vTK2wuqGkzpDtkN4czbrpXe4gYfoePxkoqnpXW1ZscJ/zNxscOz17D2tBBjN?=
 =?us-ascii?Q?eSpPeOtpMYDGsJs58RETV+aZZFF3S3FG/IZ+qVLkdmlVY4Q8xtY2Akq6Tpwo?=
 =?us-ascii?Q?ZqFvE6UUIi/lslN7YA0Tz9vhAy37AlQhluufvX1WFMf3tVRjd7TZzURVd9Tg?=
 =?us-ascii?Q?DgTN3FeaVQRHzojDi/mmcsBLnDaYMpT2vb3wnCYIhVR4SY6+C//5Tn1QI4Qy?=
 =?us-ascii?Q?ud+aO6trK9LvKaQ20eLdFP0/VbEXEAEdk1El0JpZsUJyF6I13PTqCB9nILSq?=
 =?us-ascii?Q?r8Ajki24azprCjPSyU81bkdr+3FwdnB202zcFStDHBDUWYCjZGcUqBkauUU3?=
 =?us-ascii?Q?mEa/lQigBicgAToeAvXFvfpHK02PYZmwuSvpVbKzeW9zRtB9ujN+HfPtcpeX?=
 =?us-ascii?Q?ORLBTwc6e3kQPd58hRiN0ykLf2QX2uSMsQmH+dxk9DFnqTEOHwhRpPAgm4Ya?=
 =?us-ascii?Q?XmJ4LbjSmzIHIZM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 08:07:48.9673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd7b1a8-bdda-4eed-61d7-08dd70f44b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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

disable ASPM with some ASICs on some specific platforms.
required from PCIe controller owner.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e4793e56cead..091d87ff236f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -85,6 +85,7 @@
 
 #if IS_ENABLED(CONFIG_X86)
 #include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #endif
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
@@ -1873,6 +1874,35 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 	return true;
 }
 
+static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0) ||
+		  amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 1)))
+		return false;
+
+	if (c->x86 == 6 &&
+		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5) {
+		switch (c->x86_model) {
+		case VFM_MODEL(INTEL_ALDERLAKE):
+		case VFM_MODEL(INTEL_ALDERLAKE_L):
+		case VFM_MODEL(INTEL_RAPTORLAKE):
+		case VFM_MODEL(INTEL_RAPTORLAKE_P):
+		case VFM_MODEL(INTEL_RAPTORLAKE_S):
+			return true;
+		default:
+			return false;
+		}
+	} else {
+		return false;
+	}
+#else
+	return false;
+#endif
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1897,6 +1927,8 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
+	if (amdgpu_device_aspm_support_quirk(adev))
+		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.34.1

