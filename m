Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB3ACD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 08:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C377110FA8E;
	Fri, 29 May 2026 08:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hfc/b5KM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F7310FA8D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 08:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHZlx1IIx320OyqRlN/F0/ZToArEloIodixL11RNsZy2a7Z6bjEKG2HXKwRJfthy+yQ7UEZDqj2dFVteqL7r/inJRXr1jsS2quw0NIpH7j0Rv9Od6KEhDNWAk64nny9Amk0I5EPEXbCA0p8d7rjxZ26oF2xm0Lv0MzdweF3Usv6ktLr+4n0bO8v/ZQ6BPtidkn53ZQuoxkA68rsbScw+F9+PWYByQAN5ef39YuahUqIv1JjWBWFXI4bFcZrxQc2PFZRbNa3NaT2YCuZgUwizaMV9ALRN6SXcYGm37mt4FVeE4wVHatq0snlvJ2pxt4zotP4/P1rhj3QI5JetcjkkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/ZW1RWNFoOR/5QZTjuA28w7c5HLB7cOAB+KcVSvww4=;
 b=AhFy0vtDLZ6FMPpsudBvYVu/wGLszCbTr33ofpckuU6U52GlULHHIJEp3lS+Pf69Opg5WnWdD0wZ7Py4sdLh0g7sNyFzt5ZUG9/L/DQtX6O6jl29BLLN9M1HKwtanHPx3BzyJJ4nSYZQi2RT5FA7aJq+t7BOwrHkylb0xPpSBXahYY9c3ySjBV6QPzDQkBO9SFOdSXwDN2u5TvTRPxMJ7907Dgr/SDCdzIqXlIzfRrSv4kw88Rt5CodCIuYM5XBGHrfQGk+dKPdrDtW06ntslHc1/7fcEK+HoX9spHBtqg3vUZrbwkLT6LKR64hJ/LZWCNvLKda+LLmSmzUg0NSqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/ZW1RWNFoOR/5QZTjuA28w7c5HLB7cOAB+KcVSvww4=;
 b=hfc/b5KM9CFsBxLXMG5Fc0U6TeTtNlt4O/rNSHgDWGzco5KPl/SXKNX6tjn+XfrwiMD+n5eDatf3q3iNhO314Dxsgkq1It+rf9pJzHyCVzgLM01VZUevjU9PNOxQVM8pNff6abEJIZ7g6mHdtkrkSBplABoLLRRoWxWdhRVT3ts=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 08:07:15 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 08:07:14 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Thread-Topic: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Thread-Index: AQHc7zL3qnZ7R7HYpUm11LqCtsfYvrYkkeOAgAATklA=
Date: Fri, 29 May 2026 08:07:14 +0000
Message-ID: <DM4PR12MB503870918384A4AB75B98CE28E162@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260529061811.357041-1-asad.kamal@amd.com>
 <DM6PR12MB2972B5C6F3EACBEF419362FE82162@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2972B5C6F3EACBEF419362FE82162@DM6PR12MB2972.namprd12.prod.outlook.com>
