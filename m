Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4778EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 02:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7307112202;
	Mon,  9 May 2022 02:47:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F149112202
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 02:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfhR+6/VkpxY8LTy+UMnmoSfsjJpJzS/Jj14w7M7WimDecDk2l6HS34FOGNKjBh5k0S0LFMWTJoarw+x0uJhyS4rzE3aZU9nWTDfUdvY1ck6/uUwAjljsDAalYKXhSL6HGqDwCK7odvCeoyunwQDtW9q8JIfdPGCYJSylc1pj7GWxhFqJ4hL3zmS++lGLsxKqETsKoWgIawWV77XFKYqaQxA0fSmHqTTuKGPgiLF5onFOL1OKE0fTAroIq7+pIL7OUz0Q5Ufs0UG7OXm6ZRU6/CBq646wvafOcIuOoMMpT9Pnu/XdGzdvSNDASX55EMIiugABa9yjV19XSIT7dx2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDxYmJHDObnEIl3VVSV60VqDAPFyXev+VvOIYme1kqc=;
 b=k0d4aCZKDZhb1A5idw7gjRkpRnoq14pBtd5HN7tDalePfHI5prr3y2Zofpu7Ag9Zey8P708WpCWWBdz67qzMd4xlZtJux0Wr35d9emn0KNdBgYsI2PK/qW1VusovAI9Yk7YkF3HByqkahB+MPK3YK+PXYh0AEt4H4nrmhFQmJnVfKTeSt8WWinaOkyXO8oaNLST2mipdGYhEdVy6hpBA2lBjCLwLshihenOXXdl0DKqzTBO3OQS3ObCmEL443LKOjt4+BVFYl3DJkGIQMiXjPs1sk+Uk7i+BOS5jfe5Nkl4eh1ckIXOlChLXk/jSq7FR5MA5gvNW0BtF6itpKtw0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDxYmJHDObnEIl3VVSV60VqDAPFyXev+VvOIYme1kqc=;
 b=l926NHZUtExzBtPgjdShvDF+ktoq6NE+FzaHuvB+lzs0JKizkMnoGBIelkXDx4/g7MZhh0QjU/sOYj/PyanK2Y2LoAvkHpjHUQawIZoctogvhCrQzyMj3xsjvbvVp8gk/O2erATezpu4tL/1j8r3MJSlwjFMlvByhKIdwY4ainU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.18; Mon, 9 May 2022 02:47:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c429:9d84:9f6e:42bb]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c429:9d84:9f6e:42bb%7]) with mapi id 15.20.5227.018; Mon, 9 May 2022
 02:47:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Maxime Schmitt <maxime.schmitt91@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [Question/Bug?] Why does the sysfs current_link_speed report a
 different value than pp_dpm_pcie
Thread-Topic: [Question/Bug?] Why does the sysfs current_link_speed report a
 different value than pp_dpm_pcie
