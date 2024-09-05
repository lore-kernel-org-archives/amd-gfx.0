Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71307CD5BA0
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 09:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10EF110E7B8;
	Thu,  5 Sep 2024 09:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EWXgYQMv";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C4910E7B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 09:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBCDh1wycpfN0OqaT5cTlYCllo8xDn1dqIWSgWnmJMdmSp+r/V0W082Y+K+iGJnTZoFX3G+bVf3GE8QRLahPLVi14YL4YhSbXc6gX1aH0pP/FQpQN44vsZCsiSWBNB51FpilyUATtJ2Rmmnovt+weWgAfyZPpC3Ot2A1zZ5K8ra+jsFORylUgrN8KawUqCbkKTlLrnoVvseyUxKP/vb9XZPWAZ/Lp2dGc/daboWVqjjyl1VjdrSb6KL3dMwDFiQDg0CLNqdXFE4PLIIP/jSgeWm4ptobgAKEExctYEMlVpi9JS6xRyiQyGOrl2AeAb/GStqiUVzAlTASEBaPfvjfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtV32GoRVH5G/sOwELRlI0h5v41NloVtYgdyNFFbbXM=;
 b=ZqbG3upGJyeN+U3bVovo+kIrUGoRBYlldBHu+7J6HZmCCMX15jVVFIE2eh76u9BlY41D+J1opCNSNcB/YrHdWmloBmCLwStOs1uAAhooQJD6iW4hauG1Q+8A5FWtOvULEM0t5xFkm+V5ZcdhDO/rinHL+B35myY2ZJKKhw5q4TRZK6ywmhiSL9HIlEAgixlz6h1yMHqQGCtbd/hO+mFRgDjuUrKvm1zZbPDpvjp1JNC+Zv7dtbTuH84MUfwFAmvG+F+pcHu6zTqgq+owF+ELRQEa0vfTMu14NyzPcszkGIqvbBgg19D8pkx2Ui4ImyhFEAcIiFfKNhHdg1aYczG1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtV32GoRVH5G/sOwELRlI0h5v41NloVtYgdyNFFbbXM=;
 b=EWXgYQMvNVGSa7IoFIvMACDvXJXIFyqvoQg/q+Pvr0fy9JOKH8aBuhH7qqH37H7ce379eI88Vln15eUzuwSBMcEH/PzvCaCeD76kfwWL1vj7d9NHvyb3ZhSlAUWyisGEh7cYf2RsJDePvatwnSk0tVFHXj0222v5d6Hv8psexVM=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 09:18:37 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%7]) with mapi id 15.20.7918.019; Thu, 5 Sep 2024
 09:18:37 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 00/10] Support XGMI reset on init
