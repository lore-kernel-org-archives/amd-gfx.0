Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA90C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549D620786
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Taep7dX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549D620786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1406EA09;
	Thu,  3 Sep 2020 15:19:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5445D6EA09
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 15:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPxJVf8mInETmriMExwwKKCD5YZkTserekulJtbF752Ha7/PsoAGVs2UJcC+TtXQ8xv1yP5tglDkR8gcxEkpfXOLHC+BZGzcDrOwaYArndovmm04pp00hfCYb9mZF1kqvv7SLCycPS6KynN1ZJqfg7Cu9vuoCeL97Z2Mui6iWgOaF38nX99v1q1ESC/LBefjk2BNnGOO1nDL/o1HC+LKWDn6gLX/2/2nuQ/apY5adqukpOvH9QFlbSDmqtgXyrqXTImE/R7jvNkWEbGJocqAVyrPUMKv11dxc5OTZsx1le4tPjD4SaJdP/d8Vrj7H8KUJVJ74fDnXNNAlsACNf4GLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KMBwsdNwNoC/3mxUxARfu+XYePjakEOMlapXDm47MQ=;
 b=M9jaxVTuroeekgq82B5XY4H2AuLOJDw3m5N4Wb6Bf2nDoVGeF/QXNU0DVPtHCFWt5jLXvpqMdXDwu5otE3aUNYrGLUXtZyX9ByTTyvkmw+YvEqGYCp0BS/hcXbc4O8pF5INXstmS3VKunC4qt7j3vY5Vacqu1wm4RkgIatXUpee3a8JRU+4zVfvudxG9AP4h+MAWKfHyQcx3ffKrwK0ttb61H4LBENKm4Opkrtvoh8mrXnw4a9vVlmSzMTnzK/aHxLujFyEw9gCBGzbLd7HFwPuxdLrWi+UgqVskvaUr91taVsph05mj0osC48r0ff25yjY2EIN0PKLNWWSCe7uS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KMBwsdNwNoC/3mxUxARfu+XYePjakEOMlapXDm47MQ=;
 b=Taep7dX584QWHcIy/2Dcv2cMMYqZWeGO4R2qV4YVxKVWT/ykqQYkuV3Ulb6D/YwK0P5llURT9IATnSmN7Ga8AetBm7ZBIf+/LTwl38HLjm4C9/tacdajfgh86w9AFy2k3LtewC1cEyZJ2pWaQGn5M/LWFf/RrdYX34HE0AeQYB8=
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 15:19:48 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::50a9:7a6b:e4a3:6569]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::50a9:7a6b:e4a3:6569%5]) with mapi id 15.20.3305.034; Thu, 3 Sep 2020
 15:19:48 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Thread-Topic: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Thread-Index: AQHWgNBntotxbaTmK06JBJmYj1bOsalVZj+AgAGf+ICAAANgIA==
