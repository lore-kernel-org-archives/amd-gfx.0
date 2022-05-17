Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9C2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 14:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680B510E077;
	Tue, 17 May 2022 14:06:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E42610E077
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 14:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQo1QOiEriikfUVs/ng/VboadfBnB6GbtzyIBqUjxcpT5w5DlDQ6yzxrWzi8hqWKq1eXIAVLCujEAJbtsTCYR2W0D6QehwKLFFwEJH20ZhTiiaVWNyIrUGfpIf2qXQLbmvLLvzMFPLPsNzIxWPZN9DP1lPqf0IHyr7NFitFzfQexGbvKMh7v3OWCWKxh/Js1Jcyc7aAej7E+zpbo8S9EXgYCUdP1QWpdBEAJZqGFdIqLb6yZdn+ablUUFcSaL5+AXdhe6qSxyOr2yuh0F10egykVeS6xu4NYKWpQZ1wtuzcf8eL6xajNodowiqnEzR9c6S9Ceo95CJxYeBIKbXI6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOYb9EctsVPTZ0KUByyth2Ug7S1GWLu9a3SfYjqNZQs=;
 b=ZkucauVH2aDBGwIIXCerByY1EpVR4U4SqbMPAc0iHFOAV43sjf8w6yzESbPBzmwvh8KCgSzrPoRu/WANxgW2z/lV+BdsHL9W3OAurFLRR6gcssMsge7g7Gx9O1YUqOt9sKo1fKIGI6PTufbC43bn2Ha+MjYDjghiQQVopUXdUzNDU+vPhCIzU6Am/HMqhNA1FL6ea4zOhPMekPuRTVFz2wS7FTL+4nMIR2bHYS/QnIyZh1UO3cgwhZ2zW0pmn2PJQNRchZcIUDH4szFBRiE74ytejJlNTTkCO4EJogZusAoF0X/k5gvymfPYkgD99S22zO8pBzpUQfqpqEK5juOaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOYb9EctsVPTZ0KUByyth2Ug7S1GWLu9a3SfYjqNZQs=;
 b=ShovFWynEiHhmfwHE2ag3X3bmxcN5qQLCLtF9XEi+iEXRAEGcABPLSF6u7ABLrJ1qurMSYZsrkn9USPasrzaHDOYqN1laRGpG1VgpbVAAhoP4WyMeZzJS80JAXhzbJ/Cl9WhrP9tXkqKOXTLhFRCwD2NtFa9ghlu7V5BHLXbLXo=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB3766.namprd12.prod.outlook.com (2603:10b6:610:16::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 14:06:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d42b:7413:ba19:e8db]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d42b:7413:ba19:e8db%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:06:48 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: RE: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Topic: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Index: AQHYafOSaEN0/701nU+0Pi+gyRxwTq0jFCcAgAAFHIA=
Date: Tue, 17 May 2022 14:06:48 +0000
Message-ID: <MN0PR12MB6101503EA34F43D880C203BFE2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220517133944.25612-1-mario.limonciello@amd.com>
 <CADnq5_OT9RkdSOW7vnT6+g72wENDr201taaHTs5op9kWApgeNw@mail.gmail.com>
