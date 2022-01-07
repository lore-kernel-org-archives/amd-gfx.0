Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD823C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 02:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4011410F181;
	Fri,  7 Jan 2022 02:20:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D1D10F166
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 02:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhZ6uf6FTHwicNzZGEyWvK4I/xGw3fESHxb9b5q1Dx3HOqnBaoQrqDAi07DF5tGukUna4HsGuSUO4VbUOKZQcE0i3Ump/Ap+ha8bvhiovt+boqtfF0F4lBN/EzF9VHbBoyCoZZDWPzuOaNbSdJqMaNdRROBvAXAeoQM5Tn0+Abl5VirtnFhUML5kqVxvqrnEee1CKEb1B8CMPbCywr9C/Lfo6A1ioe0JBptMrDsqt4uIoyEL/niXNGgGC3e75RsjFwKGxpGi9gi/cojLsQnYceICXX66i5qzRyQ8OQ/xnjBZuqpmxUUg1VnBnXSzBAVjhjKgZHFZRH9yAlixO9xvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcTIeOH13OyTBW6qcgiY3LjoudWvbE0zudZSzW7cXFk=;
 b=X0ifO3ZBIHouRFICNHHftA4YPRisAvqDg5nGcx6j0+9s82m3CsSqwcvdDA1QbDSgP3hrrRGK4ZfjtxotXgTKepF61TacmRHAhNQJ5ClXrXpO/w9BScHA8DBJQ55K0kVf20Z2Nue9JjlFNNJaO3mdomh8J+cy7gv8jX6TldhflQUjyqDdMvDrRO9J4YroNhU5I/8PW3AJoNfPy5EyMEXnKcYFWGOhdr3qFwjvTIIbZlb7dlHS99jybY/9KIVBCEa6pTv5N1jgv9ERd49BKym12MLv2e5FhdNBdKHlFwyQ6bJHcTGmNBb1iBEACsZKcAr2bdoJXU9OBe/Y7F03fbvYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcTIeOH13OyTBW6qcgiY3LjoudWvbE0zudZSzW7cXFk=;
 b=ZVtNPgIEPRy/nE8QhGjMXzEnW5QQhKsvEaYjpP6OSR+Kdy50au6GY4ub2R4PynskVnRoUMF2MSgMJl30SZVaHv2fg+KIFTkbdK7vWsI0dKOmMGJgwD5fIQ89gJx56TvJOEjLGLAFwVBJ1dDiciFYbjrsXezBYPCJ9M4nel6UHGw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Fri, 7 Jan 2022 02:20:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4844.016; Fri, 7 Jan 2022
 02:20:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
Thread-Topic: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
Thread-Index: AQHYAsJaW7gvaUdOjUyoUP9UF9RYD6xV+zcAgADZd4A=
Date: Fri, 7 Jan 2022 02:20:28 +0000
Message-ID: <DM6PR12MB2619ABFC0FF0C408EF434B5AE44D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220106055732.3073780-1-evan.quan@amd.com>
 <20220106055732.3073780-3-evan.quan@amd.com>
 <DM5PR12MB2469674BF581F4ECDC475CBDF14C9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469674BF581F4ECDC475CBDF14C9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-07T02:20:26Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d01985dc-768c-49c1-a390-3aece051ccc1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d236a19f-9561-44e1-8e31-08d9d18445ff
