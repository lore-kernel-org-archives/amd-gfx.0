Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E90C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 01:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72EB10E046;
	Wed, 19 Jun 2024 01:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2QwLmBRR";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81EC10E046
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 01:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRRBcVarnx27Q9GM7v2WLZHudGErHVC+D35b2ld/Fcu72Sr623yhRx08dBcf8KQETSXxJhQTY8lWAdnAz6r8XZRQsEQKSgDLdypkbZkQ2wqFuF7iB+16+bIb0mlON61zsBOKqz0DQvBeameY7ADP7hBU32nLlwfjPIyJzEv3VcdK9ThM7vhR2dkz+P/iu7zHAxcW0naENRNNFa0glbKpC/dmM4NcrnYTSt8qqOlyV9oZd6prag1tiNr8A3fKTHF1sybMpiGrdVLljeRgWV2Nqd8Yg7sLKIuU67PEZBbB1fek5W/UzDKxtFU5llNV6IPkaT+6TGuOcXWksKmia4Qdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3sTHlaryGpkyKGQPMlfvL923zO+MRaAzJUFrmfcdWQ=;
 b=N5y1qzWlYeqxMIASnVIwh0rHWjN4RcyfM11a1m8p4UYwpAQVR3TulTKdq0MTRNgNK65dCwM332m6VX4vOM+b1GxQWZNarGT9ucakLGpf38Y7vxIS+Usf1Cz/gR+xDwBLrJANSfg6Mm5KYqp24UQmwhcbS7erYIkbwxB8aJaUjIr26TjVzCezBWrwTCq6lUurhVFQz9txcsZ7uldNnbcOR+kPtbt6zNO9jBwTyTZPPGlnVpEVFu4SafNK0A2L8ZE4AQVM2TYY25AGuGX7EL4HX4hWVtgjgmBZ7LKDjnZJIk21k/bzc/vZRVJRFJh5W0H84GLG/4yKPsAYEfVufpTZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3sTHlaryGpkyKGQPMlfvL923zO+MRaAzJUFrmfcdWQ=;
 b=2QwLmBRRQJwmM+87/yoeevJ1Ek6uTTvWBcLViF/ZvOxQodo96GLlpIY45eKbOe3JukAqqKXUnZkl0MruUWzHYrPiQkHdxyvA1WWY7pJ8cc+OVzkitnzNYKBjdYFxcEsqaxHexkZj8q18ho2p++PZ+H78029Jekchnyuo7j0dt84=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 01:46:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 01:46:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/atomfirmware: fix parsing of vram_info
