Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E916E606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iw7qfHc/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBE310E6BE;
	Wed, 28 Oct 2026 17:41:32 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED69310E6BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 17:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXpgS+CGGtmGXQdQYjb5YsnlHLCtLrJ/eCIy3cQpI5MV1uuCr6xsjzmIx+4hqt4iNwM/+fcVN1Pbe0qk1uu6tGP4Qk2ById3kNsmjxZjegszUTk0dEb46Vf02MK0Pd4SP9AgvNt8tyMvKN4pEyIW5yXVmjvv5XZ6tadF91zs0RkBJ+q8vAheCKZryLwb6ZLlQOZjF9LZ6ImyP0oztzDhIf3J9Ss6ruRU5Cjl2r7TS+mMnM9IxEL1z7ae3cpf4p/rxMpVpsPPAY0OZlwKobimJgrhV8oGhEMkjDNpkNRaVmuGgBAPcgtUVQ9vrGqylfkRrZVox9eEc//vMuF5i6qYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+nUat5p+tBxMSEm2HhsBD/7AOZlpOzKtPxQjLjXk1U=;
 b=ChDJOm2AKhcaZwBqVVI7lueHHKAqzqUWGo+WL7QdnLrKzfHYeemdEPe1kAhJOpYjPBtBOSzw0oLx35/sXdKM3eqkGnprJ3eDeh1F8zMAoICQEgY6puyDGWGBD+ELZM72LmASji/qgQEuoS3Q1FhS8V2H8/WDVUnTxpJc1G+DPuiXpgGUzYccVfwMQUBvViPwNNS5KUIjMW327Ni856MhAAy/io1bjmz+7gVV4WUdvlkGKGfv5RQxp2bECKtrP9MBskBD46Tg3W4N4U7zpHXlb9Cg0PSgyRlOz1XVshM66t4np4p6NOd8fr1vVI4U3P/gqKbztWoL46iI6XNRUb7gnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+nUat5p+tBxMSEm2HhsBD/7AOZlpOzKtPxQjLjXk1U=;
 b=iw7qfHc/SlenIOSwk5+RDcr/9Fe8vTXb4QgTz7mflEuqiIY07eD8ECv3RhnaSru2dBuhScNWbJDVIqBD9CrsLp5XJSri1Qh1IoZcp9r8yKqIyeqAZPOU7Kav/TM4udcQOzJl39KYPMSKD3hwqF/SjVlUtkWc7dZmBrhTpixO954=
