Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB88C369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 09:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF04E10E0F8;
	Wed, 30 Apr 2025 09:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x0JsaFTn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B777410E0F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 09:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrgY45wLH1UaxOkNdDH/jdpoJYIjrcGotKfVNqwTsF2+2pMYZ66uS01SfQlb07g1sWYEulchb433QVUaVGp/J4cUzC/k0OMvaKTBWrnl7x6LT9bnQHASgJCNU1040+JSAQTTiGu5nzhyc8GXInwuxtGztJAgWLqocwYFoAZ6EapL0PZWjGtvfvIpjyTRFpPxj7Swu4C/00Y6v0dnuKHHOaRxubGYoEj8snu9gT7XYqfcIzyu0MJzmBMMIBwFfIDDnUI25hc8BfJjoz6irg/C0rOCp8+B6cd60sbyOeSswC98Wvi2ZXpwL/KJwMgR59FdBWVfaLZoCssk9D+AmryNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiMpGUAMW0wRy0AD6LRsGdDMgcTMSmz0H9dIdFcskPk=;
 b=YOnnrpyt4qJkU3Fsl2oj1XizZzJTb0wx2ywM7yT4g4m+UhEIUtOE5PxnGi6XwcCMzk2SSAlqg/NC33UDa4neroyUT+zDgCFCoMf494ycxENOvWtE0W8553VvDXlbDvSPWps5XC/hJBvseH4BlnQ3+Hhx6eCvQtUBTZltZhxgb04smOFqIuVBceS56of+ug1Buhkx9YVxiY0GzM8UMHomFlgGk3pilK8GXMv5XQOeGZgtUAyvA/X2FNCagQ73PyCMsPPd73nGhxzrq4XDJTMr6j7paN8cijmqokNzNSD1WP8tZD8+P6LM553Cdeg1bpAc75xhDjvQYdc7z6+NQY2AQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiMpGUAMW0wRy0AD6LRsGdDMgcTMSmz0H9dIdFcskPk=;
 b=x0JsaFTnQjHWDmgDLxt9B2TUd46xifxOZBVFYXYdSmtZZ/iMvJlllqFYnupgy7JLu2AnuyUmUANwUjHx7Hj+clt4Yb3vjwtSzqj4Nx0HuE94p00jazYSWeiX+MpFJ0OfABx7mkASb7VE992OYpmmOx5Uq+yH6j6btOTmJGDofZI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 09:12:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 09:12:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: handle old RAS eeprom data in non-nps1 mode
