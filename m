Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BFCC001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2A710E5DD;
	Thu, 27 Jul 2023 18:36:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FF610E5DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKS6HBYu+Uo1LXf65LR1aCzmPmqtuXoZX0MxLNc7sQhetLSb6QmAIfUym10z1Y6ZtR8a+oU341i9r600CjMnuIDGuPN4oC6fNluH7f+Kej9N9AIZt2XQpFbGZX80QBEEutYlVyh4Ak05mgTKJAYXtZN4tjyAu04e4PLGPzHQQ4oGqC+HBX+xM+L+p/jT9k8R/f2aBdQO1rYDEAZ4RQS1cAtCqDYwxzZ064DGY9WtxZKDUga+sssT6KSnZTMSQmKhobGLzaDSlOEgEdtYAeDBny7BNs2jiZi3Virf4Sgde6jNnAb3RCXhh6ifJvFtQB8laEyvFF8tOaN7viWaeIS4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDtX29GRg/hGww2HopmIL85VpNBwNMlRdAAaFtaPMYw=;
 b=jXtBONs8SDub3DLiYY3qzf3J1RjPnQmzh5N8MKDstD65DD/kfAGV/yI+w7SKW7n709HgrpuxRoyvH15uc+M3eNKO+FRiEroOR7mpVmw7D7DxLyeZEK1kw7e6bgV8yXQRr/cK1C2GZdRKjm+OPyujQiJoVadeT3RmSYg0ePu7juZ5zofPJxhOoJRiQGXbgcvzKUaw56qtS/6Y9WVza6O9Sy7aBHkvKG6plfrL7DTUeUto2vV2B9qvFjmJjH4jcW/8YpAz2lr3MoOdwzNPNDXwrH2o9d/shOMWEj3dUCoAUiII0u2tOHk7HHOCHlZu9aWwsu1hysecN75s8Ad0BUYGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDtX29GRg/hGww2HopmIL85VpNBwNMlRdAAaFtaPMYw=;
 b=ioVNEnPAbK57GuWvtXsFL7dexXzXqJcE8Xl8dzR9WFl+UKRht/eTTyH/uP72rubiMpOKhsu2/8L9vl/yMGqwflbU7x7v/o3EU9nGf4R82wy966MGclGbkwspj0+UueeMd5d2ZP+YXyPVr35gcVeLiVm7a3UdPtnNkqd/SU0g49k=
Received: from BY3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:254::6)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:36:49 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:254:cafe::9c) by BY3PR05CA0001.outlook.office365.com
 (2603:10b6:a03:254::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Thu, 27 Jul 2023 18:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 18:36:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 13:36:47 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd: Disable S/G for APUs when 64GB or more host memory
Date: Thu, 27 Jul 2023 13:36:30 -0500
Message-ID: <20230727183630.17043-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: d38c1f82-e347-49f9-7931-08db8ed06fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7LBNRooUc51zSvRKHqYMTuFeiNQiT5mWc9JeZfRkLGpb+C8HFUtkapc9pzGx+aGA8kjShsoPwZIStLO00zA0MJ7jPzqN+CubsTBryJd+SR9xRNjbopsMQ6h9fx9KnvLm2/HeryVA5iHOpSNIykUpPMxCmuElLmhZmANG94XxpgapowdbhS7q0mbQF/OVahKl50KuFmHaMXhUIBq83w7heMt5pTbgPucMWAt2+zdcOSZC796dD2dlXiz+Uxy64v6DXIFj68DPHIWOcJEWND/btRLU/Tr8cGqOFErF0K4qTqthuXKBGWGhlhiUA/VyrPhz2spFGOn3UM7wFp3y7vXOcPoMuYE1pBaCKQ/chCMi9haKK9QwW/V+nSQg2SyksZ3xeDk8LkMdvgHSW5+qu4B+cGqUjXXi0ocHdhfnBfcwgfX6cV7uBk73vuT2FxvqArRMGnxMKMW10p791WoUzCnXaoQ4E7stHqcXNCitMDjPB0FplMNVAgaRMFKmV8Dd3+mBMjZwUhLYE1Wu1jYJw9paz+pPOEV5+F/AYOD743DZ3kuxRZ/wVj61+munpyUHoLYkE0G/PBJu5R1H4acXUK25jTdgg7ZNVee3a2WL3ks71WnlwrnYP4A7E0RrEn0t3j8RMH74WR/x3OcIaUM1wxOm5AYXXyXIqMY1EDSR8fku7HR8pZcyfzmmoL8xJSb4cX36IPtQ4cPYTRnCpXlmGBD4oLsaygfv8+HqY6vXbsMaO8OYA0wnjWe5AO82nzeFXFY6/BSHbKpFZ+xT37HlihpTejjkVv84K5e3yMHve1eJVU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(1076003)(316002)(26005)(8936002)(41300700001)(8676002)(40460700003)(54906003)(81166007)(82740400003)(70206006)(4326008)(6916009)(966005)(356005)(478600001)(70586007)(40480700001)(6666004)(36756003)(2616005)(7696005)(2906002)(426003)(36860700001)(86362001)(83380400001)(47076005)(44832011)(186003)(336012)(16526019)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:36:48.3952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38c1f82-e347-49f9-7931-08db8ed06fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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
v2->v3:
 * Account for the VRAM carveout
v1->v2:
 * Fix updating mode_info as well
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 26 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++--
 3 files changed, 29 insertions(+), 3 deletions(-)

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
index dc0e5227119b1..0d602abd32bad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1296,6 +1296,32 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
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
+	if ((totalram_pages() << (PAGE_SHIFT - 10)) +
+	    (adev->gmc.real_vram_size / 1024) >= 64000000) {
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

