Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C6FCCD184
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 02:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680C010E1D7;
	Mon, 13 Oct 2025 02:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wmD4y0vg";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0158C10E1D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 02:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgz/kyz5c3pSEYvUrYfC1EAXtBte9Wd1aBSupCormZ4hEu1Y7FJCOGTZVyR/8qf4QK32JcFCdksI8fiGX3VM0naEws6Pz+JU0ozt65KgsuL6RcjkfldimIZH2VYu7Ea77QoUzuRfuOl0niVaf2SugH34vbqPqDCh8n7ktIApOVwjPDej2uiimb8Pbb1eiiPeAj63sW2Jbaxs5TmAaYi08vgHW78/3aK9oc9jf3Kp5PzZOVEugyRtMyaHtsCGn0lM77MTaF24tdzNRYalIfJ+7RJQKItngD3qhvcUvX6pG8gXKOvnxibco5/6CJLopZwn0g+Yc77jABns2DqDnNKfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm4r7jfGpiYgOwB8/Vmx7BsuTC/AZjjSxLMGOWWEL7w=;
 b=k828ga7G5ivkQbfmLqAP99wm+PV0+wcBtI1UdZ93wugOEY1Bh04xgli7jBfyci+mr1TBIcJiElHjKDI/4r9MhmPtNdc2K9iQvpaYJqupHnbSjptauaMgLXo0tbcDZTzWfDNG6phxsA4c0Q4eY3TMVM1hY42Je8dj0Sjj0MUBDDW3Kz2cqCdXDE8xf0qNJm6Jt7EQUumjDIAJgg4ThpmYFUF0/zYtf70nrLe4lXxNU/x7Rk4VrlZbvKA2Z16CN3Dg202IrJcldxbrk7oO55452HJH7Zq4sQUkmlqR0Bohb1BDIzu4TvknGmaJRaWVGxf65BUAOBa7cMmZAo87ViKICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm4r7jfGpiYgOwB8/Vmx7BsuTC/AZjjSxLMGOWWEL7w=;
 b=wmD4y0vgq1cu63JNZmP3n+3o5SlJb6CD55PrpXnUENKXx2HoVfDsn44CnkSo78DLMoiruN4XiNDek2QZbea3aG97wfUDzXMZKqfaeLmWq1p7dVrQOLgtZ9c/cOGbie/4k36tq9yPfqFN/e46D5BONo6nkuG1/Pc8pIowAZTbwdk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 02:31:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 02:31:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: re-enable power1_cap* hwmon nodes for gfx
 11.0.3 vf mode
Thread-Topic: [PATCH] drm/amdgpu: re-enable power1_cap* hwmon nodes for gfx
 11.0.3 vf mode
