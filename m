Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE45C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 03:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9290561168
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 03:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9290561168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008746E8DD;
	Thu, 11 Nov 2021 03:21:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F796E8DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 03:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMzusqDhTJgy9smRmMPwUCSXTvHsYdNl9Q2j/M9W/FKwOL+HgMf41/RNuPyZzeEvvRVumcsnt86WQrKZb5knhCPF646duZkbM5KscY/KoNFUdQLF50ljBXXzXQSFAFvwurFz8BB4At3Y1nhq3WLVAa6+GKbdUh0nnhjmFoLunzkwTB+r98KnHj+xvaGQbrsKZRE6NGTm6s7fUYFQDCoSNHcZM0GwUAhjTmTPdsjrPkBOPdkbB9Nn2jE/ug8T9XI3U/XZNbzVahe+MAfAEUjvgWh9dMOn7wQHTsO3JFuxVHZ6q4QFM0DdfQMBsYJs1DzuMDOlKoAjJXr1DAUXU9Lu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9COVzkEo1MWTmtFpCZdU7TOw0lxD4DOn2Htx8qZYjaI=;
 b=F3svNF+bKsy/7b4psD9dYay+8KkOJY4n+v3wu//LJU3uJmQs4fgw9/rwQGCd0E0R4njuKsg8jMUV+MfhW81TmTlGSxaOuJbZh7qv8eVx4OFcmkMRb3ym73X7crrrG7xRym1JxJNG+yhB1ZWD+D+rja1YWVbc4Fdlod5qm0cFdEM+FcUd5sEFHEgSRPBklYgMx8nQZ+fjXQPz2hPQzoqP+X4mmsFBBV9bwHSRw1Do15yJS0WxHQbVXayTKUMFGtD6wsu99HSFdSGkeJK2RKtPpDZXlun/MGU7MIk7S92ze5J9LzFEI+ESoe6FY/5M2QE1YR15ss/EcNMGL7gIQsOQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9COVzkEo1MWTmtFpCZdU7TOw0lxD4DOn2Htx8qZYjaI=;
 b=Bk+SqoIxAYYmhXYyfmPePIPDN+Es4UlUF6ll55UWVyk0cL8V1XefF/4CBKExuQLLzUmkLLM+dr4Lnv9wsvC1TbcOZOHnd9vOlHDvks5rm8nIrMtpgwGtuHFU78QTBSZdVk/zbY8bxUsavZOtB5EmeZH5uuHSB+NtY6PLv5Kn0MA=
