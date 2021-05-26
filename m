Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09259C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E5C613EC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E5C613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29FB56E0EE;
	Wed, 26 May 2021 07:14:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4C06EA88
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 07:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8Vtu/5R8xgmFTTuTgWt09ZfgTG6GZ0fszpgkPtyGUFsK6oMoX8VfNZeaYzY8JpfK3b6KGqRCqGXmhuL7HPf8bF5zRrKU5wjRFZ9DN2794vND1YgI5omWRsTzvwn8B+4qKwFFZjle3/o+jrm/kayTk4ZjPR8MedwNyTbkkpzNqBsy0MjXHDIe57LbcfoIcx6XFQ2EHW7k1D/8cwnskSYwy2+2x3qqtMpvkomJWY3YLFf3Z0OZZbQBsq9m58ZnFQocJ0hOofe4L2qHZUiUXh3ZV72ieTKjzPyIR7ERxGAIL3TCwzVpp218MUR1mhfXaZVKch8FMZ5f2gWbhnkWojeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brtd64gBKXte0FzlqRMcQH9cBOGMvVYCzhSHgqcxZ3E=;
 b=US7ea/DVQoXTu4CdYiqNvumr/oO4/4j24VebdfUrGJ6Kqve7yS/Y9flPA2hrV21shOe8mc/7dht2q1dw3+G7XzTtisx/MGdnc9WAoicu8NhbbVrpUxJ9einGqozPYCgRavvsYoti0L37OzWQDiyOmxfdJCbbqsuw9VnqGKjuJOVTuNG7BNffH7Pf5RVfRraEh35hYCdKt/PBv1xcYRVwOFgHS5E9vwpIlfArZXpoch+NWQOOBDbZ8J/8ytrrt+NxpKbT98bKm7HcgzO8AkbrjAz0LjRwphuG+owzDiAqpxq6ZdH0O4orTTu/3dwWoeXbVAFJKa8Fq5XW4C2O6xDVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brtd64gBKXte0FzlqRMcQH9cBOGMvVYCzhSHgqcxZ3E=;
 b=H6teExW0LuFXdki5F5LzEVqhVQC4OzrhPgAAbH7DWkJr/xXiI5D3XlEMdvbM+unTasSLYK9qG0d+jw1QGyWi+SOG4wrVgI1kbyHIWKbMRUmLQE12iSUlPnHYnGY1bxwwzhQA2rvceGH75GzfS7/aHQtfoLjrvqOBAF35bbkPOMg=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 07:14:27 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 07:14:26 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid attack
Thread-Topic: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid
 attack
