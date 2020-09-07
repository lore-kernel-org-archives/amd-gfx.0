Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1414BC43461
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 09:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE9A208C7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 09:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i+LG3bSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE9A208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549896E400;
	Mon,  7 Sep 2020 09:02:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7ED6E400
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 09:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyqoKYf0Edq5XFCgMLj4W5ZRIdo+OLEQh36lf2IGBf2y0e8PK8k+X3r7IKPP1AqxbmMdDFw7/+G3yMOd6VTr3TqTB18SvyOxhni2voJ8c+Z/GLNKVYwHtIkX+eUOoHJROLxjp99ljEc28C18iFq/NElBkZMlapxrE7IYEUqgjVBoIm248xlqZnWQZiYdEsomLnLEPkjFbr38gcUFUF43o1tm5/1hEX0g0KYCOmwNVq9TrCDKAOzMUwoKBPJkB6dQsQXlZ3ZwyG+xLW5lABwLSRCrl5EHnwqVjbPTIQYae/4GoLzMtLhGiB2f6/KBJm+UEwWid6btOUx9qSI/O1GEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMfu//E5VhRXKuIKX5H/coNV42wN3qxF7l7pB0ojp8k=;
 b=ACoJHCyN97xcqe9Fju5N6wZg2VQRGt0ZZ8SwU9u06HXpHzXPI8Yt10ik1O5E9vYDJ5z4N1DzHpVWsDtezbpsee2k4usNXSmje1UAHKkmVAPyKfz9SvNUnFqicVqlyHlMNBXdy9GoFeQBDr8uNSJ6hLzfgSRCQnWUuosLTDP+O6Mck2NI3C1kzcHP7RHottfFcLXH4LkPl6R58fk5gJvfwrKTSXlaYlpquXOALw5B/BG2hWOF4zpxCNxjh5U2aHl+QMsK0FbfYoEBlZzODjGcdECZSn+M/7EXpisFiNMxtwcSK4mbbB04JLbz51fUgHYQbIja4hw6xdugrEfota6l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMfu//E5VhRXKuIKX5H/coNV42wN3qxF7l7pB0ojp8k=;
 b=i+LG3bSaG/lcT8szw6h0MJ94PTPz5BrbqNwKppRhvfVfJAiJY9fxSejkjSRU/CA+Wdzo0gCUilcLpmUbIehtipWTBdYeYAE8Q901HjwAw5gLBtHgdBNeeKmBDYD5leQT2M7dw+B2p73R/PYKbO9gTBHgZ5yYe87XrVWqOI7nYto=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Mon, 7 Sep 2020 09:01:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 09:01:57 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/pm: drop unnecessary wrappers around watermark
 setting
