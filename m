Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A54C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 13:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9C810E0A2;
	Wed, 12 Oct 2022 13:20:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B25110E4F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 13:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/JTw8xSxE3+2UG/bhM64osfEVShtwAj0y4f7R/6Oo+pVTuVh5ptSN9SLHKZqg420XSVbYFUmtf96CaVW4EnqQ8UZlVwdsFsDEwd1G35pHjfMhHogNipvtPcvhkpW9thtH0ODKevzrZaFsbX5hGGNub32KyubkrwHY0nOMrMDxwaydRtk60oo7iMMjuIR5gbRG8zIYXiO3rVHmhTNceuELu6+h4G8EYigG4CN9N9tK9b0ccBmoPinDZA7HYLA4hC1fWaZUt1K080jUv5RrvzLRITD0DUJbjidP3QzYV/d46MxL2WHwijpUyo6CXbnutAAov+zGvdY4M1RrEahy9Gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPF8aWGKLR/FoUuTwDlZOEydInRTzE6ljACza1AvSVA=;
 b=Ea0seqpqF8E4MXe5YqDyKYD4WQYWvOzcOriL5TbUtNCQMk8yVLNTInxa80O1qhJCLNLKmJSA8Rkbr51OJIdkwOczOUAbvjjrYo/VjmRAuISVlbfI6L3v4Lq/2e+W61Rz5+8Ot+fK3JzNqqeA54w9tlRAIP7RrkeU2+bD7jRmcv9VMS/N5a7ixY24m0xqXnpbgtxgxQzgNGxjT5fAmk2PjUG10fszZUUkFdsdLrVIqG/cFzIa5eKK/mLLTzo2kCNIWEik834bFQqkdzBnSzmYVTJfJSQ6CTHj3JLlKrsJWEWalk0LfjE2ZAUWpRDn9j/nVcWhk+YmtpNEm6T8XtmEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPF8aWGKLR/FoUuTwDlZOEydInRTzE6ljACza1AvSVA=;
 b=G93Wuc2q9cuI2f57Dr+LCEQi5ZUqjzuBXBQl7TBEkMZuG9htB9OVc4OTgQJ+BPBDnuOIZigePYAULqY+z/LINK04ithBACa7MaQ4IMDlgMU1m5pYG6qE7+M4wUX2z37lDvoZLiBvZI6EswmoyqMfSEEiXWaoQzwKPW43tEv43Rs=
