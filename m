Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EF5CAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 06:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD7310E342;
	Fri, 26 Sep 2025 06:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ny9Z1+lZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4301210E342
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 06:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTS8o5qeO1RDlnnDLskxnF3933tkyQZ5JlMlkomdKVICQF0biEWhQTOifMO/4oae9XmxbTwZvihi6HePwaCjKRPbWTEECsxeJXm2CT4b/U+5vp220iKtEfa/nbIpX+1wUF+MAWW1J1rx6Xi5qUGyrpUagQX0h8F8ufYSbQl3mSvCgaO8YX9e8iFy3GdAyRLqOG8m1xzpXupAQa9kIzo4yJjJGefizpM+4TKvcgPGEOr6gZ9cNXNvyTWzcNzd0JXkcZM4MPLFXY42Gy1mdRvGzF2pWRiEViVr6ZIj3wSuABVnq1IZJZGrzKS9i5sxSHipVuCM7FEBtOa71cqCQmwYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1lUyrpeFBLGlKPN65rPLcHqTkQL0Sw3KbXjdUaXSZE=;
 b=nCEvFM03MmYJHgK8tbCPd3Slt1XUfXm12yEhohxEbnnP4/qJ6/h+N9AM+smAfz3jGgnVeDjhqq4/wacjXTDYYTMFzKWna+gCzZUS4PIoYBt1qabVOw+SeeCIV3yw7YHL87BIC/Mb0D4ZNzzEOI8AmHRAkL2XKuzFl3tv9TvpRpTQiikIBoMI60NU7IpC0yGGIjLOoFi1MemeCJDIkBu+VBT4doJ20Sgq+OHhBmYlg/BdQMtG8pCMcMexekBBlzGzDXk1r5ul+TmsxRAv5fb7bqzzru98I7Q+bHe4xQn9cjA4sWb8pGmXu9jKDzmBskDBwZmGj2cl7OemwTawKWJQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1lUyrpeFBLGlKPN65rPLcHqTkQL0Sw3KbXjdUaXSZE=;
 b=Ny9Z1+lZbTORQmGRb77mgh6scphe1hzdc2sPNm8/pMj4Tqd152l5yPMemDWY5GeGc5ZDyImITeFl5215INKkAPkob9dw3xbMO4J/OWnrm2rf8+oU5/hHoDJe1T3WS9Qrf70wwSawdoUW//PqHkiY4uM8xqtdvextcTkQi1TPPK4=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 06:55:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 06:55:24 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Topic: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Index: AQHcLq/CnRqszrely0C0m9n0ee75DbSlBt9w
