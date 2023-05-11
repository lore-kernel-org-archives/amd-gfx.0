Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1447C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 14:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516F610E02A;
	Thu, 11 May 2023 14:43:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF3710E02A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 14:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsJjh6h6jbzsqTLK3uv5nnclIaKX8TCR0r/Lu8hj8DKkdS0ZObqFmSzQZhERTm/HSZLPQz7zVeSULw42UUVF9eR79RdRcKQhsyv9sctLS8O7o7UO+tKR8Kdk78G5wyccKa2nCccjqt+0xC2rcFUwcMqHwBMs2D3pxRnRKx2YtHoUzAsJPmnQ2pt4kkVVvzZ0RYscGde8lRBrARJwgMx4e8+oLLgu1u4w/6XKElVzcgyCCX71q06v8SxVuayjEuUSJ2GtXgfGvzUQ8k7hbAwGGbOAxkKHk+iI8cl11uaRYXI5iWJK0T20C6tXkjCeiiNuSJR3FnwoMUcQCnMvZS0nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZwQrEdj68YTWWqHQo/ixBJ6MqW//rKXu9hLAvsZZkA=;
 b=Zzl4/kZpEfdAFLz84d27Vc1i/+5gFXNIzgELRxmpw/GQKs8ZKiU7pXBAP0Hj0ZYhoSgC0ju6jYatzItJS2u8BPxmJbTh/M4J1D+u+8Ea0q2EU1TJpF04nQXmaH+QIxliq5sT18CKAIB7ICMALRN35vF8OJBwz6tdIs5uSh4TMH8rRqeneeHRGeNT001NohpyMrAB+gieuVt6qHSgFQEpL3txt+SoY1etCb5ClTszBXSxgu8YOSpWvU13EfBhrzNHJyFtQQdOLA6fi8Y7vEsDCyo9SeuwMty+tq/lkBUsKjJPr0uxpQrQMuYBnfTNGOYO7++Rgdy3xjijXhHLIcIIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZwQrEdj68YTWWqHQo/ixBJ6MqW//rKXu9hLAvsZZkA=;
 b=p2nsrvIWVWWpRnPN/48Nlj+/v3j1+wjd+m3416crqCaoAr/kCfeqt5/2k1kkGrC11YYQ7OyNCHdUpAj5NNR1ILiEOsMlX5GiNBueW2uBTK/a/RJU2uZnR/vMlihjsQSbPICaFb+KtBLaxEQ5wvJT/29jJC7nIXhiSwhta1DbI/Q=
Received: from DM6PR14CA0058.namprd14.prod.outlook.com (2603:10b6:5:18f::35)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 14:43:37 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::7a) by DM6PR14CA0058.outlook.office365.com
 (2603:10b6:5:18f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 14:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 14:43:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 09:43:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc11: implement get_vbios_fb_size()
Date: Thu, 11 May 2023 10:43:24 -0400
Message-ID: <20230511144324.500617-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9ff9f0-d0dc-4edd-fe0e-08db522e1ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnL0cvykZDDY2MPpctq4OLoE6Q8bQO2MFMtExkLn+KXpeQAzK8+wO3HW9Lm7mEmHTtCGO/JBPNzI0XpRWSsYj3qmvmO+LVMdX+3Yp3OhRxOnxjVtCRwaQqqXSWSJ44ywO0OenlJtI37/LrMzd4cn40l++eph3Ik3Q/joz4sZ1EJ6dafATXRXGfIBzW+3c1HNWHZoU0LN8HIUclUk9gnrOiDIBsFPTfLiTfxi0Zt7cpug2eWptuu4EyN5AK5TcIyTC9jU4FWM56Qb8DMHLslmIQpR/YafEojnMVIRxMWH5P4iiS9Pxzmj4t5iQB8xY8BHbI7cOjocrpSveWr1ErZ8GNMdVEGfsBCgk5A6koiZbEc9wINHiHAaBiBmE53b14wuPg26AR/ob2r8aqomwEZBIrvuAiKxUtJhrSLWadOpgcPTHpfL+eftWvTEAdJfoYrWTWvBaORTF/bsm9bYxINU3EMOaOeS6FlN3Wigy7JUdwHJyBF5qJqoH+0ngZ3vDoY952vPCPEGAmc83XUG8ENwKc40m0VxWRZYWLLGuzFUkNroFOJ+LWJHqhISsbZ1eCNQPast5bmifXtRCJwea+PoLrdXUmheFOR5g1dPiKKjvgT7v0Ewjo8rylukA78S8B14VzbFrp6XB+aJHmBmcEbxLWeS/MoEe929ePC/65uA5POFopNjJ63GkX2PC3FeIJTZbZp8UTujm5ZzwSs2W08C2JOfgFEpdjDqOjnKFBZC/7BkvOD/ojm6FJxdiD4wCHvlRJnsV4YtMItFRC64QCFWqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(6916009)(316002)(36860700001)(478600001)(7696005)(86362001)(356005)(82310400005)(6666004)(4326008)(70206006)(70586007)(336012)(83380400001)(2616005)(426003)(36756003)(47076005)(8676002)(41300700001)(81166007)(8936002)(40460700003)(82740400003)(16526019)(26005)(186003)(2906002)(5660300002)(1076003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 14:43:37.2520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9ff9f0-d0dc-4edd-fe0e-08db522e1ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement get_vbios_fb_size() so we can properly reserve
the vbios splash screen to avoid potential artifacts on the
screen during the transition from the pre-OS console to the
OS console.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f73c238f3145..2f570fb5febe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -31,6 +31,8 @@
 #include "umc_v8_10.h"
 #include "athub/athub_3_0_0_sh_mask.h"
 #include "athub/athub_3_0_0_offset.h"
+#include "dcn/dcn_3_2_0_offset.h"
+#include "dcn/dcn_3_2_0_sh_mask.h"
 #include "oss/osssys_6_0_0_offset.h"
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 #include "navi10_enum.h"
@@ -546,7 +548,24 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 
 static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
-	return 0;
+	u32 d1vga_control = RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
+	unsigned size;
+
+	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
+	} else {
+		u32 viewport;
+		u32 pitch;
+
+		viewport = RREG32_SOC15(DCE, 0, regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
+		pitch = RREG32_SOC15(DCE, 0, regHUBPREQ0_DCSURF_SURFACE_PITCH);
+		size = (REG_GET_FIELD(viewport,
+					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
+				4);
+	}
+
+	return size;
 }
 
 static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
-- 
2.40.1

