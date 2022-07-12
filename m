Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA27EC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 03:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51349113D91;
	Tue, 12 Jul 2022 03:08:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8971A10ED1F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 03:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnvzQ+WnpKu1t8togiMqcGakC6TvVlWgK/z8PDxU3JY4VRNmP3JpuLB/iZFAZrqzshgR6sSGVXLcr/Sz9ehmDDOmfWwUWAeohkStNEeH5K4YZhKQLKxvScBDG6KSzAPrwmgz1DBcBvnSq5Ae/GVa5sm74xQ97R6w1bmepoubokW1iY0FRVma5mLcBcUoYa0VfjM59L113jbClm+VjJRrJz6alAlOILIe69gDm9A/4kVvLWo+2YQnwWoyvRii0k7LxmsckJ4cYUyVJWI0qbvtfvOLJgl/K6mA3QxWD6ckkYJq0DQ7RZl7cN88ilxczjxG5m+CZp5IhXrChLKbfkGVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81ekckO+jeSkUh5UjgUDV88P1o6vyUeLUM3fAucJb3o=;
 b=jtpeZyt8Hf4S0PW68fHZdpD7YZukCryxddh6h9cxIhhIQNMGhHRtjQXIUDg2x2s1snbh+OqPQPfvMS8EnL3l9fnp6za+PnbgbjINwfbb8gzyiMDVSyCHWiybkzeTbY7FVubtjDnNLcvkrozJ27TZtujn6FftJybwEObKPpU+dC69VkjNPBjS46F+CNqFadPc2v0etVOgWXV1L6QQ56PzfQ1KYboXXPRR+xbmjZ4xYD7pF3Oi7PKBgtv5Z9LbAFeMM8F6Aac+mGnnb55vdjzXdcj12abtNk/B2SO8xQKP/Hcg4CYHO6JpPkTpfA/Ac6LsOMOIScjtWshMz+9v6Fzuug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81ekckO+jeSkUh5UjgUDV88P1o6vyUeLUM3fAucJb3o=;
 b=uCWTp31SPwe1NyzjF7umIOKh2xn81a9AOzitFqX3JY3Pr/MLbmNTiUeqGCiKwcEk1ukBqqenixHuTvS7fg+oc4X8L25lkFrSfHIJVqajazd+B5kfJQYiXDZwwkyA309sj81FdOGVn/r8QHRPidBgrDRu0fMxNdbIQsWonuZEmYQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 12 Jul
 2022 03:08:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 03:08:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu/sdma6: add aggregated doorbell support
Thread-Topic: [PATCH 5/5] drm/amdgpu/sdma6: add aggregated doorbell support
Thread-Index: AQHYlZrc2FS7ULWJbECVxhIRN9/Ub616DezA
Date: Tue, 12 Jul 2022 03:08:12 +0000
Message-ID: <BN9PR12MB52577B98DBAE4A27BB0502A0FC869@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220712025501.2083086-1-Jack.Xiao@amd.com>
 <20220712025501.2083086-5-Jack.Xiao@amd.com>
