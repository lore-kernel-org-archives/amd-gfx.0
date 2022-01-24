Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1107BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 02:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6514410E32D;
	Mon, 24 Jan 2022 02:59:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C704710E32D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 02:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL7uENRNr0zP2wQlwKRtRHZJFCKec0QcZ02bVsIZr3Ln7e0DCUjnmgZL6aw9W+xL1Gsaaj6655z0xm8EZzJrWMOz3FkHCR8/Ky/Lk60lKTYkDR+xnyjzMuklukex0r0KtgZW8LcDY344eBsev9r5cvBukgtKKXF8VloRg06WTWeoytza2vvskgZcX4ahG/S58VYuEqS3thl1aiYoCqY1Xg+MKVA6WGqZCYF7eIg1tkjmnwvCaqHChZW152YcaMvCMf/YVFYgfnXoTVT/6OhomzzSmOoej6daTRWLkGtdFs+4FKT9UOhxnY41I2ay4C13JUu0QMyLHcKBybgSOSPEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrmJnIhTiqgJOhq6PQWYwE3KxPB94DC07v1Z6DKGhiY=;
 b=lQiJMVE4cpwDNnp35HWt5ci6uewjYnMw1JK4E+X3y8uefGU8QU9PjD2NdNtFg1QuwKeAfGj+Y58wAwUbfoj8SmHWjHjxXyYdn3HaazaeEFetQh5mJauOhf6QjBzO5Yw7PbME4tzVCo/vwUjTFcxl2GeoDxJeUTQ1w8BZlkTO2uiPXkTXwnOoxJwDG13hQHlFoVyzUPuhjMNxNuLGPoDMbprM8/lWBM8yIhFgpve/ctKag3X+fpacIYvLWAm9z72YaAJnfHPaOXHNGxm55otqw8RalRXA393c/CSLmcN9OuO93kB7OCCnaxqcckxd6fx3dAS9zMR1q29SIO4HyswFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrmJnIhTiqgJOhq6PQWYwE3KxPB94DC07v1Z6DKGhiY=;
 b=X2YoXnrrGgTikX2a2nhWFmA+nEs//KinqKxL70xY9eo6poPBJUkBYgv2Nm3ucjZ9SAxNc/Jfs5SCD7vMeIp/kShKNv3YF5b92tTLuM5V9eUZspd3wNH7dkL4MAkHt+IsbCcy7hICLbyM6KaJqKnR92fWprvZxiRnGTxiwYFduZ4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Mon, 24 Jan 2022 02:59:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 02:59:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
 accepts buffer base and write offset
Thread-Topic: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
 accepts buffer base and write offset
Thread-Index: AQHYD0LAd3fOi5RMz0ONR02M+ay+pKxxfJwA
Date: Mon, 24 Jan 2022 02:59:03 +0000
Message-ID: <DM6PR12MB2619BD5A284260906AFEDDEFE45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220122034647.67925-1-darren.powell@amd.com>
 <20220122034647.67925-2-darren.powell@amd.com>
