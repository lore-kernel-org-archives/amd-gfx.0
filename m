Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318F4C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 01:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31EA10E1CB;
	Tue, 18 Mar 2025 01:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eyQkm+pD";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5665F10E1CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 01:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lU4hTyt61SjbzJ4eCYBCd3dqlhIUUmdqsmwjHUCij1a4BeQa8FGRLN1JLnta5vz7Qc5v6c4gXJhRRxtF373sNaAJnBYXsFoTKtcAYzHeBoTDCNxag1QD59IfU7Wx6qwKhhympgMqgUTbc7GiwkxPx0EJqPeWE1a9AiiwsM0Pu8aVluohYlrPHY2HkuJWVPZ49xVrucaD8YKcspkL/7SbcDdW9QoKYn2V4Okd27Np/gDvpjHMDMjwI0+YfDDW0ORxsoLKEhLTtmOFDUM2ENIx+AkX2vfl2TmuGcttQnssMo6K4vxVTApaZwd9w1Wxe1Z7TzR7Iv9fLOCGzpESbViiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWy2pEB6sjkjiukvOFAEykNwuQn/E6yA1ogZ8YxIw8o=;
 b=IR8x15FvCakcOWjUf99RG8cwzmfH5H8i908MaggjeyvHZWNJcenBO8I5UM2M13tTxu/XdxDZV5ExUh0dafEztlUbyMwiqR8UhmdVUuTAeGUZ4GE/Cv7dc8vpoVroHTkRrZvZMiwihlfXLmQAEicatdDLUWpSV62iNZ6C0CA2P/qyImJFFSpUuxiiKFx+5MC1Fkcg1Wd9cSK1zGVqbHfjR2BcVAs9lhcfoA9zOl3U5YcOQAHb7uquPpwKw53uD237SAbmRF/wVVc5q9hmuF5AaKinwF+LL+m/C34qna175f8e/fdtqrrTpMQzZLpWdDbXnwkFOiQFQyxJJ65BhQkoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWy2pEB6sjkjiukvOFAEykNwuQn/E6yA1ogZ8YxIw8o=;
 b=eyQkm+pD7ZBBH05hDp3wMpT6gJbm1DfhVT7n9CyzTSazZ1u+gyL3WZfdLGxf1ocfy5w+a/BeRL/dXYJFGT839JvykhOFWOin+mj0F0EuqyQ57I+vZ9HokuxZjLTo7eB/7KaAuOkJagd85qN6EB9kEq4LV66C9YZKI9zT9HUQbcA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 01:04:40 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 01:04:39 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH V7 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
