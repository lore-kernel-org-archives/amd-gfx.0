Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB25105F7AC
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 13:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BB710EC44;
	Fri, 13 Mar 2026 13:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5T4Bffwn";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C8110EC33
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDRIZ3A+Vv2K7PiLWIoVbwa32ntA5HGtjVyxGM8tDe3qO1cml3QjOqgeg4d0H3O45xUhSlTLE8jXDLH8+wMB6l1JFzLg5FHGpK80Q6kqbzXPxIEQ+caTowFMCgIKuF7n+rXBxarYqonbV9AsoeXRZoanFHhKlfdfh7/IlS8IEjN2TEV+r+KdUBAlJv04VogIL8l2oCWnEpfwPYdpR/2RK8HAzOJ2KO6dqJ5fUpZhUFJ+41+TZSZCys519k593adyWgLuF0hGd2mS0Exnnky700zhrqmsixjDIFJSh8RL50B2lXLK5utAgHBgvqaWyy2MTKorBqz7Ld6ZHC1aZ3Dddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY3YHsHhKp3phjXXy4XiET4JYwr2KSPUMSB2QG0fogw=;
 b=so8johQ/04I3y2kTwYCWUwoahTV63IfBVrcPa3xXxAm2ZexuMC1nsbJ3UxEEVL4qbYVaO8DeGm7NgC1pBWa8/cxUz0+fRheKvhcFIOZ5MOmjJq/D9YmTDNx6rKPOJDPNh3Z6FeLB/mcIHXfqyd/2MjyvhhF8DJpCUvJs+8iEKXdmD4Vv3uYi1V5nVWPd41kOBfQZj8YEGa5gSgv2Ax1VY6RQ9oBEoJ2DMLDLzsmb5DVj4U8lSbrKOzJKs8FjY7ZCt+B/855VnXQZsTi7r+9roKrYQ06uYbkM72OlcGJ+TkZ1+aJ+ZOjjUbkcdKSnhG8CdbGN3HCyJ9Yb8lpdv9hG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY3YHsHhKp3phjXXy4XiET4JYwr2KSPUMSB2QG0fogw=;
 b=5T4BffwnJTqzVxWPdfDmFXVLZh3IPW7RIW+XPEEbBHSM95sDKLe5YigdkxkuW1s3FvNhYsLeBEj4iGgZu98mCWe3yh0Hc2szPl4myJ8rYA7Ds4w56AoF26QnqOheLwpQjvAnzUkMOl5+3/M3O5l659JpQC/cr5JqoEz7H0SXF7Q=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Fri, 13 Mar
 2026 13:42:02 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::a490:6ad4:93ba:c24f]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::a490:6ad4:93ba:c24f%3]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 13:42:02 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Xu, Feifei" <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fallback to default discovery offset/size in
 sriov guest
Thread-Topic: [PATCH] drm/amdgpu: fallback to default discovery offset/size in
 sriov guest
