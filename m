Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E4BC47DAF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 07:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6523C10E612;
	Mon, 22 Jan 2024 07:26:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3402D88DE5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 07:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrOj4wbyzoP54bX36RW6rNTgEEHXaOzzNk4OcINoJTaLKjmtGNRlaPU0taGkTimJzNxlQPCZaJyKo4DdocdTlsko7lotEbfZeaOusEiDNrWCsH0In5QQQjTqcPg11HsJLdqZKdlqZ31jzJ7pjgaB0iHcf9i6072dKQdVefSEAoYgBURbZesa1bScCmMoM34Ym27mxDkUPVChoU5Q020BE6+9dxK6sC2Bvr5OvjHuNDUpEKpjwF3EBDAScjfStaP/Lmgx79kTka/o4Jw1LBCbR7tmJVpbutkyVaYaOVF41IGyHuCIptfpMEm7g100G2IABUgf1nnrbT8AQKSfrwRSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFedP+7gLnXkHsMKc1QGqBjoGE84qM0Ee8oR/+Ixomk=;
 b=WrqRF6CSOO6eYTM6YMUaSfm8k+UROMXyeCQxvpsjn/hnkE1BeXh9jTOS5vcnzbY1A5JEdwrTvDMmcHVngCxh3sTqYN4V2CFY93j6pRrtjlJ/xHq0OUObTo3iIMgPCuw4bfpU5p1Numtigoc2PIvUUBqRW+XQxPIAjg+r8g33WXjVeYyVPrReAmOUiEYDNsRFXy3p6P05lT1iwQ6kDFu6Om6vq/oBkGdGfQZrgSjNtIUqA6OpW1DCPwOetHSpBsEOT5k2bQszonT9b7+b+Qxh6HHvWBq1ddMFeeWiJ7ul7JGVUQdNtUL42JszqY8R1fOH/haOmDcOeZbHJxIH6ZJFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFedP+7gLnXkHsMKc1QGqBjoGE84qM0Ee8oR/+Ixomk=;
 b=NFam9m99gNguaHXyUSK+pGMdAUKQ7DMB0HayCxNceIep/aU/AlrEXFEJ6OD+gbm5KmcdxzkLxe+8yEduY3Oun4GeKZxgOCGOJmrnrge/NscGTd4vYqXsD9gq9XVg9gt6oIagTIsJ/MnfdAAYeOM+l42oiknNwDYBcrXWcAL3Mtw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 07:26:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 07:26:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Show vram vendor only if available
Thread-Topic: [PATCH 2/2] drm/amdgpu: Show vram vendor only if available
Thread-Index: AQHaS4oZQTGj8R9GBEq5twiau3WtnrDlcVOw
Date: Mon, 22 Jan 2024 07:26:05 +0000
Message-ID: <BN9PR12MB525709EB9752041929B04344FC752@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240120101841.175599-1-lijo.lazar@amd.com>
 <20240120101841.175599-2-lijo.lazar@amd.com>
