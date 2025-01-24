Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9AAC02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 06:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B7B10E2B3;
	Fri, 24 Jan 2025 06:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jRzX8KTc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791A010E2B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 06:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xr2s6fOgcpy6EbT04YkFbFUhc2dXKpxKQxf2ywyFqG3gNYN7Gl+zn4Ab0JBlLl8hN0r8QGLS6oKF0c7e1xoi5ngm6/eqdyT/f+cAnAxZSpXDWiz3NAkXqCYGTkpzcKmPk8RWEJEKoLHJslRULWY0sWfBTIq9xsUQIJOigjlaND1J1dx5dfKAS57C1Vrz4LrjkFgKHEUrD0flFHQdYQF0I9/S3ObwKcRz7qdxHh+SD2cUvMsA9/PhZDo34ha72czqVRyBwHju/fCRqaCnwVxRECQxoV0DvXRkbDcYgTusK/0MpDb/TqX8J6ht5IHZe/dkv/y7SDz1snYYspcLpg5EQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn6WU9aVbkTXdvAEytgstYY8kBEvD1Ut++oPGqlGMUQ=;
 b=Ba7I3n+sZMgZv6MhlLCOfLiNZl3g9cntid/fUXCLd9ANQkOUDqauQIP3eIwHZ/t02XPQIZIMqb5nt3Mqvr/lZv6Y48DnoN0QqZrO+FbV536me941i2NTnUb6zauWUEoa08VA3ZTMSH/Xz0vkU6hp0Yy8NpmyauApHP0pYIjZnX3WCyRHOSSELufC+xbrUSnYonADidXVyIK5n81aJPiK7cxLlyDbY47KDEZPCKgaEqUr6I5PmpL4J2IQDYkIK05Ml0W8cQYi7rA99jv3y2wvA6UcPJMdfTRVp4L5cFobei+QFnpEbyiJHQzWviWIPsMB+4LQywGBUYxftyhTW459Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn6WU9aVbkTXdvAEytgstYY8kBEvD1Ut++oPGqlGMUQ=;
 b=jRzX8KTcPKKTd+eYFLaLF+zXiyxSMzy4UA+sK7Q31n/GLrLC/kANV27RpAS+RNoC/VeSxIfdrt6gKNgReJgdEZAc1AkA3vXGbEIQlQrvHx6xAlVazjgVT40eAzmqvi6MCTZ4qaf2z6qmzCu4PnmBIOQVK0/iZX6+fbomwJibDkA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Fri, 24 Jan
 2025 06:39:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 06:39:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 6/6] drm/amd/pm: Update pm attr for gc_9_5_0
Thread-Topic: [PATCH v2 6/6] drm/amd/pm: Update pm attr for gc_9_5_0
Thread-Index: AQHbbLPo5G7WGKMFFEKhTBfr0cXWZbMlfAqQ
Date: Fri, 24 Jan 2025 06:39:48 +0000
Message-ID: <BN9PR12MB52572064655BB8EAE2FD5A83FCE32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250122095543.148993-1-asad.kamal@amd.com>
 <20250122095543.148993-6-asad.kamal@amd.com>
