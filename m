Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09206CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 07:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD4010E52B;
	Tue,  4 Nov 2025 07:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dj9Au35B";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013030.outbound.protection.outlook.com
 [40.93.196.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E903310E52B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 07:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brpGrgyUkX3oSZLa/QWe6P+YaC5QE9HMo/1eeknOYeURWl/BUmuCgqO/hUZzcm2IDybjhFQDWG+emDJiXvsX3ErYZ74iQU+WOgz8sBJuzBMTWbHmLAa4peIFvzh41X2O0tD0TazcsxNOvO+VJMf95BLed/a+nstJqFWspXJNtLn6B1jyNzPil4pKyiz0O2Gbasc0rxahdPM2h/ZjBT9/RSgNzIUB0wzrGXuifkEOrJkfY+gqWuaak+VRwh0c0BuzqODymRVlEaslKIWg0K+T0F12Z61lvXKcnoCyEHJzBlCK44emOadZIivps9HbweEVQBVhBdPA/TcdFej/RzYYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0aN7My6MoWuA6nPlAFOO95KidahNSJ8RHam1QBTsUA=;
 b=VDRZU/XSG1NtO+mvQvoDzTS8Dzlo7NFjWifz7SCTik3xA1cOSCeZlkeCV7eykXaWjBn1Uh1gyZeYiymBW7i8gI78j0vaUTrmh3yFZcE2dGYzUMJkGMgTi0ehbypuCdSlSVmmt4XPJKni8igeJyYYXqt+1+qh+fOMYHS4btX8AD40IHV/bZkM1SC0Hp6MdjTXziR3D+BbtQTz5tAV6LcXjKZNSzO1j/oFo8nXEeOq/I5iR4i9XHHifw/evZ4+OflJv/OLQzqUcpqfbVJq/TDZZbQvSYkXfh4YoZgcz9L/ZSrbvyotRj30aaXo78+O4APUpnxdpyoE8USCp3HHYd9B0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0aN7My6MoWuA6nPlAFOO95KidahNSJ8RHam1QBTsUA=;
 b=dj9Au35BjOQ84E9HjtGofiC5BVg5BC1GbxtkvYL/Lx3yGjM00a0dHEEgDCDiasiNP6B+iSX+YpZA2Gmd7O1C/i8u+SGs0flQEyn+UMMsOr8X31XwXR2ZEqCFEno00JGLk8jb0mQQcRCX+oyFzBDuVIdQB6uNxv46sqqFlGY8HnA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:20:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 07:20:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: suspend ras module before gpu reset
Thread-Topic: [PATCH] drm/amdgpu: suspend ras module before gpu reset
Thread-Index: AQHcTJvMbQNz+cNdLUWrVaiArDB0vLTiHaHg
Date: Tue, 4 Nov 2025 07:20:15 +0000
Message-ID: <BN9PR12MB525783E6EEC6133DA990BB6AFCC4A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251103082733.2671013-1-YiPeng.Chai@amd.com>
In-Reply-To: <20251103082733.2671013-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-04T07:19:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB8364:EE_
x-ms-office365-filtering-correlation-id: 957197d8-e1fc-41b0-8713-08de1b7299ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?adf3J6AmSGJmxfHyFlZihNmqIIyPovbpiJybttVCsLBlAKzyCb/q/DJlYFFY?=
 =?us-ascii?Q?h4Da4yq7rvCjedhRT43BTuTKJ32J4lOj953IjNkCw0oUPu1WbDxfiHUk7L9j?=
 =?us-ascii?Q?RMCBq0/AtH5VPEJAfD3Nr0PC496vC7Ano5r/r3IiPAHFuthVrqIEIJNeFXsx?=
 =?us-ascii?Q?pSa3Uhbul7wsX2Y0Vqrt/OJlIrs8NxDPn3x/TvMmKLNEzMvQWKLfrdVxopdj?=
 =?us-ascii?Q?CJV41y7zAx/o7QYFl/ns1aWtTJq+4Ppx8y38AtFhsXC8oJDYomLg4fh5Ff4b?=
 =?us-ascii?Q?5zcTwK0V9AvjjCB2yO+4UNk50N8TeJbQl4keE5ugMu9RFGWReMFiozwaRpHv?=
 =?us-ascii?Q?18u6KDpfG1mzYb1Sm7tvtUaFzTRp93ft6PT6eS1uOvTzksLjumwGPwHP/g1C?=
 =?us-ascii?Q?I82HWHuj6FTcIFlIPssnBIexg1e01T+TrJHgftD4L0yRp7LkJ0eaAfj7Lwh1?=
 =?us-ascii?Q?Ban9hX0ccKAOtNkPHKHrI7vJolYUp3k/ca1qZrrz3WJcAmMd0/puuTpoPQmD?=
 =?us-ascii?Q?TJB+lx8w/QphhiNkkizhh30JBC4AGhet1tEZxC8Q1m7eSScnlVGlrHUnsHA/?=
 =?us-ascii?Q?HS9PsNURWGPPOi1fNrlAG/WKkmqdE+g6MjAttP7WRax8sGuVklVoGXzKIQ6L?=
 =?us-ascii?Q?QYiRZ5+/jQnYCN6qNyCIXxYDw/Hi/51GgePNMJm9z3uzdQq24npkXlsKcg5T?=
 =?us-ascii?Q?RwsDgPPUiyLfhJjD2Fd+Whm9hokBuP2Za27y1kCUdelpJ8A6/trRXd7hZM72?=
 =?us-ascii?Q?BIE1gvHEGBB5QqQCbbyJ7iekCgKDJLsnLYqp7qCUAWu+8Fzhm57NLE0M3o0U?=
 =?us-ascii?Q?aWvISMrgMKDkZhf/bZj/w8TmNW8fJn7i4FY6XPSqkurMTFtvtT57sgh3MMNU?=
 =?us-ascii?Q?ZoLFwKMPRENaIZCrvJIeKQMqEiLPAO3z+tj+jiZHiSlvhn8B0Tbdp1442CSV?=
 =?us-ascii?Q?AL19SfOqr4MTBuVSE3wWfNrzoH/fSma7wvfhVuusOEIuJpexjxUWpVdIZm1i?=
 =?us-ascii?Q?oVCCy5CxPg2icnAGPQ0eRT7S83WqoCJXGkjzE7pG/JxF2HpZS5cChlGElQWH?=
 =?us-ascii?Q?Yd6spd8f5Hru7zX2zt2osJ//ZNOhpXHgjjoXhVK4lMvobUxGa1oGc8d7KQ0q?=
 =?us-ascii?Q?tGSF7X2wU7TP5nwUDUPIHlImHf434ausQku6GH14i8HJrkMv2TTjwxlAOG9F?=
 =?us-ascii?Q?ZL5bBSpvuff4DUQQWIErVF8wfw0FtBvCb1JVo0X/gFCpYDsqVHMnR9x/bU9N?=
 =?us-ascii?Q?gj9lHT30PRNmETE6Qzr4ujt2yR2J/gD70wdOfcoJ1h9v0kLcnLoSYZC0hQrx?=
 =?us-ascii?Q?Ir2tHtNV56+zGyhvy1lubhzROUZ2pJV8G1SvWEj7E5P3Z19j8sOrjAAJYSfC?=
 =?us-ascii?Q?GSM/alkwGzf7mNyQ/o33hgRlRQX4tLzCbd/6t41LoVoEK2VeOGmtDnvOXuXf?=
 =?us-ascii?Q?uHa7C7UmF4G87URsTpaXnhjUDKJMgmuVeCGcHS//J8EPxjGcJzxw+ULx9inx?=
 =?us-ascii?Q?c/bINmQdcDyIOUsnhdDEI0pSPM8kbpVUPVMB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OewC5frZPJFuIpJovROep9BXLCYslZ7mXkGJr9ufzSz0R+yVgihHS1oK8O00?=
 =?us-ascii?Q?2boMPJC5Wxk/vzud4EmP10Oi9L223kB0IDMA0RLCcIFN0RCtTL/SUwS3//DJ?=
 =?us-ascii?Q?aISQZUZ4kHST156Q8f3KmKdNG0n2tmGEEdQwdccOVlp6Q3+UCtATMRk+gnQz?=
 =?us-ascii?Q?rIEIFJfPI/ordHi5nMnaPTGGwbPCUxO6XZDHhAzZl29ydnkFrP5xyfo65SRz?=
 =?us-ascii?Q?Ee9oe4Abv1D/2QxTK4ywLShbYbV2HjrLxss6WBRNTF7Wx/JNlx2EUvllvpfT?=
 =?us-ascii?Q?Ow3Z4QVhy/z/a35OKRPxzqRCgTFoOGl2Vl3ztpxl1iPJQMMHmsd4iFxzmoOB?=
 =?us-ascii?Q?YwOjawuXw74a7/iXyEWe2f+7JCjahE27zcg2ghn/BryvyEC5+BEwqHYcREbY?=
 =?us-ascii?Q?Qv27dpue9BW420pJwczNutsakRRDFV7tEvMzz+TLjKUFDg/QBGtECvWWgJdn?=
 =?us-ascii?Q?HTmA8fnyrWeB/009navXg8hzb4MLpN1KvtWqVXNRjFG7GTUIeOhgA7I/AcrD?=
 =?us-ascii?Q?LaRR6uZ87Kt59j4sS/K0GSWKxBo/Osfsljm7mH7Iqy+pRvj8LftnU/EIm/Hj?=
 =?us-ascii?Q?e2xIpJ9zBgcDWNBFzaWySRBmL6aJO4Mw2jKA/7S8poK3Wa7FsOS4BSns5Miu?=
 =?us-ascii?Q?TlllH7iOjwVs6vzYubNot6liuTrI3IYz8FFt7f7YcsMgwbEswgCIHlX+10lj?=
 =?us-ascii?Q?XUmHYFiop77bPeJq7Yddc36Y90BLFDB3tdlUivNlmb9juABdp/BDrCrHP+Kt?=
 =?us-ascii?Q?/fxrcqId4bd82OstQzt2wfyyKhfitgyySyfGU0amV2Xe3KERY43oeRFqTATx?=
 =?us-ascii?Q?6WG8dkuOFtZ7z0KUjZ2kYZmWxVRhfgNuSTcqtsNz9yVoGnuod4sDLKKaox4L?=
 =?us-ascii?Q?MmbxFIxexDG3iFKOptimC2Wl6gyDeLzf9EHIu9Fe0Iu+56aJPrvJPga+78gA?=
 =?us-ascii?Q?I7Usov6prFsa/TMHobMK6GE1iBRy4KbSqrY41U/7EedgMUyIAKJ2JVtaLDar?=
 =?us-ascii?Q?7KYOfvZTJxlENUBo/e/eLeGtc4qoig2JZYiy8t3KkFZruLe8v9gjjqoznlDr?=
 =?us-ascii?Q?gg9qqNoR5nSxsHE+loPlaul4RorTZj74fq6jzVTYLaepp+MI577DxcZX9VYM?=
 =?us-ascii?Q?jP3C1EIgdCHJqMyDkotJtt1FadKyYwl9/E45Fq3cM1iouCVdGaXvYDIX3w0b?=
 =?us-ascii?Q?BFZc7XCDjlYII56McbEEgSLCIPGL8KK9YHCBc8t+VeUdSQ8WuxAzKFAcVrZN?=
 =?us-ascii?Q?5VnaZ8vvHvQ+QQOmHakoAV8N89v+ZnARV8ycUuBc/Tmft+OpKONBH7Yvsns6?=
 =?us-ascii?Q?FzUxCdakPDgaJEswTZqI9NpfB9hSwxrJqrta/9L3TdHEoRAUsEjlHz36NQX0?=
 =?us-ascii?Q?mtKSIU0FSPczOQHcNuo7teCPa9BCYjrbZ6T94k+hsw8eW0Q1mXAWwwuFE7Pr?=
 =?us-ascii?Q?i1XeEKvrxqVKv652KM/C+bSbtJm9o3NdwnGPGiVdFWd+WoTiHBCqgxyyzzNI?=
 =?us-ascii?Q?80b/irfhkzmfHVHvePkQeEzLzzZS972b5Sar+Z9meiWMA5mk82/D9LnkKOHe?=
 =?us-ascii?Q?Ob1mDMAZ2ZDmZk67N0Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957197d8-e1fc-41b0-8713-08de1b7299ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 07:20:15.1106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ECHkWY72vFU2XRTVJCh82D4XKThdUiTInKfp7CPOH7KOWozPWNru/e+hINmveHL1eLGcFTyjiEkfeF9vvvLjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Monday, November 3, 2025 16:28
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Su=
, Joe <Jinzhou.Su@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao =
<Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: suspend ras module before gpu reset

During gpu reset, all GPU-related resources are inaccessible. To avoid affe=
cting ras functionality, suspend ras module before gpu reset and resume it =
after gpu reset is complete.

V2:
  Rename functions to avoid misunderstanding.

V3:
  Move flush_delayed_work to amdgpu_ras_process_pause,
  Move schedule_delayed_work to amdgpu_ras_process_unpause.

V4:
  Rename functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 26 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  8 ++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22 +++++++  .../gpu/drm/am=
d/ras/ras_mgr/amdgpu_ras_mgr.h  |  5 ++  .../drm/amd/ras/ras_mgr/amdgpu_ras=
_process.c  | 64 +++++++++++++++++++  .../drm/amd/ras/ras_mgr/amdgpu_ras_pr=
ocess.h  |  4 ++  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  6 ++
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 +
 drivers/gpu/drm/amd/ras/rascore/ras_process.c |  7 ++
 9 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index cc6e59208cac..9e8802ccc75e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -71,6 +71,7 @@

 #include "amdgpu_xgmi.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_ras_mgr.h"
 #include "amdgpu_pmu.h"
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_reset.h"
@@ -6586,6 +6587,27 @@ static void amdgpu_device_gpu_resume(struct amdgpu_d=
evice *adev,
        }
 }

