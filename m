Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C63C433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 16:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2187D613BD
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 16:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2187D613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C125089C09;
	Tue,  6 Apr 2021 16:12:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED8189C09
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 16:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox6PNFLherut8KS3Hwas9UEFvzl9mRuPKlRYp/xSiIkhlGvQx1+B8f7pVBGQHNg18V+/0j8/RhrGZ4mpgr29Vj4ekj9sjQv2N6jzmlXitrfMGdNBVqiOni4AzsjGykEDxCJb4wcbkl0Bh8TnpBOlJfNoHpx0k/olDE0qUbe5kSACbFytIUCJd/qBd9B6cgnbQyMUMHmnSUcJy2vI27yhuEaUjuEjqAb04SXfNxhKokFfFYn9Pv8/F3EdRPjbzhwuqfR91I3XaLANzeW0b+WSamKg4eRq5hm+m3b+pjPayU179skeBAe4HA0PRo/O/Ev5vP4sPGtcZSDguLhQyZm0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP7EJQYWT3e3DfnwYtzBjRzx8MdyYxeJwFbdgrmm9+0=;
 b=hI+xfwACc+oCPI810+Ajmv4Sjvp7qQ+vat/jW6W/Mpsvdf/O3juy0xLzd3YVQWWSyr1Qxz4P/v0TPTUcAq4kmOmI0zNTMPvknerMZ0btSnrX1xG+Dm0lfSZ6S6xMwHfe7v8H1PtLXsBZGkUbEDDp+uMJWjb7GpOqkwNm69b+ESGONooKamP6wypv1KkGX4Ti5noyxo+5DzKMSeS5VHYUusZvMU4qaIBI+8zQe4ROiLpFlPSe2uiT9U9zT0xki2OTIvUaLR07j1MrybOMawKaMQLswSwHQlPD+Rg+rzOPCRMxeMgrZ/12w37WbakuIrdykm2VUj91XXB1+5bZcx7b6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP7EJQYWT3e3DfnwYtzBjRzx8MdyYxeJwFbdgrmm9+0=;
 b=yEOO+ZOtZLU/EJMtTo5BKG0WvkYRbP+DmLlHyeedokwXreW0MYMkts68lqC8LupvUZruqVcreHUQNA7ZA2EmGYD2LoTkZ/maUbhndXezoEw7fnaABWno1RHSFE/+UmCOiUICf/oBcN3JX8I0HxRu2jZpsnZR9+oEU6N2HJhQQ7I=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 16:12:25 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 16:12:25 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move mmhub ras_func init to ip specific file
