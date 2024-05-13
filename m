Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C93BC25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 07:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0650510E4AD;
	Mon, 13 May 2024 07:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ArusDLF4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF8F10E4AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 07:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1XY1PEOoGUs3cWE9XClV4HJE0LJl2N80vsc8jYcL9DlA7j+OSTqH3i7MU5kmuXnshV1aaZT2hlNurVMS83wsQyntjQhMLpLx479VEAGZYCNkj+i9TEuw87b9VXtBie5hJr2zFOsDm+Fasr24O3xyGVG8o5SB3UHFdxRmkSZ63Pt2LSVJmasz+FKGFbQMxwTeLLr2O46Hpl92N9g93eFi/3ngiMVhTbrUUMVi8bvhjZ4ea5N8iXb0xqkPnknxTzxC0FF6QjxXyMRfaCbxOfFhzArF1/+XNBSaw9oL9np37pY6xYcdDcBT9xmZSDLt6ts6/ZEB8wsLdl+aLu+bocXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvkxIg/che2Rm8HqBbyVNjr3iQeZ++zsiWzzRCL+svo=;
 b=BETdcqHXcZMyKwRQQVsksC1ojEjdLBiZzv3D14pUoMV4PaxdaLNIcWPHwq3JCcUgXxHjtesSWZW5dCtAzCWxEBi1rtztcEhl3JKZrCTJTECZUwrAPoPpkmxwRNJXzcyaK51/dkgBr8HJM2Ov/8UhXPJMOtk8e1ZylpyO6OqiyYnsh5iqJqtYxu5Mv4DF9WhOHpSuVgu5ysUZo5hr7OsoYIXXogAlOyLa1rloRsJUx2Jqjc6h1+mh4UbRt6nJRLGOByyB5ftFRfgsQU0LesNJ6UaaafprYuDta38zB9e/sqEDrUURq97NPp9CLuk8Aw+WOTgWeANJOyf6Mju7DCa/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvkxIg/che2Rm8HqBbyVNjr3iQeZ++zsiWzzRCL+svo=;
 b=ArusDLF4UPzMfHEJdnXicF7M+6Baces0wThRj/K/nVQ6DgOMamYF/ZJWNE6jTSRm92l8VeEzuxCKlUAtW4t+zxTVm4wLCvFnsdbE27Wqqd/zFP12+G0BNY0RvZxbXnHH2uO/5ZIm5LNgTNxUY+nWyWqmyv27LsJl054YBd0zfSg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 07:58:59 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 07:58:59 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Thread-Topic: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Thread-Index: AQHapQfzPijOG7WKO0KYWOlrxoOfELGUx4oAgAAFGVA=
Date: Mon, 13 May 2024 07:58:59 +0000
Message-ID: <DM4PR12MB51524D8DE64D0707903A0977E3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240513073359.3612989-1-jesse.zhang@amd.com>
 <CH3PR12MB8074401359DAA799678AAB2CF6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8074401359DAA799678AAB2CF6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a5abaff8-81d7-47ec-a5b1-c037a1d6af6b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T07:37:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY8PR12MB7705:EE_
