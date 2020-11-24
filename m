Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A18C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 13:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CEA2083E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 13:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PahzyPSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CEA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630EB6E3F5;
	Tue, 24 Nov 2020 13:47:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACF16E3F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 13:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOZ31SNwhgZ2Sh/DyO20i4ON73vvmDpxxBV3Lo+uE7skkU2Pf6qDtV1hci0qgsMUe2RJaj+BgL8dHPzoEaCasxwPWMT4J65dKT8q8GVl+l8wQznTUwO/i2sL1eBcBD0ECSefjOlpqNAA9KebvZIqiLE6WY+qyKHCoUCxLvT2jBV/DL3lk8b9C8XmJZ+u2tynoIdbU2G03emB8Ql23JHlMY4CTqJ/dkbKMvGUphQGQiN3iZPhME1VscAh6sW5cUPsDnXsR5CpQlRpVtbxSOws9re8Ff64HKdeR4U1ifEkzj28RrH+2k/p5Q8m8VX57J0Dpl40bNcFF++kNxJ3TnoPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmLI0bxhO1X9a2qHX5yGD0OcJqFsiKrUhvkFYjC5tRc=;
 b=f+ySAFY7RH4b8xDjNciuDkQPpipnA3LZEUmI8PahX2svndHdKr5wL8QYakaWO6iTKlJpfz3RHtO20g/6tD+Byb9geb3n7zcoB9WD0wHoU0hsm8fwxBbyzDOtdL6b6TJrCAICxlqcC27up7KJP4Az7E2TZAAeRUIyTNZAmIAe375HQv1bkVpCTchLSn73CzqSew1+A4quPO7TCucyT2NgBieFJTf7qCN39C17pXQzcqeniFLFr2Z2/nRZN361psGpPzcpw0yY7U69TNafFwClQFSsalCdajeAOqK3Mb+6FI2X2TIM+hQVxv8e/fqT5H4JuKp8WNWWRfkkjpjQFfjyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmLI0bxhO1X9a2qHX5yGD0OcJqFsiKrUhvkFYjC5tRc=;
 b=PahzyPSP9yhYDiXbLgZUI/KMUiGFrIxtO1ZyATtm4CQVS4Wj+sR6sSJeQAsPlIceHjb8OxFC4F27zsFkn/idhDTXjINKVW6KEIgyQ39Wf7t4ibtrsxfJGPKzlensfpxqpkfyN29p9EtOZjshnxISOZ3OtXLRXWyf42ObjcYq/hM=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Tue, 24 Nov
 2020 13:47:03 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 13:47:03 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
 in SRIOV for navi12
Thread-Topic: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
 in SRIOV for navi12
