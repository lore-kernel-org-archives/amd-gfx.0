Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB94CC369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 10:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6536F10E421;
	Tue, 29 Apr 2025 10:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vflxf9Ny";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C6710E421
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 10:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvvIwvZKvqK0BxVyRBkGi318Oc6yHopZp5hXsLvNIJ6Aqdczdrg1PhwcRnj4t8cTV7K+K5O+azLE/dACnfmwK+B/TUR3ajiKHJNeSpWYtn8C/w8k8znU43vuiSv5HuAS6Dgzo/sAtshq1OqOdaHaSFsiqVTMRePUSZQMkU5cA8eYn6kuc0J7AQc3GXlwQReofvENGU2CpOux1mAwD1p9+OIWWFdqoqEpDWJO06J9LtCgBj267TRjtDX89dDfwemqHyU/Zfpu14q+Dz40HWD0ReOoM+dAQfduSsDpfBGtoRQ3wzARYr3JMyHmrL0RWO2yo4hmC66TrnxR1p73pGLv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaFoBY/D8a4RG0UdVYc+vrtFNbJwPRz8L0ykm3E0JQY=;
 b=uUPL1NsOWZQRMRTpPANaxG2Y9HJICr3uFo4kj7txrbhZNhhm7s9agTuSh7MZ1kMtTHF/bRsh1BnkZREZ3Mi/rj4a5wAVCkkt7W7jUbo4TMg6nb+/xOo7QPW8TC0NOENPgWhkckCB4m89rFDoJikyW0bxQE1b1SqwXdOa5ZNOOfAeY+Cg07PtaBsnHTYhh/FhGm3WIQhAauAPNsGLl8zk/clABUL/aUjPGw4EUn5NBZnrAdQ2PA6iYD8flV4907v7jGH5BLLPCk6Tc2la5ct4n/qJQlEYa0w7Gi5jNOSAJXi3dLgZhmWrwImHXHuuljcFZPtrmxd4VyGmNkdR+uRDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaFoBY/D8a4RG0UdVYc+vrtFNbJwPRz8L0ykm3E0JQY=;
 b=vflxf9Nygd20ThYcPR+02aJfN9NTUSsbiQ8zllAbNrTZ8eMSyjJ1GgHQa/Se5lWAqhxIFt0QIl7xsVXK/vyWsB4/RDQj4mvpgDcMUiYPF0g4O66M6ZC59Ypl/bllvPw3vb0vyaWf11DirIGcyGcTN/1jq/ZOB9yE6dq5FvaD0Jg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 10:08:03 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 10:08:03 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Topic: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Index: AQHbuNSUufXe4GuQCEK2IbT3YFaDF7O6VhMAgAADkoCAABCDMA==
Date: Tue, 29 Apr 2025 10:08:03 +0000
Message-ID: <PH7PR12MB8796271082C5FDFCE2982FC5B0802@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250429070121.299873-1-ganglxie@amd.com>
 <PH7PR12MB8796DF080D6D991A7CC37ABBB0802@PH7PR12MB8796.namprd12.prod.outlook.com>
 <MW5PR12MB5684B2000B58EB14048AC397E5802@MW5PR12MB5684.namprd12.prod.outlook.com>
