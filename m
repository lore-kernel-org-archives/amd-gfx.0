Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7FEC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 05:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0996122D58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 05:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0996122D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4C789B5F;
	Wed, 13 Jan 2021 05:45:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C3989B5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 05:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QErNg6vpSoBvGMrNHvlzmiH/uMF0FVteVJ7Go9auIYyXEkCd74xgXgtOOI9Rew6evItvzHOQzKp709BcuHa6SskSnQ7IK7spRNe0jKs0dZke19OzCxjPSYr9BZNtUl/UDqtURMlhBoH0ckBV8d5fobGne1TjOnH1iNw4EMqHsyDk72/Gv5PAq8Ka0K6hpcZD6ZJW/dTguygQqhiuii3ZzHqN3yupTf6S05QhlUTPOWL8LEZKmb/ZfvIKrHFtGpHSAW6dwYzv6iEcWhfeeiEDbzvhVOSWROYxHfHV/kNk50POhkC7uELi8oOJDCBG53Da7jiHNi8GuhCg4z5Ilkf1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOAD0Z4MfbUMe7c1ivP8Jv7AjeGPdg/DTcrQOfnLmmo=;
 b=oO0YjJbuu5agO/oBq4PUny77IXYkKYnY+1aJo6jux9/dfZwRWOCGJ5g847Y0N3aG/44Fe5Vt/oLjFd8JjjmUd3qUiuj+giSOHmh75QG97z0Z8vRoivxQle6DRtsvpFEmG++wqroJGULhhLX3jl0kATrqeVc2RiTtZEgScASnGHBfnhFV4V6PCTXkqG+8+NUU6v0Pw9WkunKzHnHHrRvPCq0Zw89ffkvXoVmW31gdMbdE6/GZRv1lGAXY1DAl4cjKJmyWYAUCKD2z/Pn4IUml5Ev4I/gAMS1LvAs1R2WnlRedd1R0ldieHzoFAOm/25rQRMINB60ocPwifgJAZWdhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOAD0Z4MfbUMe7c1ivP8Jv7AjeGPdg/DTcrQOfnLmmo=;
 b=UxbUZYHVqfQfZzl02R46TsCCG05c+9DB7Eu+Qbtw/LBAC283+O+BRA9c8DWDBOM4UkpaneZjie7VxRgXVu4g+whNpQjEOVXXjNF3EvKoxx9KqG7KVksrDHI7RJmDoa6I+qEL8/PjYCsZ7qNnbomo6AtHRLPxKvAFHcoAnwiHl20=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1157.namprd12.prod.outlook.com (2603:10b6:903:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 05:45:32 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:45:32 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add secure display TA interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add secure display TA interface
Thread-Index: AQHW6V5q1sJCXGwrP0uU05AzZCwkNaolCPDw
Date: Wed, 13 Jan 2021 05:45:31 +0000
Message-ID: <CY4PR12MB1287CBF4014E32D94DD3CCA3F1A90@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210113034354.14557-1-Jinzhou.Su@amd.com>
 <20210113034354.14557-2-Jinzhou.Su@amd.com>
In-Reply-To: <20210113034354.14557-2-Jinzhou.Su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-13T05:45:29Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4d0bb785-e791-4da3-bb5a-8ccb8d6cdd1f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d9a5c50-8828-4e5c-bece-08d8b786711a
x-ms-traffictypediagnostic: CY4PR12MB1157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB115782F114A0DDE8A4CD443AF1A90@CY4PR12MB1157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Su2yEMfahRkoVcX2gdg/U/W98m+UwekqbS+Fx3U30qZClsNFnt3XQQyNM/mUgavV+7lp7xA7tnkgBMbztodRShc1RfdP4PVIdIU+DZxI/xP+ZI7KMHn40kB0GrYe6S++3ztML+1Ufu8ainrn+GBLmawk0XpUzJMdXV6IxgMjZ6ECtRtuAVueB+bcixqLuEwphniw1gM+UsTZWwNY0fKdk+tYmwhQcKWurcj/MBFoNe5Yx+qdZB91mAcfATbtvJeNNmrooO4Mks5xOURZxUE70He85wLQKuvmJISp+6/PvLzUsUvmYNdcJKoGjZ/gwlF7WxptSgHxrjcVL/s/3AIs0ZaxCzX9TrlDU4bGUjhYJBa6qFHmix7Bxqb2IdMD9i23VAA9HNvmjSFnGny6FPXfBf/u890rcSr97QoyKCXzqlhtjloOWXGD/qf2AdX7oahZ/gakJVNktNnh3WZQQB1LKiAyDDD6qXajaDqXbf5MKZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(7696005)(52536014)(5660300002)(966005)(478600001)(30864003)(71200400001)(26005)(45080400002)(55016002)(8676002)(8936002)(33656002)(76116006)(186003)(4326008)(316002)(66446008)(86362001)(110136005)(66556008)(54906003)(64756008)(9686003)(53546011)(2906002)(66476007)(66946007)(6506007)(83380400001)(21314003)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?TmkvN1lJOGdHc1pJY3RtY2xJWGNMK0IwTmpjTmdvWnBYRk9lWk1pZktL?=
 =?iso-2022-jp?B?anZ4cW12YkpkVktMY2MvNUtGSWV0bXZOclRQODZiMVdvbW9KdjFTQTJm?=
 =?iso-2022-jp?B?MDFJSFRxanNhdFBrcXJwcDlWbzlpZVpBdEdienhxN0ZtQ2FIRjI5VXpO?=
 =?iso-2022-jp?B?TlpLaVIrUHpiVExDZXJuR2JiaGRhUFNudExzbW1rOTlqSDRKOFkxUG5i?=
 =?iso-2022-jp?B?eXFmdnB4VU5VYXNwWHRFakt4U3lyU2gxcEdYdW9hUVRMVVJpeW9OWStl?=
 =?iso-2022-jp?B?SVQvRmhmVEJjRUJjN0FJZFZVOUNkZDkxdEowU0dlQ1FEN1lWZDQ0dTdE?=
 =?iso-2022-jp?B?b1F2ZDJabFRmSlVGZ1JONXBrbEpyN1VUeU5sYnBlVyttM2MwdGJ1MTZz?=
 =?iso-2022-jp?B?L2ZjQW9pampBZldsWkRVSEpEQ0pYYTNoeUY0a0diTE82bEIrR1Zuck5u?=
 =?iso-2022-jp?B?aGh3NE5NL1ZGcWQ4SXg2SzhaNXNtRDNnbGR1TWZMblQyY2RwYjNXa3Rk?=
 =?iso-2022-jp?B?RDg4aEphZ2JDcU4zS3RyUFhYbWRTcXJvb3pSOFAwcWZHNmF4eHp4S0Nv?=
 =?iso-2022-jp?B?TGxyNVlCMW1acStObkpScTY2YkR2QVlqaU56ZmxrVXBNR1lVdTdmZmsy?=
 =?iso-2022-jp?B?Y3d2elZMSXE3V1JwL010VkU5Mmt5Z2wya2hJUjA1T3FuUHVhRmtxMmJJ?=
 =?iso-2022-jp?B?YTNvTCtsUGwySUd1UzQ0Rjl2SGpuSnl2eFkzeXVHSWFPRnhVVlM5czk1?=
 =?iso-2022-jp?B?WEJzaEdFZXZKdFlOR2V0TW9EdEVQdERRVjc4clE0Rys2WG44aXU5UFlF?=
 =?iso-2022-jp?B?Z0ZwNmY0NDM3WVVwN3VlUjBlaHRwSDh3VFNCaUFETGI0MzgzakgxRjAr?=
 =?iso-2022-jp?B?TnArcHdmUU1jUHYreVpYUmhWMkhaWng4cml3Y1IxQWNYOWYvK3RKK1dx?=
 =?iso-2022-jp?B?RC9kdVNSZmQwV08wYUhiSEVsYmlJQWlNSHlwZWQ0VU1yNkhGNS9hdlAr?=
 =?iso-2022-jp?B?cXZocWlEVVRUdloweVZ6Z3pQTVFYZzRZYXExM0hOUEFJS1ZSL1VHSWRE?=
 =?iso-2022-jp?B?dnd6MTJRb24rOGUyZU1sOWNiODZ2K1dFSjZWeWtNbTJCdmN4eGQwZ09I?=
 =?iso-2022-jp?B?RGY1NUlnRzNTZzhESlllOVRUci9TL29rUStJVzhEcERoaEpDeVBaeHVH?=
 =?iso-2022-jp?B?R3I5RlYwUWVyZ0tEM3JnVFc1ejZqeStvcWd2SHQzTEFZVUdkVHc2TnhI?=
 =?iso-2022-jp?B?TjRsdVZNc3RWRGtlRkF4ejdTOXNBV0NGNUlPcmF0Q0JBUzhFaUhnTkEv?=
 =?iso-2022-jp?B?TDRXMEtSL1B3K2xMQ01kVkRsOEw5LzRHUjVXekxBZDRUOS9XTmhONk1L?=
 =?iso-2022-jp?B?RjZDZnNhMkEwSENNZVphSjduTGxQaFE2WDlKWUI0ZUF2QTlCST0=?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9a5c50-8828-4e5c-bece-08d8b786711a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:45:31.9286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXTkEU5h5XRAaBcbuN5HDv6Y9aHjEhLY8lEDGh99mmSA4851Msv86Nb3BrALbfG/OsLVhXq6O2O4t4oQ46/YxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1157
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
Cc: "Su, Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

One comment from coding-style's perspective.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jinzhou Su
Sent: Wednesday, January 13, 2021 11:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add secure display TA interface

Add interface to load, unload, invoke command for secure display TA.

v2: Add debugfs interface for secure display TA

Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 195 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  17 ++
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 174 ++++++++++++++++  .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.h |  36 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  12 +-
 8 files changed, 440 insertions(+), 3 deletions(-)  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c6262689e14e..e4bebbfa88af 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -56,7 +56,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-	amdgpu_fw_attestation.o
+	amdgpu_fw_attestation.o amdgpu_securedisplay.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 477bead4fab1..4c38c5771cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -35,6 +35,7 @@
 #include "amdgpu_dm_debugfs.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_rap.h"
+#include "amdgpu_securedisplay.h"
 #include "amdgpu_fw_attestation.h"
 
 /**
@@ -1666,6 +1667,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	amdgpu_rap_debugfs_init(adev);
 
+	amdgpu_securedisplay_debugfs_init(adev);
+
 	amdgpu_fw_attestation_debugfs_init(adev);
 
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 523d22db094b..eb19ae734396 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -36,6 +36,7 @@
 #include "psp_v12_0.h"
 
 #include "amdgpu_ras.h"
+#include "amdgpu_securedisplay.h"
 
 static int psp_sysfs_init(struct amdgpu_device *adev);  static void psp_sysfs_fini(struct amdgpu_device *adev); @@ -1642,6 +1643,179 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  }  // RAP end
 
+/* securedisplay start */
+static int psp_securedisplay_init_shared_buf(struct psp_context *psp) {
+	int ret;
+
+	/*
+	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
+	 * physical) for sa ta <-> Driver
+	 */
+	ret = amdgpu_bo_create_kernel(psp->adev, PSP_SECUREDISPLAY_SHARED_MEM_SIZE,
+				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
+				      &psp->securedisplay_context.securedisplay_shared_bo,
+				      &psp->securedisplay_context.securedisplay_shared_mc_addr,
+				      &psp->securedisplay_context.securedisplay_shared_buf);
+
+	return ret;
+}
+
+static int psp_securedisplay_load(struct psp_context *psp) {
+	int ret;
+	struct psp_gfx_cmd_resp *cmd;
+
+	/*
+	 * TODO: bypass the loading in sriov for now
+	 */
[Guchun] Above comment is not needed, as this is guaranteed by psp_securedisplay_initialize.


+	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+	memcpy(psp->fw_pri_buf, psp->ta_securedisplay_start_addr, 
+psp->ta_securedisplay_ucode_size);
+
+	psp_prep_ta_load_cmd_buf(cmd,
+				 psp->fw_pri_mc_addr,
+				 psp->ta_securedisplay_ucode_size,
+				 psp->securedisplay_context.securedisplay_shared_mc_addr,
+				 PSP_SECUREDISPLAY_SHARED_MEM_SIZE);
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (ret)
+		goto failed;
+
+	psp->securedisplay_context.securedisplay_initialized = true;
+	psp->securedisplay_context.session_id = cmd->resp.session_id;
+	mutex_init(&psp->securedisplay_context.mutex);
+
+failed:
+	kfree(cmd);
+	return ret;
+}
+
+static int psp_securedisplay_unload(struct psp_context *psp) {
+	int ret;
+	struct psp_gfx_cmd_resp *cmd;
+
+	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	psp_prep_ta_unload_cmd_buf(cmd, 
+psp->securedisplay_context.session_id);
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	kfree(cmd);
+
+	return ret;
+}
+
+static int psp_securedisplay_initialize(struct psp_context *psp) {
+	int ret;
+	struct securedisplay_cmd *securedisplay_cmd;
+
+	/*
+	 * TODO: bypass the initialize in sriov for now
+	 */
+	if (amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+	if (!psp->adev->psp.ta_securedisplay_ucode_size ||
+	    !psp->adev->psp.ta_securedisplay_start_addr) {
+		dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta ucode is not available\n");
+		return 0;
+	}
+
+	if (!psp->securedisplay_context.securedisplay_initialized) {
+		ret = psp_securedisplay_init_shared_buf(psp);
+		if (ret)
+			return ret;
+	}
+
+	ret = psp_securedisplay_load(psp);
+	if (ret)
+		return ret;
+
+	psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
+			TA_SECUREDISPLAY_COMMAND__QUERY_TA);
+
+	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
+	if (ret) {
+		psp_securedisplay_unload(psp);
+
+		amdgpu_bo_free_kernel(&psp->securedisplay_context.securedisplay_shared_bo,
+			      &psp->securedisplay_context.securedisplay_shared_mc_addr,
+			      &psp->securedisplay_context.securedisplay_shared_buf);
+
+		psp->securedisplay_context.securedisplay_initialized = false;
+
+		dev_err(psp->adev->dev, "SECUREDISPLAY TA initialize fail.\n");
+		return -EINVAL;
+	}
+
+	if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS) {
+		psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
+		dev_err(psp->adev->dev, "SECUREDISPLAY: query securedisplay TA failed. ret 0x%x\n",
+			securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
+	}
+
+	return 0;
+}
+
+static int psp_securedisplay_terminate(struct psp_context *psp) {
+	int ret;
+
+	/*
+	 * TODO:bypass the terminate in sriov for now
+	 */
+	if (amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+	if (!psp->securedisplay_context.securedisplay_initialized)
+		return 0;
+
+	ret = psp_securedisplay_unload(psp);
+	if (ret)
+		return ret;
+
+	psp->securedisplay_context.securedisplay_initialized = false;
+
+	/* free securedisplay shared memory */
+	amdgpu_bo_free_kernel(&psp->securedisplay_context.securedisplay_shared_bo,
+			      &psp->securedisplay_context.securedisplay_shared_mc_addr,
+			      &psp->securedisplay_context.securedisplay_shared_buf);
+
+	return ret;
+}
+
+int psp_securedisplay_invoke(struct psp_context *psp, uint32_t 
+ta_cmd_id) {
+	int ret;
+
+	if (!psp->securedisplay_context.securedisplay_initialized)
+		return -EINVAL;
+
+	if (ta_cmd_id != TA_SECUREDISPLAY_COMMAND__QUERY_TA &&
+	    ta_cmd_id != TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC)
+		return -EINVAL;
+
+	mutex_lock(&psp->securedisplay_context.mutex);
+
+	ret = psp_ta_invoke(psp, ta_cmd_id, 
+psp->securedisplay_context.session_id);
+
+	mutex_unlock(&psp->securedisplay_context.mutex);
+
+	return ret;
+}
+/* SECUREDISPLAY end */
+
 static int psp_hw_start(struct psp_context *psp)  {
 	struct amdgpu_device *adev = psp->adev; @@ -2116,6 +2290,11 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		if (ret)
 			dev_err(psp->adev->dev,
 				"RAP: Failed to initialize RAP\n");
+
+		ret = psp_securedisplay_initialize(psp);
+		if (ret)
+			dev_err(psp->adev->dev,
+				"SECUREDISPLAY: Failed to initialize SECUREDISPLAY\n");
 	}
 
 	return 0;
@@ -2166,6 +2345,7 @@ static int psp_hw_fini(void *handle)
 
 	if (psp->adev->psp.ta_fw) {
 		psp_ras_terminate(psp);
+		psp_securedisplay_terminate(psp);
 		psp_rap_terminate(psp);
 		psp_dtm_terminate(psp);
 		psp_hdcp_terminate(psp);
@@ -2230,6 +2410,11 @@ static int psp_suspend(void *handle)
 			DRM_ERROR("Failed to terminate rap ta\n");
 			return ret;
 		}
+		ret = psp_securedisplay_terminate(psp);
+		if (ret) {
+			DRM_ERROR("Failed to terminate securedisplay ta\n");
+			return ret;
+		}
 	}
 
 	ret = psp_asd_unload(psp);
@@ -2313,6 +2498,11 @@ static int psp_resume(void *handle)
 		if (ret)
 			dev_err(psp->adev->dev,
 				"RAP: Failed to initialize RAP\n");
+
+		ret = psp_securedisplay_initialize(psp);
+		if (ret)
+			dev_err(psp->adev->dev,
+				"SECUREDISPLAY: Failed to initialize SECUREDISPLAY\n");
 	}
 
 	mutex_unlock(&adev->firmware.mutex);
