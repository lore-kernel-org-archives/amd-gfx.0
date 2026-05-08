Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28579CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 04:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5CC10F32C;
	Fri,  8 May 2026 04:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rma6oAL/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7601610F32C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 04:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wiqdv4R6qskxytQOVtsF2U+fPwXtlSwcCpxgYMXXlGPpDjUYx9ceaDNZ4owzby0GOvYOhbWtoaq9fb/F8LJcyYGv6MW3J84RA2z7qiew04jmTq54UsgkIbxnDT4v9TnU0/JrreHu8ds9FZ55s1ViM78ZaUzpgTf62G0H+XWIiJWpcMdmIGlcz7iLL3WYTD443kM2LA/aZpc2q7bwdY/PxxywVYLC3FSF3GdaqkMXlWTwjPSc/4rSng2V6da9teH/ip9Dcfji26HOr1RjR8cZ1M1zohu4K0iow0p9Mb/zf6HHIMJSjoRqiKKLFJCu99wMtyXckb78ezyYC8+FGknJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NswZ50q2q+kFoJ2zOmj4lGa0AV859hg6d9NdPitIMM=;
 b=LzYaAoF2YfyAZZMsJRKTQ/ILc4knJkQdqGoevjV8bhvF77K5sqPhzBWNRAYyct8NN+Vx5RwUcxMMTlJ451QQqTavYoBE2khDEw/anyUmWgApLF62WbHG5wK9Tk4u38Gf33lwjINAHdbNTFxKjzCcAgMNO8OTRJPuujtCxdVg9shV3mXPR1Q/fnWlYrhTLs07cX2u4izQiGrybJBhkGbJxF2r2I8qy6GP38NH5tuqWvxa+tB6Uej3ZvjFO5mPToHPfiNDPMc/uqMs+H9rWhJEdgq73xDJNr1QZXf6ILOaIeegE5jtSxshyGEM1XQRrtdP2RbbK4MgVaPTjiXRQpc3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NswZ50q2q+kFoJ2zOmj4lGa0AV859hg6d9NdPitIMM=;
 b=Rma6oAL/2b4rZzz92sdT2EcdpmZJC6+h+JYrsOduods5OiVzgXVkoCasTdX0PxeDl3zcH9hPwa+LFi+rj2dlz28HUUHr0pbZpDozt1B6r/earaJO3+ttp9vW9gTPieig/jVMvn5Ob0RKUp/lVgxj0ZYLBNuVI2u8bJBCK4pa67k=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.19; Fri, 8 May 2026 04:10:34 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 04:10:33 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Thread-Topic: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Thread-Index: AQHc3pmu+DrUhsRdEkSk2VnZnwL4H7YDgEUAgAAB/xQ=
Date: Fri, 8 May 2026 04:10:33 +0000
Message-ID: <DM6PR12MB2972F4288EB98A661DD2F95A823D2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260508032019.1617320-1-kevinyang.wang@amd.com>
 <DS7PR12MB607129C7685D7FE30F7272EE8E3D2@DS7PR12MB6071.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB607129C7685D7FE30F7272EE8E3D2@DS7PR12MB6071.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-08T03:51:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|DS0PR12MB7679:EE_
