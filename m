Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2876EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 18:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A52510E3A5;
	Wed,  5 Jul 2023 18:07:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A152A10E3A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 18:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKHU9wZsr/WHT6SA4ge6aN+Os0yJbUHsNXw1cPs/4hF2tW194poDXvZkCEOtEOwld7TGDhuz0nIdGKkAZkI1WujGbH/slVMYFHzBYanBr+ST9iA+PGCnTJ26kl2hjugf0f+SdRtCziOpcBzFzMV0Bfy6FNQZ4F9qbRex8yGZLV6HEfxiEWAUiQ8Ry1TpEw63LOzr4AuqOdtkm2Xy9og7y8kME3dSaIek60H+app15g70LhjyIXhLB6NRMuDQih2oly3TY7/01XjgZAV9mmKwZN3nTjyTFuVvUFkfkcPnfFp1+UQ5ghAaKoOExcGACQkLiVMpIDIuZc6l9LuD++KFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67HioYLe1LdpfTxXG7c/1UwIQFK/0rE0e9RiMKaKZeQ=;
 b=mD0ShoScYjg8Iyu0CdetlHn8Bn9dpLPZkOJcbzGYNNMCtvFgVBVnR0p72RuY4SEhXTS8QoRp2rq0CX335Qc4e0BdeUfRmFIAfw65DcrCjm3DXFjVf5SxxOxzixMKw7WjqCu3zO76pb3kHT2+NXdoXQsXcZ05Y+fSHSKzAtP6aH9ux6IRte2oe397UxRXQ3hTJIFdlxwWyJKGxSvq+ZOiRfVw0RFfi+kh4hGYDfLLr6EVnJ1CHf8o6PX22K63Yj2lv3PzF2PZlCNj01vObt9Qd7trqqptygJLJ8PkgiK6R2UJxLxCOOhr4IDDNLpJ9oFSH2dqFHP//3qo3MfstZSJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67HioYLe1LdpfTxXG7c/1UwIQFK/0rE0e9RiMKaKZeQ=;
 b=VAPxoVq2L6T3XBqg89nIdYi65BJg46hyLqbiYRd+P4rgDNq8bAXIsKfmnXEQkoGmotJF/1YfIH9QR9XlBJxoNUis6BN75pzuOU4wqx0NdgLt37C3SColZZrJlKo9+xGLSalxq2k+D0Vx/CCHl01jxV5L9PvAOkZ490DTX39Pi0M=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Wed, 5 Jul 2023 18:07:11 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::7a) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 18:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 18:07:10 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 13:07:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 1/2] drm/amd: Extend Intel ASPM quirk to all dGPUs
Date: Wed, 5 Jul 2023 13:06:32 -0500
Message-ID: <20230705180633.21538-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: bc49bc77-84c1-481f-697b-08db7d82a764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrtSY9Trnl38A++fVVe7CFYyO86FKkwQm+AOQyrcl4ZTZ8q8WfT/T5qRNzMSCb/TiHlujREIJqX80d39gqLnWRiPzhCTt7gDFm7VjjAOyqqQgV6HkNpEapk3DmzfXCW4V03Va93vhDuvNnfzZ/w0RBoT0DUygaXlhuhg+SVxeUso9AWcAJfy35r/sZI6S3Jv+F1UkHXHCpoQ5Lc39W1PlVVPkBY2y6daDISPJYtAP+yUGUM1ml1udh9XN7W36efM/FEsDDRcQ9GuvnSRijT4DAfvkLNwYcePZg9RfIKpFJO+Ms0wY0fz1DF5fqxv5zF6IoCI8t3qI3EBgwrLoQIJ0hx+wYzM6hwAT0W9ln1hr7zAkfbF6b+axFuO7IXXwOxjRmnXO0ZZVKTu5a4xy8rZ+ycD66hIvFTIekGRDDlghBej0wI2Drjqb+RHF0bmbqg60HuGDyXqEZs93TI2s1qaEGCRfr4OlKR7emnUQUMQGLi/TfrIP7uJqkUoICyqJyWE4oJtO0zvtrEA+wjKjqyxI5qBfun/wqg+Z4qNYWTvqWcQmTCtRCForlRZXqez9GCJYuuKydCMlrdXW2Jpe1/PsPg7Y4j57rr0MABH/F4FxQugz5JvONeiFv5aY8XYdOSGvmdJbelgprrb7YUWCSpeQqAty5FDk8dmrZf3gitpJyX9ZV95+Dcl0Rwx+zuL4jrGgnGLMPACsgcBCIFh40oMRRlkLp7trbvBxKbAzcsYUoKWNb8wub6FUKClclDfgvAApeXpQnu6Cids5qs30N8266fsgL6ARGQDYJvrgKkx0YA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(1076003)(82740400003)(356005)(40480700001)(81166007)(40460700003)(6916009)(316002)(4326008)(70586007)(70206006)(47076005)(36860700001)(2616005)(82310400005)(426003)(83380400001)(336012)(186003)(26005)(16526019)(478600001)(54906003)(2906002)(8676002)(8936002)(36756003)(44832011)(5660300002)(7696005)(86362001)(6666004)(41300700001)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:07:10.9872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc49bc77-84c1-481f-697b-08db7d82a764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
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
Cc: koba.ko@canonical.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

More failures are reported across additional products and so it seems
unless we have a handle on the fundmental ASPM incompatibilities with
Intel host and AMD dGPU, we should not allow them on problematic hosts.

Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/nv.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c            |  2 +-
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc4dc1446a19..294a549e7499 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1314,7 +1314,6 @@ void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
-bool amdgpu_device_aspm_support_quirk(void);
 
 void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 				  u64 num_vis_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f069e1731fe..ef22a0a6065e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1458,6 +1458,30 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+static bool amdgpu_device_aspm_support_quirk(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86 != 6)
+		return true;
+
+	switch (c->x86_model) {
+	/* Problems reported for Alder Lake
+	 * Volcanic Islands:
+	 *   https://gitlab.freedesktop.org/drm/amd/-/issues/1885
+	 *   e02fe3bc7aba2 ("drm/amdgpu: vi: disable ASPM on Intel Alder Lake based systems")
+	 * Navi 1x cards:
+	 *   https://gitlab.freedesktop.org/drm/amd/-/issues/2458
+	 *   c08c079692da0 ("drm/amdgpu/nv: Apply ASPM quirk on Intel ADL + AMD Navi")
+	 */
+	case INTEL_FAM6_ALDERLAKE:
+		return false;
+	}
+#endif
+	return true;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1480,18 +1504,9 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	default:
 		return false;
 	}
-	return pcie_aspm_enabled(adev->pdev);
-}
-
-bool amdgpu_device_aspm_support_quirk(void)
-{
-#if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
-#else
-	return true;
-#endif
+	if (!pcie_aspm_enabled(adev->pdev))
+		return false;
+	return amdgpu_device_aspm_support_quirk();
 }
 
 /* if we get transitioned to only one device, take VGA back */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 51523b27a186..4f8e696d9ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -527,7 +527,7 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 
 static void nv_program_aspm(struct amdgpu_device *adev)
 {
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6a8494f98d3e..c413cac369e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
-- 
2.34.1