@@ -2620,6 +2810,11 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 		psp->ta_rap_ucode_size     = le32_to_cpu(desc->size_bytes);
 		psp->ta_rap_start_addr     = ucode_start_addr;
 		break;
+	case TA_FW_TYPE_PSP_SECUREDISPLAY:
+		psp->ta_securedisplay_ucode_version  = le32_to_cpu(desc->fw_version);
+		psp->ta_securedisplay_ucode_size     = le32_to_cpu(desc->size_bytes);
+		psp->ta_securedisplay_start_addr     = ucode_start_addr;
+		break;
 	default:
 		dev_warn(psp->adev->dev, "Unsupported TA type: %d\n", desc->fw_type);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index da250bc1ac57..cb50ba445f8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -30,6 +30,7 @@
 #include "ta_xgmi_if.h"
 #include "ta_ras_if.h"
 #include "ta_rap_if.h"
+#include "ta_secureDisplay_if.h"
 
 #define PSP_FENCE_BUFFER_SIZE	0x1000
 #define PSP_CMD_BUFFER_SIZE	0x1000
@@ -40,6 +41,7 @@
 #define PSP_HDCP_SHARED_MEM_SIZE	0x4000
 #define PSP_DTM_SHARED_MEM_SIZE	0x4000
 #define PSP_RAP_SHARED_MEM_SIZE	0x4000