Date: Fri, 26 Sep 2025 06:55:24 +0000
Message-ID: <DS0PR12MB780479816BDE27232614F6B4971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250926063345.1131635-1-kevinyang.wang@amd.com>
In-Reply-To: <20250926063345.1131635-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-26T06:52:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|IA0PR12MB7776:EE_
x-ms-office365-filtering-correlation-id: d4e8bf62-91f1-43e5-0fe4-08ddfcc9ab2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?93Lx3VPcx8zQ+LYYuKD/M1CU/ucOAooC06B0o4UmqBLRmI6uZtYNGUY/CY9m?=
 =?us-ascii?Q?CTWUHIKtQwkNv96lfQLrDBUo09lHBlasaClyZPhyVnzquTx/ml5nNNXjwgq7?=
 =?us-ascii?Q?YzaRPlYwsDy07mMqlXzEDuhglX1HXyQV4g5oo8Uy3y/zlozs7uDRHt/7mHaV?=
 =?us-ascii?Q?OMMoli1hvEKaYk5pMupwt7iNtZndMYjN9r2db/7TUwBPbO+2pbaSv96thANv?=
 =?us-ascii?Q?2ZkXfiMicdkKzyOWSVUAObxbf7yOvraxPjWdLZf3KpFAxfuNdlvQj53OgUEq?=
 =?us-ascii?Q?SWyIB24ydEvdc68Bzh8J2TNMJhJHLjS27Ifoqa5K0dfN59ycvuND19iH+8GQ?=
 =?us-ascii?Q?lGuM/Y6eMtfVh1tmGfheKunjnxxEXAUs1HPCFWKV29GMhDF7AtCz5AgYhXSV?=
 =?us-ascii?Q?8HLlaFDpeKKRNq9HYq93xBw8u8O8P6K/Z9waqw5JEA2Qvrmioe3hGIdpdMhF?=
 =?us-ascii?Q?ymDmBg4Pi/QeWeeDii0Lx0XEDeauH9h7f6n4sZpeFkF5N0yB8NElKLoXvicZ?=
 =?us-ascii?Q?/eiALwcH0Z2YJ2aMbE27z55qgrB+lxXK6l1DazeYlJy7T5JvYK87gXH5u228?=
 =?us-ascii?Q?2hL4W2bZcHH5OQlCeAaJTh/4BsDXx21tbbNH2dEI3rZBNrBIUmvMbvttbU8g?=
 =?us-ascii?Q?O2KMkYmr76UMdgJ/tpy3GOeewzZYjOUTmBNPUxVXfwSVu9WgFUBthuL61f6T?=
 =?us-ascii?Q?hZ04D4O7is7Pg59JdBUyriaPwrhEKHMGkrmPPht3viz2P/bs0S/jJ4n8GON9?=
 =?us-ascii?Q?KPXTuEGVMhnagN7CHZ4ND8WqioCuXo5MEdlHD4zXsbmT1GDFF5lQlX3wfc+7?=
 =?us-ascii?Q?wRFuIOTL9alBzpEnOLce2FvflhGQN0bUy8gcbQhLomrmDr5m8Q14vQiNRKVr?=
 =?us-ascii?Q?59ejnHqNX3z6Yv66VKkW4ndDf9+/7dTahEjrR+ZWSvxSo7BUI4eNuvy2/1+6?=
 =?us-ascii?Q?NHPuIgTbi4N8v7X9GoBXK0kYgRqYj8cbgbC52ouACaokgqOGoVq2r/je+6Nl?=
 =?us-ascii?Q?AaatJW62GTcmyZ2i+MXE/bPeKXWLoUtgXaFFhnBR8s+AzwyXKaIWNX+cbeNz?=
 =?us-ascii?Q?wiLHXCTX5HQqj+k/ZYdGoBQmzMBLvgOJ/y6u8WhbIX1I4g/w408aOxA8Kvtk?=
 =?us-ascii?Q?u1rov5qmSleeAL/JFkcn3PVjozxvwjMovGe+Gi54yXIeyQiHlGsWdIIBB4cx?=
 =?us-ascii?Q?CPOw2LBDktUURU6rdc6b6ZM8jlfuepSU9YcDgrvAAbOJ3+CZm+HegpMoH1Ww?=
 =?us-ascii?Q?6UOqXvrCLq5uf8eLrSAwBcbCV8wVWRXyQevXVIt9YKk2YWeMOQHhpABQ8/ji?=
 =?us-ascii?Q?g1RyBiik5kqLpD50dDUOGWbgNPi/Mp7SCxtRzdUzctZT2QKn6+Gby6a0p0rs?=
 =?us-ascii?Q?lmWubfcIifGb7b8e+AIxKZQkAGB42jRbpH8XmC3tEYo6yHDKVWecj4CSqgiV?=
 =?us-ascii?Q?FgT7zUMq3FO7dF7R6KGlx92LKyhkG+eQv1uI6Kg6r5dYz78Pxn1cBL5mTWgF?=
 =?us-ascii?Q?eYoLgAr+wOWMS+I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UlGqc2mt39akPgkvIu8J3Rf6AIhrggMXi37LVPin8w1ijpKC7nOp4SAnnjj/?=
 =?us-ascii?Q?1VmQfYteESoZO4vnuLMoS2vyertgwibGZWNGIJGlVdsXym+q3Xh084Xv/D/Z?=
 =?us-ascii?Q?l8ccKd89JLh3irUZmjXfgpFD+x/DmO3gkp9hHzg4nUTuh35c9UGV/agpWNvx?=
 =?us-ascii?Q?j5Oxt4WBkJL8yqvchpynt646BnTORfNzGhQxx7uzNX8ags2jhQKQcpPUh7FL?=
 =?us-ascii?Q?C1+vhJEdYmZO2m12VJ3Oy2u2kVSshAnmrMZperiBD31+7ibFB1UmXrV+JmQB?=
 =?us-ascii?Q?KaaOlsO1H8TsVir5hUnapQy8T3hS7btQT6ww9dDqWg7f+AArkkJ4D2I1tM0z?=
 =?us-ascii?Q?4/7eKStIrd9olm9mHys9oAPFE2+H6QSO14rLuK7aWaubucD0nDGWALvMKNQt?=
 =?us-ascii?Q?hfX9jIrN0wOIC6FUPqlkaFFI7LSewQBNwbqS1vXMd0DnH7ZSKbiOcZYn0KbT?=
 =?us-ascii?Q?fK00aSRPhExEwbbkSE0OAN4e7SekUpTbGXkzMP7RHbRpBiBeMkUC6FZoYrAH?=
 =?us-ascii?Q?11SY31hNiYQpNt0QjOZh4PqEipYHVSjWIT2VTVYZTuVCx26dyNWsSi5H4Q7u?=
 =?us-ascii?Q?+IQwU9Vun9hqOZhgP7FfhgZpvWnsBBAxWNiH+qe6r3lEVFv/KWwNxj15jKQX?=
 =?us-ascii?Q?TxIqsH0cKJg5VdFJn1us6QweC6BqaLoe6QdwfnyO1sT/FGMH3dPZNgjfl9rA?=
 =?us-ascii?Q?2vKlaYl/Fns0DuPqQ2sGdTx4MTbXWrwuDH57uZhNZPe2sXIbZeZmwkppsylN?=
 =?us-ascii?Q?HbviNOsBfxxMFlEggBxwybgLdej9uI7gTdUl+nhXB/nlRA8n9cXyE9uH7aTZ?=
 =?us-ascii?Q?8Lsu23NhlP6ThY7psQC563ngOJ/GdfLsZ6nmSPcn1Ute/Y243kJM/poFX9H8?=
 =?us-ascii?Q?gKA+jwYdm4JstU8bm38YX4oHRzZfmisWxaSNjGeoLYmIMUumIacpJLM2HuO1?=
 =?us-ascii?Q?8ttlWo/fLan1VxwzHAHjar4wwtECskezm1cM8SKEd7ayau+CeUL25wgWgNFT?=
 =?us-ascii?Q?H4C0NvKjJ7yIeGJLnI5k3FnQKVel9KduFrDLBma15nFBVr5w0VWxzpwlb4pu?=
 =?us-ascii?Q?U2OqINwEvTDmB9LIdBgAPGsK2IMapbw9qlsWAH2onNVXt3B+oU9/1DJvTN8h?=
 =?us-ascii?Q?4b352ebcolsMSDlTWULLY1qcH+sMm2DisQQvRJ3n2Gacrs7hHNLDypvYG8Kv?=
 =?us-ascii?Q?IE0goEXmPqK+P/1GYoz8kOSfXlcJnUF4YMNR2xSXsAsgDBOpG0WVO9LuA7EE?=
 =?us-ascii?Q?dO812w5/22O0YQH8SzpMtsJYo63yWf84cT9nkC86jAFbSkcylAB8c+UmRH+v?=
 =?us-ascii?Q?EF5SbsXX5l8MZOubPwgIxebJ0lRM/E552pq5D4kH0idsEYZMYHt1z6ictCY1?=
 =?us-ascii?Q?PeWOZlKiFCrz2bpT54wzRn42Uobt4mphFlTbRx7Aj/NkqGJHcb7uHxhpegYJ?=
 =?us-ascii?Q?EhcvrcH6WOwcL/Ft38WPluTQAYl63OaW0GC9/tLrdvfOYvtoN1b41QiHul5j?=
 =?us-ascii?Q?waXC8IDbqzbZnmu0f8PBZnLVY/htKTfAcc6mZyPKMT1qAh10+5/SDWP3DMPd?=
 =?us-ascii?Q?/HZFq1SX+HjXgLUhHLU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e8bf62-91f1-43e5-0fe4-08ddfcc9ab2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 06:55:24.6944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ch+sqgL6Cw/Q+5VyP7/pw7xhRfPI8HLU0TvUqbvyHHIntqVoxbBCgQSE0d+m1vSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
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

