Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2E5C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 10:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D87510E33D;
	Wed, 16 Aug 2023 10:46:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1D810E326
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 10:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAIUUErqj4ASdLg+AV0XWw5aExn1C8L+sACiu4BXc0quUOOofhkSEdGtzReIW1utVSjsfr7yNfab90yKPiworHt0k9Ln6fXZKFUcWIcMlYq/oENVu6d02MXl3oCBC4KFQkHmoiUz/BxJyHhuKm3J94/QMjerrz+bIOdeRozs4uUwb35rJLDkY/MzoSA1cIr0BUreGB0F14JD2Er4QCPXY4Aa93ffcW6sJfn18Fu9cQ7a12CRYPKKNuCiwuQ37vpVj92s705gBjZobicYmPNu1vl8ThOKGZh4zs816ipIFQ8KKdlunJpIXtdLg8y4CvOJU639z6rAMVqOtgSVO/0zYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xehIquvjgKRd3fOZiOJz+fF2HS7q35E/MJWq0R1a1PM=;
 b=KtuRR+3KiePZOzZRjzwQNcU/rmCyH1b2tiZ4wVKKdqYGkeSH5ml+kmfWOIqbLTIRTk6iusZthvx19JQrlDOXoUvsUX19VQMLSVr6wzBzCK+RYlwP5TJmTZZ0kupZVzVCg3fFbnKJ8lDdGjXfaJH4G2yjunz/OQnPJwiwx/GzsvovTDifrPQrdrsrZe4U9knb23Td/UUmdnAX8JmQFRrFDvfPeaiVyhK5wFQHkfRoQhcamqX0YgiL9OLZxK57EgQlMzzbkOvRgpB435mrBqeZKIE16RaHAlg3sMXBc40cBgWkGMkKw4akBrJDT3B+tDfKvgwPsospDdNkSHrT04ukig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xehIquvjgKRd3fOZiOJz+fF2HS7q35E/MJWq0R1a1PM=;
 b=Fz1iqn8CmexKZDCe4hfye0UUtBV8EHlSjMcZ7OXKNX9lXyeX3BCTak0CiQyJg0zodJn7BfI2FP6bFUYnIYw3pBS3dXgf1RGXZGgy7PBQFymQIVvfY1X9Wrrvhkn7U3cqYsUvKplQzJeCLUgvx5xwyMZtSsM2uzWBC3UllHmeTO0=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 10:46:31 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::22f:b841:22b6:ab25]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::22f:b841:22b6:ab25%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 10:46:31 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Keep reset handlers shared
Thread-Topic: [PATCH] drm/amdgpu: Keep reset handlers shared
Thread-Index: AQHZy4AYlcDdhyjexU66ZkW8zeA236/scKOAgABVmkA=
Date: Wed, 16 Aug 2023 10:46:31 +0000
Message-ID: <PH0PR12MB54043723199279F8D7B34BB3F615A@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230810114425.645209-1-lijo.lazar@amd.com>
 <BYAPR12MB4614C6590B454B912A0E5EFC9715A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614C6590B454B912A0E5EFC9715A@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0c1d767d-2bf0-41ea-88e4-543ea418c306;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-16T05:37:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|MN2PR12MB4487:EE_
