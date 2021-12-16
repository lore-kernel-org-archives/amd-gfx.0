Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BB1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 20:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450A210EE0F;
	Thu, 16 Dec 2021 20:04:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C6710EE03
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 20:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnbmVOGq3B1laJOz684/BbwECEdL+nSU3C5nfte+o59h8x9JRYpbPVgdUfilSuHGJgSd4IPg9a4D5iNb9p/CjR0D7geoQenR84BN4zUJNtbWEx7Hp8tvmDFbAdXPoDd9Z4uSTqkKfMeHFrpoecJaXm3f2aOWF6myYxrehXL04gFTL10Wn1+F5KzT9lWZfjoGMsBJ1fWQsAi4y0AJSZZXtlNS78J0OWtY+kGgfG4eAL19Lq6hSf/y9wYQlle71PqXXOPkhDtpfhORq8kXvJLQDn2/yf+ECe0d4moQAZL4/Om3sYIaKrcAVt+xbiLpJlZfbF9+d6cj1PuZ3gU7wfOgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX9SV8pU+mgVYXtOWVl1Yz0uEHkPnK4ZtZj3YJ2vi6M=;
 b=Mt6MB8b1Ai3CPOCQ/oNoYGyHDcr9+Vidhz7/+laYLtQgU/H35aRNQcigpU+V8wS5urDRDoHfW2cOFqNCBdyIc0LkCpclRoCQv2qIxydX59J3c1ApOzf3rNUu0wWWSoNvd6NVuG9hZcrcTvfuOnCUons9NOnSUMwjzeFkCpmSbbN9psQ3qHjNGcVE27PABB1rlAeB89rbIj23TwbjQR+bcHl0acM1DOIh1t4EhlB+sq/T0oXz6xz43afLAjVI3XQWvzSq22LsdbRkZLEyE33AreGqvFCnFxb7PoIBQOKj2AIjTKKBadf3SPjSvF/ZioPzEANKtALm4k4BlO8IErP04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX9SV8pU+mgVYXtOWVl1Yz0uEHkPnK4ZtZj3YJ2vi6M=;
 b=yPr6HTDKJva0zuWui3HUeDQp/SZ8igg8DtND8NsYPZy3YRJoaeut8BhnVZ/JUo8YvKR9EkedT1hPXc0tq7vwRsxKpAIZEZEP8ISip7+gJqYFqXfgBRyzMPnpkCtOfZK/1v5iOQR+LIGQBIugfrH7p9C+ikTxn7iC4+St7EpIR0k=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 20:04:34 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 20:04:33 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH v3 5/5] drm/amdgpu: Modify indirect register access for
 gfx9 sriov
Thread-Topic: [PATCH v3 5/5] drm/amdgpu: Modify indirect register access for
 gfx9 sriov
Thread-Index: AQHX8rUhXAv2gc7NfkiobH7XlCXi0Kw1ityr
Date: Thu, 16 Dec 2021 20:04:33 +0000
Message-ID: <BYAPR12MB284013E7528672ABB17CD67CF4779@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
 <20211216194233.3839-6-victor.skvortsov@amd.com>
