Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01DCC636D4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 02:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FD810E08B;
	Tue, 14 Feb 2023 02:42:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E8910E08B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 02:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlYUMY58SlXPkQDLs+KVEzyMehdBKb0lePjOtUBZDvVj8Aq/E4G5JafEOyMAeNQIYG5UGpFaWFXi8SKWsUVwjrSLYsCBwNIVT2Bmts0Dd1g7VrpvbfYnnPX6ogholn/7TuWitrde8z/Im0LxshAR3NhPB5ghyEnB7xkD0cih+8640rahU1ldzKGUaYLDybMye4NkRK6gbHrPAxgxLb7dzVlQX2tzdWFZiFYvzR8vcmJ4KpJbIp7GUT0qO/zopEekVB68I4pTmMsKrsxAdLP8JI55rzwgXFTE3B0ZElwlusrlljqfMqPew21IxpV6CkXeI9ZhP0fxcwbIqF+SUqy1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBd60o8avOdJQ44JcsKaUOGB/65ypr8J30midRO/OPI=;
 b=eWb1wDCoHjK5Qh/NMme4Jx8utcgHInGzoToR+9KiSgh/3G8AavO3VCWMh01rhUe2P7LUghKPQw+dv88QYK8i+IqgsBu1s7OPtshSS50ezqW5Cbe36Lb5M1PBTSEz2SvTZ3V+uuDJ5o8gLtytePVXW9viaojStdVuzsr7chWkP6buLTr8hclbiH3XCBWRbXGrXrT7M38mRFIauM4Jyr99akMvSuSmfD0s88AtBKYNS/qEbY/+vxr0jdhE+sWzliTilRu+VECWrZYq7kzUp/i6rvSqX8zQ5tcK/qqmRUesY7crFOgTPToL1nUTmdFyxLY9BtTqRSke17PIu2M4WEcr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBd60o8avOdJQ44JcsKaUOGB/65ypr8J30midRO/OPI=;
 b=lhH/orACleCYez+lbRhME0RYRymjfV83lAjRG4Cp+peA0OBKEVS8ufPSFCuMBjdHLZk5bY9gW8BXPossDkArMNw6xWF2yrZGF6zq2CMqY4VijVSPXl+882jKYyT+5r2dRfTDv1mj8SOi/DPWCCFy4RMMd7oYhNLpH1/EIo5GKJE=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 02:42:22 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7e7b:2783:72f:5b39]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7e7b:2783:72f:5b39%3]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 02:42:22 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Thread-Topic: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
 bad page
