Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3898EED60D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 14:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A26A10EB8F;
	Thu, 12 Sep 2024 14:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DOYYVevD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B3610EB8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 14:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKn79zWICXlon3tKLEC5KBHiNFSz1aW8V44kpPep+aGUkAZz1PyCdqt1CwBGefB1Xeax9n+yGbEANjDGkPahbQorHFvbX3b8U6j3datx8T9mMfAs6no0J2KcyJa+/nYJy+fWnjENGW5JScecDZOefv66nARrM5C3bY2NzW7WypWzh8r2i5HDvzIxDIpE5wdzdkdQwhlHi7/k3FgT5j+BNIjhrqWfbYxZuZ5RbiOpnUcKSWVlPI3dVIxXy3VJZvbKrLmMaFF1q+wKkl0YYm83A0brJ0YnlA6YMRRmFz9OiLgAp+IsroqcE42qaY/L8D/n77JKFRt73ciB0wfAGLWgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4NkbPgS5/JYkBMgWEV2N3pkv8ZEwYEvql2jDmL6i/M=;
 b=GE6gGCntKVmbVjBAPyEecvI0ASJrshWJACfMWC5/nfnjpNIKvCpw+LR6wEpTGtyBZw6y6V++PI28TwsQGcybd0vv+fOeTmCMilZVL7A0IdgRuznpi/JEZsq6jUCvd+Lo/bsYrQshEJOAwDsjTaSNTqVmG3NmoIHzVMBszyn8joadYRZv/qUABix9r1xlkOTPAKjgQ5i/tJPhU1uKawYuSJNaJnwIUKfSoNm4/nDohUEM4pzSJ03sqCSNDjnv8g4EMnE0++wp5JKxMN/no9K0tA0lfqDu53OFBz7dkumZnk/RQjUj2uSSSb5GmNfwvq0z7YDcItciQ44XjJ5SbnGq0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4NkbPgS5/JYkBMgWEV2N3pkv8ZEwYEvql2jDmL6i/M=;
 b=DOYYVevD22UPbRRk+zKygcnjyxkIcLnqGe/pP2O36jNFKVBwUY6Mw2me1hfNQhoG6Rb3NvSPOH5DzcAvQl/dfIgSMW58bYuu19e+s5DR8NrVLj2YCRQhpVx9RHjYDZU+gPoh+LMw3ZHdS/JIBq3FzngHHsO7yEoz+n3oFS8qATQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 14:33:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 14:33:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: load sos binary properly on the basis of
 pmfw version
Thread-Topic: [PATCH 2/2] drm/amdgpu: load sos binary properly on the basis of
 pmfw version
Thread-Index: AQHbBPrVB9rvyXBwiUGK+LIQDP74Y7JUN4kA
Date: Thu, 12 Sep 2024 14:33:57 +0000
Message-ID: <BN9PR12MB5257469148FED9CFA350D8ABFC642@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240912100142.599746-1-le.ma@amd.com>
 <20240912100142.599746-2-le.ma@amd.com>
