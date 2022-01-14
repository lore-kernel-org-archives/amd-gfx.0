Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87AAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4204610E9DE;
	Fri, 14 Jan 2022 01:19:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA8E10E9DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNHvYOH8cZMgTgj21Uu4XPfGLkDBzUqTd7i1EIGOzLhw8NQ6b+z7jfjbz3s0vN1c8eqtUq5lkXUgNPA+dXPnrvNVtIo26Y/9A2JLkfjiS5WJIqlPyHWN6SOlBmvUpbxoYSi+wTeW7ZqsmYw+Gg+tXRHLb3eSBt00O9HdEztOf0gBNecKJMa3VD6ZloZX2IlnosoiBmPoX8Oa6ZS1WPzoE84B5V22MXgdBlF2/f0AsMkhi0WHy0rE6OoRmqGndVxk5Z0nGIBPoezDDD32lgvG/E0/5Gm0PsqqUBEgyO5sOkup84IWWrWE9lG3wfNaOKTrgoFPrSKJURotoWxb/2t/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFavnCe2nUC1XieQqKiGgq5fq+GmCu9jd7TJ/swTvN4=;
 b=FTumyHspYTgAPdBHdwk2iq70H5DcYfaDPdx310mFKalI6/N9TdnFUQ2WWEb41IcfG48Qoh0nxYGZXMIkddWmImeJT09Xxds0ikwLGPysS42eF9J5I0pl/DEXQOZoe5Bm0hGXZATmxn6zzXwCQTLeee2NOMphoz+pKqxZzbkFcASMNluQ7HxZcftaA9W4MphtNL9g9F++GfgDjCtShkwaXWTtQxzrxBpHwZY/w2xULAX1H12yD5F4Auh4oa2puwqofLqxpAXoxz3MYrDojrTHEAe1OS0wtrDQ8zdz6UKxOlvMdHNd+J3bf2Z3QndD1/nJpYseUBEVZCYD42mOsut0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFavnCe2nUC1XieQqKiGgq5fq+GmCu9jd7TJ/swTvN4=;
 b=ZEyKHHDr8fdg3atWpXCqBY4Q7HW238ddx2PsWja7pdVtKK75v8LBevEzLrUeIJeHNvWfT3CtPESp3j0RzGpCVvUUSDYU13ENwbn29bpvDzBPjIrr02c/kq7eTS6r2tKX+GFvlzm+bLjuFVIbGJojHCliykESWa13uT60AoKZP5s=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Fri, 14 Jan 2022 01:19:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 01:19:44 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix null ptr access
