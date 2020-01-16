Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC5C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 02:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916D7222C3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 02:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C49e+H5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916D7222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5430A6EBBB;
	Thu, 16 Jan 2020 02:31:08 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4066EBBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 02:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwKlW47Oebm8xPrDS1M0ESAfL5oM7k1MZ9i2/zJ1EwD/1OStZFUQFNwlwbOzi51qPjqqp2xBAhY9DiXBnUOgWEhfjQ5ZMhcPNHgAIbxSzRuna8iTEwMDZaZz/hVcFjzhTUe7+1BXEIRPn35hhhanEIUYkV/Nx4KopByfP81TIupfeLxxYZkxCloQWea+JPJ0Y80kiq87/nTHXRZKCTMyimUXfwEvRD4dgyscA0vroMQB2ptqr69XYHoEr5yzJV9lzIDDWW4vc5DqB5EUMHjnJpwXcJRNzlT6iFYuMIDtMSSHEeE1A48HibzU8eRZJGK4FT7TfgtBA/oHVh/skHM2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW/pQM05ascLZB+8An3z56lUeuvrqiMgmpE4r6QnaNY=;
 b=ZkqSxd7w0oLyVZ12AHf4yiDofijsT3+Jw+3sM4TGq1o/padJNus4HpXrezGzUoug70SQWZu7YQj39D8PS+TMWH0AF9b8TIsSI6ohCu5LlifyUs3gcBnL6+nb5pWg61nn1dlRQELzcLhyXZf28I8uVO3xD64atWYcRIms6OZTu4qAGcNTa6Z+tdpTdSls7WORwZLIt7GIOVq1uAbvxMOvzKeMHnlBDtv5A5cZ0xmNYGRVdnhSZFCcRoakXKYv3jlVAIBuo8BysWISGmjh7G5UNZ/2WlsCmAhFFC2nYrUPY5B+IoyocbUFkuSkyCUlvII1T9yxPVt18ANgZCiDMc+k8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW/pQM05ascLZB+8An3z56lUeuvrqiMgmpE4r6QnaNY=;
 b=C49e+H5u5/H7MnTVK+5XHNTbCQYtMIK1XezOtS7Q/si2chQNwEZfgMHcco2n6gAN8mBeNgh6eBpqB6+YuW2VWchT8mzEMauuvJFRXX+JG0dTI1FU1kZn2W6jny/KGG9dLBsyF9y/kFlvf+upWSK2IdZGEy8W5Gfl0Gf08Zj8gts=
Received: from MN2PR12MB3069.namprd12.prod.outlook.com (20.178.241.23) by
 MN2PR12MB3821.namprd12.prod.outlook.com (10.255.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 16 Jan 2020 02:31:05 +0000
Received: from MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::9cf1:449e:8958:db19]) by MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::9cf1:449e:8958:db19%7]) with mapi id 15.20.2623.015; Thu, 16 Jan 2020
 02:31:05 +0000
From: "Gong, Curry" <Curry.Gong@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: read gfx register using RREG32_KIQ macro
Thread-Topic: [PATCH 3/3] drm/amdgpu: read gfx register using RREG32_KIQ macro
Thread-Index: AQHVy4f8/2J4gri71UmLjvsYZdld36fskusw
Date: Thu, 16 Jan 2020 02:31:05 +0000
Message-ID: <MN2PR12MB3069F1ADEB5910DA7ED361449D360@MN2PR12MB3069.namprd12.prod.outlook.com>
References: <1579081282-659-1-git-send-email-curry.gong@amd.com>
 <1579081282-659-3-git-send-email-curry.gong@amd.com>
In-Reply-To: <1579081282-659-3-git-send-email-curry.gong@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-16T02:31:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=52d8dd81-e516-486b-80f5-0000395d21d7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-16T02:31:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0557b291-0106-47e9-8df3-0000fa0b6041
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Curry.Gong@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51043b4c-6c72-40ea-dabc-08d79a2c2332
x-ms-traffictypediagnostic: MN2PR12MB3821:|MN2PR12MB3821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB382193F4ACDA836686E1B4CC9D360@MN2PR12MB3821.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(189003)(199004)(5660300002)(478600001)(66946007)(66476007)(55016002)(66556008)(316002)(26005)(52536014)(66446008)(71200400001)(76116006)(33656002)(2906002)(9686003)(64756008)(81156014)(186003)(8676002)(110136005)(8936002)(6506007)(53546011)(81166006)(86362001)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3821;
 H:MN2PR12MB3069.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbFcYvo6PiZoUW3MglUbYJWXza5kPdNDa8TUx1Dt8F5URIQO9mnexzG2r+Ol0MO4neljc7EGgOX1nke2dysnOexQ/EqglzyztkAOz77wuryZT73u/sgGk3+NIqefmZINl3ObGVTdvDqEdjfFeH4O21sMXsJ5HMjNHVvZubuJmr6okXJhQfohU5jQgS875MTlorGsn8drfowBD1JBZrTKwQiFuKLlGgEYbc4dbxIfa4c1QmUyZU5IaJ5/+IhF2LcVNZTx9iTwaTmMK/aAV7A17mPBYumFsXOTo6Ejou62nYQtq01j1TBY2XteguyLrS9z0fmhyl95zsVzrJP/0qTDAVpjohazoTKDotqsSZLK9HiPxJXinik9BZfHA4lZC+sRbMPhYLIOlVCYoyF3mlOO7+A9hViTxqydP+hL/Ls7ZxLQqEi3cHlwsukHovTiwKrz
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51043b4c-6c72-40ea-dabc-08d79a2c2332
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 02:31:05.4859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4oxJTsePDEmJmDTOuGJ+Z9OVwLJPdH4FDuiIhwi8tDWsYBAcqyWoBNXMQJC3RYD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
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

Ping

-----Original Message-----
From: chen gong <curry.gong@amd.com> 
Sent: Wednesday, January 15, 2020 5:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gong, Curry <Curry.Gong@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: read gfx register using RREG32_KIQ macro

Reading CP_MEM_SLP_CNTL register with RREG32_SOC15 macro will lead to hang when GPU is in "gfxoff" state.
I do a uniform substitution here.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 425762a..cdafacc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4714,12 +4714,12 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags = 0;
 
 	/* AMD_CG_SUPPORT_GFX_MGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
 		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
 
 	/* AMD_CG_SUPPORT_GFX_CGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL));
 	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CGCG;
 
@@ -4728,18 +4728,18 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags |= AMD_CG_SUPPORT_GFX_CGLS;
 
 	/* AMD_CG_SUPPORT_GFX_RLC_LS */
-	data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_MEM_SLP_CNTL));
 	if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	/* AMD_CG_SUPPORT_GFX_CP_LS */
-	data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));
 	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		/* AMD_CG_SUPPORT_GFX_3D_CGCG */
-		data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+		data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D));
 		if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
 			*flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
 
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
