Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B00BCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C213113415;
	Mon,  1 Jun 2026 14:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IIol7cYy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9FE113415
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qra/MjKtfvJA9zsreZcNpSPCEXLNdqfxYPXhfjO/OAJRvITNeIcEFjKPlNSQqMoqKUHw+mRHhzoAMZsHYfKY6Mn/5EUPoub6xniyEjvuYOlhZoXkMzavsOAcYkEOVCVblQk7jcr30jedtm8NL9QdaPLaoLIASDKP530t5Uw2sMl+tdFIA7Nj1+oZND9YuaRlwHVG+e5M4mwAfzE7JL1ZgZWlj9+m8EwgByZ/xBJtF560YVryfPgOWED3HEqRYXPEUBSkv7dnLXhO5h2rIZ/8gKw5sFuq+XOATAT/2OvLIMg4q9YXvw+m4ERLUg/MgqKVEcDpeajjXcyNFTj5LK3/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/uLfw4ApBcJVhoJSG6vkIT6PiDw30ah73sV4jUykkA=;
 b=FTHgJHC0yJhNlK/A0i3ZB09poqQ+aXOzlGmSauQsfsbf1G0fg8gAqQ6HtZufZtS55x8zNfql8jNfupXpOWgzr86lj04W4l/MKbDlmT1mjVtING6ZlETiFDdiL35P11UQMRNkLDmGXpC87tEPrt1HuvjalmYMu8SwlFw+/7/9IdqweGjF/Do5F32q3yt3hoGyrNfOGzdFoqClBlnpQw7A9qr/l8LxuEsOjrT7gB5OjDaZDkoBZwvK+zI9Tkjz3ziNzRqG8uF0CoeqPq0zs6CUPgc8NNwpu793ep4s76RomMMMkpMa3mipHRUuipYcA4GdgD8ydckzvB5/ev1SCv0kIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/uLfw4ApBcJVhoJSG6vkIT6PiDw30ah73sV4jUykkA=;
 b=IIol7cYyGK1+HhidaJtNyR7HzQT2pDIbmOkUluqZ2qf6rpgbvFS2ih7vdx40ogfJPJgwJE7fIukE9PZSZ1fALpV10ol3md4sajZslzDlpt7QGWcJbLdHzMz5esmKp3Gyaliqzk/GRe79H1bzZiqDjZBCycyN3FfTQ4R+lOGzB0s=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 14:40:21 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 14:40:21 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to
 support all BARs
