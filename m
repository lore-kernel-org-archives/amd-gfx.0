Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A331C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 07:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB5410E331;
	Tue, 13 Jun 2023 07:13:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9D710E331
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 07:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXq2A3i3G/aUCyihdcC2CvdyuIuIgAYfdmlNPsICB4uMNU1qnKlEK7zZ4G1S7aqwXwPTTQ68s1NaEsLdBTueE/+pkPcrmVuvbFmh/JSdMAWlsU8LM0GYYHAEMEtazychHawOR+jHSL2V0Te30a0rb+EaCLMO1xDDzvM4APDROXo44B2W9T57255JP8tw5RKRpqRctsl0aCdHIpE7EbSllysud9AfSM90+NkYEQb2sdGdHQ3X0S7h5L/TMW3N4AXfqkpZuGkUVFhddLyZo/7qpjQRayjAvngvFkTwcG/3Ob1Ohpt17r2NLw/Oe8qAHG59Y663TUpxIiGbFCVgRr7eKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj2Ye5A1G2FIYeVdiotxsNMqS1YQ9HVzS5liCNl+Kcc=;
 b=nfO0dE4VXek3MyiWxan3/VGS7LHymDxNMH2GJe0JSb1PFF/ZJVTxihMD6uqDKZ8cniJsgwRhxcaTu60uSQKj1h/HPEsVdBtzN2muJCe7eAjelMphrLeaTqoU0VHI6Tbq21P2dEfx6kIaWRwvpX/DrKOTCS9IpCWSoGcEiTmHUrorS5vADB1ijVEP79MX7m2ukdarbncBhQjNjqHfv+bf6g6jX8QsiuBhYXpa3D1XtlvD42wDgjJ3QY4EXYCCzD0gL6EiH8hle98grNbpLXOAZ7rAJYRpQqjM5gYltX33lVq2u0thXFO//1nMpDTXAZcm0+oOVwl2xmqZrKmY52j2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj2Ye5A1G2FIYeVdiotxsNMqS1YQ9HVzS5liCNl+Kcc=;
 b=zwzxeHqM+/PxQBBHi1Jtt+HpMoHlqsQfflhfYiVQl8PVEO0XNS5ejlGYzxm1T+cQvT4qUIzck/9dyYCX8ibgqL9wfqHHxX0hSn6IEnq8m5O8/Fit/AdMxFuN0eelb5fxBmp36A0gi/ubcSkpQ10liLof5NNS/rr2GLRUeB/OFPA=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 07:13:14 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::cc12:13d6:4667:64e]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::cc12:13d6:4667:64e%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 07:13:13 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 1/2] drm/amdgpu: Optimze checking ras supported
Thread-Topic: [PATCH Review 1/2] drm/amdgpu: Optimze checking ras supported
Thread-Index: AQHZnaqaRDPJDrw7aUa5uszxRjsq7K+IUFKAgAAAZHA=
Date: Tue, 13 Jun 2023 07:13:13 +0000
Message-ID: <BL1PR12MB5334C01F0C82FF650D1E3D359A55A@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230613035318.10613-1-Stanley.Yang@amd.com>
 <IA0PR12MB898143BAC695764609219EBDB055A@IA0PR12MB8981.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB898143BAC695764609219EBDB055A@IA0PR12MB8981.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=64f53ff2-ecd6-4083-9d8e-0f2d1bc43d00;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T07:04:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|SA1PR12MB7221:EE_
