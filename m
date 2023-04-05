Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31A1C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 04:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595C110E2F7;
	Wed,  5 Apr 2023 04:20:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C71A10E2F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 04:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek41Htlbww3U20Tzi6649mlwzo0fHDNfHRMCvsmdkEX2mlygEJGamsW6gj70qFFjI7b8vp36CDUyRjcL/u0LcNp5DN4+m0JjumYMivG3g1RbwF4nRdUM9nFEZdLSR6608ViUt3aFbCtTWSBRh/oJJ0zlFeWOK9ATXeTO0WKrX2/w23ct1bwCQh7g4Ev5/5voL/xzTMQao0y/UPwys2QOg7Vc0qAv56hASps6Z8QTcL9fdN7vB9oa42R2THyulMKe7TTk7YfK0VJIJoOXif9vkB27uAVbXL/haz4tBHt2efXAOQXTKA/fQuaypN2xVobaVSEWBu/LPHV/rK8RIJe3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWmZRZfjDPRIkngA5kZ47e5MlKsvkmxvvKuvazHtBKE=;
 b=JGpCXd7gTR9VPLlTkQd0Z1zI9Seqz3+C1eGzibr2Fh4m0T1I16XWxUHUfPGaYKOyyRiO1gR+j34XKewG/pkdxdPsLBDzjYGhgWdK6r7BNOAZaqW9rHzE6U1IHmtbgUxh5IqvxEPYRTWbdkZ5f4PpKFoKKZV29ai3wuRYQAHk/hlSPF6IYR54cCC2om81LteN01RVM6i+lx4dh6aOa1I0xQighaV2xjvKiV7F4y3PeHbiyoZnKSTyWaJYqU+0QB+CXQeI0GZZw6M+KhLft9HU1TeeiyiKpRMMO9oEPue9Lpex5JUh7xmWqpWxKHN5KScnFWWOKbot6gdGbkr8C3SGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWmZRZfjDPRIkngA5kZ47e5MlKsvkmxvvKuvazHtBKE=;
 b=l01KmmebOGRBNJim+mm4pMgXBU7hI+A4vYceWExf0mqsTUCBDKQAgrnTpfQtizyYzRrnG762TPcmxq4OSx/dCAEzr+bp4614Ryarem3hnG/df3zR79uqD+z8ta0nzYP1D8z2Jdlo4mDPaz6vNpwVQRDxJ+vIsr52qw41+cRitOU=
Received: from DM6PR03CA0074.namprd03.prod.outlook.com (2603:10b6:5:333::7) by
 MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.28; Wed, 5 Apr 2023 04:19:56 +0000
Received: from DS1PEPF0000E64F.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::4b) by DM6PR03CA0074.outlook.office365.com
 (2603:10b6:5:333::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 5 Apr 2023 04:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64F.mail.protection.outlook.com (10.167.18.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 5 Apr 2023 04:19:56 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 4 Apr
 2023 23:19:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix trivial style errors
Date: Wed, 5 Apr 2023 09:49:39 +0530
Message-ID: <20230405041939.3781870-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64F:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a0cea5-afcb-40e1-8804-08db358d032b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPmgwN7Efk3PlNeOjVhN1oEu6QX0tft83zFjB5p9zMlroCkyccVhPxEkTyASl/Or+3NYGbdE/JFboBVMJ85IdiHjBpI8x/+v4/ox8/XJCkyyPk5mPv07VAamQ5Jh8dAH3UdwSxF2zm7JiwUqri/1futWZvCrFajRJ9OI5Esit2iW1v3aN5+0JYA65Xf4yE3+Q9k2vw636UHSf9Q+oAFhz1eM2yfm+PhElPspQr0sACx66+JNztnka8RHtazRffdJyZkf+S8sPHxSW7RPE2tsiYkvq3EhvswMvfQpidOdUG+gTuwAPxzhBCTtiutDVAaEZWz2ggFln0O780hIH8Bo+01dygT4mFJ+ekgwOkZS7cZ+OIAYkG7EDjKP3Lw8HHY/BsGLubkIqyn+l5mVBMNxTdgtY8ZMwJ5cUorlSC5AvM5W3/QQ6uA0iqV4Kyn24qo4xyY5vYfyQnFDEYDfEzblbfsv8etfC9lONf7Cs4FY1Rye9LtoJNgVy1sqMaL7GL8gm2C8BbDZzo67bf1jqGXFO0AINC9JKuQ5aWpKuAVE7XB/1bSW3WwThd6sPnmEf9z79V/lb1lhmF+/DqgAT1SKAtj8hfJjom1yKsr3Vd4MdAI2aceYkswRV10Z+lG8by2SU2DzFmb6sQ34RG5W5KNzVaSxcIWqzcuW03M0LNbhFAX4ZCpziEsDSydhiONRtoSM3BzQMknv6MFop9VgJ8vuzdJg4KqdfiEaUxABaOOhPjs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(7696005)(81166007)(356005)(70206006)(5660300002)(36860700001)(478600001)(70586007)(316002)(8936002)(6636002)(4326008)(41300700001)(110136005)(54906003)(82740400003)(8676002)(336012)(186003)(66574015)(2616005)(47076005)(426003)(83380400001)(44832011)(6666004)(16526019)(26005)(1076003)(36756003)(82310400005)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 04:19:56.2121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a0cea5-afcb-40e1-8804-08db358d032b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix coding style errors reported by checkpatch, specifically:

ERROR: space prohibited before that ',' (ctx:WxV)
+module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
                                                               ^

ERROR: space required after that ',' (ctx:WxV)
+module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);

This patch gets rid of all above type of  "ERROR" messages in
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e652ffb2c68e..d2af86c2af2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -526,7 +526,7 @@ module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
  * Set how much time allow a job hang and not drop it. The default is 0.
  */
 MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and not drop it (default 0)");
-module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
+module_param_named(job_hang_limit, amdgpu_job_hang_limit, int, 0444);
 
 /**
  * DOC: lbpw (int)
-- 
2.25.1

