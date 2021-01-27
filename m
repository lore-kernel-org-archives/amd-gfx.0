Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA876C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEA120709
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEA120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4F26E508;
	Wed, 27 Jan 2021 04:15:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3EFC6E508
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvGPSSLQAlP1SEz9+7iPp/wnflPTngy9lPEsBaaNg4meEv7s7OQdQdc7WlAe32N6eagBoUzt+lBZ9kw19OhCTASa2K+d2ATle4l+g8T6H4P+HrWbXTcmmaGWlDv4O/DtU/4vjaIYJx93KwZLwOOngVr099SSaoJ/TFjlYUhqtnyjVTROw45GQTTyHVkxG4Ap7DJc9apxrRmcKMMecGqpTdtniyPDEQ4y2qL0ZNjqkJg9zqp4c8JzTV7a8+TQpUbL92cJKzaoBUWSECzdT7AyPl+SeF6zAp/2uM2i1Jep1gFg0DMbM0pd/ptkqW02kAth5VIKkNusYp55LGARgDSBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTuSV2QIHNfj8P+iDlF+/rZpR2jAGya59TUemBy85T8=;
 b=bPubv89fwnpjwalXlaLIHUlh731oLgxTYfBBYn/ktvMTnBoWJTU2k65kCT55U5P7uj5TtFUKXy+jUVKFU4zoUvgYysRxkcldSIUJGunNBcmJoFZNANyb/cWy1XaVGtBCX8/pyXNx0zZGGR7WEU5C29bRTnmsVs5phvw66AMz2Hzli34aYdEHrgmv6Xrb4S/wgWC83PhTwS5hSX4JFcszrGi2gAYMN4yc54NX92yw9ClfSz9WTe0ETS1QPhg6KS1BI/bciPBSQ4nej3n+QAJq5K3xsijjXzB+dIdbNl9FE/SzgVQcw1JRP99VhN/Jw/SHoTF3QhCrLO17iN7GYw0EHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTuSV2QIHNfj8P+iDlF+/rZpR2jAGya59TUemBy85T8=;
 b=TxwFhRzAr8//plH8GZ4rQMva4Qcg167YZvPauwkqbB7bA+7sqK/dzNiItXuG2zjokeM0AhJxefYCMJ9uUNepqcbJEFRc2xXTv209SgxrpoC6CD2DHgXppZ1eE36wTAuTyvOR7IQACap2i5WS6xaY0XvxRJSQYIc3v0Ne/8i+Vds=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB3145.namprd12.prod.outlook.com (2603:10b6:5:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 04:15:17 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533%4]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 04:15:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Topic: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Index: AQHW9E2qw5X9KXYoQEKiV2hxl9rWQqo63FKQ
