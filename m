Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F9C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 07:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3623206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 07:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eqDHLAHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3623206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06986E213;
	Mon,  3 Aug 2020 07:25:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5E86E213
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 07:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR6uq48boXkuNgS9IF71SbzJnll34B4OY7d8HSmeloRKhiqSW2/nlTuAIZZfbEPA1Rcjwi3moDX0Cowd5B/0deaN9UumCLhNy5PTMKXVY7twbwqWG+6SjP8jHrAS9id6OGW+kzGHQH1fEyg8a960V1Du5l22P7MuBriny0fqebYWJdxvfQfXSUcquihGIsPoXGOzgmF3oxQZ8gAEH2nURwJyTWScr4U63NmJ7PyA7KDCZUi1AqbtvBH3ezj441Orf3CWUd/zcZ/OQXXu55EkScdlkcAkD+AaXArKtjmn/xLL6dc9x5OHXgc0RUP61F6AnUvPBkTsAKEM4bCFXEJ0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1gKZxwOO9fzM5z9QNAmV64p98Li0QelDlmFa9CvzfU=;
 b=RtSNsao9k94jn68/5ldtOO+u8XAEjt3NBJUCZ9veNw7JwUVIKtbLy9p2WI0a6685VCILkieJRKy9BuPfUpQ6R1CUmdt2kcOgUrEG7+FhHYqhnBmybsbwh4OshmRAza1oaINLlnLTaBmmNbY2D/1U2tRDy6gYhGGlXbBEtzd+TlR9EbcAP7ftfQpuUT6ICLAkAsaF6HeL15+ARv/GGG2Jxy7+FUf1ypoPbcBrjG1mRNrFevBfl/G+Lt1QE1pD9dSiompc1MN12rdAO1iaKmx9ZMj+WxfvYdbbpaI9JeQsAvJ0tN81Mh6/i5P0Ync/0rB1+M5JAP4jTY+ZfIqTJzsWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1gKZxwOO9fzM5z9QNAmV64p98Li0QelDlmFa9CvzfU=;
 b=eqDHLAHJ6bsS82LT4cat1szh3dfxJXscUKDNHebH070nLZBGy68wXRSP+4FYSx0I2w6IT19r/f/H80e8D04X8N1+4bQE3/xX98/m6va4Ig5r6SqiFsx6DGxvpllTRwVaAORbBUlvafwJgmpga7bUIh9DglzuaJ4lUDbcXh92jjY=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (10.168.168.136) by
 CY4PR12MB1158.namprd12.prod.outlook.com (10.168.168.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Mon, 3 Aug 2020 07:25:13 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 07:25:13 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: added RAS EEPROM device support check
Thread-Topic: [PATCH] drm/amdgpu: added RAS EEPROM device support check
Thread-Index: AdZpYeqQlMOCJDtATiOcCxe+S+7zUAABGU7g
Date: Mon, 3 Aug 2020 07:25:13 +0000
Message-ID: <CY4PR12MB128794C5BDBDD5EB08059091F14D0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <MN2PR12MB403277D8F0483FBC2AC9540EFB4D0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403277D8F0483FBC2AC9540EFB4D0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-03T06:48:18Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ce3385a2-1571-436d-89c9-0000efcba210;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-03T07:25:10Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: fb56629c-e1e0-4ac4-a6ab-00002eb638cc
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1f46338-c3a3-4e67-e334-08d8377e5cf1
x-ms-traffictypediagnostic: CY4PR12MB1158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB11582FF33EA10CE4B3EA3EEBF14D0@CY4PR12MB1158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9BxEthssYu40Cv6ZgId8o8nMkKXUDcUDIWndwMuyyH2EpZ0uPIm0A952pBjYmWSDxlXW9UVZvYhyiYdg0pFScCpvqcaD4h2EeHM0BKqsBV5KctMYAfRwEz8a00XDZY2xu7EF4cXwieQ7vZQdiWFTnlLqbNNPMF0TyJQkcK2JChq2WDjaa0EQ92K0Rnx2t1di/BFcGfBYDAN3q2KAB6uSBjeMhvrMvHc1mGN+OOU71t8eg9pzzIJd85nAGXMXS4/SuhD1PaiF1sI8Rt5MFZK0rGbvFRfoFjZpl2U9xUv9JCE7eK4pvOaJCrhhKPzTdi8kaMsF2B93v8N/Fdk7Aefvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(2906002)(66946007)(8936002)(6636002)(55016002)(9686003)(8676002)(83380400001)(478600001)(66446008)(64756008)(66556008)(66476007)(76116006)(26005)(86362001)(316002)(71200400001)(52536014)(33656002)(5660300002)(6506007)(110136005)(53546011)(186003)(4744005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8uX3UymM9v/L/DmolIK70C3rrgbhgdyz7ltDAHz0ytk6nqfYpHqpur1Pnw2i3JJe8ozA7uWaOoDVkA6ZZfE/P/doQwIrIPmOSk6NWJNiRrPK5i0OX+NFAhUpU22sD2UF9nZrNzbzrU+A69ZaT8dP3KW0ONTi1vR/9E7XD7u4C+fDcMt2KLTPyAneZ4hOEwo+a2DeWEovnd/EHlPA3UNbcAH+GXQJTZr5lRVkgjlwfpMB7Z3FZej4XZsa3wILweuzrOBzKrwjSLCtHFA4/HWb4nwnX9b8n1Mzxi3H8aZo202+L3uo2XY06JGDY7jlxrU8rNyLxLdmgKR3IRqjoZv0/P5Om/WlZ02m1VyHk8svTaRYj/J2jgXEXOLb4bZgBDpL02sGGyHs+48tTBFT8wDqxjGSU6p/fVao+7ZiWg7tkb5hVAVIcvRC6BEA+shn/JeXcnelwpeztgg81DXlU5P5w35hOPyUspmIi3ErB/eeEKZjeF6e1hfMmo7nmAW1n9c4mwBRhZaIlCR5UaBbIdYxOr3MbfXO6dDqgqNGadTpQ2ID1PLJ+GyRVTNrx7/o2ekd0GPTHLm0FLoyn7D7QqIIlFqU0JaxgjljherXq9I9Q32Y7Am9Gn1aZLv8qohsu/ZUZAOqSmB1k6MJRmzsox+DJA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f46338-c3a3-4e67-e334-08d8377e5cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 07:25:13.6738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkwWobGH6dcVyOY99Fx3jYRxXxy/vxForXGxT3zHKKgmY8CuX/EZZMRVTNveOVhyGJ5gSlULXnTmB60Y+pISig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
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
Content-Type: multipart/mixed; boundary="===============1862282793=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1862282793==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB128794C5BDBDD5EB08059091F14D0CY4PR12MB1287namp_"

--_000_CY4PR12MB128794C5BDBDD5EB08059091F14D0CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Please put the check __is_ras_eeprom_supported behind the line '*exceed_err=
_limit =3D false;' in function amdgpu_ras_eeprom_init and amdgpu_ras_eeprom=
_check_err_threshold respectively. That promises, even when eeprom is not a=
vailable on several ASICs, exceed_err_limit must set to be false.

With above fixed, the patch is:
Reviewed-by: Guchun Chen guchun.chen@amd.com<mailto:guchun.chen@amd.com>

Regards,
Guchun

From: Clements, John <John.Clements@amd.com>
Sent: Monday, August 3, 2020 2:48 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Chen, Guchun <Guchun.Chen=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: added RAS EEPROM device support check


[AMD Public Use]

Submitting patch to with added device support check before trying to access=
 RAS EEPROM.

Thank you,
John Clements

--_000_CY4PR12MB128794C5BDBDD5EB08059091F14D0CY4PR12MB1287namp_
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
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
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please put the check __is_ras_eeprom_supported behin=
d the line &#8216;*exceed_err_limit =3D false;&#8217; in function amdgpu_ra=
s_eeprom_init and amdgpu_ras_eeprom_check_err_threshold respectively. That =
promises, even when eeprom is not available on several
 ASICs, exceed_err_limit must set to be false.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With above fixed, the patch is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen <a href=3D"mailto:guchun.ch=
en@amd.com">
guchun.chen@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Monday, August 3, 2020 2:48 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Chen, Guchun=
 &lt;Guchun.Chen@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amdgpu: added RAS EEPROM device support check<o=
:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to with added device support check =
before trying to access RAS EEPROM.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB128794C5BDBDD5EB08059091F14D0CY4PR12MB1287namp_--

--===============1862282793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1862282793==--
