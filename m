Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59393C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 14:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB69E10EF99;
	Mon, 11 Apr 2022 14:00:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2CB10EDD7
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 14:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBcXd/7P4TU9LCjKHcBGZi1hctQ1a57pv8xFm/VrlvmnGHfHWv+cNMl3sASHfy5KkM7amI900j5NY3HgEnPRnY6oA9Z+W+7FOO6zpeL7huk3HUEGDNmO0b+KoNGrj0N6DwYMp4P8m48pvUeSiM1GHCvB7aart16qhZcVW+QO1ffS/RakMOsfHKJfQnc5++qYEPxGfAM3RE7ATyNgruHZerf7MFJbvu4zwikstbmZK4uzyC7q7Rx9U3Qr8F1BUX3dQastkjNWyfWFCgXWN/I0pUVtFzRvdjH44neyt415dGS4e2XUKEQ9aMqvZbxkqjilKoZtjcagfOLBflMV6zGZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbyrM5dk+G30IKzFMbhQzcXCMQIvn8eIT9w4x6o3Mvo=;
 b=ToB+hyf259gLeLqqFY6MhznfgvoSlJavuEoiKaYC8b6TZpG1rMEye5LuQPIXqk6SalZodcmn16AvWAQgoS/R+CLj5923KMviGsUvP9GQkXqr9IdKFkJlCprNCZw2bhm9A4CJfWm5DaHPrfK0PcuRFia4QYlS6fTD4KtzHBFHnFiKMPqCwrePclv1r9Or+M9do7bMrL11R+OSK+4C49gWjFOoqy4PUCEg6BZSewEtP3h31KfyPK5iEDmSNPH78dzThgAWfRzwCK+gWdlguc3BG/LWk43SO6lYPS+aFAfbuyyznx9lJFaM1NrdviszL12v+GDdvMbMggS7ynOjarkS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbyrM5dk+G30IKzFMbhQzcXCMQIvn8eIT9w4x6o3Mvo=;
 b=1bdm7iHLBHizrMGNCH8sEoihklp6Hs61JQd3dfhX70JIuQd8jTeH5r5H/mPcsrO/4MTV5oG+aBW8PqWhGyRq3GmIfPUWfu9TgfTrfaNZodIfNllqHHnAhnpn8sLv8yavH1EXfQZJYh8nQETCc9SkgpMp34Y7DYQnGwtsa1SFcjM=
Received: from BN9P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::24)
 by DM5PR12MB1740.namprd12.prod.outlook.com (2603:10b6:3:10f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:59:58 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::44) by BN9P221CA0026.outlook.office365.com
 (2603:10b6:408:10a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Mon, 11 Apr 2022 13:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 13:59:58 +0000
Received: from yonsun-E14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 08:59:57 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jingwen.chen2@amd.com>,
 <monk.liu@amd.com>, <zhigang.luo@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Date: Mon, 11 Apr 2022 09:59:39 -0400
Message-ID: <20220411135939.906700-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ce5a64-de97-459e-0fd3-08da1bc390a9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1740:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1740F5338FC1ACF23A6E0208F4EA9@DM5PR12MB1740.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kASABwk2M+xU/GvZ7/R0MjuUw6+buChfyBGTuPZpCKXyc6/fzHiCTfcmFCO2gFViqwWes4JDfzMJbHUaM0ERGaF6XUnTdnuODpE10L7Co+nSUd1LPSf1RD6yhLpcHuMUEXEDG02Vw1ff0+uwGxDlo8cO1zmYMNU59AS18Z1GkJ1Ld8Uv37nH5+rVCOnYZbUjdlyhpA7DEqj5MPUtO4/ZSgpNdpdXAHJ6XFBwMUeTfsH7Zy9to4/NrXpP4eWadrtCjemgpO2my/dAFIQrsaIdxuPlMW8qOutwPVTZqfR+17vRMEcFtuCwkclodqxKXBQL6rahvOhsrkRUKjEFQI5Ts+2zWfyMmJHltsvrp2kGYmTRFFHVQqxJg/ycSZIR/CI0katglsOFDhGXt53V0FKQ4f58ya/A73VSQhHZQNLi/41PIMcEM7vv6NO4X2uogWxqgQh4hAH+7PSyscREKJSGgknMLfJIhBRL2mFhSaOIg9CVCmf5GE9DjuGk1aeZc+4HGiXex31XvpkDicnOB6cCexqPOBme49bcx+oMLSApWbLbQ6veamJuI1KCCD2YTgFl6pbaC4vsTXvdPgqj+lw9W/roOzQ9JjcBQkrhcBePUZpaqcPonrIuSNmRyzWD8FuhfK11qS6WQ1ov94xUyTcd5IJ7Jkb6pjM7RYlpa+8iD1KkU29XlQD049bFjXBag/vnVAdT2y6YRX0swLXvzAHdbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(81166007)(70206006)(70586007)(16526019)(5660300002)(44832011)(2616005)(356005)(8936002)(2906002)(86362001)(7696005)(336012)(47076005)(426003)(6666004)(4326008)(26005)(186003)(8676002)(83380400001)(40460700003)(316002)(110136005)(6636002)(508600001)(36860700001)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:59:58.5292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ce5a64-de97-459e-0fd3-08da1bc390a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1740
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MS_HYPERV with vega10 doesn't have the interface to process
request init data msg.
Check hypervisor type to not send the request for MS_HYPERV.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 933c41f77c92..56b130ec44a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -23,6 +23,10 @@
 
 #include <linux/module.h>
 
+#ifdef CONFIG_X86
+#include <asm/hypervisor.h>
+#endif
+
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
@@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			break;
 		case CHIP_VEGA10:
 			soc15_set_virt_ops(adev);
-			/* send a dummy GPU_INIT_DATA request to host on vega10 */
-			amdgpu_virt_request_init_data(adev);
+#ifdef CONFIG_X86
+			/* not send GPU_INIT_DATA with MS_HYPERV*/
+			if (hypervisor_is_type(X86_HYPER_MS_HYPERV) == false)
+#endif
+				/* send a dummy GPU_INIT_DATA request to host on vega10 */
+				amdgpu_virt_request_init_data(adev);
 			break;
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
-- 
2.25.1