Thread-Index: AQHcsu7cGG/+9vBEq067EZizO3nSULWseGxA
Date: Fri, 13 Mar 2026 13:42:02 +0000
Message-ID: <DM4PR12MB5181FAC3C4B05EDA2C320A51EF45A@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20260313133920.3442-1-Hawking.Zhang@amd.com>
In-Reply-To: <20260313133920.3442-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-13T13:41:49.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|SN7PR12MB8769:EE_
x-ms-office365-filtering-correlation-id: 8018cb97-6670-4905-f1b7-08de81064ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0ajwUnI8/BdVaIrKWWm0Goz6pOso0lQMVJQEWCNLZqTUTOsrEHgudjaARREUS5M5lxIFXl4e1Vvv55DKu/ks+FVa9ZUzM4F7UUGAhj9BWBS8UBzpjzclXLnRWbRtow5IJr4rzpYadINNr+zjSq0Uy5Fs4/HKwrutGGWoouR2FwC6WAzO/N7Yz1yRdxbyCkNIA+D5o90x6OJRNVhMNfN/Af8avasWEVrlyiWRKIB421cxr1y9HrQBAdCS3hC+yknTVA4nz2mLKZS50Iwd0zZDaMgV2KMbBMwsfoJe/XQOUZTT65qqxQ3rrpGhqOoYommEEg2i7NKKRibEQIbJST4eOLKgAAM6QuNgH29m/z5mTxEAUwuXqVg6cKxYsvCO5RrYXhlyS/FKOHOraJBJ3UGR7KcMQp9PpY+a39B1UeG6RIrr071KKibuiQe6W3rBHUyV+SwTkJl/+355/m8hu0x36l+OxnGjziokYMrDPocBn/HtEJalhL038exWdQ05N1kGDL03ofxun77G62gMBc1xI5RfoiMbaTy6Iymzmq/nVwhkujWg6JFLMi0+hqRpqs8YEKAorJF+nog8Ak0AA5aYrysLTyYIPLFzapE/aj4WXG0jdV21wg1UXghoxVI2OrtXOdQdqnYHVW/R6M4oNYngS3f/htJno1Ct5r792ZOda7k4mFlImBy0y0a7Yb59duTOVxAfyQlwn54DNkzJzAXiza1+Q8zeg5kOPvPXxT8LNuG+gm4jkwkulM/pYW8ftfVOV78KBBuQ5wGP1eE4k6NuOstZ+G3TpR0lSgcDNZrMT44=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dzbV/FXQmUOLCiFVdZWYnxxA6A0Fr1gmwNaaR5G5SyVpA0cYQ4Anmh+SdW9+?=
 =?us-ascii?Q?3AbM35aVhyDsCoFhkluufboAfbciP0nhER1FVWk0WbbveDr/BzwSXSzCGRF0?=
 =?us-ascii?Q?exhIKtvCzRFw32W8A7FmIIfS0F2jgyjfEjEVJ7+5QsVK0dDjVLYr6yX083pX?=
 =?us-ascii?Q?f0vG+SB+LMBFVp9ZzYLzo+p2nQA3hbiKPV4B9+s4RwUQTek7li6z8E1mAvJf?=
 =?us-ascii?Q?pKh43fFexIYMN+SmAXZiRPRxElaJNajOxnC3b7pXfFaCM9qRb1WbynY8u4xw?=
 =?us-ascii?Q?KgXTHOOGJ9rgt8yq26mhzRzq15VkTWIWkYjosHE7Qx9BKkLfQmxhOdlQF0qC?=
 =?us-ascii?Q?gQ8Ou9D7HITSZbXQkR8XRhJJPp2eK3EO/G/2UwwbaxUcg3r4hgbZGestWKn4?=
 =?us-ascii?Q?T1/3TYn2WaJDAS63C8EHMamxFgk4WUUZIfNMYB5+vMskE0zrGvbV7fQbKSZJ?=
 =?us-ascii?Q?D41XVh6DaQzn2gOMlhDRJE+uqK9/AOsbNBkJfLsdyDbOWGARumYiZ0j+Pvc6?=
 =?us-ascii?Q?mNbGspnK2G5v/rz3zv6l5LI8yEVLqKkoxeSErwVTRhYrCbQhnF14Gb7ACzol?=
 =?us-ascii?Q?BiYm99gQjHvkfayN6EaE2yMAh7QM05DAYlLrz+MYLMAJ1NOfGp7ECGVh9Bo3?=
 =?us-ascii?Q?5XWfUZ4sbFVhyCjkEZLahP09AFYmp29OgN+US/qqF6vjfB1Mo8xHV2fA1MrF?=
 =?us-ascii?Q?DsjvYhRHa+HRl/XuJpes7B3oznzC8ZjJi+wJBMTztFjdFvBpGYlcL93VhAXL?=
 =?us-ascii?Q?pcDLnZ2hUGufOtmAXNVaFYTarJ1z9kS3yotKI0AMm+y7Hj+tTE/T3N8rX6TS?=
 =?us-ascii?Q?SzaQwXBjTVTsHijX9dSfoWcizBmE3qGjsuZa2jmCO5FQLkH1aSVJATZs+LMi?=
 =?us-ascii?Q?QPe0sSyaZJTanIDJ+myO0jna5UVaaU6QwHM0C7jri282KWxI29CeAC/P1bBC?=
 =?us-ascii?Q?0VPYaTFyc4UqXeuA5Vwn13I4NNBVXUZVwyh6kMDDMEk7rLKg6KCerNIoHRAp?=
 =?us-ascii?Q?ojn2zdALkLXsZ3krvA1QaakHHDJQaKJ3AR8i3ckIyqGZpRNRoyFUgTv2nMge?=
 =?us-ascii?Q?ds2xCiTZu8CiPV/YM3yamtqQ9ib2KV8fMQZXrxsDPryECo6zIHCAg2ozI+IM?=
 =?us-ascii?Q?nNGDOEeKjtZNwiQlxST9AfImFi2a8k8244Tkmo6ZXckuhmE0pPJDouIaA13T?=
 =?us-ascii?Q?X2XImAU5MzefUCV19m4Awj90gbWQ5CQkrC37K5BHAmDvRsmSwPylAQrKbrj4?=
 =?us-ascii?Q?KVzTmpuNTSX1q6kyf37R3stphDjLQv034ALCZvVSmqArcaItD8eZXYM0y/Et?=
 =?us-ascii?Q?h01s6zaec6hZ9A32PG1EPfb4Uya12mAME2DAvl0UvcJucp9w188bfPuaxiD1?=
 =?us-ascii?Q?Rg7WmjM+DO+KPawoBIAEAxe0ysBskI9eWChlxZzF7lS3J6O/sPVFdpBXhr0U?=
 =?us-ascii?Q?JTz0Fpj2jlSnh3X2bglxjMUVDIn8LNkzNbOlu/Z7jdJqWCeqgqy8dK0nKhnS?=
 =?us-ascii?Q?kKd+4NOah5vy1Cgtzu3zeedGlzz2BGoZZtA2BJfaz1fDvo1gzLulSV0iAgq2?=
 =?us-ascii?Q?9VWkLv9vBj1jrQ2P/yUpKupaolrABGVT64PJKEV25voXV+RCuR7b769rpANv?=
 =?us-ascii?Q?Jfp19Z360RBQQycKDUPqKjrD3ZLwC8zjN8U9dtGEjna9rpMY4Dwl12MBkiJe?=
 =?us-ascii?Q?1toxYAgBCsU7GznyBb6sffdYILCI7p6MRt1uRVvde+6fcmGN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8018cb97-6670-4905-f1b7-08de81064ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 13:42:02.3949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1OqdinP9Tr6Tdr09x+rvEylrZhWyBc6YDgW+KF/rvZhPXSTAo2spfh5w+qnJko8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
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

Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, March 13, 2026 9:39 PM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Xu, Feif=
ei <Feifei.Xu@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fallback to default discovery offset/size in s=
riov guest

