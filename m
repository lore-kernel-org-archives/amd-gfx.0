Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC37C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0001220724
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eOeo8JgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0001220724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C62196E454;
	Mon, 13 Jul 2020 03:45:28 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690052.outbound.protection.outlook.com [40.107.69.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956E26E454
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 03:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRUHwrZZitoNu7x6AwfQfnA6EH3MLWbb+kpZdbpSOfU1lLnFjOWEN1YsQ3R6n/F9Idwd4S3FJ/BDNd8hbSPuGaZxkVzHgW8TohOhAuR134eNHxgcS/razJBv03oo6NKXVkXH3qW7+TpE7tosl9rzvKaaDe0638qrObHN54OTwfK8zSqd6MAUyTqrPWnJ0Upq0lBtAn+bDsRaULxWcrx37g+T3NWCgfxQJrJ71pWMngOOhUtS4PYy+RKtq07OLcY5vr5y4eD21uEhk91/dhKDmgxqVTbai9JLBzmIVAfAIntdNztnCHx+fQH2tZKgASQIQbjCbh+//ATALkRAcQPWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zoxi2Q+oEJ/CWZmtUDcU1gHQq9pgysftCjyjQYLXQws=;
 b=Ej+3mwYR5fudAr2FB16jQQ3BI8yvZ0q5H7t7fKax0Ofi6E0v16PUqVKf5q856PIwBpInu3RVrwKMqt/wrhmGTG//ZPFDHRvgmluQ8seEt9GgvX4GnvnfFFmbEyUtZI55kw3k7UoulJUpOmE9e3CUl0qfVypr8Q8XACyl9Set0LXohwIdwv0eZuL0zTPtwPuswZ2TKtGm1XMnOi3zpEDhi1dcV7ZsUd3dKyqzif4YPzNmcFxTz3ViFOFZbdlYW2XJOrUMT+uou5kic5zNMkRmx05/5xljCG7CPf+Mj+2No/NShjOWA1mBkcWral9SN8ZyItEP0mJgx9TeH/VdY3/eCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zoxi2Q+oEJ/CWZmtUDcU1gHQq9pgysftCjyjQYLXQws=;
 b=eOeo8JgA0ebndK3Ly390KIZk52YvJsyhKcjecl4FMIvLYbBoDdfafw3kDiBQp55sYhOEULE+12/wZQmyrMpMirMyfiRPIHjU1v7wAZkP1PR+GHQQpNh0BBF2VzbYRAXlDrAZ3+DBqGPvgSHxulu0x5nD72WWPqDLher7KLfNmj8=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 03:45:26 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 03:45:26 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: enable mode1 reset
Thread-Topic: [PATCH 2/3] drm/amdgpu: enable mode1 reset
Thread-Index: AQHWVsTIptFqK5V1qUS/L+nedG82pqkE3QcAgAAFU5A=
Date: Mon, 13 Jul 2020 03:45:26 +0000
Message-ID: <CH2PR12MB4101D4BF20595E16F5BCA16D8C600@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <20200710141644.1601-2-Wenhui.Sheng@amd.com>
 <DM6PR12MB2619F6AE499BD6ACC9999EBFE4600@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619F6AE499BD6ACC9999EBFE4600@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4c69f2b7-e798-4785-b6a5-0000c158af65;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T03:20:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-13T03:45:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 73f25452-b7dc-46ec-ba3b-0000818d9547
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6810a7d6-6543-493d-f8af-08d826df2dda
x-ms-traffictypediagnostic: CH2PR12MB4086:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB408646EBEA5158824CBB26BB8C600@CH2PR12MB4086.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coHQXZb69rfcLd1cvsVsRDU2yCaRGKiasIB3ZUFoZ7BwmYQslNsJdi35qF2cSOagLQVhpSerzxoTwkYfFh9L8E1jEtoiC6NAWOQl6+obkbPJAmeN2STyXo/2p+cBolajCTEc6exu02UwN7V63k3LQitaziejKehJk1VqIlzZolbGJeArvBxkMneYUGklm+hBpAg7BoVtZ9zh9ZTjvKYhwV6PkN/V2JltoLXyeq/cIhZ9F2PVk6wl0kaFdZ9/oV6+1HOoMrdw0zYkT2+1E6yjWSSX23aVeXwnscsHNdTNY0/emP0UBDEWUx6OK0ApcSr6Z7UCaU4pb5EBLxCh2OTEUoe+j6/ztCpETur/jf9yIdg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(8676002)(76116006)(66476007)(66946007)(86362001)(9686003)(4326008)(66556008)(966005)(66446008)(64756008)(71200400001)(5660300002)(186003)(53546011)(478600001)(8936002)(6506007)(52536014)(55016002)(7696005)(45080400002)(316002)(26005)(33656002)(110136005)(54906003)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DenFChRER5SF8Le6dKhCJJIC9IDizM1up190Ay9LAfmu324BdtsPG/s9TXbeHddR4EYjthw/LCOx0gd6XDjOuU1jxCnvJpLZpKUvNh1Z1RG0OWelWDJMwYG0CaE8PRWPSOTNP7xVuaLvY+XzYjSDE6fZl6XdNOM21ZnC6ySdoaLVT6bKW9YEk8/oxjdiefwCz/bUrZdDsas9OeKA0aLCVfuj4siwEkaEGvX6X5MMYGkafGcYDlWH/h0LY+F3GV981anJ6oxwzVjpZnGCnsM34wtwOVMk1pd6Gxyi1nkVdOr6WBfIESXpRNF3kh8nIOrj9g6eJN5VJY9hOM7ZpbrUqjOqJzPB2bC6tu8uIbHmKu5XFAk/9YQlIx/Qv+o6AJetOXBeBj/kT9y2+0/Qd44k87sjU5S78+bIR0Bfi6nZ2mkCC04UqIgQT9uCjCk2DwPsveGUeDbNtQ7fCf6x18qO3/6iBgsDkApUGxJvKKH6b9kBSLvYljHQyMdHaTkGyb9m
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6810a7d6-6543-493d-f8af-08d826df2dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 03:45:26.0578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bm7HSZ1NXQ+XgtmAdrCKk4/wTRTLaYNyT3ZzTbsazfjUuZGRMdrajb8s51Sm3ASusFgVlfOnpximVupj+cNBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Ok will refine it

Brs
Wenhui

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, July 13, 2020 11:26 AM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: enable mode1 reset

[AMD Official Use Only - Internal Distribution Only]

It seems this patch contains different changes. Better to split into several patches:
One for amdgpu_ras_need_emergency_restart() changes.
One for the following changes:
+if (amdgpu_dpm_is_mode1_reset_supported(adev)) { dev_info(adev->dev,
+"GPU smu mode1 reset\n"); ret = amdgpu_dpm_mode1_reset(adev); } else {
+dev_info(adev->dev, "GPU psp mode1 reset\n"); ret =
+psp_gpu_reset(adev); }
+
One for the changes below
-if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
+if (smu_baco_is_support(smu))
And maybe the final one for coding style fixes.

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wenhui Sheng
Sent: Friday, July 10, 2020 10:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: enable mode1 reset

For sienna cichlid, add mode1 reset path for sGPU.
And fix some corner cases about mode1 mode reuse.

v2: hiding MP0/MP1 mode1 reset under AMD_RESET_METHOD_MODE1

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/nv.c            | 19 +++++++++++-------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c |  2 +-
 5 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fec6cf3f0c8a..6ce6e6bb8b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4274,18 +4274,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,  struct amdgpu_hive_info *hive = NULL;  struct amdgpu_device *tmp_adev = NULL;  int i, r = 0; -bool in_ras_intr = amdgpu_ras_intr_triggered(); -bool use_baco =
-(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-true : false;
+bool need_emergency_restart = false;
 bool audio_suspended = false;

+/**
+ * Special case: RAS triggered and full reset isn't supported  */
+need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
+
 /*
  * Flush RAM to disk so that after reboot
  * the user can read log and see why the system rebooted.
  */
-if (in_ras_intr && !use_baco && amdgpu_ras_get_context(adev)->reboot) {
-
+if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
 DRM_WARN("Emergency reboot.");

 ksys_sync_helper();
@@ -4293,7 +4294,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,  }

 dev_info(adev->dev, "GPU %s begin!\n",
-(in_ras_intr && !use_baco) ? "jobs stop":"reset");
+need_emergency_restart ? "jobs stop":"reset");

 /*
  * Here we trylock to avoid chain of resets executing from @@ -4365,7 +4366,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,  amdgpu_fbdev_set_suspend(tmp_adev, 1);

 /* disable ras on ALL IPs */
-if (!(in_ras_intr && !use_baco) &&
+if (!need_emergency_restart &&
       amdgpu_device_ip_need_full_reset(tmp_adev))
 amdgpu_ras_suspend(tmp_adev);

@@ -4377,12 +4378,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,

 drm_sched_stop(&ring->sched, job ? &job->base : NULL);

-if (in_ras_intr && !use_baco)
+if (need_emergency_restart)
 amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
 }
 }

