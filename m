Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C80C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 08:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C81210E2A0;
	Tue, 25 Oct 2022 08:00:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C3A10E226
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 08:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPUoU/mQglTQ4hJOBGIrYNO9F23DpDXIIe33sZiWBbFuD1c67mbAGWVVGsetRvRottZJ0GRCnwGrMSywb9XpKuHdGSMk7Qg5HPx6XyYtOg5ZEebJeTqUWdRI7KeRzdHmyFtMJzFlko7dHfN187u7SDXdIkexb9h72eSIXgo+gJJM6+MFt3J6ynPV8s5seyO1dAiWxd0+0t1ULK7wgXy4qC7Zu/m+lsO97p9Gle5pcCHh6EwrHVPFD8/lfqJpHNgDAEEi6Pw19G3h+gRHWR3zgP8uyG9w3cd1SBDftRGh2IVfqjZOUd0vn8ZnndjegOrhlMko+BhPxEj1pvO1R4cSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEgDMzOq6v48ifMUgxHQXk2w13qB3c7rWX/sXG/MRIY=;
 b=Jz+ZiWWgah68sfeSvHYHE88xajid0wHP47Z40a4ep5KEbZ8cew5Bz8Uf8XTFlaoAief4wWL0mQBNueUbvPS3jye0bC6FiALhr5HjSwSnEnQOCZOovWdXTrryrJvbY/cymIeM/4cYGUDwCcGhCMo9S1VUeCZd2FlQZxbUec2h1r0KBFuffYi4qH83feUDrycitEVMMSnK3tcaho2Do8VUDcjV7sUEouuPaoEl8RU4BEJqU4T+Odrd4TQndUxvM0f9xTxrHtl/UaC71an5soSpUEL1tTmjXHeyjeV3q//biPePhkOkW9lGxZoyBFMTvJ452c2X/HSq86FB8e8eZrH7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEgDMzOq6v48ifMUgxHQXk2w13qB3c7rWX/sXG/MRIY=;
 b=fD9Vp77ij/8r4Ty4SRvTzkUzMQ3haQLiGFsGu1LcaW9Nb1Wzrjz/rFEt0BhBjnJL3V21mROYVN8RqWYDkzyoUfg5MrV7YKL6MfuqlBabKDFNV3iaX6esCQTbGhDmW2alIqpsvDqWlpRoh0JiOU+fsxXcqwLKEinMQhNZWmaoUrE=
