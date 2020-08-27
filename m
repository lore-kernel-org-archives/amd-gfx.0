Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF1C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7376F22B47
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NtDRwqqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7376F22B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31806E491;
	Thu, 27 Aug 2020 08:22:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DAD6E484
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 08:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpd1nd9T10VCPGAJ2lJ34KRg7e/32a8GItI6hMZKIr3jKLdvUwy2Xo2H0t0KtmC5oD1j8bOoz4BEXzlhF39RnSVjhXQ+xnAwcIhBkUaOHHiy+9mOc0H/B3MprB3Ecw0c5NMV78vedK97PZ90RPpxeonxH4WvmHoscc8irpPMyzpdvKrszGjygNTKY1ouhvqrcnjaNsm1du3ICLtN3HTEbRk6RlkcAfF/KMTM/eep3lpbKaAUExJGqW1YMDAEnfXjb9gNkRt1y8ZYnkAkCBzBKJkA8pF1K9/3uiLPWfvuIS0PapiS/6zovZQjKUicdtvL9plgOO7r/WFBDL/G3OtIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HR7DDHYVGlz/XW9IOe4w5tyJPQfzaqS8eaPmz5a+ic=;
 b=Kj2334YiImGR0V+FTupZCxFnFJUepJNBfIhatbTAUqOQMFYjOrpkZwKAZmnn8ULIJTAhsc7Ycs/gLZNeN1fqMdZJOpZgHM76eL9RttpwzQ/1qWEL4TzP+3M5G+rmPXh0OpoxYR1UMP3xRt0+yOfplnisYHu1Hwqx8YQ5mTHMvl9aLDxVQSnV4wb6JohQwyx5mpVnUVgam5JR3TJrINjaQP/we8oJlgfif70IVG3UHewzUIKW20hs8yvBvpV1KyjA/Bp9BnuNMUBL+GzLzw2xMGqgKVXvhpO43NqZKU7WEP41N5WUHHda/9mwkikjiYfftG391G5rsIcKnECRiw7mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HR7DDHYVGlz/XW9IOe4w5tyJPQfzaqS8eaPmz5a+ic=;
 b=NtDRwqqDNIm2jGuxz2j8BCi8aZSoiyfAVIpnm/sKrhFkgws/UFL9VOt6sMS90Q62TH21FZEEsUf6ouxsO1c3waE2Ffk8eFOA1ZHOK4ciE/avQcQKNT85JOdDmIx2q2XkDGscDXZuxeEpYgRL0bnFmeyr4nGP8nSWwCuYbdnPlNI=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 08:22:15 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 08:22:15 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-220451 - Query guest's information by VF2PF message
 - Guest side - part 1
Thread-Topic: [PATCH] SWDEV-220451 - Query guest's information by VF2PF
 message - Guest side - part 1
