Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF87D6E2DE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 09:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D86710E3AC;
	Wed, 20 Nov 2024 09:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NGkI23bw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA69B10E3AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 09:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmeGdZhK+GflPvhWPpFHU8WdBJDa6z2mI4lj2ln9qKFOvFXQpqWco5a1P8X4JuPiP7gcmR+kn8vfqZpp9g7oDSGPgNVI5JQkJY/+aho/HkAPzLoOxHRXOhYf/bzK6oTJFcBVdiLPGVrVzCajQ+Ibr10KKy8bLPBaJkNVWRlCy+uitePS+rspPAXAtXhH2CAVHD4D3ATmJ+H5J9/efAS1+Hmh0/iOPcJKty3hN4HmZRXtuFZ175WslTdDvjBhJcPYlIAana1xzMRZy1QCKeHWzfN+SPaHEEiJ2HMUDiKp0cpSwi/Fxx4q2188h+4H8kBx/FtVCcwDqDkhqMBNSe5lzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+u5WUTY3mLUT03DpVqB0SqMd+5EeH9kFmliEGlA1Vk=;
 b=hM2RuMxEgZJVzPHrSj0sXMaA94oisY1QwinEWa8jV39YzxrEfXZRwrLcpl+nuF3cY2HVErhr3xWKbzhyNJHImMWjvg5Y0hfKpKQdf2PKgYt41dfhqEM5de5qYCB3GijtsPqaj0LPAh5z76rCIIoa5UcdHOwEH7aL1tpXJACCgbiRfZMEPG7cAX7ssFKKrM6P4EzGJ/LoDGsrnxNbNCIb0qrKg33QwiS61OOVkyZS/AfHHO0RFNGlZ43TLeEqaSJguZeb9t0MvTmjFA82fAgQwEItDqgM/0H9gJ/qj68O4Biq//PYaf1tK7Kf8YR4bwxvZieV+JhJ+jd3H6xoqIJqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+u5WUTY3mLUT03DpVqB0SqMd+5EeH9kFmliEGlA1Vk=;
 b=NGkI23bwqYIJyEvn5goRc1yalyApgC9G732Qmm01BbijL1BXGONgQmoFFn/0y5+k5LzmkgoUdR56B9sE51WA7uaQ5bQ4wq8kJlDTKMbdW8/6OMi1GVNGfyo5Zion+/+JCD/vJ4c3nGgiUhX9XsBUiGSWr85IGWBK7oEfKCU51J8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 09:08:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 09:08:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Remove arcturus min power limit
