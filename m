Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0BFC87FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 06:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED7710E5C9;
	Tue, 29 Jul 2025 06:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OtpIXmxE";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F0710E5C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 06:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgNGYmiSWgLAEulkpDfutJLln0IjThbv9TQ8xSCuBsDGfF9+tJcmOjVMS3+8EssmGgLr0WAViMajWLNNHwgvMVauAuUGoXzgnr1K8V4ZZ0GRb4PiJP/dXB9gDg8kwq18oMGEo/uY1k8phpHWGQpvMVn56OfT3KTKrAjeTLm2zPY5V/zqWh0oxU5gkRVFydRKPueRMw58Rnas74ohinNyFEgUKLnpeRXc8aG9xGe6pDhc6Ol318mZ1lP5XZJPuLpf5be3Y8l5K6gKDYvAzZYamXMZaa838At8xCQOv+BQo9a4zbUerhiIPOwWpBS89FjrVAtUsVmP0IZTMhVxxXtxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7dmBiFMAEJdSC/404pRODAPmI94lLzhUaNYQi7b9lY=;
 b=iKNq8ZaDVOufmCppD4yCPetmChOom8cgrm/WRph867Fba3Gfq7kH560vOLDEWIvgnKjdS9XtVsVIvMrpFiAJVa6ljgSAICaEzcridv4XFjb5UGcxkpakQP6l2w775eW5JRGcsKpJtIZ02NfuB4SWC6gKT8LteICOBg647Q/6tdITiMaL3IzL+9tLaHGS/P7+BqnW4VxCBdFa7P6OIsDx+L87VQ7FvgH2PKyUCmy8r57RoJdTszohfEP57heUSaPdYURTo9jk1jnpuq0hXynw96igkXepLq3Q5H2vxpwyeGlCg9hpyn86lS3bTSneRdqF2/q5gW1d1MStyi5NvG9KTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7dmBiFMAEJdSC/404pRODAPmI94lLzhUaNYQi7b9lY=;
 b=OtpIXmxEIpQ3pSD9/2iMd01XROGfxN6SErJ3pm4uSmvIFzk5r9UTyF7dcfgrYYey7Cky8/mLgIJdTSyAtc3/aQ8Z7ZqdEBMgUIj3HsrzE2w8cNWDbjIp+VkaxaT3I7yuVo+lQk+4oDmWBwHUbc4SE1xpUsTcJrXy5Mm00xN1cK8=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 06:03:15 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 06:03:14 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 2/2] drm/amdgpu: Add new error code for VCN/JPEG
 new chain
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: Add new error code for VCN/JPEG
 new chain
Thread-Index: AQHcADlurWaf5hYFGk2avuBQo+P5d7RImVAAgAAC+IA=
Date: Tue, 29 Jul 2025 06:03:14 +0000
Message-ID: <PH7PR12MB7988B0ED7C0C536D3405DB729A25A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20250729033205.826312-1-Stanley.Yang@amd.com>
 <20250729033205.826312-2-Stanley.Yang@amd.com>
 <PH7PR12MB5997CD799A393D24D404C80B8225A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997CD799A393D24D404C80B8225A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-29T05:49:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DM3PR12MB9351:EE_