Date: Mon,  7 Sep 2020 17:01:24 +0800
Message-Id: <20200907090126.2542-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907090126.2542-1-evan.quan@amd.com>
References: <20200907090126.2542-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0155.apcprd02.prod.outlook.com (2603:1096:201:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 09:01:55 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 131cada6-fd13-4ce6-45e6-08d8530cacbe
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0026:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0026B0D58DED385721092DD5E4280@DM5PR1201MB0026.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:144;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqwBsan3ocX0rpvqZSm9PIjvcyPPHxDt4gSGWhFQmQ8WI2pVbhJTAPeEL5QJP2/ZsGbJQIAQBQkC0/E5i56/5mm0Z2eFRbPSaESw6p2+cSIuDVVoJ/UwHWbHwpKlzQZH+nfzbYZPg9mCbLJKYlftsMDTvXC4aKlCrBb8mXjwo7WiBwqdXoU/KdLbb7kkDNplc1GBb1H0HQSgw0NJqrczTa2scnQRULj5fVZ5jpbt2RK9vAT6uVwWlFUki+7sxf+e2+vkwJq+VxPRzVdO95JR4sk74R58/PA0n6ZFmL8oO+3t14bgCuMKJ3SGNdrDKeoHn8S/NrCFwqBk7yPVY4azIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(6666004)(186003)(16526019)(6486002)(26005)(2906002)(6916009)(7696005)(4326008)(36756003)(66476007)(66556008)(8676002)(316002)(66946007)(8936002)(52116002)(54906003)(83380400001)(30864003)(2616005)(1076003)(956004)(5660300002)(86362001)(478600001)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5q8GQu8ApvJWG8amWJzMGVMFuyhp8OgflBTAah9L+NJW8v4oxx9ySGTynWEFwiyHrjDAF0xO4tCZJFvVE8cs/k/CygLsOHZol7wodpkbt9RHm48g3pM/PSIzaAtRncMMGTDtONZYTPBqMwFrT7x9VbJ8V43cnWIddZOJUhtP9QcHjNyIhdCXi5YcMcDfKAitxOYMV42TZwJSjEpRr01LO/76LcGpPQh2p29iWbYomVGPFNUDBZsPWN+tza/brHwe3+dEdEBQlO0AIiIjy05k+NvtaEQLdOGVVomz0weK40OFOZ3bC5hKwKaWNX+SyRVbYjFxDwrt+WBtBSfuazuGD6EqvyucOrI3mJfRxFnJWp0pJkqU4f6d6Fz0b6Xv5IlgpP2FtNZ5IxYDu18r44+HCh3Ia41Ea9MJXrdAjwt3siO68lHHhEzmRLXRpGJdwkjU+7Z5QrQX1dPMakNgVDjn0Wu0g8kYzJOGgyIEQsAdskYvU3Uq87V1Htzrv5xiDPPYHJgSYU8gjLKOL8ZEXuo7qN2I4sYxPfEZUj0MxDbIVkvuBlu3M/hUfV9uxepOU/I7iVtTgWamMkhWjSujZBLV1uBR0l3HuTPVSU3JDyRd7xnUo4qxvx1vCNx2gm+WAcTnHE1FR8eJhnTouLdgG0YIeQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131cada6-fd13-4ce6-45e6-08d8530cacbe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 09:01:57.8997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y18Fndk9WvIksfykvy65RorQFoQdl7M/x/dNt15Xg0qFvrcEi20HCGIelJC8uKlx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, Evan Quan <evan.quan@amd.com>,
 Changfeng Zhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The convertion to "struct dm_pp_clock_range_for_mcif_wm_set_soc15"
is totally unnecessary and can be dropped.

Change-Id: Ieaa1d1f1cc12b29a8ec26d330fd209662940417d
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Changfeng Zhu <Changfeng.Zhu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 97 +------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 68 ++++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 69 ++++++-------
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 44 ++++-----
 6 files changed, 78 insertions(+), 206 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 99ccabcc135e..435e58d12d8e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -664,49 +664,8 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct dm_pp_wm_sets_with_clock_ranges_soc15 wm_with_clock_ranges;
-	struct dm_pp_clock_range_for_dmif_wm_set_soc15 *wm_dce_clocks =
-			wm_with_clock_ranges.wm_dmif_clocks_ranges;
-	struct dm_pp_clock_range_for_mcif_wm_set_soc15 *wm_soc_clocks =
-			wm_with_clock_ranges.wm_mcif_clocks_ranges;
-	int32_t i;
-
-	wm_with_clock_ranges.num_wm_dmif_sets = ranges->num_reader_wm_sets;
-	wm_with_clock_ranges.num_wm_mcif_sets = ranges->num_writer_wm_sets;
 
-	for (i = 0; i < wm_with_clock_ranges.num_wm_dmif_sets; i++) {
-		if (ranges->reader_wm_sets[i].wm_inst > 3)
-			wm_dce_clocks[i].wm_set_id = WM_SET_A;
-		else
-			wm_dce_clocks[i].wm_set_id =
-					ranges->reader_wm_sets[i].wm_inst;
-		wm_dce_clocks[i].wm_max_dcfclk_clk_in_khz =
-			ranges->reader_wm_sets[i].max_drain_clk_mhz * 1000;
-		wm_dce_clocks[i].wm_min_dcfclk_clk_in_khz =
-			ranges->reader_wm_sets[i].min_drain_clk_mhz * 1000;
-		wm_dce_clocks[i].wm_max_mem_clk_in_khz =
-			ranges->reader_wm_sets[i].max_fill_clk_mhz * 1000;
-		wm_dce_clocks[i].wm_min_mem_clk_in_khz =
-			ranges->reader_wm_sets[i].min_fill_clk_mhz * 1000;
-	}
-
-	for (i = 0; i < wm_with_clock_ranges.num_wm_mcif_sets; i++) {
-		if (ranges->writer_wm_sets[i].wm_inst > 3)
-			wm_soc_clocks[i].wm_set_id = WM_SET_A;
-		else
-			wm_soc_clocks[i].wm_set_id =
-					ranges->writer_wm_sets[i].wm_inst;
-		wm_soc_clocks[i].wm_max_socclk_clk_in_khz =
-			ranges->writer_wm_sets[i].max_fill_clk_mhz * 1000;
-		wm_soc_clocks[i].wm_min_socclk_clk_in_khz =
-			ranges->writer_wm_sets[i].min_fill_clk_mhz * 1000;
-		wm_soc_clocks[i].wm_max_mem_clk_in_khz =
-			ranges->writer_wm_sets[i].max_drain_clk_mhz * 1000;
-		wm_soc_clocks[i].wm_min_mem_clk_in_khz =
-			ranges->writer_wm_sets[i].min_drain_clk_mhz * 1000;
-	}
-
-	smu_set_watermarks_for_clock_ranges(&adev->smu,	&wm_with_clock_ranges);
+	smu_set_watermarks_for_clock_ranges(&adev->smu, ranges);
 
 	return PP_SMU_RESULT_OK;
 }
