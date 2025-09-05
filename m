Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8C0CA1013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 12:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B803610E2DA;
	Fri,  5 Sep 2025 12:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TdOZ5BpL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C688310E2DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 12:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URt19PQle25umWAsZKt8n7BpDH6KK46WQtV/QvWtBLlpDtza8nD0vVqXWhNbKM+F84rBBXFIiFgrub4ClCYcvTwl3lcbS5oApbcsxwxsgjYcSwml3kNEJQov756sB0ObhYoFf9HW0nv9Z7zRJypjBgoSzv4vQOl/CYUPrNfmhXg+/guOpXiAgIu/c2VlzfRdceYUZBaPGw4mLr1fquFkbCnki6Z/pWVxh8TGy01EH43blNciI3L7CoGpIDW+YLqF3MsaObWv7l8lzL1+uwsyWaPE5Fucvh/358kCvdDtPvNz+CXEKqgIxfsWFNanypF3qvBJXg5yLavBMKbwPxURQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtbhDGvFRx/ak3kVwTjeMwwKXJ7AsVDPThfG2HOvyT4=;
 b=lOL6vQca5QKKsTk2xBKNI5HcDHD9nY50y8mj7lysPM6Zw/rOPmI5hQWIeEhlm5REyZpbdBCiAPbQTCF45yzXQ3lRcbOr1EAqPfWzeAyAJ2n9rQWusIiCCi4KW252Ril50U26fYFZQb3qqS5QJujOYpW5Epram2XUIdrYhZAAcE/w4w4W8uIBoX078M0Ou7a8x9VT6cEsG7jQfd5TkCgBkZ9msun6pLqcGNVEdJbzs59QTzCTyqmUIjsk0lXpDCAPeWK3A/UsRcKpSxWFTtMWo7DWtYw0IG8u7nPccTP7DNM4ITNAQ30RYfaLz3F56W0q6Pxo4JSrQzRj1NLrJiTpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtbhDGvFRx/ak3kVwTjeMwwKXJ7AsVDPThfG2HOvyT4=;
 b=TdOZ5BpLHx7vBQdOQGvUlXQhuXt61hLYsxwpxXXPiLdmCtBDPPw5TdxhEQQwpdk3swP958doFvYSCRv70B0wiM3I6Qfb0p1wDkVUX57IHMuEbYLUpzr3EgRM7EJw2R75jFQsCo+f3vicdQ6Mg2+485Bet7q74RCCJb48VpGsyjQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 12:30:04 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 12:30:04 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: John Olender <john.olender@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix NULL ptr deref in
 amdgpu_device_cache_switch_state()
Thread-Topic: [PATCH] drm/amdgpu: Fix NULL ptr deref in
 amdgpu_device_cache_switch_state()