x-ms-office365-filtering-correlation-id: c4d4bbe6-bfbc-413c-d5d2-08deacb7c042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|56012099003|22082099003|3023799003|18002099003;
x-microsoft-antispam-message-info: g1zpHR4oksSW/1sArfteaKJVJ28qo9+j0J6b0MaGC++LV3wsJoScGYwQbZZmymDMYJYOe+Ey9GJT8Pm/md77soHnTYJV9o92QELyNWZo5Clu57asJzMYq+8s5Q9oEqPKjqaMtbSVI7OLlIBJp2r00+4baVHl2YAyS2G8FFZUfWi4uJYrCmGfc292kBgZ6JtQ7xLgHNScwWMyAAawJ3P+c8TPspEGGSLDXoXQbtsDxeHHASSl16duwTD+m+YKliwL97ASqX8gUNRn1A+Y9wB/JbGsnbiRQw6hJGElzC8c9iPS1HrhJu5b949wrajJ30I3ObVJYnfrMbluotZwdm11LrhKbmHAbJkiKEfrqpXFM/4OlQeGl85gE2vhMI88geZ2rrdC4yi+yvTJXudWRHpEZ/TB5AgGGGRnZ3vjvFFUsRV7ZsMEFVYJnqV6C3NF1cbVxfkCuPX5ECZ2zzyEEbk0CxXk7YvI3P/fbvV3on4Uyo3BRPhPEFuRi92olDSc/FzFdzP6BJ3fFxZBHV6JFE4xFdnw73svBVDOyX2w3c/ftrFD+Ci5BBoCCLY7v+QFSZlKXFUOcSpJO+lZVwkJ9Ey0CAOfMDuFOZ29x5bVyBgUaZdett+T8xykdGE59Kc3wc6Wupj4nU9ne6NxhqwDwVcncV4O9BqvuK/WmLRrUBZ+3jlXzFMUDKkxvNejtO6leeGyCRlmpC7TRvG7FD7OReCBkjeDFqH4C6deIj9fGoGdl1a/cs7FVUvVJkQ7og9gQQJt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(56012099003)(22082099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lp9ndFv1aIbBK9tJJky0ROmx4TxL0fRyO6QMfRQ7TSGzij6Y/oIw7IVh5z8l?=
 =?us-ascii?Q?QlfU+G8Vp3zlE9R0nagF8LJ1P1y5+UiWQOq4xlzzJ0uabq86M1RmvjYcKKr8?=
 =?us-ascii?Q?8ZGRgAxZPxJ3CE2XBL9I0cp1GzeuJz8QctOBiheS5b5XIbboY/GewT+7+jX5?=
 =?us-ascii?Q?DPVqROPwnmD0/MapgoiQgDjLyKpFkZ0mErg8BJAiChyvD/T7AU0DUSbeRe5M?=
 =?us-ascii?Q?/okRlIncRQEnsPj+B4K6zsypD/mjW/gSJgmDO0gMco53BSmsUTP8bNZN6cTP?=
 =?us-ascii?Q?E6XuWXuyCsTqwrg9m/e3kaasLZzik2+swY0BLAzICo5fS2BCFOBsyFIzcXal?=
 =?us-ascii?Q?NDtPIXGcauIJ8jVLyBYRfH2UYyTByezU1HhOwcoASyV7Bc8JK/cYcv6lESdU?=
 =?us-ascii?Q?Stlskn0lhQlDR+w49bkh7JEDAMj4GJJbPsN42i+t30sxdrjSL6D/N14yPmwc?=
 =?us-ascii?Q?WZgOQXdeKksZSeS5oM+I66hg99yd6bLq0PPSu2qFvESVwEzbRDhhlp8PawdF?=
 =?us-ascii?Q?p2FFaEfRZcgffDpY6H6zq3s0D4FSFzwKoH1n4RMYveV0Zg1LUEAQh0N6aJuF?=
 =?us-ascii?Q?LsDQg7pG6qZOLBlkRCqTdwgvGcFGL3tf3Lyv23ytr9hMpR62dzVs1k4SUrjy?=
 =?us-ascii?Q?ZN2B/kbgPJLof8FEwJBL4qKEJqRYwcmxQQADmBIPA6+2cBsHzf/jjMX0HyQt?=
 =?us-ascii?Q?xYvlKnT5pg6INlUAX/bXjvHGWIDoeNH1BjF487ijjGs3PhaGAvgz7vTsLE+7?=
 =?us-ascii?Q?YlTqDnf0kVdcW0jaaaTF5k07yld7NR0lvLiEOCzyXUyKoaUAO9iwuO00tJx+?=
 =?us-ascii?Q?+1rXaKsCbasgtsa5Qt//ksnAMb1X3GDI6KEr1BCqTvUYUVazBvg6xeaXhkvq?=
 =?us-ascii?Q?bqvChnoxgsoExq6L5htsRJNlPpFWDdPi5/lv1dBsF0W3m3vYdpRxcoS+p+j9?=
 =?us-ascii?Q?nHEGbUMAG9HMmH/b3v1NiBlE7b/KlckT7OOz8eB+ba2OLKZ6ekysAf11wW30?=
 =?us-ascii?Q?+wRNN+Y3waSmhW08SSOXSr4yaNMH0R+Tw0xzxWyRk4zEOLELIfUhmWdqiL1u?=
 =?us-ascii?Q?dYSta54cIV6CkU/odj05zxvGdMSuO2IzBZYnchDNv0te442JIp4HTv4l/eEb?=
 =?us-ascii?Q?o6mzq4j20+f1gSnhhOk3PYEahhb/rgdTP0ew78/Q69SDe8Uun/FOtd79WC0g?=
 =?us-ascii?Q?etLZrFO3HJq35ImJcUjiYYPWJ2Kt6/HRZB38TlE9VPFRBIyqV1oalUr/4i2N?=
 =?us-ascii?Q?EJwlNHPxjDTSPbd9Ks/yCQDODTKNQmWP9O5zWHNIJia/kE160JP/nD31bRaC?=
 =?us-ascii?Q?GB2zFarnwvTwsdjtdTGtGz6fVoAEjS+ZsyAiebzZXgj94UKk1Bg+hCmqpYlw?=
 =?us-ascii?Q?HFPB4bM5PBHsPzTvcgl138AQ+J+Eo1PuTb66/PdFuLmI4+N/6D2Wf3J7lPOU?=
 =?us-ascii?Q?WyFfg8jk7vfN7+hPK0ICHUWd0jaFumwAJvN7PSrXYYOzeDGvDe6pY3Rbpho3?=
 =?us-ascii?Q?YYhphyvTQkvKalXORH23TcNVFpN2pGDpN2lKl1wXDT8xI8lHgQi4GLUUrw7+?=
 =?us-ascii?Q?e003fS/WJyFC6XxNArEWI4b/USATlstrUDwqJh8FrwWkYnLqXgfXpqEZIsn5?=
 =?us-ascii?Q?iAMosaiISMtu7JmErHmOb8OkZqCEm0AimU0S69ItxOklZwTCK6fYJWcZLG9c?=
 =?us-ascii?Q?bnlPVVY2OMszG+RC3Xs6SPjV4kPuWEhBU/S9lBkL6Uq9IPCIcPjp4VRv2+yI?=
 =?us-ascii?Q?Y4oIlvRynQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2972F4288EB98A661DD2F95A823D2DM6PR12MB2972namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d4bbe6-bfbc-413c-d5d2-08deacb7c042
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 04:10:33.7467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcnGVV4nR3huhvulE+x4fxCvX6tndEhPV/3mOfturiq8Z/iqR4W9ZRrjx5JF2XM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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

--_000_DM6PR12MB2972F4288EB98A661DD2F95A823D2DM6PR12MB2972namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


________________________________
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, May 8, 2026 11:57 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebar=
an (gc 9.4.2)

AMD General

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, May 8, 2026 8:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran (=
gc 9.4.2)

Split and correct DPM clock attribute constraints for GFX 9.4.1 (Arcturus) =
and 9.4.2 (Aldebaran) ASICs:

- Arcturus (9.4.1): Keep restrictions for mclk/socclk/fclk, update comment
- Aldebaran (9.4.2): Add dedicated per-clock constraints:
  * mclk/socclk: Only support voltage control, disable level setting
  * fclk: Mark as fully unsupported
  * pcie: Move multi-AID check into 9.4.2 case, disable level setting

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index fd2e63530e8c..9ee3053973cf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2033,16 +2033,11 @@ static int pp_dpm_clk_default_attr_update(struct am=
dgpu_device *adev, struct amd
                       gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
                       gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn.num=
_vcn_inst >=3D 2))
                        *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-               if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
