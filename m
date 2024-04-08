Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70A7C67861
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 09:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D29112376;
	Mon,  8 Apr 2024 09:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tzlO7Z/F";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62EBD112375
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 09:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPY7FUK+eLAXguV6sNbeicT2Wi3xUyt8/CCm/QGD6Izrw725/W3/Fqv0POCShz+XDroiyi6bLPoD5/1Ix0OF65aho/lLxbi5PdLBQ4FUD2Fmk0olvQ1oWorn7j/qcxZBzqFQ6Wll1JMRTKykTrOviv1Qum/tjwiiXsK3BhYVamN9Yi8SxJroGgrUeSl1BbBCCwLXC8fGTi7WJ6i25CBFJdVmo5vC7pK0nm5vExxuHP4y02CcnYONt8XK5yTehSzY/4Oaz7w9dSxtmJtLAwDWROlK7a4sgZyctMRVF+pbplpWVlp1kLBugXtlroqZYXbMQUpF0pKkp7CRnAaRfNgIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU4aYg59+Bfk+oEQ2+nJdM+nIGEBR9weeZaZCdHHph0=;
 b=FAxdrfW32cP1xBWmoe6KM1Mo0+FVOsmfc+FO++krfODHmbtCXqbhbtIYrA04ExzjuAkQRa0YayvpERdczGDPPlSkc+kNi+jTzMfTwEpDVRkYVthKvlqpJsxoRNNWRP0v3U57nxsvZYdx3szFSeLjHYY4lZb+PO/rZmDqOTnkWQvfzfAAX9P1Aeu+EifqEQYpXxokOQDtvE0nUEYZ4y3w6ehk3iJo+7rbeB0F5T5bmgyD/j49ol09mANbPE4L3wbGFHA8AifKHBvn8dQB2ZQzDwOuB6UL7fC/XMNjv7h1vLbeaUMaLmaFO7dxhYiIvw2OEmg+oiutueP5c3kmag8vHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU4aYg59+Bfk+oEQ2+nJdM+nIGEBR9weeZaZCdHHph0=;
 b=tzlO7Z/F1AQnaFMu2IegWb3T+kLRCrC3aydywjrGREp2tMcZQJVfrDsPmAUtYEpU1SsJ36EPREXrVvBkR+7XJxssIfdn8khhbdZu+byZh5qjfWdM0Byrnf+DRCdw1MuEr6jhkff48GY5JbqfIimx2MSU9LCKW3iA/vdcGVB3jAw=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 09:35:17 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::9bf1:7cdc:4c83:4da2]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::9bf1:7cdc:4c83:4da2%3]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 09:35:17 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Index: AQHahZWTzI8oX95f2kWPs2o7WORGDLFWWigAgAW5JsCAAgJugIAACHhg
