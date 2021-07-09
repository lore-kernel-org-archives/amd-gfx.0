Return-Path: <SRS0=keof=MB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B46C07E99
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 08:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A781B61375
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 08:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A781B61375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB096E9EA;
	Fri,  9 Jul 2021 08:53:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6748C6E9EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jul 2021 08:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPuqtE+KQbUUZIwdg43IGJrqaFbyBWU8OcodOPutk2OHexQwEVoQwk+KpYSPhjqCrtaUBshoXQ74VM1Py4CFRANWzWE2p5eIFSS2CxC8H5EenPtrWTsMzshTOmx4RjxTUP9X+m0m+5plG02dI39t+uvDbiqCvWFV1DND40I1DZyHXtiyk/4zZhZnSdOKLyA9ELoRg3mMvSJXGX4/thbEI+P+H7gWoBFWTa0VKw2GXt02SAs6m3a+VVHgk1RkM0ux/7g+dwI5mQj2v3Jda4g9HvmIFlhopKYJGYSqrVlaijU3Evgr+0mdazYHn29KBkLxnun2ZLgXNdOXaw3ZitHHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF7DZBYCmkV7j8lWmoRm3tgB7FN2sd/74qcJ2qxjYZY=;
 b=LX/eNS4q9bz5aMO1TC4pxkr4DjzTjsv+pqk4mr01KmbUNECCOddRfTeXUFKxMo7f6Ti85A0sIeVLS1Vp+zdzPfsoLY2shS1y4JO/iarCDw76TEVjoZkh7vFpE6PWcxKycPyR1lPi7d5c2KFVvDLMv/XLCnRfbC99NMTzt04/mJEKOgMPUocbY6Cl0L5c5hyrdz/v/7Yrg2ctVLCrpsw9qK9JScj+yEY7NkZssCII/nXBOP6Bx91Bvwmb+1gvOr1LXxlERR0As991pT0mjVDezbOazH1ZlE08Jwb5ZDg7vWfRFd2293J4G7bCwV5NxN3SR+VI1pLyJdTo/AgOA2I4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF7DZBYCmkV7j8lWmoRm3tgB7FN2sd/74qcJ2qxjYZY=;
 b=CV6fV0CC8uko/IBJ2Gp7stXyohEb1owgRGYultYgA/lNFkmkx61cfv4ZsxcQ1noFL9cGS2+R+T+FOAV/z35aLH31uRSgfilIVUDy9oxnN3IPGmPMoED2MJqJXOI9gKkHSCfRqpGzC60AA9ai4y7fYb3ZU5q7AGOyUweyV5DTS+s=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Fri, 9 Jul
 2021 08:53:23 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008%3]) with mapi id 15.20.4308.021; Fri, 9 Jul 2021
 08:53:23 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix BACO state setting for Beige_Goby
