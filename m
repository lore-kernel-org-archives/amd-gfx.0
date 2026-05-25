Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C245CD5BBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 09:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3E510E0A8;
	Mon, 25 May 2026 09:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oW4KB75h";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E19110E0A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 09:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0kx/f2CCg9cXdaumXAHukVhhCUsgTI3v1CA+Y9K5sakxej0FzcDFP9DBzpxfFACXBP3quK/ukwq5fM96ZE5OwmOdmXV41JY1y707lSe7OBAOrpbXapTFQIGeDDRfVD86/NwMJfE+vH151DiU40CosccD3BvX+Qwc5r5S3C9SSNriPsmeFHPSvoahSD+oitTB+Dtpon+mIBJoLWvitk0rx0EjTGyGyHh7rzhWmlwLa2iNkc43X/sn0T2irFjbn+PXD2BFlj55pYn17OncSB9E0sXffk0585vZPUWYp3EB0R+wK8WCRtUC83xOIMXIrcZ+lfIlUyD4yL93iafEnJmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGq+S9aUQo6GaVD13DYb0K1K1rvIYI8vefjAkGkOdFM=;
 b=moqvkYDs0eiOSCZ8LUaAB0Iw6BpYopggWy4wVHPwsIQD+VNJdrrnWQy6qcMKJ5GXvN+CqjAOaAW5bWBawIa3xU/GXtEj8tZHiXLnzvUBBOoY2eMczNX9Kk8B7TgK6Kb+atDFoYXjhGxlCZGhEHOKQP8194ZeZBBer5zBYTplYHC3L9I5AC6lFJKkoa4DbknCqMXoEUxdIbO5BpOQXOMnfgOOkvetV/RHK0Yoc1gSSI0ag5yasHSn8NRDTrLVpja7mM5e559Xs+X2f9n38tgDYtMi4sZBkj7EA2BqmBWjdEAhcbyv9o4WAaZZrNE6ng/6lqX2nopwxbAgNdH8hOh9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGq+S9aUQo6GaVD13DYb0K1K1rvIYI8vefjAkGkOdFM=;
 b=oW4KB75hMjLmmJVmdkHi13vdtV0pN85VR1s3QC4lzrrmy4UEv9a6CQO1E3Od+hLGmVyO3jkypeaP4iXZ+jmY18t9AmUJidEwujxAplXkanRE9C9l+S01VX85xtGx1QpJo3Aln4qI9z2A2skWMX7rOCyu2Kv4O0WZimoWDIUuJRk=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Mon, 25 May
 2026 09:21:29 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 09:21:29 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yi, 
 Tony" <Tony.Yi@amd.com>
Subject: RE: [PATCH v4] drm/amdgpu: grow VF RAS bad page table with bounded
 dynamic alloc
Thread-Topic: [PATCH v4] drm/amdgpu: grow VF RAS bad page table with bounded
 dynamic alloc
Thread-Index: AQHc6T/VU9cke3DFw0a0MeqG2C2kErYeeRhA
Date: Mon, 25 May 2026 09:21:29 +0000
Message-ID: <BN9PR12MB53062BBA5D48A31AC7E2EDDCFC0A2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260508180705.217683-1-Chenglei.Xie@amd.com>
 <20260521163517.1823660-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260521163517.1823660-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T09:06:39.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|CY5PR12MB6527:EE_
