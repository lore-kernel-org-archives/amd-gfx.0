Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B80CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 08:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E0F10E781;
	Wed,  8 Oct 2025 08:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TAQKiSOz";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F9E10E788
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 08:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzIKC5YiSRvVpMDo7+UYxPUTb7bYEULPn84JPUpnuCZJnHzoy2XeqeaWeQsvri63Sm0kB6Vzf+WRGnWtRKnvOVN5B0kn29zvC68D+Jqi+JwgTp/f9phLCGcej99oDOkfEBK4RFRfl3ZtVg6nhmfIwAnvKmPS8tOLk8WtheH/oKXlETc+Y1ePev8DxZ5aJCSE9h7Ak+vPdXmEo8DgKwWHzmTGkQPDmetzEWlpxg01hQNDyfFkFi/JhevioGbICNogy9BtvM5UQeFzM4KUH+Gl498woqI3O0H/PWfygNiV7wZYogcd4fCGcYkoP6l2EjU3xieC1mkkwtSu0+okFNkf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eA/OuD5t7zmbKvgkszDGUF398zTbjxhkCaWkHyh0a7k=;
 b=IYaViObXWTjCaDCLvajcrtwcuB+9WCHCGs/3nsdse5XaTnh4aUlChO2la9SocEUFPRliDbYs4llAxtBp9X3iQNng3RWl29Jb2iThPnTtkleQNVotDuRLMppobJhRtkwtqyp8vTTXfcZsOnqclXFvhma8M+CObGFRyNLELWtiS2sds5MYmWAvMq8XV2RfX3cJ9FTejdYiFh/A4r4RVOdBIgIOpXqYt3nMA8CphBOeaS2IGvn+pKVMqud4VN5ay/Ku9Q9CPPrGeNG+/e2OEaOx7+jGPtw8Xg4ISEoUMpLsDWYk66s6jD03x4+b0PWai7FDBLi7DJoCVvmBiJMgjE6fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA/OuD5t7zmbKvgkszDGUF398zTbjxhkCaWkHyh0a7k=;
 b=TAQKiSOztDvLz9wrzWsLHuCSw22pkf6qsorji+6whEUW7C/VEYIHoxMQD60ndJDkVcHd02Ie08b83puJC9Soh5He2vQKjpqVSjD4l9NF77E8CEEi5eojbye46DoAWzD36HKBEjtiqiY6RBA6jXGYCAw/MqUu1qjEThh598tNZ5o=
