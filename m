Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61747C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 06:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA13112865;
	Thu,  7 Mar 2024 06:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8XVmSEl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC68112865
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 06:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK9sy8hkNS72dpAEmZrAku8r3u424QbHfN29/KVc+RMM7/zw/iPYtiNQhI9CYkRyUw18uNnIHvAktTX0ghoYZSPRjpe15s8KBabzgjP3a2navBfIaxJNpwaLAPYz1S4WM3RSjpZVV5vqU1AgFdoc0m0fq8h1r4XdrjCMAakqEXWL+1/YEXiqCefWPBv54lpQmMXg2+PIATwrKIeAUV+Gf0PoVRwbA4VXBnwdzfSXNqReUFJr1Y3xORofrqiXnjQDNUJ2laQwmhhZZee2jb42ZATUFKT+v7PhAQCYnAKvUVN5d8j23WNeDcQkk9otIcohxamBHiyHqeuPCflsU09HiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NNAUJrSC5R9N1z8XfvzvzNWnvbgbTw/svrvyxjFvCA=;
 b=OHh7EuteF+Yx/XDskPH47F78UkBRfOTEstIZy1f4LvGzr0lH8/q0+2Sd+kJakHPUb2f6NNEX029ckOemiSemAJj7EC1x7WvJUMzz6XX5rdSfqDSQKAFGFpKqFuHXApPTmBxHJ5K1wJR3mdmWrObVNH3N+3ddXKxZR6VcAvO+j+bBUAmHEdCcRD29noXKDVXKt+PRdZ/MOFAnXxgfv+fXunE0TwbWC1mfPHW4PGrQlp6/4OssuSfuh1hQOenv0TxzKZWKpN57NU8GDT23X0Gaj9L6p99e7zDdDMRo0W1gZUEoxAex0eCWiyHtFg2LRPAzxg/V0j+tuXuegEe6+1DvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NNAUJrSC5R9N1z8XfvzvzNWnvbgbTw/svrvyxjFvCA=;
 b=J8XVmSEl7C+0hTZLjWxRRGl/7NKbbsWeuvLw+14AuZ8xinaprSo8SfFtpWYyuitBySSkBwD3Mt9S1BTEeIhU1tudFP9TxONmctsAYiINQiZ8ks0iLJLJHoJz0SnlhOSvE9ZtfHGigxnHl4iqOcvp4c/5wXpkULWr9u1ULV7Jxwc=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Thu, 7 Mar
 2024 06:06:30 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 06:06:30 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
Thread-Topic: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
Thread-Index: AQHacDoKq6fLMH8PAkiYJDvgcS3hHrErmdKAgAAvT1A=
Date: Thu, 7 Mar 2024 06:06:29 +0000
Message-ID: <MW6PR12MB889860BEDDA9C3705E4099D4FB202@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240307024854.2244635-1-Lang.Yu@amd.com>
 <CY5PR12MB6369E21D1B58474E7A179834C1202@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369E21D1B58474E7A179834C1202@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bfac0283-37ce-491f-ae04-e3735286024d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-07T06:01:04Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|CH2PR12MB4102:EE_
