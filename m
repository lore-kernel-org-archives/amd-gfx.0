Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B09C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 11:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC88020721
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 11:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IITXVuMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC88020721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1E26E92B;
	Thu, 21 May 2020 11:19:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93046E92B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 11:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTtpBesPjXRcP5z7VBw4KA5mhXYXzZo19qu0U4iE+oprNeHOr6/bhbXlH+SweJAQWQH+NRWsk3od/b0Otvfq9rUzF+gB+YGdex6wINuCdcbBfjSZveznlhAfbPVlOtLZW+pB/KPUGKGepRGSuxhsaPA+FQGqZNg3OBXjTEKe9GFtGODzUlrkhCrAX8fHj94JBfETxvsJ86bqggPEVJXyra/iY8jGSR9l04uiuQ/T+5YckuTtwgTdGD+LRUk5Pb+2xUmKXN7xDMPZatyS0EEFVmyZLf1vDxRjWqQ6/RuIa8RUWlYiTLWX8kqAsavLTb6uxmSpYYR9suHfDy8/Bx3hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90+8pyd9VpEqY70SnC2jN670yx6nquPUzodTsfwj8Yk=;
 b=eO6nyVFTGP5CAKz4cwIARo7kpfI2GwqzrnpP2aFhxhO51CmJlNNTYp8HTlP/Phb86zIN+4+SwM08RNfQYvNMRl2BEUwhfZCv+cmlGe9HI1FK/eGrbmm+P52Rew3H5XyZtq5plodStqWloT7W5j/Q1vaRKuqTdeqs/FmSpkOmruHN6SzjuYciqb6ayPKawsV7kDjPAMR3OIInQUNRxeNwDc+T0GKdgZoYf/s+1MBHm2G7lRZsru7L2l8qah0ggMP9oXuElYHIClasNjlIHVx8Kq8gHkWYHl8Ey6kd5cUlwGDP8jS0wKZ/DveeRfYl2u3zaVxrRgGUCn5sQtdJrDUbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90+8pyd9VpEqY70SnC2jN670yx6nquPUzodTsfwj8Yk=;
 b=IITXVuMXFeIKrqZ+ATW729ZCKJ6s6iCtJB2o0uplyuCSq6+MjFPcgYe3rg9RueEenwZRcuQY6x4s4uwufplHSAmyfTQO+b4cIB669vqi8ZSxmEKZYXHQr2wwdfiDV/ps/dxa+MWlfv06+VQV8WU6a0hA8JW+Zcja6CmDgzGZje8=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Thu, 21 May 2020 11:19:41 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 11:19:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change memory training to common function