-if (in_ras_intr && !use_baco)
+if (need_emergency_restart)
 goto skip_sched_resume;

 /*
@@ -4459,7 +4460,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 skip_sched_resume:
 list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {  /*unlock kfd: SRIOV would do it separately */ -if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
+if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
                 amdgpu_amdkfd_post_reset(tmp_adev);
 if (audio_suspended)
 amdgpu_device_resume_display_audio(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3a3fa8567c94..6f06e1214622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2135,3 +2135,14 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)  amdgpu_ras_reset_gpu(adev);  }  }
+
+bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev) { if
+(adev->asic_type == CHIP_VEGA20 &&
+    adev->pm.fw_version <= 0x283400) {
+return !(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
+amdgpu_ras_intr_triggered(); }
+
+return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e7df5d8429f8..b2667342cf67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -633,4 +633,5 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);

 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);

+bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 356849136d1d..9f1240bd0310 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -265,17 +265,21 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)

 amdgpu_atombios_scratch_regs_engine_hung(adev, true);

-dev_info(adev->dev, "GPU mode1 reset\n");
-
 /* disable BM */
 pci_clear_master(adev->pdev);

 pci_save_state(adev->pdev);

-ret = psp_gpu_reset(adev);
+if (amdgpu_dpm_is_mode1_reset_supported(adev)) { dev_info(adev->dev,
+"GPU smu mode1 reset\n"); ret = amdgpu_dpm_mode1_reset(adev); } else {
+dev_info(adev->dev, "GPU psp mode1 reset\n"); ret =
+psp_gpu_reset(adev); }
+
 if (ret)
 dev_err(adev->dev, "GPU mode1 reset failed\n");