Received: from BN8PR04CA0065.namprd04.prod.outlook.com (2603:10b6:408:d4::39)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 13:20:22 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::48) by BN8PR04CA0065.outlook.office365.com
 (2603:10b6:408:d4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 12 Oct 2022 13:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 13:20:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 08:20:21 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 12 Oct 2022 08:20:20 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: set vm_update_mode=0 as default for Sienna
 Cichlid in SRIOV case
Date: Wed, 12 Oct 2022 15:20:11 +0200
Message-ID: <20221012132011.91886-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: c9af1f96-5b95-434d-fde2-08daac5483f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FaTINAN6Yd63azrOLybnoSeD2dnf4hW75Za/HZ4FyIMzKyQmhx7yzKn9LULJBgFGMU1yleQZI8K2F0ixLD+YB7g2MSG+ii2QQsAD8R1ZBZa2DCfJ8o3ZXGyA24kP7suQgHch6TIREr5N7bU9fSWli99NgCtWpkwe5lOGFg4deveyrq5TberAm2Oog80zLTLZrB2xD+6eeBwjb8o9t8xHvG4RvTcGdK+A5kmVadkhjbL4nQjnf2pNU9y2QzVQZm7X7lC74/Awl6VoSVfgpB82BspZbKLhL5PgSbEKly0/8QO2f0nw3k6NTrUDLmGQt074X/cc4zorevC8zb1PUs7SusmOj9xhImiU9KFBsjKCk9SAo1Vzw4DlZNaGn4n1sr/oEo0UoH3M1uqCuAM0On1xDvtKjy3MFmKJD20GdVkdNVdadDzB9RGUPGFAQxWASnyVsSa7JLO7giVr9/Ge5NElcgQRVIV/aEYP6Pfp00No02t/IscZeuSDXMflNMiKa2zOtSyFhnGcHwNy4PnleriLBAyoxeQlT/6j3dfFLUFVxe2wXb0LOaxwQP25D4fUiu8shlFXbLUtt6i/Wis4jSFnDFybsQ7YR7wLmmz9BnwQXkyp6Z9gsF18qGTv6aZyhhq3hkrzFJYQEGogusIy0LymP7B3XxLMQz1N9Z8IDpO7YRWKntqf5ZvLvNUi2yTmpmmhDRkCg2rNU5SqOUOuAxVogJsnL8PvtxL6/47445kzjwHrgkymDHqp9+MRPAqd2fzJD280OCsH/eTlV1r9rI4WIVXszzp6Hl7V6CxksilX566sRuTH9JlBpsEGc7zdvAi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(6916009)(82310400005)(41300700001)(6666004)(36756003)(316002)(478600001)(81166007)(70206006)(356005)(5660300002)(8676002)(44832011)(8936002)(82740400003)(70586007)(186003)(4326008)(83380400001)(47076005)(426003)(36860700001)(26005)(86362001)(7696005)(336012)(40460700003)(2616005)(40480700001)(1076003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 13:20:21.7110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9af1f96-5b95-434d-fde2-08daac5483f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
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
Cc: Danijel Slivka <danijel.slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For asic with VF MMIO access protection avoid using CPU for VM table updates.
CPU pagetable updates have issues with HDP flush as VF MMIO access protection
blocks write to mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL register
during sriov runtime.

v3: introduce virtualization capability flag AMDGPU_VF_MMIO_ACCESS_PROTECT
which indicates that VF MMIO write access is not allowed in sriov runtime

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e4af40b9a8aa..9c765b04aae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -726,6 +726,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 	}
 
+	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
+		/* VF MMIO access (except mailbox range) from CPU
+		 * will be blocked during sriov runtime
+		 */
+		adev->virt.caps |= AMDGPU_VF_MMIO_ACCESS_PROTECT;
+
 	/* we have the ability to check now */
 	if (amdgpu_sriov_vf(adev)) {
 		switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d94c31e68a14..fffc224ff03d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -31,6 +31,7 @@
 #define AMDGPU_SRIOV_CAPS_IS_VF        (1 << 2) /* this GPU is a virtual function */
 #define AMDGPU_PASSTHROUGH_MODE        (1 << 3) /* thw whole GPU is pass through for VM */
 #define AMDGPU_SRIOV_CAPS_RUNTIME      (1 << 4) /* is out of full access mode */
+#define AMDGPU_VF_MMIO_ACCESS_PROTECT  (1 << 5) /* MMIO write access is not allowed in sriov runtime */
 
 /* flags for indirect register access path supported by rlcg for sriov */
 #define AMDGPU_RLCG_GC_WRITE_LEGACY    (0x8 << 28)
@@ -297,6 +298,10 @@ struct amdgpu_video_codec_info;
 #define amdgpu_passthrough(adev) \
 ((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)
 
+#define amdgpu_sriov_vf_mmio_access_protection(adev) \
+(amdgpu_sriov_vf((adev)) && \
+	((adev)->virt.caps & AMDGPU_VF_MMIO_ACCESS_PROTECT))
+
 static inline bool is_virtual_machine(void)
 {
 #if defined(CONFIG_X86)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 83b0c5d86e48..2291aa14d888 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2338,7 +2338,11 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	 */
 #ifdef CONFIG_X86_64
 	if (amdgpu_vm_update_mode == -1) {
-		if (amdgpu_gmc_vram_full_visible(&adev->gmc))
+		/* For asic with VF MMIO access protection
+		 * avoid using CPU for VM table updates
+		 */
+		if (amdgpu_gmc_vram_full_visible(&adev->gmc) &&
+		    !amdgpu_sriov_vf_mmio_access_protection(adev))
 			adev->vm_manager.vm_update_mode =
 				AMDGPU_VM_USE_CPU_FOR_COMPUTE;
 		else
-- 
2.25.1

