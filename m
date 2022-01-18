Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED064C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 16:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C1410E248;
	Tue, 18 Jan 2022 16:16:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BBE10E248
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 16:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+sr6QMo8uUNAQjLo+kk8R1vGhH7cYoIqBBENYhDsth6G4p+VR3F6VOcxVw/hfC0B8AT8B2nFUO5sc4zMriwbtVgQFT3xz80CNkvOiK4vN9FU4nFiLIEjmY97cDWRn+TpNKXwYI6VD/vIGKHA77Z9j5P0V49xANNS6CefUrp+w4+HWjlgws4NFBpqs2Qx2YBP9dRl4URA8FfUfU9/W8KIpVCGLKIqzoBCM18tSTWDnnqu4OW6BQny83VcyVionuQtfrwW3jTDBuz7ZqgYBQeIh1hvZeLbUzyTUqbbyyvbJK6rfnj4p9Rt9pUYSdZAfG+OKiDwww5fO081QBlSTaEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl+jJsxUQ7eNga0xi1KdqXR88oHN13Sb2dDIiHGJ3M8=;
 b=JRp52ywoWGb8MDw3H7L+sLDo0NVY1qZfGQTYJeX9q+2zwFk4fz+ASV/14LxCKUdW3n3Yi1FrIuHx232Wo/xk5JAN4+L+nNlX0FVBhlp1MaioRGlip2CqOPlUYqCm4dKuoccn3FxDGL6r/qRWnVjRIYrsU4nfp1Gxf1sfwcnDZpSa3O4hAT11GBAbNActRCqq9d0MLrK2pLXb86XeoEzc8qU1ID0gLzbxwki344Witq5nU+U++ypY1z9QGNq2NymNxQiUwNBdr1fWMhPPacPpyhZWuHBsYt3YTd8jzv9Mz5DrOWWftTARiW9NfrCimtaegoS7piw4Ch9iUpO0WxeVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl+jJsxUQ7eNga0xi1KdqXR88oHN13Sb2dDIiHGJ3M8=;
 b=tjrCx6wL5TeJ4yJ6c/HbsS6EhsmsMtMpnu6QadlPv9cBClLLJpNhder0GQjbCXG56wqNXGZbfVhYfVa1t33VLrE4BRaTU5JBgG5HqLQv8MB67O9D6EwnR13MF+uRJWpbOe0qrHf62HWaK3IecSO8zEd6ulph58pHNX/AYZNf7GA=
Received: from BN0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:e6::23)
 by BN6PR12MB1649.namprd12.prod.outlook.com (2603:10b6:405:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 16:16:10 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::b8) by BN0PR03CA0018.outlook.office365.com
 (2603:10b6:408:e6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 16:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 16:16:10 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 18 Jan 2022 10:16:08 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Date: Tue, 18 Jan 2022 11:15:52 -0500
Message-ID: <20220118161552.11122-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fbe2ae4-0409-461f-0c49-08d9da9dd747
X-MS-TrafficTypeDiagnostic: BN6PR12MB1649:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16490E32323D2381B99E3F1982589@BN6PR12MB1649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XftsbvngCb1iBWk/WMrs7BslTOhouy2HtRp6zqplc9Y/F5y+jeyQWbFi+lYNiNzo0JxEwKtdaY3kJXgRwZOBL/R4nz8pNidH7hnWY/GKxfzNlCAhZM3YaddAwoU6dRbxVfnQBelEVLLrjycPi9CDV/9sLcIjprUf/cXPluQh7/iuhe9vfOObfE/pRSpmojc+ML4VUAW5LpbwjXOk9t1QAVmTFHfhPuYu9reRX+J1i2msSng6LCpXFTdLs/4C/abhsRskvHUD8Oec9Aep/NEnH/5CsLoTNrgIzxsVdt9P+oDK4yv1T32GzQ7uLgugTdAKi/CKbXGuRujFAqz9ThUVAObbHfh43NueTKpaDopDmFftczL2r4KWCLvCKCXP8JlqOR/G8xhG5kNPLXQI9a20QSMtvvlnXI3h/pdEyMuz/piONu3v1LHHVBhmYpc33lV8ybZQ6Wf52nF9X1kQQaZIz90O7HXOs8Cbwe9ZupA1D6fUhe0nksyllOsdRRBHP9GE1k9J0EkyOIx/Zp67AokuGGmqHFgqyKYLo8ddvpv8Y/u44o1ufj1fRybxHmg23npcd18hBxiRCR75XAX2keOdOBCygQHDkO0BeI3wb3lJNQfw8XFbhEHO/AEJVTOgul8O072B83uzW3AC5NI4ZrbbjFBCwNCtkF+YIBENEJhj0NTikGjzTVgJts8pMyw0dfV0raFqUwy3B48G7ZGROlsotvoUqjof2fcWrMqr4n2s+sNQlZbuXMWijvrj4GaMlJN1+ILymZ2G1G1xRbIqeQ/z85E6Hoa0K5Tkppal0Xy6Z5gv2bWDJ6Qu8eX1Ecaw+GPPmFa1RlJDmZzsWgzyU3Ka6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(36860700001)(8676002)(70206006)(4326008)(82310400004)(40460700001)(8936002)(86362001)(16526019)(6916009)(83380400001)(36756003)(70586007)(508600001)(336012)(186003)(47076005)(6666004)(26005)(1076003)(316002)(2906002)(7696005)(5660300002)(426003)(356005)(2616005)(81166007)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 16:16:10.5645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbe2ae4-0409-461f-0c49-08d9da9dd747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1649
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA FW fixes the hang issue for adding heavy-weight TLB
flush on Arcturus, so we can enable it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a64cbbd943ba..7b24a920c12e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1892,10 +1892,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 				true);
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
-	/* Only apply no TLB flush on Aldebaran to
-	 * workaround regressions on other Asics.
+	/* Only apply no TLB flush on Aldebaran and Arcturus
+	 * to workaround regressions on other Asics.
 	 */
-	if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
+	if (table_freed &&
+	    (adev->asic_type != CHIP_ALDEBARAN) &&
+	    (adev->asic_type != CHIP_ARCTURUS))
 		*table_freed = true;
 
 	goto out;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b570c0454ce9..ef4d676cc71c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1806,7 +1806,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->mutex);
 
-	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
+	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)) {
 		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
 				(struct kgd_mem *) mem, true);
 		if (err) {
-- 
2.25.1

