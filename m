Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66CAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 03:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6171410E832;
	Thu, 17 Mar 2022 03:14:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B6C10E832
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 03:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnR4KWrBzlfLKlQ8KvzfLPAD82sVCTWToT6E/yXt+VRbhRxDHOwWaeDrAFylIF+aNNVTvkiSC93b7MhsT11BuEPK+hz3MWoUzq8ObqOLwBJZ4+nsf2ZXDpGRnsKjtpj4/22x/jS5AWSA6XRazhRuX1YeYfI1+/xIDwZ870tR/9pz2QZe0IX4ECGPhg+uQwa2ZehzGp0P4QswBSijMesNHO9t0A64CTZrT1vRAkiPD2vanxinjVwU2G9pu3JXGcEcxykRZ8erT8igwkQ7Y6egKDLYJxE8RyYm9UNVhTrIkRp/7XsgHnGCcR0CreVU1k2EKHpRyuF2SHAEDvuPd3AGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofeCeTtHB+bhoZjiyRCbsPLcZIfCddYaWtkbyN3iZWk=;
 b=hgyXCJqpEyuy9RJqMAdrZsOZ2FKVEgOCr4mQpVSKr+2hCcGt8lD/SQcuvxMmM2XUd0xFg4BrA/Dzn1S1VhU230hAIcQBlK8D6lex0hd6MzF2M+PyGdpqsTn9RLV/GrQbV+QVjbZPZyx+kkqE/szCiLxE46UF1zS3bMtvr3hZal5yaHTp/5VsU2oy0D/rP9yB+FKx38QS1vy9TeD0TM35LG4jyW3/vbskp73DMfU7aEvzP9y6fYyoiOu0c4reiXfBTB4+WhbvCm+Qe7dmJq+5krKjDkeQdL1o9kGLv1q06rcHLfTrJyQtgH2ZmtLSRlQ3jqeG/BCWS+bhjsEjiz/HuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofeCeTtHB+bhoZjiyRCbsPLcZIfCddYaWtkbyN3iZWk=;
 b=5M2/nPIYQ7C5zFBrnxh0DiuCOTrRQ6X/PFRmn9/LgyfBqbbsEMBS5p6hkr1p4Rbw9wKo5cnCnZX7yrCEK5B5FASZvZUqM9B0lpAp0AF5MfGdBlHctIq0LK4h3M6itlBmdIwr9lPv71aG8jCKz3yDFFFjhdcrirWTDAtCezi4o3U=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 03:14:53 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0%6]) with mapi id 15.20.5081.014; Thu, 17 Mar 2022
 03:14:53 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
