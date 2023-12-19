Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796A8C41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 12:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF0D10E0CC;
	Tue, 19 Dec 2023 12:48:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3591410E0CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 12:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFMS6xsjTTRd5/SmenN3eMo/IQzdJ7sTBwBX3VZ7xvvwGXnR9+7StQwjRptUYW9OdqKjC5Ko/OO2iJNwPLCsUXvycM8aGMQrkY/sIAgZBZDZyJOguu0xZY+qZOLil5d9kkKFNRXBTlCn4oZXKdAff4h1XTpz0tTLqH0TrmoDgBbZ9ZZjDpz9o8aSDsWkualOI+dI9I53fFT3lf4nEx5yXJKx/kRANCKW36vUNmjR8gymPsea7k/pAOnxxU4Zzp3qV8wQudTXmiZ9R7F/74O1x9Kz/p0wxaH+G2m3JQKbd5YlKYg2/K5xHcxFDB0uz6pXpzgzfdoemSPWW3mAJbCbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGWyI+1EYL8QgvPLiKt0CIWhxFBQWIX+AqZFo6P5R/w=;
 b=glMjOpzE1hcAOH7z7KhLavqtwEAq7/SelNmKk9a4B+806P1kIsg3JGKzSxMqoyg6hTLRaFjfATPmZi+whuBFNsHtfZKJ2zlKnkst9Fg6oFu9gSMtvlT1R2CLFHN0kVCTE6zAWr9e3phyICjJTiwSv8aj2xNsQzfzkdudjpMU1ue9iO2XFEuRFB4jXWrvrFq8ZpCnyygv/UY5PVsk5lY9Y26Q7PhPFfWMZZYyOchC+hK1xdE+etW2eNaF0toDmYYxxRG6rHadmz8d5CLW+kvXPNb6yEkssexXBDQJHfb+mGQu1xwg02SmKZ+WRgmboNBuq/4eVxZxNqFUX0jM2ijaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGWyI+1EYL8QgvPLiKt0CIWhxFBQWIX+AqZFo6P5R/w=;
 b=s+g7iA+EMs8yYb9MJypGM7XB4breli1Fvoy9tLQOQfT7yJTzZmDkd+NWGd8c1BMG4DtMW7jk6PLMYX+QQcfy4hyAXZX3LAgAEQGaRtu1dAUrIet5ugtTJELkR3CocGpEOb6IsG2FA3D4SNM2Jm4Z3D3T9kA7LBfkMPw/Ur8jhAs=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 12:48:00 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::47) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 12:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 12:47:59 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 06:47:54 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Fix ecc irq enable/disable unpaired
Date: Tue, 19 Dec 2023 20:47:38 +0800
Message-ID: <20231219124738.503604-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MN2PR12MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: cad56d93-1222-43d1-f1d5-08dc0090bb3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INZsDi0NtbeuqVJB+cIq71tbeo5/vyQHPw1qlrQXlxMiCswG4hZI42M/WjMTnD6Sv39nawQWBOc1u8ivx10W2z1y1tcxo/6GczzRqmW++m1D32+9awqgA4ERFMFLfgFtC1KWH0IhX16RHwRfKHnz/yVn8OLJAw+m/AlA66DmCIWi2m3D7Rp2YHub27b+ofVrJKyvRzgF3lnNZAk2YkqEQ/qr7BKmFSN1QYU3MHxLdlCT1BZG5DZ+lhKlsO5X/StlG27dfjJf0j8583h6Kl99nFMqspOrKFyHwvTe8rSIW1ItLbDg0aidWseVlQZRe43VEQfO+59ax1m/MMMOgMB54FsewcoMmH2Xz6EQMHnHi5qxX1TlAIETQ2AyOq5SZ4lQzEtMp0Gv82bEEAP+vgBbSx86GYGMG4j6y28rsJksib2aZI2kJFGmdmJVVLdPo0bet2yE52XTDGEEnV/rLnxSIJ4ewyChCC32DwVhlzYZ0W8bCPGOayy3xq2F25crZzcqjSI0cD7MsdcLXFqIHlUmAtlZNfejDU0M2946vITlbZum1yAmc+rBxnmt7jspddr9JUkJ828DnLP8msy482fhlL5yx4bQcQnOalTeg/lOWW4YkaiS+N8GlOjU7wUQrENsDeawHXlvmKIBggVSCQ9CGj611ju5nlk5CUsBE3/aF3yOphftCsOnDMUpeCNW+SxOzRdRms6ll0OUvH52E5+H6Usb4orvY6lltTwcXLSdDyJGVeQiu5KjiKkHwWb4XDhBBZQuWT9ztufhxh/debt87w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(47076005)(2906002)(36756003)(82740400003)(356005)(8936002)(8676002)(5660300002)(4326008)(36860700001)(2616005)(26005)(40480700001)(1076003)(41300700001)(478600001)(426003)(16526019)(336012)(6666004)(7696005)(86362001)(316002)(81166007)(110136005)(6636002)(83380400001)(70586007)(70206006)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:47:59.5545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad56d93-1222-43d1-f1d5-08dc0090bb3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
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
Cc: Stanley.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The ecc_irq is disabled while GPU mode2 reset suspending process,
but not be enabled during GPU mode2 reset resume process.

