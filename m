Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166B8C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 07:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0B020575
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 07:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lwEHDPKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0B020575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC756E48D;
	Tue, 14 Apr 2020 07:19:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771486E48D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 07:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZThwPbbYOyqvnlowLlCB9y14/NqnY32UvJvTKXHtWr7kaXV2drHPG+PgQmu2MHOJRNvV9vRG4BQRjiwfV3Jd/5mBAVvp4pmRb9wfmlUPQOkBEuqnzjPeYQCSJcVhXsmhCbgYPYyl+dEUNXrCfJNRS9FNCAedzRznx7X5l1H6lcrBwDZXUDreKYDjLTBOTS2Ll9zAgPxtDAy+tb+C9iY7OFpUUJZrBarM5fqYxl0summGpMBcDJg08MjBq53kNNIl5JwRqdsW0ZCYvki4MJD6yl416bxhYRh+POTNNl/7qh1Z5cdF0O1OEUgIjgduCB6M3SxomDzuRAFFSbUHXQEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeFz54S09KFr5BEi7AxlBCKV8952hf2fcX8/5W3QLYw=;
 b=K091rDCQvnNmnD1XkG8wSvdzqEDpJxZEZPUCbU3U5CqwCTbeMeNmTxNvhCfljUY3UGIEXaCfkO+iWOsUSmin3RetfxhuNY0x/4DOzM+K3JcK2epLH439tGR+fBQ6+uLgP7oavfQgXH0gy4MG627rkoOuoT43b09THm0bGdgqDmprfMVACHGFpUqdTmD4AorAnr8LfXW5KGQF57Azg+V3CdXTUelZQcyHXqD8RA4xr/dCziRdWcEwp2WbQsn2JKSGf7MaCxqtQZ/DaZ2QNFRj/04vkVtd1JMBlDPD07EQ3a5ZaaStF99S7Sg1ZjTTjRgr2euSWO6OPv3Xh5obXXRUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeFz54S09KFr5BEi7AxlBCKV8952hf2fcX8/5W3QLYw=;
 b=lwEHDPKAsgLFKggSCkOJry2LUVJDZrg1vT3HvT4AQh36eDqZCW6T5wlaErHXY7EaxJSL5nN77TbzV9DgUyt6GbXnIly/sAXvqFGbXUn8kXyVuRxLiR27ul9xtf6zH2FwPDRSzJZJUlUvQAkG0STQEQ0VtTPbp5k64kFO9H6R7Nk=
Received: from CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Tue, 14 Apr
 2020 07:19:43 +0000
Received: from CH2PR12MB4070.namprd12.prod.outlook.com
 ([fe80::5dd0:6759:2911:2991]) by CH2PR12MB4070.namprd12.prod.outlook.com
 ([fe80::5dd0:6759:2911:2991%6]) with mapi id 15.20.2900.026; Tue, 14 Apr 2020
 07:19:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] series to refactor psp np fw loading
Thread-Topic: [PATCH] series to refactor psp np fw loading
Thread-Index: AdYSKyW3wSp/rB5lSkSFu9kz/7eu5AAAdqSA
Date: Tue, 14 Apr 2020 07:19:43 +0000
Message-ID: <CH2PR12MB4070CCFCA0DD979CEE14AEA7FCDA0@CH2PR12MB4070.namprd12.prod.outlook.com>
References: <MN2PR12MB4032D3C0EC3E363471268799FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032D3C0EC3E363471268799FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T07:06:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2bca3f23-3bab-4646-920e-0000b1718afc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T07:19:40Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a205f7aa-a13c-4a81-ae2b-00009444b782
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f7c6f01-12cb-4579-18e7-08d7e0443438
x-ms-traffictypediagnostic: CH2PR12MB4150:|CH2PR12MB4150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4150F21BFC28F887215408BFFCDA0@CH2PR12MB4150.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(33656002)(26005)(110136005)(66446008)(66556008)(66476007)(66946007)(6506007)(64756008)(53546011)(71200400001)(86362001)(7696005)(316002)(9686003)(8936002)(76116006)(52536014)(2906002)(81156014)(478600001)(186003)(8676002)(4744005)(5660300002)(55016002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqDNiNCsEV6DEIJdHkJk2dbOH4emiwvvqe7/wpKlHNYsFS92ZGxlH12I6cC1qQCLhhSsLn3BAARMolm5nKZ0E6bxnXghGNoBGG3Oe03l2hGGq+84ur6SoYibV9QY78AzEN47CmUddQd5+76Z925xIi0kqrTeHESphXQc469H8wQAz1gqVXIUq3jJNRlVOLaL7RvBIT+t3hY53IBuN8r9WIuniWvyYrsYHqtBpnE9FCQ7ATzTQPgbx4GYyAJk+o+STlSL3E3fha8KJdCeq2x6dQehRva809IRcTqPgzpGXy5otGcvjKw9pnBW3oyajYsch7PH/MeQvYSHZFkFLv0Lqxsk4Jysrf0COvFwC2vxHIeJOGFYRio0J5Ubb7CWSWZO/2jZgNxuRpyfvbpmm3oaOiYtEZcSBCbZ4jmkUXoouj41/9BcCSYzzQlg6fOojo/9
x-ms-exchange-antispam-messagedata: yAnHrAPCUsGZRv7kkHmhQHCe+dfXMyFSIPdwLgKF7i1McqUV57aUWoytxARdb0Ls++s96T9WeIXI1nX9sytM3dK4KPny8NbIFOYdVpZtC2KAMNpHPHyIkRWVMgFuqTObkXZ4qcTByk2eIAen55JqkA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7c6f01-12cb-4579-18e7-08d7e0443438
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 07:19:43.3618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMXNQo2QlyNYT6WXR8iSWPJG2swo3FrO8EVEWzMd3O3oesq9IGo7mVK8mQgVkJmq0CaWliAhxf7+o1JCohpm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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
Content-Type: multipart/mixed; boundary="===============0807184104=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0807184104==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB4070CCFCA0DD979CEE14AEA7FCDA0CH2PR12MB4070namp_"

--_000_CH2PR12MB4070CCFCA0DD979CEE14AEA7FCDA0CH2PR12MB4070namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, April 14, 2020 15:06
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] series to refactor psp np fw loading


[AMD Official Use Only - Internal Distribution Only]

Submitting patch series to refactor psp np fw loading sequence and set MP1 =
state to unload in preparation for SMU FW loading during a GPU reset

Thank you,
John Clements

--_000_CH2PR12MB4070CCFCA0DD979CEE14AEA7FCDA0CH2PR12MB4070namp_
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
<p class=3D"MsoNormal">Series is<o:p></o:p></p>
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
<b>Sent:</b> Tuesday, April 14, 2020 15:06<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] series to refactor psp np fw loading<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch series to refactor psp np fw loadin=
g sequence and set MP1 state to unload in preparation for SMU FW loading du=
ring a GPU reset<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_CH2PR12MB4070CCFCA0DD979CEE14AEA7FCDA0CH2PR12MB4070namp_--

--===============0807184104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0807184104==--
