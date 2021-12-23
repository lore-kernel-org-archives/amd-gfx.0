Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D10C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Dec 2021 02:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53EB910E262;
	Thu, 23 Dec 2021 02:31:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D935A10E262
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 02:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn0iroFxeV5rZ/YUfXcuXv+oy35+OPrflV7FAOsP6MZgnRKFVr5VksIvHMHzvJvYNmWkpgdnhrlbuJF/WbciTXAbHv7YM9IpYB8bT8mozpfu2xAAJo9IEZL/UrLnbH6YF9Y6Gg03YfLMBMk8/uMUCsqaWYY3pypphoPmnTrw3ntsgDLWiYC61pI0yR/Y+jxjQH++TKxMhPwXotToHzD9q+ub+N6E+f60Sq/DBRqxqzhWzU7NzTBt+9NvTFMwLjV7+10/NvrcZgCPMiebz+zL+QoAx+EnM4ruz5sMlRCYXMmHJUDedA6b0hLivzA1rlZL9Wmup28AOZC+lutGHovK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyaZKK3cqmzzEnGPqsNsDYf1HCzeZnMPlgqFcITdceA=;
 b=g8fjshZX4HnnCYEwVGlBl0hkLfY7gPf1+GR8I5qrQQUQXUmQJHaB20GhhLiNvG9YXhukQK5WUAmXkL6FeAy0Ftl5ERS5FJiw7Wq8svpHexXaR4+OLdfZ/XrTV44DkB7VKC3T3/KpVcHnvW3zPh3VNL1+tb3Sd4qdcVgzRZVQ95yd2ACJk4vC12D2FmOQfWMdgefWVEShzzGTzwA7N+cUKLisXoOM3IBq+QS9PVKNp20SEYNwBRJpc6CJBic7m3cjLjiuhCtz90J5xxyl9Fz2D6ap79jxy46ospEhLjg8fFzvcGmqVOa1pP0yh5HpXTF8XVprntpxGHs/wNn4YC3TEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyaZKK3cqmzzEnGPqsNsDYf1HCzeZnMPlgqFcITdceA=;
 b=ZuUbE1FDix3ser/gJ8mvetm55wFkPAYIZ7pkBI4SgsCCFnKNtqQaHcBg1qB1HWLw6PByHBg8YtxbgS4Hm5QM2FF2xWwmeMQcEeOQvo/hUAE41GAILi3f67f20T0X/wBTYLQ2g27yIKzAZxBgClBXH5Lvbc51m/xAYRUgZMhwOGE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1707.namprd12.prod.outlook.com (2603:10b6:3:108::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Thu, 23 Dec 2021 02:31:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 02:31:04 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Nikolic, Marina" <Marina.Nikolic@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in
 SRIOV/ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in
 SRIOV/ONEVF mode
Thread-Index: AQHX9yaZfa3kXBeNX0mWaYhlCPGrraw/W9ng
Date: Thu, 23 Dec 2021 02:31:04 +0000
Message-ID: <DM6PR12MB26198CFC597504433EF8D18BE47E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211220160834.8400-1-Marina.Nikolic@amd.com>
 <DM6PR12MB2858E316736722D6682BAAAA857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
 <DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
 <DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
 <DM6PR12MB26190A8388C1E472837BC094E47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9@DM6PR12MB4300.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9@DM6PR12MB4300.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-23T02:31:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3e5b040-aab2-4b33-ef91-08d9c5bc446b
x-ms-traffictypediagnostic: DM5PR12MB1707:EE_
x-microsoft-antispam-prvs: <DM5PR12MB170779345F5CA4E00A638B63E47E9@DM5PR12MB1707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v1eL6721GbZLd5AHydV3ZwBWjOeuZvZ0/Dn0vh575LXVpxcI2nWW3Uv91bR6tueMKBJTOixFcI+TkNs8h8QXM67ejH0iYSaOlnC+e2q8BUQo1Ilm+fOgI1xnIcgVnOqDVP0q60VCE4b90VMytmCQf+xU5Sm4R2eSW5EORIn7q4GC5ecvQkvxD77sR2u27+2r/dVb8NYENNxMBBReHJ/qKY3T+fXcW7lpDHlMvD9KIkr5njvS3lCQgcL2Lpbt6uTHA8gsaxIq5OXmikKToWTm0h/GjlUuv5r++pvo1UJ6XZKomKil2X2HwpS6MNwumf2sPM49EEy980zBbwcYhdV+Q0rN6GqhBUz6cp5+T6VeWP1mY7XLV+FprVDtYrdJoX3JLlqX/lezmf2k4tKoGnmw/9+0Vemsnov5B7ZaGzm2fW5DjL3VzvyjxxC817B32S4+50xWAsbcb7OLWc9ZL5NJZpEOo7PLjYbkRq6yd0ZZl6eUU13BWrM/RHu/QVpB15W8MEQsbuy5CaNPoGEI1hMgAYEdJCXtA/cz/i9sCPpauTs6gWOEyzGWxW7Cj5XeZKH54LEZcY6mVUeLFhxqeGUPt4BUBbVhdXT2jK1IUBGVOk0tCglzPmFY0GDzGMPJY0qAoMB1DL7e7h2RU0417g5vTG8psOAdpwEAiAwKJaJ4t43atPdrOe6mfheAVDgHs3Vdno74F0OkNSS5RG6N0tBYYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(8676002)(316002)(508600001)(53546011)(6506007)(64756008)(66446008)(66946007)(76116006)(33656002)(71200400001)(66476007)(66556008)(9686003)(4326008)(2906002)(86362001)(83380400001)(52536014)(7696005)(110136005)(5660300002)(54906003)(38100700002)(26005)(8936002)(186003)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w6rRBVYNbimpRRJ4kw4M2O8+fhif+6QYXYWYprp3ESn/8MNltbQO1Z+wom9s?=
 =?us-ascii?Q?oe4Lck59ssIjDUttyzhqn1aYPiLuqf9MuY2p/vLj4+Za813iLLkdPUcLZfLn?=
 =?us-ascii?Q?VLbGh+v87f6xSqBnm52XUDJ2lpf5Oa1taPWtvMSfjU1DzCUlCpcCx4siRNnC?=
 =?us-ascii?Q?ANNiehGS0kCEIAg/sHxe5GCA3Mm81An28gokNLBSgClsHC1WS+VcTv54PJNr?=
 =?us-ascii?Q?vaIeuEsJPrJtUBRK3TqYPPyNf/q2zbjSbenEqlt+ncDVGO9VhdLZGsH/bWE6?=
 =?us-ascii?Q?Up08M1gC2/IfmTHSrP5+W3/bfXhlLb/sEHWAJp+V9bOSiSMG9XNgkezMDfrK?=
 =?us-ascii?Q?5cTUntuMnylxq8wd0hEwim6HBk32k4Py01YYuqkU5CLbIQLt1eAEWloh4ZaM?=
 =?us-ascii?Q?FDj5x86qtQvv88UfIcKrhp8z6BeyDCfiqdPIFF3oGhm24PUQyDusT3m0Ehc6?=
 =?us-ascii?Q?C4qCgwwXFY/Zo2jJcQtyi+yrc9x/wKG+aCWjSoXH2N89w2H4SSxracrPALvK?=
 =?us-ascii?Q?bMevLpYii7smGx6CQJ4p9yDQL1tRdbhBcwnH9UwvyrClIuMZKD9iqQUMN2Hl?=
 =?us-ascii?Q?lE4vq7DG9Zdcw1Ps8i3egd0CRCwjoorfwCGc0YOviQ0b80MEANKQIIwxgIRS?=
 =?us-ascii?Q?TfRWU8D5ZQx8jBGU5KuymddujOyqXeHYBibgzg3thbu6Xw29f+2eVgzyvXJt?=
 =?us-ascii?Q?ufmY/28Z6XUBVXwboIARCrPPdnCkfcAZnkujJHcOmDrBwjeIYIYDr4zoiVDj?=
 =?us-ascii?Q?ps9vqOs9A1T6tadbuP7fduFgC6oGmyorGqICHlk2tPOVbhf8hOc9t8fciMzR?=
 =?us-ascii?Q?UtU7/a0N0e38Idj94UGTq7LhyNjpJ5MVH4bWLG1sOf59VV5Ko0isC/OLuzYa?=
 =?us-ascii?Q?bZuybw8ZGtKSsZ5xDM8L917D+ULga9tD0LSwDXVUmbkfP2mcr5r4wXHgcCfD?=
 =?us-ascii?Q?SzNNajgRZKg8Dye00mT5dY7WZUTbqOX2RWdN+IBTJ1izHvQkjp6r8x4mN02z?=
 =?us-ascii?Q?kCh3ziD3A2bbA0lo0PZY0G8OyIClHaw7jPvqsZ59qXijOnb68+koTCq/LJuX?=
 =?us-ascii?Q?B+5VyTvthJvi1ILXZHAqXh2oBVnD5FpitRae+waHst3QpPuFu4bwgfnv9TMU?=
 =?us-ascii?Q?JmBJIS4BtK2b7OPvUyQuD0aDfHtLXdU0rmFSHROBKerkcyFtTuhBxnLcgC2R?=
 =?us-ascii?Q?tJvA7Gf6Jq3VbKIJHyKFFPVsqsYJIp5uCtBOLG/FiFz5m34HY6fBh9zgnVri?=
 =?us-ascii?Q?PWvQfu8kxXJ3Vp8PobO/PWjbh1gwCSTlV1O0U3cH3GdasXtvVHF2p+E23L6W?=
 =?us-ascii?Q?70NTET6bS4int+AGU1XFm5uZW/6n7JpDhUeAH1pq72HbEihK3jO9lgm0z1eR?=
 =?us-ascii?Q?WUPExFpYE17fhTaQJWuNOXFfc8mYMHPpvN8tlTICQfKVrp/P1qrKNbh8X7nS?=
 =?us-ascii?Q?cRM2x/AxePhzETWKIJbmMi/weQzoS72xKJZ7AAoBYFwBAEyMSoDWUfmDrrRN?=
 =?us-ascii?Q?1qJqVVORecKek8BaimcaakHxYfo19Bvx3btL0/JvhOCMjD+77/u6L4HP+hcg?=
 =?us-ascii?Q?g1U5z+h9N3JTiar59a4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB26198CFC597504433EF8D18BE47E9DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e5b040-aab2-4b33-ef91-08d9c5bc446b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 02:31:04.1146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVGq8tm0MolTK9Tph8VljAzgkRNi0D+Chyw5kkGWb98YbOsLbxoreKPvszfCWyyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
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
Cc: "Mitrovic, Milan" <Milan.Mitrovic@amd.com>, "Kitchen,
 Greg" <Greg.Kitchen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB26198CFC597504433EF8D18BE47E9DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

From: Nikolic, Marina <Marina.Nikolic@amd.com>
Sent: Wednesday, December 22, 2021 7:25 PM
To: Quan, Evan <Evan.Quan@amd.com>; Russell, Kent <Kent.Russell@amd.com>; a=
md-gfx@lists.freedesktop.org
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Kitchen, Greg <Greg.Kitchen@a=
md.com>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs to have only read permission i=
n SRIOV/ONEVF mode


[AMD Official Use Only]

From a6512c0897aa58ccac9e5483d31193d83fb590b2 Mon Sep 17 00:00:00 2001
From: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>=
>
Date: Tue, 14 Dec 2021 20:57:53 +0800
Subject: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in
 SRIOV/ONEVF mode

=3D=3D Description =3D=3D
Setting through sysfs should not be allowed in SRIOV mode.
These calls will not be processed by FW anyway,
but error handling on sysfs level should be improved.

=3D=3D Changes =3D=3D
This patch prohibits performing of all set commands
in SRIOV mode on sysfs level.
It offers better error handling as calls that are
not allowed will not be propagated further.

=3D=3D Test =3D=3D
Writing to any sysfs file in passthrough mode will succeed.
Writing to any sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".

Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikolic=
@amd.com>>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 082539c70fd4..c43818cd02aa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                }
        }

