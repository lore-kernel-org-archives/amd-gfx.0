Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E4C4346E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 01:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E02A2083B
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 01:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EgPJ53XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E02A2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815AC6E11E;
	Fri, 25 Sep 2020 01:43:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3066E6E11E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 01:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITau+0OLQ8zIz3YCxYV52Bj9J6ARE/mlIcOB4RbgeJyHw1OeHPQ6n6fJY6YLnTOKEbPMJtRxoBph4SVABjhVZK6s44Il7FE28t4Fs1rSPwS4efWeXa3qpLAX/G4tuEV1SLmeSKD0Cr/nGNJcSqlhA7dFTvFbOI3EuY+Og9tVdHOJH/DlyaYTObyo2Kmi4swn9KWgDuaBfQRlYivjVZbMC5C9b9/UY6IkjAlETSBigJv+tva+jKIKDv78qJsPKJ2ShKE+hVn+L1OcHjJneymq5cbRxmh0LRmXYcPPUMc0aX49vv5HjNQxNrIUvOWttYqGa6+fU2kXuL6YrzH2RPQgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHD8/DEKjxHnbFDy0/HwWb9j7ChzwUAe5BnYAFVYO48=;
 b=fXGQ7sYdWXkqBP/4lztLMBnphz5uzqGDoQdRvXAHu14zy2DrwP3sdObxmqk2Yr4WOFFY5JWgCeEXtt/I8GrBE+JOQMPNxrvTX8IW/MlE8P62MwKzBRx1CTibZDNisX6cguTJ307PA70+4yTYePnSfmZl60K594jurJpQoq5O27UKF8RYJ2rrTYeRw21qFCedKa8f0i37NVXKlvNCTeEfCGmBgAQ73xtMNVrNN0dRrModHgJd5gzx5HsjUd3Q3QCqCSBDQaNr/BDB9xq8FKSdEMDJwKW1OQDmhJpbp+6+pddqDkSlgGbIYg6CzQky9I8/TkV/+TPfE5EyyCxK4uRKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHD8/DEKjxHnbFDy0/HwWb9j7ChzwUAe5BnYAFVYO48=;
 b=EgPJ53XD1X8YgPyH8I2Fl3YPNCFjwB+mBGpHFfjL1IGJWUlZZSguKqdcTgPJ5zCjbTGHVV0BKazmXzzzB0JaTo5yVYbyIXyWrCLW04J03Xxv9TsTeG+WY+zj0Z9vzvRn+ieuNZf1wlXrT1F/9c03l9MRE2/5ZCLrfUR5w2x0WkM=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22; Fri, 25 Sep 2020 01:43:13 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3391.027; Fri, 25 Sep 2020
 01:43:13 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: clean up ras sysfs creation (v2)
Thread-Topic: [PATCH] drm/amdgpu: clean up ras sysfs creation (v2)
Thread-Index: AQHWkoJYuOXoqy8ypka1bnaoJxHso6l4lUTw
Date: Fri, 25 Sep 2020 01:43:13 +0000
Message-ID: <DM5PR12MB25338EBF8ED6BC4976E907F6ED360@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200924145156.8114-1-guchun.chen@amd.com>
In-Reply-To: <20200924145156.8114-1-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-25T01:43:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9528d24c-b489-447b-befd-2ccd072eaf7f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05897ef6-0361-46b1-3540-08d860f45dee
x-ms-traffictypediagnostic: DM6PR12MB4466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB446682D5C40C254F43C42C99ED360@DM6PR12MB4466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vUK61P0tRCrRv6kAXtMhkzj3CVgWZtUVsZwVS3r1XhbyjtW4X9Kzoo6vT9YDX5CsKT82/f/nan35TqDujb4KruJOBhOiNX8ZmS0D+xluZL8bFlqKryh2b7wwMIVcR/GwtlylH0eP8sBjg9pU/XlB3eBH3PzJaBCOGKdnb9LnZ/E397g0+TCp80zntqQxRNCyA01WpqcisHo38ru+4J2yvFTb9KWpCfQTqMVuPFCijH06aYMpK78165vcuO999zY5zFhxVaBc892vVFJVnRSLvr2azyls2tCLhOE274a0+7eRfVQ7PyzfTyk/4qY8DD9DY7Sobal7cTbClTK0qxYZ1qGs46qQ/AFQxkSk6JjoeNAbZX4MLXoWyp5+WpToMDkP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(110136005)(66446008)(316002)(6636002)(8936002)(64756008)(478600001)(71200400001)(186003)(5660300002)(52536014)(6506007)(66476007)(76116006)(66946007)(7696005)(2906002)(66556008)(33656002)(55016002)(9686003)(53546011)(83380400001)(26005)(86362001)(8676002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PzRZR8KWpcpqpyxMswr5ZOvtu9j61XwVZILF2+EBTmuWVMYE3MPkKvX7fjCvItouY8N7rWbrrqCw1poIqiilJMK7eSmAbLTdF3paAKoXcSUuCPq+AzidYaffMr1RJwC0rfulWr/rFNTHgr6ewIX1Bb9pgMKChlWkN0YG4VLMU401YIk2KF42CpM4FaLtp31MkkUDBzWngFnBRjDSuVjsu6H9+/Fy5UsTTz5A8s1Z1KTIoUS8lX0WF1Ft1b/1o54IaP6gJKx5gwSNLGjh5dbAeWqmeoRCDMgd1K8E8mHCiMRz/g6H68GLKeEiFv9BueGAe1eMBLkNorKFcA2ZD91AnSkPafujn+m35RvNOBV2DZZdkRhQWomgTq+srVtt0Bn9uLkbZs6WbbGgJSeqvA262utxHWcClm7Ynb8zBglAITlDPIuANVwJP2iL6As9MICyscob7ORuA8+ooY6lItLgFX+ubKgT4wGKU69b+KXh/Oy7eSXA9xe8wNJ8rtL04tWjFNvHMZqpTgOLWqB/zwdVcFd04OxMHiyW+8oeLPUZxzLFdl+c4Iu7cay5vH9b9mVbcmx/hYCOUiqtqwMzx8HXHD7JO5u6rgc0hVeKCudk3Mx3QlYZEABo3Popx/1ql8w8c7Ha+1k3/e9EQ8SX7CV+zQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05897ef6-0361-46b1-3540-08d860f45dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 01:43:13.5954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5+xHk4l/WA3uXeXgTvfuuCbqZaXLEI9VbJID642DNPTUA89EDCVgwAtrKWiOprs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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


Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, September 24, 2020 10:52 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: clean up ras sysfs creation (v2)

Merge ras sysfs creation together by calling sysfs_create_group once, as sysfs_update_group may not work properly as expected.

v2: improve commit message

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 87 +++++++++----------------
 1 file changed, 31 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5ea14774c0c..6c57521b21fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1027,58 +1027,6 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "feature mask: 0x%x\n", con->features);  }
 