In-Reply-To: <20220122034647.67925-2-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-24T02:58:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5dfc0d17-bab1-4ca5-83bf-f160bfccc20f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 836d0ecb-5b56-4fa0-0d12-08d9dee57a91
x-ms-traffictypediagnostic: DM6PR12MB3914:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3914B50A452033431FACD55FE45E9@DM6PR12MB3914.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:132;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/Uea3dsHNXiPJeU5DktgNHWL+Ho2CiLIlXGu76IVXyNttE9Ap6fXqJylZLS4mwTzAvv5J1YgzRf7/mDuYk8fbZnnmaJu1viVAenIMIEpVLkG3sGgKOPLa/PJ3+HVkY1noQj3LzRzXj996JSRt76IIX4D3nKrEQRS+uoSAnwmnlwo8KzYUyiV49303iN0rc/3BlKnZd3EmSJCag1kwejkZfPxjiG9OiRUkIuXF2BOHtbfDk3pOZoCRipf5AEBbpczppjj1q4NVjLyD8Ci67A8OppRQtflpc2ye8QxfmOALaMpOYR93odfZbsSXNTSqgz7ETEXDDkY1sajcQu0sLdrzETAossw6yQVHBBoSLuC2Yp41GaNRfSg1fYvdnh4WG3pplyvBf7Pe2PY+mOS4UDu9dTrdEXRebxG2uNB/Rvm71sjqZONCWSXK9arktbRUt5jgYmxdcdmifM0wSyaU/JHiz7PUxg61boPxfvq9UZQ4dk72q2fYl7PucYst3RgMXOc5aIyIvyLC+qrLDLxMqlxNPVlEE7DeRcgqXNcZoFltlpqKpYdeEv3++zim6gzbp0HcE7YM45bBA0rRwcaul2HEy/s8TqVcW/hWDK+o3tVYrf2uZOZiW0CSoqW9uCy+pkYdqWV1IaKmVl+/iTB8q0Kd8TPbD6SnMyt4bXW1I8m9jZE6CH+r4JcxtI/6ceL68ObXB2I88e2YKf1NXB2tR4rQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(83380400001)(8676002)(6506007)(8936002)(122000001)(508600001)(52536014)(26005)(71200400001)(30864003)(316002)(66946007)(53546011)(33656002)(7696005)(76116006)(38070700005)(86362001)(9686003)(110136005)(55016003)(64756008)(66446008)(66556008)(186003)(38100700002)(5660300002)(66476007)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YNLDbtpcsyVEK/ZWBPQmjlw/o4tDU98U9gM2dNmT00GBEaAlpMHm3w4FXzsZ?=
 =?us-ascii?Q?imKdtZSkN9LhpacChtUYE0J7mhU4rEWX7wy2enhyQgQKxwlai70sSSDLxR9q?=
 =?us-ascii?Q?FoxqPnltK5VqEIiDTCKVnhVC7p24LT1nG6Xl15cMSX+Q5L6rx+q34vubN1si?=
 =?us-ascii?Q?DKrLhLcdM/Qa/TiO/2cvPlV+9skYELvrL2/wrLacn8EKqFN7J7WGihhGijo4?=
 =?us-ascii?Q?xUgh5tMY2bcT/Lc1cut3Mlx6mJo8oHzIcw1lGVO4Bs/wkxa5Fz1rTQqjWCY7?=
 =?us-ascii?Q?BCPqo2UTDZwo43WA3iWmzp5ruhArJGmta+yuGTC7hCBiz1IuWO5dDpP9mio/?=
 =?us-ascii?Q?dYSqPkSBecoKA/F7yzozhFcx6iv0LTBggzvriLlUHD+JlyTzZCVqlmZGspIH?=
 =?us-ascii?Q?pvzeqZdKHEaC7Nc+sMgYcUySXQpDlyXh1tFjKlZXTnWq+dv8uW4bI+5Hn3FN?=
 =?us-ascii?Q?2G7bEmLmSC19mZ0NiI096lnO4f/KTLq5Cf/L58GBdkQQpGsPmA9SxZh1ZARk?=
 =?us-ascii?Q?xXuWZwzFhYtQyW3RwdySVksKCIwRmDRvDnEZ6Vht8wqE7UdEEN1F7d9VrWLA?=
 =?us-ascii?Q?/awFB/vrw6r0skIdnseNoh+JqF03/jPrSsVk4VO2b3zOUSws09mligvp2AT/?=
 =?us-ascii?Q?rpMIBhe3KEWL/PcsASO5M4IuGd37u9gH6ENO2Be52rdHutVYLeSL1Emu8JIc?=
 =?us-ascii?Q?l99VOyoYEsoKHwf4Qt7+csy64MZHiE8vpv3CNYyCLEe/1r45RYVjWUlj3C2p?=
 =?us-ascii?Q?aihLCC9nmO+9SZlbrufknPLdy0pqcrM6AseVs2TXAaKUxne7MNwzycImSoIo?=
 =?us-ascii?Q?q+ArgrgBfq4XKmkmzuGUJrGfz53XYfgkdFzvBcvIvHxC1JTDAn2EZOQbe5Br?=
 =?us-ascii?Q?5n/TmR8horHlvPx9JkJ3ZA6hc47G2SfZizfywWCSTV8tm7PLFR3Iwy++aKGf?=
 =?us-ascii?Q?tcW5TioAr7UcS0oxV3Wbra5IJFtd0EaJH3QxQezEdaO5FCS8dn+66MM6KRwB?=
 =?us-ascii?Q?vtIRzp9up6wFI6IiBbBOeSuBJQZzcyGgcD3xNiCVzdYTtYfCCCfZ4h4iks32?=
 =?us-ascii?Q?Ixs5mA6LKcMecuYPfXgSlXLbPEfV085/eGnhVQXD9KSMyF0qRCJj76rt0EbL?=
 =?us-ascii?Q?rdQqq9i1YXRxXmQzZWFZFCHy7KAd3YUbEoNrwXyEQh1VPocoeDArDfn731oV?=
 =?us-ascii?Q?SGPl+5za1v4euz0IXuhWok7oSYpzP80MbXPYWGLi0wQqownXW2ez/leOXdvf?=
 =?us-ascii?Q?oMeNlfUYAA01S0hT1V1Crzf4BgCIQoCUS/b7HPcKQhJY4Qg5i+dCvKxCckwc?=
 =?us-ascii?Q?1JaOdwApxOAJtmVKIJ8TlSLERZEQC3jGi9im3FNKNEiCKPfqEvECdKb4kZjH?=
 =?us-ascii?Q?aYNKYBWusFErpSGLLuPFbBiN2ADhZuHLi4tZvOWztLIJfez2+7dO4ZlDrIuS?=
 =?us-ascii?Q?rrMAKYl11jxXzfU/k37qkS9CGGeiDv3cNH7kt7NqPp8Jf0lyT9YQczq9lF00?=
 =?us-ascii?Q?yAYE45vwKpOkbDNSC/THA8aMYczEnDmFyFkVnz1ZsDT9RS7BQ7b2Pcfi8rfR?=
 =?us-ascii?Q?WUbzgGhPjze3EKkJrG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836d0ecb-5b56-4fa0-0d12-08d9dee57a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 02:59:03.4370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gdk6BrdrmQjGPM4jKm0778glMQfqwEHy5i6CnE/DyCUtuZHIGyGLSVDLvtV4wbvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3914
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