Thread-Topic: [PATCH V7 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
Thread-Index: AQHbjX5KAtbVH6bvfk+pccgEIQBEmbN4KA9w
Date: Tue, 18 Mar 2025 01:04:38 +0000
Message-ID: <DM4PR12MB5152DC70507814423ACCDFCFE3DE2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250305032520.1745117-1-jesse.zhang@amd.com>
 <20250305032520.1745117-3-jesse.zhang@amd.com>
In-Reply-To: <20250305032520.1745117-3-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7da43cef-aac8-4611-bb2a-5d0db2ce5d07;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-18T01:03:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BN7PPF521FFE181:EE_
x-ms-office365-filtering-correlation-id: 7f7fd285-a6b1-44ac-4a70-08dd65b8dbb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+SkU24hVl7c1gP/m7oyxzRwx2ay6NA9ZVkNrn/0tJswRAp3IDhaP02nZs4t0?=
 =?us-ascii?Q?aFI4Z4X2/Fh1utOUvsDgRaq6oMWpHApG938xISfHT1OjZdZcXW9XxJ4gBai1?=
 =?us-ascii?Q?tU3SgGlp8hiT0p0BTcMAkLxbBb5nYL1ZvVq9t+60P5GFWsrjbBO3UhCB9lQS?=
 =?us-ascii?Q?vkMFTyz14yyahz0v2VPuPtooxdqzN+CEcMIzaI/rhaXOIoh7FOdwvzC0OMPW?=
 =?us-ascii?Q?88yep+t1sQtHLO2bEyNso/21exv6d/egJPhzD4a0xt1dOiKXgs/iDM7TtP+3?=
 =?us-ascii?Q?EfuKvxpgPvudcP5C6ZFUuBT2LFT40/0x2GsBij7sJy7/ZHcFTshMviv5RL0E?=
 =?us-ascii?Q?xicGvQox5pyzDLNMH0mf2HK9xd2HeIDC+MdnfrMojFg5w5YIoyJBKIO/vfJb?=
 =?us-ascii?Q?af7AcW8AKofs1oaoTzFa3gB9bD0xiO1zVdxLa/JE1F+s5h88xVHJybUXK7Fs?=
 =?us-ascii?Q?mWDOUpszholcrdiIYzny4eV7/NcpMfhPjjVdlaElJiyqg2Pg//90kf4yqhVO?=
 =?us-ascii?Q?/CbD1jlf9L3d9v0qQ96pj9Byb7Evamzkczr+4V3PKKHVJUbfUAPmuTXHdp8F?=
 =?us-ascii?Q?/DrtCV3FneGZEf4vf81svOTBLUGj0gdOkslKRrZ53ZhHzEPbp0slpWlN/SY6?=
 =?us-ascii?Q?O4gr/jH0l//5vBU4Jc25HLC7srIQHQiI2srZJwhHPpUoaVpXVa+T+gZwNonC?=
 =?us-ascii?Q?ERS8ujlAT7/kgNbr3dv+67MA3k847bR8rx/7L4f0MEtWMNPCdbC+bF90pdiw?=
 =?us-ascii?Q?7w9m4xSDldNdWHOXh1bXVw2GFg9aVhI69SkO+UfweXyMbDTjlqKm8uqhTJN6?=
 =?us-ascii?Q?ZaBDEtkldg1p9Shi0TnxR5gZzok26U2ywk/cJcjEkhuaaUNWoxN2j6zTcwnR?=
 =?us-ascii?Q?TFYUNGSAkxzhreKRjLAYmTT3tqFseCs3V2SHtnkyCX+1K8Fqm7cZ72HvRdp7?=
 =?us-ascii?Q?sBQ/0aq6iwvZl98cosUk4ZsOR+nvKrgoRkhkBCId+1iD5LJqZMrpMqPD2FJX?=
 =?us-ascii?Q?iC/ksdnYtsdHiaWkZBtzYCiGPgVjcn6yNONbDPfvL2NpyOH8BVfAp29iwNh5?=
 =?us-ascii?Q?M3caGA7BXPqeDQEzOMToAVDAW+7UU6ID4XgbpCVZq47yWmEN/mj7NG2/wUyX?=
 =?us-ascii?Q?tNGtOQADzQIcEaRqxjd6yoi9++djFAsN88+e8OULtbZGbTPyNW8Vx9fhj9n8?=
 =?us-ascii?Q?RG6QiYW/Wr1Cd63VPoYpji/9PcpK1JCKXpsFxLgdigVhmYu/BUXqM8rJlydk?=
 =?us-ascii?Q?OxkOJK6BihIubGr1k2SA2Dv2oiCpy1y9hSjnITlsGColZCDH2u7bdF+Mi/8H?=
 =?us-ascii?Q?QTAx7FtUoEW3xnXY9GjfANhAODn3c4DYmMxe3JcnNMBfI7FM7am3Agvg8ptn?=
 =?us-ascii?Q?Jak/Gbuee48ZlIaZrimhHyuHw8/NHVSs+H6itcCSL+jhQiayfouioPo+z6lu?=
 =?us-ascii?Q?WxaohCgRKq92h1S0YJuRL4a9zNZebnfp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B/gVrx2Q+UvMHG+vdWcOHdrYLyslEtv2Tdr9unejRtcYugt2jW5zCdm7xUBo?=
 =?us-ascii?Q?XXrTZld8HABcyaA46KTR/EEqTMDD6n0PjrnaSmdLmggU20+ZkylO1j5FgDrU?=
 =?us-ascii?Q?NOTeXltFA08KfzbvirA3aiBGZc1a0EIW8Kb5Pw7mqUejNUCdhLvQn+W44eCR?=
 =?us-ascii?Q?DcpO7Asr+IgvXV0uR2EAR9x+JRz/p3AcIhkNRF0tI5IGD37FEHCxTYTuORnP?=
 =?us-ascii?Q?IsedgUsmeWO7OYwFVEVuwabIdhSJ90qUW7WJUO0p8jVjgJIXOumVQvYbSS3n?=
 =?us-ascii?Q?sDu/YVZOlX7mE1oEH2kemWinC5gE3QJs2w0ZYwiwFrYx4aPpKlAkGt7i04+U?=
 =?us-ascii?Q?J4eLw1IqSYBwCsOIIIcahFIrp0BiRn9/r/pqTPKJ9g3yE/upz3qhzgAQr8ez?=
 =?us-ascii?Q?xzEyvORZt13mFK7IqOHUPkMyeOO1gQBNgHPWi7DmASP/81YnWqes0Iom4RUz?=
 =?us-ascii?Q?v45eS9Feyy7IoTFSZi+k0GIEZfBnvD5BWP/zzcNCJxmAWK5nCT3WUgo+IGdt?=
 =?us-ascii?Q?vlm79xaKdiegoQI+mGjDhjVKSBzUGIBjR8P6lf9i7aCq/XX9aVNCe0z5X/Ng?=
 =?us-ascii?Q?BLJu9hRHV0c4P5amZIVpXrsExBNpEZ1/JPS0bqub6UowwNF8kGO0uJBFfb54?=
 =?us-ascii?Q?Dim+rgSADmJBK/IOoYi/KNrn6bps6XyNANEWAg+YY8r1EP5N5GebkkI/AZ2A?=
 =?us-ascii?Q?NikXnMSR3l5Q7xLHtlTctKp+RXwT2zXmQasGfW50lDtyXllXsuyumsb4iq0T?=
 =?us-ascii?Q?/w0AUucdHlaZ/Xy2X+qWqQVqlvjK5MxjndbF6t67BuBvyCde4yZhmy26T6zx?=
 =?us-ascii?Q?ccB+/jQKlYD+1MdTUsmoR9HgWDtmLe2XG6dK0IOQ6aENYA41/gcmZT1w8KS2?=
 =?us-ascii?Q?5scNi2qrPYq+KE8YvCJg4EkRllfNmFZ+A2AwRik0R+kM9jsdzLRQmLcYwc+Z?=
 =?us-ascii?Q?Vd/9ZG/jTVKxmMhgVOocS2oJZIDsZ3wgFqYnpxXL1uOTnNE9PdImdrW9bJ7S?=
 =?us-ascii?Q?QpC/+7e11uEkOl6M3kRkANW3PM9YU57HYUbVixaatPKo7fQRVLLyZgFlkPCC?=
 =?us-ascii?Q?Vae9KI5Tryvz9Faj8d3Ng1ZMAEaG77UdgGrk1OMXMMiza+PoMmnbFzT/a1iU?=
 =?us-ascii?Q?pdqGdZHlEvPn13nanbSAOqD6F3G7oV16Sxg6JgdXKA2PnEmKNOLMQepN90e5?=
 =?us-ascii?Q?CpKkkRB2ZvskuM15qYts+ZbyhnDAXPTGo3ilPkQINC22xYBOOL54fs7Kx1Q2?=
 =?us-ascii?Q?Thr0A5P8Tx8EG0i98s3FZpivXFTM8kHdYxYTbSD4LT1A+AL0HhYYV3LD2wva?=
 =?us-ascii?Q?YRVrJfcsReUur4ZMwUbfHcytb19BBocdL/f9o5Y6RDTEmFTsLLFBbxW8w2lY?=
 =?us-ascii?Q?pe12vx4QDoLrjEQqHaYOLHUjPNdlJDQB+tBb1DFXPeKZF0ePMmaxNEhA7pqc?=
 =?us-ascii?Q?61INXpWQ6PqW2Pza101WBfs3F8CMkEhCMjh/SWVEvbaWmGUfA2YvRQQUHcSh?=
 =?us-ascii?Q?5EL4a1IzqOMGgFlCqfZ7Ppe2CeqXh14qvaUVW6GHFuViVZYMgt5niDCvjlvv?=
 =?us-ascii?Q?MZMevmB2bX4Bgw0IJx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7fd285-a6b1-44ac-4a70-08dd65b8dbb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 01:04:39.0177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSTuH708Cbf8cvjR8CW+O4qTlwFwg9l9BG4ODQk1LIMIBw2OfKVHiwmLBtaOG4a/soGNqDma5HQ7WWR5Zb+cXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
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

Ping ... on the series

Jesse
-----Original Message-----
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Wednesday, March 5, 2025 11:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhu, Jiadong <Jiad=
ong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie=
) <Jesse.Zhang@amd.com>
Subject: [PATCH V7 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush implementat=
ion for SDMA

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This commit updates the VM flush implementation for the SDMA engine.

- Added a new function `sdma_v4_4_2_get_invalidate_req` to construct the VM=
_INVALIDATE_ENG0_REQ
  register value for the specified VMID and flush type. This function ensur=
es that all relevant
  page table cache levels (L1 PTEs, L2 PTEs, and L2 PDEs) are invalidated.

- Modified the `sdma_v4_4_2_ring_emit_vm_flush` function to use the new `sd=
ma_v4_4_2_get_invalidate_req`
  function. The updated function emits the necessary register writes and wa=
its to perform a VM flush
  for the specified VMID. It updates the PTB address registers and issues a=
 VM invalidation request
  using the specified VM invalidation engine.

- Included the necessary header file `gc/gc_9_0_sh_mask.h` to provide acces=
s to the required register
  definitions.

v2: vm flush by the vm inalidation packet (Lijo)
v3: code stle and define thh macro for the vm invalidation packet (Christia=
n)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 77 +++++++++++++++----
 .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 55 +++++++++++++
 2 files changed, 118 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index fd34dc138081..554e14b56c31 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -31,6 +31,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_9_0_sh_mask.h"

 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
@@ -1292,21 +1293,71 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(str=
uct amdgpu_ring *ring)
                               seq, 0xffffffff, 4);
 }