Date: Wed, 27 Jan 2021 04:15:17 +0000
Message-ID: <DM6PR12MB4650AC724ECE20958063ACD1B0BB9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210127014146.10902-1-kenneth.feng@amd.com>
In-Reply-To: <20210127014146.10902-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T04:15:18Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ecda6635-be0c-4e9b-9eb5-2511c521a7ec;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6882aa4-9d7c-41da-ce96-08d8c27a276e
x-ms-traffictypediagnostic: DM6PR12MB3145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3145753E5D8C4CC41763C428B0BB9@DM6PR12MB3145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkCV0o+Qsprwt5VVSpEicjWHAfFPptfn1xC2f7HbYG9gWhd6gkmYD6WNCcsIDNpDsqhaQvPjyC1qVNx6ZUlN1fqEZDFa72DUWn0ZaVokGtCzDGQlKqg/KsgRGgm82imkq1MGko/SywFp21U8vp2QYM+QJJ6vR+ULn5UX1jB1ZtbzRp7F/9GvL4ftlKY+q88+7lwRgpICh6R3MZkY6aagtavgSxxjLF5fIwmwc1udAY1+h02n3FyqYzOkeBSxLY9nBEQYTsd3TMRyeOLqFsdOydVlqXRYS80vCsoZuabz/cviAa3hVxtP3OCaPP8wo5bjn5Hp/y9a/KtdG86Gp63G/3OMAUYNUSZ2GLK82A9EJnkh4olP+N5+5BSQj65rxOHVrUQT+FFnsSXYBM5N2j8C1OSJOExcEVkRZMYdspYDmg406iN3K+9S8uDSVnpetPX+4ex/EhtIDV4CbXcv6ATC+Y8jGEYkTtUDjpqmnxsjK0inOWOg+xrmZHAUqoTdOcnXQX12WmHEL3usYRo8vfz3Qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(55016002)(9686003)(4326008)(52536014)(26005)(6506007)(83380400001)(66446008)(66946007)(8936002)(66556008)(53546011)(5660300002)(76116006)(66476007)(186003)(64756008)(7696005)(33656002)(8676002)(86362001)(110136005)(478600001)(71200400001)(316002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cM6dhvomUhmLlOiCeodtqFuUazmCqpalrfxXstkBaXuxVdQSrneXhpFoTArB?=
 =?us-ascii?Q?yydvHF5sPubUmkeSwdBHagDXlaaRmp++5TsT5xjjW6HCIntVpIIsyucqgQOp?=
 =?us-ascii?Q?ssgNCvS5LBx3a7MzpORAn9AtxpOB3mWYjHRoyYY7kEwkjgpyTq2tyWuT+/rc?=
 =?us-ascii?Q?WveT2kvroqGk+8a5oMZTE+k4V5cqfUhYMHYKtA9/olN2n2dS5M+am4vNkd7O?=
 =?us-ascii?Q?HcaQFwJJiNO+PZM2gam9XitdQpynO5SDuQWAJ2h/vkAnY/1C2de3B/vWg2ql?=
 =?us-ascii?Q?u/TIPxD+mFQlpstkQWgwb8QARtQzxp/O4EXgcCpcCwOogeHW/kj29Rqyv2W6?=
 =?us-ascii?Q?9pcvtyOYgsdq+by92yyYwCGVwwgCPcqMxntS/ig+Q+rWeexBU2tx0brkRhG4?=
 =?us-ascii?Q?ago445Upm6FJ2y6zTU8SN/PSYzT8gtne5lEcwD10+qtSNqOGH2W1PsNzQIL1?=
 =?us-ascii?Q?ny4MEHuw89DOT5Tcfi0lwh9UwmIyHLz337EaGRHQYkaoEZ1z8noy4H2HA6++?=
 =?us-ascii?Q?15qBcQYkay+dXwFSOdgz7kVFkLYeUH+suiM4ScPVCPWzZitaVkH+/mzfWiQ9?=
 =?us-ascii?Q?7jm7q1XUCkWcUF24TXgvJkXAOg6E1UTOGiVkKPYsyiMzZ/lozc4Wr8mPb9ab?=
 =?us-ascii?Q?6UCAarNcXwvOyaEKc/o4KeCuqP+ZXW87ksLmkJrGWe43eCeRypW8VAc9mSn3?=
 =?us-ascii?Q?olDB7WJW/qCheAIpa1pZG4aN+TtAxLc02Z86pvXUhvW2V+QxlgtEu0NShfMj?=
 =?us-ascii?Q?ELKjuiQUz15YSiSf7dTNhqAMNlXv9mOX9jUukaMyxCC8TBD9uJORv6qSqPUB?=
 =?us-ascii?Q?LjY6czquwAbp/As1iVQpgiTZP6nfiQV42skwWh910L2GZd2XFxpWj/tKwlQf?=
 =?us-ascii?Q?J/nN8G6yeYiatkOsMH9eMfkn884RtT0HRSjUgoI4D40+RF2w9iFZKCMn9Dwp?=
 =?us-ascii?Q?TUuIKUnOjRMt51K8FYqNJexlixs9hotf/gDfsqZU5AMhBoCXFQX+F7wdOC8O?=
 =?us-ascii?Q?o+jYhtsdolJAteSIMdWZq7NHFT7+9snugv12m4N+k0PFpk9L8TlqeNbEnmFx?=
 =?us-ascii?Q?EdYgPuIW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6882aa4-9d7c-41da-ce96-08d8c27a276e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:15:17.5277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWmqbBvLolyw5T7TzHk5ogHrQZfDRBfwBaLROsTVXL/6PCRJURqu9wguG52ZS1Ye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3145
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Wednesday, January 27, 2021 9:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: Enable gfx DCS feature
> 
> Background:
> Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
> When the current/power/temperature exceeds the limit with the heavy
> workload, the gfx core can be shut off and powered on back and forth.
> The ON time and OFF time is determined by the firmware according to the
> accumulated power credits.
> This feature is different from gfxoff.Gfxoff is applied in the idle case and DCS is
> applied in the case with heavey workload.There are two types of DCS:
> Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D fullscreen
> and VR workload.
> Since we only supports Async DCS now,disalbe DCS when the 3D fullscreen or
> the VR workload type is chosen.
> 
> Verification:
> The power is lowerer or the perf/watt is increased in the throttling case.
> To be simplified, the entry/exit counter can be observed from the firmware.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 24f3c96a5e5e..436d94cbb166 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct
> smu_context *smu,
>  		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
>  	}
> 
> +	if (adev->asic_type == CHIP_NAVY_FLOUNDER || adev->asic_type ==
> CHIP_DIMGREY_CAVEFISH)

[Tao]: So DCS is unsupported on SIENNA_CICHLID currently?

> +		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> +
>  	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
>  		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
>  					|
> FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> @@ -1437,6 +1440,15 @@ static int
> sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  	smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
>  				    1 << workload_type, NULL);
> 
> +	/* have to disable dcs if it's the 3D fullscreen or VR workload type */
> +	if (smu->adev->asic_type == CHIP_NAVY_FLOUNDER ||
> +		smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) {

[Tao]: Tab should be replaced with space here.

> +		ret = smu_cmn_feature_set_enabled(smu,
> SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
> +			WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT ||
> workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return ret;
>  }
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
