Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA74C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 09:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D7C10E23C;
	Wed,  3 Jan 2024 09:29:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F4210E225
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 09:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrRDYuQvYDl75Sk8SDHFBCB6vAxCyPsf6qb81LfZcx5SskmQ6mgmB36GkSvb2bIbaxLeXW/aWl1sqNiWnyMPonJ+WnmlicmqJPtcNsroHV/yHJ3XIUV2U/pOZLi/BgFUw+FoHOwIaCJHWoIV3x5d3YlWCxZ/7dBDFHTKBrjcPxPwAjyFM9dhELqBNCpH/WtqF/wxIKGIgKLBlqavICUSgJpTY8AMjpl1CK9L83Cn4t4+eCrT9sgpKbEeMUe5eDE8qBCVQMgYw+8KaewGy9G8JndDy4HqpgMSBoMfSKNkl2H3IPdMM98Vy4WYJNsKEJry50DNfPNv9qBfBmq4bME8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bKEtP5sTAqvToERjqyIKctR1EIbd+nvDxRjzXuKJxQ=;
 b=QseMkSq33CNsN4XEyWvjwmn7EKp95VStpzZAGNjex6Y0FkbpjLjQIOgRwUTli/K3EokT92W4TSBubBLGSo15aAs6MHNm4eWTsjU9onQNCUVrzxAf3Myidb+1NXXOpVVuvNQgH2hxY4KW1YIPGf2inCHX9nZu14GJw9rbJH2+8/FBrjMMS0TLfKXymNONfQkb0UMrF+ya/+0JMBLWzfAb6Qc3agxQJus/ZBRKJ0wxV7QqnlJIPIZeKAlCLvPLR5Amh9T9pJE5qCr8JJZUP2Ic8ERskXtZaeUZfB2+4mBjFro/hU7e6uUTzvAz0bisTmVWh52C+ilmVCK1CpyWFGYJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bKEtP5sTAqvToERjqyIKctR1EIbd+nvDxRjzXuKJxQ=;
 b=yTu5GkYY3OcF4tLFd55w9DRk8VaCqtaTFh5h6XIST9tTX9N7pWZlrgaFz3DS9EsE75VVgga+E7n9dBLTG8jduQ0vLdw78Hn7pifct7Y5BNEyiCNkEHAfTb1OpR+kUJ/+ZSeH8QUevnO8mEtbGhCb+axiT1RNQnGZZCYrNiHmhMI=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 09:28:59 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eec3:bf1c:4deb:8810]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eec3:bf1c:4deb:8810%3]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 09:28:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework
Thread-Topic: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework
Thread-Index: AQHaPhtLLn5iOkIOIkCNA8E4BZEKDLDHxG2A
Date: Wed, 3 Jan 2024 09:28:59 +0000
Message-ID: <BL1PR12MB52541DF0F27B2BD258A9FB79FC60A@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-2-kevinyang.wang@amd.com>
In-Reply-To: <20240103080220.2815115-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c75913d1-84e2-4042-836e-9a5fefd2b5d1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T08:39:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|MN0PR12MB6223:EE_
x-ms-office365-filtering-correlation-id: a8f7cb60-fae7-463a-4135-08dc0c3e6aa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /g68vfUy3PTRuYn+xILSlhBBh+ip0xcbISw2+ZIIxO0j4mWCCXXplP/tkSj1C3IbnyXKgrVmLK236bzxd7Tl3tYy1orvyl47VYCd6GtMrCgIvPsiykDrD3AWzXj2k468f0UkABsCSfCnXz/AuDf+ZTovtADj+n+q1lsqVc0fhLYeibPATXhhGvvWEpOxg6q18EdYCNJVxAJBd8cYqwv6JgqDgpxgBHsMGURcd22I/esBZs7i+XCFr+j+1mWBWsFpsyWSfNJ+PyD0UC5BJUdLXuQyCh3haa+sRLuQbDNIFyMw2PBUud9cTXT+eoWlRf4piV+y5INpc+2thvGKvKur+MqmfXEg9tgLbGAAu6HU+nW7/CX+6WOaOg5BGy20wuIWuT+sRCXPuJ/gzz2lnOdEUSrJZwXC+uAaWIFHt2/oIhxdABytRWWnlVrPDQO1+qU1KgMucaBTBlftkLk6LxEQIX2fJJcK9ANpRMfGu8ys73MFLrwd+6a5MSYvaBzXYIFDGZSYAX/Ik4bXMqAZPRF6bOO88ylvfcgDcinWku9kQTK9UJjqKrceK8OHKMxYdRf5ne29R11gMB+MM+65KzyxMA4qxBLVAyo8dMn9OxkIcnxDdNnTB9e+ZSzXLh3b2ERUimoPOvcz1ozzUM87jIpB2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(83380400001)(30864003)(5660300002)(41300700001)(38070700009)(33656002)(55016003)(86362001)(2906002)(966005)(478600001)(52536014)(110136005)(66946007)(316002)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(54906003)(8936002)(53546011)(6506007)(9686003)(4326008)(122000001)(66899024)(38100700002)(71200400001)(7696005)(21314003)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6GNefEIbNjiF+R13w3+8GE+tMSC2N6LTbAiX69gNDm3mUeW+PhzQ5amS593s?=
 =?us-ascii?Q?9EC+Elgqe7GnYFDJdfhLZ9A00YbBJfhGGGhP7m7t80V0Q2FPs9KFxe5WeaeG?=
 =?us-ascii?Q?U71KZSoO61VJRLUCexbyqHFQhoo9PT9C8H0KYtbE7wCy3xuifcjRbqIBs5TH?=
 =?us-ascii?Q?sxAUJOpp8tTJGT8Sfq2ZMrPcmjPNeB+qdfJgJxIaQ9xOqMt3BQLCjGMzqILi?=
 =?us-ascii?Q?AWLRRzoLIWU3TvfxNxJ4HCPjCGG/UnqcYkboQFay5vnALREN6hHe0BJNTyul?=
 =?us-ascii?Q?ule7whEduvXmup95mUqs25NnUvQLaMg+oDBOl7QumSnICn8eBwj/axQbLOtG?=
 =?us-ascii?Q?8+/+jfkUxYkCMDnVhPVHva66r4NnBcqLJ7B5MMpvn8fL0lMHP3Y+D1+L1C/E?=
 =?us-ascii?Q?7Nj7om1LNu/20UkIxroVHlbKNgpFNKKlKJFIlfiq0mnWzl4OpiXyAg+cMD1b?=
 =?us-ascii?Q?ytsYHUFwgz9J2AWi+DeKOq5mYfY4ydQTY/y8DS5KbMLvSNw+YyNjU3ioKXsC?=
 =?us-ascii?Q?l/VBwj7th2rT2Wb2Z9tS+JxgKwGe3jkFwjLf1kxQcpjV2aDOpp9jItjp0mKv?=
 =?us-ascii?Q?LzERZEMLL5wkZRzT5I1xtp0VBqY1eqEiPS7f8AOwg8ds/2t68ysZlTdz+GcK?=
 =?us-ascii?Q?Jtu+iOU23Y1GSBKGAralP66eMvy5bVo6FMXBHajz05rSvDjG2tvUjvNQ2qPo?=
 =?us-ascii?Q?Pnl79XgiMjP3wyz+Kv5WmN5NgZZh1gYyTdXAR7pwBXLN8sty6L7LSdRftof5?=
 =?us-ascii?Q?+1g336ReswSHXu1L5frCnkncMCIG4s8TZh98YduNq8i6z6SkpapbbBlDez4n?=
 =?us-ascii?Q?thhE4OllVgAc/6E5/c0nBWDVxHHk3Mna3Ph8N/4vzBX5UuPtUu1i/PQvFiYB?=
 =?us-ascii?Q?+N/IJZqPOp7i64UcwWw2zvSoW1ZPPkykPhuppX0PVk36ILvz1frdZCM9APY/?=
 =?us-ascii?Q?PgP7YMDnRtwvcUUuyDnauMXs7Jrc/z4yKz+6wY7fcHdJstaY+ahDAwpyztCV?=
 =?us-ascii?Q?hP92AH3ztujWuwiUJyXZ/Hhe4TJeRFfiNYZ9TcVS7vWG8j4+1CewnjfxzoiY?=
 =?us-ascii?Q?HnL7ClLO7qkF2iY/lIShaKQvm3ZmBaV9kOo8IER2bMUmqM+G9FYMV/e2xoL5?=
 =?us-ascii?Q?CsyfOj7e/qnqDPOiDbQl8ua7GJVHIjXqrIgzwPytXrlfI8/F8HfynXrL6Zkj?=
 =?us-ascii?Q?pn153QUsIqqjNVfy61onN7fVDouTfqlH/KpQALALjWr8wSuf/7eeYRzgZgrp?=
 =?us-ascii?Q?AJCHdL3egx7b94gV7Yx+4rgUHB/0xiU64pzyj7X/szTQ9ptftjD3zYtyEJJp?=
 =?us-ascii?Q?19oillUuX1LV+YMWoGEJkKwrdcPxuDQ/9/GXhNs+ELx7NNUUqMcEbAACCWxZ?=
 =?us-ascii?Q?OxtZNSH2NxT1DMaFEd6N5fP8z1apfbu7oX2dbmRwtUsvxEODiL6rLwaPYdXE?=
 =?us-ascii?Q?DDEM+V3fYqhyjIoWoYkc+GB3N5A8z2HuseGKwx0L3SmFObcasSLfPq//1WXE?=
 =?us-ascii?Q?m6mMX8JyhQNxl1iSJBSkV1ulOYjtHuHYUeia2fAXMyvqFvB2bS4DGcUSlY1w?=
 =?us-ascii?Q?kutvRh+FbApTVE5xyH1mnGtTcs8vwJk5OapPE1Gy?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB52541DF0F27B2BD258A9FB79FC60ABL1PR12MB5254namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f7cb60-fae7-463a-4135-08dc0c3e6aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 09:28:59.6110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq7pkATBMkoWawiH9v2uvJsoqb+Lv0EJNuDH2+sU9i7QTE05gqTOgmzVW26Vks0+Hcc6x+gAjeiJeDyoCn7qWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB52541DF0F27B2BD258A9FB79FC60ABL1PR12MB5254namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Please check my comments inline. I added index for each comment (9 in total=
) since it is a long thread...

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework

v1:
implement new RAS ACA driver code framework.

v2:
- rename aca_bank_set to aca_banks.
- rename aca_source_xxx to aca_handle_xxx

Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.=
com>>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c    | 679 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h    | 196 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
 6 files changed, 887 insertions(+), 1 deletion(-)  create mode 100644 driv=
ers/gpu/drm/amd/amdgpu/amdgpu_aca.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 260e32ef7bae..4c989da4d2f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amdgp=
u_kms.o \
        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
        amdgpu_fw_attestation.o amdgpu_securedisplay.o \
        amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o
+       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o

 amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 616b6c911767..9fa6f69a58a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_smuio.h"
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
+#include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
@@ -1045,6 +1046,9 @@ struct amdgpu_device {
        /* MCA */
        struct amdgpu_mca               mca;

+       /* ACA */
+       struct amdgpu_aca               aca;
+
        struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
        uint32_t                        harvest_ip_mask;
        int                             num_ip_blocks;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
new file mode 100644
index 000000000000..6a6f167b5380
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -0,0 +1,679 @@
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
+#include <linux/list.h>
+#include "amdgpu.h"
+#include "amdgpu_aca.h"
+#include "amdgpu_ras.h"
+
+#define ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWIP_TYPE_##type] =3D
+{hwid, mcatype}
+
+typedef int bank_handler_t(struct aca_handle *handle, struct aca_bank
+*bank, enum aca_error_type type, void *data);
+
+struct aca_banks {
+       int nr_banks;
+       struct list_head list;
+};
+
+struct aca_hwip {
+       int hwid;
+       int mcatype;
+};
+
+static struct aca_hwip aca_hwid_mcatypes[ACA_HWIP_TYPE_COUNT] =3D {
+       ACA_BANK_HWID(SMU,      0x01,   0x01),
+       ACA_BANK_HWID(PCS_XGMI, 0x50,   0x00),
+       ACA_BANK_HWID(UMC,      0x96,   0x00),
+};
+
+static void aca_banks_init(struct aca_banks *banks) {
+       if (!banks)
+               return;
+
+       memset(banks, 0, sizeof(*banks));
+       INIT_LIST_HEAD(&banks->list);
+}
+
+static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank
+*bank) {
+       struct aca_bank_node *node;
+
+       if (!bank)
+               return -EINVAL;
+
+       node =3D kvzalloc(sizeof(*node), GFP_KERNEL);
+       if (!node)
+               return -ENOMEM;
+
+       memcpy(&node->bank, bank, sizeof(*bank));
+
+       INIT_LIST_HEAD(&node->node);
+       list_add_tail(&node->node, &banks->list);
+
+       banks->nr_banks++;
+
+       return 0;
+}
+
+static void aca_banks_release(struct aca_banks *banks) {
+       struct aca_bank_node *node, *tmp;
+
+       list_for_each_entry_safe(node, tmp, &banks->list, node) {
+               list_del(&node->node);
+               kvfree(node);
+       }
+}
+
+static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum
+aca_error_type type, u32 *count) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
+
+       if (!count)
+               return -EINVAL;
+
+       if (!smu_funcs || !smu_funcs->get_valid_aca_count)
+               return -EOPNOTSUPP;
+
+       return smu_funcs->get_valid_aca_count(adev, type, count); }
+
+static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_error_type type,
+                                      int start, int count,
+                                      struct aca_banks *banks)
+{
+       struct amdgpu_aca *aca =3D &adev->aca;
+       const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
+       struct aca_bank bank;
+       int i, max_count, ret;
+
+       if (!count)
+               return 0;
+
+       if (!smu_funcs || !smu_funcs->get_valid_aca_bank)
+               return -EOPNOTSUPP;
+
+       switch (type) {
+       case ACA_ERROR_TYPE_UE:
+               max_count =3D smu_funcs->max_ue_aca_count;
1.      [Hawking]: %s/max_ue_aca_count/max_ue_count


+               break;
+       case ACA_ERROR_TYPE_CE:
+       case ACA_ERROR_TYPE_DEFERRED:
+               max_count =3D smu_funcs->max_ce_aca_count;
2.      [Hawking]: %s/max_ce_aca_count/max_ce_count
3.      [Hawking]: I'll suggest treating DEFERRED as default for now. (i.e.=
, not supported yet)

+               break;
+       default:
+               return -EINVAL;
+       }
+
+       if (start + count >=3D max_count)
+               return -EINVAL;
+
+       count =3D min_t(int, count, max_count);
+       for (i =3D 0; i < count; i++) {
+               memset(&bank, 0, sizeof(bank));
+               ret =3D smu_funcs->get_valid_aca_bank(adev, type, start + i=
, &bank);
+               if (ret)
+                       return ret;
+
+               ret =3D aca_banks_add_bank(banks, &bank);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum
+aca_hwip_type type) {
+
+       struct aca_hwip *hwip;
+       int hwid, mcatype;
+       u64 ipid;
+
+       if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNOW)
+               return -EINVAL;
+
+       hwip =3D &aca_hwid_mcatypes[type];
+       if (!hwip->hwid)
+               return false;
+
+       ipid =3D bank->regs[ACA_REG_IDX_IPID];
+       hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
+       mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
+
+       return hwip->hwid =3D=3D hwid && hwip->mcatype =3D=3D mcatype; }
+
+static bool aca_bank_is_valid(struct aca_handle *handle, struct
+aca_bank *bank, enum aca_error_type type) {
+       const struct aca_bank_ops *bank_ops =3D handle->bank_ops;
+
+       if (!aca_bank_hwip_is_matched(bank, handle->hwip))
+               return false;
+
+       if (!bank_ops->aca_bank_is_valid)
+               return true;
4.      [Hawking]: does it apply to the case where the valid field is not a=
vailable? Can you please elaborate why return true in such case?

+
+       return bank_ops->aca_bank_is_valid(handle, bank, type, handle->data=
);
+}
+
+static struct aca_bank_error *new_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error;
+
+       bank_error =3D kvzalloc(sizeof(*bank_error), GFP_KERNEL);
+       if (!bank_error)
+               return NULL;
+
+       INIT_LIST_HEAD(&bank_error->node);
+       memcpy(&bank_error->info, info, sizeof(*info));
+
+       mutex_lock(&aerr->lock);
+       list_add_tail(&bank_error->node, &aerr->list);
+       mutex_unlock(&aerr->lock);
+
+       return bank_error;
+}
+
+static struct aca_bank_error *find_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error =3D NULL;
+       struct aca_bank_info *tmp_info;
+       bool found =3D false;
+
+       mutex_lock(&aerr->lock);
+       list_for_each_entry(bank_error, &aerr->list, node) {
+               tmp_info =3D &bank_error->info;
+               if (tmp_info->socket_id =3D=3D info->socket_id &&
+                   tmp_info->die_id =3D=3D info->die_id) {
+                       found =3D true;
+                       goto out_unlock;
+               }
+       }
+
+out_unlock:
+       mutex_unlock(&aerr->lock);
+
+       return found ? bank_error : NULL;
+}
+
+static void aca_bank_error_remove(struct aca_error *aerr, struct
+aca_bank_error *bank_error) {
+       if (!aerr || !bank_error)
+               return;
+
+       list_del(&bank_error->node);
+       aerr->nr_errors--;
+
+       kvfree(bank_error);
+}
+
+static struct aca_bank_error *get_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error;
+
+       if (!aerr || !info)
+               return NULL;
+
+       bank_error =3D find_bank_error(aerr, info);
+       if (bank_error)
+               return bank_error;
+
+       return new_bank_error(aerr, info);
+}
+
+static int aca_error_inc_count(struct aca_error *aerr, struct
+aca_bank_info *info, u64 count) {
+       struct aca_bank_error *bank_error;
+
+       if (!info)
+               return -EINVAL;
+
+       if (!count)
+               return 0;
+
+       bank_error =3D get_bank_error(aerr, info);
+       if (!bank_error)
+               return -ENOMEM;
+
+       bank_error->count +=3D count;
+
+       return 0;
+}
+
+static int aca_log_error_report(struct aca_handle *handle, enum aca_error_=
type type,
+                               struct aca_bank_report *report)
+{
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       struct aca_error *aerr;
+
+       if (!handle || !report)
+               return -EINVAL;
+
+       aerr =3D &error_cache->errors[type];
+       return aca_error_inc_count(aerr, &report->info, report->count); }
+
5.      [Hawking]: Shall we merge the aca_error_inc_count with aca_log_erro=
r_report? if you haven't name any function as aca_log_error, then just rena=
me aca_log_error_report to aca_log_errors.

