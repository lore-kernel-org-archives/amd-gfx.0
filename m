Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FDCC02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 11:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B78B10E306;
	Wed, 22 Jan 2025 11:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eLTp00g8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB2710E306
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 11:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxGTdlNVLP40L6qjfWCEnrM8tcvA0HOgK56s4//tBgDam8ZYMgBittsE4gw/vph/kWe+00wt3Q19AwvtAfvSTjppt4RBHMMr3zlEmek8q1P8ziEL0FyvP5TqM7CaAjk0+Wfhb05LTDwsmWjUOsBFu9e30ItLelpVaUpnCjYmECNHvgmhLTnL8o1rrofQqg0T7IWwKGkn9JPE2b7kszLEz3NWSZ8bcmEhGMc91Ys1axRWljJBmu5tnwHMNON1DaDxYonwr81KJOZ/f2QBvo3F2XwDZNz0QwFVwtP0EbFAERxOKUYCixoj+nDFxGBbbMSV0+FnfmZ94eFbNQHgFpRQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OczBpj2veod+NKuZP1+k9GOzqutyFUR3sS2hp12gYU=;
 b=uUgpKGOGkmowOsn8z+QHwesHx6r5UG58iVV+ecyPqGBZM5TPkQ5WkdRyT+8QtNO6JJL+dUhbTZapHQ6AAnMl7im2gRkn40AjE4xVOahGttf06lyc6QbfTmrtWV/cyPDosQDSUyqW6IeXkaVjVhA73gDZ4kTt7iMsBWloz6h6BXKGFQN7BV4GiaRjgwEMfepLbuub8Wp2vheg9WcHuVAGteefQesWuLAY6P9wRk8eM7KXMzKIohQW3ERiGdxpBd053LBCMzN06odTYcppItGTbPhp/1E81ezaXke/36o/GQiMWfbUG1/syhe4Q9+urTK3KN+1kJcyXGGknV0oc4d7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OczBpj2veod+NKuZP1+k9GOzqutyFUR3sS2hp12gYU=;
 b=eLTp00g8A1HhiLtGXsJqBNkdeUQOaeXt4PCyP1dI4yj7/4/dGZ5ScAPQEQvESmJ5ZB2K7KYRO4sbD7GBF8JzrZipQ9YwjQiImsFMakLplCHG+YPZn8i3OkktAQnY1ZmHPzcmZtUltEIDXucVjagUoor+vRaZDY80pD+DCHnPLtw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 11:12:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 11:12:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update usage for bad page threshold
