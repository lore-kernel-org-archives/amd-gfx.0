Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0143CA0FFF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 14:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C4910E0EF;
	Mon,  1 Sep 2025 14:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4VcXUQwo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DA910E0EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 14:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dupr0dKi01cZaUKx23FpwZcwVaMN6fQcwVaFm59PewkcyQz8jZDEEeJ+E2DeMp9pGazztY4eU6hYLeoepXZTZRAt6l/iImw7MoYRPXGlgUsmxA3vjoSlskE5LL26wYEtelWo48Wo747uLS5OyeKhsn1HCjjZRKgTc3cuRSmsKQ0Y99MvWnHqE+hEKeKIR+SqkgG57hLNrhVzcicbgqMrW7N5podCXGqyo5mD4jtJblozDtjcXbjU94dYo+6QhJZn2PFAfzX8rjW7La0hb/mZCnlqhFv3IDFT8BqGyAHLppVnk/LQ7mKeSwD1JHQyCucxQsFNQmHljYk8SwXp4AEn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0E+rE+Ki7UcR94WxkIPuAK862Fn5vzFpOu6zHehWh4=;
 b=hM5IAX+CP0EUxT0/B7wQu5GJmkrpuIYf3CnnX5jC0tElovcpCkuDHYJMVAbH9mox/MniWkHqjJpDZlTDFPiRr3e4fGyfCELJXTsqucGrpaMt0CX6dbKGwbWv4opq2ozxjKavyOe7JUOQDNkG5i+D6lQlbSz9/+XUxCOm6b+8bvr13y1ebnNdQFdG7RDx9sUAYOwq7nNpXVsYS1VkT6SuHpldmJl0iF4MrCeVEqCGwGghorW6T4m/uWBXWNucBdWKc1I5PXzf01OxDztfgMOhA4dKzj/x3D/H8JO07murWQzN5Kz5sDxj8Lu8BvxXCupT0VesbCmbcjTTHkj1rYBnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0E+rE+Ki7UcR94WxkIPuAK862Fn5vzFpOu6zHehWh4=;
 b=4VcXUQwoXAgOaf+ZTdkuDZf5BPYhMkh0uGDzPt2JmYK39aGDXC+R+eRGj7P+H33qPostBKe7x+bghjjkMT6LVH/G/IMix4tVJ21H5hKnQVQ339cp3MiPjik3AIJwkbLBiLGsd6CcFUQc+tG+q3axA5VZLhB3yqQsORPVuVN2USs=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 14:29:57 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%4]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:29:56 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: wait pmfw polling mca bank info
 done
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: wait pmfw polling mca bank info
 done
Thread-Index: AQHcGI7t54dLMoP2ZEG4Hq8IX5xXCrR9nY2AgADKJ7A=
Date: Mon, 1 Sep 2025 14:29:56 +0000
Message-ID: <PH7PR12MB798811A4888875D44D1E45F09A07A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20250829024442.1019668-1-Stanley.Yang@amd.com>
 <PH7PR12MB8796EFBFA72BA7A4B6909F16B007A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796EFBFA72BA7A4B6909F16B007A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-01T02:21:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SA1PR12MB7343:EE_
