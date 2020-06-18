Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F37DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 09:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FD021BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FLhYes+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FD021BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB3C6EB32;
	Thu, 18 Jun 2020 09:30:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27BB6E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 09:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj95s6UwydmMfoOf4v3EyNP3PCg8Vw1selwivL7o09DQnetrTxQ5z9jXA7joMKhaL1lg9h9egK0ijdtu+C+2iVTZcqSRsFbyReS6Gj0pdKb+VFXCQx4Lr99c0s4+PVsRWLGQVsgCEKHxyXq6FEYbVVUhqHSx9Hn+HcR5euk6jcz0lDninZhITBogBimJEXJNyll+48KXAtzIsTYphB6csL7V48adwN/6fDY/ei+azjuEBGy/6DdgReM5hefCDZOQPT2fGlv7OdOFLYc/yGXEDrl4pZ6r5CfxdAG9ZwKVYFfZMpBIH1+bhvkvZ+AribaX3AdXbVoFaSZtm0mK9sV6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn7fpirh0ZwJiHgXETuZYreq/ZU8XdGZw8DjgqhQ9vc=;
 b=JU3a6SCgJvVf+Z941S7i8wiRXVYz2cNxoq07tt2dVHuZfN6y2u79Fq4ee1UMZHkFfwKtxYteEt0p/Q2W2ZRIgrP8lr5L190EovGsVQpdDWgR4NE0QDt2VJ51Dx1blOEAJUO90KYOvRARvlhuzDweArYKCoVYQkMS5xhSpM3aUQcTeyqNk5mPE+qbKTkzPznJAEQJVjTrIb66DR939lt1XJfi407iCv35f2EfyfvTim6mWHIt2gSv4lv5OnWeLKX9xr/q1WRi0p++raz269EMM9AyOLd7GC2PTU3Qf2L3n/nqGdung8uP17LGqXr5pJRi0SsnLbkX4O7DFcpayVqkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn7fpirh0ZwJiHgXETuZYreq/ZU8XdGZw8DjgqhQ9vc=;
 b=FLhYes+MEPN3ZMUGpsXzZMuGWKGSTBfOmE2FX0Ajc2bGpkmwwOEZO/Tu0NkW5Q4q+H9Xwr+/YkPXDjv20my+DxfOFVFrQMNHswabGjOGI+FIwlhU0FiLpzQ/ZA5Ph88xkyIzdPJan6pXbnV2p5zOL+9wtPmLnIQifOfgKaguht8=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3327.namprd12.prod.outlook.com (2603:10b6:208:cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 09:29:56 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 09:29:56 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Index: AQHWRUWyyxt0twhDmECVwlQ36PPmrajeCMCJgAACjYCAAALTd4AACviAgAABcCY=
Date: Thu, 18 Jun 2020 09:29:56 +0000
Message-ID: <MN2PR12MB302257CEE4B130B29B87D699A29B0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200618075307.3721-1-Wenhui.Sheng@amd.com>,
 <20200618075307.3721-2-Wenhui.Sheng@amd.com>
 <MN2PR12MB3022D32C41B32F413AEFF151A29B0@MN2PR12MB3022.namprd12.prod.outlook.com>,
 <CH2PR12MB4101B7B650649CADE1501E6A8C9B0@CH2PR12MB4101.namprd12.prod.outlook.com>
 <MN2PR12MB30220020DF792ED8CF72490EA29B0@MN2PR12MB3022.namprd12.prod.outlook.com>,
 <CH2PR12MB4101B84E569C4DCE6F77D1F38C9B0@CH2PR12MB4101.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4101B84E569C4DCE6F77D1F38C9B0@CH2PR12MB4101.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T09:29:55.653Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.142.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 961603d1-d58a-46d3-c019-08d8136a29f4
x-ms-traffictypediagnostic: MN2PR12MB3327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33273C2047DA7BD0EDD036E4A29B0@MN2PR12MB3327.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fl0DePm2AgHnwPyUswtdZhIZQoAKPq92a+TcJw7wQnrpeLXK9A+vFjTGBk99S6o6BGOLjq3/eEzpPVv+nXSapeULZw37J8gubuEe+k2ozx4ATBq2fAyIeQDeUll/U6nm3TWbi/nKoE4eOgHWNrqBllaJQBz13BnrwsxuxLOi0IENjZmZNqSmqss07/JR7EipjBpIV/ONOy4bBc1KpVqmtJvi/JTVw0W5bGorx0tBwEZE2uSWPojgFh1XNY4yWQicWikx/6GfI+VfKzzQUXVKZ/j65AaSRlznacmEma3OKUfvZZnt6qx4OThs1aacSwFJ616M4bZ1/Sx27SWlGLkoXP+PKdkT+6/5EFu6NjbJuCo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(8676002)(2906002)(71200400001)(33656002)(186003)(55016002)(26005)(166002)(966005)(8936002)(66946007)(19627405001)(110136005)(478600001)(9686003)(83380400001)(76116006)(7696005)(91956017)(52536014)(66476007)(66574015)(316002)(86362001)(6506007)(66556008)(64756008)(5660300002)(53546011)(45080400002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: nv5Sdge3+G+U+ONTIb2mDJbEfDZCjqQfAHu2iMYi24rLxsPHqHvcMPisoYOv9EteRRcAnLkCgIfaDbPa/CFNt/Q9Jd1q2sU47SYscpbe92/MFytYGPD2lfwyzCOZOIOJObcnkEN/P/08pEBQHqnE4NGSUfNJPCXs2WMEKDGpGc6Y7HQHXMV+E4hb7zJbhgARNwzb9Jkra37H5y85okcA16/97bJVk6vs4Stdd5Kiw+JcOSAfggiDjwudPd4brz3dWc10cILm2n5xD3N+JbXRJdW2EnnO08ZiIJDfuDsVq9Z+nLZ0f6LRkD3fXvhdCeNtHlLsPGBSEefvBN0oPfRWlYDnNCKfZQwXd80WZqCOacy7UlxsJPwhf0e6LASITizVseP5vzpjzuwggKfr9iCDO2GkbPJlzcsV7uCu8Hvob/uk4CE3VVWV9SYcgReHuGR20A24jzv/MEfmfxlazQ1kSUzLVBZlq0nDbWEUHyDqrPI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961603d1-d58a-46d3-c019-08d8136a29f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 09:29:56.3492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJVG435fT+mtE7lYIrAqurn6GQeUgkFer78b+Z46YtU/1qjkyrmCtJUvefRLH6Sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
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
Content-Type: multipart/mixed; boundary="===============0637997572=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0637997572==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB302257CEE4B130B29B87D699A29B0MN2PR12MB3022namp_"

--_000_MN2PR12MB302257CEE4B130B29B87D699A29B0MN2PR12MB3022namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

before this patch, the driver has same code logic at "drivers/gpu/drm/amd/a=
mdgpu/sdma_v3_0.c"
related patch: drm/amdgpu: fix sdma3 ucode mem leak

commit 14d83e78c578a6c45163fb399ee760fe0d314bad
Author: Monk Liu <Monk.Liu@amd.com>
Date:   Mon May 30 15:15:32 2016 +0800

    drm/amdgpu: fix sdma3 ucode mem leak

    Signed-off-by: Monk Liu <Monk.Liu@amd.com>
    Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v3_0.c
index 33605d4ac2d9..532ea88da66a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -236,6 +236,15 @@ static void sdma_v3_0_init_golden_registers(struct amd=
gpu_device *adev)
        }
 }

