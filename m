Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87031C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 17:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036DB10E18F;
	Thu,  6 Jun 2024 17:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u4FEtYL0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBCD10E18F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 17:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZqMuupx4UdPVWjXfPAeBfqWgw21cCVrYfGh7qR9VythBgUkdMOdbJ/yNopxnIpRJ4lZYaVi3Dm/e08RFjvv/382/j0DBYegPc6ucnVcRvGZzB2sZxa4SVIimZhCx8Ui02A4oGRBYHNc4iCKolsagF1q0Y1psl7QPO3ra9qRHKCizVbaejUG+W/5KQV12BPCd+FnfavIDPbUuNBmiABoMOCSWl3ES5M16NsIg4s9qoramUpI0Czm+69LvVSf6x1WSc/8hs1HcPD7+yELdCrdEyk5h1kwhTQPJyRIOseFJaPZbuzI4pe4loF2I02HVvScmjdEoXbQxpf/r6yO83MH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeOSfI/7HVmIdC8Xq7j1TVKq08zs9MeMWDd2TUegUQo=;
 b=m9laaR9z11xOJxd3XlQqiTCGzUq9Mn1vD7GIY6BD3qvBBnvQEImupJik+NKQ8NLLoxH3tj77DQl+X8aV0n/4KJjbbXW8AOErCWmzELPWC315ZWlfZUIwaWNEj+UV4wbD5Rwq4gaQ7+CIlkc0lvoIWd8oYrrjONXs44Ff6IkXLXwNO04bNbY6Vgru1Ga7nW7IldPh7NtelLb3NZDwo1kIcqnKQc7lgXw/qAglmiVhUTaGBByBWKOmcT68swZCXKW/M7RXrBaBPsElYwM0sV1qQrm3bpUx24IQjQaEoprxSM5LfXzWUR3NhZ1VIPPSVrBcS6SBv7aPFnXz8HQoTpd2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeOSfI/7HVmIdC8Xq7j1TVKq08zs9MeMWDd2TUegUQo=;
 b=u4FEtYL0Qh5EZOz8Rq7GPXj1oFwIscULO/1/7DA/hFHeI9AR8z62sPPgJAec81vFsdu38fVepjcvuR9DEiSOEQzY1NgR2S6VKZvIq0IxmIzqk1RmnjRBX8Kn49m7niZlWLUE2tEZ1JcFdwpSXF6ExLzlu/EWa7IjnRIgHH+MR6w=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 17:11:06 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%3]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 17:11:06 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add missing locking for MES API calls
Thread-Topic: [PATCH] drm/amdgpu: Add missing locking for MES API calls
Thread-Index: AQHauDHOo7jhbrPU70qWLm56mtIcaLG69JKAgAADsDA=
Date: Thu, 6 Jun 2024 17:11:06 +0000
Message-ID: <BL3PR12MB6425899B9E10D0770C78A375EEFA2@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240606165100.2821320-1-mukul.joshi@amd.com>
 <BL1PR12MB5898C513B0D9E4801B920F4185FA2@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5898C513B0D9E4801B920F4185FA2@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cb56e961-e762-4d45-8e07-835299815ad1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-06T16:55:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SA0PR12MB4383:EE_