Thread-Index: AQHWwkcSyC7H9ERIqU6kZy+Nte0A7KnXS3PQ
Date: Tue, 24 Nov 2020 13:47:03 +0000
Message-ID: <CY4PR12MB128779E09EEFC614305187B6F1FB0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201124094905.25255-1-Stanley.Yang@amd.com>
In-Reply-To: <20201124094905.25255-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-24T13:45:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=489cb579-6b73-4780-991a-00008ef8215b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-24T13:47:01Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 16cb17a1-9acf-4737-b902-0000ef4120c2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.158.166.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6913ccf-c4af-4040-b674-08d8907f6d0b
x-ms-traffictypediagnostic: CY4PR12MB1623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16239D142284A87834E6509FF1FB0@CY4PR12MB1623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnrpgsT6srYRB9yjVG0ZVizgyEA483ejr6HX77ejgM115U6+io7ZrIa6T4pXGXdiG7Hw5AEPRJxHidgIzCS+I4gLHr/vth7ydM8CaN5hTb04EEdtAHH0/cFcPePJgYAYGEzn0bjZgpAacL6bm1h0AVdIehp7TLPRjqc6Nsu4CRkHgLVKeia7oNILNVhDt00vbdoxSjeptZgzmkVC6d/QnzqpK0mtRGc4/hOyvgV6ijXBNC7mpw9WrjryLRWwoWz1N2hjMItzv7JXXcm4zW/Gto7TC0vx8yTgJJK5WTPlgmq24kvw1CfiD9So0BzXW43G19gH+exDsrU68dGnVc+xxrGBZgWy0wSoFc4IF0QgMeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(83380400001)(45080400002)(66556008)(55016002)(966005)(66476007)(66946007)(64756008)(76116006)(6636002)(2906002)(8676002)(86362001)(66446008)(53546011)(6506007)(8936002)(26005)(186003)(33656002)(110136005)(316002)(7696005)(478600001)(9686003)(5660300002)(71200400001)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YrMwtKueUbcH7ZOEunPsthGWx3jB7VAtoVsLrvzqIl+hPGzqnxL7+NdUnZzl?=
 =?us-ascii?Q?ojCrg/Re2H+5+MLJSHoPTyxjT7eICO+Ssx3xnP9q165ofHcJo6u4kFDEdhZu?=
 =?us-ascii?Q?ZGYXO107ugVa3uziXuhueVNLLcAWMVTyKegV3fS5KF4FYuIhOsfls/Ox/SsT?=
 =?us-ascii?Q?QnCna26Noqpc4Kc6DnBl+eiM0wKSx+veQ6/hbVUDrMNHqD+3rafpo3nFfQQb?=
 =?us-ascii?Q?dBcNLip1VihGhqKA1iteyRAc1jDmmCaHOJrQQv4fT3RRxQD/S519brP9udn+?=
 =?us-ascii?Q?42eF3tzSVedwsk09QRZCFw1wQ8sCwkrRkSNrWQU3jVWym2kqCeTNJgGQOA23?=
 =?us-ascii?Q?g0VjdN4hcu5ov7v2AanKgwI46CZOsQndEwqeg+trjbFo4R2m7TEmYn6XoEK3?=
 =?us-ascii?Q?kQRwL700OFg3/EAJwPtwCsl6d0PTZv9t3rDRCZ/gPDJTaJSnm3mPwqR0qAA5?=
 =?us-ascii?Q?LAOhEK/XEjivU3xn6sDXcNtpbnl0UWXoKIabQuANSFAQdr4TLoIi3U7mdO/U?=
 =?us-ascii?Q?YlXHfxWuUzy8wJyeq8FVcOZGO+CilevCiOSQHzpZ/npkWsN5wBl/wP7L7ZRw?=
 =?us-ascii?Q?+XtM9mFftuimSjcMcIZVSLymkiLFgklmQa4bsRVw2FfSopjckaL8zRwr+Pee?=
 =?us-ascii?Q?VlleOA3g2rRJt1MqZfMOnJOeKcV+Ye3NCF8QMV3umXlmc3aE0JBBNVYTmfj0?=
 =?us-ascii?Q?aL/YSlKYilaZuSzU/mibPXiQpNY8pPgvisXa/MSyW40jhw0jF1u6lFSzTNOG?=
 =?us-ascii?Q?owYSLNjYuKtQtOntDIiiSDQH4KdLVlpkz5GwvQrXadCM7Svq8Hj0klH4JFLn?=
 =?us-ascii?Q?mx/lM5nfHg8hjnsJEW6goCAUKUIGHLzyHanB1rslEUUbDVRBZLT8vfdUqR6X?=
 =?us-ascii?Q?D4ZxPxgracIX+Mnksw8izkCnfOCUWaa7CG/jfArcM4GhZ56fsAD/ohGUzUbL?=
 =?us-ascii?Q?mv7zpFmUrVZSUzyH1OGLrXsEDo4LM6/gFdSeGPMb1ZI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6913ccf-c4af-4040-b674-08d8907f6d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 13:47:03.6746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsETH4AEgpAen+I6eJRonjlgH5nuSDW7kI5BFNW96hohXruVZG0QaIg5Z/sjpXVis5UIy2ItfFIFU2/4nN6yhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -208,14 +208,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	unsigned long tools_size;
 	int ret;
 	struct cgs_firmware_info info = {0};
+	struct amdgpu_device *adev = hwmgr->adev;

Why add this local variable? Looks no one is using it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.Yang
Sent: Tuesday, November 24, 2020 5:49 PM
To: amd-gfx@lists.freedesktop.org; Chen, JingWen <JingWen.Chen2@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in SRIOV for navi12

The KFDTopologyTest.BasicTest will failed if skip smc, sdma, sos, ta and asd fw in SRIOV for vega10, so adjust above fw and skip load them in SRIOV only for navi12.

v2: remove unnecessary asic type check.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c              |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c              |  3 ---
 .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 13 ++++++-------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c           |  2 +-
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 16b551f330a4..8309dd95aa48 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -593,9 +593,6 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9c72b95b7463..fad1cc394219 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -203,7 +203,7 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 	const struct common_firmware_header *header = NULL;
 	const struct sdma_firmware_header_v1_0 *hdr;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
 		return 0;
 
 	DRM_DEBUG("\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index cb5a6f1437f8..5ea11a0f568f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -153,9 +153,6 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index daf122f24f23..e2192d8762a4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -208,14 +208,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	unsigned long tools_size;
 	int ret;
 	struct cgs_firmware_info info = {0};
+	struct amdgpu_device *adev = hwmgr->adev;

-	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
-		ret = cgs_get_firmware_info(hwmgr->device,
-						CGS_UCODE_ID_SMU,
-						&info);
-		if (ret || !info.kptr)
-			return -EINVAL;
-	}
+	ret = cgs_get_firmware_info(hwmgr->device,
+					CGS_UCODE_ID_SMU,
+					&info);
+	if (ret || !info.kptr)
+		return -EINVAL;
 
 	priv = kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1904df5a3e20..80c0bfaed097 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -847,7 +847,7 @@ static int smu_sw_init(void *handle)
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
 		ret = smu_init_microcode(smu);
 		if (ret) {
 			dev_err(adev->dev, "Failed to load smu firmware!\n");
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cdf14a0bc671547d5315708d8905e330b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418081554620468%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BNU5d%2FQSOnNZNYHQ3ZjBjIubUl1wa6lmkaWBf2XuIjw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
