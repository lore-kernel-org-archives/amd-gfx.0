Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2420C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 08:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFA710E208;
	Thu, 13 Mar 2025 08:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fzAn2Cq0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D62410E208
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 08:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee9hXZlsmIaorYAMKV04BXxUpYxfSoY+Tl2CzsPoSBYywEe7apLmre+EnxeNnqA6MUdRybQ3b2xnoaZgDJJgMG0x0DuUN2EOZjQ82MVmxmb7QtqriyV0AAMlWjM4RM2MxjvGlVMzMQDhDgdIbdZsPyS53+jiLXXMEKq+Am93b2QbeegRqYz4y6OIiZrdjF8yOpTvwxwl94bpDeDcomS6u0z3oGBjvgLDy7feZ2t3SQOiW7b0DzoitAlfCd0XRXXYKImOf6DT3ceOfEpfK+nRrpAOZ7IRE0VlEN1DGH1rxhcUC6xD3DG5PAQUqtEcIjn6VwHybAUZbWI2IQRRrHiw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4rknDXG5mqTxuEhYoA1RIXCqaRwy+5Kn2EYPF/gNso=;
 b=j6Aa122aPEM0COa9BPrRe3nJFEW+7Bd1ewuvUsm17Io2WL+ShbS1VLbHE51FjhZf8P8B0IxClunveSghjE6wgcz6FfwA2Gv1an5EtvYhZkRURmqiYWtl1hOcUfKnv0JqLVSQ787SgKI4S48gJRTILwnPgMP/cba1TviGYVeCpbuIqLGSOhS4NbLP+E9F0q7WyLnPc8JNm5M4U4PEMrFD7i67QdpCODkS10hUfZWHwdyiBWDmHhuTKgCTSrR2N8LScGw0MRZ24lSD5JbrMQajbIAL7h+P7JpMASz+mjpJPQWvMlUAzkH362o/mR4Cs4+uutwcIHRY4McGKcs3Lg6vbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4rknDXG5mqTxuEhYoA1RIXCqaRwy+5Kn2EYPF/gNso=;
 b=fzAn2Cq0atgEI2od4SxFqegR5GviDz3UBSK5j53tnSr4YSvmNMwcO71gL1PLUdkgyK4ikvhMb7y55Ba7EdWT0s75/YOv1hrqxGRfkZKtKfj6H8V/hF1bVVCDY/lKDHexzB3xH6waQggJKCpE6DnyPpdcvxkb0/V51DSPbs+600Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 08:12:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:12:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix computation for remain size of CPER ring
