Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D46E8305C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 07:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D97810E002;
	Tue,  3 Feb 2026 07:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gvzab1hU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B94210E002
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 07:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oftsJ7bCXWxiwGJYYiR+I3tr8+q4o3bWUMFT5q5NBnOhMHHRZfCx9tx7GR2yvkobuAkEMVBSUmNzsucyxhh4H+w+YpGlY7jpTOfKjhgXPLlEHYJGA10sNG2P+u610vKmC7M1WtShQkQ2LOJbAnLWySXsELFsbjF4vtSGx8BUHCLJ7bjMssSkaqgU5UKMPri9YVMhGDS7aq/jgiwri9abC6YtI9WVi2QxVzYUyYzKzFabNfev/6gBVs0+CL0SD4PlbRV+eUfFPCUZAJEyD4uumpWg33AD9Wbnf+gxnt6ZAAYvSApvEomQl5n92iyWvEVuUbStvL9enigq9fMQ8m4t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho2gRxx80d/XrnYryD3SneYLA0WY2VN0y+PhI/lrJoE=;
 b=qxoa5cPml9SC7nkztDiPtkIOYOmypEqBSEiHieP3OCjmImBnEYMqZqcZcUYVn5fiilYCi4wTWTrMXqbETaBD3mx8ZSCAoaODKjEQMOu+qGFlAD5nu4xdFgEmUqY0obOH75nY+OJcS12Wf8aq5w1p8l4ByY8noviFlPS6fx6KNWPoeAc4YXYGX/cY/ajWfBjCDmRevDwkmGsa06ZY2PNnfXqGzcqJX3ypMsq48XXnhNMqWZcD3UWHsS8+EsjIQ0SO0rA2qvMoO06vpQQDG5oqKlYvabIT/eg9P+oeK/5u/oQ+VohaWVN4Cb9ymyjYHEqBQ5DNp5qRMnl8LD3NdmdawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho2gRxx80d/XrnYryD3SneYLA0WY2VN0y+PhI/lrJoE=;
 b=Gvzab1hUD8mGPRXXQ10Erg8R3yQEUxFWwFLmeySNkvx611C3MYwC4jIpL6PgQcC6YwjATgTLjcLWcccrxT6+aMKA2zablyUZeIxmaJABlqz6cZa1SE1W1qsjVPeMqoomeHSdLtc7ZXRF38BVqCqXgQBPA3WqPp/W+2orJSGreD4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:06:09 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:06:09 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH V2 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Thread-Topic: [PATCH V2 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Thread-Index: AQHclMNb7syXUgFHQ0GXBLytKIIxqLVwjYTA
Date: Tue, 3 Feb 2026 07:06:09 +0000
Message-ID: <PH7PR12MB5997BD31F01C19B5A92AD1FA829BA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
 <20260203041206.1299104-3-ganglxie@amd.com>
In-Reply-To: <20260203041206.1299104-3-ganglxie@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-03T07:05:47.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ1PR12MB6100:EE_
x-ms-office365-filtering-correlation-id: 09f93364-8309-4374-525b-08de62f2b519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0BA7M+r03zIO9p+z7YpGGaYG31wLDZVXyk43bXEq+W7q4uIGoMpr5+St5Iyw?=
 =?us-ascii?Q?BrKe9B6AIvNrtsNU5YnDZicfleWXJflAng33ybes5PhpZI1L1vswSILYZKcY?=
 =?us-ascii?Q?xGWnYWsEW5/XrAWGibF/SyKbsJp0lDWEWyTsn3DsB8pzi2cmBFU67/tceb3z?=
 =?us-ascii?Q?5j5Mnv7IiHcFz44qguatIa9Pt5LOEjtBPf5eEu6BdpmRrl6iVq8jySU7NjTs?=
 =?us-ascii?Q?pNQWGLRA58uuLyQQXmGOFZ3cfSqENt2Ncjg1oFSIeQuW0ee+rI5EqqclIeKd?=
 =?us-ascii?Q?S3ArPT5rh0fHOR2mqNVzLyRNk8oa29YFoO78CHtRFOyCYk2nxbmCG4bRLxnV?=
 =?us-ascii?Q?4BOHKivAjXmufqiqsElZ9QVvsO2ZUKoeYLLm6wTo6b6Zt8RtKNnkg1pz/zdy?=
 =?us-ascii?Q?2PbWZFs0BlfckqR8vbpDrQVriUi32HDCrG2MY+oqvRry9qUCE/iXGUmgn05g?=
 =?us-ascii?Q?PzuOIzQZRLc1luxykKh4drX8KhqYspO4q8KRetPwxCvBnxajTcFlIsSo1gyt?=
 =?us-ascii?Q?Ng0tFx4adf2+qOVUtF3KURVuX+1PQbPgUHdwmxOCHyerEJHlb2QYl3YiN7Ba?=
 =?us-ascii?Q?5TcLGdoL+prObamEcauZqgXDst6IGnPcONOSSMSKWPsOfUrfrmM//+jc3U3d?=
 =?us-ascii?Q?44TZuaT/DOTcTfuLf3wvWQyTGyINFNrWIqmdtJeQT5OO7lsDfcuuu0dqW4wM?=
 =?us-ascii?Q?/CaVqqqAMif4x7tpLsTmGuYtG9G9Te4gKxzEW18BEwxjRLXc2mD0JnmP5x1a?=
 =?us-ascii?Q?0fAYEETTaQyXrRUDA18UWLbQi1wq65chAAbJaKayIdzMxHOiOQfd3UCjxITR?=
 =?us-ascii?Q?4M9N7JERJEn95j/FCCrAYOe4ATcAmVmZbb2bRmWOTshu2AHQ6jRY/M2kXCdi?=
 =?us-ascii?Q?4IG2hCeYDLCozyY20wXpFu8w5EZgigKWVUNAIDcCuzWMsEpgHh8pITDeNr3R?=
 =?us-ascii?Q?G90+YDJ16pTDLhBS7BZfOhIbn+eM1MMQ0GqFZFmShOp1ogtb/+0YWeJNm17U?=
 =?us-ascii?Q?rxrjK11PZutIInyYKrb2pHPsMuwwQ8EiTKXSferOfPj7HY72WpT5NpWJ4OxM?=
 =?us-ascii?Q?8g/EJzPhXjV5gNxX1rZju/R0C4Nm8LR23cBSNIJYS/RDAKpJIXIFv5AqHa/1?=
 =?us-ascii?Q?yPTcHAY1WDAYRNWhMNUtPmdcRIMR6duJjeOy1u9auNj8PezKAfTbK9/civUh?=
 =?us-ascii?Q?VIRPCbPKrAHlzppq2cxN0DulYVoGQ0sKlE3Ka4bgGvpSVE/3qHOvlAlfDoz1?=
 =?us-ascii?Q?Ez4nXiV/ELuv5JNwjjToWl1Slcgk2BcNSPahiKq7szPbPoskabOkHmxhaCdA?=
 =?us-ascii?Q?h5+lglsHAgurnqVbfr82TfL3d6iCsFwwoIGDj7B8flFX6C9YRf4ZQj4+AiYY?=
 =?us-ascii?Q?0xkMglwieavBdQ3l2kqBz1WkRsdrOpT7a/xNRcLhKmxYKb95EBEvbDO2N5Rh?=
 =?us-ascii?Q?MiHyI2noq0NSxuclWo7tPDp1CJUap8bkBLjS6HC9qow7RyV2vnfTuEp8qiyG?=
 =?us-ascii?Q?rlw3aR8Q+xUcHwNM7w850vJtnFzpuVj331CQ8C6EW8CgXi6sZLALpoC+TFEb?=
 =?us-ascii?Q?5sEo3tmDazdQBKgdzeA01Sra3NjwcRqWs8sp8qWUkBO/jTWjEypvb6hwkV0+?=
 =?us-ascii?Q?mU4tmNclYH8nygVBZ+BDtFg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VeZ1TSAbyfNJ61B9BvnrYd0t3M214UwH5ovNwYxzMvWKyN4GB7nByHWksO4z?=
 =?us-ascii?Q?ylKFtyW+7+EdPg6CYRLL384oIes5C4QawvrU1gczg53AWKM1U3vUT7520kpk?=
 =?us-ascii?Q?XilNra1CBWGkCnVukvYdvqG4nBVh26/kGn72rEOM4Ks81M2iWAWzkGU1409C?=
 =?us-ascii?Q?uKSdK7XfXjStmqBXHnSx0j91ZUjErtL3xFw6r3XzClxifZ8lor+Dw6la3srz?=
 =?us-ascii?Q?wjNrLKmLNln8Y1NIosh1hfN4U1oqeO2Oar3PbCKMXHlI6zcHjx4pf35fjyG+?=
 =?us-ascii?Q?a4GpnNQ9Vv124FFNMtWmdSOgiq+74pNWd1x7YXWoGzUDRnFOGD+pfNIi4zlu?=
 =?us-ascii?Q?3JT76YDjCiSDOkwJSyB/kGCoNNytiAFl3VQsgQ4TqQH1fV0dyeO9vfdqyUEW?=
 =?us-ascii?Q?5jh0rodAL7TzGB7csQfnYswv/ti0f8mQ8FHKwTR6KZiM723f3V7Ep9gu9E8j?=
 =?us-ascii?Q?R9wnRziyG8e8omC0M7wQ1EIPryyQyKUvQpJjhSODKb6KsJYAq8wHszG7zMaf?=
 =?us-ascii?Q?nSBLZ2LVuvTPkuj66tP1862Y5hri1ov0xgu0eXj5tVeVzWQoC+Xn7ItPKvwZ?=
 =?us-ascii?Q?uVERXrVb+sC3Rk7soAQJcrxjPXo03TiVgGZ7cWuiSyK1GAjkR9yufiLmtorp?=
 =?us-ascii?Q?wev4A6ADgzm2dcsDWSo+NcD01Y+YvuY0+a9MWyB2Ik7UZCV6ZaCascAIFrab?=
 =?us-ascii?Q?TzDyYWBU1haXtZ83in2x2er++y8rUioMkimC7ztGIJfH4epuDTO6ArSCkVX9?=
 =?us-ascii?Q?aGMrGng9hsIZScdXAp/Wzg6uKrp4InomOZzisnx/blfaQ2FUy9AS8gjbhEFv?=
 =?us-ascii?Q?MWTlhtZQRuGFbO6whq/EbC804e59pQitgklgR9SbQU96dDDVaKh1Yfwc/yYI?=
 =?us-ascii?Q?+g+x4eoheq/F1uOD6DFPIJoWm5CKxf1S2Mcr0GXFitj5ylmOXy4f0DkdIj4f?=
 =?us-ascii?Q?ClTlbBgwxz1wkpYAZALiAM9KFw/h/3CQ0tXPRdBKxQpXnDyNw1AWvcIEliaH?=
 =?us-ascii?Q?Y1+BkRAgKnpIJ1YgHupepcoAzEzQub85khy/dQ2qEUjt1k7IEykmqbwx1bts?=
 =?us-ascii?Q?8XEmzMikH0w2gU/9DS242qfPQbUQIlo0AiMvEE1GH92XLQbHq/Q+8j35gtRN?=
 =?us-ascii?Q?PTrSyhqz/viiRO8BBJUHN+CLzTDMrBkwGnx4fpH9bARGcISLpaY+eec+yVFf?=
 =?us-ascii?Q?kfo71pazE7FGakORChP8MnoCFh873PgX9Thcz8Q36zjiIw2UxJmHf2/M7G0O?=
 =?us-ascii?Q?GAN2na33ExHAB7uM6GStM4hZ/ebkZ6YNKfTC3PFuue5Yl1XVnitvsXPvHWmN?=
 =?us-ascii?Q?5M/tsEEpxSsmoa4myiWnuj3JlV4ockk0js9ShCgnih6ED/maWs5ulazwGK/a?=
 =?us-ascii?Q?8hP+PAzYuYW0ORQhY80OaLYIjg50wjEM5LTaI7ucDKTWxD20ZVE0d53Y8m44?=
 =?us-ascii?Q?pNcPhJ9njj7gbraiC45QFiW2itPgY5pZLD7+3YIUWnJ5XVszYp1kY2ECihRL?=
 =?us-ascii?Q?DjRI8AnX18cyCgaMUIG8KmLHSxWk7wm/HruUyrqvLgzL7LdgBRztVrFbj89r?=
 =?us-ascii?Q?zoWruBPGxBUcQZWClZyj4UUnzFZ9CIfWB3O/xpD6xnE10z71KvCx+/YRAmp8?=
 =?us-ascii?Q?dl68ez2bYNRIOGiqKwwVbH07jvRpacLUJuwVI1+qOWzZQouRVnbQgp/I6yjU?=
 =?us-ascii?Q?wHFEA+2/wRpajQO+yeebm1qrwfAjPyZXGIgsjMM3hMQIaWzE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f93364-8309-4374-525b-08de62f2b519
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 07:06:09.3051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPUuQft60VOQw9qCpo7RCdd/e8YpNsiaRZT07YcVVrCZadhWMqCrim8O4QdeJyJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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

Patch 1-3 is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Xie, Patrick <Gangliang.Xie@amd.com>
Sent: Tuesday, February 3, 2026 12:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Wan=
g, Yang(Kevin) <KevinYang.Wang@amd.com>; Xie, Patrick <Gangliang.Xie@amd.co=
m>
Subject: [PATCH V2 03/14] drm/amd/ras: add pmfw eeprom smu interfaces

add smu interfaces and its data structures for pmfw eeprom in uniras

v2: add 'const' to smu messages array, and specify
    index for each member when initializing.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 46 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h         | 18 ++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drive=
rs/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 79a51b1603ac..2098f24d4940 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -28,6 +28,16 @@
 #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
 #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B

+static const enum smu_message_type pmfw_eeprom_msgs[] =3D {
+       [RAS_SMU_GetRASTableVersion] =3D SMU_MSG_GetRASTableVersion,
+       [RAS_SMU_GetBadPageCount] =3D SMU_MSG_GetBadPageCount,
+       [RAS_SMU_SetTimestamp] =3D SMU_MSG_SetTimestamp,
+       [RAS_SMU_GetTimestamp] =3D SMU_MSG_GetTimestamp,
+       [RAS_SMU_GetBadPageIpid] =3D SMU_MSG_GetBadPageIpid,
+       [RAS_SMU_EraseRasTable] =3D SMU_MSG_EraseRasTable,
+       [RAS_SMU_GetBadPageMcaAddr] =3D SMU_MSG_GetBadPageMcaAddr, };
+
 static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_cor=
e,
                                          u32 msg, u32 *count)
 {
@@ -87,8 +97,44 @@ static int mp1_v13_0_dump_valid_bank(struct ras_core_con=
text *ras_core,
        return ret;
 }

+static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
+                               enum ras_fw_eeprom_cmd index, uint32_t para=
m, uint32_t *read_arg) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       int ret =3D 0;
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               ret =3D amdgpu_smu_ras_send_msg(adev,
+                       pmfw_eeprom_msgs[index], param, read_arg);
+               up_read(&adev->reset_domain->sem);
+       } else {
+               ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
+       }
+
+       return ret;
+}
+
+static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_cor=
e,
+                                            uint64_t *enabled_mask)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       int ret =3D 0;
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               if (amdgpu_smu_ras_feature_is_enabled(adev, SMU_FEATURE_HRO=
M_EN_BIT))
+                       *enabled_mask |=3D RAS_CORE_FW_FEATURE_BIT__RAS_EEP=
ROM;
+               up_read(&adev->reset_domain->sem);
+       } else {
+               ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
+       }
+
+       return ret;
+}
+
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 =3D {
        .mp1_get_valid_bank_count =3D mp1_v13_0_get_valid_bank_count,
        .mp1_dump_valid_bank =3D mp1_v13_0_dump_valid_bank,
+       .mp1_send_eeprom_msg =3D mp1_v13_0_eeprom_send_msg,
+       .mp1_get_ras_enabled_mask =3D mp1_v13_0_get_ras_enabled_mask,
 };

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h
index 3396b2e0949d..2db838c444f1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -49,6 +49,10 @@
 #define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
 #define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)

