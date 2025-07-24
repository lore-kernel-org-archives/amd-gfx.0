Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F20CC83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 10:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C7088CFA;
	Thu, 24 Jul 2025 10:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nre7pHlQ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE5B10E915
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 10:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD/ebVp5SMiKkUf0rmU8nSdfmk3R8lQey0bWsTbqwCYXltBdggsC7ojzJzTxfR0uMwFVd6mJEYXfuhbdNo6PW6DrJgsrYLYhed1gtKJ+RjNh/61j9aoK4fQX2XToKXezk6mblhCvxpmhVKAZDYZyn40S6BAO7h90rnHYiZE7nYXIwpjxsrN1yyBwZGpuEUoF/o6pW37b+vxxhUJyhHseneSQUG9Vr4N1NkM0Pseo4w3D8HKlkW+lVbjfdN5k0MpyK5LZPswaPRjQuxPvN0dQPXX8rhF83isWKjGT1buHtwCSeOy7hFLGFryUR7pof0b/T8eflrRDoGrakZOGqppm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjZxthOo2kRIOEaZl0mhKInUE8UVFo1KXa/zTmN/tkI=;
 b=IbYqRqx7StnR/9U5q15ntZwphJMc9z121/gqtcVYdPlTvCCfcDiPi0WtWdJYZbtGYdog+WOY+CcToFgzBCKdLiQEPuJAEW434cbffACvIHupOwXspI89p66pUksd9HVN6hX5JkEuxkQiKiEYQGYHH+JpkRwJQUPWYZJ+Cru34ITn4XJ9R5RnJH3u28uBhJpzYTK0F2bT51krxGC82+TiYiAkLzMtAYx3v9yUde7SGa64Wso7RCnL/M2wpbQQBAidLvCF906OcjIiW6iKr+QdJzkcmez6zQH4iyd4vLouAKYdWca4w4OKOgUzV1A3S0EIglEdGbIoDSTEU3oYzu7Eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjZxthOo2kRIOEaZl0mhKInUE8UVFo1KXa/zTmN/tkI=;
 b=nre7pHlQ7L+SZv3txLEsO9OltTKZus0Rq+IrUXYfNgEhICe7R/3eodIiRfvOUvi4URbf5GhwG4OqsLbu95NzozfTchQgEY2XLEoaFc8phD9FVU0uCwLQCSGt4sHrLp6nr0uhpvVoCM/TgjKK5GQMPxlx8dxzr7vXUW3eNokLd1g=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 10:03:27 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb%7]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 10:03:26 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
