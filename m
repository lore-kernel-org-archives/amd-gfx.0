Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39E6CD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0030510EA65;
	Wed, 10 Apr 2024 21:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n6PRgoGk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3818010EFCF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmjHrf7seWIlhUD6xCiot2+rKj36mFWSPr4gs9243Z5/FZm46xueEvjNTVesTMjVnxfYoRaSobME85LyGfgyJVbdU4s5i90jhT8JSCCti/JanilrUOucJRuqKfkPC89yL41dPQS0rKBTnCOTW7S/F/V8qQA76APlybcZ0Ga0TuWa+Nda+I3Ocdv2GgFckWVukfEp1s0hPRdKOy+Lild0Owd/jDt4CzFbq+x+OMhVfOdZ0Wca5NnqTmY+Sx21dW7je4IWRTHXSphb584fUtWWlSu1eBVs9Y5f1djjatZccbedE1xletLXAErxDYxzHhfivynEbO9CRG65i/O2LskOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnT3rJNRrCpRqlJL2cjcUzuHToP7On84Z4uVOq9UxzE=;
 b=AAn6Bk+4dWj9nlPhw3gRUaOPxWm6e3VCHMtiYPNwYQHA7W12OSqIjBGHhe0tWGvKewQbvYMgyZ168vIUDaBqo1/XO9j1y5XriJjkv+mn93Zb5XRV5OHtL6SRV7VQNyjvrYTEqqZblj2nOvcq4zovyMXfvXWtUQnC++Nc43yPfTUsoopLhUUCUA1gLuHsATdsWDbjvP3h3MVlMzFLOwNTBVmSHzWmGHVM3DDXC6UE+EQXgVnGGCfTI63I+xm7K3PBRubRIJglwp8Mqb6gtw7/8Rrdv5c+ia6e6EIca6YV10S2bmtt7Lo882uZUOWqUm+N6KyP4erCuP4S5ROmxrdbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnT3rJNRrCpRqlJL2cjcUzuHToP7On84Z4uVOq9UxzE=;
 b=n6PRgoGksqpQkzXorEpTr8TBH6gQEwZa/1RNICRtNqTsSLMSqaXl/PMISk8MLXN72Y7J3VUHBORzbjKjzyMdZ3YauspQ/+bDV3EDD8STmdgYWOeE0VxaiigXu6xb+R1qGfeqn3cGgNNinduSNf7/fN0ycgRBFTBlcGbivLl1sbQ=
Received: from BN9PR03CA0252.namprd03.prod.outlook.com (2603:10b6:408:ff::17)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:02 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::81) by BN9PR03CA0252.outlook.office365.com
 (2603:10b6:408:ff::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:01 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:27:59 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Sung joon Kim <sungjoon.kim@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 06/25] drm/amd/display: Pass sequential ONO bit to DMCUB boot
 options
Date: Wed, 10 Apr 2024 15:25:55 -0600
Message-ID: <20240410212726.1312989-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed3cbaf-eb32-434b-a5ed-08dc59a519db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVYeYF9VeWu8WcZfYo1NZUfLngv+YswG1KrrvmjR93oCBS++fV/LhdApxAgkRRo4FQlyKIiIz1KgT2a14mRFdbW2xTQKcnYC3UQLnyhC0M1SpByVsQhyNRn9gMYIY9LOiGWE6K6HVG+LhIOSLvSb2gD/PiGHEMuPnlfoiTM2C7g/mV2y7TJx3VNq3zECGKW7NAxShcfRdQ+Q+PMsO7yVJ/m2gcDGQMSj+SGS/wAFoejE7xPV3VKfLGsnLJuJTJvNyA8dq21ErQsZVDxMKbCqcNLwPatm6SUesWSikGcvlW+mGYQHL63DzDyoV8ps4naGo1U+crOmnZqgEhql2IV46oyAegVQcKGmms2mFitCdwWWB5ilcnuNE9DO7LAsIQIXHWyTklylYVUQxj4A8eOTpJpyMrzcReAYld2tzMYRR8xiaH9mR1XQSNJBlcyTDjDvi15t/e+VNIxz0CWUitTNIzJRGKwX8fTwv08O0gmeH/V+EpAwL4BFKWo+toB9K+F3WE26+b2slsFn+df5IONcMafNo4byEyWHrlDiB65miheVN84Y/X5ykjgg2bF1aqJdRt9egbduHH+UeMJO/MDktcizyACKA6zj+/tS5+ZV2HZ3PY9vmtLig8ix8chOhLfdtTwrTeGdBmnAIAEUTU5XiOS+DFoa6ESdou5HrFNIL2Ub8wrvIqeHhJvGPCNYWHuW2ec+aOLHj/70wfBdXjAuLeA3nFXf/QTTOfAsUOMj7OU/3uwKIh6Kt+RqVvTjdDAZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:01.6350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed3cbaf-eb32-434b-a5ed-08dc59a519db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
IPS ono sequence ordering differs based on the ASIC.

[How]
Detect the ASIC ID revision and set the boot option accordingly. Feed
it through the DCN35 DMUB functions.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d52701f6d1d0..2c06f2bee4a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1230,6 +1230,15 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+	case IP_VERSION(3, 5, 0):
+	case IP_VERSION(3, 5, 1):
+		hw_params.ips_sequential_ono = adev->external_rev_id > 0x10;
+		break;
+	default:
+		break;
+	}
+
 	status = dmub_srv_hw_init(dmub_srv, &hw_params);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error initializing DMUB HW: %d\n", status);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 662bdb0e5d3d..2fde1f043d50 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -297,6 +297,7 @@ struct dmub_srv_hw_params {
 	bool dpia_hpd_int_enable_supported;
 	bool disable_clock_gate;
 	bool disallow_dispclk_dppclk_ds;
+	bool ips_sequential_ono;
 	enum dmub_memory_access_type mem_access_type;
 	enum dmub_ips_disable_type disable_ips;
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 98afaecd3984..70e63aeb8f89 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -420,6 +420,7 @@ void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.disable_clk_ds = params->disallow_dispclk_dppclk_ds;
 	boot_options.bits.disable_clk_gate = params->disable_clock_gate;
 	boot_options.bits.ips_disable = params->disable_ips;
+	boot_options.bits.ips_sequential_ono = params->ips_sequential_ono;
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
-- 
2.43.0