+       /* setting should not be allowed from VF */
+       if (amdgpu_sriov_vf(adev)) {
+               dev_attr->attr.mode &=3D ~S_IWUGO;
+               dev_attr->store =3D NULL;
+       }
+
 #undef DEVICE_ATTR_IS

        return 0;
--
2.20.1


________________________________
From: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
Sent: Wednesday, December 22, 2021 4:19 AM
To: Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>=
; Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; amd-gf=
x@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com>>=
; Kitchen, Greg <Greg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode


[AMD Official Use Only]







From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Nikolic, Marina
Sent: Tuesday, December 21, 2021 10:36 PM
To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com>>=
; Kitchen, Greg <Greg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode



[AMD Official Use Only]



[AMD Official Use Only]



From 06359f3be0c0b889519d6dd954fb11f31e9a15e0 Mon Sep 17 00:00:00 2001

From: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>=
>

Date: Tue, 14 Dec 2021 20:57:53 +0800

Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read

 permission in ONEVF mode

[Quan, Evan] With the subject updated(remove the description about pp_dpm_s=
clk), the patch is acked-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@=
amd.com>>



BR

Evan

=3D=3D Description =3D=3D

Setting through sysfs should not be allowed in SRIOV mode.

These calls will not be processed by FW anyway,

but error handling on sysfs level should be improved.