> -----Original Message-----
> From: Powell, Darren <Darren.Powell@amd.com>
> Sent: Saturday, January 22, 2022 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Powell, Darren <Darren.Powell@amd.com>
> Subject: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
> accepts buffer base and write offset
>=20
>    (v1)
>  - new power management function emit_clk_levels implemented by
> navi10_emit_clk_levels()
>        This function currently duplicates the functionality of
> navi10_print_clk_levels, where
>        snprintf is used write to the sysfs buffer. The first implementati=
on to use
> sysfs_emit
>        was unsuccessful due to requirement that buf must be aligned to a
> specific memory
>        boundary. This solution passes the buffer base and write offset do=
wn the
> stack.
>  - new power management function emit_clock_levels implemented by
> smu_emit_ppclk_levels()
>        This function combines implementation of smu_print_ppclk_levels an=
d
>        smu_print_smuclk_levels and calls emit_clk_levels
>  - new helper function smu_convert_to_smuclk called by
> smu_print_ppclk_levels and
>        smu_emit_ppclk_levels
>  - emit_clock_levels currently returns the length of the string written t=
o the
> buffer,
>        maintaining the behaviour of print_clock_levels, but will be upgra=
ded to
> return
>        error values in a subsequent patch
>  - failure of the emit_clock_levels at the top level
> (amdgpu_get_pp_dpm_clock) triggers a
>        fallback to the print_clock_levels, which can be removed after
> emit_clock_levels is
>        implemented across all platforms.
>=20
>    (v2)
>       Update to apply on commit 801771de03
>       adjust printing of empty carriage return only if size =3D=3D 0
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
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  11 +-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  46 ++++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  10 +
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 189
> ++++++++++++++++++
>  7 files changed, 273 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index a8eec91c0995..8a8eb9411cdf 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -321,6 +321,7 @@ struct amd_pm_funcs {
>  	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
>  	int (*force_clock_level)(void *handle, enum pp_clock_type type,
> uint32_t mask);
>  	int (*print_clock_levels)(void *handle, enum pp_clock_type type,
> char *buf);
> +	int (*emit_clock_levels)(void *handle, enum pp_clock_type type,
> char *buf, int *offset);
>  	int (*force_performance_level)(void *handle, enum
> amd_dpm_forced_level level);
>  	int (*get_sclk_od)(void *handle);
>  	int (*set_sclk_od)(void *handle, uint32_t value);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 728b6e10f302..e45578124928 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -906,6 +906,27 @@ int amdgpu_dpm_print_clock_levels(struct
> amdgpu_device *adev,
>  	return ret;
>  }
>=20
> +int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
> +				  enum pp_clock_type type,
> +				  char *buf,
> +				  int *offset)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +	int ret =3D 0;
> +
> +	if (!pp_funcs->emit_clock_levels)
> +		return 0;
> +
> +	mutex_lock(&adev->pm.mutex);
> +	ret =3D pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
> +					   type,
> +					   buf,
> +					   offset);
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret;
> +}
> +
>  int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
>  				    uint64_t ppfeature_masks)
>  {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d2823aaeca09..ec2729b3930e 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -980,8 +980,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
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
> @@ -994,8 +994,11 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
> -	if (size <=3D 0)
> +	ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
> +	if (ret < 0)
> +		size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
> +
> +	if (size =3D=3D 0)
>  		size =3D sysfs_emit(buf, "\n");
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index ba857ca75392..a33dd7069258 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -428,6 +428,10 @@ int amdgpu_dpm_odn_edit_dpm_table(struct
> amdgpu_device *adev,
>  int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
>  				  enum pp_clock_type type,
>  				  char *buf);
> +int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
> +				  enum pp_clock_type type,
> +				  char *buf,
> +				  int *offset);
>  int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
>  				    uint64_t ppfeature_masks);
>  int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char
> *buf);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c374c3067496..d82ea7ee223f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2387,11 +2387,8 @@ static int smu_print_smuclk_levels(struct
> smu_context *smu, enum smu_clk_type cl
>  	return ret;
>  }
>=20
> -static int smu_print_ppclk_levels(void *handle,
> -				  enum pp_clock_type type,
> -				  char *buf)
> +static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type
> type)
>  {
> -	struct smu_context *smu =3D handle;
>  	enum smu_clk_type clk_type;
>=20
>  	switch (type) {
> @@ -2424,12 +2421,50 @@ static int smu_print_ppclk_levels(void *handle,
>  	case OD_CCLK:
>  		clk_type =3D SMU_OD_CCLK; break;
>  	default:
> -		return -EINVAL;
> +		clk_type =3D SMU_CLK_COUNT; break;
>  	}
>=20
> +	return clk_type;
> +}
> +
> +static int smu_print_ppclk_levels(void *handle,
> +				  enum pp_clock_type type,
> +				  char *buf)
> +{
> +	struct smu_context *smu =3D handle;
> +	enum smu_clk_type clk_type;
> +
> +	clk_type =3D smu_convert_to_smuclk(type);
> +	if (clk_type =3D=3D SMU_CLK_COUNT)
> +		return -EINVAL;
> +
>  	return smu_print_smuclk_levels(smu, clk_type, buf);
>  }
>=20
> +static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type,
> char *buf, int *offset)
> +{
> +	struct smu_context *smu =3D handle;
> +	enum smu_clk_type clk_type;
> +	int ret =3D 0;
> +
> +	clk_type =3D smu_convert_to_smuclk(type);
> +	if (clk_type =3D=3D SMU_CLK_COUNT)
> +		return -EINVAL;
> +
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +		return -EOPNOTSUPP;
> +
> +	if (smu->ppt_funcs->emit_clk_levels) {
> +		ret =3D smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf,
> offset);
> +	}
> +	else {
> +		ret =3D -EOPNOTSUPP;
> +	}=20
[Quan, Evan] The code will be more readable if the aboves can be updated as=
:
If (!smu->ppt_funcs->emit_clk_levels)
	return -EOPNOTSUPP;

return smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
> +
> +	return ret;
> +
> +}
> +
>  static int smu_od_edit_dpm_table(void *handle,
>  				 enum PP_OD_DPM_TABLE_COMMAND
> type,
>  				 long *input, uint32_t size)
> @@ -3107,6 +3142,7 @@ static const struct amd_pm_funcs
> swsmu_pm_funcs =3D {
>  	.get_fan_speed_pwm   =3D smu_get_fan_speed_pwm,
>  	.force_clock_level       =3D smu_force_ppclk_levels,
>  	.print_clock_levels      =3D smu_print_ppclk_levels,
> +	.emit_clock_levels       =3D smu_emit_ppclk_levels,
>  	.force_performance_level =3D smu_force_performance_level,
>  	.read_sensor             =3D smu_read_sensor,
>  	.get_performance_level   =3D smu_get_performance_level,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3fdab6a44901..224b869eda70 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -615,6 +615,16 @@ struct pptable_funcs {
>  	 */
>  	int (*print_clk_levels)(struct smu_context *smu, enum
> smu_clk_type clk_type, char *buf);
>=20
> +	/**
> +	 * @emit_clk_levels: Print DPM clock levels for a clock domain
> +	 *                    to buffer using sysfs_emit_at. Star current level=
.
> +	 *
> +	 * Used for sysfs interfaces.
> +	 * &buf: sysfs buffer
> +	 * &offset: offset within buffer to start printing
> +	 */
> +	int (*emit_clk_levels)(struct smu_context *smu, enum
> smu_clk_type clk_type, char *buf, int *offset);
> +
>  	/**
>  	 * @force_clk_levels: Set a range of allowed DPM levels for a clock
>  	 *                    domain.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 37e11716e919..50022de5337f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1261,6 +1261,194 @@ static void navi10_od_setting_get_range(struct
> smu_11_0_overdrive_table *od_tabl
>  		*max =3D od_table->max[setting];
>  }
>=20
> +static int navi10_emit_clk_levels(struct smu_context *smu,
> +			enum smu_clk_type clk_type, char *buf, int *offset)
> +{
> +	uint16_t *curve_settings;
> +	int ret =3D 0;
> +	uint32_t cur_value =3D 0, value =3D 0;
> +	uint32_t freq_values[3] =3D {0};
> +	uint32_t i, levels, mark_index =3D 0, count =3D 0;
> +	struct smu_table_context *table_context =3D &smu->smu_table;
> +	uint32_t gen_speed, lane_width;
> +	struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
> +	struct smu_11_0_dpm_context *dpm_context =3D smu_dpm-
> >dpm_context;
> +	PPTable_t *pptable =3D (PPTable_t *)table_context->driver_pptable;
> +	OverDriveTable_t *od_table =3D
> +		(OverDriveTable_t *)table_context->overdrive_table;
> +	struct smu_11_0_overdrive_table *od_settings =3D smu->od_settings;
> +	uint32_t min_value, max_value;
> +	int save_offset =3D *offset;
> +
> +	switch (clk_type) {
> +	case SMU_GFXCLK:
> +	case SMU_SCLK:
> +	case SMU_SOCCLK:
> +	case SMU_MCLK:
> +	case SMU_UCLK:
> +	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:
> +	case SMU_DCEFCLK:
> +		ret =3D navi10_get_current_clk_freq_by_table(smu, clk_type,
> &cur_value);
> +		if (ret)
> +			return 0;
> +
> +		ret =3D smu_v11_0_get_dpm_level_count(smu, clk_type,
> &count);
> +		if (ret)
> +			return 0;
> +
> +		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +			for (i =3D 0; i < count; i++) {
> +				ret =3D
> smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
> +				if (ret)
> +					return (*offset - save_offset);
> +
> +				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i, value,
> +						cur_value =3D=3D value ? "*" : "");
> +
> +			}
> +		} else {
> +			ret =3D smu_v11_0_get_dpm_freq_by_index(smu,
> clk_type, 0, &freq_values[0]);
> +			if (ret)
> +				return 0;
> +			ret =3D smu_v11_0_get_dpm_freq_by_index(smu,
> clk_type, count - 1, &freq_values[2]);
> +			if (ret)
> +				return 0;
> +
> +			freq_values[1] =3D cur_value;
> +			mark_index =3D cur_value =3D=3D freq_values[0] ? 0 :
> +				     cur_value =3D=3D freq_values[2] ? 2 : 1;
> +
> +			levels =3D 3;
> +			if (mark_index !=3D 1) {
> +				levels =3D 2;
> +				freq_values[1] =3D freq_values[2];
> +			}
> +
> +			for (i =3D 0; i < levels; i++) {
> +				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i, freq_values[i],
> +						i =3D=3D mark_index ? "*" : "");
> +			}
> +		}
> +		break;
> +	case SMU_PCIE:
> +		gen_speed =3D
> smu_v11_0_get_current_pcie_link_speed_level(smu);
> +		lane_width =3D
> smu_v11_0_get_current_pcie_link_width_level(smu);
> +		for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %s %s %dMhz %s\n", i,
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 0) ? "2.5GT/s," :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 1) ? "5.0GT/s," :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 2) ? "8.0GT/s," :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 3) ? "16.0GT/s," : "",
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 1) ? "x1" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 2) ? "x2" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 3) ? "x4" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 4) ? "x8" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 5) ? "x12" :
> +					(dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 6) ? "x16" : "",
> +					pptable->LclkFreq[i],
> +					(gen_speed =3D=3D dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i]) &&
> +					(lane_width =3D=3D dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i]) ?
> +					"*" : "");
> +		}
> +		break;
> +	case SMU_OD_SCLK:
> +		if (!smu->od_enabled || !od_table || !od_settings)
> +			break;
> +		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_LIMITS))
> +			break;
> +		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_SCLK:\n0: %uMhz\n1: %uMhz\n",
> +					  od_table->GfxclkFmin, od_table-
> >GfxclkFmax);
> +		break;
> +	case SMU_OD_MCLK:
> +		if (!smu->od_enabled || !od_table || !od_settings)
> +			break;
> +		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_UCLK_MAX))
> +			break;
> +		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_MCLK:\n1: %uMHz\n", od_table->UclkFmax);
> +		break;
> +	case SMU_OD_VDDC_CURVE:
> +		if (!smu->od_enabled || !od_table || !od_settings)
> +			break;
> +		if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_CURVE))
> +			break;
> +		*offset +=3D sysfs_emit_at(buf, *offset,
> "OD_VDDC_CURVE:\n");
> +		for (i =3D 0; i < 3; i++) {
> +			switch (i) {
> +			case 0:
> +				curve_settings =3D &od_table->GfxclkFreq1;
> +				break;
> +			case 1:
> +				curve_settings =3D &od_table->GfxclkFreq2;
> +				break;
> +			case 2:
> +				curve_settings =3D &od_table->GfxclkFreq3;
> +				break;
> +			default:
> +				break;
> +			}
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMHz %umV\n",
> +						  i, curve_settings[0],
> +					curve_settings[1] /
> NAVI10_VOLTAGE_SCALE);
> +		}
> +		break;
> +	case SMU_OD_RANGE:
> +		if (!smu->od_enabled || !od_table || !od_settings)
> +			break;
> +		*offset +=3D sysfs_emit_at(buf, *offset, "%s:\n",
> "OD_RANGE");
> +
> +		if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_GFXCLKFMIN,
> +						    &min_value, NULL);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_GFXCLKFMAX,
> +						    NULL, &max_value);
> +			*offset+=3D sysfs_emit_at(buf, *offset,
> "SCLK: %7uMhz %10uMhz\n",
> +					min_value, max_value);
> +		}
> +
> +		if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_UCLK_MAX)) {
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_UCLKFMAX,
> +						    &min_value, &max_value);
> +			*offset+=3D sysfs_emit_at(buf, *offset,
> "MCLK: %7uMhz %10uMhz\n",
> +					min_value, max_value);
> +		}
> +
> +		if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_CURVE)) {
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
> +					      min_value, max_value);
> +			navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
> +						    &min_value, &max_value);
> +			*offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
> +					      min_value, max_value);
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return (*offset - save_offset);
> +}
> +
[Quan, Evan] I think it's better to put the NV10 implementation into a sper=
ate patch. That is:
Patch1 --> common API framework
Patch2 --> navi10 specific implementation
Patch3 --> update existing sysfs apis to use the new API framework

BR
Evan
>  static int navi10_print_clk_levels(struct smu_context *smu,
>  			enum smu_clk_type clk_type, char *buf)
>  {
> @@ -3238,6 +3426,7 @@ static const struct pptable_funcs navi10_ppt_funcs
> =3D {
>  	.i2c_init =3D navi10_i2c_control_init,
>  	.i2c_fini =3D navi10_i2c_control_fini,
>  	.print_clk_levels =3D navi10_print_clk_levels,
> +	.emit_clk_levels =3D navi10_emit_clk_levels,
>  	.force_clk_levels =3D navi10_force_clk_levels,
>  	.populate_umd_state_clk =3D navi10_populate_umd_state_clk,
>  	.get_clock_by_type_with_latency =3D
> navi10_get_clock_by_type_with_latency,
> --
> 2.34.1
