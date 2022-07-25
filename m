Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04939C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 05:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BFF18B30B;
	Mon, 25 Jul 2022 05:17:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DBA18B30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 05:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA3c8AQYuVt/IgTbl8z+NaJub9rcI5bLIwpPM82w5DaIOzJaOP+Inmm78OtTV2ugGYDc5p0aQY5zMKIxwTtjDyXocc/nTKwLxlmhofTQD3FN91W9QjmPa3D7h+5mqdkx0t7hY4vfurOTguPUmdbJ0rAJtOOiZgOpfDZSG+YNDvDQXcsTT20G+FB3b3k7e+oj4+SLfcbXDgQTxjNvSYj8RuSQDvZoQiEacoH5sSKvap2/6K5xSUcF2GdEmFGRevsj8iF2tXOjyZYY6mMnEDUjE0t3odvz1BtjkbaWlsoaytmeto8Joag3epDsqT1LXOqPufXF8F+O7Oir08sTt+sD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRVgzaZPBHQTD2TJD8zKn94VXEYNUmri7lCdrv6lG1s=;
 b=JNE2y1rGhIIgGikDZj0QNn7sPBOXQ8rHZdWIGUj2bGi+EBJ0t1ciwrgrImIffixv+2S6iFvR5n/yvpeXMQN4Mim4xk0fYOd9JV17AkzawiC7+yHpkF9oQrI/ob32lyzvxsjRcDxXjs0Xo8NmoFIuYAbhQqYSg8xD8A5g9PLW0CfjqQRxkDdhyzlX+JvFjzupDsGXzCrmO7/LjPc0rhVetzKt0V5GHnKsBHoAVNcVg9JRnxH/zFZsDgIuy13pvfBoy+1Y9UYnrySQXQD6HLkxP5bs0g9CCici+T8svTpNVKRMc/9B0/7nc7FnBfZwe8HI9J9mBb9FGO/Eb7Al6lN9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRVgzaZPBHQTD2TJD8zKn94VXEYNUmri7lCdrv6lG1s=;
 b=sagg7c2zVLlpF+IBecxaUS/Ti5/pZkMHspbGyJ4MsZo+hfI+ng8YZA9ZnbYLAqlP3+js/qDBRcLUgDVZsWpW8C9qqJtY9ndCWdxKwxZjIcOmvD1F4FPDlckVYIEDkY4yQVn6Jd3hwEfLKnsoUtbGbqBeb36nsUw/kI3X++n7MTA=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 25 Jul
 2022 05:16:55 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 05:16:54 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct RLC_RLCS_BOOTLOAD_STATUS offset and
 index
Thread-Topic: [PATCH] drm/amdgpu: correct RLC_RLCS_BOOTLOAD_STATUS offset and
 index
