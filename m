Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E4C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 04:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAEB64E6F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 04:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAEB64E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C778993B;
	Wed, 24 Feb 2021 04:17:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D3A89916
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 04:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKaidHaWFLXe717t+YWUiCIgmG3KvZRIsb2ixo2m4h9E4um0zZ9mLSzVEtkrnd2XnkdJw0h5m/ImWsQsCd91I0MHWb5St8vekoE82HpQdz6EV4vWnrkZsgOHd/o+raXs/pXbj9lMywNt89ccO6zpQvQ49DUU91sUSf48r37IdnBpws+Y0y5dGwM5weHwSAyPOhizxyoQyrNUbRXbE2Nt6XX1gUv468t2Yu+T9k/S67ekEWIP8MAC56DbtKocSmKbr8hB8gBQo3cEvshUPVKz8fkKrHGmHl07mF/Tm1JyzY8Xye4qkyMPsnavqFkrjGC0uFHdHNl8EMOEd4cIRDO7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGZnmBG7J+iPJER39Z80pHRem1yrQu1i4YEvRE3Y7u8=;
 b=a/kzDaebRQW/gR8FLmUhsEk6gTOu2Pgfz6uZjiG8C/v7NUePlTeK5SyHqiOwceh4+YzKPk2GIrGo2Y/e15eIe9ruN+gCAF4kuepDImKmpsSIs+bH8LYSRZm1G+faAzoOXqYDp/iy4gB96Q2DrbO25a7C7B2LifGtPJpwn+XrDIOXmmCKtjlRe5n7N4KM22Y1XCjUO7uqMcysyZQW8geLjylOL0ABWnx+WUckdeToFwy1jblH6GWgixo900aMWNw7BIjJ59iT6YsqNh35MkER6+JKEQM+aSBLcs7nPqHPkNvGrCEQ9Y8h3ZGnaxInbRso4aoD9257ENAhOuZU+FbWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGZnmBG7J+iPJER39Z80pHRem1yrQu1i4YEvRE3Y7u8=;
 b=ytCwep5xX7/czfNLiKYDSJqagTWWUU5cQNf3m5dP1oBMvrB6m8HR58RuMJ+7lZKIcvGNI3gRIFGFKjuiUNoGK9BTKwMgnFtyhxYPC1mlT9RQzWNSDhQcFuRmbl9BGU9KzQ/5D3Owy/Mvub69tHG+uidQCYHSz/Cnwch144kU4pE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Wed, 24 Feb 2021 04:17:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Wed, 24 Feb 2021
 04:17:05 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 8/8] amdgpu/pm: Powerplay API for smu , updates to some pm
 functions
Thread-Topic: [PATCH 8/8] amdgpu/pm: Powerplay API for smu , updates to some
 pm functions
Thread-Index: AQHXCZto/wm3PQyDBE6fcpB6LBY9P6pms7Bg
Date: Wed, 24 Feb 2021 04:17:05 +0000
Message-ID: <DM6PR12MB26197B0CAE3A30A236670EFCE49F9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210223042032.3078-1-darren.powell@amd.com>
 <20210223042032.3078-9-darren.powell@amd.com>