=3D=3D Changes =3D=3D

This patch prohibits performing of all set commands

in SRIOV mode on sysfs level.

It offers better error handling as calls that are

not allowed will not be propagated further.



=3D=3D Test =3D=3D

Writing to any sysfs file in passthrough mode will succeed.

Writing to any sysfs file in ONEVF mode will yield error:

"calling process does not have sufficient permission to execute a command".



Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikolic=
@amd.com>>

---

 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++

 1 file changed, 6 insertions(+)



diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c

index 082539c70fd4..c43818cd02aa 100644

--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c

+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c

@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_

                }

        }



+       /* setting should not be allowed from VF */

+       if (amdgpu_sriov_vf(adev)) {

+               dev_attr->attr.mode &=3D ~S_IWUGO;

+               dev_attr->store =3D NULL;

+       }

+

 #undef DEVICE_ATTR_IS



        return 0;

--

2.20.1



________________________________

From: Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com=
>>
Sent: Tuesday, December 21, 2021 3:15 PM
To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com>>=
; Kitchen, Greg <Greg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode



Hi Kent,



Thank you for the review. Yes, I can confirm I am trying to set this for ev=
ery single file for SRIOV mode.

@Kitchen, Greg<mailto:Greg.Kitchen@amd.com> required this for ROCM-SMI 5.0 =
release. In case you need it, he can provide more details.

