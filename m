Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B32CF9C71
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 18:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA6D10E293;
	Mon, 23 Sep 2024 18:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sYirtIpy";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9278010E293
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 18:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2FkpgSTODIOn7iZvcfqRpFYnW9DvPGCEZ5a9Wz50jdQGrbQwH9fVZko5ODrpvold96KvCUfUdSqkHWDfVInyk22LATrg7pIU90ceiL784ulRb5O+XvbAJai48NKPE6aAmbwlmOZGM0T6yzT9v0qa2Jv1A/N0ICGO8wSzzIH+baGS5uuPjkbgx3BiLJrx5Nq2kOWm3qCL4NOILC5m2cf32Woe32xki4Z8ZY7aYy0eYfQV9tiUh4+Rnbc8mo3pvi2x2890hjKWkPEBNCF/bfctIuYBgCnnftBdf7D3I46KUP1s5eF/OCP0Kc3KB0qSeXdQ7yQnEwCH+PcakHGHsZ3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87jKPB6tSu68Dbd1bw3g4OurdTlB95Jk5nRIdjC/Vmk=;
 b=POgmudGRDq45l2AHiLy8s9NIp4IsPwOq3JOoYWghxPolsfoW3Iudb6qW1l2fQ5c5p5B0zTgMFlZ896m6NldB6b6sEE7s8qTzasYGEZy9qF7XMohe6Bu3rgYbYGHNPJobaajt2FJOE1XOJ++p5sMCnumqEJmYMtkXUOfoxudVppdunwcOIIA1ev/x87v+wcssYt880GTaZCYIBkNVeioUQB5maSdpF6t2Y117V+kocKgA0OY5Gkv52LOz9f/E8N4BejXS2STM3ZBX/VUrbt0y//T95BMgHfF0w85oWSWLqOxRxdFjISMO5gWSQw4fI2LdwPCCzys7FEe1sewQ0jE6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87jKPB6tSu68Dbd1bw3g4OurdTlB95Jk5nRIdjC/Vmk=;
 b=sYirtIpyLgAklvDfcYKtJRPvW47Le985DITi5cg05vaQqXVNXlnidKcuDarzNjFhlCelKvDvuPtFjHiPu2hJY2Wgw88Bw47iPVh5t2I4cXvKlMBIoHX1ZlnpAMgGwir1UVdoNL1hYyIyvX5+nHJMsyeQ83k1pUGGHrVDY2Rc7Gc=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 18:47:13 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 18:47:13 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv3 2/2] drm/amdkfd: Fix CU occupancy for GFX 9.4.3
Thread-Topic: [PATCHv3 2/2] drm/amdkfd: Fix CU occupancy for GFX 9.4.3
Thread-Index: AQHbDd/DlWg+YBl20keK2cbelNicyLJltiCg
Date: Mon, 23 Sep 2024 18:47:12 +0000
Message-ID: <CY8PR12MB709924971A2EC4915B838D798C6F2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240923174046.284250-1-mukul.joshi@amd.com>
 <20240923174046.284250-2-mukul.joshi@amd.com>
