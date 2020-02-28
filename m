Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA90C3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E528246A2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MvyXzEZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E528246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA7F6EE77;
	Fri, 28 Feb 2020 09:11:22 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF506EE77
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 09:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AULSj8ZgKKmu1st45hB74IjWaL/Xq4pEqUdWzKtoAqqY0rlA+6AQ1KgiKX6QoafFsROyaKqm+9RZmn+/3gnTH5Vxj0i96pctV8/+HHBD1CwQ7TbROUdt70L8UXCbfU2Bo0Yj3MAj7Ekx4q0dAvUjfsAOQdAAoXbL1Q/icIhIE4XJBPWidKN+HxVIE0bQE+3m3ibGVT3M2VMfv1dfegKGnm/Ga3BtwWmZ/velm2YR/TvkuWheTydV20uF7j77b3hD0b9bspMca9YaNaaaoONeXETeho9BBPdYc8wX0eEofvmIHttZg9W4stHB/Io5i6/PPpjhfhjwLtYsyv/4dVGKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrfqdcsTWMOJwf+GwsQiSSE7DyG6RHndc1eTsj4N6ac=;
 b=EXGvAf63nRrGJR7RD3Qhn9eRhEU1aZ9uyh+klpcJeYr0WI0fN2YNlrJQBsseGqoMyHkKObjhXXX9Db8EE4uOS3DY70LuNH9fv2ljl4Cmqew09T98ZD8x9WbQCvyS3w/vjQClreA9LMAE0GGvt+/QpGpAPqvkuQRMKijn4vZ72LXsLkHoD0imIMA0h2mbMNKtsiKPj5ufhLZUn5xL3mqK84DJVqFy+H7CpkLAvnDeT2v4WPPP4vuDBYQU0VJ6npiPtnrQAwz3p4+n3PP6q5Qt5xDYhhQ4TjfYDF7doN3ZG+FB070AQ/Bit+3MXUaFB9hwO0/bWYXwa3YGu32zRdn9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrfqdcsTWMOJwf+GwsQiSSE7DyG6RHndc1eTsj4N6ac=;
 b=MvyXzEZkGIZlPfxwJzkfD7fU4CjZ5bR0J/eOWlsDSk/2gzOHF4Zr8pScQPcJ2jG2K6YAi+pxHqh8SE4f6FEb3CZqwB7m1IpifbdiaLyv1Ictxb6b9Jerbp2edGdPWkZ4aU0OGykcU8fvwomspmOcdUVAoykxCx2fZzy/Hd5gYe0=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3664.namprd12.prod.outlook.com (2603:10b6:208:159::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 28 Feb
 2020 09:11:19 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 09:11:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary
 sclk for navi14 (v2)
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary
 sclk for navi14 (v2)
Thread-Index: AQHV7hWQR6IJkR3EcUKtbg9wj/HF66gwUc8w
Date: Fri, 28 Feb 2020 09:11:18 +0000
Message-ID: <MN2PR12MB33449ECD9DDF03D51BFA8623E4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1582880410-12400-1-git-send-email-Jack.Gui@amd.com>
 <1582880410-12400-2-git-send-email-Jack.Gui@amd.com>
In-Reply-To: <1582880410-12400-2-git-send-email-Jack.Gui@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3ccb2e51-e882-4a2b-928e-0000de7a8d89;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-28T09:10:59Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12f1979a-0af9-4300-b35b-08d7bc2e2c7c
x-ms-traffictypediagnostic: MN2PR12MB3664:|MN2PR12MB3664:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3664D06CCE54D5DEFF37EFA9E4E80@MN2PR12MB3664.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(66446008)(64756008)(66476007)(66556008)(81156014)(55016002)(7696005)(52536014)(9686003)(8936002)(8676002)(66946007)(81166006)(71200400001)(54906003)(4326008)(478600001)(76116006)(86362001)(316002)(53546011)(186003)(2906002)(26005)(33656002)(5660300002)(6506007)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3664;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j90IZORzzpYyQ71ZvQY92ipaN3NNPThmoVcsK7JJaSimD16NaphhjBfCHqQkD3tIRfvu4xhDOTLxpnqE38XkpUm2OHCWaWfLCWSsD+w6ZGncyeAiz2LeZwN46N+7fqrC78HnxLEJGldXM/3a2h666gWY79Zot7wgU/LO55+FDDaK5ih7kprmD6wGbHJPkruiYjGwvvtxQ+Sruo1mUmWk2BnuGWaAcOLxlddSQWelT3zcjfAN2J9P/9+NK+KxYElhmrfoZe7o3WPUSL+cTBkynSNUWqbaVwajSjVKAGGW6BodtKVveAY1nTul8CT24WMXK2t3PdPtivsjlaolpoyNEIv60j0G+cYeshGYs+sYQU7c8X4ujsIWSOOjkAha46RKhB0JD8GFTtQLI7/u6oVIA8oBrbw1IbriP/Kfwm7UNQf0Dsrl0+0CcisN392cSvgs
x-ms-exchange-antispam-messagedata: RWABhv77fp6vGsVhZhfsops8RBeGnEPtb14oKVOZLbofD3TUDiJBnrWakHwNdpSEFbnLsR4yA+p48greESDPaLIcopynqE/gh3D51Z8+J90lpJAt88n+6QtbYbvwC3CU/zK4SXPfliw78qY3rM3vUw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1979a-0af9-4300-b35b-08d7bc2e2c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 09:11:19.6582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPMMEWbaPQoT6Jn0eZVEWkpXyJspK8stJMR9EVYDzbewx0al4NVD1r3P7dN/B5Hx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3664
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

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Friday, February 28, 2020 5:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary sclk for navi14 (v2)

add debugfs interface amdgpu_force_sclk
to set arbitrary sclk for navi14

v2: Add lock

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c    | 43 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  3 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index abc1482..831f70d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1257,9 +1257,43 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
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
+		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val, true);
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
@@ -1273,6 +1307,15 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index c8e72c7..657a6f1 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -372,6 +372,9 @@ struct smu_context
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
