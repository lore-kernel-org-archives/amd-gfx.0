Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7F9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 19:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B474E10F8B2;
	Wed, 15 Dec 2021 19:16:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E58D10F8B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 19:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YElplddb5614DlBlUzyAVPaqvUgCw7xpKH5aWQyDVfFntcYobf7vOov+HhjRZvliGK1bBWMN+UgNgP98urF6+nZI1C9+6CYFtP4jA9UZ3MA2SdBK90iMK0VvmpJ/ewYVbRfd5IkeQCEHApkDrNh4zsz8fe+hyDXPgpsB4cler1y97PpNhwHuzya0wUJDPmoiTKxJLoU8xhwCn0lGWD1gfRGNwrq8iKMFN7ITODp0/cJ2P69pyZdFsiVFT5J9pACsHLKuoWyVVxVQa5ClfVLnIGGBPymY1yxWZQRZY68wSJ4Hkh4U5kGTzNoruuFufUlaZz53iKHS0tpFqYO1drrsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haqLFw1znHsUd2Q3S114uPfGEPInuTnW+Gsl5H60iE8=;
 b=XW+UezkLhouqVt8Ki65I3w+HtBzdFgBZqayoFpVi6FKWA6NmKjeRZYgg8rOoXGtqFKDmnLasBNpbKYTdVdTIFlh2fVMrtGlOj/0amZrX8F7BO5LBujsba0u7ZZfp/nVT9MqmA+oo45SLIM9dFoJ4oeBNJQRxR7OEc/rk6dzVXUbjzYk5wpx8czLPRLXryAJYB16bSxmgn5qSTDqn8xwF84dzdxPtjse5SxtCCugH9/Ii9Kwuef4OWeR3UmC8+T20jxcY3A10ec4KtVGM0BBGU+z2ILK8tAC3tM1/Z1+b5XhPdw5eUQW3wkEmqOhSEIAQEqPt88e40ccZWBBKy1N7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haqLFw1znHsUd2Q3S114uPfGEPInuTnW+Gsl5H60iE8=;
 b=frMQZKR89WYzMm294qSTIVtDqAUTMjUXTqrPxA8fTlOuQ5n9xHLjqSvPlBuZXapDx5JEcazmT2PlfjCgZuG0e+VkuwnT2xJvGG1Lg8vx8aObsFyTDLl7Bw+BiRZS0s85uJ2v1CBIs+LOLXwDN1DgaBlZhsykrQNeGHwDUKp37EM=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 19:16:05 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 19:16:05 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: Modify indirect register access for gfx9
 sriov
Thread-Topic: [PATCH 5/5] drm/amdgpu: Modify indirect register access for gfx9
 sriov
