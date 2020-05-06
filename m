Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E014C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 08:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7C6206D5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 08:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J8C61O+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7C6206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942B86E22D;
	Wed,  6 May 2020 08:47:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500696E22D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 08:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1tlchTilcjTbMMzTSO4e3N5LgaAyCOe/OzRHCMVdXSCt/I0nIA0KPr4xKR7ACDKZrv4FfASD+ZSSb7+xgNo8dNSaPkt5bCzzlMrKxdP5KN/fWZW0DRye9mDk0I0o57RVeBrtA2HREV/5adv10jeDb+vWAg6Tb3z029tNc14rKUIDS7OHNtUft8NPHTpu6y85737r/rcTfImxnvwKsRmjUP2KseW2tF/RwG+J0lCBX2K+Gi1UJk80Iq7Er0TGftHOn5VYKRacdkyaI/d9+FtU28kYQgwp9KhFcedAt+yix27r+Fonl7bvujPNYH1+cEUs2tZzXRiW0zuHcepQTA6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YTOwBuoSQ4KFYJejx0xU2fIZEvfDxSh2K2SICxF6h8=;
 b=Gcq9ajzg2nY2i4OcUZEhSO9TjDKlDumF8o9PDmVkIeMVo3n5m+U7N/DIGP60V4VCyan2Y9orUXl4rmFIIpeFIVykRTjZf1e8hIRzSP9teESCWAEpPv4qgWgH/TMCNopzUjf5Rzd985GeGQ4l25kgkMF9tGdySZx7H9TACNjeNtWzfhtdIsdL10xfft1zDtl6t9PDM4I/UGAOtCayewPGqLolotZ3Tw0ZPwSU8zzpsh1JSFGPvhloA8oNymjNyHqukTHopeoGsgF6JFNxjLSNGqfUgreLsGAYo+KiOlRhi/3oQz7vp1gO0lsNUVW5KcTwwIxENeFpGEgxXVIEpRL5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YTOwBuoSQ4KFYJejx0xU2fIZEvfDxSh2K2SICxF6h8=;
 b=J8C61O+1e6V+4LHyszV/Y/qmxH5AWGRTspiT+xaMshuhlhGHlh0yTaFtxvq6uVwHsVVH7n556oX8miHnGa3xbXRB6FaX1EUeUfl3EVn+4Xr7Tkc/uiIIE9A1x4r8zzjHtC9eaCclW0AYg4M09EohsEA3cdHeTSSsJljm9G52RwQ=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Wed, 6 May
 2020 08:47:39 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8%7]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 08:47:39 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use node_id and node_size to calcualte
 dram_base_address
Thread-Topic: [PATCH] drm/amdgpu: use node_id and node_size to calcualte
 dram_base_address