Thread-Index: AQHWaz2c8XNFNnDZPkSxllhZFBFfaalLv8ng
Date: Thu, 27 Aug 2020 08:22:15 +0000
Message-ID: <DM5PR12MB1708618BAD0E110CBC82AFC784550@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200805153222.33202-1-Bokun.Zhang@amd.com>
In-Reply-To: <20200805153222.33202-1-Bokun.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=38e111e7-40f6-448e-b483-0000ce6e8950;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-27T08:22:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00cf6d8d-6929-4685-00d9-08d84a624e5f
x-ms-traffictypediagnostic: DM5PR12MB1164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB116424B5AE87B853A12025D384550@DM5PR12MB1164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxSddPMTMsbtZjMy2V5Yb/XIVHn6j/cm3bywr5LC5t0gjSD4haNEte7WgwSdUv3UaXxi/yLw1ir56sGu47iBBNinBlFcY1/9KmUwPaQwqfPaDkMR9r/Xi+vkwctV1KSJ+vVM/dpU2eP7uIRT+aDXyGMSlICM5EwolvuxitX0SaIGxyvpNZ1q0hczpnGTZgrwdAItOR4ijypCreIr2CKcujEL9Qi925qNRM633SavzIqldV64VxKWajB6qDR8fOEylEFau8DNa2Iw7e8gzs9V7yT+LdgUtPx4kIs9xQBeLIE+2ibDfu6T2U6AJ+1k9kLaRmNkZcgSNRDL7Ssa45stQx2UsPoLy5WYy2ZJE7BLAlA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(30864003)(5660300002)(52536014)(7696005)(15650500001)(53546011)(26005)(86362001)(45080400002)(6506007)(186003)(8936002)(8676002)(66556008)(66446008)(71200400001)(66476007)(64756008)(316002)(966005)(110136005)(76116006)(66946007)(2906002)(478600001)(33656002)(83380400001)(55016002)(9686003)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +3lUWqKokuG4qZWJPEO7zxoIJwE4z5E01M29/wIrhtfDikMe7yfSoxjQzSZc37ZSN5aQ1oG2B/j1ee606oELOxjnnsES2gsRdoI/ITMz9he7cPyDQve29GedJu+eDRn5EpOdPYEIiexIMxRbtflmyQZK2JPh4yCqFcp7+NBoNf+ApzznNONgb9oTDfg/uLmk215UbTWXTgqwIMMaItFkI6L8vgvqNrbHWg+4rC8Vkeh26blnxfymak4pl31GQD9Bp7j9Ipa+ZtKM4KS4lCXh3TI4jK3k6xXm4rpIXA7QVKtkc5nZ4sT02gjNuIwOFKZRyEys3h6fNIGB08eBEiyhqod7SOSi092C10Vr6KDDniQc5kePVy1PSu3p4OoAoh6Gt49CcBQ9Mv50y9WTUtfnWnD1MNxpZDq0wDjynHfSwy9DgqBkd3Ev/i3+aKXHKqwgB7fP6f53GLMzI0HtjUIBTkRIbTZ5V1qq4E8fXQafk8p0Em2C3fHabaDUM/8WxiVdl1hs+Wv7c27oKnhpaSXXoxBtwYy+uyc5/1YGm4PSQxEgfHI2MrCVcKtkEjyHqJ0JL5epbiG34VyTCsg+NsWth2fBX0OgGj8XF5YYnaR45WJiGPAOx9zp27krwQMly6SouSwyEaE0XQ7qdL4NaZKrlg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cf6d8d-6929-4685-00d9-08d84a624e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 08:22:15.4284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGuEG5Mat+ZSXT3vCuhhgd/mZWBThj+yJ43gpN8U86KlCYmt7qjBIs4TnT72gOUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun Zhang
Sent: Wednesday, August 5, 2020 11:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] SWDEV-220451 - Query guest's information by VF2PF message - Guest side - part 1

- Add guest side change to support VF2PF message
- Fix coding style

Change-Id: I82e5518cb10ec0b19fecaba7e05b02f4b7f2b409
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  29 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 276 ++++++++++++++++++++
 2 files changed, 285 insertions(+), 20 deletions(-)  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b0b2bdc750df..ad2b2628ab67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -24,6 +24,8 @@
 #ifndef AMDGPU_VIRT_H
 #define AMDGPU_VIRT_H

+#include "amdgv_sriovmsg.h"
+
 #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is sr-iov ready */
 #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is enabled on this GPU */
 #define AMDGPU_SRIOV_CAPS_IS_VF        (1 << 2) /* this GPU is a virtual function */
@@ -69,7 +71,10 @@ struct amdgpu_virt_fw_reserve {
 struct amd_sriov_msg_vf2pf_info_header *p_vf2pf;
 unsigned int checksum_key;
 };
+
 /*
+ * Legacy GIM header
+ *
  * Defination between PF and VF
  * Structures forcibly aligned to 4 to keep the same style as PF.
  */
@@ -89,15 +94,7 @@ enum AMDGIM_FEATURE_FLAG {
 AMDGIM_FEATURE_HW_PERF_SIMULATION = (1 << 3),  };

