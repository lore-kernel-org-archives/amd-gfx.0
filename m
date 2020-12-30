Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA738C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 12:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BA522209
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 12:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BA522209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122A589213;
	Wed, 30 Dec 2020 12:31:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EB589213
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 12:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isCHLsmr1VfsjamGTLonfGMXRKncwQ3KUNmvGZHoZYt/ImpUzJId+KSbN6dFmQ12Jy6JEYK8OgZaDv2XUoWzFib7CVHurr+JkhKbt+MQIjVTZxo4yGfwUJf/bqcJgHmAUyeyJz3vfN9suqVnfj4na4+jT373sNaQEfESvdnOWxiUak7DZqr86XkQYBXao/2BcJmMecKGEYxInvKCrEysX0OfQeXvaNzyy29uv+W0ShP421M+n5ShhxxEZxQFtf7t/7Sdyh5l63xSEbicFSdBH+sPuuagaj4iOVtksDeSdeltZOkwi+Stf5YcuFBXyT6Th05z9xKmrL0JYce5eMJmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THZ6PpzuQeIxxbj+5MRmfzIIzGShlnqvlyXKKMf2k9k=;
 b=WPA6iAvJlgosiX2OSVRHBCbh3zaW24bZlAd8sXDyxssu5mmtcX2zGnOJL/g14mTotbVx/a5P9TDjFfiESs3u5CyKdG5DnOk4aRZGe9UAUzq0D3hf/rySDgcWvUWjd3dinHyCc+2ntOlnWUmG/8Y9jBTCJLDuUfOKYYVdRJIk61fnWxf3FNIrIKiMQpvsRqrNiLc0quaoom92EFopm4r/yk32ewxRKzd8yc6OrCu7s8uMUMbJ3rr2Kr7wlPwuh4zv48FcvcCQQdQvumsHYvdXsdhSQkaGh8JmhkL0G3R4pkw38gB6gxQkKZmyoSTluEZ+/WhnO2isGWhrytob9fQ1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THZ6PpzuQeIxxbj+5MRmfzIIzGShlnqvlyXKKMf2k9k=;
 b=SLux/kmk4riKDo2w4R8Dyw1XdbC7iHPSEldSVMOTlhajT8XMhFd6ee/gw4XdFfOj3Uie7RDFhLNVbmdBjrdUIouxPiJsURr3AKn+bGpmWpGQRL6Sr80NYdmleyGVQfa7UMHW79Ky0xw9IN80nyuzoS5v9Ej09ORj4JEXjGQiUxM=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by BL0PR12MB2562.namprd12.prod.outlook.com (2603:10b6:207:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Wed, 30 Dec
 2020 12:31:31 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f822:c87:931c:7297]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f822:c87:931c:7297%6]) with mapi id 15.20.3721.019; Wed, 30 Dec 2020
 12:31:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a GPU hang issue when remove device