Thread-Index: AQHYSY40gVtGhE2NbUWULlMzJ68GSK0WCNgw
Date: Mon, 9 May 2022 02:47:42 +0000
Message-ID: <DM6PR12MB2619BFF30502D3EE717A0422E4C69@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <CAPdf_3mLX49uBfyJwpMbcyumYQCqjqXB+S3gzWjdS9TCfbEVRw@mail.gmail.com>
In-Reply-To: <CAPdf_3mLX49uBfyJwpMbcyumYQCqjqXB+S3gzWjdS9TCfbEVRw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-09T02:47:39Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b3a5dfa3-9e52-467c-acb0-fe1b9efc7e7b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c79db43d-39b6-4220-69ce-08da31664a2d
x-ms-traffictypediagnostic: CY5PR12MB6322:EE_
x-microsoft-antispam-prvs: <CY5PR12MB63220C3ADA0CB79D8C3292EEE4C69@CY5PR12MB6322.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yW0ap8NLiTb4hC+L1+BxkQfVEqX0IldXuo6wPcgakDzkzwM4nKlbI1s0V3ehw9jcs4nJpJNeYy19O47YuqmyZzApH/BpjAwzrBNVDJi4xEwP1d3uPMXG2wRs0XlCUWj2EGgx7ByHkcJlfmCD8aGkr9hDlt5KDsZx+PHDhBaZHfPozxyKoUn+5KKKji1F4aBDe3sMEzx5MWGlJHsLWt2fQY/J4U4pMZpcPzUl+bnl9rNhYMJCOKJjIbmdNEeoKWeENuqvUyBnG+XvNYCoymNI5ez8iJm+bzZTsIFt2eXvFsbwd2cXyq8FpgmrSThVPVrBnDDEEzpZHL2/LpRXRVho/DEWpTsNs3fOA5xlAWkFXC922moXZ+OkTk+ng1i4DSsN7Zr2x2kvzglQdy07P6XZW6hc5dVCULAOrn8X2yimvtHHWEXy6+7/twk0WtoqvXwRZFW7QnTd7jr5XSIu/x/8Uk3lnqUNS9RWPGwd78TrI+/IaXUg/qhf0Y0zyjQbFUzFlF043BpQyKZ0NqA1z7m8rGAk6waMHT3/PP+3gYGIobPWKGwHAsDvGII95NFW7/m/qOwd08pSmHpro1hT5LqhChezy/Zrb2a+U3/26PKqnLfts25XDXatYkEDJN99WvygYhtxUoX5kDKFub9skV/8CyD3PtmQX5+oVdzKe1uctItvj+mK5fL3tzhoSEREivfgUVXBYkMoLzkctHsxfBhNMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(6506007)(2906002)(76116006)(8676002)(7696005)(64756008)(71200400001)(66446008)(5660300002)(33656002)(86362001)(66556008)(66476007)(53546011)(26005)(66946007)(508600001)(52536014)(55016003)(38100700002)(38070700005)(122000001)(110136005)(186003)(316002)(6636002)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qiN5zlAHBmWdfjnSUG647zA+kVwFnIAq9yDk6UPma/SkaVLD4xm9mkmKxU5P?=
 =?us-ascii?Q?sCAjJcEMg6Sf8jKw4/YfHyEXKJBXoDRLmFPjZ1eyAcS6WIv//ouDfD9R4oAL?=
 =?us-ascii?Q?rgVCoXl/3DIoU6mzFSr+xfjXNsqs0seIeBbnzCo1XRJtPlnzUFgns/92GzZ4?=
 =?us-ascii?Q?ZVASjdIZbTXSeM9s63YyMVm2VK/oqRukWrkIfchXwGUf9vDoHTjx1kwCdxlh?=
 =?us-ascii?Q?T8bbPWtg+IE9AXdToJZK9nnf7bd4WFg8/TpJ4To4FsZv2rkioWt1I1iqP0fB?=
 =?us-ascii?Q?sO9ct9kC8Fca0jpSSB4nXZRjcOzaeriBXPJsajCxIPaQCdXhmuHLCM8JzRRx?=
 =?us-ascii?Q?qBTxiPpCebXFT27XjjxMrhTp5RviaC9ZN7UqDWPFSwHGqaqbg8XV5ejyq3mU?=
 =?us-ascii?Q?dNvAibB0u8NzPLEppuuinwgs89o5g1J8id6xbFxAUkSsmQNCPV2Ipl9og2bC?=
 =?us-ascii?Q?NIl1ZdV8sXcx04KIV01MV5dm5pEJaUT4MqPq/0Qk7ZszsIEIk45UljvwzMuh?=
 =?us-ascii?Q?v7+abr1CKe6dRHtudocBu1nT4JyOQZcbi0vXYv6NzvGGJ652Wm5bRtWV7vlo?=
 =?us-ascii?Q?wBuUbUzzONx6paHDkK7VutSLNNZ1We1xrHgsejQbW6ZcQrtnHradKv8Ab+W6?=
 =?us-ascii?Q?v0JfuGfXcz3dbLqQixTxoZNum6BzreGSQWfIa1hxF122wKQJ+dGEG532UjS0?=
 =?us-ascii?Q?eMFdEg79vwO38xmsA4NXQphZODaEk02o19bcZ0oIwe4dbq+P+7svOHskx0nD?=
 =?us-ascii?Q?LsyCMjvoj9VHC/ocqsNrcpuSPIbC1+AGD4tlD3ouurCjg6C2cLA6RYgTqTH0?=
 =?us-ascii?Q?dWPC0RRZ+spaAadZnPv6xike+1fdfUlq0Ga8iyJfMIPjpyMYLhgGgalDWDNQ?=
 =?us-ascii?Q?/FoqrwykngLfUR/Az5fgl1XEDqFjVyhIToul6GTsOyn2ClsO7pExJFHb96mi?=
 =?us-ascii?Q?V//ZzmfyEKdT1b9V7wobd3bl/7qB3Kmjjjl8JMEUzku0BmkbSaMHGwHS2MIv?=
 =?us-ascii?Q?gr7eZASyrnESyulZ+uJlZvplk8wEOmn129JJ7Xi/oEe1WKbHveLmY25ddw42?=
 =?us-ascii?Q?4n9QeFWAdTbKqRjSemK0n90UjLbcgc+sFTM7wCI0GcLu4//eZjVthN6CJVNi?=
 =?us-ascii?Q?zW0QiJiLCkAX1nbSM9F4IWbUB8AxIDo347pllZ61kgwlc/zrOM/5P0K2NESV?=
 =?us-ascii?Q?KMU81X+rBR3ZVXuR8/Bqh0r0Cv62UpZd/1UikTn0SOmh+lxViMkNxKKlZUff?=
 =?us-ascii?Q?OEDtjoIbJwTIYsIkszdp9OCGrCEc0jpeCbpeLqntW4YmqWX6xz9vht0Bu16k?=
 =?us-ascii?Q?f9CIfgJDpcv8uSwzZBIQHWnbTSYlVfBxD/yEa5fyiHIIa/2YVmPAFwY+5uza?=
 =?us-ascii?Q?8MWc+WwDrVu1B8OGhX1fFQTaB6geXJ1k7WChPZ1nlzUBlhBIQQcolR+OfL+D?=
 =?us-ascii?Q?COx0C3lVoPzpHm8jtRh7lXzjZ38ca8SUIuRax5eJyuK0H+T/oWe5cOCBV2FH?=
 =?us-ascii?Q?70SXpb3xjvUW010eNRnt+wN9saNlmB+tLkfxTXlZ4C8RlUvHLoHqGTjrAVJN?=
 =?us-ascii?Q?r2eUcM48dA0ARp0tsKMZYF6eOTG+BlIul5lm3TjNLfufh5D95vW2BuNYsXQC?=
 =?us-ascii?Q?p6xz2oMEvoGwPs/meLg3EB7u4ippjPWVIYGJNSBRGUXV7Pc81uorBGxMTXAi?=
 =?us-ascii?Q?Yt0P2FTa9x0Ji593kE6PGB8Ll0BHzShHi6EMuWytUhtYi8Kr?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2619BFF30502D3EE717A0422E4C69DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79db43d-39b6-4220-69ce-08da31664a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 02:47:42.7105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERu/vR71OJs5MIyLuic3EhOGINjLcXLqouhyofgFBUR8bvv6q+39e7UzVpLYlBdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
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