+enum ras_core_fw_feature_flags {
+       RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =3D BIT_ULL(0), };
+
 enum ras_block_id {
        RAS_BLOCK_ID__UMC =3D 0,
        RAS_BLOCK_ID__SDMA,
@@ -127,6 +131,16 @@ enum ras_gpu_status {
        RAS_GPU_STATUS__IS_VF =3D 0x8,
 };

+enum ras_fw_eeprom_cmd {
+       RAS_SMU_GetRASTableVersion =3D 0,
+       RAS_SMU_GetBadPageCount,
+       RAS_SMU_SetTimestamp,
+       RAS_SMU_GetTimestamp,
+       RAS_SMU_GetBadPageIpid,
+       RAS_SMU_EraseRasTable,
+       RAS_SMU_GetBadPageMcaAddr,
+};
+
 struct ras_core_context;
 struct ras_bank_ecc;
 struct ras_umc;
@@ -141,6 +155,10 @@ struct ras_mp1_sys_func {
                        u32 msg, u32 *count);
        int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
                        u32 msg, u32 idx, u32 reg_idx, u64 *val);
+       int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
+                       enum ras_fw_eeprom_cmd index, uint32_t param, uint3=
2_t *read_arg);
+       int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
+                       uint64_t *enabled_mask);
 };

 struct ras_eeprom_sys_func {
--
2.34.1

