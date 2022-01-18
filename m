Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D813C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 11:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4CF10E2DD;
	Tue, 18 Jan 2022 11:27:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B6B10E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 11:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1ycnjsMGKeMTDx76vAn6nVsCUXRD9kNwWV0IKzPkb/2e4riCvbmqCY5WWPDNJYVtkg3cwS8Et2tbtVwTXt0MNcvlRHBjda4hqhNIgkXDrblYtX5F0NonaevtV4yiaKEzGPGTvA0+nr2bmbeKya8JfjTxtJwwtqHYNz/PQT/DXs9nsELJj/pD9dHj/wudKa92SZIloq4DQLjrpVAuGNFSarWq2TkSuUlaWbET4jmAqPr2qpHeKe9mDEvyixrzzmNqwaPDoWos+p8lS/5DsYiQ6D6XxiQCIb4tiknajGxPMy8oqwkoGh/YH+cpjXtY8m4VoRkpGaoaHwONDoNoZg5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+TwIFgRdbJLPf8Wo1Lj/2wwG4ccV4XXF1kWmOMOjqY=;
 b=IZ3KFYQsjP/a/P4tBiec6SudWlpo6WGBHsHbxqjV86rjZiPnP8WORD0OCkKCBidFAJZeQD2HR0/MNy5lM75Q49Cs3hQkB3coPMYphQ3AkPyCI7UIc80HiG9YnD02j7X7yi8AE+EENYW42MI+69N3GEFgG2rPNje9dAMekuowNwWtUBX6IRnxb4wL3yzQxuSkj8bKS/AKTV+NW5nmgZ1wzL42C2+sr04gco5jbZveO7FJhbB15rLJtMq/lt2952OYNvmWHQVjNAWlr9FO/8Tvj9yDOlzXEkzBGaItNIDZ6KRwqlRlSEp6jbpDqRUXv9gIV6NZ8tRYPdqR7Dd+qYvB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+TwIFgRdbJLPf8Wo1Lj/2wwG4ccV4XXF1kWmOMOjqY=;
 b=xq/EU9TJCzerJQnegShGZzax4H/b20G9YT2MQ1ZZay/D3vCFAL4/FIHhzv8OVduuq87xWieXfSfD6YtZMOyGlfH9FqS8S5kiBJGVOldL+BCVJGm/EoJcLxdeO78GuaD2mUlzUiJr+/3+iAl5PWEQosiWAG2CQITf6rBqYCTWj6w=
