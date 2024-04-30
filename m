Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5169C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 21:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED94110E490;
	Tue, 30 Apr 2024 21:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jA43Plu3";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F33810E490
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 21:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7n4dXUR7vs7HjHsAppPVE80bxXIq9EKKpPVwz5cJsnlQh4msUKWClgD2zAoQ+HYJBByzlucrHbEIAb9zkcjvSqzSFeOdWKATYcgz15p7bBcmKS9b6hUlyRBjZlM7swVRjd0jRq1sSRSbVfQshniCoxom8z+PtpXS2obGrGIjW/b2RzqtWse7QX2MDuFl58qWa6P20qS0unE0gl44HNDWKJgIzS1ognkkfPZDKqks6tsYariFMLd7I1Fl5RLNWceHfnhzjCSEEyGXELgEc5+I7ogygdhK5O4Tgxq73/qFRfN1zpbY7EDVfYmXbsDm3TPZiWkwqYaWABPYRCeRyAljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls8n6fW5ORlGQKY37l9a04we94+f22+rIV0vFArVxTs=;
 b=DFZiTuZ3+LVi7skZ9gXXR2+MC//k2HwHuxvRgEjLF+40w9J8UYfDZdnGZLbfVvc2QUBheLeJzweqbRhhoe/BYS4lbtRIGTcJ3jOxCoOzvcUx4NrjpdR5Vfk6Bza/x6hJqkXKZQsJ1nVb5u5MD66e3dlTTxWXRD/F9ihCbcMvRODG6+2/qgdfXft5sm33YNH9fTh9okBCtLKWiaUUgu9uD90VHzCOHYDWbHGxd/yeLfbzkK/VBUl/uSbt0p6UVLMhg3x2NLp2vX+pnecpc1Dkyn9JXaC8CgUBaQs9rMa5REUhyw3EPT3qxX5dK4qvXOrSvodqEBngwn12bAI1TtGhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls8n6fW5ORlGQKY37l9a04we94+f22+rIV0vFArVxTs=;
 b=jA43Plu3RP4sdkieBrRmFxTJIhOpiDu/m/bGgqeQLgYNV9KOWD4D6WhQ/1a4hc5PkKqRZz2TAuXT54+2uuGP0272+g0ei5Ci5yPL44ogV1y3VGTFvRStvwE5whizquSK5gITks5oDrNupCBdFmUcCH77k3oyRwv6jgmvvsgl4NQ=
