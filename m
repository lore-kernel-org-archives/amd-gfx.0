Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD446C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 12:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5491010E338;
	Tue, 15 Mar 2022 12:41:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14BB10E3D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 12:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9KP+p6rnFm301+Vi46lvSXdjOM91IQi3SUE9cYxpdgKBEeyvVOyXhoR4dTIMz2XTQ4im5mPkI6a1/eLpGUH9+HAFpTGK0wS3157p9xt1SNx1K2kauOVqtTdvQl2M8Ld4O7UmkBkaOg0HB8szow46oamPkjC50vbqWHT+C5pSr440K4Pm122l3aHZ+OFcJ/Tnk6WJmoGtavjY9vNU5xfb5aZydIJU43+LKrlIW8GpVTdUvOHppXdK1drwKg3ULwlSp1BmvRhfTLREKfH8zc2Zy3br7hIz2KpUz2R25K3aCAxjKdLIfsOmOwgv8P6QH3pwU7SkMDNOhXQHlcsT8rhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNVD2juqQg98XXwAc0xra+AjbhFTgzH2REkp4S/JqQk=;
 b=exCJyuOmnGmh7Lda6SZljC9RWShTpjfBrMAqj3MWzLLLdQB9qtWEF17adi7tTtCDuxbIu1u6EbPSf/VNuLcM5C6Xu2WfzEAV9td3YDXwGKnHgPNc6YOXOf8pxJX8F096NhB+r1W+aNW14RzdIoLBQd8UD8tTSx/dLSdOqWgFV3cOhbfNARgSoPBo+Zs5b94qpl1pnQch7vkvw6weuXRKKglm415ZQE5DGOtuLLNVsE6oA2oy9bzZqfLu54jJYF9gacqwoLz6mGIYUsHmtUYbjVDnSEUevnupU04axfDujQJqryYj1Sir3NCc/3GhWuUiPF7LmJaNhcgwQQP/ksoEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNVD2juqQg98XXwAc0xra+AjbhFTgzH2REkp4S/JqQk=;
 b=VgSCfxmL6cfFt2e0UQdgejy7Vey/ZUSf7s6pXg2hj39+InmbkHCyBEyM0+IOBSVE8QOveobmNrQW1GVR58lLUnSHrrd3HqfhldQMzCtaZnFn3WNoSHroS8SCStyaOblYDkkF/7ynCxvJlr4q4HN4r0PPGarFC7oq77RhtaghPro=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by MN2PR12MB3711.namprd12.prod.outlook.com (2603:10b6:208:161::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 12:41:32 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 12:41:32 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
Thread-Topic: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
Thread-Index: AQHYOFck8bEQjsf20ECIIWqM0Pbx8qzAWy6AgAAFk0A=
Date: Tue, 15 Mar 2022 12:41:32 +0000
Message-ID: <BN6PR12MB1187A91E34BB126B74B9CC7BC1109@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20220315102551.3581234-1-yifan1.zhang@amd.com>
 <YjCCqSQk165EKvZC@amd.com>
In-Reply-To: <YjCCqSQk165EKvZC@amd.com>
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
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-15T12:41:28Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: ada73d4e-3f65-4bde-923f-0ceb2b213d96
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e411cc23-5327-441f-80df-08da0681224a
x-ms-traffictypediagnostic: MN2PR12MB3711:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3711D1AE0208B4D4A3747106C1109@MN2PR12MB3711.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: On4h2hPCP/XWOTDHs1QOYwGNkn9Xfn+nIHyVr4Z5M82Rbz88wfyjEA/cGBI+g7dJ1lr/uOT+/0aJcrd/LjpTkQl+Ly7lnD0aDCCo0IAv+94bRQj62h5VkAsGc9LvKcxA/jZ1ZWrChXQI0YqheaijSSP46NTlN8hRIyQee9JjkP2baaV0SwX08Etx65hCHXRqvDATw2eBk5RLebdGt55enE0//tHk0PyJP/CLBMSRPKxnTXY1dE/QJ/JXW8bH2j09fmrqpQ7nfHc1rYvDMXILPKvzEIVZyef3vOzIkW51YvlO0mUy++doS5wZsJZjAL4WEdzl4MZc60grA+WPIxEn9FGvdRsMJGaHjUMaljYyAiAzEqe2b8KtCWbyRv+DttNBGRu2kETIZWz/a7URXh40FERMY/SalBh3wW49QXSvv/PXrmrJsD1bWbvANUTKJ5hvkaRE6hHqczIywnvA/rPzZbO1315K3WcxYfa8zF4KCDS+X67ip+mibxAUVHs1k8KMNTd9nMosPjRA+MipjcmP8M2g5IdbDMrG0hCmu2SQgHLcEicohkxzBTY9bcqunwxiQqkZc9h/o9Us0sEvY0Jjta1d/ys66kXBkLHzTPkF43MUYXNKuQJkQQKixIOcvlHO9gNzv6Qpcx7vgnScsaDU3WO1dimYdYU1e6s6yoT7Fs1O8mqCpB66AYsAcfJv06xFX5zQnFb9muZYmk+IZcPDdQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(83380400001)(38070700005)(2906002)(55016003)(5660300002)(52536014)(8936002)(33656002)(54906003)(6636002)(4326008)(76116006)(6862004)(316002)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(86362001)(53546011)(9686003)(38100700002)(122000001)(508600001)(71200400001)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vTQhEAg+m2UG+cji9Jy+WX7/578gWyUjC/5o+Z1JM640qTtffv1UI6skF0jN?=
 =?us-ascii?Q?CkJ9VxMMxutKqVeipnlEuITSkkqwxoR7LUznE8nKVUMibELT7TAt5+FbGEVt?=
 =?us-ascii?Q?VHYN1jYbVuaFpqbT0WikTz1n8zs4pgURsiSERtKtoeaoj0/P25DY06bxUiV9?=
 =?us-ascii?Q?Mr4wl4TUzs5Zf2ht1YHc52AWLb0BZkZxC1fvmPNo/nXEX9CwC6+kDXoewR4W?=
 =?us-ascii?Q?aI8OhYLhEa3+0xmllenjMVtegP/0r9pSpTi4vx3Grt7ODPOXdgTzLQsTPJM8?=
 =?us-ascii?Q?r5f65fGO0+DG0tkpWUmuCRYoGq6pXpaPAUQjWILlUWHSVDn5AUQkYW7wFOdw?=
 =?us-ascii?Q?b+I+ly5NcUCqyF7yTlq0dHhuWTGhLJ2Y0pXvOsvd4YET8LcUN8jb4fxwbN0z?=
 =?us-ascii?Q?PVK+/kZx3LZbgN8byCQSA/X2jPJrKJNLLOXf8CLaP1K5YioAk21C0IoenDoC?=
 =?us-ascii?Q?AJN9fUhvaRseG8UB+9T/I0Sz1eqmLGXda1ZgFNB/nPJBPr5tKO5qQIFpzYN7?=
 =?us-ascii?Q?rN2gcVtG2TEFR5q/6RZKQRJtOYETLbhg6R2N4l1NP7aB+8wnyEz87/smGgNQ?=
 =?us-ascii?Q?sQyxmyo9atfmf1rVyUTFK/w4gsTWRVEaKuBWbAoNNdVCkVdRVB0rLupXJbsL?=
 =?us-ascii?Q?7jGZ/4sszwY6hsvutzl3x0m501maKRTjpKFOzHAhJafPV6Sfj6zfG29O8o+j?=
 =?us-ascii?Q?jkdoyIgA+bHy0D4t1SoXNLdDc/GmikX5PYBp+Jar8BWHTzRNUeZd+vd2IsxU?=
 =?us-ascii?Q?uv/7H0arMEze+/agWahE4/L53YyqIoi3Un8p9hiHieVSGQEHesmBSA4iJI8Y?=
 =?us-ascii?Q?1UPkn17IjFTqvBBGQq7+pzJxTvCu9Zuml3EbiTa2JZE4wqqHM7c8uhaDlF1q?=
 =?us-ascii?Q?+a5hzlxsC8qucgYgEcTTBGjxB6cw5NiK916A9atcQuPvXf5QIGjYv9HC7HSK?=
 =?us-ascii?Q?0v7La0YEoARIOZWsxb1qwvwakbj7XZXryEhE1tMKdWlYquHleUbSIVrMDxjK?=
 =?us-ascii?Q?uzJR6UbTVKZdl1zy1hG3LTaF6FCPMlUTm9DSlfnA9UxV/xPrdlesU1czhCip?=
 =?us-ascii?Q?R3RumEaxLyWhMVOAO3Ch3fSWgij7PrzAkul+X40c7Q9wp54+NABZCKahEi2G?=
 =?us-ascii?Q?3H6t3kuUehgDg3xlKF7ixkzUEx3j/8rgpb+kja8R1dgM+HXoqF705QKJmzti?=
 =?us-ascii?Q?igmPdbOA2PiNUiAXbkBkupEbbsVlwre75cbFKpez07rEzHcnJX63Sc38fwZS?=
 =?us-ascii?Q?iEKodVcmmLd0o0+rIRwZrvs9bZkyS9Ws1Gs371EU1c6FHXTdCFF1183G+emT?=
 =?us-ascii?Q?vJBe7mPGMD8ikjftaoERMZikppbm6LlveFIPYqLw4CnS2adLuvZK9h6Os88m?=
 =?us-ascii?Q?HB2mxA9PCNOC5Ag7E9NLerkgLDNurDeRPDMSRCknd54sqhIcZO/+PXOeJniv?=
 =?us-ascii?Q?EysItRkb5AE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e411cc23-5327-441f-80df-08da0681224a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 12:41:32.0796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CzW9TH472V4aBkznhpnnsM3hNWNgwBcsA60wYMiNRnSiHwm/K1jWbvRMU7Q8E3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3711
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
