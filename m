Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E60FC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 12:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F7510E764;
	Wed,  6 Aug 2025 12:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHg3DCQP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E56710E763
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 12:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbZQVAnjGH6JUHIIu7WdYxuWWgmdQB/RYzCHOCjcrkmouJpJjB5TMfqH0RqcDdTjQMYjyFBOR80vZZAxNK2Z25MUxJXNCSnKbsnyCmHN++lxydYOo/cXfXCiO59wULS9xDOMFerefqNiQyZy6R/67Bz5sDtvmc1GMyUcOBMYsha0TOmgd/EuEuzfsCmWSBgcj0C3TCeuNbVy1JSO9yXcBO4TeFA5mSSn5Jl208abSobvA56Ur2DRjib87RtGGyQM+rNuCdVoGz5pOmriYGHemslm+RHG3hj/iAYJwc68+WqCQFaObItJuq5srpiKonChskCiA0HfLefvuLGDBed9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA3H9ryL9QgqcNElWe1Wc5fPgkSAf6o5h9ernC87FlQ=;
 b=QTBh8W47O7vudqCAAArh05XkFlYpmroEDhesIxSfL13nlScsc/rJwGryJFGmdVpske7g9KH3G1uHXGGpcEeccC2L4otVkNlD9R+xFwl2sKdAe+MGVL5jLp7jeUmS19dhwQHT9FYatzflYgEIGC4Obdm247ZNMOt5Hmgh5qCHK6B1A9xqTqwgD15imq9MVICiSttUETTTPzzAoYmx/PvT1X7OFhfMlUWqhUMZCw5nowI6jvfdlVmLhzeYZ6tOmo9nV2KNBP09AS1O/uu0La3DnPAHRJWOO0KYRhiwe2FxORROT0lxjhBqsbZCvpUtdXFB6lC5QUuTHfGfrA8sG8qUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA3H9ryL9QgqcNElWe1Wc5fPgkSAf6o5h9ernC87FlQ=;
 b=tHg3DCQPnx1IFVkIow0wDd836zZfTxnjlus8quNtp0yKHxf3fwSC0WdZ6QMIAnOsbCzn21xP6sbbyAXsPCmPrAZa6BxRT6VEYs7kEjOhjvwtXvIMN1g0JHBC6X+yCz9Ezx09YZ1WKCoOA/UPi7+HKKFueOJ3x77WwhHjLGa/DqM=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 12:34:15 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 12:34:15 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/vcn: Hold pg_lock before vcn power off
Thread-Topic: [PATCH 2/2] drm/amdgpu/vcn: Hold pg_lock before vcn power off
Thread-Index: AQHcBqJoJhgw1xcf1EqOlc5csjTXFrRVjz9Q
Date: Wed, 6 Aug 2025 12:34:14 +0000
Message-ID: <DM8PR12MB5399B377C8045FA7822614BCE52DA@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250806071655.4160679-1-sathishkumar.sundararaju@amd.com>
 <20250806071655.4160679-2-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250806071655.4160679-2-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-06T12:33:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SA3PR12MB9106:EE_