Received: from BYAPR06CA0002.namprd06.prod.outlook.com (2603:10b6:a03:d4::15)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 21:12:52 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::8b) by BYAPR06CA0002.outlook.office365.com
 (2603:10b6:a03:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 21:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 21:12:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 16:12:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add gfx v9_4_4 ip block
Date: Tue, 30 Apr 2024 17:12:12 -0400
Message-ID: <20240430211212.814162-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430211212.814162-1-alexander.deucher@amd.com>
References: <20240430211212.814162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: dc660c44-0664-458d-e7b8-08dc695a4bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Al/RbAc1Px8HbYhlxp2bEN4teCQaoAxJqo8p+BHp5QqciPrkMJyLxXzFbcf1?=
 =?us-ascii?Q?p1MplcKoyhlvnDlb8DR/IOQMshSOoS5+bAio9u0xjqn+c5NzqGXq4a6uXkUn?=
 =?us-ascii?Q?ZJnMTqfuCbkKnJzpJpZz1LGtksfFD9Fd5DXT6dYFTbcrxN/VP+dVq+YclPPt?=
 =?us-ascii?Q?liI2yjetefXy7ZTt6apzMwXjaQLK1lonnuq/DA7eFYxpmIPVcY0ZFnZ3p7rB?=
 =?us-ascii?Q?PLPgdlCOEi+y0BOF7VBP7ZKKWX2eAPq7AM1Q21jTAnEqsNQXzmLJ5Dukr5e2?=
 =?us-ascii?Q?Q63LjOywBJ4Z8ljFPbxwY0hXxWfCCvkQiDm0SsgHIPds34Y6SBjw4Gc796Pc?=
 =?us-ascii?Q?xS0VnEk/Bnibs8mk3k3HHdDn9atcSvRe8ZjhWkizdMm6en2UJrcF2wPp6agC?=
 =?us-ascii?Q?/h6kwiPMuARSjzci3bQcXRz1vEQCeDVtIR5zLDrdz++WfVIXcMfFAkgVx0ga?=
 =?us-ascii?Q?XtyaMd5noRClvx/+nKlHXeZni58g1XqMUeSeaCOZWLREQuIsUocFK16Fg0Vo?=
 =?us-ascii?Q?IkVxbkKpzD9DkrSrwYCqe0MVE5LwouGZzRH2zQWPlFzOsPrdeIsP4iNvO67b?=
 =?us-ascii?Q?2UZ00K2jmNL6Y/aEZbVKDo7bnWeij/CAvEWvclOYTPiKPXZfFhHKyM+q7pxQ?=
 =?us-ascii?Q?SBxrjEXRCpYanhkDYMHPLE37UIwgx2fi0bQxz2PYESxjfA9m4Y7zmWtUbwUF?=
 =?us-ascii?Q?fjAwoixBPBRCdNvNEnZkEnDnE6wduLdl7dS9l0PdbGS9BpfjYF8Sv3MnSgBi?=
 =?us-ascii?Q?FXGGOEeoR7549RN/56LWuWlGen1Ss6gU4E10i+ElHys75tcYG7fGXkMaabya?=
 =?us-ascii?Q?8n4OWWEVS3Gvd4BcgwCRox6kN1k91kQr3tl19HAfPsfEfamYApADxOa6hxsR?=
 =?us-ascii?Q?RiC1oQkZzkTPopY0SzSJD38gr0M8AVGckhKy9icS6XZrIit/jQVIU9GLw4Bx?=
 =?us-ascii?Q?YVM88XCM6/oVkEs3RYlH9ZcLjygfx6a6ClgMXT4pFvqiJ00ylWU9EqxEJwsi?=
 =?us-ascii?Q?KRyDho4J+Azoo126780bxyu2SIPDZvDZ/YwQPZhbQOPCkYsV/wTBOWFIdC1G?=
 =?us-ascii?Q?cdAgO7iSueKM8ORGnKLjLjRBBAW85E/0NwBOhVq7mOYOrYoQhicpQIRq1qV+?=
 =?us-ascii?Q?2zqhumdD4d+1nCrvw/V+ctBHDpfQKgsbnvZIFtH8Ol4MA3TqVNS1GR0mIQ7Q?=
 =?us-ascii?Q?jqyMXHFsSI8Dg+OGGrpQexZBjv4mSDCXqMBCDR2VKPKZtcw/cuG6d5lqhsAp?=
 =?us-ascii?Q?uPmNsZ6rPK3I7o4LfrVpRtUTu3AIs2QGp318RpR8zJQ5WyEU/N+f9GXM9dJh?=
 =?us-ascii?Q?j0mTg+PBMcDxP7NbzdijtLElxyaLu5QWEgrkiBByA3sth1DyNRiC40yFNysW?=
 =?us-ascii?Q?t+FSHQ4IwbsbdDoz+Q78+pAWDHEM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 21:12:51.8578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc660c44-0664-458d-e7b8-08dc695a4bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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

Add gfx v9_4_4 ip block support

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 10 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  6 ++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      |  4 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 36 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 22 +++++++++---
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 12 ++++---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  6 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  8 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  6 ++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 29 +++++++++------
 21 files changed, 123 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 861ccff78af95..03a7b2c07f02b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1308,6 +1308,7 @@ static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 	amdgpu_asic_pre_asic_init(adev);
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
 		amdgpu_psp_wait_for_bootloader(adev);
 		ret = amdgpu_atomfirmware_asic_init(adev, true);
@@ -5840,9 +5841,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			adev->asic_reset_res = r;
 
 		/* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need resume ras during reset */
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) ==
-			    IP_VERSION(9, 4, 2) ||
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
 			amdgpu_ras_resume(adev);
 	} else {
@@ -6276,8 +6277,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		amdgpu_put_xgmi_hive(hive);
 	}
 	ras = amdgpu_ras_get_context(adev);
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) &&
-		 ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
+	    ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
 		return PCI_ERS_RESULT_RECOVERED;
 
 	DRM_INFO("PCI error: slot reset callback!!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8384cda48b29f..7ed7a259c79a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1424,7 +1424,8 @@ static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 	 * harvest configuration.
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 2, 0) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3)) {
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4)) {
 		if ((adev->pdev->device == 0x731E &&
 			(adev->pdev->revision == 0xC6 ||
 			 adev->pdev->revision == 0xC7)) ||
@@ -1677,6 +1678,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
@@ -1729,6 +1731,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
@@ -2014,6 +2017,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		break;
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
@@ -2238,6 +2242,7 @@ static void amdgpu_discovery_init_soc_config(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		aqua_vanjaram_init_soc_config(adev);
 		break;
 	default:
@@ -2463,6 +2468,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		adev->family = AMDGPU_FAMILY_AI;
 		break;
 	case IP_VERSION(9, 1, 0):
@@ -2534,7 +2540,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
 		adev->gmc.xgmi.supported = true;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
 
 	/* set NBIO version */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f5a0d96cd29c0..be72837c3cf23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -539,7 +539,8 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	}
 
 	ras = amdgpu_ras_get_context(adev);
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) &&
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
 		ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery)) {
 		spin_unlock(&kiq->ring_lock);
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 9fcf194fea337..a5f970fec2426 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -881,6 +881,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 				gc_ver == IP_VERSION(9, 4, 1) ||
 				gc_ver == IP_VERSION(9, 4, 2) ||
 				gc_ver == IP_VERSION(9, 4, 3) ||
+				gc_ver == IP_VERSION(9, 4, 4) ||
 				gc_ver >= IP_VERSION(10, 3, 0));
 
 	if (!amdgpu_sriov_xnack_support(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5f075f01dbf12..80974d72cbc16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1742,7 +1742,8 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
 
 	if (!adev->bios &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)))
 		reserve_size = max(reserve_size, (uint32_t)280 << 20);
 	else if (!reserve_size)
 		reserve_size = DISCOVERY_TMR_OFFSET;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 7b16e8cca86ac..07b299ec7169f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -41,7 +41,9 @@
 #include "amdgpu_aca.h"
 
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
 
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
@@ -755,6 +757,7 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2502,6 +2505,7 @@ static int gfx_v9_4_3_set_clockgating_state(void *handle,
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		for (i = 0; i < num_xcc; i++)
 			gfx_v9_4_3_xcc_update_gfx_clock_gating(
 				adev, state == AMD_CG_STATE_GATE, i);
@@ -4138,6 +4142,7 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)
 	/* init asci gds info */
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		/* 9.4.3 removed all the GDS internal memory,
 		 * only support GWS opcode in kernel, like barrier
 		 * semaphore.etc */
