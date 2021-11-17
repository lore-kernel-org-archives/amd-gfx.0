Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D86C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9FA613A3
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E9FA613A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE16A6E1A4;
	Wed, 17 Nov 2021 03:28:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023146E1A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 03:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoYr9yIRM974DJ3ETlkAUYfs02/BPYMRYMPnvaBejy9wEhrkYeC0lgTCQiOdO+3YbBrc1cr1R5EoJzhR1jVn5ix5oVgJga7LsXokHIc40MP0Sr8GrfhkRyPh/cAdqX1qPj1jImzIJqVLJO5zgbZ9CP1YoGXUWw5WSIVDWYOqitTgPhm5UkVEwweOcG42U+A52ouvbgAJ+gE+F1nyV7X+QsFkcbkr9dYZaqSIquiHEoDyJpYViIO2kaAhtZGgeB0Tk2fGzG4FqdcZs3bHvSXyPHeRcKwcBAwYLeH8BulyunWR3zWU8ygbPyBmLTFz/vah9K0sDHVtBVfQ56d4CBOHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64KYHiyih+G7/5HWcCDDH2ApdBywo0oR1VUHtteIg20=;
 b=nHjc75LO46QlAoYxf8hz16xLbQoOwLSoXyycNhU3TK27YkrTV6yL2URle5Z+GGneGNVxHljo+K3HMsq9hirxyjNDm1yL6ikGEuzQ+qzxevCiY7rZiEhzI7tk+7EVXriwoOSTnhlaNawxRmMAkEHOTFscW9hc0a0dFHo+KGhFITDVQhO+vvuPYCXcO3+D4LaRF9WLDaJ2yIxh5GjRhBVZ1LL9NScHXunHzJQf2LQvlpyqrFfHYUG97gPq/Ior74/2ilpFT2R4/b6MeEhBgARdeAGKER7/bkc9/14NRAPYm3wEOHrhP2XpLBsPDKzQ81OIDe6ByEwe3ivfLfMs5U5IaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64KYHiyih+G7/5HWcCDDH2ApdBywo0oR1VUHtteIg20=;
 b=GPbJtgfSqHfNcZcIs9mpJ5sQFQv1hMMhMR3c0tcetQl0ZuNZjXXmKuJfC6bhaviGzyiET3M4S9N13nvs5OphnuZtH9ncWLqdfos6CdpjCRGAr0njAiU/EVRU7e2HqMUc8254S6jxg5p/xoVVAJqUriiiJlK5/Rky/j0IFu6eMa4=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR1201MB0249.namprd12.prod.outlook.com (2603:10b6:4:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 03:28:27 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 03:28:27 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
Thread-Topic: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
Thread-Index: AQHX2sBFoxDcc7xd5kSOptJMhBOdvKwF0IyggAE6nICAAAQqUA==
Date: Wed, 17 Nov 2021 03:28:27 +0000
Message-ID: <DM6PR12MB46501C7A9F152183033CC066B09A9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211116080146.3183-1-candice.li@amd.com>
 <DM6PR12MB4650F622273174D5E09B0A9EB0999@DM6PR12MB4650.namprd12.prod.outlook.com>
 <DM6PR12MB4649B835E6A801C8EA055105919A9@DM6PR12MB4649.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4649B835E6A801C8EA055105919A9@DM6PR12MB4649.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-17T03:05:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6d8e04a3-9476-4324-b33f-6f355aa8f42f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3adabbde-4ef8-4f6d-b72f-08d9a97a51e6
x-ms-traffictypediagnostic: DM5PR1201MB0249:
x-microsoft-antispam-prvs: <DM5PR1201MB024904D801310BF0CD15B492B09A9@DM5PR1201MB0249.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YInKb5kSMsA5epCWBlVC3knq3lx0QPPseDBWihbTZTuNSZ25sySgHfybFZSQutt3MbBCVjWdbGqGA5wRTff329PiOdFe/qXVtgZAL5Jux0PgjD0jqTsdhE3VXgemtj8zIIteiF6wVClyoc/LXypNhsJmEazvY3R6vyzDlYA8uE3MZt7IPLU2ksOVp7o8/GtAR+CHgnmrHeK+sTWWhMaxYuDVnEoEci3M0/cx6uyDuwfVz4iSw7MtOQwJchSM46gbacuMyhaQk8ldZ+GjLczIJYk82uj4trtoGQ+adWswANiSHWgUwm1XCSeQXkq53GAvaPMt+jYUOFhFTAYPFFRHpWfKByB/E+KrOvBgs3NNv5JvU07hqbYSW1S5mvIjDZUTsAJASz4yJbjHO0/wGu7IPlt/VTcf+IMxYtxw1kiCEpYN+ejctkvUc0AuITqInl8+H8aA4n3UqFs4lNx1simiRQRGe//GLecIDEdkuc9CLYr+kpfaM1qB89wnoB0SVsptvhAOuFEGyViyC4iuoDaq1EL+1E/eCJed5yp580LjC+eDTtqg+A8kO8v/XNk4EwpQVsdJ57jGQ3JK4BfWxppizVXOt+0fOXxxT8LX0GIc65AsDiLSzYeBqz6HotWb74YwIjHYi1OvFhmm4UELJHY/sU8Ew682eqfv1/fY3vonQgqy+u9U+U++hdi2MVAfaDR3SQRvuHOkuESpE7/XtGZurw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(110136005)(8936002)(186003)(316002)(53546011)(33656002)(9686003)(71200400001)(122000001)(6506007)(38100700002)(52536014)(76116006)(66446008)(86362001)(64756008)(83380400001)(4326008)(508600001)(55016002)(66556008)(26005)(2906002)(8676002)(66946007)(38070700005)(7696005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vWwtw9vzblMeb9xjB4B/HaDH5uWJR8dZmra0gYjksZSo8757hDC5cgSuzHsF?=
 =?us-ascii?Q?ftB9blUP+PJTqAgBCek33E0VDpyOykc96rXWHGBFFtZq30T5xd99pFGDzSA6?=
 =?us-ascii?Q?GdM4Q/RAPNXYtaJaQI0NT1akOhnc3PKLDOlxmKMRoA9mwy4e0lNde2LP8aj8?=
 =?us-ascii?Q?0/qnltJt5klHzknwPq3xBS8SMgynIAHS5dpbWykCUxGVC2RC76ItlMohPiCV?=
 =?us-ascii?Q?8FVw/vYBAiTjCTjYvbtM4wKT/lHrJXk6/9YScdZXwzLPgrNhEa17hoWotQOt?=
 =?us-ascii?Q?D6pxDIe0XTOWclhlhFqF4tx3ogNP+/RIeoOr9Zmp18ZJ0/jSPV3Q4J8Yiq3j?=
 =?us-ascii?Q?EyXFTkNv/emWyMBzGDZAsiwvfbyl9/SGiGG/qeS1t2DafgAC+B+FfkPKLEsK?=
 =?us-ascii?Q?hK3YG2PMkW1PYvaGpe6BQ+xaQhF5WAWKx2d+tCGYUZVQ22XvEfNEqJAtgLle?=
 =?us-ascii?Q?ym9QHL6YIeQrT9Sf7sgvhVY/xSvMWN1GpwGNknVcgGgTHGw4JTfKOvmAvAgY?=
 =?us-ascii?Q?VQKB4M0HxfawLmuhFXd9thfmdNKXXr4nSVssgu3r96laAF/gi1DFHKMIkk1D?=
 =?us-ascii?Q?lg47CycSZbK/TYM4/CB4xm6l2jyFPYQUOw0Thzo4qmFHEUdoiS0PwjGKG03B?=
 =?us-ascii?Q?K2UCsRhu71Wr7fd9rDydbiCuYl0/kZFLgbaqc31K4a6yjDtNLjX0Mxkkvu2Z?=
 =?us-ascii?Q?whYNtN1tmIJxrHlk7kglp0ZZLxV3SoeZTFg9zR/Xa7QXFQ7/yR1Pfl2hgPWy?=
 =?us-ascii?Q?mDGS+XRrZHtWE+CQ9ftcd5hv8X9fSs9oWPS0t2xlQ1NQvpGVRKsLeZoOfIoh?=
 =?us-ascii?Q?rR0iDDe9559Der8rvaDgrCQ720p9L+H9fnvxRV6yho9Ynld1YUlU9RUUAFrm?=
 =?us-ascii?Q?1DkGA51nzEPKYg0LFMNa+K8/JZvhYed1hkJCBFG/spNZxs5mLsFj7S91g3Lx?=
 =?us-ascii?Q?H6Tn8Vwp1vw6LrwonXmc2qJI7YfRy1dhj5Z9gSlUC6Si0iouA+ZYqMjgMd1D?=
 =?us-ascii?Q?Kh5iv6fj/OqJEJp7Erl4vk+dwr4m2agcKqeoD4ZkCYkD0G1bTqOCkitMVBS/?=
 =?us-ascii?Q?iD0s3Ev7AImo/j/B8QuuYAr57WKdnD1Gm24p3YHbeT9swiJOhFCKtc++sJKP?=
 =?us-ascii?Q?WIbefDmWLDOE2iWIAYkU1xmyRz8zdAslW/N2hHliZz/Ow86j9A9lwdZAoaSJ?=
 =?us-ascii?Q?F0FK0liXXesYusKqDqXVpDio0FUvCM6aWsIGWqM7vmN8hujyzm7/8RCe8XE/?=
 =?us-ascii?Q?YIkKdOHizD3JOj+YdhE+U7WjUUlAtkrc4Ipwijlqy1hNeGHNqow2vBUnbhsg?=
 =?us-ascii?Q?OnRv29z4VhYHKvpTsIUanIBgBHn0F/6Op78otgh/GBTmlH8fdjw3lkaPIeV8?=
 =?us-ascii?Q?xcQWKUHDTbJflrxkbkUFBJY7ETOumennJftdoBRDMtde3er+ZSL2gXWPs+A7?=
 =?us-ascii?Q?HuOd3YVIUEgRs9NR3A5kCP9BcvqnX5nDA5haZMnB35mOvHUWpzFZb/qHptYC?=
 =?us-ascii?Q?6hfwIEj4YWVdYO2A+bj9/u2xWIjNjGSSFaiL4Bpf6IdZOy/tB4/5xZUGal1m?=
 =?us-ascii?Q?E2Iv1y/BLWVeerJtEYw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adabbde-4ef8-4f6d-b72f-08d9a97a51e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 03:28:27.3715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21zYW2V0+4HjcyaSzYHAEiSBn3SfgxRigBwLR+L7Q3bmeGHWg61fzb+jV2gYZ9mj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0249
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
Cc: "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Li, Candice <Candice.Li@amd.com>
> Sent: Wednesday, November 17, 2021 11:08 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Clements, John <John.Clements@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages
> function
>=20
> [Public]
>=20
> Thanks for the review, Tao. Updated the position for unlocking.
>=20
> Fix race condition failure during UMC UE injection.
>=20
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 08133de21fdd63..53b957a5b9a65c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1935,9 +1935,11 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev)
>         if (!con || !con->eh_data)
>                 return 0;
>=20
> +       mutex_lock(&con->recovery_lock);
>         control =3D &con->eeprom_control;
>         data =3D con->eh_data;
>         save_count =3D data->count - control->ras_num_recs;
> +       mutex_unlock(&con->recovery_lock);
>         /* only new entries are saved */
>         if (save_count > 0) {
>                 if (amdgpu_ras_eeprom_append(control,
> --
> 2.17.1
>=20
>=20
>=20
> Thanks,
> Candice
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, November 16, 2021 4:27 PM
> To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Clements, John <John.Clements@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages
> function
>=20
> [AMD Official Use Only]
>=20
> > -----Original Message-----
> > From: Li, Candice <Candice.Li@amd.com>
> > Sent: Tuesday, November 16, 2021 4:02 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Clements, John <John.Clements@amd.com>; Zhou1, Tao
> > <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Subject: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages
> > function
> >
> > Fix race condition failure during UMC UE injection.
> >
> > Signed-off-by: Candice Li <candice.li@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 08133de21fdd63..711b5fb26d47d4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -1931,10 +1931,12 @@ int amdgpu_ras_save_bad_pages(struct
> > amdgpu_device *adev)
> >       struct ras_err_handler_data *data;
> >       struct amdgpu_ras_eeprom_control *control;
> >       int save_count;
> > +     int ret =3D 0;
> >
> >       if (!con || !con->eh_data)
> >               return 0;
> >
> > +     mutex_lock(&con->recovery_lock);
> >       control =3D &con->eeprom_control;
> >       data =3D con->eh_data;
> >       save_count =3D data->count - control->ras_num_recs; @@ -1944,13
>=20
> [Tao] Since recovery_lock is dedicated to protecting eh_data, can we unlo=
ck it
> here?
>=20
> > +1946,16 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
> >                                            &data->bps[control->ras_num_=
recs],
> >                                            save_count)) {
> >                       dev_err(adev->dev, "Failed to save EEPROM table
> > data!");
> > -                     return -EIO;
> > +                     ret =3D -EIO;
> > +                     goto out;
> >               }
> >
> >               dev_info(adev->dev, "Saved %d pages to EEPROM table.\n",
> > save_count);
> >       }
> >
> > -     return 0;
> > +out:
> > +     mutex_unlock(&con->recovery_lock);
> > +     return ret;
> >  }
> >
> >  /*
> > --
> > 2.17.1

