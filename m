Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D8EC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 03:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0E861405
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 03:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0E861405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5536E190;
	Fri, 14 May 2021 03:03:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D80F6E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 03:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMRFjl0EZg7K3/Ra2CYcHm0SMUcQkzQcw8npUS2/Ci5E6bShH/GhiNLkO1aWkIM4XiSSsVwHJFq28wo7FcW/1nardREJfEhzCTWUxfQe+yC73M4oIv83noM1cg6buUUtdUOU0IdbH2xRUeZqTSVD7M35JHn9xLtiCWvymANGLqikvdh5gGrQ/GLIes/jJURrijQk6vZOMFaRrx353IAsprT4E6GTPRlNSqwzXB5FSArw/A8mqZ/lOYAoWx5JRbqPMn3nGZ1YDCMGzEIsT4ll1/cUI9mitK0pXqEFCGOtObv+ubXHlFmJgjL9K8YdqIIm70W1F62RqnOOvBwlNqGVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDTQ+7j/nwgHPSWLFIi0/h6eUWwvjxInivc7uCKStjM=;
 b=kJJeHXlGoUSPaCvsju/+/Q19Au+N+QXoPwBtHc4SEw+A5WaXi52nm7UZoYnPdqAlfB65iJUeuSugrAxf+m5iVjWTflFFEqyJUurc2XTyiPZ9dvflEGqfhIEVGSqCfbimAkbONl9RaG2Vr3K2hRTWwb0JIUcyfbIIUpah/ZjbKZRqk/oAzjPwgGC+k3nFtCcXGlCmMUIqvgq5mldTChdIgTEgvoqKRqcYk3rWHLp09kBepH5xjoMlIylUdf+9M27UYulu+6IA+vvVXFyqf+SPpOt31+fLmyAo+08/plhx5XwcUnhrgxnioBm9Oa5rMMhh3d2O45+riZ/G+VpWLYVewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDTQ+7j/nwgHPSWLFIi0/h6eUWwvjxInivc7uCKStjM=;
 b=07Kuhzm+DB1NSLZ6joCPiJZ2BGxCzCLSQqiV9GY3bD8uIC3g5wk41ZCs92ZpeskYgf0u5lo5fRfmFCcw89h8oLgQeCYUdAfqgvpa0S/+Op1RWNm7IUklL2gEHmROKpzi0X2jqrE8u3L/gpO3Lmb5/gJgSW9yW5qUShe4dUDA2MY=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 03:03:11 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4129.025; Fri, 14 May 2021
 03:03:11 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "StDenis, Tom"
 <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] add vbios info query
