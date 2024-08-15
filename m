Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C70C531DD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 20:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579B610E543;
	Thu, 15 Aug 2024 20:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zvuLF6k7";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18BEF10E543
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 20:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqUmDs+q2ujJgFrkDeSLQkJXQrR2990SwOmsOPX388Me0C+Hs6HTsNyNvujVsQF2ycTPVOIazw9corKTAKgyy5YEa/fF0WyZpSOlC6v15y0qESTaWyMV3QHiZoKtOvdtRvhfbLZY0RSjOXPbxcgt+KFtziTYcMpgvLSZoBfsgZYMUTYr9UEhM8PAO6sntmniPnjco55XZ1eosVOWoQ70indxOHN9VEHm/C1MT/cb57cjszTRnZPt5v1BBtbO3L/itC2LFYu5MIs6CgXIeg/T+jylPU8KisDpPK+MqVePi1hhEfIsrYXL9vtD86xGOQ+r/2tHYFNy8XHfhhSBGNjzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijR7Tv1F1K86JONSUB6D+BZ5M5G5vgq/xWDhkhauCR4=;
 b=vqPOw4BtHnDAVKIABXUP+C2XEOGGW4JkDoSZEhlr6t/42CKU4zd4aeuR8/enElYVThwAN6X1BqHyCgdfixsgQ6GQD8VAg4gGIQFcRhvHfmZQaoAL4o+zfWbtpFvIE7AQDuMPlPyKMMDXAnpt2xoBC1Hcmk5Ma/mBYQNMt22ap+zUEnxAbvA5keUDGAuYBNykVM9Hy4IIKI4Eth0lL2PA+/kzPjvKakVTC4Utffv0wcxNwdBXcuNj7+EIM+MHqmAg0uBSNd9XB+zlRmcQSC6EBHxmB8avhjzu/NkukC67Shw4SFGHpDO3nMevrZtJ/JHWwG/t+F0eVZ2Xm39oRqlwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijR7Tv1F1K86JONSUB6D+BZ5M5G5vgq/xWDhkhauCR4=;
 b=zvuLF6k7Xom7xKZ6fbwREdxG+qzn/w1aZBpbzbokbMy7aGniSGAPNTZTvbGyiA+5ArnhDDV+SLxlV0JJ3Fd5cNk6APr4xOYZ3kEaZBzmeurxaNaFzhun1u3EtvYI1oM8KuMlToRHvIv9oaDycJpROmv8NKLBcNo7uvZRdOJGwH4=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 20:32:33 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 20:32:32 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1
