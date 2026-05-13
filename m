Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B324BCD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 23:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3789610E353;
	Wed, 13 May 2026 23:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3p2aLSTU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B8C10E353
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 23:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEO2IF45V2eKq5gCWoNW5Bu1D5zyQ/pij34Iyaf6TKjoKTpszAlpO2ztqSHQoEGy8ZGjDwqQVlv+97Og33VZJLBflvj3uNH38iN0uvucFJQaKYk5dwJiAjI55BMGSf4exU8oLaoMbwj/x9yFtuzgEUC8cv+ej0tSUdIFLauHn67Hg8pBU5WF8I8eRNFT/Eb9oKfiLfTar+dmFwMLIbugYol31n1mi9Gj31kkdxTfl4kswE+rzgGeDSDd94tiF3oYtGn5VpTjtzCdsB9nmRYKK+TVEODM26tfujKzRNx2LEPoSGWZoRoR7FV6/oeIeKVm7jJyc5kMZZ1rb4JpamhNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/Ww8pri4z6Co3wOF7IUBcoH57laDrWHh1W9v7cFdWU=;
 b=sZmw9cDuTckkJkOw37taDLmMrIT+EEULhZB1zts0cTkcxzihkTYGObT4qvD8SoNwbElh71OOcgnnWGH0T3zeFx54i61l6/pQnt3wPvVOI8E3q/b+rm5PsAPo22L334/lFSz7ITztoOWD3jrWgN6Hw+bnQsqqgE5nUxcJVSFD78bchsCX536Kc5mQmmscNAH6txBaML38YmfIP00Er0Fswrl6kw6uKAZrp1dxg+2BX4YKJJvw0NyvvmxHI8aiRVJ80h5jMNYFe5SV4UbSDejoStku5GV6vZDImDEsKxJk9/ljB2OEMIg2Nyt3xaxjin2NgbvtvjwKHVTLXjVljYeJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/Ww8pri4z6Co3wOF7IUBcoH57laDrWHh1W9v7cFdWU=;
 b=3p2aLSTUFBOrlYT5tvRQDZs+n6z+E9hReslirFYBx7yboT3kHg2JN3Xku6IgTLRGDmwG/I0nou2NCXPm8vWELL1mt73WT+8XBIaF4L9TlvhDBAaze5GNUKQ9k6a2OtvmyPJ1vGZ0xfiuMag3fOgl+LFqI8sNx8dST4w+AMg8Gik=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 23:55:48 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 23:55:48 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH 1/2] amdgpu: Add profiler IOCTL interface for performance
 monitoring
Thread-Topic: [PATCH 1/2] amdgpu: Add profiler IOCTL interface for performance
 monitoring
