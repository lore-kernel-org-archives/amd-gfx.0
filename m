Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA668C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 02:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E1BC10E852;
	Thu, 22 Feb 2024 02:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DeGfJHpi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894CD10E852
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 02:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+YhYp6N1gXDhXPa9wJHmEVDIUpGyH2tNk1r2xL74n5qxXwRxxbFfXptK2hDr0uLhTl4j6c+DTQaqMNOGMq7uxaitFkbofuQO2z8e5ZTNjR+Ej4KpQ4UZbKPKoK0JgzWDT9xp7xylipJyypzI6ujH9J3+Nq5atFisRLb4B948LP5DxZFnH3H/qhx+bsRhQm9M64fB5gWU0s6GhRckYNB0c5tJr5NpLD9RS3ChpYjsijDNqpHeX27N3E7sd0qWBIvKb8IXLBlPUA+0ELXsM0FbOfmm5889E8fgt4skGa9CTCAhJYJi0lwrFSEC9NkRvD48wZjSGonh82p3kHdjHTdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vpmp0uQfRZ5bO40BYdFJCxTrArX+ZhfExR7KebK9obA=;
 b=ACmru4RXcDln0RsgJJ/D0g1pD7SeIyEQ9+X8Pg8tVqCbAMNZIFtnlVU4KsXv5plPMAVihv5xVat0HkyrJcgmswI+WmjkLj00EsPnxqVSf75E7VYS9xe4eJEGtecYtElbl/BDrKb1QImcR4x0hcuY2Xlhv3/8uHOLRhgKBkErbnENlbjpDvFch4nKnQoRdK7zehHsKVpzCTPxGXcpjULYM+tkxzgiC9mzugoFzqCLG+VAkUZdtvRrCkAgmerZWCe2OaqyXVxXzdJq/DyC3P9NYlTq+I71/DM1SyC5OL+q9buuraXt9b3rmsZytUxFsG2nFjy6rdAKXAFS4fsS6MGnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vpmp0uQfRZ5bO40BYdFJCxTrArX+ZhfExR7KebK9obA=;
 b=DeGfJHpi96ORmhIVTXdpEQC1Lq0RnJ+5XmbstrNm5YLzfyVFERM4BEaerxGheXOPvm3BKJy1SPyDRTpmZcMqelYL4vqdBIIPJNQj/aFBzvRw5IaZXbfeFHJj/6AMoeiLKtaeguG4Iyree0x92FcTp67crAkps7OuGcHwTgKFzzA=
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 02:44:51 +0000
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::db7:1c6:2e31:a2de]) by SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::db7:1c6:2e31:a2de%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 02:44:51 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ineffective ras_mask settings
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix ineffective ras_mask settings
Thread-Index: AQHaZNIf9yQxgDOmeEW43naX1hmJ3bEVqHeQ
Date: Thu, 22 Feb 2024 02:44:51 +0000
Message-ID: <SJ2PR12MB88076946C5F111D6657F1CCAB0562@SJ2PR12MB8807.namprd12.prod.outlook.com>
References: <20240221142707.1989184-1-Stanley.Yang@amd.com>
In-Reply-To: <20240221142707.1989184-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b08884c2-adc3-443b-92a9-73fc08faf9fc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-22T02:44:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8807:EE_|IA1PR12MB6140:EE_
x-ms-office365-filtering-correlation-id: adb0ccce-ad54-4981-fd11-08dc33503e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4n3JVDqCSfzwF5ek+N5uq9WA/X77b3FvujQfSh1L348auXQEjBX8Np76mRo9wCEIVyVGtOjKx6UXegR5k2pXLGPZjvBGOZIZpJJ5zCaLPP8ihLcma0U/VVpxMSNsl5u85sMgPnigOMAkKx/ZRp2BNiLopIRssYXeBzoTFzP1Yi1zDVpR0qYDDF/o6Umh4VJHhJRuYvPfzkGIWPPGfdKstUy6s5lgeNiSsNXbpTbF5Nt//vpnidj+Vo5C7sOW5Jh0G1nmipL91lF+zs86LASm0YwbTnrftXDozAoFdLYp1oZ0/vxSH8z9LJRhmSdJ3BWrZiLsXAg9t9os8KmlmPDMRxOZ+mwalmI7uSRje9ipQI1K7uxvdekTwNqFM9Vdwg+Izb8IOPfXgoKJ7j6Zei/RIG/DsqOC95Yf9kvetn2f8BjUxIhlYE+MpQUcKAvsRQjgx7F0G+9fz5nAKFS8j+QEilbt3zvCf00+Q/9TN97otq+Iy/9UuHCG0YdyeK6/nh0yly8R4fygWT5KdtvbJuoRZNhjpzYiX+y8sWFv/EH9zHTLEKw5rDM8t9cwiLAzcVm5YHD4pnsJ+J+t6aeiUYAJcjLwTbRfwi4xgWzRKFRIRIFsnvVKe7a5xdrzoJxmLET
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I6jH6y++9voz2rxm/58owidyX/xcJCWif8trZaLiDldLL7SHuKqHDlCivkE7?=
 =?us-ascii?Q?jADOo9vBGik+xWwItSNNXEXf6fOMHwDAfF62MIS1UtW7w4qbSTDom5tA++cK?=
 =?us-ascii?Q?NQ/8L3H85ZvYrAqqODBfAedR0YTryCdMm4SnWhIhwgTfOc2VbfbAu7UeyWJE?=
 =?us-ascii?Q?nQRnsiHNTdvqCDVxpnwVuBtFOTFbNnEezbTqmXW6fXA+pf9vkzmmbhj4UXKJ?=
 =?us-ascii?Q?IDWCmRAtpaENc5R+fjg1q+7RR9dE6Ogk1MF1ygPAnimLOO8fTelPR/XkZwUz?=
 =?us-ascii?Q?owY/5sztebxpAbBAmV4f1Q+b0PyWc8Z+zr0cG0CdZ2vTGYBa2EFALyLAjsFP?=
 =?us-ascii?Q?Gstjw5sOG8cwAp/JNNXk8U6Cts+LZp1CsLCO1wEP+cw66qi/NrIRX8M07VAQ?=
 =?us-ascii?Q?6Dxa7eFGINtsFyTgN4td0iur1WZ3jh9eildlSK1yqVfSi7/S8IFIP0Nx1/1Y?=
 =?us-ascii?Q?0gCPpbyInuviz7Ioy7Q4a1EKaV6AABxl3PrzHYZ+gbymGh5IFq+86izH653s?=
 =?us-ascii?Q?kBkBUw7E2CvbWpmyzI0YxzfiBKPWCGHwTzF2k4BKodQG6+NhIv+0liYwgMpZ?=
 =?us-ascii?Q?lILf6Ei81NeIgEVUeCwQr7BQV4GYtDdTlMG7O+ExWz3Mu1cy5/1bd9xyI7ha?=
 =?us-ascii?Q?gqCAlye/m/TelriIBV3petemsKP6NFso4O4OS0Ma2YHCB3rX22lZG94ywArf?=
 =?us-ascii?Q?Hf5vQGkr4JDHppvgmoYV91JPRLxFvVzPWs+zPHJJ7JFGGRPTjsQJtWVh3qdv?=
 =?us-ascii?Q?miHvQB56bEfYEkFVx1VBcDkjv4sIudgo4d3Ox/gA5z0o9F9w+vUD6cqqXDue?=
 =?us-ascii?Q?lKhbNFMhVVaEte6xihEFgFHOCJv+n6v4s80PLfe0I8LuN8ZggeRCig1AMIoL?=
 =?us-ascii?Q?gpjLoO7bRb3ln+tCUUqAQe7yCzkAUKxgkL97ihb+CmsdbxkJ4SqjY6Bppylg?=
 =?us-ascii?Q?VeLQV6HiZodg3w7SZbK+Gy60nxMYn5r+dwpdfzY/CyG5IYcV1TXSK466Xg8w?=
 =?us-ascii?Q?URVjqGtOlkGqy9gJusqq84hRD0WLmcKIlCrGYXmfWaH6GlTIAirAdJI6vRaI?=
 =?us-ascii?Q?a7C70zKYv+Mhvvyw8TRiY2N5bDvPZpc/q/AzasNKAWJyk7mHy0Xki37AUGZ9?=
 =?us-ascii?Q?+u+gATMV8uAkig7GnHoUIQFV/K4dqYpjvsFLL5rMJTnFVyhiyI6drZdxxW2K?=
 =?us-ascii?Q?vfrlCrgtX0K7S88+gt9PK6Ig1LcqlS5JWn4cqsvejrbWjZp0HH/IeYL+11kK?=
 =?us-ascii?Q?QLtVdbHbiUIpIFvJUJt9KHVomu6pPfL+xm4KNtQUdhFynSuk9Nk5XKtOcrfW?=
 =?us-ascii?Q?9FW8CVGN9SIrX9dlCtYKC/LsNltF+tVtuydlnEpPpa/wKmQMLwCq121quf/+?=
 =?us-ascii?Q?yRzu0dveDNX0toGMvKXfKDCqd5IMp9nOb+bvfOo6bTcrjqLBe87BEuZKEQAn?=
 =?us-ascii?Q?1q0bkLIb8U7hViqdHX1UBRGl3WBGMWMgszhPnSYru5gEntj3E6HcbPCoMmff?=
 =?us-ascii?Q?X7fbMt6gO1kyNr1Mi+u9Ez+gbELr3FcjMZsa0Yh/gqgSp3OpNDqYv6kDGXvX?=
 =?us-ascii?Q?4NCT6TjPEdMELbt9O2g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb0ccce-ad54-4981-fd11-08dc33503e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 02:44:51.6442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uV0Fa3RuYOJvGkKDiWVVwI1fPdAPSaoNUKHJbEc8IIw4HhD0BPuN30SEF79JNp6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Wednesday, February 21, 2024 10:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Fix ineffective ras_mask settings
>
> Check amdgpu_ras_mask to fix ineffective ras_mask setting due to special =
asic
> without sram ecc enable but with poison supported.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d991b3467c47..b85014e7f96b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3629,6 +3629,7 @@ int amdgpu_ras_is_supported(struct amdgpu_device
> *adev,
>            block =3D=3D AMDGPU_RAS_BLOCK__SDMA ||
>            block =3D=3D AMDGPU_RAS_BLOCK__VCN ||
>            block =3D=3D AMDGPU_RAS_BLOCK__JPEG) &&
> +             (amdgpu_ras_mask & (1 << block)) &&
>           amdgpu_ras_is_poison_mode_supported(adev) &&
>           amdgpu_ras_get_ras_block(adev, block, 0))
>               ret =3D 1;
> --
> 2.25.1

