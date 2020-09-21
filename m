Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE58C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 04:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4010E20665
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 04:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f35xuAKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4010E20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF546E133;
	Mon, 21 Sep 2020 04:04:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750058.outbound.protection.outlook.com [40.107.75.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2386E133
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 04:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFScZhvmCp5LficRt4mnbvoTQ4Hg88vl2RYJ8VXQlB9ftR07naI6oS4DGS0DyuQ3KfYkB517VhQaQmPWNp5jraA+30WlqBWTKZ34fFnqGvOp8HSJNyO5LeRLRNiRAkSXa+c79X+AK6vnLtHDL+z88rCAztQf34kWJi+IWfknhvSiLss0pWzSXCV2tMZgSho2VQAIfKVmsx+gWLgjVCtp7krjr8YfTx1k0OnPK9sgFPZ4Ca6vw+gOJDdi4PVP0wSENv/kPqDDEX9/cOFTmRDxu/Xmu5FR3LK829M5jgV/ew3c0uIW6tzPFUbVfgCVMn+GgaRjE+/BxvqvzLz/luJnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAVSVBml8/In22WoZnL+E6iU4LN2svQfgVuWTq2xHZI=;
 b=lZdW4eTt7TQENMtASokPIYJgzWFOmKn8kXdhUVEATgq+dbxufFgMp89NIxNESpN6hF0prP4vmAvFVB+1gNGfg/TwNvqky2ablWLJdMn60i+uRH4ohWTktLPyEgKMe5HKe06yvPhVbc2m5VP5YgXbT5tJxcqvcY0jIfaWjVd9HvE+hpBFVAidKuJwTvLIfZ/sVWoT8zR11Kh4gwcSm+e7cPYs92Ncgrs75qwD9TNcWza9Uky2w4cFZd7M8ecoiTYBDkcX5XgsG4kNv0E3bmW2qmmqyx7luJv8sN0d2g3rspVsnxLjkNX9qttl7AeYlwWGo8gGZzcGXQvSlE7OLYENYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAVSVBml8/In22WoZnL+E6iU4LN2svQfgVuWTq2xHZI=;
 b=f35xuAKL7emdP4uZFjrwlUzYdJZr3juPzrbW4hAtRniMGBLdLDlEAsXgVk10PSfioUgdYddfsa0ePjsiGQX9zotM6++kHcNde8HBlE/e5K8smhZCJvEY1xMDmVhmx2G1cefFjtepWt4PNT8ExLZ6BdmCOPOFM6+wWqDc21eI8X8=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3334.namprd12.prod.outlook.com (2603:10b6:a03:df::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 04:04:02 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 04:04:01 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug
Thread-Topic: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug
Thread-Index: AQHWjWuhUqINnv+yrE+nHwqnt51Z+6lyfZOw
Date: Mon, 21 Sep 2020 04:04:01 +0000
Message-ID: <BY5PR12MB41154D90886681022A0BB4D48F3A0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200918032717.184758-1-Emily.Deng@amd.com>
In-Reply-To: <20200918032717.184758-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8697e4fd-f50c-4835-8a62-038105964d1f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-21T04:03:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a35258d2-5cc3-4953-4397-08d85de35fcc
x-ms-traffictypediagnostic: BYAPR12MB3334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3334BEC3299E4631D1A50B2B8F3A0@BYAPR12MB3334.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VVbRpj780wBMOqg9+DwdreX8DafBG8SXIvcNdXxQcsj97MKNiomPWmzTvgFQTqmysiE40RQ7+oHta9sll7WVt3NHrOjiLnVI+tvRxCCgkfViTZY/1z8L8Ux1U+NFhb47PQU2FClgufm5FcAe5mmahvouHx466gZ76CJ7r1DsCvzvSDaf/QMgqIdj/tPZrMPbtpC/tk5Qt+8lRARasFBehWV9MM3M/KLRxT3leG7db9/1BmW5kc2lxG9f+oVAEJCgIqybi1CCKj4Xo0nbERWZ27+gMOxh0J5tAXSEuTEYkxn9Mjh1QuBYQ0UHLsIAfllkvQ1xCNxs+zwCIgZAU7Kdn6Mgy7kQMcJkZlcwM7HOyv/8q0hP5f95tirU0SZkd4x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(66946007)(316002)(52536014)(83380400001)(478600001)(5660300002)(66556008)(76116006)(66476007)(66446008)(64756008)(8676002)(55016002)(110136005)(26005)(71200400001)(2906002)(86362001)(7696005)(186003)(6506007)(9686003)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: E1IG4eLqqWasFG+6as9b1kAJuFsXhrtSHRk59BaNdDCoLJXS4PYixjHQHM5wWpszcxVqR8aE3vFWrPnEjx7n1NsP53XtJIrkqfkDfw9fGI+YwQLOYL8Dxl3hK1PzPsB5X8PEo0hQz0txJ5HwSFjTKZwn384HYmwKsab9EukJnL31ozetH1NTrK38KQhyeyPrJIw/tGXVz5hDn2Vw+aU/S6AKB93AAoYcf562IpWz+1G9xfh4xcxVz931gALdwW/F1jZ+CmZxZQmAHMj2SNZ8p/xvOmkt4wcyAgahdti783/FaNYSEJThPeg3oolqIONg7X0RHycYbmlv83FcpFRyGbDmkCkg3rgIGHzrqRx6q4bBJRT/NChSLIjFtQ4AlWKO2RP2POf3/RiTHDW3LBOnfXPc9vfQBwSILFWlSYlJ5VewtX80+HhKISggk5lORdK42QNJCGH8/bpzj+UIhIHDcNu9kSDmuGGqSFJDsI1mS0K2znggRN0V/KuIXl2EnFZkAZTRebq9IeS9vMCMek3FVtD+I3AK2vFIgJvfhPJivt36cHmteCPSsWYrZJ+EpNHghGejBPF6D18F4dNNxTPWVONXxs497wrvwQODHcyvif6QERvwKZhOVX7YGTUULyj6xBUsCbFcep29C4DlInLcnA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35258d2-5cc3-4953-4397-08d85de35fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 04:04:01.8449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cvc/UboDX6sSuazQO2cK7feGC376HmX8NdL845ZGz7YkSVQeVfZM4vE5eEvjxNpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping .....

>-----Original Message-----
>From: Emily.Deng <Emily.Deng@amd.com>
>Sent: Friday, September 18, 2020 11:27 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug
>
>For debug convenient, add sriov_mcbp parameter.
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>Change-Id: I84019eb4344e00d85b2ecc853145aabb312412fe
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
>drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 3 ++-
>drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
> 4 files changed, 13 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>index 13f92dea182a..a255fbf4d370 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>@@ -183,6 +183,7 @@ extern uint amdgpu_ras_mask;  extern int
>amdgpu_bad_page_threshold;  extern int amdgpu_async_gfx_ring;  extern int
>amdgpu_mcbp;
>+extern int amdgpu_sriov_mcbp;
> extern int amdgpu_discovery;
> extern int amdgpu_mes;
> extern int amdgpu_noretry;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>index 3f07d1475bd2..b0b2f0f7be94 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>@@ -145,6 +145,7 @@ uint amdgpu_dc_feature_mask = 0;  uint
>amdgpu_dc_debug_mask = 0;  int amdgpu_async_gfx_ring = 1;  int
>amdgpu_mcbp = 0;
>+int amdgpu_sriov_mcbp = 1;
> int amdgpu_discovery = -1;
> int amdgpu_mes = 0;
> int amdgpu_noretry;
>@@ -578,6 +579,14 @@ MODULE_PARM_DESC(mcbp,
> "Enable Mid-command buffer preemption (0 = disabled (default), 1 =
>enabled)");  module_param_named(mcbp, amdgpu_mcbp, int, 0444);
>
>+/**
>+ * DOC: sriov_mcbp (int)
>+ * It is used to enable mid command buffer preemption. (0 = disabled, 1
>+= enabled(default))  */ MODULE_PARM_DESC(sriov_mcbp,
>+"Enable sriov Mid-command buffer preemption (0 = disabled (default),
>1
>+= enabled)"); module_param_named(sriov_mcbp, amdgpu_sriov_mcbp, int,
>+0444);
>+
> /**
>  * DOC: discovery (int)
>  * Allow driver to discover hardware IP information from IP Discovery table at
>the top of VRAM.
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>index 2f53fa0ae9a6..ca0e17688bdf 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>@@ -236,7 +236,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
>unsigned num_ibs,
>
> for (i = 0; i < num_ibs; ++i) {
> ib = &ibs[i];
>-
>+if (!amdgpu_sriov_mcbp)
>+ib->flags &= ~AMDGPU_IB_FLAG_PREEMPT;
> /* drop preamble IBs if we don't have a context switch */
> if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
>     skip_preamble &&
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>index d7f37cb92a97..156e76a5a6e0 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>@@ -742,7 +742,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev,
>void *data, struct drm_file
> dev_info.ids_flags = 0;
> if (adev->flags & AMD_IS_APU)
> dev_info.ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
>-if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
>+if (amdgpu_mcbp || (amdgpu_sriov_vf(adev) &&
>amdgpu_sriov_mcbp))
> dev_info.ids_flags |=
>AMDGPU_IDS_FLAGS_PREEMPTION;
> if (amdgpu_is_tmz(adev))
> dev_info.ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
