Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D78AC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 05:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED9110E02A;
	Tue, 25 Mar 2025 05:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gAHKJMY8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A435210E02A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 05:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5m4J3QeJLp4toXD+e63CZxFj4uIa+uBXmAdLufmTvMpopblLJ5VDWut/MvbZihXjPI/WXX8XUk3ItKsCUIRfbY+Hqt1AVSraedmRVRVaTTEcUb7eSkB1IYg1ru/C2zVGtSoZm+ZP7WCkx3IKSVN0ndwko1+tV2SnV53segnP9TI2vLIYRAe5Zpgc09IndxOoCiyvhETJKnkHKho036HcZOCyn0SkokiWFjjehzd8Mysr83DFiGFzDaSTnfkLndqqZRsVFwfG+Rfb+ghbNN1UBf9txE+j3vMRCp9EQ7CVBoxW6inhtQHWTEYvlJ3CwMnY3K7R9Yfa79VwdpALg32Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux5LTEbh++UzoUZInC0oWbdq5Y7Mlj/kcks4FxLfVNk=;
 b=rcq0o+gwXXRptI6jQbUmqy2ZM2cAkACTA5EeM0jirKET0unzu88+NqfWM93aGMkl2nyc59703OoWgVauxGbM+Szpedui7qd9cw4moEVJhVPPPGthfOLRlruRoErW8ii+SB+zc3PdrRXOPLPOEx125mwKC9OgCbH3ESlO5dnjqkUPvku3yXYcNLCTXTL0ZJzGENBrEomAhRaTpNlo5iFF3fvmcDh2z6cUyq0iYOewPDju043D52Qh9Pur+MUDx/uWfVo+V+SWIsAwY/0A9brEdrrQCcHAXjW4iUEdZFocz1qrIsTGjKdWVeE0tHD7PgEPQ5wET8z/40rtjUo7dvWT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux5LTEbh++UzoUZInC0oWbdq5Y7Mlj/kcks4FxLfVNk=;
 b=gAHKJMY8wtKAV1L2oFCs6EMFZ3ijrpLxP4qpw+3NW0MJ5FkZhKMlUck9tcV63zSTsIsfP+DLl8BrSD8M2WyAv1p0XDgyEPMklG3fg3awq+p0wz45xNoBz254bQ1ZOUdMoC6KLkTBkj3VXB4LSViLDtGoMgyk5nyFZZi0D17/CJw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 05:30:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 05:30:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
CC: "Gao, Likun" <Likun.Gao@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: make ip map init to common function
Thread-Topic: [PATCH 1/2] drm/amdgpu: make ip map init to common function
Thread-Index: AQHbnTpLomX0gf1EhU2WmHcvpP/j/LODPAoggAAXZJA=
Date: Tue, 25 Mar 2025 05:30:17 +0000
Message-ID: <BN9PR12MB525733AACC06775C3DFF7131FCA72@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250325035850.2440725-1-likun.gao@amd.com>
 <DM4PR12MB51811D8049151A7BA2E77DF8EFA72@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51811D8049151A7BA2E77DF8EFA72@DM4PR12MB5181.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL4PR12MB9479:EE_
