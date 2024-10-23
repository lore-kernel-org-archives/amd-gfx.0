Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E96FD2E010
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 03:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A1610E716;
	Wed, 23 Oct 2024 03:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gZiwcWo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8C210E716
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 03:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTSTUTrDLHDibhEMrWVJ5wTCDc/LREAbQi6gLDJSE44aReJzEJirI5A2wlblHKKYxiJ5aaztkHqsiUjr5HadD1lkwYvEV00HpLXtgMEkjHS/0RjGVaRTyteos3O4na7p6n8WGLeuWg/27dxhArib+VZ3OVXbZKGLKW4p6UnIuNAo3vsyBZ4Zq36kRerQX9/gptOjoaSbiOv8vxmO6GkC49CTo200IxNO43Rlt/pz+2BYKfDYTA8bERLB8drvrh57M3GLS/4cJ5GWZtSFpOTHIpi79P9ZNUrPaFDHolMNkYciCRcbmtBs+xOgCO6Ssr56aelkJN0twlK+7myEjX/hqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymVyj2makLwETzxZ6f2JEnPbQ1ff12hgewdJeSwx7Gw=;
 b=hShlSjrEYIEYLs94sfHOxmwlrbWU2KSJ6rB3qWtSil6n4yGJCy4wjM7ohcx/lG7a5wE1SUxsDvoJjo1XofqtgQ+W6h6DDQtYwrxtocLMGEyTr8RXLHQYDJSE3eXAoq+63EWI30warGHeL4wJd12OqB8uUZSyi9nDyZlhZ1u32UYz5i7ENR+HAYNKLrvoqNlttwtdKCY3ctpcVjXqgiF4Z/K1Lir5E24jN3s836hbRLfHgW9+ZJPZTXO6CrHQLSkdo1po27qIQaTSZUfYNpkFG/HzMfIJ4r5aPJ8JUxT0ny9OEu5rhQ2DvM6mysl5kj5rOZIbu3q4p47ggmbPIRPhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymVyj2makLwETzxZ6f2JEnPbQ1ff12hgewdJeSwx7Gw=;
 b=0gZiwcWolSPB+Llhk/ohWuCmIspz6npDTBY/z0JcWGBCn6U9161Fzgzkj6nA6HL/7jVFLYzax6rGEjxGiXVNnop/QmoWN/YKxVgZUn1heAK/hwopkRd0KbZsMc5SmDAxB1i+OGZEJiN9ROAmtbLtvdYnRnHXBEgFIMKxnvZGPS0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 03:20:10 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 03:20:10 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
 amdgpu_compute_sched_mask debugfs
Thread-Topic: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
 amdgpu_compute_sched_mask debugfs
Thread-Index: AQHbJPkZBsXPuSCCfU+1+vMC9N04TrKTqoDQ
Date: Wed, 23 Oct 2024 03:20:10 +0000
Message-ID: <DM4PR12MB5152D200A28EEF7292391DC0E34D2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241018023054.1601248-1-jesse.zhang@amd.com>
 <DM4PR12MB515215AA5944BC89E6AE2384E34C2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DS7PR12MB633300B3B6EFC78AB2BB05CDF44D2@DS7PR12MB6333.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB633300B3B6EFC78AB2BB05CDF44D2@DS7PR12MB6333.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f2be1a6f-4d7f-4150-a542-0eb73b104ca0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-22T03:11:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW6PR12MB8661:EE_
