Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6282CCAC5B9
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 08:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E0310E036;
	Tue, 30 Sep 2025 08:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cD3SD+ql";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013059.outbound.protection.outlook.com
 [40.93.196.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4091910E036
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 08:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7/0sAijMWdHSgo4jS9DYerl9C30naI/xuOrj02n6J297fJlDSZY6nOEO5e9Wqs3y6d09i6m/gvrZyXvSxWf4a3JwVvRNrrLloURSDrHjHTc+vJD4/9mSzjwyFQ4WO5XAOZ10SEAI5jG3ur2t4vNk/kZF857v7xbLeJN2eVZMq9lkaN+mq0zYe0TC6xmwdJOoO0LGZQB70kpLmQ/dLS3IpCvSAwPHbaqtmFSo8E/fdK90vhP1UM3unN73auJSyBTkwPuRZaJvKr+6ZnCpVkoG4mQKIIx9ZuMomUBf5QjdTipWzXJnuhIBpXx90gpnNrgAYePjY313ObZ/L6ko4my8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQCDfZk86kHD6pYYZIE+sy+7KyBKV2CTiWmnWenmeyo=;
 b=XoC6VRdzCY2YD1cBaDPK3qISV5r6itJNuLWQk44/qfNgjRGNWAAX+bNNwodCj4ZP98VUs5yKBY0LYb5tgiWqNe9LoSRDLO9jg0YQGDtgecuqcZdTwne0KKdwUQsnWRjBLjzMUhbORr8Lw6qG7J+ptrfmkdirCEEYogKE/+Yx2YlE+W8TnM2y4hjEhCnjJEjH9bPQUQrtWTVAUyDS0vwobBMm8y4DimKjkva6nCuUJ7UtngXUxIgxtfPR2YmX+JFAgQE8l8Nuee1YgCsZi3CidFXbKp9TOsAUZKDOg0V0N6rGDRY8hzwtB2kOYNu13U/CxTJSwwoG7rxkg5vKsNxeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQCDfZk86kHD6pYYZIE+sy+7KyBKV2CTiWmnWenmeyo=;
 b=cD3SD+qlCiiZVoye3DD29porsK3HFo694zgXn/+KxPmpvTXGs02GdYWppC/CXXClIMRonXMYM6U82PSruF3I8w2wymC2AyIiuOZCs1/jilEBuG14zJFmY2zliXxnWd2LdYDkY/GTY6/ujRdRHZSVOsi+ad0AtSEFRrRzM7EzEzA=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:58:04 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 08:58:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v5 4/8] drm/amdgpu: keeping waiting userq fence infinitely
Thread-Topic: [PATCH v5 4/8] drm/amdgpu: keeping waiting userq fence infinitely
Thread-Index: AQHcMRh4f54u41pNDkSkWx4wN2ttgrSrX8MAgAAMxXA=
Date: Tue, 30 Sep 2025 08:58:04 +0000
Message-ID: <DS7PR12MB6005CC863B157E3F86C10A6CFB1AA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
 <20250929080944.2892809-4-Prike.Liang@amd.com>
 <DS7PR12MB6005E75670D98152A2C996D2FB1AA@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005E75670D98152A2C996D2FB1AA@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-30T08:12:43.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB5736:EE_
