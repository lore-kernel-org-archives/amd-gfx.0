Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A420C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 05:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF43B10E14B;
	Tue, 14 Dec 2021 05:44:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA7310E14B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 05:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW0xdEruVTfB0XBUp4GTHZQJQVSQkxUkc9v1G3nVOLZMEUs+y8I/gCVJcuIMsCSiYBHDyjZKZuUTSHHM5GID45V+WRJvhJ2qHOmXuA2dFBvcHhPrAqGKKJZU9cGCeVODB2iHKaqr7T0fNKSJTWO2EZP81Mh0qROYxec4t0WnkpH4KemtXgU2ktd5bOUkJKsHOHBb4SON17I+DHQQiQ9+YSwxdbrW/y3f/7Z4BiqviADbvSw4sUN0FbDCfoD1AfxEqOXYzOx8auMv+oRfSf9S9I4pCzetZ/4jJsnHVMQCUgBuu+aF5JaXgS3UNSPVsfdfbmZFxT50SfEYyH/QBIkuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNQphcBNxhKvOkMZUfJPMZY51P8ovlhF7lMkZ8tW2GQ=;
 b=eLbtdLM+RTdr0tUYLCkpmk+Dw9n7/vQ1kt8cBwXRhhEBJeVQ7ohRI7GXNPLpjghiqOVbPgrM/wz3g6A4cZ4pIJGtJWRbPW+LUW78xnwGQW6nQ6wCZgsHiEzXfBpzCcQyqzBXHM8PZL7ogCZLymTMltcJN0DksFpxwcuFSXy6mweSafcRkqzlHmcGTVPY6EoUDxHKOt7zHgPp2iHfti6d61JCuDSESdgz4qHis9WxeIjqui7KrvEPfARHluFu2I/F6mrMbUb3RWBRA+voubXN++SqOhMyvJJTdkIGHujWXNnUg+sEDRdY6T1awR8t59pPxXIACaM+1FWSR4l00JOJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNQphcBNxhKvOkMZUfJPMZY51P8ovlhF7lMkZ8tW2GQ=;
 b=1LiLPKHI1C9VdZho+GtMeP3nUG7J+bocqFNM46IASEpjnzb7u+jlvU9SaBHA7jFZRjQAsk3XPMuHAGexzi28rX4+zrAoHrkiDyfENh31YLTah/V7e/1pPSdUC8WRmxL8Veei4N5avHT3ZdHrQMoodBPSVizHWN5Svr8J39eq/Ek=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 14 Dec 2021 05:44:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 05:44:31 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Thread-Topic: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Thread-Index: AQHX8IrJbR0646ruvkOhu/OoGSWFYqwxWgcAgAAAVICAAB+EYA==
Date: Tue, 14 Dec 2021 05:44:30 +0000
Message-ID: <DM6PR12MB2619C0DBDFA275A0F76BFB00E4759@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211214013423.801735-1-evan.quan@amd.com>
 <DM5PR12MB24697AF2CCAAFDBACF6E43C7F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
 <SA0PR12MB45102B1992F821B4D05B9D80E2759@SA0PR12MB4510.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB45102B1992F821B4D05B9D80E2759@SA0PR12MB4510.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T05:44:27Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b6e49435-69b1-4ab1-8614-12eeec9f74a0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bf18075-3f34-411a-ad81-08d9bec4cd00
