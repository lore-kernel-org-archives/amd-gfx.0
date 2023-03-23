Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BC0C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 07:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202DF10E462;
	Thu, 23 Mar 2023 07:41:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145F910E462
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 07:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVuQZik3vfwaW//jDXvG9yF5f41nHjwTiB3EoUKJSPkW0p2nWjEcEnpOyiTZrEg0uqF3Tl0EMWPzaNITI04JItjxbwz6dkFTuD1oGnaLCuG9BgVKvckQ7f8+nrzPyIv/B+gyw/Zb6+qakpNeZBRi2I4Cnbv1QeFWrL3qF/cSGv13W/mEbkVhjz+AQz8LniiGXYbQDC0kRR4ieF0xqIPwJ+oXoIX6bvhF98gpRIDVGye4Co4WpcvWOZIQt0SHVLqyn7qi3j0Ez0RIBWJ866/O5FIvQRo4SG86bxdll/DNm4ibswLnuj/LDdm1XXVWfHDKZSjaILVQ3WIgox11o5ui/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sch4FUqZ8odZg1SzzaR5J3WOwPrjh8szVUUcujlusfI=;
 b=SzsK8+nG2Vq6sA0XbXlGMpj2JBGxLBtmzrckhIUNZkqDcGJ09Zdl1bglhFzcXZUh6tbV2QLwEwPDRfjT9ywzsgPbWAo4OyZlzyTIBA1hfkaYBQ+Dod3A1oMoRNnSYYbc6Iu76uBO+pwpk2cBOsnpgvihGudXaGnuzZS6vuXxU6p38pdFINrfD7Qfaeg5mLXGkhDYaYsRczoxBjJeAdMB6/oempJCPgzQui0Q1X9wY5GEa48339jnGHZo0EmDiyFHCDXHII0a1JSgPzHbFUFEQ0ZTYOqHAWsllECI8XArmuw+pLX3ZFNyZyAvKk02VMOKPdLey9NhIWAv5AEtMs0H3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sch4FUqZ8odZg1SzzaR5J3WOwPrjh8szVUUcujlusfI=;
 b=uO+Lke3EH7rXkvaJt77mBl+X92iij8wjMEPvHM8Q6XmTmDYLB7e79t2PY8pK0j10B6FMeeMVs/oD5DXm6vq6MTumwN+UzXdS6LW55h/DC15yHnTpyq7pi4VPxLMxn7ujEjY0NhSi3hy/f+Jbhj6C98VMaJDOHuxt1at66DHVhXc=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:41:52 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 07:41:51 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Topic: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Index: AQHZXJ7+inbBqKAFRkOVc8bSb/v7F68H9z0AgAAEgVA=
Date: Thu, 23 Mar 2023 07:41:51 +0000
Message-ID: <DM6PR12MB353181624AFCEC590CC45DA8FD879@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-4-WenYou.Yang@amd.com>
 <DM6PR12MB2619F012875625DB0999246FE4879@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619F012875625DB0999246FE4879@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T07:41:49Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=05f425a7-6a8e-407d-9834-42456521f63e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|MN2PR12MB4205:EE_