In-Reply-To: <20220712025501.2083086-5-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-12T03:08:09Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90195345-b28e-4d1c-8e9e-0fa2776f416f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c3b2710-8e18-4b21-73ac-08da63b3c172
x-ms-traffictypediagnostic: MN2PR12MB3165:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GD9BJEVpc6Al+wmI6WxgRs+VMKJ5ekH28es1uGg+0L+LEaCYiPbu57cwidGxgYhi4hrjm3aVGpp8rCGPDn6eKbdnm4Vp+3t8zh6FlLmDA3Cyn2krCWSQXT83Vi34HVXjK1nfzUXM7mYRMtuif5TRYpi+niGGIkR4CQyS4le275pRQr01ZPq3aM+ZxCdmu8pwfmvcBKyr0FdrmgWN6BK1S/HoMwWECyxmd/e+KgE6J7yhab8OxeurZxfF67+FwzgZNOLetv/jo8ALlINXIfxengadLOWNajbES8B5MIxVq82OqZlHd9sv/RW8ctyoLnppIFLPdf+K4wQbt10PbmJKGUfa27OTXUf/+a9MMzIRxR0VOMfMuOy37nMi4UcbRqGeCTQFjJaKYmeV8a0khx2UjEEzlfGsh6D6C4Ol5Pv2nrLfJcRQBWQwMAtsT2h3ehL2qHO6jufTTTvl3ixUn69UfjtWNRBiPnOb77LigNwlXRIl+whJDXQiU8uuxU2SYAnvvQldESQRlOeBqA8EOlZgOnFYTy0YiJisx6XBjGlxw2YkuuDsH0rWmy3tcdIDhzkin8cnIb4GBP/VcLc3dbZiTKmLZrUiRu4DeG26qSI+t8bLW/Qshtf7Y6xzdzv9XaBLxekN5BZ7tUaf4z4Kj8fn3xX7ZWH4HYM0nT1QJzc1UIKzaVHdWcpQnPM03AVRpUvu/jA2xO8ojHQ6WE9/KfMHANpMVKDlUfWKIo5sTKUMVN4LFIHl+WOmhbV8ifHloVEd4cdCdPvWONQn/4gwNyWG//ntuZmcywTcabWttY+QI++SkCOe2URVQrrR85P21m4xF6/meJ+9wEQ2sY08uc/M3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(66476007)(122000001)(186003)(66946007)(6506007)(2906002)(66446008)(66556008)(4326008)(55016003)(33656002)(8676002)(64756008)(38100700002)(76116006)(83380400001)(71200400001)(110136005)(53546011)(9686003)(8936002)(86362001)(38070700005)(26005)(7696005)(316002)(478600001)(5660300002)(52536014)(41300700001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JpNdLma50USC/1L16wZ84g4OWhlknIuBgaKLi8NyERZ98tRoQ9fLGsaA6FQJ?=
 =?us-ascii?Q?hWoe3vzs4vOUtGi9Xz1FRR+2RYZQtThKXRc+eMFP61cEdjcdbJk9aaKrciHv?=
 =?us-ascii?Q?adWxa/QIjWDfEMrEdGaHkgAIek2dFmD45GJicToVVznfXCBaN9o0pf1nAozS?=
 =?us-ascii?Q?b6+4IM4JjKP6gcojCcCGkkGq+egScubMQ/FUUKEJBlQqIdlhQU5n2wsceeJZ?=
 =?us-ascii?Q?1nBQ1ooo+W1GBJ6d61LieqDzQ8cvYfzyJXPmg01dXGFWF1IH6crjdBsoineu?=
 =?us-ascii?Q?fO91RuXdTgrkVCezGb4d1EFHsfx7iIty2s2wmcEE3t6M4WHGIN4I8hh3/0pr?=
 =?us-ascii?Q?kVA55CAvw9uQxVnln5HQGK4CEtrGB0aEBCiilaLYx9vIoP38u5BenXu/ONXE?=
 =?us-ascii?Q?rul4ycpk5y64Ul7M4jKrDqldfXAVCWlnjQF8pM/fcvRTD+DqgqjqTSe/QPfT?=
 =?us-ascii?Q?DUowBE9HvrEXQZMBQgnSrvJ80LxH1r0FxMsWnoFRJiOQlCbAYfSitSQ3fM/O?=
 =?us-ascii?Q?qGJsQ2lgdOTaR5deNAG+k0KYmi0oE+YYQKKGZPShLphMlrIDL8E6KlBfM2/M?=
 =?us-ascii?Q?NfKvcygmoT9DSipwXf9buRB4+u6VqrolFSOj5i7uvKgoeHDfmfoqscskfnA2?=
 =?us-ascii?Q?JFrCcegnxv1dSoSMyIi1vded5l5/8++rEJS+lUold7LineiTmw6psyi/ywf9?=
 =?us-ascii?Q?GeGHIDG4VSeBwVQ8XAPFtRnQdqP9mmJhRHjtKFKU6SQE6AHt8UuyttWO/FaB?=
 =?us-ascii?Q?sFeUviAw9kuOAgt61L13D3f6p7yEFw/uevJC2qNHYbL6xotI47MF0M/Y1VqR?=
 =?us-ascii?Q?jmpx05SQex1ERhiQGmCfmskgpaE7YFpDrqNQ5d4xveWhzAO3dMyPHQtbyPOJ?=
 =?us-ascii?Q?o/DNPbaaXGzkPz8E73RQZ6TLmOs6Nf0weAymg+Qd8YPr98hZMrDYf33sUE7N?=
 =?us-ascii?Q?mr7CWoEPWBBUKPQBKXeUp/CWv3VMVgA4SxE25/xu6aANR/K4CohX/lB+hOzf?=
 =?us-ascii?Q?WGSYEd1g4QIRio/Ov5yLD3H1MXqhoQMTl3Q/fqFJyNiUxFkOVpgJKyDFPgi4?=
 =?us-ascii?Q?7JxA3tES0Xyk8+BFDRG6Hrihc5K/wTriaA5elCH/hUM8cW1rk8mJcNf4m1+Z?=
 =?us-ascii?Q?dzidPyLgMF8rk+/XJ5Wavu1i0xq1Uepx9sdHGEOcsk6wpsuV4+/6MemCf/JI?=
 =?us-ascii?Q?1ntM72l+2bXuFrj2fybKeOe/uoj5f4LxNorctn0GejYtDGQ2jxiYLqcJQHzk?=
 =?us-ascii?Q?iqw1rrfcNMdHTjcWKMs8YEBfpljrRiQ827XYh+kbUP9JrUDz8Cg79pUaGPXT?=
 =?us-ascii?Q?Yh3JUN9uzx9cGhBc2W7ar2vXBXcj+ZeE7Sgrs21N5uWXy/186aVHv+VscpUh?=
 =?us-ascii?Q?AkM8BQA1QIWnnKHVFRL0gd3IYxlUeO4Lpf1dLG7aZKzShNbcjSXnL6UZRd4c?=
 =?us-ascii?Q?wrAdUeyAIGHM3BGmwYuuDLMcnrQTLcNHfujTD5IE1sNAXOCvI/Gg1m7SUotg?=
 =?us-ascii?Q?vk1IpE/ifuFe2z4TTBwRncel7DRWqig5SoX0xYgftKwt2uR8m7hpZV0Va6Vg?=
 =?us-ascii?Q?jlmlnpf4ADlC33QfMifiHu7IrevqxM9dwUlUpQBo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3b2710-8e18-4b21-73ac-08da63b3c172
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 03:08:12.1677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCBEZkpumtoTCqGp9ps4LbG89u8bp4Ukhnw4Un/Dph767NDRi3iP+srFCZwkWD10zOc8v0Q2vUQNpg89ojJjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Xia=
o
Sent: Tuesday, July 12, 2022 10:55
To: amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/sdma6: add aggregated doorbell support

