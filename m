Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53336C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 06:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F46F2073B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 06:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N+fKV9us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F46F2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D551A6E313;
	Fri, 22 May 2020 06:17:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 854576E313
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 06:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiePtTeN8A8qb4Xa+yIyB312LhNsZYlZEsN0Jjyku/LWQczh50F+W1aSMEnc40HYss5KYkxfD+R7tT+sJFSxHhqtwr7OOIf+ZenGrVm/YIVkskjoedNiq19YSTXDyKEaaWnF2paXlsYURuI7KW5j3T8209Ad5yz8TCn/KvQZhXH4lAZ8V5MNQCt2KiGbfF5rEDAQ53MPFWymkhfvYfMQyHoUSMAo3AApTxN8LIyiBXLecLQ9HUFm4tTTlEvA/aUWd99KNO32eKTxMbT8ky2Bqbb4pQcJPfD9M9lgshQw50my/GApytgvV8wcUiFc0Taeks7jGMWK7XAX39mm5nmXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNFBAT3z+H3GQYPJL9v0MFxxgfrq1emvtMdjLQZ3kTA=;
 b=mCNuXiF/38LZbsvUlcamYJ3kck4reyzNdf8yMDTnrcd7EdOuvrDYguEPuTj9Jh1NdKJAPA3A+RqW5lGKdplmb7i+bPS36054dpOfhrJBnqXVjSs5cq3C/M8LnFY4qj1Ev8dgTkCZU6/2+bf+V3f8ZZDBzNvARCI99qoAq0wJPfFtvYw5A4vZCxSw0W64QMIi+k6nKI9lUlLSZrTd4zaCoUykAZTEIC7VqNv1rnydcTz00JYsIpiu2y5WsNHNuY+9rvMhJKRNj5cU5TiFrlejb5OUrk5YGyGQpyWErGzkTgNr/TVO4WxR2BoK9SWQGTHtv6w6S3EehmT1Z4+kX7cLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNFBAT3z+H3GQYPJL9v0MFxxgfrq1emvtMdjLQZ3kTA=;
 b=N+fKV9us9U07oxH+3VHLqJjmlKirSebazROCxY5DYHgnPEGQBG3xwl8WdaMb0K+ASxDzsGf6HTQIZVjkhXkm1s0uPIsPLII0G10YBvp6y8iDU0m1Azm3TguH163tAUNvPL560GvR9LXZOaJqnCvN+llAzZQ/g7wdzzv/46x+NsA=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Fri, 22 May 2020 06:16:58 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 06:16:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Wan, Gavin" <Gavin.Wan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWL6l+XbGPfE28U0GMJWSqbrawzqizd/CAgAAW6ZCAAAv0AIAABcWAgAAAnkCAAACb8A==
Date: Fri, 22 May 2020 06:16:58 +0000
Message-ID: <DM6PR12MB40751EFA8C52945377342E77FCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
 <CY4PR12MB1287CCDE92924A2C5BC25FC5F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM6PR12MB407522AD24A74063B1771BFDFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB1708563850356414C1427EFF84B40@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM5PR12MB1708FA8F3EA7F11D2E2ABEC684B40@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM6PR12MB4075685AB7A9EACA3FBA71DEFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075685AB7A9EACA3FBA71DEFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-22T06:16:56Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1c550e83-853f-4fdd-9c49-0000cbb7974a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1799f3f1-d129-45a5-db4d-08d7fe17bbc9
