Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CFEC25B48
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 10:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3424510E341;
	Tue, 24 Oct 2023 10:57:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7197F10E341
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 10:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX20vPh2wBtoyYLFVVQUKRB74SexE+4wUhY9kNS6E3lVcg7lefFxY6q0eSae7XIP0oImxLAqApMTwOAoU9pR698pJEq4P6tAjTe6UfwOiA7+WkGlqqsloIPqh8t/prJEHhKnltJZvpaSgCJmQGnS6m2Z9Ul0wCMVeqUiOqXI2cK9AEXOfqRMl9e+0LWDtVIyI4Q1SP+WA33LYoElTTPH4NVVWE4dN3y1cTwrGCmbARu07+pWONz8noXLS8HRvSzpb0k7AHZG4ixJpui7Z82y1pZBbj861KDPTOSomPAHBIYPFGwplPf19kMHQTP3H+NJJtdPeiZFv6HwAs4/ufjhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Logk+Q4bqGgbW1pdpLDxaMholB0JF9+5sYkhbWoa7gM=;
 b=baFT/GnKNSyZmWJG5I1bx0SSVNsosbN1foZMPrP7ItWQK1CvIYGjkIsaorTXtMsn2KVwdG6arC1Pi9Yqzcn9cn3ZeTK8826bpR0jSlbZt6/fPc6RHWQRrnLAq+tcFpxBbnMNRu0o9KuVgZqw04mXersrbjPx20eSw1ve5uV0Lb/rL25M8SvAU3GUKgJf7IDXlBqvmbIWurQ8/zEfpY32EufzN6vdC0X/Is/w8o0jyJ3LwxbQy8CXMASeRgUlaRFtEFhuFQD7XAmtXtWrSKy4nUn1NvxAlqLThQr/ZTl4Pp71cTdCRhm0fT+uaM8aviWDFhtmt/3ibjFtSndLP7Uf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Logk+Q4bqGgbW1pdpLDxaMholB0JF9+5sYkhbWoa7gM=;
 b=tKlFGJxbcQXniuMaGu6xvdtGr02qkweilGqzeKZYefdyge+TJWgDSDaxZofuDKRNPUG+BiLftP1yl13oFLuSUwx6pL7fQFDg0lzw9tserCRf7QhvzHoa/rAIBCxwbQY85wXmqeOcjsE5+zJw1My6t2E8lpUX3Wkc3nILbnGwXoo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 10:57:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::24ff:20ac:619a:9676]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::24ff:20ac:619a:9676%3]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 10:57:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: get RAS poison status from DF v4_6_2
