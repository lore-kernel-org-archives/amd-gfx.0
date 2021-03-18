Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDC3C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 16:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2A164E89
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 16:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2A164E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7126E920;
	Thu, 18 Mar 2021 16:34:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBED86E920
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 16:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/k4M6Ra4NhBDO68G0AiwiTu/oNj80oILoS70owqkIB2BOIHPI9b9LWVgQjRCRFmkokQtjizlpS72bFTlrgBvxO2lnCLhPt1ItfGkcOnR6zOFHx1fdLQcIeFT0kTtebiwiLlJZtY3RL1ZSwabu41XQmqr1p9cS4yCLny8ZDef/xtqWPAKrsUR43COKwtVmS9kTgtJT0EGKBTrDr5oBeaMXGPrRKE7O8wN148P9oXJwaFYGz0/ZxWFMMHtpJfLbdhSDP3oriQ7zH9xZTPeAqwYEQVOpP21knkfxxGWRuEMx8ASfVFjv2RoqsuAcvLs7amiOznn2MCfMDknoVZmoSa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YytM2DXloH73rfYKx56k7ah23WZohTFbNNPH3dHSbkY=;
 b=LcgsqQuZZ8BE8vQzIdcB6YEPxESDVR/WACGPb6Cmi0+lHKrS0hdsliT00sb6kv/s9ktIPj0qKkD/cXPLz/LRK8BvKEJICBBfFAwh6BeLXLCgz0USCJL/0vVBq+uRtg95yIuJbuDwgn9BhWN5y3xH7sqykmcqh8N5twavSPZ4z+38Xve5iDuHJn9MmYOmaTrkqg2YRUgpDpS4Hh4Mv2JXIP1FhxIq/1L4CsDHaGhkbX9Ia4bJSKTef+Eid03WRqNr19joubefmsGyNWmYUxgAMXy07CQWCIYC3DQq/uNZoAAHS66TamiWJIitW/47HxSxmLja15qKm6+RVAgBq6lpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YytM2DXloH73rfYKx56k7ah23WZohTFbNNPH3dHSbkY=;
 b=EkO/X1o0+78kL371IV5kovXO3ulbrrOKrsdL2JhPAAgcY77kSlEv0y22WCbJKKx2SvCBX9++dxcQ3vAk/A5uP0RRY4e2ffooUeGegv/LCAfgr20ukra9d1hD4cPqU5HV1Iwh6eiAqjTkR8flPJdYa1ukXO4T9N1MoWXJI+AJZxM=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 16:34:09 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 16:34:09 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Mark Albebaran HW support as experimental
Thread-Topic: [PATCH 1/1] drm/amdgpu: Mark Albebaran HW support as experimental
Thread-Index: AQHXHBCYGQ4g0pQZ/UKqzjYb2ngpmaqJ8EqQgAAAfhA=
Date: Thu, 18 Mar 2021 16:34:09 +0000
Message-ID: <DM6PR12MB3324A66C2BD696B8A8161F8785699@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210318160530.260-1-Felix.Kuehling@amd.com>
 <DM6PR12MB33245CF78AA4127C302A081E85699@DM6PR12MB3324.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB33245CF78AA4127C302A081E85699@DM6PR12MB3324.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-18T16:34:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fa7a4de0-2407-499d-a991-edd45828ca15;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:bdda:d651:986b:e5da]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7435a1d0-be61-4ea3-d700-08d8ea2ba803