Thread-Index: AQHcy3vrresunV+dwkCWkwn++z1PILYMx70g
Date: Wed, 13 May 2026 23:55:48 +0000
Message-ID: <BY5PR12MB4179F4711D276D5EFB60AA99FD062@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260413192947.3145878-1-James.Zhu@amd.com>
In-Reply-To: <20260413192947.3145878-1-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-13T23:22:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|CY8PR12MB7539:EE_
x-ms-office365-filtering-correlation-id: 38d82d1a-60ae-474f-1f21-08deb14b2817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|11063799003|56012099003|3023799003|22082099003|18002099003;
x-microsoft-antispam-message-info: HyEQeAY0Ydl4hlrTK9Bd+V6Wyptec/Wyil7qiB/tfwmqgp6SH9rluhuJrABxp0drnDT5QgWtqHicsqTvevtWup3lBDZWy7YRwYBp6wG+HKFUQXDCQS9bmPVAsdj1tIoEl+Zg0E41pIYCGt2hrSt5NeME3S0cFQeA46gsZ8qiXwaeFtSfdfKu+Xwaam6wyTETtXbciRh40cErYWvTE6VyvyyOcMvOAVAnHnmq09ATclWxU7I5fNHWz6+c9BKDNMqhV0C/pNr/ZaEk1GtF46reJ0iYG3CZX8Ly4rmjaDAnFMw8cJ6vkw9lr2hL4rWSqHve98n+hWk70ocYhOmp8RMnWVZnw2NZ0WdqMCNkg4r7vduyY9vY1ZAGxajEUMP7HHrJrZwG6bxfRo9+TCQKO2KQFlyLoq1EiB3cyW1e8JTby0Y0X3X9M8UtOFjUNHzS+80c6RI2yBhIklAjaYSI3g9WHhSF59opgsFjDJJTA2t9bkcbFJCmS+/omHD8DZi0F657fhYaAfT45zP06VL8K1B3wAUtExaHnORMKU4zYCYKjAPmsbXTPw2iJ6Mwk60c6Qde7DxGqNkBw19o1XQx8vk4Hily0X8YprLdEDteYKXJ54jcaT0tOxevjEDHtANbPBvq+dRpc/5+4V7rujqgIm04IPgNa793D7wldQbKoA4826H8I11vxdsy9ao4IEl9qt4P/Td2G0c21N0pNMA1LNhePLlMGS2vmNWTyB/RG/TkMFcaes377pHrFspk9o0q/PTK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(11063799003)(56012099003)(3023799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hArpsgU6q3KIsg2JWEr+uWc9vj+FIOjkVuHBagNCWuHkpd6RcxGB0WaAm2qr?=
 =?us-ascii?Q?k+zJjeYVK/R5A4PUR3MFeLnjANHisuzqrIONT469il5xEFMqi/+y1jZjHWYU?=
 =?us-ascii?Q?ovlVwsYv9E1jvENmwsgDYVM4YReytcctI7GAkGx1tEns0mrVoCPVoYcldEdp?=
 =?us-ascii?Q?9pFByKqpm6wZvjOcNDjObPpn8Ls2VCyFRa6R6q9rd5YcO++aHETw6uo42Vak?=
 =?us-ascii?Q?QGrE6Ztc2S1PpaMzSI2aJcOsrF+isBlt1dpMfGy0UgrQiErMy6kdZxAH6OZo?=
 =?us-ascii?Q?19RCxjD35ypLCz4kD2nhDZ9dOHIHU1RMniFFquRfL48AmYzRrLuM+8OkGLGU?=
 =?us-ascii?Q?BxwfhAGu9LsMek/6YfPUxK/47EE8s9BxOqUeefiLSQdhFrc+xXX4af9y8FqH?=
 =?us-ascii?Q?7avrSIRICS2qJmAjqCWugcpl84s4KbG0zd4lNlQG0LeX35/VRsqY6thfr5fY?=
 =?us-ascii?Q?1xl2OAWvcsaq8l/UQZQWkdrz/gQXnEfD5cWQffdgJAkGeNodeNygl21cYz9i?=
 =?us-ascii?Q?nkkFIouI0ijFMJeGZKQPWHcW/pLjaeakgyW9cA4oETA11nG4N1BMRKVMij4W?=
 =?us-ascii?Q?7vNrWq3s8tMg6383ezEi1uIf4o8C/1U28NrkfqWNdObaAQDbRFq3PCmASuIY?=
 =?us-ascii?Q?XKERRuQeh6XCKlQDHLb9XQ1Q7ZSvkR0/7qOL8vLhwJ0U7xvxwwGJ+K0m065t?=
 =?us-ascii?Q?2209v1DpiU3xyNwLgotESqVyDbTCvl/wgkGZSuumaU2nvHHjVbGi7xoO402B?=
 =?us-ascii?Q?6bjc9N0W7wjrmsU7XtMfGNtvknvEla3NbmpwBh8MHwpZd8VWMsNL2WPxZ+QT?=
 =?us-ascii?Q?uapObl7xk8omCETBEOpeRzHMGmdwSuum0px80k+qj2a8o9XNY9wsEQ/2cyZn?=
 =?us-ascii?Q?/27P2Cw8VYgtfQSUiCaB2UMwI7lqLXOHIy57Hrhl8DeXA3gDANqzgDN26T3f?=
 =?us-ascii?Q?0U5CKnl2ko+Uu6jUJB8ueAmFpI4jEk0pTX5k8ywOGH55DLZp9/Fipfk60Sk5?=
 =?us-ascii?Q?vESgDsRgz6ZV3dsFLkYqn3ch3Ojbfw0eKVIySdrvjw7alnLbJto4ohtH/tHq?=
 =?us-ascii?Q?RqWHAPLor4UIZ4MNBlzDCOJBzvod3slyTt2j3r7VuzA/w8j5N5ykpOymxvS/?=
 =?us-ascii?Q?Sr0m1F0ir9jWoOoyQi6B+sVlyFbEvxzw2xmQbpXYNwmOVAkD+t/3fSvNt0rG?=
 =?us-ascii?Q?ZiBlAHddR+kzd+S/u00fTi6Ngp7gjdvnck4kPm66Pvudc4n/CRk7qbq5E3g+?=
 =?us-ascii?Q?vLKKKrcOD6hwSmcFqzXG+durFgx5aaghD5y2Q9MOzBoj/ka5mwmJtNxgfgtJ?=
 =?us-ascii?Q?hSEk5GEYHgBqDl4oP74cLN5yzzM81uGUNprvT3WKqroTZWC13pM5F4DLAx0W?=
 =?us-ascii?Q?VtDutPMG6jZMxDp5X8i6F4FFUp9PHeg86OkvUoVLiJe84meqeD2uSv5Btasw?=
 =?us-ascii?Q?QSZ7omUFj3WifCFw4Z2YimlPV1XjssLLVNPYWkwBlAwH84YdWSHWpsPAWW5d?=
 =?us-ascii?Q?CEBbOiDPyIVhXl5wBthqn//3pf2RVc01ubLG088FvkI/+5jSq0Izb9Uz/DPv?=
 =?us-ascii?Q?brhTYa5qJCItov7A6Zu7ZexbIOl7SFLzw6FwsBTpsZXpsKQDFlUzZ8fCJrbI?=
 =?us-ascii?Q?csLoVOgKFUA73Sgq98tQQH2YF7xFJV3ANvzc+KFzROA+LLyOOKCBKMbIY1N2?=
 =?us-ascii?Q?L7DDBipVxGvl+SvVwbhY8H8vHYSn82bkVK4S3iA1SNzIwZvq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d82d1a-60ae-474f-1f21-08deb14b2817
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 23:55:48.5357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzSqHyZxCcRY9jyJ9EASgZNervMhvtMsLH3/tVHjAK5ShkFB3nXA9S8CUbpOjYqHipGB9qP+js8nUNjhgFi+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539
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

Hi James,

I reviewed PATCH 1/2 together with the adjacent PATCH 2/2. A couple of real=
 issues stood out on the userspace/libdrm side:
1. `amdgpu_profiler_version()` does not expose the returned version value. =
The ioctl populates `user_arg.version`, but the wrapper only returns the io=
ctl status and gives userspace no way to read the version.
2. `amdgpu_profiler_version` is missing from `amdgpu/amdgpu-symbols.txt`. P=
ATCH 2/2 adds the three new SPM symbols there, so this looks accidental.
Not sure if this is intended behavior for now.

Other than that, I did not notice anything else I would block on at this WI=
P stage.

Thanks,
Bing

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Monday, April 13, 2026 12:30 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH 1/2] amdgpu: Add profiler IOCTL interface for performance m=
onitoring

