Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A76CD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14ED10F484;
	Fri, 22 May 2026 00:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGPVvyue";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD4810F47B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INy9SihwHD8cQMNzqhjP8o47aAbUqHJhPuq9cM5xq3xsyDnXnIAcVmPH1AHxr8/cwK7Yb1EIJXll70RqC+EfZkvziy4naHjEV+A0mEY1EPfKIjWg+Hhc3rMaP7iywwK29kkqp7m3sFCGA9NmDY/Xpgx+S9L5Xw8JR5WXG1nTAf/1cJwFl2lm1b7Rxh2mAoYCcgSoUzGBF4P0b5opZ/ZpGWAl0LOdNX3DdXvkhcr/E7K5GQ6BH20R7AKLDtwoAs1TpNqhrvJ4OiEKdBFjCHj+tYNztk2Vk0HlL/MZxuOnSIYAqJfLqUv5aIztVBKPJ5wECo5n/PP67GoqooPQRKn+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8+a8+tz85sgF7ekcpdN7WTqLk9bnoYDcPpzWdXRuxo=;
 b=hHx8CIcPuG4yHJs/51fxWtjBMh0b4NI17YgMx414pYwin+MQfDTz1nZGuDqjIOFTHMyjU+lFSCNQ01Yb1sdI1r15qPnX9ou2nr2dEDs9t4nUCkmEBBZqTLg1gqjJmePlDKTTKw7/IzvfbTSrZqwxy0Lsstc/g5HRgH/EeP7HsoA3t3eTwtj5wSf7m2gmoOby9lN+HEoNexi9celYsfOKVlGXDPfzLuXuAQS7l4VDpTsxu/CQaX/h3sAx8R7aHAdndwTVCls1VFaMysytPl3f8vq6tUyAy6kT+o/TaETNqT4UyyxDigpqnz0jo4q/3S07XunWR7Z9U0URwgkRXr0q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8+a8+tz85sgF7ekcpdN7WTqLk9bnoYDcPpzWdXRuxo=;
 b=vGPVvyue2hIjb+iYKKyIMg4I8DrpF7NdKR331W7riy8YGqm6GfqO1bYC3ev2H9dQacp9q0O6cf4gpx5Q+qIvMw7oiHiUXzUZe1crHTrz0DCXWYQr3xDPwA0u+FYDwVBIb1VEnEWdANEtypfacVZUcE/AQ91GTetPzEDIVoVnFnA=
Received: from CH2PR15CA0030.namprd15.prod.outlook.com (2603:10b6:610:51::40)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Fri, 22 May
 2026 00:22:09 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::6a) by CH2PR15CA0030.outlook.office365.com
 (2603:10b6:610:51::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/42] drm/amdgpu: Allocate enough space for hpd info on gfx11
Date: Thu, 21 May 2026 20:20:31 -0400
Message-ID: <20260522002048.98506-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 260a81da-5247-4f6a-eeac-08deb7982953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: lo8bebT4qFPkfhLtyVNC5ilRuZlAS91Xi05kpwhjxx73Imf7HQ3/4r7LnqGSlF1zRq8PcNgDhMJ4rjuUvj4fdR8bEyF54NyG3Fioqu184CMZLOtyEenvTnk7YGhEgAkVF/h8yvqiKqmc1cEBEp3v9kfNMkbMRz/lt6cIZ3j6HGQ+b/7LdMJKFTOavysttlddmEKmPT5t5vqJkQCdzPTtJPBPGxRgkinTD+GLvI97oC4+HCdVWaduqFaKenuQ7CkgJRUGD0oKb6+2y1O6MN+g5xaT3R0967GkU8RMbpTBEyL9IwTe7Ry9EhrYTTIt2GpcArSoXL+YfeHCAqEImowQb0iVESixPdjs1B58B+m5m8KPBiTYx2z0pMNui3opb0R5G4P1DNleYwhoGc1IZUeW2qHV3G+AVnKwQax5t0XKayDmRsI4F5GG8ftNHS7V/Ryn7Vw69Vooh9OjOlGGNqpT8YHfgPGBukEWLWYS7jxKoo11q9rOksSw1g4JztVc1OM614+evc2y9DB0ZD4B6mESGaBMA1dg8HHdE7vPbVxYtzPbMYp31AS+O1LPPPs+jlg3w1SjZxGSR14Ui4Dls/Mt5eoNws07JWuXV0U5nRgjXJlBADGQFP+P+bnoEep1doWBdqtXUGVxI0F0JjGbSdwsKk+9btoekjTjc5QJysSV7ZH28CmlCJ6oPcAQyDLoWuAuXu/yjJsM/Gjo1JxTVAwhpcsejhyfcTOKDrip/d4ns6c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pfsu82MftAvWXPoBYH/foAn5ZvAhCuL4kFYC3RsH6J64YsdDcSVfSnjJ2oA0R6K8y7YUqkmzUjtsmZdeH9oVZ/O1ludSNscrRKiZ5iSVHys3C4OdcvD50LA95ar1UdAyi/sqclt3Nd5VnEEJ4jMhJEeftG3JC0rULrghkpboIFnNRtg3vT09MPrM7NOgiEbMxR/ASiKvnE4Qc0Gzx7gMWeEDKFeojpglPVJY8LEcuKqp1mut9ZAPbE+9JpsCx4yeJCaPOGCDh8XrJaKdsooXYDKrhg1mB70ml7xCsqCGtmuAZkg+60e3lQga7jrwF5ULxH049IGPHN47p2TSnLtoe3DyM6CpO4UjzmTl+xOmwi9F7xD4enF+4mf8D+Edhoyg1BcJ8ghuQlpldG/dDt5Jdti2FG+yGsSdy8dq1m98mq8gNPcMAHIjAopazabkTKmK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:08.8721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 260a81da-5247-4f6a-eeac-08deb7982953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
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

From: Amber Lin <Amber.Lin@amd.com>

MES in newer versions on gfx11 and gfx12 can support queue/pipe
reset via MES.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ad1b620230a95..370e8d159b6fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -217,7 +217,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error_doorbell;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 1, 0)) {
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
 		/* When queue/pipe reset is done in MES instead of in the
 		 * driver, MES passes hung queues information to the driver in
 		 * hung_queue_hqd_info. Calculate required space to store this
-- 
2.54.0

