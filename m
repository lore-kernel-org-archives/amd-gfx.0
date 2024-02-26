Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D78C5478C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 22:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C644110E815;
	Mon, 26 Feb 2024 22:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z24ow52+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7850710E815
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 22:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emiNOMH+81cdoUnbF94HIV6+80hHwH8/OF/q5+1HStWVXBFyR/DH24J/7ko9vBK3QBUs/IjIeY8mf8xP0qdiia52fj+CtTSDVSc1e/rS8gy44x7MQcWbPPHClAdDXI1wmouYRwW0a9yGDMOzRJsVWe4H/qB+JoeZ2slGIu+Y1sRRJEt8emb6Vo1Vly99t1epW6GC3IYZcjjedClAXtklX4kHYgG43oMx3sq1m3UjLUlHlxfzrM20L8ERy6twP911OIXeJFb0PGmShiDjAVQqschr4bbcADRQ058BYeESWXvUwDZCxSRUnS9WtMcljJe9Q0ygpmCf6ju2ydlVVMLzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIsG+6q/su3+codXYB6x1KJRZ/sRmJgeggAs4aUOA18=;
 b=FKMU4vawEJnwqOB5DNk5IoeiWSmLvNQyrLmLXj4HzZulQVQgXSdaqBhnpzCZIIf8w8bh2faQonNZxCOsjJ7qnEkBwk3vg20Qy/4SCq8Utz58+v/epqUPTmICCJqc77RMLPA6NzFNKNsk2253fKOqJY2DtDFfBnZFyWWN5hlugQDXcE0QdcgNOheiJb+7zvVa+80T++UygWDhMa5VkxrFFwyA/oyFeKW6n7/kTaeCGHtOv60z+W6Kshekn6a/sj2REzaRNUAf1PwUkZgcCJBVbp67BCfKENShV4Ru9UrPFiZ50gR7H4+lpY4gkXp4YV+wRQicpNC5bOuv1mHcminx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIsG+6q/su3+codXYB6x1KJRZ/sRmJgeggAs4aUOA18=;
 b=z24ow52+XQO3uN+MnrXc0Y0aKVcsW9ogFQx+fXijb9u2gZ5GE9KksWBzK948xrlgUnP27EQuvP4Ry4pPK8PTQFAkRFtmpi2NyqGSEUko0DFFM1zQ/Tm5Zab7DXgbHgrDFddkO4hadMx0rVGnWOjV61tRQXWiFgYGCISb1+oVll0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Mon, 26 Feb
 2024 22:56:36 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::5ad1:f5a4:5aeb:2a9b]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::5ad1:f5a4:5aeb:2a9b%3]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 22:56:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] Revert "drm/amd/pm: resolve reboot exception for si oland"
Thread-Topic: [PATCH] Revert "drm/amd/pm: resolve reboot exception for si
 oland"