In-Reply-To: <CADnq5_OT9RkdSOW7vnT6+g72wENDr201taaHTs5op9kWApgeNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-17T14:04:51Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a45e7cd2-a278-4e68-bb3a-fae83e630c91;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-17T14:06:46Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ca66dcbb-4fd6-48ec-9451-3abeaf053ebc
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7077be1-1c02-4a48-0f2b-08da380e7be6
x-ms-traffictypediagnostic: CH2PR12MB3766:EE_
x-microsoft-antispam-prvs: <CH2PR12MB3766B54F73F605B43047FAA4E2CE9@CH2PR12MB3766.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aw6iOfAW5j7qC/niOio0PkdHQoYn0cxu7Zgiou2HWouG/nZxRoxCRZSTPtpmPj7pG8FNybRcJ7SqIhkAvw0JqHaKV2Zr8Gb6T5VJO5uLc5300SLZFyHiU0Odo6Uo86RjfzRJX6PETkkAMBfIDlJ94stikVZKiJlloxx0tK31QinyzABGuPEDmmzzy3ivTIc4zjWieSyLxh8P8L0kC0pOZ6Y10fS04TArBex1P6WgxIUW1Z7sFoVPTbt5pU4xMO8kHAV4FYJFtFSQfEm2yCJ+6+HVxBQ4Wj/ReLCg/c/YdoGOwNxhGSOWN5y7Y86222QkW9WyiCzzCsuf5fDB5L3uxGjReMWKx7ChtJB+TqYeS4POHAdIrmYrVf+i+s5QasNcFFdxPB/zIycZx8WXirFJs8DWXA4df1h1NPb+ny8pPAu/7DbyvdISIJoHUowOZy8kRx5v8t1GfUhUb1LjNYdQMzZQ+aH4XRCBX6EY+FzgZe01Mcq1IzmGlsJUF/z6xrt4SrZiYjXivaalx0nm5QPq3bLoNHNLbwxbPOwQc+CqpCamNd0s/807DzlbwCrh6BrEwSBofHi+CRt6bckViIo03W2mAfiztthhEOFItKgLguhO0tTBhG1ufj5XoN7fqmXcjOY0ePDqAG9oR97ufIWrcu74gUWY1bq/9VwPpQ2nuqaLE01ypkGw3B3DiYnzLt0ataTt/JTM1PLkAniIaFfeA10jFOILqbBKo5QDB4P/DkpB3jNM4d6Sq1ehHvKyPbRAvCuQ0f2KwZ00NJsdKHsaADryDvApcI8O6/Mzj+JlKsY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(5660300002)(71200400001)(9686003)(52536014)(83380400001)(6506007)(53546011)(186003)(8936002)(66946007)(55016003)(7696005)(316002)(64756008)(110136005)(66556008)(2906002)(966005)(45080400002)(33656002)(508600001)(8676002)(86362001)(122000001)(4326008)(66476007)(66446008)(38070700005)(6636002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T5b2dPzy6purVGvtauXW5Yw8g/QG923SkUHjrE3VYtoNBcdEoIa4SFM+8DdE?=
 =?us-ascii?Q?XMnEMw0/9QOkFzJWfR8Z6uyb+WKhb9JA4Pit36Ifi7GzhBVoag4c5CuERhI0?=
 =?us-ascii?Q?H1ItZtoFnUWy5TaDoyfL0CN9RWQs6HXsm10o9RJEr45EWfFBgfgMPSDXw0iO?=
 =?us-ascii?Q?2yYz2d7MRveoeMuMHYr+quS1TMztkJtnvPrRcADFOmHY2B+dUEj0yULOOfOp?=
 =?us-ascii?Q?Bl1z2trAQMJArnLd6fid+/q2symdeBgQhFxzk6AhpaHAlY2ZdTQtowGcENFp?=
 =?us-ascii?Q?W1hYCnjkA3Ih0YwYtIHD7bmQQKHUiSDIyxeP6efo6QlmF3ZJAKU6I0UtojRj?=
 =?us-ascii?Q?XPZ/RpmOpDmza07+OBML/BDjvsy0IfluWcSG+9VREyxWG7j4A+tQNnyCzPdA?=
 =?us-ascii?Q?s/GIB+hg6VpShfK+X12Oibe4Mkx21eJ06hihktGh1Nx1PBPAtzb+/96U5O0L?=
 =?us-ascii?Q?Aot1IQPgn18FOX4JoKsqNTux6lXbttQxkFfNQJwcHfMgNV8m5gu1ZdhX/Qn/?=
 =?us-ascii?Q?D++zNQXeCSdumHYdc2h0ivqakQpMJ5IZUjnXYzLRbBhqifh1x3pOvdGhi+8j?=
 =?us-ascii?Q?3O1ERxmobH9kzMT8HC/8QoQue9v9azCZNUvAE3edzqceij0taahoFO4X3T+R?=
 =?us-ascii?Q?vbiARNImC0f+hMu5FFs82XHXCRl4wHKUPyIVCBc8y1NXL2mnm+sbxMQ6pPh3?=
 =?us-ascii?Q?idZpwfFiPux1hLrqZIPVHkeLPfAZbwHBbwsY2jSYwWDK1IEr3q5CV7aFoL8t?=
 =?us-ascii?Q?4ikx4gAKD5MsQ3KlfzuR292sYU6b1mX/6IXHVdajpV/KmsgclKopqtgmeWyf?=
 =?us-ascii?Q?XeZUfpRbHk5ew4WGxLOGGQs/4ZuzmGMtxEO/Pz0X9KzEt1DrpHUVbj3KyIKV?=
 =?us-ascii?Q?wTIFGmSkif0K3ThNIM2A84R/bzbOwdAPmtj8da8U03A4FCK7iQ47BbXBGjDL?=
 =?us-ascii?Q?mI/psrW2trGMnKHqVVc66v7pn0GmL40g5iqdcDOq+HZl6iKaKWbNUdV7Orib?=
 =?us-ascii?Q?SCmOmSgJvVIMmQKaiknIIzegb66UOZ4fzb7KuiV+Nu6vf4EWYWbos4OS7IFf?=
 =?us-ascii?Q?IHcc7XFU1Lbrh1Vjga8zv4DB+lUFXr0M4p24nVFJeftDVi5zKyoyH7nI4FGX?=
 =?us-ascii?Q?eAhZrhwMXNqZ/p52PbF2J2x9NM/sGrbLJmDcUqooXIzIJYK3+RlxMhSX2TvB?=
 =?us-ascii?Q?7/X60H1PXybT2z3QT/wto5rB7SIrVw2/44Yi6Z+ZgL3qnMEJhrf4dO+3uUrh?=
 =?us-ascii?Q?wVOtsY8aoyqaiXWeGF6fMF0hoNukfveGEztygna+0zCSUR8+q7tcm6jx9X4j?=
 =?us-ascii?Q?P2N10e8wI2isIM7Gcxbb4oa6N9CHb2PETu2pRcTyQVZT4A9mIL0LYWsPiROy?=
 =?us-ascii?Q?X5lCYfBI/jISu6vvx/UkJzmWAWAouLmUyGzRDc73sHp9qY8QKUitk6k4jdAx?=
 =?us-ascii?Q?qW78dQKLFTBSfUG8sGqGAMMMhYogrQqt0czUWTCter9DXELiPummQKDhtcRN?=
 =?us-ascii?Q?FO2U2DQpTWkcwSZGHImVUNWw7+gwUziH6u+LR7IzaQakrLPjdvWXFbZLHhgh?=
 =?us-ascii?Q?53vfdT1hYw/6w/kskPBp/s9Dih23Cpi04o0B20BDtvdtO4UDMqe4O5gm/lxN?=
 =?us-ascii?Q?DhFy9kv3kVUlcqdvK8sJVWTC8T+prGdjiD2vMVy9AN763M4Ynaxe9Bx0XRh4?=
 =?us-ascii?Q?nnVsWMsiFWkExjU0OQ7kMjFVfczsQ4cMNJiWBkDvU2a6Zbaz7Fug6ouu4EuX?=
 =?us-ascii?Q?3z7D8gTJqhjeaA7Rwhj6FhrRM4c98UlYNeexKswUXtLjyvY4S6ntimeOrrEf?=
x-ms-exchange-antispam-messagedata-1: basgdMY+DNRubQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7077be1-1c02-4a48-0f2b-08da380e7be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 14:06:48.5094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VVQU0SAQmmn4T+TCf0p3tkou4m8uFtwWcE4kLmB7hRbsZNwhixPfE62biEJgCPjjCXD4gRi0IGucbbTKfOVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3766
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, May 17, 2022 08:43
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
> s2idle
>=20
> On Tue, May 17, 2022 at 9:39 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > An A+A configuration on ASUS ROG Strix G513QY proves that the ASIC
> > reset for handling aborted suspend can't work with s2idle.
> >
> > This functionality was introduced in commit daf8de0874ab5b
> ("drm/amdgpu:
> > always reset the asic in suspend (v2)").  A few other commits have
> > gone on top of the ASIC reset, but this still doesn't work on the A+A
> > configuration in s2idle.
> >
> > Avoid doing the reset on dGPUs specifically when using s2idle.
> >
> > Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend
> (v2)")
> > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F2008&amp;data=3D05%7C01%7Cmario.limonciello%40amd.com%
> 7C38a880b8d03147194bb608da380b3142%7C3dd8961fe4884e608e11a82d994
> e183d%7C0%7C0%7C637883917968950850%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&amp;sdata=3DlNeeucWFganu9GLey2YAqXfgbYT4DUBb
> fQA6XuwGslA%3D&amp;reserved=3D0
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>=20
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> But I think maybe we should just drop all of this in the longer term.
> We are slowly dropping every case where we reset the GPU.  I'm not
> even sure it actually fixes the issue it was originally added to fix
> at this point because the actual reset has moved to the no-irq
> callback which will most likely not get called on an aborted suspend
> anyway.
>=20

So perhaps for now this patch and in the next cycle or two maybe folks who =
worked
on the aborted suspend case can try to trigger an aborted suspend w/ dGPUs =
+ S3
and see whether it's actually working and tear everything out if it doesn't=
 as you say.

> Alex
>=20
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  2 +-
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 3c20c2eadf4e..9cf3d65f17d7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1378,6 +1378,7 @@ static inline int
> amdgpu_acpi_smart_shift_update(struct drm_device *dev,
> >
> >  #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
> >  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> > +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
> >  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
> >  #else
> >  static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device
> *adev) { return false; }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > index 0e12315fa0cb..98ac53ee6bb5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1045,6 +1045,20 @@ bool amdgpu_acpi_is_s3_active(struct
> amdgpu_device *adev)
> >                 (pm_suspend_target_state =3D=3D PM_SUSPEND_MEM);
> >  }
> >
> > +/**
> > + * amdgpu_acpi_should_gpu_reset
> > + *
> > + * @adev: amdgpu_device_pointer
> > + *
> > + * returns true if should reset GPU, false if not
> > + */
> > +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
> > +{
> > +       if (adev->flags & AMD_IS_APU)
> > +               return false;
> > +       return pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE;
> > +}
> > +
> >  /**
> >   * amdgpu_acpi_is_s0ix_active
> >   *
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 16871baee784..a84766c13ac5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2315,7 +2315,7 @@ static int amdgpu_pmops_suspend_noirq(struct
> device *dev)
> >         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >
> > -       if (!adev->in_s0ix)
> > +       if (amdgpu_acpi_should_gpu_reset(adev))
> >                 return amdgpu_asic_reset(adev);
> >
> >         return 0;
> > --
> > 2.34.1
> >