Thread-Index: AQHcOdv7777Gf3Lyq0mUorHdYi5HlbS/XukA
Date: Mon, 13 Oct 2025 02:31:25 +0000
Message-ID: <PH7PR12MB5997C509E2B24528BF6875A482EAA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251010114910.2801961-1-kevinyang.wang@amd.com>
In-Reply-To: <20251010114910.2801961-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-13T02:30:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA0PR12MB7529:EE_
x-ms-office365-filtering-correlation-id: 35805258-7dc1-41a4-f281-08de0a009b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1pAane7nVhFHS+BXgpoclMTSW560QM/P5lheRSF97o5XO4RKfDB/PgiRBtLE?=
 =?us-ascii?Q?zc5YYck+ZZMPYEyL9UWi5ecDJ5HEWXTSaC0tZ2pK50E0PwJBii72mAft98dj?=
 =?us-ascii?Q?OizZT1tkJCJCgl7/UNnxGvYqOwwiw75zBe6yMXe0p0ISX2sgdGyqy4DHKOXF?=
 =?us-ascii?Q?nlBiwWt9eXi2btcHc5jbvolglNLOo6iTvhsUaIdnjgq9SdDPyz0uVL0pWnB2?=
 =?us-ascii?Q?OfBkxj+NC5XxeHPo/Jk7ZYh3H6MS1enPjFbpQpjgM1eorG+s06/7zc+ihFqE?=
 =?us-ascii?Q?laGa/nideqv/37vYzn0X+r4Z4lxTu0eUn2iuVtuNrXzVXoIS8oCaz+etHGmD?=
 =?us-ascii?Q?siujQmnjasVHE50tL4LVtbwP9RHZWU/U6WzccI1pU+nlqcpoFIMFfnDAycEC?=
 =?us-ascii?Q?A7I9Sq+u4liknkRbPHrXYxIY1U5uvxweOXRDJKQKGidI87sjoVBHhgSiXz9s?=
 =?us-ascii?Q?B1ZwRyzlC4UbtRp7LTkLx9WkIlWnynlBexHUumRUOaWwrvvuDMpk9AtjQAVV?=
 =?us-ascii?Q?3K9quBmOM/LrNkG8A0aaAu7yJPpsBtn7TLZHx5IYmvJrvYlUNAVeO7eS4fUp?=
 =?us-ascii?Q?+GNAFbOI64A9NE22NO+SvlwlAiJuKcaac8yCT7WKyRyybnwUrxDnChXKVE2T?=
 =?us-ascii?Q?MrNPTp8o74m9sQeWJNRrttdgfzH31AWOff6C8vSe3o9Caae9rPDSktlhId6C?=
 =?us-ascii?Q?MikSS4wiKuBH8Y5F4wulOwEBeYVMfbWirMZ/PkUCrkRmkSzAeFSgGcERubl/?=
 =?us-ascii?Q?L3oift3ryTcBlCw8W7rNnoLd16T6/YdBAqhoJ69IfkKI4IQN2Y5ikEMohtX9?=
 =?us-ascii?Q?IvxxJYCsR4r4hOJAG9OI1uklLN9g1wX8M+B0QRO/qBh43ZQ6f6EqfMIaEf1R?=
 =?us-ascii?Q?I8MY4ZX1XeXUw60It8tH9ECs3C3TESWpLEM/0W7diNB3aFV5/rObuX+QaWXT?=
 =?us-ascii?Q?MS4euYP6G1wOx44I8TSHMAVPW1U9k5T8Oi9Gj7hI2plIs5kJOKy3lxjtCDlL?=
 =?us-ascii?Q?0wKLfmvtXS09srmIrLqR2J+NVSFhzqX7cDRSObnaDLhaobKG8vuBDnpHEdiF?=
 =?us-ascii?Q?dtkX5bBPAn+3lx0iIXCu27ylz0XTJuWvClCPmT0zYiYe25AG92HMf1svsZgW?=
 =?us-ascii?Q?KvYQH7SjdgURUtx0Pfo3tbP9QA8LIVSRTIs5lmCIusbFrN7oLAm6Ftzsd67X?=
 =?us-ascii?Q?V8qwzouiAeMo8RVT6a4E61RvJLmmLKjDdFCo3YwqXqFF3cvxK8x9MbIn1HuZ?=
 =?us-ascii?Q?S3i8Ib729AQaWDlUH+dKECtt8ezV+duZ+3R4NGAH/q0oYKntVb4hiHs1NnJL?=
 =?us-ascii?Q?QyEn3cKZIB1iXepvZs8CIDHqwgbVotB1uAntU6vhBSyph9g9nMSW+9LNXW8V?=
 =?us-ascii?Q?DWZ+M95NVJq5gHH9wRuVhXkWOulok+Dp9s/nS6DG4yTrVVkFRKmafGYahoVz?=
 =?us-ascii?Q?4Dg2104vyLnOW4cDT0cbrXMb4nsqvYDP/cA4GAn4qi9PfsWBBh2d8Lm1L9EN?=
 =?us-ascii?Q?KBW97eU/HvWP+MKZxr4U8lYDE1NrV9RjytfH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K2FoB8fYcfd9sgnd4KWx4dwX9TSeYOx6galYvJvMJd3vHQYDpFnQzxajHqSx?=
 =?us-ascii?Q?MQ+lBiwFjxbMH8Xs5Iu7hEXh39mY2IWaeRM7MXLLV9ZuFch70dIv80ujbLOI?=
 =?us-ascii?Q?239BYJEWShSHzf4+piIH7gQgFeuv8if7fYAlQ7we15hmI25eoWlPJo/ljSLR?=
 =?us-ascii?Q?OUjFRFqApw5j2wvZwQ/ZxjFWcI3PqYjbyNFgcb/X86GOL9YrfknWM3xf1Cci?=
 =?us-ascii?Q?iqlq8PHPVZ/HINFKcWsYk7rarttFevYibqBWwQY6M+KG8sewaNjmTmX0Ov3i?=
 =?us-ascii?Q?T908VJ2mHJ1DPThUtMtu2mXJmJ6rBO+nyVLlgWvy2YHTikePFeEh3bfP3wt7?=
 =?us-ascii?Q?dlZ9NHc9XYh69NW2S7pKpqKjDjSO/a2kc0r+uvBBL1lJgNpSpNpIfFhO2W0Y?=
 =?us-ascii?Q?kp5B6lOPhhkHKJolbJpR8SBvUVpRJyHOtGaHTYIjwoAsn89yWZ7GcuNnna3K?=
 =?us-ascii?Q?j+WIuzD9AnW50/G3kZuHsTL7AtPB3gEmYUpQ1rnq/PSuT9gDDsz4zBuTlvlI?=
 =?us-ascii?Q?9dk7NzdXolC+N83dur3sg3mh4VDhGPNiqgMNEvwHORvLu+uezq1Dzo3f1tbM?=
 =?us-ascii?Q?ifO6oLBSN/rdAzBwE3HUez/Ai/HfvhZPX7dJOsWlLdgXXTHoEOJeek2WYJqf?=
 =?us-ascii?Q?14/5KBtKDriUGm64yX2LaF1TtR1kYY+BpXfiaGxIm+m9VmRfE5SNH0TcIpei?=
 =?us-ascii?Q?86sGJj0SWbNliQ//l65eNQDRVKqzYGQg4fBjJdSMYBiJbDBfqiGHPAxK3wjq?=
 =?us-ascii?Q?ApEYCv/OBburRfVCCbBJlS0nuZpjOP4ZhurPgwCIO2OXAKM6Xs+VtThBn/ih?=
 =?us-ascii?Q?BFE/W6kpP5zemFC77SqbbJOasx6ADlN823AlbIYa35HSbEfm5G2zWK3pp/1v?=
 =?us-ascii?Q?qmbPyMlI52J4r69FrA7/03m8fOtj2X2Ikf6il7LWY7sSJr2kNIDRPWxEP0sp?=
 =?us-ascii?Q?DcaLM/XAAFVxOXmK6VWZhSpV3whPCWQADvWc3Ad3J6UO2cvl6brD91E9eyPi?=
 =?us-ascii?Q?dfRwKVE35pEklHWQcI1U2Qj45Qr8FlRS19i3OW6CZvSZVn/W39p9ii5DQ7nH?=
 =?us-ascii?Q?GMV/3tPp5oUqYYtwmMzRHyOJYulnZArYSCb3aQ+1Gp/EoxfLlrfMv1DK9eoF?=
 =?us-ascii?Q?N/kq6Z3mc0ym5YXfRTs3afCbXJKGo9gx6vlSSwvC+7tukoigL6V1CFpftf/K?=
 =?us-ascii?Q?SUv5gJtl6MuGqfh9CQBJXgxlrytbvOGgsaAnAT+/Noi0v//jEwsaZ1IF3gwp?=
 =?us-ascii?Q?TD8aY75JXY8kfvETw4IA5BFSqWdvl32JsG40ZECOR+/y/VqDrgtwRBkbb4hR?=
 =?us-ascii?Q?U+xyWqqKsi82irNVDba0INFWICnJ6HuosOcvrd7YhM1sXXHuBJHmGvxQ8qW4?=
 =?us-ascii?Q?vZf34k7SmxOQYDIcecFP62M/ARiZYI/jCDq74SmcrdOuuzToB37UyBhYyJsu?=
 =?us-ascii?Q?wQ7I4MERElNL6DYccbri38j6LBKpiVxPcXE0lKgXXJ7Sruv4rJm18TVFjwBt?=
 =?us-ascii?Q?HrgiqG+INmq7NB/euf3tIIaGFqtAZsb2X/Z0/mo+WuQLZ2OLBwri17EyY5kp?=
 =?us-ascii?Q?J1xRL+KfM+0l5UQbRzg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35805258-7dc1-41a4-f281-08de0a009b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 02:31:25.8778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eemvv/l8yrCVMNKFht9xgleJD5hplOp3aYU9o/wQrqW5+759Cdr9U8Bz1pt4QoNQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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

