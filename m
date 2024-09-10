Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F93EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 14:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6EA10E815;
	Tue, 10 Sep 2024 14:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qAHokDtU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CA510E815
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 14:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USotKpRNdrwMII8pNh4+mMLC19nRVDDJ2jOc6k3/ty/A1whpmI265oND+WlLYnpgR0/X+/mBRNF3D1Vf2u9EmKjJE5rHv8hAJg3513LWaoaLFPMcuRjPbcvH8H7h3g1CmF9SXOKBejB/vAhFiuBEjHRkCgYeQyhxjomn9HDVTnwrZAbLDwZtR+BE/R2E02t2pyvQ4OyAwiA7f4/QwBTaFS+bmpzqMZ7tDf8FZFGE2ud1SgcplwWquNJtyfsz2iSkObYIuLQ5JRfphWMRlVIlb0CuxjlTE2qUNddERNr7o9VT8cbrDBgvNc3gJkQIQ8H9tQ4f2h0yMkO0sROMHovgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMOizA6Pl4O5B4hHgNd+Dl6I6TrONOIhz718e1jk3NA=;
 b=rJk/kN1J3uHZrFbkdOBQ9rbvD9gu3n9YOlhYObkIxjrQccb4xPirf4tCM6cr8zcI31eT5NWOahnqTf8gOzuv+oMn/MPtkxapuanoZZgqSeJEuECMXpy3pBNS+ww6TUA6+EZVK4CDYpiZJWeO/zZqUEIvyutRP2BZJzqVmRA7Ib+Ci0iPHys1WwvLjyCzzSL9S0PsfraewbF+7t8oVP5Uk643I+sXEBbc+O6azACAo9amUwURD/MfmDwVfy7HQ7jUdDg2rj5o33/VFqGNxMJwbgyhbo7QsxuhOrdWtqrP5viL/fUHk78KL2dEIuD9D7/yEMNzYEsJIT9Ha/5IQWK6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMOizA6Pl4O5B4hHgNd+Dl6I6TrONOIhz718e1jk3NA=;
 b=qAHokDtUpGgvNDxJyp+aUdNfe4m36s+fLopqsSsGvrtTmB9KyWjUJqOkzeZrGjfJ1tqd3mgF8iE7wnMv8OKamIQLnLIxj3ahVbDpIuhdXdjXBh/E6XD/QZLGAkj8CzdzUKVpd6xgmu+hnp+ljDmzARN7q1DjLKNnUK+5PKOiLu8=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Tue, 10 Sep
 2024 14:17:40 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 14:17:40 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Retry i2c transfer once if it fails
Thread-Topic: [PATCH 2/2] drm/amdgpu: Retry i2c transfer once if it fails
Thread-Index: AQHbA4aTFJSyFKz2FES7N189/Qjf3bJRDgSAgAADM9A=
Date: Tue, 10 Sep 2024 14:17:40 +0000
Message-ID: <BL1PR12MB589848D779AC8E38171A4935859A2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240910133703.430803-1-kent.russell@amd.com>
 <20240910133703.430803-2-kent.russell@amd.com>
 <DS0PR12MB78043C52A4BEEBDEEBBC5CAB979A2@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB78043C52A4BEEBDEEBBC5CAB979A2@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=130e80a6-ecb8-4707-a282-2ef27683dbb0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-10T14:03:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|BL3PR12MB6450:EE_
