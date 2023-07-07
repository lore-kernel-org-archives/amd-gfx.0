Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DF6EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 15:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12B910E5AF;
	Fri,  7 Jul 2023 15:05:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2125510E5AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 15:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW3ck/cp3C+H9DCDOJ//iFQpIAkzqeHe1gyjucSmpjQ0I6LJzAYQhlWN98Ohco9VtI2qCXHOvh9aDbtVfNIFqcuHgIOqQ3RPt52m6/2xWM8nBTFKE/P4F/ovatgMYR8fITpZ8aarae6HWoSJuJ7AR1WLqSZBedm9VJ+4vC4PJYmw6cksteMop2Qa3EHw2p5fDUERzACMz6daWOUW9fVcWaL6GEh7E0aGZNPYgnRcTvciyCpinjdLKzGSGauyWsoK++OkFNub44aY/FtnxyuIktihq41Y7ze033HzQcz37fRpuqdgZuuFHzG0qtycdcBC0mh+vQV8VDAOOuKR+8bdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mU+dVQaisMELXUlw3vphJJwTUxXd1oWdSUAidVzPos=;
 b=nGLF5B0DAlZ7vLsYuqY4oAJcc9nhxbWdVi0l2qOQIJR7Dr2uKGqzSVVPglpHiwZ1eFFTj27aYWp4eniJy+S2msFisP2VwhdTT8iX7SHvkFveQF71PjwI+kiSqn8FZ6UYMNbeaU0OobXnepuuim9EKOS59or/P+f23Nz2kuUH6FDU0UhbYVZzhnb5EZNGRcnqnqdLONqB8KyPjc/IGWyoG7L69WOH5ha1QVgqvOw1jF91KWkAQtOnGHl9033fk43jTxo/RgbUFHKvHxUpdtvK6Aox7apr+bhN08M/AKUN0ORoWmf3AsH+K0VmpbRL7FdBs+AfTVikZVHz9zjTDyrwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mU+dVQaisMELXUlw3vphJJwTUxXd1oWdSUAidVzPos=;
 b=wthgmfrH09iqmeyLdomBsEvDxx2Gkrbix56UY1vMFTy4Bm6Okk94LR/VqvWROMcE3sSI5SYO2GbOveh5OoXXbKbOh2kXWZSfTNTiYNUmSUvwAkvnaPWzQWSiARUUoY30VzWH4oc4PAyxt5j2WNTpovUezTYLHHvx14DF6Y/3Lmc=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:04:57 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 15:04:57 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/6] drm/amdkfd: enable watch points globally for gfx943
Thread-Topic: [PATCH 3/6] drm/amdkfd: enable watch points globally for gfx943
Thread-Index: AQHZsDZyAJDcqM2AAUimrWTebuTM/K+uaB0A
Date: Fri, 7 Jul 2023 15:04:57 +0000
Message-ID: <CY8PR12MB7435B88718E336DDB77662DC852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
 <20230706181918.189722-4-jinhuieric.huang@amd.com>
