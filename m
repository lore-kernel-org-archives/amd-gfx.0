Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3698DC3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 04:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EA5246A2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 04:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4G0visMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EA5246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B70206EDD0;
	Fri, 28 Feb 2020 04:59:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5826EDD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 04:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGEHKDfHz+zAEJdELwphHYXtWkzbrU7KjRZDGWrSCNrNL4kIo5l6KLJ4LTgoUjWIDBAxbIMHdDIDICkwzvX2/yJ94fOWNAwiuD9U0JG1kVoFFsnPSTFvRkoeLh8qpmkGTZyk3/nghDtTmxN/ioBnx18hXxdMdxJcYQ/cAIj3eVEqDICmdYSth3jiOdFBqCcHbyq9u5r0nJW5Wqn+nfEIvb9KK6HaBBfYjlHioXcyuA6EzNddQnDYVPAQoXNtKd9YA0Goblt5HaSghXiXF26u2N9HpZprVzpTdBU+7NFb6hwouG0/gcdggxWmUk2x7U93S7q30Q6hY6rh2mnFcD0o3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHMa7wdERA26qc8/W7pqybyJlAFxXypbhxJGkEmbYP8=;
 b=G8QI8hbiPlh83nOhMtRqIhZ1OiHJeAiZ2M9/1dX8Utdf5wdrDJN5hf0DhQfoQT/GgEtDc68/1g3Udy7IkCiijh3yvsKBf3PqEFbCPFX7NDmlApozb3XTty4tW1cnd9+lMMK52s/KaJLuWb6ZGFYMn3Qz89ovNulHofznTSNa5XRC9VJXYaLK5YdzCrR7PhhoYQ4Jwj1JZoDcUglHYCmiPaYkMRy9dnPbcfNVxR21WdPXjaaV76S+lANQWSSY76JccYo+mnPJfM6QGMltosAb2csjeXrPSuKL6cd9GBI+rAjU0haznVy3XoicaK6DOxI1SrhSiSLdaH7VDIiLUkrHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHMa7wdERA26qc8/W7pqybyJlAFxXypbhxJGkEmbYP8=;
 b=4G0visMv3W9Q50RKU5lx7MOIw21upliSqp33sSb1NgHMDZQ3orin94re6nsV6Devs0ZihiTKIjT/uDWPI50vrNwdHXKNY60cjT9fdFjbwUzeaPvi9MW9yC3pZgqsSfshJ3WXHTLHpjOAvg8XPf1RXBsSn1aWArAeKHH3aN7cLxQ=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 04:59:40 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 04:59:40 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary
 sclk for navi14
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary
 sclk for navi14
Thread-Index: AQHV7eAV2rumPmr8AEmZb8iCnBMpbqgv9LXQgAAQfQCAAAVKEA==
Date: Fri, 28 Feb 2020 04:59:39 +0000
Message-ID: <MN2PR12MB33449D9BBC65C91BBCF74E0EE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>
 <1582857441-32135-2-git-send-email-Jack.Gui@amd.com>
 <MN2PR12MB3344E5B3AA5E9D6CB9F7795FE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
 <DM5PR12MB2583591246E12F5ED3C3C19E8BE80@DM5PR12MB2583.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2583591246E12F5ED3C3C19E8BE80@DM5PR12MB2583.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0788bad6-0381-4a30-b69b-0000b0983bdb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-28T03:36:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37990c13-a0f9-4ba4-af1f-08d7bc0b0463