x-ms-office365-filtering-correlation-id: 6f52dcbe-725f-4437-5ac0-08dcd1a3547f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cVLiLvr8jK2ejuvevNHDBPW4ddlYVKWpcZLSBng9vSwPZwKvqvGC88qpZE50?=
 =?us-ascii?Q?3FjPkYX2ACasOwUPqH9aBJLuMVvZfcWqRbk7Nedq2+lIfCqydJY140TjSNqh?=
 =?us-ascii?Q?PrdVZ3GxnyqHJMvmDDQ7UIUPI4MX55FNheVBAd4NzUOw2oouJagAW7UXKgom?=
 =?us-ascii?Q?RlFsYiSwNDwwZ0XglUm1Wkmtgb48AepxzLiURsAJXtIMpP6Ac2lG3Jk9Z0tJ?=
 =?us-ascii?Q?GvZGeaoNt9nBFHEKQbg6H+0XP+w0ntRkg/0frlMEj4RxlARcsCDsbGA9X0V/?=
 =?us-ascii?Q?4ScXAfwAQn0upmgOgkcpOX+tNfw6LCoaMY8wgnbbbRUWEeJw9G+8yzGQWPTE?=
 =?us-ascii?Q?+4Voy2Soq+7SYMoW1uMqdzPUt08zfdxsHjDQ6qKbl4tKriw3Wc6URByAvW0/?=
 =?us-ascii?Q?qsx38F29EDzzAPDtqdVZBbCVHPHG0ziwvEzWLFlL0zMibob10d4KeEvpeXr+?=
 =?us-ascii?Q?r8TwNV+vRKYcyXm/pWzY9P8XlpuylX5ghrFgtXS2kCnzRMM2h1ifmOOeIu3Q?=
 =?us-ascii?Q?1tSoIIn0iWx6uPbbw+XjfVAzrVfF9WZGabqZybxvo3/NmZdzBANDLwO4SV4H?=
 =?us-ascii?Q?oPkIxoBl7afrqA6rUDHGy08l57FYCGdmVKS0gL2E1tR1mUpEn8hSBvXqX+Iq?=
 =?us-ascii?Q?N3ZcsODMaKEzC7pe1gQpopIT/EHKWdeXZzbFvickGyetohqjCQ5lnjNnnQLd?=
 =?us-ascii?Q?UuC/c1B29G0Ivh0VFZRpFD7xnYZ24nz6U1S/pBtJOV18pa7gZPmf0rzNaxJJ?=
 =?us-ascii?Q?qxTD/42GnIdfNjaqgzRCYWBOBgCMZyjOQBBkpIbkcZs05d/SE4tVMO4ZixNs?=
 =?us-ascii?Q?H5RnWg8AOgDsH103Wn1FEQFlng6EdRWtmS71y0I0+ikeQY+wX3dG/JRF6ISv?=
 =?us-ascii?Q?h7HOQT10NlNbiPlBigopl0d3UTyVQqppF41LuI4jcw8SBTb2eLzxv5PNhwPF?=
 =?us-ascii?Q?Cb6EklCEnWhNtu7VduF6fcl1Jhw3oGHPIT5YB03bqAOvMEUN414E4JkOgaxq?=
 =?us-ascii?Q?wuVtL5jAEYo6O3v/SvXHfE8evPDqFHRCwdxCNe9r+bbVfPSduEF2VKQgjJuy?=
 =?us-ascii?Q?48Eet1FEMncamJ8yKT+rxWtwPW7pRFScqzsvBmJQwGxPMriQUDrkccjTcFQL?=
 =?us-ascii?Q?JKK+vL79cfCBVydHgxMw75QiR1PcqLANIKVS3UDDZclUuxjUwWFB56hHQ9R+?=
 =?us-ascii?Q?ZdTxl6zbhMlVhHlgCpgMHQtF3nl0FzJKfamnNQwUPZTca6m5pGkRBngkHovk?=
 =?us-ascii?Q?ZIPGEbJXmEElEnN124QBBN5O8An26OSjTj09AOiIVJSE/uSDr0WhXObC+VD4?=
 =?us-ascii?Q?em8MMdVWBzrYAvCnk2ZUEgoryd0rpidGy4ct6JpsN6qDhLAVMKft5yvbc5Nj?=
 =?us-ascii?Q?TqUnEXgpbLIcAfnQwPkcv+wP2AMMBuHSOtSxr2MRo0mgmEh24w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n3/mEqM1B0U9ykw7QIa8PNEYfhGdEFyRB73NgWxyGRLVRdwU39P9wwLdVRao?=
 =?us-ascii?Q?ltsvjzsUl0T9We6NJIMmjnD9hX7EAF8X6omYmRoMkHPiDcyU39BHEdLicOEc?=
 =?us-ascii?Q?mqhd35pPTFEOfrdJbWbSEwUCT4ydZja2fipbD9WaxfdFooWzjd2AwRWcDtxG?=
 =?us-ascii?Q?QaocQD5V4Sh/mghjbw/f8pCyN9BOZwimFZKLEolkLZNvtnmotkufM+QBB7nE?=
 =?us-ascii?Q?Oe8U3Bu4ZNq/cbYHBzIlx+XriOZ84a10mZDCR+OE7dMuB3N3GF+PYGwuSOm+?=
 =?us-ascii?Q?i1vfbnWYS/1GqOokU1tDSGf7Vn+1LJ/1i5VI4tTunD1B2nneeBpPTsQ1pBSs?=
 =?us-ascii?Q?kKK+/oOTnQOjegzW/aWHyfVKZNaxrXEsex0LFkt09vQ/2+iU/cFfFZvzQsAl?=
 =?us-ascii?Q?r5zpbgNcOXUQgOaPFJF9P+O3WwEEl0Cm4pxxzkKcONcbkmFbDKUax/CmSXwO?=
 =?us-ascii?Q?bnwLUZ/9hMdKtWePeCkndAERfmptLZyqWBg386Fo3OFo3b68mFu2QkL1reDN?=
 =?us-ascii?Q?d6AOW+D8qT3mzw5q1UxTHp0LEBw8uHyj2TS2XvU4slPb36wwdHFsrr/H22A+?=
 =?us-ascii?Q?L9tsZKhndd9qrwHH5ga5+xKKQLnq0V/3Mc3SYCExM4BgzRYett4wO4Yqsb8J?=
 =?us-ascii?Q?6qTXLmjDgkanYZG/zNfxLsWh9EQg0lG5bgEBWzgYjbcB/kDckV6X9WdKJgRq?=
 =?us-ascii?Q?6pHjCn8tnNO1R/B/r6xxmv90c+rPxsmrmmaXVKUXZ9kYyyl9VHlAaB4outXv?=
 =?us-ascii?Q?Im6qYtNlmOAwZeIAWvUJFFARNIAqA1A5+ux+8pVtgHiDo8U4Pfx+tNkxj1cR?=
 =?us-ascii?Q?F9QRgj7q8PLgg90VmC75GKyehpQtYdW03BrqeroWFgh5TWjnuuyx5w6FJg5F?=
 =?us-ascii?Q?4IIZCzh+XMOwuCszulvQ0lUYyCADAP2aDRQk8zLZMz37WmeCaKOUJJyKa9rt?=
 =?us-ascii?Q?YY88MWP8aMZXY5tsN48Zo3JoL5an8/hrb/gmP3UnxFRKrGxzCOrY0BhQ3aIe?=
 =?us-ascii?Q?uNZpqRDCCFedWdikZUOZRxOOPQSZ86ChG0CBKhNusuVV9pcurYSVeaJJKHBc?=
 =?us-ascii?Q?GO8jY3M/P/yHhTJW/JT0ve9zhJcJXg2SJVJWL9RcXz+12m4TIg/w5aFHhcai?=
 =?us-ascii?Q?ZLv63t/84Tyh8cjBaLCU/wAxnqVjiUlCi4LnEcV/y8DYaZAIVo/YMS0xJpi6?=
 =?us-ascii?Q?NR+IkV4Lwp0UzIHqYyMbIAgAefG5Bs7ezjLY5HLUhzzfcnV/eltqDkgA+5VX?=
 =?us-ascii?Q?T3b8ZX5OnGeraqv+XsgbN04SFTjqtJcMsINatn1f4h8/+VyfAb6yJw0npy5u?=
 =?us-ascii?Q?nEYHWHqfQJ70RMFFblfoI1TtjknLr7eqJcM4UYfUzEC4ATePoM+yyR35WOAF?=
 =?us-ascii?Q?eMJdlfVM2i9TyOVT69N6HZPgqhKjbSnMBnCE/o0AJ44NbTFD1kfEJv4U0HbU?=
 =?us-ascii?Q?rD1VtGIWhRpExTMGAIy54Es9T9TyNBdTyjyltn5aFma/0zbGVASRcPH2onJ3?=
 =?us-ascii?Q?0IXQj0WUWZpq2D84XzllCaJFwUsQLc7SsiIR5L+9TskcffwD6G3KCltdmcW1?=
 =?us-ascii?Q?sj92Nn3T0iYdH/wEvJU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f52dcbe-725f-4437-5ac0-08dcd1a3547f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 14:17:40.7059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dGZnS47tsdzO39XRU1TwV3FYgijxwHtGaSqO8itqN+8kBHla9Zk1glrC7sSAjvnt3Tbf7ZRX8RzmRxpHIBAEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