In-Reply-To: <20240120101841.175599-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d008962-3267-4ffc-9ce2-3433a6e56020;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-22T07:25:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB6888:EE_
x-ms-office365-filtering-correlation-id: 0507aaf6-6a36-47b9-9aeb-08dc1b1b64f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CEznsjgkUoxbKhE8jgL+vfAQRiDrM4CEhC7Cs5wBynlN46WutFkmFS/QTfm+GT7YZ2P7YLPdmriWAk3m4JRQxGX/kc75zNLe/6bYCrFMOxLYuo5DTFCOz8kgTuvPCRtj3U8ZCX5aBHQz9yu6uMO+nYwrL7POau6/bZXb+l5Xg6dozLmmzLjdJO8aQpRJpaXxNkr/mJ+pu7E9bpouLs9THU8gpU9WvnyqKPBDXm/OK9eR6vBpBqCVpeZFCJ9WMxq3jOce8NRMHacNktNhwBYNgF6j5CL/LFlgx0UzRxBp7giU+QZIwTk4xb9o5EiMenZKA8KZ81BVCQTvixHIh+iKipGdv22NsfXnimGDgw2dpG3u1RcaplBrQb9GIYqRgLivqCqCL6cxj09TiIE+96r3TO9/DNsLUzefHR2vqd9G4wqvl6URePNfGZOsS7SiD/NiRrjaw8RaqWev0dof5D4Hep+ANlc4uJ1HSGW5HsFl1I2r2WEwqKsK6uTlZ35IS0hZqrz7d0oxUTv9F1E/ZnUW7Oa3IVI5IzO01TZ3eH1IckfEt+K6dfa0Wkcwf3tt0b8kbRCsQ4xf3EuHuEz4RGorXiV5YJw9MXva3qCVt6VDB/QjqRXJaSXMOefAwfgUi16u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(83380400001)(478600001)(71200400001)(9686003)(41300700001)(6506007)(7696005)(53546011)(8676002)(4326008)(8936002)(86362001)(110136005)(66476007)(66556008)(66446008)(64756008)(66946007)(76116006)(316002)(2906002)(5660300002)(55016003)(38100700002)(52536014)(122000001)(33656002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?67kyIbyiGy/tFB1u4tPNkfw26wlrsx2wC0DZXW+PSZSTf+SpqLXPwV7Cd9m7?=
 =?us-ascii?Q?9Vgv4B/7etEYzpTpENdutWesYaijx3AkAJ7bGlaaTjpcIcDjbDhSqk2OfE2O?=
 =?us-ascii?Q?LG5antVacYzytiefPlMeO7yDrUK47NXo2Vao5doHbGWTg9UL0ZgP8bz0LdL0?=
 =?us-ascii?Q?PlV9lvug7duMcoabOqAf/1dR5sXPn/23qOsFHHxLxf3F0MPDkPcRMeG/eOUQ?=
 =?us-ascii?Q?gEWorGpwwa8ojICTPVf+JwfK6A41WxaEFF28VD9PNobgm+vF/XQLgEK642UR?=
 =?us-ascii?Q?aowqzV0AH5gJDbD8IYICkM+ftcDj14bmgLwouTCjqGoxLnK7mzxIlXwKuSWt?=
 =?us-ascii?Q?u+n9RZhu39XH8L68tn6T1/REpAIppQEzHRaplG370hIjaCTy8/imu7Nce/02?=
 =?us-ascii?Q?CbPAGH8azPq6b0tHY707MZJoVnWiF16lg2bWQEXhIsWRUNpOeBcxJhTnPf+r?=
 =?us-ascii?Q?/4tNGPXu+48uydajPlti1nzUwX9DHSwcVu5Mu+qbRAfu2/SMLJ0Jv7pA1IAR?=
 =?us-ascii?Q?zCvZuO2JNicN2iXbJ1iBLP9uFJtw7TAVBcz6sdIYyVxued8GEbO+NVDjV079?=
 =?us-ascii?Q?WyNUbY3dIK9fHPHl1KlXpS4dm9yTRsd/Eh7uprGNV8qsGPCk/TkkvPnh9+n7?=
 =?us-ascii?Q?5HppAJzDvIDwFZKwBrrfalwXqxMO1GfpilWvBkZPLUtbureN5gQF0BfNEB98?=
 =?us-ascii?Q?WesxgxOfEPjU2+ds7SEN2TWn3CZnUgMB29jRsWakuzgXazsQn+RpeBE98tQI?=
 =?us-ascii?Q?rPFQoZXqYU8cCPI2mazuIdupjvnFSYxP2ZmqCnxMEz7bnXiwE2J9qKXiLhZ4?=
 =?us-ascii?Q?5xpBU1F17YmKOGgHEDMqT9C2UMGesp0I3Ta8qWZ28yeSHovVZBVsuu+P/YNc?=
 =?us-ascii?Q?DdcfHg23dfEtr7jOwh7BhPwp0x/QkjwgjNChOE+s8HqgwpSioXsVM7Ij/wWO?=
 =?us-ascii?Q?14u2U8BMdorCY0QjlxO/uSE9VenN87jqJah33Jdu585utdaasJCubqa5VvP/?=
 =?us-ascii?Q?lCXJynAi4EdLHfLGR84SFrYWIYxU0lyLify0c5oXl9yAiykDwmZdw9RMXouF?=
 =?us-ascii?Q?cSb384Y6lDvOr2DkoNX7/Utri3I4lRkRyPB5bvIRjtjvXLeFNKW6wqZzvEbr?=
 =?us-ascii?Q?jnaR4Z27FskJkyrVmC2Icsu8vd07kZniyvxqk05GgbjirtGLltPTW3ihhs/l?=
 =?us-ascii?Q?5dWL/CAp7op+kG1NapxCYisx16MLg4cqFJVI7Vkzhb0DZoBLNy273pRGnAyT?=
 =?us-ascii?Q?7EgyQzRJwr98ZPzLYfYRHv9OADTKUvGgFjGg4YqwgUiJrvJ68AyyGH5FEUI7?=
 =?us-ascii?Q?szBEGGODiMftYw2L0LgzTK6yE69S6SuhUGricjoMsGW7ztUIhV5TAchCMR4d?=
 =?us-ascii?Q?+7zle/02qfpgvRaT7LDuxMFJu5Ku/FpuXs29FASU5QB4gamJrlua9bJZaMKb?=
 =?us-ascii?Q?MtDcgeYD21IJE6G04k9yu6c5unxB+XgrlXk4tV4zpRmcxCsLHpBp0/wE9Aqa?=
 =?us-ascii?Q?jgWJ5aorzhooiHH19Rk7V2AvbOeUyFb6diIbY2W87EJX7Aw3D2W4Ie11CySC?=
 =?us-ascii?Q?VmFZvJaEMyMooBqttlQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0507aaf6-6a36-47b9-9aeb-08dc1b1b64f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 07:26:05.1192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8vjU3HhMXf5sah/qv93UQOZ0QvDEMuNOSkvrUzpcxjXu2rYw6gIhL/CqultsfnPjHxZNQ82Kbgg3SA0fsYCTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Saturday, January 20, 2024 18:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Show vram vendor only if available

Ony if vram vendor info is available, show in sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.c
index 08916538a615..8db880244324 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -221,8 +221,23 @@ static struct attribute *amdgpu_vram_mgr_attributes[] =
=3D {
        NULL
 };

+static umode_t amdgpu_vram_attrs_is_visible(struct kobject *kobj,
+                                           struct attribute *attr, int i) =
{
+       struct device *dev =3D kobj_to_dev(kobj);
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       if (attr =3D=3D &dev_attr_mem_info_vram_vendor.attr &&
+           !adev->gmc.vram_vendor)
+               return 0;
+
+       return attr->mode;
+}
+
 const struct attribute_group amdgpu_vram_mgr_attr_group =3D {
-       .attrs =3D amdgpu_vram_mgr_attributes
+       .attrs =3D amdgpu_vram_mgr_attributes,
+       .is_visible =3D amdgpu_vram_attrs_is_visible
 };

 /**
--
2.25.1

