Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38091E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 01:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF0C10E64D;
	Fri, 13 Dec 2024 01:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSd0loGV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F7410E64D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 01:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LelkVIPhJNuBsyx3/vw+tSK3ZxZ2cS3g3ec2bVbV/jItdW03QT4g4bzXUCno+MVuSvy8BfwvWW+e8j9ysCuZk3Bra1ClPOqmDlpKMrH3nOL/iboal1l9e6kbJknDkR3xkskguaRGUpkqcxGkamtLgAPRJQotdGG50+6RkzGcCdDje/uN8/N7UX8oAvWQZIXEueTGRinLR7V9bky2R+9WJAUqXSsxd5esXSIZTelRHwNCcL20zI2Oh7Kth+nc614ApGk3nbCEJfnnZj8S06OlIDhyTG1nhX7ytZLk0PwT5Y7OgxjqVZ+llF5CeQJr9v4V+/GPMhz6AIwNgbW5MmaK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOBWEJXHKwslYjTHyIn3AKZl0I2JuGtBXAtT9oiHpBk=;
 b=QbO5bvXsHVXu8AU4FmPvr2qtfbSJXxJ6Nu8QqHzX2QvWV9GLmbFS1BDsbMFycxCKeJ+uD393B3RcoqSrHRDkeA9LSROpOEoE14Fd6XJ0X2IEnQXwG6oInmYCbnBWQKx1kyx3FgWQtbnA2zT5syfgUce5Eu0xaeiUHBQg6jCZQkT2rfRPvwj7+MhoVkXGGAWF0PVxQtGJ+xOE9duXfMBairadMdBuQOaZdMUZ0jQ7AXoM9Ff5fhr4+TCLDM6nAAka1qxBzv90jbDx7JRWOCrSJzOifzF85Ra85OfKwOhjcMWv+Gg4fsA9GMiiDYjDoaDyCQdOZJu1Wn8LrSktapzSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOBWEJXHKwslYjTHyIn3AKZl0I2JuGtBXAtT9oiHpBk=;
 b=LSd0loGVgCKjj+VFnCDYqVfPgWb85HBLaDpBh8Y2EuomarN0pU5ch0cmf9JBEJmZjH54PsvEFvcfwBL5KfSA3qI8xgJIF5qSLNbqDlkhraqObgsCplpyOaOm1ye4iVC9WQvuwVdqOHQorACvmvMw8/MtDg8YA9bNICJEwj0k6Jg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 01:19:55 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 01:19:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu/nbio7.7: fix IP version check