Thread-Index: AQHX8eVYqkrz5GuZGEuqCdtGaPXlTKwz7Ac/
Date: Wed, 15 Dec 2021 19:16:05 +0000
Message-ID: <BYAPR12MB2840F2BD83E7E075F7EF40D0F4769@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-6-victor.skvortsov@amd.com>
In-Reply-To: <20211215185510.15134-6-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-15T19:16:04.337Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 1c740e27-cafe-2c5f-c1f0-1db9bc19f4b2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e55d4757-3f71-4936-c9fc-08d9bfff5748
x-ms-traffictypediagnostic: BYAPR12MB4597:EE_
x-microsoft-antispam-prvs: <BYAPR12MB45977993F0F81303C5E83567F4769@BYAPR12MB4597.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqemLvU24Ar1jxRGb322h+zqkjD6qN/glfT7IomBu3GjR9ZeEpALEnnBk3Yta2VLDgw/RYxMAKnI3iJSrwVIR4vIbmRiIhhQQ1ItlpEdnKEVNAVdDrnh/jEDUV/tB8WyiuENspSE4YW/n6AIcwy5BMKsQOaI5QZzOgA2pf1jAlKkc2HIkGvYxAB07Oz1CceaJK5byr1xCmzFEt34iM4WmkWdhQC+1QPYIO+vHPup6vqK7Qpg8hsc7p5FNIRW5w3YvdAyCG/Hp5Jrm/tlKv1ucpuj3HJjBXBDtCoLMruXQ/FCWJJYNlZ415CjQrO/CqVFA9JnlRquTcnjFZ6/5l/5qqE3QgHPNCq1/YTavJXvEBiZq2NZnh+teVU9zzPGZhnZME3bwSar31VBD9f8LKldDCq9ZxXG3kWEuzP8qWfEI7qDwFEoH9SSF78pPz7kn/Jxmw7Vy2PIAal9vACATuOPhalTm/KpuBYS5vDwxpJgSxXq98gzUnnvcVFedJyAxEKm3yjug4FrIx4vuIhImDYN3kKVND4AeYZZn3DMUhZjIT4Qfpo7SslA36LV2gBTkYdQAXsSPfn6ABNq5Bhk/XfooV6K8W4lzQpqHptHpxI6cpFHspaoBIgeCUfRONmBjj46SGYpFAYcdNx90mcX5if0DnDf24WVkYYDfa5B+NlMMf7FNJFboJTyq++nCLBzH1tsPUeO3+xBUiqWUcqSdnPdvEIDrdh100x9jLvRIBdik60=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(71200400001)(2906002)(66946007)(66476007)(76116006)(5660300002)(8936002)(66556008)(66446008)(64756008)(55016003)(921005)(110136005)(508600001)(38100700002)(316002)(7696005)(83380400001)(33656002)(19627405001)(53546011)(6636002)(86362001)(6506007)(8676002)(38070700005)(9686003)(186003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xOJ/phWF65JobPyS2QYYazdBYHZjumojI67UQ+EeKumjo7mI7PV+Jha+AOmo?=
 =?us-ascii?Q?HNP5zz0MCUgmO7GEYa29kFBO61ZoiDS+v3rHvXke0sHtCTDX6fUAf/JxAzxQ?=
 =?us-ascii?Q?x9ZmzM/aQr5Qp2EggWMj0nUthx+9agaZAOumBMEjpyXdraV9D9GkUWk+vJis?=
 =?us-ascii?Q?6+5CKVBq7CCe24fgETquKVwTFTYEgtRZ6Efm9x+fzqUy566ieCqXacn+qnec?=
 =?us-ascii?Q?kYi1inUsJKA6hNExJCf2XAsZNCp7HF3uDU76BV05IKjJeeTSJ6Oga32K2ESs?=
 =?us-ascii?Q?ujEE3/w4w9QNW9N3q6m506DNUQaJ/SxG8qzzGN+nkLwptsd4sWu21JaorWv2?=
 =?us-ascii?Q?wCWglhIoHxv/++EpX1wSYPqmj19GDtP0ImSgXRDEzq2e/2JUK56z70AaBIYg?=
 =?us-ascii?Q?V3FM6ZtUEBHDB0qfTt6qd1xFhE6RbMdnhhE+G9jhMc4m2/+qiIu4ABdwWyJn?=
 =?us-ascii?Q?iNkb2kb5dLupAVOcYMGeUk8aFyDh6PxGQg6scOTN66ORw39BxFImkRI3EKYD?=
 =?us-ascii?Q?/aAEFNMNVipq6PP43J2LuvlYQBxy/GkPQTyMiMxafkLPgaKZJWt5LeBT5WZi?=
 =?us-ascii?Q?7tmpyEfubm+TDT0chi/e7N+wu6e09TFg+czeecsNbi39K/7Ccp29851Y4IiA?=
 =?us-ascii?Q?+x1WmqmL12PG7gqQ/4bGvoqiRCylrVqeK+MjMZjySSrII/P3RpFZ4GgjM6dP?=
 =?us-ascii?Q?oJl5aZWQ0MkbCwmRnZ9Fxfs5Qm25gDehnpzmsRnA+JK6mq5qYCnBWAI0nE0z?=
 =?us-ascii?Q?RssyBQA8wt4MJ3QERcN44I/f8APcGNm1Olz9D8vCNn0GPIGy3f+TRaElOXJF?=
 =?us-ascii?Q?NQrx2fHTC3BIQmOkvwzdjsxk5JGAqegv7XRkyxNhDULS/F3R1XPPNppxvFj4?=
 =?us-ascii?Q?tk4PTMbIbBBgMx7kV0cPgMZTxK6MDJQydvfZf5A/1Nr7BxgUSq98geFdC95i?=
 =?us-ascii?Q?Xl2HFWbhNSIl2446VN5Lh2ypRbVF2b0cZufUUZDp55ciGdfszpD5TpVI9nvC?=
 =?us-ascii?Q?zUJsJq8fG4G4LTQd+3Fb1B1wN9gwl1gHVOk18ai4BV1W7dHB9AYfYb8gl8ID?=
 =?us-ascii?Q?PLtXAOpniEY5vOb5w9DeSG5NyC2X3dB4jr5zM8SVMBGuDAhWggFXcBfgWCZs?=
 =?us-ascii?Q?NTghQpu48TvvQFW86k9Ocg83FrmCATiDCD6nIvK2ejrn/jJnVC0MI84BLlv/?=
 =?us-ascii?Q?WSge8TdNRgdSZBVFvx520YVQCnQ8kmpKi1fu1zYaT5CYzeMd6sRKgwRhIy8D?=
 =?us-ascii?Q?kDhq911edwcAIV9P4NbWPVmXa2XPWalWYD1GpKUY7ig6woOrcN4558NXxoTS?=
 =?us-ascii?Q?MirgtUjXfK5Uq+zU8a8Oec95VlItgvgbNGOBEquXTcqieUGEe+kS84/Xi8Qe?=
 =?us-ascii?Q?gkZKwc9RmODch/bx9qvlVVD/dZsSBVOw512f7jajVdpCYIJdBlI4QOp9bZex?=
 =?us-ascii?Q?23qxT8csbQYpa6brKlxnczuDxquZN6POzFJz1hee42Xu0eo6wzgNv8ivYzXk?=
 =?us-ascii?Q?Kq7uqDUCC6jAIj4k0S1M8x2xzQ48sfDtx/mSssssFSr6cP8TWnt0a++ZHTYA?=
 =?us-ascii?Q?nmuASbGliS97VbDf8JsCsJK/VX0LmfBM2LAncQFT?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB2840F2BD83E7E075F7EF40D0F4769BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d4757-3f71-4936-c9fc-08d9bfff5748
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 19:16:05.0360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peTrT0q6qINDDw0xujLjrLPUreHoBFMahGLcbIBwVrkdditNNccxfj+vDqN6PXpf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4597
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

--_000_BYAPR12MB2840F2BD83E7E075F7EF40D0F4769BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

         scratch_reg0 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCR=
ATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
         scratch_reg1 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCR=
ATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
-       scratch_reg2 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
-       scratch_reg3 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+       scratch_reg2 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;
+       scratch_reg3 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;
         spare_int =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SP=
ARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;

the definition of scratch_reg2 and 3 has here.... will this be backwards co=
mpatible? Was it a bug in the definition?
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, December 15, 2021 10:55 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Modify indirect register access for gfx9 s=
riov

Expand RLCG interface for new GC read & write commands.
New interface will only be used if the PF enables the flag in pf2vf msg.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 111 +++++++++++++++++++-------
 1 file changed, 83 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index d252b06efa43..bce6ab52cae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -63,6 +63,13 @@
 #define mmGCEA_PROBE_MAP                        0x070c
 #define mmGCEA_PROBE_MAP_BASE_IDX               0

+#define GFX9_RLCG_GC_WRITE_OLD                 (0x8 << 28)
+#define GFX9_RLCG_GC_WRITE                     (0x0 << 28)
+#define GFX9_RLCG_GC_READ                      (0x1 << 28)
+#define GFX9_RLCG_VFGATE_DISABLED              0x4000000
+#define GFX9_RLCG_WRONG_OPERATION_TYPE         0x2000000
+#define GFX9_RLCG_NOT_IN_RANGE                 0x1000000
+
 MODULE_FIRMWARE("amdgpu/vega10_ce.bin");
 MODULE_FIRMWARE("amdgpu/vega10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/vega10_me.bin");
@@ -739,7 +746,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
=3D
         mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };

-static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v,=
 u32 flag)
+static u32 gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,=
 uint32_t flag)
 {
         static void *scratch_reg0;
         static void *scratch_reg1;
@@ -748,21 +755,20 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f
         static void *spare_int;
         static uint32_t grbm_cntl;
         static uint32_t grbm_idx;
+       uint32_t i =3D 0;
+       uint32_t retries =3D 50000;
+       u32 ret =3D 0;
+       u32 tmp;

         scratch_reg0 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCR=
ATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
         scratch_reg1 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCR=
ATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
-       scratch_reg2 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
-       scratch_reg3 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+       scratch_reg2 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;
+       scratch_reg3 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;
         spare_int =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SP=
ARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;

         grbm_cntl =3D adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_ID=
X] + mmGRBM_GFX_CNTL;
         grbm_idx =3D adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_ID=
X] + mmGRBM_GFX_INDEX;

-       if (amdgpu_sriov_runtime(adev)) {
-               pr_err("shouldn't call rlcg write register during runtime\n=
");
-               return;
-       }
-
         if (offset =3D=3D grbm_cntl || offset =3D=3D grbm_idx) {
                 if (offset  =3D=3D grbm_cntl)
                         writel(v, scratch_reg2);
@@ -771,41 +777,89 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f

                 writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
         } else {
-               uint32_t i =3D 0;
-               uint32_t retries =3D 50000;
-
                 writel(v, scratch_reg0);
-               writel(offset | 0x80000000, scratch_reg1);
+               writel(offset | flag, scratch_reg1);
                 writel(1, spare_int);
-               for (i =3D 0; i < retries; i++) {
-                       u32 tmp;

+               for (i =3D 0; i < retries; i++) {
                         tmp =3D readl(scratch_reg1);
-                       if (!(tmp & 0x80000000))
+                       if (!(tmp & flag))
                                 break;

                         udelay(10);
                 }
-               if (i >=3D retries)
-                       pr_err("timeout: rlcg program reg:0x%05x failed !\n=
", offset);
+
+               if (i >=3D retries) {
+                       if (amdgpu_sriov_reg_indirect_gc(adev)) {
+                               if (tmp & GFX9_RLCG_VFGATE_DISABLED)
+                                       pr_err("The vfgate is disabled, pro=
gram reg:0x%05x failed!\n", offset);
+                               else if (tmp & GFX9_RLCG_WRONG_OPERATION_TY=
PE)
+                                       pr_err("Wrong operation type, progr=
am reg:0x%05x failed!\n", offset);
+                               else if (tmp & GFX9_RLCG_NOT_IN_RANGE)
+                                       pr_err("The register is not in rang=
e, program reg:0x%05x failed!\n", offset);
+                               else
+                                       pr_err("Unknown error type, program=
 reg:0x%05x failed!\n", offset);
+                       } else
+                               pr_err("timeout: rlcg program reg:0x%05x fa=
iled!\n", offset);
+               }
+       }
+
+       ret =3D readl(scratch_reg0);
+
+       return ret;
+}
+
+static bool gfx_v9_0_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_fla=
gs, u32 hwip,
+                               int write, u32 *rlcg_flag)
+{
+
+       switch (hwip) {
+       case GC_HWIP:
+               if (amdgpu_sriov_reg_indirect_gc(adev)) {
+                       *rlcg_flag =3D write ? GFX9_RLCG_GC_WRITE : GFX9_RL=
CG_GC_READ;
+
+                       return true;
+               /* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_=
RLC enabled simultaneously */
+               } else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags & A=
MDGPU_REGS_NO_KIQ) && write) {
+                       *rlcg_flag =3D GFX9_RLCG_GC_WRITE_OLD;
+                       return true;
+               }
+
+               break;
+       default:
+               return false;
         }

+       return false;
+}
+
+static u32 gfx_v9_0_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32=
 acc_flags, u32 hwip)
+{
+       u32 rlcg_flag;
+
+       if (!amdgpu_sriov_runtime(adev) && gfx_v9_0_get_rlcg_flag(adev, acc=
_flags, hwip, 0, &rlcg_flag))
+               return gfx_v9_0_rlcg_rw(adev, offset, 0, rlcg_flag);
+
+       if (acc_flags & AMDGPU_REGS_NO_KIQ)
+               return RREG32_NO_KIQ(offset);
+       else
+               return RREG32(offset);
 }

 static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
-                              u32 v, u32 acc_flags, u32 hwip)
+                              u32 value, u32 acc_flags, u32 hwip)
 {
-       if ((acc_flags & AMDGPU_REGS_RLC) &&
-           amdgpu_sriov_fullaccess(adev)) {
-               gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
+       u32 rlcg_flag;

+       if (!amdgpu_sriov_runtime(adev) && gfx_v9_0_get_rlcg_flag(adev, acc=
_flags, hwip, 1, &rlcg_flag)) {
+               gfx_v9_0_rlcg_rw(adev, offset, value, rlcg_flag);
                 return;
         }

         if (acc_flags & AMDGPU_REGS_NO_KIQ)
-               WREG32_NO_KIQ(offset, v);
+               WREG32_NO_KIQ(offset, value);
         else
-               WREG32(offset, v);
+               WREG32(offset, value);
 }

 #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042
@@ -5134,7 +5188,7 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)
         if (amdgpu_sriov_is_pp_one_vf(adev))
                 data =3D RREG32_NO_KIQ(reg);
         else
-               data =3D RREG32(reg);
+               data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);

         data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
         data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_M=
