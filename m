Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85467C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 10:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE11A10E861;
	Tue, 14 Feb 2023 10:27:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7653A10E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 10:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrsguyvwYePEE0pDBwKqg+iVSVZw1dFBzjX0MtlppRbRaMyUk/uDVlUFQ8VMzgwe0gUvkKHQDK8bKHfKmc9Ym2BEINWhrhXH7BrYPEVqoZaUyimIanFBypOERDBIgUrnUyaD93nM6RseIthQvhNhXaviOxJEeYYj9B+zQnDvbLAM/ynWw/0Bto1Be7E9VnYlviI97BfySGo+qzXM55+oMzdL7ObHLF4ba3Q1RfFcgFWSJbo2AWwhtqrnBzFbssz+gmK6BBn7ITd7P0bB4dmJ+ydCBbO4crHsQTpUshS+kZ8dQT/7AzMxx7o1LFzM374/i8JPNkYNhdsurT5o+hHrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u19Wc1SkILIPVVYm5zl2MXLGLF1FNzrWXz7hUnRv2Ug=;
 b=gANfo/5pOERm6T07XGdZaJ7tiKdRgAExxblbNXXgFSX184Whel/9NsLoI1oa1wdPP3s8TGip2u7SY+hnLr038gxonzJheGtxugeyIx0Cw3C4y/59Q/4Df5fjYxMNZLv9l2UZuW5YEqaHwUrvHZji/kv2NR5O5nXRTGI+Z+2KzhXVCnwCe8njqs9x3pNb+jZwm6dqvYi7NyPDun+VPXOw7kZbnZXk39YkcGwoUSunEdABn8ZHY2CvUAMMzuU/3856/lLJ0qAmev0lvvpArTpulx6b2M5njRDsBV/yrQsysmSlWwiHb4iuLw60hVXF/fyTTVRemqkGY9+ASTHcn+43pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u19Wc1SkILIPVVYm5zl2MXLGLF1FNzrWXz7hUnRv2Ug=;
 b=nuy/9EZaw+g+vhCjNbsJTlK4766zVFcR/kR5yLZSpAlO/QQWV8XUX3sTNIFPYM2RpiDjtq93fJAQxuVYfMsMo2fGH36et0KCfZQpXX9PJQSAyRm3iNPwCtnHTljuwMTstbyB7dCPaFpwi/AduXjyDs++1xadHlscjHVhX+EvyJA=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 10:27:27 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:27:27 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Thread-Topic: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
 bad page
Thread-Index: AQHZPSwYCyokUNaSQkeAF4mLprNJJa7IRt4AgARGmWCAATQcgIAAez0AgAAGgXA=
Date: Tue, 14 Feb 2023 10:27:27 +0000
Message-ID: <DM5PR12MB17709A1BBDC1D6BDAC24AD6EB0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
 <BN9PR12MB525702B9A9FF262B9FA0CF02FCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM5PR12MB1770029EB462C56B50984414B0DD9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <BL1PR12MB5334C9F3F4623B4B3E63250F9AA29@BL1PR12MB5334.namprd12.prod.outlook.com>
 <BN9PR12MB52575D55D981DFD2ECCB790BFCA29@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52575D55D981DFD2ECCB790BFCA29@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=024f425d-59e5-430f-b54c-3a849f1aea78;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-14T02:42:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|DS0PR12MB7656:EE_
