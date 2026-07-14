Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13A8C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 06:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548CC89369;
	Tue, 14 Jul 2026 06:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m2t0A8Pu";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED39289369
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 06:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY3iyztbNe1ZW772vVVuKDeHWHmpK+FMgjMXP4SOD8/FiyadvxKXRz9j3V3aVgNT6Ps1Z1TtlGjJWQOR3YX0i/r5bie8LEB+76mbo4aOgcBJn2SUaObVGYFZULQyDmVnt4PxP235XfmgEtr1T/v0X+mwE2y2A3QSM+mRnmG2Kg+rPGW+3/7GmuSVFi5Uiygd0Ri8dte8k0winnXyMIxQEvuk9doYlWzQ6/dlFKk8BweJ08OLRxfke1If9tOZ2VLcgf23FK4fGWZnhfqPEoWaUFQfBiPaRNbaLx3tDZd/rwosUXT5cgAQW0JtyQ3Zs5RxgYCIIzB7fAtUx7RuteBPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi9YIGkleXoIVgI7DcXBl9+dZbEOvX+hB1487vhAgG4=;
 b=KbjdM/oO6E0PdcddfoXcX4tukv3uf8lPYDvW2jjcmCpTUvCMEWL91rTcGBymM7beSwfU4K4/JVGlVBHpwZNZfzhzJRh0mulI2yzoMW4gdW1gZUJ/W6InEaG3GmaX8kbzP3bTOELeHVfpJaFwlq2ufAhNNIO9Xt6I2FZ/83RWxg0cOixeDSS63zeAnoTdWsmTzif99+D1w/DNGURMlT3jZ2HPDXHPY2uy0jww9F114t5BrqFsgQOi6UFyNajpY/MotXpGY3HvZHt2OAb0f3dxmGh93ijzwuQCR8M4zswOPdYp/w84+qlMjbYP9y/hU/2b2DxVDXxBGDYkTc17CTPLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi9YIGkleXoIVgI7DcXBl9+dZbEOvX+hB1487vhAgG4=;
 b=m2t0A8PuBjXjnXIyHfDaHRcEWAHjOWU2yNXC2RJMnUPaVAkiwrtebrZxj4kJTi93/oXBw90dYlDNE3G6/Pu9M2QwTbo/epEY/EwSlTFFqn2sVmMicJXHAGNT5dKxY3FlOYZ5q9Es6knnMfo/XnH4+X6og+r13IuEOcGS+aF5JL0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 06:26:25 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 06:26:25 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Topic: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Index: AQHdEwem2ibSw3o1iUqkIFz+zu3sh7ZsTuHggAA6JIA=
