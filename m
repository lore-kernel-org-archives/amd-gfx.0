Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E85C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA3C2071A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IGlISyh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA3C2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19D46EA6D;
	Thu, 18 Jun 2020 04:25:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D2C6EA6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 04:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnyswRzKmpAajfN1OvKLMa0K2ZpsyNMVU96DkEgQqmN/PzcaMo020CMOPP6nuBegxjQXzV7DyGZdhLUPqnX9nYDDpD2riHYZTto8ExolM5dpyOsXQ5Frtk0OSnQFZRv1PprR5H44coHXE84K0CWCXT8ZnRDnwXdYRsmB3ZHBm0lyjSkX2NonJ0rfs7eCVHGjp+tv2JBopWP3d9khThxgAPdAU1rzWSqZZHlr/uAK6Km/fmURcshqlw/kj4sZlcaYViF67OyezO9KRUPTvkYIlYSnFcFR4cTZ7EV0dT0ghvoh0tqwiix7C60NQzP07c4OFgP4uedCyjw+PbqJA1OiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFGfAlKLmAyQZyvS6MaVU3iuLJ14iZ5dD3DY+H2smzM=;
 b=EjkpsJcaZ4wyD4/XPzoPBwlkuXTqD/qen5cms4uG+3vstK21g0Eqd7oh/DAjcFQUz/Jk2kyakEV0q/M8PYHpAB3Z8TFEVF7gC9CaUwLu2xyHWQziFHprvuo4DVV7WNbuE0oQdyyh24DRqbGfK0GvchMdrt/EWeCVJAyIqvVife+Yc8T6XRNYjrNdEuz7NWeRYAQX7LMtqzMMBpOCA+2Qg1EynqKjOrZPUEl2tGcRnk/LIjXNdbTl0uiwJm9vQaT6X6imkpzS5t9Jm8sfXRcKO5ZyEskc56NfQgXM2avMJzgO7kWa9FgYud2/jcRzDMvm+2FtOoniHtYbJdVUjOFOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFGfAlKLmAyQZyvS6MaVU3iuLJ14iZ5dD3DY+H2smzM=;
 b=IGlISyh5CIpAq8uq5kbBYg8zNGmV+2O7LY6JTOLQRHtAay8Q9QvnSnZzPMxkfJLsmBB/WO+W0VrBJTNnPwUVVx4FP7bGzfg1SW7Uu6LyDUeCgrvaTtGhp9CbsU/BwtT7TlaEDhyuAhngu38vjvptQCG8MwvvbIgqiUq97jHGoz0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Thu, 18 Jun 2020 04:25:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 04:25:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu/debugfs: fix ref count leak when
 pm_runtime_get_sync fails
Thread-Topic: [PATCH 1/4] drm/amdgpu/debugfs: fix ref count leak when
 pm_runtime_get_sync fails
Thread-Index: AQHWRNnb5mz4ipp8nkaMsZ0724hp4qjdxzOQ
Date: Thu, 18 Jun 2020 04:25:18 +0000
Message-ID: <DM6PR12MB2619EA81B5D7A1043E0FBD44E49B0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200617190212.3519907-1-alexander.deucher@amd.com>
In-Reply-To: <20200617190212.3519907-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9881f7bf-b32e-473b-89a1-0000633a4a02;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T04:25:09Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02350618-5e4f-447c-d68d-08d8133f9bda
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42200A58EC929917AF3274C2E49B0@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inRI8pS0KCNJI5zmNb4dhf+J2G5kjBpBSeIVFx7EE5lSk372Oy9dPWe+J+YxiNmtdiQ9HeQ8cUSzdzujTEEzos+QlihFbSS0BWUOvrgrOqLqW46fz9KC1JYXvl1+zHjiNeTiRLXYEbH3UN+jHhAcmHEcxm9Lxll1qb320CDvxe7aiUvtW2CkEBcfUeet86sqE/AEZAlxVLPK+LR//DARDHUNfpiBR9e8aCOD/EX8U78BMO6GKkFLFIC+HfZDrOihxb3NPmYt9ptMyP4Z8ZhmoUNHtPkqVbjV3xJ/o7fM8nDCY1doB3b9onFpeygVESopjaAtyTIcXbkGHrT4dYO+Oq6zHwAEvTm5a4BHgajASB0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(52536014)(26005)(71200400001)(66476007)(64756008)(66446008)(66556008)(76116006)(66946007)(5660300002)(186003)(86362001)(55016002)(9686003)(4326008)(316002)(966005)(8676002)(83380400001)(2906002)(33656002)(7696005)(53546011)(478600001)(6506007)(8936002)(110136005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HmpYurWdBaTth5l0zc1MaxEIRuuBSWs9ZVVrxmgJz/O6EIx0Xko/EhUpJMfEViildCeUutro6roC7P1MIaypABsGgllw+HcGYXW35is0bjiJpCwNaTsHYRb2YQ7nAPwEFH+OqytbOykdwRbYk7M9dZG3vIvSpcp5GBRL8s+gWjJyovKwofPHYFUo73T5uRmGWgcGEzbsrTkgKfXCOEX/rHuCms2PsZjS93rM0qDXIASqs65r1DlG7K8qBSH3k0KwYlS9l3hogQ/QapVXE0GlpujuuzHkuyK72tZoDWizoSAcvyTKxRMniXfdeBtWxKbfNSbCsMD7g9aEgiB0/rG3iijfruBDFZBT56Zoc33n8Bps+xeuijMv9crjq4UmMGSGmiGQjIOM8xnBtS3/VnHcoEQgDS5GUJkHx/Gm+Z4K2x0rU12uZOyJVivm00LOv4MOylswn8br7ADQ+aR9pcw2wViteKQCJxL45S/3A45TJtZY77450b5CN3XaYZyV1mX9
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02350618-5e4f-447c-d68d-08d8133f9bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 04:25:18.9943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0a2cmdIJNybr+74RpXnmIM1ZTE55KwjCXfSR+i6pNWPo7XbuZl2qVOp/A7eOEaHL
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

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, June 18, 2020 3:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/debugfs: fix ref count leak when pm_runtime_get_sync fails

