Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516DAC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A792100A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tn7xoEpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A792100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45DA6EA64;
	Thu, 18 Jun 2020 04:24:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA6E6EA64
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 04:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfrqxagDuiJ6ktkxZY9bPRWeapi5LcJiPiRy77R95g5OQiSx8EUysOmQVBXCaR5cLPHgxGUKyWVvXkhn+eQ17Cyg3J/vz792R3tdAPTQiuDh88EvrGwm9opDXy6qwL299mip5huEvtBxYfMqVIYddktc1VH9P2+AjYujUqZZ6NFoz0iBdOqmXFz/sEsMOh7YG1qe2r3PSN9S2cRwNNf5J58p2qpZwz6m6EBch0i9ffLySxje61ipTTPGxgHuIFovK5IxyrwkNfi//eVcr/HPfgLAiNpg1otTpUqr3ate5Bqv6j5xVjXnOG52gHMGjXhU24ulQFgxBAM2unXpfmZPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A7xvPTY7CyaPkBka8ZlgDZqFWbdWNm88mdwSje2Txg=;
 b=V6FfX2OKgSyD+0o/NEnR4hBOSDD/HFNOf8FaxLKb1KnpC/AG8Fgy/cSLxzsSdqeAJeG2eckoiUmobrQnG0jK1pbX/atOqQ5eHCJXgatHoRp2zs0EuElHirH6hSinIaevVQ0iCYPktaF1RaEP1WUAnJ716SPbgaS2Vi2YZAM0qtH/0QQp7iaXke7tzR0Pw6zn2bfhUZ0X2Ezc5mewHO9MFKFqJXrqjBplhfGRC0KL4ClYsGjdmyw7jdBMfqZVRbIlwZ+wKKfKBPjBzVlQxroL1Pf5ZJYE5fPMHiyKs0nixyoWeOiKMf6e1Gk/Xc/EA5ltmCzJlXe3B/4+XnP2DsRqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A7xvPTY7CyaPkBka8ZlgDZqFWbdWNm88mdwSje2Txg=;
 b=Tn7xoEpylW0d7g0nzxpz0i/eL3GqVzeAfXfRy6c03jsJ/VzIPkwxGxQpmNfLh31wfjOaBSWMjrATe4sf1FsvzUZFzNjXp7VkOCgKPvt1Hfvwp8m3wqdiOnTeVffVFUIdee2JyywMRZW5+yItKlxm0GzvVkfZIiuSWQpor/UrSFI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Thu, 18 Jun 2020 04:24:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 04:24:51 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu/pm: fix ref count leak when
 pm_runtime_get_sync fails
Thread-Topic: [PATCH 2/4] drm/amdgpu/pm: fix ref count leak when
 pm_runtime_get_sync fails
Thread-Index: AQHWRNnf+42GX5UnFUSLEdZ4I1uGoajdxw9Q
Date: Thu, 18 Jun 2020 04:24:51 +0000
Message-ID: <DM6PR12MB2619452E5EE5B9EF6CC0B9DCE49B0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200617190212.3519907-1-alexander.deucher@amd.com>
 <20200617190212.3519907-2-alexander.deucher@amd.com>
