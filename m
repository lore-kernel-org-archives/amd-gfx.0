Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D317DC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 07:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7335D206B5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 07:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F82ztjJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7335D206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141B789B3B;
	Wed, 19 Aug 2020 07:36:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B4589B3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 07:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuYRFiGCKSveOh1zy7mYFpXZ2Bfz2zXQAh4z6e7ycHlisGGdbW0pfIFhYNdsULHGYtDjej3iPGJGcG+1qmB5riLLTB9ZzqFjrKgoOpjrSTzVRovKmLt81jcD0kqtICvUnPDquX5ut0Ks7w0F+wqf+Cz9XcMhxU86HKaQ6wJQ6z8ZDuX6EhiTCIUWq27nrE12jq6wsST0LO/GLz8rfENwvuiRyDqUQCFZXbVw/CdMCfjbeQZXP6h5GLe1e8AiIPaip8R8o0jVzj1rehKsSYAYl9m++75dDt5/5rSGmh+UxohG4KxEmrlD0UYb5+z2JYtLfLaD46T0V51KkQCJb/k0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV7YaDP87Lbb52Btm2d+yrAI+M6tzyuwZkjq6j9sOJ8=;
 b=BsohCao+3yO9bktpy/PHln05wJ9ErU2l+VcwclrTXM3EGcIJdTxz0ixQzTrHpjTz4xZDKYvpdq7K3uoZhBLJbO2cOHBaWBQwBRmJiU+0AQWMNb5DmYpwUdHrT9LSLre3uzl/cyEWb9kq+sg+b1pntS7+tW1Lm+MIp/Rlk6eVQ6uoea4fC7xp22DHYlRyxeENFp6TnSToCzXpcc5rE8bNIlkubNTkUeAiLZs0G2pzGjKz8tmr4Lh+90GlrNfLVymQBtRki2gFOkHf6tCn7bTXD3UvtYg/c8ITp35rwlDu98rjH+fS5ROht1IhbxkCoFpKhM+Dyir3r7mvmr0gIh85zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV7YaDP87Lbb52Btm2d+yrAI+M6tzyuwZkjq6j9sOJ8=;
 b=F82ztjJoXk02QnEt2jQ6TjofzFn1ze5l4vyiitdDtZ4e8CayfdLp8aw9IIFNJ7DbXRCfLol6Hj/oDlM2On1WDGk6kGFkcGyJVWzzhtko2UbuTogPMwNRmQURi/6iRONdz0kxjETHQ/dePWJnLTKiMy545uSBRY0dmcnWE/I74Zo=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Wed, 19 Aug 2020 07:36:23 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 07:36:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: refine create and release logic of hive
 info
Thread-Topic: [PATCH v3] drm/amdgpu: refine create and release logic of hive
 info
