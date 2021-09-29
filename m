Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3284C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 07:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F5B613C8
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 07:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97F5B613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E7989CB2;
	Wed, 29 Sep 2021 07:01:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1B989CB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 07:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxI39gl/pSeqOFaWnZ6FRpOWOcfbyxQNf2FtJcaawe7pnVnbk8wRU1wXOi7RQLlsUlpNPhCZLlb5UqY6kaEmmMPaYWpmBtA9ilnuxIhZDSUVi8BsVsXpzWKA/p9DA+u8BoovUdbPDz8F5YZ/zMHTFhG+N2Nd7jAWHOlDPvI1fyTCaNxgAruRwASyf7rPIFHpw3yhNwpmMz7DX8eEXctPTB9lb2Id+AeHpVAp3UAb+6jj0/eCuEvIhN2kaVyktDPRdJ1Vav+i1Nwl3xIGUUvaijRRuDlk/IoXzOqqCIcd1NTFpUNQSKF28z2rZtjzxpp0YB7KHbIHdUdcHHuu34mPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=o1Eu6XmnCBzS+VioXYKtM+2fTKSJbpL47ay7faxynK4=;
 b=bPNFOLzW/nqGwrxtcYj2RBy9oStpvSFEvMRYZW/rixYnrxXjY9o5ado8pYuEv+Az/EYjPt/I2jaLWVaKFV4ldkMFEuSfE4vO0crnwxsbbQBR1agp7zSMVUeBKub7Wjh2MakPclddRcJhuNdDxfcnZzdgZMlRYIJhXnedSZehV/vqTI60u6YZnYG528YJslTFBLF0ZKsxYXyJ9h/+CgzgaN9i2LUQBCvA6wA2bNY4Du9DVzvLcf1ZMG0sfCFAT1V14qsXNPepUYYvwrMIe1pGlvDFeV97qp6pDsh8jT7KuGIU29RDdAnm8vl6rjJMkoA3VEWerU8KboHUPdnXGEg0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1Eu6XmnCBzS+VioXYKtM+2fTKSJbpL47ay7faxynK4=;
 b=Xmi8ZXvpK038n6oLsSif5cVcURpidclRr3GiqujQ8roOKserFHzRzk2DZhFODvVmUEpI58iuyQCsTbo0FB06W60pRT22nVRs7GDUsxU/qQsiUh6SnyuNjzovwqs/PJjf1EyfsCsqHzEfheTjeEE7sglst/Zvro5aiBGKJUriMtk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 07:01:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 07:01:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: resolve RAS query bug
