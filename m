Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643D6C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 04:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FC3206B7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 04:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S6AuARNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3ABB6EBCE;
	Thu, 16 Jan 2020 04:47:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FCB6EBCE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 04:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB+lCPCuY9mPfgEBYFloTcMJEOrjFDHqwUotk/4Qwx4ycTTrPEYePcIevT69hRE9lAvf+aTU8lFaWjmhXd8/Sy3RwuFIcT+i+le8EuAHdU4jaJ14AIhIsNEcDYqEVpAH/WJS1OsLTeGqZoRvvxzFn9L/J89bLhRkfarrmhj3JmOYEpngdSTOVGUCAYx/I3ArT28mBT7AbOZXxe2g45H2ipSmRSZifoXs0AQcTJaYp6I07B8415HgtM9JBYD2eSBm9rDoH6v6QsLLmgydZtyn0GH0zkgPTso4p+sX9V/DDv6wC7oX0S+3Tm5pzPEnsLdGS/n0AYB4tpIJlw4KVeNHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHZJbhYph2giNdIkNR3b6j4SLREHrofjaey9KKa/aRo=;
 b=UACWuCkROLx79Dx5ZF85wb6/4x3D1XYBJ8ZMBoc1oHwUFZkAs9nav7f2t3EktiG5U3L5HnJ4DLfKjO6wLubIhuE5YC34YFABZ+7aMhIllaJUSe0CWqcaKITMFtTAfX7o7RruT0ILtrSh9DdI8nLAaWnhcpCiB3SwKSXhVsfPMxmMaqCmidatyOe4/2/kQEosUtQ9KYDyCZdYMJqDaj2pszH01rAI359SJC/h5JYqcAv5U4VcdFNbpu0MQevgGj2M+Rn6tfwAtwT5hPOhS35YulEF49Njdf4VyuRaFufxA5T0MFFL6yOiCWwvQdLUuRd1vuYfDirE78KwqNmaqSHHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHZJbhYph2giNdIkNR3b6j4SLREHrofjaey9KKa/aRo=;
 b=S6AuARNdULy8c9aRZvYew5n7bYiT7FrdgK3MuJcNOqKekzMTNsIMHzo6pIwU0ZkwsUfBh/2b6TwGDA3vOoztnZJf43okQESrkmrvoXYwkD4/mgyg99cYgYJ/3xdNeBd3i2yuNIeGrmFNk8K/pBCNcSLagdYnkW/+3y7K5KnDoo8=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1692.namprd12.prod.outlook.com (10.172.34.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 04:47:51 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 04:47:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Thread-Topic: [PATCH] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Thread-Index: AQHVy1tAqNn3d4sW7kGMx68HrIbfwKfrWlIAgAFfDcA=
Date: Thu, 16 Jan 2020 04:47:51 +0000
Message-ID: <DM5PR12MB1418986E8BB21742B98CE517FC360@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200115042116.7408-1-Hawking.Zhang@amd.com>
 <BYAPR12MB280652F870F01CB5FB11DFC6F1370@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB280652F870F01CB5FB11DFC6F1370@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-15T07:40:41Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5157d19d-6390-4707-9e5a-000088957b58;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-16T04:47:49Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8318bb4a-0e37-4400-9d54-0000ad7f64d7
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5939ab8a-3c2d-43a3-d419-08d79a3f3e43
x-ms-traffictypediagnostic: DM5PR12MB1692:|DM5PR12MB1692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB169241BD1D0A4B325E8D470DFC360@DM5PR12MB1692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(7696005)(53546011)(33656002)(6506007)(186003)(26005)(478600001)(6636002)(2906002)(55016002)(66446008)(8936002)(71200400001)(66556008)(52536014)(81156014)(86362001)(8676002)(5660300002)(76116006)(64756008)(316002)(110136005)(9686003)(66476007)(81166006)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1692;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2X3dfJOaBzoE2KNLVEVjkg5cZx/u8cENw0Lg3AoaK3ATl2pWPoBSaZ1Pzo1wb+Ov8D3i3+8NqGz1C4Ow4mXnlHjAo46iiXkLnp1txGkWaIqyWnioo6FO/+ee/Ibupc3e0tbRlIjIkmjIjAcEH4YM/sMwJ3KiF0RAVxfSC0LL2zm1qS3uSxsfOCsr3UcVZKdCZrLYTF5oGU11QrcYsykcQrDGkBDayXNFciV4odvWliG8D/m4qlzoAIyaT3uTCzmUJX7XzbGQuKzXnsCVGR9gr3Qfb6MJCvaviiUx0PYKZoQ1Pm8p1FHZ/7s3q35dOSq/9wt2nnR9Slm5EdxYQz/Ghys3JN8/Ml+3YVz7vSzZYRPovtTe2P1afaG/c6qIFdl3pXZ/vRYMrU3BwzX+yigkm91Lcv4jTZaDyD9A15MeZ3kbJhpTM4YbEbGM64s+tq+
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5939ab8a-3c2d-43a3-d419-08d79a3f3e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 04:47:51.2465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0RlAYdL/3pzRxJQvGBfmwt/Zu8CtvxMoVKKpWuR/csl07TXwL3GFccTcJr0WoiC4yN/bx8iIGCm17qrK9gxIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
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

Good point. Please check my latest series.

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, January 15, 2020 15:51
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check if driver should try recovery in ras recovery path

[AMD Public Use]

Seems it's better to sperate it into two patches, considering the patch purpose. One patch is to add user recovery capability by module parameter for Arcturus chip, and another is to check if driver should try recovery in RAS function, applying to all supported asics who enable RAS.

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Wednesday, January 15, 2020 12:21 PM
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Clements, John <John.Clements@amd.com>
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
