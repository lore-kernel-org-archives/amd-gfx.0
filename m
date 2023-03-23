Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C43C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 09:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F8610EA53;
	Thu, 23 Mar 2023 09:47:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830E610EA53
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 09:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll8iTHP1rUTBp4uyuogQyhBf+CsV23MlmoTjVP/F2C9bCZNVkmA/uw1g2Mfskr16uAr+au7WNRvtp07RfghKHpKwJw8iZw6lIsGEd6rmpUabI54RMXRUTJQDkHpMXbFn+A1gGjx9rraq+e5XXgnY9fWKBAHOGlTFkY8XBDaRIasAbdoXtm+Ejp4wETKeQSl/yCygQYv/xSXBs+Db1DO3G4dgpj9FIwWYY7DYCiv2HFxwy/E211rfy91MR1wSteg1baPzS1OxOMLKWHLFTEIA+rhyqlKGNnG/A9u+Cq/GSL7dv8dooFJz0BPCZj/h2jA8VcicdAC1VzTGd5ikQ9cMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW0XOyicAcNXt0yE4ETGRLZqFUQqy4FfxORp55G5x1w=;
 b=IrzVMRiA7vyQ1seXdaM44awspu+uxmHNkvOCOwdDUqUFBf1x0F3SNzx+XE0w0FLo9A+Y92wAfYpTfhRfCzBMBIMH84Qgq9x0A8oyodCOQObtqc0OXjsXqSL7sA7TN8VlcRy413f1X4X25zlcllq57ycUQ7EPHSO3NBfrIVk5O2V5nPPyB2zrVVU890gJQvEpn40dhuTg64j9JAqfohRstHX99ZoII1G7/qqZihn07Ji4O6cdRK8THlHIP71zoBGbDc4/uayKUEC7iQWlVD+craXiZWGyz6b2GT9d68y/Dmn9709NMvpCbcWv3Yb1CfLBt1H3HKNnaXJIobteC8yzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW0XOyicAcNXt0yE4ETGRLZqFUQqy4FfxORp55G5x1w=;
 b=Od0cS5NNMYjnswVEzk3VuPOjjfzt1Z5tpP0jWLH0c71qrqBrNaw8fs+g6wn7019o3JgjMizX1KxfZlVP4g+eiSoVLoizLTTBMR6djyBc5uIS1NA2IzpN45x/I4xDZZEkEPnxQQ+BhHVHoh7tEdXQjtc9QZY9NbXut7foRTD1Y1A=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:47:43 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 09:47:43 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Topic: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Index: AQHZXJ7+inbBqKAFRkOVc8bSb/v7F68HowmAgAB76vA=
Date: Thu, 23 Mar 2023 09:47:43 +0000
Message-ID: <DM6PR12MB35312B59A50D524A414AD002FD879@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-4-WenYou.Yang@amd.com>
 <CYYPR12MB86553BBA21040265D522C86E9C879@CYYPR12MB8655.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB86553BBA21040265D522C86E9C879@CYYPR12MB8655.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T09:47:41Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=02b9d038-b16c-4393-adaf-d8d774147b40;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|DS0PR12MB7512:EE_
