Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B771C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 11:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B840E11AD3C;
	Thu,  9 Jun 2022 11:25:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03B511AD3C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 11:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjgThQ45pKTFyliR4HTUCVCbsg2C6N1D5fLR0ytoubYhzSLv7BsPm40GHlJvfgXaZnduU091t6/+/JqoynO/E90VRWG9K6hMq1BHrcEzRQu228LMZMWlgdpMIKNF0U2JRxQFmbqwHpzU6cWXuoFm+HBQjFi9UpmqFKXLpLRaE+VbRm0AQit3hVgqKP0vQekKtu77TpaweVNh9k4XHVM5UmdDI364Cf0icE/MRAlctbaDbQggNAVqgf5ME20HJXoynRB60qPv3JryiRRYchIime77QNEBRbZBW+iYWSCrgF/0pFWX5Q2DIOm3DZzFz6Vw0qkY370wu481zn6m465+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPD7h16wqc1zAsW/9gOQxVUGkOPH8Ff9nRTTm0jIpZU=;
 b=JQ9s3x47+RJfhlZc+LDNL9RHcrx0f/VH0WfNsTAGfaTSwmOEKRAK+O7xFWWYsabH1/fv8/37d4F5JCZ/L+4LfeRExmHeYqX3iZ+StI4xPpB5hZaR7GA0NW6NnrzPoxmfPanJ0/U8SCGgRoI98WgzTNnC4OuqOCjxXDCefXUPyLfORjqCwa0gZ2cHqFt30o5Zq7WYkODefUzPhv7jNMPmkfE8uON5nWZObi5JCZnS9hzNYKrDqjv4lEU9O480hx84M2O7T2I9OHqI3BaiA/dqOILxYXNvTLl7bd+s4oSav6h77bELyC6X7dZSAHZZvIRCL3yCaw7u1XCF7VVW1xOsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPD7h16wqc1zAsW/9gOQxVUGkOPH8Ff9nRTTm0jIpZU=;
 b=er/EyYtyst9hcBM8FmZWFlt/jeDaT9h0lW7d82Mgo7tDFGx70fR08YaJ15Hq8SzU304PhnULcNoOxa2sKFj3sodbUpDNWvk9D7WZV0yLEC5k+l8maFmK3nCji7sxR9x/BfeRY23D85HrNnmWdfTgs7dgWslQUv4xMDHyVRFjZXM=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 11:25:48 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62%4]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 11:25:48 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_2
