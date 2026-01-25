Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8D0E63C85
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Jan 2026 06:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DA010E14F;
	Sun, 25 Jan 2026 06:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Op0tS4wG";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6505510E14F
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 06:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrI+1+NHUQZDBuDi975AhXaKBNjyocpiy1sFfZftMcL7fXC24y+kYd6C9uYcS3j6buVp2AoWNhcsNUdn29ltgEWwXWyzYFlR12rPYeqQUpML7xSe614asrshFehnLu7ZwD+pPdZEclFpkI4xS3HAbDEYmhkoUwZpSEz95s9tAi4k1RZzOp+AHLaF3qeMncwFFysUbGZ4tuZ7KBea+i0tde5S/rscZJaBuBJl2Ykx4BCYSUGbhrTubupNoAKncboauZBNAHPkPo8T7u2LZ8wmR+eepv0dXxinQ6Nkrlkx9Eh5pfXUq1svEgsiwDYdUjDmkJfDBylqUc6qBbIivG0KGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LvbsVqD8b3vLN9vWRbJOK0c2jgDI/Z9G0cDx9Q3WHQ=;
 b=yMDT6TsOZcpeqU9YXH/Z0kptlbBHkR3+F2iUydt8OusIPrKVj+anm/nKlMZ0d6wbQnuaeEo1C33sgKhI4AgwR9tlBU2FsE0i7jjVQzi8l3gHjU4rQQqvBpve852Ys7NWetRROCx/rgmlCtVni1rqtjg8rgfOgjTiJk/U7a+Med0vyMHMGupJ7pPVLVfWZloRCoeb73LS9S3jVuEKE8PZrdKKsW98L62KVsjQBoRt/phC7KhHGAslMv/MqNkxameqtgk0iuAccESe/80NJX1qdCxIUaEKjn9EEL7ZWjIr0izmIhEwgrnTK49hdmyI1fD5ig3cU7Zv+5QYBHei6YW2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LvbsVqD8b3vLN9vWRbJOK0c2jgDI/Z9G0cDx9Q3WHQ=;
 b=Op0tS4wG6XhHkPFsXcY/LAB5KIrAAn93IR9BTCjOe9mRnEo9LctrDO3P25F1dZkrFHLjK7MNY3wtX6Z/7vW79CRt6Cy0/uOE+N3SfzrN8g5S3t4Y5gwq9+7hM2w+9cknXSAyMtLQl9JB/LcfZ+2REAh0OSmSu7bcMdZG+NECM10=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Sun, 25 Jan
 2026 06:19:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 06:19:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amd/ras: statistic xgmi training error
 count
Thread-Topic: [PATCH Review 1/1] drm/amd/ras: statistic xgmi training error
 count