In-Reply-To: <20240912100142.599746-2-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=456c4545-a9e8-4a6c-be5a-2507d5750b3d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-12T14:33:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7307:EE_
x-ms-office365-filtering-correlation-id: dfb56e20-7e6e-4e2d-25b2-08dcd337ef70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?V+JamqvS57i63sG401xrI7Hz47iHY7oF/PBtqL9Pp/S5jdczSJ9tEV0L+Gc4?=
 =?us-ascii?Q?YRzdfmKY0LLwgvbHw+53wlEF7FHYqOrJjG3IrS0ugOImpQbY4VHv0WIs1ljY?=
 =?us-ascii?Q?eTrinCTWsZsDvOz/+uLR4wCjWA/8TQR5tG+nRcJCPN50KDvD1oWglqUT/U0P?=
 =?us-ascii?Q?x48Dlgg68hNCCfkrWNbwwVHgnh4JT5W0l2dwzJEt5l0kZrGw/qpjHG0AgeGw?=
 =?us-ascii?Q?UOtzc7cG0zP630S+mctrvmOsydz74Fnd3mnuJce4ipHsf/Asx0XN8OoZ7pZ4?=
 =?us-ascii?Q?+XLBCXfpJ5WoEXhs+O1X9zWxL7xZyvr1QV8ejL6nAxT8KK6jnY/fAwjvggrg?=
 =?us-ascii?Q?szesHdkxjeO/w9CcvGUPClMeeEgODJumJ3YofrPR68reCtLU+4iuXv0NAAoA?=
 =?us-ascii?Q?JI0ExWBWD37yzB/m/6Svw0OpFXfjmZ5E7sfN3lv+gg0kGEPZR7LBnOPB+AeD?=
 =?us-ascii?Q?DO3q2mAeC+xBYxwjw7psSifRQgHsDqAqLZI5/ngH/NmptJ+hByJ+xLdbRcgh?=
 =?us-ascii?Q?jxZZ/QXu9NPPYzaLdWJNCrIiNJqPc9M6LEi6iVd04G1yJyqQZ5qrPsK/xXGf?=
 =?us-ascii?Q?J7FHdl9e77RIeFFq9dnVt/Re6nWto6T8cm0rL1EABMqwoCsGPnAvMCnZO3c1?=
 =?us-ascii?Q?UT288XLOu6ck1my7eUxCw2FoYfHMTW14WpMYS+5iCIFM0281yaUgkdFMFfOk?=
 =?us-ascii?Q?xa6hWBxj+rMAOmnXRcTylRo/D8G7RoP8BGCSrcrGdcYQTFg6WqeDhOckDpj4?=
 =?us-ascii?Q?V6VY9Cl6OYU1Y1Xfx29DMU5JHXyCLIP+EVIElH57G9j7LuB2rNRFIg9KqGJe?=
 =?us-ascii?Q?J5qT6tlqKERvJ+DruEJhubikL0+CzR7IwSpc++yv6DePxT9QuTWJ4cndS4CA?=
 =?us-ascii?Q?xB551U0kxQ5ugxZd0xaYiaJcEid7GL6HI9MkraVl6FUKZcJs6KjPepALHLxd?=
 =?us-ascii?Q?3jqHnhMSlciyuBOzvwuSfMf+30/Ot/5iZfZcyvvOy1TBmhsKQiy/vdTQiUi1?=
 =?us-ascii?Q?Qb5wgwaHpcVIW6bNXbUW2wVYbDWhshvrU6tuwqa1G7dttdltjDPjuthmhORV?=
 =?us-ascii?Q?g440nw4xQySe9KA5Uv17GN30+3D5ogxi4PsWjSmjwS4NVfpM84wKRM6QUZWk?=
 =?us-ascii?Q?b/FOTFLbr9pAVVd0nYuYo2+mLhzMItM54woPn7HOOMWUwwxW3tO9207zsbdn?=
 =?us-ascii?Q?gQyDBNDclAUsZSpp9X7SF3rdRmok8U5j00rkMxKdXESTZqH4TBqye/RNHuYq?=
 =?us-ascii?Q?vxEIUsu3QKcgncJggyafrfYaKCoLOElN0zlVl2cIwL78ToYu5tEvbg7wOjN7?=
 =?us-ascii?Q?OxAk/3j2mLOl6SB9MSZIjkBSevJ/zY+Rg0X7mJc7JWBzLnfu3qb5Kaskev7B?=
 =?us-ascii?Q?6XCRqhzN1Nd8YmaSMbV3gtkxeFNzmtMmde2BNmqc5VBwxpTFCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nM0Mqh2RMoZgSg3/hDeanP9wx5rGdbMkPq0vuUPH3e3srZuky6Gw3Ylkgt4Z?=
 =?us-ascii?Q?YL9s0FW+AYGQngzEdaWPAV/0FPLUZpV+G2V7lV2iz6/SHNDkUEOnuxVSUpEJ?=
 =?us-ascii?Q?nGBt3yVcJzODWuhTUtiNZJtBa9js9PWBbvUe1bsixfTK0GJmQvzW7unNddv1?=
 =?us-ascii?Q?PvAN+3xPwXZdsKh1ccTXasgHZ6YS0Kuh1X3VQkDv9nhvvJdTVO0yJHTeu/hR?=
 =?us-ascii?Q?Fw+Qaf6J1dQdTjCApoAretNcKW+VT+6KmwMu1TF/LdcWMT2Ph7XfFLZRGEtA?=
 =?us-ascii?Q?ufP30JhiL0qj7rsHX7bRYJLGAZze5N8sc7fy+qCqo33WWVKGq0racAYFayFa?=
 =?us-ascii?Q?opkmTKRLAKSF5Y4T/4yRxw4AfUxYaPXhoBiTDaI5DnNfaHVoLp8KH6Rd3C++?=
 =?us-ascii?Q?Lyw2lBQ7Uuz/6nDdpKneUoNoGZnqmHu37CwBZzaIlFqN41RAJ7e8xzwXg5mW?=
 =?us-ascii?Q?htYPsleHZPmYIgUmUqMgF4HBPyJ7ZJAeFu/5PwvMdik9by8A4/KEjcBvLks1?=
 =?us-ascii?Q?n9GxpzDO0kflEm/wG6QUrH2VkJ98Qv/AZwOgJGYd39g4dbxaghxf311a7+1p?=
 =?us-ascii?Q?RvoG7p5ZrK587Ld7x9U65r+TVbGItegE+mUGDW+g4prrNvif4IDqRruh6E3I?=
 =?us-ascii?Q?qLHXmrSFW5E0kQnZ9lyiQmDxt1/LPAXDrHi3lrs2C4jX+ndO/b9/ydKUM+sH?=
 =?us-ascii?Q?UFDXPA381nRHwnbR1h3lglGtLK+JclCtzDbrlgnI3InClipxOdaylmSd4nkV?=
 =?us-ascii?Q?ZupQPDqoAQQwT86OmySy0NyLbJHSIEgWjyAXc5BSayP3XrBEz24rj5XseLiD?=
 =?us-ascii?Q?jDwBDnfZbamEvpcY0OH/rpRx2gkSXAw8gH5CtMQFIxuNw+2bpR6Zn7B2chSB?=
 =?us-ascii?Q?FtG9c/Asgb++56Q9G59V5plupTo7SIMsWt9ySXBt93/3r6778Z27l8j/kUxo?=
 =?us-ascii?Q?Wj55K+LwuKYLnEAfxrHKfXdTl7d+oO6j/YfRbYcgHSZx54V8kf/JW6syZinl?=
 =?us-ascii?Q?yYuT3v5fULxTLihkf3GpRNvAVo3OwUxC/0Ph2oDEj8xC99QC2Lic1YzcO7OW?=
 =?us-ascii?Q?0QnJ9f4GdbDZfKklw+TfmsvZYZDOWyGYNavvUCcR9VwuzGUrwHyCAQw8u/dV?=
 =?us-ascii?Q?OI7ATD4H7fqL/YM947TtFEdoVyTnaBu48TboflulF3w2XGeJk98K76N124ni?=
 =?us-ascii?Q?R1/27M7O7ZUafjWE9fuPrbNL9TVgfD46Leh9VoxEd1BNUuFQ/sTEghmxRTJ7?=
 =?us-ascii?Q?tQeclcuOCbZCpwxZJXvW3WhVSCZfzMLwikazCYXERgQ1K3B/fXywtr1C1ZsW?=
 =?us-ascii?Q?88p0Kd+ylnH0rl07w85WhFmih3zW3+AIJmJE4dxUQph9duJsPEPzuB6R1Ul9?=
 =?us-ascii?Q?fCrXkhk+jDmHYgS98PW5qIyTSZzaKnNpVr7y/G8yFAkimg79ofxj5hD9jNZa?=
 =?us-ascii?Q?QapBLapVymYtHlyg7jYqb4n0NwgE8PYHJiUJ3SirB/vg23176pL5CliNoj6J?=
 =?us-ascii?Q?KpIHNl+dFelMl3rD0xTGORnCKUUPwPWOZuUCSCtB/lxpuTJz2ARzwpauXQUy?=
 =?us-ascii?Q?WnVh1Ji5i/k/B1q8kvs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb56e20-7e6e-4e2d-25b2-08dcd337ef70
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 14:33:57.3210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBdadYiEOJVbIehoYn1PcueG2+aD/Ua/WwAQ+rls5FEVIyGcifYijAHfHV8Wmt22QPEzmy31TZvFG6+tn7EnIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Ma, Le <Le.Ma@amd.com>
Sent: Thursday, September 12, 2024 18:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Ma, Le <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: load sos binary properly on the basis of p=
mfw version

