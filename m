Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4323C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 06:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B48206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 06:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4UOxDQvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B48206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F656EBE8;
	Thu, 16 Jan 2020 06:09:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20636EBE8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 06:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6gkwiI2LT14mpcGojnkxR7DsopoelzqAeyLKHUiJ8QQVTpI54M1t1aUA030ZT1+M8R5h5nj7deIWKhIPaMX760YMNmly3IWGOfS1xRUSZwyxCl0TAZ0oVqHLmxH/VOH24R3fTCjE3sr+9WsunjDBDQaV8sivSjJYi+dpRabKb/pRv2ILIL7klq17/DMuh1jy7e2wCcpfLortOnvKw0rxEqAJuAQwSh+JX+yeeLUj2Fy4/wFZ1RIlsR9ZgVYWZynxMkG9NIXCHBpVkliQwhJYqCRQDjldEdb/1h/br/aarz1v5TqG3hGbCPVoSpJ3/C859+jkdZ3Z/0TUeXd9Zw0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M0QiQbsSwdCiwkC7jcpiWsv+GMzD+jTOsygQfHKcYE=;
 b=NfX7+IKsQPxhJztwSSklCvSbD3Zqs/oxV4Sx0E1ERMgseBQOd+dmYCXaeUpQrkpOoVkggkIaNubuGCkbTWlvVoa0/60vmJx+ZC+l1dNmKV++1aXq/Ohe88zoVHvmKY0DeYHHotGQOUaTTT2hNi7yrV+BiPrY5BMq/+qk8mQzZDRuMVNhJhTQNseKZvk14HfdxPQnAWwx6A7Dg52/t0MgM5qtciWG7kKHZhu/INFsMYXAgy2GkTP+lhZRa15ZMbGrJ+gnmZ4AqgveGYH5mTG1Ym3el98lSdpvmMlR8sebtZsIIna0Kohs5Tguyjt6lfreScojI0C9pu/bTxTMqW4y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M0QiQbsSwdCiwkC7jcpiWsv+GMzD+jTOsygQfHKcYE=;
 b=4UOxDQvE5MM5Odmf9Ibd5dlJkMufwrxsnGjMbqA1bdK8D8U3dYSf7E4p4c7pP9WfLmwenQ4OTzz2xneZbXndwnb8XlFQlFCXiN3bxBmsC+WMkJ2XaF14TQFS0of8pm3EZL8B0Q5hnfzVgoxFOGDB/3csChP3HbzA84q4bQ5BdfE=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2655.namprd12.prod.outlook.com (52.135.104.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 06:09:41 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::a0d7:f7a5:5d2d:752b]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::a0d7:f7a5:5d2d:752b%6]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 06:09:41 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add the lost mutex_init back
Thread-Topic: [PATCH] drm/amdgpu: add the lost mutex_init back
Thread-Index: AdXMM3R2ar8RTqN/RB+oGoIMPAFrEg==
Date: Thu, 16 Jan 2020 06:09:41 +0000
Message-ID: <SN6PR12MB280058965C66589B199AC18C87360@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=92bde98d-97ef-4e31-b1de-0000e258c821;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-16T06:08:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b66098e-53b9-4ed7-0b44-08d79a4aacd6
x-ms-traffictypediagnostic: SN6PR12MB2655:|SN6PR12MB2655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB265508FC5D9A505E45DFCFE187360@SN6PR12MB2655.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(86362001)(5660300002)(26005)(6506007)(4326008)(8676002)(316002)(9686003)(8936002)(81166006)(7696005)(186003)(71200400001)(66946007)(66446008)(52536014)(55016002)(6916009)(76116006)(478600001)(33656002)(81156014)(4744005)(64756008)(66556008)(66476007)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2655;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyzMEms94hG0aJmNXSI7cH1S2OObhZbQjdBoJ4vlyt9ADbtsJBXwf1wiCCPXn0H6djN1JMBsuYucbco8vCI1p+Ar6CpM6ymhvpFOEv60dxz0dXHDl7H+TVkhCbheDKmx37q0bFoUXq2NFTTyzqMOqQYoB7nKVBpKuaKjvEN4kiKNIgYTx/DlDFWaQQkYzFC3cq54XVlFk/ospFktci/+GNsR464KbWFiN9qvziusmdnH9MHKhYOxF/Hi/wqs1TRKCW+CQDV8nbTkLGf9bkuDjj8WyLPVAAA+de1cYG3RtSVbPuof/AGLpBDIXYp/Kxd6S4RqsLrbu1IyD5OXZmX7UvLSVNVsFKOVSk/ekNjoW2iMsaNSnEgFpzkUkVsF7x8km14rSCpV0ihT2sdejqLQOnWHuu6DmZGxplZjpYrX+Ntl1trd6+KGdOAQUzAr46yy
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b66098e-53b9-4ed7-0b44-08d79a4aacd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 06:09:41.2798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nY4xbheK9DWn8+ZjRF3GgWNHW5GN5plEV9eSCBtmGDAwEoWShs6+T8r7mMbyyuDK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Initialize notifier_lock.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2c64d2a83d61..c2453532fd95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2851,6 +2851,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->lock_reset);
 	mutex_init(&adev->psp.mutex);
+	mutex_init(&adev->notifier_lock);
 
 	r = amdgpu_device_check_arguments(adev);
 	if (r)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
