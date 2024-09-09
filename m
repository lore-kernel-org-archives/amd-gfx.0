Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77055ECE579
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 12:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F42B10E506;
	Mon,  9 Sep 2024 12:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7La0g1j";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A0610E506
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 12:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHVDMS8W+yTBHnxf8TiSEdGGGnRY/9EdPGpYwKOAQaB+8ciiK3bWZpdshcerLMnqhbWVdvgJSc1XyM0g+UDMZ1nZ8sugvEiK3Gx16GPsoEpOCWVti6Y+CSKPwbq3LAq+OWaL6SRe2KPqjF2UTFJSlt8Ih1zo5QOffirZHwseX8M8x6AdVda7/E0pDKbXpe2/wSEYRFVyC9/oVC1nrXyvFe4PmXBK6h37t5ZyuCRP7VAz5UZkOY3whqAKZ2UceklNlM6KdhFJ+l23XPN4xJDpuUMnW2E/j/FZZvOe2AZT3gmpxzPZJUyGPJvnsGdjuDqMcUzJmEuG8jkjBmO3TMLQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7Hw8R037KJ3EIMT5fpDGwzykWZa/Q2tJ2EMB1LuCHA=;
 b=iNmQZzC1iwRm1LWSR2YhuQj6V1CdLlg4hqGd0EvuREZfOaIggIxz3FLvnUmarhGfO8uGB3uYxznWw8ZHZwKngXNR5Od3V8phML/jRxA0dbogvjhSTJjhA2XLpjPiVSrLQdP1nHPeA/nyu/Qg4bC45A/VS8139tgCWxeKERS4HQ8MT714dDQPgSOu6W6B//AohXlhzfZTlZPjdeJbIi+1wBrO5lwdScNcsbCvBSPzgVG/FTE5dc2Ig+gH8TupZh7Fdlz09BIKssRtosT0aHtNyLjCW7vDNO3AKX6X26MmVhLrRVDWYT3586Qg3XEwhwMLpD7RRefjVZG+0axvXWr7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7Hw8R037KJ3EIMT5fpDGwzykWZa/Q2tJ2EMB1LuCHA=;
 b=a7La0g1jtFGqwM2jPp/zRi6M4LG9uc2gAQleA32MvJZrtrclk1z2fTKJjc3GMp9KzTjPxtpfCYC+TGiVF0q4E2mvZ9UcZsX4OQKy6jSEugH24KqxxHLLSl2gl9hgi7/0ShH+Xvxj91LCOssAXoauJayGs1b0n/xSPdZM5b8DL+A=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 12:21:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 12:21:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable RAS bad page feature for specific APU
