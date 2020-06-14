Return-Path: <SRS0=kIzK=73=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13A0C433E0
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Jun 2020 07:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734062065C
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Jun 2020 07:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CPLEvwSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734062065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15ADD6E15B;
	Sun, 14 Jun 2020 07:38:19 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5C46E15B
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jun 2020 07:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcGWvKE4BqNHr87z/hmhl6EDYHWFEsB1VzsozWgWJLjs/35A+54aQ2byGEJqS4u7+CDDW8JHLBk5echpttAq+O15Qm/+a1spdOZFoK9ajCy1Xtcmmc1ya8Vgwtvf/e9tpgroY0zTeV+jJ41F9gcBN6GJ8o0ciXHQjScSg8jodI/DnQXvNEX3rQ2T1tcfSRTfohDksnDzfv5KBzfLhHkCgWUvx6e4OdeDPE1/IKi030eEkt0Wp4ZlNibXKCdl5xP6mXPWcaIBAjoaapLaTR/xRZKzL+FMz0NjebZ6O2YcbcqsJJyE0K/hJs+oD22zv8XDZlqZIC4VlkVvM+H+4ZwZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkYUyvBgFa1CdWYCKP/afVRb7VSmGGLG2ALq3QHV7WQ=;
 b=iCAKg3ah12TSBCHZ37R73qwuKQHX9NnynBgN7L/0KZ/cuVrlcEaRRLqoH/yk69IgttjfHgKZqn0e2EfmeIIXzJ6BnT80MIA+d07a8Q10ImUVt38/LD7mrHNW2pvwz2D9IwBXWI7Q4Z3tuMkqPBoPduOWZNwvQJIn2Ap8Wztu4DeyVUjSlw026MxOd7rvmBvP9umIBf7ONOcvnBlEAdW6HPYcxlEJSH00u5o+vLQ72pPsKDOJavWMSXvaoulfF88Cbw0P9e8Y/kupzmwMjqJeCR0XA3zgqK/CQ5J4xcMrpH12mD769sKiKm8OY521iQzKxkXzrFR8BxcaGKgNYvwBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkYUyvBgFa1CdWYCKP/afVRb7VSmGGLG2ALq3QHV7WQ=;
 b=CPLEvwSN4WY9ret4x+z5PeHpgzaK5UJ38zdE3RZgQg9O/EkX8nXMqwwTjeSOQ5GVCff4bx6BDe1+PBE/MFdP8umij84Q5wPC4JvLTq2I0XaVM/l5G1f0GIbGlhMAkfUmuNCJBcOVkscWgnHyiB1GmZaOmo5rFqb9XPIcdyXZEOA=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sun, 14 Jun
 2020 07:38:13 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3088.027; Sun, 14 Jun 2020
 07:38:13 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove perf level dpm in one-VF
Thread-Topic: [PATCH] drm/amdgpu: remove perf level dpm in one-VF
Thread-Index: AQHWQJwoBpc2jSlp+U25uhx9cG6UQ6jU0T+AgAFtKoA=
Date: Sun, 14 Jun 2020 07:38:13 +0000
Message-ID: <CH2PR12MB4101C57C190490F0A10D1E8F8C9F0@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200612093034.19799-1-Wenhui.Sheng@amd.com>
 <MN2PR12MB3022A7FD07D068626D3EE2C5A2810@MN2PR12MB3022.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3022A7FD07D068626D3EE2C5A2810@MN2PR12MB3022.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-12T11:04:26.504Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-14T07:37:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8e6cc5c2-f4d9-4c95-add3-00009115e255
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.135.83.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e085e2cb-df07-4fec-2f87-08d81035e52f
x-ms-traffictypediagnostic: CH2PR12MB4200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB42000AE1B3EA1EA8502FE6428C9F0@CH2PR12MB4200.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04347F8039
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWipBqfUePrjYNcKCKB+KvH7r8kPDvutMDgCexDFCP1irqgNcTtVJgRMiStIoL6UhCJ1cVhIKM+yexpErdaSRF0pPZ5uyEfFW3m4TjLil4ecNem1TBzLA5NzUpb8Kyuww1m1EbupoIYl5Lms2wImNRnUaVRe60Er2toRmmrNucHYYkt7fz1Aie1GrCrtHkwHRj8ITrTO3ozyWVm/K1zZmgK9hMa1vcw/KrOPERDtXbM0vuhQfM5gyG4IrhaUSogpwlyPq6U8zlbW9K7sl7Z2yPUGyC1mDooBPe7tZlQ6ttthNSJ79yw0h6eVikl9tnPHbLTRWfnGNJh1dBcSlpusZtfPcih6yQ8RDNcEW8KU6d8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(45080400002)(478600001)(33656002)(110136005)(166002)(8936002)(8676002)(7696005)(71200400001)(9686003)(316002)(55016002)(186003)(2906002)(76116006)(966005)(52536014)(83380400001)(66946007)(53546011)(6506007)(26005)(66476007)(64756008)(66556008)(66446008)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vf8V1O8nKL1EJSuUctctroe3L+faXHP+N6CXLtpiVznphIfApL/bSXxhCtQ2CYTMyxLDQESGOGv7UwgWzdzC7K0eslHfRx2BACWNuq1tq5FvCAfYzPnyxzOoSqf+GOOzGWMxrauHOuQBdUNp86yoK+45c5AEEDF6iDD3V3Ib+c6SIOdGLdhiOVP1wgfKn++7Q/VWkvCgaEljArnCV3g7k0/O0lFFpEy0wTJVo4kDfBpoLsRx2NLn5sudm2XNyncdLPPXKdnjKU51u+36EvfAx1bSoK/cISc59XASDGpsIoFEf3Ssz4f3PGDttz61i+Zwx2ljBkK+MZaJor4dQaWb71s17TPCynxJRenfMNVADubylUnEa6vg/r0rFczXsvCrluqJ1P0ijvvKHf9qyvWOvf8kzcbcO2E8IJhOK7W4vvG3ubhw1owfaIKfnm7U7S+Nky9rhuGyWqd6Z+7NK7oicyGmqf/JESPP5mB0aBY/m0FlnAbViwf3D5fkEjecGDzy
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e085e2cb-df07-4fec-2f87-08d81035e52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2020 07:38:13.5653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KC2PJvc2pgLA7NaiIjonq9kRYWs9X6/HTHBSpJebl0OrcBCGnC0rTV3IsaJfSotuBOORDDxwMb3Hyhnm5UYcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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
Content-Type: multipart/mixed; boundary="===============2009627245=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2009627245==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB4101C57C190490F0A10D1E8F8C9F0CH2PR12MB4101namp_"

