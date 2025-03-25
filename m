Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7577AC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 04:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121E010E376;
	Tue, 25 Mar 2025 04:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aH/XWKDR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5ED10E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 04:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR4nm+Syy+4y0EG/Cl5PTobDP4BI9IR7umV/rlSvn58QSbl2JPp4ADOcmxTkm6KAZt4ThDD5kSOHEB1k71sMHb5TTkKZnKHT07v93HsJLpAoM95z7o5FEcHb1poRyllrhCIgp8zj1GnVVsOsM89CABmcEzrCKSaMMlobk/VVzEvhcHBbQFuXJ+4m3FGcuQ6NPQVSE5kv5mFkCWueCs23wN52mZpx+s6e7iX1DczTvCNoeGzjcmKlVCmw3K9B7+NlucV/dBFJ8SpqeR25y9ZTU5yOzIpdAlwz05RnLdZv2PSAPiPbnuL6XrLzFZYAreZjjcJn5TpAwU/vLA4ur9NWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNbmsXE75qkK2NNKvywnoDot6lk+LyPn3+4sWAMFMmc=;
 b=R/gSTWzSWTeCYTZ8XPI3y6Ej7CG713z7OLXylvOPLXxA7a5FR2z95vPZybCzXoIdgtiPlj3xOp2CxkBIjLfZC7m03fSyRyJVt4Fx7n5nUcJHo7twmmcy3gVY6OXTKIVNlRnw31rRRGy39rD/EyxccWE+qreprWjc5mXXinvQUaSCl5cO/mecX1Ozmv//OBXlCTDwXOi2RLXm2T364kHhzMyZBGU1H2WSn5Pvp9+YYCY3CgtMwtZp3x85OgcXtn5bZm9dQrA0+b1nZBWJKvy1ojas/8d/RXdKQNF9vzvwT0yqvAD63Hl84FrMq9V2nH/rj5ZqidXNziIyZOI1A3Xozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNbmsXE75qkK2NNKvywnoDot6lk+LyPn3+4sWAMFMmc=;
 b=aH/XWKDRSw0WwTol98F8FZqdm/VkD5MMup5Bo0/wvxImymfans8uHHJYF9oaIVfAO7NCpdFCQjJZiCe9M27vCc5bwi41uEvc2JLFwh/G4Mj1exv96JRkb/IRaqmwuKzj7uV6B7SeHXLgDRdskQk2tU4sC5ThvzL5rHb0QJSuGh8=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:33:16 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 04:33:16 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