Thread-Topic: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
Thread-Index: AQHYOFck8bEQjsf20ECIIWqM0Pbx8qzAWy6AgAAFk0CAAnEYgA==
Date: Thu, 17 Mar 2022 03:14:53 +0000
Message-ID: <BN6PR12MB1187C7E45A40C7063C185249C1129@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20220315102551.3581234-1-yifan1.zhang@amd.com>
 <YjCCqSQk165EKvZC@amd.com>
 <BN6PR12MB1187A91E34BB126B74B9CC7BC1109@BN6PR12MB1187.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB1187A91E34BB126B74B9CC7BC1109@BN6PR12MB1187.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-15T12:41:28Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=436d5af7-88c0-4488-9d32-c1d491d3f462;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-17T03:14:51Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 510b56af-e03a-4e52-aacd-7b756d382a47
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7796f512-f99c-469a-b2c4-08da07c44e7d
x-ms-traffictypediagnostic: DM5PR1201MB0027:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB00271077133738076C07D353C1129@DM5PR1201MB0027.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NX+ZAiXXSBFpAAT8rYlFUqfdHQhgnDRkFCB/wKDhCopvcDK9VY0zCLQPPJno58kegKk/zGU2lDqPJT6vzXlUgDlAKKQCU4GRdZ64nyl7Tq8ui06uyFzxuYxd7UtPvIAUGcQe85v+uzhJLMPPH70QcuG3DffMzb41gnf1NviqhzhmGHJ+cQcQbWLLhZie9yVHFuldYWgQ77kX3eHL6yt0ixkk2l9mP07UVZvtVGRhMYeb0dEIjJebkTUwtCkXZeX2FZiNXygcvlVxED9tIal0e52tOkrIm+ur7ZsJAb344qB7UC6xqSdClsrqP3e6NCH4ZQTDAz0qytwFobTDiJZarkhf8LaNpbJpFqJhspQpvEDwlJZwhqurlZuZr0dXvL80svCxe0PvsTER63M01+4+mgcCcz9ZrgtGb3emVGxqIXkNDLtgoVXdHYL1ASrHqh+MlzBDQT2dH8GsnVef2kRwz/sh5g+8mq3iA2YWyJt84hFxb56gq23spj342uGoP2M8f9UxnB/GX1/ycDkPux/a2UsVfNnZQggs5JBmBmzIbD232a3GTMly0Fb+i+OuplXKCgoWN2bWaR/mPZ/BSzUoWeuS5KW+2qtX6p60ts7g4CVnthNPG3slN5CHCPqOUcCDsjftXkGoOfYcRdK5LUkKqcOy5S8oDizCV2Qk5wypMU/ZyMV6f/qEpaTGleg5KqM8vvDwt6lTZbqkIEq8UDE7aw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(508600001)(2906002)(53546011)(5660300002)(6506007)(7696005)(86362001)(122000001)(55016003)(52536014)(9686003)(54906003)(66446008)(66476007)(76116006)(4326008)(8676002)(66556008)(66946007)(64756008)(6862004)(8936002)(186003)(83380400001)(33656002)(316002)(6636002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RGuPelJs+NfzePrOZGwtWAsdabePzQE48SpCqryY5pBSxuyfsGiSbkENYde+?=
 =?us-ascii?Q?IwOy3h5c6+jy8VDScfBk7iLjqUKGjRlUuA+jh+bACa2Jd78u/gCZoMI12gyH?=
 =?us-ascii?Q?7cAMsKjzNSW1S4xUgXxOmus3F0SU56f7bPHjsPMlY86iPVVNjEbSLkUc9SmN?=
 =?us-ascii?Q?Ya2P7k866XcHCIzOqLoVX+zDgy5DZSJ2ySTh+AoDchj74ifz07H1GU8znmBq?=
 =?us-ascii?Q?syAWmhpK7/HXCu7zalK2FT4tK1PfVSwfkp7HhhKuK7RIbuQYPUz0zMCp9L4b?=
 =?us-ascii?Q?XXVPqO+Zc/+s3DJPMpzUHzDKWLA2nkPoxrUfyZmOOLG0oevstW0CvsXfyTQ5?=
 =?us-ascii?Q?MF/beMY46G8lyQbSTcJc2y2GuPLaEVQ7oQ4ZzgRobvsjE06c9z2unX7Atouy?=
 =?us-ascii?Q?KWcuC1LdcIe9/fpkaIjP2/aOKFsyK4zkQr3fmgDAVVm3hq7ClxSjUTi1D4VL?=
 =?us-ascii?Q?l1MB/EoF8mG9aCV8nz3KQRVf1fmd+0rA7GL4a6nYGYyF+CHN4d/K4tC+UdZ7?=
 =?us-ascii?Q?lS95DAWdXNaTPRL4lrUOUHpMgHADsy4PkOtsgTG+vpR68lsyzdyBOcOTiYVg?=
 =?us-ascii?Q?8v3F0s2iV0in1yCoEBB8bugg+2jUR+y5vZa4XcdgNX0r6hN25JN5JsSHpDoy?=
 =?us-ascii?Q?0LFy5EQVOOIlhMOXSaQKgg+OT0eZUDJqPiSA5vaz4d74XBcxQsDjE76r/mle?=
 =?us-ascii?Q?g3tdMzMlu//iBedgwuPCrs++Nj/jFJGjcFv702ukKoUcBirKXnR+HbTn3fsj?=
 =?us-ascii?Q?/uG0QVe2NEYWzLmHNK2jAsZwYE+UFmCJDquKDF5bDcR8NbiYArzy20EGW1qc?=
 =?us-ascii?Q?Fm9Bpy5d8Eea/FSngI+/p23YgON3epoLwv8+LcNSGzqJAvXh5TFgNY8h6riG?=
 =?us-ascii?Q?WHrZHs2JQarGdcRG7hf4zizkwbN9xi8fKxOiW+gb9hTE3ecNOYrnx4x2Ta01?=
 =?us-ascii?Q?jyjWxL2cgUug8xJlrMjAi5B3yzqyN0uUwMPh1eN3wiYzaoku0aXISdvtMs0z?=
 =?us-ascii?Q?541Eqt8+d6niJLNJtRy9/tIZPvN0zrzvZ59k8hzayGbqwU6Ak12P167BEAAl?=
 =?us-ascii?Q?KflHQ5dk3UmeaNVTqqoMsmU/hakRiu1XEUpXCzRy7hAfLIVRWvCnbHLvJ5aG?=
 =?us-ascii?Q?593u5KxPWk0pcR0zdqm/0Yap02zBEFvmF+49npRb+R9lkPsQRIVVUS1nqGjY?=
 =?us-ascii?Q?D7k75tboEtxC0ouidMXrh2JNJJtQ2T0ZZkUL6oVqHnfT58Yh7AfjFnfC9Kxz?=
 =?us-ascii?Q?H2dFQwraLIyM89laCYdct2L1DSykrDU6z61P/pAF7G8lTG2Eb9b/3JCwGEqf?=
 =?us-ascii?Q?9fqZtVoEN/hc4jf21PhGZSMR7nFoZ0zO4n5fbl7smT2AAFpaPf2W19ne2g6b?=
 =?us-ascii?Q?B0zvciSb7QI1ZUyLIKKENGq8eKKDay6fUAYgPHozFzFFwJuQE1QhK07a54+Z?=
 =?us-ascii?Q?j6Uwg1795vrHInAp6baP0ZjadCZHeHF+grcdHmdnRZgwQGmOA9Ns1oUrjywJ?=
 =?us-ascii?Q?otCbeisGtUvd4AU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7796f512-f99c-469a-b2c4-08da07c44e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 03:14:53.6785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94OsIBbsqmwzJxAOS8yvtknpM5R41MfOJcPPU5VPM3/d+/TAK7FlAHCwEGnKrypA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Since it is a generic swsmu issue, shall we merge it first as temporary fix=
 to unblock amdgpu_test ? As most of swsmu_pm_funcs have an assumption that=
 pm.dpm_enabled is true, if allow this value is be false, Lots of swsmu pm =
logic needs to be changed.

-----Original Message-----
From: Zhang, Yifan=20
Sent: Tuesday, March 15, 2022 8:42 PM
To: Huang, Ray <Ray.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Subject: RE: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_te=
st

[AMD Official Use Only]

I think It is a swsmu issue rather than a smu 13.0.5 specific one, in curre=
nt swsmu implementation, smu->adev->pm.dpm_enabled is always true after smu=
_hw_init, doesn't reflect the real DPM status; smu->pm_enabled indicates SM=
U functionality, also always true except in sriov.

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com>=20
Sent: Tuesday, March 15, 2022 8:12 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Subject: Re: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_te=
st

On Tue, Mar 15, 2022 at 06:25:51PM +0800, Zhang, Yifan wrote:
> If GFX DPM is disbaled, Stable pstate Test in amdgpu_test fails.
> Check GFX DPM statue before change clock level
>=20
> Log:
> [   46.595274] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:02:00.0 =
on minor 0
> [   46.599929] fbcon: amdgpudrmfb (fb0) is primary device
> [   46.785753] Console: switching to colour frame buffer device 240x67
> [   46.811765] amdgpu 0000:02:00.0: [drm] fb0: amdgpudrmfb frame buffer d=
evice
> [  131.398407] amdgpu 0000:02:00.0: amdgpu: Failed to set performance lev=
el!
>=20
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c=20
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index 7bfac029e513..b81711c4ff33 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -991,7 +991,7 @@ static int smu_v13_0_5_set_performance_level(struct s=
mu_context *smu,
>  		return -EINVAL;
>  	}
> =20
> -	if (sclk_min && sclk_max) {
> +	if (sclk_min && sclk_max && smu_v13_0_5_clk_dpm_is_enabled(smu,=20
> +SMU_SCLK)) {

SMU driver actually checked smu->pm_enabled and smu->adev->pm.dpm_enabled i=
n smu_force_performance_level. I am confused why these two flags are true w=
hile the smu v13.0.5's dpm is disabled.

Thanks,
Ray
