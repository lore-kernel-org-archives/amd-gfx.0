Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E700E936E9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD6910E1B6;
	Wed,  4 Oct 2023 21:49:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF3210E1B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g84zT8IttrD5xt2yiAJbqVptx//6vqt86CVcWnXmSOVtcw0hj1F66KHuOdyErdRSw5a6d6TXF2ZylDpQpbC0CzwCgHJikQjz1b096CcGXqNpXUoPbNIXfiQJ5PbQLk6GTHneJ6NrFGKv9MnPyoZtW36iwMEnPPzbwK3PvvXljHg8Cn1b7X6kirZJ3cjJw3+XYsXuotN4Fb3cbgjUtnupqyV6dOQuWexBFEk4dThuINsz1EZlL1QUX5oynevElq+UyZRe83bg5zJ7pJvYfy7NhJmd2mc4uOMGZrnedMh4YGZyUq79ObLWPTgKxUWyOcp6WiJ9RT8umXMitxaLFUuaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMrtaD624X5ck3rQ6ODGRRbHXvuE3im2NMa0+3WkYdc=;
 b=ofLAVYQoncmqS1bnC4S+GgCvPpMYLvKJeug2/h/zKETZNyHdPkLM5/jAUwFLCH27HiV+2B9bDTODtLTVT1IxLzSU5XhrkMdEURxdTw8uso3R8xYKU27IPGZveumgMmeCqVpkZW5QRfyvIIarbNyFto8N7+WjtLycCM6ZU9J54BWyTe4YQlMeNa5HRDP46RKCNT7abB5BQ1UXKU9rgd3j3woDOdtZVaNuwR90+XrX2rHAJ6ybZVVF5g9kEyTQdfIgw4mbomspYT6yE6P57VpVJIOuF19pyXmh73KHSasJj7+YauVI/Wo0BUuGSHXRh4hfbhXH0uVLOoelUsC+eJFPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMrtaD624X5ck3rQ6ODGRRbHXvuE3im2NMa0+3WkYdc=;
 b=PAJbitW2tMbWh1rANAE+2DUMqJV3uhqw21uO0eUnKuCbIvUD2M614h/fdXa1+YFg4aYXwkhFYPlTpv8A5KULg1ZCt1Eog4ZUh6ebjMxUbjbsKM/Y399mgBpWCPunI5S9YupMJ0gOlwcfDfXw+TPLQoYI1H6c2+vY3yW1O7YBslU=
Received: from PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 21:49:01 +0000
Received: from PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::3930:4a0e:f826:7228]) by PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::3930:4a0e:f826:7228%3]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 21:49:01 +0000
From: "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 03/16] drm/amd/display: Move bw_fixed outside DML folder
Thread-Topic: [PATCH v3 03/16] drm/amd/display: Move bw_fixed outside DML
 folder
Thread-Index: AQHZ9wjFsCK6mWGPJUGmcPjDP2103LA6KqkA
Date: Wed, 4 Oct 2023 21:48:56 +0000
Message-ID: <PH7PR12MB58311A0EBF084A906F25F072FBCBA@PH7PR12MB5831.namprd12.prod.outlook.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
 <20231004212110.3753955-4-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231004212110.3753955-4-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=910feade-4c43-4ccb-b33c-6e737c359dc7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-04T21:47:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5831:EE_|SA1PR12MB7198:EE_
