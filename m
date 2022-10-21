Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57FFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 14:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51C810E3C4;
	Fri, 21 Oct 2022 14:47:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64A110E3C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 14:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQYkKUdonK5flRdvVGN9ZAoE2DYB1kx1YaUw03Ij7BD3iqrrmUH3syqFyI3/5WKvRfPL5f1J7OwLKQPPJTye9slkGTD4vBlX5FdkHalom8jUDDWIYgd2xqHdqyHuuLqTxQ/CGDgdtmc3zLUU+GL8XLvOBMLRdTwV4zOc68DHMC5Zg2hwmXCNbF5rHQJPtBCNkB93gYOIv7fN0J2C8r9HD2NmHQm0WEsWuyzZw+EfI3RK2V/M7l0JL38AH99O9ZhvCUfjs63q6sJL1PBr5YPJSmypl7evdm09mUc1Tvp+m11ON/78I5A6kiSIfjqkKXtZeFCCvEwc3dbuZMBpyeD2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkJmHOWnvHrPaSkx7g92npsF+bQRvAHTUMHB+MP6aa8=;
 b=X20MRYnimALGVec0L36nGn8iHDnqVKE4474Uz5niYvkoGsjJNC+OezUa8xNsU8vK33QRgrJjLrYqrTVvdskh85/WfvnA3vpTiZF6IF9tBsXEk8TI8MaA7xyDhnRLA9ZCndHUw/aQIvY+oevlTuRifGLMoWce1xsiLDCAG4rTr+MTU/j1s5T8KjJAzXRRRArgu83kW6v7swoXlU6LdMCROKbDfKZ3/0VowVBxxSWkfn9qJdYHWwTWStOXcFKy71zxIwKWGYKDp6zufXIaWv3zrJeSXLYSCFkN0eYOwEqt6dqgAGTKPjdgBti4Q2EjtBYVyCk6HXpVcccDqU+TfUEW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkJmHOWnvHrPaSkx7g92npsF+bQRvAHTUMHB+MP6aa8=;
 b=SzYduFVGNBOlnKzOhse+rOUN2zfCqStCqZ+oVvZb/9m59aj+0LNWhFx+gn28gyN7d45rNvfSsxG6eIE2ZTYPCI5csJhUwQTV6JpAZtkueda5nLaVMxU3X2NIFbfpFQrSSexCEKeYOV6lAN7gA5gKAifAzbnN+7Nn127qeGWYvF4=
Received: from CY5P221CA0080.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::28) by
 BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Fri, 21 Oct 2022 14:47:32 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::ec) by CY5P221CA0080.outlook.office365.com
 (2603:10b6:930:9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Fri, 21 Oct 2022 14:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 21 Oct 2022 14:47:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 09:47:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 07:47:30 -0700
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 21 Oct 2022 09:47:29 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks complete
 s2idle resume
Date: Fri, 21 Oct 2022 22:47:28 +0800
Message-ID: <20221021144728.2798803-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1130ca-0dc9-40be-c2d2-08dab3732ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yy+B9ypasVpM4VjPVFmuiwz/e7sFuIct4qbhBQxSckH3cM+1U50+1ADWCVSAczd8U21OwmyDTzfvS27y6FFXlQXFIp4em78iox7m5skUwrkT8Vk4AVVUYRUbhT0fO7Z3bjhdKZ+3CVo7RN5HpEUK5ypIhi3MGY/2GSrHpX/BJsEv4ieSzBZiE6joOYj2xiYI4lGqVZ6C+GZBX0YD+fe82edcShOz0LFrfrQckld6k7uyOk4VQUOtDjVi0dRMnni+od9O0lIij9n2mQEL8zguT4LexwnChBo17pm2GhkR9nKl9sQ6uRh1SpG13E/hQGg5LdJ898avTV/DvfwXDp9bFstWQrHcI/fq2GzgbxXPZWC5dbFEj2atyI+GhJsUUfARj4im1qWaaWwwayLxQyM4CcQts09ZCiESd4EkWQXh/mwiwKYRof//qW3sJg0unYpiA0cqOXwt4hHw83WTK60sGn9gYZmxPaO9m8FntIC1yY3QV44ZHFuGgnUi61jNL6NNnRj+4tUjBwGjBVNHNYOZ3s8yJtN7RWQAB3z4gNnEXVE5uBlUt3oqQcZLPiUUfgl6oF6pQ71woPp+t9mspscD05BRjWJBWYOAnBeNjdMX3CTtZM7/AKaB2vlnR/ouF+SJAPWTajtSslNGEcmb+nWpjWVPBvkKgQWkmLCw7XV5ryxh7HJZyjNjF2pXThhJAYOK3RjHqkrVNKWLSUUEWiK0KVAP472PJ5PzexsNtJC4g0RevpqfGPxYKvBuiMQl/g3So9Cx9/KmITaNPEGLr6xuhx9NCQN4kPFWA5INlndleNjolTK+9F1AOvwsUBtZXBL4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(83380400001)(86362001)(478600001)(70586007)(36756003)(70206006)(316002)(26005)(41300700001)(8936002)(5660300002)(8676002)(6916009)(4326008)(54906003)(7696005)(81166007)(47076005)(1076003)(2616005)(82310400005)(2906002)(186003)(40460700003)(426003)(336012)(356005)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 14:47:31.5026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1130ca-0dc9-40be-c2d2-08dab3732ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the S2idle suspend/resume phase the gfxoff is keeping functional so
some IP blocks will be likely to reinitialize at gfxoff entry and that
will result in failing to program GC registers.Therefore, let disallow
gfxoff until AMDGPU IPs reinitialized completely.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
-v2: Move the operation of exiting gfxoff from smu to higer layer in amdgpu_device.c.

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5b8362727226..36c44625932e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3210,6 +3210,12 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 			return r;
 		}
 		adev->ip_blocks[i].status.hw = true;
+
+		if (adev->in_s0ix && adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
+			amdgpu_gfx_off_ctrl(adev, false);
+			DRM_DEBUG("will disable gfxoff for re-initializing other blocks\n");
+		}
+
 	}
 
 	return 0;
@@ -4185,6 +4191,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
 
+	if (adev->in_s0ix) {
+		amdgpu_gfx_off_ctrl(adev, true);
+		DRM_DEBUG("will enable gfxoff for the mission mode\n");
+	}
 	if (fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
 
-- 
2.25.1