Thread-Topic: [PATCH] drm/amdgpu: Update usage for bad page threshold
Thread-Index: AQHbbLi5f/voqutucEmbhMb+vMnf0rMio4Jw
Date: Wed, 22 Jan 2025 11:12:30 +0000
Message-ID: <BN9PR12MB52578940C4CAF152EFCDF9FDFCE12@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250122103018.17264-1-Hawking.Zhang@amd.com>
In-Reply-To: <20250122103018.17264-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a92417aa-c84b-461f-83f4-5f05b033b681;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-22T11:12:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB6870:EE_
x-ms-office365-filtering-correlation-id: 0d448262-c1f3-43ae-d408-08dd3ad5a9f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xY5lmLqJRO0eLiTpwOi5AUTMeMzqFlveYXgmbLVd32xFJjIQqZFnz1rEP/sn?=
 =?us-ascii?Q?ZKckexwqJ7B6RvOT98MR0xbkj7UMUAG5bZloN80ccMzn2oXWVv4yimHwNGj9?=
 =?us-ascii?Q?f31IEWXYUULhpo/agnv1t8BnMesZRMgdnIDsut4oFGziNxOvJbxuKQwbZwbQ?=
 =?us-ascii?Q?2Z+aYGIdYskctpNGs6FwyEW9TXFTKTW6+FRnC7Y9WW0/Z4Ql7s2sYi/gJBEP?=
 =?us-ascii?Q?O28aDIsXAnvv7r9fulG/1exVCsCRyOLuNK0jC3S2t61bmEao9/Adoxs2jW8m?=
 =?us-ascii?Q?aaKyiYA85qI4Z+CKjOH32eRVkE7jW/BSDzLFG/W1yfG0HqSJVV/fV+ZaFKKx?=
 =?us-ascii?Q?wy9a66MLXIBiMj4TO1ELnweFTrfF0qIAsjMYoiLddwxTcSQxBWadbFktPyzc?=
 =?us-ascii?Q?4nu+9UzloPWLBYAqASt/bw/qb1A2VxZ3/xrgTuGe0RHaOgjj43dIQOAxJvv4?=
 =?us-ascii?Q?I3GG16s0kmakbRdnS7WqQkvcsXvTjwfPmu28D0nRMCm2NXHONn8aR/HzT9zh?=
 =?us-ascii?Q?u/kelLYJdGCm9+AqROL9Q2sL+czvacBt4QrJlGhm1VaEfxkvFcmlrw6JDPHX?=
 =?us-ascii?Q?M/3A5VTdwZsUy96NrR9fUTs8/L6Rs5GetqjIEBnStI36dBRE5hbxeiDtOJg9?=
 =?us-ascii?Q?Di/b5Zrvdv+P9g5tA7OqwW+iHc5SItyUKKnPHJ7QcLHLqkZqJiYsGrP6GG4W?=
 =?us-ascii?Q?d+lVQrWnNBohpa0Z8nJqaNgHbdKiGNW5cr2/f4a6S67Lrs+Yy/+nzwSUGP8U?=
 =?us-ascii?Q?oCXJMcZ8XBSXlqQqNVqw+QBmZHQZOamPlQuiI9grh0bnLvBkcVCjZC7h5UqM?=
 =?us-ascii?Q?dF6CKUxSBUUZEAkVaWfKgAFFuECLvYlKGjvFWO/TJQ1KaGpnPqhg/dtq8bD1?=
 =?us-ascii?Q?76l+qhlwR3jscFV9kzFG4KfFAfJWRfcFQ3Mm/A1mD4MBwOXP1B0qhPKBQ8D0?=
 =?us-ascii?Q?fxOg10mTVoxdlY8J0fW0G7bAiLr8a7AhlXBIkcRcUaZmlPRSqZOOOahjweCE?=
 =?us-ascii?Q?EXo2IiRcpFBXYlRZkFis1Zzrjb9CaCnJtxfW4x1A9BqRXrzRIKogNSMN//xc?=
 =?us-ascii?Q?RCcoUgUqoaTOp45goE78br5pSy08FlZTJoqO0d72SMpbG/sUrrJDsLOTFFSv?=
 =?us-ascii?Q?LqyBpbfek3CDCVfdfIoL8AypbCCBhCY66AKYoka5I84KW+Zg0iXWMc66mt9Q?=
 =?us-ascii?Q?QpHhnH80Ux3XCkVO5eKWSze5BM5e62V1YfEn+/ZKi3Y8f+b7/ilVRi7/SgDS?=
 =?us-ascii?Q?Mqhi+aofDhr0EemyuGXnVApIJBAWjzyrDZrfLRwRQtRVd6gUsZZr4ALBY7av?=
 =?us-ascii?Q?oIM14VP7+yZ/7i6bQ6EXMKsGcUzmhMq3HXD9k2K1CqEdpJcNIv18Pki7TYTS?=
 =?us-ascii?Q?HEFUWNQDJBHqFuAZdiU+sAKIf0mUd0jicCf7QeHEy2O+0Idk9ER+tHeH/LMv?=
 =?us-ascii?Q?IXTtZUbJxU7GTAonRAAth8Hw7JrI4HXN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?In8xHNeR1S5h73nSrYQnLSTMtWAhuf81ITmMvWEUTxydvdYoTxqNNmCCTpl2?=
 =?us-ascii?Q?2+e8hIwkseX0s+toAedMp+I6ffPcpRJQB0qh7Ul5k04/WvjH6cQYToeEu4C5?=
 =?us-ascii?Q?KPOLaxg0kMuLY7cVlHdQg7UQBIwLqV0JtleilEg27yNJHwX/CGvo0RnPhe0A?=
 =?us-ascii?Q?FQDg4n6ZPE2CYV4RbmHWIX5rwF65NcWb+XNG/GNoJ61B5jCeB5V2qEdZe34U?=
 =?us-ascii?Q?R1nFeoa2f/isVIsXiKygTFeNrFLlkDi7tRISAynuxfVboykJiOBzSSXjrYcD?=
 =?us-ascii?Q?I4x4S/9mkKpgTXNcYjDjZ3zkl5Rq9J5RQegdRnzmJmxPaq5jZ9Dg6sCe0dwE?=
 =?us-ascii?Q?WAdmmUBPZysJXaJL+GMJHMwPbxaXMa3wF6zLmLuwZcN164nBQ1oOcmt899I8?=
 =?us-ascii?Q?9vijV3WFV1qSburMtBb/KLymvP1cUJG43Hd25Gc7dsvqDLFpFAIA8BzCXHTZ?=
 =?us-ascii?Q?b8aNIqFcjGzF77XAkr6lQqSL4a7VDCanC8iic1ShhB9sskK8PcRysfbK30H4?=
 =?us-ascii?Q?AtjiR/qxS1/cSOU8xBpSUYArTpQGpuDx0zTv7i//WO9MyiotrfYM4cqluEHX?=
 =?us-ascii?Q?aevyGP6UxpwjwpGQkvhAsNIqXEAY91ib3t3Ded6eFsafMNYBGlJOqQElKJ9w?=
 =?us-ascii?Q?5i4QNzmT7V4atf47RBOq+f7mgHvTr9ifftnbokfwneugRuDFY1BR6Hn1A0RE?=
 =?us-ascii?Q?HePtRekUAJDqbXIoKo9NMVMUf6HB5OnATqFTmMpj8mYGdXK64pGiEc4DgCua?=
 =?us-ascii?Q?C4iH4LsBTuLshuCasTiWOdYpYwtRzoT/Bze9MF5ao/liNMY4uawjaLjWXgfa?=
 =?us-ascii?Q?iUoVyPM6Gm2/tEy4DyA1Z3iwzzUedatmGbPtZmEe5pKMxdvqUVpZMaaIHhIT?=
 =?us-ascii?Q?/nzSQYif8+sZLMkn9msiR3U0xP3QCEwkMsckTEknzlCAdsQggCJOxdSErUIp?=
 =?us-ascii?Q?LN78Ao4qT43T4g+agNvWRAQE/6s6CY4bOjp13/PzdmIvv92VwnyYvK69K1Qa?=
 =?us-ascii?Q?DSsbRBQwi9J4RbfNBUyzp5403FIklN9JqZbbLj36B9+SfACiDnmvJkpjK8+z?=
 =?us-ascii?Q?T+3OlEQNkRAuSht1qLBSPNGtGSJvbnamMl+SD9F45B6L/723igzE/Tv7Jtdj?=
 =?us-ascii?Q?vTh7P41f7roO+3Rb8Td9PXoKTaJv2zEOcjBZb1zv1MJYkH7z8T7k7VRrm8wF?=
 =?us-ascii?Q?7qeXE0dG8bLZ/yxNg5QtxmKFLv9I8/a/RZU9knj9llde4jDKtWoVkO46PzWK?=
 =?us-ascii?Q?wcOvWRyAsITNot2+qFsGwguPk+PLe3j1Ji84S5l+qbYw4Tst41B7FP5ME/2e?=
 =?us-ascii?Q?mp5N4Xzq2JNcyRyfk2KMOnwzlY1EouTp6XOs8yAk+syznW3BI2W/mcduJ/cu?=
 =?us-ascii?Q?y6BercuytdrgE9FKJ7OR1Lx0ym1yCCmdMLcX+3IIvclCv8OTfPsRxDhcEF6J?=
 =?us-ascii?Q?kKH+FUJMc3CDwmaRbiGBoHmYzj3eu40Eemw2w7cvVVRpqwB8bd0zQjH47M+a?=
 =?us-ascii?Q?STaS+gwTtxc/mWy4rqzEoaR57bgBRchns3V+Pvg3NGHzpc0Q1TZrH21l+BfZ?=
 =?us-ascii?Q?EtyqNgjDpMesHHp1dyg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d448262-c1f3-43ae-d408-08dd3ad5a9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 11:12:31.0242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMjYwDYwlub2SIoC2pYIexK1iTLTcu2R9qzfQAZLvcoQNaDkzd/ul5nFoNkg9P6XBAOw7+3pjoRqZOAnkV2ETw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
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