Received: from CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 08:32:11 +0000
Received: from CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37]) by CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37%3]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 08:32:11 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Reorganize sysfs ini/fini calls
Thread-Topic: [PATCH 1/3] drm/amdgpu: Reorganize sysfs ini/fini calls
Thread-Index: AQHcOCsKDia4cs9LRUiHMpXpEl9hKbS3654Q
Date: Wed, 8 Oct 2025 08:32:10 +0000
Message-ID: <CY5PR12MB6081E8BD13A218AED4302BD18EE1A@CY5PR12MB6081.namprd12.prod.outlook.com>
References: <20251008081016.3411285-1-lijo.lazar@amd.com>
In-Reply-To: <20251008081016.3411285-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-08T08:31:43.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6081:EE_|PH7PR12MB5595:EE_
x-ms-office365-filtering-correlation-id: 8e2fdfb6-27d2-46d1-8a9e-08de06452cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?hesIUVY2ifOLL9CQLDnoTqndmpAOPIa8WLq5odaSoBDM7JpkJGAQipXUKzKx?=
 =?us-ascii?Q?IMEXQv0jCEsutR+mSabE1FXmhMX3EJ9z4/skLm1bPcyvwv8gT5BKv9cg5wfu?=
 =?us-ascii?Q?qONIkQA77KuoeMjR7N7tOz5SAAFeBf5+3ArSgmB1Pkq16OTNcdRM3myvGRXq?=
 =?us-ascii?Q?gJ+3bQQFaMzahG89uMNdj7LnzgGDP71y6HdokGlG/5iIT50n59krIG7pmsNH?=
 =?us-ascii?Q?FeUMifx/8ECb3axfXT/VDN75NBR3BCgshVReM4DQEr9PzLdvSqGyRSC+qkvk?=
 =?us-ascii?Q?bIuks25ZL1nyFJge9fQ71wbFzSImf0xpoUNoWEQiZF94hDiNMhrPhVvrIj3d?=
 =?us-ascii?Q?LhATEikxFkw/gxey51wD2HX1Yb3sF5517X0eQL24hWc05pQ25KLBHBDYXJ70?=
 =?us-ascii?Q?gIcWI5XXqF+4ZeWO+Y9k7iR4Kvj7jMMjWpbE/VqMzFq1EvRrB2qiITZuJ69M?=
 =?us-ascii?Q?bmqubgwb8dO8Q+P6+wJFBxHYnUr4nb/V1diURJiMinerVB33tGfiHwidFj0P?=
 =?us-ascii?Q?orNx7OlJofUTzremdcQe6JDkv39EDkm39fy4beyf569HVV5wgDRgEKyHSccv?=
 =?us-ascii?Q?j6Bxjak5otWzheJiftdTj+bCKW+VMppnCYs3Kd0In6hR68UzTD8heynwWaix?=
 =?us-ascii?Q?1J0pgxJ7cRQySLesXhVgf4AFu6Sp+Q03kTI4yWJsOlGRfgaMM8N6SzmcCMcx?=
 =?us-ascii?Q?Nb5UFJWZDbyYQYlhfchWpx+zlszQu/i9ZqyTx7hLgh4d10lF8/Q8p906q5CL?=
 =?us-ascii?Q?juwK5E0HiEQDi2t2dIYPsoE26hhwzbgK8H7z8a9D0Y5pIl/UutCoLsH36w7E?=
 =?us-ascii?Q?y9aA0ezpoU7Y01+kITnZLlQSawov4FkKdziUe461IGRP0tdSAE25Se0U4Gan?=
 =?us-ascii?Q?aDvs4CsISg6H73x1tOQJotj6NlzqHSlfafarVle2G4KOjy3J7csjnz2Df7Sb?=
 =?us-ascii?Q?h71MaSeYItz1cLAQo0ZY2SAQrSelDThieeCRdePumqSAZfX8qnk8VQq2VfXU?=
 =?us-ascii?Q?Xlj06fShoAe9SctIQZ6ncHY/STO+1UOcZZYDNaUuZhBTo01D0Sdp/VwdMEx3?=
 =?us-ascii?Q?5nDXK90msXKSMcWEjFa9HoJ3Cq0tHgbeHxSVz6SdCiXYRPdF/J9o+BZJ+7Tn?=
 =?us-ascii?Q?GJJKO7gpVyYTYbYC8gq9iJDTjdBlx4BCh2ZQlD4f0RwdtCO2qVYdBa/GLi7X?=
 =?us-ascii?Q?SN7zEk6sqGJdF3+dNxd9ExNb74egQ4D8nVi0K0xFeLPayGSPz2EZxFChXcM7?=
 =?us-ascii?Q?t6lbk7HUoiCeykracwRY/flE9UbgwMa+kZOEmhvvAklCEunwUFv/TbO90hvO?=
 =?us-ascii?Q?IjV7n/CYSJXCsWNqaQAy/jjZSaChye8fTKsaQcPI4+FCuFQ41dsXbebGVUGM?=
 =?us-ascii?Q?9atbgsEo1grhuHwfw15QWtvoYN23cOKdqpU+JLyEXfm3NSuFtPaNTjI368Ye?=
 =?us-ascii?Q?k/7asmzHRIjaiDy/5Vathy0nu8hOc1UU8TUpquD/6YE911VbyqgWC9o/n7u6?=
 =?us-ascii?Q?bPphqZDDyA+ofUbQj199HpnquVdWAtIVOWE3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6081.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iTdjK3MEzFvkV8WRzRUO+CXJ7vH026Fnc7LABTxJGRcCShlCrmwxI+mo0K8Y?=
 =?us-ascii?Q?vNOe1H5ai0KtmPTkEay0zIUXWSDKSIQ3rOVdMBxzpIHewZ0JrQfanO1S+iSV?=
 =?us-ascii?Q?4ISFnlk1cCmpDL33oTMhwPOd+DGvMmdbvZqBCqauNUM8TY/jCuWTVVmKWFiT?=
 =?us-ascii?Q?UUcaMPIaELx8czNANVGwNQgwnP/46txgkPAkmhdlMb3qkDv3n88ad1DUoZtG?=
 =?us-ascii?Q?l0uzLFpgy4vWI03w9yZYJo3eKattceohTB28THyuezla8LHA1VzWjQmU8OBS?=
 =?us-ascii?Q?eMOeDX7aWBUYghhLr3XATsTGXkDpOC1m9L8cM4J7MejN4zAJ4xVW8pjSF46k?=
 =?us-ascii?Q?uS7sOVxF7N+zIWxVO/co6zi/HiGjquzadrGSy0t04xVILg2tc9vtU1CFHcfw?=
 =?us-ascii?Q?HvhufwAhUzkVx8b3VdVldbg2n8mbZNMRyN6Sq9i5MAfjyM+L0ZQQxugiRdu0?=
 =?us-ascii?Q?bWqUhL4Tm5TVPIjILdXVv/Ml6yFIQjlNElBqupYzPL/gZY7hgqJQDZHXblcC?=
 =?us-ascii?Q?8r9vx8Mcp+oZLwZcPDirJTiEffD6gJVigz2yghenVCQRie2g496rqsMQf3+d?=
 =?us-ascii?Q?QjFB1ElOJinWoZV78IkCCZpkvXziXDr6qmwuMxQc/eE+cgMm0LViSpFUu3VA?=
 =?us-ascii?Q?abCF9AtJOCqvliUyB7Y1k1+wuZx/09ktbmLfkrsWDSz8b+tF3N/zXaYtQr9P?=
 =?us-ascii?Q?hZjkarsnS5g7UHtvgquCHcMUWqVH2KGDmRybakWGEWsV9IUQgu4tiu4uX3P+?=
 =?us-ascii?Q?wMdpqo2zVoMvfAYLfmn2CG2eiKexYdebzgWJ1xHYHgLJSo2Sq+f2ZcP8ETtS?=
 =?us-ascii?Q?rCQTUy7Hnegc/ks5UMh8YZQoT9fUDzHCLAfpExdVir40ajzysvtbrwmUK02i?=
 =?us-ascii?Q?ly0U7nXYi2wchnQA3j/2224WlRk2qlPkzhqt38ph/7AdTsGJZuXo1asxumes?=
 =?us-ascii?Q?+KGqbOxKdpwX6e7BBhKKQQ0BTCnUS0VlZzHlX4X2dxcYS3X6KV8qR5dJtZSY?=
 =?us-ascii?Q?4OAGKtwEHvJRXUEKloxzog0J266FhF7VHPW8zNcH7ee9aTpFqRuhEtp0WGKn?=
 =?us-ascii?Q?JdW+jG90O3BT8G95r5sOEhzgSdDTQw0BeRVqOVh/QJ8bNCTnCA9nNxoetIFj?=
 =?us-ascii?Q?3Z+5v+j2cFwM8QMVgsU6mqhMbujoUZscFcZiIRcf+AjM2SZtvWppA+9SbV4T?=
 =?us-ascii?Q?AKvJEq5mzPnokLvaIYymDpYcioQivj+gmsYFvRwe63tYBeEVhKFZXzIIl8eV?=
 =?us-ascii?Q?kjMs6mj1Eo4GQLlJ9heBX5QC7hlT4ZAMDUR3PXaFOQ4If0MHd1R7qu8FbgVd?=
 =?us-ascii?Q?l6+2sACgZhY6WG0S32r21bhBuK0EnF0OkBaVllUDLgaOaGCVYBmQIFxqGsUU?=
 =?us-ascii?Q?ayyRqoouk2wJepf+NtV7p3KZCAdOf1Y7ux+5SaqVhpBX4ZkuXBQU2WX9nu15?=
 =?us-ascii?Q?FR853iZKzTw/asFMH7L7ltG1p6trbOOmWO8yxY6ODc67d/pSvw+6BLcSIBWx?=
 =?us-ascii?Q?SscwHIEd/tnTo05XiaINhWYoXue3A277O6Aybwy27BSod3zRFbuNJMpOuFG/?=
 =?us-ascii?Q?faEVSM9wC6t9/Q3V50g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6081.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2fdfb6-27d2-46d1-8a9e-08de06452cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 08:32:10.7643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9Fs7WW6U5aqZOZW3VDhvPX+G2pjJ0Ka2hin5N5ZynCxBdgZHF98YfQLdLivAHKEznQWwr6OOOE4K5+lEmbqfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad


-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, October 8, 2025 1:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Reorganize sysfs ini/fini calls

Aggregate sysfs ini/fini calls into separate functions. No functional chang=
e.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 88 +++++++++++++---------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7a899fb4de29..7e428e7bffd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4384,6 +4384,55 @@ static void amdgpu_device_set_mcbp(struct amdgpu_dev=
ice *adev)
                dev_info(adev->dev, "MCBP is enabled\n");  }

+static int amdgpu_device_sys_interface_init(struct amdgpu_device *adev)
+{
+       int r;
+
+       r =3D amdgpu_atombios_sysfs_init(adev);
+       if (r)
+               drm_err(&adev->ddev,
+                       "registering atombios sysfs failed (%d).\n", r);
+
+       r =3D amdgpu_pm_sysfs_init(adev);
+       if (r)
+               dev_err(adev->dev, "registering pm sysfs failed (%d).\n", r=
);
+
+       r =3D amdgpu_ucode_sysfs_init(adev);
+       if (r) {
+               adev->ucode_sysfs_en =3D false;
+               dev_err(adev->dev, "Creating firmware sysfs failed (%d).\n"=
, r);
+       } else
+               adev->ucode_sysfs_en =3D true;
+
+       r =3D amdgpu_device_attr_sysfs_init(adev);
+       if (r)
+               dev_err(adev->dev, "Could not create amdgpu device attr\n")=
;
+
+       r =3D devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
+       if (r)
+               dev_err(adev->dev,
+                       "Could not create amdgpu board attributes\n");
+
+       amdgpu_fru_sysfs_init(adev);
+       amdgpu_reg_state_sysfs_init(adev);
+       amdgpu_xcp_sysfs_init(adev);
+
+       return r;
+}
+
+static void amdgpu_device_sys_interface_fini(struct amdgpu_device
+*adev) {
+       if (adev->pm.sysfs_initialized)
+               amdgpu_pm_sysfs_fini(adev);
+       if (adev->ucode_sysfs_en)
+               amdgpu_ucode_sysfs_fini(adev);
+       amdgpu_device_attr_sysfs_fini(adev);
+       amdgpu_fru_sysfs_fini(adev);
+
+       amdgpu_reg_state_sysfs_fini(adev);
+       amdgpu_xcp_sysfs_fini(adev);
+}
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -4812,34 +4861,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         * operations performed in `late_init` might affect the sysfs
         * interfaces creating.
         */
