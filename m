Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B2AFF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FD610EA09;
	Tue, 28 Apr 2026 03:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vf86eW/k";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8161810EA08
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tH0hfDrAg0eDC4Knbmqe6aCL9meIBVfe3AYnFXObeYuDA5xIy18BFoTOvthX8OlddfPIPZDj1PxcHapy92jFUcsZF2zdg/u+2aKc342SXmX2WCWUiV8LXD+VXR5KEfOxmV+OvvtTR6ZKZPACyztYcEIWIGCq2MVhZf4HeCVChN1cKRCPd/kfy1C8iQ4mJbP4XX9LjuXJdmRy5j5yqwEVl5P60NrGc/FvCfzx27rRRJzo+IP+VwrMQMU8syvqh0SBBJjV2kbj1jQcXEr3w4NUZ/7sBoD2R5XdGJL0lhyKvMGFTVDJ5ZySCVwJ6hgo5pIluO0Cc/L/AzYXFiB1rfXqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygojYgIEf5AL8yToH+SZ9gGO20LzcPJ/GVVKbLzgYyU=;
 b=UMpcVn3Vxb57tHQM2ej7MGha+Wuso0Hqb7+/4fABXyiICqDf1wT57aAaFIoVp+6rZIE437Iju8LZ4Y5SDVdKtrCjxyeuJNJdKmHzSDNNETV9dj6Qyulsqa/mFzV+EbftqIcGEHDfHR2wfKtb8GO8TFwYu35+AFo9rdPF5IX2rbT9TjTQhkPDZNY1DUcNGXAqWiIqvVBaF5qNgca65vAmHomL8ThWDeT6+CB4l+dXwL3ehZWrJSYW/LaaKY7MWXBVWbc0P8X92fTIeUCFn+VGUCNjx07MBTPI+Hko+oCVBq2AKUdXQRB6VoHMJWSqltUBs0mmkWGc4BY5YmS3VlfC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygojYgIEf5AL8yToH+SZ9gGO20LzcPJ/GVVKbLzgYyU=;
 b=vf86eW/kJMRaNXVeY1Bk+xKOh15bWLsPQ4SPnCYTxGvPLNwT9GRvyINdKLJectT+9ySWMtCN4t73jNmgeBrMSIwiar/5XfctltAF2PggnWy/yBaFxAubP5uYwYS5HT8TXZdKeecQODp0jKDevRG7UfgGSufEqFHNE8ga7F97YPs=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:14:53 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:14:53 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 05/17] drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and
 amdgpu_bo_free_gtt_mem
Thread-Topic: [PATCH v2 05/17] drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and
 amdgpu_bo_free_gtt_mem
