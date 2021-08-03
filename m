Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A4DC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 14:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D60660EE7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 14:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D60660EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20CA6E874;
	Tue,  3 Aug 2021 14:07:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9486E874
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 14:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhSCOyjHRrf4ytJZ5HUvu9UdvdhixL0ZOJWhn7IzUhe7jTcR+4RIPbO/Zk6b8+oYk6kznDurM93sNc22Qvap/9f7aGRDgRkBeU5WmdUHWVykeHiFIlYVfeZyZxIU420aXQNnjPfZXMqjXQQIkDb4jiT62ovsU/SYGBoO10OHCDSfJG1hdXNZZ8hrH3wcyKHAmJfvKqaImfHnLM8s9ZxnvfcfGq81f+gGNf9uAqqwka7/4bndOyRmDlN8v1DGHiDATB+4ZhJEmAWD3Dc2TD0spwFYs7HjEfrCE2k4ZQzbEWrbFXSPlhqS78Pf86zOLv8BOhHJF86CUyEGVlVQjOQ8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4DTHRUuYZWQgfUUCH9+zT1tMeU13LJx1I47dUpq59I=;
 b=P0upzNsEcU/DDnIjmVKNwu3imQPpreX8b6aBs9DD3T1TseD5SlTjBPg6DVUIkK7cCvCxydfgltiG7LQEwinhkK1iy0Pdoy2F/WOpxAARfWcfYLOWBaA3kDLWOaYfrDCDOwfIiA1JcHpP0encxoSJCgfexlhaotiLl+IUf/G8X85+YrWjMjSN9Vypt2s0QhZSco06vSIuJ09OI2OlNrQmsYw4dDPalVIVHuRdYc/X7ne1PNbqwOxwaXUCAslHgcwqKZa45xTnWx5+hrG5qyM98tOukxvavRx6N3z1BaEU3aRxid8NzuQBogGxQJs+tQBAqCQVXDcIaMoN0NgH+rfXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4DTHRUuYZWQgfUUCH9+zT1tMeU13LJx1I47dUpq59I=;
 b=ITXFeYKeGO2pC5mdCOgcgN5OAjDENFs4woSnY6B52HeL1SlvjYITxOKSzUqI2QRhc/TGfxv4PMD7LNaG7H73v3YBAoDUOvpvnAQKp8BrGvBckI9lYKa3Bwaf4QLbzQ5HJjmi2VR6qOAOVBbxWMCtxD9T4HnZ4R7sYdEeb6YEwAg=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 14:07:16 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%8]) with mapi id 15.20.4394.015; Tue, 3 Aug 2021
 14:07:16 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Topic: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Index: AdeITLg7attLKh5xSlmEVfidPAvHswAIhHnwAABMeRI=
Date: Tue, 3 Aug 2021 14:07:16 +0000
Message-ID: <BN9PR12MB522659C72ED024CE62496CFDFBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <BN9PR12MB52265FFACD0557EC17C4FAE6FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>,
 <DM5PR12MB24697166AD67A6E7A60718AAF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24697166AD67A6E7A60718AAF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T14:07:13.818Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 307f2da3-44c0-42d6-8518-08d95687ffc1
