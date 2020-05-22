Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66B1C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EE5206D5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vB7NrKlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EE5206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B2B6EA27;
	Fri, 22 May 2020 18:23:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54DD6EA27
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 18:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arKibSCA7pNlS9MjnxVysVcDzVLTPEeNLeJZtim1CP5x/Um1PF1V1zS+oTSOQBhJ6QI0UsRz9YxV6fatmoHj2GKSErg21WcydNkSkFGuwPs50rq1eIAjUvkVOCzYWBaw+Ta6hQ+VeFLdWVJtb2BAgg7aD6kboPvO8AgHcvAOpm8ymtX5mClaMpRopoNqCxz6IBIAWg0XNyfTKT3xCftf/MErYxRGWakOPlDE1rJGMqKqDhGe262+e7a6saxK92VXoz0/rGgMsN+GEGgP0+oYmm4Fb6sylkTUS9o18v+i8uVpfgkHUkSXIQdIE3dfYiyt/LSMCH8+XGWe/dW31i18ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7ns3fU1G/dhE/b8yxiEg0Y73UjGHDrn6sGCL9UERx0=;
 b=duxtLOxIBD5gjAoEkLLBvN+9bIt2GXyuiMRbw7273+y5B34GAnk11oV4uFbMwnQiH7Gr2Es0Ic6sExdRFGDVQ5MjvSTtW5y1EG5iXlACIKDNu8d5NIVe8inIAh1zeJMLhChbjc7HK3W0v+hJAaqFzBvRteL9wMeXACeAZADm5jzAsMn6qjsHP8HAQYZvUMyRL7s+f9qenWA3I+JDbE6qf5jR1bDhYAV+vlN7qQ1VuGo7QOfHiCHnyR9YJQPXGNR/dJuBqGZQEHHkujBrRq5HaZxFoaPcAtkQbyPo5Zk8K5k1+Rc5iCNd/PE1N5tCulULoubVEqmO0sysGunPtOdeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7ns3fU1G/dhE/b8yxiEg0Y73UjGHDrn6sGCL9UERx0=;
 b=vB7NrKlrPzW2CcHMyUoWL8KED6+ZcVXrG6fJUAsXcnoh1XFhnoFzpMKTd+HatkI/XCK5Mtl1bmYhX8f9t3xds7Inh+KR89s3LqJAFd7wDL//U7JTtcf6g6PlGD+/RqhdDUkwmWa5L6OEA4qAPQxgssvLxfSMtcAXJoXVRmzIz8k=
Received: from DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14)
 by DM6PR12MB3482.namprd12.prod.outlook.com (2603:10b6:5:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Fri, 22 May
 2020 18:23:14 +0000
Received: from DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c]) by DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 18:23:14 +0000
From: "Wan, Gavin" <Gavin.Wan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, 
 "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWL6l6qxPqjJIJxE+R0RoTtyzhRKizd/CAgAAW8QCAAAvsAIAABcWAgAABF4CAAAA2AIAAyinQ
Date: Fri, 22 May 2020 18:23:14 +0000
Message-ID: <DM6PR12MB4121D54AFD3CC67D18941847FCB40@DM6PR12MB4121.namprd12.prod.outlook.com>
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
 <CY4PR12MB1287CCDE92924A2C5BC25FC5F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM6PR12MB407522AD24A74063B1771BFDFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB1708563850356414C1427EFF84B40@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM5PR12MB1708FA8F3EA7F11D2E2ABEC684B40@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM6PR12MB4075685AB7A9EACA3FBA71DEFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB40751EFA8C52945377342E77FCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40751EFA8C52945377342E77FCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-22T03:42:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=56b9b592-8362-45e3-af5a-0000edae5c03;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [198.91.162.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d45ba6fc-6e4f-4b93-73fe-08d7fe7d30ef
x-ms-traffictypediagnostic: DM6PR12MB3482:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34827C53450F6EFB2430FF75FCB40@DM6PR12MB3482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LAnOVUE+blXP3mbcAJRiDRH2rtXfZ4pyOXvTkeC+T7/HU0gkLhpz7Z4gRZeiNtxJkaYWH4MQzioY9GvId2zStXDDsNsMkJBaEAxNl+AV+ZucEGmcPwJA++Z9Igl66PQxAX1IaCydEFKz5fub0DkbLDakzYswuGNRDafEsUCf4A6PhMUFlX1+xTTZPvGjZZvjXS8Qd5/cQBpjDxKf4Dj/kZ3ZFu1t4U694P8/M+ddclJB72X321nh/H775WYkczwvDIYDDcmyrrhuy39CZvior7LKbB3x9+dGtHHeXjG6ZUwEMuiYinKSPbVi4vS6pdYGBW99M4QY3umlSr/ulNV+wl6nq5yjpb1OwyWeDmmnomVnqkbPtL/IW58tTQ+aWE9emkO2oTN1XbFmTsw/CaoHFqx7+qZ57aN6ovbNnnRJU822J8aZF+ghi6DbbM9QMqbeFKJvfrR31yPhRvsfILyY/SnAMHZVzfgOJW3WwYJqr0A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(478600001)(64756008)(66446008)(66476007)(76116006)(66946007)(9686003)(316002)(55016002)(966005)(110136005)(8936002)(66556008)(52536014)(45080400002)(86362001)(8676002)(26005)(33656002)(6506007)(5660300002)(71200400001)(2906002)(7696005)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3Kb4wEO1UJy0VA0SDg+RRlCw2bVhR0dOjLDrQeqY77/IG29kIp7v5IpP/13q82tYKryzU2IhxslmJ/HUzchVBqGR6SBHRqS/QNYD5Pa63pzKNO9sfcXynS8Z4hcF/UDrnXYcMl1DlGX4xzlTq++lY5x7kYrt/U6SiCUWzgExC4TlEv0MibhHm1jg7GaBDq7gnNtiE+3gvQeNE+ulBQKU+bJsqY/QDsOuqLl/bbaJhqHmiAYhk5TSBVGHQNv9GvOhI6MpZp795krzwZcu+zCHt3xfi3OBSO4ma2YLzTJ+OuBqzI53MGlZznGzGTa3njpaLEteBNn2JlFqRup8VBHYdsXlWDB16Z341ecgwYD/7iIrtttAksj3JO3KOCiJW6n3bcz1Kj1ddW0OqJwkaz0SuiGMeMgXZcuiFktkIT0OnlQllKzTbz18lo6WGdBidUJoWQFUVjd6ZPanIfwowxtrZ+sDmwV69lcZ0Usdx0A94lpkdvy0lP9657aS6Ukd7Tr5
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45ba6fc-6e4f-4b93-73fe-08d7fe7d30ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 18:23:14.0186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aeP8iikCjRLMtG47EeD0Vnp+EAGYTk+5tw6xFNYsWC/a5cpvol+yLdXA3N0gIdIR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
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

Fixed it as Monk and Hawking suggestion. Now it only has one checking in function gfx_v10_0_enable_gui_idle_interrupt.

BTW, I update the commit, but it send out an another email.

Thanks,
Gavin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, May 22, 2020 2:17 AM
To: Liu, Monk <Monk.Liu@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

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
