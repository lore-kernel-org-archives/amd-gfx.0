Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1012AC5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 08:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7249D10E3DF;
	Wed, 12 Aug 2026 08:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVOVzf4h";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4FD10E3DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 08:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8Sd02HaWgbJdyqYbVy2iqzSW6EJ8BRWoIildicEn0qYPqE0yV63Jv/E9EDOsp03IsaEWfJG2NhGR5DL1+RuwKZgXm6XYXEhpyOG6PWVgyaKQxPkxUf7PBMgc7OqY6cuvsmGKRpAlVbdVIjmA8Mrl2hS/I4Ewwtp1Y20FpebZAukfJQkoJutKAEqWJQ+YyKwJl6OFelMsof5uv580SRI4ieXVU/cFk+912/PA7riWMJx1a0IkXeo3kM0B82Mj06WRUUWw/W6/2NTOsSi3Tw86ROnyoKdZdofexa9q7cTg7KudnuSRL4YhjVe2z0hBmOvWufngVbpIL+j+j2taX/uDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC6ORgJGcGRzcTUE6JRwd0qDOvntMpY/RZhTfR5lqWw=;
 b=uJfP+IqKNkD1grI2EU2pnT8jAdvQ4tIhpCiKQYiTasSvDdeEyDc+ZkYQptrBDYZ8p7LpKj98RVwHpLL1cbvlasTRrrBPIBO9iro8bNOEbOjXKqL5j+zs1Fbb9KVVcPFNNbidPpEtP8Qf1Rn7LgPthz9PYUbPMg6RluInrOxKQ/MQkxl8KpZJLMjF6EISdYdEizgx8KDOIQRRX8g2ctgyylplOpKEWp5E363UPGWe6YOptVanA9MQULh245ERrjqqGlh3IA6CJh9xicTKSRywNd9UJwOhrGs2MwdulwovJvH/rzckGzyI8sv9E0hpeQOGzmDcWyw7+BoTylMQSbXTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC6ORgJGcGRzcTUE6JRwd0qDOvntMpY/RZhTfR5lqWw=;
 b=VVOVzf4hlLNC0Blauu9VFTAH6gm9vp0ytKbQxCQo2SkTZ6Nk04qeJ1Ju21Zf30hKhypFFFtv2+CVAUMsHZ7WEeBSz3vu++gf1Wj9iW4R1JipmYt5m1Le19Z5mXhRS5IT0phlzaX7Nf76kAOMKHFKus80+fRt6u2mAExL6hXz6A0=