This patch introduces the foundational profiler infrastructure for AMD GPUs=
, enabling userspace access to performance monitoring capabilities includin=
g:
- Performance Monitoring Counters (PMC)
- Performance Counter Sampling (PC Sampling)
- Streaming Performance Monitor (SPM)

The implementation includes:
- New DRM_AMDGPU_PROFILER IOCTL interface with version query support
- amdgpu_profiler_version() wrapper function for userspace
- Profiler operation enumeration and argument structures in the kernel API
- Build system integration for the new profiler module

The version query operation allows userspace to determine profiler capabili=
ty and compatibility before attempting to use advanced profiling features. =
Future patches will extend this with additional profiler operations (acquir=
e, release, configure sampling buffers, etc.).

This foundation enables profiling tools and performance analysis frameworks=
 to access GPU performance data directly from userspace, supporting perform=
ance debugging and optimization workflows.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 amdgpu/amdgpu.h          |  9 ++++++++
 amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
 amdgpu/meson.build       |  2 +-
 include/drm/amdgpu_drm.h | 19 +++++++++++++++++
 4 files changed, 75 insertions(+), 1 deletion(-)  create mode 100644 amdgp=
u/amdgpu_profiler.c

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h index 53144f59..4ec1f6b6 100=
644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2120,6 +2120,15 @@ int amdgpu_userq_wait(amdgpu_device_handle dev,  int=
 amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_handle dev,
                                    uint64_t tba_addr, uint64_t tba_size,
                                    uint64_t tma_addr, uint64_t tma_size);
