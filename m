Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42129CD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 15:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C4910E235;
	Wed, 20 May 2026 15:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k0txnuG+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC0410E235
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 15:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXPWXgEvnfG7yyy/VEsYV2NzrrqVUBCGKKAaEM3cVp+ks2JpV+88wmDYvyHrHy6teCDIB3JUoWcNEK5S2EQPW/o8QDLFCt2nLbC9f1V3VJGOXkzZtu4+OEJhrkcx/jb0gExfmXa2xhYDbA3V+NBVpxM4Yf9RNJKQwHM0Z9mcGmuHBr7QzvD7590BXJDLv8iCYTPc61OFKDe+eAJQ+K/LPFMYMu/UwVFh1udv02fGBC+aob7NDH8NVX/9OFBQwAGV3bP14a23LINYg78qjMS2hGoDETA4ZEJQPH1So2KYgVwlqiW3r1XzxXvQnlxlZ/d/LG/zUAo0na1DSRpM38LbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20NrArr5oNFHyfAwjNO+iNGymxWiSRrtVojynb3QMPI=;
 b=f1H39xJo23lUMiRmX45JrDZF1o6OS1TGDBmin0duRCWe91uHaVsEuTd8VlSmTUQpDhG1gH9yM1nIF6rEC/9+8xkkM1YYz2S96cuTuNGSJK9NXZQXZ/hdugEz5R6TN/UmXkCsykriwjeta3zEDOMLhv4y0YpYUabmNjlqwWvDXJ+Vj+T7vXRsoXDGej5ahW2lWGKDEgvpxtv93bBu4sJMbWFP8xXVM/WT0mbw5gLp4XUuF8zbOuTyvFI9cjVx2MEvrQjcGjDACKrlI5iPxoA05BwUg8PE+4RfG8e37I2MyLG5k83unwdN2jEilkQbgv5v8QXN679zXJvP1jHM5wSByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20NrArr5oNFHyfAwjNO+iNGymxWiSRrtVojynb3QMPI=;
 b=k0txnuG+QVREezylluUPgk+bOLSRyhkGhw/gtlwnab/5mt8eF6DdGeiAR0IK/nMxQPU9ChG9xCj9WpHqmXQvRGmp1YOlqtXUnLH6XoJYY5QHVjStUOtXZzfnqBVKt9vGTeRVXL9fEbmn3gIhS14dC4lXbXo53IWVH4WZL4NcNAg=
Received: from CH2PR18CA0042.namprd18.prod.outlook.com (2603:10b6:610:55::22)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 15:46:31 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::3b) by CH2PR18CA0042.outlook.office365.com
 (2603:10b6:610:55::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 15:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 15:46:31 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 10:46:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amd: Adjust _PR3 detection
Date: Wed, 20 May 2026 10:46:18 -0500
Message-ID: <20260520154618.809699-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520154618.809699-1-mario.limonciello@amd.com>
References: <20260520154618.809699-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bdcf6c-ba74-4ca0-6238-08deb686f6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: FocRn1swNfgO3MFJT4jndatEuC7FYx115bnfyZJxAbq8y5IV6/HTgfFl4RlI7p1+hQLmb6navODn5hTbX7hJ9TVk0BriBZYKy1uhg+y0W1lQI+wEjxYhMHbLb8Gh3BCiSa44ByLyNVTcqfHc6zXEhihas1UFHJes3sCHmCAWd0IMNIqXu+JiEL6HqTrh/iH4DMNiSNv9AnXxm/Lj//kTYDIfXOjuX7qe2xw5TpwQlnAUa1wt5o0VyKah4hX14E7SMJIUpuOimM7kEqevGXq+lbKsvP3P6MUsQcHSmUG+lDMF25RiKlYLOn6EVo/FqOS0MMglHXpsTyZtYL0yFdEl6qMEt7SZmXNejZhHIk8/3GS9H1IZBMs2psEyMawsBNjP2lmgBpMVET/a5ROq1teH3Jn6YAcEOBgQT4vqRhVBa7IkMaaaRf0ybAIsLPeMhk1qcCkK0xXo10LuXhNL/DYZ01Q2XXC+TFmShOdkPuKEyURID2UFQLKTEKigbCzjeqIBz3SzDQpg3tlV5k9IpE4xXQ0LowKCTk5StJhpfaNL8d8wUmkBsTIFHvxktR7AcI2FEE9KIIuaDrZ9jSJFN8Vj6WIllHCH6HtVicrZ+eIcghtSFK/BYsLEeYvdQCaBhEK8OVETvLwC8EMEBCLU+piyRcNDPF9nAM1tBxfLJ1auw2uk2pOJeJFGBo0W8JEhUkl8/n+b4QQzsXtWW7kNztvxQq28+tF4eL7BaHrzzU/FsRk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8hq76dPYhiss8/QcPuqGGJcw0u5c6fuFznnL0JJTmNDPuqPlS3Yt8Mk6A4P9w/5qxuGa1hYo7/PECqHyZglRMxc2HafC5/HcHUdqm2KkpV3VKYRv2sMPiJ0dY+j48OkdmgSUj1uiwdi6Q6fzvatgu2cH8kv5Bdh0104VuI2AAmDnWc28B3LP342HujNvDDvyIaosy/UKAjQrVRzsAaK87vv9LkjddAucCc2YY9nv+a6v8L6xqFljdlQ807p3U0ZKgdRyRaqLxyB+e7/EcYQeu5AqqE63wWCwYapX0/UrtqO+lQYp1xCisZ07Dwo1gqrDh38khIFg3d+3bzELlWIdvkFt1D8W/2O/uDIVwYhEO4nDLXXTk9gWiZMVptyAkHB9ub9ZUfgYEZzXJFEDOvB2gvG9pU8dYHBcd1RdfUkrgY5UDuCl8xvzOl8lOePKJGPd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:46:31.5297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bdcf6c-ba74-4ca0-6238-08deb686f6d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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

_PR3 detection was changed in commit 134b8c5d8674e ("drm/amd: Fix
detection of _PR3 on the PCIe root port") to look at the root port
of the topology containing the GPU.  This however was too far because
it ignored whether or not all the intermediary bridges could power
off the device.  The original design in commit b10c1c5b3a4e3 ("drm/amdgpu:
add check for ACPI power resources") was too narrow because it matched
the switches internal to the GPU.

Use the goldilocks approach and look for the first bridge outside of the
GPU and check for _PR3 on that device.

Fixes: 134b8c5d8674e ("drm/amd: Fix detection of _PR3 on the PCIe root port")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b6a24faaf78dd..7319467b11a94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1939,7 +1939,6 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
-	struct pci_dev *parent;
 	bool total, skip_bios;
 	uint32_t bios_flags;
 	int i, r;
@@ -2026,10 +2025,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	    !dev_is_removable(&adev->pdev->dev))
 		adev->flags |= AMD_IS_PX;
 
-	if (!(adev->flags & AMD_IS_APU)) {
-		parent = pcie_find_root_port(adev->pdev);
-		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
-	}
+	if (!(adev->flags & AMD_IS_APU))
+		adev->has_pr3 = pci_pr3_present(amdgpu_device_find_parent(adev));
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
-- 
2.43.0