x-ms-office365-filtering-correlation-id: ea3c4ee6-a402-43e2-749c-08db9e460d70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: al6oaSaI/OaoqR2usB+hYhIyCMn2bOHYIw9JGBoyEIL8oTX+cQSqJOmYclfYvx9Ie3fCqg+3hMIqvQl0MYuH+OHvYoPQyotK7ZqK3wVw+Mj1xS3zeeYx1QNwvYl+YhOu1twS+k2kc4/jdq2jyurvRH3/Mud7vORCEDKOcHI7KEXPRSg5X/gQaZ0T9xVP3AmRRLR7TrEzmpTerKm8ScVIYTDgEs0giPHmrTSfYD7AlwPO6fzUDcNcyCvmU7yXVWs8KdISZmKWiPUdKlAdkWVgIgBNCHL+vQoe05bdRQ6wfsC2EhSfJgdj0FDoIbV2pLSlT0jnKpZXVM0K41iwcvCrmk/TVK1zsEPfPiue55UgTA/uEFm1/ggN77oxZyUTK58hcOUiBz/0g0NWCIuKdkGeP2I2KDi6yzI76+aUqUI26wQGakGr3uiZfvs/p6gh6Jiabr6/B3gKXCt1FChYLtS1UsZDws0eMCUVj+11ST/EVk0Iv41Q2dxkddPikJVR4M/m/sj9eE/I5q1uec49G5o9/b+8H1eGGDs7xwsM7jPi/4algAOMEluu4PmRxUcOdjFq3sODEgEuOVxLg8yal8EmoL34ACBi/HSKmcfEKQh78Ef5BgCWwthBIOImijtj8dNX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(66946007)(110136005)(64756008)(66446008)(66476007)(66556008)(122000001)(41300700001)(52536014)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(26005)(55016003)(478600001)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PpYm2katSLf7fMs28lBoVUslidBM1oOBbtxFACYxEu984/btq9z1y6PD0nuS?=
 =?us-ascii?Q?9p5YXUVLx8Ec72femEK9fdeLY2emqGhukk5VNGuzyKgr4mwlMx07mazV18N8?=
 =?us-ascii?Q?aJq+nEYe9um1eHCXCmburhfbCukbDEbACl8S4zVNj1rjDFRmZlgnFQRl59tI?=
 =?us-ascii?Q?ulepotd5KGR2Vfzvrqsxumj0pxZq14O0p2Xm7UULFpIUBQX4N0LaXlbFsfVK?=
 =?us-ascii?Q?bVxsdlOnsrjJS/NVLxGYV9g/EXpiKDcs7ZmkiL3gAqjAq0lYr6ur/U3R4tdJ?=
 =?us-ascii?Q?zw/Hv7hKinayPRA7Q7mDcaxnPmfuNZBlXZmIqbggP6p+D5ttqeRpk69kEGOI?=
 =?us-ascii?Q?8CsH0cA7eWaOgSf2IMLSgdKz7aPf7j4AGGAKF6UXs+26iMGaXVXiZUopXYD7?=
 =?us-ascii?Q?fbUVi9cXu9ZWwlvKkx8N1DRuVcE75PDL4Jc8akiVOjcUu9WDaMagIK07XKVE?=
 =?us-ascii?Q?mCBWPCynaeZeXTlQasoqmqv7Yx9DvVsOXdrT6ReeeODANYSdz5UkF2/enmFO?=
 =?us-ascii?Q?sBk6aHC8Pist5bDpcS75FvTsXmIO9Ewoa+Xd3t/6ZazfQ6PW2Dfth6jgS3W/?=
 =?us-ascii?Q?jKSfm1dMF78GSV9CzqoivHUyfrQjAg+fIOi/2D6NmDe9V0t4S1hv2ASYq3CZ?=
 =?us-ascii?Q?b2EMN13z4c8avuadkV3xHRC5y9WUFwmgO+UDoRTgVOp2bzzfXSDiqz8Vpn4N?=
 =?us-ascii?Q?hXtRT4E/gR1CDvyQH0msKo96RmY0prnBStrfYS/DZEID1R27DNMQwheuqZu2?=
 =?us-ascii?Q?YRS3LXQi9ssBSiafzP/6AjfpY0htZt5bv2Skd6sF0pyrgYoWtG/1wchaBSpD?=
 =?us-ascii?Q?Hb8HA8rUHGzZ6hIPFKdGTnXnafettsfkn9maqxhTsCPHhIo4c/bD7fEhcVav?=
 =?us-ascii?Q?sNqioC82GlknpRfsPnpF7s7ctKgz/WXiwqYr89bJZExwbRvy3qjwIaV8wPjA?=
 =?us-ascii?Q?4NBILdJzs2jNSBjtfZ/hwZB9SzAgcXdwrvrjtYcRUdi2bGGtgcU5N5NSsgL9?=
 =?us-ascii?Q?Q2Q87J7+HzcdKk5cry8ESDd6eut6um1YyZ3xZmmsZ1QoXHmJUlKlEnkhn9Xt?=
 =?us-ascii?Q?qc+l8u1vFOc9R+Ckm+UYKOJOoKcO8KXGa1MWVXrxxUwZwBh6rvCiAeW6SwJh?=
 =?us-ascii?Q?dtEW2o9c0tOr8dLaer5CvLAH0q5PqScixZuhyO06o03QOwWWdYg6I35jlTt3?=
 =?us-ascii?Q?5Ixxv3yj/zFHgzqzulszsywdSCiLce7sMf6YsLvhp8glMha3TbN3dPMxdyIs?=
 =?us-ascii?Q?9JxIeQVVrIhJsrK5R1fRZLGuJNRW/VE4VB5U0xiLcrrpiEDr7NW5bfZ1/EPe?=
 =?us-ascii?Q?ImV9Llc+4kqhklt7HVGNa6MSqjVqKDY0+10BJBm7ygiRt24NMXvKnUjGPTGS?=
 =?us-ascii?Q?cwtYKyxr8bhl4sn/ZRhXOq3ATynbLXTB/nYLIiwcMqZcKvnzgK5/2WKHyU1a?=
 =?us-ascii?Q?FAwEXPOSczI3efmUs6SQ1X9ty5wgsK8UbBdt57vRSbFbFyhqsKio6bbYHY2P?=
 =?us-ascii?Q?M84Bjrh11eSw9cc564TdSWPoAsHDaI4ZntZQPHOo5nncR0s9kPsx1uNzoCUY?=
 =?us-ascii?Q?JZ1slntejMh0TtJKmso=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3c4ee6-a402-43e2-749c-08db9e460d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 10:46:31.3139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxl/ln+TUg+3S9OxSDvBZMBIwIEwsUMvRX+4KiLzRvjDcR96i1r1n9KiJ+4m6zDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar,
