Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B84C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CCD10EDDF;
	Fri, 18 Feb 2022 22:26:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C0810EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDG7aQeF9NDfhfYUj73dZY5ug+hBisgKSRNUDDmG8hNx/9wde8GMREqe15HwM9a1HWeYbd6oguWW9j18PSuOaSVFUbhrjDMqrQ2VFbFHZq7nTHiXRjeEWAmj2PcIrSWzt96dmrnwTl83XI0QJj1/2Gmc4gkR6TkiPtiFPrwdCgHeyG01fhroYr9Mnwb8Dr5dpw3GaieWpjY6IdxMnaSoZjAVOm5MHg+nw5Nk3qmyxf54h6ZV34jXUfnqCOkQhHXO2SA1Gw8w9CDRGOC1uuoPvRADObMJDbBK0E8fUTmXqYJGbCPA7+ro3ey9bYoM5uswxHciqLvPKRNq+QBo3987DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJw2TQo2e8nvdmdo4hcP+3HYJbEOPaeGXlNfW6Gs0Eo=;
 b=mhHdjeJonEMoMEeTBuCD3txDxprCAFWTzJn0N0L3PO1Hbcpp671JmFJBBfXeSxf2y0kYuUuuE5zIHbmwyT52J0vqiRh7VXOMH8CPBgZ+1EnznFXTHoLraqcSup7QTbitFZVr3Rdc3OZCQd0KIMZSuK54xVeUhg+b/TrieruwrjpZllJwHlHJvBKFMPAxEIdtoOZKBXpWJCvoPhDo1DHPrfcpvxPoS2Pm9wN6Ls8Dq+IMQGPmPhwSVKNwbaljGi6ZTIjCgu15poi/TKw6yTIGzJoYdvUQt8aWLGNBfJcMA8Nj6ESpQWV9OtSNaiQIF6KZpiSiD1CjurprQYnfgr2XUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJw2TQo2e8nvdmdo4hcP+3HYJbEOPaeGXlNfW6Gs0Eo=;
 b=SlihRHCZ9sEVFbbFaYWdQok9HvzBKTHYKESzoDkfkLmYvmJmVCTwSTOMoJ9KFSzoF/2Yvj8fkkSYQFCkZwp34xW1vsE6IQBCY4WmIWicr4QmPyjd8AWQTN1JWc7hVvKiS/y3zD1LX993FPkBExi9j+2HiwpKSJAFkxEwM0zIdg4=
