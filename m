Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FAFC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 03:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DFB11A03B;
	Thu, 25 Apr 2024 03:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJFU/W0l";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AF511A03B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 03:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB73f1q5LVMrjxdndBhu8yPNzFNbTl9S7NjWzrjMk0dnVr7zUi8WptCi1k1+F0wPi9VWCHwylSWml3AtnvkJa/Q2vb7EGpLeS4fHj1aK2udjSS7Hp0McQo/2CqY7DQv8nHbvOoubUHkLp0LHG8w7sCHTabSlxoj1KSEcpjr7QLklukjZu9pBHGCQ3RGbQbUyxPbZreJRc2cHFjIw18hT3LDm4NGCnWpnuPvF+ZKn+9LI5493Mo9aLYUWGGtiYjd6IrnYlZBgt8iEYAYgoGz876MX9N8jemSNeC7QFTxGg8cyyW6XhO1GoisZR+7nqitFGTMySatbM0CPqABX7B507A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVFDTAjCYhrbEJr/DIVNEI31k4mQKBI8qnZrYkdrUpQ=;
 b=NeE0Ut1qB3wivo5Hvu7shGNL9EDhyItd9QArw5agvxCxwle+myWHQB5YFZ2Ju2QafNCSTAptQLIrVoqL+VNYHc7YJEOEiZvKXyN9Nd7Uc3y2+0G08gWFcMzq+FJAU09rlVu8Npxxbtabs3LU/wnL25fqFKQSN1TH2DfkHIDvNPv4wkol7+b9jymHLy4OPB2hm9Zu012qhd3uT7ryUQmpWnGFwwhevLDfgfkrAQzpeEZo2eAs/io4REo0T86KTuVrYS/fOH8OS2Hp+Qe68SpcSjz+bK512aMNSBfyDBTieA0kyO3pe8GV32XjGpzTnFT1hEFLfI3NDScZFYpuQh9Wpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVFDTAjCYhrbEJr/DIVNEI31k4mQKBI8qnZrYkdrUpQ=;
 b=mJFU/W0lQjE6JxX9CWQV4NK51hLQoqLhydGmP86Kj+7KeU0e2AgWn6zH4GiqAPcMYxUnqThpGhizBHbUYU18WAq+qleLLIm/M79rVLUm1+5+x7wPzXqMHiceLypSs3LbmX1t72E3JkY+UINPax/KG80jMOti49nzh/VIs4wk35o=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 03:31:59 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 03:31:59 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 06/15] drm/amdgpu: umc v12_0 converts error address
Thread-Topic: [PATCH 06/15] drm/amdgpu: umc v12_0 converts error address
Thread-Index: AQHakTzEv9q8DBU/OUm6IWhhyHNBqLF4V58AgAAEkFA=
Date: Thu, 25 Apr 2024 03:31:59 +0000
Message-ID: <CH2PR12MB4215169AE023F383D1BB45DDFC172@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-6-YiPeng.Chai@amd.com>
 <BN9PR12MB5257D9C7AA4E63461DEC8166FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257D9C7AA4E63461DEC8166FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8002210b-ec5f-4ac7-a188-2a36b0b117c2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T03:01:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|BL1PR12MB5900:EE_