Thread-Index: AQHaaQXO914ZLpEaB0WvR09iEKLm4rEdO/zg
Date: Mon, 26 Feb 2024 22:56:35 +0000
Message-ID: <PH7PR12MB59979B6D2BB3A82A22F09087825A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240226224703.1254537-1-alexander.deucher@amd.com>
In-Reply-To: <20240226224703.1254537-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=26c8b98a-6359-48eb-8edd-15d6038e704f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-26T22:56:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB7099:EE_
x-ms-office365-filtering-correlation-id: 717cb804-62ec-4b75-0838-08dc371e2f2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bW/B7tS4DwEyuRY0C3ckehdyZD5w6/F7ETEO3m6fmvW/WprsttxLLEipprOgtx0cezyXy3HqEJvQyHl7o6nhfZmbPr13cPm/0rmLp/AhWn5g7GJIf+I4J2UN7yciolxsvlaQGTY2CZ0SHSp480PQ9me405qYmJSxOyC41kfsnYP1sutyN0dVzeRCySMZa/oSMfcEHOD7w1NZpIFIgs0kfiY69LSx7DwA/CI2Y5awJRx0L+py4H781A9UmbKrZOGqlr2tDCLR+uF2yb0daxirnRdE9msHQ7CwdzcS+lB+xigw5JS6DEDnbqPRT6+xOOlgc+R/MhnbVI0nwa8NG2gpSyKc+bJqOHYK3jA7hycIWCtxXSzOXmpNip8f17oJuGeB/iohGzLoAz78XKpdiwhEEta448+Z9x2AXkYsCZcmCDnYrpbD/iHFbcBp3wTQTugGxjaFSJ88nxQso5MIje4TQWimipSen6s2KVxIwOUoKdzv+rqS8Rccm0TLpsbNjewbSMPd5sj4iIzcf39QZqPqdYnKVB1VsyPwMQyBWwxpqNMK4LlQ458TfPKWEr1vVZYKTiK+TN0sekE4RMt9A+DX8CV+rOQBhLmVeN67AxcosoSpJBooC0mYZoJc/p63h+UmoOQB8SP7PER9848MRthoLtj/CH6tR94ubPQsrj5QIVwvXsKvpfnVnKgyRt6oPslM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wKCzb1vOhvx6u1uzjqEhIcsO2S+AdWDHfyuQLcwVf+i0qXS1wIQ3k4+x5jtz?=
 =?us-ascii?Q?8e+MlN0/sXxKAzT1JVVgBpoR8xb4VnjwRfYWX6/Uv1jRpwGB94teX57nw5Nv?=
 =?us-ascii?Q?kD+XlPZGABc2KsMBDZwDFBuEwkwBLjA4KvmuFDi+Rx1bE6YSiThhOdAKKYFO?=
 =?us-ascii?Q?UZ3jRugL0IVZtbhdKSEjLwg/bpCrSf/oQ4nEsPLGnvKKhIXFaEZHzW4KaBAU?=
 =?us-ascii?Q?k59VwmrtwaFD/cOMmNHFpBZiLKPd9MusReDblH8vaRTlc4df3wmGYwyQrhhV?=
 =?us-ascii?Q?vTg50PNydZjv8sUp3C+wBwiEC8fe2ywSJDWXKadxm7iSXpFLnm4hIuVjM6aq?=
 =?us-ascii?Q?uawof1kob/zaRlu6iko4U+5BBzGB/+hlsJKr7gHlvsu6aPBnvsZSqWSv+xA9?=
 =?us-ascii?Q?zoMa4iTDvQl8MEQf59mrBNkM/3JLd3nIqmeZ1vomD7suZYv85kkKiqvCck94?=
 =?us-ascii?Q?OoknUX8/RBzZ5/HdVox70DktPagJl8Gfs3d2DbJLyZJjzrce3YNU+Puz+HZl?=
 =?us-ascii?Q?G+5JEtsO7EZmdN/owN7yf0A2ybSXYHgjwIVvpIBi6a37IHM4+aWF/+OrefGD?=
 =?us-ascii?Q?jXAi+IzaH/1MGnE9M9z4am6XJHcoIrziEKLJnI+ybz29WYdrhj3NCmvkK67I?=
 =?us-ascii?Q?Q1Xd/hpEF7c8TyfRfkh/D8W8a7zePr1H5SwjdZZ7n3uMdDgcLbz2K91z8zXH?=
 =?us-ascii?Q?DgwO15wkSjgyzjLI6PziFBFrhnCd/C7n5T8GKbW+g3v5njUDavyUeX8MIpL0?=
 =?us-ascii?Q?XodfsfWMf9T809krqDkn9TiLwQMZ9x64ILjYYc0zbSxjVLpSQO5LB3SPeTST?=
 =?us-ascii?Q?wijWonJJg7V7gHXiWw/L6SRJjDkbIJvLqlPern7KnGIM9rCZrQfz00tthy/I?=
 =?us-ascii?Q?yngkzSorhQKNJQ0r+dn8ofUkFIewjksYH7TlaEHuplqJunGL833n0zXmSnSR?=
 =?us-ascii?Q?B9YYrqlEP51f6F7nu4uL6uzGm7RQG/4DAWby8eR6mbJXEqePf6+EfO3YJhk2?=
 =?us-ascii?Q?wwWTJopd2vSLolBtTVX+XLYTdtPQUyQwPPofEfKgtQWUNevhAUgx2pnpIVyS?=
 =?us-ascii?Q?PC99+h4G4kKmJSc/wSpB0WucTQ7nJspZ9AsRpAj6DJRNUjgaGq7LvzHeOwMV?=
 =?us-ascii?Q?6Asf78EQyk2riy7rl0/b+LPbo5yS82Kbgmg1Ilqx7j3rQLpc+a47zZLrH03O?=
 =?us-ascii?Q?RyigXQ9diUKZEoILYJLBswouMkBCS862vro7S70cGPEZq/vG92gDMYNQ3Ndw?=
 =?us-ascii?Q?unAgYhm4cjvIjfL5dfKK9d3SU4oFAClQ1RaGg9OAW09yW3Eb/h42toVypIQA?=
 =?us-ascii?Q?bOfQMeKe9QI8SIQu7zqxdo/IENrYIfp/DEZ15Ske0tPigsT/gnDASiowra5N?=
 =?us-ascii?Q?kJJUnvN0KzcI6ggtMTGBHDEsooL6+V1OttmyaKYFtDzAZntG1k+zlfx8L2au?=
 =?us-ascii?Q?hKwINQphGz61yc0u+gocIHOoTYmKpXwK+2+f82gfZm9cXKLsxNlTlWjBiE/N?=
 =?us-ascii?Q?ESp7YDWXitGRNWBDS9cpWpMSthiKXYPQqL/Y9MtJfJpkwzb5wGsUsau0Ro4Y?=
 =?us-ascii?Q?mtg65mdzZmTESjJLu+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717cb804-62ec-4b75-0838-08dc371e2f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 22:56:35.9104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CkmPcjGDx5JnxPXExYH5DJ342jCxJrqLY4E5wm1Ty2zz+H2l5lICt6qp2AmNH5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, February 27, 2024 6:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] Revert "drm/amd/pm: resolve reboot exception for si oland"

