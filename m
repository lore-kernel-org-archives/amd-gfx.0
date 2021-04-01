Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CEAC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A555361029
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A555361029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133E66E2E1;
	Thu,  1 Apr 2021 06:00:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133CF6E2E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 06:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WryBZhbiO8FCfUl39Xfssyk1xLuykeGxccgtgiVo3wCRilp4YbetED4btv2CqewpeCh3c8hIrEdPtKJpNMjDjZmmqfyFIArvThEgQBAREJhgYWUcoaBo5Et7RECdlF7Ox40omB90eimWfGtHLWTyeQAhGCzuXU3PAtheVdwCW5CoxrK02kc3+kCXW60DdbpRBk0pAd/bGD6JrfvVBNqw6QLGPyznmXf2DrgAD1op3Hercu8xOC4NBE3PgDjhKEgvmIpl3/o2MnCXSEuh4L++2RWGuypFiLy4iVkZsnbyrwXumuggQHHR/HbhCus1zO6c95WN6nMmMIVulkdVseDygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvNiPZbp9UJ9CYSOwK/mWLy2qT1l3dTVxBA4JzfEGDQ=;
 b=NqBlpGadtnc6+vZ8wpHTUluQKn/MG0Co8JU+POYZ4gmLPtMOriDpHtn8oJUf5jXTdsLNkLsD5hukzibbknUwbJqwIf3jgMNDpxLPIx22BLt+HSFrDy1HyTbIji2Xmyd30nGV680xPnEN4exHfs+21tlndnwR4qH8Il3QLLY62yTwi+7EsSk6V2dMh/JsNHei+xQo71y54jyjO4LnEqHqfUGn58iaHYEQdlimTSGnH12GYYTVEGTsrvf3zZU71UKDOoB7lrR8hVWFoWOuA9hSs8MGtyTJ63ypd/AncOtR6paoP9bxzuKQZCJqNV0ppxlKRYW/MJG0+JikcksjVeqLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvNiPZbp9UJ9CYSOwK/mWLy2qT1l3dTVxBA4JzfEGDQ=;
 b=q90mESA/3dTl60UY2rdWfHCR7i1A0/oh+GEkjfyoKP94T1Oy50dn3wqG72rB+k+tXenMZgTsKIfN3bwFCZnSxU/PPsdXW++9rGl0VdH4URcQhY9Qrkx+Cx4mBu45Cj9GEfFbAGImQ2q121IgdHtJhtzli529M1yWe4i+zebWWQs=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 1 Apr
 2021 06:00:41 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 06:00:41 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: indirect register access for nv12 sriov
Thread-Topic: [PATCH 4/4] drm/amdgpu: indirect register access for nv12 sriov
Thread-Index: AQHXJe2nZ8ngThqCKkiWwLEiV0n4c6qfLJ+A
Date: Thu, 1 Apr 2021 06:00:41 +0000
Message-ID: <BY5PR12MB4115BE504294097CAAA2E9C98F7B9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210331052025.24200-1-PengJu.Zhou@amd.com>
 <20210331052025.24200-4-PengJu.Zhou@amd.com>
