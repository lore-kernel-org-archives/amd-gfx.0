Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430F6C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 11:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0505520578
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 11:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RktFhPfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0505520578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1D96E25E;
	Mon, 30 Mar 2020 11:57:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778886E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 11:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgKBiJU5lrSfaezM8Waf+P1+bUrRyHc60ZnXM58GYEhRDwpQ8A8slLFXFNmQl+iIEj2oMsQL9Soqf0w//ZBJGepV54BLwvsql7hnr1/jR7bMgoCZtwGKL/kWImsQzuimR11aM2viPW58Do/+RuYa6em4ZIlDSjG0fhMychHu/WwqsjpuE4FVj0OgqBTAz50nG5Euf3GlV3i9AczLWIzbclDTysfNXXo6gXJqpN9vqV2gUy5W1gXlnEVUHFymeC1+Bdgf49fUFX7oVJQ4KlvaopIhtlwOJM/lr5ttMvNzs6FK+wFRRH9+49MmG+rjWVrLgKf2rOrYbMPcDyJ2CDkKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UuxoWPQrwSjZMtXcLCIzKldgao5wTPxxRzrW4QdNvI=;
 b=NtW9c8LujPa+oDcuuTe4VcYtzYhMeKq0J+R6+UQd5hc+/XRmo6+AmxiVplQtEFyHm4jg5MzFa+3rnUGvv0E1HTnWqvUFO+3N1RtDpoiM4dv20P+rep6eq3RW4R1xflOfwlU+apY3fcaNXU06bqritYl40ucqydLNFz8D+JTnohTQ40Y24Yj8WNFxNAOjzAtzvgYaf5SPxKfzXFAKiFarVTH+M6ziQAwKsWmN9WNcWed8qIJnhQT0FwJXZtnf8lQ6Cd19NXYjxZ0SDLO/qSP3ooC7TqD1qZqA0SKgf/5QE+WTTz7q7YvQi7eBukoTSKSiH8xLEomtCglgvWW9dsLwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UuxoWPQrwSjZMtXcLCIzKldgao5wTPxxRzrW4QdNvI=;
 b=RktFhPfhLd6w1NriOcssq+mTRrFiwFL2Tr1I1PFTYTAJimtR9M2PkFuKOXx4uCLg1xZCjWSWBmOpMsgwT0bmcy0KcwhRJjA0KAY48C7VYRDCRJAydTNvokTUvFc8agAZfpf0QycGwy+/Xv2D03BZg3rZHH1KftEDc9ffJMvSHzI=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 11:57:14 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 11:57:14 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip access sdma_v5_0 registers under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: skip access sdma_v5_0 registers under SRIOV
Thread-Index: AQHWBnBlUqdpa8KU2kiIVBL0zWuRn6hhBynw
Date: Mon, 30 Mar 2020 11:57:14 +0000
Message-ID: <MN2PR12MB297582ACE534E5DB01AD994B8FCB0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <20200330084943.28382-1-yttao@amd.com>
In-Reply-To: <20200330084943.28382-1-yttao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-30T11:57:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4dc1560c-bad1-44a8-9c55-0000a6298b07;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-30T11:57:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7afc7094-ff91-41df-87a8-00009a3d3680
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c972c1b3-cc54-446e-7499-08d7d4a17ce2
x-ms-traffictypediagnostic: MN2PR12MB4143:|MN2PR12MB4143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4143A177877A13D38481801F8FCB0@MN2PR12MB4143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2975.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(7696005)(5660300002)(33656002)(4326008)(8676002)(26005)(186003)(86362001)(64756008)(66446008)(76116006)(66476007)(66946007)(66556008)(52536014)(6506007)(71200400001)(54906003)(110136005)(316002)(2906002)(6636002)(9686003)(478600001)(81166006)(8936002)(55016002)(45080400002)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQIC+Qsb7FiusoOsjvY6BMmWKN5q8AaKuAJY0IVhAtz+EG7y34+qVQkJ3r1EzCccSCYtSYURc96z/Reh/Aw3p4SAFfiyG0tK6cNSe/9LTlnrMyYqidCAITx4gw7EhBWGpekyd0CEF+BPVWi53zVOBY+8XM/ZheQ3PrmfEGJ0wcA6TJzVFi4yH9jzIQ1eQ78D3GSLI/AFDqS0PmxRcVSqPMmWWb2Xc6DXqDKYeSyEnrNvGRbNNKn1V0iC0M5mcZeiqy5QeatCy9uL09tnyyTTHepyidS3UW7QZC0CTecHr+VYpGoarA00zoKGj2DmSVOr2wtGQ59Q6b9vZEzOmF7Ge+fFNicf8uOeyKGlbr3/e4jIR0oforbYSzR0kWaFiCeFZ27b7rqHzAc566V+ACOoA5H+tiSibPkIggQLXR9nmJgmAEr3mgUaBmAdRbcyajNkOWSIlJ2XuQfsIiYCfxmCwgq0ZZjd6kDxvACyTeJTOFM=
x-ms-exchange-antispam-messagedata: rog3xWMaS/rSLWGtauL7cR2SB3pkgD55a57PL3KLl2Ip2FSYqb1LC8064jWDl/GnEXgss+8SF9Be/HvYblM+q0MtquPs/79tt22Araz87s0fdTggICpWA4Y6TZXb8CYvJ6V3kBXf10UoeRUNycgmIA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c972c1b3-cc54-446e-7499-08d7d4a17ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 11:57:14.4474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z63KeBQUvu46Kw50NwyI1Yw86gvC1nFjYAupuB40sMcHow1Dj6hWY25WIsWkJPWK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

