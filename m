Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FEDC10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 02:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7A6208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 02:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jZqftemZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7A6208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D0289F5B;
	Wed, 11 Mar 2020 02:33:31 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6498889F5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 02:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiWeKSW5FRjipYNMnrSsNvSy0MVOcwOadqDZR+va7qE291BwZqRigzM6OgKEgu8jJQNNtCVpnLqMRcLCWxClAT505OJVVUmyzyxUWecVpZGaD1X+M8YruvdcO8q/2u+r28DcaZzdKhVxrF4wMWEPTbsbZAkToznVYFwcNacVRovqUBZE6/k6MIv9KjRcaWp0Dr6VVCkJfaLm98cPLwU3FpLBEMLnjexrjI7AYI1lzyfhv0iXkz4WxadJYKFKow9SoZPcXu+3CkepXTlYYA+7u7ewBi8DFdQwARKgwr1LvcwmxTplt8fBCMWcvDluyAkS+3nGXHSWvA1Mi9bY26G0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBU4fszhD1RXVHPawud4TLY3ePeZklC+gqAPRTy1xhk=;
 b=a/YhOAUXda9NTY/uxn09rjUxiEmTmfN3cJA8I8O+Ed+cm+7/8+iuvCqXF46QgTZhbPdXL8/Ruma5RVSis42yDdVyPbJXiUhcUibfQ13jhyQgVA+89n6Rb/nKeFLaj/xUhQO07weKXVv+7Mn4e4JTsDw9j06ewUWjgTtpPYp32bzKT2suVzUfVIuhs7cLECZmdfoR7y+V59gZM/5tHYAgdCSIPh98J6R3+4iKXDzxa1fy/koqRgXpHEzJo+TBWqNLOHNLQI2L+4i8GMA6YdO7bUMrxUPJ9PY8C9fzYgg9rtR8pJ7U4YjteZcJVZ9NK1z+a+aniPhfQEGFJq6rF00UgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBU4fszhD1RXVHPawud4TLY3ePeZklC+gqAPRTy1xhk=;
 b=jZqftemZs1Hf2XrwiCsvIOhUxmNakviwrc7c8FyAvWCFijF9oTJWysSxM3qdhCzwkOd8likWx+EqtzipmudEsG8ptjbJzZodDiy/TrY/E4W5KpTRiUJzbtG0s/9ineOpSa55/y7d2WJOBHPFO65nD4/Ky6BIUdVQr/4yyf+iTb4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3323.namprd12.prod.outlook.com (2603:10b6:5:11f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 02:33:29 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:33:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Thread-Topic: [PATCH] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Thread-Index: AQHV90hu3daaO6MXCEiVjySXfunbHKhCqAPwgAADJlCAAACb4A==
Date: Wed, 11 Mar 2020 02:33:29 +0000
Message-ID: <DM6PR12MB40750F484871A3199611F139FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200311015713.23363-1-guchun.chen@amd.com>
 <DM6PR12MB40756FDE70B1DD2C6426A32CFCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB407539BA630AF236D2C048F7FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407539BA630AF236D2C048F7FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-11T02:28:52Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c5503756-cd47-4b09-b8c3-0000ca6d1e7d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-11T02:33:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 839f8e46-9123-43ab-ab4e-000019300f9e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 774004b8-ebea-41f0-2ca1-08d7c56495b5
x-ms-traffictypediagnostic: DM6PR12MB3323:|DM6PR12MB3323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3323EE1B919AF93B8F3595A8FCFC0@DM6PR12MB3323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(9686003)(316002)(5660300002)(110136005)(26005)(53546011)(7696005)(6506007)(52536014)(33656002)(6636002)(966005)(478600001)(45080400002)(86362001)(66946007)(64756008)(66556008)(66446008)(30864003)(76116006)(2906002)(66476007)(8676002)(81156014)(81166006)(15650500001)(8936002)(55016002)(186003)(2940100002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3323;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PA6APPFyYj9WU6eBCh8hnSsvRnejT5H0E6G9Fmbb4hH8uAyUjDR5uRwWUf+39ECZ6u3ZP+jHLgC+qOWy5N5FfP6UwCZ/552gqRSvnM+bFhT8dUQDNNT4c0zSRm2x7sXB7rlTzy5Lp54QPqUFiCxz4qKcuNS5tHSVsGSZCqL8cbJDBTuaS3CJqWk+h4+DqvwoLCm/dbOhn+VbikXP2UnHps2pIg8NXawLDG0I4Q9p3PQi7Fycb11Xyl59HdZ4cSBsgei2QOA/xoKQZUlKLWPohm1JgIZL0ogJhML0MAzhw94vvLuhgQ70bM2Wgt5dUgefJB0yTtbxfMatMhnb7xP0UYQB8ZHzYNWQGftdzyikI+IDSYh2QIzIpIYdAzmgAYokTMR480mE7aG9uEG13aRgyC7gW63yCI8FFLuqPhuQO6ipuSJwnZWLnrI4NxFXnpuy
x-ms-exchange-antispam-messagedata: gs4avTe0B9ZWff+GsY3FoUrKNN+LQQI93MYB4zzSBkMhwxwaIoAefG9v5KMtURx4GGlIIkPqsUlzU4HKE3C2SdVhYTt2Hx1B7y8h6MiBGdKWTwGO+zKc3jPHaGLbwIyx+uPLU7byjrTSY1rhmxsfCg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774004b8-ebea-41f0-2ca1-08d7c56495b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 02:33:29.3253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UepoQE7Djr/qQfkYXT3gTZ7xC982NelcaH9qvHuMisyccB7J+yNqA8abBLF+hWuWMktg9J3jT9dTMh/itC0xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
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
Content-Type: multipart/mixed; boundary="===============0115689690=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0115689690==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40750F484871A3199611F139FCFC0DM6PR12MB4075namp_"

--_000_DM6PR12MB40750F484871A3199611F139FCFC0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

 Oops, update the format to make it more readable.

1.      Disallow sriov guest/vf driver.
2.      Only include ASIC families that has server skus
3.      disable all the IP block RAS if amdgpu_ras_enable =3D=3D 0
4.      Check HBM ECC flag
a.      explicitly inform users on the availability of this capability
b.      if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_mask
5.      Check SRAM ECC flag
a.      explicitly inform users on the availability of this capability
b.      if SRAM ECC flag is not supported, disable other IP Blocks in amdgp=
u_ras_mask
6.      Remove the redundant RAS atombios query in gmc_v9_0_late_init for V=
EGA20/ARCTURUS
a.      for Vega10 (legacy RAS), we have to keep inform user on RAS capabil=
ity and apply DF workaround
b.      we can try to merge vega10 as well but that can be next step.

Regards,
Hawking
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, March 11, 2020 10:31
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.c=
om>; amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Zhou1, =
Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
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


--_000_DM6PR12MB40750F484871A3199611F139FCFC0DM6PR12MB4075namp_
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
a name=3D"_msipheadera92e061b"></a>
<div><font face=3D"Arial" size=3D"2" color=3D"#0078D7"><span style=3D"font-=
size:10pt;">[AMD Official Use Only - Internal Distribution Only]<br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> Oop=
s, update the format to make it more readable.</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<ol style=3D"margin:0;padding-left:36pt;list-style-type:decimal;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>Disallow sriov guest/vf driver.</li><li>Only include ASIC families that=
 has server skus</li><li>disable all the IP block RAS if amdgpu_ras_enable =
=3D=3D 0</li><li>Check HBM ECC flag</li></span></font>
</ol>
<ol style=3D"margin:0;padding-left:72pt;list-style-type:lower-alpha;">
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<li>explicitly inform users on the availability of this capability</li><li>=
if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_mask</li></sp=
an></font>
</ol>
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
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>

Sent: Wednesday, March 11, 2020 10:31<br>

To: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chen, Guchun &lt;Guchun.C=
hen@amd.com&gt;; amd-gfx@lists.freedesktop.org; Li, Dennis &lt;Dennis.Li@am=
d.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Clements, John &lt;John.Cl=
ements@amd.com&gt;<br>

Subject: RE: [PATCH] drm/amdgpu: update ras support capability with differe=
nt sram ecc configuration</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
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

--_000_DM6PR12MB40750F484871A3199611F139FCFC0DM6PR12MB4075namp_--

--===============0115689690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0115689690==--