-                   amdgpu_is_multi_aid(adev))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
        }
 AK: With the global pp_dpm_pcie block removed, amdgpu_is_multi_aid(adev) i=
s only evaluated inside case IP_VERSION(9, 4, 2). For any other GFX version=
, pp_dpm_pcie is no longer forced to ATTR_STATE_UNSUPPORTED on multi-AID. T=
hat includes 9.4.3 / 9.4.4 / 9.5.0
[kevin]: thanks, will make v2 to fix it.
Best Regards.
Kevin

Thanks & Regards
Asad

        switch (gc_ver) {
        case IP_VERSION(9, 4, 1):
-       case IP_VERSION(9, 4, 2):
-               /* the Mi series card does not support standalone mclk/socc=
lk/fclk level setting */
+               /* Arcturus does not support standalone mclk/socclk/fclk le=
vel
+setting */
                if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
                    DEVICE_ATTR_IS(pp_dpm_socclk) ||
                    DEVICE_ATTR_IS(pp_dpm_fclk)) {
@@ -2050,6 +2045,25 @@ static int pp_dpm_clk_default_attr_update(struct amd=
gpu_device *adev, struct amd
                        dev_attr->store =3D NULL;
                }
                break;
+       case IP_VERSION(9, 4, 2):
+               if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+                   DEVICE_ATTR_IS(pp_dpm_socclk)) {
+                       /* Aldebaran mclk/socclk DPM only supports voltage =
control,
+                        * not allow to set dpm level directly */
+                       dev_attr->attr.mode &=3D ~S_IWUGO;
+                       dev_attr->store =3D NULL;
+               } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+                       if (amdgpu_is_multi_aid(adev)) {
+                               *states =3D ATTR_STATE_UNSUPPORTED;
+                       } else {
+                               dev_attr->attr.mode &=3D ~S_IWUGO;
+                               dev_attr->store =3D NULL;
+                       }
+               } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
+                       /* Aldebaran does not support fclk dpm */
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+               }
+               break;
        default:
                break;
        }
