Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1280E6B26E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 03:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E6210E14F;
	Tue, 23 Dec 2025 03:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IVlbp3Ex";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55FAE10E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 03:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD4WohQyPps0zu0cDyLBZIkxDDzt17T2dHSTMa7UdWCKRR0j0qmj3n69DbSJNisecGWA3a0MMTVtzHC6oAIidcepg2TzQIzeMcE+/dwrJqYZxY019abaQ5S8s7qgLrRjG1l/zm44aW9Mwi69WqYetm2bh/b7rsZD0a98Pwap/gzKF2IIEkg46YNsKX2j6YSNfbs3q6KuYUXphQoAHObSvH4P/09aP96cVdEYgyZksxLEB1pfuVCgB7akLkQkO3ZMh4og4cs1cZYNO0luOONw3PiJvW75+lzz/Xc9MDpnheSu1cMwnn6zgOW0xa0QlghG4kP+IJNVf7bXXGDmZY7LRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AabnLI9NhbF6mUnvjaxXbRV77DC6ziLZyXF7dEJ52JY=;
 b=osF4CTiPVRx6S++emF2kfwjrNV8GJwZ6fs/D2gsg4Y8uQo3nWupYk3D5KCdjTmhSCnY4UFSIfFOtursS6tn923NMTvfCEg5FjFHWDJ2Wm9lQ+7KI5j8BzatRfj/od0hEdlec8DqGbAuf8xN8BoIiF79pEAHSf7oT8k7iyWIS24tK63Olw7xfOVakpP8v2pm3kcL68virhVIXPVzPTwKVRX7xQbAgvg7kNo5jqNfZa0VU/Pd5z5+byRgjpSwKBlQFOPXXs9vrpdlYWx7KkhqlVJvUHCp2Raf23/7QPZidKxmPAojHKJfflcGIgwzwTsPMm/64dRpJ8kslPAzMsnS/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AabnLI9NhbF6mUnvjaxXbRV77DC6ziLZyXF7dEJ52JY=;
 b=IVlbp3Ex19ANjde4QY+AFBcxnBfP84Jq7cGMyk5uf1f77xFVhYvD2cEzC/ArFJySE0XLXdSmMnsOD77mMttyP4R5w2SDE7Nyh/70HpqJMjZwSJp8S6JHAzko3dwsoH910uFN0Jnk1FXj8GBvD4HxiuYJMasj8zrtfFIwXLeDVS0=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 03:28:32 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 03:28:32 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, HaoPing (Alan)"
 <HaoPing.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix query for VPE block_type and ip_count