Thread-Topic: [PATCH] drm/amdgpu: handle old RAS eeprom data in non-nps1 mode
Thread-Index: AQHbuatUsGtztf/KeUCkfNTVma4HjLO77IBg
Date: Wed, 30 Apr 2025 09:12:21 +0000
Message-ID: <BN9PR12MB525748E2C1412C01EC6F5AF9FC832@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250430083834.60357-1-tao.zhou1@amd.com>
In-Reply-To: <20250430083834.60357-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6091843c-941c-4e4d-9b9c-de576e4ca09d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-30T09:11:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB5655:EE_
x-ms-office365-filtering-correlation-id: 2913a3a8-94f6-421d-fe2d-08dd87c71d36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZLYLCpl9c5QIDLOjfOLAincrwqJfJO1XXo0ckdRRJgtD8TlETCK8MprarPMS?=
 =?us-ascii?Q?cooZpU9khR5jEfkDece1twfbiOhStlvWEx3MsG/mZpkWFFSF9bhq8c1SHvBW?=
 =?us-ascii?Q?prC2TjPNf2pu6GAtDFs4rkJoeaJolnvHHxSOHfQKA1VqDq73PK3JxDYukk4F?=
 =?us-ascii?Q?WDaEyD17Tg6uZy6uG1BsrKmC8UIaapr6mUYnEnKNGrASn0OmwRPO5qHgDavS?=
 =?us-ascii?Q?J4stL6lgG3yNxogoMdLcpgVoIL9Vl+Ds+AaGYVVprG9DhkssgcmklK2DJUpX?=
 =?us-ascii?Q?/qyp48Vwzc9NmmCsOq1UX8Mw82LvU+dOwYgBlmpu2h6odEckjlCoYNOVc4V2?=
 =?us-ascii?Q?Plk3UWJ2PMstGXVsWOG5pPM9tfBCca4MsNCrx7A2tkofFGED15STyJtjDO9t?=
 =?us-ascii?Q?0F4Xkfv+eEpZ5yI8chqePTdjbZ89SE/RBh/JNayd5+gY1ml27hC7Epgh3/dF?=
 =?us-ascii?Q?fp/tOPiIreRE+g7P/3jvoyVbOWdxpg/T4hzeSQi+OgrA4lYM9aJ+H6cTPevs?=
 =?us-ascii?Q?UVpQiL65ZEei/GTlq/aafUoWxzEKQHdp+DsjZneMS0etuZ9ZXrEro0IceC4N?=
 =?us-ascii?Q?wIPj6n4KouJOJ6silgtTjItQnbKOHsE3PA4qaU28jex7Bg2fgs23W+tYStSN?=
 =?us-ascii?Q?J9fHas50coUrcUPfROv6bNfDqb+mLRXNJqoYJ9T948SYHY2D10RqTetYGaxf?=
 =?us-ascii?Q?3emvKkiDeAclj8z558D9jzm/0ZYvEDkuIQYKz5hO0gm2IxLIGZFIbZhXy58u?=
 =?us-ascii?Q?G+SMmarlDWLG+/9/Lym7rweOWEjeynPt3UVrapDVtpH03fuMcaZC53J/a+/T?=
 =?us-ascii?Q?FOJyHflS4ih+UTlAicLuMk6q8BAVLqaL0PAQ7buGyEligX3Y9pTTOO3OTUBl?=
 =?us-ascii?Q?0JmbV6R2kq9Pc6vh2bw2IqG6JuQdfI56FcBtRhxKLODkAZIdQ7g2ym6hVanh?=
 =?us-ascii?Q?Q1iy7k2negtvDJtSH4l+ZiktXiJY/dbR4s63eQU7PWDWIg2JxPzIexNaWe3G?=
 =?us-ascii?Q?Rsq/7VRQRh902HhZNmfFYBgZF8GA8f3aVGtq5uFFFOeObLkoeIEmK+rpDDgm?=
 =?us-ascii?Q?yFhxqD3ThUMulJfFauSfIn1EIh0UkoKIdeAG3nD3M/AThHuen7bSqdJ2SGZn?=
 =?us-ascii?Q?alFCJmir0zBdBgKwky5+BrqBltwT16WkxM+DfoyDZsg/8AQ3ceXiYElgBhw0?=
 =?us-ascii?Q?p9SRlzz8kqabgwGYiHXLzwGL+0vT4Qvgl2o0qlFhXK+fJokqTsgnknPzNPXU?=
 =?us-ascii?Q?B+WT7bUVs0bfrGsdQ8rNEkG0oqvO0ofJ3KVrydjfB/yH76NvF1Mo1xsQfX8p?=
 =?us-ascii?Q?oysnm8c0r3+ES2CJ8ils5DLJaDx8xKrJbOaGWhtGrRV0sbwht0CfsssFlOSP?=
 =?us-ascii?Q?eIG0yLmWEX8whZsPE4N4ooIMqKMBqrtnOiWL6jezsIy7usDN2NVPANUCevGn?=
 =?us-ascii?Q?Qe16QnIhxN87xY++5o7Lecrgmi4Sl/rBmZD1IUL1C1dvjKjVKFYTZ+6mV6Z1?=
 =?us-ascii?Q?rNGitu+Fuq7Kb9o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xDTnbE1H8GJgRbcBrs3YJqgbhImbiXeMJLANuaWF9C3T4GdRX5+1NRrQaQM+?=
 =?us-ascii?Q?/oYggiD93P9Q5b2JMEir+/jaEq+3bjGx0IpBjNUK1XPccxBu4JDHQ9Hd7Lyt?=
 =?us-ascii?Q?P4ZNOGeBoEzsCE3nyWoQ9DKDscdPCBBX6sn9REdtfGqCjRtv5+YvjOOV+mpQ?=
 =?us-ascii?Q?oqAaeJ+GiCMSPSO+ZSqyICvktkxhhvaHqviJwGmnCWWuXvAQP9FKglhCzOqY?=
 =?us-ascii?Q?a8qYGXIJYa4e9O0/Q9VEceU5q2oQtk5cm+hMZoPXDJF6zksCuCnErbA9su3P?=
 =?us-ascii?Q?QPb0MXjOUAr8giaxnzIMYsA2P7/G3bQ5tWgiQMA+9FiryJ+B2imLaw2iDFcJ?=
 =?us-ascii?Q?szQRnl/z1qXts4mEQ++8VrCQ7WyfYCp7q84SEMQkyEnN8w6mDSvkid/1Z2Ls?=
 =?us-ascii?Q?ZGsr5A3MruYJuvh8492qiJOImKqnFcMGwLJcYajSI9vOJGH81pcVLOmmIR34?=
 =?us-ascii?Q?Wwm876+HnUSWju4/JAE4nFJcL4W4y7eyr90b1P0Ru9+56RH6LTiNQKv0llvd?=
 =?us-ascii?Q?hCdFahJZdvnMXODKI/sjmDLOD3cznJYVZfSh/7+7z2USndvKN+r4eWZ6JSaw?=
 =?us-ascii?Q?3V+/Yl0ubwbaG0habEgWQ/pS7yA2HYK4TSHksS0NmDr9yK5ry6/Ez205XPXq?=
 =?us-ascii?Q?BmJJ4HO3K2Emn/rRXgI1yiksGYjQa9oN+SjiEIciNnXoHJtCZbkY+tLX8Nu+?=
 =?us-ascii?Q?Ggf0vzNF9buCf7/XrpLouSWcY2EdXw98PmiACKfp/s7qVQERwvDjPjZ2U3Yk?=
 =?us-ascii?Q?/kETIGkR3Xmjrm/RLRcSKwQ7FaVyuuquzoAW6YvJOLiD/VmFsW3Ke1l+G2E6?=
 =?us-ascii?Q?XGYILY49CDYIvmETTCZXHMSbjBsADCQzmEuaAbsbmL1LQP98wn8CwQig6no8?=
 =?us-ascii?Q?haHPmSEAlpoUGfkx2AMoAItkuj1WB66zyymDnIoxCFQO6DjbwPSgwbcTbzLi?=
 =?us-ascii?Q?nSjiJMe9dZcmihVYHAC7Yb2/b03HSufAlfZv1R8V3tKiCIqm+90/R5ennbVx?=
 =?us-ascii?Q?ltP5euYoFLeTi8WbdsCtZo0PgLOkNBrk6wb54oxrUl9rdYljpFe4VRMPuLyk?=
 =?us-ascii?Q?w1cPaORXYOMCixI2l+BzeNNwrKYwQ+vwTpU13v+LdKdF3c0kANLYQ/Ip5uek?=
 =?us-ascii?Q?T9wrRRUDSwC70tDV19kizyyY+tARMA17DgLInwmMK/88Psz1YZtlpEeacm6U?=
 =?us-ascii?Q?hJ7EzQlzaLmqWA4R7J1D1KktQcuCkvehdcb6SZIYRuTxC+PjPA6W3T/Ozn4Q?=
 =?us-ascii?Q?0JHSweT/grlQYCHo5HGJA4uQoLfjjF9V5xEbYhiHOQhP9/4Fmxt1Q6la5MJn?=
 =?us-ascii?Q?cgmhcyUh37+QO7IF7NyWpnhEhiTf5nSAOjmfMID5iwWQMZP08xCdF11BziQc?=
 =?us-ascii?Q?Qa9+r1LjKkjuUa8BB1WW069wAprR4+qnAbN0l2/8l+e1SDLUCKzsfMKZlHwR?=
 =?us-ascii?Q?NtxB5tRfUPm9bUQXMNFsWM54JhZ9UIgAg3YLWWSgn3u416VLInJB5AT4akmC?=
 =?us-ascii?Q?Ef/CWhFMCos/gcF2voveKtNJR7ZNLu2TYhi6yQFZHlm2Ur3fimXbva7qBp8U?=
 =?us-ascii?Q?dS50IKF7AAjvphRftlE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2913a3a8-94f6-421d-fe2d-08dd87c71d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 09:12:21.4491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUgrbpEkgsZAxMs+MjXqUJxYCCVh61VkPB5W4ny7dKtk1IZa8PHJ0evjczwDOe3gUG0RudauwObPEA9FDS1RyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, April 30, 2025 16:39
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: handle old RAS eeprom data in non-nps1 mode

