Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA9FC36010
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 01:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F013710E1D4;
	Tue,  8 Apr 2025 01:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YkEWH9GZ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE10910E1D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 01:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XABj3X25QxMc7daZRYhN5s1UwyfE4+iIuDPi4oDsB7lLFML89bW5zrsQ/5Fu1MppcbIysH+K9BdCFUSyXQpa7MhnOUMJrYNy7VkzUodBzZHzULfT5iQmjx6WyoXri/Dx6LdlvphdAYGPJqsgKmIJ230fogJHKBqterrmVx4ol58DEX8/sWiiDzjRUkabVyQyOlisrUXFB2eJa1Zgj9ZO4Rw+JLncH721gvsr6sr954ejrFyPcdaKkVmVOOxel+DnOgeNRkpnqCKB2iCe5Uh33wPRUfdJlK3Jud0VvYrEzIRSB5fO/fzjktESnF3NutJE98OpCqWx50tUALqZ+82+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv2hP370Gof5qM2mmNhL/cUkYHXr19KA6QxOvsjj+rE=;
 b=Ov8yUMWsIOJP9htW8ZEeja9+UlkfBSWQmHilGBwafCCSXsxTK2KTCqyloWtJOmwz2Tra5vUB7Q6JOFe3Lj0NbHPFLrgJbyeCYqm7lbAEH3qYtplFyL4bvc5jPjzkrHA7IEYyQB3I9DZ2OJpHAewGCOCUOoB044NW1lfeFy3Irz/2QRAIlPor4uKsSUvyQHzVc2Ce9zg/VdrAOemv+1CQvAWodaJixUn+zeb0dKltabu/tCitbqlVcBxBdiDQllZlw6E8/HtROTQK6eKTJL1uchWjUX/SUAKDFiczITChDW1F+bjdUagtrgSVcfxjlqqFuJfFbkdGvkcnamswE8xWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv2hP370Gof5qM2mmNhL/cUkYHXr19KA6QxOvsjj+rE=;
 b=YkEWH9GZHB+EkOqTHDI+mx50sTHee/bYat1eS2VQMh1cnoUnset6Kf8C/vQTRB2uLS1l9uabx18bzbOJsxxlO72V/z3IKhZj9sS1/OUc5vTC/83rGeE1jpXBr/YkAeV0z/ri/my4D9RanS8OnJvzoZvTJUgwej8huLm5GMNxMJc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 01:53:38 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 01:53:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v1] drm/amdgpu: no need to set queue_active in
 mes_userq_resume
Thread-Topic: [PATCH v1] drm/amdgpu: no need to set queue_active in
 mes_userq_resume
Thread-Index: AQHbp4InCD1K9ALMF0a27VBSz8g/27OZAjKA
Date: Tue, 8 Apr 2025 01:53:37 +0000
Message-ID: <DS7PR12MB6005D6D1B970ADED76027711FBB52@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250402121636.1689678-1-sunil.khatri@amd.com>
 <bb9f822d-722c-45f1-8432-d21c129c8a8f@amd.com>
