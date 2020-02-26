Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D5EC4BA0B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 06:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EAE21556
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 06:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0m4k3Xwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EAE21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37F889CB2;
	Wed, 26 Feb 2020 06:31:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48006E116
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 06:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/IuuSVKNZCJAJg9aZsvjxXvFnAZKmgTRXLiLkkt9f5R/ENC6G8Uk0wDm7cgOoOScFwp5qz+mL/5HRwNQ9HqLGv8umQfGWTHTrRPofB6xg+9hoNdc7hZAb5LPTJYFXgfPekL5kyMVRNQSljGjSOds5BW/GKUgJT6q8RlqmZIrs6sra79CJklHeIoGnEaQi+StRTHiLPRGKVBZFR7nwsIhdCUq62e59mEednTV+mFFE78FujqLviR2NKYKCpOE/4e/9Rtj1RyKL0UrZCj541qz5pTe/Bcm+X/tcVKdwcQ9WZMYlVAxPaBHK7Aik8nAcKKSuzJgBc6TQjRPOAOWJbYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz87kVmofwcXZYeJdEI2RkQ7nBTgMdAOIqz6n9CrYrM=;
 b=YncrCNHO2G3ZfHeaDYIgHqNAcRoBUj8JOKrCg6zdxBMhekVS2J8BOL2AknKUsXoSFAV79hyBsjyDDZ+afqVOfF+EbC+roZpA1ejja8Cwt1ODsgFprx2okSeJSLHHKkuOcoFT7vs87iT01hfmMsE99V1Tknn9UfCvJwTI+TyoWrVAo8zGyoiWrIi4P6+z8FPqH1DvKWwWNMzFMHHe7yMWttLCUwHBQCoTWVCcmmWWukTMOOq4R1rT97rxkPxBXnZQJz6xMLiW+4tQ+lfA5qW4oRB7G+7Qz/5Uyyb4CO2ZiZS3fX1QFpi7SWzd4kKgACx7XBVL47kL4aZo+MDF2q3v/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz87kVmofwcXZYeJdEI2RkQ7nBTgMdAOIqz6n9CrYrM=;
 b=0m4k3Xwxy1h53I73BIeo1PE5kNpdq7s7/Gm3nFfHMBqa6aRrjQn1S+g87NRZpW4SlMvnbAjPupbvSo+e2x8lSoazqloK7MICZdVldIq40YGyvEIRZlM2EdtlWXhfN2reufO5e6Ydhj6ZQjQwy1jLUMQXsP7Z6tgeOxDcz5yYMaA=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 06:31:24 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 06:31:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Increase timout on emulator to tenfold
 instead of twice
Thread-Topic: [PATCH] drm/amdgpu: Increase timout on emulator to tenfold
 instead of twice
Thread-Index: AQHV7EBmo41WHYqVq0i118CxP+DHUqgtBCLQ
Date: Wed, 26 Feb 2020 06:31:23 +0000
Message-ID: <DM5PR12MB1418F5648ED3DD612B7AB8D4FCEA0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200226010118.30936-1-Yong.Zhao@amd.com>
In-Reply-To: <20200226010118.30936-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-26T06:31:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=236288a9-685e-4a05-ae6f-000078c7cd5d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-26T06:31:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d0ba13a8-d3fd-41d1-869d-0000228258d0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39f38862-41f2-44f4-9d62-08d7ba85803c
x-ms-traffictypediagnostic: DM5PR12MB1835:|DM5PR12MB1835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB183546190C6EDB47701BA05FFCEA0@DM5PR12MB1835.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(66946007)(26005)(110136005)(186003)(64756008)(9686003)(8676002)(66476007)(33656002)(55016002)(7696005)(66556008)(52536014)(86362001)(66446008)(76116006)(8936002)(2906002)(5660300002)(53546011)(6506007)(966005)(316002)(478600001)(45080400002)(4326008)(71200400001)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1835;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yuWBeAxDUV5KUjdFzOiCKpMzzVBSDQdL1+38BqeKxpA60UQJ2ZhjnAFaoCfKDzOggDseruK3pwBd4bVk2QEB5fcvb3PGkZKwW0xhR9SuVmzVOvEZV2lrnjE+VhLPJsyyYR3hVwefdgYBOoyKadf1P2Cf01imfrTCzstDI+DUA2Wx7lTL9YeGUz7awe0vZTMEyqUjn+9awmDwSSIwEKwtakIrWMEx9dcwGDpzUUVsYKO9Kem6httFpEeeJMSNeQhNOd8LW0i6uGs2nO1uCYP6B+p73GxHv0nM1EvrDyi0b8f5T+nbwFZTt7vz6/jToomEsD+yIeP5M9iTxvZ0RyuHj1Z9nrFptQgAk7orzDpU4ECPgdIKe/dcuawNSzwo/KLEvw5RXci9DQEpW020wE6a/AG5W7rp1HlLkhshtBcJ1/pzmqB/Nay8/Ymq06bKhNMD9bflkkDND7HiIR9JR8cTFcbZxu261tNnfPeV3HrKnv2oR7BOuH5vN7eOIDqMi/P+CPIAjbUNjZZZL/F9miB6jg==
x-ms-exchange-antispam-messagedata: 3xQOmZGvsVBQ3aaeHA31NBCLwjqFZvr4YwfKj5ZEC1GbdkTg+RSjX7OqgvVtbwgNGK4r1yyHukO8XgfNRZL/1bqA7UhX05YgI2CnQ5FBxKkECKRRD3Zw1KMyrOzwJNhGUdFz1h4P+MTJ6N521dYm6w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f38862-41f2-44f4-9d62-08d7ba85803c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 06:31:23.9188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlucM4U//l1+Idg7wQ6iFDNb6W/K160Hkkl1/KTkxjKLZMY1JxhQorV6+1OW5MIVDd1qSErSpjmFmJmfRG4Afg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yong Zhao
Sent: Wednesday, February 26, 2020 09:01
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: Increase timout on emulator to tenfold instead of twice

Since emulators are slower, sometime some operations like flushing tlb through FM need more than twice the regular timout of 100ms, so increase the timeout to 1s on emulators.

Change-Id: Idf1ff571dd2fe69d3a236d916262ad65f86c44e8
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 28a86752567e..8ef8a49b9255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2834,7 +2834,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	adev->usec_timeout = AMDGPU_MAX_USEC_TIMEOUT;
 	if (amdgpu_emu_mode == 1)
-		adev->usec_timeout *= 2;
+		adev->usec_timeout *= 10;
 	adev->gmc.gart_size = 512 * 1024 * 1024;
 	adev->accel_working = false;
 	adev->num_rings = 0;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C196f274fb0b34205057f08d7ba576d9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637182757404018425&amp;sdata=I5vty3fNhVJEszpbVqz%2FVX0lzALKEjyuDqRONZvE1CY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
