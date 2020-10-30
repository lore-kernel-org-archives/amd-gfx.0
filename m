Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFFFC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 12:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C8D20725
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 12:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JHtrHbrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C8D20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC61B6EDCF;
	Fri, 30 Oct 2020 12:48:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75D96EDCF
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 12:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJL+TYlj7QPkuWUFW0IgzpwIXpaSYLKGO81DLdfWpRkPtZX/XB6mfb7nzbYjPDNDLxh5fBhHTIraWj2pDsrHSHDN9neiprVChKmW2Ev0Baa+27FDDC3DECFUhIpvSu8gpJ3i4U3RZW+ttMLnLW4BdYk8qODGjvVLIAM72PMrtkBroc7ZaQpe7bkgx5j03o5+lKUUVifqa0sHIMu5mdtVeXv2uHlINVHT3ukkE++IVLeaM6VYCZ2V7mDeOd0YUCYjDsykabjZlStXDfQbNXbmPD7IpVumAnGpOrM9x23X8OScaCmncgtO7XfqiVZ+tHcAk++gi7woApOptpw/Kt3h6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8C86CkWMpfDPrpVWfnGkys/qRFDbVlHfSVuFMrj2pw=;
 b=E9rFwcWSV5ycb1WK0bdOzwvMOMmty6HwmdwH2tIyH3N4Wuom6+wKT3oVIwxyfiQfHiiNXJeVsSH647f7z0C+KZJ/2FUv8MwRN+zzw1EZSuIE5ZKgqNY6hOuvyGQ2aKKA8TnVFtDPmcC5Z6xhaj5FlTEGkQgl7z6vXF7EpAH5w3aA2pMU5HYiA2JsPbBZ6TZiffj1f536mqOxehpdhCH3J4sM50xgD+sZf1KbrOKO5IdFVlLMGtllk37NyiVmoX1NW/P+LjptiUwc1oXEZaEwBOvMHedyMHfwe8VALPIZcFBtCkIvEie+IIKva2YY2pTvoX+D9z6jszi3WI1I5YFqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8C86CkWMpfDPrpVWfnGkys/qRFDbVlHfSVuFMrj2pw=;
 b=JHtrHbrV8rKPJwdOGKjr4Nzcl5Yo9PTCD0QM9c2UTZSHjaT1gD4sIvJGKuD8oeeOChnM8JkSEbvvxxEERG0Q+ks5Oen7kBcQbQcSXOBHCvqFAppbNC7UcPPZw8QE4QX1QnzbOrKTHYes92O3KtVTKVcZir2vaBA9M9YDoSKqNRM=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19; Fri, 30 Oct 2020 12:48:39 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 12:48:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Index: AQHWrrBd3Q2HThetLk6rZZhYE/MTkqmwBwfggAAFagCAAArJIA==
