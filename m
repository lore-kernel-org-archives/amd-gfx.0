Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A1AC3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 04:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8908C246A1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 04:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zour4k4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8908C246A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F476ED8E;
	Fri, 28 Feb 2020 04:35:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3336ED8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 04:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyJLzRZ3ReUYRVvwErsysii67KQey0j9XodxSNZgyVYOxFgsa93d030UT9kEY2mAA78Mxu/TuLCRuL1rTZ3WULkIZFia7PSPfMAefG6XmNczQGfPtkcP/kSTWI2RqKfecoDFm5ji1G0494OKESjJhObzNXAUnChovZpM21jXk17RD62JuKUHxfQdHrmISLQHDnSktgS3Ct13ek3Oj336MzvClUn2k4wCSDgmymX0YVFTw8SSaSG8K9txQC+J3AbwsnaYFrS6inuXqLeVUjjc9VOSjj0Ut5OZsHvpzDt9KBFQ1QaB9Mzj/yP+jalfV8jLWoAEyZQAmDIjRnu6tnHN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4oSG/tjyDgfX1JRSH9LceNHqDvbzpzmOvG5VGO9Itw=;
 b=GxLvJ8mKjXmGSPFBgvx2Jb5zZZZfKv72aBX80v/ujcYQAYgHrTDuS5dm26XPT1E1zYB1PUbQgrJCSuXht0DDBpFgduRbPs5l1zSi/wLAjnHqAarZ/A7aOTAKB3BzcpKsYMWFlGvcTkQhGZNVWvrhYrtPK0Y4eFbWKagg/I/+HkAd5fYDVwTW3G5/+7VFy1UCaukJMRukOULQLNBNuukLtrvCfWQjnNIhL4+4wvS9CgnE7BfzRoKqswzScAxESAo7X+opVZtdXAAN92gW2Qimw5huV7A96OFkQxfne/Ssma7kCABmtlwgp9t0xMJbK46h9FW2hDxuC1jobZmfv8hoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4oSG/tjyDgfX1JRSH9LceNHqDvbzpzmOvG5VGO9Itw=;
 b=Zour4k4G5CQi9tvrLKFVP1jBW5kgptJ/ntGIDO+pvX2libGAFw6FPXANxj2tX3QrQc9YTiG+Qju4J8nbfcWvMWuLpG2FgCZMFIHRVPe5JQrj7meX6nysIrqg1svrBku8+a/36m/CYFiKMGKmDLpszHSadRsR2rqqJRDthVy+otU=
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Fri, 28 Feb 2020 04:35:16 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::ad85:c1fc:c082:deb6]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::ad85:c1fc:c082:deb6%6]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 04:35:16 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary
 sclk for navi14
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary
 sclk for navi14
Thread-Index: AQHV7eAVRszkXqd0Dkm93kJR8he0Kagv9PEAgAAMpvA=
Date: Fri, 28 Feb 2020 04:35:16 +0000
Message-ID: <DM5PR12MB2583591246E12F5ED3C3C19E8BE80@DM5PR12MB2583.namprd12.prod.outlook.com>
References: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>
 <1582857441-32135-2-git-send-email-Jack.Gui@amd.com>
 <MN2PR12MB3344E5B3AA5E9D6CB9F7795FE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344E5B3AA5E9D6CB9F7795FE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-28T04:35:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d3213b86-40e5-4597-8eb3-0000ae1e7d6b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Gui@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35626686-41ae-4c76-d20b-08d7bc079c26
x-ms-traffictypediagnostic: DM5PR12MB1596:|DM5PR12MB1596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB15966DCDE39C6885A1C5EC268BE80@DM5PR12MB1596.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(66946007)(5660300002)(86362001)(66446008)(33656002)(64756008)(66556008)(54906003)(52536014)(110136005)(2906002)(66476007)(6506007)(7696005)(76116006)(71200400001)(8936002)(55016002)(186003)(316002)(8676002)(26005)(81156014)(9686003)(4326008)(478600001)(53546011)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1596;
 H:DM5PR12MB2583.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJ2RQ6FAbsE55KsbG8q7GfclFhcIShbB7yW68w2jzvhDX8DsqXBzTox/xTP+mH76d5ux8TGHhI4fxIdSefhFvrHYzwqQj7NqQJeUInTzyShTZipzmx1R0kEn91iMTfARqRYGyPTauInMTtRQuRmyQ8gayNJykmUyRkxT5sBBXON4t+V8EhK9l/sxoyuT74hJr8KlDi2/vy7tZ/oG3B/Lx9hlwYaSvlmn30kYo4LkptElSIYVQjL5Sq8vXACvIRyKxSQhO4I3V6PiL7HuvJEvSjR+wShvRbPmM+6Y6C8SddWjE6GneWtl5b7Eh9XpdS4rXjd/ViMnbaFi7LVUIUXcrf/f/qnbIRWHRLOSeNLbyQ/6AfyevC2jJPxzZPyMvNhQ5Xs+COg7dXGZ8m768H5mHFPKFy+h7QM6Z8OvRyO81zC6EjywguYgsGhoeSHjL/cz
x-ms-exchange-antispam-messagedata: Wmvk48j39G6bThACvBiNHbQCl+nZKz15oK/VRaEBFw99GSz4A3rtWdwd3qW1yz9YKp26nZZY39qyBqiAJ6Eq9G3//o/KeosCzVj7AblRhlycZqJaG2BEFkHrG1LHKMQSDVb6yVR0jEXU//hiYD9Fpw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35626686-41ae-4c76-d20b-08d7bc079c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 04:35:16.5318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMBPiVUvoV4qEKhsAb2iH3YTC9PpRFxE/gHjemRDZVWYZWy4GcAfJ6su05v6W0FC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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

[AMD Official Use Only - Internal Distribution Only]

Hi Evan,

No lock is created for smu_set_soft_freq_range() in this code path.
But some other sysfs interfaces calling  smu_set_soft_freq_range() indirectly
have created lock in middle function to protect  smu_set_soft_freq_range() as critical resource.
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
