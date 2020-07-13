Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80323C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 05:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5278320674
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 05:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EBD01P3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5278320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57AE6E4A2;
	Mon, 13 Jul 2020 05:39:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851196E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 05:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or/lfZXzp5Yx6nlW3Hs4/8RRH1QVhe0miNazFmJtMbp7iRxCK8XvzKc3ZUsx8B13E+8PHmdPj/x110uHQ1Dl9ihBmFfzl/d4BCYEIZlZgHlxVKBf7JD5rjM3qSHaqo+Hh83Fmjfa+z6ssbbqP+Tb30leS1WrZoZUbPzww1bv4p54KVi1WRpazwM047CmgrWl9wbzUYUIsePjBqZ9F3jHO9MYIkHuzlY18KhPUCaUf7uSX1F8eAvNf1d9g69CkhT38sZwatVKquA5GDU8Qp2ZB+VDLz3siEdyIYPaO+ZIwzrv9YtE3TDfm7QiyUlg/AvzysD10PVkp0u46PXNdc1tbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njMwn3sZkw0UTqsnnc52QypQzOx3sSumnZeh3CIbEa0=;
 b=cgB7iWN51rvYjUpx2+v29N2U/Ze5nOwlZOAuPDyUdV0ebQp1cGnVkfIjkdCpFGVDOM0RGv0wDKynYC3Jgk5Cg00Hj0R+WvpkRfJRcuTv8t31IQZ/uOT94qvVXPP3fjtqYAsj746ezHZ3/Th56brzBsglw0kVd9Cl+hX5h8Rk1R5WBVB3Nc9rcitnHO1FZSYt3bKx4cHKiEDcDE+nhpkTHuKfjcm3f89vpvJQOh65v3TPF96B8l9yHB8r7/hKj2NvGLup2kNNP1gVneEVfMXLBz7YubRkHQQuat4e/YW4DiehkBR4xi00CYzPtWYxWzDq/9boYZZKRqy2VBbIn0OrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njMwn3sZkw0UTqsnnc52QypQzOx3sSumnZeh3CIbEa0=;
 b=EBD01P3z2//imy7wIZBGOnoWJ5baYTaMC2xtrJqOh1h9/U4K8g4E0M1d8sFKTwBrctYiqXj4bpjWNTfuvJ6edMvei6+Sh2ic7TMwh4jALNKPXlD1d9HLcLdsIV3x/Ti3DaxvSnOd+q5xRZ2BERFeyxFqeqLOcrySiPjYcUmgDfE=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Mon, 13 Jul 2020 05:39:34 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 05:39:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Sheng, Wenhui"
 <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: enable mode1 reset
Thread-Topic: [PATCH 2/3] drm/amdgpu: enable mode1 reset
Thread-Index: AQHWVsTIuhm+lb46CU6Eb1vFPWi5JqkE/iBwgAAEG1A=
Date: Mon, 13 Jul 2020 05:39:34 +0000
Message-ID: <DM6PR12MB4075D7702154ED79FDBAEA60FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <20200710141644.1601-2-Wenhui.Sheng@amd.com>
 <DM6PR12MB4075C3BFA9392B51C2370243FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075C3BFA9392B51C2370243FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-13T05:33:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2a2b8b8b-d092-457a-83e4-0000ad3f0125;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-13T05:39:32Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: bcb8985b-034e-4c98-a956-0000be3929ae
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8654783b-fbdf-41f2-4f0f-08d826ef1faa
x-ms-traffictypediagnostic: DM5PR12MB2359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2359FED4DBBDFAF7F29397B2FC600@DM5PR12MB2359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWZrn1F9Lo8x//pSZZECdRSzAbaQORua+A9dtkZRH+wzgD1xlX+vVBpeC8janSA2XRin9jIkvCFmd2agHd2KNVzorTeh/U3tqrcM24gjSxuWBOg7ICvYAoyV+jaxkKohyGc+K/mECjSFvZ98Y6i/fewN/qqv/kB5ehhxn4gVWIyu/EKc3LRM96q+1ChKP+XIbk01WP/r25DSnMu2dpexXe8ceDEBBF2cT3R3/0INi3T7DdLLiQDiR98LJ680XvbEgtaZqwziZG3eL8ZUVVb0dQMC7+klJfr3QaNdJubudIy+bVr7sd9wuauuqQKWxUQ2dTezfi1MdL2gW1K4F4+w70oUctzUJglsDuZzU47QDNw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(5660300002)(86362001)(66946007)(66476007)(66556008)(66446008)(64756008)(76116006)(186003)(26005)(52536014)(83380400001)(2940100002)(71200400001)(33656002)(2906002)(4326008)(45080400002)(7696005)(6506007)(478600001)(8676002)(316002)(8936002)(55016002)(9686003)(966005)(110136005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qQ+YlOlbm5RV+YMzRHl6qRUqeGyq3q8v+LeegkrOKoqMPrluDxgyd62kafzi4dbxc6fmvU1UXvicFt9FJmYjcP/Iyg2dqVT+xb3IrLvigbagld/ZXdNmYfUtoXLPsUoY+7SwhurFmN9XinwDgH/Bpag+2hplYsFuBEdbmLv6a17k65yy+7fP+53/ngYRr5zg32g/dsSEUD9vWGx2QtQdcuobMax1+hknbSSrOZHlvNA6nFkxeEV80vPkrYupiAt3Zvt6QImQH66RYrqh0uDIXgWmcCxoIBs9OCiH5FQe8xZvDufOSNABJhmeNv3sDu9iSc8NuFn+K9/UuKcgJIgYvUfZ8JUTn+ZBEO0d9QOuaX9ai7uK4HboM24cqWwORMNrAa4WdGgaievxdUmLY/xe3sAjD4OWDffKUE8hIQsYtNBGAR8Fm4z4H40w0ZDJl+5ye4AyeQkR+yAn5PumryVoCzwSeOiEEK6UqQgiYQPtsKyjvFDfmES4hzYW909+ttnw
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8654783b-fbdf-41f2-4f0f-08d826ef1faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 05:39:34.2622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPeucmfAVjViGRZAuojxqNU0/T/EJuk/PQG+/GbVGtoCDs7e17v5cGnAnYAQtrgCfP1icPc269u7D6/ttsFU0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

