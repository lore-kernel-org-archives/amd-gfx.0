Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EC5CD4F3C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9059810F232;
	Thu, 21 May 2026 07:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c5L4Wa63";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69EE10F232
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 07:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBhdfV6dZClK1ypz9Y2L6BZClAu8xpWMJsM5B9Qd7MOewpJ3uhWBJqYBSQFiLcgn/Izj59vV7yIA+BaUN4XsiL/DdHkBhe58aNK0cQG/UTbtFVhvr2JxfQMPMQCEWxIKO/2BjVXG/s7VVT8dFi6g78eVb4O60l3OpRH4kzxQC55JysXR1Wij8XdvTx9ETKhdKQcVF6OzBVnm6j1olh+QAkcRi1QAOgNjnrySp0wHhAE9518TTZE5917uL/mahnzlstZJmh71zaUeQHU4qdW7mrxDgkVnOCBZp84hhqB6EJiOanPvb/w6vYihbiqRTMwcaHK2prAlBGFTzQBzTX8jBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLjR4EiC77t8gVbqSgaeiYefKfnmBsNLezXjJIuH3vE=;
 b=UTpBve9yAxZdaca5ZFZ2CCpTvvcu8K8nXMQ9U4E8zAplaNk5WO6cE7GEJby/HdcEurhHIe5lkM2znn+TRDIIuOepUROcuSB+6UBYJyfn9pgUhrlvP51t7KXfb3ZizxjbhgbjKshloyMJV9y0huJ+KnHDmcZTPcLBRbo+W/eib1sII8vVNqtETJlxkYm4jTTYSbn/tbfeD7izJxTt1Q8qmFU87SdPgbcrwvzC9njdcGwR/mp5r5JKd+94Hw9NZrVvx2LHyTbZ2Wqv1N2HWezevDW7MTYrlpwe75H8IflBEP6m6Rs+K2vx9Wn1uNCHNXF3osdN6ppxlJ2zTrsYpVRP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLjR4EiC77t8gVbqSgaeiYefKfnmBsNLezXjJIuH3vE=;
 b=c5L4Wa63zeZO41pVyvl08X8dWIVmbDlE8khUp4UQdU4SW62UMqUkSzxbjyP3JynKRJduZsK8IfG149rbqTJOdRZ8ZBWDrM2CbVWe9cxxvTa53b88gD8CDRccPMdW3kjCTp9Yaqun5U5dvpA64Zfg3jYH0eFtvmB5+7Hw6llhUR4=
