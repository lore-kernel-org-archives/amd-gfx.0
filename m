Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8C6C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 17:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141B310E406;
	Wed,  7 Dec 2022 17:06:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA9C10E406
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 17:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/dq2XxK5konwgUpxhfEjpCUSeVnJZflnMwfkSUp1SzBnXl0tvWUO1YuVEJZT8TZjU+PNen+h2ahwULZZFJVa7A8xYBd9+pkzAPGhbtDjJOtSAJ+jFgB3l1NrEfYdXVM3jyIE8NhnGXzjYLJtzz833JMsuyX/fQ1THQKSk3oTtosrbPOezQq+lRHpFzUcStIcqAEjDY5r1tL+FJv6LAy5rX8B6NW9kCTfnh1hoAVmxzwHpLnGjBd7IS9JAX/9VyQM85RS/Y+C9XtEn9faQE7nP5cR8BQftmANwKxe0eW7vuKGfj3ZYgZYiOLmt1AgHddMzeHxLYkp0TQGl8KNDbi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7Va8tw1PRZNZo55n3k59K+DQ7N3TYZLfkLrJgoSF2o=;
 b=ekWLGe5SgrM8g7A6PHFXn+K+oSdmSkBSfxh55BNCtT2AfkhOGfTKgqf1vbpKxDvbgbazB3UWY1JEz8hWnYtDpKj0HGcEjZmlQM0eKCd/1Ka3+6qkLXjT2l7NJXt/br29CT/ocGc/Psvd0qFO+ijOEGkClLGJcq66z0rtBvNRPUAX3P0agw/ox+TopXY2p1kwsksQKtVY6NU48oKT5q0eDX/q8fxpn+s96lPRPMBvVppU/zoU3a6ynJlIZdEtiiNppnKbikDk9O8vJnCtMx0LfXpoUdYZLETn3vTENpoCz3jjOkGdyT+/96PZiVFcUSny9UAHzrVGgqH3dcBrwk8HLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7Va8tw1PRZNZo55n3k59K+DQ7N3TYZLfkLrJgoSF2o=;
 b=NE/4n+S5mY1o/bho5NbmyoRaZE8JN8hFP5O+TJ8EXKGtb5027whyP+AhywTJWqtlvaB96YQvKrAuNSz8pvpav+iZzdcmAlWYDDl0BKCGhPUQGGLdA/6Z5RIMknjiDysugzoE6AOR6g1o5GDzvs46TeQPBjJXDszC1lOI9mx4nBo=
Received: from MW4PR04CA0061.namprd04.prod.outlook.com (2603:10b6:303:6b::6)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:06:45 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::81) by MW4PR04CA0061.outlook.office365.com
 (2603:10b6:303:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 17:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Wed, 7 Dec 2022 17:06:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 11:06:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: handle polaris10/11 overlap asics (v2)
Date: Wed, 7 Dec 2022 12:06:29 -0500
Message-ID: <20221207170629.3291883-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|BN9PR12MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f23eb8c-ec32-4a8e-748f-08dad8756b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed0U63DQZB0/as9zsTnhCdYmOM0i8G8o++5T7HMLeSkryjysx4g8wtP3aZ4NJK3F3ChAjTP5No3jJJZl06gfThR+TC7a+vR43OhCaOiOMJrXci0AiqJNUy4hl8s2DDtVAyql0PpHwPCX//oUmRYWG1LGgnY7ikUw4fI5f3BEeVOorthRfrQFnAVndfkPmLZnGXMRqTleDEzOxXTjiY6OY8zp5RtK1/JYJzOkn+jZB7VsWWh86SXMcjnXg+o6GOwG/hKgfBIwMUV2h3HAoDjOs1ogz6bgese2JKYxgshZUpETF5r2+3ENM2N7ChTwzASsYLTT1U0y+8ybE3jNeud+TLAuQfc2ifWFOA+fROascdLdnykW9NBb4BZOg4c5TLsRCjQu/4fOzwQyVVlXD2fM2mjiYEHkRABx82yomwxIKSo2uB6RO66sEvPZM0RufkQ5FpYQOOyt1XpzGXWbpDVdPVaYteVD5MaZZVTyPaZityRkcptuGTcnWzBOFdb5O0pq5H61Jy8dsakdkePHteyDl+mPNpg/K/7H55wrb8GokzakhnXVehu9B3gZT8Jvr80w4mu3JicES13XZ9ROO3+HFm1EvFfd9N3YKErsnr5NFgQJYvxyk8lCKrhabU/RWyitk84Rj9J5ayE7kFU3FqJLI/hS3cytwGCS9bXl1JVp1epQz/lOUPqUWYxdsQFGTsp9idv1vUqPKeZtdACj0JWe6iLHBJrDcNtg2iCHqG7zlFM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(4326008)(2906002)(86362001)(356005)(81166007)(70206006)(70586007)(41300700001)(8936002)(8676002)(82310400005)(5660300002)(40480700001)(26005)(7696005)(47076005)(186003)(16526019)(336012)(6666004)(426003)(478600001)(1076003)(2616005)(316002)(6916009)(40460700003)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:06:44.9605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f23eb8c-ec32-4a8e-748f-08dad8756b6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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

Some special polaris 10 chips overlap with the polaris11
DID range.  Handle this properly in the driver.

v2: use local flags for other function calls.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7383272c6a3a..b4f2d61ea0d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2039,6 +2039,15 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			 "See modparam exp_hw_support\n");
 		return -ENODEV;
 	}
+	/* differentiate between P10 and P11 asics with the same DID */
+	if (pdev->device == 0x67FF &&
+	    (pdev->revision == 0xE3 ||
+	     pdev->revision == 0xE7 ||
+	     pdev->revision == 0xF3 ||
+	     pdev->revision == 0xF7)) {
+		flags &= ~AMD_ASIC_MASK;
+		flags |= CHIP_POLARIS10;
+	}
 
 	/* Due to hardware bugs, S/G Display on raven requires a 1:1 IOMMU mapping,
 	 * however, SME requires an indirect IOMMU mapping because the encryption
@@ -2108,12 +2117,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, ddev);
 
-	ret = amdgpu_driver_load_kms(adev, ent->driver_data);
+	ret = amdgpu_driver_load_kms(adev, flags);
 	if (ret)
 		goto err_pci;
 
 retry_init:
-	ret = drm_dev_register(ddev, ent->driver_data);
+	ret = drm_dev_register(ddev, flags);
 	if (ret == -EAGAIN && ++retry <= 3) {
 		DRM_INFO("retry init %d\n", retry);
 		/* Don't request EX mode too frequently which is attacking */
-- 
2.38.1