Please ignore this patch.
Thanks.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, October 10, 2025 7:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: re-enable power1_cap* hwmon nodes for gfx 11.0=
.3 vf mode

get power limitation information from pptable instead of sending PPSMC_MSG_=
GetPptLimit to pmfw on gfx 11.0.3 vf mode.

Fixes: 21129c51c616 ("drm/amd/amdgpu: disable hwmon power1_cap* for gfx 11.=
0.3 on vf mode")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                  |  3 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 13 ++++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b5fbb0fd1dc0..4622dbf1cb91 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3721,8 +3721,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
            attr =3D=3D &sensor_dev_attr_power1_cap_default.dev_attr.attr) =
{
                if (adev->family =3D=3D AMDGPU_FAMILY_SI ||
                    ((adev->flags & AMD_IS_APU) && gc_ver !=3D IP_VERSION(1=
0, 3, 1) &&
-                    (gc_ver !=3D IP_VERSION(9, 4, 3) && gc_ver !=3D IP_VER=
SION(9, 4, 4))) ||
-                   (amdgpu_sriov_vf(adev) && gc_ver =3D=3D IP_VERSION(11, =
0, 3)))
+                    (gc_ver !=3D IP_VERSION(9, 4, 3) && gc_ver !=3D IP_VER=
SION(9, 4,
+4))))
                        return 0;
        }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 657dfdf76829..decb10ec0b0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -448,9 +448,6 @@ static int smu_v13_0_0_setup_pptable(struct smu_context=
 *smu)
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;

