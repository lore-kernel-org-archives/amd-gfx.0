Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB5C3F2D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 03:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BE9246A1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 03:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ois/ykeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BE9246A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DED6E9A1;
	Fri, 28 Feb 2020 03:37:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74DD6E9A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 03:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0TWQNaCwdfWzpEZ2qmrk66SO6gl/cLMvtWFLKaYxr54hy4Rj7alv4+Py4Gj9l9bfW3OBNuTel60M0zA4tW/HUCKvvkMrb1aQssb3tFpy51cmG1jp3EvYkF7/JwfA8qh0rzWO2LKe5p19PDsFym091UxWvOBRbMX6+KMl+n21jlvgOR+aGqexghiIF4Vzi1/mgBmaZOcOCtUpEl2nv0bbuRZI768gdFt33vg43Qy00D3WCGN990YkGm/uoUG03DP4rbRWHLYj9BWKfbQ+01XWqKZI5wwNPIRqpY5u+6PkdM8pSbr1rAQvn3JKH0Gcb6o7lgw01YrxjutyuqN5zIbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX1wSc+Tjo523jcDfDL9ygTYHmA3dqgjYSwEbZmufVU=;
 b=OmvYvV9qmonwA52EcFqdiZTSzY9hc7e0erRv7qc5Fk6ack0UmTGRj06KQLiLs9dlurFSkwceqjO3fGPIMKcmdNsl8JaANQvTgYV1M0dLgBKeNgLkQ2ZCVlvyaVFLO+vuOyKuM5PnmajoSXEtOXMi46mWeo7oujweh9P7Iy6l/bqCt5f9D35/Ut+5hfiRsdE4T8GiM8ms8sfLcTdXWNjEtKS0dWfg0dK/4ntFka/uh2hBrz2yR6Ut9RL/1nnkmC7ONimJA2ueBBJ8pNr/ATSar8KQX5eacwUI/UBnG2Nc3XVKCXhf3mJZIwmAU34JSpd/aTO+MZcE2ODT4xmPB4RLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX1wSc+Tjo523jcDfDL9ygTYHmA3dqgjYSwEbZmufVU=;
 b=Ois/ykeX0D34ubICTQWGrB12IrLiWwU8UAuBs0G3NZX2SATFbRDu5A7sYMSV9XHQeVMrU9aiRma9ZaGFysOSp2YJbJmX7hAVqcDKB/xB7BVyB5XiTZ1WRxDNJUiYxV54yFO6i/pf2rv6gGZf/j7gDWDMwX6lCn2RW4xxn1WwU9I=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 28 Feb
 2020 03:37:23 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 03:37:23 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] Revert "drm/amdgpu: add sysfs interface to set
 arbitrary sclk value for navi14"
Thread-Topic: [PATCH 1/2] Revert "drm/amdgpu: add sysfs interface to set
 arbitrary sclk value for navi14"
Thread-Index: AQHV7eARpSu0RPsWxkOcLBWLLuVsnqgv9PGw
Date: Fri, 28 Feb 2020 03:37:22 +0000
Message-ID: <MN2PR12MB3344987021D34B09F348FF1CE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>
In-Reply-To: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6c3efbd9-b6d5-4f14-8a5c-0000dcd6f325;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-28T03:37:06Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0b11136-6bb5-4446-b428-08d7bbff85be
x-ms-traffictypediagnostic: MN2PR12MB2989:|MN2PR12MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29892946B89C805B60A42890E4E80@MN2PR12MB2989.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:238;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(54906003)(71200400001)(26005)(52536014)(8676002)(316002)(478600001)(110136005)(6506007)(81166006)(33656002)(53546011)(7696005)(2906002)(81156014)(9686003)(8936002)(5660300002)(186003)(66556008)(76116006)(55016002)(64756008)(66476007)(4326008)(86362001)(66446008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2989;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WoLhQEnWVPY7b1q58AvHpDZoB/1YwfNFyHf+GNmMvJSM88XYJme2RK/OokU0t+6an4RoQX0QYTXPSOmYrOXmOJcE97gy6F94viczTKXMKUaLPed9lzQqQOoA/g3sfJz1iGn9EMZ98/wdgotHBuTf/qGLV5P6L4Hqramu0WYpZW2Gg+ShFk1yQf7AESqZpAgvrcpeKOO34wHOnZAkg8UFvSGI3+iHB+9QGFJf/GPyALnVw6EdLgLml0qUIczY8Pdjr0tn8ZsyA0+2vVr4rU6p53e8hi9nO8r3/18aemtTkTjpwer+XTtjyQCuAY9FMwGJEOWH2bKSHy4fqRs/AYlQAPidtcC09fqqe+Fyp6vQ9eriT82hJYNEkfc/C2fIRIL20ZKds4PYux72UJrzLZ3VlU8Wc8P9asR/8OyJ4j7hfAsDSp6EaEzo8EDbjrcc/Qbz
x-ms-exchange-antispam-messagedata: 04ZuaREAoUS+XUgxN6+aYIWafrs1dALihpn8MMvk3jNpZFQ7vHijVi1ekbdaudZ72xn5hXWmLJLLzT5Tqz+zKzs7oKFUADtL87Lqv2pL+fvqhZyYIKGQmNKD9xcRt1hNfXBHvCrVu8cgQpsM63a8TQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b11136-6bb5-4446-b428-08d7bbff85be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 03:37:22.8578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lz1hWw8DJ3DAz9V1EEdGdafPYYH1xfWAwrf61+IuSTziKZzaR4LtDun/YtU9Qmwp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2989
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Friday, February 28, 2020 10:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: add sysfs interface to set arbitrary sclk value for navi14"

Revert this commit and than add debugfs interface to replace this to meet the specitic requirement.

This reverts commit 3107269204f8e18f389080673f7848b420970aa5.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c    | 42 -------------------------------
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c |  9 ++-----
 2 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 9deff8c..bc3cf04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1034,40 +1034,6 @@ static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 	return 0;
 }
 
-static ssize_t amdgpu_set_pp_sclk(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t count)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
-	int ret;
-	uint32_t value;
-
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
-		return ret;
-
-	ret = kstrtou32(buf, 0, &value);
-	if (ret < 0)
-		return ret;
-	if (is_support_sw_smu(adev))
-		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, value, value);
-	else
-		return 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
-}
-
 static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -1829,8 +1795,6 @@ static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,  static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,
 		amdgpu_get_pp_table,
 		amdgpu_set_pp_table);
-static DEVICE_ATTR(pp_sclk, S_IWUSR,
-		NULL, amdgpu_set_pp_sclk);
 static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,
 		amdgpu_get_pp_dpm_sclk,
 		amdgpu_set_pp_dpm_sclk);
@@ -3322,12 +3286,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
-	ret = device_create_file(adev->dev, &dev_attr_pp_sclk);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_sclk\n");
-		return ret;
-	}
-
 	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
 	if (ret) {
 		DRM_ERROR("failed to create device file pp_dpm_sclk\n"); diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 1507bb7..c9e5ce1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1803,17 +1803,12 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_  {
 	int ret = 0, clk_id = 0;
 	uint32_t param;
-	uint32_t min_freq, max_freq;
 
 	clk_id = smu_clk_get_index(smu, clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
-	ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, true);
-	if (ret)
-		return ret;
-
-	if (max > 0 && max <=  max_freq) {
+	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
 						  param);
@@ -1821,7 +1816,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 			return ret;
 	}
 
-	if (min > 0 && min >= min_freq) {
+	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
 						  param);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
