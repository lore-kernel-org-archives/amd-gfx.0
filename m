Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F9CC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791BC22BED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wUjY5IFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791BC22BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3450C6E91C;
	Thu, 20 Aug 2020 08:24:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1286E91C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 08:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaHkGqpFiVOkpU+QcX7IUeMNhm645IBj/XxSTh3chK7Z+lRrEyIOjApFFgnHEnZZ0epg+Ffgl93HKofztYmjA4zDzoG2rM1hug8brtSr9YYeEc0tf45BMBK0cLVwP75PFQKiv360OwcO3TBiGqhsex54fkyaZGlViM4e7J5z09COZeIYE3eMDiiZtdwDYluY3eGFCd8CNkBiE9auRcm4ZuLUPHSSb/AAxFFU0MBP6tSZ4WQDydD7DY3WwsI+N21zwdkH0Od6Ygda/07Ky+UbWBtEQo45riM4hyC0LnREbqEnn97oHG10Bb3kr8v3e4dnSqxPn9d/KtzyfVl9qvSwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeAtkr48sFapfwhF/TfHBD0cfNibib2HFnxQpe+Ks9k=;
 b=iOF15cBUjygwAUuClkXBWd22vfLBT8td3rhgWdDYKoWsB7UPA7y13zp3Zw2ra6CtLb3dNzqBqE1ELxSaMeNAgyV3bLs4WR9elYpORMgK82HNW3ZnpimVLHRUYVV0irbN6Z8tT3F9+3poJxpbUWBDjBOsAIQHdbVvdLQKtWcXYxh+VTycQ68ldE7uTN36sWgfRsS8D7p0PhwEU4pNyLlEbYPMyWFKRNUI8XENFFEPxhZLgyG5hiI0Y0lDg8dKZFna7JxHvAJ+rsQOEm3muDpS5rtxHrf3GiprDLGTK3GvWaSb8Iqit2Xr+enMWMM7u/VRvEIyGsd/Bi20Nsk206uVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeAtkr48sFapfwhF/TfHBD0cfNibib2HFnxQpe+Ks9k=;
 b=wUjY5IFlhibvMzfo5Usg5tNkpxv7BB8gROScypEGCX1qCkXHHP8PUNRpkukfEmeqMkRiLuXYLx+9wbTlACbd/6YysNLeaxzD768J4i8z9GyIi9J/gRbRT6B/4AjfATDHjoOlFuailbSIiJ9GvFPhF61aEFAopbHzw+61xGy7tzE=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 08:24:23 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 08:24:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU
 recovery
Thread-Topic: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU
 recovery
Thread-Index: AQHWdpiINOJr0YJm9UWBlrzA+75TsqlAqRpA
Date: Thu, 20 Aug 2020 08:24:22 +0000
Message-ID: <DM6PR12MB407534C794E66240356AFAD1FC5A0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200820022041.19161-1-Dennis.Li@amd.com>
In-Reply-To: <20200820022041.19161-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-20T08:24:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a031eed9-41e0-4d28-965a-00003ecc9751;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-20T08:24:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 74859efc-eafc-4c26-ac0a-00002ae9595b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-20T08:24:19Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6d6f329a-0cff-4872-b5e9-0000d6e431b0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b30fff23-ebdd-4280-9b97-08d844e27185
x-ms-traffictypediagnostic: DM6PR12MB3963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3963204A9E3C0E82B25954EEFC5A0@DM6PR12MB3963.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YaKX3Vgi8A3lgoujcFt7EHk71ZsX+Zsbbr0lG9m8e8qvs0jBQW3XsFHfqmp3rb16BnXByv2blsYL+wDftWF3w+eTWyNTH6ZBtQugdKJ6AUNvLlTFylibL2UJ362gtRsj4bjVfPvcKW2g9ZYcQ7/RkLcHRS4l7e3W7KmEjUsn5sNhnPtLjzktEf3983Rn/FXvk5MrRxd1i8vHng3ldt+jwb8rl2tdmJyegWnIVfWVnj3Sjgiq4y0/sfeNmOTgajmroNbDi1r1a2pMDJx0WHKoWb0Oj+ye3zuu8ycNbZ4OiTYcVz6SeGbZPZEzcsr20Bei
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(33656002)(66946007)(83380400001)(76116006)(478600001)(2906002)(71200400001)(5660300002)(55016002)(66476007)(86362001)(8676002)(9686003)(316002)(26005)(110136005)(66446008)(64756008)(6506007)(52536014)(8936002)(53546011)(66556008)(7696005)(4326008)(186003)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dJ3N19tR80OZXaxXlgxRp/uyfOxvzSdXvzzjV4Fe/z8/bFAS/ORKBm2iZz8arEdwGJrCKiJ8j9vPJWXxxeapfItbjK3tlsxDiIlDjYkoPPhWdnAufwrUjqyh2qTMO/A8hQLwgyBPD0ZFwsJVK4WlhV02j7kX/zNakClJfW3DNq3FBbIwkMbCA9AEuLdmsHEscbdA0IyHYgDVLtybEcdp0qyWoJXcYESa01CFTkzp1L9udW5OxupO8Zew3KrXgxOhnMfKIB668So3eHfuJzbdHnetkAfr/EfV4gB/U833ypW0IOvnBn2TQQpn7eLhZrDF/X5BfkcIMdSqiCNke1sYb1ponhsTLmAEooSF2GgfL5X6jZ44/hPoDIJWLQT8osOfHhS+OM5YJjstvzPdiyf1dfHL0HmY8i5n36lYzHIb1lS11Vohi8bQ22b7h2op1uUMKLzcuMYWJkpUMgfdARhgp1ZZdf7mpGMH8xEC5L4WsxgwlxuBhEREtGiU4lf0r1+uYo1PR4lL+I5CO8A8LFfchhatquYT/ZgP3bwZfS7EdTbAnshD7C1OEj9yeize6MkkpZO3EEFoqZYZZxTQ9IrMvPNjQGfs5lcYe5vxX+jp+w76FOH/XJzpUIdKEIJ8e226TsibyAFOXabvfFkY/FtrAw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30fff23-ebdd-4280-9b97-08d844e27185
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 08:24:22.8932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12U1+gxK9kKnnHtSBKCBQipGWK/hKZr7Jx0i7VGwkon10stGoNDKW+yaz4CF3xEjFxFqAZErGrHCTLNp+7jOig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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

Can you elaborate the case that driver re-enter GPU recovery in sGPU system? I'm wondering whether this is a valid case or we shall prevent this from the beginning.

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Thursday, August 20, 2020 10:21
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU recovery

in single gpu system, if driver reenter gpu recovery, amdgpu_device_lock_adev will return false, but hive is nullptr now.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 82242e2f5658..81b1d9a1dca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4371,8 +4371,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (!amdgpu_device_lock_adev(tmp_adev)) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
-			mutex_unlock(&hive->hive_lock);
-			return 0;
+			r = 0;
+			goto skip_recovery;
 		}
 
 		/*
@@ -4505,6 +4505,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_device_unlock_adev(tmp_adev);
 	}
 
+skip_recovery:
 	if (hive) {
 		atomic_set(&hive->in_reset, 0);
 		mutex_unlock(&hive->hive_lock);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