Thread-Topic: [PATCH] add vbios info query
Thread-Index: AQHXRt/Q/qbEodQFLk2ISqnzzZ1QZariTLLA
Date: Fri, 14 May 2021 03:03:11 +0000
Message-ID: <CH0PR12MB51569D72B2C29929B5BBB127F8509@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210512033451.19253-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210512033451.19253-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-14T03:03:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=16056cad-b46c-4262-9961-29b46171c22c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891a065f-1842-42b6-cb35-08d91684cf29
x-ms-traffictypediagnostic: CH0PR12MB5188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB518882E867C7FCACE32A9DEFF8509@CH0PR12MB5188.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1bTT6/ZURK2LmkVPqPtsaUJlNRtzh3XnwPZSVFHoBw2Q5B/wUTbBD5NqmQfafpffOe1P+RefimmdKYZqrs/QzaO1i+MyzoRP+CQSS8/k8i8iCH9w3U3b5bqIKXC2jXf5B4OwwexmZd+IGcSmaR5wMOzx1q3Pe3MfKZSuAboJ1/1Kr2YC1FMEZ4tOVAbSsjmTW8of4Ex3LM6X9SMBZO3gPjuHvUk1iNwTQDwrsXpiflhJAbDZTOnqocQC4rrRtPrupVf4AI9cnkgR2Hvx3+9dHmAmcKcTwj9wHX1uKOH612k0O2ycaRl3sPpTq0YNY9F6PpFeAajsGC1zY44//13D6AZBATjGUQPLfq4ipgRgS/Arn6IkNl/EN0LjhLqDpsDhs1zKRMV2+TzgzmeTL90cal5AINCeuex1EQev1Tnrj4aFn8b89t2n/F/pHDLhASjrClv65dVnkBWgqO6ScJ1qV22CfvFIwoSLSqiu5awHm/AtSuYERpUctcHz/iMay8tR+JkNHnkZe0shJewBcfkAkwvAomCkBUPkQMqdCjfB8iE1oGgT08V0qufg8kQ42oYPobjm34oJxLBdA73hBF5d/fAw+RkRh/vO8MJK6+Tj8c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(33656002)(86362001)(8936002)(84040400003)(122000001)(38100700002)(83380400001)(76116006)(66446008)(66556008)(71200400001)(66476007)(66946007)(66616009)(64756008)(4326008)(2906002)(110136005)(55016002)(316002)(8676002)(9686003)(478600001)(99936003)(52536014)(26005)(53546011)(6506007)(186003)(7696005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KEe1oKEmShgSrZlCZqxWYPrRGf5m3hE0XDFF3+mRhxpVImoaYkqFHEa4lkdL?=
 =?us-ascii?Q?aNimCgWvntKt6Bxg4hPYIQNOnVzMY9H3SGxxVvdJFtg6Zo0RxlbmPBETR5f5?=
 =?us-ascii?Q?+L64TZ9soAyXA4Hj+zz3TQBlHlhxUnHMpRiQqZ7mOsN/locRzsmvWsUZliup?=
 =?us-ascii?Q?fw+AMIeRFC0ds/xMUriLc6Z5XNqXW90RQjsU9h+RcDwwFuKE4WpLtrcQgc2f?=
 =?us-ascii?Q?ViK65zPuXgFDpHaoAvk7as1f5udxOTOKVXJmYHWXIZBMnbBIUoJtqosIIdtq?=
 =?us-ascii?Q?W9+x0nXBozdZW1RZpPELqC7i8IH2KAQ129qFB5OQMAq8ybh9Ljy1nDRmq/Ec?=
 =?us-ascii?Q?FPLC0Ptvqw2+JN7Dl1MZr8s/IajiBxHnfxp6gtis5y1zpTyVvDVimm5m3aRz?=
 =?us-ascii?Q?IiRdoBqxAWv40S4hEFCgOxdSV51gcUcOYjFxwn1FWxs9p9kE8/1RafDqpQ+7?=
 =?us-ascii?Q?E9ONMCUTeCuwR37mbvJiOMAvmF2sIqIbVUFuNljo+wpAQp9MTcplKlNd+g6h?=
 =?us-ascii?Q?4AYaVvXu+wznvHOQwLZguKyHdw+REZJGxzoVFn9SXTWsC9Van2pH33rdpFMK?=
 =?us-ascii?Q?5XAc7JkE1GhfqxBhIafInczbkGaowCqJUdL1cvjaDeay0Em0E8XPObIorcyl?=
 =?us-ascii?Q?9YnwxK8kCQZwrKaV8XzbpTykhlW6fZ8J6KN1swF/cOBOUHDxeQ4QbmiyiWd7?=
 =?us-ascii?Q?331XyJPkaaBsMSLSG4andXRI9XTeZzLnRSNt7S7BNEDb6IVC0hbpFVFDpith?=
 =?us-ascii?Q?DNdHFZ43fvEze3VhPyY1hMqRvRv/FRAKpH2+MGzaNFNsC4jOM2lJvWSixmlK?=
 =?us-ascii?Q?eYuJNQTaOeedWwwfdL5tjUk0CBd8VXxkn6i8cR6D4+xjZyYAmV9gidxBj5dt?=
 =?us-ascii?Q?Pa1OHo8oV5M/HyqKXmgLRY0QHxgL47mOWNO6Vx9jnigFYDWwB1Ukcch2yEvX?=
 =?us-ascii?Q?wgLppSeRVsK8ZR4uE9sV2gMY9lk5LGs+7djsJ/uSLD2ScVM4bW53xrq35gPE?=
 =?us-ascii?Q?QrOlnyZwlb9ywh6Wdi0jlFgVLw/J0/anODgfezHs8Am6lZ7FoLSCSRBdguaI?=
 =?us-ascii?Q?3psqIBXbr0gJS78mO3VEIut5+i/wnrTpPSMNTEnk15PIEpPH3I1Ym+FcuZEB?=
 =?us-ascii?Q?ZJUQ+2zK/HUHaTq3hl72yQooKmQnB97audV6EAKbdc0GUX6tW5i7rh82dOC8?=
 =?us-ascii?Q?UhGzgoCtS214iV6CkNQZvVlvBwVnLOaTGMrpCYUG7JRf50USeMdt3LWVVOju?=
 =?us-ascii?Q?+ZSmRK1V99medcGzW8K/shtp1HZWLBhC4UjvhX3BsPeQOvGEZZDVtRrQvpC7?=
 =?us-ascii?Q?h2Ovu+n/melEQF4GUWiIv6+p?=
Content-Type: multipart/mixed;
 boundary="_002_CH0PR12MB51569D72B2C29929B5BBB127F8509CH0PR12MB5156namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891a065f-1842-42b6-cb35-08d91684cf29
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 03:03:11.5119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xb3jABf5CrC+j+GgscEA3UJ3JBj7iGvHNQyyJZGgKO8HQMpVPp2i2OngKVgOClYkAI3oWVPNwLWgaJjHM8Af7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_CH0PR12MB51569D72B2C29929B5BBB127F8509CH0PR12MB5156namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Tom,

