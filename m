Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC5C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADC561989
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADC561989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C295C6E889;
	Tue, 30 Mar 2021 09:42:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737556E889
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 09:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHyzRF21WjMSJslI+jXIhV7/Nzhfdc2Ap59ZNnacUMoF7eBEXLdS75Ffi/k3NMJzecY1t3nOCRqbGqNehQmZX192bqBbjTOxf/AwReBdnkns22bzPBRwtwpJ0HbWGKW8RVb22UJjrMXTcfaXN5wTxGJAsaeG04pUg9s1WRWOD7Gyk6WS4x40dJXUYCjBJUgSAU5cIWXb7dGf/rvyvaytKFLkVzm2aOUKimCTjCpuH6lNoGntpw8hqB7pBRE2YeKux15gg4X2EoZQt3JQYTnBW76Z4aM68kyRFqJTDw2LkV58wxU+t6U/xk2Ka/FIkIFDxQMpVWgFn7UftdHNeo4Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAMHH4mZ+/49PgtofLHEYDJMGml0Hp/EnI+24CBGmlg=;
 b=SG83L0CyUVLahoqMA07KgQIBs8IZrvncHV6obH6f0SyrutZcRZfXrcMDmIM3M++U4PQlbr0AyzaXbpfiu3hMij/QgQ5qKoRPa75QC8rITTM44NsHTG3mRQYDgAUmWk++Y6pZM5RIi2CnOjkVqU9XNz95o+zW3KpH3QHCBMPnFEq9CRQT2D12vkYY9qLIE+THVnaTqDn8JkS7PhVGUVPJs3c7Ow3aSMlIaOGdWug2M4SMYhGh/IMtiRw+5r3GOw7RQYnUKatUbDg40oyC++U8UgsPr5nR+Jnwg3TKRT5JZFI23lbDj2bCrHcuekFpsqjg7hZXqmm4IfuG+x61y6T2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAMHH4mZ+/49PgtofLHEYDJMGml0Hp/EnI+24CBGmlg=;
 b=wTNLDusTqRYOGNLxxG9usE/hAMqq13vkp+BQfymq4XeOUnX3x3s7QQX0pnLDhgY42b9owkOcHuRtJFMAGNR1UrxctwMBbylW4B0Kv+HwwHmwICuGk2+t10jgEzSsxHDepITfvVouoBTtoN3/H7IYW+vSH9MkLz9dJ0YAPFGA7YE=
Received: from MWHPR18CA0067.namprd18.prod.outlook.com (2603:10b6:300:39::29)
 by DM6PR12MB2987.namprd12.prod.outlook.com (2603:10b6:5:3b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 09:42:39 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::85) by MWHPR18CA0067.outlook.office365.com
 (2603:10b6:300:39::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 09:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 09:42:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 30 Mar
 2021 04:42:38 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 30 Mar 2021 04:42:37 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Date: Tue, 30 Mar 2021 17:42:35 +0800
Message-ID: <20210330094235.69090-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3b55ca5-a1d3-4402-5d9d-08d8f360284b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2987:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2987DC3B249AEBEE792035BB8F7D9@DM6PR12MB2987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYEhLMXeEL2EiE9/fEYtIbXWBjbeEYwUEN/wUf0RigLBvgpdMNRESRD4drFCFN7uoijQGmUqDgpMuVYedPK/Kgw+8jD5ZDv4R8IAhOT6g9QZ37aGt9eFVl6v1tLWTDJk4kOYjokdQ8BXeW1eAum9BeQkvWn/ioNQoRnEwxnMwTbK2D0VtCFduGsFHi5J3mihN4kaJbml7unG/JUV6wp4NOvYTfzfaVZORfOufcDpTWZtxeYCo5duInZhOXEG+0DpxOghFGyRQoroXhp40f2IGSs7i864zpPkPZGN/UuLjGl+q67g70+H0Ec5CiCs9rPglwJA3foJpEtpnVrWT8N/6veEBXKnSitJqUY2oNjHL3Jvk5u3AARXCmOVtVvCoDGZhsoMd8iKZItXetzBfZAlmPX802/XphVQZkalivo3ewqloNqscGw/6zE1uuHfGcO5sy30+P3rE1arzGGEoVTr8c5mXrRoOjmfyqyoHxyAnseHDcYPrjDB1somblQ+VtCGHF8RUSVY5vTq8g5WTbH8Chv9iO0cJx58bFvGmK9+EIGpaCddgZG2NyP47pxlaDTHot7HP/M6DWZvbRk1nZaY0dmUsEgTrakqmOlO/v5D3Oqn6OLCRhWb20GnmhytKKCJGdWTjwHLRfInlETc85L43psfmest3dPWcuvlSivX4HZgvnAwTE0CWwPg5W06RZ1B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(336012)(1076003)(8676002)(47076005)(2616005)(316002)(7696005)(6916009)(8936002)(478600001)(70586007)(36756003)(81166007)(426003)(83380400001)(86362001)(82740400003)(26005)(70206006)(36860700001)(4326008)(2906002)(5660300002)(186003)(82310400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 09:42:38.9663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b55ca5-a1d3-4402-5d9d-08d8f360284b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2987
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Emily.Deng" <Emily.Deng@amd.com>

For vf assigned to guest VM, after FLR, the msix table will be reset.
As the flr is done on host driver. The qemu and vfio driver don't know
this, and the msix is still enable from qemu and vfio driver side.
So if want to  re-setup the msix table, first need to disable and
re-enable the msix from guest VM side or the qemu will do nothing as
it thought the msix is already enabled.

v2:
Change name with amdgpu_irq prefix, remove #ifdef.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 03412543427a..3045f52e613d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+static void amdgpu_irq_restore_msix(struct amdgpu_device *adev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_irq_restore_msix(adev);
+
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
