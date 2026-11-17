Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC6606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S2OqTuBO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B7710F680;
	Tue, 17 Nov 2026 12:04:44 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FF910F680
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 12:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhVmrrolmqJsBLE7ngtxlB+oUSMMyDj2s3qgncLk+MaJlBrzs/tfp4Trl8agr7OWW1cLu+cylc+vNbjBlq8R1jNSpthOXj1Q0YsLlUpxSUgfWXUI+7Hs5imN5ySEkuLCCHzpts+jylPg5Em90MvTVIBjsBXJUtlH2toMSJKGCVxdqj9UnmpVo8BU9y+WTLShHQgCc/6FCuj1x5BIw+RRF/w45vrKfH1vLXyVETBUi+efm0kExvxa0P0VL/QwHGYJXV2gsw27TpTt8vj6Ij27ig5lC+4lRhfvxgIVV9oAhPXkH5sFlyL6AtgCvGwpclIAolsi5NPemriHCePKDJq2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9h6e8GTX5cJkT8kmBYmHMPgpEnvRGfKLKktN8AZ270=;
 b=j3tCDJkuFTtBDUzLMziCwr0y7oUrokDGFvqtye77z/m8cp54rWzlvZf1suX7ugEm3YuQdmp2Xt0e60OxfYmSx+vZThIyp8fCu7D9Fm7hv7jKxCZce+mPSMSLG6IxkoB3Vq3FU6G9znMtpLjSlWpObhIDqYx4pirEztjKpSkcJ6A14Xs+6yoF0thvDik7I36TWUlOhvxNzbgdjmFd5K1Vf8cmRIIOog6Y5eM1Og8YoXy1YQjPpoUq8jLOzUOSl8JlX3J362hellkyv1znIBxGWPHw6y1MeWSLwwa65Bv8nntX3LKfEcMZrjNM4jkHU8LRbXXc32JHHe8/tNpeiBxiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9h6e8GTX5cJkT8kmBYmHMPgpEnvRGfKLKktN8AZ270=;
 b=S2OqTuBOY/w1+n0nnc++PFDXulp//IjZUB2oWj36VsTGIVvl4711IsJ2Z9lXNjRy0JcmEC84/s5/7KYkpEts/JP7KfXkdq5pJGXZb/HInLDEHk3V3fMeoyQgqV5BSmShehOTt91OkI6MLMf6+dbvRgFUobQ2CQ1KHtQrPxepBVw=