Thread-Index: AQHYnpKTdqdauK9XhEOx88geS2U//K2Ojfjw
Date: Mon, 25 Jul 2022 05:16:54 +0000
Message-ID: <BY5PR12MB38732EE46F1F5172C2DF830CF6959@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220723124133.669673-1-yifan1.zhang@amd.com>
In-Reply-To: <20220723124133.669673-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bc67c16d-9ab7-4f98-b318-d26b13f8e5d7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-25T05:15:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5e35db2-fbb4-47e6-38db-08da6dfce380
x-ms-traffictypediagnostic: CY4PR12MB1703:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Im8uQuxx4xwarbvseN1yY9d32GqtnbpnoN1PFT+GvhdIj58H0ne5WcwT/072jcGuW532meqXdIGa81Gq43a9wZpOQsKdQ9YVnWa5FmbtksehQBlWBV3IUBEVFlTdMhsBhqdogH7LzBB1SUiU/ouHXDK0MRJTe+0W8sn+6Lu9fbTBz6iKNODY0b/NnbqvfILPzdRNASOeuXc7OcrGl03GjwuhSAC+ChP745WHap1aUYWvUB63bGd5oXK0JhE5KG0pUDv3xbbqhyE+OGLykLKAmsDmgILxbKvP7mPUrbTyU0o8OGYjGdnzcbV2MC18zMAsXIVzMe2CwVxNFO36ilsetpgyIXKW7tdYSW6jakMeb9dIh68xmzaDj9UWSTcgIdEqL2sDmxKIihk1owdOET0x3f5wtr+ekdEp5YqtdTkpz20hK1f1X5fYWRTjAXSQE24PIV19mzHljXzSxuownz0z7fckNRHF145T7BmM3Pu5wAIlRWRImX85NZrTVVx/p43OyBVxtTWcz0rFxFYMpoTRTvlEqyHiufUyAsByXoYiIymUZE+fylbTkI7Q4hE9VZSnlZG7K8dJ6deJTtKdVtD3NeOnCngA8sJzyKHatSLOdJAXGk5IHxk34+8No8CCjfvZRsy1UeFtA0ohNFMVMO3WN5OHJkpbizngmlotpHNdFl0bTAI2xQySlEzT8obhanZsvmdGf+Ek5ODuSAPUBNawLL2T4165ry35RV42Zt9nxJe5JLXjC3VuAFOwSLsZ3rTlWApsSWR5mcVQawde/FYqx7t9D5HDnYTV5mf1bw/v/EjYIwcQikgAtAyLryKmMsXS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(54906003)(19627235002)(110136005)(41300700001)(316002)(26005)(9686003)(6506007)(53546011)(7696005)(478600001)(76116006)(55016003)(71200400001)(2906002)(66556008)(66946007)(8676002)(4326008)(64756008)(66446008)(66476007)(5660300002)(52536014)(8936002)(38100700002)(122000001)(38070700005)(33656002)(86362001)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uz9ZXX3kg6z0hoA3BRH+vUX0n9xmPBsYanZychCAPH3k2Jrh+wgui/erfq/t?=
 =?us-ascii?Q?Hnw7gKc5OfnIGbkszdo7PlP+BuCoe03o2LhJ8S2cGyqteWHvtc7US1HZVwkf?=
 =?us-ascii?Q?x4+D1Y27TpTcInOHkeTMhn/wRTWiySuYTgMcg/FZUo7ujw/k+Oq7mGYePJBN?=
 =?us-ascii?Q?sUvOxbIS5C6vJ57YU6d9QdbG3fy5mPDaVdLI74ubJyCnUWyh43W1UXS/MKJt?=
 =?us-ascii?Q?xLvb9bLaMDvqW/xkv3Ael4sZIdhthgVAcaU9HhNlt5byBbSm+kq1U1WkAngG?=
 =?us-ascii?Q?2Ip+OkNrp57EEtTaUVAWTiYcGE2mU+3ZmZvdSDdMN97NU0L2H2kCdDn0OxdN?=
 =?us-ascii?Q?sZ1nTpovxbi5M1vED9BrUNtWgU86sRNz5+UpwjpH1zORtC+YPkaorGOJF6/T?=
 =?us-ascii?Q?zOJq3en5uZtzil4Z6hmzEpZdDoX7vPD87Ss7TZO85GvDue8ChljrsAto7Boe?=
 =?us-ascii?Q?80WZT24hs8wZrCoIEWVgivbN7eTXBj3Dj0QWndULnavh+f9OJbsKtyWawu3E?=
 =?us-ascii?Q?PAygYNXwb8Q8eJDQmyI0WMpF0N+exGm1hVfS7eBVFHUDXjAmTVj6z6ZbRkr8?=
 =?us-ascii?Q?WjbnrZwkwB5/3ovy/jFFrpmIADSWUJ9hBJ95M6+6gKuGZqwpnDS6tJNRnSXy?=
 =?us-ascii?Q?TILhNGrrJAb7gAXs4N3adbqRe2YMu2/m9qp3y8kcJJ79oUA9D5o8Xk1BZQYg?=
 =?us-ascii?Q?Ej1y8qEbcky6br2Y/hAF4UCsIyL1H/bdNk3RbLu/nw6t9U8beFri+8vW76Zv?=
 =?us-ascii?Q?fV0q+9hvw/Zhq19WifiDX6gq+B0kHBGZZWNl/495v0P/77iIGk1jgSwYogch?=
 =?us-ascii?Q?nrOQaWgrn0CVEk3meIzbTQ1AhOqGHYAwNSkL8lU5yZrtr71PqVdEzKZmhfQO?=
 =?us-ascii?Q?aD7UTie5KXg0GFcZWChLfi+t1f2Kgvrt4mFkvXrBnrNdSVhxEI/bmoqj3I8f?=
 =?us-ascii?Q?BfdCtarjdqILD8PR0mDegQg0rpH1DLCHwMcg6A3Ig8QBRo3Bpy0zr4gJyIl5?=
 =?us-ascii?Q?5F2MLTNvpP25IS7BDJ9QWGuOv6DhNFdlqQULU8uAo5gZc7YWuZ/bJGnbhPHP?=
 =?us-ascii?Q?623UXqvqJHtRHeydHBMoWm8kwO3gadb4QoqJwi9OJlEHl5XM5vAzQ3qMEm0D?=
 =?us-ascii?Q?3J2S2kgYRcTAYth6jYQU0D8DiaFkDUYXwraicWVZ/m5CBvE1TJ7wul8g5O3a?=
 =?us-ascii?Q?smbP2oJ5W09oOBeKeciWhz0R+Wl1F9g6+KIoYpUoY6JTSE/MjaR3A8tsL/wu?=
 =?us-ascii?Q?D2lPyd9VjockDENNENYzESXsDwNeh8sAqjeIeOfSJIGU9ZZ/eK6HyerVGu2u?=
 =?us-ascii?Q?7dt2fiyihIr3twvlk965s2O3kDKVM+r2p3+AvDdnf5Vb2vzT8PAypUnlBGJJ?=
 =?us-ascii?Q?UusmUig2gz6/jFQ+9u3sBh/V6p/VcDhfK7hbe4iCrKXJ+lN7FyQL13uqXy5W?=
 =?us-ascii?Q?5e0SRNeebiJlZUac/wB5KThQuIiDJuPD6lg9rPRg8hSwUC0sE/Sjs3dQpwia?=
 =?us-ascii?Q?4Hcf1jBSjuHZaX0UH/8cBl1cjmzFEiEJv7c6vGTYkvuIrrzi4breo6BgqWih?=
 =?us-ascii?Q?30IodjR3nlU3abfNar8PJC/hptd/EgzAUTey7fx0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e35db2-fbb4-47e6-38db-08da6dfce380
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 05:16:54.2051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIP11EOu+A03diFWD15dGyf2d01NgpUTToQEeUGcbgPrbWudB8At2rQMFOKNhGApHxolAC/oB282gMsvnFIs+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>


