Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A4C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 08:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5738C611AB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 08:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5738C611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0605789B0C;
	Thu, 15 Apr 2021 08:18:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770048.outbound.protection.outlook.com [40.107.77.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F285F6E4EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 08:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWcsEqHoKQMni7jUyN/JqRv9q9ilJsOMFYeTvP8FXsSzox3Y0oOeeKXy7dP0m2mmh7Z0cIuG+zDe3S/oArHUk08ivnbCweJ8lNKs0eUsmcmq6pTt9xRl7VuDgxc99ZeSgQvHi94MHf8C2NJ3Lh6TVzPKAw5cUEXxTpJ0P9wkffI5zIOTOh9yRjdpxJ5tDjrUYpfY0jjwDq+tOPVRE8By2AVN1YjmMrhHNeuwj2xWoSOWyO6+Ufsf+3MJGH7AC3RQimda6lnQ4qc56kM1rkOwIrSX7IrP/nlUTW9VU/0iF4dMoZh89bpoyWzs/bNGP0ePh6qqvvruND7qlQhHmT8wYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh+ndeKPFH9vEZ5Jblmlprf3dABDMPU5b1UB3KmnDOA=;
 b=HBAyL11+GegoG53H8j8shTwDa5HgP7E4raR9/W6JTvt6RB5usvx5IbHy8gzlCkODtVAOvkolIQWdp8spkIgs+u/PEElOIadYvmDq1ts1qzXNbvklgK/G/xsfdHXQw6leiagmmkmzXBPYdKWFANb6m0RDRVI5U3XnheqDXYFHEDOxObGSEy/vnmZCBhrRoF/V+3rAQINMbrX6+Qg5BJr0B9pCE69VcpNgMl9FaxcWpnUIzTZ2kSmcNMA+2rwSd9MdT3yDpU0nlgIqE7kX5jhLVU3rnBkbI0lVe408rm6bpC2KKG98baFJOgecp7RyRFHqb7Gf5m9UEGi5zD5jD12O2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh+ndeKPFH9vEZ5Jblmlprf3dABDMPU5b1UB3KmnDOA=;
 b=caoliX5XJjx9+mAQQRjvyC1UH7h2vM+fjQN1yrV0qs66Tsh/4oayh/JQfxiImljOvw+/6uL+dLq6euuLmDSyIKXTfnrsdaY3q+nVPE2vVlSFarfFiDE2KSmbGPH2gx8c6WKwOVmliE9v8KHkvX4QVvPH+TKO23EQCvatL30Dyd8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0128.namprd12.prod.outlook.com (2603:10b6:301:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 15 Apr
 2021 08:18:31 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 08:18:31 +0000
Date: Thu, 15 Apr 2021 16:18:08 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amd/pm: revise two names of sensor values for vangogh
Message-ID: <20210415081808.GA2286253@hr-amd>
References: <20210414072555.3279250-1-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210414072555.3279250-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR0401CA0011.apcprd04.prod.outlook.com (2603:1096:202:2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Thu, 15 Apr 2021 08:18:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 518562ec-1919-4618-b49d-08d8ffe70d8f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB012826EAA8767F4A10FFE203EC4D9@MWHPR1201MB0128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBv2XOZF4pP6+rzgsXu8ER+l/SYnW0xIJ+zXPkNR+FCGDtn3WRQXorOap41bVppiHNaDUzVu11+y/3HEre7sfQ9u4Ws3pYEa1tVyhexAiX0kHOiNIcB4ULYZZen4zUK0svZeX17kc4KFReoXj1nAG3rxv5r67PLxizOtiXsEt/o5EU+zGRY8q/PtovY+bjsDNViWk0k2ucwJPuolpsy660Mh/RGtxNOw65CySgfMdesfXIBVbYClAGgLvPPiXLIXNvrqwRrJwvwbN2L1dJZGIRPlSoxejqRNbDCuvYaPXzsQJT39dRDRmDT4jKoiUwMTIqrf/fBC+xQELUVLo7xKs7f6uT0HR8HhqelIUkw6EUiL0UkjvXf4fBjWZzZKf2Ou3Ij4zJflOgcipWAiwny4BlgaxJQKjU5halsuCf9ZZ4YCJ5Tol6T0xwW5LCz6FVKXQSVy4Qj0lNtF6Vy92CFSlWwOy+5k374+Fc00gL+6Fsan0OTGa8eKFu9KKrwmGXM4NPoM/J5wuvGynVGzWBblKlt0r/T+wggs66QCiHX9SlqPlpKh4K7Yhzz0FrhUrvj/K8WmhCtd2mxYKIqdQrVXf3xLHJe3Qp0h5Z/m9CVE1exuicUBjcFiudCb+tTELRwi3KXLe5V1vFrjee2c3pnhYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(956004)(6666004)(8676002)(6496006)(83380400001)(66476007)(66946007)(478600001)(66556008)(38350700002)(5660300002)(86362001)(2906002)(55016002)(9686003)(52116002)(38100700002)(4326008)(316002)(1076003)(16526019)(33656002)(8936002)(33716001)(6862004)(26005)(54906003)(6636002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fupSU3ey58GTrubLRqfx5ui/GOhTtxVd7OhOjoy5hsocQ83CcRIhlSwmlf2M?=
 =?us-ascii?Q?nFoYrXV0Gg80OVSUfoAPYgFK8hUyVP7ZnraPF8kGQbKTUh2l1h+n2lzjmEjP?=
 =?us-ascii?Q?51shRwLblpiEE7RGUI0xonbRw10es+Xf7jNppqnV0rXXIGAaKY3C7AipgQis?=
 =?us-ascii?Q?cgt6xtMi6wTkKffrYnQNRrc/ACekYfXN2fBlxIsD5PEVoQUbc93aAjjrtPw7?=
 =?us-ascii?Q?1ao9Nnja6r9DSVONdxqd1DsJ/OTO8E/7kLGhgmo+Z/fjR4o+Is1o488Antig?=
 =?us-ascii?Q?gkAdP++3gDGdeknANT+XoP4mNVVsSpQ6c8/ODxciJIZ75C4gAm0KIqVP1FHH?=
 =?us-ascii?Q?54gJ7Lx+8ZJ6d2l3+XFaOIYX3x6qpLEiYo2icxrheJ9L9OIzI+dagfeGgZut?=
 =?us-ascii?Q?fxiBNc/BNjTX/I1PCEaVRnpSFk2SkuqheG+wvNWt/nzNqlvX6iBSMZ2Fs4m7?=
 =?us-ascii?Q?LBD3GNfSxO61NUkckifZbtR++XvKtMxih1rtNVF6+FL3TyYfH4UuuteI9XFu?=
 =?us-ascii?Q?5QERSVIXBiHF3MCcWBf4J9011/iqlNXL22uUyd+9xdVPyD9P8By0ioERKRwe?=
 =?us-ascii?Q?e87KcCI/HCDjfqPOF7L5yarvuF+4FQAbkrBvagsei9j9pF9qfSTz0Z7RNvqW?=
 =?us-ascii?Q?NgmBuEvY5Krq4aKfT+tzzGu5WmPmOuS2HBcRlaeIGnHVzL2OdAjgdMnAYj7l?=
 =?us-ascii?Q?F4g+U6rtiDXEovrmh9BUQpmDeVVqtyVg1x4cbGnnDfGuAOrrs8kkCdZCwYQ9?=
 =?us-ascii?Q?4IKnfuCNfOwSCQ99uRNMlRjwwLVCmwsf4AZRvSSv6wx3UG64vQ7s+DTwFX54?=
 =?us-ascii?Q?ltJaDYcyvQrrjhUD5wzS2lNDuTQgz5/Yq3zbOuz3HJHqBNlV5OhRQkpoZmLy?=
 =?us-ascii?Q?acOYB2q+XvHYUoBhEvs99mkgLeJQd2DfDHUx6x4xPRfqantgdwKy1avx1fJA?=
 =?us-ascii?Q?9lrCEvjqK7ifhwZgemwqe9ZYCtJJOrutApysTH6KLOVF8cY1dE+yKz+aqa0/?=
 =?us-ascii?Q?yEQPOr9ZUOwvBY2MaIVaibHp5ipo7fVVlMjuqiVquz+ozUAqVKZzHKJgKTR2?=
 =?us-ascii?Q?YwyMrQDIhYs2stDn4QZOc1AfdjiueNkamcIPZ9IOuwGK56hAP9k7MP8hymt9?=
 =?us-ascii?Q?zAAwZRTk4KIEK/RIcEQ87UW2CY1m/PXH1nB5iiBtLwxXK0dIFGt2/LadJWQV?=
 =?us-ascii?Q?FP5NdMzJFvlGS3+vNXCLREnc8GmH7vzF7t86+RrIQmfbgQv658dI6wvnYbHr?=
 =?us-ascii?Q?r25LF+JoLTQqOx5Ad79hW72JRp1kpL53Ctd3KYl4Ez4lQilB8duHHec+uObV?=
 =?us-ascii?Q?5pTi/iIk1bRhsFJu6XEhVmkI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518562ec-1919-4618-b49d-08d8ffe70d8f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 08:18:30.9082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTwK+mqYqmviMqVpKY/bGdpeV89BgqRV27MX4e2mCWyJ8n1UsIvYSmiUc+deAYkvfhFJtEFs17nxZlw2XcvXbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0128
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 14, 2021 at 03:25:55PM +0800, Du, Xiaojian wrote:
> This patch is to revise two names of  sensor values for vangogh.
> New smu metrics table is supported by new pmfw
> (from version 4.63.36.00 ), it includes two parts, one part is
> the current smu metrics table data and the other part is the
> average smu metrics table data. The hwmon will read the current gfxclk
> and mclk from the current smu metrics table data.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 35904315c1f9..77f532a49e37 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -270,7 +270,7 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>  	}
>  
>  	switch (member) {
> -	case METRICS_AVERAGE_GFXCLK:
> +	case METRICS_CURR_GFXCLK:
>  		*value = metrics->GfxclkFrequency;
>  		break;
>  	case METRICS_AVERAGE_SOCCLK:
> @@ -282,7 +282,7 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>  	case METRICS_AVERAGE_DCLK:
>  		*value = metrics->DclkFrequency;
>  		break;
> -	case METRICS_AVERAGE_UCLK:
> +	case METRICS_CURR_UCLK:
>  		*value = metrics->MemclkFrequency;
>  		break;
>  	case METRICS_AVERAGE_GFXACTIVITY:
> @@ -345,7 +345,7 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
>  	}
>  
>  	switch (member) {
> -	case METRICS_AVERAGE_GFXCLK:
> +	case METRICS_CURR_GFXCLK:
>  		*value = metrics->Current.GfxclkFrequency;
>  		break;
>  	case METRICS_AVERAGE_SOCCLK:
> @@ -357,7 +357,7 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
>  	case METRICS_AVERAGE_DCLK:
>  		*value = metrics->Current.DclkFrequency;
>  		break;
> -	case METRICS_AVERAGE_UCLK:
> +	case METRICS_CURR_UCLK:
>  		*value = metrics->Current.MemclkFrequency;
>  		break;
>  	case METRICS_AVERAGE_GFXACTIVITY:
> @@ -1529,14 +1529,14 @@ static int vangogh_read_sensor(struct smu_context *smu,
>  		break;
>  	case AMDGPU_PP_SENSOR_GFX_MCLK:
>  		ret = vangogh_common_get_smu_metrics_data(smu,
> -						   METRICS_AVERAGE_UCLK,
> +						   METRICS_CURR_UCLK,
>  						   (uint32_t *)data);
>  		*(uint32_t *)data *= 100;
>  		*size = 4;
>  		break;
>  	case AMDGPU_PP_SENSOR_GFX_SCLK:
>  		ret = vangogh_common_get_smu_metrics_data(smu,
> -						   METRICS_AVERAGE_GFXCLK,
> +						   METRICS_CURR_GFXCLK,
>  						   (uint32_t *)data);
>  		*(uint32_t *)data *= 100;
>  		*size = 4;
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
