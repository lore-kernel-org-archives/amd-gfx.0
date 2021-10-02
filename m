Return-Path: <SRS0=D5He=OW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80BEC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Oct 2021 15:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F8761AFD
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Oct 2021 15:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64F8761AFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73D76E84C;
	Sat,  2 Oct 2021 15:18:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2716E84C
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Oct 2021 15:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKdKbQHlsI7NM6BZj/z4QUfAqBGaJP0lQt7tz/8hEJfHLPfGvnOHvseZeWvRCHE3XfX4m8meOpWS2HdI1GgXAHuvR9EcG9aEX0Rhs5mnlyjq2mh37Xt1Q0AYoi22Czpbs4mq5LpEwbekT4FDD6JMTFdFDityqSO5+eQbg6+KEJwie4z2GoI3B73rKKGYxxvTluPjhWAvKxoU8DAKkXOUEOmMB7qqJsJHH/nuu6RMOKoV0H40OeBWpWcJfcr3CB3RORNcmRxC3IHIcKNOsgPB5HodSpHVa+y++gXxRYElC1iKhnxx3C6Ko5HU7ZirTvAXdjfDNdWwp9yQxnE/QA32Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj6W5GbUXflWJJSIknltqnUztSMnPQ+PkVhlBpHrp10=;
 b=fkp3NzBLeK///v9OTBfn7x30sdfNG+1F4F8fLOj7tne+K4I/ripTdkrOFkYtodhIiXzSlIPLhoJ00F8Yr35+IkztOFr2XT0iRxZ5cTyf7hwr7/iNt/jrRUpdNmXunTt6kwAHiWSNQeL8P6X2Aaqwa2SNxuFObpFfNS2ZD+VLlFgtWoshMqKclsF9tDbRlYAO0+9OEbseRC+ZXeeQ6uOyK+ALCfpreo/C7KyeIfWHpDR8N01XYCrz+wFEY96aB0ZzzYRnKkU/rDKVS0vw6EIWqw/b4r+sP02+R0K8EiOMYQBXqwhAv+DeGAFQ4HKNP+7FaCktw+p7T7mH509cRQB7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj6W5GbUXflWJJSIknltqnUztSMnPQ+PkVhlBpHrp10=;
 b=AZQp5f9PoikkSScWV2ppXdzcHxlE33aRsDEWXzU+0BaLTU1PtuEMgVrtSzQ9MlX0uKfnPnUw4nQweHnQj7sLZHaeYF+2cj76TaDjLXpLQcIZm0EEAsZ/kdV7PzePCZxKt/DvCRS3iQp/R22AQiLBSCNZlHxHDzbhkmhvuXRF36A=
Received: from CO2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:102:2::29)
 by CH0PR12MB5202.namprd12.prod.outlook.com (2603:10b6:610:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Sat, 2 Oct
 2021 15:18:23 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::51) by CO2PR05CA0061.outlook.office365.com
 (2603:10b6:102:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.8 via Frontend
 Transport; Sat, 2 Oct 2021 15:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Sat, 2 Oct 2021 15:18:22 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 2 Oct 2021 10:18:19 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>,
 <andrey.grodzovsky@amd.com>, <monk.liu@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: handle the case of pci_channel_io_frozen only in
 amdgpu_pci_resume
Date: Sat, 2 Oct 2021 23:18:02 +0800
Message-ID: <20211002151802.11872-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62b5fd19-381f-457b-453b-08d985b7df8e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5202:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5202F1A007FDD5EBAAF9ABC7F1AC9@CH0PR12MB5202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZQQYpNydhul9pzoBdMZWxL3dz5nR7jleMSr11vfpXdVpDUwq6FxbruR1gy4L4ST+B/pEvCshxn6yXc/srfEJtwJs8crubTxBqSc6d67Ds8MqmtE5Hw0RvSkuirY9lZ3ZF35jSs+X4LOosmIcgLoESVNr+4kC5cxTnWS4RDvYhaHiFWellOt+2Ah6vfBBiW0o8hcLv/3HsUJXhcYCgGH47GVzBPlxf3YKa3GTL/cHjnCw6ZylTf9Sfimm9bMabN/M2cBEN8Qa/a5OM+dfBIW3c0UddPHVi7rdTXquEGPgy73Cr2s1YRazSApflbEy9tkkZibrEySUa4eZYPqNHAllQDAFvtK0PRXpaXzP+92DJOvHiZ49tBjfPO9ruQhPZJeJh/J5J5uEtEurReP6hNbKthaFc9MEkdwQ9v90Ys7xNG5LV2x3LunHQquf2oH7oHIT2rwRE/PCua/ilpQyPMfZZnKs6QZ972mfidtkYWvd+YdPIIK9jQYvGSJGiFnaBFFrnEzUTMMD9qjL6+Q8hmsGGmg0450XAIIIxJcdMO2VO3Ug1HmJ7m02hPY8B/n5DFwYk7h+iSfEiQp+ODHMd1F5Tqw5Z/gGnjEOTPoy+h8/naJ3aoM8qxVzjWqI2v/nrBvoN9mZJ7DTWltsXZoKUroQplYCkb30+89F6q07kMBhuAR5+rrQkU5cI74Hg+BkTsRSy5odRb0ci4UhQzP3HWjlEH4vEY5o8E/rA/7Hcfgpbc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(6636002)(81166007)(86362001)(44832011)(82310400003)(8676002)(47076005)(83380400001)(2906002)(110136005)(6666004)(356005)(36756003)(426003)(7696005)(16526019)(336012)(186003)(2616005)(5660300002)(508600001)(36860700001)(4326008)(26005)(70586007)(8936002)(70206006)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2021 15:18:22.4239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b5fd19-381f-457b-453b-08d985b7df8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5202
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

In current code, when a PCI error state pci_channel_io_normal is detectd,
it will report PCI_ERS_RESULT_CAN_RECOVER status to PCI driver, and PCI
driver will continue the execution of PCI resume callback report_resume by
pci_walk_bridge, and the callback will go into amdgpu_pci_resume
finally, where write lock is releasd unconditionally without acquiring
such lock first. In this case, a deadlock will happen when other threads
start to acquire the read lock.

To fix this, add a member in amdgpu_device strucutre to cache
pci_channel_state, and only continue the execution in amdgpu_pci_resume
when it's pci_channel_io_frozen.

Fixes: c9a6b82f45e2("drm/amdgpu: Implement DPC recovery")
Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f4bceb2624fb..720d0ccecfe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1094,6 +1094,7 @@ struct amdgpu_device {
 
 	bool                            no_hw_access;
 	struct pci_saved_state          *pci_state;
+	pci_channel_state_t		cached_state;
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bb5ad2b6ca13..1aaeb4b30edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5368,6 +5368,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	adev->cached_state = state;
+
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
@@ -5510,6 +5512,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
 	DRM_INFO("PCI error: resume callback!!\n");
 
+	/* Only continue execution for the case of pci_channel_io_frozen */
+	if (adev->cached_state != pci_channel_io_frozen)
+		return;
+
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-- 
2.17.1