x-ms-office365-filtering-correlation-id: ff37786b-c877-471f-2261-08dc73228c02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?xpQ1sDfq4pUFy2d/58qKMai5eaOkZwSDpPDJmS/Fxdlnfdq/lJBWFYA4dLPR?=
 =?us-ascii?Q?kt4W3P316gGgS9zQF3NkjtKLeUlk+xdRLqlifG8nogbh4dMsE860M4CzJ14E?=
 =?us-ascii?Q?n8/QF4N2MgvynT0jnOI+c0o3Cm7oXCi39hsiZunp9DwJ5jmTf8++bsS/IX32?=
 =?us-ascii?Q?SCX8a5oItimOQgETdJshxLV9CWD8/Hgpj7obnOtrHho7qSFqRzqjbTvN/78h?=
 =?us-ascii?Q?D256B2gN44GpYzQpaNhVR59qQ51Ks7F59xwqXLRoJATPu07G6dzOajpIvnOs?=
 =?us-ascii?Q?Ajq22BDAPFMUBFl6RUbyfAZn4MxQcNOBVddXsYSw+XVL9crALxIMiUnfv0he?=
 =?us-ascii?Q?/u2cbtVu+YC6rZVXiN4/5sLPSMX/x0J4CeUtrkNI/OGtUXZHpATfveUXKWiN?=
 =?us-ascii?Q?55z2PXEI3fQZINiuptc6Uo+qDgHqHoY+i50+WuRjTZSsdVWrup3ltq1IcmFP?=
 =?us-ascii?Q?J3lhP4Ixt2huk5jhYT5gRisYsK03YMDRXydt37hKWMJXdVl3oa8Pl+2TN6gi?=
 =?us-ascii?Q?jeNsQxtVIlyeSLk73cDgA7Ji/VoeVJLxEYN6VhdIP3dULdA/48ep9WqFzj5h?=
 =?us-ascii?Q?TlzRX6110BKS9m9i0MQnj0mYA8HryG69MyTXk5cGrHlQ2C7cHDcBliIA1U9O?=
 =?us-ascii?Q?EfgcpWcLEt9rG281EYxv05thi10VLKXRZ/OCHvxDXDpkC4cvSNinIbPVEA6V?=
 =?us-ascii?Q?wRgdUa0wLl+zyZeszilZCXVPR7QqBe7CrGeCUyH7rHasYzxULaT5WIG3lXaT?=
 =?us-ascii?Q?ZkqDFv2OY1KdyCRiaKo5GbESKPDZZ8In11Nh+/zxc7trBxT8/kVEBgh+sSkZ?=
 =?us-ascii?Q?6gLN38LR1zFxJT7ZeGWGquyiWIAktP6X5F50HL3hgq/fTIbLNKJU6bpc4IBc?=
 =?us-ascii?Q?JoyoV9rNHFHpURkAOOyhCaJFozPKzlNrnWgiDtrry2ehSngIEBanBtYbq8bG?=
 =?us-ascii?Q?cyNkKdyzDFM29Zs670EGOyWDrnGi6W/j4Mw5ZAEYpjxGk0Tp4MmyhJ8nBn4T?=
 =?us-ascii?Q?EArSBkOf9YNASRXSDZ8w4jQa9DkEio4LFZmgtSMjJTv66sG7ze/YY8YSAZMW?=
 =?us-ascii?Q?iE6wD/DfXTDMPdIbLXNzDcDQ48KOMWsS12CaXdlpvBKd7L/OPRspeP5IIm2Q?=
 =?us-ascii?Q?slBQWX5GWP9Y2IsMlxe3h2t5pu12z2LsksxPPerAfXfaSKhGlL8tGKWS/a/b?=
 =?us-ascii?Q?l70YlYnYGP+LVpv27blFHCWzq1/6H/Dov8nSivqGO99BoVClUo3xBVurRmmx?=
 =?us-ascii?Q?ZdCzNUP4m0PAEifc0KaMnZrSmPU3LQFdD92c9WP7rIuK6KxyaQ8ROiEn9H9M?=
 =?us-ascii?Q?eIDcP1fQ28utyYZ+eHnsw5E1AqyjQNhcEtPQ0yeCzZqStQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v+6AWXeSYLAzNJvP5r2E5Joj3Fdj08u4rdcBH99fDTpQt93vqePP7NmJeudx?=
 =?us-ascii?Q?P0lbmySDQmIkTvGEDa99zxpGEfEkimESmCZXqelO0VbpBHjGEzxT79uK6qjy?=
 =?us-ascii?Q?mYyEOA0cUIcxsu35XHDk1Wvrw03Y9bKN/DZ/T2JfKIquOC0FAc+7MikW8KQ8?=
 =?us-ascii?Q?SfHVsvfTjs3D1NGjYg3+6NpdQ1CP3aTQmQnBGK4LW6NDIk9udLUAQ4JClNVG?=
 =?us-ascii?Q?P6dFo3FYqFtr4uQyb7tRfHuqk/bBVaFZH4djW80r+haKwg93YAVNA4tB5wkq?=
 =?us-ascii?Q?b9e2sdY5hyyAXc7T838tbdIT6UFYd2shNyjxA9k2AeJ2DAkAiqVtj0MxqZ1w?=
 =?us-ascii?Q?zOrow7t3f9/LH5W3Uk+/ybEcwWdgNn5UBchw/RAYaIZWqcufrqMBG5Ikxrr6?=
 =?us-ascii?Q?495sz4BBTG212vNzf4fFi5zO/oo24r9+MRMF3/DeQOsqRxZUJahZsqRciCYw?=
 =?us-ascii?Q?lgPBuQ2+NzTsNYWTkM18T+8GUcSs0wBIDCNNkPcYPEJoAypTdA1HIK9EyoH0?=
 =?us-ascii?Q?p4XsQD+Oijrgu2HC0U5jQAhnQRWb5mFYXUL6A7VXtn8cWPcqGbkrw81LtfN7?=
 =?us-ascii?Q?YgcxJrWdv7K0ujXA1nCCyn1IynVMgHV9ctIxlceVUU0kjp/R4zQKtxzvXIkT?=
 =?us-ascii?Q?BjXy5LYfgcaqQMB0YBACTPqyXz/zImwQk+XmJrVD10PH2VBpieZqWRv7/zdq?=
 =?us-ascii?Q?wohncBnYbJ6TskJOc3bPH72jgPyTKavwmKoKbxpNQcd1CJmO64qiKOv05bmw?=
 =?us-ascii?Q?BZdvv7H99H6SUb7mAUoqxrD5y3lnk8b4anXlMT46xCQs9OrfNSdwjLUMBByK?=
 =?us-ascii?Q?586VBaNccW4CzLBKlWgJd279Y6zscjAOowFMILV6DLF6Vh7SwI0IuMDYytkQ?=
 =?us-ascii?Q?tc5XEi4Oe07k3ZCHDqDdA5qxNF9m1FquJr6nepHpa3ec5168eCgu6+sW5uSi?=
 =?us-ascii?Q?oalMTzTFv+eI/7Gg2Tcf/563W9IABrHMbVMnHAaIWgbXZRd+8lGqWVTf3gla?=
 =?us-ascii?Q?UubNEXhJWxfI6yzvD8nooSOzCPPoNfcZTGnfL2FBg5oeLPuX45Lav4RqD/+4?=
 =?us-ascii?Q?Gf3s1U4l6XBdxBHnQxCxivoMDTe+UxEoY1g47+FkhFIgYauW4a8+0ZwlVRUd?=
 =?us-ascii?Q?cny0g4S7r/v7mn9S43F/VrX6od5cpRNfMx3GCJX1ZDtl0IXT+5uAb5Mc/7MB?=
 =?us-ascii?Q?A9RmGp+IASgkxaLO3jLINNA/E823L2G6zJojA0NS7TtqjAHUNaUW76/S6JHO?=
 =?us-ascii?Q?zgiOXxy/d08Jqq1pbvJ+1bWuGc6DSGYJPF8iYVhDA+7o2zvDOV1hwl3XDqU9?=
 =?us-ascii?Q?LT9eR7ilJL7kBfbpZWZ5HOmePdRY1hnX583prPQbtOFGAS3LUekc7Le+7blF?=
 =?us-ascii?Q?t6M1LOeCaK6rlnOLGz1QZ9m3AtIvMoFfm1ZwcVMK7m+njSbdIycrzwk1+78q?=
 =?us-ascii?Q?Yy7v8/YmwnMtDzfbN/ZTkhaGBO01D2IFf/jTzXWthVWs2QywHb3Nr8POjca2?=
 =?us-ascii?Q?7ku2Jhq1BRhB59CD+vbk3//pwKr/ZjBAYie3ORryv7O4/GCXF/1l4HQola9r?=
 =?us-ascii?Q?mEUXC3wFweDyT0C7MiY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff37786b-c877-471f-2261-08dc73228c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 07:58:59.4696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEizK6yI/tV/PV5xyN5jspx4awg8wQpuIy7rxo9Lb0ia+8p2CI36IgnuVBjIhAddjxlAlvlHFzOavvhwBwppjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
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