Port aggregated doorbell support to sdma6.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 80 ++++++++++++++++++--------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index 8cfaed55b192..59c8250e5fe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -245,34 +245,68 @@ static uint64_t sdma_v6_0_ring_get_wptr(struct amdgpu=
_ring *ring)  static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)=
  {
 	struct amdgpu_device *adev =3D ring->adev;
+	uint32_t *wptr_saved;
+	uint32_t *is_queue_unmap;
+	uint64_t aggregated_db_index;
+	uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
=20
 	DRM_DEBUG("Setting write pointer\n");
-	if (ring->use_doorbell) {
-		DRM_DEBUG("Using doorbell -- "
-				"wptr_offs =3D=3D 0x%08x "
-				"lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
-				"upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n",
-				ring->wptr_offs,
-				lower_32_bits(ring->wptr << 2),
-				upper_32_bits(ring->wptr << 2));
-		/* XXX check if swapping is necessary on BE */
+
+	if (ring->is_mes_queue) {
+		wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
+		is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_size +
+					      sizeof(uint32_t));
+		aggregated_db_index =3D
+			amdgpu_mes_get_aggregated_doorbell_index(adev,
+							 ring->hw_prio);
+
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
 			     ring->wptr << 2);
-		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
-				ring->doorbell_index, ring->wptr << 2);
-		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		*wptr_saved =3D ring->wptr << 2;
+		if (*is_queue_unmap) {
+			WDOORBELL64(aggregated_db_index, ring->wptr << 2);
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+					ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		} else {
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+					ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+
+			if (*is_queue_unmap)
+				WDOORBELL64(aggregated_db_index,
+					    ring->wptr << 2);
+		}
 	} else {
-		DRM_DEBUG("Not using doorbell -- "
-				"regSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
-				"regSDMA%i_GFX_RB_WPTR_HI =3D=3D 0x%08x\n",
-				ring->me,
-				lower_32_bits(ring->wptr << 2),
-				ring->me,
-				upper_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, ring->me, regSDMA0_QU=
EUE0_RB_WPTR),
-			lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, ring->me, regSDMA0_QU=
EUE0_RB_WPTR_HI),
-			upper_32_bits(ring->wptr << 2));
+		if (ring->use_doorbell) {
+			DRM_DEBUG("Using doorbell -- "
+				  "wptr_offs =3D=3D 0x%08x "
+				  "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
+				  "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n",
+				  ring->wptr_offs,
+				  lower_32_bits(ring->wptr << 2),
+				  upper_32_bits(ring->wptr << 2));
+			/* XXX check if swapping is necessary on BE */
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+				     ring->wptr << 2);
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+				  ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		} else {
+			DRM_DEBUG("Not using doorbell -- "
+				  "regSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
+				  "regSDMA%i_GFX_RB_WPTR_HI =3D=3D 0x%08x\n",
+				  ring->me,
+				  lower_32_bits(ring->wptr << 2),
+				  ring->me,
+				  upper_32_bits(ring->wptr << 2));
+			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
+				        ring->me, regSDMA0_QUEUE0_RB_WPTR),
+					lower_32_bits(ring->wptr << 2));
+			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
+				        ring->me, regSDMA0_QUEUE0_RB_WPTR_HI),
+					upper_32_bits(ring->wptr << 2));
+		}
 	}
 }
=20
--
2.35.1