+static int aca_generate_bank_report(struct aca_handle *handle, struct aca_=
bank *bank,
+                                   enum aca_error_type type, struct aca_ba=
nk_report *report) {
+       const struct aca_bank_ops *bank_ops =3D handle->bank_ops;
+
+       if (!bank || !report)
+               return -EINVAL;
+
+       if (!bank_ops->aca_bank_generate_report)
+               return -EOPNOTSUPP;
+
+       memset(report, 0, sizeof(*report));
+       return bank_ops->aca_bank_generate_report(handle, bank, type,
+                                                 report, handle->data);
+}
+
+static int handler_aca_log_bank_error(struct aca_handle *handle, struct ac=
a_bank *bank,
+                                     enum aca_error_type type, void *data)=
 {
+       struct aca_bank_report report;
+       int ret;
+
+       ret =3D aca_generate_bank_report(handle, bank, type, &report);
+       if (ret)
+               return ret;
+
+       if (!report.count)
+               return 0;
+
+       ret =3D aca_log_error_report(handle, type, &report);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+static int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_ba=
nk *bank,
+                            enum aca_error_type type, bank_handler_t handl=
er, void *data) {
+       struct aca_handle *handle;
+       int ret;
+
+       if (list_empty(&mgr->list))
+               return 0;
+
+       list_for_each_entry(handle, &mgr->list, node) {
+               if (!aca_bank_is_valid(handle, bank, type))
+                       continue;
+
+               ret =3D handler(handle, bank, type, data);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+static int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_b=
anks *banks,
+                             enum aca_error_type type, bank_handler_t hand=
ler, void *data)
+{
+       struct aca_bank_node *node;
+       struct aca_bank *bank;
+       int ret;
+
+       if (!mgr || !banks)
+               return -EINVAL;
+
+       /* pre check to avoid unnecessary operations */
+       if (list_empty(&mgr->list) || list_empty(&banks->list))
+               return 0;
+
+       list_for_each_entry(node, &banks->list, node) {
+               bank =3D &node->bank;
+
+               ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
6.      [Hawking]: Can we merge aca_dispatch_bank with aca_dispatch_banks?

+
+static int aca_bank_update(struct amdgpu_device *adev, enum aca_error_type=
 type,
7.      [Hawking]: let's name it aca_update_banks

+                          bank_handler_t handler, void *data) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       struct aca_banks banks;
+       u32 count =3D 0;
+       int ret;
+
+       if (list_empty(&aca->mgr.list))
+               return 0;
+
+       ret =3D aca_smu_get_valid_aca_count(adev, type, &count);
+       if (ret)
+               return ret;
+
+       if (!count)
+               return 0;
+
+       aca_banks_init(&banks);
+
+       ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks);
+       if (ret)
+               goto err_release_banks;
+
+       if (list_empty(&banks.list)) {
+               ret =3D 0;
+               goto err_release_banks;
+       }
+
+       ret =3D aca_dispatch_banks(&aca->mgr, &banks, type,
+                                handler, data);
+       if (ret)
+               goto err_release_banks;
+
+err_release_banks:
+       aca_banks_release(&banks);
+
+       return ret;
+}
+
+static int aca_error_update(struct amdgpu_device *adev, enum
+aca_error_type type) {
+       return aca_bank_update(adev, type, handler_aca_log_bank_error, NULL=
);
+}
8.      [Hawking]: Shall we drop this function since it's just a wraper. It=
 seems to the caller __aca_get_error_data does have all the input parameter=
s that can feed into aca_update_banks.

+
+static int aca_log_aca_error_data(struct aca_bank_error *bank_error,
+enum aca_error_type type, struct ras_err_data *err_data) {
+       struct aca_bank_info *info;
+       struct amdgpu_smuio_mcm_config_info mcm_info;
+
+       if (!bank_error->count)
+               return 0;
+
+       info =3D &bank_error->info;
+       mcm_info.die_id =3D info->die_id;
+       mcm_info.socket_id =3D info->socket_id;
+
+       switch (type) {
+       case ACA_ERROR_TYPE_UE:
+               amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NU=
LL, bank_error->count);
+               break;
+       case ACA_ERROR_TYPE_CE:
+               amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NU=
LL, bank_error->count);
+               break;
+       case ACA_ERROR_TYPE_DEFERRED:
+       default:
+               break;
+       }
+
+       return 0;
+}
+
+static int aca_log_aca_error(struct aca_handle *handle, enum
+aca_error_type type, struct ras_err_data *err_data) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       struct aca_error *aerr =3D &error_cache->errors[type];
+       struct aca_bank_error *bank_error, *tmp;
+
+       mutex_lock(&aerr->lock);
+
+       if (list_empty(&aerr->list))
+               goto out_unlock;
+
+       list_for_each_entry_safe(bank_error, tmp, &aerr->list, node) {
+               aca_log_aca_error_data(bank_error, type, err_data);
+               aca_bank_error_remove(aerr, bank_error);
+       }
+
+out_unlock:
+       mutex_unlock(&aerr->lock);
+
+       return 0;
+}
+
+static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_han=
dle *handle, enum aca_error_type type,
+                               struct ras_err_data *err_data)
+{
+       int ret;
+
+       /* udpate aca bank to aca source error_cache first */
+       ret =3D aca_error_update(adev, type);
+       if (ret)
+               return ret;
+
+       return aca_log_aca_error(handle, type, err_data); }
+
+static bool aca_handle_is_valid(struct aca_handle *handle) {
+       if (!handle->mask || !list_empty(&handle->node))
+               return false;
+
+       return true;
+}
+
+int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handl=
e *handle,
+                             enum aca_error_type type, void *data) {
+       struct ras_err_data *err_data =3D (struct ras_err_data *)data;
+
+       if (!handle || !err_data)
+               return -EINVAL;
+
+       if (aca_handle_is_valid(handle))
+               return -EOPNOTSUPP;
+
+       if (!(BIT(type) & handle->mask))
+               return  0;
+
+       return __aca_get_error_data(adev, handle, type, err_data); }
+
+static void aca_error_init(struct aca_error *aerr, enum aca_error_type
+type) {
+       mutex_init(&aerr->lock);
+       INIT_LIST_HEAD(&aerr->list);
+       aerr->type =3D type;
+       aerr->nr_errors =3D 0;
+}
+
+static void aca_init_error_cache(struct aca_handle *handle) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       int type;
+
+       for (type =3D ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type+=
+)
+               aca_error_init(&error_cache->errors[type], type); }
+
+static void aca_error_fini(struct aca_error *aerr) {
+       struct aca_bank_error *bank_error, *tmp;
+
+       mutex_lock(&aerr->lock);
+       list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
+               aca_bank_error_remove(aerr, bank_error);
+
+       mutex_destroy(&aerr->lock);
+}
+
+static void aca_fini_error_cache(struct aca_handle *handle) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       int type;
+
+       for (type =3D ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type+=
+)
+               aca_error_fini(&error_cache->errors[type]);
+}
+
+static int add_aca_handle(struct amdgpu_device *adev, struct aca_handle_ma=
nager *mgr, struct aca_handle *handle,
+                         const char *name, const struct aca_info *ras_info=
, void *data) {
+       memset(handle, 0, sizeof(*handle));
+
+       handle->adev =3D adev;
+       handle->mgr =3D mgr;
+       handle->name =3D name;
+       handle->hwip =3D ras_info->hwip;
+       handle->mask =3D ras_info->mask;
+       handle->bank_ops =3D ras_info->bank_ops;
+       handle->data =3D data;
+       aca_init_error_cache(handle);
+
+       INIT_LIST_HEAD(&handle->node);
+       list_add_tail(&handle->node, &mgr->list);
+       mgr->nr_handles++;
+
+       return 0;
+}
+
+int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                         const char *name, const struct aca_info *ras_info=
, void *data) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       return add_aca_handle(adev, &aca->mgr, handle, name, ras_info, data=
);
+}
+
+static void remove_aca(struct aca_handle *handle) {
+       struct aca_handle_manager *mgr =3D handle->mgr;
+
+       aca_fini_error_cache(handle);
+       list_del(&handle->node);
+       mgr->nr_handles--;
+}
+
+void amdgpu_aca_remove_handle(struct aca_handle *handle) {
+       if (!handle || list_empty(&handle->node))
+               return;
+
+       remove_aca(handle);
+}
+
+static int aca_manager_init(struct aca_handle_manager *mgr) {
+       INIT_LIST_HEAD(&mgr->list);
+       mgr->nr_handles =3D 0;
+
+       return 0;
+}
+
+static void aca_manager_fini(struct aca_handle_manager *mgr) {
+       struct aca_handle *handle, *tmp;
+
+       list_for_each_entry_safe(handle, tmp, &mgr->list, node)
+               remove_aca(handle);
+}
+
+int amdgpu_aca_init(struct amdgpu_device *adev) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       int ret;
+
+       ret =3D aca_manager_init(&aca->mgr);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+void amdgpu_aca_fini(struct amdgpu_device *adev) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       aca_manager_fini(&aca->mgr);
+}
+
+void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct
+aca_smu_funcs *smu_funcs) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       WARN_ON(aca->smu_funcs);
+       aca->smu_funcs =3D smu_funcs;
+}
+
+int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info
+*info) {
+       u64 ipid;
+       u32 instidhi, instidlo;
+
+       if (!bank || !info)
+               return -EINVAL;
+
+       ipid =3D bank->regs[ACA_REG_IDX_IPID];
+       info->hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
+       info->mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
+       /*
+        * Unfied DieID Format: SAASS. A:AID, S:Socket.
+        * Unfied DieID[4:4] =3D InstanceId[0:0]
+        * Unfied DieID[0:3] =3D InstanceIdHi[0:3]
+        */
+       instidhi =3D ACA_REG__IPID__INSTANCEIDHI(ipid);
+       instidlo =3D ACA_REG__IPID__INSTANCEIDLO(ipid);
+       info->die_id =3D ((instidhi >> 2) & 0x03);
+       info->socket_id =3D ((instidlo & 0x1) << 2) | (instidhi & 0x03);
+
+       return 0;
+}
+
+static int aca_bank_get_error_code(struct amdgpu_device *adev, struct
+aca_bank *bank) {
+       int error_code;
+
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+       case IP_VERSION(13, 0, 6):
+               if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D=
 0x00555600) {
+                       error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank=
->regs[ACA_REG_IDX_SYND]);
+                       return error_code & 0xff;
+               }
+               break;
+       default:
+               break;
+       }
+
+       /* NOTE: the true error code is encoded in status.errorcode[0:7] */
+       error_code =3D
+ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
+
+       return error_code & 0xff;
+}
+
+int aca_bank_check_error_codes(struct amdgpu_device *adev, struct
+aca_bank *bank, int *err_codes, int size) {
+       int i, error_code;
+
+       if (!bank || !err_codes)
+               return -EINVAL;
+
+       error_code =3D aca_bank_get_error_code(adev, bank);
+       for (i =3D 0; i < size; i++) {
+               if (err_codes[i] =3D=3D error_code)
+                       return 0;
+       }
+
+       return -EINVAL;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.h
new file mode 100644
index 000000000000..688907270ff7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -0,0 +1,196 @@
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
+#ifndef __AMDGPU_ACA_H__
+#define __AMDGPU_ACA_H__
+
+#include <linux/list.h>
+
+#define ACA_MAX_REGS_COUNT     (16)
+
+#define ACA_REG_FIELD(x, h, l)                 (((x) & GENMASK_ULL(h, l)) =
>> l)
+#define ACA_REG__STATUS__VAL(x)                        ACA_REG_FIELD(x, 63=
, 63)
+#define ACA_REG__STATUS__OVERFLOW(x)           ACA_REG_FIELD(x, 62, 62)
+#define ACA_REG__STATUS__UC(x)                 ACA_REG_FIELD(x, 61, 61)
+#define ACA_REG__STATUS__EN(x)                 ACA_REG_FIELD(x, 60, 60)
+#define ACA_REG__STATUS__MISCV(x)              ACA_REG_FIELD(x, 59, 59)
+#define ACA_REG__STATUS__ADDRV(x)              ACA_REG_FIELD(x, 58, 58)
+#define ACA_REG__STATUS__PCC(x)                        ACA_REG_FIELD(x, 57=
, 57)
+#define ACA_REG__STATUS__ERRCOREIDVAL(x)       ACA_REG_FIELD(x, 56, 56)
+#define ACA_REG__STATUS__TCC(x)                        ACA_REG_FIELD(x, 55=
, 55)
+#define ACA_REG__STATUS__SYNDV(x)              ACA_REG_FIELD(x, 53, 53)
+#define ACA_REG__STATUS__CECC(x)               ACA_REG_FIELD(x, 46, 46)
+#define ACA_REG__STATUS__UECC(x)               ACA_REG_FIELD(x, 45, 45)
+#define ACA_REG__STATUS__DEFERRED(x)           ACA_REG_FIELD(x, 44, 44)
+#define ACA_REG__STATUS__POISON(x)             ACA_REG_FIELD(x, 43, 43)
+#define ACA_REG__STATUS__SCRUB(x)              ACA_REG_FIELD(x, 40, 40)
+#define ACA_REG__STATUS__ERRCOREID(x)          ACA_REG_FIELD(x, 37, 32)
+#define ACA_REG__STATUS__ADDRLSB(x)            ACA_REG_FIELD(x, 29, 24)
+#define ACA_REG__STATUS__ERRORCODEEXT(x)       ACA_REG_FIELD(x, 21, 16)
+#define ACA_REG__STATUS__ERRORCODE(x)          ACA_REG_FIELD(x, 15, 0)
+
+#define ACA_REG__IPID__MCATYPE(x)              ACA_REG_FIELD(x, 63, 48)
+#define ACA_REG__IPID__INSTANCEIDHI(x)         ACA_REG_FIELD(x, 47, 44)
+#define ACA_REG__IPID__HARDWAREID(x)           ACA_REG_FIELD(x, 43, 32)
+#define ACA_REG__IPID__INSTANCEIDLO(x)         ACA_REG_FIELD(x, 31, 0)
+
+#define ACA_REG__MISC0__VALID(x)               ACA_REG_FIELD(x, 63, 63)
+#define ACA_REG__MISC0__OVRFLW(x)              ACA_REG_FIELD(x, 48, 48)
+#define ACA_REG__MISC0__ERRCNT(x)              ACA_REG_FIELD(x, 43, 32)
+
+#define ACA_REG__SYND__ERRORINFORMATION(x)     ACA_REG_FIELD(x, 17, 0)
+
+/* NOTE: The following codes refers to the smu header file */
+#define ACA_EXTERROR_CODE_CE                   0x3a
+#define ACA_EXTERROR_CODE_FAULT                        0x3b
+
+#define ACA_ERROR_UE_MASK              BIT_MASK(ACA_ERROR_TYPE_UE)
+#define ACA_ERROR_CE_MASK              BIT_MASK(ACA_ERROR_TYPE_CE)
+#define ACA_ERROR_DEFERRED_MASK                BIT_MASK(ACA_ERROR_TYPE_DEF=
ERRED)
+
+enum aca_reg_idx {
+       ACA_REG_IDX_CTL                 =3D 0,
+       ACA_REG_IDX_STATUS              =3D 1,
+       ACA_REG_IDX_ADDR                =3D 2,
+       ACA_REG_IDX_MISC0               =3D 3,
+       ACA_REG_IDX_CONFG               =3D 4,
+       ACA_REG_IDX_IPID                =3D 5,
+       ACA_REG_IDX_SYND                =3D 6,
+       ACA_REG_IDX_DESTAT              =3D 8,
+       ACA_REG_IDX_DEADDR              =3D 9,
+       ACA_REG_IDX_CTL_MASK            =3D 10,
+       ACA_REG_IDX_COUNT               =3D 16,
+};
+
+enum aca_hwip_type {
+       ACA_HWIP_TYPE_UNKNOW =3D -1,
+       ACA_HWIP_TYPE_PSP =3D 0,
+       ACA_HWIP_TYPE_UMC,
+       ACA_HWIP_TYPE_SMU,
+       ACA_HWIP_TYPE_PCS_XGMI,
+       ACA_HWIP_TYPE_COUNT,
+};
+
+enum aca_error_type {
+       ACA_ERROR_TYPE_INVALID =3D -1,
+       ACA_ERROR_TYPE_UE =3D 0,
+       ACA_ERROR_TYPE_CE,
+       ACA_ERROR_TYPE_DEFERRED,
+       ACA_ERROR_TYPE_COUNT
+};
+
+struct aca_bank {
+       u64 regs[ACA_MAX_REGS_COUNT];
+};
+
+struct aca_bank_node {
+       struct aca_bank bank;
+       struct list_head node;
+};
+
+struct aca_bank_info {
+       int die_id;
+       int socket_id;
+       int hwid;
+       int mcatype;
+};
+
+struct aca_bank_report {
+       enum aca_error_type type;
+       struct aca_bank_info info;
+       u64 count;
+};
+
+struct aca_bank_error {
+       struct list_head node;
+       struct aca_bank_info info;
+       u64 count;
+};
+
+struct aca_error {
+       struct list_head list;
+       struct mutex lock;
+       enum aca_error_type type;
+       int nr_errors;
+};
+
+struct aca_handle_manager {
+       struct list_head list;
+       int nr_handles;
+};
+
+struct aca_error_cache {
+       struct aca_error errors[ACA_ERROR_TYPE_COUNT]; };
+
+struct aca_handle {
+       struct list_head node;
+       enum aca_hwip_type hwip;
+       struct amdgpu_device *adev;
+       struct aca_handle_manager *mgr;
+       struct aca_error_cache error_cache;
+       const struct aca_bank_ops *bank_ops;
+       const char *name;
+       u32 mask;
+       void *data;
+};
+
+struct aca_bank_ops {
+       int (*aca_bank_generate_report)(struct aca_handle *handle, struct a=
ca_bank *bank, enum aca_error_type type,
+                                       struct aca_bank_report *report, voi=
d *data);
+       bool (*aca_bank_is_valid)(struct aca_handle *handle, struct aca_ban=
k *bank, enum aca_error_type type,
+                                 void *data);
+};
+
+struct aca_smu_funcs {
+       int max_ue_aca_count;
+       int max_ce_aca_count;
9.      [Hawking] rename them to max_ue_count, and max_ce_count respectivel=
y

+       int (*set_debug_mode)(struct amdgpu_device *adev, bool enable);
+       int (*get_valid_aca_count)(struct amdgpu_device *adev, enum aca_err=
or_type type, u32 *count);
+       int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum
+aca_error_type type, int idx, struct aca_bank *bank); };
+
+struct amdgpu_aca {
+       struct aca_handle_manager mgr;
+       const struct aca_smu_funcs *smu_funcs; };
+
+struct aca_info {
+       enum aca_hwip_type hwip;
+       const struct aca_bank_ops *bank_ops;
+       u32 mask;
+};
+
+int amdgpu_aca_init(struct amdgpu_device *adev); void
+amdgpu_aca_fini(struct amdgpu_device *adev); void
+amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct
+aca_smu_funcs *smu_funcs);
+
+int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info
+*info); int aca_bank_check_error_codes(struct amdgpu_device *adev,
+struct aca_bank *bank, int *err_codes, int size);
+
+int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                         const char *name, const struct aca_info *aca_info=
, void *data);
+void amdgpu_aca_remove_handle(struct aca_handle *handle); int
+amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                                    enum aca_error_type type, void *data);=
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 4b694696930e..dc03643a985e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4030,6 +4030,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,

        amdgpu_device_get_pcie_info(adev);