Thread-Topic: [PATCH] drm/amdgpu: fix null ptr access
Thread-Index: AQHYCEsHQ4XLqT5fyU66AuATlNLJmqxhuHPQ
Date: Fri, 14 Jan 2022 01:19:44 +0000
Message-ID: <DM6PR12MB26194735CDF66346F4C1A40CE4549@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220113065826.129865-1-flora.cui@amd.com>
In-Reply-To: <20220113065826.129865-1-flora.cui@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-14T01:19:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=554891fe-12d4-4034-a81f-52ef737234f6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4634e321-8e77-47e4-2f33-08d9d6fbf2b0
x-ms-traffictypediagnostic: DM6PR12MB3466:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3466D6FBF7B1E8873BEB2845E4549@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGqShg5n7UmF8TkOsy71hGPD9tZEED1fEYzKbPFatQNzgNYaO5IFIXpBzmH/U138erX4G42sVHXIVe7FW3RyNO/khq5c/NHdNvb1dlyJQchv/SYfaiVlbfadIbhIpO8HzdlX5oXQIn7pKIUmHmRXS5WpoZUF1T+UWFNyUoy7jamXoOBxzlIbED26K6hHtBUfqbrzJiXIxnDkJe8fox9I6faYZazyHhy29zBm4+SVpS7tlKXYfh1KVzBGhKZq9ESUDjhcMX2yuANTF8bEDILbZKewdzzj+1rbSZfYXF46n5IpNj2O8ONS/l7ihkJkpap6ciqSDC8dmNSogDP32YC9WCxZetVZT+ii1ZsaEJcf54J80poabW9sSM1RfJahC6ffFHvAdRpWOHPn5k3jWytJ9VX9jWIzyvgopI1pWJdPSGHi7r7IPYDVmLZzJUmIkEEtAOaZnzE2cTSKqwIk5u3DY989BgMfS4dGIQJWfEcM61OLiq0RWTKQPE0cxm2YFUtdV+ym1tKb6e8tF+HFwdDu9GQBOFbgEnWLMlIljYN0+09G4qEt+Yl8g62t7aVhEDrf1oFWyAKZzOtR1FkPAiMYdSIaMKa2jIS9uT9ujM2Am05gAZWGH00doUwEebwv4DN8wt3xmqmbQchPOCsjox9O2iohljF151fOy0SJ/iU/MZCgBcspKO9g5PARsSfUAsP0K2c8hxIu+bTV63h1LSO+vw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(38070700005)(110136005)(8676002)(6506007)(66446008)(33656002)(316002)(7696005)(83380400001)(86362001)(71200400001)(508600001)(26005)(66946007)(64756008)(76116006)(55016003)(5660300002)(186003)(66556008)(122000001)(9686003)(66476007)(38100700002)(2906002)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HcoMFoyyUjfaVamvLTGiQNhRsLvEKPRD3/FI9AvPapXihxKq1aOQql5YdWhq?=
 =?us-ascii?Q?mLdNSCVh5RdDDN/S+Y/pvUQQ0Vg2EDh0tYYwXCBbs+umu2yDjM9PYYX4nN6U?=
 =?us-ascii?Q?BxIChh+UQ3E8lqJ6dSZQHJzzC4mnmbTdAY6HJnW6LYWshrq3utBvolfU79IW?=
 =?us-ascii?Q?jZaGvTloILkdzOiQAIvp8EZK+1rR+/OAfR03Ez0A4pPrg+goWP54YJStxYAJ?=
 =?us-ascii?Q?NQtsbW3KHYCIOAXn+eOhS/i8sduH+atjWbNYNPNFovod1+1Qc7V2ai6lP544?=
 =?us-ascii?Q?9S9mLlQcHbyMTcu+qlQTS2x/RXmQ6T5tB8antYUET5x/XApv//klASxDDdgy?=
 =?us-ascii?Q?dmH0Ed6Ng0IAKBI75WQBf1tFM0pgKAGM/cIu+6MuPF6uwTqq4lFCEjl1KER6?=
 =?us-ascii?Q?gHRdYthRwAIp2pnjVI1U5kimdps5qCGXtIB7G5QPAIi4psmsF1iXOBu/zvZ3?=
 =?us-ascii?Q?+nD4fpldNfV1As9nItUPz9u4W6Z+4HYu1+Ivet2vypV6BQPn4VPTSsnmBCxc?=
 =?us-ascii?Q?1beNxod2kgCj+i7RGenUnYvFyT+V9YxKyjW1poHAhjqce9OiSafclIrzPzTh?=
 =?us-ascii?Q?gwIFkqB8OQH4HdVsRcwgqeMrnKtZodH0p17Rb7npaX2n9iKjxa46rVeck6eI?=
 =?us-ascii?Q?mBsLlz58o5IJYnl5faSt9MA4liNwXPQHKEtZwiUILl4dtRI94Kjm2xbvROgk?=
 =?us-ascii?Q?EBXDGqvESIqzrW14nePl4JQB63ytl9J++gbc5+938qy03m5SiFq873mXvZqS?=
 =?us-ascii?Q?O68K92cM6M4rgCmhbuLdmIsOjLGX3ZA60YFHzL7hP1MwfqQUQ8xoRfrS0qzp?=
 =?us-ascii?Q?PdFBPzpIfFm/tALJ61XCxc255VwB8VPlAeVFrB7N8An59WfJxjs9ZSi94dE+?=
 =?us-ascii?Q?ZsT2v+YhkMhSUMUFdAsLw7cJKbRCXyRVvgxK+kY6FmdcIYkrupUE3g7yKd2/?=
 =?us-ascii?Q?cDFA/WFQGF2RWGekgvTh/7Oh9tf7epv7FTknrZiSbOVTdaOsoyHH4DXOLnor?=
 =?us-ascii?Q?YzWwzq6EDxQOCm0AN66829PapMrHqs3j8Uu+pZaC6OcXjGQEbqkc2376sgtf?=
 =?us-ascii?Q?Y88YyQrs+NR9HhNXqKrmK5SCDZKjXzmt6+FPMG3yLJrIfEloC/E/BH77QI83?=
 =?us-ascii?Q?eRm+dVRpxUp+N2xetV+w/l+FbrlCCkOpyjAvm+sDJZSkhxNcTIj7QlREwmf6?=
 =?us-ascii?Q?Mu2PTmG8enCqYQoRtrnvbzgTvdnLvxT6OYKA0KVn9YGMLeC+g056nFJ54i3F?=
 =?us-ascii?Q?6aONMXR5JvTo4yjWP2zElKoq2RoYX2pQP3dFPt6mCebDcB3JTZm2vJvTz+GK?=
 =?us-ascii?Q?oGQuOB65BcsdlSMmKra02eqQ8YLbSpZrLN3KasmJAU8S5JdixD+GNi48cGeI?=
 =?us-ascii?Q?otYDgeMRzBdZjx4sOFhDQEsk/V80UM3mlwdhVcmbYrLD2H3V3wCtg6TImCnf?=
 =?us-ascii?Q?UjKs5+jyeSCzqllBR+v0ogUFtIhd6fg7pyLNgYC3eVYqSOb07BAeW2AJJ5qj?=
 =?us-ascii?Q?Ah4ehTZDcFnssFfdmUrcnpFP8ASiyjyB34yls8M0f3kyTRuvDT0j4f1IyDzp?=
 =?us-ascii?Q?QHQ0N2Cir4yGnA4t3x8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4634e321-8e77-47e4-2f33-08d9d6fbf2b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 01:19:44.5310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3FvRl8N3wW8Ys//u3ZK73+8wr4O26Td95XktuBdnyLUawLaqIpmBdhAm17L6vcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
