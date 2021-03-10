Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A4C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F21964FC0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F21964FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C92566E9DB;
	Wed, 10 Mar 2021 08:42:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B55C6E9DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 08:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgvXGD3kwMEWMEHEbvweNaFE9Az6rHXvRyvgm4SZC3GceQ1Cxdf6bknmvjcEUUrPG5qrsECK6/AhoOnmU+0bMsnH9AqD25FLZK+SU4azgSKeDbt4kfVHIK6XsDmFarWjZgc34g+zJFfHIpxkDWclRTPPQTZ21koUS8HldHwX0Fjxk/WeUL244Ino/reMTuAMOzDCZ1S5lZzYwxujGSMKFhL8RvWRsItnUOrA/2zUPOuKayh32zDzolAIRZaVtEnIqCjxQwLaY5KeTrNfwqmPy0U9RpyBpL8txAfwHECVimyDN7/oBtuW1FdEMQcutwkRZxSAawIp2/06gPbmeN2eoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71EBN8+AQ4zwlTT5JUHGQr0ZKmU7EG3XOe0vZxRUPXM=;
 b=QUQ5CBnsiN3sqmmzdGNQu0yQ70mAWkY2od3HF9R4T+F0lcp/t61eYdeHbZ9i/pa+sgvHlSsBBlkP2wiIPEs+m5qLHYEMnDFRWwNMqmGgAuA717hbh3CDqY7xfH3FA2tMvqCFrfeok06zOPs8LFTZZWBhC3U2exIkgUrEq29ZmmCTKi0WrV4aUyiPirirTBs7/cheTR5sglqzal0OdTzHoDsAChdlNjMrwIJvIB2R5RuzT71VTmBtL5WEHHDFWVa9drXXqpbI4u/EpV12/33xpphoy2yiLgw9PiIy+aCblP9LtDBmQnCUSflhqnLSeY2lsmuSHDKQ75ONCZkpG6S3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71EBN8+AQ4zwlTT5JUHGQr0ZKmU7EG3XOe0vZxRUPXM=;
 b=H79uoEquzZdSUXkcjKa6WYzP1oRoJS5qPZK852HHdP0x8xJcsfW0LyOXfcu0wxLEsn22GB1QqYemG44iqYc0Tew/lSPFYDW6CdFl75IQ4rLkf4UKCsjcQhkZCSNhVquNeaBvxqfE1alHwnbJXLQpelPUMnDHR/TMxgu6S1fumjs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.30; Wed, 10 Mar 2021 08:42:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 08:42:01 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/7] drm/amdgpu: disentangle HG systems from vgaswitcheroo
Thread-Topic: [PATCH 3/7] drm/amdgpu: disentangle HG systems from vgaswitcheroo
Thread-Index: AQHXFJoqP0JRYKUqFEaiUbH3naSxOqp86I5Q
Date: Wed, 10 Mar 2021 08:42:01 +0000
Message-ID: <DM6PR12MB261998C2092183A9A8D97728E4919@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
 <20210309041012.23367-3-alexander.deucher@amd.com>
