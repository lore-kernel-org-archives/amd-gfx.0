Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EE0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 02:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0A610E796;
	Thu, 27 Jan 2022 02:22:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071F010E796
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 02:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whyq/L53OeT/9DJPcZ+0sjQqLY21j52+YBX4wwSwq1xezI0MRvetGK7z6MGmBxJgpM+a9PKBk+oN/ja+p7on7s9hYPRFqtIFvBEW0OG+/OsKbg2MVr6UIwVNv6KybwZaGEkydPjUPW+p0cuV0GH+rPg29nl+/dly0NLTeniN6dvyOnnogy1AQuV1ah8XF600fibRdjaFXwIBtOpgH5N5lP+u6Kc/mjzWs7z2T0t9GAz69Ab7DJG0m5NVtOVymc8RIpUgrnhRN72AFTk//qA+I700na1QfhzG8g5biDU1Mn5Ab2u1MuMYhBEhQg5k6g0cVdArQXOR6l3AKf9XW+k6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePK1ngtFan8eyIq4ZqSl2+yGS77Pk/GakBIKS0I/U1Y=;
 b=fU0rkPsfEInu7MOHDL5cLRLHT3ccXDvDxHJsTVETBWPEvJUzzclBVm0+neQGCDhZQe41ZJ8O6SicN/RviBFSs6sgaKHsC/HA+kSOyGvSazJW5rzbaMT/JH5QviSHt516lute951xK4ZwE8ou/+kBZeuru/KuuTX4hm1o+fLKHQB9T1TeALiXfE580lMxXz23ms+vqEeIwafik1imKSNxVIpFglM5NLy9+uRfcuQ5ehTjfOjnKAXoZU+OtWb7dQnq/ZmBbV2Lg1FCEFiYL/agMftzgz3ND3YbNihKdU/a0gMwPTc7HMAXdwQFW8xI0mfTDAETYbuEVRt81fFw5eVRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePK1ngtFan8eyIq4ZqSl2+yGS77Pk/GakBIKS0I/U1Y=;
 b=zlrazeY33oEu1yxGrKFyFzEhNIxQhiWEH43DqUw1T2l+qslgJZt+coNciMeWvGEK7RAe+Ll+kNXs+UoyMZnVVkbcsTfN7je4/+xaoVZgyFvz/JBVYFQlpHq/pLhGJCmUeBRxy3WpzT4n3VyVakWoX5ELumDpqFG/nlz2ZGuPJeU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3195.namprd12.prod.outlook.com (2603:10b6:5:183::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Thu, 27 Jan 2022 02:22:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.017; Thu, 27 Jan 2022
 02:22:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 3/3] amdgpu/pm: Linked emit_clock_levels to use cases
 amdgpu_get_pp_{dpm_clock,od_clk_voltage}
Thread-Topic: [PATCH v3 3/3] amdgpu/pm: Linked emit_clock_levels to use cases
 amdgpu_get_pp_{dpm_clock,od_clk_voltage}
Thread-Index: AQHYEnDlFBY6lCInEUSm9hqssMHcRqx2JDzQ
Date: Thu, 27 Jan 2022 02:22:10 +0000
Message-ID: <DM6PR12MB26193AB3A2B25F91B7208587E4219@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220126045441.3891-1-darren.powell@amd.com>
 <20220126045441.3891-4-darren.powell@amd.com>