Received: from CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 12:04:34 +0000
Received: from CH1PR12MB9598.namprd12.prod.outlook.com
 ([fe80::1cf8:469b:2c4:1dd]) by CH1PR12MB9598.namprd12.prod.outlook.com
 ([fe80::1cf8:469b:2c4:1dd%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 12:04:34 +0000
From: "Indic, Vladimir" <Vladimir.Indic@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhu, James" <James.Zhu@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
Thread-Topic: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
Thread-Index: AQHdddmH6qltx36kk0m/JPNRoS7WU7cxLzYAgAD8aok=
Date: Tue, 17 Nov 2026 12:04:33 +0000
Message-ID: <CH1PR12MB9598891F8CD8F48B636AE4049A7B2@CH1PR12MB9598.namprd12.prod.outlook.com>
References: <20261116144744.1904011-1-alexander.deucher@amd.com>
 <SN7PR12MB843595F0DF8CE5095E5A4DCA8C7C2@SN7PR12MB8435.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB843595F0DF8CE5095E5A4DCA8C7C2@SN7PR12MB8435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-17T12:04:33.389Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PR12MB9598:EE_|IA1PR12MB9524:EE_
x-ms-office365-filtering-correlation-id: 9630a76c-fa43-47cd-af17-08df44a2f1aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|13003099007|8096899003|11063799006|4143699003|56012099006|261021121427099003|10067099003|261021123027099003|261009223027099003|261102123227099003|38070700021;
x-microsoft-antispam-message-info: TrdsPn8XWyUGCHrcAvtSA5MqnBgykW/BwUAcdom1AFyDbNZt4NBs73AuSo+VNgXdXJSIBBhxSv6WJ+Z3qKNMgce636R1o16xBRUuQgiDD77CG3EjGoJt7Yjlbx6cBkV5BL5FJ8bLd1FyDhPX8Ued6GdzC7yIAQD5HbO4PY2PZwp9GcxeETbnIYwIBUnykzceM46HfPcv8de2UltOUwPhI9UWB/57NAQEb/jFGNx7I5B3dPNW1R32ou0HNOlO8y5WqEQpNlGawSkfKYgP8X3rHOr8oiP0t6NIXqM090xv19Vr+1x3h9LFGD7i1a0C4jpy6hpP57CTbj0AnRRHraGCAjjDjQih/npnyvtBmh5bqA3IwdSGKZIWEQeLN7FzBm7BMFKehndCyYjpmuGCAdYS71n3/NzuN7YEk47lpd4VThmFf9aqagndpQy54gkbytwY+yDGjuCZSaTpS53mpZqrIKI75VPFm8ZcB3/KvX/6dgPSzDeoQMmsnfygKT7CH9Tc8acxie/A7bRKh8sB98DIh+zBIhYsm41H0tmy8yqh+1g5MPgVNLPNpY91+XVLuqTbH/8J0X0qwVB3XEtFLm3WnoskMD4Lv/lP6hG7Y0Mm2y893zpN26CCZxwU5lVJ3ywmtw2JwO5M50q8yqrSkpnuT6jPd1FQo/VfohgGkSW4aYE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH1PR12MB9598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(13003099007)(8096899003)(11063799006)(4143699003)(56012099006)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261102123227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dw9fZG8knuJkYOfkQR+5xXcn7rE7PM125ZrVzVSB8JL/ZoijDGiYmLQtUICU?=
 =?us-ascii?Q?7BM1uhOIn9q1r1srTQmxZYVjR9h5+g0nHDZQX5v7STQoQD/VTvZ0VM6MIHPY?=
 =?us-ascii?Q?A7bftMGeUouhFvvHOQpIcPI9OxOlSa9IxyM1Q7BBJJJD6NEgjp+PemIgCrqi?=
 =?us-ascii?Q?IkhwPUdM+L3koEf5d35T3L7zLiwEP3ZBsYdSWrVITeoE7rANqgf2IX1wBvVg?=
 =?us-ascii?Q?8RIIyTKYt54yOx/Yx8iDUSkuMgOXBIKx++3WHhkzf8gtO5bs4ZR8WyzJG5XM?=
 =?us-ascii?Q?Q688egMyg/gEAsCV7kbE+XoJBNwMUDcDGBeCSw8569S7Gl36METHS1Me6CC6?=
 =?us-ascii?Q?98KzsIW6KWnf1UdnLP5/6tBbGvS1NaGOvX66fY0J3dFqLXkhRWG6ovLQFAdE?=
 =?us-ascii?Q?6DbqkInoWcPuhHoNaUWH3fOdhIc6KDlSrKpCtKUsV7Rr4x8gp4lkp8hVIys8?=
 =?us-ascii?Q?PeaKOsdRFBqjNqGpxMUqsbUaA3fvspzYpxgMNp/6lMIDz5clGM9oySPPKN+w?=
 =?us-ascii?Q?xOAf0A86+xZNVYjgjtKUswDnkkTmlQcWPNDyDB+NZCxUz/PDAOGg8dB/IHUG?=
 =?us-ascii?Q?UEpsbm/mcBVxP7xSwF/Uv12Wtba/yTo6wU3S4Xx/j2wG+EuJb0vVr927oGjW?=
 =?us-ascii?Q?J3O5XPC74f5OtmNyA4NdyFqcvMbffuCvA5tosyuZnpEcy8jnK6eUL/5aOnAv?=
 =?us-ascii?Q?91sCyFPmTgKJSbvyRqd+J9gczGR36iHZCVzKg7m2EdgOC1enFu+Rzt4/IELV?=
 =?us-ascii?Q?9LDtlsBB/inIzo4+j1+mjIfkU5IZvd5gTWzx5lTkdY9z4TsVm4XZgYlA1Xvz?=
 =?us-ascii?Q?oxqI7s2BGqyo+7d9WgwBmXIvO/U0FS8EkufTIbk3P07GvYRYU99968GnyloD?=
 =?us-ascii?Q?vOag70g6i8vEmRkdsgVOF/u1SwfpXBPXD0EU/QxaWEeisnvcMyQd097APETQ?=
 =?us-ascii?Q?kzhAhhMGnzHipGohxH5aSquv15cuXfDVaTXW9piC/W05KaHp625QcbLWt7mR?=
 =?us-ascii?Q?HI4lKG00oDM0q264P1u/omrlWvnLxNT69j6ghnnQtpkiag75cZ1Sp+W/bPZD?=
 =?us-ascii?Q?KNsJ5CLGjDr0A00WsDmgWqKEEaQaR3BVVd8lRNr+IqiNM6vN9xWRmSB+Qx6P?=
 =?us-ascii?Q?RJRWlJt/qf+J2TNuOGziB8apDlo9pBWHsrsp+UoRBkIHtJSjQzpz+Bu/eqRz?=
 =?us-ascii?Q?D+r44sfnBASvEruxJ3jCGtU6F+XHvs6u6rxy4zZzgP+xTG6NyzqwpkQqJ0F5?=
 =?us-ascii?Q?ADv5WU+fFvzUcFt2BKPiVqmD0LcMFEF/xBMZvo2Esrbk8Iiwn+2MVEra3wBS?=
 =?us-ascii?Q?eFJWM07v39py/XQ6p2kLWhbtKwysOIJZ/OiPS2HgGIODSxU8r4bfGy0dehTJ?=
 =?us-ascii?Q?DAS6aSI9CIO57NoC2fWcXNN9SUX9O2IUcvSH8PzpWuMHenMpeGm/XMFeMrWa?=
 =?us-ascii?Q?ZrhvsqPAFwAGOU8RGC/uOpDdJPOcdqpZIyAwcqr2iG61mmBD8gcI0X+uh/7u?=
 =?us-ascii?Q?JUcIkRlqXGO6qdM2LERDQU1y7Pp5URUEDVOzhcvJJo5bfthAIDO4IIN/W/Uu?=
 =?us-ascii?Q?k0a2VByry3ruOTj/8SLxQXtoFvFnXyDsu1MWbzcmDZYzkO2gTPa7i0z3PPfV?=
 =?us-ascii?Q?GZbfiDhXe1HHiU6XjIQFzQHlypdqOIeLF9VMXIrCvJUIii/zYG9vCuMzGU6V?=
 =?us-ascii?Q?lvQEmc4pBx1O39GTfs8LdTRTQ85EOdkTOuCTakKQ/kHErhoK?=
Content-Type: multipart/alternative;
 boundary="_000_CH1PR12MB9598891F8CD8F48B636AE4049A7B2CH1PR12MB9598namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9630a76c-fa43-47cd-af17-08df44a2f1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 12:04:33.8937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugxbKm0RraKhz4LEVwcQRSfGO3dJYRXiSNp3wduLbjSb+6ZVaodjYQCbBFpvQT6DSaGTkWPL+UFV2WdlxHRGMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_CH1PR12MB9598891F8CD8F48B636AE4049A7B2CH1PR12MB9598namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Alex,

Thanks for the patch. I have provided some comments offline.

I'm overall fine with the change, although would recommend we use KFD_GC_VE=
RSION(dev) >=3D IP_VERSION(12, 1, 0)).

Thanks,
Vladimir

Reviewed-by: Vladimir Indic <Vladimir.Indic@amd.com>
________________________________
From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Sent: Monday, November 16, 2026 10:00 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Zhu, James <James.Zhu@amd.com>; Indic, Vladimir <Vladimir.Indic@amd.com=
>; Yang, Philip <Philip.Yang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory

AMD General

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


________________________________
From: Alex Deucher <alexander.deucher@amd.com>
Sent: Monday, November 16, 2026 9:47 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, James <James.Zhu@a=
md.com>; Indic, Vladimir <Vladimir.Indic@amd.com>; Kasiviswanathan, Harish =
<Harish.Kasiviswanathan@amd.com>; Yang, Philip <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory

For non-MI parts, move TBA/TMA back to system memory.
Results in GPU resets in some apps after suspend.

v2: add additional IP versions

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6116
Fixes: fe5966d4fdcb ("drm/amdkfd: move TBA/TMA from system to device memory=
")
Cc: James Zhu <James.Zhu@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 546721b4d59ac..b1b641ddbcf68 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1554,7 +1554,12 @@ static int kfd_process_device_init_cwsr_dgpu(struct =
kfd_process_device *pdd)
         if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) =
|| !qpd->cwsr_base)
                 return 0;