+static void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
+                                         struct list_head *device_list)
+{
+       struct amdgpu_device *tmp_adev =3D NULL;
+
+       list_for_each_entry(tmp_adev, device_list, reset_list) {
+               if (amdgpu_uniras_enabled(tmp_adev))
+                       amdgpu_ras_mgr_pre_reset(tmp_adev);
+       }
+}
+
+static void amdgpu_ras_post_reset(struct amdgpu_device *adev,
+                                         struct list_head *device_list)
+{
+       struct amdgpu_device *tmp_adev =3D NULL;
+
+       list_for_each_entry(tmp_adev, device_list, reset_list) {
+               if (amdgpu_uniras_enabled(tmp_adev))
+                       amdgpu_ras_mgr_post_reset(tmp_adev);
+       }
+}

 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler @@ -66=
60,6 +6682,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
                        goto end_reset;
        }

+       /* Cannot be called after locking reset domain */
+       amdgpu_ras_pre_reset(adev, &device_list);
+
        /* We need to lock reset domain only once both for XGMI and single =
device */
        amdgpu_device_recovery_get_reset_lock(adev, &device_list);

@@ -6691,6 +6716,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
 reset_unlock:
        amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 end_reset:
+       amdgpu_ras_post_reset(adev, &device_list);
        if (hive) {
                mutex_unlock(&hive->hive_lock);
                amdgpu_put_xgmi_hive(hive);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5377cde0c55d..cb4f4b5668ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2921,8 +2921,12 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                type =3D amdgpu_ras_get_fatal_error_event(adev);
                list_for_each_entry(remote_adev,
                                device_list_handle, gmc.xgmi.head) {
-                       amdgpu_ras_query_err_status(remote_adev);
-                       amdgpu_ras_log_on_err_counter(remote_adev, type);
+                       if (amdgpu_uniras_enabled(remote_adev)) {
+                               amdgpu_ras_mgr_update_ras_ecc(remote_adev);
+                       } else {
+                               amdgpu_ras_query_err_status(remote_adev);
+                               amdgpu_ras_log_on_err_counter(remote_adev, =
type);
+                       }
                }

        }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index f8ec0f26a9e7..36c665c3ee48 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -622,3 +622,25 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device=
 *adev,

        return ret;
 }
