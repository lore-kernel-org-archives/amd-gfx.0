Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878B0C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8022072E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zVSQw6j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8022072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED986EB63;
	Wed, 24 Jun 2020 14:24:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E396EB63
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABYgB0VVVjPw8V/Kk0z0yL3mE7h/s6KwgI63w5khWDMyj3Naa0J+p76SEkh5lOvtjnzyT8zVPl8VOzxwDI0J0Qe55CWyr5HPR9rs32HZnho9h+KeZHZFxf/WpsG5LH3lIyyDJOAdK4Bxus3aA8JayAP4SOAfuevj6HNZh8ksIA26hUMaRYo8So+RPBjS3DimUDE41dL2oZHfZsOTSQbhdlcmmHqJkA6Hu5HxbaseDYp9FRCujQfrW96vFJg3ijROrPw/J9+FKQS49IQ+V40r8N29HwB0rNkl16SwSZhSm4cqPU5yVycFsCvOr1icEwbMP9UXJoqT5MYBlpIureeYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2wwXaz7u2D4Mkt8qIlCVl0rP8rZvXSFj3IrOZviTbg=;
 b=ExpmZj4u8NcANDCJAJMFMXKdB02s8MKra7Iw3QQHoqzYxZU6x4vH71yWI3FM6Y+iVuXdfUHzoNDEmiHBaGDY8cRrt2E7AH2gRYp5aLgd+5Fawk6Rmf6maCboAZqbnTBAf2coWr2LTI7X0dS9aCoa19NjjTY5RymH65rzAqLI+yz3JsA4Abd6BVV3CWDdMcvNzcVrhNnXzkhtPbo3BcWh/TwWUKJ73rxJmODd/AB+6BlLYQT0OR5RNAgtwLaonDv0RLmxafWFxbG1Bckg+AdkrNlnuGLTYVPbH+mzZFuUMgHeKDOxAEFIGkQWKC0Xw6a+WiI5HZkIlkpHXK7oM5+b0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2wwXaz7u2D4Mkt8qIlCVl0rP8rZvXSFj3IrOZviTbg=;
 b=zVSQw6j0qBNxy3D/pk76EohtD9yJKEVMtCWS7XGMvnpHz2UPBdkT0qu7ercM8dZrDfBnkJQYUI+s/n3tVXYQ8ndp5Uf8OddmtxI40xproVxjBqF//JDkVZ0Mk8oJIfVBWuhosmQPZVk0OLcoIhV0eCvqRPq9pFHJJO3Y3SDOTZk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Wed, 24 Jun 2020 14:24:15 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 14:24:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/uvd3.x: fix register definition warnings
Thread-Topic: [PATCH] drm/amdgpu/uvd3.x: fix register definition warnings
Thread-Index: AQHWSOI6uJn9mlgjs0GcQeRsQpqb5ajn0zUAgAABMvA=
Date: Wed, 24 Jun 2020 14:24:14 +0000
Message-ID: <DM6PR12MB40750EEF87CC8EEEB9BDDC12FC950@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200622221219.1046290-1-alexander.deucher@amd.com>
 <CADnq5_McBUGrx9jrEJcfKX_FSRKMeq8o=0Y7jHkQzjm6VtY1qQ@mail.gmail.com>
