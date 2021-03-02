Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B72DC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 10:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0424664F0B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 10:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0424664F0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E0586E141;
	Tue,  2 Mar 2021 10:20:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF046E141
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 10:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3Yqx+W56I4KiwFPEd69X1qrQeJVnMY5elQH4zOLFlDf8eSZduOXmHj5MPQkLmu2wisEdUW2QHsnnyuKLzhqXJCPFEAzuXfRbXCsXP7OhDjIP80cwmz0W8xwZGyMhguwp7lTV+x7nbQDYrSBMUmt9EBFF7pbqkSOZKPjYboU+jsVQuFfR55mo6/TzUFZLYhif6eTnRGRCelENrBtG/niJKho2sfWkUhEtAN/Ww3gxrXks4EoaOiYIbwj+PSPXNwampAdCsp5e0lBeo3jWAEaMIMFFI8uxXxxi9s/NVfGXb+gsOt9keVP1Lx5Ju36lgvnulutgSDVQFhfrTsWh5h44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzGOY6iQ8U01km+xJ739lOHc5hGIJ6JUZ83GnqAEmvA=;
 b=G+Uozm2m8uVUpcVSIQeYgUUjCIIBhFIAoo7FKSpB8au5iDOxkSw3dTN+5rdlTyNFOI5usw8MnongYc6cD16DzdwrsoJOzqeewStOU8S2BheH8g6vr6GVfswsa7kf7PNNeVZiMBf0gmxmQv92senQ9zKDf8DHo1KNXlfzDoOMhiAGmlwQlaWstJSY9sSgyS5HsjEDP3es49aiirvRWaW5g/Dfz1C/NedISktaN0L+B+kYUiKv2tpUp40Tmqg4zwqM2PY3Sk/0CFdz1yXilFe1S94JgfoiAnpIzsjG+sAZVyabwz0kuUBaOnNleNTgpaEijmhPZwy7zuZQwRcyCdkwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzGOY6iQ8U01km+xJ739lOHc5hGIJ6JUZ83GnqAEmvA=;
 b=EZY7tC218vexyXuXAK8SW7gHbmA41ruB16PXe9Iwe/fX9A7jAHiTcREsQCqwAdJ5LRFH1RK0GSStR3m4OqFKfgclgj4dVo7FeiyemkjCsRsVy+tX1TEssmmg1oEblZ2/GS69vfb5L1eXAhaG7wsvoRbb7g8bGg0fLowWH5BlQ2k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR12MB1746.namprd12.prod.outlook.com (2603:10b6:404:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 10:20:49 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::46e:9cf4:65c7:8913]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::46e:9cf4:65c7:8913%6]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 10:20:49 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct the name of one function for vangogh