Thread-Topic: [PATCH] drm/amdgpu: move mmhub ras_func init to ip specific file
Thread-Index: AQHXKv61BjV1f/AZHU2hT9gRJZEJw6qnqSqA
Date: Tue, 6 Apr 2021 16:12:25 +0000
Message-ID: <MN2PR12MB4549FB1A86E9B16E31C97C9F97769@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210406160528.21192-1-Hawking.Zhang@amd.com>
In-Reply-To: <20210406160528.21192-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-06T16:12:23Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b9ae0d3b-98db-44f3-8997-646b4a843945;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.217.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9598e72e-8918-4888-d21e-08d8f916c48b
x-ms-traffictypediagnostic: MN2PR12MB4518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45188099A2589FB30E07645497769@MN2PR12MB4518.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYS68RkL0b0wze6YFF1ikWTiUMV9yhG0qL7awVUYQnP+IYQVlErXLB2GtW3dd7DyaceesCSxkC0JiG37Bl4IzCZbuLEpfhcHg9plpGcX4shIwOnGKinbLg8Hq9qHMHtCHV7xr6+7toTozIuMBVRu/Lo23gjfklxLc4zMzEXEt8hspUAdPYdAb79HcKsymcqnztd+7vunSSCSS/WB/KiS+eIoq1Kjx0nkRfgSoS8cEO5oWK0LrttUKrO9FJARauD8+qwZ4cDNTCR9HhUYGA+sWkB5lt9SJJkLror/0nLe0aMWwyagGZ4HKmGIpHiSyj1xYK6j3wJ5C5GQbCXq92/ZbnG3CsYwTyL05Ay8B/e9LwIpF4AiyGau1k26AOkrOwqkumFZPNrG0MaGiPLmf+fTllswkX3ZCxoAWFSqYcZurLCHer3unW5pGSlrdZkmwYskVKijJo39idF3M9/G6qQkc6wk6zqegotc2XDzs8vXynEzBISesgerRknnmKQ+mYdt1cQHn8XvcHo/Z2UkIdP2Or5ukx0vp63pw+q/u+pKtHqkO86SiiCNA/2BBBLhhFBSN7p8oG0nNg6m2EMM1SgneLdVirWB/Muj98VbopBYNRNqV3wsdUu7Z3ke5bBxZYi7O/j3Pdft77C3Dm8boHsRVj3gjgFBqbafiWSAOaqLwIE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(76116006)(53546011)(2906002)(8676002)(83380400001)(71200400001)(33656002)(55236004)(186003)(316002)(52536014)(7696005)(86362001)(6506007)(110136005)(9686003)(8936002)(478600001)(66556008)(66946007)(26005)(5660300002)(66476007)(66446008)(38100700001)(55016002)(64756008)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FXF4O0UlnWaKyL+lMBRauK/zBuXxGtHnqhYnHnmjxAWDC3mFQxbe2zoOln0P?=
 =?us-ascii?Q?Z3+UWW0oRfUQypa+pE7ZfX0+Y36/1AUw9GhCfohDo73Q2YBnYhRY7fKhlfCb?=
 =?us-ascii?Q?BGuIBra3qgLncfCQuGcRtiV69YlsoHo3hxs5+JU19gTfYrlOkNwpky2o/dlP?=
 =?us-ascii?Q?WSh0jwdKJEAgDKLmL/4hSmbjZ7d5tDvIYlonHmklFPd5lEtPlgAIYKR6O2zK?=
 =?us-ascii?Q?gea1mu7x0+cXuIyJZhS/B2XNNLsPVd2KqUvjuIML6Oqw49t493SXcCfaYatT?=
 =?us-ascii?Q?0bXl9x8BPH8viJTNk+B3joOHWEbmx768sDf1/RlP/aYYyVQHfC6TeIbcoJ8k?=
 =?us-ascii?Q?7tso37e7psXyIds9WWCXkgn/Hm8LynjmnxjBpF4R4meYKPj4uukVLFtDUrYm?=
 =?us-ascii?Q?FkjeCDAss/cP2RVh+P7BvJtdU4cteR0IcYdZwIozeCijHdr9mmRrynsK8G2H?=
 =?us-ascii?Q?CJVNCJzvegyp707haxobaiCmyrwnAwhbzvvWUT4RVQSfVqALrOk8g0LYAoqD?=
 =?us-ascii?Q?7SeL7RGiJFp2n3uAM08iSE+JbozfY2htVL9GWS35mGbxxpbMMEsMvC1PRjVA?=
 =?us-ascii?Q?MwqDlcEcy4RTQTW9TXi93/FJ4nHos9UvpKIO+gA3RjIcMoilzThHtDa2UbkL?=
 =?us-ascii?Q?t1xsqUTBT3GEltBnqQ3602kmloo4MKes90un1ooclKk0OAwwWZbD9DYrjz8D?=
 =?us-ascii?Q?SGRsTXDZ42+lP7EDRfgmyVlTVKAVBpO3QQzaZ3tdHEGpZ7/aZF7kKE/RhYRW?=
 =?us-ascii?Q?6faoIc+YWvUAK7zhBEciVMbaZgJk+KXP3wyBiCqHYZumqHyjxK2Uks2hucIH?=
 =?us-ascii?Q?HJ7WWzqjPXHvRaVuS3i+q5Yjq807034Diyx6EfNQrl2qBd7aDml5aij2YjJy?=
 =?us-ascii?Q?3BrvzK48Ob2tl7BJpZD8GqAHD7W8woUP223/ZLeJGpeVgOj61nDOU8NrQepZ?=
 =?us-ascii?Q?VJWlrIJEUPMP4iNxG+mpCKrxsbY01zlMNGN+CtcmTsE4QmAxIWALmFC/euyq?=
 =?us-ascii?Q?Z2NaUBaBaQBAQScfyFegaOa4C6afBZTbyzCp25K/rlGK7z7W72gbNwxIdHVc?=
 =?us-ascii?Q?7xLg8212QMxY3AWxgE2bwYss3kJyAr+pdGdsu+YEm52r3ENKyvX0/aaYOQTJ?=
 =?us-ascii?Q?mCiPxTQrybewgtow5rDV8VqmoBCyPB5EcPf5pz9JQbDYiqGfzbvff6F6/qS2?=
 =?us-ascii?Q?VAVPX8tHbya1IY6QcbIO++lLtNUY6UlYTyUwKqgdiBNIkFGgEZv3xuzCgC+B?=
 =?us-ascii?Q?Ak77IsQahpAY++n0gqIhVNOTprDJs5ojVoAYiy1nRwfX/I417MDpIemmroFa?=
 =?us-ascii?Q?uAqmSpVZtIXx1kb5MadREjYq?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9598e72e-8918-4888-d21e-08d8f916c48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 16:12:25.3844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzDqZ/PM0xR+M5is8GI5MwVRWoEaUX4TQTUdK3jNQFduPlsDG3Un3oq+VkuUYAre
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Tuesday, April 6, 2021 9:35 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: move mmhub ras_func init to ip specific file

