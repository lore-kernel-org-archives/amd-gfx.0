Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EF5FF8864
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C18C10EA03;
	Tue, 28 Apr 2026 03:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dN23dHx7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA62710EA03
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTkjEvcGwFiBG660myOH0UhbPb/S9Q5pJ3w/JGJGbgcb+rMR8RLwmIrVW6hl7IezaEJR8BdEHrmbqfiuVHKoXZOGH9B50EFp+UYQSNiaVVeKujAvAUhCOS8lWAKa9aEae7O//1pVna5QYQyprJWvTc+s0umegdfJJolREuwWh+Zjhqf8Cfd7w9DTcuG5zUHd7Nz342ayGKHN+4KuMlsFvj8nwgpd07zb1iG14UaFdSh8QRQNGkGY2NDGo0Xbk0k1sWzSFpRnxdXQSIb8YhSRWAWm8+famuSIxQfWwUMs1+qeqUyDJuSRzvPx0VG7gj/ovoGtcltAJwkTTsEQAqeW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6xVmmcNabj1lQ0u4wEIuL/PWBY1YO7Zsmi/NflHdEc=;
 b=Zb5JZ3PvVPga+TYj9gZrQLrucJ15GpqCXRzCItNKhQ1xmzgBolWL9ljuLBWs+JzDRDdPiXYoMIDJCKrqDH1nOwRBEWNTgor1NZXl7iq/Ro/BZGw27076A4ADLlu+1k+Ut+3NRdfaXShOEmtPLpQHcEobgY3SA3Lc14ulO/VG1cif6zSgDqzu0WNLD104f1YEzjn8tRiwO2oAqPMVJDtSw0NrrEB5zyObAcLEkDSY966ktWr+IYdHFw7aoMUTxBMTS1D6rxnqKLXIxctnd44l0F/u4CjuQ4agr6eVhB2JzxBO+2C3ZvTjkZOB/bM+yMTfy0BXscDiZpBl7p+NcXPxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6xVmmcNabj1lQ0u4wEIuL/PWBY1YO7Zsmi/NflHdEc=;
 b=dN23dHx7ooouF0SpCa6D0cMcU8U04A/c+ECMKU6hUJGsxPsebUTiGbBv9VKyIRYn2yt8RYyG9UWV90EMrcZQ9YLMjFza1KuSUJ0gYxs1naGCLkdiXjiICS+RPUOhCJlK/dbIi/TUWkDKNh4N7hlFjPYpQA3ZSsVNLJMsXg2Zhp4=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:11:28 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:11:28 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 02/17] drm/amdgpu: add profiler manager initialization
 and release
Thread-Topic: [PATCH v2 02/17] drm/amdgpu: add profiler manager initialization
 and release