In-Reply-To: <20240923174046.284250-2-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=07227fc0-63d5-4a33-b62c-ed679daeb4ae;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-23T18:46:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|CY5PR12MB6324:EE_
x-ms-office365-filtering-correlation-id: 876006c8-6fe8-4097-17dd-08dcdc002356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4Cp6awV1WYS2C2uaqZC156KYSOPjBgFMXiJBUO/EtznMqCIGxijcNx5j4FOn?=
 =?us-ascii?Q?QLdB3eR/wuoLwf73DLpPFxQMbULYqC8lmHVO/aFIPHs2w+Ic+awWC7MROF4X?=
 =?us-ascii?Q?AIjjjqlL9jkRFa5z5J4aPBLy2avg02pbU+vR8gWgW/B97vFadN9URhrzG9dc?=
 =?us-ascii?Q?vzvZO4/rFyvDWyrvgr2sUGHhGb4GyhfQrk0VCGJVS86JfFj3tKtaqvcBC5Tf?=
 =?us-ascii?Q?GnRFemNoibylZM3miRQ8Hot8NR/IxSuqLUKcWTmjcUXkrnXJY2kT8XsoKNGn?=
 =?us-ascii?Q?dqhLwCYfkWm0ZHjnWSKqnHN4LSswAp1HS4FEtRNngMGXEIgAvw1bf2mk8u1O?=
 =?us-ascii?Q?qZG7rVkxUpQ5cNoPMbQwmyDop0xkoRT/UmCqQUp1jWA9vWMS5EE7KIPXNIE7?=
 =?us-ascii?Q?XHFI6ytrQBzzCsSpbn+gl5Z4kfA9jXroEsVTJEh039oqyyCiDUxaMKKfuGyZ?=
 =?us-ascii?Q?oKWvAbuEMNebMxl8tWLbiEYvS8cu/0lXHeKGokWnV32ue2LOX1yshWWZXbJb?=
 =?us-ascii?Q?5l1fj/C/FQeCtVfCWZsbtMcL0zwUeia7Jkf+CCnN5l2KK+OfUrPU4dON03Ef?=
 =?us-ascii?Q?i/gaJE3on/YRTNNgWyE3MaKhEyVK+VwDfQBmRk9Dbl1V8hbfKVLFw6f3Ve4g?=
 =?us-ascii?Q?52tsBVZvZ6fjgvps7LFvBuxHJibbJ1xjQB9Yqa+Ca/yahpSHaM2mw4aSbQWP?=
 =?us-ascii?Q?1U+qL8SJhLqscacMr51PClcvzckkpV3+fQfur/jVKyXJq0O8xDymY8lDlRWm?=
 =?us-ascii?Q?pxEbeTkDT5B+5+gFcYY+zHU9IsXuqMckfOIukXJFwP4cm8GxtPwcyviqHYjg?=
 =?us-ascii?Q?IramvzOEHb8NioIXJY3mfD7cSWweryzPxhCAxWQ1p/nYaQun81TIayIMm0rq?=
 =?us-ascii?Q?HGZ5iVn/3SenUaQYmZ8FyHjG9zNKUPasBkR9IT5QPYi4RFinL1O5RFuX3ktG?=
 =?us-ascii?Q?YtaEhEaXuiLOUj46ivBkSH1jxDQ+pkD0k7PXx4m+DOmJV/ZAYd1fQFbbldyX?=
 =?us-ascii?Q?j9A8JUutN4kMmW9UGjTQw+hJyzy/8Q5mIbFYqb6N/mLXFmrmR7GohaqKAzR1?=
 =?us-ascii?Q?lWspoquLBY28Wy3mCntJklAXJMhiaonoDEWoxT3sWW/D3nQ7X1a/zwJzXDaL?=
 =?us-ascii?Q?VZJJqIt+1ZcsjCCGrK9R7npsbQDuPQoz6nojDeJHJI53Ac1SUoJXhSbvXFVP?=
 =?us-ascii?Q?UVnqsMcSqDBXZ6HuCm1x/ACpndB60Pz2iaiJgnGhD0mLqggeJkcBw4o08S6J?=
 =?us-ascii?Q?yTUY5Uhosb520FqKGG0HJn/q5xYgscgsZSEkmTV1t1mDQ/ykGoyTMx2XviEA?=
 =?us-ascii?Q?gpLRTWE7V+h/fA83sy6Qex2LfpRF8jPe8vWje7b9MRDlZMRm43ntO+p5Q3Id?=
 =?us-ascii?Q?V5zlttoe87yKc22ortVY6rXumaiENQQrCYuKfcLIIOaTmmB3ZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LdHz3wYAjoNjR1MTPM3d4Sa9Rab+L/ztuoajkkCjpHQ0Z/3OS1LxELiJUwdW?=
 =?us-ascii?Q?3voE53OMw6msJNfv71Rf5RBVrJFz+fSsCVECQEgJdGp+EHMqk/ZJm+mMBfWz?=
 =?us-ascii?Q?GqmTSKdWbfQD2JN0OG/bqFKrp3g02hhd65OhuBTF9HtwbYLjOYtvsSOZboaA?=
 =?us-ascii?Q?0P7P/XO3JIvzTpWDy/prcY3dnzcQuwUTCjqCbLO2ads0PoXAaoH8vEGzZW7N?=
 =?us-ascii?Q?M0+KGIi/mZl3bMnKXb6tbcL0G21jrwKoZjywRbJ8bIyysDFJF8drVYR3XQMA?=
 =?us-ascii?Q?vejnJoTDtNduJpyNexCd1C2Shi2ArbfglROFyFsrGiuDUYIEnESu8Khyuplm?=
 =?us-ascii?Q?Jorn8ZKQmvOc/GDCQJC7Xe9H7zuu+a3EdAhPI4Thn1le5gxo+3iKCRiF+vPY?=
 =?us-ascii?Q?xggxysazA+NEHHL4JdKaNAddjfVeojYzhfm6W9/1UcfvzwhJ+075tlbuCPbs?=
 =?us-ascii?Q?s4/OvnXr6vUcZB0HGn1u8Z0PDlesWtzA5wRYSZ3Ty++9L6/y60BJo/ALW1qI?=
 =?us-ascii?Q?gV3JW73yRdK7J4CjEb2bAHY0sX6AxEVBcle6yPr85sERkY+MkHBH/TIov4zx?=
 =?us-ascii?Q?ExMt4URj4+4DiQTCoqdMLA5Nuy4hgHETkJRQNLgesLXn0SYX73Hy1x3RpRrt?=
 =?us-ascii?Q?IgADpcaGqSm/LYMKuaPrez7IcR9Kr6ZqWaFvRwUV26cyaph6jB4jxEHzJdIq?=
 =?us-ascii?Q?C8apSabS/lFEb8pAuWmU0pA6dbYSuP5/Vj6Trcv5hBafdV93aFxcnHpEVmTk?=
 =?us-ascii?Q?1sV/FsunzEF8AzlUpFQDXn3tOXDMYr/XBvOze1PpV+VKJvkvfwruMsxzsA7f?=
 =?us-ascii?Q?beKIOAO+6yOLVxKQe0eRSnm3YqIhISk/iIT60AHpomwzZZnieJLfbdMfDxSp?=
 =?us-ascii?Q?LAlvt9hZb5wKLWYUbbAz8kZV47qIexHygNn2+3ppY5Z0C/O41lri5QEkYGNZ?=
 =?us-ascii?Q?F05+nNH2nC7AH4hIn4al0PnXqCeXtkY51IQ9eUKxPad9IqK6bWGYNEt5ZTvk?=
 =?us-ascii?Q?AGvA48GLMJQuiit34B1RR4LN0TEA8wNhghNp3sPhxz20bKWmQ/4s6LGLJa1j?=
 =?us-ascii?Q?suk4OD9GqwBldVmP72HnQ7904LbPBBln4vyo0HAzcFCwerLFhyH8KhuhEbtC?=
 =?us-ascii?Q?qOe+YQna04WiwATC8j7PX0QnkBPDY8TyKQCaeXiIg6BDZ1mc+XfibHxaBDGj?=
 =?us-ascii?Q?SFTjR4Wv3yPhZuJyrvT8DbKdt8httiL8WvC3CQXuV4n6rIRdenzpdampWrt5?=
 =?us-ascii?Q?/BpOgwjq9iZbNR3eSlbjgdZkCg1iijOI9Y6UfHiAtXxLPObURwzcxfQJ6Tf0?=
 =?us-ascii?Q?loJY2mK6wq7QGfzlZ0tKylvSQyyEsTIw88NfvQ8oeUQvW0CVIrwR/TnLBF5I?=
 =?us-ascii?Q?41xKgy36K9Avr1Ug43kaFKDgGfNJJkECNIIcQK6ZIdVSh9IINxYbE2G8TQKH?=
 =?us-ascii?Q?N+rhKwh5m7/BbvGi6nrgPlaVxIGzUFx0xoWX4VstGJpe1d6WpqeeEX7N+kVq?=
 =?us-ascii?Q?ZQb1+NECR3hMskL1HcnGHQ7P3va15mDdt9PrwoB5zc6Acl2VNbGilV9JWG0x?=
 =?us-ascii?Q?u+eos4dtC9gDxXG0OMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876006c8-6fe8-4097-17dd-08dcdc002356
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 18:47:13.0164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbCDw2HRStAW80J2KK2XOYjRMBef83oTFp9LgkRX03DRNcbyuJgUj2zyS5eLob64S8XLpoh/ewXCbrYqb+9tng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
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