x-ms-traffictypediagnostic: DM6PR12MB4436:EE_
x-microsoft-antispam-prvs: <DM6PR12MB443638CF2FCAAB799FE4E79AE4759@DM6PR12MB4436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIxsyHNbBFO7x9YNmrbZjH6uS5zVEUMnW+R4EQ8PPJAyNJUt4/Beh5asYq1POMq4Hf5tCvEY0Qg+qQdyeAH2LylDj8zhfvCWdOLwe7+KVHXwTKwRfOaZPGokpPfPyb23QrPo4tOFyeA2M8NEydbCM4eHunlTZtdJ2bYrSPtYoJH7ZKWHkXF7yXxgqUJLHeBzfGodYiPyAXGuycsdEjE8jFdrj7oRVC8OLyn9Vo204CN/0xjU8B2OI74KeJVDP/wrY8g6zeEnm+vVUD3myfXSt06s1jyNXCDNM3NJh8bFPk6c5o2+GKcs84THMvSF3wdf3CyW/A95bsNRQu0+HBA2fxw15al3ByE5AXwrZtLCkpF9PnhlmnnEUyTA8ojxTM1ecrevIkn6i2EsER9hFukBsQv31v4KuKFSq8XR/CdvbZ5MknMzAUeAM5KiRDPdCdOZMEdCARF7cWY8LRh8AGZP3d62mMHa9fokPeh73y7fLjSy7+w/cB8Vz1Hl/PIdnuULGcvugZwqVgm3U7sh8f4FOAd22Z5x4+RsWD3JdTLpzLiuvHWbhkHUzrHpsR9bdhj83ZrOi6k6G/HZgvS/VQnvUnnJm4mKihf5SZ+hpOZdZnK0LMOFR+ZT2q7nY5+3YzLyk6nGmelyDrOXe7ZHr2nJZk6c/pNnoNmd1YZ+HF1aQM2xIVZsjoE5ZWTcKddD3FvRCRFunD4Nw8LRxNJ/yrliioEWTbF3FtTofX6KHF1X6aOu9Ihjm0p1LDC02bFdb5OsFyc6z6FB8YG8JNS+hoPrTsPHFNEAgOAJub6Xh6IjMp0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(52536014)(122000001)(8676002)(5660300002)(33656002)(26005)(38100700002)(53546011)(508600001)(186003)(316002)(83380400001)(6506007)(71200400001)(2906002)(45080400002)(86362001)(9686003)(66476007)(66446008)(55016003)(8936002)(76116006)(966005)(7696005)(64756008)(110136005)(66946007)(66556008)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/as6vbMXeskLXby/bBprcC+uzD7RBZNTOvFuzNYxBu6i1P9sQ0D3B5D/Kfkm?=
 =?us-ascii?Q?juM0Wl2+nneiHXuTu0xXZ5eTNCfHLmwyPmHKD6p9tfCZ79qnTQG1bQuJ16jX?=
 =?us-ascii?Q?bslHpdYF3uz3FvZkChwuMriwh+59WHoFJ97pTTTjfkSKKKl30Bctl5ruNgmn?=
 =?us-ascii?Q?2I/mEHk6oshH95hAeSQtwmyjP2HE2zyKwrIq3Na1tT5BHA/T7foa8QfFfS0o?=
 =?us-ascii?Q?SOS3bva74V9jgtnCAsFmwoEMAby1LTIMrpHBW2j5beafWPEU1BNdomEkDfif?=
 =?us-ascii?Q?9kNrh2/vzYeEQjB2dIO9t21KTKSllzSPNCfZiKyA2XMfSipDVK/W2xmD6OoV?=
 =?us-ascii?Q?izejOpqIkhsJdzEDNlqeF+ZSkbv021p+SEko9lG89op/PPuvzu7jrcqqXy6A?=
 =?us-ascii?Q?b4AHj7iLknWrnfkpCC73776fSZ9W6I6x1oB40ItMDGNGNmZYdJG65kyO2lJg?=
 =?us-ascii?Q?T+QuYQphNRYxd1LUQoEGnf2Nf+SDzp3NqURxdeygIH/I1WwAJChzBqbTS4xi?=
 =?us-ascii?Q?luvLxDRbqzsvbXAyontNuhs6POTa0i3PkG18M4bp3FBLHokTayNXpSYf6Wls?=
 =?us-ascii?Q?aiw7g7XPAZLj1d3rMQDjb4NPmQxDjg5alNpeEH9nQsC/T6Fu9SS6loGJL3B4?=
 =?us-ascii?Q?SZOpA8U3+/VDQ65ghIT6853yu3qJBk0IWAsyiKFJDpinYYqkObp1sOPslPAx?=
 =?us-ascii?Q?A7y77kTjXpfHOSTyC4Ucu7yOBLKPqiFW7WlTiCUmCTSZfuFIBap4C13T6PiI?=
 =?us-ascii?Q?8UgPi4DXVFB+mUXdUIAJTBeg4SArfyPAW7/SiVkQ/sdKWNaMIr+XafD90Xly?=
 =?us-ascii?Q?CxV/QqKtgTb/bSXNv871x0r+v6xVMuEjT7dKESlC+PAhzLmVdZqos6XMYINf?=
 =?us-ascii?Q?KH/tffIEkqxKvY1iKTgSA9LTcsDqOvqd3UkwD7GrKwiM0DLk9jK5att8RDQx?=
 =?us-ascii?Q?U4H1tntVs2nSOV6TKRGiTkJ2vMI7HLHQCJodjESRiSaafE3bIQxooF4RatQj?=
 =?us-ascii?Q?/2Dwj2hDUAGOeOcrTh49QIXW+Pl0K6HcV5tLpR/baousZobBLjGINp53vXNw?=
 =?us-ascii?Q?+wrnP3mlXFbVXFoDvEFwgQ1LtlTZ0KzuPxU8B8jDBBFk8r00gTHEU+qDDM2b?=
 =?us-ascii?Q?c9ZduVxHOuSIgdOO/XJSqNa7HhiCqJ7NS6GRjvCauseQOxrmXDQaF5/JoP4R?=
 =?us-ascii?Q?sVJA8VDwyQtPCCKDF2Ysgry99mwvYEwZzlNd9gTfJQpqbb0kCnTzwNK0BO96?=
 =?us-ascii?Q?lkWOGzk3eZjAkWlUG+cObd1Kbrs5v8KHZtIKRbRdazQKcSIJJWS6avwv496c?=
 =?us-ascii?Q?ylDIYwEe7l4mGBp5+/XZdYFbKq6QMoTx5FMobG6PwlaQC8pmTaaZw/Vnzo+I?=
 =?us-ascii?Q?gfedt+N3lzp6donSbUngIB77wy3lfQc0fKf0rfGXwjFnrCoZS14PDMVatV5F?=
 =?us-ascii?Q?qdZJpd4NbNKsITBzZdaIvqrfMLn9ywC6QJeiLzWpcpQteubWFBXRiWa6MTbp?=
 =?us-ascii?Q?4LZOtEByOYwBoIN3I9Iwm+zki5iIrNpD78JuS6KfNC1aOOz3egHf8Xae5qdJ?=
 =?us-ascii?Q?+fES1E3glc6Mlcj5iPw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf18075-3f34-411a-ad81-08d9bec4cd00
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 05:44:31.0287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4CNAQ7ikzyfCsFTCLB/S5Ox1VLFvOYstbuF6IfWpOwtYuBHAM/aAF5NXUTd7YTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Tuesday, December 14, 2021 11:50 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: correct the wrong cached state for GMC
> on PICASSO
>=20
> [Public]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: Monday, December 13, 2021 21:49
> > To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> > <Evan.Quan@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: correct the wrong cached state for
> > GMC on PICASSO
> >
> > [Public]
> >
> > Acked-by: Guchun Chen <guchun.chen@amd.com>
> >
> > Regards,
> > Guchun
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Evan Quan
> > Sent: Tuesday, December 14, 2021 9:34 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> > <Evan.Quan@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> > Subject: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
> > PICASSO
> >
> > Pair the operations did in GMC ->hw_init and ->hw_fini. That can help
> > to maintain correct cached state for GMC and avoid unintention gate
> > operation dropping due to wrong cached state.
> >
> > BUG:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.fr
> > eedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F1828&amp;data=3D04%7C01%7Cguchun.chen%40amd.com%7C
> 42b
> >
> 00d7e1c4e44c0762908d9bea1ef53%7C3dd8961fe4884e608e11a82d994e183d%
> >
> 7C0%7C0%7C637750424983319967%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> M
> >
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> &a
> >
> mp;sdata=3DVgBDAbcKN%2FqUz8iBQby9YP8PsG2y93VlnDVhXVaGNBo%3D&a
> mp;r
> > eserved=3D0
> >
>=20
> The syntax here should be BugLink: <url>
>=20
[Quan, Evan] Thanks! Will fix that on code submission.