x-ms-office365-filtering-correlation-id: 532c5854-2614-45a2-8422-08deba3f011e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|4143699003|11063799006|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: qaumCgz784sJY7YBK/TXGnzHUJvcob3pskG6TZ48b2+3V2PynqFdE8INL1Z1u6Th2TogXGMAhf2/AK116+86U4hTuCpz5FvoUdlWFY5mJ11rTqC5y8iXLJccBoC1ZGWK02eIsM4EfFvX873q1UMy0yp9R/ZwLj0dK7+OlsiGd78pz3Nom39M8JW1jUONjfDd9Istvq3INH+e4CGjfrYGKYFJv4JQT/5OFoKs8VEWu83sWR4zbLP/TzH8L2xjm0uc8WoVlAu6I8OC1HJgZBkL7R3l+qnn5WTKy1LaR1J1D6Akkvy6geUFJyspNLaZaUqNMQilqlRKMNlhAn+KYsAM0XzzQRwqhdLniPBgn0XvHa+exQzzbWfWpe1OTfpfpp0KwDrH1KMt4d5DUp0Y2Zc0uYUXY89koGSJhX2WxGPZXBlFHxIapiqrD79EeLZe7zGQ2Bv2zwBp4PLMLyfujOg3NxMmzjBVeBbXukzFDG2MdjoxUoIGsgeZHqUWj8qxa2uLj1K5rCMi2UqIqK0o9ZVDCGA3U+PvbvoyIA7GfCG/NjbACK74UBdWJnCsB73Enf0n6FN1CX35DCX260ikbqcFHZoJ2n3NGNMrEkEtqisZyulChkZQ8PvPwBvhlgdtKiHfL7Mii3cgad+Zqdude+7ucni9riwTg0pidLFSWANU5Xc/ruZ8aOGCm8vr4ytq4+ubID0QUY3uikdrgaWYNgCi/OH6Xbm2Ds3pvgD3sFcbImBKEGw4slmTsNaEJyreV0H/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V49dnzRtI3dkVG7Sr169kmQM1TUIedm9mZkXAPbyDyYjTc19sSk1txIO0GKT?=
 =?us-ascii?Q?RBzJgheJXLd92LYKmRhcmLt4dRzKdOEO9ZL+B7f68euWMqBkoyGStYYoqUiv?=
 =?us-ascii?Q?6gf/0h1olJqVBSTVduhDId9VxCwu9QSBf87r9Yo1IR2vshj3fCFOpJPoclO6?=
 =?us-ascii?Q?oHMzLklTug2XXaqM0VktyMi1QlEj4DgxaGYBQtnpv8Uy4ZdkVU2DK7QOPZi4?=
 =?us-ascii?Q?ojmpK73lkbjBZN0/viWStQEaBoeCw/iUwTLYjS0+M9IJOusoqx0vpLR/Bqq+?=
 =?us-ascii?Q?PMsqgoriflecZSjt1mGyKlbMuL8XhQZpKmWg+bGqSXKDUVb6AhKHq+7QTXH2?=
 =?us-ascii?Q?B4aWMBEqVXUFHBjmwbLq/f89fjJXNKWzRkxbsqWmwq4qT8eIxwn9Bmwt1Jjk?=
 =?us-ascii?Q?CxT/Zny4K9iMUQHgn7+BiG4ZAr5Kvt/4TyaLPcpI83++hPc1lkPOAOnCC1Bq?=
 =?us-ascii?Q?2fqEolho7hs7XP3ywxrq/Q6mOfRR6M6hUjq3vIKO7ydMXFIQBUt8is8cWimg?=
 =?us-ascii?Q?25r0kbC0REvf2MIjpYTgxB438Ln9pcYXCTtL2yT31WOLcIgyE77H2mnyYgVh?=
 =?us-ascii?Q?t2xHRr6R8IfLmzv2M4Ohwfuwrsuc/BzzxN8FLIjVFBy+IbeyBhRHCsyQ7WkS?=
 =?us-ascii?Q?2J3zFpuBnoj99mo/IuevBVmZDAK5Y6r68ACBN5j1YmXqg8NxurGmkHO+YlkN?=
 =?us-ascii?Q?Xu0RAv5yczi3TzKHgwBeYbjw8L3rX6xXH9bT1b2wq7dtaQ5Hz87SPtsPSioZ?=
 =?us-ascii?Q?KCsO6K+IK6Seo5ShksH9NE2pV621/9Db52GvBwYvqJ+xpayraHmjLEhXhqY2?=
 =?us-ascii?Q?RqMfLYLwNjvh5SghInLr6MYjWwn88WbSld0H92DUEbDn25ydqSpjbhmCibcK?=
 =?us-ascii?Q?wi77z90JAK+ENviISAol54cI5gtAJgS7dhBgkJEUWyDcguxoTkTw+6RPHs1B?=
 =?us-ascii?Q?leUUicecyXmAXsmRsvxEqvnaN8G+UYoG+aj7zeb1h7Fl4gw8CkJmUO264ZKu?=
 =?us-ascii?Q?I/YcvuEPAc1JSWJqbn6Qc2QRd5BuwPDy0a2q76pGLf2mI/jixHMGMUy5rN+w?=
 =?us-ascii?Q?fI+jsrXRNlftwCkC/od8FrZFbQS2CbZKK1YGG8DfvgxiOXH2FJlZcMfXOAZk?=
 =?us-ascii?Q?YtTzFIHjYr7ulYUA6ZDmQlpMHZWBbc9zkqg8M22WsH3c40wbBBU6g2f5UmXf?=
 =?us-ascii?Q?W94vV24bEiHGxS/bY1Aj5LqHH9IUHq7rcqMsW88T5KttYzw91E3Fp1PpOpHI?=
 =?us-ascii?Q?dhti80/4pE6ZrzRfYFi23Zz1uh7JnV+CnKQmFfjds7hTWu0Aj+9suhVtvhVy?=
 =?us-ascii?Q?PihlmOKAwYQ1OamoPS7Gb+7uVLkWW7RjCG9YQWDM2kd3KfCiYYmE9Dr8uQ74?=
 =?us-ascii?Q?idx77/o3mPnhWzFSdUaSEEcxt7tlTPl0RGAOosV5byepGh18D0+Iv30fL7ZA?=
 =?us-ascii?Q?iq8t+b65sX+DSBjM31HNHIhYaScqUStskZIdvR/szfyPhFNBkyOtHwRhm//o?=
 =?us-ascii?Q?1I7B9femArela0d2KkMS2anODKWT0+RQ92btnseZoGjkvCFrH2IW3FjmuNfh?=
 =?us-ascii?Q?cQystZLjSorSDRGz7eQgt1PvxO76luZWP4nwJyy6ddbI+bKiasLJCoh4rUnV?=
 =?us-ascii?Q?1tiSq+T5wQszxuDvQPqWcSJUQRqpaTzNNs1h4p4P/f9+LrrHFhhrPujnS+O2?=
 =?us-ascii?Q?FWa2DDu7SGlnXvjiHJaE9LXRek/eVS6C3RpZrCwRVYoaicyC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532c5854-2614-45a2-8422-08deba3f011e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 09:21:29.7440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7myyKmZk/E6Tb2qykQPYhq1rrLeOsfaClWo4/QA3hFubGyKfHSGahKhVsYlpSXBwbR8dLVxmQYEJIUHEPeA/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