Thread-Topic: [PATCH] drm/amdgpu: Fix query for VPE block_type and ip_count
Thread-Index: AQHcc7iDh8LAdBi9mEO8WyGlai+72rUukNEg
Date: Tue, 23 Dec 2025 03:28:32 +0000
Message-ID: <MW6PR12MB8898579450E0BF5ECD8B7F95FBB5A@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20251223030152.143593-1-haoping.liu@amd.com>
In-Reply-To: <20251223030152.143593-1-haoping.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-23T03:28:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|DM4PR12MB5844:EE_
x-ms-office365-filtering-correlation-id: e6621992-d5ca-4428-f182-08de41d35911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0ODBvt8Q6fLrUa+MWoF1uXI/tFsL63alk/WFvv99Rr7LWln5RfueTTULgvom?=
 =?us-ascii?Q?iijCBFqWIpX5GiazKC1x3EXmkwbpiFJGURJw9Lgx7um4sorOniaI/JLvSzCD?=
 =?us-ascii?Q?fDj6M9NsJXqtjgRo2PSQLhQNz1iVzdw9r4M+i4l0HhsmzaP2dqFIxa/bVDFo?=
 =?us-ascii?Q?qrTCCh38JbHVlxTS8uQhcaU9IkwRfTi/cDAuXJtSL53HdSrjKx0xtHb5Zxxi?=
 =?us-ascii?Q?CO45/rBK8LhyJhIEu4NgbLtOlROH2/rp1q4uitxQ92PKXWT2jne4LuaG/Kwn?=
 =?us-ascii?Q?1+hxlTNYO0o762aXGbhu7MLxbdtWZcDZqrQtI4tNc8U3Jsgn5lapmvz4i7Uf?=
 =?us-ascii?Q?0wvk4s0eCBEn9xqvwgDO5l4QAqoPq9mPg5yWCKX+q6S/kLPZwOBgu/jHK5sM?=
 =?us-ascii?Q?BIvCQ/zsAzAQYGfSMuBJBWQ9ihecUW6nzl4UtAca8teCZxucqCsKF+5bdayi?=
 =?us-ascii?Q?zTzAMPHOroZ2qkBAPTVhBTw9zICgXJ9osCFs7cSF1sCQCKWMWsknc/zcFl7Y?=
 =?us-ascii?Q?7NLKsb7wOIIv/JZ71TzzXH948BiM/UloYMIso6mN2BmBYVGtXecSUMDLjJpH?=
 =?us-ascii?Q?nOzv+VX17dsGYTBbMnEBlEoDisjL16IyK+E+b4XEpd68Po76+pkRZ6iSC78U?=
 =?us-ascii?Q?Iyq1jtWOC4NTOdBqxGoAMxCOcICQuYBjEe40TO05+mWbb6dytfvT0lbTYWGl?=
 =?us-ascii?Q?jGTGLO/oXrYdlMQ4PlZuz21zNI4At+jBSsx6gQyByFpXWECtVtzziHXGf156?=
 =?us-ascii?Q?BRP21C4vCcv24TZ/yl/NfzCAjDqAHQsbeR5M+FOxJTOh6At/Jp5X/agvCQo3?=
 =?us-ascii?Q?j0x/6ZXzUi2C4zoLJeNuaZTu5SImsfv5k2TC2HwVEQ/GB4aKmTrexbsaWteh?=
 =?us-ascii?Q?NtK+bpNlEYLcQ3MFfywdGQI1QqMDvYGUjyjMp9jXq62IT1m+4mH/hAaxxv2O?=
 =?us-ascii?Q?yEF0N9PLMTWEwzWwivnfmCAoYME3V9U9HAyEyVf0NWJqd3/fIWyyAcH+FEH8?=
 =?us-ascii?Q?GcBXc83YePQRcAR/0vMAA//nKuZA3JtSW6x9eD3PReL9VGEg/Z90ziVfy/sG?=
 =?us-ascii?Q?Nb4p2abkTdAIPFHm6BO0WHkc9CY8p4bhBLDf932zXXkI5wo+MAkORIVMi1Lr?=
 =?us-ascii?Q?JBHeDtN048hIxLhgQ9aryKe28wTCpj4Ia5Qchyn5DJDZcy44LELFg1p3errz?=
 =?us-ascii?Q?f/8JtX7nhJuvBfuvDDr0r52b9jUcHX2mS5XOjwNFa2Z/yA4OYNHAv/q2JTid?=
 =?us-ascii?Q?Z2d1roMI59H0PbxJnTzCuglN3WhBwBfceo8U7DuSb7qqzdyJgszw70RM+FZx?=
 =?us-ascii?Q?q2K7+MoLHbECgOk1Votkha5VKAzutErNw2cQSEAd6696SbvG1+gSa12GO0O5?=
 =?us-ascii?Q?MVJLbHWyXJT0hfNd33L71Btc9lUDMJIheFoWUxDUH172WU7GeM0m+TDxIFw8?=
 =?us-ascii?Q?B8auaH8Hfpqg6iC3GdU/ytaNMv02pS09GwB7/R/HmoP96VwetuRwR/X8JugM?=
 =?us-ascii?Q?PAtVTESM+HWJ+GLStHHaE3Yh2BEchn2upJu6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9eXclgKZfxuGta/vhv9nbR48thMhO6AHvWhIJbiSbdY9GFYhjUhYZYYwyTLQ?=
 =?us-ascii?Q?hzj4Y7X9xtfYgSdx+TL06TvnqfzDf02CZxNxxSSHuUmajjaiWkjpUuL+0Rxa?=
 =?us-ascii?Q?hmqroqrWEv7RI6Pm/E79ig5IG0iEyzvOqYSVw/Sjz4F92OQvfrjIo9wn1jtm?=
 =?us-ascii?Q?3tUh6jX05Mt6ifZceJ2t6BDFQv7YWMFmzS7AFs0Ze6CRmcp0ScqpTkT36WTV?=
 =?us-ascii?Q?DQdJiFIFI7aSbrI9LG5GycZ3ir4vkD8xiNTkciVKbgpKCOkEqx+ZpQS0joQj?=
 =?us-ascii?Q?g8zisVf/4tt3R7Xp6spnK1WTYV3JKJuwNLHyNZqf16+aMw50UIpT/QWd4uCp?=
 =?us-ascii?Q?C2EFkScz9LH2c+vJdLSR4yZCWHmt8c5+T0otfmQFIgUAre8B6QOBwwyMJNl2?=
 =?us-ascii?Q?4xhRp/WgU65PH1v5NQVwESBSnmWLkNMXnJt02Lkdh7oWpKyh7DJDv1JVDwRV?=
 =?us-ascii?Q?GmIJn1hv6B0jUTlKPaufF2v4adjaieThVa27ls2Unp/pBntEmtD18K4D1Qc1?=
 =?us-ascii?Q?8e1Ese537rCQ/kkvroN6ib8gIOO/UsU4lcw8K980rveDQDE6KgXtEhpY2Ij0?=
 =?us-ascii?Q?WIdc6KBhdYPX83dyhHAlmF2V79Ir6myGhEydGT96ECjfgcyVTa79+YuoI/4k?=
 =?us-ascii?Q?OpsaE3pcn98gjEMRmAyfXOYbifyKXPoA5cq0IYnn5S9zo0PDHfuomrQZgNH+?=
 =?us-ascii?Q?blJG476hCGHh4TVtgMYS8w+Lt94K2fNlayzzp9/HsHpKuuqwcbug2TzCCsEC?=
 =?us-ascii?Q?TCmTSrUOJCmEwhdaAV9up6N8WfYvBYcrHGulQ+N+PVKefavnYwV5OqZJFoR9?=
 =?us-ascii?Q?U3qiGruhjf1ScDegoMzsvvTttBadFldniJv3Ku7k1YzwRtNhn3vphIadbtWf?=
 =?us-ascii?Q?ruzEMHOwzFFfUwGvMMF6NNUG1VUXRh01pEyBNEhRrJZA5Byj6IzHNHptCXiU?=
 =?us-ascii?Q?7AUiUUvJARgqKZI6Q0g+QthFd7uN8XJISn7QZfxteP2sUY8eHnt9Xtk5CNgi?=
 =?us-ascii?Q?64bpf9Uw1sKoKAus9TcyiHlvAIsI6Z9ZT9gGnQBE4H42X9XiMdiDcTuugp5a?=
 =?us-ascii?Q?GEHrE9fRc/bbsMqe9GXb+oDYwv3l8PFiDse0dc/prSwWenJLEqBOAkAaSZhw?=
 =?us-ascii?Q?nWuz51iU0bj832+HiBRMVUtFVpqW4p1fkJ5tqAwQEyIjfqILcxShWddSQgtT?=
 =?us-ascii?Q?srepxaYAp3pSwXpHYMbFj5n127H/2yrV5ObZcxW+93eSk8+LPzDZDy01UL86?=
 =?us-ascii?Q?NYA/adYB9KFom3wVvD8mXmHIASGk4yiN8RoxcFuKoYlNF0bTyWoVocu9ly+w?=
 =?us-ascii?Q?2x7R9syT0Et0Py4kUBKzM5Clav2xswWCcWMt4gJxRw7HxfhBjeW82dSo9yNe?=
 =?us-ascii?Q?Xh7RCxaElJbubtl4pF2vHQBiMP3ZrZTqMaZkvMBzLd6vOczA9Fg7JXmZLfka?=
 =?us-ascii?Q?m4mt7L4tPhLYXi/I7Naz3dYyjW7MhA4tdNKMmhD4p5Ky6Dp4urkB1cSmw9tJ?=
 =?us-ascii?Q?q5UVe9tW1wrpJi8PBKwtT4D1W+CMv1nuhDMVAMVwxVuIFdlNgmiGPRn7XejE?=
 =?us-ascii?Q?z2EQlqQdOoim8rZnsCJSeJ+xPXRwn15R10NNKF0pMSK35woz5NpsumVZBZrb?=
 =?us-ascii?Q?wL18H3hh4Rz18LepdboheGlRXC4QJ5hVwGrSWlOuxRWc9coAY0ETDyI01LKS?=
 =?us-ascii?Q?HJkTm/9exebx4z20JDQp0AwAWw2NWDoxgtl7N51NWW+moIPh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6621992-d5ca-4428-f182-08de41d35911
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 03:28:32.0845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCmOwyE2eAI4eD9bxLlNikQNHRF35TMxIvxJYV4jINf22MOgctGws1yfa95vtybKxreYzk7mZHPYLmeVra2t3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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
>From: Alan Liu <haoping.liu@amd.com>
>Sent: Tuesday, December 23, 2025 11:02 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>
>Subject: [PATCH] drm/amdgpu: Fix query for VPE block_type and ip_count
>
>[Why]
>Query for VPE block_type and ip_count is missing.
>
>[How]
>Add VPE case in ip_block_type and hw_ip_count query.
>
>Signed-off-by: Alan Liu <haoping.liu@amd.com>

Reviewed-by: Lang Yu <lang.yu@amd.com>

>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>index 3d286913e9b6..728033a88078 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>@@ -201,6 +201,9 @@ static enum amd_ip_block_type
>               type =3D (amdgpu_device_ip_get_ip_block(adev,
>AMD_IP_BLOCK_TYPE_JPEG)) ?
>                                  AMD_IP_BLOCK_TYPE_JPEG :
>AMD_IP_BLOCK_TYPE_VCN;
>               break;
>+      case AMDGPU_HW_IP_VPE:
>+              type =3D AMD_IP_BLOCK_TYPE_VPE;
>+              break;
>       default:
>               type =3D AMD_IP_BLOCK_TYPE_NUM;
>               break;
>@@ -757,6 +760,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *da=
ta,
>struct drm_file *filp)
>               case AMD_IP_BLOCK_TYPE_UVD:
>                       count =3D adev->uvd.num_uvd_inst;
>                       break;
>+              case AMD_IP_BLOCK_TYPE_VPE:
>+                      count =3D adev->vpe.num_instances;
>+                      break;
>               /* For all other IP block types not listed in the switch st=
atement
>                * the ip status is valid here and the instance count is on=
e.
>                */
>--
>2.43.0

