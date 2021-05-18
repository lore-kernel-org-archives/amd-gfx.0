Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D24C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 04:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6E261209
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 04:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6E261209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9476E5C3;
	Tue, 18 May 2021 04:10:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE53D6E04A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 04:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcfrkL1rFVj/ouYHMPRn0g/3hSImF2SInbDGDzDCFCnn52BfVqiteg09Fr9j6MpQn3Mi/jo6oynTeL0119L1HGTC3MzcPLOg/M1Qri9nAk/a/GSaQNY+8/5sZnaq+6Z1LjCbZSCmCBvXvBC5R2sp3T1YcLxIeiem5BvUGtNX5bOzR92Hx9vWE/pyPWtqyUBRtyT7e7MdoshLsj0kB/oGxOLFIoV3LMaXUsDIa/kmtEiIn3SsaQuK1txlgfDjS5RkU7fRxKWxXcV4I507kZtRM6bpHZcUsXEIkeXIdQM13/7AXPLmsCIWbyCb1O5OjsrwQMo/oJ1aU59CLDF4wK0UFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HMe+9LrrPL7JlCP5TSwwJXCRZGbd8oxiRQaM2nsNwA=;
 b=kZiJChq2YVd7oiqRTRdlqdch5lYJnT0eL4hOnl0wiEDK3HF9qEEDPqYLQzj0yyKIaxCRSOB0EqC8jC6IvAtb9jAH56j4rDtJI7F80ggcllburbH4ZVzfSWFVNogi6mahwb0/dndbqqpq+jFhTBPZsPG/3kteJFpHXai3LQqFCW5JHywt+PuULl1mGvAX2qU2z7z0Aurt5LOK6An8+pkGkcakpoSNF5QSoIs25lcAyL075lYMIyGPBxVZa5P3rhu2FegRztLC7pmzPIsqQ1aKRXv8YxrkHKGLTLlYLWNKkqGXOC7E2lpYhC0qrMsnL9HCgZJTPTKBTAoq8u7FEd1SYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HMe+9LrrPL7JlCP5TSwwJXCRZGbd8oxiRQaM2nsNwA=;
 b=BZduPAVQAUbNlPZEGmE8J1Y4Qym/QQuBvBuJ2L0cdOw5UfegQTPRELlQOcE8bIQrSF+fkLYnHQmGRGpblp12e5/yzqBf5j+H+u+6MKi+YqTt8Bfe/2yAaBhNCujKCvnpWdT1HBeE3SBOPYRa7guq+3fIgSUwI6q28oSov0iWzys=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 04:10:12 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 04:10:12 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/pm: display vcn pp dpm
