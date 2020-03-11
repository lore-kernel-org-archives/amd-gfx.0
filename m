Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF775C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 02:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81E320637
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 02:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W9AQRJPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81E320637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8821D892A1;
	Wed, 11 Mar 2020 02:41:04 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750044.outbound.protection.outlook.com [40.107.75.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C63891E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 02:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr3hVzJa0V/DotPAf/Ut2gZOw0ftvT9DTNid2EERTTmEgqkrnZkpOJ5gcgkeX79LYLKFq2Rujk6QR1nyjLMxjT8FVhxE6DpxGG0NceUGR97gVUOQMkc32hF224ecFC6poVPBpHvzmVXEkBGp3X68mZiNQvwuBEGc+jqXZY9LnIgTtFRDmQRTLechoXFkukegwVUrO5BHqJfugRfpTucT4aimAmL44fKg8TbiirjtpLYUzqLW5LGIZiDmiSUvpi1HgmwQJKr0ni9wTaqIWIp6NkQXF+H8wEuH5wOxObV0+a0C/tHO7/T4ekVIIpyLuRQ6YKRFGD4KvVgDHu3xROB1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR5NIcxrHaQD67SWz2EYR4F1VekRBgzTxlOwPH8Xov0=;
 b=SF/sXDrgjcxnqtIvWBWNsqsACwal+qsu1kTc1ar/bM9Bg7hsMFf3VkC3bh4NRMooDOIqUy2ktXi8h0j24xKWfJulMlAADA7Prrw8U75DBhXa2jRMcaLd+Nq4JDVDAVKhPDsrQ7o/v0Wl3gntmHEBOvztIRgFt4NpB1LQnOZAw0rRuNE6DccA9jEQGt1+DcVdgBhrvsBDbst19cMUl4PCPhXWfgtBjCluYDP4GyoVxzcy+vsiV+4828qlDALwNXXG+Xn1edZSUWMKaPRg1xfLrUv5BPAtUGml9fktQA5UE/onnB+KTtaMsHXON8kyK4Z7WgWeb1GQI/RVoSLFOkTTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR5NIcxrHaQD67SWz2EYR4F1VekRBgzTxlOwPH8Xov0=;
 b=W9AQRJPIpaMLEQpLUKDzjFPnE6yXzgOT2tAG1M/682XmuZCb6grOUeL8gId53oIEPPg4JjdZOuGch7cx58ZJ6kncTMa2c+594WHOR9huZkk7jiw0MEBiMLHz5ySgeHCXOVPTyj+QhWIqabQI2h+7Wb5WIGTgu47LAeqXgthwNao=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3063.namprd12.prod.outlook.com (2603:10b6:a03:d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 02:41:00 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:40:59 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Thread-Topic: [PATCH] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Thread-Index: AQHV90htLbJJDAxvDU2V/WLVThEhCqhCqw0AgAAAlYCAAACzgIAAADYQ
Date: Wed, 11 Mar 2020 02:40:59 +0000
Message-ID: <BYAPR12MB28068A6E3223225B2CA00B77F1FC0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200311015713.23363-1-guchun.chen@amd.com>
 <DM6PR12MB40756FDE70B1DD2C6426A32CFCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB407539BA630AF236D2C048F7FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB40750F484871A3199611F139FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40750F484871A3199611F139FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-11T02:34:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dce66b83-6547-4517-95d2-0000a1ab903f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-11T02:40:50Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 627f1fd5-fca9-4b35-8a54-0000b5a6f6e9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb6a2352-00bd-400f-fe2c-08d7c565a230
x-ms-traffictypediagnostic: BYAPR12MB3063:|BYAPR12MB3063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3063104E96D7EBEF64894A66F1FC0@BYAPR12MB3063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(199004)(186003)(6636002)(15650500001)(55016002)(9686003)(2906002)(71200400001)(66946007)(86362001)(52536014)(478600001)(81156014)(7696005)(81166006)(30864003)(8936002)(45080400002)(76116006)(316002)(26005)(66476007)(110136005)(966005)(8676002)(6506007)(33656002)(66556008)(64756008)(66446008)(5660300002)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3063;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUDQUwCB45NRYPDgGLwvj01RrtS6vA/oGny6KCO0JLbYlPNoa2yDIzVG+IIXmiZJwSHfVye27SepqxJxNf4qt8OhExhYWEfewv6n3n9F3l061O+sTBumCyj/SQCSg/X84e+Ei8TrSAn2pd7b1g3Upj1dRBlFuvGF6kLxUqBOaO+5WCX5+BZxw54MPp0w944OxkIN1YmLAS7dI3mnecUUGlCcmJeYjjiz7AznPgNDoJABi1duToGOeDY4x/m0DdRuXGL6wWoVO+37rT1vBc7ZhO2rXVwlX9nR8GEuGF0d4HiXe8YuPkOh3VAEPK08iGdnOTJQr2ykaG9vkIKzFGOOw/YakB4z9N4mT7pknwn7byXClyD+W56nZwcZJGu6eoOfgxv+jk59m6CA6oh2IwWEtR3FhkrTICY2ukfSoDbZPL8BlsS/FBFOW84b5NC5Yt90
x-ms-exchange-antispam-messagedata: cOSAzjE6bIbdxP44bLhyFFy8WZiU5eJ2lG6NK5K04w/6LVwbUr3sR1c4OlWkrEP9KvVNZEOc0GfNlcfxsnXWQaaVEb9nWGeuq0kJs8q/yCY52rMcNI1KUMoJdExQ5jUj8HeFtmrDLQULbeMLJvp10A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6a2352-00bd-400f-fe2c-08d7c565a230
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 02:40:59.8303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuA8aYIoyaq13b4xzv8oyNW3nr759gcbA3VlLQoXwZlUSkwAIKbzd/cukmcfCq4xwm4zF8//OHOKrNcfZ4o6nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3063
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
Content-Type: multipart/mixed; boundary="===============0166512426=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0166512426==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB28068A6E3223225B2CA00B77F1FC0BYAPR12MB2806namp_"

--_000_BYAPR12MB28068A6E3223225B2CA00B77F1FC0BYAPR12MB2806namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi Hawking,

Thanks for your suggestion.
Feedback inline.

Regards,
Guchun


_____________________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, March 11, 2020 10:33 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Li, =
Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John =
<John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update ras support capability with differe=
nt sram ecc configuration


[AMD Official Use Only - Internal Distribution Only]

 Oops, update the format to make it more readable.

1.      Disallow sriov guest/vf driver.
   [Guchun]Current code has it.

2.      Only include ASIC families that has server skus
   [Guchun]Current we only allow asics Vega20 and Arcturus for ras init.

3.      disable all the IP block RAS if amdgpu_ras_enable =3D=3D 0
   [Guchun]This patch includes this logic. When amdgu_ras_enable, ras->supp=
orted will be set to be 0. No IP block will init ras corresponding code.

4.      Check HBM ECC flag
a.      explicitly inform users on the availability of this capability
b.      if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_mask
   [Guchun]This is missed. I will update to cover this.

5.      Check SRAM ECC flag
a.      explicitly inform users on the availability of this capability
b.      if SRAM ECC flag is not supported, disable other IP Blocks in amdgp=
u_ras_mask
   [Guchun]Current patch has done this.

6.      Remove the redundant RAS atombios query in gmc_v9_0_late_init for V=
EGA20/ARCTURUS
a.      for Vega10 (legacy RAS), we have to keep inform user on RAS capabil=
ity and apply DF workaround
b.      we can try to merge vega10 as well but that can be next step.
[Guchun]Sure. I will send another patch to achieve this.

Regards,
Hawking
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Wednesday, March 11, 2020 10:31
To: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; C=
hen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Li, Dennis <Dennis=
.Li@amd.com<mailto:Dennis.Li@amd.com>>; Zhou1, Tao <Tao.Zhou1@amd.com<mailt=
o:Tao.Zhou1@amd.com>>; Clements, John <John.Clements@amd.com<mailto:John.Cl=
ements@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: update ras support capability with differe=
nt sram ecc configuration

[AMD Official Use Only - Internal Distribution Only]

Add one more check.

1). Disallow sriov guest/vf driver.
2). Only include ASIC families that has server skus 3). disable all the IP =
block RAS if amdgpu_ras_enable =3D=3D 0 4). Check HBM ECC flag
        a). explicitly inform users on the availability of this capability
        b). if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_m=
