Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 18:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BB861166
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 18:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06BB861166
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3B66EB75;
	Thu, 14 Oct 2021 18:13:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BEF36EB75
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 18:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEbhcUG1+IXm7Y+YbkSofTCJFX6PbwspySvpMGC4XmvAgRrfJjCrpn5l39Sawl/+hENDpE7EWNvqF7KJgbJ6ISmxubj/oOr8sYUMrEVpCFAy1/bR93ve8mUvry4agU2J2ZEVvfnY0JHrK5nPbiewYuPXYw8WHhhykal2NulbFaky1llgU6wblm6ZbJMZYEhLPmYDJ/kTXis9zIfoacNo0nM7LjNU65Tel/XnxYMrhAqFiBPskJOd0HC1rvQ43Nt+xwqwl4haOugrKwUp9xID1gAiZBSIQ28UFOOsmP73ESoGd2uLOOljBOY+MZEolERYxnaFXdwpXLx6kyXIDDE+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHsvE9wPEYmhxcCVyZoh5XEDnoxAOZ02/nbHYTxJjgk=;
 b=gGfzIqTvVdJ/YSO22bUKxTwXVDyB7TNN+LxmfcTpQCWwIty9M25Th1T/ZvqZdO3FYcD6QVe1vNtiMK1E0kianPrdNcl2wd9LHWuRB8AqPHtXajYszo0dzgdXEEgAsvdLaasm/LNAFR5nhtYuJxxHVxIwt/dKZtVHbJjeN6O/d0LVI7mjzwNAfaRzDhuwlCUmdk2RkI17dA1r0mvBubmKwTLvdSlrRL91ASbUv+ao8PTG93r3OkVflH8a9otLb/9noN07EoMg67rSuP+EHVhc05+0KglmgFovwWTzRM7f8jeFagHoS+cgOWwKmoj2PWlcCW8BKx77jmc0moKAmmIGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHsvE9wPEYmhxcCVyZoh5XEDnoxAOZ02/nbHYTxJjgk=;
 b=rV0UJlRMo4GsFwG6ZZizk5L60bTGEQ29ZpPJmRR03PHz2XNeBFWk4JVEzCZxmMBo+90t9CWUMeKBZO/v7r7eRQab2XGig9Y4k1aKcvomo2YI/RpfEtvVkGjQ6pFEBUO3x7hys9EnxOOTlhR4qqYk8vDUAqMErAPSnGoALkL+fdE=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by CY4PR1201MB0200.namprd12.prod.outlook.com (2603:10b6:910:1d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Thu, 14 Oct
 2021 18:12:59 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::1a) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Thu, 14 Oct 2021 18:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 18:12:58 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 13:12:57 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Sean.Keely@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: map gpu hive id to xgmi connected cpu
Date: Thu, 14 Oct 2021 14:12:43 -0400
Message-ID: <20211014181243.3343339-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac29a33-a6e8-49b4-81c5-08d98f3e40c4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0200:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0200F6B3AE4A3F79F1F2F72885B89@CY4PR1201MB0200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXFWttAZtEVY09orGmUwnOZAziZRHLbpCxn1G7zB0DTOdmH3ADSrmuJ1sKKXHnPn59tevE0k8ghdPncO8XgqteAtfz+9MRK+mOEcIw6weoSrM+qW/ZKWgwN/xI6b0epiTNALZbUmBrnfl/6Y8X6bsubMtLzqHCbW24VchGx0BP8yv6uFp824VYlmSj36xxRafAvEg5NInM2sF4ub6SL+F/91LL2MTTV5Jw/IJujJYuvJSn91HMLr6WrV+ZkZZKoGNkrgxohVVFKC6xbJrWGXFAvns9JhmCj2D4B9N21MF/biBA/gabea8MTXhdH5vfSandAc8yiaI1fknIky1P+ED3wOwVLeBxRYTkUClSbWwD00a971oND3qEecwgVvlTJyg3dEQLB9z30tNSgD4Twl/5/uGY870BbxaC16m6OFxIikQ6TnnizM3YTcjUA8bBozRtPbEMku0+q94Q+Dr8g42ks8qYBWjn7P5Oa8Ka797A1nTOTRZGP8Vtns5skCJdt0uqxGQLwoJmrjzfNgJUjjq1Rh51Vsh+V65rXIGo9PhN2qSdmbBmpRJwGh8BKunBsCZ76vDgNVMsQKAA6N5e2j/WcZhtk/4+Mf1xMC3IyYy9aE60vO80LHQsGPFqYFbBxOt8lTeb6N5pPDoyv6DEMh5bTjQ8vv2BbCSnkKQRNPamNgPqVumX/qYi2KdV9EpS+QR2TYa6SC+dVDHXAJ6F+qAdL6bz/85/0ah5RM9WR4xxo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(26005)(70206006)(70586007)(86362001)(36860700001)(4326008)(54906003)(7696005)(508600001)(44832011)(36756003)(336012)(426003)(2616005)(1076003)(8936002)(316002)(6916009)(47076005)(81166007)(186003)(8676002)(16526019)(83380400001)(6666004)(356005)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:12:58.6570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac29a33-a6e8-49b4-81c5-08d98f3e40c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0200
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

ROCr needs to be able to identify all devices that have direct access to
fine grain memory, which should include CPUs that are connected to GPUs
over xGMI. The GPU hive ID can be mapped onto the CPU hive ID since the
CPU is part of the hive.

v2: fixup to ensure all numa nodes get the hive id mapped

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 98cca5f2b27f..9fda4ee03813 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1296,6 +1296,26 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
 
+	adev = (struct amdgpu_device *)(gpu->kgd);
+
+	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
+	if (gpu->hive_id && adev->gmc.xgmi.connected_to_cpu) {
+		int i;
+
+		for (i = 0; i < proximity_domain; i++) {
+			struct kfd_topology_device *to_dev =
+						kfd_topology_device_by_proximity_domain(i);
+
+			if (!to_dev)
+				continue;
+
+			if (to_dev->gpu)
+				break;
+
+			to_dev->node_props.hive_id = gpu->hive_id;
+		}
+	}
+
 	/* Check to see if this gpu device exists in the topology_device_list.
 	 * If so, assign the gpu to that device,
 	 * else create a Virtual CRAT for this gpu device and then parse that
@@ -1457,7 +1477,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->node_props.max_waves_per_simd = 10;
 	}
 
-	adev = (struct amdgpu_device *)(dev->gpu->kgd);
 	/* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
 	dev->node_props.capability |=
 		((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
-- 
2.25.1