Thread-Index: AQHb/Hj0S6ltIhN4wEGkqmFJ5eetFbRBCI7r
Date: Thu, 24 Jul 2025 10:03:26 +0000
Message-ID: <SJ0PR12MB6967DC041C3C519D228B84B29D5EA@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20250724085603.1611802-1-lijo.lazar@amd.com>
In-Reply-To: <20250724085603.1611802-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T10:03:25.9490000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|PH7PR12MB5710:EE_
x-ms-office365-filtering-correlation-id: 88ceb70f-8530-4bd2-2018-08ddca995543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nQ20wTrMuAgScEvFwa1eLAHU3HSN+vWGxMwnwTofkQ64QHoS4CJsQXAXSlaH?=
 =?us-ascii?Q?9V2Wm3HYrENk1VfxjRTJhxsY1mg72F5qCutwc7GiVhtpTI+cVZhdC1JsnU+H?=
 =?us-ascii?Q?w69teoa66enmV6W/yN0SbwoTMi2k0vNm6fMCQVEBiw+bq9fjXiLY2nbzR/4g?=
 =?us-ascii?Q?vxMEJUmoMsE15lLaTXofp611wg6khsujSvbfS2s5TSE5I4ul7R+5z7kU9u7i?=
 =?us-ascii?Q?NUORcqQ+gItLRgTjrvPi2BO82xe/Zhoc8KTlLfv5pLCNrlEB/4FtSuZ+Zlh2?=
 =?us-ascii?Q?MBRDqBU+oORYsOOTCqifPYwEl466ughPUXA6DN+wYeJRVoNqs3lGaQXUljQu?=
 =?us-ascii?Q?TIRrNYor5BpOo+hQwrgqEbCY1axx7Hpr/LpYuc+mIwhyrrdxYmcaupxT72mi?=
 =?us-ascii?Q?8Sup3gxu1vufRAv27YKhV13pBoqYym8C1B7CSmlYjy9/SNiQOSo6E61+uZsA?=
 =?us-ascii?Q?2g1lgFgYWyrsFcnAcFLSnijnit1Sak2yjhg0jb2OAyjedaKLREPzt1QIhU8f?=
 =?us-ascii?Q?yz4QcD5YMNWNzISVncNIxn9UwC52J3rwmUBMLBc1EY/+s08PDXnWGfkY2VBM?=
 =?us-ascii?Q?sx2BxTdjfIfUoM8a9KNJ5+Zy95otZnbOeEbcZLR6S+AyiPIL5l5A5EI3uZ+n?=
 =?us-ascii?Q?jTP7/05JFdPDcJuE8d8WXFM9vUP6MD/OZuU5+gCKytI0sKbMXUpsi8XNsOZM?=
 =?us-ascii?Q?ETV5XCY6H5k6Disq4umOOWCu7rSA/SagbQP3XVvZaq1kEQ0QtqPjzWNBmNM0?=
 =?us-ascii?Q?7RaXGUfC5C4mJgowV5HwXRQxBhCrtNiWEqyBLHyp5BdVu8QQr4IbXHmQGSeF?=
 =?us-ascii?Q?W8b3iGzOqMRC2CNPpTFszNDKp2SlWbMuFkfPsCKHFkAutVR+ZlXI6pV+Fwdw?=
 =?us-ascii?Q?kxXIxxFkRmRc5uiDh1yK9kbDe6QkFjAkUkDTjbehPEJX+mVL3Cs+YJV8TFD9?=
 =?us-ascii?Q?ffyLtFT0WPA4OHf7famiv5MMLVzF4s17fFccPxyxOD5Juc6tS00qYpiAdW6/?=
 =?us-ascii?Q?wtUha7QkEa219HqWNBuhCc3truSHZrLjn/vWblOQxfC3ceteMeLWG/06Paxp?=
 =?us-ascii?Q?NC7kJIAC8R1QuFLs/ZHg2uArsUpeH4Ymc4Qs11C9eFNQG47hI3zcR8Ih3o/9?=
 =?us-ascii?Q?jaayPiK72PeN8EGscbLRUZUd49h/xdrB/zRiqapeu8KArpCjngy0TnPdcCxP?=
 =?us-ascii?Q?zAsu5/fNFAybuOMQ4RqrUBw9imsU6Rww/zICQVkMxc72DIiwvlfKa3LhGaVU?=
 =?us-ascii?Q?q3M5mllHfbauheXRGZX1NfJd8evQQazTTBMsnnnDdPEJpAwsoc+z+bwMn4ta?=
 =?us-ascii?Q?1ttPGh/LptBtRC0ixEuGjEN03sEHo+ma3bWKuHV+4TRE7DuujmRkTY5uSmnW?=
 =?us-ascii?Q?soNiD5lmisVq6cFX4472fxrBqMGU/t2B4G95S4PRY1PJCEtLO4NXyizOPuAo?=
 =?us-ascii?Q?WtcHAUfyTtq7E8BcPlTFSyDSXEx9RJ/ncb1NpTbp/RouYXHr3/f4Yw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wnxSRmd0ZrhcJ70OJ91L6kKEPnePp6kTfCjT7pfo8ShBYkOPMF0135xSFQpv?=
 =?us-ascii?Q?9sGjRXkoUPSpsVW5jyMAlcxJ8L7Fb5EGy3pMUOpJV19x9/BkdYY4Wyx6h574?=
 =?us-ascii?Q?hFKh7D4w/p1EBQr3IAHT+GlsvLMvh1vjZgY21n0401P90A/aov9ARv1c1qR2?=
 =?us-ascii?Q?ofFGcixDLMf52vs6AJVnpoPrZF+X/XcPKdlw2ucWSAn/CMbqxGBjgPOvV9IO?=
 =?us-ascii?Q?cx0pGvbe82APU5fYMlovbdw4yTV6TbpzSX+PQos4XFzji9at68NffBeK1mZI?=
 =?us-ascii?Q?k8hQZe0nO5YD3LOYDRe5NEzc5drLZXM7HCES1DMhsmhzdDUgNoki6DtF4Irl?=
 =?us-ascii?Q?e2zSTgnqrNTW+wnHYbo+Nj4R4pA/Ayme4cvE199HzYz3f2qLH8h+UmaTB/JY?=
 =?us-ascii?Q?M5yCn+dYqjQNJWPjDirkevC5h9Ihwt0ob5aXn1zEgNXfG9RfBRFqfTLhBEET?=
 =?us-ascii?Q?K/yrQQmqQdG3mLLmCuKU95ZODtzaFSKkcacCL3k6Q1THLv0PmabI7OjRpI0C?=
 =?us-ascii?Q?AqTn0s5T4703bnF/Kyo1hBz9StqOH28u1A7ZPgtGeX/B8uu1U+RP4k+/VDHO?=
 =?us-ascii?Q?Go/n8z51nl4Vbq6lG+kH534dKRp2xChhvG8gv7ARoLLEcRaaFqzAA9EdzPqX?=
 =?us-ascii?Q?vCkzxQrCGAF6EBG+ucK+jEUXybF0vFT1bP7QCpcUyQrtdXgZ8cJ+d1i9pe4+?=
 =?us-ascii?Q?wsSfUGB1qBiSJEeWbIAHMPqpgc0EQZeNrG0chbkdDeB/LQ10dde1HDYslPPZ?=
 =?us-ascii?Q?H8dpWtKgwl62IedAamw2Rja1hcI7dezuHsEotPXzzwF4X1a+kNKVwZmHjD9c?=
 =?us-ascii?Q?uJ6fCPOjTPsGXFBRkA72/sbfVzsnNy+4CignOlARC7vDFLitzQKc65+Lh0qp?=
 =?us-ascii?Q?QPSbVDyawp+c11Q1x3Ytt+e9UKy05h0/qCcFrc6GIz0WUNlGvBngrmvk84Qa?=
 =?us-ascii?Q?5purAW8pv5zArwN/ihE6tdOjgpnVO1LNWmjTVQyiQFrpUj1M8fCKLKrGkWQn?=
 =?us-ascii?Q?4wJl2MTGPCJQRVUo5o4175D0tKcFfivkylraw3ssVLrhvF/d6flfJqdO6Ddi?=
 =?us-ascii?Q?wwEkZwXuTE2m3eYikVQWVBeJrCL+ZljTxy4KgJQgolrh5hNzQSvSIrYPYFyK?=
 =?us-ascii?Q?+uiLySiaDtE3c3f3Ncf/ZIaFLgWDXbqcQ2XvFCrEJ+mgqk2bVy0Gcldj9GpG?=
 =?us-ascii?Q?RvE8anGKySlWnF8v29PBzeC05I45wpOaUqWyNkD8/YTuA2wKi/LQ7vbKK19y?=
 =?us-ascii?Q?XcZmWqn/v2SDZD8VEMojYsj0BhilvbHP/stqbOQeNowYAzKMofPotPyaKl7G?=
 =?us-ascii?Q?DVOhZh6IYN9zaGz5/Th7z9y+6eQDu7MyxgXOO7HWLd//9nUWgVtMBY1rotEH?=
 =?us-ascii?Q?gr9Nv1HayT+qviWBETaXuZyvF2dRYz/w+CY3qMicp6NrEREk7xXVZZ3kxrCK?=
 =?us-ascii?Q?xTi0EAQyProCZf3prInJWYK0kuMZXnYhJWPuBlD6XO+Qp5j1ztfS3ezpRP8y?=
 =?us-ascii?Q?6ySpGCPY0D0MEd5zzCCrCJshEkQX9XwN9YGh04PUiqgnoxbsw36CixS11wEu?=
 =?us-ascii?Q?1KJLHDXWduppKSJUtlk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967DC041C3C519D228B84B29D5EASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ceb70f-8530-4bd2-2018-08ddca995543
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 10:03:26.4921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LEypbl5J89ox+hRgA2zTOVsiI2qBntugUEwRtDhOYVnWe22dnV63BTE2xco0WzKraU/086ryjrTl5Gfvch4MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