In-Reply-To: <20200617190212.3519907-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7bd9060b-17ed-4640-823b-0000aa3ce91c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T04:24:39Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66f92022-c5ac-4880-5f85-08d8133f8b56
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4220A9AF8A9E04CAF859A3D4E49B0@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggtMStG6zj/iW2wA3qwW4wehdT9E4UxJTQDVvrdwT3jwiPMwlrWZTJjeIUES0cYPOMy/JYEOQjQMZQ05WDwHC9R+5gm5XYLn0IKWfYw6+ABoTpeGXQU+x/WvDmRKwyIz6zQU5pkWBhoxUFUnhZ6RljVa9D7Icd/CjDYI3do4p3hw2rABOfktNgyqnBgyIVaHvPMsJ3v0UdAQfhZnNi8aJVSU9fVqMYm4Uah2EY0K0Mar4qQP6FcxI88K0/TITvqFid7pcmDe4UxTfZ97hFty6Q1AHXT0O0LBF7iCxJFQk4TmJ/Odua2whaVq84NtcIcjxQU0U2AGtkbfBq318AJGBi0LVBQ3bGjYVqzveKKHPkM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(52536014)(26005)(71200400001)(66476007)(64756008)(66446008)(66556008)(76116006)(66946007)(30864003)(5660300002)(186003)(86362001)(55016002)(9686003)(4326008)(316002)(966005)(8676002)(83380400001)(2906002)(33656002)(7696005)(53546011)(478600001)(6506007)(8936002)(110136005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RG62ss3R48OQ4XasDyqSSqkI9zrZx9spvZPmBM+YHZ+ERbPuimLChBVd27TyK8NhA/ATMZz+TCqUGttK6tMWC3MbtiwPR+mZPQLvdMNaYvMWMm06BiCAonGt4XLnfF4INzmMWHi8wo0tXfbiZzdg7h5h1Yn2uil6AwPSEac+h3IAuYgqrD3xyAvqvMd+JTQfxRfnNWn8nBpYGecMFvKKpcQ25jDWb+F+xr3hqPZkG0wqOdUzVPEadMzWgbICa8URibLI7i2s6Io22Sm1f9Iv5om8fvkeKPOZJZkAdhWl00pMw7pYk1/3Bbn9YGtZ9E9lwtyPseTS0pAoC72UsPoNiNbiT9vhddqDfE2ZXc/aUGDXBn54M+ORKgPQsgKeSg9W40T3ymf+tkdtaG4oPKSxMoYOVauHwcITor6racUY2cX0DxLQLEiVWywU8lvEpbZSKDUhCJ5Rq5zBFgs6L1iP1TR4B5uU1nw6BK57AIvVfYCINYGjKgi5cYMwvy/gqP8n
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f92022-c5ac-4880-5f85-08d8133f8b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 04:24:51.3266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBY7bdv4HCtTwmdQ9VjZbEIxYN5aKcR4a56ySqIiszDg0LqMCkkAOnD+aZo+sudB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, June 18, 2020 3:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/pm: fix ref count leak when pm_runtime_get_sync fails

The call to pm_runtime_get_sync increments the counter even in case of failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 220 ++++++++++++++++++-------
 1 file changed, 165 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 42bbdf49458e..14cc6c546f65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -167,8 +167,10 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 if (adev->smu.ppt_funcs->get_current_power_state)
@@ -212,8 +214,10 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 return -EINVAL;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 mutex_lock(&adev->pm.mutex);
@@ -307,8 +311,10 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 level = smu_get_performance_level(&adev->smu);
@@ -369,8 +375,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 }

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 current_level = smu_get_performance_level(&adev->smu);
@@ -449,8 +457,10 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 ret = smu_get_power_num_states(&adev->smu, &data); @@ -491,8 +501,10 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 pm = smu_get_current_power_state(smu); @@ -567,8 +579,10 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 state = data.states[idx];

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 /* only set user selected power states */
 if (state != POWER_STATE_TYPE_INTERNAL_BOOT && @@ -608,8 +622,10 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 size = smu_sys_get_pp_table(&adev->smu, (void **)&table); @@ -650,8 +666,10 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 ret = smu_sys_set_pp_table(&adev->smu, (void *)buf, count); @@ -790,8 +808,10 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 }

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 ret = smu_od_edit_dpm_table(&adev->smu, type, @@ -847,8 +867,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 size = smu_print_clk_levels(&adev->smu, SMU_OD_SCLK, buf); @@ -905,8 +927,10 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 pr_debug("featuremask = 0x%llx\n", featuremask);

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 ret = smu_sys_set_pp_feature_mask(&adev->smu, featuremask); @@ -942,8 +966,10 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 size = smu_sys_get_pp_feature_mask(&adev->smu, buf); @@ -1001,8 +1027,10 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 size = smu_print_clk_levels(&adev->smu, SMU_SCLK, buf); @@ -1071,8 +1099,10 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 return ret;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask, true); @@ -1101,8 +1131,10 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 size = smu_print_clk_levels(&adev->smu, SMU_MCLK, buf); @@ -1135,8 +1167,10 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 return ret;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask, true); @@ -1165,8 +1199,10 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 size = smu_print_clk_levels(&adev->smu, SMU_SOCCLK, buf); @@ -1199,8 +1235,10 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 return ret;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask, true); @@ -1231,8 +1269,10 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 size = smu_print_clk_levels(&adev->smu, SMU_FCLK, buf); @@ -1265,8 +1305,10 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 return ret;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask, true); @@ -1297,8 +1339,10 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 size = smu_print_clk_levels(&adev->smu, SMU_DCEFCLK, buf); @@ -1331,8 +1375,10 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 return ret;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask, true); @@ -1363,8 +1409,10 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 size = smu_print_clk_levels(&adev->smu, SMU_PCIE, buf); @@ -1397,8 +1445,10 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 return ret;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask, true); @@ -1429,8 +1479,10 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 value = smu_get_od_percentage(&(adev->smu), SMU_OD_SCLK); @@ -1462,8 +1514,10 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 return -EINVAL;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 value = smu_set_od_percentage(&(adev->smu), SMU_OD_SCLK, (uint32_t)value); @@ -1498,8 +1552,10 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 value = smu_get_od_percentage(&(adev->smu), SMU_OD_MCLK); @@ -1531,8 +1587,10 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 return -EINVAL;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 value = smu_set_od_percentage(&(adev->smu), SMU_OD_MCLK, (uint32_t)value); @@ -1587,8 +1645,10 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 size = smu_get_power_profile_mode(&adev->smu, buf); @@ -1650,8 +1710,10 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 parameter[parameter_size] = profile_mode;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev))
 ret = smu_set_power_profile_mode(&adev->smu, parameter, parameter_size, true); @@ -1687,8 +1749,10 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return r;