In-Reply-To: <20250122095543.148993-6-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=63611dea-4e24-436b-91bd-a8aa74d611d7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-24T06:39:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7000:EE_
x-ms-office365-filtering-correlation-id: efd9c7f0-0b2b-4c2e-19a7-08dd3c41e5d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gDzjb2r+Alz5h6chmrjS6qek3EXimpWoNctq6xLdhG/NmJ26ZCxAoiPyC1Hv?=
 =?us-ascii?Q?qs6L5u0o8ulNr/z3i8HptXzdRX71WMvI1wRg7CgGWudV/6lq/vZeY3SdA8wh?=
 =?us-ascii?Q?SU8yRZpZCzfcft2GKD37YhB7cBOfDFpkCbXNoP01onf63h9QLsFQNFw/7rgV?=
 =?us-ascii?Q?x6mZkncrCaGO4stk/7GbWI01k96HF2WZZ1e2UVkGuSLVOmE23K++5R9pshQ1?=
 =?us-ascii?Q?qhMP/cG20Pv4pYtHgeBCKvDZ0LUEIqRDck7AsAvLrY6qnkBHiBDwUtZyXvmv?=
 =?us-ascii?Q?73ootJI1ceZArKML8cVoCuZk5eIHsS48ZKMRrJZNqwzz9RLh7PJYenSeNddQ?=
 =?us-ascii?Q?Umxn+GrgdVU+aUtBMxRoVTi+k7YO5N1eF1I+z51eK6uoWN7sPGQyOUZez3aJ?=
 =?us-ascii?Q?YC1IE+3p9TZcw62clfsgr7EboG8oU4Ou1G8MHUuKuD8Dc/W50jGVkbpYCtCW?=
 =?us-ascii?Q?pM94A6NH6EL8BBuFR8OFmr88ciRH1wseUcCWu71JHoczufTUigxUsTRKbgqs?=
 =?us-ascii?Q?Q7cOb66jcIUEEJI2ViD03aQ6OD6rJbsEtO4Jcz+5nPkBsrLuGcqD6t/7ZMRR?=
 =?us-ascii?Q?WusZZUrrk2wLCGhL57ZAGvINGd0Tln8EQotKMXheSIcy1KOKjLAaSpHPNuNS?=
 =?us-ascii?Q?sZV8Um+ovoF3+Ahapccxs8zFioBJjKUvqESu7DeK40ETmDEPZWhX8FCtA2n8?=
 =?us-ascii?Q?3uL1ktE3hTkCGGhOpGyLgDdZNHFAAElN2IG375LDM8sxCr0bZZlU0aLqVCjV?=
 =?us-ascii?Q?J4ovza/GXy8ZbMuofKIq1lxfp487sL7EMqHpbNGa6RXLe0bp65fBP9Xs9Rps?=
 =?us-ascii?Q?HD0MCUT2qJKXxi0/UAlukrre9hm0jiI+emSqrVgQC056D8ZJRUB3a6EOewYP?=
 =?us-ascii?Q?3SNyN2BKx2CuwYwAl7GGyYP2V+zXHv+9UlZPjtOgH5A6bRUr7h4AoYQHDnlV?=
 =?us-ascii?Q?WqFgLxHaC5oOhhE+oFpLotgUUnA+EbZOgNN3vvQBTGVov86eIngr4WYNMIZB?=
 =?us-ascii?Q?2D3oAL0tMUj9Bswiyw3VbXdrNTQPQgAy8GrsBcMk37oL7+QTRVPn8GuUBEJb?=
 =?us-ascii?Q?dDjxkgNoyZDwwCtYWT1lQOkJuq3Z3ob0f2w34js6khppZgqP2PvVBSUnywWU?=
 =?us-ascii?Q?xF2dAvCu89HNTHFJpnXvrvVWKs8dYQ7iFjQyNc4ZJNVeaE6hBf66FLTwHe4p?=
 =?us-ascii?Q?4QWhqn3jVNbNjHp0jvRzgLRnLXbyqWDRc50P9Zt+Fgblk57WXmktKEI1E0Sw?=
 =?us-ascii?Q?AhE5yPz8kTVP+5gvN2n1qCPRnI8I24yKfTtmuIt6gooqPVZM0twx5Gm1+DCM?=
 =?us-ascii?Q?i1psulUEAY08hmd6g/FR660i5VFT1P8yZLft1Mkiwuw+/LlEE6I0+Et9KdKu?=
 =?us-ascii?Q?XIh+D3RYWd1lRFJp6b+Bnj7S3xkUTPaCjHIDVBDpqIrj2Whatbp3Ll5obeJI?=
 =?us-ascii?Q?LgLaUnieVwE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W4uWDyramaCtoKf4Z565bjI3Dn2cYCSnbmJWzwqZvvK8BGXpxhpyl+k7n8hi?=
 =?us-ascii?Q?NKitnwcEbKxdsEICiaAY0d2nT7nQX8A63fFzc5t1mc+5A2XQqrXoB1wTjb/C?=
 =?us-ascii?Q?WufXUr4LOdl8kSYvbg0shSPAKWnDU6BgNaXB11XAZE2oE+jE7pAGmwcwKgNz?=
 =?us-ascii?Q?rFqYML6rJXmdyPO3p0Mu6UUYWuenUUewTMD3OK3QOmrsXP7X4UwLYVFSFTWy?=
 =?us-ascii?Q?Nq5fEJIM86gJTMIh4uhxCOaI0FVD4Cw2GPGuXL4rPTwCYIG6O1xROx/R4rfa?=
 =?us-ascii?Q?fZR6xfzXGcU3KUp3+34YyD9whjgzaKPFmRAPW25so86KBffK+mBP0Ou2ovxr?=
 =?us-ascii?Q?RK/B7gLSNXLX7yhAop4J8kwfGL6JksuTOVg17eMq48tFRDZFmHAaVEBFmNtJ?=
 =?us-ascii?Q?hJL6cUKclkjfzUUaLlegLMzkoq3Mca4sEYOQw5Tt4Xgm6Q38YQXts2F7yhJ1?=
 =?us-ascii?Q?dwXQwKlD16w2cYCptNwthMl+dM3DQLsV11IdZW8nXvmV+yBlZy7kidpaIN7Y?=
 =?us-ascii?Q?KwYQ6n+cIs6lk8kvPJDko+zA0qPqKmh+zxq3hKF7E6Z88n92bUGRKUCtRCrK?=
 =?us-ascii?Q?dgT8jfXIIPCxcm+p0awlGyZbKoukFR/NkjbVVigcHba28ynyt4+5+DCyPj38?=
 =?us-ascii?Q?b/KDNrRa+Gxt0Eb1j+OObxYa/+HcwxESxKyZ68sxNQRDQIBOaKmlqvx7bGqp?=
 =?us-ascii?Q?bp8wlc2BJ5Vu40SVVGZj68COZ0G3QVRwnH+RQsbAn7RLrk5+z8GvTI3Xd5ou?=
 =?us-ascii?Q?crd3bTFqmmlUnxZ9Zg8JxqlzTSTN8/Jf8iyuceBlzOQXE1x4If+ramIPV7zg?=
 =?us-ascii?Q?quV7WON1Afx1FcUKAZS/o9ptimregBkiSunhx/7zQlI500uSmIuGvVsEvL+h?=
 =?us-ascii?Q?amLpKnAfWrAdOh2KT9gMneINhhru4zg3/s72OZsrbuZcm7PUUXtb65b5YMYW?=
 =?us-ascii?Q?dY6Jm8NvrEEm9SQ0vVSeNj4HPQF5e8SLxjnFc3IImYpF1qeHAoir2rKBDsd5?=
 =?us-ascii?Q?jL+8cJY6cpQYGET7aMKXEMqf5YAFIOCr6B64pqVFAbWstnOt50k3HgVOY0/Y?=
 =?us-ascii?Q?UttcoBu+2L+gvGr34Zew91vxTZrdaT75WuNJr4uuLJy3k5GZ9K8NGkOUfiQ4?=
 =?us-ascii?Q?EaYKnqZO6z+1tsZLuJCImi8gKhbOzHuvtJM8TBf9gM+EyDgkXS/j6wHZ9IIC?=
 =?us-ascii?Q?/7k+ETX1eVJ1l8EkKYfwK3ea4PTm6bvJ076LgSyu4dothz0dR3kvGx5KUJLN?=
 =?us-ascii?Q?2DZztigZ0hD+otNj3cU016cf40IMbRNoUunSQUX3CUCOqpAB+LbvFr4kwP00?=
 =?us-ascii?Q?Bj5P8NpAx4qqS/eQt1WQic7ANhOl7/MNq13VNLdO+knBq18qxAJSzI/l2KzY?=
 =?us-ascii?Q?ihxy8dZJqvIxULhx8UcAEIC0ZSUa2CpX51TuM4GtPVQFr5IZGseVQxZgJFaS?=
 =?us-ascii?Q?+ICpeBSSl8mmkhm/jedOjffCXQpXH2sqeU1QQOZ0n+DSnIWyAhQY2drdLCti?=
 =?us-ascii?Q?WmF6DyY5BZBvu1KyfVWZn/7z97DyGZEy8i7zREiFFonnuHVKYX+UY9KYYqZr?=
 =?us-ascii?Q?Kl6eLNCAOzPqWbJgJx2GKhIrQH1i+ylqnoYidnpb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd9c7f0-0b2b-4c2e-19a7-08dd3c41e5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 06:39:48.2366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2fm7iVSZK+qQS/KcwS8fqB7OhfKG5oAzs8OwoFSKyCFkHdTd5/HoVJt7JzBf34rylZSlWF4X2oSehaWIowWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, January 22, 2025 17:56
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Ma, Le <Le.Ma@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH v2 6/6] drm/amd/pm: Update pm attr for gc_9_5_0