Thread-Topic: [PATCH] drm/amdgpu: Fix computation for remain size of CPER ring
Thread-Index: AQHbk8f2EJejEBnJFUOsDXkkSIAU17Nwt2vQ
Date: Thu, 13 Mar 2025 08:12:04 +0000
Message-ID: <BN9PR12MB5257BB1580561A05442FB844FCD32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250313032738.428588-1-xiang.liu@amd.com>
In-Reply-To: <20250313032738.428588-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e23510e1-3352-4983-9b9d-3766e59e840c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T08:11:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6772:EE_
x-ms-office365-filtering-correlation-id: 69bc7fef-0aef-490f-12db-08dd6206bd75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HJStKnYOd2Iv9TGMrmR6J0s5BPSy/PHlOFx/HBrwmaFmop9plw8gwAiDZMRG?=
 =?us-ascii?Q?j30dvzBKTqfP8UyFtgWlaK9F8b0t2QQYShhCQbQoMV+aBJ2wTt2m2b+XhFS3?=
 =?us-ascii?Q?zRT3z6uVYi1MVzC1toJyWjsQ6mxpz0c+x53bjmHqshRPewU7kAZ16c9YMe98?=
 =?us-ascii?Q?oh6TkiSJHoM4SNyTv2CWHj0NDe2hCsnQ0Oy/JC106//1PfWkh1GZK5R4UUA3?=
 =?us-ascii?Q?lFyLbFg6NdxFlX7QcZHndMvzFySCGVDPifSVAx9vk3+k47yfWBb662/tG0JG?=
 =?us-ascii?Q?ifGzl+7oWliFtDYbiQOGnNfnO8byd4t33wwwYne0KZTr6YLiuBSZANxU8wEn?=
 =?us-ascii?Q?SrMQKnNhonB/7L9IooRaToPDHUBcal9UGNCAq/c3JKagKnt7aMwr0sqMup3B?=
 =?us-ascii?Q?YvgzsPTms4mUe7eH1lJlvDtLFXApBWOPKB7s4UZdFzhbkBtkF0sBCVwZXcLb?=
 =?us-ascii?Q?Vzkot5xmchyVqZen/j03k+/fI5yxxDluU81CeChnq4ANf9UuOPq7Xe5brf6W?=
 =?us-ascii?Q?z9Lpo1fAooxZrRYBcRjaVmGeEsKAAVYoIv612xjmok6W7g0GXa4f9fwcinj0?=
 =?us-ascii?Q?ygDZtkma8Lp7ZDvnf9K7z3MiKYe0sqUlfPjpxhj0rNrHzCnE3x9X639HtjCX?=
 =?us-ascii?Q?MI7e4PJgd8fLMQ0b5xeCgxJQemvStnVMUS5OCTVyEgoiWgWqRv6RTs6tpJQo?=
 =?us-ascii?Q?JGbXZfE456YkgkteGc6F7eC8B0EI7b9Hiv55+qYf3aJ1MvCQSm4U3XyWwOQB?=
 =?us-ascii?Q?3Ni/UyRkxjgEhqqFeiTMQrhnSYki938cM2z+jDZXTiREyIXIYg4UH9Lzkvxe?=
 =?us-ascii?Q?8h/yn7t8xv842Bz4ReYAIe2geF1lHIvfrDOjlWMo115bZ4tk81JjVm6yqvph?=
 =?us-ascii?Q?I05ciFnJu4fHVTLqanr/bJKjFAd0/lkXkJNdjNtYcQ9L0Tc8UUnbVv+X58op?=
 =?us-ascii?Q?lnqlFJme7DgGOlvuXlXvT9/oi7t11PoqgeoWtlST9/krmYyqo03wWv083uWn?=
 =?us-ascii?Q?nDwEUZ/+lNihajNECZXRl5VZLb60Gb+/UvJH/OqO4caANIhu4YGKthBdcOns?=
 =?us-ascii?Q?zEyEsI5HGDQBeG9F9NKqU3rO49SmXf3SxVkzQVO324XXyrzelJsm5A5PHq2E?=
 =?us-ascii?Q?twmt4kI+d3CWOkZxbYDQzfoaiw7j0vcFhQcEbjqZNTd4h4KnX8dVjqEq+7GL?=
 =?us-ascii?Q?E0Va3VpNKkdi/qfZqevFBuTjh82/REF+xFv4/WI+AmvCB2Aj0j2F7/Hxy2Ah?=
 =?us-ascii?Q?eOZmo2PBvZW3TtVENJ92EgQHh6S2x6yrkLIDQSRYX2hoL76t6HoaEQ71p4GM?=
 =?us-ascii?Q?oxPz+C2ACriAu9lbkTPXnrN7elRG88gOO5QL/kAqpV1wNbkH4gAR+bolontY?=
 =?us-ascii?Q?eEe96kmBJpdpdodNaqisq2xLap2+2AURmrpw/la5+ZVfyhm29SkLlx83AvSq?=
 =?us-ascii?Q?jpFeodtwJftTeXC8AMUyvP4bqaU9Tm1j?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rHQA5D0AgtRpUZ/GWY5oRBeev9aloIEQ1DfV8J7dl3DOIv+WCZEQd7baEoCo?=
 =?us-ascii?Q?wKwuhhQQIsnGgF4yd59k/Euj4VTiV3mDG40dxxnVg6m5R1nVlUTZNiuKBeF4?=
 =?us-ascii?Q?PNWDdQMBUNz43SbvI0QrzRdf0EntYjBsJdJw6fjvlPVRRWmX961U80zsjiXR?=
 =?us-ascii?Q?cgrAQSNnWeahM4eYGhL7eJhRx3aAbAS5aLic8IFLXW6YGY5mPoaIpfy/51Oe?=
 =?us-ascii?Q?L4P+fmOg0/MxMIgkYYcFYtFx2PVT2aAB1bfSlzL0fDYLYu3F4DNg2xx3HdYO?=
 =?us-ascii?Q?d6308kKnF+NKd/G4z6p3F4jNwxEFKSrmdIHjCNzrFA9UI3xVlydT/v1fXV7z?=
 =?us-ascii?Q?h6lEpHZ9ddqJwjstwUkS9ILSdBazd+wJz+9Mmsogpp2P5gVh0pBMY5xgcfeM?=
 =?us-ascii?Q?hAgFtTociRdVXnJCnvMFOYjd1m7X34Ph8KOw5SrjpYUnDsQ1YYwws0WZIWY7?=
 =?us-ascii?Q?iNDeQAhmvrcTXkJtZOLpqzgIXAnCKIkcB+hMj2T1SeFct6Lpuz6D/7822g8P?=
 =?us-ascii?Q?WmCpdaWwHSaf7xEgn6aVpeAfz+DhTW5Xcz7e1lkIcC/sAVEs153pEX5QFMar?=
 =?us-ascii?Q?w1qKeOYetpoLu4ijj8AMsyC3Qwqpp7xcUGqSS+4LELxbGKGxR2dpId1aKZ7G?=
 =?us-ascii?Q?g471ccAjr1XfnFaXSMAoO2MBfJ2Vly72qOpr+gDZ+ZPYelFPKmcyHodpdokj?=
 =?us-ascii?Q?NIQKTeOK9T6Ww+J46TO79cdutTs0EJR+YiM00+wY6AWydT7gRqkLG9bg4oYa?=
 =?us-ascii?Q?LDnJNyz6nMYXR94M3h9adAliWAej6yIP1KVOBSY02wGjtXRD23sDUjkbm7X+?=
 =?us-ascii?Q?nfhTT0WTFCJSLf1CqiG7w3gVXIUc52wzUtQhStXtuwcv05653HVfTbZZ/Uho?=
 =?us-ascii?Q?hp7jgdnr0mXy11uLEbhyngmlnUMwttAJ17Hyo9nf/5tvn8WLWJXXAxMX7aXg?=
 =?us-ascii?Q?u5O1Frku8o4QUrgQFlghJ2XpRwTtPw/W8Cxkon0bDdSRu/RGvkDxqlMtDUT5?=
 =?us-ascii?Q?vyZ0AZn7U2nbLVioQXkvcPYRM9IpgpSGlLQrK9hwxelavbyc2Lc8EfWC1m0t?=
 =?us-ascii?Q?grQBKTcDl/dRLWf4GDbGp03CfyZDVn+LP21QhsCwJKqYD4ADh9jJJw0+8TE1?=
 =?us-ascii?Q?3sn+DSfM4mz3vSW3QcyVfXS2gEJbkVNdUP3tA3ZQbYTd/RFffNNap73otBy1?=
 =?us-ascii?Q?IRzT3/eBnffgXYa2xuCXuNN6uq7r3fE08uj5d/HETvKO89WSxLeGcUc6/V1D?=
 =?us-ascii?Q?I0rkt5VMd81hwf9q+PiUDdYaodgl8aSPHRmIJz7PV+wBWsPCvYkpCPAiXobP?=
 =?us-ascii?Q?qDPDrDuL+K4h/GjMNb6fkvoIIjb8yZbnlJF/qPhoCLg7CJ1z6uukwQ1sjsVW?=
 =?us-ascii?Q?8c1ZbXaqYDUjOeFJ4Ijx0iwCGeVRg4vVtVH63s//LBFCnVMxa9xwk49q9/PQ?=
 =?us-ascii?Q?BSqH5gylSjgCVrpic4sQauOrtDGeID/lLXWjj3oG2LVsMI+sNS2E2FPQxcVM?=
 =?us-ascii?Q?2qxbardp6YwApZPsaUymZDds8WhK435MFNlHzfw1rlTV3oCOEhrPibbbXKT7?=
 =?us-ascii?Q?QtHnxlGfmoc05JBf9dPCFsHQgl33h3sVEx+GLyKW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bc7fef-0aef-490f-12db-08dd6206bd75
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 08:12:04.3842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rV4xvqlF1/kVZ86YvTcJQRheSrInDPuiq/ur1AEpdGws8zt1jsVf7G5DfNdlClh0SQws76NfVpPZbtyqDrVn4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Thursday, March 13, 2025 11:28
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix computation for remain size of CPER ring