Thread-Index: AQHZPSwY5YPBBlh4hEiiFiO1mku8/67IRt4AgARIHQCAATG1sA==
Date: Tue, 14 Feb 2023 02:42:21 +0000
Message-ID: <BL1PR12MB5334C9F3F4623B4B3E63250F9AA29@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
 <BN9PR12MB525702B9A9FF262B9FA0CF02FCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM5PR12MB1770029EB462C56B50984414B0DD9@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770029EB462C56B50984414B0DD9@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-14T02:42:17Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=024f425d-59e5-430f-b54c-3a849f1aea78;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-14T02:42:17Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d0ce8cf7-1279-45eb-8472-b60b257f6a83
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|BL1PR12MB5045:EE_
x-ms-office365-filtering-correlation-id: 23ec2b44-c461-4350-c913-08db0e35190f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8fgbGLxyhqhz7pH6NxNZDM+UImOrbKYD0axmpyK0h0HSocicK1Its2I/jLiDLN501cIsDazx6+RsMIk+XGzfR+tW7NWFbM1xV1tKX2HG3o7Sm9BwOKDywoBtIC9poCE10PZXjcZ3G7GNtsKdfSuqYNKgwYZOJfJHxOdD2dnWu3KZND/iX3SSiqFIOQUyrENzuRAlTO/NJv6pvTBdYCUmYDqZGUWy6ZTn1sUIIIx2oMBebl0VAmpR4RW1UA2Lqvgr9HCAL3nhOWqyxxB4Q74ujFlVESGUGGi/7m+veJohM2v6ak10dtshKFxUB3OTfBXIL0RbOAzDh8jEjWK6VkeHfuR10vzbOgidum9grjT8PdbWeX6jLJlUSKzVmXeRjmG7z5x0EyauQE/HTfcQJ0mm6HFA6g9UgpNQOlcJ4l46URyS3f/bW39SqbRMP6WmHnfvSbdI38gfU+y2k9C1jlJ7viS8LMLy8WbVP/2JoazmCfOqn9sHD4TvFDPrHy6GkKnQCUqTu+GCJqC8PF8UWHqwLPXzycDp6N/1Caw0j7rf3KdUf/agtGy0t3a3WTEmbvVlcDACXLJh0Sp5CWexP8RKtdeXENgY0t9E2nzAP/O+uX/EViFU/OemYC1zvGt/QaUlCAisAz1B4GLXmFO519HQTBMqxoxSYeVQ34725MtXXbh9oTl8ZVw+I8R5zGbmbA3XuWtdX4xwplZ9+GwTacdryg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199018)(2906002)(5660300002)(26005)(83380400001)(38070700005)(55016003)(186003)(9686003)(6636002)(122000001)(38100700002)(66446008)(76116006)(8676002)(66946007)(66556008)(316002)(8936002)(64756008)(66476007)(41300700001)(52536014)(33656002)(478600001)(110136005)(6506007)(86362001)(53546011)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXbIiz9jc1ElfZ6vij5BkblntSfkqXdUDXfojjuqoLIT6z3H6roPTCcgf90N?=
 =?us-ascii?Q?4pbemjR3fInJ9kCi8RLhlWxeRxa646NRcX4Ilv1fpNaJFsdEqHgbtW1O6XkG?=
 =?us-ascii?Q?x5MlgjnWTQNEJLELESIOzC5JqfBc/jGsCDPNx64CuQmHq19v+rKXTzUUND0m?=
 =?us-ascii?Q?LD6gmCHmPsw476c+1t4LB6Uu9fRPtd2qw8u+EOngzzG9M1xMqXgTowF6E0CY?=
 =?us-ascii?Q?sGyulqoB4QNdGELPYGeOX3m3CHEjS9fm5sXAl8abF3XoALR/6jQQXiA2i6pV?=
 =?us-ascii?Q?0Zx0Tg2P8rlLIht7mZJ7k49aGMbBfNkwPO5LCSeG23COOnHK6LkCWFkU01Il?=
 =?us-ascii?Q?2SxDjoOKyCQQsV5+vGPX+LnJWgLeDofFx+wBVD2M3h9n4UiqkQGfuWJq2huc?=
 =?us-ascii?Q?EGXY+HQ9YX2tLCKIvJTE+Fd7wYcnzRVwvfx4UAOzf5iFxIRMARfymr+NX52f?=
 =?us-ascii?Q?zx4lhvnVko1tBSfAjGFOEHqJ+h8B8iQffKA/KhSTYpjSxaDx3dATSQcYCAfD?=
 =?us-ascii?Q?+CE5NFcV4boZjcKunEkM2bkX9D+ddXb0qpaUsGBhj9324HsHplzZEkm4cP2j?=
 =?us-ascii?Q?KJGCkX4Q2/9GJsJwC0bjADu0DsE2advQZu9rR3Ja2LykErRYVeBUfPMBQJgS?=
 =?us-ascii?Q?zrljgyynxYIPIgAf78EXHMd/ElXdSdFGtl/Sjev3sMSJ2Rou5X9Q+BaYuKTo?=
 =?us-ascii?Q?KDvGFpY1Ud+EOXUpzLkt+xFQPM6NVrMDxhlwJWT8buW6X2gwBTTf0Mpnh1xf?=
 =?us-ascii?Q?xCXlQ9wTfwdr7ekLUNPF/SsTpCC1tN+30X16Pcxe9MTOfFCtsccIxaboUBX/?=
 =?us-ascii?Q?Q6bpjYf1eSsS74eTlwyEPNgsGnEEJGbXQcBH08EhdWN63ZbIVcdo3rz95OfD?=
 =?us-ascii?Q?JukeUWZV5quXrZvWEfuj4pcXF1FSe745LPZf2bcdsxAFwMOpKI23WWvPkgcu?=
 =?us-ascii?Q?k1Dstk5seXlmeSdWihhMDTM8usJIDacGZzyQdj16u005hhmVaYJjC2D5yIRC?=
 =?us-ascii?Q?FCLZKbaoGwSnML8hIOnI7BI69+vKh+k49m9Cy73AveNuAXCKCSstuQ4Ncg8/?=
 =?us-ascii?Q?yQElHZUuC67H5X28zu96oZfmBBqxxbilf+NZDrclf4DTz/Tn5vr+Cc05t1zG?=
 =?us-ascii?Q?KwnxBpPdC7vlJW4WNjhgZOh6zGpBRj6lnV0bNPzwAVSq1jsobXs0WD2QRvuA?=
 =?us-ascii?Q?LzeozdfCLPNrfucjowqnFX6i3sVi0ofKkllmzJ7ot1s/rvoyMR/VbT3ZbMIC?=
 =?us-ascii?Q?EAd1weUx1V3NKwH2rYhbllHRyA72G609lpRNXfItaeGsWnTPKSPFHBkETDvI?=
 =?us-ascii?Q?BCPfi0bAOSYSHFMu5mb7Gyb/zRXmlzuFro3HFJ87aGyPNvUfH/SfsKKoXUnA?=
 =?us-ascii?Q?/AiqwB5qMLSX7PAX8jJPTu6Mg2YkFIBTIxgh/ykTML4aWsVMTcQnpSsg14HJ?=
 =?us-ascii?Q?qLNEDmYaOrv3oGEbtYJRr5o8ZBC7ykNSUtTObg+bmZHOgHdykm55dazL8dcM?=
 =?us-ascii?Q?ofE+rD+sEOmb0yVW8kfJ5u4fM6d0fMZCOCR519OeJWy3WFA0UuiwzW6xKLKu?=
 =?us-ascii?Q?bOvPyHeAE/Dqf24vg/74rI9dbpvOQ59SA1323EJe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ec2b44-c461-4350-c913-08db0e35190f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 02:42:21.9108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTp8h2J2e1SUPG+XLJzeckpgJNHuYzbMv5iu6J76Lf+F8v9t3Ier5lc0CVtGLVjRwBAORWb3SfD+hrVCsTYvdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
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
> Sent: Monday, February 13, 2023 4:25 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no
> new bad page
>=20
> [AMD Official Use Only - General]
>=20
> > -----Original Message-----
> > From: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Sent: Friday, February 10, 2023 11:02 PM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org;
> > Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> > <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no
> > new bad page
> >
> > [AMD Official Use Only - General]
> >
> > +                       /* if no new bad page is found, no need to incr=
ease ue count
> */
> > +                       if (ret =3D=3D -EEXIST)
> > +                               err_data->ue_count =3D 0;
> >
> > Returning EEXIST in such case is not reasonable. Might consider return
> > a bool for
> > amdgpu_ras_add_bad_pages: true means it does add some new bad page;
> > false means it doesn't change anything.
> >
> > Regards,
> > Hawking
>=20
> [Tao] but it can returns -ENOMEM, amdgpu_ras_load_bad_pages and
> amdgpu_ras_recovery_init also need to check the return value. I'd like to
> keep the type of return value unchanged.
> How about -EINVAL?

