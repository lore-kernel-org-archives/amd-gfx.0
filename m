Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C0606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NiGeBXPs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36FB10E095;
	Wed, 28 Oct 2026 18:27:45 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5932F10E095
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 18:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJIutic5uuZqlwsXYjtEsVSW8bRUGaesw0YI9NsnNUz3uauJRqCG1nnJ7fPbPFbvhwQzAEsoNMYAvR7Nyh2WDsLWfkXEcEfFPYfuRHK9tguUERDdAIDAxMCVkqKdX3DK5iUvU2M/sfSceoWD3cXBMDZ0TKMoz6aNXKLqLqOhq9mvk2PSyJAAd4Cdugo3zK5QS0FbtPJRjD6xHUp1i7SgTMPaTSU2PG7tawTIYZDas3sIDXplqSM3FDsw+Hw5EOi52ABeFjmj3+gh3gPjHTFfiQhupyplA+10AkdVTByJScRWdpl1PRhW+bYMGTsLp/tq6PHC1hCVAYFTKVnwMx4XpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ4alDoqFHXiQQrPReHmrFnw/ZeKQhVDD6IKWn4x3q4=;
 b=u7GNcKIWyBcG265hB7WtC+HV1Y0CA1+QRUBeZAxJiQEcc3tVl3qoy7f3/AR3lcXq3C4EyhZyMKjb13B1le9EIwI2eDTpuMHSwRxpUQqWUOqiuepu/qZEehiZsVn58nD6L2cN9hXzGg/OuZgpw5D+xiW3cXpXt3F2/eWIUI0KR68A5nL8qlhe70E34w7NEvGFpw1imCqUxUyuzX37uF/nODX1kGRn27AfNaT1JWXa3184GatWvOygVwUMjOxW6u+MVwz3xtg4gD3uGlmy3HIUlpOFnz93lVHCjCD+p8DxON45riVhE5zJxwoU2cC8AKv1WnFWuGEd1tGOfZkW2RKk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ4alDoqFHXiQQrPReHmrFnw/ZeKQhVDD6IKWn4x3q4=;
 b=NiGeBXPs1IUkW2qcA2+1kvEBj1Qb0SpC53vdlZJoDepVIJaDfwqPzkoR6FxnQs6vFhSzFlKvcJahpkXuCKcfpi98sLofBXiL5mQDDZcAULMi1/E+USptLTWtbyguGoyqtutKmW4Vw7OnvluGZ1s7ZG13qbDpwCKyreAqaNQoUvo=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by SJ2PR12MB8184.namprd12.prod.outlook.com
 (2603:10b6:a03:4f2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 18:27:35 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 18:27:34 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v4 4/7] drm/amdgpu: Extend listing of buffer handles with
 the userptr object flag
Thread-Topic: [PATCH v4 4/7] drm/amdgpu: Extend listing of buffer handles with
 the userptr object flag
Thread-Index: AQHdX8oWFUWtouS1o0GTQALevHecJLcTU/uJ
Date: Wed, 28 Oct 2026 18:27:34 +0000
Message-ID: <CHAPR12MB9992476693CFD1600BBC10AF38EF6F2@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
 <20261019130159.11739-5-tvrtko.ursulin@igalia.com>