Hi Tim,

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Monday, May 13, 2024 3:40 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jess=
e(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 18/22] drm/amd/pm: check negtive return for table entri=
es

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, May 13, 2024 3:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 18/22] drm/amd/pm: check negtive return for table
> entries
>
> Function hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr)
> returns a negative number
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> index f4bd8e9357e2..1276a95acc90 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> @@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr
> *hwmgr)  {
>       int result;
>       unsigned int i;
> -     unsigned int table_entries;
>       struct pp_power_state *state;
> -     int size;
> +     int size, table_entries;
>
>       if (hwmgr->hwmgr_func->get_num_of_pp_table_entries =3D=3D NULL)
>               return 0;
> @@ -40,15 +39,17 @@ int psm_init_power_state_table(struct pp_hwmgr
> *hwmgr)
>       if (hwmgr->hwmgr_func->get_power_state_size =3D=3D NULL)
>               return 0;
>
> -     hwmgr->num_ps =3D table_entries =3D
> hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
> +     table_entries =3D
> hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
>
> -     hwmgr->ps_size =3D size =3D
> hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
> +     size =3D hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
>                                         sizeof(struct pp_power_state);
>
> -     if (table_entries =3D=3D 0 || size =3D=3D 0) {
> +     if (table_entries <=3D 0 || size =3D=3D 0) {
>               pr_warn("Please check whether power state management is
> supported on this asic\n");
As we return 0 here, we still need to set the hwmgr->num_ps and hwmgr->ps_s=
ize to 0 here.
[Zhang, Jesse(Jie)]  yes, right. Thanks Tim.
Tim Huang
>               return 0;

>       }
> +     hwmgr->num_ps =3D table_entries;
> +     hwmgr->ps_size =3D size;
>
>       hwmgr->ps =3D kcalloc(table_entries, size, GFP_KERNEL);
>       if (hwmgr->ps =3D=3D NULL)
> --
> 2.25.1