Date: Thu, 3 Sep 2020 15:19:48 +0000
Message-ID: <DM6PR12MB2938F5B8F83A4223AB53331AFD2C0@DM6PR12MB2938.namprd12.prod.outlook.com>
References: <20200902022544.24308-1-changfeng.zhu@amd.com>,
 <MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MW3PR12MB45545359545841728FC5BA67F92C0@MW3PR12MB4554.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB45545359545841728FC5BA67F92C0@MW3PR12MB4554.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-03T15:07:21.146Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-03T15:19:45Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Standard
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3fc6c608-5b4f-4c06-a182-00002b3ce588
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2408:8025:21a:94c0:5cea:51ac:d818:6d0f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 130f5347-a9b4-4b56-a62b-08d8501ccc09
x-ms-traffictypediagnostic: DM5PR12MB2485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2485403F9514559044032DDDFD2C0@DM5PR12MB2485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJmQBpx8lFUqB8AeaIe1L4C8f3ZWvRtRvYoJEIVuJZhX6XFflJeLeaxWVqjL1H8OdAwEXNc4N9y97EiCJtO0YNTKZg6LnZxoUzDCvzgC08Wl/HD3FBsRUBhGAxpPJQoY24EllTUmUa99c+qHfSvPhS0unR4ov8EZA1QCg/IYwwn2JVSgjrR8S1F2j7QmTugskXBs6GuMnugkFGNfLOcSk7TSOHDdhvtjT/iB3Fpnb0ixj/JuAKSoQCZobc6X/iXRkLavLjnFpohTbvyePSq1kWhCjA4xYarvI6xbtQRMJ1SL6Bo53+bOLbXqDOYFiiM1kdZcWWM4czrytA7pjTthC4gEGVOqEDdO4gy/mlron/0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(45080400002)(8676002)(66946007)(66446008)(186003)(83380400001)(66476007)(966005)(166002)(478600001)(66556008)(64756008)(2906002)(76116006)(7696005)(6506007)(71200400001)(33656002)(6636002)(55016002)(52536014)(53546011)(110136005)(316002)(9686003)(8936002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: znPxTgqQpXBZ/EoEyaj3gfUmkUQuRoCv5z4wHt+nFaTBaSUYE2pBu5rLda1kFXKx9dKW/7H09waduIN3t0D+W41ySeQihZ4zzOQZ/V9CuII3Il32etGBDFLY4tFlk8hBT7IOwhxee9NcMpcY9xwXtLrioVu+BKuOMyAuV38lA9Nkl5OmbO7N0qp2DbIOZFAI5YuCbg7PrxUSbZnYK76z5YeI9ioIcKQ9XoHNRF/x0KZ233HCqYwPqWPOGrs085ry8TDynjbAoFZ7bk7iQ36813O0TX6OR4npw9bBIgodFPhPFIOkswrWjPRACWrxkDCzrmj0WIydnUrSm7P3h7BqGomKxR+E0XMVkf168cXbYrnPcCkeMmudgh+2k5A0m4seEhvwhYnfz2DVvmyUwCTaeevDun/+++lWtHELfGj0Mpg3EQxSPaia9QvvSIMV/nd9RhnjzpAUkv8arZ/+vipDYkonkI8ONpTagVv1d/A8vEL0Iurgr4pgB5h9eCd7XtmdKbcTjKbSI2giqDAyFPEgPi495ivZSOqjdaRf5L69CcpG9sZ3zOXfJfnvEtwhS4HtVfJQzN/cDRekOne2aesdcidpfwD+srWeBgsWieQC7MPdQr0sik6KpNdn7bscFgsj28HJhu3e05ryeUivVSGUFLITIauzzYw6L4l1FU9EAsNA6yDHxmRti1pAIHkV2BAlCh7jiqSduWGERZQT3nmstw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130f5347-a9b4-4b56-a62b-08d8501ccc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 15:19:48.4556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0LPNz3p95TtBGkkNwCmulhBMxD/8WnRgviDuRLKylMr2O+qoUJZKDjzF5KSSPGDCgdT39j7YkvsWVFFZzCdDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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
Content-Type: multipart/mixed; boundary="===============2090735204=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2090735204==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2938F5B8F83A4223AB53331AFD2C0DM6PR12MB2938namp_"

--_000_DM6PR12MB2938F5B8F83A4223AB53331AFD2C0DM6PR12MB2938namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


[AMD Public Use]


Thanks, Lakha.

BR,
Changfeng.

From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Sent: Thursday, September 3, 2020 11:07 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Changfeng <Changfe=
ng.Zhu@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.c=
om>
Subject: Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for reno=
ir


[AMD Public Use]

Hi Alex,

psp_sw_fini() releases the ta firmware



Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpree=
t.Lakha@amd.com>>






________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: September 2, 2020 10:18 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Huang, Ray <=
Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Lakha, Bhawanpreet <Bhawanpre=
et.Lakha@amd.com<mailto:Bhawanpreet.Lakha@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for reno=
ir


[AMD Public Use]

We also need to release the firmware when the driver unloads or is that alr=
eady handled in some common path?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Changfeng.Zhu <changfeng.zhu@amd.com<=
mailto:changfeng.zhu@amd.com>>
Sent: Tuesday, September 1, 2020 10:25 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Huang, =
Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Lakha, Bhawanpreet <Bhaw=
anpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@amd.com>>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
Subject: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir

From: changzhu <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>

From: Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>

It needs to load renoir_ta firmware because hdcp is enabled by default
for renoir now. This can avoid error:DTM TA is not initialized

Change-Id: Ib2f03a531013e4b432c2e9d4ec3dc021b4f8da7d
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.co=
m>>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 54 ++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c
index 6c9614f77d33..75489313dbad 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -38,6 +38,8 @@
 #include "oss/osssys_4_0_sh_mask.h"

 MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
+MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
+
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS           0x3010024

@@ -45,7 +47,10 @@ static int psp_v12_0_init_microcode(struct psp_context *=
psp)
 {
         struct amdgpu_device *adev =3D psp->adev;
         const char *chip_name;
+       char fw_name[30];
         int err =3D 0;
+       const struct ta_firmware_header_v1_0 *ta_hdr;
+       DRM_DEBUG("\n");

         switch (adev->asic_type) {
         case CHIP_RENOIR:
@@ -56,6 +61,55 @@ static int psp_v12_0_init_microcode(struct psp_context *=
psp)
         }

         err =3D psp_init_asd_microcode(psp, chip_name);
+       if (err)
+               goto out;
+
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
+       err =3D request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
+       if (err) {
+               release_firmware(adev->psp.ta_fw);
+               adev->psp.ta_fw =3D NULL;
+               dev_info(adev->dev,
+                        "psp v12.0: Failed to load firmware \"%s\"\n",
+                        fw_name);
+       } else {
+               err =3D amdgpu_ucode_validate(adev->psp.ta_fw);
+               if (err)
+                       goto out2;
+
+               ta_hdr =3D (const struct ta_firmware_header_v1_0 *)
+                                adev->psp.ta_fw->data;
+               adev->psp.ta_hdcp_ucode_version =3D
+                       le32_to_cpu(ta_hdr->ta_hdcp_ucode_version);
+               adev->psp.ta_hdcp_ucode_size =3D
+                       le32_to_cpu(ta_hdr->ta_hdcp_size_bytes);
+               adev->psp.ta_hdcp_start_addr =3D
+                       (uint8_t *)ta_hdr +
+                       le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes=
);
+
+               adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucod=
e_version);
+
+               adev->psp.ta_dtm_ucode_version =3D
+                       le32_to_cpu(ta_hdr->ta_dtm_ucode_version);
+               adev->psp.ta_dtm_ucode_size =3D
+                       le32_to_cpu(ta_hdr->ta_dtm_size_bytes);
+               adev->psp.ta_dtm_start_addr =3D
+                       (uint8_t *)adev->psp.ta_hdcp_start_addr +
+                       le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
+       }
+
+       return 0;
+
+out2:
+       release_firmware(adev->psp.ta_fw);
+       adev->psp.ta_fw =3D NULL;
+out:
+       if (err) {
+               dev_err(adev->dev,
+                       "psp v12.0: Failed to load firmware \"%s\"\n",
+                       fw_name);
+       }
+
         return err;
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637346103730596780&amp;sdata=3DItQDVbjEzkmKeeEU%2B=
V01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;reserved=3D0