x-ms-traffictypediagnostic: BN9PR12MB5257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB525761D0CA2E07E9A10EBA79FBF09@BN9PR12MB5257.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVFPM0CxZFX/tq/P/VSqRoPzNTmwtrkFbPjBTQj21wWv/My+IHT4brs4g9qTP4PNEGjU0p/YqAMorNyq9HGqTcB7rpJqIRYcRzTBcGK00S2RsNnqRJ37E1U3kZMr/OyCumYNNiCd3hClNEjp4KwRC37dlaPtxmurrJrv8ZDcsc+4w/oxW3MQrzur9EVa9YV5/HrNLQxrSFRwns569cvfuOdV74bSK5dww3CFS5gJSt48jOsACh7SCtPmMqwrDmi/pVaVcwUKKtYggAsuh6ZYl6t348FSJTHTstw5d6kKjUwnEW5vgJW//0NxtKUzGyWAcRQQmbSYeC9UP9wdvpx+mZyZJEhuRigI5vxixlQ1aehNJAubjN+VUqpNEi2lzz3JUIuejtazaRvTDjANHanOnE/2MQ4JFmOXGCexYQP8iCHA3mrB/VSQf/tMfi6DH/mKhQ+TcpbWWEzyX9pivSUbFzFrzIrYme/JMumvdz/CH7y2hg/0v2dy+LeZx3jRNKurDHYGcBZsgPdskjH7fvJM4A9iWrLa13+TQD4qaifwgVdnIDjLsplMx5Ihc8QTDEvIjouz9GlwAaT7qOdihBeTra7DED/awzjOXt4LDpVdjA268YCTS8SFpiFaaPsu4HyuP16S7xFp16Ol4snGyPnLZKiMOpPmXnEDnt6/1LS1jxd7WsWFVfhNXKxX7WLRboyBvRVw59sccId3HBDtmPo6DQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(8676002)(66446008)(91956017)(19627405001)(110136005)(66556008)(38070700005)(52536014)(186003)(76116006)(54906003)(64756008)(316002)(66476007)(478600001)(9686003)(53546011)(66946007)(2906002)(8936002)(83380400001)(33656002)(38100700002)(122000001)(86362001)(5660300002)(7696005)(4326008)(71200400001)(6506007)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E3oePBmOTStfcY1LQ586VkAY5icqdoQFDRg3LcfoIkg5HuZzOCDOCXBXuy?=
 =?iso-8859-1?Q?xTW1nrCaXz2+khouFBb651iIDel4p40LCXhzBCASQphZHRvTfY4vyi9JVA?=
 =?iso-8859-1?Q?215zGw7Gs4mmPRSKZaOmPOpXuuX2IvRKcnZnqHm/2bbKjnnUoy+mn7YcC0?=
 =?iso-8859-1?Q?RYCc5xByV8ku2DhqinqRwPH0FZz/0P0YLeAYdgbK+rhChPtDUIVRkVPqHm?=
 =?iso-8859-1?Q?t6fci94t2XUdBHwT3GXige0wVXxWhGJNp8PfrF6iF3zsOFKTzsWNcZXfAf?=
 =?iso-8859-1?Q?oZgOw4MViGvIpLex+93+PI7t6roHtxxsSWiNcVwnbjS2Lh0AkrzBh7h/0t?=
 =?iso-8859-1?Q?Tk9H5opsuE7vo88HaG1V6U6YFXG/jgKRK2ZsDVfQSqJwgc5ry4d3xkd1tA?=
 =?iso-8859-1?Q?9EcLp0TVjzkXdZwYHf0pDUQI8Vo4PvIhf10q2wyQlycUtvjtGfvNvsnO92?=
 =?iso-8859-1?Q?IpOfTkefZBCpjsH0H+/3PHXL45h7yckky0u25jbFJ2WhtowgBwCI5jis3o?=
 =?iso-8859-1?Q?SXKSQUMR9TQmsc/X5Uzk86qET1M2SO1oNWmQTxwmyV6OBii9QlaienuMtt?=
 =?iso-8859-1?Q?jXgWZ1oPuAOUO5crR068540qkykU2h9bes7WYci5Gi6Fz2vbH86KOFxDp1?=
 =?iso-8859-1?Q?uKnpCvEOEmZMWSeK6fqM4w34ivcdTdRmRdciu4z7rLcyMPGEpD73VZdNzJ?=
 =?iso-8859-1?Q?3TbeA7peL8mniFDY2VLrPo57l9KHR2bGN/FN5Vijb5Vu/8g/ZM67pcRv9X?=
 =?iso-8859-1?Q?s6M0dCL+HQIFPQYPjH2yX2m/UCLK5F77ajHIcYcwXaZZ7cJ9El8ZDa/dm0?=
 =?iso-8859-1?Q?0m6g4iw05NjmoEcexwQEGkfhWmRkQkRQMTBfcKBhpHMi/wtmuQgnmajnS/?=
 =?iso-8859-1?Q?EC3dB2PiUmK8/s9zp0Mxr7oaPpf4S1K7O22IIqjaZCW8l82pQWxE13E3so?=
 =?iso-8859-1?Q?dV4teyzc+6yXbvs9jfZMn1c/uAX2LvO1+QLaZPgN9qiN2DLdTga0CRBGV5?=
 =?iso-8859-1?Q?A27UsUUWzanh42GLUs3GK1l8Klkun8ByhRSG9OpCgjHp+VJ38Ft8FW9jLZ?=
 =?iso-8859-1?Q?6Vf6LdYqQ8iZTZtMQCdaxh9ntJSNLMHR97BZQ/QkOqxg3zv3YxbThlGF4q?=
 =?iso-8859-1?Q?xdpmAITGhnranlD5AvszA06+Z6QTsNGmYGgLfqYB+HGJZcBqMA2ROvR1qF?=
 =?iso-8859-1?Q?IknO/O6kGMeeEpW6Ehw4whJ+HzYKbXVP9cVQDFLjNSLJkGIEIX5sIk1fHG?=
 =?iso-8859-1?Q?1ufMy4vXC07gI6GK9xQOMS/wzhn54B35mszdSaVeQu20Gf3VylgJDEfkNU?=
 =?iso-8859-1?Q?ZFMRFoEO09TzLJeoBP4Rv34ILsooeklGqwcldINc8tyWZ2IXQRM8V8fPk4?=
 =?iso-8859-1?Q?j0vhRdh8HymlFbug+RyrbyVUTEgHKq7ta56LUS10CORoJs4yLqxH4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB522659C72ED024CE62496CFDFBF09BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307f2da3-44c0-42d6-8518-08d95687ffc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 14:07:16.0554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPTDlM0lKTC50H2WGM3LJ1VV/Mwmc8xrfh3NUe8SefrGlVYP6QlA8YtecItow7l17ppiZ6UOIe5241hIpgyWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5257
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

