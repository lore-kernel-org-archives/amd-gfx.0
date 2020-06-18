Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA35AC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 08:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE8520EDD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F7I0CR9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE8520EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A226EB21;
	Thu, 18 Jun 2020 08:47:59 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690086.outbound.protection.outlook.com [40.107.69.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5806EB21
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 08:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDO5oGgruFwO+lMJSWsJSMhEkAyPJkwRQKz4laZGYAtVXrEIJvw1v8YmVq9U5HJl4y3LuoohI1AIOvrj30ePgfclRRtN1pgSX+WeXQVXgGYRRIrJCnXYSZnEtnbgUgzldTI3Kdb9XjS0/gX04CLnA/lTMNkM//951OsTbq8cNXTje0LdBcyFxnh039SP+egaA6OaJdQCQsC8HW8QsHNKDBdpD2SnBRjuZDLVy89CdwoRyVY/NjsmS/+UCUlS7drl77iuDPODnQPlha/LFHbuQ7P2U2CnXBuLv6bOjnYu8TmEQEZW1hOTaTAtpKa8Hy2VTiJodE2SrXet555oa0ycdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6Rb1Oc/ivfLLpwbk+g1U7aat1yY/EKEWif7/7YuoXE=;
 b=JaZQl4yFbwZNWBx6orDr6LQ3Jw3J3ETZolaStjRcRcp+qRXUCj/lvS0g/GApIycajXYzdOMy/ed9JXWUEMjigEQ540mGIj1zawrAO/nFcFq49Q5rZjmhh7gWjyMo8o/7w4ncmBr17R76mqn49xbukd8HpgdOHOQnmSeZdeOEkykP6Buuf2V+UkVMYdl5czMRo3SW5Ht12q/D3pDVnirIGPILuFk/0ytCRHvb8y9Zwtbp8yadyIxw2wIUzBro4Gn5TD9bzV9XmIMH+Mg4xukwk7se2pRdY472RSXl6g7PATtE20x5P0Fz/GUyVvwX84hpeBJrdeg9oJu3i+nOplOZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6Rb1Oc/ivfLLpwbk+g1U7aat1yY/EKEWif7/7YuoXE=;
 b=F7I0CR9+6CoPrtRTqzicdNarKt5/kePyhY8JnvNW3aizUDyyDuijNjnTxH7kPRMak7W/qN+wGQPuOi+QokwQBK6dZyWZzxq+GCbn+Sbl+VQQQnHxfwYYI+MtXBKsLnah8SfcTWmGWehuRKT5FDnQpw3M5eGuSVsx2f4jioS4yWQ=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3614.namprd12.prod.outlook.com (2603:10b6:208:c6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 08:47:56 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 08:47:56 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Index: AQHWRUWyyxt0twhDmECVwlQ36PPmrajeCMCJgAACjYCAAALTdw==
Date: Thu, 18 Jun 2020 08:47:56 +0000
Message-ID: <MN2PR12MB30220020DF792ED8CF72490EA29B0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200618075307.3721-1-Wenhui.Sheng@amd.com>,
 <20200618075307.3721-2-Wenhui.Sheng@amd.com>
 <MN2PR12MB3022D32C41B32F413AEFF151A29B0@MN2PR12MB3022.namprd12.prod.outlook.com>,
 <CH2PR12MB4101B7B650649CADE1501E6A8C9B0@CH2PR12MB4101.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4101B7B650649CADE1501E6A8C9B0@CH2PR12MB4101.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T08:47:55.768Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.142.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49431675-db2a-4f8e-d78d-08d813644bdc
x-ms-traffictypediagnostic: MN2PR12MB3614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36140DB5C7163B114959E5AFA29B0@MN2PR12MB3614.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFRL2rm/syWsVqC3Nw1f13Ifwk/96zfbW1mrSVX7vyfc+vgXaObdHEISKIPmK4gbShNGvmcrgK0431YN2siwXd/5gLepbJdRFabDXQ8MUqVnrFpkeMkpAAfWg8SSFSlOjM7fBxlxEftdFYWZGH0p5rWOyCEQKvXIV8rZmyO1ATErlKxK6ykvTePBDdWcPJ2jzoEhAHXLFk2Hdfs7+Ya1WbtCYUX84DWh6uKdgYMfj1wicF0fhdyf1wfuzV89+Qli+LGjIiDrJHi7Fs1ZMIHzufYNpKhxBEHDx8HJCe+at60VPx1OyrFGKJJImQcLyTvDNdpb+cdARi4w+S8A5fqM3P020NwQIy0xfWsTrU1ikuQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(52536014)(83380400001)(86362001)(966005)(5660300002)(8676002)(2906002)(166002)(8936002)(19627405001)(71200400001)(6506007)(110136005)(91956017)(45080400002)(33656002)(53546011)(66946007)(76116006)(186003)(7696005)(478600001)(26005)(9686003)(316002)(55016002)(66476007)(66556008)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XApaWjz7I5fbserk02JXk3kVcwI3CGo5acq1RIk4idTnOuQ8IgJT+ZC/fDiImp5hKdfxJfBEBecjRnngdj98vWKopdgs6Uc5fiyZCAHUm8PccmrzqLR0VbV2EAlqaPS3y55Kfb1qTqM4HMG4W0sJ/92gf6QaYmY71kuDS+nL4xY1so3sLXrgTXlQyQoo92nu2O5BygPUUpthetGui2BhoBZ2hgmXa/nlsQYFaXvrK7s3Z2Te69t07fifTt7L41GPb+aatEC5OtzwDYN8qnl1ybCbR1vdiQUa76SRaQ+ZSj+3mkYIwOBSfa4XmqT+MLSBH0Q8bgzU+nevhphEg1YgxUzrqE7JMbyipKRjk7Z957WPoxOc20WXU97r3c/m175vtZczXjnYCTJC+VH8oDrFssfcUO/F8ofA3MSEiMhYSh6GSuq82wD+b/d91PM82lU/PtPj+vgHwS/NLYJE9ms/yAjSrUlfvDtXQlQ1qOjOclA=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49431675-db2a-4f8e-d78d-08d813644bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 08:47:56.2087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GXLkeHkDpjFwF+fO+4Vn719SQVWGr/1L9PZy9YIRucEn0JTCjz2Hx5nVE6R3oKT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3614
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
Content-Type: multipart/mixed; boundary="===============0093122680=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0093122680==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30220020DF792ED8CF72490EA29B0MN2PR12MB3022namp_"

--_000_MN2PR12MB30220020DF792ED8CF72490EA29B0MN2PR12MB3022namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

afte the API firmware_realease created, the api logic never changed. (the f=
irst commit by Linus)
and you can use below command to reference the api usage case in our drm dr=
iver.

$ grep -nR "release_firmware" -A 5 -B 5 drivers/gpu/drm/ | vim -

Best Regards,
Kevin
________________________________
From: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Sent: Thursday, June 18, 2020 4:31 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]



Although we know that release_firmware has null check, but the code is not =
maintained by ourselves, so I think it=92s much more safe to add null  chec=
k before invoke release_firmware.





Brs

Wenhui

From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Thursday, June 18, 2020 4:25 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
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

--_000_MN2PR12MB30220020DF792ED8CF72490EA29B0MN2PR12MB3022namp_
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
afte the API <b><i>firmware_realease </i></b>created, the api logic never c=
hanged. (the first commit by Linus)</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
and you can use below command to reference the api usage case in our drm dr=
iver.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i style=3D"font-size: 12pt; font-variant-ligatures: inherit; font-variant-=
caps: inherit; font-weight: inherit;"><br>
</i></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i style=3D"font-size: 12pt; font-variant-ligatures: inherit; font-variant-=
caps: inherit; font-weight: inherit;">$ grep -nR &quot;release_firmware&quo=
t; -A 5 -B 5 drivers/gpu/drm/ | vim -</i><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Sheng, Wenhui &lt;Wen=
hui.Sheng@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 4:31 PM<br>
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
Although we know that release_firmware has null check, but the code is not =
maintained by ourselves, so I think it=92s much more safe to add null &nbsp=
;check before invoke release_firmware.</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
Brs</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
Wenhui</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
<b>Sent:</b> Thursday, June 18, 2020 4:25 PM<br>
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
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin: 0in 0in 0.0001=
pt; font-size: 11pt; font-family: Calibri, sans-serif;text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-g=
fx-bounces@lists.freedesktop.org</a>&gt; on behalf of Wenhui Sheng &lt;<a h=
ref=3D"mailto:Wenhui.Sheng@amd.com">Wenhui.Sheng@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 3:53 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui=
.Sheng@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</span>=
 </p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
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
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">[kevin]:</span></p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">the kernel api &quot;release_=
firmware()&quot; will check argument (is NULL pointer).</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">i think the patch don't need =
to double check it.</span></p>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
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
</body>
</html>

--_000_MN2PR12MB30220020DF792ED8CF72490EA29B0MN2PR12MB3022namp_--

--===============0093122680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0093122680==--