I'm going to clarify commit message more and send a new patch.



BR,
Marina

________________________________

From: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>
Sent: Monday, December 20, 2021 8:01 PM
To: Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>=
; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com>>=
; Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>; =
Kitchen, Greg <Greg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode



[AMD Official Use Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of Marina Nikolic
> Sent: Monday, December 20, 2021 11:09 AM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com=
>>; Nikolic, Marina
> <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>; Kitchen, Greg <G=
reg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read pr=
emission in
> ONEVF mode
>
> =3D=3D Description =3D=3D
> Due to security reasons setting through sysfs
> should only be allowed in passthrough mode.
> Options that are not mapped as SMU messages
> do not have any mechanizm to distinguish between
> passthorugh, onevf and mutivf usecase.
> A unified approach is needed.
>
> =3D=3D Changes =3D=3D
> This patch introduces a new mechanizm to distinguish
> ONEVF and PASSTHROUGH use case on sysfs level
> and prohibit setting (writting to sysfs).
> It also applies the new mechanizm on pp_dpm_sclk sysfs file.
>
> =3D=3D Test =3D=3D
> Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
> Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
> "calling process does not have sufficient permission to execute a command=
".
> Sysfs pp_dpm_sclk will not be created in MULTIVF mode.
>
> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikol=
ic@amd.com>>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..d2b168babc7d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_devic=
e *adev,
> struct amdgpu_device_
>               }
>       }
>
> +     /* security: setting should not be allowed from VF */
> +     if (amdgpu_sriov_vf(adev)) {

You should be checking for pp_dpm_sclk here, for example:
                if (DEVICE_ATTR_IS(pp_dpm_sclk) {

Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not 100% clear.

 Kent

> +             dev_attr->attr.mode &=3D ~S_IWUGO;
> +             dev_attr->store =3D NULL;
> +     }
> +
>  #undef DEVICE_ATTR_IS
>
>       return 0;
> --
> 2.20.1

--_000_DM6PR12MB26198CFC597504433EF8D18BE47E9DM6PR12MB2619namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.xmsipheadera4477989, li.xmsipheadera4477989, div.xmsipheadera4477989
	{mso-style-name:x_msipheadera4477989;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Evan Quan &lt;evan.quan@amd.com&gt;<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Nikolic, Marina &lt;Marina.Nikolic@amd.=
com&gt; <br>
<b>Sent:</b> Wednesday, December 22, 2021 7:25 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Russell, Kent &lt;Kent.Rus=
sell@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Kitchen, Greg &l=
t;Greg.Kitchen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: Modify sysfs to have only read permi=
ssion in SRIOV/ONEVF mode<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">From a6=
512c0897aa58ccac9e5483d31193d83fb590b2 Mon Sep 17 00:00:00 2001
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">From: M=
arina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikolic@=
amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Date: T=
ue, 14 Dec 2021 20:57:53 +0800<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Subject=
: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in<o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;S=
RIOV/ONEVF mode<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D =
Description =3D=3D<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Setting=
 through sysfs should not be allowed in SRIOV mode.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">These c=
alls will not be processed by FW anyway,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">but err=
or handling on sysfs level should be improved.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D =
Changes =3D=3D<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">This pa=
tch prohibits performing of all set commands<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">in SRIO=
V mode on sysfs level.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">It offe=
rs better error handling as calls that are<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">not all=
owed will not be propagated further.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D =
Test =3D=3D<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Writing=
 to any sysfs file in passthrough mode will succeed.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Writing=
 to any sysfs file in ONEVF mode will yield error:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&quot;c=
alling process does not have sufficient permission to execute a command&quo=
t;.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Signed-=
off-by: Marina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina=
.Nikolic@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">---<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;d=
rivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;1=
 file changed, 6 insertions(+)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">diff --=
git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm=
.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">index 0=
82539c70fd4..c43818cd02aa 100644<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">--- a/d=
rivers/gpu/drm/amd/pm/amdgpu_pm.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+++ b/d=
rivers/gpu/drm/amd/pm/amdgpu_pm.c<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">@@ -213=
3,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device *adev, =
struct amdgpu_device_<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; }<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; /* setting should not be allowed from VF */<o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; if (amdgpu_sriov_vf(adev)) {<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;attr.mode &amp;=3D=
 ~S_IWUGO;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;store =3D NULL;<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ &nbsp=
; &nbsp; &nbsp; }<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;#=
undef DEVICE_ATTR_IS<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; return 0;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">--<o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">2.20.1<=
o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com"=
>Evan.Quan@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, December 22, 2021 4:19 AM<br>
<b>To:</b> Nikolic, Marina &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Ma=
rina.Nikolic@amd.com</a>&gt;; Russell, Kent &lt;<a href=3D"mailto:Kent.Russ=
ell@amd.com">Kent.Russell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mi=
lan.Mitrovic@amd.com</a>&gt;; Kitchen, Greg &lt;<a href=3D"mailto:Greg.Kitc=
hen@amd.com">Greg.Kitchen@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsipheadera4477989"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]</span><o=
:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-=
bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt=
;
<b>On Behalf Of </b>Nikolic, Marina<br>
<b>Sent:</b> Tuesday, December 21, 2021 10:36 PM<br>
<b>To:</b> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.R=
ussell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mi=
lan.Mitrovic@amd.com</a>&gt;; Kitchen, Greg &lt;<a href=3D"mailto:Greg.Kitc=
hen@amd.com">Greg.Kitchen@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]</span><o:p></o:=
p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]</span><o:p></o:=
p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">From 0=
6359f3be0c0b889519d6dd954fb11f31e9a15e0 Mon Sep 17 00:00:00 2001
</span><o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">From: =
Marina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikolic=
@amd.com</a>&gt;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Date: =
Tue, 14 Dec 2021 20:57:53 +0800</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Subjec=
t: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read</span><o:p=
></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
permission in ONEVF mode</span><o:p></o:p></p>
<p class=3D"xmsonormal"><b><i>[Quan, Evan] With the subject updated(remove =
the description about pp_dpm_sclk), the patch is acked-by: Evan Quan &lt;<a=
 href=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&gt;</i></b><o:p></=
