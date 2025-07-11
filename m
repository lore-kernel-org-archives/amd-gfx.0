Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66A0C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 10:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AFC10EA1A;
	Fri, 11 Jul 2025 10:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ft17NCaG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB10F10EA1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 10:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLz11spI1BUJAmoyYdkGK7vEy0nDtitJYUkHrnTWw2x99cd7ChgCDZBuwThdFfi1GL0sZN9S5boReBQmPeh0vDkIly+kIllHwsiS846sH6QMLOJIdNt3cm74jb6mnkZaY8jQX9Or4hspZDz86uMMUFMtanPlA8kYMptESr9Itu6SdDoilgRA4W6in/y2lqtUEXx1hPcUCmD0B4HnzCXZLZDJcD9b1wdJZJNcUovISIVvcUTTV088dH5Yj82sPYX4osCAjH+KLpHavFx3YkOC6vgbpV9evGF7cF8K8LarWw6SxPZxR9RtCYIc61osPWsU/xcbwOFrZ3iLvCEFWApGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld1l5JTCnoG39MtLAK5t9hJWN/0C6EIAVgtUKFfqQVc=;
 b=s3TSqaCKXMQZ5cz8PUlSgWfonliuivqrmcVzO+weHBA9Qyn5phU3yZbl2MFrZZ46Nl/nVfgmNGKM16JDNUr3B+CbLomgRDvSZMcOo9BX0vvGm2+SXbM5m2DL71Apt+lB0xBmFKXzoMKtHkkpceeW/Uj9YdNthR4Fb1Tsyq4dYRyqZK3zYClug1+iZreF/rgNiIQflORJhqkr+l9gKpS57CdSTeufGlP8Zv5cMkyYgxTz1T2d4d5dRK9kaCGg/iJrImP8n/A4QPy2crwuErCiKiYn6Czs+nTNJsmJCSbD6oOM9XntrjkI2y4ptvRP6RIzcoGVGZmNtWK0k8XwDhs/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld1l5JTCnoG39MtLAK5t9hJWN/0C6EIAVgtUKFfqQVc=;
 b=Ft17NCaGNt2+HnUsEwmHH9jN9g+xQX8Gc5LK5gpnvWvuTBvI0IhAcSnYgkjP9AwWKCL+QOGPQ8/TEz7BRs9g1+iY0/8JgYxGJbDxhycKM2Rq1Fcerdr+FJ5W/fdopatXNMi0eAJamKE4af/wIF00v51l1q/ab0//YPrgOb0s6AE=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 10:22:41 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%4]) with mapi id 15.20.8857.022; Fri, 11 Jul 2025
 10:22:41 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/6] drm/amdgpu: add support for cyan skillfish gpu_info
Thread-Topic: [PATCH 5/6] drm/amdgpu: add support for cyan skillfish gpu_info
Thread-Index: AQHb53CTKBdMd652xE+Qw6rEUHr4mbQnqZxQ
Date: Fri, 11 Jul 2025 10:22:41 +0000
Message-ID: <MW6PR12MB889876E593C85C19140D5581FB4BA@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20250627143342.23856-1-alexander.deucher@amd.com>
 <20250627143342.23856-5-alexander.deucher@amd.com>
