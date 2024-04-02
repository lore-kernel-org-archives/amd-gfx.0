Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9785BC6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 08:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8C410F869;
	Tue,  2 Apr 2024 08:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPHz90JL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2113.outbound.protection.outlook.com [40.107.243.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F188E10F869
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 08:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDYoQsRwx0fPvjXGjjIFfvlhiqg0xBDlak8NWce7ykdB6z7SlcSOj1AI5kQlSmH6XVBTV/H7mSXDjBkBXZp/eK/3MjYQql21i1jLZxFwn10usc/iKMHrU89n3tS/ak30BEw6ftCL1zFag/3AoCKluNMIwoppLAxoDHzWIvryk1hEXvRZbiHKUKVYZyOO60e0JEdtl0DBNc26SrTpPi18ZwYxcU3VycTPugrllbBQZ1bD5J0wCa0GVDw3ll7mORMjNcJz+Gsz6hJhhramaGZbGT28uQSMsOR6CGR9z2tmJvzGFx7sf+LhMA8wD8kx1LqNQTg7wpGzZnQIm3j9y8djMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgI4AxPJmESMJMMHArZR8PcaMiQ5nLZ1g/z+kCNakHA=;
 b=WQEvvJl4W4dzmlDGZImGhExKzIzgNg8dBFeLOlEBbv+/e0dVlhZgb0/m0jdo4HQQbwRw0fpT+a+r/J+Cn+1AVOUGN+RRkpEOH7xseykdjPbyRw7muQwMzB7wq1INlLNk/NeZi8+Sk7ZzBO5rxBEdV7XL4Uud1bTu70WtocGD18cWcpg5Ik1web22jYgqotliUxjV8KQV8jjuLuH3PmV2IovcVURBsLyn0TKNBZHrrLesKtJe32g8V3Ps4CYW17U3NOHSzU8pGudzhaSNuUD9M+VbYdAbENv1MRnpcc8a4UswSQoBC9Ca5jR3DvvMt1CUgMAkngPxxIEzq5O5ZvZtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgI4AxPJmESMJMMHArZR8PcaMiQ5nLZ1g/z+kCNakHA=;
 b=TPHz90JLjLuZ9E/klK6I2TQFkXDeNrjpsj4sR2R6YvJJKQrjcIRE74eV77ruVPNJ6avXBPWOHikpVoPpI4tUd4TFFLYxw3UOY2/RsHFK7jrOyTRTE4LlaGTGeCfIwnOzmTyc1sraGDyx6SiYTx8oVFENl/ObaP0dO7N+EgONMWQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 08:53:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 08:53:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: retire UMC v12 mca_addr_to_pa
Thread-Topic: [PATCH] drm/amdgpu: retire UMC v12 mca_addr_to_pa
Thread-Index: AQHahNrp5LE+ARiJ4kqZW6AflZkCArFUrIjA
Date: Tue, 2 Apr 2024 08:53:11 +0000
Message-ID: <BN9PR12MB52578BBD328A92BBBE960D6EFC3E2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240402085050.372402-1-tao.zhou1@amd.com>
In-Reply-To: <20240402085050.372402-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1145c1d5-e2c9-460a-a667-69ba14ef04bf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-02T08:52:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB8555:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AoBlsFeGfj7Z1Z1iP7T5Y7OzKwFhcr9Pthviux26y2cEBB9VtHnCVXEGq8yfnfLUtX4R/qnxfzRfUTG/05lkULA2Yc0/4yPiQ6gDDyNP3ypUkj3il9MM7O4DDIjUJcVHnb6m5+VwDb9UHdqOSOV/feX6AJwzKcjnrvhZzhfR6SNi2KxexwecFTIgWvWbBdk0umj82uFT8QHAlRNVTgkREuPQgL0LQgYbgs3Qua/4tFASfFuEq3U8qVQhwgqtFhLZoyVC66kiGGqU3IyoKLlY6cc6exyeIrut4IpZXZrOf6rUjEw/kwXjvc5oJWY3mtRkVK8wWLnxM5TSElBJbdcEAi34lVj08gigLagR8iuiEMW50XRRa3Kj7BlfUtAdetJb8/wrKFu4ThFPlGG+g2HbKrA6dy2OhgyOxHWGxMUHkvRMUMwRSRqbQRBbHeSK4biDEL6csatX1kMo3AOe+hgpvOu/0rVNuBIqXPISKb+Dtxdkeh1oKUonBmUQDBFMFSn2682QivCKy09u/q3Pvw7XmfrYVQiT63sX5HBBsCQ0b14nlnhlmaCZ78lHyPs97hbRdxhMdkxKh7ls2kkBgUFAUjXVuzg+DIcqzXnSZCUT56XdGqxyigiVvYfEv+xEG3C64tREqop9D5mlmT1N1dOYXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D2dk/XaeFU7QV4f2oEKavhTDBsBVFykTK/lI3ioHtV/PQNNfHfU6HfwY6fTE?=
 =?us-ascii?Q?9y2m8mHZvaDdabFDgvOX50oCIbiRx85VgKpDZFydwONc1ZZ1kzy52xjp3mEG?=
 =?us-ascii?Q?dajnLb4uVN5fQOmkK2Z3hTIfUBr5i79jnEBCKaSY+tqntt719+UBm5OEi9ys?=
 =?us-ascii?Q?cmQRKlG1Iwjj53oqr6yMnqFMuORZ1Eh5NtsjjWJGkElFljA/g9qdQt0Pxw3Z?=
 =?us-ascii?Q?ZPry7ywsHjarXAsyALsECX7jABAdrSfMxZLsmYmzk4Lbia6Oex14eHdf4om4?=
 =?us-ascii?Q?Husy84tdS6iw3auzgG0WLInM/9f6zZzPq1huwER7aR96DqrEQCRRgR8i+fQs?=
 =?us-ascii?Q?SuMG53I/Rx/1eiLQEslJArk/6o/tOioXI9Cuvf3XkyZgCsWD43jOPD2fFmrA?=
 =?us-ascii?Q?hiapPZ5Ig5kSuOTKRqcLeAZY4+YvVbSAI5mwJXnFN8R53EAaNBdP0LW90oaG?=
 =?us-ascii?Q?NcMvSWKKC6HjQ7BsfgwwExBpp+Wd9ZSm8jHy0ftseY4E1wlKr6+CiSzQxJRX?=
 =?us-ascii?Q?FGZUEetA/4Sr5yzP0ajyL303hsYnQrZbBhWZhsPTu4ur4JdMRBWM4QVq1f+d?=
 =?us-ascii?Q?COBCty9gWnQ8+xp1T9ddyyHZbNQ/EqCbn/Fjyy5ywWSaVpE9nTnqk0rDmDMU?=
 =?us-ascii?Q?y8VCg6Q+Lks4L855IExtHWJVuBSZrfWptk2Foe9pyoYxHDWzo9yd1xFbf+xy?=
 =?us-ascii?Q?5GJZ8XGJY1+tzvcK3w4mpUoWyEQdj2HGt/Sw4Hs6qCa6yDYdWJhVaR+PELji?=
 =?us-ascii?Q?RLewfPyMLHlxQGo90GoKSbxr0UqAaVgPstd0iDX2BLUKdpslQ/zx1kmRIZuO?=
 =?us-ascii?Q?V/3YxL507jUGKaMX6ZkI+YqNMdkZsh4qqtxTUvVBtFgyTdM1kXO4q9I4AMtp?=
 =?us-ascii?Q?oNl8sJAijOgFzLt+CarILT7DzGmro8L8bdIi+cfeGErbtMN4zRKuoGWYlk81?=
 =?us-ascii?Q?SlyOk54VPsf39Mesx9t1bXj888qJrxxiRN+0bMeipSrqOXPZUzzR4AOL+VYF?=
 =?us-ascii?Q?eBxqbBIeEceZU7g0O8Ylz0oG7hLicoRNqJKxqbX8095Osb+QO4RlQxR5Zfc2?=
 =?us-ascii?Q?sYPA1XF2Fc/DtMnhh28Dzaunmkl488PpX19+ftk2m8z2R1jUDg3OYuhwLwc4?=
 =?us-ascii?Q?3tT2lSdrcFd1RNN9vHKChzB9z1OMrUTMxPuqUH+gLooIcQCJCWuh7xQkooMy?=
 =?us-ascii?Q?eOPg7O9CF90sru8vV1L8DeDZDjJL3U4UdwAwqWNO7ZlMe/xvVDDRNyejYYX+?=
 =?us-ascii?Q?ULLxRVrjssj0mPac/cqM2xZ7QZx1PfLowwKB/BbJzNnxZDnWZB+QPL6BytfT?=
 =?us-ascii?Q?YlGe16lb34IHCoZo2iMpRtN3R+Dp6kNW+hgIRG9yGn5RHMh3KhD2ELUK125Z?=
 =?us-ascii?Q?fOKz5j/zEWY6bEi+SILGJnBaKjDeFTwPjhluGeL/c260l2XmtkxUBPYHiner?=
 =?us-ascii?Q?HdXeUYomAVfIL8TOaZGCDrjDhSqPywsIEJYzIbIscjM1rbhyWDUM0SgyArIu?=
 =?us-ascii?Q?dzW9mbj+WX+pJMyvoB/3g96/Sli5cUDKD3HARUsHOu4OL+s+F3hoOrXY0w?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4788ca6e-efb5-4c41-d268-08dc52f25336
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 08:53:11.1421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HcJgI1jAFal00A8zWVHx4BsKvr2tVPeAeo3z6qS5QGnTHoyGVcgcFXForZ1HzalPuW1PZQVqTr8BixfT+BuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Tuesday, April 2, 2024 16:51
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: retire UMC v12 mca_addr_to_pa

RAS TA will handle it, the interface is useless.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   1 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 105 ++-----------------------  dr=
ivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  62 +--------------
 3 files changed, 7 insertions(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 4ba26d7e52bd..afae497cbf40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1460,7 +1460,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)
                adev->umc.channel_offs =3D UMC_V12_0_PER_CHANNEL_OFFSET;
                adev->umc.active_mask =3D adev->aid_mask;
                adev->umc.retire_unit =3D UMC_V12_0_BAD_PAGE_NUM_PER_CHANNE=
L;
-               adev->umc.channel_idx_tbl =3D &umc_v12_0_channel_idx_tbl[0]=
[0][0];
                if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_a=
pu)
                        adev->umc.ras =3D &umc_v12_0_ras;
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index f46a176f9b55..a0122b22eda4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -28,28 +28,6 @@
 #include "umc/umc_12_0_0_sh_mask.h"
 #include "mp/mp_13_0_6_sh_mask.h"

