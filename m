Return-Path: <SRS0=s+k6=6D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37062C3A5A0
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 12:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25602137B
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 12:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HG0WE1vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25602137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8006D6E053;
	Sun, 19 Apr 2020 12:50:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817AA6E053
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2020 12:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLcVPB8Dg32rWB3VNNp9qHYJZmy4Lv6NyX+UVu5/NCQeiIInjxZEZF3yZTNypzS/mQ3QP6FkhLDHdj+GgbILqsMFX1PfxHw3uHakOfRQPU20NePy2LwY2Z2z2U/th59vlT+8PjaL+K/HzTkBipkZclcypySHsUiEccBzAXU0njtaIGqRwSKa6tISO+08jysYeQ6HXJKf/4hiHb0/mWZlEQ/qE31X5802EuIln1hZokUdkUmDrE+rKcStEn29er09zYxqQDjSxA2FctjCyazODdxJu9Gi4HtRz9mpzWBuY/IXRVSdGbHillzYe+KZRhx234xhSM3iVnV0nMZiM0Znog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DztK7Rw5UcgFcb6t6KMBILvIzRPa+xvstKJLzb9x8Fw=;
 b=BjjpXGk3KS+nlOb3/o9Xffo4WwB5WrHQSjMv+AXx7iTrXYdpJn7MvT2QDzsfWYd/sFBak3bmemLrsDAD29nGIHnsXWGoPEE/K2E0zFikwsD+MPthFB7SG0fR60sdg5KrfsvnRp4DSXJIf1wl/1ToxU5/1XuP9yzGkXLtaf/l18JO5uAa0fOfkp02pnTtIfmmV4aEzUumdDxL41X+2nWXhlxBxEKgZJ68haNYPbR6i1O87rBpIfXskY4NYoYcDb920xIBeHPUyLN7DBfZtnJ8316kzbQcj0h0dShX5kgAi72mEMiT/XD7qRbbMrVL6Y97I5sPpWhWlOFKqKw0JKNJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DztK7Rw5UcgFcb6t6KMBILvIzRPa+xvstKJLzb9x8Fw=;
 b=HG0WE1vUOgCBbaTspKMd0zHdk5gkgc+Mq/0Fo4NocqTKE7sjJzkAXV7VWO87VU1AIqVGduhr9NYLIu3Trytzx5VyATQcbKmilA7Dw85/U7Y+X6tNM7wu4m6p7ybi/2Fl+JARTClxie26tWokMukINCVSS+BSvgM8IJAVu0PUfWY=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1799.namprd12.prod.outlook.com (2603:10b6:903:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sun, 19 Apr
 2020 12:50:26 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2921.027; Sun, 19 Apr 2020
 12:50:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: replace DRM prefix with PCI device info for
 gfx/mmhub
Thread-Topic: [PATCH] drm/amdgpu: replace DRM prefix with PCI device info for
 gfx/mmhub
Thread-Index: AQHWFTdnpeZOhaNjOU+3bD4w+z2sOqiAZ33w
Date: Sun, 19 Apr 2020 12:50:25 +0000
Message-ID: <CY4PR12MB128797F7AC9C70E1F839F4DBF1D70@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200418041049.21504-1-Dennis.Li@amd.com>
In-Reply-To: <20200418041049.21504-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-19T12:49:31Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cca3dd82-668f-422a-b1d0-00000ce39f60;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-19T12:50:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d128a8b2-d92a-4b84-a0e6-0000f510f1a7
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4da1a1d3-c38b-40fe-fc3c-08d7e4603b42
x-ms-traffictypediagnostic: CY4PR12MB1799:|CY4PR12MB1799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB17998C3427E8917F327746ADF1D70@CY4PR12MB1799.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-forefront-prvs: 0378F1E47A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(110136005)(81156014)(478600001)(76116006)(8936002)(8676002)(4326008)(66446008)(316002)(64756008)(66556008)(33656002)(66946007)(66476007)(7696005)(52536014)(6506007)(186003)(26005)(53546011)(6636002)(66574012)(5660300002)(2906002)(71200400001)(55016002)(9686003)(86362001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EPm35MHkPnG/BiWsvd9zY58dbfNGnahhQvzSXHhAaJsRCiIcpRgMWdgdxSrYqSUt5/tqO00H59jRw+Mu6xb6oFmg9m2974vnoHRa24rNe3HzMy/hySm1AWQOuG1Gi0q9SsSHzV8AEDAD+q+13gN1rs7TmuINpxJRUAR98nWXOHRBUZXbbP2zoQKagi/qha+H9/zbHDqTZXQfLMgweCgeZelIvR+TkGrYZLxVNubX2no7xq1ctX9uUVPQqn/yFDBpOVgrPQHyVajwHzA4uk4NzNnwZXre91NXhtwiowErI9SZGu8yoGY7zVBnjdDa3YJAX18ZshxAJiUWr1duM/VURKXcu6lDdwRXFdoGWbG22nTwZ7oOYJYejW4vaLDVpl+4ZvbixHioQ0fXz1l6qhEkEc219ePfST7Y0s+pcmy/L72TfVRkrCHRVtMvtRerB1gG
x-ms-exchange-antispam-messagedata: 89z1yQIMOwf1p9X9Rqh2kBAfGjxmMj2mYK06LXoI3hTyRIhv865Vz3o7pw2ky/sHlTSysbxISQaOM8zrowW1edSWCeXRGIp3hgYuntb5nszUcBtP9Xy0iBqHums9X63cnjt7O0oTnVbpZU7iCM9WLQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da1a1d3-c38b-40fe-fc3c-08d7e4603b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2020 12:50:25.6794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2MenMg7uqD8PKfz15c9mqt2KmpKNz2rWQ3krfZLkmyggY6BbHEYZ7LLs3Tz+uJ8bdYwD+cqhD8CUbyqEz2K3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1799
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Saturday, April 18, 2020 12:11 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: replace DRM prefix with PCI device info for gfx/mmhub

Prefix RAS message printing in gfx/mmhub with PCI device info, which assists the debug in multiple GPU case.

Change-Id: Iceba7cafd5aac7d0251d9f871503745cc617fba2
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
old mode 100644
new mode 100755
index dce945ef21a5..46351db36922
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -732,7 +732,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, VML2_WALKER_MEM_ECC_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 vml2_walker_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
@@ -740,7 +741,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, VML2_WALKER_MEM_ECC_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 vml2_walker_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -752,14 +754,16 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = REG_GET_FIELD(data, UTCL2_MEM_ECC_CNTL, SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 utcl2_router_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = REG_GET_FIELD(data, UTCL2_MEM_ECC_CNTL, DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 utcl2_router_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -772,7 +776,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, ATC_L2_CACHE_2M_DSM_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 atc_l2_cache_2m_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
@@ -780,7 +785,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, ATC_L2_CACHE_2M_DSM_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 atc_l2_cache_2m_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -793,7 +799,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, ATC_L2_CACHE_4K_DSM_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, SEC %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 atc_l2_cache_4k_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
@@ -801,7 +808,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, ATC_L2_CACHE_4K_DSM_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			DRM_INFO("Instance[%d]: SubBlock %s, DED %d\n", i,
+			dev_info(adev->dev,
+				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 atc_l2_cache_4k_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -816,7 +824,8 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_ras_error_count(const struct soc15_reg_entry *reg,
+static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
+				    const struct soc15_reg_entry *reg,
 				    uint32_t se_id, uint32_t inst_id,
 				    uint32_t value, uint32_t *sec_count,
 				    uint32_t *ded_count)
@@ -833,7 +842,8 @@ static int gfx_v9_4_ras_error_count(const struct soc15_reg_entry *reg,
 		sec_cnt = (value & gfx_v9_4_ras_fields[i].sec_count_mask) >>
 			  gfx_v9_4_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
+			dev_info(adev->dev,
+				 "GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
 				 gfx_v9_4_ras_fields[i].name, se_id, inst_id,
 				 sec_cnt);
 			*sec_count += sec_cnt;
@@ -842,7 +852,8 @@ static int gfx_v9_4_ras_error_count(const struct soc15_reg_entry *reg,
 		ded_cnt = (value & gfx_v9_4_ras_fields[i].ded_count_mask) >>
 			  gfx_v9_4_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], DED %d\n",
+			dev_info(adev->dev,
+				 "GFX SubBlock %s, Instance[%d][%d], DED %d\n",
 				 gfx_v9_4_ras_fields[i].name, se_id, inst_id,
 				 ded_cnt);
 			*ded_count += ded_cnt;
@@ -876,7 +887,7 @@ int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 				reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
 					gfx_v9_4_edc_counter_regs[i]));
 				if (reg_value)
-					gfx_v9_4_ras_error_count(
+					gfx_v9_4_ras_error_count(adev,
 						&gfx_v9_4_edc_counter_regs[i],
 						j, k, reg_value, &sec_count,
 						&ded_count);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
old mode 100644
new mode 100755
index 396c2a624de0..bd2d2b8d1f42
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -690,7 +690,8 @@ static const struct soc15_reg_entry mmhub_v1_0_edc_cnt_regs[] = {
    { SOC15_REG_ENTRY(MMHUB, 0, mmMMEA1_EDC_CNT2_VG20), 0, 0, 0},  };
 
-static int mmhub_v1_0_get_ras_error_count(const struct soc15_reg_entry *reg,
+static int mmhub_v1_0_get_ras_error_count(struct amdgpu_device *adev,
+	const struct soc15_reg_entry *reg,
 	uint32_t value, uint32_t *sec_count, uint32_t *ded_count)  {
 	uint32_t i;
@@ -704,7 +705,8 @@ static int mmhub_v1_0_get_ras_error_count(const struct soc15_reg_entry *reg,
 				mmhub_v1_0_ras_fields[i].sec_count_mask) >>
 				mmhub_v1_0_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			DRM_INFO("MMHUB SubBlock %s, SEC %d\n",
+			dev_info(adev->dev,
+				"MMHUB SubBlock %s, SEC %d\n",
 				mmhub_v1_0_ras_fields[i].name,
 				sec_cnt);
 			*sec_count += sec_cnt;
@@ -714,7 +716,8 @@ static int mmhub_v1_0_get_ras_error_count(const struct soc15_reg_entry *reg,
 				mmhub_v1_0_ras_fields[i].ded_count_mask) >>
 				mmhub_v1_0_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			DRM_INFO("MMHUB SubBlock %s, DED %d\n",
+			dev_info(adev->dev,
+				"MMHUB SubBlock %s, DED %d\n",
 				mmhub_v1_0_ras_fields[i].name,
 				ded_cnt);
 			*ded_count += ded_cnt;
@@ -739,7 +742,8 @@ static void mmhub_v1_0_query_ras_error_count(struct amdgpu_device *adev,
 		reg_value =
 			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_0_edc_cnt_regs[i]));
 		if (reg_value)
-			mmhub_v1_0_get_ras_error_count(&mmhub_v1_0_edc_cnt_regs[i],
+			mmhub_v1_0_get_ras_error_count(adev,
+				&mmhub_v1_0_edc_cnt_regs[i],
 				reg_value, &sec_count, &ded_count);
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