Thread-Topic: [PATCH] drm/amdgpu: fix a GPU hang issue when remove device
Thread-Index: AQHW3qINbx/lh2+7fkW3Y0gqieSRUqoPj9Dg
Date: Wed, 30 Dec 2020 12:31:31 +0000
Message-ID: <MN2PR12MB407838B2487830DF411DBFBDFCD70@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20201230115048.11045-1-Dennis.Li@amd.com>
In-Reply-To: <20201230115048.11045-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-30T12:31:29Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ea76a29a-01ac-4bbd-98a2-670e882e8b67;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a27bb39c-1e5a-4ec1-a61a-08d8acbed69b
x-ms-traffictypediagnostic: BL0PR12MB2562:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2562B7942887DF51A46223E8FCD70@BL0PR12MB2562.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dj5Kqo1lyJAICmpmZ9SdcfD8O8x0LnvcdSYv1uoP4qM+cM1jkwHsExKpRtHP24ZDif74KEToS3bAoYN5uHTbkA1O72zJJtiVGT4q3QA75zV8Zu8JlxmKMj7JsEOC7pBsuI3JEVC4QbWJZOjntjvmnhvec2D28+L0YNP1oDuZ0SCuWqMBTQHoN5Bmck9qSsJbfTN7BRAFWNYQwWDbKdiEinIZIMRXUqlMolmhaJSIfCvTdYEFcgRpYEQFuJH5HJX1oND/hAR1Kq6sIkxaqwcVm3dJMOqBcy0sYDcnkSskn24aEL5WkMVVpxKXj1IkO+9/jvxHjNrURxLF6D9GzsBBAzl/Xn6Qmjk/7RNVxIUhF7DQhZn+My+tvURF8vQTIZVnKBoascFdud8y2LLv52+GqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(76116006)(52536014)(4326008)(33656002)(6506007)(6636002)(9686003)(2906002)(498600001)(66476007)(83380400001)(66556008)(71200400001)(66946007)(66446008)(86362001)(55016002)(8936002)(5660300002)(53546011)(7696005)(110136005)(64756008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PkT/vEfuKDcjwHDfLLIp/rvmYi2grN+erbnpJHHW4OTyMYqXCaVf477TmZbp?=
 =?us-ascii?Q?ThAjXr+IChR6dkniMacggru3188Wc3RfRqXf+HHp+mnvdPmAXK3PDHPO9esx?=
 =?us-ascii?Q?xC5n90TaeEDjsAIXYuJcuoS3Io6u/hMnHekaoNurD3ZVAguc8nTau5JHDsUC?=
 =?us-ascii?Q?OkXnSWuLASGtpDS+LXyoyK2U5T2Fcqzn+5hlO4lp6puWPGbW3z3tt15svvaY?=
 =?us-ascii?Q?5sDgQC+jhrpSeOW3Tsao781PTdpP5zNTHtEKgW/zS42SE6iqFerFbisK6oJF?=
 =?us-ascii?Q?igIKeDXbAOL2t7b9B/ZqBrvwPbmuWoRBpRXjQsVMgu4fjXwi+ppOzqC6Wtv+?=
 =?us-ascii?Q?J2ozoOrKd5IxZgh+OtGYMQ/K2QvS9hWtPazw+Sb6u3ukPtpVLMPzV7Yg5JbN?=
 =?us-ascii?Q?BtOjHIo2Af6O2JT/qOtLun4mMlyRvdt1OojAu9TWumG9EHNLMiH9zvWJAfWn?=
 =?us-ascii?Q?NT07RK2PK6yguRvq2IK1D9CgDWogYWMmcN27Uw5T6EuDTJp9J7LLxPYFFeCH?=
 =?us-ascii?Q?7na8fjQjTNFNIWn2CQDK+25e/K4z2AQSCjrmOXINg4KMGGaQO+gEOGir4LE8?=
 =?us-ascii?Q?UxOdTTM3R8tA01YEizAJzG9ZGdlOPQQ44pi1W6bgp9JhGD+mM1w1FUbBr6M/?=
 =?us-ascii?Q?UPMr+c2LO5btMJ7vciWBpv5Ct+4zrp4SNEcnGNSzMbO9nNc/q774mLnivdsO?=
 =?us-ascii?Q?kARpLBSUdcXjQAT/9twocYKXIucckjJq+Y43anF3iZeYUxnU67kssRwWXqLx?=
 =?us-ascii?Q?BPuEEJyoC9UkrPnJdSTctdDgK9djBKjC4w58MyHDfjC5L8l1MOI8tS2NYSUM?=
 =?us-ascii?Q?xJH2uMGkLgUmziFFE9NN7cuYobqLg5aRb3l7LWBddvrvcsezCEKDgwQ4p9nu?=
 =?us-ascii?Q?uLG4B/REFKN6jhQfGDV7AOERs2UVBeuaJamaBkmSJ20ayCcwUaSTwafYtbM9?=
 =?us-ascii?Q?J6BXa9B9D7VPIcPOfuM8MvefXRSV25eeJYDajexYc/k=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27bb39c-1e5a-4ec1-a61a-08d8acbed69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 12:31:31.4515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+ljwTxqJpJewKt5/3xi9/UauPlJkLK3gXysoOWszJgI3dF4IV4tkbwClOcBxc7bgJmImjTff5/BLe2keis7tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
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

Hi Dennis,

Thanks for digging this out. 

I'd like to understand where the mmio register access is from prior to driver call amdgpu_device_set_pg_state to disable gfxoff in ip_fini phase. I think we already move ungate gfx pg in very early stage of device_fini. The only GC register access, ahead of disabling gfxoff,  I can think of is gfx eop interrupt disablement. 

The call stack show register write failure through kiq, but that approach should be safe even with gfxoff enabled.

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, December 30, 2020 19:51
To: amd-gfx@lists.freedesktop.org; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix a GPU hang issue when remove device

When GFXOFF is enabled and GPU is idle, driver will fail to access some registers. Therefore disable GFXOFF before unload device.

amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
amdgpu: cp queue pipe 4 queue 0 preemption failed amdgpu 0000:03:00.0: amdgpu: failed to write reg 2890 wait reg 28a2 amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706 amdgpu 0000:03:00.0: amdgpu: failed to write reg 2890 wait reg 28a2 amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I42431f5d0bf54909e1df888a0d72fc009d8e196c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e365c4fdcfe3..47d1291d5053 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -83,6 +83,8 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 	if (adev == NULL)
 		return;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	amdgpu_unregister_gpu_instance(adev);
 
 	if (adev->rmmio == NULL)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