@@ -917,60 +876,8 @@ static enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
-	struct dm_pp_wm_sets_with_clock_ranges_soc15 wm_with_clock_ranges;
-	struct dm_pp_clock_range_for_dmif_wm_set_soc15 *wm_dce_clocks =
-			wm_with_clock_ranges.wm_dmif_clocks_ranges;
-	struct dm_pp_clock_range_for_mcif_wm_set_soc15 *wm_soc_clocks =
-			wm_with_clock_ranges.wm_mcif_clocks_ranges;
-	int32_t i;
-
-	if (!smu->ppt_funcs)
-		return PP_SMU_RESULT_UNSUPPORTED;
-
-	wm_with_clock_ranges.num_wm_dmif_sets = ranges->num_reader_wm_sets;
-	wm_with_clock_ranges.num_wm_mcif_sets = ranges->num_writer_wm_sets;
-
-	for (i = 0; i < wm_with_clock_ranges.num_wm_dmif_sets; i++) {
-		if (ranges->reader_wm_sets[i].wm_inst > 3)
-			wm_dce_clocks[i].wm_set_id = WM_SET_A;
-		else
-			wm_dce_clocks[i].wm_set_id =
-					ranges->reader_wm_sets[i].wm_inst;
-
-		wm_dce_clocks[i].wm_min_dcfclk_clk_in_khz =
-			ranges->reader_wm_sets[i].min_drain_clk_mhz;
-
-		wm_dce_clocks[i].wm_max_dcfclk_clk_in_khz =
-			ranges->reader_wm_sets[i].max_drain_clk_mhz;
-
-		wm_dce_clocks[i].wm_min_mem_clk_in_khz =
-			ranges->reader_wm_sets[i].min_fill_clk_mhz;
-
-		wm_dce_clocks[i].wm_max_mem_clk_in_khz =
-			ranges->reader_wm_sets[i].max_fill_clk_mhz;
-	}
-
-	for (i = 0; i < wm_with_clock_ranges.num_wm_mcif_sets; i++) {
-		if (ranges->writer_wm_sets[i].wm_inst > 3)
-			wm_soc_clocks[i].wm_set_id = WM_SET_A;
-		else
-			wm_soc_clocks[i].wm_set_id =
-					ranges->writer_wm_sets[i].wm_inst;
-		wm_soc_clocks[i].wm_min_socclk_clk_in_khz =
-				ranges->writer_wm_sets[i].min_fill_clk_mhz;
-
-		wm_soc_clocks[i].wm_max_socclk_clk_in_khz =
-			ranges->writer_wm_sets[i].max_fill_clk_mhz;
-
-		wm_soc_clocks[i].wm_min_mem_clk_in_khz =
-			ranges->writer_wm_sets[i].min_drain_clk_mhz;
-
-		wm_soc_clocks[i].wm_max_mem_clk_in_khz =
-			ranges->writer_wm_sets[i].max_drain_clk_mhz;
-	}
 