In-Reply-To: <20261019130159.11739-5-tvrtko.ursulin@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-28T18:27:33.835Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|SJ2PR12MB8184:EE_
x-ms-office365-filtering-correlation-id: f5c4118e-b821-4c87-4b73-08df352122ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|261026121527099003|261021121427099003|4143699003|11063799006|56012099006|261021123027099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|10063799003|261026140227099003|261028144727099003;
x-microsoft-antispam-message-info: JlFDtylzK+W3dtep6ecJcNNxYLgokfMO5RU9m7l3jsyeD4aYn8pR2xLI/aEUSBQnhBh5gMn5PAz4B/Ft6+553m6picWzShOa2NaOIqc68mtvD5mUIh6XqdHNYq+FZn2LioL7Tj0INsH7qQDjknQcTXXHc7V0u07HIJJOxYQgsSu061zczG89p4mUcIIMFrvRJxiBdVbf957IEVzQu3NSV/1LypzLKLuIXvSuEqCNt34+QGKZe7j7Z3XyEUFs6+5cciuZXwHIwXuqd8XiXKFAgF++L9O1JZBSKFKzpzUsNxNE76vLAFl+arpCHgfNFoFm1cx8T0FPZP8sjQuC6buZrzlzA65JVkw+64XLdyWzgVML2+59qCQ/yxzUXzaxx2gSJKYzF1A0JyyzBlsTuVdcPK2utCNS7L9VA18VYcvlYPTsrXdpzf2Jx8WHYfEhmsbNI6CyjnFzApIFwWXpfRBIq8YbSRJY/UiRX1tief0si8hAZGZjpUfAbFguVgIJioaAzF2FDZ1EwTZ8uX/iY7E0juN2SZS6bIdIXyj0zqKpB5PkIjAwGY7abPIxU71hQ3FU701EGsHe9Kg1pm7U/QGWoNLsej05MpYSGaLUosswML4SK04i0gyN0s8vKnFIFnaj3djpmL+AuW7x+6AGXjGubrGFEeR7rvM692Go/AA7JWpbOIRO3xIVLj/hFKvFL7Lqrtz/Al0T6La/iTTxdVgrJxdbClKnoXtNjX/mrYNEGIk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(261026121527099003)(261021121427099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(10063799003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n58zTe29jkXHFAEJJWId5tvzWDqB8XLVmPxg0OpLy6NP2E9mxJhvQMfBs8dZ?=
 =?us-ascii?Q?PxlcWI1OEWJkP3pl9ODyU4wsTNXLA3LQATqNvgTPpqjLZ9r7lME18IlxfQDj?=
 =?us-ascii?Q?T6QzBur+bp8ULqJEBXLihGuupVPZPGe6ob8S56fFaHRpRFI4Ja2w4mrHdlNc?=
 =?us-ascii?Q?qMAgf/r8xKU0h1jFfHY1UxCfo8CosZV0Tj38lI7EGJV2Yg+UuUATMqjJgG69?=
 =?us-ascii?Q?p+Q3hougwlAVA4yGaw5Fv7jhUeXuekk0ADRoKZtcbj+4I4CmDzAGG3s3tKub?=
 =?us-ascii?Q?CKHdLRFQgeaZeQvemw/YLzG0rBz8M0rnFPMv76s5vjiBsMJiB6C6RJxr/wuA?=
 =?us-ascii?Q?ulanaL/jJdpSYVoouAotD7ZSYMdRv+QH2BjWTn40Cy6ldTiOglQ2zF7VW7Rd?=
 =?us-ascii?Q?fmi1kdrsu0KjRIEMAzRDceApY1sQB/AjG57bmtVKiHteYW6MT0kZU/MO/E/Z?=
 =?us-ascii?Q?1sBchsP/0inirDrGajLheRpyjzBwYYwCNUcxE3mgQVIy1Pj9P5+qraw0ZVa4?=
 =?us-ascii?Q?pEFu1qIQoCitRxUej0AsXdqRvOf7cSCEzfQCUqUuwcZDLs0OJxNVBPLWgR+G?=
 =?us-ascii?Q?QhIdGFdlNPLt1ZtnxrQQplxZq1ll3fdEfeStrnZZdoCYrl//wRBzSZEykUKc?=
 =?us-ascii?Q?Ny1dkYbxpR5zoQ80C0xaFelQ8ADLzWhLtZH5DBVLzSTCInKXfNhdzWhTemBJ?=
 =?us-ascii?Q?Zr7jbIGMq071YTzb9WjKGsngpBDVK5beOsu/1svdAMthtJM3jczFN7H0fGuC?=
 =?us-ascii?Q?3O8Rdo1lSezKrhm84VEURF8HUJBLprLWpTNvSL54DOBxaYnEFvlPng62d4uu?=
 =?us-ascii?Q?KQv7cc0zmfqiIbGOcCUDUWc8LOQQBayfAI7Sd/tYMKqtd/ynXIrhbvxPK7v1?=
 =?us-ascii?Q?DDr//PEB5bffXqU3PZG8wC4jw+plPHkwQumu5X8RhZ8NfFQe3wxeIfcsGERZ?=
 =?us-ascii?Q?T4udWVBVaIAgBwWHmZFFnn4WeVE0H/Gp+auJIL2p7D6hbaq7iNszuwn6uwfX?=
 =?us-ascii?Q?CpiOeaRitU37PUbvM9tj/xiPJiNSJjYFn8JxsALVGbvaaeZ3NnnqcEEcyA3r?=
 =?us-ascii?Q?pTzLWxDpbDPROxCYaPdTHgeH5uNkqLxMDcUiDVz4LVNfuSJ2ogURMjwWAJl7?=
 =?us-ascii?Q?LkHu519Ro/lVZPoOT6qxa1AH8oLvY4+fxbDFxYUB65uP+jwiPNnR05QF6XlB?=
 =?us-ascii?Q?LGrUdXQ8Xpw/6RRxL3iptmlG7p6xCB83Nc8/YboEnOl0KSSDxRNNBjpWw9ut?=
 =?us-ascii?Q?XwKQNpT7h07zhUwxGYwahQKpNrwrh1U+7QaKXUcNjTsxD724RxdD6vYqbIuB?=
 =?us-ascii?Q?yzO3mTu00dwCAKPVuOyKn6ACEExYmjz3m9tAbkTgS3h9QgN0qWn5BgBcqsz3?=
 =?us-ascii?Q?Cq5epNwPCfYGbT3aFM8GAbBVxL5VrmVTAQqktH3U70OmrbLzGcoshMGzyfrX?=
 =?us-ascii?Q?ffEBUcVNhO9Q7ovR+YqPUfTe1U7u1c5oj5Fg+OOoucqYdLgALtxMtyNozHmI?=
 =?us-ascii?Q?+WMzBA++WQvVckXl9qfzLTQSU8elyXUpne+0b/x8SOaw89IVbWflRQsG3D9+?=
 =?us-ascii?Q?5xe2IVwTif49qMdX9vH1fk/5OlUHmjR13PjPMOWHVjTiJSUEeQby/V4VKM6U?=
 =?us-ascii?Q?1W5bst1ZooPIIYI1JZUlS1Vvm9xBY0rzTc6ZuefqoN4VVQLz+Hdp62bcu8a4?=
 =?us-ascii?Q?eTjrBsGNwRZoRiGbPWrcFApP55aA6kVCM8a10f2IwwM1wAJb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c4118e-b821-4c87-4b73-08df352122ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 18:27:34.1123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPBG1cJZKDVvmIi/oRmD4v7faxyLmV6EMk3mDIhAqMMtHYUe3GStxYm98UX/nZ6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>+       union {
>+               /* physical start_addr alignment in bytes for some HW requ=
irements */
>+               __u64 alignment;
>+
>+               /* drm_amdgpu_gem_userptr.addr for userptr objects */
>+               __u64 userptr;
>+       };

Would appreciate comments here making it explicit when this field should be=
 interpreted each
way - something like
/* When AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR is not set */

With that change, patch is
Reviewed-by: David Francis <David.Francis@amd.com>

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Monday, October 19, 2026 9:01 AM
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com; Francis, David; Koenig, Christian; Alex Deucher;=
 Kuehling, Felix; Tvrtko Ursulin
Subject: [PATCH v4 4/7] drm/amdgpu: Extend listing of buffer handles with t=
he userptr object flag

Add a new flag (AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR) to the
DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS ioctl.

This is required to allow for checkpoint and restore of userptr objects.

The existing struct drm_amdgpu_gem_list_handles_entry is used with the
userptr creation flags places in alloc_flags, while the alignment field
contains the userspace address.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++------
 include/uapi/drm/amdgpu_drm.h           | 14 ++++++++++----
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c
index 385be1e0944c..e3d3e205a4fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1267,14 +1267,23 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device=
 *dev, void *data,

                bo_entry =3D &bo_entries[bo_index];

-               bo_entry->size =3D amdgpu_bo_size(bo);
-               bo_entry->alloc_flags =3D bo->flags & AMDGPU_GEM_CREATE_SET=
TABLE_MASK;
-               bo_entry->preferred_domains =3D bo->preferred_domains;
                bo_entry->gem_handle =3D id;
-               bo_entry->alignment =3D (u64)bo->tbo.page_alignment << PAGE=
_SHIFT;
+               bo_entry->size =3D amdgpu_bo_size(bo);
+               if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
+                       u32 flags;

-               if (bo->tbo.base.import_attach)
-                       bo_entry->flags |=3D AMDGPU_GEM_LIST_HANDLES_FLAG_I=
S_IMPORT;
+                       bo_entry->flags =3D AMDGPU_GEM_LIST_HANDLES_FLAG_IS=
_USERPTR;
+                       amdgpu_ttm_tt_get_userptr(&bo->tbo, &bo_entry->user=
ptr,
+                                                 &flags);
+                       bo_entry->alloc_flags =3D flags;
+               } else {
+                       bo_entry->alloc_flags =3D bo->flags & AMDGPU_GEM_CR=
EATE_SETTABLE_MASK;
+                       bo_entry->preferred_domains =3D bo->preferred_domai=
ns;
+                       bo_entry->alignment =3D (u64)bo->tbo.page_alignment=
 << PAGE_SHIFT;
+
+                       if (bo->tbo.base.import_attach)
+                               bo_entry->flags =3D AMDGPU_GEM_LIST_HANDLES=
_FLAG_IS_IMPORT;
+               }

                bo_index +=3D 1;
        }
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde..7620d6acfa0a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -851,6 +851,7 @@ struct drm_amdgpu_gem_op {
 };

 #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT (1 << 0)
