Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADC7C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 12:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B09E391038;
	Thu, 11 Aug 2022 12:52:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C1D11BDC6
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 12:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBR9za0sXxJ4wbil6GDREoU/Kd/AShi9JsAb4LYTf7qN/XGSdS435yyXS25BwymE9ukWQVNS5eCuxA4EH0MGJoDUsI75v6GVtMA95Y5nkP04abdJ1jY2D7Z8GZDWNA/FfqP5pBMmYFzQqYK5zPkOV6pXAbu/VTDD6C1akFq4ULmEznKJduaya6U/Vhx718pAWjim/GaHdvO+6wPh8ZRrvaqBj0gQwhxjn09EVRlakCKz8XjBihNFAQztEzQsmvKzscdn6HCUvmKYpS94YVghz/77JehVbsBCp6IQZqdXe/F5k3ztHVgOJdGe6vDNmm+ZDBQq1zwj7u3oLOwyihqZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnXoMYoDXGakJfs6iygx1WQgoWONMK3N7xYN3g29XXA=;
 b=EsmsKRx2oCgKogU773WeZRZO7v6/i18TRqzLsByKFC3EDcVVXDGu0uC0NcwJ/ZtShQqiCyVKSPr62dA5t2+B9HWhnnvOAl+rV8S76PPFmlDB8tdF0Ca8j161W9ecHQva3ZCmhe0b9MZ5wzBqEEM1TjIqDxKFnK4tc5QVolxW1IQDvgZEoplPxc12q6L63XtfAbeVHIatAG0RpOmWDYqUeS8Cjg4IxLe3DPl96E8uJm8RRcbyShasnxkBrj6I2SfQzlQCOwA4UJuQWdD8ob8H/X13WY5M7HDxnRe2iB0JNBOLwaMKGRgiWZ3NQstxLtDmUpayqddXKvvrMsNgFQEsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnXoMYoDXGakJfs6iygx1WQgoWONMK3N7xYN3g29XXA=;
 b=sIvZnwVIWuNgPxQ/GWtAPnYCtnG+isAPUwbyGi2/EGTFLiVs0jMiyKmveb1zNj7LupKnNOtoL2Kxl/fLlwToaE0DZe3UwJMs/Y491KkBl4aBmzeRkBVjj/RU6DFe4S+ghq+K+gEdqYG8m4n69HBVeQRpH6eWPq2sDyojN3ObRRg=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BYAPR12MB3318.namprd12.prod.outlook.com (2603:10b6:a03:df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 12:51:56 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1%5]) with mapi id 15.20.5504.016; Thu, 11 Aug 2022
 12:51:56 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: reserve 2 queues for sdma 6.0.1