C_CNTL__RLC_SPM_VMID__SHIFT;
@@ -5190,6 +5244,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_fun=
cs =3D {
         .start =3D gfx_v9_0_rlc_start,
         .update_spm_vmid =3D gfx_v9_0_update_spm_vmid,
         .sriov_wreg =3D gfx_v9_0_sriov_wreg,
+       .sriov_rreg =3D gfx_v9_0_sriov_rreg,
         .is_rlcg_access_range =3D gfx_v9_0_is_rlcg_access_range,
 };

@@ -5795,16 +5850,16 @@ static void gfx_v9_0_set_compute_eop_interrupt_stat=
e(struct amdgpu_device *adev,

         switch (state) {
         case AMDGPU_IRQ_STATE_DISABLE:
-               mec_int_cntl =3D RREG32(mec_int_cntl_reg);
+               mec_int_cntl =3D RREG32_SOC15_IP(GC,mec_int_cntl_reg);
                 mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_=
INT_CNTL,
                                              TIME_STAMP_INT_ENABLE, 0);
-               WREG32(mec_int_cntl_reg, mec_int_cntl);
+               WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
                 break;
         case AMDGPU_IRQ_STATE_ENABLE:
-               mec_int_cntl =3D RREG32(mec_int_cntl_reg);
+               mec_int_cntl =3D RREG32_SOC15_IP(GC, mec_int_cntl_reg);
                 mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_=
INT_CNTL,
                                              TIME_STAMP_INT_ENABLE, 1);