Thread-Topic: [PATCH] drm/amd/pm: Remove arcturus min power limit
Thread-Index: AQHbOvr5UckKhqmxoUiolBmB8v41Q7K/4XzA
Date: Wed, 20 Nov 2024 09:08:34 +0000
Message-ID: <BN9PR12MB52577AC36F796F9951952DF1FC212@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241120031407.3398856-1-lijo.lazar@amd.com>
In-Reply-To: <20241120031407.3398856-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d1440565-ecfa-4f21-9b36-e98c3f1a0123;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-20T09:08:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB8858:EE_
x-ms-office365-filtering-correlation-id: 3a7030dc-3526-40a2-7edc-08dd0942e993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eOECps14H1GlUWOb2EIfW6H+WHtTJ9m3+pR8+WPHVkNXWgyorShLYmWmAAWs?=
 =?us-ascii?Q?0Ak1Zo+uM0NYTbE3Ja08TgbzegJnmCI76V6QR5KstEpf/SSbfEk4UBtCW06B?=
 =?us-ascii?Q?bA+1eM+OGAOa7oKAxoBeIBcNAVydBm9uaePvtZsfGvgBVFdwwBk6Q6vw4hso?=
 =?us-ascii?Q?wBvtV900dpL2sh6Wc67MdTMmtcM76D7DEi0Nk/7USVuuuUybbble9bZ9p+xa?=
 =?us-ascii?Q?ecPS8Uz5rcVtAVWFAij0YRPEeQCIeCJuKL6AHSkbRhWHwrXM1AgfCK+dFd3Z?=
 =?us-ascii?Q?WI/LAvRTmp2mhGpwgU3V7z0dzhAbaGKaPhRd4HYw0TiH02+zkvoo4yxoS24/?=
 =?us-ascii?Q?x8XzXD5x9/D/K3APTR3agMjy+Nro62+UrE0BSQ1JkjO1HCoKH+zjVkPlg7cP?=
 =?us-ascii?Q?yw9dKfX5FJGG1KfWV7ZPlXAY/dUTO0DUd+W8nwFrVlRqDcmbT6VWxAybY30x?=
 =?us-ascii?Q?+RKGS5F3M8sN2hFC1GlgP2Uw04XMCLhlUmT8+Q1i2bRYAuvEucKv6RwDpAsw?=
 =?us-ascii?Q?YpDFSwBdLIleJrirZ3b0MugyMwL21GnjztHSaY4BLoK5S0OYqQf8Dh2+YQYa?=
 =?us-ascii?Q?QscSAqJ3AMzW5T1O0761CuNJVXCCQ3pMxFo/ugVQCMPP/mlVHTmHnKHEGXG5?=
 =?us-ascii?Q?VrVpgCBFQmpxhNP/SlxJmkt59lB0k5YQO0ai5cB38Eo8T0WAIT9uSaixzVy0?=
 =?us-ascii?Q?G+/MuaVlEoFJOzsrMoOcsZ88RyAQmjoNAKPVQvrh5IHI305T5DBEPfIPJYgN?=
 =?us-ascii?Q?XJBN7TCxK6CkKas3fbnfn9X43dc8V8awitEUlcgpx0+sGJ+WcbZR3AYEfHeA?=
 =?us-ascii?Q?te8MUhsLfEFfr3n61P4eLjO5hPV+K/WOhZxcCwF9gmYABbOw27HNUKK4dcxn?=
 =?us-ascii?Q?iyBof6dYdcOzhj5KSvBSKAiqWblVu7kbR7mRz0nQdTDdldlnrnIZbicwARPk?=
 =?us-ascii?Q?N/s6BcjUYQGHSdwVUe8m0wVLk//NGlHaomD7t2mF4m2FTwfdlHAsiczhALSG?=
 =?us-ascii?Q?NzPCS0pZ8IiWKUuzXrQCOD8zGrzFXnODM8PNWdpO+uJ/RnYC9b5u4lZ5pNHG?=
 =?us-ascii?Q?F2/f+FzWg6RbZT9xcAXbYo7GDIiM2Mnjmg92Cwrh4qBPV9of1ny1af3Oekqh?=
 =?us-ascii?Q?QZVLmCwezVwicPaFDPTALaKlmIX2qDloevyUfez3fTtRDmY7MviQieeA2RQZ?=
 =?us-ascii?Q?gMvb5nJvG6GujxMJ6i61zzQmjfYmcOriLHrjZbbqJK7bxmmDIxP6SdIqDawT?=
 =?us-ascii?Q?HrvxdIom7MegpG9avXl598JAJ/I4iAUZsp5nG0gfxbBmf0qvPGX5CscPwMaA?=
 =?us-ascii?Q?Cx/8LP8sfyB+PGuNmsBmwMQOY9J0UCfnP1lBIIqxPcNPsiL9NCEUn/977gyD?=
 =?us-ascii?Q?WzY/yCM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gs19Sb2POSojvwpR54u1Dy2sCcLsxEpYmcyBkh1x+4KwzTSW5wAsNUnFNqgZ?=
 =?us-ascii?Q?ojU5mp3fwfauQTpMUkoDmCtF/tqV0zxN8Caqp6neTKG802pUKG0LnGq/F130?=
 =?us-ascii?Q?I1oU0JYqt+oFGMz/GrelwZyp1HVwGh0xLvNdtcoOjPsKPQ9Nt4Akl2WfO5wn?=
 =?us-ascii?Q?BqGCjS1MB5kcmpUNtbaPDz2ccU0tQZQPBaqX1qK3sTI4e2AcpHYJdP1EggCQ?=
 =?us-ascii?Q?PSiIbW9xAk1BzIEPQu6btflUwtc9fTwrgkM+zqO+NJTpDDChy66DM3zEDPLL?=
 =?us-ascii?Q?DGfs4E1yijmHjUp+70Hk8zQXrbVctO9eF+bGRf4Vw0AR4Uq7oTDqUnjpzQFJ?=
 =?us-ascii?Q?tAPThyitSGy4aK58VLCl9Mh3QBpgeQP3T+sBU1Jx/ZVDWj63rh6vFPUaniCD?=
 =?us-ascii?Q?astN5bqauDC7Iy48ny51/ZT7Qs9iIjCjYzVufXewwR7I93GDjY1t2wVrWt26?=
 =?us-ascii?Q?8065SJsVSPoUkh+xcMBl9IsGXxmmzRujU5XUsQDl0vBc990k6xRwj+bqOaZs?=
 =?us-ascii?Q?YVSuGPUWCljAfUacRKprzeucWqB4DGhAHz2DI7Cj9Wi2D42VgGY0valUQKF8?=
 =?us-ascii?Q?Mf2oUKAwwmuLT8SqkHu2qEgX+T0tZa2agZHqz5d4tPAfXhNfdO5HkSFgqYm4?=
 =?us-ascii?Q?8GTeRtIQxAd6U3wy01LY9lgP6a0M1AyLuMPG1QOjVjBYMa/pt9iuOlW/73Oe?=
 =?us-ascii?Q?PTpR90dexLBaQbw++TLZlGktnN/36bj9lELWE8ml9LJrsGjnCgJXRznQrc+6?=
 =?us-ascii?Q?uvWJGOhCFwxzuolvSmfO22CobH75/m9Cm3IlaXUaXvMp3/x2IgIou6wzfI5o?=
 =?us-ascii?Q?+FVh6oznMbSH+BhsVJEgtIJJTebGX7PJggU3UpLyn/w2zkL7ip3CUamwApnM?=
 =?us-ascii?Q?a1jrvxwPXeNzqyX77cgRfJHcC0PHFA0ITm5YMU0x5xa80Gs9wkbIYXhi3eeh?=
 =?us-ascii?Q?7d9ghEqT6Zq9xbL/tLgza0S/buWtAgbSA6sIRaYhy3yQ3wrYyNFInj6Fqz7v?=
 =?us-ascii?Q?dxnfw+FKP7FBgN8b9vqtp6jO5At3IldQ0GyB70A9KvtsM87wvAsypdWqA8/l?=
 =?us-ascii?Q?pDpE/nQn4iK7qhCs3A4mePDTaXKmCmFSmV5OLBMqG3bHUqBzTKUhhyKSNmrq?=
 =?us-ascii?Q?ywByjt4WXEj6Yw6JZsaMjXA2CDMmypIC4PoF05lHRLLdO261dZtB4mJMB09K?=
 =?us-ascii?Q?lkFKrDjv9zZ5SeBQRqBz9a0V3zkAbpSxcgKeZvYBOYR/naawQSjwtMF2j0ur?=
 =?us-ascii?Q?YSuhFrj3jiX7hLWoZPp9+T4U13dctjEAFJadtDJZLkmP4ah9czBHJ2jsHYM6?=
 =?us-ascii?Q?DQFXI6sCe7jv7cU5Mc2lSIZcw/IT58azB1R4jxfOYrjzy1JLtTfcKAd72JAL?=
 =?us-ascii?Q?LgnGJP9FYYTahFnGPIxYuNMkElc+ifjXbrzTSEC+gmeNHYv7AU6Y9b5fbKfJ?=
 =?us-ascii?Q?EEToOo+qZwsIN4GNdAjHtEgnx4S3Mm859ugH1dCOh43oUnXNKVn+BaDtaJOm?=
 =?us-ascii?Q?J53WbMJmknHBWl6EfEvrbZ3CppRk0yQN5CTh13Q4e+9q7dE4ksDfQ4zY8+wj?=
 =?us-ascii?Q?QSi919Ek80Gxg3TirFOrjTEd8RZ6ussEKwuMIkvA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7030dc-3526-40a2-7edc-08dd0942e993
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 09:08:34.7349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwRGbLKUQtpB4cb0D7t/qkb4+yJ0tGvYzlCA0RHkt2DxwlXKYShadSOXZXxpPeqlfhNQL7WiiNXvDK28tS88sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 20, 2024 11:14
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: Remove arcturus min power limit

As per power team, there is no need to impose a lower bound on arcturus pow=
er limit. Any unreasonable limit set will result in frequent throttling.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..12125303bb79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1344,8 +1344,12 @@ static int arcturus_get_power_limit(struct smu_conte=
xt *smu,
                *default_power_limit =3D power_limit;
        if (max_power_limit)
                *max_power_limit =3D power_limit;
+       /**
+        * No lower bound is imposed on the limit. Any unreasonable limit s=
et
+        * will result in frequent throttling.
+        */
        if (min_power_limit)
-               *min_power_limit =3D power_limit;
+               *min_power_limit =3D 0;

        return 0;
 }
--
2.25.1