Thread-Index: AQHcHk2nKg5AIJXPbkGA8VhFrfUGBbSEhOyA
Date: Fri, 5 Sep 2025 12:30:04 +0000
Message-ID: <PH7PR12MB59970F48ECB9A527A377D1088203A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250905101128.3058191-1-john.olender@gmail.com>
In-Reply-To: <20250905101128.3058191-1-john.olender@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-05T12:29:46.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB6966:EE_
x-ms-office365-filtering-correlation-id: 4383575c-4615-4064-8223-08ddec77f0d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?m8wTPr9I6zBR49PN/FznfYHK1MpsB0xRRf1Rafqmq6ncrT64PQYucCgOb6wR?=
 =?us-ascii?Q?uyW/EOfUHOqAMJluWDE2jH7rWpp603ymEdTYj6n64e4n3yhRS5zTAbTDTpSi?=
 =?us-ascii?Q?j2l/8h1R7wh4L4OO+qbb/r8DUHDu3LmBI+0CivB4V4leIQTYn/EQ0IegyLsF?=
 =?us-ascii?Q?td0uZspSBGG544aPZNfhB1q1cJw+SNDdigMj9nFTbbk4H0TwEYbOAKPIfkqY?=
 =?us-ascii?Q?tDbDO9AjSRz8Z8M48m4coi67J8mhfYp6T/pMsiUXlc0gWaY6aRN34JVt8er/?=
 =?us-ascii?Q?hO4i+1flU8iDGEWiuyNAyU9nNdmw5SnTfM5nz9xKv6rtpi7r1h8dY+KzOoPw?=
 =?us-ascii?Q?vHIw+MnxqLKax588n7PXIXcsT8exHXDDrjjO7bhiSK7F0QHpoxNcrkiu/2DZ?=
 =?us-ascii?Q?FJLdSyHq0Jd5lEbnUzoPYX/cleAESihGHt+CtYdleSvAFWl1oEvCzDD+xJfc?=
 =?us-ascii?Q?ISHNlhXiGXNzTFVPyadVibaH2xbiqnbPrdmrjp1X3SK3Pl6PgaU4O8/+EBYB?=
 =?us-ascii?Q?Vntt77EaHwCxbwnyjWPxSTtogQ+GE4TcJlAFQXj9oEf1Y9tBMfa+kXVxBgV8?=
 =?us-ascii?Q?7fymD/stA0NYLg1FCJArM0rpkrk8Rjuz8Rx0AjB+S7ozzhjVmty73GBg3Xv5?=
 =?us-ascii?Q?dfE+iToYLeltY7Ne/g4xEWQScQAFA3doCgdFtlv4cQMCXFHn3tyw/Wl/dCpO?=
 =?us-ascii?Q?8lpYBJTZhkNv9tLAjqoLJVEfCK56suxVIAd7GQLv7nsjnECB9argWi/8sY3e?=
 =?us-ascii?Q?URPhhtU0ghdTJacstX1UOAM686ZvIwq7HqHYWLGgxpYvGO0aPdK3l9Q748Bj?=
 =?us-ascii?Q?hOGDsBt+fm5LtVsYv4/6TsY4cIZhG7CfX+//QTEGHVRNI75tuMYZM3W9FbTx?=
 =?us-ascii?Q?zgO7YkCURLBg26nOsw+Kvd8VfFmAgROCsPRw7YL32ZxdrkY/KNdlC9u5/6YF?=
 =?us-ascii?Q?ykqnaSIqZDQlvdaLw+ERSc/Z3sM0Rdez3Us0pThx6/cgtgOq+rLWFBbrYtot?=
 =?us-ascii?Q?au/1qEGpG9AYY9FefBHTkwL8AGDnKEF1O8k+706emb2B4zGyTiAHun8ttne5?=
 =?us-ascii?Q?lfopLYOxVAEOKfoDj2ykuLKjrez0eg91vRpe+VIczyDqqzuy9eVcpNQ9QNXW?=
 =?us-ascii?Q?+IdKh4LpjSSfEWsXuFBXSo5wOjRptTdFUQpKLs+O9yzp8cf9bXltfPRIRVV3?=
 =?us-ascii?Q?RYkRpRZ3nEhgmglGk/NTPyL46qXbhWbnxRmlvkQgBLaXpBlgiDSCpwSeIBG0?=
 =?us-ascii?Q?bKINbFUgyu6V6TcZ3P44510QTxZZzIXfRO2jTzn1t4OXXJ/nGLQDciWnBIWc?=
 =?us-ascii?Q?6tFYgyOVG9vSZgUmNIzEtKH+zxeOE8VDYbLDzxbGXexearpmWdE6QvmhFHPk?=
 =?us-ascii?Q?494Ql1YA+ejj+zjNJ39XbVJzkJDSL9h3R5bspuknCgvdt6vY9zCJIKNtVzhi?=
 =?us-ascii?Q?O3in5SFrYGx5LE6Do6uN1V1zvRbtSJ67EMI8FFD+bwlrv4ivywCbkyKxUHe8?=
 =?us-ascii?Q?XUv0gzJoOR8rQww=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CeTfabSLEYImuEpS+wJ1H/utCBMerkFFzHqBkMLKcXMhMxWGcHAh7lU7zGOj?=
 =?us-ascii?Q?vijMj0u8yfc3Irzqb2NZrtzugFDQdP+kGkX2vepz3XQcBnQkEqU+CGPyLcWS?=
 =?us-ascii?Q?JzWL8S9uCp/aPRegOZLUYb1mPwJcRJLvdOXB6oVs8+hnA/jl1cw+UMAexGJg?=
 =?us-ascii?Q?xOGhCt3x9Wq0gGpO+a241HtnHli1T3RFHwHRHBAxVFI6HO2QqWgFgvCHS+iM?=
 =?us-ascii?Q?wcs3Qyx2/e8spWDiMjOCQ8jB812/bcO1ALnJjN6Eh6M0tzN5PCD5QdvPv1Yj?=
 =?us-ascii?Q?OCdHz2jbaW2+R1q8a06r1wHkxPITtTzvGoTuEMCMFDpXTrflCZa/kJVmHsP8?=
 =?us-ascii?Q?uP0A3b5Tp7aYUwyD1S/6obzqC/HsiSBR71GWpgQlc8NBGXC2h6P2GXK4LECz?=
 =?us-ascii?Q?bVbSL0sXzfFXcmU9nepZeh4ON/jSTKYbTn7FdHprRLGynacBT+C9y9bBdFVr?=
 =?us-ascii?Q?AH3shU94YdFCSPlFT1t3/1LMttP3KtujgaG8PvdbhEP7IkvHcWHnNLapxRE/?=
 =?us-ascii?Q?5Hcd79lEeVYEzuPC94NJrLsgwXDAU8GGDdFDyG+dxz16eFCFYgQy8aWmyzLx?=
 =?us-ascii?Q?GlwImwQdiRdjap/Qyo6kYt9cuiQXgvgzXWCRwfGCG1L3tbTi1WEJZ39+p+RU?=
 =?us-ascii?Q?/+ZkhQ1B0G8958rbTBXvztncIuSdPaeaccg9iymsCHlmRglh4z0JPyxjvnqK?=
 =?us-ascii?Q?CaCPwsZMLOsDI+YeATziVladYjY9kjWtHDPKdtknIjYbXKNKuQwIg7TEui89?=
 =?us-ascii?Q?7a1DZ940iSaY1OPwpi1LmahEC+vIafANEucfv/tuQDC8r35TS5dz1F+c9Z2u?=
 =?us-ascii?Q?8TvFhrqCP3wIaClT1woDLBajud0vukaLax0UkYbwJO1kYDZuIvjO1upRfyFs?=
 =?us-ascii?Q?lKW//qn2YOxmVotLJn7T/T/eQLWNG+4AripEYDRCkmI00+9upg2AUhwtIVVm?=
 =?us-ascii?Q?nXBYwQBf+JAAR6xgfdUVzwPem5EwEQLuKPflsY0DfjlyYVfff2LDOOovOIGs?=
 =?us-ascii?Q?z+6Lf73bGIK/4jDJBW+J2HUZrqcau+sHiUlRDyLy4TOYAosVZt/CrTDiB+I1?=
 =?us-ascii?Q?MsNWn2zW0AwgtEjmOEqjvD9OzGpQFN6UMf7iKEC8vgsl3dUXYiFC1fzfa4hr?=
 =?us-ascii?Q?TLkrRGL+IbpxvFltr/xDIRnUwD1eJ/vb/UarIqINx0O8oQ1rUJOOBTROXCOf?=
 =?us-ascii?Q?OXga6Yp2ft0G+JBtwy3A0yQo3qNq5FI1xNJlxNXPTg/N64fip5w04QAQznH/?=
 =?us-ascii?Q?/8mloziXmWMnz385g1+642TWeX63nsVV1K4beeH0OksSKTCE6QWjjtDOXCBN?=
 =?us-ascii?Q?q3P0+mt7Go8rlZn2W56wGftD41kXOfRleb4FllO+QMdtX+45iCQikcovTi3w?=
 =?us-ascii?Q?2czrBHvBI1hfWENaetqJ8EVwMIQA4So8+tykqCouz7GdOzPQo5TIB4vYyaZ5?=
 =?us-ascii?Q?k76XjN7BJBNzBjG+In2SEaTCpjlMF+Tw4mYoBIQRAHQuSoSs3oGNsnbdRZqx?=
 =?us-ascii?Q?IYGCKYWW/pr1sLu7Rrmakc1BcNizYEASoDYdcTsjd5H5QGxvDWWnVG4qToDr?=
 =?us-ascii?Q?tYmExAKvPSj5HOu4t4E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4383575c-4615-4064-8223-08ddec77f0d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 12:30:04.2044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MXNdeAHI/JtIMJeKs/hCIzTxMaftdmnkz4YpjuTR1Co+199y7WXO7R8f4PP+LQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: John Olender <john.olender@gmail.com>
