Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF02C7EE2D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A0110E548;
	Wed, 10 May 2023 21:24:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634FF10E535
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBeEYsH7KpuCpiatpVdc8XrwrrauC/SJMkeLNhozTIOkHTO70MmvsrWEeyh//QgQDdk1AIgrX9xK+zPayMe4vw4mnpl1RNUg31Lu1TUMABE+pw8sidspbk4QXpXN8X94XnQDe1dkzxliTHvvx524u9kBAHg/3K9BS789y1/ubVDnIOoNc4vYgRUK59gMj1X5GWfVWmWcPActJdOiX9dxRYNPWAqQzWSHIGomYM3bgtPzmvsZ1cwGnKSF916pYPVVswsbT8eaS23GgdpZC9epJbNy9MDinLf40um8tEecLr7PqIsL2YV0fIfjORGwefZ2AU09Ip7stGtf8KGbiM09hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQGhvmw2Mh4sw9zUPwhk9FBsqu0xB6nk4MTjoGM8EMQ=;
 b=eSRO67iAbo9BLoS5ycK0tz32EpEd0LRW5P8dzfJNKRSDVhfuLFNVtNwVU9DYDRo/2fjExQl2vG+jOsmaIu8QYa6xr18n1wD1OCkUcuANhbkVdfC+nDquvkHQTcKz/kOp0Z3ylSIoF+Epf6PPjCws1FOBywJ4d0yx51Hm6kxRt9QHtOP8JoemR1O8RUxPL0MRNms68UvmIrPuaZ5RJ9ShrAf6C8e/zm2MvLEAd3cTC69njBfOxzL9GpesPe9O98QzmGBdWo3Sk1O5QulQbzZ7/ospCN/plHKE0CDdbln/CeydvPVb78FtnynFEBxSNz0PX8naapH0UZZ2IrrGFLVT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQGhvmw2Mh4sw9zUPwhk9FBsqu0xB6nk4MTjoGM8EMQ=;
 b=BCRJ9XQ6V/1upNOF/v20kUbWmvgCp2ihLgkVvZdCbyoDDsq5lpDzDUikwpiK6G7bsHHDuXRck8uMPPl/Wgz0ojs4LaN8Dbhj/yquWQ/V7dHeepMizRtC8b4RlRjjwwxJy8LrndzkAnpcO6HCoLHCO2OBFDRhTT/BFwbJAuIz5C4=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 21:24:04 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::ba) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 21:24:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:24:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/29] drm/amdgpu: route ioctls on primary node of XCPs to
 primary device
Date: Wed, 10 May 2023 17:23:31 -0400
Message-ID: <20230510212333.2071373-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2d1997-48f1-4785-8348-08db519ce168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMO337bLSFpTiDraw0QZcOvjWmEkW1OYWz74TGMJcgtgiIcU45uYVi8HIynpvKtkdYHMFcMke5Wyz2dppOuyF2MbEPmeNJiEgmBORV/n8s8VRdtxNrrsKKr6Z0x7j3n3MTXTVL7rHvA4RhMjkZXmONYVRi6JwUaicin8xuKakwPf2pWQDVJpyOyHAAnqDFqBeVSuc5vgLfIyvZ1In65EY7uaENokEWERaF1m0+CBdbReSYhaYqKrSVR9IfA9Kk+MXN5QwqJdlhZapIJYb7eypCdObEgVaULhDOiEYzt2ufjwAnF/O23g86i+m90QuA//DyuDEH+mNroYzPqvlP0zEseRp1Aeytek9A80QieRHI2soQR2B5wEicv7Zw3VMaTC/NQxDtIHIl0E5EGSR5Uyck06YXPORyLhA8AzuMgocWWUtFkvtPwpl+aXJLj0RDDJbSMUVvfhVyBVdHjkFp35yjdYzacEmzEAoemQm4BEtMix/wI2qMP3VPar2sePr4G1k629BQZuKf9IVr5kKYmhtuNa6OTsfXKU/OBHL99+APRoVwgvy8gC2kRxDnVPelZULbQiEqeRB6jaBjtuOio5HavDW3Nnp+my5YZWFo/+CK55e91QlkoSIK+Qc+0vzBElkGYHOmPPMAyiU45OvbGv8eHOuVorijYLo3OoGdwvj+2Rs0XguoO9kUS+ciVnGald5q2pH+Puj4Lf3gxXtu9htm8sjtZm29CX+LSj74b4JhkOagYDVxddcZ9CKsyGbl/lK1Eu56Tf+RxCFJpDwDqZwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(4326008)(336012)(426003)(2906002)(2616005)(47076005)(83380400001)(6666004)(7696005)(36860700001)(70206006)(70586007)(478600001)(186003)(16526019)(5660300002)(1076003)(26005)(8676002)(8936002)(6916009)(41300700001)(54906003)(40480700001)(316002)(82740400003)(356005)(82310400005)(86362001)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:04.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2d1997-48f1-4785-8348-08db519ce168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

During XCP init, unlike the primary device, there is no amdgpu_device
attached to each XCP's drm_device

In case that user trying to open/close the primary node of XCP drm_device
this rerouting is to solve the NULL pointer issue causing by referring
to any member of the amdgpu_device

 BUG: unable to handle page fault for address: 0000000000020c80
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 Oops: 0002 [#1] PREEMPT SMP NOPTI
 Call Trace:
  <TASK>
  lock_timer_base+0x6b/0x90
  try_to_del_timer_sync+0x2b/0x80
  del_timer_sync+0x29/0x40
  flush_delayed_work+0x1c/0x50
  amdgpu_driver_open_kms+0x2c/0x280 [amdgpu]
  drm_file_alloc+0x1b3/0x260 [drm]
  drm_open+0xaa/0x280 [drm]
  drm_stub_open+0xa2/0x120 [drm]
  chrdev_open+0xa6/0x1c0

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 610c32c4f5af..daeb6bcc9245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -241,6 +241,7 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 
 		/* Redirect all IOCTLs to the primary device */
 		p_ddev->render->dev = ddev;
+		p_ddev->primary->dev = ddev;
 		p_ddev->vma_offset_manager = ddev->vma_offset_manager;
 		adev->xcp_mgr->xcp[i].ddev = p_ddev;
 	}
-- 
2.40.1