[Public]

Presently, there is this one also - drm_dev_wedged_event. Perhaps it's bett=
er to modify this to include additional info like pre and post reset along =
with cause of reset?

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, September 26, 2025 12:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent

Use the uevent mechanism to expose the GPU reset state, so that the system =
tool can more accurately monitor the device reset status.

example:
$ sudo cat /sys/kernel/debug/dri/<minor>/amdgpu_gpu_recover

KERNEL[172.053149] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0=
000:04:00.0/0000:05:00.0 (pci)
ACTION=3Dchange
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0
SUBSYSTEM=3Dpci
RESET=3D1
DRIVER=3Damdgpu
PCI_CLASS=3D30000
PCI_ID=3D1002:73BF
PCI_SUBSYS_ID=3D1002:0E3A
PCI_SLOT_NAME=3D0000:05:00.0
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00
SEQNUM=3D6235

KERNEL[173.137681] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0=
000:04:00.0/0000:05:00.0 (pci)
ACTION=3Dchange
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0
SUBSYSTEM=3Dpci
RESET=3D0
DRIVER=3Damdgpu
PCI_CLASS=3D30000
PCI_ID=3D1002:73BF
PCI_SUBSYS_ID=3D1002:0E3A
PCI_SLOT_NAME=3D0000:05:00.0
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00
SEQNUM=3D6236

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 2a0df4cabb99..73c946d9cbe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1805,4 +1805,7 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_inf=
o,
                           uint64_t uid);
 uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
                               enum amdgpu_uid_type type, uint8_t inst);
