Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E419BC25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8CA10E2FA;
	Tue, 14 May 2024 08:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sa3Z9ptY";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E6310E2FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn8C84T7/XM1oUOULKCn0/sWBX9glS8cGjlOsXa5BB+8kEe4CHN9aMuvoP+lvYqOwlwezquBT++R/E70iKHeRW9msME+irRI38QdNiIz6lwDtPIwZWz0YhgzV0fjSO642ykrjNQyaEjZ+W5yI3OkQjUsVUbOoXboVWaF2fRvrV9Z//AbTvDbcMp+kNKCt40Smnkp//wtR4+jIdWg3uX481Qj0MzysCVip9b2UWg1WStP5jnqxuOCKtJw3FWH4ugQP3JIfXwbyAk8YjGgMKFr/POcpxMfu7JWmyWg6In9NBmNAADnovQ1aqizBO4DUuV3ePCzrX3rjSp2ZKlzoDP86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXDio6SSIzYwseSOBAecohILRnhp9GZqx7pqbEhYJck=;
 b=QCAFVR6p5pw9Wy1fx4D6QmJ/2wir0IVo9sh72soNM0KjiNRIi+wi3bMtzIqk0ce47IbfBrAE34GUeC8DMSjIFoXHL7mCALsv/T/YKqoOY/8Qh2bwcWlS5E7iTouZ9knczYSpbCs7ERKgdr8nu38RICGW3ZR/bH9mrQWbwtDgvVpJkDtxGprj+V0ze62UBO+IeQVOW6zuF3HjAHwQPbgMv1J9OGtO+S+zSrKdq/k8yDgNHBUro0//3XPWzYtZS1+0GmKCqmQgp56SIamqGdMYv3Qsk1MGhjLlZo7kb2ZyXm4dipX6f3xVxmwsgn/OT7RU0N4vtW1C0oSbNOUF7WzP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXDio6SSIzYwseSOBAecohILRnhp9GZqx7pqbEhYJck=;
 b=Sa3Z9ptYjm8XQNBUXT0rLIjcrAt0SUIRHXWUtPisKh196bSXxt+DHifIIJNB4Ho2OeRsLCguP5jTIW4D30EaBmLL/nqwuROFJgjH4j0cTwsFMRGhe4wwMiDyP9HRp31im/x7FK4smNQBLyiigmrtK9JbG8Zgty1BBEOOv4LYQbw=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Tue, 14 May
 2024 08:53:14 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:53:13 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: switch default mes to uni mes
Thread-Topic: [PATCH 8/8] drm/amdgpu: switch default mes to uni mes
Thread-Index: AQHapduMxLviKQC+Lk6N9YWqn5zTobGWbHAw
Date: Tue, 14 May 2024 08:53:13 +0000
Message-ID: <DM4PR12MB518155C19EC9379BC685521BEFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
 <20240514084751.3438103-8-likun.gao@amd.com>