In-Reply-To: <20211216194233.3839-6-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T20:04:33.223Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 111b8dc6-10ed-67bc-0382-777988946582
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e8b76cf-35af-41cf-8f21-08d9c0cf477b
x-ms-traffictypediagnostic: BYAPR12MB4630:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4630293ABECAD2842EFCB519F4779@BYAPR12MB4630.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqAqxCzuDO60rfYjqE2BSUzEvrB5KYQCTnXT9lX69j2dv8PraCLCvqcPyx2GoQ2XTHfvlvRmqHZiC5Y/eG2IvZUzqz/QUgKZb7D2y6mDEH/mPU+8g2WoMr94LZbbzK58BV57+sfO/hP+dQERCjiuqJHHS1FhXeXTW8GI7NeK6FvdN+aPxL+FI8IsEheVPe910ncTdCuJ0cE7OSFc+oUSEu5yM1PzgBdL+1wDgg+BsHd6dMkPy/CY3FZg19bFQyb50ijzbEXmG52ajo3wu8P5Rssa9wyEBxBiDpQWKgQ0ubtiCCp6y+ZECjSPmhpyuicSdU7SCYmo1f7BmqnWlDKaND5MYSPV4mkvhwV2PrH2Vl9VVGAom0NjYo40I++CfFT+2zAVBh86Gm+QW+qM/XQS5WZbu/KrcD1mSbEuHDkwfxfL2hRaVY1Q9c4tNJ2vgjn7S1ycLIRfLM9m5ajcU2dQWxhhISSn54+gC7Ef93J1IENVXYQZzGPJfkRJy22gKfO+GyQ+PikY7rL09FPy9+RtEUREQRlx1s32ywFU4ZYwEZ/pe4sViTHMox/r5j7pElzWmJ8W75QG+3Kilmwov+fwGw4w5yaOP3Y/LZxuSBXEtBUPuBN/CodfCTxU11UTHELV1g5SFZxgHaeaF9RZQXJig8hAP3k2haa226vE0Xz7m+2dFfRJQaRplAZvVB5u1SZ+x/vUhXLIm0tBMTa/7fXZGFyd8nzIWVeFlMLuxGoR0us=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(110136005)(55016003)(2906002)(6636002)(38070700005)(19627405001)(316002)(66476007)(86362001)(7696005)(53546011)(6506007)(52536014)(83380400001)(921005)(66946007)(5660300002)(76116006)(8676002)(66446008)(64756008)(66556008)(186003)(508600001)(9686003)(8936002)(122000001)(38100700002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t+hUdI1692fgpeUpcKKhI7hgIRyEX7Pc9OwNCC/Y+2gpyJqrkGxtbryOucyo?=
 =?us-ascii?Q?oibtDHvJh5IvHsn2PjhLMnvJP7XSqJwjt+4Gj9/ND9LbQnfsPUgRknZxKESK?=
 =?us-ascii?Q?/VB/Noah2tdlXE3pkKEBbApouKK5QPFCH9XimuQYjz/w55cgD/zFPwD4+XeF?=
 =?us-ascii?Q?7axtby4/M/vTQLew0ArC3gKkdzyfOiRqQfPXt8sPI+broMOszvV8ncLc7+ZX?=
 =?us-ascii?Q?0WCjYrH0Kk+EpHQBHw1qAINNCiyBvqB4xXlhZ2xTh8ou7vtrbBekYyV/NU2u?=
 =?us-ascii?Q?2FhgBnD59PT2KcOO5Q6cVdqZY7Mj8+FQZJZL2jXthJ17zw6ane1eJ9WvasmP?=
 =?us-ascii?Q?vytpyYcAhv8AxJP6vQP+MguDfs6pHTDGZAuLOCw4IEdNr0fO7HdIfviWvwE8?=
 =?us-ascii?Q?KVKaXsfP9hsbIrBoObKKRwKx8KohfJiCQB554BBnHIJ5sG8ta1wK6ufeM0VZ?=
 =?us-ascii?Q?mkOWT5kHRuGfD2j1OZIS78hTZvlvxfxBZEmSpGJaNrofqZt+yIIRaQmaCFfs?=
 =?us-ascii?Q?846aa9QfdH2mcK5LwViUdmri0UgE8m0iaMa4tfYUmR3VpiDGMTCEGY11I0Hd?=
 =?us-ascii?Q?LkVj4AQ3oxJKGZvz+lWYpSVr8l9HO5UeDyhLAIBcmNLvspH3vC53PNGtyavr?=
 =?us-ascii?Q?X5wg55iQPlU8g0jVms590Y/d+qLU0OkTz0cMRCAfkoojyk3MdZHYXcWKGYUE?=
 =?us-ascii?Q?H8UlYfvxoFgfWgdusYpBaJdDWfGMjD3xeZQvj8QBnkpYf/XMCwEr2tl69vSD?=
 =?us-ascii?Q?mo34/hCVzyoch7ZyZQONZUZW02Lwrd3kTYJmD4yNQtXkLXHTPK0hbLU71IFN?=
 =?us-ascii?Q?I933FTr25pwAGlcqg65uwRgxeuxhvSHxdNenkDleV0qLucrC7/HNa2E+kbm4?=
 =?us-ascii?Q?95cJEV22Ff7/ljYRqx2890oErDjDHh2HtwRhgXODp4aMt8UWB6cCx8Sc1p4W?=
 =?us-ascii?Q?rKpTE1uzW8Uu1FFF5uF/JgyMqYgzsmiY/ziCF15y1EqsaQZOewQ1sxViDxLN?=
 =?us-ascii?Q?/Crs1SamoDJn3UiyCWZIQcTN9Hnrf7BBGHhWjJZu6hMEpD+F9Yn4sKBFrLGi?=
 =?us-ascii?Q?WU69CMcGpTyddyMSJuOD2INIsJtnE/4Sgv50++oObPH2F0JSjxnLWA0a0+Co?=
 =?us-ascii?Q?H4T2lG7CL+8oiprWfdQA9TjZJxramCJIPFxFAAQDohUyh29mMNV9wBIMwolX?=
 =?us-ascii?Q?ZsFLqyUKBcm5qx5+N4MnSSiwhyfnoQDNCE1XTQgNhn4xosmkIs8rC+gXIT/m?=
 =?us-ascii?Q?fhLpcq8Z3gHT1pGqOn9ajCJcC4WlzaRnx65UbpiJ+Z+65eU5eyf/tBx0Azso?=
 =?us-ascii?Q?i1NEYNDsT9BTTJJqfthPfXml+DmryvoM+Kja6zV3qSnUFEf/IEB6cxE4R+jn?=
 =?us-ascii?Q?4kvRGSq1g9sGGe0Nf7QWqup8lyM3EtMhhqsGhPTbB9UNwDoKz+rN7EWsX46o?=
 =?us-ascii?Q?zFzkPw1dxRy17LMwpowDQ9F9DkbbnvB+R+uBbRYr/Q/6ghqqIVGhnBD8SqCz?=
 =?us-ascii?Q?yKtPC3aC4BJABzlFaFC62Q/5Q+EXj+MD1mUtqI7gH/pfUxx64Ry3lj4jI6mb?=
 =?us-ascii?Q?ODgIN2xJdz+RDUCM9/z9f2F+XqjOiDhRyLDQnain?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB284013E7528672ABB17CD67CF4779BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8b76cf-35af-41cf-8f21-08d9c0cf477b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 20:04:33.7870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhIMPzrfM1Q++T53WHjUReu6+ezT4NpvfEQXCUo/pBL48r3qs78aaVr8+F7gjE+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
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

--_000_BYAPR12MB284013E7528672ABB17CD67CF4779BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: David Nieto <david.nieto@amd.com>
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Thursday, December 16, 2021 11:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v3 5/5] drm/amdgpu: Modify indirect register access for gfx=
9 sriov

