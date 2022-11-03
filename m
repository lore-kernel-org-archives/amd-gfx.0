Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B60C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 04:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85E510E220;
	Thu,  3 Nov 2022 04:06:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3168510E220
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 04:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nllvu7DJCtUkxWpQR/vYGsCx2t4EHUQKhGaimvHl938511pMCzfYGs0Jwi/mviZP/Tbi8LvIWqsHG8H2qKebnoC12cOf6ETkysPJrhdXX/Zaezd3JHKUzGk0Mw4hfSTIb63YHN9LgPeNUTMl9R9I1TLPPaZ/wm9Xjw8fUcIytfw+azHD/pflwPxnr8MS1Ibe9PzvT2bmCGvWBCO5HP52BFkKnvMuNwdeFamyr8ASJf1oTWANVbgDgCQPG/qOCb/zLgOnQWVfYQDXtnScMm+KsVaprh3quHaLjhutPe0ahlTF94zBOd8k93Hfu7AFd93MtwSxhaJrFmIofS+yGKFWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9mVfe/W8w1fR1Y6hXSjdTb16CfSioSarTGPXg3cXto=;
 b=Yv8YVSQTGz4b7JEPfjgJlS+X1bvSTtPOIbZksDaZUT8MgnTE6+9jUC6Xv5eyn0UP0b0Oul1m0fVmuwV2hv3asdiUj6rfec6z8EjJdBzSocvRlA4OUv8f+FBsRl01Wjdjkxln0ZUlnE09jZtSs9RSpJhn0/7emEJiNr/twsCTiu3oNIiN5lSjssRfC+deHohyKjf8BwsRO+dC3avSS/CmP/9G2NQ6CQV09DtzhIdvCfOO6mbzKK+lAn+v/0HCtLwmZdgaBkEOwJQ/ptki3j8IGJZfS5wdsCa41ihk4U35/TkNUVXNwRZ8IxxTWxYqShSw/7KM++vzNxCWz2QzQr60NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9mVfe/W8w1fR1Y6hXSjdTb16CfSioSarTGPXg3cXto=;
 b=urklBHF/kFDMgC+bRslU4He+dT0uDl2L+SkNIuKm6Dx5NDZqnsNL8lvqqrbF2Mz0B0SJ05N9NHbCZT2xhhXmR3tIY6i26Cdx8wd5rI/QwaxIaOgQ0+IebwuMcTwJ9cFDHQjcq7Dfa0sGeM6FSRbrdXUmssFqfYTfKu4RSQw/sAw=
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 04:06:16 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::bd) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.21 via Frontend
 Transport; Thu, 3 Nov 2022 04:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 04:06:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 23:06:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 23:06:09 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 23:06:08 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov
Date: Thu, 3 Nov 2022 12:06:05 +0800
Message-ID: <20221103040605.796752-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a96baca-18c6-4d88-ee5c-08dabd50c098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xG6arW9w6+1cKhMLrpCxh2azvcfsp2qp6MgyAKknmzdbCQ9nCWLkl0dPEw8ukkXmg1yzPv3MTs2qoYtnTlp+6gqI/21kBoeWK63FyPVTsfi7Pogvg+Y9Aq95XRidzkpl6dJKUknF6OF/gnl+x38j1hcWVYVcCT8ydaba1ny7zKiJq+l/NydV18TGwnlTmvWcvw8xeB2hOd/+rSWvGBQtxY3kAsPmju4BuMEfxSnPqDf9bNX6mZvZzaH+Mbdvg2/BCq1TcBo6GKFYFfPVTOQui9F6kMulQDZGgsgk5+9+jLHw7UsqfdwRENi17Dq0S+r3jzhC1zLUugyOHyTmznO0Rh0zS0Y+UVxi08CJajFEZX5CSJtthlbFcZ0v3j4RtpX1i+F9/ft9jC46YgQjljtYE2Aanu14lJv4UYeVEE6OOw6lh/ks+BivpUanmRDHjZt+l8x9SJ7Re9Zd1Le7O9cm4N+Cr8NhefX3z4vksWXj85O2LGJtrLe5X1mhZ9ufX9n1HVbBFM+fQe+Aq2etkTm/tho3X4gdtsfE5MUoKof32ayFa3RNos1AqIck/0VYk9mPyIR/U9jtBVaL4WVJ6vAMhKJNZ8hO20jkA7D5X8RMBfdMS/8Hpoh3Iyh7njUc1NCY+TG4oyZwvFMMU1Rr6hTs8mq0oUH+eVkD5PU7rJLMRD0h7PTLG0hmW1qfEG3yfKUCrX0o4g+dTrd+MdrrurBJG+ADG50czWT9e3OzX4O5QDbx/TLdhSF6zNBgOoldosVcoUPdiCKn8ofo7/DfzmuWf1kt1L+4kuh2WXTSznPd8vCro8VEzE1iULfP8QRIoVye
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(82310400005)(2906002)(336012)(1076003)(15650500001)(186003)(5660300002)(2616005)(8676002)(6666004)(110136005)(316002)(7696005)(36756003)(40460700003)(4326008)(6636002)(83380400001)(26005)(41300700001)(40480700001)(70586007)(70206006)(8936002)(47076005)(86362001)(82740400003)(426003)(36860700001)(81166007)(356005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 04:06:15.1065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a96baca-18c6-4d88-ee5c-08dabd50c098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- clear kiq ring after suspend/resume under sriov to aviod kiq ring
test failure
- update irq after resume to fix kiq interrput loss

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 522820eeaa59..5b9f992e4607 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4197,6 +4197,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 
 	/* Make sure IB tests flushed */
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_irq_gpu_reset_resume_helper(adev);
 	flush_delayed_work(&adev->delayed_init_work);
 
 	if (adev->in_s0ix) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7853d3ca58cf..49d34c7bbf20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6909,6 +6909,8 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 	} else {
 		memset((void *)mqd, 0, sizeof(*mqd));
+		if (amdgpu_sriov_vf(adev) && adev->in_suspend)
+			amdgpu_ring_clear_ring(ring);
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 		amdgpu_ring_init_mqd(ring);
-- 
2.25.1