x-ms-traffictypediagnostic: DM6PR12MB3257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32575A3F6C90D9AC40AD64C9FCB40@DM6PR12MB3257.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ttpflk3+4eQaa+BSrcbM+W/va6crpTd5KIFQWzDhMyglh7FXBKkc9X/HYrkE08bgdt8bdtSMLkAR0v2H9a1uzmuSdbQqwv0AGQpsQarIMO8T48czTvgE2yjsUP6yOTO+eFx6+OLkedtRfYjBdNDomP9V8gl+Emy6gYsJa0ODE3rUn6OliZd18ZeF3b0bmb6o3ZdBWyUEh5573vEOHpdxdwDDrtjnV9iOgQbWzbzgGejaU8XYXoQDGc+6O2avebrhikwk/PBw2NWc3vKHWcB3PWZe3oUJpcSoBP1sz85kGbxIdUaQtSs2KZfgrvmYb6lM2zKwxZ3DbmFqEdStYuu4qxnIw8uCbY8J8XCIQAIDzfr4Y+/dlAD06MCsP3gxDdwQ84q9qFAqPc0qL8v14a0UmvhWXcxtRN6t/r2DU/JcFyZ+D0Ws4O2StVEriP0JwXWLfh+0OJ++JaIxI5ag86AJBJLHL7g0/35IH/pxzidBzg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(55016002)(9686003)(2906002)(86362001)(71200400001)(2940100002)(7696005)(33656002)(26005)(45080400002)(53546011)(66946007)(64756008)(66476007)(8676002)(110136005)(4326008)(5660300002)(52536014)(8936002)(76116006)(66446008)(66556008)(966005)(478600001)(6506007)(186003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0z+kewhbDe2W4ot+eWD/nqR2uWbx8BPCeNxhjOEFn9jY6jIzKEntP5+B43Tr1EuRiQXKjfqQMX4O8WShh6XSpN+W1EV9eSKMeCr9hPOBqjItSdWOr5gvMYe7dbYbJYVHNBdOkySDJzXADq2Y4uNhDLbqAS2n+VcFL6OdxTAOI70Ac92ausrqEdJqvK/1P/+brZMXx+0JZ6eO38WJAHWJF8sgxyDG/77aeqLcNhAsbfjJrlhKQTSWd2d66HkD1xkndt0V/I2bRHAnNNg7tRi7WuWy1AUyIzsAPaqG57AjVz8ygW2Aok8Jqr7bisGF5kMz8WXwDwCo1iQz7UVwUhLkcipU71mjyEZ+OZNfYo2BKNBs4mfczW1aMKikbE2ELJ30e5l249p9MY4PxNzc6QOmbtCGFueXnsVNeYhvuwdDQanFuVEo25YduAHSFwW8Dg3Yg3UtxqxRU5xP4l/B+QehwcGSuJZr7bV8gJl+mGuhpeQpKiw0nl385KUVMqZeBqxX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1799f3f1-d129-45a5-db4d-08d7fe17bbc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 06:16:58.3261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uz/r7awnLpylUhIeekd8ozT0Wa93L4uL1ygZfbt1s+KwOyYoueXH8JhQB+m908wJ+h6UVVzGr0f+auEt4jx6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
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

Or make it in more reasonable place.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking 
Sent: Friday, May 22, 2020 14:16
To: Liu, Monk <Monk.Liu@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

[AMD Public Use]

Yes, please try best effort to not introduce guest/one_vf/mult_vf check.

Regards,
Hawking
-----Original Message-----
From: Liu, Monk <Monk.Liu@amd.com> 
Sent: Friday, May 22, 2020 14:12
To: Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

Gavin

Looks the only place you need to change is the part of avoid touching "CP_INT_CNTL_RING0" which is handled by GIM now 

Others looks not needed at all

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Monk
Sent: Friday, May 22, 2020 1:52 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

Sounds a good idea

@Wan, Gavin can you try hawking's advice ?

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Friday, May 22, 2020 1:09 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

[AMD Public Use]

Can we leverage existing CG flags to control this rather than add amdgpu_sriov_vf(adev) check everywhere?

If GC CG feature is programmed by host. We can just mask out the following flags for guest driver case (amdgpu_sriov_vf(adev)).

AMD_CG_SUPPORT_GFX_MGCG |
	     AMD_CG_SUPPORT_GFX_CGLS |
	     AMD_CG_SUPPORT_GFX_CGCG |
	     AMD_CG_SUPPORT_GFX_CGLS |
	     AMD_CG_SUPPORT_GFX_3D_CGCG |
	     AMD_CG_SUPPORT_GFX_3D_CGLS

There are too many amdgpu_sriov_vf(adev) Check in amdgpu driver, which actually add unnecessary sustaining effort.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Guchun
Sent: Friday, May 22, 2020 11:47
To: Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0bb2f0a4f21948486b3708d7fe14366a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257235100002661&amp;sdata=YG2D5uV7kD1mqPj3Bq8UicMrExQzyUaGIVJDxCryncE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0bb2f0a4f21948486b3708d7fe14366a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257235100002661&amp;sdata=YG2D5uV7kD1mqPj3Bq8UicMrExQzyUaGIVJDxCryncE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0bb2f0a4f21948486b3708d7fe14366a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257235100012654&amp;sdata=E7p%2Fkc5qh%2BxIvjGM5dxJs5VuqGHvVIb%2FeNeDemis07Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0bb2f0a4f21948486b3708d7fe14366a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257235100012654&amp;sdata=E7p%2Fkc5qh%2BxIvjGM5dxJs5VuqGHvVIb%2FeNeDemis07Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