-               WREG32(mec_int_cntl_reg, mec_int_cntl);
+               WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
                 break;
         default:
                 break;
--
2.25.1


--_000_BYAPR12MB2840F2BD83E7E075F7EF40D0F4769BYAPR12MB2840namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 scratch_reg0 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRAT=
CH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;</span><br>
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 scratch_reg1 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRAT=
CH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;</span><br style=3D"color: rgb(0, 0, =
0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &=
quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; background-col=
or: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 scratch_reg2 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRAT=
CH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;</span><br style=3D"color: rgb(0, 0, =
0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &=
quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; background-col=
or: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 scratch_reg3 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRAT=
CH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;</span><br style=3D"color: rgb(0, 0, =
0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &=
quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; background-col=
or: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 scratch_reg2 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRAT=
CH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;</span><br style=3D"color: rgb(0, 0, =
0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &=
quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; background-col=
or: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 scratch_reg3 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRAT=
CH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;</span><br style=3D"color: rgb(0, 0, =
0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &=
quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; background-col=
or: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 spare_int =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_SPAR=
E_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">the
 definition of scratch_reg2 and 3 has here.... will this be backwards compa=
tible? Was it a bug in the definition?</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 15, 2021 10:55 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH 5/5] drm/amdgpu: Modify indirect register access for=
 gfx9 sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Expand RLCG interface for new GC read &amp; write =
