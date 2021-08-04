Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FB2C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 08:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D357B60E97
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 08:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D357B60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CE86EA22;
	Wed,  4 Aug 2021 08:48:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DE36EA22
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 08:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNneFxCsFvJOrrb8TImLDr65hK7qlPTpS/+9ZHtEl/MWSfcOE8LVQk+12gwbTVJFMTV1bJ7eX2AxSc8sqrGiV9Cl9BN/iB60VF2bc8az5MQvKdyt7KunWxlcmRFG/DZv7XFs3Na/JiVEH7LyayUH/JxGz4szsuItpZQnffuJ5K7eCtptI6mJtMAjjzdpreKExETFlSCKDq2uXjJnyYD6msN9q4ioWsU9R3vMi67ZfRH/CRgTQ1vRVteV3WD49RN6MLzv0s4kusO6iWHZp9sNyXVNzkUgL0KtpCSzFYDygSS+wxYkxOQAANe8gc2NG7dyaCs5ZyAimX7jBcvwaJbqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs3I9Cunryh6ur/ulEzgGZCTxDohcPZhmh45UWn86Cc=;
 b=IpFCjEobU1fy7Hfl4VaFFAItuv6HRcxqj08QR6ir5nHS6/W+EpH3tdPNvEDFkt4J2juiydmfOhVT5KRCnWQiaYauTJkSCkwfVtQbdEV3Zk+IbBSJ5bAarSnw7p6u5NkxnGQ3bNOrt8tBcmVzpy8TbvW86NA764jLkEHW0Ctyaywldh8sYsAmcBhCOXSi+MMyik+XeBQhEAj4a1r945armEt4U16CPzgOcn0bDUrVKQsWlGXUszHinMBKogOFUdsex/e+FXTbjnPpDN3UQOfCdHNOYocLxHFaCLoaL2P7rz/EuxTWngyA9QiY2P3VX2RuFwhUt9CFxRkw3kYwZTMuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs3I9Cunryh6ur/ulEzgGZCTxDohcPZhmh45UWn86Cc=;
 b=DZ6mtBOpvApGYkouXfA3NWQJs3KqpBJzjTbSEl3zcdkqyPL3LTkot68aUrHhl1RvLdXxA9FmomT57hEZeSWVDxBKccflxyYPB+yBeDmh8ZFVjCrHEFIiWkU9oq/13efhv00k3YrjQ3arOzWGzpDJs9hYhoFjNfT+VODlujfKx30=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 4 Aug
 2021 08:48:20 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%8]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 08:48:20 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS
