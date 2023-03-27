Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45645C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E75910E723;
	Mon, 27 Mar 2023 19:36:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB23210E722
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh11zSiPsptDtHGR/RH8rqgnvkEvsyj9osF+GfBLO8OhY8h/qBb80+M/lD7jpx3+MjmcCg6NAoQ2Wy7FGBFYZBAeFeVtQZ6fWTEnVG14glA4RD4lfdD22sAWYN69n2V2VDgtmpOqZWGC71i/EM6g6aErS1ZML4wwHsSX7NXy5ymhQmIDA4LVmZKa0mtJsdP4+T1tvn2hmJEQfvrYQkeojBs5jMpWbCqiUs7DOLSTtQyCLSdYRwwNBX1YM3bntLdmHuk6gbaGSkiHU1moOzZagDJApg9VEIS7eGaFeXN0E1v3oXX5v3PRG5PUmZ4vBVZY9E8yPlkJrha0z7kTKVjGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJnCMaobrc7o+DtBKfzYjaKFOsz0rETzPZjNcGcfhPY=;
 b=CvDgrvpw2RQuB+Oo9kaApJu2Tc8DnfunvxoCexs1pe2mVUdY2b9hIUxxJR6r8sjsCLUAgASthIbq4REvHWJiBuAvOR+1Up42xX/33adho8RARdHHSieUGAsWhg7itSfqaX4LRhk6dGhO9iQVHK04JegyR+AB5HpOeqa5aHy2oXHZoLamTFvYVfErWR9yPYIjMslTAMLklboN9PHmOHQL2E7ktwtNYAeh17f0dyBGiOUb+vd35LdDvNkOT8uCuBlAC6MVFdjbwGJQxrrF55BjEPMwJ55OapEQyelp1U/jn9/kj9EK3Fn3zj6eyxRv9kR9IZWSzd1HUgyPFYLED9J3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJnCMaobrc7o+DtBKfzYjaKFOsz0rETzPZjNcGcfhPY=;
 b=xVdnIF5t3h48b9ecW6x8UE3TgrYWPTX5keS05R9ZLMoreT5tsG3UXx/VdtsgSZ2cl9n2UDa6pa85OMSelpZKivg0TeCwspNI97imzQqQrfIF8gmoPzXSACejIDJeP0KELGX+LbnrN9V+mBb+ehDHbDXuhumszEjZoi3mH5Fi//s=
Received: from BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Mon, 27 Mar 2023 19:36:34 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::9d) by BL1PR13CA0386.outlook.office365.com
 (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/28] drm/amdgpu: assign different AMDGPU_GFXHUB for rings on
 each xcc
Date: Mon, 27 Mar 2023 15:35:55 -0400
Message-ID: <20230327193602.7901-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 519bac79-a20c-4b7d-3b24-08db2efa92d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gc2RcWjn2ZcBRcEIHfOtW530HMaV05R7jmP3yU67BZcxR9CgS3MzBlgocVaAFKy/+vf8oQC2mFADIIohDOGLPHDEkLcPRzSo1l5Ol9fpz+sml4CUjarzzdIf5Ujz8mDYtVKAN747ZOgOWIC7GHNRjRFr54AJ4HkW6eLm5POqSj6v2NKcp11DNuKcp3KOwIvoCnDVh7Vy7DJ04bgD6ZZJ8+9yNUt5pSiXMkmyo00+DFlKzzFMZcArt2nJg1RQsMz9Hm86X7dvgWwft7U6qRlYtXGCNgCzjLoVLIjsD7ipXGr3oYUDzCmk5y2cW7wDXpEPJx5ZxIWbNEmWvKB3tk6HQxz5hMd+MbeHizAGOjjY+A1AvbfYDMVmT7OQTH8+O4p3USud0s+oGJmozm4T4Mh2ZY+j+47iVBc0J2x4w/p58loywW+mrMaH+CLj/JecQpF5vPwZeu7IDyeQySB6PwkXqyzBV1cD+pWlIwmPJvsxJSmao0KPwZS8tBrjR6mQKxre/2L1NbXls2mb3jio2rv8sF+fb/uZN/wPCp0uL/If/v4JlaAXAWIXKRk79jqBL8BSHqsnkfP96wOHrVDl1dUw4LbThyVg1kCMZ5tmt3zsqtkOkcyOyRG1n+tGdO0/6MSGjF84NPpndddbLFh4VNVl/8T6mZPuGWCLCEoBnxWn8Fqjos3v3YZfOEY9mWtwdpKAEW7gklibJSbGIW9QJXuiJMRMHx1PtMFGGtJjy+0mhXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(81166007)(82740400003)(36860700001)(40460700003)(40480700001)(86362001)(36756003)(82310400005)(356005)(2906002)(6666004)(16526019)(186003)(478600001)(1076003)(26005)(5660300002)(8936002)(7696005)(41300700001)(316002)(8676002)(336012)(6916009)(4326008)(2616005)(83380400001)(70206006)(54906003)(47076005)(70586007)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:34.2541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519bac79-a20c-4b7d-3b24-08db2efa92d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Pass the xcc_id to AMDGPU_GFXHUB(x)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index dffa3d34a1c3..5e1e8e043a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -315,7 +315,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->use_doorbell = true;
 	ring->doorbell_index = adev->doorbell_index.kiq;
 	ring->xcc_id = xcc_id;
-	ring->vm_hub = AMDGPU_GFXHUB(0);
+	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
 	if (xcc_id >= 1)
 		ring->doorbell_index = adev->doorbell_index.xcc1_kiq_start +
 					xcc_id - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fd8f6508877e..bd3a049b20c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -762,7 +762,7 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 				(adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX9_MEC_HPD_SIZE);
-	ring->vm_hub = AMDGPU_GFXHUB(0);
+	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
 	sprintf(ring->name, "comp_%d.%d.%d.%d",
 			ring->xcc_id, ring->me, ring->pipe, ring->queue);
 
-- 
2.39.2

