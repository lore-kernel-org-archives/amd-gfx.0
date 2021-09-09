Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B72C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2C260FE3
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D2C260FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050E36E48C;
	Thu,  9 Sep 2021 08:17:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C436E48C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 08:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWtrukri1gtRllyTe0Qiu0ZrFlkr44mVsHdnhYsJ6V+/QEsC1BCREslvtBrVYbtK27QDw2iCQQydJ7z/OfuZHi+Gh/bvX2pozQhokEAca+DBLg3f7XAQ4xRSA6Oo15hNE/IaqozLnaG2E4p9hdPlMJiuB6WSpNicVfwoGSZY8M3M5QN48W0pt3bASsL+zhYRPudL6M+9Wb+o8pX9KiuTkgLdGRRhORmcpFcCuyV3oQ4rMNDa9C1ca334GOj4+LzejngJ0yBEbk5kr9nRHbCMn1QGntrAw++/03w33ajC3wtuWexxSJdqo0dR1hpaUdPPX9xcnl/Phje8hjIkIvpMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ilhMbDvOUi87HfOa0dsvyvKhiBQ7yQ15G3G4YRNLuYY=;
 b=Ajm+qj8Jg5E6+vGLTcRAE/jRT8RDiWVC9xfwkgz1Hn72Ef8ks9mOEuRChDZCbLYYeZZrHa8rGwHVo97GwfGEGdlPMaqaa19qhlY3jnZ8aAvQsbgLn/0uvzWcJjDYm/U23V55hFXmBoikvy8n++uLEycTenMWBBYuxqyjKJsOzqdgOzhbPPj5ahvLrJMdGr8MXIqykW1hIzuSNcKYbyILFnbYZHaOJoXcHBraQxvJ17FTJgUHx6fWbI06LqUy6NN6v7p0HeCR91jQXW4bQz0FQEbAVbtvlkpsHi99UtuMZSnwSyDVNXjoSA6lUqlVN1UNeHLPRgmeDKfwoih/vUHHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilhMbDvOUi87HfOa0dsvyvKhiBQ7yQ15G3G4YRNLuYY=;
 b=phQvfgfL37LcV8kof+ZQ89Q2pHdWziAO4KILhwj9fBdxDkk7z69JeQYDYuJMURcH138eG4pFcsxVe3/L5hLxgEk4Re/qbotTUUtgbV1EwEQbSLkuIvBLuHirrLzRuBCy8zV58ucdAzCnLR0MHXcSSfAJPdND0wugFyT22srC0eo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 9 Sep
 2021 08:17:29 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 08:17:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: Subject: [PATCH 1/1] drm/amdgpu: Update RAS trigger error block
 support
Thread-Topic: Subject: [PATCH 1/1] drm/amdgpu: Update RAS trigger error block
 support
