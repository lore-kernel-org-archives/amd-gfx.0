Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1845C3F2D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 03:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD04246A1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 03:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fz6Yt0Eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD04246A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2138C6E11A;
	Fri, 28 Feb 2020 03:37:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0DD6E11A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 03:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH5g09LHyTPkDELujILf6/7Ahhvc2PG3f58f5Ov8W4/aI7j3aE5Mbij+ewINOLUm5omwqn1xzKPw2Ufctyy1dr7dBRkjsvD4lqa/9n/J8Rsw0g/TC2e1h1X+zV0od0+JUU5AWZh66KpqRDw/Zj+6qybcF74I1TdMpPNGSmwj2mtD4Ng2C18PxkIMKH+9teybnrjDgWBMXP48pcY82niDQSGxT4NNCl5r+Tou+5qaDsovie9EHjpRKX9tpCyCshs4U7Q5ofWsrrvGztY1Jz5RQRwhyjLp6M7fAmCHm2aicOr6eWTO0ZnmoGxkJZIS+6Edi/cBu5bFbUKJB27zf/bWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLMnCSQPGTaY4CYwaOuCO0avv4unXsZ2LAHq3Ox28rE=;
 b=ANlf3Ml09BUblOf7maO21tAzMtRJQEyyGV2Z7ycE6EbAi0DXLdFrOafeRNQRgqDGru3lhB1cPrbSDW0yj1LmgMsKgwKGHyyqHQgUUV4/W/W0evKhKHR2h25ZbqvxWd12y7xXLHEObubErn1fRkrpqdgWn9K2JY7GjhSDswhrdxBCEN6C8n5jwB1mjcDXtZu7JLpatl4fSJGXtLQhdbpwrWRzUzzS7L/u2tOmKfmHwLfuTC89qjDFV1stAqJqaTQY9eNw+h+FE1+5Kckx40W2irUH4ZaPETpfWoPKLxpnM/yYlpG0xX8zDAAKdmPRI2KKnvNYfUmq4DQuFC+U/37aEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLMnCSQPGTaY4CYwaOuCO0avv4unXsZ2LAHq3Ox28rE=;
 b=fz6Yt0Eq6elSXZ0oBB9yCnpNt7TYdirC44GXARczKr1FnRLARFTPAj2DMtORNZzYf48p3b9GomBKuoHadZo2N6QsI4Fj9hGZPdv+h6ZtU8SEneocnM9jOsJ6ERSvJ4KdWywjre/sSKHhy5WQdBJFDHnF6i1Dpbb+99EqzgV4BYA=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 28 Feb
 2020 03:37:06 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 03:37:06 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary
 sclk for navi14
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary
 sclk for navi14
Thread-Index: AQHV7eAV2rumPmr8AEmZb8iCnBMpbqgv9LXQ
Date: Fri, 28 Feb 2020 03:37:06 +0000
Message-ID: <MN2PR12MB3344E5B3AA5E9D6CB9F7795FE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>
 <1582857441-32135-2-git-send-email-Jack.Gui@amd.com>
In-Reply-To: <1582857441-32135-2-git-send-email-Jack.Gui@amd.com>
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
x-ms-office365-filtering-correlation-id: d8bf1b5f-ce64-4e20-7533-08d7bbff7bbd
x-ms-traffictypediagnostic: MN2PR12MB2989:|MN2PR12MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2989E939800E2CD4B3321F33E4E80@MN2PR12MB2989.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
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
x-microsoft-antispam-message-info: LjDVz6EiUVyVvtZK6P12MRfGRqe0zJnKraG+KmA9TIdqiTFQmoDVsfSShvJwcfUGluhx6gJoxvAZzXlluxHR97lh2aoPW+lAzT77oXSQW/AAFyztEd4XX135bfxupnbeF8gsJtEvD14IyJnnfghHVfGxwP1bdXccdp1jUH26py+x7yg5Ve0U3xWpVcrGKPjNYkkm/lhmKVl5Ai0lSTiRzkzzyC6IXui257Wm3xvQByImV07c+G0nf+4sn5BuDNoJakA8IECwQZRzXo0/3F8SQkvAsUWSjjwLIsziZeZWigbi2Vx1IR+ddkGBOl3CBbC1jfTSfDGUjZu6lta9HWn1E+NWSxtoWqMV/D8EJP2lmbKsHyIygkOnV97Fey6PUr6gvQlcLiXFhHExOKrNdNT2mjKs1b6ropoRoAuB6uYL2GQ8DsuJmnyeioj+upicR6Va
x-ms-exchange-antispam-messagedata: 60K2kn55KaAq419o8XIGuuPJyXVcmVWddRNh4G519pZmnlcIDbb3OAtRdtMFHFcpK1TzMqBDJzxBi+Jh5YNL6AMqeBc8Nha9/yrPwLGnD2+onnnWmCT1YB9OBgFZi8BvFoH2ACcY0Gc9ZDPgPFTeqA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bf1b5f-ce64-4e20-7533-08d7bbff7bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 03:37:06.1603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBm0Jf/SR+tHNrpDKqIKNzjOKYIPjU/S+srmiER8eAYiG1sPZsUVJvrIWeCUsssB
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
 
+static int amdgpu_debugfs_sclk_set(void *data, u64 val)
+{
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
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
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