Accept-Language: en-US
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
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|CY5PR12MB6180:EE_
x-ms-office365-filtering-correlation-id: d85741c2-df8c-4eeb-d5cb-08debd594b7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: mteIBKISG0Jp4aElcMPMD3aOGZTO/Og4PBKdx9pSblngHiMtPsE842+jqZm0EAxRFKCFpuuWNdCZhcqdr84R3172u02G6WnQuz2dvgUkwzQGA2t0EGKshgy6mal89/a23SCUWLnxmOhI7Bgy5vMYmxJMhkuuH1tVw2XYkxGEZWX5ypvb1ijS4TTUcTLroMiOT85auuPYD4GfAYVphBzaNWr2MhZne1kBnfS54zn8+RkCRE9iALclknAkkFRGfdq+qUnXB1L1FNFzedxBFd4wbsNJbqanLvDMSV8luayG7FZiEwE9ImuQzKoRUVyr+WgOAtOdQdrYQNt4AOyd6fXMOoCWqhFy5pmj/uz752chia1n2AsNm4+INs17dj1mbl93X0oswrgiF5oXVBlnl6C7OrLrTeCxAWMhd7wL8v+aNKb2qeOrgBkoGhROLg33Bktfzn6Z9ZF6dBylJVOFvuzKQEIROuySuK57KRd+yudFgeubgWrmQeeoIFl3o/7QLa50JMi89B/ZpMwHg0hxanBQINW2kgag6Wdh0+NJu4zDCTlaFQT/1PKjwQD6qx4K6Ps/K5oU0w+i3CrgWKC0gs00h/U5UCjsUJgq9XfS6Cv63rdCMmDKCEwHWEMao4/3NddgLVvnTM/70eCgYi0a71kZBnE9fBQU2a4O9sBh55lhZJhSUVEpDxUhIA0prGOk65mIH/4BmABvcdIJtTOU849YDmxup5xqN5KMEQvORaYpYVJ+AffoBEC/N+L29AsFRmcs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EMxbEUJHEVdyD4ujdWt5B1t6SkiTRQyKS9ZdScj/24QLBuL+CISpBtGIc5sS?=
 =?us-ascii?Q?pwZ2rO8D2ZYjEkmrGZ+aR3V830yHb21VNPmnDXOak8FS02qYbr1KAoJIZF8S?=
 =?us-ascii?Q?fbDuTyUevRsYYNsxhBE2VOvHiW4sefmvExxhfRd4ahXscOs+TRuC0mc/LM4t?=
 =?us-ascii?Q?RuQzVAP1Y2BOw3DzLKowA49CauEjpgDVrWgeKVOLksh0SaieUHp4S9lV87uz?=
 =?us-ascii?Q?lCczrK/dfIgsoOKSyVeocFHAmkzhQomiSVpCioc4UDhzWKXjx4r5h9F+wxhU?=
 =?us-ascii?Q?LxD8rLG/mkwQMP/E0txeNe2JBjhOnLY1dKv1elNtcQ/9dDa7u7EctE1g4yta?=
 =?us-ascii?Q?LlqoVMBcBzAxLeOBG4XvjYrdTS/uSPKBaDmpHJ+kqephOqlk2RwudpA0NR3q?=
 =?us-ascii?Q?bBSWZnSoz5cxY4jz/JrLCNm0rBW3C5rlyUhbG36G4z3C9fVdLd757x8boxp6?=
 =?us-ascii?Q?tkpWHID8nHJv1MosCb/QkzOKe1Cpeut9GjElZPSftgdBO4HlNy3vwfJPn/8T?=
 =?us-ascii?Q?hvwtH0A4GUTX0hy6QCdUGl2IKNTHhg0QlKXhp+vS/xKpJ12xPhI8NrHtbXg1?=
 =?us-ascii?Q?977x9hySHkUtytHZaZvrCgyCIF94QPAM3Y0w+IwAQM5AuBJX2kCn9/9rVxTU?=
 =?us-ascii?Q?0Y66pcDdWcbupTRvpGRMuIJHazj2c1e2O4a3nqF5HEj01IqKlLG5FgFqW+8d?=
 =?us-ascii?Q?4SpUe2scq1Yha4QPM4DwP0cUzSk/+gELUlrPfJ5QKFJ+FdNpGBmR13a/7avV?=
 =?us-ascii?Q?34d9SJXsQQQLpgj0UHeV2svL/L7lOQRq7xl2vNm7LMFC9Hd7Afqqe0JlXnKd?=
 =?us-ascii?Q?9zj2xeQ1D72wEo4fHLa2ZmzQhU1mtpbmsyldhm8wzs7+HuJYBYLzRSv701D0?=
 =?us-ascii?Q?TEY4if9QpGmU8Z1u+rbllBV7iwvx5BrTs9dn+/DfqrCnJ7/bPerDU8/i5Voz?=
 =?us-ascii?Q?WD+vUz7jxLIeinZo28lzpeVIFewYCWwKpkCYkf834q1KZwU6OKhIturlNcqD?=
 =?us-ascii?Q?QK7dzcg+wLaid/3HkYNhXbTOOuU53NV8TtTNhlUMoicMVxZedk9EB5BGem60?=
 =?us-ascii?Q?mbZhsWR6W4wGHZq+t6kve4eJNEDxdZYi9xoHf31wJ5zz2dTsSH3VLHGGG+kl?=
 =?us-ascii?Q?X0jKkpXSz2vXhUFro9NKzkIHAgY1WI69hHG8ds0CZF0wXQg1Dfn5ywpM49tK?=
 =?us-ascii?Q?GL9ySsv58QukYCaXEIxC8Uu0ansSfJQHpelpwDtIbNMlD7dFoTY7teMPfgUI?=
 =?us-ascii?Q?iZDIy3bQdIz+DPbl4XSzKtav6+MCer/jqKaPRh5i6vKCv5wCAu0/SJzk2/o1?=
 =?us-ascii?Q?wCV3SJCAXHV53KvvmHQrRWcss2DybyEqHbnT23uNP4D+llxtOyr+itDtDYmu?=
 =?us-ascii?Q?MmJ3C+PHU+FKWw0epXVKLLo8YjtE01mBb9BSUtHpLOvGsvzXK2YPayLR1NkW?=
 =?us-ascii?Q?9KVcVRjw3c1hcbTuaX5vV4nulTD4oLeHz3hdFZjmAu+HZFmmeOVJRdZyOnpZ?=
 =?us-ascii?Q?P+pgJbCC9O1oGvvhBCFciaPdD30hVGV2HbN6uWiFYwIG0vhyAp14DXnOsCPu?=
 =?us-ascii?Q?tdYaK+ylwIeDH1u0v4U0pqH9S0q353fQYGXoTgMeVeqV3WmWSlzBBqIn9ySI?=
 =?us-ascii?Q?iPwWOPqjvFvpo6V/1jw5xhmFAfgxFMoxDC6XWE7UXDbvnmJbN2tJBK8/IUFs?=
 =?us-ascii?Q?mpf4/LURrGBzY5tt316Ga/ZIE+WwdeWoSSxFtXgdYnhpgSkM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85741c2-df8c-4eeb-d5cb-08debd594b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 08:07:14.9145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpLkEvTicn1Df/3oYJRt42hHhCgDxnsDZ1DucT0GrrPlVRUa58DUXBSGxgBvo+UO9GHShTdR2Des/7y2ubO+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
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