+       r =3D amdgpu_aca_init(adev);
+       if (r)
+               return r;
+
        r =3D amdgpu_device_get_job_timeout_settings(adev);
        if (r) {
                dev_err(adev->dev, "invalid lockup_timeout parameter syntax=
\n"); @@ -4434,6 +4438,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device=
 *adev)

        amdgpu_reset_fini(adev);

+       amdgpu_aca_fini(adev);
+
        /* free i2c buses */
        if (!amdgpu_device_has_dc_support(adev))
                amdgpu_i2c_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 76fb85628716..c36faf353b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -29,6 +29,7 @@
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_aca.h"

 struct amdgpu_iv_entry;

--
2.34.1


--_000_BL1PR12MB52541DF0F27B2BD258A9FB79FC60ABL1PR12MB5254namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Please check my comments inline. I added index for each comme=
nt (9 in total) since it is a long thread&#8230;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt; <br>

Sent: Wednesday, January 3, 2024 16:02<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Wang, Yang(Kevin) &l=
t;KevinYang.Wang@amd.com&gt;<br>

Subject: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">v1:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">impl=
ement new RAS ACA driver code framework.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">v2:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- re=
name aca_bank_set to aca_banks.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- re=
name aca_source_xxx to aca_handle_xxx</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com">kevinyan=
g.wang@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 4 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.c&nbsp;&nbsp;&nbsp; | 679 ++++++++++++++=
+++++++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.h&nbsp;&nbsp;&nbsp; | 196 ++++++</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp;&nbsp; 6 +</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 6 f=
iles changed, 887 insertions(+), 1 deletion(-)&nbsp; create mode 100644 dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> cre=
ate mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/M=
akefile</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 260e32ef7bae..4c989da4d2f3 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/Makefile</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/Makefile</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
80,7 +80,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_km=
s.o \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc.o smu_v11_0_i2c.o a=
mdgpu_fru_eeprom.o amdgpu_rap.o \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fw_attestation.o amdgpu=
_securedisplay.o \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eeprom.o amdgpu_mca.o a=
mdgpu_psp_ta.o amdgpu_lsdma.o \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq=
64.o</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq=
64.o amdgpu_aca.o</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> amd=
gpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/a=
mdgpu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 616b6c911767..9fa6f69a58a7 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
107,6 +107,7 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_smuio.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_fdinfo.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_mca.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#in=
clude &quot;amdgpu_aca.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_ras.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_xcp.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_seq64.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1045,6 +1046,9 @@ struct amdgpu_device {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MCA */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mca&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mca=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ACA */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca;</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ip_block&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_blocks[AMDGPU_MAX_IP_NUM]=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; harvest_ip_mask;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_ip_b=
locks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">new =
file mode 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 000000000000..6a6f167b5380</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
/dev/null</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
0,0 +1,679 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+/*<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
Copyright 2023 Advanced Micro Devices, Inc.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
Permission is hereby granted, free of charge, to any person </span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+obt=
aining a</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
copy of this software and associated documentation files (the </span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&qu=
ot;Software&quot;),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
to deal in the Software without restriction, including without </span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+lim=
itation</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
the rights to use, copy, modify, merge, publish, distribute, </span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sub=
license,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
and/or sell copies of the Software, and to permit persons to whom </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+the=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
Software is furnished to do so, subject to the following conditions:</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
The above copyright notice and this permission notice shall be </span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+inc=
luded in</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
all copies or substantial portions of the Software.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, <=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+EXP=
RESS OR</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF </span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+MER=
CHANTABILITY,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT </s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+SHA=
LL</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, </span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+DAM=
AGES OR</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR </span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+OTH=
ERWISE,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE </span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+OR<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
OTHER DEALINGS IN THE SOFTWARE.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ */=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#in=
clude &lt;linux/list.h&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#in=
clude &quot;amdgpu.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#in=
clude &quot;amdgpu_aca.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#in=
clude &quot;amdgpu_ras.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWIP_TYPE_##type] =3D </span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{hw=
id, mcatype}</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+typ=
edef int bank_handler_t(struct aca_handle *handle, struct aca_bank </span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+*ba=
nk, enum aca_error_type type, void *data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_banks {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int nr_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_hwip {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hwid;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mcatype;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic struct aca_hwip aca_hwid_mcatypes[ACA_HWIP_TYPE_COUNT] =3D {</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_BANK_HWID(SMU,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x01,&nbsp;&nbsp; 0x01),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_BANK_HWID(PCS_XGMI, 0x50,&nbsp;&nbsp;=
 0x00),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_BANK_HWID(UMC,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x96,&nbsp;&nbsp; 0x00),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_banks_init(struct aca_banks *banks) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!banks)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(banks, 0, sizeof(*banks));</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;banks-&gt;list);</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+*ba=
nk) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_node *node;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node =3D kvzalloc(sizeof(*node), GFP_KERN=
EL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!node)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -ENOMEM;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;node-&gt;bank, bank, sizeof(*=
bank));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;node-&gt;node);</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;node-&gt;node, &amp;ba=
nks-&gt;list);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; banks-&gt;nr_banks++;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_banks_release(struct aca_banks *banks) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_node *node, *tmp;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(node, tmp, &amp;=
banks-&gt;list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; list_del(&amp;node-&gt;node);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; kvfree(node);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum </span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_error_type type, u32 *count) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_smu_funcs *smu_funcs =3D=
 aca-&gt;smu_funcs;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_funcs || !smu_funcs-&gt;get_vali=