Stanley: How about return -EALREADY?

Regards,
Stanley
>=20
> >
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Friday, February 10, 2023 16:45
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>;
> Chai,
> > Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no
> new
> > bad page
> >
> > If a UMC bad page is reserved but not freed by an application, the
> > application may trigger uncorrectable error repeatly by accessing the p=
age.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index e85c4689ce2c..eafe01a24349 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct
> > amdgpu_device *adev,  {
> >         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> >         struct ras_err_handler_data *data;
> > -       int ret =3D 0;
> > +       int ret =3D 0, old_cnt;
> >         uint32_t i;
> >
> >         if (!con || !con->eh_data || !bps || pages <=3D 0) @@ -2060,6
> > +2060,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> *adev,
> >         if (!data)
> >                 goto out;
> >
> > +       old_cnt =3D data->count;
> > +
> >         for (i =3D 0; i < pages; i++) {
> >                 if (amdgpu_ras_check_bad_page_unlock(con,
> >                         bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
> > @@ -2079,6
> > +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> *adev,
> >                 data->count++;
> >                 data->space_left--;
> >         }
> > +
> > +       /* all pages have been reserved before, no new bad page */
> > +       if (old_cnt =3D=3D data->count)
> > +               ret =3D -EEXIST;
> > +
> >  out:
> >         mutex_unlock(&con->recovery_lock);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > index 1c7fcb4f2380..772c431e4065 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > @@ -145,8 +145,12 @@ static int
> amdgpu_umc_do_page_retirement(struct
> > amdgpu_device *adev,
> >
> >                 if ((amdgpu_bad_page_threshold !=3D 0) &&
> >                         err_data->err_addr_cnt) {
> > -                       amdgpu_ras_add_bad_pages(adev, err_data->err_ad=
dr,
> > +                       ret =3D amdgpu_ras_add_bad_pages(adev,
> > + err_data->err_addr,
> >
> > err_data->err_addr_cnt);
> > +                       /* if no new bad page is found, no need to incr=
ease ue count
> */
> > +                       if (ret =3D=3D -EEXIST)
> > +                               err_data->ue_count =3D 0;
> > +
> >                         amdgpu_ras_save_bad_pages(adev);
> >
> >                         amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> > >eeprom_control.ras_num_recs);
> > --
> > 2.35.1
> >
>=20
