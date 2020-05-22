Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B829C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 03:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D229F207D8
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 03:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XuYsw/DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D229F207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760A16E977;
	Fri, 22 May 2020 03:46:57 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760054.outbound.protection.outlook.com [40.107.76.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BAF6E973
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 03:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB0UMdfk/H/O8AO1R4xrrZjHKJJC908orn3b2/nSuv5toxmvdAgyqD1Id8Ub62GLoiYu7AN5NTi0SAp4nETtEq5Bt4pTZ7V9vFiaVxm5fLWc9OkTeCg/nm9si/GyKc3hP2MrAX1pFtfOUQc9jx1gAqm1okLfgOBN7LE+f327MmDh/DzG7mLFhf9tXDPVyEhzM9sq5grrXrp4Alcj7EtfppSbnBbxstwOdHoIa1ASza6lvnU4mZc7U3gaQLRC8r0eP3HyEXpTp0Hwu7ErvwZxW2H1SKg2MQlXKvC7HZ6ItTyxslXLFvMKRedSFtMxgwBc6S1qdFgoJWojN7FyKKBw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP3HoNGcHcZSIiSL1BuPV5MlaVPSSu2+QOlyHT4QGPU=;
 b=liK0ZCsVBgFq5qubF8Lb9or1SlCsSW9ms4x2HHc7RiRLf6MkrWcZSvlZ36qSpuxm8/HKz3oKV6pbIc04HSdEo/KFv06qYLa1s8lSG4nhdRmKXwoA6AIaUneuzrPMRbwYUoKkZhbUQWqFDnBAQ+rJ3A9OedyFxJ3+SduNlF8r2mQ70ZIFi+JYziVLIZTeI9aXPK5CYCp/1/QtiDfVzZKlZU01qlyL6dxIbvIKaXXSncr+/NfwSX9NYiUmFLX5xoDAx6xW6ZwE2LpJBlQVlzy8AWwB9MOK+rtxVaAdmzzFLTTA9K++C+thjuIYoxeBAMHn/5Wo3mT5gsF6jE6Ch+nhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP3HoNGcHcZSIiSL1BuPV5MlaVPSSu2+QOlyHT4QGPU=;
 b=XuYsw/DQ6uK0knnMn2AwSQfmmlutbDyZtSz+W52JMp91n/3FM9Oy+5z6IUEyq55n5UI9poEBH3VXva9N4x4ZsmDQ9FVpidsFHuxDL0si3i1pJs4W4Obo4N+zec8S9C+4Qhej3olQPcQ3R/1HEpj0qa737ytIb0SpG5w+woBhd9g=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Fri, 22 May
 2020 03:46:54 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 03:46:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Wan, Gavin" <Gavin.Wan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWL6l+ZDqm4xJLv0+i7N4NyOhlEKizdrsg
Date: Fri, 22 May 2020 03:46:53 +0000
Message-ID: <CY4PR12MB1287CCDE92924A2C5BC25FC5F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
In-Reply-To: <20200521195306.261777-1-Gavin.Wan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-22T03:42:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=56b9b592-8362-45e3-af5a-0000edae5c03;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-22T03:46:51Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8998e178-3165-4b39-af74-0000a97f5ec1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e9d2215-0bfa-47e0-dfa4-08d7fe02c4d6
x-ms-traffictypediagnostic: CY4PR12MB1846:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB18462214A65DC82795C596D0F1B40@CY4PR12MB1846.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 345nG3QhEG0u7Gupr1WX3n9ZaQILc+D4+rjACwOwuYYjaP4kJ+FX2QWbIHoShEYe3rOCDG0BuFA9TpwwgPv9Tf7wXnJ2j2B1XQWuXJwYi5svpE8ljN0qcRQTihpKneOA4iZdhe4BCTwHMNBxPRug9HjxnF0JPJHwmCpYrpg0u9nAowjsh657HZVwO5nBO5P/RDgxFbsTDxhfEW0Cle7lNGZZ13tn2miS+TBQuai774tk+O9rQR0BthWZHMCH45j06xDb6OM+cy32Sn0e7+X8h+PtSehyXehFlXhmNP/C4QVmPCEV7loba1WqEgP9c7QcMshHfk2P0CSdruG99zlDsIqDIf5ADgQDiDx0o8Vf0qbrlWZ8VSeXfmUFFRjoDYdXMEdNdYRr6OLMcA45LZE9p4wl9LF1cTGiVIxzk1O0hmdffIveshQzsG3yprCmHrUcLQhpoY/MQNvp0F4ZF2iyzMpH9Sc9btYUBLIzj7AEqDM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(45080400002)(5660300002)(2906002)(478600001)(110136005)(53546011)(8676002)(4326008)(26005)(6506007)(8936002)(316002)(71200400001)(66946007)(66476007)(9686003)(7696005)(76116006)(33656002)(66446008)(66556008)(55016002)(186003)(86362001)(64756008)(52536014)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mBS9nKPNYcpJ+iC6xmCfa/RpPOKJ0DmY7Z+oaQFMROMBphx/XRZnM/jbg2eNe7KtDDDENK0C4AUuZlIm0ZRw8EhEi5ZyjVsX5sTScBi7bcotFpqiya1+tRYYpzk6o2gdBAnVFnkO2iNxeXvjcSs9CvtTq5uXaNSkWtv8lgAlOmAkTDoTRNlgXUircjVH3CSpCjyXT8Ehd81hkx8CcmNXC2FAL2g064NHk/NX6WxbH0LoJ3RbOJaB4xbS44YkcpZNLdiVzZBnkt4AoKENHKfqEj8u3gFdVCJCwzACB3NkkufSIseUfkEPSQl8uPj/860/VCbsLlZqidczfN3r8EyDELyM3QBHAsW5R/+ttZGDHPm87YY9SPZIxBgoh8H9/+9IbHVoTjpyyFl/GU0/zxaqBZOpYnhv84DvxrFwHJ4Hnqowp/b1KYLivJJI8rC3a7sxahPn+vD6p/AE1VhgQ/LQQxy+8lyDwwBU1+6/w8zeCLTFnCvwYVP1+fD+fEVoKw1s
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9d2215-0bfa-47e0-dfa4-08d7fe02c4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 03:46:54.0591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AZwzcfqHEgpR0jg/D1OjHBV2gNkukjpFilMVahHDBzDsEN6ZTU8e43B+XIk/d4IP6YWYy6Ksyjtc+4TurFHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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
Cc: "Wan, Gavin" <Gavin.Wan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Please see one comment below.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gavin Wan
Sent: Friday, May 22, 2020 3:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

For SRIOV, since the CGCG is set on host side. The Guest should not program CGCG again.

The patch ignores setting CGCG for SRIOV.

Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index bd5dd4f64311..52b6e4759cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4558,6 +4558,9 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)  static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
[Guchun]This coding style is not correct. You should put the check after the declare of 'u32 tmp'.
Maybe it's better to split below line to declare and execution parts respectively.

 	u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, @@ -6842,6 +6845,9 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t data, def;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 0 - Disable some blocks' MGCG */
@@ -6911,6 +6917,9 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,  {
 	uint32_t data, def;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Enable 3D CGCG/CGLS */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
 		/* write cmd to clear cgcg/cgls ov */ @@ -6953,6 +6962,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t def, data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -6994,6 +7006,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C0539b7a16a5f488b7ddf08d7fdc09f30%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256876068046189&amp;sdata=wMjQV6VwTBu8pCfQjXf39e1ffQSkQHKkZdXyWjue%2FJk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
