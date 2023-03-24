Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536C0C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 07:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D426310E502;
	Fri, 24 Mar 2023 07:04:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C7710E502
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 07:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoIA4717BBL36ejiCxVkSgi7eNsBTuTRTFp8FPIui3615w8W7mzZ205FncBBAsXkJLDlnxMSkZctFJDhcESZApHcYubRzDOgpjekqtr5Kz++1gWyHnjhmaZMzH/pjkkci6+MRLDFLLHv+rvCGdn6fea33dhY1Keme6ISj233/PvbLPg5GtNFvmP8ecEx9NEjpPUfogFg/3IW6qkTJgI6IAtk2VIVv/KzrfhSmLqzfUMiORmbEmepYQuI2ME2EhS9ja30kZffAQqN3m8Vhj3ZCLMYkE1+VyNE+iXbge0zRa5LtsCOrkUlN8FP69wPpRlu4uCZ7TqM6DueSaPRiif4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCr9kAlToZ1F5Iz34p7bJzuSRvBEe76cYEIOQZD2q4M=;
 b=BGTAD5+OgUK86QrGmTNEqGe80Ie8Dso/kk4ZvFEvkP8SI6cXdK3clN7yyo8FtfzitBgqFUny9goHOqN5S0ByU2UYBs2sFPh01RBvh2seFEN2tFUvULaxN0442IFpdsbR9gaohYR7TMUbAPpWtmNSGSDQZQoqov8Yv5y/r2r8r4nWxOAnFV/BwaWuOqZp/x69ZfxOQrvoUB8Vn6hmlqmtOJRquUd58EELZUxt4TXb6XUx5c7vOGK0Qt3IeSE2YvKadvaFFiw5tCJVtlwdh031V6ly1HV1n79bBcd+rcByqkoyFMR/BtlUr3kmix/h9WtV0vK2WI9t7iHh2BZerEWukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCr9kAlToZ1F5Iz34p7bJzuSRvBEe76cYEIOQZD2q4M=;
 b=I8tcTQ8cpLsITbbwmKgIDV7y7Z/chOHq1RaU6HatHK+iyiH5efqo7zpCS6ZMkK23d3IFZ4FTfyRmISrZqGTtOWNXOZvr6AcuwH2bFkb1VgujgBibQsW9caxW2oxA+4j3DnTYSR+6Ww2CjKquGNnt565PQEZy5WKUuSf/AjQNTVU=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 07:04:14 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 07:04:14 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Topic: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Index: AQHZXJ7+inbBqKAFRkOVc8bSb/v7F68HowmAgAHgbOA=
Date: Fri, 24 Mar 2023 07:04:14 +0000
Message-ID: <DM6PR12MB3531C1C961195DBE915A7155FD849@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-4-WenYou.Yang@amd.com>
 <CYYPR12MB86553BBA21040265D522C86E9C879@CYYPR12MB8655.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB86553BBA21040265D522C86E9C879@CYYPR12MB8655.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-24T07:04:11Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=46d0ee2f-bfe3-421f-bef1-73f86bc9427b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|PH8PR12MB7325:EE_
