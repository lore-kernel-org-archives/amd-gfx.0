Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FE7FED2F2
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 08:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C0110EA2E;
	Thu, 12 Mar 2026 08:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u96rOIll";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2F310EA2E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 08:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDBbtOW8WGbeY9+hSXZ/XlZjfZJMNE1QIMznj+m0nscwTRaY24iSO1/ui3whxrKXa8d6ZzBN6fEaQDxKuYuie/gbsJYlLO1YlOTLbboANV8mJmyF1GgMg6SdaDBxxGS3KgDrrFMmQzoLzYjQq4mG/AzCQY6lPxmqzDnp6oE+Jy9vvGNs9usm34BesfCDIOr8mKBlWqeyyVxeD8exCl/xyxbrRiIMuq0kSapkUII88lDLWRu96XxbhRcN6SE7qUJTXG+vAkhHoaczfW/5Cn0pOZ4+CKzBI8q3zYXQ8IOeb4BktUA58C+bRvaNjPgoAG/KOUKJphGEqIogs8jEQ3zaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGyjmwwp5buchwvbO+qrpOxwJGxydHkAf1i2jqdmbHc=;
 b=uv/rMv/syTpVneeNlc3UWEvarlt/Tsix+31VKC+aoOM+Y/D9XzQXEsI9UYVwclRifPYmOuQMSbqqCvutYLcuGKtMDOqAh11w+tXITkwXPazqPlblRMfQkD/e0k6AhqF6ClwRYMdCEwvC4+tAZXLHO4rhib+plrWRFtrtRRoF5sbUCtFQ3IKXGBoPmze3i9gT+DouwMSNSaAgCDiTAu0szjp3te8u+lWSqVRgzYGRwiyTQAy78nQsFX2LbTQc4kzi5FSfIshqyAxrzC1dVCugYfVT4KsKmyElrQwYkUOPHwvmNBFFivTOO40/HQtMzriDFfoOj8JrBp8MOOtcDUUrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGyjmwwp5buchwvbO+qrpOxwJGxydHkAf1i2jqdmbHc=;
 b=u96rOIllTPcfKdj847cshaiBF4fzE75Qkz6uLd5MXtyUOWVLSksijUOE6KTkM5aagG8omxoPJKR8XCqyBqQLblhx7Eq/WqkOJD3byixBXtZh0MN+EjwOmSQzDGDwCiM9QF0/0AP+xdwrkkNKlNqtp7nO+NSIdjtWCoxKiLB90WU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 08:52:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 08:52:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
