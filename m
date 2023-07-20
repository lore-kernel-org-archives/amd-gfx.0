Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA46C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 19:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D36810E602;
	Thu, 20 Jul 2023 19:20:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211A710E5FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 19:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl84fiXrDNskiyV/gatRLcX32MzNxCB8VebQB871pUM39k2oOHRr4XpXwEJdSo/xxqvOOOiZvBaf5fRZHFt8i19OC9KAU+TBdyU0/u9iXzEyCRo3NnQIG2BYLUx18jdD50N1c8MpY3mvC4TH+J6YVLfFfN2KvDuQBfqWrJxiDr3cyRQYWksPXdUCBjryYsEjWd/LtI2vKxIb121SgmiosommEadYm87GFzl/gGjLXrZx58pd59wVcASDMZf8UieLqODohYGNSxxz28szMBIA0zI6vl3VSYuWrS5ZO3Jm87W+5EKIyliajMSzdjpgjnIBQ1IGJREicCOXhj6ggnbzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOTUfDRdAJ19pTQeUKB2On1bXu9BJim1OXCWQkafYSA=;
 b=BH0hXw/KVr1MPrXI7PSwARoe7RTpegWeYbq3bnDaT/0MAhR6Ii+RwRTUDqwCRaWTbuhEJWNoiLY6qMsYtjyP050DzCr3u8l9C3P5C4xuqXAAKfKUrBRXha8tXsB31PYP7RAnsDvoSwZMY6NSN2plI7DgKduy1qdBK5NlaaS0YapoXYoDRayH4cbOKGPpHSakoLqvYV35px5s/B2MCssm73bxn7eKnpiqjm8o7Lgw0dJyoprrPTei38OtXXAw2GBtz/sDZ2xLaqCNzToEuvNorLsX7YseKSfVzoXGBKt2pIlzDQpNMUYQH0ROBPaZR7H8hV9iq82+NSn8khPIbjE+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOTUfDRdAJ19pTQeUKB2On1bXu9BJim1OXCWQkafYSA=;
 b=n532yrMA6H7EgldZr8NRHohdcTCHSZxQkbjwG2buvZauGenPOHZYQlBOe56QI4k6I4jMaNAMtCwCKkqExH34M0XFzbMO85jzGmvJ/K3WEM4fv5gPXOeBdL18Snk5hAwlcJLfA/he8Y9fn97L4MazR9qO0f1qw7GkR18hrRqpUt4=
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 19:20:28 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c2:cafe::51) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.26 via Frontend
 Transport; Thu, 20 Jul 2023 19:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 19:20:28 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Jul 2023 14:20:27 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu/jpeg: mmsch_v3_0_4 requires doorbell on 32
 byte boundary
Date: Thu, 20 Jul 2023 15:19:39 -0400
Message-ID: <20230720191940.780187-6-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720191940.780187-1-samir.dhume@amd.com>
References: <20230720191940.780187-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e8a0fd-8f70-4323-c2fe-08db89566090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLJXJXSXruoIAuJQKybcKPuxEVza/vcWirwas3WG4fXj7ybgoj1cxSuN91k+w9Ymy05na28CiOT/sq8h/VDZaic5xeehm6aEa3ZjgnkG1xkkbHdk4mHCNdH1zUKYOxF83y+O6KQ5yDe3L3G8GimQ/oW1TBc8Xp93UDhhUzSvSkvF1LJQ+tW/aP1hw9RICev/SkF0JDToxVqFiMRrUESd2UzIvMoqtCcMK8Xu7QbKqoKuK3T0C3HVwact1c10qkLEBxPd4aEBanSP4Mu8U791Gk3MMuk/jcn/5MoYw7TYyTNOfkYxQ1q/nY05HeoidSqlYbvl/YpPhn1rUJe20+B66XkGgC8rxA9dhj63jB2s6H1QBg2fZe+aN7FhsgFaa4ICUWRnxKW/dTxj5HM1ROtSazalOxfkvuHZR9XApr4vmNwxGjbm1Ml6gH6YpWGKLndvzfY4IUrunWZrSIricvBM2drL/6RXTBvZbw0zyvSd9xNWbbKkgPiTryipqQknWvARs3w6O87Y7QFZD8G+OIAegNnBUtLz9CW9LfimE3Q8oGjgpZ4ihsO2FHPC2EV5z/UjTtveLRe+xkBBwde+UGxla7sKOvG/ZWQKAEtRFRSrzEt+bOj372vPWnoMMFFhIsNBP4QLGsk0xiK8wOUd4M0KOmPMYCEpNRS9fC4EbP+IyhitjwVLwNj2lCFj2Np85CgOdQKnfGuZhs39lltPD43WdZSCUFDrKlyuOouW0UI0tVz2O5S6EkD6a/jYe225u1c9brcntfGvRv0Rnv4V55/rcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(70206006)(36860700001)(7696005)(40460700003)(6666004)(81166007)(356005)(2906002)(8936002)(316002)(8676002)(4326008)(36756003)(5660300002)(47076005)(82740400003)(44832011)(16526019)(70586007)(426003)(6916009)(2616005)(26005)(40480700001)(186003)(336012)(1076003)(41300700001)(86362001)(478600001)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:20:28.2412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e8a0fd-8f70-4323-c2fe-08db89566090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
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
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 85ee74fdb7e3..896e2f895884 100644
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

