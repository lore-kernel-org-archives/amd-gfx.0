Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD62C7EE26
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF15B10E3F3;
	Tue,  9 May 2023 22:08:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD1010E3E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E18rOKPpchDsk0wNS24MuzPsfv1eCzh6/3cQWbI2JFJetGS3fiu+TG1Y+Ik7tjN4FdKGN//MUuDWorT120l90G3NHGoQ3ulQ/maQqzfE5i5L6Pbo1cX7DYf8rBHV8sr05zExNlYKp2yspgvbeT7P90xamjilHtoAXNeisZ/RCh+X8yrxR9NTXJZ+YgNKJhFaB4b+T/hWGhwrFX70cHKwGDtC6GR7U7gUZcg7XT/FxFMFSy8EwhmfmchVKpUVD3mz0MgNZsHQKmEtfpMW0x/+on2h75B1WwZPKyU375ETH07IbwFHoDJapoNCdJsqa37EnZK6YOw9go4I7uAj/hGQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BedtlWv/wmuMdk8w0bKn9rHj2ppQcllRDj3E84R9ANI=;
 b=S8J4OIt/UMGMwWQkj2+3OpQKPohUP7mPWYUpss/Ez3H66Zeg7e18gyLjqnPAJ99LiCYHbq171M+baQREpWMj/QcEQy8qizECLLnOuz84SW9UGmljENjuE3HITLwNfPmufRwcrolqC6zv4YbdkGUxQEPp+akXMrDxfGl27MQllBKP1ceLrofEVQ3FwdnMWwn/Msd/5zKmmb4NyKfGxhafnV9r+ZKUV5/29SCTy+eqCmoxcwKcOvNv3pexz9pzHDfa6G5OzXgMP984VbWPXanwVTISSeZBYf+34AZFeCNeQXozFkuX9Sp+IEzVFiMpbtTKev0FW84s1q49m/TAvRDSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BedtlWv/wmuMdk8w0bKn9rHj2ppQcllRDj3E84R9ANI=;
 b=N3mi2Ta821Bb/nyE+YdaFzCIqOM2B+ZpszjtKERngYa3P6dlGME1KfebmBlBUfKULlQ2twsnsikX4hpk9dYKqr0taqY3pvadraybygL2B7H9FSOZgKlObBFR+UcbRhD1TUgDMBD2um5eRGRcO/DLS2qFFW233c4rbAfenaLXm7Q=
Received: from BN8PR15CA0013.namprd15.prod.outlook.com (2603:10b6:408:c0::26)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:08:36 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::8) by BN8PR15CA0013.outlook.office365.com
 (2603:10b6:408:c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:08:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:08:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdkfd: Enable SVM on Native mode
Date: Tue, 9 May 2023 18:08:18 -0400
Message-ID: <20230509220818.475582-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220818.475582-1-alexander.deucher@amd.com>
References: <20230509220818.475582-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc17b32-a87f-4db6-a815-08db50d9efd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krdbCz44p2iKq6Vl02i2yNAHXzP6joCzGH7TpsYbaDc+3tV4vV3F8SzGYWQio9nSsw7T/AwY5jpESSKg4fev13zVq/tY/w9r8fH7lmLD3R77iY9aZIB7EqGy7gXB6Mu/7FTX830Yhk2DMIiu9T18YLDoX1MLpCiqLOUWVl2ifo/mfQH/V6bO22KPN54OT3652tQ4wjaISQjXqRBdTmBMky1g/Dp5tAZ00BIneRg4lLdCN1BZ14gRFouSBD7th4887E1udjwEMyJR5e2nLMbSHiA0jDUFtzqMio6hU5H+UZRdPHEdE2cowC3Fak8U/EZ02tJqhQdh58wgh27sYylmv+5Jp9GoTF4WtB8DhzLGtdnjrRfrFzQFqKQGa/oyS2TBb0eEGKO1OCVYmh+Gl4HG4T6O6KM+nQfWYaeIftUtZSN1l3pGNDcnDamzPG6jH6iT9NvcdB8O69ZVNAYS68w311fnfCTSz5k+mw5Urz+G6/VTZky6s7G4wkPAobwL5aw9Hsy1g52nr3a0BNE1BCJGAOYnyHAHJVjuUmqCU6ouVQgrxDcNZj0Ff3HoMHntGGIDlxBcl2C3sEyuOvfiYhSFL4cqBRcq5ELV4/WMN6JzLp/RFybzRyVJrhK2MXVOBINaNqhan/EqbFddZNMUjhx4UDksBJYhUq2m/iJcZldgIQcorBaz4HgQsfr2o2Mbs+RXP1aZPwPq31lLWv9Y3yQQTFIJ6dlUzZXJ7zUdX0k1pFI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(2616005)(2906002)(186003)(36860700001)(336012)(86362001)(6916009)(4326008)(41300700001)(36756003)(16526019)(70206006)(70586007)(47076005)(1076003)(83380400001)(426003)(26005)(5660300002)(40460700003)(7696005)(82310400005)(6666004)(82740400003)(81166007)(54906003)(40480700001)(356005)(316002)(8936002)(8676002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:08:36.4667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc17b32-a87f-4db6-a815-08db50d9efd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

This patch enables SVM capability on GFX9.4.3 when
run in Native mode. It also sets best_prefetch and
best_restore locations to CPU as there is no VRAM.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c87b12f1c957..8a1075eed5b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2542,6 +2542,9 @@ svm_range_best_restore_location(struct svm_range *prange,
 		return -1;
 	}
 
+	if (node->adev->gmc.is_app_apu)
+		return 0;
+
 	if (prange->preferred_loc == gpuid ||
 	    prange->preferred_loc == KFD_IOCTL_SVM_LOCATION_SYSMEM) {
 		return prange->preferred_loc;
@@ -3255,6 +3258,11 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		goto out;
 	}
 
+	if (bo_node->adev->gmc.is_app_apu) {
+		best_loc = 0;
+		goto out;
+	}
+
 	if (p->xnack_enabled)
 		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
 	else
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 5116786718b6..7515ddade3ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -200,7 +200,8 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
  */
-#define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
+#define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0 ||\
+				       (dev)->adev->gmc.is_app_apu)
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
-- 
2.40.1

