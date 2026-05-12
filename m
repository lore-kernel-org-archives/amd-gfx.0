Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA4CCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 14:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005A610E28E;
	Tue, 12 May 2026 14:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ac1un7QY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD2010E28E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 14:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmksIEdv5cE7Dx9eV2rxk7ebyC1bAxEOswtGXr3jUZoqxEhlcowetM7AHsimpT7eCalPP8OFRpQ5LT3Wu01RqqanTkGlKQrgyUKi3QwDLqbMKKH1ZZPYwrDXHcSuW8vR7a2Le0ykEHMXqMEPUsSSkjWu5bLVM9gVcftmGaXQza5q6XoCDNNO+4GzmtN/9dIRba4+k7QvBCtX6GGg1gmaOfVLbT7p/YsGeOCRxhj/V1ATTg8GZj8tkm3i4Ihb6pybW3vUFqcKt61A3V5Q1VXktq7z3+ttnCaNUW9/iQiyaYpQiNsKOW0NsWJblMZmeJixSY0jc/h24BEp5KnjmY3ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJnfrWrx4ojcgSWpUjjYevHKYL1BrwHnIw+/SOhemgE=;
 b=o+aEWuGfD3XWaHxFo3y+o0G4JMTuAq4wanX2kcBPzG7S5sZwi9CRoYalGQPBEZByXg3nnzwmIjoszVt7+WJpSJGpyuH6Uh2nHHWcvxO37msHenddkj5aSNGoNwEkBWlfMoQqXnHjlm286olqdUWjhmcFCFl/bUNotVArqW2pc8CbkS2tJc76Sb03xvfVActhdlY3d8Mk04tc3x5fvz1J2/xZaYhgPjgzay2xoKNoRR8zZ09M68ut1rgdTc8prELvr1L/XgEbcvgNKLaZy/Oos/ow7dyUgcgYRzGQivUl2Sf2Yk+jhyxm2Ohzrii84mBKltjKsomtnE82he3P3RcESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJnfrWrx4ojcgSWpUjjYevHKYL1BrwHnIw+/SOhemgE=;
 b=ac1un7QYvTtSbAV4ZANgB4mJ1lvrlc6edSBuIiSPBoqsmeu+vPLDDndWnyPcOpp9akNhhuHo4dfPyqeov3zMnl+y/9TGV+yy0nI7oLYedMyU4+jn6fngycjqs7HTWzJcKS2DDbsLxPBWsHb6SY7vSaUTRLAZV69u6vKirrL7k9M=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 14:50:28 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9891.019; Tue, 12 May 2026
 14:50:28 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to
 support all BARs