Thread-Index: AQHWdVx0elKnoENDUkGMzcoGMcCDA6k/DATQ
Date: Wed, 19 Aug 2020 07:36:22 +0000
Message-ID: <DM6PR12MB4075F6FCA06956CC95FFC5BDFC5D0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200818123807.11333-1-Dennis.Li@amd.com>
In-Reply-To: <20200818123807.11333-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-19T07:36:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cd5710d6-97ef-480b-bf61-00007821101e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-19T07:36:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a43b88a6-9215-49fd-bc07-000054aa64ff
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-19T07:36:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9b1e51aa-52e3-4939-b7b2-0000920c2f9d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a90bb054-da58-4d79-cb0f-08d844129275
x-ms-traffictypediagnostic: DM6PR12MB4436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44361F740038B68CED82DD9EFC5D0@DM6PR12MB4436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUbBlSXAk+bFclvCbESrmIH4nMsX6E+DPHrKPjYfmZFqsOtBsEmc2PVRBZWa/q5DIGN/eznx0sGLg0rXpZkLYHwCgAsfQhFA8emqvCQvEN6WIascrra1k+oQ5lfbVFo3iHcd/N0o3Uaj+ikiP/EdK3bCku+OJseUhxQ/tCNTZCQsD754TMZGI6cgVmCVZS+9K4dXBvkEQjuqWzjHTKU4zNnQzbgLNvh+aB72Y7zWmZbnXzNPPI5pzUDZRQif1SMSVtoYzl9a5fJppgUG1s8ddfSdXuWjqR4gN9cfuUdZeK3zKSkA5BF9M47CQDI9sdPmjCczSiHYty2VtNbnXEq2tw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(478600001)(316002)(110136005)(64756008)(2906002)(66556008)(6636002)(66946007)(66476007)(5660300002)(33656002)(76116006)(4326008)(66446008)(8676002)(52536014)(26005)(71200400001)(83380400001)(7696005)(86362001)(30864003)(6506007)(9686003)(53546011)(186003)(55016002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 6yZA1Tt+LiGpoBlDMO79cDzlxuCV30QS1+JklyCeSKqtdgNieLR8hWTnt7oYT7hiNtKG+2hzuDRhIG5mBrmbNrR0NF4+7XM4IOL4nq/TgfyhD/BgLeCHLgX0i3hRwb/jnlr1fSUNwoIVStrkCm5K0CwDiebwT81pF2HIzS2tpYEH1dV9ACHpWzVZpTtfb8siY3vqqxUg/DcVqkQcEgwLBWwdnAGNDMN+JKe9/Hpu2G1eoSZHiFZ30GEThvTlN7AKVK20KFtIVhjeY2JjwitNQGxEwMsRML/Lj8/q2LlIXCzyB61Fxc9fRDkUcGJ2af3JLGe5bjjeK7KyEXKu3F74fS8/tB7gGE+EU+GUjXQGGDLkwKCJ4HzS5/9YBrFZn+n13YrXRrMUIXMKS9q0IWdgseviU8sw8lHnopweI/wSc5uFqdbLRyGQabl/81e7l2BemuTAiCOR/VNzuYCetoG/KmhlfzKwGK3A1qVDvKrAc8Dp/xOxR8eL0OK/f4K5rqkxHepz6A9Bdp/cRgxKJQ3y4KvRl4+k9Dtx9LPM/W82MQAG6o8YOPLAriJ+bhXP7otpMCjw8YZYf83VTByAhv8lqVUq1SS9NEi9sEULT9bB/P2yCZyKiEoX3psdEiOf4awiFdiLpir7kXFwsbwr7xk2RA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90bb054-da58-4d79-cb0f-08d844129275
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 07:36:22.8346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EvU/JAxuexpdGcW7sF2M/hffdq+JqR5V/LSDEQeAeV4jD2gFpF3Y95lbIFoIxbwtZBXcTm9qRB46iiVws9tCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
Sent: Tuesday, August 18, 2020 20:38
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v3] drm/amdgpu: refine create and release logic of hive info

Change to dynamically create and release hive info object, which help driver support more hives in the future.

v2:
Change to save hive object pointer in adev, to avoid locking xgmi_mutex every time when calling amdgpu_get_xgmi_hive.

v3:
1. Change type of hive object pointer in adev from void* to amdgpu_hive_info*.
2. remove unnecessary variable initialization.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 98d0c6e5ab3c..e25f952d8836 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -251,6 +251,7 @@ struct amdgpu_fpriv;  struct amdgpu_bo_va_mapping;  struct amdgpu_atif;  struct kfd_vm_fault_info;
+struct amdgpu_hive_info;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -730,7 +731,7 @@ struct amdgpu_device {  #ifdef CONFIG_DRM_AMD_ACP
 	struct amdgpu_acp		acp;
 #endif
-
+	struct amdgpu_hive_info *hive;
 	/* ASIC */
 	enum amd_asic_type		asic_type;
 	uint32_t			family;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f323281c82b0..bc6ef0caf157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2857,7 +2857,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)  {
 	struct amdgpu_device *adev =
 		container_of(__work, struct amdgpu_device, xgmi_reset_work);
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 	/* It's a bug to not have a hive within this function */
 	if (WARN_ON(!hive))
@@ -2895,6 +2895,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 	if (adev->asic_reset_res)
 		DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
 			 adev->asic_reset_res, adev->ddev->unique);
+	amdgpu_put_xgmi_hive(hive);
 }
 
 static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev) @@ -4315,7 +4316,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive = amdgpu_get_xgmi_hive(adev, false);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress", diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bf71f0a58786..18cdd259d568 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1555,9 +1555,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *remote_adev = NULL;
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
 
 	if (!ras->disable_ras_err_cnt_harvest) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
 		/* Build list of devices to query RAS related errors */
 		if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
 			device_list_handle = &hive->device_list; @@ -1570,6 +1571,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		list_for_each_entry(remote_adev,
 				device_list_handle, gmc.xgmi.head)
 			amdgpu_ras_log_on_err_counter(remote_adev);
+
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 7a61dc6738eb..08ed4dddfaf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -35,11 +35,9 @@
 
 static DEFINE_MUTEX(xgmi_mutex);
 