-       if (amdgpu_sriov_vf(smu->adev))
-               return 0;
-
        ret =3D smu_v13_0_0_get_pptable_from_pmfw(smu,
                                                &smu_table->power_play_tabl=
e,
                                                &smu_table->power_play_tabl=
e_size);
@@ -461,6 +458,9 @@ static int smu_v13_0_0_setup_pptable(struct smu_context=
 *smu)
        if (ret)
                return ret;

+       if (amdgpu_sriov_vf(smu->adev))
+               return 0;
+
        /*
         * With SCPM enabled, the operation below will be handled
         * by PSP. Driver involvment is unnecessary and useless.
@@ -2464,7 +2464,10 @@ static int smu_v13_0_0_get_power_limit(struct smu_co=
ntext *smu,
        uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =3D =
0;
        uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PPT0=
][POWER_SOURCE_AC];

-       if (smu_v13_0_get_current_power_limit(smu, &power_limit))
+       /* NOTE: PPSMC_MSG_GetPptLimit msg is not valid on vf mode, so get =
power limit from pptable */
+       if (amdgpu_sriov_vf(smu->adev))
+               power_limit =3D skutable->SocketPowerLimitAc[PPT_THROTTLER_=
PPT0];
+       else if (smu_v13_0_get_current_power_limit(smu, &power_limit))
                power_limit =3D smu->adev->pm.ac_power ?
                              skutable->SocketPowerLimitAc[PPT_THROTTLER_PP=
T0] :
                              skutable->SocketPowerLimitDc[PPT_THROTTLER_PP=
T0];
@@ -2474,7 +2477,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_con=
text *smu,
        if (default_power_limit)
                *default_power_limit =3D power_limit;

-       if (powerplay_table) {
+       if (!amdgpu_sriov_vf(smu->adev) && powerplay_table) {
                if (smu->od_enabled &&
                                smu_v13_0_0_is_od_feature_supported(smu, PP=
_OD_FEATURE_PPT_BIT)) {
                        od_percent_upper =3D le32_to_cpu(powerplay_table->o=
verdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
--
2.34.1

