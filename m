Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE855C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 13:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C27210E69F;
	Tue,  6 May 2025 13:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZaYEhNAk";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D2310E6A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 13:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhEhewgdCzUr8VWAY9jpfnPhRidw4BCscOhi/11MZH8Z2xVrYx4VFnorMZKp6074EnUto7U8htkZk9RvlZvqnHn3/gZABwsYCIGOiayccCSWvxaq5zD31Yq4pwkL/i9thydssnAGAoaAeO3SpAfKuPf+HLymFGuo9HBPP7dcobxj/zNxpVwibhUkftRAVcZYP+2rFGxAQ9yB/UK7crL885THzbbr59CY8KpScM4bLAe4rW/dKQ1PgNQE7mBkJwqMZGy0nU6amwCuT5NkZY1oZDvGe6ArqmtQlCq5EQCcCfMHpkqG7fs+Y8efF3MbePtChCzX2aoz+gYkI2z7XVZE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2uTVeoy1qRpah2OwrPbyhi8L3eprZ3Hx9g+fIZIygY=;
 b=MgLNRv3QFpf6wmtwajw4UnE9wznHfSkNyZIi9Q2PKILrBoSRxPdfzjljzjNmLyhl/KexI249+eK02QvvWAVoMgb9gy1zzhnEkS2+umZSk2bBzjLYpqQQtCmPbHZ2JHSD1ucpTzwCTRSIVtVca+5Jdn01bOCwyvM1JDE7dFS9+0x6ydPOvgrLDq3Wd7A5sfqGBe+1wEzgWU8lHPyJiiVFCMsyl/S7iQ6/NF+XOLYTN7IVgcM+6Tr+fd8ibiGi9uPHqKQuYrTXaf8wlV4tmVw1wpa6e6qD76DEubpUlZSE7AZ8REKL3Xqy7+JfOn6ILFi/G4JpJQRN6Yofa+Ne6pobUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2uTVeoy1qRpah2OwrPbyhi8L3eprZ3Hx9g+fIZIygY=;
 b=ZaYEhNAketsN3ZfVcP+cuZ7xsprSTqL0fKUtntyPHbU1ji0nho2e3bIPqYoGVTKgeaUI0f7VijNTte1nR6ysiUBJU8WcRgZe6jrmiYQbO1zSjLuFE4yR5jsH+HoMec47lNQowNKv4zLTqjoqScl0vQS+0x2QSGbwD4qrhDZKslY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 13:34:39 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 13:34:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Thread-Topic: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Thread-Index: AQHbuAbbGAa0pwMfOk2XdnXKBBngkbO7hSoQgAohxyA=
Date: Tue, 6 May 2025 13:34:39 +0000
Message-ID: <DS7PR12MB600557F4E08F81716AAD4D69FB89A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250428062853.4057900-1-Prike.Liang@amd.com>
 <20250428062853.4057900-2-Prike.Liang@amd.com>
 <DS7PR12MB6005F7AA06172FDF96E96F59FB832@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005F7AA06172FDF96E96F59FB832@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f45f172e-e7be-43e7-92e9-66937a0e8719;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-30T02:50:55Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB8933:EE_
