Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CEAC47073
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 15:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F52A10E0D4;
	Sun,  7 Jan 2024 15:49:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3710B10E0D4
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 15:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHCRqfI2X95Vg1syxTJdgUEhgF0rH4htRdHAuSdO1VgCffCl31cARVsO/WuDmx72HVYinHcfCAnMZj/SV97MK4JmINBgA0gBjAdvb7f4ZrenilFjDc4KN95HEaZZ8atdwUqAcv0QMnNIQ4bIFgI4wmKsypkwsV9MOJ+qMFdBwapRl+q+4LV04/kUu16JomcugFEHio2vqSlmeencmXDehsz2aqWqdoDBInr5xS5YRZrDr+9/1ZDVAWlmCZjBeV/u1Kdld4H3ooAzCgNut4yOhOHioAbTJEAk1WW9n+x5C1kZ8A81yoOn5Hmm/lMeKU1LmFx+nTea8yv8kUGvel29jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLgNZcRmMBm85AvaGNubicBDXKu3gPm4Z8nTc/OOIMw=;
 b=URnYZGRTShwUfgo6I5tQ4sgeekTFUEteDb+gpEAhBvJWEAc4SP5iRg/gFnspSB2yqfWfYptwXX4LvXxmF5KWZN8RxCmMIoT8m6A7tuPwD+CtdnPqdLZeQejBwGxQTgJ3jBOPgxO9ldk62tUhqOsmlws1euiIS17FXKp1FGFocatT4lcD4p4nYQXPsMys++mVC7z1i+zv4XZoAfIoBpLAHJzSH+h+eWAhz7kHwoQLtV01MU802CSBE+9nxO3OBH4Smoe189MXpXat+67SmmYi0OE25vAEVRcfUJpm6EiiNwFnLAWDRoRKbGFzOIi/mn1bUGIXwsR47+Z1g3bBFeY05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLgNZcRmMBm85AvaGNubicBDXKu3gPm4Z8nTc/OOIMw=;
 b=KNgrFT8q16lBp7NoGceAE02e3S11wA7i8gtL8waeuEXvurX89aWsEe7i5rZZqsv+L7ODN7QcuwHFcWOX4Z0IA4WxbfBpXG3O0LaiQRpO0h6Nzpz7uKsZEH5GWVPvCjq/wptiE4H4WqDvpbuLNxSVUj/eS64Gn1e0h09jbHLLWr0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Sun, 7 Jan
 2024 15:49:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 15:49:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 01/12] drm/amdgpu: implement RAS ACA driver framework
Thread-Topic: [PATCH v2 01/12] drm/amdgpu: implement RAS ACA driver framework
Thread-Index: AQHaPwQUvZv1DqNUX0+hSXnll7oImbDOhBTw
Date: Sun, 7 Jan 2024 15:49:35 +0000
Message-ID: <BN9PR12MB52570A40B6D95BD7149FEC28FC642@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240104114858.3475783-1-kevinyang.wang@amd.com>
 <20240104114858.3475783-2-kevinyang.wang@amd.com>