-	smu_set_watermarks_for_clock_ranges(&adev->smu, &wm_with_clock_ranges);
+	smu_set_watermarks_for_clock_ranges(&adev->smu, ranges);
 
 	return PP_SMU_RESULT_OK;
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3aefc5f9ba21..85c5e8627e3b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -501,7 +501,7 @@ struct pptable_funcs {
 	bool (*is_dpm_running)(struct smu_context *smu);
 	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
 	int (*set_watermarks_table)(struct smu_context *smu,
-				    struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);
+				    struct pp_smu_wm_range_sets *clock_ranges);
 	int (*get_thermal_temperature_range)(struct smu_context *smu, struct smu_temperature_range *range);
 	int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states);
 	int (*set_default_od_settings)(struct smu_context *smu);
@@ -755,7 +755,7 @@ enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu);
 int smu_write_watermarks_table(struct smu_context *smu);
 int smu_set_watermarks_for_clock_ranges(
 		struct smu_context *smu,
-		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);
+		struct pp_smu_wm_range_sets *clock_ranges);
 
 /* smu to display interface */
 extern int smu_display_configuration_change(struct smu_context *smu, const
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 77e3ffb72dc2..489a84792002 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1824,7 +1824,7 @@ int smu_write_watermarks_table(struct smu_context *smu)
 }
 
 int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
-		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
+		struct pp_smu_wm_range_sets *clock_ranges)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 28d8ec3866fb..ac32fbb2acc7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1589,57 +1589,43 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 }
 
 static int navi10_set_watermarks_table(struct smu_context *smu,
-				       struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
+				       struct pp_smu_wm_range_sets *clock_ranges)
 {
 	Watermarks_t *table = smu->smu_table.watermarks_table;
 	int ret = 0;
 	int i;
 
 	if (clock_ranges) {
-		if (clock_ranges->num_wm_dmif_sets > 4 ||
-		    clock_ranges->num_wm_mcif_sets > 4)
+		if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
+		    clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
 			return -EINVAL;
 
-		for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
-			table->WatermarkRow[1][i].MinClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz /
-				1000));
-			table->WatermarkRow[1][i].MaxClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz /
-				1000));
-			table->WatermarkRow[1][i].MinUclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz /
-				1000));
-			table->WatermarkRow[1][i].MaxUclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz /
-				1000));
-			table->WatermarkRow[1][i].WmSetting = (uint8_t)
-					clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
+		for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
+			table->WatermarkRow[WM_DCEFCLK][i].MinClock =
+				clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_DCEFCLK][i].MaxClock =
+				clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
+			table->WatermarkRow[WM_DCEFCLK][i].MinUclk =
+				clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_DCEFCLK][i].MaxUclk =
+				clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
+
+			table->WatermarkRow[WM_DCEFCLK][i].WmSetting =
+				clock_ranges->reader_wm_sets[i].wm_inst;
 		}
 
-		for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
-			table->WatermarkRow[0][i].MinClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz /
-				1000));
-			table->WatermarkRow[0][i].MaxClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz /
-				1000));
-			table->WatermarkRow[0][i].MinUclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz /
-				1000));
-			table->WatermarkRow[0][i].MaxUclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz /
-				1000));
-			table->WatermarkRow[0][i].WmSetting = (uint8_t)
-					clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
+		for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
+			table->WatermarkRow[WM_SOCCLK][i].MinClock =
+				clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxClock =
+				clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MinUclk =
+				clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxUclk =
+				clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
+
+			table->WatermarkRow[WM_SOCCLK][i].WmSetting =
+				clock_ranges->writer_wm_sets[i].wm_inst;
 		}
 
 		smu->watermarks_bitmap |= WATERMARKS_EXIST;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 59b062fb8601..fc6a1b6d252b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1407,58 +1407,43 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 }
 
 static int sienna_cichlid_set_watermarks_table(struct smu_context *smu,
-					       struct dm_pp_wm_sets_with_clock_ranges_soc15
-					       *clock_ranges)
+					       struct pp_smu_wm_range_sets *clock_ranges)
 {
 	Watermarks_t *table = smu->smu_table.watermarks_table;
 	int ret = 0;
 	int i;
 
 	if (clock_ranges) {
-		if (clock_ranges->num_wm_dmif_sets > 4 ||
-		    clock_ranges->num_wm_mcif_sets > 4)
+		if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
+		    clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
 			return -EINVAL;
 
-		for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
-			table->WatermarkRow[1][i].MinClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz /
-				1000));
-			table->WatermarkRow[1][i].MaxClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz /
-				1000));
-			table->WatermarkRow[1][i].MinUclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz /
-				1000));
-			table->WatermarkRow[1][i].MaxUclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz /
-				1000));
-			table->WatermarkRow[1][i].WmSetting = (uint8_t)
-					clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
+		for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
+			table->WatermarkRow[WM_DCEFCLK][i].MinClock =
+				clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_DCEFCLK][i].MaxClock =
+				clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
+			table->WatermarkRow[WM_DCEFCLK][i].MinUclk =
+				clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_DCEFCLK][i].MaxUclk =
+				clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
+
+			table->WatermarkRow[WM_DCEFCLK][i].WmSetting =
+				clock_ranges->reader_wm_sets[i].wm_inst;
 		}
 
