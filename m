Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED5FC54FD4
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410D020714
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WoSSCS7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410D020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36066E5A4;
	Wed, 25 Mar 2020 08:35:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C256E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i82bQpq40Sib2BXQoge7sVMjP+4/EWlQpO9BerVEef34XfhuN85EkwE7XY1wh4dhi74jr7H2hbmeMod5NVMi43Jm1QhnvvQQToQyi2HVov4MkM+DJkDnVnAotrWA2yxJp8Z6ljkQgaqQsKpJ9w7zjnA2ZN91MQ6BUOWTQDr/qP7s1N8PkCeoUk2xnfzIfRit1xKOMVLEgHslmIoaKSOv5XEk2vHdeaxRv4qkKeDxPEJwfLv2rY2ycujT0GQS4CfRJ0kepUBeyltgeuuSY/6w6EryRWcyxROciUoY3GniWZZOhvx25/tGcfKsVIB9Rx4IQqynz8U5o8u50zv4opmtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91jcMth1kSTftZLe+MHMaPHlHcq7ucIZojj/DETCc0Y=;
 b=FPKvIarEIJWm+n+mPmccgDnXuPXWG7PS1TBD9oYDBPjOlFd9yzqWAwQ42N4M0Cj2T8+RWBexpxkN3S9Zke0qbb/DHTLWpiZqsh1NOBUOupWXmrNZQKk27lW1kDLGLBCXbZ+X9l33Qbpc94pqQbJ1e8wJNuGRqmL2qkxOHtJaaVI26kXlz74Wy+sOPdhRos387meZjgTzE7T5pRRQteR08plYfnKNZVbWmLaNmVM+m/lStKdAG8NSTIC+B1KfYbUcnWqvRobSOL4MHsQJE/4zoz9jWVFz/i3BKSk4V2cSHwTcwHVnU5hZ6a/Lj9FZzs37A4oANkVZm3v70P8NJgDgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91jcMth1kSTftZLe+MHMaPHlHcq7ucIZojj/DETCc0Y=;
 b=WoSSCS7daG6VDI8Ct8I2ONJ9sASMPu6J+GxKATIuW/UNoWnB0iItQjtuibH4a4+CCroVadkXc6oQ0Y9rWtmGx1iss0rZc3Kwibkse4pJ1bjaQXVM6CX0ow04C89VlHYUbxMyGj6imXZ0Tbnj9VLrvFDYo8uT2jL6Qne7eMmGdr8=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 08:34:58 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028%3]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 08:34:58 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: postpone entering fullaccess mode
Thread-Topic: [PATCH 7/7] drm/amdgpu: postpone entering fullaccess mode
Thread-Index: AQHWAlm3UAIMCCF1xUqGXLY/TBslx6hY+6PA
Date: Wed, 25 Mar 2020 08:34:57 +0000
Message-ID: <MN2PR12MB2975551EA5410A1AF2E265098FCE0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
 <1585108722-19098-7-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1585108722-19098-7-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T08:34:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0bd64f7a-7d5c-4b92-95e9-0000f21d008b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-25T08:34:55Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 720bbb42-4327-4351-a984-0000cdaa0b8c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc007d84-739d-4139-829c-08d7d0976714
x-ms-traffictypediagnostic: MN2PR12MB3823:|MN2PR12MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38236B9B6EE64285E695B7E48FCE0@MN2PR12MB3823.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(8936002)(4326008)(71200400001)(55016002)(86362001)(33656002)(45080400002)(186003)(478600001)(110136005)(66476007)(2906002)(316002)(6506007)(9686003)(26005)(5660300002)(66946007)(7696005)(64756008)(81166006)(66556008)(66446008)(81156014)(8676002)(52536014)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3823;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xEngxfHwd63DI0W9N01GwB6vNG4G1v2WY3NnwEJKIdoeE5VIy0CHitBt1nfjehfMvAAbHhkIBGcpQDLtca7Fx1k9KunU1SxUKLpnMMP/YpbLVrA7e7Z53vPSlGPDsuox6IdkhEmBRTic8MchFJgy6Ywflb+MBK3PIj7cjOvtJuqjN2zaO83ir4iUV5yIexcSSIPsBAjSTbrR1ZJR/0hdKYSI4yviMx9KSMOKJoX7N4jruPUOCRbIkHdUwLQ0TCqnAIR7awU+X8eTW8gnywz2e4pG4iv+aAvMCvg96ohDdABqYwoabGpN/17r6so8SI8MTs1CdrDCGj4uXljVYTP4Rk8OQNnm+/LC42ATyCxrLaZobCVAeo98nJ9VSIm+50t78xcGS5reYpN8tXWdbyma8J9IgPyBt/JefoIZxXM5S8dkyWQGCfq1gZcJp7FcuDx5vzv4vSkzKkOqGJOEOIvJihH4ZNs0tK/JnmqiTNsIxOA=
x-ms-exchange-antispam-messagedata: bvrn2EX0aTbS1YtgMBLcD6TWhKLfB8qqHtzocBMBfQ/3DTANjNNykuUE0XKdMmxeRqaijFHpGazCxYhSl58rJV1ag++ZyvY6QOOInsoROkqCxvMrh1i0KXNoQIolFZMxquqgGPETWl1/OCz2aP84Rg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc007d84-739d-4139-829c-08d7d0976714
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 08:34:58.2681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v17N/fEwF3nqv9PP1ilJ3acpkTZSeOIDXQ8R3mro1elnRMmG1jJ5CluEUbW6ktaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3823
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
>Sent: Wednesday, March 25, 2020 11:59 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Liu, Monk <Monk.Liu@amd.com>
>Subject: [PATCH 7/7] drm/amdgpu: postpone entering fullaccess mode
>
>if host support new handshake we only need to enter fullaccess_mode in ip_init()
>part, otherwise we need to do it before reading vbios (becuase host prepares
>vbios for VF only after received REQ_GPU_INIT event under legacy handshake)
>
>Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 724ad84..b61161a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -1814,10 +1814,14 @@ static int amdgpu_device_ip_early_init(struct
>amdgpu_device *adev)
> 				return r;
> 			}
> 		}
>+	}
>
>+	/* we need to send REQ_GPU here for legacy handshaker otherwise the
>vbios
>+	 * will not be prepared by host for this VF */
>+	if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver < 1) {
> 		r = amdgpu_virt_request_full_gpu(adev, true);
> 		if (r)
>-			return -EAGAIN;
>+			return r;
> 	}
>
> 	adev->pm.pp_feature = amdgpu_pp_feature_mask; @@ -1977,6
>+1981,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
> 	if (r)
> 		return r;
>
>+	if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver > 0) {
>+		r = amdgpu_virt_request_full_gpu(adev, true);
>+		if (r)
>+			return -EAGAIN;
>+	}
>+
> 	for (i = 0; i < adev->num_ip_blocks; i++) {
> 		if (!adev->ip_blocks[i].status.valid)
> 			continue;
>--
>2.7.4
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
>desktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C800016a97d6d499de
>adb08d7d070d87f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37207055405387207&amp;sdata=J0nRbxV4lfqMe3XLszU7gIGpnookLgz9DaRJ4P
>WHRhg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