--_000_SJ0PR12MB6967DC041C3C519D228B84B29D5EASJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Reviewed-and-tested-by:  Ce Sun <cesun102@amd.com>







Regards,
Ce,Sun
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Thursday, July 24, 2025 4:56 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Sun, Ce(Overlord) <Ce.Su=
n@amd.com>
Subject: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6

Certain messages will processed with high priority by PMFW even if it
hasn't responded to a previous message. Send the priority message
regardless of the success/fail status of the previous message. Add
support on SMUv13.0.6 and SMUv13.0.12

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 14 +++++++++-----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index d7a9e41820fa..aaf148591a98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -469,6 +469,7 @@ enum smu_feature_mask {
 /* Message category flags */
 #define SMU_MSG_VF_FLAG                 (1U << 0)
 #define SMU_MSG_RAS_PRI                 (1U << 1)
+#define SMU_MSG_HI_PRI                 (1U << 2)

 /* Firmware capability flags */
 #define SMU_FW_CAP_RAS_PRI              (1U << 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 02a455a31c25..17e0303f603b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -106,7 +106,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_=
map[SMU_MSG_MAX_COUNT] =3D
         MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqB=
yIndex,                1),
         MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit=
,                      0),
         MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit=
,                      1),
-       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                   SMU_MSG_RAS_PRI),
+       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                   SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
         MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetD=