This patch series reviewed by: Harish Kasiviswanathan <Harish.Kasiviswanath=
an@amd.com>

-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Monday, September 23, 2024 1:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Joshi, Mukul =
<Mukul.Joshi@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.=
com>
Subject: [PATCHv3 2/2] drm/amdkfd: Fix CU occupancy for GFX 9.4.3

Make CU occupancy calculations work on GFX 9.4.3 by
updating the logic to handle multiple XCCs correctly.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com> (v2)
---
v1->v2:
- Break into 2 patches, one for the generic change
  and the other for GFX v9.4.3.
- Incorporate Harish's comments.

v2->v3:
- Update code to handle both PM4 and AQL queues.

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 12 +++++------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 20 ++++++++++++++++---
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 26b1f37c316e..3bc0cbf45bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -963,14 +963,14 @@ static void get_wave_count(struct amdgpu_device *adev=
, int queue_idx,
         */
        pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
        queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
-       soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst,
+       soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, GET_INST(GC, in=
st));
+       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC, i=
nst),
                                  mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot=
);
        wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
        if (wave_cnt !=3D 0) {
                queue_cnt->wave_cnt +=3D wave_cnt;
                queue_cnt->doorbell_off =3D
-                       (RREG32_SOC15(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTRO=
L) &
+                       (RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_D=
OORBELL_CONTROL) &
                         CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) =
>>
                         CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT=
;
        }
