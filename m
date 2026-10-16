Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3EECCA463
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 03:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B26410E28C;
	Fri, 16 Oct 2026 03:19:36 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B17510E28C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 03:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n53IkrdesqQ5STtOztncaypLcKH0zHh3Yx6uVhCQReOfVXaQskRQr4D2LqMrn+o330mt5Igauu9VAPqwyX77H0OLJx5L5h2rOEaufgIcqYcF4wEtLZ08y3grFSHbmfQdMJMIwd7QuaJtQksEtP5UKBdLdVIYSr3UWBTGjkPPF6mcqwIM2izUf6VqoHfx8+E3OqVyyibB5l1fr3CkVKCHQnt3U+GouRKG47oaI6giNpNoQa3+uixWf0nuiR3Shgv1Omvk3rLGYEHyPIVu3GRKUADtS0b6saYThB8cNVpEFhoZyjAJgI3p1ykz0Ra3QMH9BlIEdhYHwS/mZ+VrlmNlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhliL58CeojeS1ZZzc4JOieyz2/sghI7eN3Qv2VclNE=;
 b=ocpdPpSxdEBDv1WFpSHHm68zsDGlgtwCsIcol50hQPk4jftf1iPiPhCgDvBM22PiPybtm0mzT6U5LN82g4CSQ2G76BUuo5NoQf95hgN/D1l2sgTeGDBN2fgI2fQyJl353X+jr5bfHl+Iz8oEhsQc8DjIU2kiZpg2sId/AEWTAUSe+YSXa8l7Q0NbMIfpY58f3Y7hVSh0j5eAwk6ltPO/VmQ6IC9gD2usDyUifXuF8zmdCurAD8Ao+Uhs2qTFBOO+YRBTkkDhXoFwgr+OXuaqVQSQz+WQq56ZwBNM2QAX1bBTp012AHg6cWLv5DGr51zXPi3o0wzeLkgjohQp3Pg34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhliL58CeojeS1ZZzc4JOieyz2/sghI7eN3Qv2VclNE=;
 b=aT4uOYUNxZ/WxIRCZnwkx3pUhbZeAeaVHn8ESyDmswaC/FDC4ibOtd6NkH9r1nMNxY5zOp7NF5QxS4LDpE8a0i3/vxqSMQJDG7/sN7RwIYr2qVezrv63Uo2inA2oS5Dd2Pk8f57Q3oN5vYOhGbjorTtm3CbrPbyx93uWMqN3JKs=
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SAAPR12MB662741.namprd12.prod.outlook.com (2603:10b6:802:303::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 03:19:27 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 03:19:27 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at queue
 creation
Thread-Topic: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at queue
 creation
Thread-Index: AQHdXMziKoCLPuZCWkqYsd6O3DTN2bb/euqAgAAEswCAAAC5Eg==
Date: Fri, 16 Oct 2026 03:19:27 +0000
Message-ID: <PH7PR12MB7794D419AE3B29C6E2107D59939B2@PH7PR12MB7794.namprd12.prod.outlook.com>
References: <20261015174444.948651-1-sunil.khatri@amd.com>
 <99bfd8d4-8839-44f4-996e-8f903af60abf@amd.com>
 <BL1PR12MB51441FFECBA6F0211FDF6D51E39B2@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51441FFECBA6F0211FDF6D51E39B2@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-16T03:11:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7794:EE_|SAAPR12MB662741:EE_
x-ms-office365-filtering-correlation-id: 1b2efaa8-bbac-400b-473d-08df2b34493c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|8096899003|6133799003|13003099007;
x-microsoft-antispam-message-info: T6lDPI5LJPerb4A5vOphcl/k5tM4cBSYfTY5s9idl3aAaAks6wlimDAAatLMg+fLOfMYQcr/ESVEhxpZh4gGRaSUoj2d2uqJxttHy7Sl2KlN7yCYg1+s+J4rRSNyPUPM4t5Jyf+/K3fFkF84acIuutSTl+LJg0Bd29MAbjQICYk3U6csYpUmfAE21pna/lDJr/Mhp2et3UQRyQ/hm71h+SyVPHkpVGGbSFTo4NWkgnBPbMX3Rzah1UmKjQDFPZXJCYCAy0ElAyEL3UgWJXurO5xYJOh940i9KHDvbxiEeyj1OcVyCN0Dz5WXM/9gsDrjc40VPdsFRsG5tSW06w447XfE3Ic+OFPDCZDQbmI8JxBa5fE8Wbo1YyzynvK4/+z9rB/O71BSs0b9peRVSSc70X68U8TazpChUdxzLgKPixjYs1YAoJ/vb5BLE1kAJ1ZzjULjGWlaY4vhpdFjQGtiDdlp0pvCubrNW6HfivZFj0kI/nCs39QXV9vumIJY4dwpVo5/X6i0Py5VwGMXYFSJ3rFScEkUsqJeHbMjO9FlTA1krcKB9MwxOvO77v1OVi2l0GWblcHD8KsiqUfEfYdnk5aUaU/C4HCPnqQM1hcMZBEljjYEEu0YlOIG7MWvMFoTaBENVtwCVehjwlCMp86GadBZ6lswftIQIAIpSCh82lE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(8096899003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ZuP62mhdmuSRLCZwIP4CO+6qKGNy++Rt+IQx1Lsggj17OBDG8nj+d10YLZv?=
 =?us-ascii?Q?ePyeonIewfGenkglCrpYhK9VcPb1OiifMwf8N3PvTwMhLS1kx7uRcY5d0wYK?=
 =?us-ascii?Q?9t4810A/5qLfGLhbj6PxBFgjOpNlKeGYidD+VudY0tzXoKHI7VAlWPqNZrML?=
 =?us-ascii?Q?CglE4GBOnhbhZSBeL5hOSo2KoLpvB+CRBUWr5SzOJd1UZxvF8i/FnHNQBflI?=
 =?us-ascii?Q?G+/QFI118rIv3zngS7eoLFw95eYX+2oCroDGtN4e0SQ9o33R2cCpsWZXoutq?=
 =?us-ascii?Q?XnhiTv09APOnObZHv7vw606DL2ObkLjF2sJegXV6NRZILohrAtvFSA+v6neW?=
 =?us-ascii?Q?Kd5M98ZXfhvXPAkePdrwV2ABIxLw08BQQyXXHHqWN5zw0pmhEehIbPOtWn/W?=
 =?us-ascii?Q?FzLVO5bmtOcPdnsnN3Ni5SoK5FiX5G/d6q7vxJQxF50c47ChmvnRH3QIRAPu?=
 =?us-ascii?Q?6KNQlVkYvXzc0IrZ/l//2B2kyGn6rmZ3SIox59l4JO0tDNzkQzamGExv8v79?=
 =?us-ascii?Q?03+1sua8xkVHmgjeR/41C7qBivvCnpXqv4nMqUfT/rCRvsNrBWkehSv9x2gf?=
 =?us-ascii?Q?6qiyr8RizZQ87pE/Ns7ohUicU5mPXMCS0qgXgU1HVJ7054eHcsV2riLGIplT?=
 =?us-ascii?Q?3bYCxKh/FsIlMe+lT9oaAG6jE70EEENfE0iXNAKcuBVoQXC6PVqMQ+dLRJGb?=
 =?us-ascii?Q?NsK2qjH3bigotN6MiRitC8x+JfFctavGjG3+9cXRoS78xCQ8gNNQxD8obFH6?=
 =?us-ascii?Q?PWT8NJxwg9otVwln0Vc9ruoQWrKepC2+2CZukti9kcmKG7cE3/vFla3Q6Dp8?=
 =?us-ascii?Q?pCEI8UK0gYnWd0Xr4pi0GDYuX0BMMiwZiDW4OSEg7DlKxmJskWwomJxscDSq?=
 =?us-ascii?Q?3Y/KC+4x2aEIH8ZKzDEkc4gnpbZyBBHm/a7rgcGGb5pwD3ngDOWa13RDJ4Qm?=
 =?us-ascii?Q?4BGJu06fheu/EKaLP/wmbWEVYLJG/xvuaOgI2yP+kA8SHdNH2jnlDHEgZjcQ?=
 =?us-ascii?Q?18x2k3Zfsu27EZUM4wA4SMmbAxf9ct1kBXAWGjFC0OSE5xtyIgoyWuhogwnt?=
 =?us-ascii?Q?vf6PT8WL3MtriNsooA2T0y+rU1MMcbY1Ofv0tJTjLpCZbnSPEm9itlriMm1/?=
 =?us-ascii?Q?w42bmWE1064nV+L+VyW4XyDzrHArJDoNA4ekEpZdszdrxKLZwggp+p2x2j0U?=
 =?us-ascii?Q?C3jeUliCtFSNqU7PKPJcjOjmrtnKzfEN5zmC14nFj9pd3ZLIWw7NF8+TUENU?=
 =?us-ascii?Q?LLKbO9SbuNg3vt7XGllmrekj4Ti9OWuAZKzOHBMGN75Fzo/BYf9MX3obTvat?=
 =?us-ascii?Q?g7AErOiQx0QnwuEnnzwKQe2WFI1GF4syX1G0FkEToVWQoVUYAcDDVafdPzPL?=
 =?us-ascii?Q?TcnZ5ieGnF2e7N9DRgpgbRt0XxnD/y30JLbh1BzeVRrtQwcMB9c85R7qDYq1?=
 =?us-ascii?Q?dZXHLxnFu+5EXxIKipzRh1k49DSwt4fYpjRoN2KMmLGvVJR9Vwc+Dr5I9ebz?=
 =?us-ascii?Q?TC5Tjj9XLE+xvIs30aXTHjbZDzMDgX6etYoQeIYiA9zl1mamyLIx0agdAPi7?=
 =?us-ascii?Q?wG39b+OHLo1NOv3cXqLkxqhmOYK+wvykDJmOIxXa+UCpCQgpnXKOQndiUpH6?=
 =?us-ascii?Q?BG9B91u6GnE+x0KibbF9AKuXrD7IZXvIYB/mOmzzkrGMXSHzQ7V2Ak08ikz7?=
 =?us-ascii?Q?7WVwOjh8txKbbBqmyHs+NOwS/iP4QD2xVdb+dOqUtZc0v0EkRefiZ07FGfIc?=
 =?us-ascii?Q?KHIu1kNDuA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB7794D419AE3B29C6E2107D59939B2PH7PR12MB7794namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2efaa8-bbac-400b-473d-08df2b34493c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 03:19:27.6458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WScVCX9WS95egq7QlSyEw7KX5FqyjlarrSR+ffyLiaqzqczQeTJ3gyEb9yEcIogW9HZoW9fl3KXhBWBixHCHpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAAPR12MB662741
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

--_000_PH7PR12MB7794D419AE3B29C6E2107D59939B2PH7PR12MB7794namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Yes, I realised that and updated the patch in restore path and pushed it al=
ready.

Thanks for pointing.

Regards
Sunil khatri
________________________________
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Friday, 16 October 2026 08:45:34
To: Khatri, Sunil <Sunil.Khatri@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chr=
istian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at queue =
creation

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Khatri, Sunil
> Sent: Friday, October 16, 2026 10:59 AM
> To: Khatri, Sunil <Sunil.Khatri@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at
> queue creation
>
> Ignore please. Sent new patch.
>
> On 15-10-2026 11:14 pm, Sunil Khatri wrote:
> > The seq64 sync BO's PTE update only ran from the legacy CS path, so
> > userqueue-only clients never got it mapped and their fence_drv could
> > never signal completion. Add support for userqueues too.
> >
> > Fixes: ae05e3f3d02b812c ("drm/amdgpu: move amdgpu_vm_bo_update()
> call
> > into correct location")
> > Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21
> +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index 4dca1ab48410a..44cf25946a21c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -720,6 +720,27 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
> >     if (r)
> >             goto free_fence_drv;
> >
> > +   /* Update the seq64 BO mapping in VM for User Queues */
> > +   if (fpriv->seq64_va) {
> > +           struct amdgpu_bo *seq64_bo =3D fpriv->seq64_va->base.bo;
> > +
> > +           r =3D amdgpu_bo_reserve(seq64_bo, false);
> > +           if (r) {
> > +                   amdgpu_bo_unreserve(fpriv->vm.root.bo);
> > +                   goto free_fence_drv;
> > +           }
> > +
> > +           r =3D amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
> > +           if (r) {
> > +                   amdgpu_bo_unreserve(seq64_bo);
> > +                   amdgpu_bo_unreserve(fpriv->vm.root.bo);
> > +                   goto free_fence_drv;
> > +           }
> > +
> > +           dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
> > +           amdgpu_bo_unreserve(seq64_bo);
> > +   }
> > +
Hi Sunil,

I noticed two issues in the earlier version that are worth checking in the =
replacement patch.

The update runs before VM validation. If the VM page tables were evicted be=
fore the first USERQ_CREATE, amdgpu_vm_bo_update() can return -EBUSY becaus=
e vm->evicting is still set.
CREATE then exits before reaching amdgpu_userq_ensure_ev_fence(), which wou=
ld otherwise trigger VM validation and restore.

Also, the root PD is already reserved here. Reserving the seq64 BO with ano=
ther amdgpu_bo_reserve() uses no shared ww ticket, so it can deadlock again=
st a drm_exec retry that holds seq64 and is waiting for the PD.

Could we update seq64 in amdgpu_userq_vm_validate_and_restore_queue(), afte=
r VM validation, with the BO reserved through the existing drm_exec, and wa=
it for its PTE update before restoring the queues?
please try the patch: "map the seq64 memory when restoring user queues"
https://lists.freedesktop.org/archives/amd-gfx/2026-October/155022.html

Thanks,
Jesse
> >     if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
> >                                        args->in.queue_size,
> >                                        &queue->userq_vas.va.queue_rb)
> ||

--_000_PH7PR12MB7794D419AE3B29C6E2107D59939B2PH7PR12MB7794namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Yes, I realised that and updated the patch in restore path and pushed it al=
ready.</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Thanks for pointing.&nbsp;</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"ltr">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" id=
=3D"ms-outlook-mobile-signature">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);">
Regards</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33=
, 33, 33);">
Sunil khatri</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Jesse(Jie) &lt=
;Jesse.Zhang@amd.com&gt;<br>
<b>Sent:</b> Friday, 16 October 2026 08:45:34<br>
<b>To:</b> Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;; Khatri, Sunil &lt;Su=
nil.Khatri@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt=
;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> RE: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at=
 queue creation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">AMD General<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of<br>