Thread-Index: AQHcu9QVyW0x8Bl3cEKP8nFnBALU5LX0AhVQ
Date: Tue, 28 Apr 2026 03:14:53 +0000
Message-ID: <BY5PR12MB4179BA8A303F3D94301DF809FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-6-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-6-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:12:39.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: abe1518c-f161-4753-9eea-08dea4d450f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: nVfIj6p0RaML9/lp2UJ//51zlo9zN4UuEu29BSzGoztQCAvRFLVp/6XBNjS3i7yxc/hC/6UOYiVc+/TOjyzhEY9EhSF9JLPFE9trFYmf15DQkxcRC83tPzJpPUs8yjGR9j/J8cvJBapau4+Ey+bQ+YeWUG14JsmGHiqf5+2wNYyMmmIys70bAEHwvaul1j8G9nYd/9efMbF3xo1I3BRq/uOiTfSHjZQmTmg8glV0bt1Dtye3UMWzCShOi5AAd+StSuh3yN9wwdwVjij7sSiJxbgGrMOApfCmk1CDFZ899MFhKNeim8FZFp5xT5ucmwEWrUIgky/psq2DIB+0eK1JXaZHwz3bCbnBiwnH5ZA5gWHF+FMZqUqnUsPX9JYk707IQRj+OfCkAC7rQ0gQtkGJk4CGWBYLmRu7wsewHxm0YDcDNh5aOHdfPPJyW+TMirzI1VdayM+A0kXCMyQcT+Yi9kKPhzv4IW4mOhdSavRjX3EfRxLXT0mTV0UQp0e0rm5B6tXkoDqt/er8ua1CIciUjzH7C5ib8patVX+uG9Bzuu9C2qwOGrXqRasiCGGmPEWe2HJnuEXiCdDaq4HhYjwoD0aGg+4qjD37ZmxDDLoXONtWd5xHuYkoMZ2DZkBbUkwn0Rbc8ilxOvXgyCPa3iM6diffpEcPJxG3Gy4T1Rp4AHYsb8kk6WBICCOdwNvPo40OVeB9HPzaHhr5vIRyjD4buogDFdQ4fNDJ/yDr5fVNtAXH86QssEe+RraYVKdRrivuVVGLMLVbaV0An17K7BtvbAPGM92NK432cStJNOVy5fY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3+FT4gMPBamGg6GhfmI0eSzCfH27vwMsRgZSwC21dZ9WxMm0NwaN+Rr3DHSM?=
 =?us-ascii?Q?IygWstBn23JhG1XG50oqirstTokFxEWZKaCy3sdwqUhTlKz/MAfuvOSTyIXT?=
 =?us-ascii?Q?p5niZeYzx8rnOYLS6yI1U/Fuy7ZLQfgFFJuhwQ2oh5EYHMacb+23At04HHlj?=
 =?us-ascii?Q?YmhmgSuHI+CqMOuoRSElsG0A1kWghs1tkB63zo2JQjRvBQv7UBcl/D7wZ2iS?=
 =?us-ascii?Q?UW7D4TGinKQrKfb+IVIkuf/aH3b+e42WKqC+VHYcCEMJ7T0xG7/lJAL/Cto7?=
 =?us-ascii?Q?+Nm0nCo8zl3NhACUDQne0kgfNuAe0PQHRqRlqpVMzvfYoTi2lunqWyMvP+db?=
 =?us-ascii?Q?gCDTPibdK9JipITxL0wnM3VHoq2bov5sAVTpBENuAIvcAmtGMWHBCXCEV2sS?=
 =?us-ascii?Q?vj84kYekD57rAh7XCMgdW8yNF/LnIlamZfS7kl6M5/+qN9Utv3u3vbKHFDX9?=
 =?us-ascii?Q?hLGBlyK/Bf/3IjDphfTIsH3H8rjSMlS2vlgtS1MUaLJ++NxlTlD0mEXt3/Hr?=
 =?us-ascii?Q?rcFPgeqqWdEXA7q1YGCoc4P/966g9MKF25YvS/ri90jG7ELbZ8sL1iYhlcgx?=
 =?us-ascii?Q?qvQlLpOp6u+u/kga7v0ELYY926WanitkYIvdVPdDijX8WJ7LsaTHN7UN/h9E?=
 =?us-ascii?Q?p8+8sIgn6FabN/OcD3J0d0+s37IRHYdHFQ7sJi4Sli4mKyLj+WhvPkTyag9A?=
 =?us-ascii?Q?BSlv8ZsNs9bteHhTVw0vKN0xApqGTMDtB1J4QWNeTOAKkD9nwrqNX7Q3LKF3?=
 =?us-ascii?Q?qyOHxBHQSJuq8N7OHBtYDU+LqYOMa2FKwEoIT2mPcEOw8NhYAQ9R5LjhoeH0?=
 =?us-ascii?Q?2JJuyQBejsEL7N1E5eTH7u11Pk97lBriI81JlGDdgHlVGaiVhX474S2jqeqR?=
 =?us-ascii?Q?0wS2oqKVD+ODoK/3lUplFHvOyOwlH34c/SGLxQIkRYHESXEBDQmqoDSMFkL9?=
 =?us-ascii?Q?XgPmYkvb9oFp67cTbcEMVDIGu4ukBuMD87k+YyLoKMxc1zwhlyRzleiTXJXI?=
 =?us-ascii?Q?7X4RzyOzkjO3AgViimGndgt8/YF58mXwSwqAoC2iafMEdr3gY66aGmzXe/r5?=
 =?us-ascii?Q?cxBm/ZXulrwtNg576/2riNqPv1yxQMnp5Hky7I00CasnZ3ncPvL0zAtYHuL2?=
 =?us-ascii?Q?NJbT5TLo+H84ML1d9VTtU0H9kL8INOgM1CcNGN5BT1d6HSkOh6B1F4FYW6LM?=
 =?us-ascii?Q?rgcPDbT7mWV29NfD6W7QviAVKL3KvXuL6S50hL2O6iSspRlNfHaIp98MLGyQ?=
 =?us-ascii?Q?2z/L1/EGwbThN8nmDh91FzbeC+3ZLs7ZSkAMjrYa5CrBAn0uTGvZ+wAtgrnq?=
 =?us-ascii?Q?S93GzANRUHiFCe7znQ8kB29AYSVeV5EX9xlwWStCxV5U1pNMQa3AYAn1Ip19?=
 =?us-ascii?Q?04BkETV1bgq/CWSjTP4JcqXJ+FGWaqXmCDIjRAxXWItCFGTm7WR1WQ6nZgAU?=
 =?us-ascii?Q?dEKvWgUICxHvBSpV0CXhWTLzKCy4PN5GFyaLxYJ2xTFsAtklp5x0OwtVOoJ0?=
 =?us-ascii?Q?AdomOQpTeIwuWI9x5R4y+IZM1hxXISeZ+W0D8v9B8GxC78HtgJbzgXqcpm2x?=
 =?us-ascii?Q?OzdALxt8kxS1/zFr9Op5g+OK8U0Bhx+0VUyRBbSARil5Lpqnidv6v9VOZwV6?=
 =?us-ascii?Q?b74duhWu2M82/Wedei1Sk4VYqe9NkjUvi2lzafnlVqcy74SdACmrkeXl9hmJ?=
 =?us-ascii?Q?Ys/1w+CLfNJIZW7KOsYi3DMI+6mN17J1TlSYb7ZkGyIVbm9i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe1518c-f161-4753-9eea-08dea4d450f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:14:53.0868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWPBFdUi6XZsDlozYhpm+HqdQ5OvkhzQcUzCoT3SpMC0fraBf8jKMkXq1uimcIO7Zo/nTGk3BncR9mbB1lYkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