-
-/**
- * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
+/*
+ * sdma_v4_4_2_get_invalidate_req - Construct the
+VM_INVALIDATE_ENG0_REQ register value
+ * @vmid: The VMID to invalidate
+ * @flush_type: The type of flush (0 =3D legacy, 1 =3D lightweight, 2 =3D
+heavyweight)
  *
- * @ring: amdgpu_ring pointer
- * @vmid: vmid number to use
- * @pd_addr: address
+ * This function constructs the VM_INVALIDATE_ENG0_REQ register value
+for the specified VMID
+ * and flush type. It ensures that all relevant page table cache levels
+(L1 PTEs, L2 PTEs, and
+ * L2 PDEs) are invalidated.
+ */
+static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
+                                       uint32_t flush_type)
+{
+       u32 req =3D 0;
+
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+                           PER_VMID_INVALIDATE_REQ, 1 << vmid);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flus=
h_type);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PT=
ES, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PD=
E0, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PD=
E1, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PD=
E2, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PT=
ES, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+                           CLEAR_PROTECTION_FAULT_STATUS_ADDR, 0);
+
+       return req;
+}
+
+/*
+ * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
+ * @ring: The SDMA ring
+ * @vmid: The VMID to flush
+ * @pd_addr: The page directory address
  *
- * Update the page table base and flush the VM TLB
- * using sDMA.
+ * This function emits the necessary register writes and waits to
+ perform a VM flush for the
+ * specified VMID. It updates the PTB address registers and issues a VM
+ invalidation request
+ * using the specified VM invalidation engine.
  */
 static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
