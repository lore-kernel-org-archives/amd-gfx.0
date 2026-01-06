Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F54DCDC19B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 13:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0481810E49F;
	Tue,  6 Jan 2026 13:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RfS87+Cn";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BAB10E49F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 13:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHB5RFvBekWIYBh4zlfIdBKHPcAApIepGLg4mZrUu7EsD8OfMo2FDSoJoxgQkKgEej+rkxtfwior55+93VGUamNtdwB6hJkMIIkSbG+/5jJ7eo5+r5Redlc69rLojoiU7GAwcosCRAsCYF4a4XLnYhINIZoaovFmlHzcPBBUZ+MKZwH6wse4601aGIc0VPuxIF2230fr467zXM858Xl/x40/qYjtjtLOk+Al9oS0ot81I2n+PEUE4/y2BoNO3Y2MUQFuMNUeqVFS1FMs/U7iB36Y9TKN/C8xYNeDn6RSbJpGOmmd/qgdDkga4ykGsawxOFzrF38Ta2P5S8V6LdsW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEjc3Ae5fawNYsoLm6igAieqLoivy/zmLK8PeA16UMo=;
 b=hEb21M9ElZgaorvLIgF1Ln2Ft+PhJo8u1CsdFVlJiHOXt/QOLSdhP0jOacx9yZnNmpyrFF6sV+DrwWeqo+xd067AMuGETpl5FQ2zxZfL+WRmLrvKMWkIDoJ1BzMhUB3tVSGAZStLDGHxZ1O2aEqRzCxwPznAGQQW8wtdVU/sbVX/ua8GvAHkoRKP/6bg5qmzIN770SjdUSxTUd0ZQYiLma2Vx+DraURTx75slOtsDaitSquMzpzK2pS5lEGhCXS7J4Dn59/WV2//SUrTl51YYZIBhqpiP6bVthPgcJ4q0Z/h194z+r7+DEqXUFt6qXuozuiwV4xhADhfb32H+l+UEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEjc3Ae5fawNYsoLm6igAieqLoivy/zmLK8PeA16UMo=;
 b=RfS87+CnxEa0oR+G/T49X1AmmBiPf60F7vcBwlBGe+I/UudWmdFVf+4TTWalSZYtmtnqYu13Jp+I2n0oQ3PYimsbrDwaFFhaPbpcEcwiioFq/Z0qGXj5eP1KbJOZT4yQX9wiIr9TnBV5BJe/AKRC+IATvPMv1LW3sGVmOoX0MtA=