x-ms-office365-filtering-correlation-id: 0c8c6665-f199-4201-bfa8-08db2b72113a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zD4d62IR8zOwd/tawWq+VtCNLlN1hQmQM8YDepumsrMePddOYsesWA7pKmKv9HhKuzi1FCwsFI1/4fPhoCvP5uxQU/aRdGAUtCzpYCMBAfjGmfBTnAUkyIQkefkeJ/8wWRcYYUNB4CJaYOGpGCO86AdU1r+/aoutVq5QMaod0Rfc/4Yy3nsecLMWDIt7t9/qM5TwDywiEtiKDS0o19uSuHxccq6sPJHVhafeIOgdgHOiHwvbj2KHYlrSwEIwiyrriRp/fNO6Hspb0Gqzl2+Fxlkwjh77AQK4pV8y3Zlzc80qyJjdYD9C2Zlga9GseB8Y2/OHwP6aESspvtDUWGp2bzksHhmePWzaGiaP8A2L41oDDdunhfKBzxZxMy5hQZlpNaoqLi8r9BlLCj3JfOd3K9kru+u2bXkFPdul3rC5ftBIkS+l7chiHgjjAwdVFcDTYJk9dwf09JTgPbXSqRhqM8fMxr3qO2XzU/6JxT3PPel9OmeHb4SZfbrVZSNOlhVU+s0bTAB3R2Ns1vYVW/Fy8cRKOQue5DV1zcbDa0KLlaWONzB55Pz81UrqBmEBDJ1XXOiaQbojzJbrA1VvmzdxL7AtxxMXeEQ57OnteRuu7RwLhjogeu3nEF13rNKhSPq9YaytCZzuuNRli8Xbpu1GzI62vAyy/aLjObKs3DviDkZ+1c3NQTZbXRG0arncEQqPE24es6etlkhqTEPm4IpfZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(66476007)(4326008)(76116006)(66446008)(8676002)(66946007)(66556008)(64756008)(316002)(110136005)(54906003)(6636002)(5660300002)(122000001)(15650500001)(41300700001)(8936002)(52536014)(53546011)(26005)(6506007)(186003)(9686003)(71200400001)(83380400001)(478600001)(7696005)(86362001)(33656002)(55016003)(38070700005)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5HLQ3860+QeLKdz42f7YCOLlMaHsNLApTaMsLupRcTHHR543gzwtFTdPEcx4?=
 =?us-ascii?Q?CtxsYf8pOMmP7Tq2dY9ZRAMvJ6QVzmk+oWUqlbQtjIO/F1Omn0P1WG0bRTVi?=
 =?us-ascii?Q?ygCYinY+9oOci8owaUxBvO6iE16Agl41YqD5ZC0nJArvMyjr6h0x4nDnp4kh?=
 =?us-ascii?Q?2/nTshZsDbxRLW4viwuI63mDFS2YNAfGHi+d+3dyQJ7F2piX1qzZlpCdM12Q?=
 =?us-ascii?Q?AnQNyUhPH2s69lsTrdu1a/ThvBis/vX1je8Iqz209PcK7Uo3EeKCkDAu8aWk?=
 =?us-ascii?Q?RPlQiRLRcxiQVPCOqyuvHauw4Pq1NwfOP1tju267ykPCn85h8EQRudqNIjGl?=
 =?us-ascii?Q?s62u7dy/RZGg4T/UARdVvOKRYx61oXLUWqUs5B89ULHxbQJGy10fGpY5qVqX?=
 =?us-ascii?Q?BA5Bc6rOfxq/bxOTIC9oY5q8GZTI29TNXChefrcuaeOKV9HlUk1w65w+0KER?=
 =?us-ascii?Q?SC8ChmauDgOZr2Yq+M6RqfC5tnKfSWoDx5EDJPS2R/ngs28sftg+eTz9v/sT?=
 =?us-ascii?Q?T+tM2lKLxhFmx4bhucl1SaJU4zxOTn1OhT+K1nFvMJT+OP6x4bfg7mbZwCHg?=
 =?us-ascii?Q?Ph/IstiFkso4bBdhtbh4Y4d/gXoWTBQphICOcCshPnSTIQvBot5iHoL8XztA?=
 =?us-ascii?Q?+sfiK7XGV2js97hBIKIL8Yyglli9RfLE8PERA62ZeNHMddHSbpmLmbBt8IXH?=
 =?us-ascii?Q?B49Y9QH5zp4OnBeTDljWiys0sb4kuN3H8L5Y9DxNbBYx1xedCWRInvUmmdWq?=
 =?us-ascii?Q?UEeWe9oZkXoiIw3UhCud2j/RjUWGTyidaTniAwGDJZeiDS0ZyXROjgZfOkyY?=
 =?us-ascii?Q?BvWP2aoRFs95HdbeDugaNKsMRFXl+mdMLhQNl2N2zCDntlrNzA0NGvHYi/4K?=
 =?us-ascii?Q?IlefI3mWfqhHMZP25Hq6mcivWveTKUgRQENmIxRXi0USsB7dhKqAbaNtVeEk?=
 =?us-ascii?Q?qTF+/7X7t2AZMIxnIfam9cI7hwQ45lXW/Fz8Lms0U3xfgnEWdUvYk9DN1I2d?=
 =?us-ascii?Q?8HuOOvcrYy15wPabE112XQra2pTs/8d1OHkYByBxvIbTMeWYCdnPEW+0o6SM?=
 =?us-ascii?Q?2G9GBtHQ1oRNpGHp8L4DjEwwzOaoexdJoTm5gm0K9Z4aV6yU+47v4IUQhZWW?=
 =?us-ascii?Q?hpMtRBy0XQhuF0tCTq+USKjKtXyLL+/LniivJut267xMGi+H+kPRw5FWjYbp?=
 =?us-ascii?Q?MVBsyXoDAKUWF/6NVj4O/1QfMqvP+Wtn8Bp2c6KcMbN0IuSAzuMOcbsN4fEg?=
 =?us-ascii?Q?sGw49T7fCM1+aJGpDdyNwaJFThnhBnRl1zwZWwItve8LQAD449CkRDsIv/Jy?=
 =?us-ascii?Q?byWJPNri1MNZkE//mVHJiKdS6N/v1NAZLzzUu9Dk82cvCCH6/K9pTMJZrklC?=
 =?us-ascii?Q?2ZW8xv9lg0vcy5ReFj0rek9V03aNi27XuBvLXAkxKrVxZMXwKg4TrfgO//1d?=
 =?us-ascii?Q?QNKwTWVksdTotD/b4PzBaSWHuSjhM6r5frLxPdO58Y84JQZESh7iWuQrs0SE?=
 =?us-ascii?Q?qCKj6+KwbaY8TRkjwMocxiZq0WI5LxZ6Js8SaYNNUx1jgkulxwwRUi08VH9u?=
 =?us-ascii?Q?THkghNN5WPo8XJemYJtEM3rcpKWKr/WrnQ9Q/mr8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8c6665-f199-4201-bfa8-08db2b72113a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:41:51.8073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKFWImVe3LD2SlcoZzAtWHTNEYskK3v1MR7QHDjYna2Z16NR1ntufDmd2MNliagpyhb9brU8Q7x4BYj5Tz61UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks Evan.

> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Wenyou Yang
> > Sent: Wednesday, March 22, 2023 5:16 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > Cc: Yuan, Perry <Perry.Yuan@amd.com>; Li, Ying <YING.LI@amd.com>;
> amd-
> > gfx@lists.freedesktop.org; Yang, WenYou <WenYou.Yang@amd.com>; Liu,
> > Kun <Kun.Liu2@amd.com>; Liang, Richard qi <Richardqi.Liang@amd.com>
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
> > .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19
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
> This seems not right. The message count should be bigger than the index o=
f
> any other message.
> That is PPSMC_Message_Count should be 0x59 or bigger.
Accept. Will change in v2.

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
> > 	0),
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
> +2429,23 @@
> > static u32 vangogh_get_gfxoff_entrycount(struct
> > smu_context *smu, uint64_t *entr
> >  	return ret;
> >  }
> >
> > +static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool
> > enable)
> > +{
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
> It seems the whole bunch of chunks can be simplified as "return
> smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetCClkSMTEnable, enable ? 1 : 0, NULL);"
Yes. Will change it in v2.

>=20
> BR
> Evan
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
> >  };
> >
> >  void vangogh_set_ppt_funcs(struct smu_context *smu)
> > --
> > 2.39.2