In-Reply-To: <20210309041012.23367-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T08:41:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d1e1f7a5-68a9-490d-a1df-8ed94d0ee5e5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5dc9b061-6cbf-4b09-228d-08d8e3a05fd3
x-ms-traffictypediagnostic: DM5PR12MB4678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB46782E84F26E9E3D12EC2546E4919@DM5PR12MB4678.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9v8nhQxHrYgbqo0yJd1zKLZPB0DhRwuxIkVqhmKlTrYddLXYt1xyU4DrN907CM4cTBgnmi2kKEb23MYt2vvsZ/w3EVJ2wLLU0rs5LsFBmpiOUt4LTHm6aoNnEp+QKcdyS6Dzw+vVD0RDEkyhjkAsucy9rBspq7Dz+4oNgVaH1rXRcGF2SQiSgShU0KJQb27gRz923pr+qG35px0MgfwDAhVwK62a/BKiDvx+mTDIGI5JecQiGLofftizftUCAqMki7kYJlIqMEQmiHcKQ4HyatSgAVfu7aC22OXXaAR6QXimiXVrjtK2A6neXKluW4977GCfwLM19COp/tpwFBCKPJ+p2E7l1FB0wuodeCempwCbCJsDaB5BxkhidGACe75Nx0sheEoTm5yitRO01FwL4sv8Cbfy7BKBVr1hZQGGM1NB2+7zBNE8pyCvIx+XtBvgOjQWvPIsP2ut4gvbUYkrL/2fenN+iHewaATNfE15m0cjfPEbeTMAksgdKI2fr7oaaQ9r5EZ0ZCzycvv/AnniLmeCF/GshJgGrT68B8DuKTtXjLEKQQwBtFQUyQrp/pLk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(66476007)(66946007)(76116006)(66446008)(64756008)(5660300002)(52536014)(8936002)(55016002)(9686003)(4326008)(66556008)(8676002)(2906002)(186003)(53546011)(71200400001)(7696005)(966005)(45080400002)(110136005)(478600001)(316002)(86362001)(83380400001)(33656002)(26005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RwXlkFU8T41w/veabLctdEbHnuBc+Qh7wS2C1F3Lp3uzm55fpOeCg/kIWftg?=
 =?us-ascii?Q?ClEfEcw6IrPpk0Mbj8avUpJihfFCjMmhFwDCwPNme89/ctLTNRWhBrH45rEp?=
 =?us-ascii?Q?2r0gHH285Tw17tcmh3//vjhJ/w/pBHzKt7c3oq4Sr7ujPenkl147WcFjqe9t?=
 =?us-ascii?Q?4eIBstOaEHGKRNSykpCZJ86SMUXWZpqoaMQjiondxKPi22wOV2G6CeUteqgG?=
 =?us-ascii?Q?shME9aGX8He9ihWF/GDmBDrXmUmYwBodf5k8K3RrBfdsGcj30GmBXxXMHaMx?=
 =?us-ascii?Q?XbuD5BHlwhanmdIUw7mtdywNqbWIpAgA/IvWIyEFsH/pwch0Ry0gJVFaRA5O?=
 =?us-ascii?Q?T5y8MiQtA7ppxVAqqC3ybOn7iWGJBsqt97S/2ybGngX62qz212TdRb74MXD6?=
 =?us-ascii?Q?c0hqIMCUf3kQKS048Nes4hggPkpjDhJyZTuumkPzlpj2yknVfyOjb4bb9tai?=
 =?us-ascii?Q?3xcVuJwIptSAxtZu2NK9hNYTGCwWIuhQeuXAFT942AUmjn+jhuQGHb7u2kK9?=
 =?us-ascii?Q?oKeCo21jRJ7kDO48kslwZt8PfQgep69WwOc8IzO6wflKH632Zoey+RwU//DD?=
 =?us-ascii?Q?wTAMIohvQPsSLo1xb+W7m8xjztol+txyAVSOSqqsVDDvpHxnestiUUn4RXXA?=
 =?us-ascii?Q?E67/8145jl8BfiUXulbUmOX3TXjndWlfGCDRUJ/s/Hcp4giTlPM3zj4wgCYx?=
 =?us-ascii?Q?Rbd3hgUVBqaMiPzK7y5PEQ/R3/GD+FTJcEBKLerGvdpyV3Ek/HFz6wiveJ5V?=
 =?us-ascii?Q?OBJLSBWsGVGOAMXSzkXn3Zs5TME9SlsDy2bId5sbVf3pYoZ0BoEFk9VmspGT?=
 =?us-ascii?Q?wPV7xYjwoGBsrMBxwEPWqcj6fIoZjxxITbV8/2yk4rGJz0k3DoqLn9004Owu?=
 =?us-ascii?Q?izwqc5FDAU8dpaEIaRk6tAE+PRDsA0YXWeW4rhDnJXoAZau2tudinON6NMrT?=
 =?us-ascii?Q?8EqyTLmXaAtA5CC1qhJQjWFBSiuWvEdCfs+HfbWr2nXO/6tFva5DwY2nJvoX?=
 =?us-ascii?Q?mYsqM6Qb9fr6/W0+q90YcE//MIykI76GOeNFhII+xnHKyTGy/AYEr8QGY+wg?=
 =?us-ascii?Q?Hp2f9LSiSuk5HNk6bpP/4f2d8OTdD08BXqtAnBCcM6o4yFClCLS3DK7ilHtF?=
 =?us-ascii?Q?kyxGlD3MZ+3HIJLC5KeZXFts+wVcbcwvbKBSj9wtFeg0ZXJALTKQIItdDEzC?=
 =?us-ascii?Q?p8tvcqPcwjkBqbF3h6vEuRfsx3cFxwW5neYR7CAL1BRBz51giTUboo6NBO7k?=
 =?us-ascii?Q?mVu9VyITm3zMB2F8h4051SLcpWfa31HT0eRCW9NknkJEoJzNfiC3p++gKotF?=
 =?us-ascii?Q?KSGIkwz1BbTox5XGV3DXlD5G?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc9b061-6cbf-4b09-228d-08d8e3a05fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:42:01.3740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akcqx81catWHOV9azZKa+YQxZI6NX7iTxpReEglxvboC69q7DPjvCcy3qu3Vd3a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, March 9, 2021 12:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: disentangle HG systems from vgaswitcheroo

There's no need to keep vgaswitcheroo around for HG systems.  They don't use muxes and their power control is handled via ACPI.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 34 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 ++---
 4 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b5310b35721c..d47626ce9bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1260,7 +1260,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 					     const u32 *registers,
 					     const u32 array_size);
 
