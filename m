Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C93C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431D5206B5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dzsAzA9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431D5206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F926E914;
	Thu, 20 Aug 2020 08:40:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63436E914
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 08:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuFUcarFFam+S0MMHzNomNfM/pU1sizqvO89EfdAl77gVkYV9dsmmK3r4qEC7qIf7oPjIYgz3GwG9G2lZ1yy9Doz4FfFRPlr6Mi3N1VvuQSyOntnLUEqPX2IgXK/rpqOQ1tvIZbLd010gDGnxb7ykGhP3Rdxh4NLEo8YyaoqkMx/Z5JZ1DxhydKi9+KZA96geyIpToQvPTRmCqKtTl6ab9SsoxNx36hwvDYSCL6l8cl8iBhNJsmxZss4Y/89jyGevVLrbyCll8CuC+2ErpklUdL4RKO9rD6GX1UvmgVUOilfsgSYkB0qeKBhwMyGsRTtysyxQzvM29zrbidCYZV97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ2w8q7Wtm+BagdFscNivkfvhUMXZs7QQbMDFbPEvqY=;
 b=n5Gq8jCoiuJ/rG2RBhLIQpUWpw8zR5ngZzpiOQl2SUzvg1MtWKbPyBxn2vCREgVuLl/vNB2Gztggjyl/qDJS7Ji950yyeUAfZ9Gn1EQh/MjntC9SEix19GUQiJiqOLXQxKsK2bHhvhxY3nsmE9JqlQG3CRJppAM8ezDSeXzBe+W0WgJYN0YljYRf7E4UdnH0XIAX3BZLOZ4XhlLEsGbM5gtjoxKYCMWiPeeOMpFRiTKnc/JXkq9MlPW+GKSVDd2isgTalAyhECdozakijQdHMfjETU5xXHTsNHva+nvKnBBO/B5SqzCtBDxcVjJlYWH1R2DS3aO7pnKWRNAKjohiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ2w8q7Wtm+BagdFscNivkfvhUMXZs7QQbMDFbPEvqY=;
 b=dzsAzA9uFvyU08lO7txEYUs1FnH/lkBWU1DeMH8Xn59EglgNl2hrL/RbYEFDbpjW1iDIRevgwScQ3HAYAUvwc14kxQpYZ4pI+Vj7BJBWtgXxFims3LXeNefDPlfqGjFsKaOqTDgUnQ0ppQIRNYVieBZFDMJJ+2tjZSF16RerwYE=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3673.namprd12.prod.outlook.com (2603:10b6:5:1c5::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 08:40:28 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 08:40:28 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU
 recovery
Thread-Topic: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU
 recovery
Thread-Index: AQHWdpiI+3rLGz2VD0y65Dvrls2AG6lAqWsAgAAAscA=
Date: Thu, 20 Aug 2020 08:40:27 +0000
Message-ID: <DM5PR12MB2533F50DFC7A07A94EAFEABCED5A0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200820022041.19161-1-Dennis.Li@amd.com>
 <DM6PR12MB407534C794E66240356AFAD1FC5A0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407534C794E66240356AFAD1FC5A0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
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
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 364a2b78-b273-4ec0-f250-08d844e4b0ba
x-ms-traffictypediagnostic: DM6PR12MB3673:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3673F0A73E8232F82ED53399ED5A0@DM6PR12MB3673.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBXRg2Wy2z98n9vjrZDdYhEeXUUc8ajaPWgOgpvLWFpDeidQ+L1Y2lRdd23lzVJgSCHy+2en8niLjBPXVPvO/okkD1tsV/YObMNrBCYWTWzTwUXcxkuQ3TzI2VZfGFsVBjb/B0Z0/i3ob2wxG+Vud7Vn2e4pSCRxBc2U2xLuV+VtozvLIEy/OohyEJET3kgkYSr4+3Tu4QhcW+ltPCRE1hxOGpGrY8ImkxYzO1TB2gQAVVlDROBL/bMA1c2yR/i8lwk3/a1jdxLaEVjinDNUv89n+U9f3TsI+Jx0OFfcaBEES2LWdrO0f0KNN9MkijDX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(7696005)(76116006)(66946007)(6506007)(6636002)(8936002)(71200400001)(86362001)(53546011)(55016002)(66476007)(64756008)(316002)(26005)(66556008)(2906002)(83380400001)(8676002)(33656002)(66446008)(9686003)(186003)(52536014)(110136005)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4YiGgzHCHy8RN4FisK9RscAeV56sIHTU9TdvS/Hm8RGqhHsxEHuPtYvgCdFZl/Sn71ozrwUttXsh7aaLOklT5FbL7koB38cp8OoxHGlqLVX6u+88O4s/WreJo36oLQOT6rZURPOa0UflHOMROhAmGvNtt5neTS3JjDndnEmssFULZUXgmp2gCfMiQc/ncYUzNcY8ChbZ4xsv+BFyr71/kmdyw5uVo7zz6wI7RXiMchmtjUTXiVdV0g1UaRHIzvte8exytny1R9t9A5Zc0v8bvY2AionCvJ31ylqFSBCw4Hv8qcf9/jl2uXIEe9K+R0D+nyd9N7gXTRG/+yw9z0s2xB504pY7331YQ5I9txUbEYJnf9K4GY4j4G1ZPQbIa/LZyzlU46Sw7+SygPdk/DR4IB5o4yOA7M2AgFDzW8Vo4N71yaNjpiAn3BUQHgnYnJp0lKlJiY08vgtcsA7ZdeWW/IAWp0zVRQ/CZJesbVa+NP0GOGtm/7AxBR0YLlHrja/IuqSrmn/6sE13OX205SAFyS9JbdhyESVQg3UwM0xu7VXY5r55M+d69hiXi/Ad+UdtHuyegWXD1V7/2lrtc5z6Xg1oBcITyJ6JZtEH6pGqL/vb1QbII0Yms5Bgmob98gCma1Irr39v1VgObCjF14T0jA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364a2b78-b273-4ec0-f250-08d844e4b0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 08:40:27.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ne6tj26l13xLFnhs6hXrmerfMmyw9E+lyCr0EBEtg8h5jh+yUWjsEBciG8Nwdj5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3673
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi, Hawking,
      When RAS uncorrectable error happens, RAS interrupt will trigger a GPU recovery.  At the same time, if a GFX or compute job is timeout, driver will trigger a new one. 

Best Regards
Dennis Li
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Thursday, August 20, 2020 4:24 PM
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU recovery

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