Update power management & clk attributes for gc_v_9_5_0

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index e8ae7681bf0a..0aca0803514e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2006,9 +2006,10 @@ static int pp_od_clk_voltage_attr_update(struct amdg=
pu_device *adev, struct amdg
                return 0;
        }

-       /* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
+       /* Enable pp_od_clk_voltage node for gc 9.4.3, 9.4.4, 9.5.0 SRIOV/B=
M
+support */
        if (gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
-           gc_ver =3D=3D IP_VERSION(9, 4, 4)) {
+           gc_ver =3D=3D IP_VERSION(9, 4, 4) ||
+           gc_ver =3D=3D IP_VERSION(9, 5, 0)) {
                if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(ade=
v))
                        *states =3D ATTR_STATE_UNSUPPORTED;
                return 0;
@@ -2087,7 +2088,8 @@ static int pp_dpm_clk_default_attr_update(struct amdg=
pu_device *adev, struct amd
                      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
                      gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
                      gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
-                     gc_ver =3D=3D IP_VERSION(9, 4, 4)))
+                     gc_ver =3D=3D IP_VERSION(9, 4, 4) ||
+                     gc_ver =3D=3D IP_VERSION(9, 5, 0)))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
                if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) || @@ -2109,7 +21=
11,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *ade=
v, struct amd
                      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
                      gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
                      gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
