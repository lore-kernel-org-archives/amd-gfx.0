Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074DDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 08:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C8210F233;
	Fri, 28 Jan 2022 08:52:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6943610F233
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 08:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlVwb3Rby2ue2/AC/Qd9owHGz09riegskJjYBsezp/4+x0SOv+yJKJP2W7eM8zaY6oFyz0NCXC+/50kVxv7LMxc3yK3TribfxI9P3ySikQVuflvDFCif01FGwrO1eaNscdyWGJ4Q85TUDzXGu9LyW0rxKd7ll8RZHcxsWUx8rgQFaClTOri8v1lFmcd5nJVcRoK/6kSw0D1/PAbtdI3cdlZ2bSnISSNhD5Ft9FT3NJGaujEyh0aSNTX7JQH9NVfyu+HkYYfpV+VwV4EzwfH734z1ePQQ95z24TyoeTiSSf6Q1i2h3jypAgoKvrpiWrnK5jnUwOm86yylaHbu4DDXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBEftEUzyfLvWpJ6yZdrbgEwpPNCX8EipvW2JK/Swfk=;
 b=RYvt2LC2iDi2wabHslelQfW2Xa0tkP9KPL5ez7huTNuCuw5dLFu++1bqi9kok57Um5l1hWBMNBHT37PmhBf2GkyQ7YIbNl9TzPHRZ4NXNoxHQrRgi96pJcTlauswO7d6bozZhEjIJRF7UVrYPRlEssoQyqmz8ZU1cE8kLnqPcB+DG9HoNIfKahvZFTm8099XQhqKi2bZUd+4s9knFQd+de1MMBKgeTZb4CQIOe2Ta8Fsgh9p3eF2ZIW1iqulVrzhivALjBVj5+vVsKdkD4JloV2l2uSwK+ifylOPSZx7mEOYob//y+pIPqpP2UuzMNDlf3cFTGTvEdcXtof1bGW5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBEftEUzyfLvWpJ6yZdrbgEwpPNCX8EipvW2JK/Swfk=;
 b=YlKVPfBlevjjrjA35rSi2iqkGufUA3P53HS1mL245sSKK9lD795n4LJQYNVZGOEOOtgKJFb2hl62iBPx+4EB3sdsHdryzIfLKBGDrW0XXSSIxAwA4mfmvuKksqoD1nCRb7Zz15T7yrfmaEkSX43l/0dqe9jOAi0JGsy5UdIRQhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 08:52:37 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac%8]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 08:52:36 +0000
Date: Fri, 28 Jan 2022 16:52:27 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: add safeguards for querying GMC CG state
Message-ID: <YfOuy/sVoKBpJI5+@lang-desktop>
References: <20220128065409.1479854-1-Lang.Yu@amd.com>
 <d8bf41f2-6aa8-8af5-c5a7-ba0750549a82@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8bf41f2-6aa8-8af5-c5a7-ba0750549a82@amd.com>
