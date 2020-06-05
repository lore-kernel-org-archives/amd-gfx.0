Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86171C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 02:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222402074B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 02:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0hFY2xj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222402074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8AD16E4B5;
	Fri,  5 Jun 2020 02:24:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7806E4B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 02:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcJ3caDwBkP+n3U0mMUH2WAnVkGjcxFw00heKtUhqF8Cgx6yJwmQjp1cxqy8CShmAk0YT7tQlv2AmMAQHBeHWBXGMPu9qP4/TKZt5RLVfHluACe83EROJ0Py59LGE2WYm+9L5FagxsX16sRjsqKFpYARTI/lt61Ii7T2Lae8US0BQEzxvZgUewBtZpT2mXaQzsrZTMMBBrFuN92mljxl/rMNhmTZ2tc9ojeCoeQMHGPNo6I4iPPf8qCz5pqb9Lgup82yyfJSaupXb/s5g8aRmoN6a94gvxVcTeyT4i/p/1bQhzGeStmEuuTT/z7XzbZopIpw59sQMcjMRH3eY5XSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y2Axl9Kp09z1nXIedPbwqezyRT4cqHM8lP/q9Wnk1U=;
 b=IpPOkIL+QPhZ+nXN2DfOOmbzKKhbagrKugeUkNRLde+13YZLWzcxiUvUg1fgiyS4seP9d/R+rCHf5Nz3Fct41owq7Y4PDsv0VviGTrWwon4bx2SYRisrDrUQTCqPmINj+LKMnxRYwmskmhoVEhiaBKN8a4WCb9f3lmO54feEdkYJm+e8U2fGF5I4zYhcGBcLS0d6InkZTq4yyKNyA9eHjt1+dWxzkrrtNIHxKA1SVImzVCdxRQp4SxjpUBsmCtPQdUzOqxetQlnNISsBzamj2R9SCM1dKJl5hHBawg2ys9mhH9OsUAPJVYvWXuzJnsjNtB0+pG1R4YmFUJMTMOVghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y2Axl9Kp09z1nXIedPbwqezyRT4cqHM8lP/q9Wnk1U=;
 b=0hFY2xj0zWLGuWXyXU2QOIHMdaAfPqEFRw8NXuvh1lXpchGha+JKsGtDHBT315wSQ9L7BRQgUBKFW6ouPw5o99uZ9t+JY6G2LyYA5VPeB6JZ1JXdKP6vaduTS/Lg263aXs4UAtPG3fzlzq9GABHMnZIgjlAyJLD+m5yvMKG44q8=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 02:24:06 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 02:24:06 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: support reserve bad page for virt
Thread-Topic: [PATCH V2] drm/amdgpu: support reserve bad page for virt
Thread-Index: AQHWOmy9rZmGlFAqRUu1PCEn7lO0RajJR8bw
Date: Fri, 5 Jun 2020 02:24:05 +0000
Message-ID: <CY4PR12MB1287EED837E483BAACFC187DF1860@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200604123602.14032-1-Stanley.Yang@amd.com>
In-Reply-To: <20200604123602.14032-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-05T02:23:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=59bf89a0-b32a-4b57-ab8e-000026fd0d49;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-05T02:24:03Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8844a3d0-c368-49e8-8941-0000ab4db3fa
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acf46c53-9460-4bab-9032-08d808f7855b
x-ms-traffictypediagnostic: CY4PR12MB1830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1830725DB4C7642A725ABB78F1860@CY4PR12MB1830.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRNg0rD0TLklc7tUT9zW8t2B3m2PaQNU9HIsXpKtMEemAUnHPYmxAswb2HKe3CRS6Ql5e2DGE33IIaK1o7LM+k8bNTc8ichMV+IZwLs4MehJ+qT6KEoewGoPYid6oNK0BaVQvp++sOgwl3DVQQW/jAued3Q6v99PdNihT0MiHnV0z9HRxs1xZ0XXJnjdVCjJyfsS6vb0ghqxV+AsZLpwxKsOPpKHEM4Nx267TfFWGMzzshwMpomGpgT0TCi1j13le+FDfZIlq4pwTN+/Yl+8yLXe863J/2WnJ9oOBrIKPA4NLOR0YgCjpyjfdZeaZ8zY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(52536014)(7696005)(4326008)(71200400001)(186003)(86362001)(33656002)(26005)(6506007)(5660300002)(64756008)(53546011)(2906002)(9686003)(76116006)(83380400001)(66476007)(54906003)(66446008)(55016002)(66556008)(478600001)(8936002)(110136005)(66946007)(316002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qjkCRltoXOxxbOkCn0/i33awBYRB/dZ7efoca4P+TqfGww8s6u1t3Q0QDbc+9/wEEBAB8P6TSUF6awjnZ2oYtIX8R5q76MsKqGTcS20HB2nZXWOvpJBOw4XfjhOsAs1Yv3JwFXevV1NOTrUaMhxlOBGP4U4rLPjd/vyXOavSwRkQ486hLTMrcgsC9howS8yteVajXCbD0LOnCVpjl7LlYC79C8w1VswME3Y9u8N1VBQQPRXwJWtQsp7Sps7MF+pA25grO+W/amZISiI7V7XIe2+f0gVKmAmPpSEq2OyjQV3CpipEs86iBX3d3DmchyLgIc50Ud3Kbh0OYZ1W7G/Hgi7r+D6uQ+tn5fzlPD36BDug1qfAD9Qh5dFTyS/LgWC33wBMdWtFRgiRYWKzvPd7a9Pmbf0HJQMCbmQF7re2+LB2tC/lTXipMTuCNGARfLcLFzZ5Oz7nb+OsDlhk2/vBsJonIbn7cPAGAAYWRHn2wKtcYPLunWRKOdIAiN+9cbpg
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf46c53-9460-4bab-9032-08d808f7855b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 02:24:05.4022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKswFhubXVXAUGLX6O/Kotp6Ty+ZJtvwxfP1J4WT0mYIPeA4T9Yq+WtMU/HAn4r9ijgo4gJlverJ/1yQdq6vAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Clements, John" <John.Clements@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Please see my comments with prefix [Guchun].

Regards,
Guchun

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Thursday, June 4, 2020 8:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH V2] drm/amdgpu: support reserve bad page for virt

