Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD0C47099
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0CD61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0CD61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8846EDC2;
	Wed,  2 Jun 2021 16:50:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5582C6EDBC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzxO1AnLXupCGjFrNSF17yd0b87MZMUG0fcm2B8nVuCRdOtC8r4jta+vjmUX3t3MVPf4jB4mlVvjcY1+DZnyNJ0/M6OZYOTJq1WWYLsHdZazTqMqbMCVvh6O/GYzUxucdMoLjvpRBr1MuvZyxuBNB5K54iQUYiYiV72wfHDyjang9JqIOdKvslcfFG4Jite1Z/HEj7HhFrkYs8VMkAfotcgqqlfmD6gYsiRbULPq+WctuhiJQapsK7G3fmwEupkLHSIl/Lqi4k86GsnuV6wbceyiD+3/5IWqBzOh5r1soYaao0A/eih3qrXcRdQ0kpjp2SRpCovg2PSaLglxuGhhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d68lNNT2ctgcGyDWQXF4m/Sz61tcskOvWSypwTEfMMc=;
 b=SHCjRFnc8K60iUgek4cOzpr8cIpzHi7Y0+BniMirg4J3tyIuV1IoQ8o7aEJaZdOv7jdhJ4PpkUEQFBmWpPn6pmV3Mahii9Qm/TR4Rfn8n2FNAeEwv5VbWqFhvTfusbHtvi4ZYlFuFuf15M13aUD0FTkbHizSBvsHUUkhkBBQYFoN9FJcxE6nTYS6oS18vJGd+eOgIE7IA987wiUJV6stUlv3ysbWaOIj80Qbx1ZMDhzl77Z1n0c//hbri30RdOZYaeDwFmuHegW94jKK6te2TLAfA6VQQ1JKkX5810Pgn9zfaiyVEfm/ga4F/44+iotGpPaCte0r3IY3P4WIrIDtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d68lNNT2ctgcGyDWQXF4m/Sz61tcskOvWSypwTEfMMc=;
 b=XTBVayMGF9NvBpZMP98mcm1bUh34KmGghfIPfB84eoFkecrrfOJwR0fUSago41S226/UHaw6OKhMs0eg4j3MwZ3C5r1eT0POp3t1vrqWAtKOWTPO6WfJsHRqBxVj7YJE5btlcY/JP4uv51XMRcOKybIyo71pvOUNiCiOzX5XRWI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 16:50:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 56/89] drm/amd/pm: add callback force_clk_levels for yellow
 carp