-                                        unsigned vmid, uint64_t pd_addr)
+                                           unsigned int vmid, uint64_t pd_=
addr)
 {
-       amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+       struct amdgpu_device *adev =3D ring->adev;
+       uint32_t req =3D sdma_v4_4_2_get_invalidate_req(vmid, 0);
+       unsigned int eng =3D ring->vm_inv_eng;
+       struct amdgpu_vmhub *hub =3D &adev->vmhub[ring->vm_hub];
+
+       amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+                              (hub->ctx_addr_distance * vmid),
+                              lower_32_bits(pd_addr));
+
+        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+                              (hub->ctx_addr_distance * vmid),
+                              upper_32_bits(pd_addr));
+       /*
+        * Construct and emit the VM invalidation packet
+        */
+       amdgpu_ring_write(ring,
+               SDMA_PKT_VM_INVALIDATE_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
+               SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDA=
TE) |
+               SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(0x1f) |
+               SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(0x1f |
+               SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(eng)));
+       amdgpu_ring_write(ring, VM_INVALIDATE_REQ_INVALIDATEREQ(req));
+       amdgpu_ring_write(ring, 0);
+       amdgpu_ring_write(ring,
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK(BIT(vmid)));
 }

 static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring, @@ -2115,=
8 +2166,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs =
=3D {
                3 + /* hdp invalidate */
                6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
                /* sdma_v4_4_2_ring_emit_vm_flush */
-               SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+               4 + 2 * 3 +
                10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fe=
nce, vm fence */
        .emit_ib_size =3D 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
        .emit_ib =3D sdma_v4_4_2_ring_emit_ib,
@@ -2148,8 +2198,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_pag=
e_ring_funcs =3D {
                3 + /* hdp invalidate */
                6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
                /* sdma_v4_4_2_ring_emit_vm_flush */
-               SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+               4 + 2 * 3 +
                10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fe=
nce, vm fence */
        .emit_ib_size =3D 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
        .emit_ib =3D sdma_v4_4_2_ring_emit_ib,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h b/drivers/gp=
u/drm/amd/amdgpu/vega10_sdma_pkt_open.h
index 8de4ccce5e38..d3a72ffac04b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
@@ -64,6 +64,9 @@
 #define HEADER_BARRIER  5
 #define SDMA_OP_AQL_COPY  0
 #define SDMA_OP_AQL_BARRIER_OR  0
+/* vm invalidation is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
+#define SDMA_OP_VM_INVALIDATE 8 #define SDMA_SUBOP_VM_INVALIDATE 4

 /*define for op field*/
 #define SDMA_PKT_HEADER_op_offset 0
@@ -3331,5 +3334,57 @@
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_=
32_shift  0  #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETIO=
N_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_comp=
letion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_c=
ompletion_signal_63_32_shift)

+/*
+** Definitions for SDMA_VM_INVALIDATION packet */
+
+/* Define for HEADER word (DW0) */
+#define SDMA_PKT_VM_INVALIDATE_HEADER_OP_OFFSET 0 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_OP_MASK 0x000000FF #define
+SDMA_PKT_VM_INVALIDATE_HEADER_OP_SHIFT 0 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_OP(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_OP_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_OP_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_OFFSET 8 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_MASK 0x000000FF #define
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_SHIFT 8 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_OFFSET 16 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_MASK 0x0000001F #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_SHIFT 16 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_OFFSET 21 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_MASK 0x0000003E #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_SHIFT 21 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_OFFSET 26 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_MASK 0x0000007C #define
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_SHIFT 26 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_SHIFT)
+
+/* Define for INVALIDATEREQ word (DW1) */ #define
+VM_INVALIDATE_REQ_INVALIDATEREQ_OFFSET 0 #define
+VM_INVALIDATE_REQ_INVALIDATEREQ_MASK 0xFFFFFFFF #define
+VM_INVALIDATE_REQ_INVALIDATEREQ_SHIFT 0 #define
+VM_INVALIDATE_REQ_INVALIDATEREQ(x) (((x) &
+VM_INVALIDATE_REQ_INVALIDATEREQ_MASK) <<
+VM_INVALIDATE_REQ_INVALIDATEREQ_SHIFT)
+
+/* Define for ADDRESSRANGELO word (DW2) */ #define
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_OFFSET 0 #define
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_MASK 0xFFFFFFFF #define
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_SHIFT 0 #define
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO(x) (((x) &
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_MASK) <<
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_SHIFT)
+
+/* Define for ADDRESSRANGEHI and INVALIDATEACK word (DW3) */ #define
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_OFFSET 0 #define
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_MASK 0x0000FFFF #define
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_SHIFT 0 #define
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK(x) (((x) &
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_MASK) <<
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_SHIFT)
+
+#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_OFFSET 16 #define
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_MASK 0x0000001F #define
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_SHIFT 16 #define
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI(x) (((x) &
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_MASK) <<
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_SHIFT)

 #endif /* __SDMA_PKT_OPEN_H_ */
--
2.25.1