-       r =3D amdgpu_atombios_sysfs_init(adev);
-       if (r)
-               drm_err(&adev->ddev,
-                       "registering atombios sysfs failed (%d).\n", r);
-
-       r =3D amdgpu_pm_sysfs_init(adev);
-       if (r)
-               dev_err(adev->dev, "registering pm sysfs failed (%d).\n", r=
);
-
-       r =3D amdgpu_ucode_sysfs_init(adev);
-       if (r) {
-               adev->ucode_sysfs_en =3D false;
-               dev_err(adev->dev, "Creating firmware sysfs failed (%d).\n"=
, r);
-       } else
-               adev->ucode_sysfs_en =3D true;
-
-       r =3D amdgpu_device_attr_sysfs_init(adev);
-       if (r)
-               dev_err(adev->dev, "Could not create amdgpu device attr\n")=
;
-
-       r =3D devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
-       if (r)
-               dev_err(adev->dev,
-                       "Could not create amdgpu board attributes\n");
-
-       amdgpu_fru_sysfs_init(adev);
-       amdgpu_reg_state_sysfs_init(adev);
-       amdgpu_xcp_sysfs_init(adev);
+       r =3D amdgpu_device_sys_interface_init(adev);

        if (IS_ENABLED(CONFIG_PERF_EVENTS))
                r =3D amdgpu_pmu_init(adev);
@@ -4961,15 +4983,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *ade=
v)
        }
        amdgpu_fence_driver_hw_fini(adev);

-       if (adev->pm.sysfs_initialized)
-               amdgpu_pm_sysfs_fini(adev);
-       if (adev->ucode_sysfs_en)
-               amdgpu_ucode_sysfs_fini(adev);
-       amdgpu_device_attr_sysfs_fini(adev);
-       amdgpu_fru_sysfs_fini(adev);
-
-       amdgpu_reg_state_sysfs_fini(adev);
-       amdgpu_xcp_sysfs_fini(adev);
+       amdgpu_device_sys_interface_fini(adev);

        /* disable ras feature must before hw fini */
        amdgpu_ras_pre_fini(adev);
--
2.49.0