The mistake of computation for remain size of CPER ring will cause unbreaka=
ble while cycle when CPER ring overflow.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 47fe8a04e26a..d4e90785ee33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -452,10 +452,10 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_=
ring *ring, u64 pos)
                return umin(rec_len, chunk);
 }

-void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
-                                             void *src, int count)
+void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int
+count)
 {
        u64 pos, wptr_old, rptr =3D *ring->rptr_cpu_addr & ring->ptr_mask;
+       int rec_cnt_dw =3D count >> 2;
        u32 chunk, ent_sz;
        u8 *s =3D (u8 *)src;

@@ -482,6 +482,9 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
                s +=3D chunk;
        }

+       if (ring->count_dw < rec_cnt_dw)
+               ring->count_dw =3D 0;
+
        /* the buffer is overflow, adjust rptr */
        if (((wptr_old < rptr) && (rptr <=3D ring->wptr)) ||
            ((ring->wptr < wptr_old) && (wptr_old < rptr)) || @@ -498,12 +5=
01,10 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
                        pos =3D rptr;
                } while (!amdgpu_cper_is_hdr(ring, rptr));
        }
-       mutex_unlock(&ring->adev->cper.ring_lock);

-       if (ring->count_dw >=3D (count >> 2))
-               ring->count_dw -=3D (count >> 2);
-       else
-               ring->count_dw =3D 0;
+       if (ring->count_dw >=3D rec_cnt_dw)
+               ring->count_dw -=3D rec_cnt_dw;
+       mutex_unlock(&ring->adev->cper.ring_lock);
 }

 static u64 amdgpu_cper_ring_get_rptr(struct amdgpu_ring *ring)
--
2.34.1