BR
Evan
> Otherwise
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>=20
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > Change-Id: I9976672a64464b86bb45eed0c25c9599d3bb4c06
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 8 ++++++++
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          | 8 ++++----
> >  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 7 ++++++-
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index db2ec84f7237..c7492db3e189 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -1809,6 +1809,14 @@ static int gmc_v9_0_hw_fini(void *handle)
> >  		return 0;
> >  	}
> >
> > +	/*
> > +	 * Pair the operations did in gmc_v9_0_hw_init and thus maintain
> > +	 * a correct cached state for GMC. Otherwise, the "gate" again
> > +	 * operation on S3 resuming will fail due to wrong cached state.
> > +	 */
> > +	if (adev->mmhub.funcs->update_power_gating)
> > +		adev->mmhub.funcs->update_power_gating(adev, false);
> > +
> >  	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> >  	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> > index b3bede1dc41d..1da2ec692057 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> > @@ -301,10 +301,10 @@ static void
> > mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
> >  	if (amdgpu_sriov_vf(adev))
> >  		return;
> >
> > -	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
> > -		amdgpu_dpm_set_powergating_by_smu(adev,
> > AMD_IP_BLOCK_TYPE_GMC, true);
> > -
> > -	}
> > +	if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
> > +		amdgpu_dpm_set_powergating_by_smu(adev,
> > +						  AMD_IP_BLOCK_TYPE_GMC,
> > +						  enable);
> >  }
> >
> >  static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev) diff
> > --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > index 3656a77baea4..9953a77cb987 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > @@ -1167,7 +1167,12 @@ static int pp_set_powergating_by_smu(void
> > *handle,
> >  		pp_dpm_powergate_vce(handle, gate);
> >  		break;
> >  	case AMD_IP_BLOCK_TYPE_GMC:
> > -		pp_dpm_powergate_mmhub(handle);
> > +		/*
> > +		 * For now, this is only used on PICASSO.
> > +		 * And only "gate" operation is supported.
> > +		 */
> > +		if (gate)
> > +			pp_dpm_powergate_mmhub(handle);
> >  		break;
> >  	case AMD_IP_BLOCK_TYPE_GFX:
> >  		ret =3D pp_dpm_powergate_gfx(handle, gate);
> > --
> > 2.29.0
