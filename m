Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10154C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 03:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533CD10E433;
	Wed, 22 Dec 2021 03:13:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A421F10E433
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 03:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOLOWhqCDRapkqleE6luzxqh1UCeVKRtjycmj80GXYn6WPS28E8oD0x04iRDl6hlDOR75qj8tldQTO5DIwzTZ52XeUVwSSn4jj9RiY4FmpQWyg85DGLhKla3vivO70p87cMtkVwAkbnEU5t1/fknWvz5QT2G2ptBqgBLdpgGMY4ttGJfey6x38iSpg/iE5wv8mWqm5lRJIpCwnufan8CUAZa5qN3B26jJtF+Qtmr+fjaD527EZeGDAtd1vbr814DYt2LAXRPX9if2mbcbQiGceWhunGypnHp5Rj+07WcoHfFnbi7i07HvMvRe4vSul9rgleezHoa2HmlG8vif/Dqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DdutDmyyEq8GQQtE08F6hfntyRkeIrovSDoDut/6pI=;
 b=Y9WnMHMFWUDJutKet8YPMK06BrBLtJa6fwOlLun+t0NvgYEjoNLc0DzGbKMr4NfoCWga8h2qN2AalrrdH0F03tsqgPyOK/hMmrxXj9nLdeXL0tURVHeseKzNuLie+OgHPMnGxhgPWF/I37Gh8QQqq0I0JsdMzvv7ZdHmnmW/+ZQHX8dSDYU+EXAPCVIjG0cpIE/32ldzS1pbt0bV6sZ+FIzdXP9lJz/5Z2mKXtvif3Q8RBFqP/q5wve2ULqz2WXbt9U17ljtkk6zs2p0U2H4Qbe2C2XLC8zIF3QqtF2GpwVcgLCHLz9ATZRDeNCiECn48I/0pFcYAz3GxRprD1+N9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DdutDmyyEq8GQQtE08F6hfntyRkeIrovSDoDut/6pI=;
 b=TpGzh5G0xkNcjPAWXgHrBCxD5nDIWiOqUQxx57lqM4xK+IeOd5Oi35PDiKwDJVwDTaLiC59FFiUqaJhYxbLVK7EoF7BRhYAz+UVhjYNfki+dkQIVdDqjhWCGR3op+tvTaoSmM2GpDG2YDxaXv4SIlnVU5pFt2bZtdGIJ+zlxh+w=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.20; Wed, 22 Dec 2021 03:13:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%5]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 03:13:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix runpm documentation