o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt">&nbsp;</span><o:p>=
</o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt">BR</span><o:p></o:=
p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt">Evan</span><o:p></=
o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D=
 Description =3D=3D</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Settin=
g through sysfs should not be allowed in SRIOV mode.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">These =
calls will not be processed by FW anyway,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">but er=
ror handling on sysfs level should be improved.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D=
 Changes =3D=3D</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">This p=
atch prohibits performing of all set commands</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">in SRI=
OV mode on sysfs level.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">It off=
ers better error handling as calls that are</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">not al=
lowed will not be propagated further.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">=3D=3D=
 Test =3D=3D</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Writin=
g to any sysfs file in passthrough mode will succeed.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Writin=
g to any sysfs file in ONEVF mode will yield error:</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&quot;=
calling process does not have sufficient permission to execute a command&qu=
ot;.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Signed=
-off-by: Marina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marin=
a.Nikolic@amd.com</a>&gt;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">---</s=
pan><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
1 file changed, 6 insertions(+)</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">diff -=
-git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_p=
m.c</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">index =
082539c70fd4..c43818cd02aa 100644</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">--- a/=
drivers/gpu/drm/amd/pm/amdgpu_pm.c</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">+++ b/=
drivers/gpu/drm/amd/pm/amdgpu_pm.c</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">@@ -21=
33,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device *adev,=
 struct amdgpu_device_</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
 &nbsp; &nbsp; &nbsp; }</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">+ &nbs=