Thread-Topic: [PATCH 1/6] drm/amdgpu/nbio7.7: fix IP version check
Thread-Index: AQHbTOKBEuhHsaC6aUKRzCKsOfSd5bLjYF1w
Date: Fri, 13 Dec 2024 01:19:55 +0000
Message-ID: <PH7PR12MB59973018F4900372FB57848982382@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241212220855.790502-1-alexander.deucher@amd.com>
In-Reply-To: <20241212220855.790502-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=287f6d8a-d569-42ce-8920-316bcf68cb9c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-13T01:19:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH0PR12MB7885:EE_
x-ms-office365-filtering-correlation-id: 19f413d7-66ae-4494-1179-08dd1b1440c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7iPgqEDOn8JnkP9Rt835bhZUb2HLmxYH8dKU+HSEYM6OE/NMQvdIs4so53s+?=
 =?us-ascii?Q?XAmAfrRayf70wMRtEyaiZegI78h+fy6DQuxZAI4UaK5ZDxT5w8oj5tWNZx8K?=
 =?us-ascii?Q?6qJRlNyqFF8H7XHm6Np/Qopg2KnpysIbAh+mmHWWOi0GXo4DAUvpAuE5B360?=
 =?us-ascii?Q?Tjyzzm2+IYqX4GS/g8E0wr9AajXNeYcf4fAmYqUJJvdtzo9k266/lx4kNVPK?=
 =?us-ascii?Q?PkNYHnB0pwFrvgodB9074naBmCOBFxvn8E261gdSsOjE+GbHgwSTQXFH/VI0?=
 =?us-ascii?Q?dLL7stjOZ9ZEYXPL2v85gUBRgZ6itUtQTdxTYC1XF7HjejOEizX5k0TcWBes?=
 =?us-ascii?Q?qc1mrn5JJlw5ncQU9BQMFwrbYQQl86nslCo2uRyKNfE9y1yuqn+ikywMTPFT?=
 =?us-ascii?Q?odrvzTWroHdB88sbsrboLZ2r9EtljlH54RO+kLQ5YDLErF2EgezVjjFvsaET?=
 =?us-ascii?Q?rKaSadBfO1HsoYxPh38+WkrpkgBavcptIgEP6kKiJsflS0lz5gkjCHIWADsX?=
 =?us-ascii?Q?k1EsCKBGLvIOcO274GIrIpUkywh7OFEQsXpVj1QGt/0IrKKUowcoM4o2sjyw?=
 =?us-ascii?Q?zjxUQohpueeQnlj87p9HyFTCqgO7mpfFGcdMG78fKV5+9vdgJ315hjBWQtC9?=
 =?us-ascii?Q?ZoXFOl9FX+r+Rt2LcjE1gtK42fyvv8whgQoAMg9gMKgCP5cAnI0XQWJCVxsx?=
 =?us-ascii?Q?DXUY4wbz8GBo0GuaaKvtjNQSGibz/yAhAYv5rgxekFmsPArRZISWNsQH3yfD?=
 =?us-ascii?Q?4/BqB3mua+BbYwQ0hZitWoBpP2ltgosuSqciHMSqm5I2aZhXrDqv0fL1cB51?=
 =?us-ascii?Q?q0om1ULpF6L/wJbOuUDE+5xXPiq/zMl7Wosy8bFusVEKcq3wHmKHLApijAti?=
 =?us-ascii?Q?4r2o7tHs81Co/AHRofx9ETBsWzEA++9Xig+bDt2e3g9g6YLpy/uC1pj69Kp0?=
 =?us-ascii?Q?YSs6XNxKSTj7d+Z8aBDMOUFZBHWvhip8/Mxq8R4ljMak3r0yUs8X7t7NDGYL?=
 =?us-ascii?Q?DcGHhY9/5VDifJHkUiRqKEesIm0jLdKkt5PIHFFmTxQdQSxKWdFn3wd8zH6w?=
 =?us-ascii?Q?oQQ7nfXYWeSoYddIOEmt9cdTduSC3RcVJztZEV8XBeTDM4/aE3AGOo1EjOXg?=
 =?us-ascii?Q?lqptvk+0kbOIMl63QPEQxTNpMotvlIs+DBOKuxEtdZX7ubBBoVhDya3MhjlI?=
 =?us-ascii?Q?KSAAnVUBhZ6PBBKd56+c5Om123nCE1i3Lfn+ll7wXsR2Nq5/0KxKpIMyZ42k?=
 =?us-ascii?Q?Pf0K5W+1rgtoPHSepdWsWHMOb9u/RQuf9SwmEiwEjd3buJnsyZuRCbmZdf09?=
 =?us-ascii?Q?hKPUdfYzy5DZgLsmg5CcircNj8qbeok8CsYzHJL4c/JrdbiovDcAj4TNN/7C?=
 =?us-ascii?Q?6wwmuIBKSen0tHKnCMObI36k1kAbIQTac7MQ+znNY/4egrrwwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kr8LPppwcedce4d5XrVg3rhF3pJ33YoCYHdnUj1Lldaav0LfxCHqMWi3UcOI?=
 =?us-ascii?Q?S3POZd3J6b1/h1W2jViXzZDQGgB0Odg2LA14O0rDTx2ie0DE+9neX64BRrSj?=
 =?us-ascii?Q?Qxhg8+t0N1p3q98ZyE0qZG7BrzENJcks/vW0BlHpIT0VMb5tADH5qDQaL6Xc?=
 =?us-ascii?Q?xDtdNRrH2uvm5bdhKthM7YBVv/dFSa8Uew4F7v48eP2fyHcJuwdEX2HQgnoU?=
 =?us-ascii?Q?20k7hMnGS4Bafzk/8tqSZSQWXFoGKfdzmGv+I7AWMrFvodVEqmz7tNwlbFqk?=
 =?us-ascii?Q?qjB7uVCQRbYIsg3TvmIhSrDNz1fTurNEoiDqbZK999C7MzEEBCfpq5j2nqkc?=
 =?us-ascii?Q?A4wL78PkJe8qh9iBFurhZJRh3yf/51SnK6v0w6eQ0sp89H925C6dTnU+dqvp?=
 =?us-ascii?Q?Fh7X9GXP3Fo+iPcHAhRI/XmNK/7z0X8SzGheimKO1Ji6Tmb8UC/oLYxbX7IH?=
 =?us-ascii?Q?hM27mfgiGZwbpZqygjAqdPKDKRt44ZgrIV/mOeqpBNmrChcAN+w3Oins0PHe?=
 =?us-ascii?Q?t0bbOvYOXEnh0sx8GiVVMQF+WiaiewFP4KM1Qnv66Dfbn39ZavNk7u+PJubn?=
 =?us-ascii?Q?/Dg6g+4V/bVIKHdI+4hq987xT1zral4dboQ9ebzKvhG0+d43cIbZrUU55C5F?=
 =?us-ascii?Q?XxS5IOy4HlJB31O3pwYvp6yoV7oJXX3I/MDE6vTQ740LNIfTq0lGfx6qCvJp?=
 =?us-ascii?Q?BHGndYvGg9w3Vt7nSJbsOLiy15eqDS63YnQvL+9Rcqj/IG05PrChseJ9hSd4?=
 =?us-ascii?Q?/ZnmdkhWcp/Q65xFHkQNBEy9VUjryt7reljfZxEsRuhUvUynuhfLjt1ICRB2?=
 =?us-ascii?Q?89O2RhRn3UgOZhTlcrYUgbfC0sXZpJzHlAue0Gs4JuInUhETModnECkfiwAx?=
 =?us-ascii?Q?iqyC0zcerZ+Kj/ojXWmv6ZKElAw4l8xt1CuXEcYH3db0K0KzD/k4vEjzOv9o?=
 =?us-ascii?Q?CTawRvev0ZCl4xo1MvZ2cTEM+xV9SFbIhnw5j656wdY2S8aBg/Ul1x7O09DO?=
 =?us-ascii?Q?efq4thAZiSjV0v6tI0nBb8EGkPXspLuuODwLcT0Qc3qqCL04EJz/hR0xMSxJ?=
 =?us-ascii?Q?5NeiNF6NicVT3J+2TSAvG5XFimqeHezoV6T5nO4sGky73ELYbAswpQS0NnTV?=
 =?us-ascii?Q?fNHcqcILdEOEUO1WaE73ePGYlOLaaLiG5SPIN1gq87mMNHWVYx0iAxS/pE6v?=
 =?us-ascii?Q?qm4QYoXYg5yogrE9Hbxp9O6l1E8aHe8o5z2vRinOcDc1vNXx+j8jMSEmk3Ct?=
 =?us-ascii?Q?UC5YFt1Jyz5ZN5q27Ri1OqtYo1mO6Kzy0/OXPihWNIVHS45btb3O00pEaIXs?=
 =?us-ascii?Q?I1TyfBFsP2E1WJVi6fV740dlAZDg860REpzuUqgVk00Gbp09gqoGjtYs+Ulm?=
 =?us-ascii?Q?zxisAnkAfMmMuLrsxkfL++U/OEJbnrW+ATCN28CiaEytZQK76PWWCCqdkEq4?=
 =?us-ascii?Q?xhq0hfQrqkYSCelj4lD1MwP6ie/QMN/AQBxvUsT4L9KIphFt3zU4pNf4EJ28?=
 =?us-ascii?Q?HBzxoqdQ7BpfVCFbx0jp1nHSuNYCSeb0fmmtDVfvO02U6wXzFWkYlJ+B3fKd?=
 =?us-ascii?Q?V54NmmzXvkVgawDO54c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f413d7-66ae-4494-1179-08dd1b1440c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 01:19:55.6079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KN/Pefgo5qrAZDGDdwVaLxehKlaNe6GiTJ+w9pw9jS9Vx0f1sKAd1jcSzIecJUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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

Series is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, December 13, 2024 06:09
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/nbio7.7: fix IP version check

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_7.c
index 1ac730328516f..3fb6d2aa7e3b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -247,7 +247,7 @@ static void nbio_v7_7_init_registers(struct amdgpu_devi=
ce *adev)
        if (def !=3D data)
                WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);

-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
        case IP_VERSION(7, 7, 0):
                data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) & ~=
BIT(23);
                WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
--
2.47.1