--_000_DM6PR12MB2619BFF30502D3EE717A0422E4C69DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Maxime S=
chmitt
Sent: Wednesday, April 6, 2022 1:40 AM
To: amd-gfx@lists.freedesktop.org
Subject: [Question/Bug?] Why does the sysfs current_link_speed report a dif=
ferent value than pp_dpm_pcie

Hello,

On my system the sysfs file "current_link_speed" is reporting "16.0 GT/s PC=
Ie".
The GPU has support for PCIe gen 4 (AMD Radeon RX 6800 XT).
However neither the CPU (AMD Ryzen 7 1700X) nor the motherboard have suppor=
t for PCIe gen 4.

The file "pp_dpm_pcie" returns the following:
0: 2.5GT/s, x1 310Mhz
1: 8.0GT/s, x16 619Mhz *
Which is correct.

Is this the expected behavior?
[Quan, Evan] "pp_dpm_pcie" is reporting the correct link speed. You can tru=
st that.
While "current_link_speed" seems reporting the link speed the card is capab=
le of. Not sure whether that fits design.
@Deucher, Alexander<mailto:Alexander.Deucher@amd.com> Any comments for the =
output of sysfs file "current_link_speed"?

BR
Evan

I am asking because I recently added AMDGPU support to a monitoring tool I =
maintain (nvtop) and I don't know where to get the information from.

Cheers,
Maxime


--_000_DM6PR12MB2619BFF30502D3EE717A0422E4C69DM6PR12MB2619namp_
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Maxime Schmitt<br>
<b>Sent:</b> Wednesday, April 6, 2022 1:40 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> [Question/Bug?] Why does the sysfs current_link_speed repor=
t a different value than pp_dpm_pcie<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">On my system the sysfs file &quot;current_link_speed=
&quot; is reporting &quot;16.0 GT/s PCIe&quot;.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">The GPU has support for PCIe gen 4 (AMD Radeon RX 68=
00 XT).<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">However neither the CPU (AMD Ryzen 7 1700X) nor the =
motherboard have support for PCIe gen 4.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">The file &quot;pp_dpm_pcie&quot; returns the followi=
ng:<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">0: 2.5GT/s, x1 310Mhz <br>
1: 8.0GT/s, x16 619Mhz *<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Which is correct.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Is this the expected behavior?<o:p></o:p></p>
<p class=3D"MsoNormal"><b><i>[Quan, Evan] &#8220;pp_dpm_pcie&#8221; is repo=
rting the correct link speed. You can trust that.<o:p></o:p></i></b></p>
<p class=3D"MsoNormal"><b><i>While &#8220;current_link_speed&#8221; seems r=
eporting the link speed the card is capable of. Not sure whether that fits =
design.<o:p></o:p></i></b></p>
<p class=3D"MsoNormal"><b><i><a id=3D"OWAAM9A57E03E9052415B9227753024FFB076=
" href=3D"mailto:Alexander.Deucher@amd.com"><span style=3D"font-family:&quo=
t;Calibri&quot;,sans-serif;text-decoration:none">@Deucher, Alexander</span>=
</a> Any comments for the output of sysfs file &#8220;current_link_speed&#8=
221;?<o:p></o:p></i></b></p>
<p class=3D"MsoNormal"><b><i><o:p>&nbsp;</o:p></i></b></p>
<p class=3D"MsoNormal"><b><i>BR<o:p></o:p></i></b></p>
<p class=3D"MsoNormal"><b><i>Evan</i></b><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I am asking because I recently added AMDGPU support =
to a monitoring tool I maintain (nvtop) and I don't know where to get the i=
nformation from.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Cheers,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Maxime<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619BFF30502D3EE717A0422E4C69DM6PR12MB2619namp_--