Sounds good, thanks for the input Lijo! I'll get that tested and verify tha=
t it works too.

 Kent

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, September 10, 2024 10:06 AM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: Retry i2c transfer once if it fails
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> The ideal place is -
>         smu_v13_0_6_request_i2c_xfer
>
> Restricts the change to specific SOCs with collision problem.
> Gives a bit more survival chance with a retry on every chunk requested.
>
> Thanks,
> Lijo
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> Russell
> Sent: Tuesday, September 10, 2024 7:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Retry i2c transfer once if it fails
>
> During init, there can be some collisions on the i2c bus that result in t=
he EEPROM
> read failing. This has been mitigated in the PMFW to a degree, but there =
is still a
> small chance that the bus will be busy.
> When the read fails during RAS init, that disables page retirement altoge=
ther,
> which is obviously not ideal. To try to avoid that situation, set the eep=
rom_read
> function to retry once if the first read fails.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index 35fee3e8cde2..32755a37dcef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -227,8 +227,14 @@ int amdgpu_eeprom_read(struct i2c_adapter
> *i2c_adap,
>                        u32 eeprom_addr, u8 *eeprom_buf,
>                        u32 bytes)
>  {
> -       return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, byte=
s,
> +       int ret;
> +
> +       ret =3D amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, byt=
es,
> +                                 true);
> +       if (ret)
> +               ret =3D amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_=
buf,
> bytes,
>                                   true);
> +       return ret;
>  }
>
>  int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
> --
> 2.34.1
>

