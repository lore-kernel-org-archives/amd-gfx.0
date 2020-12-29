Return-Path: <SRS0=yA2I=GB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2538C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 06:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECC0207AE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 06:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECC0207AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E89890ED;
	Tue, 29 Dec 2020 06:27:14 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760048.outbound.protection.outlook.com [40.107.76.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E778E890ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Dec 2020 06:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8nI8FhLl2zA4fvHDTcmQeDB8vifl3Sjs/G0F6n0+ny1EydoccmrDXxYQO+EEobfOeLmD4vLDeDK2z2AywzyDbZtnv5jzqmH6j6PHqB8k/cl6lb+qjtUuj7bdNHIwDQKP8U7gLfE09F25uZxXT3n8/gF2TEfSr9WnHtBwV/gnIXJAw1idt8S+NUIGGk/Q78Sps/4zKuvX4vk9UohNsftupg3ckKlipuV/h+z5q3KE7L4Q/S6S4Opfhp1FaAKD1gnWLvsAkIbSiKajipcYdmCd/5xd+n54eNkGdiPnxVZaT47930oyAKU7jnzihtZ2kHS2d+3J4pHE0QY8H6JyrtGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNwRRf4ZICyMEBCZ/ZN97X6A6zpSQm9ZbJhZkjU+0ME=;
 b=D5BNKZLhz5NNm3hiGSoNgqP3THn7r6kUjvTbpaBCKRYmhTiRq0PeDMRYxaNAodAJhES5EMG7T/bwRRAJBa/aJM6eS39dfYXkDO8DNfQtvsds4Xx2OSavSG0kGEl8o572CxFgW61/N/OTyd2W+8MnW/qPB8jn6sl+5ckzQMa3oPxj/NfJljS/k2Vz9UTI+KxyWIpIogXM7S7ZBLbHeYXItJ0pINzujyebLw/nStOw7FtFAR5sVbe40LXiWdp3cXWCZNKWTpCqQxs/so964aCKKpSxludwU32tqT735J3CUsSB9YpqJBsJS5z93b33Fy8SFuwQRvdgyBvh1RRYEho3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNwRRf4ZICyMEBCZ/ZN97X6A6zpSQm9ZbJhZkjU+0ME=;
 b=20Tvk9IVALdsIgDqNoGiNP4+u8sVlK9qwoyVcSxtQd1hMwWb5Yx1U3hIUhXFhVKKxuMyJeBTQEdflKFbg5bLcxd5KsQkZ1bpUBVVXoFk3yBkNW/yqXsPScCwa3wcg93FtCdFBC61WK5lqYdEeHnvcIQN6fM0kqAkhByk7ax808I=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Tue, 29 Dec
 2020 06:27:11 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 06:27:11 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu: switch hdp callback functions for hdp v4
Thread-Topic: [PATCH 3/5] drm/amdgpu: switch hdp callback functions for hdp v4
Thread-Index: AQHW3Pp8zdnWU/9Y4EOaxQ7PrUfnR6oNmhHg
Date: Tue, 29 Dec 2020 06:27:11 +0000
Message-ID: <MN2PR12MB4549DBAD958F7A00611B731097D80@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
 <20201228091834.3240927-3-likun.gao@amd.com>
In-Reply-To: <20201228091834.3240927-3-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-29T06:26:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a72124d6-efad-431a-a8e5-0000a41e490e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-29T06:27:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: fe820f54-d6c5-4d3b-ad80-0000480f6e95
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.204.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d89a72d5-19b7-4256-0b0c-08d8abc2c6ba
x-ms-traffictypediagnostic: BL0PR12MB4897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4897D76C8D6D2B09D14691DA97D80@BL0PR12MB4897.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHYQLTQxWaNODH0G5dHh1e/jveqFA7V/YsXP8+Gl9gdwsGraVYnGXFjww5mZXZVS5MtfjwyTtoY5z6GPzRRVJF68YldMbFghxSZiiLpVU0VuOSJo6IO0lSZT3ghUQXBzBPbZRzyx3UFi6Ig7uI+aGE1/FjIy+J2ZDBwqpLpBoRfTwnJ7m3nR0g0cXreeZYksZyFMSNFaAWKqS7MbZ1uEmKGVAjUT0Ak97v2MOV6YjwLozPK7AoFwWmOWHBjY0LHMngUgiTWMZ7s9MqcMLj554yOH3/yTJgcJJ9hjbrCi+Lv5BvwVtxtApQvv2ZxCsUfy8qfNMUfopMH+d2po6gMWDqSlUNm0y6O7YstQ12mUiRXeCGYkFAr1RZMwAy4QSMzAnVoBswRAgrtF1uqWCq9oYC8D/sagjoO5NfLaytyuVXFHIT4/1nvdb7os5Y6DUIXglddRJ/aEpYNP1qRMuHDSNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(30864003)(4326008)(186003)(478600001)(2906002)(45080400002)(6506007)(26005)(55236004)(52536014)(64756008)(66556008)(66946007)(66446008)(76116006)(66476007)(5660300002)(9686003)(55016002)(83380400001)(8936002)(110136005)(54906003)(8676002)(316002)(71200400001)(86362001)(7696005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kA/YVBYBLClevq4+Bph9GTZFHfqSRTtDXFy0V5vvXi7Sn23YF/LdzcXdQh2n?=
 =?us-ascii?Q?5UDyaVxfyYXMG071B16Hhb/gxXP2A/NH9HZmQ1FnCn6rm2g7KREzh1m7R31Q?=
 =?us-ascii?Q?8h/72z4Ef9Z1DuQG/SL4w9ENqQKDh5cQoYzLPbzNt86VDn9EpKfxHgDJSijh?=
 =?us-ascii?Q?xSCl3Or0cv4igzF+5yQ+H/6+g1NzwkE+vntsDAY3UDipc9nUHQFHqH1V9tUo?=
 =?us-ascii?Q?Zl0vbOPWsIWmrs/SdPA5dR89QfXbo4QzbzsQ+xOp0Ak7gPrCKTYp6LF5H5fY?=
 =?us-ascii?Q?xRvWcnbKoVwSRNb6/JuQzG7sOYGHA3I0dal3Zq1mMw20cTYVzuL/36ihUQrg?=
 =?us-ascii?Q?s+e+sWkUf80/7qhkk0sSezx1FW7Iq+OZwcF/FkV48pg+ywjJ/rZb3ItZNZwP?=
 =?us-ascii?Q?/yx39eqLwbNstlc4OKNPDriCDuKTZK4/NfTWEGModDSZSniQ39dIpD+Z8VAN?=
 =?us-ascii?Q?vT9Lr9EExEBxgPnEx3X7Qyi65AICMP/Qj9txqRG3jSWVClWTcOTLXdVaW28b?=
 =?us-ascii?Q?OHBq0oV2UkwrcN45PhJCCKe1ZmtpA5PvG1umX++gxjbzad/6MRt9QMI+DptF?=
 =?us-ascii?Q?kJT4wotF0pUPA+WYoq4ALJmt0UbGEykZTd0PG+CMhzQsJGCde1iL3zRk+YlX?=
 =?us-ascii?Q?0hcj6lee/GBQySvwhXFQmo1ZfEUH4qiWN9/QYBdJ/OcM2Bt9ji++6yDp0UWU?=
 =?us-ascii?Q?4AMQnPxP9ib0i+XlXN8cP7bSeOnT2cX+ywKTDVP3/OtOV1okL/0kVyB9xa1v?=
 =?us-ascii?Q?YNSWfWO8p8RVOlNa5gSwRbtYhBQFljX/E5COtQsFk2O8g8pXLjWGxhZRlez7?=
 =?us-ascii?Q?9Bxs+EyYbUGHbwUNhUupwXr9AA02lGbEUY5+l22XIc6NDyq+Duk+V5wMJSEe?=
 =?us-ascii?Q?PQ50t2KWcqkEUrvCf7hWDzV4fHH06LCiMXzCtc1sPolFvYqhLDBcVKWA8Rqr?=
 =?us-ascii?Q?x+QYeeZ60B7bG+lXkLUPqWFJ1eXOi7B1+P1HJNpDADo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89a72d5-19b7-4256-0b0c-08d8abc2c6ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 06:27:11.8125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZevLdvPAkmwEaB93oewQDZiblBWpwgESdp/UsWT+c+0dK5fvupiQRFl+E+gGbNLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun
>Gao
>Sent: Monday, December 28, 2020 2:49 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking
><Hawking.Zhang@amd.com>
>Subject: [PATCH 3/5] drm/amdgpu: switch hdp callback functions for hdp v4
>
>[CAUTION: External Email]
>
>From: Likun Gao <Likun.Gao@amd.com>
>
>Switch to use the HDP functions which unfied on hdp structure instead of the
>scattered hdp callback functions.
>
>Signed-off-by: Likun Gao <Likun.Gao@amd.com>
>Change-Id: I75016df403eca537fa30519e2918207461ec6f28
>---
> drivers/gpu/drm/amd/amdgpu/Makefile   |  2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  7 ++-
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 21 +------
> drivers/gpu/drm/amd/amdgpu/soc15.c    | 82 +++------------------------
> 4 files changed, 15 insertions(+), 97 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>b/drivers/gpu/drm/amd/amdgpu/Makefile
>index c6262689e14e..d741fee91a37 100644
>--- a/drivers/gpu/drm/amd/amdgpu/Makefile
>+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>@@ -71,7 +71,7 @@ amdgpu-y += \
>        vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o
>vega10_reg_init.o \
>        vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o
>navi14_reg_init.o \
>        arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o
>vangogh_reg_init.o \
>-       nbio_v7_2.o dimgrey_cavefish_reg_init.o
>+       nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o
>
> # add DF block
> amdgpu-y += \
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>index 92e9d1f1207b..ae4bcdd630e6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>@@ -89,6 +89,7 @@
> #include "amdgpu_gfx.h"
> #include "amdgpu_sdma.h"
> #include "amdgpu_nbio.h"
>+#include "amdgpu_hdp.h"
> #include "amdgpu_dm.h"
> #include "amdgpu_virt.h"
> #include "amdgpu_csa.h"
>@@ -1209,8 +1210,10 @@ int emu_soc_asic_init(struct amdgpu_device
>*adev);  #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)-
>>asic_funcs->read_bios_from_rom((adev), (b), (l))  #define
>amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs-
>>read_register((adev), (se), (sh), (offset), (v)))  #define
>amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs-
>>get_config_memsize((adev))
>-#define amdgpu_asic_flush_hdp(adev, r) (adev)->asic_funcs-
>>flush_hdp((adev), (r)) -#define amdgpu_asic_invalidate_hdp(adev, r)
>(adev)->asic_funcs->invalidate_hdp((adev), (r))
>+#define amdgpu_asic_flush_hdp(adev, r) \
>+       ((adev)->asic_funcs->flush_hdp ?
>+(adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs-
>>flush_hdp((adev), (r))) #define amdgpu_asic_invalidate_hdp(adev, r) \
>+       ((adev)->asic_funcs->invalidate_hdp ?
>+(adev)->asic_funcs->invalidate_hdp((adev), (r)) :
>+(adev)->hdp.funcs->invalidate_hdp((adev), (r)))
> #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs-
>>need_full_reset((adev))
> #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs-
>>init_doorbell_index((adev))
> #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs-
>>get_pcie_usage((adev), (cnt0), (cnt1))) diff --git
>a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>index e22268f9dba7..7b1f50fa9dac 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>@@ -31,8 +31,6 @@
> #include "amdgpu_atomfirmware.h"
> #include "amdgpu_gem.h"
>
>-#include "hdp/hdp_4_0_offset.h"
>-#include "hdp/hdp_4_0_sh_mask.h"
> #include "gc/gc_9_0_sh_mask.h"
> #include "dce/dce_12_0_offset.h"
> #include "dce/dce_12_0_sh_mask.h"
>@@ -1571,7 +1569,6 @@ static int gmc_v9_0_hw_init(void *handle)
>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>        bool value;
>        int r, i;
>-       u32 tmp;
>
>        /* The sequence of these two function calls matters.*/
>        gmc_v9_0_init_golden_registers(adev);
>@@ -1590,24 +1587,10 @@ static int gmc_v9_0_hw_init(void *handle)
>        if (adev->mmhub.funcs->update_power_gating)
>                adev->mmhub.funcs->update_power_gating(adev, true);
>
>-       switch (adev->asic_type) {
>-       case CHIP_ARCTURUS:
>-               WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC,
>1);
>-               break;
>-       default:
>-               break;
>-       }
>-
>-       WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE,
>1);
>-
>-       tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
>-       WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
>-
>-       WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev-
>>gmc.vram_start >> 8));
>-       WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev-
>>gmc.vram_start >> 40));
>+       adev->hdp.funcs->init_registers(adev);
>
>        /* After HDP is initialized, flush HDP.*/
>-       adev->nbio.funcs->hdp_flush(adev, NULL);
>+       adev->hdp.funcs->flush_hdp(adev, NULL);
>
>        if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
>                value = false;
>diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>b/drivers/gpu/drm/amd/amdgpu/soc15.c
>index 0d3def7269bb..6426ecd1861b 100644
>--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>@@ -40,8 +40,6 @@
> #include "gc/gc_9_0_sh_mask.h"
> #include "sdma0/sdma0_4_0_offset.h"
> #include "sdma1/sdma1_4_0_offset.h"
>-#include "hdp/hdp_4_0_offset.h"
>-#include "hdp/hdp_4_0_sh_mask.h"
> #include "nbio/nbio_7_0_default.h"
> #include "nbio/nbio_7_0_offset.h"
> #include "nbio/nbio_7_0_sh_mask.h"
>@@ -59,6 +57,7 @@
> #include "nbio_v6_1.h"
> #include "nbio_v7_0.h"
> #include "nbio_v7_4.h"
>+#include "hdp_v4_0.h"
> #include "vega10_ih.h"
> #include "vega20_ih.h"
> #include "navi10_ih.h"
>@@ -84,14 +83,6 @@
> #define mmMP0_MISC_LIGHT_SLEEP_CTRL
>0x01ba
> #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX
>0
>
>-/* for Vega20 register name change */
>-#define mmHDP_MEM_POWER_CTRL   0x00d4
>-#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK
>0x00000001L
>-#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK
>0x00000002L
>-#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK
>0x00010000L
>-#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK
>0x00020000L
>-#define mmHDP_MEM_POWER_CTRL_BASE_IDX  0
>-
> /*
>  * Indirect registers accessor
>  */
>@@ -700,6 +691,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>                adev->nbio.funcs = &nbio_v6_1_funcs;
>                adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
>        }
>+       adev->hdp.funcs = &hdp_v4_0_funcs;
>
>        if (adev->asic_type == CHIP_VEGA20 || adev->asic_type ==
>CHIP_ARCTURUS)
>                adev->df.funcs = &df_v3_6_funcs; @@ -835,21 +827,6 @@ int
>soc15_set_ip_blocks(struct amdgpu_device *adev)
>        return 0;
> }
>
>-static void soc15_flush_hdp(struct amdgpu_device *adev, struct
>amdgpu_ring *ring) -{
>-       adev->nbio.funcs->hdp_flush(adev, ring);
>-}
>-
>-static void soc15_invalidate_hdp(struct amdgpu_device *adev,
>-                                struct amdgpu_ring *ring)
>-{
>-       if (!ring || !ring->funcs->emit_wreg)
>-               WREG32_SOC15_NO_KIQ(HDP, 0,
>mmHDP_READ_CACHE_INVALIDATE, 1);
>-       else
>-               amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
>-                       HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
>-}
>-
> static bool soc15_need_full_reset(struct amdgpu_device *adev)  {
>        /* change this when we implement soft reset */ @@ -858,10 +835,7 @@
>static bool soc15_need_full_reset(struct amdgpu_device *adev)
>
> static void vega20_reset_hdp_ras_error_count(struct amdgpu_device
>*adev)  {
>-       if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
>-               return;
>-       /*read back hdp ras counter to reset it to 0 */
>-       RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
>+       adev->hdp.funcs->reset_ras_error_count(adev);
> }
>
> static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t
>*count0, @@ -1012,8 +986,6 @@ static const struct amdgpu_asic_funcs
>soc15_asic_funcs =
>        .set_uvd_clocks = &soc15_set_uvd_clocks,
>        .set_vce_clocks = &soc15_set_vce_clocks,
>        .get_config_memsize = &soc15_get_config_memsize,
>-       .flush_hdp = &soc15_flush_hdp,
>-       .invalidate_hdp = &soc15_invalidate_hdp,
>        .need_full_reset = &soc15_need_full_reset,
>        .init_doorbell_index = &vega10_doorbell_index_init,
>        .get_pcie_usage = &soc15_get_pcie_usage, @@ -1035,8 +1007,6 @@
>static const struct amdgpu_asic_funcs vega20_asic_funcs =
>        .set_uvd_clocks = &soc15_set_uvd_clocks,
>        .set_vce_clocks = &soc15_set_vce_clocks,
>        .get_config_memsize = &soc15_get_config_memsize,
>-       .flush_hdp = &soc15_flush_hdp,
>-       .invalidate_hdp = &soc15_invalidate_hdp,

>        .reset_hdp_ras_error_count = &vega20_reset_hdp_ras_error_count,

Could you remove this asic function also ? You may use this check before calling hdp reset errors function.
	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))