-		for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
-			table->WatermarkRow[0][i].MinClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz /
-				1000));
-			table->WatermarkRow[0][i].MaxClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz /
-				1000));
-			table->WatermarkRow[0][i].MinUclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz /
-				1000));
-			table->WatermarkRow[0][i].MaxUclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz /
-				1000));
-			table->WatermarkRow[0][i].WmSetting = (uint8_t)
-					clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
+		for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
+			table->WatermarkRow[WM_SOCCLK][i].MinClock =
+				clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxClock =
+				clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MinUclk =
+				clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxUclk =
+				clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
+
+			table->WatermarkRow[WM_SOCCLK][i].WmSetting =
+				clock_ranges->writer_wm_sets[i].wm_inst;
 		}
 
 		smu->watermarks_bitmap |= WATERMARKS_EXIST;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 3b9ac72c7571..53d8beffc74e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -863,50 +863,44 @@ static int renoir_set_performance_level(struct smu_context *smu,
  */
 static int renoir_set_watermarks_table(
 		struct smu_context *smu,
-		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
+		struct pp_smu_wm_range_sets *clock_ranges)
 {
 	Watermarks_t *table = smu->smu_table.watermarks_table;
 	int ret = 0;
 	int i;
 
 	if (clock_ranges) {
-		if (clock_ranges->num_wm_dmif_sets > 4 ||
-				clock_ranges->num_wm_mcif_sets > 4)
+		if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
+		    clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
 			return -EINVAL;
 
 		/* save into smu->smu_table.tables[SMU_TABLE_WATERMARKS]->cpu_addr*/
-		for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
+		for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
 			table->WatermarkRow[WM_DCFCLK][i].MinClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz));
+				clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
 			table->WatermarkRow[WM_DCFCLK][i].MaxClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz));
+				clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
 			table->WatermarkRow[WM_DCFCLK][i].MinMclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz));
+				clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
 			table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz));
-			table->WatermarkRow[WM_DCFCLK][i].WmSetting = (uint8_t)
-					clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
+				clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
+
+			table->WatermarkRow[WM_DCFCLK][i].WmSetting =
+				clock_ranges->reader_wm_sets[i].wm_inst;
 		}
 
-		for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
+		for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
 			table->WatermarkRow[WM_SOCCLK][i].MinClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz));
+				clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
 			table->WatermarkRow[WM_SOCCLK][i].MaxClock =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz));
+				clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
 			table->WatermarkRow[WM_SOCCLK][i].MinMclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz));
+				clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
 			table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
-				cpu_to_le16((uint16_t)
-				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz));
-			table->WatermarkRow[WM_SOCCLK][i].WmSetting = (uint8_t)
-					clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
+				clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
+
+			table->WatermarkRow[WM_SOCCLK][i].WmSetting =
+				clock_ranges->writer_wm_sets[i].wm_inst;
 		}
 
 		smu->watermarks_bitmap |= WATERMARKS_EXIST;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
