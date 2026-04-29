Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC397FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 12:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DD310E3CA;
	Wed, 29 Apr 2026 12:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4E01Vzx";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4ED10E3CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 12:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTPBmTxdfhnYlXebNjxY/xC0b/xrj1GvPfJvkt4H73fCcJq+aof3JzquylUWt3alVbEN9y/K/sC0EqdOFV8X2zqCiNgpEe64DXceM088ldnkCzHNm+d0DTwqr/P9gLYW40FXZSllMxgzoRPh05mLvHanhWbccRZnjWZ628q1KLw3VInkGETsgdFB6SjveqtDftP5dQLd2Mi+92Jtz0pPYw0gOOQGPjQ+BmbtDR3qyBwwPznYg21juNdTr3KHYPs4tQB1s0WgHXsGfPHluJ1lBhnwzx6HNqef/Z9SEgiplcE5yTBljreDhoKJ5dMyK8lJ57RpT9+NV51/7brcQ+QkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yapiXdnwc47/PUAobeOzWrqww2aFpLX0NRNzogpl5vE=;
 b=TgaKW1McZi7oPu2jeANPqrsek8XUXFxWuHuh5s3q/bijZR9H1nZMfMOb1FNZbtmi62OT/MtxeVnWbGv8q+X6KeZpGxU62OSIX3KY6bn9OI3UiEeB29N+6yWU0B+YJ03wgXxu8vISWAO8oy+NZQKkcjANC5ixuJJpATzHF/5JuvZjc/7LH1nTd5u+KW7Kv0KW0iJ8xeYNx0pQDd6qGgcK2N/O8Ax4WcszhXmdlikg16A0W7ADBnRLbyCDngbD3dKj1bmj8/KIlmf9umG1eP7k+rzvS24DB8wFdxWa3RhlO9UthGMsNYHNJjdTviYeSn9JcaSlcySNA7dAKobmSD86jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yapiXdnwc47/PUAobeOzWrqww2aFpLX0NRNzogpl5vE=;
 b=D4E01VzxTvA+zkEobnPxzoaG8JVlPfT/vQblIytLyD/9U8Z1mzE0D683W1oy/72HgwDNUPYq2GZJO5739lJssPlcV62MjZs416T8T368+s6oYmo9cm8fYx+qThH4wrZn8YU7NVPvkrAByg/ACMbzAYxhGfDWCrMuZ17uhxC/vcQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 12:12:32 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 12:12:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Prefer ROM BAR for default VGA device
