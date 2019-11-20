Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A6BC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 18:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5127920721
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 18:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5127920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC22E6E9EF;
	Wed, 20 Nov 2019 18:49:56 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730084.outbound.protection.outlook.com [40.107.73.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412546E9EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 18:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImDvOGh//Mdas3Nd9TUK3VX9PWd53UD0NsnM4lIEJ/8el9BpfHyJ98ig5cXXj6hDm4R2Dzf/75Q55ZdsXoGb9I+E8Ud0ZN2VH+BLRIeadb/h+1971ID19EYeFH+PhJGLMACbVR92r7PBHlJcLowjn3jInJWWnoLsaa1PHAxtDLmbh0ZezOzIqcO9tzBZ4NkR3Dfi2M0KA1T2+aGP7l5/v9DPID4fwK5dMUwQ6XWqq0f3Kj/II7gbkq7aOTCm4OC8/7BKuHSQe262EgD4iry9Qez4xT9leFPgf09rw6yO98ai89MD56PVXnjCGmqGC9+qBtj+VXyZvU38oPGpbo3GXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q92ZvFs76aTVqw6Bd1VfrxH+gwtC7D6xbhG0hjQ56Ag=;
 b=dK7eQh2mpnnse6KaJLZ35e1C4rgq6H5hIY9yVjn4JUZcSAufvdS1b/Ko96Eq+eoY+XRMY+B6wj/TsoNEQClhjCLAKVGuieJwk/zudM7WkSe3lMkHqZbUZApvkEJ6NyHyyck77zBI5KoakD4CIkBk5+4wqfaRhK48VCO6UdvnsdadHT75z74KGAaK+RIhMk6JgM6DJMDERdljri9ViTDqTvf9Dlk3ZepzqIczn6K2zLWgSYfGN6kjVq7jmVNDVDSXtRQSPgVvEcQk9kWFxCZS1bEZ+ja+IMFNXqznfdx6iPC5X6JPyAe4ZBXX7RHP29iCe0TXi2AcM8vT2zv8elrITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1590.namprd12.prod.outlook.com (10.172.69.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 18:49:52 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 18:49:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-3?Q?Yusuf_Alt=B9parmak?= <yusufalti1997@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: AMD e9171 linux driver
Thread-Topic: AMD e9171 linux driver
Thread-Index: AQHVn8SVfsEQT9xo4EWsNKT7Jpnx3aeUZu3N
Date: Wed, 20 Nov 2019 18:49:52 +0000
Message-ID:
 <CY4PR12MB18133FB0A527DCF440ABD5A4F74F0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <CAGzVRjwf9Zo+i_L7rgZKV2oEXqXbMNK1e-z41Tpu+TzsyzfVOQ@mail.gmail.com>
In-Reply-To: <CAGzVRjwf9Zo+i_L7rgZKV2oEXqXbMNK1e-z41Tpu+TzsyzfVOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 471a030d-b851-4ada-9748-08d76dea6dcf
x-ms-traffictypediagnostic: CY4PR12MB1590:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR12MB15906DB57F99C0F5493A6F10F74F0@CY4PR12MB1590.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(199004)(189003)(64756008)(316002)(8936002)(74316002)(7736002)(110136005)(19627405001)(8676002)(81156014)(81166006)(606006)(71190400001)(71200400001)(14454004)(4744005)(2501003)(256004)(446003)(11346002)(54896002)(6306002)(476003)(55016002)(486006)(236005)(9686003)(99286004)(6246003)(33656002)(105004)(229853002)(2906002)(3846002)(52536014)(6506007)(5660300002)(66066001)(6436002)(66946007)(76116006)(66476007)(26005)(53546011)(76176011)(7696005)(102836004)(86362001)(25786009)(6116002)(66446008)(478600001)(186003)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1590;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MCzY/rPrjwD8SMJullWznrsAAvSk74yXMT09yUDHXoT24oLADoSIjv5YBubrqdCyJnRltgX2e+EGsIRMCjNd/xu9SO3xMLSt5o5kD2tCQdwgWWfvqsfQZgvH/wYVewEw+UjSaR6jQ0EB8xbWLskcmzUvbmWA2Y4ffBDnWyIRFgAUN/S37XDXRGvYKJVmk9QA0EnRbSTJIQ4rtkxIm3Oe03idm7LlYkWqI6HPYqd6p0t67xwL6f5l/nFWqn0KAWHX6EKU6dUCdqxJ9FXwDYFlIOdwozPLAPycf3RDt1QqJ3P6PE8f0h1gd7iJUlDRk6hFjX6Ou1DpmYYBjV5ZuaK1heEGt/Qj/lJAGdu0TwvfXTOeJxKo/p61ejr+I261As8RslB40sYcvaeUPAWO4Wim4P55SD0Mj98FkgIYJJzUbGEv8pfUa0yNjHO/2E8HPb7Z4GsZt1MOA4fibulhpDK1oA+TKvM42icb/jmVo0WBsFw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471a030d-b851-4ada-9748-08d76dea6dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 18:49:52.6821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Qz2qlitfeOjrA6aDFeFly4jim6Iebb9LsdEOiIfnsQevFeZcZjvOGAOKHDUdZXdS7hzdtBeRkpgR1GN5/rtkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1590
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q92ZvFs76aTVqw6Bd1VfrxH+gwtC7D6xbhG0hjQ56Ag=;
 b=nNR0+Xrtu/XsLHgieWB5hMMzXqUqkPk2GmNpxEM+1fVaPH3C/4ElFr2rDB0VX6LAn/W1ZGcGBZG3cMrMRQXdF7X8KzrRBn0gy1iPdjpDXaSxXm+OqaGuf0KqFlIVVEGASrSv6ObbgzhfmomP9GZdhkjS6BJNAUjf7qDs4e8MaRw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1391841496=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120184952.UcdC3gcn8djO9crqSULB-HMpiwK1aq7E79rsC9_pmxc@z>

--===============1391841496==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB18133FB0A527DCF440ABD5A4F74F0CY4PR12MB1813namp_"

--_000_CY4PR12MB18133FB0A527DCF440ABD5A4F74F0CY4PR12MB1813namp_
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable

Yes amdgpu will work.  the e9171 is polaris based.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yusuf Al=
t=B9parmak <yusufalti1997@gmail.com>
Sent: Wednesday, November 20, 2019 12:04 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: AMD e9171 linux driver

Hello,

I have simple question. I want to use e9171 with my embedded t1042d4rdb-64b=
 board. Does linux kernel provide a driver for e9171? More specific, does '=
amdgpu'(https://github.com/torvalds/linux/tree/master/drivers/gpu/drm/amd) =
provides driver for e9171 ?

Best regards

--_000_CY4PR12MB18133FB0A527DCF440ABD5A4F74F0CY4PR12MB1813namp_
Content-Type: text/html; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
3">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yes amdgpu will work.&nbsp; the e9171 is polaris based.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yusuf Alt=B9parmak &lt;yusufa=
lti1997@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, November 20, 2019 12:04 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> AMD e9171 linux driver</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Hello,
<div><br>
</div>
<div>I have simple question. I want to use e9171 with my embedded t1042d4rd=
b-64b board. Does linux kernel provide a driver for e9171? More specific, d=
oes 'amdgpu'(<a href=3D"https://github.com/torvalds/linux/tree/master/drive=
rs/gpu/drm/amd">https://github.com/torvalds/linux/tree/master/drivers/gpu/d=
rm/amd</a>)
 provides driver for e9171 ?</div>
<div><br>
</div>
<div>Best regards</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB18133FB0A527DCF440ABD5A4F74F0CY4PR12MB1813namp_--

--===============1391841496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1391841496==--