Received: from CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 07:14:17 +0000
Received: from CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1]) by CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 07:14:17 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: fix the ww_mutex and GEM reference leaks
Thread-Topic: [PATCH 1/3] drm/amdgpu: fix the ww_mutex and GEM reference leaks
Thread-Index: AQHc6DOqIfSoEdVgRk2eC+bBiyGDnbYYEmRg
Date: Thu, 21 May 2026 07:14:16 +0000
Message-ID: <CH0PR12MB5106ADB98CE948C194AD895CFE0E2@CH0PR12MB5106.namprd12.prod.outlook.com>
References: <20260520083518.191863-1-shiwu.zhang@amd.com>
In-Reply-To: <20260520083518.191863-1-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-21T07:14:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5106:EE_|DS2PR12MB9798:EE_
x-ms-office365-filtering-correlation-id: 4928473a-b9bf-4641-7174-08deb70891f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: ZBRHn4C4b81T51hlnfhLpfaZMKhk08A4K0+wX9TAUyQTAm/ZUHMxCmrexmMJovachoqmowGs+W9IYLr8y5jG2yaYOvub4lXqESBnqRSoqguAHwz3/fRsMRodoCHjhb8A7pkQJEboyY2LY4C+ngGeaTmrPCiHDDB7KL5ksp35WEK1Xh/vNA6MqVZa2/ixV+81TRhp2fXou/sNP2kTS4jWyCfg82JEG+74W2bKUCgyk8h2Qr95nIV/Hs9BzivY39ghU9NNjl7+vK1OBS1xiPfjoBaFcY8VFlCxsSDeYzBh+zC8i2udYwlSdWDxWy0dJ02C88PghIR6n4q/pks9ENVSNw5afEouNqRwkgbEMAgRmfnwYOxvbehjq/frYwIs6rHh9J9vwDNb6bZwtmIl5AJF+LTOyRm6RHC88ljxbtXBvl5V2rK4lNd8z6OtDLNdjuuOXpur8D3q7OPLsHVtDBXM3HVMOSaJFlZCs0wgTE2TMAr+TPOUtEb9cRR2YxCBiEIDwbSzGjDkib2cKdyFFUMcRDn/Xwz6APlrrO+zpEcW28LpBVnDZLTrtiRHLhqwGj1kJcVYAPGiHP0aXZi1hkxxnAYMNaQkWrBkcNmFi8tudNMum9eOq+CVc+8TyEwpgpoKuoYgvft3GZO8/+9E7/mVQGBsKFkKbWQqrRAU7hdL8ZrbEFlP1J2ThEqXc1Yz6He3Rs1Uj1019rMlqEwiAyxHE26HEXXwFOTzF+K3k1Tajzd4pZFkYMA+P2QzfLm68M4D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5106.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F1ju0GL6sZ5SHjOgM6UZcmHXWo92nzhc/n9cI3/Heq2bQ3+sGnkjaVRg+vGu?=
 =?us-ascii?Q?FSSgwGVTvtnnYpmRVgTPXLj1g0yiphWGco7KFfeGWY11JLkt1mJefpcLUnvm?=
 =?us-ascii?Q?6rZl1pB6HicGYv6cIexb7ee0I3JlSX6moUT7M6cT8Q7+vpMha1dTCe+lYvZo?=
 =?us-ascii?Q?2Ej7Ohhl/jkIWbZWuazdsxNv4IPnLXKO6mGZvvkOZFTcPixnMjRVYbwn6zI4?=
 =?us-ascii?Q?q1Nc2DcA09ZpOy8bWoDXebJO5jdodRT9xxqiaDE/+Vvy8/nwk5osej2+DeOb?=
 =?us-ascii?Q?3eEYiX0id/4UWg/smohbp0V7mGJjhIC4z5VPY6udZCEz46L4omNfZxcVJ0xi?=
 =?us-ascii?Q?clPehUKlLjBlDamcXNwNO8zLdhFd+FvyvKhzUJ0IB34AzvwKLlLWNuPG7u4x?=
 =?us-ascii?Q?As3ltVE9yRMkYL05mnBBEDxizQso7GPGJslgIKYwfnQEaOdUhzfl8TMr8JSE?=
 =?us-ascii?Q?+jehfPKrtftVfcVlS8A9TmqI31BJplNO59WIGWJ9U0ZeFvhxQUfIy1AF5yRH?=
 =?us-ascii?Q?wOQWSzqlO5RewHsdepbHTYQBuU3tDH/FoFpChz6BN8Uj5xNGXA7Z0j6qzLGp?=
 =?us-ascii?Q?Q9jQbBBjKeSz5tMLN0xZzzkpyV7OrhQD9Z5ywbbPuMSSa1+pBfT4qlSVGIaw?=
 =?us-ascii?Q?LxD3+KABPHVg2mb9W2zI+8h/hkIm3jHniAIoGger/vHAtZj2x3EazR2hhaX2?=
 =?us-ascii?Q?ASqV29jg5y/ey0XmuDxbmjfAi9cYpgDimJaA8jN2A8DwAKC+09Aowh+q62ZH?=
 =?us-ascii?Q?Kg4fMmScVU8I0/zS48cRc3oTVZeuhPXDzRbsLlcLo2rq+vAj86g4Q7258rvZ?=
 =?us-ascii?Q?j77tKiigHC0fRKOVE5SXGm1AHIJXyNBoxsZ6g97qTWAIReK7MCrCNJAvBVR5?=
 =?us-ascii?Q?KPIUvFfyus8fJqNkaxuimbDolFw8k33HGtvdMBohaUUP3SJX1Waw3glUFftD?=
 =?us-ascii?Q?8K8KM8Vqu8rx7FBHx3qoKtlmBK8hcFgA0VnWklt8CXXdlUGvAdayaNCvtq5R?=
 =?us-ascii?Q?bxudpAsjTUMkerC4W5RrsCD6X7IEE2AwwHCMdkuqbYynp6M5+2i8olLmx9Gm?=
 =?us-ascii?Q?JF1qOkwpdSdQweFVvw05pSNDLRlJq+oa0PLS3y50QRh2KrKybpKwu5phK+vM?=
 =?us-ascii?Q?MO+RNCXnVE1/TnVK31HTtfYwyMtzeBUj3+ikMpX/LOEs+/JMtNA75UbI0ZwJ?=
 =?us-ascii?Q?Fbns6K1TYGB9fbvwMyf/pCAKLte6Y4uFDYIXAnPIaEW+xpNEX8/x7bQ5SWnb?=
 =?us-ascii?Q?zjOWeP/X7UcTHcVRBnwuRkb+lKKvt6Uz8tJtsY/PiV9fn1Uk04NwPOeYH/9G?=
 =?us-ascii?Q?P/swOsRphmzhK0fiUu/XMcH8MosI1DFf9UzS4fTy/UclF2ask6oCMWPDCXNP?=
 =?us-ascii?Q?IU1mCwYfNGaDtfjjf1Rrrd4aLVxAIRw6uUBNjFO8RAJnv5uZQGDjTHLeDqsw?=
 =?us-ascii?Q?4gVs7ZtGQ67fGIvx9shNDxa+pHOlfqC4GXV9SQjqHauqNunaX74RlVL5eUXL?=
 =?us-ascii?Q?X3tzSueD+4AqvxCxg2zC9PzUgJXfDvzko9IBqV3Lp8i0VuJdFW09V2X37paN?=
 =?us-ascii?Q?+Tff0Hk5eF8nRqwsHzExB1fD1v55oiNq3X+YRyYJMEcNeCLrF4ksWuke2wYw?=
 =?us-ascii?Q?pGSIaFnmTYFaZMbFc17tZ//w/OpVv8PuE/F82CU/up0gEqsAIzAJA8Un4Mtw?=
 =?us-ascii?Q?JumtSYZ9J55rxOOnFnncMGSpIpVqTwBKPFMV76qGW1i5JsDk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4928473a-b9bf-4641-7174-08deb70891f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 07:14:16.9220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eu0kjvBVqj/CwrlWBDovIKPJdKfBrlF4m+v7ZJOYo5hFhG47KXxYZfck+WSalLeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798
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

AMD General

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu Zh=
ang
Sent: Wednesday, May 20, 2026 4:35 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: fix the ww_mutex and GEM reference leaks

In case of kvcalloc failure, ww_mutex should be released and BO's GEM refer=
ence should be dropped as well.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c
index a93c64732bf4..b5fa4b0affc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1261,8 +1261,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void=
 *data,
                 * be retried.
                 */
                vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_entri=
es), GFP_KERNEL);
-               if (!vm_entries)
-                       return -ENOMEM;
+               if (!vm_entries) {
+                       r =3D -ENOMEM;
+                       goto out_exec;
+               }

                amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
                        if (num_mappings < args->num_entries) {
--
2.43.0