--
2.47.3


--_000_DM6PR12MB2972F4288EB98A661DD2F95A823D2DM6PR12MB2972namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<div id=3D"mail-editor-reference-message-container">
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif;"><b>From:</b>&nbsp;Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, May 8, 2026 11:57 AM<br>
<b>To:</b>&nbsp;Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@l=
ists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang=
, Hawking &lt;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd=
.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH] drm/amd/pm: update dpm clock pm attributes=
 for aldebaran (gc 9.4.2)</span>
<div style=3D"font-family: Calibri, sans-serif;">&nbsp;</div>
</div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<span style=3D"font-family: &quot;Times New Roman&quot;; font-size: 12pt;">=
<a name=3D"BM_BEGIN"></a></span>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 11pt;">A=
MD General<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ya=
ng Wang<br>
Sent: Friday, May 8, 2026 8:50 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &l=
t;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
Subject: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran (=
gc 9.4.2)<br>
<br>
Split and correct DPM clock attribute constraints for GFX 9.4.1 (Arcturus) =
and 9.4.2 (Aldebaran) ASICs:<br>
<br>
- Arcturus (9.4.1): Keep restrictions for mclk/socclk/fclk, update comment<=
br>
- Aldebaran (9.4.2): Add dedicated per-clock constraints:<br>
&nbsp; * mclk/socclk: Only support voltage control, disable level setting<b=
r>
&nbsp; * fclk: Mark as fully unsupported<br>
&nbsp; * pcie: Move multi-AID check into 9.4.2 case, disable level setting<=
br>
<br>
Signed-off-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 ++++++++++++++++++++------<br=
>
&nbsp;1 file changed, 20 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index fd2e63530e8c..9ee3053973cf 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2033,16 +2033,11 @@ static int pp_dpm_clk_default_attr_update(struct am=
dgpu_device *adev, struct amd<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D IP_=
VERSION(11, 0, 2) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D IP_=
VERSION(11, 0, 3)) &amp;&amp; adev-&gt;vcn.num_vcn_inst &gt;=3D 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states =3D=
 ATTR_STATE_UNSUPPORTED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_pcie=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_is_multi_aid(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states =3D ATTR=
_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;AK: With the global pp_dpm_pcie block removed, amdgpu_is_multi_aid(ad=
ev) is only evaluated inside case IP_VERSION(9, 4, 2). For any other GFX ve=
rsion, pp_dpm_pcie is no longer forced to ATTR_STATE_UNSUPPORTED on multi-A=
ID. That includes 9.4.3 / 9.4.4 / 9.5.0<br>
[kevin]: thanks, will make v2 to fix it.</div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 11pt;">B=
est Regards.</div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 11pt;">K=
evin</div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 11pt;"><=
br>
Thanks &amp; Regards<br>
Asad<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (gc_ver) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* the Mi series card does not support standalone mclk/socclk/fc=
lk level setting */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Arcturus does not support standalone mclk/socclk/fclk level<b=
r>
+setting */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_mclk) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_socclk) ||<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_fclk)) {<br>
@@ -2050,6 +2045,25 @@ static int pp_dpm_clk_default_attr_update(struct amd=
gpu_device *adev, struct amd<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&g=
t;store =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_mclk) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_socclk)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Aldebaran mcl=
k/socclk DPM only supports voltage control,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * not allo=
w to set dpm level directly */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;att=
r.mode &amp;=3D ~S_IWUGO;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;sto=
re =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_is_mu=
lti_aid(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states =3D ATTR_STATE_UNSUPPORTED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;attr.mode &amp;=3D ~S_IWUGO;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;store =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Aldebaran doe=
s not support fclk dpm */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states =3D ATTR=
_STATE_UNSUPPORTED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
--<br>
2.47.3<br>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2972F4288EB98A661DD2F95A823D2DM6PR12MB2972namp_--