-static void amdgpu_ras_sysfs_add_bad_page_node(struct amdgpu_device *adev) -{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct attribute_group group;
-	struct bin_attribute *bin_attrs[] = {
-		&con->badpages_attr,
-		NULL,
-	};
-
-	con->badpages_attr = (struct bin_attribute) {
-		.attr = {
-			.name = "gpu_vram_bad_pages",
-			.mode = S_IRUGO,
-		},
-		.size = 0,
-		.private = NULL,
-		.read = amdgpu_ras_sysfs_badpages_read,
-	};
-
-	group.name = RAS_FS_NAME;
-	group.bin_attrs = bin_attrs;
-
-	sysfs_bin_attr_init(bin_attrs[0]);
-
-	sysfs_update_group(&adev->dev->kobj, &group);
-}
-
-static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev) -{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct attribute *attrs[] = {
-		&con->features_attr.attr,
-		NULL
-	};
-	struct attribute_group group = {
-		.name = RAS_FS_NAME,
-		.attrs = attrs,
-	};
-
-	con->features_attr = (struct device_attribute) {
-		.attr = {
-			.name = "features",
-			.mode = S_IRUGO,
-		},
-			.show = amdgpu_ras_sysfs_features_read,
-	};
-
-	sysfs_attr_init(attrs[0]);
-
-	return sysfs_create_group(&adev->dev->kobj, &group);
-}
-
 static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev); @@ -1300,13 +1248,40 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 /* debugfs end */
 
 /* ras fs */
-
+static BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
+		amdgpu_ras_sysfs_badpages_read, NULL, 0); static 
+DEVICE_ATTR(features, S_IRUGO,
+		amdgpu_ras_sysfs_features_read, NULL);
 static int amdgpu_ras_fs_init(struct amdgpu_device *adev)  {
-	amdgpu_ras_sysfs_create_feature_node(adev);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct attribute_group group = {
+		.name = RAS_FS_NAME,
+	};
+	struct attribute *attrs[] = {
+		&con->features_attr.attr,
+		NULL
+	};
+	struct bin_attribute *bin_attrs[] = {
+		NULL,
+		NULL,
+	};
 
-	if (amdgpu_bad_page_threshold != 0)
-		amdgpu_ras_sysfs_add_bad_page_node(adev);
+	/* add features entry */
+	con->features_attr = dev_attr_features;
+	group.attrs = attrs;
+	sysfs_attr_init(attrs[0]);
+
+	if (amdgpu_bad_page_threshold != 0) {
+		/* add bad_page_features entry */
+		bin_attr_gpu_vram_bad_pages.private = NULL;
+		con->badpages_attr = bin_attr_gpu_vram_bad_pages;
+		bin_attrs[0] = &con->badpages_attr;
+		group.bin_attrs = bin_attrs;
+		sysfs_bin_attr_init(bin_attrs[0]);
+	}
+
+	sysfs_create_group(&adev->dev->kobj, &group);
 
 	return 0;
 }
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