Thread-Index: AQHXUfw24LGgNzQdoUOJKSkJGVb9Z6r1WJAQ
Date: Wed, 26 May 2021 07:14:26 +0000
Message-ID: <PH0PR12MB54176F7CDBAD4134AA57889C8F249@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210526065459.26368-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210526065459.26368-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a593f7b8-f2f4-4f27-ba75-d6e19b55d7e2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T07:10:54Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e13c3a95-ef43-4903-86b6-08d92015e5b1
x-ms-traffictypediagnostic: PH0PR12MB5433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5433331BBE2A1B0DF33D3E068F249@PH0PR12MB5433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SH3iIb2GHSpa/1n6LRL6xFqI8wvCeS4mUbbc4WYDU4qfqq0bP/3/pX1M3+06o5/wYMFh7ljreybUAZXFLp2+D/eVzGCCNiqAA3LhqrXQYP6afrKENfM6/gduvSD/R9FQ3ux0H98M+j079W2VTPjmlrYJRGwAH6WgS6VTiW4oGFZqI6HYe3p73oLCFlTdTV5b7DKqqVgV+ZlvHtNQHoXn18bJY6Gu9Nf8P7ixYRrpMLiQ8bVwy6VtOs7mDhNlrf/rKzTcJsD5rGhE+tjvnvfmuz8JFxYU+GsabqQeva0FOoMX76muSc7OHfm5f/3dUeZJDIHkQzp8prEIPkzqVA/3XrEaALb66/NovZ7n1BMsLTYa8piCye5Rs8YgJbei34Za+4tymMNerXJkd5PSvfKNAiXb6jiQ2bUCKw4B9ct1Kq2AjA+wJeLEb7v+S1FsJqzygZ6nSKV5MKmTf+59JfMfFZkQWdnu6JR10SqbJSWzfhcbXrfvEmOmVVV9yzYbrLPFgUnw1Z4uiJ0cfqJ0WucIIas+1T5stY6lc5/Hc+O8gEyTq1Ap2qV9FLTsGISndYCN3uNYMZ06gDGeMilxCoCrkQ1mZQH49SmpaC+1oV1t7EgTpwG8eauy3dHJL9zQStJDUDyeZVUWG/1ElESu9hVo1wmQmeIMg42KH8lhp/dWwchJU0qoPrVqfsfkErre9tLEERUivbythaFT2vQ7A9j7BT5rrRNKUCMQdHp+uPMAHFo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(26005)(9686003)(38100700002)(122000001)(7696005)(55016002)(8676002)(8936002)(86362001)(6506007)(33656002)(66476007)(64756008)(66556008)(66446008)(76116006)(66946007)(4326008)(316002)(52536014)(186003)(83380400001)(2906002)(71200400001)(478600001)(54906003)(5660300002)(45080400002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+iiNX0o4Xcb3ncFDj1p1VVJQoS50NVnqn+F8oTfoIYQ16t6aWj6DKdh4UlvV?=
 =?us-ascii?Q?iuX0qW83b2lKn4eTa12YM61D0R+KHnhD2xb2N3O59wlZ2jhbex7brOElvPfE?=
 =?us-ascii?Q?JPajSoXiczj2ycRH+chHPLbl9iexKsfVhLiCPGVvxudLblnMUByzA200n/5F?=
 =?us-ascii?Q?Yn001pjrj2aQkfmaOrVuNikppu4C8908RGrD3hkZOOsJi1jfE+sWXbDO51bQ?=
 =?us-ascii?Q?Bz5RxY36iAD7+9T8Ac7CzzErtQUj3M0xYzBpk47AJNUCflWgUtQDKFJM0d8w?=
 =?us-ascii?Q?ZJbjabSjM2JYCfriZVf5mtFiyFsBiInffc0uB5+NJjGpwj7n6GAryJf62dj5?=
 =?us-ascii?Q?aZWJj9Fx2IYz0V9s0hdcgpsvzNZri+FNFMqHHWRhSHpqSUnkctHYW3DS7PoS?=
 =?us-ascii?Q?LTn34+DKK5Dl22izyDtJ1TDlbE6obEZh4I4k/qRKZHgzdluzKpCaoZr2EaeN?=
 =?us-ascii?Q?ATw7XKHK5R2M6DiYeaDYi2stg+UtSk+2ALkWuor11UxvYYJewOiPqPY8cavJ?=
 =?us-ascii?Q?kq7b7Qm1Egbr9q60js2hqfhGmKYKLvMjQer0R3/w/X/rreG3+3vsaKoxens2?=
 =?us-ascii?Q?3idx8jplShYr4jQpK7IuvMY9eg0pBOE5n+ihQl8f0T4JCNBPcOjNEWa7UObQ?=
 =?us-ascii?Q?L/2GQlGICUhKVb1HqB4vvZw7vTRFFMTTV7TN/XtSp9T6mU3w+E/B+V2bb8wX?=
 =?us-ascii?Q?ZhkPyDZxN8u74JByqr/ZlOrLMpH5zbGWomk0yS1PUr5ywBs4Ri5iKvQguIh/?=
 =?us-ascii?Q?s92QUVuqRcrxR7j9sheA/zevFmN5IoNuPBIl+ysPwgyAR1F75DoeZKTXqMd5?=
 =?us-ascii?Q?hRRcCWvHn5QT3GUveDUG36sQ1mlPxym6j6eS21EV2PEw0pyY5LmZJ97Hl5Z0?=
 =?us-ascii?Q?qzvNt5CMi+XJJcG1c125LZXd4BUAIQKNnqENWKLwZ9X9mVKZDLKzjJEUCfrU?=
 =?us-ascii?Q?SXj0BJIPWeSuO3ZE+MNpABfc7/R/qIHJ+JQbqxteApituJpP/hvUKKV6PaUJ?=
 =?us-ascii?Q?QxbhFYAMq4rknSEYjLuQQBLGtrzyzmfqfUXY6mw+2bYCAJAgNOVeZEW2EfdY?=
 =?us-ascii?Q?8vhOVm72Gny22JigMFDJYNznXlIlOSsM2033C5C9f9u0T6VL3a7kYpzawRFi?=
 =?us-ascii?Q?j3vEy4mpNwBcXmoz21YFlzOgimy9nEaeArhq8wFZTC/opJat8OVEh2hoN7H4?=
 =?us-ascii?Q?nuOrsaHpydYLyI+CF97Y2wjEwOZvDF7YXtngne+bz3T2WRBxi0WYEJC+RG2u?=
 =?us-ascii?Q?lWHFvetFJSaveQaQof/0VU+xos7qC3thzZnvV2uepdH5M8p006e8n5NHpsDO?=
 =?us-ascii?Q?1FgCfbEF4bmOJSHDQqPmHUSe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13c3a95-ef43-4903-86b6-08d92015e5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 07:14:26.8350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NY/7cIO4xmHsYz7pGvVqs823El9BqBrNnNCv2/kzNcIdulsBBQTarhOUUhICFXV3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jingwen
>Chen
>Sent: Wednesday, May 26, 2021 2:55 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Chen, JingWen <JingWen.Chen2@amd.com>; Zhao, Victor
><Victor.Zhao@amd.com>; Liu, Monk <Monk.Liu@amd.com>
>Subject: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid attack
>
>From: Victor Zhao <Victor.Zhao@amd.com>
>
>save psp ring wptr in SRIOV to avoid attack to avoid extra changes to
>MP0_SMN_C2PMSG_102 reg
>
>Change-Id: Idee78e8c1c781463048f2f6311fdc70488ef05b2
>Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
>drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
>drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
> drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 3 ++-
> 4 files changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index 55378c6b9722..20e06b3ec686 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -2701,6 +2701,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>       /* Update the write Pointer in DWORDs */
>       psp_write_ptr_reg = (psp_write_ptr_reg + rb_frame_size_dw) %
>ring_size_dw;
>       psp_ring_set_wptr(psp, psp_write_ptr_reg);
>+      ring->ring_wptr = psp_write_ptr_reg;
>       return 0;
> }
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>index 46a5328e00e0..60aa99a39a74 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>@@ -76,6 +76,7 @@ struct psp_ring
>       uint64_t                        ring_mem_mc_addr;
>       void                            *ring_mem_handle;
>       uint32_t                        ring_size;
>+      uint32_t                        ring_wptr;
> };
>
> /* More registers may will be supported */ diff --git
>a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>index 1f2e7e35c91e..4a32b0c84ef4 100644
>--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>@@ -474,6 +474,7 @@ static int psp_v11_0_ring_create(struct psp_context
>*psp,
>                       return ret;
>               }
>
>+              ring->ring_wptr = 0;
>               /* Write low address of the ring to C2PMSG_102 */
>               psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
>               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102,
>psp_ring_reg); @@ -733,7 +734,7 @@ static uint32_t
>psp_v11_0_ring_get_wptr(struct psp_context *psp)
>       struct amdgpu_device *adev = psp->adev;
>
>       if (amdgpu_sriov_vf(adev))
>-              data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
>+              data = psp->km_ring.ring_wptr;
>       else
>               data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>index f2e725f72d2f..160f78eb6403 100644
>--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>@@ -237,6 +237,7 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
>                       return ret;
>               }
>
>+              ring->ring_wptr = 0;
>               /* Write low address of the ring to C2PMSG_102 */
>               psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
>               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102,
>psp_ring_reg); @@ -379,7 +380,7 @@ static uint32_t
>psp_v3_1_ring_get_wptr(struct psp_context *psp)
>       struct amdgpu_device *adev = psp->adev;
>
>       if (amdgpu_sriov_vf(adev))
>-              data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
>+              data = psp->km_ring.ring_wptr;
>       else
>               data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
>       return data;
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
>desktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C36c0aa6490f94ad29ac
>608d920133b77%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375
>76089720049840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
>QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=PV29Nx
>wj0ASCRlw%2BHWal6Ghk%2FkLe6Qhxd2yCwA%2BiI9Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