In-Reply-To: <20210223042032.3078-9-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-24T04:17:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=23731c09-605a-4d4c-b9fc-6dd3fbdd62ad;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a16d7971-afbc-42dd-432d-08d8d87b0b64
x-ms-traffictypediagnostic: DM6PR12MB4957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49571A26742450690F20917FE49F9@DM6PR12MB4957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrBG+hs7wuGoaPhZPtMD5T5Sxb77i0ABvr6BfSoKpx4D48VjxXeJl+LnONnAvwgnr5Eo1XX+4zFwg6duLMV1Cblif266Nxu6ak9WT7IrbzDWfLJwfsix6rB94pzoO0/GUB66a9PEEaXYo8eqOlIF4r1+ISWqdwVBf1mOal62Q/9sj0Jaz51/QtY3h2tgawjsVq0eIUZlCkKQLG8+yvAZjn4NAiYpm9Ib2xrLGuMXhjR8/1cpl6/OX2ZQEvE2PyNKd4gbTnrEAQpS22kJORh7Ql4wwg4XLuUgluS0u5gK7cbSIVJcYTF/b/3iR9jqUqWCnEkVj2CaW42B4gj2oOX1xRoPD3yRbNH+lVIG3r/ec9tt5apoocVGvrcc/setGyxHQNYXTdh3GFyz+79/LykCIvl7jeDV5edF2MdmXAmdXMn6ZPIkwbGBAKiYLO27cmxCEjzbxjGz6bDclpFlhA6D+Hv79XMfLCyx4YEZPIwklVZd6kUaeaEAD3nPzmJpW+fzqs5nSX32ElaTFwm25ptl9Rkd+fgTicRGFCMIbVS3bdE4+oMBWoiDFL7FECJCcQOP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(7696005)(53546011)(478600001)(966005)(26005)(86362001)(30864003)(186003)(8676002)(6506007)(83380400001)(2906002)(52536014)(316002)(4326008)(71200400001)(110136005)(33656002)(66476007)(64756008)(66556008)(5660300002)(8936002)(66946007)(9686003)(55016002)(66446008)(15650500001)(76116006)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RHChSDDDdNXgUmOrCF3NgZUN9npS6USRcP/UY4LZM+qtVr9W1gmWvEgpIyWm?=
 =?us-ascii?Q?Z3793bK1hbLu3eX+NIUeKtcYSuq+DE17RC8XdcmzOMTaInnYRsiQGgbMtcFG?=
 =?us-ascii?Q?blQg78eSoy21uzyR4n1iiLkAh0ysR2SrqhYEWpRwCS48LIUJpUKAzkLJfv83?=
 =?us-ascii?Q?UW1jSnayK8a9x6qpPehezILUAj5QDvOl1nf4hULepBjVUz+9InCACnexjHx6?=
 =?us-ascii?Q?+SNGmFH/4cWANJoSwQ3tinS6adqmmKHSXSYgHQ6Jm0+6v7WD6awHcPZr+kYy?=
 =?us-ascii?Q?uVfpVGGFAc1jaZFraPpGJSRIbKO4qSpX8oMFcUqsa6RA+yNGgLPOTrPwX1hA?=
 =?us-ascii?Q?xgn+7ptcZBBx0PsqJ4Uma9jXvNMuqmbbiIp6psMvRZprseyYqMN1I/hfkO5H?=
 =?us-ascii?Q?bPRRE48eg5D3CwdTTRc9k2dVnO+ET7CsJnimJrek9UEs4JZ0Ma5+ZyndrtqJ?=
 =?us-ascii?Q?K1WeinfuHww+yStOyh4/lvwIGFi4/gI2Jgvzu4RJEs7qv4iIl7kuJWdjrxhp?=
 =?us-ascii?Q?ZDUlutypAGw7pKnsDfY+co7Uo7yr1a62qrO3L7KT1W07ajgDA90DZtYtrcOm?=
 =?us-ascii?Q?1B/HRRX9y4+XVqelFa5ZC4iVz1/CKeoWpRD9qgcgaTYQfP7D9NLSYuifNb0t?=
 =?us-ascii?Q?soZ55+iIprk6eRS6FPm41FuRxzL9vJmVOKS4Q6lGpfILm/K1u3ehdzead1ht?=
 =?us-ascii?Q?bVYs9RDCEVI5r/BDdrXeXEGZzHgyrqJnrexhXfnSZsH5lX9G6nsd1p3XfkKq?=
 =?us-ascii?Q?dpJxP5i/Uv/0HtKe/S3I83JAlDH0hiAysU81HzCgOcdx000xWED7XFUl7GM3?=
 =?us-ascii?Q?M9yIXqcfTmfW9VGBR9BC3Y441fZDmfuRKTyG2nLas0QVpLmO+xh/dONO0nMG?=
 =?us-ascii?Q?/PZLPrEf2oVlaoPoqvJqM3DvPI6MZbYAd1cTA6F9WjTeJD/mCxWK3skJE19U?=
 =?us-ascii?Q?N4uIDtywRLySXjs5nZgcaJ7SyXFtCywp9hWwLsZQ85ECEW8BNSfp3JAHX1Rp?=
 =?us-ascii?Q?5cOJ3Eb/57pWJZeo/rm7kq1i/4Klah//giJ/q2Z6Tmrqv6fqD2/+8BbsVq8D?=
 =?us-ascii?Q?xtfldrEnAXICJQk4ls9TgvPAr42KrQiSmqp8UMyKnSxuOYznHDw6zP5H/b1s?=
 =?us-ascii?Q?adqlD9cLl0yuAeAA83SumWrJHGDOZZLYxd/MFeiA9xHFvx3fqrEvSVvpxGvF?=
 =?us-ascii?Q?HkX6rTRvy/XKt3ngLs3ENyTMJVmWtnCfnelUIFvEihv05rFEwZjn5e5bNf5y?=
 =?us-ascii?Q?NEKsEsytiA3PeQhmsyWYS6PGSB06gTv+M9uk98xUUu4zEhNaR3lkbSDYr93w?=
 =?us-ascii?Q?5Asgo4l9yFi/K23ogawEFrv6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16d7971-afbc-42dd-432d-08d8d87b0b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 04:17:05.5742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHxhy+wkn18AuqoRJVJruo7IKery6CdoOhU7h2UmyCcbFTJwiFm1SBHCbTMr7tDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Cc: "Powell, Darren" <Darren.Powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Darren Powell