d_aca_count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_funcs-&gt;get_valid_aca_count(=
adev, type, count); }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_er=
ror_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int s=
tart, int count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t aca_banks *banks)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_smu_funcs *smu_funcs =3D=
 aca-&gt;smu_funcs;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank bank;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, max_count, ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_funcs || !smu_funcs-&gt;get_vali=
d_aca_bank)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR_TYPE_UE:</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; max_count =3D smu_funcs-&gt;max_ue_aca_count;</span></font></div>
<ol style=3D"margin:0;padding-left:36pt;list-style-type:decimal;">
<font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"font-siz=
e:11pt;">
<li><b>[Hawking]: %s/max_ue_aca_count/max_ue_count</b></li></span></font>
</ol>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR_TYPE_CE:</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR_TYPE_DEFERRED:</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; max_count =3D smu_funcs-&gt;max_ce_aca_count;</span></font></div>
<ol start=3D"2" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"font-siz=
e:11pt;">
<li><b>[Hawking]: %s/max_ce_aca_count/max_ce_count</b></li><li><b>[Hawking]=
: I</b><b>&#8217;ll </b><b>suggest </b><b>treating</b><b> DEFERRED as defau=
lt for now. (i.e., not supported </b><b>yet</b><b>)</b></li></span></font>
</ol>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (start + count &gt;=3D max_count)</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D min_t(int, count, max_count);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; count; i++) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; memset(&amp;bank, 0, sizeof(bank));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D smu_funcs-&gt;get_valid_aca_bank(adev, type, start + i, &amp=
;bank);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D aca_banks_add_bank(banks, &amp;bank);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum </span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_hwip_type type) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_hwip *hwip;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hwid, mcatype;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 ipid;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || type =3D=3D ACA_HWIP_TYPE_UN=
KNOW)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwip =3D &amp;aca_hwid_mcatypes[type];</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwip-&gt;hwid)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return false;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipid =3D bank-&gt;regs[ACA_REG_IDX_IPID];=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwid =3D ACA_REG__IPID__HARDWAREID(ipid);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcatype =3D ACA_REG__IPID__MCATYPE(ipid);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwip-&gt;hwid =3D=3D hwid &amp;&am=
p; hwip-&gt;mcatype =3D=3D mcatype; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic bool aca_bank_is_valid(struct aca_handle *handle, struct </span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_bank *bank, enum aca_error_type type) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_bank_ops *bank_ops =3D h=
andle-&gt;bank_ops;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aca_bank_hwip_is_matched(bank, handl=
e-&gt;hwip))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return false;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_ops-&gt;aca_bank_is_valid)</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return true;</span></font></div>
<ol start=3D"4" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"font-siz=
e:11pt;">
<li><b>[Hawking]: </b><b>does it apply to the case where the valid field is=
 not available? </b><b>Can you </b><b>please elaborate why return true in s=