+
+int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev) {
+       if (!amdgpu_ras_mgr_is_ready(adev)) {
+               RAS_DEV_ERR(adev, "Invalid ras suspend!\n");
+               return -EPERM;
+       }
+
+       amdgpu_ras_process_pre_reset(adev);
+       return 0;
+}
+
+int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev) {
+       if (!amdgpu_ras_mgr_is_ready(adev)) {
+               RAS_DEV_ERR(adev, "Invalid ras resume!\n");
+               return -EPERM;
+       }
+
+       amdgpu_ras_process_post_reset(adev);
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 42f190a8feb9..8fb7eb4b8f13 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -52,6 +52,9 @@ struct amdgpu_ras_mgr {
        struct ras_event_manager ras_event_mgr;
        uint64_t last_poison_consumption_seqno;
        bool ras_is_ready;
+
+       bool is_paused;
+       struct completion ras_event_done;
 };

 extern const struct amdgpu_ip_block_version ras_v1_0_ip_block; @@ -75,4 +7=
8,6 @@ bool amdgpu_ras_mgr_is_rma(struct amdgpu_device *adev);  int amdgpu_=
ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
                uint32_t cmd_id, void *input, uint32_t input_size,
                void *output, uint32_t out_size);
+int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev); int
+amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers=
/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
index 6727fc9a2b9b..5782c007de71 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
@@ -29,6 +29,7 @@
 #include "amdgpu_ras_process.h"

 #define RAS_MGR_RETIRE_PAGE_INTERVAL  100