In SRIOV guest environment, if dynamic critical region is not enabled, fall=
back to default discovery offset and size to ensure proper initialization

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index f77a03ea4d90..4e362b7aff8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -296,13 +296,17 @@ static int amdgpu_discovery_get_tmr_info(struct amdgp=
u_device *adev,
        if (vram_size)
                adev->discovery.offset =3D (vram_size << 20) - DISCOVERY_TM=
R_OFFSET;

-       if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enable=
d) {
-               adev->discovery.offset =3D
-                       adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID=
].offset;
-               adev->discovery.size =3D
-                       adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID=
].size_kb << 10;
-               if (!adev->discovery.offset || !adev->discovery.size)
-                       return -EINVAL;
+       if (amdgpu_sriov_vf(adev)) {
+               if (adev->virt.is_dynamic_crit_regn_enabled) {
+                       adev->discovery.offset =3D
+                               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_=
TABLE_ID].offset;
+                       adev->discovery.size =3D
+                               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_=
TABLE_ID].size_kb << 10;
+                       if (!adev->discovery.offset || !adev->discovery.siz=
e)
+                               return -EINVAL;
+               } else {
+                       goto out;
+               }
        } else {
                tmr_size =3D RREG32(mmDRIVER_SCRATCH_2);
                if (tmr_size) {
@@ -322,7 +326,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_=
device *adev,
                        adev->discovery.offset =3D tmr_offset + tmr_size - =
DISCOVERY_TMR_OFFSET;
                }
        }
-
+out:
        adev->discovery.bin =3D kzalloc(adev->discovery.size, GFP_KERNEL);
        if (!adev->discovery.bin)
                return -ENOMEM;
--
2.17.1