x-ms-office365-filtering-correlation-id: df4a6473-e863-4f76-aec4-08dc64d843b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?KAwHMJZUUnERscC+Lwz3XqHOzrYxXt/a0zTJMLEPwq9CpzUxQZnn1rAAnyvC?=
 =?us-ascii?Q?TeqUyVaa5YgT2se39lanaixVtyyYFnClXCtsGnH2QhjH3WtlEJi03vWWY9Sx?=
 =?us-ascii?Q?4+QLkr1iO3JpwgiG7SZ6sfgx0y+bkZI/rpScWPGbbko6p0qe5glNfLUW/PGU?=
 =?us-ascii?Q?CKfzsDzoBJqBHUtYxjPN+vFkTPhV9vFp2FV0L0LjeayjbEUGNvMtc2qorIk1?=
 =?us-ascii?Q?vaD8U8P56IfgthsjIk1hQuq3+ZognJ4zXSnED0UR0iUxnlhxQxmyuUYwXOlq?=
 =?us-ascii?Q?dX0Du+AllMxzTT6Dk39cS2Ydf4CTeGrPnIwNh7zJwb6uTTJt0NSwpqtVbliU?=
 =?us-ascii?Q?mkLY2B5SC0yfPPBHasYgVpUALAkpcfHh+t+H/svG/R51OH8Vo4nf5aDdKlD+?=
 =?us-ascii?Q?W+JDmmZqAh7/SHqG2hMJCeEQzhe1uiaZufrdE57lqQkykJxIXNvPaXxeIoS5?=
 =?us-ascii?Q?D6xaa7SElTW6zb35xYWSCktVDK447Gr6HDrNtzYL4Do7+EaGtjLjixDYdQLx?=
 =?us-ascii?Q?ifg8fLgQVgImYkPA2KDCjfz/RjZtZ7I2Vl5TCNVZp9WcHA2XuMSxgmCoDnDG?=
 =?us-ascii?Q?SGPB7rietL7S3aHetNNH63ORCdINTxO6GZZSEqMcWSAK0Uj6QCkUFfU/z5N6?=
 =?us-ascii?Q?ljSeENsIK1ZRhRKM03Ohrn9a7gVqIgMWvOBu7NO9tbvbilSnIhKGLnFTA03I?=
 =?us-ascii?Q?AsarAWGXCZ7RZEqByAvk5CYRInBOzj7FmeZHLigEl2KxCiMeGOYHJbrzuif2?=
 =?us-ascii?Q?RC/8A0oNUjjYyCKDJ5Da0Cf4OWbZqMi+RBYkq9RPB/gUeQQgi0EEwwtPH6Ic?=
 =?us-ascii?Q?g0ybsMpr/o6AbNhMQTjoCRVeyLO0P+2I/8NmyzRbhGc4OZqvMk6Cmdq6Xu6c?=
 =?us-ascii?Q?dXZV/+fafNX09cSzEjkE0YA1zpUu2NuR1dWqvSUchPevSaDEkZAGfngtEqgm?=
 =?us-ascii?Q?xOW6tJz0/s26AImUzT0msnt1Sr/PnMDzucqQRtwRCz1rC6HstwlYUW+Pa+W7?=
 =?us-ascii?Q?umBKXcKNSwTcytCejXU5+86zYS0r9d8I1DUthq7G8zN1ao3ldY28JeaAhbtp?=
 =?us-ascii?Q?RdBZdasrydnu4nVTtkdj51QMWMQ26zwD9XuXABW+9+8+fWUfqEBL54OtQcPW?=
 =?us-ascii?Q?RWLxnoWktE8lGr29fN2Pdctze/lLz6PNGVsMrtxJ84c7O3x62cdWQljqGFo/?=
 =?us-ascii?Q?hdbH18xaDTh7SCAXibUNjg8xIz3MuYxJEVvd9ap9cCu4vOz3JEWMQVglDjOX?=
 =?us-ascii?Q?nCAMFzLKzpeB+SVb1jE6KBCWrg69eA/G//rFPYCpjPAB4vezt2u7rG2Q9bIO?=
 =?us-ascii?Q?ahyqLyoeVwYQNw0RH7FowdgfZu9SZm65nQ6LmzrT0aMfww=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fqPokTbL2upYnjJ9Y8UXRtwAvAInFMTaLlGCkpsxPZ4gm8q+aS7XCThE8WCV?=
 =?us-ascii?Q?I70KjaltkQWLxaOdDEPOQNl26WGzhNELdu2jIsv4ccMjhSZQlOaV48usNBUO?=
 =?us-ascii?Q?2G4LrharY0kZ5HL2nw33nN3rMQ12dipTHbiFfMUyXwTr5Nhr6jFoTQ/2522H?=
 =?us-ascii?Q?O8NO/2IS4uumtN9zphCcUz03hmT8PHa4uYSrWbkoertBTBnbjAbg9WAF4RqP?=
 =?us-ascii?Q?DvW3dGis+C94BqrTto8EzqEUKYknOxV9NgkKXh6AqbGIG9XZBWtIEMGvz30j?=
 =?us-ascii?Q?wK5YO7gBI3CJ3cR0GYY1Ah0iga6df4MHkAzq+KZB81N3pUjoLEXFLqOo5wFe?=
 =?us-ascii?Q?RCKezr+naqSQq+5wooDDHMKrOoS6GsHb8C4eK2IM71Uh7twDVImax8UbmrKp?=
 =?us-ascii?Q?hnCQA55LvoXKNoF33QcGIEMpNtp2COgaDHz24aOGKJIRF6UdKutdqjkZveBU?=
 =?us-ascii?Q?eGU4jVu9Engb+ngL+dt1YqZJMdJHtIfs+e8rj54/qkrTVOKO+0o3/1pgaJ4c?=
 =?us-ascii?Q?ZMe8Ur7RlDS2RA0KPrnBclCxzgq4i8t+JHIEQ7Rt1PaRcLNd7af63WQhTsWp?=
 =?us-ascii?Q?hQxR3X/dHbR5lsnR2MBUhAA9izfJVDhjK4dkbJx86KfoTXI++24kEtFc2rkK?=
 =?us-ascii?Q?sw4upwWINojNc84/jjD1etWtkCyv9ekS7niSIlZq0AqJvA0viB8dnqpQtrMy?=
 =?us-ascii?Q?EnSpgpNsDYTBw9nSsMxj09w7HHPGUrEKnsvoikQh55aQe7/HaLeNnl4WW40Y?=
 =?us-ascii?Q?lqnBI4RaQL3IER9Lb0vxGQvUs+2hj/MAmS5FXKnGlnD2VXh5hs+cOb9gas+N?=
 =?us-ascii?Q?GrIWiCdwTtY+qAvA+jE43BMzhSj27Au7Yq09Pmm21Hy6kC0ARVTeH2LUgpkO?=
 =?us-ascii?Q?Ebsu3mSAHRjG81Zsz/Jsm5xAqwQhL6x73EgI8XzMsOFOEZn6Z9CMFwusydZm?=
 =?us-ascii?Q?OtsowvbsRLTJQfpDaezvD8GZhWFUuNJWZsHJOFnzk4tTS53lV1AsD80IniJE?=
 =?us-ascii?Q?+LxwtT9EUDLa4hSG01nVWppUlbQbm4mc2slL33BagLfUOCba1l42i19JGUw3?=
 =?us-ascii?Q?c17YmSoua+VXMl2SiwgSVfPTnn5Fw8LUFaWwqAIew6DsB8w0dD/3Pnk6orq0?=
 =?us-ascii?Q?38Ml2WH4kGtMaNAgTwPsPHeTygNJmosPXOuHIi3GmPVe8WmVW6tUhGqURf2p?=
 =?us-ascii?Q?Hf7D7T4k7BwtlWUl/8qjd44KGRSRBapO41ZXMvG6WofdHtjT92ZCStajvHWA?=
 =?us-ascii?Q?iepWuKgB8QSLkQKo5V9i4L3Whfhz6YmqH0e70mZF6RBOB/tDsGxzqFy+XKlj?=
 =?us-ascii?Q?lrdQ02KWzlBeU8y/aWuHYAiPFr8FHlu17C7y/q90BOowyixFcFA4muntNbIW?=
 =?us-ascii?Q?VnzZWn/vmZuecYSmoNX9CQ8YgMdZ6eLJBfpo8V822ArbJdHDT0ynlYBkvlli?=
 =?us-ascii?Q?vcEAr65ky4sdP/MQYZT70oM3gYtsW6ynoHm5JHsZiX+C1dDTCm4a0JsMhp98?=
 =?us-ascii?Q?AUhZUCOARoLSOXR5upsDYCfwtasiH6B5+oScbVfGJZeqCFylzmZvPAAm4yTo?=
 =?us-ascii?Q?2SGT6iK1SGzFEZ+scA8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4a6473-e863-4f76-aec4-08dc64d843b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 03:31:59.1373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJSEAnO7y+pg/dAYU765IvzY/EZHLnuMpw+pOzA3dwas+6fawjLfKyfBDz4p9h/CVzvgH66E7PCazIvBkQJs9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
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

