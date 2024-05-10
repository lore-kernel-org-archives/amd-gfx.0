Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39E2C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696AF10E5CF;
	Fri, 10 May 2024 07:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UgH+tPZW";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB20210E5CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 07:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euyq1xUZPazZE5ECiVayK/ZV1quHi9FhSh51uRK0wOqUj0ZTVdmQ9aeG4mfWVJNJeo8uf4EPhyMF/V8PfTEEMyn3by0MTxcFbWU/7322ZjdyHVjwHwhN+fQnBC4mpzebP1kR3GJMec5fkfRDua8UfQKZhuo0svCRnHf2Z3hWmeFscxzNG6GrKlWRBmndI6pwDZOa2MWh4J9B4NjQPGcn1BFOK4tihkj+tbZM8RjV6XDLs7SJ4/vzkeYMhl5cL+eI/js0vyYl5ke2hGBsF3DtHDC4bryMbWn26KoJMiNDVwtEeJBvneSk5Spixy3d6iWHwKPLvG5direejsi63Prr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hPLxUbbMYQj3fJKs7J2ltzu8W4I7LhmQhNpSUTcqq0=;
 b=aIR/d6QqGFWT/gCIBYjvRHz6AbVVDWyNY8me18PgrJYp28EoChSDU7o4Xfk4FH9pRNwiBeXipZxgintq784N56kHgIzsi51QuNXn4TRmaRU2GoGiVDc3COeSTRZ4S2d/C0TAJAyq+5DjzF96p93JltZM3yGUg2sG7CxKhnHy5pfUDIJOXm0bXeRGIROC+3WQ6XcE/qgb9yLoEO1QUX3x/amdWIk2QkokFAhgQ76wIt5y4lizFpXBE/wkIRwbJu156nO5oI3jX65JmOC4XcjilAIa2tW+Tl36InpM9pzddlcaQR0k/DRkM0RMG7a31T7gr2lozE6nQqQTAymo8gfEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hPLxUbbMYQj3fJKs7J2ltzu8W4I7LhmQhNpSUTcqq0=;
 b=UgH+tPZWNhmJ95rSSv+Ryt13BvOyCUUAjl58UAYcZiXNla73VY1+MuUyMEY4Maw/tL05dPd8SwnvLKyYx3N6n5UmT6uORlXPKdYS7cUTyMbdy9n1ubOzTCKlTKYEqVJhyBkfBhzmzhcUW0ISZZ/sGddxphZQm3nABqb4TzwJJN8=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 07:42:45 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:42:45 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 08/22] drm/amd/pm: check the return of send smc msg for
 smu_v13
Thread-Topic: [PATCH 08/22] drm/amd/pm: check the return of send smc msg for
 smu_v13
