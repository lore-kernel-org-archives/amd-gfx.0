Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D0C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 14:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049FC10E5B2;
	Tue, 28 Jul 2026 14:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VR58lmmu";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012029.outbound.protection.outlook.com
 [40.93.195.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D0E10E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 14:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMMKqBfmseHFk/wcVi19ClRHiNEHFOxYx4rNheLtYBOZdfNA4Pzb4k/VLBOjvYWGCIgL6oYl4aEflsrIP9qtNnGWhY1e5uMRphJMluCZvkVm8mogg5aya4NeGtYCvuXmuomtlMVAvOKqMQkqpmJgE8vfsKB9uHG1MphXbliEvdacvQMXWncog/7OvoSiAUlkjUYA+THzC+Tk3UdApXpjY0vl8ZGmWzps+H1OVgcnfyHMoFtpI5uwSTd7epezPVqlrpY0swFNz9eMrce35tcFrUOvlHCQAPuph9UPsNNuxSI0feRccJCO2HwwS61IDt+APDMWsFKRpeGklCa1+j5ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oZtfLSSAuCF+DbRC15Gs4nxjQiRTi6KjOpv0nu7ozo=;
 b=j2t0sxYWW7rNlQoKqeEvSOFiZVA6Lng/0DSWdDajszO9cQ8+LPe/AEnXye9P3cR8MlI2cO5jEgIn6gvM8Fdp2KGPTfG5vZK0yISqhWEAkDQAPgCPK7UZ04EAN2aVj9wfVtGaVIvKfjoRrZEw65dCrWm6+p2DLTHaC8wOLjkfYShhlYQNXFWv+9k4CS1FYgXzDPmJM5YvLbkzHOx4CUjdGQ0wLmjUSOc2g2KR/62ZWFdrtKVuWg1NyDz7WZQkQ2Ru+EzuhGKlNPsugvgzJqIRv+fpfCiHUOobe0QyyH16NKVA9P1eXOCwtaDjAfybTUHl3LPLt9y9NW05uUJ26U/eWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oZtfLSSAuCF+DbRC15Gs4nxjQiRTi6KjOpv0nu7ozo=;
 b=VR58lmmuyq+j4oopUhI5pTz+nrnW19VDa+yGrtt78gOSzYcMU1/11IK4KdU06O5rMD/eJ4jV1YcbK7khJL+P/nB4r7bm49F8A5YHG/MJ2DQvadK/P+JEde8vNhXBF/WsXEZoXdwaCfyJsGxiGMS5NmaiLmPpB7qAY8rZWNyG0Ak=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by IA5PR12MB999276.namprd12.prod.outlook.com (2603:10b6:208:60b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 14:12:14 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 14:12:14 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Gill, Harkirat (Harry)" <Harkirat.Gill@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: cap GTT size to physical RAM on APUs
Thread-Topic: [PATCH] drm/amdgpu: cap GTT size to physical RAM on APUs
Thread-Index: AQHdHgA0Co7GVc8qmUWYWGgsn+iD5raC+hLV
Date: Tue, 28 Jul 2026 14:12:14 +0000
Message-ID: <SA1PR12MB81449D3F0A3ADCCC6D5FEAA5EFCB2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260727194207.176803-1-harkirat.gill@amd.com>
In-Reply-To: <20260727194207.176803-1-harkirat.gill@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T14:12:13.591Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|IA5PR12MB999276:EE_
x-ms-office365-filtering-correlation-id: 2808bd1b-5e14-470c-a190-08deecb23933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|11063799006|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: SA90G68tAijKY4IhAqTDxuKCBoxj69iL9wSZI2hHQizDH059lk6ShQDNy0wxoFCAJkGyrx+cZ0xoARrJTWBs+/Q0MaZAREpHThJ39EaCrPtFBOXrbZALdEwhuqkSm20/mEtFa8igGdaBYqWgG1JgOsGVi8ypCZ2TZ0NnMq8W0YYpca99BOsrDykXW27K8AR/YlVRumphhoek1kQ1lEo+pElVHdofH8rBEWiwctbScOamM4xHc29XN7FkoK+tfUXI8XTt2K08mfc2fKZgFcuf8HQQ8EaAD0yKUHmyGCYZHBdBFtPDFoZbFtaNETsEzxpDqAZ6/Mx0AubzBPzqw3G38k877FNWoqerpuIPBVsVIbJ9QHvITTtZQcf+GHpcb+MGq9XOQMuW/PEZrOjN6uQX4rvkV9PHhjO97MJJnE+bscaflVBR60NrhSnQhWD70vCycLdEVoyXA9MdQA2un2SshibXAkDVGn5KEbp13YUgT35sQh1ioZY4GXTteKVDD+KkUNvZXpEg4Kzr8d+WKbGBcfrEtb9Is21s/8RE7Y+duvV4MVE0xHpc43FHK6tPCES6s5s+LUbFXZ/7wndMxzW1GOyEV4sGO7p0MBgEeOi0qBoU6gxavRUnWkSHqf61m4oTGbX6D/FK75pGvQnLUp3axX6k5FNJhhISIkJwAAnPPPWYW609dCdsj80ti0PIw7ID5dK9yUI2QtdwKsXpucA4KGu/z2I5FzLR/KeQ5Gcun0w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ArFkJDyKZDzBQAR5ArZDr/aNWNsBl9PKYHa24MtJS2BF9POM/WJAKqOjEtKl?=
 =?us-ascii?Q?iREhaznwSy43Hxbg83hBZ+XDMu2OxF2/wtHKKeXmPy0LO9w/0dvB5MBKiV/2?=
 =?us-ascii?Q?xXb6g5zBbRFjGMzDIe7mFD8gW5IG+7287hvQAjnL/4cQekYNFlqlwgIzLrCb?=
 =?us-ascii?Q?rsw2pjbqxafMCzFg5DgWbXqMnajec3p3o44pOVeLXT+jBCdMdufpBWcfP3OX?=
 =?us-ascii?Q?ZpLmifVPg+a1anaoGqZ369gbeXrQ9fq1Ji8BB9wa85GGM34liyYcKoKH35ZH?=
 =?us-ascii?Q?Tr2XQGXUpyUJtlFBkXRhdCoBunJWSCub0bvpW/woVXTMzO9ow9gF60VEHBk0?=
 =?us-ascii?Q?A6dFbZWaa+iq/EbwKX/tCI8QA7hDVCmqVeXA6EseFLwoayHumzD0Kq7Wxt0a?=
 =?us-ascii?Q?ELAqFQC+a3XNvtWkHUtrnB6Idm23T9hcHVUACuFUWZa/Chr6TVS3VqP9voCf?=
 =?us-ascii?Q?2hUCRofARyxk05SjNHMP//2Z5qrXDSczBwpjSroeok7erclQYvu4fyY23Hd3?=
 =?us-ascii?Q?n1cdcOgGAXJj7sUj9Yl1HmuZ6a21JbIEpFy2voDT4PjZPIlFshhnM7q0Il4L?=
 =?us-ascii?Q?sRnWUciSs4XPvTxJa08xij0L5h8FT5/Dg0UAuVEW5UzMcoijdRGLn5ru8/YB?=
 =?us-ascii?Q?MH6+VDPoRxqSyuntlGLt6YAM9eHWVySi7aX33g8ao+U2m3+4GrlY8KlP7fMu?=
 =?us-ascii?Q?4iAOEO0zT6YCT0tanRn8EZAbMpSFTj6u2Asv2B+ZkPCtVtRHlFh42ZAlgYCt?=
 =?us-ascii?Q?K0hTVGnSFU+1xsG/NUazw48OsX8hugq/TJV9JJE64VOsZgiIALcwpeU52iqC?=
 =?us-ascii?Q?zhxSliLFNqJC1X1ib7Sn2ENT5wlHg24AWe8PkVYRWeVWf0ETVwUp/IEJNCTW?=
 =?us-ascii?Q?aWgWVAfLkxfGoLHNW0sYf8pIf5/s/gv1nSVdpU7PjaW/ebqPzrTMvtQYG4zO?=
 =?us-ascii?Q?oYlStfx7I2z8qwy6qK6IXm26nBAkwHudgPdCcIp92LDTJvVvTmUPmDPfBeLP?=
 =?us-ascii?Q?YJFXW1eSNKlQ4w8u9KAZQ7zNhu3uDxMzDCXB3bPYniq8y32qfD+NSq1xH3aG?=
 =?us-ascii?Q?Qe6MflSOEBZhPMe176auYVTtj+0840w70ysGoBPlzDhzrUBNh2F/YOTTLt3A?=
 =?us-ascii?Q?sP3VX3LMZORWfgyxJ/HX3JHZGnyT6gnPn2BJIjTVx0w+fzOzQes7epjWJHN0?=
 =?us-ascii?Q?80u11BFxjYsQZxStMUyt3RxHKCSEhEAiqR+N4I6xx0OrBZWSOOM0BBz6cCrU?=
 =?us-ascii?Q?qzGQ8S8+pSQKonIo+OsbWCnnbeNjDJk3joAxhmfy0RMT67muC2oVwQqDzVBl?=
 =?us-ascii?Q?MDPbLi+gwXVUAHU2DmkSWEbipCPG1B9iNvnclq4nKvZr2qnYfWvlLJSGz3N6?=
 =?us-ascii?Q?bBgyiO7nPnhlpBl6KJ22jo8VxwyH1ybzfDVVI8TonKR+bOzo12/D+pnOjLe6?=
 =?us-ascii?Q?NBtqVTbp8YtONbhS3jnwacxcPz17W11pbbCP9h3U1sBbqnlp6/KrXfw5cjhx?=
 =?us-ascii?Q?aE7vfc/ob7DQb/LGcpfq7LV0NvtChGUQhBke7YgXidoItmQ0x+6Uf5WghgjW?=
 =?us-ascii?Q?pXB+UYKjiFaGROq3YsxG5gH5dlXu73sEB01l5H2jWytMA4vfFc+ZElwdTuZN?=
 =?us-ascii?Q?Xly/V9B0EMqBTtDNWyWfwc6wCpbEwVa9m+hD9VwmFVE1SMXsEPrvHKjV0Qbp?=
 =?us-ascii?Q?iNdzQkvOiJwUIWvThIySC6OOBDVDBQQyMGslUV7y5l2PK8Tt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2808bd1b-5e14-470c-a190-08deecb23933
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 14:12:14.1091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMGJ3B98IxBJrCTzZ3szd2CPd9d+o4Meqp/r4LL8SFXyywXwSeSqDsBMJy9Inyxz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999276
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

Looks good to me

Reviewed-by: David Francis <David.Francis@amd.com>

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Harkirat=
 Gill <harkirat.gill@amd.com>
Sent: Monday, July 27, 2026 3:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian; Gill, Harkirat (Harry)
Subject: [PATCH] drm/amdgpu: cap GTT size to physical RAM on APUs

[Some people who received this message don't often get email from harkirat.=
gill@amd.com. Learn why this is important at https://aka.ms/LearnAboutSende=
rIdentification ]

On APUs, the GTT pool is backed by system RAM, but its size is not bound
to the non-carveout memory that actually backs it. A user can end up
with GTT + VRAM exceeding total physical memory through the following
sequence:

 - Have a large non-carveout memory space (~128GB) and accordingly set a
   large GTT (~100GB) via the ttm module parameter.
 - Lower the non-carveout memory space in BIOS by increasing the UMA
   Frame Buffer Size (VRAM) to 64GB.
 - The previously set GTT value (~100GB) persists, even though the new
   non-carveout space (64GB) can no longer back it.

This leads to a case where kernel reports GTT (100GB) + VRAM (64GB)
despite the sum being greater than total physical memory (128GB).

Cap the GTT size to totalram_pages() on APUs. totalram_pages() already
excludes the VRAM carveout, so the resulting GTT can never exceed the
system RAM that actually backs it.

Signed-off-by: Harkirat Gill <harkirat.gill@amd.com>
Assisted-by: Claude:claude-opus-4
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 7920675af..da89d19dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2173,6 +2173,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
                gtt_size =3D configured_size;
        }

+       /* Cap GTT so that it does not exceed total physical RAM. */
+       if (adev->flags & AMD_IS_APU) {
+               u64 phys_ram =3D (u64)totalram_pages() << PAGE_SHIFT;
+
+               if (gtt_size > phys_ram) {
+                       gtt_size =3D phys_ram;
+                       dev_info(adev->dev,
+                                "Capping GTT to %uM to not exceed availabl=
e system memory\n",
+                                (unsigned int)(gtt_size / (1024 * 1024)));
+               }
+       }
+
        /* Initialize GTT memory pool */
        r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
        if (r) {

base-commit: ea97ab2759506d9a818ffed1009bde01062b4091
--
2.43.0

