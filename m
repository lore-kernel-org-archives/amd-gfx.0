Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D80C19F2E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 21:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA7F10E2E8;
	Wed, 26 Feb 2025 21:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gmr3WhSM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE0310E2E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgGY9rFS/YQw+AdW+ip1PV9WkE4Mr/0q5w8/Cos2R+HZPztdcUFog/JQMDnju03sPyliDRTU+FKYRWq5i3Eb9x1jsKnpgCTyyLZ7W2yiPfWoH/3x/p5Me6UkGcJXIQIyWftkAEKa2OKNXhYaQD4O1PnQDA/7JXIwfFAdzDc3UvNksdhHzr+TbVL5mmk75PBw79mxwOY2+7YaQHNj8//V7gZ0ajRE7olzeX6xyOhKe5REMu5nQTZaDJyvG7OKmyUJpJgakTnKOawVSqOpZDHHplbs40sPstDBX8N88h757A2f+KV6+aXtPjpFPE8CW8OHd/rBWAaEUhqestlAxeH8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g5YfhC/4gCA8xvzDGkleT62lcDfRYiqOpM4oiJGWno=;
 b=SdKl830zop0OvQ60KO2QtTWBvp6KStil5j/IjCDW60IbC/E5WmHV05pN1AFuN04YzToojovP5hCLGNBhDKcj7QTLGIeNW+co+fxCM6kKJEsw7VpXQWtYIdZwojmrz/hII9MYqWzo1NL+FNk+xSlvyOqQUjP+MMDKGtKrmXw7RhM4nOYfQXbbM0ciJ+ryifuFQ2GeCe2d2LAUEsMuWi/wbU6ErX9FXqwU+gHNUirRRHYPfIiyJbjpMatUUBWBJhMrTDCgqL1kebj2skfFUlZ/Ys0cRWvt6McyEJCfyb6+IqM42oAvZNT1hCltSsKFvHFDUfG76iPxxRNMBr8G8ZC6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g5YfhC/4gCA8xvzDGkleT62lcDfRYiqOpM4oiJGWno=;
 b=Gmr3WhSM/7V2V/pCskqf31I1Hb/CvR9FJUBUo9y833dyJp/IGAXZM3SQVlAPsRA1d6Fwb283TMR7Y5glDV74kec2BEJrCZlOqWoFhgMOI5vMj+Lirog/vtkm9iHt2s+/dconWZTQ1Vor+znor5p1M2NQRIRwyzi7DzR3qjbyqNo=
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 21:30:02 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:30:01 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: remove kfd_pasid.c from amdgpu driver build
Thread-Topic: [PATCH] drm/amdkfd: remove kfd_pasid.c from amdgpu driver build
Thread-Index: AQHbhw75DpZK3ZcyNUiD4POQvcyW1LNaHLww
Date: Wed, 26 Feb 2025 21:30:01 +0000
Message-ID: <DM4PR12MB6566E960973BC1AAEE55CA97E3C22@DM4PR12MB6566.namprd12.prod.outlook.com>
References: <20250224225942.278208-1-xiaogang.chen@amd.com>
In-Reply-To: <20250224225942.278208-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b52517ca-08ea-42a0-b748-6cb09c0a89bb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T21:28:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6566:EE_|IA1PR12MB6043:EE_
x-ms-office365-filtering-correlation-id: 9b2546a4-31f5-4280-38e9-08dd56acba5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xr0xYTN9A8qLYOp/ozaTvv8BEzbyqebGLT2y6qG4pwtLy3L5moVBcn04VOjS?=
 =?us-ascii?Q?OCfEIwfEcDUrHP/YOal5v/4eAQNZVlRD8qFUiqYl/SOB5SMDKDJdmy9+N2wr?=
 =?us-ascii?Q?jDtCjfqSsUpUMeQsxAyFPuWPKD/gUJeWdOt57gGR+WVBOgQTG4iZt2E2PH/J?=
 =?us-ascii?Q?pLuxz+lbW8URWYgSCrx3OgNlRX1OW9xeQ0hLCCJMJhCkwz0cVeFymbCmTTdr?=
 =?us-ascii?Q?SlHcU9HCmyPjQlu6fZf7EoCSjyfpZBrc45teibuMuuz4UMep+oXsjFCjLEbC?=
 =?us-ascii?Q?ewsLBtqZdL/TgYv8dQn6yGkU5L1tq47XI3Fei3jgop6ztEhe3x3C3G74+HCd?=
 =?us-ascii?Q?ctAuFPuCB7HiEzagjgCImCk2V8H6E8cWCREMTI3ZBgYfsXH11ZcrayAZhHAD?=
 =?us-ascii?Q?KWiUqWbqEHXsX8EYDimU3VC26jEgf1V5GR3DYIRLGhAJ86ugFc3ZlkgUYUrj?=
 =?us-ascii?Q?/bBThFs0u0jXWrtWD12qR9Gt/vHVGnUe5xJQupRCVhZnWzjk1dSr0KTSpZt4?=
 =?us-ascii?Q?9MpdOaWGmKKOqyNpaCx8DiFitEba9xsRpH2/mg686HuXS2PvhwbKHoZ+KBIw?=
 =?us-ascii?Q?hIr4JoRJUAs2zhdsY0S48xetm7LHI4bZN2ODHxlNTUr3THHo6hA0sWalsIYc?=
 =?us-ascii?Q?uID6AvL3jGYp2besmlo1RQ5/QJ7h8PdEdO675ALlnaWoz+NkQQqeUlqECVYk?=
 =?us-ascii?Q?kx6GK8+OVatygAAkTur3NtuzXd4pgcK1JE7mDxn+MNcY0WBOEmBlq1Q39xod?=
 =?us-ascii?Q?hdHu0EJ3cFKIxOxGTCATdM2+wcknIqddpL63P04KPUDsIFmNygIEk57tiu9v?=
 =?us-ascii?Q?b/ulz/PxnLd79ozCAV7ncjxVdtOwZIgHy/5BpQ33jZmFVV5baSivPxnFHxBJ?=
 =?us-ascii?Q?6T2IdCLPPyWm4vOqYDTvYlxtoowCGnIqxnyKn7kccEUL2JzyUo+R2veMqPAG?=
 =?us-ascii?Q?tYO7BKnTmZbw2UkVYBKJW4KhiZ83/3tVaXzGEbqPC44lBpsF2qkvY0fVJv7W?=
 =?us-ascii?Q?rbqREJxlPASZWTnxW9StEgrhVLNp8lORVvGmX5eLHGAJfqcuH2fdGSa2TxAm?=
 =?us-ascii?Q?3hZv6ftkXag40Mzu01A63+wUxTVeWwgm0Vd2cPD1NfN07jfqrvmgbMtcodlv?=
 =?us-ascii?Q?ufNWzV3rd3UDNhC3At11NyLfzeIxB3GcJKU5cc/NwiH2DwcuDZ66y3arWhqa?=
 =?us-ascii?Q?hhB+EZYJHHSqsgurDXBXH75HQDbWcugxq0XG/f02esT6edRU3o5QLtLAXevC?=
 =?us-ascii?Q?PZHoM5908NyrpGTYkVB7vyuJ2pWF/NsyNDRADyh44g+zHSQEqoC4/c3fuu3A?=
 =?us-ascii?Q?2F8VYLaEaFR5/RHsFsFZHCofDblZJMd2h4optyWsf0la1Vsmxhy8vr9vyguV?=
 =?us-ascii?Q?rTK8r3VYpIEQCVfETgFDa8IbCXkDaElIM28T1unyzgQNBzc9/AhB3RAau7Nd?=
 =?us-ascii?Q?PMfusTrKRymvwpvEo+hVVVG4XzHetOYo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hw9ZD6iBF7VOYD29pr4nTl3ucdlwKxBmM86zvilSXYD+SO4tYZI1UHexH1Q2?=
 =?us-ascii?Q?6fFuPzhBEOqe3KLaYTxdGJxbQjqRGopd2uqlXRAQVNxgMFNULHEOceGH5ywM?=
 =?us-ascii?Q?u9oytKmT/z9BzmFqtOPBNeZXMeqwWO3Q4P1jFv4EkrBNZwvmymJ4414+RLIv?=
 =?us-ascii?Q?YZqQPa4iLkxeyEI76vJFiyvFrTnU50UU6B+swSZNvrY12Gzxo9D+wHMcsIE1?=
 =?us-ascii?Q?UyU6E29glrCdhT/2vV3ms+5Snm+uDZ1zCzSBco+qzw7/efjc44zng79soz9C?=
 =?us-ascii?Q?c9aQmEPjHhyUrcAMUQbeJ3PrZIrc8LMifQhtXjbQl/XU7CXHYWkm6nE9L1jM?=
 =?us-ascii?Q?50cefQHsregIubXfYXBZD+sAmK6l9IR4WwCkKN8QQhGTHo243/cKQRIR4Gwt?=
 =?us-ascii?Q?4DUvEQ7kTEq4rTm5MPzflcWHpKYWg0JT6DqnuVr35ozfP9Mqe1oxFp2ZMmPp?=
 =?us-ascii?Q?GC5e6UlHI4JqDm6yuWkH0vLGVD3f/d2eTCvu9K0TqZRjl3Y4y5+uMRtROTMb?=
 =?us-ascii?Q?tarHv6h6j1gbnuKUQdLWlGQiPYDk3TLFdohRGaFOOXcfiUp8J3Lg1g3wFScc?=
 =?us-ascii?Q?PhKjX8M6S3VonCi+cBy3/eMff/gZW+MSt/q1PuZb5ETFj1UwIjAlSCeMaVr4?=
 =?us-ascii?Q?hjuJ5SdSyGLp9rtXnfOLOCSYjsvUuY4K0/79YC0q6DYKG+jIeuSmazBfZ/Xa?=
 =?us-ascii?Q?uU839dIPbU2ULeNdokyPxw7q44dIt5O8Vb+okx4hktBEE9mSf7BxTkRbn2wa?=
 =?us-ascii?Q?Up6elHx9cM6jDakz4bcGeI4BwFrtgqhKqbDcn0Z2IynbClMQ3F6nLUHAF0Ia?=
 =?us-ascii?Q?UylhMs7waN8kdgQGmA4j3cTXigPWgd9tHD61PHSTjoIfznfhzfsHZSDypVd1?=
 =?us-ascii?Q?iFiICFDMevQqp/lRvfDAWy+Nhyvb3tIPIYb3y20wpsrPJEIvGNu/RhnwDI4o?=
 =?us-ascii?Q?BTqVc79g09BnAOUPViTMV5/8lrDTMHTyazN6HoimYa3K086+dkL8fb5rmR8h?=
 =?us-ascii?Q?Zj0QD2RtLwrbs6bRs4Dl2QYRolKG6EFgxtDhePfXoMVxhqQi9THQZWrGJSnd?=
 =?us-ascii?Q?YepI2yBr2ejQyV2UrbV/nWnSZlHf877YUgMXsh7uLlUncoiX6pnsTMVLHUdX?=
 =?us-ascii?Q?OTn/b1JGA0dFSVx+oqVGnep5m6ADymGbJaDVsHnQ3yN+5nTxfPr1zyFkde06?=
 =?us-ascii?Q?Sk8oBE3C60bptM1zCmvnFfpKyBJJfZm5i+JIAHiVueUmrrdE9Ycx7ZL7gYZq?=
 =?us-ascii?Q?ehFI1gUEg1evmWVql6gTEMJkhk8lqTFx8mDqViPhkzC8SKWGduc8JL+jF4y1?=
 =?us-ascii?Q?frQss3odURTa1KaRvnJYuyMWwGtsNkHzkYbrf125SQXLzYoU+VfWM6U0aoG9?=
 =?us-ascii?Q?UqdHTZ04jXsqmwodCf2WC46YOZJrfwUtgofideSHx2v5wDykYprIClhUaRZy?=
 =?us-ascii?Q?3VB8AeMJNIcXnoIJho/n6luoNq8zTaIDDNiYD4CU++rNufSKjMbM7BlXzrrL?=
 =?us-ascii?Q?9vgiuNIFdqG5dR5yylRqn9MvOuUauHt8Nv2Y5kQIiSOUTaECQY+8afVOPSD9?=
 =?us-ascii?Q?Hy34zK1mjPbp27c6UZY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2546a4-31f5-4280-38e9-08dd56acba5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 21:30:01.6976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTBzo7UqdEyTqMxiIt6TXW2ieXSlUday42az/fv5et4MBksFxA8YpnqbDYPFBl22
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