-
 pci_restore_state(adev->pdev);

 /* wait for asic to come out of reset */ @@ -307,7 +311,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)  {  struct smu_context *smu = &adev->smu;

-if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
+if (smu_baco_is_support(smu))
 return AMD_RESET_METHOD_BACO;
 else
 return AMD_RESET_METHOD_MODE1;
@@ -319,15 +323,16 @@ static int nv_asic_reset(struct amdgpu_device *adev)  struct smu_context *smu = &adev->smu;

 if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+dev_info(adev->dev, "GPU BACO reset\n");
+
 ret = smu_baco_enter(smu);
 if (ret)
 return ret;
 ret = smu_baco_exit(smu);
 if (ret)
 return ret;
-} else {
+} else
 ret = nv_asic_mode1_reset(adev);
-}

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 4f7d064e16e4..014815bcae93 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2039,7 +2039,7 @@ static bool navi10_is_baco_supported(struct smu_context *smu)  struct amdgpu_device *adev = smu->adev;  uint32_t val;

-if (!smu_v11_0_baco_is_support(smu))
+if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 return false;

 val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C5f3fbaad4309421b1e7508d824dbed1e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637299874318950168&amp;sdata=iVrmi9ovJz57IzZfR3wFAJDEhVmwXmTGOlzvMIxAZq4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