x-ms-office365-filtering-correlation-id: ea216796-2122-4bbd-15d8-08ddce659b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TNJfO9lgYwxQ3JlaQj6L9vNxwMGb15r8EDIU6w6MbsBPVVpQR9LgFh/1xB04?=
 =?us-ascii?Q?+aO/wt1vkgMrykZlw/AprAuIcvVnftrjz/tcsZom0h7kRLeNlVeZA/oiy709?=
 =?us-ascii?Q?KkIEbEc0cRX1v+9aC7XTmrdCGsmk27Oa8isJv5w+AvXidufqf6nigVZwUGUl?=
 =?us-ascii?Q?WFCftvzNP7t5nEyIyszKWcthVt1eicQ2/5JwtQQM9y+WqqD9oYrA3A4j23qg?=
 =?us-ascii?Q?PhJ/qlwf7U63mbq+g8BTOeUh0PsX9UAkMLnRdte4kdmNSNRGgL0RfAVRxgd8?=
 =?us-ascii?Q?3g7jGNNX6sh46UBDj5eneWEklpWims684MdWgKCcQP+nR6MBuws2WUzRQjjP?=
 =?us-ascii?Q?BE/axROqYzFKgBCzcIKtEbvb7RFf3OklIyWUzGLy0V0Zil7TAnmluU9HEvb2?=
 =?us-ascii?Q?xvTnB4f6y7qGkxLm+ddLuQRyGSSTHEBZw7O3hgcw1NYlw+0QRcMt7c86dpo1?=
 =?us-ascii?Q?TzJhJ9se+nwAvwKg+Cp2ShyucLoE9RkLus9UKJzY2FcL7IaTcDypVDpn+/AS?=
 =?us-ascii?Q?GlI7Nl+bvSVc8X01DtHzDoFYKPfOIT0YcwHbwZ4OS47aJk5foPuntNsW3A7k?=
 =?us-ascii?Q?50Mh1DCOtHTXcMNhc+impcVFPxUg8xmu1KOR1mqd3hA6ZzUr0Guvmq49uBnu?=
 =?us-ascii?Q?J3FGOsdAp60TGZi0W+pnKYocsTfpK4M3iFeem6jSRmJNFm0gyoRdNYMLob/m?=
 =?us-ascii?Q?nKANGG/mKiQzXOLdJRewDtydA1MdvQ/ZwNZQIsehk0sJp/bWBqD/Fi/CqFFo?=
 =?us-ascii?Q?XTpPj8z9WxsLtQcFgv1fxWDmjZDESFtE0Xlfvo4bN5ldchwU9bdSdSr+AlP0?=
 =?us-ascii?Q?Qwj3VlZFLWp8gJUJzZ62CeoTQTY3vjCQuO/oMtenFOhUPieWj2+82IaQKNTI?=
 =?us-ascii?Q?O5Eep7Y57gaWm94VX4OD0vk4ZYx7pt2Qb++K8F2j3BGqicCbNYoQxuxFp+UW?=
 =?us-ascii?Q?9hWfY9cedvTMdTR/90xnZDsQSkqKNw98X5apC15f1gAspCqCn6x4fplcydUc?=
 =?us-ascii?Q?80R+1act08XZqnNSE8V2mSHkguAfUpJxtcxGJA9cCMOfC5LshPyO0bsZ5Yfm?=
 =?us-ascii?Q?PcDXOVQ3wa9/lhhpQMvAqPTrnkY+/dV4L8nSOO3LqYQLs7B0+MShbIC1xTIf?=
 =?us-ascii?Q?YSZ/aDyRkpJ+pneAo0dRHaom9NkOID8fKD1qoSouNq/PCifAw4dF02JjMprr?=
 =?us-ascii?Q?9mARaYig37PV3AHuRz5aAKotVnS/DjS4eFc0TJTOTt+WXBFEQyg3DXs6+4oL?=
 =?us-ascii?Q?i+rZKkhM7+D9F9s4Rsf4qNAHcLa7+rkk02z7aVn0atxu55QlonomZzwwxtwT?=
 =?us-ascii?Q?WRbgyZXMCQbqvYVTw2uAY3Eex6g0/VuSAwP7GcyBi+1EIpb7FQ32klD8/KQM?=
 =?us-ascii?Q?JvrH1RRjHD3yZJVS8644M3iclZx/9q3A8C25CmogbA4/8IXSuSEQCugPhF94?=
 =?us-ascii?Q?gbR67PmC9K21idLXcJo3i9e6VPljdQExWWLanuopkpNzazhFS0zx4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vDNPDEPtxlKTtwrK1SLZwQBQ5MObZeL3C9wScnqk/8DVjcECKY4BXmnlXa85?=
 =?us-ascii?Q?9/4GUA7rQBt+a8ZfhBTHaR7n7BRR/STB2jzLEzKFClI3FfxnZfT2DcvKyxIH?=
 =?us-ascii?Q?8BtVANQKI/sRgYxNhCCLhF+DyOGoEI6E8nhNCjReY5PpkYVnCC6itv+9S9NI?=
 =?us-ascii?Q?y2nNBHPKdIELLeS3ixeqoQy5xq8o5lsSSsUoha6NBmpTEMwFp9OMmkF1GaYQ?=
 =?us-ascii?Q?UnhQd7xahe2UxBTVRRuuoDsBl76NvST6DFQRfBGoAuW8MDccd5PXDdN7swm0?=
 =?us-ascii?Q?+kJBAbdC9g6ALgniO9CBEViLbK5GoSuodfKRsfpp3oeZJboYpAu5IhVQtOLA?=
 =?us-ascii?Q?lEuygUxdeb6C1dwwIgAYvJBSCAVLYAubyPx2KjdWv+J1oIwSQ9B+gfeQpLjJ?=
 =?us-ascii?Q?zieea+q5rPWpPSxkfyIdCsZNzxSkXWNSsofSWMTG0sLFbMNjqH0abgntUrl0?=
 =?us-ascii?Q?eBA3xzUtl3cnQGckY+VebCQM6+bhj5ujj3LMpil1uaWa6O0b79bf3q8RLI8N?=
 =?us-ascii?Q?upE0IC8P1SpVoC0Six9uCwee8mvvVWYV4AXnuZlprT+RreMT2Ga8RlMxGrej?=
 =?us-ascii?Q?UbSwgFp7pDWRZvaq20WwbaIpMfehpHp8nxLdbi9Fepn7kYD+d8UGCC6xLjaG?=
 =?us-ascii?Q?eTtR3qQuiFRySIPOp9QCiFBTkUW98J72Sg4/S9mWiv8ZxD8PaJhSPD6akl4R?=
 =?us-ascii?Q?n6xPYZZoJ1OLL+DM4eN6DMSjAm/zBMQe77QIaBvqKN3ldmLdh9ry4544G3qf?=
 =?us-ascii?Q?WUgucAgBWkcNQGTKB6DjoJGyxX4a8Cv6cPvqMzBGwMP3ue6gKViK5iW0G1bG?=
 =?us-ascii?Q?DwoaNRofNxCBC1UvwWtWe/I4XW08BaEO/PTAdqfgFZKBByApYzX10QDoOMvz?=
 =?us-ascii?Q?ZLTt+WhTNpAsAp+QSymLV/aif/HI5z7gskHgBvnbkMANI0iJUfu5XtaQGrVK?=
 =?us-ascii?Q?N5O8AWSS1Qknk+lPvCNz6zjakC+adDutJKV/+9QNVoDpCjFn4vBfz+U0apWF?=
 =?us-ascii?Q?MnAU+kKAKnff66mKwqo8IuMF4EXSQTtNKt+F73W+ygq478c7Qbi02mkkKoIe?=
 =?us-ascii?Q?xvQkinaatQpwD+fCKtpsJa9oBiPvXVnaBEZtZtEIrdOEivSdMnVphEE5Yvaa?=
 =?us-ascii?Q?VwJ2eVk1RDrY0tKte1j9SySWggcKWQ6oyNVJZzS7FnZZGc3qGXA+9hiklYsu?=
 =?us-ascii?Q?Lh9rEcBHZ/6vtxIsMgeBNkvPPVrCcjArAW1bJoc1RVoD1F0tP9msjvVh7Gv7?=
 =?us-ascii?Q?Mlz9Sas+9+Dc1AQF9jOUUqETTzpBTGUpHXiwO9CdR10GnGwgslBDSiOYurkL?=
 =?us-ascii?Q?ZFl1cMLqNRArYn7W3tuRnm8XAMALt5IHcz/9Gfc5sPVdJlgwwLz8z+MCwL3j?=
 =?us-ascii?Q?GUiKAkAGVUtBrZe4NdPUu1FKIU98NPK8AT+q9pf6ZsYjZyVNTN6F+KgOoBIt?=
 =?us-ascii?Q?GGkXwmMi1DDmZY91W7S694iSNOLcGMRl9YkLtWbze1KxMRkx3QX2K9keZoj2?=
 =?us-ascii?Q?fgVCptEldswT2c1hjkkcmSjECJIHZq3/m70SoKSHU/2WUb+zlaTRZAKFIugd?=
 =?us-ascii?Q?zOHi4wcje70GcsT59v4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea216796-2122-4bbd-15d8-08ddce659b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 06:03:14.6704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7NZtmJ0FfXkKg6iJYG8mPalpCmWEhJlkhcG8PxOR/USGM9lkGxx/aQ408vimrJrjob1UGac3ef4W35lweTuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
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