Thread-Index: AQHcjF/S8fi/w/lBdke8EAQiinJm77VibEBA
Date: Sun, 25 Jan 2026 06:19:23 +0000
Message-ID: <BN9PR12MB5257AC8B4675C70EA15FBA2CFC92A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260123115931.3857571-1-Stanley.Yang@amd.com>
In-Reply-To: <20260123115931.3857571-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-25T06:19:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4235:EE_
x-ms-office365-filtering-correlation-id: 032089ca-3232-41b0-2700-08de5bd9aeed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?W4k9khQ/Vs2wcIVVSAtMTzj0V/hML4vErjXIyVWGIgZyGsCWRaJkLyGfr5vr?=
 =?us-ascii?Q?YTmWZi4RepR0bEC40ryM0T+X9ODoxkPQL2oWyhPiW64A7p3nW3E45IV+enLA?=
 =?us-ascii?Q?9SE4r+g7OjfBGNRPI8z33ynhTBhpHf/rueSM/Ztv60tjgyQshd/Hjg+fgXP+?=
 =?us-ascii?Q?JgW1rp8km00dMbOExhAxMluoGQsR/KjVzKrbkUJh4l8ZswUBw6HgM9rao7p6?=
 =?us-ascii?Q?/izU54fBjtifQRBZYI3vOFJR5YxfeZvo4y9sNMR4h3f+bClpzy2+X52dMwzp?=
 =?us-ascii?Q?Xqw+NfGs846rNAYHxBLW+Fk1JrYoxn0a14rY25ofx56kJCd8R6qGW9Om+c2z?=
 =?us-ascii?Q?cNF8GbT4stGeqG4Chw2qNK6k6lPrnUlBFl7H9VPx+1xV8ZSdmaXrfveEeSVk?=
 =?us-ascii?Q?khNePaXIMvxeDNRbcPu2wQvz3tu97NYlpN+5MCZ/byyunhlTgZY+6wOycao+?=
 =?us-ascii?Q?MHxb+ppiLc4t0uUl5ldS4pDYRlKt9oCR5R5GvEJdgimnmsX5bmGCiqbo8Uiw?=
 =?us-ascii?Q?iC0xuZfn1yiMNuHSZ/LYp0p4Nobf5kUWk0B2g/jV+Vrq+uVDG5HZ2gK3bfhK?=
 =?us-ascii?Q?WDAicBLVxshnVkBR6Lmj1BDBw/0F22ipdSISnnX+3ZUrLEibv2pc/TGVfqqP?=
 =?us-ascii?Q?xtYQAoqktxG272wmmQqlQmhXp79gBRy5s8Q0fN57r04TNYPFQ9boTHHuIw/X?=
 =?us-ascii?Q?mX9jCivuplFDqWf5S3Akv7J761HDQzVjR1u1SgIvcIMr5jgCu8Fc1CPBalf+?=
 =?us-ascii?Q?FpyBiznrmH5z20WusSOHKwggJutth7EHhMUN1JbOEryIXg8laI58rNz55KgG?=
 =?us-ascii?Q?+byhxcAQ/VP8v1PSCbj/T1vqFJUV/kZ2fJ7v06XEC/VYvw+TvuFSnUYm7Ifj?=
 =?us-ascii?Q?FtGNuSIYTBBlw9/q5XBZYj34RiClzFfixDvELZpdTp42jqT8rfcFBhsCTc9G?=
 =?us-ascii?Q?v4U3T2lK5hJQy10uVTc6Q8JM3gUsJ0c+UvAcbMXzuUFwzrdCXdErZiwhIAEc?=
 =?us-ascii?Q?CrXS4+14YBtgnBbdjJ0lxXnBPbNkVEm1NVOEZ6uDLsqGd9icHxHGpJd8mxZc?=
 =?us-ascii?Q?UJbsnUz65kykNkdvnW/v8UxV9XzoYflEFEK+9hsZGAJ1HfLW0uCvRyS1AyQ1?=
 =?us-ascii?Q?DWWOXZYA/PthClGUOp/6ydli1uGxdCoUef2/Z+oO9ggnYIGb12l5yXKY7jZh?=
 =?us-ascii?Q?XbQVtrhw17yrgLVqxf5bF7FXqka+zxnkDHumqxSDat79qqjSDYRII8s6skZr?=
 =?us-ascii?Q?fBQDtgYf0b/imUFpm6J1HOkJoW92mpZ+ROcQf5nuLNo3XH8t6QDYTAGgsCB3?=
 =?us-ascii?Q?oljkITMoWNszeki8bPl6s/vHlFqLaarapXQ3dDTy2ym8GvVmyZjtIK6SkYH1?=
 =?us-ascii?Q?B3NGPGU3jgVM+BqJ1eeRXZM5u8VQW2xqMbcvCIzESJv2N0DUON2yMRY1Qjne?=
 =?us-ascii?Q?wHVm00ehPWfL1qTYfjLOLyvga7PWwEYMAVlmofIVoBkhH4HSL9m31W17xK5D?=
 =?us-ascii?Q?BaFYfJo2px6bKCEL6Rc678r6XK7AUQ4OSpjF76UlMhV2uOSUpSS3ieqvu6P8?=
 =?us-ascii?Q?JDjwrhN5zbs9ZV3J+elpsEUMYSuK6NH2cIm2fIbLG7tC7WTk10ckGKtQIv+X?=
 =?us-ascii?Q?9bC9vAY/XZKK/xeYLh/gVHI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7AJ/JLLgyLHfuVhUhQlZKnj9+JYiyJx15GbEwMBIUWnMEXmv/my5dlmssGPj?=
 =?us-ascii?Q?pEjwM+8bKf7H8p1sSze4BnmYQrECPqGpwUlxhxkSyEC2uOiyYXV3IsVcaq7S?=
 =?us-ascii?Q?ZpRE8wgAeu0ZtTh96iWfyFoG/HVdGcHfywYNQbW93Cqtl351LxtJ3c72u0bh?=
 =?us-ascii?Q?wKwdXuhTW9qhdoPUHCOc4luauRw90qziJ1Qfju+JDimmpLUpoIZF7udpRAxu?=
 =?us-ascii?Q?wfSZLGmPHFPVX4k84Ez+5efRVTDZjV3EuZLNn6vYrhJbzYpEDDfwuTW+/Sq/?=
 =?us-ascii?Q?WYDZrZTmf8N5fluPauaNpbIk5TyyiGKiPeI52hN+YMGUDyZyb/a8VJxOBV+U?=
 =?us-ascii?Q?adOaPfON2BBW8JIfme+ne4EcbxwJtNFAS1Q7tRfGfflhGQjvOFEMNZOVXLQV?=
 =?us-ascii?Q?zJJgpVkc3fy11hN4swZQJXV7yL+C2qka3rgbv/s2Z7jTkkcV1y1zbNtg3YMb?=
 =?us-ascii?Q?cCcMh79IGCfwCZCQ3Q1jBtfiEScxJPFAUEvHeGiDAFj/UihDv9YPuNiJ1g2N?=
 =?us-ascii?Q?jioWLfKB/GueOIG9dqXjv91R4atUKKHiG4GYz4D8f311BoQKR++VfexYQ+gE?=
 =?us-ascii?Q?cvV4/VfbGmuXaxXOLtvIRw/YijovemJByVk22SHPKEuoL3A+yL357rgMnHhz?=
 =?us-ascii?Q?1EcbG1KkIA0O5spXPeP7ZeC3Leha/xOIEZmZtIB8XUxkG95PHcSY1+ocQg8w?=
 =?us-ascii?Q?ri8q0pYV1urohsLZ1YIjfm50No02+BM+oaG6cZ6Iw4x9fCT+ftzA+9V9Ux7e?=
 =?us-ascii?Q?DH0Xd8+bsJY/4O8v5SzLo5yw+6b/E5QsFpMLDzG4YQfIJWTtotG37D2FDH5i?=
 =?us-ascii?Q?f0gIDaLtegWkjLdwmZiz+LkvcRNT3H2golN0D05XTHMdorpRCUuTk0OX95RO?=
 =?us-ascii?Q?+y2t/MMK0RWTIVlZ/4FibKsHnkdSpH9IZv8eY3TBJijnUBfj9lGDV5idwbt2?=
 =?us-ascii?Q?+Nhp5GezrnQu7SYEcCSQ4qOjldt6ifHZFu3Zp9WFPni/+TdRshN4xpZfkSbe?=
 =?us-ascii?Q?4MusIcSGDOcZdtCSWxMzdJ3ZY7aIecm/0X6R8v559zJoNK6mvPF/0Cqy34JF?=
 =?us-ascii?Q?BmpK0XfkfHjqKfQLXdltGao5fdNMaI8r6vbGWhk9JVXlB6aIhbQRVcBpVua/?=
 =?us-ascii?Q?Bg5sK1RZ7ts/l9ixVFmHQTRMwReMayn2Cm1WdfdvqRvJtUKi8+wJvPuJfoeV?=
 =?us-ascii?Q?fiXnnNlVWBBc+fgzQutRh9lRSHNyyrqZKxdvWhVxhfjtmA4tlHGldtt89OK2?=
 =?us-ascii?Q?FERNl4Qwjg5t1Grmj8W/I/l5ZIAWqUavsGbrts0jY62p6BOVNz9RieMVzLUR?=
 =?us-ascii?Q?eDVPyyDT6AaoNulMKKeEWSY7w1GQypPTcUGVDiIC/KgbmnHsx/iM7xMbPM72?=
 =?us-ascii?Q?DOjQwtbnYJTkrFFq9XgZh7BgiyX/pV8/XmS9gX74S34o+yIwCPrrDFbS2a4e?=
 =?us-ascii?Q?8i7W1F0v12zokTzPoaqEDSk1gcgPuwOwXFCaBct0OJ9qKrrb3Bnrg+KbHFBP?=
 =?us-ascii?Q?wf0bfjkaYYRQ3bmaP0m4xp3Ref5QqplzTjoZq6pHGSV8w/fxCy4/Q+pxcoLE?=
 =?us-ascii?Q?xkxVxduN2TIV0ZvLU7iBGB3ht/bCowlpJ3SwLf9MsSmFRoLoH4wdUR4qbPrZ?=
 =?us-ascii?Q?T2HT3DDrbEEPb3UzcrI4dUqrluLENXBQ9fK+KwhWMcCL08yYSy/aMRBEVWEd?=
 =?us-ascii?Q?ARiEWgM1KOl/rUV2pKk499bqCntI3sf3OGzL2xEqcus0gXqB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032089ca-3232-41b0-2700-08de5bd9aeed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2026 06:19:23.3643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJ/DPQDIIOi4i3NDNcIieDvRYdgeTzJ+PrsRe+c9nOlNZEHbtWRkFzi4zibxytcLgT5s7tV6Uwuu54vGkBsCUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Friday, January 23, 2026 20:00
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amd/ras: statistic xgmi training error coun=
t

Report xgmi training error uncorrectable error count.

Change-Id: I7f2edf00ed37b5a4f13115ab2f0f914f07fc8519
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/d=
rm/amd/ras/rascore/ras_aca_v1_0.c
index 29df98948703..210fbd8851a6 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -299,7 +299,7 @@ static int aca_parse_xgmi_bank(struct ras_core_context =
*ras_core,

        count =3D ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
        if (bank->ecc_type =3D=3D RAS_ERR_TYPE__UE) {
-               if (ext_error_code !=3D 0 && ext_error_code !=3D 9)
+               if (ext_error_code !=3D 0 && ext_error_code !=3D 1 && ext_e=
rror_code !=3D 9)
                        count =3D 0ULL;
                ecc->ue_count =3D count;
        } else if (bank->ecc_type =3D=3D RAS_ERR_TYPE__CE) {
--
2.25.1