Received: from CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10)
 by LV2PR12MB733495.namprd12.prod.outlook.com (2603:10b6:408:423::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:41:22 +0000
Received: from CH1PR12MB9598.namprd12.prod.outlook.com
 ([fe80::1cf8:469b:2c4:1dd]) by CH1PR12MB9598.namprd12.prod.outlook.com
 ([fe80::1cf8:469b:2c4:1dd%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 17:41:22 +0000
From: "Indic, Vladimir" <Vladimir.Indic@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Six, Lancelot" <Lancelot.Six@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Scope VOP3PX trap workaround to revision 0
Thread-Topic: [PATCH] drm/amdkfd: Scope VOP3PX trap workaround to revision 0
Thread-Index: AQHdYmbfrw9dXdZNREy7/AgSYMNnqLcTQkRK
Date: Wed, 28 Oct 2026 17:41:22 +0000
Message-ID: <CH1PR12MB9598F7D782297E89C405FB4F9A6F2@CH1PR12MB9598.namprd12.prod.outlook.com>
References: <20261022204858.4143484-1-jay.cornwall@amd.com>
In-Reply-To: <20261022204858.4143484-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-28T17:41:21.113Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PR12MB9598:EE_|LV2PR12MB733495:EE_
x-ms-office365-filtering-correlation-id: aae2affa-cf03-462d-766d-08df351aae76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|8096899003|22082099003|3023799007|261028144727099003|261026140227099003|56012099006|11063799006|10067099003|261009223027099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: R4rfUq23/+yoTZJc7cshWFRGdyEl5xuNgZKK3yQQdoDA53gorzHaWbkuu2/rsvPMhoD63MJdEhdPmV5ejYpH81vGH2dG1L/N3LgV8ht8VlXVEIz1iJsQTyHu0CSZeCEEHvmd/BLjtvmgz+yNzH4Gl33D1JKJxZHSES9P9HbuBG95UsUsXeIubGg5TvyfdA+vbHQ8yk3iNgp6ZldqTZtYhKjafxhkVhgmbvAciv6Oxpq/dFcQkoh5xbPa4gQHjyWFqLVpZjQGY+0bwH3PxGG+kzXeTbrNwy+fJOAxfeLM2X70/JFqcHNjoex0E3NLIMG3mSYiYtKpPXl62GuoIAOwqEUilus6YgWchVwGFVAPk4vTFHI+s03+EyunVZkjUBI8R7ETU1YWN1Jl2ufB17kr4+tEINDWB96rZiqd16cFyqtpmhJw+99cWHaWJlxKJzKsNDou4VEMZ2yvEMe1P8fRxhHW72TFHT/HkU2l7xj6srsn3CSKgA3OJqVVnHYDOOw13G1J0+W9mDOmgaLcoZ93lM9vDScjvqGeV2MilJuSSxRr3JtOqA2ZfMYVRy9n3N2F33DgiVaSOf8mO4KV0cg4zJdrppkNvAtaUYdBa7s6t8v+XQJYm5DsNhv6i0nqg4CsBsuzGlmPXVvLO4sHg9V0XhBK6opcje3izmllx8EjXpHWj6IV6uRdKdvvNuE7EUHxEIKhmTb9QoRsJjhG0zMZzt4lTmXQqQOsHNNv9Pz1yr0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH1PR12MB9598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(8096899003)(22082099003)(3023799007)(261028144727099003)(261026140227099003)(56012099006)(11063799006)(10067099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YcFQuwi5YJGNYsgoqjZIB+FwAfXjpWKe8uy9qWOZCTq4OPSvg3FxEomQwhei?=
 =?us-ascii?Q?3EMVpJWNzggc+f5dqQoU9oyaFW+6dQFT1ycEAQxmS9YICYPOs5iA0rYTLaXn?=
 =?us-ascii?Q?Y7w0/e1byRmZLz8lmjpxLrimuPpl2wzIYBZnmrJhR5P9VFL8Xb+SKLg04Yrk?=
 =?us-ascii?Q?fcE3wGobgkCpT1pn463FFRBPqMGlJKa4Y5U76I094jnQTwn7GGk8OKddzlpk?=
 =?us-ascii?Q?tJbdtxubd4uUuQJhe39lblBlcDHoVPrHxO8gwl9zi3zlnIOGfd7SuPMV9XK0?=
 =?us-ascii?Q?RtkaHSQJpmbiRHf7RIp2FYwJdWxADAMVKkqAxdqVmYbFQw5k0RBysnfWIEZg?=
 =?us-ascii?Q?l6lQLHBTujhIVzfoKDg23n9gw4iTwZmr5c35VHgMx1okCYm6xRXcL0ztDDWV?=
 =?us-ascii?Q?5ajxV9cVlFyY8pUzgvi6CBgzlr7c/+7Msnb4tJ3hDWElOLOAP3cqjLsUfwBZ?=
 =?us-ascii?Q?f7ml/J89Z/n/eV00IshpHV1V+X63Z6Dr06f2f9E+w9zuJqu2Z8gYy6rYp2nt?=
 =?us-ascii?Q?sKZvGmWcZAo2ZbHUD+o6Cdp5TdJ93d+Hup09ZOQqVtZOQwVVzEPMwkab1x1Y?=
 =?us-ascii?Q?eV4zqX9KTvrzWZavdvAax89d1nXygliASENoVo8E49crYV3DBYOMa0OJviAf?=
 =?us-ascii?Q?c08qh/wGCii73WaDIXG3Zs5eu5G+Y/0jZY05Zhn99fmTNuWo1iFJ7WDb3CSw?=
 =?us-ascii?Q?WXJI9RSh02+n4w5w5y8lH5eDRjRGab6To/hNpaRtV0UIqOq4vT7Zjgp6Rt/Z?=
 =?us-ascii?Q?eishM2g8gu8vTLL2xQlcS8P3NDTWjrTMhs9PpM5J4T5+5dPu/d8bKHQm9Aa4?=
 =?us-ascii?Q?jAg0+B/yYeeJrYGjQ8YZ4b739KX+VtjxX7dw4eCBrm5cl0hOh/Cu5JqrcyQf?=
 =?us-ascii?Q?1ARojvWZBSuhZI4O61bVRmus9t8SZHvwiWARV8UjpsqzDEzhXxoFFxg32F/c?=
 =?us-ascii?Q?JLEzDeHtUjORd2KvyL3yAq9bfIClh2OokRDdo4v1Q887qpVWKiT7VsmgKXLZ?=
 =?us-ascii?Q?ic+QOaRbpJ1t0wO43hdNX1ReKqFTDuv6ZjKRmLq4ww5mxPjHCfrMVbd7IK/R?=
 =?us-ascii?Q?l3AI1aChFQyVQZzXPGJYJXP0s1UvjwLTOU+8pV4QrSS2d09LGRxFvlhnEQs5?=
 =?us-ascii?Q?DonB2TR2HdhS+/QghTfHcBHBZKCH1jZHTYMnLmCrgflm/97RCdlsJcxIEnzb?=
 =?us-ascii?Q?61+lp3353INpxQzSKPJKcy9wLw4WIQoWR0/oLiyKDUBZN7MkyUAU7IjV/E1z?=
 =?us-ascii?Q?gdEoIGEdaurqfwIqlaeUbna/etUZsndCM8HADRyZEPI1ph8lwL7d5Y7FwVi2?=
 =?us-ascii?Q?76jUizfpbGOSP19IqLBXUckyBqTblhC1t/S07zJMxK4uRp0sLAUWhnoiRdRW?=
 =?us-ascii?Q?WfMdgfbwHYUPueR2Dwk5Ow5a0KiPJw9UrIrXc0lZeMVfEHc2prpRiZIGGLqE?=
 =?us-ascii?Q?i6Mv69ERURaq8VPVWSvvd9zOspah76E5zI2Sd3ZAx1sIhF4bO13mHvtIN6Wk?=
 =?us-ascii?Q?XmD6h9ABmTE6SacneRkvDc85tgsXmTxEORUG0nnZnwBays9aoXmHm8HBufFp?=
 =?us-ascii?Q?7LbaiPwhSLDvO2Oi2auWiNyr2MwJq2BtaF13WIGWmAlIFAgNeusruvKdG/Rk?=
 =?us-ascii?Q?Gc2gE17Y8h1N4KuhD4FPpWaJGGwp7ngzRBTvUa7cYHDKSgg7cSlwpgon+S+e?=
 =?us-ascii?Q?2WvNAsxFLjxMJgt9obE81gjf3Ub3mZG+zTITxi8kjHnMrYO0?=
Content-Type: multipart/alternative;
 boundary="_000_CH1PR12MB9598F7D782297E89C405FB4F9A6F2CH1PR12MB9598namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae2affa-cf03-462d-766d-08df351aae76
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 17:41:22.1864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YPPrCN5jOI6Q4cjqnaB3a8vqdK0weM97yXqt5S7E1hFqqBXxAL6Q0IsYrBMhpJE1ZmfDbWIOhXfoo0r9zZctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495
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

--_000_CH1PR12MB9598F7D782297E89C405FB4F9A6F2CH1PR12MB9598namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Jay,

Sorry for the delay. Overall LGTM, so approving.

One minor nit regarding the, but I believe this will never be hit.
(kfd->adev->rev_id & 0xF) =3D=3D 0 is inconsistent with the rest of the dri=
ver. gfx_v12_1.c - the exact same GC 12.1.0 IP block - uses plain adev->rev=
_id =3D=3D 0 in two places (microcode selection) to distinguish A0 from lat=
er steppings, no masking. If rev_id can ever have bits set  above the low n=
ibble for this chip, the masked check here could disagree with the unmasked=
 check elsewhere about what counts as "revision 0." Worth confirming with t=
he author whether the mask is intentional (and if so, why gfx_v12_1.c doesn=
't need it too), otherwise align  to =3D=3D 0 for consistency.

Regards,
Vladimir

Reviewed-by: Vladimir Indic <vladimir.indic@amd.com

________________________________
From: Cornwall, Jay <Jay.Cornwall@amd.com>
Sent: Thursday, October 22, 2026 10:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Six, Lancelot <Lancelot.Six@amd.c=
om>; Indic, Vladimir <Vladimir.Indic@amd.com>
Subject: [PATCH] drm/amdkfd: Scope VOP3PX trap workaround to revision 0

Split instruction fixup into two separate workarounds:
- Trap during VOP3PX: revision 0 only
- Trap during VALU/SET_VGPR_MSB: revision 0 and 1

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 695 +++++++++++++++++-
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  43 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  12 +-
 3 files changed, 729 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/d=
rm/amd/amdkfd/cwsr_trap_handler.h
index 5cf306de0d96..5d468460f532 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4600,7 +4600,7 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] =3D {
         0xbf9b0000, 0x00000000,
 };

-static const uint32_t cwsr_trap_gfx12_1_0_hex[] =3D {
+static const uint32_t cwsr_trap_gfx12_1_0_rev_0_hex[] =3D {
         0xbfa00001, 0xbfa003e2,
         0xb0804009, 0xb8f8f804,
         0xbefa007e, 0xbefe0081,
@@ -5301,3 +5301,696 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] =3D=
 {
         0xbf9f0000, 0xbf9f0000,
         0xbf9f0000, 0xbf9f0000,
 };
+
+static const uint32_t cwsr_trap_gfx12_1_0_rev_1_hex[] =3D {
+       0xbfa00001, 0xbfa003d0,
+       0xb0804009, 0xb8f8f804,
+       0xbefa007e, 0xbefe0081,
+       0xbeee0080, 0xbeef00c1,
+       0xee17406e, 0x00040000,
+       0x00000000, 0xbefe007a,
+       0x9178ff78, 0x00008c00,
+       0xb8fbf811, 0xbf0c877b,
+       0xbfa20002, 0x916dff6d,
+       0xf0000000, 0xbf0d857b,
+       0xbfa10006, 0x917bff7b,
+       0x00000480, 0xb98001d1,
+       0x00000000, 0xb9800291,
+       0x00000000, 0x8b6eff78,
+       0x00004000, 0xbfa10008,
+       0x8b6eff7b, 0x00000480,
+       0xbfa20018, 0x8b6ea07b,
+       0xbfa200e1, 0xbf830010,
+       0xb8fbf811, 0xbfa0fffb,
+       0x8b6eff7b, 0x00000bd0,
+       0xbfa20010, 0xb8eef812,
+       0x8b6f8f7b, 0xbfa10002,
+       0x8c6eff6e, 0x00000080,
+       0xb8eff813, 0x8b6e6e6f,
+       0xbfa20008, 0x8b6eff6d,
+       0xf0000000, 0xbfa20005,
+       0x8b6fff6f, 0x00000200,
+       0xbfa20002, 0x8b6ea07b,
+       0xbfa200cb, 0x9177ff77,
+       0x007fc000, 0xb8fa04a1,
+       0x847a967a, 0x8c777a77,
+       0xb8fa0421, 0x847a957a,
+       0x8c777a77, 0xb8fa3021,
+       0x847a8e7a, 0x8c777a77,
+       0xb980f821, 0x00000000,
+       0xbeef007b, 0xbefa4d82,
+       0xbf8a0000, 0x84fa887a,
+       0xbf0d987b, 0xbfa10002,
+       0x8c7bff7b, 0xfe000000,
+       0xf4601bbd, 0xf8000010,
+       0xbf8a0000, 0x846e976e,
+       0x9177ff77, 0x03800000,
+       0x8c776e77, 0x8b6eff6f,
+       0x00000480, 0xbfa1000c,
+       0xbf0d8e78, 0xbfa20002,
+       0xbf0d9877, 0xbfa20002,
+       0xb98001d1, 0x00000000,
+       0xbf0d8e78, 0xbfa20002,
+       0xbf0d9977, 0xbfa20002,
+       0xb9800291, 0x00000000,
+       0xf4603bbd, 0xf8000000,
+       0xbf8a0000, 0xf4603ebd,
+       0xf8000008, 0xbf8a0000,
+       0x8bee6e6e, 0xbfa10001,
+       0xbe80486e, 0x8b6eff6d,
+       0xf0000000, 0xbfa20009,
+       0xb8eef811, 0x8b6eff6e,
+       0x00000080, 0xbfa20007,
+       0x8c78ff78, 0x00004000,
+       0x80ec886c, 0x82ed806d,
+       0xbfa00002, 0x806c846c,
+       0x826d806d, 0x8b6dff6d,
+       0x01ffffff, 0xb8fbf811,
+       0xbf0d847b, 0xbfa20078,
+       0xf4003eb6, 0xf8000000,
+       0xbfc70000, 0xf4003bb6,
+       0xf8000008, 0x8b76ff7a,
+       0x80000000, 0xbfa20027,
+       0x9376ff7a, 0x00060019,
+       0x81f9a376, 0xbf0b8179,
+       0xbfa20068, 0x81f9ac76,
+       0xbf0b8179, 0xbfa20062,
+       0x81f9b776, 0xbf0b8179,
+       0xbfa2005f, 0x8b76ff7a,
+       0x000001ff, 0xbf06ff76,
+       0x000000fe, 0xbfa2005d,
+       0xbf06ff76, 0x000000ff,
+       0xbfa20057, 0xbf06ff76,
+       0x000000fa, 0xbfa20054,
+       0x81f9ff76, 0x000000e9,
+       0xbf0b8179, 0xbfa20050,
+       0x8b76ff7b, 0xffff0000,
+       0xbf06ff76, 0xbf860000,
+       0xbfa10051, 0x9376ff7b,
+       0x0002000e, 0x8b79ff7b,
+       0x00003f00, 0x85798679,
+       0x8c767976, 0xb9763b01,
+       0xbfa00049, 0x8b76ff7a,
+       0xfc000000, 0xbf06ff76,
+       0xd4000000, 0xbfa20013,
+       0xbf06ff76, 0xc8000000,
+       0xbfa20027, 0x8b76ff7a,
+       0xff000000, 0xbf06ff76,
+       0xcf000000, 0xbfa20039,
+       0x8b79ff7a, 0xffff0000,
+       0xbf06ff79, 0xcc350000,
+       0xbfa20037, 0xbf06ff79,
+       0xcc3a0000, 0xbfa20034,
+       0xbf06ff76, 0xcc000000,
+       0xbfa10031, 0x8b76ff7b,
+       0x000001ff, 0xbf06ff76,
+       0x000000ff, 0xbfa20029,
+       0xbf06ff76, 0x000000fa,
+       0xbfa20026, 0x81f6ff76,
+       0x000000e9, 0xbf0b8176,
+       0xbfa20022, 0x8b76ff7b,
+       0x0003fe00, 0xbf06ff76,
+       0x0001fe00, 0xbfa2001d,
+       0x8b76ff7b, 0x07fc0000,
+       0xbf06ff76, 0x03fc0000,
+       0xbfa20018, 0xbfa00014,
+       0x9376ff7a, 0x00040016,
+       0x81f68176, 0xbf0b8176,
+       0xbfa20012, 0x9376ff7a,
+       0x00050011, 0x81f68176,
+       0xbf0b8176, 0xbfa2000d,
+       0x8b76ff7a, 0x000001ff,
+       0xbf06ff76, 0x000000ff,
+       0xbfa20008, 0x8b76ff7b,
+       0x000001ff, 0xbf06ff76,
+       0x000000ff, 0xbfa20003,
+       0xbfc70000, 0xbefb006e,
+       0xbfa0ffad, 0xbfc70000,
+       0xbefb006f, 0xbfa0ffaa,
+       0xbfc70000, 0x857a9677,
+       0xb97a04a1, 0x857a9577,
+       0xb97a0421, 0x857a8e77,
+       0xb97a3021, 0x8bfe7e7e,
+       0x8bea6a6a, 0x85788978,
+       0xb9783244, 0xbe804a6c,
+       0xb8faf802, 0xbf0d987a,
+       0xbfa10001, 0xbfb00000,
+       0x8b6dff6d, 0x01ffffff,
+       0xbefa0080, 0xb97a0151,
+       0x9177ff77, 0x007fc000,
+       0xb8fa04a1, 0x847a967a,
+       0x8c777a77, 0xb8fa0421,
+       0x847a957a, 0x8c777a77,
+       0xb8fa3021, 0x847a8e7a,
+       0x8c777a77, 0xb980f821,
+       0x00000000, 0xbf0d847b,
+       0xbfa20078, 0xf4003eb6,
+       0xf8000000, 0xbfc70000,
+       0xf4003bb6, 0xf8000008,
+       0x8b76ff7a, 0x80000000,
+       0xbfa20027, 0x9376ff7a,
+       0x00060019, 0x81f9a376,
+       0xbf0b8179, 0xbfa20068,
+       0x81f9ac76, 0xbf0b8179,
+       0xbfa20062, 0x81f9b776,
+       0xbf0b8179, 0xbfa2005f,
+       0x8b76ff7a, 0x000001ff,
+       0xbf06ff76, 0x000000fe,
+       0xbfa2005d, 0xbf06ff76,
+       0x000000ff, 0xbfa20057,
+       0xbf06ff76, 0x000000fa,
+       0xbfa20054, 0x81f9ff76,
+       0x000000e9, 0xbf0b8179,
+       0xbfa20050, 0x8b76ff7b,
+       0xffff0000, 0xbf06ff76,
+       0xbf860000, 0xbfa10051,
+       0x9376ff7b, 0x0002000e,
+       0x8b79ff7b, 0x00003f00,
+       0x85798679, 0x8c767976,
+       0xb9763b01, 0xbfa00049,
+       0x8b76ff7a, 0xfc000000,
+       0xbf06ff76, 0xd4000000,
+       0xbfa20013, 0xbf06ff76,
+       0xc8000000, 0xbfa20027,
+       0x8b76ff7a, 0xff000000,
+       0xbf06ff76, 0xcf000000,
+       0xbfa20039, 0x8b79ff7a,
+       0xffff0000, 0xbf06ff79,
+       0xcc350000, 0xbfa20037,
+       0xbf06ff79, 0xcc3a0000,
+       0xbfa20034, 0xbf06ff76,
+       0xcc000000, 0xbfa10031,
+       0x8b76ff7b, 0x000001ff,
+       0xbf06ff76, 0x000000ff,
+       0xbfa20029, 0xbf06ff76,
+       0x000000fa, 0xbfa20026,
+       0x81f6ff76, 0x000000e9,
+       0xbf0b8176, 0xbfa20022,
+       0x8b76ff7b, 0x0003fe00,
+       0xbf06ff76, 0x0001fe00,
+       0xbfa2001d, 0x8b76ff7b,
+       0x07fc0000, 0xbf06ff76,
+       0x03fc0000, 0xbfa20018,
+       0xbfa00014, 0x9376ff7a,
+       0x00040016, 0x81f68176,
+       0xbf0b8176, 0xbfa20012,
+       0x9376ff7a, 0x00050011,
+       0x81f68176, 0xbf0b8176,
+       0xbfa2000d, 0x8b76ff7a,
+       0x000001ff, 0xbf06ff76,
+       0x000000ff, 0xbfa20008,
+       0x8b76ff7b, 0x000001ff,
+       0xbf06ff76, 0x000000ff,
+       0xbfa20003, 0xbfc70000,
+       0xbefb006e, 0xbfa0ffad,
+       0xbfc70000, 0xbefb006f,
+       0xbfa0ffaa, 0xbfc70000,
+       0xbeee007e, 0xbeef007f,
+       0xbefe0180, 0xbefe4d84,
+       0xbf8a0000, 0x8b7aff7f,
+       0x04000000, 0x847a857a,
+       0x8c6d7a6d, 0xb8eff822,
+       0xb980f822, 0x00000000,
+       0xb8fa2b01, 0x847a997a,
+       0x8c6d7a6d, 0xbefa0080,
+       0xb97a2b01, 0xbefa007e,
+       0x8b7bff7f, 0x01ffffff,
+       0xbefe00c1, 0xbeff00c1,
+       0xee0a407a, 0x000c0000,
+       0x00000000, 0x7e000280,
+       0xbefe007a, 0xbeff007b,
+       0xb8fb0742, 0x847b997b,
+       0xb8fa3b05, 0x807a817a,
+       0xbf0d997b, 0xbfa20002,
+       0x847a897a, 0xbfa00001,
+       0x847a8a7a, 0x8b7bff7f,
+       0x01ffffff, 0x807aff7a,
+       0x000001c0, 0x807a7e7a,
+       0x827b807b, 0xd7610000,
+       0x00010870, 0xd7610000,
+       0x00010a71, 0xd7610000,
+       0x00010c72, 0xd7610000,
+       0x00010e73, 0xd7610000,
+       0x00011074, 0xd7610000,
+       0x00011275, 0xd7610000,
+       0x00011476, 0xd7610000,
+       0x00011677, 0xd7610000,
+       0x00011a79, 0xd7610000,
+       0x00011c7e, 0xd7610000,
+       0x00011e7f, 0xbefe00ff,
+       0x00003fff, 0xbeff0080,
+       0xee0a407a, 0x000c0000,
+       0x00000000, 0xd760007a,
+       0x00011d00, 0xd760007b,
+       0x00011f00, 0xbefe007a,
+       0xbeff007b, 0xbef4007e,
+       0x8b75ff7f, 0x01ffffff,
+       0xbef1007d, 0xb8f30742,
+       0x84739973, 0xbefe00c1,
+       0x857d9973, 0x8b7d817d,
+       0xbf06817d, 0xbfa20002,
+       0xbeff0080, 0xbfa00002,
+       0xbeff00c1, 0xbfa0000a,
+       0xee0a4074, 0x008c0000,
+       0x00008000, 0xee0a4074,
+       0x010c0000, 0x00010000,
+       0xee0a4074, 0x018c0000,
+       0x00018000, 0xbfa00009,
+       0xee0a4074, 0x008c0000,
+       0x00010000, 0xee0a4074,
+       0x010c0000, 0x00020000,
+       0xee0a4074, 0x018c0000,
+       0x00030000, 0xb8f03b05,
+       0x80708170, 0xbf0d9973,
+       0xbfa20002, 0x84708970,
+       0xbfa00001, 0x84708a70,
+       0x8070ff70, 0x00000200,
+       0x7e000280, 0x7e020280,
+       0x7e040280, 0xbefd0080,
+       0xd7610002, 0x0000fa71,
+       0x807d817d, 0xb8faf802,
+       0xbf0c8b7a, 0xbfa20003,
+       0xbe804fc2, 0xbf94fffe,
+       0xbfa10001, 0xbe804ec4,
+       0xbf94fffc, 0xbefa4c88,
+       0xbfc70000, 0xbf0c807a,
+       0xbfa20006, 0x9371ff7a,
+       0x00070004, 0x937aff7a,
+       0x00070010, 0xbf06717a,
+       0xbfa2fff6, 0xb8faf804,
+       0x8b7aff7a, 0x0001000c,
+       0x9178ff78, 0x0001000c,
+       0x8c787a78, 0xd7610002,
+       0x0000fa6c, 0x807d817d,
+       0x8b7aff6d, 0x01ffffff,
+       0xd7610002, 0x0000fa7a,
+       0x807d817d, 0xd7610002,
+       0x0000fa6e, 0x807d817d,
+       0xbefa0080, 0xd7610002,
+       0x0000fa7a, 0x807d817d,
+       0xd7610002, 0x0000fa78,
+       0x807d817d, 0xb8faf811,
+       0xd7610002, 0x0000fa7a,
+       0x807d817d, 0xd7610002,
+       0x0000fa6f, 0x807d817d,
+       0xb8f1f801, 0x937aff6d,
+       0x00060019, 0x847a8c7a,
+       0x8c717a71, 0xd7610002,
+       0x0000fa71, 0x807d817d,
+       0xb8f1f814, 0xd7610002,
+       0x0000fa71, 0x807d817d,
+       0xb8f1f815, 0xd7610002,
+       0x0000fa71, 0x807d817d,
+       0xb8f1f812, 0xd7610002,
+       0x0000fa71, 0x807d817d,
+       0xb8f1f813, 0xd7610002,
+       0x0000fa71, 0x807d817d,
+       0xb8faf802, 0xd7610002,
+       0x0000fa7a, 0x807d817d,
+       0xbefa50c1, 0xbfc70000,
+       0xd7610002, 0x0000fa7a,
+       0x807d817d, 0xbefa4c88,
+       0xbfc70000, 0xd7610002,
+       0x0000fa7a, 0x807d817d,
+       0xb8faf81a, 0xd7610002,
+       0x0000fa7a, 0x807d817d,
+       0xbefe00c1, 0xbeff0080,
+       0x80767074, 0x82778075,
+       0xee0a4076, 0x010c0000,
+       0x00000000, 0xbefe00c1,
+       0x7e040280, 0xbefa5081,
+       0xbfc70000, 0xd7610002,
+       0x0001007a, 0xbefa5082,
+       0xbfc70000, 0xd7610002,
+       0x0001027a, 0xbefa5083,
+       0xbfc70000, 0xd7610002,
+       0x0001047a, 0xbefa5084,
+       0xbfc70000, 0xd7610002,
+       0x0001067a, 0xbefa5085,
+       0xbfc70000, 0xd7610002,
+       0x0001087a, 0xbefa5086,
+       0xbfc70000, 0xd7610002,
+       0x00010a7a, 0xbefa5087,
+       0xbfc70000, 0xd7610002,
+       0x00010c7a, 0xbefa5088,
+       0xbfc70000, 0xd7610002,
+       0x00010e7a, 0xbefa5089,
+       0xbfc70000, 0xd7610002,
+       0x0001107a, 0xbefa508a,
+       0xbfc70000, 0xd7610002,
+       0x0001127a, 0xbefa508b,
+       0xbfc70000, 0xd7610002,
+       0x0001147a, 0xbefa508c,
+       0xbfc70000, 0xd7610002,
+       0x0001167a, 0xbefa508d,
+       0xbfc70000, 0xd7610002,
+       0x0001187a, 0xbefa508e,
+       0xbfc70000, 0xd7610002,
+       0x00011a7a, 0xbefa508f,
+       0xbfc70000, 0xd7610002,
+       0x00011c7a, 0xbefa5090,
+       0xbfc70000, 0xd7610002,
+       0x00011e7a, 0xee0a4076,
+       0x010c0000, 0x00008000,
+       0xb8f03b05, 0x80708170,
+       0xbf0d9973, 0xbfa20002,
+       0x84708970, 0xbfa00001,
+       0x84708a70, 0xbef90080,
+       0xbefd0080, 0xbf800000,
+       0xbe804100, 0xbe824102,
+       0xbe844104, 0xbe864106,
+       0xbe884108, 0xbe8a410a,
+       0xbe8c410c, 0xbe8e410e,
+       0xd7610002, 0x0000f200,
+       0x80798179, 0xd7610002,
+       0x0000f201, 0x80798179,
+       0xd7610002, 0x0000f202,
+       0x80798179, 0xd7610002,
+       0x0000f203, 0x80798179,
+       0xd7610002, 0x0000f204,
+       0x80798179, 0xd7610002,
+       0x0000f205, 0x80798179,
+       0xd7610002, 0x0000f206,
+       0x80798179, 0xd7610002,
+       0x0000f207, 0x80798179,
+       0xd7610002, 0x0000f208,
+       0x80798179, 0xd7610002,
+       0x0000f209, 0x80798179,
+       0xd7610002, 0x0000f20a,
+       0x80798179, 0xd7610002,
+       0x0000f20b, 0x80798179,
+       0xd7610002, 0x0000f20c,
+       0x80798179, 0xd7610002,
+       0x0000f20d, 0x80798179,
+       0xd7610002, 0x0000f20e,
+       0x80798179, 0xd7610002,
+       0x0000f20f, 0x80798179,
+       0xbf06a079, 0xbfa10009,
+       0x80767074, 0x82778075,
+       0xee0a4076, 0x010c0000,
+       0x00000000, 0x8070ff70,
+       0x00000080, 0xbef90080,
+       0x7e040280, 0x807d907d,
+       0xbf0aff7d, 0x00000060,
+       0xbfa2ffb9, 0xbe804100,
+       0xbe824102, 0xbe844104,
+       0xbe864106, 0xbe884108,
+       0xbe8a410a, 0xd7610002,
+       0x0000f200, 0x80798179,
+       0xd7610002, 0x0000f201,
+       0x80798179, 0xd7610002,
+       0x0000f202, 0x80798179,
+       0xd7610002, 0x0000f203,
+       0x80798179, 0xd7610002,
+       0x0000f204, 0x80798179,
+       0xd7610002, 0x0000f205,
+       0x80798179, 0xd7610002,
+       0x0000f206, 0x80798179,
+       0xd7610002, 0x0000f207,
+       0x80798179, 0xd7610002,
+       0x0000f208, 0x80798179,
+       0xd7610002, 0x0000f209,
+       0x80798179, 0xd7610002,
+       0x0000f20a, 0x80798179,
+       0xd7610002, 0x0000f20b,
+       0x80798179, 0xbefe00ff,
+       0x0000ffff, 0x80767074,
+       0x82778075, 0xee0a4076,
+       0x010c0000, 0x00000000,
+       0xbefe00c1, 0x857d9973,
+       0x8b7d817d, 0xbf06817d,
+       0xbfa20002, 0xbeff0080,
+       0xbfa00001, 0xbeff00c1,
+       0xb8fb4306, 0x8b7bc17b,
+       0xbfa10042, 0x8b7aff6d,
+       0x80000000, 0xbfa1003f,
+       0x847b8a7b, 0xb8f03b05,
+       0x80708170, 0xbf0d9973,
+       0xbfa20002, 0x84708970,
+       0xbfa00001, 0x84708a70,
+       0x8070ff70, 0x00000200,
+       0x8070ff70, 0x00000200,
+       0xd71f0000, 0x000100c1,
+       0xd7200000, 0x000200c1,
+       0x16000084, 0x857d9973,
+       0x8b7d817d, 0xbf06817d,
+       0xbefd0080, 0xbfa20015,
+       0xbe8300ff, 0x00000080,
+       0xbf800000, 0xbf800000,
+       0xbf800000, 0xd8d80000,
+       0x01000000, 0xbf8a0000,
+       0x80767074, 0x82778075,
+       0xee0a4076, 0x008c0000,
+       0x00000000, 0x807d037d,
+       0x80700370, 0xd5250000,
+       0x0001ff00, 0x00000080,
+       0xbf0a7b7d, 0xbfa2fff1,
+       0xbfa00014, 0xbe8300ff,
+       0x00000100, 0xbf800000,
+       0xbf800000, 0xbf800000,
+       0xd8d80000, 0x01000000,
+       0xbf8a0000, 0x80767074,
+       0x82778075, 0xee0a4076,
+       0x008c0000, 0x00000000,
+       0x807d037d, 0x80700370,
+       0xd5250000, 0x0001ff00,
+       0x00000100, 0xbf0a7b7d,
+       0xbfa2fff1, 0xbefe00c1,
+       0x857d9973, 0x8b7d817d,
+       0xbf06817d, 0xbfa20004,
+       0xbef000ff, 0x00000200,
+       0xbeff0080, 0xbfa00003,
+       0xbef000ff, 0x00000400,
+       0xbeff00c1, 0xb8fb3b05,
+       0x807b817b, 0x847b827b,
+       0x857d9973, 0x8b7d817d,
+       0xbf06817d, 0xbfa2001b,
+       0xbefd0084, 0xbf0a7b7d,
+       0xbfa10032, 0x7e008700,
+       0x7e028701, 0x7e048702,
+       0x7e068703, 0x80767074,
+       0x82778075, 0xee0a4076,
+       0x000c0000, 0x00000000,
+       0xee0a4076, 0x008c0000,
+       0x00008000, 0xee0a4076,
+       0x010c0000, 0x00010000,
+       0xee0a4076, 0x018c0000,
+       0x00018000, 0x807d847d,
+       0x8070ff70, 0x00000200,
+       0xbf0a7b7d, 0xbfa2ffe9,
+       0xbfa0001a, 0xbefd0084,
+       0xbf0a7b7d, 0xbfa10017,
+       0x7e008700, 0x7e028701,
+       0x7e048702, 0x7e068703,
+       0x80767074, 0x82778075,
+       0xee0a4076, 0x000c0000,
+       0x00000000, 0xee0a4076,
+       0x008c0000, 0x00010000,
+       0xee0a4076, 0x010c0000,
+       0x00020000, 0xee0a4076,
+       0x018c0000, 0x00030000,
+       0x807d847d, 0x8070ff70,
+       0x00000400, 0xbf0a7b7d,
+       0xbfa2ffe9, 0xbfa00184,
+       0xbef4007e, 0x8b75ff7f,
+       0x01ffffff, 0xbef1007f,
+       0xb8f20742, 0x84729972,
+       0x8b6eff7f, 0x04000000,
+       0xbfa10044, 0xbefe00c1,
+       0x857d9972, 0x8b7d817d,
+       0xbf06817d, 0xbfa20002,
+       0xbeff0080, 0xbfa00001,
+       0xbeff00c1, 0xb8ef4306,
+       0x8b6fc16f, 0xbfa10039,
+       0x846f8a6f, 0xb8f83b05,
+       0x80788178, 0xbf0d9972,
+       0xbfa20002, 0x84788978,
+       0xbfa00001, 0x84788a78,
+       0x8078ff78, 0x00000200,
+       0x8078ff78, 0x00000200,
+       0x857d9972, 0x8b7d817d,
+       0xbf06817d, 0xbefd0080,
+       0xd71f0001, 0x000100c1,
+       0xd7200001, 0x000202c1,
+       0x30020282, 0xbfa20012,
+       0x80767874, 0x82778075,
+       0xee0a0076, 0x000c0000,
+       0x00000000, 0xbf8a0000,
+       0xd8340000, 0x00000001,
+       0xd5250001, 0x0001ff01,
+       0x00000080, 0x807dff7d,
+       0x00000080, 0x8078ff78,
+       0x00000080, 0xbf0a6f7d,
+       0xbfa2ffef, 0xbfa00011,
+       0x80767874, 0x82778075,
+       0xee0a0076, 0x000c0000,
+       0x00000000, 0xbf8a0000,
+       0xd8340000, 0x00000001,
+       0xd5250001, 0x0001ff01,
+       0x00000100, 0x807dff7d,
+       0x00000100, 0x8078ff78,
+       0x00000100, 0xbf0a6f7d,
+       0xbfa2ffef, 0xbef80080,
+       0xbefe00c1, 0x857d9972,
+       0x8b7d817d, 0xbf06817d,
+       0xbfa20002, 0xbeff0080,
+       0xbfa00001, 0xbeff00c1,
+       0xb8ef3b05, 0x806f816f,
+       0x846f826f, 0x857d9972,
+       0x8b7d817d, 0xbf06817d,
+       0xbfa2002c, 0xbeee0078,
+       0x8078ff78, 0x00000200,
+       0xbefd0084, 0x80767874,
+       0x82778075, 0xee0a0076,
+       0x000c0000, 0x00000000,
+       0xee0a0076, 0x000c0001,
+       0x00008000, 0xee0a0076,
+       0x000c0002, 0x00010000,
+       0xee0a0076, 0x000c0003,
+       0x00018000, 0xbf8a0000,
+       0x7e008500, 0x7e028501,
+       0x7e048502, 0x7e068503,
+       0x807d847d, 0x8078ff78,
+       0x00000200, 0xbf0a6f7d,
+       0xbfa2ffe8, 0x80766e74,
+       0x82778075, 0xee0a0076,
+       0x000c0000, 0x00000000,
+       0xee0a0076, 0x000c0001,
+       0x00008000, 0xee0a0076,
+       0x000c0002, 0x00010000,
+       0xee0a0076, 0x000c0003,
+       0x00018000, 0xbf8a0000,
+       0xbfa0002d, 0xbeee0078,
+       0x8078ff78, 0x00000400,
+       0xbefd0084, 0xbf0a6f7d,
+       0xbfa10018, 0x80767874,
+       0x82778075, 0xee0a0076,
+       0x000c0000, 0x00000000,
+       0xee0a0076, 0x000c0001,
+       0x00010000, 0xee0a0076,
+       0x000c0002, 0x00020000,
+       0xee0a0076, 0x000c0003,
+       0x00030000, 0xbf8a0000,
+       0x7e008500, 0x7e028501,
+       0x7e048502, 0x7e068503,
+       0x807d847d, 0x8078ff78,
+       0x00000400, 0xbf0a6f7d,
+       0xbfa2ffe8, 0x80766e74,
+       0x82778075, 0xee0a0076,
+       0x000c0000, 0x00000000,
+       0xee0a0076, 0x000c0001,
+       0x00010000, 0xee0a0076,
+       0x000c0002, 0x00020000,
+       0xee0a0076, 0x000c0003,
+       0x00030000, 0xbf8a0000,
+       0xb8f83b05, 0x80788178,
+       0xbf0d9972, 0xbfa20002,
+       0x84788978, 0xbfa00001,
+       0x84788a78, 0x8078ff78,
+       0x00000200, 0x80f8ff78,
+       0x00000060, 0x80767874,
+       0x82778075, 0xbefd00ff,
+       0x0000006c, 0xf460403b,
+       0xf8000000, 0xbf8a0000,
+       0x80fd847d, 0xbf800000,
+       0xbe804300, 0xbe824302,
+       0x80f6a076, 0x82f78077,
+       0xf460603b, 0xf8000000,
+       0xbf8a0000, 0x80fd887d,
+       0xbf800000, 0xbe804300,
+       0xbe824302, 0xbe844304,
+       0xbe864306, 0x80f6c076,
+       0x82f78077, 0xf460803b,
+       0xf8000000, 0xbf8a0000,
+       0x80fd907d, 0xbf800000,
+       0xbe804300, 0xbe824302,
+       0xbe844304, 0xbe864306,
+       0xbe884308, 0xbe8a430a,
+       0xbe8c430c, 0xbe8e430e,
+       0xbf06807d, 0xbfa1ffef,
+       0xb980f801, 0x00000000,
+       0xb8f83b05, 0x80788178,
+       0xbf0d9972, 0xbfa20002,
+       0x84788978, 0xbfa00001,
+       0x84788a78, 0x8078ff78,
+       0x00000200, 0x80767874,
+       0x82778075, 0xbeff0071,
+       0xf4601bfb, 0xf8000000,
+       0xf4601b3b, 0xf8000004,
+       0xf4601b7b, 0xf8000008,
+       0xf4601c3b, 0xf800000c,
+       0xf4601c7b, 0xf8000010,
+       0xf4601ebb, 0xf8000014,
+       0xf4601efb, 0xf8000018,
+       0xf4601e7b, 0xf800001c,
+       0xf4601cfb, 0xf8000020,
+       0xf4601bbb, 0xf8000024,
+       0xbf8a0000, 0xb96ef814,
+       0xf4601bbb, 0xf8000028,
+       0xbf8a0000, 0xb96ef815,
+       0xf4601bbb, 0xf800002c,
+       0xbf8a0000, 0xb96ef812,
+       0xf4601bbb, 0xf8000030,
+       0xbf8a0000, 0xb96ef813,
+       0x8b6eff7f, 0x04000000,
+       0xbfa10022, 0xf4601bbb,
+       0xf8000038, 0xbf8a0000,
+       0xbf0d806e, 0xbfa1001d,
+       0x856e906e, 0x8b6e6e6e,
+       0xbfa10003, 0xbe804ec1,
+       0x816ec16e, 0xbfa0fffb,
+       0xbef800ff, 0x00000080,
+       0xbefd0081, 0xf4601bbb,
+       0xf0000000, 0xbfc70000,
+       0x80788478, 0x937eff6e,
+       0x00070004, 0x847e907e,
+       0x8c7d7e7d, 0xbe80517d,
+       0x917dff7d, 0x007f0000,
+       0x856e906e, 0x8b6e6e6e,
+       0xbfa10003, 0xbe804e7d,
+       0x816ec16e, 0xbfa0fffb,
+       0x807d817d, 0xbf08907d,
+       0xbfa1ffec, 0xf4601bbb,
+       0xf800003c, 0xbfc70000,
+       0xbf0d806e, 0xbfa1000c,
+       0xbf0d9a7f, 0xbfa10002,
+       0xbf068180, 0xbe804fc4,
+       0xbf94fffc, 0xbfa10006,
+       0x856e906e, 0x8b6e6e6e,
+       0xbfa10003, 0xbe804ec3,
+       0x816ec16e, 0xbfa0fffb,
+       0xf4601bbb, 0xf8000040,
+       0xbfc70000, 0xb96ef81a,
+       0xbefd006f, 0xbefe0070,
+       0xbeff0071, 0xb979f822,
+       0xb97b2011, 0x857b867b,
+       0xb97b0191, 0x857b827b,
+       0xb97bba11, 0xb973f801,
+       0xb8ee3b05, 0x806e816e,
+       0xbf0d9972, 0xbfa20002,
+       0x846e896e, 0xbfa00001,
+       0x846e8a6e, 0x806eff6e,
+       0x000001c0, 0x806e746e,
+       0x826f8075, 0xf4605c37,
+       0xf8000010, 0xf4605d37,
+       0xf8000020, 0xf4601e77,
+       0xf8000034, 0xbf8a0000,
+       0x856e9677, 0xb96e04a1,
+       0x856e9577, 0xb96e0421,
+       0x856e8e77, 0xb96e3021,
+       0x8b6dff6d, 0x01ffffff,
+       0x8bfe7e7e, 0x8bea6a6a,
+       0xb97af804, 0xb8eef802,
+       0xbf0c8b6e, 0xbfa20003,
+       0xbe804fc2, 0xbf94fffe,
+       0xbfa10001, 0xbe804ec4,
+       0xbf94fffc, 0x857a897a,
+       0xb97a0244, 0xbe804a6c,
+       0xb8eef802, 0xbf0c8b6e,
+       0xbfa20003, 0xbe804fc2,
+       0xbf94fffe, 0xbfa10001,
+       0xbe804ec4, 0xbf94fffc,
+       0xbfb10000, 0xbf9f0000,
+       0xbf9f0000, 0xbf9f0000,
+       0xbf9f0000, 0xbf9f0000,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drive=
rs/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index b5af2c97a091..1e248af0e9e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -28,23 +28,26 @@
  */

 #define CHIP_GFX12 37
-#define CHIP_GC_12_0_3 38
-
-#define HAVE_XNACK (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)
-#define HAVE_57BIT_ADDRESS (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)
-#define HAVE_BANKED_VGPRS (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)
-#define NUM_NAMED_BARRIERS (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3 ? 0x10 : 0)
-#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)
-#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY =3D=3D CHIP_GC_1=
2_0_3)
+#define CHIP_GC_12_0_3_REV_0 38
+#define CHIP_GC_12_0_3_REV_1 39
+
+#define HAVE_XNACK (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)
+#define HAVE_57BIT_ADDRESS (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)
+#define HAVE_BANKED_VGPRS (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)
+#define NUM_NAMED_BARRIERS (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0 ? 0x10 :=
 0)
+#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)
+#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY >=3D CHIP_GC_12_=
0_3_REV_0)
 #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY =3D=3D CHIP_GFX12)
-#define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)
+#define HAVE_VOP3PX_FIXUP (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3_REV_0)
+#define HAVE_VGPR_MSB_FIXUP (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)
+#define HAVE_INSTRUCTION_FIXUP (HAVE_VOP3PX_FIXUP || HAVE_VGPR_MSB_FIXUP)

 #define SINGLE_STEP_MISSED_WORKAROUND 1 //workaround for lost TRAP_AFTER_I=
NST exception when SAVECTX raised
 #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY =3D=3D CHIP_GFX12)
-#define HAVE_HT_TRAP_ID_WA (ASIC_FAMILY >=3D CHIP_GFX12)
-#define WAVE32_ONLY (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)
-#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >=3D CHIP_GC_12_0_3)
-#define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)
+#define HAVE_HT_TRAP_ID_WA 1
+#define WAVE32_ONLY (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)
+#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)
+#define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)

 #if HAVE_XNACK && !WAVE32_ONLY
 # error
@@ -76,7 +79,7 @@ var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE           =3D 9
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE            =3D 8
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT           =3D 12

-#if ASIC_FAMILY < CHIP_GC_12_0_3
+#if ASIC_FAMILY < CHIP_GC_12_0_3_REV_0
 var SQ_WAVE_LDS_ALLOC_GRANULARITY               =3D 9
 #else
 var SQ_WAVE_LDS_ALLOC_GRANULARITY               =3D 10
@@ -707,7 +710,7 @@ L_SAVE_HWREG:
         write_hwreg_to_v2(s_save_tmp)
 #endif

-#if ASIC_FAMILY >=3D CHIP_GC_12_0_3
+#if ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0
         s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_SCHED_MODE)
         write_hwreg_to_v2(s_save_tmp)
 #endif
@@ -1281,7 +1284,7 @@ L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
 L_SKIP_CLUSTER_BARRIER_RESTORE:
 #endif

-#if ASIC_FAMILY >=3D CHIP_GC_12_0_3
+#if ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0
         s_load_b32      s_restore_tmp, [s_restore_addr_lo, s_restore_addr_=
hi], null scope:SCOPE_SYS offset:0x40
         s_wait_kmcnt    0
         s_setreg_b32    hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp
@@ -1393,7 +1396,7 @@ function get_sgpr_size_bytes
 end

 function get_hwreg_size_bytes
-#if ASIC_FAMILY >=3D CHIP_GC_12_0_3
+#if ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0
         return 512
 #else
         return 128
@@ -1550,6 +1553,7 @@ function fixup_instruction
         // Instruction is 1 DWORD otherwise

 L_FIXUP_ONE_DWORD:
+#if HAVE_VGPR_MSB_FIXUP
         // Check if TTMP15 contains the value for S_SET_VGPR_MSB instructi=
on
         s_and_b32       ttmp10, ttmp15, 0xffff0000                        =
      // Check encoding in upper 16 bits
         s_cmp_eq_u32    ttmp10, 0xbf860000                                =
      // Check if SOPP (9b'10_1111111) and S_SET_VGPR_MSB (7b'0000110)
@@ -1560,6 +1564,7 @@ L_FIXUP_ONE_DWORD:
         s_lshr_b32      ttmp13, ttmp13, 6                                 =
      // Shift SIMM[13:8] into 7:2, Src2, Src1, Src0
         s_or_b32        ttmp10, ttmp10, ttmp13                            =
      // Src2, Src1, Src0, Dst --> format in MODE register
         s_setreg_b32    hwreg(HW_REG_WAVE_MODE, 12, 8), ttmp10            =
      // Write value into MODE[19:12]
+#endif
         s_branch        L_FIXUP_DONE

 L_FIXUP_NOT_VOP12C:
@@ -1586,10 +1591,12 @@ L_FIXUP_NOT_VOP12C:
         // Not VOP1, VOP2, VOPC, VOP3, VOP3SD, VOPD, or VOPD3.
         // Check if we are in the middle of VOP3PX.
         s_and_b32       ttmp13, ttmp14, 0xffff0000                        =
      // Bits 31:16
+#if HAVE_VOP3PX_FIXUP
         s_cmp_eq_u32    ttmp13, 0xcc330000                                =
      // If 31:16 =3D 0xcc33, this is 8 bytes past VOP3PX
         s_cbranch_scc1  L_FIXUP_VOP3PX_MIDDLE
         s_cmp_eq_u32    ttmp13, 0xcc880000                                =
      // If 31:16 =3D 0xcc88, this is 8 bytes past VOP3PX
         s_cbranch_scc1  L_FIXUP_VOP3PX_MIDDLE
+#endif
         // Might be in VOP3P, but we must ensure we are not VOP3PX2
         s_cmp_eq_u32    ttmp13, 0xcc350000                                =
      // If 31:16 =3D 0xcc35, this is VOP3PX2
         s_cbranch_scc1  L_FIXUP_DONE                                      =
      // If VOP3PX2, no fixup needed
@@ -1651,10 +1658,12 @@ L_FIXUP_THREE_DWORD:
         s_mov_b32       ttmp15, ttmp3                                     =
      // Move possible S_SET_VGPR_MSB into ttmp15
         s_branch        L_FIXUP_ONE_DWORD                                 =
      // Go to common logic that checks if it is S_SET_VGPR_MSB

+#if HAVE_VOP3PX_FIXUP
 L_FIXUP_VOP3PX_MIDDLE:
         s_sub_co_u32    ttmp0, ttmp0, 8                                   =
      // Rewind PC 8 bytes to beginning of instruction
         s_sub_co_ci_u32 ttmp1, ttmp1, 0
         s_branch        L_FIXUP_TWO_DWORD                                 =
      // 2 DWORD inst (2nd half of a 4 DWORD inst)
+#endif

 L_FIXUP_DONE:
         s_wait_kmcnt    0                                                 =
      // Ensure load of ttmp2 and ttmp3 is done
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 0f96c9e3fa4d..edafbd9377b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -564,11 +564,17 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
                                              > KFD_CWSR_TMA_OFFSET);
                         kfd->cwsr_isa =3D cwsr_trap_gfx12_hex;
                         kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_hex)=
