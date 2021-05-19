Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E78C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 06:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8FD61355
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 06:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8FD61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACEB6E55C;
	Wed, 19 May 2021 06:03:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C991D6E202
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 06:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMEWnSuDTfTzVhc9k3GKW6d2gMPfU/pl/7bhyESJC8sG6Bi2et+ZE00vO/s9lFvx6F4xUJPfe4AgjR3W63zhnnmzD13lIu8bIgEcw/fkTA8ps5rcK/oiOJvRLRshnOGUuiVZDnWOqbBmSeS/yUvm8rItl2XFoGQ1UnWhDOnBYXcKkMZsydpotRHTuShAqHgp8Gm0/G9zJWpa7sChKxTG/ubAELmMHi/ziR+t9BnsCA2gnXO7QLkePWMTL+wzyVVnMNq5iN4RQzrwR+L/ahINBmOsZazgi5erYpYGlfpUFb+KhOFmbx4Tr+bKO30cch5iPBMW5SCbLlQfGc9oWy60ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e1LPrZ//ntLYWSekjSBs40xNqb/2XHYY6zoERvck+E=;
 b=geuFWT6IGvtinZzjRbGXQcxBXjE+BfQEyFJslJe0RiiY/cLiNbYIi4gneuXkAyHuv5nUi5aiCzRy7VDN9y/ORfJV2aTGqdPPYQMQm0VwcbNsba3KxAIW4nFaONxCljGScZ1sYMYt1KnHQvnvLeEq9H4+bc9LIhO+tUe9NvrmKl7+qks6A7wBLLI3FLpdcjGYVGylM5gs3BlXav4CtKjsXxIoGLZYxHZ/FSThO+ltsUTfjgEc60cX9YuleK5TGY2uFnfVkwdlLUasT63EjOVP4WS3K7tAjSrimKpeGggTHFWyTPrtW3cGibDG5m9mBes5bIv50ZwJnWWv9UT2rSIPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e1LPrZ//ntLYWSekjSBs40xNqb/2XHYY6zoERvck+E=;
 b=02auBl6yZHOkDwIE6WjwBj0bjqnC0+qSPYvig+1dtUXOnKIlALDM1347L5n00BFjXLm9BMD+RZOvowW8vTp2XMnJ1Y1XRr9Bu/JjMaEVJ06ZZqBnNMUlK+hK6wai7fh23ev33MRrGgmpIm4PSNyH/Sth3Jq6umsmaYFHs/WTp8Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3287.namprd12.prod.outlook.com (2603:10b6:a03:131::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 06:03:09 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 06:03:09 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/pm: display vcn pp dpm
Date: Tue, 18 May 2021 23:02:33 -0700
Message-Id: <20210519060233.13597-3-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210519060233.13597-1-david.nieto@amd.com>
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
 <20210519060233.13597-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 19 May 2021 06:03:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c90ade6-fcde-454c-c8cc-08d91a8bc6f8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB32877C303556C84A28938072F42B9@BYAPR12MB3287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:208;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYdxeDY1gM12qKxhjClqsG66rwXqSVu2OBXqp4aanW+57wSqTtKD1UuptQ8YNRx3zaz2AxOOkhTnwmvt0TDodbRVIKbAirCRMGh3i9XiMibr3RKnBy6WLVFGf2kKZNrLXbgIBgGEfgeUUEsHLKLnseIY46ekl3SfCViqowLgoebwUUjlIG6/Leymq6Jg8rSAWARXUXg/6xA5Q9K5f+K68e/3nXShWC3tUIno7Vb/3Bn9RtIS6s6MgWZfzo24djvTpOUqd8m7Efu8trvUyT1wJfN+Z8SeqP9XBvwXRdiyVaFQ8rIjr5kMTPpH1h6W3gncBtfN4j+aYtkPu4/5SeaD5NmcxNYtpwoTvfmh5iGBbAGhqdzK1h7HlC3OlJ5YkNg9j5AdENZDolWezawYXX+Tfo4jL+Q1rVdLxamcxioabiC+fCHnOma9T5OP78TBOBB9edubjYwrRsC7eIOOyCjBnRB1ru7wgu6IqZQPaqc50p6gYkr/K4Ur3cq/osY+mbprB5G1+5WBBhaNslpLlSZW0+J0kxwbBwGEDUKyw2R1nHQMKmtT7uDYrm1JzSbrhHPGLdq2/rLK3PeDPU1oMv9xDq8tkaoW1DcPZDfd+x+LIWwoOt5g4womB0bgkBdOojhAp9n+s+pqvGdz43QVZL24TSQfAyPb62ADYB4rtSb3mp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(5660300002)(38100700002)(66476007)(38350700002)(316002)(66556008)(6486002)(8676002)(66946007)(8936002)(6916009)(2906002)(7696005)(52116002)(956004)(2616005)(26005)(83380400001)(86362001)(478600001)(36756003)(1076003)(186003)(4326008)(6666004)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?woaBWdwOVfem2Ew1HzhVxm2qwwna/kLOqWf7b9FWXuZlwE8gJC/hWClyjiYc?=
 =?us-ascii?Q?fIYuDOLIHIuXP5O15PEoBmqGpLuunHd9FYy5LS9062aH/LyW1GBeI0kwVVnh?=
 =?us-ascii?Q?N8ysYDxnaRX2WncqSLKmUcMTYH18lqLW+P+ffZOfr9ccHFdb1cZeGZdGn+VB?=
 =?us-ascii?Q?1rWy7IYRq79WCfbh7tSz0LCBWJr+pd/8WFs8i7ux/k3jHwiPtIC6nwistibS?=
 =?us-ascii?Q?JCXbCdBlZxa6OKQutJ24xL7VaDp51gmIcb0qLU6K7dMfHUZCBjD3EPnCJ54d?=
 =?us-ascii?Q?xAcphgpONPXJQV06saE5q8mxQZE+XGMX4B/PkB/m+5/qAgGbnuXUnVk7BLNx?=
 =?us-ascii?Q?KhG2tCx2GQMxqsIWB6XRMMGzYDJMiiID+VQIoxjse7tavkCPCPjYlxdAFVD4?=
 =?us-ascii?Q?c9Zs+l8V1vIZtXo1yb6o4hbR/GwfXzQ1yLw1SO/xvBWdJzkmhnoPjIuElXIV?=
 =?us-ascii?Q?mY6PBA+Hx9Kr7/Mqg/HRCD0MGy2JS3uPbkcLH9Bqz+7tSQCrwVHDS0INVzOW?=
 =?us-ascii?Q?ybYlHeXsrlW/EMmaCzKzC8ytKEd9hZCcF681bH7HYb2016odstoHhzu9xqHq?=
 =?us-ascii?Q?wcF54jkjofT/RuSofRC4aMPZbleeEtJ1lKwFHJzevQ9iBbNIR3cQ/MufTnem?=
 =?us-ascii?Q?nwDiUTF1rvg3k3RcQ4hfxAuyoVAU4th685BfrGA50tCxe/5NGOQdb+vTgIT6?=
 =?us-ascii?Q?bGZmytdQi16oFKY/yTGn6/KjvtGofEsrZPm/wUpIj8glXuIy/fIa8zhz0YBN?=
 =?us-ascii?Q?FC23z+/NgG5EodZBc5SrDsfs8svBfOxNkI6t+WvuTrtruNli/pxKHjr80gx9?=
 =?us-ascii?Q?t2ghuqPsZvJz09RH7jVgDVY9F6M7mgvVGi7oWxGNfKr1QgqjfNoWDd4cwkSq?=
 =?us-ascii?Q?EvXtYx8AM3wdG4U+szcISqrG7zVB4AY2rRhoDb0o/MJUm9rP5jl70W13YwtD?=
 =?us-ascii?Q?26JAtgSxlkkzfvxjtuWQ6disP3HxZCbqO3tjt/k9J9gqBFb6g4wr3ZKfUomI?=
 =?us-ascii?Q?dTDJBu24O0rznLKYhYpqxpx/smsdNJMZBDM80uwk0iRUTMv8/8AtoTGbNaA1?=
 =?us-ascii?Q?9NXaAtfs5etXnNciOx7l3ETEbpxpGHtD/0e7q9L6c3LvsnIX1NwfbVGrG/XG?=
 =?us-ascii?Q?Yv9kniXlGYeyPGlJuIZOYQBcqDfWH13BDKjUwtjrs1N/7IfWBbicOWftt6mA?=
 =?us-ascii?Q?SF1VOoXOd03n8oArWjR7qK3EuZQTCrlj+PiI+e0mF5b1BLpvaWAQmRQnKJqx?=
 =?us-ascii?Q?X5q06a+c/gOIqdf3KUgpYa+rb9bcKD1tuzVBx2bEPdVc6UFHvy6pHE1cdF/6?=
 =?us-ascii?Q?9VdQJiJGGgujuCBkUpN3aWzh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c90ade6-fcde-454c-c8cc-08d91a8bc6f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 06:03:09.2504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQX0LSNPH+4QD9zc2WPsdILrLQAXIAxp3A7oTWZzEZuPu0QHLvTAJ4SslKTfrsg+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3287
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
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 46 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  8 ++++
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 34 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 46 +++++++++++++++++++
 5 files changed, 136 insertions(+)

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
index b8971303a873..7763de464678 100644
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