Thread-Index: AQHWI3F5BrXpx68U5UmLsu+qE5xT0Kiavv7w
Date: Wed, 6 May 2020 08:47:39 +0000
Message-ID: <MN2PR12MB4032496F1F65725C5EBFC55BFBA40@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <20200506064201.22945-1-Hawking.Zhang@amd.com>
In-Reply-To: <20200506064201.22945-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-06T08:47:32Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=29866424-f7b1-4aeb-bfca-0000403b1b40;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-06T08:47:32Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 778b0db9-5f5d-40cc-a9a0-0000987478ad
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 637fdd84-9cb6-4980-3b24-08d7f19a220b
x-ms-traffictypediagnostic: MN2PR12MB3951:|MN2PR12MB3951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39516FC9317FE28E9D4A9961FBA40@MN2PR12MB3951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCd4mGnkGEt578apMBaFXhDZU5Mnj/w/WQir3L6y+zlRjgP7LEAL8Eic3e4Zl5D1Ki3O3gfRRCAXNhYU3WbhIqrw732RqDYGXX8mX2LFz7UWjbMTpG2Y2GPtBkxD+kBE5zY0T0uRuUf1EGECt3/xg8feu2K/41BC0+I557EAPgT/mzrZ0riQImSQ64dGQe8/G2Ab/+p0qTqWYdbV1tqwz0cHFPkrweLzhd9ARLMQRPsYm4B+DX0exxpPg/OTpIXTDqd4QLKyAg5Nr/20QiE98tQZByjWe0WPPuEjoAkSqClJoEH8qjvw15qmhT4jJkh0suKREripcztz5HsfQEb4On2hQGQNMdxYDpBAXFKbCJ9veYEXRNvv/I4OT5AnmYUTctZeqZOTN3pfSssDSg2UZSdnRZoGwMKI+W01jTJBFN3QNkbZi59E0ng97TYTMNUhQ5xAoj2OnPFnLzHD6moanZvme31qlkBptmUGhgu6OrgvE629IfuxljE37v+G9J6xGqj68vTf6CCYmJjd/rnmew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(33430700001)(86362001)(8936002)(8676002)(6506007)(53546011)(186003)(26005)(33440700001)(33656002)(7696005)(316002)(5660300002)(52536014)(6636002)(110136005)(66476007)(2906002)(76116006)(4326008)(66556008)(478600001)(71200400001)(66946007)(9686003)(55016002)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oBgIunouDbASw99usOr9EEZm15XiFTDxKlbbc2rMT/JP50W5npsxmEU8H/GaWMhF2jk6ghpwKUXauU/PtPDxXLyPWWZUaNgRT44bAz/A6FvNXMZyZrGrBqcUjYN6RlQhNGb/oKYz2fBIwjli5YiVoSuOoGBIJkbzpak+pXCg2eCj8CSNgBE/8I+Vw+cN+9MslgnegkFFEHdrEaJOz5E1G+xA6pK8JqHFsnc7A3mk9EYD+yzfTd/m0IZh2ysDPygcEB/mPAiqSoiN+VnN1UkM62BwBNxCSsoI+IcJoa7gu7aA97sapfFkHsJbBPpn7xBFMWED6QZisKQmxHfPjADOH0EXWSBkYOSDJpa4Qsbf4VSxuL8GEK2TgtLighZAEYojH0pS8VrKFvhkZnGVzLuQt5RNdE0MSigJeORqrMhIYCUIiB1F9n/UBtvEKaE3iGsKuZeN9D9TSYtnNN28ILpYGdHn5ChstFpBa1d/feQqzUQOjTmTzwBSH7dt9fxan6F9q7LhRPV07ph/fBi8SYFtmpLBN9ryHrICUB2SUXqy2YKozbj/X1DVGWpNs3qjDHKGbpd/mjSeJ0uA2pxUyRIHr7Fn1wbHJnjviAhZyKdo+A/wPCKl1fG6J14EwPAeyfN70HaFdP37BbiYX5OC9kS89BaEZEB6LW3eg7AZcld+3Dy6pMGcrXmibdBIJowzKRpaDW8HS2yHln0LO0Z2MHJQA4o6vZwfcub6iNzn1K980bVsJwUOu0nuv9r31xsmJcV4XGGbykD49MhXs45H5oNTsrJIV3v8egTXpkUM/8ILZD4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637fdd84-9cb6-4980-3b24-08d7f19a220b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 08:47:39.2374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxMNFKXHzi7QVVkK9ml1XdsRskW8gMCpo3s/s/yE6NSZkU0+mYFhnLFR1jGMJmWyxViUNgfuPVkv42pa8JfsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Wednesday, May 6, 2020 2:42 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: use node_id and node_size to calcualte dram_base_address

physical_node_id * node_segment_size should be the dram_base_address for current gpu node in xgmi config

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h   |  3 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 ++--------------
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c     | 54 --------------------------------
 3 files changed, 2 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 057f6ea..61a26c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -52,9 +52,6 @@ struct amdgpu_df_funcs {
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
 	void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
 			 uint32_t ficadl_val, uint32_t ficadh_val);
