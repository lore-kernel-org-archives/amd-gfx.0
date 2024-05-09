Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDA2C25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 12:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9167810E210;
	Thu,  9 May 2024 12:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A2MRuQ0M";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744DB10E210
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 12:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1tdMbdsSOjs7nKCIHr7zhGuWbzQIbJD+VS1hIXuZ8ot9M3I3XaM8xjlxkHzKoxGcN/ZVSBOlgw3EUToYcHzGor631rcnYC2atIrp4dWELaoUT31y+5HkO+tK5gCQNA5aLHSumSQRPth+ABYtRvxmnvCcdjh6w3uoD9WvUK2UlHoSh+lldDTkJAA1u+YsUnKmSmV0hh4N/gI8+POifWraaplIPbHCFFWkepHeAwyfd6Hvlk1v7qB499Wi7UBEWDb4bvCtShW4e0Nu2/u/rxJBHPcB/IH1+k4K+2IHQ2klt+fErWVeBAFy9vzeE62nrzA1EKz+im3YZjz1RLYBEAIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GqYtsIX849AV88aEa10SYs2avD3gzt/xEq7AYlGrP4=;
 b=CTG3KiL8dUCt5wq0Yy7gDWnFwdUMSllmj9pYtvOsYzWhwuAmf8PThwifODYwn+etnPkDTic9aQ6RyMdsqH826rUjifgzN+xzeyNsDnmJqfDMrCjU6MO/3NDk3fTTReY87DUkdMi/LB2DeT/rzdaYmiebc6mfKB2QIZ0uGzSF5OB0opGHlAp223abbPzHor1zqQzK0x01JdLVK6ONNCDreVHaiOYJBptQyDmLZnx7ASHKgRelqiC2wCMZF3s3vXy9h6pI+y6iFd98rtOOp4d14mzNgV0ifMB4/x5jCOY0P+ilAICMoWcgMUcHJzX80jN/+l0bngHVfV6vSos6U8m4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GqYtsIX849AV88aEa10SYs2avD3gzt/xEq7AYlGrP4=;
 b=A2MRuQ0M86A6ZSNWsrK/h91n8TLRdEgsmlQg9dvCtpavM2Wcmc0iEECQbA/SjONfOxLrpeFcn0TMI2eXLN8qpdC9wvT/4HfMoZxP9n0MqhRpxrKKphaE/zNGGbqmy+MbysuhDgbaebGO3UbJSx/QZX5LICfFoc2trbbi0FWrscA=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 12:46:14 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 12:46:13 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix aldebaran pcie speed reporting
