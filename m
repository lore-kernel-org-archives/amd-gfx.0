Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209BCD2D8E6
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 10:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23C610E503;
	Tue, 27 Jan 2026 10:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J0qH6q67";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF6110E503
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 10:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2bKkngc1oo8F50b2k5jU9rG4bg1dQkOf3BceFtd7FF2waTJHYnJyWWl6ViW3PM9UE/g/Kp5DsgKFsH/bz9IjS6GvOQMI5cJvWcqGxwKom+LI53plUv2VaYSy4fRpZ7RsLOWcJeWbzrQ8PRugoeKhQlv5l07i6dOZag19KslF3n5ulN9KdaTjo9dj+Tkf2mefGBHBkajPgf3efK/nelMjMTWfoPIIW9IoZZe4wdqfz11TPKAPXA1MHMKbKyv3kn9I/oZIukQt7RDcSCx69h3I6Suz1Zjok4s39Sghtpvc0Hvdd3hGxOeQzafMl3hFm9rhZ+WFZzAiJt40aRIwrWKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8ClBZIsdTSI42a41J5M5xkVaqSK7WstsYYJFliITNc=;
 b=No4WShdctyAfzXYqyiKnWpO6tWn/sfdJCQnzfixByZ6J6fj0vQdgJwShrPXVkCPfCTTTanGEt4qEjxifUvmVdnl3EKyE8B9F5Z50CmLko7gAb2JgnrzEQTltQV0J5gSBaaAmXz8UrgOh9m0aCFsyiU2P4ssQEL93Gfrl0csqKKuOdx/eKqezxT9ypXuF4AyVD5lsymlZeoDPfC5epuYvY/U0SUgadRyM0WjY8xazyi9Gya8hMW7rfqueo6272mGNsfzZBYCdJJvZS5SxpREjzxMr8s1fLJ4VAQ1kZZUEAdbbz0nxMoSqVXu5l17YQM6Dyhw+4NVQQncpp3m3aEAsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8ClBZIsdTSI42a41J5M5xkVaqSK7WstsYYJFliITNc=;
 b=J0qH6q67UhMIo28AkqRI3bIV0oGX9bxJ+KzD/j6Vbrmy6hkSJMTSFxtRjFdewwn8M5jCA2oP9etu86IDCwQGGgOt8I8qc2adrLfwMzV8RDKQcoei6FCGdI8oQxDLAc0/QMQcD9DyyMfbzluODcoPA2SIZjVGr6cBnKBcQzjN3AM=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 10:27:31 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 10:27:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: statistic xgmi training error count
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: statistic xgmi training error
 count
