Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C964CEBF8A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 09:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D908E10E036;
	Fri, 27 Sep 2024 09:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQ4SXD9R";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0A910E036
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 09:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRH1IUL2o8pgFdEQ4k1O8/y2NoLKdTi/4R7YfcdejzCtMSZ6D6/JxsgYHbnXk2onUe8Hw4m9g4wwHGmwhldFvsltMAtwJYA+tOB9xUDbvnxtCsVSf1zCsd/z8mNN5Y9RVYFmnyn+4zjL6d8RI++/EbKZE2jLOChxlTR3zxepWcREplHas7BuCj1Ez8PcQf/yVtIhKVIHjtaumqDPcvFVWiIZNSBU4bXf3cci2UbSW38Fl7S3nNKCG5RPoM8WQWHIKWBtK4TB4EGoVbuAeQNgwlI4VNhMvflTcCLLLxnk1zBjRP1Cwwne/3dk4Z2vSBhkHovoSxwgvz2exVXa53TtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn5jENf4ZbdN17NicBWXhkwhZo4ODDrg+zCOXdT4RSo=;
 b=VOHJ8TEUJHY4KrBV1+glWpXUYlAQj13NRLhg1wEGGy114v+NO3y9TG6J2TmJQeqzGEc7pbGBywpzKY+BiXeDlGDak/Zm3WcLWSHDx7bQgBbYdpBOxber5eUeltxicpLDUTPhUh6M4M5FipqLaSlK2q3i8fCeUrWD87cXtSYp6LQ3IMhidcb3yZb133BKM9lHhsP4eRatW0yJSbn6CVGj+5RdG96Lg5F45HH5ueNyr/e1i0ACtAEF7i9puRenlIKityV7qUPnZIDNZXAENKI14bl7cySGwj5VUKWIkObK9dw2lZ8OeiVMgkmE69EHDB38BIAtu8bYfhCgXF1k1wJDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn5jENf4ZbdN17NicBWXhkwhZo4ODDrg+zCOXdT4RSo=;
 b=xQ4SXD9RL3wV4Mq6e9y3/oYmVazBsJBDd1podTW+9csmrUcMyaQtpk1fb3R4RLpGYa3CqaAhUieyoBriCctvSbnQS6PhAwtzOYXWvaawVDYKw7+MikryE1IN/mmiea7ZHHz84S2O5x0LYzi4G2xIcUiImXkw2+jW6jJ7hFrxwSU=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.21; Fri, 27 Sep 2024 09:57:21 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%6]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 09:57:20 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for
 debugfs getters
Thread-Topic: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for
 debugfs getters
