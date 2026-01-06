Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54C2C47BE2
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 11:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6334410E0E9;
	Tue,  6 Jan 2026 11:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ig3W4uLl";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE8910E0E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 11:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gp3Angc49YmDWEbzEF0eqVaW1iOtNGH6kI17KIDu7XlqLSI4Yyf3R97jdoIdeBjw9rCThgfmrIH8l6yl6gCrrVXQ2m7VSmqUy5ZW2XG0H8v+0wgGYhPS3LapvqlKJuovepNOSmmg9gSCVmjWhKKDYgJqXC1CaiIIRnIRzL+vj69iMZO9NAyTyEzk5X7P2rGVmNNqf0NQY3GOrlgBf+pwBWFeqDMuRnH2EYiiHrRG+3/G1mt0R5L7mQEAkzsSM7K9RLZ8e2LFumd322kbCyetPwHoTKSvxlGo21pHYbi/UQfcjPwxCJlj28Sfap3nl+ITWNSZohpJihUWelcguSVdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ53okvez1Ars4E7BBrBPRDlg3yyEhe0oq8A28oOnh4=;
 b=g3AZjMYxI+M2ApdQKFq8xrL0yMSZZ7pa31ZrMmY2EU8IJGi92RCxonk5r3ti7duOBxbdRv3V+e54MgCOVj6//wm1qxPjte2xA57FDu6qgT1gdMrO/gfboVVMdMlGG0N5VTLjBAoQ3pwvzRPZa+Jhgh8IQ2UjMhIkEHrpAMbIhrQK5EIgnFo5ueNdimj6Anffd1FTsDlvDl4ZFKNvqzNPkjujqmmWGLh34E94hHVn0SdNzqOnCZFxQOV/xfJwnNTCzc1+vQc9LB1f9jnJfEyHS1JkNxzGgZcw/vCQZLGxtjY0lR09DGTqSbL07YJYtiIARaJtRq1pRm354VB/p1wnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ53okvez1Ars4E7BBrBPRDlg3yyEhe0oq8A28oOnh4=;
 b=Ig3W4uLlUjtSBHoZD6058/J/s9vjHs9WDHe1O/AlvE20HLDSyhm723AajM1iSfuFkk3KqLdzZFjaV001yhhUFZYVMKP7BXWkxGmoMSOO52S2UvzBJ2c7yQ+ztKvOf0RtSJwan+ko1EdpwdoodS4VW+aNgbQAuoWpOaGnYp2GgM8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:32:22 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:32:22 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2 00/21] Add smu message control block
