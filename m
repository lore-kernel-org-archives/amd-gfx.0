Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D05C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 16:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4693510E0F3;
	Fri, 16 Dec 2022 16:44:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E29B010E0F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 16:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kul7cBNnq0hBrDB8Z361ostgXIb6nl1fEGGKrKibdafBIH79xSvcmsfFS1/runppD9RU8iMlK2BDxqO3gKY2sVJEE99IOmUk8DB8nJbgfe8YGaNB/rOLYdn2ncCC7/Qf2nrUTyF/p8p8/UzzoWnwlFlNdIZX0ulRZHd1nv7+SXoRI/+76Eekka7s1XLe2gXLdoMAh8JXfvNpvN4r3iY4mIzarf0WJ8uUA5thGfYVFDA3Ri6LXrcbAeuyi7SLQdRNMQWYFiGJnxyY02b65f67cqmije4AMf9q6FJGfZDih4SoeOpoCxC0+LG5lzsE90Oib5LakyokrZ97kxwbEEZe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10Yt5gB7wCiN+ReSuyymUpDluQKTYiXn1TInkyma5wc=;
 b=l2Uk0eBMMoMUvHriCmJIkJz0+BL54GjOqdymbM1xBuO6JgR5jN8oN06hHROKLX0/jbrkRjqD3lf22QtaxJ2ZB9QdD+VEfewnfOBqiTGFumP6ntWYnrAQQHE/daCyy1flrAQLtovHXnR68F+pgTazRjlrNTKA6TBrclFBrBJkRLHYverq0m+AtpIHf7O85ner3fTsp98x9YauqTbJG6G6lkh62RaF8IcTMa/r4DpwwpuRD5z4IFgyT1/vx1YtP4RNergXkMgtLJ+56Bk447IVu8uu2SK36fEopJHbWeDGzIPaPPHcYd2IJ+2UWHfV7sXFJIWT0cYZ0yxvvFVMICcD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10Yt5gB7wCiN+ReSuyymUpDluQKTYiXn1TInkyma5wc=;
 b=irun1GJ1lo1ADzjzybjNVllJWGVxK/obcqaQ1XA6FJn9ZayNp9jOYzENYPOlfMQCZ6o5KQgF9Y3FCcEm17AbhvL7th6ONLUYtpCtDUUwpO5MMPpasYRXyULaOwOLorZGgnzMJg0zdsvKoYbI+GVaL1CuGKRqKQr34Pjetzzbrfw=
Received: from MN2PR05CA0047.namprd05.prod.outlook.com (2603:10b6:208:236::16)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 16:44:46 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::50) by MN2PR05CA0047.outlook.office365.com
 (2603:10b6:208:236::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.5 via Frontend
 Transport; Fri, 16 Dec 2022 16:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.9 via Frontend Transport; Fri, 16 Dec 2022 16:44:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Dec
 2022 10:44:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip MES for S0ix as well since it's part of GFX
Date: Fri, 16 Dec 2022 11:44:30 -0500
Message-ID: <20221216164430.42642-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 379567a4-f2ea-4b47-6bd5-08dadf84d6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xuR/OvoifiZqlNs00iahLwr8R0pfk/+OMTCQauatqibEaxvn26Wz45AglVr9U6MIErhpufsB4geXIJjfFRx8iDGerWs+2lJwPqwnYp5NublM+jbJSN0WHF2PWj8MDGrg0aUHtsbNyaSuVp3VMPkDaSaxFanitWxGe8mY/1qDD1DQYhoD/IqDzISufkNxCNk9FWxupEKpT124eadhEkrekIo28XVvwcYlt7bceRW2oqBIwHBoNFRycd2c6sHxlKGaSOuUFxw73WwGJ8/m9LqxD7xoI+IlgeHGBSkUYjytRU9aKog5M7yHgAKydqCCcJJDPm7sQzPuZWud8C15o774xR+LQnHWp3hFdRoe22MLKCwcI+EjdZeA8cepxzCAM0qLLvWtW0wN3AYsMtpILfmysRNWU5gXrM8fH+pRpeYDbWMo26GwAEObKe6vekDFHWYlQpfT+1ttCH5+85ZSh2UegSmg/DhFWmdso++5oE5jzkcBNLdxFMeb1T3LVY9Vm2McZeFpqIkMOaOvPf1hJ+LytOzgmGUbbe753cFm1OZ8i8h14QTv+On4BPH9QEDINyeoIGdNeragQmqihMlt3Y1QfC8jP66TY740C7XLMMvhR42jq3DieJuHD8U2/x8T8TXARoP21qdyjRt5krKfpb3mKi8LIS/t14F9upuMhSGWTOx+BtiyKb84oc7vn+agSVLcLorzQJ/ti+50i+d6f1I10cq1GpvSqaR5kHwqCH3OzHH3ntZLwsvOmCgypigtyPQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(82740400003)(36860700001)(86362001)(83380400001)(356005)(81166007)(26005)(36756003)(2906002)(40480700001)(336012)(16526019)(5660300002)(6666004)(186003)(41300700001)(8936002)(1076003)(2616005)(47076005)(426003)(8676002)(4326008)(478600001)(7696005)(6916009)(40460700003)(316002)(70206006)(70586007)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 16:44:45.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379567a4-f2ea-4b47-6bd5-08dadf84d6e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's also part of gfxoff.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 582a80a9850e..e4609b8d574c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3018,14 +3018,15 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			continue;
 		}
 
-		/* skip suspend of gfx and psp for S0ix
+		/* skip suspend of gfx/mes and psp for S0ix
 		 * gfx is in gfxoff state, so on resume it will exit gfxoff just
 		 * like at runtime. PSP is also part of the always on hardware
 		 * so no need to suspend it.
 		 */
 		if (adev->in_s0ix &&
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
-		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_MES))
 			continue;
 
 		/* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
-- 
2.38.1