Thread-Topic: [PATCH] drm/amd/pm: Fix aldebaran pcie speed reporting
Thread-Index: AQHaoe9EoVraXc3yYE2EUJGwbSvbs7GO2dFw
Date: Thu, 9 May 2024 12:46:13 +0000
Message-ID: <DS7PR12MB6071E3579A40F82E282496F08EE62@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240509085925.61641-1-lijo.lazar@amd.com>
In-Reply-To: <20240509085925.61641-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f92b6b72-0ed6-40e6-9bd8-e1bebbbf67a5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-09T12:45:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH7PR12MB7356:EE_
x-ms-office365-filtering-correlation-id: 7698856d-f6bd-4119-6c6b-08dc702602d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?i+EVtKuiZwtpj1p3+n8I5QW7bi3vBzieeY3iv+SZFgWtLAPxqCP8T+oK8M5Q?=
 =?us-ascii?Q?1sR1myQsq0LWE2Ethk1XkdOzsh7eTsArba3gFKv8AA8p7/chEt49LxSbFxPU?=
 =?us-ascii?Q?R69CM+6b4jXQmzh80yHNGRJXD+ucHh3/hBghhBQSMELYiIwbhFSLNAwaeqBF?=
 =?us-ascii?Q?TiHtmbVshtcc6TFjOaponq/ZvJpglPOyF2WZpeRxNN5dgb4SzeVte2mbHuvi?=
 =?us-ascii?Q?el76Q8WZplelZlCIYL5FhXlyILdQDvE8amSNruTW1BcHNh8mhDavH1kXVV1B?=
 =?us-ascii?Q?DOTJqvCZ1fknDQHsXzGbBcrfxAfqx1V6gRITWKnx5Ia0ZIv9Ju1mjhYrCefe?=
 =?us-ascii?Q?IJ5LiImH6khXtlWEgma+6SpgsGQ0Hz0OTgQR68RnBPE/2GPC6EyUufczYilM?=
 =?us-ascii?Q?x8M0jDzlWWkAoR/MMTq5crRMwzM1fB7HX2Z7oktdMsLNDAnlbMAiMQBzPgrn?=
 =?us-ascii?Q?fsHD25/Zr9ZECCKc6FKD0JxqZMvF/NUlIXbF2lFBVLql1x8BkPZknrTB0fjE?=
 =?us-ascii?Q?bIYIIXbVmJ0a5JG5ah3HV58v5UQPh0bsfE+v+XLfx7BBTItsan+AGuNRSy6Y?=
 =?us-ascii?Q?+5ATP+eW3vOypqN9bxjrLUBCUxccnXG9I/6ad8hXw3zA5NOdyh0VPuZJqfcs?=
 =?us-ascii?Q?UlGcDmLopWKt1cajEQiOepZr5tK3jbJmPh+7njVNoauN9exYMv3pgUvlCDsB?=
 =?us-ascii?Q?F5avQWhtr8AzQgrmKEcIVIbCK4P9ekBdiWncqtZ/KCKAXcgczLyHlAgIMsKK?=
 =?us-ascii?Q?T0xGg5P/YdtcipmJoq6itcAVJR2UWc7ylvBJT46npyD5b5gqSMqgFgKRHBxO?=
 =?us-ascii?Q?90BX0x8KGNQ83Q77kldxa53r7EdrtZmQoD1rzBjT2DU2owGTYuuZAMVxcDbF?=
 =?us-ascii?Q?e/0Gf/26ez9fvxAnklq4TpoHk3NlOu095r6YwwLYJRyQNvSdEY6XgBH7Tkxo?=
 =?us-ascii?Q?DV6DFMtPKexMIFUf6ZvPRfzQo92DdVaHij/f9dsKxtN7c9yXzaLBEvy25n3s?=
 =?us-ascii?Q?wQmx4r7wr4PylB1ICCvMZ2ZHhvFFQt6q5wXkzjAByskDZRrbzRRDdPYao/7F?=
 =?us-ascii?Q?s1w3ayvm0ffxClHXmBVCbjnflb6GKzgtOfIhn33IXp2fILCMEoQwvCLMtSZo?=
 =?us-ascii?Q?cND8gZExme66NuFZQciOw9e5yCSdCCocS6FZKymKsayvjBthMRTa73rc6yU6?=
 =?us-ascii?Q?+O0opSypTi/crsxSPl47nbJHDe4VyAZHOW/BkN+D5Ixf9EIJtoggN4osieAs?=
 =?us-ascii?Q?hH3xKcXCpGCkFtTb6QmDnUlnJPz5BTAUil1YO6E7GNVCqY8tHGgYmBTH7g7e?=
 =?us-ascii?Q?1ml2T3o8/1RQeNlXp8TQ7KkWRYxkHHz9h+4FPdHaUBrA5w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+IM/iTvoQxrU5Kdu3kKtx60HAwWCDDaa53Ng8z17stVHWMz+bD7E6GN7tnOc?=
 =?us-ascii?Q?cdb5sDNEOqn62KLEnMwJr+unm1QYYmXeFsXidKIinJLUielOK7lRkIhtMtx+?=
 =?us-ascii?Q?LtjkKFEz0aKhx9QvprIBA3KyEJ9zrvArELDOaTlDUjaphK1wS4c+yszMmwLi?=
 =?us-ascii?Q?CWCq2vne8h5dKrGbkYmTjE70xjfKAOTIAD1yILZlsh4FowiB16G1tcMsvxRj?=
 =?us-ascii?Q?PbjML4hetutvXWu1bOJyZkQG5CqVgUiZrFVfiRE9rP4caqyRyBzODN4JkG55?=
 =?us-ascii?Q?bkYbfAljnY/vwNe9JciB1C88/Pd4gTcNd/+2HIUqHu/xZ2BcnGANgMNayHcf?=
 =?us-ascii?Q?ERCdLIKmvF/cylRkOiS5cgFQzJW2SsEenvBNNMK7GHJiTqUb0qsw6ddNAPUA?=
 =?us-ascii?Q?nHOfWOj0WJKEjrJ14FqogCmNOEpxZ1Zw3R5fF0lAxfOmI/R9P1/FJm3XNSjK?=
 =?us-ascii?Q?FYbhdyyN1oc/xOCQtEDmmIF+T11i+bPHImn0WWPOZF51B8J5TeaQW8Jtd8jB?=
 =?us-ascii?Q?EmDJRBQsPv+obzh1OmqZfO9Fy9mqN3dnVjgLQzNKK6r2KDA3U+/VOcjcT1uc?=
 =?us-ascii?Q?xzhcUaWc1hP/k+OtoKVaotV5I+1rzPqSobEydZ+UO7FL0DhPlwF61pMj4O9S?=
 =?us-ascii?Q?NU00cUIy3mPW1lnO1tYt2D1sGaOXINiuiGOiBbvzyoJqJ7pn9Ag+KzyudO8B?=
 =?us-ascii?Q?bpyrEqJsWKNJ1oUOQG/fYQx1PJ+pBuie/lFJq4zZMRRFhEbcWeoDZ/c7l3pL?=
 =?us-ascii?Q?0qG96wc+SgCDMLDgwNK4dGkKRT+XNxl+bXCpborVPc23dhBia8a9109bb+FM?=
 =?us-ascii?Q?S1wT7bqAMSZnQD5mi6UStRpP6uQ8pGKrzWELZ4wAfYZk4L+n39ikqpJd2oXO?=
 =?us-ascii?Q?Nn3fSGJP3f7jj4FWDM/LCuDj9xYncz4UFaT/ubgrRb7GxNpZ9vQwLsRA96m+?=
 =?us-ascii?Q?vkyYoYLzRlXf/2UScwMZIyYDMlOBrs0agSnb7YdwmeyHFOa45OlQ7v59eFYe?=
 =?us-ascii?Q?+GBLGXXsoS+HNji0slCkqWcRHkEeKHuUvWvYjmkMMtMjTU07UvVRionvyRJ7?=
 =?us-ascii?Q?tAI01cOx3lzJwpaH31oePsfYccwgJSI7f452deke5YR9JVcT6f0SpySDK3XA?=
 =?us-ascii?Q?hGTN3+TEBxAEBOXbHegj6uV1CfvidZ87w5Q12/J+csaqEaUAxWqsKoz+fKmU?=
 =?us-ascii?Q?ff/KukuDpjwsXCUTS6uwp+Z8iz8+iFfkcwNOMy6pbVj+HlcjSMxfMIIUFVJ6?=
 =?us-ascii?Q?4MEk3XrVQ88X+RCJ/MKAmeZx6uJ3jS/Her0BsJJB994o2vXFLY2U9KuQlm2y?=
 =?us-ascii?Q?weqPjtfEgenFezzExYedui49tg4yYBDyIZNbTDOGEXNYD/f0FR//QZFbgcvc?=
 =?us-ascii?Q?YMZmchlckiMZKTdBfzBcDViOXKLrrxQRW1XALcNrRBLhjKlynaFpjFEk8BID?=
 =?us-ascii?Q?LApqXSGUOK0MvGT6cnoR/DU9MptTVXWPeATwaHJpQO9W6Ao2FTAO26ul723y?=
 =?us-ascii?Q?VhDtF1BIokoLmBtbyTFr2v3KrOth90IOFAnLdLtryyghinN0OtRrTaTxf5qL?=
 =?us-ascii?Q?NJOF9b0SPKoca/ZWjrg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7698856d-f6bd-4119-6c6b-08dc702602d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 12:46:13.7667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uH1a9ntHxJfIP9phRDhxM5mq7mjFU81CSzS7cpw5geYgx8OuKxKT2IvnbqMnH6YpmABm74Brqxng1DRy5NFH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, May 9, 2024 2:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix aldebaran pcie speed reporting

Fix the field definitions for LC_CURRENT_DATA_RATE.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: c05d1c401572 ("drm/amd/swsmu: add aldebaran smu13 ip support")
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0fd25b72a40c..9c0445fa9f9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -79,8 +79,8 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L  #defin=
e PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
 #define smnPCIE_LC_SPEED_CNTL                  0x11140290
-#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000 -#define PCIE=
_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0 #define
+PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5

 #define ENABLE_IMU_ARG_GFXOFF_ENABLE           1

--
2.25.1

