Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C2BC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C09A10E543;
	Mon, 13 May 2024 09:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NUoVgrXt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA08F10E543
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW4izfFD2TwrD4WjZfJ6ZdAWvFia0A0bFTCPOUCGbG6yvI+3xwBqquqQySxnU8OpSOmp06JuUO80H2WB7pVqnyOEok6qW+eJ1kmTFfbC5JMaZo5uiVZ5y6WropU22v2wwd0o8i0ExynhiysOWZr7CdE6aZ0jv3BCIOmdmFZ30xg7g7oZgkxHwHGrVs0wBDxsUMt4MoUlTheytlpXnsn0NlLtciMQLA5xT773JuQ43+mlvCvB1PNtgH0ooUe+7R9c/o5DW8XdtP+K15n6o9Ql2jcRwQvmMtH+caADP7f299BeewBHUNVSgBMlijJBpHhY+E+7+gEw+M1qsdR3oqZARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa3iAjXQ3hFkaYXuyPGYALe317p0iMaJ+DmdApoirDQ=;
 b=Lq/xVhjpg/pmqxO6/aE9IfPrsshd+s+B4eKHQ2Dfwm8AVpFUHQV/2EWRTe4AafHs0+Fq+Oc0G2BScSeAim//r0TPtvJzWIaXF/m/eKksUGtvuytuAu19Zfl1V/9ZaOs7KGug3D2cOhu8QsH2vmdNyxMH1OhR6oimnGVcCPbnIcwpWBMO3Oci5plqoB2sG6Anx5QCTnu44JMggmlHt7mJjLjNULYTgm4fTsWdvQBX38THWpqHXzzHd5thzeVEGzpJ0C1KPVTx//OFgOKQme+0EbjIBj81201xWjtZM28aWvf20TbSVlwavy0LeAXLCr4sSwai5YrtT0xIG4rVF6cFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa3iAjXQ3hFkaYXuyPGYALe317p0iMaJ+DmdApoirDQ=;
 b=NUoVgrXt5A3CEIrV3XBxKbg/8U+inlnB0kd/OaGmmfTUvB3n1QB+LpsUJZVi3zcBbdDXf4j8dazMJ4SHR63R6RP/eO1Iyuo+W2XNhN7gIVlRe6ku6cZRHxhD8ylBvyyS3CiOEGsfmtcU/aPaeCQr6K03hnRRa1auEEPvWeOyx/g=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:00:02 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::e5c4:8dc5:a5d3:33a0]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::e5c4:8dc5:a5d3:33a0%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 09:00:01 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add initial value for gfx12 AGP aperture
Thread-Topic: [PATCH] drm/amdgpu: add initial value for gfx12 AGP aperture
Thread-Index: AQHapRFl4ZPTezTvu0iKeMk/iEZ4dLGU3FVAgAABK7A=
Date: Mon, 13 May 2024 09:00:01 +0000
Message-ID: <DM4PR12MB5181AAF5D6B02927220B7679EFE22@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240513083929.91933-1-Frank.Min@amd.com>
 <SA1PR12MB56592211FB21D663BFE2F7C5E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB56592211FB21D663BFE2F7C5E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a0f72b4e-a389-49c9-a756-360b5ab5f063;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T08:54:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|SA1PR12MB7127:EE_
