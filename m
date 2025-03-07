Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54FDC19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 09:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747E510EB14;
	Fri,  7 Mar 2025 09:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="whDrgiVs";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFBE10EB14
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 09:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErvbZ5TVrYm6Jlddrnd/j5yAbIUp0v/ntuKKF1oGsejpJUnD1vf7U0HeJqAH6YYOZE8MRiZh8Y2dIb1lKkjfqoEZquReYET1TIFELinO5K4/a+NL0YdMEGqCizyVaE4+zQMxToofFNzQulrw0X8NDG7Laa6VVWeNyiau6ct/MLSy6jPETLUzfLcbOQugt+u1QWU5uMQvcf0qcMDrqXx0xbhuxA+PRvkF3ukYfBMd1lE+lhxq9Uerx/D0FenP9L7bSgNGI/AhrxPa+afF3z+J8vl93l51lLWVwwAVCmpttCx36jMywiwVXRo8oVu3BKcGS8gPq2z7mYZLAuIYkqpYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tKqQjY1AuNgtNlv/PBqw4FyR0uwUlK9jJIdk6s3mw4=;
 b=kaOlHFkrDptHmnejdaTMxEPNRJAlFLbAlTHOQSDI7mt4wZjr9iq9lKQbR07jLd/4FF8NOuL4YtcoOIfoIqiZM+lAv0WmvRs+eLXJyGAyDX7IJ6105KCMU+fwoa/LCTxiUjmnLT1Yv5X1bQBwpqwzgsVuDc+OtFU3mJaO2tFaU+kiWcq3UYV+DEZ7nXyP/dc5LcYoC9rfwXAEk88P+vMG8uv9sON4Fp6VdK+Rt2jGZJnyYs79wSbP3zFr/HJcuG9EaYKVHwff27pJnTXLDEnTy/PLFlhDG4rUZzvazYPqeVxSAdv0vMoMg3JAhIUlyX5lMQ3rhowgL2ysvv/09lBoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tKqQjY1AuNgtNlv/PBqw4FyR0uwUlK9jJIdk6s3mw4=;
 b=whDrgiVsJv/10WqDE9AW4paGyFqEYfNNqLaZGCLjmnxtJXiW5so/PKXUlYOQduMfiOJd05OsLL+I+UjzfvY05E1VH1ugT6Nkn7ZBU0oopOei67sFXXz9bgz7qxuNXopRumroVgQ5QRecrS6C1ibylvJqjRiR3wcJExxwMObzVJY=