-bool amdgpu_device_supports_atpx(struct drm_device *dev);
+bool amdgpu_device_supports_px(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);  bool amdgpu_device_supports_baco(struct drm_device *dev);  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6eb3b4d2c9b2..ac5f7837285b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -211,18 +211,18 @@ static DEVICE_ATTR(serial_number, S_IRUGO,
 		amdgpu_device_get_serial_number, NULL);
 
 /**
- * amdgpu_device_supports_atpx - Is the device a dGPU with HG/PX power control
+ * amdgpu_device_supports_px - Is the device a dGPU with ATPX power 
+ control
  *
  * @dev: drm_device pointer
  *
- * Returns true if the device is a dGPU with HG/PX power control,
+ * Returns true if the device is a dGPU with ATPX power control,
  * otherwise return false.
  */
-bool amdgpu_device_supports_atpx(struct drm_device *dev)
+bool amdgpu_device_supports_px(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	if (adev->flags & AMD_IS_PX)
+	if ((adev->flags & AMD_IS_PX) && !amdgpu_is_atpx_hybrid())
 		return true;
 	return false;
 }
@@ -232,14 +232,15 @@ bool amdgpu_device_supports_atpx(struct drm_device *dev)
  *
  * @dev: drm_device pointer
  *
- * Returns true if the device is a dGPU with HG/PX power control,
+ * Returns true if the device is a dGPU with ACPI power control,
  * otherwise return false.
  */
 bool amdgpu_device_supports_boco(struct drm_device *dev)  {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	if (adev->has_pr3)
+	if (adev->has_pr3 ||
+	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
 		return true;
 	return false;
 }
@@ -1429,7 +1430,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	int r;
 
-	if (amdgpu_device_supports_atpx(dev) && state == VGA_SWITCHEROO_OFF)
+	if (amdgpu_device_supports_px(dev) && state == VGA_SWITCHEROO_OFF)
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
@@ -3213,7 +3214,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
-	bool atpx = false;
+	bool px = false;
 	u32 max_MBps;
 
 	adev->shutdown = false;
@@ -3385,16 +3386,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_atpx(ddev))
-		atpx = true;
-	if (amdgpu_has_atpx() &&
-	    (amdgpu_is_atpx_hybrid() ||
-	     amdgpu_has_atpx_dgpu_power_cntl()) &&
-	    !pci_is_thunderbolt_attached(adev->pdev))
+	if (amdgpu_device_supports_px(ddev)) {
[Quan, Evan] Maybe this should be " amdgpu_device_supports_px(ddev) && amdgpu_has_atpx_dgpu_power_cntl() && !pci_is_thunderbolt_attached(adev->pdev)".
+		px = true;
 		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, atpx);
