Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6410C54FD2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 08:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F9A10EE3C;
	Thu, 30 Jul 2026 08:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QWrqE+J+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D5710EE3C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 08:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQfwxAPQ4bmyLmjpx3FKVRLaZWTTuRNeE8vNF66/qb6DX/EL9hJEz/uLutMFOx/31LdIk+8Wh4cICiFAEe63W15bvYGaENHVVEzdRTZT7tPRb6jVyt7upAR1mTuCkYvdjFfkXeVwUx3AeecYBR2mHatndIoPjPH3CoPb9kncercxQLJ8jiMSHEpZ9EX95/mxA5vziuzW3tNv2oqz4DPtkPpvJZc8V/dJBhnFPznx4HngNmqj0tdNUR99YNZQI9Owq9MmpU7/LSpYh+VcMOCwY2sOSFoXDi0mLSFKscRACyZQffs1xM/aFqP4s2wHsten75+3Z1lw4+6/m+pRtE7ooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A38NqtrArEN/BsnMn3ltXj8JCNsZV93Uhv89APxGRJc=;
 b=QrpWnhQfp5MnFklD7aFOUBeoXR8nQHj9FFzzMDYjwJgtuncLBR67VlrV5I5Lx+ewv6ktkz+L7W9B9mYjfIdZmnG3sbTR2Gui1sQr3kgYcS4ti8oxAkOUTSpDm0+ridFWRASjOztPAXaUXbdR3J2roZOp1Kh4/tF1knd8Ks088PpKAmWzl0LNqE81JZnuoLYAxnLtrr+ONSvPnqcjPORhvgLpxGzC2FhQ8eDS9PP4mA0pwlzz4zgxUjrVoxLTfF9my9e+Ua/pG+mtevezbdV1ypA/pZakl7h5hB3UAezbpyWTBrzuV5kxwekSkiyJFXX65wGL+MpsSf4KJvgvDTHLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A38NqtrArEN/BsnMn3ltXj8JCNsZV93Uhv89APxGRJc=;
 b=QWrqE+J+cyhN+Ch3fYWO61nsdRaFGKDR+2AVNNGisBA3vbry/nwivpDrAAqhnYiPx4BZ3XZBbX+BHPFSqq4f3cuQcGO6wrFZ1Ty67eIfCrKtTQsnn1oGBFKCERX5fDrIkEENlgE/a2TNJTvm3pr9fxSDOcXs1KJ/a5lcXXjunPk=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by DS5PPFBABE93B01.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 08:39:56 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 08:39:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/ras: rename rascore directory to core