p; &nbsp; &nbsp; /* setting should not be allowed from VF */</span><o:p></o=
:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">+ &nbs=
p; &nbsp; &nbsp; if (amdgpu_sriov_vf(adev)) {</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">+ &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;attr.mode &amp;=
=3D ~S_IWUGO;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">+ &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;store =3D NULL;</=
span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">+ &nbs=
p; &nbsp; &nbsp; }</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">+</spa=
n><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
#undef DEVICE_ATTR_IS</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
 &nbsp; &nbsp; &nbsp; return 0;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">--</sp=
an><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">2.20.1=
</span><o:p></o:p></p>
</div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> Nikolic, Marina &lt;<a href=3D"mailto:Marina.Nikol=
ic@amd.com">Marina.Nikolic@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, December 21, 2021 3:15 PM<br>
<b>To:</b> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.R=
ussell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mi=
lan.Mitrovic@amd.com</a>&gt;; Kitchen, Greg &lt;<a href=3D"mailto:Greg.Kitc=
hen@amd.com">Greg.Kitchen@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Hi Ken=
t,&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Thank =
you for the review. Yes, I can confirm I am trying to set this for every si=
ngle file for SRIOV mode.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black"><a id=
=3D"OWAAM749892" href=3D"mailto:Greg.Kitchen@amd.com"><span style=3D"font-f=
amily:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Kitchen, Greg</=
span></a>&nbsp;required this for ROCM-SMI 5.0 release. In
 case you need it, he can provide more details.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">I'm go=
