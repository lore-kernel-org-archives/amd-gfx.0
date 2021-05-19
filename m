Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B294C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 17:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3688610A2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 17:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3688610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B486D6E20B;
	Wed, 19 May 2021 17:39:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4D16E20B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 17:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGSXCgVMdhNf1UnQ+bQLvX2QvL16aDMvRhRRcR1NMs7CzabnsAsV+EyNlarms9Fo2mG4B+bjgLlTpWgkfYSIe0egoGFWwt8k0pXMOoCuyD7jt5yMVY7y8buMn0uN20PH0nESJk0kIkaxYOjk6mlNZW2eNbG9SOq1QWAUaEIIcIEGHwfump9ZFzNc7iuZ9vK26oLVDBdp7WFtrfDYaTX/gT+ZV542F4O+lEohUAJ8iFbhuwFyax6k7ld8YC6s/BAsZgngeQ3er8+bLJ6CFz1I5NgNDKvJ0qRK2BmwszIIwbH/fnp+FfsQWnlJCqtRZqraFLGMp5NzSzL6FQq9Ty2ZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTkpvsWGQLQBgMIVRMdAv9okkscrV/KKe5rbGnzeHd4=;
 b=N0cHBVodDHTLN9+T6KxxtlsGqvdhVOO8wA5OndHkde0sKtNP59ekJXCZL8iZRbREuzaw+vitTLhZpfdccFr5kSkO4Gw8wcqKuiR/M1pEQxlKuuUS8fQGcm8ksESq8AkLb5qgfeaymHdgFbIliEQLR9YOAst1VrOlxybs7QzgrImHZze33pXGK6V71m/nr1xfjw8s9vxN84hDGdjejIiDSx9hQ4/FGamwsVDa49gwjuT6Jdxf3GqWgGFmwQG1oy83VOyiWCXWiaaL0EzTVae9O3UYQRjRmkUeNQ6rwC2k2aKyQfhsctL+b6tYj+d4Q1s1T1fZF/4YMgznB7gS/JRZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTkpvsWGQLQBgMIVRMdAv9okkscrV/KKe5rbGnzeHd4=;
 b=s1U66vDxgC92o9oGab0O4tHqZWtvgod99uo+W7ezk5w5lB/AOkF64GCmA9rQjH6bBUYHJze3l3gnIButtozVVrbx4hToqyTHyHdQwMSx9NnIHLYNFFabbtMuSIHHkU1rju7GgqlPXBfyFHO6haAbpX0KMYUXYTkrWxenU9NPYSY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3063.namprd12.prod.outlook.com (2603:10b6:a03:d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 17:39:17 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 17:39:17 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/pm: display vcn pp dpm (v3)
Date: Wed, 19 May 2021 10:39:06 -0700
Message-Id: <20210519173906.32504-3-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210519173906.32504-1-david.nieto@amd.com>
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
 <20210519173906.32504-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Wed, 19 May 2021 17:39:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d90d41-cea7-4763-e89e-08d91aed06ad
X-MS-TrafficTypeDiagnostic: BYAPR12MB3063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3063F4BD6353851C4B4920EFF42B9@BYAPR12MB3063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6vQ7gsF1ZM4SHTr7mEFVkAV7QMz0iHj616OQ+SBFT3/TOKyZwmYyFXPdI1Ve2rTWrm+TzSc756CiV9BDfLeyzU1D/tDAGQp9f+rmCEq8EvyO68e4IFkZITCLYtVnyhqXPE+NTZqJevJJYPApLxm5jYrJehU/hmESjE7HognVperezPSFMPVp/pD/+hUKiNeiQMwsZxBF0XcHVwlAf7uIWmhLuB21WFlPmIA4YzTXIhEaaAaN3fNYixqTyFEfYRvpYlhCfED7EH6EdoHgeRV9VbCyKuqcMMoAoIeQB7b0PllJGyBVpWRAqW1Asqh4r5yP+SZstB0PE694psjrZNf7JCTj2I5H4D2DmRyAW2Kakwn33F4Du7r4j+EGnVSzSR+mDdiHFhFc6qcmV8YBZKVqeyK34Um1bqA30KXWRBuyLqbiekqQRuGtccA9e/3FVpL0sQEifZTdOO/eLFMNRiwTpJyNZBa9xWHv5E06FucicHXTAW+4cC4dV/RmYnd/y660GwVKg10rI/FULaqbi3WNQUaKTCCgRpffNOxL65+5PMdFscGr7EgP1fajCBZr3bWlFdbzFLvcQq2mztR7Iqae82X871aWRQL1s/kJdLD8A64ALbU8vJ663o4EZOXKlih11SzfDTnf+dIzg/KDcgpuQj/kiZ5aGRi+46cUdsV9P8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(4326008)(478600001)(8936002)(1076003)(8676002)(316002)(6916009)(6486002)(66946007)(5660300002)(86362001)(7696005)(26005)(186003)(2616005)(16526019)(52116002)(66556008)(66476007)(2906002)(38350700002)(36756003)(38100700002)(83380400001)(956004)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aLpFpaACkcEoe2f/QKFOe+lpsxw304YjLB+wpXJ+VbaLZjehIbzHZUpneL8q?=
 =?us-ascii?Q?L7ebt4/WOJp7BlWnYLqOlByTbs0yDMSlTcO5AxFOWw0adT2czQdNFFtMQfX0?=
 =?us-ascii?Q?IR8znCt6cSbaVkC4dC6+Appl0AQg8G05HAVOhOIkKjRzg/PLITm/p37RDUx/?=
 =?us-ascii?Q?Lr4RaVbFJK6AfnmWLsGPgCihrrcLMTZuzYrMNDeIep01/mPOgUqi0HAKzP+R?=
 =?us-ascii?Q?CIQ7ZD/x6KeeDDg1AUMt1NJ96uyA+5WZHPXP9/5udURPwhnTKAJ+tclSrCvB?=
 =?us-ascii?Q?pnIcWIozdyU/kjfoGxZkr4ZQQ1ZW4SV4RsEcyjdmpBlzRZtEA3VlQFk1PxuY?=
 =?us-ascii?Q?n6fRDojsWDaRRc67NSAG+aWQ+FPrR+42Wbr/rY2YaF/h5A3jQ+X/UxTBJXkB?=
 =?us-ascii?Q?aDGevpBsqeerJb2A4xHlBF0KaF3QBnCGgrnNkuk4/oaPdJyGiQEjfW320b30?=
 =?us-ascii?Q?Hz+EqHR35R6wruNLjBBmuR902iJmQy1NFPBB+nr0LDBH7k3Kd+sXE3VyFxtc?=
 =?us-ascii?Q?lkhqpBl/wtQZdvvMRlS526xwy3Wg3hOeq+t4XnPZjAwp6lF1kBae5YMKoDU5?=
 =?us-ascii?Q?mj5AOfs8FJM5wtw0oe+yBlJIEIo1rEsAvbCAgofUFtc7NZUKlF2xp9DtTasG?=
 =?us-ascii?Q?EhGaIXQ7OHCWUvR0Cn0cI30sxJl+5QXWBt+UEi7Ue7QYfssvy1I6KA+Opi02?=
 =?us-ascii?Q?lHwtk7APVP2YbTC2nXsQJ21r2gvvFvUGKw+OpPamc8O93gA5fo51C4x9Vu9v?=
 =?us-ascii?Q?5zUFK8ltxdog4k5yEAbD8F7gMtO8zz/x+itbjZKeL3QlDPoj+NDgYQFcH4OY?=
 =?us-ascii?Q?Jk3UIMk0wtMUNNvEPGwqeHVvI35YsXSsHoh1pMnFCkjyQw69hKWWZHCMjxS1?=
 =?us-ascii?Q?0biRoFq5e/g+JYCudk5/YBlUh+ZxfAO/hhh5VbaoRDKnlPgsMHa0mjsiSvHb?=
 =?us-ascii?Q?DRh2l68H2tYWo1T1OFLV0Y/cTVmqbapZnsYMetR0+m70kuLAo4CP2Zy78GW+?=
 =?us-ascii?Q?bpxpHftiEIIvyGEPXf+RKs85/137k1i0f+k6Y936iG8grsAfrXTEbwhpxts+?=
 =?us-ascii?Q?EV3QLbR1KFNyOJHZih4p4ICnmP+03Qkwy7fzyiFaRU+FaEh+q98tkYk3aVgQ?=
 =?us-ascii?Q?xi2aGYTE/5DsvyMCr9lFHibCUz3ZahEtDqopvmPx9YkGJ7I+kl4GfzvnHJMH?=
 =?us-ascii?Q?uayPjTY4xGq5IbXuhiUnY5XyZ7/Zw3r42HwHh1D+X+viUtksL+p0LdOM9lsP?=
 =?us-ascii?Q?oavCwDVO9F3UtRvYBD7KskKBVW2BJPpww2qDcigZiBBZyLJxWsXSsFlhrdxT?=
 =?us-ascii?Q?4KwOxk0CfkvitGfFszi4ryNk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d90d41-cea7-4763-e89e-08d91aed06ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 17:39:17.3756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deamYoM1epYXLPbUU/0k8Dr0WOAEBuQAkas82nNCXyHD38QDZCMyNDmha8+wuBnl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3063
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable displaying DPM levels for VCN clocks
in swsmu supported ASICs

v2: removed set functions for navi, renoir
v3: removed set function from arcturus

Signed-off-by: David M Nieto <david.nieto@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 46 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 ++
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 34 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 46 +++++++++++++++++++
 5 files changed, 132 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 77693bf0840c..1735a96dd307 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -822,6 +822,52 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 				now) ? "*" : ""));
 		break;
 