-       if (KFD_GC_VERSION(dev) >=3D IP_VERSION(9, 4, 2) && !dev->adev->apu=
_prefer_gtt)
+       if ((KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
+            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
+            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 4) ||
+            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 5, 0) ||
+            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)) &&
+           !dev->adev->apu_prefer_gtt)
                 flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
         else
                 flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;
--
2.56.0


--_000_CH1PR12MB9598891F8CD8F48B636AE4049A7B2CH1PR12MB9598namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Alex,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for the patch. I have provided some comments offline.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif;">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0);">I'm overall fine with=
 the change, although would recommend we use
</span><span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">KFD_GC_VERSION=
(dev) &gt;=3D IP_VERSION(12, 1, 0)).&nbsp;</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Vladimir</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Vladimir Indic &lt;Vladimir.Indic@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kasiviswanathan, Hari=
sh &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
<b>Sent:</b> Monday, November 16, 2026 10:00 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; Indic, Vladimir &lt;Vladim=
ir.Indic@amd.com&gt;; Yang, Philip &lt;Philip.Yang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memo=
ry</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div>
<div style=3D"font-family:Calibri; text-align:left; color:rgb(0,0,255); mar=
gin-left:5pt; font-size:10pt">
AMD General</div>
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;al=
exander.deucher@amd.com&gt;<br>
<b>Sent:</b> Monday, November 16, 2026 9:47 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhu, James=
 &lt;James.Zhu@amd.com&gt;; Indic, Vladimir &lt;Vladimir.Indic@amd.com&gt;;=
 Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Yang, Phil=