Date: Mon, 8 Apr 2024 09:35:17 +0000
Message-ID: <CH2PR12MB4215FEF62EA1AE91E5CF2490FC002@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240403070649.685497-1-YiPeng.Chai@amd.com>
 <PH7PR12MB8796050C3FF06BCA9485BE06B03D2@PH7PR12MB8796.namprd12.prod.outlook.com>
 <CH2PR12MB42150FCCCFBB2D4AAFCC01CFFC012@CH2PR12MB4215.namprd12.prod.outlook.com>
 <PH7PR12MB8796E1D39D10C0A043E731F0B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796E1D39D10C0A043E731F0B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|PH7PR12MB5688:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4QuK6yu6fRTwkx5tfOFOZrRCon+aG+IEe/t9YVr7HCz9DWc94Zfgj2NS1OUxFoF0A0cik2dIeHTZcCUtyLsiHqMbIGLSL5BuiYgtXV+kpwMZSuACuX/S/HILt9MAAo+iJvkvIT2sgS9/nWaAcaYQF7tiEKwf1IHJkjcg5hq6SKg0tiywCdsUrqzHHziZ+5EZqTIW/IRUmIdjNo6NeN27h7p06L9Tfmvb6O/zvdgyEtCF/qWcHxhI2xB++Q42Giay6BsBDVjo+O4mS8ALmFAbPJ8F4udqTz5R7A6zIEx/rLEZjovX8De8DgpuTqrWR9cXp9vt0B9m7hbXG0vAq6xkLFxzAqaQtwTyKRE2dvYQYlapdrO1KvoKWw0FJE9uz9enMcG6ieGxblbztICiEqAuidRmriNlNfgyJleL0OAfj2dib4FZj82RqfVpUBV4PnZzJxOhpmQZEbmJcX5UmAtJVpJ8INGE2JasGNG8T4tFDKEw/rR+MwHgBhRftjOIRSQGBn7hn0knxg/uRo/zznes8YpKpgTGDeCQl+SAEBzn17tddt0kYozr0d+HwrLoQDK31WysGmgpnUDinMAN2vsOVQRgvm+IANhU5g711KeLarHFMAeS8GheDW86rqvmunCdM2sOnUaCEAeGPWpDNV4UnXd1sAk7DsWueSyMWPsUq5k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S1UTYgGWmgIuQWPoMaOLY0Ug7n2BfHOk73rkZRyCdvcS9Sx/vbsymCPNjDxk?=
 =?us-ascii?Q?LEp60Z7fPrGfTDGqJJHQloOFVAUo6drGskiyPe/skYGhdweFf4UcWGvJnq58?=
 =?us-ascii?Q?iabxV3cELzTHdiDQ5TBpT+DYmULhHC8CIyxvohfzyzSFImXOLzDW5o/7HZBo?=
 =?us-ascii?Q?+sMH8M8gHRUYVOnUgmVJREmIvK+Bu3S2nzM0piG0hXqC9TYQTHZmSngaOzCp?=
 =?us-ascii?Q?OidsIhW1LIxlE0ZJDVzP+9qxirmp9De+CHxye3N5LzND5FZk5gG2bsZzCVKg?=
 =?us-ascii?Q?jewsQ2A9vFMQv91t4bjBjfXuwiH5ziLXdxULV8gQiCQKTZK4s2eJTyBydJlr?=
 =?us-ascii?Q?7P4zN53zASroitDaYK6GjQqfqj4l/AresHPt/11G1MA++kTa9nbJLDZR5clp?=
 =?us-ascii?Q?Ow4KZuLoBDGXHmfnjXUr0oocd0F1TgrIDABgk4+k+3orTZarO1q5GU2duue4?=
 =?us-ascii?Q?PZaRan3/TmRcwle1DP08RR9h4Sakd0ya9xfSbCrWnyayGY+hDnbqxvVV/tj3?=
 =?us-ascii?Q?x+Tp+QA7hbsziXkYFuDosGXCF7BMcpN4v2JKhkP0bylUW1wTcfCqUk3L3hBL?=
 =?us-ascii?Q?SButeuXcZMcCy+X6J/9n8ICnR+zq77O/4lptnxdsiObR/DvcPDM2OfDi4UB9?=
 =?us-ascii?Q?c116A0pvijrgVXnkQgM4S2qO3FY0tmeoooBFgrMd3NRa47G26T12IiWb2XbO?=
 =?us-ascii?Q?ITolFdxFQciZv5GCO5zcUBlZdqSSmRvEpmFwJnGRKsEY8O37yfuWyWp/UeUf?=
 =?us-ascii?Q?tyAO8BkFdff4QFPPx82Py5KNg2u/mVlr2Bv1HN5DbwOdt0t3mXnaDlr0R6+u?=
 =?us-ascii?Q?DQXSk7L2VXvfbubAnlt5Qq1XOFvyBR3NXGDuH9hTT7Y88Z1LZWNASCM+ytod?=
 =?us-ascii?Q?7IIQdn/7f0KbfiYytkTj58+IxVR4gf30Lh44sfOY37y8oSjqtAdUy+dyt7SU?=
 =?us-ascii?Q?YydaErL3uvKCBUihGmaC+nhYj2jTVD0VTZXCy+WkaO5OAaOIRdHd5n5QCaTI?=
 =?us-ascii?Q?CmoQHhlzAaBor/wQfTFFi/aeTsUilVRR4rUjJgRXulf6madgXQbmUt05GEG+?=
 =?us-ascii?Q?M+SvV1PMWdkxEhhNRzqIM3FtRKJBoLwnmymvPCC+jgT9eymMbmLoSLChpg34?=
 =?us-ascii?Q?NJmyY+Mqgl+6T4/Zox7cVVx+wTPV1GA9UTgW8pxK0qB9WcSAot9f8pPw9s1T?=
 =?us-ascii?Q?3Nas0RjcM2GewPUELHIY97E08Tyb2t+6KxiQXYTyCsB42wrSepsx2jV7Zoop?=
 =?us-ascii?Q?NUgbB8XXURheTfwW/o8PfBh6xxAca7bJr94DLvLiQ5N4MR8uVQkbTtvxaoR+?=
 =?us-ascii?Q?YvmOHgWPiRUyInKU5O4xCUOVvFZ+xgUypwj/g6r4207HarN1IePkEPJvl2HF?=
 =?us-ascii?Q?uqG2o38H9ZY8EmmUzthZWNEd4BhStwTi0LZ7U5kusiMzBwKnpyJ2TQylow7g?=
 =?us-ascii?Q?AHwBOHzGCAuY+AYssCUWMTOH+6oXXF7/JI7DsJUi+RpFIlQR6lXQEz5MxqdG?=
 =?us-ascii?Q?C4RmzJGO2rZLNiv74qxdG/viPjJyhfCWJg5kHBhZGHFV8BADH1ueobP6GED1?=
 =?us-ascii?Q?G0X1sYQWP4IHh9jl0NE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0f9441-ebce-4983-3916-08dc57af3343
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 09:35:17.0679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vblZjw4C+EWzwL6FfysGcY+RP0DldEYJOBOrMzuhRBW776Klf/nWbH9U2ZnMPNvwBosmI++GCNkcq5Z72AdQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, April 8, 2024 4:41 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Sunday, April 7, 2024 10:21 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
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
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
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
> >   After calling amdgpu_vram_mgr_reserve_range multiple times with
> > the same address, calling amdgpu_vram_mgr_query_page_status will
> > always return - EBUSY.
>
> >[Tao] could you explain why we call amdgpu_vram_mgr_reserve_range
> >multiple
> times with the same  address? IIRC, we skip duplicate address before
> reserve memory.
>
> [Thomas]
>    When poison creation interrupt is received, since some poisoning
> addresses may have been allocated by some processes, reserving these memo=
ries will fail.
> These memory will be tried to reserve again after killing the poisoned
> process in the subsequent poisoning consumption interrupt handler.
> so amdgpu_vram_mgr_reserve_range needs to be called multiple times
> with the same address.
>
> >   From the second call to amdgpu_vram_mgr_reserve_range, the same
> > address will be added to the reservations_pending list again and is
> > never moved to the reserved_pages list because the address had been
> reserved.

>[Tao] but if a page is added to reservations_pending list, it should also =
be put in data->bps array, and when we call amdgpu_ras_add_bad_pages again,=
 amdgpu_ras_check_bad_page_unlock could ignore this page.
So except for amdgpu_ras_add_bad_pages, would you like to call amdgpu_vram_=
mgr_reserve_range in other place?

[Thomas] Yes,  Since after amdgpu_ras_add_bad_pages is called, the bad page=
s will be saved to eeprom. When a large number of bad pages need to be rese=
rved, this will delay subsequent memory reservation.
I want to call amdgpu_vram_mgr_reserve_range to reserve memory immediately =
when driver receives poison creation interrupt, this can reduce the probabi=
lity of bad memory pages being allocated and storing the bad pages to eepro=
m can be done slowly.

> >
> > [How]
> >   First add the address status check before calling
> > amdgpu_vram_mgr_do_reserve, if the address is already reserved, do
> > nothing; If the address is already in the reservations_pending list,
> > directly reserve memory; only add new nodes for the addresses that
> > are not in the reserved_pages list and reservations_pending list.
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