Received: from SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.18; Fri, 7 Mar 2025 09:16:10 +0000
Received: from SJ2PR12MB7990.namprd12.prod.outlook.com
 ([fe80::b83a:d225:234b:6c57]) by SJ2PR12MB7990.namprd12.prod.outlook.com
 ([fe80::b83a:d225:234b:6c57%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 09:16:10 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Thread-Topic: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Thread-Index: AQHbjyy7TYErPVdmpUSoneZxFZ4I6LNnR7vQgAATLQCAAAlXgA==
Date: Fri, 7 Mar 2025 09:16:09 +0000
Message-ID: <SJ2PR12MB79909F0105A43CC05BE8E3639AD52@SJ2PR12MB7990.namprd12.prod.outlook.com>
References: <20250307064639.273141-1-tao.zhou1@amd.com>
 <PH7PR12MB7988E52CFA8019C506A46AA59AD52@PH7PR12MB7988.namprd12.prod.outlook.com>
 <PH7PR12MB87963B4294E9CC47449C3614B0D52@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87963B4294E9CC47449C3614B0D52@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bb6828aa-0ca0-4f27-be9e-8b942e310789;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-07T07:32:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7990:EE_|DM4PR12MB5769:EE_
x-ms-office365-filtering-correlation-id: 47e4dfeb-8782-40ea-1d50-08dd5d58b319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZNFwqro4fKL1NLy+dDZbZZ6VzBemiHDsO+H7cyWO4La0iOvSjeG6JdkMEp0T?=
 =?us-ascii?Q?63SlJdHjXnhlB9b7NKU9xisqxTc5dUo4Ics8BZYcBhyIbxtUJv99HPv5+CyD?=
 =?us-ascii?Q?lFPw8iOCfQxjU1xCy6nIr8yI7TZO0peK/zjyCGax/YMYOwUwcNRlIamBD4Ka?=
 =?us-ascii?Q?xtIoKRyNfNKRO6rtsmeegHWs+2d6M2GL3A6t5uIR0jN/sLFCG+YvnZ5YmEsR?=
 =?us-ascii?Q?DkZGmwGolMTf9Q6Yw/MJHDf0LAyx/sKd2O5fTT7VCvbZLb/cu5ygyb22jQ4H?=
 =?us-ascii?Q?wtdqo6Y2XGPY1vXmuMIzHEV088vdtp2igkQ1P/GJG4UX/HdfPdzd4Tp+4t3f?=
 =?us-ascii?Q?KHhONRNNCQtgJkP3qo+PWi2jvDKbYHIJvchJ0+50udZEE12g8ETajDQFVY8f?=
 =?us-ascii?Q?yOXD7rbQy8nlrZvgmxXFPtE31BTCe8ogW9IByR6EUpFYMCaQ5mGIvxEav+4R?=
 =?us-ascii?Q?F+EyAXGZ9WyzaLUqRR7TmkLy9NDyV5Otr3p69sLkgJuP8RQ7vPWseQiQr/Cl?=
 =?us-ascii?Q?ir6OwRCUu2lu69NGwciiYAlAz6AUUB/S2RY6kCAslgEPqtkNlMnVAK4Xm/pj?=
 =?us-ascii?Q?rslbV373h6xi0xCuaO2kdPvOyM28Crehh+81USOsf2/rds9uGmXfVTsvcrbe?=
 =?us-ascii?Q?9L16vl0jWQ5KoIkcLjFYMicqzwVKoEV5pfUT/JwxoPPwYFCLbzlsuc9+0XO+?=
 =?us-ascii?Q?qbkwZ/yLH2ZPQKPuzKBb7vPEc2/mxHxc2gjW0EHSjG6x5+7CcatNRofiPCTD?=
 =?us-ascii?Q?29DKVbsWA3mmSGkpeHoP0bxZhblCg9AKcO9jgACJRwRzQEmCY+49riC0/uap?=
 =?us-ascii?Q?7vd3wwT39CVn5OqlBWwSYw0n/S/IMxrYPpZTtiUKuCW/qT3ROF+KWkXYVqqZ?=
 =?us-ascii?Q?Nfagarcvn7poIc9r1APzCwmFHK30IelaWbh6y8rEbzBKUhY+qWR5ghNvc8DY?=
 =?us-ascii?Q?Pdy16AijHFy4TlBp8xfc8n4CDqa78RR5OenlFR6L+Ote4redgKFs+lag/iYH?=
 =?us-ascii?Q?Rsc4Wh6XkZeRqcgTtfEO9vC46QxeipRdsrjjPBnbST+qTmcce6+hGKEnst0Y?=
 =?us-ascii?Q?s+F7eODD7vypbCwkEqhXo5MHf85Tul02RlMPrZD78BNoTPO+uwPTuBInScU6?=
 =?us-ascii?Q?plbM++JfGz+IIp+Fcr1I0eO8M6DMV6o2oe4EUkWCr5NzvyX38X5L2rzF7Ssi?=
 =?us-ascii?Q?SIKdFGWvBfomqgu0bwX7a0y6jjKdAGLcL3819CRSDVXUEXGgdUUn13OeIT2K?=
 =?us-ascii?Q?0cehOl7ncAiTE/gBAWKioGVbAnfv1a8ccS/HfWpfmakMrWF3/VA2xMEiGSEZ?=
 =?us-ascii?Q?pspAJ67AVv/+MbvQLvi120YR+MFQJUHhkY8ESdrXdKJ73k5w+vlCLS8eeVAm?=
 =?us-ascii?Q?mxWOHZouCunPVkyySzcbLvyM+rHvevzyPwVRS7XNS36r7L9a5/cF3AVeJIhl?=
 =?us-ascii?Q?5gXKjEzKejHtCLL05LpeLlOuw5PqYZez?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB7990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YqswidkFzn2G3KfgF/1nphj4CPHt3lqcXppFq/DKBp/Dz89acjkTEVOSFAJm?=
 =?us-ascii?Q?GT3U5iftrXGgnkW1mBo4tu+JCVy6u+fqw9vzxq/F7n6EGp9B7rZ5OYaS3Po2?=
 =?us-ascii?Q?6OPIfg88BoTV47uCukOxNoUCv5Q1ixsUqRN9IE7Ktwtazs66jwUVHTioeYKk?=
 =?us-ascii?Q?Aon8dZ4kHS40vEfbksE90FrkcomVw+52kwhSxwKzyFJJHDFAyifSrNVyrQJz?=
 =?us-ascii?Q?Q6ws8oLM9iwwcJ0lLheDiO2I6QKiR0NlRhqGPlVm+jIbDRbE/0r9yvRdVia4?=
 =?us-ascii?Q?Ifqhm15vO8VAmoEin0KpIaBoa9WdU43Far0g5MCEOYEGpcMwKhDsJPXSYzjJ?=
 =?us-ascii?Q?iMzmZyiRUFA/ItI32bKxL0R6pnWAb/kfo3zv5T7Z3qHXH77NtthPEQIPruUb?=
 =?us-ascii?Q?IuZGQpDCbtd6+RQ+etixmTxBaIdrmzeuIrFWCHz00Z15lOapsrkIqSPhDsRS?=
 =?us-ascii?Q?K2G+ZZUIA/sWWd9MsFJqh8VYxDkNbPi1rERqx7E2f1kWP7Ghj82pwhPxJps5?=
 =?us-ascii?Q?/HfFSVugVL3wSM8LREd/d+jPyPskuXXIVEJAvH76ZrXmM2xCdB76HaFlMT0V?=
 =?us-ascii?Q?wLD6EqhJZm3Yf/XK8WtD/YTV2hhjqBVoEdFGOWQGkqOtUlaXcX21+bmedDUm?=
 =?us-ascii?Q?fRE3EfUyZQaSgRv0Mk/O1KhrYSF0z5CphMsp5DVdd4wp/2Az8ahxb11jreGp?=
 =?us-ascii?Q?q8Obutk3HeEMIJFYpZUYH298FRXVz9bTcZ6Vnoon6MhBJ86BcWACF86Yf00z?=
 =?us-ascii?Q?KBVAUGyecmTGH8iIXuei0MkIxsjtn9coBhcadXarsa3ob/3TIKb/84pbUJFi?=
 =?us-ascii?Q?P3e8g/RCaD47+tCw2DQSfemn6NRP2CU8B5VYGlvZYtKSrCZlp6CH86YUX0SM?=
 =?us-ascii?Q?SyDSt2DR5xdZC5t9n2Qob8nIEi8p298MoQxdSZZBtFs7+JSdSVNr89fH7Sm9?=
 =?us-ascii?Q?VYyTHDmMNDZzCVKrC/RXU6QtjPkT983octUs2hpayIre2+91hOizfMqFjyEo?=
 =?us-ascii?Q?Qa+fNl7RbBZoC1MBnJBSNvIPwZLkSlpa8VBHRcogYigZLmw4eL92QluTU79m?=
 =?us-ascii?Q?Ii3LnQXbAx2E/gqxP5z9eWC4wKrmTcAYFzMIIKJmV1407c1qAglQPt/Zlbp4?=
 =?us-ascii?Q?8SarJFhi1P31XU1C/MK9WxJMvbiHJl8MsSdREd6Cj0Ogq2W+cS6ZDbtKIVAg?=
 =?us-ascii?Q?2CNrJr2UYDE3TToJ8KkWyTH3nBd3pqsaSeIsWTR7lUS2XWk0P6tNqL6UiSm5?=
 =?us-ascii?Q?igAyn7q4lavLZsKgYxC6ch+kDv6Xl6nuaUv7OHn6MNOAf7VWU64imOexzdTV?=
 =?us-ascii?Q?oUl9YHHP03HXdpmE+sKgAlQRohG/FkwAOxI3nX1tqtI+AEAJGNZGLPoFGMnV?=
 =?us-ascii?Q?q1c0csrmoIdZEMvg2km5CT3on2nGaRTiPPC6bjc6DMUzH01UmDM2Vs5nJ773?=
 =?us-ascii?Q?LLBhAWOjTcco1GhnsjZn8lGRBCMjzhT/2n6MXl+tU5cWL1wU51y/OhQU/KWC?=
 =?us-ascii?Q?1hQX/x1dvSvNFQKD/njVpgYdX55AwLH+NKMjlzxp4j//tmZGF+9pDz+wkSLo?=
 =?us-ascii?Q?6VBnRJ+TuYMqrEm1NCk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e4dfeb-8782-40ea-1d50-08dd5d58b319
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 09:16:09.9389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rES35BcdiBnqjg06D5tVwRrdfn/Do1mmf+RVJEvtdXRplzo+wtN/NgmeHbXJuTM1GbC/6DffGeWk3WErm647ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, March 7, 2025 4:41 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 versi=
on
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Yang, Stanley <Stanley.Yang@amd.com>
> > Sent: Friday, March 7, 2025 3:36 PM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
> > version
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Tao Zhou
> > > Sent: Friday, March 7, 2025 2:47 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > > Subject: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
> > > version
> > >
> > > Clear old data and save it in V3 format.
> > >
> > > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 ++++
> > >  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++++-------=
--
> > >  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  1 +
> > >  3 files changed, 20 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > index 837f33698b38..266f24002e07 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > @@ -3465,6 +3465,11 @@ int amdgpu_ras_init_badpage_info(struct
> > > amdgpu_device *adev)
> > >                               adev, control->bad_channel_bitmap);
> > >                       con->update_channel_flag =3D false;
> > >               }
> > > +
> > > +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3)
> >
> > [Stanley]: should check ip_version here, this affect all asics that
> > epprom table version is low  then V3.
>
> [Tao] how about "if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)"=
 ?

