Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60169C35254
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 03:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0289B20674
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 03:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B/avqzGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0289B20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795F16F9AB;
	Thu,  6 Feb 2020 03:19:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C4D6F9AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 03:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3qNP+feH1cFP/0P/B7ln7ckhaSuvY13AgPgAeTWlZThhG1b1slsVjaiGkrVAGLvvmvkhgFov7/0MEyXIHXarTCLSB0vOsOCt2WDmh8cNLgMQt/50TLgNVjeBOChKBS3AdegMO5oBhdst40N/yJQyUQo2fMFVxsREDzh7bd+q2vDpUk+n4bn6mL73Fbw6kbI6PzIRz38pLAONs2DFtKKg3c7yJMVtJ5WQSM1IXuF+zhETMgGCQ2z/y+mXRsugmNH+Eo/HGXIOpUTC5ahEeemqD1yXmGdhRbNUveNQEiSGBTcoQiE2aoMhvpapfJ9szCsMau4diXlClqx3budIAVCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4dXLmmhefyOvAUHgnyokj+pGFZklPaV3F+FmlaNZ9I=;
 b=a7c7ipB5z/k4M6UcrQcGueatlaFWM5bxqbNaknFB2fq5SkwJzrCAQdpH5TH4fJpvZPfNb9vNQOiAVkb13Ur5FQEVGyeIg3lPUsltg54s+Ttx5oxsHmCWCCDCJKhnR9GKNSA5xADFlLY1nUDJ2RhE0myQnSd9K52U5yAcEUX0CWKcH6dvUEf2vwC0vklSM6nUcFOoZYle+BIpDq3+1LOj/o0UZDDnGe18Zjfoo5tTXK8SEFdrR3K0+5kqsyFIEjaPk/bKaWIuIkrSxJpa5mTJwm+ZCWMdGUSc2YCHVgIjkdeirqFEUIOWEvrEZjR3/GWcat5jhUemfh7XMsWWr+PRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4dXLmmhefyOvAUHgnyokj+pGFZklPaV3F+FmlaNZ9I=;
 b=B/avqzGb2RwUVu/2NHQvZ/8f/j8mzXdcg10zSjPvSHRHUXtb9Xe7M2SAO91UNbjyYi5CGbqlC90Fj0FjvPi7YxyQRQHLJ8RVdj8iv+HG4VFPP4L3JzmVdcBuUgDYrPEULfPuephETwLhdHoZe6usXVwW800Sj3d9mzfI9wpBiQI=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3405.namprd12.prod.outlook.com (20.178.242.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 03:19:33 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 03:19:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov Don't send msg when smu suspend
Thread-Topic: [PATCH] drm/amdgpu/sriov Don't send msg when smu suspend
Thread-Index: AQHV3AU7mqMd1ZkEEUud3o458x6B3qgNgEJg
Date: Thu, 6 Feb 2020 03:19:33 +0000
Message-ID: <MN2PR12MB334423801FCC363376E246BBE41D0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1580894294-3573-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1580894294-3573-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [153.118.50.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60a63989-b47f-4c3a-e35e-08d7aab3632b
x-ms-traffictypediagnostic: MN2PR12MB3405:|MN2PR12MB3405:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3405A1CC6089F3B9DF19282BE41D0@MN2PR12MB3405.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(52536014)(55016002)(64756008)(66476007)(9686003)(76116006)(66946007)(4326008)(66556008)(71200400001)(66446008)(33656002)(316002)(110136005)(5660300002)(81166006)(45080400002)(2906002)(966005)(478600001)(86362001)(53546011)(26005)(186003)(8676002)(7696005)(15650500001)(6506007)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3405;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ei9uxXmqK4bRyI/gW1bj0KC1mOfg5cI3bNOgjlbMP9MsrHoXuFEQHxWwrpYXQQs5hD5fBlAY3gEerRsd/ddTXLRNPCvBHQMAYYG9feakjR9v7rwYR8jmWR4sr0tbt4R7iY2JaJXixr/4KeXOQW+3J9gWXn56j+KqeU2nHLOkRMWzT9tK5uyOvVHaJsiJ4xnPNQ8+qX0kU/UpUBhIFbGsfcmV2Vcb3Xi7NxD9VbSP487/k5i7xDztq32zx34VQNKFJbLbsf+mcfpQHWGIoAnEfPtRVmvnS3lzvwSeRIAfae+Gq8GfF/jFckK9IlMiBIurUaAOF3RlD1ZlIq3tX3TXT8aIrN6yYMbMTcNZSYNIS6k7QVTGCLo1iIRGieonf6dC5PvP8HANKoyVbuxvFzzWpPcGkj4fSwmpkT3ogoa0pYaUK/J+s95yE3Sjmx0DZV0ndztFGylbEGEyttFJvM2hp0ZxjQnK2dAk3NIZYvwF+5LEXAN+XusWQeAx4NofMj9gjjvbhvQ/fqYse/EkEZFyBg==
x-ms-exchange-antispam-messagedata: 8Ar0kg/m7QjgiDZfOyHpl+5mjBzvUM178170n45K63KhTpQ1EzxA9qWdlCqNaWPn51XtfI8kOYnTdVB5XSazChHIvkPG/ZSmo6ic5rAm3Fwbo5ZqUMcJdONv+6UL2JxBaEiTs16E6GWECgFXSiyAmQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a63989-b47f-4c3a-e35e-08d7aab3632b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 03:19:33.4303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+gLyv/9kaGKal5Q+DzzpWWbx4ocjqPMpfEEHOLodSPMm78k4WsfbSTtW+oKxS0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3405
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Zhang
Sent: Wednesday, February 5, 2020 5:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov Don't send msg when smu suspend

For sriov and pp_onevf_mode, do not send message to set smu
status, becasue smu doesn't support these messages under VF.

Besides, it should skip smu_suspend when pp_onevf_mode is disabled.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++-------
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 21 +++++++++++++--------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4ff7ce3..2d1f8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2353,15 +2353,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
-			r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
-			if (r) {
-				DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
-					  adev->mp1_state, r);
-				return r;
+		if(!amdgpu_sriov_vf(adev)){
+			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
+				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
+				if (r) {
+					DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
+							adev->mp1_state, r);
+					return r;
+				}
 			}
 		}
-
 		adev->ip_blocks[i].status.hw = false;
 	}
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 99ad4dd..a6d7b5f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1461,21 +1461,26 @@ static int smu_suspend(void *handle)
 	struct smu_context *smu = &adev->smu;
 	bool baco_feature_is_enabled = false;
 
+	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
 	if(!smu->is_apu)
 		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
 
-	ret = smu_system_features_control(smu, false);
-	if (ret)
-		return ret;
-
-	if (baco_feature_is_enabled) {
-		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
-		if (ret) {
-			pr_warn("set BACO feature enabled failed, return %d\n", ret);
+	if(!amdgpu_sriov_vf(adev)) {
+		ret = smu_system_features_control(smu, false);
+		if (ret)
 			return ret;
+
+		if (baco_feature_is_enabled) {
+			ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
+			if (ret) {
+				pr_warn("set BACO feature enabled failed, return %d\n", ret);
+				return ret;
+			}
 		}
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cd2316a5aaf5c4a34251d08d7aa1c5a73%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637164911103084738&amp;sdata=l8oqMsQDf0t%2FUi%2B8yR57BrKU71IZJaZl1T83%2F9%2BRm4I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
