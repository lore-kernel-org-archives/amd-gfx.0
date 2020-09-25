Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A49C4346E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 03:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACFC20872
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 03:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ja0xsKD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACFC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570A36E090;
	Fri, 25 Sep 2020 03:38:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA1E6E090
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 03:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvdHXJMfviq11cnkPWKYZQFOybQQzP2nSH48fi7TDXfUENgayYao1SjWCc3rww15fYYQfrFkoE0j2UtSfBxxepjAeumoFIaPetNku6buNqy/Pv/AHKBYTcJRJ72JxyZUOhip7NwbVVs38AWFXpP7fcuzg1SkFRaIWd/8XLV6aGELMII78tDicQIq8NJKat/ACxUAmettadRrtqgFLyH86uxsPc0QxrhIPNbkQvkcZYJVk8J2wnym7IQ4lgA+u6vb4nRR/UTLC+kJ8WnSrhB5JX9Hkke3bZEyWV2sz8brAej/+2KDzIDhbmHJNPf076vcS4xWgjiu+OuldugdjeJVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL3JqoLzHpsBg8s5Q6mpiNzjhQO+vLJLcjl/smDvOwA=;
 b=FOY6rBwuvLalDvwRuPYXE41+DyEfYAZEWVmSS5CQC0ZfKAMnPiCm4Byp3naBM+dALdiyD2vxpwVx5utAQfIqJBV23gIE3EYw8/aHtwgfl2b60KUGAxPLoeccrrF6D4Re10Fqrt+AAbgVpgtR9MwYXUrhhr/ouJlKuuLfgWacE3Io+oVrUxp9vnK3EZTQbGJtvzD0oAZ/gr6UWz3RKAr3Ew70fcClLoJPdXONynvw3AiJnk8uKEpr01nPdbvmZsavI1rMkvYjJ7PhANTX9xDjuR2jp/ELjkzwUgwwOYftOzqBhOl2i5QalIE2Dl+pULTOqh2DYV/0M1SRw/8CaWv4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL3JqoLzHpsBg8s5Q6mpiNzjhQO+vLJLcjl/smDvOwA=;
 b=Ja0xsKD5AXhn1g/jN5zjctoyes7AL2TsmMoGgz3liqtpqJYo1ika6OrAamNwnX5pTiDQM7PSuO7G52Axs7GVxMOuF5qAqku314CFxd7ikF3jeKjNNKeXDfOpvt0Ckf6ZEBDV9yYI+84DXokR/YjNh1bB+vDWuoF3bS1ZaDDaP6Y=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Fri, 25 Sep 2020 03:38:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3391.027; Fri, 25 Sep 2020
 03:38:22 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
Thread-Topic: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
Thread-Index: AQHWklrv8ROzoDhJA0qX/XWVBuaBXal3wLQAgADzQ3A=
Date: Fri, 25 Sep 2020 03:38:22 +0000
Message-ID: <DM6PR12MB2619DA9B85A535D12D63E915E4360@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200924101012.22845-1-evan.quan@amd.com>
 <CADnq5_Nw6mdj38FVqg2Y67_eN04YSm1mSsS04RC09v7BHWNiWA@mail.gmail.com>