Changed from V1:
	rename same functions name, only init ras error handler data for
	supported asic.
[Guchun] 'same' is one typo? It should be some..


Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: Ia0ad9453ac3ac929f95c73cbee5b7a8fc42a9816
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 172 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  30 +++-
 3 files changed, 201 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1df28b7bf22e..668ad0e35160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2326,6 +2326,9 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)  {
 	int i, r;
 
+	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
+		amdgpu_virt_release_ras_err_handler_data(adev);
+
 	amdgpu_ras_pre_fini(adev);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index bab9286021a7..174fcb8c8b57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -26,6 +26,7 @@
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ras.h"
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  { @@ -255,12 +256,169 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj,
 	return ret;
 }
 
+static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device 
+*adev) {
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data **data = &virt->virt_eh_data;
+	/* GPU will be marked bad on host if bp count more then 10,
+	 * so alloc 512 is enough.
+	 */
+	unsigned int align_space = 512;
+	void *bps = NULL;
+	struct amdgpu_bo **bps_bo = NULL;
+
+	*data = kmalloc(sizeof(struct amdgpu_virt_ras_err_handler_data), GFP_KERNEL);
+	if (!*data)
+		return -ENOMEM;
+
+	bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
+	bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo), GFP_KERNEL);
+
+	if (!bps || !bps_bo) {
+		kfree(bps);
+		kfree(bps_bo);
[Guchun]It's needed to release *data as well to prevent memory leak?


+		return -ENOMEM;
+	}
+
+	(*data)->bps = bps;
+	(*data)->bps_bo = bps_bo;
+	(*data)->count = 0;
+	(*data)->last_reserved = 0;
+
+	virt->ras_init_done = true;
+
+	return 0;
+}
+
+static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev) {
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+	struct amdgpu_bo *bo;
+	int i;
+
+	if (!data)
+		return;
+
+	for (i = data->last_reserved - 1; i >= 0; i--) {
+		bo = data->bps_bo[i];
+		amdgpu_bo_free_kernel(&bo, NULL, NULL);
+		data->bps_bo[i] = bo;
+		data->last_reserved = i;
+	}
+}
+
+void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device 
+*adev) {
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+
+	virt->ras_init_done = false;
+
+	if (!data)
+		return;
+
+	amdgpu_virt_ras_release_bp(adev);
+
+	kfree(data->bps);
+	kfree(data->bps_bo);
+	kfree(data);
+	virt->virt_eh_data = NULL;
+}
+
+static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+		struct eeprom_table_record *bps, int pages) {
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+
+	if (!data)
+		return;
+
+	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
+	data->count += pages;
+}
+
+static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) {
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+	struct amdgpu_bo *bo = NULL;
+	uint64_t bp;
+	int i;
+
+	if (!data)
+		return;
+
+	for (i = data->last_reserved; i < data->count; i++) {
+		bp = data->bps[i].retired_page;
+
+		/* There are two cases of reserve error should be ignored:
+		 * 1) a ras bad page has been allocated (used by someone);
+		 * 2) a ras bad page has been reserved (duplicate error injection
+		 *    for one page);
+		 */
+		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
+					       AMDGPU_GPU_PAGE_SIZE,
+					       AMDGPU_GEM_DOMAIN_VRAM,
+					       &bo, NULL))
+			DRM_DEBUG("RAS WARN: [SRV-IO] reserve vram for retired page %llx 
+fail\n", bp);
+
+		data->bps_bo[i] = bo;
+		data->last_reserved = i + 1;
+		bo = NULL;
+	}
+}
+
+static bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev,
+		uint64_t retired_page)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+	int i;
+
+	if (!data)
+		return true;
+
+	for (i = 0; i < data->count; i++)
+		if (retired_page == data->bps[i].retired_page)
+			return true;
+
+	return false;
+}
+
+static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
+		uint64_t bp_block_offset, uint32_t bp_block_size) {
+	struct eeprom_table_record bp;
+	uint64_t retired_page;
+	uint32_t bp_idx, bp_cnt;
+
+	if (bp_block_size) {
+		bp_cnt = bp_block_size / sizeof(uint64_t);
+		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
+			retired_page = *(uint64_t *)(adev->fw_vram_usage.va +
+					bp_block_offset + bp_idx * sizeof(uint64_t));
+			bp.retired_page = retired_page;
+
+			if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+				continue;
+
+			amdgpu_virt_ras_add_bps(adev, &bp, 1);
+
+			amdgpu_virt_ras_reserve_bps(adev);
+		}
+	}
+}
+
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)  {
 	uint32_t pf2vf_size = 0;
 	uint32_t checksum = 0;
 	uint32_t checkval;
 	char *str;
+	uint64_t bp_block_offset = 0;
+	uint32_t bp_block_size = 0;
 
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
@@ -275,6 +433,20 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 
 		/* pf2vf message must be in 4K */
 		if (pf2vf_size > 0 && pf2vf_size < 4096) {
+			if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
+				struct amdgim_pf2vf_info_v2 *pf2vf_v2 = NULL;
[Guchun]Move declare of struct amdgim_pf2vf_info_v2 *pf2vf_v2 = NULL to the first beginning of this function.


+				pf2vf_v2 = (struct amdgim_pf2vf_info_v2 *)adev->virt.fw_reserve.p_pf2vf;
+				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_L & 0xFFFFFFFF) |
+						((((uint64_t)pf2vf_v2->bp_block_offset_H) << 32) & 0xFFFFFFFF00000000);
+				bp_block_size = pf2vf_v2->bp_block_size;
+
+				if (bp_block_size && !adev->virt.ras_init_done)
+					amdgpu_virt_init_ras_err_handler_data(adev);
+
+				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
+			}
+
 			checkval = amdgpu_virt_fw_reserve_get_checksum(
 				adev->virt.fw_reserve.p_pf2vf, pf2vf_size,
 				adev->virt.fw_reserve.checksum_key, checksum); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b90e822cebd7..f826945989c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -143,19 +143,27 @@ struct  amdgim_pf2vf_info_v2 {
 	uint32_t vce_enc_max_pixels_count;
 	/* 16x16 pixels/sec, codec independent */
 	uint32_t vce_enc_max_bandwidth;
+	/* Bad pages block position in BYTE */
+	uint32_t bp_block_offset_L;
+	uint32_t bp_block_offset_H;
+	/* Bad pages block size in BYTE */
+	uint32_t bp_block_size;
 	/* MEC FW position in kb from the start of VF visible frame buffer */
-	uint64_t mecfw_kboffset;
+	uint32_t mecfw_kboffset_L;
+	uint32_t mecfw_kboffset_H;
 	/* MEC FW size in KB */
 	uint32_t mecfw_ksize;
 	/* UVD FW position in kb from the start of VF visible frame buffer */
-	uint64_t uvdfw_kboffset;
+	uint32_t uvdfw_kboffset_L;
+	uint32_t uvdfw_kboffset_H;
 	/* UVD FW size in KB */
 	uint32_t uvdfw_ksize;
 	/* VCE FW position in kb from the start of VF visible frame buffer */
-	uint64_t vcefw_kboffset;
+	uint32_t vcefw_kboffset_L;
+	uint32_t vcefw_kboffset_H;
 	/* VCE FW size in KB */
 	uint32_t vcefw_ksize;
-	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 0, 0, (9 + sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 3)];
+	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 0, 0, (18 + 
+sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 0)];
 } __aligned(4);
 
 
@@ -254,6 +262,17 @@ typedef struct amdgim_vf2pf_info_v2 amdgim_vf2pf_info ;
 		} \
 	} while (0)
 
+struct amdgpu_virt_ras_err_handler_data {
+	/* point to bad page records array */
+	struct eeprom_table_record *bps;
+	/* point to reserved bo array */
+	struct amdgpu_bo **bps_bo;
+	/* the count of entries */
+	int count;
+	/* last reserved entry's index + 1 */
+	int last_reserved;
+};
+
 /* GPU virtualization */
 struct amdgpu_virt {
 	uint32_t			caps;
@@ -272,6 +291,8 @@ struct amdgpu_virt {
 	uint32_t reg_access_mode;
 	int req_init_data_ver;
 	bool tdr_debug;
+	struct amdgpu_virt_ras_err_handler_data *virt_eh_data;
+	bool ras_init_done;
 };
 
 #define amdgpu_sriov_enabled(adev) \
@@ -323,6 +344,7 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);  int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
 					unsigned int key,
 					unsigned int chksum);
+void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device 
+*adev);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);  void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