In-Reply-To: <20250627143342.23856-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-08T03:56:35.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|CY8PR12MB7435:EE_
x-ms-office365-filtering-correlation-id: 9a845732-d28e-436d-6a68-08ddc064de32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3B/Drs0sd79B3qpv2E9EjlwLw8PBJ7Rsh2FqHBe1h4VGwFHHUUMrOugVi7Yk?=
 =?us-ascii?Q?ljdxh5xigmQacsHEFyi2TtOXWUtAT54W17Y4W3ip+jInfqAW+naSvFGljDIz?=
 =?us-ascii?Q?d1kyQjy5Hwji4BhmYk5B3HijIq8E9K6BiTrFQLGGvYTpy2WaELvf1z865POi?=
 =?us-ascii?Q?JGTck/6NJQ+4uoN1cxWxAgILbjYYbV0+/zP8+qXipZk8W0uurm2dDp9uy9IA?=
 =?us-ascii?Q?p+DcG5TaVYmBp4Z0dj4viUYUDPRdB4atj0F42NSa26AoJjYt5F2Q4sQpcim9?=
 =?us-ascii?Q?LtTLDV/E7dcs9gTljvugOTiaEHmy5NGSLXokc539j993H8QmgNpKhyMFDfj1?=
 =?us-ascii?Q?ga0DZqSwgELvHgQg81+RlCFNz1D2dFgdBgCnaA/7gdTcaQMEEpnETd1JcU16?=
 =?us-ascii?Q?t2/1C1ZHnMBVFvkyH7z4pWziwTTnA6M8twLMPO3GG6kKBdk3BElx6rcnLtTn?=
 =?us-ascii?Q?gKqJRnbXYK1HdEu4rL3p/DndI9ZqrmWSRdx0GoQ25asLnEgpZI0gA76m3ECD?=
 =?us-ascii?Q?cHs4LBHx4qjslGOYjM0Ad/TrFN+uGlAM19aXQ0vwdXmxs5TWS+802+cLC8C0?=
 =?us-ascii?Q?MGb9dy/AfWQAUubsHsPDrlY+NhzWh/evZH0CnHnTID2MD22rjf+jmiTJTpIn?=
 =?us-ascii?Q?NY1avA2M4e2tc+K9Gj25UNoeqyVlXkuNa7p/C5pm+IDYM8J95l2z7AxBgeR9?=
 =?us-ascii?Q?Rcm2gXzZkruUC3+1PPf+SBeKp/fCJExWP/C7u1dO7soJYw83mLihlft2KsXM?=
 =?us-ascii?Q?o6Sbf6wFOGfaYCSqQSgMN6UbuttZpuEMObHSeeMdbWiwiV66mhWw+1C0AHhe?=
 =?us-ascii?Q?KTr84CWq5MM3jWNIUaI0QwULlB3x+KcVMa+WATnO10V8bsjyd7v7tEvptirR?=
 =?us-ascii?Q?jtc5nr6Rhglrd0NaDPs9YcDoJCXlG8WAJVPpVexwgcFMN35XBphjc4L45m2K?=
 =?us-ascii?Q?C90Z/56kiZRw5vnw3p4izf4RzOpp8tzxMMAZajgK0YcjZ5eY5zBlqyrFKPeZ?=
 =?us-ascii?Q?XTMWLNZ8qsEFOsuJcL0q8ANdL74sKFFUBNx03wiRtARMuEQQmYkz3AlrSCbz?=
 =?us-ascii?Q?ve1xrhGpCMBZIo/efh2IjCzWyhxPuhMpzW9UgfkCGtDnE7ahQuFqL6DCL8st?=
 =?us-ascii?Q?aoGXnkkUUGeBVoDXvjak+PPtuAlLn2yPLZQQKxoDNmgL8GnFw3WRDHWPGJxj?=
 =?us-ascii?Q?GeAXlS9zmYzSbLx4nl/tBbwCdGlLl+Kd2862OLzgfL7bKXwZgg8u5LSElCZc?=
 =?us-ascii?Q?vleH5InT8Yrk5WpGVAn+3r4IcQuMxWSVx0CssrBM68UHoavO+x2GVYFKgQI/?=
 =?us-ascii?Q?qEffqMFfNtAmy1/7a5h/1vXhdIfgQP85EnzKFwuZfET38CeskKQdZBVKme20?=
 =?us-ascii?Q?1iqotJ3vKhaElLGtzgtptI+oJTYrS+P4shErSH5fDML09Els8uUKj4V1ThHv?=
 =?us-ascii?Q?ct5Rpmf19cR2+ZWd4/HoZ9b01CxlHLcBW/mqfpPhLcgYJKl9jI6w8Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2XhabzwqUJFPlgfc8BOICNdPq2Bx2r63AyrkVMlKPOGoSTIROfHHje6X+vlq?=
 =?us-ascii?Q?bsTf65VN3zDj+9SY+gYjsktsXEZiKAnkrEuET4bvRKaED2MSI5eGWGBP6YdM?=
 =?us-ascii?Q?yoAuA+GZ5j4Pn1hzjTzdDJLgia3hMZ78uevGMnDmjLGeoQzBU4SQPvsWFei5?=
 =?us-ascii?Q?TVFlgWdrfbo/Ap72kCpDxRjOx/B17/jmhv5cSnZOF7XYZ7PREp8riOEFFqAa?=
 =?us-ascii?Q?CBFVhNlR9pmrd7Dy/YhGVxjg7IUfgC41y9pWJv2s0wm6TzN4KwrtStxCIEPy?=
 =?us-ascii?Q?tSrBDZ6dnOkcpbQ9EjJHz8x3VuLpFVE4yVixcsP/hVDNWBIYoLAdVimd1j6n?=
 =?us-ascii?Q?HJEE1Sxbn7ZOa8OB0buu18enYVsNGL2pvDA6T1N1yN4ZBaVK+fTMqeGLuTjE?=
 =?us-ascii?Q?a2M1p3lmajikOOBVJ1cWaTkt1WCSOCDNuCTAi+A7m4jxRqVVkSBS2FbtbLD0?=
 =?us-ascii?Q?YPwb4RcVIYDuO4I/+Vk/LROPe5pmGSx0i7SGnqtuR0fSyJLTpwqLMWNd6LjC?=
 =?us-ascii?Q?SJ4hTwUPb9ATssit1lxhsyj7OoPEBYNF635Slv431yBrdYW0dm2rlRkH27Ur?=
 =?us-ascii?Q?EuolyMWQrvxBbFf3X4UPYkTVySDL6AkS1aT7K0cVn3f/qDPknFwAfxgB83EB?=
 =?us-ascii?Q?btW3/nJjcdD1r7P8vP2wKvCkJkAsB0aZId96nTFdNKKUNpIImNqNZt3KuqxW?=
 =?us-ascii?Q?uhMKAIRmwFPBYnkwEEnwaFqp5hHPMUavXD+GQ9nG1kyBhJJTv/HQZVCQsdJc?=
 =?us-ascii?Q?z2zEzB9VuxFMRQS5FMldFSZchui2uSUIGnmvn6yBN+RBEPhXuZnbj0tTJMfJ?=
 =?us-ascii?Q?PCUzH99mCQ4H3F/udhp0IaksG/kyp/sN9l/i0GalW4dlDvyESZ5GjgJp29pl?=
 =?us-ascii?Q?2FGDa8ZYnDXauT7dEaL1KEF+BMTzJIP+RDaysZnfbW7lxnok0RssWVki3JLc?=
 =?us-ascii?Q?87f8g3zXV5siPEFsBtk+KDlMbEDSqDS3iOLndQw2CL0ydOL4NocAr8+wOgUu?=
 =?us-ascii?Q?EHY6Yk3ga4mAXPJjc3AiC9iJl1FiskS7KBlHvNcEfzK2pS9k3j0tyud6dFJC?=
 =?us-ascii?Q?2Yg04ulkVgOKVCXa/ZNPqVyUz2mUulqzzVWNr1f9lJhbZ+bKQ3gZeb0Czptb?=
 =?us-ascii?Q?YuahzZgkINKL5NQjTKxQvrfVmBmEekYYL7u133/hWwSjfFORRrzDYDX0bm5V?=
 =?us-ascii?Q?khrmsiVue93YmwJX7gyi3wuVVAEYOI4nc4460ohxVPWeWQSBX3WkzQwYKv8m?=
 =?us-ascii?Q?1zAku3TFeIrRE1Yf4EQoAVtwBzQTq48yhO0PDcV/gMccPx6V1qh0LuFs3gKz?=
 =?us-ascii?Q?IejEZDfUNVRlns77LwkK1XLRs+Acbi11iO76ts4r4JOq0xhoqpfP8xDf1D1F?=
 =?us-ascii?Q?iR0hcBQbTIE3ghX+cgF2Q7Zs2+431b3HRvjjBUUpcRU/lYN2SKiuq4ZTycWi?=
 =?us-ascii?Q?z/U2PCBOV0dNdnlxsMBnFcO/b10uLd6XKaotkt4Yy2Sh0m0ibS6UkkjJB04q?=
 =?us-ascii?Q?B8PWU9RrPMR7owImkXW2EZXrjMi0PfmySCG5TDQmh2BXDuyZCUO3ib+opruA?=
 =?us-ascii?Q?Zq99u6F0sDOxX3qdgHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a845732-d28e-436d-6a68-08ddc064de32
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 10:22:41.3342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cymzllgo3zm/Yh2wPCB2m3xh6q3eOHCue0akuB2NTPgbeD/v24nA+IRUSk+xZ+50kpjKYva/QPSchZU3H0whzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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