Received: from DM5PR12CA0018.namprd12.prod.outlook.com (2603:10b6:4:1::28) by
 BYAPR12MB2997.namprd12.prod.outlook.com (2603:10b6:a03:db::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Tue, 18 Jan 2022 11:27:13 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::f7) by DM5PR12CA0018.outlook.office365.com
 (2603:10b6:4:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 11:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 11:27:13 +0000
Received: from jenkins-MyrtleD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 05:27:11 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: modify a pair of functions for the pcie port
 wreg/rreg
Date: Tue, 18 Jan 2022 19:26:18 +0800
Message-ID: <20220118112618.16000-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 676b9ae2-a4e9-443f-b03d-08d9da75797a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2997:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2997A3C0EDC2B7F6282187E2F1589@BYAPR12MB2997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXM/nR6Wajb/9veSFT/ecS6ic7IUMZNljSuqlNDuycjJD71gG2hENXUxNcPE0lz7JIN5WTQaqHcPH/AFUbZsD8IdwVyvVk2v2JEACkOA+CtIHJbzx2FQx+Gk4+cI4Kct+hCbliVbsQoLBLFstFPw1pAtmYBn8AbdK8R3pQLzwcfwPM79qz4z1KlCdknCDpE09IyCyZPW+MOiFh3DFvnWBNBXPJzBInrSSrswBkS3oC1FkrYWa/lERUGvGPp3t15J/XprvnfBk8Z1pA2a6EZcjdHmEiZQ5KsRCYEMTGC5Abe655TU7FdOfW4LJgN2r0DMvYWO584XvJKmmybH0Qa81lOBYpH/dCQ5cCVEk2A8Tu8AUlWiUSZ9n6xYJ8PPv5BPzy1lfjTHERmiPE/C3t4I7PQT2z7awf66efHcqvIsR2I6LHl+48LpQIn/jjr7KbEz+IB0QLUJfPy/d7dseqfMLyy2eG4QZ7Hb/XVXiHaCvOJ4ANNHpHQZ/5u9mGwnda1voYeGjN6fqLQKLQGKZqJ8o8MEJdCb4t6RvDJe3WE6uhm6j7Jww+TZFIf8xckgFasTVDo18vuvNqheSB4ILyr0QYVBpeAChNZ0cdbejWheaKCzDz+BBXosfmMSyM3O9YlOjcHAC+ja3gtI1e+xMdoPW6Q2JStv62sByVIAbtNzpukB4ss0mIQ9e9gaTbGyYIGDBFKzoY3mccbnpi7u2jTu2b5+Xt5apS9jUk3qol+AbhiRjfSKVEzDQCc62pA89p4T+X7WbH5KAfe7uTErUdLd0/0pGQ5LFQ7X+p+L4tt7Tgc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(7696005)(70586007)(426003)(6916009)(5660300002)(82310400004)(70206006)(83380400001)(316002)(54906003)(336012)(36860700001)(8676002)(356005)(2906002)(81166007)(1076003)(186003)(508600001)(26005)(4326008)(36756003)(47076005)(86362001)(2616005)(40460700001)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 11:27:13.2967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 676b9ae2-a4e9-443f-b03d-08d9da75797a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2997
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch will modify a pair of functions for pcie port wreg/rreg.
AMD GPU have had an independent NBIO block from SOC15 arch.
If the dirver wants to read/write the address space of the pcie devices,
it has to go through the NBIO block.
This patch will move the pcie port wreg/rreg functions to
"amdgpu_device.c", so that to make the functions can be used on the
future GPU ASICs.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            | 34 ++--------------------
 3 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b2da840f4718..691d7868d64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1421,6 +1421,10 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 		struct amdgpu_ring *ring);
 
 void amdgpu_device_halt(struct amdgpu_device *adev);
+u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
+				u32 reg);
+void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
+				u32 reg, u32 v);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ff4cf0e2a01f..10f2b7cbb49d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6023,3 +6023,36 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 	pci_disable_device(pdev);
 	pci_wait_for_pending_transaction(pdev);
 }
+
+u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
+				u32 reg)
+{
+	unsigned long flags, address, data;
+	u32 r;
+
+	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
+	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	WREG32(address, reg * 4);
+	(void)RREG32(address);
+	r = RREG32(data);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	return r;
+}
+
+void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
+				u32 reg, u32 v)
+{
+	unsigned long flags, address, data;
+
+	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
+	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	WREG32(address, reg * 4);
+	(void)RREG32(address);
+	WREG32(data, v);
+	(void)RREG32(data);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e52d1114501c..17480c1eeae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -256,21 +256,6 @@ static u64 nv_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
 	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
 }
 
-static u32 nv_pcie_port_rreg(struct amdgpu_device *adev, u32 reg)
-{
-	unsigned long flags, address, data;
-	u32 r;
-	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	WREG32(address, reg * 4);
-	(void)RREG32(address);
-	r = RREG32(data);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-	return r;
-}
-
 static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
 {
 	unsigned long address, data;
@@ -281,21 +266,6 @@ static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
 	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
 }
 
-static void nv_pcie_port_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
-{
-	unsigned long flags, address, data;
-
-	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	WREG32(address, reg * 4);
-	(void)RREG32(address);
-	WREG32(data, v);
-	(void)RREG32(data);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-}
-
 static u32 nv_didt_rreg(struct amdgpu_device *adev, u32 reg)
 {
 	unsigned long flags, address, data;
@@ -709,8 +679,8 @@ static int nv_common_early_init(void *handle)
 	adev->pcie_wreg = &nv_pcie_wreg;
 	adev->pcie_rreg64 = &nv_pcie_rreg64;
 	adev->pcie_wreg64 = &nv_pcie_wreg64;
-	adev->pciep_rreg = &nv_pcie_port_rreg;
-	adev->pciep_wreg = &nv_pcie_port_wreg;
+	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
+	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 
 	/* TODO: will add them during VCN v2 implementation */
 	adev->uvd_ctx_rreg = NULL;
-- 
2.25.1