x-ms-office365-filtering-correlation-id: 613cfe05-ab02-47e9-34b7-08db0e761201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SyyiTAUapeux01z77MYUAt+UmEioWR4PWFUt1PGZaovYHCTn9+d6cW9rChj9zRHPLF6GvYkX8BkzeTkT66Il+oIrFdbyGW6VfiT7PcKhzeHpc6HWfFsO7EBfoSSOW3bp6sPYOE2kzMEstEn+aZftfRlIt9N8DjD+iVt2qKHeEzKpUCAEQkhmyMnSrmOYBYuUFeu/kRx7/cED7Xs9rakvo68XS+pzq/3b+qIpfNIejIWB/nBTryClBypTbGYmZ1U3uDjxnriRAghkRtszRNHBUgyLeJe/EBSL9RpDumWrbbXPlKptvY4safcDveH/n7+NTlqkO7AtH9bqAyvA/BepOYLzhmn4BV8SC1hyvQd1iMn048U3yo8decmd7uXItysP2DmbuL69gEaeoD3AfAKAY1vAVaDIeECqpPz/XT0ycpfEkbBrNoISeV9vCFpC0RmDgSRDL6QBjqC6TT4U6MO2HXMPzY0h0GfRXYY4Lj+efV3bRrwLc9WLcosoKmKLZxC8zWhtpbrHGSTbbNLMTcW7Yaf7OHdUL3Nvdv4+5zurz7q69Xy0aCmMHFIZYVIC6GARA4vqoBT3H/AYyn2ptAMN8omK5+/rVG2qqrP5Q/+KkC2xTnxzMlLwNRf45xQYxcoOahuzRl6VM235S5VQKpE/k9PK+JI6r14ER5p57yA/qNdKnhSWMddUUKvP1BTFWLvM5/EtPd+dwAdt71dnnEwi8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199018)(41300700001)(76116006)(66946007)(66476007)(66556008)(8936002)(8676002)(66446008)(64756008)(316002)(110136005)(6636002)(52536014)(5660300002)(38070700005)(186003)(26005)(9686003)(83380400001)(71200400001)(2906002)(86362001)(7696005)(55016003)(478600001)(6506007)(53546011)(38100700002)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?79ka4cLlixc+mk70TQZ/YSmEneMW5sFd5HK8jpBIugoCU7JMhmdI/XOwNKNs?=
 =?us-ascii?Q?kSutpwWP2REi6KYbOlED80hzYx3Q7r29KL/JpdJjm0xG+Wo29O/FiW+wAGe5?=
 =?us-ascii?Q?4WVmOLDvsJRcvcw08xo1y3+yfGSM/bP5fwOu0k9GxO5cl+TEr8rndwFffN06?=
 =?us-ascii?Q?YdLvzDth9Ft7SwqPHBQi0OvgU8ybkpIscW9QHzUvDbtcB7KoxQmyyaA5LJUL?=
 =?us-ascii?Q?aVk48x494g5A1K2jNdNfADzzlkdI1+/7Xlh/7xthSAdz7KB0dZjYoQwy3NLX?=
 =?us-ascii?Q?9ao7ISLX+xgaasQqVKMWBp4YdjfA9n/YCxJ9Z6JGZ6zs1VJ/FblRh7Un8KS5?=
 =?us-ascii?Q?Tp1nREfNvvRH3hw6z4nje3T+mrrCKGlokdeVhyc4Bw/j+Hu7ZgZ6u9SXfb5C?=
 =?us-ascii?Q?BIe0KJgMzxtKk2Yg0LQEl1tknO+eTHWbXZE0XqtXZh1QJ3hJwqjWqdruhcfz?=
 =?us-ascii?Q?5Pcsxjf+2QWLR5bkq3c0ktL9aTqESuNd8fA+mI5MlZ4hiLGV09jDjlq6o+nn?=
 =?us-ascii?Q?EG4h0O08GVBOvRHwfiSmHVTqcAHGONrLVFejdvlDjYRmQEWD52mWDVDfOiam?=
 =?us-ascii?Q?2oSC3+V7sz5fRmCNDuLHYh65NZkvheLS3unIRqR7EYIjdGgttbHobG1U8zqJ?=
 =?us-ascii?Q?wQc6qBr2EYRaeVJDIbHhZfdmziJ0ipiVL2TGT7Q1A1/mGLs6YbhJnRORwjk5?=
 =?us-ascii?Q?ngF+6BT9ALMPPy8NYUnKOzGnhaqIbpMDQy6u+xKF0cIGuVbawBcMGEqhrXU/?=
 =?us-ascii?Q?rFeLk8Fb+ADZ4bKN2YqvLzPxZJOnPbqb6Ncxq3JXxPoZwOeWV68PlfQu35r2?=
 =?us-ascii?Q?PLYnyubeZnmJMTnFGfrXc9n7zG4fSISV3KXG3akw5RnHpDNUQCUYepexSbE3?=
 =?us-ascii?Q?CWwgxI4/a7jJmFp6693d9T4FiOCm+5o0NGn3HiAZQ65dwDh3zaRztCBQJPVe?=
 =?us-ascii?Q?1t8Z2VrZts0Ao8lHSmu3y+HP2fkXP3ihy3BvjknIeEf1tBdQPbQ8drj2lwbv?=
 =?us-ascii?Q?Rs2w1hn2JWHLnKVl6iJGzcE+bJZhlUkOdggl+mNwnx41HUzywQSs9VNRgO2o?=
 =?us-ascii?Q?jxs7ZlUf68/WD1R1u4GKNfIajSJwvg1sD1nOPVyToSybIvDsjM/Fscz8NLCO?=
 =?us-ascii?Q?v0ks78qUM8SS2im3ikXB4Koj2rEnjhem77I1lORM0J9e4crBzsyWASy2vYev?=
 =?us-ascii?Q?8SaoLeHHL6cSt2hAGTLKsZXADPPhxRaLf0ydzx73fghBDCV5rzdzQ/qTkVGi?=
 =?us-ascii?Q?S848Ereojk9RVt6KlSsLLMerkbg7gjqmpY6gI/j1umjIzlMlviyDGrShH+f6?=
 =?us-ascii?Q?AljJX8i7NyLzwb7rrwIXlrQjQwWxvOAoPpQca7p38CnSBvV6wyOKyAaLJQ1P?=
 =?us-ascii?Q?PHWNsHccqPqpD/tVAa5/rXowM/blB0UXq1r1eVXpOyiUfgvW1eW3hbFjeAiC?=
 =?us-ascii?Q?vRX7t0dGGfaaauHviss9DZJe8JE25gupQdYI/tggCscV3Awr/FF+7EjIsiZ6?=
 =?us-ascii?Q?/+/Tf/uraCslPxKK64aoZqq0SZl1HRnMK+BgmsZlgLsdkM2WdwGL5Uj6VGM2?=
 =?us-ascii?Q?2ImjiMdof61Un25uUkQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613cfe05-ab02-47e9-34b7-08db0e761201
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 10:27:27.3430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KxbA1/DsFTe9Vg32gg3qQKQviZGoTebr8iG8Zzt29BRrx6seVUCBfvfz5ydAM5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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

