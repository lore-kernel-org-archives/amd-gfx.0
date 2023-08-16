Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA35C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 13:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C847510E0B0;
	Wed, 16 Aug 2023 13:20:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611D310E0B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 13:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpLWtah5MVvnXCN4PCiEOX1IG749Brscbp/S9wDhX4Qtdy8XiexUXB2uCbHHMv8NDsdcG2kt2I6EuOt3GWONCMEKWE/3RXl/jwRYKNPujtoymlOTFYGmwz7itkqAho6S2XdEqXv0AGCnSf1evxh2maLlTOQW2t19YkOhJ2TCHprcVQsygHAZ1VFSMROWZZm1IcO23Tv1B1JYAbI42uHWz6KJzc9UCirINaKAGTdlLL68KA9e/w88a4d7I1Od6bnmwA/spJdAz47ppEF0KbwyADZzSwdiourbIbT4eK4RmuEjUPcze6LRlKc6MSqjx6Nm4JS/zd8zALDSmub8DYkQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTm8w4KYexiIAwlH66JC/wdWIBMrTmfopVUSm92JqDw=;
 b=QOjRmO0i8cA/vOsIuGUDyW1bLib+9lrFYyCbv/nSKs4Jd5cRqpwFda65ZrrMcD1ITtE36xUcUA+YTqHJyw638YgBQ67NnujGnsDlAz6V9G2LndBH8sh0y6tfLnGOrRpBjMuxBKOJYTz5QJIMtX9xBYtcMga+0YEZmpOPk8G8K6YsJS4rcYZj24uxNMMTuRsq3Mw2BQv56nhMWh5XeFfpPBChqz6hH8QVYu0N2K69WtA1dc9Id3p7rGwoxy7nm3vGHW3sgZpmrkB7eGGH1xw6omQOeE8nmo3Vw+G4TMQnUSdATSPXh1Ual5gsvlHv/Fd4knc3bLGyVgCeruyRVcDjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTm8w4KYexiIAwlH66JC/wdWIBMrTmfopVUSm92JqDw=;
 b=C/dkPMY4/b0q6DEOnP9lV8DmixX56HASmgkSXKCR8ymz+rKpH+DLwmC7CvRhyycSy70ZkTmXbxsjAav9k5W1aA1fXJrQZGyDpeLuBnwdqTSLs2Ik8SHHe+2z0oC07P0IjpMc2NGur6tGe3bfwGH4XaWpvXulusiatsyahz49f2w=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 13:20:34 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 13:20:34 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Keep reset handlers shared
Thread-Topic: [PATCH] drm/amdgpu: Keep reset handlers shared
Thread-Index: AQHZy4AY5spGA1i58E+9Lw1Xd8ursq/scKOAgABWMoCAACrkkA==
Date: Wed, 16 Aug 2023 13:20:34 +0000
Message-ID: <DS7PR12MB6071F77C2AA7382E206CE7778E15A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230810114425.645209-1-lijo.lazar@amd.com>
 <BYAPR12MB4614C6590B454B912A0E5EFC9715A@BYAPR12MB4614.namprd12.prod.outlook.com>
 <PH0PR12MB54043723199279F8D7B34BB3F615A@PH0PR12MB5404.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54043723199279F8D7B34BB3F615A@PH0PR12MB5404.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|IA0PR12MB8225:EE_
