Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7162C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 12:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A37011B0A0;
	Mon, 20 Dec 2021 12:51:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE6111B0A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 12:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQE6ogLNeBgevo2yRV9/GGZ3UemnakXFxZ7HkI/Wn2I1ZfkyPMcNWPMs5ZN0TKxJFVaOey/vFyzsYtaJPVUaoImjkjkn3ZQy+kHwe/kess/Qd6STC+3WlzsLBufT4hpjDI80/SJZhIfFRbAvNemto9R9SdfmDKiqXtKH7u0UwyVrs0fx2hymV8RA1+xfxh7zkTyRZCFiiDal8yzgvq/1H5ZrEpRnUnGdpoA3xRxSLIJM38iEcurKmA+AHoSvGfKbav7TMFag+/vAn+SZ9cddSBomZa9xDKtqBpObR7mM8JCgq0+05MbAKr3El+Le5x/QZdh0wjkhvIh5CCgrFp52+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq1MM41cPLrNyoByFDgXUACKXAvMdZxSXiCz3kJ9Qg0=;
 b=QuLEvGfx6p59THFKNmmw222VQS/9P4wHTbl3pg6jsk7Xjc7zsYvKG7Dl/MZGoDRusGGon+iHpWrzVTVyVshATHnS59ViFEPQfOsXgWu5M0k0tiAp45orPqvWJJId70oQACmMv5q2Iqo6gpwEc50oUcVsH6fMjTpVsm9H41a6CDKcVcvwfI8pmYfzRpOKkY4gUtlgGPieXUrMqMN+wnCOKczGZN5y2RFrYkFo7aEBmynk+hSk+WmhfRM3KqB1gGYsH513RBHuMY4nTHtEkf0ljfJmSylBd+wogOtJ17LT6jdjU01CO2Tg2fW6t/JKp+JWmGeXqsR0pWSEd3ycbtQmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq1MM41cPLrNyoByFDgXUACKXAvMdZxSXiCz3kJ9Qg0=;
 b=TYkWVWLLsvxOG7PPi0MRUjeh7a2p+xxH8YMX2T7z5S6rg7rNkL7N2NDzK/0eGYfWY6KK6mcVQCumqfIBHD9WjPvu9FRWiasFoVY7eoAfLHUpW6JM+Qt9OyP9rKknkzAcqVBElcEBeAbvwZen5veqZly9t3fCibPeCWLiVHY7qVA=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM5PR12MB1595.namprd12.prod.outlook.com (2603:10b6:4:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.19; Mon, 20 Dec 2021 12:51:10 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 12:51:10 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Index: AQHX9U73J+Gwhw9bDkC+52llWaYzZaw61QYQgAATcICAAGyewA==
Date: Mon, 20 Dec 2021 12:51:10 +0000
Message-ID: <DM6PR12MB31634CBD03D7FE095B38C658857B9@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <20211220030849.32458-1-guchun.chen@amd.com>
 <DM6PR12MB3163F586AB5EED14E56AA455857B9@DM6PR12MB3163.namprd12.prod.outlook.com>
 <DM6PR12MB3067D18C422AB01AE376DFE98A7B9@DM6PR12MB3067.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3067D18C422AB01AE376DFE98A7B9@DM6PR12MB3067.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-20T06:02:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2350a017-1461-4d73-a390-1767873df162;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
x-bromium-msgid: 1d590d19-78cf-431b-a05c-0357f8d16efa
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a93f1325-9a7c-45ee-5208-08d9c3b765e9
x-ms-traffictypediagnostic: DM5PR12MB1595:EE_
x-microsoft-antispam-prvs: <DM5PR12MB15953445298BC3E8D6171A2C857B9@DM5PR12MB1595.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8SBtMbfMVxHFCHzLrsmHXf75LRY9y0vIKRP+za+ekJCRNc1htEsAn/XmxZgNY8vdMDLmXUSo2+6pup8h7qCo9GhA1Pdj4eDJBTvL3Po7ja53JFWNsxOzL5kshPkBtZ437FriungdEgY6EOx/Fc0M8W1r/9crRxaDGCHbFmCa8EhDt7K42+vG24qw1D2VxSHAUX0U2m9NcFaVfsswQEHU1KbFIQRnQrq5Ov8VSSj1JA7PEFslN82WD8xCjxjy0cT49FX/e9xvu5yjS4It2qQYxtbs2IXEoRLmlQtrZ0SiYECUivSYAMMR5G/l1nm5YCA/ImH9LlUu0uwoZWMe/tsOiurOuJowVBWO1ORCF7yO7AyxjB2LMgwHJ+cjMbEPYE5so794adhUZwppSo2lPFMkbEG+aa1s9JkNLjYEobsNN2mmHg4cU1+JDBWGRnCjXln2tsolvjciCUyHyTFYhMwXZNuHVshlcxS7LOU+k6tG4tHQBSz4T7IQAdj5J7A1ZSKUooACePpdRcaXOd3iMtr7KsGyG2WGUyQbqUps8U0bpt97nrZl6bnKWK2ND9/xsGprj5nsoLNVHNsUK4hs42c/EtkLOp39ntKrvVrLMQDGh2Q0I3wH3Cb1uvrY2k2g/RCFkPR+xSkoQDu3yj2hNtJ9CSZhbVSupV+U1bocfql+vl/7wtyWZ+MaZ/kgfS8ELGOe8kA599I9K44qDcOmf5DDLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(52536014)(8936002)(9686003)(71200400001)(6506007)(53546011)(38100700002)(2906002)(508600001)(66446008)(76116006)(186003)(8676002)(5660300002)(7696005)(33656002)(83380400001)(66476007)(38070700005)(66946007)(64756008)(66556008)(6636002)(110136005)(55016003)(122000001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OJ6FWg9UVvVIepP/yuwW2HnDc6ti4DSc6O7cWJBWV38IwHG2pRK3V1tmyJXb?=
 =?us-ascii?Q?xhlauqjA2nus2AmrxAg7LIR7wf6Utb8PUV9so18D1Jdtyt9j5qHVFcOgwHMV?=
 =?us-ascii?Q?ZOOoTSbYj7Xhh5TrD2Hiou5pas2NPS+xz6eExFWVBrfOQp6uoRI56sGUixvT?=
 =?us-ascii?Q?IrFl7gHdR0N37fiMKrO3tA3imvbbBqC7n9Ifoe8CN42IkXGi30Ry+0N7kG1U?=
 =?us-ascii?Q?IiwmF0pwLVIrZpTz29uxryMeJkwAPRFMUFUtbjJNBZzAWp7NEYlgKbQ3INC5?=
 =?us-ascii?Q?5AcCEcQJXRP1GI0cIX9t6pJMte87Pwb27sNrg40+UMU5InPndWTzPSc1I82l?=
 =?us-ascii?Q?aXY+lCK6s38zss1w1JTO6efNE4WjuXuXfJLy8I3tfJBdVMZ3JmPIq5LaU8kf?=
 =?us-ascii?Q?IuxdRvgmtIb0Gnzc6ur5cIcOowc4kKqWCvIWMPcJErocvQ71hLTqgK7ycJOI?=
 =?us-ascii?Q?cMuTemyWMCMbqPd1yMxSmBeOUb9mHsD61kFi1tnfhCPusu0n5K6sgig16SmS?=
 =?us-ascii?Q?BFDHZs3HfLuo1DhGxfqCvncOIx8zuwBGU83PmlQTFCB4lyjzIaeXEKUMXUnx?=
 =?us-ascii?Q?4sZ/Nd5DxAGqGDUEKZb7qafVhCL2wlO+l7sEhiuS/QwCVZPImE+cThGqP9BX?=
 =?us-ascii?Q?M98a1FKfI1MCJqWxKyFzhO1slq7IKpx3lhXEFhKyUQAM6UhuWw8NM3DJwtNR?=
 =?us-ascii?Q?nPKzTV8k+9Qtw2KTVak+KclX5CnCH5pUPcNNC8kJJ+mCBDbEBWwJNQFkq2dO?=
 =?us-ascii?Q?+2iE85jaZ5rxy8aUuKLEdlE9tW0LFQmkwqbkN/TOf/F2RXMcXUIkJQLkcG1S?=
 =?us-ascii?Q?ob/pwnnEh2Cy1noydd9vgD8GdPiiuqeGdgObXBA7WkK8KrJdmDSeqrMqffyk?=
 =?us-ascii?Q?/NoYsA0gMCKrW4mFofWunxtBk7CBNKY/h92LDnzlYxXjY2RLMbV+vtAMqTB8?=
 =?us-ascii?Q?6WqnVeMkcFUT8IWhRM8nyk23th/6JCR20ZAiS/qdyavN9VHtLiHuE7tQeA4I?=
 =?us-ascii?Q?hTrACTwxRb/4I7YkauR1P/eJzsQBofUtkE3seSiqk4TCqR7fg9ZAH3z6kQ19?=
 =?us-ascii?Q?vt/o17aX8o7KsCzRbAO9FnFU1VrLkFQCq1S67LolpT8s8P/f0w3WLQeE6vJQ?=
 =?us-ascii?Q?N6UcyeLLpDwbQqfGr9VjM3ep2A+hIJtUpaUVpn/0yEFs1cSxpwd64dy7bgNx?=
 =?us-ascii?Q?8NqQAF8b1bl5Ak6E8nkQxhUpRkJPsgM6uYE/8PQ/kD0sKckb8QRnyeDk8IKt?=
 =?us-ascii?Q?pK2J1lSa0QnL9YztNOvjnagdHJGI1sE/lKigacGyBuT90VLeaAjfQZFMcFye?=
 =?us-ascii?Q?S266C9TFgQf/3y56T+lyU4A7B+xMhvFDsxqXljuQshLF8X4TXXqlAbWvXNUJ?=
 =?us-ascii?Q?XK1sD2TK57Zhh8LaB8Yz0wnR2YJMJBlm3CRy4dsS3m4/rkmHaEHhdndcX3Fp?=
 =?us-ascii?Q?3V2exsbdY3YsKVLa/Go39vtZUdwP5sJjACDX9w9wXSM9IXOvLZnPSB+vgiMN?=
 =?us-ascii?Q?Uv3syyNaitYmmdCj6iUNDl2T2S/YIkoBWxp4GwyV9Zxn8FdCjkcZmTP//Bw+?=
 =?us-ascii?Q?H8VyRHVeWOATivhUZXa2OHAd8IJauynmqRJIGKYfp8QaCRCQ1M4nKZh1evJF?=
 =?us-ascii?Q?7ams3RLnpIVZUPiHnAChexY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93f1325-9a7c-45ee-5208-08d9c3b765e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 12:51:10.4919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ThhWbyaSG67jkW4C18Qqv6kFBrzojR+tA0CjzfDi8MBQ8WqCqgCPOC7AHh9odPs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1595
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



> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: December 20, 2021 1:19 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd
> device init (v2)
>=20
> [Public]
>=20
> > -----Original Message-----
> > From: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Sent: Monday, December 20, 2021 12:44 AM
> > To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
> > gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>;
> > Kuehling, Felix <Felix.Kuehling@amd.com>
> > Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd
> > device init (v2)
> >
> > [AMD Official Use Only]
> >
> > > -----Original Message-----
> > > From: Chen, Guchun <Guchun.Chen@amd.com>
> > > Sent: December 19, 2021 10:09 PM
> > > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Sider, Graham
> > <Graham.Sider@amd.com>;
> > > Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> > > <Jonathan.Kim@amd.com>
> > > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > > Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd
> device
> > > init (v2)
> > >
> > > sdma queue number is not correct like on vega20, this patch promises
> > > the
> >
> > I think you've also fixed Vega12 and Raven (they were being set to 8
> > before rather than 2).  No need to mention this in your description,
> > just double checking.
> >
>=20
> I believe it was only Vega20 that was being set incorrectly. The conditio=
n
> was:
>=20
> 	sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> 	sdma_version <=3D IP_VERSION(4, 2, 0))
>=20
> which encapsulates Vega12 and Raven setting sdma_queues_per_engine to
> 2, but also accidently encapsulates Vega20.

