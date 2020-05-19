Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272CBC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 05:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C3420709
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 05:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="03QYYvye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C3420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9256E2D1;
	Tue, 19 May 2020 05:54:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8E46E2D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 05:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlaGO1hHiJc5nzCPT537VsH4Iknd8euyrrY+QnhINZ2ZA4ymDci6LNMvyhbcnyR7vFuzWx7lEVLGTK8I1cF58PUmBHpc4XmuGdOEsUQCuy2AiUSLtf4095nmXBilYSy2WBFEJI1+qNWQg0dMtEl20RKUmvhIw4zq3c2NicJxUboki1mgBaotB3bodyIc+t46ex+1aO0ELlDFJrktrKGchaanywojH/6eSodTmv6NicGX4RSrIXdBvYbmsvMIC63e3JhG6Ka7dVMHCdqoT1X1TyvGHAH6l70GJcjbHRDAEhmqeZ1bZCpX/JD46MfFUHSqD/UkToWc1FJT5TpO8/e7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQNSj7VcaUaVpwbZt2xorEGUtAi7gOw22o8/xZy4jCw=;
 b=n8/gKGor50Vup8JngpVrc8+tXChw/6eA4skwia5LVkLd4PRtRheXElBh4XvdXWnye2cqj+hn5zX+x2dCwZVgLZa7rGxmhKbFsv4jfD0X3McRQ+SpXfSp1mJrqXswPbinCexDNkD0oW/mDlo/vH/mfC1JKZ8zdUCMGfCT88CKl7/72Luv3iykzDuNIikmPLrJzd6Kf0w7eKsks8/2Xr+2qfXSeWo9+iwr4NCya+KSCSSaXwfPknSlZqjYn6b4hZtNLDbQv4xyGfkghZzFf2/t4yIuSUB3g8YBjo1NtYQOGwqBql1EMbC3IdPTAHS64Mzgav1HNdWsw05g0H6TqvZfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQNSj7VcaUaVpwbZt2xorEGUtAi7gOw22o8/xZy4jCw=;
 b=03QYYvyeSZPHQ+sMUvGThWlfQqSBygRjRNOMZvPd0CGOulgtV6KdObCVoFmS1xiE/Y4Z7vbKHlSUWPOTXXDjmUuIlfwI+bGSp9So6BbmNogcwjNinX2RYhbPgTIVxKF67erJL3OdygvrkLEcDfFPG7jTiUf3cMMSfD08D38rbFw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3050.namprd12.prod.outlook.com (2603:10b6:5:11a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25; Tue, 19 May 2020 05:54:34 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3000.033; Tue, 19 May 2020
 05:54:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdgpu: cleanup unnecessary virt sriov check in
 amdgpu attribute
Thread-Topic: [PATCH 3/4] drm/amdgpu: cleanup unnecessary virt sriov check in
 amdgpu attribute
Thread-Index: AQHWJFYre33p9FSnnkarfaIXHjikw6iu+y1w
Date: Tue, 19 May 2020 05:54:34 +0000
Message-ID: <DM6PR12MB407599A10CAC7AEAB22E26F1FCB90@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200507095704.25623-1-kevin1.wang@amd.com>
 <20200507095704.25623-3-kevin1.wang@amd.com>
In-Reply-To: <20200507095704.25623-3-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-19T05:54:32Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ee29cd41-f514-48ff-a7b6-0000685e2eb5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-19T05:54:32Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c835a5a1-33a2-4294-940a-0000ff48dd01
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b87c4a5e-bfc0-4834-ff9f-08d7fbb91ba4
x-ms-traffictypediagnostic: DM6PR12MB3050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3050B1D2425037F5140DFB08FCB90@DM6PR12MB3050.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VtCcXTIiHLrxdZKWdqWwM8LM/BwjMLjZSFdfUxjbUkNrmC7GvNpMGdAj4qwTQNfzWfmxDSmhFVK63PFTAOKXhQzO692sJBmLWjtqkxL5u9rAgSlTWLln2LQ5++X9Rud9fyBp8IyW9zU/a732BTsyKUAxANm24TYSCQZRpzSzFiYdmLS7AT0Fsc4Mi3cP4lqxOhjjzsvmIzgVpahk9kCRuYYAulGPYC3j5IN8XkfRM1YTaKe1V0V4LgvJcdaIAlyTFTqD9epOTdofHh0f+wfxS4BjV4aVJ4oqFrM5WBak9OA/qV7yyY+dNpZKLFEuXni/6jJtJnzwTrtRGnspkZ4ef9JhsoZZ0gn1Wo74JJyA4HlHO+2lb812O0cn2MOZ/iMiqJzpjrNt/S3f3uZnc1QYN8Bj4XYk1l3MqChRrr35xlXk9r+6BrK/13pnmVZq78zL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(71200400001)(478600001)(7696005)(110136005)(53546011)(6506007)(316002)(4326008)(33656002)(26005)(54906003)(52536014)(5660300002)(2906002)(8936002)(186003)(8676002)(9686003)(66446008)(66946007)(86362001)(76116006)(55016002)(66556008)(66476007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Z/LgiJDRnAYhQwzroqfBufnIGs/m8BO/uZQoHnEGIXwILXXamk3CZJffmV2qOEFWfDWjCS6SnJQiLhSLxMZSnIlkeFmutOvpgBNDq1MG+lbvw4eHUyXdgc+Dmfp0uHazhh013KKzh2Di6UuKsXT2yYUso9uP7S/fqHfxyOCKn79EbQD/dy74ZcHqv5qlcOPA49IT29mOHpTVMFBIO3N+5NpZ8NmGYcZV7hQYdG0R0aeeYBPD2T26/koXfI8FgTSNal0TfLygS3GpMcWPMZ6D2LysmZQbGE56IDjZlKCpkqmgVheqy9AX+7pyJv9d+Q935oQcFoxuDl4YAj7WvK0R63CRGcig08IDzN42/x8dGieYBT1sae++FCReCVNNFx+j4o3g6bY0L4AVQUpeKC/88xoMl7h3U4NRnKXNo9fbkT/1i1TJfDVynO0qfHqNCqycV3iU8Af7r/49k1x9Dq6I1RRfgiHP/AMtRtPzQ/58C8eXdBIG/KopKzy5OdkTpeTN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87c4a5e-bfc0-4834-ff9f-08d7fbb91ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 05:54:34.6399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg4HWKVlLd/86KI1vjPPP6tXQrqQtDBNEvxOCCSJIs5cyVZCOaX02HEZtwZ0iIHe7XsORepn4RctIDlbcT56Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3050
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Thursday, May 7, 2020 17:57
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: cleanup unnecessary virt sriov check in amdgpu attribute

the amdgpu device attribute node will be created accordding to sriov vf mode at runtime.
cleanup unnecessary sriov check in attribute operation function.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 105 -------------------------
 1 file changed, 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b75362bf0742..bc7de2f62d12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -163,9 +163,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -199,9 +196,6 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strncmp("battery", buf, strlen("battery")) == 0)
 		state = POWER_STATE_TYPE_BATTERY;
 	else if (strncmp("balanced", buf, strlen("balanced")) == 0) @@ -303,9 +297,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -343,9 +334,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strncmp("low", buf, strlen("low")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_LOW;
 	} else if (strncmp("high", buf, strlen("high")) == 0) { @@ -475,9 +463,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -514,9 +499,6 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (adev->pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
@@ -534,9 +516,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strlen(buf) == 1)
 		adev->pp_force_state_enabled = false;
 	else if (is_support_sw_smu(adev))
@@ -592,9 +571,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -634,9 +610,6 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -739,9 +712,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	if (count > 127)
 		return -EINVAL;
 
@@ -831,9 +801,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -883,9 +850,6 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	ret = kstrtou64(buf, 0, &featuremask);
 	if (ret)
 		return -EINVAL;
@@ -926,9 +890,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -985,9 +946,6 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1051,9 +1009,6 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1085,9 +1040,6 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1115,9 +1067,6 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	uint32_t mask = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-			return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1149,9 +1098,6 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1179,9 +1125,6 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1215,9 +1158,6 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1245,9 +1185,6 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1281,9 +1218,6 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1311,9 +1245,6 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1347,9 +1278,6 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1377,9 +1305,6 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1413,9 +1338,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1441,9 +1363,6 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
@@ -1482,9 +1401,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1510,9 +1426,6 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
@@ -1571,9 +1484,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1615,9 +1525,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (count < 2 || count > 127)
 			return -EINVAL;
@@ -1671,9 +1578,6 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1707,9 +1611,6 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1748,9 +1649,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0, count1;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1781,9 +1679,6 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (adev->unique_id)
 		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