In-Reply-To: <20230706181918.189722-4-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=28ae5bf3-137b-4cf1-b072-d9f0a8a6012e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-07T15:04:37Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|IA1PR12MB8407:EE_
x-ms-office365-filtering-correlation-id: d7f8292e-f668-4485-9607-08db7efb8761
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ReMvH6D3P1cIJ+16vJgL5+ARr/pkpINOmFAg1FNaUgT3O9JtHNoKg0Wv6MhCtINdiOE94ayFOwfujFsjHTANGgeLbnBKby0nukMAlIcVosaqU4IaB2FhqFagTrUR6O1I3hcNazo94ch9pWlr3CCD4e/NhfR5vb2W/XMPEVQFRYr280AxHOCxxaQpz/zClEey9UdM+7aUGav9bmQ1VBB+pmP1DlRUxE7nUKGEZYaVlSRzDpQEtywYLHgsPutFiigQuNcc2sD738xc59s8dM7InzOaS/0TcligLlMCOcyjEBf4dihQzAhW/Gw5odhB/semKImPiD6QvohzGAW0ZI+amhI+QX/pY1SA2KF4zND1vVfyaRkdsWmSshXv37hLkqRv2l/3XbFzqBNug7OtG6OGZ1z5iAfUc8KwkNTiR7Tj01JmYRdKx4jzGOA4WH+yLj2auCNOqJppQ2TKo9iNBQ63sXMrWZwc3PoGnlEPxD8mPKTOciagqv0SQ2wOZdN910DqGQlILeUJvcYIMka7S38vcDOce5vfQ/S7En1K60PF4zFIzy5u3NqxCIlM3ef32Kx16Cm+8eITGm+ClwIdPPg7bmdGc7KZ9YxS5FL8gJWRQ4TL98Vic5Q5dJKURVQ+DyFW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(7696005)(478600001)(71200400001)(76116006)(110136005)(83380400001)(33656002)(86362001)(38070700005)(55016003)(2906002)(66946007)(186003)(53546011)(6506007)(26005)(9686003)(38100700002)(122000001)(66476007)(66446008)(64756008)(4326008)(66556008)(316002)(41300700001)(8936002)(8676002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MeY4zw6AgBWDf508BecGATPvx4cVghjP5OAwiZFvqbPIUhYBoAo2GVHzN2AT?=
 =?us-ascii?Q?/phak+3cdkmocs+NxctIRJXKiKlKN3FGJ0Jg6alboV2R1xbDYUT2SQLz9YJD?=
 =?us-ascii?Q?30YU3liSHOA9+0tHMiT/VVoVHUZPm/ohrtiONZNClme7ibJNDSNIoD7kNijr?=
 =?us-ascii?Q?ifZl0HrYZRrXR1hJh5icltwvzEFlFtnL/Tb8Io3w7rJw7mOOfsE+izJWvRKK?=
 =?us-ascii?Q?tCZpdpZAr+eWTaIY+PfE0hndxLIwolkpE3veIDEeXUPgJeDIVUsKS0bT4Zgp?=
 =?us-ascii?Q?npxbfzB+/y0TXtfV+g2C374a+4+QZPrwQEWe7HsRYTF8GenMfcEQUF+Pl7RT?=
 =?us-ascii?Q?lwgYrPIRup3Mif5FxkZhMeqk2XBfoZnOg1OON4zY+4q7Z/T29VCJm32yMES1?=
 =?us-ascii?Q?iV+M9OCc/YpJuxavNAu9UsdlMoxKzqOhv8E3N8Ee6b8aG+5Emnx0srP3Ntlj?=
 =?us-ascii?Q?cdI+23v2mGUkqekwge0pUe7Q2tIlaO6G+JLqNbo4/SCIF62Fu7FkfbqxE+dP?=
 =?us-ascii?Q?Lh+LhoBWrRzg85AVLLjLtK4m3uiuyGkPDqT2GZQQCEvH52SEkRKWb9r4SNDB?=
 =?us-ascii?Q?RAWHJF4dj6Kp4UpGteAgEBPRCjJhQ4o9grGDaCyUVYnIrwLdLYA1fZMv45uH?=
 =?us-ascii?Q?kIan8ldpJiXBbPZGS31d9AADsAepbFAKoNv44cd9KilNj0C6Npu1iLCsrsJW?=
 =?us-ascii?Q?57YvYR+4wmLt22+7TiNlwodZ6KQeSpCr+Tbt/bB7ENP96qFiOqmt4OtOLhkC?=
 =?us-ascii?Q?Nm0blr+CtK2UrDdIaYkKnxsZ3hM5IfFExJcB1cyif+a92GzWhSUUnVORW0UP?=
 =?us-ascii?Q?RC6WLdm0iMVZdt2/CprvdLWjRs/+KA+fl+eYuWGuL1CwkJSPB7v/RKB3nBk4?=
 =?us-ascii?Q?TYmb1L4i+8ToGnMzwKhCfhcm2WmNxjcgBfGPNDDUThiWTnwMTwzkk8WkXJxQ?=
 =?us-ascii?Q?m5iiZzMcRfn/iJYYzw3JH8R1cwvwGoDmmnB43Phw5tzYJ3uRijjWzVuD358j?=
 =?us-ascii?Q?5Tncjkc9o/9ODcTRcPyrZ9j8Qbg/catJ4CHRtMlgWbBy2MPgztAh8k80m7z9?=
 =?us-ascii?Q?jJYwCr2rckE1pUGB/KR8W74amhupoBejknN+v6/Z/cyUMjyFubNVD3MnToQz?=
 =?us-ascii?Q?fqiV9mh+Dq4JpqaF91Qrq3C6OwRCFetipMrW2iyMWCUwu6LByWa4zsQ3xvMR?=
 =?us-ascii?Q?veb7J+ZxayZYOZW5TgDusnw6W+X6FhKJeCLvhJBFwzr05U/h9kQWZhWeeORP?=
 =?us-ascii?Q?YQu/+hWRI+1XcbE+iiDFSvzmpBVmXSXh1rIWTyfGnCrOJ/C7Cm7uuNh+Dh/D?=
 =?us-ascii?Q?OqVvjHCJJPxemoFjneLpyQ7DGYxyJ12QG40N47rjmbG+45yP1zoCpz1AI9h1?=
 =?us-ascii?Q?qknfnl4lOMa9ZPfaj+C7Y9lXRrqmtDhMWxvbQKXM7gOy2IU3EMhRXGBFh8sg?=
 =?us-ascii?Q?r+el2P6ma3CmPan9E8sA+gt5tojFG144ZacqIp0lj4dYeMcKmNTIf/afpCgO?=
 =?us-ascii?Q?wmQvcfxIEWHcjR8wAEsDwFO87k0wHst6O9c7qlCIHat2TSB+1QrphHVk1uB9?=
 =?us-ascii?Q?glo+Mer3NrVwhlNyV+w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f8292e-f668-4485-9607-08db7efb8761
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 15:04:57.5861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmE/KHrWPkEl8CGMXBbxyVug6FOG6yqNOHdaOiEyzYOssONrXKK6nnedinZ3Hejo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Thursday, July 6, 2023 2:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 3/6] drm/amdkfd: enable watch points globally for gfx943
>
> From: Jonathan Kim <jonathan.kim@amd.com>
>
> Set watch points for all xcc instances on GFX943.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