In-Reply-To: <CADnq5_Nw6mdj38FVqg2Y67_eN04YSm1mSsS04RC09v7BHWNiWA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5548a11b-1d2e-4e11-9c78-5bc36fd0c670;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-25T03:31:23Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a46af28c-a073-4d48-cefc-08d861047414
x-ms-traffictypediagnostic: DM5PR12MB1354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13543CC5470E6F572A3B9ACBE4360@DM5PR12MB1354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:529;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TryLzEDcfA7FTb2mpkSlNjgrkz1wiswLhxyyH6W3VulJaZc3D1yXb5li6HRUqwgrFcK4I8ZQH3HD3gvsmpRy+e41eq0YKCHuMLUmYLSy/mXJbwzypEL7bxq77VMxrOuw+WCrnp+iu7wcAqP9HvweKSIbs3EEP+pcAxjaHsQR/Vr5SYJGVjP5DAOM3EZhYn5Wgrr9t8klZtaamHa+ZCNt3RyQYODQj6SWGii2qmazQy6Y9sWsSx8A1uVkKiLTbsrxfCdSXzAy6/8yZB1aY+nI+We+6Lq611InhRMix6OjKiFDXs2XMeXiD7O0JsBgMd8LovqDHIib6KGphzQ4ln0le/3mgp+1ebUd7W+aOPffOeZi/foCNRsfTR4fuJs1M5rg5LS4yoz4BwCSRBadM0qzSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(9686003)(66446008)(64756008)(55016002)(966005)(5660300002)(66946007)(6916009)(52536014)(2906002)(478600001)(66476007)(33656002)(86362001)(53546011)(8936002)(6506007)(316002)(66556008)(76116006)(8676002)(54906003)(83080400001)(71200400001)(186003)(26005)(45080400002)(4326008)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ANY2Vahva9yRNxi1puXQbpPwHxYIS86NHlgBTv69rYAl3KPDnBXzZydOWUo42cvZMF3CJolinVTO4WbnmuHmXhJ4HyY/zP27QGS+7FEH1bnHvScAPp52YxCPI5YAdEGj0tRony+t4xbkwjPa6eK1f2s/lmOS2Gd8FOL7xWMD4THjsUR/lHnpUoEOsMdxLD3joDVlWoMVc6CB+ta3S/oJ59Xrs6YzOYbdDOCOJYhjw0fgRvS/Nk6jlzUuDdyWOkUhtx3Nrfv+ew2/WdkypjcSYi65WmU8Nyc2n/rXI2xAwfcQuF6tH/w1c8aVSFIpglyPzRPtoXzDA6sV9Noi1Yekd+ncs8jG5vONZZDv/fvcIExZSfVhcQiwZBuSEefDfcWgRlgeJgSgqgC6gki4+vrbdYlDU0HOm6wEsm+QThcn1lbcNPtnTGUqwYHY96ic9xwMiCAr4thVqVpOvwLfxzERtoRQdcGohToUGy2wa6yFRjmli5libpsn8YMQUA29Dqe3LnhbPaR4Z7x2uyS103qsgW4XL4Lrxn+teg2x+Wrc50HPzkea+dIm9FiQ908Vb9fUfNcGIpOutnhm1rO0Lhz+VMG/S90ThUXVmpBgPws10e3VPkW9WsgcE942lT8hrO3jvMsaNXXH+GD4N1/AGi+T+A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46af28c-a073-4d48-cefc-08d861047414
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 03:38:22.7000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2zfopxeNHDcIhQF5C5gZ/rv8GYVaUrypNviQ8CPo9bVeGa5Ze/usAgXqDoMbRV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

That(postpone SOCCLK/UCLK enablement) will be revised and added back after confirmed with DAL team.
For now, we just revert it to get around the screen flicker issue introduced.

BR
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, September 24, 2020 9:01 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K monitors

On Thu, Sep 24, 2020 at 6:10 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Revert the guilty change introduced by the commit below:
> drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL
> initialization(V2)
>
> Change-Id: I0cab619ffdf0f83b14ba5d2907e1b9c02a984e2f
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Won't this effectively disable the potential fix for multiple monitors at boot time?

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 ++++++-------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 1695b36dc23c..be44cb941e73 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -316,6 +316,18 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
>         if (smu->dc_controlled_by_gpio)
>                 *(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_ACDC_BIT);
>
> +       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> +               *(uint64_t *)feature_mask |=
> + FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> +
> +       /* DPM UCLK enablement should be skipped for navi10 A0 secure board */
> +       if (!(is_asic_secure(smu) &&
> +            (adev->asic_type == CHIP_NAVI10) &&
> +            (adev->rev_id == 0)) &&
> +           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> +                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> +                               |
> + FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
> +
>         /* DS SOCCLK enablement should be skipped for navi10 A0 secure board */
>         if (is_asic_secure(smu) &&
>             (adev->asic_type == CHIP_NAVI10) && @@ -2629,43 +2641,12
> @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
>
>  static int navi10_post_smu_init(struct smu_context *smu)  {
> -       struct smu_feature *feature = &smu->smu_feature;
>         struct amdgpu_device *adev = smu->adev;
> -       uint64_t feature_mask = 0;
>         int ret = 0;
>
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       /* For Naiv1x, enable these features only after DAL initialization */
> -       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> -               feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> -
> -       /* DPM UCLK enablement should be skipped for navi10 A0 secure board */
> -       if (!(is_asic_secure(smu) &&
> -            (adev->asic_type == CHIP_NAVI10) &&
> -            (adev->rev_id == 0)) &&
> -           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> -               feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> -                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> -                               | FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
> -
> -       if (!feature_mask)
> -               return 0;
> -
> -       bitmap_or(feature->allowed,
> -                 feature->allowed,
> -                 (unsigned long *)(&feature_mask),
> -                 SMU_FEATURE_MAX);
> -
> -       ret = smu_cmn_feature_update_enable_state(smu,
> -                                                 feature_mask,
> -                                                 true);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to post uclk/socclk dpm enablement!\n");
> -               return ret;
> -       }
> -
>         ret = navi10_run_umc_cdr_workaround(smu);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to apply umc cdr
> workaround!\n");
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7C3899143b7990458f882c08d86089df67%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637365492561293539&amp;sdata=J%2FM6YSLX6d%
> 2BMO%2B%2FWzdKAW7JlVZM%2FMFRDpTfi6UHkozk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
