Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A138AC4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 19:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412F110E3E3;
	Mon,  6 Nov 2023 19:30:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC63E10E3E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 19:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3tQY6ss9sjmJgTH1545Qw1DsOw1JRMK7d91gueQpzqOEFZXgWdf6L9hlcteIwKQQgLt8EFDv4gImPMLLss3YpEiPG5D03Wf6QlzhbSFKsooGbe0Muohvh63Zr4NZK24sV4JwEiAJuQkLhfgbVowJwKZdcWPopneguBQs+C7UYhlIxnBySDpxlY7l+Ij6lSib0Mk7cAlT9egrUjTOGnvgep1iFRUOIbrxGtmv64RYvte93ID8KEMDYtemnKnwUB1fGGZk/x6kSN4PbneL9RYG3nIuCXHCY42ZRZVknUUL9N/vcgtoqL2Hl7oeorjc80Si13ipH0l30C4AaDqAU2Vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfB66AwoKZzEuntYBAvhfjvj488ZwUGer0hAzomI3yY=;
 b=IdWpj+GoRXF7m37wNsLFvqvwIgiCONansDY7TUKZWZlLuMnvafCmdw827rcE0nbMN8s5yD/xbl3KDUXyERQj0xmczEbIjtGsOQ6MgdKrkKgRHNSq7VYB1qkb+QxrGbvWw+sXh+t46DtpPzkJlcQQR7a21u7nU3wUKQsWDQ42AFoORe8TMO/gxO6s3cV/PQoQ8wLgtka2maJZptdHvUpfycCWMQ6rPe+DxPwCHtiK2uduJ+ku1W8eaotVQqt6h91INrr1F98DAENX03gWSBLnXNe9MdKGXFf5LHxpyhHg2c4Dp7scpve65NFIg2k9uv1OxcIG2HFysFlk4gdBLqBa3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfB66AwoKZzEuntYBAvhfjvj488ZwUGer0hAzomI3yY=;
 b=ulYj/rrqxQDuLi4/HkW2WZ9lXG9/wrggpDnR8QraxYCR1cdqSbgwRjwmtYrsqDdLAB5s7QCSpQhzEUVSy46XJ5/LP9wi2YIlGa7THVszuoQWxYy+SkmddTcbbB3k62+LHwSJWtZGmDnF+3N330imATl3nwqhTzJIefnNgVPQueU=
Received: from MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 19:30:36 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::69) by MN2PR18CA0002.outlook.office365.com
 (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27 via Frontend
 Transport; Mon, 6 Nov 2023 19:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 19:30:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 13:30:31 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Exclude dGPUs in eGPU enclosures from DPM quirks
Date: Mon, 6 Nov 2023 13:30:10 -0600
Message-ID: <20231106193010.2093-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 050d8c61-a711-4cc1-dcc4-08dbdefed9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hE0d3QerXRwhW5BzWdU2gHgEmGvx2l+m/TEutSSmtV7I1qs7vObtHURxmLmYIlfsCBUGFHFDzq4zBu6KNRtpmh+7YdZenT8qMadWd0zSvTa6d7vlCdzL2gTNS4fIKV025LyZ6+hcRGjpcNgoHS9CfVZVctSQj/X25d9IagnAo67TqAEANKwaeIIXc7ZOJyvduGcyodFd+8CKrnTj2rzlSDXQbZutk5aURvoRzZWLJ8Jp0vOo0K7l1Kr8tUs9nYD+VO83wcyHyTQTj5FWkDMa/4XKzbw0spIzDftb4pl+9TEkSoM7rWm9RBTuzxYY95IwQ9KG2jgkAG85qzlgdcas8bJzo+qUCLryIPtsgYNmVeAaYNwPhpNUyx6PY8HEGHYiP1YCIxqt0JHiZXsWIoNvjvFnApQXR4c11ED09unIJvKV7USgE4a/5+dm8ena2VtWNuuOy+VrbFrTs07138VRclIfI7vS5ro68OfISP4WFRaQNXY8sij5E3jy7aXaBbvpD2SuVaeB7R8zY7VQJylCrNhUqNIVl1XPt8YpH8L9/vF2jwop0wphhYh1VF2k5s9Z+IKWf3oRvmv0Sz3zNrfq8oPQwCbLjxAq3AqcfIG/tIOASM4iUz8k2qt/9scV2EIhWqOUJn+CgbSsKxQbUHPzI+kUyOmFw3r51JXkoNT6/QOyvq8E70lsUTxQktanmQ5BuFzggmvKhQvBnw/EricQX6gi1KNNBeZWyzmmEgxnPmVROpUL1yTJbB/uqOtFM5e1pQCWAxucR1FU64Lt49yiCqdJQoqej0aKaPWpoatt4+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(36860700001)(40460700003)(41300700001)(5660300002)(2906002)(36756003)(356005)(82740400003)(81166007)(16526019)(426003)(478600001)(336012)(83380400001)(70586007)(70206006)(26005)(2616005)(1076003)(316002)(6916009)(7696005)(966005)(44832011)(6666004)(47076005)(40480700001)(8936002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 19:30:35.5651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050d8c61-a711-4cc1-dcc4-08dbdefed9a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DPM should be enabled on dGPUs that are used in eGPU enclosures
regardless of the host support.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e2199d8fd30e..29d5820e912b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1466,11 +1466,15 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
  * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
  * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
  */
-static bool amdgpu_device_pcie_dynamic_switching_supported(void)
+static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
 {
 #if IS_ENABLED(CONFIG_X86)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
+	/* don't worry about external dGPUs */
+	if (dev_is_removable(adev->dev))
+		return true;
+
 	if (c->x86_vendor == X86_VENDOR_INTEL)
 		return false;
 #endif
@@ -2310,7 +2314,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
-	if (!amdgpu_device_pcie_dynamic_switching_supported())
+	if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
 		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
 
 	total = true;
-- 
2.34.1

