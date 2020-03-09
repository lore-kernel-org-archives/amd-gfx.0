Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B4EC10F29
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 09:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE81120674
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 09:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b+QRRUuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE81120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A46389FC3;
	Mon,  9 Mar 2020 09:20:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC85889FC3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 09:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9MKNgiTPIOF6R/cYiKMrmglF1EGj0bjzb/CuQ0pndp/iu5hqLuAgY9APv04yFOk9mjYMcqwmmyAOHErUGXIWcEXsV1qTNly+Ri3TxAEdFwGmdqNMhaSk9P48eU4G5J0DC8gIcDyLD9eyez0pXz47EYXVlVC4vh64X3S46BGPuW0QjbGaFNYLCjtrJ1w1A5MLi+mYi+P3c5oxV6fvQ73Gdzr8zgHU/j/y0xEu1f3d9EOPMI3SsQfZlD03fpjeyCIMPRsxMv2jNFbLIyg0pvZmioyzH9VyGoTqNnKjmGtN6qnItamBToiypEFnSSQLc1In6/HOhI030azhlKFUXMW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2X1zUf5ukgw9WXNW73U/1qmU4qAMIZTLKaxE4QPZ6I=;
 b=csP5HfgLbP0MD6onRH9y/RKxXE1qaclIUBrQYwuti9tUirZaEzX6R+Yo3Cg5U9ocyMiANlaQ33FtvIJSaA/tqFGA1Q4lTEX8L25dcIUScLEgPqqMB2J0vQ3uYGR8b5iqSlKt9ZGY59tUix1VLbRqw2Kdw+4oq4Gqk/17L1ydcZgQlIKxfNM1bMbrP8X9C5TEOJMeBSi3UC5wukRNOvUvawXWQtaLCYNy42cN3VrcPPU7+6J9C7NrG2aH0V5b6ebfu4xBI9bs9S02M/TiV0JrG9lhwRjCRuHkKqFbRCyuvNbAYUlSGxADOk09w6oEYAy2+iHG9iqtExTZ5RWhdsYnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2X1zUf5ukgw9WXNW73U/1qmU4qAMIZTLKaxE4QPZ6I=;
 b=b+QRRUuRrj9ec+cjQCxIxgmzewX62m42UIpVvISEG0deqS++LqHZJwvIN88aVf0Hpome7yZs0y+03PQgWo8iiME26VCXkv+xKfxGKt6WZFilFzfgP4/S8ybQXeVP3mqYnM/4P4wJm2dqfVrEQvOcVI3jLxthQ/8ixZkO7lLn87Y=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3447.namprd12.prod.outlook.com (2603:10b6:a03:a9::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 09:20:34 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 09:20:34 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in
 debugfs_init
Thread-Topic: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in
 debugfs_init
Thread-Index: AQHV9fLbdxIrSy7yekesnjnJnnBtcag/+7fw
Date: Mon, 9 Mar 2020 09:20:33 +0000
Message-ID: <BYAPR12MB2806E9C6F7B8E2BEFF19B4F5F1FE0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200309091215.26768-1-Stanley.Yang@amd.com>
 <20200309091215.26768-2-Stanley.Yang@amd.com>
In-Reply-To: <20200309091215.26768-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-09T09:19:20Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=14dd4b30-9321-4a3b-bfcb-00003ac7d245;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-09T09:20:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d0a63976-5f51-415c-bc64-0000c7a1d607
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fdd9bcb-5f03-4253-ccd6-08d7c40b1f05
x-ms-traffictypediagnostic: BYAPR12MB3447:|BYAPR12MB3447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3447188C771FD217710EB266F1FE0@BYAPR12MB3447.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:134;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(199004)(189003)(71200400001)(4326008)(33656002)(86362001)(2906002)(8676002)(316002)(54906003)(110136005)(8936002)(81166006)(81156014)(26005)(186003)(52536014)(66446008)(66476007)(66946007)(66556008)(64756008)(5660300002)(76116006)(478600001)(6506007)(55016002)(53546011)(7696005)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3447;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ydh/ehb5Qcjd10/xrZuPL4pd5PGTduEH0M0xYUYnjecD70yXbQawY6BRu7u6znZr5/JyByzcAGoASgXj5QziMhTtJdf0qspfj4palAkeZDYRbrMHGXRVn4ssReC2cmJi+FOXYrS3HDzWfJyxuOabrIGFN0x5k68kSMLwUDVPOmt9v6RRovS4mu0aFSWclgM16ceQmXOG8r84GEWlb/aI6bHu28e9e5m78fQ0tOn2zXE9x7Ioz0vQxM1rqLTHnVFgr0jikI40wCrAdgGKpRooeNC6g+YRlAGx55eHFQAkepx4NuSrMQqffXWCU7g4IC7LM8v7PsOFPc9kep8iqRlbLeHcYGFkQAXr+mf4bTvJ1epQubCcbwLndMo29k5naSAIOGAwC+lKdNepXgnHEF7Q8TuilbxxpYYV9FjZ0RT22cnQ+1wdu5J9OIuzEqntjtUP
x-ms-exchange-antispam-messagedata: AwHS0MWdflZweonKibz7Jx2yu32gPq1qnJMoRe3Ef/O+9bi+szx/p3CZ65pS6NNkQ8PvraJAcFoJjnNiOqcEVRPHlp3twpY0dpL1b58+Ol/v9+9tU30HMeBEkDMFgjhP+RXpSWF+M0fEVfP2OEqISA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdd9bcb-5f03-4253-ccd6-08d7c40b1f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 09:20:33.9063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4C86ds1PyjeNt73hxjmM+3/IjpeEXraodqWuMjr/+SMLcqDSFN7qZ89Mg6QMnrgDFQ2rY4MnUQcNHotkxAe6og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3447
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Shall we need other codes to remove ras debugfs in debugfs_fini to avoid leak?

Regards,
Guchun

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Monday, March 9, 2020 5:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in debugfs_init

From: Tao Zhou <tao.zhou1@amd.com>

and remove each ras IP's own debugfs creation

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: If3d16862afa0d97abad183dd6e60478b34029e95
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c   | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    | 1 -
 8 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index deca6343d0cc..1d513e4f9934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1315,6 +1315,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,  DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+extern void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev)  {
 	int r, i;
@@ -1387,6 +1388,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		}
 	}
 