x-ms-traffictypediagnostic: DM6PR12MB4339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43392DBB4F807BCF8513782585699@DM6PR12MB4339.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mjCViVlTPT11mO4ZI7iPkFOO0qR8/yaHjpl3MPOhk7CUEOqI6GAo3FeDnPXe5dn0VqNulwmiZoq1+ZI8uTn7jgaDcb+p+oYXEOHNGRB4Vb5XSKPDLmDnpTu60jA9wVd+F4TTlnio6r7hdNsjxUa2kh3uP5gq72OLqllU9OJDbDrO9aDtYUmOrIxcip5ZSmKYxFVR5Nt8tcd1Oj3XKeUzKH9t2thfmgnD6a3PkAPf1s2IFWgnQU4eE9nhDGgfqax7ee+OQvn+M8cMEAoIx6x4kUWo/jt372fQW4Ik+Q2mJZsk4RklSuRgDHydNd+Y0mPoJXvqde4EJ00pzvveuVkB94v3WzdG0yDYF8OpgoTjPnpbDU4XwntrWD0NIp2pftI5U58o8SZoXICMaMjzqkouuHtZGXctmQSD6vx+jGJyL0Kw3yGkKwC7O+F3MQdsKinEc7PxaswjL8z4fj1rbtWYlpyijV0r2ulmwEh52m1CiwObuCxhvSTk3YjR9NvkE4efNzpXUAbrIALHrz3SSo9Z3lNDxnKXAJ1Do4jIskXnryF4qo8+xA6aYFxXbQBwL0B/NOjMp05zdebeo2HFWaMZyQ0THDTdmqWgYMa0FZiTYcEz/HfhzAB3G13Z57w+Bl9hk9OoF0qfFx3u8QaRR6D0DFJg6sTBxCg+mRPM92a/H1KIsY+hXvnwtvtL1NlkUYpn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(5660300002)(186003)(83380400001)(66556008)(9686003)(66446008)(66476007)(966005)(38100700001)(33656002)(110136005)(7696005)(53546011)(6506007)(45080400002)(64756008)(478600001)(8676002)(71200400001)(86362001)(66946007)(316002)(2906002)(2940100002)(8936002)(55016002)(52536014)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KM6VPtE69Xqd5SeGj9Sx6Ie1mRNLIYQ9KtW1idUI+wob1s6y5gAryqmIpF8Y?=
 =?us-ascii?Q?P01a5th2Hne7LVkfzUeRJG5gf/VrHyWfjtgJdb9CC11kOdllBZb8ECV01iRi?=
 =?us-ascii?Q?+Eaoh71AY1NdigVrIrfzzXZfzYX0yiQ9q5ObXCokNnixKSD5LonUg4fUa84k?=
 =?us-ascii?Q?x5IVldzsQa+ofeH5HMCppSLC7h9pruqHT+SYodoZgYUXexZy8eVAGYIMLX1J?=
 =?us-ascii?Q?59Wdo9LU3Nty9O8r5HSVrUNNe3ZrF/hlqBFRJIcyQS07KQKQpWC0Y/I/z+BD?=
 =?us-ascii?Q?Y7dVFqz3Ar6KZtL/h4FGZBbASR9TS7+Wr0IA0Z54+KgVkYrYbM3raezNdv6y?=
 =?us-ascii?Q?FcCKF6TxTVrgvCils9pnHww0l/SG/ZTLS0BrVi43m7ZlIyqNi6xirGl/07of?=
 =?us-ascii?Q?Qd/9Kx5w0FCfxekSa2A9NZClZfiChI9IVJeIu/eGfY/iiMWC2Cez1TAkFOZ0?=
 =?us-ascii?Q?iahZCSRIKHC1y2yWTYbGAOjwK/arIQXclQrLkQTvLjOfwVkilGxm0nNG2vq8?=
 =?us-ascii?Q?fULSfAm9DRGsmhnJZdNAmIQPZpiw3vX7O1LS3qjmg1CsnpnJ4zKgycN7xraf?=
 =?us-ascii?Q?bLd6F3OnlD79VaaYk1GTodX/Syq3B3ZfZmKl7DrVZ0HrVkvkQHh4hCXIfHFb?=
 =?us-ascii?Q?7rI7g9lrZ5o7mZ+wh8MWpR3rjk4pmrkdS8ExN9QnpW4PJUE4bL5gdpi0fWSt?=
 =?us-ascii?Q?3ahlKGtSGHuZiL3enQRLI5LbBVlvNg70ko9fHphVyfV/WUpPwWWkcZAYIAJK?=
 =?us-ascii?Q?WU9UmXDEGZDPkU5DorYQOJ6Ld7kBsZekOMwqU7GTEk5Km/vjxPCSo0AbDXGX?=
 =?us-ascii?Q?tfaqtfBRcaA8X2H8QtNutmLIb0oDSrL8KR5HtkBnMU+CtTo+jb8XWqZtcgVL?=
 =?us-ascii?Q?jscQs5TbxFjr4Cp8We9q58b3yfBYpshgwzsJudA8p9pmYZVyAWxdrY7CqAIW?=
 =?us-ascii?Q?bqohQ/LeqwPWgKrPgTBWkURXvs2lubPadgNhMgmw+iem8PhBqZl8xf3iSfHy?=
 =?us-ascii?Q?PHAPngHDg8Qee9mnMDe2xhOJI5uFa1CRkxxG6p8jCYdInYml6VC6+T/DpEzh?=
 =?us-ascii?Q?F3wcJfpBsGcy507R1GbIfuZaq/jMpViIGcIajJYKzF/Xy8JZ6hYpXgem1GFC?=
 =?us-ascii?Q?NU6jUJV/bqgDVjHkYnoaDBTA16Mfpj2N9E23bg4y9aFJLwxyhm134fd/JJrz?=
 =?us-ascii?Q?SY1jJzC8/sBm675jbJ7GoT70nLAndfV96W6/d7efHauQ2cRVI70+CciXSoz6?=
 =?us-ascii?Q?NJn90i/46ib8NxtK5Pw/1O4fPZs7oOEWjF1EoUrdQt8O56wfXTR4z5PaeCap?=
 =?us-ascii?Q?T+YOaeGWmK9h/JTFoyrQ4m/br7sNb94ShE5iBmWN6Ct77lAnnn1zkcXmOdLC?=
 =?us-ascii?Q?rw0XjKnIL82GGJZEDyfJfPlSe6tf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7435a1d0-be61-4ea3-d700-08d8ea2ba803
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 16:34:09.5163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRRDUV27R3PFse0ILPRHokf4TRI/gYqI2p7nQF2f8kQdvugY64NbAgd+8JQl76Tk2kFtqQiloQCft04aSPlZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Sorry, just realized a typo in the headline. Albebaran->Aldebaran. With that fixed,

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Russell, Kent
> Sent: Thursday, March 18, 2021 12:32 PM
> To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 1/1] drm/amdgpu: Mark Albebaran HW support as experimental
> 
> [AMD Public Use]
> 
> Reviewed-by: Kent Russell <kent.russell@amd.com>
> 
> 
> 
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> > Sent: Thursday, March 18, 2021 12:06 PM
> > To: amd-gfx@lists.freedesktop.org
> > Subject: [PATCH 1/1] drm/amdgpu: Mark Albebaran HW support as experimental
> >
> > The HW is not in production yet. Driver support is still in development.
> >
> > Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 2e7b5d922f31..a3e3760e8d62 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1179,9 +1179,9 @@ static const struct pci_device_id pciidlist[] = {
> >  	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
> >
> >  	/* Aldebaran */
> > -	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> > -	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> > -	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> > +	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> > +	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> > +	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> >
> >  	{0, 0, 0}
> >  };
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> > g%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7Ca58b14d47cbf4b23a11008d8ea27
> >
> b9ec%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516803643712583%7CUn
> >
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> >
> VCI6Mn0%3D%7C1000&amp;sdata=yPjcheikiBkipF6jux1pKQv2XpNDXxEEDxu022uOB40%3D
> > &amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7C680802488a6d4bc9d09d08d8ea2
> b68f0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516819462779878%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C1000&amp;sdata=B7hAa4%2B3IZiEcc34%2F8YLTn7p7%2Fb7yWYtOtPVLzC
> Zs90%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
