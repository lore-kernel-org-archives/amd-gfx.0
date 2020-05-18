Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1C3C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 04:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164972070A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 04:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lcn3tlrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164972070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9BBC6E082;
	Mon, 18 May 2020 04:53:25 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918136E082
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 04:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0Og2lqUgfn/pf5TsoSFESlZZ0tC9DVMT9hG1f07yEOptSkAzWIMMBrGtHoiEGqLg02zNOQ8nkuGPDV2SJW2UmMSxJGrW3hlynDrZ7GFoXAmkgDuIDmaNu7FVhYIB+x2nWImeJtrX7zbJD2TxO0OzdAGW8XISRCXNbeeBvXGMQtMyWzTegnS/2EyPA6D+9JXuM4dxgVHcRpXipkS499g4Xjy5dR8/rS6GhJXaizBm1ZuFuln5hLL9nBi8Pd/Ks7/r7tjFUm5ARolRX3hrmjG0ipMJ/1mvKyKWBBrkSDhrbm5oPgS++qNciSN2gBbhcekB6m0UQvOMgVROJevQiXisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR/4+aeFzYKrj9Du7mvwaLzhrjgbGj+z+DhPSwZ1yrw=;
 b=ZjERDUdKs4nyOhD9nebB2kZT/Eu05yA8OpxNlcY1TiZHrgqi3znhruZT3FaRv4yExUPsXpDptrV+2yXtmy6Mf0nyMMSaXpGLf3A8Kjamc096i7MoxGng021WIheBEHDKWQh8B7sCeTDH7km6Tdm6iIfndWSS0wtjYeKJkfMPNzsXjFEUFV3Q+SR1PqHnK0VnriicCrzAsO1IQx0Ybr2mBF8+64Koos9mcu7/q/U5M/y17ORrnMEkbHUjTH1CLNYv3E8qASEiaT5dyp17vsPKcLJbmY2P4HfRJB8zBsLQIjfpL7P9SOGUVZyV02PsuVh5ojrqzeuMq/u2hHddmUscjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR/4+aeFzYKrj9Du7mvwaLzhrjgbGj+z+DhPSwZ1yrw=;
 b=Lcn3tlrK7lr/mQkRvRG/AklAc3NKEvvtiFPjFa0CL1oYER1c91q1oFHErflGx7fpqWS77FG/TtOaVCdxj19lWP1gyuDDKDrA/KMCfxcRzXZ4J3L08cbL/D8QV3OACZw8DAlvcCdoUCMYgBlNyh74qmgsH9fO3GjqGUdNeREDCsc=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR1201MB0044.namprd12.prod.outlook.com (2603:10b6:4:54::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 04:53:22 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::151:afe4:587f:3a86]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::151:afe4:587f:3a86%9]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 04:53:22 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