In-Reply-To: <20220126045441.3891-4-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-27T02:22:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1f9d8276-2452-4a56-a9e3-26702b576dfe;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97d30b60-ed0e-4062-4275-08d9e13bd310
x-ms-traffictypediagnostic: DM6PR12MB3195:EE_
x-microsoft-antispam-prvs: <DM6PR12MB31952201192A2F70AB023E2AE4219@DM6PR12MB3195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LgQ0cbOLPQ23K07ZOJ1/xPHMBUjyWCKyNnRi+8dSFDR8TQuda3JJNKmTWplOGIU1or9TVkBCLUHV0PtqCKhIUnd9SBvJxbr9cOfl36ScjxJOOcX/+mQnMZP+LIrfwAcz3aAELs/+Y0HatmMEVSHjwHm7zpvBGVZ2pvskAyoT8eWx+c0jc5m+Zsn1Z3kk5t5ICQOAmLW7oZGciluPONJxaIT3S+UilUfFnKV1wYV+LXOdMJzNHTP2HS5Tl1llp8QC20OByZBKT9hBLrfu5EB6TANzKlSU3ogjFnZzC+Z4xo+if/50/7hbfAthktmXNQt7sn1ikSxz0FHKDkkzpuHSRt0+WBal6bD1/ukUI8vNrq/TyTtoWBRghh2gCVkextNslrD2aBDRaNJLskM5A9AZTTnGT7u0rPp8kpOzZisfoXnugSqOVIlfAPIPMpoaaL9h/CnaKYfVlDhUdz1hyARI85bXXpn2LejtVz8mojIwLNa36418ddkHsq8U+erNWIqg8vx351brT9OvPsMVL6neyJuscdV941Scwuf+xF07MisEcy+mEK7vPWZU8sax3gvl97BJ2O6Fkpfw9bciL5qksa/J9KFsZqheitSiMHstr4tMhaFNkfayKqOzeZwINlQEa3fC2zh9huEsZEOqS2n5q63KuKhm2Wd7kmg23zzLjxMPYmiD2akB7Cb7mYjK29RPE9QyfgewKZ+f8uEGfc+A/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(53546011)(38070700005)(66946007)(316002)(110136005)(86362001)(26005)(52536014)(5660300002)(6506007)(122000001)(8676002)(83380400001)(76116006)(8936002)(64756008)(7696005)(33656002)(186003)(66476007)(55016003)(66556008)(66446008)(38100700002)(9686003)(2906002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rW2K+MD3ubjKMqMx+LlOtCUx1OBMvuCBRNX+i3pIR9J2mnD2zGHpB6bGcXfq?=
 =?us-ascii?Q?mQXya05BeW4UqNupvXALD3UtCdPCb+TQQ7nfqkhgKAfR6nNcMiZ5zqBqxEPY?=
 =?us-ascii?Q?RnSrV+NcfirlBq30inwv7+dcXgHhtfXT6izBEYWNjxJzKtEt6XEmQyTpvNkr?=
 =?us-ascii?Q?OKYPNkc5AOUuANv6zPDa+DuRDLzc62/kY83+EdyA5XB+0wJ2rfhw6XGsy/pD?=
 =?us-ascii?Q?CqLSTxlcmj2tWauDs2p+igKkcsRZDqe/zj3YWBra1bM+GnUJcM9IrSnnTWFh?=
 =?us-ascii?Q?GKdnhTEfeJiKO+CuOddlG6oxEQasdINQin7HeWXgdDx5T6yYH9jmcUaawGyx?=
 =?us-ascii?Q?hGOsK5eKMPCZTDsY8rXWjH/6KfNvCwMPvbUkWeVowCM1/jOcdBUPrCnhEwLK?=
 =?us-ascii?Q?qOG058YC49tRs2caeFcJ70geZCHBBLMysB48/Zltl+WLXAgNZOOw4ymKBbvh?=
 =?us-ascii?Q?F67JFOS+8bnSXvHrfbzV9E7ltOzCNkqxkcofRe0bu4jY/uYqBazky1vkk8Wz?=
 =?us-ascii?Q?zVpir/qb67kGuHrGcOpU1M6BC1z3zbeIsiBnep657dRV6xkDn/ZnB2mVHG5X?=
 =?us-ascii?Q?4YyqjUFV6aHfNDXzC9IEaeW/HERoS5aQu/qdnEsJxYAp+YCECjhuBbLd3QYM?=
 =?us-ascii?Q?2QQqsVhwsDTm+JzjfG3nmOfdMNSHuzeUZ4CCiIGLDfGgjMIHhRrskR3kZnpT?=
 =?us-ascii?Q?FzxhxGIBpZ4i16KiWzINGNR1ssXjy8aAYJJS7MOtJQTY3Fqo7koLFpEeQSdA?=
 =?us-ascii?Q?ouJROtbPr7gxOZHAYBnRPG8QTHITufO6N3c4QqQNUm+3DT9i3JYU0KnH1wT5?=
 =?us-ascii?Q?AWyvGYzVsO3PNGigonuTr7E0iXZVAlZSZmWseqHvhE2+AZFoqmdB37dTwzxp?=
 =?us-ascii?Q?8dE4aMrhNSGaR8/pO7hGCOENGjvYyBxflzUw+8c2NW1ZQRMOfXSNw9+8e+wm?=
 =?us-ascii?Q?eKiZeD++OSe8Kqu+f9VNCLpBfMnodUzucOQsmCISe6VDfeslkQcYWNKImCLA?=
 =?us-ascii?Q?WBGUG9yeyVxQa1+OiRT6+/y6cSnT8VFBQVePUrQ0Kn3yAA/eFl7dBRJkBt6I?=
 =?us-ascii?Q?ECdRqhxPLXngF8CEqexV2IjP2EUA7XkA+ZmdgpPat5haHEZS+ksHDroxiWEy?=
 =?us-ascii?Q?3ZU4dr/ILch2v4o1u5PLDLD+a2JG3FPjx2VlHeT0Qz8IkICePaOykWO2OSbT?=
 =?us-ascii?Q?zWsl1qimcYTHDfHeSMdazyfsXdQ38DBdXwRwSaiPDyVaAWq21kCYgvXhYkiR?=
 =?us-ascii?Q?rUp1udJjSgMXt1zgj6Slmo5qfJ+kJ4XOdNV+RvN18DCp13dz8zi5WAdFucep?=
 =?us-ascii?Q?yswiveoDdN2i/D5cRFtjabot6P4zzXWFh+owLyiADNJ1Agtxz+tGkATP4JZE?=
 =?us-ascii?Q?JrCBwQuyR94Nm1UGi5+H3S6015VzsheqmQOK2lZht5NnY2HfWX8rSWf+CB8R?=
 =?us-ascii?Q?D5GgThUKp4WaRhmX29RpbOtX3g+MYwKV/c/pY/0c6UuPfY/eSyL84ojwFees?=
 =?us-ascii?Q?y6Z1mcEbdIqFn9CKXK+lW01wN9Nm0Hy/QKxqwnJfT2RVK1VusGuZZtWnRB9h?=
 =?us-ascii?Q?yNYlNrbWhgtH0cVEF0U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d30b60-ed0e-4062-4275-08d9e13bd310
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 02:22:10.9076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PtQ++Yqo/JkO+rsW3rsdPV+gTs2i0uZymZE1qrEGhPz/u804vcymwxKKIM73Xaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3195
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Powell, Darren <Darren.Powell@amd.com>
> Sent: Wednesday, January 26, 2022 12:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Powell, Darren <Darren.Powell@amd.com>
> Subject: [PATCH v3 3/3] amdgpu/pm: Linked emit_clock_levels to use cases
> amdgpu_get_pp_{dpm_clock,od_clk_voltage}
>=20
>    (v3)
>      Rewrote patchset to order patches as (API, hw impl, usecase)
>=20
>      - modified amdgpu_get_pp_od_clk_voltage to try
> amdgpu_dpm_emit_clock_levels and
>        fallback to amdgpu_dpm_print_clock_levels if emit is not implement=
ed.
>      - modified amdgpu_get_pp_dpm_clock to try
> amdgpu_dpm_emit_clock_levels and
>        fallback to amdgpu_dpm_print_clock_levels if emit is not implement=
ed.
>      - Newline is printed to buf if no output produced
>=20
>  =3D=3D Test =3D=3D
>  LOGFILE=3Dpp_clk.test.log
>  AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
>  AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR |
> awk '{print $9}'`
>  HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}
>=20
>  lspci -nn | grep "VGA\|Display"  > $LOGFILE
>  FILES=3D"pp_od_clk_voltage
>  pp_dpm_sclk
>  pp_dpm_mclk
>  pp_dpm_pcie
>  pp_dpm_socclk
>  pp_dpm_fclk
>  pp_dpm_dcefclk
>  pp_dpm_vclk
>  pp_dpm_dclk "
>=20
>  for f in $FILES
>  do
>    echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
>    cat $HWMON_DIR/device/$f >> $LOGFILE
>  done
>  cat $LOGFILE
>=20
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 49 +++++++++++++++++++++--
> -------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d2823aaeca09..a11def0ee761 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -832,8 +832,17 @@ static ssize_t
> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  {
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -	ssize_t size;
> +	int size =3D 0;
>  	int ret;
> +	enum pp_clock_type od_clocks[6] =3D {
> +		OD_SCLK,
> +		OD_MCLK,
> +		OD_VDDC_CURVE,
> +		OD_RANGE,
> +		OD_VDDGFX_OFFSET,
> +		OD_CCLK,
> +	};
> +	uint clk_index;
>=20
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> @@ -846,16 +855,25 @@ static ssize_t
> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  		return ret;
>  	}
>=20
> -	size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
> -	if (size > 0) {
> -		size +=3D amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
> buf+size);
> -		size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDC_CURVE, buf+size);
> -		size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDGFX_OFFSET, buf+size);
> -		size +=3D amdgpu_dpm_print_clock_levels(adev, OD_RANGE,
> buf+size);
> -		size +=3D amdgpu_dpm_print_clock_levels(adev, OD_CCLK,
> buf+size);
> -	} else {
> -		size =3D sysfs_emit(buf, "\n");
> +	for(clk_index =3D 0 ; clk_index < 6 ; clk_index++) {
> +		ret =3D amdgpu_dpm_emit_clock_levels(adev,
> od_clocks[clk_index], buf, &size);
> +		if (ret)
> +			break;
> +	}
> +	if (ret =3D=3D -ENOENT) {
> +		size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
> +		if (size > 0) {
> +			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_MCLK, buf+size);
> +			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDC_CURVE, buf+size);
> +			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDGFX_OFFSET, buf+size);
> +			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_RANGE, buf+size);
> +			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_CCLK, buf+size);
> +		}
>  	}
> +
> +	if (size =3D=3D 0)
> +		size =3D sysfs_emit(buf, "\n");
> +
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>=20
> @@ -980,8 +998,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>  {
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -	ssize_t size;
> -	int ret;
> +	int size =3D 0;
> +	int ret =3D 0;
>=20
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> @@ -994,8 +1012,11 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
> -	if (size <=3D 0)
> +	ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
> +	if (ret =3D=3D -ENOENT)
> +		size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
> +
> +	if (size =3D=3D 0)
>  		size =3D sysfs_emit(buf, "\n");
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
> --
> 2.34.1