mmhub ras is always owned by gpu driver. ras_funcs initialization shall be done at ip level, instead of putting it in common gmc interface file

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 -------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 013efc746821..4d32233cde92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -30,9 +30,6 @@
 #include "amdgpu_gmc.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
-#include "mmhub_v1_0.h"
-#include "mmhub_v9_4.h"
-#include "mmhub_v1_7.h"
 
 /**
  * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0 @@ -401,22 +398,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* initialize mmhub ras funcs */
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-		adev->mmhub.ras_funcs = &mmhub_v1_0_ras_funcs;
-		break;
-	case CHIP_ARCTURUS:
-		adev->mmhub.ras_funcs = &mmhub_v9_4_ras_funcs;
-		break;
-	case CHIP_ALDEBARAN:
-		adev->mmhub.ras_funcs = &mmhub_v1_7_ras_funcs;
-		break;
-	default:
-		/* mmhub ras is not available */
-		break;
-	}
-
 	if (adev->mmhub.ras_funcs &&
 	    adev->mmhub.ras_funcs->ras_late_init) {
 		r = adev->mmhub.ras_funcs->ras_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 64cd08ee8290..321caf77b0a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1186,6 +1186,24 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev) {
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		adev->mmhub.ras_funcs = &mmhub_v1_0_ras_funcs;
+		break;
+	case CHIP_ARCTURUS:
+		adev->mmhub.ras_funcs = &mmhub_v9_4_ras_funcs;
+		break;
+	case CHIP_ALDEBARAN:
+		adev->mmhub.ras_funcs = &mmhub_v1_7_ras_funcs;
+		break;
+	default:
+		/* mmhub ras is not available */
+		break;
+	}
+}
+
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)  {
 	adev->gfxhub.funcs = &gfxhub_v1_0_funcs; @@ -1209,6 +1227,7 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_irq_funcs(adev);
 	gmc_v9_0_set_umc_funcs(adev);
 	gmc_v9_0_set_mmhub_funcs(adev);
+	gmc_v9_0_set_mmhub_ras_funcs(adev);
 	gmc_v9_0_set_gfxhub_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