To be compatible with legacy IFWI, driver needs to carry legacy tOS and que=
ry pmfw version to load them accordingly.

Add psp_firmware_header_v2_1 to handle the combined sos binary.

Double the sos count limit for the case of aux sos fw packed.

v2: pass the correct fw_bin_desc to parse_sos_bin_descriptor

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 29 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 11 ++++++++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 189574d53ebd..f702f3391c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3425,9 +3425,11 @@ int psp_init_sos_microcode(struct psp_context *psp, =
const char *chip_name)
        const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
        const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
        const struct psp_firmware_header_v2_0 *sos_hdr_v2_0;
-       int err =3D 0;
+       const struct psp_firmware_header_v2_1 *sos_hdr_v2_1;
+       int fw_index, fw_bin_count, start_index =3D 0;
+       const struct psp_fw_bin_desc *fw_bin;
        uint8_t *ucode_array_start_addr;
-       int fw_index =3D 0;
+       int err =3D 0;

        err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_so=
s.bin", chip_name);
        if (err)
@@ -3478,15 +3480,30 @@ int psp_init_sos_microcode(struct psp_context *psp,=
 const char *chip_name)
        case 2:
                sos_hdr_v2_0 =3D (const struct psp_firmware_header_v2_0 *)a=
dev->psp.sos_fw->data;