x-ms-office365-filtering-correlation-id: 61f262b7-8387-404a-2853-08db9e5b92d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yesarwBsliay0D0bx9YxGu8aaUNvs3vj5L/2+3c9w8DHLHzmQ5Jppt4qDgn7eSSibib+tlpAEg5f8r4PSVVaKIK4XsrrK0qqk4wXIywMbOyPizBVKE2scJhd1L3y2mUsjE9uIboR6XhJrt+f1Kv/DUdgrtsWeFVAg+lanKvzbTLHgwqlbwhqjCfdHdqXywQ32FiVJhh7hkvVuuJ2nMoaCDgsn861Rbf8HAxTNr5t7mXm6acsxXHDC+c81saPO+n/+Atv1QHc6GNt3rSM9XUct6LOmp40gyNXb+lEZm1sEQeTcSwQ2f2rkYjtoeMTUCM1FIcQIPBuee4cyp/4SelNSvl7MDuKjuZa5FNqObYn+k9o68oLJhTaFYi7JciqCVTILlMeFNTVGOawNjn8D+FZz/PUzIvm8WaThurH2XvznRpUHLi4dHmSB7C8c2M+6xiSJmtjbvd8Vd0tm5HW4ayK5l/Nqz08JgBvf3cjAjUanCHGa3NRxmUPr6NTIxNupJOITyazCfU5GS8Oa1XHJvlVOY1mI6wgCoXU2JEsBG8AaIUSRXBR3O68UZSodR5xRApv9N9L2YQNCt2k4oCpgLH0J4LoAZLfSKpIgA9RaLfd/1hFaAk2xg6081ygSn3kZWiz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(66946007)(64756008)(110136005)(66476007)(66556008)(66446008)(122000001)(41300700001)(52536014)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(26005)(55016003)(478600001)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wG/oTpz3fYpH2el1cXgS0yjlWgrh7X91s6HXnIsZmBHgC0owwjZEVAM0dnwT?=
 =?us-ascii?Q?lO/69LdBKtD0yWD/FdR5RYenCectB0NDQmWPWqj611Ip2Br0Rl2x+PxJGLYc?=
 =?us-ascii?Q?ZsVzU6KrQWlBPzGlqTspC7mjPpqxC07Yk10fX9PZT48S2ioUyhTydGLPk9Iw?=
 =?us-ascii?Q?BfVIpDYQRS+MQ0BgOWm8QH+HsLCxJbFVUcFskMC6UEfgh8URiv/ei4en+HPb?=
 =?us-ascii?Q?tSWTX3qIQGK/pB79wA5rkhIZ6O1G9H3VGiGcNNwj+M3pSwneIS+m3aHSohhC?=
 =?us-ascii?Q?WXJIzAmDXONzRs2JrPAtBeKlgms7x+nw6seRrtjN38IOPI+12y0Ia3RFRa2J?=
 =?us-ascii?Q?HPEXPN4/6vLx/yKoOveWiu5Y8bg2gNdtYGEfL+KWLdVEw0iW206LzizQwltp?=
 =?us-ascii?Q?iGDeU6R2/PZbCLZf8OYZHeV97Ve6Td8V+Ag7im9bCmghuihBTFzQAFEzqrAb?=
 =?us-ascii?Q?Z2a0cnDtWpcWrDlyKQH6TjxwrU+rlJFhaXDVhIGu1Cs9444EsA714j078Dop?=
 =?us-ascii?Q?mF4oc1D/fV66msjx5izjokbBCyVlx6oqPrTbA2kUK3w6c8pwqgfYA2GDRPvi?=
 =?us-ascii?Q?DbUujBObYNeYqSPdvNH5FWeVsJylDzhbr8piI9m+CvJPCnCsBq9UM6TGYphU?=
 =?us-ascii?Q?l+2iXl2Gb5UYe3l5khR19KDq3XLU4+NEk2itm3vSiyAQPVQvIjzyxK8hiUIe?=
 =?us-ascii?Q?TbZZz+q6Hvcj6eEHzB3srtCo+qMOcR4Pb2CWM/6KgUzgI0hGXxFbAmVHN+Ag?=
 =?us-ascii?Q?XxF3krPzLCBe95hwYPFYQG0+vtqSmtV9gU4yoA6PSqpuCfGWNBnGh+nn0sj4?=
 =?us-ascii?Q?D1EqUMAuvm0IeZvXPOzqNCKAGQyIv+GkbqqY6IxXpsHNKKbEdxxwTY6nu+J6?=
 =?us-ascii?Q?lq/WYGHEUggJWWl1XPZ04nz4CxNJ0o19q7HkQR8Kdc6ZkDdO5cXvmGUyiPZU?=
 =?us-ascii?Q?eTTRzWQm25glmPAey9RWcwc7jCo1i+FSL2JS/B4AJP+w6xsfqzKh02XGYyuQ?=
 =?us-ascii?Q?T82sO+R7XhkpXdeIXxj3iexEL8LGv8vuUYmNxN1YUilzsEtEkCyNb/nu0Y3Z?=
 =?us-ascii?Q?BtjOBShCLyyGl7lvcOQ+k2q6uXmJpMvaYeL4mbKFOXdMKVpBFVb8d5aQwne9?=
 =?us-ascii?Q?Ct5O3+CV0+ETAXg1jgE0bZUmC/uupcD2z0htgNZurMl3zqUVDzBf1DHZBdRi?=
 =?us-ascii?Q?iuuuRGLiFcGjxu0xFUCpCgrNmpP6+6dKhPxuBW560rpZcsJiFaE6EzDswrei?=
 =?us-ascii?Q?Bl7RCzrM/pc6FEsmXIv0hyh84iZquM0NleleKjamXRJKbJaR4/1A0aEf/mNx?=
 =?us-ascii?Q?cAAuo+EuAlIiY7Q1NPHQ0W8Z9Lm8DPSiw0pQrEnPc/Er6EMM2/DZDDj1y/Zk?=
 =?us-ascii?Q?dascexlydKKPswGa0oAAocQK/+GS/CUa/5COwGaNvGRak4AJvJe3EeMqSxzP?=
 =?us-ascii?Q?pawYKsFSOtYDxduHIB4LOq8gt/+KrhLOh5GW4PuTNf4EQX8tnsy7tdsDBzYX?=
 =?us-ascii?Q?w3iH8h3+w8cSqD3M0t6l45aTxqpHTqPmx4llP0th38TOhXH544NVZHq1EJfF?=
 =?us-ascii?Q?86aQCAMULS1Z/oTNneY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f262b7-8387-404a-2853-08db9e5b92d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 13:20:34.5469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4x7E0ka5II/PdDEZpTuS+u4TiZXXZC2lUcWdyQRH6PZSWufVvjN3zskU2UovGXcQkWzd7ikkX+xmN42sRRIpew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Ma, Le <Le.Ma@amd.com>