ramAddrHigh,           0),
         MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetD=
ramAddrLow,            0),
         MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetD=
ramSize,               0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..c22b3f646355 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -145,7 +145,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
         MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqB=
yIndex,                1),
         MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit=
,                      0),
         MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit=
,                      1),
-       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                   SMU_MSG_RAS_PRI),
+       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                   SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
         MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetD=
ramAddrHigh,           0),
         MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetD=
ramAddrLow,            0),
         MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetD=
ramSize,               0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 59f9abd0f7b8..f1f5cd8c2cd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -256,11 +256,12 @@ static int __smu_cmn_ras_filter_msg(struct smu_contex=
t *smu,
 {
         struct amdgpu_device *adev =3D smu->adev;
         uint32_t flags, resp;
-       bool fed_status;
+       bool fed_status, pri;

         flags =3D __smu_cmn_get_msg_flags(smu, msg);
         *poll =3D true;

+       pri =3D !!(flags & SMU_MSG_HI_PRI);
         /* When there is RAS fatal error, FW won't process non-RAS priorit=
y
          * messages. Don't allow any messages other than RAS priority mess=
ages.
          */
@@ -272,15 +273,18 @@ static int __smu_cmn_ras_filter_msg(struct smu_contex=
t *smu,
                                 smu_get_message_name(smu, msg));
                         return -EACCES;
                 }
+       }