Thread-Topic: [PATCH] drm/amd/pm: Fix BACO state setting for Beige_Goby
Thread-Index: AQHXdJx0fJjI8MAGcEq+jtIonKGpXas6VmJA
Date: Fri, 9 Jul 2021 08:53:23 +0000
Message-ID: <CY4PR12MB12870C04F76FCCB62ED6526FF1189@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210709082833.21494-1-Jack.Gui@amd.com>
In-Reply-To: <20210709082833.21494-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-09T08:53:21Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=df29f34f-9160-4320-a8bc-dbe532644d94;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cf95b90-3d47-4809-15eb-08d942b70285
x-ms-traffictypediagnostic: CY4PR12MB1462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1462876F48DCE0C7044F3C87F1189@CY4PR12MB1462.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNJxjTQx81Ady/mMqL6sIJ5AabJ++fLHc6tcBdCWgZtPPYUkPeN76nme7n4uCgil7RR7MkHXsjbyFGwNMzzNgiLkV0gKgLFcmirHVD5e5E2JNKu7b/djTzx936ZvEFArCeECprlsym6Yf7g+4as3a+vH2MSpHFlAdL30+2E3SFqR9W7+duuCU4TqAH1lC7zCmD0ZUwt9kdo8CcpXA0JBMhkrWMzvy/O0u3x52heNHj+05KF8oJcFlFRgtSKZRgolaMhsK0K2uU/3tq8BCNYjiSc2mcdZVGBrdUNIia89hEMozXCYyxFrdyGCljpvBcL238V3o5CvyhTApbQ/Chz5wBNo4qkoZwWF+AoujQgXWTmrafjcrOM3Xu65UZH4YtVYZTduGxKXsqfmLeKLrGweJy9IeIFdLZN/vDpSDW+/9MJshkXzcCmTnp5g2YmqtK0+lcxGQdcyN5Aw1PIJRIHfKMzotq2zgLx4DH5QiMoQ8i+gKwSvxJ2/0OX/P6YUT9T/FeXYprp7i9Q6Mvb9kiocfxouxQTCncneHVqEoymm8DleXIp1mFxb9Ux9i4aieGLzmO/zMoZjwQTeytTlbNfcM7eoajGyRuZBuBrND2NlrgMK0uVgxtlFvtt0MiPsAYGcIShPJNgdQ6DtWpsu+uCf3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(71200400001)(8936002)(7696005)(76116006)(66946007)(66556008)(66446008)(86362001)(4326008)(122000001)(52536014)(66476007)(38100700002)(110136005)(478600001)(54906003)(186003)(316002)(26005)(2906002)(33656002)(5660300002)(83380400001)(8676002)(53546011)(55016002)(6506007)(9686003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6pUQLDdmUaPodxyxl1VenT3ihUFVnj+aurLgiY+dPhcR/tvqUbT2GmNqiLcJ?=
 =?us-ascii?Q?mTVc8B9mnlsg0bBd+YcpbzyFi0q7WnOKSG5ukWfv2/D0wrhFzUfzlMrzS/1+?=
 =?us-ascii?Q?AFX/JzuD40ydTkTVw03TLad460Ip2p/IcOHVUCb3ugsN0xvbuthi1G+zNfa3?=
 =?us-ascii?Q?RR8SCwcCg37hs7f5MOSn1/z9PswiHIv5XZG7HeqThEIt1ZwJjqolKynfnmmN?=
 =?us-ascii?Q?nEqDJO+isR8xFUNFzspe+JKT4v56oVqYs0OtRpNa1ve1OjNkGxu/gPWMSFpJ?=
 =?us-ascii?Q?XJ4bgMabjbgBIlF77prEIxYnEFkiY9HxtPVF0jxBvtLSmEl1ozVLOSVVjA4D?=
 =?us-ascii?Q?0DNWsmuz2Z2bMnmkYJ0LZxuRJqfIArUkf8iEnJzeQFvsNNrPVgxyhYHU1YIV?=
 =?us-ascii?Q?V5XcsVKYJOVp5fibozWdyaaULwlL21FpCe6dZIEiRH1bgXb9KtPX+LuufzAK?=
 =?us-ascii?Q?MdQb1zidXEh8sqC1k6PBaUUvpRP7fEkLhBllLuJs3dyIMbyWExGmwnypbL+Q?=
 =?us-ascii?Q?LuzQ6ra/MAVYX/EWMKo104zkc4rvIvAtcymMI1ePB8m6fbiJu9NkhMb6iKPj?=
 =?us-ascii?Q?8capfptiSqM+HsrhwoIOefIEEJGH+He1VFC5+TvBBvnZMUKhqzDuhNafAP9t?=
 =?us-ascii?Q?7xpUX5jzQHHl8Zmu30ct+2curySlCW6MYTIcUkjGLCpkY4QlpHNwVBaG2x8c?=
 =?us-ascii?Q?dJe8J6cui/4y5wIjSPEXBJfYbXLxnyaEweg+skd4yBvuHo2I6ZelkHYfSHhB?=
 =?us-ascii?Q?t7eZkc8EwVxjNadg6YdKqNL9YZhcv/M3fx+POqq8TBBe1qKdUJ3lVYLkkb4V?=
 =?us-ascii?Q?vABws3CyU5D18r5wyEde83VKsZOCNxTgpZazmgoM3XU09BtiBe8rl39W6+Et?=
 =?us-ascii?Q?HG51h1lFbr9fqGjF77uLkFb8L7KZ0nOJqBF13Fx33NVFewTLsZYYQ63vmGth?=
 =?us-ascii?Q?IsKHEUP+FeEOmwIMzTtueEE+fYqp5JO14rNIUU1QELRTJW0IKGcB6XM2lAY4?=
 =?us-ascii?Q?HDPNO6FsX6pD44rFg7S1J0EAVDElVTArWlIpP61+ewJPqG3V1Xxdx0gpvaPa?=
 =?us-ascii?Q?aDIaKCjLEnp14xYTGVvGhYDuOpSQC6fKYPgjIeTi9+qlS3VF6RaFwjp9WXUz?=
 =?us-ascii?Q?FAGB6DBO8rQenv9YZ9kR0wNU9yQwr4NlOBzFYNUR5Cd5SibZzj3Xe8/WKQsO?=
 =?us-ascii?Q?M6K/byRK3VNv4rrea4QQPDFc98xdg5gbnXVUJcLIlqd3CvNUpdYUkvDRtW02?=
 =?us-ascii?Q?XVXF3DyiW7TXgA/OT3h30qa6sklmvAJnWa07fKhVd/kMMXxd5tr5qiOrBRII?=
 =?us-ascii?Q?C++7UOxTdgmS5iNSlrMSZ3l+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf95b90-3d47-4809-15eb-08d942b70285
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:53:23.6971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDz+YMqD1u+W9ZGnvaIUqMrtc2kGBPOGZZJ/A19ExFZlGZGBLx7u+FBx9yOye4Qj96NPjHJYXjT7B7Ya9x0WuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Friday, July 9, 2021 4:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] drm/amd/pm: Fix BACO state setting for Beige_Goby

Correct BACO state setting for Beige_Goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I28b9a526f1b353c3986225f075c613ba88b6ae2b
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 388c5cb5c647..0a5d46ac9ccd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1528,6 +1528,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		case CHIP_SIENNA_CICHLID:
 		case CHIP_NAVY_FLOUNDER:
 		case CHIP_DIMGREY_CAVEFISH:
+		case CHIP_BEIGE_GOBY:
 			if (amdgpu_runtime_pm == 2)
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								      SMU_MSG_EnterBaco,
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
