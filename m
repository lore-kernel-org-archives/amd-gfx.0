Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1863C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 13:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDBE61186
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 13:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CDBE61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE8A6ECB5;
	Fri,  1 Oct 2021 13:40:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DAE86E520
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 13:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3QOQIlSmjesLIwUMQbODEwRG6tDgeJQ/cYvDwaZkxN+NmQfN5N8B5D7ulN/sN4yOCxtVy7oUFlQ0oqckU65/SxELAIx/vPXy6Cycpl1GfdBZItsrnFFPMdaYyskE9f5R+4On4E5ouyH7Rf66/aeSYk7ELzHm9Rtrxsghsl6AqPA4xG+OuDgaUVLUQjV54IxH1ZrbS4Zh4Q5JEXtF8csE7F7SS6u681RNlfsWcSSA+SNAFpDaytQre0Ci/1PGEGHY5EX9JWQSAMTKA+zEzx/s8zj0zAqMDqce6kzcGPe1m3/HBsTo7O4y8m11UGsT+1IOfqw8IJHEzgHPxSUxmeSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJxmIGdVg54goePWVWHVDrfyrmCdCk4H0CcqSIi/xn0=;
 b=RQFYg8BDSeZPNy9/ICAaISdxjaeNGBut1+9AqMXRZoEYzU12aQxgXw5jYF2KuF9Uq6XGxpqUTOTVyIq6CpyoLBMMIa79X744BvvGCfyjNhmmRTtPf8m81NYeyTeONDwB5yQJ7KIFdI9F2WR5u+Gra2+4KozxK36ob9LhdXNKMc7FJspsMCFP2ar51W+WRej5cRTWeJqn+OvnaknKX2ie5kp0+vGgWwwHiqohFihzWBeV9jjxWgFZdYHavJT2vbIVaoNsH3rSs+tdPOxEvZWe6+J4pYeKfe2FrSkWe7ubtXw15q65GKYc4H/wKtYm0YMUlPETGf/WZV7WdHPzHVIAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJxmIGdVg54goePWVWHVDrfyrmCdCk4H0CcqSIi/xn0=;
 b=DQNaMRZCu0VDm6x8NWBd7ruVnJEW0bAwoMED5w4Yc7qKa0fVTfE8nkGpzJcrBd51lk696ptGLBPX/ADhHcvV1ZNnYnJTg3zdAuAzLHYnvmX7SD7wQNxk/1yxvjbFVc6it3TN7B1kkjnwmflZG7PIkSxjvGvJWqlggq762GQ0XVQ=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Fri, 1 Oct
 2021 13:40:53 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%5]) with mapi id 15.20.4566.014; Fri, 1 Oct 2021
 13:40:53 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, 
 Yang(Kevin)" <KevinYang.Wang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: During s0ix don't wait to signal GFXOFF
Thread-Topic: [PATCH] drm/amdgpu: During s0ix don't wait to signal GFXOFF
Thread-Index: AQHXtq1pbrOHTmmWIE2lHEwHOf/0Gqu+IoSAgAAD7FA=
Date: Fri, 1 Oct 2021 13:40:53 +0000
Message-ID: <SA0PR12MB4510019C45CDB7A5CD7ED0E1E2AB9@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211001101625.15575-1-lijo.lazar@amd.com>
 <CADnq5_PQkPwOWWPK92OUDEA=kFh-RhqB-Qp==DDosZQzP27aEQ@mail.gmail.com>