-               if (le32_to_cpu(sos_hdr_v2_0->psp_fw_bin_count) >=3D UCODE_=
MAX_PSP_PACKAGING) {
+               fw_bin_count =3D le32_to_cpu(sos_hdr_v2_0->psp_fw_bin_count=
);
+
+               if (fw_bin_count >=3D UCODE_MAX_PSP_PACKAGING) {
                        dev_err(adev->dev, "packed SOS count exceeds maximu=
m limit\n");
                        err =3D -EINVAL;
                        goto out;
                }

-               for (fw_index =3D 0; fw_index < le32_to_cpu(sos_hdr_v2_0->p=
sp_fw_bin_count); fw_index++) {
-                       err =3D parse_sos_bin_descriptor(psp,
-                                                      &sos_hdr_v2_0->psp_f=
w_bin[fw_index],
+               if (sos_hdr_v2_0->header.header_version_minor =3D=3D 1) {
+                       sos_hdr_v2_1 =3D (const struct psp_firmware_header_=
v2_1
+*)adev->psp.sos_fw->data;
+
+                       fw_bin =3D sos_hdr_v2_1->psp_fw_bin;
+
+                       if (psp_is_aux_sos_load_required(psp))
+                               start_index =3D le32_to_cpu(sos_hdr_v2_1->p=
sp_aux_fw_bin_index);
+                       else
+                               fw_bin_count -=3D le32_to_cpu(sos_hdr_v2_1-=
>psp_aux_fw_bin_index);
+
+               } else {
+                       fw_bin =3D sos_hdr_v2_0->psp_fw_bin;
+               }
+
+               for (fw_index =3D start_index; fw_index < fw_bin_count; fw_=
index++) {
+                       err =3D parse_sos_bin_descriptor(psp, fw_bin + fw_i=
ndex,
                                                       sos_hdr_v2_0);
                        if (err)
                                goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index 5bc37acd3981..36b14c1b94b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -136,6 +136,14 @@ struct psp_firmware_header_v2_0 {
        struct psp_fw_bin_desc psp_fw_bin[];
 };

+/* version_major=3D2, version_minor=3D1 */
+struct psp_firmware_header_v2_1 {
+       struct common_firmware_header header;
+       uint32_t psp_fw_bin_count;
+       uint32_t psp_aux_fw_bin_index;
+       struct psp_fw_bin_desc psp_fw_bin[];
+};
+
 /* version_major=3D1, version_minor=3D0 */
 struct ta_firmware_header_v1_0 {
        struct common_firmware_header header;
@@ -426,6 +434,7 @@ union amdgpu_firmware_header {
        struct psp_firmware_header_v1_1 psp_v1_1;
        struct psp_firmware_header_v1_3 psp_v1_3;
        struct psp_firmware_header_v2_0 psp_v2_0;
+       struct psp_firmware_header_v2_0 psp_v2_1;
        struct ta_firmware_header_v1_0 ta;
        struct ta_firmware_header_v2_0 ta_v2_0;
        struct gfx_firmware_header_v1_0 gfx;
@@ -447,7 +456,7 @@ union amdgpu_firmware_header {
        uint8_t raw[0x100];
 };

-#define UCODE_MAX_PSP_PACKAGING ((sizeof(union amdgpu_firmware_header) - s=
izeof(struct common_firmware_header) - 4) / sizeof(struct psp_fw_bin_desc))
+#define UCODE_MAX_PSP_PACKAGING ((sizeof(union amdgpu_firmware_header)
+- sizeof(struct common_firmware_header) - 4) / sizeof(struct
+psp_fw_bin_desc)) * 2

 /*
  * fw loading support
--
2.43.2