This patch is Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 24083db44724..190b03efe5ff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -446,7 +446,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
> kfd_process_device *pdd,
>                                       uint32_t *watch_id,
>                                       uint32_t watch_mode)
>  {
> -     int r =3D kfd_dbg_get_dev_watch_id(pdd, watch_id);
> +     int xcc_id, r =3D kfd_dbg_get_dev_watch_id(pdd, watch_id);
> +     uint32_t xcc_mask =3D pdd->dev->xcc_mask;
>
>       if (r)
>               return r;
> @@ -460,14 +461,15 @@ int kfd_dbg_trap_set_dev_address_watch(struct
> kfd_process_device *pdd,
>       }
>
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> -     pdd->watch_points[*watch_id] =3D pdd->dev->kfd2kgd-
> >set_address_watch(
> +     for_each_inst(xcc_id, xcc_mask)
> +             pdd->watch_points[*watch_id] =3D pdd->dev->kfd2kgd-
> >set_address_watch(
>                               pdd->dev->adev,
>                               watch_address,
>                               watch_address_mask,
>                               *watch_id,
>                               watch_mode,
>                               pdd->dev->vm_info.last_vmid_kfd,
> -                             0);
> +                             xcc_id);
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>       if (!pdd->dev->kfd->shared_resources.enable_mes)
> --
> 2.34.1

