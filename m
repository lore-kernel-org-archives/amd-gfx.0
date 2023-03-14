Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E6FC74A5B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 14:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A43B10E812;
	Tue, 14 Mar 2023 14:24:51 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com
 (mail-maxind01on2093.outbound.protection.outlook.com [40.107.222.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE4888A27
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 14:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqdAu5Igx+OgjMqhjjio19dnfhiHVaW+OFPh5saNECkUZhTh068FuClMfAbOx3mW0ZZ5KprS3YsSh8JnilXtCt8UnKm9/d3YZTPgJ0IENOvKvJwXwT80MGggazmwfPXqCtF/7SAJMWnT17YMU5pT/kuF9elj0Dc42VwLnE2Yi59erUEhme2VHO/OpMKME2uld+ekTG+NKdRIh7Il7dFytpKJQKtkMJM4cdvccLge/CNw1DQ71a4TzmbUJe0JCQAytUA3qp3W+9EvUDtFJlQk7EKxU3WSr8BtdIatN2Y3agZ4SrGAm7dN2XnAFsFjGk7kLVrVGJl6j1KQdX8HofkOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT1/zS2kx3j1McTWsAx86RNW+9e/uyXBIFY9+GwZ30Y=;
 b=aTZdYFcNzujhTIJ8Otire0BvmTxgwnGwibB2rUCOS267hNDqkcxxpKeIwYEa2ErTsY/z2E5D9iiRlcBInWzbzyNGjPczgdK0dSiYokM1U7uSg6BZ5pTsJ6K5fNouJPRN6JviDVQCtEMC+QZFE+SI+AcYYcYIwsPRKFp37ucpHBghLMqinEPKJT4W6K+RUio2XLL6YqWskTYjuUs1NPCQmxlkGInLdYGNd57RwKDR3kolMnGuErZq5nz6ku0uLAtoqClxzn4zV+MuneavcMOPTG+X5IGx3MY+TPadU4Cs/LDaL5ZuSe8SmsK7jiILKgNEG/PJoHRZSocekOdeQcBu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=findusab2binfo.com; dmarc=pass action=none
 header.from=findusab2binfo.com; dkim=pass header.d=findusab2binfo.com;
 arc=none
Received: from BMXPR01MB2935.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:31::13)
 by PN2PR01MB9428.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 14:15:56 +0000
Received: from BMXPR01MB2935.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::28bc:738e:f90d:20]) by BMXPR01MB2935.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::28bc:738e:f90d:20%7]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 14:15:56 +0000
From: Nancy Tyler <nancy.tyler@findusab2binfo.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: NAB Show 2023 - Lead & Deal retrievals
Thread-Topic: NAB Show 2023 - Lead & Deal retrievals
Thread-Index: AdlSsFW8YvTN9h1eR0+27yNYOFEmZwAABp3QAAQPlHAAAAARAAAAAA9AAAAAEKAAAAAPoAAAABDAAAAADzAAAAAP8AAAAA8gAAAAEIAAAAAQsAAAABDgAAAAEKAAAAAQ0AAAABJwAAAAEDAAAAAQYAAAABDAAAAAEVAAAAARUAAAABGwAAAAEoAAAAAScAAAABLQAAAAEaAAAAARYAAAABIwAAAAEvAAAAASIAAAABEgAAAAEeAAAAASsAAAABKgAAAAFAAAAAAToAAEiMxgAAAAEcAAAAAPUAAAAA4gAAAAEVAAAAAOgAAAABGwAAAAEEAAAAAQ0AAAAA8AAAAAEAAAAAAQkAAAABKQAAAAD1AAAAAQgADq75dw
Importance: high
X-Priority: 1
Date: Tue, 14 Mar 2023 14:15:55 +0000
Message-ID: <BMXPR01MB2935B437951A0B5DCB290AB0C8BE9@BMXPR01MB2935.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB2935264A4FB4A8E0D9606096C8B59@BMXPR01MB2935.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BMXPR01MB2935264A4FB4A8E0D9606096C8B59@BMXPR01MB2935.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=findusab2binfo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BMXPR01MB2935:EE_|PN2PR01MB9428:EE_
x-ms-office365-filtering-correlation-id: 54fea956-8778-4058-ea58-08db2496a080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VthbjMSsFFJAUtIA7H86E4bA2SrMMlpmSMp2kYpJAm79n8BrD6Ybi98Bis4V+KilH6B89UodKkqeZMptH85qv+QlVDEdn6md4+K5GvgtASlEf662hmkPfDc9MlF227QvNr4mfBsf+bKYaBYR8BKAZ/GMwKAOfmzWPtictbmJsf+wEFqUwrDxeptYrEnXmF/q/t9oNLX39nppXluoih15GQ3eZTelvidTgLoMQ9IAho08Qwo+v24L+el8qxCeio8jJRUBBIDzRBTSowBKv7gxgiC2dyZFOjWSj831XcRH+GLgds8KTwPf4HNsL81qbXsVJzPqIv9QT3iG7Q+wCGC1Sm0YRzQ+bNIg8JezxUvhRtK/j4XamF1ZMJr7HG+Co5dhh0Y9mC4D/nrMleAewAFp3Z51P0cyn2TsePRU5mEvL7DfDyRk3HGWF0ekthrwYG7lbarQADAj02iW7HBRNdLUhnFYiQTwah0wi/4ITzkyq8oRD4wy385qeY+wnSaVd/qBz+nzKszsLur//Rse15f+Hjh+HNaMN3sYAYjAVvMVKs9znNzFCTbT2gVk6w0kDquOH/hXHHJGC/cPrFUXdIvHdptV82AWvFUkPyjinIJ01/a3oCzOo6d5Nj379gO4OvmEFtRIGpt9fbQLJQKN1GDusakrR6HMifZtTn7dlQQs5/VSiqZEeT3xbJ1LhCfLG+sK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BMXPR01MB2935.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230025)(366004)(136003)(346002)(376002)(396003)(39840400004)(451199018)(66899018)(9326002)(41300700001)(8936002)(478600001)(66476007)(6916009)(52536014)(66946007)(66446008)(66556008)(8676002)(64756008)(76116006)(33656002)(38070700005)(86362001)(38100700002)(122000001)(55016003)(6506007)(26005)(9686003)(7696005)(53546011)(186003)(71200400001)(44832011)(5660300002)(4744005)(2906002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0vvfzod+c83tPPZgsZEbj8lhNG+kKdnmAUlfpOro4Uq1sG+C8q6e3LCpM4Ch?=
 =?us-ascii?Q?RVv2YkULVeNDQDOZuGRwSeA3FDBO8A+RcLDypb5A3VJSy11VwHgAaivrtxh3?=
 =?us-ascii?Q?oFwmqTDrBVn1+tCP+tBAcK72K9Y1qyW1OggeqRHOxNYONmVsxTVqEUmGmCyb?=
 =?us-ascii?Q?6sCTx+epgsoRdOnOle5gVF8FOx4anTLYSF3OKIVuD5lTMXz6qiVr/+4H9+nG?=
 =?us-ascii?Q?EBiszA+Cg9dMxXSHJIGwRw+zDJUA9RBCpPxe4FJ4jMwu11EVo9UdT8VHtvzr?=
 =?us-ascii?Q?pQE8F/5aFjGUE9/W7JIFGnlplwr8aILczxQaAPDpzQHUobegEqLbrHyBHXfg?=
 =?us-ascii?Q?wz58cFafVryUOx61nt4ZhC5R2U5TL+MOR6jpwiK8A7oKnKRdasCZ6tcErnsC?=
 =?us-ascii?Q?8anPjdbi+yjOu2TkF/0s3f5GmWlO6XX4sCWabFl8A275RHR0QAafZIu0bgUl?=
 =?us-ascii?Q?C30yZ4m0r+0ab/0KgJDo/vTa0OXCW3oUalGzEhCEgzG6fk6eLF6tsUJqXeGb?=
 =?us-ascii?Q?N8GW1BH6sMzOgP5yPOlTwjpC0Mm1/mRuivV4y88ZCeB/HofAfk2NS0Db9oaZ?=
 =?us-ascii?Q?GAMAVxcihpAR7qWky7sLKLOnNNzG8PlVFoLEYH8KDi3JyeMoO42FSCwpUDw4?=
 =?us-ascii?Q?FXE9mNQynuERmD69e705Nr6HtZ4G0Xmn3ec1o0uobJ+HDzbkGaZJLkcbQ/x7?=
 =?us-ascii?Q?fdiv44YguEeVMK7sfF58j1J7I+1JsD7MJNyjvl5I4s8woRgUyfsasxPPI/hv?=
 =?us-ascii?Q?v6786q+fEaqwAM4s8goHrtfUoZZobKHG2enZ/vd7VVnJvGYXzh9CyBfNhe8J?=
 =?us-ascii?Q?SANwyJhdFJ5wB3P7EE7DlC4f1RXxjRqdzd5ZrtrVaKTlBgzZDRovKYNyDajR?=
 =?us-ascii?Q?+B+RhaitxFE2olsKs4Bc88COpIl6h+0tRMX/Lloipsf+UfJtQtaCFee/cDeK?=
 =?us-ascii?Q?feNpSt8DnpKY9x5XUEYpkhDA/XJvOv864BdRmyRABZjL0qmtt3gP+F2gTXQm?=
 =?us-ascii?Q?gVh3MaOfIZrwjNfEEAaukZfzmJVApVV0PplkuFpjHc3/a4uSmCDWDdy20uKJ?=
 =?us-ascii?Q?XWLfnyb7PVCfuEub2jm8QyGCPft/bQp1+60jxda8N+yZmlB/gbVqVSM7QtHC?=
 =?us-ascii?Q?NXVJFuRIquRI+uAGsEkV35rspQz3PIWgxFeegoNpkiEP7KbQ1Iv5k0+5lxTD?=
 =?us-ascii?Q?HcLNZrD/BVIeEyDwZF/lrOzpw/WZ+wrjOZnNhY8VTW53Vn/IoRO/kyQZnjpL?=
 =?us-ascii?Q?0yli0YJocfzWAzFBOansol6tUxJWXNBYPzYQsBGy5H78B33dv7MsFkFRnMAO?=
 =?us-ascii?Q?L+59TabY0h+tBVhb+imiOPM2yDjRf+Fqi30huos1IOVApCSgN+aKoQ8CYR+/?=
 =?us-ascii?Q?RTi16OmwM7dxAvvzKXgd1B6MlU+oXJE+B/Ba4v/IedGx+sYmqSUbqcwJYxDM?=
 =?us-ascii?Q?skyFE1GCdkMLETrM5qKf8sHrP8DZQG0/65VqZ5V/hqUgBjQjuUKKl6jAhedY?=
 =?us-ascii?Q?j1FzHDVIcIs+VUbU4JY3ajq+M00SYjB9U94YjAix7FzDZMkpMQWyyEjsGvSQ?=
 =?us-ascii?Q?ktFZqNkpLHBWzDfSzNMqzHcDKKkMJG3abPYANTu+yGRqWXHjvdKXSyAlgvub?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BMXPR01MB2935B437951A0B5DCB290AB0C8BE9BMXPR01MB2935INDP_"
