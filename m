Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE02CC35FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 01:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B751810E23A;
	Fri, 14 Mar 2025 01:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wgCfSS4c";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927A510E1D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 01:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR8pZ+tf2NjXVJM7XHnlwzNr1gu/3tNu9t+qQUP0YpQYIbTf1RKzEvybO44CvH+EQ9mErSvbmqpVluXQQpLNdfGO8jRExwT0prADnyrlvt2Hzho9nRkIfsQkbW1lFSNuR0fAJWMPNH/Z/3ghp0UfdpVGLkAQo4qVmfbBVk/Jd4RZndT51i0OqTS/UK0JROAA4KbRTau+KDaHqAYUepaEHrYkXgmmW5b0xbReZsKuJ+eKhZqL/pmdI9FuG0/AP032m41e/aKKK9/VBT1/fQqpVc6hHmg3btJTHv0Iwa8GckMibCeMS+CyKzYBqeHMBc+TUKMi++HVqa4SbaY6dwO78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3gAjWGhyuvcoCNrkxm37wElmL16VmFvzjJqRPZhYPE=;
 b=vfliAWqX2cEnImOfOQmulnbjVhmMhiKV+0LwcNDRvvut72oW1bKQv9qP+RPsBakrUNvUiEk+QtU4O4uv+wUWpmKWFHLuW3LvKIkpV9VMRnWutop73IeLet25ek/4wDUfC5pwxDGIMCL3GdqKS3FYSmqL234pUYynS865ON8wQckzhC1g0oL6Pd8so12pxEYLoO1bbpAf9claepxB6HMA/CHCdHLNpjIBbqQn/WWJ4RpkeVcv+FP3lnzcOGQ+HbpMWN5ENyN0BjR0Bk2MHWle5UVP4i4r2RFdaaVcW4MU4PxWxo+R8XW86zQfPO3tmV0G0pYvkMXbCYc6QqsgttO9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3gAjWGhyuvcoCNrkxm37wElmL16VmFvzjJqRPZhYPE=;
 b=wgCfSS4cSwFgG/eEIt1YB1mjFCAAvG5sK/Nffyta6heoNhD3SPNAW769SdBFVf4mXfSy//QU/rsrWPOD1MkI8rcSKKUECUQuLXh5PGHdgir+SRl6VIy3KaHtBN2WcwleoWj0eqrz5xGY6JPUGodIkm+PcQyqu/BUqbElCo0BfLI=