The call to pm_runtime_get_sync increments the counter even in case of failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0ac9aab69497..aeada7c9fbea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -223,12 +223,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 *pos &= (1UL << 22) - 1;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 if (use_bank) {
 if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev->gfx.config.max_sh_per_se) || @@ -332,12 +336,16 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 while (size) {
 uint32_t value;
@@ -387,12 +395,16 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 while (size) {
 uint32_t value;
@@ -443,12 +455,16 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 while (size) {
 uint32_t value;
@@ -498,12 +514,16 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 while (size) {
 uint32_t value;
@@ -554,12 +574,16 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 while (size) {
 uint32_t value;
@@ -609,12 +633,16 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 while (size) {
 uint32_t value;
@@ -764,12 +792,16 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 valuesize = sizeof(values);

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);

@@ -842,12 +874,16 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 simd = (*pos & GENMASK_ULL(44, 37)) >> 37;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 r = amdgpu_virt_enable_access_debugfs(adev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 /* switch to the specific se/sh/cu */
 mutex_lock(&adev->grbm_idx_mutex);
@@ -981,6 +1017,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 return result;

 err:
+pm_runtime_put_autosuspend(adev->ddev->dev);
 kfree(data);
 return r;
 }
@@ -1006,8 +1043,10 @@ static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *bu
 return -EINVAL;

 r = pm_runtime_get_sync(adev->ddev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 while (size) {
 uint32_t value;
@@ -1143,8 +1182,10 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 int r = 0, i;

 r = pm_runtime_get_sync(dev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 /* Avoid accidently unparking the sched thread during GPU reset */
 mutex_lock(&adev->lock_reset);
@@ -1200,8 +1241,10 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
 int r;

 r = pm_runtime_get_sync(dev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 seq_printf(m, "(%d)\n", amdgpu_bo_evict_vram(adev));

@@ -1219,8 +1262,10 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 int r;

 r = pm_runtime_get_sync(dev->dev);
-if (r < 0)
+if (r < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return r;
+}

 seq_printf(m, "(%d)\n", ttm_bo_evict_mm(&adev->mman.bdev, TTM_PL_TT));

@@ -1410,16 +1455,16 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 return -EINVAL;

 ret = pm_runtime_get_sync(adev->ddev->dev);
-if (ret < 0)
+if (ret < 0) {
+pm_runtime_put_autosuspend(adev->ddev->dev);
 return ret;
+}

 if (is_support_sw_smu(adev)) {
 ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq, true);
 if (ret || val > max_freq || val < min_freq)
 return -EINVAL;
 ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val, true);
-} else {
-return 0;
 }

 pm_runtime_mark_last_busy(adev->ddev->dev);
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C1860e6d2bd8647d39ec108d812f0f8ef%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280173541390159&amp;sdata=MVz3X2G09LrL6rLSgLDG5IKbOkLHOlkXKvrtMTR1Ics%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