Thread-Topic: [PATCH] drm/amdkfd: reserve 2 queues for sdma 6.0.1
Thread-Index: AQHYrX9Lbx+96w+Ha0Kr7AaFwC8ufq2ppxLA
Date: Thu, 11 Aug 2022 12:51:56 +0000
Message-ID: <CY5PR12MB63698D8AC1797868B3857A8EC1649@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220811123016.3958303-1-yifan1.zhang@amd.com>
In-Reply-To: <20220811123016.3958303-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-11T12:51:53Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bd98a3c7-97cc-4c17-85b1-84c6a1cdbb61;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-11T12:51:53Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b85877a0-5549-4b7d-9901-1bed5d3f5d5f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfa5e639-6162-43c7-64f1-08da7b9845e7
x-ms-traffictypediagnostic: BYAPR12MB3318:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2aVXlRsGudZmcEeRLSHbpMXB7kV9TeB7uz78TmhuGoYYmbSpbnPb3kIKZHLLzDd4Ptg5wwlBNAXiecawZiwxWL6EuDoX3zNhKrwqHecKqkk9vLMLaPLBU4KX54F8MtFku3WkkuuCzzk9ucIiwMyoRUlrhMv2foqbhAI6rYCIVK3vRcm7OIjcmKjKWihdAowCh5LaPDvcJpK991bWtFOE7wxBSYE0FesfRwEVgXbYV7PS55RrwwiD8+48u+a7HQntAqWPaBz3qOGRz7k7oFYNzcE2Wu7b8wafi5MM4w75Pu/yX22gLXngE4/e9lUekDL0UHagx6V8lLqHtsZkh0q0WGvc4+BbwJ4ixMtB4qCwe0zZ9HKcjZWE+L2xtmSKEyp+GOLMy08OZ9qsOZ/QWUeoEsDxq4P9LdlhymwLZ4hPJjAkgxzmC7EqzjEcDgcbL6pUmN/4z/WvqYNyfqISMgdqy0/oz7iyVfUTysEhiU8X2jM/JieDlMp070loEd2BORHoMpbdEjOvg5RJXYOWaROIJS6to27Uns633/0AX3lVUxQS83x73zcpnjqsnIYroslzBngr04UbnrIfy3Dl+L3nNfsz10tKEMQuHG1nmP1qMfNurXm8Mvls7xtLN9mFJlfoX9U9FslQ6PXPrzwFOg2KOGHa26Y2mPZ3Uk+nBKLBVEhwZOmnY7rp2NxnaGbMBGi15bGAlctkwPfLh0uiZvKMIQNBTivFZyUus+8SxEBUEAfOd+WoxkmhhEfDTls5d/pDFC+Dg0bDoGNQzYmBKYUJUCd6N+6auNagY2AzRS6CYAe8HoXG0x73DNXpDRr8Rha
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(186003)(83380400001)(55016003)(38070700005)(38100700002)(122000001)(478600001)(71200400001)(316002)(76116006)(6916009)(52536014)(5660300002)(54906003)(2906002)(66556008)(8936002)(66446008)(26005)(64756008)(66946007)(8676002)(9686003)(53546011)(6506007)(66476007)(4326008)(41300700001)(7696005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D+zoIs/s4cWhPRST5+nTVEdY5755Ky9SNmsGCjJRxyWCXM4oOUP65OkrqoQq?=
 =?us-ascii?Q?AI53ai+Ud325H9qUJS6has8NWHZP9jrFqli1DOhQsF/QXmFwLErWgHSCNfKm?=
 =?us-ascii?Q?o5Gn+7u2I76FI7ocB93UsE/qhnO58MwiEKT5757SbHj1L2UytgwAZl/Qjffu?=
 =?us-ascii?Q?0+zntM5quRrjGZR8hlkDy3W5+WjgLw/TcrnwTFostGR9v1i0HuW/M/1aof0R?=
 =?us-ascii?Q?pFiwOieD3+C499iFn57LOJpojhUEdXZrgKiz52GUzsLXvYHKOW8OrjptGBZR?=
 =?us-ascii?Q?tOqV0B1uG6I7IflJ+WVkIk2QsLQfeuXhBREOtpC6TA4BB1ysJNcBLlrSOL9z?=
 =?us-ascii?Q?/qyAtHFb/AayyToC7tLjJ6xHw4hHFpWA30KLturpimfGs26yxXqFyXxBxnkC?=
 =?us-ascii?Q?tHaSzkPcP96MSsULJMVAYjWnO3jb/hLSe4tFwqV9aRGxM07SWv748zFhao75?=
 =?us-ascii?Q?eONxLj8JEk3NJSy+8uVWvUZe+MeEo/iAGgT6hORkAOeERRTAR3GhUU0mwVBj?=
 =?us-ascii?Q?c4dwEuFNDcD1y30JjuXwGMPfJZ6Y5jkLaTabGrDqv8xdxjPoqDxMxktd86Cf?=
 =?us-ascii?Q?nuoIYPCoJy2A+UBo666wxKKIgmcak6BBmbg5n25MANnVjbiQNpEIBtOmO/sg?=
 =?us-ascii?Q?3lsxRQXCno/wlJjiItiWdEOA2Kn6e+laLO/xB6CcGbu6nlJ5/Bb1mVvA6cWe?=
 =?us-ascii?Q?zg+fHWGeVWy3P0CjL4w2XhuS0cVgqEGyfXzdrV1xJ5AlpzN+0/HAa5TG3uzL?=
 =?us-ascii?Q?7ChSEPBGVtKNGj3/+rz4uGodqA/o1fN2/TCVrtdkJKC1leSuySd4dCUWKhqT?=
 =?us-ascii?Q?UsdPjGEUh8qJVsC/aO6e2XV+F7pjrACkMc8gRipdxqGqdgSELpglw7kaT3rF?=
 =?us-ascii?Q?HPbrynD6ofu7gCSxZ6UP3vYuD33MToww1rfuXKBEj2fd86SazhV2cqayRSK9?=
 =?us-ascii?Q?lQRB5AVDeQyKqcKPF8K829rYgY4DjUIhwRNsQJvhHbhUR8za9k6twLpdulzd?=
 =?us-ascii?Q?X+ewWKjxfEVHpxDoqBECnnzrSga0JJJ827d1Y/qVfa8NLC/8SItmTznrMT4k?=
 =?us-ascii?Q?l2E/pMjyJ2x7R1Cse3XG/B6XqJnYPZXBQryomMgAgAHJNtXMXtyYNCfQ01cO?=
 =?us-ascii?Q?OmlLTxxdxhMrEXYBFuFMbfS77za7f7a10opWHAqov9+GPvqv8k3QUv9anc09?=
 =?us-ascii?Q?UnhIjoGpP6bcwq5fap7OBf9g/8et6Tf8oz17lg2P25U1zqabnbnvItrjyV1M?=
 =?us-ascii?Q?YfrnZAVd5A5aBsHJzQrovjNWFy6tMs5C0OrCgypkvVTJNe5jdkrPNs1IRGls?=
 =?us-ascii?Q?v+SgDmyVqG3k3tEV2sVcnbX+LtGaAyaqU+G5JVbNARwkEXOUiAkz4rgIrUpd?=
 =?us-ascii?Q?6jueQed0kRrFTqVqC3E7y6zq1kFMYbb2Gy0ad1dSdZE2xU9IP2cVgPA13P60?=
 =?us-ascii?Q?TQLwA0XT5WJiWW0mZwEUuxQEKAVohhRtxHvn9Gc9XKIxJhXYBtS8cSltcZED?=
 =?us-ascii?Q?gMzzg4wisWTAiBDqSVxucn8oyNMl9eHVUqJzggbCKq1WDBQT4FZBu/wi9wVw?=
 =?us-ascii?Q?2QqeRXocCU1atCoBe6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa5e639-6162-43c7-64f1-08da7b9845e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 12:51:56.3759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHXep5mUCUtCm9j8KkRKHOyklsFzxU5/hOoVIL5TOhybFngP6jsGFWXlb0LSm9uT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3318
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Joshi,
 Mukul" <Mukul.Joshi@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The comment is not correct. Please ignore this one and review v2.

Best Regards,
Yifan

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Thursday, August 11, 2022 8:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>; Zhang, Yifan <Yifan1=
.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: reserve 2 queues for sdma 6.0.1

There is only one engine in sdma 6.0.1, current code reserve 4 queues togat=
her w/ 6.0.0 and 6.0.2, which is not necessary. Shrink it to 2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index f5853835f03a..a82ddea967f2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -102,13 +102,18 @@ static void kfd_device_info_set_sdma_info(struct kfd_=
dev *kfd)
=20
 	switch (sdma_version) {
 	case IP_VERSION(6, 0, 0):
-	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine =3D 2;
 		/* BIT(0)=3Dengine-0 queue-0; BIT(1)=3Dengine-1 queue-0; BIT(2)=3Dengine=
-0 queue-1; ... */
 		kfd->device_info.reserved_sdma_queues_bitmap =3D 0xFULL;
 		break;
+	case IP_VERSION(6, 0, 1):
+		/* Reserve 1 for paging and 1 for gfx */
+		kfd->device_info.num_reserved_sdma_queues_per_engine =3D 2;
+		/* BIT(0)=3Dengine-0 queue-0; BIT(1)=3Dengine-1 queue-0; BIT(2)=3Dengine=
-0 queue-1; ... */
+		kfd->device_info.reserved_sdma_queues_bitmap =3D 0x5ULL;
+		break;
 	default:
 		break;
 	}
--
2.37.1