Best Regards,
Tim Huang

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Saturday, July 23, 2022 8:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Tim <Tim.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd=
.com>
Subject: [PATCH] drm/amdgpu: correct RLC_RLCS_BOOTLOAD_STATUS offset and in=
dex

this patch corrects RLC_RLCS_BOOTLOAD_STATUS offset and index for GC 11.0.1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 0787a965615b..fb9aefb1b404 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -77,6 +77,9 @@
 #define regICG_SQ_CLK_CTRL_BASE_IDX                                       =
                              1
 #define regSPI_GFX_CRAWLER_CONFIG                                         =
                              0x1296
 #define regSPI_GFX_CRAWLER_CONFIG_BASE_IDX                                =
                              0
+#define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1                             =
                              0x4e7e
+#define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX                    =
                              1
+

 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
@@ -2800,7 +2803,10 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(=
struct amdgpu_device *adev)

        for (i =3D 0; i < adev->usec_timeout; i++) {
                cp_status =3D RREG32_SOC15(GC, 0, regCP_STAT);
-               bootload_status =3D RREG32_SOC15(GC, 0, regRLC_RLCS_BOOTLOA=
D_STATUS);
+               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, =
1))
+                       bootload_status =3D RREG32_SOC15(GC, 0, regRLC_RLCS=
_BOOTLOAD_STATUS_gc_11_0_1);
+               else
+                       bootload_status =3D RREG32_SOC15(GC, 0, regRLC_RLCS=
_BOOTLOAD_STATUS);
                if ((cp_status =3D=3D 0) &&
                    (REG_GET_FIELD(bootload_status,
                        RLC_RLCS_BOOTLOAD_STATUS, BOOTLOAD_COMPLETE) =3D=3D=
 1)) {
--
2.37.1