&gt; Khatri, Sunil<br>
&gt; Sent: Friday, October 16, 2026 10:59 AM<br>
&gt; To: Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian<br>
&gt; &lt;Christian.Koenig@amd.com&gt;<br>
&gt; Cc: amd-gfx@lists.freedesktop.org<br>
&gt; Subject: Re: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at<b=
r>
&gt; queue creation<br>
&gt;<br>
&gt; Ignore please. Sent new patch.<br>
&gt;<br>
&gt; On 15-10-2026 11:14 pm, Sunil Khatri wrote:<br>
&gt; &gt; The seq64 sync BO's PTE update only ran from the legacy CS path, =
so<br>
&gt; &gt; userqueue-only clients never got it mapped and their fence_drv co=
uld<br>
&gt; &gt; never signal completion. Add support for userqueues too.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: ae05e3f3d02b812c (&quot;drm/amdgpu: move amdgpu_vm_bo_upda=
te()<br>
&gt; call<br>
&gt; &gt; into correct location&quot;)<br>
&gt; &gt; Signed-off-by: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21<br>
&gt; +++++++++++++++++++++<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 21 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
&gt; &gt; index 4dca1ab48410a..44cf25946a21c 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
&gt; &gt; @@ -720,6 +720,27 @@ amdgpu_userq_create(struct drm_file *filp, u=
nion<br>
&gt; drm_amdgpu_userq *args)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto free_fence_drv;<br>
&gt; &gt;<br>
&gt; &gt; +&nbsp;&nbsp; /* Update the seq64 BO mapping in VM for User Queue=
s */<br>
&gt; &gt; +&nbsp;&nbsp; if (fpriv-&gt;seq64_va) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_bo *seq64_bo =3D fpriv-&gt;seq64_va-&gt;base.bo;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_bo_reserve(seq64_bo, false);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(fpriv-&gt;=
vm.root.bo);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_fence_drv;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_vm_bo_update(adev, fpriv-&gt;seq64_va, false);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(seq64_bo);=
<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(fpriv-&gt;=
vm.root.bo);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_fence_drv;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma=
_fence_wait(fpriv-&gt;seq64_va-&gt;last_pt_update, false);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_bo_unreserve(seq64_bo);<br>
&gt; &gt; +&nbsp;&nbsp; }<br>
&gt; &gt; +<br>
Hi Sunil,<br>
<br>
I noticed two issues in the earlier version that are worth checking in the =
replacement patch.<br>
<br>
The update runs before VM validation. If the VM page tables were evicted be=
fore the first USERQ_CREATE, amdgpu_vm_bo_update() can return -EBUSY becaus=
e vm-&gt;evicting is still set.<br>
CREATE then exits before reaching amdgpu_userq_ensure_ev_fence(), which wou=
ld otherwise trigger VM validation and restore.<br>
<br>
Also, the root PD is already reserved here. Reserving the seq64 BO with ano=
ther amdgpu_bo_reserve() uses no shared ww ticket, so it can deadlock again=
st a drm_exec retry that holds seq64 and is waiting for the PD.<br>
<br>
Could we update seq64 in amdgpu_userq_vm_validate_and_restore_queue(), afte=
r VM validation, with the BO reserved through the existing drm_exec, and wa=
it for its PTE update before restoring the queues?<br>
please try the patch: &quot;map the seq64 memory when restoring user queues=
&quot;<br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2026-October/1550=
22.html">https://lists.freedesktop.org/archives/amd-gfx/2026-October/155022=
.html</a><br>
<br>
Thanks,<br>
Jesse<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_userq_input_va_validate(adev, =
queue, args-&gt;in.queue_va,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; args-&gt;in.queue_size,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &amp;queue-&gt;userq_vas.va.queue_rb)<br>
&gt; ||<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB7794D419AE3B29C6E2107D59939B2PH7PR12MB7794namp_--