+}

 /* read the IP busy sensor */
 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_LOAD, @@ -1723,8 +1787,10 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return r;
+}

 /* read the IP busy sensor */
 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_LOAD, @@ -1770,8 +1836,10 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 return -ENODATA;

 ret = pm_runtime_get_sync(ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(ddev->dev);
 return ret;
+}

 amdgpu_asic_get_pcie_usage(adev, &count0, &count1);

@@ -2073,8 +2141,10 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 switch (channel) {
 case PP_TEMP_JUNCTION:
@@ -2204,8 +2274,10 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(adev->ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 pwm_mode = smu_get_fan_control_mode(&adev->smu);
@@ -2242,8 +2314,10 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 return err;

 ret = pm_runtime_get_sync(adev->ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 smu_set_fan_control_mode(&adev->smu, value); @@ -2290,8 +2364,10 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 return -EPERM;

 err = pm_runtime_get_sync(adev->ddev->dev);
-if (err < 0)
+if (err < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return err;
+}

 if (is_support_sw_smu(adev))
 pwm_mode = smu_get_fan_control_mode(&adev->smu);
@@ -2342,8 +2418,10 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 return -EPERM;

 err = pm_runtime_get_sync(adev->ddev->dev);
-if (err < 0)
+if (err < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return err;
+}

 if (is_support_sw_smu(adev))
 err = smu_get_fan_speed_percent(&adev->smu, &speed); @@ -2375,8 +2453,10 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 return -EPERM;

 err = pm_runtime_get_sync(adev->ddev->dev);
-if (err < 0)
+if (err < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return err;
+}

 if (is_support_sw_smu(adev))
 err = smu_get_fan_speed_rpm(&adev->smu, &speed); @@ -2407,8 +2487,10 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MIN_FAN_RPM,
    (void *)&min_rpm, &size);
@@ -2435,8 +2517,10 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MAX_FAN_RPM,
    (void *)&max_rpm, &size);
@@ -2462,8 +2546,10 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 return -EPERM;

 err = pm_runtime_get_sync(adev->ddev->dev);
-if (err < 0)
+if (err < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return err;
+}

 if (is_support_sw_smu(adev))
 err = smu_get_fan_speed_rpm(&adev->smu, &rpm); @@ -2494,8 +2580,10 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 return -EPERM;

 err = pm_runtime_get_sync(adev->ddev->dev);
-if (err < 0)
+if (err < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return err;
+}

 if (is_support_sw_smu(adev))
 pwm_mode = smu_get_fan_control_mode(&adev->smu);
@@ -2543,8 +2631,10 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 return -EPERM;

 ret = pm_runtime_get_sync(adev->ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 pwm_mode = smu_get_fan_control_mode(&adev->smu);
@@ -2589,8 +2679,10 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 return -EINVAL;

 err = pm_runtime_get_sync(adev->ddev->dev);
-if (err < 0)
+if (err < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return err;
+}

 if (is_support_sw_smu(adev)) {
 smu_set_fan_control_mode(&adev->smu, pwm_mode); @@ -2621,8 +2713,10 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 /* get the voltage */
 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDGFX, @@ -2660,8 +2754,10 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 /* get the voltage */
 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, @@ -2696,8 +2792,10 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 /* get the voltage */
 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_POWER, @@ -2735,8 +2833,10 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 if (is_support_sw_smu(adev)) {
 smu_get_power_limit(&adev->smu, &limit, true); @@ -2767,8 +2867,10 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 if (is_support_sw_smu(adev)) {
 smu_get_power_limit(&adev->smu, &limit, false); @@ -2810,8 +2912,10 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,


 err = pm_runtime_get_sync(adev->ddev->dev);
-if (err < 0)
+if (err < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return err;
+}

 if (is_support_sw_smu(adev))
 err = smu_set_power_limit(&adev->smu, value); @@ -2841,8 +2945,10 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 /* get the sclk */
 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK, @@ -2876,8 +2982,10 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 return -EPERM;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 /* get the sclk */
 r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK, @@ -3739,8 +3847,10 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 return -EPERM;

 r = pm_runtime_get_sync(dev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(dev->dev);
 return r;
+}

 amdgpu_device_ip_get_clockgating_state(adev, &flags);
 seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cad0b80e4afa3473948d608d812f0fb82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280173604141377&amp;sdata=7q6QSHp4%2Bidxm%2B4M5rFAVryi3zcpbdXoqoLw3ouw%2Fos%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