Thread-Topic: [PATCH] drm/amdgpu: change memory training to common function
Thread-Index: AQHWL2CJfELMIMuJHEGP5j4dAvG+Y6iyZJRQ
Date: Thu, 21 May 2020 11:19:41 +0000
Message-ID: <DM6PR12MB40753210568B83044BBE2850FCB70@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200521110946.2488274-1-likun.gao@amd.com>
In-Reply-To: <20200521110946.2488274-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-21T11:19:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d6364ebd-0f15-4b06-b7bb-0000e4b7399a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-21T11:19:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a28588b4-434f-4434-ab15-000016a30d87
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a9ff8a6-d3ee-4802-840e-08d7fd78db51
x-ms-traffictypediagnostic: DM6PR12MB3931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3931453D0C3BEF238DC01B43FCB70@DM6PR12MB3931.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mPQ962WHIuljuodDt+owksGo4jda7+Sd3iGYIl6WcPjvWZg1DjZ/nRDsdTapa+0QEnb8HLzb22xGgh/SFLSzo5WVHIx2V9QK04whi0wFaoShKABwnz7mprp7Xw82PbwfxboyYG8NaSh2BmoyjJblZ7l1YDWVVy+bsfC8P7Avmzwn4EY3RwEGB/r1/UhmpafX7JXE5eQ0Ba68e6reJ0/BZW8PcB7EQ2c0GHqw4VdmGm4n4uQj7t+yRpLclC4Jz0JtLpgToVP6Kjjo95O3QhN7U4C7m4ropB1fPdI2l52Dvivz+5GwtWiqql0eyA7T0/9Tf0b+CGeuDxYzsw0fZDOPflm6Cy6t5VUWw7OlBvp22zDoeOk3CfDyCmc3pRE6jCzJL9cJyT+kyKb7Hf/mrescIa0jxZsH/U4hsDss039lFz/jeGgM6gbENbuKaNlauqungMFVWchTMzo561UBA39Dsw1oLBLtdy/MnfrF9glncY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(316002)(64756008)(86362001)(110136005)(52536014)(66556008)(26005)(76116006)(186003)(6506007)(7696005)(66446008)(66946007)(53546011)(66476007)(71200400001)(478600001)(33656002)(966005)(9686003)(45080400002)(8936002)(5660300002)(55016002)(8676002)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: r2Eo/99EbouAi1Yfad8fp0eIsY/57LWCxOHl0pRpmjH+ydJW8htG/w2HOBugVv+Kbaqu6CbKu4S10ahExOOXeYBmIj2/WKWc1nHRmbOIbM17gsz032zEVpSYqfadzLHPxF5Yt+rC5q8bd35c5EkeOoVik7LLjbfJGe9GE0g2iJ7Fvjs+/b0RQxRx1dFhf8LrYU+DsxTaeRWrl/qQm9Wo9tqhYUW28jKzDE8oL+PKM9jkxAXKve7gQdmLm7nOnldpAKGjPKzYZMXlz+6SUI0xU/1xx04oP0LfFfVMSjFUUC7/21frfB9VnqpJoFDxje2rQ2aCAX21hYXwekXMdNUGfBi6EIarxtk/g7dEupA8FxpSFN74DX5u5yj5/gHHUScHFR1pvDpnvsNZZxGN7/kvx8WjmvIEu3D0iMzrMD1aMfw61VjWYlaNcqtJQY4l7VHzAquu24EKrUj9mkx3+DGj5VWgi/nIy2edqNxGEwBepgTxTeZL6g2ORLMJdhdC9BvE
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9ff8a6-d3ee-4802-840e-08d7fd78db51
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 11:19:41.1589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwlLOjqiY86A5X+UXvBVKVD6UiJenfcnHGjEa7Jtb4qkj6sHDDDCrBdYWB0f/TLm2eZF0H7ye0o/Vkr84Yst5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3931
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun Gao
Sent: Thursday, May 21, 2020 19:10
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: change memory training to common function

From: Likun Gao <Likun.Gao@amd.com>

Change memory training init and finit a common function, as it only have software behavior do not relay on the IP version of PSP.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I0a81d3c3cd1813480781876101e9bfb6787bce3b
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 42 +++++++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 ----  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 40 -----------------------
 3 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7301fdcfb8bc..679d96719410 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -115,6 +115,44 @@ static int psp_early_init(void *handle)
 	return 0;
 }
 
+static void psp_memory_training_fini(struct psp_context *psp) {
+	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
+
+	ctx->init = PSP_MEM_TRAIN_NOT_SUPPORT;
+	kfree(ctx->sys_cache);
+	ctx->sys_cache = NULL;
+}
+
+static int psp_memory_training_init(struct psp_context *psp) {
+	int ret;
+	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
+
+	if (ctx->init != PSP_MEM_TRAIN_RESERVE_SUCCESS) {
+		DRM_DEBUG("memory training is not supported!\n");
+		return 0;
+	}
+
+	ctx->sys_cache = kzalloc(ctx->train_data_size, GFP_KERNEL);
+	if (ctx->sys_cache == NULL) {
+		DRM_ERROR("alloc mem_train_ctx.sys_cache failed!\n");
+		ret = -ENOMEM;
+		goto Err_out;
+	}
+
+	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
+		  ctx->train_data_size,
+		  ctx->p2c_train_data_offset,
+		  ctx->c2p_train_data_offset);
+	ctx->init = PSP_MEM_TRAIN_INIT_SUCCESS;
+	return 0;
+
+Err_out:
+	psp_memory_training_fini(psp);
+	return ret;
+}
+
 static int psp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle; @@ -127,7 +165,7 @@ static int psp_sw_init(void *handle)
 		return ret;
 	}
 
