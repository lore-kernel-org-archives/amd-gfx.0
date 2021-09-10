Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB66FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FC560FA0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0FC560FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A546EA02;
	Fri, 10 Sep 2021 14:26:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E8E6EA02
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 14:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXkDI0II17l+TA3fhmHRSZGxf/WQ5v3ocuksxt2t4pduXZ2n02ENwq5vxZWTX+nHjM2dCYhP99QBP4+Cq+QiUVE+vXotU6dXbRud7g8S8lEFSdV9yQFxBXLFY2hcqJhyE+W1voHSkIDxEQOAuFdBGwnDL3600PMI1qyN3oDSoxZ74clFROU0lCHnBPbakuYXfZFY9bAkShDNTQHDv3Q47ncyz6OPPggvnnUTa9sn/06zWKKFZtyllvIPzPWCjjfTojoG7QtWxnJ+yCznzPDSi4b3fFRgd4ZaJIwbdp9ucFLuaDiuLDstVyiRzYg9Ofa1hgiU/fqHiCOkCG7kGOvhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Zn4n6I4Zhm5S1eVAWvssQIMnS+y20sfTHEZlED1AjlA=;
 b=ZTB2Ruij1YUnDSlwbjwn9iIsG0i2gREfy4emO4SRbRL3e0kwqcZxr2sT4yFpt3ajmxsuyCn0EYDx/ThCYRH4c4/PHGXxfEuNpTAhceFpt6NlDIN6tsshWhKpXFUXZPyUxp8Zfvbi9zqZgXgyg0IVnt2bcyFwuXH86FnTi9c60T8IGSOGl0oo0Vm64JXHPwsBSAWxiIfnFstEen/xCR9ubeaUAXe0jmi9uta+u41VRYnBIq95XhldWxxndFJ/G2LBCZjlYQyOzkyXWwWKX5HmX7UhauQGGcMKtSybHsunZG8H1lkDn8oUAiZWc2gy7sCNxItskFWJ6LAoIvGSObM5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn4n6I4Zhm5S1eVAWvssQIMnS+y20sfTHEZlED1AjlA=;
 b=kzbpd/M5phuXXGnbL7Yw02laXSKT69SwU7ptN/+hHjRnzxs/mYlJ1bORRODzihF/A5gcs0PECxvC7CkShd/wFz0QuVpl93l29L0WPLcfY9atLLcxqUfqF7pqS1k6r5klSa1jiHFjCpHsopmj52i/Ayh6fE2IYRMiWoxG3dPxJv0=
Received: from BN0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:408:ec::13)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 14:26:20 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::9c) by BN0PR04CA0098.outlook.office365.com
 (2603:10b6:408:ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Fri, 10 Sep 2021 14:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 14:26:19 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 09:26:19 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu:  Get atomicOps info from Host for sriov setup
Date: Fri, 10 Sep 2021 10:26:07 -0400
Message-ID: <20210910142607.3182-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 908f2905-2ff7-4193-91bc-08d97466f52e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4316:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4316C37D64C9B18EB34B1E1BF4D69@DM6PR12MB4316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEGirxZ9Sum+/DCurq8tuAJXqDGWi8puEYF1f5PQ4HfhuebfLI642DSI4HWeQR+PiZGnwy18DhinQFnwL4NnCyjqiXnt0GKH31gbGbbOTGhryl0DrBddBPkOZMmYt3u3dVJiceYe9dCRnzVtnRKZjg1GA1GhV2NjZPGyoELHZ8T4t4lld3RvbLc1aobCmhxUtoSwjXteKOiPSVNFtxvTf1HVt63VCp/m9GJhTSxfjS0KoCPEhzFA9krc77uU/UefDRp0lXKgUY3W9X98ADZv/LtpQ6Ajk5nDDO5JViD+xmm0Uo5N4BH0/TxHgXvn3LRe2ScyCTxqoW6hKPvPacQvqB3JZGZNnshTmOW2qLgPrQMIA4ZogVUs6mEvetgoL8F5K3q3/RfkA5JwTXqx+TCH7dMDdbFSpVJptDJz7LUp3ycuxEidpgQ8S8QKq+ujCHlTU/Th33AwBwbVdiIyigGQrYSrS0eEdc4IGNY+w8Alh8Q7nSeW4Xh2hZqUqrp6wJiqeridBDs1TIxmZcc4ZCINUaF96qiA/bM9QtlEDcMTkB5OVhoTRuseRo4RgOc+fjJ45H9zqQc03V6UFIWz9Hbh/dCl7VLvRnF7bfZzyiDtbJx0RJsXC/I20laN2HdRJLBrxEPWcdMq+/rc4DnKhztkZGEet+yLBaBG5havf5BaxON6iydUzmQngkrujOBAvh7nWPBNvSTB0Ibrv+/ZaAIz5JKyMPbF9Wrc9x91ZG7Ar/oanPefHSJQ/OciKG1bPdn16jWJUeqOtUVi4G1kaiPIWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(356005)(8936002)(2616005)(4326008)(1076003)(82310400003)(86362001)(6916009)(5660300002)(70586007)(70206006)(36756003)(82740400003)(8676002)(426003)(83380400001)(6666004)(2906002)(186003)(7696005)(81166007)(36860700001)(47076005)(26005)(478600001)(16526019)(336012)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 14:26:19.8152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 908f2905-2ff7-4193-91bc-08d97466f52e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

The AtomicOp Requester Enable bit is reserved in VFs and the PF value applies to all
associated VFs. so guest driver can not directly enable the atomicOps for VF, it
depends on PF to enable it. In current design, amdgpu driver  will get the enabled
atomicOps bits through private pf2vf data

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ifdbcb4396d64e3f3cbf6bcbf7ab9c7b2cb061052
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 24 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
 2 files changed, 16 insertions(+), 12 deletions(-)
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
old mode 100644
new mode 100755
index 653bd8fdaa33..3ae1721ca859
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3529,17 +3529,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
 
-	/* enable PCIE atomic ops */
-	r = pci_enable_atomic_ops_to_root(adev->pdev,
-					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
-					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
-	if (r) {
-		adev->have_atomics_support = false;
-		DRM_INFO("PCIE atomic ops is not supported\n");
-	} else {
-		adev->have_atomics_support = true;
-	}
-
 	amdgpu_device_get_pcie_info(adev);
 
 	if (amdgpu_mcbp)
@@ -3562,6 +3551,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	/* enable PCIE atomic ops */
+	if (amdgpu_sriov_vf(adev))
+		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
+			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
+			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	else
+		adev->have_atomics_support =
+			!pci_enable_atomic_ops_to_root(adev->pdev,
+					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	if (!adev->have_atomics_support)
+		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
+
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
old mode 100644
new mode 100755
index a434c71fde8e..995899191288
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -204,8 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
 	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
 	/* UUID info */
 	struct amd_sriov_msg_uuid_info uuid_info;
+	/* pcie atomic Ops info */
+	uint32_t pcie_atomic_ops_enabled_flags;
 	/* reserved */
-	uint32_t reserved[256 - 47];
+	uint32_t reserved[256 - 48];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
-- 
2.17.1

