Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DD5C25B5C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 05:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0C710E95E;
	Tue,  7 May 2024 05:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dAud5y4e";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43EA910E95E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 05:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHXlhfSz2OiBD065PX2AqDCmLO+J4oTHJYJlHFtjgz+ML3yh5DlvCg3pdR5/aGmPlvnPPN3VS00hzhhVYJy7PpK8F0LcMLZts0++ETACCBranMam0+9cPROeqdp261vknTqRKMtY7qUwx9vagMyaV7vTbGXCOgy5Z++gDCiijx30aEYxCHozA8qvmBmxvzQaaymFAv31ztkeelPl3nmMaGihCTLdtapqFEZw1nTqVYJfIx79BwEZyXa7D6hwvoZ5pk//aMv1GsTxdxE6TuD4FidBMZNBJPHdq3juFQaGM+ChCnWhA9TutaNtj1it7tWjEHJIy/hCYg1gBaBHi1xSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+RrIQ371MwANcACglyGTAuELwmh4F99IrUnMPQlACc=;
 b=GtSUqRol4D39YBTXEq63zlACLW+mAB/MnUtma95R1YpTJpCxj4gwsdJ/UrBhYbbfE3Q1wbUdV1iJYGAekPFb3wOxl9GzF7cIDKCvSUq/MLZcsdUXlb4uVcLPykmhtbr0P1vVbA/jH4ooy1B8149MOpIGh20yDHD08Ydb3JqzGfR5v1uJG4J+iDIV8z3gqolpMt/mLA0juHpH+2kIfpLL7IK5VCaQk6Xanh1uQLdPBeST/EAFaCC+L6/3WxkXAElRzxYY7Uasyvycu+ph5D/YNj4e22H7IvTeMdO/zIx6AXG+6jFm1mbWFI8VuRmtphDv0de0FPk1Pq2sP6K4e+/0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+RrIQ371MwANcACglyGTAuELwmh4F99IrUnMPQlACc=;
 b=dAud5y4eCqb4KsUgGdiRuxbV5U9VXugSck2AHdB0eMYXjSCmMyToxwi5CAeRpNBWY3Szwzpg9Q0b4CiBtR/KuxRcltzZswhG0/nY3y42XcHlIutUIoMTeO8KWpe1u9LKVTcr1lkdFyOOvu68Ha2YYVM2n4myJjE8yHlEMxkzQZU=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Tue, 7 May 2024 05:02:04 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 05:02:04 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: enable UMD Pstate profile level for renoir
Thread-Topic: [PATCH 2/2] drm/amd/pm: enable UMD Pstate profile level for
 renoir