Sent: Tuesday, February 23, 2021 12:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 8/8] amdgpu/pm: Powerplay API for smu , updates to some pm functions

v3: updated to include new clocks od_vddgfx_offset, od_cclk
    Context mismatch with revision v3 to patch 0003

Modified Functions
  smu_sys_set_pp_table()        - modifed signature to match Powerplay API set_pp_table
  smu_force_performance_level() - modifed arg0 to match Powerplay API force_performance_level
  smu_od_edit_dpm_table()       - modifed arg0 to match Powerplay API odn_edit_dpm_table

Other Changes
  smu_od_edit_dpm_table()       - removed call to task(READJUST_POWER_STATE) after COMMIT_TABLE,
                                  now handled in calling function
  amdgpu_set_power_dpm_force_performance_level() - now checks thermal for swsmu systems before trying to change level
  amdgpu_set_pp_od_clk_voltage() - now attempts to set fine_grain_clock_vol before swsmu edit dpm table

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 98 +++++++++--------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 17 ++--
 3 files changed, 48 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ec5277ed74f7..1675a5e72a0d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -370,14 +370,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_force_performance_level(&adev->smu, level);
-		if (ret) {
-			pm_runtime_mark_last_busy(ddev->dev);
-			pm_runtime_put_autosuspend(ddev->dev);
-			return -EINVAL;
-		}
-	} else if (pp_funcs->force_performance_level) {
+	if (pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
 		if (adev->pm.dpm.thermal_active) {
 			mutex_unlock(&adev->pm.mutex);
@@ -615,15 +608,12 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_sys_set_pp_table(&adev->smu, (void *)buf, count);
-		if (ret) {
-			pm_runtime_mark_last_busy(ddev->dev);
-			pm_runtime_put_autosuspend(ddev->dev);
-			return ret;
-		}
-	} else if (adev->powerplay.pp_funcs->set_pp_table)
-		amdgpu_dpm_set_pp_table(adev, buf, count);
+	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
+	if (ret) {
+		pm_runtime_mark_last_busy(ddev->dev);
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -821,53 +811,42 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_od_edit_dpm_table(&adev->smu, type,
-					    parameter, parameter_size);
-
+	if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
+		ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
+							parameter,
+							parameter_size);
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
 			return -EINVAL;
 		}
-	} else {
-
-		if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
-			ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
-								parameter,
-								parameter_size);
-			if (ret) {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
-		}
+	}
 
-		if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
-			ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
-						parameter, parameter_size);
-			if (ret) {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
+	if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
+		ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
+						    parameter, parameter_size);
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
 		}
