Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C504C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 08:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CE810E716;
	Thu, 18 Jan 2024 08:06:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 178C310E716
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 08:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESDRvrpsI8Ku9oBDFMX7bp2uNptpeMN5YKnPIZJUQWbuIZm7EFiZFUs9UR1P/mw+6H2LfuKgN/UOIxS8ck7np72QDe/qxPKXRYP+f8bKuoqRSCD5CPbfl2uAOCff7BALFwlV5oVaPCraGW6YHRXbNziYb7g6aI73xSJquA2ieBFAUZagM/1xOywgC9OQk7gp2egacYFhBwLbXTYokIvSXIxjGBwR/vkpGIPfMRA++WTPN6QaZAvq8tJwtSsQ069b3KlmGW8XhO5wHCXtssEgcuC5mG5Fq1OsmngEkusnXhZbCyuNYhyNDFKeiWA8Zv7pXCG6nmpP/0QF011DJHkPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6XhZkaR4sdmx7rm/Ot0ZZt+gPCmd7iEnt/RQMKe5Og=;
 b=UscaAphHpY/yqbFB6lXT0JBR2tQEQvz8JruMyfrFynCQ9zw5Cx8CZpjZ9l3DVcz5u0mwu1mju0weSu4Y72F3Nhj939P/1vHbtPArO2DIypI/AeMZ3/w/6q+cWTXg3HX5cO4EGapR6OwmDuncwJhELmSj84kSiOwNM0KYCzV6WmbD5xqg/F5UsbIavM/hoLqBf/EQsOwCf2XwnlevWVMdW8Ydie7/MW58bhut371nqADRLUUgPmrtf8+GLBKPnZ7gTalFV4rq+UqkgkKdi/xjp2QeMwj4JFGXWCz6kpFL6/DXste1TR5KflsE/or76h5jDhZOyV+mzVZjkvIz+9Jtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6XhZkaR4sdmx7rm/Ot0ZZt+gPCmd7iEnt/RQMKe5Og=;
 b=vPajulwNVMEYh6G7HtmWjGUfRrSVPL13S4mJsotBkpr+rQFQW/2J74kQLZDkqCu75WtEdzC9oLDZOpxvgrs4LW/+k5oZserMimw1fiTqZVl+wEpT3irGxjMntrHBFVRtfRg2AWpt7kHjueLg0kJsSq45yRcf3zmX7OEYy66y+TE=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 08:05:57 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 08:05:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip call ras_late_init if ras feature is not
 enabled
Thread-Topic: [PATCH] drm/amdgpu: skip call ras_late_init if ras feature is
 not enabled