In-Reply-To: <20240104114858.3475783-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f7654a93-b663-4330-b9d6-a429e62fa03b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-07T15:49:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5713:EE_
x-ms-office365-filtering-correlation-id: 0b54568c-0db9-4b79-fd3e-08dc0f983f4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Olx+DtG4gaK7Evh5riS1Rmjd5cFGDmMejlm+lJgeU3E+mP32CqKib1MkpxAGDCGVD7Q1K+O+HvJWq65GAsZ0SOTMqmtjWx9ZMqwsmV88G+tXc0bZ/v5VSXzSTBF0HMRbFoFHOJjnfpV+88bbPvv0I6W7tlxIn72O3WBpO0zQ/FhofjOGvMIN3I+sQFNEjsI3vLCwN2TiLSSRc6vjQskcmmDM0L26ibbPVNEqIWQ+SFq7QG8LJyykOFkUbCKo+kqFu/airxd/2vZcbe/8JieykP2vmZOpQKSOxxiiMwy883O8Nn9/qUvO0POGRBFna3c9TMSepu+hMQy0DJKgUdJNdKcIDeodan56A3A2zymQBHYAC7Ob2VlRFevLesk+teGNnzMbPiIE1GlMJre1wxHDa/TClZbcbqssgJoTLro9zDhIylO7ApxQ/cH8Sbvvvgds2N/M6DsN8svhBYejU4QNeFgceJV5SPEYFAaWMWgUx69F3BVjp+ucrINEdJflpjWDm5yYO2xT3myouJAegvxcffainscxDDyAqK1TbKVOObyM6CuBUMZKwELWEqgL2D7cbVm02eSfAXLYFenssC/vH/UCc/IxxLIJEe5Yf6fb53yMZ2yA6HvhJJxuZehAOW6ZvhEzrMXjTv4LFyVc2NrUfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(66899024)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(110136005)(54906003)(8676002)(8936002)(71200400001)(478600001)(86362001)(2906002)(30864003)(38070700009)(41300700001)(33656002)(4326008)(52536014)(5660300002)(83380400001)(26005)(55016003)(122000001)(38100700002)(6506007)(9686003)(7696005)(53546011)(21314003)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tr/vvxm9ZipU1dOkXmnxKkDiZRRU9cGNwHDEIoId8Oer9hdc8U5dnnXv/VTf?=
 =?us-ascii?Q?cbeM/IeweN+MDLxcY6Un6DPUA3xDwM83/zhcDxHqLkcfPLZLS268yhR03kTg?=
 =?us-ascii?Q?rhn43J1KjyE2dv+5mf9EzCttS543ZTjSgVcWScgU2qvv7E+No01w9L5zxFE4?=
 =?us-ascii?Q?tK/iOETNvtd6yRHm1mMK099X2iOxrRBzPw8uPEVxV4unq/FvRclzd2fumZ1v?=
 =?us-ascii?Q?MBjszKBXSLlwOIPnTGaNY5eI/gOcMVGOIBPIATTISWqU0ubhvd83QR8+jRMi?=
 =?us-ascii?Q?aMdtnm5UnGYPo32/JsvnMrl9YNJ6n6gs1wvQaN8agLtE2mxaveytTqvr+nkX?=
 =?us-ascii?Q?J5XEf6cPR4k9q4pHG674Xmu97qPDwdzYNPBtzFFYcV4ZlckDy3ennUYkzHvc?=
 =?us-ascii?Q?MJ4mTEn0LTXzEQqijBxTTQR3UIqZ9bk9U27m9R9YH7k6elTk/U2Kw0WrrBVK?=
 =?us-ascii?Q?G7xO2EzZgWlAz3J72tCdup6whwTXQy8V+nap0ezarCurupK6NdCkmLYmGNF8?=
 =?us-ascii?Q?Eih0LHOoak3eHHrXO1PNKWdipx8RJ9tiWa832VTUCg2vk5+vAyR7efhQp3Zu?=
 =?us-ascii?Q?JNklxss9e/GwrQTGu+i7TlSH2pFNdXZovlMokwFuQAJeHcHBpTQfd+onW1sl?=
 =?us-ascii?Q?YDTeS4ckiitGrLzL8tXBy91RvHli1Fdpuf/FHD6sb/G5jOMFsfeOvIgPu5Zo?=
 =?us-ascii?Q?dW1am3Np6mMypxOguzb0NYyJfqxR3AssZ+xsci7ctrE8ZBabq0/BiTIHra+6?=
 =?us-ascii?Q?oXrgwTvDKdYGnkpc3xD2Fq10w43rlVEXKUCcpRdAnMI7EMA8+6fVWBGvgAtz?=
 =?us-ascii?Q?yz374IxycRl30JAVcyERUxtHtzPuy3JLNimOeFb3DrSjHixh4xLLuuF/M0Lw?=
 =?us-ascii?Q?HR0v1Wz/LtjlSUwl6j3xOc04zsSeKM7NHIPiNzwodBSTFJpaMjskmSDbG2fm?=
 =?us-ascii?Q?ELHD/wujdmOXTIyxJoZ7dj6wpSCupTnio7Rw+wYXGEZycC8NYhDLqwY3Bu9O?=
 =?us-ascii?Q?BPlRM7PdP+Fc29AEEpvdGB9Ciozg5wYAzLA4c1xFJ8v4ecnbyG/D/VK81wze?=
 =?us-ascii?Q?KZ7daNCWzt3mJ0mC8OsvlLDiPi8prLWRwIyQD5NjdRmQT/AZgL4aEOWmnT/5?=
 =?us-ascii?Q?0LCnE3U95dYuM5G5/wf8AF9fnKCDDWBRdRQHDJxzHK84Atz1EaP2r1RgK4au?=
 =?us-ascii?Q?s4cdQMS8GJ5Rx3lnPT8IOp/Tal/4KsX085vUCjp0NL1JOU2BP+nJL2mbAdRA?=
 =?us-ascii?Q?5yzgfFb9cecxedEYeXDOR4V6Jeg9JoeVAbpDR1cyU7lJmmWr3fDLm6hv0XGf?=
 =?us-ascii?Q?1CPlnDxaBlFuFqFnJoQ+id9sFVYySNZiTHw93cfsccHUJymKM2ff3Y5UvD64?=
 =?us-ascii?Q?vrdoXfj4LgTjNQo5iGlowC0jWfvaMDzez4IwjfPYbAfi596YWomXH6yGut7M?=
 =?us-ascii?Q?YxaW+ptKYoJD6yhOuEResZILGD7LaHFzX4o9s/jmihXi6XQ7wOi9sIK9SuL1?=
 =?us-ascii?Q?c4AjrOgDhXBETG6px/aP4csSmO2KMYKKX3gE5Zdj6cKoR67E5o2YC7Atmsvf?=
 =?us-ascii?Q?LkbAzNhaQupMg5XEWHc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b54568c-0db9-4b79-fd3e-08dc0f983f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2024 15:49:35.0692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eT7aqO88yCKFcyzpoi0Xxxn97mv3xh7u5mTTtpcs4J6bqtwZqFkB6kSxoQDBSMk65dMQ97eg+YTkT9+g8rLBAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, January 4, 2024 19:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH v2 01/12] drm/amdgpu: implement RAS ACA driver framework

