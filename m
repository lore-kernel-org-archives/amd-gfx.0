Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE96C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F04521D7A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F04521D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748ED89DC7;
	Fri, 15 Jan 2021 09:34:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EF289DC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 09:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh2efDe3TPr2VIXKqKTfANygiHs7lpbE7eLnCocPiT68D7cCkN0PQ4fnERaDKDpInfY2gtk8cNYq8Ru6GAZ07SKGA/y1k2YG+jB/37QNaMLLJqX85ESy+6lVxhbxfUKQ69G7ko+JpQXVD/a9rrPjkaqIqitHokFJX6HSnh56ISqBN06Be05voH3+IOsQpSS4Pu2hgKgQlPHpKN/C9YMolWKc40zvu1tNALdk9v6tBrY8b7sfi6MQnqQT5Pm7vH6bWGN5FU+VYifkSwwAUxBjuFP0XmJtevilmD7FjJLXtZbogQUZXrl5bEiwmgM7EJL7nFOHmlUf3tijo4Bjk0wdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPU7Hg9Vej5VzYz+MPCdERQ8QNmRKfOEOS97dUWn4D0=;
 b=SfvCDNtBrF6b3VtKzwIEtTjRJZM9uHw9horz4VpFWtJsJ59KvsSyI1iZLxj79aZrcbyPHsc3LTleIYBIis4cgfVFVMUOy/ReThGETNMWzaJpzLvB1C8rkzW5VMM96GZeGFTzGlaODYFaKOf8rX8HsN5F/dnOAxI2y1uJkKKNAJd7tJWbfI+2XAqQrNeTwdYY3P/P7vy7qoP746hFL1OaFuBQSx+mPxjId3WaF1sCryRCBfW1KxNADtHuEdyVFxwP9xq0tO0bWObUN7XnPYXy/Y6Dg+bwSp7lfnTJR8ySsPAn8E/+pW6NZ24X5t1esKqBrJ0INObXxUbiPFay+LQ5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPU7Hg9Vej5VzYz+MPCdERQ8QNmRKfOEOS97dUWn4D0=;
 b=DcFOJ1XYVj5LUtdvezd150w3GVaYe6M76MaVD4wSsWVZU3Mh83F8Ydzypvvh8pPoxL48dhvbiT0yt690CflJiBmLjzCxl6+uPQLdNu2TRGttonZt1cEroPT+4LwNsau9Enpj7vAd2MoiTUOSnO9hWF/L8OVKdFhsvrPu4c2IlwI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Fri, 15 Jan 2021 09:34:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 09:34:25 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Date: Fri, 15 Jan 2021 17:34:05 +0800