--_000_DM6PR12MB2938F5B8F83A4223AB53331AFD2C0DM6PR12MB2938namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks, Lakha.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Changfeng.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakh=
a@amd.com&gt; <br>
<b>Sent:</b> Thursday, September 3, 2020 11:07 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhu, Chang=
feng &lt;Changfeng.Zhu@amd.com&gt;; amd-gfx@lists.freedesktop.org; Huang, R=
ay &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 f=
or renoir<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Alex=
, <o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">psp_sw_=
fini() releases the ta firmware
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Reviewe=
d-by: Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.com">Bh=
awanpreet.Lakha@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.=
Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Sent:</b> September 2, 2020 10:18 AM<br>
<b>To:</b> Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Chan=
gfeng.Zhu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com=
">Ray.Huang@amd.com</a>&gt;; Lakha, Bhawanpreet &lt;<a href=3D"mailto:Bhawa=
npreet.Lakha@amd.com">Bhawanpreet.Lakha@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 f=
or renoir</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">We also=
 need to release the firmware when the driver unloads or is that already ha=
ndled in some common path?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Changfeng.Zhu &lt;<a href=3D"mailto:changfeng.zhu@amd.com">changfeng.zhu@=
amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, September 1, 2020 10:25 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Hu=
ang@amd.com">Ray.Huang@amd.com</a>&gt;; Lakha, Bhawanpreet
 &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.com">Bhawanpreet.Lakha@amd.com=