[Stanley]: if v3 is only for UMC_HWIP 12.0.0, I suggest adding ip version h=
ere.

Regards,
Stanley
>
> >
> > Regards
> > Stanley
> > > +                     if (!amdgpu_ras_eeprom_reset_table(control))
> > > +                             if (amdgpu_ras_save_bad_pages(adev, NUL=
L))
> > > +                                     dev_warn(adev->dev, "Failed to
> > > + save
> > > EEPROM data in V3 format!\n");
> > >       }
> > >
> > >       return ret;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > index 09a6f8bc1a5a..71dddb8983ee 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > @@ -413,9 +413,11 @@ static void
> > > amdgpu_ras_set_eeprom_table_version(struct
> > > amdgpu_ras_eeprom_control
> > >
> > >       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
> > >       case IP_VERSION(8, 10, 0):
> > > -     case IP_VERSION(12, 0, 0):
> > >               hdr->version =3D RAS_TABLE_VER_V2_1;
> > >               return;
> > > +     case IP_VERSION(12, 0, 0):
> > > +             hdr->version =3D RAS_TABLE_VER_V3;
> > > +             return;
> > >       default:
> > >               hdr->version =3D RAS_TABLE_VER_V1;
> > >               return;
> > > @@ -443,7 +445,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> > > amdgpu_ras_eeprom_control *control)
> > >       hdr->header =3D RAS_TABLE_HDR_VAL;
> > >       amdgpu_ras_set_eeprom_table_version(control);
> > >
> > > -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> > > +     if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> > >               hdr->first_rec_offset =3D RAS_RECORD_START_V2_1;
> > >               hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE +
> > >                               RAS_TABLE_V2_1_INFO_SIZE; @@ -461,7
> > > +463,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> > > amdgpu_ras_eeprom_control *control)
> > >       }
> > >
> > >       csum =3D __calc_hdr_byte_sum(control);
> > > -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1)
> > > +     if (hdr->version >=3D RAS_TABLE_VER_V2_1)
> > >               csum +=3D __calc_ras_info_byte_sum(control);
> > >       csum =3D -csum;
> > >       hdr->checksum =3D csum;
> > > @@ -752,7 +754,7 @@ amdgpu_ras_eeprom_update_header(struct
> > > amdgpu_ras_eeprom_control *control)
> > >                       "Saved bad pages %d reaches threshold value %d\=
n",
> > >                       control->ras_num_bad_pages, ras-
> > > >bad_page_cnt_threshold);
> > >               control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
> > > -             if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)=
 {
> > > +             if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
> > >                       control->tbl_rai.rma_status =3D
> > > GPU_RETIRED__ECC_REACH_THRESHOLD;
> > >                       control->tbl_rai.health_percent =3D 0;
> > >               }
> > > @@ -765,7 +767,7 @@ amdgpu_ras_eeprom_update_header(struct
> > > amdgpu_ras_eeprom_control *control)
> > >               amdgpu_dpm_send_rma_reason(adev);
> > >       }
> > >
> > > -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> > > +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
> > >               control->tbl_hdr.tbl_size =3D RAS_TABLE_HEADER_SIZE +
> > >                                           RAS_TABLE_V2_1_INFO_SIZE +
> > >                                           control->ras_num_recs *
> > > RAS_TABLE_RECORD_SIZE; @@ -805,7 +807,7 @@
> > > amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control
> > *control)
> > >        * now calculate gpu health percent
> > >        */
> > >       if (amdgpu_bad_page_threshold !=3D 0 &&
> > > -         control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
> > > +         control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1 &&
> > >           control->ras_num_bad_pages <=3D ras->bad_page_cnt_threshold=
)
> > >               control->tbl_rai.health_percent =3D
> > > ((ras->bad_page_cnt_threshold -
> > >
> > > control->ras_num_bad_pages) * 100) / @@ -818,7 +820,7 @@
> > > amdgpu_ras_eeprom_update_header(struct
> > > amdgpu_ras_eeprom_control *control)
> > >               csum +=3D *pp;
> > >
> > >       csum +=3D __calc_hdr_byte_sum(control);
> > > -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> > > +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
> > >               csum +=3D __calc_ras_info_byte_sum(control);
> > >       /* avoid sign extension when assigning to "checksum" */
> > >       csum =3D -csum;
> > > @@ -1035,7 +1037,7 @@ uint32_t
> > > amdgpu_ras_eeprom_max_record_count(struct
> > > amdgpu_ras_eeprom_control *co
> > >       /* get available eeprom table version first before eeprom table=
 init */
> > >       amdgpu_ras_set_eeprom_table_version(control);
> > >
> > > -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> > > +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
> > >               return RAS_MAX_RECORD_COUNT_V2_1;
> > >       else
> > >               return RAS_MAX_RECORD_COUNT; @@ -1280,7 +1282,7 @@
> > > static int __verify_ras_table_checksum(struct
> > > amdgpu_ras_eeprom_control *control
> > >       int buf_size, res;
> > >       u8  csum, *buf, *pp;
> > >
> > > -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> > > +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
> > >               buf_size =3D RAS_TABLE_HEADER_SIZE +
> > >                          RAS_TABLE_V2_1_INFO_SIZE +
> > >                          control->ras_num_recs *
> > > RAS_TABLE_RECORD_SIZE; @@ -1383,7 +1385,7 @@ int
> > > amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
> > >
> > >       __decode_table_header_from_buf(hdr, buf);
> > >
> > > -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> > > +     if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> > >               control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
> > >               control->ras_record_offset =3D RAS_RECORD_START_V2_1;
> > >               control->ras_max_record_count =3D
> > > RAS_MAX_RECORD_COUNT_V2_1; @@ -1423,7 +1425,7 @@ int
> > > amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
> > >               DRM_DEBUG_DRIVER("Found existing EEPROM table with %d
> > > records",
> > >                                control->ras_num_bad_pages);
> > >
> > > -             if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> > > +             if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> > >                       res =3D __read_table_ras_info(control);
> > >                       if (res)
> > >                               return res; @@ -1443,7 +1445,7 @@ int
> > > amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
> > >                                       ras->bad_page_cnt_threshold);
> > >       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
> > >                  amdgpu_bad_page_threshold !=3D 0) {
> > > -             if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> > > +             if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> > >                       res =3D __read_table_ras_info(control);
> > >                       if (res)
> > >                               return res; diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > > index 13f7eda9a696..ec6d7ea37ad0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > > @@ -28,6 +28,7 @@
> > >
> > >  #define RAS_TABLE_VER_V1           0x00010000
> > >  #define RAS_TABLE_VER_V2_1         0x00021000
> > > +#define RAS_TABLE_VER_V3           0x00030000
> > >
> > >  struct amdgpu_device;
> > >
> > > --
> > > 2.34.1
> >
>