x-ms-traffictypediagnostic: DM6PR12MB2986:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2986B44C0F870089BC61B769E44D9@DM6PR12MB2986.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4X4ZJnVbmC3okqQMPnzgJtlnvqeGiP27QfAQUSpjTjlTkrpkgZO+kW1cNJgMzMIZ2Zma4r4TlozVIayN6UCulO3AuRNimcLGHhLg/j0X5Rpuq5V+StyKy6Qzh6MUrxNH6P4FqBBA5IFW9tWRkYAHqcuJI2es4ZZJ5kQFigplwv/4Y1BTjNh1hbJlJzOKEvahgHImJ6l4TewTv2zm5Lgx0P1i858lfR975prCwDUwGYIn+2Tyc07Eebqpl37fW05Q5U+8Xj4wu2sJ/xhvGjPH9xLVWSnosqHJr7mypx8ajgpyF4hl1F4JDAVLVf3APG74HlP3TyxkfvtMiK4y7BvPd5GFjrqM2oSOYluU+wKust/N+k+mYaL/u+qEjgHgG+HvVoVDjPlE2rr643SmW+akDkUrUrXJVqQjms4kCUEFi6ZsfxO5guKqKt3kCHVO8H/9yE8JNcwvpnGF0oDcEDyZRap7od0ce9Ga3pFDe4IGcAKouRNh/Z3fu/lSwsTAn8dFaAlI7FQ1A/qLh87V/K4xAkNMf0b9sDG8HWo1q9nOy1xRy8Yg19iGuewKDX2yOuQFNOkDmwngOC41yPB7KyWy481UWoB2DCpSu1uOzDie6KRQr8qajMneNPqdksMOa1hym9K63Kp+aKRCqhJPYfbBAoEQzgzsbprLqurbvnZ2Gc9AuQU0WAKsn7pjCV7QuED9e1+EbEahBuoDmoD2yckV0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(6506007)(76116006)(83380400001)(9686003)(66476007)(66946007)(8936002)(5660300002)(53546011)(55016003)(66556008)(38100700002)(316002)(52536014)(2906002)(186003)(110136005)(508600001)(33656002)(122000001)(4326008)(86362001)(64756008)(8676002)(7696005)(26005)(38070700005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1H5cBWCE7T1jXLiNHuMrvt1OeQwFjABOa4VzZUnpb98WYlmkcMdCBpTFi3n0?=
 =?us-ascii?Q?0LNFn6mCYiCvUmyLCDEqIl6963U1czoyGCu5x+55E4vDCBAKpMVESeMl8WIT?=
 =?us-ascii?Q?kIaX1UaLii4o6oCnQ8MG1hegVNtSeYHwjKtF8POodjMredd8AfwiQsWUOSId?=
 =?us-ascii?Q?1osOn0e3U3kTWyMeZII47jl3c5p5E90+YlicXhELeIAbMoOTfnsWdJ9LQ2QQ?=
 =?us-ascii?Q?X9dSL7bDsg+F2v9yh0anjrDim934bT3HzUxQ0kf/amiX//zS18j0zE9de1Zv?=
 =?us-ascii?Q?qS0YFAKeSCIKTC+5vhj50zQqeHM/TsozTOFgFBjJR/Q0PEDkv1UxJm53vX2O?=
 =?us-ascii?Q?e48ZDiQQp0MlUrPeEDoKTdZTaBEeLpAq4qQ7ZVE/0prjeqvHUmnD5DilgtDK?=
 =?us-ascii?Q?I8YM4ZkHcpH6CSlGD2+BUyM2pGszQwOHPthqc2LOHvLZHJWH4ZRzzvOpoBNH?=
 =?us-ascii?Q?KlBcxal59ZgMwCD33d8znd0+QLpylZRx8z8k/kwHTwTKL6gPheFbNOmQXBbj?=
 =?us-ascii?Q?197fpxAOC5OLdHhzJGOCPf6M/cx5qzCEHb9y1JmdnNpIY+eS/aBgxtJgR0JM?=
 =?us-ascii?Q?Jm7PlOJocQaPIkIuNbweS+5t2wkv6+rH8sm0dNMKpqbVSovQOnmIEr6wJY6X?=
 =?us-ascii?Q?s2/uSV1gJtLaebJwnY0oqvVylq+hZ/gqJprI6OrIvCo0lJt18qhEdrO45UwZ?=
 =?us-ascii?Q?uyTbkauGORMnMx4fmCPhaQk9htMBQwApGu1i/HdDdfMgsmkRl6g5DqBqKPOU?=
 =?us-ascii?Q?fThgH6oTQmr9KKLh07DuiOEY8UdWY533JWmVLQ58T4S3ibSGH03ZhmDUz0kQ?=
 =?us-ascii?Q?XbKxxukOfLeteXZiLbVpM1KIsiLlD7ppvKXFfVgkX9QmtOD2swvW7q05a7bs?=
 =?us-ascii?Q?w/C2nsOFcadjpEu6kJ2gzriN0FP/Th/V3pJlkge6m5KZpIScVNdcZmLAQscY?=
 =?us-ascii?Q?mchqsO9IqlQVTL5DrcgicGm5DfJgAD3QI8Og0tIXZOQ+YPDX3WzEaTi4iGwB?=
 =?us-ascii?Q?WTZzX7IodGWvosbrTrk2e1oGbB0/aOFsPMO6y5jrIi1f+QrrUZzXS5ADtM4j?=
 =?us-ascii?Q?agJWoESNeHtvy3CBrlPoHy74KKkx6LYLr7OkXapS+59FLJcp1Ocpre1LW9mM?=
 =?us-ascii?Q?TeshvqpEnTP91Ye0PgpJPLSS/t0WqUtCUzNSoYs93v7+i4+5nBovQBxw6BYT?=
 =?us-ascii?Q?WLERtC72MTd5FhheeYuK60Q8253UMWqQ3B76PFBNwm9IK5Dn4ucGzPMmQNVZ?=
 =?us-ascii?Q?vaRKgsQ2JlhOB7KL3DVJkOi6m4UL2fWjEmjBOnV36ZUU8W+JlGoQuscXDvfP?=
 =?us-ascii?Q?UeKoFtXO4vzN4dmlyMI7jFqN74slO11dPuo+QfbwD+bMSdq2JYGgX2/RHRbN?=
 =?us-ascii?Q?k687r9sdk7gwwHbwt5mGQLBnrkff6CNNRTQjbLwdLEtZjwPR5vJsu9AExABT?=
 =?us-ascii?Q?vsq6Q7adbOeXnLgwpDk8QlvyqOySaOqstKtlzmvXkz5yxAVD4VuLcarSbckp?=
 =?us-ascii?Q?TzUS1qagv6NQ2xx6BS1hne/jQa5gJwxU7OgxhhGlLEbI9MJHjWnhIpcP/Q8T?=
 =?us-ascii?Q?ocYcyu/kLCwpfR4Rj3s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d236a19f-9561-44e1-8e31-08d9d18445ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 02:20:28.8493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/B2mLe2h+8myBQL1x0iSToraIvBoNJHB5TWT5BTmU7RuToidFt0k/RQKleBe2Ot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, January 6, 2022 9:22 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: RE: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
>=20
> [Public]
>=20
> err0_out:
> -	mutex_unlock(&power_gate->jpeg_gate_lock);
> -	mutex_unlock(&power_gate->vcn_gate_lock);
> -
>  	return ret;
>=20
> Is it better to refactor the code to drop error path of "err0_out"?
[Quan, Evan] Sure, I can do that.

BR
Evan
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan
> Quan
> Sent: Thursday, January 6, 2022 1:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
>=20
> As those related APIs are already protected by adev->pm.mutex.
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I762fab96bb1c034c153b029f939ec6e498460007
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 56 +++----------------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 -
>  2 files changed, 8 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ae91ef2078bf..ecbc768dfe2f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -158,8 +158,8 @@ static u32 smu_get_sclk(void *handle, bool low)
>  	return clk_freq * 100;
>  }
>=20
> -static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
> -					 bool enable)
> +static int smu_dpm_set_vcn_enable(struct smu_context *smu,
> +				  bool enable)
>  {
>  	struct smu_power_context *smu_power =3D &smu->smu_power;
>  	struct smu_power_gate *power_gate =3D &smu_power->power_gate;
> @@ -178,24 +178,8 @@ static int smu_dpm_set_vcn_enable_locked(struct
> smu_context *smu,
>  	return ret;
>  }
>=20
> -static int smu_dpm_set_vcn_enable(struct smu_context *smu,
> -				  bool enable)
> -{
> -	struct smu_power_context *smu_power =3D &smu->smu_power;
> -	struct smu_power_gate *power_gate =3D &smu_power->power_gate;
> -	int ret =3D 0;
> -
> -	mutex_lock(&power_gate->vcn_gate_lock);
> -
> -	ret =3D smu_dpm_set_vcn_enable_locked(smu, enable);
> -
> -	mutex_unlock(&power_gate->vcn_gate_lock);
> -
> -	return ret;
> -}
> -
> -static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
> -					  bool enable)
> +static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
> +				   bool enable)
>  {
>  	struct smu_power_context *smu_power =3D &smu->smu_power;
>  	struct smu_power_gate *power_gate =3D &smu_power->power_gate;
> @@ -214,22 +198,6 @@ static int smu_dpm_set_jpeg_enable_locked(struct
> smu_context *smu,
>  	return ret;
>  }
>=20
> -static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
> -				   bool enable)
> -{
> -	struct smu_power_context *smu_power =3D &smu->smu_power;
> -	struct smu_power_gate *power_gate =3D &smu_power->power_gate;
> -	int ret =3D 0;
> -
> -	mutex_lock(&power_gate->jpeg_gate_lock);
> -
> -	ret =3D smu_dpm_set_jpeg_enable_locked(smu, enable);
> -
> -	mutex_unlock(&power_gate->jpeg_gate_lock);
> -
> -	return ret;
> -}
> -
>  /**
>   * smu_dpm_set_power_gate - power gate/ungate the specific IP block
>   *
> @@ -619,17 +587,14 @@ static int smu_set_default_dpm_table(struct
> smu_context *smu)
>  	if (!smu->ppt_funcs->set_default_dpm_table)
>  		return 0;
>=20
> -	mutex_lock(&power_gate->vcn_gate_lock);
> -	mutex_lock(&power_gate->jpeg_gate_lock);
> -
>  	vcn_gate =3D atomic_read(&power_gate->vcn_gated);
>  	jpeg_gate =3D atomic_read(&power_gate->jpeg_gated);
>=20
> -	ret =3D smu_dpm_set_vcn_enable_locked(smu, true);
> +	ret =3D smu_dpm_set_vcn_enable(smu, true);
>  	if (ret)
>  		goto err0_out;
>=20
> -	ret =3D smu_dpm_set_jpeg_enable_locked(smu, true);
> +	ret =3D smu_dpm_set_jpeg_enable(smu, true);
>  	if (ret)
>  		goto err1_out;
>=20
> @@ -638,13 +603,10 @@ static int smu_set_default_dpm_table(struct
> smu_context *smu)
>  		dev_err(smu->adev->dev,
>  			"Failed to setup default dpm clock tables!\n");
>=20
> -	smu_dpm_set_jpeg_enable_locked(smu, !jpeg_gate);
> +	smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
>  err1_out:
> -	smu_dpm_set_vcn_enable_locked(smu, !vcn_gate);
> +	smu_dpm_set_vcn_enable(smu, !vcn_gate);
>  err0_out:
> -	mutex_unlock(&power_gate->jpeg_gate_lock);
> -	mutex_unlock(&power_gate->vcn_gate_lock);
> -
>  	return ret;
>  }
>=20
> @@ -1006,8 +968,6 @@ static int smu_sw_init(void *handle)
>=20
>  	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
> -	mutex_init(&smu->smu_power.power_gate.vcn_gate_lock);
> -	mutex_init(&smu->smu_power.power_gate.jpeg_gate_lock);
>=20
>  	smu->workload_mask =3D 1 << smu-
> >workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>  	smu-
> >workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0; diff -
> -git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 00760f3c6da5..c3efe4fea5e0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -376,8 +376,6 @@ struct smu_power_gate {
>  	bool vce_gated;
>  	atomic_t vcn_gated;
>  	atomic_t jpeg_gated;
> -	struct mutex vcn_gate_lock;
> -	struct mutex jpeg_gate_lock;
>  };
>=20
>  struct smu_power_context {
> --
> 2.29.0
