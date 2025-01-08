Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA78E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 04:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F4010EB76;
	Wed,  8 Jan 2025 04:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kOBIQP4X";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890F910EB76
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 04:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtltyG6cityULKCUuK550Qy1ugyEOLEgobO35bbqDmc0tI3oX771HQ3P30DJPLglFLf+MF0yzJ3UwBM/5ZKufG0gRtRMlNEymbTCLLoOyfNswg3vwJoPL1ZjBMNHmW3pxw+/OtiV/7mNh4eeYA9ZIj2CCSH1jVGU9VE9c6VNC+hOrSsBPA6qnKV9NWZNeqIrBh9Gv3W0koR4eAHTup7cLe7TieiViZfUvMkY+/OQP1faBwzbO8oaQfMXEeZ12VJW4Pd6uAveW5/jh2yqiMxO6TqQeoJ44Sqy++bv+j1cIvkNADw6Hkp/NCk0eWDRXjdCmeZIj9RSYlyunOQ1mZjucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Nz7lu3t+Es+XZJGeGzEkiaHBcH4FDEq26fDu/r8U5I=;
 b=iRpHohLj5tzdD/M8GAVVhebxF0UpG5Xnlg7REdzCLjvSmSkedRBA3uBFzvCY2XQDTpCmzk6RKXvNbaZ/VsdoA9S8w3eNOrG4jw5uC5TioFt2SLsCttPFAY7BQPl4l3UYVGejv0cYhAoBixM2rv6v93CKMMHTyPBq1tC11+HAPDACAR8K22glneV1ME1ZLVMUeo8nOclczolqjmk8t75X+aXtxzQHNgON66cxEp0aqeCZZvecIZCZXOclzOatvCr19i6Q3p08G7Kp2IAEfVvB+0fHy7vIaU5tFoaYmODb3+8M+mvcZt/p42YZXd+lweDNw4qUhq5eskszmMskvP0Z4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Nz7lu3t+Es+XZJGeGzEkiaHBcH4FDEq26fDu/r8U5I=;
 b=kOBIQP4XohSGHvhmOe+teQQym/X+J+gZ3x+2OFxuKOKs9PYOJxq7Zi5HU6MnLYhhZRE4g5D1A7QVSfePR2q/rI3fQZfFnq0Ae1ddPhay5oyhXsEeRzzhFFK36artmW1eZ9cxL/HNrxCqFAW+cQm/VV8juI9I6XL+nbDIZCZ5xkU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 04:42:52 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 04:42:52 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amd/pm: add the interface to set and save the
 bootup workload type
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: add the interface to set and save the
 bootup workload type