OK, I'll add a new function to do the check.

Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, February 14, 2023 6:03 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Chai, Thomas
> <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no ne=
w
> bad page
>
> [AMD Official Use Only - General]
>
> -EINVAL looks better than EEXIST, but it still doesn't fit the case? Alte=
rnatively,
> Can we compare the count before and after amdgpu_ras_add_bad_pages to
> decide whether reset ue_count to 0 or not. That could be straightforward =
than
> struggling for returning which error code in this specific case.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Tuesday, February 14, 2023 10:42
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Chai, Thomas
> <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no ne=
w
> bad page
>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Monday, February 13, 2023 4:25 PM
> > To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-
> > gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> > Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no
> > new bad page
> >
> > [AMD Official Use Only - General]
> >
> > > -----Original Message-----
> > > From: Zhang, Hawking <Hawking.Zhang@amd.com>
> > > Sent: Friday, February 10, 2023 11:02 PM
> > > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org;
> > > Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> > > <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > > Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if
> > > no new bad page
> > >
> > > [AMD Official Use Only - General]
> > >
> > > +                       /* if no new bad page is found, no need to
> > > + increase ue count
> > */
> > > +                       if (ret =3D=3D -EEXIST)
> > > +                               err_data->ue_count =3D 0;
> > >
> > > Returning EEXIST in such case is not reasonable. Might consider
> > > return a bool for
> > > amdgpu_ras_add_bad_pages: true means it does add some new bad page;
> > > false means it doesn't change anything.
> > >
> > > Regards,
> > > Hawking
> >
> > [Tao] but it can returns -ENOMEM, amdgpu_ras_load_bad_pages and
> > amdgpu_ras_recovery_init also need to check the return value. I'd like
> > to keep the type of return value unchanged.
> > How about -EINVAL?
>
> Stanley: How about return -EALREADY?
>
> Regards,
> Stanley
> >
> > >
> > > -----Original Message-----
> > > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > > Sent: Friday, February 10, 2023 16:45
> > > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > > <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>;
> > Chai,
> > > Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > > Subject: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no
> > new
> > > bad page
> > >
> > > If a UMC bad page is reserved but not freed by an application, the
> > > application may trigger uncorrectable error repeatly by accessing the=
 page.
> > >
> > > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > index e85c4689ce2c..eafe01a24349 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > @@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct
> > > amdgpu_device *adev,  {
> > >         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> > >         struct ras_err_handler_data *data;
> > > -       int ret =3D 0;
> > > +       int ret =3D 0, old_cnt;
> > >         uint32_t i;
> > >
> > >         if (!con || !con->eh_data || !bps || pages <=3D 0) @@ -2060,6
> > > +2060,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> > *adev,
> > >         if (!data)
> > >                 goto out;
> > >
> > > +       old_cnt =3D data->count;
> > > +
> > >         for (i =3D 0; i < pages; i++) {
> > >                 if (amdgpu_ras_check_bad_page_unlock(con,
> > >                         bps[i].retired_page <<
> > > AMDGPU_GPU_PAGE_SHIFT)) @@ -2079,6
> > > +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> > *adev,
> > >                 data->count++;
> > >                 data->space_left--;
> > >         }
> > > +
> > > +       /* all pages have been reserved before, no new bad page */
> > > +       if (old_cnt =3D=3D data->count)
> > > +               ret =3D -EEXIST;
> > > +
> > >  out:
> > >         mutex_unlock(&con->recovery_lock);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > > index 1c7fcb4f2380..772c431e4065 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > > @@ -145,8 +145,12 @@ static int
> > amdgpu_umc_do_page_retirement(struct
> > > amdgpu_device *adev,
> > >
> > >                 if ((amdgpu_bad_page_threshold !=3D 0) &&
> > >                         err_data->err_addr_cnt) {
> > > -                       amdgpu_ras_add_bad_pages(adev, err_data->err_=
addr,
> > > +                       ret =3D amdgpu_ras_add_bad_pages(adev,
> > > + err_data->err_addr,
> > >
> > > err_data->err_addr_cnt);
> > > +                       /* if no new bad page is found, no need to
> > > + increase ue count
> > */
> > > +                       if (ret =3D=3D -EEXIST)
> > > +                               err_data->ue_count =3D 0;
> > > +
> > >                         amdgpu_ras_save_bad_pages(adev);
> > >
> > >                         amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> > > >eeprom_control.ras_num_recs);
> > > --
> > > 2.35.1
> > >
> >