Received: from BN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:ee::35)
 by DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 03:21:33 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::1f) by BN0PR04CA0030.outlook.office365.com
 (2603:10b6:408:ee::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Thu, 11 Nov 2021 03:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 03:21:33 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 10 Nov 2021 21:21:31 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: add error print when failing to add IP block
Date: Thu, 11 Nov 2021 11:21:08 +0800
Message-ID: <20211111032108.20859-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f622dcb7-7664-4f4c-b348-08d9a4c25cbd
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0266:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02661A4AA28F20382AED96E5F1949@DM5PR1201MB0266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKKmcujlzzCCMsMp6CfVOjOQb7oEcf9V6ZYt79dQ6HTKUuwBwxzx5eZj36BRY76RTPDpm9rJIPCdHqqoWl9riO5BDXq90XYEotuidTbtzc3wOB1vUQdLI3OF04Rp61VMyIJ9Eh6ohlVngy8qf23CKX/rJxuSypf2SFxKulDF4oI1tPKGaj0rjBlksJKuNvtCHmg/SZhWbEQ0Dr5NIZZLgcmlXVrgw5JLf42hPdjIS6spYNkmbNGvE6zuzTpLac4UXyGWXCUNRIHFCqW6eLxFg3uTWoEFnUzsmuHIZr7H2RMGrgABmZYmUY+DrErGGItcaU3RcxqTGOO1Zu05pjTqG6fFQykJTYISOElJu9+DLuJvQiBb1Wcb1FeT8a9EICmshtTiBinAzMoX0VVs+aqnxyQTprX83NiBQKiE/TZRVQRtWjhon3wxELKHegq1AmVwyxPgI8E8qabR/L4fB98vIfDFZTFif0PYa+2sXDqMnr1ikYrQLUXZPjLBNdjvgKXf+R40/7P8PoKd9OId1Q3GtJAJDdjbRrwm52wWB+bQcohrQ2CuDKBMmO19j0CLD4A/PZ2Vjbx161ec1C7w58z/nQfquMtLOjMN2wFwO381djtP5UN61uzSSpLenfSwi5H6HBIhIIVf/gn75zKKYWd/dWPh/6Jw7fLkrKDCjIbSXMA0jhkKeh5ZVZKrTCqVn6EHnEY/9+IHYWFVwIDwTMRs5Ygps0bXoGYsn+Fn5SyJEzjDhkO5M6yo0nniNNXnFPzk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(6636002)(2616005)(8676002)(426003)(16526019)(47076005)(83380400001)(1076003)(70206006)(4326008)(110136005)(508600001)(36860700001)(8936002)(356005)(70586007)(5660300002)(186003)(316002)(6666004)(86362001)(82310400003)(44832011)(26005)(81166007)(36756003)(2906002)(7696005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 03:21:33.5443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f622dcb7-7664-4f4c-b348-08d9a4c25cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver initialization is driven by IP version from IP
discovery table. So add error print when failing to add
ip block during driver initialization, this will be more
friendly to user to know which IP version is not correct.

[   40.467361] [drm] host supports REQ_INIT_DATA handshake
[   40.474076] [drm] add ip block number 0 <nv_common>
[   40.474090] [drm] add ip block number 1 <gmc_v10_0>
[   40.474101] [drm] add ip block number 2 <psp>
[   40.474103] [drm] add ip block number 3 <navi10_ih>
[   40.474114] [drm] add ip block number 4 <smu>
[   40.474119] [drm] add ip block number 5 <amdgpu_vkms>
[   40.474134] [drm] add ip block number 6 <gfx_v10_0>
[   40.474143] [drm] add ip block number 7 <sdma_v5_2>
[   40.474147] amdgpu 0000:00:08.0: amdgpu: Fatal error during GPU init
[   40.474545] amdgpu 0000:00:08.0: amdgpu: amdgpu: finishing device.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ff70bc233489..b68e5237fd16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -587,6 +587,8 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		break;
 	default:
+		DRM_ERROR("Failed to add common ip block(GC_HWIP:0x%x)\n",
+			adev->ip_versions[GC_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -619,6 +621,8 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	default:
+		DRM_ERROR("Failed to add gmc ip block(GC_HWIP:0x%x)\n",
+			adev->ip_versions[GC_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -648,6 +652,8 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
 	default:
+		DRM_ERROR("Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
+			adev->ip_versions[OSSSYS_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -688,6 +694,8 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	default:
+		DRM_ERROR("Failed to add psp ip block(MP0_HWIP:0x%x)\n",
+			adev->ip_versions[MP0_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -726,6 +734,8 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	default:
+		DRM_ERROR("Failed to add smu ip block(MP1_HWIP:0x%x)\n",
+			adev->ip_versions[MP1_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -753,6 +763,8 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
+			DRM_ERROR("Failed to add dm ip block(DCE_HWIP:0x%x)\n",
+				adev->ip_versions[DCE_HWIP][0]);
 			return -EINVAL;
 		}
 	} else if (adev->ip_versions[DCI_HWIP][0]) {
@@ -763,6 +775,8 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
+			DRM_ERROR("Failed to add dm ip block(DCI_HWIP:0x%x)\n",
+				adev->ip_versions[DCI_HWIP][0]);
 			return -EINVAL;
 		}
 #endif
@@ -796,6 +810,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	default:
+		DRM_ERROR("Failed to add gfx ip block(GC_HWIP:0x%x)\n",
+			adev->ip_versions[GC_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -829,6 +845,8 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	default:
+		DRM_ERROR("Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
+			adev->ip_versions[SDMA0_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -845,6 +863,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
 			break;
 		default:
+			DRM_ERROR("Failed to add uvd v7 ip block(UVD_HWIP:0x%x)\n",
+				adev->ip_versions[UVD_HWIP][0]);
 			return -EINVAL;
 		}
 		switch (adev->ip_versions[VCE_HWIP][0]) {
@@ -855,6 +875,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
 			break;
 		default:
+			DRM_ERROR("Failed to add VCE v4 ip block(VCE_HWIP:0x%x)\n",
+				adev->ip_versions[VCE_HWIP][0]);
 			return -EINVAL;
 		}
 	} else {
@@ -893,6 +915,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			break;
 		default:
+			DRM_ERROR("Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
+				adev->ip_versions[UVD_HWIP][0]);
 			return -EINVAL;
 		}
 	}
-- 
2.17.1