X-ClientProxiedBy: HK2PR02CA0173.apcprd02.prod.outlook.com
 (2603:1096:201:1f::33) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e908050-3977-4bea-13cd-08d9e23b885b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4372:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4372A56D11DA479DC637D12FFB229@DM6PR12MB4372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AuDhEiQHqjMppg+2EYWHf1gg9FX4k6G8Ip6iXe4PGoBJm1V8Lj79NAIxpCH/vgPUWV03+gUpZIb5YTaFTG46HLzQH3/EiF6bSyEPlE6YBrOTv5gQ0ygO7vPz8qBZbNy4a5E3L6a1xdEgRHYX9A5tHfYYStPwEX2jnKAYYuYXs4X5KTT9kjyJZZnAc2SdQDZxWwOkaPOjoNyNLbPTeDaBtZnLdLsUpaRkFUgavy/eagJZnAW0SldI2MaDBlVjG6eJ7v3o56dcsy+U9+apzMQ9oEVMCu1oVEzPj3L2aiOM2Wtu6P8KePFQ3qhJMjjMNnVrDEoy1NwEnUhIHn8UPZeZPcfdUnmCJauc7vndWtHRh97PDdFvCWfaIXiL0XMd7+Tv26gWKDsmfgJJgAkbf7nh7HP8Zf5JPFmItcwatLPdgvGSccUR0o0QfOMOdutYgqBHpMGshS8U3yG7j0d8bcOAecDFVElXmqetF4UfyfqFT0kSR4gjro3XkjvBNbWk5WdmngaxExuFOPzWr4RIat5rTytlUfKs2IPMpFZAOSGvjtJ/2GsTXLRaYYORoi5sXWbHROofkvgwi0WpxxzVbxEIP5Q25bHjOqNWzwtiEn+mCboaZLEpLFjW8AXOGY0tRlvyur8WBG7+2E1OXkDnnziaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(6862004)(8936002)(4326008)(83380400001)(8676002)(66556008)(66476007)(66946007)(86362001)(186003)(38100700002)(2906002)(26005)(33716001)(54906003)(6666004)(6506007)(6512007)(508600001)(9686003)(316002)(53546011)(6636002)(6486002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1Dho9xweaNckjclohQEY1QAXEk/QH/KgpHSH1pFuTdXinakOjrXa1/crxs2?=
 =?us-ascii?Q?A7PHw4zbmKnLHNBkOHWsfAhM8pFo1u60fcsj4/AAlqR15bquqjB62SfneuAp?=
 =?us-ascii?Q?PCTULstoe6YIGIe/EjZNNxG1lk+V+mHb6rNCWC+ZDjEtcQRYQZKVrOjtiSlp?=
 =?us-ascii?Q?dQB2tsRsnjqMIUEFvy1hMOryyfMy1akJE3d2llb92UWxlc3mMZUuoLU0V8DK?=
 =?us-ascii?Q?EwmxqbGX+lTAeKKv8VvpqAsldA4cxKOJ81Jlgo8oovO/xvuNOCNpar086b8r?=
 =?us-ascii?Q?2/mJ4ABpkl1+3r9NqKIBqe64xR0veGSUNoJCb8MosJkyud7zmQdNGXkL2eOj?=
 =?us-ascii?Q?nb/7sfb9GVPbclmShsSot5uXX1KLgMQOM+yix0EGgLeRtdfTsACveHs+ad89?=
 =?us-ascii?Q?54xRPPAx41JMMDJa1Hvi7w7e/XZj1tSf9Ens/kp+ltCJ19tBS66xf7Ry6BGA?=
 =?us-ascii?Q?MXOYkg72hslai+75xXGS8AYy/ziEleD1pAMORIy0ag7Np3+8WTvkCf8nC3sn?=
 =?us-ascii?Q?ROia8qvrxkKTpZgXbalaplpluEgHY5HAjdJIh2X1myY0WcKGvxbVmoF9ok1X?=
 =?us-ascii?Q?jbTrYejTWppuGjU6yL5sGRJ+aVDSdjAUsqENujnHUpvWbVm9wWtDs7TDDscN?=
 =?us-ascii?Q?GXwtcfXzcYtEehxTmkLSb8R95bdJrYetwP5gxT8OYy9OwdeeUFGf0xyEqjvK?=
 =?us-ascii?Q?I7ZQEPmnWylo4tXSiRhaoJ2nsDrtYhm0Z/Obt2UlnVRgDBsKUT6BebCKSjqE?=
 =?us-ascii?Q?DfYO5cpdx8iwf+Dg1HZUY8OjkCbRLFxgeuNKYgo5W3pRWjaLAefHRLhB19i4?=
 =?us-ascii?Q?a0vPFS3VOZAF8GJV2qYOMPqL7p/evfwG4EmBAlpw2fMxHK90craFdsDEI4Gc?=
 =?us-ascii?Q?Aj8FvrLxUdP1MF+4IC+v6vjnkghna7zOdtTnzkmvDVq5AQECp7vkF9o8Gj5j?=
 =?us-ascii?Q?YPDDvn+S7y8AiCXU7v0j6PBdz9YcU6/xAshUSeBUIqyQNwuWhz0EvOPuCxzj?=
 =?us-ascii?Q?4QV6xkiOfH3hnHbEhzFhpD2p2fnYroeKp84T0HqkejRXQqe1EvX0TXlf8ZA9?=
 =?us-ascii?Q?WxLhCmpyCfZjMaNbxO3Pg50VhCu4DRfo2KFMqYitc6Ew5iRCPgptCaM2HDsL?=
 =?us-ascii?Q?brt6qMUyjIuoJEWWz2VR1qrDumMLgHcFSTpnb+aYROAuPf69dkeigxywD0YV?=
 =?us-ascii?Q?FfwLgJ3N89hYCDPS4jZXCOeNnAHlT5p8BEsUcbEXjU9WldzoAWzZ5ObMdmME?=
 =?us-ascii?Q?njqBY0anORre9wa87CYW18upvPZNanPH4HIslOjzGO5hAw/+ybofNXPBcplj?=
 =?us-ascii?Q?ZPsEO1H8BXj73UphX9DxUckPZzcLC4lzhuVgxHXwo8oM7GIypL8bJ0uXs2TX?=
 =?us-ascii?Q?4OMcGHcpHN5Ll0wjol6YlyquTySdV9EbXvHeUK7i+QVxwZ8ZWSpwdpJFXLlG?=
 =?us-ascii?Q?1GFst9dSHN6V32NWSd6KqQJvNUVNkErKLjqo8QABVMoKreqCxaKwkAQK3HkO?=
 =?us-ascii?Q?Ouc/Xl9OGhIX6Jc5tCbzCCIdOA6dkGC7pGLnxBxnyj79NpDlBOOYbv33iNYQ?=
 =?us-ascii?Q?5rn6U0bxzrSnz89DbTAk9kWUOVKkOuMaQ9SHOeB0QLMl+s4rH1aHEricCQ9q?=
 =?us-ascii?Q?OO8O1hivBsbq7gglpOrRVvE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e908050-3977-4bea-13cd-08d9e23b885b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 08:52:36.9503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygWoVLX9uvC9UvmgGLtcZaVgVO3CkuqJPOymse8d+ULc6DXkWPiwCwZOPFdT95PChjBHLrR+NqOWLW074Ca2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01/28/ , Lazar, Lijo wrote:
> 
> 
> On 1/28/2022 12:24 PM, Lang Yu wrote:
> > We observed a GPU hang when querying GMC CG state(i.e.,
> > cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
> > skillfish doesn't support any CG features.
> > 
> > Only allow ASICs which support GMC CG features accessing
> > related registers. As some ASICs support GMC CG but cg_flags
> > are not set. Use GC IP version instead of cg_flags to
> > determine whether GMC CG is supported or not.
> > 
> > v2:
> >   - Use a function to encapsulate more functionality.(Christian)
> >   - Use IP verion to determine whether CG is supported or not.(Lijo)
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 +++
> >   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 +++
> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 +++
> >   5 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index d426de48d299..be1f03b02af6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -876,3 +876,13 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
> >   	return 0;
> >   }
> > +
> > +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev)
> > +{
> > +	switch (adev->ip_versions[GC_HWIP][0]) {
> > +	case IP_VERSION(10, 1, 3):
> > +		return false;
> > +	default:
> > +		return true;
> > +	}
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > index 93505bb0a36c..b916e73c7de1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -338,4 +338,5 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
> >   uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> >   uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> >   int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
> > +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev);
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > index 73ab0eebe4e2..4e46f618d6c1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
> >   {
> >   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +	if (!amdgpu_gmc_cg_enabled(adev))
> > +		return;
> > +
> 
> I think Christian suggested amdgpu_gmc_cg_enabled function assuming it's a
> common logic for all ASICs based on flags. Now that assumption has changed.
> Now the logic is a specific IP version doesn't enable CG which is known
> beforehand. So we could maintain the check in the specific IP version block
> itself (gmc 10 in this example). No need to call another common function
> which checks IP version again.

Thanks. You mean just like this?

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 73ab0eebe4e2..bddaf2417344 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 {
        struct amdgpu_device *adev = (struct amdgpu_device *)handle;

+       if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3))
+               return;
+
        adev->mmhub.funcs->get_clockgating(adev, flags);

        if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))

Regards,
Lang

> Thanks,
> Lijo
> 
> >   	adev->mmhub.funcs->get_clockgating(adev, flags);
> >   	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > index ca9841d5669f..ff9dff2a6cf1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > @@ -1695,6 +1695,9 @@ static void gmc_v8_0_get_clockgating_state(void *handle, u32 *flags)
> >   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >   	int data;
> > +	if (!amdgpu_gmc_cg_enabled(adev))
> > +		return;
> > +
> >   	if (amdgpu_sriov_vf(adev))
> >   		*flags = 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index 4595027a8c63..faf017609dfe 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -1952,6 +1952,9 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u32 *flags)
> >   {
> >   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +	if (!amdgpu_gmc_cg_enabled(adev))
> > +		return;
> > +
> >   	adev->mmhub.funcs->get_clockgating(adev, flags);
> >   	athub_v1_0_get_clockgating(adev, flags);
> > 