+
+/**
+ * Acquire profiler version
+ * \param   dev               - \c [in]     device handle
+ *
+ * \return  0 on success otherwise POSIX Error code  */ int
+amdgpu_profiler_version(amdgpu_device_handle dev);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c new file m=
ode 100644 index 00000000..8d4dffe4
--- /dev/null
+++ b/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include <string.h>
+#include <errno.h>
+#include "xf86drm.h"
+#include "amdgpu_drm.h"
+#include "amdgpu_internal.h"
+
+drm_public int
+amdgpu_profiler_version(amdgpu_device_handle dev) {
+       int ret;
+       struct drm_amdgpu_profiler_args user_arg;
+
+       if (!dev)
+               return -EINVAL;
+
+       memset(&user_arg, 0, sizeof(user_arg));
+       user_arg.op =3D AMDGPU_PROFILER_VERSION;
+
+       ret =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
+                                 &user_arg, sizeof(user_arg));
+
+       return ret;
+}
diff --git a/amdgpu/meson.build b/amdgpu/meson.build index 3962d32c..d781f2=
e9 100644
--- a/amdgpu/meson.build
+++ b/amdgpu/meson.build
@@ -27,7 +27,7 @@ libdrm_amdgpu =3D library(
     files(
       'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_device.c',
       'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_table.=
c',
-      'amdgpu_userq.c',
+      'amdgpu_userq.c', 'amdgpu_profiler.c',
     ),
     config_file,
   ],
diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h index ef12=
e725..307242ac 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL                0x17
 #define DRM_AMDGPU_USERQ_WAIT          0x18
 #define DRM_AMDGPU_CWSR                        0x20
+#define DRM_AMDGPU_PROFILER                    0x21

 #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_CWSR          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_CWSR, union drm_amdgpu_cwsr)
+#define DRM_IOCTL_AMDGPU_PROFILER      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_PROFILER, struct drm_amdgpu_profiler_args)

 /**
  * DOC: memory domains
@@ -1695,6 +1697,23 @@ struct drm_amdgpu_info_gpuvm_fault {
 #define AMDGPU_FAMILY_GC_11_5_0                        150 /* GC 11.5.0 */
 #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */

+/*
+ * Supported Profiler Operations
+ */
+enum drm_amdgpu_profiler_ops {
+       AMDGPU_PROFILER_VERSION =3D 0,
+};
+
+struct drm_amdgpu_profiler_args {
+       __u32 op;                        /* amdgpu_profiler_op */
+       union {
+           __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
+                                         * lower 16 bit: minor
+                                         * higher 16 bit: major
+                                         */
+       };
+};
+
 #if defined(__cplusplus)
 }
 #endif
--
2.34.1

