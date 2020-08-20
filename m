Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C63C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 07:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF9A207DE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 07:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QqG2zKBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF9A207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6F86E90B;
	Thu, 20 Aug 2020 07:37:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114ED6E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 07:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLM9/udX62sU7dQBwLrTI/G/4gpkul+Z9ytkl6rh+fDZjd/Tg1oC3pRG4XkAvqsF7DppV9xxm53hs5HX6RnWmKBz7+X4Xp0N9eifdEjoTnoI+fKCZ+XAZdxHFyegsvFFcO5IyXN4H4Qz5BvZ+leXvOqz+L7atbdEulF19dVPPMoxSMkdZxAu8McttqmAtPBq7Krq2rtlHFGb4yLMY8Ms9EKfsKCkvoJYAHBjRoJIpV04Nbt0JC5J1kohRu0chr2AabJhfF/+cbOKEhWr9jjI4gca0Tu4FDigfPrNzuPrvS9uWSxiDOtuKZooItTMU/ljpNOBXlDy/4jUD9EzapWKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ2u3P/xua73jvnJFdr2fyDHOncLdaj42DyFpzrzTTs=;
 b=Vzy0NU7vh8i/9O7bs3usrGGXdMnzV10C14uczJ7CpgY5M1LpxGtS4f9GzZuaMiQzTGeEzzsqa5MRnGZ41uNnOx/Hd22JbDG1wSrPI63Zy3Y+FqEDOOy+jZw36Hz7svMks/R78tI9XeaOysW0KEKH3ribvBInSJrlL49qklujHsuEMn/gTikzz7yuLh9qMZgJ0wdy5XGvQM7ZIrSN138wZse2KGpDWu/Gq6nwvA0zcfNiS8JRGk3hwZxfW7JVg4D0o5wL9/DeUjeYGEJEI0avqUyewomz1q3w5BHM0tYLiB63RY9fncqGiFSH51l2G8Wfu/Wm8ymKlemWOHZkc1FITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ2u3P/xua73jvnJFdr2fyDHOncLdaj42DyFpzrzTTs=;
 b=QqG2zKBwd75gOJPN24mIondB5nXHTFi72FmqhTNgnpaRbcn5KeDjjZLLLSHw9ixyETKwySNkvDTngTcFfrOn1mEqVbRN+PiLYjeMuW1qD0/ArVlVHl/bz1IKr781TM6Sl5QR/x2HgZmZfmFTydAnOUw9FTOWcZuIGETyYE+GzcE=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Thu, 20 Aug 2020 07:37:35 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:37:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine message print for devices of hive