</a>&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Chan=
gfeng.Zhu@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for r=
enoir</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">From: changzhu &lt;<a href=3D"mailto:Changfeng.Zhu@a=
md.com">Changfeng.Zhu@amd.com</a>&gt;<br>
<br>
From: Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Zhu@=
amd.com</a>&gt;<br>
<br>
It needs to load renoir_ta firmware because hdcp is enabled by default<br>
for renoir now. This can avoid error:DTM TA is not initialized<br>
<br>
Change-Id: Ib2f03a531013e4b432c2e9d4ec3dc021b4f8da7d<br>
Signed-off-by: Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Chang=
feng.Zhu@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 54 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 54 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c<br>
index 6c9614f77d33..75489313dbad 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c<br>
@@ -38,6 +38,8 @@<br>
&nbsp;#include &quot;oss/osssys_4_0_sh_mask.h&quot;<br>
&nbsp;<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/renoir_asd.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/renoir_ta.bin&quot;);<br>
+<br>
&nbsp;/* address block */<br>
&nbsp;#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x3010024<br>
&nbsp;<br>
@@ -45,7 +47,10 @@ static int psp_v12_0_init_microcode(struct psp_context *=
psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *chip_name;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char fw_name[30];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ta_firmware_header_v1_0 =
*ta_hdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
@@ -56,6 +61,55 @@ static int psp_v12_0_init_microcode(struct psp_context *=
psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D psp_init_asd_micro=
code(psp, chip_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &q=
uot;amdgpu/%s_ta.bin&quot;, chip_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&amp;adev-&g=
t;psp.ta_fw, fw_name, adev-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; release_firmware(adev-&gt;psp.ta_fw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_fw =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;psp =
v12.0: Failed to load firmware \&quot;%s\&quot;\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D amdgpu_ucode_validate(adev-&gt;psp.ta_fw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out2;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ta_hdr =3D (const struct ta_firmware_header_v1_0 *)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw-&gt;data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_hdcp_ucode_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_hdcp_ucode_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_hdcp_ucode_size =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_hdcp_size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_hdcp_start_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)ta_hd=
r +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;header.ucode_array_offset_bytes);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_fw_version =3D le32_to_cpu(ta_hdr-&gt;header.uco=
de_version);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_dtm_ucode_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_size =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_dtm_size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_dtm_start_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)adev-=
&gt;psp.ta_hdcp_start_addr +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_dtm_offset_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+<br>
+out2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;psp.ta_fw);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw =3D NULL;<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;psp v12.0:=
 Failed to load firmware \&quot;%s\&quot;\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346103730596780&amp;amp;sdata=3D=
ItQDVbjEzkmKeeEU%2BV01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637346103730596780&amp;amp;sdata=3DItQDVbjEzkmKeeE=
U%2BV01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2938F5B8F83A4223AB53331AFD2C0DM6PR12MB2938namp_--

--===============2090735204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2090735204==--
