Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC533C624D4
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 14:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2278710E48B;
	Tue,  1 Sep 2026 14:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dnQXH5Tl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F5710E48B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 14:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOMFCfUYROddhiwjn4mv/H429RJMY1gJrbj12k9EplCW+yLgLJv3rjPOn3H2xGZG6FuKBVIoaTyJlLzgEZtwb2ly3B86o+pe6b7Cg8xwrua99jkmkbN5xkCg7oQdrCpTsN2iC8gqmqslroZkPCY5LhhjSRafDE1NDfk1Fao/MP6yv/BzCgnDNaO0PwM81ijD7qBYdB6c6t1515YqHFrh9Ci9zgnbhuElgdJcg7N2vcGcFVe5ssdvq/aTSClttIWxAYvLWXawtCMNBUy5797YXL+N7EC12/X+DUCteMYDkoETVtRVcia1YWFNUU28SWIHAFssqYdthHYN/4ZJlByA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEVEbdniYH6DBM/taJk4wPJQvPnUqGfpu0bLrScUoBg=;
 b=nUsxBj4v3z9k5ho7wOWE3kr+bYae/kCioJqNvHV7r96GKL7h4QjUx9wpMqTaq9Al3+kBvUozVd5/UkUW10IOc48Nv0DbaZf0z78zu47p/bV1irZ5VRX6gQ3V+K0T/rgWjs3LE+vpAvRWY+nhAgsARHNwe/TuvQ9kvk8vPqaPESJznF7DGCz7sZVosrEG50cv5QRO2lejPLv9WeAD7IoAmAcYBEDAcXI/P81NZoMNYi94Tu9v4ouxuMpA7yTBvugDOcpV6RwrLQ/ptyYF2iYeg5yNJTPHbe8+rs4CY3y+zSTCFZapyL+7Bo1ObeXBSR0nHGtGqQE/JL3EZQfzHphYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEVEbdniYH6DBM/taJk4wPJQvPnUqGfpu0bLrScUoBg=;
 b=dnQXH5TlavGjqNuhiVCZk1fQiS/tmCB/NxF4xo+79u//tDS1c03D2pk2N+LBKnIHcbMVtjIxbrlO7srw8cedNZfkmJph3HPV53Ge8HiVfE5MsKYbddmVJ8hE4aHoqagdJKDYGOZvu12t2jBnDTCzttfCZnmeH1EaY+YeKV+/Qcg=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:23:23 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 14:23:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix UALink build errors on 32-bit builds