This reverts commit e490d60a2f76bff636c68ce4fe34c1b6c34bbd86.

This causes hangs on SI when DC is enabled and errors on driver reboot and =
power off cycles.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3216
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2755
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/a=
md/pm/legacy-dpm/si_dpm.c
index e145d53a794ba..a586e0b7c47d1 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6927,6 +6927,23 @@ static int si_dpm_enable(struct amdgpu_device *adev)
        return 0;
 }

+static int si_set_temperature_range(struct amdgpu_device *adev) {
+       int ret;
+
+       ret =3D si_thermal_enable_alert(adev, false);
+       if (ret)
+               return ret;
+       ret =3D si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN,=
 R600_TEMP_RANGE_MAX);
+       if (ret)
+               return ret;
+       ret =3D si_thermal_enable_alert(adev, true);
+       if (ret)
+               return ret;
+
+       return ret;
+}
+
 static void si_dpm_disable(struct amdgpu_device *adev)  {
        struct rv7xx_power_info *pi =3D rv770_get_pi(adev); @@ -7610,6 +762=
7,18 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,

 static int si_dpm_late_init(void *handle)  {
+       int ret;
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+
+       if (!adev->pm.dpm_enabled)
+               return 0;
+
+       ret =3D si_set_temperature_range(adev);
+       if (ret)
+               return ret;
+#if 0 //TODO ?
+       si_dpm_powergate_uvd(adev, true);
+#endif
        return 0;
 }

--
2.43.2