Thread-Topic: [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to
 support all BARs
Thread-Index: AQHc2nrCXBDyz7M/P0aSSuPXEu6RErYKiFH1
Date: Tue, 12 May 2026 14:50:28 +0000
Message-ID: <SJ2PR12MB8650A6133770E8AFA78BDC5E8C392@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260502212857.85677-1-Harish.Kasiviswanathan@amd.com>
 <20260502212857.85677-2-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20260502212857.85677-2-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-12T14:50:28.428Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|DM4PR12MB6040:EE_
x-ms-office365-filtering-correlation-id: f854bef9-19f5-4be9-78c6-08deb035ceed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info: PhC/e7GXDUBGN4tUPa1WxZWAkl1rq1BpsrTaf0qKLLupNRhJPVZDh2hoggB45BcQWLx1yx16ukh9OXP9nKM/xGS5hVe9lxI91eaSRMafGX1xL34mM5KiNuPva02Vaw9gZyvEGsVhX+foc+mAU2qAAYT6prJMQQueaQwVkuaCtTz9HxXIuMhJCz/FFuY2TCujKXrmrnuvOOp4mi24fcXOzjCQnddbBlIgMPF0UhfDdG0Y+4VRs4vU0joSICOKlyEYx4j80BVAtq8klcqEPomes1CqdWuuGjU/SyIYefWe4uMCZIofQJahBZk/hlp2x6J041zIBMWZMEMh/EdwDBbpeM5ELYLbui9RaSDKTZ9m4cjdY59TTDnN8syAbcUX+5YDzuzYtI0ATPxYAl4Og3FdUlw7CuJhMkaPeV1TQrwESoUG9LfpcP4iK9nogi9PNZaHkOLfC11kwJiPSwGVi+pFhuNN5ZXFg4ghRISAQH6ToiuBCNb/QnJvmyFTTp9kRydWbOCODBHDFdcupIXR8UzQ/eKidicSs0GXGhK4A7d3JQmR+8l563SEzytNg6L5JeKsG5dlMkmQDKwC4KQBjrl3iaIsiCQIKUn4STkqkTzDMH8DFdN9/7BydtKfH0bRs4+Bkvmt2ldnZXe/NO00ZcnZF9PcXzTeEKmPyCkHKvAWEBEOJWP/wrrKbfHqtanJN4sHFOMfpo8hN6sRtyQkymfMcAV63uTGTkdSU4X13dE10sQ8NyOD4J5lFRfl0AD6Kcqy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T1Uq3/2mYEM3qGMdxjlkZ0RVpyJrPIoQ/DtLCoo8dPEj5lZm8SVGxp5UkEGp?=
 =?us-ascii?Q?tBP3ptojwFHuEP7nPUovLXSqBMLi1C3xkj6Q16ukBJNqerNc1Wk81uqnYWNo?=
 =?us-ascii?Q?ZN6IuodNtkHg9zO01IamceLIHAzrA2QfuzvKPJ3AlmQu42hVH6Iw/Prv7oNb?=
 =?us-ascii?Q?aGRlgIST8ZAdyJUOgHuDfrYuywzKSZiFUih1ZDYTtLEgd5r1tdrF3fbyIIQy?=
 =?us-ascii?Q?Oec051iTx5F5LiBgcXzONDrjC1gm4YRcI0huilG6FGl8jULjpn51H7BRTre8?=
 =?us-ascii?Q?fC7l6vHfnDqU3gC8ebBSLOJj68EL5FHnAD2oEpjtmxuyFHBrLtWpjhilba0s?=
 =?us-ascii?Q?CjhbQd6rPfWmd7mdljLTVlaIutY7LNzSqhaJFcbD0rmUTnIGL+wIxo10O2yv?=
 =?us-ascii?Q?48IyGznj3BQpWMRET5qzxFbCsv7SqoJsZORMsRK6ebOFplRwWuNRHknhnmW2?=
 =?us-ascii?Q?ST4XGW8agMVWQj6g5fZ5SW/NLRfdCtyRqf4xQoiHm8aErAGgyvmg0zDHxG+D?=
 =?us-ascii?Q?Qm9jxH1vOvdUK3V3EsM3EOteYlRLVJ8fbtcLleDI9H/I+S871wIegn0BALrk?=
 =?us-ascii?Q?AtNhdmbRF5o5k5l9bUeGekWMmvLUA6qoXm2M7rSJtbjShs4aHWLAp8YJZ4iV?=
 =?us-ascii?Q?lXc6akOzE0b1fzOQit39U/MNLefpmg3ENVwxQ05tZR5twxlb+hcA1F2W9MEP?=
 =?us-ascii?Q?JMs8GH217ySNN78IVWc+TYdzOuw5CPDQBlxmsdTgvK7Y5pahv00BqQxrbXK3?=
 =?us-ascii?Q?ZozqnPXUMhRKwgXEiQlY9DtAIeX96Wy0vTT0TpvuNlrOvCTR0i3mWgRl2Fk5?=
 =?us-ascii?Q?NWQT2TQ0s7yVni6lLBhkEOJauBTO8W2OkPjjDnU0XNChCd/Lf9WD6V2/qZSn?=
 =?us-ascii?Q?esEb1GCBTXxJcH4XzHPHbMga+r/QQ3zRb1u1NrqTPTMFRfmD2UnLNVH15Yhc?=
 =?us-ascii?Q?rkx9dlyxLmG22D6Lwp/TVh8aRtSjwIDBIZ6qHUUJ+IHlChFAabVZwhVqM9k+?=
 =?us-ascii?Q?pA9S5GsCKwPYF0rNVEAe4VJmEONPqTUSwIJfzY2TVBdchZqObMiGbx4w2nuW?=
 =?us-ascii?Q?yA8qdzX7zl1M4yQTgzrrFhIqzaF17D7P7OZeFYAhb9lzRiRdLBnMhn/yYYOf?=
 =?us-ascii?Q?z/8ZzMSF+GDCTE7QwSnbGl6RJuBfrJ3RJLFmY7YBOhKwvmQWAynA1bj4ge+9?=
 =?us-ascii?Q?LsU+CzdLFMWoiKBLeDKFvelp7G1tFyFoLJVsRQCC0NTj4nSnScoGZMjyI3Vq?=
 =?us-ascii?Q?/352X+S4PzQyfSJBnzWpxQ+TEG5UqNFrOfagJ6+pr4v/YhdYv+ZxroBo5eaT?=
 =?us-ascii?Q?ZRMTP11Jx3Wd5IvJBnLY5xSOsPxJ5+amlKftgKk4D/rGYB6hQdCJIMNECR4u?=
 =?us-ascii?Q?cNxoEfEWZ3KQj3k72X6o2XDCnXXDTdXt1ruWQRqglWZ3Ru6MmefZqLUafL2u?=
 =?us-ascii?Q?lUaFvrc7j6aTOm/064OI7pyqqcXb/bzJsE1XdCFOvQDpwxzIfFGc4ZMDSyyY?=
 =?us-ascii?Q?i5ESEDr4m+fto6ZIqWNXapDkzFSK1M6dmcdnmCwgyOSY3dMrq5LxQIoTTJUg?=
 =?us-ascii?Q?UJv7n8JpcaGcD+KMxE74t97hjui5jinQ8aCCEgHbhNptmlrakCsFG5p2vHma?=
 =?us-ascii?Q?N9itYMQ+H26KANmoUHBHfmwdnbgDPtcSwKzajjc9R2RqSr7k1t7a8mvZfhhB?=
 =?us-ascii?Q?RQIOL3QX8ZFpBDONeGxvEDYSi9ia5/cVq3znuTk9xGSQQMEA?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB8650A6133770E8AFA78BDC5E8C392SJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f854bef9-19f5-4be9-78c6-08deb035ceed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 14:50:28.4154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pnbf+DphYP98nuAj4TuDIYaOxruWXbkwOihsUgWazNzX62Oi1X3wiOVDXSatQ4/WbO5GPOjqkRP1mlqw+lAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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

--_000_SJ2PR12MB8650A6133770E8AFA78BDC5E8C392SJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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


--_000_SJ2PR12MB8650A6133770E8AFA78BDC5E8C392SJ2PR12MB8650namp_
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
Ping on this patch series. Thanks.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kasiviswanathan, Hari=
sh &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
<b>Sent:</b> Saturday, May 2, 2026 5:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;<b=
r>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to=
 support all BARs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">amdgpu_device_is_peer_accessible was initially wri=
tten to check peer<br>
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
</body>
</html>

--_000_SJ2PR12MB8650A6133770E8AFA78BDC5E8C392SJ2PR12MB8650namp_--