uch case?</b></li></span></font>
</ol>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bank_ops-&gt;aca_bank_is_valid(han=
dle, bank, type, handle-&gt;data); </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic struct aca_bank_error *new_bank_error(struct aca_error *aerr, </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank_info *info) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_error *bank_error;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank_error =3D kvzalloc(sizeof(*bank_erro=
r), GFP_KERNEL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_error)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return NULL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;bank_error-&gt;node);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;bank_error-&gt;info, info, si=
zeof(*info));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;aerr-&gt;lock);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;bank_error-&gt;node, &=
amp;aerr-&gt;list);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;aerr-&gt;lock);</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bank_error;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic struct aca_bank_error *find_bank_error(struct aca_error *aerr, </span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank_info *info) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_error *bank_error =3D NUL=
L;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_info *tmp_info;</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool found =3D false;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;aerr-&gt;lock);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(bank_error, &amp;aerr=
-&gt;list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; tmp_info =3D &amp;bank_error-&gt;info;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (tmp_info-&gt;socket_id =3D=3D info-&gt;socket_id &amp;&amp;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_info-&gt;die_id =3D=3D info-&gt;die_id) =
{</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found =3D true;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock;</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+out=
_unlock:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;aerr-&gt;lock);</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return found ? bank_error : NULL;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_bank_error_remove(struct aca_error *aerr, struct </span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_bank_error *bank_error) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aerr || !bank_error)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;bank_error-&gt;node);</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aerr-&gt;nr_errors--;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(bank_error);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic struct aca_bank_error *get_bank_error(struct aca_error *aerr, </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank_info *info) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_error *bank_error;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aerr || !info)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return NULL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank_error =3D find_bank_error(aerr, info=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bank_error)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return bank_error;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return new_bank_error(aerr, info);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_error_inc_count(struct aca_error *aerr, struct </span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_bank_info *info, u64 count) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_error *bank_error;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!info)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank_error =3D get_bank_error(aerr, info)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_error)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -ENOMEM;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank_error-&gt;count +=3D count;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_log_error_report(struct aca_handle *handle, enum aca_error_type=
 type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_report *report)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_error_cache *error_cache =3D &=