Message-Id: <20210115093406.389563-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0058.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 09:34:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 747c82fe-13a2-41ef-cc51-08d8b938bf0d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2796B4769B0B8C26B3274992E4A70@DM6PR12MB2796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/Wtmy7HH07b9lHXziJbPZWdk8AM1vqLMi+6GngGeAsJvXaELzdEgtJZi/KbG8SDRZjUtOGwulvZxmWNFoLi8v9Gg3n61XMQT+Iy3MMttOJWWwxv4pWzg0nwRaoo6t9C3GKiV0Dze8uuR7TeQnVGgweFlpGv6g4BgdX4EVfT8F8K67+fggiO1iUhOpauSaSLfkjsloj/TRMRB+2VmmBe6d9qZSbN7Qzpa4+5n4e4LDD0qkrid/UcfXgbmuzB5jKkXWrbe9JnPNjDf0j61Wr3/+QfwNW2CFjkETIs6iXeCuXziUvYC5oYWRPGV+2lDqXGBR41JJvbgYKQuZ6W5F8WaO1960M5pPXu5XEnw6ig1d7h6rjVqEOdVN0rRmpoMF7rkWC+PYnS2DAm+qYbCTU46k65E7Am3iqDEwAgxlCny1G1eUulHKfHsNgzN7UvCC2m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(26005)(36756003)(6666004)(66476007)(66556008)(186003)(66946007)(8676002)(7696005)(52116002)(6486002)(6916009)(16526019)(1076003)(8936002)(2616005)(44832011)(2906002)(956004)(316002)(5660300002)(4326008)(86362001)(478600001)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SrZmHJH/6AFFjNHc2Og5IptMT+Zsrn6X4TFlF70Q/wBy5sTTu3i8GsY5WdRx?=
 =?us-ascii?Q?el18k7G/uKNgpDQ1mzx/e2+TrGdy6+QkYvnb9D2/GjfpfT/FMrWk+mwyDt4I?=
 =?us-ascii?Q?X/KU62ZCGd28hAjTqSTsEQHeArjbuSapa/8p7ciwfH9WsDelfVD99fiuWceb?=
 =?us-ascii?Q?6W1uO4y8rRJT3ppdVJvZJfya/poJ3JUbnh82qIzM5v3jl+FmEP/0fuuB6wsw?=
 =?us-ascii?Q?TaMmYRGqNpDFQtuC5ET1xB6E9Owv6IV4nVZy42zKwaAf6IyGL1np/vy65Joi?=
 =?us-ascii?Q?8J4ZXNq10RaXpFQf3RrvQAog6s2jDTKqbEtKW+vHwOYjR/0UY+cDNTdAEq+D?=
 =?us-ascii?Q?YLYOig+fROQ9h4wdOINsGA08tkcbuspYy8YYVPvCgcMJ9bSx38ZqVYHLHghK?=
 =?us-ascii?Q?JTLvBoAktmTf3j3uM6vrMzduhps5ct5yL9rFN8EfXhdlwsVig/pHYNQiiF+B?=
 =?us-ascii?Q?T7MuIWsRVazNhUeS4pZ9p2Fqg5qpmIGXTxIbzmJARyd2KBcV7RdLMTwpDveT?=
 =?us-ascii?Q?A224V7H7yFNTtXnNkUIMqHi1a0+6sW3oj+BdSh3WOFefWkzxh+LTP6xSWS7h?=
 =?us-ascii?Q?0WiBuJGB34MGJT6kzCDQIABRW+CuLlZs0jr2Ia9JirY6dFgIwLajLxI1JJrX?=
 =?us-ascii?Q?BHISk56Fg9w4tM6QhD3/BwN/XihZwOVv1HCtyXCbaGej5kVpamIQ8iG8eWBv?=
 =?us-ascii?Q?ImDrlAt86kg+kelaPw1eI/6ZjYjN2XDQHK4ldYn4QmGY+7qWmSnXklsrJ4tC?=
 =?us-ascii?Q?7tWGPa/JKot0vTBHnmd048RhUG5vqVQnIkF/JyehMx7A2/YVlEnyFf9p7a9E?=
 =?us-ascii?Q?0sfzjGThMkA0h9TPFftse/GnU/Pu0NjxBW5harsP4vIs25IMA5qh26gRs5cc?=
 =?us-ascii?Q?by4N3MKxwM+UNs2Nm/YvBtBAJDuaKW1vLpeFoLutLh1yuDpX5Qof/WIQGYuQ?=
 =?us-ascii?Q?W6SLwyyYiU+kw+SXAzSMA4uK98PY3qx6VGSgYgBqpILolSpkaOisACkcmaOZ?=
 =?us-ascii?Q?FPcd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747c82fe-13a2-41ef-cc51-08d8b938bf0d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 09:34:25.0003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATDi7E67iQKgVgavjh3G1a7AZdvRxrlUMv3qXbq3DzfntXNTMc1uKoYjqSJf13CL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support Navi1x gfxoff state retrieving.

Change-Id: I57aa506b82dc122bbead708c580a4720e536cfce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 13de692a4213..2857f1bf4e9a 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -287,5 +287,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..93a3b6b60c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2482,6 +2482,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..50566c613971 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2127,3 +2127,27 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+/**
+ * smu_v11_0_get_gfxoff_status - get gfxoff status
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
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t gfxOff_Status = 0;
+	uint32_t reg;
+
+	reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+	gfxOff_Status = reg & 0x3;
+
+	return gfxOff_Status;
+}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