Received: from MW4PR03CA0254.namprd03.prod.outlook.com (2603:10b6:303:b4::19)
 by MN2PR12MB3104.namprd12.prod.outlook.com (2603:10b6:208:cc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 22:26:19 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::43) by MW4PR03CA0254.outlook.office365.com
 (2603:10b6:303:b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Fri, 18 Feb 2022 22:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:26:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:26:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: add a benchmark mutex
Date: Fri, 18 Feb 2022 17:26:00 -0500
Message-ID: <20220218222603.25470-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218222603.25470-1-alexander.deucher@amd.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9ed84a2-fce2-4721-f8d9-08d9f32daf4e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3104:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31042B2803829EB9B3D98511F7379@MN2PR12MB3104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhBz0e2w5sWYo95V6ee+PdWxEt57r3+aHUI6J+KDiumffkN0Iht8VgaUJ5DKAXXFOnuak6qNTRlck0O0tjaHCHChD0ykhlSF8k9rUqDp8h++tqoBmPeRM1qPm8/rc8Ay4BJnbTPvd8cEa0ZO8RdvRu6Lzn/Sq7d4rGljZ3Ygbmjyn081SJM8KS/QftsOqsM2cz1elhzcgxJGxjfYmGdyVZJwLzLxne6+MkOWpIDrHiAY0wpSzMSw/HbXFYLMFReEI/jlsJ7EEnYzk+qy7jWnwgM2NgIlpN7UlTL5WzdMNLX9YPtpMac8BGW4HxsRfjVXXAZ2Y/RniMxyXZkMmTiBG2+pPauYQRmyqwOWfSNrRPCL3gMaO8desj+HKCLiplIMhaEt8xtwbBWCihcACkJmg4cCPAs//Dy8b8h8osQUZQJI6EWa+SfDc9al0IpKXchyM2JL3Qvq9m8x/fsJRJymOg/tlu39rqH0grIQwHV6wQ3vB1zi/DZnpNLkoJloU+L03ggWbXROSRNhL/8HOPxkPDV8gUgIniTBYAZoVPkMYj0L6MHjs9Cf08CkhW8T1ep+TYNFTINbmWlFbMJGHaFD3rdGjNWB38WYvphD183b4lAYqgLRQR7mUcAZshPgrQ5lwHTZXl/EtggEcaAd2Qu41Z+G7fwONBA+hW9xWmI92Wj2ScHWWGDm5RBaHRMwrGA8DrSaF4yPlwhHPDBKYwoW/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(316002)(86362001)(6916009)(26005)(426003)(186003)(83380400001)(36860700001)(508600001)(82310400004)(7696005)(6666004)(16526019)(336012)(2906002)(5660300002)(70206006)(2616005)(1076003)(70586007)(8676002)(4326008)(36756003)(40460700003)(8936002)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:26:18.8027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ed84a2-fce2-4721-f8d9-08d9f32daf4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3104
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

To avoid multiple runs in parallel to avoid mixing results.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 23 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 66d556fc17ef..c736c30e0a0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1100,6 +1100,8 @@ struct amdgpu_device {
 	struct list_head                ras_list;
 
 	struct ip_discovery_top         *ip_top;
+
+	struct mutex			benchmark_mutex;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 62422c395789..8e4997983124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -183,6 +183,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		1920 * 1200 * 4
 	};
 
+	mutex_lock(&adev->benchmark_mutex);
 	switch (test_number) {
 	case 1:
 		dev_info(adev->dev, "benchmark test: %d\n", test_number);
@@ -190,11 +191,11 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_GTT,
 					  AMDGPU_GEM_DOMAIN_VRAM);
 		if (r)
-			return r;
+			goto done;
 		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
 					  AMDGPU_GEM_DOMAIN_GTT);
 		if (r)
-			return r;
+			goto done;
 		break;
 	case 2:
 		dev_info(adev->dev, "benchmark test: %d\n", test_number);
@@ -202,7 +203,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
 				      AMDGPU_GEM_DOMAIN_VRAM);
 		if (r)
-			return r;
+			goto done;
 		break;
 	case 3:
 		dev_info(adev->dev, "benchmark test: %d\n", test_number);
@@ -212,7 +213,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 						  AMDGPU_GEM_DOMAIN_GTT,
 						  AMDGPU_GEM_DOMAIN_VRAM);
 			if (r)
-				return r;
+				goto done;
 		}
 		break;
 	case 4:
@@ -223,7 +224,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 						  AMDGPU_GEM_DOMAIN_VRAM,
 						  AMDGPU_GEM_DOMAIN_GTT);
 			if (r)
-				return r;
+				goto done;
 		}
 		break;
 	case 5:
@@ -234,7 +235,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 						  AMDGPU_GEM_DOMAIN_VRAM,
 						  AMDGPU_GEM_DOMAIN_VRAM);
 			if (r)
-				return r;
+				goto done;
 		}
 		break;
 	case 6:
@@ -245,7 +246,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 						  AMDGPU_GEM_DOMAIN_GTT,
 						  AMDGPU_GEM_DOMAIN_VRAM);
 			if (r)
-				return r;
+				goto done;
 		}
 		break;
 	case 7:
@@ -256,7 +257,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 						  AMDGPU_GEM_DOMAIN_VRAM,
 						  AMDGPU_GEM_DOMAIN_GTT);
 			if (r)
-				return r;
+				goto done;
 		}
 		break;
 	case 8:
@@ -267,7 +268,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 					      AMDGPU_GEM_DOMAIN_VRAM,
 					      AMDGPU_GEM_DOMAIN_VRAM);
 			if (r)
-				return r;
+				goto done;
 		}
 		break;
 
@@ -276,5 +277,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		r = -EINVAL;
 		break;
 	}
+
+done:
+	mutex_unlock(&adev->benchmark_mutex);
+
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 31834d2d4d55..63b4876e13c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3550,6 +3550,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
+	mutex_init(&adev->benchmark_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
-- 
2.35.1