Thread-Topic: [PATCH] drm/amdgpu: refine message print for devices of hive
Thread-Index: AQHWdpyBFDxch5ggqEK4TE23vr7+HqlAnCSg
Date: Thu, 20 Aug 2020 07:37:35 +0000
Message-ID: <DM6PR12MB407584CB0C0035E08F6669FEFC5A0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200820024908.667-1-Dennis.Li@amd.com>
In-Reply-To: <20200820024908.667-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-20T07:37:23Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=473767c1-6f4e-4d44-836b-000073a2d1ba;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-20T07:37:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7195b00f-ae93-43a5-96af-000068d15978
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-20T07:37:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a8b621ca-7455-431b-aee2-000019f4434e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0503d772-27ba-4497-3568-08d844dbe7ef
x-ms-traffictypediagnostic: DM6PR12MB3964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB396442D3A5F688D4136B38EEFC5A0@DM6PR12MB3964.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FcLY8p8G8ARgtnlihElQKpAsnHZCCtbNcj32q9/iT98WuuEiVWuPVqgK6rem3zoEM7CsSB7SNrQWH7ColeVU2InUnmY0hFCP8HTRaQeVuhaYJwxaKnbbfLq5rV9us3kchzUigRdnzcG3Ex19qxIu8NzTD9v7uLydcDnKBlWOwCyNWECjKSwemQJiWUoCv0KLJOLVJlwzT/Goh8hZIEZrea/Sc5tOfPcCRVGPIzWiyvQiud8qneWj4gjP+0R/G04qY1m4G5TRjXMb6cuSDddZcY5ctbYJ1YaRfu2xxzG0lXKI4KUxJLProddIRTRdBsuDcr8MhrLkaGAgKjdJT6FrgFFOk9eTCdp5I+UeRpoAoEhCkaeOhZw7JTekknD0z5ud
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(71200400001)(8676002)(110136005)(15650500001)(6636002)(86362001)(64756008)(478600001)(66476007)(8936002)(4326008)(66556008)(26005)(7696005)(76116006)(66446008)(66946007)(5660300002)(83380400001)(186003)(6506007)(316002)(53546011)(55016002)(9686003)(2906002)(33656002)(52536014)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: i7mI4Al7ogPE7hSFaBeiIVqdPqqUdTWu1TtuWc6hNWRd1TeLhwizmUQx4KG3BU/NQSJ85Daa+m3kIryyanejLwmf9UL4HLVFs4EVcWq2FWb/H2r6XjVJ2VBtLRq+R+BX6atxnyyMOe6EVyypNmivaOyXOJ2OhyH0lrxadfaomwe51MzR8Q1ILYlrCTQCyII3wBM5DYYim7xxtj0bumzHxRurTH7N+O17zVrOA1dADctWdxWRgMkHGCWPnKDgbeCC8JdiQ5wkN5886M6TjpSSn648e3GcI9X7WhyR6+VrAY7Py04oKnogr+x0XLouwy8CBDwG4/PV3GMZEzgtdXEk1Ij/xR8d7yYUcjF6wvKpZcOLrtDwDlYlAZ5bydbkvyOTMkTFoANJ8SxKb27aoGpLY2uhAVB0TUFT2zWVD7TIxxx4zbJhM44uDr/2vFKpWb878sgct29oSiBIePsPPKanpXQPP3PaNKhzrvejW5hnUDMoJOpgwUBK4BnFQYXqggNUFEJBPvzTCvyjqpItRjvpSsASSMfXVksMh95SX/IcQYmMp4HOSEIeFl4Tchw8UF3PWehb0BqIJbaJkHHMoeWzK/dygwqS5Gk2xvwhppIej/FpnltalbecFGoznVQ4/Zqr1lOhaCh/YWvt5Chf9x+zFg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0503d772-27ba-4497-3568-08d844dbe7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 07:37:35.1430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcqYtA8xvyQTup4OdVYClfNGH+IzhJpbVg7DVbWiw6U7rD+9LBHbjVawPnRmH43fZa4GIivYHFd9RtQEuBMLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Thursday, August 20, 2020 10:49
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: refine message print for devices of hive

Using dev_xxx instead of DRM_xxx/pr_xxx to indicate which device of a hive is the message for.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 81b1d9a1dca0..08548e051cc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3370,7 +3370,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)  {
 	int r;
 
-	DRM_INFO("amdgpu: finishing device.\n");
+	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
@@ -3555,12 +3555,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
 		if (r)
-			DRM_ERROR("amdgpu asic init failed\n");
+			dev_err(adev->dev, "amdgpu asic init failed\n");
 	}
 
 	r = amdgpu_device_ip_resume(adev);
 	if (r) {
-		DRM_ERROR("amdgpu_device_ip_resume failed (%d).\n", r);
+		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		return r;
 	}
 	amdgpu_fence_driver_resume(adev);
@@ -3584,7 +3584,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 				if (r == 0) {
 					r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 					if (r != 0)
-						DRM_ERROR("Failed to pin cursor BO (%d)\n", r);
+						dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
 					amdgpu_crtc->cursor_addr = amdgpu_bo_gpu_offset(aobj);
 					amdgpu_bo_unreserve(aobj);
 				}
@@ -3674,7 +3674,7 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hang =
 				adev->ip_blocks[i].version->funcs->check_soft_reset(adev);
 		if (adev->ip_blocks[i].status.hang) {
-			DRM_INFO("IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
+			dev_info(adev->dev, "IP block:%s is hung!\n", 
+adev->ip_blocks[i].version->funcs->name);
 			asic_hang = true;
 		}
 	}
@@ -3735,7 +3735,7 @@ static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) ||
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
 			if (adev->ip_blocks[i].status.hang) {
-				DRM_INFO("Some block need full reset!\n");
+				dev_info(adev->dev, "Some block need full reset!\n");
 				return true;
 			}
 		}
