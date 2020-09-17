Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED52FC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 05:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88030206C3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 05:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="er1jCZgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88030206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1954D6E0C5;
	Thu, 17 Sep 2020 05:26:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E036E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 05:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0OaRgtS0bll2dXdXo8ldcEOfjBaYClUQwcgFw8vtEmUn2ohLRfh5C294Y9YNOQYq7TGMNwTutj6j5moRpdBBMuKjyI1ip9wanIKqmFjOD2M4Z40J9CqradEMC0R/UhL3YRFwUrDGbZ5FqfK+6PkAss6IKfj1hF/EmDwhtq+y0T0wwX1AHSAYLmWzdJ+XBLEER0IOEv5D+vNay9KmDSy/ja1/9xq7u8UZspOSOBfzaABdw8oInCkVQlzRud7Y3FM0mmsp74bQmN+GtEXKhmtE+nv4SWCTsTgAlay8qKsrVMJVMYWFXdoTREu+BrtkrosK0p63KegIUti0DKbLs2SLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkcZOY3gz3kE7UoKwiWpQQ68aZYCBiHZofr8q0OLGxQ=;
 b=nhNDdNLEbimBoLKoXoHAh9hSCF/B5r6ut/JYydBmWs6m3ZRsCnJZRDahBKEy0MZW21v/85YH8GWUtyR6tcwYualuMhrusqLdDe4qgLU0C5Wpk4KbwHrH7MqlVIHI+D3oL2+tsK/2RB7/g1mIVb5pioP2lGCOgChQnzBIdG0JcHJDt/Q0DQ+AhXPzRGsgg7C17fwRnWr0iukptxz1Fpedk9Cj2wi6HyXLJHeBeRi92LZtPeMb/oQSmsL9slwO6H1Ash2YUHX5Hfxn26H7U2GCoTtgXp5I4nHw44+WCxUxYpGMJvnZ1r4S5ykkE1jHc2LnwsdpGyCmFsq7VM3FfolpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkcZOY3gz3kE7UoKwiWpQQ68aZYCBiHZofr8q0OLGxQ=;
 b=er1jCZgscwYZILDRtU/4JjXXgqYe2G/3xpdH+wBxvyUoWgfgB2ho1p27a4DJDEwP6gZTkkh3h/cizB/ufdUVbIarOKhiDtEQR7AB7M79HOX3I2MdDx1btTQGHOBx5VZmEsv6lIGRMMU9iRPh4punG4B5i3tsXHP91dJpoMw+ygQ=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1707.namprd12.prod.outlook.com (2603:10b6:3:108::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Thu, 17 Sep 2020 05:26:37 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 05:26:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdgpu: use the AV1 defines for VCN 3.0
Thread-Topic: [PATCH 3/4] drm/amdgpu: use the AV1 defines for VCN 3.0
Thread-Index: AQHWi41yszbZruHkpkukmS/IH1XCUalsTwLg
Date: Thu, 17 Sep 2020 05:26:37 +0000
Message-ID: <DM6PR12MB407516D788FB33BCFEE064A1FC3E0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200915182409.68727-1-alexander.deucher@amd.com>
 <20200915182409.68727-3-alexander.deucher@amd.com>
In-Reply-To: <20200915182409.68727-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-17T05:26:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4399914a-7f73-4a4a-8a86-000022ca9cf5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-17T05:26:30Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 82bd077b-b400-4732-8967-0000df582b93
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-17T05:26:35Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 35d0cba0-9a02-4eb6-99f4-0000d4f41113
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4924d27f-559d-4efd-e73c-08d85aca3fd3
x-ms-traffictypediagnostic: DM5PR12MB1707:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17071AEADA5859E0F457AE1FFC3E0@DM5PR12MB1707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0hZTOtBrDtm38O7vsc9UZ5+Ne+Tz34kbHHZh9WPh7ComRq9W586XkjYesCkT63iHspQ4nHKz74rAJ9n8RetFAy8DhKAprkmYCFVbGR0pAwU9RhkF2LK9tgNun3mn4ZqA/8BnAGWxOCeiQx5T0TYz4FVcehR3hhduMK9+uAIV1f7s29TEihvoxEsIEH8U0Vys9yVqh+Re1Bf9riAxtTTR3WWn+01brcGabFQrvHGR5ERVhtlIdPCJZjSsOGqe9Z0FJVvCCCbTiSUFLyyOMIrkMSUrSNhZIoYM2abshZMf9xBEAHAOTa0jBneW1D1/fRgedCm4NPhYDVA7JLLdLGpXhpYNMfw0voLxB5y8JIPQYqsFveWyYHQUZgRG2BPAqCKEr7iWhfgIw09DFL88a6z+olpswkExCAnqIVn1H2XBfA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(966005)(55016002)(4326008)(52536014)(110136005)(33656002)(9686003)(7696005)(53546011)(2906002)(6506007)(5660300002)(64756008)(66946007)(66446008)(66556008)(66476007)(76116006)(71200400001)(45080400002)(86362001)(186003)(26005)(8676002)(8936002)(83380400001)(478600001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: F9ZgJ7Wthct/ybpXu3G7ktD5HCUpjbIC4bpCX8Amp8qJX3O9Besh4DzKRKopgdbp7wwzv3cXeGhME1pctHJcKq6CKjWoPldpnr5ePEmxkoA5PaxrV30fzmZNZ8i+8xc+B9VWHRVKmfqwUCex6i69l0eDG31j33oDWn5tefNxSuRhM6ez0+RdCjzdqs2br1Hy1ndBL33Uwy+FeHFmJ1tqiieSwgWEZtGAK5dWpbcFDbZRQjsd7TQYrQuEoFAXgKOh3fES/AUvDza9XMIlw5Gwn7XHvZvKfxgqPMb5znk6J4qwMxH5XLF4IdYorw3DB4y2nHnr+cy1qywzwBEMgpQxlSuLgmIGdoUy2vJ0pSVLk+XnAxsvwKRnLNa12x8NnBG6hNaeJFIaSaU4T8yxb5FHm7iBIxrw/QtKiNyPf8Rss9pPaDAzIHZeQED2Rl1WtccxSyI02Z5xP71YApWCbp0F864PozL7s8+Q2i12LyVuL4qD56Nj8DLc2qh2alGvYd2Pv0Sje2O37q+feQNuaXpGP0xefr3M3zm+Zbh1HkoTdAsmJzBazPOz+N+Nfbb8T+tLKZNJjXheZplSf+5wEJ4PgvtteBbvLgOnfGJqipHv2fIPSTg/txIWzxlzR646CByZO4j8f/F3cXEpYL53soLqjg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4924d27f-559d-4efd-e73c-08d85aca3fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 05:26:37.3033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/TsXw09w+SWlVXMDVcQzxNYm8sk8A4bRpwnVrxHCGxSFiPTKUEZGUdAUaGjnlWDSjg8CZ4gfwURcLxuMTtDww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, September 16, 2020 02:24
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: use the AV1 defines for VCN 3.0

Switch from magic numbers to defines for AV1 clockgating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 589d6cd8adec..e074f7ed388c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -746,18 +746,18 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 		| UVD_SUVD_CGC_GATE__IME_HEVC_MASK
 		| UVD_SUVD_CGC_GATE__EFC_MASK
 		| UVD_SUVD_CGC_GATE__SAOE_MASK
-		| 0x08000000
+		| UVD_SUVD_CGC_GATE__SRE_AV1_MASK
 		| UVD_SUVD_CGC_GATE__FBC_PCLK_MASK
 		| UVD_SUVD_CGC_GATE__FBC_CCLK_MASK
-		| 0x40000000
+		| UVD_SUVD_CGC_GATE__SCM_AV1_MASK
 		| UVD_SUVD_CGC_GATE__SMPA_MASK);
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE, data);
 
 	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE2);
 	data |= (UVD_SUVD_CGC_GATE2__MPBE0_MASK
 		| UVD_SUVD_CGC_GATE2__MPBE1_MASK
-		| 0x00000004
-		| 0x00000008
+		| UVD_SUVD_CGC_GATE2__SIT_AV1_MASK
+		| UVD_SUVD_CGC_GATE2__SDB_AV1_MASK
 		| UVD_SUVD_CGC_GATE2__MPC1_MASK);
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE2, data);
 
@@ -776,8 +776,8 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 		| UVD_SUVD_CGC_CTRL__SMPA_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPBE0_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPBE1_MODE_MASK
-		| 0x00008000
-		| 0x00010000
+		| UVD_SUVD_CGC_CTRL__SIT_AV1_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_AV1_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPC1_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__FBC_PCLK_MASK
 		| UVD_SUVD_CGC_CTRL__FBC_CCLK_MASK);
@@ -892,8 +892,8 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 		| UVD_SUVD_CGC_CTRL__SMPA_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPBE0_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPBE1_MODE_MASK
-		| 0x00008000
-		| 0x00010000
+		| UVD_SUVD_CGC_CTRL__SIT_AV1_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_AV1_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPC1_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__FBC_PCLK_MASK
 		| UVD_SUVD_CGC_CTRL__FBC_CCLK_MASK);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cf1b6a751d3c949dacef608d859a49351%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637357910672209491&amp;sdata=YZ0iB9Ol3M1ErK1LzQqmXvO3USy7G7NvoHxff0liN%2BE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