ping

-----Original Message-----
From: Xiaogang.Chen <xiaogang.chen@amd.com>
Sent: Monday, February 24, 2025 5:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Chen, Xiaogang <Xiaogang.Chen=
@amd.com>
Subject: [PATCH] drm/amdkfd: remove kfd_pasid.c from amdgpu driver build

From: Xiaogang Chen <xiaogang.chen@amd.com>

Since kfd uses pasid values from graphic driver now do not need use kfd pas=
id fucntions.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile    |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c | 46 --------------------------
 2 files changed, 47 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdk=
fd/Makefile
index 0d3d8972240d..0ce08113c9f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -27,7 +27,6 @@ AMDKFD_FILES  :=3D $(AMDKFD_PATH)/kfd_module.o \
                $(AMDKFD_PATH)/kfd_device.o \
                $(AMDKFD_PATH)/kfd_chardev.o \
                $(AMDKFD_PATH)/kfd_topology.o \
-               $(AMDKFD_PATH)/kfd_pasid.o \
                $(AMDKFD_PATH)/kfd_doorbell.o \
                $(AMDKFD_PATH)/kfd_flat_memory.o \
                $(AMDKFD_PATH)/kfd_process.o \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_pasid.c
deleted file mode 100644
index 8896426e0556..000000000000
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright 2014-2022 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include <linux/types.h>
-#include "kfd_priv.h"
-#include "amdgpu_ids.h"
-
-static unsigned int pasid_bits =3D 16;
-static bool pasids_allocated; /* =3D false */
-
-u32 kfd_pasid_alloc(void)
-{
-       int r =3D amdgpu_pasid_alloc(pasid_bits);
-
-       if (r > 0) {
-               pasids_allocated =3D true;
-               return r;
-       }
-
-       return 0;
-}
-
-void kfd_pasid_free(u32 pasid)
-{
-       amdgpu_pasid_free(pasid);
-}
--
2.25.1

