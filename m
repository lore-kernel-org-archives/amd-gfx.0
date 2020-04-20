Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F55DC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 13:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118ED2070B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 13:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iWErdlJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118ED2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7046E558;
	Mon, 20 Apr 2020 13:14:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770075.outbound.protection.outlook.com [40.107.77.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF9C6E558
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 13:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbzwEE8YNYmNWN7LHpLWMUTv+3yEScPcUF6FopM6NXJJQ5h2bS+6pzJtzOFreDGXVZ9DQBpHf/+8mavd0iq8h2WoQkqWDHd8QS9kBsDWCwuAdOnA4/IQFTT2OY9MxGwYr0SWAtpvuQak8xf88162Gqd7RjC6gkhd+5pExHbL79iGN/gg8YY43u3UsheNL4OxtqrYrPBi9jKUBXvvkn0TlXFUT1qhfnMqfMGM/ogDXVqBYGbFTh1RQ/D9j3zt0rRrDzMHDuF+k/MrQWTRNygtkEH0SPhgM1XQEkShKt2zrS2GD9zmCfbe7NKp/FsQAvzYOcr2MPur0wUIw2ulSEzxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5/u11w11Ze/7avh3wmyHHTkhgd3PRdQfJJI7Kb1WgE=;
 b=Pz/FvtL1q17tE8U93YtF5YQMFS9SVy+DQ8Ac50RL4m6UILyAVTBGUdSKCLSUa6ncLKkS/vogyQxWDvDVBbZjIyHC6os+Pgm7uMxx5YOW21JX0Ymv6YHsNmN8alGCLkMzpvgZ8tjChDjk5Gd5E3VEEfm44418CA7V/zMzpfjxiWcxCO0qMzMMDu4xP0Tx1OCgZzZZD1OakelpuLPbvTgo5vTKTiDFtxGRgz9U+cwSj1+XzooDKuaLbOZ/b/2mCi7FtTVTN/Sy6XZ3pbvgkZbd2/L8KG5dwiRJeBf0amyivKjhcpb8hjl9SS7vSX72592K8ljpjY0iqGbxvr3SNqKkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5/u11w11Ze/7avh3wmyHHTkhgd3PRdQfJJI7Kb1WgE=;
 b=iWErdlJ7yLDxGqxmlVIPNMsYZQ3avq9GaW5HWqhd3aIXglcqPKsVuB8xKqbB54rCdnMzImMnjyZcoTt+UmXlGdj69SZIcecHrzW3HnLU7egImD4qSgF8Rqx1LRnXiBbZMHORVNuW6JMXgBVFO8pQ0e4+IkOJE3hIvvm7QRfFX7s=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3534.namprd12.prod.outlook.com (2603:10b6:208:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 13:14:14 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 13:14:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo@gmail.com>, amd-gfx mailing
 list <amd-gfx@lists.freedesktop.org>
Subject: Re: drm/amdgpu: add tiling flags from Mesa
Thread-Topic: drm/amdgpu: add tiling flags from Mesa
Thread-Index: AQHWFR3T3Y7G3ILKtUiYq8PuGJIJyqiCANqC
Date: Mon, 20 Apr 2020 13:14:13 +0000
Message-ID: <MN2PR12MB4488A1E959574A7590429E5EF7D40@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <CAAxE2A4YRokWUdNBhy_Tse4W51waGmrgjvs86XdZ0MNibXe+xw@mail.gmail.com>
In-Reply-To: <CAAxE2A4YRokWUdNBhy_Tse4W51waGmrgjvs86XdZ0MNibXe+xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-20T13:14:13.236Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.72.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b064a2b5-2891-44cd-6ad5-08d7e52cb8f0
x-ms-traffictypediagnostic: MN2PR12MB3534:
x-microsoft-antispam-prvs: <MN2PR12MB3534EF08DAA81B2F834DFC2BF7D40@MN2PR12MB3534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(71200400001)(9686003)(8676002)(5660300002)(55016002)(4744005)(81156014)(8936002)(33656002)(2906002)(19627405001)(86362001)(66476007)(7696005)(26005)(186003)(478600001)(52536014)(316002)(76116006)(66446008)(64756008)(66556008)(66946007)(110136005)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNvQJk+NRxr+HdR7KU8Lcdamn8nHI5itU9Z9RFiN4Y1dsVWhTaMkXZ1GGdvFg40hN95lXV1mKuIM9q90VEJlZPtMS33i8o/CaQQqoUr6/mRIiKO8x/GLXt+pFE7hEItxu6SRDo36Z/uM0XusRkvmiS0C6qDSieQw5lcOonBR0mXf88jA6M+6PCaEOMeHwh7tBHrz2BUTNC6TQupf8WbCeGoI5bn8rm+18H9jOO97uNieFDHpRphXestYHGtAOp/PCQ9qFl8jK9rQ/aJhUDCM5hh+FYwGqjlQuD9KThBFyJ1RggEZDulxXUd/3VLHrjcwcAyuDlZpU1F3OX09V7tKuyK/sw2QSe0Tb86P7yZ2HZsdP9EDHgCJdsB867ol3NqooRSjx655m9snIy61j2OcfXHMcCa1Xvx45brkAIUpc9xq0eIO09DN2Bk8SDj9NFXV
x-ms-exchange-antispam-messagedata: ITuKAnwlOChC+v7IIk+QG7W3Qf4nGTIoGclixXIoyAYNk6clC5wDZmqYZ7P+toraKCdzWUR1s4n5h1cf9xIxMYAIfUMlW8q6XIC+6gsZou+QfV/UwUvk/khAF3RJLZkMBIVdRx4Vkcg1NGQJtY6A7A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b064a2b5-2891-44cd-6ad5-08d7e52cb8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 13:14:13.8249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68m1RDNYAj46wl4S7AHVj9xgHepcBpLL/C6vDVHNub72JG8iB7pvq0mYPhu6S8l7J2LJBL/VCLGtYp+Ks6xrEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3534
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
Content-Type: multipart/mixed; boundary="===============1032297564=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1032297564==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488A1E959574A7590429E5EF7D40MN2PR12MB4488namp_"

--_000_MN2PR12MB4488A1E959574A7590429E5EF7D40MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Marek Ol=
=9A=E1k <maraeo@gmail.com>
Sent: Friday, April 17, 2020 9:06 PM
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Subject: drm/amdgpu: add tiling flags from Mesa

Hi,

This is needed for displayable DCC on gfx10. Mesa will add the first flag s=
oon or after DAL starts using it on gfx10.

Please review.

Thanks,
Marek

--_000_MN2PR12MB4488A1E959574A7590429E5EF7D40MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Marek Ol=9A=E1k &lt;maraeo@gm=
ail.com&gt;<br>
<b>Sent:</b> Friday, April 17, 2020 9:06 PM<br>
<b>To:</b> amd-gfx mailing list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> drm/amdgpu: add tiling flags from Mesa</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div>Hi,</div>
<div><br>
</div>
<div>This is needed for displayable DCC on gfx10. Mesa will add the first f=
lag soon or after DAL starts using it on gfx10.<br>
</div>
<div><br>
</div>
<div>Please review.</div>
<div><br>
</div>
<div>Thanks,</div>
<div>Marek<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488A1E959574A7590429E5EF7D40MN2PR12MB4488namp_--

--===============1032297564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1032297564==--