CC: "Gao, Likun" <Likun.Gao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: make ip map init to common function
Thread-Topic: [PATCH 1/2] drm/amdgpu: make ip map init to common function
Thread-Index: AQHbnTpLomX0gf1EhU2WmHcvpP/j/LODPAog
Date: Tue, 25 Mar 2025 04:33:15 +0000
Message-ID: <DM4PR12MB51811D8049151A7BA2E77DF8EFA72@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20250325035850.2440725-1-likun.gao@amd.com>
In-Reply-To: <20250325035850.2440725-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6662cc23-0848-41d2-845e-210f12b58744;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-25T04:06:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY1PR12MB9673:EE_
x-ms-office365-filtering-correlation-id: 03356afe-8f9a-483a-ef29-08dd6b562952
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sAlCOWfMM5cPrrjg6q8mK31LmU9dmOBgsTSkL6n8P1XNd8Gyt3+PkLpv9aR/?=
 =?us-ascii?Q?+vZWgAnNCIFr9FdYewlaJ8b0O0yNGt57SZpulclHzxW+loCAMURH0eN8vnXV?=
 =?us-ascii?Q?fJQIbR3Rn0pb3Toyfc58v79/8wnw/ycQFMqH/4aqzkOHeO6LvO92BMKsZEJY?=
 =?us-ascii?Q?ahVEtV4FuVqt6K6HflgVtqcDCJhJZn0whP8Q1fF1q4JnZ/f+tng3rH+czLV1?=
 =?us-ascii?Q?wdIyI8siHmczoRzTnxcD5TqVjCznZZf+pnd78Bjj0UL5RvLHCOm7gIjg/oJS?=
 =?us-ascii?Q?Bj6sH9+HT2qvu5uNxMKG2XIg4w3LkswVSPAvGOACw8lVRMZCfA8/p5mkr+wL?=
 =?us-ascii?Q?FHsQHjx6DOQdimhWEHp7jdDcV96yEzZZmd6yG27aM4rmPCmTNsBoFDHuxLcu?=
 =?us-ascii?Q?zE0cHBB5Q9yiY5QUm5n7VdEAeeAdPiS0ooe+Zfastvg3z+zSxgeaN2spi1BI?=
 =?us-ascii?Q?6etc+EbuJrg01iUxpl1aigGF/tiy256qu8VRtgez2Q8pEry+/quiNUL71FoK?=
 =?us-ascii?Q?J2wQ9kUZUE7kgrjU9B28+mSXoGAjj0Hlsslp3Ffos1g8KzOfL8WAuWKKt0Hs?=
 =?us-ascii?Q?V5L0JUTYg3lMHQ/U0jG2IQyN0WGrxAH58CDaC3enn9sY5nkIAUvxc1qII5+z?=
 =?us-ascii?Q?1VghkwxXwclhPHoZAnS0iQdCnmnh/i4bXkzErwG4tODnaQfkJJ4apQ9fW5Dk?=
 =?us-ascii?Q?diQ68RTdiavtLLU9FVBnYmB6j0Gu3NC3WHiweezpcuK7xVf07GHDq938Pf+H?=
 =?us-ascii?Q?chGeWmiQjgb8dkareJ1qjOPf5QK/s5eOBZPOojPwCq18Rgs14qy/jLnQg2C/?=
 =?us-ascii?Q?jgyyY4AjOuN/gGc2baN4EB17q3Q7HReRDT5i9DX9KyMR8CbxaA24tomNvVTK?=
 =?us-ascii?Q?Sz1JT1uzPb71o3bQ2q7nZ8SVMQU4O3MnS2f2FZ99UD47hI85V6Y+jIHcrC7Z?=
 =?us-ascii?Q?aG5ZIVr+N0jb0I/U41RAwSC48MDXMlh6V5R7JFRGXnI5015P3HwLa4a33a+4?=
 =?us-ascii?Q?3BGXDw0lSowJMyOZQ4G0kXP0o22mcZ72BCPpWxLMdrTWb/dokKuA80Hv57RK?=
 =?us-ascii?Q?g/ZlLJCpRFsUB3ZB4Orjn2Qncwab/NfRaG6ffrRsePqdn0/bRkS2FdKovUdI?=
 =?us-ascii?Q?UNsGLyLr9ljguMk4N36hof7sjx7rw14ZJvHY9oOL/UR0xcQpvTY2XwxsfHEF?=
 =?us-ascii?Q?bdBPVBTTK3jNgnPOgeiaEzxVex1k/7GGpIrhxBST+JLLJ6x+TlD5mIiem9id?=
 =?us-ascii?Q?6mfSQVrvGuq9vWTPZN8xq/oEkHN9tWuDBc7orubMQ+diocS3gj+P0HDTWDAD?=
 =?us-ascii?Q?slwhWHuv3+2eAkwFtcPCqldLcT8Zf42sNKe9LiP5egfbuC3tcReY5S3h7AJ1?=
 =?us-ascii?Q?gOYePKFj5wa70ENW958qLl6ew6IN6ip/VKFfS1KR41WQGpxVJT712V8KoOY3?=
 =?us-ascii?Q?ocj9q/HaIFCoNKwb1tu6CvzNzWFJJ1O4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hpiGPvSbe9S4Gakyxdf/BNEGZrtfNLPNPyvbyw4ypqnJnersj/DhNPMEqwTl?=
 =?us-ascii?Q?6p4uPXU1V7XdO/gQgQnYhMfDOW10be1rCFNB0Bi6eyqQzu/Z1HlkN/tODhaX?=
 =?us-ascii?Q?ry+0d23RPn/nvJ4VXVLK2NdTtIdfWAcD9vH7zPgAbUCJyZcwQAgDidIVXb/b?=
 =?us-ascii?Q?BW7NWgNy510Pp9DHHw4CY3MYBEcAnkJdDucSpP6Ym+Ka1/0qY88VyMB6/Y3K?=
 =?us-ascii?Q?yWP8efqgI3H7znoe5M+vjffeddQsOrD5aUgl0BYbsBbw9NIo7IUWpb9DBoKc?=
 =?us-ascii?Q?SjqqDdQbnhSf5AdTvCd1PdRUvBoc6T4YCYlnkUSQGj8aeLD6lEOQl3gKyZ16?=
 =?us-ascii?Q?4c3Snl9z7GoJ3SIZUnWlYFPqcFWKAuJizMlHl7PWXLn7ZSenAcdxvdMCeSCt?=
 =?us-ascii?Q?maAoOF5KpdywfgE6Y4qw0vnkjdPxA4Jdz7WjXtDJiq4w+PkHN1PxQp58CZ8K?=
 =?us-ascii?Q?k4Iiam7kcl/iOdvIzKvW5ymHz8KZtNRCmVDmfF2CIawvXSR+CL+5Pc/2I76E?=
 =?us-ascii?Q?+KCa9V/nhXL7xQUIO9hcmTcamBSaZMxXDgRzCcuaeQ51X0VKcB/4hXgScp3Y?=
 =?us-ascii?Q?9bfT9x4jHRaojyifoKNl0OPfH5ZR/LVRaCHGT0wsrArz57pyT3JmCuNn9z2H?=
 =?us-ascii?Q?FGCpSLvKOPt1GJTN8SFr0txqp9YmhBuvPHT0O6wwfgGEDgTTECj7dFRlplOa?=
 =?us-ascii?Q?CYS5Fo0GzG3AEKZoB9zvqBBP1JyPFHwfzmDw3yc5PaBLJqDhaTDy1BcW2Msh?=
 =?us-ascii?Q?dDF9M0Gg0EzrVFaiZeNyKOh1Lcr0GbrLe2qM1ulsX0I8fzP7nH20sQFf+irY?=
 =?us-ascii?Q?JVbtAXLmD3AQLFvkfEU/yQMEsPfwqJ1OXriAiWjumN3iTGo4qpoKKGqMDvHs?=
 =?us-ascii?Q?23Js8YA2Y0iiweDNlhae1vE7gqcuXKkML4ogI3rN3wtzSMOiiApvYeNMBnrT?=
 =?us-ascii?Q?3w5v8L+maNEzy0lHkJ/f70lTcoXuydrXdZKnwmSqXYCBEACdSkPvMjO93JoM?=
 =?us-ascii?Q?TiQL9AJz5Xm/FlbfcgkpTEHTdUyDepkjWeZZJH4fkACorH6AiSUYMt8aN7Yp?=
 =?us-ascii?Q?61kKgwIs5ruqO4Pfmlm0QEXUp4pGXHgtygefsnPi1Clz/NSfzE+FIAyuoE8M?=
 =?us-ascii?Q?h9nuDr+0zqvHCnN3BTP/iGSmC6lt/6Jc0Asi8/GW+K/NTHz8E4xw9WNmx1r8?=
 =?us-ascii?Q?5JCA41hPf87EUdNrkB2jfqaXofxiSOPCfjEc3npWexzOszcTJ/iXKdhPI4hc?=
 =?us-ascii?Q?wuI6jBgtQ2rVQWsb4f7XqFP1MmFynS1cLWY9FKPI+oByiSHHydiURIlPyFlF?=
 =?us-ascii?Q?IHDLuNy/ig+awje24m6V97EFwnmMSRwvIZB2C3D4RI8Ie4h8TvKQKhLI3bDB?=
 =?us-ascii?Q?nn9AXOmdD09vlV/mjmfP3X/Olv8kseFayREZA64PTazCoWymGe2yDdW/ZCuZ?=
 =?us-ascii?Q?nCpp+PtdQLD3fGgQzY5kDWMyS2feFk7PqLyuHxKLch+TvHxWUkYAFwwWstuI?=
 =?us-ascii?Q?8UgVoAiBYdQkHgNYa+Q/oW16n0cuy0IUBvkxPQy1V9cD7dHbot/mk9kl8d/J?=
 =?us-ascii?Q?+AfZSQM3Y/pU20j+zwM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03356afe-8f9a-483a-ef29-08dd6b562952
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 04:33:16.0666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QSyhzhIyXO0KXLWVjdvatgwwHfGzibq0Ndx7vWFYrGFdJIASYGQ+l/HMZmd85E4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673
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

