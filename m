Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47709C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 17:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66BF10E049;
	Tue, 27 Sep 2022 17:57:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EAC10E049
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 17:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks+QciNOKXvAPdBj70RSBguIuJOAWYFE4b/PuyAiCg2J31XXHHf36OxnKHWS/70/riQkCWyoEcHvxACwRgQMVnLIdyPyrdffV/8mar00U4T/ixnZ8cLPI0X5jW+osPXtVp1i7QiQXgY0Nt+VOB6djHz+w7wee0kNvEpLjsDms4MHqOPVgJ7JT9sXh1Qfi8U8FxL0y/mtsRKokDvt/eC+Ae9TicfffZS6MwWcHQu6NtNS6GRFc+Y1MugFQOzeV7ryRM51z+MpMxCEe1soFIhnrYabyyH4wsJItTyedpk0pc+UqbG9oeKVw2FOmP767gjR/hoIIjxrbzxxy9LT76DavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS9XeXw9Np9QVP9crw7QV84f+vt+RyLYycqRUHDXUJA=;
 b=lM9/LIqsRDkq40MV6sufxK6gcOxuHUDz8wypoWL7b7Ijx9TazxJV/m0tNJsQmf8n2bDxDWHuXEYk3Bhf+fqMtNJ93ZGNMU9bKLmU2s/MgnEeQ1vEr2zOaNMq3zlypnNodRiSrWeujonX/Uzmt34meSEfeYPVYmgZRwK5bVFec67WLtExfEaiyZjKlkqcxihEz91tX32oNaJRmDaOy+32PabzO7H4SaAIIKD4S4gzI6T+ZKDLRYot0oCSCQuTJnB1g61Ad3J7hInccKfkPzRbU0c0F4BL5BOyaZYVl5QpHIVo2hw6pV7ferb/yHBfcYsf4R9mL4Sm5nN07QxXWtVlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS9XeXw9Np9QVP9crw7QV84f+vt+RyLYycqRUHDXUJA=;
 b=IOPvuYwJusNRZp9ofnSrazAAfhqg1Lx3k4FoJS/08bhaoJOtoltf2Nb1Nw58eJx5PgjNyFX2JrUIgOo32o7fpZ+3h1jNFbcfulN2Zv4kplI4eale7G8pHLNXrzTn7usT5ISsdnsFydPF5u+lGKngIAmpdzWdd5vIvwwzcFi9sI4=
Received: from DM6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:333::34)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 17:57:14 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::68) by DM6PR03CA0101.outlook.office365.com
 (2603:10b6:5:333::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 17:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 17:57:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 12:57:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Add a new parameter that can force reset on suspend
Date: Tue, 27 Sep 2022 12:57:02 -0500
Message-ID: <20220927175702.7585-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: b79eee7f-7da1-4533-6606-08daa0b1b4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaKT7/szvGPFH5TAybwT0NxcVP5r8przHYN9D8Dck3ZS/q9R0fwc58/LPxkKWIfJQhuHU4/S+4ykXgytTc96LbvDO9uCzRXcJKHEf/c2Tf3aCu+nbG+L4bFhzDq0RDsS85dNYrwpVx3Bo/p1SPrvWTKjp2OrgY3gSCODyDKc/aFLIYEoKuEZoCh17jZy5gTwIUOL/rUKe7z38hALMFVIg3neHqa7wKVv+h5gS/ALK0pUggGnYgrUB+mVYiDM82JyKdp4qNmfBpSGr8H7Wc/ZcLRPr5ZHtK9KYMd5hWFGxqHXWhhgCaD91c/phQX489OxqIkVFkNLzEDtRGxxb08YIsQ4vHmu61Bjg2GI0BsTOLTjh5QeoSfr2Up4S/oFCF1v2Ic60Dz7DvwpSGWe1yXS8IX2EwXyKlXg/CShQ1qMGOySDn2BDl+1zlqnSC97SsuVxajDDACvDhXVIeQTeeZrnrLE4yoiKiCjVvH27cL3NIbAIZQQ2S56FcU3wPwEMNDiUdflTQnasI823c9l7BHRz7LLJajtzSuS0F7Tr5Ll0haGFwDd/4DGVNYOBq33ge2NJUSd3/feBTWU0Iy2GvzMSzic8Q0liEHqrtav7kG6MK/DYUFxG4fDXKaO7mHWmt40oRVfy3iM1oXbnzL38CwIXAURwBB+LF4SRCyzO/wi2yGKyi6cMnmf3Jhci6ScDGnHBHV/IN0y7YIH/X3QdEbRDkgG9LFtXA+jKeqUdfrrDFM5BcxQ5KI5RDgEHNJg1B84aqcCWYuqnkk2KPyk8jDn6awJQdrnHK2kSO8guqm5xB8AoI8Mub/Y45rtkq9wMxnB/A58CYVvNCju07dkehE3JsL9x3571aUjWhGXj5EvUP4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(15650500001)(47076005)(81166007)(70586007)(4326008)(70206006)(86362001)(356005)(44832011)(26005)(40480700001)(426003)(186003)(1076003)(2616005)(5660300002)(36756003)(336012)(16526019)(2906002)(8936002)(8676002)(478600001)(6666004)(54906003)(966005)(316002)(83380400001)(82310400005)(40460700003)(82740400003)(36860700001)(7696005)(6916009)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 17:57:12.8948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79eee7f-7da1-4533-6606-08daa0b1b4d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: kolAflash@kolahilft.de, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We previously had in place some behavior that would cause APU or GPU
to be reset during suspend entry.  This caused various problems, and
eventually was reverted.  There are however users that preferred this
behavior, so add an option that they can use to force it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216516
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ae9371b172e3a..85999f48e2835 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -230,6 +230,7 @@ extern bool pcie_p2p;
 
 extern int amdgpu_tmz;
 extern int amdgpu_reset_method;
+extern int amdgpu_reset_on_suspend;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b14800ac179ee..17c0a0ec21bd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1051,6 +1051,8 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
  */
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
 {
+	if (amdgpu_reset_on_suspend >= 0)
+		return !!amdgpu_reset_on_suspend;
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16f6a313335e9..6a786dacf2c2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -179,6 +179,7 @@ int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = -1; /* auto */
 int amdgpu_reset_method = -1; /* auto */
+int amdgpu_reset_on_suspend = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
 int amdgpu_use_xgmi_p2p = 1;
@@ -870,6 +871,13 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
+/**
+ * DOC: reset_on_suspend (int)
+ * GPUs should be reset on suspend (-1 = auto (default), 0 = no, 1 = yes)
+ */
+MODULE_PARM_DESC(reset_on_suspend, "GPUs should be reset on suspend (-1 = auto (default), 0 = no 1 = yes");
+module_param_named(reset_on_suspend, amdgpu_reset_on_suspend, int, 0444);
+
 /**
  * DOC: bad_page_threshold (int) Bad page threshold is specifies the
  * threshold value of faulty pages detected by RAS ECC, which may
-- 
2.25.1