Thread-Topic: [PATCH] drm/amdgpu: Fix UALink build errors on 32-bit builds
Thread-Index: AQHdOhyipl3s6xfh5k24HWqV2sPsfba5xpkz
Date: Tue, 1 Sep 2026 14:23:22 +0000
Message-ID: <BN9PR12MB5146B193E70BC8E8CC0EECE0F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260901141727.196585-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260901141727.196585-1-IVAN.LIPSKI@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-01T14:23:22.320Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS7PR12MB6167:EE_
x-ms-office365-filtering-correlation-id: 07798a7e-a952-4b63-7a86-08df08349443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: EX85I5NxCXAvpWqRD2SWE4fdZhglpJQNXK2Bo33FP/gd+9rAyDrHyUj3PUQ9N0wQmAidam5wSzZe+J2fwA5xxaO7mUM38jFM3Wq9ZEotWLZ0QUXA9r3zTOBO7ZNrZc+rQyXKd6vfjYpDXW79Fzu6AEpnJ+dRCOMIX3uj+VxpBn7g1OMIOOKI0mkiVLM4Hgdm/btA0xWTGuBWcTuAEavFUWXBplIOGFPxxForz613ISsYIhlhWlsY6P+4LmwGAerXG2C3tvVNQWVRVlQUqFwAe3y7mZfD2HcRNZXLRZUeg4dFI4zCiHy2efKoIEG9T0Lt2RAd8a1saHyurdwmRTWZ43FzvVzdwf6/j8+jLckamzj5mY2L2qDQMBzaxlrLhUPCq0cr4mZ/K3Y2dPPEZBq4pAY9DN+cjVKwDEILuqWECxqGKOl1PyoLfAvNRvsL8TCd/bsOHRrUkrPNqmh2ZFaOiTsAMrskLGez05AUhKxiR3lwfmfOf4yjLxkiz9IatGNbTP1jbwt0zKG+Zv4JUv2rfIKWRS7OHe1NVfx6ptbHwwqlIsmTlN687s0cf/q44yeW0i6ThajdjFzkzONURKcKFKdpDbokCiTeNlZDml+TbDCCDZ5NFecqNrlIblevArAHaxJzVyzPuU9356cVbk9rNqfLoGKlU/NwJhp0HZgpj7GmivTJ9UhBGuBUx3v3beaaA4skx+IRlW3Twg8YjH8g9M5dOLok1R14S8eZ1TFml7E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bRbUP/cnNC3hMS8BgRXzt2bxtQIUh65S+So4QdtDgkIRsRjLRDo6OAVXUnqy?=
 =?us-ascii?Q?l2qd9qIssxyhkRxi7naGnbGm7Q15mgmHP2bd19MQUFpvHGyNT/IDUTv2BlkH?=
 =?us-ascii?Q?rd2mklCwEcqv21q00yDgaRNJ8VQB/pTW8icPcxpr2ylC4JXUYpZrNL5to3zL?=
 =?us-ascii?Q?CWYrqpuhOqbTyuaQiXt1rANhgGp03Zm0IXLHVXYwV3FJprqCrUkAeyw9ErWq?=
 =?us-ascii?Q?u/ETQ1Lze6JvZ3EeYHFaN7fClE82LlAQRqWhhkJ43OEqE7AiFZ5G2r3+RtoM?=
 =?us-ascii?Q?d5+7rHYucfFbxp+T49E2XJs4nU9dLwvxjvePrZQx6zqJfifG23ZV6hIO5fYR?=
 =?us-ascii?Q?sg4eGj5Mh+cGVgiaobZZw8g906ZqoVTsQs3Tg3p2E6nGVPQS1Mq3hdpPRnlb?=
 =?us-ascii?Q?Gz3MgkBU8mPov1zk5SegT5/6AfUuVk4l/XpyzOpm55vG9c9HXI1AaDaK5ZUk?=
 =?us-ascii?Q?RAs068vjwjVOg+9f9SfRtWYampzsGCguuiD9QG5GL/Jt4i85M+j/NVZHqXqi?=
 =?us-ascii?Q?VZTKUJB8gGjQzRD8cL8k0OcVZRIhvfWYGZlrFa5fN9eujgj+itqKYNmOc8yz?=
 =?us-ascii?Q?2M601976hgV9vdfrbmrvEn7db3Z5r8NNTJ7x7q7/BQ1ItA0YNveJZcK1JnNo?=
 =?us-ascii?Q?kHCiWaCMqi61CEQhjU2mf9GTvXAvvk+93S2DxsyzAHTVNEYuBIlC04WWUomv?=
 =?us-ascii?Q?VoTP8YpmkUwrMwymXB107VSBl7Mgj13uzYO/lsb8QCeAy6Ynst0BLSFHEbvD?=
 =?us-ascii?Q?adB+KIXV84Jmfu++GvLMbegPiCOZp/xR5MBU6rJMf80Go3pGCTU/mh0EytgK?=
 =?us-ascii?Q?Mf8hh5Q8EkqXu+bufVsIhtN0BQIrroqnz4iwZwY5nkJNhDKuacWrGJ/vjKn6?=
 =?us-ascii?Q?8oIIRMes6Pf8LyLxBJKZhMbxjv/O1to4i6kXt2tgCO89bYxK9L/28MdjyrjG?=
 =?us-ascii?Q?pWsN35c70hWqWIlr+y53auxx88/6DopSK97ZE+rPeuUkqXmgOG3Gmesv56iB?=
 =?us-ascii?Q?XTgWolAQXeVSjZgHkprXA1LcTwOi/4P7zQd1eDEMhFDhm75ynsL98+l3dA9N?=
 =?us-ascii?Q?9WaY1196DWA07f9aDDCjkb6X7Frz0C42USrBcDUYmKOcKXL9b3+wlfN3qpPR?=
 =?us-ascii?Q?7NN63VYMHUKjUxDRZvDfDV4fanKrOOAHUUqme9i/Tz6Vb/lpqc3v5yefvCdX?=
 =?us-ascii?Q?iT29iRWNNyWkFoNw7quRtdaaEZRIX3XFC+3CuSVJHXMz9G2DHXchQzbqxuDH?=
 =?us-ascii?Q?ZKO3ieZgwbuYDAoqYVQvTLKSxlCL1HINII8to0CwwbFUgOVcFdNwOcXyUiWI?=
 =?us-ascii?Q?j3JQX8SOw2ldfwF276GYliJrhg7Pg+GYW4XT77R+E/uSizw17b1gXitiSxcR?=
 =?us-ascii?Q?PzE/zmHHlVyJQ38NlBCQ0UIbIZQZ2EUuP2toJbBKQQizLJnid74S42lH4jlk?=
 =?us-ascii?Q?fzii33jRF36l8zyhdyGlIlE/hA+Bie88zqqtEVd7raMtttMNMGHyCAANXehA?=
 =?us-ascii?Q?vBN282g6TujRFCJTN8o+6wuEUMbnaS9jUJw8xLgvsah7s2bQieL4nBVwNgsN?=
 =?us-ascii?Q?jmgW8fJnwrFdfi/XVaduBphOmH/wwMeWpwVTgTwZawjfzpId8zGakkUBxM+h?=
 =?us-ascii?Q?Fs/vm8G/MBJIo9RzPXBzSwkDgBk6K0iHbqJMP/GNzOKAFj2TK6WU7OoGvlko?=
 =?us-ascii?Q?NnaqTT/zLTyjLlmRYLSwlm3V9zddkuX/F30Wfn8zi8BfbCRA?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5146B193E70BC8E8CC0EECE0F7A82BN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07798a7e-a952-4b63-7a86-08df08349443
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 14:23:22.8548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSwT/abOSzWBSGO+rWuU2vcKQD5LWHSgshDHWzn5J3HFib3VSauazyYBY5HwBw6t3SotPAuTjpBX/uDDEq40EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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