x-ms-office365-filtering-correlation-id: d56b24c0-8b6e-4401-f6d7-08ddffff7780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ICuopj0kRrQQVB/8qW7NBWXAiKIB/IrCW3NKXyioxbW6hw0RrHN7P1I8Ears?=
 =?us-ascii?Q?/fVpAUGL7y9Rw+Uq/g7FgsSQuCbKkNVJN7oa13fQfGz0HBJHgWFeU8KoNljT?=
 =?us-ascii?Q?LjynlFKeZ30JZ+grzX32roCEGiA/lX46g6kWOs9sLIs6n6B3nMB9bcN1ToZf?=
 =?us-ascii?Q?ZG9LDM6Q+kYeztITN/JfOX+W8jnRr8r/LSUcePDePIFi14wIf6Jvd01Z+W7b?=
 =?us-ascii?Q?PLXI2BQ7vmeUxnLQbTt2hkKl3tF8cv4XRBCyI6Ftogl00ZFr8g+TmlPiJRGl?=
 =?us-ascii?Q?8Hb3q22gsUyaf4bbzenQPfu5zYexRVJM4p+KXWhjIf0tQXIUEvMiPLanarYa?=
 =?us-ascii?Q?jt3RKvvwPWTD5vedK719VZXbizxN1qL978rTerE+m6Gla9/hMMdicS2KHa6v?=
 =?us-ascii?Q?cWxxP4uUYzWiYYxBO1B22zXetAz7fFjkjG38+a9Q1WBB86IRNu6DreEak4jT?=
 =?us-ascii?Q?7GdMiNFvn2AV+wrT5Dv+zuU6UegUlEvKg56K/DQSymNItVj/7NtsA0X2C27V?=
 =?us-ascii?Q?XeES0bgDcws0ConVTfkGRr7zeXOb1/nAagkFuSptouQ2VJP0ShHixeJ3qP4n?=
 =?us-ascii?Q?QFYFjuPv8lv1ddhXZ75CW5xNqBoTp3dyLTEPKfliHpmfD3z1wLUTtuLkZ8Px?=
 =?us-ascii?Q?8ZtC/XAaICotWC0+Uue6YvbeDSkwtoQCChZyqqb/IChR7eathWcBFLRK434g?=
 =?us-ascii?Q?hj5STkYgea1qBGaAYDi7TPrP7sxBC7LBjCmDKqhRn2sAMW6uISdzg+cCKvXi?=
 =?us-ascii?Q?hECdHYidoAYp1Kuc6M1RzgkiTdEKnqad7Fh/XRHjVARNuvv86IWswd1mZCzH?=
 =?us-ascii?Q?jNrau2w+zYJv6fah4dEfQ2aN/253wnp549cPCjNdFdpfOOw6PXec7U0lh+ZM?=
 =?us-ascii?Q?gyb2BUd1TGLz9lPIpUjCtts3msuuY+5Ygqz2TB46BOiBjuvflbTWGbix12t9?=
 =?us-ascii?Q?PrCeE8I/V0cSSPxVo+dibRyPYDxiNAat0mGkArGukn2CBexgHhgoxYR9XRBq?=
 =?us-ascii?Q?n130Iw09fMfwXnFzgdaFkkf4tgujziKpvmNDz3ePm3YRuAWmjkjmQixFKLkZ?=
 =?us-ascii?Q?v2c0GdPWm2z6KudDNqD2Ks15x1NG0hcWrkhBNBdMxg3vKaU9QVkhBXYpsYQV?=
 =?us-ascii?Q?eDM0KvNdmnH5fzIqVW7iTi2FUODs1RW1Me+NGvZzG3kz98LDoAvruhDtyCwe?=
 =?us-ascii?Q?hQGNyR49VDBQowIFKkHV0iOVmvb5WnPNlcezq1otUZETkKg4DXW9ppI7kBPP?=
 =?us-ascii?Q?+Hzml0LJN6p8NBFmubr8c4LjH1cRbcl2fKfum792+u0zJC59jZMMUJ+33s8P?=
 =?us-ascii?Q?nAlvE57nNFNEYykXV3hYKTqPaHKxIQvPitKhofzH8HBmkL4tB4ZGfbiqXb6j?=
 =?us-ascii?Q?hke9UbKwbSGuX0eAU2Flbsse3mG+omI61X28pCCm2oztxdQt6n/uNuBnxpgr?=
 =?us-ascii?Q?arHO/KoOf9LclChG/caf4HVeD3GvsXl+pFcWlI8kfF0B+oIqhtqaA7Mu1n3C?=
 =?us-ascii?Q?RR5MpeFnETqrhSSVyWvhbyKbAtRNNmMED5oP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0LIa5uIKN4ryUBD+Kp+4+uoWeIwP0sI7leNlXEHdoyrAZUKusHztq77MKfKE?=
 =?us-ascii?Q?hJM8vMoikjR42iwnWXc6IpxFySC+S2eFhkNR2SzUHB4HWVcgtLPDNEMR0lAG?=
 =?us-ascii?Q?Or0qpqKgRc3dqMOBCJjlO6FSKqr3fAFhu7KCeyxePfEK+Fw7LrxeS3ouzSK1?=
 =?us-ascii?Q?QRWx1l9z41/KKZhbYSDZDKkGaxk/hcoZwC8EoLTNItsCAQEIgEt9FQpYYuNM?=
 =?us-ascii?Q?9uUsDuY8mP1Za4mXmtuZFqPd7+qOknFdtS/Xb5sl6EyMm0KxnGq4ItrqCNbx?=
 =?us-ascii?Q?+cu+VhZ0KCx+m5kwZQbdQE2IEwFLsXIAIQunThQ08vFlGkQuWk9fRMVynO27?=
 =?us-ascii?Q?SlI4GkFKD+j33BCZQAxgsS1kQvSsyB3N4G9AG0+lbVTgGS8El8fiEUaDf9xQ?=
 =?us-ascii?Q?DzUC91nhDBlFvJsrIDjr266h6cmUtHfZYLE8PEBrdvd/sIyaqZ1flhMlwi2+?=
 =?us-ascii?Q?5fUEUH0owSsHCS2TtXzsCLa+yYqcnEXt/9T9atqbkdgFsloFTuG8uevOeDxW?=
 =?us-ascii?Q?OywlRLh/algC6KWXkswsZiJ4dJXkG7JgIt/LbkteQmaitzeRk67QI8IwkNRC?=
 =?us-ascii?Q?FKB97TWQ5We9ZmU6Gu0BO/SjvyPpBNwirX2TUbwcRwC7gYKIUPb1f37baxEG?=
 =?us-ascii?Q?LC3jq+NI+ShLn7pteFeL7VzkCvPH83ezeUxsl1XM+xIA2LEb8QGC7YA22Y2M?=
 =?us-ascii?Q?DJSme7wBknwcCXIfHeTpOjNgn52lEmWujrVcSPemGNnataIfph4DD+9tP8Gv?=
 =?us-ascii?Q?Ud49aXqqQy587DpJRkc5LeTDpzjyzisapoxqV2xseBFRtix8j3HpBB02Uc13?=
 =?us-ascii?Q?tUcTdYqEwqofDfnqq6z5RiiHs6eYTELz4EIay5XW4slAgS3yPhLii/HPIyc9?=
 =?us-ascii?Q?PZQ1yieBmTCSz0thLUpQ4xvMqw+wdpiGT8Mg0ZVqCzgY6U2mLmG/kVE2NNQw?=
 =?us-ascii?Q?SmOkNhD/F0FPO8Ce/xBnk1jEj6UauRfzbXvJhzGppEFYRqkuybKJfjtCzbpT?=
 =?us-ascii?Q?8XHRA5Si8tq5GoKoLX07J2oLSrpX/RbibNqxFUhUtSLaV4NXMU0xw6qWhyXS?=
 =?us-ascii?Q?TI1bx/o8r2lo/kIcjpJQKds+n+LLV7v3AAmf+PL3p5x8W4y9hWfeaXl1/cgA?=
 =?us-ascii?Q?3EZbxebl91tWZQrgZoeWofzPTjZb55X7QYZKP+siYQ/lvVLLXK2Gb9fkFtC/?=
 =?us-ascii?Q?PsOB4f0uTgDPCvRKZ/d5BUlJhmt0EIj6Z8+5CSaeyIsgIcav9q1GKgXHfDwQ?=
 =?us-ascii?Q?MNWVVTrl9EY9a2gGkRlaEcztw7bnFyweMxZyjgdhFUYL1uZqioaSnj5aCBwO?=
 =?us-ascii?Q?kOJhVJw6WISOeJinc0hDLj8jB320hI060kBsWmJzalY0dLmlkDfrI139ad8/?=
 =?us-ascii?Q?PVZnncFgGHLlbqnVCWPH5w9z0Dss8h/kHjSOBNNZC1zJoqBIous4EAdQ3oHt?=
 =?us-ascii?Q?rM0apMgTDCfWVRkeGnLymCYVaNhyXVS7mGbOII5JXNUuwRAQ2Q0bJVrXxRJ1?=
 =?us-ascii?Q?MQK3DnHlpZ2fUjlz/W2i3x1icN1oqAGpa3fpNJpSPd44erc9kuhy3DHbv4mV?=
 =?us-ascii?Q?VjuM3JF7A/r6YJVXAfg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56b24c0-8b6e-4401-f6d7-08ddffff7780
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:58:04.2669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRmrTVzXDZLCt4xBqoAmnBaw9XE7jtpwDyn7O9N6bDetnkyF1BD2dPKpOnVoLlRA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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