x-ms-office365-filtering-correlation-id: 17a47b44-eda7-42f8-84a2-08dbc523b5e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilRNifU/7Y3qNXQS60Mw3jCU3CSR8h6+dzSUpKNp4eGDTHE4nN6D8GrpkPyUGHTHGIQ8EsCZsJR0Yui5KFcW2u8oW6Xxv9uxx0OKUYDtMsT8PH63zk5kjjW7IlKooojVRj0D7saFsBKabp1VJAL1Cx7kI8PnVjbOqO4bVg/+SVx/JkMpV3jHRTHuZ2mhhoNwBRujKHibUDEIpa/u95YYRrsVm6m0peB1p4LrW7NIX1ZzhF4wLHVy7I0Xd/EmStKrZ0yLTdrzmTIrLqxmERtzUFpsJA6SmYmgEdan73JICiL51Q83LkJ/kYCcQts43aCktDfRPHO2os81pIXVaXCCgBorDnoRB0ISO4EAnZ+/W/NDVlKQ6Iaj8sIgP2huUheTspy7rWNa2n9YqexT+ixeSMjXLdkMqTx9QKEk4NpXbG5Wf93ll5x2qxBqYLg0oxZ54976kfeg0Z8EZDrnuz746larBH744HZ2jzZpPPmgANP/ZY7TPIS0u6w5oBgQxO74KKK0ojFKdeRQQFzZ60jmbMrLMz1FnCAiSuBY5bckACe4bLlxdaHeN4gDGCV/JQ/nrmaap+3eBxXFOBIwJpigjXPJKuHXOXe087xcaC/TGV2B+vPWJyq/otSQ23BIYLls
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5831.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(55016003)(122000001)(26005)(66946007)(54906003)(110136005)(66476007)(53546011)(66556008)(66446008)(316002)(76116006)(33656002)(64756008)(9686003)(8676002)(4326008)(7696005)(8936002)(478600001)(6506007)(38100700002)(6666004)(41300700001)(71200400001)(83380400001)(38070700005)(2906002)(86362001)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GsqV63PnyTsxhXBJpT7nmxGY7MdnrPGk+wJVuYYQ3wPHiOnc2meNAaDEfh9n?=
 =?us-ascii?Q?yoHOTQB8T53Z7Fk+N4HMPpdV0tcLPm4/q2qQ0ESYJGOdxueSailzKygbkOXe?=
 =?us-ascii?Q?dLZJGZGTFEkE0oE65AUk2fASj4rmoI2cSi1ifpUD53VgjmdnLCVl2IBEJLUk?=
 =?us-ascii?Q?qItA7bHhKegFjNjZBFhBUPSPlC5Ha83kV48f5goXeIFR51BqFuuYjx6YvyiG?=
 =?us-ascii?Q?GYhOQn76xYk6J/gUKGQbVnBoPMKdZUuEfa09LRmWzsMZ5Ee8WA/2G4mvPP2D?=
 =?us-ascii?Q?NGtKUBFdlgFJTm2KE0Fo/BFNNKTB1aKkVKqqWlyLdyIm9JM5BaMQrbFHlUPH?=
 =?us-ascii?Q?3VyRo+8QuLdp+03vXz1aAY8St+82WvE8pOKIBa7nM2HqzkrpfwDORrL/CPUs?=
 =?us-ascii?Q?ZPm8j06mVkhd6TMEHWVlqe6/5EAXzkDHyL0GZBXly4Kj3bAWudp1WA36p0m/?=
 =?us-ascii?Q?PChMY7mLyQmIGhza1+fEitHPPAzzOqLsmGaRd/pLbXadpTF8yaOCFetqxEct?=
 =?us-ascii?Q?xXj4L0pB7uXMySFch5QZ6s31Ut7hDbJHo8BPgbdRGB/ei5D32QwSmTW70B9r?=
 =?us-ascii?Q?FjtrWPi5icTbQL4/4/E+/vYOaUQIiTWqYvygGaJ2i8ZiMQqxCuzcWL7xxcAX?=
 =?us-ascii?Q?Lx+qETAQDvANdtJzQTyETU7qWA5Kkzbq9Y2XlzWyuZxfIbc1OFKCAvvVhKQL?=
 =?us-ascii?Q?aJcUTHatD5CDYG07TdA/a3hl11e99kvcQ9KoeCE0gITlQvEUeJk5DvXpube9?=
 =?us-ascii?Q?PxvoJPr+JMPb+6AQLvjAI45dusgNTFzVmR37TWeOgW91Ak6ltC/VjBJze4Z+?=
 =?us-ascii?Q?9mIxg5r8aOJI8dyYbLUj9ytBv7hNdmz8VU3KtXvthWMvqTfxOSjGtEDyBT0X?=
 =?us-ascii?Q?oDDOSUzLpogrIKlsgxYQ25NtQKb2iSvBYAQ842Um7LZRNB3gr3p0kgYSjYRg?=
 =?us-ascii?Q?ZkZr/B2U0UV522eCKQk910npzRVHxLZdBeppRyI+PhmstOqW3oc1UbweXFc+?=
 =?us-ascii?Q?Ji7J1VnfbAptJ5iTgqi27UQOpRY8+krpuzzgQU8wKhElzEQNxFF18ee+Huwy?=
 =?us-ascii?Q?YW6arKPTHZcWd/eete/71P8pzq7hxkYPUlBLAVCYeCdPniFo2q+kgKYBNScP?=
 =?us-ascii?Q?0Td4ja8JsSm7uDYRgn/uP6WvwCl8atBFSmtDhKzMZsJY+nTAlwEZlsoTsWEw?=
 =?us-ascii?Q?KD4LWeTDL93Y5dE8jvdmCUtUSGUH1CL22kFz+tv0JZdcECBl6PkPZOK0FfQf?=
 =?us-ascii?Q?bT9C3UpWIDx8xZnmGlWEO4Rd9AuelUMiJlPm9OaYH1l8v6iXSWYjS9/Us8tk?=
 =?us-ascii?Q?ygXgidfYrXJEELRfMtqUkMp9ULhQnGr+eiu9asaEVNsbmKPMtKkUGXPhvEBa?=
 =?us-ascii?Q?O2GAPIPejEKiauMH+QTQpKpIfeN8VveWXmBNiXxu0ahabEAgbkVEv45sLKHp?=
 =?us-ascii?Q?LV8hT4TDIf44V7Depkj5k2l4dr/aTuHeCIwKAfgSs7v9KLFgiVZyQldeu027?=
 =?us-ascii?Q?wyH40mUBEUFYT2HufhxXWBnfnLiLWQu0TsjBsYTF/XLB88cmrSiGWVWakI3x?=
 =?us-ascii?Q?oJ9061e+uCOV0CSdGzs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5831.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a47b44-eda7-42f8-84a2-08dbc523b5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 21:48:56.9504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPILbSw1YgXpiM3YPInFsufrTPnEqRLXP/uvxecDIWoNyXsXx8oRSlCbEfBIvQiB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Gong,
 Richard" <Richard.Gong@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Wednesday, October 4, 2023 5:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.=
Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Lillian <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin,=
 Wayne <Wayne.Lin@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mahfooz, Hamza =
