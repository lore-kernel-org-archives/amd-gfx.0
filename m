Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA0FC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 07:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEDD20409
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 07:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m5Xyjy0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEDD20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCD06E111;
	Wed, 25 Mar 2020 07:01:06 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680064.outbound.protection.outlook.com [40.107.68.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FA86E111
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 07:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFQw3bbKA4D5t5fl2SmQLmLap17MfT8xGddWZEFZkUFn9Hiz/1N5twE/aVxn5GCp2f4vfGD19tIHGxwKTFnpcamrPV752tpzL2IkzPVcLeUjuK9bfRC7HW07krQ91NMCtIZyfqnoBOfVS5n5wxtAN62scnDw5z3mYeEJqo1WoEfUXhcTUd44Mg6/MgauN1RMLSiOZiAW1nMhGCtCmaZzstcblynIr80gAj7K3RYQz8QEdyIwr807Va6m82kAvCO0HAEoT3L6aXmZJLlAsb/n3NRXMb+GdHGbChG2FSbCLCMqCW6ZLiL6MFVpw82YfpiTUvlcP13WI++sc/7XAJf60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=131hBsOobhgukyUN5XbXbDzehqgcXHhmQ9OKtoPnRdg=;
 b=Sj8to6iA/7aQRTg0PraExPNOzQHNGk0wPgR5h9ji+SZ0nm9MROE56XxgucFKhapbzQX8VlwQYWPxEYvVkwn1EJUAFz1rEii/vKabvdB9BN0sDRW0D8FDITrLOihvOpJrA/plZJjDiRn7UZGbuy21zDX9bqRSCZ8KzFaIYGWQdR4PAUhcbLwR30I6RHOJgP/qWEh7ugr4wORavblYElUMINR5mCTkL4cfi48lm9Sl+5SRcxlbl9RFGbQrUOM3cBk0+rVO56s35P4+QqM6krhnuoNalFAZ3BujjiONxn+QNOSRTsMsVx4GM3dupd9GcWYs43XrzPShJWyNfeJUhrVWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=131hBsOobhgukyUN5XbXbDzehqgcXHhmQ9OKtoPnRdg=;
 b=m5Xyjy0QZ5o0ca71b3NhF1Ih/TisGDbJ9kzusafXaYD7GjnK8iOalol6ike1Jd995+P/Nan1aIgH+b4Nc3hTtFAwE7xRB1OjPoyLUOThEHfhpFeggnJWM29Y2Ay2a6qc+i5T6LPmgahkYu1utYU/jUbYhJ27+bOSLbIsXCEANeI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15; Wed, 25 Mar 2020 07:01:01 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 07:01:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable ras query and injection during gpu
 reset
Thread-Topic: [PATCH] drm/amdgpu: disable ras query and injection during gpu
 reset
Thread-Index: AdYCca+yLm66Szs8TCqzfYFWysHyiQAAWklg
Date: Wed, 25 Mar 2020 07:01:01 +0000
Message-ID: <DM6PR12MB40752544CAA5F185CAA53192FCCE0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB366349FEEF93758FA0BB32F6FBCE0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB366349FEEF93758FA0BB32F6FBCE0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T06:51:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f1142338-ed98-4387-bbaf-0000a88a82b9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-25T07:00:58Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e3328680-026f-4949-a5d4-000053aeb5e4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd2ecd7a-dda0-459a-6d26-08d7d08a475a
x-ms-traffictypediagnostic: DM6PR12MB2988:|DM6PR12MB2988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2988521222B859EF076D165DFCCE0@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(4744005)(2906002)(5660300002)(8676002)(478600001)(76116006)(9686003)(81166006)(81156014)(66446008)(66556008)(8936002)(52536014)(26005)(33656002)(186003)(66946007)(66476007)(6506007)(86362001)(53546011)(64756008)(55016002)(71200400001)(110136005)(316002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2988;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPZiJ3+Xtid/uZNpKiCo7V6YHflN73azakWqUGiXuGDiYzexxYFKv8Y2cG2lnkf/4rAhimG6jWPvGHMGn6ehExUsrzB/Psaeqzwl8z0n3+AibM2YGdl0cuFBNQ6V4dCkCku2xocmGhaE/+IOMOqmqOk7DCFmbnFa9pgJmnriZ/LrhyxH+LnIXpwDUBzQ0HTHmYOC4VA+klvryXm+L2juWakLWuFNtks88tJ9aFRRIcitFCsf+qB1+tVeMPEDhKlKtPedNAYG5553ZLZilHNNXhgghTW0Abbu0V3lP+WM+aUX1bFn+B94WeUVxdhMNfDK76qbgmuYQQ05x76zAIJcU6ZwYd9iPfUYNAKKWYNz15n6fkclDQ3Vw8ETQ748Fb4TiUPRgawpNdTuFB1kOEgMfA/4AnhKRays6bEqAFNnrG/1A/0VxvF0UeWBJ6+FTmrO
x-ms-exchange-antispam-messagedata: upxN6eQhz9sMzgo4X18TpzZLh84GC+NjBswSfaRH3SSXoMVaOgkUckDXzh8enMBzJdqGu9oK775ugZbE+pVkgxt/OxuHx/Fr7IoyzucK13z7JorHD23Pw9ay4rdQCDcYsP3o1lwyArS2LOrS+4cxqg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2ecd7a-dda0-459a-6d26-08d7d08a475a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 07:01:01.6222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYPgiCLgOrD3IhSJUdrvplnokGALAKr5Lc4m7BWFrIWAV3QiOsz0StQ8mXSzz0EW6SWEajJ/5gWUiDnTSvuFIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Content-Type: multipart/mixed; boundary="===============0402804294=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0402804294==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40752544CAA5F185CAA53192FCCE0DM6PR12MB4075namp_"

--_000_DM6PR12MB40752544CAA5F185CAA53192FCCE0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, March 25, 2020 14:51
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disable ras query and injection during gpu res=
et


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to disable ras debugfs features during the entire GPU rese=
t cycle

--_000_DM6PR12MB40752544CAA5F185CAA53192FCCE0DM6PR12MB4075namp_
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
<style><!--
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
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Wednesday, March 25, 2020 14:51<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable ras query and injection during =
gpu reset<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to disable ras debugfs features dur=
ing the entire GPU reset cycle<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40752544CAA5F185CAA53192FCCE0DM6PR12MB4075namp_--

--===============0402804294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0402804294==--