I suggest defining AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY as an absolu=
te value rather than referencing or modifying anything in amdgpu_ras_eeprom=
.x,
Since amdgpu_ras_eeprom.x is also used by amdgpu, the maximum bad page capa=
city requirements for amdgpu and amdgpu_virt may differ.

Best Regards,
Thomas
-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Friday, May 22, 2026 12:35 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xie, Chenglei <Chengle=
i.Xie@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Yi, Tony <Tony.Yi@amd.c=
om>
Subject: [PATCH v4] drm/amdgpu: grow VF RAS bad page table with bounded dyn=
amic alloc

The VF RAS error handler used fixed-size bps[] / bps_bo[] arrays (512 slots=
). When the PF2VF bad-page block listed more entries than fit,
amdgpu_virt_ras_add_bps() could memcpy() past the end of those arrays.

Replace the fixed backing store with a dynamically grown table:
- Add capacity to track allocated slots separately from count.
- Start at 512 slots and realloc bps / bps_bo together when full.
- Refuse growth beyond RAS_EEPROM_PEAK_RECORD_COUNT, the largest bad
  page record count among supported RAS EEPROM layouts (v1 and v2.1).
- Return failure from amdgpu_virt_ras_add_bps() and stop processing
  the PF2VF block if allocation fails or the cap is reached.

Move shared RAS EEPROM size and per-layout record limit macros into amdgpu_=
ras_eeprom.h so the VF cap stays in sync with EEPROM layout.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: Ic8dd487d91436759bee0e201ce90ea1f2266a161
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  17 ---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  28 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 110 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   2 +
 4 files changed, 120 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index c61389a079822..c7a813e5fa0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -58,15 +58,6 @@
 #define EEPROM_I2C_MADDR_0      0x0
 #define EEPROM_I2C_MADDR_4      0x40000

-/*
- * The 2 macros below represent the actual size in bytes that
- * those entities occupy in the EEPROM memory.
- * RAS_TABLE_RECORD_SIZE is different than sizeof(eeprom_table_record) whi=
ch
- * uses uint64 to store 6b fields such as retired_page.
- */
-#define RAS_TABLE_HEADER_SIZE   20
-#define RAS_TABLE_RECORD_SIZE   24
-
 /* Table hdr is 'AMDR' */
 #define RAS_TABLE_HDR_VAL       0x414d4452

@@ -87,13 +78,9 @@
  * ---------------------------------
  */

-/* Assume 2-Mbit size EEPROM and take up the whole space. */
-#define RAS_TBL_SIZE_BYTES      (256 * 1024)
 #define RAS_TABLE_START         0
 #define RAS_HDR_START           RAS_TABLE_START
 #define RAS_RECORD_START        (RAS_HDR_START + RAS_TABLE_HEADER_SIZE)
