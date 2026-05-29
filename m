Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B44FCD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 08:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9A210FAAE;
	Fri, 29 May 2026 08:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zIzrHgLP";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DD710FAAE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 08:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j91Q+cT659B69WQ+dn5vA/j8hjRkjBlsF1UIMl5/fGfLGZxW13NNurz9DH/R7gmAltedNdlZk59Fp4SljndzMcLlUwTh+8TPh6M57BRdzvaqUsaCDnxd562Qug2HRHnEsRUKVrjFSBOEesTLgUdR5e4K9qhEpbmd0RcGKlSr+QG3g/bOEk/ueb78dvi+KIC80jJumyftYi5CYpDl5+021YPSl2Wxr+ZgsOZ6fy5JM/jCUjL88cfw875bpr7Ve8n2BD0WBYOXyuz7bXDlCSSo3WTueuOJ17pl0wsruSZy4Ma+X5E2rYKQ+Q6g2ajotsO+nLIiYCc730Xevp2yIYXT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBfcb3aThGRxo3iQ1TmxXohFwkDCvdyny2RxOKs32QM=;
 b=oT+9hsBlPqHVpMI0n6YUHXN63jVbcg2acqp2nOn+lYF5oHpZ7HOyUE0LjGdXzrhhkQI0fYS9OWZFc/c8+bgvr2xM/L09sTPs1XBYhUmA5ImJzfGBqzIv9jJtLUKN/p58zBfIsJLrzcP/CTzLYAb1n+faq7SPo3vlJq6Y/42csgiuUP0KRxk8P7QrtDl8ceodTg1wW+wlAiLcDReWNc/VUXVE09RHj+s1MwqzzN6Ol41RxdRkjp+pv90FFp1uG9RIxh5yLlC0WHHaWwgYuSnAIyTPB81Zn2j8rkvvHnV+ndT5PGdwS91xdl45Rv1bklU0r5UvfRQAXRU8QRXJNYMQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBfcb3aThGRxo3iQ1TmxXohFwkDCvdyny2RxOKs32QM=;
 b=zIzrHgLPqAxQDKhJ9RRSfIRpS6NTXtfjCBRXeWnbj5T+laSg6htW2h5WTlXaYASsofJHNGR3A27QnvKZHxaGITW5Xk7KpaVjXishQcF6MU2UC9HiQVQi6ySckfT216PekqySLmY47XGY040+BIBZVvoTKxLXkokT/hFrGcN7PCc=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Fri, 29 May 2026 08:14:42 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 08:14:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Thread-Topic: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Thread-Index: AQHc7zL3OcbT5I3dHEufP0x0EAzU3rYkkIDAgAAVagCAAAG/0A==
Date: Fri, 29 May 2026 08:14:42 +0000
Message-ID: <DM6PR12MB29727754D5F5ABC0E607A1B982162@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260529061811.357041-1-asad.kamal@amd.com>
 <DM6PR12MB2972B5C6F3EACBEF419362FE82162@DM6PR12MB2972.namprd12.prod.outlook.com>
 <DM4PR12MB503870918384A4AB75B98CE28E162@DM4PR12MB5038.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB503870918384A4AB75B98CE28E162@DM4PR12MB5038.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T06:50:34.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|DS7PR12MB6262:EE_
