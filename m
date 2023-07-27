Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD32C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 17:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBACA10E5D7;
	Thu, 27 Jul 2023 17:29:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D2C10E5D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 17:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1h0f0B1IoOR9xB1sGZRd5BGwiBI6sm5gK0MKDdmjRALtea+VgqHEsPaZp/M8kJNrVY8X9c1/rJ1lz2im+m155kaZOkaBw00XtsOFnt4ufVjDuML5BRTuJB2CmzVCBgqF6lHonbYNgRZ6tDTPBB3vydM59yDURAbuediSALHg8RiQS/N1WVXZvWCTrEMHqzYkWPs3uwn+l4cWRqcc0xUzj3QljrjNvZ0yEqwxgAZvTZ0NRSco472Kk8aGj+g5dZaiWVMvriSpij4lKl1DehiA2QnXSVgVeUaPXJvu71LiDsiChfVrZqEOlgXf7q2MJU7y/X9bYHFe1Z9Dkb0+EHDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4Kchdec57ep9HxYw9zmiIBJ5JfO1/8c0O03h9KPa/c=;
 b=VWJET4XsU92knXzJzWy+6JRMIfQKrpFDeFGsHGERwl6OlbHwM9KPK94UqPMNV7OiB3R5M9WNYOzMV6voAx5jNVGRyABxdh8H0AmiDM36r1t1i5WTN7xLixg3v6SSIrpEyyWWBmet6/6T6ChvEnwlYERdASOdiDpGCJH2LZsaR+pA1SzPgUHbugm+AugXMf2/GO1hy10dE8o04CG3ZcWTIm7C+YNJUfwOWyZLQd7ptnTj9CsFWuLXTuIXXIVnGql5fnFZjL3hlMlkaeYUQ2ycNyuUewuzzL4dhNdtbnSi28biJgsrLwPpn+drRR/e5RDlTgjBjvVjXvF+51Ypy/hOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4Kchdec57ep9HxYw9zmiIBJ5JfO1/8c0O03h9KPa/c=;
 b=Y7UeQzBWzgpSw/rBzGS58me50peRWDt/CjKnYAqQ4NAZibgHFkam46W8efwUASj3UFZNrGPRTbWj8BmZAPVLoU92N5+WA/t/SF8+ZV+Kszgj3pRCw7JFFaaiuRa6qCqk1cUC7CTaiDLt1l9MJv+h9hMjQGDWRFCTEuDp7kteocw=
Received: from BN9PR03CA0278.namprd03.prod.outlook.com (2603:10b6:408:f5::13)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:29:12 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::ff) by BN9PR03CA0278.outlook.office365.com
 (2603:10b6:408:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 17:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:29:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 12:29:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd: Disable S/G for APUs when 64GB or more host memory
Date: Thu, 27 Jul 2023 12:28:57 -0500
Message-ID: <20230727172857.12780-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: eca89df5-c824-4bd2-bf50-08db8ec6fe2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iE+gV5qeGCY5kZoBTP5EYT3iH23lkcY2Gh+mvqchvRGImOd2cTmxgvSUFGmV8WJ2fN6QIvJuk6E7cGEnC/phoijpaKy18cWR4jp9Zb34cmRi4vySSNM93/C218SscpfgETXJFc4cRWHc3sNjMqMuEHEK11p6akOrNbZnodNa8OBESdryHU65ajTkkIEJeY6SJRvapy0rT2Ca1YjuK0XAbmjRYu8kYRUKYgLVtooOKJtj7LMfo5Z/LXUFutt7bIYztWYO9YUyG9pDXTQpoC7ugOXovgJYy63q+TtpIhUzhacS+RibHJQ3GTipW2UpDrPeiWOVOiS9bKUWuvwby/nmaLcFKd1IOXFts6jDWXsXcEmG327M9D4dwcQRdqXWpY8N/GksL8rzWkoahCCdX7Z3HKoXX+qBcIsttttJEWJ5zL2rgC/STnbXBvU8+szTp07PHw7F4Fy0NC6fsJtPqotZTyMnwsHf3IDhAzmn4oZMKOD72vZBC9Af/WUGylMR3JH8KkntPPmrzz1XYv/epfmtlXdwYmzepymKdkWhkeDB6O8qCXPsag4L0Q6lpqlgh3OFHUdnZFgUERGbC9ddmwOXXnPlOx68KK3HhPFxPlOHQp3VAZz9lIJxviLT3bwT4Cflq/0JSSVTpXU64U1N0LFiScSIPjHZl/WmgYRoNA8TVYl+Hvcy+VXjsgqHnhgx1Wsf7dDZv38737Rc7SQnNdKSTUc6QuMcl4mt/uHbVoFJOgbAcaiSLx8/SHrfXIAljI4AnQzZVVhynGOPlNDhUpaQLkH50sqJgHVFKjwkXYg2atA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(356005)(36756003)(40460700003)(40480700001)(2906002)(478600001)(54906003)(82740400003)(81166007)(36860700001)(2616005)(26005)(336012)(426003)(186003)(1076003)(47076005)(16526019)(41300700001)(966005)(44832011)(6666004)(316002)(8676002)(7696005)(70586007)(83380400001)(6916009)(4326008)(70206006)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:29:12.1799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca89df5-c824-4bd2-bf50-08db8ec6fe2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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
Cc: Mario Limonciello <mario.limonciello@amd.com>, roman.li@amd.com,
 Hamza.Mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Users report a white flickering screen on multiple systems that
is tied to having 64GB or more memory.  When S/G is enabled pages
will get pinned to both VRAM carve out and system RAM leading to
this.

Until it can be fixed properly, disable S/G when 64GB of memory or
more is detected.  This will force pages to be pinned into VRAM.
This should fix white screen flickers but if VRAM pressure is
encountered may lead to black screens.  It's a trade-off for now.

Fixes: 81d0bcf990093 ("drm/amdgpu: make display pinning more flexible (v2)")
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: <stable@vger.kernel.org> # 6.1.y: bf0207e172703 ("drm/amdgpu: add S/G display parameter")
Cc: <stable@vger.kernel.org> # 6.4.y
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2735
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Fix updating mode_info as well
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++--
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 93d0f4c7b560e..2e3c7c15cb8e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1313,6 +1313,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dc0e5227119b1..a4e36b178d86c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1296,6 +1296,31 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * On APUs with >= 64GB white flickering has been observed w/ SG enabled.
+ * Disable S/G on such systems until we have a proper fix.
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
+ */
+bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
+{
+	switch (amdgpu_sg_display) {
+	case -1:
+		break;
+	case 0:
+		return false;
+	case 1:
+		return true;
+	default:
+		return false;
+	}
+	if (totalram_pages() << (PAGE_SHIFT - 10) >= 64000000) {
+		DRM_WARN("Disabling S/G due to >=64GB RAM\n");
+		return false;
+	}
+	return true;
+}
+
 /*
  * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
  * speed switching. Until we have confirmation from Intel that a specific host
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 77d970a2ee693..26c3eb7a9f882 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1639,9 +1639,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		}
 		break;
 	}
-	if (init_data.flags.gpu_vm_support &&
-	    (amdgpu_sg_display == 0))
-		init_data.flags.gpu_vm_support = false;
+	if (init_data.flags.gpu_vm_support)
+		init_data.flags.gpu_vm_support = amdgpu_sg_display_supported(adev);
 
 	if (init_data.flags.gpu_vm_support)
 		adev->mode_info.gpu_vm_support = true;
-- 
2.25.1

