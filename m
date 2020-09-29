Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7ABC2D0A8
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 02:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6435206CC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 02:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dpym3CEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6435206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720736E434;
	Tue, 29 Sep 2020 02:10:32 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750049.outbound.protection.outlook.com [40.107.75.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB046E434
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 02:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5kegpHqSTpRtpf/FjAERZLKDzRiN6gjS6MlL4RypogfC2Ra05ZRAucJkb/7ReRJNYN9zBRhig88kD6QfRvkS+DM38hSCos06ZhvimuVGK40wF+LKj/PsweILDlCpEw6ERaYa+YIIJxSa+OHZHk5MvcwaE+98FH/JvvWkWHdPRPTWzS6z+mmQ/t7Ise7qiqEJJT0fG4gNwSi/22XrKamlSe0UCgEZxtMc6mkEoFD4ISAxHZLeFYRdrjXPMnsA1qOGiX+dT7GwuV7JB/p9Lp0sHFNOTzXJQ932kiRuncASAUoTvPCptMNYKAuH8RWRj2XkjT2bys6iJvztTNgx/mgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzfuWOZTNQpDN2Yj1f8R5G+6pWU1L55pqtfjQbslGhQ=;
 b=NVrf+X5LWiDcibW41rjy+xVPC1L/mcF15KGMDkmXp8bCbe9x/dH2sEZSqY3DoctTRtMrei8lfASJUmzJMjiKKIngngq0ayDfOR4UVBYj3nXlhd/z+/qcVB/l9hXhjEqOqcvOKJH30o7HdqMdtiVaxLfNKX5ghRF5Av4hkhUJgSr26LaYVY+LzPgy8n4A/Oy0m4oPcsjaTIydzfQc2EP4Ks1RjSBR7H+FyphQBtw4cOdzIhFdOs0IDiDEMYtyV+IHjwECXb5zQCtUaoDic9/o/g/WwYSY7MPDv4hCdhHcbyeVT+fB46xTt4RCfaGViXNE93OTBFEihLfIeQtvl+8fWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzfuWOZTNQpDN2Yj1f8R5G+6pWU1L55pqtfjQbslGhQ=;
 b=dpym3CEy1h+lfFETa2mlyQvSXvIJnSFqgr8za6goU3/Sa8V8vo1HwNdAli+J1OtdOMENcQbGP8o2+erUs+vJZdFIP+XQv+cxh+bKoblKWqLW/dwwhgHkDdnxabvlN94q85m7koYZEom/Tkss9yGeV2ZB04Tg+7Cp9SLFammtc/A=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 02:10:27 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::b006:9951:b590:87d6]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::b006:9951:b590:87d6%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 02:10:27 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu/smu12: fix force clock handling for mclk