+	case SMU_VCLK:
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
+			return ret;
+		}
+
+		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
+		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
+			return ret;
+		}
+
+		for (i = 0; i < single_dpm_table->count; i++)
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
+				i, single_dpm_table->dpm_levels[i].value,
+				(clocks.num_levels == 1) ? "*" :
+				(arcturus_freqs_in_same_level(
+				clocks.data[i].clocks_in_khz / 1000,
+				now) ? "*" : ""));
+		break;
+
+	case SMU_DCLK:
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
+			return ret;
+		}
+
+		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
+		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
+			return ret;
+		}
+
+		for (i = 0; i < single_dpm_table->count; i++)
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
+				i, single_dpm_table->dpm_levels[i].value,
+				(clocks.num_levels == 1) ? "*" :
+				(arcturus_freqs_in_same_level(
+				clocks.data[i].clocks_in_khz / 1000,
+				now) ? "*" : ""));
+		break;
+
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 30f585afeddd..e81310a424e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1273,6 +1273,8 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_UCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
 	case SMU_DCEFCLK:
 		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 0c40a54c46d7..b09c253b9db6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -987,6 +987,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_UCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK:
+	case SMU_DCLK1:
 	case SMU_DCEFCLK:
 		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index f43b4c623685..0805dc439572 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -109,6 +109,8 @@ static struct cmn2asic_mapping renoir_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(SOCCLK, CLOCK_SOCCLK),
 	CLK_MAP(UCLK, CLOCK_FCLK),
 	CLK_MAP(MCLK, CLOCK_FCLK),