Date: Mon, 17 May 2021 21:09:57 -0700
Message-Id: <20210518040957.23266-3-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518040957.23266-1-david.nieto@amd.com>
References: <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <20210518040957.23266-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 04:10:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2cc6c7e-a711-46ff-aa2a-08d919b2d52c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29813AC1BF5E20783D683E0DF42C9@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKQr3dZuDhzGIzX3KF+u99mLkIWTx8KeFXQBvBtX5ha151zzhTUJ3azYNJw0rQYSVwcy7lS55VuUQExvDjZu3ndOyxGQz+SKmqzBBy2BPRHC8r5AaX4R0/JBOHEKkI0aPh3d24+6sD1zQZWSOGDY4B4N96+VxWSbkC6GGDUekfskpuZo4Suc0B3gl9x/vapAknM/ElwE9q+lVWNs/qgn2T8csHpEeCS37l9Hfhq5JaVmqWb3EHb3j73GCzRp9z7k/elrIEAN7c4PwoDCB9Le+iVKTj947N9OIYY2DOxcoOt70zw/LPeDzkD5QM6CHanJgeW7N2c0YjIIJB5gINYgpj+4hEvICrTvq/xF6Xkq/SPjBAYSjd7jvlNO1BCS85+vsG8fIuJ05L8fxWa+EYxC0Qr2o3Skoast8ohsjMkQi8nEVw6o/x3M39oQDu+mFVyZ2gPFFHYRYdKjxpUHaR4czKlv3yYe2sqTXQa/4i9XH/zBClqm9hrlWr5yHFkBYf8URwb/qoZwS0GgTkzT/0ZKXd4AL9WEy5+QiXsnuSAQNpsMa4zxybF08nN+WIFrPIkyPVyZjm2SXHvyhjP6EhULUHyHwoM8FcXzVNtU6ijttjp6iSyPb50DgqcUzeBlHT8KHZarnA2qyXWVLmzLcoi440GehouucokCVjDlUHxN7Hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(83380400001)(6666004)(6486002)(8936002)(8676002)(38350700002)(4326008)(38100700002)(2616005)(956004)(1076003)(66476007)(66946007)(66556008)(52116002)(316002)(5660300002)(7696005)(36756003)(6916009)(478600001)(186003)(16526019)(2906002)(86362001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?smXf8oA6mrM5Ke9GOG+iJK0c4iuy9ZhxWUFl949vlPSW7qbFhzCVLm7DhRjt?=
 =?us-ascii?Q?dsDa2dmnwN2aqth0R1WjyBEvqkyW2bke0Z/t/4KBLBQONKD1WPDnZSCFe7AZ?=
 =?us-ascii?Q?hMONskzuYpPhbdumews9QBfUv6GKh1owiFQj1QC9yHmbYYhBvpM86D9r0swJ?=
 =?us-ascii?Q?DtFqoJOEzyrt3EI3ldmb5mtv0QlPRJQhrknbrWf4/R7cajTTozXQLAcUVDHG?=
 =?us-ascii?Q?nUFaEkdhqrmmgOPTdKo7ulAmd8IT2SJgUfkUcqxqkJ5Pn297DMoiDuvcRdA+?=
 =?us-ascii?Q?JQX3vgJ5yMoaevjwkNLFRU2xqJmvJnF623TxGiSqCx8cidWYpG4vp2/BGyJe?=
 =?us-ascii?Q?/yv06oJfqd0461C5SDFW1bKPiKwuUIXZc4z/cypOXdw40s8tw84uzCYfuOJt?=
 =?us-ascii?Q?ZPqA/z3z4qevQp4P83RMpjYsFdAstfQVla7Qcwy+lQ5hl3aVirMaQSmaraMa?=
 =?us-ascii?Q?lIOXPF/KPvSaLO5WFOZYW6H4O56QHIUPABltkLyureNhpTlT8f71uSC+zqP/?=
 =?us-ascii?Q?FNhm8iAC+nkDG5uXxs6KDsKhO3XE+mSKAo2mximAGsbwf5LQ8CfAPXvue1iL?=
 =?us-ascii?Q?h3yJ//ls5apcrEGbMN86Oy+/03B/0Vy2eWkltAWx8+ApI8kj2n2XRh2T+eLK?=
 =?us-ascii?Q?FBdeH1E27jKnnaH3A/XG398/70uEGAVoFkNhUjGoY/0MfUspL86BJbL7jkPm?=
 =?us-ascii?Q?wQKaST4ZHI4EI9wWAzGYCxZm7MPb202aE+X5duXdUdudeXhnU6MR4XbYO6cY?=
 =?us-ascii?Q?aYMJU2o0njPcNbi8CUYfaZsN39N/zGjffYHPs8o+vxbzheGqDvueoUjhly1h?=
 =?us-ascii?Q?3ObhTiUjwm8k0bAFhHmVdicaqS9jCBHlEEEcxf7bPXrEyfGKlPABuil2yZ01?=
 =?us-ascii?Q?1p3SMEbroD8d4iaswD1KD8dfq0l7deMf6ccBUeRJe+IwK2EXvT2A4hSR+iHk?=
 =?us-ascii?Q?SRZjIj4KeGKrJd+hnPim5O0DvRLD7IkxBncxeqRBMi3g/5/AlJRrGZFS95Bk?=
 =?us-ascii?Q?YR6zAITyPann44WeBOhN7AxHiOnuvqnWpOdhYyx9FmVaJp2Gi+hJO3dvOHrD?=
 =?us-ascii?Q?PYrP2QY7wR7cv9vARUwo4TviLdvS0QNDdhsQeZZ6xEVlJiSA+pazVffc/0Vj?=
 =?us-ascii?Q?7FgfZufGQElnQJ/lK69VgvbfEzuWjKmj2xqil2tkfc7x38tqOHfRuuNgUnry?=
 =?us-ascii?Q?4YrEh487VJAZaPyFTR+EyvJaKHEcRFIJJoU6pGwKq81y0vYMz25YLkrVDPWm?=
 =?us-ascii?Q?InCZ7TX2ZFzEYX9zpE2rJbHz+k/yiBVitm1+EvAQk9DUUBWMeCXG6eBj8zEr?=
 =?us-ascii?Q?8F5R8cd7rpUXB9/qqAfcwiPu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cc6c7e-a711-46ff-aa2a-08d919b2d52c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 04:10:12.3001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrWpQOpyfsX9sp+g9mgLaE0H1bCx5fe07ho4E1rMS5Q5rX2y0z25ESgt472NhXIf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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

Signed-off-by: David M Nieto <david.nieto@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 46 ++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  4 ++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  8 ++++
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 38 +++++++++++++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 48 +++++++++++++++++++
 5 files changed, 144 insertions(+)

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
index 9339fd24ae8c..2e801f2e42a9 100644
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
@@ -1444,6 +1446,8 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_UCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
 		/* There is only 2 levels for fine grained DPM */
 		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 0c40a54c46d7..6da6d08d8858 100644
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
@@ -1150,6 +1154,10 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_UCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK:
+	case SMU_DCLK1:
 		/* There is only 2 levels for fine grained DPM */
 		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index f43b4c623685..3a6b52b7b647 100644
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
@@ -296,6 +309,8 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
 		case SMU_UCLK:
 		case SMU_FCLK:
 		case SMU_MCLK:
+		case SMU_VCLK:
+		case SMU_DCLK:
 			ret = renoir_get_dpm_clk_limited(smu, clk_type, mclk_mask, max);
 			if (ret)
 				goto failed;
@@ -324,6 +339,8 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
 		case SMU_UCLK:
 		case SMU_FCLK:
 		case SMU_MCLK:
+		case SMU_DCLK:
+		case SMU_VCLK:
 			ret = renoir_get_dpm_clk_limited(smu, clk_type, NUM_MEMCLK_DPM_LEVELS - 1, min);
 			if (ret)
 				goto failed;
@@ -532,6 +549,14 @@ static int renoir_print_clk_levels(struct smu_context *smu,
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
@@ -543,6 +568,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_DCEFCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
 		for (i = 0; i < count; i++) {
 			ret = renoir_get_dpm_clk_limited(smu, clk_type, i, &value);
 			if (ret)
@@ -730,6 +757,17 @@ static int renoir_get_dpm_clock_table(struct smu_context *smu, struct dpm_clocks
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
index 7c191a5d6db9..bc628326776c 100644
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
@@ -920,6 +966,8 @@ static int aldebaran_force_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_SOCCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
 		/*
 		 * Should not arrive here since aldebaran does not
 		 * support mclk/socclk/fclk softmin/softmax settings
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
