Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45514C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 06:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4ED2073B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 06:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dsfI4WN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4ED2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E706E2F0;
	Fri, 22 May 2020 06:16:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFB26E2F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 06:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7eAAnRqGtJf3kJ8bFjqA/gifAC7Pn9iI4CF8/Dt1Pu0fEPpc+Mby5t4eOCzGcEm0lZi89EaZRhCsQM7XdalM+hHn8MX+r2wQrZu2OYDvsZOcA78Ia63k+PGfu/4es4oAgnigBA3jT5mCohezg2xgQ3jcQ97eXRhrXWLjBavtXAMrvNVNZ/4Qzbbe0fmSAreMquuSh/4iJ/L43RSOSM2sNuVWGkH0sG5+kGvFdmxKOCRACpxSn7fLg1VcKUa5iSh38rjldDH4ColLj4XdKhMY3I+pJKoO9HuULYhZ7RreHobCVNGWQrDQgT2pnoRZUYypDOuT55gFj2iU/GT7PVS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vZ2y/wNRw2/UW1YcFe3ILg9Rxq+iFWS1F0LDmfdES8=;
 b=QxiSjkmT06eH3CztvlbzA391S4QSqDoR+yCXhXFdxewSqdeIOistrBc/gbYunFo56yre0C/lUqv3rgmpMBin+tR+X9hVoakXFAXOLTgHCF+iuWOy0lcGAHTbyqJd50xQ+KqoQMghW6KxY1XU7OBmL3YO8kWosN/GzMM6a4qEhThp0Zk5SWqmTXgL8+cY8PRnR7s4+7vpEiVCwqzXKtozYfcm37diU8xLqMtbvw/Zs268Zm9HHHUKo/juFK0HPF2r0F9NbiFYZdpDuL34T955fAYLBd7mBc/8xfJ96PnP+N55OVjHpo5CdMwHOguA0NITj39IpDeF1+5ZakanHWjEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vZ2y/wNRw2/UW1YcFe3ILg9Rxq+iFWS1F0LDmfdES8=;
 b=dsfI4WN4etgkhznjaXBVoXhLPvcED6PC90qDBBO4gF7o8Qa3Z7QzFNpg7UD776Akubc3INW9ustFk2+wO25pPYFGf+w5zLmjZvVrpecdFHfOyWABC1Mx0cif0MKgWrn5rOvQl4J1c6V2Lm93fe0wdnuOXKODQXhfKhw3TD1DAuY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Fri, 22 May 2020 06:16:13 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 06:16:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Wan, Gavin" <Gavin.Wan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWL6l+XbGPfE28U0GMJWSqbrawzqizd/CAgAAW6ZCAAAv0AIAABcWAgAAAnkA=
Date: Fri, 22 May 2020 06:16:13 +0000
Message-ID: <DM6PR12MB4075685AB7A9EACA3FBA71DEFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
 <CY4PR12MB1287CCDE92924A2C5BC25FC5F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM6PR12MB407522AD24A74063B1771BFDFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB1708563850356414C1427EFF84B40@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM5PR12MB1708FA8F3EA7F11D2E2ABEC684B40@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1708FA8F3EA7F11D2E2ABEC684B40@DM5PR12MB1708.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-22T06:16:10Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5f5a540d-5e2a-401b-aa73-000073e795d2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6975e9b-0513-420a-7f61-08d7fe17a104
x-ms-traffictypediagnostic: DM6PR12MB3257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3257FF3A18F9D777B11DE54BFCB40@DM6PR12MB3257.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIiey5zC33T1hY2zm4P92+YF6QEcO6v8d2sxIZAeWEYZKOFv5cOzDkSEQSL+XLyUO+LUZFAbT17pnOOj4WvVtaIycsAKlFgIu6pajDxdA2Xwux6hQ+F7niDI0ymHJRBEafJ63XYD+hCgEA0Oa0jtxbVQRGsfBseIZm1B6IOGnxGq2wrYnXdnPz1T1JktslTa++p+M3NU6REIry1oXV2xw5L6zqcAygTk4uAbW3pWy0H2qcQImgIHB+kyRxvMjKRpn7ynWxYYjbzs6a89ArnO1iMYni5OyxxSAsAengQI9nVgOGJnHlur0ujdt5hwkmYkPz4F2SbfOQZWi6cIUOWN/e9Yf/S8LqlLwspS5H59lnPlD+UiWu4StMLvEyHIZoCdGk6MHa6P5/J7EU2uDp6c1RJDsOwYjWvHsmqF01TtnCOTpaJUZ1SIfY7eZW+astcZ7GGt5UzBK8RqoS4gYVoD9AsgzacK22xQ1S2u8tp5NnI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(55016002)(9686003)(2906002)(86362001)(71200400001)(7696005)(33656002)(26005)(45080400002)(53546011)(66946007)(64756008)(66476007)(8676002)(110136005)(4326008)(5660300002)(52536014)(8936002)(76116006)(66446008)(66556008)(966005)(478600001)(6506007)(186003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: MWgDBomX5jYfaT4dQSWbP6wDiYeI/jGXcVYhjmJZ2iEh/5vC+IXOsuc5c+ScYZz1bZ8gb99qWyDrFck6QKXAFRdweFFLgM4EDg4IUT7rvFvzYbiLkYPrbQBtsEnSfmrBTnYYVjjp2xPl8TXgfPb5/gcGs9tWK+e24cHdUudQEEcaK08oQqwu0dULGW91JZDb8Ml5QTEHDvJm3UiWWsbxcHlFZrQvA1V42g9yu6OcZbH5pdXmyCJpTGzkj3PZ+oW8RW7Q+rxySh+7aTUt3gcd2Mocdp6ZUJvy8p57IcjvQjujFeJn85f2KH0RSvGBa/nZaLat1oOm5+0K47HtPdGN4zZP5bu5+SN0Uagi9U9p4gbQcl+5D3N1O13vVgbRocb0sephZqJWY89fTJy1OcXkXt6h4OL0RVJEztU75vw88EMpeXXUBo7IbW/MAE4wiTsBNE8RKy2gnG1T+UD1/yer8862oh28mOvchJjElE6X+gfDBb3SG5wpMkwDVXmB1AI1
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6975e9b-0513-420a-7f61-08d7fe17a104
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 06:16:13.3103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqIPmlXvkUprwQ/MepSbroUL93ITBgZm3gj8pX/WSaTI/TfnaMHVih6ZSQATUVH9W4FwKCVwVnXxpiDlbga1jQ==
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