Thread-Index: AQHcu9QU9RybQrgEQkih+SG3YvN7u7X0Abbw
Date: Tue, 28 Apr 2026 03:11:28 +0000
Message-ID: <BY5PR12MB41792E6DD829B085F4555FD9FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-3-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-3-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:11:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: 015ee6f2-14f9-4f93-5653-08dea4d3d6f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18096099003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: au3ldpfjqF35jwyHFWrybX25ROnZwQHHr2O3P9IxSpAIPLEFf3ozmCFjeZ3bywwcgP8jkHicuoFhcilHGXrW7XCtvl2a6ckP3pvGNmMD1XSpsMX3AUD/S2AV2M3t5BakPtaoQO6CH2tVIDdRhUum9SoyDpvZiT9Rz2vfe6SsSnBpM4H51ewQgnYgG1OAhIM5WFmFGhH7r0wJysRsOaN2sQn84XxxvejWu86qdtNGRFEBC5JCRW8pAlcA/2zZ42NqnCE9upaXyfgaQZs1CBamZwLz2ilaGU4FXS6ogovCmxzJsaK1MACpn51fmJ6UFOcS4MVCuhLUHCQePlEsbZCzisoDv3j3SURMSyL2McmPgtq7N30l3QN84zLhMpkkvWe6JDtsfigEgHjbqiCxG7I09MyPraG3g/iboZCmhijRlE79pGWRbdDnSwUgMLqoK7VNtKIT+emIinlNo2zCbaVZPrjnUugVoq1slTwpkLnzfWySzRJe+/Mc4R69Zv8OOQP8Uh3nSSlJkuUlzeQm224jqgbqGVIcQUdilZ3dLiI9FF19f58a8BETntewneFXKp3VWawug8/fWj4d6EJVS8cB2BNhnwTZJ9IMY9TqYzHo50JsYfW+QlWFCm72YVG1gE7EjeSOEZT6ll9CE7GXGdD/zMjz+vFoyFiDkpsHCgk6rJRODSzNslIsfJkrkBINkWXWO0eEI+9K9gtcNp1XGCo4U++GVBsg4DqL1Xv3Hc6OxYjOy0YNW3RIe8saJx/vWvO8li6nPDILu8lniCkNglyoyGgGPJtGjNs65/VKWjcah6E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18096099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y1M/ryngLJCjoJjlNPOo6Q8B66Pygo5lF7VJiV65K+QBIb2B6tzziu81sGIk?=
 =?us-ascii?Q?JlLi9qEYxEOCeCl5AJTelaJ5BgtZaOmRm5Un7xqYQS7J9+hukPWyfTQ7J/rv?=
 =?us-ascii?Q?88kjOjughqwQTpnW0VYRUtdu5RSRoh+MbIQsWAunTTMRfzZANFnxiZFMsbxO?=
 =?us-ascii?Q?nb9PW354FGH7QI9pwjUSi7nPYirvpalWTnfnBXwNGPlSRWA8Zf3KoIYbWicz?=
 =?us-ascii?Q?nJp6lxMRxdzdf8Ei5KOAZYRzcVxpoj3/rhjuPG/1SWXdfJTojYrXZtfysbUI?=
 =?us-ascii?Q?+L416cxm5xTK0o6kdVkNjaNVzXx/f/unAO4NA7QHppsTRORIdCaafJNQ8NXb?=
 =?us-ascii?Q?x3a89fScSejxonoQmHlPvYpbLOsEahHbbEq7I3oiMkXzdnyatRBKf9DEjg7z?=
 =?us-ascii?Q?pZyh0nNmh0yWLdvrGwkOlFHM1swez7c33faZkxhhO7p4xvDD7us3egWYw7V6?=
 =?us-ascii?Q?Gholy9EcFMqpU6Uzu2XFrGhVpQqMb3Ci59W5ky7yqptTjy4IaVpzoPoiAZ52?=
 =?us-ascii?Q?PYZcDxWHoFRviHuzxsG+ST2yw+DfKmIpTyMicm5cDB7qtOJ+JE7+ZWcneLQu?=
 =?us-ascii?Q?tWwkeMvJMgzO/YV4GTgdtrwJjl2vhvl9Fth7laXa3NkPzyT1OV0uH9WRUpFX?=
 =?us-ascii?Q?9Xmkhly+/wp6EXRKTfo6XNWMpBNnkuc8gOET/ouKHcPquho6YgH5r2Gp1s7g?=
 =?us-ascii?Q?+dSI1HiVJoe8maeaupQpMy434NOlWGsDiclVF37xIFSdOcNczSLb60r5+TIR?=
 =?us-ascii?Q?KobkI9qYoeiHruOO8rbAYy8PHCjuiHxr5pl1aiCTBIntgxn+bpYkXeBniqL/?=
 =?us-ascii?Q?ZEClooCfjPBl596q/NTaZ7QilhFuiA/wm1qzMXFEYarR7Dcxc5P11NOCIQAY?=
 =?us-ascii?Q?Z0npMHifJq2KCTMK3BmkTwmvemsJrijc3ZH8WVFOujn2BKIOM1KLDNlisKiZ?=
 =?us-ascii?Q?FrCEnp935Xj1f2opnDL8SK0SKixjeo+yUAtECE6rJ2XNDedfO4G35dEktLEO?=
 =?us-ascii?Q?0XFbojaFFBfwYhVrWMIVWigDK1VGGxLcjpali3s8W5E9+x0UZnBVDfru3EhI?=
 =?us-ascii?Q?TUcm4iS3CGgkvYgf5aIumSFfS02d8NbEeM6ZLWvdc4uIGFxDZC7pxEsu/fQe?=
 =?us-ascii?Q?PZcGxgPBqym2fJjqavpUB8TIG0qNKZABm7irXPUhlwgkHL6QAh3vVJXCbMk3?=
 =?us-ascii?Q?GhLn80aIeX8gpNbk17h1Vk8K5qr/fqo0WeVlNF8S6ahtoze3huszWHQp4ZfK?=
 =?us-ascii?Q?v5Ww3MwVuWtPZlI3IrA2RsRaDiymVu3ADmcwDDeCtsoNYZALvGn5Ef3/DIkS?=
 =?us-ascii?Q?vIZ5QsbeVK9J57ZrZvBkpyftwz1C8khpPuxgwKTFuQuqktTIpILPsDA4zFi/?=
 =?us-ascii?Q?i6JhJQ86kGIGOrZ8vqJdIKIgDRy5kjdeM72eeh5KMJ3UJlrHOUZQoWRa4CP7?=
 =?us-ascii?Q?f9vRGb28vZT4JGbdjMOZ/4a7rP1REFYdZnaYNljzw7MtzZpyqJRSyPdcsVBA?=
 =?us-ascii?Q?v4XXh9cmvhU7Yoael0K6/ddlKlQ6nw+JZZBeI2w6uBLr3iVU6CR+KPtmariL?=
 =?us-ascii?Q?HCdH1W/m//+etLvB5xJOtxAyrxgtWviXfaImqM5Pw/Qjjomx0XHrPikCHbus?=
 =?us-ascii?Q?gOfKL0T/rUQoZ9qR7cONcwesxVLHjBzivXXuRg1XIbkkbAvKqrAB2DIq3f0l?=
 =?us-ascii?Q?U9ucvWiWXncEGv0xXE3oSalLddCerXg4y3q7LDoAl/nYsqJv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015ee6f2-14f9-4f93-5653-08dea4d3d6f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:11:28.4323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MxwEYFXtUxvUzU6rc1x5g/lVFc4IVKkWsrXhewz6dcxz08rUeBlDk3ax2KQb+EXGJlJwG2+nWofsGh8wOpc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 02/17] drm/amdgpu: add profiler manager initialization a=