-#define RAS_MAX_RECORD_COUNT    ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SI=
ZE) \
-                                / RAS_TABLE_RECORD_SIZE)

 /*
  * EEPROM Table structrue v2.1
@@ -116,13 +103,9 @@
  */

 /* EEPROM Table V2_1 */
-#define RAS_TABLE_V2_1_INFO_SIZE       256
 #define RAS_TABLE_V2_1_INFO_START      RAS_TABLE_HEADER_SIZE
 #define RAS_RECORD_START_V2_1          (RAS_HDR_START + RAS_TABLE_HEADER_S=
IZE + \
                                        RAS_TABLE_V2_1_INFO_SIZE)
-#define RAS_MAX_RECORD_COUNT_V2_1      ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HE=
ADER_SIZE - \
-                                       RAS_TABLE_V2_1_INFO_SIZE) \
-                                       / RAS_TABLE_RECORD_SIZE)

 #define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.h
index a62114800a92a..4ac0d67f53743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -30,6 +30,34 @@
 #define RAS_TABLE_VER_V2_1         0x00021000
 #define RAS_TABLE_VER_V3           0x00030000

+/* Assume 2-Mbit size EEPROM and take up the whole space. */
+#define RAS_TBL_SIZE_BYTES             (256 * 1024)
+#define RAS_TABLE_HEADER_SIZE          20
+#define RAS_TABLE_RECORD_SIZE          24
+
+/* Per-layout bad page record limits (add new EEPROM versions here). */
+#define RAS_MAX_RECORD_COUNT           ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HE=
ADER_SIZE) \
+                                        / RAS_TABLE_RECORD_SIZE)
+#define RAS_TABLE_V2_1_INFO_SIZE       256
+#define RAS_MAX_RECORD_COUNT_V2_1      ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HE=
ADER_SIZE - \
+                                         RAS_TABLE_V2_1_INFO_SIZE) \
+                                        / RAS_TABLE_RECORD_SIZE)
+
+#define RAS_RECORD_COUNT_MAX(a, b)     ((a) > (b) ? (a) : (b))
+
+/*
+ * Upper bound on bad page records for any supported EEPROM layout.
+ * Extend when a new RAS_TABLE_VER_* adds a RAS_MAX_RECORD_COUNT_* macro.
+ */
+#define RAS_EEPROM_PEAK_RECORD_COUNT                           \
+       RAS_RECORD_COUNT_MAX(RAS_MAX_RECORD_COUNT,              \
+                            RAS_MAX_RECORD_COUNT_V2_1)
+
+static inline uint32_t amdgpu_ras_eeprom_peak_record_count(void)
+{
+       return RAS_EEPROM_PEAK_RECORD_COUNT;
+}
+
 struct amdgpu_device;

 enum amdgpu_ras_gpu_health_status {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index f8e58d12e39ae..fa3df31d3c476 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,65 @@ unsigned int amd_sriov_msg_checksum(void *obj,
        return ret;
 }

+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY   512
+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY    RAS_EEPROM_PEAK_REC=
ORD_COUNT
+
+/**
+ * amdgpu_virt_ras_realloc_eh_data_space - alloc/realloc VF bad-page
+@data->bps and @data->bps_bo
+ * @adev: amdgpu device
+ * @data: VF RAS error-handler data
+ * @pages: minimum number of new slots to add beyond @data->capacity
+ *
+ * Return: 0 on success, %-ENOMEM on failure.
+ */
+static int amdgpu_virt_ras_realloc_eh_data_space(struct amdgpu_device *ade=
v,
+               struct amdgpu_virt_ras_err_handler_data *data,
+               int pages)
+{
+       struct eeprom_table_record *new_bps;
+       struct amdgpu_bo **new_bo;
+       unsigned int old_space;
+       unsigned int new_space;
+       unsigned int align_space;
+
+       old_space =3D (unsigned int)data->capacity;
+       new_space =3D old_space + max_t(unsigned int, (unsigned int)pages,
+                                     (unsigned int)AMDGPU_VIRT_RAS_BAD_PAG=
E_TABLE_INIT_CAPACITY);
+       if (new_space < old_space || new_space > AMDGPU_VIRT_RAS_BAD_PAGE_T=
ABLE_MAX_CAPACITY)
+               return -ENOMEM;
+
+       align_space =3D ALIGN(new_space, AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INI=
T_CAPACITY);
+       if (align_space > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY)
+               return -ENOMEM;
+
+       new_bps =3D kmalloc_array(align_space, sizeof(*data->bps), GFP_KERN=
EL);
+       new_bo =3D kcalloc(align_space, sizeof(*data->bps_bo), GFP_KERNEL);
+       if (!new_bps || !new_bo) {
+               kfree(new_bps);
+               kfree(new_bo);
+               dev_warn_ratelimited(adev->dev,
+                                    "RAS WARN: failed to grow bad page tab=
le to %u slots\n",
+                                    align_space);
+               return -ENOMEM;
+       }
+
+       memcpy(new_bps, data->bps, data->count * sizeof(*data->bps));
+       memcpy(new_bo, data->bps_bo, data->count * sizeof(*data->bps_bo));
+
+       kfree(data->bps);
+       kfree(data->bps_bo);
+       data->bps =3D new_bps;
+       data->bps_bo =3D new_bo;
+       data->capacity =3D (int)align_space;
+
+       return 0;
+}
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *ade=
v)  {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data **data =3D &virt->virt_eh_d=
ata;
-       /* GPU will be marked bad on host if bp count more then 10,
-        * so alloc 512 is enough.
-        */
-       unsigned int align_space =3D 512;
+       unsigned int align_space =3D
+AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY;
        void *bps =3D NULL;
        struct amdgpu_bo **bps_bo =3D NULL;

@@ -302,12 +353,13 @@ static int amdgpu_virt_init_ras_err_handler_data(stru=
ct amdgpu_device *adev)
        if (!bps)
                goto bps_failure;

-       bps_bo =3D kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP=
_KERNEL);
+       bps_bo =3D kcalloc(align_space, sizeof(*(*data)->bps_bo), GFP_KERNE=
L);
        if (!bps_bo)
                goto bps_bo_failure;

        (*data)->bps =3D bps;
        (*data)->bps_bo =3D bps_bo;