-	if (atpx)
+					       &amdgpu_switcheroo_ops, px);
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
+	}
 
 	if (amdgpu_emu_mode == 1) {
 		/* post the asic on emulation mode */ @@ -3576,7 +3573,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 failed:
 	amdgpu_vf_error_trans_all(adev);
-	if (atpx)
+	if (px)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 
 failed_unmap:
@@ -3636,13 +3633,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (amdgpu_has_atpx() &&
-	    (amdgpu_is_atpx_hybrid() ||
-	     amdgpu_has_atpx_dgpu_power_cntl()) &&
-	    !pci_is_thunderbolt_attached(adev->pdev))
+	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
[Quan, Evan] Same as above
 		vga_switcheroo_unregister_client(adev->pdev);
-	if (amdgpu_device_supports_atpx(adev_to_drm(adev)))
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
+	}
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, NULL, NULL, NULL);
 	if (adev->rio_mem)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8d4fbee01011..3e6bb7d79652 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1301,9 +1301,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if ((amdgpu_device_supports_atpx(drm_dev) &&
-	    amdgpu_is_atpx_hybrid()) ||
-	    amdgpu_device_supports_boco(drm_dev))
+	if (amdgpu_device_supports_boco(drm_dev))
 		return pm_runtime_suspended(dev) &&
 			pm_suspend_via_firmware();
 
@@ -1392,7 +1390,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
-	if (amdgpu_device_supports_atpx(drm_dev))
+	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 	ret = amdgpu_device_suspend(drm_dev, false); @@ -1401,16 +1399,14 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		return ret;
 	}
 
-	if (amdgpu_device_supports_atpx(drm_dev)) {
+	if (amdgpu_device_supports_px(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
-		if (!amdgpu_is_atpx_hybrid()) {
-			amdgpu_device_cache_pci_state(pdev);
-			pci_disable_device(pdev);
-			pci_ignore_hotplug(pdev);
-			pci_set_power_state(pdev, PCI_D3cold);
-		}
+		amdgpu_device_cache_pci_state(pdev);
+		pci_disable_device(pdev);
+		pci_ignore_hotplug(pdev);
+		pci_set_power_state(pdev, PCI_D3cold);
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
 	} else if (amdgpu_device_supports_baco(drm_dev)) {
 		amdgpu_device_baco_enter(drm_dev);
@@ -1429,19 +1425,17 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!adev->runpm)
 		return -EINVAL;
 
-	if (amdgpu_device_supports_atpx(drm_dev)) {
+	if (amdgpu_device_supports_px(drm_dev)) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
-		if (!amdgpu_is_atpx_hybrid()) {
-			pci_set_power_state(pdev, PCI_D0);
-			amdgpu_device_load_pci_state(pdev);
-			ret = pci_enable_device(pdev);
-			if (ret)
-				return ret;
-		}
+		pci_set_power_state(pdev, PCI_D0);
+		amdgpu_device_load_pci_state(pdev);
+		ret = pci_enable_device(pdev);
+		if (ret)
+			return ret;
 		pci_set_master(pdev);
 	} else if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX @@ -1452,7 +1446,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
-	if (amdgpu_device_supports_atpx(drm_dev))
+	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8e6ef4d8b7ee..86eeeb4f3513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -161,7 +161,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		goto out;
 	}
 
-	if (amdgpu_device_supports_atpx(dev) &&
+	if (amdgpu_device_supports_px(dev) &&
 	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
 		adev->runpm = true;
 		dev_info(adev->dev, "Using ATPX for runtime pm\n"); @@ -202,13 +202,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 
 	if (adev->runpm) {
 		/* only need to skip on ATPX */
-		if (amdgpu_device_supports_atpx(dev) &&
-		    !amdgpu_is_atpx_hybrid())
+		if (amdgpu_device_supports_px(dev))
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		/* we want direct complete for BOCO */
-		if ((amdgpu_device_supports_atpx(dev) &&
-		    amdgpu_is_atpx_hybrid()) ||
-		    amdgpu_device_supports_boco(dev))
+		if (amdgpu_device_supports_boco(dev))
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C51517a035c23422125bd08d8e2b14c1e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508598407995789%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=zfLM9A%2FtPCjR8xAd%2Faz2ab8Kyk%2FclUnDMKNyoLFkAlU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