Get MCA address from PA in nps1, then convert MCA address to PA in specific=
 nps mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++++++--  drivers/gpu=
/drm/amd/amdgpu/amdgpu_umc.c | 22 ++++++++++++++++++++++  drivers/gpu/drm/a=
md/amdgpu/amdgpu_umc.h |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a5a853894ab0..a9d2e7fb3e47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2889,8 +2889,20 @@ static int __amdgpu_ras_convert_rec_from_rom(struct =
amdgpu_device *adev,
                                bps->retired_page << AMDGPU_GPU_PAGE_SHIFT)=
)
                        return -EINVAL;
        } else {
-               if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
-                       return -EINVAL;
+               if (bps->address) {
+                       if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
+                               return -EINVAL;
+               } else {
+                       /* for specific old eeprom data, mca address is not=
 stored,
+                        * calc it from pa
+                        */
+                       if (amdgpu_umc_pa2mca(adev, bps->retired_page,
+                               &(bps->address), AMDGPU_NPS1_PARTITION_MODE=
))
+                               return -EINVAL;
+
+                       if (amdgpu_ras_mca2pa(adev, bps, err_data))
+                               return -EOPNOTSUPP;
+               }
        }
        return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
                                                                        ade=
v->umc.retire_unit);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 8adceeee298b..6337b6406006 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -565,3 +565,25 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,

        return 0;
 }
+
+int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
+               uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition np=
s) {
+       struct ta_ras_query_address_input addr_in;
+       struct ta_ras_query_address_output addr_out;
+       int ret;
+
+       /* nps: the pa belongs to */
+       addr_in.pa.pa =3D pa | ((uint64_t)nps << 58);
+       addr_in.addr_type =3D TA_RAS_PA_TO_MCA;
+       ret =3D psp_ras_query_address(&adev->psp, &addr_in, &addr_out);
+       if (ret) {
+               dev_warn(adev->dev, "Failed to query RAS MCA address for 0x=
%llx",
+pa);
+
+               return ret;
+       }
+
+       *mca =3D addr_out.ma.err_addr;
+
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
index 78a8b8654573..d6929d6f64f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -187,4 +187,6 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
                        uint64_t err_addr, uint32_t ch, uint32_t umc,
                        uint32_t node, uint32_t socket,
                        struct ta_ras_query_address_output *addr_out, bool =
dump_addr);
+int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
+               uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition np=
s);
 #endif
--
2.34.1