x-ms-office365-filtering-correlation-id: fdc05b0a-2359-4a2c-f822-08debd5a5624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: X4qlWV0qDjhRpBRrSOmVNSvmtA5LuideogPWDCOsSG6kjhskY+PvIbU7URtjEq3qXf0bPn/bxfjZnngP3+Q8oUj+BwM7pVII2LP3z0UPSFqzBluyqgG4/tJIW7iJPUJpSNQOMNvq1DwXfHtMyircsh2AB/gJZwwL/oCLvBgwwwaaznyGMkg0TJcnqUVUH3jp0i5HahC1BH0VdQcb06NFr6wpf01P+ol+dkIFM3xM6Kn9fbO2aJ13RJdofQd9q+EyCp2sNtQy0IlK4XOFOM8jHDK+zNzycHvxN06kqwL/8i460Oum5PP7MPLFs3Ys3WHmv/c2spzoBsazbKa6g1Ddck+7gzfhu1XxXUFMU4/e+zjgVBYziAiRt3L8aQqQpK6ra6LpfUQtawC50f+LyTc9s3qxgVxNUwrBOuQK5SVG2Cp+i9+6dq7wHnUwxek7tZumQdP2jnv7xNKGi7lE9E3Kq8dSIAuS+fC89ZcXpPZvkJ28PSPf1JFY8jEXvvE61SleV/DMZ/yZ83tyKzuwGAtaMJ7Hyb6ZUSPuj+WLYSx5Wf1V6Z4PrO+5+YvQ4tDfCktf/KFxFP0l9buX3DxELI76w7xx57TsJkoXAd4ffTgrWHqkS1OLLL1ia04DuGuENg5W/o+YewwpXRwddMSb0Q9Q41Dw3Fow9pK8e4/PjmohKNnBlTsSvV0wVXxE3s+FORDFIIdjhhvjQ1e8kZVIVCCwV/QnujhR7M17vvCw3Dofy3EvPRFw9k+2CpIXU5BJVtCs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RIdbAknz/YaO4xsgss6VOJDJh4ODf9dboGEp3nAr9Sj6wMC9OJ1x1Glz7ij8?=
 =?us-ascii?Q?giR2/kdEVtDa43oWvxZhC0ozPfiJYHuJxMF47rb90Rv0PQC0u4KLzCD7QyJp?=
 =?us-ascii?Q?wBgAuPGeXA/UiUN/KQkHzF22omRHsiLX/0s4iARGhtTYbNWIXA75AfZRgY0G?=
 =?us-ascii?Q?bAueL8udJyd3xPdLWo21GYj8G/NlRy4Ob7cFiXZEPJbUjw/UQw6cSDxUIRGT?=
 =?us-ascii?Q?PP/pK2/cRKLTR4SO0VA5B9cCkIZBDWVF4Dx2eWc3uNu3pgBvKaz1dca1dKkY?=
 =?us-ascii?Q?uJb6mADZiOoRSUOnXqzBqPpzKOogz/nzm0mVAmGBPltyWi7R44+YqBOWM+67?=
 =?us-ascii?Q?2sX1LTH9yEnyD2yPOXeLmcOHzv56OX2r5eNTkf1a9gvKDBRYR1+Q+JERd6Av?=
 =?us-ascii?Q?wGnKrWGpBd40XgiZGJ8piGQbe5KaT+X1DvYEX77UYDJFJkeXwLYzoCqK/hWc?=
 =?us-ascii?Q?wuk1eEnm1z/evsJTa6yntmPyDLVPWAsHQ/OzzJdLDxCKsGvX2U8l5QstK/9/?=
 =?us-ascii?Q?MhZYZ+pvojXXbIbnykM+bP6S0OVNsqKdGdgo+7j2LUaC3e1sflBuFoA3mVzB?=
 =?us-ascii?Q?v4d+Q8KPPzNjjYNxLEsjlAwRyjPPE7r5fUq0ijCCcqdN4ahOw+KjvMXQJDC0?=
 =?us-ascii?Q?piVmcER+2wNAnat1Sf30mAMMxDv8BFaoX+gvKl7/C/7Ma3k0i8kYTL5W3psI?=
 =?us-ascii?Q?gdy2fQgc59w6rN6ybcCKdyyV5xV1FPTba4w+gPC0RKF6YQpr5x04lnOL7GTc?=
 =?us-ascii?Q?SHlysQNrAHNFl8FYnFzre7pp8OBlvxmp2x/VoRc752zMFUtu3mDIFsuSbkxf?=
 =?us-ascii?Q?X27OPJXSBjfpJYrULcuKSICs7GMZZG0/nQ3HnS5z23K9CD5Ht35agKH1KSJQ?=
 =?us-ascii?Q?kLMh717Z2wTa3SlEptTls40/i2yxiAKyOXuZBmAfpJddbRl7q5LVS2Urj/01?=
 =?us-ascii?Q?iuHz4kk42favWiOipxNm3Zeq7nSHZebBDuADwqJoa2V8b+cJFEhPdYG7J09y?=
 =?us-ascii?Q?oIAIJuAo11E/D8B0oAUv/JQzp21tF4IE3CmDmWljI4rDHaypWckrgyXqwuAx?=
 =?us-ascii?Q?RScc25VCrbv6kkPey1QF/TlLsIncQodQydTRdCfuQYxBixNnwoJ9UrPi7MV/?=
 =?us-ascii?Q?sYSkINQYDJ5pIwEzgJ4mpjCXEj8d2XFT3StV3I2kPhu5G+6UpdgV2k3egKKZ?=
 =?us-ascii?Q?YFQqPLVxUo4SzItLEg0o7kE1Oqm0rfaSeIrJxDB3PhoKt0L8sVU2qtnDFhfV?=
 =?us-ascii?Q?IKjsOIHeNsI80KaD9S13swWtDmbupk9sUwlU33SYsUYVpKjk+XA9mw/8hOFP?=
 =?us-ascii?Q?tkJBAaE1utWZzMVCzEMnxkgB2lJXHUFCN41sj4jd9KPZusOowd21l0OOrlUi?=
 =?us-ascii?Q?8wbDLW8nfabZoCOvzZoQkI/GZubTS70s6pWHsfdKhv42YeJvs4FlZhPmHYke?=
 =?us-ascii?Q?jbCQeSOmH9oJ5IWYxsNPCql9yI8+bqn8bunkbIrhCVpAX7tPaBTGRvHRBTTA?=
 =?us-ascii?Q?Dm5ClV9hU/B/DsXCjFj2w2UZ13T7DfWXojizS2L8+R7JDb625YpHyJyUqrG9?=
 =?us-ascii?Q?UKiN6H+2TSCyFylDOnPfneMjMU9zm9+d9CNSCDhnwnUWf7evEvJVvql/XZcL?=
 =?us-ascii?Q?WLNg88FHeJbpDt1jC2RjH/gDNxJFWPNmqLwOHrlSVXODsJHmCAk2/NFX3DCP?=
 =?us-ascii?Q?zmMVWUm7iznJ47GINx7wsiNnG6w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc05b0a-2359-4a2c-f822-08debd5a5624
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 08:14:42.2598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeAlYIgVpSyx+h98oPG6/9G/fDlM5564cxoGdLzdzlOGTuVKf/hlqR6eFTKfRv8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
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