x-ms-office365-filtering-correlation-id: e1255626-60f5-4d4f-a4d9-08db6bdda6e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nW1yORSF1AnHO7f3ORJ4LIU3HZPVdClNsTrPPIUkqhgApMa8ySp6NIJngkDYPk0l7dGZVU/wbeNMfc+nl8HN9ZfDFWwxo6OBKOV86OGca2ix+yd0DDXnhR/1clv06zJULi1Lcv1d1hGG+Cxx/i1XMmd6PrR9q2nitqwLafVTTPFS3vrvxMzLjtMdgpJCdOeuUeYbBgoZQ/M6op0BNi3mNgUHyrmbHToC0PoCXsh0Cbxs/I8RijsgqqPGinWUZecQ+nKIM/Ckk6HlDSy9AxDxp7604nyOeUd8PjwAPPbEI8IUAg4wagMTRW8cZrSEXJ5rHjZ5VhmaBbrPSqKZwelj21Nc6c43Zf2vtEyyqSTvrKk67zibtQ02M22J7/g6T57OveAewqbTUiMK4RFeTFMSfEI4WpUwQrU+cCSYubQdehLAsirONDZQMoMEW+svakTSFBYlLa80QIGLBF6nKDiL4Ij1h9HlToiVB3apxR4rUNNJtlsocrhtWSWx8HiKcM8G2FkmPR1nc0kkkN4/co9lEK3WxdTFju5QNdaksFLzB3gwfkAsI3lZAZS+hI66xKTjibm1Cy1hkG2ZCg9pXZPlI+sypiOPtZMnzhhtoPBDWnU8rJQws9hg0lc3ckmsonXo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(5660300002)(52536014)(66946007)(66556008)(66446008)(6636002)(64756008)(66476007)(76116006)(2906002)(316002)(41300700001)(71200400001)(110136005)(8676002)(8936002)(9686003)(186003)(53546011)(6506007)(83380400001)(86362001)(38070700005)(122000001)(7696005)(478600001)(55016003)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8OcHsADqXas+H1rsmxUXe6xfnYTV3DTMYej/AQWOmPOKbUXEahMlfevysZ2H?=
 =?us-ascii?Q?HJQzOVsklj6tteS1+iLn3/n7NikRx1TNbtcndwi8w/Y70Cr5Q2qECUQc6K9d?=
 =?us-ascii?Q?aWKKKaOVnSjjlEHItIBhGcgPjyd3yCEgGrN2rv/G/rTRcsQj2pqNlTE7RUbq?=
 =?us-ascii?Q?6h/SVORWoMPMsmQDoQALc9i63kvpj2qNpeQs1x2fIMRaOLvlbSpmLQxmYGZ4?=
 =?us-ascii?Q?U8mK8po9v86dHz1bS2Ygi2W3Pcp7Hj3TNyBMf20peOikem8v+RhwfqFTjYxY?=
 =?us-ascii?Q?O+7DBg0tcywB7XrCEpK2uSPVWt+IzaHXWam9l2zXrnZY/x+sKa6iCkZJQ1q9?=
 =?us-ascii?Q?UcoxjyyLVKIBwqHR9QdrB0jwaF4O5onqehUqidHfyfzxDO/25PvLlemuJr0s?=
 =?us-ascii?Q?0CO6sMCVUhCo5/Kh+gysFS2eqIDk4+HIptsbdCp8d9dwIXswk6B2OluZRnCn?=
 =?us-ascii?Q?/GGCYQ98R9UFqam8hqc6uYyt75ZjJX/Ij2jjzar40AcBusOpje2TQU8GLBq9?=
 =?us-ascii?Q?NUz/EkTKoLm4a72xeMk8avCnjGG7bjp6H/Ye43ZOp1dg4bsZpWnoNkVFX+bV?=
 =?us-ascii?Q?TjkyiU3zxBCdtP/zVwEky+gHhvH1iQb1LZk5BPadFKW5VaH9BH2lRpyIosjF?=
 =?us-ascii?Q?STfyJZ9OIFyge7T/dsx0+hmesZBigeQkIpPv9Kz8X3Y0xQ+00jzjodWOODIj?=
 =?us-ascii?Q?oUVoQvh7zklPhXp/TzrXoWLMZswJ+OoVLk/fhE1w1fgsHIGIVnpEZeoG19zx?=
 =?us-ascii?Q?/jrUpLlYB/ebLLOO0MB3Ajkxtg4DcnKftD4FQrGyVsO7H6TxkJgLqVhyF7F7?=
 =?us-ascii?Q?/7HP8NB0sMphRRLGeWAP79L8KCCofGKY8HkCA3qWdWEWJPfngX6JSDeBDCer?=
 =?us-ascii?Q?0/yDMzlOPo1d/gexJmlu93T4Njvq8jrtDT9ImtK9trYTOC3e3yBDbA1DxJ50?=
 =?us-ascii?Q?LxvCT23AkRxpdVDBHO+zGwDCViLLBB76+9lYyYmNEO1ZCVQH5qmMmRuJ+j8v?=
 =?us-ascii?Q?OSr4E/Py+i6oHY+VDRoajt1Yu8oDD5KqsOcH2WpHji4nbBpzV/tQ2vKFydqJ?=
 =?us-ascii?Q?iJHlBzfKdAiQ48uu7t4v8BoUfarNIIHeKDmIdRDlyxThW4JYLZOJkgwWlX66?=
 =?us-ascii?Q?cziAXiTo5B3O1wP4weJljJUTqxaXmNkYEG1B8hE/Ta8rSqLG3zIppYRPZa1K?=
 =?us-ascii?Q?QW+FaO3qtZy/vGsPF4mXVziYzEaqLiDhwra1WvKYL2scw8Dq7XEEeDWcE517?=
 =?us-ascii?Q?KCTBXLoW25TISMUmMlIo8YYtWGAU8NBe8tRUCtEYzYmMtypTOGe+ljchceVW?=
 =?us-ascii?Q?R01amJyk40/6jzieIhGhr3rl48MXS3GCaxczBH212Htik/PwLAbvjwuGvWg2?=
 =?us-ascii?Q?3m/kii1bCOLWylv9pG1iFvwnMFTDW8G7jk5jm9Brgb/IBHRGh+KuhdfPQ/bj?=
 =?us-ascii?Q?QdZTd1T6F//yXJ/bZ/VnZa+hxRm6ntb3dHn9CMjJiZosm/VDX3x1k3kdsPtf?=
 =?us-ascii?Q?F0UU864no1KFdp3JB9/the5Q5gVE9jy2vcFIPAXZaaDB86Ug4UrZHM9phQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1255626-60f5-4d4f-a4d9-08db6bdda6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:13:13.4272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLiG/7XDZDjMkuyzP6cJ1xeL6koMv+ATMro5pf+8BMCacebmcORrlq1HlsSbP2uRrcEkSPG67uQMinrH/kJteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, June 13, 2023 3:08 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org;