Thread-Topic: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS
Thread-Index: AdeJDVbWTr3gUddJQAKxCNFB1i4ygw==
Date: Wed, 4 Aug 2021 08:48:20 +0000
Message-ID: <BN9PR12MB52266E0B3F150CA07FE3BF67FBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-04T08:48:17Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d85b9a83-ccf9-422e-8df1-d8188f5d5714;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3648c089-16b4-4ba0-b3e2-08d957249c65
x-ms-traffictypediagnostic: BN9PR12MB5130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB513021FCD3373F8B829F1CA9FBF19@BN9PR12MB5130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rBeQ6FCqqVjJxWo3SJJQ2RVuczlHQsD43xfIYkjICYy2zZLfPmyr0bJ/vfZw5y7FfRlOdjzQhj1yMaNzQdXlMBHOoZyy0j6HhuYiHuAsLwxY1UFHlRtmLCsdFUzYoNzfX9zChpX3JiSsz4NXk2kjekDQWFoaq5nK2G3n6d15Pj9FkatlKhVPVK27OhvYjVRGRpBjx6c14YptyUqfmQ5CqB7EvUoKxnkN6bLLL7LQ9P7triIOY/mKY53ghZw3dcBrep2BiB4HppLm08eXdPGWW9DNRXrFxzZ6Kf4aeLkWDYsgg7T7GULyt7uH5ztJ3ZxZAuqYg6loZzwwtbG2gKXUapUOBa5PYvAh9lQHiyOQxcfZQEhR17jnUifdLOtfeMED7JdAspKn4+yjGTO2Zoum3p981NKLH1TZk56lF+2r3ELdPyB/3KjS3GkathcL20YOHfK6xTmrhmAXsLPKrJsK/bHivyKhaX4GEQ4Q0spBIlurFZEgtqJnx0ns/ZobovxC3vUyBua2qcBjfOYX4URwabtf0InHQfh1L5YKNOt+fCj9B0SfsIs30BwZ0eldArqHktZrgY7PCp0aAhdAOTKyYu0QTNjNO8zsoS+mTuBrzc5hO8u2sQy9vGmvOdVs8Fm5FDQPplpvtn4vqoam0vQ2mBqy0lUiutP/LIeA3yZslPdm679cYlVg6xybjhwcaqcP8v1fah2synF9Ovkr2Ei7jw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(8676002)(66946007)(9686003)(71200400001)(76116006)(55016002)(558084003)(6506007)(478600001)(7696005)(38100700002)(52536014)(4326008)(2906002)(86362001)(99936003)(5660300002)(316002)(64756008)(122000001)(33656002)(8936002)(66476007)(26005)(6916009)(38070700005)(66446008)(66616009)(186003)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5EgZU61M0ZNItYVSivo9N9E8BaEaxqhFHbFzre2HfStD5FTyniJOSHwgv3Ip?=
 =?us-ascii?Q?/FuoDW7AXDXrBKiWere2KQkkwFYYd2FE8zCu/bpYmLwHG1ZrB4Sx6COm1In4?=
 =?us-ascii?Q?c2ORhCQjMtegcdftSvxneXyc4i7Z2MCrGf3vByVS+H9NZcoalWRWYoSOgs5U?=
 =?us-ascii?Q?TwKe/Og1tX1itPeYkJ8O+VoZCIlkU/J3nennWrFts9hwyEJVpCcq5H4ZjDpH?=
 =?us-ascii?Q?0w85xVhWarXwEe3hh5ysPnpu5ntI//t2kiVGZhPDSovJW0Za56xkxd0finI4?=
 =?us-ascii?Q?NLOltrJ17fLOxVpl2I9loRAdYURzw47Y4wCyR2HnNifB50MTvF/OomaCb9hR?=
 =?us-ascii?Q?3AGFDxpPdeyB4kdQPtUyKXI8f7AOmu0rbeDTS7GmuY1OifieNHzOhszyIvNm?=
 =?us-ascii?Q?Rp1CFZMdrN7en5J70T7n3ICJT1WEGKmpV0YEgeKRtQcpVp+fj4LptCRcwz4K?=
 =?us-ascii?Q?JM5Z7CGYLCBvRim+fZTHN1r80rcy66fKPxnng+qW0xcB3FC2UHU3pZTigA8s?=
 =?us-ascii?Q?U7GiSeFvmDnNcYBRfqZNoIL59e66zhr/W04BUW6vyCe/q6ySJwE52xQOKw71?=
 =?us-ascii?Q?qam3CB7dFVAcWtErJGBSGxBOIY1ykjdovwPDnHfubuR3LqU9MkSORh6l48Bb?=
 =?us-ascii?Q?tFlmLpo5ntLwwuwcjTd+e+MX+DW8oKt3Crz5+RJHW0CF892hYWS2JyxvqNKl?=
 =?us-ascii?Q?iWy9w+wpqpVhWgF17gC3GCMb1fgcm36Vnd/D53pRBFClxqqWOfaLi46ty6QT?=
 =?us-ascii?Q?vaRDMJyCuEg5Xgkx0A0NIBetmglrv+jCt1Z8Z9ZkF5jIST8Dby29ZjtvoSEZ?=
 =?us-ascii?Q?JZyXFxWkh+yqouNwTZxOiCc2wxWvJquifVPa5VK5DkMeeJpF9OiM/ey1cZjz?=
 =?us-ascii?Q?aM5ZiKU4sqVhu86cIvM8O9nUTgWCZxWtewkvKwDHGKHS2f65tV65PaRmeLHw?=
 =?us-ascii?Q?V44nVW/MNtCbaZuoISc3er5Sq6VewSr+nPJiNmF1eeXX46QVu059Cebq0mnn?=
 =?us-ascii?Q?jqpWCsCjABqG/NJPRBgwt0j4fTO/kvL55JLRsDqHb5zCLhFzOFF3v9rCzEKn?=
 =?us-ascii?Q?1C5Cpkvab3rn46eNlc6yQcQKDRuv08U/EgkWFyZOc4Gw5oIWGnK2DWipvFEL?=
 =?us-ascii?Q?iAc+t2SsJo7/i7uMuYrKUZpVRyloJ/fWveWiVMvohWRgdHuIWPoXFI8jIF6Z?=
 =?us-ascii?Q?72DP+yLJe104ELEQ7yffHziOZaTBy4fxiOWe+ETDVlDPiVGLRykTguKMGCeU?=
 =?us-ascii?Q?1N5g0aK9NLB/Bv56YERGRThxvYANDsQyeO5pr/PTpfrKrrfMYBb9RbaQWGw+?=
 =?us-ascii?Q?Z2aCAPv7koeezSl3hWxRCbdS?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB52266E0B3F150CA07FE3BF67FBF19BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3648c089-16b4-4ba0-b3e2-08d957249c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 08:48:20.1994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfqbp1j3H1J/w2YUqWYsW9zCH1JMTW1blEklBVfbsjhs6sM2AiY8vA9DRbaKrNZiTsYUKwdAsRpOwbcq+dKRZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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