Thread-Index: AdelUHE4vkYZdNDaSlayBUdjMUdcqQAAqapg
Date: Thu, 9 Sep 2021 08:17:29 +0000
Message-ID: <BN9PR12MB52571CCB4656DA962A5D6900FCD59@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB52269FFD7928A6A2F697653EFBD59@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52269FFD7928A6A2F697653EFBD59@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T08:17:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a030baba-8cf1-40f4-b423-4482685f9af6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fca0238e-a6aa-44ea-7057-08d9736a4422
x-ms-traffictypediagnostic: BN9PR12MB5307:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB530717242F3D234FDA42AE50FCD59@BN9PR12MB5307.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0LsQy//lXn9mVoCCOKopIcogxt/cWKv0jkwpyTyMfvaHLgsVZEXzJmMRHHN5XqDmfnT/Ifa1/+CbQIYV0suCcHumewVAPGxqLJY3aEWAhnzNU1JcGgfOoielOaU2POMaC2Ga6ExjSXg8rNawYqhRo2dKNojj+DpvFovhoFlZcDknPMQgTaxOhvykk7VMWekmLGgpXkDwmtq6AdARP3KAel26b7d11HVSd2J2M2sBKua5j9UrnwYw8nViCNusDEZsd8UzgMH7lGlAGLjL5fKYup4Y4qskRxFP0X5J532yszQ8gbWc439aG4jfek+MgHazdYhr3lwtdqQgkeXhznCeQPv229wlGv0JI3iuYeWfOywUMGIWyc26TBOLxWVpCvFAJEKY89VxVIxSaX66dS8sCpNCDhfm3lW+J7B0uUy5agpOZzixdnWdVyyxrPY1jkQkhRQZzbLRRvE809Ps2I3+EqxJENynliP1D71XQ73Ye05Lhx9nkwpTZwKLCoG02xkcCfsFReXXdyrlNtJMuriaX9sZ9e/7Bbmlx5ZOEzkC1GTFG2k0bRDq5JQ/GfJgcVSXA6+zThUolwZcEqxP9Ke0NXjbI+zpb2v694VhOgI6qohIiXttdxGMgY3NzpWJHQ2mk1MfEj4GH2oojeDnYWLhBysF9hZAy/dIqusm6llIWQj0aa78j2ackudjFJp8YnPe8EV8v1/HWjZGJAkz6oFjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(316002)(38100700002)(86362001)(33656002)(66476007)(66556008)(122000001)(66946007)(64756008)(66446008)(52536014)(7696005)(15650500001)(38070700005)(8676002)(4744005)(26005)(53546011)(2906002)(6506007)(71200400001)(8936002)(186003)(9686003)(110136005)(478600001)(76116006)(6636002)(5660300002)(55016002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9bXRphlpIxRWV26JwqtIvHwuCvvmZ8rQiEFcptVZmQDIacqbJD8ie3nLzq/o?=
 =?us-ascii?Q?gAnphXLy/EwfPyszvbxEjBkWHiwD/VbdI/3aBd3cRW6O2r/cCtOoJfV8u2Z2?=
 =?us-ascii?Q?jNOdp/UrV4zP8uyxNdbCa+Zy8deWPvqFuOPKtzbfbhF2WBkPLKZ2fBxhg+SA?=
 =?us-ascii?Q?8wmz+yt/wbPLOpGJwM33oWjEiSDDKnD9hQq4fGJuZjPACx+5VohMnfUstGhS?=
 =?us-ascii?Q?purNz/DN2ZrggiC/mV14xcJCpm15/JS8ARszyp3qBLXgP4erIWj39ohIQNJ/?=
 =?us-ascii?Q?8/nBmPe1j0jrtrS0Ubw998r/MgA+i40RvLpcuZqnyD+hA16vrgLyYG8d2Ifc?=
 =?us-ascii?Q?yOoDWI1wGTdzebxGEYKw61qknswTqObUSjHFso+PmUG6zC8lybq/5BvpoBuM?=
 =?us-ascii?Q?bSUsLfxm9X9N0s0leKGVmlpsCnmEJvbGXgy4U7WLVsSV0SS0qc4K2/wOnEoT?=
 =?us-ascii?Q?B7vcN+m7xJTz6tar0qrxJfvq+7jxbOGcYwBE+3J1l/glaYTITDBHWUseEIsd?=
 =?us-ascii?Q?SWWngXd5RHEngoXKO/1TG+qmr/fCNpBl9ycsLMdHCx4p2A5lrDt1qxXsA/pX?=
 =?us-ascii?Q?1nbAWhpL8TtJf7COHy0a+6RiLljwvsM2hI4RlhFtokXGIp4B+0iTpYi8xd66?=
 =?us-ascii?Q?ZX2Gepbs+FWXtp15E9VIo6JgzQXTVZcPnrffRuPAD6T34a5Cgd/jRcpjYxwM?=
 =?us-ascii?Q?Te15dQWNsf5xeJleN8UofVCnztDGJBFUIhCmcTeaYF2AiJ73Hm7f+EnVZ8Gl?=
 =?us-ascii?Q?Fd1vBQJmUaYmwAv9lw4jwuOdEHE5/PLstUVdhww9vN2ArjPqninbBSriP79g?=
 =?us-ascii?Q?BZzwN4doqZoKTIoMnwBRnsAFHAhmftIbYS8exJfgnzkx+ZKyY/VySBbwgVbP?=
 =?us-ascii?Q?tJpzO+6zWvH+Bp+dCgXc/tfuU8zrnowRCAxW91CinDZfFs74M95Ka4wWKvbD?=
 =?us-ascii?Q?M7hXernFx0GP4UNjqpiXyzpJLcOAc77bhkqr5ZOEJwC0bfJBXj+WYbWqWi4A?=
 =?us-ascii?Q?2pZ7jNXDxmwy6EWw/F8jX4VQr88TLMG6sXkQDCsDYxIC3etd+omd/0fS2t6Y?=
 =?us-ascii?Q?qJBor4P5Pm7t5VUVG5CAH1Ua70ZihTwSjovRFYgJndfHOcRRMkdYnQPSTn5J?=
 =?us-ascii?Q?dVFl7LizYWa4aniV0MdpeM2NSnty1bNr9Ei7eAM83elYbo7nydbKCtaT5Tot?=
 =?us-ascii?Q?SxgvORpTGauun4Vr2ddw2DOnfahMtSsNt+h+KcFN9PRnC03qoTl95tHget0X?=
 =?us-ascii?Q?WyU9jHxZPjPPHbVg/m9lc0thG21rTwqHXvXQTtTvZCSaMJo6tnyUF35x92QG?=
 =?us-ascii?Q?bQ2eWPHIOW8ZsILFr06YeUUs?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52571CCB4656DA962A5D6900FCD59BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca0238e-a6aa-44ea-7057-08d9736a4422
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 08:17:29.4917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDIOHn7PfAduRP/AmI5cuGnTYZrKi9cIdC7a/qSKLXuT+qG5c3CZ06syjuR0uVE6yma6HlvMNxfOF5gLE9SLSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52571CCB4656DA962A5D6900FCD59BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, September 9, 2021 15:59
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Li, Candice <Candice.Li@amd.com>
Subject: Subject: [PATCH 1/1] drm/amdgpu: Update RAS trigger error block su=
pport


[AMD Official Use Only]

Submitting patch to update RAS trigger error to support additional blocks

--_000_BN9PR12MB52571CCB4656DA962A5D6900FCD59BN9PR12MB5257namp_
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
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
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
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
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
<b>Sent:</b> Thursday, September 9, 2021 15:59<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject:</b> Subject: [PATCH 1/1] drm/amdgpu: Update RAS trigger error b=
lock support<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to update RAS trigger error to supp=
ort additional blocks<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52571CCB4656DA962A5D6900FCD59BN9PR12MB5257namp_--