Expand RLCG interface for new GC read & write commands.
New interface will only be used if the PF enables the flag in pf2vf msg.

v2: Added a description for the scratch registers

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 117 ++++++++++++++++++++------
 1 file changed, 89 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index edb3e3b08eed..9189fb85a4dd 100644
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
@@ -771,41 +777,95 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f

                 writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
         } else {
-               uint32_t i =3D 0;
-               uint32_t retries =3D 50000;
-
+               /*
+                * SCRATCH_REG0   =3D read/write value
+                * SCRATCH_REG1[30:28]   =3D command
+                * SCRATCH_REG1[19:0]    =3D address in dword
+                * SCRATCH_REG1[26:24]   =3D Error reporting
+                */
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
         }

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
+       }
+
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
@@ -5135,7 +5195,7 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)
         if (amdgpu_sriov_is_pp_one_vf(adev))
                 data =3D RREG32_NO_KIQ(reg);
         else
-               data =3D RREG32(reg);
+               data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);

         data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
         data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_M=
C_CNTL__RLC_SPM_VMID__SHIFT;
@@ -5191,6 +5251,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_fun=
cs =3D {
         .start =3D gfx_v9_0_rlc_start,
         .update_spm_vmid =3D gfx_v9_0_update_spm_vmid,
         .sriov_wreg =3D gfx_v9_0_sriov_wreg,
+       .sriov_rreg =3D gfx_v9_0_sriov_rreg,
         .is_rlcg_access_range =3D gfx_v9_0_is_rlcg_access_range,
 };

@@ -5796,16 +5857,16 @@ static void gfx_v9_0_set_compute_eop_interrupt_stat=
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


--_000_BYAPR12MB284013E7528672ABB17CD67CF4779BYAPR12MB2840namp_
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
<span style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); d=
isplay: inline !important;">Reviewed-by: David Nieto &lt;david.nieto@amd.co=
m&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 16, 2021 11:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 5/5] drm/amdgpu: Modify indirect register access =
for gfx9 sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Expand RLCG interface for new GC read &amp; write =
commands.<br>
New interface will only be used if the PF enables the flag in pf2vf msg.<br=
>
<br>
v2: Added a description for the scratch registers<br>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 117 ++++++++++++++++++++-----=
-<br>
&nbsp;1 file changed, 89 insertions(+), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index edb3e3b08eed..9189fb85a4dd 100644<br>
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
@@ -771,41 +777,95 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
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
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SCRATCH_REG0&nbsp;&nbsp; =3D read/write value<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SCRATCH_REG1[30:28]&nbsp;&nbsp; =3D command<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SCRATCH_REG1[19:0]&nbsp;&nbsp;&nbsp; =3D address in dwor=
d<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * SCRATCH_REG1[26:24]&nbsp;&nbsp; =3D Error reporting<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
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
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
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
@@ -5135,7 +5195,7 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_de=
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
@@ -5191,6 +5251,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_fun=
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
@@ -5796,16 +5857,16 @@ static void gfx_v9_0_set_compute_eop_interrupt_stat=
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

--_000_BYAPR12MB284013E7528672ABB17CD67CF4779BYAPR12MB2840namp_--