Good catch. count and i are unsigned, so the concern is underflow of count =
- 1 - I, if i + 1 > count, not signed overflow. On the sysfs path, kernfs N=
UL-terminates at buf[count] and count >=3D 2, so the whitespace loop should=
 keep i <=3D count - 1, but that isn't explicit today. I'll add if (i + 1 >=
 count) return -EINVAL before computing len and keep buf_cpy[len] =3D '\0' =
for strsep().

Is it Ok?

Thanks & Regards
Asad



-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, May 29, 2026 12:26 PM
To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode

AMD General

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 14:18
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>
> Subject: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
>
> After consuming the leading profile digit in tmp[0] and skipping i
> bytes of whitespace via *++buf, buf points at original + 1 + i. The
> number of bytes still inside the sysfs buffer is count - (1 + i), not
> count - i; using the latter copied one byte past the store buffer.
>
> NUL-terminate buf_cpy before strsep() so parsing cannot run past the
> copied payload.
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 60db9b66d08c..450ecb188aed 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1379,6 +1379,7 @@ static ssize_t
> amdgpu_set_pp_power_profile_mode(struct device *dev,
>       char tmp[2];
>       long int profile_mode =3D 0;
>       const char delimiter[3] =3D {' ', '\n', '\0'};
> +     size_t len;
>
>       tmp[0] =3D *(buf);
>       tmp[1] =3D '\0';
> @@ -1391,7 +1392,9 @@ static ssize_t
> amdgpu_set_pp_power_profile_mode(struct device *dev,
>                       return -EINVAL;
>               while (isspace(*++buf))
>                       i++;
> -             memcpy(buf_cpy, buf, count-i);
> +             len =3D count - 1 - i;
There is still a risk of signed integer overflow here, please review this p=
art.
btw, the variable 'i' may be greater than 'count' ?
>               while (isspace(*++buf))
>                       i++;

Best Regards,
Kevin
> +             memcpy(buf_cpy, buf, len);
> +             buf_cpy[len] =3D '\0';
>               tmp_str =3D buf_cpy;
>               while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NULL)=
 {
>                       if (strlen(sub_str) =3D=3D 0)
> --
> 2.46.0