commands.<br>
New interface will only be used if the PF enables the flag in pf2vf msg.<br=
>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 111 +++++++++++++++++++------=
-<br>
&nbsp;1 file changed, 83 insertions(+), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index d252b06efa43..bce6ab52cae0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -63,6 +63,13 @@<br>
&nbsp;#define mmGCEA_PROBE_MAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x070c<br>
&nbsp;#define mmGCEA_PROBE_MAP_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
+#define GFX9_RLCG_GC_WRITE_OLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x8 &lt;&lt; 28)<br>
+#define GFX9_RLCG_GC_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
x0 &lt;&lt; 28)<br>
+#define GFX9_RLCG_GC_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (0x1 &lt;&lt; 28)<br>
+#define GFX9_RLCG_VFGATE_DISABLED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4000000<br>
+#define GFX9_RLCG_WRONG_OPERATION_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x2000000<br>
+#define GFX9_RLCG_NOT_IN_RANGE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1000000<br>
+<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega10_ce.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega10_pfp.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega10_me.bin&quot;);<br>
@@ -739,7 +746,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_SRM_INDEX_CNTL_DATA_=
7 - mmRLC_SRM_INDEX_CNTL_DATA_0,<br>
&nbsp;};<br>
&nbsp;<br>
-static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v,=
 u32 flag)<br>
+static u32 gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,=
 uint32_t flag)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void *scratch_reg0;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void *scratch_reg1;=
