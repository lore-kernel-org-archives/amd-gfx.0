Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45074C4707B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 10:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E144810E3E0;
	Tue,  9 Jan 2024 10:31:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEAB10E3E0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 10:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7fXIw2N/nkubM43dA9Y2IRoLbOpP7XRQEWy4/ZceYLEp/IwjtkW1LRM62JnEjKFVSwF8oS6QXipR5ruopjn8u5Zich865oGqiHu756Ccv64h45WL1TI80+mPLuPq+ECtZXM5agKiLcVPetss5VWELVmexBszHgX+O4/QXEIxHTTflHuBvLrLqubh0F7OGr+nkFiHWJzYP45UrXZKgpPu8j+ZyFlR7ARiVj+cMDPvhpVO+wr9B5KAgZ+VwNqeBd8hdA7JdRnGS0VZbey5a2NWaEDnyets0PXpfvxrKOzaNDuOztGjuVmnppS7INJSuluI/fEBYOgh1Yrp6e500TZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q03c3ZN4x8sS8DZovyOFg0KrY4JECTT7DzssvVGkcgU=;
 b=LIfowVbb7cCXuaOsFI30UjNc0TpRr65ykLWcw+EeW751VVP3tmOZuEW/2e57zNnPHv0ckHsj44GX48L12yGcyBPDVyVxUnQ/NRGJOtGzH4I6eJ4g/baHJZtCYG4eCmOwEfllDKuhxWHFHUbolS9ER+qgX27HWTLMbOWGyn+Iiiao43tUhoh9iSpUt0cUueMdJfOaTE9obHmehkX7RIUvKa3ba9H3u6m+axnVBrER5Xfesf/Ys1IOVQN9mhL+IBDLQcuUoEt5LohdWznmyq6N1RRanQhT4xf/gz0BLk+m16k9zVRpZjk0ucL/fWQopfleD2tn8y088DMN/nknLncKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q03c3ZN4x8sS8DZovyOFg0KrY4JECTT7DzssvVGkcgU=;
 b=5NzTQycSI/3Z0kkpZC+MtJUqdZ3S6zGmtPBGe2vDc8/+yur1JEI2uanD0N7bcdxLPNc+sCbveImnPtOiwo6gLw59jQyaP3v4otUysnZ+zKmnBBbxoEMfnTUSzohIlNZwCejEbI9k2Y3tGFhpfHUgaXHBcBafXG67uPaq4lQnQIY=
Received: from BYAPR11CA0052.namprd11.prod.outlook.com (2603:10b6:a03:80::29)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 9 Jan
 2024 10:31:26 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::31) by BYAPR11CA0052.outlook.office365.com
 (2603:10b6:a03:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Tue, 9 Jan 2024 10:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 10:31:26 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 04:31:24 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Check extended configuration space register
 when system uses large bar
Date: Tue, 9 Jan 2024 18:31:04 +0800
Message-ID: <20240109103104.645692-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|BY5PR12MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b063ba-780a-4476-6406-08dc10fe2270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODN0sSqmXWKaytpnFDas7ZWHd0RpAnhvurZ3SSe52/hDjU/xJq1NRPAs3iTNDWdHPaL5+me8XJxWhMJqL/LltzRepKYOet81eNvn22NOV6oaiRRORscEQp7l3TH0A4ieHGerQZ7fQDXfXk8+r6vn8MthRPgTthF70C8R2RoDCqhDaN++gEVoB16Vq+oC9lBvG8mjxN5IoLsWNAeY8vNcq9CYxUYMs0n9TFi0IO1RlpalRBpTOYZy/ASZzbDW2lHxouOeNMyTNdLIe2afwydtxZQBzavipRUwEryNGE58k4yiCucQSm/cQ0Iig66yeBRqid4UCMRWVJbBqHEjDXnLlZFqRTDg7H8fDsF5PYBMkT3eZtTc3e5x5dXANxm1nt0vUJjkYwO/f+A7vb221RXugHuv4qBo8iDAsHZPLFTZkIVuxpO1g+tTUAhKVUGli+Oz5P8gKy4BOkqcgnhSo0ZDxF25NEZfShJwrJZBH30myXea50unkoeu8LvfM4QBkfF4mkq4p5Q+WoApVoNsaHDjxg7yOXrCeCU4zPhnsbDe1U/q5aHT/Qvi5ZsbiXV+oPYqYKpOYNlOsgT6n8vZdVDGfO3qeAR0UzLU5U5VEwZEOJ8Bn05u3SmFcwjxhHEqpJtyR4vjFqKTHJIOAvIBFN7UnxmgigIFfk89iMSNnrt619dRYMZ0Chnuz5b0P2kMZW/wyWJ4SwagrY2GPvR87HSszXyFHiLoQDFqgot5DzR823Yrz+k0dWyngz3cQnAaMxDCCCbs6Syc+zNMDP92tJRTNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(36756003)(40480700001)(478600001)(7696005)(70586007)(70206006)(86362001)(426003)(336012)(83380400001)(16526019)(2616005)(81166007)(356005)(26005)(1076003)(47076005)(2906002)(6636002)(5660300002)(316002)(6666004)(4326008)(82740400003)(41300700001)(36860700001)(110136005)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:31:26.3890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b063ba-780a-4476-6406-08dc10fe2270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some customer platforms do not enable mmconfig for various reasons,
such as bios bug, and therefore cannot access the GPU extend configuration
space through mmio.

When the system enters the d3cold state and resumes, the amdgpu driver
fails to resume because the extend configuration space registers of
GPU can't be restored. At this point, Usually we only see some failure
dmesg log printed by amdgpu driver, it is difficult to find the root
cause.

Therefor print a warnning message if the system can't access the
extended configuration space register when using large bar.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
v2:
- Check the register at 0x100 but not resize bar register(Christian)
- Modify the commit message
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..0d7d55f13b8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1417,6 +1417,13 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 		__clear_bit(wb, adev->wb.used);
 }
 
+static inline void amdgpu_device_check_extended_capability(struct amdgpu_device *adev)
+{
+	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
+	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
+		DRM_WARN("System can't access extended configuration space,please check!!\n");
+}
+
 /**
  * amdgpu_device_resize_fb_bar - try to resize FB BAR
  *
@@ -1444,8 +1451,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
-	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
+	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
+		amdgpu_device_check_extended_capability(adev);
 		return 0;
+	}
 
 	/* Check if the root BUS has 64bit memory resources */
 	root = adev->pdev->bus;
-- 
2.34.1