Please ignore this one. will send out a new one soon

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 22, 2025 18:30
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update usage for bad page threshold

The driver's behavior varies based on
the configuration of amdgpu_bad_page_threshold setting

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 54 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++----
 4 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 99d884e6763a..87ea2e2a062f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -983,7 +983,7 @@ module_param_named(reset_method, amdgpu_reset_method, i=
nt, 0644);
  * result in the GPU entering bad status when the number of total
  * faulty pages by ECC exceeds the threshold value.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 =3D ignore thr=
eshold (default value), 0 =3D disable bad page retirement, -2 =3D driver se=
ts threshold)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 =3D ignore
+threshold (default value), 0 =3D disable bad page retirement, -2 =3D
+threshold determined by a formula, 0 < threshold < max records,
+user-defined threshold)");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 044=
4);

 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to set=
up (8 if set to greater than 8 or less than 0, only affect gfx 8+)"); diff =
--git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgp=
u/amdgpu_ras.c
index 960476e6124b..5676ffe5c43a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3071,35 +3071,35 @@ static void amdgpu_ras_validate_threshold(struct am=
dgpu_device *adev,
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);

        /*
-        * Justification of value bad_page_cnt_threshold in ras structure
+        * amdgpu_bad_page_threshold is used to config
+        * the threshold for the number of bad pages.
+        * -1:  Threshold is set to default value
+        *      Driver will issue a warning message when threshold is reach=
ed
+        *      and continue runtime services.
+        * 0:   Disable bad page retirement
+        *      Driver will not retire bad pages
+        *      which is intended for debugging purpose.
+        * -2:  Threshold is determined by a formula
+        *      that assumes 1 bad page per 100M of local memory.
+        *      Driver will continue runtime services when threhold is reac=
hed.
+        * 0 < threshold < max number of bad page records in EEPROM,
+        *      A user-defined threshold is set
+        *      Driver will halt runtime services when this custom threshol=
d is reached.
         *
-        * Generally, 0 <=3D amdgpu_bad_page_threshold <=3D max record leng=
th
-        * in eeprom or amdgpu_bad_page_threshold =3D=3D -2, introduce two
-        * scenarios accordingly.
-        *
-        * Bad page retirement enablement:
-        *    - If amdgpu_bad_page_threshold =3D -2,
-        *      bad_page_cnt_threshold =3D typical value by formula.
-        *
-        *    - When the value from user is 0 < amdgpu_bad_page_threshold <
-        *      max record length in eeprom, use it directly.
-        *
-        * Bad page retirement disablement:
-        *    - If amdgpu_bad_page_threshold =3D 0, bad page retirement
-        *      functionality is disabled, and bad_page_cnt_threshold will
-        *      take no effect.
         */
