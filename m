Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B975C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 01:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24ADA229C4
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 01:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ADA229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D0706E55C;
	Mon,  7 Dec 2020 01:43:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4F36E55C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 01:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cW1VnpcvtO3W1pyjOTAMg3111wxiFIG4iULxgs6tgBx34uUTarnzEqp9dx6VBEDQx3lzoiG3oos/BOudp1XI1727YadGBNcX+S2VeqhNu+jZAXBzVErfrc1H4YUxJ7Il5jl736aG2o1oCX8g6KqRsdZEIIpdqQUMZcV/dTejZlB6PrI3IOcd/JA0wzvQf7zcy0ze5S01e9Uaau17HwFFPl0C7w2bounjFjkOERzTXA+ZZ+3Bq4+Xci9X6tamcV1GMEAt4ox19Miy+OsM0ZCrJCbgaLBBGahwozEVvgvdNzDH1zi4dgiME3jEbJ6svEQUjzo30KKRdo6xQHjsL8ueHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqZ8vT++dZX19tAfPsFrFfDjMKNFJKjMrlKIAR7CjAI=;
 b=hjwi/1UNj4PY72g8ckERMNBVlGuAqZGMyTAdtj8dSJisitHcB/z76qwjSZgaovXIWhdwPfyGvGT6i1wyOivGWLMWq2d1HF5zUFdwh93NlhVNa3yqfY9Ami8Y8+3wmtailCu5FG0KWmG43LONtYX4rrbiyoQh+uZRlJTv7pP2Dd+KdMgo2nI2cgncOyx1x9WJTavwLR+4dp9W2LAWybwiFB+LD4WA3ZPJVUFxEVsxh+cL8ejPRh0zWfwEX7rcfeLOEW+oY6HCpwjJAxBCwFA25tyD1BYcm849wYXe3Nf/UUnHHCeBuIUcGBuhE8dN57o80gIqOvRm2DDJDtlRntWKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqZ8vT++dZX19tAfPsFrFfDjMKNFJKjMrlKIAR7CjAI=;
 b=kC+1+aWc/7dE6c2hoRCk0B7Lr9IM/FENaF6+DO1F4XC38/OSLoyEPRvjpD0960SBaKL/0TOm//nm4g5z2t8bNO9r7Pt1UvD5HTIA4lBi5srFUl/0Anu48V65BxH2aVqr8j/JDjcXRmU51wX5U+sj7JVANV07LhV93Zaf/kM7qsk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Mon, 7 Dec 2020 01:43:21 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 01:43:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] ALSA: hda/hdmi - enable runtime pm for CI AMD display
 audio
Thread-Topic: [PATCH 3/3] ALSA: hda/hdmi - enable runtime pm for CI AMD
 display audio
Thread-Index: AQHWyn5R7qaukLZhl0a36FUbsY2t+anq33aw
Date: Mon, 7 Dec 2020 01:43:21 +0000
Message-ID: <DM6PR12MB2619C1ABAFDE863C44A375E4E4CE0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201204204437.3845-1-alexander.deucher@amd.com>
 <20201204204437.3845-3-alexander.deucher@amd.com>