-#define AMDGPU_MAX_XGMI_HIVE			8
 #define AMDGPU_MAX_XGMI_DEVICE_PER_HIVE		4
 
-static struct amdgpu_hive_info xgmi_hives[AMDGPU_MAX_XGMI_HIVE]; -static unsigned hive_count = 0;
+static LIST_HEAD(xgmi_hive_list);
 
 static const int xgmi_pcs_err_status_reg_vg20[] = {
 	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS,
@@ -171,59 +169,47 @@ static const struct amdgpu_pcs_ras_field wafl_pcs_ras_fields[] = {
  *
  */
 
+static struct attribute amdgpu_xgmi_hive_id = {
+	.name = "xgmi_hive_id",
+	.mode = S_IRUGO
+};
 
-static ssize_t amdgpu_xgmi_show_hive_id(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct amdgpu_hive_info *hive =
-			container_of(attr, struct amdgpu_hive_info, dev_attr);
-
-	return snprintf(buf, PAGE_SIZE, "%llu\n", hive->hive_id);
-}
+static struct attribute *amdgpu_xgmi_hive_attrs[] = {
+	&amdgpu_xgmi_hive_id,
+	NULL
+};
 
-static int amdgpu_xgmi_sysfs_create(struct amdgpu_device *adev,
-				    struct amdgpu_hive_info *hive)
+static ssize_t amdgpu_xgmi_show_attrs(struct kobject *kobj,
+	struct attribute *attr, char *buf)
 {
-	int ret = 0;
-
-	if (WARN_ON(hive->kobj))
-		return -EINVAL;
-
-	hive->kobj = kobject_create_and_add("xgmi_hive_info", &adev->dev->kobj);
-	if (!hive->kobj) {
-		dev_err(adev->dev, "XGMI: Failed to allocate sysfs entry!\n");
-		return -EINVAL;
-	}
-
-	hive->dev_attr = (struct device_attribute) {
-		.attr = {
-			.name = "xgmi_hive_id",
-			.mode = S_IRUGO,
+	struct amdgpu_hive_info *hive = container_of(
+		kobj, struct amdgpu_hive_info, kobj);
 
-		},
-		.show = amdgpu_xgmi_show_hive_id,
-	};
-
-	ret = sysfs_create_file(hive->kobj, &hive->dev_attr.attr);
-	if (ret) {
-		dev_err(adev->dev, "XGMI: Failed to create device file xgmi_hive_id\n");
-		kobject_del(hive->kobj);
-		kobject_put(hive->kobj);
-		hive->kobj = NULL;
-	}
+	if (attr == &amdgpu_xgmi_hive_id)
+		return snprintf(buf, PAGE_SIZE, "%llu\n", hive->hive_id);
 
-	return ret;
+	return 0;
 }
 
-static void amdgpu_xgmi_sysfs_destroy(struct amdgpu_device *adev,
-				    struct amdgpu_hive_info *hive)
+static void amdgpu_xgmi_hive_release(struct kobject *kobj)
 {
-	sysfs_remove_file(hive->kobj, &hive->dev_attr.attr);
-	kobject_del(hive->kobj);
-	kobject_put(hive->kobj);
-	hive->kobj = NULL;
+	struct amdgpu_hive_info *hive = container_of(
+		kobj, struct amdgpu_hive_info, kobj);
+
+	mutex_destroy(&hive->hive_lock);
+	kfree(hive);
 }
 
+static const struct sysfs_ops amdgpu_xgmi_hive_ops = {
+	.show = amdgpu_xgmi_show_attrs,
+};
+
+struct kobj_type amdgpu_xgmi_hive_type = {
+	.release = amdgpu_xgmi_hive_release,
+	.sysfs_ops = &amdgpu_xgmi_hive_ops,
+	.default_attrs = amdgpu_xgmi_hive_attrs, };
+
 static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -287,8 +273,8 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 
 
 	/* Create sysfs link to hive info folder on the first device */
-	if (adev != hive->adev) {
-		ret = sysfs_create_link(&adev->dev->kobj, hive->kobj,
+	if (hive->kobj.parent != (&adev->dev->kobj)) {
+		ret = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
 					"xgmi_hive_info");
 		if (ret) {
 			dev_err(adev->dev, "XGMI: Failed to create link to hive info"); @@ -296,9 +282,9 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 		}
 	}
 
-	sprintf(node, "node%d", hive->number_devices);
+	sprintf(node, "node%d", atomic_read(&hive->number_devices));
 	/* Create sysfs link form the hive folder to yourself */
-	ret = sysfs_create_link(hive->kobj, &adev->dev->kobj, node);
+	ret = sysfs_create_link(&hive->kobj, &adev->dev->kobj, node);
 	if (ret) {
 		dev_err(adev->dev, "XGMI: Failed to create link from hive info");
 		goto remove_link;
@@ -326,78 +312,96 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
 
-	if (adev != hive->adev)
+	if (hive->kobj.parent != (&adev->dev->kobj))
 		sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
 
-	sprintf(node, "node%d", hive->number_devices);
-	sysfs_remove_link(hive->kobj, node);
+	sprintf(node, "node%d", atomic_read(&hive->number_devices));
+	sysfs_remove_link(&hive->kobj, node);
 
 }
 
 
 
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock)
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device 
+*adev)
 {
-	int i;
-	struct amdgpu_hive_info *tmp;
+	struct amdgpu_hive_info *hive = NULL, *tmp = NULL;
+	int ret;
 
 	if (!adev->gmc.xgmi.hive_id)
 		return NULL;
 
+	if (adev->hive) {
+		kobject_get(&adev->hive->kobj);
+		return adev->hive;
+	}
+
 	mutex_lock(&xgmi_mutex);
 
-	for (i = 0 ; i < hive_count; ++i) {
-		tmp = &xgmi_hives[i];
-		if (tmp->hive_id == adev->gmc.xgmi.hive_id) {
-			if (lock)
-				mutex_lock(&tmp->hive_lock);
-			mutex_unlock(&xgmi_mutex);
-			return tmp;
+	if (!list_empty(&xgmi_hive_list)) {
+		list_for_each_entry_safe(hive, tmp, &xgmi_hive_list, node)  {
+			if (hive->hive_id == adev->gmc.xgmi.hive_id)
+				goto pro_end;
 		}
 	}
-	if (i >= AMDGPU_MAX_XGMI_HIVE) {
-		mutex_unlock(&xgmi_mutex);
-		return NULL;
+
+	hive = kzalloc(sizeof(*hive), GFP_KERNEL);
+	if (!hive) {
+		dev_err(adev->dev, "XGMI: allocation failed\n");
+		hive = NULL;
+		goto pro_end;
 	}
 
 	/* initialize new hive if not exist */
-	tmp = &xgmi_hives[hive_count++];
-
-	if (amdgpu_xgmi_sysfs_create(adev, tmp)) {
-		mutex_unlock(&xgmi_mutex);
-		return NULL;
+	ret = kobject_init_and_add(&hive->kobj,
+			&amdgpu_xgmi_hive_type,
+			&adev->dev->kobj,
+			"%s", "xgmi_hive_info");
+	if (ret) {
+		dev_err(adev->dev, "XGMI: failed initializing kobject for xgmi hive\n");
+		kfree(hive);
+		hive = NULL;
+		goto pro_end;
 	}
 
-	tmp->adev = adev;
-	tmp->hive_id = adev->gmc.xgmi.hive_id;
-	INIT_LIST_HEAD(&tmp->device_list);
-	mutex_init(&tmp->hive_lock);
-	atomic_set(&tmp->in_reset, 0);
-	task_barrier_init(&tmp->tb);
-
-	if (lock)
-		mutex_lock(&tmp->hive_lock);
-	tmp->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
-	tmp->hi_req_gpu = NULL;
+	hive->hive_id = adev->gmc.xgmi.hive_id;
+	INIT_LIST_HEAD(&hive->device_list);
+	INIT_LIST_HEAD(&hive->node);
+	mutex_init(&hive->hive_lock);
+	atomic_set(&hive->in_reset, 0);
+	atomic_set(&hive->number_devices, 0);
+	task_barrier_init(&hive->tb);
+	hive->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
+	hive->hi_req_gpu = NULL;
 	/*
 	 * hive pstate on boot is high in vega20 so we have to go to low
 	 * pstate on after boot.
 	 */
-	tmp->hi_req_count = AMDGPU_MAX_XGMI_DEVICE_PER_HIVE;
+	hive->hi_req_count = AMDGPU_MAX_XGMI_DEVICE_PER_HIVE;
+	list_add_tail(&hive->node, &xgmi_hive_list);
+
+pro_end:
+	if (hive)
+		kobject_get(&hive->kobj);
 	mutex_unlock(&xgmi_mutex);
+	return hive;
+}
 
-	return tmp;
+void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive) {
+	if (hive)
+		kobject_put(&hive->kobj);
 }
 
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)  {
 	int ret = 0;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 	struct amdgpu_device *request_adev = hive->hi_req_gpu ?
 						hive->hi_req_gpu : adev;
 	bool is_hi_req = pstate == AMDGPU_XGMI_PSTATE_MAX_VEGA20;
 	bool init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
 
+	amdgpu_put_xgmi_hive(hive);
 	/* fw bug so temporarily disable pstate switching */
 	return 0;
 
@@ -449,7 +453,7 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 
 	/* Each psp need to set the latest topology */
 	ret = psp_xgmi_set_topology_info(&adev->psp,
-					 hive->number_devices,
+					 atomic_read(&hive->number_devices),
 					 &adev->psp.xgmi_context.top_info);
 	if (ret)
 		dev_err(adev->dev,
@@ -511,7 +515,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		adev->gmc.xgmi.node_id = adev->gmc.xgmi.physical_node_id + 16;
 	}
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (!hive) {
 		ret = -EINVAL;
 		dev_err(adev->dev,
@@ -519,6 +523,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 			adev->gmc.xgmi.node_id, adev->gmc.xgmi.hive_id);
 		goto exit;
 	}
+	mutex_lock(&hive->hive_lock);
 
 	top_info = &adev->psp.xgmi_context.top_info;
 
@@ -526,7 +531,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	list_for_each_entry(entry, &hive->device_list, head)
 		top_info->nodes[count++].node_id = entry->node_id;
 	top_info->num_nodes = count;
-	hive->number_devices = count;
+	atomic_set(&hive->number_devices, count);
 
 	task_barrier_add_task(&hive->tb);
 
@@ -565,35 +570,48 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 exit_unlock:
 	mutex_unlock(&hive->hive_lock);
 exit:
-	if (!ret)
+	if (!ret) {
+		adev->hive = hive;
 		dev_info(adev->dev, "XGMI: Add node %d, hive 0x%llx.\n",
 			 adev->gmc.xgmi.physical_node_id, adev->gmc.xgmi.hive_id);
-	else
+	} else {
+		amdgpu_put_xgmi_hive(hive);
 		dev_err(adev->dev, "XGMI: Failed to add node %d, hive 0x%llx ret: %d\n",
 			adev->gmc.xgmi.physical_node_id, adev->gmc.xgmi.hive_id,
 			ret);
+	}
 
 	return ret;
 }
 
 int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)  {
-	struct amdgpu_hive_info *hive;
+	struct amdgpu_hive_info *hive = adev->hive;
 
 	if (!adev->gmc.xgmi.supported)
 		return -EINVAL;
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
 	if (!hive)
 		return -EINVAL;
 
+	mutex_lock(&hive->hive_lock);
 	task_barrier_rem_task(&hive->tb);
 	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
+	if (hive->hi_req_gpu == adev)
+		hive->hi_req_gpu = NULL;
+	list_del(&adev->gmc.xgmi.head);
 	mutex_unlock(&hive->hive_lock);
 
-	if(!(--hive->number_devices)){
-		amdgpu_xgmi_sysfs_destroy(adev, hive);
-		mutex_destroy(&hive->hive_lock);
+	amdgpu_put_xgmi_hive(hive);
+	adev->hive = NULL;
+
+	if (atomic_dec_return(&hive->number_devices) == 0) {
+		/* Remove the hive from global hive list */
+		mutex_lock(&xgmi_mutex);
+		list_del(&hive->node);
+		mutex_unlock(&xgmi_mutex);
+
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	return psp_xgmi_terminate(&adev->psp); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 453336ca9675..148560d63554 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -27,13 +27,12 @@
 
 
 struct amdgpu_hive_info {
-	uint64_t		hive_id;
-	struct list_head	device_list;
-	int number_devices;
+	struct kobject kobj;
+	uint64_t hive_id;
+	struct list_head device_list;
+	struct list_head node;
+	atomic_t number_devices;
 	struct mutex hive_lock;
-	struct kobject *kobj;
-	struct device_attribute dev_attr;
-	struct amdgpu_device *adev;
 	atomic_t in_reset;
 	int hi_req_count;
 	struct amdgpu_device *hi_req_gpu;
@@ -51,7 +50,8 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device 
+*adev); void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);  int amdgpu_xgmi_add_device(struct amdgpu_device *adev);  int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
