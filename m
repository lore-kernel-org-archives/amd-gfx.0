Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E11C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 14:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F42C10E677;
	Fri, 25 Mar 2022 14:29:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1591410E677
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 14:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCdWf+ew2OgL0Af2A3xg+ONomxXXP9wZMTDAdPVGS/Eo1KzMiWcqfh/vDPyDdo8h41KUb3/LObBhHPtqnYuDdvq6yTL8XNknNbnDscovEwKXNE0JkbTXGzqOQAnRBgv5pWkAgecYg0gPDz6tVJX1CwSh7JOTgbOVX5xSVLZT7//ZKt+EUUFB9VDS2QfK3DNoKHxVZBypEjbAX5BdXC3KR5xRRYzElbkusiiwoGMg//QB50qOnH1L3kMg4Uik/aGoXRCDAMIJGAAPG21Edcb+P+RzTm0xzYtqV8H2NN8TpHWD9v+9GMXseaD7eqbWY7cL/cRaL4bQ1BPYFGfWLO+gxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ahxtyQCKalTRs3r/HkIf/gFe/hEwJ3RHlI3V/JAPJg=;
 b=jcNYezBktzJv5TzK02YVZPyGZJ1ZXgeKfV8+9KozkNFZLFpXMez7sgeS5te21BUVu0Wte/hpQ+fdpvidhsjr48AI1R7sUMid5q5gsQWaUSfHS63BA4Lm94F2NyqmEaThfg6QUaeWL7R2s1kpewkyKwBfv7FgRF+oWupugyX6j1/ZSECw9EZxLPW9tV+LGIgpAz2oWZkSiC+dAUm6G6g8Ipdweb/0oQAXmF29wRedMFH27ocJJ453d/z1MHyeGpWxxGRLLSTuQz9s7XiyDiBVSZkaixO3IqJupttOzM1eadjmlIDyY+mmS+Hn18JkMUTaa7R9gT/3+RQw0iD2WjZo/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ahxtyQCKalTRs3r/HkIf/gFe/hEwJ3RHlI3V/JAPJg=;
 b=HTaEFZq5luq7ERyNzg1evEBcxPcO752k5ul0ACVHXE0DMie5uByrahGRZzl36Fi7FpedSPbq5fsEkcNIJiDf4e2rMw/z/Rn66/82fcHijUiKQcFivJrBAHylC4so/9Zi3GmtNna/lXU/etjDui4zqD3RIRZg4xXnIw/uP/URnOU=
Received: from MW3PR06CA0018.namprd06.prod.outlook.com (2603:10b6:303:2a::23)
 by BL0PR12MB4740.namprd12.prod.outlook.com (2603:10b6:208:84::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 14:29:22 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::ad) by MW3PR06CA0018.outlook.office365.com
 (2603:10b6:303:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Fri, 25 Mar 2022 14:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 14:29:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 09:29:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 09:29:12 -0500
Received: from amd-zekovic.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 25 Mar 2022 09:29:11 -0500
From: Marko Zekovic <Marko.Zekovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Enable sysfs node for pp_dpm_vclk for NAVI12
Date: Fri, 25 Mar 2022 15:28:49 +0100
Message-ID: <20220325142849.2541-1-Marko.Zekovic@amd.com>
X-Mailer: git-send-email 2.24.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5d295c-ba2a-4634-4803-08da0e6bdab5
X-MS-TrafficTypeDiagnostic: BL0PR12MB4740:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4740AAE1C08797AF61D3417AEE1A9@BL0PR12MB4740.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EtUd/lYU7hlqnVIA+EoB5bbi35IovRgjRDxVtGBFLkSsHh2/PSMaU9DaTU992CsPcRMWW7ARHbZh2T2fIAeyhgwspC1afvkCUtwnc+e1x2TEYLev8uWRP7WSCVi9Hf9jRY/g60JIQ1TE8YGI41Wx2qmp3TFGzHOc0kHmJSzwCf1hyJsDp1fakt9aNY6K0yr5KgPVlD899mM4RT8F8SVQQ8f10hlvPLsyyM2hgte2dJY5W51JxIRjvv7Sjcmj9Z13J4L4xdR9IyyFyC8UlNLaFLhnmcDk8vlSYJojTSlWf4aQ3En9GRjoTFb71w/C1FmUATp8hPLPJHIGnXB2W3rcdSFG55JaqHic3sRAR5BqXSGaAirKQb9PDEJvcg5o/GzI3VLEUMjVMCnVVsi0KiR00BoOScCWFNopw4k1bwRdNHxaHH/EnXy2fXSk/zgPTNgreCru2w8ruHwEMM9lEnH7YCMVGQckNe6yAKzoOIS/6Ef5VtCnCh8tOYRIu645RPtddPR4OzZIu9uAOpgxFO1jd7yExQTJ6wN69IBlfat8OaACdeyHo+oLUcpEfLYwMC24JjqAeWd8lF3oGx51ksjSbP58zo2mY9ZRW3xZJ/6mZPTYxm6uqaKhE4XoTYHVgJq3xgc4+vOJFxbIItcG6zPddNb1zYbs+8iy9lBPsQKJmImQEAUYs7ycgjEWj1jCSsaOox2ulbkm8WdWdv/VAjHP1LScj/JDXmblirGoTk3GxPjsvjWgDxEaLACxespwX6a1zSp8fBoPUbMnCt6PXcskmoeNwRFaVQuayWOxMdvyXA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(86362001)(508600001)(1076003)(47076005)(316002)(426003)(356005)(82310400004)(6916009)(83380400001)(186003)(26005)(336012)(5660300002)(36756003)(81166007)(40460700003)(8936002)(36860700001)(4326008)(6666004)(70206006)(70586007)(8676002)(7696005)(2906002)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 14:29:21.8230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d295c-ba2a-4634-4803-08da0e6bdab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4740
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
Cc: Marko Zekovic <Marko.Zekovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMI clock measure API is failing, because sysfs node
for pp_dpm_vclk is not existing
Bug:
https://ontrack-internal.amd.com/browse/SWDEV-327254

Signed-off-by: Marko Zekovic <Marko.Zekovic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5cd67ddf84956..095cf57d73de4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1999,7 +1999,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (asic_type < CHIP_VEGA12)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
-		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
+		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID || asic_type == CHIP_NAVI12))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
-- 
2.24.1.windows.2

