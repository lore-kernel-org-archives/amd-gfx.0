Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA8AC7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63DB910E410;
	Tue,  9 May 2023 22:11:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD4310E40E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO675UEJCyYQKkD7a+ptMRxnMuEXTtxyop2eTS2wfWvjI1ZVMmitSrbp4e4cCEiAOtCpJArXYZf9ALwjJKmmcEQ5fIIac9tB9N+1cjV5Wgb5TPhXM6B1NVl6Jc3OxYTIqiLjwijantzcJhueNj0vNcfUT+ferp9CHzO5zyaNnPbT3BAVoHcjGxBitwEuA8KaxSSMD/wJs+W2tmJSuTqP6xgknNyVjur1BR5AebRTZmhp+VSMIXeLMZID2Ld9DXmfwfbND5WiLSt2DNTyFRfy9jQMntYgcAsNk+8H32E/lpWc7zoLtUaHlEOIYC939wUFHz+2AO/8uDevDHWVsXFjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYLZ0nyn1z4EnLoXYo8RdDYjNzWz/RzRakmaq1kKOQU=;
 b=M8HNJV4IDHFmRi/dF2ysZ86r9Ey0PsxuhC0zL4AEy0GmECKw6OMKt4l3+IOW3L3BppOfS9jMr3ucz6SZT50//LD/kVhTuUqQRT1ArhkQ+R2MWo2vtOLn9mLxqT4OLAfYi7NSZ0AiT+6VCYuTmBPs7ij+olWhPPmyXYQj5olL+kc6AHBMijEZPWrCzf/tKW6uoNdbZ4RVRpGDNzYPitmg2NV/uLO8On8KL0uF5ZSILQeRfnCpehpa1LWjhepOy8C/Z2NA+rG3zDus6oG8WVg9R3zjRoQyiAWdkARce32twZLaSWDTZ/lAOmNc5eEXbFwy4G1mAIj5xzNHAkPvlu871g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYLZ0nyn1z4EnLoXYo8RdDYjNzWz/RzRakmaq1kKOQU=;
 b=WXnhEko6Y8kYyfv+lhKp5TOY2+jM/Q+AINqtyj1GJeV1tSVGD12TaLkEl2Yr+4NpwQPD/qtR1TQwzWIoyP1B09puvrIzIEroUd0HV5wlxW6Ky2iFxoty7+4jwtvKUQ6MFSTdP85LSdBPuGX5H+16T7ixHhdMFAoiOYiI3Si9FUk=
Received: from BN1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:408:e2::6)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:11:50 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::93) by BN1PR13CA0001.outlook.office365.com
 (2603:10b6:408:e2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amdgpu: Use a different value than 0xDEADBEEF for
 jpeg ring test
Date: Tue, 9 May 2023 18:11:27 -0400
Message-ID: <20230509221128.476220-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: a98ffff7-9980-4e28-a339-08db50da6311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XohvTT0rlXiICjGRXS0OcR9NPfmHC12B79OzLpAubLFFM4lAMRELY+wzOqa/QsNkZ2bXjqSWKDNRaBrt/qqgtDeEvaMAwEdLsgdKrrUGc7gvzwvh+B44mlJB0UqvcFWuelkkp22lZqttTVU36pd//SLz2qUTn1AdlgLDlYfROUm4Zss/o+S9AQz83YNAQ76QNakOz5yGTlFN7cxo9pPHKle3wiqB7LBEVwjFtjPnz5ETfJs3Rjy9QNZcr6flUFUm1km/HCy/AItX1x5+VLRARy4jCXujRSExPn9QDFDDu4d2SBcdPuNHdZPB4wuRlR9TJUej1A0ZFAX7c0NcuElY9P/BpE7KA3O0wBbDMCwpAMnmtF1IelC7X3WHrgWC20PkpjNcRjmVLJgaRKRVeqW3zBSVRvc0dVVur++z4Euuea8o/6ZT0XY39GEprOVewdQV/73FGgFEUl/abp5ASRyXkK72yCmCfzfprjZpaP7DAysH8uKEIdI0jTItEKZbsC+VDmnkwU1ukFy+Ayfmj+VVJSMNCTB/41S1rxhGlSN4sl+NOY71SOvykL3ybsvvyAgQV7EfcKJX+irKp1SoBwi4QC5x6XhBZSVnr0XVlYOfwKOGjV4va81X7xCIcZvMEWGZ6sUtX2gjTTe6pwDj2+z0mIBvJMrryMNXVMu/S8W0diRtR9t/yAA2wZ8iQM8luJ3ejqlQt1hxeDJ1zN4BeJdJMVP3ZTUEfwZSotO4QtYb2GM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(4326008)(6916009)(41300700001)(16526019)(356005)(186003)(82740400003)(81166007)(40460700003)(316002)(54906003)(36756003)(7696005)(478600001)(6666004)(82310400005)(40480700001)(86362001)(26005)(1076003)(36860700001)(8936002)(8676002)(2616005)(47076005)(83380400001)(5660300002)(336012)(426003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:49.7937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98ffff7-9980-4e28-a339-08db50da6311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonny.jiang@amd.com>

The 0xDEADBEEF standard anti-hang value. Use it may cause
fake pass.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 9a1db2bd03e7..8c479669c459 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -133,12 +133,12 @@ int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
 	RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe]);
 
 	amdgpu_ring_write(ring, PACKET0(adev->jpeg.internal.jpeg_pitch[ring->pipe], 0));
-	amdgpu_ring_write(ring, 0xDEADBEEF);
+	amdgpu_ring_write(ring, 0xABADCAFE);
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		tmp = RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe]);
-		if (tmp == 0xDEADBEEF)
+		if (tmp == 0xABADCAFE)
 			break;
 		udelay(1);
 	}
-- 
2.40.1