MIME-Version: 1.0
X-OriginatorOrg: findusab2binfo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2935.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fea956-8778-4058-ea58-08db2496a080
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 14:15:55.9398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 330db043-7520-455a-a0ca-b88971686b37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXwL9MCscBizaqTsSgXYol0gwExQKxfGLpRVtg1M/KJ/pJY/CA6pTYZc4i2GW5IuLCmYIhfrTFABmvmlWZEf6KFKIGjvEgIKzesallhgUkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9428
X-Mailman-Approved-At: Tue, 14 Mar 2023 14:24:50 +0000
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

--_000_BMXPR01MB2935B437951A0B5DCB290AB0C8BE9BMXPR01MB2935INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



Hello,

I sent you an email about attendees list ?

Let me know your interest to Send Pricing Details..

Awaiting for your response!

Cheers
Nancy

From: Nancy Tyler
Sent: Thursday, March 9, 2023 5:13 PM
To: amd-gfx@lists.freedesktop.org
Subject: NAB Show 2023 - Lead & Deal retrievals
Importance: High

Hello, Have a wonderful day!

Would you want to purchase an National Association of Broadcasters - NAB Sh=
ow 2023 Attendees Pre-registered Contact List?

ATTENDEES TITLES: -

Executive/Corporate Management, Creative Professionals, Technical Professio=
nals, Sales/Marketing/Programming Professionals, Others..
If you're Interested please reply back as a "Send Cost and Counts"