Thread-Index: AQHbDyCFQnrKWRLB0kKbsjAU3d05OrJraNFw
Date: Fri, 27 Sep 2024 09:57:20 +0000
Message-ID: <DM4PR12MB5165976761005ACA332486148E6B2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=52bdaaad-a9b2-4ccc-9cb7-df713eb253aa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-27T09:56:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DS0PR12MB7927:EE_
x-ms-office365-filtering-correlation-id: 0ac95449-baf7-4d3b-54f8-08dcdedac72a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9SO9D5nmaTjFzWcrXHTN3PnsUGLXPN2jBFsE8krtYksWDvYAlmOO4ma4j4J1?=
 =?us-ascii?Q?Lpp2SRYnXRQ6Kz5oy6jrs3GW/cw8XcsNfmb8yXz45SSlM4xFhsC5zU3h1cWs?=
 =?us-ascii?Q?NRsNDbR5vn37nGJTquUW3GzAKBleU49oEACU3MkCJE/5ePmn2JzzO6Ye3iYA?=
 =?us-ascii?Q?2f9sICKJhwCIx9jAvYEKbp82fU9d+H/mIm8W0R9YnPFYTnZEFar48rHQJdKO?=
 =?us-ascii?Q?W2MYgCHuRQDHtxBcKIpt2RKlLm0J1E0hC4uJ9TOYrDmX78pj1UqGTXUVpbt7?=
 =?us-ascii?Q?tEcnuFkYE46b0fttphcUa0pqZ9LmM5D7MEb+3GbEqX3D/5kSdCyLjByaHkD0?=
 =?us-ascii?Q?bxfSpwb6n1CLkUUY+zii5D35xyKHThQr2SmgOq0Go71usfwVqZwLmucTvFv+?=
 =?us-ascii?Q?1gKgdDirhzL1G8fli9/n01xcSRYJPnDdeeAUWqaRvPLQAX+xW3qsUeG2pQQc?=
 =?us-ascii?Q?Letz7N4pXUh3Z/YI8eBvPwedj7TqyeDtFprrKrRPe2IpHiejYmWJkPd4c6iv?=
 =?us-ascii?Q?EwvX734WBhvT4JSvneAoX2mKgcoM4WRZcy5kLdgcK5wGrizUlaAUhnqNwIXX?=
 =?us-ascii?Q?F5IJyDisWmpmv1nTeogof0TVPVhgAO6kpDc6m1rXCnL/rD5PpOE73xOSAyR+?=
 =?us-ascii?Q?4KSNtrf19wkj+1NXmHNUhGclPl+oC6MTJ7+aQmKKFq36XjISZ64d6+NTUCsy?=
 =?us-ascii?Q?CWvLyGKrmT42n7U8l8A+6vDftcUI6b6jznxoRmyL1yMLvYsTs24YxGLkSvBo?=
 =?us-ascii?Q?VCQGRPkHaZ7YRkyvdu7oDWWXKopywclJYCrJhN1wc0iryHIm9N7sbmjVGIRm?=
 =?us-ascii?Q?KWtxdLIubZsPNWFSNRMH4bZ6yGCqfn2AfAxULVxACOgGdoy4E9cUD1WfkiqR?=
 =?us-ascii?Q?HmXDPhOreNKRpUrbjSN6E4hPmCacecHcP8J1IYKKd72iDBhHaPAB6ehAVd86?=
 =?us-ascii?Q?99I8ktZwXJxGmNL1WVCANfb0BjNOUeLFkrvMg53Y4p7qaHedV1by1Atd+Xns?=
 =?us-ascii?Q?s2SQ1H8YPP9Ww70rrmxscLg1kT4j3B0zUDR0orV3DT1RgOVcIU5upS2k9boO?=
 =?us-ascii?Q?xkqdxeJ+2AxYH4zyojmbGbup4FdUVr/NJJca6kd7A25F1+IbIirurVYKAlaB?=
 =?us-ascii?Q?VUOGUHx2RqZCzc6t3r/gbn25cbqLIL24lUO2AtauY+vtKWcPUBuAjMPaX3ne?=
 =?us-ascii?Q?JcM5W1/R+RBHla9ecsg554xkNVmv6//Ff//PD+C7zAVgGrLtvmr3/ofHoYK+?=
 =?us-ascii?Q?WvVleaK5TbJk/wD8foeyklrqtKXjf1Yz0J8GZEyKBjrfyoaOcqNwyxuoK8HD?=
 =?us-ascii?Q?vTLOZ6aeZozo4SKb+5uALLmIRw88KaDtTMn04IqOfJ1WoA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XMq1i7z/WEIJipmpEnRgOSWnLIm1Gu6gePAs27B8STsfp6j6q9bK5W0cN/0U?=
 =?us-ascii?Q?qHFej2M1QBL3/e8RCX+YJjKWmQglYiDO8pDPa8RFHIXwJG+pMgYNFzcP5QAQ?=
 =?us-ascii?Q?9EeavZM8tAWj31If6A+pLT4Qeh4zSBASQDrRhuFEn/W7Cf7gGdaL1xundbp4?=
 =?us-ascii?Q?avMdDwhYBNAVQbejq9m1w9+3dzAIakuV1oerBp+Khuo15bOFN09ZiBs+plDH?=
 =?us-ascii?Q?9SMlEQbteQhRe71nah476Fizf0tR8XsDgdu+jTHSMmF1Xc4u4UIGDCldIzlO?=
 =?us-ascii?Q?0KUN4hrf/R7ztlTi0DiHEjrQZyBEEMtQPFoOYIULhgQElfzppyhRjAgcz7/J?=
 =?us-ascii?Q?RYUqUe2Ulf7w74orS933EE3VbryzYTENv/SvjlrMfgd0u/hhB4kQGnO3ahw7?=
 =?us-ascii?Q?msV1LPWFCQGpXDGixxI5QkWeUi62HCcRbvKfWuMHXz89XE0QI4uoA5HK3Sux?=
 =?us-ascii?Q?vS+8DYHBqgnPzzuKyPx9RS7jDeuO1HuTRbnAcqvA3qdWG5lBzC3EBm5GugmT?=
 =?us-ascii?Q?X82eTC0tcN+Fho1JCyCD36S3dznBfN/LxKFm6uUuEtysPonEQNsh+deKcGhw?=
 =?us-ascii?Q?WxOqZzc/fV0W8/CALzvt1vQc8QYw5FxmBP2Nrz2mhRRrYKdQ6wQ/yBoe+OXe?=
 =?us-ascii?Q?w+QcyaVKZYRlKdfp+s7wakVvGpIuJQklOAzrSDmtJZ8uB1ZzwM9kbVILqW45?=
 =?us-ascii?Q?J+IMCMQb5u1mAXd7p8gh6J/3XQ2xUyXh1aS6rgXBkvLVmsW2gxikhVLr3gZx?=
 =?us-ascii?Q?S1S3BcxK5CjkB8jtvVGP0lGW9kiSheVgLE09ZVi0yi7Qv9xMZtDaY4pMkXMm?=
 =?us-ascii?Q?0OUilzQ79FNZI4Mw+j2s5XdYh/OHZBZrFdZBvHCfOmvvJPzCuGqYUyYl6jgH?=
 =?us-ascii?Q?RgXuTrbOO/BMINzBndy5RmiOk/iyKy3cdiQh9EU+cxoxlZOJy0BF5Fss0/1V?=
 =?us-ascii?Q?h2h+GMg/Ij/ohBMgFluT+G5nC+HsA1qKz8hQozNXysl4M0IDj5oZZtf26YmH?=
 =?us-ascii?Q?YQ/u4J7xd7QgXhIz/2ABV8TpTo3g8CXS8dj/SNqXhM7KfYKyI2IVygs22tDc?=
 =?us-ascii?Q?BGwI1UvVLPGEJM69U66fUrSUOwUenYBoIjUn7CqQZxkhh53P0EWiowXF3ivG?=
 =?us-ascii?Q?XERiWudNnPssO9vD2SPp7WWQDzkSQYhNkYiaDs6xHuOs4lM3w4oa7cO9ienn?=
 =?us-ascii?Q?BBP+2A0cmasDN4Wd2HSpYaR0A6q2YPXDlm532sk4q1P/Tmhf6BAlu/lFm2Fz?=
 =?us-ascii?Q?8U8Yx9n3YO6Tw/fJFKgf03ZjWq6khyu2wZEzlL4XMf4sLc9VTMmSCyIiNyHd?=
 =?us-ascii?Q?VI9DTuxeAq2V10av9QS7T8D4LImr193ZtRmPGVZK2dnc50ZiGx0l6tL1UIMa?=
 =?us-ascii?Q?/Jib+llzR2QZG03EtBhXP/FyonODfsq5gwrQ3y3ZwreCogDU6a4UtviMwkwO?=
 =?us-ascii?Q?hFQE8WykQMIzmhiIsLQZHKg6lQQeG73HK/IqBpSb9NgSDfIugDDUBhLZ0iaV?=
 =?us-ascii?Q?THqb+eZTGeV0kiSOkcAHUjpbzwnOcvH8l4WoavYj1mnyR20yyEDeNGrAnd/I?=
 =?us-ascii?Q?nlTUFof9uzXCwak/35k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac95449-baf7-4d3b-54f8-08dcdedac72a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 09:57:20.4863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PO4CCqaXh8yQBaojj5dV/pFzdI9PWiwe/X276RroFJwX9tF31gjcOo1ZHClYLnsh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
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
From: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Sent: Wednesday, September 25, 2024 3:54 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Limonciello, Mario <Mario.Lim=
onciello@amd.com>
Cc: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Subject: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for debugf=
s getters

