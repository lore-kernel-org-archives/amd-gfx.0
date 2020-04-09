Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36B0C2D0EA
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 08:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C105E20757
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 08:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UcciTrcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C105E20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7DC6E027;
	Thu,  9 Apr 2020 08:22:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B6996E027
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 08:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg34HyS4qrnjZFTOu4nUjuHITOdW5b1QVJScFWod0sS8VIdVSRuBP2B1RS7MrNuP3szVNj5JVjzBoiGx4uZPhqZY77ZQnFB7nkyLeW4LEob1obIaYS1jczMbKU5grdhhxlSXOs0AMd5Y//VoiQe2+P1emygZiGej5VEhoBSFwHDmEvSH+Pq4AH7M39G8Un31N9CUkPBI3elY8cXOiABZUTjP/252k9ZqD8xLnd3BSF29nFl7P4qKGR9AeXMh/IgHGOjjlhBBndxZGiYfMGRR8HaqH1j6aq8gv6YqU7JrUg5GOowMTMxye1FDQvrdnqLK5X0iL/kfy9Wc/+J7Sh38MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRQZ2OYnuXkZR1it0hiHygb4hS2OdVC6yvFDl145Q6w=;
 b=RWWed3E/uaKTxWLv1/Q6JHBFAbIZ7G5HzzM0dKpLcTc6AxFrdoJsychIqxtCjVxJcxqGjkhJMwp5CKKdBFswTan3omx/o5RLMUMA79S3hwdssY9qlZC6uJ5OH064bXucgr1X4KAO/GOk/XExwXC4mQ6yd4Od+9CaAyvbEw2UlwaGmdPEhxVqAgkcez2181SgVG4gvHrzhxBSRWOYixvRoT8QiLlvU/JViCOo/aFu3tFLiZ3aDWY9rSlFHUQX2/tT/pN+81t2xLXO6CtyVkwjHQ4LdWvJQqKSIbwmPlx9fnbTSRW8+bijBWj1TYs94WeAB9CDEgGXc+OdI6ehrDdXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRQZ2OYnuXkZR1it0hiHygb4hS2OdVC6yvFDl145Q6w=;
 b=UcciTrcKWs7h+ssVybi+sd+vpv6Lw54wNt07FeR5P8H3HkjsIiQEDYaTst1J/5gHFFSHaYJH7zDQI6KWh2KTgF+s7NV2HkA3ZxJwJ635lhgAsh18aZNxgw5z8TG+skPb/4Fhj2bPEP3K2xefW+RmS+Rzz55//LbP+WJvHHPz+nM=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 08:22:15 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901%11]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 08:22:15 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: increased atom cmd timeout
Thread-Topic: [PATCH] drm/amdgpu: increased atom cmd timeout
Thread-Index: AdYOQUS7RlEBuEB3RsWb6izfGut1iwAAC3IAAAGZAtA=
Date: Thu, 9 Apr 2020 08:22:15 +0000
Message-ID: <CY4PR12MB1287282AE63C1C7F947DB950F1C10@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <MN2PR12MB403254AA3427896F5E99F3DBFBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
 <MN2PR12MB40321A470DEC718A2B8571A9FBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB40321A470DEC718A2B8571A9FBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-09T07:34:43Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=22851874-540e-4d28-9204-0000dd2bf020;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-09T08:22:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fa8ab57f-a3c1-4c4d-b5cc-0000c536d6f3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 272231d3-18cb-4f13-6133-08d7dc5f1cc4
x-ms-traffictypediagnostic: CY4PR12MB1623:|CY4PR12MB1623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1623374D4F6CF1595B3BADD6F1C10@CY4PR12MB1623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(8676002)(316002)(6506007)(8936002)(81156014)(478600001)(6636002)(110136005)(9686003)(81166007)(55016002)(7696005)(2906002)(86362001)(66446008)(33656002)(64756008)(66476007)(66946007)(26005)(53546011)(71200400001)(186003)(66556008)(4744005)(52536014)(76116006)(5660300002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBSaO0ZRhfneysluQ9JO5Rn9d/aodAFnvYFMyLX70sHCdAElPGrW+4sokg0GaYxh1BZxBqYzrNN7qoHuURis1Mh59e8BHJ7NXiiTBRAzzu6lVhK0WyXjzGH0WVP53X4GiN0FJM84ZC4ae+Zerzqg8k4zeZkBPXgAqWFSuiLWM8K0ogk3aGgpflaWu4zKUQsDrinD7Ya7a4XFTmsUc9feiJNckL1JNNjhcbi83DKWqtsU/zhOTboUlVephh1VClzeJqkfjn74TuuDpgNtTH6jbkHOC/vF5oFbHNELfK9Jnhk3BLRDCspXEP5gQQlb8X3ImB5ZU8wRhW6+y/HCDVowfvCicZbN0x+2Nzs7k+L1JtctLLcde3iG3JLVr5W0ZJ2ljPecLYwb5huHg0hXzeuL3A61RtYqX2e+xHEe0zllbkgPhalBRDvVaKuTDLI/XE1m
x-ms-exchange-antispam-messagedata: NAYODBFvGEVjM77EG3nPR5GHQWbGSN4GgRr2NkzCGhIDyxlZZPjaXSOFfveYyVyfqH0KC6qkQM3BBMaVRYUnhcOGd7heeQF4HDPyZ+1cmTF6zHMzcAqcu8Go7xzkyWX8kjMEvAwVUYzCEbBiaNiDOQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272231d3-18cb-4f13-6133-08d7dc5f1cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 08:22:15.7650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8pXKM8V8drXTaGYlu/4+WrjETL/vUfJwE/F8AOkikxA9sGIqgGoN8OpWPiMsfdvvzMuQqZa8n30N28LKme7rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
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
Content-Type: multipart/mixed; boundary="===============2109067749=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2109067749==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1287282AE63C1C7F947DB950F1C10CY4PR12MB1287namp_"

--_000_CY4PR12MB1287282AE63C1C7F947DB950F1C10CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

if ((jiffies_to_msecs(cjiffies) > ATOM_CMD_TIMEOUT_SEC*1000)) {

A white space around '*' is needed.

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Thursday, April 9, 2020 3:36 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: increased atom cmd timeout


[AMD Official Use Only - Internal Distribution Only]

+attachment

From: Clements, John
Sent: Thursday, April 9, 2020 3:35 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: increased atom cmd timeout


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to increase atom cmd timeout from 10s to 20s

Thank you,
John Clements

--_000_CY4PR12MB1287282AE63C1C7F947DB950F1C10CY4PR12MB1287namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">if ((jiffies_to_msecs(cjiffies) &gt; ATOM_CMD_TIMEOU=
T_SEC*1000)) {<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">A white space around &#8216;*&#8217; is needed.<o:p>=
</o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Thursday, April 9, 2020 3:36 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: increased atom cmd timeout<o:p></o:=
p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;attachment<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John <br>
<b>Sent:</b> Thursday, April 9, 2020 3:35 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: increased atom cmd timeout<o:p></o:p></=
p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to increase atom cmd timeout from 1=
0s to 20s<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB1287282AE63C1C7F947DB950F1C10CY4PR12MB1287namp_--

--===============2109067749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2109067749==--
