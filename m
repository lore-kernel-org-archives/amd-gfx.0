Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903FDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 09:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134B210E77D;
	Wed,  2 Mar 2022 09:45:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3596210E716
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 09:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIc8Ll5lv+k9Mp1SxE/L0Mt7wJhSypmFP92QTkk+t9eweCbdoHT0RMa7e9BYBb4p/NGLRXwcMOOnIBpj15O5JDwBA8Peqnx8c8C47QFRmDMwEent9q6uFpQU6TbsBhf+2L2ejyXdEewtYDYHHQkXhKskJXOHsoG6CWAgKeIuw2H9lO4Kh3+2Z4YKeVRBcSWct5XUj0aNR0r8HTD+RHPE8Whvdshw0r5TGa3B1N9GJe6RC/vi9cq2ppFs92ALWk5u2+KASvq4RgwfMIRJBKQGwo51wXX8Y5xWjTQFm90IppkyELbR7SmyIXSkaq+7CNDhz2iEVFh7UiahnOYjj8giQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfBiNSJANL4ed7dzrjEUEaIQH8fIe04vNTS+rJIhwlY=;
 b=LamO7UQYjWbOK6r/OGOMpylLkkOkpqrfgW0G//78FdEgepNqgS1mPQpLU2uYMkwcFqpfWrv15v7w+xerUFPP6JpUvTiDWkyQtzLAVXB59QWQleA7qIQycRClPKwv1QL2cj7HSdv3H6vxwVsCepz1+Ut/qxfV0lJgHGfTwaGTSFbghIb+2aHefu4YxKclCuYQ4F1nYKCQ/f67lVfQXiOJSE23JowUkQ56kGSf9+GgPkTnD+ldtBgPNvdVK/xXlH/Oih0oiljtnSVBQlTunZ/fzF2dGI+LZltb9wvYo4g1MCkiulf3lCcXdC2sV9HRNwPHnXHllgNQ3JunLMkaZHlNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfBiNSJANL4ed7dzrjEUEaIQH8fIe04vNTS+rJIhwlY=;
 b=SmmuPI9sfI4XXDkw3+0zvybFQwf/pcfuvP3yZiTcyAcX3rN1Js0PTKkY++U0rMx4Jdw1cSLYpnEr13cuk1T8dwBWEdzpJbbhPnQ4y7HFHaIwNFs6n/binph+ggJy5M237UZQaquJll4COqsTKpYFV/Y4PaQWPe7x9nDKI2lGbqg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1769.namprd12.prod.outlook.com (2603:10b6:3:10f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Wed, 2 Mar 2022 09:45:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea%5]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 09:45:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: new v3 SmuMetrics data structure for Sienna
 Cichlid
Thread-Topic: [PATCH] drm/amd/pm: new v3 SmuMetrics data structure for Sienna
 Cichlid