Don't wake up the GPU for reading pm values. Instead, take a runtime powerm=
anagement ref when trying to read it iff the GPU is already awake.
Kenneth - just a nit-pick iff(typo) -> if

This avoids spurious wake ups (eg: from applets).

We use pm_runtime_get_if_in_active(ign_usage_count=3Dtrue) because we care =
about "is the GPU awake?" not about "is the GPU awake and something else pr=
events suspend?".

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.c=
om>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 138 ++++++++++++++---------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index c8f34b1a4d8e..f1f339b75380 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -145,9 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device=
 *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        amdgpu_dpm_get_current_power_state(adev, &pm);

@@ -268,9 +268,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_l=
evel(struct device *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        level =3D amdgpu_dpm_get_performance_level(adev);

@@ -364,9 +364,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *=
dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        if (amdgpu_dpm_get_pp_num_states(adev, &data))
                memset(&data, 0, sizeof(data));
@@ -399,9 +399,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *d=
ev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        amdgpu_dpm_get_current_power_state(adev, &pm);

@@ -526,9 +526,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        size =3D amdgpu_dpm_get_pp_table(adev, &table);

@@ -840,9 +840,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct devi=
ce *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        for (clk_index =3D 0 ; clk_index < 6 ; clk_index++) {
                ret =3D amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_in=
dex], buf, &size); @@ -930,9 +930,9 @@ static ssize_t amdgpu_get_pp_feature=
s(struct device *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);
        if (size <=3D 0)