Received: from CH0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:610:cd::29)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 01:02:08 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::2c) by CH0PR03CA0114.outlook.office365.com
 (2603:10b6:610:cd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 01:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 01:02:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 20:02:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: don't free conflicting apertures for
 non-display devices
Date: Thu, 13 Mar 2025 21:01:52 -0400
Message-ID: <20250314010152.1503510-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314010152.1503510-1-alexander.deucher@amd.com>
References: <20250314010152.1503510-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d7e39c-68e9-40b3-746b-08dd6293d7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w04H5DUo9Sy5cPO3e8gMAV+prVDMTFuDBT3pwZfQjQ4IWsUHzbSe3UCntCIl?=
 =?us-ascii?Q?kE+0Qewe4psssZ0NutFpTmQiCxSTk8wEhDRGywVoDesxT5TMam9nh7QYuUv/?=
 =?us-ascii?Q?1aAKZR4l9UodYLiX0og0Rys0MTr5i4zDiENVm6f6SrDhjTzTNedi1XCtsfYJ?=
 =?us-ascii?Q?aTAY5DpSuxFW0Lnf76gx+SHN1if5pMd7Sjn6gKzVHQX5/hP9ThNcUIw+H2v/?=
 =?us-ascii?Q?FHxGzzKpoNpBWapMMebnbPCTD9gmhAtYQ/i0EC4P2saglhWdWLL/Zs9whfwC?=
 =?us-ascii?Q?DpiCrBILZlyCbcx5Jxyf3sKUbk7zSdf5/tXyXZYaZVYcepZUCxAgoxbsY4an?=
 =?us-ascii?Q?EE46wEr3PN11y4OkRJ/XmGxroOy0XMABaW9KbTiyAMWlHHzHr0oGR108ORJm?=
 =?us-ascii?Q?TsV8Zv/9qOXQek8J1D1q9cWiJqF+oLjtQZzplvl0GIUTXBw4MPnT/BXcphnZ?=
 =?us-ascii?Q?M7O9FXnH9iwx0XSZU2HFTTmYFG0q7koznn6mexrpgNL7hR2kHX8jzqRBsOSk?=
 =?us-ascii?Q?n4fZT9amx1mp33JfcZ98ZemA0RdCVQ6z50m2OFk3x05wUJAuOknUwP8s1ABj?=
 =?us-ascii?Q?fJudH0NTKq9TfX8ylx/cS4A33eXv7KbqV024N4g83MiicqrCnLrJZS5ihmFG?=
 =?us-ascii?Q?rTok79xZALjutAoMPKxMfrQMvgztHs5RTrHWGGk3RtU8zdosBcmLRNxMHOjO?=
 =?us-ascii?Q?Ome61U7P80LJKSYGdMofFXmJDA0KQOYmRm0ox8gTMgB4EbqiYinJuEqLvgkR?=
 =?us-ascii?Q?QOc4F2fhXOi7yOdaGkILCv2R6I10ZkYsx4Cq+SMrpY8oqwZ7C2Yhavbz+uBJ?=
 =?us-ascii?Q?NsdkJwCRmZrWRM5V3oFRshDWyJ/mEfRsLseQoDuI+Tj0tSsM7hsPdpd6/Pek?=
 =?us-ascii?Q?HMpmMWxMY4WR2cAgs2Wl0XUxZxF4Y2EzjF1tl2Ir3bBNsJsP5bpf5X0IVoIa?=
 =?us-ascii?Q?UouqKk7HCzfoUCEnd3hUKyCm2KkG+bRM/DnRqQDAv3/0s4Bm5byT1noGW8dg?=
 =?us-ascii?Q?1P3xZ51Yncjupc/js+5ERWz05ntvtHqQwkKM4JqMtV8SFq1WXl6MNVMIKFFc?=
 =?us-ascii?Q?Y9yfpSi9rQTJM13N13qvHwl/cpusDOnsKSIXl9GiB+fa7xFNZ0iqCta2Bqr2?=
 =?us-ascii?Q?fqd5CTe/e4TjPe7S9D3VTE6VXMHvPqaptyQ9rNmn7M0kIeBzkIrIGWG1l8VH?=
 =?us-ascii?Q?ZQFnjciQnP4zZjrG2qPkCvoBDofaHuPLcn5/0BYTbJmxTP6AftdQfxcTHXWH?=
 =?us-ascii?Q?l5PBkiOgD+n2DUT07cGz/Act1OiCC471PEkC3C96lT74DqKpnH7JoB+SbYhW?=
 =?us-ascii?Q?/HMGPv24aasm+zc/+sdSvHFmnPIzIAxenGf92IJrxkFZyPRZFNXGLo7M/p8H?=
 =?us-ascii?Q?7UwpwQUS5dwuUd9ZLfm3L6tPOV5bhGOgi2D5kWFwG5vOpY981nUgA6TIHwEo?=
 =?us-ascii?Q?kSQZnnYe9FUqGRRri/UaRAsC2BkD0sUGS8vOfnCm1jaPRbR7mpaio/nA9JHS?=
 =?us-ascii?Q?y8znVdaaYebCVFc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 01:02:07.8362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d7e39c-68e9-40b3-746b-08dd6293d7ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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

PCI_CLASS_ACCELERATOR_PROCESSING devices won't ever be
the sysfb, so there is no need to free conflicting
apertures.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1eff6252f66b4..689f1833d02b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4401,10 +4401,17 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	/* Get rid of things like offb */
-	r = aperture_remove_conflicting_pci_devices(adev->pdev, amdgpu_kms_driver.name);
-	if (r)
-		return r;
+	/*
+	 * No need to remove conflicting FBs for non-display class devices.
+	 * This prevents the sysfb from being freed accidently.
+	 */
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA ||
+	    (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER) {
+		/* Get rid of things like offb */
+		r = aperture_remove_conflicting_pci_devices(adev->pdev, amdgpu_kms_driver.name);
+		if (r)
+			return r;
+	}
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
-- 
2.48.1