Received: from IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:21:12 +0000
Received: from IA1PR12MB7661.namprd12.prod.outlook.com
 ([fe80::6e9a:f2bf:3d9a:2a3]) by IA1PR12MB7661.namprd12.prod.outlook.com
 ([fe80::6e9a:f2bf:3d9a:2a3%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 08:21:12 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable runtime PM for externally attached
 dGPUs
Thread-Topic: [PATCH] drm/amdgpu: Disable runtime PM for externally attached
 dGPUs
Thread-Index: AQHdKjHUW9MBJ+/u0k+/8yHVFW4kD7aaEqYA
Date: Wed, 12 Aug 2026 08:21:12 +0000
Message-ID: <IA1PR12MB766149F0F5A7397BF3B45A4D91DC2@IA1PR12MB7661.namprd12.prod.outlook.com>
References: <20260812080841.2936007-1-kevinyang.wang@amd.com>
In-Reply-To: <20260812080841.2936007-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-12T08:21:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7661:EE_|SN7PR12MB8026:EE_
x-ms-office365-filtering-correlation-id: f19c550a-9cd1-418a-3212-08def84aabe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|56012099006|11063799006|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: jPf3c5QCDsP2CXrgM67KQzICbgL9/SYtvDAg8rOmNxuWxkQuagn5BV8hvHmngob27aPPpN/mx+M2xdkNHY3UdoQih8X4J6KLLCWhTDgCchWdVLp2soK03Py9G2Sn11X6cFssDS6hTRt3c/p4CZiY+P/uhdcXPyMhe+BPA4a4bu4JYr/XGMVDGs5+UebjbDWK9GeFeoc9NDf9CAlgtmJbJQ1+gDSABhdmR8DbZW3RwrkC9WFaTFEjCkN+GgWron0M3yvrfbXJFQb7UAVlzqqVaqIGzJaqfGfnvEI/mITxLvMsCtNCC6Pvv2ZyzpsigMXPbGqaQxnRFMtpWcpsxBMZeIyeeAJl/9cdzAJB0O0FlC0Tu3gV0uaL6AfTaohVAJ2DDS2pWdYwn3YndMXBFhjg7Svho63DVDld8cmshsnONcNeLptFnIEVzKaE+2rBmEPnFyppsM5v64MaayvZqgxEUt1K1DOKPVoRFosjstcIauJ/yk0IRvZ07rZ5jYzjHFotbRmaZVmFaEevlDQq7lKP4xdSpYB2LDowuqdmxc5Ld8RM8KpXrAxuuPeMwrlx1d8jyGuscGhRClRz9ecXe0JDoDlRxnCel6h9875qzDzlo2vWGNp31x9pgnexxzNXJBF6chBrX7jSLfqvOwRiY1Cifn3h3MSGyCBTuEW+dui5lv4fXq9KhH7g3yp/IXjMo/j35ZXSQ4B6VFtGxXtKX+doTlj/v5EvpuHQo8IWI/tq09w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB7661.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(56012099006)(11063799006)(18002099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gEFavOHPsMN8tSdbPdZvIHS4+ITrDpwiMEYdrgBAds+wOZMZWDAGy/kjF9t5?=
 =?us-ascii?Q?tUcop96WjWrY45QBU0ZwznpmvqmwJTLllDfZoF3C5GqWRuXKOwaQes0EKcxQ?=
 =?us-ascii?Q?yEC852UUrUIbcs5t/kyp5Z9okn8R3W0fSW21ui/BL7hMq2SRpwqVwps6TEp8?=
 =?us-ascii?Q?/yhEcxyH9Gv989YmSPGYaxejikYKXyjhfZ2Cf/8D/hcmA2BZj8e3jnlWuPdH?=
 =?us-ascii?Q?LUb6z5rYCOa1L1GtZ+VQO1oSFGWRctC1OhoZcOnuM6KvWmFHngMvudpSPTDY?=
 =?us-ascii?Q?r3M7fJMshVBRXmFV9J+AJvu9fFeQeBsk+9NWXrIEAi4LNCM8RiB1KaSiadmH?=
 =?us-ascii?Q?2j1y0M/SoISUbHkYt1siBiULfjvWIHFrCXgOY7cxe8XRv5rtp7K/dtBGxF8c?=
 =?us-ascii?Q?xFtqLGZHVsFn2BdSUbndRhAogix3H1g4HkTZkG8UrU7dCrQx4Q3wCWCSseDU?=
 =?us-ascii?Q?8WG1vb/FDwPjocFBNAPICUgiOhfrM3JZx16y4PbztEaxx0p6cXHKtyKJZTwl?=
 =?us-ascii?Q?1nySw9GYqBu8XvDts2IOJ2/zjW1NUm/W1EsTv4mnNfDHotKBpkQMjcPFDyXO?=
 =?us-ascii?Q?ut7ODFCsIgZTucXV153FWQIvedZozpPQL3fHL4BhXI7w1rMncZCW9r9sHb8/?=
 =?us-ascii?Q?DLjVW9FIoCHm0b8DnjXmw6d+UjqB+kgWGEui0hbrVHmCpdgmFqClGQzOTZX9?=
 =?us-ascii?Q?jE8G9QvpUu2gMLuMnh3jZvsPqDIITny6I5gGObJ4g4fKP6R03okXllyJG5do?=
 =?us-ascii?Q?g1GgBtB63hwmLvjJHRBCxgEzFqK0CeM15ykF0pCCSnWJLMQWqELeyuKwieys?=
 =?us-ascii?Q?wpnus4VdAPPAShhMaTRgNDJrWSa1RUH0BB1f08pMOae8tnVe+4ovBga6i3ak?=
 =?us-ascii?Q?l4xzJwl20grZ+3jYYvet0WafH//CymrZbEwMsnIftyhAIxfcbOHoW3xw7KxV?=
 =?us-ascii?Q?GXdaMLrEhDFCC0+11mN1LcimXnaXSNbj39wOdlOykRPjZ/jKj9tqY1z5nGHh?=
 =?us-ascii?Q?mR5p65WmG1XOop83c1eIA28qiUj+fbxZI+oiI882ydkit9C658cs+2vll555?=
 =?us-ascii?Q?uLZwfKoWJdaovkGZTzbvBFqY+dvtdom8KF+tL+IGNo9yw6YpUJpBAbcMcgtI?=
 =?us-ascii?Q?kvotuUM7Wtz1xQPsKZ4dVnZuLRdpdSjIihxl+MgnJKTqqUqK23RYEyX8B6E+?=
 =?us-ascii?Q?f1q2xo6Y6zauTRSoGYgTjAX8E2YfWoiQtAZcFKj3lw3sGgWIjzxC3emJWepW?=
 =?us-ascii?Q?z5HhHaHI3dvpmqXXVQo8jtIw905MH16oXkwuu2PvDgRB1fUblxm0fqJroaNf?=
 =?us-ascii?Q?nk3s7M15MaE7VvwjRoXtWFE7GQqzPSBndfUxqSFNc3SZNb4mkoRr8PSXxJRv?=
 =?us-ascii?Q?NIJ+GMOGIGcDDJF35qTNYOcc4jZEB09ZPSsxSGsqjCWDIvZKIiWYuL+t3SVu?=
 =?us-ascii?Q?jSvnSylrNoiqTrkPCwfQkOMocIMXVuJnFivPJASjs0iVqRGs+taZBJsbIAmy?=
 =?us-ascii?Q?SMJvCBYplH4BRyJTl8IcynBpnbMbfzYBJQosLVFGaM3/P9jU8t6Bv11NkbT4?=
 =?us-ascii?Q?n2U/+Sr6+WogkVS9o5jz0EgBmswI/KFnT7okZnu13bjEBFxuTNcuQlPuSb/a?=
 =?us-ascii?Q?dMqHD3HWv3MXDHviUk1a6V1vDE6LSBbvOIUmNinaCkeTjGoQtge7P/AHEtoM?=
 =?us-ascii?Q?RrkQsbGO0dEEei5LQNYhyCH1Igw+opLI4ajP7tbGrOf9F4Z2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19c550a-9cd1-418a-3212-08def84aabe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 08:21:12.7475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmnxkqu1jaD6GXF+ujCupgEQkjgRR3ocdcXBT5UTSoUAlg7wvUm7CxrvlGn/gxWw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
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

Reviewed-by: Candice Li <candice.li@amd.com>


Thanks,
Candice

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, August 12, 2026 4:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Li, Candice <Candice=
.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Disable runtime PM for externally attached dGP=
Us

pci_is_thunderbolt_attached() requires an upstream PCI bridge with
is_thunderbolt set from an Intel Thunderbolt VSEC. This does not cover
the affected ASM4242 USB4 PCI hierarchy:

  00:02.2
    \- 0f:00.0 [1b21:2421]
       +- 10:01.0 [1b21:2423] -> 45:00.0 -> 46:00.0
       |  -> 47:00.0 -> 48:00.0 -> 49:00.0 [1002:7590]
       \- 10:03.0 -> 76:00.0 [1b21:2425] USB4 Host Router

The host router is outside the GPU upstream bridge chain, leaving no
ancestor with is_thunderbolt set. PCI core propagates DEVICE_REMOVABLE
below the external-facing PCIe tunnel. Disable Runtime PM when either
pci_is_thunderbolt_attached() or dev_is_removable() is true.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 8ebe24d59ab6..a4b4f9645c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -609,6 +609,13 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgp=
u_device *adev)
        int bamaco_support;

        adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
+       if (pci_is_thunderbolt_attached(adev->pdev) ||
+           dev_is_removable(&adev->pdev->dev)) {
+               dev_info(adev->dev,
+                        "Runtime PM disabled for externally attached devic=
e\n");
+               return;
+       }
+
        bamaco_support =3D amdgpu_device_supports_baco(adev);

        switch (amdgpu_runtime_pm) {
--
2.54.0