Date: Tue, 14 Jul 2026 06:26:25 +0000
Message-ID: <DS7PR12MB6005FB0DF535C58EAA3DC93BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <DS7PR12MB600589F9C41083DA5506725BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600589F9C41083DA5506725BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T02:42:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV8PR12MB9229:EE_
x-ms-office365-filtering-correlation-id: cc3ee332-3d41-4e86-0712-08dee170d4b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: zxOUjmfHGbLgkrG9R1MffscfCmPy+cn6xvV8LqoUcA30gBTr+HqQ+pGElu48d0vbdga0I5a6hp5YcDS8HxflQZFeU9OKsLCV12I1LS75NWZ4eo4bBoU17e/3kzrnWOxRKc2ehmLjGMYq/bPmz3Mo5g4LrG1joca3lO0zErQqTvoVMmFfepAQonh35BoFK+oDqJWibzwCHjhSfOOrCwm8oBE9SCaTCZQNQJKFznjHNPijiqmYUv/l5X+/rOqulLGYgvij0e0hZ+V81vgSxTdi/wETrUfuTW0nbeCeAZDYOBEzkdzIVg/7kPGRtKWvhFpbl8Oz0xynbGnv289UVJkzP+uCSNrf1IJzafqEB6N6k94WcbRdkFdNZdanplFk/P5Sh7I2v7NwZ6JX9nQN5e/SG6T4jcqHZVFyspDhM/3ZgSGi6T1nyF8TM1cwFe57Wqj2F6NAUDZw0l0qPF522U1aGHyTuYCeXUQ72Whl9/QbClCKMUFtMdzEzihHPDMb7AI/QQTepsZZtvF6Ga+Ok8JG+ZLK7qiO5L4iyuJIScMsMAquMbUI4gcu0cbzdkIcqx6L3OYFMo+AJfdt0rad6ypSyCYheNGRkGT8GQuL8miO9ZgBuocDbV1jBoshvhln/Tn7YspjFzGhIPRNcuanaaIA7IZ6IMo02slb3i63UdKpQNmkfpQYwItIvfPUYa75VKn6/cO5bAMaafKgSX+0KMCff2amrLrAd694/wysL7toHbQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Keh6cMX+IbrJrHLd+MGKhbyiADrxNXH9Wvyy1xnxGC1+NfqdND8xfB/gunTy?=
 =?us-ascii?Q?qiBUcBF9myMPK393uNU03/W/swAqkUbY7ETHIiJTLN9dGpoDjvpibiJ3R7SV?=
 =?us-ascii?Q?KgA4edlwGzunaCPM2IDZP008fWUi4eIgPtl2dHuNTSZXSxgz7Z1hvWMWschD?=
 =?us-ascii?Q?ZRLaGWgI/ZItSDzRNwdm/keZdls1eAjT4IiqJVnbmc6RhDWg1WTtdtVKc2kr?=
 =?us-ascii?Q?oCv6vmOp5iTMefyR6sgdXXdc6EN+NuzRfO7M2v8clKZ8CGeXs+LNNjSjldxu?=
 =?us-ascii?Q?6N2iM50Xao4+jY1wXL2boEuKCBAJAk6wZUO6MsY1uBlnzxQzRzioHR84+rXL?=
 =?us-ascii?Q?A25V7EKfAoRIe2187lWtxOSj8kawpdT3Rj6iWKlmUXis0c/ndcP4+1fq93kv?=
 =?us-ascii?Q?H/6sPCefov/E5XY3F58ZsFAM8cxwRgmGH6RfRut+QE7ivO/nwPlZgYOuHOEu?=
 =?us-ascii?Q?Fz0pYN+ZhVvlIXK1O44paZMWOD+IHyNAKrC+MrR9hj9Arc4wjgddligoZ72z?=
 =?us-ascii?Q?JFG5WM5oy8KAdf4kkxPpKV7EZiR9Ldp/sJLrZbjHVkwVzwFayNmDEA4iJ/vR?=
 =?us-ascii?Q?KcPWr/A+gae50DyUUG+qv6ZY7iX7/oI+LI5m2ogUHT+yxKp4Scpx3ga6HhFC?=
 =?us-ascii?Q?XO5fnirMiyxowlCo9ZgLC/oo7R9QviUD8g3oPp0gpo0hEFjXaKg1H9xz1rzC?=
 =?us-ascii?Q?NwQXL8IZzD6YP5KLIBXyuvcX763ar2oe/TYDIHYLTRoYgT9tJNBSuupEyfgN?=
 =?us-ascii?Q?LQWJuh8QMN5/kkOEqG7PXOnk7mhbO031sbFxTyN+X41vrejR6fEdeXpVH/Qy?=
 =?us-ascii?Q?aECZ+epW+j4PBpDFcaU9T0Up984BnGr22zz7NtBEMoBXEcLfHuP5RICuoC7W?=
 =?us-ascii?Q?TT1E52QuKxVGZYX0RnTkY+u2FuPnLkFoUBIp7G5axw9UHl8+0rv1wSZZHPIK?=
 =?us-ascii?Q?/yFW7/D/Ik8R5Z0EbTwBHPFB9CfxNinJNQbraG8Ft9EXHY3vvdomUz6eXP8P?=
 =?us-ascii?Q?/uyMMEZqrv9KRdqHM38OMhw/crSjBeA1N+TUy1qCsxdwKh/JjETO5aZoo1Y1?=
 =?us-ascii?Q?b0JVbjExFygU/HoiAfXRi+uLtHLQVjzBtaAVmnYn6KvnGmR7/EiN8BqBbMOn?=
 =?us-ascii?Q?7oDuxfpW/HTslMDKfGI5DSKrI/SaZK5LxE9bkzGJY4PSTL+cSznaoWk+9vke?=
 =?us-ascii?Q?Xcz9iF6gZuxWdRCgzaLW414nHBo0BqGHPEkt6pCFa92ZF8R1MseYapnDmIRP?=
 =?us-ascii?Q?zzleoNwsJRjxS6j9x42BsMQVgRmQbtGJKJx1BrHXIkpKAG0u9YXt08NzwM4/?=
 =?us-ascii?Q?FqFKeiVlRx+X6qk29menNljFhvkaKTvjGXUNY23S9wXOyTH5TcXWiFLyMFmq?=
 =?us-ascii?Q?RvQLpohHZt6jYPfPlH7uDnW+AsgR5DpYNOqRlxo8NFa/O6rHn7mc/mYiOK8a?=
 =?us-ascii?Q?M8eqRDC7GVYH0D6x8Ir3Fg9iqqg8xyt4G7m/fj9GSeQN5KtARkiSwXKHxpck?=
 =?us-ascii?Q?jNh56Pb99gh4kZfPrigKaC1YlWUOvSjfzmJikIUhlwI/9W76L3McPu3SdrUO?=
 =?us-ascii?Q?R/x/CRJmLIwUXs5x5xz0TagiOkE8MLEii9dWjKeYFilfKBkY5EFLxJk4KxbY?=
 =?us-ascii?Q?NF1RuAzrtVviSHkGTyXv2A7kMyN0ts2sxJNgi+DNqtkLIz1ddIzbfdZvDYLX?=
 =?us-ascii?Q?QQjU+GjDOgC5FkwPEbfTkfkagWtvhMPdqDaSP23b2OqIx71Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3ee332-3d41-4e86-0712-08dee170d4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 06:26:25.3469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJqMYdrVEyEHq92r4OTjdpgeZ50P/fj3vS8m7psWyz4+NQ1GME5YtKVjxMmyLjwg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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

