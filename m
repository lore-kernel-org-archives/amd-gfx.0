Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCE7C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63F161209
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63F161209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AB16E2C8;
	Mon, 17 May 2021 06:28:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04C656E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 06:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCNrA6gHMxWQNQs3XFBGLpkcMpZpvYNOIur2l+9DGsL71yefbyR4JIyJhMLiAjzYQRCquNh+cJ8ecIUUK5ZV/Twjng6MKl8hcJEL6cBK9Bza+6qVfeBkb7Ws6+f2qc0YYWtlnFZBrXJc4lhfaklGumZKRyUdNyTxzjal7fzpZJ/ksHOh2PLar5bCAstg7FGI52tbc36lY7HMbKaEUMIHeI+l5YN3l7tIeZHITDSLDpx+jX7DeIUR3FgszcXmH6K7IPFa9X8XR2mQawos06vkobLQcTAXM5wcX/QhIxsrmS11GMNmPKRqKm/FV+2kcbTY9IwvTiuC3BK0iePu4GXY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07EIym2wT/UsTjj8l1vjkl8s7NXbUpdpTOYvO6GGFbM=;
 b=b9jss+8mfcaG4dkiMZG6h+Rei6bT8W+gPW9BsE3pFbnGH8E9jUOgLck9AnPXUCCeCr1MJrOGMElGI3go17AjcBeR4WjrLUjIPgywdEEm9UJGsAWVffFIu5qPzBp6QvuKo1zOjZw2Bg/wqy+ug/2QSQ9WKNDITirxLqBI7aYe9byPZXWp/iDZVsEF3OVSxbwluu9IvMvVkmNFi9CzQHN4H/ZAAoLCrBDHDvdcLcTBsljhAaIpiaAESF+BlKjQUUoiy6i2dmoEBt1D2vX9/QPKySv5xwCbRdC7H3P8ZqltPlN3Zc1IM1ftDF1rqvoD+bxAAo6wSc2iHC6X3SWCwamG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07EIym2wT/UsTjj8l1vjkl8s7NXbUpdpTOYvO6GGFbM=;
 b=FFVDUL6PPto3ORNcCUnyTGeccHzPh8R29cDbKHz2DOq4Pudldmq6nYCyA8VQgLNFj+h/ss+HxfUKzt92M+WH0CrQK03ujiM4Lla2ZoggCyeUcY26tBieGeiXHQKDMLo3HE5eRn/peZUQJ1Ak0QiiaSsPi+RwhSeS5SYRNy8siZ0=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 06:28:08 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 06:28:08 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Nieto, David M" <David.Nieto@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x
Thread-Index: AQHXSQRgyiwW8/Ufy0eEB7lWTGk9AarnOOqg
Date: Mon, 17 May 2021 06:28:07 +0000
Message-ID: <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210514210135.14079-1-david.nieto@amd.com>
 <20210514210135.14079-2-david.nieto@amd.com>