ask 5). Check SRAM ECC flag
        a). explicitly inform users on the availability of this capability
        b). if SRAM ECC flag is not supported, disable other IP Blocks in a=
mdgpu_ras_mask 6). Remove the redundant RAS atombios query in gmc_v9_0_late=
_init for VEGA20/ARCTURUS
        a). for Vega10 (legacy RAS), we have to keep inform user on RAS cap=
ability and apply DF workaround
        b). we can try to merge vega10 as well but that can be next step.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Zhang, Hawking
Sent: Wednesday, March 11, 2020 10:29
To: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Li, Dennis <D=
ennis.Li@amd.com<mailto:Dennis.Li@amd.com>>; Zhou1, Tao <Tao.Zhou1@amd.com<=
mailto:Tao.Zhou1@amd.com>>; Clements, John <John.Clements@amd.com<mailto:Jo=
hn.Clements@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: update ras support capability with differe=
nt sram ecc configuration

[AMD Official Use Only - Internal Distribution Only]

Hi Guchun,

I would suggest we organized the amdgpu_ras_check_supported in following lo=
gic

1). Disallow sriov guest/vf driver.
2). Only include ASIC families that has server skus 3). Check HBM ECC flag
        a). explicitly inform users on the availability of this capability
        b). if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_m=
ask 4). Check SRAM ECC flag
        a). explicitly inform users on the availability of this capability
        b). if SRAM ECC flag is not supported, disable other IP Blocks in a=
