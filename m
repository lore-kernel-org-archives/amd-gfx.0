Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AA0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 05:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C9689D5C;
	Fri, 24 Dec 2021 05:26:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB8789DA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 05:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1MPvieT1tvMry49JXL5MZzB1m4Oh5ymu2mIO5OZzBDk67ipjBqpwPapMal0FtcjAxBwFlIYt7VY9t2w8Cr4kI3ZGktDi83oKh9sYDXBttfdNng4hY/pje3m29y/HVFJW5e55Clg0AYgP8jeVskQUCslj8Oy16pGiioGn0Imi1Dw5y/IwIdiXOcF0Swfxf86qPRWmesaqjpVZ1ihaQlgPrr3TJgeXa0EYpx5G8E/yj/PBZpI/ueL4jBufhyLQtyH5C04wxyq5xUXIsvI9LkFvH7aliVXRalQHVNOeWTgMhes41ipB2DG6VlAkhB83mB+FvqQwu69ybI6fNXYoVGrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ezZdd5UKwa7hgrLyjzizZm7/j2inMnBJSlWwox0XA=;
 b=dalDIcYHGtPU528ghm2NiScBwxGVVIsU9/lNEbi/P+1Byx3LJNgPhh+EYdyKMBKWrGJyd7ympiH652twGJyoTI4yhKq2j1J7+ZZG7GJKWDOGTUsA0SDXbkPcHVpN5qHwyo7bY55E5kEG+JmZkxM9RETXWKeCyYCxzzGGD1ojShnG1FOGd5WNE5hezqVglkk+UYWNkrmqYh6YAX03ZsmwSw1p2WsZ2T7f4KHHE9ViA8WAA/gKYj94MsuXjCpz7y4WQsIdD8hD+oO8nXktI+Tr/nhrGTdREUIibUwHEKY7nfbUJU/8GRo8AkMh2B/5OZXesji8b0YbpXj0X9l+cFKwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4ezZdd5UKwa7hgrLyjzizZm7/j2inMnBJSlWwox0XA=;
 b=M5loSKpdDNVOVUpb3COSh82sSIWRMt5lJzew6AtqIxXlFMzdBQJ5Usxu54a2rpi+Mfsc1gYAH6cgK+OKtDytgEG3doTPERpiwlr9JN94H2RuN+EDY4GmjMxqRzoorrVABAT2mjkfkE8uovYQUo7IdV6VQhtcVRj4LmOc4Xf2lKU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.21; Fri, 24 Dec 2021 05:26:36 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 05:26:35 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspending
 for BOCO capable platform
Thread-Topic: [PATCH] drm/amdgpu: put SMU into proper state on runpm
 suspending for BOCO capable platform