AMD General

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike
> Sent: Tuesday, July 14, 2026 10:49 AM
> To: 'Alex Deucher' <alexander.deucher@amd.com>; amd-gfx@lists.freedesktop=
.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
>
>
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexander.deucher@amd.com>
> > Sent: Tuesday, July 14, 2026 4:39 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> > SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> > Subject: [PATCH] drm/amdgpu/userq: properly account for resets
> >
> > We need to increment the reset counter, force fence completion, and
> > set the wedged event when a user queue is reset.
> >
> > mes_userq_reset_queue() handles this for collateral damage, but the
> > caller needs to handle this directly for the original guilty queue.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Cc: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index 6aa75da27f912..5e1262636e1e9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(struct
> > work_struct *work)
> >                                                      queue, NULL, NULL)=
;
> >             else
> >                     r =3D userq_funcs->reset(queue);
> > -           if (r)
> > +           if (r) {
> >                     gpu_reset =3D true;
> > +           } else {
> > +                   atomic_inc(&adev->gpu_reset_counter);
> > +                   amdgpu_userq_fence_driver_force_completion(queue);
> > +                   drm_dev_wedged_event(adev_to_drm(adev),
> > DRM_WEDGE_RECOVERY_NONE, NULL);
>
> If we do the userq reset post similar process here just like as
> mes_userq_reset_queue(), so do we need to clear the duplicate the code in=
 the
> mes_userq_reset_queue()? Otherwise, the gpu reset counter should be incor=
rect.
> Except that, we might input the wedge task info to report the guilty proc=
ess info.

As to the first question, I recheck the code and found out the guilty user =
queue in the amdgpu_gfx_reset_mes_compute() was reset separately before  me=
s_userq_reset_queue(), with this current reset sequence then this change it=
 make sense to update reset counter and  force complete fence.

But why need to reset the original guilty queue separately, should this gui=
lty queue was found by the amdgpu_mes_detect_and_reset_hung_queues() in the=
 MES firmware? If so, we may need to reset the guilty queue through mes_use=
rq_reset_queue() rather than reset separately, then we don't need to add th=
is change anymore.

>
> > +           }
> >     } else {
> >             gpu_reset =3D true;
> >     }
> > --
> > 2.55.0