x-ms-office365-filtering-correlation-id: 84295a61-761c-4228-2674-08dc864ba720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?xZgoG67vWDgz6dkihPTNDZCvAK17BEhStxAVu9oJPwfR6irAQ7qonk+Tyjub?=
 =?us-ascii?Q?ljThUvxsjUjRQOt3evqFgCY8uzTkrGXSObPSDwbDHo10w/XbaTi1JC/Agve2?=
 =?us-ascii?Q?RauGXjEmcHo3NGSwv9boIp6XFdLwpr8VgUBbjREyBTtpp1SFj8zdFzlvvq9t?=
 =?us-ascii?Q?tiT5trNxuFrIkqMUZ3L8DWXxFQIQPYQ/5FsCtsq4F0bJJl7wipJPKJ/cdGP1?=
 =?us-ascii?Q?8m7eJK9zqe249cBJY6WRQt9efIiQeQbwk7MC2UHLJ6HAUXZDXolmc7bbwArm?=
 =?us-ascii?Q?zarpzAjJiSFN6Lx3Hk1vGFDCmcfdPwxlyzQT1sHazss3+d7WDvCm41aeqqGJ?=
 =?us-ascii?Q?Y5vLehF2YMs1ZHz0l419z9EG+57HWkbYd/YV9nVAmkUoyk4Rk1/IV9klzBYj?=
 =?us-ascii?Q?hYb31WRfY91KlEwIvCG1waFsXtUXY5ylNT0pSnR1bpY2cbsUXTYzz1tG0YOz?=
 =?us-ascii?Q?ENgeabN/Wrg7Ob8F+21n9ITqRkNfJ2mzy0PzHqEoBSyk+CtHbjYw+K4eMGv2?=
 =?us-ascii?Q?FpGuPcf1tUkjMxSY95gUVT3I2EDNDQR5W4nipRnZKnI38K8L5KmxHWJAf/GA?=
 =?us-ascii?Q?xkFnPkYz/a6v7eYBeITra10O56DxU58a4ssYvhUX0bXPZTGBzz1NE4Mz50o4?=
 =?us-ascii?Q?avXz6sll/gxW5/r5Njw89cDEarDUkdt8DP4DuGHrDFTbFOhcGPezVinJ/vsT?=
 =?us-ascii?Q?GsEixDVVMyBMYnxMGyjuVPns8InEtFrLaEUoIjwTMnI/TM3riMcLaSXYRHHV?=
 =?us-ascii?Q?ucLoALchX30lR7nW+MmcYO+tnD14CFm1ZLDovRpjBhzwpHxRqTiEW8ji420Q?=
 =?us-ascii?Q?X7NwdDyjCQ1IhaNCETlTDzq0ti7iJ9iDCLhK8APaNUgNAbcFexaWqQinQkvw?=
 =?us-ascii?Q?szswtQuNMeeykD9q/UjFGBzv2AufcEnPlS/LLClZVSoOJ2V9pNi9q4Qhmpxk?=
 =?us-ascii?Q?sjoBQzrjDMfBtIioQK5jj4TvcNlJDq+nPHQtdyItQqo8QUbzK97d28fMcKCu?=
 =?us-ascii?Q?C5fT+9Svolz37SpJ3Lpn7biAZSGI6eIeZaU41SRrAkxhywA60sO2WHfn1FgD?=
 =?us-ascii?Q?HgZkEHdYA6lC1o+eFtWgilLFC2Ws8J5RwlNr883rGZxssXORb0XwAyvOUQE/?=
 =?us-ascii?Q?JFrjdr6JM9AICyx1QJuP0/WBmSgpzCgQpXFsZ5FsPGyyHbYrubSvWJKlku9n?=
 =?us-ascii?Q?oVf0SMATY5+16br7IvOKiYHacapsDnT8DqdjxwDzfRaoZth3tlT3jk2Hrcna?=
 =?us-ascii?Q?HLbBwU1oq11O62F+Z3q6cEGmJKPtimDK0KlOVNOeOrttIhWT50ZEfvkFeDRY?=
 =?us-ascii?Q?RjaqIXqWZ2qO7CDOe/1LNCICM/JxpcEf6PSLRVparR3vYEHeBmd4pZ7pUec2?=
 =?us-ascii?Q?xzyd0p4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gvb3q0yD/gPk+l7yExUmB3DMvQt1X4Bcu1B35+wJZ87xy+Iy4a4grt+ewBku?=
 =?us-ascii?Q?pOQlpBHmpQGjG9seZWit1uDZMQVqYezTtXDIUW9jhyMooywocjWlxy+QgDeC?=
 =?us-ascii?Q?hWWgTu9bUboX1oXpIiIH9UFZMmaTGaYIRY4S2THDPFuvM4HT5pZg8yls73bZ?=
 =?us-ascii?Q?xxfo7pVaz4R+6q7yaBxoGpLHpGUuLx/EnjDizw0uYZkApSBWfsh94/QmXG70?=
 =?us-ascii?Q?HyqG0xPKtLsJezhMbdyGMjDnh2qqsWPtNzo9xHvUoTOyWUZj972NRZNmebhp?=
 =?us-ascii?Q?Y1tfl45+EoB3by4C1ApvTB/QFHDr0mQtfXsSnp1Mdvmudn+Lz1hs2GEBMqbA?=
 =?us-ascii?Q?WtlXQ1dU1ULCxBDEn7NN0qQwEBfjAetOsCIGI/tPCma6KEdGgnpEuCnFy5U4?=
 =?us-ascii?Q?5IhtdOZFON4wJ1z8yrhFc9YOjGSsbtdCyEXTsmvlPTPF9xjiZviMYdOeVvvy?=
 =?us-ascii?Q?JXvB1etLhyFr9Zi/j/lT1Nj8+mLViU3CXCuMuLNDva4AQ3WKDsE8gkAbBsh2?=
 =?us-ascii?Q?K6gDaTbeyR0u5nSmjd3ks7+ekJbTUD6iXBIeCJiFfvgkDGUC9Vpq+yhPbQob?=
 =?us-ascii?Q?64vqZ2hHN5FCT7enSyEurC59IriIeLNsp7t/V/QriIJ7/RfR1r2bxsY4s7DK?=
 =?us-ascii?Q?f2HJRvD3KtEwYEtl3nRQ2V64/dhZXEmW4YdhJeEmSit7K6V4CjW7ETH6CInD?=
 =?us-ascii?Q?4RVbPElsAieuPaxItAUNjGKc6EgKBMURnKAfb+PBnhu6kjVLvAmF5MD826gU?=
 =?us-ascii?Q?jXRsM+RoPQ3UIYiYR01Y3F0fMw02SwmBaa1qfHAE8IRONhHT0XFL5x4D/tZI?=
 =?us-ascii?Q?pnx3ieunQZl0OnkgYN407N32PZ/uZg7j5bh+vJ0KcsPlb2RTQvdllX65UnUp?=
 =?us-ascii?Q?1ejP9Tx2vdJo5lNP8di1KnMogfEwbbKgRDm0RndTUqBQchPilp/HVIT6/0oV?=
 =?us-ascii?Q?6KlPtNgJr7AoYexITH7qa9pGt8OtlCKkNRJUhQL3uk9VBqDmciPFWmAZzQzG?=
 =?us-ascii?Q?wUg7FZm4nnzOGg6FKpCuXC3OYf8OmyiS/R1Wq/KfEYmGw0LxWBmg3wFcdRvr?=
 =?us-ascii?Q?qjr8z/VhiifpcsPZtADHNTr+fAd97swZb7iYFThnTW3bp0WLSKiVy6lQB/iX?=
 =?us-ascii?Q?NpvBOb5a3Ro2kphw+lbzs4RgKeQL0tH7bFjGC1FXkYVLiVav5nFAaZP8mUSY?=
 =?us-ascii?Q?MhCXY5H423hoZCcd7Ul80FOA+js/UHB9GI/KmH1CQVxP7W9KIQc0u9LwxASI?=
 =?us-ascii?Q?SJkdnyCdakFjaiEXnlRk6PWrSpe6kNzgW1j2umWBq2jY1gXLSR33JzbxbAn4?=
 =?us-ascii?Q?KLh7tryXQ9MxYGLlj6StPbNIzUpMl/ETZxSDKtOkZocmHrF1WQsmLWMMWj6m?=
 =?us-ascii?Q?fnfUIWSkQoB2dWAIN0a6OI6kjmorzk8uVTYMobChCDNq1eYWqXx9cml/CoM/?=
 =?us-ascii?Q?67U4uLRn612ScYApeWXJP1ND/CrEStD49fd67fn4ODmqDm1hR+gVLoDUeDFy?=
 =?us-ascii?Q?DZpOAlMTJXVNlZmkxOQBRqg4F2MaUmCHcG2dsWDzOfUZzmm068s+LRbfcJLF?=
 =?us-ascii?Q?Og6dEfdFLBLKiyt0m00=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84295a61-761c-4228-2674-08dc864ba720
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 17:11:06.4096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKevMZHnTL8ued6XQoDL5rFNNEtGbvouOfqMK57YG4IYEw1aRdOYULtfhJoMEptCKPsUoc0SHFyLA6HZx1GRIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Thursday, June 6, 2024 12:57 PM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Add missing locking for MES API calls
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Mukul Joshi
> > Sent: Thursday, June 6, 2024 12:51 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> > Subject: [PATCH] drm/amdgpu: Add missing locking for MES API calls
> >
> > Add missing locking at a few places when calling MES APIs to ensure
> > exclusive access to MES queue.
> >
> > Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index 62edf6328566..df6c067b1dc9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -801,7 +801,9 @@ int amdgpu_mes_map_legacy_queue(struct
> > amdgpu_device *adev,
> >       queue_input.mqd_addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj);
> >       queue_input.wptr_addr =3D ring->wptr_gpu_addr;
> >
> > +     amdgpu_mes_lock(&adev->mes);
> >       r =3D adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input)=
;
> > +     amdgpu_mes_unlock(&adev->mes);
> >       if (r)
> >               DRM_ERROR("failed to map legacy queue\n");
> >
> > @@ -824,7 +826,9 @@ int amdgpu_mes_unmap_legacy_queue(struct
> > amdgpu_device *adev,
> >       queue_input.trail_fence_addr =3D gpu_addr;
> >       queue_input.trail_fence_data =3D seq;
> >
> > +     amdgpu_mes_lock(&adev->mes);
> >       r =3D adev->mes.funcs->unmap_legacy_queue(&adev->mes,
> > &queue_input);
> > +     amdgpu_mes_unlock(&adev->mes);
> >       if (r)
> >               DRM_ERROR("failed to unmap legacy queue\n");
> >
> > @@ -845,11 +849,13 @@ uint32_t amdgpu_mes_rreg(struct
> amdgpu_device
> > *adev, uint32_t reg)
> >               goto error;
> >       }
> >
> > +     amdgpu_mes_lock(&adev->mes);
> >       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> >       if (r)
> >               DRM_ERROR("failed to read reg (0x%x)\n", reg);
> >       else
> >               val =3D *(adev->mes.read_val_ptr);
> > +     amdgpu_mes_unlock(&adev->mes);
> If we're following the pattern, this should go before the if/else block
>
>  Kent