Thread-Topic: [PATCH] drm/amdgpu/atomfirmware: fix parsing of vram_info
Thread-Index: AQHavoQOctWboLUXtU+n5VSmju1D8rHOV9yw
Date: Wed, 19 Jun 2024 01:46:23 +0000
Message-ID: <BN9PR12MB5257FE5C61E491903431A091FCCF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240614175458.459062-1-alexander.deucher@amd.com>
In-Reply-To: <20240614175458.459062-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f7421073-6c76-4083-a04d-075c8ee3a1b1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T01:46:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4131:EE_
x-ms-office365-filtering-correlation-id: 9e82dc19-3096-4999-ea6d-08dc90019fd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?txpb4eDGuy91Vmtnq53tct7gdR9a1poKKEQiB1uynswsKP3iKubi0hzC2HGM?=
 =?us-ascii?Q?iG1mlH0grgpyZDFu4FLEm2W11m0UPeSVJh43iD7zWF2ErkpmFtW1OhpUG5dO?=
 =?us-ascii?Q?cDxSbpHzHUdUt74VdUwT7ijyJCJRBZFQqmx0Y5t7jfQo7XCdeNkMi976y5dR?=
 =?us-ascii?Q?nUQX5YV1STz3i/jivao/tcTH5WpgBUNgSwiXszxuzLBhNrozCFGD9lbP5839?=
 =?us-ascii?Q?SOXo37RxrEgIjSNcWmA8vuNP8B2lGcc1NczRGOQBQRaaQEgK/z7k8yHaiuMf?=
 =?us-ascii?Q?efk0i7R5TD8pgmIZuGU5JAUK24CfTtLgeK7Sw9Bw2KvZtoevfREh9GMRmSvn?=
 =?us-ascii?Q?INqORRd+rB8nfVpqxul19eou25O1/1y6LwNA/5GV2ov6gj2ptXAyeML2nLqy?=
 =?us-ascii?Q?hBz+JNSRSKmQJaV1k/JCZ0jTsceRijc3n9u6CDXFpRtXnF5m8OvxrfXWXRAl?=
 =?us-ascii?Q?tpBWz2JcHlOZ72ASxPbSagYORLCUYObrWjemjMUBc34z24H8Rz//mGmtvS3n?=
 =?us-ascii?Q?gV88KFBNuLQ+ZlO035jpx3N1FoD6yXXnOm2DHxqx1n05clp153X/xC8OAwS/?=
 =?us-ascii?Q?bgwZxevTfsjF1Kcg1Ry6nBPBTa12Kg/Ky7wAtIzT/Yi8uHS6xtU4SFCjITRJ?=
 =?us-ascii?Q?Uh1zFJXF4mudUwMF40rOIu8vb2KsktXr6jUbkSAzPHU1D5MaRJrU0h1kCaYc?=
 =?us-ascii?Q?LFxeSSpMkOBuYlCESuTIWTymGXiqZTUMC/0rQa0KGPkVzc15Ll1me51fB72D?=
 =?us-ascii?Q?NVXcGyNzKsMdKD7AybfKm1NMVb/JxUzDx/f0LCP8HYhlZA++YayNKg0oIB0c?=
 =?us-ascii?Q?5S5I37ZBOABbV3mwFPvKPH0kMTsjnfEs8rEq+9x2LyWIuVrYJ+rR++Qgxb1a?=
 =?us-ascii?Q?VRwS6HeoY7mGQwRTwFPoRWuTQZ+YA6xSjvfm2m8oNmtBCW4+DcbFdN4xVkTa?=
 =?us-ascii?Q?I6/fRW1VkKJc1FzJjjh8RUwFgxzYbeL8zX2xnjVTp0tjbwdf2QmJp50/Q7pi?=
 =?us-ascii?Q?R5lqtQQuce85Ue82WmvXVf56uGApU4YFIDBH9DmxqC7caCpnYBTKqaYy2rsu?=
 =?us-ascii?Q?7FNLfkrKypmT9pVIS8fQtFk05jra6mgjtXp4i3gKSzUvih42WSVeJS3wrxX8?=
 =?us-ascii?Q?gVkD2FmwsuGeWlBELS7aVyOUBLAqkhOzpPqVSrpcEjJQfoujYRPEAiXhxvxx?=
 =?us-ascii?Q?w2eXE/sR4P+X/LIg9rJD8AuRBraq93ZtmWrnp8WPzykfNHnP+Y0EORArg9aP?=
 =?us-ascii?Q?j924UBxWi5ezBiqdJw1WcsIWgPLLfQBUAWg0SGJBhywCeGH9wrKXKo+qZuoC?=
 =?us-ascii?Q?JSNJC7g3RLaoHh103udx2WiC4PX5U3D6s7tJlKj43vkuxWiKSGPYuEX/djzI?=
 =?us-ascii?Q?vFCQhNY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aJiOgBgEjmDo4HnZTIwA5P3mzKtT/Bpv83buokd8vNP01JX95IT/Q71V7G9b?=
 =?us-ascii?Q?DgY00W/dvgeIwmN5rYPKuxHvLNLUciLS78n1IRKOHOzt2g4dfYgIGz6f4CEZ?=
 =?us-ascii?Q?hsLYXfsVMWFB5UKxAQAr7N8Jj5NI6sja6xRTqv8wLe1VlOSTmjq9K7cH5UES?=
 =?us-ascii?Q?Y4zCJyQ9v7JsygDHwJTRsCwpXCi0QuF1MHdAxXPpKSvD+2EnZUM7aKsVKPH/?=
 =?us-ascii?Q?iJFeATt1Eeq5+93ikCE8/zE4SJbylHhZqbumhcdBeydJQK06AM9tGlMHkQZO?=
 =?us-ascii?Q?uPf1FJ4IRM40jHjmcjlgUqqD0Z+tGg53St4ggARW0YoF+l1QV80YHZj6AE5s?=
 =?us-ascii?Q?Jg2/SWzU7jTEM6nUYGI8l1xJ/qmh/8CkGfQX8qKbRUseVaB1zNIN2AffZTDC?=
 =?us-ascii?Q?NHFStNeWjk2yqAdLsVDBEbGYyRqImAwkekRjt4MubFwRDn/tTNVO5x8IYEBE?=
 =?us-ascii?Q?vaZqbImbBXy8DjyKGfSA1MxcKrYLcf5X8iKJr9vntLDTm02+8xUQS2oT3lez?=
 =?us-ascii?Q?4p9BTM25t/fJPjGLuyQbykgYes9+snqmERMRzaj2O/PzshBb7P2+3dKf8MiC?=
 =?us-ascii?Q?uU5gGv1MPnV3cGp/Ck4OzmPpfm26X1nTU4We8W1QUgLJpXWp+kyn+4tWoHg/?=
 =?us-ascii?Q?vriYT6YmfwXXc3EF77Q1U6V1YsGZ8c7p3ebeOsUHN50IE09k26latJdoflgD?=
 =?us-ascii?Q?fo1cOca8mcnzHG0uR0yQ2uZpDUgT8dDdDJnLwsuXGw8D2q/rBgPtjZYWbgMQ?=
 =?us-ascii?Q?SOTjWEzAaUkZOhN4rYAfYyMTAlb5y/15TIAvnW47UoVHvOIBBLnWQU18ICH+?=
 =?us-ascii?Q?iqF9LU0hFk8aDxrMFPbxYSInnyFsi3nZsijZOAFqX8WIqRDx6BCBX3O/kRN7?=
 =?us-ascii?Q?skZYR+HHE+lXm24pGlJjawLG+RpQxr30ebh226fh1/J10qEf4zdrVCv5Mc8c?=
 =?us-ascii?Q?6XYH5ZqaV+OhE5zG0EGzLCPG5mR73IATLJWz2mKKvQbj76AJo7ysmDhXvS/a?=
 =?us-ascii?Q?7jwn9xMnqz4ZmQ7nv+5lSrsTTc6Olq2PRf/RM+Zxzx+pLW6knnIQJrVgeoNO?=
 =?us-ascii?Q?tEPsaZXgPTBLq0ViZjHGU1pgdNKQArYqdNsKHVCeQVOo1ypSSd+igDOrsJeB?=
 =?us-ascii?Q?sljCNklRakhrOqLj0l2o9YvweV1+zuSNufvyyRLBTwdEclGmYDKytH3Qtbj+?=
 =?us-ascii?Q?qDhHFffFoZvgZ8ekxI1kX6PuwYiaRK6wtTVF8ODnpb6KZoiqncV3svAyXsVY?=
 =?us-ascii?Q?QCD+dALASsID/Mq8jL4KAnRFYiah1vaxB4OdGJ4e6OvPgm66duk8gSPEyz81?=
 =?us-ascii?Q?DItBOYSy7gJXrcIvc4nVQHfFo2UVq+4C3PkejnbgtDe8dfAp+L6HXTuIWSRM?=
 =?us-ascii?Q?avlLsPirzGDnanRWBXRZeE7p5u2OmcThe0PwoEU+GRuPOCqnIRXPa1Eu6bve?=
 =?us-ascii?Q?uJuYshXbz+7xCDPjo3A8UVwqWN//pRtFGSw/UjSeatLOpFQ4xFu7zHZuF8qP?=
 =?us-ascii?Q?iQ4Y3pcvB7paQ5KulAQSnXkxi+INQRlnbThtSoy/stUzmjgGL9mmiIk5n/Q/?=
 =?us-ascii?Q?b3h2EBm5xKoqcSwv8eoieOD7NPdAXZdrbjJlE9tk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e82dc19-3096-4999-ea6d-08dc90019fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 01:46:23.0759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yzsx1uK+78rr9FWgp8s3QdZt/qi4lJU1K83F6ey3MQ4bY8WDVv4zC6bET05KmK5rS52Zd1Rtrfc2me3J2y1vhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, June 15, 2024 01:55
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: fix parsing of vram_info

v3.x changed the how vram width was encoded.  The previous implementation a=
ctually worked correctly for most boards.
Fix the implementation to work correctly everywhere.

This fixes the vram width reported in the kernel log on some boards.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index f932bec6e534..f873dd3cae16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -433,7 +433,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device =
*adev,
                                                mem_channel_number =3D vram=
_info->v30.channel_num;
                                                mem_channel_width =3D vram_=
info->v30.channel_width;
                                                if (vram_width)
-                                                       *vram_width =3D mem=
_channel_number * (1 << mem_channel_width);
+                                                       *vram_width =3D mem=
_channel_number * 16;
                                                break;
                                        default:
                                                return -EINVAL;
--
2.45.1