Thread-Topic: [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to
 support all BARs
Thread-Index: AQHc2nrCXBDyz7M/P0aSSuPXEu6RErYKiFH1gB9rvBw=
Date: Mon, 1 Jun 2026 14:40:21 +0000
Message-ID: <SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260502212857.85677-1-Harish.Kasiviswanathan@amd.com>
 <20260502212857.85677-2-Harish.Kasiviswanathan@amd.com>
 <SJ2PR12MB8650A6133770E8AFA78BDC5E8C392@SJ2PR12MB8650.namprd12.prod.outlook.com>
In-Reply-To: <SJ2PR12MB8650A6133770E8AFA78BDC5E8C392@SJ2PR12MB8650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T14:40:20.411Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|IA1PR12MB8494:EE_
x-ms-office365-filtering-correlation-id: ec2ce31b-f32c-4139-0c02-08debfebb595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|8096899003|18002099003|6133799003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: nymOBxW+5wzqdAEl+JFVESXcx+SW+kZbPFH9Zq3srj5EqjU12+fOI1r5qjIY/lX+iMzBZ/slU4erBaoYtIzyZUu2qTdJFZtGis0FAkyQzgsKyvRyNTOlt/i19lDFGDjBAG+VChT/DgqPGJORUr5K2CRlsChaKMgD2L47AeR2EkgF/N6YyuidBjiJL7tEt8PwJlNKueCJyH7JIUBZSv2f3FUfmiJSWWF0uTVs0yyZbeNc4ee88LyLbXPMu6m3DQs//bx+ZaAk05hCkbpxMfLWPyXe2bTyLCILXtpF6mxPv5IA6bxh7CyuTj2/eu6ZaXrygTiQdg9BMDed0KdbY8QDUCcMY/RxWX/p74tGftTGzedwjDrbnPEH/RrPRbtaW/Wn63I/+LdkQ1B2U5PEdPYF2Heo0002aGWr/OzKc7bRQYeCCneMYqTto5Pf5mpgurBeXuvFSQGXF1tEEv7BK3njUsVM6mJY3/vxtIbGQrnb6ZKX66+nMzDjk36cZbYIgOoOg9Not7jGLuZY6OAV7FuYtZ2a/66HCcGhPU7Ry6MYEp5TaGyGlFrZDhz16LY7/eeF7uBO24ks7dgyS1WM0rGAQdABTiZ6Gx4DbPaK/5p0mZu8xy6I2z6jmyHPUnARBHPtnTHXP0mvakD0c4mAa/sWbMyYyxyID3zF/f+riZgklTeW7pP2VYpaoOrJVU5pJahnyGbQHo5g+yl4w3HDWlVDuXKz6nYp3v1ycYXoQ5fRW0iqb5vh0hbBU+sPZSYZOXC4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(8096899003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cal79CTjfYj5dJ2gcfr8tk5n4AWI1Gs07mv1zETg95vHojljOIKhPv3Q2kcO?=
 =?us-ascii?Q?51eKssBUrFnwKghTw+KFgoFik1udI7MciADd5U1FE/pQqDxqDOFYy6bZ7IbA?=
 =?us-ascii?Q?+VjRhW5efs8gsWGzZ5eplaA1lkMRzhPPREvKv2kGQiPYlA+fdYiteVHJOcSO?=
 =?us-ascii?Q?INYZNDnpP2QwXi3ReTu7vafHtYvQpuPYvwYfjcHHGVytrRC8JncQtBuqRbqP?=
 =?us-ascii?Q?XzTbrc+TShkwc4e0BUlpmS6uLY0bHDof2qCa4ksBHQLv6VNBQtHzieTfp5u8?=
 =?us-ascii?Q?A/00gjdpy7hZ97Wt5wtrPeMHFOFsxFKOb9AFqshTmLSlhjYgovxM/FEGb8lM?=
 =?us-ascii?Q?O2GZJh1SFH/95DICbjecVl5mpZTocuaIqw0mCxDXrcVNZqfIkwK1bz4BHbMl?=
 =?us-ascii?Q?QwLm41NUn4k2F+o34cwmeuBywCSINsQbRP7nDKUP/qP5WmgUabLJp7DBTRxV?=
 =?us-ascii?Q?fE3vlePuhrnj5M60PjaFB4zJ654WXSSEf07Vd+15TR/T9P6r5mo+qGncS/Kg?=
 =?us-ascii?Q?C0EB9sDIfVdIpQ95wjTv6YC6bk6pCyFca4QIDzSruo8Ga2ijJrgaImrFteTe?=
 =?us-ascii?Q?JAQvLY4l9TGj0xMk9DZ50+WllMkFCke7WTtZkMLg1Z9MaR5ARt0PBrWW7tXa?=
 =?us-ascii?Q?98HuKWdD0iN5ysjFz/NUjJVl5R/rM8qakC3qfZR7JbKv45+5T4h3Zs7ie9FK?=
 =?us-ascii?Q?u6p54aWqkTUeme8L4eYFV6OWNPW+lStCkOGoR3STNk++zKgXxXOJF8DoMMwV?=
 =?us-ascii?Q?QG//KlxL15JHsxh2vMCvGHjB7mTw1KZuzpkL3xK1Pmy6vL/je4yLoOtfduxY?=
 =?us-ascii?Q?Tvl7RUGwyCnBfyYBBJsbBIdtzWocflr9pcN5OHMzNg1TAkQFmpBpAKgOHWcF?=
 =?us-ascii?Q?YIC4OMouG2eLtPDC2is+ZhmZEF6bZF65cbUxX7ppntMvRC7XyqlGtSga5fpU?=
 =?us-ascii?Q?lzllygWg9IhYC9hwMLUJHqkUSv1LbHinmn+KJfB7+DbUBY73QrASeBY1rUnN?=
 =?us-ascii?Q?XnWojTI31kDqpxSqYPSF04A4M6wQVPPW7LDmwE3Iopsa2FSBYlyRDT0F7rkg?=
 =?us-ascii?Q?UwVDLNoe5GI72TTAGf7i2pmj6kL12YR72Jn1Kih+9HT258nPWGoDT4qbENnG?=
 =?us-ascii?Q?FvU4m0LfmsgMECvZTgGzDJCo8NhYrhzTjICIztzSP5n6mo1D3R8GJe0NqRy0?=
 =?us-ascii?Q?OGTavAs8hEndVG6UPRyBLISY6xl594M0awGC/GMIH819njDPsMExObGRSPhV?=
 =?us-ascii?Q?i0+PbB2yU2IlRPd0OQ4M8bs5b3+Fx1HHkJK8ju98e06joxuIacZCEgSAQbZW?=
 =?us-ascii?Q?zs4c3Bnl0k2Ts40zgsoy9AjDX/wkzqes/CJO4Wp9ObmD2gS7ApxqE+58zx8P?=
 =?us-ascii?Q?jU4w75BMkuXxSKhEdOF2csQ7RJTPKDyPlK+V5808EKrhHm652AldMgAx+1ZY?=
 =?us-ascii?Q?Y0pTKvlxUgRvkb5BPrxvmAV3zNoR5H09kRzBTiMor3H2CuHuOxGUUTYj5jNn?=
 =?us-ascii?Q?bPDJAPAV9kop5QZeba7ESm5m0BJAsu5cGe4qh9CU+swp7ixoQPtXZidwnMSF?=
 =?us-ascii?Q?+rZV/s00L78nFaXtAfLarjo72l0ne6OvXlO9qyWNHC0OTht4o6WvrMVkO7xm?=
 =?us-ascii?Q?ecFsGQkksMZQLa9z3x/HoQVtZHG9+rjyawwLEKYl03duaTb1fvo3n3Y9uMjd?=
 =?us-ascii?Q?ZSydldcjw9KFSwZEauR3K9PoIrc/+VQpmLiFXs5aHNilpj9G?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152SJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2ce31b-f32c-4139-0c02-08debfebb595
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 14:40:21.7286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJVcgHN0qOanB886IV1Zs5K0+UrijiFIJ8HOJ/KR6naLuDqeiXiEpMl67zBV03Lq4ZYDYs8iuiYwoGFfphtzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

--_000_SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152SJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Ping on this once more. Thanks.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kasivisw=
anathan, Harish <Harish.Kasiviswanathan@amd.com>
Sent: Tuesday, May 12, 2026 10:50 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to su=
pport all BARs

AMD General

Ping on this patch series. Thanks.
________________________________
From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Sent: Saturday, May 2, 2026 5:28 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to suppor=
t all BARs

amdgpu_device_is_peer_accessible was initially written to check peer
VRAM access, however, it is getting called for DOORBELL & MMIO range.
Add support for these also

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 77 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  2 +-
 4 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 6b9d103fbff1..b67d42d7f8a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1455,7 +1455,8 @@ enum amdgpu_pcie_bar {
 };

 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
-                                     struct amdgpu_device *peer_adev);
+                                     struct amdgpu_device *peer_adev,
+                                     enum amdgpu_pcie_bar pcie_bar);
 int amdgpu_device_baco_enter(struct amdgpu_device *adev);
 int amdgpu_device_baco_exit(struct amdgpu_device *adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7c01492e69dd..a9be242c6bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -900,8 +900,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, =
struct kgd_mem *mem,
              (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
                 if (mem->domain =3D=3D AMDGPU_GEM_DOMAIN_VRAM)
                         same_hive =3D amdgpu_xgmi_same_hive(adev, bo_adev)=
;
-               if (!same_hive && !amdgpu_device_is_peer_accessible(bo_adev=
, adev))
-                       return -EINVAL;
+               if (!same_hive) {
+                       int bar;
+
+                       if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOOR=
BELL)
+                               bar =3D AMDGPU_PCIE_BAR_DOORBELL;
+                       else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS=
_MMIO_REMAP)
+                               bar =3D AMDGPU_PCIE_BAR_MMIO;
+                       else
+                               bar =3D AMDGPU_PCIE_BAR_VRAM;
+
+                       if (!amdgpu_device_is_peer_accessible(bo_adev, adev=
, bar))
+                               return -EINVAL;
+               }
         }

         for (i =3D 0; i <=3D is_aql; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5c14fdbc1847..a5c1160cdd03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6185,36 +6185,83 @@ static void amdgpu_device_get_pcie_info(struct amdg=
pu_device *adev)
  *
  * @adev: amdgpu_device pointer
  * @peer_adev: amdgpu_device pointer for peer device trying to access @ade=
v
+ * @pcie_bar: PCIe BAR index to check accessibility for:
+ *            0 =3D VRAM aperture (BAR 0)
+ *            2 =3D Doorbell aperture (BAR 2)
+ *            5 =3D MMIO remap aperture (BAR 5)
+ *
+ * Return true if @peer_adev can access (DMA) @adev through the specified
+ * PCIe BAR. For VRAM (BAR 0), @adev must be "large BAR" and the BAR must
+ * match the DMA mask of @peer_adev. For doorbell and MMIO BARs, only the
+ * DMA addressability and P2P chipset support are checked.
+ *
+ * @note: CONFIG_HSA_AMD_P2P indicates support for P2P DMA mappings. Query
+ * P2PDMA distance only if the kernel has all the prerequisites for P2P DM=
A
+ * support. Otherwise fall back to the less reliable legacy P2P support to
+ * avoid regressions.
  *
- * Return true if @peer_adev can access (DMA) @adev through the PCIe
- * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
- * @peer_adev.
  */
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
-                                     struct amdgpu_device *peer_adev)
+                                     struct amdgpu_device *peer_adev,
+                                     enum amdgpu_pcie_bar pcie_bar)
 {
 #ifdef CONFIG_HSA_AMD_P2P
-       bool p2p_access =3D
-               !adev->gmc.xgmi.connected_to_cpu &&
+       bool p2p_access =3D true;
+       bool p2p_addressable =3D false;
+       resource_size_t bar_base =3D 0, bar_size =3D 0;
+
+       /* VRAM requires large BAR (full VRAM visible) for P2P access */
+       if (pcie_bar =3D=3D AMDGPU_PCIE_BAR_VRAM) {
+               if (!adev->gmc.visible_vram_size ||
+                   adev->gmc.real_vram_size !=3D adev->gmc.visible_vram_si=
ze)
+                       return false;
+
+               /* VRAM on CPU-connected xGMI devices is accessed via
+                * coherent fabric, not PCIe BAR P2P
+                */
+               if (adev->gmc.xgmi.connected_to_cpu)
+                       return false;
+       }
+
+       switch (pcie_bar) {
+       case AMDGPU_PCIE_BAR_DOORBELL:
+               bar_base =3D adev->doorbell.base;
+               bar_size =3D adev->doorbell.size;
+               break;
+       case AMDGPU_PCIE_BAR_MMIO:
+               bar_base =3D adev->rmmio_base;
+               bar_size =3D adev->rmmio_size;
+               break;
+       case AMDGPU_PCIE_BAR_VRAM:
+       default:
+               bar_base =3D adev->gmc.aper_base;
+               bar_size =3D adev->gmc.aper_size;
+               break;
+       }
+
+       if (!bar_base || !bar_size) {
+               dev_dbg(adev->dev, "Invalid BAR%d configuration for P2P acc=
ess\n",
+                       pcie_bar);
+               return false;
+       }
+
+       p2p_access =3D
                 !(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) <=
 0);
         if (!p2p_access)
                 dev_info(adev->dev, "PCIe P2P access from peer device %s i=
s not supported by the chipset\n",
                         pci_name(peer_adev->pdev));