In-Reply-To: <bb9f822d-722c-45f1-8432-d21c129c8a8f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc912af8-8a01-4fc9-9df0-cdeb9a713258;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-08T01:50:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB8727:EE_
x-ms-office365-filtering-correlation-id: 512d41ad-2852-4893-4ae4-08dd76402e20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BlC3Q246cuMUUE7Ggoz4ncIZZgcdACwQbvs/3HTIaHUCwOLNiUJ8DNoWhnXG?=
 =?us-ascii?Q?iAWO1jdSAQ8XQ1W8NZELUPDzcg8yc83nwkhhI3X24VJAKIYHGct2qzaxf1ab?=
 =?us-ascii?Q?I82CfDnWxZZ0ERVFhSt+YQ/VGvmnn1fTd978CvF4xhMCG4rGfsKoCDu70o9U?=
 =?us-ascii?Q?WCaNujznc6QfGWDjTLJ2pN49hbWhnFYC81IMtAzkU9/VaYWEbs7sw2DCJDIp?=
 =?us-ascii?Q?hy9eB35kEn5ztQx/fioqdUECJCOQkJ3JhY/uRvKJnOHIDVdhEp6uAod6L/Jj?=
 =?us-ascii?Q?Ecem0LH3wEI/jNNXXOvDuhaZERS3lYFKyCHAhwwE5kbsqNfqv6ibyPbCPtZn?=
 =?us-ascii?Q?AfnymrM0fft9zLn3yLwacqAhTTHfdvrIsZNPYi81OSEjpP4CKwhZwE9VhDWv?=
 =?us-ascii?Q?V5Sx6VJ9NU7EY0AiDu/h7EX9i8nrR+zJLi360oM6AOUMjojjEoMvB5StIjI2?=
 =?us-ascii?Q?udjDyIH+ZyFBB04DfP7EaE08reJmz3ulleCb8AavJ3MyxPZ5XVxzajF8H29R?=
 =?us-ascii?Q?5fEV/FhFbH5PhCBSSJx8OHeh2/woB5vS7jzWorwUdr0TV2KqTAYmJNMlh5Va?=
 =?us-ascii?Q?6YhX29pbnr36TXNlOeBxIkjy90ytoDiTYqRj7d4iOE6ntBe1pHImRlFj5Y9m?=
 =?us-ascii?Q?AB4uuK6UIFzP6urKzgngA8IhoeL27kD2cJfaIP7gn7GtL0bXxdfnidelbGQX?=
 =?us-ascii?Q?A0DJs/5AiR149LlJArI+YeG6JDQZBIcYmOYd8Ggz5o2Q99WyZAl1QdgrZU/g?=
 =?us-ascii?Q?0Gy9SpxwBar8qsR4GocC6yAZR/j1+Pnnz+EcG/YziGOFhw1jq48UeYJs/g5Z?=
 =?us-ascii?Q?19x4jzHR+k5cFj249rgKQunu7TkOySP9QlTVTWuSFf2jFalMTU5KEy1ChbJg?=
 =?us-ascii?Q?GICOH3nxZ+SxEqrnA+FSZC2brqXnjGMXtDug7pVvfqlQEFjv0SyN6WoHZpyh?=
 =?us-ascii?Q?YkgGsqmuE07nL+JAdS4a/AncP888SgJVM+qPHo3ntchHOdZRgN9LEMDhD2SN?=
 =?us-ascii?Q?CDVXuyd+p+BeK6QZtCh1OXc0HJ4FhPUoKMl6JzsuTa/3SP/2m/U/wmxXnwwU?=
 =?us-ascii?Q?BEXQn+CnFr4c2ZuhQhGEkvF970oN/b6lLQlr3hNPy3Y0u141cHAiHyNnD7ke?=
 =?us-ascii?Q?MS/BHrsPjZRO2Kuc7+CBLnyiQl+R3AuNFrmvNCZpoJsAOm3jOw2OCU/nRHOz?=
 =?us-ascii?Q?89CQiqhWeNT+KSJhZ/SJw5x3IUOi+i/qZqBN+T+duujv80kyWlUFayu+E8UE?=
 =?us-ascii?Q?ysj9oCYnFiBkm5PCY4WLkNmySygax8eVXRJ0GiAuTIBZBMNQee1ewkYLPfuw?=
 =?us-ascii?Q?7NgyRo2y5chlkxHl83CzRkliHWqTyqZ9saYXUBzLbcgHTrKzD8lPWMFfN2OD?=
 =?us-ascii?Q?CQKoUj9MWXltNyGrnpX8BsFXpTPdJG7CsMiXrfe53xN5Oi8+SHdjYRIrzBNI?=
 =?us-ascii?Q?J08nzXgt//weXBJPrx82hZcTZ6JPcR2s?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nSKv49sGnM0Lp3p6QdS39uzv2HtFyd7eDhvUCokIftgaC6pTD4dCP7kiR3kt?=
 =?us-ascii?Q?em9YxRFNbOoUApYjf3pVhw9T19+qjdEyCZ3Ptip+kRnEJauQGYfzoObQenSD?=
 =?us-ascii?Q?vlLa/Z3uDQuFNtObXVweDTRlcapqnEzndUoNEYxQka311TwnRUS0+V0SGlcr?=
 =?us-ascii?Q?Zo/Ou9zMBoODD5L0jpCwf4Q7GSIDN2W30bmuTWLWQrcPBE+A33Ga+Z+04Jtd?=
 =?us-ascii?Q?tso22LI3+Hy3Y8oN2QfR0m/0vgRFxaZ0NyAbnnzCLTJUFkrbXKaKiuLmnqhJ?=
 =?us-ascii?Q?MT4R37KLo2A/l7+Q58X5DY+J2plTHoQ8AqWlRZ3dVC3kX00xGdIi1UMMsXkh?=
 =?us-ascii?Q?O+kGn3Qi531VZoBDK2Hvoat3m56Q3ed4aj8bgvVTOx9e7niXz9hW7V4H2tac?=
 =?us-ascii?Q?J0afJUdk5sU/eq9XH2Skoe4H0xt6sKnhFGalTEY46QdTvjjFB7beCPmBttpM?=
 =?us-ascii?Q?HlmfWR5wtsNHKwo8gkCGVc7oKFrCKzJ0tWH3CFVWxlZHRboiNJJWMV1dx21N?=
 =?us-ascii?Q?zF2bEcvZ1k2SmwsAY2+UniZI0v3MdGtpnxxau5phiJmYZ/puASMxcA9GSsHC?=
 =?us-ascii?Q?1NCcyq6SlHb82Bf4NDBVY9f5eOmFkdnsASEFgFQ8Vtapuva6KmE8bmyDkD9T?=
 =?us-ascii?Q?eq4sQmOonb4k3LjoooquVscALLFKH+7J0M1cF+AVORb07Ok0d15a20qhJeM2?=
 =?us-ascii?Q?OrljUeJFu+uIK1eYx1k4ahnzhWgUAAoPqwNfKGnnN7XJhPvNgR8BBHQubtLH?=
 =?us-ascii?Q?7qFZaoGt2PJW5je8qLQ+GZmp+2YZG5Co+a5pAw28h/UAnQpQZTcVUnNEA1Hj?=
 =?us-ascii?Q?gdXnxdf3VyhM4o7MZk+hQBNClfEouVBPxHN+e99KbkqDqBnmbFelV1s3AZK1?=
 =?us-ascii?Q?yKRnOMhuNMhNV/5gjk6qNcY1BxTg6xnrqIydMA7ep0RO9olyUDAmZdZSUosb?=
 =?us-ascii?Q?+pRTuO3QhjeU7C+TIb0mtLVpVBsjJOBosSvKgiyOOvmC6tTupK78Y/mADy3M?=
 =?us-ascii?Q?WUgg5FxCVjgw9MMdAh8ZuOyhPuX0AEAvzicqUBnh0od0qr7j/U8Rp54JhSOt?=
 =?us-ascii?Q?DZUiq4Fe/YwvbUSX5Pd2h7nA+yQdMbfdLvoyq+U7V8o6y07Sm4tQQsMIS70l?=
 =?us-ascii?Q?ifAneVZHpcO8kXOvFNtgGY/M4V2PGhiv20Z+OaJtFpeozpDub7aLrsjO+PPS?=
 =?us-ascii?Q?BKbiFq/AoFHhQJ6dCao25VgDGSmZz5u0gu48UhSmrxSUqbKZzyEZjM6I9OdY?=
 =?us-ascii?Q?xiDdbXjMRajBlvTqQbnNbYyW8X3Ja3jdmu6SLd4bCYv8h4+PJ7Jwkq1q645Y?=
 =?us-ascii?Q?LmmBII8ucqpf6Nbs0ei6oWCnqshnutCI9zJcmbuem0AqCZDOem4oAqKzxSsl?=
 =?us-ascii?Q?9CrgUsY1BYINw/DLHbL3FquvSgAVTL98Zs56TlTXB8bxHYRab9hFcgvNz712?=
 =?us-ascii?Q?z1QOe0h20yXw3T7qQd2Y8UQyveeFARfMcz2RjmtGQUMsTfECvF5PuiOfhHey?=
 =?us-ascii?Q?s206SW6YUIljdcuEONI6Ltb+70l0M5+NHbLTdP9+AYrf73okCLb84ygodNPo?=
 =?us-ascii?Q?GB5XRpokxFOIXZINyt0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512d41ad-2852-4893-4ae4-08dd76402e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 01:53:38.0035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3p7YKE5vA8nRscP5pMUNOGQaly3dd7BOrQbyqB2qsksa3l8FwrJSvSquD9FFRh6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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

I had a similar patch before, the mes_userq_mqd_destroy() also need to clea=
n up the duplicated queue active bit setting.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Khatri=
,
> Sunil
> Sent: Monday, April 7, 2025 1:59 PM
> To: Khatri, Sunil <Sunil.Khatri@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: [PATCH v1] drm/amdgpu: no need to set queue_active in
> mes_userq_resume
>
> Ping
>
> On 4/2/2025 5:46 PM, Sunil Khatri wrote:
> > In mes_userq_resume calls mes_userq_map which set the queue_active
> > state to true if it succeed and from the resume we dont need to
> > explicitly set the queue state.
> >
> > Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > index 8f6c12a78f3a..c596e534efbf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > @@ -382,7 +382,6 @@ static int mes_userq_resume(struct
> amdgpu_userq_mgr *uq_mgr,
> >             return ret;
> >     }
> >
> > -   queue->queue_active =3D true;
> >     return 0;
> >   }
> >