+       (*data)->capacity =3D align_space;
        (*data)->count =3D 0;
        (*data)->last_reserved =3D 0;

@@ -361,17 +413,33 @@ void amdgpu_virt_release_ras_err_handler_data(struct =
amdgpu_device *adev)
        virt->virt_eh_data =3D NULL;
 }

-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-               struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+               const struct eeprom_table_record *bps, int pages)
 {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_dat=
a;
+       int need;

-       if (!data)
-               return;
+       if (!data || pages <=3D 0)
+               return false;
+
+       if (pages > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY - data->cou=
nt) {
+               dev_warn_ratelimited(adev->dev,
+                                    "RAS WARN: bad page table at capacity =
(count=3D%d pages=3D%d max=3D%u)\n",
+                                    data->count, pages,
+                                    AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAP=
ACITY);
+               return false;
+       }
+
+       need =3D data->count + pages;
+       if (need > data->capacity &&
+           amdgpu_virt_ras_realloc_eh_data_space(adev, data, need - data->=
capacity))
+               return false;

        memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
        data->count +=3D pages;
+
+       return true;
 }

 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) @@ -44=
3,20 +511,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *=
adev,

        memset(&bp, 0, sizeof(bp));

-       if (bp_block_size) {
-               bp_cnt =3D bp_block_size / sizeof(uint64_t);
-               for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
-                       retired_page =3D *(uint64_t *)(vram_usage_va +
-                                       bp_block_offset + bp_idx * sizeof(u=
int64_t));
-                       bp.retired_page =3D retired_page;
+       if (!bp_block_size)
+               return;

-                       if (amdgpu_virt_ras_check_bad_page(adev, retired_pa=
ge))
-                               continue;
+       bp_cnt =3D bp_block_size / sizeof(uint64_t);
+       for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
+               retired_page =3D *(uint64_t *)(vram_usage_va +
+                               bp_block_offset + bp_idx * sizeof(uint64_t)=
);
+               bp.retired_page =3D retired_page;

-                       amdgpu_virt_ras_add_bps(adev, &bp, 1);
+               if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+                       continue;

-                       amdgpu_virt_ras_reserve_bps(adev);
-               }
+               if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+                       break;
+
+               amdgpu_virt_ras_reserve_bps(adev);
        }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index d563deec0916b..d8500c3e48a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -265,6 +265,8 @@ struct amdgpu_virt_ras_err_handler_data {
        struct eeprom_table_record *bps;
        /* point to reserved bo array */
        struct amdgpu_bo **bps_bo;
+       /* number of slots in bps[] / bps_bo[] (always >=3D count) */
+       int capacity;
        /* the count of entries */
        int count;
        /* last reserved entry's index + 1 */
--
2.34.1

