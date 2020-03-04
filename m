Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79174C3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 13:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC5D20848
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 13:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xMnuvZRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC5D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3DA6E169;
	Wed,  4 Mar 2020 13:25:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CBE6E176
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 13:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7cb+A9mYHDObskJd2xICqCenhOYR8X+gH0YuVZ9xImqefVurCq42vUAJVcy4iPgG9MUiPfAG1wQKMSmk4P52tLgWtkll1nrbFLepAEle71/qTg/bRKLickYiGsfnqNlvO/F+zKft52Ji4nqRlm3ak1bOIu1velnFPprNRUQ/ozfKpzwuWKkn3Z4g8j51Qxf2bg++T4CFzQYIf3UOfBVnQJwAQtBuxBy44rApSu0Jy/AFUwVAVSaD60EyCGaSKPFo9FP7tfVszcDGvLrbSGsucs3XVaLovpFolPcbU1QcUEHJ61Iyp9cJIbxzE/TThLgGvimkZdR4qfmZuPBn+mwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDxck8+wqcML6U1YrKOmopiXpFaQwCB3Xr+I8f3aelY=;
 b=kBPsEdvczwzhuNY+NY4i6yZkxiEpVh36RVNB/VZ99MGZ2asSUCXWlT3IvZcXQfo3dZiX0dgwj/ziApUbXS4Ej83xrO3YhymP+2CXqeCrSJVJCO4rQPaPjnrsTOlzs8EBUWcGRM/AD2m/2qVcPJ66XweOwmksGcRpTLKKfBVajhI6rcnmRhnKhUoPAJvCy5OhHzblib1wIFJCMKX5ikdIE55uLlZSdI/agpMfC+mV2lPXMWmzHuxE8SSbiwEF2HKi3M+R4luSzMoHwlUHqEkoMkRorLh2nkZymqamvA9PrjpmRbnXvsLnf0brRZGtbo+yOTpr+9Uhf+IXpQflF+qzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDxck8+wqcML6U1YrKOmopiXpFaQwCB3Xr+I8f3aelY=;
 b=xMnuvZRD+2ugsmEYUq3qNSIqWd28G+ckbcKaLct7AugO01c8ZQmHohZtVPJ5vAGmF0m143wMMnO419yduCzFa5ef1EiIpTt+O/vuTA/d4UUGXFieOierwjHOfydmnHFR9jaEakBN8jGYc0nWRBZa/+H0V0WEXPCQGSBqXrdeCBI=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3638.namprd12.prod.outlook.com (2603:10b6:a03:dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 13:25:42 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 13:25:42 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20
Thread-Topic: [PATCH] drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20
Thread-Index: AQHV8gcS/Azav+7OTU6uexd+NM27Zag4LJUAgAA/4rA=
Date: Wed, 4 Mar 2020 13:25:42 +0000
Message-ID: <BYAPR12MB28063FF96C3B5CB694494253F1E50@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200304092649.6109-1-Hawking.Zhang@amd.com>
 <MWHPR1201MB2479C318F928136A6C3DA98791E50@MWHPR1201MB2479.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB2479C318F928136A6C3DA98791E50@MWHPR1201MB2479.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-04T13:24:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1c3caad6-dc1a-42e5-90c1-00001f7f4a69;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-04T13:25:37Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c0a3ecc1-5748-45a4-9443-000080b55769
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0bca19ab-ee8d-441a-00d3-08d7c03f89f5
x-ms-traffictypediagnostic: BYAPR12MB3638:|BYAPR12MB3638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB36388D3A96004082A33E4C48F1E50@BYAPR12MB3638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(9686003)(64756008)(66556008)(8676002)(55016002)(71200400001)(81166006)(81156014)(4326008)(6506007)(66476007)(66446008)(53546011)(66946007)(76116006)(86362001)(5660300002)(52536014)(33656002)(316002)(26005)(186003)(110136005)(8936002)(7696005)(966005)(478600001)(45080400002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3638;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iE2MPX4f95OGZ7zLiVPNRgDjA86DOXH/mzE0wZbistE/yn0fDCSRJ0pfy2kJ84lVUg7/nKY9dHQ+84itS/JJnHo6nWl3gHmoUTf+IaGTUytqATvrnZ3SEk0ym7V7xPj1UVhmCl3wa2h/h4os8VSry3DvLqwN7vSCIMGce1H+E7W1drEyN83VSTZ8p9SGblkggaJIPoIfswkr2Cr2QH7/LRNDmfL4+x0XKuKbWwyXRDnBBAOowc8mc3bwTgU0lDTfMRoFXXSaH4ptFhECfVJvk1/KRA9JFdSLxfCFztPwT4PQV2iJIaJ+JsVf2XZMIMzxRsSM9ehst60iAdC2dQWDOOEx1yBOT586WLAl6YB0tQvkxOsGDIuwi1cKIX4HU4ROBkmByRRaHSPNfu26inWABcmpa7wlncaCaZodruG06+gJfD4tzx+R24W2yuXnNFVD+PC5gzLip0n1B8KHTf/8kO+nCa7WKdlIzxrAbHaG4gE=
x-ms-exchange-antispam-messagedata: POf0xV4+HLOTiItLhe2IgY1fUGLb/PCFwWVXi+qh2606x3J8gw1pQOhhLdBZS8h5+3EINo7PD9yHH1p+VuJ03gp8DOd/1/H1xZA4g85OBXcksWhdmYQ6T4APtUD7JlvDPpihsLi6zLEUzyFXWaHWnA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bca19ab-ee8d-441a-00d3-08d7c03f89f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 13:25:42.4463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pItqspobZd0jAGvCQTYwoMBzNCopU+3u1G/LsBe7OJBQEHSZAA8wXNrJXixpGe+JwAY8zVsP3oMgGubaH0EE9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3638
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

A spelling typo.
+/* for Vega20/arcturus regiter offset change */

regiter->register.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Li, Candice
Sent: Wednesday, March 4, 2020 5:36 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20

[AMD Official Use Only - Internal Distribution Only]

Tested-by: Candice Li <Candice.Li@amd.com>
Reviewed-by: Candice Li <Candice.Li@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: 2020年3月4日 17:27
To: amd-gfx@lists.freedesktop.org; Li, Candice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20

The ROMC_INDEX/DATA offset was changed to e4/e5 since from smuio_v11 (vega20/arcturus).

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 6b717691d554..f5e11a56158a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -89,6 +89,13 @@
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK	0x00010000L
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK		0x00020000L
 #define mmHDP_MEM_POWER_CTRL_BASE_IDX	0
+
+/* for Vega20/arcturus regiter offset change */
+#define	mmROM_INDEX_VG20				0x00e4
+#define	mmROM_INDEX_VG20_BASE_IDX			0
+#define	mmROM_DATA_VG20					0x00e5
+#define	mmROM_DATA_VG20_BASE_IDX			0
+
 /*
  * Indirect registers accessor
  */
@@ -304,6 +311,8 @@ static bool soc15_read_bios_from_rom(struct amdgpu_device *adev,  {
 	u32 *dw_ptr;
 	u32 i, length_dw;
+	uint32_t rom_index_offset;
+	uint32_t rom_data_offset;
 
 	if (bios == NULL)
 		return false;
@@ -316,11 +325,23 @@ static bool soc15_read_bios_from_rom(struct amdgpu_device *adev,
 	dw_ptr = (u32 *)bios;
 	length_dw = ALIGN(length_bytes, 4) / 4;
 
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+		rom_index_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX_VG20);
+		rom_data_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA_VG20);
+		break;
+	default:
+		rom_index_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX);
+		rom_data_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);
+		break;
+	}
+
 	/* set rom index to 0 */
-	WREG32(SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX), 0);
+	WREG32(rom_index_offset, 0);
 	/* read out the rom data */
 	for (i = 0; i < length_dw; i++)
-		dw_ptr[i] = RREG32(SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA));
+		dw_ptr[i] = RREG32(rom_data_offset);
 
 	return true;
 }
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7Ca3d950521fb444512da808d7c01f7787%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637189113776290047&amp;sdata=g5WllYTvgLwjEN80qgAupeKzCAhV2b83HJSAi%2FmCqJg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
