Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31616C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 06:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E0760E74
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 06:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6E0760E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749EC6E088;
	Wed, 13 Oct 2021 06:16:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3074C6E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 06:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hnoi/MMkgNEnJsWbRc591k10Q2HfY87x0kTP58pdn24qqOy8ek3W5ejmksCY82a7X7dhqTj7OEHnjMheoYHIW6pRtvoNOLMxJPmeiCM9SkRpxK1onkgM96bKtirnn8gYOa4ZrjJ93ZRnToYJUItdfGbp6wmDmykh+/UPdhy+2XEpmpVvaXahKygrnHWnd4ALYaSkKPC8LBo1DpKGubKBJvZolVs73wmPQiMAZRE19BL0KFuaviMBdCOLJAP0egeyCQX2YEupCgptphF8TO+vNgUVDJRT67ZkWuxTXhyP9IloYaEcJPvHFtM1VzfvCNqlT0Utt4mqZScPccnko9xtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE+9/JTsOQ//SfbwWjxM4AtxvBqv2SiqgCevJdYzIr8=;
 b=BDWVKmU1wcfplCw24mZcPR/LpAoUruo0TWjVvNdUgotcgATcdom4hfL3s3FpwIHjkB25iOPFxPkVKEHo+C5eyWbDFG3RAloY1EgKX3owckgAoNr4KnG4h9mLIpNajkT340wiaE4lQEdF5CbosKo9rXIv1l+TIeHQU9j69jgCuARc+mnCHGFHxSsP7Q6e1uHe0ElXIyzUJsv/Z7eCn+tR29pehljFMIWAhl/BzHmkPyrFyli+VOmqaplmTnTCx1T07lzXTfZrdYjOmCIjzixojiHkOKn68ccPr9HpBaMonjtrWq2GSUNiroZnN+aiD1YtSY+JyVk5Cxx4OFDqKI66JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE+9/JTsOQ//SfbwWjxM4AtxvBqv2SiqgCevJdYzIr8=;
 b=ApQaNU2ieAoXyAp8NYsf7GSTHBXZ2mujszo0BLaZaCuwlCV0BOWKOJ98Hv+JUKLdZyPMRNXD0XmR8JD4ZS72qDAdhfaUWdAix6sKftNgA5XRkaUSnpdK4/YMlzn4soDbuInaS+pclxOI053RytYQM8f91pDVKPGyRWf2qBuimWo=
Received: from BN8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:ac::42)
 by BN7PR12MB2707.namprd12.prod.outlook.com (2603:10b6:408:2f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 06:16:25 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::fb) by BN8PR07CA0029.outlook.office365.com
 (2603:10b6:408:ac::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Wed, 13 Oct 2021 06:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 06:16:24 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 01:16:22 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <James.Zhu@amd.com>, <youling257@gmail.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: fix boot failure when iommu is disabled in
 Picasso.
Date: Wed, 13 Oct 2021 14:16:03 +0800
Message-ID: <20211013061604.3404343-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: accc731f-c078-4ef6-a03d-08d98e10fbfc
X-MS-TrafficTypeDiagnostic: BN7PR12MB2707:
X-Microsoft-Antispam-PRVS: <BN7PR12MB270702BC492361CE1E4DBFA9C1B79@BN7PR12MB2707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUGDxRrUYvmPXCjhOC0nPWlL9qfPQYdqoeMudeuVV7B1u8RZqubCqFg0Lvlp9KZnqiQmZrRxOF+E2XiceOPLhgWsJchEOH/XfxWn+FYoxblO6SB7QPIi+5G90HYApz6D48QqGvSCtYevW7wRw0DJ5qgScE7VEbj31bdiatbTJRdrcgOUU3egEtTPCdG7OuT0Js0JeD39l8fKb6X5njCq7NEMMnDVGVE5PyQf0XoQMous/fwJ9otAJJaGlqxCVEB/khwNsM9UjxVwx6qPw8Hlx/vXcll1IBaAMRxk3CraB9NrX1baa2yr0oOaksp3IFvBxsSWJ7T6qxgVXtlerWsTjT/owJHtt0lQE1PZpnSdB1jA6bSkpe8Rz7DjYvyg6auDrivuu14Zg1XTlTsof0XfQJFwRweNem3xrKBXMn7PfcM7LAnOj2ApYFFt5BQxv3lx01XYYcmiA6hyfcvnsi3c68dKgpefSjPdOgY2+yvR0Xx7FkX/U19KL+7YaOPavLUIXiX+BUP0V2VJfQirdNHKdvu/gLZmK2S4Nv6vWxq9MFEg3osmGOGPfOFiHPeT0+oFuYVzLRTgKVciwpQRTkb4G7dnOirdFUuUwEvZzGcwVd4aL7e7ExAR3VxY3r4+J58qXCXVnHDtbEqSBV/yQ7VA+fxinZNAxa61SbNTX0GKOlcbo9bcLD7IGW4lPclIVAo16HLFqNucBqG60u3aaNcyj9lA2t9W2QobIxIwrOoC+U0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(82310400003)(6666004)(7696005)(86362001)(47076005)(8676002)(426003)(186003)(36860700001)(26005)(1076003)(16526019)(54906003)(316002)(508600001)(36756003)(81166007)(70206006)(4326008)(6916009)(8936002)(83380400001)(2906002)(336012)(70586007)(2616005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 06:16:24.7474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: accc731f-c078-4ef6-a03d-08d98e10fbfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2707
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

When IOMMU disabled in sbios and kfd in iommuv2 path, iommuv2
init will fail. But this failure should not block amdgpu driver init.

Reported-by: youling <youling257@gmail.com>
Tested-by: youling <youling257@gmail.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 52b24334a19e..ef467216ff8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2397,10 +2397,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 064d42acd54e..08eedbc6699d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1029,6 +1029,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init((struct amdgpu_device *)kfd->kgd);
 
+	if(kgd2kfd_resume_iommu(kfd))
+		goto device_iommu_error;
+
 	if (kfd_resume(kfd))
 		goto kfd_resume_error;
 
-- 
2.25.1