In-Reply-To: <CADnq5_PQkPwOWWPK92OUDEA=kFh-RhqB-Qp==DDosZQzP27aEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-01T13:40:52Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3da2d20c-059a-4add-a1c7-d1edcc42edf3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ca8a7f1-c58b-41b6-6313-08d984e116f8
x-ms-traffictypediagnostic: SA0PR12MB4511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4511AC3F1203E24F643C16ADE2AB9@SA0PR12MB4511.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oWMmZcoWZCt00etIQVtbiV683C/9OawZZQXhXQjsxQXd2WSyKtwmORhxyI9lXbFyjMcTHJ8Sq0i3Pd1XuUKc9KO6ybYOBSCI9sh/1hR7I3QoJbYP7PCp3DaV1NQ/gCRNxz6nsICnrK4qpR199Q4ezraTBVsrtMhU62YCljSA4SKurwe6WxRg6qLu+tk6ZDdRRJ5VnB6c+f/f0KkWy5LnwaurWWO64l2830xcL/cj/o/M0G5ybc0JppuuZp9zuyHa7ZA5Bn3cB25btYgm3IcSergJvO0+1HHEk8SXE6tAgMoH20kNHXEMJHMdvn0YiVHUTWTxr7ldcKSPRHbKoZ2iGdy6oQz7GsYf2fwqEJOjBazDWEAguFk2n5MoRiPmM0R8+tGg0wlPPK5y8FXL8ymTuW6nftxk3iDJcPHBH9i6e+eM1ugGpta8UykZtIlEQBaKpboX5cVKB/KmssOuU892gnej2tLKCQJTD5co6jPppByVb/gDAxOBVS2JWUG7Xz6kv36cgYxWqokdDGpuWgvIFHCzuKEdwb9hDB+eePUR3BG2gBSbT0jncxyWKUL/jFikcBG/yBWMuAuyOvlivdegq6CqNe4dZzBJ76UyBcWZcLregmhgt3V+AtbnN/g0Lk5esn6j/aqmVBuveAy2/cCNgAcJTNyDe4ZGqSa6cV0sHnQg4n9W8F9sK3ZyYEiltYM6a/CNZ7Hn9GJYL/ctEyVOFWb/KnHxLp6Kd7meZ0H4BubMB0rInhHAdhXK8EHIuqPpGpcr7bEZyj4LV0PwDro2m5SuJSozJl4NjHV5I79VRc3oZDNBeOa9GIeEpODvUxCX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(2906002)(71200400001)(7696005)(83380400001)(5660300002)(316002)(55016002)(38100700002)(45080400002)(76116006)(966005)(33656002)(66446008)(66556008)(64756008)(66476007)(66946007)(9686003)(110136005)(54906003)(52536014)(8676002)(8936002)(4326008)(6636002)(6506007)(38070700005)(186003)(86362001)(122000001)(53546011)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h1lzw4QQ6ie6KZkaew49TRI+r6PLXPuSCtSxHY+xcYbc/N+sRait46e/Evee?=
 =?us-ascii?Q?by/3UZhhSU5SzQRKRsI4poeoQG0UjkLAYUnKQDFxUDcxsu+UD52tX2sfxKa6?=
 =?us-ascii?Q?CpIPmGeHOuNnSrEqrNBCtQfRWlOM8JIqKWKPhmgHoDV/bIXsaMxLDbS1LwZY?=
 =?us-ascii?Q?/XHexX5PnKWXuygl9H7DE7QNDrN2lJTEPTUFUiTJ7enQWH3o9N+dv2Y2B0DC?=
 =?us-ascii?Q?Ip+jut9UmFjT8w5xM8kkV3YQ3Mz/LYNLi/E2qNh1IcMicFPf1lFwfgwceJlD?=
 =?us-ascii?Q?WDx99ByZXcUJrXNSJ1PwcrRMOpVxWxx4ofzbnmfAAkV+3SgJ4g5xPjUoc9BM?=
 =?us-ascii?Q?qZ/H3zhtfWQ3UvwYda4tZG4dkLkY2lTTXlEAUDD1kSXZLrVXCf03Cu5GFMPr?=
 =?us-ascii?Q?iRJ04LW4226qcMKMt2AG735FFIWFgYmWs0LAa6n1dmg1GI6QEUQ8Jf8c0grZ?=
 =?us-ascii?Q?77n4YqKmhPa3dJf8qsTKgMdWfmX4q8VnV7+e2LVxsjO7rlBkC4WsbbbWlazq?=
 =?us-ascii?Q?rCLnEN9ACzSYjvuZXpWdiOdkH2b5f4SZz/x2zOJPGtoIVBBGRKHgbtsBVNm2?=
 =?us-ascii?Q?PfCkXIcHg5Nm7RlH8VCNYSRzCxwLxaoYauHTqTKscizZV+1hnQmSwKjdCwXh?=
 =?us-ascii?Q?x8t63ol58t3YUrXTcP1fPNIwRdt8ffmDygLpd6qhJlBjgcyihzkT2c7Sd7uT?=
 =?us-ascii?Q?7PK5w7HBAX167M5toAbTBRpuJT2pv7VJT823vBd0+LxK4+FPFQ9eH82+D9tv?=
 =?us-ascii?Q?MLMQ3g+v4UaXmBFKHXv0fgwcM1oR4OE+G10lOeSlaj+kwCbVNRRHzVAMONJz?=
 =?us-ascii?Q?6qXa3LCRYSdZbfAeuvaqg6PmTcLOrKF4cKW0mTG7pvIC8FR1biscQstEue+j?=
 =?us-ascii?Q?jOcWLS3bQWIter/w0I1trF3E8CG3+GUDegysieSyLwzeeWyWQZ1WqdZR7CQU?=
 =?us-ascii?Q?Jdhd5tKuXrFW98Hp4rGQUJrFTvcgoiBNATCHm/kiIRIi3ps1RwIcLGtLaP2D?=
 =?us-ascii?Q?Y8EakolMzu1lPsKSLY0lAlpZiIHM9t1hWlOoNz3RQxS5kTb5ybqxtkdBxMnx?=
 =?us-ascii?Q?6a0fwX+SjhOY3CBPPTElZjldSYP8OU/xrR+mekpY2ZtHTLH2MSHalszGw4fg?=
 =?us-ascii?Q?iP9paX+PaqGngH9fhPDtWHZNe8TnOFQK6HhPvRUZ2uCnbBbFIo/T0GLOw8SZ?=
 =?us-ascii?Q?r2hB+HSLGj0oqSdyRwRS7kqF4EBLaNZAvG+dfqMDMnJQ4ihBCEjmK0ycM0iD?=
 =?us-ascii?Q?GBxtnmBVyMhC2Yxu9J78Q8/pkevlAERDEqCkXAd9OQvkqcuh4It6TRixp8Xx?=
 =?us-ascii?Q?b9VIdahZdZBLjNS/OVyO3f6mc8fP8IVa8k5u6Fsw2ycqbf0aArvYthRTGWHc?=
 =?us-ascii?Q?W/c4Zy53ke0ugPVKutLK1pS7GSPj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca8a7f1-c58b-41b6-6313-08d984e116f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 13:40:53.6107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7K4udufszN0rSUxi8o/o58a0BvYwO6YJpgd0roE3ZSrp9/oTt498S9GQMm+3xjEHYNJ2MPEgrJWyRzowBSnFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
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



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, October 1, 2021 08:26
> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: During s0ix don't wait to signal GFXOFF
>=20
> On Fri, Oct 1, 2021 at 6:16 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
> >
> > In the rare event when GFX IP suspend coincides with a s0ix entry, don'=
t
> > schedule a delayed work, instead signal PMFW immediately to allow GFXOF=
F
> > entry. GFXOFF is a prerequisite for s0ix entry. PMFW needs to be
> > signaled about GFXOFF status before amd-pmc module passes OS HINT
> > to PMFW telling that everything is ready for a safe s0ix entry.
> >
> > Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1712&amp;data=3D04%7C01%7CMario.Limonciello%40amd.com%7
> C0ff4fe8eaf34471369ff08d984df1a33%7C3dd8961fe4884e608e11a82d994e183
> d%7C0%7C0%7C637686916025223001%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> 0&amp;sdata=3Dx4FS7%2B8uSPiNwYhQdDLekjBabrQwvkBfb%2BjlVbxJWB0%3D&a
> mp;reserved=3D0
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>=20
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciell@amd.com>