ip &lt;Philip.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">For non-MI parts, move TBA/TMA back to system me=
mory.<br>
Results in GPU resets in some apps after suspend.<br>
<br>
v2: add additional IP versions<br>
<br>
Closes: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/work_items/6116=
">https://gitlab.freedesktop.org/drm/amd/-/work_items/6116</a><br>
Fixes: fe5966d4fdcb (&quot;drm/amdkfd: move TBA/TMA from system to device m=
emory&quot;)<br>
Cc: James Zhu &lt;James.Zhu@amd.com&gt;<br>
Cc: Vladimir Indic &lt;vladimir.indic@amd.com&gt;<br>
Cc: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
Cc: Philip Yang &lt;philip.yang@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-<br>
&nbsp;1 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 546721b4d59ac..b1b641ddbcf68 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1554,7 +1554,12 @@ static int kfd_process_device_init_cwsr_dgpu(struct =
kfd_process_device *pdd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;kfd-&gt;cwsr_=
enabled || !iosys_map_is_null(&amp;qpd-&gt;cwsr_map) || !qpd-&gt;cwsr_base)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSION(dev) &gt;=3D IP_VE=
RSION(9, 4, 2) &amp;&amp; !dev-&gt;adev-&gt;apu_prefer_gtt)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((KFD_GC_VERSION(dev) =3D=3D IP_VE=
RSION(9, 4, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_=
VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_=
VERSION(dev) =3D=3D IP_VERSION(9, 4, 4) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_=
VERSION(dev) =3D=3D IP_VERSION(9, 5, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_=
VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !dev-&gt;adev=
-&gt;apu_prefer_gtt)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;<br>
-- <br>
2.56.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH1PR12MB9598891F8CD8F48B636AE4049A7B2CH1PR12MB9598namp_--