Changed from V1:
	only do sdma/gfx ras_late_init in aldebaran_mode2_restore_ip,
	delete amdgpu_ras_late_resume function.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 28 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  3 +++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 02f4c6f9d4f6..b60a3c1bd0f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -330,6 +330,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 {
 	struct list_head *reset_device_list = reset_context->reset_device_list;
 	struct amdgpu_device *tmp_adev = NULL;
+	struct amdgpu_ras *con;
 	int r;
 
 	if (reset_device_list == NULL)
@@ -355,7 +356,32 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 		 */
 		amdgpu_register_gpu_instance(tmp_adev);
 
-		/* Resume RAS */
+		/* Resume RAS, ecc_irq */
+		con = amdgpu_ras_get_context(tmp_adev);
+		if (!amdgpu_sriov_vf(tmp_adev) && con) {
+			if (tmp_adev->sdma.ras &&
+				amdgpu_ras_is_supported(tmp_adev, AMDGPU_RAS_BLOCK__SDMA) &&
+				tmp_adev->sdma.ras->ras_block.ras_late_init) {
+				r = tmp_adev->sdma.ras->ras_block.ras_late_init(tmp_adev,
+						&tmp_adev->sdma.ras->ras_block.ras_comm);
+				if (r) {
+					dev_err(tmp_adev->dev, "SDMA failed to execute ras_late_init! ret:%d\n", r);
+					goto end;
+				}
+			}
+
+			if (tmp_adev->gfx.ras &&
+				amdgpu_ras_is_supported(tmp_adev, AMDGPU_RAS_BLOCK__GFX) &&
+				tmp_adev->gfx.ras->ras_block.ras_late_init) {
+				r = tmp_adev->gfx.ras->ras_block.ras_late_init(tmp_adev,
+						&tmp_adev->gfx.ras->ras_block.ras_comm);
+				if (r) {
+					dev_err(tmp_adev->dev, "GFX failed to execute ras_late_init! ret:%d\n", r);
+					goto end;
+				}
+			}
+		}
+
 		amdgpu_ras_resume(tmp_adev);
 
 		/* Update PSP FW topology after reset */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 09cbca596bb5..b93a0baeb2d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1043,6 +1043,9 @@ static int gmc_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
+	if (adev->gmc.ecc_irq.funcs)
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 416f3e4f0438..e633e60850b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -941,6 +941,10 @@ static int gmc_v11_0_hw_fini(void *handle)
 	}
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+
+	if (adev->gmc.ecc_irq.funcs)
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	gmc_v11_0_gart_disable(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 205db28a9803..8ac4d5b7fb37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2388,6 +2388,9 @@ static int gmc_v9_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
+	if (adev->gmc.ecc_irq.funcs)
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	return 0;
 }
 
-- 
2.25.1

