Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D066C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 09:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5ED2206F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="roHsyqF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ED2206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AF46E332;
	Mon,  6 Jul 2020 09:19:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741356E3B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 09:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN0a8W3cSKhy7EaR2MgdgcAmr99xVzYkYHx0XHg7S3Ii+73bcOokS6xXYW7bp2BCcD9j4cGmaPI5grPkvQZvz+HwD1YZ87fSIb+PxxIu9qOEthYgrVXu3t9dHBl9W7s+gDr+N09cw6q9Xih/3dLgFJkiGSNxmjb/cTcqb+xyANqWeywDMjLkh+GxPtcdz1hhiE7umrDX3b6t2DwVmmdrX6J7xB+sxKZSHwGe80Fdc4K7YRKf29n3XGuHEDV0i0RUPkHJthLQFsuAdv4hAimNu9QBUm5vtZbY/J5lFul7PIRTAnhMw49Hdo61XZS/SL48hDBR7aXbY6Vt7ZbPs2lKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9eikcKTxBKS8nCMIyF0nKH3+tU4LN92EJlZd2h+Yic=;
 b=SKeN+c7liwwX9ggOdyexdI0NrqQGPToD75+z7GEAmNQswxw14wdYf/tTR+iNsBc7FR26PQ2/A0HuHLKDP0PxkFlLc9HK4so8kxWI2RUxB/gUeuIqZX8FcIx+hlE3PepQ/ToA2GA1O6EoJxp8Dzfcvtr0WscWEHsexzcQF9/E3hqypyx9qozXacXmP6RomPRWOU4skAtOuJ14bbCPQqKeVfrKAmSCNrQXQXwI9x4lGYwWUfjxaNHREMj/FEUHSBe4CLggEzpeS+6dLwo0gnbwJAHiBJ2t0ZnIedLtDKEEz5ShBi7x7WL6Tpxen3lTLN6u29zlr7rBpcchWlCTefri+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9eikcKTxBKS8nCMIyF0nKH3+tU4LN92EJlZd2h+Yic=;
 b=roHsyqF3mOox31v028wAjXkDOR/A550Emr6vWfjd7rqj9gZDStDnmE0WBV7Il3yd+OGFgogJW9T4Z6yfVIJUR4RVdR2cDrFhM9dUpXuiGZTrbEagtj6gQ7t2ae4cH+/4nNCtLP9zYHJULTTGO7mAVAiOUMalyHEw4fs1LSyunfY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24; Mon, 6 Jul 2020 09:19:10 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 09:19:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use RREG32_KIQ to read register when get cg
 state
Thread-Topic: [PATCH] drm/amdgpu: use RREG32_KIQ to read register when get cg
 state
Thread-Index: AQHWU3SR9r8tITQe5UWugBtf6EpwSKj6RXJQ
Date: Mon, 6 Jul 2020 09:19:09 +0000
Message-ID: <DM6PR12MB4075E73ED38C7B363CAA450DFC690@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200706090445.2933057-1-likun.gao@amd.com>
In-Reply-To: <20200706090445.2933057-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-06T09:19:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cbed3f56-e5c6-4639-98de-00004d575039;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-06T09:18:54Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 45cad944-3585-4249-9985-000061d80ff7
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-06T09:19:06Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 42bcccf9-9589-4343-ac92-0000f5ba76cb
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92576d28-29a1-43fe-dbae-08d8218da42c
x-ms-traffictypediagnostic: DM6PR12MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30817F1AD631325A7200F473FC690@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A4VjrP0UwrKQy2D2EZXWc63G+rMDBVUjpyyhShowmpArblGh3hSmnOwhRE6wzhvPrjNwjX0fmreF1K6bNKwo+f8HYOefzfhkr67JcOUvqG+PF2ma/LlC4XRL+P9A7U3ewUcoPQ3730iWT1qeAsHxl2aQgiBov0dcggxQUBCkSYxWEh2tHEOhnXSoAv+JJi3CAzwZyGQUaAgtEgRoACNlhNe//L5y2L+dD9KsbjvSM9vsHz6FV1vX3QWPL+JYqMdUIwn9/r8qMC8fMVdO1twVNnaHzp8Yfao0WmyuVQAyywfRs/nwdiSmCshZd5lLd0+e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(86362001)(53546011)(76116006)(8676002)(8936002)(26005)(2906002)(4326008)(186003)(9686003)(55016002)(316002)(110136005)(71200400001)(478600001)(5660300002)(83380400001)(6506007)(52536014)(7696005)(66476007)(66556008)(33656002)(66946007)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WiG6HyRig1lH6hOkBojDVuOFyd0b3y8Hwtwv8y5yx8dmsCQKyIljuZVeGggDS5dtUU3MYcpccoZ0SKv0XsS3pDczoD+oxeZ2dAFtKR7CR7bTjTjPGSwRRXPFl/bc7AVRMi3/dfMUqpltQ8Lr1Xo/3ongPerlkt7lSWI46F9wiiuSiibHcuaNmp+KkL6PgEDKpKebSrfSYpayXyUxlzV6PgExIly+rn6a/NUlfenjjDDcNPIHFLSZIyd2lpz/486r7lkYfwoKds7Di3BoK2M+xVnQV8cqEJnGEb99N3fdeRaz2/FJgCfBR7LL+XJh3PuJoymGYXE6lh9bUdBTOH2G60dkztZqQ9OOMjqeRevZZmfsimjMX3F3kE7ON8aBANck+yOED4V5BGzmvo1GJuGxdm2AIijj1+Tc+9POZkC83VxD4edv+xsbUbNhONe5+pKG9W06zKMF1E8eHBvcyfDW422i9WAoSQwkAU6ICWidzuHKSuylvfxrHXDugB9K1jbp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92576d28-29a1-43fe-dbae-08d8218da42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 09:19:09.9123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26Om8nQEICgG+HQZPN6NRhIOUrdO/PcLtl6b8WeaH2GS7ETZbo7ZunHFyt1XDU76SCW1eq5ZK7OhBWhR1B+cEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, July 6, 2020 17:05
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: use RREG32_KIQ to read register when get cg state

From: Likun Gao <Likun.Gao@amd.com>

Use RREG32_KIQ to read gfx register when try to get gfx/sdma clockgating state instead of RREG32, as it will result to system hard hang when GPU is enter into GFXOFF state.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I1fc5fe70831e0ec35f1e701a1646cb3e46e121bf
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 +++++-----  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8366c506a8b5..b8b4cff20013 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7481,12 +7481,12 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
 	int data;
 
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
 
@@ -7495,17 +7495,17 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
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
 
 	/* AMD_CG_SUPPORT_GFX_3D_CGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D));
 	if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 318d32e2bbf6..4dbc11907bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1572,7 +1572,7 @@ static void sdma_v5_2_get_clockgating_state(void *handle, u32 *flags)
 		*flags = 0;
 
 	/* AMD_CG_SUPPORT_SDMA_LS */
-	data = RREG32(sdma_v5_2_get_reg_offset(adev, 0, mmSDMA0_POWER_CNTL));
+	data = RREG32_KIQ(sdma_v5_2_get_reg_offset(adev, 0, 
+mmSDMA0_POWER_CNTL));
 	if (data & SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