Thread-Topic: [PATCH 1/2] drm/amd/ras: rename rascore directory to core
Thread-Index: AQHdH/5iG8BVafNipUq2pAMi5R1IdLaFveNw
Date: Thu, 30 Jul 2026 08:39:55 +0000
Message-ID: <EAYPR12MB99915836B0C90B90AD06230C67FCC92@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260730083435.540592-1-YiPeng.Chai@amd.com>
In-Reply-To: <20260730083435.540592-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-30T08:39:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|DS5PPFBABE93B01:EE_
x-ms-office365-filtering-correlation-id: 0bc3f59f-4364-4d01-bcd6-08deee1621dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: UQkAZ0V4yTXic0V7CGJIUYE/9pamKhoGPWmctgNauIsYE8yFbTEIc6UW9K5ao2vRNS0dSsjqcsH5TRxqrscW/3q5s+rUAKSSkoGIRi+2qyZ8KkotRlSL+XGjoTpbm2jbWWtxUnNJiEfgoUqXDwU3a8R5LiA0u205wvPyFCTJfANhtxnFIceX+XDA1vKh0JblzCqwsL0wyUdLhXUVwf1ZeFkEp4TOY1XocTKJZCfTdxuwPt9r8TkWUG+ITv72oz0l8FjYiD4DOTCcZ1tV7NMDqZH1rs97UkhCgfRXaCgrN4eqLRPfhXGR+U9CPhyJ7Mi0MCeZlLpxc4mObhVYhlXV/I06h9H2RkIFg09DXYBaRbhKN57xRaBOV9+xHlJ3VtZzuJR73f9fC4O1E/4sbi+6tD9GqW1VPfsGt3fYy3fUU68MCeHGOnutexhlxmIQsv003O6bHVCvRaMDkIxvEI66j4rayooUOyEVAbHq2X8cYH4NWaL821YPNs2JvN0rGv1nsSelyxIwb/ZiToOCWQh+0kKdovlYbCH2SNPXfcjuxgVLP6Y7tlOw6D5XZsK7cAWcKK8AzeEHgjzuhML/XBaU+LfctuV6IMlotb2Ek12nuzyt9Rd650bc/F/rLhL29IVGHHDG+plVq2fcQciE/s4JunsoyQbMbjeDYER6kPfCvhw0qNsPzDI53+PzCk3/6NKnBVzSeUfCVBgAe6IcH+Xu74AWql5+JBTSunF+EWg0Q5k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R6DOZ4S3XUY8XT5VtQPtUrkdG0DNmT7W0/xjfrFUmjiCFsTuFX1xV4joIRKX?=
 =?us-ascii?Q?NxXZvPxVoL0KqSFEKuh5GpygU4cFkxwoA2kkYDRDBx9uK06uRGjUrDFnvpQo?=
 =?us-ascii?Q?O0UtqwTGHlg8MAj+y4agQDHX4HmNvJMnGa1HhCmSL/ezG1zKxWvt4QR/WrCa?=
 =?us-ascii?Q?YHA6QW13RGYWcKg04+tvB3hcVUiqPnuij0ecfQeo22U2iTjItl1yta+g9Ur3?=
 =?us-ascii?Q?rpV9lkCp4YGRT2JloSKWmbmmB9Ooo8Od6NMw8NhEoZ7u8zN1LHFEh/NxrCsi?=
 =?us-ascii?Q?VRtARIpYx1zFBmK/VJpKFs0NtaSKW5J090A4X8Kd57lCl/NI0PaZCST76Hz8?=
 =?us-ascii?Q?ynZXj+VdbUOS1+BFdnDIBVCJRfkV2z5DM+WvSlLpVY3wXwRW1IiCFq70bAl4?=
 =?us-ascii?Q?+vE3DQKDNvK3DqL+vobzyXcuQzqxavHvVQrH9br3U/TgPZNyDyQMn84a1zJS?=
 =?us-ascii?Q?JATG3SWkLqlz8nkKMleeFJOeKWwdN5mMzrSKoEplXkYKL4XoI7Y7fOdtifhd?=
 =?us-ascii?Q?XqgSy+trPf1K1FYPyOXGcMk0uaxMB1JP4XmhyUBb3B2Oi9bE9w2+W0pTueyM?=
 =?us-ascii?Q?EdoqOhGXEYEZp5Ms+KB7Z5VtT0KtaSi00ZeIa/RuRdFEudyuoBc0rbqwMi4s?=
 =?us-ascii?Q?eiFV/B0AZTfsyjJ9oT/WQ4F2M8kyJYDFeSVMWGEenc1nxhhKyrWEJVqUY1QP?=
 =?us-ascii?Q?sndGU11aj5YgohpHbxrTFqgXijyrE9PeUwgujIHFQAX+ZoEIkv9F2om1WJ6n?=
 =?us-ascii?Q?XrJhHjH4gKpOlp1EbjDn8r6Zx+oeYXd92LjTdnIEssQdn2EyqGb/M2YZr0Kk?=
 =?us-ascii?Q?Fe978er0qUB4PiQySDBmW9GqPtrvPPxUTjxHriNTw2/x3C4zxOQfZ7KBEEKp?=
 =?us-ascii?Q?Y3NDGkK7SbHXE4F4OEJSrpPLd4fdP7RJZfk0liAB5YS/wUe+yh3DdVoXqcMv?=
 =?us-ascii?Q?L7yMHTWEBKF2078W6l6uQVGF5VapDkV+YS/vUdT5cLGWmE+82Ofcq8Knmbj7?=
 =?us-ascii?Q?Yb6rhmG5McTE6VD9y3vmsONa2FMwjdMPBgPQ8DkshZitPvwwLq6xpf9+JOjB?=
 =?us-ascii?Q?8gHJwa9QCh5PpnookMwJoAFkX1UUKjTB+3PngBrXn1/V5neERIUy4mMK3PxM?=
 =?us-ascii?Q?Cjq/nEXpa+1p4bDsGMOYOGCfL6FawspcOJIA6s9BooVmUH2VNdfgFe5v1/Io?=
 =?us-ascii?Q?Iwq4zqq106HVHIPc7CdKU5xvORui5AloF0/hmgx3fPOsBVM/9tbBLElFrYxj?=
 =?us-ascii?Q?jqyT3bjewz6dUAbPgPDOcbE9sjQpqawJmvWYRON8R7NKdu8wgkPOUNrTYroL?=
 =?us-ascii?Q?fpmhxRNCNYgr4NN+z6M57fmUsfbc0dxUZECF2+U1AQSd4wzIRMMs6mYMBd/L?=
 =?us-ascii?Q?yhC1Axgs652a2cSxpJxXqC32Uh8vbMGqgsIaKZJFRnXzPVDOul+YajjnMlOp?=
 =?us-ascii?Q?uuGENvYMT7vSpzNTgmOECjYqXROfMoexQEJbwtiIazmQ8+ETty4JznTEGOvr?=
 =?us-ascii?Q?z6qor2JiR4FbvSy96CATQrwUngI+Ejn7pKhlovLTyvlv+fFGRhGyoO7c+TBt?=
 =?us-ascii?Q?t8bPGgvnyjdfCGQ7Es82DbBPjHTp8ixiVd3q0Q4xmPVcibjHgIfZySPRaY+h?=
 =?us-ascii?Q?PGm8BqHy7a+jbCST/KbMzqd3gOp3q48CJZ5pw5wTMeYD9tZuofWmbLaUBjF6?=
 =?us-ascii?Q?xsvtDHc/Ms2czMVAHRcPRfxKeqNeBu0HhAuoytUCuZLg5oSR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc3f59f-4364-4d01-bcd6-08deee1621dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 08:39:55.7850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkQ7g59wQpozhmEpaoHtS2U6SLf0oLX0pUx3i2EkRIz4Mjwuy+ouIDsvO+cXnier6bexR66KHdBXOaC6E9D/cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
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