mdgpu_ras_mask 5). Remove the redundant RAS atombios query in gmc_v9_0_late=
_init for VEGA20/ARCTURUS
        a). for Vega10 (legacy RAS), we have to keep inform user on RAS cap=
ability and apply DF workaround
        b). we can try to merge vega10 as well but that can be next step.

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Wednesday, March 11, 2020 09:57
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Li, Den=
nis <Dennis.Li@amd.com<mailto:Dennis.Li@amd.com>>; Zhou1, Tao <Tao.Zhou1@am=
d.com<mailto:Tao.Zhou1@amd.com>>; Clements, John <John.Clements@amd.com<mai=
lto:John.Clements@amd.com>>
Cc: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH] drm/amdgpu: update ras support capability with different s=
ram ecc configuration

When sram ecc is disabled by vbios, ras initialization process in the corrr=
esponding IPs that suppport sram ecc needs to be skipped. So update ras sup=
port capability accordingly on top of this configuration. This capability w=
ill block further ras operations to the unsupported IPs.

Signed-off-by: Guchun Chen <guchun.chen@amd.com<mailto:guchun.chen@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 69b02b9d4131..79be004378fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1748,8 +1748,23 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev,
                         amdgpu_atomfirmware_sram_ecc_supported(adev)))
                *hw_supported =3D AMDGPU_RAS_BLOCK_MASK;

-       *supported =3D amdgpu_ras_enable =3D=3D 0 ?
-                               0 : *hw_supported & amdgpu_ras_mask;
+       if (amdgpu_ras_enable =3D=3D 0)
+               *supported =3D 0;
+       else {
+               *supported =3D *hw_supported;
+               /*
+                * When sram ecc is disabled in vbios, bypass those IP
+                * blocks that support sram ecc, and only hold UMC and DF.
+                */
+               if (!amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+                       DRM_INFO("Bypass IPs that support sram ecc.\n");
+                       *supported &=3D (1 << AMDGPU_RAS_BLOCK__UMC |
+                                       1 << AMDGPU_RAS_BLOCK__DF);
+               }
+
+               /* ras support needs to align with module parmeter */
+               *supported &=3D amdgpu_ras_mask;
+       }
 }

 int amdgpu_ras_init(struct amdgpu_device *adev)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Chawking.=
zhang%40amd.com%7C3d2355f98f2444a8327808d7c563f58f%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637194905433994263&amp;sdata=3DtAAbGn2gNN05yUL%2FRIyn%=
2BSbUcIhu4lUQbcw6YO6cfd0%3D&amp;reserved=3D0


--_000_BYAPR12MB28068A6E3223225B2CA00B77F1FC0BYAPR12MB2806namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12pt;"><=
a name=3D"_msipheader87abd423"></a>
<div><font face=3D"Arial" size=3D"2" color=3D"#317100"><span style=3D"font-=
size:10pt;">[AMD Public Use]<br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi H=
awking,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Than=
ks for your suggestion.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Feed=
back inline.</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Guch=
un</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">___=
__________________________________________<br>

<b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>

<b>Sent:</b> Wednesday, March 11, 2020 10:33 AM<br>