nd release

to introduce the profiler manager infrastructure needed to support per-proc=
ess GPU hardware profiling features such as SPM and PCS.

Two new files are added:
- amdgpu_profiler.c/.h: define struct amdgpu_profiler_mgr, which
  holds an array of per-XCP partition managers (amdgpu_profiler_xcp_mgr),
  each reference-counted via kref and protected by a dedicated mutex.

A device-level struct amdgpu_profiler_mgr prof_mgr is embedded in struct am=
dgpu_device and its top-level mutex is initialized during amdgpu_device_ini=
t().

The per-XCP profiler manager is initialized lazily on the first
amdgpu_driver_open_kms() call for a given XCP partition:
- If the XCP manager is already initialized, only the kref is
  incremented.
- On file close (amdgpu_drm_release()), the kref is decremented and
  the per-XCP manager is destroyed (mutex destroyed, is_init cleared)
  when the last user releases it.

Non-partitioned devices uses XCP partition 0. Initialization is skipped whe=
n fpriv->xcp_id is AMDGPU_XCP_NO_PARTITION, which indicates the device has =
not yet been fully initialized.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 89 ++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 48 +++++++++++
 7 files changed, 148 insertions(+), 1 deletion(-)  create mode 100644 driv=
ers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 3b563c73bb66..74abc061cd4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -67,7 +67,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amdgp=
u_kms.o \
        amdgpu_fw_attestation.o amdgpu_securedisplay.o \
        amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
        amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_d=
ev_coredump.o \
-       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_i=
p.o  amdgpu_cwsr.o
+       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_i=
p.o  amdgpu_cwsr.o \
+       amdgpu_profiler.o

 amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 116e509e7bed..7c18640ddb59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -109,6 +109,7 @@
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_profiler.h"
 #include "amdgpu_eviction_fence.h"
 #include "amdgpu_ip.h"
 #if defined(CONFIG_DRM_AMD_ISP)
@@ -1252,6 +1253,8 @@ struct amdgpu_device {

        struct amdgpu_uma_carveout_info uma_info;

+       struct amdgpu_profiler_mgr      prof_mgr;
+
        /* KFD
         * Must be last --ends in a flexible-array member.
         */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b5a5b1670fe4..09ea4f1d7e33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4448,6 +4448,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        mutex_init(&adev->gfx.userq_sch_mutex);
        mutex_init(&adev->gfx.workload_profile_mutex);
        mutex_init(&adev->vcn.workload_profile_mutex);
+       mutex_init(&adev->prof_mgr.mutex);

        amdgpu_device_init_apu_flags(adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 5e784d4de81b..52423c98ebf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2955,6 +2955,7 @@ static int amdgpu_drm_release(struct inode *inode, st=
ruct file *filp)
                fpriv->evf_mgr.fd_closing =3D true;
                amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
                amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+               amdgpu_profiler_mgr_fini(fpriv_to_prof_mgr(fpriv), fpriv);
                drm_dev_exit(idx);
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 24ecdee0d735..ead67b4c54a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1626,6 +1626,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, s=
truct drm_file *file_priv)
                        dev_dbg(adev->dev, "cwsr trap not enabled");
        }