Thread-Topic: [PATCH] drm/amdgpu: get RAS poison status from DF v4_6_2
Thread-Index: AQHaBkU46TwAb8eAdUiEAP35tSAAnrBYxTyA
Date: Tue, 24 Oct 2023 10:57:51 +0000
Message-ID: <BN9PR12MB5257E2C0C346B047AE7BF700FCDFA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231024064135.2070-1-tao.zhou1@amd.com>
In-Reply-To: <20231024064135.2070-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5b0c8c98-6574-4325-a0dc-71a1d198209b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T10:57:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN9PR12MB5242:EE_
x-ms-office365-filtering-correlation-id: 2055a249-7a94-48f8-faa3-08dbd4801198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LGk5h3Aijdarj/YXpzqLJc5oc9NGkJ2mjR5vOsDM9iEGcDKrqK3WaIjw2ifChN0uBL0pMPP3lTqv9udrrqczMZcGDcs45pnF7zi34WOD7KktwYlbtAcsIYqA2SbXXReSho0ypU+pRUQnC25ICkzzNf2YrkyNpqvBiHwbG+A0c2et02Kb+nissQjxdUoSq6DkwhHzHjH4qQkknIL14GV+0KnWOxUiYZLeA1MsJNUuS37ca8s/czk3UP1s9Um1POpAPk83JK/fnQ1Ve0sUwI+i1QXqvfN1QYiQVMrI9VjltEJjKgf8ycr6gZQIuVX5XQYVnEbyIBdX/GVDXw+f1lUssqmHPPkCV5QUfw8HDHRt8DrSiPsAFjgfUiEjwndobuj2a9V+1Bqq5LfP21wBXscM94hnjD81achTBv+36UYiBvR72BG8+PhIs60THWTt8tGNvXirW5uRQUsuh2wTsH/H7tPWQpLOvCToIimlIr2DISreI8HWO3swZe8GURWZ5mgc2UKo8lR1FD3BRdr7HShEPJCObvjswgQZpmZPiQGj33uqz5GR0eIzK8WVcqYzxQ87WqQNTWUDZYN5CVuvzr18gnP7Cw/VO0c6Xh0mCPLTYHGvEZqTUFwppaxSSq3600YG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66899024)(8676002)(86362001)(4326008)(122000001)(52536014)(33656002)(5660300002)(38100700002)(2906002)(41300700001)(8936002)(110136005)(66556008)(66446008)(66946007)(316002)(54906003)(64756008)(66476007)(76116006)(53546011)(6506007)(7696005)(71200400001)(9686003)(26005)(478600001)(38070700009)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SX9HPlyBgIupEuYLplQ03obUV4IzsCEgvmdXUzPRNfcJXIgG0EQwEh7mP/fP?=
 =?us-ascii?Q?yzwBykJ4VjlzzBSv8EhkbYb4tgQsjuTXzlFSxIUwGrZ252blxXIP6adyHXNq?=
 =?us-ascii?Q?F0s7v39YJ5LhFvYTBt2sxfItUuLHNqg1BmVFB7FmZYj+hQpaMYf8jY+t9IP3?=
 =?us-ascii?Q?b0HOf2k07PA0cn2WOYRXmZpITpwBsIEs2D92p4U01SL0DGma55mn/ra6itdd?=
 =?us-ascii?Q?wKO2nIOIuHYgvnqAJgg5xM0bbFBsfvymwenIb4uLYfCAmlmsI1IBvQgCEj/W?=
 =?us-ascii?Q?Vd06sBE2ZRrsDcoyaHuiMQHH4rCB+VUWrx2zLSnFWCsCNFnnB5U651QsJRE0?=
 =?us-ascii?Q?nh5c8hh3hxb+A8gi4v/xnThyNPAPKjM8jIyb8vFB14meOYbj0uQfU3jsPtUP?=
 =?us-ascii?Q?FTOmhEqDKMgls7yY2DTDIXf1OzrRqOuhMOERj1iiqYRGz06UzW9GWUF6cb0i?=
 =?us-ascii?Q?eeIV1MhVae+ktJxSCvcI0yJIQyVPH5veH1cgJ6v0XecKT0nWmmIayG3MDYlU?=
 =?us-ascii?Q?iL2TomnUD6BnPgour+mTIWHZ/2pNbp1upkUI7t2mo/HxrcNb60eEeVUjIUok?=
 =?us-ascii?Q?n4JdXdrbB8S0cfL7Cvsz/3RFONaiJ/WzyhVRWRSNAVCUJ/l8YO6XB8+LiLfR?=
 =?us-ascii?Q?29YBsYJPGzE22OUQGn9zrjA0Ja6X55QOFSY6Na7hoBdwB/1D6m7U97bcooFf?=
 =?us-ascii?Q?jAcNZ/ef8u9FRkkzb/fGKI8emfRQahMU5opDD39M+Di1+9wBSmK7nNl5Qfet?=
 =?us-ascii?Q?S0bqFD+nu3TxpgO/vrnl9g+IxWTmugl/bFbUzSfrWwbi/8b0lAwjsyUJooUt?=
 =?us-ascii?Q?KGsuLmX5Rb5a0MxZl2QMQGwNYGDXDJ8jajvhGcIuLVHbNMgSM/hncO42cZjX?=
 =?us-ascii?Q?eykPePn/WXJHW1w288P3ktHMFQTORCxmGtHa5vWw9NB2OWRNhfN06UOkEoSt?=
 =?us-ascii?Q?VOswZF1cA2NqCPLPwOIIsslWfhpjETm0R5spblSqRaffX30x2PcBkPPWE+XV?=
 =?us-ascii?Q?RxwEcjW1To6AL7dw7pg5DBY5UoIFVD4OVWtHmityZKXcRKB/Iej5vnTpzpnH?=
 =?us-ascii?Q?5wGCG2MijKBmMDEnUybY7mSQUbo9MI6hP3Eikzm6a0HXxv9sveTp7d8eoOd1?=
 =?us-ascii?Q?XcSa4pN12xKO3Jw0btaisrTaQktOGweoM5/nKJ7Q1wikhswSOjBmcKTaM9Fu?=
 =?us-ascii?Q?VAxh+UQYEFTp3P26SS0Ix0876efqIEHzbErPrfLejg0970D/1WshBaIA1Abv?=
 =?us-ascii?Q?2bF4p8zKE62VPeR5o0lC7mQiYVm9gzzWpE7lNMCOQlC/SjxeaXvSbEgZprWB?=
 =?us-ascii?Q?ElS3P9Xj9+Qm+3KRFuCHhaJng0scWtFuyHPtRML/1Rw0Wjs6ekG7aj8rbbp1?=
 =?us-ascii?Q?GxYY1zFLh2AUVZovDtFVesHbDM3DO6PvG+BppyqnfD7VOZWtKJifLfTgRfZG?=
 =?us-ascii?Q?cSuRoJ/BYTEqPmX5P685Dy9A+62p4TLdAfitx1UAlienny/y4Gi1GvzAK4Rf?=
 =?us-ascii?Q?Q0JaTHZuwRJflNxpjH/33zp7ROpy3qQIffwQSb/3RPKVOqx+zQ14Z4GoO6x1?=
 =?us-ascii?Q?GKqZ3IF3tCxHsPaTU2HEs8sUyX5M8gyFyzqt0lib?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2055a249-7a94-48f8-faa3-08dbd4801198
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 10:57:51.8927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eG7KlUrlCdsihxvQ4KV6kVf656WKtarW3/lkbAJZPCkDbnwZt7p2ioVmAtp3kRAMQYC3airXwb4ttXlbnWwjuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Tuesday, October 24, 2023 14:42
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: get RAS poison status from DF v4_6_2