<Hamza.Mahfooz@amd.com>; Gong, Richard <Richard.Gong@amd.com>
Subject: [PATCH v3 03/16] drm/amd/display: Move bw_fixed outside DML folder

bw_fixed does not need any FPU operation, and it is used on DCE and DCN.
For this reason, this commit moves bw_fixed to the basic folder outside DML=
.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/Makefile      |  3 ++-
 .../amd/display/dc/{dml/calcs =3D> basics}/bw_fixed.c | 13 ++++++-------
 drivers/gpu/drm/amd/display/dc/dml/Makefile         |  2 --
 3 files changed, 8 insertions(+), 10 deletions(-)  rename drivers/gpu/drm/=
amd/display/dc/{dml/calcs =3D> basics}/bw_fixed.c (94%)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/Makefile b/drivers/gpu/d=
rm/amd/display/dc/basics/Makefile
index 65d713aff407..aabcebf69049 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/basics/Makefile
@@ -30,7 +30,8 @@ BASICS :=3D \
        vector.o \
        dc_common.o \
        dce_calcs.o \
-       custom_float.o
+       custom_float.o \
+       bw_fixed.o

 AMD_DAL_BASICS =3D $(addprefix $(AMDDALPATH)/dc/basics/,$(BASICS))

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c b/drivers/=
gpu/drm/amd/display/dc/basics/bw_fixed.c
similarity index 94%
rename from drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
rename to drivers/gpu/drm/amd/display/dc/basics/bw_fixed.c
index 3aa8dd0acd5e..c8cb89e0d4d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/bw_fixed.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2015 Advanced Micro Devices, Inc.
+ * Copyright 2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software=
"), @@ -106,9 +107,8 @@ struct bw_fixed bw_frc_to_fixed(int64_t numerator, =
int64_t denominator)
        return res;
 }

-struct bw_fixed bw_floor2(
-       const struct bw_fixed arg,
-       const struct bw_fixed significance)
+struct bw_fixed bw_floor2(const struct bw_fixed arg,
+                         const struct bw_fixed significance)
 {
        struct bw_fixed result;
        int64_t multiplicand;
@@ -119,9 +119,8 @@ struct bw_fixed bw_floor2(
        return result;
 }

-struct bw_fixed bw_ceil2(
-       const struct bw_fixed arg,
-       const struct bw_fixed significance)
+struct bw_fixed bw_ceil2(const struct bw_fixed arg,
+                        const struct bw_fixed significance)
 {
        struct bw_fixed result;
        int64_t multiplicand;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/=
amd/display/dc/dml/Makefile
index 2fe8588a070a..ea7d60f9a9b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -134,8 +134,6 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=
=3D $(dml_rcflags)  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.=
o :=3D $(dml_rcflags)  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_ma=
th.o :=3D $(dml_rcflags)

-DML =3D calcs/bw_fixed.o
-
 ifdef CONFIG_DRM_AMD_DC_FP
 DML +=3D display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_c=
alc.o  DML +=3D dcn10/dcn10_fpu.o
--
2.40.1

