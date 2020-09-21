Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E3C43464
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 06:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB6F20756
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 06:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2QB+Kd+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB6F20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1752289F31;
	Mon, 21 Sep 2020 06:45:20 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C6589F31
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 06:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3+BNRiH/gOLFBIDvZVGWKDN3YsdYGKSlbB+P8bBr2MRP7SUmBkHjcGrnflRnWAkwn7f0azYlHOwUltGBbP5m9qgKnAwlJz0VALegwwWJDflWM8oRyuxOqsmFFt4gfYbUQWfIiKjuNUC/hL1Kn5/QJ/FjsLtXoVDS+YIMW+phc74E9+zTdFkS/XgftqM0m2xNUeLXl7G1hafpkI/exERxNCMz3UpPUalTiQTeBGo7pVeWCYkZb8k4CKNb2YEdLtq2EdWipK7r8vimzIwXGldq/y0bTN2z4x71dWM5yHVBn2dyCMdijs0aUlXNGD2rMnN378PRtSdDQHwmNOrp1DhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsBAVQh5DhQQCaJcDPp1ghtcjsqrfMfRpZlu5xKI7tg=;
 b=AnnyD7O5bjaZWLWGitORYBp4sxiDnixteZ7MgL9p8OJ7Zf0t0ZFUAPLXS3lcpsgd5ALGVVhRDcaITREMdQCfNtcPw4Q/ndzxeOoe3BdugyT9avC1i34uQr8gh3cSKeGOBPvcrDWy5iMsIk7c8bYluYWbDGllT+eqBhcFRnPwsY4L+D1SUa+9qfZ68wXs/cEsvXxSi0S5uB14RLohTosXpbFlAPB99Z0x8hImIbBXSFkAkw1uUyNggPENV0QvZRzS62KqBR6FiqPQWxlxjf3KBu+GmIys4T2+LYjHuYdYaPCG9zt0ihscCRN1Fh4qGhuGuF4EnfgtuYp2J5UMFHTqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsBAVQh5DhQQCaJcDPp1ghtcjsqrfMfRpZlu5xKI7tg=;
 b=2QB+Kd+02SF9AtlkqYYPmc+XJkjQGAnsaNv62WEmZmN+2+qrT72Cv3UnUEXtSp6wvZ2sqKgu+A9t1BrJOx948cK7upbNs4fjn3Y9cKIpB9DUfZyWit04f0PhscSF9KVGZuL51l5POpTmk8LCJUz1qRe2HYBNkKdPlVOrG9wR/9E=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 06:26:05 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 06:26:05 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug
Thread-Topic: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug
Thread-Index: AQHWjWuhUqINnv+yrE+nHwqnt51Z+6lyl6YAgAANkFA=
Date: Mon, 21 Sep 2020 06:26:05 +0000
Message-ID: <BY5PR12MB4115BA1D9AAF9D155CD54B468F3A0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200918032717.184758-1-Emily.Deng@amd.com>
 <DM5PR12MB170840A1DBDA0DC13AE71368843A0@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB170840A1DBDA0DC13AE71368843A0@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b0797491-070a-4531-9d4c-000001bec29f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-21T05:28:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69489a65-17c6-49d0-f661-08d85df73818
