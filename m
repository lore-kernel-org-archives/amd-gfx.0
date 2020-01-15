Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D4C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595B024655
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L4em0ZhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595B024655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C80E6E093;
	Wed, 15 Jan 2020 07:51:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC396E093
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 07:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNl3akXSlhNC1cEDNn/VOFHTvJrYtEbC5jnnTGcE44GeFmbO5wrCrHg2jThyGtSQv8FliJD23S6SRzDXGQ8gttPgtOkcm6m/Ht9vEsvK+Jmvd0q6b51YuBIPLCf/gZRXWRU7JPuvOzeaFwtcAfLtSSteu/plkRcqKFvU9NclqKqcabtiOBJnbFM7bzWdrB8N02Grz/mNa25nwReG1QOCHJR9n10deIIAsHXJxhsFwAqBvMrm96chxr6qq0PqwAq2kkl4LSF5pKGKiO3a08ENjJNIYtPspyOwnEvnQfVtr3ZGkV/LYnTB8/fTXApp9JKgMhcGkKDe/cNHcDI0MqUK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRnBnFdLL02zedqjkdwRadQQ8N4ROfV+h4ZZXPyg3iM=;
 b=GP91HdIzC3X3F3vt/NxXpgWAJ9xhlU53s61btVZULOcaEucSyehxt3cpd3Iazsz/QYhDfNJBI4tlp/tHdKRWt/j+6DT93KOEncPwIaCugysmkPn2HbHvO0zFQXqn1fWh5pRnI9nQtPXd8AdffPD29pBTRFDa4CpFPCh07F+XsM3CvX81X84rCd//F9ra8lkIyLj70hS4o9Vyw4bEyG9MaRV+HpQ8Cw51mVZOWL7Z44mjgaym4OypAAxJJ+MFdeSDsd1wvIGZESjr6vAbw0Nv6HgX17hcJZg/yRCrd+xar6GSe9Ntrs22cDwHXCWrKdUWW4C20KimCNBUIh5rsdXeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRnBnFdLL02zedqjkdwRadQQ8N4ROfV+h4ZZXPyg3iM=;
 b=L4em0ZhIstLepwEtx0gHGJazBgGVTvmSKNmM9a/xiMdfbnEndd7n+CiN/fJk3MKepZgxJX0OD8n1zM5qAlN2dN2mYWkktdbrZ/oymoPd5YFvHKA9QHnMS59ZE77dqTOvU6eHVbC2szlppiTZzzFSOgPpdO1gZ15/MeuiM/u1bzU=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 07:50:57 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 07:50:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Thread-Topic: [PATCH] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Thread-Index: AQHVy1tAATWfhdreB0uujQG1mX/aUafrV3Jw
Date: Wed, 15 Jan 2020 07:50:56 +0000
Message-ID: <BYAPR12MB280652F870F01CB5FB11DFC6F1370@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200115042116.7408-1-Hawking.Zhang@amd.com>
In-Reply-To: <20200115042116.7408-1-Hawking.Zhang@amd.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-15T07:50:53Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: cb87c90e-6b0b-4515-806d-000024c59174
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39a60197-4a18-479b-de05-08d7998fa7ad
x-ms-traffictypediagnostic: BYAPR12MB3398:|BYAPR12MB3398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33984EA365ED5FB0E259B64FF1370@BYAPR12MB3398.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(316002)(8676002)(8936002)(26005)(4326008)(81156014)(52536014)(81166006)(71200400001)(6636002)(478600001)(86362001)(76116006)(53546011)(33656002)(7696005)(5660300002)(2906002)(55016002)(186003)(66476007)(66556008)(64756008)(110136005)(9686003)(66946007)(66446008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3398;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9U4TtYKMdefvSvCItTsIsufTHvnE9JmCppzULyOK+FtDCCCMv0nsQgwlYDRVnnvZlLOD9+h90lnJ1YgeJCW0foDcTeg8Ejvd8S47GsnwA7KbMi6MQrnUUwSMgtYJRJyef1s91bBKTRVCKUwF1T+c0h/8hoF5dpPMKK07zvyD40y4cQ4uzVEqln5tewzLNL7+G8HCybNHZ5bM9TYkgmxFr7pGER0Mqk7M1xUr2DqpAHlwLsxAgvbqMQbzJEI3YrNOyW+PDxl5nRwu+WkKYaQ2BWNRIolz0tRs4csJcfOPGq0mEDqs7Fkbqlu6X7hTEwjtUWL6ggJVuZs3rjHJPoNFfD9gTrH4UaNvFV4OA12dJ2s0m2kn3m/xNc4vXO0XEfHeq2o63RU7wnSOjGPxrBqRGm9GOJLZ8qpzRlFf2i3UaU9PPhnVdJ6oExk8kMrAJmo
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a60197-4a18-479b-de05-08d7998fa7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 07:50:56.7358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FkpAnjaGB/5yuHiwhvjKOYoJCC386WnREGcGs7Gdbh6sXAE5Hl0z1ueZ5bj8+pU+X0zh283cWCffMYl2RbYHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3398
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