Sent: Wednesday, August 16, 2023 4:17 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Keep reset handlers shared

[AMD Official Use Only - General]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Lazar, Lijo
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Lijo Lazar
> Sent: Thursday, August 10, 2023 5:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Keep reset handlers shared
>
> Instead of maintaining a list per device, keep the reset handlers
> common per ASIC family. A pointer to the list of handlers is maintained i=
n reset control.
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
>         struct amdgpu_device *adev =3D (struct amdgpu_device
> *)reset_ctl->handle;
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
>                                 return handler; @@ -124,9 +123,9 @@
> static void aldebaran_async_reset(struct work_struct *work)
>         struct amdgpu_reset_control *reset_ctl =3D
>                 container_of(work, struct amdgpu_reset_control, reset_wor=
k);
>         struct amdgpu_device *adev =3D (struct amdgpu_device
> *)reset_ctl->handle;
> +       int i;
>
> -       list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                            handler_list) {
> +       for_each_handler(i, handler, reset_ctl) {
>                 if (handler->reset_method =3D=3D reset_ctl->active_reset)=
 {
>                         dev_dbg(adev->dev, "Resetting device\n");
>                         handler->do_reset(adev); @@ -395,6 +394,11 @@
> static struct amdgpu_reset_handler aldebaran_mode2_handler =3D {
>         .do_reset               =3D aldebaran_mode2_reset,
>  };
>
> +static struct amdgpu_reset_handler
> +       *aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
> +               &aldebaran_mode2_handler,
> +       };
> +
>  int aldebaran_reset_init(struct amdgpu_device *adev)  {
>         struct amdgpu_reset_control *reset_ctl; @@ -408,10 +412,9 @@
> int aldebaran_reset_init(struct amdgpu_device *adev)
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
>         int (*prepare_hwcontext)(struct amdgpu_reset_control
> *reset_ctl, @@ -
> 63,7 +64,8 @@ struct amdgpu_reset_control {
>         void *handle;
>         struct work_struct reset_work;
>         struct mutex reset_lock;
> -       struct list_head reset_handlers;
> +       struct amdgpu_reset_handler *(
> +               *reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
>         atomic_t in_reset;
>         enum amd_reset_method active_reset;
>         struct amdgpu_reset_handler *(*get_reset_handler)( @@ -97,8
> +99,10 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device
> *adev,  int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>                                struct amdgpu_reset_context
> *reset_context);
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
>                                                              char
> *wq_name); @@ -126,4 +130,8 @@ void
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
>         struct amdgpu_device *adev =3D (struct amdgpu_device
> *)reset_ctl->handle;
> +       int i;
>
> -       list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                            handler_list) {
> +       for_each_handler(i, handler, reset_ctl) {
>                 if (handler->reset_method =3D=3D reset_ctl->active_reset)=
 {
>                         dev_dbg(adev->dev, "Resetting device\n");
>                         handler->do_reset(adev); @@ -281,6 +280,11 @@
> static struct amdgpu_reset_handler sienna_cichlid_mode2_handler =3D {
>         .do_reset               =3D sienna_cichlid_mode2_reset,
>  };
>
> +static struct amdgpu_reset_handler
> +       *sienna_cichlid_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
> +               &sienna_cichlid_mode2_handler,
> +       };
> +
>  int sienna_cichlid_reset_init(struct amdgpu_device *adev)  {
>         struct amdgpu_reset_control *reset_ctl; @@ -294,11 +298,9 @@
> int sienna_cichlid_reset_init(struct amdgpu_device *adev)
>         reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
>         reset_ctl->get_reset_handler =3D
> sienna_cichlid_get_reset_handler;
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
>         struct amdgpu_device *adev =3D (struct amdgpu_device
> *)reset_ctl->handle;
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
>                 amdgpu_asic_reset_method(adev) =3D=3D
> AMD_RESET_METHOD_MODE2) {
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
>         struct amdgpu_device *adev =3D (struct amdgpu_device
> *)reset_ctl->handle;
> +       int i;
>
> -       list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -                            handler_list) {
> +       for_each_handler(i, handler, reset_ctl) {
>                 if (handler->reset_method =3D=3D reset_ctl->active_reset)=
 {
>                         dev_dbg(adev->dev, "Resetting device\n");
>                         handler->do_reset(adev); @@ -272,6 +271,11 @@
> static struct amdgpu_reset_handler smu_v13_0_10_mode2_handler =3D {
>         .do_reset               =3D smu_v13_0_10_mode2_reset,
>  };
>
> +static struct amdgpu_reset_handler
> +       *smu_v13_0_10_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
> +               &smu_v13_0_10_mode2_handler,
> +       };
> +
>  int smu_v13_0_10_reset_init(struct amdgpu_device *adev)  {
>         struct amdgpu_reset_control *reset_ctl; @@ -285,10 +289,9 @@
> int smu_v13_0_10_reset_init(struct amdgpu_device *adev)
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