Received: from MW4PR03CA0284.namprd03.prod.outlook.com (2603:10b6:303:b5::19)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 13:19:34 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::1a) by MW4PR03CA0284.outlook.office365.com
 (2603:10b6:303:b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 13:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 13:19:32 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 07:19:30 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
Date: Tue, 6 Jan 2026 21:19:21 +0800
Message-ID: <20260106131921.801193-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef35ce1-ffbb-4ad4-1013-08de4d263b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uqLxhTBqQCP1G6vsAzFT2MJXg6IE1/swXOSwyakxmvP5myzncMEdAg48Z6iR?=
 =?us-ascii?Q?7tAm6iJ6QUtGTBaJniY/oq3WHhfYrCxdrKCyGdB/MRpyv18brQ6ZHyPEMAUi?=
 =?us-ascii?Q?YzCVcwRPTNS5kmF/dmUnv4AssOkPNWuxckh3FFkBIjIUCNlwtziuM827oLp+?=
 =?us-ascii?Q?UL4rzvcuX9M9Y1dj5utV++2W9qTchI4Ip2jMgmG2I60r8NvuNhD8dJDErCgX?=
 =?us-ascii?Q?TqGUKhY+M5fKEaUcq0dlW9jVsGhXJk3DfCaCMtsSe67xtpoIzk+aWCjmp8Ok?=
 =?us-ascii?Q?haMqR9hU5kPohR3bC2ks8e0bQZlCxWSEp0bg2jO25AtAvYfGxS6ZsmRYg0WC?=
 =?us-ascii?Q?nZH3VFv0LkpbiAIPWLlA+PF3HvbSiNL3mhOB9vgL2pIDVgz5EuDpyFaS1nI9?=
 =?us-ascii?Q?UNAjTLaM2jGy1h3LdkN/DR8HMOW6f0SYuFbfPAAal+0ygJvX+t5vkPgLK0rA?=
 =?us-ascii?Q?VKCAcy1TXSra/DzVJKT7rpDYa5aZoLTHEqfnEQQNIkUuYnVTqVC2fwYxKHr6?=
 =?us-ascii?Q?ieCSfxlTi2yPISEUtTKB1/hz0W4cwkeAQYfOo2C1z+F4z5JSgEa+kPRq3I/M?=
 =?us-ascii?Q?IVopUCPI+yfH+EUUOS25Eqv4a3BC6E8ySAo/cBvE7raRhjjm9PMKyPPpr35v?=
 =?us-ascii?Q?RlLyo2h4ufgGL+WWBaVDucuDdY2d+Dt99cotHw1RfA1HdLsL2K3LA2uAtKWi?=
 =?us-ascii?Q?mnowIxDx3cBkbT4oZoGrBuN8FYBAqkd2Y4j1wOgL6OEy7LmzZiGTRZFS4S9u?=
 =?us-ascii?Q?NYDb8wDSIEqiT/KT4qpP16y/Do6oK53IdByWBozGRmg3NNah+C/GZW2Zj5bo?=
 =?us-ascii?Q?igz/wjtJZQ4ptktHONqpNmuu3qTcSY5e509F7EbI6GHq95rLHmLvBUyJjkcW?=
 =?us-ascii?Q?KyN2lAbfzmnDSc7CF14RVaZP/CFTUpl10561X8ycCSY8eoOp4MdscfVSoLjg?=
 =?us-ascii?Q?kkLaHGS+JG2cJYCfsqXlZF8eEMlJNm+Phopt53AwWa2Y7UAGDdMOofNiFXHt?=
 =?us-ascii?Q?POemYlRewwKkcWNe3E51k8hmDQNGXidSHa++otU1gFBQvCr9ndHRHGGhMQBr?=
 =?us-ascii?Q?SoFs3nxbeDBmTvnPC72dl3iOwC6ik2Ue8Wg4aO9OPys9cTWKFSQgLVaiSAnd?=
 =?us-ascii?Q?dTdsPwZtW+xmHR61aVsqTVikJqmy/tBXbzh7z3945Ugd+gPD5Us5O00YwurO?=
 =?us-ascii?Q?UKc6c25NnYAC6L/b3aTDHOnfFfaT3yXT2tVM9x76MLhxzkYCfrolOBIJcZRl?=
 =?us-ascii?Q?51t8qvg7+BOMDj8U3SH5UQTFychw+NF2SMlW8mHp6gxoOnZvIziYa2KjDYR8?=
 =?us-ascii?Q?nFQY064mUxO6F26vPsNDxvdboOcH0SqXPj46ARrHGQNcllhafur4X3fsHRZK?=
 =?us-ascii?Q?10Kvi5fpaRV/pS51m7/SYm/b3mmFtfEuMjtQdgSbVdOIeeW7dGc3GnpYL3op?=
 =?us-ascii?Q?qB4VS7wzOS8w0ExqnthMt8ZIlYo9YHVSS16MCVAcTdj5DDPuC54vvG6Bm18U?=
 =?us-ascii?Q?35zCh1TMIFHyy4xaHCr0zXDBbgANsJYZXkSfQ6xkg814daki3d6GWGwuLcAd?=
 =?us-ascii?Q?f27NBrzlzxoYHQCqxnc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:19:32.9194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef35ce1-ffbb-4ad4-1013-08de4d263b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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

Validate flush_gpu_tlb_pasid() availability before flushing tlb.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index cd4acc6adc9e..f871f1693483 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -780,6 +780,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		return 0;
 
 	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
+
+		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
+			return 0;
+
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 								 2, all_hub,
-- 
2.34.1