>=20
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index e7f06bd0f0cd..1916ec84dd71 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -31,6 +31,8 @@
> >  /* delay 0.1 second to enable gfx off feature */
> >  #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
> >
> > +#define GFX_OFF_NO_DELAY 0
> > +
> >  /*
> >   * GPU GFX IP block helpers function.
> >   */
> > @@ -558,6 +560,8 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device
> *adev)
> >
> >  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
> >  {
> > +       unsigned long delay =3D GFX_OFF_DELAY_ENABLE;
> > +
> >         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> >                 return;
> >
> > @@ -573,8 +577,14 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device
> *adev, bool enable)
> >
> >                 adev->gfx.gfx_off_req_count--;
> >
> > -               if (adev->gfx.gfx_off_req_count =3D=3D 0 && !adev->gfx.=
gfx_off_state)
> > -                       schedule_delayed_work(&adev->gfx.gfx_off_delay_=
work,
> GFX_OFF_DELAY_ENABLE);
> > +               if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
> > +                   !adev->gfx.gfx_off_state) {
> > +                       /* If going to s2idle, no need to wait */
> > +                       if (adev->in_s0ix)
> > +                               delay =3D GFX_OFF_NO_DELAY;
> > +                       schedule_delayed_work(&adev->gfx.gfx_off_delay_=
work,
> > +                                             delay);
> > +               }
> >         } else {
> >                 if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> >                         cancel_delayed_work_sync(&adev->gfx.gfx_off_del=
ay_work);
> > --
> > 2.17.1
> >