x-ms-office365-filtering-correlation-id: b8fcfe7e-3ad6-4d64-0877-08ddd4e58dfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|42112799006|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CegcYejaUJ6QJqPOeetbgLhADVB9MEEeEPy+gMz5U7sobQryczzulr2FDnR1?=
 =?us-ascii?Q?XL47VrJK25BPT90cqeoaRSZ63A+4Zt7T92zE6VKiZ+jAfjGq/EYHYPb4Cwmd?=
 =?us-ascii?Q?4xnVDtAeFmhPxE+p7/PG1HuEXFNDKiRhqTijmuHOT40OdyfJD40QO9R/K88z?=
 =?us-ascii?Q?C/LUgAox+TFt0J2hYMq0Qu95hCD4AvTTNYYOsqutPUBr9VaC0riUPhuKdSNi?=
 =?us-ascii?Q?Knhi1JfhYQfpCeu5NhL7nZNllb1LZfw6b3FOBpVkWx7iCQ/Zz7pyPKLVA3Fp?=
 =?us-ascii?Q?MdqxPpcggzu1LyZl5RdEx6tHWQq4rOsrEdxPsWhqPAb4T2vuzMy5fObh2815?=
 =?us-ascii?Q?oLTZrb9YoYWH27o9x0CchW4/z1yIweumtNJMKXGAioYDxNW26U2ZXQU5d4dQ?=
 =?us-ascii?Q?fU8t2IMNdySttDolDdgbM/qD4SgbMvCj2ZtK+XdAj7DTDeP1V5jqWho90+SV?=
 =?us-ascii?Q?Kn2ihULJbDOwjT5Nzu3kD1bXygL+GjfvY8eCTIiQhaMSZlv4IsDs65ZrxBVh?=
 =?us-ascii?Q?pleLQio71eW75jcdYdndCF5j2mRNk1wL7coPmj/dhtxfb05Txvy6TNGtC2Nq?=
 =?us-ascii?Q?hKXdaQt4XS7XxyYCFt6ZztzN2sLyfNUO1WhY4CzJlo86RRdc2vufdPeOKGTl?=
 =?us-ascii?Q?BFoJ4xvVP83YlrEUJchvVc2rIUNNEJ53so4gJVLNg1Wb6BgtCxElgSyrAfs4?=
 =?us-ascii?Q?O05iiNnwVS61H/Gz1YCrNJRnV8KRacFejDnrF2BTAB50T38/AEmDxxMdOKLw?=
 =?us-ascii?Q?gElFUSVuEnYNGnl4b2V1ZOx1av/RdME1DG/lz4ZdPHHXb2lp0xKAZTHFtJ0L?=
 =?us-ascii?Q?Qqt49ry2CHsm1xyPa7FHHZ5vwqZXpTVyn0eFjgW+XJH87ptE67BMss+v4OPK?=
 =?us-ascii?Q?86vVQxYouIdMnShkqi99r1h6ZRr1R9QrhZugn+/SK3JiMoj7+c+HpGd9Bse5?=
 =?us-ascii?Q?/HxfwcF1JyZnzVilYBBE24ikk7pKLmpTlvs30KM9FlSxNOfiC1AoSWIQSslz?=
 =?us-ascii?Q?t3BthZ14dlNWBB9U+mlP1cQCpZsTRGp3ypL+sd7krdXbV4PuugDItdjRi02o?=
 =?us-ascii?Q?KheYjPVXoUy+sTNzWKnvXecScr+7drIeT2t4uyAE/ZY4wroePMTu0WHyZw9u?=
 =?us-ascii?Q?ZGfgSH95PsDsAjXuudcIUpOeadTC6e5vcrXI+XxlKSDslZNs9QOwyehb+sgO?=
 =?us-ascii?Q?VJ1Yk0EShG645q2pNrPdyocaSMSntUt3y//ke1/pE8UapI85ObldYMimfHPw?=
 =?us-ascii?Q?ZKHJmv5+RwhXlvZRCpZ7y5OiSx3eR4LELV8ogMR8ZZvkmFm1agWie0mRnvKS?=
 =?us-ascii?Q?F+f1IWAcNFvE4R/Xhc/oz7OhKoAkgpM5mnv2I3uPqyuJ5ngQHU23Ewkg2jIe?=
 =?us-ascii?Q?43Wt9yW0E7ADdMmh9AHKJmUdcKhJFTIQCGhcxe3g+C23shF6uhS6YwZ0EO0/?=
 =?us-ascii?Q?GlSjKmGnKZfoPygi/1+THYLAJYdOL2C23z7SyD9ksmQgsJ9Enj1JYQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(366016)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ELZ+aWziwtZP4aaVphktWnn08VjryX4IsK061lE3DIcjCjTC3Ma75Kpeat4Z?=
 =?us-ascii?Q?2klM6Sjx8/NTC0vOV+UQ40uHStjXFeYsUcJeXS2ZO08ifvs52d4sfoTL2e0p?=
 =?us-ascii?Q?y0czKKHLR3G/dTnr+OKrUkOK6Bd8Ue1QKYEh6V/fNGtCyy2HvoLQZruP83ed?=
 =?us-ascii?Q?S8NBrl+sA8qgi1ENnKegw4SEK/E2hZc6J5CnJIT8akGQqY693hRDnu1JdjGg?=
 =?us-ascii?Q?1PWB4I25CYsh5o95+RHm42+ldapYURryCDvI+dnw80mcWWWIVIRhjYZ7t+x4?=
 =?us-ascii?Q?KF5hYUKCUC9VMRgZsmIoNeTMA63dstygJs+/OSRxegeK40hdj4vvly2g6ESU?=
 =?us-ascii?Q?s5l763lpTGMGZsu9JZG1+DhWtDeDx8UHJEamGa+Wz6jzORDrNC1FD1aJNgwL?=
 =?us-ascii?Q?kpqTvsqdUtMPf/YIetzfiOMW8DMgZz22NCrzoL6EisrJkSZ2LFDwS/yPF+aF?=
 =?us-ascii?Q?zHuf86d2A0NfSmkAF1TdvGCCYIivzng6D9EzRjgm6pnMYO17E9xsgIWGkTdH?=
 =?us-ascii?Q?UITUjMjrMuJSxSTe12BDedMZiq47wzhVoUc9STvaO55v6/Cs7FzO8aTVOU8G?=
 =?us-ascii?Q?2EbEEEEWwC70tQk0uK7TLQw8MDc+JCJ64cSGs4P3ccyBSSMor1HkK7EbA8mx?=
 =?us-ascii?Q?E1kGCduDAyyrnTaUXnqXvFP02yXpXzVgtvFPHDTf+SRYaWp8iAB5bs+BR46M?=
 =?us-ascii?Q?2Q2PihZXdr9Tw1aGTGeW0Hx/Stum4AH+FHI1GfCrBfBBrnt6vk4/Jm3Ua0y+?=
 =?us-ascii?Q?i6tRQVDTvP7SbY136EwbSoZ3kl2nNrswzJX8YdtNUSCIvwuOfZVl/W+uxqLr?=
 =?us-ascii?Q?FbmCsqRNsoB+vkTpZDV/ZGsmsCKWZlRcuiVN3VEVZGZe3Yw1V/S1w2Fle6WX?=
 =?us-ascii?Q?FGDc+gow7mUGhcloU06YAsLGORGul9Dft9r6loE7fMaCu6eeAjvso6NzWbWU?=
 =?us-ascii?Q?OwZT3Aam95oXrstprCUwpozhnTXsVera6rtOZTmVZQiBBK6G1QEonkwXsUKq?=
 =?us-ascii?Q?EZEwV+EzoC8tRdGpHVolb2iEjw7nuUVb4UpvtgEdGpIuiXZsZpXz+Y/vH2kE?=
 =?us-ascii?Q?Uga4cIJkTxj1E9i1VP+BIB1h9bG81b4IQvfuuviEvXxlSs/bzgw2JV7jQ+wC?=
 =?us-ascii?Q?bMe2yjXF+q9Oe7mKbjOekVtH7MnFyNBV8L8guVhhgLuJMjyNcHtAavLqc6yK?=
 =?us-ascii?Q?VeN5SOfaPrMLdnx+0sWMMwlsAHrpAeuoyuro16aHwC/tuY4YCiGsPA0UoWq/?=
 =?us-ascii?Q?/8+FC6CAYVbgopfpcwhEW/NpWAjm7kpjkcnfQi3HkGZyD3ses4IX63afgcPQ?=
 =?us-ascii?Q?MddHcg1t+I5DhtoiVAQ/T7MZcYjjukuBJrlmdhmGjvnr0fpFBdJI7w7bCrjL?=
 =?us-ascii?Q?1vZat3MnsUgw+BVm4ODpZnw2bVwP9MDS/Op8tvdEiTDlEL0WeNRUHgv2ujCq?=
 =?us-ascii?Q?bx+ue4l1RZafammokJQEIekkv6zvxfLEBWcjh/8qaGXGHxmERzQeyLqfoBpt?=
 =?us-ascii?Q?aFFO/NyT/yOBIFVdoJbcxyL8mMeLPb9KjcLOH0RxgcBalLAWZukEGHSvZXs8?=
 =?us-ascii?Q?vPIQe2WBn41kCDatAjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fcfe7e-3ad6-4d64-0877-08ddd4e58dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 12:34:15.0773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5rKOqpvV+kTjM8qVZeGlqP+OKTx6u4rwLsURTz/rZZPxGZSg+Vn8MhNUMXJQgxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Sent: August 6, 2025 3:17 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Sundararaju, Sathishkumar
> <Sathishkumar.Sundararaju@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/vcn: Hold pg_lock before vcn power off
>
> Acquire vcn_pg_lock before changes to vcn power state and release it afte=
r
> power off in idle work handler.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index b497a6714138..e965b624efdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -443,7 +443,9 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       fences +=3D fence[i];
>
>       if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> +             mutex_lock(&vcn_inst->vcn_pg_lock);
>               vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> +             mutex_unlock(&vcn_inst->vcn_pg_lock);
>               mutex_lock(&adev->vcn.workload_profile_mutex);
>               if (adev->vcn.workload_profile_active) {
>                       r =3D amdgpu_dpm_switch_power_profile(adev,
> PP_SMC_POWER_PROFILE_VIDEO,
> --
> 2.48.1