Thread-Topic: [PATCH v2 00/21] Add smu message control block
Thread-Index: AQHcfvUhacN25GOA8kuPI91N4tQsgrVFAkkQ
Date: Tue, 6 Jan 2026 11:32:22 +0000
Message-ID: <DS7PR12MB6071CE3FF4E033EC6B6EC6878E87A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-06T11:32:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|LV8PR12MB9336:EE_
x-ms-office365-filtering-correlation-id: 8a750e1e-8ef6-4d2b-83be-08de4d174237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?r+Z02Cjs2MkNP1jwhsVs0tsZnAWtn9l5A0YUiuSv3N9OvB4Cff0xgErjlJ1q?=
 =?us-ascii?Q?AXGphA8mZQllDJAHnRwjaS85HmI4CwZ7uHpwf4eeC31q0Oe2MAhWt83dfbfq?=
 =?us-ascii?Q?SItY6qTOD1XKjeMSgrr47BRfmTOWT6N/MxpQwf80J9CV/66zPfCNuEpbVWdN?=
 =?us-ascii?Q?aHClGjh/9XRqYGymdrtSpdh/Tur5cGjJQOART259zceyd+IH++EUBWJfeykO?=
 =?us-ascii?Q?h9ZSptpDs4Za2IJIXRIV8xOqrthLuOJJEEiU7qjFbLWfeLgh/HnEMd7R3JLL?=
 =?us-ascii?Q?6AXYzD8zAVyR8xF9ze6wKnbH1iQrv/UsXxJREa7CryefWvjF8UX5fqxSq0En?=
 =?us-ascii?Q?gE98n9nye2taK5QIZPWwu8koZzGC4GKs7a/FnfiQ3gU10TW2q565rrqZBAij?=
 =?us-ascii?Q?CIlifydtGpTkf4lgHuSVmfEwUqcSXMQ0eXho2xUIICKv9EsRabbgoblT4Zke?=
 =?us-ascii?Q?WpdGH9j0LqsjqfG1LIbj/nVGEtlsVWpXbe5aiadkHRAqlRVYtKEpYGSA7w0C?=
 =?us-ascii?Q?iiIHjdkqNC3g8qUM4RzUJusrlcWIa471FBG2lD597KkK2/pc5Xp688FKt+Ty?=
 =?us-ascii?Q?r0Yz8tdQ+wyPzMdMEU44LgJa7cVnq1gQNCZGRzusCrwUFdu6EWGhD03bw8CJ?=
 =?us-ascii?Q?Qmgwm4bX+iYbnNJFpI7aYc/5u6SFt0/0UVMD72kGI4pHEW0M4gBcxX7y6+3g?=
 =?us-ascii?Q?2b4ObmYz/Dw6wFi5cyhmi3XLPZXP5UiIZG96vChoXPxC4M+nA/kvYdesJ+oT?=
 =?us-ascii?Q?cA5IZamMBknUqmvYlU1omAk3awzPLBZOMmk8a57jp3eTLRSpC8soG4Sd2nNc?=
 =?us-ascii?Q?Q8Q/T5Ol7R+6CGZsbM6wEOGsXLW0mHJOflbR6/ZoDhqSGPx6lFZwGG7V8fsj?=
 =?us-ascii?Q?HJI49VvgUA/p1yxvnbBRw96sERgV9ThlV+W9+EknFVfBrpFaR70pZFcKISHS?=
 =?us-ascii?Q?9Zjfb0YnTOGrRDLaMnNQOVcg/Wvv4afv+aMv3MpmcetpAv6Q3IvYb/Vumokf?=
 =?us-ascii?Q?6ggOojmwF4TDqjtIiILvT8R0Kods4uH2ZDyyoSaA9RWLlnz6LQu5Lr+ShTnl?=
 =?us-ascii?Q?kYMw6/2jmREGCQlMkY4oZ2O2QfqF8IVY+t7ZJQMYQf3VCNi44KAKiksXVMeM?=
 =?us-ascii?Q?iSbZHkBcm4r4leoEBeHYRwOxv9yu6KsnKtuMcOJ+Bj5EPnmNRa29YOr3+lJ4?=
 =?us-ascii?Q?1oaGX5T9jxsuQHUbSgw3NVAQ8dG2Qa+b5YjGUo6qV28ixplg9mHgmihqCxSc?=
 =?us-ascii?Q?2T+X9lr5QX6HzRdjE+hKsKAhd2W9tMg8KOG5ZXVBHXcBeRd8DXyh8p5QxSZJ?=
 =?us-ascii?Q?W0byAk+IPL5TKmcHlx41v33P8QAxYiKnEVZQE/buJny0N8W3i8LLNKa/daHr?=
 =?us-ascii?Q?Zsb/KmIygb5Lm9PB1RRiPv5au+VutfAho7KT6pE16Hx9mDqz4ggnd7KV72j4?=
 =?us-ascii?Q?10hyfWYzJ2+CRk5k33IFi/BRUMnp9+UiB34/YxW84fmiG3WONQ1zcG3bj5O2?=
 =?us-ascii?Q?KXGMMhnIYePkVTJSGNyKs9XbM9kb9pxjF+De?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0soZiMhJJ+wXf2OCt4yxtGs0KaaKdZyZIAKHIq9hQWMnqtvUMZ8zOZ9xiyB?=
 =?us-ascii?Q?pjzByMIRU4NtPv1W2K5m8rvg9BMEz9Yp+4/ruEn+B76qGBXdRMn//2Sw4tUb?=
 =?us-ascii?Q?a/6x+7DTqXqC3g8cUtvgRpFQYOC4UuRL98XMn5J038Dwv7lJ33qTjSTBkKDz?=
 =?us-ascii?Q?Afg2YYiKpkUpq3onRLLfxqzuhgnCMSr7FBWrM1aa0PbgdHPLpxz9NDrQoLNL?=
 =?us-ascii?Q?pl3q9aeFxWpepSInDNph4S/tFph0D2c64Jrcn72ixsq1PdJYALNw/puC5QVL?=
 =?us-ascii?Q?/uztEPEWg7uimh/4nk82c4BitbVfa36qDb+AzGLx17e4Y+jpCz+pzwoLBZcQ?=
 =?us-ascii?Q?0WqgpMKIS9HqUVXm2XHZS9J2GBzeEKY3DjaLSiYbG1DAFygPWzhyyEmfIHvI?=
 =?us-ascii?Q?59I7+zhoZVik97fXtj9UIdPzVy0eh+X+CkttzdIdgQ9CBlbh/GVr/Im6Pe48?=
 =?us-ascii?Q?zWnu919tebZoZ4rLsqdKrsucQ6yokCUF1dDnzpkxDtiOh/rwK+u0pblQm/4e?=
 =?us-ascii?Q?2ITy3K5gXXkiLrE6Wrmn9PgQejvLydxpvfgGTrK+v/ia+PW9t3XIRnOeOz6j?=
 =?us-ascii?Q?v5yL+dTG6TxLW0nYQ/25sY4yei839K6jRkxuxaKBS3t4CcB0VV8ckHRtkuST?=
 =?us-ascii?Q?x637OJy/TmQdZAaU7hTQKWUBQnqwqTZMRfkt2xLGknBya3i/v/KjhuXEGX6F?=
 =?us-ascii?Q?OFd6WbCFFyygzNNSwI3u0CRZ5l7i9jXwU/7FLY8oPGnDt7Y0DoPbVr/X1eOZ?=
 =?us-ascii?Q?npYoMpQlVHzPH0EvXF3xpSAZC1CwU7ulsScdvCCVDgZdtfsjcCn61DN22F+P?=
 =?us-ascii?Q?LQRfr7HxSj3XRVJmXSm3ZJIj77mBRR2vemFUj2rMShd6vsS47xSP2f9VXa5e?=
 =?us-ascii?Q?uSmY0sz2VwTxbnxb58yjrZgK1kqLOQ698LQmnDdOOXbaX+Int9vWGc6qX9pK?=
 =?us-ascii?Q?A85L6MNkrhstbTCcNf5CfCw5udtHjB+BA/khH30T0gtjpdTdPXEemSagSjMc?=
 =?us-ascii?Q?wfxfJkfxNiZlPcuP2cKn7+ZGxYBMnsMaJ+RPFAkqvN3uTraidV4NU/tsBr3R?=
 =?us-ascii?Q?kqQyIlxajI1KsGhZPmuFio7dW+8ftdDmrlUuxVhgAmk8UeWS2hxeKfzPJlnO?=
 =?us-ascii?Q?5WB/CI1Xerql+eukRhE3+2erLRzcsFsdO/XECgqhtBrN17bwMsOH0k1R3LcO?=
 =?us-ascii?Q?WSHqmf987MgytgREopW8ROKJeBlmzkRSk2dvERdgHQ9Bd4IM9rwEIpIrrLCD?=
 =?us-ascii?Q?LbwBXOEC0zzQOjetty0x7WZ9StLre7HnVmOk3VB+VZ3Dr7go74oqlW0rwAXy?=
 =?us-ascii?Q?pU7jI+ntHz3zc7vM9Bs2YzkOFISoiPv/Lmg6SmUD1yi512+4/RJ75MQV6tKF?=
 =?us-ascii?Q?R512O61OzX9m0LXFjvuBwenPWQ/JPjze0DGav9P4H0nNfdiYJnJbO8Ve4odp?=
 =?us-ascii?Q?QGCYcdtJCoBaJvQlNSp+fyIBuTrSbEcZ6xPtQvNZ0nEliG8DrR3awv9Oes/k?=
 =?us-ascii?Q?gJ93aolllW8prQP7C262ZnQUt5iMlEcgqLFTkZ/AzBk9Q3hzq5WhgyUWgl1y?=
 =?us-ascii?Q?vF+IbTF4YqnXfoRsvBgoFES6J0iqmrtFIR8I5pOYa/ggMAHRpQ3Uq6yaR7xj?=
 =?us-ascii?Q?Sssedvfji6HWjUQafyFVmMKSwd7oHIOwaqQnTFnFY442UM9kO1qWXDnoM942?=
 =?us-ascii?Q?4t2TggjHt8Gf/xk37CzI29KqI+k5jZJt+WnEz8924n9cZVIo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a750e1e-8ef6-4d2b-83be-08de4d174237
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 11:32:22.3438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Af6BxwsiQSw4DanXtFXxPePWwZIMYu2Cxbmy3OHm2m2HzHicDHlWSPyRB6ZRiOpxc3NRiM/3GmA5YiUZci8oOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, January 6, 2026 3:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH v2 00/21] Add smu message control block