> From: Cui, Flora <Flora.Cui@amd.com>
> Sent: Thursday, January 13, 2022 2:58 PM
> To: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>
> Cc: Cui, Flora <Flora.Cui@amd.com>
> Subject: [PATCH] drm/amdgpu: fix null ptr access
>=20
> check null ptr first before access its element
>=20
> Signed-off-by: Flora Cui <flora.cui@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f0daa66f5b3d..5fc33893a68c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -463,7 +463,7 @@ int amdgpu_pm_load_smu_firmware(struct
> amdgpu_device *adev, uint32_t *smu_versio
>  	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	int r =3D 0;
>=20
> -	if (!pp_funcs->load_firmware)
> +	if (!pp_funcs || !pp_funcs->load_firmware)
>  		return 0;
[Quan, Evan] This seems fine to me.
>=20
>  	mutex_lock(&adev->pm.mutex);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 828cb932f6a9..aa640a9c6137 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3281,7 +3281,7 @@ void amdgpu_smu_stb_debug_fs_init(struct
> amdgpu_device *adev)
>=20
>  	struct smu_context *smu =3D adev->powerplay.pp_handle;
>=20
> -	if (!smu->stb_context.stb_buf_size)
> +	if (!smu || !smu->stb_context.stb_buf_size)
>  		return;
[Quan, Evan] For this one, maybe as Lijo suggested, a check for "!adev->pm.=
dpm_enabled" in amdgpu_debugfs_pm_init() is better.

BR
Evan
>=20
>  	debugfs_create_file_size("amdgpu_smu_stb_dump",
> --
> 2.25.1
