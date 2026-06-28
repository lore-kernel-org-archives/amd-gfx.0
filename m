Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D58EC43458
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jun 2026 16:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E53310E3E1;
	Sun, 28 Jun 2026 16:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FbzPTSKQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295A110E3E1
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jun 2026 16:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/IiiJuzpzRr4HiuYEE6N0vvko+WttYPWDGjuyfsuOMCdrWZyElaRfm8hUQQfT530SwMtZAoRtCPBhEsoDu5qtFG2cSY/sDAxYcM2aYLQWRx29FYlI/igdpn1f5TNMkxSPKkVPpH+QIgdLp+1kqtfy7f79gN/LiucvlOAeHKW66HqtNcOsoenIpk9+6cZVfS+wuaGj9ogRwAGMpkMtlNytd0C98oZG+Zcj2HgXvB1IPBliBXVacbrCYBQfWfdOyLkpDRc/WKo6mLG5OCRjtDYqxPmZNLq0y6GxbLePS5U+ZcUEaVq+QT3Ia3SnKm3AKbGb50Hmj5XohvvH1qECGowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn9+dHBMHwU8TMKNEbHV3v5iEemH1zhvK28APMWXkhA=;
 b=Lih7zSDGxt7/b2YCkA9RGus0AXQZ+f+A3gCzQyUIsiYrrUWqSbmpNcUnbi0rB5pvAC6ik+aCm8Q9xIQHfQ1wKW1Bi9fmq7taF0ElOHaE7JW9VZevvV0Gp5rTqCSeRfL1Mw+2a8hvoiTJ8IGRKaOAD+CLpW9Lb7G40luUHkFMIfThm9jyadELxV6FPFJ92CV4oINjqupm4avfaVLP+g9JorGM9icj8QGMf9mZHs8MsGWgK+P/PWT2XednQGo+2B+PpmgPPy9Ht0fZI0pnEfOKjolkoyGEgClDXwGm1t7XjAqN22Nc136TdtHVcjKgkCZE059w2mSt1pgFvCW+Z56oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn9+dHBMHwU8TMKNEbHV3v5iEemH1zhvK28APMWXkhA=;
 b=FbzPTSKQVlwLo0ascLBjUqKpA6ov3jfqv9+5TIr61lNEOOkuKJ25cfiPgXg8mnGg77a2gtqsy5Ffn0M3l+H3jaqkoblEaGUgOOUlwYye+ApPOjp42GYddqLOVw6BTEFF+n3pE5cIuuCzXPAp3ulsEE3R4e0hC5Btu/6s331Zhjc=
