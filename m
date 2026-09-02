Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA65C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C80EA10EFD1;
	Wed,  2 Sep 2026 05:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFC1y8Dw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50CB10EFD1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRLMRXbJPLPQ1YhC7IcS5JQKbVx8w8YgCmr9guodPS746m9WgtF0VzDnKKpnTmZgYFgJvCO5Mmz5+C83MaS3QaYHg71Re91F3ScZCi1lBaKvMIS/CETwrw2pLu9xmHckB+6ws1ip5lupB3aXXvA0Xm2eLDL+q1xApApqA0pppTEwp51dQHCrPbgc6KmKhDDMW4PEyw2JMyI0CerE7/nBO7TNZRKVXxQsxvFmb1NhvOIUc1Wj1SqKFzlpfP//UeO3YXt2wxDx0gq6X/3zdspRvRgFsuX7kRgWylmS6Yxzo9hB+MnkokijVYobjLhVboBX4wQcNEgn86F8UEIJXnYAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z+lrkg4GSKdjqB4xuQbKmPbUO6l6dMoOI+LqF02Qgc=;
 b=e4fAsKm1WxHoVPOq044EQ8EKylU6TqA2rQowK9MbKI0uwSUCD9gKwafUQu+KR7rvRwQKXdTbu3ahd01959wesJl3qWl3oiap2I+mooELyS+FVl5VCPCYn3CNxesiifTGMiZ5bZT2zFCilDCC1Qxv6Q7W51hAIsneGBX+lxq+6069c+9BcWexFQrY1Afg2Za9tcmG9NQBZJCKxBem500rpHjHPN0GHI72znvRHxXwiBRyfxWhQonld7SfUytzdqCEMwt0kFtwEyigzp9AvwLkkP6EsV/BxkSqqter90jBxtE1h5gXLYQrFNdg1DnlCT9dnl14BTnDzWA9kbxeGlH5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z+lrkg4GSKdjqB4xuQbKmPbUO6l6dMoOI+LqF02Qgc=;
 b=NFC1y8DwgOFFqaMWAp/44OnIuDFjx+otLou43s7fLItev3xeVtlmS4f6hGFOEJ4oBaF3K/oxdpVPJhWbBTTKPguMe9ZvlllgYeBse9GY2lHNq3YiDWCbSTo17WUvkxAjbv7ycYLsHt+TcEAwdXyc2r1px0ZK0GSu6qiX8ye9mX8=
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:07:53 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::a6) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:07:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:49 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:07:40 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 23/40] drm/amd/display: Enable FW locality check in DCN6
Date: Wed, 2 Sep 2026 12:58:45 +0800
Message-ID: <20260902050411.3473916-24-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ecd869-a9f1-433c-9c92-08df08b0245a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Sow2Q8md0qpZgSUbIMX+mAUUzCba7X+KyMj7jb5HeqS4AEwj0yVUf515VEKrGJv6SBZaKdDRpj6W4WMK8yTW90/Cl6hjSz+PGcrKCr7SEaGsGhgo53SViGGigvd0h41wpijaQE36hHG9D+Q2fbJ8fgCZv0p6jIXm1Hhp+VVLZtFCY7hwDqH7mAqDY/Hu5BOcQN9V656d98opjgHt1epd7NHIck/ZAmJdtBJF0wNHlMcts1PeCnDWkH0eYr4iOuCcRT6Wk3aW3VPqZ0A6b0ibmmSQ4F+bRWlt5chx6PzAn7NnFJfAhx5qSjPhAR2ZS8LiLHQTMyUloT4ajjbCzgg3WJLEJkbHK53Pz52o5LR7zvbvoxNu9izRoJgOMOVyE/1Og0AnKlV6WHhB+g7fNy/kC2AOGWsaUyLlf5kdsM8eEsvUDT0wJ/ML3wDM/I1lxtHLmFHmDUzrjmpnhP/YiHrfMgmr6pSZpFaud+UOBY3ETuY/FkCtJN0Kyb1Foau3LwHWq0y8EEqaQ3Ysg1281LfHrRCctFsevtGRJSnQIFkrryDhYq4iC4IJkeh4rLcVe7ewJjFK26URfucr3RRiRiADuOo1THKQR0y7zxHZ09P1Vl/IjXQ89gKMXhkzrQF85lXcQ0X0fZUkcLOsYQF6EvUUjcEV80bY2FSMyw7n9rigOXD6velmMIxH5whbB5T33eadboqyG7EbREDsXOda3ZKuJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2zoHqdSapr/fA1d4r1uQFPTpjU7bB/L/uz6OXVWq/Pc8L26U69dxidrff1tF2m90E/wLGjRELqS5nRiycZ2P+xVeo25G0DXKTYFIOELc5FKPTI8WZ16b+yMquZduwbOcE9HCGk9hTNhPpj5OSC2CbEMBM6FZe6X+fOTKmLASidt+XSRFsbj/d0p+BzVK6YZn0lYxw9gts6dhiSyfrJ87tqc1F2e2oMugYK4Ia1N/VO7x+ksPObHVzdWW8bRws/X5m0d69c9Bb0iWRCXcFBymf7iBlSkwU1PTbPDRy5iXG9b1YEvUmMtOFeN0iZGcGOE84hBd6BrezZSFrzoUqib1cDt0c2u11Iu4Bux9rJZgUhpHgD1XnU1dpeJMnHgY+20cOJ1zzW4DvZrb9zL9b89mctd6X8/CweFK5Ln6pmqLLxTgKFV98VhAq5VFyPo6OCGe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:07:52.6246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ecd869-a9f1-433c-9c92-08df08b0245a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
Enable FW locality check in DCN6

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index dff51b641552..b52d2179532e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -2111,6 +2111,7 @@ static bool dcn60_resource_construct(
 	dc->config.enable_windowed_mpo_odm = true;
 	dc->config.set_pipe_unlock_order = true; /* Need to ensure DET gets freed before allocating */
 	dc->config.dp_connector_no_native_i2c = true;
+	dc->caps.fused_io_supported = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.43.0