Received: from BN9PR03CA0372.namprd03.prod.outlook.com (2603:10b6:408:f7::17)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 07:59:58 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::98) by BN9PR03CA0372.outlook.office365.com
 (2603:10b6:408:f7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 07:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 07:59:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 02:59:20 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 02:59:14 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Move the mutex_lock to protect the return status
 of securedisplay command buffer
Date: Tue, 25 Oct 2022 15:59:08 +0800
Message-ID: <20221025075908.185288-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b255e5-9225-4b12-f789-08dab65ee937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdiF/ByGoLDDzSL8Xxt1Ckl8Q7FELJNJG8YoESBsEKemrYHRkp6RNw9Xe7SCa+dnb8mGdbfGxMd531FKt4jg5RoOHVczD61uFF1Pm9yCzkW+zWk76djGTJh76GDPRFimF1Qjb3mvcu2lHR06l3y05NCIocX0PXXYkxR7bU2ODMD4WiabHHHFZ3hS8aXtBLihtNWrri9lZiYHTpEy7updnIW8NLtpFkiMB+0r6GUbhlZIvvUXYA4hSyinhHXSYzCMlckjC8QR+2KAIOqSefPMvilNxwOJR6Z9oGJv2eo5WhlseTyN6qJEuE0V0VNoikoxTyHdccvyzWe15LNI7Yd8cqslYRxL57zGv58AF6r1l4MGhnln9YbChMuww8Gf2feWb3J5dz4tMfc5lPsIZFbPQ5gLmuAFlGFqQbBWdHDxmKLCeyIRLeO5zF5CgyqIKXHJaG1kcNzkzNf3S0P7dLc2r2TE8LGlircOB+aByQeFxGspgiPzb/W1G6/82YK09oYFkee8l4a7EkbE1LLL/GwaE8IIZ7TOaL+hIht7kSANfZ/SA80axWbKG0l2hFUe38v4IykWlIu7b8jxRZJfnllZ1yKvtr/FTdJ9Ltp1Lf8AYHiefC+sVwDk11Eq/lHSIsp31H/DbPs/b6B7A66mCGYk0w/k45xg4pBkYyq/m9h45KW6/4iJCijWxIoXn79D9uFP7fWhX0qXnJ+eBPbcgb30t/H8IlzSEkZn3nWT8Jr/FsaTkIRxV3p5zNICRvYXKLAbPVyXibnumPRJ83AMqpcLN2msrGBfcH+cgupnNTtOtsO4s6hO1O/aw/hi6VozEbv7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(426003)(47076005)(83380400001)(86362001)(36860700001)(81166007)(356005)(5660300002)(82740400003)(70586007)(8936002)(70206006)(41300700001)(8676002)(4326008)(82310400005)(2906002)(7696005)(6666004)(40460700003)(186003)(26005)(2616005)(1076003)(54906003)(6916009)(316002)(478600001)(336012)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:59:58.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b255e5-9225-4b12-f789-08dab65ee937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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
Cc: alexander.deucher@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 shane.xiao@amd.com, wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Before we call psp_securedisplay_invoke(), we call
psp_prep_securedisplay_cmd_buf() to prepare and initialize the command
buffer.

However, we didn't use the mutex_lock to protect the status of command
buffer. So when multiple threads are using the command buffer, after
thread A return from psp_securedisplay_invoke() and the command buffer
status is set to SUCCESS, another thread B may call
psp_prep_securedisplay_cmd_buf() and initialize the status to FAILURE
again, and cause Thread A to get a failure return status.

[How]
Move the mutex_lock out of psp_securedisplay_invoke() to its caller to
cover psp_prep_securedisplay_cmd_buf() and the code checking the return
status of command buffer.

Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c               | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c     | 4 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 4 ++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index effa7df3ddbf..7bbf869f4f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1938,10 +1938,15 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	} else
 		return ret;
 
+	mutex_lock(&psp->securedisplay_context.mutex);
+
 	psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
 			TA_SECUREDISPLAY_COMMAND__QUERY_TA);
 
 	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
+
+	mutex_unlock(&psp->securedisplay_context.mutex);
+
 	if (ret) {
 		psp_securedisplay_terminate(psp);
 		/* free securedisplay shared memory */
@@ -1990,12 +1995,8 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	    ta_cmd_id != TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC)
 		return -EINVAL;
 
-	mutex_lock(&psp->securedisplay_context.mutex);
-
 	ret = psp_ta_invoke(psp, ta_cmd_id, &psp->securedisplay_context.context);
 
-	mutex_unlock(&psp->securedisplay_context.mutex);
-
 	return ret;
 }
 /* SECUREDISPLAY end */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index cc7597a15fe9..2c1d82fc4c34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -121,6 +121,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 
 	switch (op) {
 	case 1:
+		mutex_lock(&psp->securedisplay_context.mutex);
 		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
 			TA_SECUREDISPLAY_COMMAND__QUERY_TA);
 		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
@@ -131,8 +132,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 			else
 				psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 		}
+		mutex_unlock(&psp->securedisplay_context.mutex);
 		break;
 	case 2:
+		mutex_lock(&psp->securedisplay_context.mutex);
 		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
 			TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 		securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id = phy_id;
@@ -146,6 +149,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 				psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 			}
 		}
+		mutex_unlock(&psp->securedisplay_context.mutex);
 		break;
 	default:
 		dev_err(adev->dev, "Invalid input: %s\n", str);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 8a441a22c46e..515352ba788e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -123,6 +123,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	phy_id = crc_rd_wrk->phy_inst;
 	spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
 
+	mutex_lock(&psp->securedisplay_context.mutex);
+
 	psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
 						TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 	securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id =
@@ -133,6 +135,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 			psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 		}
 	}
+
+	mutex_unlock(&psp->securedisplay_context.mutex);
 }
 
 bool amdgpu_dm_crc_window_is_activated(struct drm_crtc *crtc)
-- 
2.25.1

