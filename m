Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49264C369B8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 08:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E904910E687;
	Tue, 15 Apr 2025 08:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YiiPr+5T";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A551D10E687
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 08:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaMrIPUII3d67dNwkVtdc3U2SQFdHQWZbrtyWheGETE3diymYU4KNDSw1Sxhaxz0xB9zU0qhU55KwtCjeGL9Ym9cVL5MO65gL8qcz71BoGVCGs54+L9n6l+hW5O5nQH7OhVqlh5HJP3tadV7JCZeAyuYBvmDbzotekyOxPXnCISKpRLdnYOWkFwgFq0EqNqRTyahopYj8vJo8zn289HSrU4byFWYRYeiy8eypG04wkI2zqL8v2jwOgOXYjK+81+EcoXoeoBeJ8Z0si66VWhGzy1a7Q/eNW4YdY45hGdiVh0CmI74iJxMJqaDPv6ja9YniPh6qljnMAvMobF5tkhbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlhw+I/mfvt7dG4NxlOGGC6q9frViSplZ+ltFYBTX6g=;
 b=MMvYDMDYiXVbBmZktehCxvQLp/bl3BeflwO5L0Efce8wTfIkjkxd6qBO2Gd7wS3cKCd1C2dvRLMaGL1nBwucXezqgeJkjuacwh8DOBvC9svYe9QGQYOOwhyzh8mWywi7I4/j27XPaFXvZVIl493R90oH+7qu1+OK44zcBkMeCSPziOPhaqJeFpObDwEuXHT6Rp7ykaOxIMUQ39aZ7+UvJ/uKkkgLDX1jbyx7/WhT+P6h8xWhX3UNfe/m776e68ChPYB6LzC2YBkaYdjZWKJGJ+agnwnlgCBTKWkulT/aH75jpYN7usuxQCOZlJ076j2BnP1Sh0MCSN+DyfiHZlx91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlhw+I/mfvt7dG4NxlOGGC6q9frViSplZ+ltFYBTX6g=;
 b=YiiPr+5T9keBKSy9rDTOB00+/CTeOd5pR4+6huj/tBal4Ec8GDljPDw9BlRiCXax42RxNweaGAuwNRNXoZ2fbOwb++BSY0nC/wDBvaHpC8zX9MQ4USErMm1nnWEIPWUc6S3sn7HKQn0RqddHWVYwBah8wSX+1BzgQ3R2GxD5cnI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 08:22:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 08:22:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: Enable host limit metrics support
Thread-Topic: [PATCH 2/2] drm/amd/pm: Enable host limit metrics support
Thread-Index: AQHbrblkiF+DYfBgs0almvSwMsradLOkY4NA
Date: Tue, 15 Apr 2025 08:22:35 +0000
Message-ID: <BN9PR12MB525772E649801DB98890FBC7FCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250415034907.106855-1-asad.kamal@amd.com>
 <20250415034907.106855-2-asad.kamal@amd.com>