Thread-Index: AQHaSeMJg/y6Hc4OI0Gf73Jh3KfvhrDfNogw
Date: Thu, 18 Jan 2024 08:05:56 +0000
Message-ID: <PH7PR12MB87962D49C62A6C114E29CCD3B0712@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240118075002.2071651-1-kevinyang.wang@amd.com>
In-Reply-To: <20240118075002.2071651-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=072f254e-ac3d-4dd3-b841-34b63ad30f33;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T08:05:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB8337:EE_
x-ms-office365-filtering-correlation-id: ea1ddb87-7e32-4bc2-3474-08dc17fc4ce9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+bYTI+i4WXC8o4rhMXn4dEHgGAe+nc4miPdLxp+NpX9+HSJ+DkcB1ElBuCk36l/TJGhgWslqYyEMhxAUIzvKp4P9ex5IOuYH2A+dBYBXUQuVVxjMwRK0QifcMauM3vwvsPDJ9CB7L0yKjO2/IkQ4f9NfEu5TUCSG/h60EglNdzV7mJ59Y0/EpVYz0YjNz1MejAXAXn6rEZSQ+qH8CW78xr0o0420uEj7zFQWmTfTLnydtlUODAmASgTUePpgpfq4C3y04N8Kd0eaWz3cXYHIK3uZgJ77r8h+oyAmVljq9nqIoUSvF63FsQRIleDzlckXnG/F7s6pcOEAR4igHEPMVPHn678vVsCHdaRCZsznOW7z7AJPfd1SRuXKXjSOCDpcFJKdA6lW4zbY+7TUihBpLSVEEo25Wm6h9u4YSN7bfy9fF2lprQpIt5HuDBdKHXQDuYXUO0yHsE6QfMCm7ED2c3mUt7XUUdsgBXg8wI6Sh6sXIRRydQUx7JI0RF3OrGzdKYjDiDM7j6cTZDcVe2heiprOjVmMTtM8LbkFezwcovnhSLmEOWumAE9oRat6hlAYRfprCvYxpTx/sv5QBhG47b9SwFA83VlOnkqVj2puBxApiYR0z5q5GxLn3Cdfnfo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8936002)(8676002)(53546011)(52536014)(7696005)(6506007)(4326008)(38070700009)(33656002)(41300700001)(26005)(5660300002)(38100700002)(122000001)(2906002)(83380400001)(86362001)(9686003)(316002)(64756008)(66446008)(66476007)(66556008)(55016003)(66946007)(76116006)(110136005)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CSQ8XiczXMgSZb8oDzw9SINoTsaVIFszgp72abSirOPTdPatv09OzJDpgzXK?=
 =?us-ascii?Q?x6bjdw/GrgTzqUMvUhzW/Y/5LEzO8AkNgzQ0jxKM4bnrVtVB/Ow8fUWkRliH?=
 =?us-ascii?Q?2o5QeoJ2kzLOGXQn8B4Xklw1yhXc22g5AFIHwstr55wp+HV+JsHkwsJSdTPh?=
 =?us-ascii?Q?NP/awI289yNHIDKRXa5qZTavSaADE443+By2LoZRVrU1odmlt9+i4Vux6eQf?=
 =?us-ascii?Q?nnvQ2OtMR8a2KCUneADzwSK+oFAqBghkPei12ymbVuzow1qA5sxJ+CUXMj1c?=
 =?us-ascii?Q?u1A/t7MOP4e+RaVAlDzJbntvAiDn40kvVwUGN5Tm+Vr22zlJSfLQ0vOhhffr?=
 =?us-ascii?Q?sv512FDvbbE4FqUOwpua5oscVLFfPVL+3PPe/nrmyoM99k/Md3n30tPYLE0z?=
 =?us-ascii?Q?HCWJYTWYyhlRIktGoF0PGMwG4mgtylhylSiJIydHKFMJ5SJ4XzzJCnRC90x9?=
 =?us-ascii?Q?YIFeTYyzLjUfWsxLVgJu5+gKNndYomF/zxxmXnXJifLw0qKvO956I6WEyqhk?=
 =?us-ascii?Q?p7hFG3v6xTKpn/0w19dhlmZvk6cLByFR4naof/d+voq9SudcZQLOc6pFZ+g+?=
 =?us-ascii?Q?/r/UFGPeIU7MoLTedM/3+UwCj6EmRTLpsc95pfk2QXviOgN4tK9tpbw20vFr?=
 =?us-ascii?Q?7eR5WBO3zr2MAeXZfPDURbvHqMJMAHpummR8wvV/coYgldA1h/Cf3V3cVoed?=
 =?us-ascii?Q?Jtn27qqkFEFyKxMoOcdkTpgvjcCo3YwJ9o/vtIkzRR6oUrk583K6nU1R7zSe?=
 =?us-ascii?Q?bhCvSeWD54Tkxc6BkVxN9vjoPj4eN4UzBrin+nZp90yqsCvJQvNAmFFIKAvr?=
 =?us-ascii?Q?pa5ptUZQXEuw8bvaYGxW8efUQjKCm6QkCGIdsNoU3Y3XYyBJrCcGsTgv2v1Z?=
 =?us-ascii?Q?5n3DW5ivgLxX/YlgjD+h2g5oGjdowLP0huULyUtUCjwsfWTvaJTL7ipu0BBM?=
 =?us-ascii?Q?om1Ey9TcDoCKsyX9dyEKbix3TaxHGF1cNwMqVroAEldzYqMNqkr8+2TUelCJ?=
 =?us-ascii?Q?j/10SrHwxTtpTfkTOelPH0WmCXNjYZSegwXMtC7oCQCeFQfYfRNsJwur/dfb?=
 =?us-ascii?Q?T1A+l++TQV0PoP2bAx/p73z/GD1enBDCtUAD5+8ghRRx2YtkDPqlS366Zhzr?=
 =?us-ascii?Q?hafvyu2OaaTuDifdzAJhb+7c4J1/NQZSz5ResmPD+wMQSrCt8U/g6YFay8Aw?=
 =?us-ascii?Q?tAEqSARrO2jqPgyORs4Owxyk/Rk6Nl+OUEJn9PTvjIIt+eKX8rGgfnaKf4pJ?=
 =?us-ascii?Q?NoMiGuKEKfRa09Mfxb5vdzeIxKNuD4tEqhi++Oky/Cp3CL0gay5C+LXbdeUv?=
 =?us-ascii?Q?Kg9kJeslqGa16ew6QvyoDpq804AYKwRxaafkrUcofZkR7RQPbgNg5x+B7Bhl?=
 =?us-ascii?Q?7kxSBChCDTBWy6Cu/jJZuOJZfXs0Q5umXm68PlSzuPxyaBSiCj+0kC1zqYPK?=
 =?us-ascii?Q?p/2dGv7izaMrRsCUPpY7tBdrtszCO4QbgQGgBIENI9bYnVnE94LnV6ZwkRx1?=
 =?us-ascii?Q?7oBCNauu994Ae2A5zgIBTMB4aSPuKXZlsNYbv9SV8JD/9vGjz6bvC4X0Ao1O?=
 =?us-ascii?Q?ax/FHx2my49CsxcHWLM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1ddb87-7e32-4bc2-3474-08dc17fc4ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 08:05:56.8705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZxBGSS58CQsv4WekJNpgWc3Dwp0FwvnQzByLWyTXV65UV4fgglry+NwUBCoIkIJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Thursday, January 18, 2024 3:50 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH] drm/amdgpu: skip call ras_late_init if ras feature is no=
t enabled
>
> skip call ras_late_init callback if ras feature is not enabled.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5c817c155d72..5c73d0871220 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3312,6 +3312,9 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>               }
>
>               obj =3D node->ras_obj;
> +             if (!amdgpu_ras_is_feature_enabled(adev, &obj->ras_comm))
> +                     continue;
> +
>               if (obj->ras_late_init) {
>                       r =3D obj->ras_late_init(adev, &obj->ras_comm);
>                       if (r) {
> --
> 2.34.1

