Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FA4C47DD9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 02:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E991122AB;
	Thu, 28 Mar 2024 02:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GhqccBKq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDA71122AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 02:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7kXzWEGDTObaruaTXDSBcjXTq+ISFpsKPS/WwRBj5me9XarhUzZ9kLwi0fcawbCvPBrB7RhL5wjA5TWJ1vPOCToiEwe6EP/wPdz6q/1TG9P3GCOIhoaT2YEncCKEM/6ZIDkUA2q50+tdc1UU9K633tRahXcJcGQYYf9EZmrJpuPWvOmKmUnKtdf3JrGZcwQOfhH4koU0ZVR0SLmMPzNGd26K42zmVnGSKxzbJyTBB9DsZA4PF6BqaDuzCK7wCVaAy7g4ck+7OQoypOmOYDLlvuw3+T7XobdLEJvIOmJW1T1avyQTdmTb1gq7TJUTaPbVD/vkIjoFkrimoXScHnhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsMLo+gomWza/oeT9CoSWVF+zQ3qaSAY4rF3tZGwzdQ=;
 b=QtVtQ8DEKMeNx8jz28XzmNStMZrSVENeDDEGAMQ65TAxwFTEPQenJ/uSKnVLU7QgRXjX3sDg39yriuh+hpaYUf5mngO+EIXypBNCw026AUHjxv+SUVVilKfSBRd2RL2vvzN5rVrsk/Tq4MApA6Z1HnGf1RZ9KXMGU5gwDVQNgzFrywq+hYQM2VyGA5qe3T89zgkyq2ovqyNNa1BTkOrUq6S9HmALbH6YepI1JlGFYSwfk+CxYeOReE4prpseu0pvjpT9LI6iMvxcMtG9dvKjYLSMIcq3dv4OB8cYZk+k7T0A2RItfJkEVjWKMQbNRjYdzsUvfYYjtdJQI91JGefupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsMLo+gomWza/oeT9CoSWVF+zQ3qaSAY4rF3tZGwzdQ=;
 b=GhqccBKq+BgRdyoqXEDNbRjqVArYKf7/mYcJtdsnUCqu7S4UzBm9QWgPw/cKwuOArTxCHTgHGoE1dpFeGPBtkzaJJh5MfJ32UIdGc9nQ9dJwVCmVchHNFmowUDtewsypbexbxaYoQm+jSjSUaG7H1RtBDpVLQxEYG4jLhi9L7y0=
Received: from CH0PR03CA0425.namprd03.prod.outlook.com (2603:10b6:610:10e::27)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 02:06:20 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::93) by CH0PR03CA0425.outlook.office365.com
 (2603:10b6:610:10e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 28 Mar 2024 02:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 02:06:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 21:06:17 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, James Zhu
 <James.Zhu@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Fix VCN allocation in CPX partition
Date: Thu, 28 Mar 2024 07:35:59 +0530
Message-ID: <20240328020559.812603-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e0620b-594e-4b9b-f26d-08dc4ecba8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kvT6nql7nR2s5b8rCKz+IEqBNLe20Vu4F78ysgBSAxTNoHUgzAWGgAs9+uVRyjnTnQlt7fu/A6u8mWZxxyLR3JO5IvHmnDXUccKuVRodra+L6/Yf/GQIxBmiruYYhyD36aOIV1p5Aors0HBL6dQU4LN9UvTKGhFxIZ7i0/x0rELjo14pYdcJI++8sFb9Znn2aoiHnw7e+gEgp8/WNP3yLlkR9tAMflxjval1oN8AOFFodRENdPPOBgHo9oQqvCIMfQL5Ox3sSmyeNSPQMMp3UIf3ZzPnB6ut4Hw/nMHZaEBvAlvNS+YKpbZ2hZxuKsNmAAHcXALmu9lMapI3lxSDzvhIaALtJDrCMdpyuCUOoSTt7R+3Fk2OQzuw1/thjzsubk5ZGX5AYCwS7nswAlyONEQpwqT+BDAQXo7pTyfj0s5ZVWfHJg2MYZKQWA5xdEed809iwQ5EhX+xvsPBG3VPAu3ANMqrhIU8PWDZl11EAri7z9KJW6lciv3/LhrVhtVa1ADaWP7ILpdki3J1w62N76t4WjgQJNgPQWhY2WViYFRfSjpjLtU+MBoh1itstIBssN1HJnSIQuvbQ7a/VvEpz+mWubo0bBa81qhvM49S5NT/cq+6CiZ3XmyQz4xA4BejMiMJMAytb83ej/9gH4XGtIVbCagx6fhwBBSphCW5+Gy53uQlwXyyWXzZH+5agy8QDKNqaYDXwNh+Y/TgMPD4ap0HQKsM1SHH/IJZ+yuTuBlSi/7yLa7dnD6i8rKJFS3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 02:06:19.9423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e0620b-594e-4b9b-f26d-08dc4ecba8f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN need not be shared in CPX mode always for all GFX 9.4.3 SOC SKUs. In
certain configs, VCN instance can be exclusively allocated to a
partition even under CPX mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index d6f808acfb17..fbb43ae7624f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -62,6 +62,11 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.max_assignment = AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT << 1;
 }
 
+static bool aqua_vanjaram_xcp_vcn_shared(struct amdgpu_device *adev)
+{
+	return (adev->xcp_mgr->num_xcps > adev->vcn.num_vcn_inst);
+}
+
 static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 			     uint32_t inst_idx, struct amdgpu_ring *ring)
 {
@@ -87,7 +92,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	case AMDGPU_RING_TYPE_VCN_ENC:
 	case AMDGPU_RING_TYPE_VCN_JPEG:
 		ip_blk = AMDGPU_XCP_VCN;
-		if (adev->xcp_mgr->mode == AMDGPU_CPX_PARTITION_MODE)
+		if (aqua_vanjaram_xcp_vcn_shared(adev))
 			inst_mask = 1 << (inst_idx * 2);
 		break;
 	default:
@@ -140,10 +145,12 @@ static int aqua_vanjaram_xcp_sched_list_update(
 
 		aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
 
-		/* VCN is shared by two partitions under CPX MODE */
+		/* VCN may be shared by two partitions under CPX MODE in certain
+		 * configs.
+		 */
 		if ((ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC ||
-			ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG) &&
-			adev->xcp_mgr->mode == AMDGPU_CPX_PARTITION_MODE)
+		     ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG) &&
+		    aqua_vanjaram_xcp_vcn_shared(adev))
 			aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id + 1);
 	}
 
-- 
2.25.1

