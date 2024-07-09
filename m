Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84207C3271E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 02:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B2E10E31E;
	Tue,  9 Jul 2024 02:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XnbdNNG4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4365810E31E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 02:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCIwKreb5uYb8M7zD2FLtqIKd0HIOW0Bhy9OkyhZDbmxMxU5z/77gCA+agBu0YMtFeu2Nq7hsa8Wtg9W74uYFTrvcRGOkGMk5c3qTI5cGdielWYo+0GPsiUsIznxZysKpIaHEmkmrq4IywT0uhaeOrD977lq4xMXgsZPFw8aAQvrRNaQU+ITlMq7qZUCfuuLpC8foB4M1CC8rK/ynwykSXoXxn9OpQ+P97Mgr1rj7HbfmF+g6BjXtTEQavl8WDKxggU7fKJZr9PpWPN5Vz6NewCIokoQx3xwYkBTJDykYVjJXA93xO4mWczFGuUJ4t1xtnwypaYwK1cPHyFXTGu/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVMeErrQoM/Y8Nl+5J8nNc/Wp2GHOHE0ytD2AdxWSAs=;
 b=Ao/aIj6l1kvrFFLjybAVZsjqO6hE6R1Ei2xd8ZznnDgNwRrRVgCpWVuIdCiSy000r5aDN2bigaeUnRxO5/9vOhA3/oiullttaxG0uF/HZatL6vMUrNsvmnS9X+Vn0kF5+aCN5M+84U5xVMJ8Fr6XsfBQ3vEpx6y9bKe2mviu5YMENvc5VLymavdi1s+SZxbrb/J1DTp/WTJ51f7Ua5c7M5qL2d5Zia56V5FzISWxX1MXdv28Jv4Zdo+0YLPidfkiqlFSI4O7+3/5Z39n/Vnna0E9K9pZSbQWLHlhDlV3tezIyw0RqoDtrJ1UeOrb9ldSjL//mMndXrdSnVd4JjXFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVMeErrQoM/Y8Nl+5J8nNc/Wp2GHOHE0ytD2AdxWSAs=;
 b=XnbdNNG4Cl5JAqVnqJvyFhykcTHcyZm7chIJ7wRbwJwS+exSxhcbCbz65pTIVu6W6ju4QDb0sSCI00Zfr7o1SkZFdXnnAlTuCwv4qu1jwatRvkXlI5DduPwBagw/0GfH3hii4CaxwyRHszfPlN/btf+163C3Cbs5t6ozvf0B5H4=