+	amdgpu_ras_debugfs_create_all(adev);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7403588684b3..d12bb4a35780 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -565,7 +565,6 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev)
 	int r;
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "gfx_err_count",
-		.debugfs_name = "gfx_err_inject",
 	};
 	struct ras_ih_if ih_info = {
 		.cb = amdgpu_gfx_process_ras_data_cb, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 676c48c02d77..ead3dc572ec5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -32,7 +32,6 @@ int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev)
 	};
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "mmhub_err_count",
-		.debugfs_name = "mmhub_err_inject",
 	};
 
 	if (!adev->mmhub.ras_if) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 7d5c3a9de9ea..6201a5f4b4fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -30,7 +30,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev)
 	};
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "pcie_bif_err_count",
-		.debugfs_name = "pcie_bif_err_inject",
 	};
 
 	if (!adev->nbio.ras_if) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 422cdd1ce3ad..57af4ea8fb58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1178,7 +1178,6 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)  static int amdgpu_ras_fs_init(struct amdgpu_device *adev)  {
 	amdgpu_ras_sysfs_create_feature_node(adev);
-	amdgpu_ras_debugfs_create_ctrl_node(adev);
 
 	return 0;
 }
@@ -1882,8 +1881,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 			goto interrupt;
 	}
 
-	amdgpu_ras_debugfs_create(adev, fs_info);
-
 	r = amdgpu_ras_sysfs_create(adev, fs_info);
 	if (r)
 		goto sysfs;
@@ -1892,7 +1889,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 cleanup:
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 sysfs:
-	amdgpu_ras_debugfs_remove(adev, ras_block);
 	if (ih_info->cb)
 		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
 interrupt:
@@ -1909,7 +1905,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_ras_sysfs_remove(adev, ras_block);
-	amdgpu_ras_debugfs_remove(adev, ras_block);
 	if (ih_info->cb)
                 amdgpu_ras_interrupt_remove_handler(adev, ih_info);
 	amdgpu_ras_feature_enable(adev, ras_block, 0); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 7854c053e85d..250a309e4dee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -93,7 +93,6 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 	struct ras_ih_if *ih_info = (struct ras_ih_if *)ras_ih_info;
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "sdma_err_count",
-		.debugfs_name = "sdma_err_inject",
 	};
 
 	if (!ih_info)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f4d40855147b..9dd51f0d2c11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -28,7 +28,6 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
 	int r;
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "umc_err_count",
-		.debugfs_name = "umc_err_inject",
 	};
 	struct ras_ih_if ih_info = {
 		.cb = amdgpu_umc_process_ras_data_cb, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index a54ce398ed77..0837f872741b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -598,7 +598,6 @@ int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
 	};
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "xgmi_wafl_err_count",
-		.debugfs_name = "xgmi_wafl_err_inject",
 	};
 
 	if (!adev->gmc.xgmi.supported ||
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