@@ -3823,7 +3823,7 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	else
 		tmo = msecs_to_jiffies(100);
 
-	DRM_INFO("recover vram bo from shadow start\n");
+	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
 	list_for_each_entry(shadow, &adev->shadow_list, shadow_list) {
 
@@ -3859,11 +3859,11 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	dma_fence_put(fence);
 
 	if (r < 0 || tmo <= 0) {
-		DRM_ERROR("recover vram bo from shadow failed, r is %ld, tmo is %ld\n", r, tmo);
+		dev_err(adev->dev, "recover vram bo from shadow failed, r is %ld, tmo 
+is %ld\n", r, tmo);
 		return -EIO;
 	}
 
-	DRM_INFO("recover vram bo from shadow done\n");
+	dev_info(adev->dev, "recover vram bo from shadow done\n");
 	return 0;
 }
 
@@ -3962,7 +3962,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)  bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)  {
 	if (!amdgpu_device_ip_check_soft_reset(adev)) {
-		DRM_INFO("Timeout, but no hardware hang detected.\n");
+		dev_info(adev->dev, "Timeout, but no hardware hang detected.\n");
 		return false;
 	}
 
@@ -4002,7 +4002,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 	return true;
 
 disabled:
-		DRM_INFO("GPU recovery disabled.\n");
+		dev_info(adev->dev, "GPU recovery disabled.\n");
 		return false;
 }
 
@@ -4041,7 +4041,7 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			r = amdgpu_device_ip_soft_reset(adev);
 			amdgpu_device_ip_post_soft_reset(adev);
 			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
-				DRM_INFO("soft reset failed, will fallback to full reset!\n");
+				dev_info(adev->dev, "soft reset failed, will fallback to full 
+reset!\n");
 				need_full_reset = true;
 			}
 		}
@@ -4077,7 +4077,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 				r = amdgpu_asic_reset(tmp_adev);
 
 			if (r) {
-				DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
+				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm 
+dev, %s",
 					 r, tmp_adev->ddev->unique);
 				break;
 			}
@@ -4111,7 +4111,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		if (need_full_reset) {
 			/* post card */
 			if (amdgpu_atom_asic_init(tmp_adev->mode_info.atom_context))
-				DRM_WARN("asic atom init failed!");
+				dev_warn(tmp_adev->dev, "asic atom init failed!");
 
 			if (!r) {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n"); @@ -4369,7 +4369,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (!amdgpu_device_lock_adev(tmp_adev)) {
-			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
+			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another 
+already in progress",
 				  job ? job->base.id : -1);
 			r = 0;
 			goto skip_recovery;
@@ -4444,7 +4444,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 						 &need_full_reset);
 		/*TODO Should we stop ?*/
 		if (r) {
-			DRM_ERROR("GPU pre asic reset failed with err, %d for drm dev, %s ",
+			dev_err(tmp_adev->dev, "GPU pre asic reset failed with err, %d for 
+drm dev, %s ",
 				  r, tmp_adev->ddev->unique);
 			tmp_adev->asic_reset_res = r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ebea3f655826..d6981425ec51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -743,7 +743,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 failed_kiq_read:
 	if (reg_val_offs)
 		amdgpu_device_wb_free(adev, reg_val_offs);
-	pr_err("failed to read reg:%x\n", reg);
+	dev_err(adev->dev, "failed to read reg:%x\n", reg);
 	return ~0;
 }
 
@@ -796,5 +796,5 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	amdgpu_ring_undo(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
-	pr_err("failed to write reg:%x\n", reg);
+	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index ae720a6dc5a0..d84649b4d51a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -93,7 +93,7 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	amdgpu_ring_undo(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq:
-	pr_err("failed to write reg %x wait reg %x\n", reg0, reg1);
+	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, 
+reg1);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9d3b1245a339..ad9ad622ccce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -390,7 +390,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		spin_unlock(&adev->gfx.kiq.ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
-			DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 86f20426c4af..e1a0ae327cf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -633,7 +633,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		spin_unlock(&adev->gfx.kiq.ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
-			DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
 		}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