--_000_CH2PR12MB4101C57C190490F0A10D1E8F8C9F0CH2PR12MB4101namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

Hi Kevin,

At least 3  SMU messages not supported in one-VF mode , which could break t=
he node power_dpm_force_performance_level functionality

SMU_MSG_SetSoftMaxByFreq
SMU_MSG_SetSoftMinByFreq
SMU_MSG_TransferTableDram2Smu

Brs
Wenhui
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Friday, June 12, 2020 7:04 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: remove perf level dpm in one-VF


[AMD Official Use Only - Internal Distribution Only]

which smu message will break this node work on navi12 asic?

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Wenhui Sheng <Wenhui.Sheng@amd.com<ma=
ilto:Wenhui.Sheng@amd.com>>
Sent: Friday, June 12, 2020 5:30 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>
Subject: [PATCH] drm/amdgpu: remove perf level dpm in one-VF

On Navi12 platform, node power_dpm_force_performance_level
doesn't work correctly in one-VF mode.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 395ddbe2461c..4e7b579afe0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1877,7 +1877,7 @@ static ssize_t amdgpu_set_thermal_throttling_logging(=
struct device *dev,

 static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
         AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           AT=
TR_FLAG_BASIC),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637275511045991505&amp;sdata=3D1uvfK9R%2FMAFkZrgPk5aEnVM=
Qs9zYOJQUFdLWwLzMbs4%3D&amp;reserved=3D0

--_000_CH2PR12MB4101C57C190490F0A10D1E8F8C9F0CH2PR12MB4101namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Kevin,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">At least 3 &nbsp;SMU messages not supported in one-V=
F mode , which could break the node power_dpm_force_performance_level funct=
ionality
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">SMU_MSG_SetSoftMaxByFreq<br>
SMU_MSG_SetSoftMinByFreq<o:p></o:p></p>
<p class=3D"MsoNormal">SMU_MSG_TransferTableDram2Smu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Brs<o:p></o:p></p>
<p class=3D"MsoNormal">Wenhui<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Friday, June 12, 2020 7:04 PM<br>
<b>To:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: remove perf level dpm in one-VF<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">which s=
mu message will break this node work on navi12 asic?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Kevin<o=
:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Wenhui Sheng &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui.Sheng@amd=
.com</a>&gt;<br>
<b>Sent:</b> Friday, June 12, 2020 5:30 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui=
.Sheng@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: remove perf level dpm in one-VF</span> =
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On Navi12 platform, node power_dpm_force_performance=
_level<br>
doesn't work correctly in one-VF mode.<br>
<br>
Signed-off-by: Wenhui Sheng &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wen=
hui.Sheng@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 395ddbe2461c..4e7b579afe0b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1877,7 &#43;1877,7 @@ static ssize_t amdgpu_set_thermal_throttling_logg=
ing(struct device *dev,<br>
&nbsp;<br>
&nbsp;static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(powe=
r_dpm_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_force=
_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BAS=
IC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_f=
orce_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG=
_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_n=
um_states,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_c=
ur_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_f=
orce_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637275511045991505&amp;amp;sdata=3D1uvfK9=
R%2FMAFkZrgPk5aEnVMQs9zYOJQUFdLWwLzMbs4%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637275511045991505&amp;amp;sdata=3D1uvfK9R%2FMAFkZrgPk5aEnVMQs=
9zYOJQUFdLWwLzMbs4%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB4101C57C190490F0A10D1E8F8C9F0CH2PR12MB4101namp_--

--===============2009627245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2009627245==--
