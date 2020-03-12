Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79412C1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 06:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B58520578
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 06:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aGgf4MIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B58520578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B573896A5;
	Thu, 12 Mar 2020 06:05:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126EA896A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 06:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErvtppaF8tO/HFgqay7csE5fdPF+D5H7/IiMy2q3UQnAy12llEEIVZ3GxLXAoar7lBRTF2VkY88+9sZ72fySDUrb9z0WR14h8mqr/POGmYa2QYDP3K9kugCNLNvgFKbGh26kh8fWpQiurIR0x8lndSlfCW2QSzBcOPWt4+YAB6yGMT/dVqxofPtEyNypEoOSN18ZBOVZcMy3HfHrU26uSPWP840hFlo/7UL4uZF9AMMgyQ5CoAzDqHMnMoOXezkzn+a/nJmFZlap4fuWaYxxD4Pf0ggPgvkONcdYSi09Ef9dqZ6ot6LMVMyNmgQ4g7iICRK7/pjJm9UpPOp8MdXqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpc8c4t3QWtg9FGtc0OVf9xS6CWMd7mYjHu1Dj5gV8c=;
 b=Q01qN9AXwZPRYRwzxImDi4CmS+w3XTfOjKERuxVEWmiyjRBJsjtxkxcsNfwzLSn2+OtozqK8LlzaUqmYrZIMdJfMIEFBRr7DlvcT+oFh+TGaRQePA1MQOno8FgiXIHB00+LAy8SgKoLENR499JAgv59j764Q17c53NP924HwsffsvPNRpGFpPhrOYduhfN7gC42aCODnItpEZjdLlG74NejhWjUdvgcjQdnsB1zFtBxLWNzpY0uMcUS/HVBe1yzfEJE0o9OGKWo5mm001u4677dvZYA0+aqGad9Icgw+2v1y7uwoQ6DrQt2a1KfHGu9d325FJfeLHgO0X8LdS/c/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpc8c4t3QWtg9FGtc0OVf9xS6CWMd7mYjHu1Dj5gV8c=;
 b=aGgf4MIynwk13Imlg5a4c4zfYMehDCdgnDus0zyhiPl4neNcVPhopX164fZj5D7LpAJcVsu9gVIvzDeIKEI1lAl7s8LPQj169ymsOOv7bkgcKJZyOj7SeaaTknWO9Pi2CnnEymR7o/SKHQhfZ942+hZVioEmnCIpFcgZ07e/dO0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3612.namprd12.prod.outlook.com (2603:10b6:5:11b::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Thu, 12 Mar 2020 06:05:22 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 06:05:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update ras capability's query based on mem
 ecc configuration
Thread-Topic: [PATCH] drm/amdgpu: update ras capability's query based on mem
 ecc configuration
Thread-Index: AQHV+CM/oTizxt5VhkaJB7Tq5cYEdqhEd8qg
Date: Thu, 12 Mar 2020 06:05:22 +0000
Message-ID: <DM6PR12MB4075DAF357B6F0A1851B80CFFCFD0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200312040315.13565-1-guchun.chen@amd.com>
In-Reply-To: <20200312040315.13565-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-12T06:05:19Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=839bc27c-7cf8-4f13-8efc-00004a634f99;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-12T06:05:19Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2fa80e89-e10d-4b10-ba15-000074b1c806
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e75beba2-d204-44e3-9588-08d7c64b59ac
x-ms-traffictypediagnostic: DM6PR12MB3612:|DM6PR12MB3612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3612ACE6A3BF6C7FEB1DE702FCFD0@DM6PR12MB3612.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(52536014)(8676002)(76116006)(110136005)(81166006)(26005)(8936002)(2906002)(71200400001)(66476007)(316002)(66946007)(81156014)(53546011)(5660300002)(6506007)(66446008)(64756008)(66556008)(186003)(478600001)(7696005)(6636002)(9686003)(55016002)(15650500001)(33656002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3612;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWZ5dUegpqPR5J7ZHhad1z+joHn1fYdnUA9bH/DuKEyh8AvBkuxRfygxNtuE4bBQeEmQWdbPJW3zJA6qggu+FXZsxvTXb8hGE+cnIgg7Lie8QelAmoE70Ah/9ej5REtPcXVuw55a4rsNvlkDJQ/r1Ll4aBryD1EQiAXXKm1DUGg923xQ4JVuCwd0aE1Fyh1LYtsXUnG9lpZR83Q/VXS9FT0Ovs9BQOoCl5Q4+6V6W2Scb3PLDWRPwfjR8ZCrQaCswt+pWRC63d+8cV8u5zgaDavxjBVDKLIn7qylYmgd7E4LR3CTQx9TRQ770rbi3IfIbq0PsKw8E4p37fHX9kHcN0orKMb6LuksFC9LLAbTsqqJY0KRNuzykC3Ce7yEzFWUnClt2bIqRyo+q3A9+iuxGd0wsUXVlCWMMGyrvgmBo23NAocifAlbZc/A7cyzlSvA
x-ms-exchange-antispam-messagedata: E/db1sefQT+URrVA6/G/6XRU/IH9NShzQOf6EodFrfnEk+BIMsraiCkTM32SzCiYpSW05FgNU8eGmZhlwg3ZAWBPfcaPzbms7IrWW9tbP8YHz3E3b2vE/jN71EarXZDr4dk6WceeXFMwuQM0bmE7bg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75beba2-d204-44e3-9588-08d7c64b59ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 06:05:22.4389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lB3V5kyHhHRnIbB+eKv5a867UPi2fm7L3UktMdx+ZgXDounBBB2jxYPqZ1NQL+jfOJJmzPYt+9cVs+RD7jBMLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3612
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

+		if (!r) {
+			DRM_INFO("SRAM ECC is not present.\n");
+		} else {
+			DRM_INFO("SRAM ECC is active.\n");
 		}
{} is not  needed. With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, March 12, 2020 12:03
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: update ras capability's query based on mem ecc configuration

RAS support capability needs to be updated on top of different memeory ECC enablement, and remove redundant memory ecc check in gmc module for vega20 and arcturus.

v2: check HBM ECC enablement and set ras mask accordingly.
v3: avoid to invoke atomfirmware interface to query twice.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 36 ++++++++++---------------
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69b02b9d4131..38782add479a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1738,18 +1738,30 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	*hw_supported = 0;
 	*supported = 0;
 
-	if (amdgpu_sriov_vf(adev) ||
+	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
 	    (adev->asic_type != CHIP_VEGA20 &&
 	     adev->asic_type != CHIP_ARCTURUS))
 		return;
 
-	if (adev->is_atom_fw &&
-			(amdgpu_atomfirmware_mem_ecc_supported(adev) ||
-			 amdgpu_atomfirmware_sram_ecc_supported(adev)))
-		*hw_supported = AMDGPU_RAS_BLOCK_MASK;
+	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
+		DRM_INFO("HBM ECC is active.\n");
+		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
+				1 << AMDGPU_RAS_BLOCK__DF);
+	} else
+		DRM_INFO("HBM ECC is not presented.\n");
+
+	if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+		DRM_INFO("SRAM ECC is active.\n");
+		*hw_supported |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+				1 << AMDGPU_RAS_BLOCK__DF);
+	} else
+		DRM_INFO("SRAM ECC is not presented.\n");
+
+	/* hw_supported needs to be aligned with RAS block mask. */
+	*hw_supported &= AMDGPU_RAS_BLOCK_MASK;
 
 	*supported = amdgpu_ras_enable == 0 ?