+	}
 
-		if (type == PP_OD_COMMIT_DPM_TABLE) {
-			if (adev->powerplay.pp_funcs->dispatch_tasks) {
-				amdgpu_dpm_dispatch_task(adev,
-						AMD_PP_TASK_READJUST_POWER_STATE,
-						NULL);
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return count;
-			} else {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
+	if (type == PP_OD_COMMIT_DPM_TABLE) {
+		if (adev->powerplay.pp_funcs->dispatch_tasks) {
+			amdgpu_dpm_dispatch_task(adev,
+						 AMD_PP_TASK_READJUST_POWER_STATE,
+						 NULL);
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return count;
+		} else {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
 		}
 	}
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -892,18 +871,13 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		size = smu_print_ppclk_levels(&adev->smu, OD_SCLK, buf);
-		size += smu_print_ppclk_levels(&adev->smu, OD_MCLK, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_VDDC_CURVE, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_VDDGFX_OFFSET, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_RANGE, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_CCLK, buf+size);
-	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
+	if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf+size);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf+size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf+size);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index a2f4b8f1db4e..af71c7c6db46 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1242,7 +1242,7 @@ int smu_get_power_limit(struct smu_context *smu,
 int smu_set_power_limit(void *handle, uint32_t limit);
 int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf);
 
-int smu_od_edit_dpm_table(struct smu_context *smu,
+int smu_od_edit_dpm_table(void *handle,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
@@ -1294,7 +1294,7 @@ bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_sys_get_pp_table(void *handle, char **table);
-int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
+int smu_sys_set_pp_table(void *handle, const char *buf, size_t size);
 int smu_get_power_num_states(void *handle, struct pp_states_info *state_info);
 enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);
@@ -1324,7 +1324,7 @@ u32 smu_get_sclk(void *handle, bool low);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 enum amd_dpm_forced_level smu_get_performance_level(void *handle);
-int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
+int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
 int smu_sys_get_pp_feature_mask(void *handle, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 72501d8a80b9..f5d9590f2178 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -477,8 +477,9 @@ int smu_sys_get_pp_table(void *handle, char **table)
 	return powerplay_table_size;
 }
 
-int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
+int smu_sys_set_pp_table(void *handle, const char *buf, size_t size)
 {
+	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	ATOM_COMMON_TABLE_HEADER *header = (ATOM_COMMON_TABLE_HEADER *)buf;
 	int ret = 0;
@@ -1775,8 +1776,9 @@ enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 	return level;
 }
 
-int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
+int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level)
 {
+	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int ret = 0;
 
@@ -2278,10 +2280,11 @@ int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
 	return smu_print_smuclk_levels(smu, clk_type, buf);
 }
 
-int smu_od_edit_dpm_table(struct smu_context *smu,
+int smu_od_edit_dpm_table(void *handle,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2291,11 +2294,6 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 
 	if (smu->ppt_funcs->od_edit_dpm_table) {
 		ret = smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
-		if (!ret && (type == PP_OD_COMMIT_DPM_TABLE))
-			ret = smu_handle_task(smu,
-					      smu->smu_dpm.dpm_level,
-					      AMD_PP_TASK_READJUST_POWER_STATE,
-					      false);
 	}
 
 	mutex_unlock(&smu->mutex);
@@ -2950,6 +2948,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
 	.get_current_power_state = smu_get_current_power_state,
@@ -2957,11 +2956,13 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_fan_speed_rpm       = smu_set_fan_speed_rpm,
 	.get_pp_num_states       = smu_get_power_num_states,
 	.get_pp_table            = smu_sys_get_pp_table,
+	.set_pp_table            = smu_sys_set_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
 	.dispatch_tasks          = smu_handle_dpm_task,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
+	.odn_edit_dpm_table      = smu_od_edit_dpm_table,
 	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
 	.get_sclk                = smu_get_sclk,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C032980474b064f959adb08d8d7b28a18%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637496509115947921%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=YPPZTA%2BGtDWywgk3gdw2TOkc1xcoP1M59Qh4%2BBuTy8c%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