x-ms-office365-filtering-correlation-id: 992d27a2-2064-4589-86aa-08dde964062e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7I4kiIhSaFnwmfoO9joVIC0f/YHs7J6PDnl77n3O5/tnJfp7NjM/C+4AUf7o?=
 =?us-ascii?Q?DfA+5YSISm5gcSIbQLuJCNETpZTbf3GzpE7Mq2XvxhZuMPiv1YNMVLW0Ijal?=
 =?us-ascii?Q?uO0OG0Cc2SYT1uktY63sDtPBGADqaqmKkX7UUVbcp4UCY9aB9nSJ28Ecd9Fz?=
 =?us-ascii?Q?aAdQxojhkEK3I7V5TFldkmeXtTXkkE90+trgvlBWewgCmVAKRCxVzCUyYFWv?=
 =?us-ascii?Q?4A3LOcFc53YptBYeDIPVLCrUzryNhug0+2EOoZ2Vna2X0Kyhm8WOhCnwthEs?=
 =?us-ascii?Q?hs7v7vEHjkkIgH1STeZm8gtoLj1j/Qxybd+FQrp3IzLwjI2zpFghHGN7kKpL?=
 =?us-ascii?Q?taTSAfOMVEbHvcSZsvv/hyQ+ZMD7HOx1bk9L3W426eZvYkYtQ7m4slGhiTK8?=
 =?us-ascii?Q?ozYWRP4yWVQIVOzPK/3Gb8cdKBXNZOQM+YWMYFY169hF8OoE3b4eK5t68rgP?=
 =?us-ascii?Q?nqbAi0w6EfxqlME/xvECCEu7eQVLDhdQGl4t0YrjU2t/+ijJxT3deL1eqRad?=
 =?us-ascii?Q?Gny7IBarUL+4XXDTOThH5UUiiluIW2qRLWl+sk7GMB3QRQ4n+u0TC/vnmwN/?=
 =?us-ascii?Q?B1EfIC/KrP9vsehSlEBVWnP1B0u3qMhBMCNIm1U2mCfl01MvziCTjY9AuxE2?=
 =?us-ascii?Q?XHoZ/vP7MqFy7pICJocvhYp7VBhgIM7qLh/eAUeI6kjVRyDOeYgnXnP+SfVW?=
 =?us-ascii?Q?BmIWX8FoCeAj039bebdL5AMe80S9PcjLCIB7M4xej59A8DZSupehWek+u74R?=
 =?us-ascii?Q?XQ3rE0VAZF6Y0k5WtrVHpp1PysyzqcK/WGB3VkohlMouItebeMw6M6a1R+pH?=
 =?us-ascii?Q?im8oEPI00ZVJG6YL7DmwHonP6PZOMjTKLvyf1pYUKFsmE/qaF23cl0Pvtg8g?=
 =?us-ascii?Q?SOLjbGsPmN65Kt4ZR8s/WcY8YKR7A2rQo8M9b4rrqtPdgjijFyQx//gq991z?=
 =?us-ascii?Q?YzqcL0CFeChT2CR9A5+KxUrZMwHJWD/hIEWqGOU3R9T9snICrUI/iLxQ/X/j?=
 =?us-ascii?Q?F4yyAiTEGLDcbngGpl/F9Uoo0LzoZqMl+aSa5SaGLefvugezcqJJqYU8e0P8?=
 =?us-ascii?Q?iRELO/XIwcC9qHinCfTML74bPwR+hRlqrUHhdINIJioiqhd+0pKGr4fI+Bbi?=
 =?us-ascii?Q?BOG/c2LPe4dPXCcUw0Zw5SJa/isqG0L0foDFJN4upQpeJfa91obl/XMiLpVD?=
 =?us-ascii?Q?Dp82QoMX64S8QblOSah/F+lB1sbGMojsm+ZLZdI4sczmBmng5IS3RgFadYLj?=
 =?us-ascii?Q?xb76PcRuXuUB7bSR7f1QvUg9455i8AFSSGbrvMA6Uav/2tbQKKfhYISjSczb?=
 =?us-ascii?Q?WO8o+ZnaqUrs7afPsyf8I2UudOfUsO2ynfbQzHPqSX/5xr3b68ncjCB2Ak/k?=
 =?us-ascii?Q?DjBTCJSN0pyQy8AKwJ+C4R+Ln6jzGJj+Ulnmi5ScVawtP/Alr+Lspn9H2opx?=
 =?us-ascii?Q?kaWxHMjIPl7FbfsmHmbJPm4+wN/5L+0OWvMroelSb5mVDdaHdp0c5LdUFxgO?=
 =?us-ascii?Q?UKgd5WxPgOJeiwc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vB1T1YpnrIXgcGu4OIPCYPhHliBu/baqj+HUSY+plJgh9KYEmReBAJIBQrMm?=
 =?us-ascii?Q?QWFdP08ZUBk+xOtPB2rX7Kt4dKpklO3XOfjMJC2jxtCETObCInnv0hBIt5+c?=
 =?us-ascii?Q?gvBhu+U8bqcWl+XRm7h0+mMrAWdEcoOvidNhgUjnTyQFm+PKXG7eFRIIfjnz?=
 =?us-ascii?Q?0auaxBi4/2cTem45mqn0JGdl3WrbQMClUl+eD+bU+Qw3S0VFRkGlAzEOhpbn?=
 =?us-ascii?Q?VKgpp0k7w4JeCNkYKGZL2JstriMhuD6RRqdRVysoEmHCfzGTbWz8s0CRgsgc?=
 =?us-ascii?Q?TtycX22yXTo8dtPPWcVShoOlTUpnp5yLjSG0Hieps9rixALBg6ZGB6RDkPMq?=
 =?us-ascii?Q?8E4aJlB3Yjuf696ONyUJk1cVHrkS6VXsHG/6fq2Rsug8Dd7m1NC+486TKS1v?=
 =?us-ascii?Q?sJKZ71+fZzhtVTuiAQX8fC6n4ix41SRAZfGTF5BL3ExKYfQR39J5gv35ypDl?=
 =?us-ascii?Q?cpQMzj+Ncx/4sV0TgWsK5cdBhw+C9DZJQibP6ZWde0mvk51ka9nv64You8jw?=
 =?us-ascii?Q?SdSiHdnbFPgXfOIOvz8slkea297cS6wBMCZ8A/QIwpFQBn0+/jmGYFOCHIjk?=
 =?us-ascii?Q?kYrSwBIkmCI+8jknfIrl/fh462TC9Qf1Ptvp471nrq1AngjjbhwzOmKQm0vK?=
 =?us-ascii?Q?3XDe32OA8MGBkHnBzNyv9vJIR+IrQRL92HYMPr9cDpy/sE7LOjaUKxenb8dt?=
 =?us-ascii?Q?2LXUAdD/Gr1TJhMvtmue8B0fzXjBz+0JxLtKTdE2jX0nr67sNzCBXXd4aAwE?=
 =?us-ascii?Q?zwt+8fHLn3nPirE1sv3IS22p4gipvxw4OSWLc2pEM7CiSxtAe6DzTDM20y6j?=
 =?us-ascii?Q?UeRuRepHJcMjZuLlaPYsYCvO/sMthXYzx16e9DyM2HMy0Xneswqb7FzCJ/Wk?=
 =?us-ascii?Q?EZE/r5irjhpFmK/UjDa5oln0WaaLltxJq+PfZgb2inTE8iC5l3vkBBicoS1v?=
 =?us-ascii?Q?DduuKjI8prLxX9p0gvjkxJyLxCSQO61bwwMMEBjMMtdgvMQv7/Rwl3SQPwNO?=
 =?us-ascii?Q?E8KUeO5tXKIChuZzGxV8cPpgyITMHtds5XFDmYWhlHys4SYQ6kXtyzEDwOLF?=
 =?us-ascii?Q?i0sM8aEfY7bPnMDexvDMMV67zEhctYdHiycDT60zVzV3KrFE9/Ekhc1fDsSl?=
 =?us-ascii?Q?1E3K17pTiBo0sTjIznauQLjd5Sx+7B6FYfj6H0PfEGbUBe4rMxTS0KqMqJNj?=
 =?us-ascii?Q?K0YJIAIVjZLjT/P6qZPZuOtL182NFuWk9iCn/mIlT4/xFV6vAWqpMt3594N6?=
 =?us-ascii?Q?KvFh5m+Fy63FbU/PZr/+46Hau9Z7BqXZqCOYPHVRiWdx3cJxfZFUEEHI+SVe?=
 =?us-ascii?Q?DQfAya8kNZ/tjpHc610fabAzoqcNkRq4/336Z1mQd8JFX2jjQwocqSS0rJYt?=
 =?us-ascii?Q?/k54sPOBHanb4wsBXxTAMx9nMGNRqlYXNS55oXmUm0gUUc0Y+F4FL0vNa2/I?=
 =?us-ascii?Q?tXGT5yj3lUWSIKJ4ZvYocLneKa1+A6YvpL/FvZQDKH9GcCwc9wT1dUFPVp/2?=
 =?us-ascii?Q?eBi1ceq5IUHCos2PUQOTtn77Yg8tImaMrXOtB2eq/uNWjKzTJqhHxpdJU3ST?=
 =?us-ascii?Q?BicNpd7ZTl30CcCzhfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992d27a2-2064-4589-86aa-08dde964062e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 14:29:56.5994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+Y30Ap1wZ5HkWZRQ4Q4Qn9rJeMorFhEEO4HRKkm0NBIsk3l95YN/SDIhsNah0g5TUJEyU5nrgNlsOwZG7RjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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