-const uint32_t
-       umc_v12_0_channel_idx_tbl[]
-                       [UMC_V12_0_UMC_INSTANCE_NUM]
-                       [UMC_V12_0_CHANNEL_INSTANCE_NUM] =3D {
-               {{3,   7,   11,  15,  2,   6,   10,  14},  {1,   5,   9,   =
13,  0,   4,   8,   12},
-                {19,  23,  27,  31,  18,  22,  26,  30},  {17,  21,  25,  =
29,  16,  20,  24,  28}},
-               {{47,  43,  39,  35,  46,  42,  38,  34},  {45,  41,  37,  =
33,  44,  40,  36,  32},
-                {63,  59,  55,  51,  62,  58,  54,  50},  {61,  57,  53,  =
49,  60,  56,  52,  48}},
-               {{79,  75,  71,  67,  78,  74,  70,  66},  {77,  73,  69,  =
65,  76,  72,  68,  64},
-                {95,  91,  87,  83,  94,  90,  86,  82},  {93,  89,  85,  =
81,  92,  88,  84,  80}},
-               {{99,  103, 107, 111, 98,  102, 106, 110}, {97,  101, 105, =
109, 96,  100, 104, 108},
-                {115, 119, 123, 127, 114, 118, 122, 126}, {113, 117, 121, =
125, 112, 116, 120, 124}}
-       };
-
-/* mapping of MCA error address to normalized address */ -static const uin=
t32_t umc_v12_0_ma2na_mapping[] =3D {
-       0,  5,  6,  8,  9,  14, 12, 13,
-       10, 11, 15, 16, 17, 18, 19, 20,
-       21, 22, 23, 24, 25, 26, 27, 28,
-       24, 7,  29, 30,
-};
-
 static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *adev=
