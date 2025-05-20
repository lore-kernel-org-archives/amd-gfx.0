Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28206C2D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 01:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2E710E02F;
	Tue, 20 May 2025 01:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENAmoZvd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE3510E02F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 01:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Viq7JDpcq7iT/VBeFiHMzsVYIf7C5o2oMXpauWZM/dqAylTViOLPfsDV3NA1bDyVfvRWRB+0BhCzXu2AddlK7TSCxbWbqE4/PRs7cQTrYbfFCbweeBMdDJv4oetgGM/QlSG/2xO6OdwurVR9aZwjNligKf6sPnajnq4a2NNC1V8BZmmAPmpnpvwoHobgGcykJPo4tRdiuqsm46RW2obbRyLtXwByvALowepviIn6TF87P1GYfPdVuDavTStl3ABwEO3L2cJe56lQshxBbgDK356XU3bfWgcfLD5skSor8+DCRS7qHJ49agiTqGD4agTGJC/RmwMe+K27h9mzNcFw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ1X6J5dByiZQAbGWCNDRpgMjFpDJYMGxs0JvgYFT1E=;
 b=L1QCeY4a9ssLeGprjqSRW/HhmlmhuAHPXiQahFcFjkayYvMfkdsgtV5+tkDCICmUhB3Dc/cgmvRTiw5WtxGRMK4oc2CKnyYtvTilbX6YWGemnwDVCsMqX1Sx9imHsOCvu/HMZ+QNJkKZ+6JfSAsDfXbM10VXBmw+yekvHtGrc/L1HNo/k2hK0nkBB5zh2Qfzy7QqEyDkHUcYUBHRzpyOQ4cUCLa3ZuKjoWpY+Akbd/G8MzVyHDTdDMZjluIaNsk9CKMxIhAlS2tDcb+aTMCfBxjGCCMfQvt6sgE1lxAsIaWspk49zQfMAhCXo1IikRd72UfAmDzV0QZYtb+4RHWcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ1X6J5dByiZQAbGWCNDRpgMjFpDJYMGxs0JvgYFT1E=;
 b=ENAmoZvdcNYHCUvL/VGLDa/PcKRXmhPfzSn1+AspLAOFi/knQhNVN1hgJ+heKvZBTeDXvGYG/wKKQLQXQIYpqeqfZlxGcOHRBkplMazKZTr9T6YLuatpSaYEC3SefCYIWkT9QFUSu1JZszuV3Dxl8ju8Rr4tcCnL2CIZU6QF6t4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 01:05:39 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 01:05:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update runtime pm checks