+#define PSP_SECUREDISPLAY_SHARED_MEM_SIZE	0x4000
 #define PSP_SHARED_MEM_SIZE		0x4000
 #define PSP_FW_NAME_LEN		0x24
 
@@ -171,6 +173,15 @@ struct psp_rap_context {
 	struct mutex		mutex;
 };
 
+struct psp_securedisplay_context {
+	bool			securedisplay_initialized;
+	uint32_t		session_id;
+	struct amdgpu_bo	*securedisplay_shared_bo;
+	uint64_t		securedisplay_shared_mc_addr;
+	void			*securedisplay_shared_buf;
+	struct mutex		mutex;
+};
+
 #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
 #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES	0x1000
 #define GDDR6_MEM_TRAINING_OFFSET		0x8000
@@ -298,12 +309,17 @@ struct psp_context
 	uint32_t			ta_rap_ucode_size;
 	uint8_t				*ta_rap_start_addr;
 
+	uint32_t			ta_securedisplay_ucode_version;
+	uint32_t			ta_securedisplay_ucode_size;
+	uint8_t				*ta_securedisplay_start_addr;
+
 	struct psp_asd_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
 	struct psp_ras_context		ras;
 	struct psp_hdcp_context 	hdcp_context;
 	struct psp_dtm_context		dtm_context;
 	struct psp_rap_context		rap_context;
