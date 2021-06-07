Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A3C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 04:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6336121D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 04:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6336121D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9320D6E0FE;
	Mon,  7 Jun 2021 04:09:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FEC6E0FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 04:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPgnDMCkFBqa9KoEZ6/SViLaVf0wXX16p9CVAG4JC0pMpONg+eNpbICXj2JDrkDs5YQpLGtF4WcVeu0RAL2Hj/WJKpnbTeYWyWHZBEpHJ7mWnO9YpMJ31HwYaFqDYsmVv2Dub6QrAtXzjaYjcMYnAVJs6sJBBkEKA6/FQtNDB4nPBkYq9nGm1RUM20fDOCjs/KcwQbmh5aZribHDzlFaHse9Y58JpRIro4R2LBcHO9QbbuQ8n+1EKGxkPws9OaJYrWJ8wKzTesS+6t3gWPCb9AwzPBdSGAOWccF1V6l54eDVuBU/C2Aj5VrnQE4ElW91sjEiLXpvvMQPdGQ4kx1rmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVK46uLHnv1OvjU42k0yMzySV+1dmr7WD1CpmWp9nas=;
 b=ckPvifQy0QU8JNqFAoPk0+Yn/L+qcHs2VsIc3coWqfTAwrNwLPd+SV72svR1Q73UjWEflxTNFeC2dcCuhOd1/WoDeYWrhCI5olx3ggrwmTuLbzeA22KDb6wr+peC1yuSY3tu8Xyyurq9NlRQxZIBsCIxzgxWPrV59kvK3mjnJlvFgQNpLse9hED0sAX0jSt8g8ZHASu+PcQzfsIDzY/LLN45DwbbLgIQ5RUq8pWKKK3U+fMgDgOotKTKeXT7nLAoq8nkWgRctoIoeow1iJVCMcivXUKdvPzeXXovCA2ETU17Nwb2DFBCp2C9U43DU2HSUQRgZHNDc+DToR7ANJSGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVK46uLHnv1OvjU42k0yMzySV+1dmr7WD1CpmWp9nas=;
 b=MSN57BaQtSdrlyhmIr0fEgLsX7nj+VMdHUeUNIjN/A7Tk2BQ8F1aY08s8DLZl1YRvDK4mSZhvcQnzB9cpzWh3KSusYkoTGDngJEn9wBTA1hTlg7Vry2JeruPUuvNyqU+chyUOw4wcam2oOOxjRPs6imWNtYowZB7dpynCtxXwUw=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 04:09:16 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4195.029; Mon, 7 Jun 2021
 04:09:16 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Topic: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Index: AddbStf9BnLmUUpcSRKXKLQG8fAUEgAAWcIg