AMD General

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 16:07
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
>
> AMD General
>
> Good catch. count and i are unsigned, so the concern is underflow of coun=
t - 1 - I, if i
> + 1 > count, not signed overflow. On the sysfs path, kernfs NUL-terminate=
s at
> buf[count] and count >=3D 2, so the whitespace loop should keep i <=3D co=
unt - 1, but
> that isn't explicit today. I'll add if (i + 1 > count) return -EINVAL bef=
ore computing len
> and keep buf_cpy[len] =3D '\0' for strsep().
>
> Is it Ok?

Looks good, go ahead please.

Best Regards,
Kevin
>
> Thanks & Regards
> Asad
>
>
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, May 29, 2026 12:26 PM
> To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
>
> AMD General
>
> > -----Original Message-----
> > From: Kamal, Asad <Asad.Kamal@amd.com>
> > Sent: Friday, May 29, 2026 14:18
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> > <Shiwu.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>;
> > Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> > <Asad.Kamal@amd.com>
> > Subject: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
> >
> > After consuming the leading profile digit in tmp[0] and skipping i
> > bytes of whitespace via *++buf, buf points at original + 1 + i. The
> > number of bytes still inside the sysfs buffer is count - (1 + i), not
> > count - i; using the latter copied one byte past the store buffer.
> >
> > NUL-terminate buf_cpy before strsep() so parsing cannot run past the
> > copied payload.
> >
> > Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > index 60db9b66d08c..450ecb188aed 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -1379,6 +1379,7 @@ static ssize_t
> > amdgpu_set_pp_power_profile_mode(struct device *dev,
> >       char tmp[2];
> >       long int profile_mode =3D 0;
> >       const char delimiter[3] =3D {' ', '\n', '\0'};
> > +     size_t len;
> >
> >       tmp[0] =3D *(buf);
> >       tmp[1] =3D '\0';
> > @@ -1391,7 +1392,9 @@ static ssize_t
> > amdgpu_set_pp_power_profile_mode(struct device *dev,
> >                       return -EINVAL;
> >               while (isspace(*++buf))
> >                       i++;
> > -             memcpy(buf_cpy, buf, count-i);
> > +             len =3D count - 1 - i;
> There is still a risk of signed integer overflow here, please review this=
 part.
> btw, the variable 'i' may be greater than 'count' ?
> >               while (isspace(*++buf))
> >                       i++;
>
> Best Regards,
> Kevin
> > +             memcpy(buf_cpy, buf, len);
> > +             buf_cpy[len] =3D '\0';
> >               tmp_str =3D buf_cpy;
> >               while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NUL=
L) {
> >                       if (strlen(sub_str) =3D=3D 0)
> > --
> > 2.46.0
>
>