x-ms-office365-filtering-correlation-id: 3e27ae72-b05d-42dd-21af-08dd6b5e2099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?p0Y6to4EfBrEj6D+EQXWsSnOyK+n8qUQmrxuKJsY7tKWJ0HQ50bVzR4jL6Lb?=
 =?us-ascii?Q?9cOZ0Qv+kjOaiyO6EugrlEIcbZg9qWlI+hIXxzAsdvD9at1ch7F0iw+IMBv6?=
 =?us-ascii?Q?4I2ch4FZ/kEnCcuYcaDVExuqs9wMFvV0dWK0TYZwCpmlbKXjnuzqf4MSYec5?=
 =?us-ascii?Q?vck/4dGYkL2jtNs59JYMDQMPxntE9ectKjqLE47Icn2OHSlT66OjsiDuYFOs?=
 =?us-ascii?Q?vWAbJQv0NZGbGJHSRGkjR6vaTHMU4/g+ZmWvyDCnbrR+CSVAXK+oI25aa/Ih?=
 =?us-ascii?Q?L6veMfmUgYtNe/atQXayloi7RVG+tK5r6/DZkkZvwnV90kAk3TGl0t5iu6nB?=
 =?us-ascii?Q?VOxx+X+eYMgiYHjEWBRK+RuT2s8Z/byZbmZfMgNR1oNhbS35rpiqt/Q36DHU?=
 =?us-ascii?Q?cECipBXp0aTHy4sEfXf8gHZnDZtV8ch3Ydd13fJMToydPylWTE0nDW+QPb/m?=
 =?us-ascii?Q?i5m5fDr1Zkj+thv4ZUMET1yrs0Zpq7WpDYwddtlVz4BryxGW0hqeLG6oHB1O?=
 =?us-ascii?Q?PugPruqy8FjNby8T+dikbi8b+BdfRcg8H0c7hJ0iEG7QDRALP4DtT2cjH5qs?=
 =?us-ascii?Q?xlge4dZev54fThtHvsM2LgutMm5udSEQB1oYz6b9H72V+zKka34R2jBeyvnF?=
 =?us-ascii?Q?EA0MuCFGKtA+JT2+e5bhR97YzhEN4jk2dENELWfAG6F9E2OOGt39SE0JnNGA?=
 =?us-ascii?Q?BGFkffiBUFhrKl6eLUi0woDy90dkK7PI0vvnUoBQ2ZCvkf631yG6ygLAioJH?=
 =?us-ascii?Q?s21pwlIPuxinCc3ceSPlRIQL/r+bZuw7+7uOQa6096/eXPSvMGDlgSJ5zZoi?=
 =?us-ascii?Q?7rPhT4BX/Xm5XzrCCz/CMxnvi9GgjPey/YiSVb/mHYxk9/1AWRKlx4JlEm+S?=
 =?us-ascii?Q?d7xf6DQteApQUWiBmXuj2WhDgfjn5RQxa6zD0J5mG2ydCGJ8ajooVzeMGqKl?=
 =?us-ascii?Q?V9ucHzZ+cZiA/W+aqpbmseIhcQkTB93zjtotpujgGGMLU5VJZ3HM45fdUehC?=
 =?us-ascii?Q?SoVodZnRLrs7VYO33XdFB/k06LZRYTiablq3tFCSnWlycbAPjePx1/dtAyO4?=
 =?us-ascii?Q?MGvgaN3wUpealYcN09fDhlT8/PZ+y4ZdsoaDjRG1v4D0KWb03QaNcWrMacR+?=
 =?us-ascii?Q?Sast0mfXEGXQIwwO8aDu61o9Ceo19K4ybChAVCTsoW41aXl9IwjY0Z+tbaKf?=
 =?us-ascii?Q?AcxJ7dA/uVjJn8mZSSQXy+AX8js1X2ny+NRSLKizhiyahcpa+ceIiKQd86ES?=
 =?us-ascii?Q?RYXYQryjhAGFCo/mgCOVD+B/6JqJ1GaaHaT08MZN0OUadA6YFMLy8wmr12+x?=
 =?us-ascii?Q?nGj3rvQqmVlLl9MxN14pfLNgvBx4rQbMIEKOseURfisPOa0M0yjC6q5PvH90?=
 =?us-ascii?Q?Vds+qnUL5MqoWr5gn0AcfzE604bRxNAyjReuN9yjM2jPHyyF28CZ22qaCNmb?=
 =?us-ascii?Q?zzDAAbGz7TD1mjqaHEYG/SrqYX4WB0NE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bm5+HDFG/labMEnpps6YPKd66/DypKeGIzRyinstyoWgItWmZl4l+U1ZeZxO?=
 =?us-ascii?Q?nfrOVVt5ADXfBN/ZaPGtpt2NUf56dYZ63Ei94yeVckfw9C1BNrLAmjYNVTuv?=
 =?us-ascii?Q?/RwrZe/KwMWsxT2P0rZhRAngoW7DWqL4t4ZHCfEBPih0HxX5YbWrZHvpl+8r?=
 =?us-ascii?Q?zPkZLOau6hfpzOZOTjGUedq55VK/kH2FSwJ3MX+m5l4sPi38O6eVoM7oeWim?=
 =?us-ascii?Q?hWhxpThIQ9ADWhDCcevjfQtQzApGXe06CSWT//em+ojA3q7YigI8n2Sk1pwU?=
 =?us-ascii?Q?PHUy4GXN+/FRxuCgPATsGkKjNlQ/Mem+KnhH1oKcV9Mi2hsTgFsIOwBsEbs7?=
 =?us-ascii?Q?Z7PMbl/1NVTcwwBDD90ciCKBSLNJFh9l29lovgi5OqC9N2HChAcXmWAJWg3o?=
 =?us-ascii?Q?5pCvflX4gheInln7yG+iT3UtAI7b4xv/Qlzkqe5NZne711B65TnuzJ1sRV4c?=
 =?us-ascii?Q?1RrrXzh0pxp56wpmrGHRigxJpjhVeZogjZ0hrZOGrJApNZQRFQM1lovLw1Bg?=
 =?us-ascii?Q?h/1nCcWYoNCrONzlYqNgQAbPbRL9ZJNwx6m7YWkp8B7qkuRaqszx4/oK9Qq9?=
 =?us-ascii?Q?fwA6kNyErsh5Jnv9nKvdE08L1blTkg97kKVVnRFr1X2V+rI09jmfONfpcmky?=
 =?us-ascii?Q?S/vvs+heVjrfofhibTQ/qlEJvYs58gtGzKkhaqxb8HK9vi1DoFTgCWcee4kA?=
 =?us-ascii?Q?RFrnZ2z4jFON3fCbMhDWmDHdr7xdBzjhStSFIZ2dtrmtQmPmX/YABLJYLVrx?=
 =?us-ascii?Q?NR+WxYHuF4d/GS+OWMKvw1TZxwhqJzMEyCKIcXBqbT64DrFEYi/BSkuEDNO2?=
 =?us-ascii?Q?ZoTE6UNf+6LAvqnBReHwA39gOxyBXWRv3nsmSFX2AUDNR9fT47uTVpSktVAt?=
 =?us-ascii?Q?ya9oFaLDNvpn/jhuuKrvTlKbCKAbK7ZzKioldqkyYV7LHHwaUYa0lfXBuCC0?=
 =?us-ascii?Q?icQuatw0FS/i3UdGKYKot2yVgF8wjBwUfrL/zZx2tnDC06efdCOLYDuSD7EJ?=
 =?us-ascii?Q?bqA9ckM5YIj2VwBVePNMen8buqAFoFe5/bxFu0AHgVl4RmgUf6Fdfrjt9PdP?=
 =?us-ascii?Q?qZhqHLwHvXah+GzzskbgsMbhAoozifetwrQ+OSkb+04+riqSaSr4W77o8AiA?=
 =?us-ascii?Q?IVwHxsESRZ7cmbWzHC4ECHNxXuZpoFM3P35WHa+uonC3OKiykHmb+VavvZ3p?=
 =?us-ascii?Q?UCq0W9TEf+cTvwH6xhuwdUXgRtdGGEakrUi6d1BqV07glqJZn+4yZoofzrln?=
 =?us-ascii?Q?+Dpt8UjfjD2rz4o3X7FPbfFhVWByeuU9/3g4rQi4y1DqF/rc/e7IkeWTrEwD?=
 =?us-ascii?Q?rDS5zt9oPVgN2UIBIg8cK2tiY2J9tP4tZp28lIqXJnmBrjlZM7dYXUmwrQLk?=
 =?us-ascii?Q?A1VjMf0KEOTcLFoqQDv970beW/HOB/iPaTx0SH5gd7zih76BaPi6MpvjGEg9?=
 =?us-ascii?Q?l6EQgVneygyO6qpGchtZu8mIRNspzqApJUQCyWtO7pDvC7swb2SYXSNgDRpL?=
 =?us-ascii?Q?tbVe/2X3UDScVxOnQCBzHLHFf//H6BvLoDOYB/m91gWF8n+ElonWArPyAZiv?=
 =?us-ascii?Q?qrHnWQxAaFhGAG6Xkzx6A4GT0grZ3Lqr+aOhE7y+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e27ae72-b05d-42dd-21af-08dd6b5e2099
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 05:30:17.4379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNujLLFw5PYNsLIVN+3neQlbO5SCo5YJqDbMbJR3TB599hRgMdIMXFnhbuht27X+wZX10P9BzjqQTa2A4If0XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gao, Lik=
un
Sent: Tuesday, March 25, 2025 12:33
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: make ip map init to common function

[AMD Official Use Only - AMD Internal Distribution Only]

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
+       amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_cper.o
+ amdgpu_ip.o

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
+                                        int8_t inst) {
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
+                                        uint32_t mask) {
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
+                                         uint32_t inst_mask) {
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
+               amdgpu_populate_ip_map(adev, ip_map[i][0],
+ ip_map[i][1]);
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