-struct amd_sriov_msg_pf2vf_info_header {
-/* the total structure size in byte. */
-uint32_t size;
-/* version of this structure, written by the GIM */
-uint32_t version;
-/* reserved */
-uint32_t reserved[2];
-} __aligned(4);
-struct  amdgim_pf2vf_info_v1 {
+struct amdgim_pf2vf_info_v1 {
 /* header contains size and version */
 struct amd_sriov_msg_pf2vf_info_header header;
 /* max_width * max_height */
@@ -116,6 +113,7 @@ struct  amdgim_pf2vf_info_v1 {
 unsigned int checksum;
 } __aligned(4);

+/* TODO: below struct is duplicated to amd_sriov_msg_pf2vf_info */
 struct  amdgim_pf2vf_info_v2 {
 /* header contains size and version */
 struct amd_sriov_msg_pf2vf_info_header header; @@ -146,16 +144,6 @@ struct  amdgim_pf2vf_info_v2 {
 uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 0, 0, (9 + sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 3)];  } __aligned(4);

-
-struct amd_sriov_msg_vf2pf_info_header {
-/* the total structure size in byte. */
-uint32_t size;
-/*version of this structure, written by the guest */
-uint32_t version;
-/* reserved */
-uint32_t reserved[2];
-} __aligned(4);
-
 struct amdgim_vf2pf_info_v1 {
 /* header contains size and version */
 struct amd_sriov_msg_vf2pf_info_header header; @@ -217,8 +205,9 @@ struct amdgim_vf2pf_info_v2 {
 uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 64, 0, (12 + sizeof(struct amd_sriov_msg_vf2pf_info_header)/sizeof(uint32_t)), 0)];  } __aligned(4);

+/* TODO: below macro and typedef will cause compile error, need to
+remove */
 #define AMDGPU_FW_VRAM_VF2PF_VER 2
-typedef struct amdgim_vf2pf_info_v2 amdgim_vf2pf_info ;
+typedef struct amd_sriov_msg_vf2pf_info amdgim_vf2pf_info;

 #define AMDGPU_FW_VRAM_VF2PF_WRITE(adev, field, val) \
 do { \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
new file mode 100644
index 000000000000..5355827ed0ae
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -0,0 +1,276 @@
+/*
+ * Copyright 2018-2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef AMDGV_SRIOV_MSG__H_
+#define AMDGV_SRIOV_MSG__H_
+
+/* unit in kilobytes */
+#define AMD_SRIOV_MSG_VBIOS_OFFSET              0
+#define AMD_SRIOV_MSG_VBIOS_SIZE_KB             64
+#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB    AMD_SRIOV_MSG_VBIOS_SIZE_KB
+#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB      4
+
+/*
+ * layout
+ * 0           64KB        65KB        66KB
+ * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | ...
+ * |   64KB    |   1KB     |   1KB     |
+ */
+#define AMD_SRIOV_MSG_SIZE_KB                   1
+#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB
+#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
+#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
+
+/*
+ * PF2VF history log:
+ * v1 defined in amdgim
+ * v2 current
+ *
+ * VF2PF history log:
+ * v1 defined in amdgim
+ * v2 defined in amdgim
+ * v3 current
+ */
+#define AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER2
+#define AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER3
+
+#define AMD_SRIOV_MSG_RESERVE_UCODE24
+
+enum amd_sriov_ucode_engine_id {
+AMD_SRIOV_UCODE_ID_VCE = 0,
+AMD_SRIOV_UCODE_ID_UVD,
+AMD_SRIOV_UCODE_ID_MC,
+AMD_SRIOV_UCODE_ID_ME,
+AMD_SRIOV_UCODE_ID_PFP,
+AMD_SRIOV_UCODE_ID_CE,
+AMD_SRIOV_UCODE_ID_RLC,
+AMD_SRIOV_UCODE_ID_RLC_SRLC,
+AMD_SRIOV_UCODE_ID_RLC_SRLG,
+AMD_SRIOV_UCODE_ID_RLC_SRLS,
+AMD_SRIOV_UCODE_ID_MEC,
+AMD_SRIOV_UCODE_ID_MEC2,
+AMD_SRIOV_UCODE_ID_SOS,
+AMD_SRIOV_UCODE_ID_ASD,
+AMD_SRIOV_UCODE_ID_TA_RAS,
+AMD_SRIOV_UCODE_ID_TA_XGMI,
+AMD_SRIOV_UCODE_ID_SMC,
+AMD_SRIOV_UCODE_ID_SDMA,
+AMD_SRIOV_UCODE_ID_SDMA2,
+AMD_SRIOV_UCODE_ID_VCN,
+AMD_SRIOV_UCODE_ID_DMCU,
+AMD_SRIOV_UCODE_ID__MAX
+};
+
+#pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed
+
+union amd_sriov_msg_feature_flags {
+struct {
+uint32_t  error_log_collect  : 1;
+uint32_t  host_load_ucodes   : 1;
+uint32_t  host_flr_vramlost  : 1;
+uint32_t  mm_bw_management   : 1;
+uint32_t  pp_one_vf_mode     : 1;
+uint32_t  reserved           : 27;
+} flags;
+uint32_t      all;
+};
+
+union amd_sriov_msg_os_info {
+struct {
+uint32_t  windows            : 1;
+uint32_t  reserved           : 31;
+} info;
+uint32_t      all;
+};
+
+struct amd_sriov_msg_pf2vf_info_header {
+/* the total structure size in byte */
+uint32_t size;
+/* version of this structure, written by the HOST */
+uint32_t version;
+/* reserved */
+uint32_t reserved[2];
+};
+
+struct amd_sriov_msg_pf2vf_info {
+/* header contains size and version */
+struct amd_sriov_msg_pf2vf_info_header header;
+/* use private key from mailbox 2 to create checksum */
+uint32_t checksum;
+/* The features flags of the HOST driver supports */
+union amd_sriov_msg_feature_flags feature_flags;
+/* (max_width * max_height * fps) / (16 * 16) */
+uint32_t hevc_enc_max_mb_per_second;
+/* (max_width * max_height) / (16 * 16) */
+uint32_t hevc_enc_max_mb_per_frame;
+/* (max_width * max_height * fps) / (16 * 16) */
+uint32_t avc_enc_max_mb_per_second;
+/* (max_width * max_height) / (16 * 16) */
+uint32_t avc_enc_max_mb_per_frame;
+/* MEC FW position in BYTE from the start of VF visible frame buffer */
+uint64_t mecfw_offset;
+/* MEC FW size in BYTE */
+uint32_t mecfw_size;
+/* UVD FW position in BYTE from the start of VF visible frame buffer */
+uint64_t uvdfw_offset;
+/* UVD FW size in BYTE */
+uint32_t uvdfw_size;
+/* VCE FW position in BYTE from the start of VF visible frame buffer */
+uint64_t vcefw_offset;
+/* VCE FW size in BYTE */
+uint32_t vcefw_size;
+/* Bad pages block position in BYTE */
+uint32_t bp_block_offset_low;
+uint32_t bp_block_offset_high;
+/* Bad pages block size in BYTE */
+uint32_t bp_block_size;
+/* frequency for VF to update the VF2PF area in msec, 0 = manual */
+uint32_t vf2pf_update_interval_ms;
+/* identification in ROCm SMI */
+uint64_t uuid;
+uint32_t fcn_idx;
+/* reserved */
+uint32_t reserved[256-26];
+};
+
+struct amd_sriov_msg_vf2pf_info_header {
+/* the total structure size in byte */
+uint32_t size;
+/* version of this structure, written by the guest */
+uint32_t version;
+/* reserved */
+uint32_t reserved[2];
+};
+
+struct amd_sriov_msg_vf2pf_info {
+/* header contains size and version */
+struct amd_sriov_msg_vf2pf_info_header header;
+uint32_t checksum;
+/* driver version */
+uint8_t  driver_version[64];
+/* driver certification, 1=WHQL, 0=None */
+uint32_t driver_cert;
+/* guest OS type and version */
+union amd_sriov_msg_os_info os_info;
+/* guest fb information in the unit of MB */
+uint32_t fb_usage;
+/* guest gfx engine usage percentage */
+uint32_t gfx_usage;
+/* guest gfx engine health percentage */
+uint32_t gfx_health;
+/* guest compute engine usage percentage */
+uint32_t compute_usage;
+/* guest compute engine health percentage */
+uint32_t compute_health;
+/* guest avc engine usage percentage. 0xffff means N/A */
+uint32_t avc_enc_usage;
+/* guest avc engine health percentage. 0xffff means N/A */
+uint32_t avc_enc_health;
+/* guest hevc engine usage percentage. 0xffff means N/A */
+uint32_t hevc_enc_usage;
+/* guest hevc engine usage percentage. 0xffff means N/A */
+uint32_t hevc_enc_health;
+/* combined encode/decode usage */
+uint32_t encode_usage;
+uint32_t decode_usage;
+/* Version of PF2VF that VF understands */
+uint32_t pf2vf_version_required;
+/* additional FB usage */
+uint32_t fb_vis_usage;
+uint32_t fb_vis_size;
+uint32_t fb_size;
+/* guest ucode data, each one is 1.25 Dword */
+struct {
+uint8_t  id;
+uint32_t version;
+} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+
+/* reserved */
+uint32_t reserved[256-68];
+};
+
+/* mailbox message send from guest to host  */ enum
+amd_sriov_mailbox_request_message {
+MB_REQ_MSG_REQ_GPU_INIT_ACCESS = 1,
+MB_REQ_MSG_REL_GPU_INIT_ACCESS,
+MB_REQ_MSG_REQ_GPU_FINI_ACCESS,
+MB_REQ_MSG_REL_GPU_FINI_ACCESS,
+MB_REQ_MSG_REQ_GPU_RESET_ACCESS,
+MB_REQ_MSG_REQ_GPU_INIT_DATA,
+
+MB_REQ_MSG_LOG_VF_ERROR       = 200,
+};
+
+/* mailbox message send from host to guest  */ enum
+amd_sriov_mailbox_response_message {
+MB_RES_MSG_CLR_MSG_BUF = 0,
+MB_RES_MSG_READY_TO_ACCESS_GPU = 1,
+MB_RES_MSG_FLR_NOTIFICATION,
+MB_RES_MSG_FLR_NOTIFICATION_COMPLETION,
+MB_RES_MSG_SUCCESS,
+MB_RES_MSG_FAIL,
+MB_RES_MSG_QUERY_ALIVE,
+MB_RES_MSG_GPU_INIT_DATA_READY,
+
+MB_RES_MSG_TEXT_MESSAGE = 255
+};
+
+/* version data stored in MAILBOX_MSGBUF_RCV_DW1 for future expansion
+*/ enum amd_sriov_gpu_init_data_version {
+GPU_INIT_DATA_READY_V1 = 1,
+};
+
+#pragma pack(pop)// Restore previous packing option
+
+/* checksum function between host and guest */ unsigned int
+amd_sriov_msg_checksum(void *obj,
+unsigned long obj_size,
+unsigned int key,
+unsigned int checksum);
+
+/* assertion at compile time */
+#ifdef __linux__
+#define stringification(s) _stringification(s) #define
+_stringification(s) #s
+
+_Static_assert(
+sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
+"amd_sriov_msg_vf2pf_info must be "
+stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
+
+_Static_assert(
+sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
+"amd_sriov_msg_pf2vf_info must be "
+stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
+
+_Static_assert(
+AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
+"AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
+
+_Static_assert(
+AMD_SRIOV_MSG_RESERVE_UCODE > AMD_SRIOV_UCODE_ID__MAX,
+"AMD_SRIOV_MSG_RESERVE_UCODE must be bigger than
+AMD_SRIOV_UCODE_ID__MAX");
+
+#undef _stringification
+#undef stringification
+#endif
+
+#endif /* AMDGV_SRIOV_MSG__H_ */
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C778bf74d216749c425c108d83955ccc7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637322387970269123&amp;sdata=PNE%2BFc%2Bbpjn%2B9AaVVGkjF3nym60z82ZNtur1atgUBC8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