Thread-Index: AQHYJMQv4AEYiuVs8USujfZiM4kBHaye3quggA0MKIA=
Date: Wed, 2 Mar 2022 09:45:10 +0000
Message-ID: <DM6PR12MB2619169D505499C14AFCBAFEE4039@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220218123616.10401-1-danijel.slivka@amd.com>
 <DM6PR12MB2619F61204605A3EADED38E3E43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619F61204605A3EADED38E3E43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-22T02:30:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0779b469-e15c-4cd0-b56b-93c667d7de84;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-02T09:45:07Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 275421ba-e74c-49bc-8c53-479e305b19ba
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88e66ea5-a0db-49ae-0533-08d9fc3157ce
x-ms-traffictypediagnostic: DM5PR12MB1769:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1769592FD371AB8775FF531AE4039@DM5PR12MB1769.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFgWfw31+IEa+MYPzjRDKbqhiKk6z4vrJvW7iudRDGP7PVL4K+cuA1DD6YvN6IUAAuTl32qWKOn9IfzviypJrc42aM10fERPSzjAYd6onLk8YK6lt8uXhOHcs7bpPe51Jyr9iuQ7RjH04DhqolsuaGrP5ixhdY6jbuRNHFfIgzqongiBk+baJvP/L1Oy0f4Ld7P8tdiNC6iXHW+Dg46n4firvKLmOzXcaoHV6gYXtmbA2je2+iJHZ9AHlP6ATA9vOv0R4qulYZb3Dy3QwW2Iz9GrAYZPiMHNYxm7tjoieMEklp4MtUEJZOcguq65kEvabkW/HgtA1XCE0lr+1C7U9N7TJbni+Rv0Ta6xhlgMqUtff8ul6U1CxaKvjzJC55OKTG5V4NQ7PDfVOC9xnmcY55IO79yci5FBR/i3sTKolxQsUEgW2T1E3qZKvZU8BPIpaU7YZvmHU4cQd2EFWan66aI7IvgnCtWNE7tZ97HT//SjNiQdrH3Dh9VvwtfF5k49tKPVUSXjh0zSrPJzMXWgKld/P15kCgq4SvnLGa2JTnVd2JJaUcaUtbO+cVmP4T/wPdM9Rtxs8TfVnfiGXm4weuPNBESAB7KAlZBrDCV7EyPCJfBvDDsUQGK/WIYx4KuFzphOV9Tn1/WKsKTvmv68DjQYv/U9KmTuRf65t4aHJ74fbNDw/z3RlCRY14H58IZEGspIdAiFvdqlm+W+T8Bspw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(316002)(8936002)(5660300002)(38070700005)(7696005)(6506007)(52536014)(66446008)(66556008)(66476007)(64756008)(76116006)(8676002)(30864003)(2906002)(186003)(33656002)(26005)(66946007)(53546011)(38100700002)(4326008)(71200400001)(122000001)(83380400001)(508600001)(55016003)(110136005)(9686003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2KjxXw9KxfJdXZEyUKpK90TagQqU4KCpRUnV0v4Ek/oFAc1e/dpdiPMP4LvB?=
 =?us-ascii?Q?vd1E3jOfpXxfJM9Rh26v7PInmPh63orfu4Gug1ZM/o4w0TuBD6cWzoxar6pz?=
 =?us-ascii?Q?DaQYu2uBPZhXpBZKLNUpgczZP2qJ/dSjFQudWXkMupFD3mmnJ9VNdw59P+ix?=
 =?us-ascii?Q?RY0EKe4O34WiFz62CUjbRn2snuWpBAlOnyZyI9pVQfHK6Kx7ulRSUhe+SO1G?=
 =?us-ascii?Q?iorOEjED7ebepdzrWKaJQJClazXs5FKNtg6bc8zfQwG6gf7mR3RnU8A7FroL?=
 =?us-ascii?Q?QWE6V+pSVsfpzDaMBPa8oodWp5jAMqSx92yuf8bLiJ6L/il/1PLBD2mOKX0W?=
 =?us-ascii?Q?FL3B1yLiCJx7830nPKPG+C8ovy0GLJI3ge++5hOJBpr0Kf42jRUJoiuJnl1d?=
 =?us-ascii?Q?o3fH+8oAvB60KM9dQjJsxRKUQyrmwx8DCwr4ABMvwb3weE7DaBq7DD5ZzVda?=
 =?us-ascii?Q?sg0Vv1CqvkhDKNVUV3wXPYqDA4THKSyoIfUOjO3QRI4yIuxzt8Jbiamq8cDf?=
 =?us-ascii?Q?yOSWBh0XXqUpvQzILeeiS7rLX1ISjqqZc95fAx99FZ/kFgRYc7ACqxgO+V0x?=
 =?us-ascii?Q?PQuRnoOgHLLwHdBKPaLPF4WEaToybFhd2hQNMhW9dEM02NIe9HS7l0FQ6nnz?=
 =?us-ascii?Q?rfJOKp+tA7TQkBjgRLCNNcwmrveUiT9idSR9zNqbm2wi5AWFAo7BNKfq6PD3?=
 =?us-ascii?Q?WZCGbr+mLYwFWrCa8GxBdaUxxC/qz+mSrO+e2rkX1RiXgQqztF/Ln4w3ul4y?=
 =?us-ascii?Q?AeXk1BAmo2/Y7mWfaMR94v7oQ3JbjDrgzziJybS4l2TDII8RardMVydk7V+y?=
 =?us-ascii?Q?Uu3ozAB0cYEUH4dV/ey/Iq0Qy0oBkzpq4idzd9weU1cpKM09hh8DGOsR3WZZ?=
 =?us-ascii?Q?xiuFCk3Ly1rPKaXATfreeBLxhogrnwEjbiq7QST8OfxK1NiUFvLOlia3Dq+Z?=
 =?us-ascii?Q?XKtHEJsUxWLhsjMWmzHg37MGllkxFcD1I++Ujp1xQolAA1oYGilY+jkvHYXP?=
 =?us-ascii?Q?JM5B9qkU1NpfB5htoQy+0tNC+iV7cVijZZmenEp8fCn0neHedlOTjJc8f+GZ?=
 =?us-ascii?Q?D/iCT+u3lev+tHBgrwTBelrbC2q9vFzYF+/QAv5wKvpEKmQuXvGTE/JKRP0w?=
 =?us-ascii?Q?aGCyJ6Hrxu/OhWgCL42M+NrxDE4QyZo9TG46GGolL9MighIHwgmsmJTYZHuR?=
 =?us-ascii?Q?NX5cgAMlBLm12waw0pNpDhNqy+sLTnQ4PKck/cdNDVRKvXZaWtOFsM2ipU6t?=
 =?us-ascii?Q?GhmuaBYKGnL3sIKJgVzn9rhKeVm6oam+cSgHFeVhWeUz41+AH3roo+gpLc0g?=
 =?us-ascii?Q?2l7npWi0kvf+K7gaFd4p8/jpZR+c2Nc2sEI/uiApXrijYWP3yFIiEX0+PUcv?=
 =?us-ascii?Q?t7Mim1AJ2ybyHKbyW4uHxzlG35RkmRsBEJchXGWmxED65agg89y5GmfvBx1a?=
 =?us-ascii?Q?K96Qmy3Iw6lnKj6i9yY6hWDS7NDT7mL9Oa3icq2bhEGZkHcmeT7j8MrAIQPt?=
 =?us-ascii?Q?TXr/rFR+PAqKeiCggYzJKNKnhnmJmNQEWoFfn35tmj1cqK+XnZuSx02i1JfS?=
 =?us-ascii?Q?Xrt1ubuSGFd1VjNtlVQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e66ea5-a0db-49ae-0533-08d9fc3157ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 09:45:10.4946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBLl8J/laJFNaJnEjkY/SxJSFbTGkQtvkPi9o09yw9Fng4i/RwFLoaJdgoELjb5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1769
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
Cc: "Slivka, Danijel" <Danijel.Slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Quan, Evan
> Sent: Tuesday, February 22, 2022 10:31 AM
> To: Danijel Slivka <danijel.slivka@amd.com>; amd-gfx@lists.freedesktop.or=
g
> Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: new v3 SmuMetrics data structure for
> Sienna Cichlid
>=20
> [AMD Official Use Only]
>=20
> Acked-by: Evan Quan <evan.quan@amd.com>
>=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Danijel Slivka
> > Sent: Friday, February 18, 2022 8:36 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
> > Subject: [PATCH] drm/amd/pm: new v3 SmuMetrics data structure for
> > Sienna Cichlid
> >
> > structure changed in smc_fw_version >=3D 0x3A4900, "uint16_t
> > VcnActivityPercentage" replaced with "uint16_t VcnUsagePercentage0"
> > and "uint16_t VcnUsagePercentage1"
> >
> > Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> > ---
> >  .../pmfw_if/smu11_driver_if_sienna_cichlid.h  |  58 ++++++
> >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 181 ++++++++++++----
> --
> >  2 files changed, 178 insertions(+), 61 deletions(-)
> >
> > diff --git
> >
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> > cichlid.h
> >
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> > cichlid.h
> > index b253be602cc2..3e4a314ef925 100644
> > ---
> >
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> > cichlid.h
> > +++
> >
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> > cichlid.h
> > @@ -1480,10 +1480,68 @@ typedef struct {
> >
> >  } SmuMetrics_V2_t;
> >
> > +typedef struct {
> > +  uint32_t CurrClock[PPCLK_COUNT];
> > +
> > +  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t
> > + AverageGfxclkFrequencyPostDs;  uint16_t AverageFclkFrequencyPreDs;
> > + uint16_t AverageFclkFrequencyPostDs;  uint16_t
> > + AverageUclkFrequencyPreDs;  uint16_t AverageUclkFrequencyPostDs;
> > +
> > +
> > +  uint16_t AverageGfxActivity;
> > +  uint16_t AverageUclkActivity;
> > +  uint8_t  CurrSocVoltageOffset;
> > +  uint8_t  CurrGfxVoltageOffset;
> > +  uint8_t  CurrMemVidOffset;
> > +  uint8_t  Padding8;
> > +  uint16_t AverageSocketPower;
> > +  uint16_t TemperatureEdge;
> > +  uint16_t TemperatureHotspot;
> > +  uint16_t TemperatureMem;
> > +  uint16_t TemperatureVrGfx;
> > +  uint16_t TemperatureVrMem0;
> > +  uint16_t TemperatureVrMem1;
> > +  uint16_t TemperatureVrSoc;
> > +  uint16_t TemperatureLiquid0;
> > +  uint16_t TemperatureLiquid1;
> > +  uint16_t TemperaturePlx;
> > +  uint16_t Padding16;
> > +  uint32_t AccCnt;
> > +  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
> > +
> > +
> > +  uint8_t  LinkDpmLevel;
> > +  uint8_t  CurrFanPwm;
> > +  uint16_t CurrFanSpeed;
> > +
> > +  //BACO metrics, PMFW-1721
> > +  //metrics for D3hot entry/exit and driver ARM msgs  uint8_t
> > + D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
> > +  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
> > +  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
> > +
> > +  //PMFW-4362
> > +  uint32_t EnergyAccumulator;
> > +  uint16_t AverageVclk0Frequency;
> > +  uint16_t AverageDclk0Frequency;
> > +  uint16_t AverageVclk1Frequency;
> > +  uint16_t AverageDclk1Frequency;
> > +  uint16_t VcnUsagePercentage0;
> > +  uint16_t VcnUsagePercentage1;
> > +  uint8_t  PcieRate;
> > +  uint8_t  PcieWidth;
> > +  uint16_t AverageGfxclkFrequencyTarget;
> > +
> > +} SmuMetrics_V3_t;
> > +
> >  typedef struct {
> >    union {
> >      SmuMetrics_t SmuMetrics;
> >      SmuMetrics_V2_t SmuMetrics_V2;
> > +    SmuMetrics_V3_t SmuMetrics_V3;
> >    };
> >    uint32_t Spare[1];
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index d9d634ce9575..38f04836c82f 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -554,6 +554,11 @@ static uint32_t
> > sienna_cichlid_get_throttler_status_locked(struct smu_context *s
> >  	int i;
> >
> >  	if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))
> &&
> > +	     (smu->smc_fw_version >=3D 0x3A4900)) {
> > +		for (i =3D 0; i < THROTTLER_COUNT; i++)
> > +			throttler_status |=3D
> > +				(metrics_ext-
> > >SmuMetrics_V3.ThrottlingPercentage[i] ? 1U << i : 0);
> > +	} else if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11,
> > 0, 7)) &&
> >  	     (smu->smc_fw_version >=3D 0x3A4300)) {
> >  		for (i =3D 0; i < THROTTLER_COUNT; i++)
> >  			throttler_status |=3D
> > @@ -574,11 +579,20 @@ static int
> > sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
> >  		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> > >SmuMetrics);
> >  	SmuMetrics_V2_t *metrics_v2 =3D
> >  		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> > >SmuMetrics_V2);
> > -	bool use_metrics_v2 =3D ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D
> > IP_VERSION(11, 0, 7)) &&
> > -		(smu->smc_fw_version >=3D 0x3A4300)) ? true : false;
> > +	SmuMetrics_V3_t *metrics_v3 =3D
> > +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> > >SmuMetrics_V3);
> > +	bool use_metrics_v2 =3D false;
> > +	bool use_metrics_v3 =3D false;
> >  	uint16_t average_gfx_activity;
> >  	int ret =3D 0;
> >
> > +	if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))
> > &&
> > +		(smu->smc_fw_version >=3D 0x3A4900))
> > +		use_metrics_v3 =3D true;
> > +	else if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11,
> > 0, 7)) &&
> > +		(smu->smc_fw_version >=3D 0x3A4300))
> > +		use_metrics_v2 =3D  true;
> > +
> >  	ret =3D smu_cmn_get_metrics_table(smu,
> >  					NULL,
> >  					false);
> > @@ -587,96 +601,119 @@ static int
> > sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
> >
> >  	switch (member) {
> >  	case METRICS_CURR_GFXCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_GFXCLK] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_GFXCLK] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_GFXCLK] :
> >  			metrics->CurrClock[PPCLK_GFXCLK];
> >  		break;
> >  	case METRICS_CURR_SOCCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_SOCCLK] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_SOCCLK] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_SOCCLK] :
> >  			metrics->CurrClock[PPCLK_SOCCLK];
> >  		break;
> >  	case METRICS_CURR_UCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_UCLK] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_UCLK] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_UCLK] :
> >  			metrics->CurrClock[PPCLK_UCLK];
> >  		break;
> >  	case METRICS_CURR_VCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_VCLK_0] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_VCLK_0] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_VCLK_0] :
> >  			metrics->CurrClock[PPCLK_VCLK_0];
> >  		break;
> >  	case METRICS_CURR_VCLK1:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_VCLK_1] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_VCLK_1] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_VCLK_1] :
> >  			metrics->CurrClock[PPCLK_VCLK_1];
> >  		break;
> >  	case METRICS_CURR_DCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_DCLK_0] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_DCLK_0] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_DCLK_0] :
> >  			metrics->CurrClock[PPCLK_DCLK_0];
> >  		break;
> >  	case METRICS_CURR_DCLK1:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_DCLK_1] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_DCLK_1] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_DCLK_1] :
> >  			metrics->CurrClock[PPCLK_DCLK_1];
> >  		break;
> >  	case METRICS_CURR_DCEFCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_DCEFCLK] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_DCEFCLK] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_DCEFCLK] :
> >  			metrics->CurrClock[PPCLK_DCEFCLK];
> >  		break;
> >  	case METRICS_CURR_FCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_FCLK] :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_FCLK] :
> > +			use_metrics_v2 ? metrics_v2-
> > >CurrClock[PPCLK_FCLK] :
> >  			metrics->CurrClock[PPCLK_FCLK];
> >  		break;
> >  	case METRICS_AVERAGE_GFXCLK:
> > -		average_gfx_activity =3D use_metrics_v2 ? metrics_v2-
> > >AverageGfxActivity :
> > +		average_gfx_activity =3D use_metrics_v3 ? metrics_v3-
> > >AverageGfxActivity :
> > +			use_metrics_v2 ? metrics_v2->AverageGfxActivity :
> >  			metrics->AverageGfxActivity;
> >  		if (average_gfx_activity <=3D
> > SMU_11_0_7_GFX_BUSY_THRESHOLD)
> > -			*value =3D use_metrics_v2 ? metrics_v2-
> > >AverageGfxclkFrequencyPostDs :
> > +			*value =3D use_metrics_v3 ? metrics_v3-
> > >AverageGfxclkFrequencyPostDs :
> > +				use_metrics_v2 ? metrics_v2-
> > >AverageGfxclkFrequencyPostDs :
> >  				metrics->AverageGfxclkFrequencyPostDs;
> >  		else
> > -			*value =3D use_metrics_v2 ? metrics_v2-
> > >AverageGfxclkFrequencyPreDs :
> > +			*value =3D use_metrics_v3 ? metrics_v3-
> > >AverageGfxclkFrequencyPreDs :
> > +				use_metrics_v2 ? metrics_v2-
> > >AverageGfxclkFrequencyPreDs :
> >  				metrics->AverageGfxclkFrequencyPreDs;
> >  		break;
> >  	case METRICS_AVERAGE_FCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >AverageFclkFrequencyPostDs :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >AverageFclkFrequencyPostDs :
> > +			use_metrics_v2 ? metrics_v2-
> > >AverageFclkFrequencyPostDs :
> >  			metrics->AverageFclkFrequencyPostDs;
> >  		break;
> >  	case METRICS_AVERAGE_UCLK:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >AverageUclkFrequencyPostDs :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >AverageUclkFrequencyPostDs :
> > +			use_metrics_v2 ? metrics_v2-
> > >AverageUclkFrequencyPostDs :
> >  			metrics->AverageUclkFrequencyPostDs;
> >  		break;
> >  	case METRICS_AVERAGE_GFXACTIVITY:
> > -		*value =3D use_metrics_v2 ? metrics_v2->AverageGfxActivity :
> > +		*value =3D use_metrics_v3 ? metrics_v3->AverageGfxActivity :
> > +			use_metrics_v2 ? metrics_v2->AverageGfxActivity :
> >  			metrics->AverageGfxActivity;
> >  		break;
> >  	case METRICS_AVERAGE_MEMACTIVITY:
> > -		*value =3D use_metrics_v2 ? metrics_v2->AverageUclkActivity :
> > +		*value =3D use_metrics_v3 ? metrics_v3->AverageUclkActivity :
> > +			use_metrics_v2 ? metrics_v2->AverageUclkActivity :
> >  			metrics->AverageUclkActivity;
> >  		break;
> >  	case METRICS_AVERAGE_SOCKETPOWER:
> > -		*value =3D use_metrics_v2 ? metrics_v2-
> > >AverageSocketPower << 8 :
> > +		*value =3D use_metrics_v3 ? metrics_v3-
> > >AverageSocketPower << 8 :
> > +			use_metrics_v2 ? metrics_v2->AverageSocketPower
> > << 8 :
> >  			metrics->AverageSocketPower << 8;
> >  		break;
> >  	case METRICS_TEMPERATURE_EDGE:
> > -		*value =3D (use_metrics_v2 ? metrics_v2->TemperatureEdge :
> > metrics->TemperatureEdge) *
> > -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> > +		*value =3D (use_metrics_v3 ? metrics_v3->TemperatureEdge :
> > +			use_metrics_v2 ? metrics_v2->TemperatureEdge :
> > +			metrics->TemperatureEdge) *
> > SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >  		break;
> >  	case METRICS_TEMPERATURE_HOTSPOT:
> > -		*value =3D (use_metrics_v2 ? metrics_v2-
> > >TemperatureHotspot : metrics->TemperatureHotspot) *
> > -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> > +		*value =3D (use_metrics_v3 ? metrics_v3-
> > >TemperatureHotspot :
> > +			use_metrics_v2 ? metrics_v2->TemperatureHotspot :
> > +			metrics->TemperatureHotspot) *
> > SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >  		break;
> >  	case METRICS_TEMPERATURE_MEM:
> > -		*value =3D (use_metrics_v2 ? metrics_v2->TemperatureMem :
> > metrics->TemperatureMem) *
> > -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> > +		*value =3D (use_metrics_v3 ? metrics_v3->TemperatureMem :
> > +			use_metrics_v2 ? metrics_v2->TemperatureMem :
> > +			metrics->TemperatureMem) *
> > SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >  		break;
> >  	case METRICS_TEMPERATURE_VRGFX:
> > -		*value =3D (use_metrics_v2 ? metrics_v2->TemperatureVrGfx :
> > metrics->TemperatureVrGfx) *
> > -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> > +		*value =3D (use_metrics_v3 ? metrics_v3->TemperatureVrGfx :
> > +			use_metrics_v2 ? metrics_v2->TemperatureVrGfx :
> > +			metrics->TemperatureVrGfx) *
> > SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >  		break;
> >  	case METRICS_TEMPERATURE_VRSOC:
> > -		*value =3D (use_metrics_v2 ? metrics_v2->TemperatureVrSoc :
> > metrics->TemperatureVrSoc) *
> > -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> > +		*value =3D (use_metrics_v3 ? metrics_v3->TemperatureVrSoc :
> > +			use_metrics_v2 ? metrics_v2->TemperatureVrSoc :
> > +			metrics->TemperatureVrSoc) *
> > SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >  		break;
> >  	case METRICS_THROTTLER_STATUS:
> >  		*value =3D sienna_cichlid_get_throttler_status_locked(smu);
> >  		break;
> >  	case METRICS_CURR_FANSPEED:
> > -		*value =3D use_metrics_v2 ? metrics_v2->CurrFanSpeed :
> > metrics->CurrFanSpeed;
> > +		*value =3D use_metrics_v3 ? metrics_v3->CurrFanSpeed :
> > +			use_metrics_v2 ? metrics_v2->CurrFanSpeed :
> > metrics->CurrFanSpeed;
> >  		break;
> >  	default:
> >  		*value =3D UINT_MAX;
> > @@ -3656,12 +3693,22 @@ static ssize_t
> > sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >  		&(metrics_external.SmuMetrics);
> >  	SmuMetrics_V2_t *metrics_v2 =3D
> >  		&(metrics_external.SmuMetrics_V2);
> > +	SmuMetrics_V3_t *metrics_v3 =3D
> > +		&(metrics_external.SmuMetrics_V3);
> >  	struct amdgpu_device *adev =3D smu->adev;
> > -	bool use_metrics_v2 =3D ((adev->ip_versions[MP1_HWIP][0] =3D=3D
> > IP_VERSION(11, 0, 7)) &&
> > -		(smu->smc_fw_version >=3D 0x3A4300)) ? true : false;
> > +	bool use_metrics_v2 =3D false;
> > +	bool use_metrics_v3 =3D false;
> >  	uint16_t average_gfx_activity;
> >  	int ret =3D 0;
> >
> > +	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) &&
> > +		(smu->smc_fw_version >=3D 0x3A4900))
> > +		use_metrics_v3 =3D true;
> > +	else if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))
> > &&
> > +		(smu->smc_fw_version >=3D 0x3A4300))
> > +		use_metrics_v2 =3D true;
> > +
> > +
> >  	ret =3D smu_cmn_get_metrics_table(smu,
> >  					&metrics_external,
> >  					true);
> > @@ -3670,29 +3717,30 @@ static ssize_t
> > sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >
> >  	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
> >
> > -	gpu_metrics->temperature_edge =3D
> > +	gpu_metrics->temperature_edge =3D use_metrics_v3 ? metrics_v3-
> > >TemperatureEdge :
> >  		use_metrics_v2 ? metrics_v2->TemperatureEdge : metrics-
> > >TemperatureEdge;
> > -	gpu_metrics->temperature_hotspot =3D
> > +	gpu_metrics->temperature_hotspot =3D use_metrics_v3 ? metrics_v3-
> > >TemperatureHotspot :
> >  		use_metrics_v2 ? metrics_v2->TemperatureHotspot :
> > metrics->TemperatureHotspot;
> > -	gpu_metrics->temperature_mem =3D
> > +	gpu_metrics->temperature_mem =3D use_metrics_v3 ? metrics_v3-
> > >TemperatureMem :
> >  		use_metrics_v2 ? metrics_v2->TemperatureMem : metrics-
> > >TemperatureMem;
> > -	gpu_metrics->temperature_vrgfx =3D
> > +	gpu_metrics->temperature_vrgfx =3D use_metrics_v3 ? metrics_v3-
> > >TemperatureVrGfx :
> >  		use_metrics_v2 ? metrics_v2->TemperatureVrGfx : metrics-
> > >TemperatureVrGfx;
> > -	gpu_metrics->temperature_vrsoc =3D
> > +	gpu_metrics->temperature_vrsoc =3D use_metrics_v3 ? metrics_v3-
> > >TemperatureVrSoc :
> >  		use_metrics_v2 ? metrics_v2->TemperatureVrSoc : metrics-
> > >TemperatureVrSoc;
> > -	gpu_metrics->temperature_vrmem =3D
> > +	gpu_metrics->temperature_vrmem =3D use_metrics_v3 ? metrics_v3-
> > >TemperatureVrMem0 :
> >  		use_metrics_v2 ? metrics_v2->TemperatureVrMem0 :
> > metrics->TemperatureVrMem0;
> >
> > -	gpu_metrics->average_gfx_activity =3D
> > +	gpu_metrics->average_gfx_activity =3D use_metrics_v3 ? metrics_v3-
> > >AverageGfxActivity :
> >  		use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics-
> > >AverageGfxActivity;
> > -	gpu_metrics->average_umc_activity =3D
> > +	gpu_metrics->average_umc_activity =3D use_metrics_v3 ? metrics_v3-
> > >AverageUclkActivity :
> >  		use_metrics_v2 ? metrics_v2->AverageUclkActivity : metrics-
> > >AverageUclkActivity;
> > -	gpu_metrics->average_mm_activity =3D
> > +	gpu_metrics->average_mm_activity =3D use_metrics_v3 ?
> > +		(metrics_v3->VcnUsagePercentage0 + metrics_v3-
> > >VcnUsagePercentage1) / 2 :
> >  		use_metrics_v2 ? metrics_v2->VcnActivityPercentage :
> > metrics->VcnActivityPercentage;
> >
> > -	gpu_metrics->average_socket_power =3D
> > +	gpu_metrics->average_socket_power =3D use_metrics_v3 ?
> > metrics_v3->AverageSocketPower :
> >  		use_metrics_v2 ? metrics_v2->AverageSocketPower :
> > metrics->AverageSocketPower;
> > -	gpu_metrics->energy_accumulator =3D
> > +	gpu_metrics->energy_accumulator =3D use_metrics_v3 ? metrics_v3-
> > >EnergyAccumulator :
> >  		use_metrics_v2 ? metrics_v2->EnergyAccumulator : metrics-
> > >EnergyAccumulator;
> >
> >  	if (metrics->CurrGfxVoltageOffset)
> > @@ -3705,37 +3753,45 @@ static ssize_t
> > sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >  		gpu_metrics->voltage_soc =3D
> >  			(155000 - 625 * metrics->CurrSocVoltageOffset) / 100;
> >
> > -	average_gfx_activity =3D use_metrics_v2 ? metrics_v2-
> > >AverageGfxActivity : metrics->AverageGfxActivity;
> > +	average_gfx_activity =3D use_metrics_v3 ? metrics_v3-
> > >AverageGfxActivity :
> > +		use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics-
> > >AverageGfxActivity;
> >  	if (average_gfx_activity <=3D SMU_11_0_7_GFX_BUSY_THRESHOLD)
> >  		gpu_metrics->average_gfxclk_frequency =3D
> > -			use_metrics_v2 ? metrics_v2-
> > >AverageGfxclkFrequencyPostDs : metrics-
> >AverageGfxclkFrequencyPostDs;
> > +			use_metrics_v3 ? metrics_v3-
> > >AverageGfxclkFrequencyPostDs :
> > +			use_metrics_v2 ? metrics_v2-
> > >AverageGfxclkFrequencyPostDs :
> > +			metrics->AverageGfxclkFrequencyPostDs;
> >  	else
> >  		gpu_metrics->average_gfxclk_frequency =3D
> > -			use_metrics_v2 ? metrics_v2-
> > >AverageGfxclkFrequencyPreDs : metrics->AverageGfxclkFrequencyPreDs;
> > +			use_metrics_v3 ? metrics_v3-
> > >AverageGfxclkFrequencyPreDs :
> > +			use_metrics_v2 ? metrics_v2-
> > >AverageGfxclkFrequencyPreDs :
> > +			metrics->AverageGfxclkFrequencyPreDs;
> > +
> >  	gpu_metrics->average_uclk_frequency =3D
> > -		use_metrics_v2 ? metrics_v2-
> > >AverageUclkFrequencyPostDs : metrics->AverageUclkFrequencyPostDs;
> > -	gpu_metrics->average_vclk0_frequency =3D
> > +		use_metrics_v3 ? metrics_v3-
> > >AverageUclkFrequencyPostDs :
> > +		use_metrics_v2 ? metrics_v2-
> > >AverageUclkFrequencyPostDs :
> > +		metrics->AverageUclkFrequencyPostDs;
> > +	gpu_metrics->average_vclk0_frequency =3D use_metrics_v3 ?
> > metrics_v3->AverageVclk0Frequency :
> >  		use_metrics_v2 ? metrics_v2->AverageVclk0Frequency :
> > metrics->AverageVclk0Frequency;
> > -	gpu_metrics->average_dclk0_frequency =3D
> > +	gpu_metrics->average_dclk0_frequency =3D use_metrics_v3 ?
> > metrics_v3->AverageDclk0Frequency :
> >  		use_metrics_v2 ? metrics_v2->AverageDclk0Frequency :
> > metrics->AverageDclk0Frequency;
> > -	gpu_metrics->average_vclk1_frequency =3D
> > +	gpu_metrics->average_vclk1_frequency =3D use_metrics_v3 ?
> > metrics_v3->AverageVclk1Frequency :
> >  		use_metrics_v2 ? metrics_v2->AverageVclk1Frequency :
> > metrics->AverageVclk1Frequency;
> > -	gpu_metrics->average_dclk1_frequency =3D
> > +	gpu_metrics->average_dclk1_frequency =3D use_metrics_v3 ?
> > metrics_v3->AverageDclk1Frequency :
> >  		use_metrics_v2 ? metrics_v2->AverageDclk1Frequency :
> > metrics->AverageDclk1Frequency;
> >
> > -	gpu_metrics->current_gfxclk =3D
> > +	gpu_metrics->current_gfxclk =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_GFXCLK] :
> >  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_GFXCLK] :
> > metrics->CurrClock[PPCLK_GFXCLK];
> > -	gpu_metrics->current_socclk =3D
> > +	gpu_metrics->current_socclk =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_SOCCLK] :
> >  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_SOCCLK] :
> > metrics->CurrClock[PPCLK_SOCCLK];
> > -	gpu_metrics->current_uclk =3D
> > +	gpu_metrics->current_uclk =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_UCLK] :
> >  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_UCLK] :
> > metrics->CurrClock[PPCLK_UCLK];
> > -	gpu_metrics->current_vclk0 =3D
> > +	gpu_metrics->current_vclk0 =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_VCLK_0] :
> >  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_0] :
> > metrics->CurrClock[PPCLK_VCLK_0];
> > -	gpu_metrics->current_dclk0 =3D
> > +	gpu_metrics->current_dclk0 =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_DCLK_0] :
> >  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_0] :
> > metrics->CurrClock[PPCLK_DCLK_0];
> > -	gpu_metrics->current_vclk1 =3D
> > +	gpu_metrics->current_vclk1 =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_VCLK_1] :
> >  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_1] :
> > metrics->CurrClock[PPCLK_VCLK_1];
> > -	gpu_metrics->current_dclk1 =3D
> > +	gpu_metrics->current_dclk1 =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_DCLK_1] :
> >  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] :
> > metrics->CurrClock[PPCLK_DCLK_1];
> >
> >  	gpu_metrics->throttle_status =3D
> > sienna_cichlid_get_throttler_status_locked(smu);
> > @@ -3743,12 +3799,15 @@ static ssize_t
> > sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >  			smu_cmn_get_indep_throttler_status(gpu_metrics-
> > >throttle_status,
> >
> > sienna_cichlid_throttler_map);
> >
> > -	gpu_metrics->current_fan_speed =3D use_metrics_v2 ? metrics_v2-
> > >CurrFanSpeed : metrics->CurrFanSpeed;
> > +	gpu_metrics->current_fan_speed =3D use_metrics_v3 ? metrics_v3-
> > >CurrFanSpeed :
> > +		use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics-
> > >CurrFanSpeed;
> >
> >  	if (((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) &&
> > smu->smc_fw_version > 0x003A1E00) ||
> >  	      ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 11)) =
&&
> > smu->smc_fw_version > 0x00410400)) {
> > -		gpu_metrics->pcie_link_width =3D use_metrics_v2 ?
> > metrics_v2->PcieWidth : metrics->PcieWidth;
> > -		gpu_metrics->pcie_link_speed =3D
> > link_speed[use_metrics_v2 ? metrics_v2->PcieRate : metrics->PcieRate];
> > +		gpu_metrics->pcie_link_width =3D use_metrics_v3 ?
> > metrics_v3->PcieWidth :
> > +			use_metrics_v2 ? metrics_v2->PcieWidth : metrics-
> > >PcieWidth;
> > +		gpu_metrics->pcie_link_speed =3D
> > link_speed[use_metrics_v3 ? metrics_v3->PcieRate :
> > +			use_metrics_v2 ? metrics_v2->PcieRate : metrics-
> > >PcieRate];
> >  	} else {
> >  		gpu_metrics->pcie_link_width =3D
> >
> > 	smu_v11_0_get_current_pcie_link_width(smu);
> > --
> > 2.20.1