@@ -4150,6 +4155,7 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		/* deprecated for 9.4.3, no usage at all */
 		adev->gds.gds_compute_max_wave_id = 0;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 77df8c9cbad2f..e14acab5cceb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -366,7 +366,9 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					amdgpu_ip_version(adev, GC_HWIP, 0) ==
 						IP_VERSION(9, 4, 2) ||
 					amdgpu_ip_version(adev, GC_HWIP, 0) ==
-						IP_VERSION(9, 4, 3));
+						IP_VERSION(9, 4, 3) ||
+					amdgpu_ip_version(adev, GC_HWIP, 0) ==
+						IP_VERSION(9, 4, 4));
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c4ec1358f3aa6..671a6766df5bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -644,7 +644,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		dev_err(adev->dev, "  cookie node_id %d fault from die %s%d%s\n",
 			node_id, node_id % 4 == 3 ? "RSV" : "AID", node_id / 4,
 			node_id % 4 == 1 ? ".XCD0" : node_id % 4 == 2 ? ".XCD1" : "");
@@ -786,7 +787,8 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		return false;
 
 	return ((vmhub == AMDGPU_MMHUB0(0) ||
@@ -1170,6 +1172,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		}
 		break;
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		/* Only local VRAM BOs or system memory on non-NUMA APUs
 		 * can be assumed to be local in their entirety. Choose
 		 * MTYPE_NC as safe fallback for all system memory BOs on
@@ -1261,7 +1264,8 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local system
 	 * memory can use more efficient MTYPEs.
 	 */
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4))
 		return;
 
 	/* Only direct-mapped memory allows us to determine the NUMA node from
@@ -1506,7 +1510,8 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		adev->gfxhub.funcs = &gfxhub_v1_2_funcs;
 	else
 		adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
@@ -1551,7 +1556,8 @@ static int gmc_v9_0_early_init(void *handle)
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		adev->gmc.xgmi.supported = true;
 
 	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(6, 1, 0)) {
@@ -1560,7 +1566,8 @@ static int gmc_v9_0_early_init(void *handle)
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
 	}
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) {
 		enum amdgpu_pkg_type pkg_type =
 			adev->smuio.funcs->get_pkg_type(adev);
 		/* On GFXIP 9.4.3. APU, there is no physical VRAM domain present
@@ -1722,6 +1729,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		case IP_VERSION(9, 4, 1):
 		case IP_VERSION(9, 4, 2):
 		case IP_VERSION(9, 4, 3):
+		case IP_VERSION(9, 4, 4):
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -1976,7 +1984,8 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) {
 		gmc_v9_4_3_init_vram_info(adev);
 	} else if (!adev->bios) {
 		if (adev->flags & AMD_IS_APU) {
@@ -2059,6 +2068,7 @@ static int gmc_v9_0_sw_init(void *handle)
 		adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
 				  NUM_XCC(adev->gfx.xcc_mask));
 
@@ -2124,7 +2134,8 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	amdgpu_gmc_get_vbios_allocations(adev);
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) {
 		r = gmc_v9_0_init_mem_ranges(adev);
 		if (r)
 			return r;
@@ -2152,7 +2163,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	adev->vm_manager.first_kfd_vmid =
 		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) ?
+		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) ?
 			3 :
 			8;
 
@@ -2164,7 +2176,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		amdgpu_gmc_sysfs_init(adev);
 
 	return 0;
@@ -2174,7 +2187,8 @@ static int gmc_v9_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		amdgpu_gmc_sysfs_fini(adev);
 
 	amdgpu_gmc_ras_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5169795df38c2..8806f54df8bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1174,6 +1174,7 @@ static int soc15_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		adev->asic_funcs = &aqua_vanjaram_asic_funcs;
 		adev->cg_flags =
 			AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_CGCG |
@@ -1185,6 +1186,7 @@ static int soc15_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
+		/*TODO: need a new external_rev_id for GC 9.4.4? */
 		adev->external_rev_id = adev->rev_id + 0x46;
 		/* GC 9.4.3 uses MMIO register region hole at a different offset */
 		if (!amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 7f2ae0d15d4a5..5141d970d591c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1614,6 +1614,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
 			break;
 		case IP_VERSION(9, 4, 3):
+		case IP_VERSION(9, 4, 4):
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config_v2(kdev->kfd,
 									*pcache_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index fd0ff64d4184a..43e8cafdd8ff1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -78,6 +78,7 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
 {
 	return (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
 		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
 		KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0));
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 3c4b758d9733d..f622f96719ec5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -144,6 +144,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
 		break;
 	case IP_VERSION(9, 4, 3): /* GC 9.4.3 */
+	case IP_VERSION(9, 4, 4): /* GC 9.4.4 */
 		kfd->device_info.event_interrupt_class =
 						&event_interrupt_class_v9_4_3;
 		break;
@@ -333,6 +334,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 					   : 90401;
 			f2g = &gc_9_4_3_kfd2kgd;
 			break;
+		case IP_VERSION(9, 4, 4):
+			gfx_target_version = 90402;
+			f2g = &gc_9_4_3_kfd2kgd;
+			break;
 		/* Navi10 */
 		case IP_VERSION(10, 1, 10):
 			gfx_target_version = 100100;
@@ -481,7 +486,8 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
-		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3)) {
+		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) ||
+			   KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 4)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex)
 					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx9_4_3_hex;