--_004_BN9PR12MB52266E0B3F150CA07FE3BF67FBF19BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB52266E0B3F150CA07FE3BF67FBF19BN9PR12MB5226namp_"

--_000_BN9PR12MB52266E0B3F150CA07FE3BF67FBF19BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to get RAS EEPROM I2C address from VBIOS FW info table.

Thank you,
John Clements

--_000_BN9PR12MB52266E0B3F150CA07FE3BF67FBF19BN9PR12MB5226namp_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to get RAS EEPROM I2C address from =
VBIOS FW info table.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52266E0B3F150CA07FE3BF67FBF19BN9PR12MB5226namp_--

--_004_BN9PR12MB52266E0B3F150CA07FE3BF67FBF19BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-set-RAS-EEPROM-address-from-VBIOS.patch"
Content-Description: 0001-drm-amdgpu-set-RAS-EEPROM-address-from-VBIOS.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-set-RAS-EEPROM-address-from-VBIOS.patch";
	size=4577; creation-date="Wed, 04 Aug 2021 08:47:00 GMT";
	modification-date="Wed, 04 Aug 2021 08:47:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwNjRjODAxNzFkM2FhYmQ4OTY1NTNmOGRmZTljN2VlNjIwNWI0MWRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgNCBBdWcgMjAyMSAxNjo0NToyOSArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBkcm0vYW1kZ3B1OiBzZXQgUkFTIEVFUFJPTSBhZGRyZXNzIGZyb20gVkJJT1MKCnVwZGF0ZSB0
