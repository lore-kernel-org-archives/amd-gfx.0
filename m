Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27E7FED2E1
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 07:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6122210E969;
	Thu, 12 Mar 2026 07:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nb3xJtew";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886F910E969
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 07:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3wQ3I4WcTvFzmw4q4vOdBw0pBEznC5TeifQIQm9AmHuUIY5aiJR7JLA5MxkQ8GvpX/PSYF5PElOLh75FHk9fgeCzO+OpXiD85KhKzwuIP6XkCNY4Z/ZUPX0mNeysp975j9Ef96EyZAnee7Q4fuqyT1jWGK0+dRIAVfQXFRvfAyVEKlPoRccXFA+YBPWaukJRH3luweqw3RiPGXLHoyQjMnePJADtWls96mleuZ0sBlEQ2COAuHmrY4sbI/TuHhogQaju8DSRmeSeQCANKFyhU0qJEArKtIwBoChN3aA2yGZzJAoTr5hHpvkLHozdBfAOvv/11e/Vh3W3mMDmqBoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjIqzsQ4PwhkXw5TkizHFT3N/S1ljNglDAnNRsWgDxY=;
 b=pepplE5qpCiot8c3g87a9+Xp3oSb/rBlPUMtIPvPCFnS5CjGVPkuufV3CXcTsLxweG1cI4OSNv0KUcKr/6gf0Kez+K/Anfiy4mSgeOolr5ZQ+bQAg31MQ+vRX9gcGZEPjV23y0qu8aZMIsxbM7kf3rkumcjQPqMNYDzbLVeqpqgry/CMEOceexesw7nj3NUYx/djhPJqyCcnjwIsqjVOFR3V6CjR7ZVJ2PqH8ZUT5G829wJ1xFKXhWqAccLoTHyGss7EIptO1l2hHXmWO/nu4578lQhlM/1/K4VIWmgvnL53Zl5GVWTXedhJyvOlKzQwNbIYJ/sLZfCdhwdbggyWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjIqzsQ4PwhkXw5TkizHFT3N/S1ljNglDAnNRsWgDxY=;
 b=nb3xJtewxbORT/ncK0sxXmuagHa2n1BDQ6eY/xiDkUz/NY3MKLpsMMRCdbYH9NCHw9GHgOTn/Eo6yWzfWLyo0FS0QmOQOJ0O4BlDBhahZyAHLY6dK57jYXHqBCTbSQNSIy8TiumOx/A0x1VbtgxQYzniul4OVn+1hnvJlReLePI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 07:47:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 07:47:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