@@ -531,7 +537,8 @@ static int kfd_gws_init(struct kfd_node *node)
 			&& kfd->mec2_fw_version >= 0x30)   ||
 		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 2)
 			&& kfd->mec2_fw_version >= 0x28) ||
-		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
+		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3) ||
+		 KFD_GC_VERSION(node) == IP_VERSION(9, 4, 4)) ||
 		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
 			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
 			&& kfd->mec2_fw_version >= 0x6b) ||
@@ -774,7 +781,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * xGMI connected in the topology so assign a unique hive id per
 	 * device based on the pci device location if device is in PCIe mode.
 	 */
-	if (!kfd->hive_id && (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3)) && kfd->num_nodes > 1)
+	if (!kfd->hive_id &&
+	    (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) ||
+	     KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 4)) &&
+	    kfd->num_nodes > 1)
 		kfd->hive_id = pci_dev_id(kfd->adev->pdev);
 
 	kfd->noretry = kfd->adev->gmc.noretry;
@@ -812,7 +822,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 				KFD_XCP_MEMORY_SIZE(node->adev, node->node_id) >> 20);
 		}
 
-		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
+		if ((KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) ||
+		     KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 4)) &&
 		    partition_mode == AMDGPU_CPX_PARTITION_MODE &&
 		    kfd->num_nodes != 1) {
 			/* For GFX9.4.3 and CPX mode, first XCD gets VMID range
@@ -840,7 +851,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		amdgpu_amdkfd_get_local_mem_info(kfd->adev,
 					&node->local_mem_info, node->xcp);
 
-		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3))
+		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 4))
 			kfd_setup_interrupt_bitmap(node, i);
 
 		/* Initialize the KFD node */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 54eb1bff903c7..210bcc048f4c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -63,7 +63,8 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 		if (dqm->dev->kfd->noretry)
 			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
-		if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3))
+		if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4))
 			qpd->sh_mem_config |=
 				(1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 6bddc16808d7a..542191656aeb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -77,7 +77,8 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 	m->compute_static_thread_mgmt_se1 = se_mask[1];
 	m->compute_static_thread_mgmt_se2 = se_mask[2];
 	m->compute_static_thread_mgmt_se3 = se_mask[3];
-	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3)) {
+	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3) &&
+	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 4)) {
 		m->compute_static_thread_mgmt_se4 = se_mask[4];
 		m->compute_static_thread_mgmt_se5 = se_mask[5];
 		m->compute_static_thread_mgmt_se6 = se_mask[6];
@@ -299,7 +300,8 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_address)
 		m->cp_hqd_ctx_save_control = 0;
 