-	uint64_t (*get_dram_base_addr)(struct amdgpu_device *adev,
-				       uint32_t df_inst);
-	uint32_t (*get_df_inst_id)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_df {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 48c0ce1..90610b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -649,31 +649,8 @@ void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr)
 {
-	uint32_t df_inst_id;
-	uint64_t dram_base_addr = 0;
-	const struct amdgpu_df_funcs *df_funcs = adev->df.funcs;
-
-	if ((!df_funcs)                 ||
-	    (!df_funcs->get_df_inst_id) ||
-	    (!df_funcs->get_dram_base_addr)) {
-		dev_warn(adev->dev,
-			 "XGMI: relative phy_addr algorithm is not supported\n");
-		return addr;
-	}
-
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW)) {
-		dev_warn(adev->dev,
-			 "failed to disable DF-Cstate, DF register may not be accessible\n");
-		return addr;
-	}
-
-	df_inst_id = df_funcs->get_df_inst_id(adev);
-	dram_base_addr = df_funcs->get_dram_base_addr(adev, df_inst_id);
-
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
-		dev_warn(adev->dev, "failed to enable DF-Cstate\n");
-
-	return addr + dram_base_addr;
+	struct amdgpu_xgmi *xgmi = &adev->gmc.xgmi;
+	return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
 }
 
 static void pcs_clear_status(struct amdgpu_device *adev, uint32_t pcs_status_reg) diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 5a1bd8e..a7b8292 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -686,58 +686,6 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 	}
 }
 
-static uint64_t df_v3_6_get_dram_base_addr(struct amdgpu_device *adev,
-					   uint32_t df_inst)
-{
-	uint32_t base_addr_reg_val 	= 0;
-	uint64_t base_addr	 	= 0;
-
-	base_addr_reg_val = RREG32_PCIE(smnDF_CS_UMC_AON0_DramBaseAddress0 +
-					df_inst * DF_3_6_SMN_REG_INST_DIST);
-
-	if (REG_GET_FIELD(base_addr_reg_val,
-			  DF_CS_UMC_AON0_DramBaseAddress0,
-			  AddrRngVal) == 0) {
-		DRM_WARN("address range not valid");
-		return 0;
-	}
-
-	base_addr = REG_GET_FIELD(base_addr_reg_val,
-				  DF_CS_UMC_AON0_DramBaseAddress0,
-				  DramBaseAddr);
-
-	return base_addr << 28;
-}
-
-static uint32_t df_v3_6_get_df_inst_id(struct amdgpu_device *adev) -{
-	uint32_t xgmi_node_id	= 0;
-	uint32_t df_inst_id 	= 0;
-
-	/* Walk through DF dst nodes to find current XGMI node */
-	for (df_inst_id = 0; df_inst_id < DF_3_6_INST_CNT; df_inst_id++) {
-
-		xgmi_node_id = RREG32_PCIE(smnDF_CS_UMC_AON0_DramLimitAddress0 +
-					   df_inst_id * DF_3_6_SMN_REG_INST_DIST);
-		xgmi_node_id = REG_GET_FIELD(xgmi_node_id,
-					     DF_CS_UMC_AON0_DramLimitAddress0,
-					     DstFabricID);
-
-		/* TODO: establish reason dest fabric id is offset by 7 */
-		xgmi_node_id = xgmi_node_id >> 7;
-
-		if (adev->gmc.xgmi.physical_node_id == xgmi_node_id)
-			break;
-	}
-
-	if (df_inst_id == DF_3_6_INST_CNT) {
-		DRM_WARN("cant match df dst id with gpu node");
-		return 0;
-	}
-
-	return df_inst_id;
-}
-
 const struct amdgpu_df_funcs df_v3_6_funcs = {
 	.sw_init = df_v3_6_sw_init,
 	.sw_fini = df_v3_6_sw_fini,
@@ -752,6 +700,4 @@ const struct amdgpu_df_funcs df_v3_6_funcs = {
 	.pmc_get_count = df_v3_6_pmc_get_count,
 	.get_fica = df_v3_6_get_fica,
 	.set_fica = df_v3_6_set_fica,
-	.get_dram_base_addr = df_v3_6_get_dram_base_addr,
-	.get_df_inst_id = df_v3_6_get_df_inst_id
 };
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