I wanted to make sure read_val_ptr wasn't updated before its value was read=
.
That's the reason to put the unlock after fetching the read_val_ptr.

Mukul
>
> >
> >  error:
> >       return val;
> > @@ -871,7 +877,9 @@ int amdgpu_mes_wreg(struct amdgpu_device
> *adev,
> >               goto error;
> >       }
> >
> > +     amdgpu_mes_lock(&adev->mes);
> >       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> > +     amdgpu_mes_unlock(&adev->mes);
> >       if (r)
> >               DRM_ERROR("failed to write reg (0x%x)\n", reg);
> >
> > @@ -898,7 +906,9 @@ int amdgpu_mes_reg_write_reg_wait(struct
> > amdgpu_device *adev,
> >               goto error;
> >       }
> >
> > +     amdgpu_mes_lock(&adev->mes);
> >       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> > +     amdgpu_mes_unlock(&adev->mes);
> >       if (r)
> >               DRM_ERROR("failed to reg_write_reg_wait\n");
> >
> > @@ -923,7 +933,9 @@ int amdgpu_mes_reg_wait(struct amdgpu_device
> > *adev, uint32_t reg,
> >               goto error;
> >       }
> >
> > +     amdgpu_mes_lock(&adev->mes);
> >       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> > +     amdgpu_mes_unlock(&adev->mes);
> >       if (r)
> >               DRM_ERROR("failed to reg_write_reg_wait\n");
> >
> > --
> > 2.35.1
>

