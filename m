Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A5C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D06C20826
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fPUdQRIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D06C20826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0743E6E1D8;
	Fri,  3 Jul 2020 08:33:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538066E1D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4fav+vPwsx8FmjvQYzcszZAgSw/cROzNflMoziJS4LQXgxVZ0X4R3FjRf42Fw9/oq5dZKcvGB4a53UTFI8obJQKwfA4DoGRtyhmAMcHJENUk1CQQsCd5qmq0Qe04IMPVnnGFeteUCpV82xYrug7WGMAHRTj72B0McZizUl/zDtddB9gpsNs3nZVWRuXF/lJ69sUyRSvE8857bXMjP+KiXTFQBfCcDxbpjUzVKBDerLopSDqqpZ1EE6O2/XsEJI4eGpZF9Iohljh2ymlUyh+dGTUh5jvi5VY9OPC5goNdikBFrncJq1MKvA9B8O5SA9XHMz1CTY4njecyN9dH0tO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3LSm8/aESIIc7pYwRX6CAhKkVO/GykZ7gDh8yNrFHM=;
 b=J88LPqa29s7+S4ViEqEaaLZmdzrFAAQFx1YioGree1uziPddJUL2fsCqr+BuXCebxLFuPpqW5myUScuojAUQWAOyFtVfBdgxX7WIpJ/LNP5LH0/VHM1Z2xfVpWPwGFWA3BjwgxtDhDX53MpSGlqmVGBVbantHYyK6P6/9g1LYKGKlxB3wCwBPE1UQli90BaiVRYp+8KPXkyYSObRyxuDb9h8lqvhHC1aEsBi9oToFK4HND5rmuAfCqffD3q+BPZVBIxgm95TJ200IDuELtYX/Hi8KQgLH0sVyRfmjemkVj7WyVk6Rg936R20z0k/8jAmjl6eIifclnTQKSanelbaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3LSm8/aESIIc7pYwRX6CAhKkVO/GykZ7gDh8yNrFHM=;
 b=fPUdQRInyIfBhlUOpecG8woAtsNMjr/xlyf8Y/5HT0Bpq4007kDcIGwXtaVxLC72w/gbIosDxLzEh6eu88HbK0soDGQmV339nkqa2eUgSJL2sT7GBUodsWC1ILtq0xIzvpZDt/km/lDNX6YwH6SHbX72xikPrnGUAjbTsoFlc70=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:48 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/14] drm/amd/powerplay: update UMD pstate clock settings
Date: Fri,  3 Jul 2020 16:32:55 +0800
Message-Id: <20200703083303.478-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703083303.478-1-evan.quan@amd.com>
References: <20200703083303.478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:46 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 801ae8c5-e107-426b-165b-08d81f2bce81
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3962F034C7C066452774B8CDE46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Lun/X1DTsgHRMCodmUXH/Rm9MTxDutPHFSbnN5h4CmDPGwZsH57PdP8ckCedetKw38P4Z4G5zuREqAeZsDtzkgynSAW3t+cCa4VyF8zlR682bJs8hikCnvs/vg6nH6oNzky83qc49l7ggkhTqgD4HZHywMlKpM+LgVvNNxreXeOOiMAr6PakeLbLAY7Y0yUHXE7R27tyL9D6YCKSEu+B9wpw4R+mrO9ZRbFfnBe7v1dew1yS3/Ytb/BnHqXTROoJk35yGAi9y6HkAKXuDE3y5Rzyxg5gvDZuBzyWMxu9v/gNMYVF50sie57EMFs+dGHtYs0kHziiWFQdQ179/Fl9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(6666004)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002)(66574015);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XJrKMTvQVjicXZZJXORceuFsueXmmSSQPKbI5Lbj6wjHyBz3iYjRa72H6wDWEPmOS1wQhCUq4BEUcDxzkUxcerJVpPxKs3uqx6C33EBftjniDtQGcnDmCStkrGDqddkUYpvE9XdWhEmykufKEHYK0ghg2TNwCMT7/nR2eeI6a/ptw7CIdvmrc8U6syGTMxrHj8gR6URgqQ2CEaKJy5SEc4UIqozryqiFoPUWhOV9ZYWcf47R7UVQdin9JCTVQBHwSgq0nbye8q+1Nfo8sk5yo2J+ngLgn0FEpH4cmhvBktG8A8AF8UsPY/h67ul59ZHQqH/bK6rMjxSdWq95npaW+HN+KAbVo/UQkt41JSvSmbTvxA0Wgv9THtMuTT2sg5jXKXIBnUnRU9ZPosOrYOCJHgsAVdUpCpLpCt8bzvFlCdXU76LgO5LRdcjIGtOwNCNlYp3Fwk7q3IEw3MoSNMOpvIxzAlRIiBowpiF9OPrv/SAszFTCjDVAIQHbDw5UQljv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801ae8c5-e107-426b-165b-08d81f2bce81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:48.4614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lj5Sh635MFHAIeYc1uI+5dCuNdFbSxKiJeTDBmRYdSU1pQy4Wx790x4hJvceLO96
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Preparing for coming code sharing around performance level
setting.