Thread-Topic: [PATCH] drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1
Thread-Index: AQHa7lhX9Ow25mUEn0GP7d8fMgKXArIox7mA
Date: Thu, 15 Aug 2024 20:32:32 +0000
Message-ID: <SJ1PR12MB6194A601AD91CF5DCB69F32F95802@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20240814144313.711802-1-alexander.deucher@amd.com>
In-Reply-To: <20240814144313.711802-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4ab87f8f-be7a-44c3-8075-80770d4c589d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-15T20:32:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SA3PR12MB9177:EE_
x-ms-office365-filtering-correlation-id: a0585166-3fd5-41ab-1be0-08dcbd696426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VnkWSMKdvhAS7bt2ihgIFfk8t4M3qZwXZaiGzEOf1Xt3XcpByyoK1eca/iId?=
 =?us-ascii?Q?EXcBhU5OUx/QPs91Fh3PEFeypafBVuXs3eB8AATAiV5fyYDR385Fba3WlP7L?=
 =?us-ascii?Q?HHI3acP3ox3lEgnjlnc3k3LzKiyag6D7NlANgS77AYzjgLZPFsxuAsj1mJSi?=
 =?us-ascii?Q?6xmUJZHRc9WV8X4DkI/CD1EtfE10Ufd0YN7bfemHSapYM4qzhnSjOoo+gwzC?=
 =?us-ascii?Q?jKtYBHyFFes5hmiKuOerRXHDFOUrsEhGjOve1E4MoE+syWEbz2sW5dZhINca?=
 =?us-ascii?Q?qRktzQ3rK1tXJejMiLYgZcJPKsv5ogfqe85R0k5COs2787xgt92swGNvwaSf?=
 =?us-ascii?Q?Rkxd/5G3UZ3/uwH9e4EKVe32jbL2gA264YFfyERyAi+npu37RGBr6zLdaeH/?=
 =?us-ascii?Q?6vM9tLwIAHttN/dDTvuNep1ymLDcdweaeD9Kmw4m/WZ8ao+zbJH2ha/L+N4j?=
 =?us-ascii?Q?tBOKR/5WxhxRASr8zbR8QijyHAkrYjo/K9yZgQLl9I9VuA/XtvNSR/NrtEtK?=
 =?us-ascii?Q?ThM1Piq4Sa9xZs7vOkvTbMN37oJGiEkmki1YLZe4+1zm9zD4MmIJrm8WiTgJ?=
 =?us-ascii?Q?ALfD1yZJd/gUTZ4mD59LmK0w76BEuKMA1/Q/2iZfZMPZzxmBy4pRm+PMS+4i?=
 =?us-ascii?Q?XsD6qqLJDKxutkj/wmN+lBuNYrNNOWXxSw2UjPp0LP+6WsYhrdpTCatzMg49?=
 =?us-ascii?Q?Fj4VmgB3DLPKLDtsn9zoT3O046i2vhgRSo8BD9sn+BvaNRol6NJLRMhti+8Z?=
 =?us-ascii?Q?q6xPP7dCTlUCh+LBUTj1fjfzUzEtzIsjXZG6uR+Mil+4CDswX17ZTu+Y+duW?=
 =?us-ascii?Q?RzyoRCvZ+xkKV5zNPNncmHm+qMs4oogW0PK/VF+fcfq0krGjXTqfWFSQi2Al?=
 =?us-ascii?Q?2dNb2Kvw7Ee9v92NevL11QmsIcvZvdheHJry8CaoTPQdJP0DVYob4jMWbalB?=
 =?us-ascii?Q?xsijLCV2rxOUEZ+1Qg6JWkZFW9hapz3zSr08YA58VIKtBIFWEwC9KJPSWoFz?=
 =?us-ascii?Q?o3yfVSKjDfpUsztOrmn1sIipPD/a/nFOq6ffb2kaJtf2KrxN0Wndv7DbLJvh?=
 =?us-ascii?Q?r2lqDHEs3NeD6SvUqZcx6s3x50Z2/nuYP7E4Pva82qw+GTXb0gCCx0R4v0DC?=
 =?us-ascii?Q?BN4msULyLK8Nowy5OvNZ7YI2XD/slMaMOwM58f2tN8z7M2G8aiv+vmp+Qdtz?=
 =?us-ascii?Q?1aiDVY4qNK2Qq6a8M3yRspLIqH2Wsbgl8+j6LDZvSRI2wQ7OSmMrVdYwVeyk?=
 =?us-ascii?Q?iUHU0OE3j0nWwYvzZU+nJkuXm+e12h4GmJpFvZtImukeKJGPdS6cW2dmQhCi?=
 =?us-ascii?Q?9tNElF8wao/0UX7kJSYBdi+9GeEl+aSrHr53ON3nf46tz/KbG6qYowoirv0V?=
 =?us-ascii?Q?NNOqv9Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ndpF3caYHKrrBXgnmXkCA4vC3zqWL+OlGX4MsYcqURTFEHNt/jaXu8wJh8Q?=
 =?us-ascii?Q?shZxgPLCNanBklvdNvTHxtzmit8wPzSeqrTWK50Ugjtz9AN+KH0197yUZvt8?=
 =?us-ascii?Q?dyriyKNxBb1GcNE2tB1zK2ZlD2pTB5VyrPieKEmrFGpBnVvmTrc9afC+T6/e?=
 =?us-ascii?Q?DiMRhpH5wc6TjVAr843EdKzU9AXcEQqXarLivke6XvkdIYl4s3UKaMLGnoNi?=
 =?us-ascii?Q?HGUSzL6wjXesxos/5PJOiq89GCtlgiSJJ2Ioy0U/IxgM+CDoX88nrmnyNslk?=
 =?us-ascii?Q?o8ftvPO23Xc4xTlG1ULOJ1/bDpWU2wEwtoOCF3bMTt0dt9SfyV5f4UlH4JJ4?=
 =?us-ascii?Q?BkTCvaZCBt4RmYJ2YV5R0JUEgNuFK4gaXQouAaeEr3i/trbcsjCNKiYFanva?=
 =?us-ascii?Q?8Z1TNRYHq8Be02GyG74Ys3RefhkJDCizNFMg95S6D8JEXNplGHimaaHXzzXC?=
 =?us-ascii?Q?Oa5Or07OXA3epdePkG8JZDPPZHCEfC0XccRoWW2yjuKb1IQH+LDOCv3fZh6j?=
 =?us-ascii?Q?pywa0v4hBngC+wO64wCrCljfIJ0QhKxAAT28ZJZyqJWFV3IsdUn8F50kOv57?=
 =?us-ascii?Q?MNq5EWKuljDOMES+gfQtEcq9pcipi61FYkUkqt2MSFis3Lq/fGrsPfNT7jEH?=
 =?us-ascii?Q?yWQqCK46KrYhr42lOwiazxO9MtfkqRTDquN8IkMFOvT+YJ3vO1ep+RGPDm2L?=
 =?us-ascii?Q?GVRa0O2pWY+kP+lOZRo4R8cNESF5uvb14jPLUzpAQUg4oI9drb4L/OQ0TJfM?=
 =?us-ascii?Q?KBH0/ty3ouX7/JQ4LsD5Ml/qMjECs9qv2ONvS7yVs8zIGdBmWEvMh/xHeCRU?=
 =?us-ascii?Q?w+5Jzzo/KsPWaBcCSlKMvo8rLzt8WLVXaA8wKEC0nLY5iZt3/vagYv/mmfka?=
 =?us-ascii?Q?wNDR/Do/WBigB1RLKkty28LjPb6P/pYw5fsScVI0CQ4N0IPPj4dFEKiQZohc?=
 =?us-ascii?Q?ec8yAw1UsMWbsbqQ44bU70U+bU56ER7iAGR1VosnixIwG9LVhe1nAAOLOMsi?=
 =?us-ascii?Q?TQ6RJ9OeKIJ/7wvWq5ZR32NX+jA3WvG41I9rabT5guQIUSriGckTLFyTgGNe?=
 =?us-ascii?Q?jyhy8RfTFCFYA6yULcW2STtlWDCt3HERWpKJie3YnsO7nxXc3d0M3TIfzTJT?=
 =?us-ascii?Q?50WlxBeMGHcq6isp7Jl10uvs3JAo1JOhUGpwwvbiTbbBbOWWBk0EG+8GPCk5?=
 =?us-ascii?Q?DMRJWEosC9xPZcPr4R9UoC36oaat2/klovFgsLU/jBgZrPo5eCuybENjxh3G?=
 =?us-ascii?Q?mA45aZK5xFNaH/iVqT4PNSfOVw3CIDICaCZsg6kDcBtJiZ8RMohH3o1LMBF3?=
 =?us-ascii?Q?RiyiciKqx45Y3m7ZVbAESYXMvejEUUeER9QIJCtSeKUjrhLLjeLdlWKcoAAG?=
 =?us-ascii?Q?an+ocSfYhbPIn11AwCTKgjWEGUdx+BPwH6wP1XxgCscpPAuaxT4dgU0s5+s7?=
 =?us-ascii?Q?Aw9d0ch5icw6TNBW80pOu1okXa55QLh7DF9nzIm01KAwtuSp6vvHlKRuRWaS?=
 =?us-ascii?Q?9XZ8ehq8ywCbSOyoOAidP3ytAmfet9vjhkbhnclmKw8s23wm0lks/iyKTvMt?=
 =?us-ascii?Q?EP2CRNDAr3agISUPxB0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0585166-3fd5-41ab-1be0-08dcbd696426
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 20:32:32.9022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkRfPQt/d3iANG1LzuO9GWCLbNZLHoaVRqs5ZYP4qNLrbfOS/QxZn4YlUAT4H7UT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
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

