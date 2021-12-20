Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B3DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 19:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B4610F4A8;
	Mon, 20 Dec 2021 19:01:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340E910ED20
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 19:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISXyLTqloCQVyMb9YeodSG7+YmG6IUi6LX0xs1JT8qgYW4mrRw9c4ITGaNsUxt+CGFArDyAxv3B5FYWA0ilwF5vPsF/hyDZpwkT0IjM9DWcRD3DJdXfkTW893pGoQ5K7RTtnIxIfPVUR+B6RbPwjAyevAKWtARMKDmtFl8MniMoMSAVBJ1BvzIC5WqUJXR6d6/Ei15KGyf5qXH3m+yMHUT1vwdsoZzYXoHczt0OLE6al7pig9mMwpKZkYjcVVoWqz4bEld/sYPUaSMXEMrysFK08LK7JCdk3Ck/LfoyEf457pFhiim47UKnkbX97kj/+0wmBrycZaQbvPiJI4eMU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRhDcHTw3AzG9XN7ktPh+hRY/PD+pN4BW4fYLvvc1LI=;
 b=BCjq7mETdmUGY/hsHEoTDui2Y/NEREF7v/D5e+XumLhEgx81ZNLaNjtLL7MAisnaIfiieYXd0qZIvpB/o1e27ydlxDUlwR+WsHvORrzPXOqBDR2nyUahX39XexP4kblrkH41fWrSWcKINS2XyJ3RkxICIbUoI4BYwdAAbarlbJbF72yvzgoDCa756+61QMz2wFfc4HUE0UDaUBItVSsQfbFFOWx8AnjGjwSLZ5Nof3oONu/MkYTdlD9RgFfd6nwGlNPuophP0/DIfvg3ikAUo1QhpsIvX52mc8BYgqQV1o7Yzc9EpJNGaAQpx/XfBbuTEJnv2MIYLnvL3axcGAvwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRhDcHTw3AzG9XN7ktPh+hRY/PD+pN4BW4fYLvvc1LI=;
 b=YxLV1Ed/u2pzI2I2M4v8UizKcieziozkBn9ZZyVI+1UnYMfPRJfH/cYq+2AkpiTRi4emsSNnIoAi0lTXDfmFntk21fOrwO9yvrhkjQJbYgdrCKBTHglSj+1E3rbkAZfMwXzKJeVSn710dVmifeg/DO/xUOnaSc4h0kKZ34XvEbQ=