Thread-Index: AQHbYYB8wQsMbLNK4kGM80OnABci+rMMS+cw
Date: Wed, 8 Jan 2025 04:42:52 +0000
Message-ID: <PH7PR12MB599756BB21F5CAC3AA884F4782122@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250108033607.13506-1-kenneth.feng@amd.com>
In-Reply-To: <20250108033607.13506-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b8f232f1-62ac-436c-93e8-d47d4a1e5e92;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-08T04:40:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB6760:EE_
x-ms-office365-filtering-correlation-id: 8996335e-10ea-4881-b47b-08dd2f9ee962
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gYx1jy8yJlNWzrhBN75PRa6bjaYc6GCy3RfJwoEbYZeDjAqIR/OKdrp7titC?=
 =?us-ascii?Q?Z7XZfKl2pUwgdWMeLVnraBEWBfCPw92g4aJiSUyq0kqlXuZkSKALtpzRHusT?=
 =?us-ascii?Q?QPVGZ++h/EB+jSk0ape+vfBntYpU/issLuyV4H4Qb/rDWHu0KdO/gZJuNFwL?=
 =?us-ascii?Q?JMXMsGIvsrdbi0zU6XRs/59DeHsCqtUDFPLRmdmFWinr6WGCEtuZ6uHmIGal?=
 =?us-ascii?Q?StsdbzDUYe4si8+KuahMGOdLzYumKx9Nh7vR5a7F5D4evBEF2qTAoD4EWJFO?=
 =?us-ascii?Q?qaByYiDocU+PzUaa2wWyebDdxn9PTSW9caRJAyDR0UQJhgiHlDQEvwJpBSTV?=
 =?us-ascii?Q?TFMdRyjgp+QAy7NkZsuwBqUndyIOINz541V3jSYRM1vpUL5btrGfUXIY/oBk?=
 =?us-ascii?Q?x0MsioPKQQJgiP56KjInSACOSFMD6mV2P+6U+zuoV1WATGTXjriwmXW4SDUK?=
 =?us-ascii?Q?eYuRZqRVwz/39+hIduE7kwp4FSb6RcBvdq1+ZdKw5S3C05vP5OPYc12vGGiV?=
 =?us-ascii?Q?imP1SktPH051UPqkvxIOfBdBkh0iyoakxDDvj5YwazQjPWpmz7cM6USb6Ryf?=
 =?us-ascii?Q?iKPS+JBPOlvT4q/yiBfjW5cc4Ida7HRGkaqtlQq71GyoIxRK3Q+7rSKlLPFH?=
 =?us-ascii?Q?Smhbyp42BeKaS3JHInw5W3lQkTi8Svgei7dhQatIz6trEAw3c8WCXCVCsIJg?=
 =?us-ascii?Q?uzHhE2hse4gJ/ACZRvTvDOMDLzAEWgVIO89EhbEvxtlmQK7EsoovgJC5qEi/?=
 =?us-ascii?Q?VHls1zVgryBI2//aql1HhAd71CG/xAc8EcykENLTwxYKsg7uhngTP3Wum+lY?=
 =?us-ascii?Q?UBP+zLQq9BBoPY1OUhljqYnDoq16/1alP0iryH38ut+6kUT+6Ifgc6VlTx7W?=
 =?us-ascii?Q?vsNKBU6qzmYCqAvV696Rbukk+V6yyZC/7PspRtNYDa8zPmCM+xgSG2MuhRBF?=
 =?us-ascii?Q?ws4lXrBDWmQ95Y6j4bgixrnrOPJA12RhhEncnHaA6shc1XrHwYeRbfZ6MezA?=
 =?us-ascii?Q?s11oP7VKhWsUO3C9jG+CjIayD0Er+9LSE1LpHAjbByX6HpfUQL4LuzwACKzj?=
 =?us-ascii?Q?4go3+tYHQp8AFrIVSrEdu4QVp581bIg3+SjcH4ja8AdkynzbUg4SQBz6gQDV?=
 =?us-ascii?Q?IN0IJSQEQ/9vp6cBhvv/1oWgd3TL8E2FH0GhBpAMN4AoYJBUU6RDb4Jz3+tH?=
 =?us-ascii?Q?+lo7N+T8FLYnqebc1fAk6zBP1rIa078v5GIP0nXhuFl/Bf9b77sqtkBXv0ef?=
 =?us-ascii?Q?J5gV+DHZrcqdcsoVnNR78c2XqQq1TIXKlV0KLiTUZgRQpeQ+akjoYS1ZrNet?=
 =?us-ascii?Q?9wnERC/9bBZEYtQCZ8uaoVKwC/ZIgRP0vBnEUrMcaNoqMZGLKToPW0hW4h1G?=
 =?us-ascii?Q?vVAbJz0q+H+vz2gcLqppxNt7eqojbIgNOZ29wonC0KX9/8GkF0nG3+bTqe9D?=
 =?us-ascii?Q?Va6LuLNdPDYyDRDQCHOkYEvFdXv+pAI0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?osVdTRwamtA9ojCLL/9+A/PZRBJ6/rPQh/6oZQH54sI0rPxvqG9uTFY+xCL6?=
 =?us-ascii?Q?6hleQ/et2/Q9hdF8tcdlJwkvrTXnYQh0v9pUfzULXlCnIiMo3MGZQ1ZxdXQj?=
 =?us-ascii?Q?S81TDuOpvAH5X1TSJkzfMNeQgLuHEA0q6h7ZmHcs24cWZzSg45eAJE9X6pgG?=
 =?us-ascii?Q?n1oBJh1hZgriYfQZz7Gq/zqG9Oh6NEqjPxZ1OPiOT41kfgVtK5ZPATR0tjql?=
 =?us-ascii?Q?Q8rLlS5NAhrViDq/rQDMJLiDTxJxRji7dp4Nqjfrx0tiWQFA6ssVPWxUK9ic?=
 =?us-ascii?Q?s1pIiKq/xSL7FPl3sZPeKDJhHhwk1pF2h/eykVzYrlRAw3vfnegFxvFjxll2?=
 =?us-ascii?Q?BDOP/XFWRXp/MVtvQX2b4hPhlroOTtC8pnqTp23tBuLbj0/tMTGi3FhQMHUc?=
 =?us-ascii?Q?vS9DaKI/fEsRBTaSVr423Y31y9L5Yj8PlDf0XCrRXqQLhGAoBR1xprz0cQJe?=
 =?us-ascii?Q?iXDhhNz0OoGhFPU5E/ZQ9+Kui/ALzC/CaDnYBBLBEKpjXZgbvqtEguOao6uW?=
 =?us-ascii?Q?am1iPqtjfjriCmJIZZEY96KTKagnqEw5Mjbz710u8NHJ92HzVC9cGEakcwde?=
 =?us-ascii?Q?s1zLS8qmZ3AEiaaTK7/TlySfwwafxgZ8bw32ONrjfBUCR2rcBAB6F8FwR3ia?=
 =?us-ascii?Q?Jb0mjKL3JYGW0tl9XRQwjLnX0u8RcqiV9TYwiAq7nYMMxqEFD2aaRzmsE9oS?=
 =?us-ascii?Q?eG/GaIqBqedfmGxtzIRn8KeH6mjgQgXA+73T30xiuO/9dl+THmcAtJY6HgPm?=
 =?us-ascii?Q?LSwvEOMTiBonazdoDY/4eIRDe8+sqLgRQ9cGHWPTCbXziENXGVFqf3Aovbq5?=
 =?us-ascii?Q?CiKbIMxUwElZQmbV9e+EAnvHsTL7DyvZzAk1CCe0UN06ly89sUtZEaXGtMAU?=
 =?us-ascii?Q?adiPz8qxaoCNCcR2g3p9lHhQ4vKEEiWlzdYFfy06LtdnwcQulEkcE3w2/ANL?=
 =?us-ascii?Q?/WZ2+9XWS3pKJf5xDszxP2qUXaZcVV3F5syQjW3SM4o5y1or5tTNuCWRo6+d?=
 =?us-ascii?Q?GI95FktWstTLJ5+ljA0gSzgyQIy8/IIXvxWrUNWTyA0FLUENwScyab1a4raS?=
 =?us-ascii?Q?JlYSNMo6yUuvGXEpNsduaI3L/rjFdtXAYLDh2g8hY9OveKH97Me/4vFHlbxu?=
 =?us-ascii?Q?3aFIGVn2/5H6H3MFMAAXoQWgvh95Te0j8FWPkJJioT9Y3cvJ+yM/QTWByjuB?=
 =?us-ascii?Q?9hWAObyJSZ+f+0OHkDcKQ6CjnkvXYORWORa50sdYyjPNnHcSsmyyU8Z6rryt?=
 =?us-ascii?Q?9G11A74vd5FwCkSRbiATOygWDngYMhgrCREYMYqc2bi80hAvke6E8QXfOHVy?=
 =?us-ascii?Q?qzvk0zoRx9iB44ULkPuJTCB9aKnRdiDF3pqqUpzgByDNuKgn8ec49dQ2fsY5?=
 =?us-ascii?Q?1rAv7P9rsue7TphSEKPBfv7qz8NxB51P1tjp/e921V/6Vi3m+IV3NaYRE+Jr?=
 =?us-ascii?Q?JP2QKpUbUmeEzkA2Nu5e2TepTtUucX+24e4nd/35a33YvP48+tboS8wdhV68?=
 =?us-ascii?Q?vJLQ6CDzGGvmmX3J8I7DAYsHqZZ21aVZN9ODdkWk44PHr4pf7f7+TFO8A8Of?=
 =?us-ascii?Q?vWuzJtnC5r5mOQvHkAQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8996335e-10ea-4881-b47b-08dd2f9ee962
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 04:42:52.3148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtDcfqyloxbCXuhgjuQCFcoE2uyhIpXJ1gHuZ9sqkqQZgORZwrjjJW3r8w/eIWsj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Wednesday, January 8, 2025 11:36
To: amd-gfx@lists.freedesktop.org
Cc: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: add the interface to set and save the b=
ootup workload type

