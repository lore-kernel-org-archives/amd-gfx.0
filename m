Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C04AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 10:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A749B10EEE9;
	Wed,  1 Jun 2022 10:01:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C2E10EEE9
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 10:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqpm1qyuAmvNExG9Rp7K+Y6RpakH3o8OfDEqekv6JeKq+5a3rKXML53xmoJOxh0/3sNoZqF9O+5luOXxK2sLlPZ9eoBGaDsWfuBafeuGHj5NAZ/C9Td5tU20A5po69VAA+WZRgjlCv8yVFjF8E8++ILc4zxPrW0dwxQdh8waSjg2fupO1FhMNqGV7Pl9S0cly2pQaHqCAk4DGgvgCY42m5+l1jlRliQYfydEhSvDVUb6uqRr5T8p7Ubw2Ty0pg4MmR6Z9WGLWYQNpitOFkQQ5fndukg7FoU83N4hlvX93VtsqsuUhIzSf0IWHXyLVQXB8cZF/HmNANNZVEO7ZcW+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3jvRA1/7HaPvgsFULcrL4LLVCc9OBn3WcpP7DDxJjA=;
 b=a3p9pggK2rhPiEraqW0Qw9XmJaOGPtYWSF/j5W8UL373UzY7oAsIDGbHcj0Xr9TtJ8fUMUg0l2c+e3rSCXYKQfzY7bbK6bJO0SWHEz8bIsNOgW8fV6ZnSsV5OAgPre0l0PiU76mqnELIpJOU8GzQneTu3r0RTtVJwaqjgc4xk4NU49R7WnubEokbTFboDK1NhQOBQxA1EZjnrFaEZptMYSgiGulTPZrM1FM24cwB3GT6YS5c7UcQLSqpSY8bAuSV8Q0LhKq5geExdlB1lhCEsC+FHQsa0t7UZIDGpkH4AZXGdGJxRP14kAc9ORfFzWNxRyFMcwL+k2O1HZGZfbRT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3jvRA1/7HaPvgsFULcrL4LLVCc9OBn3WcpP7DDxJjA=;
 b=x2SFHtszCXEYbJS/hyyrkaYp8bDkZTMrX40/JrG3ea4OnKsKk2cNTg+n1qXY1S1Lje0cpTChru46PZNuTTXwBMyD1h43YIYD/Mt6YrsJAzlVhXjlXzhAOKdDn9mlZXuwZ0wuKF6gkcdmiweS9qdf7ku9nfv26/qaF7u/WpewPQs=