x-ms-traffictypediagnostic: BY5PR12MB3970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB397041C0203F7F585178AF1F8F3A0@BY5PR12MB3970.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V0IQWuFuEi/kgab/10VfpZdTifLJnfHUBhcvj21CR4mqZfcd3JyWtOsbIkiOvsSVdE4x5TQcNnNQLPXruLC/9aV6KYfiENDoJcLlSAVTUFYzgg9EkzdVxduOHZWdIXpR8FW2WlDoVOBvpvqpbF55/TTRRlI56UrVH9PVdYUkbM/YTYZhnnvuPI9qEsETA8BODAn4YBmBQJ7Zq1Y7mVSXMYzXwKa7OhuShkvWDP0j/IOn43woZUNaG9V2+a+QmOTy94s323sL9D9TaUFfzIRZzNyXuQtffP6PSRELvpYgfBwP5Gn4jnXOol4IPrak5ZlpqVO9PDH/KBKmkUsgReCgqxS7j9uCLSOaiYPcoBMQBAsj6qT3uGQbZ8OXiqeqyI1a9PRW6SAt54B3JqQ4UQvJ0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(64756008)(8936002)(66446008)(66476007)(66556008)(5660300002)(8676002)(33656002)(45080400002)(7696005)(83380400001)(76116006)(66946007)(2906002)(478600001)(52536014)(316002)(55016002)(186003)(9686003)(71200400001)(110136005)(26005)(86362001)(6506007)(83080400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: E33ps9R0SG6xT2ibcOVCcCc58coHwYgylCz4slRD5BHybAJ4j+OpkP21y3URqZFjkHRZ9Jnj4HI772QGL+jlpe/nVnep8woBLD92X03hrMdIKOk2PyDsMinDhJ55sKch3GX3OnxygHl/2OCv8QoIg+tEtaHlS5V5J+cM0XGdJnQNTkw0nW3y1nbHgN7/pIggJUgXMWbpbmpjYlsZRo24uPl6IG7xfvWCccZPWq1/Cr+gAAf3ToMEWclVK8MfYzFHozQGnnOZrkaz6Jam3c7M3Vq8CSXGmkxXka7U/MTnK4n2dKC+EwvqCx2/pgWBUB/FgkNRsWxaQ2EQtYO7ehCynnKhKa1GMNiZOCw+hlLKs21qJx3PkiH9f3avdVZaqO0PNQeg0ldjmzIeHvkzEDbob0NG+FntxKuDM8XsXMEXneiLDlV0Cv7MmjHhfgT6GhuoaL3+vSrzoBro0HLHZM24W4+NW29WUcibtzC37BDlDvi8TjfG1Npeaawfg71Z5wMTf/82RiSrYsZBQWF4Qzh4y6RXWyFRQXswvYarNl6xIeGx08pfmPl4eJP2zXNIT5MGtyv6CyBLGnkFVV6PEIA9/v2A0jSjQdzhNRw9ok3D/o5oeeZsDs4odnpNanZz9glS4ZXr9IW0utNwvbQDoGzxkg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69489a65-17c6-49d0-f661-08d85df73818
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 06:26:05.1165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pk6OQ8DuSudrWcfy6DtEiPZsBE4ToF0mBjzrn8vtzrOAISs7UcHzzoYHlet/D2HK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
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

Hi Monk,
    Good suggestion, will send out patch again.

Best wishes
Emily Deng



>-----Original Message-----
>From: Liu, Monk <Monk.Liu@amd.com>
>Sent: Monday, September 21, 2020 1:37 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp
>debug
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Hi Emily
>
>There is already a amdgpu_mcbp parameter there, can you try to leverage that
>one ?
>
>e.g.:
>we refactor our driver's code and reduce the checking logic  from  "if
>(amdgpu_mcbp || amdgpu_sriov_vf(adev))" to something like
>"if( amdgpu_mcbp) "
>
>therefore:
>1) You need to force set "amdgpu_mcbp" to true in the driver's init stage once
>the "SRIOV" is detected *and* "amdgpu_mcbp" is not set to "0";
>2) for Bare-metal, we just leave "amdgpu_mcbp" as the value it was....
>3) we interpret  "amdgpu_mcbp"  as:
>0: force disable, it will be "disable" for both BM and SRIOV
>1:  force enable, auto (default), it will be "enable" for both BM and SRIOV
>
>This way if you can disable MCBP in both SRIOV and BM by that existed
>parameter instead of introducing a duplicated one ...
>
>_____________________________________
>Monk Liu|GPU Virtualization Team |AMD
>
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Emily.Deng
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
>@@ -578,6 +579,14 @@ MODULE_PARM_DESC(mcbp,  "Enable Mid-command
>buffer preemption (0 = disabled (default), 1 = enabled)");
>module_param_named(mcbp, amdgpu_mcbp, int, 0444);
>
>+/**
>+ * DOC: sriov_mcbp (int)
>+ * It is used to enable mid command buffer preemption. (0 = disabled, 1
>+= enabled(default))  */ MODULE_PARM_DESC(sriov_mcbp, "Enable sriov
>+Mid-command buffer preemption (0 = disabled (default), 1 = enabled)");
>+module_param_named(sriov_mcbp, amdgpu_sriov_mcbp, int, 0444);
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
> /* drop preamble IBs if we don't have a context switch */  if ((ib->flags &
>AMDGPU_IB_FLAG_PREAMBLE) &&
>     skip_preamble &&
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>index d7f37cb92a97..156e76a5a6e0 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>@@ -742,7 +742,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev,
>void *data, struct drm_file  dev_info.ids_flags = 0;  if (adev->flags &
>AMD_IS_APU)  dev_info.ids_flags |= AMDGPU_IDS_FLAGS_FUSION; -if
>(amdgpu_mcbp || amdgpu_sriov_vf(adev))
>+if (amdgpu_mcbp || (amdgpu_sriov_vf(adev) && amdgpu_sriov_mcbp))
> dev_info.ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;  if
>(amdgpu_is_tmz(adev))  dev_info.ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C497edf57e53b41a055f
>c08d85b82c709%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37359964547689160&amp;sdata=zXlPTG939tdC0sUbCntiJuGsZHpM15DqWmg
>y8SmZ2Z8%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