Thread-Topic: [PATCH] drm/amdgpu: disable RAS bad page feature for specific APU
Thread-Index: AQHbAqgxtrH9ZU5wWUGsTb7vw+y7JLJPXCBw
Date: Mon, 9 Sep 2024 12:21:53 +0000
Message-ID: <BN9PR12MB5257D7D20C08EE756F27D051FC992@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240909110508.19202-1-tao.zhou1@amd.com>
In-Reply-To: <20240909110508.19202-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4e291243-7132-44b3-a40e-7aceeae231ca;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-09T12:06:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB7782:EE_
x-ms-office365-filtering-correlation-id: 402b2c15-1296-4f47-628e-08dcd0c9fd1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?z92pf4D66OkqwLYsKtkf4ht273bKLKuWW8mYVW9CJaG3IeCqmXqLS787X5WT?=
 =?us-ascii?Q?JBWyeY3XIIUi/W3xFxs92cNUZYUo6nZ7G6idXuz1oAa4wmcEdLLnEn06mT1M?=
 =?us-ascii?Q?pdlDuGLkBpR/AIgXh7B7F49SwAUr5ouLZJlaDewYUfOBLzSJRJmEZvYJ1zUr?=
 =?us-ascii?Q?AGK2vuvqZcJ/K6wnQwrOZ9T/2mF6UP9zE7uJLrOFLdsvfF91xlCxqo5VKrc7?=
 =?us-ascii?Q?wWT6G+flLJVbP+oRYU5ZWC0Wvz81inB5yUJCVN1qvgQBprnogEgVrkUfzsV/?=
 =?us-ascii?Q?IeW1+jQv0m5ULzj2DpYV5xb9ngQYA+RQTQM+3GSW2mUiWl1Vsim3L8TWHT/C?=
 =?us-ascii?Q?fjbdkXzE971RBfemuz3dfLrzInNdEcehW33AHbmHPhnwDCm+qqi+4lx3foxn?=
 =?us-ascii?Q?pJXeWY7P6hmqndp2CjDmKuqR4EUBKneLZEm92wOJIZkm6yrSnO+9PiAFoFRr?=
 =?us-ascii?Q?ANwOibpA+rwGUMQnaI19qdpeS6PbjkXqlfqmI+fTvd+RULV1eiYVQqNUlv9O?=
 =?us-ascii?Q?KZaa+mPq5uo+MNEAcyHyqKKEB07KcXSE7bfR+6wZkWqTidXAdYUpuxjVWcLQ?=
 =?us-ascii?Q?zyniHwqCSyM6aI9F7kShHeoVBUYq26svZj2VCPlFcigcnzmd00GwOzMB7wb3?=
 =?us-ascii?Q?J6cwCngip/pZ16TInRQCDNHBHFYoglhnaEiAs6t+LvfA6K3N6zumPYoN8DLq?=
 =?us-ascii?Q?I7tri9J5Wdd5eAUajlXexcedW1gfK1S1BiXaqbsqNRDhm3mqYHs2BAPO8dZN?=
 =?us-ascii?Q?rbgVjB6UG0JlDvlmsm8j9wmWy371dhHgBnVCX4PeSUGzMQLnst9VH/rsjVyy?=
 =?us-ascii?Q?vquk522H7nSuR/wGM0se1xikR+zr6eFJlHIwq0gK5KdwqeEqG2knLEXci+tW?=
 =?us-ascii?Q?PARkrnkvvs4sSksn1dWOo7LWzwZoTXieNvWcCO/J3Gs6iozzalgRB3ofs67+?=
 =?us-ascii?Q?qicv2rU4sjbVDzhgzEXGrEshZ0T29yAtN1qrk/vdUMt26a4hRmexg13jnNaZ?=
 =?us-ascii?Q?kSmQcuxLqY07bk1Xp1aYQagCUO0OLa2ujo/KEutXOPNpghXkJYTjnrwdxJMf?=
 =?us-ascii?Q?e5nuPws3MG4BKNSXKDXNlQDagaHnQ3qyYBDxjWa//jQZ4s5JLjKzipB4K3AK?=
 =?us-ascii?Q?NGrU+SnZchPX39cQfkSXax78DkaD9vz5gPZYJnUCE6A4TmJadM4FrhD/nBp2?=
 =?us-ascii?Q?KSyDSTFY8IGm0hE0+sQMnL3WnF+eE/lVaczttDZVBxX5yPSxVwfQpLRBLDaP?=
 =?us-ascii?Q?VOHNn/nh1qDkXG71L7jy+PeJB4rSgw17g7xMuZS2++cDrmopOkHu2C05rMWY?=
 =?us-ascii?Q?YPP29qDlHvDKMwOkvc8AW7EP0y+FtawscUOkt4n/2aUFQKXCtd2oYmzokSIR?=
 =?us-ascii?Q?+wjvGjceHbVbbKePp7ansjVmXUbqzNkEXARoghCXz+FTkp5qMw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lAN8HP8kvBT4G0kYtgkCekJp/ZTTqG9anY6VjKVPMZ1221g+orvOSVeYZPYf?=
 =?us-ascii?Q?9q9Oqtn0xpIOhQDZV/kZ6jh9/tB0APvlpp4BglOCFtW22HG1QmDz9tEprTzy?=
 =?us-ascii?Q?LJBOg6zLuzeD78WFAFEd4b33zJ7vCI4+9nkFya80U/8vCoYGWkrqFH/d/iKx?=
 =?us-ascii?Q?4MhEOUin1opI9bIoxNx9kFGlfaEGfLpMnXgJhcGnboR+8hPFpRfo2eMiVf7m?=
 =?us-ascii?Q?fId+rGGtP8Bd/GeLOGLyQqaAKlK8Z8ZBNUY0vYmptC50XV7Q0VNuK5UICTqi?=
 =?us-ascii?Q?g8/+ZucoxlUiGkE654QuNAtug/64k09UBTcCR0SnBeWR1o/iC9K59MpCmk0f?=
 =?us-ascii?Q?RfL7y1OHojMcI1iOqqNa5r0UIo6Jyh/5PIahCcI1PewyC0l+ZziSYI5oBwaG?=
 =?us-ascii?Q?lz0kDq4k07GXhtbi1tD8TDliz3vjxoVo9k+QitMLmgAWjjh5t0pUj5x68ilp?=
 =?us-ascii?Q?+inyApZhTjkgC6lhpze7DxeslDh88dcBjIMo9QqyHGChPwPssT3G9f/b+lZr?=
 =?us-ascii?Q?CJLi2EEUpqMLbOB/QsDvIA9iiM4um8GRuUPO26ZtCQma0RZSxBg8GT7EE1+x?=
 =?us-ascii?Q?nVvLGSKnWFblJBz0baiL79CHDez0AZsy2iP24cMSUs3n1bQwR/B14RE5ZWxx?=
 =?us-ascii?Q?/TlkFuqTHuc/iZBrziHOR7Swiy718sJve6JlDOXoeu8l0GvRkfIN++Q1dyvH?=
 =?us-ascii?Q?LvLafAzdXie8L0R9nwy1wTLm8aniYMxSdRZhS29M2582QCxLg1erendMSQXe?=
 =?us-ascii?Q?qZAnFiQ7KY6dHDTs6PMCjqkNK1dCcPv/mWmypO0CXP2P31i8KocaUxwdDRLz?=
 =?us-ascii?Q?CT6XpcTrU+wijIQALLoB50y/JsYbWQCxFnunh0ImwiAP/wnVgytk4Y27ms/X?=
 =?us-ascii?Q?tb7p85gzBAX0EK/Dmuure/W6U/mfdyu1dhpoCcKH5YNWdWkfJfjhUTzdCcXU?=
 =?us-ascii?Q?vqu2CbPuMhpi5kXpbOyB/jzPUGoU947MrMfqMrg6fF8xFZN/cH9jRqNgF5LI?=
 =?us-ascii?Q?sUPu53xFNQJuVBRkTfM1sIcaDDB2OZpPBBZvpaUoF+96fquB1Mqk0ahS1G4s?=
 =?us-ascii?Q?eg2OdK4ptBXq0xNmsFez1b+rcY9hh/wps4swEOADvVLGSkiwT6RpdEemfzUg?=
 =?us-ascii?Q?go8yiSM6iDfyF7+6GAcqqDp/4RYHBNsdWDrJJDWL7SPEh6dPkzc8jEsjYGaR?=
 =?us-ascii?Q?Vayz18s2JT4fMwaR0dxryMmcQ+Ko7tcwmp15mk9NzLZ8sCCeCO6WAL4ZoZMB?=
 =?us-ascii?Q?H71jExox2sWWaFgUjyJ/SRqC98m7gL/yVugEiJ/epXtvUnXIt3mRJiY+TdaN?=
 =?us-ascii?Q?vPhLN0TllFUbx+aiB6jTmJn6x+6nT4bI8Nt3C/sXnXKgl6rr1hZ02npSa6tU?=
 =?us-ascii?Q?YDODcwgPYxbHfcBU31EzCmMHPqEt1mnZqCc50qWkeozXq0skBLXLYNyKdArT?=
 =?us-ascii?Q?v8FZi7injlR5Qc/uZqySprmxJg6024k8Gp3QhXsWalyMmiKyEi+0zfpVjMc0?=
 =?us-ascii?Q?YATvpir/A0h/r44YbY6VIbuSQwwE7na35poXKeDUDnWLG+Q5VxxNfgTOB7vJ?=
 =?us-ascii?Q?K3/X1q690eyoSf3MEh0iO9+N1kDnMNeSRdd/OdVj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402b2c15-1296-4f47-628e-08dcd0c9fd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 12:21:53.2959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0ovz8fZq9TURhjx+bgqfecJ7LyhXVWGJJ8C45Phdusg6lhusijmuy9F/zas22sytPnIZGMVcwsMCKROg+N/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

connected_to_gpu is legacy design - I understand UMC IP version is also use=
d so it works. Checking is_app_apu flag is good enough at this stage.

It would be better to move the code change to amdgpu_ras_fs_init.

In addition, it's more accurate to say that bad_pae_thread is not applicabl=
e to specific app platform, or something like that. Bad bad page feature is=
 supported on the APU, but just GPU driver is not involved.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, September 9, 2024 19:05
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: disable RAS bad page feature for specific APU

The feature is unsupported on specific APU.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..d46f216a33b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3679,6 +3679,12 @@ int amdgpu_ras_init(struct amdgpu_device *adev)

        amdgpu_ras_init_reserved_vram_size(adev);

+       /* bad page feature is unspported on specific APU */
+       if ((adev->gmc.xgmi.connected_to_cpu ||
+           adev->gmc.is_app_apu) &&
+           amdgpu_ip_version(adev, UMC_HWIP, 0) =3D=3D IP_VERSION(12, 0, 0=
))
+               amdgpu_bad_page_threshold =3D 0;
+
        if (amdgpu_ras_fs_init(adev)) {
                r =3D -EINVAL;
                goto release_con;
--
2.34.1