x-ms-office365-filtering-correlation-id: 67be01fc-53cb-40e3-0cc3-08db2b83a663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCPgNlWqj5WiF21Euwa0dKfgMvIZnTQDeQHuIWpdWKg0bb2Y3424ZI1oRcGAKik01fLWQl/pNk/J5mwZzlNTouwDVpS7cBPoBzdF32ZFXA5y2J23AQs28V99hKBRl5I9O4eKmqrJE9MfyY2Q6qYxIl8RjYtgvXcB9XH+dam+4p2lkb09w1uJzGXnbqhxp6Dqkt7zkLUEHKeYYLU7p415wAH+6uCoKjKjYC2sEWNWFx91/JhKuNJtGQbVUlBawgQzYYRLTrfiEX5p4nvSgRm2R4JmV/+tlZEMnhSimYIRpeWQ7D/xA7AqaWnn0eUtlp4vTdN1LWv4ztJpaUDAYb5wiMos1hZZnZVOLmGk8jkpmEAJvloO4Il2qSp3nvhRMHF7aknF6MmSkIo5T/+7yAZjwGb4fLPBkVxp++N7+FVu9d5QKWdvky757xjv7CBCQMyWnRWeD1UIx+GXrpIUvXVHWevlyD0wZG7gEuAYeU+i885oaodOEHsTWPZ99iRaKxgzXAQhvHC24E8RQ30x4yCPHJXXljbmYOg46QMbk0BtMdsxp4HIaIE2EZuHzv6imZnovtRb770xbC8rAYeB5mb0KgS4nZPkJiJK1asWQCWuT33x87OPDDNiY+nQGYn4UArq8Qa1jkIh7mvYLMslbVOBA0UvtsJTWCqQtccDmvl+dfVToDtDuHwkPKae3flweOxI/kWyV2+CjMWcqW0R6FQCdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(66476007)(4326008)(76116006)(66446008)(66946007)(66556008)(64756008)(8676002)(316002)(110136005)(54906003)(6636002)(5660300002)(122000001)(15650500001)(41300700001)(8936002)(52536014)(53546011)(26005)(6506007)(186003)(9686003)(71200400001)(83380400001)(478600001)(7696005)(86362001)(33656002)(55016003)(38070700005)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LMDg9fPqniMKHTmr4T6FNWiZihOpz49h9Dja3UyrW83HUwGC+UrAUWMZTQYt?=
 =?us-ascii?Q?RBQtmEPkEaafjKn5O5o7lj0VSXseFRuBpUDoPJcBrZSdqa2HyIUqClAtpm0G?=
 =?us-ascii?Q?f+8iQFrPps+FBweDagQhS7tRv9Vf9poBaQQM/qgkzNiixPcmrSNlNuuK0NUn?=
 =?us-ascii?Q?QX7x+2sgUEeWfg8vXI1nM8EFdU70Hxq5NDDm67sGVFdz0+01ARHZnmJc/MM5?=
 =?us-ascii?Q?+Y1itMMClFuHc8qNHBrEQkravdeuelcaFxy6mTWR2Np/66zezhmJFDE4OPtc?=
 =?us-ascii?Q?8ASId5BBO/f3LO2d0NXlSOQsSMn3h5Ax2dFPpi47jefHOaHfO6+RbfMga1+c?=
 =?us-ascii?Q?GeCmdTDbeDYXwBcFv3UONiCERSF9g9Sj+X+J3Ei84uG0LRoU3yoMFqqhWpC/?=
 =?us-ascii?Q?RmveQz8bmhYGWJIevrHuhN8D8YwVfMKJUHQCJGDUm650PS+kOdSpgRlhSOhG?=
 =?us-ascii?Q?/TaNzxpz8exswyzu0Wj5kW0uM+U2oq8p1Sv/W0zjP6X6stwWXf2uwp0Z8mt1?=
 =?us-ascii?Q?18LM6R9bVqGOeW7kn0KoJZbxesqybBH+zFBTz6TprZSXY7T6dgXFqihzuRwN?=
 =?us-ascii?Q?eMCIZrRH4a4oRkI9L7cCEjnXhWeSJKLysuXpsY/Sgirpmp0Ed7YC2Z9dBImM?=
 =?us-ascii?Q?ZNnjJXVyNe6Il9iQ0TzEaBImh/M1nRbyzU/SiWv/K93TIBBurmrf+vnd13Cp?=
 =?us-ascii?Q?2qWk+GP1mxzd/7T3qXkhbq/eypQrk1jrzGUzuFOVFxMkVKZAQKgr0DG3Rtrz?=
 =?us-ascii?Q?rP3H4+zSpmmKxJabXN3MXpvkEJHFjch+601bE3zOFQ6nsOdAtpX/FX3SaMvo?=
 =?us-ascii?Q?JaYAlMU7p1GIN+xSTEJGhKDxYmE6HrpASGqmHk1U/2MHebuNobyCTW4mhr1e?=
 =?us-ascii?Q?QCLwo6tx6dZ1gW0NmKiAa/UEkjs3/veI5m4CP4GO3wGX6Krh7XXuYEFQE7pr?=
 =?us-ascii?Q?RtjQzvGu1iN4X0wQvaLFUkjSSYTluUb7asMJszZgfgDut3P2LRfqZYA8LUia?=
 =?us-ascii?Q?MEA8MIhziMkwYsC4ORYuITTGVNm8YfmdBGqjMfUJbCeHMY8Dv3uHXot6v4aZ?=
 =?us-ascii?Q?mRcq2dqg64TFlxPCHqbt1qjH9tud709P7W7Wl+E/RdcjqnOQ99vN13FMOoKP?=
 =?us-ascii?Q?EYSkxOT8rEFbAoQasWJ1bx54x9eJ6lEylQ8USmdMrmb7BCwyS9D6a5z/GR2O?=
 =?us-ascii?Q?Vk5PZQkPzLW6ckeHkG03dyV3HY/mnnas1sbT6fDVnKMCaubiQgmus8jw6MHl?=
 =?us-ascii?Q?yesD9egK13pMm0+aHmRb+zM2+ZgCRxpt+2Alqbgdf/MyEw1cdOLi0fJzjImL?=
 =?us-ascii?Q?uj1XWFtQ7n4oZcr9SfeRcZm256rBV0UPY4xYkgyFpfYza0PNxcynPLJJQYry?=
 =?us-ascii?Q?enAYCFD1w6NAn4ohy+IDVCo8/D7CZkTQ3fQedgf4ijlkmjk0p1WDnvur3mAy?=
 =?us-ascii?Q?AniMvZy4Oj0N0QQwFXtJEXVykGnxQwoohT2n4ChtNkrPqhxTstsAU5ClqTUJ?=
 =?us-ascii?Q?JmSd3R6FpLntnhXdIufOmwAV/lyk0dctBFn8slI+2kfho8BPrxkg4ZkEvfUa?=
 =?us-ascii?Q?XdPzHMtHb9iFQJ23GTByv9VQ6VX6AjEkL3LM3zYz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67be01fc-53cb-40e3-0cc3-08db2b83a663
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 09:47:43.4807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSDVYJKFXmPH6EJMpMf5+9iQYBvTdzK2hF4wSC3QRqsxhd19D8cl5mkIl6D5XEF4lJVhpzk8aUzmEDDoatEltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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

This interface is only to send the smt status to pmfw, it is not used for c=
onfiguring the Cclk_PD_Data_Limut value.

>=20
> Perry.
>=20
> >  };
> >
> >  void vangogh_set_ppt_funcs(struct smu_context *smu)
> > --
> > 2.39.2