Thread-Index: AQHaoDC/p2ixrkxNzk+v3SLxUfFu47GLNWOg
Date: Tue, 7 May 2024 05:02:04 +0000
Message-ID: <CH3PR12MB8074A80E60D3B7A26B28CBFAF6E42@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240507034312.3177370-1-jesse.zhang@amd.com>
In-Reply-To: <20240507034312.3177370-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c63d29ac-0873-4c21-96e3-d6631dc9ed1b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-07T04:56:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS0PR12MB8293:EE_
x-ms-office365-filtering-correlation-id: bcca4237-f21d-4dde-1f1c-08dc6e52d659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Q9f40cHFyzvoImxNh+as8tv9no0FbKWKcx2qMUH0HlWHK8OLYNo7uKFKL2?=
 =?iso-8859-1?Q?ZWBmnLhOw612ToNLuWobSJecvkyRiEMh82vVWnGkIJ/syTiAb8nBPZCQ0+?=
 =?iso-8859-1?Q?5HoB+LNjTK5QQmcXKS/6rEnWoyS7Uu+5OEn/gHRIVwoCAkOw9Nl0FWia5y?=
 =?iso-8859-1?Q?zvk7oxFD26xM30irxlJfTIWhpyEZn7iPaKJ1BtCtgoVfM6E7gdklByaTmh?=
 =?iso-8859-1?Q?aq683jHTuKQITN/G+wzR0xX8ap0T1jAAt2ncGgar4Vgs/hwLjE/+WECLl+?=
 =?iso-8859-1?Q?6inNM7gq6Ks0w97NXEg2Eq86Fhg7CO2sjNOw9vXlR0jJQ6CANhS5TQk7+v?=
 =?iso-8859-1?Q?V3Zl4Ad3hiB7Zmgd1RWX4/WWh+09q/6Dy1b8e2IjolrlrAbqWSv8TazCuo?=
 =?iso-8859-1?Q?3+3Vm/TfH5o6nv3RAXdfyDVYnPTjzyIDCTC4dE9mNcqnTZaewwHpN3JW/4?=
 =?iso-8859-1?Q?dTOWRa3S6OlEMqasR3pRiKUG8JHKIRd812cwuiwHvGzrxx87L/wqkoRewo?=
 =?iso-8859-1?Q?cxesjwy0J3qYDnfGtx3i3K4mk4mwqkSzAEwjZZ8MI7XGjn0bGnXeCLGjH2?=
 =?iso-8859-1?Q?ahs75xweJjm+RSAwGdnXNef4AatS7N0h72mFetvZXsEsTEH0dceWxqI/zk?=
 =?iso-8859-1?Q?0q29XIH9soYE8px6CMQMIjlb3j6Jr1BflpjuKAfLV4ZB5dhRYgGbwNm2AQ?=
 =?iso-8859-1?Q?OFbgsKUqHUV4G0p3K8XyEtwHkLPb92A3+d7H1Z7+zAIAEacjq+VCDOfAPd?=
 =?iso-8859-1?Q?mHI/b7vSik7yzExE19s2mkmYEEQY0qk7l7VpS9xSZLJZHOslPeRWQBna+T?=
 =?iso-8859-1?Q?XXVDEzCED9MKdfI87UIB+ZchV7HGQww1y+MNqXhe3F0Oa4JSnGvMi1iaWc?=
 =?iso-8859-1?Q?AfsISJuQfHtF7jPOjO40vuYWkguVHIt56w/MMAo8weuYRANmc5Q072vFoL?=
 =?iso-8859-1?Q?iumS3xxRNldv2H9o0dx9f+MJGIRakoHcgueoizURGgphbN/gqCq5v6koVP?=
 =?iso-8859-1?Q?bvvdFUl4hUEKGdpYIrtOOl/Xp/DtL1oHVLMVTPYzWlBLTtrMGNvLbzJiCu?=
 =?iso-8859-1?Q?XTnwInjhhbDcKq63pPXlXet6vVEHnz2WJcmu+h+gdJiz9Gk2K0YnKnSxcG?=
 =?iso-8859-1?Q?szPuHqP5jrt8EieB2uY9eWbnoqkc+0+3T0ikOjjeiEf6X4LsHyH+3E1U4M?=
 =?iso-8859-1?Q?bY5Lga5Oe0yT5gvdg2Zo+FiZxH0m7+xbc6BdGDGlGNWf6pKlJObCI72Xf4?=
 =?iso-8859-1?Q?quJ1yNZjsjwCGSU698FXqSpDkM5Y1lwb5fznk6u51hUOLBCfj5Pv17+Rlm?=
 =?iso-8859-1?Q?d6oZ6+aKxDgvtQwKjx1dsznH1MY7PGxvGi0R4xuD8lEexBvLt7Ag5Tq4+s?=
 =?iso-8859-1?Q?4nTcIm9hwZLE1GDWs/UOWvvWZp2xnuOQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?72ETHDju82z9+0WcZOCXaafSIHcFJufw5yi2/a1DO2gSUQU3zfwmNrmeDi?=
 =?iso-8859-1?Q?PfH6HCJL1Cw2AIx563ksKK2T/9vIjEDSz1IZZNOUDh0JLmPvD80uDUbyeU?=
 =?iso-8859-1?Q?AFQx+/VzvfgK0X3eJpM4eHo3OA8UHqMYEodyvAzAdrhhGrRTUra/Q/y5s+?=
 =?iso-8859-1?Q?z8FmJS5mKxt7d9IRpU62/gVzHSes5gpZV5niYApzE8reNQkGnhKvRgnAK6?=
 =?iso-8859-1?Q?GaMAY/0UrpUk3jiEAguUx8O12TwfYjoz2gpA3G4AscAZ4UpaCM92SzutEO?=
 =?iso-8859-1?Q?I6z3A1D+8fSmZj7F/8bDGObvv1nRU6TwbCF6xaL3FDU1U0JvcAAoRtal03?=
 =?iso-8859-1?Q?DF0XA8oxob9bfFWh72rrhxp5RtSUOZrOu8hz5C49kVD0NPV51r3SYReny8?=
 =?iso-8859-1?Q?pde2XgGpvK/c95NxzfQfnb1I3CyeGX/xCmKVU+d/pkjiSBtHSon8b8qd0z?=
 =?iso-8859-1?Q?Lw345ZU6nqB7p51aNQh2VR1l0dvtLtYgwUVSvteomMEdM1LOHu3ePRkW5/?=
 =?iso-8859-1?Q?4qSrV3sWpN9aNLF9IeIAKWVzBH5QD/SDEG17cvV2tt7IhYYF+9F1LLHfdV?=
 =?iso-8859-1?Q?x9JVCt9CgRrCxyAB7ryHUgaKkpKC50G28744Q2BQsVzZFX7DQh+e3V8+Z6?=
 =?iso-8859-1?Q?3B+o7JTpTcxaZLU4PJ66DhgxnqIC2sQ7ISz559GlNiAtyoo5o3VA2ulWQa?=
 =?iso-8859-1?Q?6C+cG07SKaIl2dRu8k1vYcEPkpkcVyi65tfVZjMQbTv2GT/72YjnzcObha?=
 =?iso-8859-1?Q?RZmkFrlRg7uBIeuUJgAjSbO/uCM+Z3Wu3bi1uVPELZKfBabY3fY7eYkZCB?=
 =?iso-8859-1?Q?x7Kp00XMffi78+ppE9DFAi3qn7xpCvdZheWzUCwEYhQaw+98zILw0JKE33?=
 =?iso-8859-1?Q?iP8opR3AK3+hJ9k0B+FRT8lzoilrMnAfSFH0PtLKd05DwmBvLHffDuFWR7?=
 =?iso-8859-1?Q?/LEt0tcXiqDt2InVcxugzHllOBx8EhvuYGqFLOCxUh+ZCe4BTR4Pbbd66m?=
 =?iso-8859-1?Q?YgpoO+VuH48v2vUM0iRa6/bTqBKN/LjG93WZa2Ft1eXMkt3oqz0y/F+/Va?=
 =?iso-8859-1?Q?PIcV49b8+gxsZNLZZTAT2JU0Vumvf/d2CMZx4EJRyui95dVQ6vPQ5QqRtE?=
 =?iso-8859-1?Q?DHD5KrObSGJyaoGIc3l68zNnT63mIxv9qChXPb6FeTuAJ7tRQrR2Xabc3y?=
 =?iso-8859-1?Q?UDbjXYCUpiEqx9egEPy8ujPRE1gPEmyhBp2BywjF0htiEf2zPsLrp9me0Y?=
 =?iso-8859-1?Q?vq6fDQqM+PwxujQnCbxLZ71lTbTG4MKZJC5WxCkjDlZMvCUFd16c3S1N3o?=
 =?iso-8859-1?Q?C0HhM4Qr06yVy+Yva8IN/66XxMDld8wiH8lnQkkuc3BYtY2K9A3h5L+Nb+?=
 =?iso-8859-1?Q?IFFS3YJFYFVV8GBRSvxgjd36bhp6o7ZRN0HnFwOErWy2tqodgaM2Y/m+h7?=
 =?iso-8859-1?Q?wRi/c+53LEWOYR0Fg5ZeGKw+ip9ZrqvQB6pRMMmAtbRQCo/yBQBujv16Za?=
 =?iso-8859-1?Q?ZsiJ3JymUtxhtKMr8/nptWCYkBM8QGxW7vbw3jiV4E2cnaqCtGM6P8nAbc?=
 =?iso-8859-1?Q?Ac4e1VwW5LADYOG6I1mXzr0yXhpNBQe08LaewGjQKqAXYjblV3/t9ozZdI?=
 =?iso-8859-1?Q?KXp3/LIYbpTvs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca4237-f21d-4dde-1f1c-08dc6e52d659
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 05:02:04.1803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9VTRlzTqgYHMSVNGftAXE6Ajkw9K+ZX7oOWB30XD4acruVjNhoorSKhprgvNR14ohNs9QatTeWan7DZd3CExQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Tuesday, May 7, 2024 11:43 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: enable UMD Pstate profile level for reno=
ir
>
> This patch enable UMD Pstates profile
> level for the renoir_set_performance_level interface.
>
>  -profile_min_sclk
>  -profile_min_fclk
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 58 +++++++++++++++----
>  1 file changed, 48 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 8908bbb3ff1f..e56b7afb5b78 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -928,11 +928,55 @@ static int renoir_set_peak_clock_by_device(struct
> smu_context *smu)
>       return ret;
>  }
>
> +static int renior_set_dpm_profile_freq(struct smu_context *smu,
> +                                       enum amd_dpm_forced_level level,
> +                                       enum smu_clk_type clk_type) {
> +       int ret =3D 0;
> +       uint32_t sclk =3D 0, socclk =3D 0, fclk =3D 0;
> +
> +       switch (clk_type) {
> +       case SMU_GFXCLK:
> +       case SMU_SCLK:
> +               sclk =3D RENOIR_UMD_PSTATE_GFXCLK;
> +               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                       renoir_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL,=
 &sclk);
> +               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SC=
LK)
> +                       renoir_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk=
, NULL);
> +               break;
> +       case SMU_SOCCLK:
> +               socclk =3D RENOIR_UMD_PSTATE_SOCCLK;
> +               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                       renoir_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NUL=
L,
> &socclk);
> +               break;
> +       case SMU_FCLK:
We should add case SMU_MCLK here. With this fixed, you can add my FB.

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> +               fclk =3D RENOIR_UMD_PSTATE_FCLK;
> +               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                       renoir_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL,=
 &fclk);