@@ -1033,7 +1033,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device=
 *adev,
        DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);

        lock_spi_csq_mutexes(adev);
-       soc15_grbm_select(adev, 1, 0, 0, 0, inst);
+       soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));

        /*
         * Iterate through the shader engines and arrays of the device
@@ -1046,7 +1046,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device=
 *adev,
        se_cnt =3D adev->gfx.config.max_shader_engines;
        for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
                amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
-               queue_map =3D RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_ST=
ATUS);
+               queue_map =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CS=
Q_WF_ACTIVE_STATUS);

                /*
                 * Assumption: queue map encodes following schema: four
@@ -1071,7 +1071,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device=
 *adev,
        }

        amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, i=
nst);
-       soc15_grbm_select(adev, 0, 0, 0, 0, inst);
+       soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, inst));
        unlock_spi_csq_mutexes(adev);

        /* Update the output parameters and return */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 29578550b478..648f40091aa3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3542,15 +3542,19 @@ int debug_refresh_runlist(struct device_queue_manag=
er *dqm)

 bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
                                 struct qcm_process_device *qpd,
-                                int doorbell_off)
+                                int doorbell_off, u32 *queue_format)
 {
        struct queue *q;
        bool r =3D false;

+       if (!queue_format)
+               return r;
+
        dqm_lock(dqm);

        list_for_each_entry(q, &qpd->queues_list, list) {
                if (q->properties.doorbell_off =3D=3D doorbell_off) {
+                       *queue_format =3D q->properties.format;
                        r =3D true;
                        goto out;
                }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 80be2036abea..09ab36f8e8c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -326,7 +326,7 @@ int debug_map_and_unlock(struct device_queue_manager *d=
qm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
 bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
                                 struct qcm_process_device *qpd,
-                                int doorbell_off);
+                                int doorbell_off, u32 *queue_format);

 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *=
pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index d73841268c9b..d07acf1b2f93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -272,6 +272,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr,=
 char *buffer)
        struct kfd_process_device *pdd =3D NULL;
        int i;
        struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+       u32 queue_format;

        memset(cu_occupancy, 0x0, sizeof(cu_occupancy));

@@ -292,14 +293,27 @@ static int kfd_get_cu_occupancy(struct attribute *att=
r, char *buffer)
        wave_cnt =3D 0;
        max_waves_per_cu =3D 0;

+       /*
+        * For GFX 9.4.3, fetch the CU occupancy from the first XCC in the =
partition.
+        * For AQL queues, because of cooperative dispatch we multiply the =
wave count
+        * by number of XCCs in the partition to get the total wave counts =
across all
+        * XCCs in the partition.
+        * For PM4 queues, there is no cooperative dispatch so wave_cnt sta=
y as it is.
+        */
        dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
-                       &max_waves_per_cu, 0);
+                       &max_waves_per_cu, ffs(dev->xcc_mask) - 1);

        for (i =3D 0; i < AMDGPU_MAX_QUEUES; i++) {
                if (cu_occupancy[i].wave_cnt !=3D 0 &&
                    kfd_dqm_is_queue_in_process(dev->dqm, &pdd->qpd,
-                                               cu_occupancy[i].doorbell_of=
f))
-                       wave_cnt +=3D cu_occupancy[i].wave_cnt;
+                                               cu_occupancy[i].doorbell_of=
f,
+                                               &queue_format)) {
+                       if (unlikely(queue_format =3D=3D KFD_QUEUE_FORMAT_P=
M4))
+                               wave_cnt +=3D cu_occupancy[i].wave_cnt;
+                       else
+                               wave_cnt +=3D (NUM_XCC(dev->xcc_mask) *
+                                               cu_occupancy[i].wave_cnt);
+               }
        }

        /* Translate wave count to number of compute units */
--
2.35.1

