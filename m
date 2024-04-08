Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6E9C67861
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 08:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146F81122AA;
	Mon,  8 Apr 2024 08:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yBODGUrw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2123.outbound.protection.outlook.com [40.107.94.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197021122AA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 08:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/Ar1Dd7kmv1ItFotPNDV7qBQkMlFhZEh/TSdF1rs1V8Tk1VWJhnSnKD75CL0Pn29Q5FrU31YhBYU/rQilmyyPmudEgx0WDmjg+uRexITuDl+mbfEGMuSSloNABaIppAtFzPo8qhXCWgAXsKari/nxG7tN3MdE4GH1HTDWV75KGr0MIFFdnhXaqwm5NsW0jURTO+N6AySFr6TzAVBoKMJ206i+JUYQDKQoFYeev0L3SNpC7B1Tjn2+QU8abw8EJZSxTTv0lYvoPD34qn3vXRADgb8jLr6CtsWEAwtwU+fUKHTs+NBOFV0ZYd93vbKKHZ0WSQlZy0lhG4uvAKuDgC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zIJltVOXlf71QgGDXyP8fzuoh864DmA/HXTsodZtG0=;
 b=k6tcybc9P7W/pdQHMj9iIbeYRKExnUbeu5gJRqkmaQH+ZDn6W1j/o0Fpr4s8UEvzU+3gVKdgKXY3VRtwvBRIAqDy1bFmW/ICrfwFXdOhcp/NS3tPG/lHc39bnfpBo3+jkPpt6aF9gd4s3XVGRj2PlEe2fBKE4Stz+En6JXwyl9LpHcIkJXyV9plo1v+FD7WtcUhTFdahvD8G3/txk1B5qN0f8e051BVqXQ7pb5JEvGuAAIWkFqaiaTBGkhaX2rPu06wINNZIpS1jxYMXjj4yEHhvASLPohgLLwkyQmieFX/3AGIlzhMZwTAz9Na0v0HPHqID+9nLoFv0aHlxUuIXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zIJltVOXlf71QgGDXyP8fzuoh864DmA/HXTsodZtG0=;
 b=yBODGUrwpFh974Y7FjQXKKLDJ0aDFlq/S035r0w0V6B/fOaF5HYQwAT9jvQzyet1LmcBomLIVe1lKkJmLSPJQsOKvkpDwKwlPsFJC4w44hZgLNOoersLWYAbPSQA+jbTDEK90wBA8pga/FxHrpCDuehXk74DzMwVC/kEiSVX6v4=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB7103.namprd12.prod.outlook.com (2603:10b6:806:2b0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 08:40:48 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 08:40:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Index: AQHahZWTSQEgzb5ie0e8rQ6E+eL0DrFWNozAgAXitoCAAfgp8A==
Date: Mon, 8 Apr 2024 08:40:47 +0000
Message-ID: <PH7PR12MB8796E1D39D10C0A043E731F0B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240403070649.685497-1-YiPeng.Chai@amd.com>
 <PH7PR12MB8796050C3FF06BCA9485BE06B03D2@PH7PR12MB8796.namprd12.prod.outlook.com>
 <CH2PR12MB42150FCCCFBB2D4AAFCC01CFFC012@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42150FCCCFBB2D4AAFCC01CFFC012@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a19a3b2d-bb1b-4ac9-b35e-0c78ab4d6bfe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-03T08:28:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB7103:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFQ3oxHEt/YwwUjYm09w25PUJ/GL3HFN0oaqcyKeseyjaCbp4dPSId8EoixpFutwYvGrHX/AzARXyo+LQ6ThyB+IRV3Yq7NSP+09QCxSgDQDVAAg0sl9MvipN901//wqAaYJYPgibeh/zGN+QC8+CXo2ySTjfvtCbW06J32t8duE3hq8L8CYjvJYaVcKmlajM+PbYDyIe/glWtZCdSLSk4Ew68ZjUt7nyBrNW0v2kP9zA/+l4zVIy9tpEs60+OMGKTMJRcqUYc/Xwf/xnLF1ALj1ZzpVmJFYAqAySvYNYQQODmDqUR6z+dOAAiGCjfa97VSrLlbVqWyDH+vogxqvoV592DQ0LUdraPteFupto4UEDX4IEWOQKSTjgg/fUrfVpMBMwjaR7vmsTSyGqr1vdkjYTnhBEv6Kevc71Me2jSWzrJ2r8ENy83hAP7/lml8Q8zgV6+TBSY5AZfJ/mfaYeus1oVfm0IUC23AmUrhQFGUYDikm9nT9HEYwMYdYnRk+xO1+cUBoaWrzrMVV7bX3gDWEqJXmfTsuoZC0jl51dofik4hXmzsT0WVQ40s9/ccNDALlF/LtR8tW3h9H/lIKwNtuKPBZrXPezZZ3FrXwxOzGvIxxza6S+Qac/zqxShYED+y1L6LR7Iut1nnKuhaPFgWb+qQOU+cVAE2sH+hMoRE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h23ATXK8YXdsUq3LeSHbjsjsqXEZMlvQtrn1kGDhKTYWsXj2h8Pm025PXzTQ?=
 =?us-ascii?Q?piV4ZOy8A16Hydirbckl1wDx+QS6CpLf0ZrLUhn2xq+z/ajYSpt0Z0jDN3lQ?=
 =?us-ascii?Q?cgI+gkHzbIb34wDw42GoyzR8twQWLD3iYSCn1NtSgBWHNX5MnC5wtOHF6sXl?=
 =?us-ascii?Q?QomMtonSkSSA3YC7vvbB+hNpvnH9QSzLmLSCvDJPlfh+D8NqCMwRiAuKEGe2?=
 =?us-ascii?Q?i+rKTQ0GWaWrbqQMhROpDF2+NpL/Ef6yXLdorEFXZ3h2Ejnt1Rvi1U/id6c/?=
 =?us-ascii?Q?wK4de5NPLIPpDTttnAw7bp5nK1+e3euv5xjO65LkaZhCJL3XrsPyhzpZMZn+?=
 =?us-ascii?Q?145ILbBDJiR7OEd/a0PK9HbVM3uUrD70krygRIU78G18v6fi5XRs6A/XZpfe?=
 =?us-ascii?Q?a3TQICLrVkQ/NRzQR9h6UHqvMG9q2gsgP11JtXgeJ4miqd/2BixWIy2KvWvS?=
 =?us-ascii?Q?1ne4TN74ZrXQX2bOYLjlUjWTdAT2/6QvD1+B/bf8gg/cZ4amqpYFr4P2bPIT?=
 =?us-ascii?Q?NpycevIBHAl4WQYe/j+K41SDMGRwTIsNYGhqpqAybepUWvUTrtphHSfWb3FX?=
 =?us-ascii?Q?WGyOt3JgSW8p4YbBtcZO/2QyN/baWUnmWi7vu3d0a1dQvFsEGusFoR43gFic?=
 =?us-ascii?Q?eloNWDl/vfHnFsnAS6IiCEc3SFkwdrIxLaabkEHM0ovjtBsqW/JmK+aW58fl?=
 =?us-ascii?Q?eB3snWVGg9G/LjEMbvhF1HVlDmJno2VFM8HmJNLhL4m7fAGnVE+2TH8Zj3ZI?=
 =?us-ascii?Q?8PtJwwa+V7eXE7X05nqQJKT450hi8/S20aU8GRK8zEfAZteesp1fs8ldGvMm?=
 =?us-ascii?Q?ihsGW2SKphLTvSduzBCOroLGssDwLrr3UlRo+1GeIIAuduseCfNAVjYyaSjQ?=
 =?us-ascii?Q?eFkKal/sC8MI8sVDPYMmUPh0fF/RXjUUkpElwQSolDN1l51KQe8RqAO3xlrc?=
 =?us-ascii?Q?QLGAabMQYfTPr9FBjFZCSihjZYemDYzy+lXZkQGba868tD2vjIgh25HAoGEc?=
 =?us-ascii?Q?UdipfnsxkmgbEzfkWSmd/a2QPjirtXeRkZWCjMBrD7V4Uv8mX+Jc1LUCXTbr?=
 =?us-ascii?Q?XOIVmdmPtNlww5SXFL98KaAsXEDQ23rYguhtEhWOcZPPiuyXt+gs++uA1dMS?=
 =?us-ascii?Q?BIk7lPaRLvuCMxPHpBksTNL6gMtIzJy/3c3uMaQG9EfOnwnqGYJ/kUDeCCRt?=
 =?us-ascii?Q?6fkzRPlGA47bHkjgZ1LzQ0rZoj5dZnaBwWmHDrgCkousHWl6ZVQYdt5Q4DV/?=
 =?us-ascii?Q?XXi0J86CxD67CS7vC4SW5wF/VYvCd0UlPGhCF7pkbFbxAutJocfaKnyU6RCy?=
 =?us-ascii?Q?LJKp32FyVwRakkl00gCMCRrl3Ojmatbl5pVbLyF+FSdkbUHvV23cLAxnLTmP?=
 =?us-ascii?Q?vhq9WlWnSico56DkxmOYvEM2i4Tz5uvmFDpFGdYr3teHds4ZSzJ+RSP/WWPf?=
 =?us-ascii?Q?h6ZcLLpH7H9QJY/XQjFoF/InlNZzJ/ygAHnIUdGdbb03bG/tmu86DNIOsXnF?=
 =?us-ascii?Q?jAxDYkdb+lBGHpsOoDfhf3Wh5B6FgEK2LGv8nWPlYsapl8EHVvAJQMUYCP+V?=
 =?us-ascii?Q?BQNiRxfnrFgVWJS7Tks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f656783-f501-479b-d6de-08dc57a796ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 08:40:47.9349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGiQXKJstxGaZ7JE2yoV0vqvYISFb/3ANToUfbrWh0m39AJU34qYyjDbuFxgtxIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7103
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Sunday, April 7, 2024 10:21 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value
>
> [AMD Official Use Only - General]
>
> -----------------
> Best Regards,
> Thomas
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, April 3, 2024 6:36 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Wednesday, April 3, 2024 3:07 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> > <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> > Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> > <YiPeng.Chai@amd.com>
> > Subject: [PATCH] drm/amdgpu: Fix incorrect return value
> >
> > [Why]
> >   After calling amdgpu_vram_mgr_reserve_range multiple times with the
> > same address, calling amdgpu_vram_mgr_query_page_status will always
> > return - EBUSY.
>
> >[Tao] could you explain why we call amdgpu_vram_mgr_reserve_range multip=
le
> times with the same  address? IIRC, we skip duplicate address before rese=
rve
> memory.
>
> [Thomas]
>    When poison creation interrupt is received, since some poisoning addre=
sses may
> have been allocated by some processes, reserving these memories will fail=
.
> These memory will be tried to reserve again after killing the poisoned pr=
ocess in
> the subsequent poisoning consumption interrupt handler.
> so amdgpu_vram_mgr_reserve_range needs to be called multiple times with t=
he
> same address.
>
> >   From the second call to amdgpu_vram_mgr_reserve_range, the same
> > address will be added to the reservations_pending list again and is
> > never moved to the reserved_pages list because the address had been
> reserved.

[Tao] but if a page is added to reservations_pending list, it should also b=
e put in data->bps array, and when we call amdgpu_ras_add_bad_pages again, =
amdgpu_ras_check_bad_page_unlock could ignore this page.
So except for amdgpu_ras_add_bad_pages, would you like to call amdgpu_vram_=
mgr_reserve_range in other place?

> >
> > [How]
> >   First add the address status check before calling
> > amdgpu_vram_mgr_do_reserve, if the address is already reserved, do
> > nothing; If the address is already in the reservations_pending list,
> > directly reserve memory; only add new nodes for the addresses that are
> > not in the reserved_pages list and reservations_pending list.
> >
> > Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 28
> > +++++++++++++-------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > index 1e36c428d254..0bf3f4092900 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > @@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct
> > ttm_resource_manager *man)
> >
> >               dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\=
n",
> >                       rsv->start, rsv->size);
> > -
> >               vis_usage =3D amdgpu_vram_mgr_vis_size(adev, block);
> >               atomic64_add(vis_usage, &mgr->vis_usage);
> >               spin_lock(&man->bdev->lru_lock); @@ -340,19 +339,30 @@
> > int amdgpu_vram_mgr_reserve_range(struct
> > amdgpu_vram_mgr *mgr,
> >                                 uint64_t start, uint64_t size)  {
> >       struct amdgpu_vram_reservation *rsv;
> > +     int ret =3D 0;
> >
> > -     rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> > -     if (!rsv)
> > -             return -ENOMEM;
> > +     ret =3D amdgpu_vram_mgr_query_page_status(mgr, start);
> > +     if (!ret)
> > +             return 0;
> > +
> > +     if (ret =3D=3D -ENOENT) {
> > +             rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> > +             if (!rsv)
> > +                     return -ENOMEM;
> >
> > -     INIT_LIST_HEAD(&rsv->allocated);
> > -     INIT_LIST_HEAD(&rsv->blocks);
> > +             INIT_LIST_HEAD(&rsv->allocated);
> > +             INIT_LIST_HEAD(&rsv->blocks);
> >
> > -     rsv->start =3D start;
> > -     rsv->size =3D size;
> > +             rsv->start =3D start;
> > +             rsv->size =3D size;
> > +
> > +             mutex_lock(&mgr->lock);
> > +             list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> > +             mutex_unlock(&mgr->lock);
> > +
> > +     }
> >
> >       mutex_lock(&mgr->lock);
> > -     list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> >       amdgpu_vram_mgr_do_reserve(&mgr->manager);
> >       mutex_unlock(&mgr->lock);
> >
> > --
> > 2.34.1
>
>