x-ms-office365-filtering-correlation-id: 098d5f4d-35b7-4ba8-a047-08dcf3119a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Cy2gMrGgi78ym0Q3D//D1P5CGKPHnpLBNUOVrQEr2YhR0PTnnapYKXPda0/m?=
 =?us-ascii?Q?y8A/Z3WcUN83PoxyQW2q8SMUtPrVAWrbcuDz3dwS0QL0q8vVgzC99LClcT26?=
 =?us-ascii?Q?h+UZtIa+2gFikACmn5ZZHARhsUALEoAfgkhKDBHYeYx/bNY5PSwLEQODJ7Au?=
 =?us-ascii?Q?AF3OxKSelYlY69lQ00iaIREDDBW80JT+lS7BlXcdbr6GscV4OpGibhSzFCGV?=
 =?us-ascii?Q?6h5t4d3KONytpey9I+oS0VjaR3BeP3JLJE4TqEYnKT3RwtDZHiG4LHQ3MoMh?=
 =?us-ascii?Q?zXK4h74nhqWlzwhbujqx5ukkMrGZoGiEVuaaAed1XecWfl0xdHdYr7zEN7GA?=
 =?us-ascii?Q?NF9O9/b7xF4TSfQBJtJWWoOGlrXs4dKANOpbKHV+5b2hA9RPpdCbG9Wh8Gxh?=
 =?us-ascii?Q?zpl0mbgalqDNHLRKyuv26QrwCjgjACJDophshxso8CxZUk/NimMKMsYe6Zrz?=
 =?us-ascii?Q?althuCBdHIWk7g2NjXTHI2N8dVUbUkhuIicsmLP2Sqg7wgKi5y/UI7hjgaSB?=
 =?us-ascii?Q?jgwIZbeXxzLp9foZFKm+RocvO71D2dAOGrQQmyl6LjZr3IDa/yVTm6LXVoMR?=
 =?us-ascii?Q?ZwAgiZscsudxkncCF/5pzksGHJFnEeoT+fywHSvl7Pil+DfFsHNQKWECGDH8?=
 =?us-ascii?Q?exV4wWvEDYQAZrcoJIYgrs5TInwoEG5DcerptlA77lUlEluXU6Kvkt+3Vtj3?=
 =?us-ascii?Q?hs/pJV5uRcqmsAQFd8Bxwfjgm/9owgIKz2ZFPYuoecy9/RIKVYRm0FO/JMyz?=
 =?us-ascii?Q?km6+9JSIY9YlZ2hUfZx9RwKW96FragYMTW6BLeykg1zIo4pIPnKbeSO6+Xpm?=
 =?us-ascii?Q?mPSlV9kiaUu0rheEf3K0oDVM7Yw6A7Ca75hQjvNZTvdqGBB3LWIXjWMWKEML?=
 =?us-ascii?Q?w5MGRGegqA60kRA+kvGIjzWcwAaCcLTcwkogyyCIYqfN1r8+RLkZf4CU1zWQ?=
 =?us-ascii?Q?607o0L8B91NFx7+r0ULBxamHBMVCenWwTh8dfHJRDhZ6VnSjHzvpcl8TJj99?=
 =?us-ascii?Q?VvqpdsygpXr/y2uuSJB+KqlmpEiSaCpBSZnlvfRuvg7wEfzkE896qrj5tcl+?=
 =?us-ascii?Q?g3wm+qKUcJDKKMv+W5m/1dnLLKEl+s+ntrNOz8Zo3+l7XN82VELTXiBFeInv?=
 =?us-ascii?Q?0Bnhy+wLO04NSpBD9vMeX5kELcdy+4zPG9TPnPKTijqXK0434YlC8SUVyc9L?=
 =?us-ascii?Q?X2aH4t63EkzCf2IgnKzZme3e6kS9oG9Jfiv0GzdOka6XJEyaUjWSMNNyHloh?=
 =?us-ascii?Q?l6mgKvR2r3QhPl9pZw7sZvNxbHH3/js2dHC8AP1pqAo9eJ0pX9Qgb5JBYwnm?=
 =?us-ascii?Q?3mTesKlvEtOZJZlkTBdsBxHbEWP6Aszi57sYAeGDnBsdFm4ZfaUpvOHW+AJv?=
 =?us-ascii?Q?cwD9wuk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?60qj+SBg6Vj5rg3bXpoik+BqDZiCyfRrcqVz7Ih44XIfy8TMnqy+aB5ecUiz?=
 =?us-ascii?Q?jZq5GidsDUrMmHrTwD8t1ggUOEm3XdDhq/bcKpU+z0xYFi0s6JadZygcK78a?=
 =?us-ascii?Q?nzCVMu9BslJphfiU4A9aq0tfxdT7Lmj05iimty/8WMQsU7vbLzVWC/yQlA+8?=
 =?us-ascii?Q?OOHAQVN6n5ZltHuM39Ys+WTFkhMfdFSNsdNuZXztEBHykMIrXEyPAiUczvAH?=
 =?us-ascii?Q?5aU00IH6Y5D/5e4N4gw+C90fsJapVMxyKiCkLPIUtt5MigV/t9Cgy014atr0?=
 =?us-ascii?Q?t+qjm1oHtHac1oVfHhyJNXgKp0CBC7ue2oi0jaD48slPfTgGqotsyNndZcf5?=
 =?us-ascii?Q?4cST7mRb3DUEhM/q0cRgOm3HQRz97Kb8uNWojKtDQq+FVjHRleO8PvBcxYC9?=
 =?us-ascii?Q?C82sQHauR7nH8yyuFo/GQAk96ms/NeTKr1xTVSezrQEiLWrjh9Z7/ekzpORC?=
 =?us-ascii?Q?7vCp37XA+JFylUel0RT0GEy0VZaqcKJ3gH888ggpRPqUvgnBMVs7qX/iBySk?=
 =?us-ascii?Q?lo5zMSyaL9xxSfNpeognWDhmASvBnDwf1/+nYcvfI+9+qrSqo+Dv1Q0qQt/R?=
 =?us-ascii?Q?X6hEyOdsrG2xf3uKNKvbI5lG1x2BZagSIlxULZ1zea9Mbmrkqx/j0T6hZyCd?=
 =?us-ascii?Q?cFgzBimkpuJNLCXFnjRQdoLL3hjeyutYpt6Eb5vrH8ZggPT3/QrarLqE0a03?=
 =?us-ascii?Q?amr9KgWznCNIQA3tPQEfIqFZlKHA7h136InQ1tVb5FihdPLtnAaI9xmABtiX?=
 =?us-ascii?Q?Ehw/0cai8cqaZVZLib/dm9sKs/zFFvgssywB+ObA7z8jpq5GOk7bASpK0qxS?=
 =?us-ascii?Q?BhRJ8xw/byGacDAl617Ec5Q5Ddgn9c1hYbmffbsI1SMnLcMtqejPNbdsm2m5?=
 =?us-ascii?Q?VhjM6dXo0UfilEmNqhYXcz0K9SOaE8r2YKJ47FgQFVEBc0k3kaWV/I64fCOX?=
 =?us-ascii?Q?B2vfRPloNdBEFyveObKXJcsJeZs+FiWBDe7X6QFk60Q/tlYTTfyIHe++aHDJ?=
 =?us-ascii?Q?OGQQ7SdfZtCjJ3RtIjQe7bulVYDv19fPlGiTzDfOU8gGyNJZ3v5zubskMvVk?=
 =?us-ascii?Q?RZG498gjlCSeNPmThq2ACthnc9z66Z5w52dJOlui/K6m2XDHxSiHvIVf97OK?=
 =?us-ascii?Q?ejEfbWrDEK6Eibwjj0EntYGMrk9QNQK77yNNklP/VGwaCNclipOwh44a5fOy?=
 =?us-ascii?Q?GJ/lNJgfF+hzVDvqPwlqIpedAy98pfEB7kIPVkMKSetEMJD6sNyEkkqMn8Oo?=
 =?us-ascii?Q?A5uvf2cfW8rlu3qLvOQuviFEDZBevumUEgWwUO9OuXRj7pcH2AQ5OlIKkrjE?=
 =?us-ascii?Q?YQF9bAyU5mv4R3amITCeZ83vH4fpIr5KGfalwpQN1r+8u5nzGa1m8PdeY+O5?=
 =?us-ascii?Q?vJdnuBYZk2W325If9rBCPQQ+rYqDrLCEePFb8TRDehxvkc6VKxEJurM+/6dp?=
 =?us-ascii?Q?CnhHp/fyQiMBA4NiCiD4wf1P3qeMQhAt9owDgoCc4ksE5ySqb9/MFGY0QSAG?=
 =?us-ascii?Q?+7HmGqFJ+p4ndMBpHwgMAo0qL+qbpdFvQz6sx2D13ZIflJvT/89WnahcdkTl?=
 =?us-ascii?Q?OJ6TV4foidCUIXp290w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098d5f4d-35b7-4ba8-a047-08dcf3119a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 03:20:10.3553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNIXjGL/uaB2mIiCpurvKc+0qKLhxVZQeU7jFhM1rpVC77S7pimCgbQ8rYmf0uNibxCv7q8YmFy3dg5+VmlRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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

