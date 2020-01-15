Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A347CC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 04:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFA724656
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 04:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ig6ZJdhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFA724656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31ED76E84F;
	Wed, 15 Jan 2020 04:06:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBF16E844
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 04:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPAXh+zw19a7OkM3NV5TBpznQgXFVUgTHIOccu4eOph0Iku2A1WHJYEMj3+cdzUPxumln6yt8TkyQWoSLTTGZ8i4zG1aaVbqUtYixGyV20bFLzcf4vwkhomv9/utbTpYQN+6upJ7jaUKWBSt4+08zVc19rbuZVzKHuYJ9EA5E7BvOTx9gMujBtojquJ+MPamdSb6Ef0SG8iKHKbhdO+sJrE5uPb+G4QL7QFNIp/IJNZN/cIP0QiRk5b3UztEhY/HysQq3Ybc3UUXe7xPAxgb5UcnuPGjtGQlGSRmFirC+EZ1UDq/MGxmUFyIez3E9skIlqf7hMp6kCShKsFfYHoUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA0OqqeLudvk+zyLdOnLr8Fzl83Ca6fPxPDdNoYq+r4=;
 b=GynHebd/MQ6Cu+08Q9pjKkSDiiJkbKZNncXxJtLLTqqZvsZV64K2Lr5V/u1FVll+jMBaAM0zXE6P3vq0F9fzJyNCMkvhpwv6Az+ZyTZ1+X6wViN7dwExkWAHPAZvrUM+bL53Kgx/I3saE7Y3cIMHUBUW4hXmp0nt47OHpKdt0TEvukCM88dO5NYCNSC0TLkzc4g2KoaR007ihWzWoOkBTPBV+HLgr9VWjpehu4YQkbpc5U+30ECa7Pd3Q1cDWWF7V9MTt2vF5ZWZI1paJVDNokWnSZd3K+OZ5SFAPJ7/lbGB6kLa59s+TFhHnDtJCvRjl+TIxwkyMOhm1XylPFZA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA0OqqeLudvk+zyLdOnLr8Fzl83Ca6fPxPDdNoYq+r4=;
 b=ig6ZJdhWpJngzxAuBeL+MLdnPBQukubuAtOMaz1gkPzEh/d1q869KUiWoPiNDm/XIBS2lDQoJ8IXHPpn9gcZBt94J3NX7PMUOp5jQcitCwus/OXHbl/ADH9JvfJh7pWLabfrcJ1HBx8dheNzAwqSdxqkUp0JPd3F9ykjbGtzQng=
Received: from MWHPR12MB1424.namprd12.prod.outlook.com (10.169.206.135) by
 MWHPR12MB1342.namprd12.prod.outlook.com (10.169.204.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 04:06:32 +0000
Received: from MWHPR12MB1424.namprd12.prod.outlook.com
 ([fe80::c95f:57e0:d490:6abd]) by MWHPR12MB1424.namprd12.prod.outlook.com
 ([fe80::c95f:57e0:d490:6abd%2]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 04:06:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Thread-Topic: [PATCH] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Thread-Index: AQHVy1ascB7HT2LT40qbdnbQ/uDcIqfrG5pA
Date: Wed, 15 Jan 2020 04:06:31 +0000
Message-ID: <MWHPR12MB1424F0F3CF5C64F4304192FDFC370@MWHPR12MB1424.namprd12.prod.outlook.com>
References: <20200115034827.7187-1-Hawking.Zhang@amd.com>
In-Reply-To: <20200115034827.7187-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-15T04:06:30Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a643485e-d3c3-40b9-8ccd-0000ed297916;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-15T04:06:30Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9bc849bf-c116-4828-bf7e-0000e2093e5b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b0a36fe-b646-44c9-d04d-08d799704dd7
x-ms-traffictypediagnostic: MWHPR12MB1342:|MWHPR12MB1342:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1342532C24E8B43EA72DAEA3FC370@MWHPR12MB1342.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(8936002)(33656002)(86362001)(316002)(53546011)(26005)(186003)(64756008)(66556008)(81166006)(8676002)(66446008)(110136005)(66476007)(81156014)(66946007)(76116006)(71200400001)(478600001)(6506007)(52536014)(7696005)(55016002)(5660300002)(2906002)(9686003)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1342;
 H:MWHPR12MB1424.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMigFHsMVyIP4GSnj4XTYIN1LWEV4BztJJbh51+x1OfV+HbuKy2bq0xBLu2OSEYXTpOd2Tes0uzR0RHlHXuCn1eICUypAmmsLzVME7ccm1PmXXAln/c6SmP4MODeJwV56Wr65AsshRuA1g+37X9hlJ+rAJcWp2YmI5f8erG0rv8W0IzA+9yg5flIOIsRayp2EuMGJZV3LbWJDbL/sFnlLDSS9PUZxFyDMNwNxQ3aNcSwCo12hu9MosvpugxVw/0cDzSs0DRTwHuwP6RYHxvlDWnb8lNdBC7sjRtWcWJKd/WFPkoPifXo9RuVmHqJEbz9wNjmBfd8QajJflhJuh0VUNVS+IdYnMDmN545BVlgBRx3CSLQr0fTreP0VY8mimSQ/zpT6ax93Op5Nlf5qupiPu71QcUo29AcIQ5C/AJlMMJ02wMnInTPiwsRlBlg9sPx
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0a36fe-b646-44c9-d04d-08d799704dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 04:06:31.5881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFsYcqSwlIjdoWUHrynTxy8pZs5wpzxHVMq9nwHuLCgN6AVaD+UFrV/gfNkeMW3DQhJwPfu6Ub7C5C7Dm9MhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1342
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

[AMD Official Use Only - Internal Distribution Only]

Please ignore the patch, I will send out another one

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Wednesday, January 15, 2020 11:48
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: check if driver should try recovery in ras recovery path

To allow the flexibilty for user to disable gpu recovery in RAS recovery path by module parameter amdgpu_gpu_recovery

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 706a30e81fcc..8e2f0a380461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3799,6 +3799,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_VEGA10:
 		case CHIP_VEGA12:
 		case CHIP_RAVEN:
+		case CHIP_ARCTURUS:
 			break;
 		default:
 			goto disabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac9926b3f9fe..492b3ba685cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1356,7 +1356,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_ras *ras =
 		container_of(work, struct amdgpu_ras, recovery_work);
 
-	amdgpu_device_gpu_recover(ras->adev, 0);
+	if (amdgpu_device_should_recover_gpu(ras->adev))
+		amdgpu_device_gpu_recover(ras->adev, 0);
 	atomic_set(&ras->in_recovery, 0);
 }
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
