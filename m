Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432ACC77B71
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Apr 2023 06:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D256510E1FD;
	Tue, 18 Apr 2023 06:55:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F2010E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Apr 2023 06:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvYC7RnwQeNU1fu9cZnH4K6vFCI1BHlrEcdlc7Kbip7r0cT+4E71prtNdsz9hPcdP3QYaPdwcxFdu8pqb5RDfSHQRdmIqXIKj8aU+hWOB4XygAwi0DSayWR+PSbpsf5+AF0NAay9fcpsN/2puctI+ViYziQcwjRKwXl4uRQQiWB4ZHFys6vF61kbXxpjCqx+BTgCoG71MXIc3AmwjmlfCRg5YXcoIku64NiRkDts1nhnqup+wnQmuJ1O0xxCRL7hNI3fgiLE6lmrmojd2DMg4EQclKV/JISZkaSRxeGE8bJkbYpETV0WDPrYjDHCXSdsoG0PfMH6H4ZVYMPDy0nH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGs3lO9y3RvKkWgF6LfYa3+LRZE/fuhh4VAaITywdog=;
 b=BHMT1ce7G8klEmLowDNzDQhFlx8m/QyL4raB2w7+fLWwOt/p+LzITCmbpJOWNoKAPwGrL2eRRe8Bd0O9D9b7LigvyFs3/0luBDx4DgieB5Lt3D4so4e1zeyrg5CdkFoSCfwTeiRUwn4joDVx7HipeKregaM/ILqv3bKaR1SmxYVtg/99F1u2jNTy8MyBzMtfEC+Zq6L5zYYY0+1YeJZKsIEnxjLT6vCbmlUoMvEivKmTHa6xbtuUfRueifEKLzVGDeV/R76wdu1W3MBvDjHNs5vhbIFrISINh1eX4lbLtglKVGBNj2BMGXbXHIXHTPBZieXpx+WTiRWUhrWs3jVt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGs3lO9y3RvKkWgF6LfYa3+LRZE/fuhh4VAaITywdog=;
 b=aAos5gMBksFXNUwgmAekx4+MCtHVfko7TIdsJoSokYLDjZMZuFGIhT8J2DZx8+dzyQ+MdTSPNXyVKOvJddpOLdUOCo3ufGS1E+xeIh8vNUu+UZkcASSjDzhQHuK/fKEm99BeTBdqVN4E3rOYKIEDxsbYUC6p4ZIWrl+sNIGZ04E=
Received: from MW3PR06CA0014.namprd06.prod.outlook.com (2603:10b6:303:2a::19)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 06:55:05 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::e9) by MW3PR06CA0014.outlook.office365.com
 (2603:10b6:303:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Tue, 18 Apr 2023 06:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 06:55:05 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 01:55:01 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <hawking.zhang@amd.com>, <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Date: Tue, 18 Apr 2023 14:54:43 +0800
Message-ID: <20230418065443.878721-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|CH2PR12MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d63e19-46f8-461f-53b6-08db3fd9d71f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OF3TYkTF1c6uqiw13TNr3wMhwyn/H6MDfy61l+LL6Swr7ZbgzymPeUU6fUAxfV7/Q5qf79HKA416rsCvJJAhb3wsTisKn2i5Y0TiQGTwuqvmh+LogH/bKautbXBDMerTjDcMXh2jX6kmgZBPQubJEB4h27vTwBtkAJanHTJ3qmwt6cq7QugJHcg728n6MdvGdfinuUO7CVvhzw/fspiwnNgEmeDEonAgTbDnAg2sDzI61Q90PfiS9uQvnJK3mZCzn5KJcmiBENNVPaz/M2jJPi/pIYtaYVHPUEhvBUsi45tIZ6/ArXyPsm3KD4wlYgxjZNYmhFYHxaZhbPUijYIjNf9YQF2BXA5hXhJ33x8W9VBx2138aES7VKBmorELAAEn5vLvwsH0v/GyFL8HOiCy9ETL7rtr5kYOZnZR8hboc3JoH4WRBVOhIKzoSpsPM201SfSWVMn2fWhlkWgTSTq4KIyi7MhKMnoufvqOlxCIDUWKybMHmgQwN61zumqKn/2lfSNSJr+65lpKt5jJUdQOIbyv0mXVwdzfWz1B446MRs6n1rPlXKwn6WKqzFGfXaLRc+r4rJ8Pl528e+R1aHLyrDCuAaEvip5LazJrc3yRYLCG5ZBbTTW6WQreAdatM1bVZzV6uU5OL6pUC1rHwwxM9p27ycXkejKyrSJKqALUTZmHHRnN2IUwXIfjXN6HX0MjKesH//tc0eO83WgpoDHFCeD/EoaWBCf1CQxVvYwktg/pfxy4fwI9yyI6mbgzEnCf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(336012)(6666004)(7696005)(478600001)(86362001)(110136005)(2616005)(47076005)(36756003)(426003)(36860700001)(40480700001)(26005)(83380400001)(1076003)(16526019)(186003)(40460700003)(82740400003)(356005)(70586007)(70206006)(81166007)(316002)(2906002)(4326008)(8936002)(5660300002)(8676002)(44832011)(41300700001)(82310400005)(54906003)(6636002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 06:55:05.1102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d63e19-46f8-461f-53b6-08db3fd9d71f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Shane Xiao <shane.xiao@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
The selfring doorbell aperture will change when we resize
FB BAR successfully during gmc sw init, we should reorder
the sequence of enabling doorbell selfring aperture.

[How]
Move enable_doorbell_selfring_aperture from *_common_hw_init
to *_common_late_init.

This fixes the potential issue that GPU ring its own
doorbell when this device is in translated mode with
iommu is on.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 4 +++-
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 47420b403871..f4c85634a4c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -535,7 +535,8 @@ static void nv_enable_doorbell_aperture(struct amdgpu_device *adev,
 					bool enable)
 {
 	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
+	if (!enable)
+		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 }
 
 const struct amdgpu_ip_block_version nv_common_ip_block =
@@ -999,6 +1000,7 @@ static int nv_common_late_init(void *handle)
 		}
 	}
 
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index bc5dd80f10c1..0202de79a389 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -623,7 +623,8 @@ static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
 					   bool enable)
 {
 	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
+	if (!enable)
+		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 }
 
 const struct amdgpu_ip_block_version vega10_common_ip_block =
@@ -1125,6 +1126,7 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 514bfc705d5a..cd4619085d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -454,7 +454,8 @@ static void soc21_enable_doorbell_aperture(struct amdgpu_device *adev,
 					bool enable)
 {
 	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
+	if (!enable)
+		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 }
 
 const struct amdgpu_ip_block_version soc21_common_ip_block =
@@ -764,6 +765,7 @@ static int soc21_common_late_init(void *handle)
 			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
 
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
 	return 0;
 }
 
-- 
2.25.1

