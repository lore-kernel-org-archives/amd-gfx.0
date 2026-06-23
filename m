Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D70CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 04:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC3610E931;
	Tue, 23 Jun 2026 04:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vioxm26u";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095CC10E931
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 04:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgyBCC0TYAm20fOd5wPo/qzOLEYJYRJEGmzdcBFKFRsZvIbmvubFe0EiP4BgciPJ6ZA6iN+KgtnWydhQLSfvbh9z803bVxW94ZIdAA+p+r2OexvVNTqC2q9FdQWCNqJPcN7SFE3qg07XXYOaFhYigp7wcQ1Ykmec5yH3KW5aa0WPt7Cyg3+GjDJXOwQdVVxYxPE3xle81itXxfKY9f+qAba4IU8M2BlrftzyTiJCL/y7dpMijtDwzPZwqb+SKTnZbVur11R8XGtWQFgNhJnyh8zE9dJxmBkEDcX4uQdDHCLMiJPIDz4l6SoNAPiSnObvSLNo6RQqvHJyqR+6RKAcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws3So9JB0T0aymezmxpmsI4yoLKbkeBsL1RbdnMtaFI=;
 b=uksodNlNCyGbQstL66fSszE/rOhchu7lf3/uR/ZF1KSAXeqeQ5DcspOZRPskGydZYZ4XdjjCTeV4X19oV6ZfwebsWz6AsrkJ/i/FpNO+p0FkCTV5Q3MnWxXToUp0HQui8CH86kT650Ih8W+LDbeMti+14WF71ZzxNHnm0qFMTE2klfMO/x+LXkjUSJeAMiwDSED3MuUwjtoPVZ38GBOXnPuH5RuGgX7CIBX+badtb17iSy74KhTot6I5m6AKFeEol1D76zRnhnChxCP6aoETkPdC1ZDfVcawjk9rO/+Oqdmfsf9DOoe/T9dFzLjr5ZTvpA0GsgDGbofEDwnBRhPVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws3So9JB0T0aymezmxpmsI4yoLKbkeBsL1RbdnMtaFI=;
 b=vioxm26ufFLMsMR92yuc3QzF3sLRMkAQeDW6RpfoUdPucqIN66q5rzjTYUwrPmmzzHJOtNo10GXljjVKMNtdqZU+Hn9pFQ0vC45dUijGxNe41W6HGmgzcnoXq1lTEGGrgpgKGnzRyA+ypZQhWBI4ZHbQwqV+QBnveokDGRlKFGc=
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 04:34:25 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 04:34:25 +0000
From: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into create
 and map helpers
Thread-Topic: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into create
 and map helpers