In-Reply-To: <20240514084751.3438103-8-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=aee8f692-5c68-4296-aa95-795eec1888ff;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:52:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|SJ0PR12MB5663:EE_
x-ms-office365-filtering-correlation-id: 305deee8-9fb1-424c-f27b-08dc73f349ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?HDOGA4jOzXC9zau45eep+fHFMDYqt0tctiMLjGDK0y6nuDm46V/5s2ZF6W/u?=
 =?us-ascii?Q?Rs6Gf1j9I0oqMjwNAqqudATUDHyvRcBTm5c3Bgt+vNC52ughq5/vbGiRB7T/?=
 =?us-ascii?Q?wsDn0xEXKMyPOvM60zyttjBvewy7S8QNqRRHmshTgUx2NTVOu5j28sPfe5U0?=
 =?us-ascii?Q?IfH6tGIx+gaZt79K7f79gg326OfzUMfRlXINk82cr1vSPLg+Y8o/VUlv04wE?=
 =?us-ascii?Q?pLldjfenwn1Iz2WPNdtZJdtZbpdzFCg8YcOIR4P3m1ikMvMLtezwNW3Ww3Lh?=
 =?us-ascii?Q?yd1/6kmqL9wGIrNF+MLyQWLX9KzzqyrO4AwCKN5gL/D+/Z2RrK+mAK4av3Ng?=
 =?us-ascii?Q?VQQqEVOvhfNGax6LXwNePr1QFEZB4muxfdHkNPA1JIUHAv0ycL9gfr2gBYSP?=
 =?us-ascii?Q?MgpHoPQL1a92tXv06SVeEAKIUj3bWJ6U9smW8RLQo1XAEMBoTvMstojyGhf7?=
 =?us-ascii?Q?TJLEknj3Xg5wCHMuSTcYghsuqhgbTH7Yv/yzUOeOnlCDNJoDxzMLhsCf1YU3?=
 =?us-ascii?Q?UdCkVdnNGermASGQZoCj9WcbqnS+5MSDWNO4Hc4AuRekE1raz5YQwcMfTAcm?=
 =?us-ascii?Q?oowFfMpqEp2V5YuiY5l91RutJI6LBeiZtp88TW4ppWddoHhiReesIE9PN2ZR?=
 =?us-ascii?Q?VUTNX/Me5/jEUqbhcbasMIc+JG79eUs+IOlE4ayIYRkih/ZmNb2bZmIg4Hvz?=
 =?us-ascii?Q?oZZBYZhbnCXuZ8clg7sZjkaxnWHhyJRIiUqkzGkMpvZF0+sQ4EE5PKtvwevy?=
 =?us-ascii?Q?no3zSxPTN1DWdCCl1ONIcvD+GcuygSDuVT2FFT8CrQYI641WSc22AS3NFWM1?=
 =?us-ascii?Q?jzQhpfPFiQuYNqy3rVBrWeT2J+UiKEBrRb/++eGTdFSCHS19gWI9wqBEvewt?=
 =?us-ascii?Q?umDR1i+H3jzP/3P2/vcfVWJDI5WWAAeE+O7oV219zfJxREhauaBFS757lP9x?=
 =?us-ascii?Q?NATMT1Y/vDL22kLdZ818j4eEJAgCTj1+/mSl/rEmtQ1H7xnuM9HEhx9FdC8h?=
 =?us-ascii?Q?R3zs6L6ceqg22E5VV8FDXXwNegqzP3qMEeIHeB0eUe0qjFzAR9m4Lkd0FUF0?=
 =?us-ascii?Q?VZP7HmLvvCN7A6bQECoy8nbpc18rUyBmB/dFq7MQ+fxI6fnV9zfAkVJKpeg+?=
 =?us-ascii?Q?07U6IS0QDA/HLSIuytlu1cyjoir9xhxG+8G6Jg9ZDDeF+5KJv57329+aZBaT?=
 =?us-ascii?Q?Hlw43jvOtGaYuJpVbHXS79KFdF8rhaG81rCL6X+YZ3aDj/lXB10Ta/N9741a?=
 =?us-ascii?Q?S5rscVhW5sExvl0vRsW60ss863tCjGgnMzlepN6vydpE+/7cFpFrEgyT/bAD?=
 =?us-ascii?Q?ShTK2RtOzmFhvTVKx59J+FCiWsK2vL1UKkf3ej7NDs0Gcw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EKPoiTL55etlL2DPq9kWvOhZfADShZAOiGOHzwJGC/ER6owL9Uz13yXSfYqL?=
 =?us-ascii?Q?GV9XS9/+JltUapNKxHyxVTj16f3s+smG3PXmPqtmDawDj/XR/ZmszspFqmSp?=
 =?us-ascii?Q?FFawGn9qSGPHiKzoIPdzF/fzVi108IVz/sB2gW93x8QRS1+QJBUmlgtAFWu3?=
 =?us-ascii?Q?9SVSLD+eHFoDGkI9Zsp3TYtZ8M+NdAXOVTDagj8Yfc9Grgy0uNIVcFxJ/5eA?=
 =?us-ascii?Q?b7LxBqrYswiSXPOb6d1Z+Tb10nJTfvmRO2fYfIlHiTJ/HvUw2Pt1Qpacv6nH?=
 =?us-ascii?Q?IMOAD0WxaIReui8zD49CICWwG7IQO5FivvXxhWMKqwl0I24179GTS6BsV4Mw?=
 =?us-ascii?Q?g6KYx48UePqG0TCK/SFgIREtFJq4qNEsBfBjfEFj1dl1yPF6vmHBhGlEgYHN?=
 =?us-ascii?Q?9xgc1hu7lIIvsPYFpmBiLnxSBpnfMBcBh5z7E8vW6jDd6cZXFbNFyPInr7dE?=
 =?us-ascii?Q?n6uQD1KWuU7d8zj5AsBwQUSOvWjXefoJw8e2X7/6TESgfjnGmL9Uoby2CLmB?=
 =?us-ascii?Q?B39W9ynPnSm5PB5RjdszpbWnjWaoAuUpYVXo9q9FXLtbzLhkns3GlQ5B6/P8?=
 =?us-ascii?Q?SsEPOaPGVD6h9mzL7KbdTT0y2M6QgfvGQupcPB1qnvwn6j1VNi/SbdXSfPp6?=
 =?us-ascii?Q?9FYjswTcfK67G1LXWRnhjBU07UtaMw+WSFYcosKZttcwHik8Ynp4Ju51AI8V?=
 =?us-ascii?Q?1kKQg3i6WB6WksI82H/xmgHf9yQ7DLAwXdmNXJVAqMzgr9A9SKfj2x1Awfiy?=
 =?us-ascii?Q?Gg18b7eQc9h0G15k14YyHaX2ZOsMh8pi+6mpkvLcGzDOePWXOKiEOYZgDyJS?=
 =?us-ascii?Q?NtohrGq2VXk7QsJlLgWQfLPkPORdtqMSHpQC5VRQ8GjqKF/R/zZa2c6byzzy?=
 =?us-ascii?Q?mMeQYPM0JjCYeX7rXquhJFzedfa5y7yT+a6rub89kGmCjqJAns2lR4jofsLk?=
 =?us-ascii?Q?v/WMsvq7emnZx7zV0x99+dGwv5F7Tw9Drb3a35fEn9L2L/LMnsVC/OFMuziO?=
 =?us-ascii?Q?kBpycS2VFERSOT4rwIwg4CMVsvBzQ1cxtpodQJg0IO9juuKOJLo/YYE5+V7R?=
 =?us-ascii?Q?+G4iiYYlw9hUC8gV0wQ2E8hp03QlYYbwvLAXitLi3yBgSbFkugU2GL8ez9bN?=
 =?us-ascii?Q?dVjtaMXAr2U4OSJuzzB6yH4q8gcdWuOK4uKGLJKJox+zcVozkDY+5q3Ear0p?=
 =?us-ascii?Q?PB7ZAJqGtgUIEsc/A9KmYSDZCuYe945dO440WLpOCJ+uD5lblMM+324JjYqx?=
 =?us-ascii?Q?UPapSu2YyP/gpkd7PPsBP13NXM7j3Th2WZO0F+kr85eA/Ivprbdh2H7ELNL/?=
 =?us-ascii?Q?e420wJTKku6eyxr/jna+G2CVDZBsRo8tFIv30zgE+C8ZhKZaEiArFx7fvfQg?=
 =?us-ascii?Q?fQdPmabxoGTj2NYU69ny3m1kFZvCaR7158k51xmO/g6+RyZkj8IevQVxXgoG?=
 =?us-ascii?Q?FNmUO5mh/voKPhUQsoFiqyfYbiuwe5IdttCtzV7Lp/OyfrLNymrC9lT9jLPf?=
 =?us-ascii?Q?oLqrY93JD+1nc4WyMtXPnFkWGb5F50thTeMDeyk8UbNLiu2if3h9KtUYgN3N?=
 =?us-ascii?Q?+k07KF/jgzsgEIDGDq0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305deee8-9fb1-424c-f27b-08dc73f349ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:53:13.4232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0DJykimwGT1Bgd7vlAViTUObxKdBwWdfxNLCGxRFmGKxN/F3uNeEve3KWKBy5RF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