,
                                            uint32_t node_inst,
                                            uint32_t umc_inst,
@@ -192,79 +170,6 @@ static void umc_v12_0_query_ras_error_count(struct amd=
gpu_device *adev,
        umc_v12_0_reset_error_count(adev);
 }

-static bool umc_v12_0_bit_wise_xor(uint32_t val) -{
-       bool result =3D 0;
-       int i;
-
-       for (i =3D 0; i < 32; i++)
-               result =3D result ^ ((val >> i) & 0x1);
-
-       return result;
-}
-
-static void umc_v12_0_mca_addr_to_pa(struct amdgpu_device *adev,
-                                       uint64_t err_addr, uint32_t ch_inst=
, uint32_t umc_inst,
-                                       uint32_t node_inst,
-                                       struct ta_ras_query_address_output =
*addr_out)
-{
-       uint32_t channel_index, i;
-       uint64_t na, soc_pa;
-       uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row;
-       uint32_t bank0, bank1, bank2, bank3, bank;
-
-       bank_hash0 =3D (err_addr >> UMC_V12_0_MCA_B0_BIT) & 0x1ULL;
-       bank_hash1 =3D (err_addr >> UMC_V12_0_MCA_B1_BIT) & 0x1ULL;
-       bank_hash2 =3D (err_addr >> UMC_V12_0_MCA_B2_BIT) & 0x1ULL;
-       bank_hash3 =3D (err_addr >> UMC_V12_0_MCA_B3_BIT) & 0x1ULL;
-       col =3D (err_addr >> 1) & 0x1fULL;
-       row =3D (err_addr >> 10) & 0x3fffULL;
-
-       /* apply bank hash algorithm */
-       bank0 =3D
-               bank_hash0 ^ (UMC_V12_0_XOR_EN0 &
-               (umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR0) ^
-               (umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR0))));
-       bank1 =3D
-               bank_hash1 ^ (UMC_V12_0_XOR_EN1 &
-               (umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR1) ^
-               (umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR1))));
-       bank2 =3D
-               bank_hash2 ^ (UMC_V12_0_XOR_EN2 &
-               (umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR2) ^
-               (umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR2))));
-       bank3 =3D
-               bank_hash3 ^ (UMC_V12_0_XOR_EN3 &
-               (umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR3) ^
-               (umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR3))));
-
-       bank =3D bank0 | (bank1 << 1) | (bank2 << 2) | (bank3 << 3);
-       err_addr &=3D ~0x3c0ULL;
-       err_addr |=3D (bank << UMC_V12_0_MCA_B0_BIT);
-
-       na =3D 0x0;
-       /* convert mca error address to normalized address */
-       for (i =3D 1; i < ARRAY_SIZE(umc_v12_0_ma2na_mapping); i++)
-               na |=3D ((err_addr >> i) & 0x1ULL) << umc_v12_0_ma2na_mappi=
ng[i];
-
-       channel_index =3D
-               adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_nu=
m *
-                       adev->umc.channel_inst_num +
-                       umc_inst * adev->umc.channel_inst_num +
-                       ch_inst];
-       /* translate umc channel address to soc pa, 3 parts are included */
-       soc_pa =3D ADDR_OF_32KB_BLOCK(na) |
-               ADDR_OF_256B_BLOCK(channel_index) |
-               OFFSET_IN_256B_BLOCK(na);
-
-       /* the umc channel bits are not original values, they are hashed */
-       UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);
-
-       addr_out->pa.pa =3D soc_pa;
-       addr_out->pa.bank =3D bank;
-       addr_out->pa.channel_idx =3D channel_index;
-}
-
 static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
                                        struct ras_err_data *err_data,
                                        struct ta_ras_query_address_input *=