Thread-Topic: [PATCH 00/10] Support XGMI reset on init
Thread-Index: AQHa/QqX5ttZZCwQzkKXUkR5uxCYybJI7vhQ
Date: Thu, 5 Sep 2024 09:18:37 +0000
Message-ID: <CH2PR12MB41523DE5B9BEDD30AC2B1072FE9D2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b8ba303b-651d-4ded-9c8f-ce5b309ca8c1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-05T09:18:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CY8PR12MB8242:EE_
x-ms-office365-filtering-correlation-id: 754ec285-997f-4ce3-4936-08dccd8bb989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DLovaabFakcHSpvqC/Zo/70Mp6NLHlzqjALPhT/13IvvdPbVG+PQhh99BQXb?=
 =?us-ascii?Q?RICti0nrV87fWENxXXRKVnjM8WZ5+bZ8hqUDrXVl/f/5H806sh1Xa/PQ4vZC?=
 =?us-ascii?Q?kszcSyeS/OwCxPfrGyZEcOiGQ02PSxkkpr7zAJCJQyHEVb3mDqo3sEO62RHC?=
 =?us-ascii?Q?vxylkwb2YNSytllzQbGbKNILoOTunEW9fXDHJDblKgMiz2JVhwWkKwOknJda?=
 =?us-ascii?Q?S0Hvy7o68U0M8NDsTUbflBsC2qYvUQkK1eSl4RcwefrB86kl+ikQ9fSYuUnp?=
 =?us-ascii?Q?dcS+PLHTzYwR4UVsQfw1EDq9H0ys2vjz2dazIPxGVcXdrP0dgtfDZwJ98EAZ?=
 =?us-ascii?Q?AIqTUswQE94LS5rUegBXyB2fpxnm7WDsjHjqhuIhOtBBCCWdo5E0JGHHjWnf?=
 =?us-ascii?Q?tD5p29DLeFA/nbktqm+JyaL+EX6yzEIg089xG68nTHL0H1w+0oxGmAeXhXBb?=
 =?us-ascii?Q?39YJ2blFFNEHYHOYAQOTPWn/nCdk017aP7EdxsKI+YNlwTNa7dVElWgaGiyT?=
 =?us-ascii?Q?zdPpF6QmkiE9RoJhxc3L60YgIvPBY1MEUZ5EtEl49eITp3t1vILLA4k6gJ9n?=
 =?us-ascii?Q?QlpX4+lfTUuH+GL3XWM4H+bfONKIuiTTyMgWwi2FsUf7OId50aAG6bxVP2zE?=
 =?us-ascii?Q?w8GfGI7Q2GrR2UO7nGx+HwA/BxPzcf1R0UNYRhC9SUHKCfOmnflzD+QlkQ0u?=
 =?us-ascii?Q?22liuS1FPAc7E8magMwQDTdVZeLva4If7lxtgljPrtQfx1IkxWDAnzQLLhfN?=
 =?us-ascii?Q?SmJMWWDh/TJDuWeejEDsb8VQVJZe4Z/FwJJsQM8EehrJF94gKcWJHcBOuUDA?=
 =?us-ascii?Q?R2TGDBjOXuyFvThmChW88jfbRroSjOxeyN4nBoc8mpYCbLrnLvIJzLmB45Hj?=
 =?us-ascii?Q?KXnQ1n/ZI8lbGY5MI6T1rpbMJC5irlP8ThEWgTSg71nNvVxWSqaSekWcVbwp?=
 =?us-ascii?Q?Dd69zBAL8OwEDxSTkevsZSbhrUAM0mAn25XycvGkzG9gTa0e5zcSduplvlEI?=
 =?us-ascii?Q?WdwcOFqCo9O4k24Ak6fb+53XVfPPjWAi+P3y8MmmKXT3YbL4R0V9UGbpKUUp?=
 =?us-ascii?Q?LCTkHkurE7M2V98kKT+OEIzeJZc1Czqtenn1u/ydffyxBfdCESgrcoLCdeek?=
 =?us-ascii?Q?UtUPlkJIUVOAIsFwEh3cXkAnrk59wNXUoFpcp0HyAMfOJqLukBnG76cxLjBe?=
 =?us-ascii?Q?UEVgRZecAuXjkFpABAyb1rASmzcJ31fGp+XY4nb7CiRlVWscXy0mX+3s9WkC?=
 =?us-ascii?Q?vrCJr0WWrDz3O8lZGwzB5OfHMR9SJcK0YTIcUiG1NN8akAqtuYr7maf5A/ni?=
 =?us-ascii?Q?WnVzSB4n1BqQfJwgJVsgC4iWSV4yzd1TQEPEO8zvFErLSc7+DuRYRqwej3cd?=
 =?us-ascii?Q?8W6pwzEnlDLplYgeZ9C9QClUcvIk90Oxsn7zVhYm02Ap3/dP1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iDMmML7QEQcOf4U6mdyXQCf7As5DQUNQsK9uUMf7BT5qXoVRlv6BwyYHrhA4?=
 =?us-ascii?Q?yPp5ogNDBcNxymtQEpk40pCx/68Ex0R04fOe+sNMJg13YypfnAtYHYFZHYAr?=
 =?us-ascii?Q?IgiiH87MmpEy13bEKdjTKXOx0tTIPRXkzBZijGV3tIZAfT1cCtY/h+oBMquk?=
 =?us-ascii?Q?01xoonXC9FTXWkpzcl2t2n7+vjBiQ4tZNAnXdz9EcGNH+sDmjwGZprkWma5o?=
 =?us-ascii?Q?b0HbQZg4ea8il2BVEYOwYdK7tKPKlmoLxkk0ZYabdfS7hHlMWlgAnJ8ZEVmv?=
 =?us-ascii?Q?4ICWhwEGENPf34UbNsg7J2xJEMD7SOrL4fklGdsHvLSX5wXGPTxWPi10Z66l?=
 =?us-ascii?Q?xIsodQqQdy9cXJfb/Vv59kEU+34HHIfM0T4k7G4sykBJFN31VXJGUi67vgkk?=
 =?us-ascii?Q?Y1JD7nlI5Y68YIEAq2xp01xoH2OtwFldRgC0A7inXBi5v9FixDzvXcFgnpW2?=
 =?us-ascii?Q?7vGRjNX+0GArXDUhX9qUioyN/u2P2kFMfear5jk0IcOpSgKEq470nYX6CLAv?=
 =?us-ascii?Q?yH6aqKNViyQPDRSjtMaPQ5jWmCpl6ZaQ/WMllRGJvGO7PP3Yohm06cRfLHjN?=
 =?us-ascii?Q?s2q5FmxwxRWfuRWebMOW/J+RlcxRnrxYOrCJ0uDQtMOr1E3/uAJrmDZBwfa6?=
 =?us-ascii?Q?YjDqCREVFdJ1RbFvowbuLs3QUTIHb8HXOQF+yDxpJ2qwhlCW3UOhEoKIvJ7y?=
 =?us-ascii?Q?dWwkj/t02LFSvsRLDSjFiKMnR3VcoG7MowVPEivRALgo8JhNX2E1H9wcsyBk?=
 =?us-ascii?Q?WMZbADWhxzPgg4RGzLnH+R59C7Iig3k39iaxVgNHQiRw/U4QexE4/Vaiffy0?=
 =?us-ascii?Q?+XcY5vDc4LaS0piu8uEEBEaWo/YGvrNs12srUyPMVhvd1Gtvmz66a/9LNCQZ?=
 =?us-ascii?Q?5FYmHpi2ZiGTMKqIq2WWn/70G53zITknrscrILXutZVVnru5+5BlcjTLAmAo?=
 =?us-ascii?Q?o6y5X/9HhtcSt2Ym5Nj8dpLh7s6dRjBozzPR3/obL3zaOC28fpUDCvKczUB1?=
 =?us-ascii?Q?cAENdm8M1JECQ4Tc1tf8EpY9PvQ8hCNnii6/9vZKVAh826Vm2BDsEQP83V3+?=
 =?us-ascii?Q?KWRaI3IJiegIB5j2esTeVdK6cqcEohhYVXxAYZjByPnwY7y+OcCIoOXBhdfU?=
 =?us-ascii?Q?TavqDOOFkDtpKwRwFlFgQMWmOs8dKfQth/n4AzptSjTx1nEZS5OWOmwms3LY?=
 =?us-ascii?Q?IGko1AHQmzr33C4uLeuCMqG3Iz9lSe3CX0hMi9U6CmMrRhk9xYMQ6y3N1rg0?=
 =?us-ascii?Q?r2ueTPqhLtmCbULlNum8gKz7tCRFzOPGR0EactLRqtkTWdLFINd1LrTEZWpU?=
 =?us-ascii?Q?qGYp1ET1MH2ofMIpeZ8N/MmsILS/wqu7fHdH49807+4mhHvXIq4vVMdeOopr?=
 =?us-ascii?Q?Wi6p4doTZLSylAxW00hgXBt12fQglp345lf7FpaHt0ZBCdvMTdZRnst05T5K?=
 =?us-ascii?Q?3kG/JMcaXUdibUvtqCHYFP0YmgNM+1CyLVo04YdPBoETkS7dPPvAt8ztIPky?=
 =?us-ascii?Q?0io86zoEIaJdtNzaJdi+iqvQXPpPe27l+QxSXyI891ZzV7YSbJ2CQEOzRzto?=
 =?us-ascii?Q?4jsaZ252rff003YvlAU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754ec285-997f-4ce3-4936-08dccd8bb989
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 09:18:37.6124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XNoW0KIkrDN/WVIt1UO37n0FNAXTd53Oke5vxCwFD/jXgWDY1I41G1fpFnxEZSl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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