-                     gc_ver =3D=3D IP_VERSION(9, 4, 4)))
+                     gc_ver =3D=3D IP_VERSION(9, 4, 4) ||
+                     gc_ver =3D=3D IP_VERSION(9, 5, 0)))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
                if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) || @@ -2120,7 +21=
23,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *ade=
v, struct amd
        } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
                if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
                    gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
-                   gc_ver =3D=3D IP_VERSION(9, 4, 4))
+                   gc_ver =3D=3D IP_VERSION(9, 4, 4) ||
+                   gc_ver =3D=3D IP_VERSION(9, 5, 0))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        }

@@ -2416,6 +2420,7 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                case IP_VERSION(9, 4, 2):
                case IP_VERSION(9, 4, 3):
                case IP_VERSION(9, 4, 4):
+               case IP_VERSION(9, 5, 0):
                case IP_VERSION(10, 3, 0):
                case IP_VERSION(11, 0, 0):
                case IP_VERSION(11, 0, 1):
@@ -3530,7 +3535,8 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,

        /* Skip crit temp on APU */
        if ((((adev->flags & AMD_IS_APU) && (adev->family >=3D AMDGPU_FAMIL=
Y_CZ)) ||
-           (gc_ver =3D=3D IP_VERSION(9, 4, 3) || gc_ver =3D=3D IP_VERSION(=
9, 4, 4))) &&
+           (gc_ver =3D=3D IP_VERSION(9, 4, 3) || gc_ver =3D=3D IP_VERSION(=
9, 4, 4) ||
+            gc_ver =3D=3D IP_VERSION(9, 5, 0))) &&
            (attr =3D=3D &sensor_dev_attr_temp1_crit.dev_attr.attr ||
             attr =3D=3D &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))
                return 0;
@@ -3605,7 +3611,8 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
        if ((adev->family =3D=3D AMDGPU_FAMILY_SI ||        /* not implemen=
ted yet */
             adev->family =3D=3D AMDGPU_FAMILY_KV ||        /* not implemen=
ted yet */
             (gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
-             gc_ver =3D=3D IP_VERSION(9, 4, 4))) &&
+             gc_ver =3D=3D IP_VERSION(9, 4, 4) ||
+             gc_ver =3D=3D IP_VERSION(9, 5, 0))) &&
            (attr =3D=3D &sensor_dev_attr_in0_input.dev_attr.attr ||
             attr =3D=3D &sensor_dev_attr_in0_label.dev_attr.attr))
                return 0;
@@ -3613,7 +3620,8 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
        /* only APUs other than gc 9,4,3 have vddnb */
        if ((!(adev->flags & AMD_IS_APU) ||
             (gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
-             gc_ver =3D=3D IP_VERSION(9, 4, 4))) &&
+             gc_ver =3D=3D IP_VERSION(9, 4, 4) ||
+             gc_ver =3D=3D IP_VERSION(9, 5, 0))) &&
            (attr =3D=3D &sensor_dev_attr_in1_input.dev_attr.attr ||
             attr =3D=3D &sensor_dev_attr_in1_label.dev_attr.attr))
                return 0;
@@ -3636,7 +3644,8 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,

        /* hotspot temperature for gc 9,4,3*/
        if (gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
-           gc_ver =3D=3D IP_VERSION(9, 4, 4)) {
+           gc_ver =3D=3D IP_VERSION(9, 4, 4) ||
+           gc_ver =3D=3D IP_VERSION(9, 5, 0)) {
                if (attr =3D=3D &sensor_dev_attr_temp1_input.dev_attr.attr =
||
                    attr =3D=3D &sensor_dev_attr_temp1_emergency.dev_attr.a=
ttr ||
                    attr =3D=3D &sensor_dev_attr_temp1_label.dev_attr.attr)
--
2.46.0