From: Likun Gao <Likun.Gao@amd.com>

Switch the default mes to uni mes for gfx v12.
V2: remove uni_mes set for gfx v11.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 82d064adaa49..e5fc100c9ce7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2248,8 +2248,6 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct =
amdgpu_device *adev)
                amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
                adev->enable_mes =3D true;
                adev->enable_mes_kiq =3D true;
-               if (amdgpu_uni_mes)
-                       adev->enable_uni_mes =3D true;
                break;
        case IP_VERSION(12, 0, 0):
        case IP_VERSION(12, 0, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index caf89d21b61c..82b02bb261b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -197,7 +197,7 @@ int amdgpu_discovery =3D -1;  int amdgpu_mes;  int amdg=
pu_mes_log_enable =3D 0;  int amdgpu_mes_kiq; -int amdgpu_uni_mes;
+int amdgpu_uni_mes =3D 1;
 int amdgpu_noretry =3D -1;
 int amdgpu_force_asic_type =3D -1;
 int amdgpu_tmz =3D -1; /* auto */
@@ -694,7 +694,7 @@ module_param_named(mes_kiq, amdgpu_mes_kiq, int, 0444);
  * (0 =3D disabled (default), 1 =3D enabled)
  */
 MODULE_PARM_DESC(uni_mes,
-       "Enable Unified Micro Engine Scheduler (0 =3D disabled (default), 1=
 =3D enabled)");
+       "Enable Unified Micro Engine Scheduler (0 =3D disabled, 1 =3D
+enabled(default)");
 module_param_named(uni_mes, amdgpu_uni_mes, int, 0444);

 /**
--
2.34.1