Received: from SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 16:31:05 +0000
Received: from SA1PR12MB5616.namprd12.prod.outlook.com
 ([fe80::78fa:a7a9:a14f:a50d]) by SA1PR12MB5616.namprd12.prod.outlook.com
 ([fe80::78fa:a7a9:a14f:a50d%4]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 16:31:04 +0000
From: "McRae, Geoffrey" <Geoffrey.McRae@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix i2c devres group teardown race
Thread-Topic: [PATCH] drm/amd/display: Fix i2c devres group teardown race
Thread-Index: AQHdBxmjTW13N6PuMEiw3sJAwgzzwrZUKLj5
Date: Sun, 28 Jun 2026 16:31:04 +0000
Message-ID: <SA1PR12MB5616BAE037D29D7D38D8679E88E92@SA1PR12MB5616.namprd12.prod.outlook.com>
References: <20260628161719.1598835-1-geoffrey.mcrae@amd.com>
In-Reply-To: <20260628161719.1598835-1-geoffrey.mcrae@amd.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-28T16:31:26.390Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5616:EE_|BL1PR12MB5804:EE_
x-ms-office365-filtering-correlation-id: fc02010a-e34b-4338-7740-08ded532a658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|38070700021|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: uYD0rYr6zmxdJnWw8mG2LKYMOjyV6UXJpUVfMr5Jm8dwRy4CUA45wGOPtuaOSwFOqXfZLr98WaLF2VuK12/uEBdpk3LXDAf4/8vD+PQNP9Lze1/aPV0rlz44Xw0/bB5uwjA3LiftKcp3l5gb8HOUbc7PD31Pli1Pj3UxP6WxJnM6C1/L04veGtnA1IJh1+918MSIt5mJeydQUak+ejsQ+Yu3ulJAgymqtSkrxkP2yaf8sWwNqcnMI4nh5LhhwA1aBMJcI/Cks7sfqceUOonUCZA2JKz0tfOYeizmZncqoW0KwbSJsmQrfBdIvRrqPooPPmd72PlL8esGqcB7kvIBtBkFJxtKO0FF6YzNrWybn7ae1jIqESk+1BVuXx1OLr/QzDJu/XW7AB5p4ayFBqrJsvJfVFoUH6Pi13MaC9Vjq5xen7fDeYwKKpInzOJ/+hUanRy3aGo6l0WClJASi9t5Uo1bJjIxiTBfp7xSM9oxS7bnrD+hoj9g5xgb70orko5lPzFB+FPq6DPZkYqF2m0otu3MEaEMw8SZz+BEq7wCdOzg8u3y29k6Ww7PCyjDhOkOD4BcgYD2uXVG4v7PhJ2Z1sx8sqW3AwJdx9lEpVIr82XlgTY4MPYtnB8IUNxHQGcsyb/tFJk3oI2o6TnRjSsnPVkCdTC/vtz5x8lWCrxPdXnoTVjLYRN8fekEec2nha7XU2h7ycnZHD+MPYqVcLvtuzAD85YesAQf0I1jPD0uQMQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5616.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NDEcN5vpdoq3GL8+8+buCWwYTq/Ko5cPQUVDw/cfJTj7z+jEbFwDXQ+NPL?=
 =?iso-8859-1?Q?saXTh0+rlLCBq4CUA2HVYEXBAYP6K5FmASpTLt1bc8sAH4ILUAxhbVa08W?=
 =?iso-8859-1?Q?TyQvAn1fT1B6n0MgsFcj/SHMqz9rOxhkMKs96TQDRGO8RTdltxpvOEfsJK?=
 =?iso-8859-1?Q?VNnrsVjGpiXLI+xPCgEy2NSB4O5ynjSC27AM0K/EnlCedW8a5qA9PqZHZF?=
 =?iso-8859-1?Q?lewrKffo2uhfIGC/cA/hI73qFxTtbtMdpGy6It4f0XFIUxG8zrxui5CI50?=
 =?iso-8859-1?Q?B/2liYrlSARzFld87yHRJbWLbFVdFQWZdB525ObY2W8enGMh10QCvHBV/t?=
 =?iso-8859-1?Q?ccMEDLfAqoTBs75RptH00krVVynlMvvbo0Dz60HIyt9Q+1KWu5ndNMgJVJ?=
 =?iso-8859-1?Q?uyUNPTPhBB0Z19AjwZT43zsRpMCbCYPERj7irTB33C5Ye8dIV6p2TqFHNs?=
 =?iso-8859-1?Q?pupNMJc4JwjHJ0zc5Va4aqW/erLkdwbGtetpG8gaZ8eZiXYg6Dv4DsFaXA?=
 =?iso-8859-1?Q?qhHBphQq7APa1XT6bThfk9za23ufDtEzk9gt+HufaZ6gRTfQxBxCO8twPr?=
 =?iso-8859-1?Q?XVfvsPcm4vnP/YJfTD6gbydE6FRUeNi+eRxZrBWN/cZiAmszdINtLtG6oC?=
 =?iso-8859-1?Q?mCzahYgt6SjrtR5PNnd4m5Jx8rjUbGZ5YzBXAO07K8nIyouvdAIV1/QpKN?=
 =?iso-8859-1?Q?QoWXbgB8fUoO8hFVcNZJhmJDDxVlcCsR44P06ZmS1cRc5iciQrIvH0c/xE?=
 =?iso-8859-1?Q?efvpt/UX7Oll/IE/VWNN5urEVNv9Ls86Lv9Ba4FKK7ImYMBCh6q86T6rS2?=
 =?iso-8859-1?Q?FpRQ2ZJIK/8WC79R5+8MWzGzXf1cZkYhcIcJU3xA33nBXPJJ3sAp2W2kmB?=
 =?iso-8859-1?Q?2kLM2DM1QFGecSzkfQ/+UPELir59lF9FPsY4J4D/SW+DU1oreg7iOjFB7w?=
 =?iso-8859-1?Q?FaP9/3M47RlTuEJkC3e4o7pTMxeulbzhc/y8mkM3Aa6hf6V2Zym2M0NDZn?=
 =?iso-8859-1?Q?65K2fw3rT4/Bw7V6Dk3tMBEBmMScguMSHknCcwq4k1EAnGdSWDOVvzm7Yf?=
 =?iso-8859-1?Q?cCGXcTFTqtHOEJPx5VWzKURK/YyTCW66CFRUe/Gagjxdz9Mt2Au8FmwQIL?=
 =?iso-8859-1?Q?Cr4xc81BDozIgIqy3DkH/P10mk5Og/kiS4bCG/G3X29a/cQzGC3juk4fxR?=
 =?iso-8859-1?Q?5UrDcty32JW+XWBL1rKG934xJTmHqFHk8sBQhIUcyQAhA4G7wtUPZFsjqQ?=
 =?iso-8859-1?Q?ly8EKSeD3RdO+jtMAJ05gVhm5u30Fauuw/YqXapNNElL9NbierMdi0FPJt?=
 =?iso-8859-1?Q?llgXyPsvjJYWzNLF9NdlOV6vsYfrEUE/5VfTyQC1JO9wdt2WM/Wli8v4Cy?=
 =?iso-8859-1?Q?U8BfR501BNYZ9jID75o9h8WQ4NecdXgk5bh+CnxKs/8kOOpZMgrVEgQaOS?=
 =?iso-8859-1?Q?cGrMLNzkfFolHTqMMOONbJ3zIse7WwayMBJAxu0FZczbF5UYgDAfEu6S3y?=
 =?iso-8859-1?Q?bWrmfEYVOPXDLdiIGasfRMg74zBNg/OTRcxiRIdM9nqpVpNVRuybEPdTLN?=
 =?iso-8859-1?Q?00n1YCpfYSviYrq+/SLErNYV6iz/yUots0sc8Oigs5unI9ZB3JHkdWUQR9?=
 =?iso-8859-1?Q?7QULmTe+JQU1wVWXPvwdoQ7yHUszxdYpFictYwsv7X9Mlrg48XGpx45jOE?=
 =?iso-8859-1?Q?hPZwcE2wfKipJBEuZVbUl9DlyfrF7EsKo59lj8n3X4/mBjTsIwSRqE6wGU?=
 =?iso-8859-1?Q?90v74AwldS4998BBiSZyL7MiyRgFOJ/YD+jgpnJEfOv4Io?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5616.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc02010a-e34b-4338-7740-08ded532a658
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2026 16:31:04.8228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moczu7raiT/N7uFoHpFjZYcvN6mfG4aSvP4M10UYOMPzmhhbdjvnCTDuMyCCmFE0fRdi8t/u4sRfHhnxwUMMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

Please disregard, v2 incoming with properly worded commit summary.=0A=
=0A=
________________________________________=0A=
From: McRae, Geoffrey <Geoffrey.McRae@amd.com>=0A=
Sent: Monday, 29 June 2026 2:17 AM=0A=
To: Deucher, Alexander=0A=
Cc: Koenig, Christian; amd-gfx@lists.freedesktop.org; McRae, Geoffrey=0A=
Subject: [PATCH] drm/amd/display: Fix i2c devres group teardown race=0A=
=0A=
When tearing down the AMDGPU display manager, the i2c devres group=0A=
was being released before the i2c adapters were fully torn down.=0A=
This caused a race condition where i2c transfers could still be in=0A=
progress during device teardown, leading to a NULL pointer dereference.=0A=
=0A=
The fix ensures that the i2c devres group is properly closed during=0A=
initialization and released during teardown, maintaining proper=0A=
lifetime management of i2c adapters.=0A=
=0A=
Fixes: 5b3eca05cfb0 ("drm/amd/display: Use devm_i2c_add_adapter to simplify=
 i2c cleanup logic")=0A=
Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>=0A=
Cc: Alex Deucher <alexander.deucher@amd.com>=0A=
Cc: Christian K=F6nig <christian.koenig@amd.com>=0A=
---=0A=
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++++++-=0A=
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++=0A=
 2 files changed, 20 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c=0A=
index b97ceabe6173..5613dc9903fe 100644=0A=
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=0A=
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=0A=
@@ -1496,17 +1496,26 @@ static int dm_hw_init(struct amdgpu_ip_block *ip_bl=
ock)=0A=
        struct amdgpu_device *adev =3D ip_block->adev;=0A=
        int r;=0A=
=0A=
+       adev->dm.i2c_devres_group =3D devres_open_group(adev->dev, NULL, GF=
P_KERNEL);=0A=
+       if (!adev->dm.i2c_devres_group)=0A=
+               return -ENOMEM;=0A=
+=0A=
        /* Create DAL display manager */=0A=
        r =3D amdgpu_dm_init(adev);=0A=
        if (r)=0A=
-               return r;=0A=
+               goto err_release_i2c;=0A=
        amdgpu_dm_hpd_init(adev);=0A=
=0A=
        r =3D dm_oem_i2c_hw_init(adev);=0A=
        if (r)=0A=
                drm_info(adev_to_drm(adev), "Failed to add OEM i2c bus\n");=
=0A=
=0A=
+       devres_close_group(adev->dev, adev->dm.i2c_devres_group);=0A=
        return 0;=0A=
+=0A=
+err_release_i2c:=0A=
+       devres_release_group(adev->dev, adev->dm.i2c_devres_group);=0A=
+       return r;=0A=
 }=0A=
=0A=
 /**=0A=
@@ -1521,6 +1530,9 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_bloc=
k)=0A=
 {=0A=
        struct amdgpu_device *adev =3D ip_block->adev;=0A=
=0A=
+       if (adev->dm.i2c_devres_group)=0A=
+               devres_release_group(adev->dev, adev->dm.i2c_devres_group);=
=0A=
+=0A=
        amdgpu_dm_hpd_fini(adev);=0A=
=0A=
        amdgpu_dm_irq_fini(adev);=0A=
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
index 909ee71d6d59..13a18e1ed576 100644=0A=
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
@@ -688,6 +688,13 @@ struct amdgpu_display_manager {=0A=
         */=0A=
        void *bb_from_dmub;=0A=
=0A=
+       /**=0A=
+        * @i2c_devres_group:=0A=
+        *=0A=
+        * Devres group for DM i2c adapter lifetime management.=0A=
+        */=0A=
+       void *i2c_devres_group;=0A=
+=0A=
        /**=0A=
         * @oem_i2c:=0A=
         *=0A=
--=0A=
2.43.0=0A=
=0A=