AMD General

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, July 30, 2026 4:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Ch=
ai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: rename rascore directory to core

Rename the RAS core directory from rascore to core and update build-path re=
ferences accordingly.

The change is mechanical and done with git rename semantics so history trac=
king is preserved.

No functional change intended.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/Makefile                            | 4 ++--
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/Makefile          | 2 +-
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras.h             | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_aca.c         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_aca.h         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_aca_v1_0.c    | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_aca_v1_0.h    | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cmd.c         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cmd.h         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_core.c        | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_core_status.h | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cper.c        | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cper.h        | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_eeprom.c      | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_eeprom.h      | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_eeprom_fw.c   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_eeprom_fw.h   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx.c         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx.h         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx_v9_0.c    | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx_v9_0.h    | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_log_ring.c    | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_log_ring.h    | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1.c         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1.h         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1_v13_0.c   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_mp1_v13_0.h   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio.c        | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio.h        | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio_v7_9.c   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_nbio_v7_9.h   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_process.c     | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_process.h     | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp.c         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp.h         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp_v13_0.c   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp_v13_0.h   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_ta_if.h       | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc.c         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc.h         | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc_v12_0.c   | 0
 drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc_v12_0.h   | 0
 42 files changed, 3 insertions(+), 3 deletions(-)  rename drivers/gpu/drm/=