Thread-Index: AQHc/iY9numL1Kfvl0mNWMfkSpb0j7ZLls/A
Date: Tue, 23 Jun 2026 04:34:25 +0000
Message-ID: <CH2PR12MB9457099AA2A66864571315CD8CEE2@CH2PR12MB9457.namprd12.prod.outlook.com>
References: <20260617065442.16432-1-lingshan.zhu@amd.com>
In-Reply-To: <20260617065442.16432-1-lingshan.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T04:34:18.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9457:EE_|DM4PR12MB6350:EE_
x-ms-office365-filtering-correlation-id: 7767d7c8-9c8f-4570-6b03-08ded0e0b4ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|22082099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info: A+iJkVpRXnZaHWjFZj/fCWyMQB1KF+giDr9bPS38EK5OwT6Jaf7U1NE5P6ZrOiAmcy8Ems39bZ+sWtDr8a1hWLVItV+WNzueTP1kaboSIpyKJdLNlghRh43DHSrP2FBvkj6LphqhFYJ5wxe/kCGiH7UsZGHGO9uD7SjHT+XWt3Y7Q957qDz+ZtnBRSrO1IjAIdGdTuhAECOuUVR9mjIhHXVY3oOwIjNOo7MSyTUc6r7mSp0r47frRJ9Y56NjflDZYJc09m9y8D6jw+ZAX+54VZ6Hj9V2AJkmSV00yhan0NinWtpxnpxO4RVOzahs/veTKhGz+Mp3N/wE5XolaMSJjREsPmXtiG3hF0jdt1LlZDyhSN72IPGUg7HF6VSK+cYMZww2FwyIEwtD7wbfpvmcvKFDktnHyaqJBms+sq7asXLubcjzZTi3gR4BCv7pZfHJzPy72TgomJT/sLna16GNTQqKJkRVh/4sLcEcG25XN6FAHQLeZyCQFlrHXZ0D39/es6SBgs/NeCegQQT10WXb2sPykiikmQlWzJ8TMD4X7fejZLEU5OfjlzFN5e8/m+hLi3ym9gyEUoqrjaQPbtQiZpQEpGqXBpeiozC6ExOlja+/aQZg5yt9okNh9mxDNjtkYqxcURGBxRKCdo+XyTVTtdVNeuJ09ZkLBhOVokuhPJe9J2CD+2JmI+mypw4YUvcYkANNDc2aG6jzjRjuVKZauSVQpZleratcm8i+PRFO334=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LODp3/v+glq1iZUClo9gkqTsHTMfXSJBabIIcDavMmem9LEpJ6Moels9psRG?=
 =?us-ascii?Q?c6VDaAC6bP6lpu5q6ds5YNbL59KFlVCYxtJ2RRcmUnzAu+Yrl61fSEUJJ78Z?=
 =?us-ascii?Q?EIiyXzQn9IJD1WThicbF6Kq7f9YMXzTQ5BiqxbbIWbiQDG64NFJxaPpkN/c4?=
 =?us-ascii?Q?CRSwzJwNqmI202I38kiZv85eJ1zgWmV/m0zHVjrXjuZFz8vNs64FFEUfwm7+?=
 =?us-ascii?Q?IxIiaHk8JPSksTgxAcc3ShSJ8KA2LipSfRsirFXAYtCKE6qcsNG7XlWFn+KL?=
 =?us-ascii?Q?RJ5yDm/thbvOcR6RboJule7iygmLnzJoJbhmjX0jgA+iKJPS+PY0hLajS/bg?=
 =?us-ascii?Q?2VuIrSefBkcwbN+NGd5T6ZTpNWdb/ub4mXeK083RQcXFNvQsPV9Nl+E4XopJ?=
 =?us-ascii?Q?KorydDDIUI0BTQIqJGDTVsz0Fu4CXnM76r9M85P1w5iSJdZb2+iiLGAFxSg3?=
 =?us-ascii?Q?AZ5JpvY4joy4aFLMPITCKRnOtDGvlEKmOyKmr5ssU/pHEY00tBgfaCgaqNgR?=
 =?us-ascii?Q?R697MJJHmTq1kyMaAQrz4EodmDdBYCgGv/Rp4vDZvyoMJaj9zd2hFc2aL9rL?=
 =?us-ascii?Q?qW6hGJNwGcyrcsg43jaf1aNhjGF5Nz7lXDZEG2vfNLEX66gbuBBBDt9x0Ny0?=
 =?us-ascii?Q?SaXPFltuWW6zDUDXzWQTC4iX7MHdHgdEyct940EfCWg+Wg1FsuNbK/qOeiTp?=
 =?us-ascii?Q?JSPZ23xx5CRXjFdU4Df681huH63HM1fPG10B0jF45CSL5OdUahd1mfg7zDUs?=
 =?us-ascii?Q?JgjRhonMI9ZKHZS0hGPjwSDpqy3x6Z2xlC66Ukl+b1AitYixPBsnf7mX1hfR?=
 =?us-ascii?Q?KxQ+FSIvy/E/ZCB9LhdGemE0SrZROf4YMdAicti0cT7Gr4CbwwjPG3VzqRY7?=
 =?us-ascii?Q?pYGguvX8nYv3Wd6ANeAJs6y6435hXwZGDCtVmds5tKMtrrzp6JnZukAtUwo/?=
 =?us-ascii?Q?lrpfjyWExbCcXDjB2XpzJehiTjm1zB7FbGCu7lU+XUhf1BuvW6QB30X41LZq?=
 =?us-ascii?Q?27zZX3Tok2mOCxG8SQ0RrFiTlxxI6Sx2JSYr8UZh2qdcyexArfGR8PgOYO2l?=
 =?us-ascii?Q?IpUqcGCoMq90ByRYw3K9OPujMT3RJ0jUaQ7fk0173IUIT+x8cx1HdT2A/kPk?=
 =?us-ascii?Q?pc7WqsGw0W0G4xH1+skZFWhHsfZXCIfgIm15Crrr6/r2OSiW/J7/pKTz1zE1?=
 =?us-ascii?Q?dPSbLIoeKLfjX3c64G3TMzYQ7/KRJ0filXwOGiQm5ijTlXTDnrlJ1+Oe0uJt?=
 =?us-ascii?Q?P6K/9nty8OnxLZXlHwQjU0+mbCK3nBeZ+PmzLJiJmdvvp65EEkaOGTUUXFJt?=
 =?us-ascii?Q?NBkLZbUVVu5DrPN7ZrUV8Yaw3tb3xJe1BFRINVK7zcgPjuFPsgxFHg3C+RaQ?=
 =?us-ascii?Q?tSLv5UQUs9mLCW3NC82C+LV8nzD2i6C8zmWeKv/FKc3FNkty6xEn5reGCrc4?=
 =?us-ascii?Q?Ur9O95YulLaHErCK7ij2QTHjwtlJSfFdsgfwRNoiRzQRFrILii9KiJJ2frGp?=
 =?us-ascii?Q?wZo8/LKGZNyDvvMnied9fKzliHRqRcnnlzwwojDWjNoIoPbF538cXlWpKi3i?=
 =?us-ascii?Q?7hZX4/NTYNFzBZ2FBaLN4P3sG9K3xrbNVXxxWdUcDYl0yrvyQ2X7OthaOP9J?=
 =?us-ascii?Q?UraY1ipNhH73lXa6zsGI2MqpDW/wc/Y1oGwVibEJV0Oa9rvhwyWIAT70Wl22?=
 =?us-ascii?Q?a4e3MzHI4YS7jL1/APxcFWz2OHE583MWjqX+INV3xsJ0yrcj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7767d7c8-9c8f-4570-6b03-08ded0e0b4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 04:34:25.6271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcIVhCFB7+aw7Iw/wjNVoa1lzZXar/AsVvb7cE/sV5zTBHvwXOktTAVubzyZGHhKRWzBqwLgWnBYvMViK7uirQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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