+       r =3D amdgpu_profiler_mgr_init(fpriv_to_prof_mgr(fpriv), fpriv);
+       if (r)
+               DRM_WARN("Can't setup profiler\n");
+
        r =3D amdgpu_eviction_fence_init(&fpriv->evf_mgr);
        if (r)
                goto error_vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_profiler.c
new file mode 100644
index 000000000000..d2cf0520c6f1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
+ */
+
+#include "amdgpu.h"
+
+/*
+ * Profiler revision change log
+ *
+ * 1.1 - Initial revision
+ */
+
+#define AMDGPU_PROFILER_VERSION_MAJOR 1 #define
+AMDGPU_PROFILER_VERSION_MINOR 1
+
+int amdgpu_profiler_mgr_init(
+               struct amdgpu_profiler_mgr *prof_mgr,
+               struct amdgpu_fpriv *fpriv)
+{
+       struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+       struct amdgpu_device *adev =3D fpriv_to_adev(fpriv);
+
+       if (fpriv->xcp_id =3D=3D AMDGPU_XCP_NO_PARTITION)
+               return 0;
+
+       mutex_lock(&prof_mgr->mutex);
+
+       prof_xcp_mgr =3D &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
+       if (prof_xcp_mgr->is_init) {
+               kref_get(&prof_xcp_mgr->ref);
+               mutex_unlock(&prof_mgr->mutex);
+               return 0;
+       }
+
+       dev_dbg(adev->dev, "Initialize profiler on render node %d xcp %d",
+               adev->ddev.render->index, fpriv->xcp_id);
+       kref_init(&prof_xcp_mgr->ref);
+       mutex_init(&prof_xcp_mgr->mutex);
+       prof_xcp_mgr->xcp_id =3D fpriv->xcp_id;
+
+       prof_xcp_mgr->is_init =3D true;
+
+       mutex_unlock(&prof_mgr->mutex);
+       return 0;
+}
+
+static void amdgpu_profiler_mgr_release(struct kref *ref) {
+       struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =3D
+               container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
+
+       mutex_destroy(&prof_xcp_mgr->mutex);
+       prof_xcp_mgr->is_init =3D false;
+}
+
+void amdgpu_profiler_mgr_fini(
+               struct amdgpu_profiler_mgr *prof_mgr,
+               struct amdgpu_fpriv *fpriv)
+{
+       struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+
+       if (fpriv->xcp_id =3D=3D AMDGPU_XCP_NO_PARTITION)
+               return;
+
+       mutex_lock(&prof_mgr->mutex);
+       prof_xcp_mgr =3D &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
+       if (prof_xcp_mgr->is_init)
+               kref_put(&prof_xcp_mgr->ref, amdgpu_profiler_mgr_release);
+       mutex_unlock(&prof_mgr->mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_profiler.h
new file mode 100644
index 000000000000..2dfc0b1bb207
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
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
+#ifndef AMDGPU_PROFILER_H_
+#define AMDGPU_PROFILER_H_
+
+#define fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
+#define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev)
+
+struct amdgpu_profiler_xcp_mgr {
+       struct mutex                   mutex;
+       uint32_t                       xcp_id;
+       bool                           is_init;
+       struct kref                    ref;
+};
+
+struct amdgpu_profiler_mgr {
+       struct mutex                   mutex;
+       struct amdgpu_profiler_xcp_mgr prof_xcp_mgr[MAX_XCP]; };
+
+int amdgpu_profiler_mgr_init(struct amdgpu_profiler_mgr *prof_mgr,
+                                       struct amdgpu_fpriv *fpriv);
+void amdgpu_profiler_mgr_fini(struct amdgpu_profiler_mgr *prof_mgr,
+                                       struct amdgpu_fpriv *fpriv);
+
+#endif /* AMDGPU_PROFILER_H_ */
--
2.34.1