@@ -996,9 +996,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *d=
ev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
        if (ret =3D=3D -ENOENT)
@@ -1245,9 +1245,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *d=
ev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        value =3D amdgpu_dpm_get_sclk_od(adev);

@@ -1302,9 +1302,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *d=
ev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        value =3D amdgpu_dpm_get_mclk_od(adev);

@@ -1379,9 +1379,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struc=
t device *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        size =3D amdgpu_dpm_get_power_profile_mode(adev, buf);
        if (size <=3D 0)
@@ -1467,9 +1467,9 @@ static int amdgpu_hwmon_get_sensor_generic(struct amd=
gpu_device *adev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       r =3D pm_runtime_resume_and_get(adev->dev);
-       if (r < 0)
-               return r;
+       r =3D pm_runtime_get_if_active(adev->dev, true);
+       if (r <=3D 0)
+               return r ?: -EPERM;

        /* get the sensor value */
        r =3D amdgpu_dpm_read_sensor(adev, sensor, query, &size); @@ -1583,=
9 +1583,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
        if (!adev->asic_funcs->get_pcie_usage)
                return -ENODATA;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        amdgpu_asic_get_pcie_usage(adev, &count0, &count1);

@@ -1711,9 +1711,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct devi=
ce *dev,
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(ddev);

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        ret =3D amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
        if (!ret)
@@ -1787,9 +1787,9 @@ static ssize_t amdgpu_get_pm_metrics(struct device *d=
ev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        size =3D amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);

@@ -1825,9 +1825,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *=
dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(ddev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(ddev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        size =3D amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
        if (size <=3D 0)
@@ -2700,9 +2700,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct de=
vice *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(adev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(adev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        ret =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);

@@ -2828,9 +2828,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *d=
ev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       err =3D pm_runtime_resume_and_get(adev->dev);
-       if (err < 0)
-               return err;
+       err =3D pm_runtime_get_if_active(adev->dev, true);
+       if (err <=3D 0)
+               return err ?: -EPERM;

        err =3D amdgpu_dpm_get_fan_speed_pwm(adev, &speed);

@@ -2855,9 +2855,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct dev=
ice *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       err =3D pm_runtime_resume_and_get(adev->dev);
-       if (err < 0)
-               return err;
+       err =3D pm_runtime_get_if_active(adev->dev, true);
+       if (err <=3D 0)
+               return err ?: -EPERM;

        err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &speed);

@@ -2916,9 +2916,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct de=
vice *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       err =3D pm_runtime_resume_and_get(adev->dev);
-       if (err < 0)
-               return err;
+       err =3D pm_runtime_get_if_active(adev->dev, true);
+       if (err <=3D 0)
+               return err ?: -EPERM;

        err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);

@@ -2986,9 +2986,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct de=
vice *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(adev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(adev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        ret =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);

@@ -3152,9 +3152,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(st=
ruct device *dev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       r =3D pm_runtime_resume_and_get(adev->dev);
-       if (r < 0)
-               return r;
+       r =3D pm_runtime_get_if_active(adev->dev, true);
+       if (r <=3D 0)
+               return r ?: -EPERM;

        r =3D amdgpu_dpm_get_power_limit(adev, &limit,
                                      pp_limit_level, power_type);
@@ -3685,9 +3685,9 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_=
device *adev,
        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

-       ret =3D pm_runtime_resume_and_get(adev->dev);
-       if (ret < 0)
-               return ret;
+       ret =3D pm_runtime_get_if_active(adev->dev, true);
+       if (ret <=3D 0)
+               return ret ?: -EPERM;

        size =3D amdgpu_dpm_print_clock_levels(adev, od_type, buf);
        if (size =3D=3D 0)
--
2.40.1

