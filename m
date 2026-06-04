Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6C7CD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF99112855;
	Thu,  4 Jun 2026 14:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FZliN8kH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4421112853
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8LWf/yafJ13M8a57rmUFDCuwCfwUwL+7Rw61Bno538/ILFqkOzxW0VIVJI7eF7V928mT1PvkX+PDoAf2n6c32NcRu6OT7BPmnnePy/UlRslP3fb35q0JFQTOpGYaC8fbOjSzKD+78OKKoXYVK7y7CSM1KEc37cZYBJAIdve/loPbuNiyLaj63zt3ygLhoMPQT8BdmKrzCIKNUAU1Mc6n049EirxssLOwOjGWv3D67ukRNvfUvg8EEqu7fzSeUdhyMslBWz5CgMtRa9PjSzKR7u+sTy0Tliy4J4aJOYWp1LIT7HxrbcEu1CuwSsOmA7e3NNbdNnYO9ywQiA4nEfGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuGQb1XOs2l+MZLVnCuoA2rMqnAFwOoJQPkEoIxdAFU=;
 b=frwSN92pq+8m/wYO/+8STC13Ci6K/HqVXDp91kM/UB6sOLsm7mLs2/O1YLwPlb+YCcoBUSrBR8VQeDqueLfxM8fONV1XXb7Eh8xZXYaf1puK6qZahxhaZs7Mluf0VILlnFtBKC4A2B8/RHi1M9riT5ZU2l88C0SHfd+9gsC6EXEfk/RF5hu2tl60qeZW0xmigPFtmgiY1wd7/ybkCzWmR/5+mJENp1b5YASS+xPQEfIZJAn8ThJI7dmaHvr4yrBRJFxVRvf3revKEKsgPrPZ3ukt7V368Aiez0YOGMH+Qot19l4TzR6BC+Tg3jCI+D33oiReEMrSdS0gAu4g6QpvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuGQb1XOs2l+MZLVnCuoA2rMqnAFwOoJQPkEoIxdAFU=;
 b=FZliN8kH/zsEMmDvVYbJYt03xOaQYSgUd54Oalg2zLSB4zJn/WJDt5jUj8xlKL2RBcWeZJZef7N8gFVL1DCx+nZvmCxzERuT8qrb6jBD/3xajG5NIByzSaufAzU95IIP9uJBEQr2ywHHUkSLHQJBreLjqvA6Epq4ECRHT9mzpmo=
Received: from BL1PR13CA0383.namprd13.prod.outlook.com (2603:10b6:208:2c0::28)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 14:55:29 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7e) by BL1PR13CA0383.outlook.office365.com
 (2603:10b6:208:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:10 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:09 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 22/24] drm/amd/display: Retry link detection on resume and boot
Date: Thu, 4 Jun 2026 10:52:16 -0400
Message-ID: <20260604145428.809959-23-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 97044896-eb69-492e-9d06-08dec24951e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: nnIRWtpCyRfFHntVvnhVE2Vo0X0QDsuPMIHrrYUTvt1SGoOZr/SoFYJFxz1m7isGyQQE91wOlxdglJ0KvJLGbpE1W/pYaRpF4lP0nuqFpFUSoAVua0s/BYZWygmeMeQ41ks7uEUtvcgeW3RTprOHpP4nD/r7uZ2k/fS811EmDkB+Kd0d5TY+Gmuv1gkTC/9hO+c6cdOObT+7NcYLIsDupUCAeKeNT1xqlRNOgulBBmfiPma/KhjU14ncjuhZ9A3BqPEs5y58EZgCfLn8Mj37v5FSNzZYYRBfRLeI6H2a+XmE8a9JD5G1eH25hFKwlUjCJHjtPVCk+FfBgut3VJg/H12o09adF/b3nVtcrjm0N1r4hH4JhV0mbQi2AhNM60e+0OV3S6/FZ9iaVo0oAWEk3SmuVxaSHglRQK9hnAajMqZhm+7nrb/apE/f1HY5yeaHXCQDM6FEFbd5jjM+/sIzUP8I/47pArDkrM0HI79hv6v44/FnPzLJu0rFDlQ4nVPArOQR0aaOM6uhPEXvj/7umA00pLgkbEI9yh7O04bq4egeqH+A3wsKC2VV9ILukK9ZgYmIOhNK/EPc7w7Fg31AuYi7KBW0S/jLJFv1xMXb5UpmwRiz9jTeVVxjD97a1N96oAA/Q7qW+qWMlyE96GHEHx+7rFomYO+wZIT8+kZ74BE5w7fb2K++ckwn+771OX/tFr18MOf72IZ0F9Bo5Rs0+i5BDxmBxG7vCbDEf1FAZqo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zlWhouT7Iv1d1QMpDMpddlq1KCCjjL9vdc48ex060UPFwPJXsIBIRLiCnro5IUbkMk71OrMBLXgoMTISeUjmo6JhtiOk+Etx9FT7npB9z+ZTM7c64ja6FzkKDo4FP1jzE1CbyaKep7arXtHq8GwGKVV3udRs4X6L9SpXMEYDE8gbvEPzhQoh3E9Sa98XRLRXJBtq3Uh8IZXh1RyQqVM/+O1ifnqLSgsmOnA1x6WQh+XGUhhQae88C4XejdoZZUXF+CCmvaSj0UUyxvVPJ3FUjdwb2lGw6iZPWyxJuSTkA43jjR1DYbyJtfJushtQSPzqAEnqJ9+I6/oeoib+qtqOjBWc72cIAC9S41cGg/QRV/wufXqIyqbT8dAI5CZJGrymBM6FQ3MfktvSLxLL/KzhpBg2plFXgOz4oNf6eGHPjMQ+c/D0BQxWlulW9LtU0cw4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:29.5353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97044896-eb69-492e-9d06-08dec24951e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Timur Kristóf <timur.kristof@gmail.com>

Link detection may fail after suspend/resume when the display
is "slow to wake up", and it may happen on boot as well.

Let's retry link detection in those cases too.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 40295a5edbec..b19bad9fcd12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4010,6 +4010,10 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			if (ret) {
 				/* w/a delay for certain panels */
 				apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+			} else {
+				dm_queue_delayed_hpd_work(aconnector,
+							  DETECT_REASON_RESUMEFROMS3S4,
+							  AMDGPU_DM_HPD_RETRY_DELAY_MSEC);
 			}
 		}
 
@@ -6038,6 +6042,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 						 link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
 						 link->dpcd_caps.psr_info.psr2_su_y_granularity_cap);
 				}
+			} else {
+				dm_queue_delayed_hpd_work(aconnector,
+							  DETECT_REASON_BOOT,
+							  AMDGPU_DM_HPD_RETRY_DELAY_MSEC);
 			}
 		}
 		amdgpu_set_panel_orientation(&aconnector->base);
-- 
2.54.0