addr_in) @@ -275,10 +180,12 @@ static void umc_v12_0_convert_error_address(=
struct amdgpu_device *adev,

        err_addr =3D addr_in->ma.err_addr;
        addr_in->addr_type =3D TA_RAS_MCA_TO_PA;
-       if (psp_ras_query_address(&adev->psp, addr_in, &addr_out))
-               /* fallback to old path if fail to get pa from psp */
-               umc_v12_0_mca_addr_to_pa(adev, err_addr, addr_in->ma.ch_ins=
t,
-                               addr_in->ma.umc_inst, addr_in->ma.node_inst=
, &addr_out);
+       if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
+               dev_warn(adev->dev, "Failed to query RAS physical address f=
or 0x%llx",
+                       err_addr);
+
+               return;
+       }

        soc_pa =3D addr_out.pa.pa;
        bank =3D addr_out.pa.bank;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h
index 5973bfb14fce..1d5f44dcffdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -55,67 +55,12 @@
 #define UMC_V12_0_NA_MAP_PA_NUM        8
 /* R13 bit shift should be considered, double the number */  #define UMC_V=
12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
-/* bank bits in MCA error address */
-#define UMC_V12_0_MCA_B0_BIT 6
-#define UMC_V12_0_MCA_B1_BIT 7
-#define UMC_V12_0_MCA_B2_BIT 8
-#define UMC_V12_0_MCA_B3_BIT 9
+
 /* column bits in SOC physical address */  #define UMC_V12_0_PA_C2_BIT 15 =
 #define UMC_V12_0_PA_C4_BIT 21
 /* row bits in SOC physical address */
 #define UMC_V12_0_PA_R13_BIT 35