+#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR        (1 << 1)

 struct drm_amdgpu_gem_list_handles {
        /* User pointer to array of drm_amdgpu_gem_bo_info_entry */
@@ -866,7 +867,7 @@ struct drm_amdgpu_gem_list_handles_entry {
        /* gem handle of buffer object */
        __u32 gem_handle;

-       /* Currently just one flag: IS_IMPORT */
+       /* AMDGPU_GEM_LIST_HANDLES_FLAG_* */
        __u32 flags;

        /* Size of bo */
@@ -875,11 +876,16 @@ struct drm_amdgpu_gem_list_handles_entry {
        /* Preferred domains for GEM_CREATE */
        __u64 preferred_domains;

-       /* GEM_CREATE flags for re-creation of buffer */
+       /* GEM_CREATE flags for re-creation of buffer or drm_amdgpu_gem_use=
rptr.flags */
        __u64 alloc_flags;

-       /* physical start_addr alignment in bytes for some HW requirements =
*/
-       __u64 alignment;
+       union {
+               /* physical start_addr alignment in bytes for some HW requi=
rements */
+               __u64 alignment;
+
+               /* drm_amdgpu_gem_userptr.addr for userptr objects */
+               __u64 userptr;
+       };
 };

 #define AMDGPU_VA_OP_MAP                       1
--
2.56.0