Date: Wed,  2 Jun 2021 12:48:35 -0400
Message-Id: <20210602164908.2848791-56-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff2021f-b63c-4018-5ecc-08d925e679d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4487E6DFBC2F0FDC4333C450F73D9@MN2PR12MB4487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgUuy924p71MPkCvVlvC1YzxsS8w6azXOum2Tyf8URHnDRZQt+aGw+bEsLqgiARQB5AUlGT5GobScffQCB0ZwGFjLnza5oV1kew8pNNfRoJ1dOz8z+/ZEy5VuY4B4Lypmt4KEEZE7gmwKT+KytO3mYZnq2+z2Dzfna4FAZ4lo0wM+X1h4vFCX6TTFZ2qUqLr+Exf9CCxF5eTEJyc7ugt7utb7yPL3BPH4tb15snX/cQHe6obBXDDbBORDUVMwBBHwzave9+ERESOY30rNPIgtNYFotmgApW9mwlnsXTtHYZWa2iF29w5eQMWa3bnQvd+rCWDesfhKNqxqYYzb+JWfYqSOyNYofZed3cZC8mwk9BKHkHfY2+nDVP4ryGvldfZ7XKsvtRU3DNMG75dXvsHhrq8OaWAo2fbgnVdEKaShhK5UY9a4+wv6ijUnsbpu8poy6dLNh7+gJNowpuDzCWLXFi6Ls2suPBaNKIq97Pc4CuA+wSRMGEOw/lzNlg96Hj+0i8ENRtSkFBQGeqWFQbLuMMpllF1M2E3YpQGhhCWhGKEEs5x0zPwBEoOzAq/QWIji69jUeGGsNzxk3ztAVMEpeloQlpIEpw/CGa1EIi6IQNm48jDXAELWVmLd1uTTt3lZrrQEmyQTlJ81QLlvKYCy8SOfCGfcruUsETYsEwgbz9uHjAiWvUnWl3mIgsECPQH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(86362001)(54906003)(1076003)(8676002)(478600001)(6916009)(6506007)(2906002)(38350700002)(8936002)(316002)(6666004)(36756003)(66476007)(52116002)(16526019)(186003)(26005)(83380400001)(5660300002)(6512007)(6486002)(4326008)(956004)(2616005)(66556008)(38100700002)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ffysZOg//JkUQkc1NvjRTdSUkyX+WrNUDspt/meW8pY8r4LXlrMiIdLsdtDr?=
 =?us-ascii?Q?+McCTSrx+bkwmbRGJhOju20EgXJZpmKctqYCw+5FF+zRCx6FZ6AR5ghkz8vb?=
 =?us-ascii?Q?sO9ATekmE+305kUn8+EpbqqHlxtmDUGe0d17cLBJu1ME35J6jyTJ+w6wZXoQ?=
 =?us-ascii?Q?8LhVMIL0gcMqRgjKDjFZcpH2Nnjrnu2FTMi0V1D0NOtbenDu7PpLfvodSzli?=
 =?us-ascii?Q?tKNAtSbRAjCcG5JgE3RRAQLspjuU/dTcK1dNHsWht+PZrn/vRQQdfaOCFpdM?=
 =?us-ascii?Q?AMvTltoTYM0IieUm+qfMei4SStjbzdUR3vV+z9MsjvZRCT7qBtyN1W/yn1Av?=
 =?us-ascii?Q?YVNEhzPiwfmSJEELHnVReed7FVQb51mTi6fKPcupBDfvmbFrJUvvQKZFME2m?=
 =?us-ascii?Q?c7a4Ml/8vWMFvFrJxAXnW+1EnfwQV1p2dqOfDxABmlcnudQxryMoaOMXl7s6?=
 =?us-ascii?Q?gkl2Mgqkiod9nNkwxJxOqehH/YtE3hicRK/2OSvmXpEMjiggOIEiTHTLk4Qs?=
 =?us-ascii?Q?jjEhenRRx+1enGqkQdpmzpSX61RtWYoikkZGcSq7pwH9a8GcpxV/Rt45czKr?=
 =?us-ascii?Q?SU+oUy0J6EfuGzhceB6jOUNKXku/aC+i3fWvy6aup0QCoHhIiMAvt4T29IYx?=
 =?us-ascii?Q?C6hi0CdWYFunrrLEbJ4jDTqaADH1v6Wkn5LrL3TQjlmP/Roub1JHchtbxRaC?=
 =?us-ascii?Q?XAHTIBIruK7qYFdUI1RLYEqbySRaGWTNu01nX9QgRttdEFlobDrgC/W6SBt3?=
 =?us-ascii?Q?hyITxnHFdr3yTHHw33hHVBk7nZyWGBipIsHaQfTx801OO7YtAJIzVa9ImnbB?=
 =?us-ascii?Q?wOlx0Eay0WqGN00v2IlGx8Hdf5TWUBc+zY3Cell26ce0HWcB7XDAdVCAw6sP?=
 =?us-ascii?Q?4Ep2a01yxfPuAeFvxMx+gZ3z78uNUmguCSz2lqe3nDeeg7wHM25EOYw/Ql0U?=
 =?us-ascii?Q?v6XM4LdyuFlgtw7M/J9mXBbQSz/8jHk5r7J1cANezrhrQzHq0vAnFzcSLNfR?=
 =?us-ascii?Q?32v6tPB05Ucb99BwJ/3FQj4R9gTA+zFOxprIwWcWIc9dNcJzv/VW8X4fYkKY?=
 =?us-ascii?Q?eqZt1uMQ/rNJ9v7apLqa3N/e2UNce2c6VXcCbC5bGxijhjqJpNH1ctPvPrlW?=
 =?us-ascii?Q?+HtUzQjSruutZYkx5tc5nShLQOPF+g0LDr4AZFU/LcGbcq/w85nmCvPiJVV/?=
 =?us-ascii?Q?mbfKGs/JMPL+aMWRQeJ3LfV4KFFjgf70ormHaZV0BCYBcwb/65hRMioL76SH?=
 =?us-ascii?Q?2nsFhOmCTKl2GYD//Rcgp0heyV75ieHIKvCJUiE8j3V+I4XH3S1xkVDg12hs?=
 =?us-ascii?Q?WWBzTJ/oXYvLV6b7IP+OmtLl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff2021f-b63c-4018-5ecc-08d925e679d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:06.7548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhtQxh25fhVj3MZeO8ENgq2BPAzvmKXCXb2ADaZQkXWVPSsmnupA15RDMCS8f+DciZvyJ61VO2Fb7AvC7rB+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Implement the sysfs API to set a range of allowed DPM levels for