amp;handle-&gt;error_cache;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_error *aerr;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle || !report)</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aerr =3D &amp;error_cache-&gt;errors[type=
];</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_error_inc_count(aerr, &amp;rep=
ort-&gt;info, report-&gt;count); }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<ol start=3D"5" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"font-siz=
e:11pt;">
<li><b>[H</b><b>awking</b><b>]</b><b>: Shall we merge the aca_error_inc_cou=
nt with </b><b>aca_log_error_report</b><b>?</b><b> if you haven&#8217;t nam=
e any function as aca_log_error, then just rename aca_log_error_report to a=
ca_log_errors. </b></li></span></font>
</ol>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_generate_bank_report(struct aca_handle *handle, struct aca_bank=
 *bank,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error_type typ=
e, struct aca_bank_report *report) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_bank_ops *bank_ops =3D h=
andle-&gt;bank_ops;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || !report)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_ops-&gt;aca_bank_generate_repor=
t)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(report, 0, sizeof(*report));</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bank_ops-&gt;aca_bank_generate_rep=
ort(handle, bank, type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; report, handle=
-&gt;data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int handler_aca_log_bank_error(struct aca_handle *handle, struct aca_ba=
nk *bank,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_er=
ror_type type, void *data) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_report report;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_generate_bank_report(handle, =
bank, type, &amp;report);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!report.count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_log_error_report(handle, type=
, &amp;report);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_bank *=
bank,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum aca_error_type type, bank_handler_t handler, void *data) {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle *handle;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;mgr-&gt;list))</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(handle, &amp;mgr-&gt;=
list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (!aca_bank_is_valid(handle, bank, type))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D handler(handle, bank, type, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_banks=
 *banks,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum aca_error_type type, bank_handler_t handler, void *dat=
a) </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_node *node;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank *bank;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mgr || !banks)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pre check to avoid unnecessary operati=
ons */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;mgr-&gt;list) || list=
_empty(&amp;banks-&gt;list))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(node, &amp;banks-&gt;=
list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; bank =3D &amp;node-&gt;bank;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<ol start=3D"6" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"font-siz=
e:11pt;">
<li><b>[Hawking]: </b><b>Can we merge </b><b>aca_dispatch_bank</b><b> with =
aca_dispatch_banks?</b></li></span></font>
</ol>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_bank_update(struct amdgpu_device *adev, enum aca_error_type typ=
e,</span></font></div>
<ol start=3D"7" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"font-siz=
e:11pt;">
<li><b>[Hawking]:</b><b> let&#8217;s name it aca_update_banks</b></li></spa=
n></font>
</ol>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ba=
nk_handler_t handler, void *data) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_banks banks;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 count =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;aca-&gt;mgr.list))</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_smu_get_valid_aca_count(adev,=
 type, &amp;count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_banks_init(&amp;banks);</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_smu_get_valid_aca_banks(adev,=
 type, 0, count, &amp;banks);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;banks.list)) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_dispatch_banks(&amp;aca-&gt;m=
gr, &amp;banks, type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+err=
_release_banks:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_banks_release(&amp;banks);</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_error_update(struct amdgpu_device *adev, enum </span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_error_type type) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_bank_update(adev, type, handle=
r_aca_log_bank_error, NULL); </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<ol start=3D"8" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"font-siz=
e:11pt;">
<li><b>[Hawking]</b><b>: Shall we drop this function since it&#8217;s just =
a wr</b><b>aper. It seems to the caller </b><b>__aca_get_error_data</b><b> =
does have all the input parameters </b><b>that can feed into aca_update_ban=
ks.</b></li></span></font>
</ol>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_log_aca_error_data(struct aca_bank_error *bank_error, </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+enu=
m aca_error_type type, struct ras_err_data *err_data) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_info *info;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_smuio_mcm_config_info mcm_i=
nfo;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_error-&gt;count)</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;bank_error-&gt;info;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcm_info.die_id =3D info-&gt;die_id;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcm_info.socket_id =3D info-&gt;socket_id=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR_TYPE_UE:</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_ras_error_statistic_ue_count(err_data, &amp;mcm_info, NULL, b=
ank_error-&gt;count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR_TYPE_CE:</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_ras_error_statistic_ce_count(err_data, &amp;mcm_info, NULL, b=
ank_error-&gt;count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR_TYPE_DEFERRED:</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_log_aca_error(struct aca_handle *handle, enum </span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_error_type type, struct ras_err_data *err_data) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_error_cache *error_cache =3D &=
amp;handle-&gt;error_cache;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_error *aerr =3D &amp;error_cac=
he-&gt;errors[type];</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_error *bank_error, *tmp;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;aerr-&gt;lock);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;aerr-&gt;list))</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto out_unlock;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(bank_error, tmp,=
 &amp;aerr-&gt;list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_log_aca_error_data(bank_error, type, err_data);</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_bank_error_remove(aerr, bank_error);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+out=
_unlock:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;aerr-&gt;lock);</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle =
*handle, enum aca_error_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data *err_data)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* udpate aca bank to aca source error_ca=
che first */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_error_update(adev, type);</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_log_aca_error(handle, type, er=
r_data); }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic bool aca_handle_is_valid(struct aca_handle *handle) {</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle-&gt;mask || !list_empty(&amp;=
handle-&gt;node))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return false;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h=
andle,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum aca_error_type type, void *data) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data *err_data =3D (struct=
 ras_err_data *)data;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle || !err_data)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aca_handle_is_valid(handle))</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(BIT(type) &amp; handle-&gt;mask))</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return&nbsp; 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return __aca_get_error_data(adev, handle,=
 type, err_data); }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_error_init(struct aca_error *aerr, enum aca_error_type </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+typ=
e) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;aerr-&gt;lock);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;aerr-&gt;list);</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aerr-&gt;type =3D type;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aerr-&gt;nr_errors =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_init_error_cache(struct aca_handle *handle) {</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_error_cache *error_cache =3D &=
amp;handle-&gt;error_cache;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int type;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (type =3D ACA_ERROR_TYPE_UE; type &lt=
; ACA_ERROR_TYPE_COUNT; type++)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_error_init(&amp;error_cache-&gt;errors[type], type); }</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_error_fini(struct aca_error *aerr) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_error *bank_error, *tmp;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;aerr-&gt;lock);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(bank_error, tmp,=
 &amp;aerr-&gt;list, node)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_bank_error_remove(aerr, bank_error);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;aerr-&gt;lock);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_fini_error_cache(struct aca_handle *handle) {</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_error_cache *error_cache =3D &=
amp;handle-&gt;error_cache;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int type;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (type =3D ACA_ERROR_TYPE_UE; type &lt=
; ACA_ERROR_TYPE_COUNT; type++)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_error_fini(&amp;error_cache-&gt;errors[type]);</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int add_aca_handle(struct amdgpu_device *adev, struct aca_handle_manage=
r *mgr, struct aca_handle *handle,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const ch=
ar *name, const struct aca_info *ras_info, void *data) {</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(handle, 0, sizeof(*handle));</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;adev =3D adev;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;mgr =3D mgr;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;name =3D name;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;hwip =3D ras_info-&gt;hwip;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;mask =3D ras_info-&gt;mask;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;bank_ops =3D ras_info-&gt;bank=
_ops;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;data =3D data;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_init_error_cache(handle);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;handle-&gt;node);</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;handle-&gt;node, &amp;=
mgr-&gt;list);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mgr-&gt;nr_handles++;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handl=
e,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const ch=
ar *name, const struct aca_info *ras_info, void *data) {</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return add_aca_handle(adev, &amp;aca-&gt;=
mgr, handle, name, ras_info, data); </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void remove_aca(struct aca_handle *handle) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle_manager *mgr =3D handle=
-&gt;mgr;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_fini_error_cache(handle);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;handle-&gt;node);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mgr-&gt;nr_handles--;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+voi=
d amdgpu_aca_remove_handle(struct aca_handle *handle) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle || list_empty(&amp;handle-&gt=
;node))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove_aca(handle);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_manager_init(struct aca_handle_manager *mgr) {</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;mgr-&gt;list);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mgr-&gt;nr_handles =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_manager_fini(struct aca_handle_manager *mgr) {</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle *handle, *tmp;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(handle, tmp, &am=
p;mgr-&gt;list, node)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; remove_aca(handle);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_aca_init(struct amdgpu_device *adev) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_manager_init(&amp;aca-&gt;mgr=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+voi=
d amdgpu_aca_fini(struct amdgpu_device *adev) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_manager_fini(&amp;aca-&gt;mgr);</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+voi=
d amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_smu_funcs *smu_funcs) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(aca-&gt;smu_funcs);</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca-&gt;smu_funcs =3D smu_funcs;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+*in=
fo) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 ipid;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 instidhi, instidlo;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || !info)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipid =3D bank-&gt;regs[ACA_REG_IDX_IPID];=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;hwid =3D ACA_REG__IPID__HARDWARE=
ID(ipid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;mcatype =3D ACA_REG__IPID__MCATY=
PE(ipid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unfied DieID Format: SAASS. A:AID=
, S:Socket.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unfied DieID[4:4] =3D InstanceId[=
0:0]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unfied DieID[0:3] =3D InstanceIdH=
i[0:3]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instidhi =3D ACA_REG__IPID__INSTANCEIDHI(=
ipid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instidlo =3D ACA_REG__IPID__INSTANCEIDLO(=
ipid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;die_id =3D ((instidhi &gt;&gt; 2=
) &amp; 0x03);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;socket_id =3D ((instidlo &amp; 0=
x1) &lt;&lt; 2) | (instidhi &amp; 0x03);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_bank_get_error_code(struct amdgpu_device *adev, struct </span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_bank *bank) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int error_code;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_HWIP,=
 0)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp; adev-&gt;pm.fw_ver=
sion &gt;=3D 0x00555600) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_code =3D ACA_R=
EG__SYND__ERRORINFORMATION(bank-&gt;regs[ACA_REG_IDX_SYND]);</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return error_code &a=
mp; 0xff;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* NOTE: the true error code is encoded i=
n status.errorcode[0:7] */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_code =3D </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ACA=
_REG__STATUS__ERRORCODE(bank-&gt;regs[ACA_REG_IDX_STATUS]);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return error_code &amp; 0xff;</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 aca_bank_check_error_codes(struct amdgpu_device *adev, struct </span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_bank *bank, int *err_codes, int size) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, error_code;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || !err_codes)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_code =3D aca_bank_get_error_code(ad=
ev, bank);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; size; i++) {</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (err_codes[i] =3D=3D error_code)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_aca.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">new =
file mode 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 000000000000..688907270ff7</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
/dev/null</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
0,0 +1,196 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+/*<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
Copyright 2023 Advanced Micro Devices, Inc.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
Permission is hereby granted, free of charge, to any person </span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+obt=
aining a</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
copy of this software and associated documentation files (the </span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&qu=
ot;Software&quot;),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
to deal in the Software without restriction, including without </span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+lim=
itation</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
the rights to use, copy, modify, merge, publish, distribute, </span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sub=
license,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
and/or sell copies of the Software, and to permit persons to whom </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+the=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
Software is furnished to do so, subject to the following conditions:</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
The above copyright notice and this permission notice shall be </span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+inc=
luded in</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
all copies or substantial portions of the Software.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, <=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+EXP=
RESS OR</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF </span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+MER=
CHANTABILITY,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT </s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+SHA=
LL</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, </span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+DAM=
AGES OR</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR </span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+OTH=
ERWISE,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE </span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+OR<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ * =
OTHER DEALINGS IN THE SOFTWARE.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ */=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#if=
ndef __AMDGPU_ACA_H__</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine __AMDGPU_ACA_H__</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#in=
clude &lt;linux/list.h&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_MAX_REGS_COUNT&nbsp;&nbsp;&nbsp;&nbsp; (16)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG_FIELD(x, h, l)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((x) &amp; GENMASK_ULL(h,=
 l)) &gt;&gt; l)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__VAL(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 63, 63)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__OVERFLOW(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 62, 62)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__UC(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 61, 61)</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__EN(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 60, 60)</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__MISCV(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 59, 59)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__ADDRV(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 58, 58)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__PCC(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 57, 57)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__ERRCOREIDVAL(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
CA_REG_FIELD(x, 56, 56)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__TCC(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 55, 55)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__SYNDV(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 53, 53)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__CECC(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 46, 46)</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__UECC(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 45, 45)</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__DEFERRED(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 44, 44)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__POISON(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 43, 43)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__SCRUB(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 40, 40)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__ERRCOREID(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ACA_REG_FIELD(x, 37, 32)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__ADDRLSB(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 29, 24)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__ERRORCODEEXT(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
CA_REG_FIELD(x, 21, 16)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__STATUS__ERRORCODE(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ACA_REG_FIELD(x, 15, 0)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__IPID__MCATYPE(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 63, 48)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__IPID__INSTANCEIDHI(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ACA_REG_FIELD(x, 47, 44)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__IPID__HARDWAREID(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 43, 32)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__IPID__INSTANCEIDLO(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ACA_REG_FIELD(x, 31, 0)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__MISC0__VALID(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 63, 63)</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__MISC0__OVRFLW(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 48, 48)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__MISC0__ERRCNT(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 43, 32)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_REG__SYND__ERRORINFORMATION(x)&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIE=
LD(x, 17, 0)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+/* =
NOTE: The following codes refers to the smu header file */</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_EXTERROR_CODE_CE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3a</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_EXTERROR_CODE_FAULT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0x3b</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_ERROR_UE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; BIT_MASK(ACA_ERROR_TYPE_UE)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_ERROR_CE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; BIT_MASK(ACA_ERROR_TYPE_CE)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine ACA_ERROR_DEFERRED_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT_MASK(ACA_ERROR_TYPE_DEFERRE=
D)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+enu=
m aca_reg_idx {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CTL&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_STATUS&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1,</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_ADDR&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 2,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_MISC0&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3,</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CONFG&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4,</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_IPID&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 5,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_SYND&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 6,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DESTAT&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 8,</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DEADDR&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 9,</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CTL_MASK&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 10,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_COUNT&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 16,</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+enu=
m aca_hwip_type {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_UNKNOW =3D -1,</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_PSP =3D 0,</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_UMC,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_SMU,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_PCS_XGMI,</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_COUNT,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+enu=
m aca_error_type {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_INVALID =3D -1,</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_UE =3D 0,</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_CE,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_DEFERRED,</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_COUNT</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 regs[ACA_MAX_REGS_COUNT];</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank_node {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank bank;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head node;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank_info {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int die_id;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int socket_id;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hwid;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mcatype;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank_report {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error_type type;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_info info;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank_error {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head node;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_info info;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_error {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex lock;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error_type type;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int nr_errors;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_handle_manager {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int nr_handles;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_error_cache {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_error errors[ACA_ERROR_TYPE_CO=
UNT]; };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_handle {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head node;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_hwip_type hwip;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle_manager *mgr;</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_error_cache error_cache;</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_bank_ops *bank_ops;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mask;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank_ops {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*aca_bank_generate_report)(struct ac=
a_handle *handle, struct aca_bank *bank, enum aca_error_type type,</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct aca_bank_report *report, void *data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*aca_bank_is_valid)(struct aca_hand=
le *handle, struct aca_bank *bank, enum aca_error_type type,</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_smu_funcs {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_ue_aca_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_ce_aca_count;</span></font></div>
<ol start=3D"9" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"font-siz=
e:11pt;">
<li><b>[Hawking]</b><b> rename them to max_ue_count, and max_ce_count respe=
ctively</b></li></span></font>
</ol>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_debug_mode)(struct amdgpu_devic=
e *adev, bool enable);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_valid_aca_count)(struct amdgpu_=
device *adev, enum aca_error_type type, u32 *count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_valid_aca_bank)(struct amdgpu_d=
evice *adev, enum </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_error_type type, int idx, struct aca_bank *bank); };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct amdgpu_aca {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle_manager mgr;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_smu_funcs *smu_funcs; };=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_info {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_hwip_type hwip;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_bank_ops *bank_ops;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mask;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_aca_init(struct amdgpu_device *adev); void </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+amd=
gpu_aca_fini(struct amdgpu_device *adev); void </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+amd=
gpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct </span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_smu_funcs *smu_funcs);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+*in=
fo); int aca_bank_check_error_codes(struct amdgpu_device *adev, </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct aca_bank *bank, int *err_codes, int size);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handl=
e,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const ch=
ar *name, const struct aca_info *aca_info, void *data); </span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+voi=
d amdgpu_aca_remove_handle(struct aca_handle *handle); int </span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+amd=
gpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handl=
e,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error_ty=
pe type, void *data); #endif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 4b694696930e..dc03643a985e 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
4030,6 +4030,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_get_pcie_info(ad=
ev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_aca_init(adev);</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_get_job_ti=
meout_settings(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid lockup_timeout parame=
ter syntax\n&quot;); @@ -4434,6 +4438,8 @@ void amdgpu_device_fini_sw(struc=
t amdgpu_device *adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_fini(adev);</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_aca_fini(adev);</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free i2c buses */</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_has_dc_supp=
ort(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_i2c_fini(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 76fb85628716..c36faf353b46 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
29,6 +29,7 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;ta_ras_if.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_ras_eeprom.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_smuio.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#in=
clude &quot;amdgpu_aca.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> str=
uct amdgpu_iv_entry;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BL1PR12MB52541DF0F27B2BD258A9FB79FC60ABL1PR12MB5254namp_--