Received: from BN9PR03CA0893.namprd03.prod.outlook.com (2603:10b6:408:13c::28)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 10:01:30 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::41) by BN9PR03CA0893.outlook.office365.com
 (2603:10b6:408:13c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 10:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 10:01:30 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 05:01:18 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Resolve RAS GFX error count issue after cold boot
 on Arcturus
Date: Wed, 1 Jun 2022 18:01:05 +0800
Message-ID: <20220601100105.9893-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe5868b8-d2ae-4c52-cde7-08da43b5b352
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35159889337F22BF6877761791DF9@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xU0c44alsl+vnIRG6YLs74T9AEqQ+iM/Oj6zcyT1LkQvtvfNy+HioJaAJo7kRJMcJwAEMOxeyDguwn5bc/fPNBtvQbwMMRC7ATk4K/PeFilzJFBbnCBx6MiGdYmuMz82leOczK2dDke+Zf4zh1yqqBW/H/E0BsGLLmQw/0KrUN8PaRGPQoLHHuZOLeaQbtWgIXb2HUwvaAQam8R1KfzW9o97Nx1JwXU3FsZITDC3TuK11Exw8zZ63tKELq1Cz719oWOadKf678Nt61dU8IRllgZgCgyESXmPOxlihICzz2Ub/A6d/wtzJ59UI9HgBpvGsYCXFiMvatanUsgVt/NmD6pqbAoBCOtpQVNXD78y0QXVtfkvLJID2vdJ2D7E/7KThbgsdpommwoPt4jdp5c2bF/VL+Xxp20PLXHdnSFtAUB0l7PmYEyCVVtxiyUDPRxd30Eyko9WAFb3gTgpQjR+KVby87qjVK5RhQrh/HyUFg8NJ2972BW3HlzKcLRpHig6S+t6slBWXNONQ3FrSIavSAcbX043fTFvsjTxgU2DqcNZ2oNx+0jb+8mmhoVZK4sCMLZuJMRkY5Z9mh1z+R9s+vJrrsVeHU6ZS1g0l7zQePQ/mXPDAPlYZ4b5ywuIB6NttWE7XC+zjdv/oApzfKeSGRZjH0IPERDZ1COI8sXpCtm02fLbPtDY3IbGkWgNTWX/iBY4WsIS/cIoHC6YHb7y2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(86362001)(4326008)(8676002)(356005)(5660300002)(16526019)(186003)(70206006)(7696005)(508600001)(44832011)(6666004)(426003)(336012)(83380400001)(47076005)(8936002)(36756003)(316002)(1076003)(6916009)(2906002)(2616005)(36860700001)(81166007)(26005)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 10:01:30.2411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5868b8-d2ae-4c52-cde7-08da43b5b352
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adjust the sequence for ras late init and separate ras reset error status
from query status.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 27 ++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ede2fa56f6c90d..99c1a2d3dae84d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -594,14 +594,15 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
 
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		if (!amdgpu_persistent_edc_harvesting_supported(adev))
 			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
 
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
 		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 		if (r)
 			goto late_fini;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 31207f7eec0291..9c5e05ef8beb0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -197,6 +197,13 @@ static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *buf,
 	if (amdgpu_ras_query_error_status(obj->adev, &info))
 		return -EINVAL;
 
+	/* Hardware counter will be reset automatically after the query on Vega20 and Arcturus */
+	if (obj->adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 2) &&
+	    obj->adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 4)) {
+		if (amdgpu_ras_reset_error_status(obj->adev, info.head.block))
+			dev_warn(obj->adev->dev, "Failed to reset error counter and error status");
+	}
+
 	s = snprintf(val, sizeof(val), "%s: %lu\n%s: %lu\n",
 			"ue", info.ue_count,
 			"ce", info.ce_count);
@@ -550,9 +557,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 	if (amdgpu_ras_query_error_status(obj->adev, &info))
 		return -EINVAL;
 
-	if (obj->adev->asic_type == CHIP_ALDEBARAN) {
+	if (obj->adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 2) &&
+	    obj->adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 4)) {
 		if (amdgpu_ras_reset_error_status(obj->adev, info.head.block))
-			DRM_WARN("Failed to reset error counter and error status");
+			dev_warn(obj->adev->dev, "Failed to reset error counter and error status");
 	}
 
 	return sysfs_emit(buf, "%s: %lu\n%s: %lu\n", "ue", info.ue_count,
@@ -1027,9 +1035,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 	}
 
-	if (!amdgpu_persistent_edc_harvesting_supported(adev))
-		amdgpu_ras_reset_error_status(adev, info->head.block);
-
 	return 0;
 }
 
@@ -1149,6 +1154,12 @@ int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		if (res)
 			return res;
 
+		if (adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 2) &&
+		    adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 4)) {
+			if (amdgpu_ras_reset_error_status(adev, info.head.block))
+				dev_warn(adev->dev, "Failed to reset error counter and error status");
+		}
+
 		ce += info.ce_count;
 		ue += info.ue_count;
 	}
@@ -1792,6 +1803,12 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 			continue;
 
 		amdgpu_ras_query_error_status(adev, &info);
+
+		if (adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 2) &&
+		    adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 4)) {
+			if (amdgpu_ras_reset_error_status(adev, info.head.block))
+				dev_warn(adev->dev, "Failed to reset error counter and error status");
+		}
 	}
 }
 
-- 
2.17.1

