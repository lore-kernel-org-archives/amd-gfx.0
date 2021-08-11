Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325BDC432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 07:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB01E60551
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 07:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB01E60551
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105E36E0CC;
	Wed, 11 Aug 2021 07:58:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A8089E05
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 07:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eggFetY57KiUsmxbnwzx0bDs8x71l9XzHbSdZQR0RFUScTC7hadRlN8iXfRcu2DKQlDbnwwQZswPq//x6zFhvttSQuhidWCdKBCQYZjZ8A9MwkcsDztDrRGMN5sfflyq9jeuO17MchHcqsIAAfNdiwfStPwtALcHzvXAbq0G+Yzp79lVmxZ0rT0w7LSfwkqiK3Yy+6a21lsAKlSyzqluo9LDlE3cRkNqw1EXQ5uo4sV7pKcEDYFF4K6Mc/XcF0F+OvLxJTEo/fm2kbv4MKBNR4Wx1IwnfRddzFVhaar/Q5omhg/yL6oqbAHcswhYK0C0zJqGXl8Ec38yfnFxJ4ixNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfPThzlNsU5lhJxF/lHOJ2/Ep8TQqnRjkX3tdEdWMR8=;
 b=S3xw5K3GNDL+iU5GqQ1qshUiU8TlZAXqqU8aQq9zsA/luYS8irX3bgncwPQV0dB+mTVzjLb3bNEBvQhCZjN5m31WNiOdurqt+/0OozpZ2vAIM/qjHCkR46+u2P0FhU2zUQdt9p06rWwhrzF6KD6x2vmpCHG5l+0CXFP59ow2xHStDFk8YPApuoO3NMwELpbSv0cTyyC8VoEq0t7OhiagwmMSuSo/BgNGpsDC+g9b88vHZSBMk0iD+yvkO3bWiv7uV19qiHMmo8PUy7Mc/PvxQaX3WY/bJlgeegb/2qX0DXpKSqUmjtWDflCUrAlsLPOIQE4PZ25Ee1G7xWwaK995+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfPThzlNsU5lhJxF/lHOJ2/Ep8TQqnRjkX3tdEdWMR8=;
 b=ZEDDx/2YcPeG9ZgNt6SsnjvipOzqz8f/gKx9UkLM92jNBXKkojnqVUkgIPeTMN3swnpPiMBO2W6fbukQa7BEdDncmfyW433faAJxwT3T3eO8vaxwOBJz2ZKCzKBaQxrlLXX9BIaP9TzD5sx4K/ot2lsqxbdBz8xl94NMsz0Mzqs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (2603:10b6:3:e1::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.19; Wed, 11 Aug 2021 07:58:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 07:58:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting
Thread-Topic: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting
Thread-Index: AQHXctOyAerpsfQipEqxvRZs2fExuqs28MkAgDc2XXA=
Date: Wed, 11 Aug 2021 07:58:00 +0000
Message-ID: <DM6PR12MB26195CEE48633C1671B13BA8E4F89@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
 <BN6PR12MB1283FFC825660548C25FF23CF11A9@BN6PR12MB1283.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB1283FFC825660548C25FF23CF11A9@BN6PR12MB1283.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-11T07:57:53Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=076c083f-5276-4aed-bcc5-284a72787de8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9c8ae44-2711-485f-0e05-08d95c9dbd51
x-ms-traffictypediagnostic: DM5PR1201MB2472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB24725EB3CA2522A6DBF5B48DE4F89@DM5PR1201MB2472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3LC8S5aYzcPz4eY0j07RxaDfp7ynWZYYyyiMIVD86j8H3w9CGYxNxV+IfutB4x0srDXc2QKLfiZs/cs7bYScCNAWtFz+eFpYG9c86j60LyMg/mDv29PWi/52jSC/OdU/3sG3fLo9xI967j2l2/dIsKlotP2WmmFUm1H6pRauUvCOCmou7un5MsWp7Wm63GxLrmT/j/b6j2/aElVkNY2o9p0DVQ7lQo/xq1UcstDwfWR/f8+JTqYoCxsEeFNJOi29TgVNp+6bFeezYkgk+rnD8UHkerEQzxSC7VPhgyNa+9Re6tuxl+8Cz3eFshCHW+qfnRf2nmiOXmFcQym/OfxHz0Go/+00t4iF9/8WLhrhV5mRzRW03Ij2eXZvxSsSR2Rs/JHAIE+iNa2929M0PC+zzEWk20Kt9/D9sUeiOXxFudoqDk+RvI4ju75jDXH2rybW8nZIdmeiLeNGQPyfcwW5OoskuE4qN7tw5UyKXQrFqQr1gR1Q+0Qm+KtPJH4umt1LTQF+2Lxd9cMoj+aOBguIQqvgzMdB/h6O2rnMXc3792AmMMcuqAf5ZsTC1mPZbWCuwWUIB47+Rkg95AUsC67dWUkSSN5KUr42U6oe4hgStdNqBY0hoKGDn6zHLPEM1B2pYNQIlVNHyzm+g8YFbfsbq775ipZZiMVU+sV0UWouNynbKtooeJG9HsINrKkjbjcOKspbAx6z4LvpyPTZ13pUk6j19LkHMC3JopUbiluXhg5vt86XHEw2Mewhp6tOrO+1hDTOdG/sWzhyxfQ3/cxQi/NvgpHoZNca1bV78BJiwU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(52536014)(38100700002)(110136005)(316002)(26005)(66446008)(66556008)(38070700005)(64756008)(2906002)(76116006)(66476007)(66946007)(45080400002)(4326008)(122000001)(186003)(478600001)(83380400001)(8936002)(71200400001)(9686003)(86362001)(55016002)(5660300002)(7696005)(966005)(33656002)(8676002)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HPu8B9yu6svg+9tGczVdSDdrJ/NNv5NfQ7kc0xpZJr3keKlJXKh0x4Puvuug?=
 =?us-ascii?Q?GRgYzeA9z2zbEfA8zZvMRjJEtwvkLfU4naCo9RtfX4tPINIzQgYFqDMcDfQz?=
 =?us-ascii?Q?SY4brGCTsD1CgGD49lam2HDIAE3iy/Qoe/cZrfgoTF+Se4bYQdpZAQvsA5/z?=
 =?us-ascii?Q?S5CqMYvZNn3v0+UG8fp8PE854AdC+V1gGIWg6/b6nRPW10voQUvNjgc2GYEZ?=
 =?us-ascii?Q?M+oCSUEfvhiK/uJ8/A4l2k2tGoB3m7UW+Mcrq4/g0glhrRiJi+VZYvTMpPz/?=
 =?us-ascii?Q?K9v7zTaJw7dH0dCAc4XpJIYe8A/5Yxiwe3VmzgmegctIwqr0SLNr/oAjSTfY?=
 =?us-ascii?Q?l5cQnz0K9CVZH+hDIdIjxdUNG+uwwSqW8sNt5xHkbdmnRwIWwrzIb7ZpXq21?=
 =?us-ascii?Q?+CF2dlPtjeiNgpB7kG3GfRc52q6WF9uj+VnZtVY3iv9ErcaaHgdfBeRqpxJr?=
 =?us-ascii?Q?j5QOa62vLdbudBAF44lttYD8gXfEKgIPwlhVbXIjlV54otsuVLv/L26MfsYN?=
 =?us-ascii?Q?ahJfND9kSHe7+fayWTMsbXLMoFIaBySowLzbeR7TTW/KkEGCwDxA7abzC+s4?=
 =?us-ascii?Q?514ZEJKoC7fvNXAEdtHL2Au48N/9TqQCPqY1dGGr4ZS5P/KJihizAc2mSLo1?=
 =?us-ascii?Q?Jyq22hJ6eOjt82oaKUuNR4qu5soKS6CkDTMLdE0XMPkg2lXUykWF8jBovZQo?=
 =?us-ascii?Q?3/6nBX/pxCU5h+f3l0Hn48Zrn7hY2L+vncGW+jVWAgk/MKF7lV0gPSulOKKs?=
 =?us-ascii?Q?ptFwaTDSR4wcnyOFqIXdjVSAfYuVRuMe+fAbn/I99EcrKxOHoiiljGXeOdqA?=
 =?us-ascii?Q?ngMSmXKKEY1hVXKZIsarZ9SbAUM4zRFq6BJlccol905mzxK1dToCN9wVY6qH?=
 =?us-ascii?Q?NImTmkGywVzoexVEsIGDUvq0Hs0cU5j+lOcNXGdNP0Sepa1pKn6vyUzY2UPW?=
 =?us-ascii?Q?0bXGp/0PYGgRhyEtx+7FBYpnhpRgHcVUDOoHIQUG5MRyBXLigfvXuL14wW6h?=
 =?us-ascii?Q?10p6mtoQ6lfkfYvGJLa5ZeQqMaSH7cVZboQvEmhrkVArAXMDuvNxrPA5VDiq?=
 =?us-ascii?Q?yw1qmMbXGg3PkPE+aDCZEUzpPmFsOFsvPizPpCiCNiL257YCy4HY+10uXaMZ?=
 =?us-ascii?Q?gipfXfnxQgv8wlMY5Oa3EaIHeN1/XqHntLanQJ/s7sUfmimZO7aCohY341Iq?=
 =?us-ascii?Q?ZNoIOozL/tSTEkMnjfUis6QjqMzscks3T6PyDsfgr7dMRIxQWNHczikm7x1t?=
 =?us-ascii?Q?i4Yg10wWWLz4yK6N792JG9Ot2OaFD/UiRpFpMS+w747M13zi/jg3mXx4J2l8?=
 =?us-ascii?Q?XBaUZwvMzgyN8lTqQTAkbjc/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c8ae44-2711-485f-0e05-08d95c9dbd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 07:58:00.4043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfpWV2m/uAgUdfAWg0tMOz5D/8cD+5vprynSj7/8uchnHUrvOoWN88CJ/dPPDfZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
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

[Public]



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, July 7, 2021 12:48 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: RE: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting
>=20
> [Public]
>=20
> tach_period =3D 60 * crystal_clock_freq * 10000 / (8 * speed);
>=20
> Any multiplication's overflow possibility?
[Quan, Evan] crystal_clock_freq is actually always 2500. So, it's pretty sa=
fe here.
BR
Evan
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan
> Quan
> Sent: Wednesday, July 7, 2021 9:57 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting
>=20
> The relationship "PWM =3D RPM / smu->fan_max_rpm" between fan speed
> PWM and RPM is not true for SMU11 ASICs. So, we need a new way to
> perform the fan speed RPM setting.
>=20
> Change-Id: I1afe8102f02ead9a8a07c7105f689ac60a85b0d8
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +++
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 36
> +++++++++++++++++++
>  7 files changed, 52 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3e89852e4820..6301e4cb3c2a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1039,6 +1039,11 @@ struct pptable_funcs {
>  	 */
>  	int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t
> speed);
>=20
> +	/**
> +	 * @set_fan_speed_rpm: Set a static fan speed in rpm.
> +	 */
> +	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t
> speed);
> +
>  	/**
>  	 * @set_xgmi_pstate: Set inter-chip global memory interconnect
> pstate.
>  	 * &pstate: Pstate to set. D0 if Nonzero, D3 otherwise.
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index b89e7dca8906..134a33e3de91 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -223,6 +223,9 @@ smu_v11_0_set_fan_control_mode(struct
> smu_context *smu,  int smu_v11_0_set_fan_speed_percent(struct
> smu_context *smu,
>  				    uint32_t speed);
>=20
> +int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
> +				uint32_t speed);
> +
>  int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
>  				     uint32_t pstate);
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ebe672142808..576e9ea68fd1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2174,11 +2174,12 @@ static int smu_set_fan_speed_rpm(void *handle,
> uint32_t speed)
>=20
>  	mutex_lock(&smu->mutex);
>=20
> -	if (smu->ppt_funcs->set_fan_speed_percent) {
> -		percent =3D speed * 100 / smu->fan_max_rpm;
> -		ret =3D smu->ppt_funcs->set_fan_speed_percent(smu,
> percent);
> -		if (!ret && !(smu->user_dpm_profile.flags &
> SMU_DPM_USER_PROFILE_RESTORE))
> +	if (smu->ppt_funcs->set_fan_speed_rpm) {
> +		ret =3D smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
> +		if (!ret && smu->user_dpm_profile.flags &
> SMU_DPM_USER_PROFILE_RESTORE) {
> +			percent =3D speed * 100 / smu->fan_max_rpm;
>  			smu->user_dpm_profile.fan_speed_percent =3D
> percent;
> +		}
>  	}
>=20
>  	mutex_unlock(&smu->mutex);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 6b3e0ea10163..047adf6dd444 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2314,6 +2314,7 @@ static const struct pptable_funcs
> arcturus_ppt_funcs =3D {
>  	.get_fan_control_mode =3D smu_v11_0_get_fan_control_mode,
>  	.set_fan_control_mode =3D smu_v11_0_set_fan_control_mode,
>  	.set_fan_speed_percent =3D smu_v11_0_set_fan_speed_percent,
> +	.set_fan_speed_rpm =3D smu_v11_0_set_fan_speed_rpm,
>  	.set_xgmi_pstate =3D smu_v11_0_set_xgmi_pstate,
>  	.gfx_off_control =3D smu_v11_0_gfx_off_control,
>  	.register_irq_handler =3D smu_v11_0_register_irq_handler, diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 59ea59acfb00..d8a011483dcf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -3248,6 +3248,7 @@ static const struct pptable_funcs navi10_ppt_funcs
> =3D {
>  	.get_fan_control_mode =3D smu_v11_0_get_fan_control_mode,
>  	.set_fan_control_mode =3D smu_v11_0_set_fan_control_mode,
>  	.set_fan_speed_percent =3D smu_v11_0_set_fan_speed_percent,
> +	.set_fan_speed_rpm =3D smu_v11_0_set_fan_speed_rpm,
>  	.set_xgmi_pstate =3D smu_v11_0_set_xgmi_pstate,
>  	.gfx_off_control =3D smu_v11_0_gfx_off_control,
>  	.register_irq_handler =3D smu_v11_0_register_irq_handler, diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 83d8e53ca1f8..dad120294c19 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3886,6 +3886,7 @@ static const struct pptable_funcs
> sienna_cichlid_ppt_funcs =3D {
>  	.get_fan_control_mode =3D smu_v11_0_get_fan_control_mode,
>  	.set_fan_control_mode =3D smu_v11_0_set_fan_control_mode,
>  	.set_fan_speed_percent =3D smu_v11_0_set_fan_speed_percent,
> +	.set_fan_speed_rpm =3D smu_v11_0_set_fan_speed_rpm,
>  	.set_xgmi_pstate =3D smu_v11_0_set_xgmi_pstate,
>  	.gfx_off_control =3D smu_v11_0_gfx_off_control,
>  	.register_irq_handler =3D smu_v11_0_register_irq_handler, diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 388c5cb5c647..fefc8e93fdc6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1213,6 +1213,42 @@ smu_v11_0_set_fan_speed_percent(struct
> smu_context *smu, uint32_t speed)
>  	return smu_v11_0_set_fan_static_mode(smu,
> FDO_PWM_MODE_STATIC);  }
>=20
> +int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
> +				uint32_t speed)
> +{
> +	struct amdgpu_device *adev =3D smu->adev;
> +	uint32_t tach_period, crystal_clock_freq;
> +	int ret;
> +
> +	ret =3D smu_v11_0_auto_fan_control(smu, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * crystal_clock_freq div by 4 is required since the fan control
> +	 * module refers to 25MHz
> +	 */
> +	crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;
> +
> +	/*
> +	 * To prevent from possible overheat, some ASICs may have
> requirement
> +	 * for minimum fan speed:
> +	 * - For some NV10 SKU, the fan speed cannot be set lower than
> +	 *   700 RPM.
> +	 * - For some Sienna Cichlid SKU, the fan speed cannot be set
> +	 *   lower than 500 RPM.
> +	 */
> +	tach_period =3D 60 * crystal_clock_freq * 10000 / (8 * speed);
> +	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
> +		     REG_SET_FIELD(RREG32_SOC15(THM, 0,
> mmCG_TACH_CTRL),
> +				   CG_TACH_CTRL, TARGET_PERIOD,
> +				   tach_period));
> +
> +	ret =3D smu_v11_0_set_fan_static_mode(smu,
> FDO_PWM_MODE_STATIC_RPM);
> +
> +	return ret;
> +}
> +
>  int
>  smu_v11_0_set_fan_control_mode(struct smu_context *smu,
>  			       uint32_t mode)
> --
> 2.29.0
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=3D04%7C01%7Cguchun.chen%40amd.com%7C645297d9dabb45c
> de58708d940ead718%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
> C637612199673041719%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
> ta=3Du55f4UA2CryPci5gT95LVEm%2F1%2FGeys0N39USkBTgTFM%3D&amp;res
> erved=3D0
