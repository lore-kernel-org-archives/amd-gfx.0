Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0FCCF58E5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 08:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F47210E7C6;
	Fri, 20 Sep 2024 08:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JvBXl0LA";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5B410E7C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 08:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr0h5apRWsO5AX6BBNHB3kislthv3zj7tyfMIUZfIUU9acbPeBmsFuZBsTKY/AfFlCOprvUMT3Gw4Tekcv3TFGosTNYSG57KjMGUacSjdHsGj9FW39FDn+3FiYve5J88PUgCuvmeGRSZvgQwepJT5L7HtuQTyEG7PeT6qZi7sCWRp8hLZeuEXy73kRPHaN7BQyEtV+WmW1I3jDLsUZu35+rdYYNjLFyX7t26xln9HXEexcU/mQXGgnsug5ZpyuVbP8nR7UJsYaKru7fiRt8u4wUy3XUfBsyiqzrK70veKsPLvWJ1AJ//640kasDeXvCBuDoogeGkHX6VIDD15ca3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY9u/ZxPHqTl6/X3P5B3HmF0fLHf+gcNAvKNTQ5msN8=;
 b=wKhEaBZYsrU3JFMPP1LfV3awiJAvE7lOaJdyWbcMQQIt8oVOKR3+pPrQOJlSnbl8ntHa3f60XB9uVNVws2T9ntztEeXUW+7qg8p3ax6nYeSIhcJmDu5p6fGHb6iC+a5cwQdlVbhduoXa7O5DKLEq4BzkDs62jjlZ0+b1GV1i1jlS8UXorTIcT2nD6FW+pw7THZbXhylCFc1ciYT0VVUJzkrQh1VcarEcXSawO2V69fbCcUtO6KRbYOL/UKjZWXaT0LvJ0lWqFW2dmBPHu96AlRmwDkzJDfwNeQ2dmFI+cg/ClBM8hPj8MuB9dGDRw9xwVWh5X7Ab0fVMD1Eb3xau0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY9u/ZxPHqTl6/X3P5B3HmF0fLHf+gcNAvKNTQ5msN8=;
 b=JvBXl0LALrorS9YmYBUF8GbG8AO5deF3gXIMCJmfHBlbBehGWHmTYg0m2GCQyYyjuuu99tnSMfi8t34htIz0TTA2as7I7w0nWQRb7zmeju33asodvXQ2QkjlvLvyCRKxtEnP+aM4xh0Q1UQTABVLtdKmX0IXcxMUZxHRvejhN/w=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 08:01:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 08:01:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] amd/amdgpu: Reduce unnecessary repetitive GPU resets