+#define RAS_EVENT_PROCESS_TIMEOUT  1200

 static void ras_process_retire_page_dwork(struct work_struct *work)  { @@ =
-57,6 +58,9 @@ int amdgpu_ras_process_init(struct amdgpu_device *adev)  {
        struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;

+       ras_mgr->is_paused =3D false;
+       init_completion(&ras_mgr->ras_event_done);
+
        INIT_DELAYED_WORK(&ras_mgr->retire_page_dwork, ras_process_retire_p=
age_dwork);

        return 0;
@@ -66,6 +70,7 @@ int amdgpu_ras_process_fini(struct amdgpu_device *adev)  =
{
        struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;

+       ras_mgr->is_paused =3D false;
        /* Save all cached bad pages to eeprom */
        flush_delayed_work(&ras_mgr->retire_page_dwork);
        cancel_delayed_work_sync(&ras_mgr->retire_page_dwork);
@@ -124,3 +129,62 @@ int amdgpu_ras_process_handle_consumption_interrupt(st=
ruct amdgpu_device *adev,

        return ras_process_add_interrupt_req(ras_mgr->ras_core, &req, false=
);  }
+
+int amdgpu_ras_process_begin(struct amdgpu_device *adev) {
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+
+       if (ras_mgr->is_paused)
+               return -EAGAIN;
+
+       reinit_completion(&ras_mgr->ras_event_done);
+       return 0;
+}
+
+int amdgpu_ras_process_end(struct amdgpu_device *adev) {
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+
+       complete(&ras_mgr->ras_event_done);
+       return 0;
+}
+
+int amdgpu_ras_process_pre_reset(struct amdgpu_device *adev) {
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+       long rc;
+
+       if (!ras_mgr || !ras_mgr->ras_core)
+               return -EINVAL;
+
+       if (!ras_mgr->ras_core->is_initialized)
+               return -EPERM;
+
+       ras_mgr->is_paused =3D true;
+
+       /* Wait for RAS event processing to complete */
+       rc =3D wait_for_completion_interruptible_timeout(&ras_mgr->ras_even=
t_done,
+                       msecs_to_jiffies(RAS_EVENT_PROCESS_TIMEOUT));
+       if (rc <=3D 0)
+               RAS_DEV_WARN(adev, "Waiting for ras process to complete %s\=
n",
+                        rc ? "interrupted" : "timeout");
+
+       flush_delayed_work(&ras_mgr->retire_page_dwork);
+       return 0;
+}
+
+int amdgpu_ras_process_post_reset(struct amdgpu_device *adev) {
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+
+       if (!ras_mgr || !ras_mgr->ras_core)
+               return -EINVAL;
+
+       if (!ras_mgr->ras_core->is_initialized)
+               return -EPERM;
+
+       ras_mgr->is_paused =3D false;
+
+       schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h b/drivers=
/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
index b9502bd21beb..d55cdaeac441 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
@@ -34,4 +34,8 @@ int amdgpu_ras_process_handle_unexpected_interrupt(struct=
 amdgpu_device *adev,
                void *data);
 int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *=
adev,
                void *data);
+int amdgpu_ras_process_begin(struct amdgpu_device *adev); int
+amdgpu_ras_process_end(struct amdgpu_device *adev); int
+amdgpu_ras_process_pre_reset(struct amdgpu_device *adev); int
+amdgpu_ras_process_post_reset(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index f21cd55a25be..45ed8c3b5563 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -142,6 +142,12 @@ static int amdgpu_ras_sys_event_notifier(struct ras_co=
re_context *ras_core,
        case RAS_EVENT_ID__RESET_GPU:
                ret =3D amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t =
*)data);
                break;
+       case RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN:
+               ret =3D amdgpu_ras_process_begin(ras_core->dev);
+               break;
+       case RAS_EVENT_ID__RAS_EVENT_PROC_END:
+               ret =3D amdgpu_ras_process_end(ras_core->dev);
+               break;
        default:
                RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\n"=
, event_id);
                break;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h
index fa224b36e3f2..3396b2e0949d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -115,6 +115,8 @@ enum ras_notify_event {
        RAS_EVENT_ID__FATAL_ERROR_DETECTED,
        RAS_EVENT_ID__RESET_GPU,
        RAS_EVENT_ID__RESET_VF,
+       RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN,
+       RAS_EVENT_ID__RAS_EVENT_PROC_END,
 };

 enum ras_gpu_status {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/dr=
m/amd/ras/rascore/ras_process.c
index 02f0657f78a3..3267dcdb169c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -162,6 +162,11 @@ int ras_process_handle_ras_event(struct ras_core_conte=
xt *ras_core)
        uint32_t umc_event_count;
        int ret;

+       ret =3D ras_core_event_notify(ras_core,
+                       RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN, NULL);
+       if (ret)
+               return ret;
+
        ras_aca_clear_fatal_flag(ras_core);
        ras_umc_log_pending_bad_bank(ras_core);

@@ -185,6 +190,8 @@ int ras_process_handle_ras_event(struct ras_core_contex=
t *ras_core)
                atomic_set(&ras_proc->umc_interrupt_count, 0);
        }

+       ras_core_event_notify(ras_core,
+                       RAS_EVENT_ID__RAS_EVENT_PROC_END, NULL);
        return ret;
 }

--
2.34.1

