Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3795C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34DA910E3B4;
	Tue,  8 Aug 2023 16:27:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695B210E3B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL/U7kgErt6MQhpT56OtkpE8eG+SHHHluypUG0zTDyXkI+kDSscVw8mnyyfJ3ptkrsmKFUPoPkykMqt8W4V49WK0Uie2e8e8UcohmPCuJNoafpK9V57csywviN6oDA656YcbGHNtGKIf89/v68Vmf60aV9cwAQQy1Jd+iZysh2+2Yi/PqPmRJnh+yJ/OTggiTiflAkeHbzKqHiK6jwgqBMYjByCpoaXz7vJ0YlcFcPAca9h2FP0muFcsI4O0MXDtjdz5+Mdk2MFYzjBmAvdBgpF/DAoU65OWaWLocdXMz32gGmz0FWDJZxzsczXFJ8mD3RYXiU6LVP+vOCAxOGvBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxy5qDRUin4mlBBbl4Wh8tAdST5cpw66RrHFZBb+wF8=;
 b=DJbf/HYAcWtdm1r0vB5DbvXHHsQcXBD4aajNm+2l+lLNbmbFR8OpEsJW4rccepvl90Lg0LGbiCX186JD8wUf6WeYUKg5TSivuVy38VFW6Y8h2v86wvz+6BUiOxwQKxCIBQE2Pkaq87XP+3DQLAw4Ijo1XI2dD4+x6yAgrfkSc4vM5aJcw1Sa6te7hN4Z2si4H6UXERgyKCJW94iOe6J9MDH4GHkhIPBCx2YFJfAMMDDOk+Pk20u/VkteJ2Q9QSvQ3AClWFX2caHMAI/NW61kAgUodW9GZCt1eh9qQcs6LYvAjdzKieu0TUbCuQdr3DCgPD/le/FI7aGm/fqP6mjBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxy5qDRUin4mlBBbl4Wh8tAdST5cpw66RrHFZBb+wF8=;
 b=az2WmgCZx6tG7mGTGl5JnSHO3koTho7Yl44S2vJ5vkndwE7gyoQERTiimBFysPfXaN4yNzUwfVzXM+nRsaLFHlR9pC4/SHHzP1F7YrFo1/Z7nY2pVBsfcNLW1biZGA6Qvp/uh5R4n0T9z6eyNgdWWpPo7LxryxO5sJ8DiS00VZk=
Received: from SA9PR13CA0115.namprd13.prod.outlook.com (2603:10b6:806:24::30)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Tue, 8 Aug
 2023 16:27:08 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::b3) by SA9PR13CA0115.outlook.office365.com
 (2603:10b6:806:24::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 16:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 16:27:07 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:27:06 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 6/7] drm/amdgpu/jpeg: mmsch_v3_0_4 requires doorbell on 32
 byte boundary
Date: Tue, 8 Aug 2023 12:26:21 -0400
Message-ID: <20230808162622.74937-6-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808162622.74937-1-samir.dhume@amd.com>
References: <20230808162622.74937-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 855507f8-d0af-4d0d-f8f0-08db982c4f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2I/I02eoikcJxxf+KMIHCPJXCfPwz11oeaNYaCha1IsKJ/n6pZipd6TH2mSp1dF7HAOysXwN9dh9DB97XGbh0ofZWAD0N352TYtW7ADmZq1hssvzbWkVEjunp7HfV7Hl1q8raydvF8OXEaD2yZ/3FjM3ZlN8+qmLB1e9DELqBafmLax+mdbEG1LooNm93jAfFOAJG+gpntLjybeNImavaeeUNhet9foOMCNSsKSjOdYV28BG3jjDDdRC4l7hMAHuK7MXHbV/l3BUNWdHoeQwYulTIfQzDJy0/PmPUtRFhmKwkgXAZ5HE6eQq++/KpzzfeqSP/l7kQrM58mPShLpAz1eql0/Yt4B8wjqV8iIQP1NYLoXr7Zc+XVupLkPZ96Rp3noF+2Sw4AIKJSAnS0Rid62jiKejPLKTyBDWbhV2XPBQQQrPHp/Xb+XsWdyCooaNX2lQqL69SVeLVPJwVOHLqynfxF+eQQE+2yfNMx9/c+7aVsrTKms3YjCBRv6h9iTXG3r68oG00FCCdzZglCNQOKiDubRCunYUchBoyeL05BxeCuP0+1KJX7r9uz3MHmS7ndxXCaPb2IUOnhhazutpnhavyJPU80xChj2GOfcg2KCHdmj4Wb2KyzPnMYOnh+PwK8mMshrTFq70F4OGG8vQRd0zn8aGgFXOVtFJyOy6S93Z+JKBq/I+dQngRd0v7vFAh2dFp2f099IcBvydsYHe9uf2jfYdpST5tXYa2B0Zdgwha1yw5c9PxFqJlpDhHg1WbN5FkLzAL2um9O1AMzqDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(1800799003)(186006)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(70206006)(2906002)(44832011)(5660300002)(70586007)(36860700001)(8676002)(83380400001)(47076005)(40460700003)(2616005)(41300700001)(8936002)(36756003)(316002)(6916009)(4326008)(54906003)(7696005)(40480700001)(478600001)(426003)(336012)(81166007)(356005)(16526019)(1076003)(26005)(86362001)(6666004)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:27:07.5976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855507f8-d0af-4d0d-f8f0-08db982c4f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, emily.deng@amd.com, frank.min@amd.com,
 alexander.deucher@amd.com, Samir
 Dhume <samir.dhume@amd.com>, leo.liu@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

BASE: VCN0 unified (32 byte boundary)
BASE+4: MJPEG0
BASE+5: MJPEG1
BASE+6: MJPEG2
BASE+7: MJPEG3
BASE+12: MJPEG4
BASE+13: MJPEG5
BASE+14: MJPEG6
BASE+15: MJPEG7

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 33f04ea8549f..f745eeef442f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -111,9 +111,20 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			ring->use_doorbell = true;
 			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
-			ring->doorbell_index =
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				1 + j + 9 * jpeg_inst;
+			if (!amdgpu_sriov_vf(adev)) {
+				ring->doorbell_index =
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					1 + j + 9 * jpeg_inst;
+			} else {
+				if (j < 4)
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						4 + j + 32 * jpeg_inst;
+				else
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						8 + j + 32 * jpeg_inst;
+			}
 			sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.inst[i].aid_id, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 						AMDGPU_RING_PRIO_DEFAULT, NULL);
-- 
2.34.1