Thread-Index: AQHX+HS+nLduwuKFakeGdwr+F0Qtk6xA+ZgwgAAi7AA=
Date: Fri, 24 Dec 2021 05:26:35 +0000
Message-ID: <DM5PR12MB2469B0FEE12D46B5F74DFEF4F17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211224031644.2555373-1-evan.quan@amd.com>
 <DM5PR12MB246972666C925C37BCB871DFF17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB246972666C925C37BCB871DFF17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-24T03:20:54Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d69a6c63-eeef-404c-8735-c05a4988c8aa;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-24T05:26:33Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 67a122bd-cdfa-4eb9-ae6f-08304c3d3483
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd8e2f0-c0f3-4bd4-0bb5-08d9c69df437
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4516301074BFAA9BE0425B07F17F9@DM6PR12MB4516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fd2GC7uIvJzJSOpoDt4O4fIwKomeolsqY6/q7nAz3NFLzmXIvBwhac6RhxkM3UsVC4uMRmAlrkgYGj8vDNye7xDRsOxoOqaTOpAyoxQALVLb0Ny+JIU0B7C7ZFs6LxbXVGN2g6Lc401/e5UydKe6s0IuSTo9kSFJrZlS9DSh75BUgVUuJRGUq/S0v9p/d/TukN5q+vG3ls5gjp5B9UH8uHJyVnyQK4Tcle48hiIWqRgZODvqwLV6ck2jLmaHUL0/JKDgUfEYutk19ifcsDV8ylp3oBVpnGjvihGTLp0QC1/Vo5Yiop0EV/Z8IUUgurLuCU1ggRIdQwLrsWDaMYkxcg+ruBoDUdj+FNe6YSVj87FSPX34f/mNfbkOKf7TvuMrQbQ7md+VgyHLOBv3SkHxkEkYt8PIc4u7UCHeWHPqG6g0d4kGPyCz+HOLl+R58X+rNQIjTGq7MTrinLGxifX4kkfgxbR7K5OL4LVs/DLAhj31K71rEtS8NWyXBTF+8G/D+41NGak9VgH0azlcoRr+KKzIR3x7rHofsgUkvKqaNJn+R5WGk64ksK3zhhBUaLGa4nk1mZKpU/1uva8Blqf+kh3epdqcLvJh6LxPV5gOxVLes7b3bDjmPTFtkrNf8W1cf/BapSZg0vLcQTudqUI1qWRLlcKjoRlDyOVJCPA+gRmnxIktT0ioQjXge0ldOTduJFuX/hA2NLGOD88hQaBOgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(2906002)(86362001)(26005)(53546011)(7696005)(186003)(83380400001)(54906003)(52536014)(6506007)(122000001)(38100700002)(71200400001)(38070700005)(8936002)(55016003)(15650500001)(66476007)(4326008)(64756008)(66946007)(76116006)(66446008)(66556008)(110136005)(33656002)(316002)(508600001)(5660300002)(2940100002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WNR+ZgZz/ZNT9HoUR8Y3SGmwnfwcJM/w+KeCl8Stkja8/qxJNWI1Rywfacgr?=
 =?us-ascii?Q?eLbpph0xVQzIwLK6evRHKEYkOjBldYUOR2EdaxN7nTaCd2WOsWMDOCShTPp2?=
 =?us-ascii?Q?JjEhZmhA7iGHkdPjHOaSCSoq2Bjv/fIfacU2vgJDQq9o7ljRGMj16Te1lGcw?=
 =?us-ascii?Q?Ys2V834hG4MBUl9dqzRlwS0PivtkjhxV7TAMBONyzZIAtGM+pKS2URPPVCQm?=
 =?us-ascii?Q?swpM4IoPBK8N3kAGvlSbM42xYAMEAGG+R5q5kC/B8Vm/5Gq3Y4c8xe2fB5+y?=
 =?us-ascii?Q?y5X+F0px5RcrAfcLS+Cua7M6ZWS4ruIGocyq+RwQEJ++cMoYNl/eGF/ew75K?=
 =?us-ascii?Q?nN/HM/bl7aLaHqqAMoH+6YXZyglZrRtgLEIMOOPJZVI04UV7YZOaRqrx/L+c?=
 =?us-ascii?Q?VakO0wwm/PanXuZeRpg167TYuKCOpYN6K+I1Bc1B8lZUDeCSD3Tdk3fpjXQM?=
 =?us-ascii?Q?sHuIxrvzCgY3cdVvr8yJMIljaUdrlQGHRvh5yLMGuxU9p7DHwfM365IgkBfP?=
 =?us-ascii?Q?A8VbB/SyL2VcxBVwl6qVOgj0VfHuOiqhKjvhjNgIIYo1+Md6OPaSQsAw5Idr?=
 =?us-ascii?Q?elH4yC/hHclI/Y0WVQrUx4EMD5V5uEV26NQZy1BLmu39JJKZh0HVwK6+Ytwh?=
 =?us-ascii?Q?pspifC1OAvng0IsZnO5DrLBeEhPrshpJfNx0SeT7yS8UkOjspEVZx5bmWnrk?=
 =?us-ascii?Q?RTPAjcAVMX3nayaUvPBYZumXz72mEm6xDaX8FY/cMi9fGdRfQfEteB7Mr20q?=
 =?us-ascii?Q?VHfiPRbyk7/yWd7YNR1Tf/0u3X/xRBRcVlJ/E0+v6RaP90Q0N70pxJiC0Phv?=
 =?us-ascii?Q?kiHyw1BzaozxaDyjSO/MIhQ0GIw4wQT4TSDo+z9mNRauh4egLdl9ProsSxqA?=
 =?us-ascii?Q?TdQwsthTUaRC/4vlsVyjHpS4PKtpzfxcQiqc4Kz0aI5/nHxsJITHvEoeOVqs?=
 =?us-ascii?Q?K9y+sJRAhfZXENoYPKTJzJ2zYHtnF6DL/EaRdNE2Xoou7O98x5eJPr9/3Kuh?=
 =?us-ascii?Q?Kd8DorMOJ/NpAmMZ0Oq8PbjbP2Qv9Uc+hxPqhUekAMq/0shiT979dGXaWp15?=
 =?us-ascii?Q?m1jHsTAl9xxX9GTbBUV/sRqEuqfdtTjy7qRTf3rmR02fgS3gkfp9zB/9ppLa?=
 =?us-ascii?Q?cVm6f6vfhNAOLt2UeEbI2ySibqtD0D1aE6jzlrksLj2Q2+/50Tat6CsthO4E?=
 =?us-ascii?Q?owRwPxYmUPs7R+aovc8gU3S0OpRQbUPwaTIu2fgvnB5qXruzb76GtG0Ht+ko?=
 =?us-ascii?Q?ABXal8ZgWVl5vkhZlX3FeZ9pwkFLH+2Lpe6FnB0ykLYfjUjuLUt+mkmyNUiO?=
 =?us-ascii?Q?jHyXwPmcLTBYSy4JGDN7QMaCKTK6Gr1X83wEDKD2FGm+RZNXjKJ1TjqWwhiu?=
 =?us-ascii?Q?95AMv9lUJ7tlv+6BTIZjcTUawkH2lauKy+88jOTNZj9JaXjL7Ve1yrWCSYeo?=
 =?us-ascii?Q?4Aer+tjW/c7+JBRQ3z2KxbqRef9C+9dDwQg82dBvnPQ6DfYIGyqEPg6dwdjr?=
 =?us-ascii?Q?tYC5NICrE5DDRSOgBw79TG5eZkR42rm3L+1cSmPgjdjVn/3+J9cdzxAPBCfM?=
 =?us-ascii?Q?/1IUmMfvw3+wcGiq1DaLJ04yFnOtQLvCkEUjvGO5yvgZb8prT3chK4kqMnnU?=
 =?us-ascii?Q?f4k/IUaNCcFo3fhn0p44hQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd8e2f0-c0f3-4bd4-0bb5-08d9c69df437
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 05:26:35.7799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gY4DSNKmVsbApLqKVhKXIoUnsaU9O4/Gir3poW5p+CkGiFtFkI1LoNx87KA0TJazQi2Y4uJIP2IIXgs1poyFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Never mind. I checked the code in amdgpu_device_supports_boco, it's only tr=
ue on dGPU. So pls skip my question.

Regards,
Guchun

-----Original Message-----
From: Chen, Guchun=20
Sent: Friday, December 24, 2021 12:42 PM
To: Evan Quan <evan.quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: RE: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspend=
ing for BOCO capable platform

[Public]

Thank you Evan. Shall we limit it to dGPU only?

With above concern clarified, the patch is:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Friday, December 24, 2021 11:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspending =
for BOCO capable platform

By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some proper cleanu=
ps and put itself into a state ready for PNP(which fits the scenario BOCO s=
tands for).
That can address some random resuming failure observed on BOCO capable plat=
forms.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9804c4f04b6d2ef737b076cabf85d2880179efe2
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index e431c7f10755..ad8370b41e74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2235,12 +2235,27 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
=20
+	/*
+	 * By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some
+	 * proper cleanups and put itself into a state ready for PNP. That
+	 * can address some random resuming failure observed on BOCO capable
+	 * platforms.
+	 * TODO: this may be also needed for PX capable platform.
+	 */
+	if (amdgpu_device_supports_boco(drm_dev))
+		adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
+
 	ret =3D amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm =3D false;
+		if (amdgpu_device_supports_boco(drm_dev))
+			adev->mp1_state =3D PP_MP1_STATE_NONE;
 		return ret;
 	}
=20
+	if (amdgpu_device_supports_boco(drm_dev))
+		adev->mp1_state =3D PP_MP1_STATE_NONE;
+
 	if (amdgpu_device_supports_px(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
--
2.29.0