Thread-Topic: [PATCH] drm/amdgpu: Prefer ROM BAR for default VGA device
Thread-Index: AQHc18CIwGzOEocHKUWIcENWlqLr+rX181Tg
Date: Wed, 29 Apr 2026 12:12:32 +0000
Message-ID: <BN9PR12MB5257627DE606672951FD25CEFC342@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260429101100.3893004-1-lijo.lazar@amd.com>
In-Reply-To: <20260429101100.3893004-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-29T12:12:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7222:EE_
x-ms-office365-filtering-correlation-id: 46c4e8c7-9e23-43b9-c054-08dea5e8976a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: A3N55WdhzVg6vNCs3Gr+ZrU9vT6fu/u4jvoFhdXSAB5lgQZKUUhc7CSzI0IoB0nfhlpZE9wwhq+p8W56qJey27tUXA6M75oQ1HVcs65GYOSH3zGJcawbW+7VbjVRz4S8dQlpzFQnPRijN3oWzO+gBzht0hWUK8ABVJ92P1ONGYvGL0zjgX2IoYOpbaXQa/hUpJeDPWJ+Dq7VGzRQTd4YXFfgLFQOHOA93Wp4C2VcKp3D/Qdr2JfmHwDHD9YsZAFuA6zrHRQN6tTZXvbXo3+rtOXWkyjKlF17MXxIy/gv6k3qxCjn1+CsCOUxvMUoGyO3yDcpvr21nOWpO5jnJoRPbE/yz33SkGRI11qxWV5lr3u3S5t8fN5TJ7fTnssdim8xxQyykOmV8RLSNpW7d/fG3LPvGN7WmHWstTXRhNh8pndUXJ4NNnlmhC31j+cYeT/CprE34s8PMJKR+qIlRs3siSgsUWGI5wggoihSZZk4JcvZL0QCUBJ+pzDIsu605QYsz9dFcuUnwCS/267iGILZoCryS0OVgniV7XQic/SJd+vCh98oKfqzMhtVTVxw66D+KqHTWK0jW1w8SaV4Zwy0DP1y5NNH7voTPkJO2OeuWlCn8mZAQAMhOr7j4flhCU6ryog4HLQd7O0CPQyM4Ci92leyNmQHVviJMfFaPbfXdNuUQqExYjC4fn0PMOvuOVNt1kBPUKx2K7MkQxYfptEYTH4N6197lP6R8HAmvgESqwQH7dFT+QUhtYXgw7Np5XPeM9JGGbmmYNX/vj4WKEDHosgirEDjMUCt1HbENSJnUi4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GoFuNrCJ3WF8J9hM8flR5ouC0jaMmItPZxbbmSKFsFpZXMxRppA3YPyzNFeT?=
 =?us-ascii?Q?jl5OuFRlGiS5cJhGTgH+TpXCfh4vcK0saBd36FDohnTO3jqaZeWPTHh/69TY?=
 =?us-ascii?Q?f8r9aKkS32jkLAHt1IHzN19/GAeNlzQSTCxH225k7PfNaTV1tNMZ0+HwymiP?=
 =?us-ascii?Q?0yQFLd8YuYIS+Gy8fzC8lLeweXvgAE67ovN+XJQGys85JP4fZcsgSYbsI4t9?=
 =?us-ascii?Q?55F3i7w5N1r3tjwaG7q6OmQIqOiRxB8AxiQDSi2ewZNyUHsYPBZPwIwsZYuY?=
 =?us-ascii?Q?uIycF1gbf4KtPkhgd+2RBX+NbErP/+G01uz9evSG4h9QROLlATN+S/Nqry9g?=
 =?us-ascii?Q?lylistdph9Lhi5B7eKA41dhheg7Az3Et1GorT5FgPCh/MwLel/A+NIDuKy45?=
 =?us-ascii?Q?/NEINPUkYcgSqvpBU6Qfr9Yihyx8NIHcFDRNgqHeLZn8MP/i/zIQHrWAoodX?=
 =?us-ascii?Q?MsabgBX+SYGQQkJBT1GwAgXvJbl0FtYrfKZddGOTvSYoKNKUqWxzLXhrL8+K?=
 =?us-ascii?Q?abKzo94nSS3yy29zHFtIsAg0xUfxT9pMGtyoeF7UZg4ZWpoidZpYQlolXT7Q?=
 =?us-ascii?Q?qYz62rPvfQV/uEKYWCIfks1xMvik7e49yJTXUTg+EbX5bMS6qpQTFSNKE9h1?=
 =?us-ascii?Q?eiGTh+Gvs1dvRAxqhmiIFGH93ByCfg16QgkPxDHbeZaAVkVTLENgsX5rwCLv?=
 =?us-ascii?Q?0cptN06Rk1Jl1ZSULkWgTyjb7CDUFsjfgaPNWlph0Df93ezxXizfuohTcI/8?=
 =?us-ascii?Q?t2+SUeoreTeyOOwToJdaZZheSSFit5TwvPe5F2vdMe8ZpC37HU+c4WAiUaJF?=
 =?us-ascii?Q?PPTWymthwl6ZM9zycdYPWSoxf4BMTdMDaiWlme/OMya5TyhWtr5av4Mx/IJE?=
 =?us-ascii?Q?6Pw6gyl+je4ZE+uV7PfO55Whm2wILvdr4OU//SJrTHApqXREsfTw8auHwBzO?=
 =?us-ascii?Q?cHlzfX6sRJutVtcj/n5jhovArCXIObdnFNdpIVN8PitUVUm7f8bFvtS4IVlj?=
 =?us-ascii?Q?KL2jPojTd6A+FbyO2HviTlY1A68sqcJ6P60+bhxQxqhVF1mFYbmbca4JV98i?=
 =?us-ascii?Q?cfkYrBi01JkD5GMC4Jm6cmdOI6WNMy0ONhhpXT2DZvesm6afCQsiEIB8s76F?=
 =?us-ascii?Q?hcG8DaKpmqzZ8aOTQIuvm9yf2mze9pxLFlkrDGPWZdJrl0jUJMhpCzUqMvxR?=
 =?us-ascii?Q?lHXrY+5s5x15zTe9ho3qvwFIljtaTDnaIjgaqOtpoOZl6VxLgVdwPlwRvrZc?=
 =?us-ascii?Q?ac5+bXAdklizk5oBzqhdB8IktfJPSLfTPIXdpowOftuABTiWVnpEK4CHYsq9?=
 =?us-ascii?Q?9II/Vsnm48LA1BqXe17yUR3FEPX4P7aHJoRFCbDn+ayZTEknomBEnmXt+BRK?=
 =?us-ascii?Q?GPLItOYmSrO8b52u4cCKjbLMmnvNJjjTyc8cySRMMZfOEFIwMzVWcS5B+/bk?=
 =?us-ascii?Q?TeOMZ3zEafElnCg7ng98gRvHZfDRevMJHN4PWLLC7iBBq7Tt+nOvzTZDU9wX?=
 =?us-ascii?Q?eiEFBxCwdOxLSWC7unJBXV2sGJTLj/gmLd0VHoKvGhfVx+9Sc0ZltNJyj44Q?=
 =?us-ascii?Q?Q655QB8LCjGxmNLKTBUdRuJzMVpqO5fs3IH/bb4G89lHiZe66Jg4bFAcC6eH?=
 =?us-ascii?Q?8cp7IwBap1Ugy90fVIc7bf2EHN77DlCieqeRnxWuI/PH0/qZEqdqAng/jRJV?=
 =?us-ascii?Q?Y2Urla0Lodda7pbhtM4F582vRJWfm0Lr8H5gm+Vmfo4PEnIc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c4e8c7-9e23-43b9-c054-08dea5e8976a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 12:12:32.4302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uimIL3acm4seBWY95dff6nfkhkI6hC/VZAX6yIBu1gbZn+3detlRLFVU+2XottLIMnBG5F7iiaKOgE6ALHBoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, April 29, 2026 6:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Prefer ROM BAR for default VGA device

Fetching from platform ROM doesn't work with hybrid ROM images. For default=
 VGA devices also prefer ROM BAR.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index 35d04e69aec0..aa039e148a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/vgaarb.h>
 /*
  * BIOS.
  */
@@ -467,7 +468,8 @@ static bool amdgpu_prefer_rom_resource(struct amdgpu_de=
vice *adev)  {
        struct resource *res =3D &adev->pdev->resource[PCI_ROM_RESOURCE];

-       return (res->flags & IORESOURCE_ROM_SHADOW);
+       return (res->flags & IORESOURCE_ROM_SHADOW) ||
+              adev->pdev =3D=3D vga_default_device();
 }

 static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
--
2.49.0

