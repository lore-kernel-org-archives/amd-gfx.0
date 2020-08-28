Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97444C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554E1208C9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WzW2dnKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554E1208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE296EB69;
	Fri, 28 Aug 2020 07:29:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DBE6EB69
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 07:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/ultkpXiV0VMGC989nKJZaf2L97UMQIfc9lV+TlhtDuc0h6TFll/HLIht0Qigk93QmBumfBM1xYRM20NRKtbZm4LR1rIchpH0CSWLt8scxYQ0q0/NVR6JFMeiaVra5ObWO7IC5BB3MoElf8MMOHAoEj0BRvXCtrVY2o2LPpkwdIEejjwz4nIO3FMkpyht8mIAOmZbZskZJjKSr/CNsafwi/OuyaNuyQwpdxbOAXCcSTKJQO7W6Aq9XsX6LiPExKsFSn3TZxR9RcQffl7MZNtITZqMeNwN5XlQpcokFeAxZDLFvqa7gvaAY4ciCkqrOkQCelduJEZf7YRjz0QJFEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJR5NrhwIGQxyyXzJ6D1EF9dCXfMzeYv4Ss7MFzfnmU=;
 b=EECkqCqycNPDVv9PlWD5hpmAd26NeJJTcPmx+NvVGHX/62NDfOCGhnHrbWI0YgV4K80igt3ne6EnTMBeYV6IfupN5TV++C3JX8xPZFPiQ8VvhWnN+7O+1/lNDKZ9o/AxsSXAlvyqC6L9yID26KghMWhGWS2MAYp4wQ1zDDNuDOLvA4vwvKc+mq5XzvThdGDm4xHdeUwkplXSzRAwkDj4TA2ybSuCogiyIMky5jNFUfBl94a1V7zzZcSdvtrESThYVTajYegNVYVG0tWjfnv9icRMRQUbRCFqUFpS9sfUGXBB3h6NzL6OEulK8CX/2yWvMD5v4OLEsy+YV0vIjLJzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJR5NrhwIGQxyyXzJ6D1EF9dCXfMzeYv4Ss7MFzfnmU=;
 b=WzW2dnKcpNJvaY1hKr7aB5MOvfERphCnUIrXQTWtFfOWLpLCYKLaFlJIS4zxd72ezqkAXQD062M5dneVuw0q7W9f+zuZ+PKKNfrrRMFaFQpWqWYMGn+I3wl6tci0I407MPLmtlMXatvorHAGiTDgwAwH6tpDOeWvVmoPpBM7PGc=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 07:29:57 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 07:29:56 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Thread-Topic: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Thread-Index: AQHWfITdmXlZOGalnUqmD8sY4cKI+alNIKfw
Date: Fri, 28 Aug 2020 07:29:56 +0000
Message-ID: <DM5PR12MB1708A7B24C9A36455E45A89784520@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200827151858.55326-1-nirmoy.das@amd.com>
In-Reply-To: <20200827151858.55326-1-nirmoy.das@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=04606ec5-7360-4239-80fc-00000dbb4bea;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-28T07:28:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2685ecc4-b9df-436a-e468-08d84b242a08
x-ms-traffictypediagnostic: DM6PR12MB3690:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB369088A73F1ECE2D36BE509C84520@DM6PR12MB3690.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8yDNsJpteV96hlzHLCJp/Cv+MBXk+WWgvkjaKxVn2ZkpkacuAgfLUCHBstkvcvU2tpzu83IxiTsx/PkmlDXgfCy6jpy+TheLOqenLhrBz3fLhSzvxWWGdeTgFjwDKs5dbEF9GCyKCjNnJdKimUSj5fbYNbmeHpoMGKq0WfFDCJ1Ix3ZD73OPuk3erToYq/tkNG83L9s2bdMPXpFnjVAerkx0Wr0Alka29KmQBWIfD0N4lHquePq/vZRwsZmK7jveOtz/+I45lLAR8/zhzFQ3x9juCiyRv8NrsD79Y2toI1/Bj+YwRfs1602E+Cv+3elE8u2nCpsLnbwuvCaVYre8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(2906002)(8676002)(478600001)(186003)(110136005)(54906003)(53546011)(7696005)(5660300002)(6506007)(33656002)(316002)(26005)(52536014)(9686003)(55016002)(76116006)(66446008)(64756008)(66476007)(66556008)(66946007)(4326008)(83380400001)(86362001)(8936002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: h3LNczxmFsj3dLpZTFWW85qvdUisP+LeqCfRs4Fm2A20LpAy0YOC1/NPPHtrIIeYOi9qTo9q9gOYWPcMOHQA9XDo0eo/G1qTvC1qN/QJrwcuY0Sltw0SMbvOgFCEyTaJXxsp5/3Qzwe4riTLQTlQR8t+f9e+DMEJwIOvr3HIF39Mh5mGjrDEBUbiB4ZKNwC9/pkNvYbDYe4H/7oWYez2ScISKnY3lo3hE9O+BNvJ5MnyWJ31N5Wyombu4RikiAivlwB0doYbTI5s6bmL7wcT76i4sb9sX3mwg1tK6VP2tAWefd6OjhZQKE9HltMRaZzScn/czcTLpXBQXCdNeoCyY+v7Tb+KqRvacwGLusNSCBuJzKJ5/zB4yXCj8XSru9Q9fRARkCyzNnBg/7r37dhiVKAq/gjtXZCf5yKXRf7/R91qBlwkXb03TDTtyS9HxIPVUBKxz9vd6FPOhZxSelaioZbTdlz0iqc6wM2/h9FYcoH1A06udW5Oe7Pvurrpllx0vqMUpnkF93jJcngIXKulFHqriMP+D3l7wG+vPq+H23s+IlNT/pvKQvYN6yHIHIfZ+ML549Y/PaROB8bi1kGaPrnnnIQaReDewbsbOsL8fbvjHXXAMrfBAxjpzPTIU+GIYwSW+t4zywghWNxobTlp+Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2685ecc4-b9df-436a-e468-08d84b242a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 07:29:56.7387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mV86XccZtALugbaBGcpf9F4pSfSKZmgC17d28+Lq0pT4ISRKlwmP58lysdkuN6y2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Gu, JiaWei \(Will\)" <JiaWei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Please don't change those code unless you have a full stress test and a solid reason (what bug fixed or what new feature introduced )

Otherwise if it's a pure personal refactor or cleanup it will be not necessary

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Das, Nirmoy <Nirmoy.Das@amd.com>
Sent: Thursday, August 27, 2020 11:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov

This patch removes some unwanted code duplication and simplifies sriov's ip block reinit logic.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 117 +++++++++++----------
 1 file changed, 60 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 696a61cc3ac6..0db6db03bcd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2587,77 +2587,80 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 return r;
 }

