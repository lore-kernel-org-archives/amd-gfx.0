Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802ACC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 04:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 031D310E2E2;
	Wed,  1 Jul 2026 04:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+aVi7Tf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2E910E2E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 04:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7QFNUfq6wTLqEjvWxC4L+DAqf1a1+GI25R4CJaANa+KATfrzqBAVWvZxHwWUKAn0YALx3L5Qhh3ZuVhRfziaxdBj17UPT1N5PCOlgzqq3OAOV/IDsugUuXljnw8cFmWGdED+GTe0YSq0v5ojBh04GgtAGZEeXCF5w4btJGjaOKBrjgcV7oqv56LgdpXzTRGPVuqg8hIljR8uuS0LCJQqKfNRt+m3eH8v5GZyRWwRtnvTVwXa2cOdEfEZt+stFW0y9I2sbkfad5GT2NdoLTVjkjIhFlPH6k+uLQlhDLjtGdOR4suq6Y32W5U/Ba7PwOngNn/WYnIoM9fBubNNz06nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdjAw6dM359Nb5JIx4VcvJivQCsl6/wZw+qFz1ck2qE=;
 b=F4sOlgWdWqxXuC8CuCTuv5h6XfPEx3G5KVcMdSZZlZPwmpVA0Q6qWobR/avm4ofMWuHzBBEFSsca/opfhAvd7MDTNYQN2fBjBm6RT7q1jrICip7enKjGMGxzJTmf+gHAttR2Mg1AHDgnCWNx8jrRGFJj4FXkaXLEoTpXOC/qgHX+xyzXu7+/AIx+SwMW6EHobaXe/yeCyTGYsT+y5syt2uabxnJ2Y9D938/CcRoxf6Gfg77Y/UAgN2mO7/Rm+tzF85NRAojYcosxL0K58dnTit+GzcIhn0Fcgq8qm/ScQreRVFY2ozcerUf8ku05PS8Q6CXKnuXBFUDitmtYV6CUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdjAw6dM359Nb5JIx4VcvJivQCsl6/wZw+qFz1ck2qE=;
 b=w+aVi7TfLmujWaglj0LXzK3Csf1C4hmthZ3pRZO19a4QBlsTC/CrHn0iMHWBBORtjlALNyBd58mtk2GzuOKNAeOCrfsfcraEoOuSfQB5qBZc63jv/043RJXZkOuc5dAza3KKPji9pd3Gtibav1AE1RUCw7LwdOz3rJB7Gg+yu8A=
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 04:09:07 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 04:09:06 +0000
From: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into create
 and map helpers
Thread-Topic: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into create
 and map helpers
Thread-Index: AQHc/iY9numL1Kfvl0mNWMfkSpb0j7ZLls/AgAyLVyA=
Date: Wed, 1 Jul 2026 04:09:06 +0000
Message-ID: <CH2PR12MB945788F022C612C89E54779A8CF62@CH2PR12MB9457.namprd12.prod.outlook.com>
References: <20260617065442.16432-1-lingshan.zhu@amd.com>
 <CH2PR12MB9457099AA2A66864571315CD8CEE2@CH2PR12MB9457.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB9457099AA2A66864571315CD8CEE2@CH2PR12MB9457.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: CH2PR12MB9457:EE_|PH7PR12MB7161:EE_