The series adds a message control block to take care of driver-PMFW mailbox=
 communication. This helps for individual IP version to have its own instan=
ce and differentiate if there is a protocol mismatch with the common one.

Message control block primarily contains -
        Message config to provide mailbox register addresses
        Message operations - callback operations to support messaging proto=
col

Both may be overridden by IP versions for any custom handling.

The legacy ppt callback functions for messaging are removed as well as part=
 of this series as they are not used.

v2:
 Write all message input params and read all output values (Asad)  Modify d=
ebug prints to print all in/out params.

Lijo Lazar (21):
  drm/amd/pm: Add smu message control block
  drm/amd/pm: Add message control for SMUv11
  drm/amd/pm: Add message control for SMUv12
  drm/amd/pm: Add message control for SMUv13
  drm/amd/pm: Add message control for SMUv14
  drm/amd/pm: Use message control in messaging
  drm/amd/pm: Add async message call support
  drm/amd/pm: Replace without wait with async calls
  drm/amd/pm: Remove unused legacy message functions
  drm/amd/pm: Drop legacy message fields from SMUv11
  drm/amd/pm: Drop legacy message fields from SMUv12
  drm/amd/pm: Drop legacy message fields from SMUv13
  drm/amd/pm: Drop legacy message fields from SMUv14
  drm/amd/pm: Drop legacy message related fields
  drm/amd/pm: Drop unused ppt callback from SMUv11
  drm/amd/pm: Drop unused ppt callback from SMUv12
  drm/amd/pm: Drop unused ppt callback from SMUv13
  drm/amd/pm: Drop unused ppt callback from SMUv14
  drm/amd/pm: Drop unused ppt callback definitions
  drm/amd/pm: Add debug message callback
  drm/amd/pm: Use message control for debug mailbox

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 111 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   5 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   5 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  21 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  17 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  29 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  32 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  27 +-  .../drm/amd/pm/sws=
mu/smu13/smu_v13_0_4_ppt.c  |  24 +-  .../drm/amd/pm/swsmu/smu13/smu_v13_0_=
5_ppt.c  |  23 +-  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  32 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   3 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  12 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  23 +-  .../drm/amd/pm/sws=
mu/smu14/smu_v14_0_2_ppt.c  |  31 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 700 ++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   2 -
 28 files changed, 671 insertions(+), 525 deletions(-)

--
2.49.0