Thread-Topic: [PATCH] drm/amdgpu: fix runpm documentation
Thread-Index: AQHX9ntTn1xxPA7UpEOCISJEZLy1d6w91fLg
Date: Wed, 22 Dec 2021 03:13:23 +0000
Message-ID: <DM6PR12MB26191802EE0608EAA06DDBD3E47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211221145853.725472-1-alexander.deucher@amd.com>
In-Reply-To: <20211221145853.725472-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-22T03:13:21Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=51810db7-d47a-4be8-9493-aa7a84281ae7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 357a3b91-9c7d-400c-bf02-08d9c4f903e2
x-ms-traffictypediagnostic: DM6PR12MB2794:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2794A44F9831D96AF9270EE5E47D9@DM6PR12MB2794.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LW8kjg4ePxYcM8TuWyBeU+ZNFJ0/sz6nLvjoKctNMfJv20B574JDK2UOE7YWobykWP4BDOypHE7qzFoZr/C0U+mFOjFJjvnngZafnyhByRZLtO70YPD5n486hd8wn3BBWXNngN/u3KdkewdMf3yURdhN0yt3Ym+Czj4YGdnDlGTTL0POowThmqzUb1T5PES/j+6kE4FCkWDt3nK+wgXsHxU/qu8c8zwdsanHZ7ze0eIAbr6ES2PuYp0s6H/zIAZWlayl+to+SUXL9nF0MWtePCAl/Y/9TA6HzB3htWdEMSR/YlxWR+lxc8e0PgfL8VVXN0zeAGE7wuADU4cWVBWN+9nN/pHw8T2DEWdrz/1PsxXcfCHzz/iY/Ezt0NFVwCvkB0l6HQU0fqf7mweN31TfHvDdn2hrb+7ukU8FC2IIjg5uS3S/i9YrLTZz3l0yMIGilD6+3fAcTF5ndkMxNbsx6C/ZGhZ2kqx/MRU9n8tOIVL3UYjukoFW1kZcRE5xVJIUqpPwG+U40bfS9RrCZYZIoH7oLiPlm/7aBeLfAxTRBi5au7S+/ERDFSxLvyxchaknYoOi7X2NPB9xsZmb0c3VLQ6nsqIO/yxFAv8Lm/eDCLKNVQoCFkzAuBz4BLScg7W1aB8YZLL436ViyUlQX70iRxaKsGp0bVUe46t/qtKULGzeRQm9pTIi2tzm4ZLCs1puN3B4BxU7ZT7PqYTgGTxAwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(86362001)(52536014)(66476007)(66446008)(83380400001)(38070700005)(64756008)(6506007)(66556008)(66946007)(26005)(186003)(53546011)(2906002)(33656002)(4326008)(55016003)(5660300002)(7696005)(316002)(508600001)(110136005)(8936002)(9686003)(122000001)(71200400001)(38100700002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vz1HWyOSmZqObM73v+eusvGPejgg52VNFaSw8QjhtZLgplQL0WpDJ04S+ins?=
 =?us-ascii?Q?IbPPlbsHoZAKpsOv0AI5OKaepcHmug99y2C6tluAQ5ctIdFRRs2PC9t2gnqJ?=
 =?us-ascii?Q?BmjYAq8p+hKJug3WjeXFtcam/qSZFzCQD5H/luhTsqhPsXGiq/uXGKRIMVty?=
 =?us-ascii?Q?CZnDGUUxLd8si0YmOPxiBho6+XDTTkCawtFHLWY9OlYOh6o4hNmmsNSNACGz?=
 =?us-ascii?Q?t9JBAjNl+ZOGSuEQG0VngP7c7iCYbA98UeHo4TYQ3mgkfJ40qpnJhHwgCDzP?=
 =?us-ascii?Q?028ZKosLr7JhxiMobIKKLFraWmISkF0eRJTdvy2u+uNdHNv3klxuV3qALXmp?=
 =?us-ascii?Q?Kn4Y2iooQrF4Xi2eTeSpy/EqQ9mXXFAHNoFBUSOx/yHd5LXKwk4lSzUorRaQ?=
 =?us-ascii?Q?g/u4YyiUHQqp0zDer74R+tqJcUkM5Ni2hcUtWUgwTPkauNSZ9xGHbTDca7pZ?=
 =?us-ascii?Q?j+a507nyHOXh1zx/Pwiougd5de3hZieKurhNetnKCie+JELt7dAyorwM1M3E?=
 =?us-ascii?Q?E2q3/x/Mzqk9MNJ1yhYgevaXSb2H3+QRyaOjuQ3ffJTahgWam3JmB8JgUJwy?=
 =?us-ascii?Q?uf8pisgF8IGOjHFxycCzJHngLc6FdPnjYZLwHDb4I86NeOnlKd2gWAFctPg9?=
 =?us-ascii?Q?wRf1zooXVmOstSUbuFO4+9tfZH2dMKePW1A+Sv2RTjzoBbTRyX57+XL9677k?=
 =?us-ascii?Q?NAaUeLQ/pBp3CLZaOmUB/kBIDA2WBAqAsD0QEJGoIyUu/kelRerDYP2EhoLj?=
 =?us-ascii?Q?9VdKutN7U8gAHpDOXlybLuunSIltI3Mb/Bg0tGfqtyWJYsxlOOsku8zS1JiZ?=
 =?us-ascii?Q?fhpCYNyrmBwsuP/c4UymllxQw6MzF7cCrGiNmOxUXZZhODFP4oCuersklatR?=
 =?us-ascii?Q?+fGWm16YfL0QnQQqQ9+pFi3BJwoM/Px1wlfq2bZTJnAYGEYjGmtwmOo8h7Bf?=
 =?us-ascii?Q?Q7wHP3jXwSA/7WxjA9RSbtvtcjO/TkmOXl6PVJe/HQJ3BjT/I8RYJqHYGoiS?=
 =?us-ascii?Q?1t/FfuntK4faLmFXlKXMdeC4w7B5YK8pMO41xYzX3lPrAKfgucXjD7Z2TUfO?=
 =?us-ascii?Q?CVcLbrMDCw0I606roUgk/UGr2Zt+aKl4uzX527YYNTgEQMyMlNCo+6lRjjKp?=
 =?us-ascii?Q?NRyPTH4V2tzbeGOWgRX1zGkRaZJ3ozXjTsee+SyWti3Gb2CaqajNQ09xc2HG?=
 =?us-ascii?Q?m1uKaCQFoMtgV8dmVI8S76HwiO4EwOKfsJv9ADEZSpBjVkvA+/cNIqUpOZzA?=
 =?us-ascii?Q?N0Xz8uya3PbrscTvPBAY6v5kbC8GbCw/VHPhDrBt/3LWFEjcNAxPMb54hfil?=
 =?us-ascii?Q?Zmu5QzcshvRUJyLymiR5pILGaqw9H7N69jW3n/+nEC8wCjfgqNiG50thwf4Y?=
 =?us-ascii?Q?fRfgCFFMo1OP/uKKKykUnFmD58bAXm9bbYkNs7zkQ5psaB+DGPFbcDWuMYXx?=
 =?us-ascii?Q?lewGSOlPL0gr2tmSfOY5AjFJ284xVSGCfwzil2tq0xyiBFRCyk/Cq2EDc5oN?=
 =?us-ascii?Q?CcqokQmKdtDU5hV5DmCAsU935EnInhJnibA3riJQ9YdXDYTGz7wNpsqoS5JX?=
 =?us-ascii?Q?+q1zAcKKhYmK/DlPSa0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357a3b91-9c7d-400c-bf02-08d9c4f903e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 03:13:23.9790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JV2QfwVUvbjLJ+BYlgOsibs2s5RqWTPb2WhIzzl8++3X5jPUG81VqO4W+vYPWyam
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
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

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, December 21, 2021 10:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: fix runpm documentation
>=20
> It's not only supported by HG/PX laptops.  It's supported
> by all dGPUs which supports BOCO/BACO functionality (runtime
> D3).
>=20
> BOCO - Bus Off, Chip Off.  The entire chip is powered off.
>        This is controlled by ACPI.
> BACO - Bus Active, Chip Off.  The chip still shows up
>        on the PCI bus, but the device itself is powered
>        down.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a78bbea9629d..f001924ed92e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -331,9 +331,10 @@ module_param_named(aspm, amdgpu_aspm, int,
> 0444);
>  /**
>   * DOC: runpm (int)
>   * Override for runtime power management control for dGPUs in PX/HG
> laptops. The amdgpu driver can dynamically power down
[Quan, Evan] This("dGPUs in PX/HG latops") needs also be updated. Maybe mis=
sing unintentionally ?
With that fixed, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
> - * the dGPU on PX/HG laptops when it is idle. The default is -1 (auto en=
able).
> Setting the value to 0 disables this functionality.
> + * the dGPUs when they are idle if supported. The default is -1 (auto
> enable).
> + * Setting the value to 0 disables this functionality.
>   */
> -MODULE_PARM_DESC(runpm, "PX runtime pm (2 =3D force enable with
> BAMACO, 1 =3D force enable with BACO, 0 =3D disable, -1 =3D PX only defau=
lt)");
> +MODULE_PARM_DESC(runpm, "PX runtime pm (2 =3D force enable with
> BAMACO, 1 =3D force enable with BACO, 0 =3D disable, -1 =3D auto)");
>  module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
>=20
>  /**
> --
> 2.33.1
