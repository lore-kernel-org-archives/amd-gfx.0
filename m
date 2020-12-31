Return-Path: <SRS0=M3Em=GD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A03C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 05:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B6C221EC
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 05:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B6C221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F5989B05;
	Thu, 31 Dec 2020 05:43:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673FB89B05
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Dec 2020 05:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOuSg649FDrNd1QrXgBLNGBK3bMZaoENv+rLfXHLHy7yCiWB4iaJiV52dvgzU2cS3N6jqGqod2Xxb6mXlOWvaX7QABYfMQ5UTyV4StBl5mC3OAXiCBH7XoW2XgZJJxfZsUZZUEiy++WFKnbxVb2ChZyUqMG4ZLg79PTwDNeJ8xs7fA4xDtFgj5zLqpFPinqKthfXQViDIPksxN7zBrg5NzsiwVVLSlmBUnQmaPtm4ad0vI0a05yz9evjVGf+KGxR3EsX6VPEUUols9HZgbJXAL5Enq8hr0KL8+bwtxLUP6ErR2L38MyAhKJkTxsorSaXkHzZiz5ZI683aWVDwIr4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no7xYHoxmqVLhmUMjKhpldpHPClPuTyeBNtBzI2uDl4=;
 b=lAWfnaFtF0kMpwciNj0GRA76cytoaste3MnXGSGG20kw7VsdDF+4SY1k6W7HBpSa3jZ8d4dt6CcvSoy/8mOFqzWc699gbF2tgki5+XEb+4uU84QBnHgP5erl0zE0Q2L/A4c2NTVZldEBppS3ULTfnkdDsqhZgU1EWUfuS6oOjDrdh7cSQtiMi9T+YV/gaKH41Gn0u4EYeAlu72H/J7fboTdduQGksMdO6mppsF6DXhI8oyGotzx/5e6NU+RyvuV7aud87zbGVML6aSIOguC4GqSV5TZxk+5aIQapcVOti5wWthvmZ2NmKgHr7eR8BjoSncyM1/JFNCGGXFea5BaNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no7xYHoxmqVLhmUMjKhpldpHPClPuTyeBNtBzI2uDl4=;
 b=A574hf2ZfiFftB6xiCTpO89+Xh3PQyuwS+X8unCbchFBojok7WemB1ChBnYGzNb5BlX78NaMEHyE43ihwJa+E5RYpHH6fxfaGSETOzuz8jUOqG0h6EMsHSc59gYTG/IC3LUFZiSbrJXWVvmfUmYvSO0gHsAecwZRV/oHqA+iXR8=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27; Thu, 31 Dec 2020 05:43:46 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3721.020; Thu, 31 Dec 2020
 05:43:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix a GPU hang issue when remove device