ping

-----Original Message-----
From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
Sent: Wednesday, June 17, 2026 2:55 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>; Zhu, Lin=
gshan <Lingshan.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into create an=
d map helpers

amdgpu_bo_create_reserved() only allocates a new BO when *bo_ptr (struct am=
dgpu_bo **bo_ptr as input parameter) is NULL, it simply skips creation when=
 *bo_ptr is non-NULL.
But it unconditionally reserves, pins, gart allocates and maps the BO after=
wards.

When the same non-NULL BO pointer is passed in again, for example firmware =
buffers that live in adev and are re-loaded on every resume / cp_resume / s=
tart under AMDGPU_FW_LOAD_DIRECT, amdgpu_bo_pin() just increases pin_count =
unconditionally, however the matching teardown only unpins once, so pin_cou=
nt never drops to zero, so TTM is not able to move, swap or evict a BO, cau=
sing BO leaks.

Ideally the BO should only be pinned once at creation. So this commit split=
s current amdgpu_bo_create_reserved() into two helpers:

 - amdgpu_bo_create_pinned(): create + reserve + pin + alloc_gart and
   return the BO unreserved. It requires *bo_ptr =3D=3D NULL on entry,
   so only pins the BO once.

 - amdgpu_bo_get_access(): reserve + map gpu/cpu addr + unreserve.
   This function is idempotent and is safe to call multiple times
   on an existing pinned BO, for example, on every resume path.

