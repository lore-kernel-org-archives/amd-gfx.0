Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061FDC4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Nov 2023 03:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0BD10E0B6;
	Sat, 11 Nov 2023 03:18:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D7C10E0B6
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Nov 2023 03:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koZm5jJ7alANTC9/70EN43+hCKCbecWI/RiGoiTccQhf5h/ox3gab9lAkfzHTBVEzZ95rSrOWNQIDTAJXsgb4iiICgjioI4RabOiODFXdyqcbzN/Y3QJChNzQEUn9qMtM/RPIKwffFZT41LaQyujegJx++CRDMnaQFiABjG5YgO4s7OEUVIHO3g63/XqkQpp6nAucCi+7zHno7Ef0uvnb3zRtxKvGEC0yiHQiTyoeRKOoZArSlhXyHivUlETbLXVpF6tfGEafOksnixaXtkGSTRq3zhSbzhXumf1IlGPMiscqhxE76jxGv7oLCnYgIkD415FWyY2lCr3ABJvT6/bXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvQ6fRQMRHvUurITS3j2Tt7U6gAs/HIScyTiJ9t+z8c=;
 b=aMXAgJ25jd9ZdgSDnM+jiLSVREsSQaXz67exjdrvr5R7LCDrSDCyf3rvPKmN20OvnbPnql+wiZaq2D465WGd4YSRg/KFF3MUw2YQCRKQ30hAFKk80t2MhmIH7xGTK82xBSWkfxyku0pZL93prPQC+qg/l8WlpuZBQjDoM7l0BrzzBhb5Y4tGFA6qT29CxTnp0oNjgYGI3m1UbwT5i60kONNjoaRijrdtpqoZolaO4FOWXuxwYz4aN7q0cdMP/CZdCYSiN+kHNHnx7P7GiNWPLOGryueRPRPFStIwFZbbYSgF7gUjzh7AlGqppUXDzuuwzKBdcZQGX/y2/3qPUd8t2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvQ6fRQMRHvUurITS3j2Tt7U6gAs/HIScyTiJ9t+z8c=;
 b=p/WzrJtcZcORo8hn2JtfdYN7Nbp4tZZHnG1qReXEzR/SjvqkjDoyR88YiNVu9nZNCoAZ0Cg58KLTzyJa7oteKe8/iQme5oXrk+x8YSPXaU5ZAhwat9WZTxixMXZOq85ncCASOCivYccOlaqGrN+4Vo20/XE1Vo0dbUchPUsks74=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Sat, 11 Nov
 2023 03:18:41 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6954.029; Sat, 11 Nov 2023
 03:18:41 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Thread-Topic: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Thread-Index: AQHaE+brCRycx6UzqE6wSytaUAseXrB0c6pA