-	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3))
+	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3) &&
+	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 4))
 		update_cu_mask(mm, mqd, minfo, 0);
 	set_priority(m, q);
 
@@ -875,7 +877,8 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) {
+		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)) {
 			mqd->init_mqd = init_mqd_v9_4_3;
 			mqd->load_mqd = load_mqd_v9_4_3;
 			mqd->update_mqd = update_mqd_v9_4_3;
@@ -899,7 +902,8 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) {
+		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)) {
 			mqd->init_mqd = init_mqd_hiq_v9_4_3;
 			mqd->load_mqd = hiq_load_mqd_kiq_v9_4_3;
 			mqd->destroy_mqd = destroy_hiq_mqd_v9_4_3;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index d6f65f39072bd..7332ad94eab88 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -239,7 +239,8 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 		break;
 	default:
 		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2) ||
-		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
+		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 4))
 			pm->pmf = &kfd_aldebaran_pm_funcs;
 		else if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(9, 0, 1))
 			pm->pmf = &kfd_v9_pm_funcs;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a81ef232fdef9..e32ee963eeaba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -206,7 +206,8 @@ enum cache_policy {
 #define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
 #define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\
 	((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) ||	\
-	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)))
+	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) ||	\
+	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)))
 
 struct kfd_node;
 
@@ -1128,7 +1129,8 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	struct kfd_dev *dev = adev->kfd.dev;
 	uint32_t i;
 
-	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3))
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) &&
+	    KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 4))
 		return dev->nodes[0];
 
 	for (i = 0; i < dev->num_nodes; i++)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 451bb058cc620..6251f37c312aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2109,7 +2109,8 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 	/*
 	 * For GFX 9.4.3, send the NodeId also in IH cookie DW[3]
 	 */
-	if (KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 3)) {
+	if (KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 3) ||
+	    KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 4)) {
 		node_id = ffs(pdd->dev->interrupt_bitmap) - 1;
 		irq_drain_fence[3] |= node_id << 16;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4858112f9a53b..6bf79c435f2eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -126,7 +126,9 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	if (!gws && pdd->qpd.num_gws == 0)
 		return -EINVAL;
 
-	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) && !dev->kfd->shared_resources.enable_mes) {
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) &&
+	    KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 4) &&
+	    !dev->kfd->shared_resources.enable_mes) {
 		if (gws)
 			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
 				gws, &mem);
@@ -189,6 +191,7 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 
 	if (pqn->q->gws) {
 		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 4) &&
 		    !dev->kfd->shared_resources.enable_mes)
 			amdgpu_amdkfd_remove_gws_from_process(
 				pqm->process->kgd_process_info, pqn->q->gws);
@@ -290,7 +293,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	 * On GFX 9.4.3, increase the number of queues that
 	 * can be created to 255. No HWS limit on GFX 9.4.3.
 	 */
-	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3))
+	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4))
 		max_queues = 255;
 
 	q = NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 386875e6eb96b..037e502f50bc5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1213,6 +1213,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		}
 		break;
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		if (ext_coherent)
 			mtype_local = node->adev->rev_id ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_UC;
 		else
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c51f131eaa2fb..71bea1fcb8386 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1635,7 +1635,8 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		pcache->cache_level = pcache_info[cache_type].cache_level;
 		pcache->cacheline_size = pcache_info[cache_type].cache_line_size;
 