x-ms-office365-filtering-correlation-id: d8419875-1550-499e-0851-08db2c35f9f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: scB61uLmxIisYMpjRNioerHeoJi63YYvXvB6Zjt1IRfsaMkrHM1MODRKkvgxdttySKQcmcxjIlOI67c0yKGGNEkrC04h6l7/XxFPGIUtMIwG42XbBMFR6WOvHpYjoGi+8FoDvs8ZQh142lRciKb/zfZg7mLu0A0+GZUw6og+eu2TiucoOn55RD3iL7j/jiPHGx1nXknkdjrSkIvbTzjntMPNh1XW6LLccI02kkw4neEREpMk4qLUKj341X/PkvlYL53eRHXGVC48EwzPxAk0YoITEykoYmm9kmkJ/Ar3sUYXyO7D1sYhy4JxIbmIZ7X3/0COSAfi+9YrOxQcPDgIIryGaiUwKTLCCxyBTuAkt267ulfZLlXbsh3XcmBmbOq2xNC0ww4EsJyqK0QysLYSC873wEDTMIBIgnxHXjMEMfkISHWfERGc95GbWIGYxduGTAULBjacrQBMyvsE2OqkTEGchoWV94ZApnOBA2jutXbIlfMbgp5RFD8Ew0ADPjfdowaHsDgc5/j0+pfFPrwxkoSkNjrHbyUI5Q/z9gEvlkdHY34T3awdcWQ2GJ9sxDK1v9ZbDdmYQxRfcLaG+qAOVq3mZkO1CiLAWcyMCwShx6x4FmsdQLEDi+sdfy9U6XWAvpR43sxQewAJLtiaDkwJF6eBqRFKS89vipaSZkg4ye0/7R7mcYPgQ7VgRsJdy1s0TvzXAFJs9uiqQn2twzSedQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199018)(8676002)(316002)(5660300002)(52536014)(76116006)(66476007)(66556008)(478600001)(8936002)(54906003)(64756008)(66946007)(66446008)(6636002)(15650500001)(2906002)(71200400001)(7696005)(41300700001)(4326008)(110136005)(9686003)(6506007)(53546011)(26005)(186003)(55016003)(83380400001)(38100700002)(122000001)(38070700005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RPy/SIon/8GnGM0/CqHbTeL1eJBXyoK6nlMv930d3h2u30M3Ny1oa9A5mP/3?=
 =?us-ascii?Q?8vvFW+wYoA89tz+JjvEjfci3H07qHYK27tCs9Tfqp+zQRa5fyVsxMsCukxgM?=
 =?us-ascii?Q?zqHlcT5dcdXQeKqF1PO2k385nRvPXFktNIkIDZE80tIXo986Bkkx7Ewt60M8?=
 =?us-ascii?Q?K5iUcZPo/taT6QGvtO6+S4OWQFpZyUmIqVH7/7f6cq4916c6szxGuBrGUW3O?=
 =?us-ascii?Q?inXVXxn1TGJXgIKLQ4A4f8ZJj8Bq0dW8uh1i9zvUhl26f3sqv7HdgLNUqZf+?=
 =?us-ascii?Q?p8vr8GILC7tA/p4HcHbMOHWRInMVB0RHY5u3h9KCzKpRdRb0dWyWWfMKK4b6?=
 =?us-ascii?Q?gqTgY++uHOl7qvxCI4viqgVMKG9OJoSqlyz62ZAhmjphC//Mk223+Fm6Pz0G?=
 =?us-ascii?Q?gPl1Z2+96BeoB6ojsDuOnZhPOTMeBXSwrO41gcyCEKQ0zUNOdOT+Y8Eo+xUg?=
 =?us-ascii?Q?YiV4b4fRVKSNhmowrAPVLlUBmKlWSBZr7rDPM2+JCWJe1xyl4ZdbXsc9udWa?=
 =?us-ascii?Q?2V9yDPha6bdymbXHLnt5RBWeUj0V/JbBae/6xBBvAFrxw5kGGvj3T2zN3AyY?=
 =?us-ascii?Q?JiUADXkIH3xJlYUh/aY5izD2UOt7cZkoNMeBqi/UVhOCzZvbBiFc96rC7XDn?=
 =?us-ascii?Q?V+49RHYSAm2TL2QTSjKUS0ymzakiYMCwAxIUkLrs+tX8sLenPYeu42UTdt+S?=
 =?us-ascii?Q?ckh8jzXq4r4ALEsGGmTuJTc9xv9A/4iNZte8ARHv15Yujy4w3eiSRxOFflPU?=
 =?us-ascii?Q?9mGn7gOph7Uj4D/gjlle5R/WdDaov9OcoMnFAINPJosq2rlpc76ouOX9AuAZ?=
 =?us-ascii?Q?2vyRgTd/8StJewP3IPMAlNZXaz0d75gmQsFpIOMWZr+hVwAggtDH+8PzBJkd?=
 =?us-ascii?Q?IiOEReKC1+6aRCoWDnUJyl1PoPmBhL7OSiqD8YJNHtJKj+gAEDk1LPk2hKRH?=
 =?us-ascii?Q?Oy5zNgBwh9JxWhBQ8k/DRTHP1UOroSnkD8et1bz36EF+rK5xSWB4p8Mogq9T?=
 =?us-ascii?Q?wdYsnIPaFhG8iSsiDWIEk+rx835PLT++/QVeZl1U1p7Ohrd/tOwREI61X+aG?=
 =?us-ascii?Q?K/8JGQmkmzAG5fs0hHffZR5ZlfcR4YuUc4Fd0dUMLzLWLfwUhWjzs7TikAOI?=
 =?us-ascii?Q?H+PYFzYDmyUuu6eBiE4V2C5c0ScWQSZFJAgA4eIgSAyZ4jkI72LCxCukvdPE?=
 =?us-ascii?Q?Ho6k0gIXqBWLdOruvpz8ioxjMXkqtu+IQLWXEsArfcyxfnMi31tCbajC1Wv3?=
 =?us-ascii?Q?mCsKQQRJ52rLbmTgzEnl0O4UGBTtp/44faoI0Woqzi6+qsxznBqsgI9VCvgh?=
 =?us-ascii?Q?b7cGpmlKIrwQuQzJnwxHEPvv6UgFSNLj9xN6DIqZl/0llxDObxcMN/juEXL2?=
 =?us-ascii?Q?xX4qB5WPCCT7RmN7YVPqKSv2F55uAoC1knKCLviGFmoE/+bdxaPFy8CPH47b?=
 =?us-ascii?Q?PHcLCQ1j365EQ9dLSY9AAabJKPD/qVCO3p9hjGJz9vqPewaAeBB50Jrn4YHh?=
 =?us-ascii?Q?W7Il8Qo4H7wp0FCSzJ6kMm3LLdGNCAGUdmKB+E/sVzxtK9XctC5FBpRck5WR?=
 =?us-ascii?Q?28tL7rhfpxtPkdTN8CIWihg0dS5SIQLpCrtvzoDr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8419875-1550-499e-0851-08db2c35f9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:04:14.0996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kCoj348UXW9atoc7Q9ZJT3a5lRK2B7xqb0a/42Tu/xJ5JIIb8rYvfCMboDl/5pV2URtgkIC2FJ5/J+wU+BO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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
Cc: "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Thursday, March 23, 2023 10:21 AM
> To: Yang, WenYou <WenYou.Yang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Liang, Richard qi <Richardqi.Liang@amd.com>; Li, Ying
> <YING.LI@amd.com>; Liu, Kun <Kun.Liu2@amd.com>; amd-
> gfx@lists.freedesktop.org; Yang, WenYou <WenYou.Yang@amd.com>
> Subject: RE: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send
> SMT enable message
>=20
> [AMD Official Use Only - General]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Wenyou Yang <WenYou.Yang@amd.com>
> > Sent: Wednesday, March 22, 2023 5:16 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > Cc: Yuan, Perry <Perry.Yuan@amd.com>; Liang, Richard qi
> > <Richardqi.Liang@amd.com>; Li, Ying <YING.LI@amd.com>; Liu, Kun
> > <Kun.Liu2@amd.com>; amd-gfx@lists.freedesktop.org; Yang, WenYou
> > <WenYou.Yang@amd.com>
> > Subject: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send
> > SMT enable message
> >
> > Add the support to PPSMC_MSG_SetCClkSMTEnable(0x58) message to
> pmfw
> > for vangogh.
> >
> > Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> > ---
> >  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 ++-
> >  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
> >   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19
> > +++++++++++++++++++
> >  3 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> > index 7471e2df2828..2b182dbc6f9c 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> > +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> > @@ -111,7 +111,8 @@
> >  #define PPSMC_MSG_GetGfxOffStatus		       0x50
> >  #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
> >  #define PPSMC_MSG_LogGfxOffResidency		       0x52
> > -#define PPSMC_Message_Count                            0x53
> > +#define PPSMC_MSG_SetCClkSMTEnable		       0x58
> > +#define PPSMC_Message_Count                            0x54
> >
> >  //Argument for PPSMC_MSG_GfxDeviceDriverReset  enum { diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> > index 297b70b9388f..820812d910bf 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> > @@ -245,7 +245,8 @@
> >  	__SMU_DUMMY_MAP(AllowGpo),	\
> >  	__SMU_DUMMY_MAP(Mode2Reset),	\
> >  	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> > -	__SMU_DUMMY_MAP(GetMetricsTable),
> > +	__SMU_DUMMY_MAP(GetMetricsTable), \
> > +	__SMU_DUMMY_MAP(SetCClkSMTEnable),
> >
> >  #undef __SMU_DUMMY_MAP
> >  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index 7433dcaa16e0..f0eeb42df96b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping
> > vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
> >  	MSG_MAP(GetGfxOffStatus,
> > PPSMC_MSG_GetGfxOffStatus,
> 	0),
> >  	MSG_MAP(GetGfxOffEntryCount,
> > PPSMC_MSG_GetGfxOffEntryCount,
> 	0),
> >  	MSG_MAP(LogGfxOffResidency,
> > PPSMC_MSG_LogGfxOffResidency,					0),
> > +	MSG_MAP(SetCClkSMTEnable,
> > PPSMC_MSG_SetCClkSMTEnable,
> > 	0),
> >  };
> >
> >  static struct cmn2asic_mapping
> > vangogh_feature_mask_map[SMU_FEATURE_COUNT] =3D { @@ -2428,6
> > +2429,23 @@ static u32 vangogh_get_gfxoff_entrycount(struct
> > +smu_context
> > *smu, uint64_t *entr
> >  	return ret;
> >  }
> >
> > +static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool
> > +enable) {
> > +	int ret =3D 0;
> > +
> > +	if (enable) {
> > +		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > +
> > SMU_MSG_SetCClkSMTEnable,
> > +						      1, NULL);
> > +	} else {
> > +		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > +
> > SMU_MSG_SetCClkSMTEnable,
> > +						      0, NULL);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct pptable_funcs vangogh_ppt_funcs =3D {
> >
> >  	.check_fw_status =3D smu_v11_0_check_fw_status, @@ -2474,6
> +2492,7 @@
> > static const struct pptable_funcs vangogh_ppt_funcs =3D {
> >  	.get_power_limit =3D vangogh_get_power_limit,
> >  	.set_power_limit =3D vangogh_set_power_limit,
> >  	.get_vbios_bootup_values =3D smu_v11_0_get_vbios_bootup_values,
> > +	.set_cpu_smt_enable =3D vangogh_set_cpu_smt_enable,
>=20
> Maybe we can rename the function with cclk dpm string?
> For example,
> .set_cclk_pd_limit =3D vangogh_set_cpu_smt_enable,
Having second thought, renaming is needed.

Thanks=20
Wenyou
>=20
> Perry.
>=20
> >  };
> >
> >  void vangogh_set_ppt_funcs(struct smu_context *smu)
> > --
> > 2.39.2
