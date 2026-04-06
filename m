Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D25EEF4ECA
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2026 10:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6AA710E1D4;
	Mon,  6 Apr 2026 10:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zHa11pYd";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C6B10E1D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2026 10:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOfABjKJmNb7p5JeUdrSZlY9SFHJAKG8VIA8RCmd2qPgAvo0Y3/QqMIFowJw9NZX3XKrfrCp1o4/xqApJJkoECcW7uTQAx0t2hQrHgw51Tj/9RTZx7zSHlt+sfR80U1L8zi/r7Y4HK5zFQlraQPtKZYuP5w3j30Y/LqYH+XzX5sQGmSIcO3zHI50V4z5QtZYFBSWkJuTivHLQ+kJ7O003lKcCZNRZcr1Vkywf6m2yFhwhEvb8rsgXD6Z0Nr10y16ucyoU0NlZDTIRfcELuE+tF3tXybld74vbsfkodaPYAqJBCOXCi1NmxWYe4BJ0DkFYBD8GgcdOp0aUm2JAnXEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRRelp4NCB7WmzB+kDQb831PAD+P0grd4t8MvTfzWJI=;
 b=Wi9zyplvQ0Tld1qh0FeT5LS0pz0LKWq91o3ePVs2I1n8Oh8gTltAYtrFz6XF9szV1jBEFdmOsdCGIXo+Q0HXqL+YoE06ZJyYbkjJvGj4tfXL+TitkMxp+MTD43EZALfL6dSEaB9aVLouU7xuSUvWGgLFqV+bbXerCg4L9uYD5uL/9lXwtfIREXFLwePIoWheXAhbeuU0gR8b2bp2Y1WWBNhiyezBJXljW4bRq2hqU4J9NbW8n1agoXDHgxkEEtjgkEzlc4+QvIM1CfJ3aDGYJGQpya6wvJbu49WhWm+ZydY4IV9pK22BwEgLVnUPpJ9krr4N2aajqVpFV7UwFaVIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRRelp4NCB7WmzB+kDQb831PAD+P0grd4t8MvTfzWJI=;
 b=zHa11pYd0OsZzlTm7lEghDN9Ae4SehxHbKBjOBPBNW0M9ktnhK8tgdiIPpzN5mESI+nyh6FaKGg17LSkRC5evkMCXh7COLAOndLL2UF9qkJ5cHbupiHhG/StxGdx6QwtjJu6AkAH0WHQU44OWJv/DjjRZRYeOUAzd32tKaqFFJ0=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 10:01:34 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9769.020; Mon, 6 Apr 2026
 10:01:34 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Restrict NPM data to primary socket for
 smu_v15_0_8
Thread-Topic: [PATCH] drm/amd/pm: Restrict NPM data to primary socket for
 smu_v15_0_8