[Public]

The patches 1-4 introduce userq VA tracking, and patches 5-6 add userq VA v=
alidation.
Together, patches 1-6 provide full userq VA validation support. If there ar=
e no objections,
I'll push the full series today to complete the implementation.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang,=
 Prike
> Sent: Tuesday, September 30, 2025 4:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH v5 4/8] drm/amdgpu: keeping waiting userq fence infin=
itely
>
> [Public]
>
> Hi Alex,
>
> Apologies for overlooking your earlier review comments. I just see patche=
s 1-4 have
> already been reviewed. Can we proceed to land the series (patches 1-6) in=
 drm-
> next?
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Monday, September 29, 2025 4:10 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > Subject: [PATCH v5 4/8] drm/amdgpu: keeping waiting userq fence
> > infinitely
> >
> > Keeping waiting the userq fence infinitely until hang detection, and
> > then suspend the hang queue and set the fence error.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index a82b8d30228d..93d92b6ea86c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -232,7 +232,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr
> > *uq_mgr,
> >       return r;
> >  }
> >
> > -static void
> > +static int
> >  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
> >                                struct amdgpu_usermode_queue *queue)  {
> > @@ -
> > 240,11 +240,16 @@ amdgpu_userq_wait_for_last_fence(struct
> > amdgpu_userq_mgr *uq_mgr,
> >       int ret;
> >
> >       if (f && !dma_fence_is_signaled(f)) {
> > -             ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
100));
> > -             if (ret <=3D 0)
> > +             ret =3D dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIME=
OUT);
> > +             if (ret <=3D 0) {
> >                       drm_file_err(uq_mgr->file, "Timed out waiting
> > for fence=3D%llu:%llu\n",
> >                                    f->context, f->seqno);
> > +                     queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > +                     return -ETIME;
> > +             }
> >       }
> > +
> > +     return ret;
> >  }
> >
> >  static void
> > --
> > 2.34.1