+	CLK_MAP(VCLK, CLOCK_VCLK),
+	CLK_MAP(DCLK, CLOCK_DCLK),
 };
 
 static struct cmn2asic_mapping renoir_table_map[SMU_TABLE_COUNT] = {
@@ -202,6 +204,17 @@ static int renoir_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_type
 			return -EINVAL;
 		*freq = clk_table->FClocks[dpm_level].Freq;
 		break;
+	case SMU_VCLK:
+		if (dpm_level >= NUM_VCN_DPM_LEVELS)
+			return -EINVAL;
+		*freq = clk_table->VClocks[dpm_level].Freq;
+		break;
+	case SMU_DCLK:
+		if (dpm_level >= NUM_VCN_DPM_LEVELS)
+			return -EINVAL;
+		*freq = clk_table->DClocks[dpm_level].Freq;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -532,6 +545,14 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		count = NUM_FCLK_DPM_LEVELS;
 		cur_value = metrics.ClockFrequency[CLOCK_FCLK];
 		break;
+	case SMU_VCLK:
+		count = NUM_VCN_DPM_LEVELS;
+		cur_value = metrics.ClockFrequency[CLOCK_VCLK];
+		break;
+	case SMU_DCLK:
+		count = NUM_VCN_DPM_LEVELS;
+		cur_value = metrics.ClockFrequency[CLOCK_DCLK];
+		break;
 	default:
 		break;
 	}
@@ -543,6 +564,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_DCEFCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
 		for (i = 0; i < count; i++) {
 			ret = renoir_get_dpm_clk_limited(smu, clk_type, i, &value);
 			if (ret)
@@ -730,6 +753,17 @@ static int renoir_get_dpm_clock_table(struct smu_context *smu, struct dpm_clocks
 		clock_table->MemClocks[i].Vol = table->MemClocks[i].Vol;
 	}
 
+	for (i = 0; i < NUM_VCN_DPM_LEVELS; i++) {
+		clock_table->VClocks[i].Freq = table->VClocks[i].Freq;
+		clock_table->VClocks[i].Vol = table->VClocks[i].Vol;
+	}
+
+	for (i = 0; i < NUM_VCN_DPM_LEVELS; i++) {
+		clock_table->DClocks[i].Freq = table->DClocks[i].Freq;
+		clock_table->DClocks[i].Vol = table->DClocks[i].Vol;
+	}
+
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7c191a5d6db9..fb744f3e17d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -816,6 +816,52 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 								       now) ? "*" : ""));
 		break;
 
+	case SMU_VCLK:
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
+			return ret;
+		}
+
+		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
+		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
+			return ret;
+		}
+
+		for (i = 0; i < single_dpm_table->count; i++)
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
+					i, single_dpm_table->dpm_levels[i].value,
+					(clocks.num_levels == 1) ? "*" :
+					(aldebaran_freqs_in_same_level(
+								       clocks.data[i].clocks_in_khz / 1000,
+								       now) ? "*" : ""));
+		break;
+
+	case SMU_DCLK:
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
+			return ret;
+		}
+
+		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
+		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
+			return ret;
+		}
+
+		for (i = 0; i < single_dpm_table->count; i++)
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
+					i, single_dpm_table->dpm_levels[i].value,
+					(clocks.num_levels == 1) ? "*" :
+					(aldebaran_freqs_in_same_level(
+								       clocks.data[i].clocks_in_khz / 1000,
+								       now) ? "*" : ""));
+		break;
+
 	default:
 		break;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