+
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a77000c2e0bb..300cc22dad91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6318,6 +6318,7 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,

 retry: /* Rest of adevs pre asic reset from XGMI hive. */
        list_for_each_entry(tmp_adev, device_list, reset_list) {
+               amdgpu_device_uevent_reset(tmp_adev, false);
                r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_context)=
;
                /*TODO Should we stop ?*/
                if (r) {
@@ -6362,6 +6363,8 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,
                 * in before drm_sched_start.
                 */
                amdgpu_device_stop_pending_resets(tmp_adev);
+
+               amdgpu_device_uevent_reset(tmp_adev, true);
        }

        return r;
@@ -7669,3 +7672,39 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_inf=
o,

        return uid_info->uid[type][inst];
 }
+
+__printf(3, 4)
+static int amdgpu_device_uevent_emit(struct amdgpu_device *adev, enum kobj=
ect_action action,
+                                    char *fmt, ...)
+{
+       struct kobject *kobj =3D &adev->dev->kobj;
+       char *uevent_env[2], *tmp;
+       va_list ap;
+       int ret;
+
+       va_start(ap, fmt);
+       tmp =3D kvasprintf(GFP_KERNEL, fmt, ap);
+       va_end(ap);
+
+       if (!tmp) {
+               ret =3D -ENOMEM;
+               goto out;
+       }
+
+       uevent_env[0] =3D tmp;
+       uevent_env[1] =3D NULL;
+
+       ret =3D kobject_uevent_env(kobj, action, uevent_env);
+
+       kvfree(tmp);
+
+out:
+       return ret;
+}
+
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done) {
+       int val =3D done ? 0 : 1;
+
+       return amdgpu_device_uevent_emit(adev, KOBJ_CHANGE, "RESET=3D%d", v=
al);
+}
--
2.34.1

