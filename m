Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2F2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 06:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F0F1133E5;
	Thu, 21 Jul 2022 06:20:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D1B10E75B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 06:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZdbHSbTT771GyABOGpG0Dk7bLnmBwR/f8vlEatfn9nM55o7cXgfAA/7zmpD+dlHDE95Dj4ZdM5MsGrb0wDq7Vi5lnH8k6sn4uj/K5fWx4zodfExsyh1Zn4Yc39fcsAnb4XWDKKnWQ5Tp54x2hkhvlunX7TsK94N/7ACvawmsSJoin5z4shJJ/Oe0ZNivuIVm/2f7rp4xsq2bQe385MAyT9YwYwJ4X0MIHHZHxjbSIxnO9i/ssm/KBu+1hvK98zNZKSb3IXoBKnOmn+VOnz1e6NjvPLWAUgJaeKjdbwvnIXw4WdgiLvF4vMOuoqkseys0I9nmGOujPUs289mhJsGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wAp3ebO0agzH5nWf4kvUMNQfn+ditDyIPsAaWbWJCI=;
 b=Kag4A5XkKTaa2TpU62KU6ioEfFstq2S9tAe7nEIZwi/s3jqNobYOtU36yqrwxtpLArmNotauPpcCqniCSyiK+1yLMNfyuP0N6w5A+cRpQEAw/LxTeF2HzAPzFR+jDCqoTvTXgJpbFZCoK+kk/YLdMc9MZ05IqOzpKal1dLDO/d+y8K7Grw8HBfCtEa3VYs9sus8svAv3hiDnf88V5sZV1WUJgmwvPESs0Lgx+bHeJyeDpFTheUYNEIskGrNmEGsJpwocXabgfT4yUl7yuk2yOpCOgGJtNNh8BDB6n7PSOXOlf2pWmeBjxsCdkSeckPMxwfvvdkerVn44ClGvlgW8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wAp3ebO0agzH5nWf4kvUMNQfn+ditDyIPsAaWbWJCI=;
 b=0/B3pW5I1wlMFZJ6BTpWOdgbhD/TWYmnKSsWYsluJhxntM1hiSaLRtiNJTPBor3ao6jVwhX5wHvWNfuYAzbVIELWSPPXAPkWwnMxT2jaY8malUTKhdMEM0t0YzYGI5zabdMd3nTl7r729yhTF+9Iru27ZhjECKlHgLIrcif26Tg=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by BN6PR12MB1892.namprd12.prod.outlook.com (2603:10b6:404:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Thu, 21 Jul
 2022 06:20:34 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::81) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 21 Jul 2022 06:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:20:34 +0000
Received: from master-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:20:31 -0500
From: <shikai.guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
Date: Thu, 21 Jul 2022 14:19:42 +0800
Message-ID: <20220721061942.2517331-1-shikai.guo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 803d55bd-86fb-4bd5-167d-08da6ae11eb6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVD9S0F7SarHg0FLDpDztMbISVeuwMd5L80pb13r2iNXQKePs3poQAVN0fHHUytAJb0ckEAryN76nYLR2cdKzIR0oE6MsVy40Fe1n0Xe7XmgzMXRFMYcvx0p2+J+6G76u2zLeKfYkKG3Fu5hfOmIVWLlDxv8UimDs6HB8zNtnsThj9iPm1gdFTJxwsh6Kds4G867H+CIN9qB5CwMdmO3clVAmngjx9kI7DF4rL9lHrZrfCmatw2jcBfdoYj/BoX3K5EZSh0al+grsSRRsTbQcxYSHdPI3IfM0Nl+XfXkuQJ1xpo7VzpOuvrnVAYe7oWJjK6G24nid24/iFHPO0XChtf4lsfnaFCa+cw/XaY2gF8Rdki8lAHJgc7cNs9f8SAlR/Ng4NsXZT2koBjO1LCflu4qIaeoyuhb8lXgOuahyumza/ZtDtWdLZLvuqEWJwcS2jBbTYPlRgNtfe3eYczK6/xUB66DgePaOiAA17DBJgE6RP71x0kduuqA75ilBvPdzk3to0pb4PXr/ILalLL6DX4Gv9n42ipp199Pk1He6HFkfyqE2KhhY6HJpkNa2TLMJozhHol6DvDpEJvEilYyovPlAewYVdg3VeMkhRcqyF4bPPMb8A9CRvtbCtVoeQPA9XY1IgrpYjlfKiSl+iqHUCLI/rRgA/w6CKC9GdvTzhNZraaUsq2EvTjMvQQWf06poDYlO+NzWCfvWVnFK9/D8jeuXMmvtbMymJVbAeb3DCUz+W/AZ+YzH2XZq+A4FjyKTaMn/A6UKNHu/gASGmYvpxHZuV0IDJDJal8MXsxg/6ifBssyFx/A/vZVGmHvDX7J2NlTeyasvedGH7p12XV/H6iJ617CuuBRZ+wZCdK6lWXsf4gXylV/0K1vkF9wIvYA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(6916009)(54906003)(4326008)(36756003)(70206006)(36860700001)(336012)(8676002)(83380400001)(86362001)(70586007)(8936002)(5660300002)(47076005)(426003)(478600001)(26005)(356005)(82740400003)(16526019)(82310400005)(186003)(41300700001)(1076003)(2616005)(2876002)(81166007)(316002)(6666004)(7696005)(2906002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:20:34.1000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803d55bd-86fb-4bd5-167d-08da6ae11eb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1892
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
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, evan.quan@amd.com,
 Shikai Guo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shikai Guo <Shikai.Guo@amd.com>

add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.

Signed-off-by: Shikai Guo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 70cbc46341a3..cac48121d72b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -31,6 +31,7 @@
 #include "smu_v13_0_1_ppsmc.h"
 #include "smu_v13_0_1_pmfw.h"
 #include "smu_cmn.h"
+#include "asic_reg/smuio/smuio_13_0_2_offset.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -42,6 +43,9 @@
 #undef pr_info
 #undef pr_debug
 
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK		0x00000006L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT			0x1
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -587,6 +591,31 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_1);
 }
 
+/**
+ * yellow_carp_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: amdgpu_device pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)
+{
+	uint32_t reg;
+	uint32_t gfxOff_Status = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	reg = RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
+	gfxOff_Status = (reg & SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
+		>> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
+
+	return gfxOff_Status;
+}
+
 static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -1186,6 +1215,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_gfx_off_control,
+	.get_gfx_off_status = yellow_carp_get_gfxoff_status,
 	.post_init = yellow_carp_post_smu_init,
 	.mode2_reset = yellow_carp_mode2_reset,
 	.get_dpm_ultimate_freq = yellow_carp_get_dpm_ultimate_freq,
-- 
2.25.1