--_000_BN9PR12MB5146B193E70BC8E8CC0EECE0F7A82BN9PR12MB5146namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: IVAN.LIPSKI@amd.com <IVAN.LIPSKI@amd.com>
Sent: Tuesday, September 1, 2026 10:17 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Subject: [PATCH] drm/amdgpu: Fix UALink build errors on 32-bit builds

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Building the UALink code on x86-32 (ARCH=3Di386) triggers -Werror failures
due to pointer/integer width mismatches:

- In amdgpu_ualink_get_wb_addr(), casting the void * CPU addresses
  (rb_cpu_addr/rptr_cpu_addr) to u64 causes a pointer-to-int-cast and
  int-to-pointer-cast warning where pointers are 32-bit. Use uintptr_t
  for the writeback address so it matches pointer width on both 32- and
  64-bit targets.

- In amdgpu_ualink_peer_remote_init(), the doorbell NPA constant
  '0xFFFUL << 40' overflows on 32-bit where unsigned long is 32-bit,
  triggering a shift-count-overflow warning. Use a ULL literal so the
  constant is 64-bit on all architectures.

No functional change on 64-bit.

Assisted-by: Copilot:Claude-Opus-4.8
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ualink.c
index f82bc9a9d083..ad8cc95e6cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5674,15 +5674,16 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu=
_device *adev,
         struct amdgpu_ualink_remote *remote =3D to_remote(adev);
         u32 accel_id =3D ualink_accel_id(adev);
         u32 rb_size =3D AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
-       u64 wb, npa;
+       uintptr_t wb;
+       u64 npa;
         u32 offset =3D 0;

         if (ualink_addr_mode(adev) =3D=3D AMDGPU_UALINK_ADDR_MODE_SOURCE_I=
DENT) {
-               wb =3D (u64)remote->rb_cpu_addr + rb_size * remote->num_acc=
el;
+               wb =3D (uintptr_t)remote->rb_cpu_addr + rb_size * remote->n=
um_accel;
                 npa =3D amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
                                              remote_accel_id, accel_id);
         } else {
-               wb =3D (u64)remote->rptr_cpu_addr;
+               wb =3D (uintptr_t)remote->rptr_cpu_addr;
                 npa =3D remote->rptr_npa;
                 npa |=3D (u64)accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUI=
D_SHIFT;
         }