Can you help review & merge this patch to bring vbios IOCTL usage in UMR ba=
ck?
The patch is also attached.

Thanks in advance,
Jiawei

-----Original Message-----
From: Jiawei Gu <Jiawei.Gu@amd.com>=20
Sent: Wednesday, May 12, 2021 11:35 AM
To: StDenis, Tom <Tom.StDenis@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gu, JiaWei (Will) <JiaW=
ei.Gu@amd.com>
Subject: [PATCH] add vbios info query

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 src/app/CMakeLists.txt             |  1 +
 src/app/main.c                     |  8 +++++
 src/app/vbios.c                    | 58 ++++++++++++++++++++++++++++++
 src/lib/lowlevel/linux/query_drm.c | 11 ++++++
 src/umr.h                          | 15 ++++++++
 src/umrapp.h                       |  1 +
 6 files changed, 94 insertions(+)
 create mode 100644 src/app/vbios.c

diff --git a/src/app/CMakeLists.txt b/src/app/CMakeLists.txt index ca7d46b.=
.462e4fc 100644
--- a/src/app/CMakeLists.txt
+++ b/src/app/CMakeLists.txt
@@ -35,6 +35,7 @@ add_library(umrapp STATIC
   pp_table.c
   navi10_ppt.c
   read_metrics.c
+  vbios.c
   ${GUI_SOURCE}
 )
=20
diff --git a/src/app/main.c b/src/app/main.c index 47ddb38..b484cf3 100644
--- a/src/app/main.c
+++ b/src/app/main.c
@@ -825,6 +825,11 @@ int main(int argc, char **argv)
 				asic =3D get_asic();
 			ih_self_test(asic);
 #endif
+		} else if (!strcmp(argv[i], "--vbios_info") || !strcmp(argv[i], "-vi")) =
{
+			if (!asic)
+				asic =3D get_asic();
+			if (umr_print_vbios_info(asic) !=3D 0)
+				fprintf(stderr, "[ERROR]: Cannot print vbios info.\n");
 		} else if (!strcmp(argv[i], "--help") || !strcmp(argv[i], "-h")) {
 			printf("User Mode Register debugger v%s for AMDGPU devices (build: %s [=
%s]), Copyright (c) 2021, AMD Inc.\n"
 "\n*** Device Selection ***\n"
@@ -951,6 +956,9 @@ printf(
 	"\n\t\tPrint the GPU metrics table for the device."
 "\n\t--power, -p \n\t\tRead the conetent of clocks, temperature, gpu loadi=
ng at runtime"
 	"\n\t\toptions 'use_colour' to colourize output \n");
+printf(
+"\n*** Video BIOS Information ***\n"
+"\n\t--vbios_info, -vi \n\t\tPrint Video BIOS information\n");
=20
 #if UMR_GUI
 printf(
diff --git a/src/app/vbios.c b/src/app/vbios.c new file mode 100644 index 0=
000000..98e0f87
--- /dev/null
+++ b/src/app/vbios.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person=20
+obtaining a
+ * copy of this software and associated documentation files (the=20
+"Software"),
+ * to deal in the Software without restriction, including without=20
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,=20
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom=20
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be=20
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,=20
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF=20
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT=20
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,=20
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR=20
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=20
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Tom St Denis <tom.stdenis@amd.com>
+ *
+ */
+#include "umrapp.h"
+
+#define AMDGPU_INFO_VBIOS			0x1B
+#define AMDGPU_INFO_VBIOS_INFO			0x3
+int umr_print_vbios_info(struct umr_asic *asic) {
+	char fname[64];
+	int r;
+	struct umr_vbios_info vbios_info;
+
+	if (asic->fd.drm < 0) {
+		snprintf(fname, sizeof(fname)-1, "/dev/dri/card%d", asic->instance);
+		asic->fd.drm =3D open(fname, O_RDWR);
+	}
+
+	r =3D umr_query_drm_vbios(asic, AMDGPU_INFO_VBIOS, AMDGPU_INFO_VBIOS_INFO=
,
+			&vbios_info, sizeof(vbios_info));
+	if (r)
+		return r;
+
+	printf("vbios name          : %s\n", vbios_info.name);
+	printf("vbios dbdf          : 0x%x\n", vbios_info.dbdf);
+	printf("vbios pn            : %s\n", vbios_info.vbios_pn);
+	printf("vbios version       : %d\n", vbios_info.version);
+	printf("vbios date          : %s\n", vbios_info.date);
+	printf("vbios serial        : %lld\n", vbios_info.serial);
+	printf("vbios dev_id        : 0x%x\n", vbios_info.dev_id);
+	printf("vbios rev_id        : 0x%x\n", vbios_info.rev_id);
+	printf("vbios sub_dev_id    : 0x%x\n", vbios_info.sub_dev_id);
+	printf("vbios sub_ved_id    : 0x%x\n", vbios_info.sub_ved_id);
+
+	close(asic->fd.drm);
+	return 0;
+}
\ No newline at end of file
diff --git a/src/lib/lowlevel/linux/query_drm.c b/src/lib/lowlevel/linux/qu=
ery_drm.c
index d0c82d4..f4ab709 100644
--- a/src/lib/lowlevel/linux/query_drm.c
+++ b/src/lib/lowlevel/linux/query_drm.c
@@ -49,7 +49,18 @@ int umr_query_drm(struct umr_asic *asic, int field, void=
 *ret, int size)
 	inf.return_size =3D size;
 	inf.query =3D field;
 	return ioctl(asic->fd.drm, DRM_IOC(DRM_IOC_WRITE, DRM_IOCTL_BASE, DRM_COM=
MAND_BASE + DRM_AMDGPU_INFO, sizeof(inf)), &inf);
+}
=20
+int umr_query_drm_vbios(struct umr_asic *asic, int field, int type,=20
+void *ret, int size) {
+	struct drm_amdgpu_info inf;
+
+	memset(&inf, 0, sizeof inf);
+	inf.return_pointer =3D (uintptr_t)ret;
+	inf.return_size =3D size;
+	inf.query =3D field;
+	inf.vbios_info.type =3D type;
+	return ioctl(asic->fd.drm, DRM_IOC(DRM_IOC_WRITE, DRM_IOCTL_BASE,=20
+DRM_COMMAND_BASE + DRM_AMDGPU_INFO, sizeof(inf)), &inf);
 }