x-ms-office365-filtering-correlation-id: b39c9555-698b-4cc1-34bc-08dc732b12fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?NvgIWkk6v4gLvrcszXJ9Kye6fUco4evHVGHDwK/YMtbqUfie7l27BrE/LPox?=
 =?us-ascii?Q?wBNkRDpyD+gUfIfCERorULjP1YU6eMUt9yaslvWggswgtnWFUH5N6FdDCgXs?=
 =?us-ascii?Q?h/YgZAFqXWloOfchTLw8Ti58PQmOtODBn86Kmk5UoIKhOKWLPpYME0yjgi9L?=
 =?us-ascii?Q?Y4JyHBi1GJSaWukEJKdqLJokd5u085QNzWexMhl4NNykenuUSA18fP2GFg9W?=
 =?us-ascii?Q?kdopl5MqC++qnJxN8nOzdWL4Rdpq9iGt9qvyTd4L3vSPUcNBbdRz+Ex76IIn?=
 =?us-ascii?Q?6bjmYMUHUdXT4E//9+21V8j+rx+3vdJkMspzSKA6fquNLRVlOfIs4hS0nzpc?=
 =?us-ascii?Q?tznb5ejo3MPxNd13h5LGSg9z8XRBR51EslM9AiLeUGyGcPEs2Jy/08lbbhYE?=
 =?us-ascii?Q?92dM9g4d3gaAtc3anIeDgJ9YiigW/AJKGIpLgpkF2CawJoykpZhbYZLRVPi6?=
 =?us-ascii?Q?NllnmctcMo6gZVGFL8eJm1qqsjNnM4cjFFSILl6JLoGGv6ejAhuqQAKk5397?=
 =?us-ascii?Q?AlXSbdD7nmYeiV/hjbaWrYOEWy/OWlo2EDFgFOVizIwMn4SA9maf/yzLeGO9?=
 =?us-ascii?Q?kSkKU25mVYSXkOoxSslv9SUePLJxiiZ93TVQe//Hj5sf0l7Jwdq6+H05QgrX?=
 =?us-ascii?Q?iT1iVorGd+N2ju6EW08PwR/x5BomJ7GQZ/11bj7iio85u9emlZW7kjbIjI0S?=
 =?us-ascii?Q?3mAX/aq/YJn9jabYC2C5ZeEed1NdikiwE+7H49mLMh9s8mARUC3hoqnbvii1?=
 =?us-ascii?Q?9Sgg2B5ZfkDGLpAFBK+Bc8igZIrIdoNFuKiNl3U21bdqlEoh5IMWOc45LJWm?=
 =?us-ascii?Q?6gGL5PPxg9B28vws08Xa0kQw+k7xa66domSMF7I6nJr4VcAVl539IG4fyaQ0?=
 =?us-ascii?Q?e3MZsYlHjxevSgQOD5YQvdcAfNdMF8cKzJDSeJFAKYsGhVM+xJZxAd54lKGE?=
 =?us-ascii?Q?qP6jEicIhVFFZUufhnBx1TWvPA0fjtUCtdVnGj4//4Yi7RdapBt9y7X9zm6w?=
 =?us-ascii?Q?n921UoHBJ3IrdU7XSKr/vFHKpBCwzooXzHRcu+gt9CfS3lh7r1Aq6wRQE3fk?=
 =?us-ascii?Q?01qQwIfMBMB05aNQT3z+lQrKW5YzkY/J1MvX1deHJUL/b6rObga7oJ3pO7CV?=
 =?us-ascii?Q?GMRYzeuTmGGTFYwOYMrTLo639xuIYLsJMsscg5SOWOcvOP6sH5315MnculWk?=
 =?us-ascii?Q?HBJUMYg9Y3KH8NFQP/i+Ruq8o4EanipygTfSTojXtLeKTW5kgdJtx5RUQAHN?=
 =?us-ascii?Q?32qTl2AJIWDoLxEmhKynyGahRa0qaKLqNhEG6O6G+zLBx7nM0THzFX9cZfMo?=
 =?us-ascii?Q?Em4SNeEyZOBzz3Ac5Kre8MMV04NIEK4S0xZLcBwTeNwHYw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O2ttGC/ioCzI4gzAZeZnERGhSKICs9Xh6+HaCz09AzsgfxiUDzRDHnPdYE0j?=
 =?us-ascii?Q?K4UogqJVKxrFLEJiXGA7CAKAzsENvXUeEL2JqmWeLUy9fddSIXKE6GFM13V/?=
 =?us-ascii?Q?KNd2bDIEe3hxVI/qr3GHI40apdzC/LH5SvZKdrhaSgE7Y9ww7cMdoZjEUlKl?=
 =?us-ascii?Q?e2Tqmzh+KHMmpb4jMToqFbr2rwJjhbflH9T8K3ZJP0PeLKLsHKHLZMtS4r1J?=
 =?us-ascii?Q?fJg+sn4pysxbGwnN9eqZW9ioDSHREbLYBnbYM92wZjAJ/48bMJufsaA1lnLt?=
 =?us-ascii?Q?eYQXSwU+rtZWct0BRofSQeJT+dTFXmvfLzfKoxWNE0cwE/ZkjlEb7YYy1aIf?=
 =?us-ascii?Q?4Ja3zBLX8lpx1+9M6pw7uU8+/9vzv5OjxM/l2BLuWWH4uoraGtCX3FB1S9fG?=
 =?us-ascii?Q?ec4EeRy5WQcsQsC4JdTFnX9WQCASsl1QGRBZgV1mrJeZtxp94LgE4LikUZGF?=
 =?us-ascii?Q?YgpGaK1P50f9pWr9JI4wPp48G1IzbDmqVP25h8HC6NSOMxH4tpyEMs8QWpP6?=
 =?us-ascii?Q?XbDGk9eZFyNq2KIpLJicqhIHbb+BS/1//waPpVjr8VVPdIqezX/hda73s3Lu?=
 =?us-ascii?Q?nmRquUKVUxKpYYjolHQkEvQc4ubxNtIh9JIEhXCfhuVyiUEsJ6U7jxscwQZa?=
 =?us-ascii?Q?TQMp+yDAQt6Rr+gocke6/WYGg4oR8vSOEHGoLQkX1QrELMB2Ur/pjGnHzwsp?=
 =?us-ascii?Q?0FOf2gyz154G7V2n8Ax/ovWbetrv6Uj7yNSNTBOYxiHRnA7k2JCT1CfEwPem?=
 =?us-ascii?Q?J22AAd5zvw+Qjc/02klorvjelnkeREOTtD2weNg9DVTi0E9S3nyLhWZPLBcj?=
 =?us-ascii?Q?0tcsL7vguRbxULetXQJKCkmpqTCdsNK1+3CKkJy79Kt8rzhckSkvWaioH0wL?=
 =?us-ascii?Q?7pR0JvzMbHIyuHz1m0PV6t+UpOIoUvvqR92H8UMqLt7NK7I5M01IXkajAy0C?=
 =?us-ascii?Q?U4Q4XmqfTqrtoQeN5ssCNkiAeg7a8g7Cyznh7fkIJPlnba6ARnXk7wFW/PDH?=
 =?us-ascii?Q?UQi1jjii68bSmpKsjlMMCdy18NdPFrOltkMmyyDtow86nRYmt0qo9X23PkKe?=
 =?us-ascii?Q?xdqTJ1EnkGgA2BOJkvz1YM3Y1q6qxei/UHJCL8DTlKzakcZL8+pBsU6jvRYZ?=
 =?us-ascii?Q?9JiZSKNZHaepwzb+fUOU+hj7BflwEKI36G/7JxVhPBbvUhdIBxOY6Fs8QNn2?=
 =?us-ascii?Q?slPIf/P5ki7kfkW95taQetDJeVowdgP2ru0m843adUCS7xeS5yaCOn//bKJO?=
 =?us-ascii?Q?H3cmIqu9gwMxXOBhhDYOZYQ3FVwMPO9WuXaLyV71ioVEpZqNkYAuLgvwW5zg?=
 =?us-ascii?Q?Ob4GdkI2327tkXrCF6/VYcbqbOEc6lKC97OHqNtHypr3Pz0s5+az4bD85b37?=
 =?us-ascii?Q?XaKom5dhmuAmFwypzs5pdvI/aqf4V4dWf8GiBm1onb5j/Sta8kjRg9JLP2XX?=
 =?us-ascii?Q?skszFZLrITFWbiwmH4YofTpIUnBDmHCXv+04ZSv3GHhY3/1ifrHYt4fyUN2X?=
 =?us-ascii?Q?oaycptFAiPuSNFrCErIOy3Obqu4qxIsFoBT8woG69GfRC7jPClLcqBY7369+?=
 =?us-ascii?Q?O5rLhe3g5jxaxrHEao0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39c9555-698b-4cc1-34bc-08dc732b12fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 09:00:01.8651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YL4c2Dr3kNO4YFPiLNTcgnD5lZKH0Fx1GYaufyzVHYpVzJeYEzYcLYXVgiQnN2VA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
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

This patch was
Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: Min, Frank <Frank.Min@amd.com>
Sent: Monday, May 13, 2024 4:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <=
Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: add initial value for gfx12 AGP aperture

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

add initial value for gfx12 AGP aperture

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 34264a33dcdf..b876300bb9f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -622,6 +622,7 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_d=
evice *adev,

        base =3D adev->mmhub.funcs->get_fb_location(adev);

+       amdgpu_gmc_set_agp_default(adev, mc);
        amdgpu_gmc_vram_location(adev, &adev->gmc, base);
        amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
        if (!amdgpu_sriov_vf(adev) && (amdgpu_agp =3D=3D 1))
--
2.34.1