Thread-Topic: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
Thread-Index: AQHWLM8pnY1xWAKtgUapxa+oWDkhjqitRmww
Date: Mon, 18 May 2020 04:53:22 +0000
Message-ID: <DM5PR1201MB02049AA86A0FDAD2F59B7247BBB80@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <1589777093-8738-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1589777093-8738-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1098eba0-fd80-438f-2bd1-08d7fae7648e
x-ms-traffictypediagnostic: DM5PR1201MB0044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB00442AEDD3FE8E1C68EBE19CBBB80@DM5PR1201MB0044.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /V6QF7tACWXr1OU2lGwtxwmZTM7vyvg8ns7hUaLmGFissZ0nue/MctAFjuAmdIQCS6upkJlZE5PLVdqMObXgREfbgfhBTqh+0n1xJszXPhcTEZ+BlRy/Rid/w9/EldT+nfbq+CGUr+Nb9IEzn7gt4Yl61LC+u9+ul8jI+A12ug6EwiAvDLLyhZN4AkN3BF3Cnwto2Ibb9VMqf/9NqoVZ+Ki6i2NPunDLisEBdtXdP7VrwDYCQtH2FZ+btAWZXdJGoh9kMEBOwpuLQh6ydE/Ucbgj1ae+C8l+tWWLLKvS+13ozqrNIocK+VCkEg1U5Iys2qdUFg9FjK+9IMi3x7tYKExBD6q9LySVZAXqPEtGGzRfO9HmtMqQPQTAvNq4sODnKOfqHLoEYOh8A+81j45NJFJ2GoFQC2+fJ8QpxsYGQlAR7BD6yDEvxWFmQK0DhLf5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(66946007)(110136005)(33656002)(316002)(55016002)(9686003)(4326008)(2906002)(478600001)(52536014)(186003)(26005)(76116006)(64756008)(66446008)(71200400001)(66556008)(66476007)(53546011)(7696005)(6506007)(8676002)(8936002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: xIEOL7+0tOwDIwhzD+lHDw2qbTTji+zxz2QXzxzh6Czz2wLRRSUjrjpP8n6KDELT3bA+CnstmTyAJiMcWim8f4JeSutOgb2pw0hMru67v0JkUAKu4xl2AQniOyfYHRVe9FMJPEwWPv5T0A6Q81uoD0zXORLDz+sWt8DoNMvCtPo9f3AS4P4KkEB1Sg86BMT5YvXFzw+HQRv8xRRvIgcDxfcUdHpgVKnt+MqqqyEOCrcEfxwGsBQ/4tqy/bVinvSW+oDMH12tDg7DsCQ5HolzU8n98R8arXGuLdxaRjgsL8X+voTn8KElZZMigKScGeB2WNHiOV/9ZHLEHXKQSf14W89/DVby2UkOsotltxkrDpxPrPP6GjEXNmRPV5Uty4obhBODn4h32X4lwqCIPMRG2E/rzXlrVKYFDTc0I+NpUnX3hfNgTyjqWO7nsuntraGtpjnFEbscermh+HHzhGR4it9lsqLRhjSIQcuyoaD98wt7UIh5WGt078tOJpCTqDFm
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1098eba0-fd80-438f-2bd1-08d7fae7648e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 04:53:22.6253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luovYCCm+zekaePIr6g3kii3mpscxh8qw+ohWw9u647wE0ExGVQ3UaOWRUdA6K+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0044
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Monday, May 18, 2020 12:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi

Under xgmi setup,some sysfs fail to create for the second time of kmd driver loading. It's due to sysfs nodes are not removed appropriately in the last unlod time.

Changes of this patch:
1. remove sysfs for dev_attr_xgmi_error
2. remove sysfs_link adev->dev->kobj with target name.
   And it only needs to be removed once for a xgmi setup 3. remove sysfs_link hive->kobj with target name

In amdgpu_xgmi_remove_device:
1. amdgpu_xgmi_sysfs_rem_dev_info needs to be run per device 2. amdgpu_xgmi_sysfs_destroy needs to be run on the last node of device.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index e9e59bc..bfe2468 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -325,9 +325,17 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,  static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 					  struct amdgpu_hive_info *hive)
 {
+	char node[10] = { 0 };
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
-	sysfs_remove_link(&adev->dev->kobj, adev->ddev->unique);
-	sysfs_remove_link(hive->kobj, adev->ddev->unique);
+	device_remove_file(adev->dev, &dev_attr_xgmi_error);
+
+	if (adev != hive->adev) {
+		sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
+	}
+
+	sprintf(node, "node%d", hive->number_devices);
+	sysfs_remove_link(hive->kobj, node);
+
 }
 
 
@@ -583,14 +591,14 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	if (!hive)
 		return -EINVAL;
 
-	if (!(hive->number_devices--)) {
+	task_barrier_rem_task(&hive->tb);
+	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
+	mutex_unlock(&hive->hive_lock);
+
+	if(!(--hive->number_devices)){
 		amdgpu_xgmi_sysfs_destroy(adev, hive);
 		mutex_destroy(&hive->hive_lock);
 		mutex_destroy(&hive->reset_lock);
-	} else {
-		task_barrier_rem_task(&hive->tb);
-		amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
-		mutex_unlock(&hive->hive_lock);
 	}
 
 	return psp_xgmi_terminate(&adev->psp);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