;
+               } else if (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(12, 1, 0) =
&&
+                       (kfd->adev->rev_id & 0xF) =3D=3D 0) {
+                       BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_0_hex)
+                                            > KFD_CWSR_TMA_OFFSET);
+                       kfd->cwsr_isa =3D cwsr_trap_gfx12_1_0_rev_0_hex;
+                       kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_1_0_r=
ev_0_hex);
                 } else {
-                       BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex)
+                       BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_1_hex)
                                              > KFD_CWSR_TMA_OFFSET);
-                       kfd->cwsr_isa =3D cwsr_trap_gfx12_1_0_hex;
-                       kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_1_0_h=
ex);
+                       kfd->cwsr_isa =3D cwsr_trap_gfx12_1_0_rev_1_hex;
+                       kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_1_0_r=
ev_1_hex);
                 }

                 kfd->cwsr_enabled =3D true;
--
2.43.0


--_000_CH1PR12MB9598F7D782297E89C405FB4F9A6F2CH1PR12MB9598namp_
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
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
Hi Jay,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
Sorry for the delay. Overall LGTM, so approving.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
One minor nit regarding the, but I believe this will never be hit.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
(kfd-&gt;adev-&gt;rev_id &amp; 0xF) =3D=3D 0 is inconsistent with the rest =
of the driver. gfx_v12_1.c &#8212; the exact same GC 12.1.0 IP block &#8212=
; uses plain adev-&gt;rev_id =3D=3D 0 in two places (microcode selection) t=
o distinguish A0 from later steppings, no masking. If rev_id can
 ever have bits set&nbsp; above the low nibble for this chip, the masked ch=