<br>
@@ -748,21 +755,20 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void *spare_int;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static uint32_t grbm_cntl;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static uint32_t grbm_idx;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retries =3D 50000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg0 =3D adev-&gt;=
rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRAT=
CH_REG0)*4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg1 =3D adev-&gt;=
rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRAT=
CH_REG1)*4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg2 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg3 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg2 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg3 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spare_int =3D adev-&gt;rmm=
io + (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPA=
RE_INT)*4;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_cntl =3D adev-&gt;reg=
_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_idx =3D adev-&gt;reg_=
offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_runtime(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;shouldn't call rlcg write register during runtime\n=
&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offset =3D=3D grbm_cnt=
l || offset =3D=3D grbm_idx) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (offset&nbsp; =3D=3D grbm_cntl)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write=
l(v, scratch_reg2);<br>
@@ -771,41 +777,89 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(v, ((void __iomem *)adev-&gt;rmmio) + (offset =
* 4));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t i =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t retries =3D 50000;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(v, scratch_reg0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; writel(offset | 0x80000000, scratch_reg1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; writel(offset | flag, scratch_reg1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(1, spare_int);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; retries; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; retries; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D readl(scratch_reg1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(tmp &amp; =
0x80000000))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(tmp &amp; =
flag))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udela=
y(10);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &gt;=3D retries)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;tim=
eout: rlcg program reg:0x%05x failed !\n&quot;, offset);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &gt;=3D retries) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov=
_reg_indirect_gc(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp &amp; GFX9_RLCG_VFGATE_DISABLED)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_err(&quot;The vfgate is disabled, program reg:0x%05x failed!\n&quot=
;, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (tmp &amp; GFX9_RLCG_WRONG_OPERATIO=
N_TYPE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_err(&quot;Wrong operation type, program reg:0x%05x failed!\n&quot;,=
 offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (tmp &amp; GFX9_RLCG_NOT_IN_RANGE)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_err(&quot;The register is not in range, program reg:0x%05x failed!\=
n&quot;, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_err(&quot;Unknown error type, program reg:0x%05x failed!\n&quot;, o=
ffset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;timeout: rlcg program reg:0x%0=
5x failed!\n&quot;, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D readl(scratch_reg0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static bool gfx_v9_0_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_fla=
gs, u32 hwip,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int write, u32 *rlcg_flag)<br>
+{<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (hwip) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case GC_HWIP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_reg_indirect_gc(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rlcg_flag =3D w=
rite ? GFX9_RLCG_GC_WRITE : GFX9_RLCG_GC_READ;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_RLC e=
nabled simultaneously */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if ((acc_flags &amp; AMDGPU_REGS_RLC) &amp;&amp; !(acc_fl=
ags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp; write) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rlcg_flag =3D G=
FX9_RLCG_GC_WRITE_OLD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+}<br>
+<br>
+static u32 gfx_v9_0_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32=
 acc_flags, u32 hwip)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rlcg_flag;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_runtime(adev) &amp;=
&amp; gfx_v9_0_get_rlcg_flag(adev, acc_flags, hwip, 0, &amp;rlcg_flag))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return gfx_v9_0_rlcg_rw(adev, offset, 0, rlcg_flag);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acc_flags &amp; AMDGPU_REGS_NO_KI=
Q)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return RREG32_NO_KIQ(offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return RREG32(offset);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offse=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u32 v, u32 acc_flags, u32 hwip)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u32 value, u32 acc_flags, u32 hwip)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((acc_flags &amp; AMDGPU_REGS_RLC)=
 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_=
fullaccess(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rlcg_flag;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_runtime(adev) &amp;=
&amp; gfx_v9_0_get_rlcg_flag(adev, acc_flags, hwip, 1, &amp;rlcg_flag)) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_rlcg_rw(adev, offset, value, rlcg_flag);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acc_flags &amp; AMDGPU=
_REGS_NO_KIQ)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_NO_KIQ(offset, v);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_NO_KIQ(offset, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(offset, v);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(offset, value);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;#define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042<br>
@@ -5134,7 +5188,7 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_is_pp_one=
_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32_NO_KIQ(reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32(reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RLC_SPM_MC_=
CNTL__RLC_SPM_VMID_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (vmid &amp; RLC_=
SPM_MC_CNTL__RLC_SPM_VMID_MASK) &lt;&lt; RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHI=
FT;<br>
@@ -5190,6 +5244,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_rlc_st=
art,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D gfx_v=
9_0_update_spm_vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sriov_wreg =3D gfx_v9_0_s=
riov_wreg,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sriov_rreg =3D gfx_v9_0_sriov_rreg,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlcg_access_range =3D =
gfx_v9_0_is_rlcg_access_range,<br>
&nbsp;};<br>
&nbsp;<br>
@@ -5795,16 +5850,16 @@ static void gfx_v9_0_set_compute_eop_interrupt_stat=
e(struct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISA=
BLE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mec_int_cntl =3D RREG32(mec_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mec_int_cntl =3D RREG32_SOC15_IP(GC,mec_int_cntl_reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_P=
IPE0_INT_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 0);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(mec_int_cntl_reg, mec_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENAB=
LE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mec_int_cntl =3D RREG32(mec_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mec_int_cntl =3D RREG32_SOC15_IP(GC, mec_int_cntl_reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_P=
IPE0_INT_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 1);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(mec_int_cntl_reg, mec_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2840F2BD83E7E075F7EF40D0F4769BYAPR12MB2840namp_--