+        if (amdgpu_bad_page_threshold =3D=3D -2) {
+                u64 val =3D adev->gmc.mc_vram_size;

-       if (amdgpu_bad_page_threshold < 0) {
-               u64 val =3D adev->gmc.mc_vram_size;
+                do_div(val, RAS_BAD_PAGE_COVER);
+                con->bad_page_cnt_threshold =3D min(lower_32_bits(val),
+                                                  max_count);
+        } else if (amdgpu_bad_page_threshold =3D=3D -1) {
+                con->bad_page_cnt_threshold =3D ((con->reserved_pages_in_b=
ytes) >> 21) << 4;
+        } else {
+                con->bad_page_cnt_threshold =3D min_t(int, max_count,
+                                                    amdgpu_bad_page_thresh=
old);
+        }

-               do_div(val, RAS_BAD_PAGE_COVER);
-               con->bad_page_cnt_threshold =3D min(lower_32_bits(val),
-                                                 max_count);
-       } else {
-               con->bad_page_cnt_threshold =3D min_t(int, max_count,
-                                                   amdgpu_bad_page_thresho=
ld);
-       }
 }

 #ifdef HAVE_KFIFO_PUT_NON_POINTER
@@ -3852,8 +3852,10 @@ static void amdgpu_ras_init_reserved_vram_size(struc=
t amdgpu_device *adev)
        case IP_VERSION(13, 0, 2):
        case IP_VERSION(13, 0, 6):
        case IP_VERSION(13, 0, 12):