Regards,
Lijo

>        .need_full_reset = &soc15_need_full_reset,
>        .init_doorbell_index = &vega20_doorbell_index_init, @@ -1422,41
>+1392,6 @@ static int soc15_common_soft_reset(void *handle)
>        return 0;
> }
>
>-static void soc15_update_hdp_light_sleep(struct amdgpu_device *adev,
>bool enable) -{
>-       uint32_t def, data;
>-
>-       if (adev->asic_type == CHIP_VEGA20 ||
>-               adev->asic_type == CHIP_ARCTURUS ||
>-               adev->asic_type == CHIP_RENOIR) {
>-               def = data = RREG32(SOC15_REG_OFFSET(HDP, 0,
>mmHDP_MEM_POWER_CTRL));
>-
>-               if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
>-                       data |=
>HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
>-
>HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
>-
>HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
>-
>HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK;
>-               else
>-                       data &=
>~(HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
>-
>HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
>-
>HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
>-
>HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK);
>-
>-               if (def != data)
>-                       WREG32(SOC15_REG_OFFSET(HDP, 0,
>mmHDP_MEM_POWER_CTRL), data);
>-       } else {
>-               def = data = RREG32(SOC15_REG_OFFSET(HDP, 0,
>mmHDP_MEM_POWER_LS));
>-
>-               if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
>-                       data |= HDP_MEM_POWER_LS__LS_ENABLE_MASK;
>-               else
>-                       data &= ~HDP_MEM_POWER_LS__LS_ENABLE_MASK;
>-
>-               if (def != data)
>-                       WREG32(SOC15_REG_OFFSET(HDP, 0,
>mmHDP_MEM_POWER_LS), data);
>-       }
>-}
>-
> static void soc15_update_drm_clock_gating(struct amdgpu_device *adev,
>bool enable)  {
>        uint32_t def, data;
>@@ -1517,7 +1452,7 @@ static int
>soc15_common_set_clockgating_state(void *handle,
>                                state == AMD_CG_STATE_GATE);
>                adev->nbio.funcs->update_medium_grain_light_sleep(adev,
>                                state == AMD_CG_STATE_GATE);
>-               soc15_update_hdp_light_sleep(adev,
>+               adev->hdp.funcs->update_clock_gating(adev,
>                                state == AMD_CG_STATE_GATE);
>                soc15_update_drm_clock_gating(adev,
>                                state == AMD_CG_STATE_GATE); @@ -1534,7 +1469,7 @@
>static int soc15_common_set_clockgating_state(void *handle,
>                                state == AMD_CG_STATE_GATE);
>                adev->nbio.funcs->update_medium_grain_light_sleep(adev,
>                                state == AMD_CG_STATE_GATE);
>-               soc15_update_hdp_light_sleep(adev,
>+               adev->hdp.funcs->update_clock_gating(adev,
>                                state == AMD_CG_STATE_GATE);
>                soc15_update_drm_clock_gating(adev,
>                                state == AMD_CG_STATE_GATE); @@ -1542,7 +1477,7 @@
>static int soc15_common_set_clockgating_state(void *handle,
>                                state == AMD_CG_STATE_GATE);
>                break;
>        case CHIP_ARCTURUS:
>-               soc15_update_hdp_light_sleep(adev,
>+               adev->hdp.funcs->update_clock_gating(adev,
>                                state == AMD_CG_STATE_GATE);
>                break;
>        default:
>@@ -1561,10 +1496,7 @@ static void
>soc15_common_get_clockgating_state(void *handle, u32 *flags)
>
>        adev->nbio.funcs->get_clockgating_state(adev, flags);
>
>-       /* AMD_CG_SUPPORT_HDP_LS */
>-       data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
>-       if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
>-               *flags |= AMD_CG_SUPPORT_HDP_LS;
>+       adev->hdp.funcs->get_clock_gating_state(adev, flags);
>
>        /* AMD_CG_SUPPORT_DRM_MGCG */
>        data = RREG32(SOC15_REG_OFFSET(MP0, 0,
>mmMP0_MISC_CGTT_CTRL0));
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cba137ed79c354d2620a1
>08d8ab119d0c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637447
>439441071208%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
>IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8nzvnyY
>DrhrG5HXAXut4N%2FXUYpWcrHbObXOxnDjwm1Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
