Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF19C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 07:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BE66138E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 07:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6BE66138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893EE6E9D1;
	Wed, 29 Sep 2021 07:02:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E396E9D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 07:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuHfeTqQceCMd+n1/JXqSqJanLWAAlxNeMBRzfDAzYjJYT/Vv40X+6Qh8v8JR0mqKxYy/8KBK7opM8Yv7I1GaeM9ios+SVt/JuzfLt1QP7LdPi0SN1V1Yx89e1ClDLWT+V0vFEm/xv++gWuN7MXYnRtiv/JivIP5tEvTpSM5CI9tvQv4Qmk84LDJvh2zNX5WH7MyVPN2zgtFnuhuZKF4kP9y8R+lQSZtJkAk4unBQVIjx/Iq3V13Uls3NIhFZwcPpJv/WzlsoKGK+KKvHqaAdDE9QQgWJR4KxAgQlX7h+bWWThALPRZqCi/VvVP7mLcp/SFbjhFI/zSzTEe7DQcpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dUVBYuzoMfhLmZmNbF/K1GhNpsID1hjBp4ic49mrqK0=;
 b=RdwJeuDV55WC55GyTRRTohAPUu5+0gPMurACjlyHT0pq7zHNbS7gKYCQ9rveZ/BuU8JLwDHd1NYJeTMFJJNNYMyjdghLKmSUTgNtzFj1cuO3B0cVbsn0MQl6n32MVLqDXhra3lO+jGRwKh/nbJYvg81MY+WCHO9b0iySLLaNvkjbO685GdZycq5BYn1Rcip5+JjneKwTX1db0x6xEyFiKoD6sf+1QoHjnQs6j4tOJgQSBZ6T6Jqagp0/b/DUtunPKiqhfF103zeQ6nePX39bnpv378POAN7HTjgNvACHWNKu2yOE15KmDwrHizyVo/UV0dqS1Ods3Zuc992YsGPn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUVBYuzoMfhLmZmNbF/K1GhNpsID1hjBp4ic49mrqK0=;
 b=b6/pOLlSDOHjv6DNFuMPkWeKl3lniN3xmkD1OcOkg5Ugbg70HplwQLko7+NrMitD5T9b/WGp4re282jzLoKCZ0g4mlnl0Ba/a0XTYFPD+sEm1KUO/A39h5CrRl8xmyVwhJ6HwRsOCLBX+kVlIAEcybzKRqvlCXcYwy7OnJObNAg=
