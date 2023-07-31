Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07993EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 01:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D0910E0B7;
	Mon, 31 Jul 2023 01:41:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD52710E0B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 01:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9EUOMcGBhxCeCxWeY1+a088p40sQ7PzRIYH69gnFgylGRtCHvhH74XvGAfXcucTACATcTAwnqxiktwaaLW3PKHRLQMoP4ieaogj1Cj4zfMgHxJ/2Rm0MZoAYgrHXl7GqgzK7CSggQnrTEX4jN09CNqv18/OSbSNqdebCUqA2AXbHVwYM5sZZraU/oTyQ1VeMgfVAVawbn2KXPh5QIYjP54rYA3uuSA+4YrfZWWIKxkWLJljtp/LqG2bc/V84L90ZeXNFA//RiNQXHscGfdZxn/GTOOOOGbEc0Ye0smj+tin62aPOJEm3iLHClXOGy6SNgw+bkX9GFDZL4l50IjT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYNpWfzPzmKNXkJTthddgDNa8iM3IOmQCwJLYtIzAdM=;
 b=XYWzz4gzKKTR4TlZFK7j25QwEwb4mPAdyJPVQVJQlpE69E27Sv+bqJl5/JOR9n9wmL6rLb8goCaeQlLF0+yY0LWtbr05nBB2XXeWDYVszoH73/abhQbGDBdWSNygtnotCB7vF60CSUU1Yf3EpE1WGzkDLdIsa+HCdXY+7/E86Jn6Vk/aInHHXFTSc1QlkDLZl8iO5TRqb3zec0ds14QDxa8pam4v5QM5RCNBXY9u5jXTZqpTss7Q6vgOEhiQQLQCcTnrxtTY02jvzTsrC3lW3Fp3/OakGdAO35O6gT1JHZRK69qKFQvSX3hJhXcZ2f7BWunanVIsgp8hKVf49IAJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYNpWfzPzmKNXkJTthddgDNa8iM3IOmQCwJLYtIzAdM=;
 b=r6blGn8NqA6YBkIQdqMdZ4eWQ2AYn54jBsYT8YFoMHcJNY7n36Pkm4WRT/Mowm7ZgMyyaN4IgpSPFYtN0jtunDd5mBAeeSswUYSRO3FeUyx1v3xLbb9G0C76BUiIsEC50twGCaB14pPa+5SKsDCj3W6QUF3tL5Igko4cIj1v0aU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 01:41:38 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 01:41:38 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