In-Reply-To: <CADnq5_McBUGrx9jrEJcfKX_FSRKMeq8o=0Y7jHkQzjm6VtY1qQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-24T14:24:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=96bd2986-7bba-454d-84b7-0000a5e0a43c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-24T14:24:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1d4b37d3-40db-4f04-825b-00007a904242
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c284db9e-c446-4080-2085-08d8184a45d1
x-ms-traffictypediagnostic: DM6PR12MB3082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30820FC1DBDCFE11DCC5A6F6FC950@DM6PR12MB3082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQ5X79GPgPG9wssRc9yUpYUcLpHtgvk9CUnuttjWDtgmd4wMMhVlHmq0dyPijAAAXbniH7OWGPjYof3EPG+TKn1X3I19mYWcJE3ko063QjzLS96GGwKA5ddsl/Dpl1CNJxXD3V8s9jfz2W6eNc1NesoSmi4Y6p2Y4byhNPm+PHs/YeO/u9JOov983P9lW8WmpWqGwknn5KukBsTsnhV6cSRCRBb7Z0MDKI+CEw+jmjlFtR0+sgmGn7myfiRmwx1qMY7jyrWFOWsctKkEQNHrDsDddb/fV1BruIHAKzfuf6TaY5PNVqZy+um1H4jFDISGbfdBzU5PCKKQoH1m8i4GTpQ1RY2enimn4GE/xy8Kihg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(53546011)(33656002)(6506007)(316002)(8936002)(71200400001)(66946007)(26005)(966005)(45080400002)(8676002)(7696005)(66476007)(110136005)(76116006)(9686003)(64756008)(66446008)(2906002)(66556008)(186003)(83380400001)(478600001)(86362001)(55016002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pf6TTEyKP9K6o7fftdGL4eydkVc7y0nRZLhNNHVpMp/4++/PB9B/iY9W1IlRGddB7RzodH4SYjH62AESr+1PR3O67tNsezg4ytymv2Gho8wSx8S5rMjSAu1zSt06dL2kOkQRPAqnpx6upblDjWF3+lwZ2MsuGipiPyLP1WOKd3Yxm3hXBnUK+rC6ovHM4lHdDVTUivg2DK8SYL+p8pCVOyzWEAu3NgUPE/A3N5cH7NxkAleLOKwYoD2MLffVPbljO/744nGZtaLO7BomQtcGEIozt0yRzDryfyXjh+KjD6rMFpfAeq3ACoDYrS25gyt93soJOzAmQeBaqMjNyV6STB1MDOM2nJIyN1KLIBzcknTA333XjcfE4Uhpth0M6/q8NWkNgDO0KDbUksK64/UrciBkEKPINuaYv+IRSDLELom8n0PYs+DUnDuVPffknldkRXADWYMe9Ui/olrW38rmj2N+Oasl/aPtJXUTl49oVcT4WMCTIi5XKhZXNHku0+SJ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c284db9e-c446-4080-2085-08d8184a45d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 14:24:14.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDDPWRkM67iKGO5xQd1EBG2G/3PMAtKVErPwYXjaNrVoXJFylx939YO49khUwAvkRXG+gKkVCQXhCIYsRIrE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, June 24, 2020 22:20
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/uvd3.x: fix register definition warnings

Ping?

On Mon, Jun 22, 2020 at 6:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> drop the duplicate register macros from sid.h and use the standard 
> ones in the oss register headers.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/si_ih.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/sid.h   | 19 -------------------
>  3 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c 
> b/drivers/gpu/drm/amd/amdgpu/si.c index cda9aa5e4b9e..9b12285177e3 
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -45,6 +45,7 @@
>  #include "dce_virtual.h"
>  #include "gca/gfx_6_0_d.h"
>  #include "oss/oss_1_0_d.h"
> +#include "oss/oss_1_0_sh_mask.h"
>  #include "gmc/gmc_6_0_d.h"
>  #include "dce/dce_6_0_d.h"
>  #include "uvd/uvd_4_0_d.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 88ae27a5a03d..621727d7fd18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -27,6 +27,8 @@
>  #include "amdgpu_ih.h"
>  #include "sid.h"
>  #include "si_ih.h"
> +#include "oss/oss_1_0_d.h"
> +#include "oss/oss_1_0_sh_mask.h"
>
>  static void si_ih_set_interrupt_funcs(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h 
> b/drivers/gpu/drm/amd/amdgpu/sid.h
> index 75b5d441b628..5f660f0c819f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -2341,11 +2341,6 @@
>  #       define NI_INPUT_GAMMA_XVYCC_222                3
>  #       define NI_OVL_INPUT_GAMMA_MODE(x)              (((x) & 0x3) << 4)
>
> -#define IH_RB_WPTR__RB_OVERFLOW_MASK   0x1
> -#define IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK 0x80000000
> -#define SRBM_STATUS__IH_BUSY_MASK      0x20000
> -#define SRBM_SOFT_RESET__SOFT_RESET_IH_MASK    0x400
> -
>  #define        BLACKOUT_MODE_MASK                      0x00000007
>  #define        VGA_RENDER_CONTROL                      0xC0
>  #define R_000300_VGA_RENDER_CONTROL             0xC0
> @@ -2432,18 +2427,6 @@
>  #define MC_SEQ_MISC0__MT__HBM    0x60000000
>  #define MC_SEQ_MISC0__MT__DDR3   0xB0000000
>
> -#define SRBM_STATUS__MCB_BUSY_MASK 0x200 -#define 
> SRBM_STATUS__MCB_BUSY__SHIFT 0x9 -#define 
> SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK 0x400 -#define 
> SRBM_STATUS__MCB_NON_DISPLAY_BUSY__SHIFT 0xa -#define 
> SRBM_STATUS__MCC_BUSY_MASK 0x800 -#define SRBM_STATUS__MCC_BUSY__SHIFT 
> 0xb -#define SRBM_STATUS__MCD_BUSY_MASK 0x1000 -#define 
> SRBM_STATUS__MCD_BUSY__SHIFT 0xc -#define SRBM_STATUS__VMC_BUSY_MASK 
> 0x100 -#define SRBM_STATUS__VMC_BUSY__SHIFT 0x8
> -
> -
>  #define GRBM_STATUS__GUI_ACTIVE_MASK 0x80000000  #define 
> CP_INT_CNTL_RING__TIME_STAMP_INT_ENABLE_MASK 0x4000000  #define 
> CP_INT_CNTL_RING0__PRIV_REG_INT_ENABLE_MASK 0x800000 @@ -2468,8 
> +2451,6 @@
>
>  #define PCIE_BUS_CLK    10000
>  #define TCLK            (PCIE_BUS_CLK / 10)
> -#define CC_DRM_ID_STRAPS__ATI_REV_ID_MASK              0xf0000000
> -#define CC_DRM_ID_STRAPS__ATI_REV_ID__SHIFT 0x1c
>  #define        PCIE_PORT_INDEX                                 0xe
>  #define        PCIE_PORT_DATA                                  0xf
>  #define EVERGREEN_PIF_PHY0_INDEX                        0x8
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C4fec5ee61df24949a27908d81849a8f9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637286051966961153&amp;sdata=VbX%2BkPjTQyWhFuoDGYLxmlmJtbD1xnsWOMX0GFsr3To%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