In-Reply-To: <20201204204437.3845-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cb9d35e5-c5a6-4d3d-80bf-4a9224f9c005;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-07T01:42:31Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88495338-c158-4613-8f1c-08d89a517ab3
x-ms-traffictypediagnostic: DM6PR12MB4387:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43872461DDD05D0914D252C6E4CE0@DM6PR12MB4387.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nThEqA8KgMXul3YxqwRcXYKW8ZSBe7fwlCJopi3Itposv82lAH9nfnkP0P9XcmcfBSHgo8jdKU1rUaeDacMy+lvUtyqsp/NWvbRdIDJZqEfuiGZ0vUwNrObq+/+sR8SfjE4XUNVKX+WPJ1a92p8C1Ltu9rvwsW5ppx5EAAnp72mQrkLqBuMBIf+3qIUbySym/h7P7tSDkG+j90Hvcd6FSdaE8ObrGOA78Qim6h/7Klm9Rni152onY0VRRSZ0fL+9tHDF0FBcljgo1yRQ7B7/N1eY55LnfWlm3UI/6vTWFX38TETJHXWGLzKORmVqeIt2hQHLx6y9FFcO22OLntRxwur3s+AcFGXRI/UxsKGFmcs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(66446008)(26005)(66476007)(966005)(66946007)(45080400002)(76116006)(478600001)(110136005)(64756008)(186003)(6506007)(8676002)(66556008)(316002)(86362001)(4326008)(2906002)(53546011)(7696005)(71200400001)(83380400001)(52536014)(9686003)(8936002)(5660300002)(55016002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aYxFSbm4MznO2b93D6TUBVwYH1jU3JxUjm3QMc3pcLgVwvnzNnWzEIAEYuh1?=
 =?us-ascii?Q?Qtg5Ov+Eb5r8i9DH/EkkGI00G2BxdTcJ7udW2GKGPgKwiXU2b8lEwyYla6jq?=
 =?us-ascii?Q?aytz6laVse5bcACObz6plbi4oagwrgOjkFSjrhOzBXaSy1zgxplqHQmr9+kU?=
 =?us-ascii?Q?XuvHbqb1vKpnNoRqCjfgt/O9x3daYKkkWhisELOo0ftdCEdh0MTqCLiXSmHh?=
 =?us-ascii?Q?KhiLMHUX0T4TS/7fn5uIsbjNacCeSDwlwjIrQI2yXJCBTwUMFFhG2jiv1o6z?=
 =?us-ascii?Q?p1yfh7S3D7yOfC2OwbPr1k5uMfqg//bIhBzohCNZZRfscyXFX+7t9xBkIVTP?=
 =?us-ascii?Q?00XHrk03PMdMMt1hcJoTyciCCkgY0ob3sjxyxoM+K8fMvne/g0d9p6Hl5XVY?=
 =?us-ascii?Q?xSLO/S424doO6VKN+3VXzHglRz3PIahEoTt3Qo5f1pUMStHoFnpgFPy0npm3?=
 =?us-ascii?Q?lwydgM/o0D0uGGHfWrOfo+x3NxnA06u8uw451QJg7YBakbZ+u18CsmM/UIGx?=
 =?us-ascii?Q?PUhTpe8MafNnwuw/Hr1f63nNZc4cY+6D2gnc+TX8jzrv/anlaVUqscKcqUkg?=
 =?us-ascii?Q?8zFv6qgWtCjkyoMZXJJ8c6wjw0pl7YkwAsO/LgD/KTQq3M+g5ef8DRlTLnan?=
 =?us-ascii?Q?reN7D84LigA9RVIuO5ime9MhW0k/T4wEyFju/OOeKIRPWyrAabyTvNs63qLu?=
 =?us-ascii?Q?eCUQqjK/PCFZ8S1+41u6QfL/n5XM/KbZ3SlB6bwfmxzDF8NB5HqJAcfsQ9W4?=
 =?us-ascii?Q?8wH6GFMcNCMcK31dHCTYlpdgJOXNeBsZDUS9iuStDSN9QqdaTyA3Mh0VIbUk?=
 =?us-ascii?Q?VIgdFrQnJkETIkHe2XU47PXQKGDOH7ut3TMV/cUvEKwDpHHkqkXxjf0oXY45?=
 =?us-ascii?Q?k0DLb0OphJeIXPAkjQkOct22t+T+Q+qzKI25OOtO2BAqaDGrgUUYuW6a0LjC?=
 =?us-ascii?Q?xbD1x2geit44c2+xqPtLprm8qSPJydreBTL79AD+ZDQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88495338-c158-4613-8f1c-08d89a517ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 01:43:21.3272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuLx85NbxYAYmN27A99AHCornjIj2glx7OZUIVFnoIauLSjoTxntoRO/r2RIw4L4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Saturday, December 5, 2020 4:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] ALSA: hda/hdmi - enable runtime pm for CI AMD display audio

We are able to power down the GPU and audio via the GPU driver
so flag these asics as supporting runtime pm.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/pci/hda/hda_intel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d539f52009a1..2ea46b5a9a23 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2597,7 +2597,8 @@ static const struct pci_device_id azx_ids[] = {
   .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_AMD_SB },
 /* ATI HDMI */
 { PCI_DEVICE(0x1002, 0x0002),
-  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+  AZX_DCAPS_PM_RUNTIME },
 { PCI_DEVICE(0x1002, 0x1308),
   .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 { PCI_DEVICE(0x1002, 0x157a),
@@ -2659,9 +2660,11 @@ static const struct pci_device_id azx_ids[] = {
 { PCI_DEVICE(0x1002, 0xaab0),
   .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 { PCI_DEVICE(0x1002, 0xaac0),
-  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+  AZX_DCAPS_PM_RUNTIME },
 { PCI_DEVICE(0x1002, 0xaac8),
-  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+  AZX_DCAPS_PM_RUNTIME },
 { PCI_DEVICE(0x1002, 0xaad8),
   .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
   AZX_DCAPS_PM_RUNTIME },
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cb8344151863f449f2b2d08d8989572f0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637427114931734308%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gFXLAd6VDdNuRP3Eu7YAoeeOusA99156kyUUl9MKATs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