x-ms-traffictypediagnostic: MN2PR12MB4190:|MN2PR12MB4190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4190BDA365640ADDFD03EE0AE4E80@MN2PR12MB4190.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(66946007)(66476007)(316002)(4326008)(86362001)(64756008)(33656002)(9686003)(52536014)(66556008)(66446008)(8936002)(81166006)(8676002)(5660300002)(26005)(71200400001)(76116006)(54906003)(186003)(6506007)(478600001)(81156014)(53546011)(2906002)(55016002)(110136005)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4190;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1KygNLCmjOMEk98lmjCU8Z+c9aEseKxWJYEaFr3qP0UWmgwhnKunVOLaGPwGGAhkqYDa1hmg/wMhr6p7PURraPTKIWHT62Ai1Kmi0bcgRiLB2YvBDxCpdedlyd5+p+cdlbWHbO66gTsf6ywhxohs29jx/1UzEnKY2u4Rtx6UbTE69+YzCYUtr1v4ZfhH5B9uYAifNbZqH1sp+41+t1wLm5pm+JD7fBZn1o1eW0qXbuiZUD0pZ91SD51nPdulVtRay2ejVmv89onE+TggW9/M/tvmizdWJGY1jG5l5n578pqgRkq60PFVnyLHCB0pBAShTMpJiFU01wryCDVPAmR6Pfey+b+ne+dIuZ8OMN/Z/UP2G5u/6cgxk0misIeDCtYD/YIHnJBfkVqvOZDI7Gko0cJI8z7MkQVP7ecj5ggpunKIusq7i8MZlUg6jIvwRZNR
x-ms-exchange-antispam-messagedata: /BZxjhKA+uoat4vZilfOUhVfhSLDfV9U1qUklj3IWzx1KczodhDLRstyWdP0abNwwLqX5Ve2pcA0gmfZ3vQDsuotj/DO+TxFY8mMqbI+UVvL4+0G1sFWRQGDk7Ld6j5xJ1wAldGcimagkKZQW7Le2g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37990c13-a0f9-4ba4-af1f-08d7bc0b0463
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 04:59:39.7919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guiUUDrSF3Io2URhReV2dcgnCyoW5HqeWs+tFH3Wlgl0g6+RiE0DY9+KnUDJuUQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please add proper lock in smu_set_soft_freq_range() then.
You can do necessary modification to existing code paths.
Otherwise without lock protection, you may run into race condition on the new debugfs intrace(amdgpu_debugfs_sclk_set) called by multiple instances.

-----Original Message-----
From: Gui, Jack <Jack.Gui@amd.com> 
Sent: Friday, February 28, 2020 12:35 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary sclk for navi14

[AMD Official Use Only - Internal Distribution Only]

Hi Evan,

No lock is created for smu_set_soft_freq_range() in this code path.
But some other sysfs interfaces calling  smu_set_soft_freq_range() indirectly have created lock in middle function to protect  smu_set_soft_freq_range() as critical resource.
So, if we want to lock the "issue message action" in smu_set_soft_freq_range(), another patch is needed.

BR,
Jack

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, February 28, 2020 11:37 AM
To: Gui, Jack <Jack.Gui@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary sclk for navi14

Please confirm whether smu_set_soft_freq_range() is properly lock protected.

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com>
Sent: Friday, February 28, 2020 10:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary sclk for navi14

add debugfs interface amdgpu_force_sclk
to set arbitrary sclk for navi14

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c    | 44 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  3 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3bb7405..5ee7e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1269,9 +1269,43 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	return 0;
 }
 
+static int amdgpu_debugfs_sclk_set(void *data, u64 val) {
+	int ret = 0;
+	uint32_t max_freq, min_freq;
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(adev->ddev->dev);
+	if (ret < 0)
+		return ret;
+
+	if (is_support_sw_smu(adev)) {
+		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq, true);
+		if (ret || val > max_freq || val < min_freq)
+			return -EINVAL;
+		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val);
+	} else {
+		return 0;
+	}
+
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
 			amdgpu_debugfs_ib_preempt, "%llu\n");
 
+DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
+			amdgpu_debugfs_sclk_set, "%llu\n");
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)  {
 	int r, i;
@@ -1285,6 +1319,15 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return -EIO;
 	}
 
+	adev->smu.debugfs_sclk =
+		debugfs_create_file("amdgpu_force_sclk", 0200,
+				    adev->ddev->primary->debugfs_root, adev,
+				    &fops_sclk_set);
+	if (!(adev->smu.debugfs_sclk)) {
+		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
+		return -EIO;
+	}
+
 	/* Register debugfs entries for amdgpu_ttm */
 	r = amdgpu_ttm_debugfs_init(adev);
 	if (r) {
@@ -1353,6 +1396,7 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev)
 	}
 	amdgpu_ttm_debugfs_fini(adev);
 	debugfs_remove(adev->debugfs_preempt);
+	debugfs_remove(adev->smu.debugfs_sclk);
 }
 
 #else
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 97b6714..36fe19c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -371,6 +371,9 @@ struct smu_context
 	struct amd_pp_display_configuration  *display_config;
 	struct smu_baco_context		smu_baco;
 	void *od_settings;
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry                   *debugfs_sclk;
+#endif
 
 	uint32_t pstate_sclk;
 	uint32_t pstate_mclk;
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