In-Reply-To: <20210331052025.24200-4-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bbd132b2-edc9-4435-828f-a7dcb051c964;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-01T05:59:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e6805a5-d911-4728-3537-08d8f4d37b1d
x-ms-traffictypediagnostic: BYAPR12MB2728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2728EC2C6772EDCC608017918F7B9@BYAPR12MB2728.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zV/yYFT5Ex+JZF4IqDH3iB1QxI0rjLbKQi9aErVDWhV8CHts83loqRPcviEJ5aflxZ1oDgxx7ngIMouJi/DMtrEBWPoEE4LXhAE2wr9HELQQ7Y8l0P0s5o72caqE9jHo6p/xSUmVfNuuqiiZOK42l+TU8hcV3mfZS9US6QUPWPSOPoZyc3jbf19+lxhCBe8gmJ8ymGFm0YGKmSYcmxaabifBJZGyDbUT9358CNO2/EwM78L1XgBkSVKesuwTuDouaQQVhEkF9HvjR85s+D1DCYEoWUFtNqpBkKpNFUaGm8oQLfjQMFOqnX1LLvv1GUccv4DPf+Uj0JzJGgYtpdLMoS+13yOGchnRVWHnhLBvoXVC+HmrHUugm9m6CwLNoxxfBuAikop2h5C2EsqewpEVlh0KDOQBZ2bxDSFbCl93AXd7AGHc/YXY2ZxecGMuTd6RKGFA1dA4mt0leO1yZpxqt/2npwtDnbqYfai+/CKbDuTzSks06NbItBJrxTdFWZAu8mrObauo5R0Mljv66UOf5Q7TmSkX4aGalTban9qzOx2frKvAJfTHGZ7v9Itj4vaKXYyQXulQr2Lw8zf/sLt7YvqMra3HSmmlLlqoclMObR5TniSZdi4SSR1PK113TbrOIBdRznQzKML7YZwynvhYuyUpnrtxWDv137HO9M6skhbhbBr2NsQfT4YDUIyD8u1C/tznTYBxWKS+fOtMjLFlVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(26005)(186003)(4326008)(52536014)(55016002)(83380400001)(38100700001)(2906002)(478600001)(33656002)(6506007)(30864003)(9686003)(76116006)(64756008)(45080400002)(66446008)(110136005)(86362001)(71200400001)(8676002)(8936002)(5660300002)(66946007)(66476007)(7696005)(316002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G5tJb6M4QIC0AOz+zejIUh+BlCV3rhubkrQtCiZHT8hTjAfrDXSSpB8I0Mo5?=
 =?us-ascii?Q?nTUg1HIX7zx4PIkri3xFQJ0/vQYmtrKjgV7PkKAh5m3Tmq1MkMLKqZJ4UpwN?=
 =?us-ascii?Q?ouo9+WdmjOEaaycufuqZT/8wqhZV08H5rOj1x0To/KzwLks7NNx6tHwsqLst?=
 =?us-ascii?Q?Lls+GkOJvHzi26eK0LUxuzTGwRi1raSFPsfqLFB+zF0u4sRhEKvSPrqxg5bU?=
 =?us-ascii?Q?7iT+H0Fjuhr+oWLJdsWUQ40k0W4BIzla+G+MQrc6mCPXxtMjlZs8j8uWNQ4X?=
 =?us-ascii?Q?fZbN6ls7tWi2VHlWLjYHsOpWqyS7wqZ1UCsBZFWhxjzYshl78NRiXrA8w1wq?=
 =?us-ascii?Q?eFUi7M0U4OOm1UzTHUmHjYhvMIz4JfpWMrlA38XIWHREKvypKi7wtbl0L5IP?=
 =?us-ascii?Q?m8UVeJGS1subQYBqFbplRTGmJLXH0liMiUmeEa2E3ltNs7FCGM9x1Xj1TO1U?=
 =?us-ascii?Q?rAVcWUvr/UUHL2nFPcfUo9B+2Xg/jEL8WwibEx/OWd9kE7bzk0meNwl0OGfF?=
 =?us-ascii?Q?6nIWvy71JBlAyReZhmGxla47zo4+Jg+BQ7TZiC6PgHnFitpv+reVaITj+cbq?=
 =?us-ascii?Q?83JMToGDrB/alHd5ykAT0IF5h22iJEweLHZtEnffawfuJ+/Z3UVRV0yTixBn?=
 =?us-ascii?Q?8vV89J8Kx8nRsDKh278fdeInkcoOl/o4QVPlJoz+NADmdCnZAyYbFPuoPI/p?=
 =?us-ascii?Q?yN5L0BMY2OxkA3z1BDqwuf+whfaOR5KE5VHmmNsEUNTOKa19H51Z/Bmp+Oks?=
 =?us-ascii?Q?Y1A7AGlHFH7Iq6mC9CdvC2lyNMfURT+enRB+pD/u4mP0OkpU+nvut3kwpDAB?=
 =?us-ascii?Q?W/7ZtgINJ9XS3xMM4KHURONKrD+k2AiV45J/bp5fNnp2gGzDAaitmii+O8tt?=
 =?us-ascii?Q?YupUc+Ml8dVw3zQ0NqVx6/frMXucwycJA9HDNxFtpA3VB6TOR+4CMkV4Wc6S?=
 =?us-ascii?Q?lx1D+N36ULZv2TkVCa+WBKyJSoNRff6SfjgkMIJ/8ZkkgQ+JWtl4DXNoV6nD?=
 =?us-ascii?Q?+jvJJ/sKR9PrJ7KQaECpSkzu0Z/eqF8drJOz2qVRp6viA5/blDAmXZ/H+bm7?=
 =?us-ascii?Q?lAm2ZeEaVfbXoEFNloM/WqJ76R4bHrfDvJzZROijd+SAa7mRgWbER2eT1a/i?=
 =?us-ascii?Q?xDQXGnVBwoOXB60WV7BCZwdDqMUh8sCJ2SSKAXVJO9ypcTpq6zXmCcZkmvYw?=
 =?us-ascii?Q?LrUySvZe1O+J28P1sYMu+2uJD48AGAodl9fWFbctqxWTitGLIJsQcAD039S6?=
 =?us-ascii?Q?Qu8VpRMpIoW7ZQ4Pt8itneM3lc0dBWZTVZNfOFyUgQPTw/rf+AvBkzr5od8I?=
 =?us-ascii?Q?DcGWUQpCyucaUOhb5kTmPeeQ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6805a5-d911-4728-3537-08d8f4d37b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 06:00:41.2618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2rzOLUGt/rD0C9Jm/X9iWxEYApU0gIU84xr7Bu3ZX2XyZTN70q36grwZVH9mf7n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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
Cc: "Zhao, Jiange" <Jiange.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Peng
>Ju Zhou
>Sent: Wednesday, March 31, 2021 1:20 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhao, Jiange <Jiange.Zhao@amd.com>
>Subject: [PATCH 4/4] drm/amdgpu: indirect register access for nv12 sriov
>
>1. expand rlcg interface for gc & mmhub indirect access 2. add rlcg interface
>for no kiq
>
>Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    |   3 +-
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 131 ++++++++++++++++++---
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |   2 +-
> drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  75 ++++++------
> 5 files changed, 150 insertions(+), 63 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 060d0ae99453..438e2f732377 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct
>amdgpu_device *adev,
>     adev->gfx.rlc.funcs &&
>     adev->gfx.rlc.funcs->is_rlcg_access_range) {
> if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
>-return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v);
>+return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
> } else {
> writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> }
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>index aeaaae713c59..4fc2ce8ce8ab 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>@@ -127,7 +127,8 @@ struct amdgpu_rlc_funcs {
> void (*reset)(struct amdgpu_device *adev);
> void (*start)(struct amdgpu_device *adev);
> void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned
>vmid);
>-void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v);
>+void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32
>flag);
>+u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 flag);
> bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t
>reg);  };
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>index b4fd0394cd08..85a6a10e048f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>@@ -177,6 +177,11 @@
> #define mmGC_THROTTLE_CTRL_Sienna_Cichlid              0x2030
> #define mmGC_THROTTLE_CTRL_Sienna_Cichlid_BASE_IDX     0
>
>+#define GFX_RLCG_GC_WRITE_OLD(0x8 << 28)
>+#define GFX_RLCG_GC_WRITE(0x0 << 28)
>+#define GFX_RLCG_GC_READ(0x1 << 28)
>+#define GFX_RLCG_MMHUB_WRITE(0x2 << 28)
>+
> MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
> MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
> MODULE_FIRMWARE("amdgpu/navi10_me.bin");
>@@ -1422,38 +1427,127 @@ static const struct soc15_reg_golden
>golden_settings_gc_10_1_2[] =
> SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff,
>0x00800000)  };
>
>-static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>+static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset,
>+uint32_t *flag, bool write) {
>+/* always programed by rlcg, only for gc */
>+if (offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI) ||
>+    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO) ||
>+    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH) ||
>+    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL) ||
>+    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX) ||
>+    offset == SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)) {
>+if (!amdgpu_sriov_reg_indirect_gc(adev))
>+*flag = GFX_RLCG_GC_WRITE_OLD;
>+else
>+*flag = write ? GFX_RLCG_GC_WRITE :
>GFX_RLCG_GC_READ;
>+
>+return true;
>+}
>+
>+/* currently support gc read/write, mmhub write */
>+if (offset >= SOC15_REG_OFFSET(GC, 0, mmSDMA0_DEC_START) &&
>+    offset <= SOC15_REG_OFFSET(GC, 0, mmRLC_GTS_OFFSET_MSB)) {
>+if (amdgpu_sriov_reg_indirect_gc(adev))
>+*flag = write ? GFX_RLCG_GC_WRITE :
>GFX_RLCG_GC_READ;
>+else
>+return false;
>+} else {
>+if (amdgpu_sriov_reg_indirect_mmhub(adev))
>+*flag = GFX_RLCG_MMHUB_WRITE;
>+else
>+return false;
>+}
>+
>+return true;
>+}
>+
>+static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32
>+v, uint32_t flag)
> {
> static void *scratch_reg0;
> static void *scratch_reg1;
>+static void *scratch_reg2;
>+static void *scratch_reg3;
> static void *spare_int;
>+static uint32_t grbm_cntl;
>+static uint32_t grbm_idx;
> uint32_t i = 0;
> uint32_t retries = 50000;
>+u32 ret = 0;
>+
>+scratch_reg0 = adev->rmmio +
>+       (adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] +
>mmSCRATCH_REG0) * 4;
>+scratch_reg1 = adev->rmmio +
>+       (adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] +
>mmSCRATCH_REG1) * 4;
>+scratch_reg2 = adev->rmmio +
>+       (adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] +
>mmSCRATCH_REG2) * 4;
>+scratch_reg3 = adev->rmmio +
>+       (adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] +
>mmSCRATCH_REG3) * 4;
>+spare_int = adev->rmmio +
>+    (adev-
>>reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] +
>+mmRLC_SPARE_INT) * 4;
>+
>+grbm_cntl = adev-
>>reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] +
>mmGRBM_GFX_CNTL;
>+grbm_idx = adev-
>>reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] +
>+mmGRBM_GFX_INDEX;
>+
>+if (offset == grbm_cntl || offset == grbm_idx) {
>+if (offset  == grbm_cntl)
>+writel(v, scratch_reg2);
>+else if (offset == grbm_idx)
>+writel(v, scratch_reg3);
>+
>+writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
>+} else {
>+writel(v, scratch_reg0);
>+writel(offset | flag, scratch_reg1);
>+writel(1, spare_int);
>+for (i = 0; i < retries; i++) {
>+u32 tmp;
>+
>+tmp = readl(scratch_reg1);
>+if (!(tmp & flag))
>+break;
>
>-scratch_reg0 = adev->rmmio + (adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] +
>mmSCRATCH_REG0)*4;
>-scratch_reg1 = adev->rmmio + (adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] +
>mmSCRATCH_REG1)*4;
>-spare_int = adev->rmmio + (adev-
>>reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] +
>mmRLC_SPARE_INT)*4;
>+udelay(10);
>+}
>
>-if (amdgpu_sriov_runtime(adev)) {
>-pr_err("shouldn't call rlcg write register during runtime\n");
>-return;
>+if (i >= retries)
>+pr_err("timeout: rlcg program reg:0x%05x failed !\n",
>offset);
> }
>
>-writel(v, scratch_reg0);
>-writel(offset | 0x80000000, scratch_reg1);
>-writel(1, spare_int);
>-for (i = 0; i < retries; i++) {
>-u32 tmp;
>+ret = readl(scratch_reg0);
>
>-tmp = readl(scratch_reg1);
>-if (!(tmp & 0x80000000))
>-break;
>+return ret;
>+}
>
>-udelay(10);
>+static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
>+u32 value, u32 flag) {
>+uint32_t rlcg_flag;
>+
>+if (amdgpu_sriov_fullaccess(adev) &&
>+    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 1)) {
>+gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
>+
>+return;
> }
>+if (flag & AMDGPU_REGS_NO_KIQ)
>+WREG32_NO_KIQ(offset, value);
>+else
>+WREG32(offset, value);
>+}
>+
>+static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset,
>+u32 flag) {
>+uint32_t rlcg_flag;
>
>-if (i >= retries)
>-pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
>+if (amdgpu_sriov_fullaccess(adev) &&
>+    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 0))
>+return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
>+
>+if (flag & AMDGPU_REGS_NO_KIQ)
>+return RREG32_NO_KIQ(offset);
>+else
>+return RREG32(offset);
>+
>+return 0;
> }
>
> static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] = @@ -
>7888,6 +7982,7 @@ static const struct amdgpu_rlc_funcs
>gfx_v10_0_rlc_funcs_sriov = {
> .start = gfx_v10_0_rlc_start,
> .update_spm_vmid = gfx_v10_0_update_spm_vmid,
> .rlcg_wreg = gfx_v10_rlcg_wreg,
>+.rlcg_rreg = gfx_v10_rlcg_rreg,
> .is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,  };
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>index 99f58439f3d5..6e49b239087a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>@@ -734,7 +734,7 @@ static const u32
>GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
> mmRLC_SRM_INDEX_CNTL_DATA_7 -
>mmRLC_SRM_INDEX_CNTL_DATA_0,  };
>
>-static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>+void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v,
>+u32 flag)
> {
> static void *scratch_reg0;
> static void *scratch_reg1;
>diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>index 8cdf5d1685cb..14bd794bbea6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>@@ -77,27 +77,11 @@
> })
>
> #define WREG32_RLC(reg, value) \
>-do {\
>-if (amdgpu_sriov_fullaccess(adev)) {    \
>-uint32_t i = 0;\
>-uint32_t retries = 50000;\
>-uint32_t r0 = adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] +
>mmSCRATCH_REG0;\
>-uint32_t r1 = adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] +
>mmSCRATCH_REG1;\
>-uint32_t spare_int = adev-
>>reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] +
>mmRLC_SPARE_INT;\
>-WREG32(r0, value);\
>-WREG32(r1, (reg | 0x80000000));\
>-WREG32(spare_int, 0x1);\
>-for (i = 0; i < retries; i++) {\
>-u32 tmp = RREG32(r1);\
>-if (!(tmp & 0x80000000))\
>-break;\
>-udelay(10);\
>-}\
>-if (i >= retries)\
>-pr_err("timeout: rlcg program reg:0x%05x
>failed !\n", reg);\
>-} else {\
>-WREG32(reg, value); \
>-}\
>+do { \
>+if (adev->gfx.rlc.funcs->rlcg_wreg) \
>+adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, 0); \
>+else \
>+WREG32(reg, value);\
> } while (0)
>
> #define WREG32_RLC_EX(prefix, reg, value) \ @@ -125,23 +109,24 @@
> } while (0)
>
> #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
>-do {\
>-uint32_t target_reg = adev-
>>reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
>-if (amdgpu_sriov_fullaccess(adev)) {    \
>-uint32_t r2 = adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] +
>mmSCRATCH_REG2;\
>-uint32_t r3 = adev-
>>reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] +
>mmSCRATCH_REG3;\
>-uint32_t grbm_cntl = adev-
>>reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] +
>mmGRBM_GFX_CNTL;   \
>-uint32_t grbm_idx = adev-
>>reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] +
>mmGRBM_GFX_INDEX;   \
>-if (target_reg == grbm_cntl) \
>-WREG32(r2, value);\
>-else if (target_reg == grbm_idx) \
>-WREG32(r3, value);\
>-WREG32(target_reg, value);\
>-} else {\
>-WREG32(target_reg, value); \
>-}\
>+WREG32_RLC((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
>reg),
>+value)
>+
>+#define RREG32_RLC(reg) \
>+(adev->gfx.rlc.funcs->rlcg_rreg ? \
>+adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, 0) : RREG32(reg))
>+
>+#define WREG32_RLC_NO_KIQ(reg, value) \
>+do { \
>+if (adev->gfx.rlc.funcs->rlcg_wreg) \
>+adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value,
>AMDGPU_REGS_NO_KIQ); \
>+else \
>+WREG32_NO_KIQ(reg, value);\
> } while (0)
>
>+#define RREG32_RLC_NO_KIQ(reg) \
>+(adev->gfx.rlc.funcs->rlcg_rreg ? \
>+adev->gfx.rlc.funcs->rlcg_rreg(adev, reg,
>AMDGPU_REGS_NO_KIQ) :
>+RREG32_NO_KIQ(reg))
>+
> #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
> do {\
> uint32_t target_reg = adev-
>>reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\ @@ -160,10 +145,13
>@@
> }\
> } while (0)
>
>+#define RREG32_SOC15_RLC(ip, inst, reg) \
>+RREG32_RLC(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
>reg)
>+
> #define WREG32_SOC15_RLC(ip, inst, reg, value) \
> do {\
>-uint32_t target_reg = adev-
>>reg_offset[GC_HWIP][0][reg##_BASE_IDX] + reg;\
>-WREG32_RLC(target_reg, value); \
>+uint32_t target_reg = adev-
>>reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
>+WREG32_RLC(target_reg, value); \
> } while (0)
>
> #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \ @@ -173,11
>+161,14 @@
> } while (0)
>
> #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
>-    WREG32_RLC((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] +
>mm##reg), \
>-    (RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] +
>mm##reg) \
>-    & ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
>+WREG32_RLC((adev-
>>reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
>+(RREG32_RLC(adev-
>>reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
>+& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
>
> #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
>-    WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
>+ offset), value)
>+WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
>reg)
>++ offset), value)
>+
>+#define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
>+RREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
>reg)
>++ offset))
>
> #endif
>--
>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
>eedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C5418b86bcb4042c1a
>b1c08d8f404c823%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>7527648681476268%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SIC
>r%2FbhwrejJzpuhJmsnJiu6TP%2Fvu075po7%2BJ70Foec%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