Date: Fri, 30 Oct 2020 12:48:39 +0000
Message-ID: <DM6PR12MB4075B4682253CE1C5F2512EEFC150@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201030113225.12675-1-tianci.yin@amd.com>,
 <DM6PR12MB407500CE6EB454B4DA0AE713FC150@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB15464C58F1DEBA74E9F8BF2895150@DM5PR12MB1546.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB15464C58F1DEBA74E9F8BF2895150@DM5PR12MB1546.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-30T12:05:08.120Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-30T12:48:36Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Standard
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d1ed5e48-8f5e-4793-8fb7-0000b7ff52a2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 097aa6df-b375-4bb0-12be-08d87cd22032
x-ms-traffictypediagnostic: DM5PR12MB2470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB24706ECCE42AD4D650AD4525FC150@DM5PR12MB2470.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /K1VwxZeSIKIJlt091mE/KLJtUnT7DApf1hAQ8BKucuwjA85jtVf+dbXCaoibGsWQOddEbFZXL3zQwOxDUiDFMWMVmnu+/I+TRc0KoKCImgcrM9iDmBJWM22C2zHzIGCS6Z6cyZ6EnUEWUrn09CpMQKwh7BtoHw26XkYwFen3aSNJRgRikuCOs6JJHx+0K1aCasEXka2dI9gRJbbzCEX5ITxklII61uRGzc5XDQk0nagQtEYpgU2cnDeqp2FcYcYJM2/uRfmKvV/WHx020skW14LYJfIb5zjtmThrToND3do37EX/BiGOaYGDvgPSR8vTQl4vA5PD9xaFvMLc1dDZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(478600001)(316002)(8936002)(66556008)(26005)(8676002)(76116006)(5660300002)(86362001)(66446008)(2906002)(7696005)(66476007)(71200400001)(66946007)(64756008)(110136005)(33656002)(54906003)(52536014)(9686003)(53546011)(186003)(4326008)(55016002)(6506007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: uyFJMuHBNHKaLZDxEtfN1/m//0P26yWIuE+t6Nktg26yDgQ8l7hhdlem/VzLsUmus30DRw9hcFJwj1bTK2dPI+KEVN9otMwYVAWlfFE/DTdkJYb3RWiOZjDFSBaxwrnNu1oGxt4pH1diB8mXIazEhmfNlpjSCZxFBVhXpeglqWBaBhcxCEydRaGXcpnP3TJKst51TnXlpNlxBmu7UYSedHzbLky1gtq1FJJ6A4TQWSUfkjBe++vagS8zWcR6T+N91ReGt0rDuHP+mQhN6KefStm+9SxvpTWyA9wZ/QF5Ee08fObQeujPvJ9vV0PCy7kpz55UdivtC3UscFFDZmOErTjYLiVPxg97jl0wv+q6SHPB2uYWK23SO3kLWriiR0ASosydKCAA2GPvoZcq7PcMUUBqxDm/xvQOsvRbBoCvBDJK5bmfotXmmzRf+dL7dD+7zh/9i8kd+Go2d6lhYUxRqLFU2u/KPlCETOVmXopwW95KTSkianzGKgeeD1jNLqeQuTycTnIBA3TXpop2Lcq3KS0DNXLVsBH26EBke0BopZq6tboDefS0x90rxrG4LP/1Y5BWy/G2b31rjSjK6YkPrOcIrH1uFcQBTuc6VBHFDmZpGBsv1JW4ZBa2sbJuX4aMOzW/Fp4SjWIDCg3aY4cBEQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097aa6df-b375-4bb0-12be-08d87cd22032
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 12:48:39.6142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0ZUKCRt2eZEYCc5gWkgd3/GSHK3zwP0v7h//UTBC1lT6H33BTCtyI/dQzUBnvPXEgaWKqLHBXNKiwcfcRdjSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>
Content-Type: multipart/mixed; boundary="===============1829170505=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1829170505==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075B4682253CE1C5F2512EEFC150DM6PR12MB4075namp_"

--_000_DM6PR12MB4075B4682253CE1C5F2512EEFC150DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


[AMD Public Use]

I see. Thanks for the clarifying, Tianci.

In such case, how about we add a new flag AMD_IS_HEADLESS to amd_chip_flags=
, so we can identify headless asic at the beginning when we add a new item =
to pciidlist.

Regards,
Hawking
From: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Sent: Friday, October 30, 2020 20:05
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@am=
d.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU


[AMD Public Use]

Hi Hawking,

amdgpu_device_asic_has_dc_support() is referrenced by amdgpu_pci_probe(),
at that point, adev has not been allocated yet.

My change can make it to right code path.
int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
{
...
if (!amdgpu_device_has_dc_support(adev))
drm_helper_hpd_irq_event(dev);               //right path for headless SKU
else
drm_kms_helper_hotplug_event(dev);      //wrong path for headless SKU
...
}

Thanks!
Rico

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Friday, October 30, 2020 19:48
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com<mailto:Tianci.Yin@amd.com>>; amd=
-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com<mailto:Luben.Tuikov@amd.com>>; Deuc=
her, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>=
>; Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Cui, Flo=
ra <Flora.Cui@amd.com<mailto:Flora.Cui@amd.com>>; Xu, Feifei <Feifei.Xu@amd=
.com<mailto:Feifei.Xu@amd.com>>; Long, Gang <Gang.Long@amd.com<mailto:Gang.=
Long@amd.com>>; Yin, Tianci (Rico) <Tianci.Yin@amd.com<mailto:Tianci.Yin@am=
d.com>>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU

[AMD Public Use]

I'm not sure I get your point on changing amdgpu_device_has_dc_support() in=
terface by adding new parameter. but it seems to me change input parameter =
from pdev to adev for nv_is_headless_sku is more straightforward.

Regards,
Hawking
-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com<mailto:tianci.yin@amd.com>>
Sent: Friday, October 30, 2020 19:32
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com<mailto:Luben.Tuikov@amd.com>>; Deuc=
her, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>=
>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Ch=
en, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Cui, Flora <F=
lora.Cui@amd.com<mailto:Flora.Cui@amd.com>>; Xu, Feifei <Feifei.Xu@amd.com<=
mailto:Feifei.Xu@amd.com>>; Long, Gang <Gang.Long@amd.com<mailto:Gang.Long@=
amd.com>>; Yin, Tianci (Rico) <Tianci.Yin@amd.com<mailto:Tianci.Yin@amd.com=
>>
Subject: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU

From: "Tianci.Yin" <tianci.yin@amd.com<mailto:tianci.yin@amd.com>>

The crash caused by the NULL pointer of
adev->ddev.mode_config.funcs in drm_kms_helper_hotplug_event(),
but this function should not be called on headless SKU.

Fix the mismatch between the return value of
amdgpu_device_has_dc_support() and the real DCN supporting state to avoid c=
alling to drm_kms_helper_hotplug_event() in amdgpu_device_resume().

Change-Id: I3a3d387e6ab5b774abb3911ea1bf6de60797759d
Signed-off-by: Tianci.Yin <tianci.yin@amd.com<mailto:tianci.yin@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 10 ++++++++--  drivers/gpu/d=
rm/amd/amdgpu/amdgpu_display.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.h             |  1 +
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index ba65d4f2ab67..f0183271456f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1090,7 +1090,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devi=
ce *adev,
                                    u32 pcie_index, u32 pcie_data,
                                    u32 reg_addr, u64 reg_data);