add the interface to set and save the bootup workload type
v2: add is_support_sw_smu check and pm mutex lock.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 4 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 6a9e26905edf..94e92e496e55 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -349,6 +349,45 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_devi=
ce *adev,
        return ret;
 }

+int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *ade=
v,
+                                               bool en)
+{
+       if (!is_support_sw_smu(adev))
+               return -EOPNOTSUPP;
+
+       struct smu_context *smu =3D (struct smu_context*)(adev->powerplay.p=
p_handle);
+       int ret =3D 0;
+       int current_profile_mode;
+       int saved_profile_mode;
+
+       mutex_lock(&adev->pm.mutex);
+       current_profile_mode =3D smu->power_profile_mode;
+       saved_profile_mode =3D smu->saved_power_profile_mode;
+       mutex_unlock(&adev->pm.mutex);
+
+       if (en && current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT)
+               return 0;
+
+       if (!en && current_profile_mode !=3D PP_SMC_POWER_PROFILE_BOOTUP_DE=
FAULT)
+               return 0;
+
+       if (en) {
+               ret =3D amdgpu_dpm_switch_power_profile(adev, current_profi=
le_mode, !en);
+               mutex_lock(&adev->pm.mutex);
+               smu->saved_power_profile_mode =3D current_profile_mode;
+               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEF=
AULT;
+               mutex_unlock(&adev->pm.mutex);
+       } else {
+               ret =3D amdgpu_dpm_switch_power_profile(adev, saved_profile=
_mode, !en);
+               mutex_lock(&adev->pm.mutex);
+               smu->power_profile_mode =3D saved_profile_mode;
+               smu->saved_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOT=
UP_DEFAULT;
+               mutex_unlock(&adev->pm.mutex);
+       }

[kevin]:
I think we'd better check ret value first, then assign new value to smu glo=
bal profile state?
which can avoid some logical errors in some corner cases, is it ok?

Best Regards,
Kevin
+       return ret;
+}
+
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
                               uint32_t pstate)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d..5fe404bbb033 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -410,6 +410,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_devic=
e *adev,
                                    enum PP_SMC_POWER_PROFILE type,
                                    bool en);

+int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *ade=
v,
+                                   bool en);
+
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);

 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev); diff --git a/drive=
rs/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_=
smu.c
index 8ca793c222ff..a6f748361198 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1272,6 +1272,7 @@ static void smu_init_power_profile(struct smu_context=
 *smu)
                                PP_SMC_POWER_PROFILE_FULLSCREEN3D;
        }
        smu_power_profile_mode_get(smu, smu->power_profile_mode);
+       smu->saved_power_profile_mode =3D smu->power_profile_mode;
 }

 static int smu_sw_init(struct amdgpu_ip_block *ip_block) diff --git a/driv=
ers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/in=
c/amdgpu_smu.h
index 3630593bce61..c58fc31fb1d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -560,6 +560,7 @@ struct smu_context {
        uint32_t workload_mask;
        /* default/user workload preference */
        uint32_t power_profile_mode;
+       uint32_t saved_power_profile_mode;
        uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
        /* backend specific custom workload settings */
        long *custom_profile_params;
--
2.34.1