> Sent: Monday, September 1, 2025 10:23 AM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review 1/1] drm/amdgpu: wait pmfw polling mca bank
> info done
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>
> 500ms is not a short time, not sure if we can decrease the delay or check
> pmfw status.

[Stanley]: Agree, 500ms is not short time, but currently, there is no way t=
o check pmfw status (polling done), and the delay of 500ms has been verifie=
d.

Regards,
Stanley
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Stanley.Yang
> > Sent: Friday, August 29, 2025 10:45 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: [PATCH Review 1/1] drm/amdgpu: wait pmfw polling mca bank
> > info done
> >
> > wait 500ms to ensure pmfw polling mca bank info done.
> >
> > Change-Id: I50581f03929c86d75bf09d66238b64f2806697f0
> > Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 096881c90200..be0da05aa9a3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2705,6 +2705,7 @@ static void amdgpu_ras_do_recovery(struct
> > work_struct
> > *work)
> >       struct amdgpu_device *adev =3D ras->adev;
> >       struct list_head device_list, *device_list_handle =3D  NULL;
> >       struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
> > +     unsigned int error_query_mode;
> >       enum ras_event_type type;
> >
> >       if (hive) {
> > @@ -2733,6 +2734,13 @@ static void amdgpu_ras_do_recovery(struct
> > work_struct
> > *work)
> >                       device_list_handle =3D &device_list;
> >               }
> >
> > +             if (amdgpu_ras_get_error_query_mode(adev,
> &error_query_mode)) {
> > +                     if (error_query_mode =3D=3D
> > AMDGPU_RAS_FIRMWARE_ERROR_QUERY) {
> > +                             /* wait 500ms to ensure pmfw polling mca
> > + bank info
> > done */
> > +                             msleep(500);
> > +                     }
> > +             }
> > +
> >               type =3D amdgpu_ras_get_fatal_error_event(adev);
> >               list_for_each_entry(remote_adev,
> >                               device_list_handle, gmc.xgmi.head) {
> > --
> > 2.25.1
>