In-Reply-To: <20210514210135.14079-2-david.nieto@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-17T06:28:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=aaa0e53b-1385-4432-acbc-fc3c9e16b153;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5753581e-e5d7-45c0-9e91-08d918fcefa3
x-ms-traffictypediagnostic: CH0PR12MB5236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB523682133C02321711C284FC972D9@CH0PR12MB5236.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdpZ3SvKSpPurCs9a+5sIIv2/CxPMBetikRwOV1IOTtQme6jQChJAy7HAWfT7VMkM6N5F7JBQXNMS309tnKPDPHj8NTnQoKaXqsMDzp04NoPfXoo9UwED5rK2UV+1VRkF70zcGUKhThbuxxlouM9wBbh6AE9a2ImBpC8QMiyCVlae29IrQk90DNQp+LuiQCfxM1Afl0ACIbsUGOL6prxZasnScIqSjrR5TB/dey2BVX+yJnrcWC1q0tfY0xb0KE6TKELIT/czWBNVIxSc/EyxlgzemTHInW1LRtBPVdJ2x2rJDBHX632KhMjPDgbNzfEE7x/Pyznj4Pp7miN/BbDDbybn8fjj4n3XoAhH6Dj5ti1sy0AkmpKWj3CFXPkat38phJbWWu/+q0/K6DKEuZuSy4VTlRlc/q1QG74SQR4RhHaDbEbw1QOuZ/4Y1Av1bqyBdO+8pZiLGF0xYYcztyW+sYWF+euPpFoU1cd1vvToZOu3kG6NfpKBpaFDXoHmL3b8mzkwkTkybMdbqrpVp+RI23rIgAgI5A4k/hm1LtEbIL8WNZsSZZmQhEtyjUNHXPFNe0e56/lj8Oh5s7HX/CdwXHagWzlMw+EXDGSdYPtbcy7TqkjX5DXEMZBfrD5Jl9s6aG3csHQ/SCTc7W4CrB0493HLnrT1Qp2C1tG62+ylvXcCMrrLNWM9p2zqSQxVkmK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(966005)(83380400001)(33656002)(76116006)(2906002)(478600001)(9686003)(19627235002)(7696005)(53546011)(6506007)(86362001)(316002)(5660300002)(38100700002)(186003)(52536014)(64756008)(55016002)(66446008)(66556008)(30864003)(8676002)(66946007)(122000001)(4326008)(71200400001)(26005)(45080400002)(8936002)(110136005)(66476007)(32563001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QPY8lWhoUkAAffMp2upC74DMfuCsOnxFduA6/0FsRdA6oBssDocMCUBIr+5r?=
 =?us-ascii?Q?7ZyflwwjJ4HmuJ3PdXpmi9GrtAIY8mkL5j59EoXYK0mHK1tG+YpbeyhJLdGw?=
 =?us-ascii?Q?/gGhGAwLQGzzz2Y9y9CBr0BpdkmnuzzMyi3wuoueJhT8XT9ppANj4cDqY/w5?=
 =?us-ascii?Q?j9DAU5fFvRX9w8fSFfvW3aQtIqIukpGMBb4G6X4kCfPpTEgSgEJAYfCN+7Cr?=
 =?us-ascii?Q?NFQqG93MERR93r7DFGiDuFLQ4YoguwvQkVrqvyvR2U+gUNtDtYXYvbnf5Osa?=
 =?us-ascii?Q?QtwP1iEiSOpTw+FZd/WICxaaAwfcxvT0q3XSP7DRzbJzIO3rNdAnjM3RvjlM?=
 =?us-ascii?Q?yMr483jVpDmNA4BnfFCjknsti2oPp72ulMJpElDsiZLbRS7XuhQBR7HflwKA?=
 =?us-ascii?Q?05xRyGsLerI3zWkbbEdWv/gIEm/mYuqFZcUKiAhMjdboZicVYegETm+99qLF?=
 =?us-ascii?Q?Im63buo/UAqYOWLeutdjeTlYkBjagbrus4yAS6hVzFLxxb8/Ay/LTabARx4i?=
 =?us-ascii?Q?xD1hzA8lBTmi/LzdEv8rZ0a3srGfV53Rj8hH8qOGjXr8zwxMdqdtpIfwwy2P?=
 =?us-ascii?Q?x2mUemn1lb9JdoSlXN5iKMYlJ+GgmaTIP1wLw/Mp/29/4VDABDjORBWR7BQS?=
 =?us-ascii?Q?irV6BW2i/5JMkptvEhP8KZJsPM9a9xqXvvAZnYNUghYrycCkmmdpfYxt4xUD?=
 =?us-ascii?Q?thcDrYwEUV0CgVut+X1q3VW+ztjsfMRcklXuY11rPZcmXcsfkVdC+dTn1RxJ?=
 =?us-ascii?Q?dq+pvV1J47mMmdco2R6OgafEWYIA/DMjJ25O4f3sMXk6gQuRMah9Bphy5b42?=
 =?us-ascii?Q?z+Xhltl+JUwh1dEcEqygTpAYaPeOL6p+bmJ5IGvFhnN8BP4KdQ6I4pc/DpYK?=
 =?us-ascii?Q?W5PGWNYzW7ulPthXemaabEiE+H01xU1KeMPjqU3aXnjnHUzSyqayJavecjCA?=
 =?us-ascii?Q?wLJwf7GIWg5NFMqy3aKu6djaCDOACNbVgzKtXLgRHuZxvooBG1GUbg5Q/G8d?=
 =?us-ascii?Q?q/KokzZN53pMVTIzVgW7NoNbwA3B9plwM0DeasnxVUo7OGZmgqrtHmXhmo8a?=
 =?us-ascii?Q?qOLv6nTAHBlGWVHtWuPtXTBXYuHYNJYseVQ/JYseOvPQqACu3iAJ4Q0uZPak?=
 =?us-ascii?Q?9mLfqcSIM/Ls/Mi3lZDFaZJ8H86jjoE/QuNZjfaSRQzUDt1CwSHXw4SrD5LP?=
 =?us-ascii?Q?88bQSseVdHPMgk2IixOzMGbqX7AT014rubS59BIcbxx9qgMtsUeUknLxVNvt?=
 =?us-ascii?Q?V0CKlL0UC2COlF3mQZz1PJR2/V8q/Oir1DFreQIYGjfbPcJNbq0NXoFTIo74?=
 =?us-ascii?Q?EPijKQRFQcm3RebGaN3eelvL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5753581e-e5d7-45c0-9e91-08d918fcefa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 06:28:07.9962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdEhCIqmPpbgOVYQ1YgBH+qS7LH7D74IyVs1FOXxFx5LGjKOtxpBlx7dXdVrw4/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
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
Cc: "Nieto, David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Metrics table carries dynamic state information of the ASIC. There are other pp_* nodes which carry static information about min/max and levels supported and that is a one-time query. Why there is a need to put everything in metrics data?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David M Nieto
Sent: Saturday, May 15, 2021 2:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Nieto, David M <David.Nieto@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x

Fill voltage and frequency ranges fields

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: I07f926dea46e80a96e1c972ba9dbc804b812d503
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 434 +++++++++++++++++-
 1 file changed, 417 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ac13042672ea..a412fa9a95ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -505,7 +505,7 @@ static int navi10_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -2627,10 +2627,11 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2646,7 +2647,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2681,19 +2682,119 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * 
+metrics.CurrSocVoltageOffset) / 100;
+
+	gpu_metrics->max_socket_power = smu->power_limit;
+
+	/* Frequency and DPM ranges */
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_dclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+	if (ret)
+		goto out;
+	gpu_metrics->max_gfxclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+			gpu_metrics->max_gfxclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+			gpu_metrics->max_socclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+			gpu_metrics->max_uclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+			gpu_metrics->max_vclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+			gpu_metrics->max_dclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_frequency = freq;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2709,7 +2810,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2746,19 +2847,119 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * 
+metrics.CurrSocVoltageOffset) / 100;
+
+	gpu_metrics->max_socket_power = smu->power_limit;
+
+	/* Frequency and DPM ranges */
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_dclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+	if (ret)
+		goto out;
+	gpu_metrics->max_gfxclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+			gpu_metrics->max_gfxclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+			gpu_metrics->max_socclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+			gpu_metrics->max_uclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+			gpu_metrics->max_vclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+			gpu_metrics->max_dclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_frequency = freq;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_legacy_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2774,7 +2975,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2814,19 +3015,119 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * 
+metrics.CurrSocVoltageOffset) / 100;
+
+	gpu_metrics->max_socket_power = smu->power_limit;
+
+	/* Frequency and DPM ranges */
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_dclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+	if (ret)
+		goto out;
+	gpu_metrics->max_gfxclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+			gpu_metrics->max_gfxclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+			gpu_metrics->max_socclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+			gpu_metrics->max_uclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+			gpu_metrics->max_vclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+			gpu_metrics->max_dclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_frequency = freq;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2842,7 +3143,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2884,9 +3185,108 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * 
+metrics.CurrSocVoltageOffset) / 100;
+
+	gpu_metrics->max_socket_power = smu->power_limit;
+
+	/* Frequency and DPM ranges */
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_dclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+	if (ret)
+		goto out;
+	gpu_metrics->max_gfxclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+			gpu_metrics->max_gfxclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+			gpu_metrics->max_socclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+			gpu_metrics->max_uclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+			gpu_metrics->max_vclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+			gpu_metrics->max_dclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_frequency = freq;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C2aabcce1455c410dec6008d9171b80a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637566229187346163%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NgHqow7Ra1rXTqz4suB8Vv%2FASOYRRJAtCgLUcpHRDto%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