Received: from MWHPR1201MB2542.namprd12.prod.outlook.com
 (2603:10b6:300:e8::20) by MW2PR12MB2523.namprd12.prod.outlook.com
 (2603:10b6:907:11::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 07:02:51 +0000
Received: from MWHPR1201MB2542.namprd12.prod.outlook.com
 ([fe80::890f:f5c3:5f15:455c]) by MWHPR1201MB2542.namprd12.prod.outlook.com
 ([fe80::890f:f5c3:5f15:455c%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 07:02:51 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] V2: drm/amdgpu: resolve RAS query bug
Thread-Topic: [PATCH] V2: drm/amdgpu: resolve RAS query bug
Thread-Index: Ade0//sY0aEdGir/STOuqDf0HZYaBg==
Date: Wed, 29 Sep 2021 07:02:51 +0000
Message-ID: <MWHPR1201MB254209E86784E97EC5C15BE2FBA99@MWHPR1201MB2542.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T07:02:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=87f4871e-644d-4853-897a-0c7e793a7ed9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58722331-2b27-4f9d-7c26-08d983172768
x-ms-traffictypediagnostic: MW2PR12MB2523:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB252314A867317E8459C179BDFBA99@MW2PR12MB2523.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vuWhHSe+T81Nu2FMEM7KokPPuG0iLgVr8VRJtoEhAVZ7dWWHvo2Haa07S59EiKi/enf8Ehvr3jNt0k6C6mfy1o3HSBXtjEKyHhQ+oqGOZkNgaYMAWT+WuhVk1M4Juf0qJCmSTtOTJ8ApGSQgu1zuW6H/NQ14g6d4bMMn2CjDPZlETPUBpi4FYuj2xeyegP53N8noYAckkWB7LrSkA/WTf/KrKXsLmb3ch9VxBengu7tU6V6iTMNk9tlUBuclqrugkozSc4Mxuc2lf2y1BQurqUNQXQaCmdjwVqSkh8GlQGvcmiYUgwZ1KvDF40E1wkLxdP7S/VfaWeseOPxEUMCMVhwFExTjeb3CkpBhQJfbJkQjp1XB2G2isRyqoqsl7dntpgwsI8T7e8rgVDkw83dFTUY835vGRrAfXLtEhFpHqi6ECFJF2ZiCDGqIh82xbe+uVly84ig7CeFr8+0h268OTZ4AoWqsFaMZyJFneyBFEdxisAF+cfkFjc7VCA5lF43G4Ov2NPz9zgLbFp8LMLCiH6AZEf68FVClMXO/nlt6ZqQKFVjj9ILpxo7u1iskXYwxRJyyrtiQdtXiU/neQwDcTiPuPgSFuh6XjMCEEyjD3iRJBXIlYvhBBooaxSXN3CQ+G2f7WN8xvggSuImnTXMHb7AeeGNsWJeqt2kNJTN8XPD0acVqXnIuRNpWu452Xyj5kLZjl46e2y8rRzmKJ5CKHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB2542.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66616009)(186003)(38070700005)(6636002)(83380400001)(66556008)(9686003)(64756008)(26005)(86362001)(4744005)(8936002)(66476007)(52536014)(55016002)(508600001)(7696005)(2906002)(8676002)(71200400001)(66446008)(38100700002)(99936003)(66946007)(76116006)(53546011)(316002)(6506007)(5660300002)(110136005)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VgOei9mO9ABZY7CdRXTZYyrvd7PnFh55RUQWV7QV/sKtlfM1VZ7n7cP3KJZd?=
 =?us-ascii?Q?Fu9sSpuyBb1ir4rnBH5z8El8NvQJOB4Bl6xB2KUDM6FSzjvmDjoPMA+/45Fk?=
 =?us-ascii?Q?SYcOHq531i5ogxM3zGuBKcmqS1T/ZWAkhroQcFjMcxtrVWrkJuY4kkKSLDth?=
 =?us-ascii?Q?4cezf/BNR5TyGTGx349RI9MvREeK4Vp7HHh5EQMMDLdYe7jgQj5mZ+OCFmv/?=
 =?us-ascii?Q?jo/0sDlVTUbx6Y0RII/1vz0TCoxJGpI+cnoVm8Ke400mtcN+RJNk+qLKXwVy?=
 =?us-ascii?Q?DUvfQMrEkPJ+EoR6LNlOVcYclF8oyFElufuPvXv1dsIwnSFAMTZChK26XN5M?=
 =?us-ascii?Q?z1frc4S8WGFK5pcBSkM3asfQYFCc6D+R4xpLeuGxRnztrTUvEk2zZn3GpraH?=
 =?us-ascii?Q?Y58LC7/cKoq2Wvi+z/qkXvcHCLiajG+2cbLvOjgGiWKBrosKfSNgAeJe71LH?=
 =?us-ascii?Q?SWEPx9w9+cCVk8Ehn9ZzLLbxc1NVWOZqw5YsD5gIBswvtHS37OA7wTDouQIP?=
 =?us-ascii?Q?qNJk+D0J8x84B4M0BPuSy4WSF06zLtOHlY0c+dOI04IqbVP2xpHVwnnAt7NZ?=
 =?us-ascii?Q?0zzUGe1YlB18RjvnI9IpW08dh/cWT40jVPuehJUv7qTXmHKBu/CmikElkGit?=
 =?us-ascii?Q?R7trlouMJJa+Da1QDAwK7mlcrcbMY0PV6ejQ1wVjKIdXcTGzNQkSSXyyhfzp?=
 =?us-ascii?Q?nIqptaH7GroKvy3kDjMRAPNw/tXOifqPTePmck9Y9L/cUQaVJ0CVQ308kNFl?=
 =?us-ascii?Q?apysKFauBsbaVjiHbRsRCaBoU13a49EIZ+1/66KE6t4kvH00VDAcFDNxeWFf?=
 =?us-ascii?Q?P4hd24kYVBFVunBAYF+6r37svMkyYAdtW32ejR6IDCPIASADfc0jVo0ZmY8W?=
 =?us-ascii?Q?oAJ09Hk3a8vYyvEX1KgBlIfbOf80nmb4ULVMU5EAZfj1j8oqDpz9ThEGxuJi?=
 =?us-ascii?Q?he8XeohKrRmgD3y2vPNldj8B6XXxYi4b9fXRwlslhZuhOxPJGU+cY64J/Q/D?=
 =?us-ascii?Q?174ZitZGthcOY63AYOOsv5GlNNkyOgnIdVpqwt1XedaRQxGlL58xjS4csWGZ?=
 =?us-ascii?Q?wqwglW/XTfIW3QTo2GZRV2KspO6JYJdJYCq0/+bSKb+01G2yMlCxJ45xZVlt?=
 =?us-ascii?Q?WSn9pfK43+vNFZxb8bBheEesN3OcNItNUSf7VR8rU/fKKLbjNCFdQxqle+aL?=
 =?us-ascii?Q?v02gusrXgDRNvzp8NGGyX2M2aM8hJyEgWu5fTjmlTKJdFipSiltVtUaKF3bW?=
 =?us-ascii?Q?17DJr4uQtuBnLej1cq3oeonvRKPUi9/HF7hfBGu8fINuWgZr56trlqPg1Qhn?=
 =?us-ascii?Q?+34l/zVpzUYeU9ibfXzyAzBc?=
Content-Type: multipart/mixed;
 boundary="_004_MWHPR1201MB254209E86784E97EC5C15BE2FBA99MWHPR1201MB2542_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2542.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58722331-2b27-4f9d-7c26-08d983172768
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 07:02:51.6911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avv/xF7M+btmPzM8wxNQhgqN5vNl+eSjlmulFBdtgOXRQzL7fZ/tlYw43i44lgLkv86r4SqQgAuPKR9RQEGjYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
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

--_004_MWHPR1201MB254209E86784E97EC5C15BE2FBA99MWHPR1201MB2542_
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB254209E86784E97EC5C15BE2FBA99MWHPR1201MB2542_"

--_000_MWHPR1201MB254209E86784E97EC5C15BE2FBA99MWHPR1201MB2542_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Updated patch with simpler solution

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Wednesday, September 29, 2021 2:07 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve RAS query bug


[AMD Official Use Only]

Submitting patch to clear RAS error encounters during error query if persis=
tent harvesting is not enabled

Thank you,
John Clements

--_000_MWHPR1201MB254209E86784E97EC5C15BE2FBA99MWHPR1201MB2542_
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
<p class=3D"MsoNormal">Updated patch with simpler solution<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Wednesday, September 29, 2021 2:07 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve RAS query bug<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to clear RAS error encounters durin=
g error query if persistent harvesting is not enabled<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MWHPR1201MB254209E86784E97EC5C15BE2FBA99MWHPR1201MB2542_--

--_004_MWHPR1201MB254209E86784E97EC5C15BE2FBA99MWHPR1201MB2542_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-RAS-query-bug.patch"
Content-Description: 0001-drm-amdgpu-resolve-RAS-query-bug.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-RAS-query-bug.patch"; size=929;
	creation-date="Wed, 29 Sep 2021 07:02:00 GMT";
	modification-date="Wed, 29 Sep 2021 07:02:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxODMzNGUzZjM1ZmVhYWQxNTA3MGIzYWNjNDkxYWQ5M2UxYTQxZGIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMjkgU2VwIDIwMjEgMTU6MDE6NDQgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogcmVzb2x2ZSBSQVMgcXVlcnkgYnVnCgpjbGVhciBlcnJvciBjb3VudCB3
aGVuIHBlcnNpc3RhbnQgaGFydmVzdGluZyBpcyBub3QgZW5hYmxlZAoKU2lnbmVkLW9mZi1ieTog
Sm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEk2NGYyYTM1
M2UxYmVkOTA0NDczYTQ4OGFjYTUyZGEzZjU4NjUzOWI4Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKaW5kZXggODI0M2Y3
OWE3YzRlLi4wZTgyZTBhNDdkNTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yYXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMKQEAgLTk5NSw2ICs5OTUsOSBAQCBpbnQgYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9zdGF0
dXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCX0KIAl9CiAKKwlpZiAoIWFtZGdwdV9w
ZXJzaXN0ZW50X2VkY19oYXJ2ZXN0aW5nX3N1cHBvcnRlZChhZGV2KSkKKwkJYW1kZ3B1X3Jhc19y
ZXNldF9lcnJvcl9zdGF0dXMoYWRldiwgaW5mby0+aGVhZC5ibG9jayk7CisKIAlyZXR1cm4gMDsK
IH0KIAotLSAKMi4xNy4xCgo=

--_004_MWHPR1201MB254209E86784E97EC5C15BE2FBA99MWHPR1201MB2542_--