[AMD Official Use Only - General]

amdgpu_umc_fill_error_record  is called in umc_v12_0_convert_error_address =
directly to prepare for page retirement,
The new path need to check if these converted pages already exist before fi=
lling the error page,  umc_v12_0_convert_error_address is not suitable for =
new requirements, so I created a new interface.

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, April 25, 2024 11:03 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 06/15] drm/amdgpu: umc v12_0 converts error address

[AMD Official Use Only - General]

I might lose some context here. Can you please elaborate why we don't lever=
age the existing umc_v12_0_convert_error_address implementation?

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, April 18, 2024 10:58
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 06/15] drm/amdgpu: umc v12_0 converts error address

Umc v12_0 converts error address.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 94 +++++++++++++++++++++++++-  dr=
ivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 12 ++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 81435533c4a7..085dcfe16b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -222,6 +222,66 @@ static void umc_v12_0_convert_error_address(struct amd=
gpu_device *adev,
        }
 }

+static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
+                               struct ta_ras_query_address_input *addr_in,
+                               uint64_t *pfns, int len) {
+       uint32_t col, row, row_xor, bank, channel_index;
+       uint64_t soc_pa, retired_page, column, err_addr;
+       struct ta_ras_query_address_output addr_out;
+       uint32_t pos =3D 0;
+
+       err_addr =3D addr_in->ma.err_addr;
+       addr_in->addr_type =3D TA_RAS_MCA_TO_PA;
+       if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
+               dev_warn(adev->dev, "Failed to query RAS physical address f=
or 0x%llx",
+                       err_addr);
+               return 0;
+       }
+
+       soc_pa =3D addr_out.pa.pa;
+       bank =3D addr_out.pa.bank;
+       channel_index =3D addr_out.pa.channel_idx;
+
+       col =3D (err_addr >> 1) & 0x1fULL;
+       row =3D (err_addr >> 10) & 0x3fffULL;
+       row_xor =3D row ^ (0x1ULL << 13);
+       /* clear [C3 C2] in soc physical address */
+       soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
+       /* clear [C4] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+
+       /* loop for all possibilities of [C4 C3 C2] */
+       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+               retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
+               retired_page |=3D (((column & 0x4) >> 2) <<
+ UMC_V12_0_PA_C4_BIT);
+
+               if (pos >=3D len)
+                       return 0;
+               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+
+               /* include column bit 0 and 1 */
+               col &=3D 0x3;
+               col |=3D (column << 2);
+               dev_info(adev->dev,
+                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
+                       retired_page, row, col, bank, channel_index);
+
+               /* shift R13 bit */
+               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
+
+               if (pos >=3D len)
+                       return 0;
+               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+
+               dev_info(adev->dev,
+                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
+                       retired_page, row_xor, col, bank, channel_index);
+       }
+
+       return pos;
+}
+
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
                                        uint32_t node_inst, uint32_t umc_in=