<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd=
.com&gt;; Clements, John &lt;John.Clements@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH] drm/amdgpu: update ras support capability with =
different sram ecc configuration</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<a name=3D"_msipheadera92e061b"></a>
<div><font face=3D"Arial" size=3D"2" color=3D"#0078D7"><span style=3D"font-=
size:10pt;">[AMD Official Use Only - Internal Distribution Only]<br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> Oop=
s, update the format to make it more readable.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<ol style=3D"margin:0;padding-left:36pt;list-style-type:decimal;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>Disallow sriov guest/vf driver.</li></span></font>
</ol>
<div style=3D"padding-left:18pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[Guchun]Current code has it.</span></font></div>
<div style=3D"padding-left:18pt;"><font size=3D"2"><span style=3D"font-size=
:11pt;">&nbsp;</span></font></div>
<ol start=3D"2" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>Only include ASIC families that has server skus</li></span></font>
</ol>
<div style=3D"padding-left:18pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[Guchun]Current we only allow asics Vega20 and Arc=
turus for ras init.</span></font></div>
<div style=3D"padding-left:18pt;"><font size=3D"2"><span style=3D"font-size=
:11pt;">&nbsp;</span></font></div>
<ol start=3D"3" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>disable all the IP block RAS if amdgpu_ras_enable =3D=3D 0</li></span><=
/font>
</ol>
<div style=3D"padding-left:18pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[Guchun]This patch includes this logic. When amdgu=
_ras_enable, ras-&gt;supported will be set to be 0. No IP block will init r=
as corresponding code.</span></font></div>
<div style=3D"padding-left:18pt;"><font size=3D"2"><span style=3D"font-size=
:11pt;">&nbsp;</span></font></div>
<ol start=3D"4" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>Check HBM ECC flag</li></span></font>
</ol>
<ol style=3D"margin:0;padding-left:72pt;list-style-type:lower-alpha;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>explicitly inform users on the availability of this capability</li><li>=
if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_mask</li></sp=
an></font>
</ol>
<div style=3D"padding-left:18pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[Guchun]This is missed. I will update to cover thi=
s. </span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<ol start=3D"5" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>Check SRAM ECC flag</li></span></font>
</ol>
<ol start=3D"3" style=3D"margin:0;padding-left:72pt;list-style-type:lower-a=
lpha;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>explicitly inform users on the availability of this capability</li><li>=
if SRAM ECC flag is not supported, disable other IP Blocks in amdgpu_ras_ma=
sk</li></span></font>
</ol>
<div style=3D"padding-left:18pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[Guchun]Current patch has done this.</span></font>=
</div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<ol start=3D"6" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>Remove the redundant RAS atombios query in gmc_v9_0_late_init for VEGA2=
0/ARCTURUS</li></span></font>
</ol>
<ol start=3D"5" style=3D"margin:0;padding-left:72pt;list-style-type:lower-a=
lpha;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>for Vega10 (legacy RAS), we have to keep inform user on RAS capability =
and apply DF workaround</li><li>we can try to merge vega10 as well but that=
 can be next step.</li></span></font>
</ol>
<div style=3D"text-indent:36pt;"><font face=3D"Calibri" size=3D"2"><span st=
yle=3D"font-size:11pt;">[Guchun]Sure. I will send another patch to achieve =
this.</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font col=
or=3D"#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;
<br>

Sent: Wednesday, March 11, 2020 10:31<br>

To: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font color=
=3D"#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; Chen, Guchun &lt;=
<a href=3D"mailto:Guchun.Chen@amd.com"><font color=3D"#0563C1"><u>Guchun.Ch=
en@amd.com</u></font></a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.=
org"><font color=3D"#0563C1"><u>amd-gfx@lists.freedesktop.org</u></font></a=
>;
Li, Dennis &lt;<a href=3D"mailto:Dennis.Li@amd.com"><font color=3D"#0563C1"=
><u>Dennis.Li@amd.com</u></font></a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:=
Tao.Zhou1@amd.com"><font color=3D"#0563C1"><u>Tao.Zhou1@amd.com</u></font><=
/a>&gt;; Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com"><font =
color=3D"#0563C1"><u>John.Clements@amd.com</u></font></a>&gt;<br>

Subject: RE: [PATCH] drm/amdgpu: update ras support capability with differe=
nt sram ecc configuration</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[AMD=
 Official Use Only - Internal Distribution Only]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Add =
one more check.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">1). =
Disallow sriov guest/vf driver.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2). =
Only include ASIC families that has server skus 3). disable all the IP bloc=
k RAS if amdgpu_ras_enable =3D=3D 0 4). Check HBM ECC flag</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a). explicitly inform users on the a=
vailability of this capability</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b). if HBM ECC is not supported, dis=
able UMC/DF RAS in amdgpu_ras_mask 5). Check SRAM ECC flag</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a). explicitly inform users on the a=
vailability of this capability</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b). if SRAM ECC flag is not supporte=
d, disable other IP Blocks in amdgpu_ras_mask 6). Remove the redundant RAS =
atombios query in gmc_v9_0_late_init for VEGA20/ARCTURUS</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a). for Vega10 (legacy RAS), we have=
 to keep inform user on RAS capability and apply DF workaround</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b). we can try to merge vega10 as we=