Thread-Topic: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
Thread-Index: AQHcsfdgQNsLvj8lk0mY+HTh29+pmrWqlwAQ
Date: Thu, 12 Mar 2026 08:52:20 +0000
Message-ID: <BN9PR12MB5257F56373A9FDAB6F2DAEFDFC44A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260312080747.485024-1-tao.zhou1@amd.com>
In-Reply-To: <20260312080747.485024-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-12T08:51:50.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6254:EE_
x-ms-office365-filtering-correlation-id: 6650d7b6-8881-4cb1-2372-08de8014abea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: VFOCy8Ok49CQx14qaMuAqkijfWCwqf2EnzeCOolAUSzAaKc604uOcxUTjkgbes2HT2sOR5KTC7kKF9OLRmR8MUdnCy8tOR2e/jV1/lS0Gy7Rz3E/6HMC2YFc2wCcuj0ztyb0pPGs1H7pQwa1KMyBWa+GsDFlRCfl4ySdPI3/uSQLGdXDqaG81Y+b3zkkw3T0DHaOPUM8im/LEGWZOLLx30F4kk4u69ITHoK2hqMViVNehNfP1jdhrvPrvmO0HjGHPjK0lib11LDiUukbPHyDIyan3gt82XQNckQJLcYdQgt0frnLZvdLwfNgoG0/1wzyyJ7MV6Murg9TGZ5cwzEWqjfK8aLvD13uJN4Tbsb58UL5i7egQQV7S9Y4zkbdMBYQVdtxmjM4AoSOOuZdJLcGtNLp4Cg98HlIvFmH/rdIlsWHKgOQ30H3rP2lwqO1/o3rqeNMmREQG3x78e7xH80+4wYEVk9Cmj9X/6/H8PGjuMEHa0N95pVtI+UpzszGBWrLczlXDpJwRo5Cc36oeRuT0qJmw7d1C06W+rul2WBdON9H7CGa4FAMazEV7RhLA7WBr3VfICP/dCjnBCaHd3he9EWVFiXfPqqUOUxCvUks3fyIv+tQWlUCTLkUSW9xDCjIRX0Exs6S2hJUCt7EsbMtYzuuqR+/OWuppvC/HIs7v0ZmeUx/N8ZK+pquA4vpGHGUDrJMTOkFgi0anAIqizlV7Cfdpm0SOfFenN9qchtj0/Yq1f0pYlG8eSyvccYNAlo7N3shUHUZk+08ZpenZjtxa0C+lQb/ia6rbCMs8y0h2ow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bK0oKtqEUvaeNHjbIiYlXL434cAZN+BwIzM8UZfuvue4rzTbIVH0F6cwExjt?=
 =?us-ascii?Q?uYQdz39Bf700QHU5tsiai8S+tbqQNlL9r/YDsS80d8uwOV5VM3WQ1fpt1ScB?=
 =?us-ascii?Q?KanXRDiBbqp4d9UrfJ7VEh+1oym3UAEIg06OzN8nw3EyIRZ46VjwNdzFzG8G?=
 =?us-ascii?Q?zLFD94NPG8t4L2XCdDd8Zbp9Na0UAiXk9udeqDimPXRpsxPbpPrpQX4skrIX?=
 =?us-ascii?Q?VJst38YdrMp2SMZqkrXQnY9g1DBAVk5hOL/JEid5qwQ+VgQpfbaLa+wLQZys?=
 =?us-ascii?Q?rKh+Y2KV3JriN9rRVh39nrW2R1rcSoTZY3arWM7JUuPzeN/chU9EVF3KNaHg?=
 =?us-ascii?Q?bin3+gcqsJ1Kz/+MV0Am/4LoXxQyImK5WQ9FO3vnOPs0B1Xm1PER+QdSD7bc?=
 =?us-ascii?Q?QKADZgCtSYrvL+7TMnzfcv8CK4NlWhDrZlU0B8erzupVaQ7SDhzHz8INe/H5?=
 =?us-ascii?Q?vnrFbAYvQ6WgKtlVdqH8Jamh2kqH35lTXkOlkzhU4JPqWK26DZ5jkQm6dMpL?=
 =?us-ascii?Q?iA1Y8qj1SIXVg3r5K0Wvpr69bfaXS/6sk9dTwONBYm2mnbU+3a2CAcBW3hTj?=
 =?us-ascii?Q?Hd8nqwPJdZ3dK/pAsjYzwWIPrSOoXXhbD5IwPOHeKwhwwQbmu50hjfCr1SY3?=
 =?us-ascii?Q?w8gxlwmIL20ltKVgfzED/a/qCGv0x7rbjwoVmsZennUZczs8BiASiGcd3Seo?=
 =?us-ascii?Q?zX2x+Np2YYipTepnXZ+tBszscXt0AwuEbmoFqHd6n1j1GiZFjm56JMJvI/Ko?=
 =?us-ascii?Q?t+P2ViM28zIDGuRtxUmovvIBTrj+kFq6twgCiDKbGxEBJdVqUdxdjWlCaRil?=
 =?us-ascii?Q?tXC2UP8BwLKcRRjMB7HKVsTisOjUunKi8EKNXvSNgPlh9CcBpcrUDBTPqLIE?=
 =?us-ascii?Q?rSe98Yls0yMOeP0ws5Fgcn7JcJupQKzJjGzJupLDdsbpZnZN13dzqYbWkJLN?=
 =?us-ascii?Q?j8R33nVtayPIsiZBN0T/6n5s9XUUXrkI/fDLDvFukbfTrq5wtr1eEtpuq9hS?=
 =?us-ascii?Q?81GEEBiXA5fGEMwSEqCaYTrII7tLqTQT35eajVaiclleDppMgBvkKvpSnNyl?=
 =?us-ascii?Q?r512Q8jVu76RyFX9MG2hbXc8Vfa1Wp9fP2N5c3GeQK8o4jkip+PSIx8ePBM7?=
 =?us-ascii?Q?X+jmt9nX624lxYFjRls9lwSuvdf8rQGCLGGFN0BVOLVVjkuSsqECgb6MHg6G?=
 =?us-ascii?Q?TvYwX8FeaDtTiUC5009bdsrqlVwQ9yTisDYlC7CWJ7xsI19VMFgikhk8cqe6?=
 =?us-ascii?Q?Y3hByvWHI21pirk30ymHsiiG9QTQrA4qs7BCguawofgC/YcL2Gu2wAUAOFi1?=
 =?us-ascii?Q?9HuE8cog7C+tFFywkNBsxmkvz2rKH0f3fAUJdglT52QuEUMcXmwBzEA5SJKK?=
 =?us-ascii?Q?jKDxITdqfi62ZMcYZvWZt8oER2+rpeTnUvWBCBwKISRziam2l3h3cdDnapxX?=
 =?us-ascii?Q?ALYzZURFJhXkguL1an6KlB3zggERBX3JdXCR1UMbz5YzzIr1YksGbVJg5YBB?=
 =?us-ascii?Q?c2kTk1jRbv459KbkkEvO7FERO3CKXhOMSN/RNaWokdG+7OXjeu6Ayc6H7Cc0?=
 =?us-ascii?Q?pYtXn3b0c60+q8aZ6wZ++UeUYVzeWkuYbbNuSI0rXpekJpcjAYnkUNnagKRq?=
 =?us-ascii?Q?ENFCx2P7JSNBq5wyB5seycez9njPMNE6JAQxIMQ+nUrDur7PlpFGcBoeDJN1?=
 =?us-ascii?Q?+s4v1ePgv+0/N9sW+VtJuhgCaLX2zMiZ2D5iL64UtkIvwoCO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6650d7b6-8881-4cb1-2372-08de8014abea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 08:52:20.5030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lncaSILcQQZmTHlN/UcMIzl89XP5t4JzWcK4VFir//nGu2cy1zj2NjqkwSaopjUPKiOyCwoXMCRaYNcQ4nZWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, March 12, 2026 4:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page

The flip bit setting is different if umc number is half of original configu=
ration.

v2: block the flip bit setting for unsupported umc configuration.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 113 +++++++++++++++++--------
 1 file changed, 80 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 0f5b1719fda5..6cf674dfc8c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -183,50 +183,97 @@ static void umc_v12_0_get_retire_flip_bits(struct amd=
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
+       } else {
                dev_warn(adev->dev,
-                       "Unknown HBM type, set RAS retire flip bits to the =
value in NPS1 mode.\n");
-               break;
+                       "Unsupported UMC number(%d), failed to set RAS flip=
 bits.\n",
+                       adev->gmc.num_umc);
+
+               return;
        }

        adev->umc.retire_unit =3D 0x1 << flip_bits->bit_num;
--
2.34.1