In-Reply-To: <MW5PR12MB5684B2000B58EB14048AC397E5802@MW5PR12MB5684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=277a55aa-6944-400b-8930-8ac0888aa38b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T08:51:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|LV8PR12MB9133:EE_
x-ms-office365-filtering-correlation-id: 178e2a15-4278-463f-3b4c-08dd8705bade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5IbVYvp6QN60gtD0KnwoLL8OSHMuQYoJeIeqYRvopitlXJUOUvkk0/mr+b62?=
 =?us-ascii?Q?kaknihvVYYS1rMBmFWhOwMbk/phCn46HknI1OorJLD7c3WYHp5FD+cWn+hcy?=
 =?us-ascii?Q?3tFI9v0J85RYG31LLXTbOpovx6Sp9JdAdUVg9WAHSPWXNdCggYKngliZAA8z?=
 =?us-ascii?Q?JOC0lOYgW1UEEwIkTvZlSwHh3B42OHvYP7XyvKlu7L3OxOUiqp5Pos5bcNIU?=
 =?us-ascii?Q?kv0AbKGEj6F6c33ihrlhU/Ye/ME7hqK9Q9fEse2eU/r0Zyu/hQMRw0R/+zEd?=
 =?us-ascii?Q?EvfsvoKkdBIvlu5rGf5eifpePPYU5zpU9uzZOoinECB0xCevv5XvpLym4ZyD?=
 =?us-ascii?Q?72aU3I+EXUsZ7Z1g7mrZSAoUQL8HhGpC31GYWLeOWX5ckkJ/6gMhFUo7mM6c?=
 =?us-ascii?Q?jOSDSogs+HxjnyTcAm6dHLmG6IvHPU87aAXcg0g+MDoB7TR3k3aH8N58jHNa?=
 =?us-ascii?Q?VQcuCLRt4CeJA7HQdoZ1Z4LcQfdL5+uBzlfAFy8aMR6G9J9IhladTANPQiQO?=
 =?us-ascii?Q?tG/3NzXSqIsCu0P+7EQ2ydnXIpBCjtRzI3Bd20kjNxMfyLm0jN3CaEc7l9nP?=
 =?us-ascii?Q?RQYMopz/CsEU5R6sVtds6Rxswo2LHQj0pjpklmDG4FhIm4TeWo62taZghrFm?=
 =?us-ascii?Q?GbbBG0j+/vucKbu2x4J/dJL9w7SNFig+pf8bBrx61+eg0PAvzAJoUQF8thN0?=
 =?us-ascii?Q?KvYlGgxOo2l7C/+BpCmgCZLo8hykBc9V7KH91xyC0UtWxtOFYMVI5/RBUi8s?=
 =?us-ascii?Q?dXExLZW0K+FJlzBm4qNU8FbDayF0BcUBpHTfdUsDWpjY5xdWs7sPMvIOqMr/?=
 =?us-ascii?Q?pQFUraI0sZqZgyPINbx5/ViwiTw5jKRXdE6uynO6vYxumHTbOSTJlqFx64fx?=
 =?us-ascii?Q?AjkAuo1v8H+p2srM8o76n3UDbK3xzUNSgF0hX3YjNDEyAxB9c4m2+MO/2SJy?=
 =?us-ascii?Q?mYAYZAB8K2cN3YBKJMRLo9ri0YR5LJ2kfwOv7yK2ljLBClBwexkw8py8WvSG?=
 =?us-ascii?Q?d6fdXJCAamj9posO0lroAZrGpl/aV7ffmouqO8lHES9eib4c1HKpQh5zGc3B?=
 =?us-ascii?Q?vWqXEKPXgX0+vxs6tPRI6dvR6uj+IHiJYxkS+csLOoE0naZMpEfEGu6keeVA?=
 =?us-ascii?Q?/BOU9KgPEHnMQdgUqBlaHS8RECSp1Ybb44ryPDbQSrhmqG/BGvRpPJnkiU/v?=
 =?us-ascii?Q?dceNuHMLKfPqFZ2u4Pec8OVI4Q38gzfl7IyJHC0Aavf7Bdp+UD1JDiKoBk8E?=
 =?us-ascii?Q?yRmma8qNbDfeyQCV+zwtK4lada632kG0F/BL+hKFGTZjM5Zl0b9Iv4H5AspQ?=
 =?us-ascii?Q?6mNfzr7aJXswgXeoDQ8VhtVMk4TLqSM/YPpZznweXndz9XJBirwv90I1q1KX?=
 =?us-ascii?Q?JIdAMA8LMThd8KlgwNNH4ddkKiSbJuBK80DPKKC7+BjwWb3U5y+9cXPIY3pf?=
 =?us-ascii?Q?cKB1HlS+w0QxfWKYk2el/jUX4A0T8iSi4HGkNgLXEPIiPn5z51oepQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ENS87qmvgPEr5eTnfoIp8SjH5fF+EZMRFCde6wUKr95U0JC4MJZ1yWVrfeHs?=
 =?us-ascii?Q?q7knVnen/IIxxlkHWlZnRghYDDMn5Ru8nJDYHACnhNMDvNyw7+84srbSOs9d?=
 =?us-ascii?Q?6sWVWxgHBcZdoRVImzIw0d5p7cKfD/cWWvEKuqDXUenoRHjDmQMqBOyowAmS?=
 =?us-ascii?Q?t3fXEEkVzozN1v/y4AuYEQocpFAqsysFC1nPK+BPAkfmIux6rfY5kc0noqdR?=
 =?us-ascii?Q?j8Yt6g2C3na6bRQvgx1I6umyn6KYWz3Vpkc6XzwCrWoroBfuofc+AciCpJUV?=
 =?us-ascii?Q?USpDC4um1hKdX68w4E9odXSwObpoZVrVTLFF9Ctk8NcVuGlXPL22f1X5hSFe?=
 =?us-ascii?Q?1esPM5ORkMuHurn5x5PyYeAT38d2+Jv1FjFQpyNYqQezoKhgzhzd3UbLWR+b?=
 =?us-ascii?Q?btOHmshosIx+SXFTllQeB2E6sZfX9OP7uxi0ttrpCJDZ6grGOtoxuW+EQAsG?=
 =?us-ascii?Q?FlfowYgkcFZFkGgB8UKDzZ/Zc4gEM6mddktfihYvcv/72Fot3DnNQM5EH66l?=
 =?us-ascii?Q?HaIi+hvwjXvTDK/i3FVTV9eGsCWap4tWVzzrQLFQBWYV/0yYn4YJjLt1VZTi?=
 =?us-ascii?Q?qp+A1VVGTMOvZGY/Pe5Trcf+zCqwP8FjytMCqEx1bEfMDevKjuFhWhRybAyx?=
 =?us-ascii?Q?wYJUozFFJOcCaKUYxYneew6bBxpvQYpm9ls7Wt7BdPYNfKz+b3AEeAIOx+2x?=
 =?us-ascii?Q?zXwEcKfoMnaOX8dFlsp1U8xM5eokFQOZMJm2Tvy0XY9sUT9IhnCVomfNPTdT?=
 =?us-ascii?Q?R/liJ+CHTdFGremdq8RlfOd8EBgtERUkre2ZcpZCMjKStOUhBjnnswH0DYT8?=
 =?us-ascii?Q?Ownw5kW9W4C6mg2lCvzh+V+lmPje7MhNDda3yUWJ8mavjCK/M7Yg9UCAGRCs?=
 =?us-ascii?Q?tIx/N141eqHiLl8avFdDXNdgWBgMoxq2mAD0B3oNOC/XtgwBKxVzBiamM60m?=
 =?us-ascii?Q?7umIXadEHzAql8R6G+EMQkG7mRsGX02FTWEEqy7XCrlViLunE6l2QmNnYQUa?=
 =?us-ascii?Q?bchrhG7OqBlll+41YEsmy21FzyHfKsFJCYpCyY2f0c+DTXUi4acLn6X+9+vQ?=
 =?us-ascii?Q?Yx0bAzASw5e3Un+IPkuTsLHmi7aqiFCkaMvUptcm9ztVpawUEKPGoGPrX2U0?=
 =?us-ascii?Q?BUZF1M9tsocnGKBUsLYfE+msOMdmj2zK5LIH77C0/gavwam3qAE+JuDhfm+P?=
 =?us-ascii?Q?wy/UxWmPFVUGyuzT2XzHO/X6X3GwLqs7i0/d/sgPoOkQnzRtGG3911lUZxof?=
 =?us-ascii?Q?CS2D0tPSKcgdTVe2zdMBb7S2502YYLnMsZ2DdMfjQWsIJqLmFj9QF7CCBlbC?=
 =?us-ascii?Q?jcz9lk/hbFpOb3DbxDkpjY/9jvjDGtHdii3xRgOQUBQgJSVI7xXGmWPIux0H?=
 =?us-ascii?Q?fUGKxFD4t0IlI0foYaV1cxtwHV/ZnTr/d6+ENniCfGn/6i1MNXXHrqx5vBxU?=
 =?us-ascii?Q?FpB9wLj+rhe4kUZqiJdxm/YRUuySeRO5BqW4occ2+IB2infyBxVQzYbjmNJ9?=
 =?us-ascii?Q?fLX/i0+pZTNFqFrKTAX6RFMNTc8kq8xXtBcv9Q0BuvawwkH/GmBrRvLr5i2E?=
 =?us-ascii?Q?214aLDe8RQtQkgomlL4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178e2a15-4278-463f-3b4c-08dd8705bade
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 10:08:03.6030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKABl+TtjsWsMY2BwvZ8ZPkpf+iPCJCCfuL4oyBK1v+1pybCJuiD8hRzy6Y5sGvG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, April 29, 2025 5:04 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, April 29, 2025 4:53 PM
> To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Xie, Patrick <Gangliang.Xie@amd.com>
> > Sent: Tuesday, April 29, 2025 3:01 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick
> > <Gangliang.Xie@amd.com>
> > Subject: [PATCH] Add support for leagcy records in eeprom format V3
> >
> > After eeprom records format upgrades to V3, records that have 'address
> > =3D=3D 0' should be supported in NPS1
> >
> > Signed-off-by: ganglxie <ganglxie@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 73
> > ++++++++++++++++---------
> >  1 file changed, 48 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index e85143acf3a2..4f4e12452ecc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2881,6 +2881,17 @@ static int
> > __amdgpu_ras_convert_rec_from_rom(struct
> > amdgpu_device *adev,
> >       save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
> >       bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
> >
> > +     /* if address=3D=3D 0, the rec must be a PA rec under NPS1 */
> > +     if (bps->address =3D=3D 0) {
> > +             if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE) {
> > +                     if (amdgpu_umc_pages_in_a_row(adev, err_data,
> > +                             bps->retired_page <<
> > AMDGPU_GPU_PAGE_SHIFT))
> > +                             return -EINVAL;
> > +                     goto out;
> > +             } else {
> > +                     return -EOPNOTSUPP;
> > +             }
> > +     }
>
> [Tao] better to add an empty line here.
> [Patrick] will add this empty line
>
> >       if (save_nps =3D=3D nps) {
>
> [Tao] is possible that both "bps->address =3D=3D 0" and "(save_nps =3D=3D=
 nps " are true?
> [Patrick]Yes, all of the "address=3D=3D0" records have save_nps=3DNPS1, s=
o when loading
> the records in NPS1, save_nps=3D=3Dnps. But it does not matter, I check "=
address=3D=3D0"
> ahead of "save_nps=3D=3Dnps" , the code won't go to "save_nps=3D=3Dnps"'s=
 checking at any
> case.

[Tao] so how about this if structure:

If (save_nps =3D=3D nps) {
    ...
} else {
    if (bps->address) {
        ...
    } else {
       ...
    }
}

> >               if (amdgpu_umc_pages_in_a_row(adev, err_data,
> >                               bps->retired_page <<
> > AMDGPU_GPU_PAGE_SHIFT)) @@ -2889,6 +2900,8 @@ static int
> > __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
> >               if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
> >                       return -EINVAL;
> >       }
> > +
> > +out:
> >       return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
> >
> > adev-
> > >umc.retire_unit);
> >  }
> > @@ -2903,7 +2916,7 @@ int amdgpu_ras_add_bad_pages(struct
> > amdgpu_device *adev,
> >                       &adev->psp.ras_context.ras->eeprom_control;
> >       enum amdgpu_memory_partition nps =3D AMDGPU_NPS1_PARTITION_MODE;
> >       int ret =3D 0;
> > -     uint32_t i;
> > +     uint32_t i =3D 0;
> >
> >       if (!con || !con->eh_data || !bps || pages <=3D 0)
> >               return 0;
> > @@ -2924,28 +2937,31 @@ int amdgpu_ras_add_bad_pages(struct
> > amdgpu_device *adev,
> >       mutex_lock(&con->recovery_lock);
> >
> >       if (from_rom) {
> > -             for (i =3D 0; i < pages; i++) {
> > -                     if (control->ras_num_recs - i >=3D adev->umc.reti=
re_unit) {
> > -                             if ((bps[i].address =3D=3D bps[i + 1].add=
ress) &&
> > -                                 (bps[i].mem_channel =3D=3D bps[i + 1]=
.mem_channel)) {
> > -                                     //deal with retire_unit records a=
 time
> > -                                     ret =3D
> > __amdgpu_ras_convert_rec_array_from_rom(adev,
> > -                                                                     &=
bps[i],
> > &err_data, nps);
> > -                                     if (ret)
> > -                                             goto free;
> > -                                     i +=3D (adev->umc.retire_unit - 1=
);
> > +             /* there is no pa recs in V3, so skip pa recs processing =
*/
> > +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> > +                     for (i =3D 0; i < pages; i++) {
> > +                             if (control->ras_num_recs - i >=3D
> > + adev->umc.retire_unit)
> > {
> > +                                     if ((bps[i].address =3D=3D bps[i =
+ 1].address) &&
> > +                                             (bps[i].mem_channel =3D=
=3D
> > + bps[i +
> > 1].mem_channel)) {
> > +                                             /* deal with retire_unit =
records a time */
> > +                                             ret =3D
> > __amdgpu_ras_convert_rec_array_from_rom(adev,
> > +
> > + &bps[i],
> > &err_data, nps);
> > +                                             if (ret)
> > +
> > + control->ras_num_bad_pages -
> > =3D adev->umc.retire_unit;
> > +                                             i +=3D (adev->umc.retire_=
unit - 1);
> > +                                     } else {
> > +                                             break;
> > +                                     }
> >                               } else {
> >                                       break;
> >                               }
> > -                     } else {
> > -                             break;
> >                       }
> >               }
> >               for (; i < pages; i++) {
> >                       ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
> >                               &bps[i], &err_data, nps);
> >                       if (ret)
> > -                             goto free;
> > +                             control->ras_num_bad_pages -=3D adev-
> > >umc.retire_unit;
> >               }
> >       } else {
> >               ret =3D __amdgpu_ras_restore_bad_pages(adev, bps, pages);
> > @@ -
> > 3040,21 +3056,28 @@ static int amdgpu_ras_load_bad_pages(struct
> > amdgpu_device *adev)
> >               dev_err(adev->dev, "Failed to load EEPROM table records!"=
);
> >       } else {
> >               if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)=
 {
> > -                     for (i =3D 0; i < control->ras_num_recs; i++) {
> > -                             if ((control->ras_num_recs - i) >=3D adev=
-
> > >umc.retire_unit) {
> > -                                     if ((bps[i].address =3D=3D bps[i =
+ 1].address) &&
> > -                                             (bps[i].mem_channel =3D=
=3D bps[i +
> > 1].mem_channel)) {
> > -                                             control->ras_num_pa_recs =
+=3D adev-
> > >umc.retire_unit;
> > -                                             i +=3D (adev->umc.retire_=
unit - 1);
> > +                     /*In V3, there is no pa recs, and some
> > + cases(when
> > address=3D=3D0) may be parsed
> > +                     as pa recs, so add verion check to avoid it.
> > +                     */
> > +                     if (control->tbl_hdr.version < RAS_TABLE_VER_V3) =
{
> > +                             for (i =3D 0; i < control->ras_num_recs; =
i++) {
> > +                                     if ((control->ras_num_recs - i)
> > + >=3D adev-
> > >umc.retire_unit) {
> > +                                             if ((bps[i].address =3D=
=3D
> > + bps[i +
> > 1].address) &&
> > +
> > + (bps[i].mem_channel =3D=3D bps[i +
> > 1].mem_channel)) {
> > +
> > + control->ras_num_pa_recs +=3D
> > adev->umc.retire_unit;
> > +                                                     i +=3D (adev->umc=
.retire_unit - 1);
> > +                                             } else {
> > +
> > + control->ras_num_mca_recs +=3D
> > +
> > + (control-
> > >ras_num_recs - i);
> > +                                                     break;
> > +                                             }
> >                                       } else {
> > -                                             control->ras_num_mca_recs=
 +=3D
> > -                                                                     (=
control-
> > >ras_num_recs - i);
> > +
> > + control->ras_num_mca_recs +=3D
> > (control->ras_num_recs - i);
> >                                               break;
> >                                       }
> > -                             } else {
> > -                                     control->ras_num_mca_recs +=3D (c=
ontrol-
> > >ras_num_recs - i);
> > -                                     break;
> >                               }
> > +                     } else {
> > +                             control->ras_num_mca_recs =3D control-
> > >ras_num_recs;
> >                       }
> >               }
> >
> > --
> > 2.34.1
>
>