-		if (KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 3))
+		if (KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 4))
 			mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 		else
 			mode = UNKNOWN_MEMORY_PARTITION_MODE;
@@ -1908,7 +1909,8 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
 
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
-		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3))
+		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 4))
 			dev->node_props.debug_prop |=
 				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 |
 				HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c11952a4389bc..ec9058c80647a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2073,7 +2073,8 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
 	}
 
 	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
-	if (gc_ver == IP_VERSION(9, 4, 3)) {
+	if (gc_ver == IP_VERSION(9, 4, 3) ||
+	    gc_ver == IP_VERSION(9, 4, 4)) {
 		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
@@ -2151,7 +2152,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 5, 0) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 3)))
+		      gc_ver == IP_VERSION(9, 4, 3) ||
+		      gc_ver == IP_VERSION(9, 4, 4)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2172,7 +2174,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 5, 0) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 3)))
+		      gc_ver == IP_VERSION(9, 4, 3) ||
+		      gc_ver == IP_VERSION(9, 4, 4)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2182,7 +2185,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (gc_ver == IP_VERSION(9, 4, 2) ||
-		    gc_ver == IP_VERSION(9, 4, 3))
+		    gc_ver == IP_VERSION(9, 4, 3) ||
+		    gc_ver == IP_VERSION(9, 4, 4))
 			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
@@ -2364,6 +2368,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(9, 4, 1):
 		case IP_VERSION(9, 4, 2):
 		case IP_VERSION(9, 4, 3):
+		case IP_VERSION(9, 4, 4):
 		case IP_VERSION(10, 3, 0):
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 1):
@@ -3509,7 +3514,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	/* Skip crit temp on APU */
 	if ((((adev->flags & AMD_IS_APU) && (adev->family >= AMDGPU_FAMILY_CZ)) ||
-	    (gc_ver == IP_VERSION(9, 4, 3))) &&
+	    (gc_ver == IP_VERSION(9, 4, 3) || gc_ver == IP_VERSION(9, 4, 4))) &&
 	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))
 		return 0;
@@ -3545,7 +3550,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	/* not implemented yet for APUs other than GC 10.3.1 (vangogh) and 9.4.3 */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
 	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)) &&
-	      (gc_ver != IP_VERSION(9, 4, 3)))) &&
+	      (gc_ver != IP_VERSION(9, 4, 3) && gc_ver != IP_VERSION(9, 4, 4)))) &&
 	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
@@ -3583,13 +3588,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	if ((adev->family == AMDGPU_FAMILY_SI ||	/* not implemented yet */
 	     adev->family == AMDGPU_FAMILY_KV ||	/* not implemented yet */
-	     (gc_ver == IP_VERSION(9, 4, 3))) &&
+	     (gc_ver == IP_VERSION(9, 4, 3) ||
+	      gc_ver == IP_VERSION(9, 4, 4))) &&
 	    (attr == &sensor_dev_attr_in0_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in0_label.dev_attr.attr))
 		return 0;
 
 	/* only APUs other than gc 9,4,3 have vddnb */
-	if ((!(adev->flags & AMD_IS_APU) || (gc_ver == IP_VERSION(9, 4, 3))) &&
+	if ((!(adev->flags & AMD_IS_APU) ||
+	     (gc_ver == IP_VERSION(9, 4, 3) ||
+	      gc_ver == IP_VERSION(9, 4, 4))) &&
 	    (attr == &sensor_dev_attr_in1_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in1_label.dev_attr.attr))
 		return 0;
@@ -3601,7 +3609,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
-	    (gc_ver != IP_VERSION(9, 4, 3)) &&
+	    (gc_ver != IP_VERSION(9, 4, 3) && gc_ver != IP_VERSION(9, 4, 4)) &&
 	    (attr == &sensor_dev_attr_temp2_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_label.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_crit.dev_attr.attr ||
@@ -3611,7 +3619,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* hotspot temperature for gc 9,4,3*/
-	if (gc_ver == IP_VERSION(9, 4, 3)) {
+	if (gc_ver == IP_VERSION(9, 4, 3) ||
+	    gc_ver == IP_VERSION(9, 4, 4)) {
 		if (attr == &sensor_dev_attr_temp1_input.dev_attr.attr ||
 		    attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
 		    attr == &sensor_dev_attr_temp1_label.dev_attr.attr)
-- 
2.44.0