Thread-Topic: [PATCH] drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
Thread-Index: AQHZwWdt2qmv0Qzvq0mgXOy77ZuVPa/THTmw
Date: Mon, 31 Jul 2023 01:41:38 +0000
Message-ID: <DM5PR12MB2469E784A786056B85067B85F105A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230728152248.3290911-1-alexander.deucher@amd.com>
In-Reply-To: <20230728152248.3290911-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f61897c3-2001-4b1d-8400-ae8791d8bdb7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-31T01:40:45Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN2PR12MB4304:EE_
x-ms-office365-filtering-correlation-id: 68319631-5249-49ed-5a96-08db91674851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1FQd+16QnHBBRkrcGmiakYjaB8hPJFzueJ0WHu+mrej1IqXO3a5phkGd8KgI+Dsb2y+EmClx/RyLTkwB9voDC+4cwAR2R4iyWDh9KeEsolh5rTLFNCGCvyfs6Wsq8VMKg0i2h25G0vDAlrEzNBwXonxX2w2Mj/m3ZCjjf0jm83wxmmalIJtwqLNd+UI2ihS2tYyealQPI3s4lGs+TVsC1tMBZgfHv3iSO2qhjLUezPtJ2sLFA0eqEhnAWqc/Xa6POg8iWRaNhMelHvBDBUfIFQdW7bshi7qTMcE2gIeoWMFWGICcaJRCAJ1IMMhTbXh53NC7yfDmjVzFebkfjRPq8Ex09kwbJuVd0tSQZUrZ0XRdakj/jU6L7up3FTHaPXh8x/ZefUmDmY5LQ4bTc6mWahmdgWt/g0tWobrl/xouNsdzwP1KTDZTDBOERHj06+cfs+1g8xvhHmCq7Mu53aHa8z/LK7SArNAfO+rA2Y5l269WobLaOjwERpSTn8SbtQafoQjqTilOwIzqWdthemZaIJ3mmI728J0M8Lom5uFvlr/v0eUaHuoxr+gTES0OWhDp5cGdRAMksuom60FtupQ5l2bZa527qs839S1WXeuX2qYRbfecZF9ToXr/PeKQvqF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(38100700002)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(478600001)(71200400001)(7696005)(53546011)(186003)(6506007)(26005)(8676002)(8936002)(52536014)(5660300002)(76116006)(4326008)(64756008)(66446008)(2906002)(66476007)(66556008)(66946007)(110136005)(41300700001)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IUZO9mOh9hBH68fP0G9H7YN4OZBi7SsgvJA8yv2s0u3GKsJTd5Ut+ohgh0Ed?=
 =?us-ascii?Q?hYrXfg1K+pR6ToIdVI/IIB2oH/jbwRurgDdfzpgCkzb4MPHcsWpkgikx/ZKd?=
 =?us-ascii?Q?VNCrGA7YMXOgLKFPrgxkkDVYP+x+1EEVx3cZuu4vXvJrYAokZB6H8SdeAhFh?=
 =?us-ascii?Q?ZzjD3Rvju9TqWyuRzNHkyfNvw4Cpk8DUDW0jk4hUDlBmv2aFBK5BS6QeP12q?=
 =?us-ascii?Q?hbqdexLp8zsBDHec7ULdpctyDV6BRbPomk9V19d+VB+HJr9IG4P7zGxzeB0O?=
 =?us-ascii?Q?ZMWzjEBPOSHsIPFFSD00QoKAp76G9TOmgg+MUuHXruWhr9eusBvBzFtWUrSq?=
 =?us-ascii?Q?KG/eFb3NXvBOLKJfBiU7l1lsjf4cG3PHNdYx3od8valLp4uvtPs/4atzlqk1?=
 =?us-ascii?Q?5+/Mk23hH9gVmoUl2nHEkp4FAodwpigTMraOoiUikCuIKU2SvhUSdLNme6sP?=
 =?us-ascii?Q?vJN1JpEvfhBHZH8qKxF9a1OcjQt6cfs1rnOLnqGAVO7mebutUmDVli8XG1XA?=
 =?us-ascii?Q?5DUPauWuKzMm+/Njxq2WA7EgqFmHaPw15avz60SsD++yuIf9O24pm/LfwRp7?=
 =?us-ascii?Q?06TuuSlBIXR7ZghM8FXyag8gF+fRXj7iM47Keo2sjgjVd8Z5wObpRqKfXop8?=
 =?us-ascii?Q?lvPGAVYSRepcGhAWxd2oHzHhEt2vAf+L9II5ni4TFux8PuBB8szeUADn4djG?=
 =?us-ascii?Q?nG8uDqEgIWpMHpMV4Qlbg4sIEd1Sgvh+Km5wKlBfZNgozSu4ZD4YEZ4cYF1w?=
 =?us-ascii?Q?bWfku9eDad7PgUiXhudhrrzOWpwdoVY1tlQcHQAQTpP4rGbWhDHNnDRmVh8A?=
 =?us-ascii?Q?2qCrvK49YxjMC2cHP5thsqV5urAsC56jxQHdeYSnv4bJd9Xgduq4cnR3D8N7?=
 =?us-ascii?Q?CrWSI7RMylDFBIjwYEbgPux6YbLk65nZp4f2++Oke4DGWGWteEGgIaFSO2XF?=
 =?us-ascii?Q?g2XdmidxladD5Kpq4kZtV94dAHXZVgQEae2WuaZ+tn25gdQh7ZnfIYc6Y8eb?=
 =?us-ascii?Q?0lOOpmXMxlz6SMF0dAbPxrcwHLktRgEoenbO6iq9WHszG8XQfyJXCr3Jbv1S?=
 =?us-ascii?Q?14KM2d7bhdgBcaGzJuX+qjQyiEul1PNeY8FLUyJq1LM+e9U81xxOLGZ1i4TP?=
 =?us-ascii?Q?FeSw2EgCbKz/zEitxgRcsb3wx8t5B4eCQ1h1ViQHWG0siojbeBJS384QichH?=
 =?us-ascii?Q?TZZUKlnPil0M6KKW0+1CNZ9WSoWK4MaQOuN5lc2VjY64m3bB/hooM2x2Cr5w?=
 =?us-ascii?Q?DaopejJfyCxTM/+K2DzH5HB3MAhyNQVelnjjFrTKKMzpujthu61HXsRUxgfj?=
 =?us-ascii?Q?SGx0ix4xgmYFYlk4WCWuM7Wmra/aJaMxHnB4HucUvdkZ4DaVOo2n1EcEABt0?=
 =?us-ascii?Q?0E1t379tL/Y8+Tr1eCsqLqbzwRmja45hWYAKev2LScOXfynOhUhRJjh/b9zP?=
 =?us-ascii?Q?oYUbkzvRiqO6MjkpfbQ+GrOAqbwOaoVdAXf4Onx5by7x9sbqvPF52HpOjMqf?=
 =?us-ascii?Q?wGAuCT9GsyKgbQIdHUcjEg4/yXHc3cYsH2MYiy3eSEwqo1rY5miwdrs7cPy/?=
 =?us-ascii?Q?43xwbem5LYEN02ZHoaQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68319631-5249-49ed-5a96-08db91674851
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 01:41:38.3699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziR6EqkbfVfPQ4IUS7PfEC4c/E6PChyDix+BqWPdCcJjHKZgfNqajlLU9OYA/z/5nX7uEbExeGaFRsxJ5dOKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, July 28, 2023 11:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
>
> Since the gang_size check is outside of chunk parsing loop, we need to re=
set i
> before we free the chunk data.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 040f4cb6ab2d0..fb78a8f475879 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -295,7 +295,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser
> *p,
>
>       if (!p->gang_size) {
>               ret =3D -EINVAL;
> -             goto free_partial_kdata;
> +             goto free_all_kdata;
>       }
>
>       for (i =3D 0; i < p->gang_size; ++i) {
> --
> 2.41.0

