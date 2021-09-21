Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613C7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 13:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2709F61166
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 13:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2709F61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5DA089F3B;
	Tue, 21 Sep 2021 13:11:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763ED89F3B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 13:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9+xNg8Kih5taA1bSEvje8v5zRUtJFkyStyiRhJ6W6IKKVxfghxiF3g34LMSfRxCrNjeMRzH4ahYc33Kn5r0DfuOdHHCpaLGsHFCOLrCxMRZxkDKwgx/Oh9bIS9XrPRsYH8LLl2E8zTDnXkKtIOAwZIzEkuHTcQfuVNF26fiYba7y41QcnwmwkVy6Qt6lG8zPZRdQ+TgQB7EYj2HGxGO1MO+TMDCYY9OBvDoVAdqqkzcv60QZSFH/dtANjCRIMBbJUO5P2B8TmpUwhwpJEuC3f3v+l/sIJ7yEogaJ5GNHk+fRx17ecS0YNKfheVThVk/mUW/elFOo3/VZb882mGHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CHXHAZmFiWbvBlUKF+Obcs/nQOv7XRJzGSVm8P3azZo=;
 b=l0+ujFqKTo1HQvgTSUopv3fYQVC4pMqNGzWe24blMy1vOdwOMiybQ7CXYfT1GRi0q5LL52e5d5iZrzN1m5St7B5UqwGekhffyfpfHq3j9G7XHAW8XGzeHkpBq9xSxlBCL4QVUy04DjCsyeNsoGnhHoP0GwAK9/4Dt1WJyQr2RCrro9diwlNDkP60N2ad4Q22X9qmXzJcrNSkjAdjYTa1z91i5g98NVXdOnd90MQ+PDhmmwPGk14I14d6vdbeiArB2ViArbocfOavqHsYseuriN0Ucn4orUHmgNhsuXImEFpHi5phroxdpyWgb6MIsmDj08Mtho/rDSGh3MlmaU9jWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHXHAZmFiWbvBlUKF+Obcs/nQOv7XRJzGSVm8P3azZo=;
 b=JNqwFRrmNC5f0rZUlpz3SB/syP6yeHqwbdox/bBYUu9ZOdE86XPgex/0laIbPNViszA+cD6aw4t06lRMT1JK8iE+BkbiWZMRTNvYLtxXtt0IDX272+jadfkAQ/4dRH9XV/aFLv4Oz/ews3DGZ52CmYnAtgRSKtrBx7QLinU/jOo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Tue, 21 Sep 2021 13:11:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::54e5:e9f1:8883:e8a9]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::54e5:e9f1:8883:e8a9%3]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:11:05 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
CC: "Shi, Leslie" <Yuliang.Shi@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move amdgpu_virt_release_full_gpu to
 fini_early stage
Thread-Topic: [PATCH] drm/amdgpu: move amdgpu_virt_release_full_gpu to
 fini_early stage