-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type,
+struct pci_dev *pdev);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);

 int emu_soc_asic_init(struct amdgpu_device *adev); diff --git a/drivers/gp=
u/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c
index 1fe850e0a94d..323ed69032a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2960,11 +2960,12 @@ static void amdgpu_device_detect_sriov_bios(struct =
amdgpu_device *adev)
  * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
  *
  * @asic_type: AMD asic type
+ * @pdev: pointer to pci_dev instance
  *
  * Check if there is DC (new modesetting infrastructre) support for an asi=
c.
  * returns true if DC has support, false if not.
  */
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type,
+struct pci_dev *pdev)
 {
         switch (asic_type) {
 #if defined(CONFIG_DRM_AMD_DC)
@@ -3000,9 +3001,14 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic=
_type asic_type)
         case CHIP_VEGA20:
 #if defined(CONFIG_DRM_AMD_DC_DCN)
         case CHIP_RAVEN:
+               return amdgpu_dc !=3D 0;
         case CHIP_NAVI10:
         case CHIP_NAVI14:
         case CHIP_NAVI12:
+               if (nv_is_headless_sku(pdev))
+                       return false;
+               else
+                       return amdgpu_dc !=3D 0;
         case CHIP_RENOIR:
 #endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
@@ -3033,7 +3039,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_devic=
e *adev)
         if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
                 return false;

-       return amdgpu_device_asic_has_dc_support(adev->asic_type);
+       return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pde=
v);
 }


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 9e92d2a070ac..97014458d7de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu=
_device *adev,
          */
         if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
             amdgpu_bo_support_uswc(bo_flags) &&
-           amdgpu_device_asic_has_dc_support(adev->asic_type)) {
+           amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev))=
 {
                 switch (adev->asic_type) {
                 case CHIP_CARRIZO:
                 case CHIP_STONEY:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 4b78ecfd35f7..b23110241267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1117,7 +1117,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
         bool supports_atomic =3D false;

         if (!amdgpu_virtual_display &&
-           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
+           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev))
                 supports_atomic =3D true;

         if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) { diff=
 --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c =
index 026e0a8fd526..97446ae75b0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
         adev->virt.ops =3D &xgpu_nv_virt_ops;
 }