In-Reply-To: <20250415034907.106855-2-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=729bc2e1-da91-4bb9-90de-ed4bf8409fb3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-15T08:22:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW3PR12MB4378:EE_
x-ms-office365-filtering-correlation-id: 9bde23af-5f7d-4605-cbaf-08dd7bf6ad56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QJwzaUCSQ0eLqzuWqxOc6ExJsdcOP32ZrSJp7qqXTtMDxQKXVWZE/sOSQb/W?=
 =?us-ascii?Q?9x5Lb969DOdja6TpBp1SUujlMO/mnR1v6N6vHV4Lf1sGzq226Gr6o5qRa96D?=
 =?us-ascii?Q?YpEGH7eSFWJHM9ABJUAygAmYbFuvwc3hdBgiQm1addmyw7SzVI80toB0nbVP?=
 =?us-ascii?Q?DOwVrNXtLLK6xqYvJosmvtzuL7xC4X/Bhr5L2wZYkbDxfK2lnn9/RJX7KVfm?=
 =?us-ascii?Q?tDeju4CdV+MccBMw51UjGHYznCpjFjRNd7M00ir5apNB5VDbgMDRbOK0+icS?=
 =?us-ascii?Q?gBvzns8qpK0XsQ7mYddmWM7xRUWB3igHgiGGRfJHif8KygKly530crvvgV9p?=
 =?us-ascii?Q?Fi7HJwtgxwqVG4NzYzMhUHwxN6gVVeISYUDumGPP9ZWyrFq5FGP+0WXDIEKC?=
 =?us-ascii?Q?pj3HACukQbt+T1PX19VWgHNypFZVh1ONsT7Znmz9j4ZYNfGChwb6FrUbSTAD?=
 =?us-ascii?Q?m21nHUUgkn2BPw4mPmvoL5IL4X6K+Tm3qlpn6I39EJkdy5tYhP7QMAxBVkvm?=
 =?us-ascii?Q?NhfeDFbPysD/lbrMaOyQ2bXhlOQWDg/gZOXJ+IvuAsOUPDipcMn5BhNXs4+K?=
 =?us-ascii?Q?Gb/gfUYBN3t9lhmvr68A8P6f8CBC7neo/1sCLNxUpbcy9EJU2UmvU7uTw5y2?=
 =?us-ascii?Q?CKhewDRQurRjy31GX2wKSZZV4eKptgOvziognJhCNzREK2KoyhZDcZ3U21lp?=
 =?us-ascii?Q?4EebGZEp3LdI8Iz7Ygydmd4hBei0U5jpudPeWWgIbb/7bMBnidWYIbz0sNNi?=
 =?us-ascii?Q?7GEEZjIc6syrathhmAv3oU6AStN7uaxAwykMbTOAGxuX+y+Q5mRO68YYhBpl?=
 =?us-ascii?Q?hGBg7p4/4Zec7QKxwKOWHPcG1hKy00/OqWXEgtlJD5y7MlpRD4mnKIwWMQfg?=
 =?us-ascii?Q?gUL8c9f8m/niI6wdsx+AvV1XSTBKqogkqI8Bktr/q43bg8pgEm+T+QqrbdfG?=
 =?us-ascii?Q?YxEguQRVmzwxeKGe4Q8vsQpgvHsrs9Urws+XRvJNSQsBKqllGyVnForORWm2?=
 =?us-ascii?Q?hDnOiVTEc58sYl83zaCNykJObMjD3VGd5zTcheGgw9jAhzh5/1XZhY7b2yfY?=
 =?us-ascii?Q?8UzQ5g6zNXKsKmBJTjLv9nPKOKKCfXU6rkxx10rdc1m1ZJcTZaLcWk5Gv0NT?=
 =?us-ascii?Q?Jj9fbr/Uh5AZ/cbtaaM3hRyC/dB2OW/Vgqb/i04WgLQ/k6xymKdhJJZ9P7s5?=
 =?us-ascii?Q?wwO1H7kJb/VXY+5p8tSPDnrO6NR9D6aWACECNA9DcCQbYW6zSCNwQNSCDWKG?=
 =?us-ascii?Q?+5iv8Dn0g/k3j5hkVtPBnctQLJteT7YHkVJXnLrLBSa9ixy+OaOp7eF4aXh9?=
 =?us-ascii?Q?ZmJLk6xtq9quAM5gA+0Gu/UPVDBH80Y4GiiUGBYJu24/gVZCX3yj681p1t9K?=
 =?us-ascii?Q?ohgrgWckoIExrnsaq7rqd1MTblubmCa6SJygPY2yv/c5odpJCDBJmmH9c9Xn?=
 =?us-ascii?Q?ea1GnrnsK2G9nd0tq0ugxBt7MlG3fSbRW7DPTST1QAB/EpoTDKzK2FrtnIvC?=
 =?us-ascii?Q?jfXTEZEpkWp6f8k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0GlIhHsBaUVozGZLxtO26r5W/3aQZ67fRoONibW0Pdi/rWl2hMzd66tpETqB?=
 =?us-ascii?Q?ni75ExYc6gePkW892Ylvoz0W7iglXIfpUQbEYcoyihGuX2UPorkz1waRhhLS?=
 =?us-ascii?Q?4HDADW2lqGjIRAQ86CA6vI54cXtjPOWETEnzvlYX/7VNbyKjL+kJ1Cc8aVag?=
 =?us-ascii?Q?NGq3FLSEKoU2r6vue/NamcxU5pq4DT/ZRA//QomCKCRQarfPcJEh4UkLUSwc?=
 =?us-ascii?Q?gLw++tTG3FrgzdKIqot3hjShup67AgILQRa95lS4Jvdkx6iWWnEUJwUB4tAB?=
 =?us-ascii?Q?YosvXQUxTg3UnpwBeMkfeMbsihOxGieX2bzZ/PoAQt4kbptdV5bkPROVoVh6?=
 =?us-ascii?Q?bmMlOt7n4x+S7gSJBbA5XKdoxk5UWJIcXbu4OOsmZ60MRA/e3TtIp26kkOuu?=
 =?us-ascii?Q?894YwiwjOp34WlTDREcJVQZOf+9yn6PrUN7LYjThMHBvIgwffVnrV5BzHIcS?=
 =?us-ascii?Q?NJOCE7zKkKmQDhOAzHqk8qQpDvE25+G7kO86RxyU1KuDsloi7HTlyMzyuJey?=
 =?us-ascii?Q?+hSAUO50V2A0QTGP7E0avDJjst7FFrF+b0/5rgON9uxqYFBWC9khEAlSflMv?=
 =?us-ascii?Q?PtOfeIo715bLe89Y3gbXwEEn8xcsFRSQE3eTM3+mQat9x/gHOdc5TQ2BbQtA?=
 =?us-ascii?Q?S0Z6T3hZyyQ6XzrDlV5v3kl04WjwCtvkPuv+f57f8LI01s48ob2KK58+zAho?=
 =?us-ascii?Q?Nmteul+3j0lC0BBJR93ZlMevQoGsZpw4InUGPzDonefhQSY/M42cVBH76xSQ?=
 =?us-ascii?Q?OYYMEFXlZCYaBJWtnIC6AeJZjf8JrG8afo3k1i2DTUHFzqsHexwc4qSz5Uv0?=
 =?us-ascii?Q?Xb/bgGa1uJ6iHpkJOYoGFAw7fwTS7GP+HudQzgwKPTjFk4+wwm7REI6xkmiv?=
 =?us-ascii?Q?YUkYu1OuL7gW2l9+OaEA+UN1g8+KHiVBi5MLhtfqeevgmT1Iq9UKANuYARbF?=
 =?us-ascii?Q?CiafTFrTY7OH8AN4QCRN7otNblluyzss6+Jj/eNAVHLFHsMvNcZSiEsd9mY7?=
 =?us-ascii?Q?wMbgZkzrfylKBixKNJ6BmlBgj5/NduDRWcB9FYFWYgiTy5Vintvm2cz78k69?=
 =?us-ascii?Q?c24l489iM7cQkwgw9hsVGvoHckXJZv8PglBGWcy1xqigrcZs+gzharGzk6vb?=
 =?us-ascii?Q?rQif4b49o7+AasQj0bTK/tNqPHZDg787JKt8MQXvV9ag/9mb7I7j5fknK6gK?=
 =?us-ascii?Q?fTasBQziRS1LeWEV0mUIiTPltxJN2otKetW9d1eLmNHXq6m0Bs+4prUFYG9m?=
 =?us-ascii?Q?SIEU8Ix5SJo652gLxFhMUEjHNXeTzUYHZHiQb35oLTFT1wHYLkUL72UXf0zs?=
 =?us-ascii?Q?o7Ddn+pCk/gg9GNRoSU1MUDte20Is55du10Y1Usvlz7UvC3UFGahBv9Zpw5k?=
 =?us-ascii?Q?Fy0LWemW1uOxdVSmb/cPzy3zJQcjutVF178hVKKyV9DLgWF1TQrPCoWfNQ2u?=
 =?us-ascii?Q?PWDNCYgI6fzKBowyUb9u5fMdsbgXhRB/RTUCXrWJCLXGnVL1tm4K9ezakV18?=
 =?us-ascii?Q?5N8YlVFEX91xAZZZKdQxV1/0369sPTCenOkcZo9OTkrj3OQkIsKWjuY5Qel3?=
 =?us-ascii?Q?3P2Xnc3BiWEgDgbaWjI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bde23af-5f7d-4605-cbaf-08dd7bf6ad56
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 08:22:35.6763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFve0rqVDBTELPFcYiwGN6Nrr8AcD8HAh0NYFbjdaWUoHVnCcPZ+7CUkk7X3XEjkaPd6PX9/SvJmJNs6RMFPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, April 15, 2025 11:49
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Enable host limit metrics support

Enable host limit metrics support for smuv_13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3f61c94ea2f8..6d84257b5301 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -337,6 +337,8 @@ static void smu_v13_0_12_init_caps(struct smu_context *=
smu)
        if (fw_ver >=3D 0x00561E00)
                smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));

+       if (fw_ver >=3D 0x00562500)
+               smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 }

 static void smu_v13_0_6_init_caps(struct smu_context *smu)
--
2.46.0