Hi Jiadong,

-----Original Message-----
From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Sent: Wednesday, October 23, 2024 11:10 AM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang=
@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and amdgpu_c=
ompute_sched_mask debugfs

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Zhang,
> Jesse(Jie)
> Sent: Tuesday, October 22, 2024 11:12 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
> amdgpu_compute_sched_mask debugfs
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping on this series?
>
>
> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Friday, October 18, 2024 10:31 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
> amdgpu_compute_sched_mask debugfs
>
> compute/gfx may have multiple rings on some hardware.
> In some cases, userspace wants to run jobs on a specific ring for
> validation purposes.
> This debugfs entry helps to disable or enable submitting jobs to a specif=
ic ring.
> This entry is populated only if there are at least two or more cores
> in the gfx/compute ip.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com> Suggested-by:Alex
> Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 142 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h     |   2 +
>  3 files changed, 146 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 37d8657f0776..6e3f657cab9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2096,6 +2096,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>                 amdgpu_debugfs_umsch_fwlog_init(adev,
> &adev->umsch_mm);
>
>         amdgpu_debugfs_jpeg_sched_mask_init(adev);
> +       amdgpu_debugfs_gfx_sched_mask_init(adev);
> +       amdgpu_debugfs_compute_sched_mask_init(adev);
>
>         amdgpu_ras_debugfs_create_all(adev);
>         amdgpu_rap_debugfs_init(adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b6acbe923b6b..29997c9f68b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1868,3 +1868,145 @@ void
> amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>         }
>         mutex_unlock(&adev->enforce_isolation_mutex);
>  }
> +
> +/*
> + * debugfs for to enable/disable gfx job submission to specific core.
> + */
> +#if defined(CONFIG_DEBUG_FS)
> +static int amdgpu_debugfs_gfx_sched_mask_set(void *data, u64 val) {
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +       u32 i;
> +       u64 mask =3D 0;
> +       struct amdgpu_ring *ring;
> +
> +       if (!adev)
> +               return -ENODEV;
> +
> +       mask =3D (1 << adev->gfx.num_gfx_rings) - 1;
> +       if ((val & mask) =3D=3D 0)
> +               return -EINVAL;

Is this check used to prevent all the rings unscheduled?
Yes, we must keep a ring available.

Regards
Jesse

Thanks,
Jiadong

> +       for (i =3D 0; i < adev->gfx.num_gfx_rings; ++i) {
> +               ring =3D &adev->gfx.gfx_ring[i];
> +               if (val & (1 << i))
> +                       ring->sched.ready =3D true;
> +               else
> +                       ring->sched.ready =3D false;
> +       }
> +       /* publish sched.ready flag update effective immediately across s=
mp */
> +       smp_rmb();
> +       return 0;
> +}
> +
> +static int amdgpu_debugfs_gfx_sched_mask_get(void *data, u64 *val) {
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +       u32 i;
> +       u64 mask =3D 0;
> +       struct amdgpu_ring *ring;
> +
> +       if (!adev)
> +               return -ENODEV;
> +       for (i =3D 0; i < adev->gfx.num_gfx_rings; ++i) {
> +               ring =3D &adev->gfx.gfx_ring[i];
> +               if (ring->sched.ready)
> +                       mask |=3D 1 << i;
> +       }
> +
> +       *val =3D mask;
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gfx_sched_mask_fops,
> +                        amdgpu_debugfs_gfx_sched_mask_get,
> +                        amdgpu_debugfs_gfx_sched_mask_set, "%llx\n");
> +
> +#endif
> +
> +void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev) {
> +#if defined(CONFIG_DEBUG_FS)
> +       struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> +       struct dentry *root =3D minor->debugfs_root;
> +       char name[32];
> +
> +       if (!(adev->gfx.num_gfx_rings > 1))
> +               return;
> +       sprintf(name, "amdgpu_gfx_sched_mask");
> +       debugfs_create_file(name, 0600, root, adev,
> +                           &amdgpu_debugfs_gfx_sched_mask_fops);
> +#endif
> +}
> +
> +/*
> + * debugfs for to enable/disable compute job submission to specific core=
.
> + */
> +#if defined(CONFIG_DEBUG_FS)
> +static int amdgpu_debugfs_compute_sched_mask_set(void *data, u64 val) {
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +       u32 i;
> +       u64 mask =3D 0;
> +       struct amdgpu_ring *ring;
> +
> +       if (!adev)
> +               return -ENODEV;
> +
> +       mask =3D (1 << adev->gfx.num_compute_rings) - 1;
> +       if ((val & mask) =3D=3D 0)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < adev->gfx.num_compute_rings; ++i) {
> +               ring =3D &adev->gfx.compute_ring[i];
> +               if (val & (1 << i))
> +                       ring->sched.ready =3D true;
> +               else
> +                       ring->sched.ready =3D false;
> +       }
> +
> +       /* publish sched.ready flag update effective immediately across s=
mp */
> +       smp_rmb();
> +       return 0;
> +}
> +
> +static int amdgpu_debugfs_compute_sched_mask_get(void *data, u64
> +*val) {
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +       u32 i;
> +       u64 mask =3D 0;
> +       struct amdgpu_ring *ring;
> +
> +       if (!adev)
> +               return -ENODEV;
> +       for (i =3D 0; i < adev->gfx.num_compute_rings; ++i) {
> +               ring =3D &adev->gfx.compute_ring[i];
> +               if (ring->sched.ready)
> +                       mask |=3D 1 << i;
> +       }
> +
> +       *val =3D mask;
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_compute_sched_mask_fop
> s,
> +                        amdgpu_debugfs_compute_sched_mask_get,
> +                        amdgpu_debugfs_compute_sched_mask_set,
> +"%llx\n");
> +
> +#endif
> +
> +void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device
> +*adev) { #if defined(CONFIG_DEBUG_FS)
> +       struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> +       struct dentry *root =3D minor->debugfs_root;
> +       char name[32];
> +
> +       if (!(adev->gfx.num_compute_rings > 1))
> +               return;
> +       sprintf(name, "amdgpu_compute_sched_mask");
> +       debugfs_create_file(name, 0600, root, adev,
> +                           &amdgpu_debugfs_compute_sched_mask_fops);
> +#endif
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f710178a21bc..9275c02c94c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -582,6 +582,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct
> amdgpu_device *adev);  void
> amdgpu_gfx_enforce_isolation_handler(struct
> work_struct *work);  void
> amdgpu_gfx_enforce_isolation_ring_begin_use(struct
> amdgpu_ring *ring);  void
> amdgpu_gfx_enforce_isolation_ring_end_use(struct
> amdgpu_ring *ring);
> +void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device
> +*adev);
>
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)  {
> --
> 2.25.1