-static bool nv_is_headless_sku(struct pci_dev *pdev)
+bool nv_is_headless_sku(struct pci_dev *pdev)
 {
         if ((pdev->device =3D=3D 0x731E &&
             (pdev->revision =3D=3D 0xC6 || pdev->revision =3D=3D 0xC7)) ||=
 diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/=
nv.h index 515d67bf249f..7880ad0073c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -29,6 +29,7 @@
 void nv_grbm_select(struct amdgpu_device *adev,
                     u32 me, u32 pipe, u32 queue, u32 vmid);  void nv_set_v=
irt_ops(struct amdgpu_device *adev);
+bool nv_is_headless_sku(struct pci_dev *pdev);
 int nv_set_ip_blocks(struct amdgpu_device *adev);  int navi10_reg_base_ini=
t(struct amdgpu_device *adev);  int navi14_reg_base_init(struct amdgpu_devi=
ce *adev);
--
2.17.1

--_000_DM6PR12MB4075B4682253CE1C5F2512EEFC150DM6PR12MB4075namp_
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
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I see. Thanks for the clarifying, Tianci. <o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In such case, how about we add a new flag AMD_IS_HEA=
DLESS to amd_chip_flags, so we can identify headless asic at the beginning =
when we add a new item to pciidlist.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.c=
om&gt; <br>
<b>Sent:</b> Friday, October 30, 2020 20:05<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;;=
 Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;=
; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Hawk=
ing,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">amdgpu_=
device_asic_has_dc_support() is referrenced by amdgpu_pci_probe(),<o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">at that=
 point, adev has not been allocated yet.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">My chan=
ge can make it to right code path.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">int amd=
gpu_device_resume(struct drm_device *dev, bool fbcon)<br>
{<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">...<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">if (!am=
dgpu_device_has_dc_support(adev))
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">drm_hel=
per_hpd_irq_event(dev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //right path for headless SKU<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">else<o:=
p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">drm_kms=
_helper_hotplug_event(dev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //wrong path for =
headless SKU<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">...<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">}<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks!=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Rico<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@=
amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, October 30, 2020 19:48<br>
<b>To:</b> Yin, Tianci (Rico) &lt;<a href=3D"mailto:Tianci.Yin@amd.com">Tia=
nci.Yin@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;<a href=3D"mailto:Luben.Tuikov@amd.com">Luben.=
Tuikov@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.=
Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun &lt;<a hre=
f=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;;
 Cui, Flora &lt;<a href=3D"mailto:Flora.Cui@amd.com">Flora.Cui@amd.com</a>&=
gt;; Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.Xu@amd.com<=
/a>&gt;; Long, Gang &lt;<a href=3D"mailto:Gang.Long@amd.com">Gang.Long@amd.=
com</a>&gt;; Yin, Tianci (Rico) &lt;<a href=3D"mailto:Tianci.Yin@amd.com">T=
ianci.Yin@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
I'm not sure I get your point on changing amdgpu_device_has_dc_support() in=
terface by adding new parameter. but it seems to me change input parameter =
from pdev to adev for nv_is_headless_sku is more straightforward.
<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Tianci Yin &lt;<a href=3D"mailto:tianci.yin@amd.com">tianci.yin@amd.c=
om</a>&gt; <br>
Sent: Friday, October 30, 2020 19:32<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Tuikov, Luben &lt;<a href=3D"mailto:Luben.Tuikov@amd.com">Luben.Tuikov@=
amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher=
@amd.com">Alexander.Deucher@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"=
mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;;
 Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.co=
m</a>&gt;; Cui, Flora &lt;<a href=3D"mailto:Flora.Cui@amd.com">Flora.Cui@am=
d.com</a>&gt;; Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.X=
u@amd.com</a>&gt;; Long, Gang &lt;<a href=3D"mailto:Gang.Long@amd.com">Gang=
.Long@amd.com</a>&gt;;
 Yin, Tianci (Rico) &lt;<a href=3D"mailto:Tianci.Yin@amd.com">Tianci.Yin@am=
d.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU<=
br>
<br>
From: &quot;Tianci.Yin&quot; &lt;<a href=3D"mailto:tianci.yin@amd.com">tian=
ci.yin@amd.com</a>&gt;<br>
<br>
The crash caused by the NULL pointer of<br>
adev-&gt;ddev.mode_config.funcs in drm_kms_helper_hotplug_event(),<br>
but this function should not be called on headless SKU.<br>
<br>
Fix the mismatch between the return value of<br>
amdgpu_device_has_dc_support() and the real DCN supporting state to avoid c=
alling to drm_kms_helper_hotplug_event() in amdgpu_device_resume().<br>
<br>
Change-Id: I3a3d387e6ab5b774abb3911ea1bf6de60797759d<br>
Signed-off-by: Tianci.Yin &lt;<a href=3D"mailto:tianci.yin@amd.com">tianci.=
yin@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 10 ++++++++--&nbsp=
; drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;6 files changed, 13 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index ba65d4f2ab67..f0183271456f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1090,7 +1090,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pcie_index=
, u32 pcie_data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_addr, =
u64 reg_data);<br>
&nbsp;<br>
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);<br>
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, <br>
+struct pci_dev *pdev);<br>
&nbsp;bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;int emu_soc_asic_init(struct amdgpu_device *adev); diff --git a/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_d=
evice.c<br>
index 1fe850e0a94d..323ed69032a7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2960,11 +2960,12 @@ static void amdgpu_device_detect_sriov_bios(struct =
amdgpu_device *adev)<br>
&nbsp; * amdgpu_device_asic_has_dc_support - determine if DC supports the a=
sic<br>
&nbsp; *<br>
&nbsp; * @asic_type: AMD asic type<br>
+ * @pdev: pointer to pci_dev instance<br>
&nbsp; *<br>
&nbsp; * Check if there is DC (new modesetting infrastructre) support for a=
n asic.<br>
&nbsp; * returns true if DC has support, false if not.<br>
&nbsp; */<br>
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)<br>
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, <br>
+struct pci_dev *pdev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (asic_type) {<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC)<br>
@@ -3000,9 +3001,14 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic=
_type asic_type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return amdgpu_dc !=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (nv_is_headless_sku(pdev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_dc=
 !=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&nbsp;#endif<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN3_0)<br>
@@ -3033,7 +3039,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
|| adev-&gt;enable_virtual_display)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc_supp=
ort(adev-&gt;asic_type);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc_supp=
ort(adev-&gt;asic_type, adev-&gt;pdev);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 9e92d2a070ac..97014458d7de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((bo_flags &amp; AMDGPU=
_GEM_CREATE_CPU_GTT_USWC) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_bo_support_uswc(bo_flags) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device=
_asic_has_dc_support(adev-&gt;asic_type)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device=
_asic_has_dc_support(adev-&gt;asic_type, adev-&gt;pdev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 4b78ecfd35f7..b23110241267 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1117,7 +1117,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool supports_atomic =3D f=
alse;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_virtual_displa=
y &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device=
_asic_has_dc_support(flags &amp; AMD_ASIC_MASK))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device=
_asic_has_dc_support(flags &amp; AMD_ASIC_MASK, pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; supports_atomic =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((flags &amp; AMD_EXP_H=
W_SUPPORT) &amp;&amp; !amdgpu_exp_hw_support) { diff --git a/drivers/gpu/dr=
m/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 026e0a8fd526..974=
46ae75b0b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops =3D &amp=
;xgpu_nv_virt_ops;<br>
&nbsp;}<br>
&nbsp;<br>
-static bool nv_is_headless_sku(struct pci_dev *pdev)<br>
+bool nv_is_headless_sku(struct pci_dev *pdev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((pdev-&gt;device =3D=
=3D 0x731E &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (p=
dev-&gt;revision =3D=3D 0xC6 || pdev-&gt;revision =3D=3D 0xC7)) || diff --g=
it a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h inde=
x 515d67bf249f..7880ad0073c9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h<br>
@@ -29,6 +29,7 @@<br>
&nbsp;void nv_grbm_select(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 me, u32 pipe, u32 queue, =
u32 vmid);&nbsp; void nv_set_virt_ops(struct amdgpu_device *adev);<br>
+bool nv_is_headless_sku(struct pci_dev *pdev);<br>
&nbsp;int nv_set_ip_blocks(struct amdgpu_device *adev);&nbsp; int navi10_re=
g_base_init(struct amdgpu_device *adev);&nbsp; int navi14_reg_base_init(str=
uct amdgpu_device *adev);<br>
--<br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4075B4682253CE1C5F2512EEFC150DM6PR12MB4075namp_--

--===============1829170505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1829170505==--