byBsYXRlc3QgYXRvbWJpb3MgZncgdGFibGUKClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMg
PGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KQ2hhbmdlLUlkOiBJZWFmZmExNmE4NzUyNGU0Y2M1YmVh
YmQ1NGJiMjAyNTNiZGFhNTNmOAotLS0KIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0
b21maXJtd2FyZS5jICB8IDM3ICsrKysrKysrKysrKysrKysrKysKIC4uLi9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5oICB8ICAxICsKIC4uLi9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhc19lZXByb20uYyAgICB8IDEzICsrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hdG9tZmlybXdhcmUuaCAgICB8ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDUy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYXRvbWZpcm13YXJlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYXRvbWZpcm13YXJlLmMKaW5kZXggM2I1ZDEzMTg5MDczLi4yZWIwNjRi
NmIwM2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdG9t
ZmlybXdhcmUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRvbWZp
cm13YXJlLmMKQEAgLTQ2OCw2ICs0NjgsNDMgQEAgYm9vbCBhbWRncHVfYXRvbWZpcm13YXJlX2R5
bmFtaWNfYm9vdF9jb25maWdfc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGUKIAly
ZXR1cm4gKGZ3X2NhcCAmIEFUT01fRklSTVdBUkVfQ0FQX0RZTkFNSUNfQk9PVF9DRkdfRU5BQkxF
KSA/IHRydWUgOiBmYWxzZTsKIH0KIAorLyoKKyAqIEhlbHBlciBmdW5jdGlvbiB0byBxdWVyeSBS
QVMgRUVQUk9NIGFkZHJlc3MKKyAqCisgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisg
KgorICogUmV0dXJuIHRydWUgaWYgdmJpb3Mgc3VwcG9ydHMgcmFzIHJvbSBhZGRyZXNzIHJlcG9y
dGluZworICovCitib29sIGFtZGdwdV9hdG9tZmlybXdhcmVfcmFzX3JvbV9hZGRyKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCB1aW50OF90KiBpMmNfYWRkcmVzcykKK3sKKwlzdHJ1Y3QgYW1k
Z3B1X21vZGVfaW5mbyAqbW9kZV9pbmZvID0gJmFkZXYtPm1vZGVfaW5mbzsKKwlpbnQgaW5kZXg7
CisJdTE2IGRhdGFfb2Zmc2V0LCBzaXplOworCXVuaW9uIGZpcm13YXJlX2luZm8gKmZpcm13YXJl
X2luZm87CisJdTggZnJldiwgY3JldjsKKworCWlmIChpMmNfYWRkcmVzcyA9PSBOVUxMKQorCQly
ZXR1cm4gZmFsc2U7CisKKwlpbmRleCA9IGdldF9pbmRleF9pbnRvX21hc3Rlcl90YWJsZShhdG9t
X21hc3Rlcl9saXN0X29mX2RhdGFfdGFibGVzX3YyXzEsCisJCQlmaXJtd2FyZWluZm8pOworCisJ
aWYgKGFtZGdwdV9hdG9tX3BhcnNlX2RhdGFfaGVhZGVyKGFkZXYtPm1vZGVfaW5mby5hdG9tX2Nv
bnRleHQsCisJCQkJaW5kZXgsICZzaXplLCAmZnJldiwgJmNyZXYsICZkYXRhX29mZnNldCkpIHsK
KwkJLyogc3VwcG9ydCBmaXJtd2FyZV9pbmZvIDMuNCArICovCisJCWlmICgoZnJldiA9PSAzICYm
IGNyZXYgPj00KSB8fCAoZnJldiA+IDMpKSB7CisJCQlmaXJtd2FyZV9pbmZvID0gKHVuaW9uIGZp
cm13YXJlX2luZm8gKikKKwkJCQkobW9kZV9pbmZvLT5hdG9tX2NvbnRleHQtPmJpb3MgKyBkYXRh
X29mZnNldCk7CisJCQkqaTJjX2FkZHJlc3MgPSBmaXJtd2FyZV9pbmZvLT52MzQucmFzX3JvbV9p
MmNfc2xhdmVfYWRkcjsKKworCQkJcmV0dXJuIHRydWU7CisJCX0KKwl9CisKKwlyZXR1cm4gdHJ1
ZTsKK30KKworCiB1bmlvbiBzbXVfaW5mbyB7CiAJc3RydWN0IGF0b21fc211X2luZm9fdjNfMSB2
MzE7CiB9OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0
b21maXJtd2FyZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21maXJt
d2FyZS5oCmluZGV4IDFiYmJiMTk1MDE1ZC4uNzUxMjQ4YjI1M2RlIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRvbWZpcm13YXJlLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5oCkBAIC0zNiw2ICszNiw3
IEBAIGludCBhbWRncHVfYXRvbWZpcm13YXJlX2dldF9jbG9ja19pbmZvKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KTsKIGludCBhbWRncHVfYXRvbWZpcm13YXJlX2dldF9nZnhfaW5mbyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBib29sIGFtZGdwdV9hdG9tZmlybXdhcmVfbWVtX2Vj
Y19zdXBwb3J0ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogYm9vbCBhbWRncHVfYXRv
bWZpcm13YXJlX3NyYW1fZWNjX3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7
Citib29sIGFtZGdwdV9hdG9tZmlybXdhcmVfcmFzX3JvbV9hZGRyKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCB1aW50OF90KiBpMmNfYWRkcmVzcyk7CiBib29sIGFtZGdwdV9hdG9tZmlybXdh
cmVfbWVtX3RyYWluaW5nX3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBi
b29sIGFtZGdwdV9hdG9tZmlybXdhcmVfZHluYW1pY19ib290X2NvbmZpZ19zdXBwb3J0ZWQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IGFtZGdwdV9hdG9tZmlybXdhcmVfZ2V0X2Z3
X3Jlc2VydmVkX2ZiX3NpemUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMKaW5kZXggZDJlNWIyNTY3
YmMxLi5iOTVmNGY0NTFhNmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXNfZWVwcm9tLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhc19lZXByb20uYwpAQCAtMjcsNiArMjcsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2JpdHMu
aD4KICNpbmNsdWRlICJhdG9tLmgiCiAjaW5jbHVkZSAiYW1kZ3B1X2VlcHJvbS5oIgorI2luY2x1
ZGUgImFtZGdwdV9hdG9tZmlybXdhcmUuaCIKICNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+CiAj
aW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgogCkBAIC0xMTYsNiArMTE3LDE4IEBAIHN0YXRpYyBi
b29sIF9fZ2V0X2VlcHJvbV9pMmNfYWRkcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlp
ZiAoIWNvbnRyb2wpCiAJCXJldHVybiBmYWxzZTsKIAorCWNvbnRyb2wtPmkyY19hZGRyZXNzID0g
MDsKKworCWlmIChhbWRncHVfYXRvbWZpcm13YXJlX3Jhc19yb21fYWRkcihhZGV2LCAodWludDhf
dCopJmNvbnRyb2wtPmkyY19hZGRyZXNzKSkKKwl7CisJCWlmIChjb250cm9sLT5pMmNfYWRkcmVz
cyA9PSAweEE4KQorCQkJY29udHJvbC0+aTJjX2FkZHJlc3MgPSAwOworCQllbHNlCisJCQljb250
cm9sLT5pMmNfYWRkcmVzcyA9IDB4NDAwMDA7CisKKwkJcmV0dXJuIHRydWU7CisJfQorCiAJc3dp
dGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKIAljYXNlIENISVBfVkVHQTIwOgogCQljb250cm9sLT5p
MmNfYWRkcmVzcyA9IEVFUFJPTV9JMkNfTUFERFJfVkVHQTIwOwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9pbmNsdWRlL2F0b21maXJtd2FyZS5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9pbmNsdWRlL2F0b21maXJtd2FyZS5oCmluZGV4IDM4MTFlNThkZDg1Ny4uNDQ5NTU0NThmZTM4
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXRvbWZpcm13YXJlLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2F0b21maXJtd2FyZS5oCkBAIC01OTAs
NyArNTkwLDcgQEAgc3RydWN0IGF0b21fZmlybXdhcmVfaW5mb192M180IHsKIAl1aW50OF90ICBi
b2FyZF9pMmNfZmVhdHVyZV9pZDsgICAgICAgICAgICAvLyBlbnVtIG9mIGF0b21fYm9hcmRfaTJj
X2ZlYXR1cmVfaWRfZGVmCiAJdWludDhfdCAgYm9hcmRfaTJjX2ZlYXR1cmVfZ3Bpb19pZDsgICAg
ICAgLy8gaTJjIGlkIGZpbmQgaW4gZ3Bpb19sdXQgZGF0YSB0YWJsZSBncGlvX2lkCiAJdWludDhf
dCAgYm9hcmRfaTJjX2ZlYXR1cmVfc2xhdmVfYWRkcjsKLQl1aW50OF90ICByZXNlcnZlZDM7CisJ
dWludDhfdCAgcmFzX3JvbV9pMmNfc2xhdmVfYWRkcjsKIAl1aW50MTZfdCBib290dXBfbXZkZHFf
bXY7CiAJdWludDE2X3QgYm9vdHVwX212cHBfbXY7CiAJdWludDMyX3QgemZic3RhcnRhZGRyaW4x
Nm1iOwotLSAKMi4xNy4xCgo=

--_004_BN9PR12MB52266E0B3F150CA07FE3BF67FBF19BN9PR12MB5226namp_--