So first make a patch to refine need_emergency_resetart logic in amdgpu_device_gpu_recover function. Then apply you next series to add new mode1 reset support

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Monday, July 13, 2020 13:34
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: enable mode1 reset

[AMD Public Use]

V2 looks good to me expect for the following that can be improved

+	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {

The check of reboot could be centralized to the new function amdgpu_ras_need_emergency_restart you added in amdgpu_ras.c. And it would be better you can make amdgpu_ras_need_emergency_restart related as a separated patch so that it helps to isolate ras recovery related issue from general gpu reset issue. 

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Friday, July 10, 2020 22:17
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
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
@@ -4274,18 +4274,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
-	bool in_ras_intr = amdgpu_ras_intr_triggered();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
+	bool need_emergency_restart = false;
 	bool audio_suspended = false;
 
+	/**
+	 * Special case: RAS triggered and full reset isn't supported
+	 */
+	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
+
 	/*
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (in_ras_intr && !use_baco && amdgpu_ras_get_context(adev)->reboot) {
-
+	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
 		DRM_WARN("Emergency reboot.");
 
 		ksys_sync_helper();
@@ -4293,7 +4294,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	dev_info(adev->dev, "GPU %s begin!\n",
-		(in_ras_intr && !use_baco) ? "jobs stop":"reset");
+		need_emergency_restart ? "jobs stop":"reset");
 
 	/*
 	 * Here we trylock to avoid chain of resets executing from @@ -4365,7 +4366,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_fbdev_set_suspend(tmp_adev, 1);
 
 		/* disable ras on ALL IPs */
-		if (!(in_ras_intr && !use_baco) &&
+		if (!need_emergency_restart &&
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
@@ -4377,12 +4378,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
 
-			if (in_ras_intr && !use_baco)
+			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
 		}
 	}
 
-	if (in_ras_intr && !use_baco)
+	if (need_emergency_restart)
 		goto skip_sched_resume;
 
 	/*
@@ -4459,7 +4460,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		/*unlock kfd: SRIOV would do it separately */
-		if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
+		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3a3fa8567c94..6f06e1214622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2135,3 +2135,14 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 		amdgpu_ras_reset_gpu(adev);
 	}
 }
+
+bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev) {
+	if (adev->asic_type == CHIP_VEGA20 &&
+	    adev->pm.fw_version <= 0x283400) {
+		return !(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
+				amdgpu_ras_intr_triggered();
+	}
+
+	return false;
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
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
-
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
 	pci_save_state(adev->pdev);
 
-	ret = psp_gpu_reset(adev);
+	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
+		dev_info(adev->dev, "GPU smu mode1 reset\n");
+		ret = amdgpu_dpm_mode1_reset(adev);
+	} else {
+		dev_info(adev->dev, "GPU psp mode1 reset\n");
+		ret = psp_gpu_reset(adev);
+	}
+
 	if (ret)
 		dev_err(adev->dev, "GPU mode1 reset failed\n");
-
 	pci_restore_state(adev->pdev);
 
 	/* wait for asic to come out of reset */ @@ -307,7 +311,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)  {
 	struct smu_context *smu = &adev->smu;
 
-	if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
+	if (smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
 		return AMD_RESET_METHOD_MODE1;
@@ -319,15 +323,16 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = &adev->smu;
 
 	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+		dev_info(adev->dev, "GPU BACO reset\n");
+
 		ret = smu_baco_enter(smu);
 		if (ret)
 			return ret;
 		ret = smu_baco_exit(smu);
 		if (ret)
 			return ret;
-	} else {
+	} else
 		ret = nv_asic_mode1_reset(adev);
-	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 4f7d064e16e4..014815bcae93 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2039,7 +2039,7 @@ static bool navi10_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cba02ce03c500432b668108d826ee5cd6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637302152493471927&amp;sdata=1Kn2Q6DqkrGj2hgmT6jBHibeDPCmc%2BytqGz3Bma0fv0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