+static void sdma_v3_0_free_microcode(struct amdgpu_device *adev)
+{
+       int i;
+       for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               release_firmware(adev->sdma.instance[i].fw);
+               adev->sdma.instance[i].fw =3D NULL;
+       }
+}
+
 /**
  * sdma_v3_0_init_microcode - load ucode images from disk
  *
@@ -1256,6 +1265,7 @@ static int sdma_v3_0_sw_fini(void *handle)
        for (i =3D 0; i < adev->sdma.num_instances; i++)
                amdgpu_ring_fini(&adev->sdma.instance[i].ring);

+       sdma_v3_0_free_microcode(adev);
        return 0;
 }

Best Regards,
Kevin
________________________________
From: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Sent: Thursday, June 18, 2020 5:21 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]



Hmmmm=85.



  1.  There are some places in amdgpu driver using release_firmware like th=
is way
  2.  This case is a little different, we use it in loop and maybe not all =
sdma instances=92 fw is initialized, just like we did in v5_2



Brs

Wenhui



From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Thursday, June 18, 2020 4:48 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0



[AMD Official Use Only - Internal Distribution Only]



afte the API firmware_realease created, the api logic never changed. (the f=
irst commit by Linus)

and you can use below command to reference the api usage case in our drm dr=
iver.



$ grep -nR "release_firmware" -A 5 -B 5 drivers/gpu/drm/ | vim -



Best Regards,

Kevin

________________________________

From: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>
Sent: Thursday, June 18, 2020 4:31 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0



[AMD Official Use Only - Internal Distribution Only]



[AMD Official Use Only - Internal Distribution Only]



Although we know that release_firmware has null check, but the code is not =
maintained by ourselves, so I think it=92s much more safe to add null  chec=
k before invoke release_firmware.





Brs

Wenhui

From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>
Sent: Thursday, June 18, 2020 4:25 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0



[AMD Official Use Only - Internal Distribution Only]







________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Wenhui Sheng <Wenhui.Sheng@amd.com<ma=
ilto:Wenhui.Sheng@amd.com>>
Sent: Thursday, June 18, 2020 3:53 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0



sdma v5_0 fw isn't released when module exit

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 58d2a80af450..6751ad69ed90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1299,8 +1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         int i;

-       for (i =3D 0; i < adev->sdma.num_instances; i++)
+       for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               if (adev->sdma.instance[i].fw !=3D NULL)
+                       release_firmware(adev->sdma.instance[i].fw);

[kevin]:

the kernel api "release_firmware()" will check argument (is NULL pointer).

i think the patch don't need to double check it.

+
                 amdgpu_ring_fini(&adev->sdma.instance[i].ring);
+       }

         return 0;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637280636699912801&amp;sdata=3DHrKVAmRO0HKFZBRG6oWq3thNl=
GBd0T9bMramDU1ijys%3D&amp;reserved=3D0

--_000_MN2PR12MB302257CEE4B130B29B87D699A29B0MN2PR12MB3022namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
before this patch, the driver has same code logic at &quot;drivers/gpu/drm/=
amd/amdgpu/sdma_v3_0.c&quot;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
related patch:&nbsp;drm/amdgpu: fix sdma3 ucode mem leak<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span></span><span>commit 14d83e78c578a6c45163fb399ee760fe0d314bad<br>
</span>
<div>Author: Monk Liu &lt;Monk.Liu@amd.com&gt;<br>
</div>
<div>Date: &nbsp; Mon May 30 15:15:32 2016 &#43;0800<br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; drm/amdgpu: fix sdma3 ucode mem leak<br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; Signed-off-by: Monk Liu &lt;Monk.Liu@amd.com&gt;<br>
</div>
<div>&nbsp; &nbsp; Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.=
com&gt;<br>
</div>
<div>&nbsp; &nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.co=
m&gt;<br>
</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v3_0.c<br>
</div>
<div>index 33605d4ac2d9..532ea88da66a 100644<br>
</div>
<div>--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
</div>
<div>&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
</div>
<div>@@ -236,6 &#43;236,15 @@ static void sdma_v3_0_init_golden_registers(s=
truct amdgpu_device *adev)<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; }<br>
</div>
<div>&nbsp;}<br>
</div>
<div><br>
</div>
<div>&#43;static void sdma_v3_0_free_microcode(struct amdgpu_device *adev)<=
br>
</div>
<div>&#43;{<br>
</div>
<div>&#43; &nbsp; &nbsp; &nbsp; int i;<br>
</div>
<div>&#43; &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.num_inst=
ances; i&#43;&#43;) {<br>
</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; release_firmwar=
e(adev-&gt;sdma.instance[i].fw);<br>
</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; adev-&gt;sdma.i=
nstance[i].fw =3D NULL;<br>
</div>
<div>&#43; &nbsp; &nbsp; &nbsp; }<br>
</div>
<div>&#43;}<br>
</div>
<div>&#43;<br>
</div>
<div>&nbsp;/**<br>
</div>
<div>&nbsp; * sdma_v3_0_init_microcode - load ucode images from disk<br>
</div>
<div>&nbsp; *<br>
</div>
<div>@@ -1256,6 &#43;1265,7 @@ static int sdma_v3_0_sw_fini(void *handle)<b=
r>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.num_ins=
tances; i&#43;&#43;)<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_ring_fi=
ni(&amp;adev-&gt;sdma.instance[i].ring);<br>
</div>
<div><br>
</div>
<div>&#43; &nbsp; &nbsp; &nbsp; sdma_v3_0_free_microcode(adev);<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
</div>
<div>&nbsp;}<br>
</div>
<div><br>
</div>
<span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>Best Regards,</div>
<div>Kevin</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Sheng, Wenhui &lt;Wen=
hui.Sheng@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 5:21 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</f=
ont>
<div>&nbsp;</div>
</div>
<div lang=3D"EN-US">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_msipheadera92e061b" style=3D"margin-right: 0in; margin-left: =
0in; font-size: 11pt; font-family: Calibri, sans-serif;margin:0in; margin-b=
ottom:.0001pt">
<span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; =
color:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
Hmmmm=85. </p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<ol start=3D"1" type=3D"1" style=3D"margin-bottom: 0in;margin-top:0in">
<li class=3D"x_MsoListParagraph" style=3D"margin: 0in 0in 0.0001pt 0.5in; f=
ont-size: 11pt; font-family: Calibri, sans-serif;margin-left:0in; mso-list:=
l0 level1 lfo3">
There are some places in amdgpu driver using release_firmware like this way=
</li><li class=3D"x_MsoListParagraph" style=3D"margin: 0in 0in 0.0001pt 0.5=
in; font-size: 11pt; font-family: Calibri, sans-serif;margin-left:0in; mso-=
list:l0 level1 lfo3">
This case is a little different, we use it in loop and maybe not all sdma i=
nstances=92 fw is initialized, just like we did in v5_2</li></ol>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
Brs</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
Wenhui</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
<b>Sent:</b> Thursday, June 18, 2020 4:48 PM<br>
<b>To:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</p=
>
</div>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#0078D7">[AMD Official Use Only - Internal=
 Distribution Only]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">afte the API <b><i>firmware_r=
ealease </i>
</b>created, the api logic never changed. (the first commit by Linus)</span=
></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">and you can use below command=
 to reference the api usage case in our drm driver.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<i><span style=3D"font-size:12.0pt; color:black">$ grep -nR &quot;release_f=
irmware&quot; -A 5 -B 5 drivers/gpu/drm/ | vim -</span></i><span style=3D"f=
ont-size:12.0pt; color:black"></span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Best Regards,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Kevin</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin: 0in 0in 0.0001=
pt; font-size: 11pt; font-family: Calibri, sans-serif;text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 Sheng, Wenhui &lt;</span><a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui.Sh=
eng@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 4:31 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;</span><a href=3D"mailto:Kevin1.Wang@amd.c=
om">Kevin1.Wang@amd.com</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><span style=3D=
"color:black">&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</s=
pan> </p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#0078D7">[AMD Official Use Only - Internal=
 Distribution Only]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div>
<p class=3D"x_xmsipheadera92e061b" style=3D"margin: 0in 0in 0.0001pt; font-=
size: 11pt; font-family: Calibri, sans-serif;">
<span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; =
color:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><=
/p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
Although we know that release_firmware has null check, but the code is not =
maintained by ourselves, so I think it=92s much more safe to add null &nbsp=
;check before invoke release_firmware.</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
Brs</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
Wenhui</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
<b>From:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.com">K=
evin1.Wang@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, June 18, 2020 4:25 PM<br>
<b>To:</b> Sheng, Wenhui &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui=
.Sheng@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</p=
>
</div>
</div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#0078D7">[AMD Official Use Only - Internal=
 Distribution Only]</span></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin: 0in 0in 0.0001=
pt; font-size: 11pt; font-family: Calibri, sans-serif;text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org=
">amd-gfx-bounces@lists.freedesktop.org</a><span style=3D"color:black">&gt;=
 on behalf of Wenhui Sheng &lt;</span><a href=3D"mailto:Wenhui.Sheng@amd.co=
m">Wenhui.Sheng@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 3:53 PM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D=
"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><sp=
an style=3D"color:black">&gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;</span><a href=3D"mailto:Wenhui.Sheng@amd.com"=
>Wenhui.Sheng@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</span>=
 </p>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
sdma v5_0 fw isn't released when module exit<br>
<br>
Signed-off-by: Wenhui Sheng &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wen=
hui.Sheng@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 &#43;&#43;&#43;&#43;&#43;-=
<br>
&nbsp;1 file changed, 5 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 58d2a80af450..6751ad69ed90 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -1299,8 &#43;1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i&#43;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdm=
a.num_instances; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;sdma.instance[i].fw !=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firm=
ware(adev-&gt;sdma.instance[i].fw);</p>
</div>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">[kevin]:</span></p>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">the kernel api &quot;release_=
firmware()&quot; will check argument (is NULL pointer).</span></p>
</div>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">i think the patch don't need =
to double check it.</span></p>
</div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11p=
t; font-family: Calibri, sans-serif;">
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;sdma.instance[i].ring)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637280636699912801&amp;amp;sdata=3DHrKVAm=
RO0HKFZBRG6oWq3thNlGBd0T9bMramDU1ijys%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40am=
d.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637280636699912801&amp;amp;sdata=3DHrKVAmRO0HKFZBRG6oWq3thNlGBd0=
T9bMramDU1ijys%3D&amp;amp;reserved=3D0</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB302257CEE4B130B29B87D699A29B0MN2PR12MB3022namp_--

--===============0637997572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0637997572==--