I didn't realize that these two functions are only used by SPM, no other fe=
ature uses GTT memory?

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 05/17] drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and amdgp=
u_bo_free_gtt_mem

two helper functions for allocating and freeing kernel-internal GTT (Graphi=
cs Translation Table) buffer objects, intended for use by the SPM ring buff=
er allocation path.

amdgpu_bo_alloc_gtt_mem():
  Allocates a TTM kernel BO of the requested size in GTT domain,
  PAGE_SIZE aligned. The bo_ptr_size is set to sizeof(struct amdgpu_bo).
  After creation the BO is reserved, pinned to GTT, GART-bound via
  amdgpu_ttm_alloc_gart(), and kernel-mapped via amdgpu_bo_kmap().
  On success, the caller receives the opaque BO handle (*mem_obj),
  the GPU virtual address (*gpu_addr), and the kernel virtual address
  (*cpu_ptr). All intermediate steps are rolled back cleanly on any
  failure via a chained goto error path.

  Two optional flags control BO creation:
  - mqd_gfx9=3Dtrue: sets AMDGPU_GEM_CREATE_CP_MQD_GFX9, required for
    GFX9 MQD-compatible allocations.
  - is_uswc_mode=3Dtrue: sets AMDGPU_GEM_CREATE_CPU_GTT_USWC, enabling
    uncached speculative write-combining CPU access to the GTT buffer.

amdgpu_bo_free_gtt_mem():
  Reverses the allocation by reserving the BO, unmapping (kunmap),
  unpinning, unreserving, and dropping the last reference (unref).
  Handles NULL gracefully and logs an error if reservation fails.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 97 ++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 -
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 1fb956400696..993171979896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1696,4 +1696,101 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *=
bo, struct seq_file *m)

        return size;
 }