Thread-Index: AQHXrFO+WHRgBYIyr06xfdZPEbx/H6uue4Tw
Date: Tue, 21 Sep 2021 13:11:05 +0000
Message-ID: <DM5PR12MB246933AF573AC62992B7BACCF1A19@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210918060909.8068-1-guchun.chen@amd.com>
In-Reply-To: <20210918060909.8068-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-21T13:10:59Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ac6f5806-2d1d-445a-9b4f-04d40d1cb120;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f206c26b-83a2-49cf-7856-08d97d0144f7
x-ms-traffictypediagnostic: DM5PR12MB1163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1163B4E6758C7B039878E5F9F1A19@DM5PR12MB1163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWLQTTGbj797BfrriRkwylum9VSZ5n1+YjKrsCietYtXXU9+4bePcsbUutxFc5BVzI5hk5UqxBdk3n7h5aThpyAdtFe+qVB4H/M2gYFHCeHwikY6sPoWlgtk5QopyNf6h+PFmI28FSh99reTUOB9TvW1MRldGPF2FmR1lDBmpMaDfp+BcyBE8XlzLuDqE9jWfpCA71IREwVJ2SUNV4B85AAsPNiBtt24MO6Ig6WkvJX/0Bi8Ozrl7qJNMoLCD1vRKWzDCGtPBQoRuLeRkg8FQe+EhcYKVXDl/Jg4lEhJTemFLi+lL65q7i6f95YnTDGVF4nnjMB7XAOshwmlNzqp8SEWeCVa7VbB9t8xKI3G/6lcaoOU/gR2mWzg4wacNTE00Dz1BZgDYMC2fLZlOlxZWdQxrgiFfS1qtDcqYR5nUqoU4JnedAuf7VeJg3Zhi1dFamOnZIvsA/kQ/r740lXtfjXfhNeqgqg5BXqPPrP4Wx9fnqFQZBUwhyeFHKE+n7oAVg7zD7i5baWa1GZ0ProCmK5C+FoCxayh4Z/SOZrPeYXFJ6JGWppXfa9TelDu/+UXD/RLeVBAXAzFnl7C/p9xJncDQ4hvZh/uQIAOP2vV9y+TWnFc5drX1n705ljh+A0TnkUaWZvrDHZWHCPuct892rmt960VFTy4LKuOD81w94Bt2KcxNJC1Ezi5Fng9acmYul4pneZMjgzOl+ZNkwz4jq7xYKbx0/kNEp8n2Iq/VK4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(66556008)(186003)(26005)(83380400001)(2906002)(38070700005)(52536014)(8676002)(9686003)(55016002)(5660300002)(6506007)(53546011)(4326008)(7696005)(64756008)(66446008)(66476007)(508600001)(33656002)(66946007)(86362001)(76116006)(921005)(110136005)(71200400001)(6636002)(122000001)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?54bwYpuKIzxQy3W/gspLHmOlseruk46wcD9BEKBP67815YcM6e7F7hyGuNdr?=
 =?us-ascii?Q?7mydSdWofcuL3sWkXif1SCACFzmoqYV97zwyeJNU9thtUCcmdN995ElwBgC/?=
 =?us-ascii?Q?iyUTYW7DprX5LaQX4K6WjyDDygzLsB6sfXQUmUOBMo/VA6gbWDdjW3zX4UdR?=
 =?us-ascii?Q?vVvvHg/wpETDJRZmXgcWuoTS013jWfxv+jb6DsBBxsZgWHPHPhlTRy6daTzv?=
 =?us-ascii?Q?NwJ61IeKF65dPbdsRVT5s5SyFfQM2rW4nsca8wzSKwuHntYGzXqWOKh+C0Mt?=
 =?us-ascii?Q?cRpb7y8BYT9ubj7oQcPR3a8yn1ALPEMubrCSE/9Sy/vkkDT+Y4EWfV+MEWqG?=
 =?us-ascii?Q?HlCUAqRqOMewQJD1ROw5hfdNWpKtOuMrPFco7N0lGpEyd1ZqwsUxvLm3QlaA?=
 =?us-ascii?Q?EQXq7Oe/lhga08limMl+0XtW8YtjC/U/7ejphUxJVMOZqe9y4EM2tGT6sOom?=
 =?us-ascii?Q?lqDUwCQP7mCS4ALP5l4sdZGBUS6ZiHgsdz409A4wQG0Aj7CIOAGHsimIVhvg?=
 =?us-ascii?Q?T6mFLb/ceyYaQjdr9DJGe9XbUH51b1mPRpIH9yMy4AmVwACPj4xkhdvObGNW?=
 =?us-ascii?Q?W250jxvQoYpX4dLLE5IkiBNSILYxNGmdKU/OR7TavuQOQB2ZxSQMDaR8U9jd?=
 =?us-ascii?Q?3WZR08tpUwjQs7lu/YH6FZzZgFGENVVy47qPH2PuQPTgL5xfD6m4f2Fvp7xh?=
 =?us-ascii?Q?KtXjs9DBuC1zvoWqmSTBq/wCp0+BMXqlNOu3GJwXivk1aq1pRvwRnTeYNHd4?=
 =?us-ascii?Q?Y6WIEQGUvKbpLC6Atq2AElQB842htgy+uJ85jL3VHsFSEDzW24Kiyr0yymt9?=
 =?us-ascii?Q?fw9TvzIOPiMQTAnN1QvcGwvtShKrUu3j1eGLPLQysnKwyegH82/pJKOVJ25D?=
 =?us-ascii?Q?L6WwnN3YTpJf1L7hJ009sxMc7XLrjr/1xP6Q4T0zgA8kTShjy9+buMdyT0mi?=
 =?us-ascii?Q?icX8SE2s/ldV0BspVDfNr65PTJKgLfyljMTjF2/ob2eG+9IjkMGNGZyl87CT?=
 =?us-ascii?Q?0m++0r07Eh8LaiXDn1BOuA5A/499m2wSlrpOKHbEQTJE6CM+C/x9ItWOmE6k?=
 =?us-ascii?Q?zFOv6hfePfRHzSX554orL92aMlFtyRsISwWJrQalRSDUKkjMc3Kg4/F62rpZ?=
 =?us-ascii?Q?b//1o5FNt1KTZFBEHYfNA8G5owqo3jkqtEQnFYDU352HGe2koosJw10ITLhp?=
 =?us-ascii?Q?tKbWweIGPIeNUhzaFDPZdfDtr2mZPVHOUmVi/uUQkwQNfcSeeFJTKIbt2xpz?=
 =?us-ascii?Q?eGE9XWQGvZz4QusrhxluPNI7v+wCIafGq9VC7XUvM0CuduIXklC2OwD8pfZV?=
 =?us-ascii?Q?TZ2J1KPpc9dymRAdv54oomIy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f206c26b-83a2-49cf-7856-08d97d0144f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:11:05.4194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3pHBBF87O+qnyYGGVmYUCeAMXp0WKxAsMN3yH2I/GCtEJMRGm7riz8DFBrQFumuEmyBbxxSNGzdygsvp4ieNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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

Ping...

Regards,
Guchun

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Saturday, September 18, 2021 2:09 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Liu, Monk <Mon=
k.Liu@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>
Subject: [PATCH] drm/amdgpu: move amdgpu_virt_release_full_gpu to fini_earl=
y stage

adev->rmmio is set to be NULL in amdgpu_device_unmap_mmio to prevent
access after pci_remove, however, in SRIOV case, amdgpu_virt_release_full_g=
pu will still use adev->rmmio for access after amdgpu_device_unmap_mmio.
The patch is to move such SRIOV calling earlier to fini_early stage.

Fixes: 07775fc13878("drm/amdgpu: Unmap all MMIO mappings")
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f3da97086f7d..2a75c09c4884 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2810,6 +2810,11 @@ static int amdgpu_device_ip_fini_early(struct amdgpu=
_device *adev)
 		adev->ip_blocks[i].status.hw =3D false;
 	}
=20
+	if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_virt_release_full_gpu(adev, false))
+			DRM_ERROR("failed to release exclusive mode on fini\n");
+	}
+
 	return 0;
 }
=20
@@ -2870,10 +2875,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_devic=
e *adev)
=20
 	amdgpu_ras_fini(adev);
=20
-	if (amdgpu_sriov_vf(adev))
-		if (amdgpu_virt_release_full_gpu(adev, false))
-			DRM_ERROR("failed to release exclusive mode on fini\n");
-
 	return 0;
 }
=20
--
2.17.1
