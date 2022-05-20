Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624F7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 08:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE17C10F48A;
	Fri, 20 May 2022 08:16:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F213910F486
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 08:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMNx/7OtYFkb6JyWg59dh26XEwhKb1kr5NW9ej0K/6GnUkDIHwc9rTBM+PPKVU5Z9Ja38Uxs0OS3nYDAAB7uLG0ruhlasfbzitU8smpC8dvk7WZvIAnkI8fAZn4Zmj0RA99lILOTUhvA25LuCANNLT/CHy/Cmp8mBdPotav9QkaE7fraxVSFUcDV2A/M088tW8TIhKOfJ4daBmPGvGVPxLypoq1lGg0UjTcq7WPNIzsK2tHLMiwQHmk1WqYkGj+r4JCqIm7dvLzGSSr7TvsjKSgvCm2b3lZhMTpkBGT19BH4ei9wBChrVqD7mwesq08/QYq5kMzTYOmG2tZPpVXoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDRvfnI9CcXugNXv/LLYXAhUVRzrC4QIFlUP4W5aFmM=;
 b=Rsn5ztBC7hHQaJYHc1F/1wBGFRZF06I9U7X2BDirabZa6mpNH2AUp//ayrVmwPcO2Aw5UmdSv3xQxyhztyLrDRSeFSVEeQbN9ZFHdypQGYGoG1mSky9LMHbNZzqgVnSm9gz5mEhwqpdkFEsVc/jBaTULLZ8Yq89MdE4r4WdYiSyJVSl9k9jfYiBsBHgpF33OkeL0ggRzLIKtndyXXG3DRMUefB8YaYT9B5NOODOln5fa7a96cw5nSj8rArp82UYHZhlHgJR/0J169Wr5IQ/XFJodjTBBCyHM5SlKNmfMATzy3Q9JDZHg78QRbrf73eXR9CFrT/Lv5On2QrHJqa/doQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDRvfnI9CcXugNXv/LLYXAhUVRzrC4QIFlUP4W5aFmM=;
 b=g5HqgXTGqTYnrajAPQsGcgZ12kIrL/2kS9Zie4n/im/iVwHcfOm9hws4F5Bpatjd/VzGQiPkyAeCCkiDgugBKe9US4uZpw5BI+OEYytQNSTGesFMdRxXBwM/YkRQe1wDPF3V2z7RlKLZxuhBzT8FMz4YEv5EcrZqZmKichBE4tM=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 08:15:57 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::5a7:435c:485:6658]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::5a7:435c:485:6658%8]) with mapi id 15.20.5250.014; Fri, 20 May 2022
 08:15:57 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: clean up asd on the ta_firmware_header_v2_0