[Public]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex De=
ucher
>Sent: Friday, June 27, 2025 10:34 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>Subject: [PATCH 5/6] drm/amdgpu: add support for cyan skillfish gpu_info
>
>Some SOCs which are part of the cyan skillfish family rely on an explicit =
firmware for
>IP discovery.  Add support for the gpu_info firmware.
>
>Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index d1b122090b3d8..758e51505b3c7 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -95,6 +95,7 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
> MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
> MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
> MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
>+MODULE_FIRMWARE("amdgpu/cyan_skillfish1_gpu_info.bin");
>
> #define AMDGPU_RESUME_MS              2000
> #define AMDGPU_MAX_RETRY_LIMIT                2
>@@ -2603,6 +2604,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct
>amdgpu_device *adev)
>       case CHIP_NAVI12:
>               chip_name =3D "navi12";
>               break;
>+      case CHIP_CYAN_SKILLFISH:
>+              chip_name =3D "cyan_skillfish1";
>+              break;
>       }

It would be better to name it "cyan_skillfish" which follows the name conve=
ntion.
E.g., raven/raven2, phoenix/phoenix2, cyan_skillfish/cyan_skillfish2.

Do you need to parse its name in amdgpu_ucode_legacy_naming()?

Regards,
Lang

>
>       err =3D amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
>--
>2.50.0