ing to clarify commit message more and send a new patch.</span><o:p></o:p><=
/p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">BR,<br=
>
Marina</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@a=
md.com">Kent.Russell@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, December 20, 2021 8:01 PM<br>
<b>To:</b> Nikolic, Marina &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Ma=
rina.Nikolic@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mi=
lan.Mitrovic@amd.com</a>&gt;; Nikolic, Marina &lt;<a href=3D"mailto:Marina.=
Nikolic@amd.com">Marina.Nikolic@amd.com</a>&gt;; Kitchen, Greg &lt;<a href=
=3D"mailto:Greg.Kitchen@amd.com">Greg.Kitchen@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_x_BM_BE=
GIN"></a><span style=3D"font-family:&quot;Times New Roman&quot;,serif">[AMD=
 Official Use Only]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Marina Niko=
lic<br>
&gt; Sent: Monday, December 20, 2021 11:09 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mila=
n.Mitrovic@amd.com</a>&gt;; Nikolic, Marina<br>
&gt; &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikolic@amd.com</=
a>&gt;; Kitchen, Greg &lt;<a href=3D"mailto:Greg.Kitchen@amd.com">Greg.Kitc=
hen@amd.com</a>&gt;<br>
&gt; Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read=
 premission in<br>
&gt; ONEVF mode<br>
&gt;<br>
&gt; =3D=3D Description =3D=3D<br>
&gt; Due to security reasons setting through sysfs<br>
&gt; should only be allowed in passthrough mode.<br>
&gt; Options that are not mapped as SMU messages<br>
&gt; do not have any mechanizm to distinguish between<br>
&gt; passthorugh, onevf and mutivf usecase.<br>
&gt; A unified approach is needed.<br>
&gt;<br>
&gt; =3D=3D Changes =3D=3D<br>
&gt; This patch introduces a new mechanizm to distinguish<br>
&gt; ONEVF and PASSTHROUGH use case on sysfs level<br>
&gt; and prohibit setting (writting to sysfs).<br>
&gt; It also applies the new mechanizm on pp_dpm_sclk sysfs file.<br>
&gt;<br>
&gt; =3D=3D Test =3D=3D<br>
&gt; Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.<br=
>
&gt; Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:<br>
&gt; &quot;calling process does not have sufficient permission to execute a=
 command&quot;.<br>
&gt; Sysfs pp_dpm_sclk will not be created in MULTIVF mode.<br>
&gt;<br>
&gt; Signed-off-by: Marina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd=
.com">Marina.Nikolic@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++<br>
&gt;&nbsp; 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; index 082539c70fd4..d2b168babc7d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_de=
vice *adev,<br>
&gt; struct amdgpu_device_<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* security: setting should not be allowed f=
rom VF */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
<br>
You should be checking for pp_dpm_sclk here, for example:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_sclk) {<br>
<br>
Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not
 100% clear.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;attr.mode &amp;=3D ~S_IWUGO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;store =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp; #undef DEVICE_ATTR_IS<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; --<br>
&gt; 2.20.1</span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB26198CFC597504433EF8D18BE47E9DM6PR12MB2619namp_--