Regards,
Nancy Tyler |Global Marketing

If you don't want to receive further emails please revert with "Take Out" i=
n the subject


--_000_BMXPR01MB2935B437951A0B5DCB290AB0C8BE9BMXPR01MB2935INDP_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Constantia;
	panose-1:2 3 6 2 5 3 6 3 3 3;}
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
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060">Hello,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060">I sent you an email about
<b>attendees list</b> ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060">Let me know your interest to
<b>Send</b> <b>Pricing Details</b>..<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060">Awaiting for your response!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif;color:#002060">Cheers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Constantia&quot;=
,serif;color:#002060">Nancy</span></b><span style=3D"font-family:&quot;Cons=
tantia&quot;,serif"><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Nancy Tyler <br>
<b>Sent:</b> Thursday, March 9, 2023 5:13 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> NAB Show 2023 - Lead &amp; Deal retrievals<br>
<b>Importance:</b> High<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif">Hello, Have a wonderful day!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif">Would you want to purchase an
<b>National Association of Broadcasters - NAB Show 2023 </b>Attendees Pre-r=
egistered Contact List?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><u><span style=3D"font-family:&quot;Constantia&qu=
ot;,serif">ATTENDEES TITLES: -<o:p></o:p></span></u></b></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-family:&quot;Constantia&quot;,serif">Executive/Corporate Management, Crea=
tive Professionals, Technical Professionals, Sales/Marketing/Programming Pr=
ofessionals, Others..</span></b><span style=3D"font-family:&quot;Constantia=
&quot;,serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif">If you're Interested please reply back as a &quot;<b>Send Cost and Cou=
nts</b>&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif">Nancy Tyler |Global Marketing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Constantia&quot;,se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Con=
stantia&quot;,serif">If you don&#8217;t want to receive further emails plea=
se revert with &#8220;Take Out&#8221; in the subject<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BMXPR01MB2935B437951A0B5DCB290AB0C8BE9BMXPR01MB2935INDP_--
