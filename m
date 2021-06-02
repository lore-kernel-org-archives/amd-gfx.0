Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A75C47098
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1EA61C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1EA61C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4496EDC3;
	Wed,  2 Jun 2021 16:50:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE836EDC5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M45m7bzI3BwXd2JyMVA1laI/tX4e4RiBwsbXfZK5d274fCyn7KkjjRDVkoIynhTp7IPYD5bHOBdZ4VgMENOB5wEDIkZyPVADYSB3+NQlFUxcecJN8jr8NewvsW2SQ3eS4LGDh7rYxwNzip9R2AcTlWtQHJn18YJykIG4nO/tIF7AVEglRVaW8mrjPOYP7rOB3WjUSlFtxmSA88gbrbmCUzZJxy3XAFdYl1XsgwiKVitUS2EH6AfTsok8tWTc5xJuNdmNaIh2sPhE+OgmfBkfOu2PE0Ulo9F42CRTyFHvclxYV4UwXV+8+WlcRpxkH9DyObZrX5Efm3tmY+wvnVU+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDfZHxViSC3HgccMMZlC+PUxaA1XmPsv2dxkk2KlnG8=;
 b=jGTsW5bIJhW2JxQOsaZ5I+1EDEgOGVbDR0bUSUZh/95WySN/O51wBaGIuMPWqWpyi8HzBSxWpPmpGlMruMcyIv52zqcEpNUUm8kPAV4v3iL8q+DWvCdbopghUyGjYFAzDfY5FxJNxAnjSmmewgld0j5iMARG7jr3nLwZopEVudBUUtF0MSkijyrEYUC8yc6YO8Obi8lYTtwk5sFoEIIKTHSAyEllmYBhN8Fdtna+Q3P18wjZv+HHDD1neVafG1eSQLn9WPQEkTrjdsDwR1/k8KZZ/bEfwDiFC3i23F+Pgl6i0ezs4v4exJ2mkhZ3ypv3mYz65SCjQz1Bc9PMFs33iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDfZHxViSC3HgccMMZlC+PUxaA1XmPsv2dxkk2KlnG8=;
 b=LI9O4fxN1NuRgaNPvFsc26Tmbbbcpl1cX99POoR/dNOuJLnMhclPS8GYF5yWUC/Wx1O0G09KXqbtuvNWtHgPdzzsp8IztsPihU09VWDrJh0PrKgSUafCEfEQmPMJyzMEPmbVn7tiVawRfedud7kF1JgAGS9dX1vwPJ+uaRT/rN8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2434.namprd12.prod.outlook.com (2603:10b6:207:4d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:41 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 60/89] drm/amd/pm: add callback get_dpm_ultimate_freq for
 yellow carp
