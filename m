Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCFDC79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 08:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2AF10E6B3;
	Mon,  7 Sep 2026 08:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n6U6loOY";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013047.outbound.protection.outlook.com
 [40.107.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606C810E6CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 08:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teYXdshKhsV3h/pZc9xoYE1vF0Oydabin2mFOgphK7G15dQBFKl9tPq/TUS1xG7UhfcJ3z+Ctw6GMpPr+PP+YVxO1We45o78pmjnOKeOtOOy5T0RuqglcfRFEq7zpri/Ll5AHL5aOUBZE8y0vmxYHJUgTFTmPetYSVNyKWzHnCzIe79TlVatno7F3ftI6zZkEooByfgxmRM+t3WQHyB9HJKvfIDhdKJwsGkfBdfBT9NHv4XK/hvelhsErCMGn3EKnmklpglp6AHrXcoyRehthC9DDy9OPGxsO+M9oNAXHRU1bwWhyytmbuZnxMdtP9aYuAzZrxDMYcwm0RM30iy8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZTgxKAiAmXC6Em8C6MXS7tCzpbSAXtwyQjIZb92KzI=;
 b=O1jh22i0VwaKM/GYfRi3U/6v/Yf7Mmq3wr+cPg9QTw3Gcnlf2EaHctdVH8LZpEaSsyaLnYHMDwxBIfeEPJdU9Afa7a0AUTS4gAwq0F7l1Q40Ri1pZrtv+fCppibeN92An3QL1DvwPlx0vpmx6mogRV9ZI6vCO3LHqINLOgM+MLeq4phnfCD5QOndhxjHBiZoTKFqiQYtE7F2ScyLsELQwbA62IVryAtu+TbBvehy45IMFIaCLMK7PcilKT24FQUgZBh86nQUmbct26QnflMWSlWDxhcG3llbv4uFOpfwjBNRMF9jf3/CECUnjeUGNA3etcInI5J99xuYHlYmiWC7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZTgxKAiAmXC6Em8C6MXS7tCzpbSAXtwyQjIZb92KzI=;
 b=n6U6loOYw92baf8Q1XUS3bZ0/OQdYO9uA0TLbY9Z97+T37o7XfaSOebv2KW9k7DE8oZduLoKtwmncb+jBm5vJdmzoHHr7dpZohLVix/XZgrENcNdOGTu9H8Z6eASiX9eJ5TBEaUGOCxY++zb/22Q42ntFxLI8FsBMkudWu2LDNc=
Received: from IA1PR12MB9530.namprd12.prod.outlook.com (2603:10b6:208:593::17)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:21:15 +0000
Received: from IA1PR12MB9530.namprd12.prod.outlook.com
 ([fe80::7bf2:b883:379a:3d41]) by IA1PR12MB9530.namprd12.prod.outlook.com
 ([fe80::7bf2:b883:379a:3d41%7]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 08:21:15 +0000
From: "Yao, Chengjun" <Chengjun.Yao@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Shi, Leslie"
 <Yuliang.Shi@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal
Thread-Topic: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal
Thread-Index: AQHdOTuU06reO4P3oUeRbhbtLkv14rbCuXfA
Date: Mon, 7 Sep 2026 08:21:15 +0000
Message-ID: <IA1PR12MB95302C0A8E92235524097C6392B22@IA1PR12MB9530.namprd12.prod.outlook.com>
References: <20260831112623.1475796-1-Chengjun.Yao@amd.com>
In-Reply-To: <20260831112623.1475796-1-Chengjun.Yao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-07T06:56:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9530:EE_|LV8PR12MB9270:EE_
x-ms-office365-filtering-correlation-id: af906aa6-f70a-4f15-4db4-08df0cb8fc09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: 1wkhIFM8YTDYOfHdSwJ1R00Th01xNOlU4prevbnVhsS6zBXmQ6CBZZhRAtJaLLv7tb62BpIZHZdGv+iGeTy4LHHKZLIHyzhGnX2Wmpd5+579y8v6Zj3wbW03V2iLkUwB7MVsG46enVRHUj0RQVBSf3i1qe9MYZ/vYCZ6zP+WndbHWR4zTXyjD+FtU6W1YurJmGDCWUKf2R/v0icfJb6dX2PAnXnk+VA8ke0I2kKkv6/u+scsiU/6Xf4Cf8fB7XKm0fUx7xD4cOFJSZpFbpbpixmt9uhbBCxnrDvaLTJb7LqUGr5wkIYJnMMZoA/EPD8e75PTbTPHS9xzsbKVibk292gzPNEXgc+svEOxozIPZvZQJojx+DfdicqGF0yMODBrtk/AJbiJJHdeXSN8iUIR99SYDcldc6SzCR8ldzCBPJ/1VWf69YqAcYzTDX1YSpOnFLzQ8rBaKA2kljC6NlQ97Sk2ETE7hUXLBxiC4YzqoNbfAtDOFVGZ6C3wZa69AY++MCQUYgOOkpMhn35wqiLgihu68iWagTi3iegYie7HXYTryt1reWjuLYi8pu8QGwYbMI2dGzocT1ifejlCW0XP/cezlT2dObQ7RBVg5LSDYonjgyU0XF3TK/b83VHm/o/e0sNwqFCsN8IqiYeQb3oLpcKAdSjCcCuP86ONK4uTWAZcsEWafD7/9X4KOuIhCeLcJXL9/YBG91Rew3THj9BK9rvSEwhIi/ZohorqqD6PZOs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9530.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ulFaq00TXJML1j90bvG8I3kFNLqEaCpDNeve98Dxx2SAtCLV4vT9g0IlD+NK?=
 =?us-ascii?Q?DDU31//n3KquX6qdNtBIvXwFJkNnn1man+WWPWaRWKaxOYTn0VD5a2sjoVBt?=
 =?us-ascii?Q?eNGgbv4MJdKjPc9D4Ii7aKQTts280kXnpbZabSX7IWvgN/esVPW7LuH/qW3o?=
 =?us-ascii?Q?Rp32wDZZGtEgmOgz1hTabGTMhT83SA/1jTmg0anDZ8s6n+eZx43rkDUcE+ax?=
 =?us-ascii?Q?qGHPCH7PKU24vfcZCLOP0NWR7eIYwv7Wxhj8zWz1UHchZ+rkmuefARFarSAX?=
 =?us-ascii?Q?c9kh8JXPkI83dBL/zPgRxhsTNCFthbDC1Y96oRqBJ3F8qwsA0QZHDjFQWUlW?=
 =?us-ascii?Q?GoVAeYEYNvd3WKGD10WIfWTW2OxiUjN7eMGWNMZBHuDI/AWvXtlUagCt/11O?=
 =?us-ascii?Q?exTfPoe6KDh1h+RyZYrp4e/FukdTg74FCcI4cY+ide1p9yjHDKAtvtd5w3tp?=
 =?us-ascii?Q?S6ESac3FKXoMSABUjYqDgVRlXZfhLBypKEqbhjK0ZqzwPBiy2vjqvL8XuMIE?=
 =?us-ascii?Q?pC+Hf6e8BSKAiad1/Ai5skeFWw6N+L0NtVS8g31vkqL/MQ9w4YGpsmRmw4ms?=
 =?us-ascii?Q?jQbM1fmRNJFOHSQCLt9uBo/7cdxKPzt2Nwx8YWEBMC8NhAr8byvytqD/2kG4?=
 =?us-ascii?Q?z8n/llCiZamKpB4SR2NCmvxlbb9Epn2uPvt9HazdmiNxBSXKRRN1kWH1yVMz?=
 =?us-ascii?Q?mWQRFjMHhkCO0veKes3aq6D8D+KvF5phnOMAZicpKigL5oo3H2CowDPZMshY?=
 =?us-ascii?Q?7Hh26jYSZIUX6Nw0HRJgk6ew53P9SL4E/Y6p9tgH7Xhz8lVHDlIXwDZ5wZm5?=
 =?us-ascii?Q?sXdiqj7a2Z7/sFRZBRUSiCjx6yannXD/VLdaZpi4sIYDm7x4gzwOh9oG7l7I?=
 =?us-ascii?Q?qyqzPtr8x84t4kxMnekWTI6qomRSlqWP3FX//5mQGuD5JOHJ1WxztRIXe02E?=
 =?us-ascii?Q?kq34JXgAL7RN5nKzoweJd72troeoYGzWdoZ94oZWs8da2WZVXE8mMgrnoW8E?=
 =?us-ascii?Q?gH4RGEgMIwsoPnQuL1NokhyFzTtWFq4Wf6IN/nGbmAuGQc/4qWI22VqnHla0?=
 =?us-ascii?Q?He8tx5Gz0x5JuyOGgDYNJN8QSpcpzceTRjAZzVaW7q/t56zPjODmsf4r1yQa?=
 =?us-ascii?Q?Lf3+dVYTPavDyUImsoW/OZxBa+6pPvum09kwnbwyO3ehflmnRwzuzCDMApKH?=
 =?us-ascii?Q?Flq5+VNJEvpH50d9FU4rAcxUkyq0BnY1bkptSWIVC1KtBz/BiCTpi3kXZP3g?=
 =?us-ascii?Q?yqGxVC2/OhBWOs7Wx+AgZ+XqTSmvwZrAcGUyTAODhuh5mV1M2+hljZuRGuzA?=
 =?us-ascii?Q?8DOSZsotARrw4qStvKJH++XLynLDvZsNw6oYRPRRQEeLUwx9saytm32itZaC?=
 =?us-ascii?Q?gvKLK/+FMjfP28UlSITLAoidv59XQZe+Ul9O4FzeV20EgBcMVKBKzakkNmvH?=
 =?us-ascii?Q?6k2A1WDSqb3vGABlrq5RJfcs1cncUe2pjQZDikbaOW9JqHIbBqM78R0eyHPK?=
 =?us-ascii?Q?CHU+2vgt2cMQ1gntac86XegIBnrtFURBzmQmyWagl8P8N/i9ZSExiV/Zsz0S?=
 =?us-ascii?Q?xyp/iH3mqZBTw63xrEwcMEYzl5uNjNoDIfYeep6fNpMUoEE8n+G1ekyWmkOv?=
 =?us-ascii?Q?wuwKSO9/G2ssc4zEmSX0oU12QlXja5cHEpsc808YomTpoaZQAug5Nar7oZ5A?=
 =?us-ascii?Q?Iffb6ICX6XKLLZfQagopaAGIWEMXD7kAVrmwhbHswnRUYEyU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9530.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af906aa6-f70a-4f15-4db4-08df0cb8fc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 08:21:15.1572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLBJuwIHg7QgAiQalh2Jv5527jRLPAQmk1qgtioLXF7ogSZ9F1WHh7i3JdGFj5FAC2MH8jvQBBhAPW2ZK4yGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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

Ping...

-----Original Message-----
From: Chengjun Yao <Chengjun.Yao@amd.com>
Sent: Monday, August 31, 2026 7:26 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Shi, Leslie <Yuliang.Sh=
i@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>; andrey.grodzovsky@amd.com; Yao, Che=
ngjun <Chengjun.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal

amdgpu_pci_remove() calls drm_dev_unplug() before fini_sw(), so
drm_dev_enter() is already false there and the iounmap() guarded by it is s=
kipped. This .remove path runs on both hot-unplug and plain rmmod, so the r=
egister BAR ioremap mapping leaks one instance per unload.

Unmap rmmio unconditionally (guard only on non-NULL) and drop the now unuse=
d idx.

Fixes: 62d5f9f7110a ("drm/amdgpu: Unmap MMIO mappings when device is not un=
plugged")
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 18cfa2dbcc2dc..c175c29040274 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4343,7 +4343,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)

 void amdgpu_device_fini_sw(struct amdgpu_device *adev)  {
-       int i, idx;
+       int i;
        bool px;

        amdgpu_device_ip_fini(adev);
@@ -4385,11 +4385,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *ad=
ev)
        if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
                vga_client_unregister(adev->pdev);

-       if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
+       /* Unmap rmmio unconditionally; drm_dev_enter() is false after unpl=
ug */
+       if (adev->rmmio) {
                iounmap(adev->rmmio);
                adev->rmmio =3D NULL;
-               drm_dev_exit(idx);
        }

        if (IS_ENABLED(CONFIG_PERF_EVENTS))
--
2.43.0

