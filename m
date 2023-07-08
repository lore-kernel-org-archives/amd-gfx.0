Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B0FEB64DA
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jul 2023 02:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A67C10E09B;
	Sat,  8 Jul 2023 02:26:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E32B10E066
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jul 2023 02:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHMxgQjNno60ZT8C8HpeSi4i8VvQl+NsqYKDTFcIW2WqFS/5TVgTjSYUCCdX2d7DTohEX/bRO+ZZNYZhFf8L/8GYRqT32JXHR9FcFDiqQio3bPiFgCpf9BTi27FcBRwSQ8LKUKo2851yW7DSpQKzSMWSnI+1eUk6r6fiL63IDIA3dlAnE7FML0vWWGttQa9Y99ET9yjUs055hzikx6d5nxUn9UDSidmv/l30vOE9MlowgtNOKFHsVQEzsbma+fzhgFAR+xFAmvHzUCzr1P9Y+iE7Rjc8rDBN9dBUPRkAghrheCartBMBtVyutmuRpm2Jrf2iRJiPbCLNP6mYUG4HfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUCjCtGzyoJMgmnKFp3U6C4TtHkuvQUOloeoefpXpdQ=;
 b=gLfsD2GDq7ZS0uJLTR+ecVYz9dJA4guAjZ3EHhivtnF91tNH4nx28HAyuKs/m5RxxyqnxwsEqax3ZVDlq0aXQWc3nGOndWQJdYr/OWkVmkRfSa3cCHV9xnq9oVKKa8uBBljkXjpMAGVGhoJum3pkqnaBjt36/ySaGurC0numqDuqNyYPwWmFkm8V3oImTu2lD6Yi+Q+fQYEbWdQ4oO7Mi4qfFVj05TWpwl1HVZOmD2VqcarVMmGuRTqrsN7wDphFDjKpQAx8LUB/FFfUsYvjWjiqxIG7PheERFyDktqy9Kisxj7ASdnT/aEMOzs8T/vdvN0XMhbdP92eWbBGI3550Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUCjCtGzyoJMgmnKFp3U6C4TtHkuvQUOloeoefpXpdQ=;
 b=sd2eGqTKCVjQjw4TNFdPU4XeJvuB0FzimWKpmttsw3s86xL9RAxJX3BEV49HykNt+H/Bo9cx0FC2Ep1y5EyuITIVOo/KrLgAEhZXIiOGdbObwB2/88q5fZ4re1ZimmuS06U7QT0f4VZWWIOniUcSEPWjRpUm+x+UoXxRlv6m9tM=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 02:26:36 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::93) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26 via Frontend
 Transport; Sat, 8 Jul 2023 02:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Sat, 8 Jul 2023 02:26:36 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 21:26:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd: Drop amdgpu_device_aspm_support_quirk()
Date: Fri, 7 Jul 2023 21:26:11 -0500
Message-ID: <20230708022611.50512-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230708022611.50512-1-mario.limonciello@amd.com>
References: <20230708022611.50512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: c2eacd3c-3e9a-4442-75fc-08db7f5ac103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lf8TMnNVgnGFECnhmr+S2gJk5GyeCbT1Iw7sVdwLq2QF3B7FFVOOqxqMe8VCP3cSyyWvr8sCBUW0Kk96LniQogbDsJOkz09k7F3tywLeyrDdLNHTDECOt/EQ/aU/Cqb7k0Bc6s0lszV1PXWCB+Ncow8AaF804XnvRb7PV5Sces0q1QoRDLRbJ+7pQNhj7INQiLHB6vb+NkTx0hLPeu84L7uBpSo7GKEsqTXg5OL0qX/w5BMIF0BV1lcquY/uxpEKcMUSUgvM0g3oAXdsQpTwyrOZHLM0pXMpM4+aR7iStn3dJZ4Tp6hiku25TRFTRRcJ1qCU/oWjmpbVhv93Q2l1BKt6pzFYr5kFTO85CjM0yzfqHRIQ55jDkO/A9oDDsGMxByLx4PeyMHhdEDgJtNy22x5PH4l36pT9zny3g9cC88ZMhjce8DXwJ8tXB7FiZ/leasqgB6TJ0+/3CgMR1c2aM/ka+a0DrxDpKZDAjebrBgXYgytDWfpYddXgy8vAaiWdOFFZ+uQa66F2Fw0zyW27R1OlOAYGsgdjrRzd1sOaDtX1OXQgKX+xy8h3XxGXXX1uP1lgP5ZydcqhpUzayZJbkoPi4FbKPgtOujo4g6a7eqPaCQLXlPIQac4fR18B0zKinKtFdity5+VyQgVW0+KCLrlkd3Z5qeEUxsCptQmL0X1mDneUZOzQHAwTM6C2Eb/5w0RcwfEnthmhhAJf3j1cfsCEB5nIlKr2D98Qgb+5u/pyzC2/ReffD6VMCIq6JAgJSpPLnZqGHgoiygnt5Y9/fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(2906002)(82310400005)(356005)(82740400003)(16526019)(81166007)(336012)(426003)(47076005)(83380400001)(186003)(2616005)(40480700001)(26005)(36860700001)(5660300002)(1076003)(86362001)(40460700003)(44832011)(8676002)(54906003)(6666004)(7696005)(36756003)(478600001)(41300700001)(8936002)(6916009)(70586007)(70206006)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 02:26:36.4602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2eacd3c-3e9a-4442-75fc-08db7f5ac103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690
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
Cc: Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

NV and VI currently set up a quirk to not enable ASPM on Alder Lake
systems, but the issue appears to be tied to hosts without support
for dynamic speed switching. Migrate both of these over to use
amdgpu_device_pcie_dynamic_switching_supported() instead and drop
amdgpu_device_aspm_support_quirk().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 -----------
 drivers/gpu/drm/amd/amdgpu/nv.c            |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/vi.c            |  5 ++++-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 813713f42d5e..6ecf42c4c970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1315,7 +1315,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
-bool amdgpu_device_aspm_support_quirk(void);
 
 void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 				  u64 num_vis_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7314529553f6..a9e757f899f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1505,17 +1505,6 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-bool amdgpu_device_aspm_support_quirk(void)
-{
-#if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
-#else
-	return true;
-#endif
-}
-
 /* if we get transitioned to only one device, take VGA back */
 /**
  * amdgpu_device_vga_set_decode - enable/disable vga decode
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 51523b27a186..71bc5b2f36cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -527,7 +527,10 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 
 static void nv_program_aspm(struct amdgpu_device *adev)
 {
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev))
+		return;
+
+	if (!amdgpu_device_pcie_dynamic_switching_supported())
 		return;
 
 	if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6a8494f98d3e..f44c78e69b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1124,7 +1124,10 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev))
+		return;
+
+	if (!amdgpu_device_pcie_dynamic_switching_supported())
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
-- 
2.34.1