Thread-Topic: [PATCH] amd/amdgpu: Reduce unnecessary repetitive GPU resets
Thread-Index: AQHbCy/TKpColpqC8kKwaVIwfbh6QLJgTxpg
Date: Fri, 20 Sep 2024 08:01:04 +0000
Message-ID: <BN9PR12MB5257BE1F3E3DA1D8181AB143FC6C2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240920073607.109275-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240920073607.109275-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=51d70558-d24b-4757-8967-3a65763171d1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-20T07:57:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8504:EE_
x-ms-office365-filtering-correlation-id: 727f1313-3b30-4139-49d8-08dcd94a606e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8tgRwXw8V4qQCbhoxIOgyb26r2wyvbkyyGnBXFEegkTRS9ci2vtNc7JOQGVI?=
 =?us-ascii?Q?n9fe04QYjOcmkwxZ+PP5wdk3njKsEz20/9DMOdhJJNPeGkxQdp3ic2WJ5J25?=
 =?us-ascii?Q?PuFb1IaPS4aiAA3ahxBSVOw+oiPtqxxLicuosJ7c5n69VGiRJC/EZJEM0MFP?=
 =?us-ascii?Q?RqLHk8YT3qymIZL5XDANyNahaLXe8mS8Ryr3EMn9uXly0uSUeO4SgNyBUYfT?=
 =?us-ascii?Q?sXIL3n9LIIwbCvjfI4JKzL/6h0EJ2FQ18xaKJJEnuCTlSr3BxjhHC8AiKrFJ?=
 =?us-ascii?Q?XMuBQZoqBfZRtauiKOFI6bJzZuVymm8T8O5RbuBilqLbjuRirfHyflAjw2kj?=
 =?us-ascii?Q?YMAXagultbaBWJ2NRBS1wslA6K6k2XOqyyeEHYk6dyU1V333M7OfMDKr8ghX?=
 =?us-ascii?Q?71ckfiB//8RKycCQdy5Tc5AibXkur2lahVpcCg6LX5gtMRkyCUXYqppNwtvZ?=
 =?us-ascii?Q?sVSzeLP50D5qbg7aBA92FWGLfxfeqgkLO7qHZD2xLPpOp/KzZMRbmtSOgrgq?=
 =?us-ascii?Q?OqYK1/+9rl6/wB5oDID3W8qmH179CJXhy8Fe7oolQUk4vx7Y/6jDjAvEemrO?=
 =?us-ascii?Q?hMH9sn/belRGM+AD8OZYnfC/iIclKor8F8JJAjP4d78pe89+2bmaUGt1oXYQ?=
 =?us-ascii?Q?crH8mI3EWIm6UiA2WiTdLXutScnqDwzCnIffJuJV4e/mm+OUnu1eDsA0Z+i9?=
 =?us-ascii?Q?Gbg6P6JasJr3/4CPyvaZ7CeKI7DBlFdP13UZS9NI+FNxKzJwjL1CT44A+D6l?=
 =?us-ascii?Q?q3uAwKukErPzPQAbRCorGOELo/0liuiKNchqacoeyS7tOi8zKnLGOrsWl/bE?=
 =?us-ascii?Q?T2PsEE9aGBcLkbL79rqfYrUCfQpMC0Zz9y3p9VYuNqlSmSe2GYAinhQXKfeo?=
 =?us-ascii?Q?rVy3+cLoreFMWKvEO5fDD6+vKmHZleaTyeYDXN+EGPloSyrcyFVlVMqllEwC?=
 =?us-ascii?Q?lig3gnJzVlXmYJOKMta1wF3zQ1880nzPhxkBt+n09jWvc2fUxWxlBTynUQZf?=
 =?us-ascii?Q?E34w9IN41QBhcfS7NLgx8o8Ak96wHULA3azUdssw0Wkj1I/v8mGNlou16yOi?=
 =?us-ascii?Q?tYRiSaGTDWZN7HYT4ZViSUEY7gEaTko0ip/0D3KG0fx496ZmRV9X7UcAzhGo?=
 =?us-ascii?Q?hNjVFn1ojId3NdoxfeMvZz2sfmOGJP+QpDl2DZ4YECFCb1rf7p9qqUNhgZZz?=
 =?us-ascii?Q?aTm9c8Eo4Q9FSgz9jrihABqk8pa1TBD04c8KylsbP33nyo9HS5g8dSp4Jlgw?=
 =?us-ascii?Q?a/XCMs6pwKxXdRgIJ3QmN9Fj8R5yaP6aB3pxTOpVAKU8AJs3BjSt8TKMCtSc?=
 =?us-ascii?Q?vQXLbOy4JwPu1emdXv1pVDjrMoJarzCe+j9r68e+L0qc3w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aV4SIjT7So49knUGU8aE5giwM3Cu97cbzVyyHLYeJ5uwpgPUwHJwuqkEIJX2?=
 =?us-ascii?Q?HNqqowaN4piGsL58gSr0RxBy7vNB7vRZGbeS+Nj7HK0b5SgZpamL/AdKYul+?=
 =?us-ascii?Q?OcVu1xW62LmADaKyG63vhZwk9X9cpUf+kzm7Jm59KLyJLHANjjuz3igPor5r?=
 =?us-ascii?Q?Ys0Y2evp/TWVokhwvDcdorJ5HDrmAODCA83lTbjCLiQVtnnhzP2bA4MumSjW?=
 =?us-ascii?Q?l9uJN8xsPz3sWJdZUeS0ClQkgSc720nc7isXOoFgpoQ+CbHnLBy+PavWvAIu?=
 =?us-ascii?Q?+bx9MMQNtY1OzKeHy8XlUAtdaIfLFa7et/m0GQy3PiGswHrzy8k1QxKfq9VN?=
 =?us-ascii?Q?4uKE7VmXQjQEH+gSoy4KPl2PwxYB0dB/nKa3JmvypAe21vjMwX2yZcjRt8yp?=
 =?us-ascii?Q?LIY/AbNdVFQYLmIZZajR2mLfBV+j+8dGCIYLY+h2V671xoWFumX733tYIVhK?=
 =?us-ascii?Q?cpGC6fV8Kc+CP7l5t62HfaN034wvTG/BLXaKwl+OZ6uDBvtV/BibCc9zhAUm?=
 =?us-ascii?Q?1XLxpIt5vCND+ghAIEedAg4E9eHw4qzUVUbQneQQXuZEY6jQEUsmNxk4C0+/?=
 =?us-ascii?Q?mRxaF8123IENXH0piP7QQzmMheQ2xiWCpQu0K5CmKbPaPftoKEF8zMzQLZ6g?=
 =?us-ascii?Q?8MiK13WyTRBdlOnEEmly0q2Ecn4eAvlb/9qj+Vm4MWUg6TB4jx13TVg/UL+G?=
 =?us-ascii?Q?Wkijb+vVKd1id5ybWON1mWL+9IuVtBOG3ZUrHfENejdNZq0/vuW4jGVehVST?=
 =?us-ascii?Q?dl30vP5nVO02Xa0dNkvWYdcETZuhYqTbkXg3dDAAHarYK0SOOk3ihe6tQrR5?=
 =?us-ascii?Q?P5OEZjE8hmdBhq06TVZvymDaj1d/QdVh7sRFKZJa61pgpGyPB19EymLm4U1D?=
 =?us-ascii?Q?w34AwRKK03HVFxZ/lXNf1u7dJk1QMC2EpKaQxc05aq4Nfp8drtMvdbMbmlCu?=
 =?us-ascii?Q?4uiW5mM7o5ttrjN4pJVWsBIMJV0S58XDmzX8cOtfY8dkkN+EXxmNLJ6qlY//?=
 =?us-ascii?Q?EMk+oO1furbQRjMKC3LpaFAeYJMeqygBaUS7IkHZKEV9Ql36ZMyFmDwcFXI5?=
 =?us-ascii?Q?cgGhp1oMrY4I2aNrmqmxf9yYe9i+nEPKrv5wv5ekBTfNuo7RkLQTttZ2hR9H?=
 =?us-ascii?Q?Bsn9CXSPGKunlQqo2LDRLwff9Anqk5TSgaiHPUE3C7knWq9m4VFsw9Y9flnn?=
 =?us-ascii?Q?q34H3kglOeNB/jhwfTjR6Zzp753BPQAyxSLwPfz0hsXDpc7QTyPg7JikQLUZ?=
 =?us-ascii?Q?UgtPWSuH6xbUCZInNntgRZSAeqjQbssqLaGiMK7qB9USeN+PoSSOxGcvJF3I?=
 =?us-ascii?Q?ahEGE8QQPwnFhQpu/SMq5UTZY/KverW+ZZHjZiR+IpITIjvrc31t8UtI25Zg?=
 =?us-ascii?Q?r/b+/j4n70JU3NLX+luBGeuPEy6jj//j65p/QnpCxovx7eIvWIHsiCKCpxL4?=
 =?us-ascii?Q?nE90v0mA/rEQ2iexbZWclpUa9l5QLuEPtecwSkP6WaPiGmJTF0yDX927Y5kW?=
 =?us-ascii?Q?vH6HtOWQ93Pfnoa9jnfXiOmAPyqIod0w3DDeocrOEY79GJ96i2DLBs6csukn?=
 =?us-ascii?Q?vTxYZ0VmJHN0V++QmW6m8j1yrRgevnvXj5olDbVy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727f1313-3b30-4139-49d8-08dcd94a606e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 08:01:04.8114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0whZIC991FTd70KhS7vJmsBED0LyfEjHkyeKm63U2PxeCwWBp6Qj3tETleRWde7Ma3gEFt65xuA7x0RryG86g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, September 20, 2024 15:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] amd/amdgpu: Reduce unnecessary repetitive GPU resets

In multiple GPUs case, after a GPU has started resetting all GPUs on hive, =
other GPUs do not need to trigger GPU reset again.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..7d48541b03d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4306,8 +4306,27 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
                ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
        }

-       if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0)
+       if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0) {
+               struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev=
);
+               int hive_ras_recovery =3D 0;
+
+               if (hive) {
+                       hive_ras_recovery =3D atomic_read(&hive->ras_recove=
ry);
+                       amdgpu_put_xgmi_hive(hive);
+               }
+               /* In the case of multiple GPUs, after a GPU has started
+                * resetting all GPUs on hive, other GPUs do not need to
+                * trigger GPU reset again.
+                */
+               if (!hive_ras_recovery)
+                       amdgpu_reset_domain_schedule(ras->adev->reset_domai=
n, &ras->recovery_work);
+               else
+                       atomic_set(&ras->in_recovery, 0);
+       } else {
+               flush_work(&ras->recovery_work);
                amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras-=
>recovery_work);
+       }
+
        return 0;
 }

--
2.34.1