+       if (pri || fed_status) {
                 /* FW will ignore non-priority messages when a RAS fatal e=
rror
-                * is detected. Hence it is possible that a previous messag=
e
-                * wouldn't have got response. Allow to continue without po=
lling
-                * for response status for priority messages.
+                * or reset condition is detected. Hence it is possible tha=
t a
+                * previous message wouldn't have got response. Allow to
+                * continue without polling for response status for priorit=
y
+                * messages.
                  */
                 resp =3D RREG32(smu->resp_reg);
                 dev_dbg(adev->dev,
-                       "Sending RAS priority message %s response status: %=
x",
+                       "Sending priority message %s response status: %x",
                         smu_get_message_name(smu, msg), resp);
                 if (resp =3D=3D 0)
                         *poll =3D false;
--
2.49.0


--_000_SJ0PR12MB6967DC041C3C519D228B84B29D5EASJ0PR12MB6967namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-and-tested-by:&nbsp; Ce Sun &lt;cesun102@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Ce,Sun</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@amd=
.com&gt;<br>
<b>Sent:</b> Thursday, July 24, 2025 4:56 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Certain messages will processed with high priority=
 by PMFW even if it<br>
hasn't responded to a previous message. Send the priority message<br>
regardless of the success/fail status of the previous message. Add<br>
support on SMUv13.0.6 and SMUv13.0.12<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c&nbsp; |&nbsp; 2 +-<=
br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c&nbsp;&nbsp; |&nbsp; =
2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 +++++++++-----<br>
&nbsp;4 files changed, 12 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h<br>
index d7a9e41820fa..aaf148591a98 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
@@ -469,6 +469,7 @@ enum smu_feature_mask {<br>
&nbsp;/* Message category flags */<br>
&nbsp;#define SMU_MSG_VF_FLAG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1U &lt;&lt; 0)<br>
&nbsp;#define SMU_MSG_RAS_PRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1U &lt;&lt; 1)<br>
+#define SMU_MSG_HI_PRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1U &lt;&lt; 2)<br>
&nbsp;<br>
&nbsp;/* Firmware capability flags */<br>
&nbsp;#define SMU_FW_CAP_RAS_PRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1U &lt;&lt; 0)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
index 02a455a31c25..17e0303f603b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
@@ -106,7 +106,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_=
map[SMU_MSG_MAX_COUNT] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetDpmFreqByIndex,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetDpmFreqByIndex,&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_S=
etPptLimit,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_G=
etPptLimit,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxDeviceDriverReset,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PPSMC_MSG_GfxDriverReset,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_=
RAS_PRI),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxDeviceDriverReset,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PPSMC_MSG_GfxDriverReset,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_=
RAS_PRI | SMU_MSG_HI_PRI),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddr=
High,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_DramLogSetDramAddrHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddr=
Low,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PPSMC_MSG_DramLogSetDramAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramSize=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DramLogSetDramSize,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index 9cc294f4708b..c22b3f646355 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -145,7 +145,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetDpmFreqByIndex,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetDpmFreqByIndex,&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_S=
etPptLimit,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_G=
etPptLimit,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxDeviceDriverReset,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PPSMC_MSG_GfxDriverReset,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_=
RAS_PRI),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxDeviceDriverReset,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PPSMC_MSG_GfxDriverReset,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_=
RAS_PRI | SMU_MSG_HI_PRI),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddr=
High,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_DramLogSetDramAddrHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddr=
Low,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PPSMC_MSG_DramLogSetDramAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramSize=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DramLogSetDramSize,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index 59f9abd0f7b8..f1f5cd8c2cd9 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -256,11 +256,12 @@ static int __smu_cmn_ras_filter_msg(struct smu_contex=
t *smu,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags, resp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool fed_status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool fed_status, pri;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D __smu_cmn_get_ms=
g_flags(smu, msg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *poll =3D true;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pri =3D !!(flags &amp; SMU_MSG_HI_PRI=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* When there is RAS fatal=
 error, FW won't process non-RAS priority<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * messages. Don't al=
low any messages other than RAS priority messages.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
@@ -272,15 +273,18 @@ static int __smu_cmn_ras_filter_msg(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_get_message_name(smu, msg));=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EACCES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pri || fed_status) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* FW will ignore non-priority messages when a RAS fa=
tal error<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * is detected. Hence it is possible that a previous messag=
e<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * wouldn't have got response. Allow to continue without po=
lling<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * for response status for priority messages.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * or reset condition is detected. Hence it is possible tha=
t a<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * previous message wouldn't have got response. Allow to<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * continue without polling for response status for priorit=
y<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * messages.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; resp =3D RREG32(smu-&gt;resp_reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Sending RA=
S priority message %s response status: %x&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Sending pr=
iority message %s response status: %x&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_g=
et_message_name(smu, msg), resp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (resp =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *poll=
 =3D false;<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB6967DC041C3C519D228B84B29D5EASJ0PR12MB6967namp_--