> Lijo
> Sent: Wednesday, August 16, 2023 1:38 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Keep reset handlers shared
>
> [AMD Official Use Only - General]
>
> [AMD Official Use Only - General]
>
> <ping>
>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Thursday, August 10, 2023 5:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Keep reset handlers shared
>
> Instead of maintaining a list per device, keep the reset handlers common =
per
> ASIC family. A pointer to the list of handlers is maintained in reset con=
trol.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 19 +++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  8 --------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   | 16 ++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 20 +++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 19 +++++++++++--------
>  5 files changed, 45 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 2b97b8a96fb4..82e1c83a7ccc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -48,20 +48,19 @@ aldebaran_get_reset_handler(struct
> amdgpu_reset_control *reset_ctl,  {
>         struct amdgpu_reset_handler *handler;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-=
>handle;
> +       int i;
>
>         if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
>                 dev_dbg(adev->dev, "Getting reset handler for method %d\n=
",
>                         reset_context->method);
> -               list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                                    handler_list) {
> +               for_each_handler(i, handler, reset_ctl) {
>                         if (handler->reset_method =3D=3D reset_context->m=
ethod)
>                                 return handler;
>                 }
>         }
>
>         if (aldebaran_is_mode2_default(reset_ctl)) {
> -               list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                                    handler_list) {
> +               for_each_handler(i, handler, reset_ctl) {
>                         if (handler->reset_method =3D=3D AMD_RESET_METHOD=
_MODE2) {
>                                 reset_context->method =3D AMD_RESET_METHO=
D_MODE2;
>                                 return handler; @@ -124,9 +123,9 @@ stati=
c void
> aldebaran_async_reset(struct work_struct *work)
>         struct amdgpu_reset_control *reset_ctl =3D
>                 container_of(work, struct amdgpu_reset_control, reset_wor=
k);
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-=
>handle;
> +       int i;
>
> -       list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                            handler_list) {
> +       for_each_handler(i, handler, reset_ctl) {
>                 if (handler->reset_method =3D=3D reset_ctl->active_reset)=
 {
>                         dev_dbg(adev->dev, "Resetting device\n");
>                         handler->do_reset(adev); @@ -395,6 +394,11 @@ sta=
tic struct
> amdgpu_reset_handler aldebaran_mode2_handler =3D {
>         .do_reset               =3D aldebaran_mode2_reset,
>  };
>
> +static struct amdgpu_reset_handler
> +       *aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
> +               &aldebaran_mode2_handler,
> +       };
> +
>  int aldebaran_reset_init(struct amdgpu_device *adev)  {
>         struct amdgpu_reset_control *reset_ctl; @@ -408,10 +412,9 @@ int
> aldebaran_reset_init(struct amdgpu_device *adev)
>         reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
>         reset_ctl->get_reset_handler =3D aldebaran_get_reset_handler;
>
> -       INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>         INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>         /* Only mode2 is handled through reset control now */
> -       amdgpu_reset_add_handler(reset_ctl, &aldebaran_mode2_handler);
> +       reset_ctl->reset_handlers =3D &aldebaran_rst_handlers;
>
>         adev->reset_cntl =3D reset_ctl;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 5fed06ffcc6b..02d874799c16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -26,14 +26,6 @@
>  #include "sienna_cichlid.h"
>  #include "smu_v13_0_10.h"
>
> -int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
> -                            struct amdgpu_reset_handler *handler)
> -{
> -       /* TODO: Check if handler exists? */
> -       list_add_tail(&handler->handler_list, &reset_ctl->reset_handlers)=
;
> -       return 0;
> -}
> -
>  int amdgpu_reset_init(struct amdgpu_device *adev)  {
>         int ret =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index f4a501ff87d9..471d789b33a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -26,6 +26,8 @@
>
>  #include "amdgpu.h"
>
> +#define AMDGPU_RESET_MAX_HANDLERS 5
> +
>  enum AMDGPU_RESET_FLAGS {
>
>         AMDGPU_NEED_FULL_RESET =3D 0,
> @@ -44,7 +46,6 @@ struct amdgpu_reset_context {
>
>  struct amdgpu_reset_handler {
>         enum amd_reset_method reset_method;
> -       struct list_head handler_list;
>         int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
>                            struct amdgpu_reset_context *context);
>         int (*prepare_hwcontext)(struct amdgpu_reset_control *reset_ctl, =
@@ -
> 63,7 +64,8 @@ struct amdgpu_reset_control {
>         void *handle;
>         struct work_struct reset_work;
>         struct mutex reset_lock;
> -       struct list_head reset_handlers;
> +       struct amdgpu_reset_handler *(
> +               *reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
>         atomic_t in_reset;
>         enum amd_reset_method active_reset;
>         struct amdgpu_reset_handler *(*get_reset_handler)( @@ -97,8 +99,1=
0 @@
> int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,  int
> amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>                                struct amdgpu_reset_context *reset_context=
);
>
> -int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
> -                            struct amdgpu_reset_handler *handler);
> +int amdgpu_reset_prepare_env(struct amdgpu_device *adev,
> +                            struct amdgpu_reset_context
> +*reset_context); int amdgpu_reset_restore_env(struct amdgpu_device *adev=
,
> +                            struct amdgpu_reset_context
> +*reset_context);
>
>  struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum
> amdgpu_reset_domain_type type,
>                                                              char *wq_nam=
e); @@ -126,4 +130,8 @@ void
> amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain
> *reset_domain);
>
>  void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain
> *reset_domain);
>
> +#define for_each_handler(i, handler, reset_ctl)                  \
> +       for (i =3D 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
> +                   (handler =3D (*reset_ctl->reset_handlers)[i]); \
> +            ++i)
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 8b8086d5c864..07ded70f4df9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -48,18 +48,17 @@ sienna_cichlid_get_reset_handler(struct
> amdgpu_reset_control *reset_ctl,
>                             struct amdgpu_reset_context *reset_context)  =
{
>         struct amdgpu_reset_handler *handler;
> +       int i;
>
>         if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
> -               list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                                    handler_list) {
> +               for_each_handler(i, handler, reset_ctl) {
>                         if (handler->reset_method =3D=3D reset_context->m=
ethod)
>                                 return handler;
>                 }
>         }
>
>         if (sienna_cichlid_is_mode2_default(reset_ctl)) {
> -               list_for_each_entry (handler, &reset_ctl->reset_handlers,
> -                                    handler_list) {
> +               for_each_handler(i, handler, reset_ctl) {
>                         if (handler->reset_method =3D=3D AMD_RESET_METHOD=
_MODE2)
>                                 return handler;
>                 }
> @@ -120,9 +119,9 @@ static void sienna_cichlid_async_reset(struct
> work_struct *work)
>         struct amdgpu_reset_control *reset_ctl =3D
>                 container_of(work, struct amdgpu_reset_control, reset_wor=
k);
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-=
>handle;
> +       int i;
>
> -       list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                            handler_list) {
> +       for_each_handler(i, handler, reset_ctl) {
>                 if (handler->reset_method =3D=3D reset_ctl->active_reset)=
 {
>                         dev_dbg(adev->dev, "Resetting device\n");
>                         handler->do_reset(adev); @@ -281,6 +280,11 @@ sta=
tic struct
> amdgpu_reset_handler sienna_cichlid_mode2_handler =3D {
>         .do_reset               =3D sienna_cichlid_mode2_reset,
>  };
>
> +static struct amdgpu_reset_handler
> +       *sienna_cichlid_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
> +               &sienna_cichlid_mode2_handler,
> +       };
> +
>  int sienna_cichlid_reset_init(struct amdgpu_device *adev)  {
>         struct amdgpu_reset_control *reset_ctl; @@ -294,11 +298,9 @@ int
> sienna_cichlid_reset_init(struct amdgpu_device *adev)
>         reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
>         reset_ctl->get_reset_handler =3D sienna_cichlid_get_reset_handler=
;
>
> -       INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>         INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>         /* Only mode2 is handled through reset control now */
> -       amdgpu_reset_add_handler(reset_ctl, &sienna_cichlid_mode2_handler=
);
> -
> +       reset_ctl->reset_handlers =3D &sienna_cichlid_rst_handlers;
>         adev->reset_cntl =3D reset_ctl;
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index ae29620b1ea4..04c797d54511 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -44,10 +44,10 @@ smu_v13_0_10_get_reset_handler(struct
> amdgpu_reset_control *reset_ctl,  {
>         struct amdgpu_reset_handler *handler;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-=
>handle;
> +       int i;
>
>         if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
> -               list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                                    handler_list) {
> +               for_each_handler(i, handler, reset_ctl) {
>                         if (handler->reset_method =3D=3D reset_context->m=
ethod)
>                                 return handler;
>                 }
> @@ -55,8 +55,7 @@ smu_v13_0_10_get_reset_handler(struct
> amdgpu_reset_control *reset_ctl,
>
>         if (smu_v13_0_10_is_mode2_default(reset_ctl) &&
>                 amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_MO=
DE2)
> {
> -               list_for_each_entry (handler, &reset_ctl->reset_handlers,
> -                                    handler_list) {
> +               for_each_handler(i, handler, reset_ctl) {
>                         if (handler->reset_method =3D=3D AMD_RESET_METHOD=
_MODE2)
>                                 return handler;
>                 }
> @@ -119,9 +118,9 @@ static void smu_v13_0_10_async_reset(struct
> work_struct *work)
>         struct amdgpu_reset_control *reset_ctl =3D
>                 container_of(work, struct amdgpu_reset_control, reset_wor=
k);
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-=
>handle;
> +       int i;
>
> -       list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                            handler_list) {
> +       for_each_handler(i, handler, reset_ctl) {
>                 if (handler->reset_method =3D=3D reset_ctl->active_reset)=
 {
>                         dev_dbg(adev->dev, "Resetting device\n");
>                         handler->do_reset(adev); @@ -272,6 +271,11 @@ sta=
tic struct
> amdgpu_reset_handler smu_v13_0_10_mode2_handler =3D {
>         .do_reset               =3D smu_v13_0_10_mode2_reset,
>  };
>
> +static struct amdgpu_reset_handler
> +       *smu_v13_0_10_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
> +               &smu_v13_0_10_mode2_handler,
> +       };
> +
>  int smu_v13_0_10_reset_init(struct amdgpu_device *adev)  {
>         struct amdgpu_reset_control *reset_ctl; @@ -285,10 +289,9 @@ int
> smu_v13_0_10_reset_init(struct amdgpu_device *adev)
>         reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
>         reset_ctl->get_reset_handler =3D smu_v13_0_10_get_reset_handler;
>
> -       INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>         INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>         /* Only mode2 is handled through reset control now */
> -       amdgpu_reset_add_handler(reset_ctl, &smu_v13_0_10_mode2_handler);
> +       reset_ctl->reset_handlers =3D &smu_v13_0_10_rst_handlers;
>
>         adev->reset_cntl =3D reset_ctl;
>
> --
> 2.25.1