amdgpu_bo_create_reserved() now calls amdgpu_bo_create_pinned() only when *=
bo_ptr is NULL, then calls amdgpu_bo_get_access() for CPU/GPU address mappi=
ng, and reserves the BO before returning.
Repeated calls no longer take additional pin references.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 175 +++++++++++++++++----
 1 file changed, 143 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 4dd7c712b8c3..dd0a59137028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -217,57 +217,53 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo=
 *abo, u32 domain)  }

 /**
- * amdgpu_bo_create_reserved - create reserved BO for kernel use
+ * amdgpu_bo_create_pinned - create and pin a BO for kernel use
  *
  * @adev: amdgpu device object
  * @size: size for the new BO
  * @align: alignment for the new BO
  * @domain: where to place it
- * @bo_ptr: used to initialize BOs in structures
- * @gpu_addr: GPU addr of the pinned BO
- * @cpu_addr: optional CPU address mapping
+ * @bo_ptr: used to return the newly created BO, must point to NULL on
+ entry
+ * @cpu_access: true if the BO needs to be CPU accessible
  *
- * Allocates and pins a BO for kernel internal use, and returns it still
- * reserved.
+ * Allocates and pins a BO for kernel internal use, and returns it
+ unreserved
  *
- * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
+ * Note: *bo_ptr must be NULL on entry, this helper always creates
+ * a new BO and never reuses an existing one,
+ * so it never pins the same BO twice.
  *
  * Returns:
  * 0 on success, negative error code otherwise.
  */
-int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
-                             unsigned long size, int align,
-                             u32 domain, struct amdgpu_bo **bo_ptr,
-                             u64 *gpu_addr, void **cpu_addr)
+static int amdgpu_bo_create_pinned(struct amdgpu_device *adev,
+                                  unsigned long size, int align,
+                                  u32 domain, struct amdgpu_bo **bo_ptr,
+                                  bool cpu_access)
 {
        struct amdgpu_bo_param bp;
-       bool free =3D false;
        int r;

-       if (!size) {
-               amdgpu_bo_unref(bo_ptr);
-               return 0;
-       }
+       if (WARN_ON(!bo_ptr || *bo_ptr))
+               return -EINVAL;
+
+       if (WARN_ON(!size))
+               return -EINVAL;

        memset(&bp, 0, sizeof(bp));
        bp.size =3D size;
        bp.byte_align =3D align;
        bp.domain =3D domain;
-       bp.flags =3D cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
+       bp.flags =3D cpu_access ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
                : AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
        bp.flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
        bp.type =3D ttm_bo_type_kernel;
        bp.resv =3D NULL;
        bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);

-       if (!*bo_ptr) {
-               r =3D amdgpu_bo_create(adev, &bp, bo_ptr);
-               if (r) {
-                       dev_err(adev->dev, "(%d) failed to allocate kernel =
bo\n",
-                               r);
-                       return r;
-               }
-               free =3D true;
+       r =3D amdgpu_bo_create(adev, &bp, bo_ptr);
+       if (r) {
+               dev_err(adev->dev, "(%d) failed to allocate kernel bo\n", r=
);
+               return r;
        }

        r =3D amdgpu_bo_reserve(*bo_ptr, false); @@ -288,27 +284,142 @@ int=
 amdgpu_bo_create_reserved(struct amdgpu_device *adev,
                goto error_unpin;
        }

+       amdgpu_bo_unreserve(*bo_ptr);
+       return 0;
+
+error_unpin:
+       amdgpu_bo_unpin(*bo_ptr);
+error_unreserve:
+       amdgpu_bo_unreserve(*bo_ptr);
+error_free:
+       amdgpu_bo_unref(bo_ptr);
+       return r;
+}
+
+/**
+ * amdgpu_bo_get_access - get CPU/GPU access to a BO
+ *
+ * @bo: the input BO, must be pinned
+ * @gpu_addr: optional, returns the GPU address of the BO
+ * @cpu_addr: optional, returns the CPU address of the BO
+ *
+ * Note: *bo must be already pinned!
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+static int amdgpu_bo_get_access(struct amdgpu_bo *bo, u64 *gpu_addr,
+                               void **cpu_addr)
+{
+       struct amdgpu_device *adev;
+       int r;
+
+       if (WARN_ON(!bo))
+               return -EINVAL;
+
+       adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
+
+       r =3D amdgpu_bo_reserve(bo, false);
+       if (r) {
+               dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r)=
;
+               return r;
+       }
+
+       /*
+        * The BO must already be pinned. A GPU or CPU address of an
+        * unpinned BO would become meaningless because TTM
+        * may then move or evict it at any time.
+        */
+       if (WARN_ON_ONCE(!bo->tbo.pin_count)) {
+               r =3D -EINVAL;
+               goto error_unreserve;
+       }
+
        if (gpu_addr)