v1:
implement new RAS ACA driver code framework.

v2:
- rename aca_bank_set to aca_banks.
- rename aca_source_xxx to aca_handle_xxx

v3:
- Optimize some function implementation details. (from Hawking's suggestion=
)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c    | 665 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h    | 196 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
 6 files changed, 873 insertions(+), 1 deletion(-)  create mode 100644 driv=
ers/gpu/drm/amd/amdgpu/amdgpu_aca.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 260e32ef7bae..4c989da4d2f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amdgp=
u_kms.o \
        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
        amdgpu_fw_attestation.o amdgpu_securedisplay.o \
        amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o
+       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o

 amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 9da14436a373..eb182225f548 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_smuio.h"
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
+#include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
@@ -1047,6 +1048,9 @@ struct amdgpu_device {
        /* MCA */
        struct amdgpu_mca               mca;

+       /* ACA */
+       struct amdgpu_aca               aca;
+
        struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
        uint32_t                        harvest_ip_mask;
        int                             num_ip_blocks;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
new file mode 100644
index 000000000000..756b40bde38b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -0,0 +1,665 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include <linux/list.h>
+#include "amdgpu.h"
+#include "amdgpu_aca.h"
+#include "amdgpu_ras.h"
+
+#define ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWIP_TYPE_##type] =3D
+{hwid, mcatype}
+
+typedef int bank_handler_t(struct aca_handle *handle, struct aca_bank
+*bank, enum aca_error_type type, void *data);
+
+struct aca_banks {
+       int nr_banks;
+       struct list_head list;
+};
+
+struct aca_hwip {
+       int hwid;
+       int mcatype;
+};
+
+static struct aca_hwip aca_hwid_mcatypes[ACA_HWIP_TYPE_COUNT] =3D {
+       ACA_BANK_HWID(SMU,      0x01,   0x01),
+       ACA_BANK_HWID(PCS_XGMI, 0x50,   0x00),
+       ACA_BANK_HWID(UMC,      0x96,   0x00),
+};
+
+static void aca_banks_init(struct aca_banks *banks) {
+       if (!banks)
+               return;
+
+       memset(banks, 0, sizeof(*banks));
+       INIT_LIST_HEAD(&banks->list);
+}
+
+static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank
+*bank) {
+       struct aca_bank_node *node;
+
+       if (!bank)
+               return -EINVAL;
+
+       node =3D kvzalloc(sizeof(*node), GFP_KERNEL);
+       if (!node)
+               return -ENOMEM;
+
+       memcpy(&node->bank, bank, sizeof(*bank));
+
+       INIT_LIST_HEAD(&node->node);
+       list_add_tail(&node->node, &banks->list);
+
+       banks->nr_banks++;
+
+       return 0;
+}
+
+static void aca_banks_release(struct aca_banks *banks) {
+       struct aca_bank_node *node, *tmp;
+
+       list_for_each_entry_safe(node, tmp, &banks->list, node) {
+               list_del(&node->node);
+               kvfree(node);
+       }
+}
+
+static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum
+aca_error_type type, u32 *count) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
+
+       if (!count)
+               return -EINVAL;
+
+       if (!smu_funcs || !smu_funcs->get_valid_aca_count)
+               return -EOPNOTSUPP;
+
+       return smu_funcs->get_valid_aca_count(adev, type, count); }
+
+static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_error_type type,
+                                      int start, int count,
+                                      struct aca_banks *banks)
+{
+       struct amdgpu_aca *aca =3D &adev->aca;
+       const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
+       struct aca_bank bank;
+       int i, max_count, ret;
+
+       if (!count)
+               return 0;
+
+       if (!smu_funcs || !smu_funcs->get_valid_aca_bank)
+               return -EOPNOTSUPP;
+
+       switch (type) {
+       case ACA_ERROR_TYPE_UE:
+               max_count =3D smu_funcs->max_ue_bank_count;
+               break;
+       case ACA_ERROR_TYPE_CE:
+               max_count =3D smu_funcs->max_ce_bank_count;
+               break;
+       case ACA_ERROR_TYPE_DEFERRED:
+       default:
+               return -EINVAL;
+       }
+
+       if (start + count >=3D max_count)
+               return -EINVAL;
+
+       count =3D min_t(int, count, max_count);
+       for (i =3D 0; i < count; i++) {
+               memset(&bank, 0, sizeof(bank));
+               ret =3D smu_funcs->get_valid_aca_bank(adev, type, start + i=
, &bank);
+               if (ret)
+                       return ret;
+
+               ret =3D aca_banks_add_bank(banks, &bank);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum
+aca_hwip_type type) {
+
+       struct aca_hwip *hwip;
+       int hwid, mcatype;
+       u64 ipid;
+
+       if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNOW)
+               return -EINVAL;
+
+       hwip =3D &aca_hwid_mcatypes[type];
+       if (!hwip->hwid)
+               return false;
+
+       ipid =3D bank->regs[ACA_REG_IDX_IPID];
+       hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
+       mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
+
+       return hwip->hwid =3D=3D hwid && hwip->mcatype =3D=3D mcatype; }
+
+static bool aca_bank_is_valid(struct aca_handle *handle, struct
+aca_bank *bank, enum aca_error_type type) {
+       const struct aca_bank_ops *bank_ops =3D handle->bank_ops;
+
+       if (!aca_bank_hwip_is_matched(bank, handle->hwip))
+               return false;
+
+       if (!bank_ops->aca_bank_is_valid)
+               return true;
+
+       return bank_ops->aca_bank_is_valid(handle, bank, type, handle->data=
);
+}
+
+static struct aca_bank_error *new_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error;
+
+       bank_error =3D kvzalloc(sizeof(*bank_error), GFP_KERNEL);
+       if (!bank_error)
+               return NULL;
+
+       INIT_LIST_HEAD(&bank_error->node);
+       memcpy(&bank_error->info, info, sizeof(*info));
+
+       mutex_lock(&aerr->lock);
+       list_add_tail(&bank_error->node, &aerr->list);
+       mutex_unlock(&aerr->lock);
+
+       return bank_error;
+}
+
+static struct aca_bank_error *find_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error =3D NULL;
+       struct aca_bank_info *tmp_info;
+       bool found =3D false;
+
+       mutex_lock(&aerr->lock);
+       list_for_each_entry(bank_error, &aerr->list, node) {
+               tmp_info =3D &bank_error->info;
+               if (tmp_info->socket_id =3D=3D info->socket_id &&
+                   tmp_info->die_id =3D=3D info->die_id) {
+                       found =3D true;
+                       goto out_unlock;
+               }
+       }
+
+out_unlock:
+       mutex_unlock(&aerr->lock);
+
+       return found ? bank_error : NULL;
+}
+
+static void aca_bank_error_remove(struct aca_error *aerr, struct
+aca_bank_error *bank_error) {
+       if (!aerr || !bank_error)
+               return;
+
+       list_del(&bank_error->node);
+       aerr->nr_errors--;
+
+       kvfree(bank_error);
+}
+
+static struct aca_bank_error *get_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error;
+
+       if (!aerr || !info)
+               return NULL;
+
+       bank_error =3D find_bank_error(aerr, info);
+       if (bank_error)
+               return bank_error;
+
+       return new_bank_error(aerr, info);
+}
+
+static int aca_log_errors(struct aca_handle *handle, enum aca_error_type t=
ype,
+                               struct aca_bank_report *report)
+{
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       struct aca_bank_error *bank_error;
+       struct aca_error *aerr;
+
+       if (!handle || !report)
+               return -EINVAL;
+
+       if (!report->count)
+               return 0;
+
+       aerr =3D &error_cache->errors[type];
+       bank_error =3D get_bank_error(aerr, &report->info);
+       if (!bank_error)
+               return -ENOMEM;
+
+       bank_error->count +=3D report->count;
+
+       return 0;
+}
+
+static int aca_generate_bank_report(struct aca_handle *handle, struct aca_=
bank *bank,
+                                   enum aca_error_type type, struct aca_ba=
nk_report *report) {
+       const struct aca_bank_ops *bank_ops =3D handle->bank_ops;
+
+       if (!bank || !report)
+               return -EINVAL;
+
+       if (!bank_ops->aca_bank_generate_report)
+               return -EOPNOTSUPP;
+
+       memset(report, 0, sizeof(*report));
+       return bank_ops->aca_bank_generate_report(handle, bank, type,
+                                                 report, handle->data);
+}
+
+static int handler_aca_log_bank_error(struct aca_handle *handle, struct ac=
a_bank *bank,
+                                     enum aca_error_type type, void *data)=
 {
+       struct aca_bank_report report;
+       int ret;
+
+       ret =3D aca_generate_bank_report(handle, bank, type, &report);
+       if (ret)
+               return ret;
+
+       if (!report.count)
+               return 0;
+
+       ret =3D aca_log_errors(handle, type, &report);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+static int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_ba=
nk *bank,
+                            enum aca_error_type type, bank_handler_t handl=
er, void *data) {
+       struct aca_handle *handle;
+       int ret;
+
+       if (list_empty(&mgr->list))
+               return 0;
+
+       list_for_each_entry(handle, &mgr->list, node) {
+               if (!aca_bank_is_valid(handle, bank, type))
+                       continue;
+
+               ret =3D handler(handle, bank, type, data);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+static int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_b=
anks *banks,
+                             enum aca_error_type type, bank_handler_t hand=
ler, void *data)
+{
+       struct aca_bank_node *node;
+       struct aca_bank *bank;
+       int ret;
+
+       if (!mgr || !banks)
+               return -EINVAL;
+
+       /* pre check to avoid unnecessary operations */
+       if (list_empty(&mgr->list) || list_empty(&banks->list))
+               return 0;
+
+       list_for_each_entry(node, &banks->list, node) {
+               bank =3D &node->bank;
+
+               ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+static int aca_banks_update(struct amdgpu_device *adev, enum aca_error_typ=
e type,
+                           bank_handler_t handler, void *data) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       struct aca_banks banks;
+       u32 count =3D 0;
+       int ret;
+
+       if (list_empty(&aca->mgr.list))
+               return 0;
+
+       ret =3D aca_smu_get_valid_aca_count(adev, type, &count);
+       if (ret)
+               return ret;
+
+       if (!count)
+               return 0;
+
+       aca_banks_init(&banks);
+
+       ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks);
+       if (ret)
+               goto err_release_banks;
+
+       if (list_empty(&banks.list)) {
+               ret =3D 0;
+               goto err_release_banks;
+       }
+
+       ret =3D aca_dispatch_banks(&aca->mgr, &banks, type,
+                                handler, data);
+       if (ret)
+               goto err_release_banks;
+
+err_release_banks:
+       aca_banks_release(&banks);
+
+       return ret;
+}
+
+static int aca_log_aca_error_data(struct aca_bank_error *bank_error,
+enum aca_error_type type, struct ras_err_data *err_data) {
+       struct aca_bank_info *info;
+       struct amdgpu_smuio_mcm_config_info mcm_info;
+
+       if (!bank_error->count)
+               return 0;
+
+       info =3D &bank_error->info;
+       mcm_info.die_id =3D info->die_id;
+       mcm_info.socket_id =3D info->socket_id;
+
+       switch (type) {
+       case ACA_ERROR_TYPE_UE:
+               amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NU=
LL, bank_error->count);
+               break;
+       case ACA_ERROR_TYPE_CE:
+               amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NU=
LL, bank_error->count);
+               break;
+       case ACA_ERROR_TYPE_DEFERRED:
+       default:
+               break;
+       }
+
+       return 0;
+}
+
+static int aca_log_aca_error(struct aca_handle *handle, enum
+aca_error_type type, struct ras_err_data *err_data) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       struct aca_error *aerr =3D &error_cache->errors[type];
+       struct aca_bank_error *bank_error, *tmp;
+
+       mutex_lock(&aerr->lock);
+
+       if (list_empty(&aerr->list))
+               goto out_unlock;
+
+       list_for_each_entry_safe(bank_error, tmp, &aerr->list, node) {
+               aca_log_aca_error_data(bank_error, type, err_data);
+               aca_bank_error_remove(aerr, bank_error);
+       }
+
+out_unlock:
+       mutex_unlock(&aerr->lock);
+
+       return 0;
+}
+
+static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_han=
dle *handle, enum aca_error_type type,
+                               struct ras_err_data *err_data)
+{
+       int ret;
+
+       /* udpate aca bank to aca source error_cache first */
+       ret =3D aca_banks_update(adev, type, handler_aca_log_bank_error, NU=
LL);
+       if (ret)
+               return ret;
+
+       return aca_log_aca_error(handle, type, err_data); }
+
+static bool aca_handle_is_valid(struct aca_handle *handle) {
+       if (!handle->mask || !list_empty(&handle->node))
+               return false;
+
+       return true;
+}
+
+int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handl=
e *handle,
+                             enum aca_error_type type, void *data) {
+       struct ras_err_data *err_data =3D (struct ras_err_data *)data;
+
+       if (!handle || !err_data)
+               return -EINVAL;
+
+       if (aca_handle_is_valid(handle))
+               return -EOPNOTSUPP;
+
+       if (!(BIT(type) & handle->mask))
+               return  0;
+
+       return __aca_get_error_data(adev, handle, type, err_data); }
+
+static void aca_error_init(struct aca_error *aerr, enum aca_error_type
+type) {
+       mutex_init(&aerr->lock);
+       INIT_LIST_HEAD(&aerr->list);
+       aerr->type =3D type;
+       aerr->nr_errors =3D 0;
+}
+
+static void aca_init_error_cache(struct aca_handle *handle) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       int type;
+
+       for (type =3D ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type+=
+)
+               aca_error_init(&error_cache->errors[type], type); }
+
+static void aca_error_fini(struct aca_error *aerr) {
+       struct aca_bank_error *bank_error, *tmp;
+
+       mutex_lock(&aerr->lock);
+       list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
+               aca_bank_error_remove(aerr, bank_error);
+
+       mutex_destroy(&aerr->lock);
+}
+
+static void aca_fini_error_cache(struct aca_handle *handle) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       int type;
+
+       for (type =3D ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type+=
+)
+               aca_error_fini(&error_cache->errors[type]);
+}
+
+static int add_aca_handle(struct amdgpu_device *adev, struct aca_handle_ma=
nager *mgr, struct aca_handle *handle,
+                         const char *name, const struct aca_info *ras_info=
, void *data) {
+       memset(handle, 0, sizeof(*handle));
+
+       handle->adev =3D adev;
+       handle->mgr =3D mgr;
+       handle->name =3D name;
+       handle->hwip =3D ras_info->hwip;
+       handle->mask =3D ras_info->mask;
+       handle->bank_ops =3D ras_info->bank_ops;
+       handle->data =3D data;
+       aca_init_error_cache(handle);
+
+       INIT_LIST_HEAD(&handle->node);
+       list_add_tail(&handle->node, &mgr->list);
+       mgr->nr_handles++;
+
+       return 0;
+}
+
+int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                         const char *name, const struct aca_info *ras_info=
, void *data) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       return add_aca_handle(adev, &aca->mgr, handle, name, ras_info, data=
);
+}
+
+static void remove_aca(struct aca_handle *handle) {
+       struct aca_handle_manager *mgr =3D handle->mgr;
+
+       aca_fini_error_cache(handle);
+       list_del(&handle->node);
+       mgr->nr_handles--;
+}
+
+void amdgpu_aca_remove_handle(struct aca_handle *handle) {
+       if (!handle || list_empty(&handle->node))
+               return;
+
+       remove_aca(handle);
+}
+
+static int aca_manager_init(struct aca_handle_manager *mgr) {
+       INIT_LIST_HEAD(&mgr->list);
+       mgr->nr_handles =3D 0;
+
+       return 0;
+}
+
+static void aca_manager_fini(struct aca_handle_manager *mgr) {
+       struct aca_handle *handle, *tmp;
+
+       list_for_each_entry_safe(handle, tmp, &mgr->list, node)
+               remove_aca(handle);
+}
+
+int amdgpu_aca_init(struct amdgpu_device *adev) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       int ret;
+
+       ret =3D aca_manager_init(&aca->mgr);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+void amdgpu_aca_fini(struct amdgpu_device *adev) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       aca_manager_fini(&aca->mgr);
+}
+
+void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct
+aca_smu_funcs *smu_funcs) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       WARN_ON(aca->smu_funcs);
+       aca->smu_funcs =3D smu_funcs;
+}
+
+int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info
+*info) {
+       u64 ipid;
+       u32 instidhi, instidlo;
+
+       if (!bank || !info)
+               return -EINVAL;
+
+       ipid =3D bank->regs[ACA_REG_IDX_IPID];
+       info->hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
+       info->mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
+       /*
+        * Unfied DieID Format: SAASS. A:AID, S:Socket.
+        * Unfied DieID[4:4] =3D InstanceId[0:0]
+        * Unfied DieID[0:3] =3D InstanceIdHi[0:3]
+        */
+       instidhi =3D ACA_REG__IPID__INSTANCEIDHI(ipid);
+       instidlo =3D ACA_REG__IPID__INSTANCEIDLO(ipid);
+       info->die_id =3D ((instidhi >> 2) & 0x03);
+       info->socket_id =3D ((instidlo & 0x1) << 2) | (instidhi & 0x03);
+
+       return 0;
+}
+
+static int aca_bank_get_error_code(struct amdgpu_device *adev, struct
+aca_bank *bank) {
+       int error_code;
+
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+       case IP_VERSION(13, 0, 6):
+               if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D=
 0x00555600) {
+                       error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank=
->regs[ACA_REG_IDX_SYND]);
+                       return error_code & 0xff;
+               }
+               break;
+       default:
+               break;
+       }
+
+       /* NOTE: the true error code is encoded in status.errorcode[0:7] */
+       error_code =3D
+ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
+
+       return error_code & 0xff;
+}
+
+int aca_bank_check_error_codes(struct amdgpu_device *adev, struct
+aca_bank *bank, int *err_codes, int size) {
+       int i, error_code;
+
+       if (!bank || !err_codes)
+               return -EINVAL;
+
+       error_code =3D aca_bank_get_error_code(adev, bank);
+       for (i =3D 0; i < size; i++) {
+               if (err_codes[i] =3D=3D error_code)
+                       return 0;
+       }
+
+       return -EINVAL;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.h
new file mode 100644
index 000000000000..8cf520403548
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -0,0 +1,196 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_ACA_H__
+#define __AMDGPU_ACA_H__
+
+#include <linux/list.h>
+
+#define ACA_MAX_REGS_COUNT     (16)
+
+#define ACA_REG_FIELD(x, h, l)                 (((x) & GENMASK_ULL(h, l)) =
>> l)
+#define ACA_REG__STATUS__VAL(x)                        ACA_REG_FIELD(x, 63=
, 63)
+#define ACA_REG__STATUS__OVERFLOW(x)           ACA_REG_FIELD(x, 62, 62)
+#define ACA_REG__STATUS__UC(x)                 ACA_REG_FIELD(x, 61, 61)
+#define ACA_REG__STATUS__EN(x)                 ACA_REG_FIELD(x, 60, 60)
+#define ACA_REG__STATUS__MISCV(x)              ACA_REG_FIELD(x, 59, 59)
+#define ACA_REG__STATUS__ADDRV(x)              ACA_REG_FIELD(x, 58, 58)
+#define ACA_REG__STATUS__PCC(x)                        ACA_REG_FIELD(x, 57=
, 57)
+#define ACA_REG__STATUS__ERRCOREIDVAL(x)       ACA_REG_FIELD(x, 56, 56)
+#define ACA_REG__STATUS__TCC(x)                        ACA_REG_FIELD(x, 55=
, 55)
+#define ACA_REG__STATUS__SYNDV(x)              ACA_REG_FIELD(x, 53, 53)
+#define ACA_REG__STATUS__CECC(x)               ACA_REG_FIELD(x, 46, 46)
+#define ACA_REG__STATUS__UECC(x)               ACA_REG_FIELD(x, 45, 45)
+#define ACA_REG__STATUS__DEFERRED(x)           ACA_REG_FIELD(x, 44, 44)
+#define ACA_REG__STATUS__POISON(x)             ACA_REG_FIELD(x, 43, 43)
+#define ACA_REG__STATUS__SCRUB(x)              ACA_REG_FIELD(x, 40, 40)
+#define ACA_REG__STATUS__ERRCOREID(x)          ACA_REG_FIELD(x, 37, 32)
+#define ACA_REG__STATUS__ADDRLSB(x)            ACA_REG_FIELD(x, 29, 24)
+#define ACA_REG__STATUS__ERRORCODEEXT(x)       ACA_REG_FIELD(x, 21, 16)
+#define ACA_REG__STATUS__ERRORCODE(x)          ACA_REG_FIELD(x, 15, 0)
+
+#define ACA_REG__IPID__MCATYPE(x)              ACA_REG_FIELD(x, 63, 48)
+#define ACA_REG__IPID__INSTANCEIDHI(x)         ACA_REG_FIELD(x, 47, 44)
+#define ACA_REG__IPID__HARDWAREID(x)           ACA_REG_FIELD(x, 43, 32)
+#define ACA_REG__IPID__INSTANCEIDLO(x)         ACA_REG_FIELD(x, 31, 0)
+
+#define ACA_REG__MISC0__VALID(x)               ACA_REG_FIELD(x, 63, 63)
+#define ACA_REG__MISC0__OVRFLW(x)              ACA_REG_FIELD(x, 48, 48)
+#define ACA_REG__MISC0__ERRCNT(x)              ACA_REG_FIELD(x, 43, 32)
+
+#define ACA_REG__SYND__ERRORINFORMATION(x)     ACA_REG_FIELD(x, 17, 0)
+
+/* NOTE: The following codes refers to the smu header file */
+#define ACA_EXTERROR_CODE_CE                   0x3a
+#define ACA_EXTERROR_CODE_FAULT                        0x3b
+
+#define ACA_ERROR_UE_MASK              BIT_MASK(ACA_ERROR_TYPE_UE)
+#define ACA_ERROR_CE_MASK              BIT_MASK(ACA_ERROR_TYPE_CE)
+#define ACA_ERROR_DEFERRED_MASK                BIT_MASK(ACA_ERROR_TYPE_DEF=
ERRED)
+
+enum aca_reg_idx {
+       ACA_REG_IDX_CTL                 =3D 0,
+       ACA_REG_IDX_STATUS              =3D 1,
+       ACA_REG_IDX_ADDR                =3D 2,
+       ACA_REG_IDX_MISC0               =3D 3,
+       ACA_REG_IDX_CONFG               =3D 4,
+       ACA_REG_IDX_IPID                =3D 5,
+       ACA_REG_IDX_SYND                =3D 6,
+       ACA_REG_IDX_DESTAT              =3D 8,
+       ACA_REG_IDX_DEADDR              =3D 9,
+       ACA_REG_IDX_CTL_MASK            =3D 10,
+       ACA_REG_IDX_COUNT               =3D 16,
+};
+
+enum aca_hwip_type {
+       ACA_HWIP_TYPE_UNKNOW =3D -1,
+       ACA_HWIP_TYPE_PSP =3D 0,
+       ACA_HWIP_TYPE_UMC,
+       ACA_HWIP_TYPE_SMU,
+       ACA_HWIP_TYPE_PCS_XGMI,
+       ACA_HWIP_TYPE_COUNT,
+};
+
+enum aca_error_type {
+       ACA_ERROR_TYPE_INVALID =3D -1,
+       ACA_ERROR_TYPE_UE =3D 0,
+       ACA_ERROR_TYPE_CE,
+       ACA_ERROR_TYPE_DEFERRED,
+       ACA_ERROR_TYPE_COUNT
+};
+
+struct aca_bank {
+       u64 regs[ACA_MAX_REGS_COUNT];
+};
+
+struct aca_bank_node {
+       struct aca_bank bank;
+       struct list_head node;
+};
+
+struct aca_bank_info {
+       int die_id;
+       int socket_id;
+       int hwid;
+       int mcatype;
+};
+
+struct aca_bank_report {
+       enum aca_error_type type;
+       struct aca_bank_info info;
+       u64 count;
+};
+
+struct aca_bank_error {
+       struct list_head node;
+       struct aca_bank_info info;
+       u64 count;
+};
+
+struct aca_error {
+       struct list_head list;
+       struct mutex lock;
+       enum aca_error_type type;
+       int nr_errors;
+};
+
+struct aca_handle_manager {
+       struct list_head list;
+       int nr_handles;
+};
+
+struct aca_error_cache {
+       struct aca_error errors[ACA_ERROR_TYPE_COUNT]; };
+
+struct aca_handle {
+       struct list_head node;
+       enum aca_hwip_type hwip;
+       struct amdgpu_device *adev;
+       struct aca_handle_manager *mgr;
+       struct aca_error_cache error_cache;
+       const struct aca_bank_ops *bank_ops;
+       const char *name;
+       u32 mask;
+       void *data;
+};
+
+struct aca_bank_ops {
+       int (*aca_bank_generate_report)(struct aca_handle *handle, struct a=
ca_bank *bank, enum aca_error_type type,
+                                       struct aca_bank_report *report, voi=
d *data);
+       bool (*aca_bank_is_valid)(struct aca_handle *handle, struct aca_ban=
k *bank, enum aca_error_type type,
+                                 void *data);
+};
+
+struct aca_smu_funcs {
+       int max_ue_bank_count;
+       int max_ce_bank_count;
+       int (*set_debug_mode)(struct amdgpu_device *adev, bool enable);
+       int (*get_valid_aca_count)(struct amdgpu_device *adev, enum aca_err=
or_type type, u32 *count);
+       int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum
+aca_error_type type, int idx, struct aca_bank *bank); };
+
+struct amdgpu_aca {
+       struct aca_handle_manager mgr;
+       const struct aca_smu_funcs *smu_funcs; };
+
+struct aca_info {
+       enum aca_hwip_type hwip;
+       const struct aca_bank_ops *bank_ops;
+       u32 mask;
+};
+
+int amdgpu_aca_init(struct amdgpu_device *adev); void
+amdgpu_aca_fini(struct amdgpu_device *adev); void
+amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct
+aca_smu_funcs *smu_funcs);
+
+int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info
+*info); int aca_bank_check_error_codes(struct amdgpu_device *adev,
+struct aca_bank *bank, int *err_codes, int size);
+
+int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                         const char *name, const struct aca_info *aca_info=
, void *data);
+void amdgpu_aca_remove_handle(struct aca_handle *handle); int
+amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                                    enum aca_error_type type, void *data);=
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a39c9fea55c4..7d5e5059cc85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4023,6 +4023,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,

        amdgpu_device_get_pcie_info(adev);

+       r =3D amdgpu_aca_init(adev);
+       if (r)
+               return r;
+
        r =3D amdgpu_device_get_job_timeout_settings(adev);
        if (r) {
                dev_err(adev->dev, "invalid lockup_timeout parameter syntax=
\n"); @@ -4427,6 +4431,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device=
 *adev)

        amdgpu_reset_fini(adev);

+       amdgpu_aca_fini(adev);
+
        /* free i2c buses */
        if (!amdgpu_device_has_dc_support(adev))
                amdgpu_i2c_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 76fb85628716..c36faf353b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -29,6 +29,7 @@
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_aca.h"

 struct amdgpu_iv_entry;

--
2.34.1