Best wishes
Emily Deng
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yintian
>Tao
>Sent: Monday, March 30, 2020 4:50 PM
>To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>
>Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
>Subject: [PATCH] drm/amdgpu: skip access sdma_v5_0 registers under SRIOV
>
>Due to the new L1.0b0c011b policy, many SDMA registers are blocked which
>raise the violation warning. There are total 6 pair register needed to be skipped
>when driver init and de-init.
>mmSDMA0/1_CNTL
>mmSDMA0/1_F32_CNTL
>mmSDMA0/1_UTCL1_PAGE
>mmSDMA0/1_UTCL1_CNTL
>mmSDMA0/1_CHICKEN_BITS,
>mmSDMA0/1_SEM_WAIT_FAIL_TIMER_CNTL
>
>Signed-off-by: Yintian Tao <yttao@amd.com>
>Change-Id: I9d5087582ceb5f629d37bf856533d00c179e6de3
>---
> drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 110 +++++++++++++++++--------
> 1 file changed, 75 insertions(+), 35 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>index b3c30616d6b4..d7c0269059b0 100644
>--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>@@ -88,6 +88,29 @@ static const struct soc15_reg_golden
>golden_settings_sdma_5[] = {
> 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_UTCL1_PAGE,
>0x00ffffff, 0x000c5c00)  };
>
>+static const struct soc15_reg_golden golden_settings_sdma_5_sriov[] = {
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_GFX_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_PAGE_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC2_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC4_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC5_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC6_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_GFX_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_PAGE_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC2_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC4_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC5_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC6_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>+	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC7_RB_WPTR_POLL_CNTL,
>+0xfffffff7, 0x00403000), };
>+
> static const struct soc15_reg_golden golden_settings_sdma_nv10[] = {
> 	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA0_RLC3_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
> 	SOC15_REG_GOLDEN_VALUE(GC, 0,
>mmSDMA1_RLC3_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000), @@ -141,9
>+164,14 @@ static void sdma_v5_0_init_golden_registers(struct
>amdgpu_device *adev)
> 						(const
>u32)ARRAY_SIZE(golden_settings_sdma_nv14));
> 		break;
> 	case CHIP_NAVI12:
>-		soc15_program_register_sequence(adev,
>-						golden_settings_sdma_5,
>-						(const
>u32)ARRAY_SIZE(golden_settings_sdma_5));
>+		if (amdgpu_sriov_vf(adev))
>+			soc15_program_register_sequence(adev,
>+
>	golden_settings_sdma_5_sriov,
>+							(const
>u32)ARRAY_SIZE(golden_settings_sdma_5_sriov));
>+		else
>+			soc15_program_register_sequence(adev,
>+
>	golden_settings_sdma_5,
>+							(const
>u32)ARRAY_SIZE(golden_settings_sdma_5));
> 		soc15_program_register_sequence(adev,
> 						golden_settings_sdma_nv12,
> 						(const
>u32)ARRAY_SIZE(golden_settings_sdma_nv12));
>@@ -557,9 +585,12 @@ static void sdma_v5_0_ctx_switch_enable(struct
>amdgpu_device *adev, bool enable)
> 	}
>
> 	for (i = 0; i < adev->sdma.num_instances; i++) {
>-		f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_CNTL));
>-		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
>-				AUTO_CTXSW_ENABLE, enable ? 1 : 0);
>+		if (!amdgpu_sriov_vf(adev)) {
>+			f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_CNTL));
>+			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
>+						 AUTO_CTXSW_ENABLE,
>enable ? 1 : 0);
>+		}
>+
> 		if (enable && amdgpu_sdma_phase_quantum) {
> 			WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_PHASE0_QUANTUM),
> 			       phase_quantum);
>@@ -568,7 +599,8 @@ static void sdma_v5_0_ctx_switch_enable(struct
>amdgpu_device *adev, bool enable)
> 			WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_PHASE2_QUANTUM),
> 			       phase_quantum);
> 		}
>-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL),
>f32_cntl);
>+		if (!amdgpu_sriov_vf(adev))
>+			WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_CNTL), f32_cntl);
> 	}
>
> }
>@@ -591,6 +623,9 @@ static void sdma_v5_0_enable(struct amdgpu_device
>*adev, bool enable)
> 		sdma_v5_0_rlc_stop(adev);
> 	}
>
>+	if (amdgpu_sriov_vf(adev))
>+		return;
>+
> 	for (i = 0; i < adev->sdma.num_instances; i++) {
> 		f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_F32_CNTL));
> 		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT,
>enable ? 0 : 1); @@ -623,7 +658,8 @@ static int sdma_v5_0_gfx_resume(struct
>amdgpu_device *adev)
> 		ring = &adev->sdma.instance[i].ring;
> 		wb_offset = (ring->rptr_offs * 4);
>
>-		WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
>+		if (!amdgpu_sriov_vf(adev))
>+			WREG32(sdma_v5_0_get_reg_offset(adev, i,
>+mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
>
> 		/* Set ring buffer size in dwords */
> 		rb_bufsz = order_base_2(ring->ring_size / 4); @@ -699,26
>+735,28 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
> 		/* set minor_ptr_update to 0 after wptr programed */
> 		WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
>
>-		/* set utc l1 enable flag always to 1 */
>-		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_CNTL));
>-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE,
>1);
>-
>-		/* enable MCBP */
>-		temp = REG_SET_FIELD(temp, SDMA0_CNTL,
>MIDCMD_PREEMPT_ENABLE, 1);
>-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL),
>temp);
>-
>-		/* Set up RESP_MODE to non-copy addresses */
>-		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_UTCL1_CNTL));
>-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL,
>RESP_MODE, 3);
>-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL,
>REDO_DELAY, 9);
>-		WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_UTCL1_CNTL), temp);
>-
>-		/* program default cache read and write policy */
>-		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_UTCL1_PAGE));
>-		/* clean read policy and write policy bits */
>-		temp &= 0xFF0FFF;
>-		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
>(CACHE_WRITE_POLICY_L2__DEFAULT << 14));
>-		WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_UTCL1_PAGE), temp);
>+		if (!amdgpu_sriov_vf(adev)) {
>+			/* set utc l1 enable flag always to 1 */
>+			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_CNTL));
>+			temp = REG_SET_FIELD(temp, SDMA0_CNTL,
>UTC_L1_ENABLE, 1);
>+
>+			/* enable MCBP */
>+			temp = REG_SET_FIELD(temp, SDMA0_CNTL,
>MIDCMD_PREEMPT_ENABLE, 1);
>+			WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_CNTL), temp);
>+
>+			/* Set up RESP_MODE to non-copy addresses */
>+			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_UTCL1_CNTL));
>+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL,
>RESP_MODE, 3);
>+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL,
>REDO_DELAY, 9);
>+			WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_UTCL1_CNTL), temp);
>+
>+			/* program default cache read and write policy */
>+			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_UTCL1_PAGE));
>+			/* clean read policy and write policy bits */
>+			temp &= 0xFF0FFF;
>+			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
>(CACHE_WRITE_POLICY_L2__DEFAULT << 14));
>+			WREG32(sdma_v5_0_get_reg_offset(adev, i,
>mmSDMA0_UTCL1_PAGE), temp);
>+		}
>
> 		if (!amdgpu_sriov_vf(adev)) {
> 			/* unhalt engine */
>@@ -1388,14 +1426,16 @@ static int sdma_v5_0_set_trap_irq_state(struct
>amdgpu_device *adev,  {
> 	u32 sdma_cntl;
>
>-	u32 reg_offset = (type == AMDGPU_SDMA_IRQ_INSTANCE0) ?
>-		sdma_v5_0_get_reg_offset(adev, 0, mmSDMA0_CNTL) :
>-		sdma_v5_0_get_reg_offset(adev, 1, mmSDMA0_CNTL);
>+	if (!amdgpu_sriov_vf(adev)) {
>+		u32 reg_offset = (type == AMDGPU_SDMA_IRQ_INSTANCE0) ?
>+			sdma_v5_0_get_reg_offset(adev, 0, mmSDMA0_CNTL) :
>+			sdma_v5_0_get_reg_offset(adev, 1, mmSDMA0_CNTL);
>
>-	sdma_cntl = RREG32(reg_offset);
>-	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
>-		       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
>-	WREG32(reg_offset, sdma_cntl);
>+		sdma_cntl = RREG32(reg_offset);
>+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL,
>TRAP_ENABLE,
>+					  state ==
>AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
>+		WREG32(reg_offset, sdma_cntl);
>+	}
>
> 	return 0;
> }
>--
>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
>desktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7Cd8f4122b4fb7463d56
>af08d7d487526a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>7211550868892241&amp;sdata=I%2BNRIK8zc0Ih%2FW3cijivPB10ZdzQDadgvDd
>Pa7zA77Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