x-ms-office365-filtering-correlation-id: f1d806e7-4685-4107-30f2-08ded7267eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: TPflhjdYJD+nedFwQ/Rqj+fvTCg2VWLcxt6mdVRSDa9gmWmkCZNXsEfl7v3+SBZjM7oUWXTN9X7OOGchdm+P7tDKpuKW2ZIloeK9wOKDC3idq6/u419Gi4/AEb4Yx1yYyY1rD6dEva8EnpphI/wPiS7vkxGP+PbhMtvcrxjmGj8GHTT85F+nclBen4o0sUJ5wXLJ5dc3DXWGQmG2K4S2DTXaj6IdO7/dCM8Q1p1HGlEyXhOn+UjoIj6f1V4AuHGNb/+wa2Oe5sgerxT6ztDB/+9+HUlmw1NpnEuBTHpvt3zdcVP29gUYerFVHzcqnS5+SCcDl2b3Zj7GCObY39FlZWbfphNtXAYPMf/Rm9zX7TuxhF3hkHgyLaPGtnCTlaBwJQO/Hkruq9RAbFj1WQo0orh8LBvqPNrOs6+22mTDV9+K1no4iQ3Gf6Xv9RW2ykLxjcaUvFtQpNieRFMWV1Daj/4BZwG5XZGJFlOv3smf9Q8Kztb9blicuieCFdhx2zuoGzI1CdadcnTRB6RaXdH2TRfQPWUf7qnQUrevwhqQo3ge7yBEId9R1yoY7y1APKQUhPBkTnQCTThCQvESmQNGQIipVlt5YKvAzYkxHH3Yu16SVONOUJ35uv8K+uMj2PAaz6A+/p07i4Yrc8T3ORIeHE8k9h9KgD/artNKd1tEF/tfJyHnIkTSNShf8W81AQNDDFkWReDn8x0Oc3TWDpNo0XK40LhrXlNDlDEpymfoFGQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QK5LjFRWr9kG2F+kcXRhgi2KRIak3n7XyiAiKuT5GPNteZFvyI84Jh51P6o/?=
 =?us-ascii?Q?yNY106n6UQWDjvTzA1ufNYxvU+Xk8zC/+7lmE3BrwTWi7Mk89bqRWgCF5Eq3?=
 =?us-ascii?Q?9Rh8b+BzerFPnqeXFoBytfgxO5mXNz0Gtxel3qjXGX+oJmgbCNjbjDi/px3b?=
 =?us-ascii?Q?6Nc2fhdch3rhNY0SPuKYAkkTUKduRv3eXZFVYuL1i1HYtNJ3YD3FJDvzrAHj?=
 =?us-ascii?Q?VIIZXV92laj2HaBuszfFDJ5HpaWOHPyFWFXwE98cD6at4iKVXDDraG0lYHny?=
 =?us-ascii?Q?V2ZHfOI/5bR6cJlUvO0LHEcTaJ9rMTPxwzwFj7nhHR3Bp3p/HpTf6MPgCdKj?=
 =?us-ascii?Q?jQSikzzxUrGq8+2LZoVs4S7T6NvmVm81wGezCE6TCLb9Hcnfo8+1RthRytfv?=
 =?us-ascii?Q?Y2t6OuwsUoICjDYxchpXlR4EeJLGlRNdhD4Zty2di20faRSA9DAWvP3SF0Un?=
 =?us-ascii?Q?6s2TEiiP3XYkru0xy6sIEUZoRes9Bep115cUVctNqH8jo/obt2b/L6lpxnT9?=
 =?us-ascii?Q?64wu74lVeZN7a1Om0Qvne1rDtTmPkianWRI/4M7KDSrnlmIOFeLPA2jrWsR7?=
 =?us-ascii?Q?IwWQ2bdzpMPiPu0kNpLIafi2jHmMmaWhNHCxGR3xCG7ogkffMxFNXj0UzH35?=
 =?us-ascii?Q?fhQ7BqWJFIgdnpxd3zSacGvemeUlbY9v0pEpJNmDU3qHc/A6VPV5xNK/nueP?=
 =?us-ascii?Q?JsLT0+s/O4qsFl14IvekLEbtelnS6ZPxiqfdToSx2OjHgKFnCfVrWyS3UfB7?=
 =?us-ascii?Q?LKZDmpBcxv8g4JHLGeqVhvlXRXYs/jDHjDo9j0deGTBiqJMA5v/u+W9rCMcU?=
 =?us-ascii?Q?Xmil8gsV9MMXBYqEoGZH5dX8/qQDD/Isia/0uOPPcVrZ/EpYejS7aO7FvqXS?=
 =?us-ascii?Q?2rYXnFe9MCE/X/zI7Vt22UNxUhDaSELkBt9M0CUMdp5siRyr0TrB01wk7YdZ?=
 =?us-ascii?Q?7AFSQo7Apl880WgSYWvwzp+hgVIKRhb4CxUcdOfXRWA8k9xwUSQcEyHH8Asp?=
 =?us-ascii?Q?hCff60Ljt6/K6B31XUxBJAbORJYza3QzagEYe7kmMcHfEjak73IxV13ivz0p?=
 =?us-ascii?Q?1nIV9oWli6VTEM0tlBo2xqswYPaCrN766CDjHHpjPmNOgPVG3RHzba3ssSc5?=
 =?us-ascii?Q?38QZ/T/nqcHg//RiDxvosaH679vembJ5XSIcVQ+BIr1b50LZ2SPWVqlD8evr?=
 =?us-ascii?Q?KM9xdfCafnVlp8ux0PrBiJaA8cMdfYMN8CUI5QfUnyZPW6P6Lyity3ylhC6n?=
 =?us-ascii?Q?CWmgduOZ450J41IM+LbnGW4h1G+CbTgFFkLJkXZZJRo6SMQLE/WJo8w8lvq1?=
 =?us-ascii?Q?1LLEHkogYk/1dpWdrqt+hKmYZ/E2fbFCxCR/uwjAiDKaq3PBEG5rUSPEQEe1?=
 =?us-ascii?Q?TXQzNLQrqOUoPhHdaI8Gh8TdA4vr/90LaFJ9c7hxAthzD+7NIPSXsCJbOXNw?=
 =?us-ascii?Q?8psti6wvhuQLD4yHZXZl3ewsdmrU6WQ3jP2vSLD+iFiKkHpIkf0MaTtSYr+B?=
 =?us-ascii?Q?SdGsBR4JEsIcOdWQJ55ldfS9Zozx48LMIVKOW0ZZ2W97oHjyQWtS4iMlUDir?=
 =?us-ascii?Q?abztVtSQPbProvuYOKNoOqM7ESbS3xucJCdlBq+jdz1/AEtJoDWUQDP10GLq?=
 =?us-ascii?Q?bX0dPXm9HsnFfSTxy5iNHLYfFltpSYNR/VXeoZXFHxT8J6sttERO13bEtJ+c?=
 =?us-ascii?Q?rutP20qbs0A1wdQx88uyTZoEgn9+MLJryOq1DOIc7+zms/Ki?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d806e7-4685-4107-30f2-08ded7267eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 04:09:06.8794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDFArvyaDfJ3P5feLHLxkUt/Bks609LwZorvnT6cI5fKxlhAgHdNEB5knGX+VzF9yoqvbs/+89JB8JASPenjxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
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

Gentle ping

-----Original Message-----
From: Zhu, Lingshan
Sent: Tuesday, June 23, 2026 12:34 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into creat=
e and map helpers

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