Change-Id: I51b1536b62995f0fecd51b91f238793f57485aa9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  6 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 47 ++++++---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 99 ++++++++++++++++---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 35 ++++---
 4 files changed, 141 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 6839faaab611..4080b3c792ac 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2168,6 +2168,8 @@ int smu_read_sensor(struct smu_context *smu,
 		    enum amd_pp_sensors sensor,
 		    void *data, uint32_t *size)
 {
+	struct smu_umd_pstate_table *pstate_table =
+				&smu->pstate_table;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2180,11 +2182,11 @@ int smu_read_sensor(struct smu_context *smu,
 
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
-		*((uint32_t *)data) = smu->pstate_sclk;
+		*((uint32_t *)data) = pstate_table->gfxclk_pstate.standard * 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK:
-		*((uint32_t *)data) = smu->pstate_mclk;
+		*((uint32_t *)data) = pstate_table->uclk_pstate.standard * 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index a3747ab4af32..33d472ffb2be 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -548,27 +548,44 @@ static int arcturus_run_btc(struct smu_context *smu)
 
 static int arcturus_populate_umd_state_clk(struct smu_context *smu)
 {
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	struct arcturus_dpm_table *dpm_table = NULL;
-	struct arcturus_single_dpm_table *gfx_table = NULL;
-	struct arcturus_single_dpm_table *mem_table = NULL;
+	struct smu_11_0_dpm_context *dpm_context =
+				smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_table *gfx_table =
+				&dpm_context->dpm_tables.gfx_table;
+	struct smu_11_0_dpm_table *mem_table =
+				&dpm_context->dpm_tables.uclk_table;
+	struct smu_11_0_dpm_table *soc_table =
+				&dpm_context->dpm_tables.soc_table;
+	struct smu_umd_pstate_table *pstate_table =
+				&smu->pstate_table;
+
+	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.peak = gfx_table->max;
 
-	dpm_table = smu_dpm->dpm_context;
-	gfx_table = &(dpm_table->gfx_table);
-	mem_table = &(dpm_table->mem_table);
+	pstate_table->uclk_pstate.min = mem_table->min;
+	pstate_table->uclk_pstate.peak = mem_table->max;
 
-	smu->pstate_sclk = gfx_table->dpm_levels[0].value;
-	smu->pstate_mclk = mem_table->dpm_levels[0].value;
+	pstate_table->socclk_pstate.min = soc_table->min;
+	pstate_table->socclk_pstate.peak = soc_table->max;
 
 	if (gfx_table->count > ARCTURUS_UMD_PSTATE_GFXCLK_LEVEL &&
-	    mem_table->count > ARCTURUS_UMD_PSTATE_MCLK_LEVEL) {
-		smu->pstate_sclk = gfx_table->dpm_levels[ARCTURUS_UMD_PSTATE_GFXCLK_LEVEL].value;
-		smu->pstate_mclk = mem_table->dpm_levels[ARCTURUS_UMD_PSTATE_MCLK_LEVEL].value;
+	    mem_table->count > ARCTURUS_UMD_PSTATE_MCLK_LEVEL &&
+	    soc_table->count > ARCTURUS_UMD_PSTATE_SOCCLK_LEVEL) {
+		pstate_table->gfxclk_pstate.standard =
+			gfx_table->dpm_levels[ARCTURUS_UMD_PSTATE_GFXCLK_LEVEL].value;
+		pstate_table->uclk_pstate.standard =
+			mem_table->dpm_levels[ARCTURUS_UMD_PSTATE_MCLK_LEVEL].value;
+		pstate_table->socclk_pstate.standard =
+			soc_table->dpm_levels[ARCTURUS_UMD_PSTATE_SOCCLK_LEVEL].value;
+	} else {
+		pstate_table->gfxclk_pstate.standard =
+			pstate_table->gfxclk_pstate.min;
+		pstate_table->uclk_pstate.standard =
+			pstate_table->uclk_pstate.min;
+		pstate_table->socclk_pstate.standard =
+			pstate_table->socclk_pstate.min;
 	}
 
-	smu->pstate_sclk = smu->pstate_sclk * 100;
-	smu->pstate_mclk = smu->pstate_mclk * 100;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index a022e93a487c..d3e11d81c0ad 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1213,22 +1213,93 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 
 static int navi10_populate_umd_state_clk(struct smu_context *smu)
 {
-	int ret = 0;
-	uint32_t min_sclk_freq = 0, min_mclk_freq = 0;
-
-	ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_SCLK, &min_sclk_freq, NULL);
-	if (ret)
-		return ret;
-
-	smu->pstate_sclk = min_sclk_freq * 100;
-
-	ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_MCLK, &min_mclk_freq, NULL);
-	if (ret)
-		return ret;
+	struct smu_11_0_dpm_context *dpm_context =
+				smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_table *gfx_table =
+				&dpm_context->dpm_tables.gfx_table;
+	struct smu_11_0_dpm_table *mem_table =
+				&dpm_context->dpm_tables.uclk_table;
+	struct smu_11_0_dpm_table *soc_table =
+				&dpm_context->dpm_tables.soc_table;
+	struct smu_umd_pstate_table *pstate_table =
+				&smu->pstate_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t sclk_freq;
 
-	smu->pstate_mclk = min_mclk_freq * 100;
+	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	switch (adev->asic_type) {
+	case CHIP_NAVI10:
+		switch (adev->pdev->revision) {
+		case 0xf0: /* XTX */
+		case 0xc0:
+			sclk_freq = NAVI10_PEAK_SCLK_XTX;
+			break;
+		case 0xf1: /* XT */
+		case 0xc1:
+			sclk_freq = NAVI10_PEAK_SCLK_XT;
+			break;
+		default: /* XL */
+			sclk_freq = NAVI10_PEAK_SCLK_XL;
+			break;
+		}
+		break;
+	case CHIP_NAVI14:
+		switch (adev->pdev->revision) {
+		case 0xc7: /* XT */
+		case 0xf4:
+			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XT_GFXCLK;
+			break;
+		case 0xc1: /* XTM */
+		case 0xf2:
+			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XTM_GFXCLK;
+			break;
+		case 0xc3: /* XLM */
+		case 0xf3:
+			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XLM_GFXCLK;
+			break;
+		case 0xc5: /* XTX */
+		case 0xf6:
+			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XLM_GFXCLK;
+			break;
+		default: /* XL */
+			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XL_GFXCLK;
+			break;
+		}
+		break;
+	case CHIP_NAVI12:
+		sclk_freq = NAVI12_UMD_PSTATE_PEAK_GFXCLK;
+		break;
+	default:
+		sclk_freq = gfx_table->dpm_levels[gfx_table->count - 1].value;
+		break;
+	}
+	pstate_table->gfxclk_pstate.peak = sclk_freq;
+
+	pstate_table->uclk_pstate.min = mem_table->min;
+	pstate_table->uclk_pstate.peak = mem_table->max;
+
+	pstate_table->socclk_pstate.min = soc_table->min;
+	pstate_table->socclk_pstate.peak = soc_table->max;
+
+	if (gfx_table->max > NAVI10_UMD_PSTATE_PROFILING_GFXCLK &&
+	    mem_table->max > NAVI10_UMD_PSTATE_PROFILING_MEMCLK &&
+	    soc_table->max > NAVI10_UMD_PSTATE_PROFILING_SOCCLK) {
+		pstate_table->gfxclk_pstate.standard =
+			NAVI10_UMD_PSTATE_PROFILING_GFXCLK;
+		pstate_table->uclk_pstate.standard =
+			NAVI10_UMD_PSTATE_PROFILING_MEMCLK;
+		pstate_table->socclk_pstate.standard =
+			NAVI10_UMD_PSTATE_PROFILING_SOCCLK;
+	} else {
+		pstate_table->gfxclk_pstate.standard =
+			pstate_table->gfxclk_pstate.min;
+		pstate_table->uclk_pstate.standard =
+			pstate_table->uclk_pstate.min;
+		pstate_table->socclk_pstate.standard =
+			pstate_table->socclk_pstate.min;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int navi10_get_clock_by_type_with_latency(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index d750d06378e9..8fae7dd982c7 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1114,22 +1114,27 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 
 static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
 {
-	int ret = 0;
-	uint32_t min_sclk_freq = 0, min_mclk_freq = 0;
-
-	ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_SCLK, &min_sclk_freq, NULL);
-	if (ret)
-		return ret;
-
-	smu->pstate_sclk = min_sclk_freq * 100;
+	struct smu_11_0_dpm_context *dpm_context =
+				smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_table *gfx_table =
+				&dpm_context->dpm_tables.gfx_table;
+	struct smu_11_0_dpm_table *mem_table =
+				&dpm_context->dpm_tables.uclk_table;
+	struct smu_11_0_dpm_table *soc_table =
+				&dpm_context->dpm_tables.soc_table;
+	struct smu_umd_pstate_table *pstate_table =
+				&smu->pstate_table;
+
+	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+
+	pstate_table->uclk_pstate.min = mem_table->min;
+	pstate_table->uclk_pstate.peak = mem_table->max;
+
+	pstate_table->socclk_pstate.min = soc_table->min;
+	pstate_table->socclk_pstate.peak = soc_table->max;
 
-	ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_MCLK, &min_mclk_freq, NULL);
-	if (ret)
-		return ret;
-
-	smu->pstate_mclk = min_mclk_freq * 100;
-
-	return ret;
+	return 0;
 }
 
 static int sienna_cichlid_pre_display_config_changed(struct smu_context *smu)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