+               con->reserved_pages_in_bytes =3D AMDGPU_RAS_RESERVED_VRAM_S=
IZE_DEFAULT;
+               break;
        case IP_VERSION(13, 0, 14):
-               con->reserved_pages_in_bytes =3D AMDGPU_RAS_RESERVED_VRAM_S=
IZE;
+               con->reserved_pages_in_bytes =3D (AMDGPU_RAS_RESERVED_VRAM_=
SIZE_DEFAULT
+<< 1);
                break;
        default:
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 82db986c36a0..cc4586581dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -65,7 +65,7 @@ struct amdgpu_iv_entry;

 /* Reserve 8 physical dram row for possible retirement.
  * In worst cases, it will lose 8 * 2MB memory in vram domain */
-#define AMDGPU_RAS_RESERVED_VRAM_SIZE  (16ULL << 20)
+#define AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT  (16ULL << 20)
 /* The high three bits indicates socketid */  #define AMDGPU_RAS_GET_FEATU=
RES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0d824f016916..bd9ed86d8fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1428,8 +1428,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)

                res =3D __verify_ras_table_checksum(control);
                if (res)
-                       DRM_ERROR("RAS table incorrect checksum or error:%d=
\n",
-                                 res);
+                       dev_err(adev->dev,
+                               "RAS table incorrect checksum or error:%d\n=
",
+                               res);

                /* Warn if we are at 90% of the threshold or above
                 */
@@ -1447,8 +1448,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)

                res =3D __verify_ras_table_checksum(control);
                if (res) {
-                       dev_err(adev->dev, "RAS Table incorrect checksum or=
 error:%d\n",
-                                 res);
+                       dev_err(adev->dev,
+                               "RAS Table incorrect checksum or error:%d\n=
",
+                               res);
                        return -EINVAL;
                }
                if (ras->bad_page_cnt_threshold > control->ras_num_bad_page=
s) { @@ -1466,17 +1468,18 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_=
eeprom_control *control)
                        res =3D amdgpu_ras_eeprom_correct_header_tag(contro=
l,
                                                                   RAS_TABL=
E_HDR_VAL);
                } else {
-                       dev_err(adev->dev, "RAS records:%d exceed threshold=
:%d",
+                       dev_warn(adev->dev,
+                               "RAS records:%d exceed threshold:%d\n",
                                control->ras_num_bad_pages, ras->bad_page_c=
nt_threshold);
-                       if (amdgpu_bad_page_threshold =3D=3D -1) {
-                               dev_warn(adev->dev, "GPU will be initialize=
d due to bad_page_threshold =3D -1.");
+                       if ((amdgpu_bad_page_threshold =3D=3D -1) ||
+                           (amdgpu_bad_page_threshold =3D=3D -2)) {
                                res =3D 0;
+                               dev_warn(adev->dev,
+                                        "Please consult AMD Service Action=
 Guide (SAG) for appropriate
+service procedures\n");
                        } else {
                                ras->is_rma =3D true;
-                               dev_err(adev->dev,
-                                       "RAS records:%d exceed threshold:%d=
, "
-                                       "GPU will not be initialized. Repla=
ce this GPU or increase the threshold",
-                                       control->ras_num_bad_pages, ras->ba=
d_page_cnt_threshold);
+                               dev_warn(adev->dev,
+                                        "User defined threshold is set, ru=
ntime service will be halt when
+threshold is reached\n");
                        }
                }
        } else {
--
2.17.1