-				0 : *hw_supported & amdgpu_ras_mask;
+			0 : *hw_supported & amdgpu_ras_mask;
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90216abf14a4..3cc886e96420 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -886,29 +886,21 @@ static int gmc_v9_0_late_init(void *handle)
 	if (r)
 		return r;
 	/* Check if ecc is available */
-	if (!amdgpu_sriov_vf(adev)) {
-		switch (adev->asic_type) {
-		case CHIP_VEGA10:
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
-			r = amdgpu_atomfirmware_mem_ecc_supported(adev);
-			if (!r) {
-				DRM_INFO("ECC is not present.\n");
-				if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
-					adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-			} else {
-				DRM_INFO("ECC is active.\n");
-			}
+	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
+		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
+		if (!r) {
+			DRM_INFO("ECC is not present.\n");
+			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
+				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
+		} else {
+			DRM_INFO("ECC is active.\n");
+		}
 
-			r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-			if (!r) {
-				DRM_INFO("SRAM ECC is not present.\n");
-			} else {
-				DRM_INFO("SRAM ECC is active.\n");
-			}
-			break;
-		default:
-			break;
+		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
+		if (!r) {
+			DRM_INFO("SRAM ECC is not present.\n");
+		} else {
+			DRM_INFO("SRAM ECC is active.\n");
 		}
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