Thread-Topic: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
Thread-Index: AQHcsUXr3tJ8GT7TFEyZYM8iF+Nh1bWqhgFA
Date: Thu, 12 Mar 2026 07:47:38 +0000
Message-ID: <BN9PR12MB525799B7DEC744EA91B1049BFC44A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260311105724.477408-1-tao.zhou1@amd.com>
In-Reply-To: <20260311105724.477408-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-12T07:46:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB6831:EE_
x-ms-office365-filtering-correlation-id: 36e0e3c3-464a-476d-ef75-08de800ba1e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: DdNuqb2oSUjopLUhRKVD4u0XAxoi4DBYd0IopFq5JqotWHdrVfA925Ok3NtsJnkmUTaQ4ynceLM1mU9w599G82O+4dBGiTxy1/GXJgsHx1BjMWf69r2XT0bGDlBd7sC8dliRvPDV+274Myyx6ERZdfS+K48YlFMThaKLwyEUVNsAnf65pCv4XVAdleEiyFE701LEnu+B1+ds3AytgmvVPhNf3TtgCtt4I182FaaNQbX+k/jC+BMPGJOEeb6ZDN5EptuqdvS6UqZUZiIJHo/AB6CFWNtafI5b1oapPOKZK0m1Cl+8at0zBkE+k27w4LHB/S097G1qQCxJaRjty31b/Iun2dH2Z683mMX6eTZeHepU1VSEUt6EiuWb7nvVqskmVxsi7Bygo63FCyI+Yn9YbeDx2GAmyDgbF36V1Mv0U9x+BGquVL7clRFZAorlKsz87QJCmv0beFhDInN0M24C62UtWeqiM1kiIYJVwTB58p+6X2VbrlCBJ92W2U4ZYiEnVXlUdLGGGklZXiW/hCJjwVpJVjwmICcyHibR5jipWpdIC4DplHAYJ7bBkkE260sVOtn/f+QZoEMO72xD2X244u4jP/ZHVciOl4GCee6Ud2nhFgsJliOqyPnhdcGMZyVJqhYZae4IBsFwIjFeqsPVA9ordVxuLINrtxGN89y2oRoEHMyBe5Xuf3BuyK2Cv7Z4rp8cd8DWLpm7dAIgBO+ZQmjCqf8kSWMOya7bxtuCJKkkj5pPKWcpf1qlX4mCtzHmxJPz4ReH8VdsnNiecPGnv2fAtI/RPp3WGn5K+iTgv+0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VAe8lsz7wUIipPvWb399mofy+Ex8f+KL4ZH3zdjpHPUVFKumwJMKd/pGQlQM?=
 =?us-ascii?Q?RGmxlHeB7ug9TOchNv3k9Jvgz1DQxERDu6B6nAcPtCbWJQMjW1Ef4HCRpqPr?=
 =?us-ascii?Q?r+FYfO52IIXVlm7ufUyXYCNeDTnZNWKL8IrS2pFO4Hki8DtxMMGMV1l36v/1?=
 =?us-ascii?Q?0I0pHsUxidfC4n8ObBONhmpVdSMbde4U/uVerj4tDAhE6bkDEPv+WpMErCgq?=
 =?us-ascii?Q?HvWdFJ3n03q31NG3sxrFbhxE9dRBQX7Ay+dqGi6GxZqIVjaeQMgaAY2sQnq4?=
 =?us-ascii?Q?rS2QZYaAD9dCeEsy1xQhMvBLlmRbYx2nn8TMd2M611NDZ56+GjHHJUdDxxAa?=
 =?us-ascii?Q?HTOQzew8CEc0P8OcAwbhK1tTam0E6HjfMeNlISr52rNZsegQ9WUsy6lrpc+j?=
 =?us-ascii?Q?spo+m42PUtq2rO+enOvMRn9LcVBr+zTz6yN1wl0Vbw1zwqf5u/5nXiQd9QUn?=
 =?us-ascii?Q?Ejvc6jeHHwpc6bKnHHE8FjnD+/yitVUFZvxp2PQe7f4sTcqIcOUWHsiha5Ft?=
 =?us-ascii?Q?oRRFAOuHCuv3vOfgxeASookjFQr/ABZGonmHOVGQ2yxt3S5nz8beHPbA9Xb+?=
 =?us-ascii?Q?1N+YoLZPCVgf2VhlK989q0hyrQpEBLMpBL9fUGjQMhiWznNb//tR+bVZDSTX?=
 =?us-ascii?Q?Bx/rybGGhDm8koDk/ykKwjCo06NOAIx5vhWtIz7HfEoSb9v4Oii5OtSjZmcC?=
 =?us-ascii?Q?xAAvtp8EIKmwGjOPi0CrW7YEORm/3YZVj/HJmYWELOruzGtM7+tyR5RCSv/5?=
 =?us-ascii?Q?cpmhdsKW4Lktb1MFklU5ISzue6dkRHOsJQ4+qJwvRUaWFvJUOZpvXOmCWDgx?=
 =?us-ascii?Q?WzO/+TCXxxfhs4fmrhArY6q45FpmRVmG3imKfdD7ipeMKg9sgiBndbKWTHlM?=
 =?us-ascii?Q?2hbBLtY63fRRzZeSyjOAQILvsIWUlUj7Lp8Gsv0LXbSeFAogddV1+ikBuh/c?=
 =?us-ascii?Q?swh7VBLefO3vELFHPmqiX/5dOJj19tXjQR1r9CLhIZBiyVroOruqLreWS74+?=
 =?us-ascii?Q?ixVEuUhDrMeE8uU3LfJ9tIb2gQZzFvXjd7YQOLr3fMISDlIIJEEcrAOjIavX?=
 =?us-ascii?Q?TQlbNbXHf1HLy91g4mwPQdJjzGDsaEfFX976ewV1o5b2R7RmjdW0RU2PObsu?=
 =?us-ascii?Q?pRIW/7PbTeeNXHltQ+900CxPhnCc62UFYLVvrTl5C6y6tSrERATglncou2kw?=
 =?us-ascii?Q?bt3qN8gnw8xFjR7MORLo+ADHuUC6tCHqSkjaciU+u0s7KEfUxoJw9iHCL7Gc?=
 =?us-ascii?Q?UWrI03yAPxsUv9/6oKw35WITq7bz/F/4XaTTVt5XajF7wNQQo7fCjtGsDUO3?=
 =?us-ascii?Q?O9ymMsPRMxWMUmB9zeOOwAPP/hjW6XXbTXffyF/MjfUEBga+teHdb06KNzZd?=
 =?us-ascii?Q?om3aSx7fkzasitGCYNl2Ao19+6e9AEyAErpmN7o3PZ/TFSOWpUPxqIeafU+c?=
 =?us-ascii?Q?bxKwt19cQ3I6HpBSTkbMbanhLUlxQFyPqujsaWdH8lzAFhwNRta34657Ra5s?=
 =?us-ascii?Q?Kh/BPCekrL9ltrh/tD8zbthmE7yRIwX8D3iVO0fDv5jr7CLUu/tXlvlUSdRu?=
 =?us-ascii?Q?9aTzQ+zV3+vRH8DkK5aid9JAwZyXVfLgcCiwkBhKPXqSPvN0HWv4cZXilXsv?=
 =?us-ascii?Q?4QtvI1nx2nCPfXvfdzKburga3dUXbontlzzpkFkOpCeDer5x3IpRIFUscm/E?=
 =?us-ascii?Q?2AVHPCV1UdIYS3US/p/MbekUvhr+TV4MB2xIJWd3svuRSivX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e0e3c3-464a-476d-ef75-08de800ba1e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 07:47:38.1893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mwxgdzHwihQL9tjlcMe5QdQYXN9aMlQIo9G++3HRC6gNsHNy4un4DoKJRP+p6n/AOi30mMJdNKq6Mda3PO7/oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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

