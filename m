Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094ECC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 06:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577A32064C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 06:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G+A6E1cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577A32064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2506E483;
	Wed, 28 Oct 2020 06:17:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A6D6E483
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 06:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixOMvkU1tlORHh7xChanbHqHp1OwH3tsyYbFyFoXzktrrS4XL5S4zQmDGfcNrjBm2E8P21+zkwNkZ+T4p9RXMvMMlpFKD+lewCdVDDISfnJi3lLQ65VEGvDsaFF57YdwJpyLjgDqgbqSObw2wMT4VXRkV5nRmUt+AbYq9payjjMQTGj377tskUm2tYTGXrx24TN+KdMEd9N0ob+N3QE/meI+moVWqqAutzB3V/xhQ4iUrN2Zi4KPcO2UhqSshEghH7+XGnOOoclQNaUB17JMdXCdx9X3ReV5GBfdzAUcXR+ftzrfbaiyyoBD/X+eZsu68Nm2CXB/vdO9lKJrTWtLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBtXImqFjfDWOuDREXheHf2ZqWwQcI7wU2K9Vvs6la0=;
 b=gsKLRpXC7lMi8duxfueZkSy064Lk5DHnG0kuaup5IQ8BuIDSxPk1X2q5RjNBXBNJM2wreqewZGlJKrq/i8InxaMrU0xp6Hf9CfyWwF5WM2kTK0+12pCXl6GMWnmmwGIpFSOx8ykIEPX50Yb6HGTPXkm4L0Jnaa7/rITHmNGYu/Zmq1FMY8VpA9qvCgc1HJuc7mFw3CATuM2C51FG4MT3FIkOfsjOWEhpgP+ruGfSysZmxM5j3GASAFxEazaOsurCnRSZcqt2RCBo8f+fEek6dgyx1cJ5WNV+aq5NZY8T7G/bk/rmWBFSm4iX5j5BvUZ4WnUsGccuOm4H1i9E89IoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBtXImqFjfDWOuDREXheHf2ZqWwQcI7wU2K9Vvs6la0=;
 b=G+A6E1cjGci/oaXlHM8g2GZTrTcPsHPSdYW+r1o9ywgG8t5zcoWJrwyUjf/vkvuDn0Uwh0EAoQd0WQnOFOJ3l8Nfq3AcDIlI8Z3MtREq51dyGMlJKj1GAiUXIqaKIpxGx2TpjGaslS33KdONt3dB/bo2bzCuc1yn7g6+O03R868=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 28 Oct
 2020 06:17:41 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 06:17:41 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: rename nv_is_headless_sku()
Thread-Topic: [PATCH 2/2] drm/amdgpu: rename nv_is_headless_sku()
Thread-Index: AQHWrPCLV44cDLhybUKOqjArmexG4amsic7Q
Date: Wed, 28 Oct 2020 06:17:41 +0000
Message-ID: <CY4PR12MB1287318ABF046A41C04956FEF1170@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201028060638.2339229-1-flora.cui@amd.com>
 <20201028060638.2339229-2-flora.cui@amd.com>
In-Reply-To: <20201028060638.2339229-2-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-28T06:16:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=332e0b9a-5854-4885-96f3-00005c6396f6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-28T06:17:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 22fd1678-fd13-4b0a-bb15-0000b6b2931b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eda714a8-dcce-4c9a-11e6-08d87b092d4a
x-ms-traffictypediagnostic: CY4PR1201MB0118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0118025CFEC27E543FD5DD76F1170@CY4PR1201MB0118.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /jW9fs8eUcIBjnj2U6E9QaghQIzjk+OkkOsplPNvdz/3rT1EQUhjb9MmPgvRVox4KPGsrEfYXp07VeEr2LHWCvDOLYPXjxHzrTndMtm8E4b+K28R/J+OlLldVhj9wk5D6DG2LH5xfyoShhtMuvQJvfNPr3IVC3KWaw3qFwX7HTbTxoyGY3t5euRyd4TOmZnI4TaiCwuBlm9xor2n/PngcFJO2O5lskte6PJCN4nDkK3W8MU+CzTqfyI9CZuDywXjHjNC6cu448hN0QZ5+90qW87ehezGpFA7alTzJDC8kcxch11G4h/StNtB4IXAMKdmJGaHQiEgCNZXLw4mS0ibtg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(53546011)(5660300002)(110136005)(8676002)(2906002)(8936002)(7696005)(478600001)(83380400001)(316002)(86362001)(9686003)(4326008)(33656002)(71200400001)(66946007)(52536014)(54906003)(6506007)(66476007)(66556008)(76116006)(55016002)(66446008)(64756008)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: S05ArnHi0LwU4CmqTy2loLjgWtlCBN6yeUY42W51l7RnvJAkyTQOc20at2D9wrDMDRvGlD/qiiKELuLqDdqfja/kA8lNcDVkZIRdLKicOCpCZBT/3xtRHjJdpIE2Ji2Mu6TvnY5vsUKbesnLA1TTl/9tOZtRX4FA7idsGd8la/i3x0hPzVAfh9TrSI5lP4aC1ZDIr67SWmnHVF2yfuVtEEWMiLaowVlrFS4PxYp2IgbJeX91fpgC9tzBbagfDAjArEX4bgSGU6ojnpSqRgAJ7ZRp2fbtQT41ITMqtDEgKfzMj9RyGK3THl7Cr/nKOp7Y/peZeC4ggZ2F6TpkMP8tPDxv02hc9hVTe5BWW/wK6wvkJ4gLHo1kp746UKThil3UTdBN7GMxb5BWF8HdtasDOPumo8Ln9dW3o1DGJAO0mQgrPtcUnDRkL9BcnLdgKpjgc7dlaJM+9W3S1b9W6rBZn2ZUFgiNc3EkT2mC1fHTzMFOq0jujFmpAfneJOsfsQ2oOO+EjYG84ByznIZAyBn60FHJE3eNRY3qxbu/srv1RJWT+IUCarc+n5qXZTmNqa63GMRwX1aRofPLsvdxdk/DOBfJMk0pv5IMZlKr/mrlFcyQMklSRGIP+Pz9cIwhhRj8w4ATpov8MJoBIsSEk9qu8w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda714a8-dcce-4c9a-11e6-08d87b092d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 06:17:41.6276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuGcIi2hzhQe4+PI/sS+OfFzX4npTUaUR8L2Fm7yQ6J3lLdBeMkUaHfIHTAKI/xIJV6cYTr/Q7apifG0zQLFPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Long, Gang" <Gang.Long@amd.com>, "Teng,
 Rui" <Rui.Teng@amd.com>, "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Cui, Flora <Flora.Cui@amd.com> 
Sent: Wednesday, October 28, 2020 2:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Teng, Rui <Rui.Teng@amd.com>; Long, Gang <Gang.Long@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: rename nv_is_headless_sku()

for headless NAVI ASICs

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 23446aceea1d..c65b4462bf5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
-static bool nv_is_blockchain_sku(struct pci_dev *pdev)
+static bool nv_is_headless_sku(struct pci_dev *pdev)
 {
 	if ((pdev->device == 0x731E &&
 	    (pdev->revision == 0xC6 || pdev->revision == 0xC7)) || @@ -536,7 +536,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);  #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev) &&
-			 !nv_is_blockchain_sku(adev->pdev))
+			 !nv_is_headless_sku(adev->pdev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);  #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block); @@ -544,7 +544,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (!nv_is_blockchain_sku(adev->pdev))
+		if (!nv_is_headless_sku(adev->pdev))
 			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		if (adev->enable_mes)
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