-
-       bool is_large_bar =3D adev->gmc.visible_vram_size &&
-               adev->gmc.real_vram_size =3D=3D adev->gmc.visible_vram_size=
;
-       bool p2p_addressable =3D amdgpu_device_check_iommu_remap(peer_adev)=
;
+       p2p_addressable =3D amdgpu_device_check_iommu_remap(peer_adev);

         if (!p2p_addressable) {
                 uint64_t address_mask =3D peer_adev->dev->dma_mask ?
                         ~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
-               resource_size_t aper_limit =3D
-                       adev->gmc.aper_base + adev->gmc.aper_size - 1;
+               resource_size_t bar_limit =3D bar_base + bar_size - 1;

-               p2p_addressable =3D !(adev->gmc.aper_base & address_mask ||
-                                    aper_limit & address_mask);
+               p2p_addressable =3D !(bar_base & address_mask ||
+                                    bar_limit & address_mask);
         }
-       return pcie_p2p && is_large_bar && p2p_access && p2p_addressable;
+
+       return p2p_access && p2p_addressable;
 #else
         return false;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 4dc9f9aa3a2e..0b50a35b79a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1496,7 +1496,7 @@ static int kfd_add_peer_prop(struct kfd_topology_devi=
ce *kdev,

         if (!amdgpu_device_is_peer_accessible(
                                 kdev->gpu->adev,
-                               peer->gpu->adev))
+                               peer->gpu->adev, AMDGPU_PCIE_BAR_VRAM))
                 return ret;

         if (list_empty(&kdev->io_link_props))