Please warn the "invalid" umc_num, and fail the function in such case.

With that addressed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, March 11, 2026 6:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page

The flip bit setting is different if umc number is half of original configu=
ration.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 109 +++++++++++++++++--------
 1 file changed, 75 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 0f5b1719fda5..3d34592e8ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -183,50 +183,91 @@ static void umc_v12_0_get_retire_flip_bits(struct amd=
gpu_device *adev)
        if (adev->gmc.gmc_funcs->query_mem_partition_mode)
                nps =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev)=
;

-       /* default setting */
-       flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_C2_BIT;
-       flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C3_BIT;
-       flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_C4_BIT;
-       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R13_BIT;
-       flip_bits->flip_row_bit =3D 13;
-       flip_bits->bit_num =3D 4;
-       flip_bits->r13_in_pa =3D UMC_V12_0_PA_R13_BIT;
-
-       if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE) {
+       if (adev->gmc.num_umc =3D=3D 16) {
+               /* default setting */
+               flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_C2_BIT;
+               flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C3_BIT;
+               flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_C4_BIT;
+               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R13_BIT;
+               flip_bits->flip_row_bit =3D 13;
+               flip_bits->bit_num =3D 4;
+               flip_bits->r13_in_pa =3D UMC_V12_0_PA_R13_BIT;
+
+               if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE) {
+                       flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH5_=
BIT;
+                       flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C2_B=
IT;
+                       flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B1_B=
IT;
+                       flip_bits->r13_in_pa =3D UMC_V12_0_PA_R12_BIT;
+               } else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE) {
+                       flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_=
BIT;
+                       flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_=
BIT;
+                       flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_B=
IT;
+                       flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
+               }
+
+               switch (vram_type) {
+               case AMDGPU_VRAM_TYPE_HBM:
+                       /* other nps modes are taken as nps1 */
+                       if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R12_BIT;
+                       else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R11_BIT;
+
+                       break;
+               case AMDGPU_VRAM_TYPE_HBM3E:
+                       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_=
BIT;
+                       flip_bits->flip_row_bit =3D 12;
+
+                       if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R11_BIT;
+                       else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R10_BIT;
+
+                       break;
+               default:
+                       dev_warn(adev->dev,
+                               "Unknown HBM type, set RAS retire flip bits=
 to the value in NPS1 mode.\n");
+                       break;
+               }
+       } else if (adev->gmc.num_umc =3D=3D 8) {
+               /* default setting */
                flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH5_BIT;
                flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C2_BIT;
                flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B1_BIT;
+               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_BIT;
+               flip_bits->flip_row_bit =3D 12;
+               flip_bits->bit_num =3D 4;
                flip_bits->r13_in_pa =3D UMC_V12_0_PA_R12_BIT;
-       } else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE) {
-               flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_BIT;
-               flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_BIT;
-               flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_BIT;
-               flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
-       }

-       switch (vram_type) {
-       case AMDGPU_VRAM_TYPE_HBM:
-               /* other nps modes are taken as nps1 */
-               if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
+               if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE) {
+                       flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_=
BIT;
+                       flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_=
BIT;
+                       flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_B=
IT;
+                       flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
+               }
+
+               switch (vram_type) {
+               case AMDGPU_VRAM_TYPE_HBM:
                        flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_=
BIT;
-               else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
-                       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_=
BIT;

-               break;
-       case AMDGPU_VRAM_TYPE_HBM3E:
-               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_BIT;
-               flip_bits->flip_row_bit =3D 12;
+                       /* other nps modes are taken as nps1 */
+                       if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R11_BIT;

-               if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
+                       break;
+               case AMDGPU_VRAM_TYPE_HBM3E:
                        flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_=
BIT;
-               else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
-                       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R10_=
BIT;
+                       flip_bits->flip_row_bit =3D 12;

-               break;
-       default:
-               dev_warn(adev->dev,
-                       "Unknown HBM type, set RAS retire flip bits to the =
value in NPS1 mode.\n");
-               break;
+                       if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R10_BIT;
+
+                       break;
+               default:
+                       dev_warn(adev->dev,
+                               "Unknown HBM type, set RAS retire flip bits=
 to the value in NPS1 mode.\n");
+                       break;
+               }
        }

        adev->umc.retire_unit =3D 0x1 << flip_bits->bit_num;
--
2.34.1