-               *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);
+               *gpu_addr =3D amdgpu_bo_gpu_offset(bo);

        if (cpu_addr) {
-               r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);
+               r =3D amdgpu_bo_kmap(bo, cpu_addr);
                if (r) {
                        dev_err(adev->dev, "(%d) kernel bo map failed\n", r=
);
-                       goto error_unpin;
+                       goto error_unreserve;
                }
        }

+       amdgpu_bo_unreserve(bo);
        return 0;

-error_unpin:
-       amdgpu_bo_unpin(*bo_ptr);
 error_unreserve:
-       amdgpu_bo_unreserve(*bo_ptr);
+       amdgpu_bo_unreserve(bo);
+       return r;
+}
+
+/**
+ * amdgpu_bo_create_reserved - create reserved BO for kernel use
+ *
+ * @adev: amdgpu device object
+ * @size: size for the new BO
+ * @align: alignment for the new BO
+ * @domain: where to place it
+ * @bo_ptr: used to initialize BOs in structures
+ * @gpu_addr: GPU addr of the pinned BO
+ * @cpu_addr: optional CPU address mapping
+ *
+ * Allocates and pins a BO for kernel internal use, and returns it
+still
+ * reserved.
+ *
+ * Note: For bo_ptr new BO is only created if bo_ptr points to NULL. An
+ * existing BO is only re-accessed (get CPU/GPU mapping) and not pinned
+again,
+ * so repeated calls with the same BO do not leak pin references.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
+                             unsigned long size, int align,
+                             u32 domain, struct amdgpu_bo **bo_ptr,
+                             u64 *gpu_addr, void **cpu_addr) {
+       bool created =3D false;
+       int r;
+
+       if (WARN_ON(!bo_ptr))
+               return -EINVAL;
+
+       if (!size) {
+               amdgpu_bo_unref(bo_ptr);
+               return 0;
+       }
+
+       if (!*bo_ptr) {
+               r =3D amdgpu_bo_create_pinned(adev, size, align, domain, bo=
_ptr,
+                                           !!cpu_addr);
+               if (r)
+                       return r;
+               created =3D true;
+       }
+
+       r =3D amdgpu_bo_get_access(*bo_ptr, gpu_addr, cpu_addr);
+       if (r)
+               goto error_free;
+
+       r =3D amdgpu_bo_reserve(*bo_ptr, false);
+       if (r) {
+               dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r)=
;
+               goto error_free;
+       }
+
+       return 0;

 error_free:
-       if (free)
+       if (created) {
+               if (amdgpu_bo_reserve(*bo_ptr, true) =3D=3D 0) {
+                       amdgpu_bo_kunmap(*bo_ptr);
+                       amdgpu_bo_unpin(*bo_ptr);
+                       amdgpu_bo_unreserve(*bo_ptr);
+               }
                amdgpu_bo_unref(bo_ptr);
+       }

        return r;
 }
--
2.54.0