Received: from CH0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:610:75::14)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 02:28:18 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::38) by CH0PR04CA0099.outlook.office365.com
 (2603:10b6:610:75::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 02:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 02:28:16 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 21:28:08 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gavin Wan <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.
Date: Tue, 9 Jul 2024 02:26:54 +0000
Message-ID: <20240709022654.2796-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8219d3-75ff-4e10-4448-08dc9fbecaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VLXm2BbMedqcO26RCZbulKsRZEGgploUkcNIePE7HTjlOFFo/4zPR5c8Afey?=
 =?us-ascii?Q?kfcoGoU/EDi+rVSDGvAyOtXLF2xDfRfRPb4dXAX76NzJmiKh0QIA0yGvJpcG?=
 =?us-ascii?Q?5zy0xfYajXtVRFbE5jae9qcQtvwfCuhN2dqgd+HqYPZwiX5XDUYea7Y19aQ8?=
 =?us-ascii?Q?XU9WVrvsaPUQtw29PCIvqH6AVa4vHB5Ic/VlChqk9ToF9VcGGcoeYXs3o4tL?=
 =?us-ascii?Q?FAeB6W6ZntKKEFoMSvyA8LpqKNdeTbMh95T1iNA/273Qb6i0GxWL++2fCnbb?=
 =?us-ascii?Q?OaBQdGl+LzngXoyDVU/ftVlIoMIe7lu5RskKW3g0FL2STu53yw6RRe6ZHqUO?=
 =?us-ascii?Q?NidEHyHDg6usncWPO9nK91dHL7zSmqj9ovs1be9cAoptup/cMp/8J+4FirDg?=
 =?us-ascii?Q?eRPqlLSCBz+2AscyDpg2ywedS65fqEpnUfRDheK+TZvwp0XdOJuxil4hGr5v?=
 =?us-ascii?Q?FqglBoDz6KVenfkiMNhZKfnANvVLDH9nGEtnZATrJiBZig3893JdFGh3H8Si?=
 =?us-ascii?Q?wU5kCaTZ99DqboV/3x5KHxFCg37z/jlDjB+12uTBaxGgV3YCeDHnllWRJ6Bg?=
 =?us-ascii?Q?3M8EZz8YfZqefHAGDV3+I55S//7EnhCs8S6kVziZhXUqoUk8w2XXq1FcxBLD?=
 =?us-ascii?Q?qxak9+rQu2USJTaHCA2uK4Ek/cMVtgOrK92vhFEEC7fhFlROraOBGaKTblDI?=
 =?us-ascii?Q?+ZEBm3BZ6ZaeJa+xtIRJzXQCG3PijgQOhA/WntwgD9XmWGoDrk6l9Kz+LK1q?=
 =?us-ascii?Q?LsYId2Utb4/rHlZZuy9nX2HvbT1lWeFJjuQB7+oUgmiTJDno2SYRHG6GOALp?=
 =?us-ascii?Q?J3Mt6NPqNRVL/XmmlRQRpofeBDUC9PvQKN8yqCS1EsC+Uj8TB9Frt7O4omJX?=
 =?us-ascii?Q?jerTgZufd4vfLMtlojZ+FUNOZCBoKg58U0LEYHCqt+RDt/jaj8PSX16hIlgq?=
 =?us-ascii?Q?iEeUIWjCXiYMBOl/k40EvybXrHRNTLeuJQP7DSYs/ObkgG18z6RwJhflbq0x?=
 =?us-ascii?Q?/aJmJPDz5Yyv+XQKHzPBgDRnyUejFToOtWZnRMsaE8QCeLC5Ixbsb3tmREGj?=
 =?us-ascii?Q?tHW4PwiWLlNYY7BIPlC1pqthK4Ef0n7OKTdR1FKZsfxklNsDO3n1jyzXFTbG?=
 =?us-ascii?Q?olu/ngL3DcEwxGp1jn5UDGX/aFiTAY2dKDrOyWcmhZeoKdt7vIkX4I/vceeV?=
 =?us-ascii?Q?qqw3hhLb6osfKaa2UewYHAcyti16e87QfmRQT/N+16tiw5I43xf0m29WZwEh?=
 =?us-ascii?Q?yBzsuQ7HUrzLJMDWAz3wkDyfPnZK5oJ0ivkJl5Cfoah07BY9e3frIhBBvQ2W?=
 =?us-ascii?Q?NPYawL2pbjsmnAQ2DKCzW+Fm+8d1Di7THpSyOOa0fhMd4vbKMGZXdBBHa7ld?=
 =?us-ascii?Q?pGinV56klpDLOOztP6voSAdBrD00QLGzM7VZgLyTsiYDAOdnX7f4j46i8u4u?=
 =?us-ascii?Q?JKi6zL/fVrz38aq1juxu9O4weU74QF7d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 02:28:16.9724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8219d3-75ff-4e10-4448-08dc9fbecaa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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

sdma has 2 instances in SRIOV cpx mode. Odd numbered VFs have
sdma0/sdma1 instances. Even numbered vfs have sdma2/sdma3. For
Even numbered vfs, the sdma2 & sdma3 (irq srouce id
CLIENTID_SDMA2 and CLIENTID_SDMA3) shoud map to irq seq 0 & 1.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: Ie850114932ca98ea3c9176370dde5dd393ddf7e7
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fec5a3d1c4bc..4516cb0b3ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -82,7 +82,7 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
 	}
 }
 
-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev, unsigned client_id)
 {
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SDMA0:
@@ -90,9 +90,15 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
 	case SOC15_IH_CLIENTID_SDMA1:
 		return 1;
 	case SOC15_IH_CLIENTID_SDMA2:
-		return 2;
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			return 0;
+		else
+			return 2;
 	case SOC15_IH_CLIENTID_SDMA3:
-		return 3;
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			return 1;
+		else
+			return 3;
 	default:
 		return -EINVAL;
 	}
@@ -1541,7 +1547,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 	uint32_t instance, i;
 
 	DRM_DEBUG("IH: SDMA trap\n");
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 
 	/* Client id gives the SDMA instance in AID. To know the exact SDMA
 	 * instance, interrupt entry gives the node id which corresponds to the AID instance.
@@ -1584,7 +1590,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
 		goto out;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		goto out;
 
@@ -1603,7 +1609,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struct amdgpu_device *adev,
 
 	DRM_ERROR("Illegal instruction in SDMA command stream\n");
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		return 0;
 
@@ -1647,7 +1653,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	struct amdgpu_task_info task_info;
 	u64 addr;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
-- 
2.40.1