x-ms-office365-filtering-correlation-id: 31b48f71-a380-4f3b-3acc-08dd8ca2c05c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DufCtOmytT5sVlqgI1htdI3C6OnVHK/jqrdeIgGWOo+ZhjT0mG76Z0dnXkcJ?=
 =?us-ascii?Q?hZ68osf7fQcfBD0UzIF/T2gEp9Jky4bCmjlVanzK8TVzpSQERY8waDFvruym?=
 =?us-ascii?Q?ZnHundJsSyMjP1Y+v5devP8p93Qv+rg0MKQzEK2rt41jcYFG4GNT3eKdY3x5?=
 =?us-ascii?Q?S1ifLHBjsh3JV+t5UiA9V9oz4kMvTiRgiicx3jUgWV4Da++Qlzai3fsgYLjE?=
 =?us-ascii?Q?eWmJrAD+2DjFDGkefPDqDu95KCiSW28tlvGzp/paQFkcwrLg0ZxcwE6etTQq?=
 =?us-ascii?Q?+M9sBpfo5W+4ldSz0c6Nq7P2oOt2XU3wytlbO7DaANOuLhScArH/ZzqydXxT?=
 =?us-ascii?Q?nJLbFhmumJ/p8hqvFsIsmUZWttAi/SfCOvNpryPN9wpHqo+6PH6Bc67Xmo7s?=
 =?us-ascii?Q?1YHSOWjj7n6b+7fKOagAq9kkbHK9eiV45OquYDhdYisJlFfSkkF+/VE9IsKx?=
 =?us-ascii?Q?U9I32xmiqCrml/h5zCJ3XO/eTKQT9QTqWoLNgbmfM+jbrYGr/vNZETYpt/3O?=
 =?us-ascii?Q?58/lb9YpschzhKwu4ol4DMtMYb+bnyxnjeaqSVQNC7duhIE0IOTJIJwr6M5B?=
 =?us-ascii?Q?n36lhfl1LxqxJ8c7AcP/5Ipnhp9hNmj0Y+OtffGgvPAFKSWM5U7/+wQujdrL?=
 =?us-ascii?Q?KbMaJhXvQff4e+bpOgxhoqB96WJ7sruCgC08HhUFbnGyPsV1StNDmxZYWMqb?=
 =?us-ascii?Q?TDiUSQ++rzJpEaNEJaBviT+Sago2aNdnw/1JQKD61OqaYg2h1/VB8LE/TXcw?=
 =?us-ascii?Q?98DX8XWnP6+kiWKQuzqRIFqgUemfhW9NJcTGBaV9Np48EOGhN8RtmMyUTF0w?=
 =?us-ascii?Q?Zrw6AIoiEm3md3lNXSYmkO6JUzs8uXFZ44vCMYo1PYIBA+2GAIjHRqZ9jfTe?=
 =?us-ascii?Q?dFHSb1UIXGvRX9AKLSfMIMV3+wFXiROrlggiUl2u1hFV6Gwywaj40/GqehhH?=
 =?us-ascii?Q?tJx7gqJCi6s6WyuwT5pfcpjZ+UuBGbELQ0jXXnqq/wfzGBXXwx3CpfDM4X1k?=
 =?us-ascii?Q?xNRzIr9ehnplb2AmBZhe9coFBIl5Tcm1kr6Ha+Ncycq9UuaTzRi+oX3XUMdL?=
 =?us-ascii?Q?pYb0b4YAwY70PwK8E13/TSAKQOLj2QP82nLM1xVzEqRvpDc43V+k+7lq1+Ig?=
 =?us-ascii?Q?bx8sf8fzHsb+CJOxtefrR3o4JnM3/Q4d45Bx+cup8FUiElVPLMqqYA9e2fbJ?=
 =?us-ascii?Q?QkIx1tLNuX5avzxMqFg6PADkaCYFklh6vtsYAOsd5tnCo1eEhF3G0mnzGfaa?=
 =?us-ascii?Q?P/T+RNcZFK4xTjiJxxFN/P264NrV0P7RiVNtCKLXLZhPmbaTTNsjdr5Os0LJ?=
 =?us-ascii?Q?b69ZTAmrqxyoPHWYNdBog/WQ3ZLIX3waIwQ98U4AEppvXEsTg/2mfnhsOXuO?=
 =?us-ascii?Q?l5XVTqBoHixgjQ98wbMRcKDkJtnQbQ7lf8ZD4CY+o+JGwNq0vM5KjwilMqtm?=
 =?us-ascii?Q?+AEaEbE8bQRqFkh+NSch1OFt8NZnjWTSEnz/kSjJZ5BFsSFZ+jzL6D+JImeP?=
 =?us-ascii?Q?xSSuBwzZyF0qxJY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ODjFfTcdn/UjobxG2P2hHqS4bOVHTuXa2u2o4mPBslh9T0RMxk/EbE1Vq/Mj?=
 =?us-ascii?Q?RphoHdvdHPZuLPIzaFq4Z9FEa2xJwYMr3NqwRVj5PJllPxuzCjk5lpPuz7CF?=
 =?us-ascii?Q?L4SW4K+oD6ZW5wjahwvIUWE8EgH2P7YkFPe2z+XkSGmJBjWn5RZkjsalCdJm?=
 =?us-ascii?Q?4RxsxqOPlwbr7NIMvA+jRnzUT1ar1MWmrWJueNYIpcKTBYaIFPLIV/ULDXg1?=
 =?us-ascii?Q?U2h1fYZY6rTImyMT5k0W+rDVA+OpL0PlQqmNU7SNDFZ32AyskKEk+6iZ1ZNj?=
 =?us-ascii?Q?6bv2XYnsGRrXNDsqbznpoPQhyDVeWP5t3YsNLFlXnO0cS5E2uZhi5b0rMygx?=
 =?us-ascii?Q?aM66QaE0ogjPkVGdmu0Z/xXqTQpQ/5DNYhvXlSXxsZsIz2yAQtKrcP7WMcK3?=
 =?us-ascii?Q?0QjciOcJ5p2S5jcXsBJ3vjyuF99ehbabxrw1Cok2+eO+gdpqYON0zTl4JSQR?=
 =?us-ascii?Q?k3Sm1V07bI/4vlfsI/CwnRpyQnjA7nelRL348znc3ec53bG/lRJMfs9VAxCw?=
 =?us-ascii?Q?4jnuyS2w3VaCzDKqW0g2PCGqZntzn39pu3RBR06lPeUHNAcgTbsz21tMFm0X?=
 =?us-ascii?Q?GVivhGPMt99VRGA5DoHNyoHmdTj6qxs11IjDscW4Xdad9zLRa2owEUyzkK8u?=
 =?us-ascii?Q?fX5y7ont99V8a6IJqGuxjAAxnoxb0Bhx0N3IPBF3wKvV29oOPNhjbsDjDC6M?=
 =?us-ascii?Q?Vupb2t5mxb+2D9W22rLdtyX2w7uJZ5Fn+VzNOj1dvoObFMuQB63L/zo87Zgu?=
 =?us-ascii?Q?AkqNi/KDH6Co4Psa5gpDmDQL2VkvovU9U6Cf3aiT7vtRST99bKaoXb6rgK/y?=
 =?us-ascii?Q?pcw1N5EYYFC7T33wuf+T27hqeiBUiIqruiGZdUO7KLKpjKgAD0H10VdLsIem?=
 =?us-ascii?Q?thJDnzMFwhUGXYKwtw8us78Q0YSuHrfC9dCB3C3acQ0bIm+S//RxcAB2tQ38?=
 =?us-ascii?Q?ALlU3ObzdhaobbovTyBmoycn5cU3Ogof8nGrwC26ttA5+HyjQ+NCy7KWIxms?=
 =?us-ascii?Q?Ftc/kQRyBGKAhuJlN8JPMwfC0dr10v15rl7KzoIvFzEOQtrW0WC2e6n+J2wf?=
 =?us-ascii?Q?hfCNW0uRdODH1OIe7+sG2WW9gPcHTOsYIiM7RTUUCJKfD/ykn453srqr8rZZ?=
 =?us-ascii?Q?Usd16EzYzJqj2IdsYh77Xkl9sXO3O69pbBTkjCXIN/t4RIWjjxtPGD9ZmjXB?=
 =?us-ascii?Q?t7twSLSRFnBM4xhLgrTjJENkB1m4ttZxuZl3+eK9TSHvX8l21Kgtvmovq619?=
 =?us-ascii?Q?N2rBfrT4y5yDPhn+q0tlEyS533oXgcug/ifKuDnn3w59aoBuQCxcPHrzxsoV?=
 =?us-ascii?Q?t9LdQ12O6hwRmBiV4y9wCDw0DNui3tFJiXPy/GYTCRoPymOeo+74uSb4CJhy?=
 =?us-ascii?Q?EExRWCa1drvRb7kataGxjB4YDtCFeuUsZNYAljoquawuJ6T8Milv1XkOBPv9?=
 =?us-ascii?Q?Dv7B+nRlNIbIHl1Fbl2+AVvEhTgI6BH08xpwnpCYaYwogfPsf149hS9cVDYC?=
 =?us-ascii?Q?aY0zKAUykLjTc3LV0/oTL8aYG9hWz0PZAvbN3lodajiPeKg2rvWtsCQ2Oq6A?=
 =?us-ascii?Q?cqbkVwOC5wOntuNM+ac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b48f71-a380-4f3b-3acc-08dd8ca2c05c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 13:34:39.6160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QD7hKtWQt2a2P+nVSa+taJpzXlZZ921nsf9e7gMRSIr7MgDIsCSbbyTfchAIDC7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
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

Any feedback?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike
> Sent: Wednesday, April 30, 2025 10:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mappin=
g
>
> Soft ping for this series.
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Monday, April 28, 2025 2:29 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > Subject: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
> >
> > This patch will log the user queue buffer PRT mapping, and this will
> > help on checking the user queue PRT functional status.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > index 30022123b0bf..7992a97f8745 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > @@ -903,6 +903,10 @@ int amdgpu_vm_ptes_update(struct
> > amdgpu_vm_update_params *params,
> >                                                 upd_flags,
> >                                                 vm->task_info ? vm->tas=
k_info-
> > >tgid : 0,
> >                                                 vm->immediate.fence_con=
text);
> > +                   if (upd_flags | AMDGPU_PTE_PRT_FLAG(adev)) {
> > +                           if (params->vm->is_userq_context)
> > +                                   dev_dbg_ratelimited(adev->dev, "The=
 kgd
> > user queue PRT map is functional\n");
> > +                   }
> >                     amdgpu_vm_pte_update_flags(params,
> > to_amdgpu_bo_vm(pt),
> >                                                cursor.level, pe_start, =
dst,
> >                                                nptes, incr, upd_flags);
> > --
> > 2.34.1

