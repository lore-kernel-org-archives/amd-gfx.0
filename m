Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855A6C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A868310E353;
	Thu, 27 Apr 2023 15:27:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F75210E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpQ2an3t+dCTlOYK89jN09xDxdWRWx6dAtAJgubRiyxxLDwMqYbfOScOifezDkfBF8Wlll6dfqTRZx4zDPg25+0bRf72pCB9jEKWI3h3LGwuGKJN0dN4U6T0v3OnTSMCleV9BOF4GSIdxISH17Ggo2d0b/Bkk2KJbE4tUqPBqjENBN0piBKHOYJZezrWot5Rziv8LSdLu3xr9/o8+o06IOuzSsfKhCPhhyKEsgkB82QI1rGdV9OCgz/+vDtHnT0/WstksmPrTLORjFd7zam5DcIYpqemqj21YOpM01UuZJgv0pfd2qRk6oEVdbJX/qb1wlDVFTipRKn/BqOON17Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcaUfsFrPWnBRqo6PEYmkmjfY2KMPBcx8jMAk0ki5Co=;
 b=XoOF+FSJ3c8CzQUy5VK6X7CZMjr+qywdwEK5HBmnp70YMAkZBWnENE9ken/0WLTo+qFU5HRuLCzwQ5R5zskqIBUE4EoF1UATreUyRY+RBBo7zMxZBSN+aEr6m9+0AbE0THzjupr5YtxPjh+TMHd0V9keFjPnuTZlOAgPwvrC4EOKvr2+AVFyAY92dUxrjEO6k7ugQSFjdpQvPi/+ot5b5lF7v/3Ni7rLtQKGy075/Ay1wexj3jbQ1/5u8jgBinksoX5/HILWR3lhuIIZNaKfz6ryHj+mzRRJxG4OspELRQewwm0tPOpeSdnlopFoJ/sGpIDIE9g0Giju0f8xa2cOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcaUfsFrPWnBRqo6PEYmkmjfY2KMPBcx8jMAk0ki5Co=;
 b=x0hrOD6hSmoJu6nIkZMdnztSKUaC/ltPsaHPzRenMmJ3FeZQUgBMv3icYp33RV81cvQ9Pp9MwiNuXldfej6yg/8/cBoHFwfPkozV9/SXYDb9S73ClKzzhZB5IsTIKnhtlfAFjYhckJI5p1TyumSJzh/uZUMEehCiQf6cEnVJ/s0=
Received: from BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::16)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 15:27:39 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::6c) by BL1P221CA0022.outlook.office365.com
 (2603:10b6:208:2c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.16 via Frontend Transport; Thu, 27 Apr 2023 15:27:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amdgpu/gfx8: always restore kcq MQDs
Date: Thu, 27 Apr 2023 11:27:05 -0400
Message-ID: <20230427152709.7612-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fd04bd-a8a1-45b3-1ca0-08db4733ef67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9tL/fxZdbYYbBMVJOOGxDa7qcidhYT5vKwNjB9V83ZygpzatZNVZMdgAyRZJkgt2lMHxW5oXtPvoZFBLIUF98GpA4KpF/+PMVQXUk3wn5ShH+jtkzUg5GnG5dQegTEiX/edYTTQOZwRlknPpYx93WsNz3ThTWpGxRIpYPo3DDU3rWoUqPX9oYYPuJqI9AkEvsJBt2BHknJ7oGOxVdwYImlxVYvmzIRMF1zPCNaJCsguETv8wfyVtqo4KLGgNKuXjQo4PH/C7lN0rt3pm46WXlHgk5W7RTwIr0fjFXroEUUEEYR9ejTTGYMfTg8sT6glpQUzoo1heaVlHCEoJIOlEuY7O+N+Aa1lkcmHgNUs1qxQIim3liVsF/FTBhk5PhPwCTuLToXAMeO7aOCV4y2ukFMZF02IHRVw68Ojimz0BXr74dJjzZrUCnVT7rz0Eg+7xdjpG7w+ijVOTZHS/imWaVdv8Natq21q/GZCpwqmuLDfVJf4CJnAocHZtMJJmFLfQqk9z+1Ltq1G4F6vog04G7H+uwiY8VxPEEIMQ/irOm7lnAoLsQ6U83CLW/lJCLAdhPJsUJsbqMUa+tSOs2oWUJtRFnT3I5VhbGahDO4kN+O0YNyGIMNwWBAV0WxeLLPqX1TQX4z3/LIjTcejr30UYRoJTMyiZitSaJQwwmEYG0c9Ld6w+IcS+YpspCkEFcCFwrJWjwDweCcWn0ejnU8CqhEQreYRqJbdCp5q20IHf6c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(26005)(1076003)(426003)(40480700001)(2616005)(36860700001)(83380400001)(336012)(36756003)(82740400003)(47076005)(186003)(40460700003)(356005)(16526019)(81166007)(70206006)(86362001)(70586007)(478600001)(6916009)(8676002)(8936002)(5660300002)(7696005)(82310400005)(2906002)(41300700001)(4326008)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:38.8004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fd04bd-a8a1-45b3-1ca0-08db4733ef67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

Always restore the MQD not just when we do a reset.
This allows us to move the MQD to VRAM if we want.

v2: always reset ring pointer as well (Christian)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5de44d7e92de..2ae7f167985f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4651,15 +4651,13 @@ static int gfx_v8_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct vi_mqd_allocation));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
 		/* reset ring buffer */
 		ring->wptr = 0;
 		amdgpu_ring_clear_ring(ring);
-	} else {
-		amdgpu_ring_clear_ring(ring);
 	}
 	return 0;
 }
-- 
2.40.0