-/* channel index bits in SOC physical address */ -#define UMC_V12_0_PA_CH4=
_BIT 12 -#define UMC_V12_0_PA_CH5_BIT 13 -#define UMC_V12_0_PA_CH6_BIT 14
-
-/* bank hash settings */
-#define UMC_V12_0_XOR_EN0 1
-#define UMC_V12_0_XOR_EN1 1
-#define UMC_V12_0_XOR_EN2 1
-#define UMC_V12_0_XOR_EN3 1
-#define UMC_V12_0_COL_XOR0 0x0
-#define UMC_V12_0_COL_XOR1 0x0
-#define UMC_V12_0_COL_XOR2 0x800
-#define UMC_V12_0_COL_XOR3 0x1000
-#define UMC_V12_0_ROW_XOR0 0x11111
-#define UMC_V12_0_ROW_XOR1 0x22222
-#define UMC_V12_0_ROW_XOR2 0x4444
-#define UMC_V12_0_ROW_XOR3 0x8888
-
-/* channel hash settings */
-#define UMC_V12_0_HASH_4K 0
-#define UMC_V12_0_HASH_64K 1
-#define UMC_V12_0_HASH_2M 1
-#define UMC_V12_0_HASH_1G 1
-#define UMC_V12_0_HASH_1T 1
-
-/* XOR some bits of PA into CH4~CH6 bits (bits 12~14 of PA),
- * hash bit is only effective when related setting is enabled
- */
-#define UMC_V12_0_CHANNEL_HASH_CH4(channel_idx, pa) ((((channel_idx) >> 5)=
 & 0x1) ^ \
-                               (((pa)  >> 20) & 0x1ULL & UMC_V12_0_HASH_64=
K) ^ \
-                               (((pa)  >> 27) & 0x1ULL & UMC_V12_0_HASH_2M=
) ^ \
-                               (((pa)  >> 34) & 0x1ULL & UMC_V12_0_HASH_1G=
) ^ \
-                               (((pa)  >> 41) & 0x1ULL & UMC_V12_0_HASH_1T=
))
-#define UMC_V12_0_CHANNEL_HASH_CH5(channel_idx, pa) ((((channel_idx) >> 6)=
 & 0x1) ^ \
-                               (((pa)  >> 21) & 0x1ULL & UMC_V12_0_HASH_64=
K) ^ \
-                               (((pa)  >> 28) & 0x1ULL & UMC_V12_0_HASH_2M=
) ^ \
-                               (((pa)  >> 35) & 0x1ULL & UMC_V12_0_HASH_1G=
) ^ \
-                               (((pa)  >> 42) & 0x1ULL & UMC_V12_0_HASH_1T=
))
-#define UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) ((((channel_idx) >> 4)=
 & 0x1) ^ \
-                               (((pa)  >> 19) & 0x1ULL & UMC_V12_0_HASH_64=
K) ^ \
-                               (((pa)  >> 26) & 0x1ULL & UMC_V12_0_HASH_2M=
) ^ \
-                               (((pa)  >> 33) & 0x1ULL & UMC_V12_0_HASH_1G=
) ^ \
-                               (((pa)  >> 40) & 0x1ULL & UMC_V12_0_HASH_1T=
) ^ \
-                               (((pa)  >> 47) & 0x1ULL & UMC_V12_0_HASH_4K=
))
-#define UMC_V12_0_SET_CHANNEL_HASH(channel_idx, pa) do { \
-               (pa) &=3D ~(0x7ULL << UMC_V12_0_PA_CH4_BIT); \
-               (pa) |=3D (UMC_V12_0_CHANNEL_HASH_CH4(channel_idx, pa) << U=
MC_V12_0_PA_CH4_BIT); \
-               (pa) |=3D (UMC_V12_0_CHANNEL_HASH_CH5(channel_idx, pa) << U=
MC_V12_0_PA_CH5_BIT); \
-               (pa) |=3D (UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) << U=
MC_V12_0_PA_CH6_BIT); \
-       } while (0)

 #define MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) >> 20) & 0x1) * 4) +=
 \
                        (((_ipid_lo) >> 12) & 0xF))
@@ -127,11 +72,6 @@ bool umc_v12_0_is_correctable_error(struct amdgpu_devic=
e *adev, uint64_t mc_umc_

 typedef bool (*check_error_type_func)(struct amdgpu_device *adev, uint64_t=
 mc_umc_status);

-extern const uint32_t
-       umc_v12_0_channel_idx_tbl[]
-                       [UMC_V12_0_UMC_INSTANCE_NUM]
-                       [UMC_V12_0_CHANNEL_INSTANCE_NUM];
-
 extern struct amdgpu_umc_ras umc_v12_0_ras;

 #endif
--
2.34.1