Date: Sat, 11 Nov 2023 03:18:40 +0000
Message-ID: <CY5PR12MB6369517BAB180F433F045F90C1ADA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231110150206.1900871-1-alexander.deucher@amd.com>
In-Reply-To: <20231110150206.1900871-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bcb96585-abdf-4992-b512-a27d264a0826;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-11T03:18:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|LV3PR12MB9214:EE_
x-ms-office365-filtering-correlation-id: 68a5e5b6-d9ce-4647-1431-08dbe264e6f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0Y5TGoPUHsmnw7Y2ZRKBZPsbpQBuRs5oOvudYrJqrLL3Xpi1Gg8254ohn3abcJ9v0Ws0+Dkee0XWm+iOtjY4lA5Xu0BGYyZlkp+VwQFU9Ccz0uDRWjsMRtfm46SMjnBKUJ2veCUBWeYa/yQ1dWwiFifY5zk0js5KBn+SoYMnx/PuY9qn+HeyYCAM9inb75JSq9NkCwmoCDPvkY0wqipnX18GXAjJSu39CTSlpEwxJg7MeIQMCVLToPd+Q072KdYJHUKvDrEiRJni1lsi+ICerGVT97XeKuuOGsYjVOAPq6qYKYZ1d3edMt7QDiqvYvcEg6qWf+5njLck9IOkL2cHhPHeTnBAsX7Gha0JpsKilr6zm+bKLHfhGJ7EnaD2ug5hwMUT3YtZa9m3q3LFAz6jxlFW8WbFrixrmHnh6S0+XyRrQ7OS2xwOoH4N9Ee10f2l0FK+rncOliVbD+tC1UTZZbsubVu5KLTRlk/2A/SbVqYuqEE4vKdxhCds5nBz1MsSS+BNuc3YXS+q4QT8+8KJBmNk7ApO8rkrZCv9KIZR1iwLrtcLSWGqxKqio0mWEvXclfe3s33D4lIoh1/kgocR2bCIIwjNkjGgDVMXT4If40sHq/qmVrxBgoDL8YPhA1e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(122000001)(41300700001)(5660300002)(38100700002)(38070700009)(33656002)(86362001)(2906002)(53546011)(8676002)(83380400001)(8936002)(4326008)(7696005)(6506007)(55016003)(9686003)(66946007)(66446008)(66476007)(64756008)(66556008)(54906003)(316002)(76116006)(26005)(110136005)(71200400001)(478600001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1ZBRfe0pYAsc+SRQDwMtrUm0Nv35CXYpPNIwF5aG0qYvKOv+Rs6756zjvfL?=
 =?us-ascii?Q?2dwNwuNz5P6q/gN0oXAh6eLVaMxCq9zW/ZFOxnfkvApwDJI7mO4fH3wv0iUA?=
 =?us-ascii?Q?O+vfWzd5AyyjXuXYaEGAqOk9t1vdcQ/RFYdDFeuBRHYMEQedA560p0M8KYW4?=
 =?us-ascii?Q?Qzpr4dhmVyJ8T7mw6sSGHgsDvJxW7gQjR6Ixpqcfespnp0hIvt88oMygOwSK?=
 =?us-ascii?Q?ddN7ZyVHw6Jc6a+i6c3L3c478GYn/a4xNuYwqgj628vMX8nwm6x2pNjSOdZz?=
 =?us-ascii?Q?UanC4AYnbqUhQvc6RRM3PWOBaAnw7NfKaith8VVmrIPozCVeX8i5s8ml9CnC?=
 =?us-ascii?Q?0gHgvFFBAepk1qk/jwXHaNhFadvXsWaYC68Skl/ngLvP5dLPXG4JAYtv1KZW?=
 =?us-ascii?Q?n/HAYnVsEC2GrzhSCQbdcpWKNd1uq33Gfy/vglzMZSWdUv/6Xd2TjtLPWJFe?=
 =?us-ascii?Q?+Il8XFwjvVEEed73QEJsZGeOuPY5D28HHutM7yvVomFZDlsUC10nnmTXE1Fu?=
 =?us-ascii?Q?/h96ZmZxomhb/zwxMzJbpBcz4dXZlCLj3kqrxLbTlmRYuNZvrjpzU0JAprMb?=
 =?us-ascii?Q?DgvfsZOLxB9VTaFCGkCRzASMLH9YN4MZMd50rFqXRHR5cq2f9IdyyZl0Lam0?=
 =?us-ascii?Q?YJ7+AG81F3UKMl0r6AQBwcdzvGFWCZTUB+tKDvsuoyNs8qRYUaFztOdYH1UM?=
 =?us-ascii?Q?8+FQydqRDb+68gWFF9shEZJbwa+Grs9ABgfByPKubT8N5oFKdLhDR1YBv/Yd?=
 =?us-ascii?Q?RoaUiw/MJHpufR+gcdzzqqmqYxsjvpSFPCRLFM/wJ3dw8v9Qspo1KYJbIT1n?=
 =?us-ascii?Q?KtEtmLybw4Od/cZYdMAOJp4DG+ztVw+4Ux6dldkYXkGVk0HAMrF5Pndd1sdH?=
 =?us-ascii?Q?/SHHCzqTxJnPAHFb5LoT5ZRRbEt6tVaILHFN8QHqbZF8Us7SvMYPEzsQN4EX?=
 =?us-ascii?Q?gWR5fiSbUNhCYMgJNk6Mn/ycqviJ1Glb2vAWxSSfANWPPjgXrxStDGaj5ydg?=
 =?us-ascii?Q?DLK61reQbLVptLQzQP8gLri/Vd1OPtEFVAg/lKWhTh66glu7Q51JuqeHE0Go?=
 =?us-ascii?Q?MYN2Cgkn14Y4tR1SdE+TBG9CwL4XbOnzHUNimDPVEREDETKBzuiRz4FcqLo6?=
 =?us-ascii?Q?BY8Jp69ktdJx0kGYNSsW4XBEwVLnbt2+P9/EFLGO4tNZpK3k4w2/ILqOXBtL?=
 =?us-ascii?Q?Q1QQBrabzHobeqaEMmf7HWIAWn+DHniati18LwY3eoVlz8FO5nX5iEWi2fZI?=
 =?us-ascii?Q?e5FiRvzGQ/ws0S7Zfk9ej10Hluk/OrhhcPZTuo/voiFwXPHwpl1I6mrOvjW9?=
 =?us-ascii?Q?p6HGGTGAKX0Qd49LoXrUlTPzlXyeYdxzRvTNzmSPt6TGtzzFGCLuitMk2Il1?=
 =?us-ascii?Q?MMCSoQhg0ZiOApaleAbLuUf5DMWZVtpgZFMayvRaYvIWY4ymSiK75IrmxRL5?=
 =?us-ascii?Q?vt2jy2ELxm1tCQRuAaDoN9qSQ5QoeQ191Lsr19ZvalAHAY4Cbl8oJvvDOHqc?=
 =?us-ascii?Q?r8o3+3hIs+Jol4W9Mz9wLjEMD2N+5FyjFj+OXFnPIXJMHiqPh4HxDOA9jEfX?=
 =?us-ascii?Q?/d8ea+nyvvrWZpZtyyc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a5e5b6-d9ce-4647-1431-08dbe264e6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2023 03:18:40.2491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSbS4XYSp8OmeaAI6lgzGgdxt9aAJQaICQnptU7LoVRfu4upEB8/rF3HwsbwkbZK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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
Cc: "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, November 10, 2023 11:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Koenig, Christian <C=
hristian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0

This worked by luck if the GART aperture ended up at 0.  When we ended up m=
oving GART on some chips, the GART aperture ended up offsetting the the AGP=
 address since the resource->start is a GART offset, not an MC address.  Fi=
x this by moving the AGP address setup into amdgpu_bo_gpu_offset_no_check()=
.

v2: check mem_type before checking agp

Fixes: 67318cb84341 ("drm/amdgpu/gmc11: set gart placement GC11")
Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: christian.koenig@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index cef920a93924..d79b4ca1ecfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)  {
        struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
-       uint64_t offset;
+       uint64_t offset =3D AMDGPU_BO_INVALID_OFFSET;

-       offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
-                amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
+       if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT)
+               offset =3D amdgpu_gmc_agp_addr(&bo->tbo);
+
+       if (offset =3D=3D AMDGPU_BO_INVALID_OFFSET)
+               offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
+                       amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem=
_type);

        return amdgpu_gmc_sign_extend(offset);  } diff --git a/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 05991c5c8ddb..ab4a762aed5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo=
)
                return 0;

        addr =3D amdgpu_gmc_agp_addr(bo);
-       if (addr !=3D AMDGPU_BO_INVALID_OFFSET) {
-               bo->resource->start =3D addr >> PAGE_SHIFT;
+       if (addr !=3D AMDGPU_BO_INVALID_OFFSET)
                return 0;
-       }

        /* allocate GART space */
        placement.num_placement =3D 1;
--
2.41.0