-static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
+/** amdgpu_device_is_early_ip_block_sriov - check for early ip_blocks
+ *
+ * @ip_block: ip block that need to be check
+ *
+ * Returns a tri-state value for a given ip block.
+ * If an ip block requires early reinit sriov then return 1 or 0 otherwise.
+ * Return -1 on invalid ip block.
+ *
+ */
+
+static int
+amdgpu_device_is_early_ip_block_sriov(const enum amd_ip_block_type
+ip_block)
 {
-int i, r;
+switch (ip_block) {
+/* early ip blocks */
+case AMD_IP_BLOCK_TYPE_GMC:
+case AMD_IP_BLOCK_TYPE_COMMON:
+case AMD_IP_BLOCK_TYPE_PSP:
+case AMD_IP_BLOCK_TYPE_IH:
+return 1;
+/* late ip blocks */
+case AMD_IP_BLOCK_TYPE_SMC:
+case AMD_IP_BLOCK_TYPE_DCE:
+case AMD_IP_BLOCK_TYPE_GFX:
+case AMD_IP_BLOCK_TYPE_SDMA:
+case AMD_IP_BLOCK_TYPE_UVD:
+case AMD_IP_BLOCK_TYPE_VCE:
+case AMD_IP_BLOCK_TYPE_VCN:
+return 0;
+/* invalid ip block */
+default:
+return -1;
+}
+}

-static enum amd_ip_block_type ip_order[] = {
-AMD_IP_BLOCK_TYPE_GMC,
-AMD_IP_BLOCK_TYPE_COMMON,
-AMD_IP_BLOCK_TYPE_PSP,
-AMD_IP_BLOCK_TYPE_IH,
-};
+static int amdgpu_device_ip_reinit_sriov(struct amdgpu_device *adev,
+ const int is_early)
+{
+int i;

 for (i = 0; i < adev->num_ip_blocks; i++) {
-int j;
+int r = 0;
+bool init_ip;
 struct amdgpu_ip_block *block;
+enum amd_ip_block_type ip_block;

 block = &adev->ip_blocks[i];
 block->status.hw = false;
+ip_block = block->version->type;
+init_ip = (is_early ==
+   amdgpu_device_is_early_ip_block_sriov(ip_block));

-for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
-
-if (block->version->type != ip_order[j] ||
-!block->status.valid)
-continue;
+if (!init_ip ||
+    (!is_early && block->status.hw) ||
+    !block->status.valid)
+continue;

-r = block->version->funcs->hw_init(adev);
-DRM_INFO("RE-INIT-early: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
-if (r)
-return r;
-block->status.hw = true;
+if (init_ip && (ip_block == AMD_IP_BLOCK_TYPE_SMC)) {
+r = block->version->funcs->resume(adev);
+goto show_log;
 }
-}
-
-return 0;
-}

-static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev) -{
-int i, r;
-
-static enum amd_ip_block_type ip_order[] = {
-AMD_IP_BLOCK_TYPE_SMC,
-AMD_IP_BLOCK_TYPE_DCE,
-AMD_IP_BLOCK_TYPE_GFX,
-AMD_IP_BLOCK_TYPE_SDMA,
-AMD_IP_BLOCK_TYPE_UVD,
-AMD_IP_BLOCK_TYPE_VCE,
-AMD_IP_BLOCK_TYPE_VCN
-};
-
-for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
-int j;
-struct amdgpu_ip_block *block;
+if (init_ip)
+r = block->version->funcs->hw_init(adev);

-for (j = 0; j < adev->num_ip_blocks; j++) {
-block = &adev->ip_blocks[j];
+show_log:
+DRM_INFO("RE-INIT-%s: %s %s\n", is_early ? "early":"late",
+ block->version->funcs->name, r ? "failed":"succeeded");

-if (block->version->type != ip_order[i] ||
-!block->status.valid ||
-block->status.hw)
-continue;
+if (r)
+return r;

-if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
-r = block->version->funcs->resume(adev);
-else
-r = block->version->funcs->hw_init(adev);
+block->status.hw = true;

-DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
-if (r)
-return r;
-block->status.hw = true;
-}
 }

 return 0;
@@ -3901,7 +3904,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 amdgpu_amdkfd_pre_reset(adev);

 /* Resume IP prior to SMC */
-r = amdgpu_device_ip_reinit_early_sriov(adev);
+r = amdgpu_device_ip_reinit_sriov(adev, 1);
 if (r)
 goto error;

@@ -3914,7 +3917,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 return r;

 /* now we are okay to resume SMC/CP/SDMA */
-r = amdgpu_device_ip_reinit_late_sriov(adev);
+r = amdgpu_device_ip_reinit_sriov(adev, 0);
 if (r)
 goto error;

--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