@@ -5914,7 +5915,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdg=
pu_device *adev)
                  *     1 - PMI1 Remote TLB Shootdown
                  * ReqAddr[5:0]   =3D 6'h0
                  */
-               npa =3D 0xFFFUL << 40 | (u64)dst_accel_id << 30;
+               npa =3D 0xFFFULL << 40 | (u64)dst_accel_id << 30;
                 r =3D amdgpu_ualink_gart_map(adev, 1, npa, &interrupt->mm_=
node_doorbell, flags);
                 if (r)
                         break;
--
2.43.0


--_000_BN9PR12MB5146B193E70BC8E8CC0EECE0F7A82BN9PR12MB5146namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> IVAN.LIPSKI@amd.com &=
lt;IVAN.LIPSKI@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 1, 2026 10:17 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Kuehling, Felix &lt;Fe=
lix.Kuehling@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix UALink build errors on 32-bit build=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Ivan Lipski &lt;ivan.lipski@amd.com&gt;<br>
<br>
[Why&amp;How]<br>
Building the UALink code on x86-32 (ARCH=3Di386) triggers -Werror failures<=
br>
due to pointer/integer width mismatches:<br>
<br>
- In amdgpu_ualink_get_wb_addr(), casting the void * CPU addresses<br>
&nbsp; (rb_cpu_addr/rptr_cpu_addr) to u64 causes a pointer-to-int-cast and<=
br>
&nbsp; int-to-pointer-cast warning where pointers are 32-bit. Use uintptr_t=
<br>
&nbsp; for the writeback address so it matches pointer width on both 32- an=
d<br>
&nbsp; 64-bit targets.<br>
<br>
- In amdgpu_ualink_peer_remote_init(), the doorbell NPA constant<br>
&nbsp; '0xFFFUL &lt;&lt; 40' overflows on 32-bit where unsigned long is 32-=
bit,<br>
&nbsp; triggering a shift-count-overflow warning. Use a ULL literal so the<=
br>
&nbsp; constant is 64-bit on all architectures.<br>
<br>
No functional change on 64-bit.<br>
<br>
Assisted-by: Copilot:Claude-Opus-4.8<br>
Signed-off-by: Ivan Lipski &lt;ivan.lipski@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 9 +++++----<br>
&nbsp;1 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ualink.c<br>
index f82bc9a9d083..ad8cc95e6cfa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c<br>
@@ -5674,15 +5674,16 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_remot=
e *remote =3D to_remote(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 accel_id =3D ualink_ac=
cel_id(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rb_size =3D AMDGPU_GPU=
_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 wb, npa;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t wb;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 npa;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 offset =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ualink_addr_mode(adev)=
 =3D=3D AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; wb =3D (u64)remote-&gt;rb_cpu_addr + rb_size * remote-&gt;num_ac=
cel;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; wb =3D (uintptr_t)remote-&gt;rb_cpu_addr + rb_size * remote-&gt;=
num_accel;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; npa =3D amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, accel_id);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; wb =3D (u64)remote-&gt;rptr_cpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; wb =3D (uintptr_t)remote-&gt;rptr_cpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; npa =3D remote-&gt;rptr_npa;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; npa |=3D (u64)accel_id &lt;&lt; AMDGPU_UALINK_GART_NP=
A_ADDR_GPUID_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -5914,7 +5915,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdg=
pu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; 1 - PMI1 Remote TLB S=
hootdown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * ReqAddr[5:0]&nbsp;&nbsp; =3D 6'h0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; npa =3D 0xFFFUL &lt;&lt; 40 | (u64)dst_accel_id &lt;&lt; 30;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; npa =3D 0xFFFULL &lt;&lt; 40 | (u64)dst_accel_id &lt;&lt; 30;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ualink_gart_map(adev, 1, npa, &amp;inter=
rupt-&gt;mm_node_doorbell, flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN9PR12MB5146B193E70BC8E8CC0EECE0F7A82BN9PR12MB5146namp_--