=20
 #else
diff --git a/src/umr.h b/src/umr.h
index 4e730e5..41266e2 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -973,6 +973,7 @@ void umr_free_asic(struct umr_asic *asic);  void umr_fr=
ee_maps(struct umr_asic *asic);  void umr_close_asic(struct umr_asic *asic)=
; // call this to close a fully open asic  int umr_query_drm(struct umr_asi=
c *asic, int field, void *ret, int size);
+int umr_query_drm_vbios(struct umr_asic *asic, int field, int type,=20
+void *ret, int size);
 void umr_enumerate_devices(void);
 int umr_update(struct umr_asic *asic, char *script);  int umr_update_strin=
g(struct umr_asic *asic, char *sdata); @@ -1349,6 +1350,20 @@ struct umr_so=
c15_database {
 	struct umr_soc15_database *next;
 };
=20
+// vbios
+struct umr_vbios_info {
+	uint8_t name[64];
+	uint32_t dbdf;
+	uint8_t vbios_pn[64];
+	uint32_t version;
+	uint8_t date[32];
+	uint64_t serial;
+	uint32_t dev_id;
+	uint32_t rev_id;
+	uint32_t sub_dev_id;
+	uint32_t sub_ved_id;
+};
+
 FILE *umr_database_open(char *path, char *filename);  struct umr_soc15_dat=
abase *umr_database_read_soc15(char *path, char *filename);  void umr_datab=
ase_free_soc15(struct umr_soc15_database *soc15); diff --git a/src/umrapp.h=
 b/src/umrapp.h index 14457fe..1336e07 100644
--- a/src/umrapp.h
+++ b/src/umrapp.h
@@ -57,5 +57,6 @@ void umr_clock_scan(struct umr_asic *asic, const char* cl=
ock_name);  void umr_clock_manual(struct umr_asic *asic, const char* clock_=
name, void* value);  int umr_print_pp_table(struct umr_asic *asic, const ch=
ar* param);  int umr_print_gpu_metrics(struct umr_asic *asic);
+int umr_print_vbios_info(struct umr_asic *asic);
=20
 void run_server_loop(const char *url, struct umr_asic * asic);
--
2.17.1

--_002_CH0PR12MB51569D72B2C29929B5BBB127F8509CH0PR12MB5156namp_
Content-Type: application/octet-stream; name="0001-add-vbios-info-query.patch"
Content-Description: 0001-add-vbios-info-query.patch
Content-Disposition: attachment; filename="0001-add-vbios-info-query.patch";
	size=6967; creation-date="Fri, 14 May 2021 02:59:52 GMT";
	modification-date="Fri, 14 May 2021 02:59:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MzY2OThkNDU3YWJmNjAyMDE5ZWUwYWQ2MGU4NjgxZTY3MjNmN2Y1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKaWF3ZWkgR3UgPEppYXdlaS5HdUBhbWQuY29tPgpEYXRlOiBX