+
+int amdgpu_bo_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
+                               void **mem_obj, uint64_t *gpu_addr,
+                               void **cpu_ptr, bool mqd_gfx9, bool is_uswc=
_mode) {
+       struct amdgpu_bo *bo =3D NULL;
+       struct amdgpu_bo_param bp;
+       int r;
+       void *cpu_ptr_tmp =3D NULL;
+
+       memset(&bp, 0, sizeof(bp));
+       bp.size =3D size;
+       bp.byte_align =3D PAGE_SIZE;
+       bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
+       if (is_uswc_mode)
+               bp.flags =3D AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+       else
+               bp.flags =3D 0;
+       bp.type =3D ttm_bo_type_kernel;
+       bp.resv =3D NULL;
+       bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
+
+       if (mqd_gfx9)
+               bp.flags |=3D AMDGPU_GEM_CREATE_CP_MQD_GFX9;
+
+       r =3D amdgpu_bo_create(adev, &bp, &bo);
+       if (r) {
+               dev_err(adev->dev,
+                       "failed to allocate BO for amdgpu (%d)\n", r);
+               return r;
+       }
+
+       /* map the buffer */
+       r =3D amdgpu_bo_reserve(bo, true);
+       if (r) {
+               dev_err(adev->dev, "(%d) failed to reserve bo for amdgpu\n"=
, r);
+               goto allocate_mem_reserve_bo_failed;
+       }
+
+       r =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+       if (r) {
+               dev_err(adev->dev, "(%d) failed to pin bo for amdgpu\n", r)=
;
+               goto allocate_mem_pin_bo_failed;
+       }
+
+       r =3D amdgpu_ttm_alloc_gart(&bo->tbo);
+       if (r) {
+               dev_err(adev->dev, "%p bind failed\n", bo);
+               goto allocate_mem_kmap_bo_failed;
+       }
+
+       r =3D amdgpu_bo_kmap(bo, &cpu_ptr_tmp);
+       if (r) {
+               dev_err(adev->dev,
+                       "(%d) failed to map bo to GTT for amdgpu", r);
+               goto allocate_mem_kmap_bo_failed;
+       }
+
+       *mem_obj =3D bo;
+       *gpu_addr =3D amdgpu_bo_gpu_offset(bo);
+       *cpu_ptr =3D cpu_ptr_tmp;
+
+       amdgpu_bo_unreserve(bo);
+
+       return 0;
+
+allocate_mem_kmap_bo_failed:
+       amdgpu_bo_unpin(bo);
+allocate_mem_pin_bo_failed:
+       amdgpu_bo_unreserve(bo);
+allocate_mem_reserve_bo_failed:
+       amdgpu_bo_unref(&bo);
+
+       return r;
+}
+
+void amdgpu_bo_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
+{
+       struct amdgpu_bo **bo =3D (struct amdgpu_bo **) mem_obj;
+       int r;
+
+       if (!bo || !*bo)
+               return;
+
+       r =3D amdgpu_bo_reserve(*bo, true);
+       if (r) {
+               dev_err(adev->dev,
+                       "(%d) failed to reserve bo to free", r);
+               return;
+       }
+
+       amdgpu_bo_kunmap(*bo);
+       amdgpu_bo_unpin(*bo);
+       amdgpu_bo_unreserve(*bo);
+       amdgpu_bo_unref(bo);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index 912c9afaf9e1..0102d43b2edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -353,5 +353,8 @@ void amdgpu_debugfs_sa_init(struct amdgpu_device *adev)=
;

 bool amdgpu_bo_support_uswc(u64 bo_flags);

-
+int amdgpu_bo_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
+                               void **mem_obj, uint64_t *gpu_addr,
+                               void **cpu_ptr, bool mqd_gfx9, bool is_uswc=
_mode); void
+amdgpu_bo_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.h
index 1a3a7229de56..7b88693eb6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -720,5 +720,4 @@ void amdgpu_vm_print_task_info(struct amdgpu_device *ad=
ev,
                list_for_each_entry(mapping, &(bo_va)->valids, list)  #defi=
ne amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
                list_for_each_entry(mapping, &(bo_va)->invalids, list)
-
 #endif
--
2.34.1