Thanks, will update.

Regards,
Stanley
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, July 29, 2025 1:52 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH Review 2/2] drm/amdgpu: Add new error code for
> VCN/JPEG new chain
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>         16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */
>
> it is better to correct/add the code comments before submit patch, after =
that
> the series patch is
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Tuesday, July 29, 2025 11:32 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH Review 2/2] drm/amdgpu: Add new error code for VCN/JPEG
> new chain
>
> Add VIDS and JPEG8/9 S|D chain error code for VCN/JPEG v5.0.1.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 3 ++-
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 51b9148626fc..961ab557fed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -1028,7 +1028,8 @@ static int jpeg_v5_0_1_aca_bank_parser(struct
> aca_handle *handle, struct aca_ban
>  /* reference to smu driver if header file */  static int jpeg_v5_0_1_err=
_codes[]
> =3D {
>         16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */
> -       24, 25, 26, 27, 28, 29, 30, 31
> +       24, 25, 26, 27, 28, 29, 30, 31,
> +       48, 49, 50, 51,
>  };
>
>  static bool jpeg_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, str=
uct
> aca_bank *bank, diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 0333a2833b2e..120414fb024d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -1565,7 +1565,7 @@ static int vcn_v5_0_1_aca_bank_parser(struct
> aca_handle *handle, struct aca_bank
>
>  /* reference to smu driver if header file */  static int vcn_v5_0_1_err_=
codes[] =3D
> {
> -       14, 15, /* VCN */
> +       14, 15, 47, /* VCN [D|V|S] */
>  };
>
>  static bool vcn_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, stru=
ct
> aca_bank *bank,
> --
> 2.25.1
>

