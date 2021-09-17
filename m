Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13513C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 11:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14AE611C8
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 11:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C14AE611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59ABF6EC25;
	Fri, 17 Sep 2021 11:31:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E22D6EC25
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 11:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHkMaSMBcOFP0VGdcg8mANtVxzTWY0OIqF1WYIUnp/3+GYPTqwwUqRuBwEP350O52OTETXx3d49BAx2qDJ8MT3rb5BYUK39D+uPUNC9bgEc0bEbjg3PznflwmppK34Unrc/dpBAWfhZlBpcC7rNADyMPE7Tn5tNMXBjhz4v7u3h8EBSFotKVI/Oi2kmJeuw9hbZFSKp4//lLxmj8AT9BRgEKVMkaGiJW/j/f16LjolLLX09QR6R/W4m9NtTv5CZhUAQ7dBEfC18WSs4JbHJRpd30o0SQJcXjTLfufayPsEpjPwSXwDbXI4r4UsJ3mpzKeuxRSj8HpBMravsz9/IE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=tDkHhDGxSOL2ssAdl/QT6biKDaHL6hELbZ32UtqPCLs=;
 b=asuJ7L1IISxSC5eKYASEZ5OpGylLess58Cj5RMkqZVzGgATTqPVTKYjyyyrM2eAEfN/wo3jFw1L6gZVcejh6ZoCqQuhJDBjZcuDNVqqxpfbamErmSIbf7efzGcH0owk1svPFZyPlhpqiqfD881ws55RezM62ftJpMhAc4GzIxzYrvYTk0Kax0b8Y93IrzSEy367PGu8uBUxiiXwPt88SWUW86dQhQq7W60DGYIVsZQr+QsyUXdS1O2kI0YS7bpmzGpFiMPnCN5Rk3T19C4C1fmww318qUXOBvvNeUKFy0ExmsuJiV0TGLJMSmHqNPI322bsfFWXpZ2kUcontUDUz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDkHhDGxSOL2ssAdl/QT6biKDaHL6hELbZ32UtqPCLs=;
 b=LcRNw6iBP5wDPjPXnFP2HZmRzly0jub9Mdpmx05kTFbloLls8G7PBx1gY7bKuJlcqYNX0tSXPMkMSfBWWj6RcgeLcis6R0f1k1N2b/eYWQ+jAfi98qSY9aqp5C1G4JVGEwkKBhYEBDbRjI9lSplHWbKZpWaQckE4tKLOYorRQtU=
Received: from MW2PR2101CA0031.namprd21.prod.outlook.com (2603:10b6:302:1::44)
 by DM5PR12MB2389.namprd12.prod.outlook.com (2603:10b6:4:b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 17 Sep
 2021 11:31:04 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::b7) by MW2PR2101CA0031.outlook.office365.com
 (2603:10b6:302:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.1 via Frontend
 Transport; Fri, 17 Sep 2021 11:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 11:31:03 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 17 Sep 2021 06:31:02 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix resume failures when device is gone
Date: Fri, 17 Sep 2021 07:30:45 -0400
Message-ID: <20210917113045.22194-2-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
References: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d012a639-e398-43b4-a0d5-08d979cea1a6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2389:
X-Microsoft-Antispam-PRVS: <DM5PR12MB238978B181C059064DF1DCD4EADD9@DM5PR12MB2389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oa+T6R9nU9sRaThnAlGZIJlBKsSIzyK1CNh+WqTny5e4jEkjXyjljJmmVw8cXltVbJA9OYxa4ugCowmmSOybcPtuhNuIrsrwV+VY7pEz0QH1AhvBVCLdnFy+c12gSD0MuVNUk8602GcEy4TCakySkExB02PnmL8BtcmFa/h2Z1n1h9hs28JIGlbpD8TYIQGqeG1EwhMMXLkaBIjtG00jH7ZIVPNkD4jfGifFTZA3Cj/FJylWEfZS7jVj6ilbr2W3VnqPwKyrAxcSZ4EmOmarpsGmaC8bTinnSJQCLiqzSBwl28IUOTuIgT1SmLYvJWKiEJeuowUL5OQfVniMWBhXpEEa0j9cvNhOwdIewR4uP4WvoBArc6XalYJxDDcBns7HnWTRCToxen1uxmA1+CAi97a8zIfRQvi3YRWAMljjE5MegbtM5dmdXCZ/ok5sqymYIOLprn19XjDddm6cEV1SzkA527VPp7/G0WQZe5Y0CbDKdIwDFhPDZRJePLCPEd5dzSMMnrp0AuxxCxyLMkow+eirZ7cGcwktP3s2VRWIZwlbwtMHQBUEXzx+PtlP9tNRX7wYdIvYNG2ROR3ixgFKq28N/oTXscIPlUDPRQmoJe+HMJtzLcmCUa0mp5wY7BggZkUnvAO3OjjbLYMAoYnr+bCTF2cTPM3pNyM0R/eBHFoMrtOSpqKPX/VusCXJ+siUex9Qzz7bawFxeEp7G92ycKCF//UAWZCVQRDx9v1Ycfk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39840400004)(396003)(136003)(36840700001)(46966006)(8676002)(478600001)(6666004)(70586007)(70206006)(7696005)(8936002)(36756003)(54906003)(356005)(4326008)(16526019)(86362001)(44832011)(6916009)(2906002)(47076005)(316002)(36860700001)(426003)(26005)(186003)(81166007)(83380400001)(5660300002)(336012)(2616005)(1076003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 11:31:03.0282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d012a639-e398-43b4-a0d5-08d979cea1a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2389
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

Problem:
When device goes into suspend and unplugged during it
then all HW programming during resume fails leading
to a bad SW during pci remove handling which follows.
Because device is first resumed and only later removed
we cannot rely on drm_dev_enter/exit here.

Fix:
Use a flag we use for PCIe error recovery to avoid
accessing registres. This allows to successfully complete
pm resume sequence and finish pci remove.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index db21af5e84ed..04fb4e74fb20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1522,6 +1522,10 @@ static int amdgpu_pmops_resume(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	/* Avoids registers access if device is physically gone */
+	if (!pci_device_is_present(adev->pdev))
+		adev->no_hw_access = true;
+
 	r = amdgpu_device_resume(drm_dev, true);
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = false;
-- 
2.25.1

