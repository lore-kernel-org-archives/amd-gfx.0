Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB03C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 03:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2474E207D8
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 03:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aC71RkGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2474E207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E5A6E983;
	Fri, 22 May 2020 03:40:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2A889F19
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 03:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoZ3iw7/XjVIpKlS3u3tAsjXVFvxOKwCKuWgDakE1fwq0+lwgD3lnArjW84S2iq/7y+/B4YuJCNzqbyBkqz4xuZ/tKY5k3yRUd/wK8ChGWESHkbPEO9z5RWoaQ1yetYuiBHkjY2lqMMUl6A13WCztR1R+gWYEdVfH7K16fEX+iT/8tU8s0r79/w/b2FmIgo40MaLW5FUE+YDUUcWWZ8a+2TTPDvjdv+hfQCI971dr6MS/XiK4rHhfIcOZU6PN6QIyE1N1TSnX/ubsKeAtd3JnxpTZ+EyeQ8tZwGbeoot6kJNRszc4cbxfYLQMpX7GSCkBHXtKmxeOX7NoeqB8GF41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpc7XmhUlWUcvn/4+5jreGQz+hNf/Uajh5WmCqbbrNI=;
 b=BVY27y0ZzaqJcv4xECAr1nLp7ey5jueDsr5kwe8hfzUf3pccrKJAgf/4HjfiCNYxMRycKrwC8EFoDPVG9n5hvdrWHBQQ2jMbAJ/RPdnuFu2m9329x+p6/MQliGV3mZpz+UiDkqaae1fGucnDVCxJRVYtK26ur/zgNHyMMxL5GLqATJwkdOzogKfdRAft8JsKVszjHkiiMyUWCiaFZXsquxdOVbzJ1Ap+SVAwH6/6mD8VE7+VHWLRWL4kxhTcsdxzKztpmtYXuIXrVs4jGHLKcMcWY48nI3zmj4JtzWSFKZRbGypSeSt50zBo46yBEp3ZGTjF2L+OW8ekY//ZY+oBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpc7XmhUlWUcvn/4+5jreGQz+hNf/Uajh5WmCqbbrNI=;
 b=aC71RkGLxyEucuKy+pvjlG4sWNp++TQIKMsenJXgNdUfuUHXYxXEZ/v8IaS/UoLl3e8F30UejcpQgjEysNhbRjtvWH2xQ9w2PtgqyjZNMLUcuoxDk+l/1E9CrJOVtJk7FWMPSpQ94OJvGXjGNNYZxku+NuNSe0drkC/XL3ZzBzc=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 22 May
 2020 03:40:45 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 03:40:44 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Wan, Gavin" <Gavin.Wan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWL6l+4Ytr41evJ0yEh2yg17cX8KizdiZA
Date: Fri, 22 May 2020 03:40:44 +0000
Message-ID: <DM5PR12MB1708959808DB4123138F545484B40@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
In-Reply-To: <20200521195306.261777-1-Gavin.Wan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6165eb0-4471-4a39-8348-08d7fe01e8c4
x-ms-traffictypediagnostic: DM5PR12MB1916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1916EFF0E708A8BD53BDF75384B40@DM5PR12MB1916.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Gwqtt135YVDDq8TvMlMnpyAxk+dd8+nSv4DpU9mTIQLstvCzyFLzAJY/8NimyPX2H81CTdLHLUP94/qq0Sg8440fJ4Riv+3dK4pdTcD/F07k5gPcB+Y1pNVFmWhSGBigMqreGkY6fDQF7b++Kscw1+Rhl+T/CGORoNSI60y3Gj3SkUyNxxDO88nJqSEkX1GmYkaU9Wiblm7pds3qbDPmt3Xiok/L3C1TSF4wnrkysmu1lBZ7JmBTj9ZiG9+OKDSxgfAVxFrEyPcjm+GYM6SEviGWIIP3102g7lXL/iTQhDWgOqYE/1iCJVSPnPHxBw+AvfKfI2SrWfbPDh7kC0RrAxYI7aie+PZdayWQUmXIUqEP8+zYcStHSaN6x7yIJBM3ZeMIN1xlXlQLmgQzucBx5P+9vibp6MzGSuX/UiLX5twHka0ee9ZykIVvklAODV4tHikDG30iACMbcF8tLBCNDvt5Ghsun9xKslv7TqGaFU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(966005)(478600001)(26005)(4326008)(64756008)(66446008)(7696005)(6506007)(53546011)(66476007)(66556008)(316002)(33656002)(66946007)(5660300002)(76116006)(9686003)(186003)(55016002)(52536014)(71200400001)(86362001)(45080400002)(2906002)(8676002)(110136005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fCXGD/em28th9raB0mdKDAjpI617Rf+zEnKzYQ7jQoU+NF3Dm7YU6XlWp/YwMBJeIwjkLDoF/1k83Yq8pkx9EebC+vJPHcHl66hYG9r4xEEobPb05BpvmmEe3bcpuclwuzM3KWLSkCXgygAtwVIL9/UNQmTSj3iNo/Beb68Hv8+SOU5XUfIeNowtRSicR/70+g7o3l+IgabWi0Q8drWQYbpUYpwBdWSgWLhCNJqp1o55QQy5xMMwcEN6YD8EVGfXpG3EfYzCn5a3qYPLx9ypc1SHRGMBcCQfCyP8OWLJg0VqAhRa2P0vap4LngIKF/fa/lvXQA/VduKbHn7fgrcKzKOyoNI0Tj/9lX/Ykq6sxHH+yPaGIRYhLJvv2k4b7sDmvVuzuwX9qTgN2Jx1D9z2+/cawB13BcjZfjIpM2DkPDbFDpjaSIXXXVi3vz8nPpml8BgkrkOTnzvZJXwZiBeUxLeHpkA6teA8J5JmTY1s0hvBiFTQjFV3v75P8w16PQvx
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6165eb0-4471-4a39-8348-08d7fe01e8c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 03:40:44.8370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcxLC6qvGQzqeqUPqNg24dm2ua/mPEPT8rUYue+T3rfJGCy0EnwW05SMIu+5ZKh9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
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

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0539b7a16a5f488b7ddf08d7fdc09f30%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256876073183596&amp;sdata=gIakEeKOfji3Z29RdDojiPDtCegcfcCvFP0%2FOVFeSaQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