Thread-Topic: [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_2
Thread-Index: AQHYe+7ADnFEpW0z3kWV9F0f0NF4aq1G71gQ
Date: Thu, 9 Jun 2022 11:25:48 +0000
Message-ID: <BY5PR12MB3873526FFE22728D04788BF7F6A79@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220609104909.2163905-1-yifan1.zhang@amd.com>
In-Reply-To: <20220609104909.2163905-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8724110b-23fb-4cb0-92d1-4009a9e9c056;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-09T11:25:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b64d33eb-b292-4a8f-d872-08da4a0acd80
x-ms-traffictypediagnostic: CY5PR12MB6431:EE_
x-microsoft-antispam-prvs: <CY5PR12MB6431EFC8DA58D0BFCF444481F6A79@CY5PR12MB6431.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzYlKC4ivB5bKl/reGym4NOesKOB8egcIP7xbFK2UgcByR+KONV+WNpuA4Al9jtlzh5i8+Mp0nnxYxneVLfRsF8QQ+D818e7DJInYcmWgC57fMebpVd1RR7ii5A4IdnY7vamACwNnK7/nMGdfOdTCYyKi7OOF6hzaXxdi2VyWJj/qi6mdcr6tH13ukulVuCTM4E/AP9MDkI1wrO9SpOm0DNfWTaeBA2RRg5NREMDQFNSI7GnCjUgkrIHrnCyEB8bt5DlZ+EVuhkSN+g4uN1UYXHYuZnaBlO8maJuSmmuTROMvkmdjJi2AOr/T6ArYhhOJI+35595gOznigXXxux7bc/mFoR6mIJIIat9CgxoxcxuOoByqV3Xnxrk5TwHuoCF2vyw/LNmytjg/FZfRmMAOZHJBhtqFbIWylJuPYXwKkOYzEAwHwikxWrDHhOT7OGkYnD1OeU2mumv6AYP2n4Gugy053VZivyqsEYP+Q+GZcqap1o0KGhONT/+bOnaxDndu10UQy9XZ7RFpjeMJClRfq8vFpTgnJtckwVpQSrtoDxpu3i3qQ9r4hTZuCJDEGkWaJrKSGV6x7p0wd8KQgNcK4r3AgaTY7+mgYaAa1bAYihuij9BgPLc8LnbqphxrDu16RN95X4XPR8tRpduLl4fFvEHzTiaLVelSO8wcnfx6raiDa8dZEsXOxN3wD1hHy0Edebm0o2m7lAR53GjANkBqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(52536014)(508600001)(8936002)(54906003)(38100700002)(110136005)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(5660300002)(2906002)(38070700005)(76116006)(83380400001)(316002)(33656002)(71200400001)(122000001)(26005)(9686003)(7696005)(6506007)(55016003)(86362001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NmiizYLvVpKmQHm33KEPdacMyNegw5Pz7ejPf6LihFsbeDwgcqXmbbzDjEn9?=
 =?us-ascii?Q?jXH3dVVZETcYs8oyhVvPdfXmsPoweKi1fBQ2qC0Mo6uh6HbDL67vkuPP4+lO?=
 =?us-ascii?Q?YLDrFrmd3QIDWdc9IBZkUnEVvRTvhcjsAM+6eJqWQ0bVeRwEAw7F0wN8BOi3?=
 =?us-ascii?Q?r0vqHSQsBeG6hYpSCMeiHzLP3e+wC3IQ2ZMSmpUWcqxaRZvF1HwCpwpXzNTK?=
 =?us-ascii?Q?r9O0zu9+muBS/knJzjel6/J6EGY20vmD62sR3O7YmW5QRYtksz/Ll5/qlfzm?=
 =?us-ascii?Q?PFDi6WliIp2kBDOKyeIr00StArszdcsolnXec+2MoVnyumdoSTdw8oIkGEu1?=
 =?us-ascii?Q?Mcs8EDHM9AeULj7HbaGHXbzAnCMj4RYT8BhsuSIiHJNSxOGMVm1cjNtQLgMq?=
 =?us-ascii?Q?uBk0+ETqQn8awAN1adcnyvsNefSK4Q4fkF4rsDHvkXuyN+0fYv2uYbpmldaf?=
 =?us-ascii?Q?xB7ngSr2oMr4ld46r5DrHKG6QX2oerwLMi16ZVNf2ZeeNkAYCf2ux4gpLk/C?=
 =?us-ascii?Q?Cs+BbS58znK3LL0qSyvm6NQXt1NuMAP1978pX5M6mm8ctpHTmAz3h0BF4LPQ?=
 =?us-ascii?Q?HVd9Hk3kQ4He2q99PBxXfsjis7ueTKUT/NXI/VCCpVphCtTs6OZNlPJ1ysGi?=
 =?us-ascii?Q?YAm39J2JnPK1KO6xeoW71AfiM3U54ntNs2RPqqNLem5P9Ck5ppTCcyJJ7ERx?=
 =?us-ascii?Q?gRctfzeJ289euP+A5fCCH6zTVQt2BYGhj6ddCLGkRbTT/JjrO3eH3HxkQAa6?=
 =?us-ascii?Q?DRUsctW5zRjQQIlF3d3+penmTEOE1QHUzU7x2bWkZdSOrBlsz3wHRgdl+bAF?=
 =?us-ascii?Q?q0rLFkzx4T2RqppFXMf31a9BB+c07I+34naqDxPw88AFsxj/Mum6w/fnpuIq?=
 =?us-ascii?Q?2Uu2qJz78HHBctduJp9VgPKa6yl0VAVsA2PNj8AcpomxsoDRoslQFc5W8P/5?=
 =?us-ascii?Q?VNELpHCwU0D3ZFLY8tQUkCl2tyxCriQJN7GCdtPMlXjrfMFvJcKkqcd4MxEk?=
 =?us-ascii?Q?hAL6eSj184XZ/QOY4wPOcc54KUlYEz7n2FSwochR0Vai/obYpl8cnYegfu4i?=
 =?us-ascii?Q?VxxrGWX4QIOYV75TMvQWv3/+NYFYm5LnbS0/KjZHk6CoKF/0HwiDz1UPaj3B?=
 =?us-ascii?Q?K69D6ro6vsVMl+uBCnncWpcFx0amM71sFXF0yaJY2wV4YZH+2Dq6558x4M7d?=
 =?us-ascii?Q?hKzyaW9df3I9CaPXyFtNTaeIoFpqACGTD+YRD5xulNYBNCZW0usWx9XZc/4R?=
 =?us-ascii?Q?OawmUc0ZxjuizA0TKfuJEZ/imEnaLl7Xofy4BYR3hi0AsL4rUTGJW05OkpbA?=
 =?us-ascii?Q?v+WC4g/rLGuS3VtJT3QgDI/i4vctHosjWdrH8IW8EHFyL+no+rO2hgSzWV+R?=
 =?us-ascii?Q?QOUvUzPLt64W7vAsZb1LtBugxRvj/zCKSV4TD7vVqMakrvKIkZp16XjI1E7N?=
 =?us-ascii?Q?iqNfJ0oZkEOSqn+rZaciln1IAx0TUZVXF9tfiGjBCWeheRR7CCgFadHqsIE1?=
 =?us-ascii?Q?3IJzZjHUsHanqCGtfhK3CgEFlWPo1qtrXUaQkuPgpYxMmLLL5mhSz+IplGZd?=
 =?us-ascii?Q?NmKmAd3xjstq4xBVsEmGqNXOQvVgFbZDk4XF/cH2sZ+Q3CqzeYr7QassKf+c?=
 =?us-ascii?Q?wICfvFaLrRXhj+YMbMf6m0mHwbpZ+GnIR1ZWo5D2k6D3/eD3nJq8oNlnoIXJ?=
 =?us-ascii?Q?59oMR9bw7GZIZ8vG4VSVCvIXzRNuoU3IGR+AVccuiFpCNSOE1MI1HnmFB0KT?=
 =?us-ascii?Q?NzHDnDq9cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64d33eb-b292-4a8f-d872-08da4a0acd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 11:25:48.3935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwAnBuKT329kAP3ZI7BOgfDru5pLtQDvh9MnZ3Z41M/qiGpOfIAtq2umEhziUrzxxGbWXXFA6c5m7vf3VaHJuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Thursday, June 9, 2022 6:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com=
>
Subject: [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_2

Enable vcn/jpeg 4_0_2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 91f21b725a43..7dd098351a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1888,6 +1888,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct a=
mdgpu_device *adev)
                        amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block=
);
                        break;
                case IP_VERSION(4, 0, 0):
+               case IP_VERSION(4, 0, 2):
                case IP_VERSION(4, 0, 4):
                        amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block=
);
                        amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_bloc=
k);
--
2.35.1