Date: Tue,  2 Mar 2021 18:20:18 +0800
Message-Id: <20210302102018.20190-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0152.apcprd02.prod.outlook.com
 (2603:1096:201:1f::12) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-MyrtleD.amd.com (58.247.170.245) by
 HK2PR02CA0152.apcprd02.prod.outlook.com (2603:1096:201:1f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Tue, 2 Mar 2021 10:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb66caf3-e97e-43dc-1470-08d8dd64d9a2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1746:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB174696B054AFB9C1D1B44C4DF1999@BN6PR12MB1746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOcfdJGYq3kTFnQPnjpQ4q96H4pjDS33pFjjCw1/cdiOJJFUY4hdOSitRhfytQtqBDd0zndG53phmtzbjCXblWRBLEQqUUrbU66gKnAtOjGClUgojWFdA8bTtkyNXd9kWJpGQnhjXUXnyxYopE64+d3Jgpky3/uisthR2RDvoQtlCny0zc0vbOi/vIJraSaQkcs+DyJG/wx49eLlZyEyDvlGwxEyx5Q8qIP65THuO0bDQMhu3AGvoG0c9QwCjON2k0XO0ma7bKAgV7Cu9Dij6hkkyenLZO1LGRl3ftSXBuqE/i/rXuDZ7xGaZNOWO5RpUZwqkTqLhFHp8un+40h1SRxSVB+YLirNuzKC2A/Wq+6XVNf0qGlS4gMbKwoli8619rWZ6NtohsgZNVegzk3NIfjpTAoVKCg6ce4NgbD/zGEZwYIGeVwiI7m4BxflstC5HQHoCCjaajBNjWnueEuZR6l/5sxKPPCbTvOlB4dnuNv1qSv765cFpLKaA++pX7DkekLIx8tF71bEHvPqlRnMLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(16526019)(6486002)(83380400001)(2906002)(1076003)(26005)(8936002)(36756003)(6916009)(316002)(186003)(7696005)(52116002)(956004)(6666004)(66476007)(66556008)(86362001)(5660300002)(8676002)(66946007)(2616005)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9HcVe4Y29DsM+48l+u9fmZSDL7ytoWequpn7MmxwjHZ+Hm/2nwfzjV4mDjCK?=
 =?us-ascii?Q?klvMmEvULhKMmz5hcxNunvuHKYUawEsjlF2JNdaN0Peu+yM/rSvtKkvfDEoB?=
 =?us-ascii?Q?48KcxhzEVFEAwuFCejJh3+w+THAaaBgQmvNc960m5s/3OiwczxrwB0Y9mHiV?=
 =?us-ascii?Q?MiA/OMrxsffTlQDoCzvzMVg4UoodjSvBoMJAwwyI8JPZrubVhxZazzEeR5iQ?=
 =?us-ascii?Q?BUnL6X29NfEfLRJo9JiUvUc5SW0ZccmhI1UkAg6LAsWIv+kl3yMEanVx6ZnT?=
 =?us-ascii?Q?KMy/shh0b8hvgCdtR6yt4hQ4U4hr3SKxEXv19Nk1YZAvWgIXq/V0P32Nver6?=
 =?us-ascii?Q?KtxLJlgb+XyUqyKbeFId5ee2ild8+vtsk5/huUZmORxeVq71OGD+2M2Bo22a?=
 =?us-ascii?Q?73RZnd+PQL0koNu7vRj02mEDhBzUaEwJ/VVJjTAqNgRIdsC1+qL4Jlfx6ydP?=
 =?us-ascii?Q?oy0jrPGdf2zeHPvyKeXJYR/sE8bWnJxBfMinpihczHCU00HCaxC6YsOWQfkZ?=
 =?us-ascii?Q?uf6w6SwCig3XnhiwzutBBa4GLX4tR2cDco80T2jlNXeSILEGiCY0okRWbSBY?=
 =?us-ascii?Q?Okxrxv92eK2UkPFqMl4KkfpBP0FcYxJlsD4s42E4fLJjha3Ypbo6/T/+lPgu?=
 =?us-ascii?Q?LIVrepQ3wXZ/NPP6TpB0HXlGTGzKeGKsn3m5yRD91hAsu56KTJS96AbGF6dg?=
 =?us-ascii?Q?jMNAjQha378DFbx6YniZUWU0a6F2fDg6a4qU0Mw6rnhxX3/k+1IO3d6RZEWi?=
 =?us-ascii?Q?c1RwJQ7BV7Gb4S+DGgaulwKzk6awYsiZq5R0yOWJB19jrB2EYpnadaWT4QNV?=
 =?us-ascii?Q?ZiZ5J+IUz97CJMIs6C9eS4attaUo/h46kqrkSqKgUvGnL6zZ2Jsp8bu3rjvS?=
 =?us-ascii?Q?aflNA2JK36tHZhtLBsvwSOmS/qIw3foPwtK86v91Hqz5N3p1hUYc/wnzn3iz?=
 =?us-ascii?Q?IN42a+q9QtxjB3U5aRKbV8L8sT3kCw+P/Oq/Fc/ilgN/vF9+8D/d6NE9413L?=
 =?us-ascii?Q?YOL3bhF80Wd6bJl1JaRNAuNjmULWMK/lZe8pInbHi7pjrVidgOSFh3n4PXOS?=
 =?us-ascii?Q?0qFTgD9bHwB+E/Hz81atnKll9K6ZsATjY53DOxTVnn8ClJ93FhHQfd8qM7bh?=
 =?us-ascii?Q?vW6z1lChN9hX3r5woMpd4Ht5z7TUvoOTsn1vEbeKVLQsfs4YqbYLlBLM3Bbm?=
 =?us-ascii?Q?dUgK84GpMut2OGOxq8y2BoZDKNUVDIvCAuivyqpEJ4Yicdqea2p7cPGAugpz?=
 =?us-ascii?Q?+dUW7MKAwwk9cee6EqCzGcF8ggGJRnOcRcSK7UUvsOmQC99ibE0GdTI483R/?=
 =?us-ascii?Q?A1dIeHyRP3SjCkoArWRCoBos?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb66caf3-e97e-43dc-1470-08d8dd64d9a2
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 10:20:49.3539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHAvs0HS7e0mU9PkjkhciAD31moMJIb/tJ+xi2oeFcrMB5ASS91VgkmtvAHM+8FeahfI/OQ6XQdjN8IAWj82Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1746
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
Cc: lijo.lazar@amd.com, kevin1.wang@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to correct the name of one function for vangogh.
This function is used to print the clock levels of all kinds of IP
components.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3f815430e67f..2bc55de1812c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -442,7 +442,7 @@ static int vangogh_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_typ
 	return 0;
 }
 
-static int vangogh_print_fine_grain_clk(struct smu_context *smu,
+static int vangogh_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
@@ -1869,7 +1869,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.get_gpu_metrics = vangogh_get_gpu_metrics,
 	.od_edit_dpm_table = vangogh_od_edit_dpm_table,
-	.print_clk_levels = vangogh_print_fine_grain_clk,
+	.print_clk_levels = vangogh_print_clk_levels,
 	.set_default_dpm_table = vangogh_set_default_dpm_tables,
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
 	.system_features_control = vangogh_system_features_control,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