Thread-Topic: [PATCH] drm/amdgpu/swsmu/smu12: fix force clock handling for mclk
Thread-Index: AQHWlcPb5RyG8qMI6ECYWGJItGZP1Kl+357Q
Date: Tue, 29 Sep 2020 02:10:27 +0000
Message-ID: <BYAPR12MB3238FE0D0AF417D6B715A1AFFB320@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20200928181854.2053782-1-alexander.deucher@amd.com>
In-Reply-To: <20200928181854.2053782-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0f2f3851-39a3-481c-9297-cfddf8f690ba;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-29T02:09:34Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 966959a9-85ab-474a-9d3b-08d8641cd56f
x-ms-traffictypediagnostic: BY5PR12MB4276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB427692D27D84812CB972C495FB320@BY5PR12MB4276.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ztbR08Rx8HTLBPmgOOsRyKIgaol8r4I1UNPsYxzZq/Um19jtvSmjNfuu0dz5XYDJ4FMQlLsM7PDM/ANxYe1AnJ7q1U6rA6JjBy6XxSmHiX/lypebzX2jrpi7nJZKUpywk/Vw43W1tD1Sbta99asJQlsyddzY4W7NaavVxbDD/lg4gW9pL14NRxzXU2cVz0JMAYTGWFfU8/5nn1lTfdNTujTBKnccyroSY95m33qc9/ldow6feQU7fKs3C7l+livzMOInajdjPv77Zb1grTmQkRVhTY9wb1kW4d+sUb2NzCJFz5FC5nfQ6eY+ndBQq0RczNBukTqp/ko+qhGwSMvMh+GZd+e8prOyC/pUUiSlBmhlGpqy7Dnf8i8u3DJz7bVow1pIF0se0Tc6+JZ79gdlHZTdKg0DnoST+WfGo2BxhdRToEHfMY47TCnANnGCQ7w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(9686003)(83380400001)(6506007)(53546011)(186003)(2906002)(7696005)(4326008)(316002)(66476007)(64756008)(66556008)(966005)(45080400002)(86362001)(71200400001)(5660300002)(66446008)(478600001)(55016002)(52536014)(83080400001)(26005)(8936002)(76116006)(33656002)(110136005)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: q+BLYPl5XUcJQsp/Av6TSWvosnu+ofRTNBKR74qhd2niY7vDw0W11ORLxJ7gdozcTdMADQBF9njjEOi6/toBXV2iiJWB23/O83sBDuiaFbRqdq2UB8cqrMxVKQKIV7EY9699lReT8GAaV6kQ+fofM+kSgw9aeU0Xw+AR22hd4HhRQVhesol28jZp8FXnX3Q3g5oT1DbCYTlpk/Rz94+tOGxALHV6SEnSPBnl/PDH/ewyHg+atlrowIGslOwS3YDCFfz1AwWJqRWaSkFZGLMj07YJNMC1TLcHefG61RJorOv20ghYnclbxTCG2UGWNX17klPpPJRRfaLwIROOBoOTlUPvGihPi3y3B6P0H5wgKNPHDCFz/bsgL6fD5RF53coS1hKzrDDMfd+jkVEdtUK24+i8lRBKFrLPG2HGzXZlqNy5x2A28i1274J5Ofq94YmTLgvfyKF5ClEqNgfpC200dc8SHp5l4IQvoIVc5wNf4lYw4FQWVXXesFZVPfOoRtLWBiW+MHEJ5pA8b4O8epNXxqiJ9f9uAZBoCIVkWeJzhgbyBLrSKQPZ5S/D6ZNtHRUiKp4I81bVLn1XePGsCyEakqfTr3sqg4y6IMGyEOLHrhqPEtUWIj3W+xlyTEslE1guB1vR/6DMryAyyKhNHB6s2g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966959a9-85ab-474a-9d3b-08d8641cd56f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 02:10:27.4399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2oYeTt2elrNuq47t9IcSOajOcz1lDi84W1QT4OYTmoytomI3fzt7ZvxyEJqC4L7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Thanks,
Prike
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, September 29, 2020 2:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/swsmu/smu12: fix force clock handling for
> mclk
>
> The state array is in the reverse order compared to other asics (high to low
> rather than low to high).
>
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1313&amp;data=02%7C01%7CPrike.Liang%40amd.com%7C15f
> 59da6951546dbea4808d863dafba6%7C3dd8961fe4884e608e11a82d994e183
> d%7C0%7C0%7C637369139485609967&amp;sdata=8QG%2FcFh8K3t7BT%2Ft
> cZJt6KqYOYxQVX9dblyzebY4rFc%3D&amp;reserved=0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 55a254be5ac2..66c1026489be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -222,14 +222,16 @@ static int renoir_get_profiling_clk_mask(struct
> smu_context *smu,
>  *sclk_mask = 0;
>  } else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
>  if (mclk_mask)
> -*mclk_mask = 0;
> +/* mclk levels are in reverse order */
> +*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
>  } else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
>  if(sclk_mask)
>  /* The sclk as gfxclk and has three level about
> max/min/current */
>  *sclk_mask = 3 - 1;
>
>  if(mclk_mask)
> -*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
> +/* mclk levels are in reverse order */
> +*mclk_mask = 0;
>
>  if(soc_mask)
>  *soc_mask = NUM_SOCCLK_DPM_LEVELS - 1; @@ -
> 323,7 +325,7 @@ static int renoir_get_dpm_ultimate_freq(struct
> smu_context *smu,
>  case SMU_UCLK:
>  case SMU_FCLK:
>  case SMU_MCLK:
> -ret = renoir_get_dpm_clk_limited(smu, clk_type, 0,
> min);
> +ret = renoir_get_dpm_clk_limited(smu, clk_type,
> +NUM_MEMCLK_DPM_LEVELS - 1, min);
>  if (ret)
>  goto failed;
>  break;
> --
> 2.25.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7CPrike.Liang%40amd.com%7C15f59da6951546db
> ea4808d863dafba6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637369139485609967&amp;sdata=kH8rL1yy2JAGfJcsVdKfIP5wVjWMW%2Bp
> NLOLSuZssGh0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