Thread-Topic: [PATCH v2] drm/amdgpu: fix a GPU hang issue when remove device
Thread-Index: AQHW3zcl6eNj4aY9nEaz9kcGBgnYIqoQsTqw
Date: Thu, 31 Dec 2020 05:43:45 +0000
Message-ID: <DM6PR12MB407543951E29BD2B4D8517C4FCD60@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201231053802.27248-1-Dennis.Li@amd.com>
In-Reply-To: <20201231053802.27248-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-31T05:43:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=aae92b83-0c63-4d0b-bc68-e132d0ef0732;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eee60b12-1d0d-4a80-447d-08d8ad4f0a5f
x-ms-traffictypediagnostic: DM5PR1201MB0122:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0122142CF7B1131F6F06EDE2FCD60@DM5PR1201MB0122.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sCK2vWFbPFmFIATZ7cmLmqGJG14tB8IIoYdDBRcRwn1y3SxCsJ02293lQxnD3P0kbKewuvjdicXWayGQGm+4R4InU0cgUGY8Zwwd7LynEfz/EI4NFN9CpAo++cs2w2jCMD5uanLSgCM3JOnnaoWxzYgasLihlMkhQ37tgPJV3m21rbpoCzdqrwCqiEXaElkBsfOXmNFpdavp5St9rZZcN+3+5+3yr36bUOAmM6ZUgRjZE6hYGc2a6eWyz5j80eIz6agWivRSI5Ow0WbAMyo4TxYxCL/ey6IbUZ6WMQW5U2mVckdvf+UYkhnD4HljCI37sOeEbBBS0D0zRXbR9VjTZ44ET8jZUQzKiMVY3IwKyxIlmFcVxlQ23d2a93P5I/aO4uiHCMDW3Ghi9nJRTJiug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(66476007)(6636002)(2906002)(71200400001)(110136005)(64756008)(186003)(26005)(316002)(4326008)(9686003)(8936002)(33656002)(86362001)(76116006)(55016002)(6506007)(8676002)(7696005)(66556008)(5660300002)(66946007)(478600001)(53546011)(66446008)(52536014)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H/5XaUxmASuE0T5/S29oRWOQOxM1c6wcbLPS8ibAPUWVloJBrIWCZs/nF1l3?=
 =?us-ascii?Q?j514twN9emIC5CDW3XEDmPYjDeNa22zJ90TpdLlxjj0NOCupeWWZX8mJt3LM?=
 =?us-ascii?Q?fkyU/Oq9k0+gfcauFmslky3HxEVZtQY15xBagmhaLOIdFinr0GS0DS15uQ+H?=
 =?us-ascii?Q?uv+KGc2yRGsRNgthpuhl/Z/pkuUDWyCUPNG7sJuIgO6R3/Deo1E4bTEiQBHh?=
 =?us-ascii?Q?MdOWLTWpvTgAqdLzQNWoZJEfyOjqfhv2+ckEzosmtiHyoPCuO4Ruzk4WXKpt?=
 =?us-ascii?Q?Y9Fk8UlDmFUIG3gMl8uxyov+EPA26moe0+lIQrR9Sz0oDPvEZFc0rzjZ/+B/?=
 =?us-ascii?Q?QmLHQukNacsmVn/tCTtTaAicPfA+8AG9/bpdkvpePYZqqlTi9o8Iba0M4bou?=
 =?us-ascii?Q?ztpL8ueYDQizOsOhp8EgMFPCVX2e/OPmKwmfujiEr5s7tWxg4aBPbRJ1yryA?=
 =?us-ascii?Q?VTLCDDLXWMZO6HY9PodlMRtzKN0i5aETRyVgukRqIwcIoOmMwQm1eX4aJZDd?=
 =?us-ascii?Q?eomqWWqe1mgrvT6gWHk+VrE2+8W8i81sYpE3eG+7lwSo8luCTyP9B17oTbux?=
 =?us-ascii?Q?iaGKW8Gav1b6szC2/J/iv4k40eBrdkwej872tMD5z7o6T5S5GaGboDbq2kv5?=
 =?us-ascii?Q?c2J0wu5mjc8SH+sq/5+Cs2cfhoT4XoKiRATsVWjFrz6+/hYVCUCg3FKLIER4?=
 =?us-ascii?Q?9xC+xQQLddkWYDdtv9YlaeXZdIcMqbN1Sd/1s8lO2hW+Toz7JscQVz2q8J86?=
 =?us-ascii?Q?KQ8YwgnTyYq2Alsimg3HSbGJpniA1gwwTwNgd88IddgSrxqdvZY0QbmBgjS2?=
 =?us-ascii?Q?/kjOPP8m6QGH2LN+GNiEdeX6O9qRuYvJJGAdB9T1uHgH833rEN6+2mgeRAIj?=
 =?us-ascii?Q?oiz853afx0qS04xd9/5Dzf2Ud8YUZeKLVhxNx4KOxEqXfBzUZmqnTGbUjggm?=
 =?us-ascii?Q?6x+t1HdQ8NKkmmlSAuGOg1dwNyFAuIdknSP9NMCI4p5ZJnnG+x7S+S5nfW1a?=
 =?us-ascii?Q?5INM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee60b12-1d0d-4a80-447d-08d8ad4f0a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2020 05:43:45.9468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgchb1O6BDdJvK2dAp+3wEP/I06wYRCuinvwoR2BGx7QfM8oLcZAxdo6eYTV+OGsXg4Lp6uLLc5OduqBuAqH5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Thursday, December 31, 2020 13:38
To: amd-gfx@lists.freedesktop.org; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix a GPU hang issue when remove device

When GFXOFF is enabled and GPU is idle, driver will fail to access some registers. Therefore change to disable power gating before all access registers with MMIO.

Dmesg log is as following:
amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
amdgpu: cp queue pipe 4 queue 0 preemption failed amdgpu 0000:03:00.0: amdgpu: failed to write reg 2890 wait reg 28a2 amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706 amdgpu 0000:03:00.0: amdgpu: failed to write reg 2890 wait reg 28a2 amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I42431f5d0bf54909e1df888a0d72fc009d8e196c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1cb7d73f7317..b69c34074d8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2548,11 +2548,11 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
 
-	amdgpu_amdkfd_device_fini(adev);
-
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
+	amdgpu_amdkfd_device_fini(adev);
+
 	/* need to disable SMC first */
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.hw)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
