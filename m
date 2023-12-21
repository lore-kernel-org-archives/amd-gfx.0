Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E6CC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 06:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE0610E07C;
	Thu, 21 Dec 2023 06:05:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C6210E07C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 06:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtJOGuRjokcsjHLtOYg8jI+tbi2dGz6Pn5aoLiQ+T0srVGsIYsFUPsRjdZWIK7423UcyAxJtHLjv9z2uFVizp5vPoP7dmcst2EzyLwzJ076Ps2ctaQuU3/now3htQCG3DgDMzo6+m8a32hYytkFFMPgaKkYAwUsxsOyBphoyEqQt5+XGFfIZhUBEmwu69UoI23K7BjwxbjVR3zpAZEHLVOyq0uYLwJiTOsIGLd66V5F8q9J8+TBU6hLWjil+rP1oo/nXwZO6nc/V4BJPl+UVKU1F4VHP5PKT1nBk0GQCBzjdEQzcUQF1hZtNBn/RO8hJoXAcbmlllHeoFdvMJO+nGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPmCAfGW/AXVBAZOvt7v/Klw5tkbm6D5YJZU+qwf6oQ=;
 b=OJHJRu3sbcGhqbEHK6dhYSgetwdO24L7oNV9bLkTDEmEVH6/tjrzGE8k/PtAGDqL0byI0c/0FuXTE/IsUouvW/ZziD8Dp8iTC+t6+x/3uydwSfTclIFKPTy75wI7Ib/kYzKCwAZ8P0QNbGEVko4D7mvIsP20AOrjstQqvkgyAnIS6VfQzthIkgCWeD7HetMmoBcMbHhGXshU6iRhmnIEPrh8i1Wt5Y1CcaKO8j5bzjL9rOG9qJ4hMdPBrQzyh5VQL3YQTBj5IHC1k5zaosnFBpUD8qh2oAUGWMAlgPtAFtrN2PcO2YxrAFzThdbBS02AvpDAw9nq+23sXEpN8GpWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPmCAfGW/AXVBAZOvt7v/Klw5tkbm6D5YJZU+qwf6oQ=;
 b=4jVkeqIwZlfNPMJSQmZ5A3zBp3wyCw+qFriZqBrQpSvD+GHRUJI5zKZMsHYyFZw7/XpWC0oI/dIvAozYF9lMcTJjfGHxdllxqIuSLuV8iqZPX4HuzDKQCs/n85aXJYN1lIDrac97X94AAqaXDgt3Ll7txlHkgdM+ewi+x5pvHtc=
Received: from DS7PR03CA0044.namprd03.prod.outlook.com (2603:10b6:5:3b5::19)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Thu, 21 Dec
 2023 06:05:50 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::34) by DS7PR03CA0044.outlook.office365.com
 (2603:10b6:5:3b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 06:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 06:05:49 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 00:05:46 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
Subject: [PATCH Review V3 1/1] drm/amdgpu: Fix ecc irq enable/disable unpaired
Date: Thu, 21 Dec 2023 14:05:21 +0800
Message-ID: <20231221060521.529095-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: f45ad42a-c40a-43b9-335d-08dc01eae186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6Bwn6T69V+U455Fhc1dM7sMP3uLxLs918E7veF6m9aJYg3krWEDRjsawBw+zaToQBF0rttuy7UzKgsGYV36E788ioz7OQZSmZc5IV+0C7QCwurdAx9iSGSwsy8BnXMhEr7zzGXezk4tSy4G6NIkGU+xB9BOFFgRzQyxIGUlJhv7fc3/QKGBgCcKpo5XTj8tXmng4bsRmntrs7ZfsvGG/V49QTDdBg7sbBpt0Nr2O4MxfPddAPVvxApjeny0XdEjb7nG066+VjFH6loFtnWQAcduu1/wYwibjzCDnb0HcCrWf5Up7jlCMlDsZ4OT8SF5uHjR2O3ejMppoxdhnqJNqxD9BJzgFlbu4lH9l4Yc17gExZWrCymtrLnki3MdxdX+f/j72kJomUiPYOOrI9mAzLCBjo7zB1Kb8QSDOqR9WTBjQcEEk2Uz4evKUiiEAHHU8vAib+9ekbISMEsPP5fM+v2ZoHPpTmr5MMp908wCiz5klgKpDZKlpYUDX14dzMVK6/m3aISL+Jo+iWgeO+/KU4bI5GDQTDu1NmcCrnwQLOP61mr06eBOgvNt1FU0jhPdNwQeZENNkaPwdKJiCP82feMjWrYnPC18XYXUQgclv+Sfr0bHHCKKnkRXWTIIoH4xZ2yoSASKIHj21xSeP5Vw/oSr3sy+PpYT0nyMKwRDFP3pzzj2Xw6IOdbpCilQg/inwhfNJXfQgLZLjtiNPyzvrkPRAsqQ+WNrSehxM60lBJRlxEQvB6bR8YqAMz2/6knuLqFcOeViv/LG8DB9exir3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(36840700001)(40470700004)(4326008)(8936002)(8676002)(5660300002)(2906002)(7696005)(478600001)(6666004)(316002)(6636002)(70206006)(70586007)(110136005)(41300700001)(356005)(40480700001)(36860700001)(47076005)(36756003)(86362001)(81166007)(82740400003)(40460700003)(16526019)(2616005)(26005)(426003)(1076003)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 06:05:49.6317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45ad42a-c40a-43b9-335d-08dc01eae186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
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
	only do sdma/gfx ras_late_init in aldebaran_mode2_restore_ip
	delete amdgpu_ras_late_resume function

Changed from V2:
	check umc ras supported before put ecc_irq

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 28 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 ++++
 4 files changed, 40 insertions(+), 1 deletion(-)

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
index 09cbca596bb5..4048539205cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1043,6 +1043,10 @@ static int gmc_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
+	if (adev->gmc.ecc_irq.funcs &&
+		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 416f3e4f0438..e1ca5a599971 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -941,6 +941,11 @@ static int gmc_v11_0_hw_fini(void *handle)
 	}
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+
+	if (adev->gmc.ecc_irq.funcs &&
+		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	gmc_v11_0_gart_disable(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 205db28a9803..f00e5c8c79b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2388,6 +2388,10 @@ static int gmc_v9_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
+	if (adev->gmc.ecc_irq.funcs &&
+		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	return 0;
 }
 
-- 
2.25.1