Thread-Topic: [PATCH] drm/amdgpu: clean up asd on the ta_firmware_header_v2_0
Thread-Index: AQHYbBEQ3TfGCpzghEWh1o68eLUGrK0nasPA
Date: Fri, 20 May 2022 08:15:57 +0000
Message-ID: <CY5PR12MB63690D8DE711EF7038C2F241C1D39@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <1653027110-15667-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1653027110-15667-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-20T08:13:22Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=11c65b91-9dbb-48d8-b515-4581d95d8d36;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-20T08:15:54Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3b8b7c98-7a3f-4367-a792-6ab6a6c24f9c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56a37ac3-157d-48ce-9edc-08da3a38f790
x-ms-traffictypediagnostic: DM6PR12MB3306:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3306576E4F8A0D6F2DDE5DAEC1D39@DM6PR12MB3306.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uui3nYPJMh+61Bo7n4yurcBS1PFWaprfG95HfnMBP2/psedhqhGroS49ocReJNCJmMcq6FPGqs6YJSQmatcwHxW5oJ2jZBtoInBrXKtTiTpKIToB2HEOfz2+BH2z+Klj3OigDrE8nlTPMFyBa6XS4x6tl8OubVA7WSZ20hIQI0HG/WEwlwpo9jsqm+ursnIwmiv4nZtUsk7ml3Dhrh9BN+d0BXiiV6jzE4WzSEUXvC9xyB0XQ31Peywe3NbZHqqAkldBQl5mFcEMwylDLvAxE/r70dMPVhWEwm184SR+HPjK6JuvU8Q8TsLmJwyGEbuGBUfBlmQzcbLcu0kLP57v1VQu1zwdq+RAwigxsBfY+vvm+rnkV41Qwkdngg926wJDPKmu0X+0IRMUVnSgENiXTuW0kjzg3zPFz3f+VUp4zoKBHQYVguuHyioQDk8zxRwb3qVRt9k8uc6nf7XnCvT8v+ffKieocGh0xYkhztm9TGz+x9eHvcF66Cd0Ek8V+87rEmOsZca1IVmtMIERZGMEXevbgNOnn44/xwo8XpuJkH3QqQOtFMT1eMJd30+RZLxm6Gx5dI+HzwI05SW760c5LDeoDrproleNd58epBJ3zmX1PNZzzxaHP1+2gLrccBs23RpduxE5fPZMh2WkPZDP4v5/xTT7DH2RhmGHvRdsBRdPQ248CcKircvlvkJ0UUgxaBrhKcyAlqsJwiMlk9OLVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(33656002)(186003)(55016003)(38070700005)(5660300002)(2906002)(83380400001)(52536014)(64756008)(53546011)(316002)(66476007)(66446008)(66556008)(8936002)(66946007)(6506007)(71200400001)(26005)(7696005)(122000001)(86362001)(8676002)(110136005)(76116006)(4326008)(54906003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iERPgjBD/BWuqZtVTfoJC+1Q9wQ0nH5f7ze8BD2+Ujm0t+Qx4BlzLaRjTL8M?=
 =?us-ascii?Q?I4KNYc3xhrd7bpEjQHPvuZ4GwJJq1zlU4yRM0osVPijgI6ZG3hmop6Kcy8mn?=
 =?us-ascii?Q?8REW659fIbL//92G6UcLRbMkdoAEEhINSJJc3Nu1WYKGeQyTefMkrWpCp6/H?=
 =?us-ascii?Q?3/DZay1ljEf29d0USE7u9/DDl8ghM8At9rJ4i+vzuMk/I9J6KwJEJDfVGK1O?=
 =?us-ascii?Q?L+cmXzgB4ky+x3z/HX97Bcx4sLtg4lPzK2AiRFvS8RX3EfW5+UbuBWsXHR9E?=
 =?us-ascii?Q?tuFiDgBrc5YOiCLl1hq3NVCvtxiMECZF/EwUJmsJxnswSnYdGZ2lq8H2o9lo?=
 =?us-ascii?Q?n8JzNO203bWgnuOyaJp+eWF7vpCciMP3V2aanlfnIAmTuZpfAYWCPIXP648n?=
 =?us-ascii?Q?x/0TYWx/lar+0EwdwwTEaR4xoriOFT41s0Pbm1wDeF1gyB0DIngeqiaLyZha?=
 =?us-ascii?Q?01L4ImJoJW2mnLW/btY0SmwsM92aF/D2Zm82+xgSRum+kDZzt8fEegtzuVwN?=
 =?us-ascii?Q?FsdY5cCmPBCCGL1oH+NpCh9QxsXcjfHP26eqdOeuy+71kMbEn2RfwCbMNJ/x?=
 =?us-ascii?Q?j1H+u+pXzzYdCmyWkw8/2bmahOYo+w26PJ+mMwPzho7sQnYoZmF0ypue+0Pr?=
 =?us-ascii?Q?SaYoE6mmq0tUzy9Fx8LhF6IDDkEY47J+g5qCtoYbU3KhDWZ0O655r6OyAjWY?=
 =?us-ascii?Q?puLKiLx/lanD7DeclTzZ7WA39Em2d4xwmMCGANL+xIl9Dp++sEN8B8doqh0x?=
 =?us-ascii?Q?zYTkqpGUc+BIQK8LOWvFNoixJU6YkgtJtg8uqgiVVo9gxvAnw7mEyJPaAeuh?=
 =?us-ascii?Q?EPChAB6bahaif4M0wFe/dK75/4p9Dwsc/yjC+e67IkRQmHn6ZyLrGUBD5dOy?=
 =?us-ascii?Q?7HxcCxny0NkjPMDsmNSe9bXwMwM5OWJnVfy89PI5ypZJ6o3VK+ITyvpevghK?=
 =?us-ascii?Q?REyWMWyLYJYU0qaSM1kqBcjDRf9mlDFvgbZKitJHJOdmRWtVaHS3+xASSQMh?=
 =?us-ascii?Q?6KYERys6RerVBTmBXFSe5HEJf7qa5+i/+j3QNwWIUTTmdvInCLOGk+YV+X3p?=
 =?us-ascii?Q?PRnQ3Q654EvhtHPdFs/XLmjMKUeqLXhMOjxd02hKwM+7vrabNvnYBRbLKK8s?=
 =?us-ascii?Q?zGNnBqDN8VrOW4KAT7wzV3xzDfFstOVXrceVSH5gyghJDksANgpPwR8+9kt+?=
 =?us-ascii?Q?8HqdDTwY6L0uFQXVr2GurRm6jbroQqou+/omxOCw47g/EXF0Ym0sAcoy5W46?=
 =?us-ascii?Q?u3a8LqDDt4QTmgD3LjzRHtYq2/gBgGlczJMzGaRm8XjDQ/LQOLprllw4FFU0?=
 =?us-ascii?Q?uCf0UMCcMnV8r2I0K3AXw501g0utT9NmuKT5yXqTwzccZNVoqdfDyq7Ljd9B?=
 =?us-ascii?Q?HSU0IIaPnVUSQKhCNxNynZSsmcPXIHt/3JPAt1bOA/0BSmcPCDjX0h2Cjxv3?=
 =?us-ascii?Q?u/dHZLtY118BqEHvdUB9cAlrH07wQQqVGY9uXoWoPNG8gueUSkLqon5hzfpS?=
 =?us-ascii?Q?QGpHBZJMxFhL87/1jjNn02jrrMcQCXwfA1//DulyEaKNZNj3KQcVCpq9te31?=
 =?us-ascii?Q?S3MCP3CJCvmlyYqVHZ0H9nBhepHIdJwZo722OJxh/SOCJzw01b+1os4vFZFj?=
 =?us-ascii?Q?+QR3VYJN5VyGgjb3evLeTUjXigOhOI3+1L3sQ9mqGvYuHyb0ofVST4H4NcNR?=
 =?us-ascii?Q?lpgdb8/3MMRY54o9P76WpQ2ojAPaUmduljS2ZCU1jH6ezfCH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a37ac3-157d-48ce-9edc-08da3a38f790
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 08:15:57.1751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbBsgOIuJLXjg03T7tI5aFIa/58q9/G5RFUIT84C24kb0h3ZINkgBD2wn8R2ACqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>=20
Sent: Friday, May 20, 2022 2:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Liu, Aaron <Aaron.Liu@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com=
>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: clean up asd on the ta_firmware_header_v2_0

On the psp13 series use ta_firmware_header_v2_0 and the asd firmware was bu=
ildin ta, so needn't request asd firmware separately.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index d6d79e97def9..f2e3b6ede77b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -32,13 +32,10 @@
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
-MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
-MODULE_FIRMWARE("amdgpu/psp_13_0_5_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_5_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
-MODULE_FIRMWARE("amdgpu/psp_13_0_8_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
@@ -93,9 +90,6 @@ static int psp_v13_0_init_microcode(struct psp_context *p=
sp)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
-		err =3D psp_init_asd_microcode(psp, chip_name);
-		if (err)
-			return err;
 		err =3D psp_init_toc_microcode(psp, chip_name);
 		if (err)
 			return err;
--
2.25.1