x-ms-office365-filtering-correlation-id: 7981326e-a79f-4c72-b589-08dc3e6cbb53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5V8HDvkBDII896LDaUUyNqoJAUt+QoxG+2N6ejku08Ot3WuSFvJb4QdDCJdgV334xofnB5fSqy4Wfbjf0hfZoOg5F543bKTju3Cqv0RgwGfwW8nnJGHS8tMdmIIHvLhsbUU68OgeCM9xVT9f22j4SYzt4fOtvhJCNSyCk2JAqSMYM0yrB44pTdafS+b+DPkckA69bi/85iKVHmxMUW0w1ay5thH2Az1/DS3AvVEjct3nccLYEF+FW8gGDkBI+Z0dGgdKlo+j3CwnzC4wM3ied698Tw2Y8OKiqM8qtodzFHIyqknO7hUXEQmai+/jfxGax1eB8XSKgeEm5zZimoWY+KkGv3JxLaeVNZs0I4D42QYKC8+gxRYqNh7urHKKE86mExqlZZI29iMYFGGNknhdHPDk29yKe9uSqeC1+Bv2Pjd13Ug/v/VjWQE+C5ZSvzShdaNPUJ6RoiQZQG+QtKu+4JDPKDgi5/c1ZgcdV8x+y8RoJ+POGpHkwmtwey5W8LaPogoZFRJtxlVi1JIBCPZr0k7L2HsAtgJxSfesmlHHsuVFaCmdGufTU8NQcDUsUw0DpzyWToDRzYzK6fbktYqSQ4FeL+rlqla3xnsRXi8z/i6jTZtMa6Zda4e4AYDc4TTut4ct5lWIQMuUEj9eL3GMFbiyArwOCYlfjCOriGQGq5FWmsUDa9Y2xsxnJ+W0Q1opRaPkNT97pT1Re8zVIGwHS6RH9UnsoUyLTnFbUpqcddw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?37MUoU5SeStsL2MYXKIBq893+ooSPyH1UqNn20NSkMxGwqEqa9cPT7OkRWce?=
 =?us-ascii?Q?fTIbozEw6kkJ4xNhuxIkHLQRZ6C/2ilc/hDAeK5snGsPXNUGd+aDQK9VyvSU?=
 =?us-ascii?Q?3zH1P+o/eaRk8oun7DnhvuGnvtp/QRQn6vbCnoXC/tuAD464os8FOyUQDij4?=
 =?us-ascii?Q?R91VbDzH05YZk4qNMHRJrisnRKfhz7GMYhVnXXl2pAuZknxuRzmt13zKg0nm?=
 =?us-ascii?Q?m0KaedruyPPqE7AuX5+rDKx/1PAXlk0qvOokdYu42WWM7kFzqnBQtXIJNAME?=
 =?us-ascii?Q?4B7YV2LQ7dXuY5lmEKyadO3UfQAoL4FtNuZ37r75xWIAsGhNVyGpUJ0l7jT4?=
 =?us-ascii?Q?L2oBQ3HnKxvD8i1bNBdExQjriodPkxG9J5/JXReo67mlgeFhqwD+i2Awesuv?=
 =?us-ascii?Q?QF/J5J6C7kBivNTIOiYv8GNm/u4LZsBamspNYdRtMdis0C8WYnoWSrAXfOpX?=
 =?us-ascii?Q?QtNbdw6IeFT1GDkiFk4lwf60dR/Y+DzPYnbmG0JqW5CzWSppUTdojrOBjBHE?=
 =?us-ascii?Q?PVwQitKFI1mLfCJPajYgg2q0hFcUSwhq1NI9nV4zGwwXZLPcmpFFaj7T34E0?=
 =?us-ascii?Q?CRChAW2AWvrU1CG3JPj7EzrSBJG2aX8Icz7aUrNZ/n8PmNQqbJU9C2ej+DC3?=
 =?us-ascii?Q?xUFtYrNltecD2ODYc83b3fjh06egVD+Jj/3m3eewd6if2SO/783+tPbzdDlL?=
 =?us-ascii?Q?pTtvl+pQ3ZS1YZ36/rqXyLWwVGCpnzYKD5Yg9lg7xXkRqCtbIykpVJEw1N8a?=
 =?us-ascii?Q?7jem+jKAf0hJfaC5/y9bgXS11sp0CoegOM0A7jpM3z+9mbccrXi/6HF5kt8k?=
 =?us-ascii?Q?DiCJ0tPGoNO3QgwI/1c09E8YiVE5ngzwS47m3imgtsPyYY/qxjvR8hhcKomt?=
 =?us-ascii?Q?Gs6DQe0AINobib9IuebRe3LDJgjaIws8j+TuO1H9VnIC5ttN152phPSOeiLi?=
 =?us-ascii?Q?nOQ7gY4b7IQ2DNuBgXrOCYSetDZg1Rda6HJ7UbFFDIDv3FF04qD7TB6ZSigR?=
 =?us-ascii?Q?MjBAXZ+SP4HWV1dTmZjfH58i8wlpfMiTI3YYwAXJbBgLY71IVEblEo6701oY?=
 =?us-ascii?Q?8qlpxVcElOq4ZB73n+luxpc3STV1V1s5/RdEJaPqFAkgupY8eRSa8dTODgwq?=
 =?us-ascii?Q?W08gQ0YTlGcQwBQGaFZMIHeCPJONUHzaDJhYu5k5a55zZBLbTFRLHo0SOgVq?=
 =?us-ascii?Q?n52NN2bOpQ9LIMGzH9mKNTgd7hOZLA6cb2oywPmJW5FnwNT3kABSR5x2XjGS?=
 =?us-ascii?Q?rd8RLeYtBWo0Xspta/rGF8UdHoS6oG2exw6kOvlqVa2iDpHgJVQSucE1t6AI?=
 =?us-ascii?Q?jL27YqCstKwjYQinT1hvs4MUJ4hvQceOitd7YBlF4siKkz1klCumEzQOXawt?=
 =?us-ascii?Q?d3HWM65RjXz/ZBNqBdLMN3mZDzMM1r0RMlm7EfVVmQkZ1xn3bFswN9u9/4ok?=
 =?us-ascii?Q?NJrMG1zAzyBr9DPCg841q1DkvvFig8s6vqXF0GWRh1zLws5gSnb48C/vwptg?=
 =?us-ascii?Q?Yd2obBuu3RdYbuKN7sPFkGaXrgeMAicgxEjrTeHYejRLiAqvcwY1FbOou4C0?=
 =?us-ascii?Q?0cfKI91ycPyy+PRwfxQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7981326e-a79f-4c72-b589-08dc3e6cbb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 06:06:29.9663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZz2tYdhEWESsQFCtFC/BT7Y1ZD7q1iKIdPf48LnE7dSFdRY8Al4fcPZKfpKmP1mdxDLiJoX+Kn0AaRJqWLfMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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
>From: Zhang, Yifan <Yifan1.Zhang@amd.com>
>Sent: Thursday, March 7, 2024 11:11 AM
>To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
>
>[AMD Official Use Only - General]
>
>Can we just add cid 0x140 "UMSCH" to mmhub_client_ids_v3_3 structure ?

Yes, we can. Then mmhub_client_ids_v3_3's capacity will change from 31 to 3=
20
and most of the space are unused.

Regards,
Lang

>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Thursday, March 7, 2024 10:49 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
><Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
>Subject: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
>
>Fixes: aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")
>
>Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
>b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
>index b3961968c10c..238ea40c2450 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
>@@ -99,16 +99,15 @@
>mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
>        switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
>        case IP_VERSION(3, 3, 0):
>        case IP_VERSION(3, 3, 1):
>-               mmhub_cid =3D mmhub_client_ids_v3_3[cid][rw];
>+               mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
>+                           mmhub_client_ids_v3_3[cid][rw] :
>+                           cid =3D=3D 0x140 ? "UMSCH" : NULL;
>                break;
>        default:
>                mmhub_cid =3D NULL;
>                break;
>        }
>
>-       if (!mmhub_cid && cid =3D=3D 0x140)
>-               mmhub_cid =3D "UMSCH";
>-
>        dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>                mmhub_cid ? mmhub_cid : "unknown", cid);
>        dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>--
>2.25.1
>