amd/ras/{rascore =3D> core}/Makefile (95%)  rename drivers/gpu/drm/amd/ras/=
{rascore =3D> core}/ras.h (100%)  rename drivers/gpu/drm/amd/ras/{rascore =
=3D> core}/ras_aca.c (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> c=
ore}/ras_aca.h (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/r=
as_aca_v1_0.c (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ra=
s_aca_v1_0.h (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras=
_cmd.c (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cmd.h=
 (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_core.c (100=
%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_core_status.h (1=
00%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cper.c (100%) =
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_cper.h (100%)  rena=
me drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_eeprom.c (100%)  rename =
drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_eeprom.h (100%)  rename dri=
vers/gpu/drm/amd/ras/{rascore =3D> core}/ras_eeprom_fw.c (100%)  rename dri=
vers/gpu/drm/amd/ras/{rascore =3D> core}/ras_eeprom_fw.h (100%)  rename dri=
vers/gpu/drm/amd/ras/{rascore =3D> core}/ras_gfx.c (100%)  rename drivers/g=
pu/drm/amd/ras/{rascore =3D> core}/ras_gfx.h (100%)  rename drivers/gpu/drm=
/amd/ras/{rascore =3D> core}/ras_gfx_v9_0.c (100%)  rename drivers/gpu/drm/=
amd/ras/{rascore =3D> core}/ras_gfx_v9_0.h (100%)  rename drivers/gpu/drm/a=
md/ras/{rascore =3D> core}/ras_log_ring.c (100%)  rename drivers/gpu/drm/am=
d/ras/{rascore =3D> core}/ras_log_ring.h (100%)  rename drivers/gpu/drm/amd=
/ras/{rascore =3D> core}/ras_mp1.c (100%)  rename drivers/gpu/drm/amd/ras/{=
rascore =3D> core}/ras_mp1.h (100%)  rename drivers/gpu/drm/amd/ras/{rascor=
e =3D> core}/ras_mp1_v13_0.c (100%)  rename drivers/gpu/drm/amd/ras/{rascor=
e =3D> core}/ras_mp1_v13_0.h (100%)  rename drivers/gpu/drm/amd/ras/{rascor=
e =3D> core}/ras_nbio.c (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D=
> core}/ras_nbio.h (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> cor=
e}/ras_nbio_v7_9.c (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> cor=
e}/ras_nbio_v7_9.h (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> cor=
e}/ras_process.c (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}=
/ras_process.h (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/r=
as_psp.c (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp=
.h (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp_v13_0=
.c (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_psp_v13_0=
.h (100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_ta_if.h (=
100%)  rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc.c (100%) =
 rename drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc.h (100%)  renam=
e drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc_v12_0.c (100%)  renam=
e drivers/gpu/drm/amd/ras/{rascore =3D> core}/ras_umc_v12_0.h (100%)

diff --git a/drivers/gpu/drm/amd/ras/Makefile b/drivers/gpu/drm/amd/ras/Mak=
efile
index bbdaba811d34..803e250d1666 100644
--- a/drivers/gpu/drm/amd/ras/Makefile
+++ b/drivers/gpu/drm/amd/ras/Makefile
@@ -23,10 +23,10 @@ ifeq ($(AMD_GPU_RAS_MGR),)
        AMD_GPU_RAS_MGR :=3D ras_mgr
 endif

-subdir-ccflags-y +=3D -I$(AMD_GPU_RAS_FULL_PATH)/rascore
+subdir-ccflags-y +=3D -I$(AMD_GPU_RAS_FULL_PATH)/core
 subdir-ccflags-y +=3D -I$(AMD_GPU_RAS_FULL_PATH)/$(AMD_GPU_RAS_MGR)

-RAS_LIBS =3D $(AMD_GPU_RAS_MGR) rascore
+RAS_LIBS =3D $(AMD_GPU_RAS_MGR) core

 AMD_RAS =3D $(addsuffix /Makefile, $(addprefix $(AMD_GPU_RAS_FULL_PATH)/,$=
(RAS_LIBS)))

diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/amd=
/ras/core/Makefile
similarity index 95%
rename from drivers/gpu/drm/amd/ras/rascore/Makefile
rename to drivers/gpu/drm/amd/ras/core/Makefile
index 06b265ec1cde..454f83f62930 100644
--- a/drivers/gpu/drm/amd/ras/rascore/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -40,6 +40,6 @@ RAS_CORE_FILES =3D ras_core.o \
                        ras_eeprom_fw.o


-RAS_CORE =3D $(addprefix $(AMD_GPU_RAS_PATH)/rascore/,$(RAS_CORE_FILES))
+RAS_CORE =3D $(addprefix $(AMD_GPU_RAS_PATH)/core/,$(RAS_CORE_FILES))

 AMD_GPU_RAS_FILES +=3D $(RAS_CORE)
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/core/ras.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras.h
rename to drivers/gpu/drm/amd/ras/core/ras.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/am=
d/ras/core/ras_aca.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_aca.c
rename to drivers/gpu/drm/amd/ras/core/ras_aca.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h b/drivers/gpu/drm/am=
d/ras/core/ras_aca.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_aca.h
rename to drivers/gpu/drm/amd/ras/core/ras_aca.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/d=
rm/amd/ras/core/ras_aca_v1_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_aca_v1_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h b/drivers/gpu/d=
rm/amd/ras/core/ras_aca_v1_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_aca_v1_0.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/am=
d/ras/core/ras_cmd.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
rename to drivers/gpu/drm/amd/ras/core/ras_cmd.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/am=
d/ras/core/ras_cmd.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
rename to drivers/gpu/drm/amd/ras/core/ras_cmd.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/a=
md/ras/core/ras_core.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_core.c
rename to drivers/gpu/drm/amd/ras/core/ras_core.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core_status.h b/drivers/gp=
u/drm/amd/ras/core/ras_core_status.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_core_status.h
rename to drivers/gpu/drm/amd/ras/core/ras_core_status.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c b/drivers/gpu/drm/a=
md/ras/core/ras_cper.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_cper.c
rename to drivers/gpu/drm/amd/ras/core/ras_cper.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.h b/drivers/gpu/drm/a=
md/ras/core/ras_cper.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_cper.h
rename to drivers/gpu/drm/amd/ras/core/ras_cper.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c b/drivers/gpu/drm=
/amd/ras/core/ras_eeprom.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
rename to drivers/gpu/drm/amd/ras/core/ras_eeprom.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h b/drivers/gpu/drm=
/amd/ras/core/ras_eeprom.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h
rename to drivers/gpu/drm/amd/ras/core/ras_eeprom.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/=
drm/amd/ras/core/ras_eeprom_fw.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
rename to drivers/gpu/drm/amd/ras/core/ras_eeprom_fw.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/=
drm/amd/ras/core/ras_eeprom_fw.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
rename to drivers/gpu/drm/amd/ras/core/ras_eeprom_fw.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx.c b/drivers/gpu/drm/am=
d/ras/core/ras_gfx.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_gfx.c
rename to drivers/gpu/drm/amd/ras/core/ras_gfx.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx.h b/drivers/gpu/drm/am=
d/ras/core/ras_gfx.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_gfx.h
rename to drivers/gpu/drm/amd/ras/core/ras_gfx.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c b/drivers/gpu/d=
rm/amd/ras/core/ras_gfx_v9_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_gfx_v9_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h b/drivers/gpu/d=
rm/amd/ras/core/ras_gfx_v9_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_gfx_v9_0.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c b/drivers/gpu/d=
rm/amd/ras/core/ras_log_ring.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
rename to drivers/gpu/drm/amd/ras/core/ras_log_ring.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h b/drivers/gpu/d=
rm/amd/ras/core/ras_log_ring.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
rename to drivers/gpu/drm/amd/ras/core/ras_log_ring.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c b/drivers/gpu/drm/am=
d/ras/core/ras_mp1.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
rename to drivers/gpu/drm/amd/ras/core/ras_mp1.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h b/drivers/gpu/drm/am=
d/ras/core/ras_mp1.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
rename to drivers/gpu/drm/amd/ras/core/ras_mp1.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c b/drivers/gpu/=
drm/amd/ras/core/ras_mp1_v13_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h b/drivers/gpu/=
drm/amd/ras/core/ras_mp1_v13_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c b/drivers/gpu/drm/a=
md/ras/core/ras_nbio.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
rename to drivers/gpu/drm/amd/ras/core/ras_nbio.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.h b/drivers/gpu/drm/a=
md/ras/core/ras_nbio.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_nbio.h
rename to drivers/gpu/drm/amd/ras/core/ras_nbio.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c b/drivers/gpu/=
drm/amd/ras/core/ras_nbio_v7_9.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c
rename to drivers/gpu/drm/amd/ras/core/ras_nbio_v7_9.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h b/drivers/gpu/=
drm/amd/ras/core/ras_nbio_v7_9.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h
rename to drivers/gpu/drm/amd/ras/core/ras_nbio_v7_9.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/dr=
m/amd/ras/core/ras_process.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_process.c
rename to drivers/gpu/drm/amd/ras/core/ras_process.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.h b/drivers/gpu/dr=
m/amd/ras/core/ras_process.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_process.h
rename to drivers/gpu/drm/amd/ras/core/ras_process.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/am=
d/ras/core/ras_psp.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_psp.c
rename to drivers/gpu/drm/amd/ras/core/ras_psp.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.h b/drivers/gpu/drm/am=
d/ras/core/ras_psp.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_psp.h
rename to drivers/gpu/drm/amd/ras/core/ras_psp.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.c b/drivers/gpu/=
drm/amd/ras/core/ras_psp_v13_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.h b/drivers/gpu/=
drm/amd/ras/core/ras_psp_v13_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h b/drivers/gpu/drm/=
amd/ras/core/ras_ta_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
rename to drivers/gpu/drm/amd/ras/core/ras_ta_if.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/am=
d/ras/core/ras_umc.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_umc.c
rename to drivers/gpu/drm/amd/ras/core/ras_umc.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/am=
d/ras/core/ras_umc.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_umc.h
rename to drivers/gpu/drm/amd/ras/core/ras_umc.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/=
drm/amd/ras/core/ras_umc_v12_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h b/drivers/gpu/=
drm/amd/ras/core/ras_umc_v12_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
--
2.43.0