+	struct psp_securedisplay_context	securedisplay_context;
 	struct mutex			mutex;
 	struct psp_memory_training_context mem_train_ctx;  }; @@ -380,6 +396,7 @@ int psp_ras_trigger_error(struct psp_context *psp,  int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);  int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);  int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
+int psp_securedisplay_invoke(struct psp_context *psp, uint32_t 
+ta_cmd_id);
 
 int psp_rlc_autoload_start(struct psp_context *psp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
new file mode 100644
index 000000000000..455978781380
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ *
+ */
+#include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
+
+#include "amdgpu.h"
+#include "amdgpu_securedisplay.h"
+
+/**
+ * DOC: AMDGPU SECUREDISPLAY debugfs test interface
+ *
+ * how to use?
+ * echo opcode <value> > <debugfs_dir>/dri/xxx/securedisplay_test
+ * eg. echo 1 > <debugfs_dir>/dri/xxx/securedisplay_test
+ * eg. echo 2 phy_id > <debugfs_dir>/dri/xxx/securedisplay_test
+ *
+ * opcode:
+ * 1：Query whether TA is responding used only for validation pupose
+ * 2: Send region of Interest and CRC value to I2C. (uint32)phy_id is
+ * send to determine which DIO scratch register should be used to get
+ * ROI and receive i2c_buf as the output.
+ *
+ * You can refer more detail from header file ta_securedisplay_if.h
+ *
+ */
+
+void psp_securedisplay_parse_resp_status(struct psp_context *psp,
+	enum ta_securedisplay_status status)
+{
+	switch (status) {
+	case TA_SECUREDISPLAY_STATUS__SUCCESS:
+		break;
+	case TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE:
+		dev_err(psp->adev->dev, "Secure display: Generic Failure.");
+		break;
+	case TA_SECUREDISPLAY_STATUS__INVALID_PARAMETER:
+		dev_err(psp->adev->dev, "Secure display: Invalid Parameter.");
+		break;
+	case TA_SECUREDISPLAY_STATUS__NULL_POINTER:
+		dev_err(psp->adev->dev, "Secure display: Null Pointer.");
+		break;
+	case TA_SECUREDISPLAY_STATUS__I2C_WRITE_ERROR:
+		dev_err(psp->adev->dev, "Secure display: Failed to write to I2C.");
+		break;
+	case TA_SECUREDISPLAY_STATUS__READ_DIO_SCRATCH_ERROR:
+		dev_err(psp->adev->dev, "Secure display: Failed to Read DIO Scratch Register.");
+		break;
+	case TA_SECUREDISPLAY_STATUS__READ_CRC_ERROR:
+		dev_err(psp->adev->dev, "Secure display: Failed to Read CRC");
+		break;
+	default:
+		dev_err(psp->adev->dev, "Secure display: Failed to parse status: %d\n", status);
+	}
+}
+
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedisplay_cmd **cmd,
+	enum ta_securedisplay_command command_id) {
+	*cmd = (struct securedisplay_cmd *)psp->securedisplay_context.securedisplay_shared_buf;
+	memset(*cmd, 0, sizeof(struct securedisplay_cmd));
+	(*cmd)->status = TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE;
+	(*cmd)->cmd_id = command_id;
+}
+
+static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __user *buf,
+		size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct psp_context *psp = &adev->psp;
+	struct securedisplay_cmd *securedisplay_cmd;
+	struct drm_device *dev = adev_to_drm(adev);
+	uint32_t phy_id;
+	uint32_t op;
+	int i;
+	char str[64];
+	char i2c_output[256];
+	int ret;
+
+	if (*pos || size > sizeof(str) - 1)
+		return -EINVAL;
+
+	memset(str,  0, sizeof(str));
+	copy_from_user(str, buf, size);
+
+	ret = pm_runtime_get_sync(dev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
+		return ret;
+	}
+
+	if (size < 3)
+		sscanf(str, "%u ", &op);
+	else
+		sscanf(str, "%u %u", &op, &phy_id);
+
+	switch (op) {
+	case 1:
+		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
+			TA_SECUREDISPLAY_COMMAND__QUERY_TA);
+		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
+		if (!ret) {
+			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS)
+				dev_info(adev->dev, "SECUREDISPLAY: query securedisplay TA ret is 0x%X\n",
+					securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
+			else
+				psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
+		}
+		break;
+	case 2:
+		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
+			TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
+		securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id = phy_id;
+		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
+		if (!ret) {
+			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
+				memset(i2c_output,  0, sizeof(i2c_output));
+				for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
+					sprintf(i2c_output, "%s 0x%X", i2c_output,
+						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
+				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
+			} else {
+				psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
+			}
+		}
+		break;
+	default:
+		dev_err(adev->dev, "Invalid input: %s\n", str);
+	}
+
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	return size;
+}
+
+static const struct file_operations amdgpu_securedisplay_debugfs_ops = {
+	.owner = THIS_MODULE,
+	.read = NULL,
+	.write = amdgpu_securedisplay_debugfs_write,
+	.llseek = default_llseek
+};
+
+void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev) { 
+#if defined(CONFIG_DEBUG_FS)
+
+	if (!adev->psp.securedisplay_context.securedisplay_initialized)
+		return;
+
+	debugfs_create_file("securedisplay_test", S_IWUSR, adev_to_drm(adev)->primary->debugfs_root,
+				adev, &amdgpu_securedisplay_debugfs_ops);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
new file mode 100644
index 000000000000..983446c72520
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ *
+ */
+#ifndef _AMDGPU_SECUREDISPLAY_H
+#define _AMDGPU_SECUREDISPLAY_H
+
+#include "amdgpu.h"
+#include "ta_secureDisplay_if.h"
+
+void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev); 
+void psp_securedisplay_parse_resp_status(struct psp_context *psp,
+		enum ta_securedisplay_status status); void 
+psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedisplay_cmd **cmd,
+		enum ta_securedisplay_command command_id);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 0e43b46d3ab5..46449e70348b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -122,6 +122,9 @@ struct ta_firmware_header_v1_0 {
 	uint32_t ta_dtm_ucode_version;
 	uint32_t ta_dtm_offset_bytes;
 	uint32_t ta_dtm_size_bytes;
+	uint32_t ta_securedisplay_ucode_version;
+	uint32_t ta_securedisplay_offset_bytes;
+	uint32_t ta_securedisplay_size_bytes;
 };
 
 enum ta_fw_type {
@@ -132,6 +135,7 @@ enum ta_fw_type {
 	TA_FW_TYPE_PSP_HDCP,
 	TA_FW_TYPE_PSP_DTM,
 	TA_FW_TYPE_PSP_RAP,
+	TA_FW_TYPE_PSP_SECUREDISPLAY,
 };
 
 struct ta_fw_bin_desc {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index d7f92634eba2..4b1cc5e9ee92 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -92,8 +92,6 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 			(uint8_t *)ta_hdr +
 			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 
-		adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
-
 		adev->psp.ta_dtm_ucode_version =
 			le32_to_cpu(ta_hdr->ta_dtm_ucode_version);
 		adev->psp.ta_dtm_ucode_size =
@@ -101,6 +99,16 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 		adev->psp.ta_dtm_start_addr =
 			(uint8_t *)adev->psp.ta_hdcp_start_addr +
 			le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
+
+		adev->psp.ta_securedisplay_ucode_version =
+			le32_to_cpu(ta_hdr->ta_securedisplay_ucode_version);
+		adev->psp.ta_securedisplay_ucode_size =
+			le32_to_cpu(ta_hdr->ta_securedisplay_size_bytes);
+		adev->psp.ta_securedisplay_start_addr =
+			(uint8_t *)adev->psp.ta_hdcp_start_addr +
+			le32_to_cpu(ta_hdr->ta_securedisplay_offset_bytes);
+
+		adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
 	}
 
 	return 0;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C105d330e2a9f417d324408d8b775887e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637461062775011351%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2LyTLuKVDdzQ0Dk3EOsEpgfmcl4vbr1CmxXsoe7O%2F%2Bo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