st,
                                        uint32_t ch_inst, void *data) @@ -4=
82,8 +542,12 @@ static int umc_v12_0_ras_late_init(struct amdgpu_device *ad=
ev, struct ras_common  static int umc_v12_0_update_ecc_status(struct amdgpu=
_device *adev,
                        uint64_t status, uint64_t ipid, uint64_t addr)  {
-       uint16_t hwid, mcatype;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       uint16_t hwid, mcatype;
+       struct ta_ras_query_address_input addr_in;
+       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
+       uint64_t err_addr;
+       int count;

        hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
        mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -497,6 +=
561,34 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev=
,
        if (!umc_v12_0_is_deferred_error(adev, status))
                return 0;

+       err_addr =3D REG_GET_FIELD(addr,
+                               MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+       dev_info(adev->dev,
+               "UMC:IPID:0x%llx, socket:%llu, aid:%llu, inst:%llu, ch:%llu=
, err_addr:0x%llx\n",
+               ipid,
+               MCA_IPID_2_SOCKET_ID(ipid),
+               MCA_IPID_2_DIE_ID(ipid),
+               MCA_IPID_2_UMC_INST(ipid),
+               MCA_IPID_2_UMC_CH(ipid),
+               err_addr);
+
+       memset(page_pfn, 0, sizeof(page_pfn));
+
+       memset(&addr_in, 0, sizeof(addr_in));
+       addr_in.ma.err_addr =3D err_addr;
+       addr_in.ma.ch_inst =3D MCA_IPID_2_UMC_CH(ipid);
+       addr_in.ma.umc_inst =3D MCA_IPID_2_UMC_INST(ipid);
+       addr_in.ma.node_inst =3D MCA_IPID_2_DIE_ID(ipid);
+       addr_in.ma.socket_id =3D MCA_IPID_2_SOCKET_ID(ipid);
+
+       count =3D umc_v12_0_convert_err_addr(adev,
+                               &addr_in, page_pfn, ARRAY_SIZE(page_pfn));
+       if (count <=3D 0) {
+               dev_warn(adev->dev, "Fail to convert error address! count:%=
d\n", count);
+               return 0;
+       }
+
        con->umc_ecc_log.de_updated =3D true;

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h
index 5c2d7e127608..b4974793850b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -69,6 +69,18 @@
                        (((_ipid_lo) >> 12) & 0xF))  #define MCA_IPID_LO_2_=
UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)

+#define MCA_IPID_2_DIE_ID(ipid)  ((REG_GET_FIELD(ipid, MCMP1_IPIDT0,
+InstanceIdHi) >> 2) & 0x03)
+
+#define MCA_IPID_2_UMC_CH(ipid) \
+       (MCA_IPID_LO_2_UMC_CH(REG_GET_FIELD(ipid, MCMP1_IPIDT0,
+InstanceIdLo)))
+
+#define MCA_IPID_2_UMC_INST(ipid) \
+       (MCA_IPID_LO_2_UMC_INST(REG_GET_FIELD(ipid, MCMP1_IPIDT0,
+InstanceIdLo)))
+
+#define MCA_IPID_2_SOCKET_ID(ipid) \
+       (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
+        (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
+
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status);  bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *ad=
ev, uint64_t mc_umc_status);  bool umc_v12_0_is_correctable_error(struct am=
dgpu_device *adev, uint64_t mc_umc_status);
--
2.34.1