Date: Wed,  2 Jun 2021 12:48:39 -0400
Message-Id: <20210602164908.2848791-60-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad7f441c-2b45-4ece-b7a9-08d925e67b5d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24345DD0D3A14F703DDDE580F73D9@BL0PR12MB2434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihDc1J34Nkdosl+74JZoM7KuLjsush0ct4+zjlS8QRNoXkmL7aZ52g6metZPjffviviZIqPU8Oc2PkmQca1nquoFkIa0vP5j2hKnhwgUBV7OhBewVGluomd4J7IJ7et0JlhGAvuzqlntv9jJsl5q7Kb2g8+CQCOO7doHBJLj9IwRAmHkF+xMin2DsgzQrlRWIOfs32PSpWxOrb7dy/kdEvAhxbQCXSRHSrzXSjfTqBvJGvbEc3/hcA1MFmSW8p1ycJHW5VeQRs8gNZx+FyYYGt2fts6afGvuPgQ5eRKj40bSqH8DbdDGtg5DPn762IfATWERPzv/d237UGPEOChQEazPKoicY2j5+O3CF5+QXLE/tLvzGklOREFwhMdRu2y0TW6m0c0Z5gQsQEYAnPScTwR5Dzm+3XAHAxCfQCzF3TSSlml64C0mjVYtYNtcB1pDFM03tE6Ekn90ewUGWEKlOXBcDJwoG520kuWUu2q05G9jc7D6xnlOZPgP6XvmcD5z1ObJpUHf3nM630rxj4eXlenZXE8SnjeV6i2Tzzz1OxhXhe9mvsqaynYVzGaqZsOz5MZIpvAHgwX89joLcpgFCmykMj7Pp9jbfySu6Y2X4r0jsbSCm6RmU23s5xyOAtTU0JvagprEcFguFn6yJ0ZJIU5fHBk+GcIYW/82EiFd7RtS1dr8Z7xKV+Cb+6ZuziLv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39850400004)(52116002)(6486002)(6916009)(66476007)(66556008)(316002)(66946007)(36756003)(54906003)(86362001)(5660300002)(16526019)(186003)(6506007)(6512007)(26005)(6666004)(83380400001)(1076003)(8676002)(956004)(4326008)(2616005)(478600001)(38350700002)(38100700002)(2906002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VY7x4nr0dQwKexJ1MRhoW60axuttYzkZrI856OTEWWNiG6qn/4hdrPO5A1XF?=
 =?us-ascii?Q?807OLIIgkme6h+XWHgtlndRu4uz7x/ScH7xsGwW/Gf7z7Us5G8NFFpWqyZ4c?=
 =?us-ascii?Q?U7kvAJyzHBSb6jXCE7QnPsb80KzPplSTcWogUt1fZH8wFHkBDeoiEQV6W1W5?=
 =?us-ascii?Q?BO/b8UC1yZMM2ddzlV84bn4unNQB9pxokgiKsm43JFyA43aw87beL2QK3uJr?=
 =?us-ascii?Q?L3y7vJGpfNOB1aSxgNfpQ3JVEOFzC/L/ZfXfMlIEY539xFjRQ/SrqHY7Rq0t?=
 =?us-ascii?Q?bZ9HTBknu/QHeKH/MTvSvDvDKs0ZIBRweQWqm9OEbq9w/AW/DAKDq1vyoC62?=
 =?us-ascii?Q?nA8yYzUHO3vG28Mb+xPiuyQC7ueUAMIkVNZ28paKmTevvc1Z/MdIHkHEl+vR?=
 =?us-ascii?Q?d1kofanB4nUu5oiaWDUy8jE0vHCoQM3TtDV7lbyHPmB2cJP6+iMWNMnf0Ilc?=
 =?us-ascii?Q?Mz46+wBx4SazaT/PRgf4SlRSNiNZRctaiGE5iO/vqA1qaCYTKBT88MQ5hNaG?=
 =?us-ascii?Q?DAf2lASNmaDuqmYo81nFif2Sz07HSZHbdodG3m3vsyPN2TToZv/ZLha7DVLA?=
 =?us-ascii?Q?ILUsYzHJNlR0ceL/OQB+UOKmKFAgFXIXrgTNl8VjUKkz9j8VSJKvwZe5Cbkr?=
 =?us-ascii?Q?Dyz9xmDG0aNfPhyoqzsUHrdajqEFJRcD1+TlnjvEC0rrK98YFXZy1+etoWa9?=
 =?us-ascii?Q?1T0ftqQ8zG7nbjCX4EMwNIwXvjNdrEtOaITpOBMPLpJAcJMyI9X4F+E0ay6f?=
 =?us-ascii?Q?FPQBnZQXKS9lKF5RlKz0LBTjbSR9Bq7jSG2X2XCI/nVokcXB5ZCY6cTqRlzs?=
 =?us-ascii?Q?sQa+XKr3k/dwozQB9gDxGRN1DkOp3iGrfUxutwLmQA0K57qtexwrgI0F3QUW?=
 =?us-ascii?Q?PNWK10Q1PuNCpu0oF27LmZ1xtr6AxnVSzTk4Ulrfen6ecRNfPv8OF9GO5viX?=
 =?us-ascii?Q?JM3pIRa6UORox8yOMruDVV+d9DmA4Lun5FFJx104zCic171n1K4KW/4AmVm6?=
 =?us-ascii?Q?JCYNL0jm80KNKkoZw5brVpNzYLcvxJrm7hTevxZ4TSZJDXnX31axSJXuM+ov?=
 =?us-ascii?Q?J+4HWB4HtPSg/pMhcn1y2ZWUQh5YKzfiSliz7pcQ7jsoN5YBGtDzCePkFrZI?=
 =?us-ascii?Q?8oItbQgoy5G78ZTUJ25BcU4odwjAmLzRPJ8K2nY7LH2lr5ANTG5FFKoOaCUy?=
 =?us-ascii?Q?Q7NtOziPckhZs39mLfhARvpryRjhkQNxMony8abqVZk8vdTOyU/qqQPJBoO/?=
 =?us-ascii?Q?A7I4n43/dLiDW7fB0oXNjQyYVGPHdhKLNGOV4jFhZdrCp7tpxQEOlcUSRFQw?=
 =?us-ascii?Q?iHWNnu1YSCAU9NRf48gtki0x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7f441c-2b45-4ece-b7a9-08d925e67b5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:09.3644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXzbdde1Tuwult/j9DJLbYLFQQ2dDIVTbI9K9YD3OOXItSOU7b6Y5y+RPu/xekQwTlEPhGmsXH6nhPbZB8cT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Add callback function to get the hard frequency range of a clock domain
for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index bded5c297a08..080dd761a328 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -670,6 +670,116 @@ static bool yellow_carp_clk_dpm_is_enabled(struct smu_context *smu,
 	return smu_cmn_feature_is_enabled(smu, feature_id);
 }
 
+static int yellow_carp_get_dpm_ultimate_freq(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t *min,
+							uint32_t *max)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+	uint32_t clock_limit;
+	uint32_t max_dpm_level, min_dpm_level;
+	int ret = 0;
+
+	if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_FCLK:
+			clock_limit = smu->smu_table.boot_values.fclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		case SMU_VCLK:
+			clock_limit = smu->smu_table.boot_values.vclk;
+			break;
+		case SMU_DCLK:
+			clock_limit = smu->smu_table.boot_values.dclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
+
+	if (max) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*max = clk_table->MaxGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+		case SMU_FCLK:
+			max_dpm_level = 0;
+			break;
+		case SMU_SOCCLK:
+			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
+			break;
+		case SMU_VCLK:
+		case SMU_DCLK:
+			max_dpm_level = clk_table->VcnClkLevelsEnabled - 1;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, max_dpm_level, max);
+			if (ret)
+				goto failed;
+		}
+	}
+
+	if (min) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*min = clk_table->MinGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+		case SMU_FCLK:
+			min_dpm_level = clk_table->NumDfPstatesEnabled - 1;
+			break;
+		case SMU_SOCCLK:
+			min_dpm_level = 0;
+			break;
+		case SMU_VCLK:
+		case SMU_DCLK:
+			min_dpm_level = 0;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, min_dpm_level, min);
+			if (ret)
+				goto failed;
+		}
+	}
+
+failed:
+	return ret;
+}
+
 static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 							enum smu_clk_type clk_type,
 							uint32_t min,
@@ -835,6 +945,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_1_gfx_off_control,
 	.post_init = yellow_carp_post_smu_init,
+	.get_dpm_ultimate_freq = yellow_carp_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = yellow_carp_od_edit_dpm_table,
 	.print_clk_levels = yellow_carp_print_clk_levels,
 	.force_clk_levels = yellow_carp_force_clk_levels,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