Thread-Index: AQHcwfXiZYUxTdFWD0y27ceIijPXV7XR1MBw
Date: Mon, 6 Apr 2026 10:01:34 +0000
Message-ID: <DS7PR12MB6071B0FF7327B6FD3BDAAF988E5DA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260401163726.3811578-1-asad.kamal@amd.com>
In-Reply-To: <20260401163726.3811578-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-06T10:01:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH7PR12MB6934:EE_
x-ms-office365-filtering-correlation-id: 7cbc7680-2641-4245-674b-08de93c37c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: eHYYr/tCSHg07/9ywiKOM4boui1YTDlNfx85/HqA6wCg+5AzEuUg4JkWy8yKzKbdZdMmctK5uCQ6kkuT5pIYvO3O5QwRkrnRx8cuSTf4f9g74LsCFOkiqMZleJIEVxv4JyBMxqVf2VbUNCt05cJa4z5m3EwwN/WtoF844mLKzIty/+MiICZDjl4gKu4K+oRj2eBxPs71jYIIm1iWgBt88FyMCEy3RCjHYGcCqWzTg4Z9b+hbr8EQAcBE5WLUZ6j0hhQUuZM+O7TDtKxB7uo3DInkbVf372U5/+CMuyqEaX9m/z/C2GvyoDripSu1VgIb3XKZeHQI1xOmyOpUuc69RT0MPMub070y2+1zLKpkbKG0A6fcvx6PnDGlnKZblYipDFRzTNkjUHvnu+0SlFiLK2nZBdMBL1Nmyb9FGfCRNWyAJl1Ah3A5n1ArsxB9++mh8CnsUC1HOZYhQyZ+pG1EOjsP6ooxlZSdkUtZbP2WnrSb4s+BU9PSidUVg4z5FGfwD7xZiccNV7W0GfR3PZWCv230bcwsKyUTcnusYJ0ziq43OHGKBKIqZi2Webqofhpya0O2AG4JCEyeIZqMM+xVpim0L2g0WovCuIZf/XgLPiXSJVkoKCzB4mD6iSh/9WWL2cflNSpBQAWB+xCNo35pJJPcTFouRI/96dWFC3AEnbqYjzFaKKFgRlIM257eNPxNHW/UWd1ZSdtPVt8MF/3GsacMajcD8k6vH4kmHY1JpHOPx8YvAYth/7Z19k4ouZ82OoI3/BV0h8GWq8Q0YIDzyHLYlyfU3Meu7zZG39nJ5iw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?icjB87tB/7QlHBpFfeqKnsCJMO5HOzJRFgjk9BonRRQu+RJhMyhNBTHrHnub?=
 =?us-ascii?Q?zB5cyJn3YZ3A6v6MYsQhyk7jNPhKM86rUPnbcEC3RWECmWmnqcooz+3HJs3Y?=
 =?us-ascii?Q?XA2cyRZj9WE0M4n5MKgK8mKWqymYT5p+lIehMb3j/loinJD2CZSIFktCfPVo?=
 =?us-ascii?Q?YIQHRDEqbHP+INQbIwrPCajavIOhrK/3f4kLSNiJwu7hUzKOYlFUXUN9Z1iY?=
 =?us-ascii?Q?T+pykQHtM/DGhrgoAHXt+Yk2GmdHKBGixPoNEHqeD1TbxhqxMBFEjn1NuO8O?=
 =?us-ascii?Q?KKGcdigxgDAcQpynJaKbkjmngC164RcvT5x8cAgzMcLS4jF5Uiqsk3FdggJL?=
 =?us-ascii?Q?FovZVtn68MELVq/Vs6EOMQ6nUP/KQBMNLvUKQGzR6+FPd9Rp02egcazL0JiG?=
 =?us-ascii?Q?RHs41azTFTJOzIClLBODb2ItnZJydiFU2fkcQNAu9pBfVxMbihs8+scX35jg?=
 =?us-ascii?Q?5N2TLIW9jq5z1TuTYShk6XXpHOL3BPCcbcTeUyfDg7QPG7pyCun7t7BW6Jhv?=
 =?us-ascii?Q?BQArbgWwuwQOqELEuOjr0+8lmLSr65zwCGCWY50Q0CXsUbHjIxheycb+xT3/?=
 =?us-ascii?Q?habe4pYqmIAwFb8+7z1XH7F0V9eHHTbrA/G+4/7rA5zMJLPKkK4bckx8bcNs?=
 =?us-ascii?Q?Dux5rf99BnpNgf7fexCGX9OVr0OAShuM058scjhwnuuZa2kkbr8sOhNFJ62n?=
 =?us-ascii?Q?G2Brj/Qviq86sqZunwSSUPvRjUM+c138L+3Fc6IkQt3kYbGf9Rwof6JPJywe?=
 =?us-ascii?Q?FdUkirJhpSDrrswZ898FsTsNl6oYtIVvwdTf59M4p50+5pptKDKkbQdHs3Ic?=
 =?us-ascii?Q?3i1ozVdrMa4HwZFghCqCUpI6kwy2m0bSxQTXK9XKBpHBQkRjAhqVThvtjAzz?=
 =?us-ascii?Q?WVXfw7ysvknOoP4r0r85BxlWo+0YCx0KhJOtH6BdhrakythqvJc+5spC9gOB?=
 =?us-ascii?Q?9Zv5IWoCDyneXlUIw6aolngqfsEqCpRCPWkW4whD70Iwjh0FxuE48cwMsIG6?=
 =?us-ascii?Q?ziwYimjh9cy/6TpHXExZUmXzTESQUT6rqV6gYn0PIMN+Vsh3hXjcxflLcUDz?=
 =?us-ascii?Q?O9tL4p2Ublr+9jbY6kM01XIFBzUsufEO7oiTdlCGBnCpWLG5ajpSUW/RNC+B?=
 =?us-ascii?Q?wDkENnZsOpp12izpEm8sRMbwTbODKyu5vyHZT7OAjqBhH4VariZ4+rq0qTpY?=
 =?us-ascii?Q?LGJkN44J5C2q3GbbkkAcB45ALZXpryPB9MpdHgnFJBLdablfxUpNgVZbsCRS?=
 =?us-ascii?Q?iM7yC5Fk8Z8L+nqcUoqpJUdkNMa50ak//Gg4TR3ysCUSr1itrp+WckRFke6H?=
 =?us-ascii?Q?xiWvvgkCfucnawFx7mwholPzYdlC+qkijDlrMeYWrj0TcNhZunHxH6Ka/zLb?=
 =?us-ascii?Q?7N0UnWGwhq2vzxrVZjqbwJfmlPia376ubH/nVDi+3e4fmzV6BP7RJZyB6sM0?=
 =?us-ascii?Q?OeJAM6sUNV+DLkwWZDUiOn3pFVspX04wzkQLyZIse38AleFj6WUgqvBngE0P?=
 =?us-ascii?Q?J2Xi8nNRH6L3pVY8/otJe5RhCUNL1pWW2kYkC/d9lbIf9+Kk2zHS/OQCJgys?=
 =?us-ascii?Q?GS0M88ox2nF/YDp5cGU7Hr2rOQxd4QK7mJ3qEc7SnUVBFPZpdaCwimBY8M0n?=
 =?us-ascii?Q?T2JAFWX1/F7Sx/qTL4zTNKFKFgCtjhnxXiV9KrIJLLHTcy10h2UGPuB/jEBI?=
 =?us-ascii?Q?3moFaoGr/YNxIaavSfB+aDqqv8SKEo4IDp/RPGJqPJH4yQn3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbc7680-2641-4245-674b-08de93c37c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 10:01:34.6296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rY98C7naM5Mozh09TcsyZHKmGR9/lVu5UdmTMJm0kjLJd1uWVpiESsS4ClnEaa97LXioiSG/XBeq3Mnd7HhvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

ping

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, April 1, 2026 10:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Restrict NPM data to primary socket for smu_v1=
5_0_8

NPM data is only defined for primary socket. On secondary nodes, return -EO=
PNOTSUPP instead of continuing, thereby exposing npm node only for master s=
ocket.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 756cf4ac00fa..b0faf57b0655 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -578,6 +578,9 @@ static int smu_v15_0_8_get_npm_data(struct smu_context =
*smu,
        struct smu_table *sys_table;
        int ret;

+       if (smu->adev->gmc.xgmi.physical_node_id !=3D 0)
+               return -EOPNOTSUPP;
+
        if (sensor =3D=3D AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT) {
                /*TBD as of now put 0 */
                *value =3D 0;
--
2.46.0