> +               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MC=
LK)
> +                       renoir_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk=
, NULL);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +               break;
> +       }
> +
> +       if (sclk)
> +               ret =3D smu_v12_0_set_soft_freq_limited_range(smu,
> + SMU_SCLK, sclk, sclk);
> +
> +       if (socclk)
> +               ret =3D smu_v12_0_set_soft_freq_limited_range(smu,
> + SMU_SOCCLK, socclk, socclk);
> +
> +       if (fclk)
> +               ret =3D smu_v12_0_set_soft_freq_limited_range(smu,
> + SMU_FCLK, fclk, fclk);
> +
> +       return ret;
> +}
> +
>  static int renoir_set_performance_level(struct smu_context *smu,
>                                       enum amd_dpm_forced_level level)
>  {
>       int ret =3D 0;
> -     uint32_t sclk_mask, mclk_mask, soc_mask;
>
>       switch (level) {
>       case AMD_DPM_FORCED_LEVEL_HIGH:
> @@ -1012,15 +1056,9 @@ static int renoir_set_performance_level(struct
> smu_context *smu,
>               smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
>               smu->gfx_actual_soft_max_freq =3D smu-
> >gfx_default_soft_max_freq;
>
> -             ret =3D renoir_get_profiling_clk_mask(smu, level,
> -                                                 &sclk_mask,
> -                                                 &mclk_mask,
> -                                                 &soc_mask);
> -             if (ret)
> -                     return ret;
> -             renoir_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask);
> -             renoir_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
> -             renoir_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
> +             renior_set_dpm_profile_freq(smu, level, SMU_SCLK);
> +             renior_set_dpm_profile_freq(smu, level, SMU_MCLK);
> +             renior_set_dpm_profile_freq(smu, level, SMU_SOCCLK);
>               break;
>       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
>               smu->gfx_actual_hard_min_freq =3D smu-
> >gfx_default_hard_min_freq;
> --
> 2.25.1

