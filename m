Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D34DFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3B310E7A8;
	Wed, 25 Mar 2026 07:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vyXl+tBu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7772510E7A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scGjetHyofbnlidDd4ELGOXVKpS+PqxvKMaBjnpxS5m36gzvUbbwl7OA8DgB2JAb6vmMwzIhfcWvZuxGUhLaZtbv07Pugb7joCpVoSg5poNwysn0vuZFY9CfjSXm8SfeBdUuVaRuWw4HLkrCW/6EIeuWPuSD9TFiOfG/Em9w/LzmGRiLt09kYM05gJbPMUT1jpBqsd+fixPgmrxl8qzfqZAwWWpiets5e0Q6FMn/bY9wSBpEmyZBsdoafo4GLUB5/9yJpW71jYUQdoMpKbM9/KknraSjPWS2kB/WVnAVelkkzPgLPro8dCZcdoejCS2AJevFZ1wp7YzMcaWwPI67QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9lxaO06EAltrr+hC7aZpjat76cT2d4+orPK6jrMP8Y=;
 b=diL9TqmqU1JuqF+6UDLK7mMm6F9hWzImWLL4Gy/h2msbxSwY2Akb7nyMz0QfTBlS9YNJF34Rl6mYC1LBm3pxdVfYOxCqkkhCqO/NQqy+bQCuC9jgGrKLB1Mt8H8xhRQwoEoBdqy+ugdm7oyCsCeq5j2Gj2etp/bXN7Md9uBTSOAf0vpUhQUtdLG/lOJN78CWZufMlQrbV7Jr/x0Lu7zvyGYrkMKR23ShJAqQutAivErZNmJ6hbqZdJoIq1/fjbNt3RVD8I4dNhjXaZb7JUMyi44AkzacLeIsL11FeZ3AjqoNLm3TC8u5uWfM0xti2Yz5He5mX8j9pvXMSg3A926udw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9lxaO06EAltrr+hC7aZpjat76cT2d4+orPK6jrMP8Y=;
 b=vyXl+tBuMpQuk1o3DzAyAg2oW9QDdIGN3lGIMP4gJUVrn4yUBKCsDJrxaVRVEi+c4D4PEzCNdAO9DBdKTo19uARzG9uV68K0+XnfHP8S3CRpuTDo9oghrwPKWS/Y1F32GHo4qwxCR7fEe9C/VPuiP1UKhXejHPryawszISggu4E=
Received: from MN2PR15CA0039.namprd15.prod.outlook.com (2603:10b6:208:237::8)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:28 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::e3) by MN2PR15CA0039.outlook.office365.com
 (2603:10b6:208:237::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:28 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:24 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Leo Chen
 <leo.chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 14/29] drm/amd/dc: Disable PSR & Replay CRTC disable by default
Date: Wed, 25 Mar 2026 15:06:20 +0800
Message-ID: <20260325071003.4022594-15-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e98d8d5-936b-45d6-8f4f-08de8a3d7442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: K9msYdMxYpukNg2Yrhq7WJ5P5FWMrI/bURng7MG2joDDN9a2wGGEhppxnbHLs8zYiSrbiZIWjdGOygL4BI3to95VAZyI79EODPM81GQ6d0hwWDj3PK5eQH+vMDlRDo4SSm51tVxmLbh+24vLivpw+dDk4XC22RFWbChqa+Dj7g56raQHtHzkK3JgoP47Jgg/Y3fzj7Z7bD/rplH6vz+X3NkldMpA5fayYFOTJBU1prjWPXfKTeXBcDr+EmIqyj01ZXHPbiZ2k4+7t/EYg736D9s/i2arEIlaFNBM6tQ04trrjk1ZfbtpFVnI/2aVIXdRBM+SxK5o2Md52TxboxNeaf/4TN8QOVLuUzWYX2aWdg4ZJgmLEWtG8PqZq2YBYfjmudWfS05TV4EBi6Ft4gGjBOTQqR/FLpFytfwtbjMC0HKdr+JdCgo3oC9hlQynFuI486qctCWKswqZcJh+quFHYj0fpMNm/oW2NepH3F6FqSNJ6GL8o6monSlF50NaYmDCWdQEkWJZcO9logHqryFCIH7fTZAxNRZbUCeBpQgGhVswxM1odTwwJkGITeWXGYaXrciF6H034ZgPBzAxSnMtdDc3m2pV2J2nZzo5jgwWss3RUbki4iFbWeXmwh89jrgI5OfVJt+LwT+Nl+gklK6vZn4vydSOqqns0v2kVbvH/eYlBDgoeuhp64ZQ5SaGxeglQP2Qcjb/k8fFXS2/DqHDdSpvjZtd8ojPaK6shHUXQ83yOCKVvavqFD0wCdzQPHFBQcREW2XA0SjyuNWZ0ZkCLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c2gr1dJw7pSg8/V8Vx4dVxQbiLN3f4esSVAjGLpUMCVe0vUfjHZapQzU3Yery0mnmJq8DBMkPsh9EYeTB3T3x+XP5+v86LM9A541hylyyRKLkH8AUQOToudmRj2UNha4klXCJ2zMN0nLQEob///tYaSJ96ce/oLPncBC+VzoP9K9lPYyUPBzhk5ueMjCFACzy4dLTsJ0OxIXenEPRFM5JGdrXmCRWE+uf8ijuwnCL7qd1hgI3jAlWwdivQQdidL3hwAMZ/2yH7QCXIUq5VYBLlo3LXtgoy7zuYkQMoGm3aEwlcqjUFKiN+nBMH3IPr3o2HI2sGeydKsu4ZKGCpkeF9xAWswNxyaf0UwCTrSO3RyiJSDO38+TVqYH2WDuu+35QN2RZMEiF0iAugpu88QMHLaBgP0T5YY4TCdRiBdu3sKGCiqYw+RrQ6fnTtiQj4zJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:28.0990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e98d8d5-936b-45d6-8f4f-08de8a3d7442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
Let IPS FSM handle OTG disable.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 11b302c4d06f..f2a6e260f061 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -761,6 +761,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.ignore_pg = true,
 	.disable_stutter_for_wm_program = true,
 	.min_deep_sleep_dcfclk_khz = 8000,
+	.replay_skip_crtc_disabled = true,
+	.psr_skip_crtc_disable = true,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