ZWQsIDEyIE1heSAyMDIxIDExOjMwOjU2ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYWRkIHZiaW9z
IGluZm8gcXVlcnkKClNpZ25lZC1vZmYtYnk6IEppYXdlaSBHdSA8Smlhd2VpLkd1QGFtZC5jb20+
Ci0tLQogc3JjL2FwcC9DTWFrZUxpc3RzLnR4dCAgICAgICAgICAgICB8ICAxICsKIHNyYy9hcHAv
bWFpbi5jICAgICAgICAgICAgICAgICAgICAgfCAgOCArKysrKwogc3JjL2FwcC92Ymlvcy5jICAg
ICAgICAgICAgICAgICAgICB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogc3Jj
L2xpYi9sb3dsZXZlbC9saW51eC9xdWVyeV9kcm0uYyB8IDExICsrKysrKwogc3JjL3Vtci5oICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKysrKysrCiBzcmMvdW1yYXBwLmggICAgICAg
ICAgICAgICAgICAgICAgIHwgIDEgKwogNiBmaWxlcyBjaGFuZ2VkLCA5NCBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgc3JjL2FwcC92Ymlvcy5jCgpkaWZmIC0tZ2l0IGEvc3JjL2Fw
cC9DTWFrZUxpc3RzLnR4dCBiL3NyYy9hcHAvQ01ha2VMaXN0cy50eHQKaW5kZXggY2E3ZDQ2Yi4u
NDYyZTRmYyAxMDA2NDQKLS0tIGEvc3JjL2FwcC9DTWFrZUxpc3RzLnR4dAorKysgYi9zcmMvYXBw
L0NNYWtlTGlzdHMudHh0CkBAIC0zNSw2ICszNSw3IEBAIGFkZF9saWJyYXJ5KHVtcmFwcCBTVEFU
SUMKICAgcHBfdGFibGUuYwogICBuYXZpMTBfcHB0LmMKICAgcmVhZF9tZXRyaWNzLmMKKyAgdmJp
b3MuYwogICAke0dVSV9TT1VSQ0V9CiApCiAKZGlmZiAtLWdpdCBhL3NyYy9hcHAvbWFpbi5jIGIv
c3JjL2FwcC9tYWluLmMKaW5kZXggNDdkZGIzOC4uYjQ4NGNmMyAxMDA2NDQKLS0tIGEvc3JjL2Fw
cC9tYWluLmMKKysrIGIvc3JjL2FwcC9tYWluLmMKQEAgLTgyNSw2ICs4MjUsMTEgQEAgaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQkJCWFzaWMgPSBnZXRfYXNpYygpOwogCQkJaWhf
c2VsZl90ZXN0KGFzaWMpOwogI2VuZGlmCisJCX0gZWxzZSBpZiAoIXN0cmNtcChhcmd2W2ldLCAi
LS12Ymlvc19pbmZvIikgfHwgIXN0cmNtcChhcmd2W2ldLCAiLXZpIikpIHsKKwkJCWlmICghYXNp
YykKKwkJCQlhc2ljID0gZ2V0X2FzaWMoKTsKKwkJCWlmICh1bXJfcHJpbnRfdmJpb3NfaW5mbyhh
c2ljKSAhPSAwKQorCQkJCWZwcmludGYoc3RkZXJyLCAiW0VSUk9SXTogQ2Fubm90IHByaW50IHZi
aW9zIGluZm8uXG4iKTsKIAkJfSBlbHNlIGlmICghc3RyY21wKGFyZ3ZbaV0sICItLWhlbHAiKSB8
fCAhc3RyY21wKGFyZ3ZbaV0sICItaCIpKSB7CiAJCQlwcmludGYoIlVzZXIgTW9kZSBSZWdpc3Rl
ciBkZWJ1Z2dlciB2JXMgZm9yIEFNREdQVSBkZXZpY2VzIChidWlsZDogJXMgWyVzXSksIENvcHly
aWdodCAoYykgMjAyMSwgQU1EIEluYy5cbiIKICJcbioqKiBEZXZpY2UgU2VsZWN0aW9uICoqKlxu
IgpAQCAtOTUxLDYgKzk1Niw5IEBAIHByaW50ZigKIAkiXG5cdFx0UHJpbnQgdGhlIEdQVSBtZXRy
aWNzIHRhYmxlIGZvciB0aGUgZGV2aWNlLiIKICJcblx0LS1wb3dlciwgLXAgXG5cdFx0UmVhZCB0
aGUgY29uZXRlbnQgb2YgY2xvY2tzLCB0ZW1wZXJhdHVyZSwgZ3B1IGxvYWRpbmcgYXQgcnVudGlt
ZSIKIAkiXG5cdFx0b3B0aW9ucyAndXNlX2NvbG91cicgdG8gY29sb3VyaXplIG91dHB1dCBcbiIp
OworcHJpbnRmKAorIlxuKioqIFZpZGVvIEJJT1MgSW5mb3JtYXRpb24gKioqXG4iCisiXG5cdC0t
dmJpb3NfaW5mbywgLXZpIFxuXHRcdFByaW50IFZpZGVvIEJJT1MgaW5mb3JtYXRpb25cbiIpOwog
CiAjaWYgVU1SX0dVSQogcHJpbnRmKApkaWZmIC0tZ2l0IGEvc3JjL2FwcC92Ymlvcy5jIGIvc3Jj
L2FwcC92Ymlvcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjk4ZTBmODcK
LS0tIC9kZXYvbnVsbAorKysgYi9zcmMvYXBwL3ZiaW9zLmMKQEAgLTAsMCArMSw1OCBAQAorLyoK
KyAqIENvcHlyaWdodCAyMDIxIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4KKyAqCisgKiBQ
ZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNv
biBvYnRhaW5pbmcgYQorICogY29weSBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRv
Y3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwKKyAqIHRvIGRlYWwgaW4gdGhlIFNv
ZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRob3V0IGxpbWl0YXRpb24K
KyAqIHRoZSByaWdodHMgdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0
cmlidXRlLCBzdWJsaWNlbnNlLAorICogYW5kL29yIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2Fy
ZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhlCisgKiBTb2Z0d2FyZSBpcyBmdXJu
aXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgorICoK
KyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNl
IHNoYWxsIGJlIGluY2x1ZGVkIGluCisgKiBhbGwgY29waWVzIG9yIHN1YnN0YW50aWFsIHBvcnRp
b25zIG9mIHRoZSBTb2Z0d2FyZS4KKyAqCisgKiBUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFT
IElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUgorICogSU1QTElF
RCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRiBNRVJDSEFO
VEFCSUxJVFksCisgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5G
UklOR0VNRU5ULiAgSU4gTk8gRVZFTlQgU0hBTEwKKyAqIFRIRSBDT1BZUklHSFQgSE9MREVSKFMp
IE9SIEFVVEhPUihTKSBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUgorICogT1RI
RVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBP
VEhFUldJU0UsCisgKiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEgg
VEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IKKyAqIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZU
V0FSRS4KKyAqCisgKiBBdXRob3JzOiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+
CisgKgorICovCisjaW5jbHVkZSAidW1yYXBwLmgiCisKKyNkZWZpbmUgQU1ER1BVX0lORk9fVkJJ
T1MJCQkweDFCCisjZGVmaW5lIEFNREdQVV9JTkZPX1ZCSU9TX0lORk8JCQkweDMKK2ludCB1bXJf
cHJpbnRfdmJpb3NfaW5mbyhzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMpCit7CisJY2hhciBmbmFtZVs2
NF07CisJaW50IHI7CisJc3RydWN0IHVtcl92Ymlvc19pbmZvIHZiaW9zX2luZm87CisKKwlpZiAo
YXNpYy0+ZmQuZHJtIDwgMCkgeworCQlzbnByaW50ZihmbmFtZSwgc2l6ZW9mKGZuYW1lKS0xLCAi
L2Rldi9kcmkvY2FyZCVkIiwgYXNpYy0+aW5zdGFuY2UpOworCQlhc2ljLT5mZC5kcm0gPSBvcGVu
KGZuYW1lLCBPX1JEV1IpOworCX0KKworCXIgPSB1bXJfcXVlcnlfZHJtX3ZiaW9zKGFzaWMsIEFN
REdQVV9JTkZPX1ZCSU9TLCBBTURHUFVfSU5GT19WQklPU19JTkZPLAorCQkJJnZiaW9zX2luZm8s
IHNpemVvZih2Ymlvc19pbmZvKSk7CisJaWYgKHIpCisJCXJldHVybiByOworCisJcHJpbnRmKCJ2
YmlvcyBuYW1lICAgICAgICAgIDogJXNcbiIsIHZiaW9zX2luZm8ubmFtZSk7CisJcHJpbnRmKCJ2
YmlvcyBkYmRmICAgICAgICAgIDogMHgleFxuIiwgdmJpb3NfaW5mby5kYmRmKTsKKwlwcmludGYo
InZiaW9zIHBuICAgICAgICAgICAgOiAlc1xuIiwgdmJpb3NfaW5mby52Ymlvc19wbik7CisJcHJp
bnRmKCJ2YmlvcyB2ZXJzaW9uICAgICAgIDogJWRcbiIsIHZiaW9zX2luZm8udmVyc2lvbik7CisJ
cHJpbnRmKCJ2YmlvcyBkYXRlICAgICAgICAgIDogJXNcbiIsIHZiaW9zX2luZm8uZGF0ZSk7CisJ
cHJpbnRmKCJ2YmlvcyBzZXJpYWwgICAgICAgIDogJWxsZFxuIiwgdmJpb3NfaW5mby5zZXJpYWwp
OworCXByaW50ZigidmJpb3MgZGV2X2lkICAgICAgICA6IDB4JXhcbiIsIHZiaW9zX2luZm8uZGV2
X2lkKTsKKwlwcmludGYoInZiaW9zIHJldl9pZCAgICAgICAgOiAweCV4XG4iLCB2Ymlvc19pbmZv
LnJldl9pZCk7CisJcHJpbnRmKCJ2YmlvcyBzdWJfZGV2X2lkICAgIDogMHgleFxuIiwgdmJpb3Nf
aW5mby5zdWJfZGV2X2lkKTsKKwlwcmludGYoInZiaW9zIHN1Yl92ZWRfaWQgICAgOiAweCV4XG4i
LCB2Ymlvc19pbmZvLnN1Yl92ZWRfaWQpOworCisJY2xvc2UoYXNpYy0+ZmQuZHJtKTsKKwlyZXR1
cm4gMDsKK30KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1naXQgYS9zcmMvbGli
L2xvd2xldmVsL2xpbnV4L3F1ZXJ5X2RybS5jIGIvc3JjL2xpYi9sb3dsZXZlbC9saW51eC9xdWVy
eV9kcm0uYwppbmRleCBkMGM4MmQ0Li5mNGFiNzA5IDEwMDY0NAotLS0gYS9zcmMvbGliL2xvd2xl
dmVsL2xpbnV4L3F1ZXJ5X2RybS5jCisrKyBiL3NyYy9saWIvbG93bGV2ZWwvbGludXgvcXVlcnlf
ZHJtLmMKQEAgLTQ5LDcgKzQ5LDE4IEBAIGludCB1bXJfcXVlcnlfZHJtKHN0cnVjdCB1bXJfYXNp
YyAqYXNpYywgaW50IGZpZWxkLCB2b2lkICpyZXQsIGludCBzaXplKQogCWluZi5yZXR1cm5fc2l6
ZSA9IHNpemU7CiAJaW5mLnF1ZXJ5ID0gZmllbGQ7CiAJcmV0dXJuIGlvY3RsKGFzaWMtPmZkLmRy
bSwgRFJNX0lPQyhEUk1fSU9DX1dSSVRFLCBEUk1fSU9DVExfQkFTRSwgRFJNX0NPTU1BTkRfQkFT
RSArIERSTV9BTURHUFVfSU5GTywgc2l6ZW9mKGluZikpLCAmaW5mKTsKK30KIAoraW50IHVtcl9x
dWVyeV9kcm1fdmJpb3Moc3RydWN0IHVtcl9hc2ljICphc2ljLCBpbnQgZmllbGQsIGludCB0eXBl
LCB2b2lkICpyZXQsIGludCBzaXplKQoreworCXN0cnVjdCBkcm1fYW1kZ3B1X2luZm8gaW5mOwor
CisJbWVtc2V0KCZpbmYsIDAsIHNpemVvZiBpbmYpOworCWluZi5yZXR1cm5fcG9pbnRlciA9ICh1
aW50cHRyX3QpcmV0OworCWluZi5yZXR1cm5fc2l6ZSA9IHNpemU7CisJaW5mLnF1ZXJ5ID0gZmll
bGQ7CisJaW5mLnZiaW9zX2luZm8udHlwZSA9IHR5cGU7CisJcmV0dXJuIGlvY3RsKGFzaWMtPmZk
LmRybSwgRFJNX0lPQyhEUk1fSU9DX1dSSVRFLCBEUk1fSU9DVExfQkFTRSwgRFJNX0NPTU1BTkRf
QkFTRSArIERSTV9BTURHUFVfSU5GTywgc2l6ZW9mKGluZikpLCAmaW5mKTsKIH0KIAogI2Vsc2UK
ZGlmZiAtLWdpdCBhL3NyYy91bXIuaCBiL3NyYy91bXIuaAppbmRleCA0ZTczMGU1Li40MTI2NmUy
IDEwMDY0NAotLS0gYS9zcmMvdW1yLmgKKysrIGIvc3JjL3Vtci5oCkBAIC05NzMsNiArOTczLDcg
QEAgdm9pZCB1bXJfZnJlZV9hc2ljKHN0cnVjdCB1bXJfYXNpYyAqYXNpYyk7CiB2b2lkIHVtcl9m
cmVlX21hcHMoc3RydWN0IHVtcl9hc2ljICphc2ljKTsKIHZvaWQgdW1yX2Nsb3NlX2FzaWMoc3Ry
dWN0IHVtcl9hc2ljICphc2ljKTsgLy8gY2FsbCB0aGlzIHRvIGNsb3NlIGEgZnVsbHkgb3BlbiBh
c2ljCiBpbnQgdW1yX3F1ZXJ5X2RybShzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMsIGludCBmaWVsZCwg
dm9pZCAqcmV0LCBpbnQgc2l6ZSk7CitpbnQgdW1yX3F1ZXJ5X2RybV92YmlvcyhzdHJ1Y3QgdW1y
X2FzaWMgKmFzaWMsIGludCBmaWVsZCwgaW50IHR5cGUsIHZvaWQgKnJldCwgaW50IHNpemUpOwog
dm9pZCB1bXJfZW51bWVyYXRlX2RldmljZXModm9pZCk7CiBpbnQgdW1yX3VwZGF0ZShzdHJ1Y3Qg
dW1yX2FzaWMgKmFzaWMsIGNoYXIgKnNjcmlwdCk7CiBpbnQgdW1yX3VwZGF0ZV9zdHJpbmcoc3Ry
dWN0IHVtcl9hc2ljICphc2ljLCBjaGFyICpzZGF0YSk7CkBAIC0xMzQ5LDYgKzEzNTAsMjAgQEAg
c3RydWN0IHVtcl9zb2MxNV9kYXRhYmFzZSB7CiAJc3RydWN0IHVtcl9zb2MxNV9kYXRhYmFzZSAq
bmV4dDsKIH07CiAKKy8vIHZiaW9zCitzdHJ1Y3QgdW1yX3ZiaW9zX2luZm8geworCXVpbnQ4X3Qg
bmFtZVs2NF07CisJdWludDMyX3QgZGJkZjsKKwl1aW50OF90IHZiaW9zX3BuWzY0XTsKKwl1aW50
MzJfdCB2ZXJzaW9uOworCXVpbnQ4X3QgZGF0ZVszMl07CisJdWludDY0X3Qgc2VyaWFsOworCXVp
bnQzMl90IGRldl9pZDsKKwl1aW50MzJfdCByZXZfaWQ7CisJdWludDMyX3Qgc3ViX2Rldl9pZDsK
Kwl1aW50MzJfdCBzdWJfdmVkX2lkOworfTsKKwogRklMRSAqdW1yX2RhdGFiYXNlX29wZW4oY2hh
ciAqcGF0aCwgY2hhciAqZmlsZW5hbWUpOwogc3RydWN0IHVtcl9zb2MxNV9kYXRhYmFzZSAqdW1y
X2RhdGFiYXNlX3JlYWRfc29jMTUoY2hhciAqcGF0aCwgY2hhciAqZmlsZW5hbWUpOwogdm9pZCB1
bXJfZGF0YWJhc2VfZnJlZV9zb2MxNShzdHJ1Y3QgdW1yX3NvYzE1X2RhdGFiYXNlICpzb2MxNSk7
CmRpZmYgLS1naXQgYS9zcmMvdW1yYXBwLmggYi9zcmMvdW1yYXBwLmgKaW5kZXggMTQ0NTdmZS4u
MTMzNmUwNyAxMDA2NDQKLS0tIGEvc3JjL3VtcmFwcC5oCisrKyBiL3NyYy91bXJhcHAuaApAQCAt
NTcsNSArNTcsNiBAQCB2b2lkIHVtcl9jbG9ja19zY2FuKHN0cnVjdCB1bXJfYXNpYyAqYXNpYywg
Y29uc3QgY2hhciogY2xvY2tfbmFtZSk7CiB2b2lkIHVtcl9jbG9ja19tYW51YWwoc3RydWN0IHVt
cl9hc2ljICphc2ljLCBjb25zdCBjaGFyKiBjbG9ja19uYW1lLCB2b2lkKiB2YWx1ZSk7CiBpbnQg
dW1yX3ByaW50X3BwX3RhYmxlKHN0cnVjdCB1bXJfYXNpYyAqYXNpYywgY29uc3QgY2hhciogcGFy
YW0pOwogaW50IHVtcl9wcmludF9ncHVfbWV0cmljcyhzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMpOwor
aW50IHVtcl9wcmludF92Ymlvc19pbmZvKHN0cnVjdCB1bXJfYXNpYyAqYXNpYyk7CiAKIHZvaWQg
cnVuX3NlcnZlcl9sb29wKGNvbnN0IGNoYXIgKnVybCwgc3RydWN0IHVtcl9hc2ljICogYXNpYyk7
Ci0tIAoyLjE3LjEKCg==

--_002_CH0PR12MB51569D72B2C29929B5BBB127F8509CH0PR12MB5156namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_002_CH0PR12MB51569D72B2C29929B5BBB127F8509CH0PR12MB5156namp_--