Thread-Topic: [PATCH] drm/amdgpu: resolve RAS query bug
Thread-Index: Ade0+AOhxyucOhgJSNqptAodmsakigABnlJQ
Date: Wed, 29 Sep 2021 07:01:12 +0000
Message-ID: <BN9PR12MB5257793599D625B270031C00FCA99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99@MWHPR1201MB2542.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99@MWHPR1201MB2542.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T06:06:30Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=87f4871e-644d-4853-897a-0c7e793a7ed9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04509e2f-0032-4324-7f69-08d98316ec65
x-ms-traffictypediagnostic: BN9PR12MB5366:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB53667A8C264ECC22131817FDFCA99@BN9PR12MB5366.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdviPktcFsWR8PLOSSK43u5te4PjtguhMSuwfIgJbR7UeAhRs0BSaVtsT1p3VjKfI3qK2jUg9HsLSB7nKV13rqe+1ry2hHKpdosgr1xJqkhW1Ifbkwn84L5ojFxy3WUH8Bs4djmhgT25mDLH1VkLpQ/AeWGOu+eF4udQOlXlw/Qw/oe/ywlYmdclh9f8meHd0FVwQtGMAifK2Cg4t2wfjT3DxTjRmYCs9G4CpomnBYfwzFjWhlpg5R9askZ2agQa4xCD+2pwE1Zuc/hRMytzWsvjJrWm/aTd4v/U6E3nsMsIfKA7dZqpf6k9bELCrEYfLedRRGuxLvou1ElxYISmCxwTyRcOQdAfTVAYkmFvXoKWJJP3r1kGWU+7cXO6ftm/YzlQqdLpz8fiG5oyMXjEim/adeSYwtMfWBlFBl7X22gg0v7lk6GIHbHRjccpTBavHLBEIkdRZJOg7BmPH0gZCqf7fEGnbItzK3nQY5Fa+QwSuVGqSCkdwFVWCl8bLCc34Rr799yydQI3sOaA4HfYQ6QmlXJJ9xzaKYOMiaN0o54V3MV/LRbDELb61rhRp9ssPBZwXZ+tcu0Osf4u9+8hKqRgNCkaae5Ai6iGYcxZ1I5e/Y9l1/8eFLQyWbHQvYkxFkhCNsEtt3voGGMc0kZmCzG8EDM0J+E9s+vmqv1qdO4QwOnwVtCCbTrK8GX5N7inPehqtyUqzVBHvfutpwQuUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(110136005)(86362001)(33656002)(53546011)(8676002)(66476007)(6506007)(55016002)(2906002)(66556008)(76116006)(5660300002)(52536014)(71200400001)(38070700005)(26005)(7696005)(9686003)(508600001)(66446008)(64756008)(122000001)(66946007)(186003)(4744005)(38100700002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8AICAPuWPehXFTSufm5SmDBfvyLH3dWhW8/fUJRAEieuW6fAPr9imIEYirYv?=
 =?us-ascii?Q?xAylf7jYyerJCNakHr9RROsTqLoR67A7OGnYaicEo+AVqOVv8YzHmlVJPTiX?=
 =?us-ascii?Q?2u5pfhUSB9vD8ovRZ6qfh8pDNU9fu/ZrNClw3NXwAmMdWuRYN/PoZqN4avug?=
 =?us-ascii?Q?PJKM5XxvgppgYwLgYKfvh6LeFThc45axKs1kpjQ6RH/D8IsLHIxL+QoWg23P?=
 =?us-ascii?Q?WVH+5M/AZ3kHzn6puXFH63yHF13MeOwvtslcJTfvPD6pSaSQQa66HIm5QEmr?=
 =?us-ascii?Q?2inOUvCUlPcZ062rwQiP97RTIG0Hdwti6kqRw+4BDtns/MiGDkE64bJ4XCZh?=
 =?us-ascii?Q?cAJ7LgKvFAMKpp7MOLrvwri/dhvivRM/xJf3WB0RGYqHlh83TNldWVXQkPJT?=
 =?us-ascii?Q?g2utaQnQ/L/p87qHwRhf10qY2FuF8J8pEH78dxGk2D94w9vlJNAGerbTi9Ry?=
 =?us-ascii?Q?GFkpmmgYzjP5MaGCCNYhtifdoTJIuJz7bQzKJgRb5RDXGC55Vt1o9N9mT0Xs?=
 =?us-ascii?Q?3VnJUaHw19fdq5iEGfxM0XNmaO5KyHQz3vH3Ov8h8013bGHwBdxVYUuzc+1g?=
 =?us-ascii?Q?9aPrJKV8b77r/HHM/leAfF88UvOOFUGnGUkgQXogNffkD1LgmIaW8ncoNs7C?=
 =?us-ascii?Q?/XGHCaSpgg4dsdb/wJdzO/OThC9jLv5Fp4tLWkWkZBWso7c68XC4/U9ZkKFY?=
 =?us-ascii?Q?iihnC016OcrmSOIC+v4FBLUeKswpgpow/X/I88ZaI8dm5gHRW7BAQze6UA3n?=
 =?us-ascii?Q?tlAQmiqzHwMESDAfQ+q120IEq+utJw6RLzpnhQx4UlCjNkqKTeL0n+1UfJQi?=
 =?us-ascii?Q?grFL0CuTwb06JAlVIw0gz8jTwv6AFk/crg6IjSB4qUm4XK3uiYhn7DkbEGdZ?=
 =?us-ascii?Q?QQIbvo/K+q/WVWu1eRjB7biEKGv98Yr0LnSQjepw74jDBy7J0QV28pZvJzzp?=
 =?us-ascii?Q?fiybiRdqV55e3j40JmTdvWqZljREH0p7ZZaMidUCUPDY3B88ir5TFomK8CiD?=
 =?us-ascii?Q?m/LfDoFiMM8E94ifKIc6ygzYsUTxIz6U+vQc2wUJE5rd10p60BZxbj648CoB?=
 =?us-ascii?Q?68uTKJmgAotHSaKjJJUIS/Yhtme3xWSZR9WZQxfHf/GzwotNHLgRI5FLHRMK?=
 =?us-ascii?Q?8NI88Mq/Hf+AvaYlxhiPRfJxj1Rry5NDktcNC8zchc+CU0t7TXAXJB1cIyyy?=
 =?us-ascii?Q?f6Hk+N+8B3F9L9IP9iTEQWBY84EbCZ932nFcERSHWzWQPLhxYTMDb6y5jwoo?=
 =?us-ascii?Q?tepNE7q0UVFrMv02EfGCrd2ZaQYCjY01yfMxpPrv9Da4uosVexKZaMF9dgZV?=
 =?us-ascii?Q?7/xd6g0VL/zWkELyZrV+/bBk?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257793599D625B270031C00FCA99BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04509e2f-0032-4324-7f69-08d98316ec65
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 07:01:12.7990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6izgdW+mXQaY4FqMXKis/eQ5eB/3OL+5wTixlY102GebJ3UUwvOW6vD3ZX0FAtqpQTt24OEXYKeYbpNCM8ynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
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

--_000_BN9PR12MB5257793599D625B270031C00FCA99BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks John! Let's try to use amdgpu_ras_query_error_status for that purpos=
e

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, September 29, 2021 14:07
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve RAS query bug


[AMD Official Use Only]

Submitting patch to clear RAS error encounters during error query if persis=
tent harvesting is not enabled

Thank you,
John Clements

--_000_BN9PR12MB5257793599D625B270031C00FCA99BN9PR12MB5257namp_
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
span.EmailStyle20
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
<p class=3D"MsoNormal">Thanks John! Let&#8217;s try to use amdgpu_ras_query=
_error_status for that purpose<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Wednesday, September 29, 2021 14:07<br>
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

--_000_BN9PR12MB5257793599D625B270031C00FCA99BN9PR12MB5257namp_--