> Zhang, Hawking <Hawking.Zhang@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review 1/2] drm/amdgpu: Optimze checking ras
> supported
>
> [AMD Official Use Only - General]
>
> [Tao] typo in title: Optimze -> Optimize

[Stanley]: Thanks Tao, will update before submitting.

Regards,
Stanley
>
> > -----Original Message-----
> > From: Stanley.Yang <Stanley.Yang@amd.com>
> > Sent: Tuesday, June 13, 2023 11:53 AM
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> > Cc: Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: [PATCH Review 1/2] drm/amdgpu: Optimze checking ras supported
> >
> > Using "is_app_apu" to identify device in the native APU mode or carveou=
t
> mode.
> >
> > Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  2 +-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  8 +++---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 34 ++++++++++++++-----
> ------
> >  3 files changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 78bacea951a9..352e958b190a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -1653,7 +1653,7 @@ int psp_ras_initialize(struct psp_context *psp)
> >
> >       if (amdgpu_ras_is_poison_mode_supported(adev))
> >               ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
> > -     if (!adev->gmc.xgmi.connected_to_cpu)
> > +     if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
> >               ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;
> >       ras_cmd->ras_in_message.init_flags.xcc_mask =3D
> >               adev->gfx.xcc_mask;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 7a0924469e4f..56bb0db207b9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -1689,8 +1689,7 @@ static void
> > amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
> >               }
> >       }
> >
> > -     if (!adev->gmc.xgmi.connected_to_cpu)
> > -             amdgpu_umc_poison_handler(adev, false);
> > +     amdgpu_umc_poison_handler(adev, false);
> >
> >       if (block_obj->hw_ops && block_obj->hw_ops-
> > >handle_poison_consumption)
> >               poison_stat =3D block_obj->hw_ops-
> > >handle_poison_consumption(adev);
> > @@ -2458,11 +2457,10 @@ static void
> amdgpu_ras_check_supported(struct
> > amdgpu_device *adev)  {
> >       adev->ras_hw_enabled =3D adev->ras_enabled =3D 0;
> >
> > -     if (!adev->is_atom_fw ||
> > -         !amdgpu_ras_asic_supported(adev))
> > +     if (!amdgpu_ras_asic_supported(adev))
> >               return;
> >
> > -     if (!adev->gmc.xgmi.connected_to_cpu) {
> > +     if (!adev->gmc.xgmi.connected_to_cpu && !adev-
>
> [Tao] the tab should be replaced with space.
>
> > >gmc.is_app_apu) {
> >               if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
> >                       dev_info(adev->dev, "MEM ECC is active.\n");
> >                       adev->ras_hw_enabled |=3D (1 <<
> > AMDGPU_RAS_BLOCK__UMC | diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > index 1edf8e6aeb16..db0d94ca4ffc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > @@ -169,27 +169,31 @@ int amdgpu_umc_poison_handler(struct
> > amdgpu_device *adev, bool reset)  {
> >       int ret =3D AMDGPU_RAS_SUCCESS;
> >
> > -     if (!amdgpu_sriov_vf(adev)) {
> > -             if (!adev->gmc.xgmi.connected_to_cpu) {
> > -                     struct ras_err_data err_data =3D {0, 0, 0, NULL};
> > -                     struct ras_common_if head =3D {
> > -                             .block =3D AMDGPU_RAS_BLOCK__UMC,
> > -                     };
> > -                     struct ras_manager *obj =3D amdgpu_ras_find_obj(a=
dev,
> > &head);
> > -
> > -                     ret =3D amdgpu_umc_do_page_retirement(adev,
> > &err_data, NULL, reset);
> > -
> > -                     if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
> > -                             obj->err_data.ue_count +=3D err_data.ue_c=
ount;
> > -                             obj->err_data.ce_count +=3D err_data.ce_c=
ount;
> > -                     }
> > -             } else if (reset) {
> > +     if (adev->gmc.xgmi.connected_to_cpu ||
> > +             adev->gmc.is_app_apu) {
> > +             if (reset) {
> >                       /* MCA poison handler is only responsible for GPU=
 reset,
> >                        * let MCA notifier do page retirement.
> >                        */
> >                       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> >                       amdgpu_ras_reset_gpu(adev);
> >               }
> > +             return ret;
> > +     }
> > +
> > +     if (!amdgpu_sriov_vf(adev)) {
> > +             struct ras_err_data err_data =3D {0, 0, 0, NULL};
> > +             struct ras_common_if head =3D {
> > +                     .block =3D AMDGPU_RAS_BLOCK__UMC,
> > +             };
> > +             struct ras_manager *obj =3D amdgpu_ras_find_obj(adev,
> > + &head);
> > +
> > +             ret =3D amdgpu_umc_do_page_retirement(adev, &err_data,
> > + NULL,
> > reset);
> > +
> > +             if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
> > +                     obj->err_data.ue_count +=3D err_data.ue_count;
> > +                     obj->err_data.ce_count +=3D err_data.ce_count;
> > +             }
> >       } else {
> >               if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
> >                       adev->virt.ops->ras_poison_handler(adev);
> > --
> > 2.17.1
>