Patch3~10:

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, September 2, 2024 3:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH 00/10] Support XGMI reset on init

There are case where a device needs to be reset first before it is fully in=
itialized. An example case is a driver reinstallation with a different vers=
ion of PSP TOS. In such a case, if a device supports reset in which PSP TOS=
 is unloaded, then driver needs to reset device first and then load the new=
 firmware components.

For devices in an XGMI hive, a reset needs to be sent on all devices in the=
 hive. Thus driver should discover first devices that belong to a hive with=
 PSP support.

There is an existing delayed reset handler, however it has the below
limitations-
1) It doesn't discover devices in the hive, instead it tries to do XGMI res=
et for all devices registered to mgpu struct. mgpu struct may have other de=
vices than the one which belong to a hive. Also, if there is more than one =
hive, it doesn't work.
2) It doesn't take a reset lock and since this is a delayed reset, that cou=
ld result in unwanted hardware accesses during a reset.
3) It doesn't initialize RAS properly (left as TODO)

This series overcomes the above limitations. Instead of marking a pending r=
eset, init levels are defined where the level of initialization may be defi=
ned. In case of a pending reset, only specific hardware blocks may be initi=
alized.

Further work (not done in this series) may be done to have fine grain contr=
ols for init levels - say skip enabling features like DPM enablement, or sk=
ip loading specific set of fimwares as they won't be required during a mini=
mal init scenario where device is going to be reset.

The series adds an API interface to check if a PSP TOS reload is required.


Lijo Lazar (10):
  drm/amdgpu: Add init levels
  drm/amdgpu: Use init level for pending_reset flag
  drm/amdgpu: Separate reinitialization after reset
  drm/amdgpu: Add reset on init handler for XGMI
  drm/amdgpu: Add helper to initialize badpage info
  drm/amdgpu: Refactor XGMI reset on init handling
  drm/amdgpu: Drop delayed reset work handler
  drm/amdgpu: Support reset-on-init on select SOCs
  drm/amdgpu: Add interface for TOS reload cases
  drm/amdgpu: Add PSP reload case to reset-on-init

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 245 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  81 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  62 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     | 148 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  72 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  25 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   7 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   3 +-
 17 files changed, 492 insertions(+), 214 deletions(-)

--
2.25.1