Received: from DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 19:01:03 +0000
Received: from DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::a589:5d7a:f504:aa69]) by DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::a589:5d7a:f504:aa69%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 19:01:03 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Nikolic, Marina" <Marina.Nikolic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Index: AQHX9bvnrRjMjFx1i0GTpQ8VWCMmo6w7u9Lg
Date: Mon, 20 Dec 2021 19:01:03 +0000
Message-ID: <DM6PR12MB2858E316736722D6682BAAAA857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
References: <20211220160834.8400-1-Marina.Nikolic@amd.com>
In-Reply-To: <20211220160834.8400-1-Marina.Nikolic@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=00c8d6f2-a584-428a-9a38-2bf3936d2bde;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-20T18:58:58Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acd9bbb6-1e67-4595-45b4-08d9c3eb11b5
x-ms-traffictypediagnostic: DM5PR1201MB0106:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB0106298B4CD51E49C2941D90857B9@DM5PR1201MB0106.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Ab6n7pQBFH1Z8DZdxYZzuNXjRHxNLwrdeBXsDEjjnabsLVVrQ5l2jhH8MgbzZXi9Xmf9N+raDVklPL1AmgoqS7ODrrPfpkmlcYlWgbPt2JmBANoC1NxcyicLsh4h08FHNdS7E0wmrIxEUeI/pilultMQgSjQxy6tOdGzdmqofmc2qpFIBUKACkvnwTvzfIpLczDcQERc/qPi4wDw5sSAeulHFpOIVJqWpN4BOCfNsyRf9tEA0lHBCfbnWmHxNs6azEl6TRwsmkporfjFGcvVP4uqDWTuYkWQD3QXxTZwdrSO/WGUa3pp7ZvZMe8Ndnp97D2ogjuRowL9mJIOo9D2nzVEteJaveiT4E/lgaNpvvfc/K8PdYcnlvrMOdxp3b8R7x7Lh7b5DaqtSE/tZWhyiPm57QJNh1XKMbUBtGog1iInQnzja/rRSKRMFWUXutOaezshu234AKoHnYMbG7fuApemW/O7VFWruGQR0JeH59tI9I4bSUwlgdP4i8gPd0fE+1DMWX89NAXO5aEHCi3xXG1mrYVDxtYBHCm+U1UmwHi+S3EKUtpQkAKmQBmL6zdkT8xgO8f5KJzcjop3LDiKU9EujO5Xx2MoWHtwU5JakMlG8aJGgqdm2z3tvy3JR2lu1xlY116P8/l5oAm53HEgs4Dkqm6NiBNtVL/Jn9+uerDWN4laWNU7DUOUtrjAjM8lmbCU3OEQyjNssTQJlz5NNE9bM3xAwCn8dVH7pWgWOJQ6E/jBiLewHH7SvUFWg7E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(5660300002)(26005)(55016003)(7696005)(122000001)(186003)(9686003)(71200400001)(38100700002)(86362001)(33656002)(83380400001)(4326008)(8936002)(53546011)(76116006)(52536014)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(508600001)(6506007)(110136005)(54906003)(316002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LXUF5+Jk+T7NDtkv0/ilFZJ3zdybYbSe7C/XhpJvl16T4Y6GHmpVwA0YYwpm?=
 =?us-ascii?Q?XXFEhTXelDkIxkX7uphbKmYi0HEWba1b028VeztBWG4PqGkzymZI66kZ3LGw?=
 =?us-ascii?Q?zLaxqANzHJKxV3+zQHcY4DOtRT/HwrwHBVaIYE7XSvH2DJ7GZ+I6PWdgy1pF?=
 =?us-ascii?Q?VIBEL0QEtBw8VQy32bVzQ2o+3DkWb4qjRKdp/MhRLSFLIXLnSOgXkumjI8Ur?=
 =?us-ascii?Q?HtfFWTElaNvNQDULB94yyWQVU4HhdUNZNQjqZnMFqhSmAcAZ0I8ttmvyydlz?=
 =?us-ascii?Q?tujLOMuXp0Vx/+Id3WEFTmGrDaAtUC9u+arnt92aj2QpYuccjgElQml4bAqQ?=
 =?us-ascii?Q?G/nTDjbzyDwj5b1fw9jz86Jp8apclFkEXHc2wpjEv1ZmGVOSjfkj22iF0u1d?=
 =?us-ascii?Q?38fgIjrO3ASjRJUmTYo1CtnQfKmZTfHA1egqNetkeZMnAe5hrRRQ4kSCMIsZ?=
 =?us-ascii?Q?1f834zZC/l+dcerSs+lt4Rl3jrkksI3SV6Ci78EKu3ZvjlT7yJmu1bVFGfju?=
 =?us-ascii?Q?R1+s5TJXxlKwdxEWnyamQ67/iWjwQgcZw9BTsLcNJpGrCEYqPvZVza1TQYVh?=
 =?us-ascii?Q?pO6Pm4ahTxY+mRb8HNSHwH3RCZQilUlFQL8StN1DXR6nvYGSBYSjMf8DFQYu?=
 =?us-ascii?Q?u69SYy8Kdzv/azYWOptlKW8EC3BT4WQ+chUByYmycWY7IrJ9GA+kGJNSCy55?=
 =?us-ascii?Q?9d8rvjsWum/kiottdcJw01e1Jf00wqBm0sRlo35xUEyPE1aF1xxItCPUZIn3?=
 =?us-ascii?Q?oEp6+y3yB7cG+G9KbNPohHQciyPQCc9YBXmF9jJa2n//oJBakHq0j79cr6sK?=
 =?us-ascii?Q?/H+G+coQ/6csczMD1l2RblXiSsBMVwzZl6CsjhHiKV4VEubc8aKxOYZ+kfAu?=
 =?us-ascii?Q?1xM+RghTl+aFxX+hJ/ZRoR5koaActfLrzn9w/ysIC6aFq9cK3dHXeYaYxab3?=
 =?us-ascii?Q?D9gbsxUxsrmTr6d6HKtp6SzjTvnYHhSuP6aCKU4hJ3+JL4uNVii79Q1X8eNb?=
 =?us-ascii?Q?45BxkTHyTsE/a45hY1yFVKvpd9rCiaTh208bYad77IqkYiHIknwbMutbKXfq?=
 =?us-ascii?Q?PqDCPWe75bXaEvCkFSUQo7LhO373rdDk98jigkELP+mDDyiLysjB8jXwa3VW?=
 =?us-ascii?Q?cUg3OFEWAKT3NCu+qASEyHlBk4ZHh0WbfNKW3/vI1KtBsV293uD+kjSeAMZO?=
 =?us-ascii?Q?tFvRSkIvx8wjmJ8Pn/XyiwdouQLDLcBZs1R+Xf3kPyufvKbLXDA2Ez/oFoLd?=
 =?us-ascii?Q?Jce5+RjMvHYq7+osXJlhzgR3DCGLhi6X1PNemrU1aIhHmAZkPawEWvLzNvpX?=
 =?us-ascii?Q?4MjEPlWYIBTHQ1QZZC6WEVTPTaDzdCMZL38bA3b2ChaX16z1z7jUI5F6mi5B?=
 =?us-ascii?Q?bGVZKQX6v2yyCN1x2vLART43mTlT5TIF+tv3AZ9pHBzdl1njoZfk0v9SD6y3?=
 =?us-ascii?Q?cGLFj6fReu0uQ2OYDpKBq0ICinHxTjPK4wadvl+wtLfMWfyLv6vr8bJrZqSv?=
 =?us-ascii?Q?rJvUsTSZ2/ZVerizE8VGz7xcbfpEMaIS9HQ40PpZFrVQeAZ37OlG+MrsrXSg?=
 =?us-ascii?Q?DZK6TTxO9aloM4oAVjHWJ05ZNnD4Md+yRw9yvcaiUYXh8ft8BfL1z/qTohQX?=
 =?us-ascii?Q?WNr7cpL8J1AdrJiY5oEb+H0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd9bbb6-1e67-4595-45b4-08d9c3eb11b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 19:01:03.0834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0b+DD11dNmh5j82L6H3/Ue7VzoaXslGhNYGoA2TA5tKR1uFUZsPPwKY4eum56f3EGvx+gxtU7x2Bd1+71hJ4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
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
Cc: "Mitrovic, Milan" <Milan.Mitrovic@amd.com>, "Kitchen,
 Greg" <Greg.Kitchen@amd.com>, "Nikolic, Marina" <Marina.Nikolic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Marina=
 Nikolic
> Sent: Monday, December 20, 2021 11:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Nikolic, Marina
> <Marina.Nikolic@amd.com>; Kitchen, Greg <Greg.Kitchen@amd.com>
> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read pr=
emission in
> ONEVF mode
>
> =3D=3D Description =3D=3D
> Due to security reasons setting through sysfs
> should only be allowed in passthrough mode.
> Options that are not mapped as SMU messages
> do not have any mechanizm to distinguish between
> passthorugh, onevf and mutivf usecase.
> A unified approach is needed.
>
> =3D=3D Changes =3D=3D
> This patch introduces a new mechanizm to distinguish
> ONEVF and PASSTHROUGH use case on sysfs level
> and prohibit setting (writting to sysfs).
> It also applies the new mechanizm on pp_dpm_sclk sysfs file.
>
> =3D=3D Test =3D=3D
> Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
> Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
> "calling process does not have sufficient permission to execute a command=
".
> Sysfs pp_dpm_sclk will not be created in MULTIVF mode.
>
> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..d2b168babc7d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_devic=
e *adev,
> struct amdgpu_device_
>               }
>       }
>
> +     /* security: setting should not be allowed from VF */
> +     if (amdgpu_sriov_vf(adev)) {

You should be checking for pp_dpm_sclk here, for example:
                if (DEVICE_ATTR_IS(pp_dpm_sclk) {

Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not 100% clear.

 Kent

> +             dev_attr->attr.mode &=3D ~S_IWUGO;
> +             dev_attr->store =3D NULL;
> +     }
> +
>  #undef DEVICE_ATTR_IS
>
>       return 0;
> --
> 2.20.1