Acked-by: Ruijing Dong <ruijing.dong@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, August 14, 2024 10:43 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1

The workaround seems to cause stability issues on other SDMA 5.2.x IPs.

Fixes: a03ebf116303 ("drm/amdgpu/sdma5.2: Update wptr registers as well as =
doorbell")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3556
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index d740255edf5a..bc9b240a3488 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -225,14 +225,16 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_rin=
g *ring)
                DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
                                ring->doorbell_index, ring->wptr << 2);
                WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-               /* SDMA seems to miss doorbells sometimes when powergating =
kicks in.
-                * Updating the wptr directly will wake it. This is only sa=
fe because
-                * we disallow gfxoff in begin_use() and then allow it agai=
n in end_use().
-                */
-               WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX=
_RB_WPTR),
-                      lower_32_bits(ring->wptr << 2));
-               WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX=
_RB_WPTR_HI),
-                      upper_32_bits(ring->wptr << 2));
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D IP_VERSIO=
N(5, 2, 1)) {
+                       /* SDMA seems to miss doorbells sometimes when powe=
rgating kicks in.
+                        * Updating the wptr directly will wake it. This is=
 only safe because
+                        * we disallow gfxoff in begin_use() and then allow=
 it again in end_use().
+                        */
+                       WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmS=
DMA0_GFX_RB_WPTR),
+                              lower_32_bits(ring->wptr << 2));
+                       WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmS=
DMA0_GFX_RB_WPTR_HI),
+                              upper_32_bits(ring->wptr << 2));
+               }
        } else {
                DRM_DEBUG("Not using doorbell -- "
                                "mmSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
--
2.46.0

