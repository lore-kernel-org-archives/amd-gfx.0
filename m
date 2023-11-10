Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69819C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 22:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEF710E2A5;
	Fri, 10 Nov 2023 22:35:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 178CB10E2B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 22:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awseViE97Z2q9ofLdZAL9m3Oab7fh1HtLn5ZfShoASjTQ9W03VSqdl5/35vEpR6x4iPhKyyaHGiQytsFjPP/Z+GC/lcvS+yNtB24h2dE9s2SN1y64KNWoe90tXdJScpAI4NauTMQsOLUQ/i4OZ0KsKoSTpyeCRODeneCmdhv3VqmhB8tSDeeLB76yZXgu10e2G6omH9h0wZc2NhkkJ4Y/0eyOY1joYFH/V1jx7o+Q7sbv5EobKRsX2EqznaizoAperB2+aVnTO+q2OZ47jbiScWFfK9/VyUGkiJyLnOkGxgcNYEKOI/FgONm3ybpklhpyMLSmivFXCs/xiUsQhZmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0vMPC6G23IMJv7BZLw0Hga6+G/pTWj1MibllNseKG4=;
 b=dL0cwKqNfpWwsHkE4wUlHazBpHnrfr96zF2cpAVgTTlymWS6zC7OO9V48jEnhpoPPGA7ej08kOx386XXr+lM0Q22Fq05QiV/6YYuL5JDAxwKm3q1Ba23z2FUbpi874AyTS1Z61dkR8R+KslV7bYuQNZmVUKCbU8MHr/0iOPSKbQn6fy4bSzqULRcaDyz7M7C3MCPCKuD098IwEsyFsmFEiE61BCDFU5UHpOWMafKEzIvd9rKVskuUrb0nBzmnp30RvfmQPSFAm2/EC6+hE0uJluSQH5zWQxDnhod/faSIQxnJJKZIBb+25FZ+B892FLJfKayJAm0tbRq20Vt6CnPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0vMPC6G23IMJv7BZLw0Hga6+G/pTWj1MibllNseKG4=;
 b=dMvlawgf40bcRxfUQKplSP/26kftsTFt5dQNL0FnH5OMUxRIPb1l6b6QgGxiUWWrc4Wkt+/9YJcpzM90enc7IjgxaOxjl7q+YeDhNfNB/xuRqjQYiwXK7ehcOOZhYA1k4oekCLNSscx+F4TTAw9ha66xlQSZZmOwuGy+DfAuibg=
Received: from DM6PR07CA0111.namprd07.prod.outlook.com (2603:10b6:5:330::12)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Fri, 10 Nov
 2023 22:35:05 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::44) by DM6PR07CA0111.outlook.office365.com
 (2603:10b6:5:330::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 22:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 22:35:05 +0000
Received: from test-TBI1100B.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 16:35:03 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd: Exclude dGPUs in eGPU enclosures from DPM
 quirks
Date: Fri, 10 Nov 2023 16:34:52 -0600
Message-ID: <20231110223452.13439-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231110223452.13439-1-mario.limonciello@amd.com>
References: <20231110223452.13439-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3aadfa-2ee3-4764-31e6-08dbe23d4962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTu/ePmEP6VE9EXgJTmwzFIETOo2tqjqWoTMGH+QRGdHPJHmDAlCFzQCkjSRnpzA7X/7wvD0gOPwEmijbzXpG6nDXS1mtf6cliBbw1TqHYGMaHGtli8GKOh8f1wxW6RajZ5A3OQvWzfiYouOVLMadsVcwGxg0UhdCc/j76emL7gce1mnPuwKFy1/hm96cW1RxJyQdV46X7CpsIJp+9x1RpZNklSXWxRq4Ewj0UdQAxE1K2EzLXiXKeyiMf1Jfzkww3fp0rkO9Upp3DW1ODHTvS+VFr69YUd+Yp8ZlT083VlSbbNI0zuKLL+tpPzd9TKkO/qa2sDD0fPKlIOv+g5FJ75KaOTry1i/opc5ZEt5/WQ0N80y4wenMajsu62d4/cvW3xj6AF4WXFHkmKWgN2cimRW0ZSBSuF4j+Pqak5OeVpE9SYcS7s4oEkY/AaLa+Eft9/tdJcPBdAptyQrJigwZa91evgZDJK4c9NZcIhuWRJiw5fVZwD8iYEcEhhPlAVfRectoqDdPqJUlb/16RdaHlE8aX2KohXZM73OMfF0bRoMnWN4vMOPtOcK5mSk5db0vRF28j+6IVGB4Jly1WLoV6rPlXeajvUNeDCY501pGCUj4RYWf8fg0OuOScWLZjGYeybaFBekUSSNfuehdEYQRKLMLHy5reDAb3UJqXT1wKb83W/XTnF+AsM7wZReaW5cdETxTsQERNmO8sDSn3oa+EsWF4z/Bv1YPKgkt/2MyklN+bN+ZUq+Z/1igBDaHxeV6WsarKj1CbJ5VXmkZB0X7r3vjFZPeOmU3s4tjfLJn2U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(36756003)(83380400001)(26005)(316002)(16526019)(1076003)(6916009)(426003)(336012)(70206006)(70586007)(2906002)(36860700001)(8936002)(8676002)(5660300002)(4326008)(47076005)(44832011)(478600001)(6666004)(7696005)(2616005)(966005)(82740400003)(40480700001)(86362001)(81166007)(356005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 22:35:05.2611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3aadfa-2ee3-4764-31e6-08dbe23d4962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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

The PCIe speed capabilities advertised by a USB4 or TBT3 link are
limited to PCIe gen 1 per the USB4 spec. In reality the speed will
change dynamically based on fabric conditions and other traffic.

DPM is disabled when dGPUs are connected directly to Intel hosts
since the PCIe root port isn't able to handle dynamic speed
switching.

As this limitation is specifically for PCIe root ports in the SoC,
don't apply it when connected to an eGPU enclosure connected to an
Intel host.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2885
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Adjust commit message
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 683ea2284827..b49ad7690a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1551,11 +1551,15 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
  * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
  * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
  */
-static bool amdgpu_device_pcie_dynamic_switching_supported(void)
+static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
 {
 #if IS_ENABLED(CONFIG_X86)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
+	/* eGPU change speeds based on USB4 fabric conditions */
+	if (dev_is_removable(adev->dev))
+		return true;
+
 	if (c->x86_vendor == X86_VENDOR_INTEL)
 		return false;
 #endif
@@ -2395,7 +2399,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
-	if (!amdgpu_device_pcie_dynamic_switching_supported())
+	if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
 		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
 
 	total = true;
-- 
2.34.1