Thread-Index: AQHcjFtbNgCXkyB92E+DcnCfS8OArbVl1leQ
Date: Tue, 27 Jan 2026 10:27:31 +0000
Message-ID: <PH7PR12MB87964B6986E135D093ADA230B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260123112742.3855999-1-Stanley.Yang@amd.com>
In-Reply-To: <20260123112742.3855999-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T10:27:24.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH3PR12MB8330:EE_
x-ms-office365-filtering-correlation-id: 6c589105-f8de-4898-ac1f-08de5d8eadcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FdQeIiMbEF4L2sPrayvabY3AEdejy+dOaU1lm63SQ6NqKH7D3uFz+vcZF5yY?=
 =?us-ascii?Q?0eRCCoAPlYufK/RgsWJOcC0eNf8i7jWzOS+Z5nLw1XU04VqyKkBn44tqbFsa?=
 =?us-ascii?Q?J+IR7CDU5KJbnV1tkDjARR8p6qiCpo5DEn7XKn0ojg1qAbAqeZgM7v73dq1r?=
 =?us-ascii?Q?WhWuGG35Ed5OpRzGpCn7oymc1zc2WIz9oX816l093wh7wPMDL+gmt5UUVlfT?=
 =?us-ascii?Q?UwFzVPRPklMXCDDKjKTp4HGEPU+hkYMYzBiterLKaMyE+VWdF8HqRmYjvBIm?=
 =?us-ascii?Q?yq3TPNmReSN3XqcwxzPZue+LNLvGa6MwhLbtK99pfC/yRUQ9i3MEo5dBICMz?=
 =?us-ascii?Q?LGkPeUKI/T3S3QypPIp6icvrayJbdc9yP1nr6jC+Jx2xwaKuBXkdu8v2Miga?=
 =?us-ascii?Q?BF9oW8wJm3CEMGWm7WvGdanoDuwKSEV7OWSAdjxnyakCsdaK0QmADHlLVHJr?=
 =?us-ascii?Q?QWNgmaZ4Rs6BNot1ZXwqHlUZijWYbZzOmbyAPhhoGxKqYPD1Wb5vFpBtktIt?=
 =?us-ascii?Q?dZB1Ft+nQj6KDpKo7E9yJopa25GJdiveboInfObFl81HXiJAm5RBh/g8rcSL?=
 =?us-ascii?Q?vKBuixJJHHl4GfGA8hQk9ejSGm2FF5K0wXc6xPuNLTBmknNILDdrAqrCneCn?=
 =?us-ascii?Q?M7l3hzLahNypdMo9wOLHdtU6mwKR7etXnZxBzi8sbqLB8hmsmDpU0QnyBGYh?=
 =?us-ascii?Q?ggTGO4CJq6nroZsWGmkl/DVAfdvSDuxsssqiC0227/0RIVESSX/bj0Br59TN?=
 =?us-ascii?Q?ipj7L4y72i3UmSejAoj/iEoPdMDd5bGuMvKgn/V0FXu99GphvT/UjZc+3I/K?=
 =?us-ascii?Q?voggVqYjQsXGdCLgw/qNdoJGtN7L/x+DiemapUFV+zF5MDxsygQDeECAIQFx?=
 =?us-ascii?Q?qtUgkLPti+U6iFgkajyb4VYtc3SzgjaxGo1zn4OBxke/kK6L73zsRwl80N01?=
 =?us-ascii?Q?4TmqKCBiR2u6iJ+5K/MYFRSaD8dJVNmMlrEA4yEo8gBNUELWygd2CGJTTJfP?=
 =?us-ascii?Q?PwnhoTT79smn+O7fCi6kdiJDaggdRhz/mtOt9u5LRqnsEd5JJ2WfF+49OG/2?=
 =?us-ascii?Q?1s7ZaR1Klbj60vauHrc+q18F4PE9kqvSTyqvY78mTuYy/Gg0pAF05Y2b1khx?=
 =?us-ascii?Q?MKa8DM4z+W1TDFuq6Uk8gTgZ18cXuUpz36gQe06Qqm/4LqG4rByzjxtpNMSW?=
 =?us-ascii?Q?BdP1XWUxeulqnckYA4q+M5JVQSfpcNoH5KtWjDTO/mRBu8naFzyrDDDWHzDR?=
 =?us-ascii?Q?1cw8fESnBXAIa1ibFCCeV91Hqonq8jojrp+91R6ZZgXLecFLKn2fsjkTcCXG?=
 =?us-ascii?Q?wUgWzX6/EPjTITMxyLXGHAleJsn4PBlOEm76s1P1glGJECE58VVlFhllPO5X?=
 =?us-ascii?Q?am6u56012kr8kAmOie2D8CNz9EQJCe18eedqkm8nSCePahe8uXGLud929mZ9?=
 =?us-ascii?Q?yFZIBkF0nBkHLbHwN/RTurXxucwhg/3w33beI36ZXsDYFzlzJpQWugNYIwXz?=
 =?us-ascii?Q?Jk8GqEG6rregYSc5MgxU5oMMD4IbmPGDHiDshq6xyUMTVPmm+X3Gbk8gm4pB?=
 =?us-ascii?Q?SmQVuP5XHqMThuzsYTvRPQsWtUDxf+c1Fanp4j9//H+l+Ovi2AMD4o6dURf1?=
 =?us-ascii?Q?QJTo4OR1A9dvgYdfh7QHfbo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JlXUnqjQmSWTzLPS+dKaxxg/ivnwnysxlpqPvriWMVw0RTQ9UW4CHiJ6916u?=
 =?us-ascii?Q?NoJl26O9MDrYtVbYzbWQuENauafClQVOb5+12HLcsMa7OIAFxshobq3RjrsR?=
 =?us-ascii?Q?8cAatglYISzEBiw35JQ28rQYBAGz3XM2s8MbTmR5LTvr51Zi+DU13f+wXOOW?=
 =?us-ascii?Q?HbMupTHxl7mpq+Gdj4/Cye2007UyYnq8OuRutckPgARE4oJvAdfZxVR/ny3P?=
 =?us-ascii?Q?xi0LN8QpUgy+DodKGQys3IsfEjzGHSh77L0O8QM4lBUJnmigb4zO1PA1ZRFP?=
 =?us-ascii?Q?XQAV9iivXY0WIFBzWa9ycbjm3xfs3Dyw+KJVDMT/JEytW7H0Gw0ektPk6aVP?=
 =?us-ascii?Q?Xg1a1B8yPb9cLF2yivZCykoDJc7/EVJKcjuomsJJZBz3AlhPF+gJqsLuEuce?=
 =?us-ascii?Q?IiBLxm2IQpKv7/LJXaV35dD/J1JMzq1ekLuITy0GDM0SI86IbAJT8icrQLp0?=
 =?us-ascii?Q?dE4py+AJmCPM3LswgF1EGQRLZUB0qeMnDqjpxmazcLyAF2xA7T7nh2RSNTnE?=
 =?us-ascii?Q?qeoRYsl8/dhvOdBJ7fSiktVsUxUHSAFRehKsP9RyRi9oVbX8EzKKjHmSWQ/3?=
 =?us-ascii?Q?drZaNZiSTGUYEa6hfFbUuv+nniDWEH32DpYor+ETSwPFjH9vgy5L5m8v48qC?=
 =?us-ascii?Q?pkM4OLlAeLgLgrjbbxPWQKgMlHSlM1tSHylPyQuj6oMAAF6tmb9KlcJwqpax?=
 =?us-ascii?Q?9tvJxZQs2SyPK5u9Ur2cH6m7HRtI6vpj5fI9oJRzfLhpQkEs1lMGjQBD53hZ?=
 =?us-ascii?Q?s7IRJdHj7xj7S6kpEYTjMmABv79ThbQo8U0XWfs+RsnEMcVFtsTQXA4OZOnu?=
 =?us-ascii?Q?tMGDE4LwoZKfK9D/+is+0446Evfq/aIzdFlQSEcPi/BMkaBEEh0XwUu9LRW2?=
 =?us-ascii?Q?Dh6hWBIy75Sm5g2zoar8qphEokpthRQIRurq4x4Jm1PNv8cxq8RlGCeWyMi1?=
 =?us-ascii?Q?jCBHK7M6sCnmyMafNqtCbqoov/tXoR6uPb2RcRu/XK4Hk4vq9jJQTkiAyxq0?=
 =?us-ascii?Q?FP9pWBXvJ9rCVa1evVAZXJyxQT6BBDymrjFnqXlreHkImJkzC/gnX7UvdelY?=
 =?us-ascii?Q?PUFSXENNw71R1VWWC1J/+EAfgOGekGZ0GGMgyMinilOfUfo/GkB05nBcVuLC?=
 =?us-ascii?Q?xBy4w36lB/38dK+KeKTQvylbUB1bx5cDhAzC6s/Voh3AdoMIvflgu++mQOCK?=
 =?us-ascii?Q?Z1zxEA+FO62AUMpWWBaWxFlYDvndQGukQ2Q3Z3n4HbqopKS5JxRX5syw6stC?=
 =?us-ascii?Q?j+qYMjB56vvMGXxfR0iCbT3c3jI7iF8Vey9Ugnx6a+e2KYUNjTAPK9QsOG+m?=
 =?us-ascii?Q?bHAaUIzKAGt24UDtJjqSSPNpJ0lfEsEP/EZofIPZ65IKa5C5pWdfKYAjY3Pb?=
 =?us-ascii?Q?aPfOopbtahY71kSNGMSSmulVzUTVwvWcnihwaN75tXioSu0v2+hcxKiy3J6w?=
 =?us-ascii?Q?YAK7We+g3DdzPs90XszdzheYNo0CYWR9+D12wDMzWIjb2LAL3BnD7gNelx3w?=
 =?us-ascii?Q?8zFDEqcngqPLD+wmiUzPvTMP9cdlWQ9jMAVhrpnTGCEeHJ2BBI8c9yqPyh2Z?=
 =?us-ascii?Q?8eq/rAngXQ/dgP0bipslbtzMNAVDCknKP/RCtlbnGNJu/cY25oLwkWFvkBPM?=
 =?us-ascii?Q?Zn/Jb82V2t24iOacx6zynxFeaVJ5NKC82xvpxr4LNZuXY4OS+A5v+oznYxQK?=
 =?us-ascii?Q?GYBQ5XZ5s1pFSeifQrTksX1lvS0MojYnDR6zJCC0fqxbB1Jl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c589105-f8de-4898-ac1f-08de5d8eadcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 10:27:31.5647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zLmmluhDwgfINpxZ66ZeKeyEDRGgNso3xHLw9hI633vThsv/7wzt3N9/e74DXn6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Friday, January 23, 2026 7:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: statistic xgmi training error cou=
nt
>
> Report xgmi training error uncorrectable error count.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 95f3611d743b..a220fa6dcd6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1199,7 +1199,7 @@ static int xgmi_v6_4_0_aca_bank_parser(struct
> aca_handle *handle, struct aca_ban
>
>       switch (type) {
>       case ACA_SMU_TYPE_UE:
> -             if (ext_error_code !=3D 0 && ext_error_code !=3D 9)
> +             if (ext_error_code !=3D 0 && ext_error_code !=3D 1 && ext_e=
rror_code !=3D
> 9)
>                       count =3D 0ULL;
>
>               bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
> --
> 2.25.1

