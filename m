Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201A3C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57382073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xeF4dUnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57382073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA0B6E160;
	Thu,  5 Mar 2020 09:43:26 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750058.outbound.protection.outlook.com [40.107.75.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E586E160
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 09:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVhOMuSUbhRRKsNIcesWYKBDGaMe5LkGHjlS6Iqy5xozC9lhFZQOjA5f5hNV/o0PtX3fXtEnKxf/+sveaGUaLHeOMzqdrTtAFk59OWKO4TmEdOyNAKLlVDBQw1jfQ6QW+gUwoxdrqSVoQu3ljWsf9zQgKfcT56oP0QndNiMsP0NpIcJN++Oq6rnplNnBwHiHse84uweXyeI6E0royxV8GzQKZ4wDNVO+HIsHY14jq37pg3AnGnhgCyThlMNRcYD3GGYlXxlGbDACV0lBIXQ+R+y3yMHajPvffMhKMZQAstnczYrEbaCs5OUFz6fw7qWMgTj6Wzxzgmcb8Zk7gm5/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE81BbLTXGrCfNDmro4NQuyGjB0kS9UoBM9SXR8xzKM=;
 b=EuH3GbkNxYw4qOENvhuJu4AbzzMUdhhwPkeXYetP0x2rv5cpzq0Af/MnwVjolpixT1ECEpbNpp+2k/VxXi8Zkuq93AnDDeU3tfTvtHA8lMYyMCIuAKKpnweVcZAZEhVcB1K8ZbBCk2umz90zqfPwOyD1fcmkkiKRCLsuUFaSwXZgZ+C8tSM2YAhTailzcjHWlDxgC03TzAz7Lp+79g1c3FNNE01fPKLJgOpfkhRn+2Vqmqd3g6gEaoTUbfsrTkzQZ/QXrxHd1EKtO26L5XoFtfGK5tFu+fj8xAlmWY7KTnpBWEcnb+XEPGq9S7ub11qqemF9FbF+nL8sBtcrlHc3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE81BbLTXGrCfNDmro4NQuyGjB0kS9UoBM9SXR8xzKM=;
 b=xeF4dUnI+cbCNGNvMxDpp9Z+sOVWokPKIsrQpQJbHhE6K5/JYZGssQNdlkzbwmRf/7RoFEbzEe3lji/tpQ+EamY//7ZW0AU5KkhfjhJ+XsQnUeZl37l27a8hS6fiW8P3DEm0EQKzmlLZKm56W+cyQ5lyU+xhdtGTbfrZe/zyaP4=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Thu, 5 Mar 2020 09:43:23 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 09:43:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: increase atombios cmd timeout
Thread-Topic: [PATCH] drm/amdgpu: increase atombios cmd timeout
Thread-Index: AdXy0dBSZnPbjEp8RUSqBndfIsh2+AAAKMBg
Date: Thu, 5 Mar 2020 09:43:23 +0000
Message-ID: <DM5PR12MB1418F84A376F874E0C134B5CFCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <MN2PR12MB3663B49E183438B1B5070EA4FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663B49E183438B1B5070EA4FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T09:38:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=58e119e6-772a-4273-8acf-00008a1b2e6d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T09:43:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 931ed49b-b8ab-4659-b106-00004b5d9ed3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02528085-b6ef-47e3-ddd8-08d7c0e9a5b1
x-ms-traffictypediagnostic: DM5PR12MB2373:|DM5PR12MB2373:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2373D94F7E2B03292F4F9EB7FCE20@DM5PR12MB2373.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(199004)(189003)(66946007)(66446008)(66476007)(8936002)(26005)(66556008)(33656002)(64756008)(53546011)(7696005)(478600001)(6506007)(5660300002)(76116006)(186003)(81166006)(8676002)(52536014)(81156014)(2906002)(86362001)(71200400001)(9686003)(6636002)(316002)(110136005)(4744005)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2373;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7mXZrCIs6r3QFWZ7JWnBa4qtLrpP+MJjws/Aqj7ADFkLDxN+PfRzaqlfelR8rYc/qKZEW1Pz1AvzzXdM9OcyicMuTpfHnLjlCj+O2STNew4uq9m2sTZVyOubqGdwrZG9Q59i11th7gczGFtT7AEjkHmxThcPQD+PWcKP50g8SXo36WvY0XnVZCA56oCCMORvFaOrgZgnWDsJATVzSep91Tuy59h6CzKssBhrohRy3AQDiSWP7iEZA2P6UCRQamFc/OFYWMZzUKgmB/wgAmXrX+EENmrgvRLYdQ8ykMaw3xLn8ciBWED8dUWIshVzFaoBH6492I4WyTfkH1xuDdmdbDe34f5GAh+/nrf26aogtv5wyRktdCRlhFYD8CCULvmbKrV4MUGRrcVOWYHoZo+jzJwhpUSSSiKGClSxdQ4uQnMWb4HsQ3ovXfGU64sGnNqQ
x-ms-exchange-antispam-messagedata: UPrQ/z0Zao2ETgZbmSEtvilhEzXuFMkxuq8h6st75ICU7et/nQ9bgjS4tXdFk8C+xNomV/aJeg6RCZ+Qf8jYjePVXVHkHITerzKeoykfa15h4MJi4bXiQe3lo+3n1NQQ2ekHHre01x0sBS5uR6vfVQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02528085-b6ef-47e3-ddd8-08d7c0e9a5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 09:43:23.5185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H0CF5OwY78aSYbc+5UCCk6TZeq4fX0Bagp9LEjEQuO+GLgrB97H1XO+k8qyVRGTTCUHTVvGa70djScTyxcd8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Content-Type: multipart/mixed; boundary="===============0559088883=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0559088883==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1418F84A376F874E0C134B5CFCE20DM5PR12MB1418namp_"

--_000_DM5PR12MB1418F84A376F874E0C134B5CFCE20DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, March 5, 2020 17:39
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Guchu=
n <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: increase atombios cmd timeout


[AMD Official Use Only - Internal Distribution Only]

mitigates race condition on BACO reset between GPU bootcode and driver relo=
ad

--_000_DM5PR12MB1418F84A376F874E0C134B5CFCE20DM5PR12MB1418namp_
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
<b>Sent:</b> Thursday, March 5, 2020 17:39<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: increase atombios cmd timeout<o:p></o:p=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">mitigates race condition on BACO reset between GPU b=
ootcode and driver reload<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB1418F84A376F874E0C134B5CFCE20DM5PR12MB1418namp_--

--===============0559088883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0559088883==--