ll but that can be next step.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-=
gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Zhang, Hawking</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sent=
: Wednesday, March 11, 2020 10:29</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">To: =
Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com=
</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fr=
eedesktop.org</a>; Li, Dennis &lt;<a href=3D"mailto:Dennis.Li@amd.com">Denn=
is.Li@amd.com</a>&gt;;
Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&g=
t;; Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John.Clemen=
ts@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Subj=
ect: RE: [PATCH] drm/amdgpu: update ras support capability with different s=
ram ecc configuration</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[AMD=
 Official Use Only - Internal Distribution Only]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi G=
uchun,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">I wo=
uld suggest we organized the amdgpu_ras_check_supported in following logic<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">1). =
Disallow sriov guest/vf driver.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2). =
Only include ASIC families that has server skus 3). Check HBM ECC flag</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a). explicitly inform users on the a=
vailability of this capability</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b). if HBM ECC is not supported, dis=
able UMC/DF RAS in amdgpu_ras_mask 4). Check SRAM ECC flag</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a). explicitly inform users on the a=
vailability of this capability</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b). if SRAM ECC flag is not supporte=
d, disable other IP Blocks in amdgpu_ras_mask 5). Remove the redundant RAS =
atombios query in gmc_v9_0_late_init for VEGA20/ARCTURUS</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a). for Vega10 (legacy RAS), we have=
 to keep inform user on RAS capability and apply DF workaround</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b). we can try to merge vega10 as we=
ll but that can be next step.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.c=
om</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sent=
: Wednesday, March 11, 2020 09:57</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">To: =
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawkin=
g.Zhang@amd.com</a>&gt;; Li, Dennis &lt;<a href=3D"mailto:Dennis.Li@amd.com=
">Dennis.Li@amd.com</a>&gt;;
Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&g=
t;; Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John.Clemen=
ts@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Cc: =
Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com=
</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Subj=
ect: [PATCH] drm/amdgpu: update ras support capability with different sram =
ecc configuration</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">When=
 sram ecc is disabled by vbios, ras initialization process in the corrrespo=
nding IPs that suppport sram ecc needs to be skipped. So update ras support=
 capability accordingly on top of this
configuration. This capability will block further ras operations to the uns=
upported IPs.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Guchun Chen &lt;<a href=3D"mailto:guchun.chen@amd.com">guchun.ch=
en@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 &#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 17 insertions(&#43;), 2 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 69b02b9d4131..79be004378fa 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1748,8 &#43;1748,23 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_atomfirmware_sram_ecc_supported(adev)))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; *hw_supported =3D AMDGPU_RAS_BLOCK_MASK;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *supported =3D amdgpu_ras_enable =3D=3D 0=
 ?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : *hw_supported &amp; amdgpu_ras_mask;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_enable =3D=3D 0)</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *supported =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *supported =3D *hw_supported;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * When sram ecc is disabled in vbios, bypass those IP</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * blocks that support sram ecc, and only hold UMC and DF.<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_atomfirmware_sram_ecc_supported(adev)) {</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;B=
ypass IPs that support sram ecc.\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *supported &amp;=
=3D (1 &lt;&lt; AMDGPU_RAS_BLOCK__UMC |</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 1 &lt;&lt; AMDGPU_RAS_BLOCK__DF);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* ras support needs to align with module parmeter */</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *supported &amp;=3D amdgpu_ras_mask;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&#43=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_ras_init(struct amdgpu_device *adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.17=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">____=
___________________________________________</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">amd-=
gfx mailing list</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;"><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org"><font face=3D"Calibri">amd-gfx@lists.freedeskto=
p.org</font></a></span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;"><a href=3D"https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Chawking.zhang%=
40amd.com%7C3d2355f98f2444a8327808d7c563f58f%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637194905433994263&amp;amp;sdata=3DtAAbGn2gNN05yUL%2FRIyn%2B=
SbUcIhu4lUQbcw6YO6cfd0%3D&amp;amp;reserved=3D0"><font face=3D"Calibri">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Chawking.=
zhang%40amd.com%7C3d2355f98f2444a8327808d7c563f58f%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637194905433994263&amp;amp;sdata=3DtAAbGn2gNN05yUL%2FR=
Iyn%2BSbUcIhu4lUQbcw6YO6cfd0%3D&amp;amp;reserved=3D0</font></a></span></fon=
t></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
</span></font>
</body>
</html>

--_000_BYAPR12MB28068A6E3223225B2CA00B77F1FC0BYAPR12MB2806namp_--

--===============0166512426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0166512426==--