Ah right.  It was a range check before.=20

Thanks,

Jon

>=20
> > > setting keeps the same after code refactor.
> > > Additionally, improve code to use switch case to list IP version to
> > > complete kfd device_info structure filling.
> > > This keeps consistency with the IP parse code in amdgpu_discovery.c.
> > >
> > > v2: use dev_warn for the default switch case;
> > >     set default sdma queue per engine(8) and IH handler to v9.
> > > (Jonathan)
> > >
> > > Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
> > > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> >
> > Other than the missing checks for Raven when setting the interrupt
> > class (see inline comments and reference kgd2kfd_probe in
> > kfd_device.c) and one nit-pick inline, this looks good to me.
> >
> > With those fixed, this patch is
> > Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
> >
>=20
> Other than Jon's comments, this patch is also
>=20
> Reviewed-by: Graham Sider <Graham.Sider@amd.com>
>=20
> > > ---
> > >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 77
> > > ++++++++++++++++++++++---
> > >  1 file changed, 68 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > index facc28f58c1f..36406a261203 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > @@ -59,11 +59,75 @@ static void kfd_gtt_sa_fini(struct kfd_dev
> > > *kfd);
> > >
> > >  static int kfd_resume(struct kfd_dev *kfd);
> > >
> > > +static void kfd_device_info_set_sdma_queue_num(struct kfd_dev
> *kfd)
> > {
> > > +     uint32_t sdma_version =3D kfd->adev-
> > > >ip_versions[SDMA0_HWIP][0];
> > > +
> > > +     switch (sdma_version) {
> >
> > Please pull in the indentation for all cases to line up with the switch=
 block.
> >
> > > +             case IP_VERSION(4, 0, 0):/* VEGA10 */
> > > +             case IP_VERSION(4, 0, 1):/* VEGA12 */
> > > +             case IP_VERSION(4, 1, 0):/* RAVEN */
> > > +             case IP_VERSION(4, 1, 1):/* RAVEN */
> >
> > As mentioned, you've also fixed Vega12 & Raven here I presume since
> > afaik, they're based off Vega10?
> >
> > > +             case IP_VERSION(4, 1, 2):/* RENIOR */
> > > +             case IP_VERSION(5, 2, 1):/* VANGOGH */
> > > +             case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
> > > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > > 2;
> > > +                     break;
> > > +             case IP_VERSION(4, 2, 0):/* VEGA20 */
> > > +             case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> > > +             case IP_VERSION(4, 4, 0):/* ALDEBARAN */
> > > +             case IP_VERSION(5, 0, 0):/* NAVI10 */
> > > +             case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
> > > +             case IP_VERSION(5, 0, 2):/* NAVI14 */
> > > +             case IP_VERSION(5, 0, 5):/* NAVI12 */
> > > +             case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> > > +             case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> > > +             case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
> > > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > > 8;
> > > +                     break;
> > > +             default:
> > > +                     dev_warn(kfd_device,
> > > +                             "Default sdma queue per engine(8) is
> > > + set due
> > > to "
> > > +                             "mismatch of sdma ip
> > > block(SDMA_HWIP:0x%x).\n",
> > > +                                sdma_version);
> > > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > > 8;
> > > +     }
> > > +}
> > > +
> > > +static void kfd_device_info_set_event_interrupt_class(struct
> > > +kfd_dev
> > > +*kfd) {
> > > +     uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> > > +
> > > +     switch (gc_version) {
> > > +     case IP_VERSION(9, 0, 1): /* VEGA10 */
> >
> > Missing check for case IP_VERSION(9, 1, 0): /* RAVEN */
> >
> > > +     case IP_VERSION(9, 2, 1): /* VEGA12 */
> >
> > Missing check for case IP_VERSION(9, 2, 2): /* RAVEN */
> >
> > Thanks,
> >
> > Jon
> >
> > > +     case IP_VERSION(9, 3, 0): /* RENOIR */
> > > +     case IP_VERSION(9, 4, 0): /* VEGA20 */
> > > +     case IP_VERSION(9, 4, 1): /* ARCTURUS */
> > > +     case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> > > +     case IP_VERSION(10, 3, 1): /* VANGOGH */
> > > +     case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
> > > +     case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
> > > +     case IP_VERSION(10, 1, 10): /* NAVI10 */
> > > +     case IP_VERSION(10, 1, 2): /* NAVI12 */
> > > +     case IP_VERSION(10, 1, 1): /* NAVI14 */
> > > +     case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
> > > +     case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
> > > +     case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
> > > +     case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> > > +             kfd->device_info.event_interrupt_class =3D
> > > &event_interrupt_class_v9;
> > > +             break;
> > > +     default:
> > > +             dev_warn(kfd_device, "v9 event interrupt handler is
> > > + set due
> > > to "
> > > +                     "mismatch of gc ip block(GC_HWIP:0x%x).\n",
> > > gc_version);
> > > +             kfd->device_info.event_interrupt_class =3D
> > > &event_interrupt_class_v9;
> > > +     }
> > > +}
> > > +
> > >  static void kfd_device_info_init(struct kfd_dev *kfd,
> > >                                bool vf, uint32_t gfx_target_version) =
 {
> > >       uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> > > -     uint32_t sdma_version =3D kfd->adev-
> > > >ip_versions[SDMA0_HWIP][0];
> > >       uint32_t asic_type =3D kfd->adev->asic_type;
> > >
> > >       kfd->device_info.max_pasid_bits =3D 16; @@ -75,16 +139,11 @@
> > > static void kfd_device_info_init(struct kfd_dev *kfd,
> > >       if (KFD_IS_SOC15(kfd)) {
> > >               kfd->device_info.doorbell_size =3D 8;
> > >               kfd->device_info.ih_ring_entry_size =3D 8 * sizeof(uint=
32_t);
> > > -             kfd->device_info.event_interrupt_class =3D
> > > &event_interrupt_class_v9;
> > >               kfd->device_info.supports_cwsr =3D true;
> > >
> > > -             if ((sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> > > -                  sdma_version <=3D IP_VERSION(4, 2, 0)) ||
> > > -                  sdma_version =3D=3D IP_VERSION(5, 2, 1)  ||
> > > -                  sdma_version =3D=3D IP_VERSION(5, 2, 3))
> > > -                     kfd->device_info.num_sdma_queues_per_engine =3D
> > > 2;
> > > -             else
> > > -                     kfd->device_info.num_sdma_queues_per_engine =3D
> > > 8;
> > > +             kfd_device_info_set_sdma_queue_num(kfd);
> > > +
> > > +             kfd_device_info_set_event_interrupt_class(kfd);
> > >
> > >               /* Raven */
> > >               if (gc_version =3D=3D IP_VERSION(9, 1, 0) ||
> > > --
> > > 2.17.1
> >