Add DF block and RAS poison mode query for DF v4_6_2.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 +++
 drivers/gpu/drm/amd/amdgpu/df_v4_6_2.c        | 34 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h        | 31 +++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)  create mode 100644 drive=
rs/gpu/drm/amd/amdgpu/df_v4_6_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index ec1daf7112a9..260e32ef7bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -104,7 +104,8 @@ amdgpu-y +=3D \
 amdgpu-y +=3D \
        df_v1_7.o \
        df_v3_6.o \
-       df_v4_3.o
+       df_v4_3.o \
+       df_v4_6_2.o

 # add GMC block
 amdgpu-y +=3D \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 17d4311e22d5..8d3681172cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -35,6 +35,7 @@
 #include "df_v1_7.h"
 #include "df_v3_6.h"
 #include "df_v4_3.h"
+#include "df_v4_6_2.h"
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
@@ -2557,6 +2558,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
        case IP_VERSION(4, 3, 0):
                adev->df.funcs =3D &df_v4_3_funcs;
                break;
+       case IP_VERSION(4, 6, 2):
+               adev->df.funcs =3D &df_v4_6_2_funcs;
+               break;
        default:
                break;
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.c b/drivers/gpu/drm/amd/a=
mdgpu/df_v4_6_2.c
new file mode 100644
index 000000000000..a47960a0babd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "df_v4_6_2.h"
+
+static bool df_v4_6_2_query_ras_poison_mode(struct amdgpu_device *adev)
+{
+       /* return true since related regs are inaccessible */
+       return true;
+}
+
+const struct amdgpu_df_funcs df_v4_6_2_funcs =3D {
+       .query_ras_poison_mode =3D df_v4_6_2_query_ras_poison_mode, };
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h b/drivers/gpu/drm/amd/a=
mdgpu/df_v4_6_2.h
new file mode 100644
index 000000000000..3bc3e6d216e2
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __DF_V4_6_2_H__
+#define __DF_V4_6_2_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_df_funcs df_v4_6_2_funcs;
+
+#endif
--
2.35.1