-	ret = psp_mem_training_init(psp);
+	ret = psp_memory_training_init(psp);
 	if (ret) {
 		DRM_ERROR("Failed to initialize memory training!\n");
 		return ret;
@@ -152,7 +190,7 @@ static int psp_sw_fini(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	psp_mem_training_fini(&adev->psp);
+	psp_memory_training_fini(&adev->psp);
 	release_firmware(adev->psp.sos_fw);
 	adev->psp.sos_fw = NULL;
 	release_firmware(adev->psp.asd_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2a56ad996d83..e19b98d48c98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -95,8 +95,6 @@ struct psp_funcs
 			    enum psp_ring_type ring_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
-	int (*mem_training_init)(struct psp_context *psp);
-	void (*mem_training_fini)(struct psp_context *psp);
 	int (*mem_training)(struct psp_context *psp, uint32_t ops);
 	uint32_t (*ring_get_wptr)(struct psp_context *psp);
 	void (*ring_set_wptr)(struct psp_context *psp, uint32_t value); @@ -306,10 +304,6 @@ struct amdgpu_psp_funcs {
 		((psp)->funcs->smu_reload_quirk ? (psp)->funcs->smu_reload_quirk((psp)) : false)  #define psp_mode1_reset(psp) \
 		((psp)->funcs->mode1_reset ? (psp)->funcs->mode1_reset((psp)) : false) -#define psp_mem_training_init(psp) \
-	((psp)->funcs->mem_training_init ? (psp)->funcs->mem_training_init((psp)) : 0)
-#define psp_mem_training_fini(psp) \
-	((psp)->funcs->mem_training_fini ? (psp)->funcs->mem_training_fini((psp)) : 0)
 #define psp_mem_training(psp, ops) \
 	((psp)->funcs->mem_training ? (psp)->funcs->mem_training((psp), (ops)) : 0)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1de89cc3c355..9ec6e3819dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -555,44 +555,6 @@ static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
 	return ret;
 }
 
-static void psp_v11_0_memory_training_fini(struct psp_context *psp) -{
-	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
-
-	ctx->init = PSP_MEM_TRAIN_NOT_SUPPORT;
-	kfree(ctx->sys_cache);
-	ctx->sys_cache = NULL;
-}
-
-static int psp_v11_0_memory_training_init(struct psp_context *psp) -{
-	int ret;
-	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
-
-	if (ctx->init != PSP_MEM_TRAIN_RESERVE_SUCCESS) {
-		DRM_DEBUG("memory training is not supported!\n");
-		return 0;
-	}
-
-	ctx->sys_cache = kzalloc(ctx->train_data_size, GFP_KERNEL);
-	if (ctx->sys_cache == NULL) {
-		DRM_ERROR("alloc mem_train_ctx.sys_cache failed!\n");
-		ret = -ENOMEM;
-		goto Err_out;
-	}
-
-	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
-		  ctx->train_data_size,
-		  ctx->p2c_train_data_offset,
-		  ctx->c2p_train_data_offset);
-	ctx->init = PSP_MEM_TRAIN_INIT_SUCCESS;
-	return 0;
-
-Err_out:
-	psp_v11_0_memory_training_fini(psp);
-	return ret;
-}
-
 /*
  * save and restore proces
  */
@@ -820,8 +782,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.mode1_reset = psp_v11_0_mode1_reset,
-	.mem_training_init = psp_v11_0_memory_training_init,
-	.mem_training_fini = psp_v11_0_memory_training_fini,
 	.mem_training = psp_v11_0_memory_training,
 	.ring_get_wptr = psp_v11_0_ring_get_wptr,
 	.ring_set_wptr = psp_v11_0_ring_set_wptr,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C5274a40ffb69486a53f108d7fd77aa8a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256562720385907&amp;sdata=l7gu73UTWF59P5TXRxCxscyVv%2FGiEO93VX%2FfQAiCa6U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
