Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01325C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 04:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A791160FC1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 04:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A791160FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248B26E949;
	Thu, 11 Nov 2021 04:11:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CE66E949
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 04:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYL6N4Zu8zbV9ftQQo1grcHkmji2kFzUHtvVK/4OO2+kvltzVlsdaMQ9JRoE9ZtwsDa7+8UwgN5qZASt8rxlc/nPod1NobPmsnSAeXBvl90dc3eBHh7hJCSUnGxhUisweMhW4n24YikfL3NPLRjNwOHPA03sC/ci9uHRO2lvQo4xIq1bEFXppYHlf/NhpLaf8mA0vgp/GDaOZvzSDqKTOd72oNDS9zL2+aR2TMqEdbIcTBAXqYoLlhlsOV8XL1dQF41Okbso/PC8S8ZmdPW2CONvLcXjqtgOgDrLnylzUR1vRa70oRcfGcjS+DOVP8XlJU2ACS3FZ6mwetWvSvBd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP6v93F76g08YRuKkBbxw6Bqbl99gzukC3cM8xvN1Xc=;
 b=lxiD2trkjX57tVOZ/0FtrWtv+m6kRNwvJ5Z503hQBxvVIiB6gZnjtJ6KY6UrSJB9DWke+wIWK6kSFuO8nGFd/yG8uKuFBHs3CSScbg0NL5pAT0J1Ty+sAUKIryteh/8aku3P3OJzGUgbQvzJ64n/f7g6Y/wrDb2EnTaPfejnLclv8JkVSPuu4OBdqltYfZxSjkfC+FRAlqRClx3xwQZKniD/mm1E0QnHy46kjCsCK/Hn5v42cIw1VpdaeX03WdZfs6PZzL+UgBwkpw9ocy+dYUM1GHiimRicOzzkjgOUDqW93j+yzFBDyK9lXUK0gOjq1C9YfKcRju7bXuirb7cR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP6v93F76g08YRuKkBbxw6Bqbl99gzukC3cM8xvN1Xc=;
 b=RZb27iA0ALi5pcLbcZVQOcAol7iMpslTn8lZQ+TJk+NPSQ8KkoaA/QduiSl4b/lkW46WTV8iYjegiR0I2l4rlXleAdPDfFHNw0O+uo1/2EB638NHtQaiCKP7nAo98sB10mfrdL2TdHXiX6/OMoWUY7J7rgEbYdG6H3U852+3CdA=