Thread-Topic: [PATCH] drm/amdgpu: Update runtime pm checks
Thread-Index: AQHbyPfqFJfFfel4/UqGxdIX9cHbJLPatJXg
Date: Tue, 20 May 2025 01:05:38 +0000
Message-ID: <BN9PR12MB5257B623F445D76C9AD94B49FC9FA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250519195435.82731-1-alexander.deucher@amd.com>
In-Reply-To: <20250519195435.82731-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cb79bcd3-03e3-4e22-9e00-4cb3147cd295;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-20T01:05:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH2PR12MB4245:EE_
x-ms-office365-filtering-correlation-id: 2461ce07-1d2b-4b6e-5e11-08dd973a6f48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7BNzLq1T5NApbEDJJO7sbdSsjQuMV8YszmccwdmwGntQlDg8ubpM6kMV7rOK?=
 =?us-ascii?Q?QI7qOK/8KanKzmL62UqHtbIHul372PyHZw8rSaoKh3fL0NUXAts/X8ly2J6Y?=
 =?us-ascii?Q?5sT111lMywQJZsXtELC7v8wT8jEVsIjTL4EyQWy8jCvAG9fdXC0VnrG9Duce?=
 =?us-ascii?Q?pUodBTlnSGVs1QDvngxpQueBDD/8vu1FUHqxYMegr39GOqAYoGEEBWhj6+nl?=
 =?us-ascii?Q?9Rvxe2JMRR5etwif0VPzvInN/Kp4kPk8d8Z6VbfEN+RL7iIJFizN+1czltvX?=
 =?us-ascii?Q?owWpXEzxGlhKmfKUi9D3Zoo5344Q+2PEjz/yTeWtg3CMFF1Qt+mqIdrmnN7J?=
 =?us-ascii?Q?gCFM6QBst/As56lSm+itSo8gty055VJNhic4y+Sr9Wiz/J3LzrSG3/5+oMYa?=
 =?us-ascii?Q?94XJD7Azo9xkl99aOBAbFEh3tGBZCxQQ3wcnbkhbmCqG3TCPnVOiLVLNoubn?=
 =?us-ascii?Q?HH7GgAqHa3lhQqOoHBjTKou9ZwO52saXSHJA6k99Xh7VMzCuVO6fTYx2hhZO?=
 =?us-ascii?Q?3WpHSsySPjrEP9ZXUQadNaSP1b6GEtQ0iIfROe+JPLfvobq0/1w/HE0xXhGx?=
 =?us-ascii?Q?B2cM7gPxoT3Em1gKNx+lAkswd3fBGk9uc6lOXv/KcQYFoCfnHuiGxUZfp3vB?=
 =?us-ascii?Q?wXcwPYokYTTtuw/BIS0ewrK7mQG2NJWaq48IpKkAuN9YX3G3lIl8sJe0mrRf?=
 =?us-ascii?Q?ALDxDrG+YdSyj83Q58Q3TuKp31btAvgJGd0oSlLUnfoA8TJ2Q7PhorjmZAtY?=
 =?us-ascii?Q?mbI4ZY7uw8eS6qd99XKLuQrCCg/tE6uZwGRKCSUyEpqbYhQYlLidwJZSJdV8?=
 =?us-ascii?Q?M+AyWRp4auCLXHix52euEKuXqPGUhQmm6F3FTZRGtZCTpm32kT1NnxVsct7c?=
 =?us-ascii?Q?etcc3pdKgA1Ai5LN2OLSAWmKRyKtkh1CECZVLfI9dIlDJ8f2O6Ln4SFxbobL?=
 =?us-ascii?Q?WzOWttSdG9VRePs+ApK9BHbXhmfywcuUg+KXUpy4WdHdSYJt4Md2oF1sOQbY?=
 =?us-ascii?Q?wZWNcH6GG4I6esVPy8KPXSXcuH8C3NHwlj9zKdgwcJnmn+SsJTp0Hqne3yYy?=
 =?us-ascii?Q?zPfwTgHeZ+u5/HNO58GKDE8HEGiY2mAPTu9nhSCm1D4NNrnaoPiCw7LbnQUQ?=
 =?us-ascii?Q?aSQh3gFbB94IkxT+uCZcJ64hItrzbCX/ZI2wsu5TXgvJngU2Mcu/CflPKXfC?=
 =?us-ascii?Q?PNS0r/zOkZznir4BnOPimT0kQRkgoS+NUEbVsiVfkUw2IqkbyfLVecTafNzr?=
 =?us-ascii?Q?Iu5jS2T18dv/biy8MNC6ls5SJeOEPzmUu2dKbRtsMhJuyecNa0BbWJ9jxfyD?=
 =?us-ascii?Q?8PDfyHDF+4J/D8Naffq97+by3/BrI+Y6K/yoeT4ONrs6Mh3IhOEUKyeDLYxJ?=
 =?us-ascii?Q?goF1qr1KSwA3swe+IGWhiGUI/BRX2P2goZwhMNniDnWTGcdXKI0pqz1tLO5F?=
 =?us-ascii?Q?MC549N0Nw3MjSwRozaXT82P9zJWTBFUfhYdXTDK2YDafKsK4YKokDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6yubRuc0oH/vz1bCASY73uYcTB1+xQW8QwpmfVkj62Wsf6oHDiBAcvcnW0pP?=
 =?us-ascii?Q?uyVZOL7JGH4Miic9l3CaDnVLn84uc7m7qw3gBP0Yc9cJ/aLFAspKiy1aCIJ0?=
 =?us-ascii?Q?pvM8/NGVeVhXldc2sWf5rE5gdDfMhmNIqR7E5dk6UDVhSU4YaO5YwxopYvtq?=
 =?us-ascii?Q?PES41+eRcEZUXHElw+ltEL8SDSBoMfL7TPdpWSC7t4u+0zbLidFq+901rTtx?=
 =?us-ascii?Q?Vwu5+8w5jtIig99N/Qyx/TIy6axyABmnsnVpY5cs++UUEFV2kcIVMQ7XdedS?=
 =?us-ascii?Q?cLYB1SMhspP5br0Fxh1cgIcmBoktuCwKaIBuZCK6ug4k5Tv8kER4JIsdQRP1?=
 =?us-ascii?Q?77lWT453tyN4jLSjxHs7YXyHWWHcj4uAQvLWvTYWLyoDrnQpXTcyb5PZ1Y4P?=
 =?us-ascii?Q?haeJFFutPRItcEeyo3hAqJwQdaYCwGD6LlNM/N6qYEFgsVs4LPpwufTcgBJ7?=
 =?us-ascii?Q?g3eHR49jpagBPl0Y4hB+ILamzKMi3E0Lyla/29gHPplbGwwUaLanFgf9aD2q?=
 =?us-ascii?Q?5IL/72UPsXglVCwpeOFdPY9HOLPR8bsuouN0TQ8J9ZOOzwyd0Ruy8DA8CbSK?=
 =?us-ascii?Q?XOzKrQ0qbFtqsj7hOBT4C8C60tUdtfKZhFkfQRhF7Re8YUCNMor+xnf93QIO?=
 =?us-ascii?Q?//L7WM3DMLBbyiFbPWwHwoSsGkEr3rTTKtCr1/Op2B3vFkdemKxyxrp8X68J?=
 =?us-ascii?Q?Pwp0+lfM5gzT+xhymCp7Jmp9psnaC474uTD/XuueBSFAI4cdmHQCBS30XeLS?=
 =?us-ascii?Q?V7w9xEd2u35Dzipy/Ky+1cuh8OcHzB7YoW9NE3KMimtxjpjtz2WKISa9t5hB?=
 =?us-ascii?Q?MI8945sDvowW235vDm45QPxfBs3FPJNZmYvzMx2iA5k1Tvnz4Pve85wGJspq?=
 =?us-ascii?Q?JZyvyAK4PRa9E0TY1KFsz+hsl2FJ1J1ljzOuG7Aqd+Brg2nuFCVXYL3vJ/SX?=
 =?us-ascii?Q?+8eWGu7G/uOCX8g5Sru75jRi0zeYji8Ygm94YPyPBFpFPw0OYmSPlNJhjDBX?=
 =?us-ascii?Q?ljrFaS7jH31DVFW08kk75Im8lMcwcixrrzWKCszQQh5KTTCbpg60YSEnRTq+?=
 =?us-ascii?Q?yJnzsCk/zP46WFbDBqy7qvY9+eNV0W2OvlJVYx1Vtah9+DzUfIMwwKJY0WXR?=
 =?us-ascii?Q?mkC/1gToGafe3gUsiFSh/yh1S/nfZ7v8M8kSXl0YVzSq+xgB5TrvLSEtR2Z2?=
 =?us-ascii?Q?9etafjmL9UalRnzB03T5h4TcEH60QXNCgCaETLWuVEEHMPD/0b1nH2nt+4Po?=
 =?us-ascii?Q?Sr0PjHmxpDzFoAb/RI3fXDTh2ieDj4v3JMlIsb+egVFoRoNPeAWEOYz35J+6?=
 =?us-ascii?Q?jHwik4Pz2syovjCcJi7EdWzFd/FWESMR9q8Mv+N9KMCAngZNXWkrZGTIu+H1?=
 =?us-ascii?Q?sPpQDA878PvpLvqNNM8T0HaiwZXfju96h9h3CBcc0lcCO7wChhnWxtbWgu3N?=
 =?us-ascii?Q?hbWm84R5qsA71P+l8ObMBP5CQQ4C3MDMX5EtTiAZgzyukEo7YLYgBB1xU3iX?=
 =?us-ascii?Q?1GxvKPC+Mok63McdvLXlUnwmYAZNJKUWbX/H7NlK4xNQ9tSYCjRNk5WeS9hl?=
 =?us-ascii?Q?hnIdwDPow2i1DzFX8cg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2461ce07-1d2b-4b6e-5e11-08dd973a6f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 01:05:38.7324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVJsqzit2ZbjdogF38Zs4xvcoZ9rBqJVFNxn6uvqFbBhBVvxA0rHgCrZfG1INiHvakMmLBExfBL9S7nZLxpBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, May 20, 2025 03:55
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update runtime pm checks

Don't enable BACO when in passthrough. PCI resets don't work correctly when=
 in BACO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 32bf55eab9efa..f011ca5d24942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -512,12 +512,13 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdg=
pu_device *adev)
                                break;
                        case CHIP_VEGA10:
                                /* enable BACO as runpm mode if noretry=3D0=
 */
-                               if (!adev->gmc.noretry)
+                               if (!adev->gmc.noretry && !amdgpu_passthrou=
gh(adev))
                                        adev->pm.rpm_mode =3D AMDGPU_RUNPM_=
BACO;
                                break;
                        default:
                                /* enable BACO as runpm mode on CI+ */
-                               adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
+                               if (!amdgpu_passthrough(adev))
+                                       adev->pm.rpm_mode =3D AMDGPU_RUNPM_=
BACO;
                                break;
                        }

--
2.49.0