Date: Mon, 7 Jun 2021 04:09:16 +0000
Message-ID: <MW2PR12MB4684E8A899148EF3095E3A41FD389@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <BN9PR12MB5226F943C24139A71502430FFB389@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5226F943C24139A71502430FFB389@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-06-07T03:12:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=df1aa59b-160f-48b4-9bcf-cc154c83c10d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50327a93-e4a4-4974-c04e-08d9296a047f
x-ms-traffictypediagnostic: MWHPR1201MB0062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0062FEC576C0695098849553FD389@MWHPR1201MB0062.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPOVutG83wv40kk6sSiVi5+yFZcXzkwV7uLvtBF+0NpqWVvAqiZBOUUy1v/ARlX3L3IX9FzWs4XVmAao4eG0C09FJxMBnGhXa+zbwecsPLML+90D6tSYLTYFF+AmYJhq/gojkYyeP3g0qdty+uj10zoUzFgM1bQDIltxVe41M8JmOmpj6CBo6AsyYIgFm1Y2UsxTLiwCrEHpAm3f3qbzVRu+kbfIOSff9P5+vmRkPpE8HrLziYYAKCZWOlD1X+KqF7OkTNC5+PvS1pQclw08yXWmQAP28DTIevyKAC3puBL0uq2JLJF3L6PHLB7S5d8pUQ+D6+v+U1I7I7+iCmzf59/HcftGLFWOet2rIb128OyuXESaMKHwKGIr7CCtqOLYuHWuYxIfdKXfAHru9WogL45wbhswixOut2B7JaWXCjWuIhNZPo9gcoBmYzKZwLWxwePTMRsqCkFZrzp5ur9D66MSKd4eNRzh0U/Zv0xo/3XApvezbpg2iWn9szTf6GDaI8a/m95F9o8DRwY5WbUhrlBh6kyXwQpAQxht4qtNJFNOP4CxBYNo0tXF+y8p2v5il5PxKP/3EDFPDVfWMWGSGmDQBZpAfLTHfwLLh3Oh8dY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(4744005)(33656002)(86362001)(9326002)(316002)(186003)(110136005)(2906002)(478600001)(122000001)(83380400001)(26005)(7696005)(55016002)(71200400001)(76116006)(15650500001)(66446008)(38100700002)(9686003)(66476007)(66556008)(64756008)(5660300002)(8936002)(52536014)(66946007)(8676002)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FXDP2GFKEqNZLVU+xiUjX/xbRpJbF/tzLW1TSdZTOuolDwleivzJ8JbLlm48?=
 =?us-ascii?Q?lxKnRey92x+HeA5qIk2raNiFMamIhoqk08R8TUTWDtKOiKfWXBETUfwB1wB2?=
 =?us-ascii?Q?rjH6aj7wPOpzuWFQyhQe7HwB2FZAxj6eHwcccEtllt8ce5CXzuk9sIVUORqA?=
 =?us-ascii?Q?Cw750ZILx/62HrV430uIdtAiFrUKmQv87Kxtf4UIkc9JcjSKwohySNf0j4Pr?=
 =?us-ascii?Q?+hRFzGKWsFGxBhwL8VSBIP/s02PjOJyg7QKLD2+YRtFKXG/4fZ+F1VGgOcuH?=
 =?us-ascii?Q?/AwLvbQ+dlOcyz9RF94AnQ7J56db2sCqi7SQD71DVVOCvmLfpGDRx2kh5MM7?=
 =?us-ascii?Q?OQ46cVS9Zz0XMMCm76SYnZ1S0D2ZkVFTV6CIGuagxUDb3dGi2RH6iR4Dcjxp?=
 =?us-ascii?Q?a1O3HYnQTCGl9nSb6A+nfjBrs48Zpk4fZNM0WhVNhxjM45xtzAVxkwi+d2qz?=
 =?us-ascii?Q?+UAwzQdexRLkCrJl3aWkXsqEnmf9hmRE6l88uvcDLJGV0dDZhWVWKLg5R67M?=
 =?us-ascii?Q?X4n5tM3ypi5B8XUJdqQBpnxh+h/Jakh6c3RGdb+YmG7FJOETdAUhriiWqFe0?=
 =?us-ascii?Q?lld4wy3CHv7Fgi4qZC0jEFn4kiAJ11IvhZX3XhA5Ptt+JOH+dvSxxlmcu8gp?=
 =?us-ascii?Q?IAtBMNYO53d83vdKnVhDeY/qmQY2BXMSNdvs9yiths8OVpU57x/Y7t+aA54z?=
 =?us-ascii?Q?6qoV+osILiWhY2SnPgCQE7ZNwS0VO5H6PQmFhmh2U++dqbhDXKKoxCJmwubQ?=
 =?us-ascii?Q?u7+ldGWpaeFvx2vDwe2WjZ7HgiPpTeVHbE1ZjJ67Ohkh9XstqA4h1FDSzQy0?=
 =?us-ascii?Q?1RN4gf2/yYLYaouvkZ0toYQWRlWOwV15e4wdEqAAxytL0hzhFzuhPQJNBgbV?=
 =?us-ascii?Q?aOmcW8RdaY6PLPpcQVqFPl5xcJcZbFO34hKInHqzpeijenXGwIeQoHgnzb4g?=
 =?us-ascii?Q?/0GzgCaxqAhrfTu/Mvj0clHqH7sc1ou8i4wOPuCNzLjaRlLZOzLchv+XE1eE?=
 =?us-ascii?Q?xGrnd1ZGMQkNidfVdFC14Zpenk3A2Cy/oBbJUUimnM1y2z7C95TFj8nghlmX?=
 =?us-ascii?Q?dga41PQecJEyUfZgwUu6JjbQ+FKzQyWf2ntZGTCAFaSRCnZNI3pNaP+CoPUx?=
 =?us-ascii?Q?8pDoM4JubEBYStwh6fb0svsVuDUoGeckEiS0YK8KFg2zenw+tNMY61ug+nYD?=
 =?us-ascii?Q?Hpi5wif3Al726pyTJoU0UhMtV6r9qRR5wy3Hy63z8tR8msAok5Jz5XS5R6Pw?=
 =?us-ascii?Q?tubPZj8m+RPeE6JdU7o17LmTH3dbMMx66P+vSOwFpxB8+fgLLCmvzY8NA071?=
 =?us-ascii?Q?MtqvIWYji4pduSnpRRLL6USp?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50327a93-e4a4-4974-c04e-08d9296a047f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 04:09:16.6989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgJzeKkTf3/D6fZgFeq2pcVLmzGrgTV/uyPQAj1Q2xEOITN/FnvrSfYkuXBjv9lE7TvWJ5zL61Pi/T3ffsIHOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
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
Content-Type: multipart/mixed; boundary="===============0852486867=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0852486867==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW2PR12MB4684E8A899148EF3095E3A41FD389MW2PR12MB4684namp_"

--_000_MW2PR12MB4684E8A899148EF3095E3A41FD389MW2PR12MB4684namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi John,

As talked offline, the patch fine with apu at present.

Reviewed-by: Changfeng <Changfeng.Zhu@amd.com>


BR,
Changfeng.

From: Clements, John <John.Clements@amd.com>
Sent: Monday, June 7, 2021 11:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: Update psp fw attestation support list


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to disable PSP FW attestation support on APU

Thank you,
John Clements

--_000_MW2PR12MB4684E8A899148EF3095E3A41FD389MW2PR12MB4684namp_
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
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
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As talked offline, the patch fine with apu at presen=
t.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Changfeng &lt;Changfeng.Zhu@amd.com&gt;=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Changfeng.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Monday, June 7, 2021 11:13 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update psp fw attestation support list<=
o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to disable PSP FW attestation suppo=
rt on APU<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MW2PR12MB4684E8A899148EF3095E3A41FD389MW2PR12MB4684namp_--

--===============0852486867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0852486867==--