Thread-Index: AQHaooUzrIojySnzFEyuKZfzpm5YxrGQCkMQ
Date: Fri, 10 May 2024 07:42:45 +0000
Message-ID: <CH3PR12MB8074642900CFB6F98A371A4BF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-8-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-8-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7e04045c-3fe5-48e4-8650-efabd792ebe7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T06:59:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA0PR12MB8349:EE_
x-ms-office365-filtering-correlation-id: dbb19561-1799-4052-a6f2-08dc70c4c81b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nY0RboiaCoY869Vys+/AC3+NziQWTNVouawZSYtHn5hJYlytRJYZpFEMjC?=
 =?iso-8859-1?Q?IVgydqAGsMaVVut1wuZS2ZuUakpWlM2gojM/rMMDUcqh57rYKFg1sBJjUt?=
 =?iso-8859-1?Q?WpXDr3i43X5BE/V3mklgVYOCXVUAcjTV4Jl5e7hViw7ctXzCVEH9335Txc?=
 =?iso-8859-1?Q?ThxBUtWJyv3ZoA4F4eKg5DeQhJishQzzjvGQE7baosebd65VuxqTKFpzrd?=
 =?iso-8859-1?Q?bXr/lQJm+ebBc6ebkKFqm24ClkkCRsV/LXbyvGc3I6+4Ua4sX4lXNnkMiM?=
 =?iso-8859-1?Q?1jVuj30CC7Mi/J9s45ozwYo3DeLVHSHCQbPUBFGLBQ9xf6DPV7s5dS/LHv?=
 =?iso-8859-1?Q?+ItEdeGtUIpRcEwvklBSMew9+0F3B7jbxrs3AIf28hK/30fxbyousJn8sl?=
 =?iso-8859-1?Q?RzOkUaa+RO/E2mqHvigHZxJH6pof2G3kcbUPRGa/tKLWnnzkn8vn4ikJhW?=
 =?iso-8859-1?Q?aYiGeQi6tBBQD+JCIyHPJ+x4Pdc4pO2mWDmx68wkaaMDJihiR3zZc59PGo?=
 =?iso-8859-1?Q?nZYS4PkDNm9VwA3WdR2ztWumY9+mmqXYQYI8oxo4VxQqN14HlndCebaCaP?=
 =?iso-8859-1?Q?KGd/AkZkvsvkAAt23B/ct337OZ0yMWS5F/suDTyReD1/iLA++SY/N2Oz4i?=
 =?iso-8859-1?Q?QVq+j3sDUBFWdheCboHpHP8+TCPdgvHKaEID2Mkwbobe5gJZLKBTOf/aOP?=
 =?iso-8859-1?Q?7J1oOfKAx+CQ6f0Yq34NJczE+tx76v3XIVs/+mOftP0T86d6et+zDii/hL?=
 =?iso-8859-1?Q?P77+Av0fSU3jHX0AY4zrFz6iV/n2JJXRnUr7oJSxhvNbRJIJrVlYG12knb?=
 =?iso-8859-1?Q?8342Ip/adCuMgW82GlgUzcZZr622BDRw2+Lf9CK4r3Ev0dvILWejlHDYre?=
 =?iso-8859-1?Q?EzecPZPRzyu+d9h+5RMCX6MBRyZKY2nUDm0CjR9CUxnxuEw0EEWpvJIuyy?=
 =?iso-8859-1?Q?EcXAjt19mRuaQVySyl28arNYh5Uinc8hl5fv3PMrcW1bOqwN99D75I6OgE?=
 =?iso-8859-1?Q?aeeQTGFHPdnZBCYOdMfiPx0jM9XFfIuRZSYxdq0VPz6HNSA8+Jof/BNenG?=
 =?iso-8859-1?Q?rT0k8eAooEwpvPb59Ya3Ou4UKEgGzhWhs+snLjBFYazXWkMCZdEOMfPyCB?=
 =?iso-8859-1?Q?iyjnmsuQ5LBkFOf15d5mFt0/MwaGpEWjO4/JDV7dWU20mKBniLLiwfyrSj?=
 =?iso-8859-1?Q?Zm+louaOXaFCIZ/dchOk5QWdyBKE0jj3MMuH7WOQTnKNXr+6/N8AymiHWy?=
 =?iso-8859-1?Q?4VS2Rnu1Ls4oKlx4XWO+KhoN6q21Jbq9wmjZ/YXiSEahwkke3qITJ7DeZH?=
 =?iso-8859-1?Q?E+kjS4rr78rT+giA16IOxIn3OXs8gknGi7AMBFgmQ1Ah5Fex7lFnMXgcJm?=
 =?iso-8859-1?Q?vaTzTNynqIRumlMjahozUEL4kyOi1YVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SWpw+V6cX0gz4H5TQFrM2bdN+9b5QLShMMYq4TkIFTtEK7nJy185Hvmuof?=
 =?iso-8859-1?Q?77UbPxIW4PE13YhXQrzKDbZ+WdPhDCOjtnnOeoM/ewPVeVf1MYw+ffTSk8?=
 =?iso-8859-1?Q?nO8fGnwzunI0QkXD9FbthGZlUOv05ojenWACpSoAamVtboekqPLbNuCARY?=
 =?iso-8859-1?Q?GFqiZrbgaNBXk+PIXpuvC00FZRYo/nPBOUj5zoOs2fzeq5+5xmAViA2g1H?=
 =?iso-8859-1?Q?Dbg7xezmJLUtSW5Z37MTqwwNbwn9nKfpMneIk1j8udYHlVScIe4U0/H7QW?=
 =?iso-8859-1?Q?jUIvzvB5VGy1Mu7x6mmEkRPxSJGJ0KU1xQDhjg1i4Hw1/DHo38rsYtfYnP?=
 =?iso-8859-1?Q?KBgER/sfYKJQadM+RKt6ALq9mJcYdvNAGshB5V0rLLrhoIPJG3EQVhiMvO?=
 =?iso-8859-1?Q?W3OAj6S51JsoGvIkV4+knOOOZA7vHX79AEqZ/rzm+T7km4NLlg6RQabZz9?=
 =?iso-8859-1?Q?3u45xYttXI9vhCcxJ2tcIz1JpJREfOjXHFxSrIMIhhlJe1TQZn6SKlH5wy?=
 =?iso-8859-1?Q?lqMzz/6PFBW71krscAnnfcXYYAh/gJcCVJCSXUhs2ZL0MkSOFToxnUzkyO?=
 =?iso-8859-1?Q?+Vt3UCPajsUMORotZemJraPKetO9pkKqh5jRR9ssI9MHS/r5QxPtmgpDqR?=
 =?iso-8859-1?Q?xKeSOB6VMHdFBYRDsiRgzPTlIRW2lTmdHJYTxJSNQfjZYSGJPxllIRH3wm?=
 =?iso-8859-1?Q?LaXSWEngR3jrheHnKmV0ailx8zg9PSUXP+GLPddt3lf0C5OFfyycQGG4Kx?=
 =?iso-8859-1?Q?BPYUVRG2ZHZj/AbVww8ESaaz+4XUAk1Oh3fVgsKC8s4NtbayFY2M+7wvlY?=
 =?iso-8859-1?Q?yh5oga4/p/NzFfAvd1gCDil6T6zMItcrD6X1Zrk5iDjwDumIZhA3fdbLJP?=
 =?iso-8859-1?Q?iy1yIsXeEoX2twGvjIxbCu7HNm6K2cr6jGixhULJCdPg42agl8SaYI8IaP?=
 =?iso-8859-1?Q?w6kwkiYIi7z3hU6c8FmoHKZPqNT8dy8TcaFrCOxwmehSC0IvPEE5ptpiVU?=
 =?iso-8859-1?Q?ItXMD+MxJ4fE3EEaAcsTeOVi2Yi9+LZ3lG5geOe9JPu1Q+B1olaYUbPKHV?=
 =?iso-8859-1?Q?ivtcHsdaUfTWV+bkFkC7KdJPnFu7UHNH/zzrDRwqP7PXQKKLUJn8xhpn5H?=
 =?iso-8859-1?Q?W3FIPClCvvHKtzCxkIUJTLrpgbCboCl6SDGk7pjJDKl63+tSuKGmCMibXh?=
 =?iso-8859-1?Q?Cs3ST+aOHt5nZlJcM+tZOjyEitsHhy+MoeDDbZjhT5fsIe8ahiu5NV80vg?=
 =?iso-8859-1?Q?OSNNkqOt28+X84DWWPCuIAECd5Rb6lULC7JGp3ezFARFZQ2nWMCjxUGUxk?=
 =?iso-8859-1?Q?L3J3bfjLPYybl2ID0qARBIz1ZkZV8kD5x6mn2gp9wjD2mEOswDilKrGHo3?=
 =?iso-8859-1?Q?HsVTSoPQrOuhH69amXbPBcm6nz1YzRVIzjTi82MKkWk64V8+NQnlSpmxEJ?=
 =?iso-8859-1?Q?DAbc6XpjmvGU90uAFOGKFAl0XMocJ+NedY/QSKfMtVQMJ4JMYbKWRWAS3d?=
 =?iso-8859-1?Q?L2xUPijW68UKbG6a1MJmve+C3oZujuP5VEgcK69kGVRMQoFDQiaA4r99l+?=
 =?iso-8859-1?Q?nydL2xm4vVVeuSrufjZQlJbdF5QrAzl61fKAPaE3HZhIF+yuCF8yN6nRv6?=
 =?iso-8859-1?Q?b9BAIrzdptv/OwDVdKdaRBj1XmMuiTfVUO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb19561-1799-4052-a6f2-08dc70c4c81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 07:42:45.2549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/y0mwIGATH15EqiuKxu1sBOknxPo8sEYF6x1zt2uIIJ0E0AMKEEW1WJpqZOl7CzcoCw4/W/8BrXWkYWxOSPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 08/22] drm/amd/pm: check the return of send smc msg for
> smu_v13
>
> Set smu work laod mask may fail, so check return.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index e996a0a4d33e..dcb68ab51fa0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2495,8 +2495,10 @@ static int
> smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>                                                      smu->power_profile_m=
ode);
>       if (workload_type < 0)
>               return -EINVAL;
> -     smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
> +     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
>                                   1 << workload_type, NULL);
> +     if (ret)
> +             dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
",
> __func__);
>
>       return ret;
>  }
> --
> 2.25.1