specific clock domain.

v2: return error directly if the specified clock type not supported

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index feef77c31d56..8e09811f56ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -637,6 +637,82 @@ static int yellow_carp_get_dpm_freq_by_index(struct smu_context *smu,
 	return 0;
 }
 
+static bool yellow_carp_clk_dpm_is_enabled(struct smu_context *smu,
+						enum smu_clk_type clk_type)
+{
+	enum smu_feature_mask feature_id = 0;
+
+	switch (clk_type) {
+	case SMU_MCLK:
+	case SMU_UCLK:
+	case SMU_FCLK:
+		feature_id = SMU_FEATURE_DPM_FCLK_BIT;
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		feature_id = SMU_FEATURE_DPM_GFXCLK_BIT;
+		break;
+	case SMU_SOCCLK:
+		feature_id = SMU_FEATURE_DPM_SOCCLK_BIT;
+		break;
+	case SMU_VCLK:
+	case SMU_DCLK:
+		feature_id = SMU_FEATURE_VCN_DPM_BIT;
+		break;
+	default:
+		return true;
+	}
+
+	return smu_cmn_feature_is_enabled(smu, feature_id);
+}
+
+static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t min,
+							uint32_t max)
+{
+	enum smu_message_type msg_set_min, msg_set_max;
+	int ret = 0;
+
+	if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type))
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
+		break;
+	case SMU_FCLK:
+	case SMU_MCLK:
+		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
+		break;
+	case SMU_SOCCLK:
+		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
+		break;
+	case SMU_VCLK:
+	case SMU_DCLK:
+		msg_set_min = SMU_MSG_SetHardMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+	if (ret)
+		goto out;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
 static int yellow_carp_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
@@ -686,6 +762,43 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
+static int yellow_carp_force_clk_levels(struct smu_context *smu,
+				enum smu_clk_type clk_type, uint32_t mask)
+{
+	uint32_t soft_min_level = 0, soft_max_level = 0;
+	uint32_t min_freq = 0, max_freq = 0;
+	int ret = 0;
+
+	soft_min_level = mask ? (ffs(mask) - 1) : 0;
+	soft_max_level = mask ? (fls(mask) - 1) : 0;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+	case SMU_MCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+		ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
+		if (ret)
+			goto force_level_out;
+
+		ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
+		if (ret)
+			goto force_level_out;
+
+		ret = yellow_carp_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		if (ret)
+			goto force_level_out;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+force_level_out:
+	return ret;
+}
+
 static int yellow_carp_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 {
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
@@ -719,6 +832,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.post_init = yellow_carp_post_smu_init,
 	.od_edit_dpm_table = yellow_carp_od_edit_dpm_table,
 	.print_clk_levels = yellow_carp_print_clk_levels,
+	.force_clk_levels = yellow_carp_force_clk_levels,
 	.set_fine_grain_gfx_freq_parameters = yellow_carp_set_fine_grain_gfx_freq_parameters,
 };
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