--
2.43.0


--_000_SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152SJ2PR12MB8650namp_
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Ping on this once more. Thanks.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kasiviswanathan, Harish &lt;H=
arish.Kasiviswanathan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 12, 2026 10:50 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessibl=
e to support all BARs</font>
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
Ping on this patch series. Thanks.</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Kasiviswanathan, Ha=
rish &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
<b>Sent:</b> Saturday, May 2, 2026 5:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;<b=
r>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to=
 support all BARs</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">amdgpu_device_is_peer_accessible was initially w=
ritten to check peer<br>
VRAM access, however, it is getting called for DOORBELL &amp; MMIO range.<b=
r>
Add support for these also<br>
<br>
Signed-off-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt=
;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +-<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 15 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; | 77 +++=
++++++++++++----<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 +-<br>
&nbsp;4 files changed, 78 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 6b9d103fbff1..b67d42d7f8a7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1455,7 +1455,8 @@ enum amdgpu_pcie_bar {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_device *peer_adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_device *peer_adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum am=
dgpu_pcie_bar pcie_bar);<br>
&nbsp;int amdgpu_device_baco_enter(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_device_baco_exit(struct amdgpu_device *adev);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index 7c01492e69dd..a9be242c6bfa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -900,8 +900,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, =
struct kgd_mem *mem,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (mem-&gt;alloc_flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (mem-&gt;domain =3D=3D AMDGPU_GEM_DOMAIN_VRAM)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; same_=
hive =3D amdgpu_xgmi_same_hive(adev, bo_adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!same_hive &amp;&amp; !amdgpu_device_is_peer_accessible(bo_a=
dev, adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!same_hive) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int bar;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mem-&gt;allo=
c_flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar =3D AMDGPU_PCIE_BAR_DOORBELL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (mem-&gt=
;alloc_flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar =3D AMDGPU_PCIE_BAR_MMIO;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar =3D AMDGPU_PCIE_BAR_VRAM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_devi=
ce_is_peer_accessible(bo_adev, adev, bar))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt;=3D is=
_aql; i++) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 5c14fdbc1847..a5c1160cdd03 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -6185,36 +6185,83 @@ static void amdgpu_device_get_pcie_info(struct amdg=
pu_device *adev)<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
&nbsp; * @peer_adev: amdgpu_device pointer for peer device trying to access=
 @adev<br>
+ * @pcie_bar: PCIe BAR index to check accessibility for:<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =3D=
 VRAM aperture (BAR 0)<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 =3D=
 Doorbell aperture (BAR 2)<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 =3D=
 MMIO remap aperture (BAR 5)<br>
+ *<br>
+ * Return true if @peer_adev can access (DMA) @adev through the specified<=
br>
+ * PCIe BAR. For VRAM (BAR 0), @adev must be &quot;large BAR&quot; and the=
 BAR must<br>
+ * match the DMA mask of @peer_adev. For doorbell and MMIO BARs, only the<=
br>
+ * DMA addressability and P2P chipset support are checked.<br>
+ *<br>
+ * @note: CONFIG_HSA_AMD_P2P indicates support for P2P DMA mappings. Query=
<br>
+ * P2PDMA distance only if the kernel has all the prerequisites for P2P DM=
A<br>
+ * support. Otherwise fall back to the less reliable legacy P2P support to=
<br>
+ * avoid regressions.<br>
&nbsp; *<br>
- * Return true if @peer_adev can access (DMA) @adev through the PCIe<br>
- * BAR, i.e. @adev is &quot;large BAR&quot; and the BAR matches the DMA ma=
sk of<br>
- * @peer_adev.<br>
&nbsp; */<br>
&nbsp;bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_device *peer_adev)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_device *peer_adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum am=
dgpu_pcie_bar pcie_bar)<br>
&nbsp;{<br>
&nbsp;#ifdef CONFIG_HSA_AMD_P2P<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_access =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_access =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_addressable =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t bar_base =3D 0, bar_s=
ize =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VRAM requires large BAR (full VRAM=
 visible) for P2P access */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pcie_bar =3D=3D AMDGPU_PCIE_BAR_V=
RAM) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;gmc.visible_vram_size ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.real_vram_size !=3D adev-&g=
t;gmc.visible_vram_size)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* VRAM on CPU-connected xGMI devices is accessed via<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * coherent fabric, not PCIe BAR P2P<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (pcie_bar) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_DOORBELL:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bar_base =3D adev-&gt;doorbell.base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bar_size =3D adev-&gt;doorbell.size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_MMIO:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bar_base =3D adev-&gt;rmmio_base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bar_size =3D adev-&gt;rmmio_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_VRAM:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bar_base =3D adev-&gt;gmc.aper_base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bar_size =3D adev-&gt;gmc.aper_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bar_base || !bar_size) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Invalid BAR%d configuration for P2P =
access\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_bar);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2p_access =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; !(pci_p2pdma_distance(adev-&gt;pdev, peer_adev-&gt;de=
v, false) &lt; 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p2p_access)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;PCIe P2P access from pee=
r device %s is not supported by the chipset\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_n=
ame(peer_adev-&gt;pdev));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_large_bar =3D adev-&gt;gmc.vi=
sible_vram_size &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gmc.real_vram_size =3D=3D adev-&gt;gmc.visible_vram_siz=
e;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_addressable =3D amdgpu_devic=
e_check_iommu_remap(peer_adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2p_addressable =3D amdgpu_device_che=
ck_iommu_remap(peer_adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p2p_addressable) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t address_mask =3D peer_adev-&gt;dev-&gt;dma_m=
ask ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~*pee=
r_adev-&gt;dev-&gt;dma_mask : ~((1ULL &lt;&lt; 32) - 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; resource_size_t aper_limit =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.ape=
r_base + adev-&gt;gmc.aper_size - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; resource_size_t bar_limit =3D bar_base + bar_size - 1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; p2p_addressable =3D !(adev-&gt;gmc.aper_base &amp; address_mask =
||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aper_limit &a=
mp; address_mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; p2p_addressable =3D !(bar_base &amp; address_mask ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar_limit &am=
p; address_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pcie_p2p &amp;&amp; is_large_b=
ar &amp;&amp; p2p_access &amp;&amp; p2p_addressable;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p2p_access &amp;&amp; p2p_addr=
essable;<br>
&nbsp;#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c<br>
index 4dc9f9aa3a2e..0b50a35b79a5 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
@@ -1496,7 +1496,7 @@ static int kfd_add_peer_prop(struct kfd_topology_devi=
ce *kdev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_is_peer=
_accessible(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kdev-&gt;gpu-&gt;adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer-&gt;gpu-&gt;adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer-&gt;gpu-&gt;adev, AMDGPU_PCIE_BAR_VRAM=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;kdev-&=
gt;io_link_props))<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152SJ2PR12MB8650namp_--