--_000_BN9PR12MB522659C72ED024CE62496CFDFBF09BN9PR12MB5226namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Hello Guchun,

In most of those cases you are right it is redundant, the reason i kept the=
m separate for now is to resolve this bug while also keeping those interfac=
es modular, and not affecting the psp submit sequence yet. We are planning =
a bigger change to that source to remove alot of the duplicate code regardi=
ng the cmd buffer prepare/submit flow and will probably go back down to one=
 mutex there.

Thank you,
John Clements

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, August 3, 2021 9:58 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss


[Public]



Before calling into psp_cmd_submit_buf, a mutex psp->cmd_buf_mutex is there=
, and after entering psp_cmd_submit_buf, there is another mutex psp->mutex,=
 is it a bit redundant?



Regards,

Guchun



From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, August 3, 2021 5:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access



[AMD Official Use Only]



Submitting patch to synchronize access to psp cmd submission memory to reso=
lve potential race conditions.

--_000_BN9PR12MB522659C72ED024CE62496CFDFBF09BN9PR12MB5226namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Hello Guchun,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
In most of those cases you are right it is redundant, the reason i kept the=
m separate for now is to resolve this bug while also keeping those interfac=
es modular, and not affecting the psp submit sequence yet. We are planning =
a bigger change to that source to
 remove alot of the duplicate code regarding the cmd buffer prepare/submit =
flow and will probably go back down to one mutex there.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thank you,
<div>John Clements</div>
<br>
</div>
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Gu=
chun.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 3, 2021 9:58 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access</font>
<div>&nbsp;</div>
</div>
<div style=3D"word-wrap:break-word" lang=3D"EN-US">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader23c54b6f" style=3D"margin-right: 0in; margin-left: =
0in; font-size: 11pt; font-family: &quot;Calibri&quot;, sans-serif;margin:0=
in">
<span style=3D"font-size: 10pt; font-family: &quot;Arial&quot;, sans-serif;=
 color: green;">[Public]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
Before calling into psp_cmd_submit_buf, a mutex psp-&gt;cmd_buf_mutex is th=
ere, and after entering psp_cmd_submit_buf, there is another mutex psp-&gt;=
mutex, is it a bit redundant?</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
Regards,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
Guchun</p>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
<b>From:</b> Clements, John &lt;John.Clements@amd.com&gt; <br>
<b>Sent:</b> Tuesday, August 3, 2021 5:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Chen, Guchun =
&lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: added synchronization for psp cmd buf a=
ccess</p>
</div>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_msipheadera4477989" style=3D"margin-right: 0in; margin-left: =
0in; font-size: 11pt; font-family: &quot;Calibri&quot;, sans-serif;margin:0=
in">
<span style=3D"font-size: 10pt; font-family: &quot;Arial&quot;, sans-serif;=
 color: blue;">[AMD Official Use Only]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
Submitting patch to synchronize access to psp cmd submission memory to reso=
lve potential race conditions.</p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB522659C72ED024CE62496CFDFBF09BN9PR12MB5226namp_--