Received: from DM5PR06CA0046.namprd06.prod.outlook.com (2603:10b6:3:5d::32) by
 CH2PR12MB3846.namprd12.prod.outlook.com (2603:10b6:610:24::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Thu, 11 Nov 2021 04:11:44 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::1b) by DM5PR06CA0046.outlook.office365.com
 (2603:10b6:3:5d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Thu, 11 Nov 2021 04:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 04:11:43 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 10 Nov 2021 22:11:41 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: add error print when failing to add IP block(v2)
Date: Thu, 11 Nov 2021 12:11:28 +0800
Message-ID: <20211111041128.8043-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f307d3-1050-43f3-7ea4-08d9a4c95eef
X-MS-TrafficTypeDiagnostic: CH2PR12MB3846:
X-Microsoft-Antispam-PRVS: <CH2PR12MB384691211FB5CE1272150B78F1949@CH2PR12MB3846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDlkwXuMalqOEHXLZGJN4AgijRQDfgue5wUllajqvGgJYqGi6yIiSRyiz/2ilzgf5/FV8CxZKGOOo76Lq3NfY87nY/JonFs+hZJG0Cl9d+6lYm5tXqmvEQZEFcX5FN97mSQXrEnuF+GYSqxFZC/nGAvhrGu8moRqW6je3tyc7rGC6WAdf7kHDIeaSgHbFQh2I981l1Hl3CvPYELKZRrOXX45OuvM0dug/IhfnfL7cIeJsy927EAofv+TkNnGhiuhZkLjjnnHMEDFeV7BvzGgJoUmdf7HknQBFWYUwroFCITt6zj9KuV2OXfNe1hMPEr8PxLWENsbzIc9rBL7SkaDLoZhxY3SFGroMD7z9FCAcEvkLyBYg45Xp2KjOV/nBOaljm6n3OQGwa5QyerqgI7q7Q/L03e5M2hK0TJL5xWU39fH50QT5+0svXvi3zoBZ5Q5QvowRaPluzKozz1idrJcPXM4H54IKIs2o3RIeJhq6LtWuqxphI4o0mHnLLE8ZoxtFXVemJwZQ5GXLhTxH2qEN+UuAUbc2Qjsk8/AyTxg8wYMzJtat2avcgnaVJAKs3hyVRH1T0dtXUqR5zuv++pM48l3NGZ7IHgAQMLT4yqbf2OfL9ocgx3C4GjW2koXEaNz5mnLNT8XTIX0vdcgSTp/VHR9h/MReiP/885qjJh0oVet/XrboZUkMbW4FhGA8H057h+9PYY3jq9rrZhOk1FTtjMnEsw6ZtDz9iwTrtxyUo/LlCg90FRnBKXnsZucTUTJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(6666004)(8936002)(356005)(508600001)(5660300002)(70586007)(8676002)(6636002)(4326008)(336012)(110136005)(47076005)(70206006)(316002)(26005)(2906002)(44832011)(83380400001)(186003)(81166007)(36756003)(1076003)(86362001)(82310400003)(16526019)(36860700001)(7696005)(426003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 04:11:43.6612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f307d3-1050-43f3-7ea4-08d9a4c95eef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3846
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

v2: use dev_err to multi-GPU system

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ff70bc233489..4e3669407518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -587,6 +587,9 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		break;
 	default:
+		dev_err(adev->dev,
+			"Failed to add common ip block(GC_HWIP:0x%x)\n",
+			adev->ip_versions[GC_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -619,6 +622,9 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	default:
+		dev_err(adev->dev,
+			"Failed to add gmc ip block(GC_HWIP:0x%x)\n",
+			adev->ip_versions[GC_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -648,6 +654,9 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
 	default:
+		dev_err(adev->dev,
+			"Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
+			adev->ip_versions[OSSSYS_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -688,6 +697,9 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	default:
+		dev_err(adev->dev,
+			"Failed to add psp ip block(MP0_HWIP:0x%x)\n",
+			adev->ip_versions[MP0_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -726,6 +738,9 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	default:
+		dev_err(adev->dev,
+			"Failed to add smu ip block(MP1_HWIP:0x%x)\n",
+			adev->ip_versions[MP1_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -753,6 +768,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
+			dev_err(adev->dev,
+				"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
+				adev->ip_versions[DCE_HWIP][0]);
 			return -EINVAL;
 		}
 	} else if (adev->ip_versions[DCI_HWIP][0]) {
@@ -763,6 +781,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
+			dev_err(adev->dev,
+				"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
+				adev->ip_versions[DCI_HWIP][0]);
 			return -EINVAL;
 		}
 #endif
@@ -796,6 +817,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	default:
+		dev_err(adev->dev,
+			"Failed to add gfx ip block(GC_HWIP:0x%x)\n",
+			adev->ip_versions[GC_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -829,6 +853,9 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	default:
+		dev_err(adev->dev,
+			"Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
+			adev->ip_versions[SDMA0_HWIP][0]);
 		return -EINVAL;
 	}
 	return 0;
@@ -845,6 +872,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
 			break;
 		default:
+			dev_err(adev->dev,
+				"Failed to add uvd v7 ip block(UVD_HWIP:0x%x)\n",
+				adev->ip_versions[UVD_HWIP][0]);
 			return -EINVAL;
 		}
 		switch (adev->ip_versions[VCE_HWIP][0]) {
@@ -855,6 +885,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
 			break;
 		default:
+			dev_err(adev->dev,
+				"Failed to add VCE v4 ip block(VCE_HWIP:0x%x)\n",
+				adev->ip_versions[VCE_HWIP][0]);
 			return -EINVAL;
 		}
 	} else {
@@ -893,6 +926,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			break;
 		default:
+			dev_err(adev->dev,
+				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
+				adev->ip_versions[UVD_HWIP][0]);
 			return -EINVAL;
 		}
 	}
-- 
2.17.1