Sent: Friday, September 5, 2025 6:11 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd=
.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; John Olender <john.ole=
nder@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix NULL ptr deref in amdgpu_device_cache_swit=
ch_state()

Kaveri has no upstream bridge, therefore parent is NULL.

$ lspci -PP
...
00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] K=
averi [Radeon R7 Graphics] (rev d4)

For comparison, Raphael:

$ lspci -PP
...
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A] ...
00:08.1/0e:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AM=
D/ATI] Raphael (rev c5)

Fixes: e5e203e0cd53 ("drm/amdgpu: Save and restore switch state")
Link: https://lore.kernel.org/amd-gfx/38fe6513-f8a9-4669-8e86-89c54c465611@=
gmail.com/
Signed-off-by: John Olender <john.olender@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7783272a7930..ca58cde66446 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7148,7 +7148,7 @@ static void amdgpu_device_cache_switch_state(struct a=
mdgpu_device *adev)
        struct pci_dev *parent =3D pci_upstream_bridge(adev->pdev);
        int r;

-       if (parent->vendor !=3D PCI_VENDOR_ID_ATI)
+       if (!parent || parent->vendor !=3D PCI_VENDOR_ID_ATI)
                return;

        /* If already saved, return */

base-commit: 035edba1e204b302ae74269d4f09e355153a79ac
--
2.47.2