From: Likun Gao <Likun.Gao@amd.com>

IP instance map init function can be an common function instead of operatio=
n on different ASIC.
V2: Create amdgpu_ip.[ch] file for ip related functions.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 96 ++++++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ip.h | 29 ++++++++
 3 files changed, 126 insertions(+), 1 deletion(-)  create mode 100644 driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ip.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index ff210241bc72..4293069924cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -66,7 +66,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amdgp=
u_kms.o \
        amdgpu_fw_attestation.o amdgpu_securedisplay.o \
        amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
        amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_d=
ev_coredump.o \
-       amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_cper.o
+       amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_cper.o amdgpu_i=
p.o

 amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ip.c
new file mode 100644
index 000000000000..fc6787d87fcf
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "amdgpu_ip.h"
+
+static int8_t amdgpu_logical_to_dev_inst(struct amdgpu_device *adev,
+                                        enum amd_hw_ip_block_type block,
+                                        int8_t inst)
+{
+       int8_t dev_inst;
+
+       switch (block) {
+       case GC_HWIP:
+       case SDMA0_HWIP:
+       /* Both JPEG and VCN as JPEG is only alias of VCN */
+       case VCN_HWIP:
+               dev_inst =3D adev->ip_map.dev_inst[block][inst];
+               break;
+       default:
+               /* For rest of the IPs, no look up required.
+                * Assume 'logical instance =3D=3D physical instance' for a=
ll configs. */
+               dev_inst =3D inst;
+               break;
+       }
+
+       return dev_inst;
+}
+
+static uint32_t amdgpu_logical_to_dev_mask(struct amdgpu_device *adev,
+                                        enum amd_hw_ip_block_type block,
+                                        uint32_t mask)
+{
+       uint32_t dev_mask =3D 0;
+       int8_t log_inst, dev_inst;
+
+       while (mask) {
+               log_inst =3D ffs(mask) - 1;
+               dev_inst =3D amdgpu_logical_to_dev_inst(adev, block, log_in=
st);
+               dev_mask |=3D (1 << dev_inst);
+               mask &=3D ~(1 << log_inst);
+       }
+
+       return dev_mask;
+}
+
+static void amdgpu_populate_ip_map(struct amdgpu_device *adev,
+                                         enum amd_hw_ip_block_type ip_bloc=
k,
+                                         uint32_t inst_mask)
+{
+       int l =3D 0, i;
+
+       while (inst_mask) {
+               i =3D ffs(inst_mask) - 1;
+               adev->ip_map.dev_inst[ip_block][l++] =3D i;
+               inst_mask &=3D ~(1 << i);
+       }
+       for (; l < HWIP_MAX_INSTANCE; l++)
+               adev->ip_map.dev_inst[ip_block][l] =3D -1; }
+
+void amdgpu_ip_map_init(struct amdgpu_device *adev) {
+       u32 ip_map[][2] =3D {
+               { GC_HWIP, adev->gfx.xcc_mask },
+               { SDMA0_HWIP, adev->sdma.sdma_mask },
+               { VCN_HWIP, adev->vcn.inst_mask },
+       };
+       int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(ip_map); ++i)
+               amdgpu_populate_ip_map(adev, ip_map[i][0], ip_map[i][1]);
+
+       adev->ip_map.logical_to_dev_inst =3D amdgpu_logical_to_dev_inst;
+       adev->ip_map.logical_to_dev_mask =3D amdgpu_logical_to_dev_mask; }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ip.h
new file mode 100644
index 000000000000..2490fd322aec
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_IP_H__
+#define __AMDGPU_IP_H__
+
+void amdgpu_ip_map_init(struct amdgpu_device *adev);
+
+#endif /* __AMDGPU_IP_H__ */
--
2.34.1