eck here could disagree with the unmasked check elsewhere about what counts=
 as &quot;revision&nbsp;0.&quot; Worth confirming with the author whether t=
he mask is intentional (and if so, why gfx_v12_1.c doesn't
 need it too), otherwise align&nbsp; to =3D=3D 0 for consistency.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
Regards,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
Vladimir</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
Reviewed-by: Vladimir Indic &lt;vladimir.indic@amd.com</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Cornwall, Jay &lt;Jay=
.Cornwall@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 22, 2026 10:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Cornwall, Jay &lt;Jay.Cornwall@amd.com&gt;; Six, Lancelot &lt;La=
ncelot.Six@amd.com&gt;; Indic, Vladimir &lt;Vladimir.Indic@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Scope VOP3PX trap workaround to revisio=
n 0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Split instruction fixup into two separate workarou=
nds:<br>
- Trap during VOP3PX: revision 0 only<br>
- Trap during VALU/SET_VGPR_MSB: revision 0 and 1<br>
<br>
Signed-off-by: Jay Cornwall &lt;jay.cornwall@amd.com&gt;<br>
Cc: Lancelot Six &lt;lancelot.six@amd.com&gt;<br>
Cc: Vladimir Indic &lt;vladimir.indic@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdkfd/cwsr_trap_handler.h&nbsp;&nbsp;&nbsp; | 695 ++=
+++++++++++++++-<br>
&nbsp;.../amd/amdkfd/cwsr_trap_handler_gfx12.asm&nbsp;&nbsp;&nbsp; |&nbsp; =
43 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 12 +-<br>
&nbsp;3 files changed, 729 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/d=
rm/amd/amdkfd/cwsr_trap_handler.h<br>
index 5cf306de0d96..5d468460f532 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
@@ -4600,7 +4600,7 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] =3D {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9b0000, 0x00000000,<br=
>
&nbsp;};<br>
&nbsp;<br>
-static const uint32_t cwsr_trap_gfx12_1_0_hex[] =3D {<br>
+static const uint32_t cwsr_trap_gfx12_1_0_rev_0_hex[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0xbfa003e2,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb0804009, 0xb8f8f804,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefa007e, 0xbefe0081,<br=
>
@@ -5301,3 +5301,696 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br=
>
&nbsp;};<br>
+<br>
+static const uint32_t cwsr_trap_gfx12_1_0_rev_1_hex[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0xbfa003d0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb0804009, 0xb8f8f804,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefa007e, 0xbefe0081,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeee0080, 0xbeef00c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee17406e, 0x00040000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xbefe007a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9178ff78, 0x00008c00,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fbf811, 0xbf0c877b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x916dff6d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf0000000, 0xbf0d857b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10006, 0x917bff7b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000480, 0xb98001d1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xb9800291,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0x8b6eff78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00004000, 0xbfa10008,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7b, 0x00000480,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20018, 0x8b6ea07b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa200e1, 0xbf830010,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fbf811, 0xbfa0fffb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7b, 0x00000bd0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20010, 0xb8eef812,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6f8f7b, 0xbfa10002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c6eff6e, 0x00000080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8eff813, 0x8b6e6e6f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20008, 0x8b6eff6d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf0000000, 0xbfa20005,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6fff6f, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x8b6ea07b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa200cb, 0x9177ff77,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x007fc000, 0xb8fa04a1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x847a967a, 0x8c777a77,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fa0421, 0x847a957a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c777a77, 0xb8fa3021,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x847a8e7a, 0x8c777a77,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb980f821, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeef007b, 0xbefa4d82,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x84fa887a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d987b, 0xbfa10002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c7bff7b, 0xfe000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbd, 0xf8000010,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x846e976e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9177ff77, 0x03800000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c776e77, 0x8b6eff6f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000480, 0xbfa1000c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d8e78, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9877, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb98001d1, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d8e78, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9977, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb9800291, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4603bbd, 0xf8000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xf4603ebd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000008, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8bee6e6e, 0xbfa10001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe80486e, 0x8b6eff6d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf0000000, 0xbfa20009,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8eef811, 0x8b6eff6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000080, 0xbfa20007,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c78ff78, 0x00004000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80ec886c, 0x82ed806d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00002, 0x806c846c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x826d806d, 0x8b6dff6d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01ffffff, 0xb8fbf811,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d847b, 0xbfa20078,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4003eb6, 0xf8000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xf4003bb6,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000008, 0x8b76ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000, 0xbfa20027,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9376ff7a, 0x00060019,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x81f9a376, 0xbf0b8179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20068, 0x81f9ac76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0b8179, 0xbfa20062,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x81f9b776, 0xbf0b8179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2005f, 0x8b76ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001ff, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000fe, 0xbfa2005d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x000000ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20057, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000fa, 0xbfa20054,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x81f9ff76, 0x000000e9,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0b8179, 0xbfa20050,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7b, 0xffff0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0xbf860000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10051, 0x9376ff7b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0002000e, 0x8b79ff7b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00003f00, 0x85798679,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c767976, 0xb9763b01,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00049, 0x8b76ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xfc000000, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd4000000, 0xbfa20013,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0xc8000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20027, 0x8b76ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xff000000, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xcf000000, 0xbfa20039,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b79ff7a, 0xffff0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff79, 0xcc350000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20037, 0xbf06ff79,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xcc3a0000, 0xbfa20034,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0xcc000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10031, 0x8b76ff7b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001ff, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000ff, 0xbfa20029,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x000000fa,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20026, 0x81f6ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000e9, 0xbf0b8176,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20022, 0x8b76ff7b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0003fe00, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001fe00, 0xbfa2001d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7b, 0x07fc0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x03fc0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20018, 0xbfa00014,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9376ff7a, 0x00040016,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x81f68176, 0xbf0b8176,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20012, 0x9376ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00050011, 0x81f68176,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0b8176, 0xbfa2000d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7a, 0x000001ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x000000ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20008, 0x8b76ff7b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001ff, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000ff, 0xbfa20003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xbefb006e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0ffad, 0xbfc70000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefb006f, 0xbfa0ffaa,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0x857a9677,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97a04a1, 0x857a9577,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97a0421, 0x857a8e77,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97a3021, 0x8bfe7e7e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8bea6a6a, 0x85788978,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb9783244, 0xbe804a6c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8faf802, 0xbf0d987a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10001, 0xbfb00000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6dff6d, 0x01ffffff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefa0080, 0xb97a0151,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9177ff77, 0x007fc000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fa04a1, 0x847a967a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c777a77, 0xb8fa0421,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x847a957a, 0x8c777a77,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fa3021, 0x847a8e7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c777a77, 0xb980f821,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xbf0d847b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20078, 0xf4003eb6,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000000, 0xbfc70000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4003bb6, 0xf8000008,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7a, 0x80000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20027, 0x9376ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00060019, 0x81f9a376,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0b8179, 0xbfa20068,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x81f9ac76, 0xbf0b8179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20062, 0x81f9b776,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0b8179, 0xbfa2005f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7a, 0x000001ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x000000fe,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2005d, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000ff, 0xbfa20057,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x000000fa,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20054, 0x81f9ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000e9, 0xbf0b8179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20050, 0x8b76ff7b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffff0000, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf860000, 0xbfa10051,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9376ff7b, 0x0002000e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b79ff7b, 0x00003f00,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x85798679, 0x8c767976,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb9763b01, 0xbfa00049,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7a, 0xfc000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0xd4000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20013, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc8000000, 0xbfa20027,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7a, 0xff000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0xcf000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20039, 0x8b79ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffff0000, 0xbf06ff79,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xcc350000, 0xbfa20037,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff79, 0xcc3a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20034, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xcc000000, 0xbfa10031,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7b, 0x000001ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x000000ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20029, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000fa, 0xbfa20026,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x81f6ff76, 0x000000e9,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0b8176, 0xbfa20022,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7b, 0x0003fe00,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x0001fe00,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2001d, 0x8b76ff7b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x07fc0000, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03fc0000, 0xbfa20018,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00014, 0x9376ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00040016, 0x81f68176,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0b8176, 0xbfa20012,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9376ff7a, 0x00050011,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x81f68176, 0xbf0b8176,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2000d, 0x8b76ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001ff, 0xbf06ff76,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000ff, 0xbfa20008,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b76ff7b, 0x000001ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06ff76, 0x000000ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20003, 0xbfc70000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefb006e, 0xbfa0ffad,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xbefb006f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0ffaa, 0xbfc70000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeee007e, 0xbeef007f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe0180, 0xbefe4d84,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x8b7aff7f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x04000000, 0x847a857a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c6d7a6d, 0xb8eff822,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb980f822, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fa2b01, 0x847a997a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c6d7a6d, 0xbefa0080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97a2b01, 0xbefa007e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7bff7f, 0x01ffffff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe00c1, 0xbeff00c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a407a, 0x000c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0x7e000280,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe007a, 0xbeff007b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fb0742, 0x847b997b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fa3b05, 0x807a817a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d997b, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x847a897a, 0xbfa00001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x847a8a7a, 0x8b7bff7f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01ffffff, 0x807aff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001c0, 0x807a7e7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x827b807b, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010870, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010a71, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010c72, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010e73, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011074, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011275, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011476, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011677, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011a79, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011c7e, 0xd7610000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011e7f, 0xbefe00ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00003fff, 0xbeff0080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a407a, 0x000c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xd760007a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011d00, 0xd760007b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011f00, 0xbefe007a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff007b, 0xbef4007e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b75ff7f, 0x01ffffff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef1007d, 0xb8f30742,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84739973, 0xbefe00c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857d9973, 0x8b7d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06817d, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0080, 0xbfa00002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff00c1, 0xbfa0000a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4074, 0x008c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00008000, 0xee0a4074,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x010c0000, 0x00010000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4074, 0x018c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00018000, 0xbfa00009,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4074, 0x008c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xee0a4074,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x010c0000, 0x00020000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4074, 0x018c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00030000, 0xb8f03b05,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80708170, 0xbf0d9973,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x84708970,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x84708a70,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8070ff70, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e000280, 0x7e020280,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e040280, 0xbefd0080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000fa71,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d817d, 0xb8faf802,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0c8b7a, 0xbfa20003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804fc2, 0xbf94fffe,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10001, 0xbe804ec4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffc, 0xbefa4c88,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xbf0c807a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20006, 0x9371ff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00070004, 0x937aff7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00070010, 0xbf06717a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2fff6, 0xb8faf804,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7aff7a, 0x0001000c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9178ff78, 0x0001000c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c787a78, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa6c, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7aff6d, 0x01ffffff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000fa7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d817d, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa6e, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefa0080, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa7a, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000fa78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d817d, 0xb8faf811,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000fa7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d817d, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa6f, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f1f801, 0x937aff6d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00060019, 0x847a8c7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c717a71, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa71, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f1f814, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa71, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f1f815, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa71, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f1f812, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa71, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f1f813, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa71, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8faf802, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa7a, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefa50c1, 0xbfc70000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000fa7a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d817d, 0xbefa4c88,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa7a, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8faf81a, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000fa7a, 0x807d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe00c1, 0xbeff0080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80767074, 0x82778075,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x010c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xbefe00c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e040280, 0xbefa5081,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001007a, 0xbefa5082,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001027a, 0xbefa5083,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001047a, 0xbefa5084,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001067a, 0xbefa5085,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001087a, 0xbefa5086,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010a7a, 0xbefa5087,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010c7a, 0xbefa5088,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010e7a, 0xbefa5089,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001107a, 0xbefa508a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001127a, 0xbefa508b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001147a, 0xbefa508c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001167a, 0xbefa508d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001187a, 0xbefa508e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011a7a, 0xbefa508f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011c7a, 0xbefa5090,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00011e7a, 0xee0a4076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x010c0000, 0x00008000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f03b05, 0x80708170,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9973, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84708970, 0xbfa00001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84708a70, 0xbef90080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0080, 0xbf800000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804100, 0xbe824102,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe844104, 0xbe864106,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe884108, 0xbe8a410a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe8c410c, 0xbe8e410e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f201, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f202,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f203, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f204,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f205, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f206,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f207, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f208,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f209, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f20a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f20b, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f20c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f20d, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f20e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f20f, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06a079, 0xbfa10009,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80767074, 0x82778075,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x010c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0x8070ff70,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000080, 0xbef90080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e040280, 0x807d907d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0aff7d, 0x00000060,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffb9, 0xbe804100,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe824102, 0xbe844104,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe864106, 0xbe884108,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe8a410a, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f200, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f201,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f202, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f203,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f204, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f205,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f206, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f207,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f208, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f209,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xd7610002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000f20a, 0x80798179,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7610002, 0x0000f20b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80798179, 0xbefe00ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000ffff, 0x80767074,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a4076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x010c0000, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe00c1, 0x857d9973,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7d817d, 0xbf06817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0xbeff0080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0xbeff00c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fb4306, 0x8b7bc17b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10042, 0x8b7aff6d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000, 0xbfa1003f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x847b8a7b, 0xb8f03b05,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80708170, 0xbf0d9973,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x84708970,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x84708a70,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8070ff70, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8070ff70, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd71f0000, 0x000100c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7200000, 0x000200c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x16000084, 0x857d9973,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7d817d, 0xbf06817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0080, 0xbfa20015,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe8300ff, 0x00000080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf800000, 0xbf800000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf800000, 0xd8d80000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01000000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80767074, 0x82778075,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x008c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0x807d037d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80700370, 0xd5250000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001ff00, 0x00000080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a7b7d, 0xbfa2fff1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00014, 0xbe8300ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000100, 0xbf800000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf800000, 0xbf800000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd8d80000, 0x01000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x80767074,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a4076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x008c0000, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d037d, 0x80700370,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd5250000, 0x0001ff00,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000100, 0xbf0a7b7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2fff1, 0xbefe00c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857d9973, 0x8b7d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06817d, 0xbfa20004,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef000ff, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0080, 0xbfa00003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef000ff, 0x00000400,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff00c1, 0xb8fb3b05,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807b817b, 0x847b827b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857d9973, 0x8b7d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06817d, 0xbfa2001b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0084, 0xbf0a7b7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10032, 0x7e008700,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e028701, 0x7e048702,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e068703, 0x80767074,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a4076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x008c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00008000, 0xee0a4076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x010c0000, 0x00010000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x018c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00018000, 0x807d847d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8070ff70, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a7b7d, 0xbfa2ffe9,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0001a, 0xbefd0084,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0a7b7d, 0xbfa10017,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e008700, 0x7e028701,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e048702, 0x7e068703,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80767074, 0x82778075,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x000c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xee0a4076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x008c0000, 0x00010000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a4076, 0x010c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00020000, 0xee0a4076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x018c0000, 0x00030000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d847d, 0x8070ff70,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000400, 0xbf0a7b7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffe9, 0xbfa00184,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef4007e, 0x8b75ff7f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01ffffff, 0xbef1007f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f20742, 0x84729972,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7f, 0x04000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10044, 0xbefe00c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857d9972, 0x8b7d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06817d, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0080, 0xbfa00001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff00c1, 0xb8ef4306,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6fc16f, 0xbfa10039,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x846f8a6f, 0xb8f83b05,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80788178, 0xbf0d9972,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0x84788978,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0x84788a78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8078ff78, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8078ff78, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x857d9972, 0x8b7d817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06817d, 0xbefd0080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd71f0001, 0x000100c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd7200001, 0x000202c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x30020282, 0xbfa20012,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80767874, 0x82778075,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd8340000, 0x00000001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd5250001, 0x0001ff01,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000080, 0x807dff7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000080, 0x8078ff78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000080, 0xbf0a6f7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffef, 0xbfa00011,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80767874, 0x82778075,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd8340000, 0x00000001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd5250001, 0x0001ff01,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000100, 0x807dff7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000100, 0x8078ff78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000100, 0xbf0a6f7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffef, 0xbef80080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefe00c1, 0x857d9972,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7d817d, 0xbf06817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20002, 0xbeff0080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa00001, 0xbeff00c1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8ef3b05, 0x806f816f,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x846f826f, 0x857d9972,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b7d817d, 0xbf06817d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2002c, 0xbeee0078,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8078ff78, 0x00000200,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0084, 0x80767874,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a0076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00008000, 0xee0a0076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00010000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00018000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e008500, 0x7e028501,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e048502, 0x7e068503,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d847d, 0x8078ff78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200, 0xbf0a6f7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffe8, 0x80766e74,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a0076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00008000, 0xee0a0076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00010000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00018000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa0002d, 0xbeee0078,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8078ff78, 0x00000400,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0084, 0xbf0a6f7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10018, 0x80767874,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a0076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xee0a0076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00020000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00030000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e008500, 0x7e028501,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e048502, 0x7e068503,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d847d, 0x8078ff78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000400, 0xbf0a6f7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa2ffe8, 0x80766e74,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xee0a0076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0000, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000, 0xee0a0076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c0002, 0x00020000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xee0a0076, 0x000c0003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00030000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f83b05, 0x80788178,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9972, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84788978, 0xbfa00001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84788a78, 0x8078ff78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200, 0x80f8ff78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000060, 0x80767874,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xbefd00ff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000006c, 0xf460403b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80fd847d, 0xbf800000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804300, 0xbe824302,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80f6a076, 0x82f78077,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf460603b, 0xf8000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0x80fd887d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf800000, 0xbe804300,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe824302, 0xbe844304,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe864306, 0x80f6c076,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82f78077, 0xf460803b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000000, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80fd907d, 0xbf800000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804300, 0xbe824302,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe844304, 0xbe864306,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe884308, 0xbe8a430a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe8c430c, 0xbe8e430e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf06807d, 0xbfa1ffef,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb980f801, 0x00000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8f83b05, 0x80788178,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9972, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84788978, 0xbfa00001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x84788a78, 0x8078ff78,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200, 0x80767874,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x82778075, 0xbeff0071,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bfb, 0xf8000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601b3b, 0xf8000004,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601b7b, 0xf8000008,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601c3b, 0xf800000c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601c7b, 0xf8000010,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601ebb, 0xf8000014,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601efb, 0xf8000018,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601e7b, 0xf800001c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601cfb, 0xf8000020,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000024,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef814,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000028,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef815,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf800002c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef812,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000030,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf8a0000, 0xb96ef813,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7f, 0x04000000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10022, 0xf4601bbb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000038, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d806e, 0xbfa1001d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e906e, 0x8b6e6e6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbe804ec1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x816ec16e, 0xbfa0fffb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbef800ff, 0x00000080,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd0081, 0xf4601bbb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf0000000, 0xbfc70000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80788478, 0x937eff6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00070004, 0x847e907e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8c7d7e7d, 0xbe80517d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x917dff7d, 0x007f0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e906e, 0x8b6e6e6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbe804e7d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x816ec16e, 0xbfa0fffb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x807d817d, 0xbf08907d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa1ffec, 0xf4601bbb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf800003c, 0xbfc70000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d806e, 0xbfa1000c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9a7f, 0xbfa10002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf068180, 0xbe804fc4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffc, 0xbfa10006,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e906e, 0x8b6e6e6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10003, 0xbe804ec3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x816ec16e, 0xbfa0fffb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf4601bbb, 0xf8000040,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfc70000, 0xb96ef81a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbefd006f, 0xbefe0070,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbeff0071, 0xb979f822,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97b2011, 0x857b867b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97b0191, 0x857b827b,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97bba11, 0xb973f801,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8ee3b05, 0x806e816e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0d9972, 0xbfa20002,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x846e896e, 0xbfa00001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x846e8a6e, 0x806eff6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001c0, 0x806e746e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x826f8075, 0xf4605c37,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000010, 0xf4605d37,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000020, 0xf4601e77,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xf8000034, 0xbf8a0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e9677, 0xb96e04a1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e9577, 0xb96e0421,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x856e8e77, 0xb96e3021,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6dff6d, 0x01ffffff,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8bfe7e7e, 0x8bea6a6a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97af804, 0xb8eef802,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf0c8b6e, 0xbfa20003,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804fc2, 0xbf94fffe,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa10001, 0xbe804ec4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffc, 0x857a897a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb97a0244, 0xbe804a6c,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8eef802, 0xbf0c8b6e,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20003, 0xbe804fc2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf94fffe, 0xbfa10001,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbe804ec4, 0xbf94fffc,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfb10000, 0xbf9f0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbf9f0000, 0xbf9f0000,<br>
+};<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drive=
rs/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
index b5af2c97a091..1e248af0e9e9 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm<br>
@@ -28,23 +28,26 @@<br>
&nbsp; */<br>
&nbsp;<br>
&nbsp;#define CHIP_GFX12 37<br>
-#define CHIP_GC_12_0_3 38<br>
-<br>
-#define HAVE_XNACK (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)<br>
-#define HAVE_57BIT_ADDRESS (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)<br>
-#define HAVE_BANKED_VGPRS (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)<br>
-#define NUM_NAMED_BARRIERS (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3 ? 0x10 : 0)<=
br>
-#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)<br>
-#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY =3D=3D CHIP_GC_1=
2_0_3)<br>
+#define CHIP_GC_12_0_3_REV_0 38<br>
+#define CHIP_GC_12_0_3_REV_1 39<br>
+<br>
+#define HAVE_XNACK (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0)<br>
+#define HAVE_57BIT_ADDRESS (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0)<br>
+#define HAVE_BANKED_VGPRS (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0)<br>
+#define NUM_NAMED_BARRIERS (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0 ? 0x1=
0 : 0)<br>
+#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0)<br=
>
+#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY &gt;=3D CHIP_GC_=
12_0_3_REV_0)<br>
&nbsp;#define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY =3D=3D CHIP_GFX12)<br=
>
-#define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)<br>
+#define HAVE_VOP3PX_FIXUP (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3_REV_0)<br>
+#define HAVE_VGPR_MSB_FIXUP (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0)<br>
+#define HAVE_INSTRUCTION_FIXUP (HAVE_VOP3PX_FIXUP || HAVE_VGPR_MSB_FIXUP)<=
br>
&nbsp;<br>
&nbsp;#define SINGLE_STEP_MISSED_WORKAROUND 1 //workaround for lost TRAP_AF=
TER_INST exception when SAVECTX raised<br>
&nbsp;#define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY =3D=3D CHIP_GFX12)<br>
-#define HAVE_HT_TRAP_ID_WA (ASIC_FAMILY &gt;=3D CHIP_GFX12)<br>
-#define WAVE32_ONLY (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)<br>
-#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3)<br>
-#define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY =3D=3D CHIP_GC_12_0_3)<br>
+#define HAVE_HT_TRAP_ID_WA 1<br>
+#define WAVE32_ONLY (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0)<br>
+#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0=
)<br>
+#define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0)<b=
r>
&nbsp;<br>
&nbsp;#if HAVE_XNACK &amp;&amp; !WAVE32_ONLY<br>
&nbsp;# error<br>
@@ -76,7 +79,7 @@ var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 9<br>
&nbsp;var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 8<br>
&nbsp;var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 12<br>
&nbsp;<br>
-#if ASIC_FAMILY &lt; CHIP_GC_12_0_3<br>
+#if ASIC_FAMILY &lt; CHIP_GC_12_0_3_REV_0<br>
&nbsp;var SQ_WAVE_LDS_ALLOC_GRANULARITY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 9<br>
&nbsp;#else<br>
&nbsp;var SQ_WAVE_LDS_ALLOC_GRANULARITY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 10<br>
@@ -707,7 +710,7 @@ L_SAVE_HWREG:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_v2(s_save_t=
mp)<br>
&nbsp;#endif<br>
&nbsp;<br>
-#if ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3<br>
+#if ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_getreg_b32&nbsp;&nbsp;&n=
bsp; s_save_tmp, hwreg(HW_REG_WAVE_SCHED_MODE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_v2(s_save_t=
mp)<br>
&nbsp;#endif<br>
@@ -1281,7 +1284,7 @@ L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:<br>
&nbsp;L_SKIP_CLUSTER_BARRIER_RESTORE:<br>
&nbsp;#endif<br>
&nbsp;<br>
-#if ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3<br>
+#if ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_load_b32&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null =
scope:SCOPE_SYS offset:0x40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_wait_kmcnt&nbsp;&nbsp;&n=
bsp; 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_setreg_b32&nbsp;&nbsp;&n=
bsp; hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp<br>
@@ -1393,7 +1396,7 @@ function get_sgpr_size_bytes<br>
&nbsp;end<br>
&nbsp;<br>
&nbsp;function get_hwreg_size_bytes<br>
-#if ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3<br>
+#if ASIC_FAMILY &gt;=3D CHIP_GC_12_0_3_REV_0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 512<br>
&nbsp;#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 128<br>
@@ -1550,6 +1553,7 @@ function fixup_instruction<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Instruction is 1 DWORD =
otherwise<br>
&nbsp;<br>
&nbsp;L_FIXUP_ONE_DWORD:<br>
+#if HAVE_VGPR_MSB_FIXUP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Check if TTMP15 contain=
s the value for S_SET_VGPR_MSB instruction<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ttmp10, ttmp15, 0xffff0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // C=
heck encoding in upper 16 bits<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32&nbsp;&nbsp;&n=
bsp; ttmp10, 0xbf860000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; // Check if SOPP (9b'10_1111111) and S_SET_VGPR_MSB (7=
b'0000110)<br>
@@ -1560,6 +1564,7 @@ L_FIXUP_ONE_DWORD:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ttmp13, ttmp13, 6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Shift SIMM[13:8] into 7:2, Src2, Src=
1, Src0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ttmp10, ttmp10, ttmp13&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; // Src2, Src1, Src0, Dst --&gt; format in MODE registe=
r<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_setreg_b32&nbsp;&nbsp;&n=
bsp; hwreg(HW_REG_WAVE_MODE, 12, 8), ttmp10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // W=
rite value into MODE[19:12]<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; L_FIXUP_DONE<br>
&nbsp;<br>
&nbsp;L_FIXUP_NOT_VOP12C:<br>
@@ -1586,10 +1591,12 @@ L_FIXUP_NOT_VOP12C:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Not VOP1, VOP2, VOPC, V=
OP3, VOP3SD, VOPD, or VOPD3.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Check if we are in the =
middle of VOP3PX.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ttmp13, ttmp14, 0xffff0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // B=
its 31:16<br>
+#if HAVE_VOP3PX_FIXUP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32&nbsp;&nbsp;&n=
bsp; ttmp13, 0xcc330000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; // If 31:16 =3D 0xcc33, this is 8 bytes past VOP3PX<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_FIX=
UP_VOP3PX_MIDDLE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32&nbsp;&nbsp;&n=
bsp; ttmp13, 0xcc880000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; // If 31:16 =3D 0xcc88, this is 8 bytes past VOP3PX<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_FIX=
UP_VOP3PX_MIDDLE<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Might be in VOP3P, but =
we must ensure we are not VOP3PX2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32&nbsp;&nbsp;&n=
bsp; ttmp13, 0xcc350000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; // If 31:16 =3D 0xcc35, this is VOP3PX2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_FIX=
UP_DONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // If VOP3PX2, no fixup needed<br>
@@ -1651,10 +1658,12 @@ L_FIXUP_THREE_DWORD:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ttmp15, ttmp3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Move possib=
le S_SET_VGPR_MSB into ttmp15<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; L_FIXUP_ONE_DWORD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Go to common logic that ch=
ecks if it is S_SET_VGPR_MSB<br>
&nbsp;<br>
+#if HAVE_VOP3PX_FIXUP<br>
&nbsp;L_FIXUP_VOP3PX_MIDDLE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_co_u32&nbsp;&nbsp;&n=
bsp; ttmp0, ttmp0, 8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Rewind PC 8 bytes to beginning of in=
struction<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_co_ci_u32 ttmp1, ttm=
p1, 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; L_FIXUP_TWO_DWORD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 2 DWORD inst (2nd half of =
a 4 DWORD inst)<br>
+#endif<br>
&nbsp;<br>
&nbsp;L_FIXUP_DONE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_wait_kmcnt&nbsp;&nbsp;&n=
bsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Ensure load of ttmp2 and ttmp3 is done<br=
>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index 0f96c9e3fa4d..edafbd9377b5 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -564,11 +564,17 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; KFD_CWSR_TMA_OFFSET);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa =3D cwsr_trap_gfx12_hex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_hex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(12, 1, 0) &amp;=
&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (kfd-&gt;adev-&g=
t;rev_id &amp; 0xF) =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUILD_BUG_ON(siz=
eof(cwsr_trap_gfx12_1_0_rev_0_hex)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; KFD_CWSR_TMA_OFFSET);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;cwsr_isa=
 =3D cwsr_trap_gfx12_1_0_rev_0_hex;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;cwsr_isa=
_size =3D sizeof(cwsr_trap_gfx12_1_0_rev_0_hex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUILD_BUG_ON(siz=
eof(cwsr_trap_gfx12_1_0_hex)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUILD_BUG_ON(siz=
eof(cwsr_trap_gfx12_1_0_rev_1_hex)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; KFD_CWSR_TMA_OFFSET);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;cwsr_isa=
 =3D cwsr_trap_gfx12_1_0_hex;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;cwsr_isa=
_size =3D sizeof(cwsr_trap_gfx12_1_0_hex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;cwsr_isa=
 =3D cwsr_trap_gfx12_1_0_rev_1_hex;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;cwsr_isa=
_size =3D sizeof(cwsr_trap_gfx12_1_0_rev_1_hex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd-&gt;cwsr_enabled =3D true;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH1PR12MB9598F7D782297E89C405FB4F9A6F2CH1PR12MB9598namp_--
