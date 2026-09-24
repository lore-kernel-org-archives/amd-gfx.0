Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924E6C98324
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23CF10F727;
	Thu, 24 Sep 2026 18:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qm7AJjP/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9007210F720
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhu3ckAtaZDXmFsO446KLXR2TU4XAgDpgtOdrOqFFHx3zLrUJaZwaASOfU10oig/3iub7zTBx3aLR4qg0dVwp8ICkjWZT2NXUFFIUUFMSzWWBGRm8b034ecrmsWULNercK5NYhOd8+xp6at0NmGEay/BDIcouuCBOn5tXy5Nt5oUywFusDjlEHlfiwbzPk6aZDHvlDfVtNZFheFwLf92Q4ETIdADeUkchtpFcapGJVnlkewTEUGvZlcHcamNvLV0b5vBh7Gvr1PphlkAfiFXJU/kCaEeSq0pTQbBIPlWJmYYNnhlN1RKQLxcPqUxYQZcP+DcF4SiD9oi2WY4Z1krug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcxjrc7lHio5CiI7WdxWBXP6nwAeqq6paAx1fNrTY0I=;
 b=yESSqcjmPlJ2Ub3yDXiujU3jQIvpK3bzWDHHwNwogHMyaw3g1D33DGbkdUmMI9L6ZNIZpOTcryBFR8R4XRQWvSBUlbQI93ZiguZYh+zL6VUQh8/av++2ApWJNpp28GpZLNWHV4inq9NgBfZdxqjMFsXmhkGcL+4GIisLq7DKu4auklMNvpzSdh0ujN1OCmRcD9pWic6eHh332AFpIZmetSIzFXQFSqn4DEUcLq3FcWvqSoFnWIheCXOGY6uBUTLXwOJoX9j1qXqWpXdWLEiUCaKSTVVLRwtPT86BxFg/8s9UtfFhlN+xp41sIOuVmEQ+TNNPzq4niqanYD9A+ZbTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcxjrc7lHio5CiI7WdxWBXP6nwAeqq6paAx1fNrTY0I=;
 b=qm7AJjP/HfPOZ1az1VcGh4dR53yNbsCrFWsXdNBPfdI1/ghXel6uy1DCiXQDgzWechRRR1c80grg0kPg2BrHfQ3lMqVFhGa6++a9Om4VNiEUxk0ieE3OU2C5GywJWFQ106cFSL3yHdvjYQG7R8y191EpxfDzRb+br7qKV7Zxt3Y=
Received: from SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::14)
 by DS6PR12MB602245.namprd12.prod.outlook.com (2603:10b6:8:499::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:18 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::3b) by SJ0P220CA0010.outlook.office365.com
 (2603:10b6:a03:41b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:18 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:06 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 07/34] drm/amd/display: Add dcn60 revision specific clock
 overrides
Date: Thu, 24 Sep 2026 14:45:20 -0400
Message-ID: <20260924184824.596894-8-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS6PR12MB602245:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c95d81-664e-438d-2bef-08df1a6c1edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: eKtPVa9lHLy6TCZ8SmwyQhb8bGE/Ao1ke12SsPF4GLMrfDug2t72jBQK21QfMoMpvzAYcJAxmgdakg75TWmToCylYiKDVx0pRUB77lA5H7eTIUPw/6UNPWh4qxxtgEvUCkvQyWEwEoU8Dfvc/9ZqY86QvLfuDJ/6bnxCfE0+1iCr+DwGhEbjoPGx9LHTuTkD4pn4Qnvl8Kf7B67KORuL/0/fu/1U4rHv5S8LtxVtVbgpvgNVi2QG3eYfPlO7jaWISjc1+4qKYeLa3xdDzwmXzic4rOdc4UsPplrHB7tkNp9CO31BZSvHUzjMHpCLdPARdMZABv2rJWuAURCSde1TaCtRDab8d6g9+jR84wE+uj6vNjH/5F1FKAsvxqzURwriQPRN9A9ekZSJSYlcPTo59cpjHfPRjlsaCOLRqrkWqdxZSNImvWEGeQLazAzPEgQbKc1f3tePGDxW8A+AvJF7k13ryr9zde1I7EnnENuAimkgpU4cS5Tj20enhJpmXEgKbRxre3J2Av4Dc3iZQfKPOrGNxSguVs2q9N38+UfAiVKP8KRdqthZKaLSSsnhXSvu2YVeda37UK2Cr/IWdNdXbVaO+T7AyGGoIU1xZXjWPQ9HH4HtDKyIzaq4tZh6FkzNNxOQOth9m2ViXVSEff0/MK2ZLRAJG8Cyl1EuzNYTosiYC85OLSlb9Go1Y6l9O+cN7jjOwibQrRRTDkPefkRvvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q32tS0N2VDtWJnDbjDVQjOdQjR6cPA1G02hR5+e2OzTpgYAR81ooav+wuwiH3h37Eym16foYdYwLT8INi4XxPq6khksmtYTweYpEEVj6ilqZ5tXeCICWp5twNycZJWOo5/Xy1diVN6/1tcxR2UfAW3emC1z7+K67fsFVSdV0ZyNaqkf1V8t30+zZ8p4ib7djDXc7yKrjlTzFkqN+pKOUlPS020BmOIQR1+xOnInZ6AA8q9AaTuTF3ePy0JP4iZfbE6X2t3Cp8q5Y5Qu5xf6R9eucjjJAitU1tNwiQlF1BWKdtyyFald/ajxl7FaFgAAK+mRHPINulTOXHf0B5VJJdeNd8zBYxkmrmjjl/iTpUNZdcV5mCkJOv/UtuEZVC7LbrRU/1VSUiz8z0VW6qtTzYfHzfNwi4DK+YicJp+r0R8BHH/CTH8hU5jnOfKvW4dkS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:18.5170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c95d81-664e-438d-2bef-08df1a6c1edc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB602245
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Not all revisions require the same clock overrides.

Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 04891ae776b6..26972c220e34 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -729,8 +729,10 @@ static void dcn60_override_utm_qos_model(struct clk_mgr_internal *clk_mgr,
 static void dcn60_override_bw_params(struct clk_mgr_internal *clk_mgr,
 		struct clk_bw_params *bw_params)
 {
-	dcn60_override_clk_table(clk_mgr, &bw_params->clk_table);
-	dcn60_override_dc_mode_limit(clk_mgr, bw_params);
+	if (!ASICREV_IS_DCN6_VARIANT_LITE3(clk_mgr->base.ctx->asic_id.hw_internal_rev)) {
+		dcn60_override_clk_table(clk_mgr, &bw_params->clk_table);
+		dcn60_override_dc_mode_limit(clk_mgr, bw_params);
+	}
 
 	if (dcn60_should_apply_temp_utm_override)
 		dcn60_override_utm_qos_model(clk_mgr, bw_params);
-- 
2.53.0

