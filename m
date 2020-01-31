Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C8AC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 19:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3CF20707
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 19:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CxKEKXTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3CF20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C2D6E9E6;
	Fri, 31 Jan 2020 19:05:13 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760059.outbound.protection.outlook.com [40.107.76.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB026E9E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 19:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3foRnQPGvPdur42yLWLwyih8+kn4Z7pwhdOPaUrdM6bootQrK2HNQV04SimGJ1/wBnb5N9w5/ALTfGyfxbUCRS94jEkmLtPd376vskaKHzTQIBwqnP/2gzSL/yrdzV2kxjkC0bB/57XXXH320GDW6tRHOpma62kuXjFXrKF585jJRM5cT1V0uWtUn7gOyhuYoC3S6bxtZbGjQu1Ip6+hsFKlx88iel0/n+e4qtTgd2avbiRaMOMKImTyTgzhBOcdEaHCsBikGl6cXyBIu9f9CQO/i1ApRtw71CZUiZeD2m9NMSiNHG3jszB04BQTbh9h52GRV3M2S6YWeubuhSbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAWKbcLGAvQo9mKAoY+wMKmnYKeGVlrPUc1txDoMlUU=;
 b=D7IzOI3F4MNu+2lSmoV12RLKYRY/L5jmvlIbOBOxKYul/Sx40LeclWttjcoNsvV/6mZUzYaXOv+J1LckRBFMZ+NUWdFGS8Ir14LEW3/ZSWSEOPTtQnY3GE1aJrXxrqGrQME4O9eGZUOEXzFqjlf84TuCF8MZFWM+5vZMWrm7r3LFmsTB1jJXV2XGIxfYpnZ6zH27usRWQrlkmSIE7uqGlUc00M10QSX48fIUXGO6zSmaixI6Di1dUvPRbw/9yFxjBJ9xJ01zhPxVb4xnNaR/9msiLIVZPhte08AZWBn8Ja+ri1fcTw+20QzcahpZg1RfeUIdwPxoRdjJJioarJxpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAWKbcLGAvQo9mKAoY+wMKmnYKeGVlrPUc1txDoMlUU=;
 b=CxKEKXTK1WSxsbHnsAKtSSaLK5N9MvcvPmCvwo2hwraTTr+nyDnFtoar/He/sX9Nx7PyQDv4Mbld1EjY96913Oqa8JZzOHeugHC+MPC7vmMchu/cPpj2i+UeIkjuy0V5zrSRUicQi8E+Zlm7UGAtBNu/QbzaDspM7zYTiWrknyE=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB4037.namprd12.prod.outlook.com (20.180.17.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Fri, 31 Jan 2020 19:05:10 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2686.025; Fri, 31 Jan 2020
 19:05:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Josh Fuhs
 <Joshua.Fuhs@pm.me>
Subject: Re: Asking for Direction
Thread-Topic: Asking for Direction
Thread-Index: AQHV2F/rvvj9xxlV+06keFcyEgy3XagFId4B
Date: Fri, 31 Jan 2020 19:05:09 +0000
Message-ID: <CH2PR12MB391261E5E0B4ED644B27F85DF7070@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <_a89rdMCBfe551EYsOQQ9AS8gdX2eNTS9VmWelbIZo6asP2FTaRqmNsPHEluPZ6wLVCDUqQIHYiHMQbNsen89RQjb_R4LfpmApIdOjf2fNM=@pm.me>
In-Reply-To: <_a89rdMCBfe551EYsOQQ9AS8gdX2eNTS9VmWelbIZo6asP2FTaRqmNsPHEluPZ6wLVCDUqQIHYiHMQbNsen89RQjb_R4LfpmApIdOjf2fNM=@pm.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-31T19:05:09.443Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bb3ec37-6180-40e3-0ce7-08d7a6807e45
x-ms-traffictypediagnostic: CH2PR12MB4037:
x-microsoft-antispam-prvs: <CH2PR12MB4037EBCBBD449673917C30F0F7070@CH2PR12MB4037.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(316002)(64756008)(66446008)(66476007)(86362001)(19627405001)(66574012)(3480700007)(110136005)(66556008)(9686003)(55016002)(76116006)(33656002)(81156014)(2906002)(81166006)(7116003)(66946007)(8936002)(8676002)(478600001)(26005)(186003)(7696005)(5660300002)(52536014)(71200400001)(53546011)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4037;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ImxR2KqSC7FU0YcWRakJEhPcLzT6cmWGNIf/0dl4bNwJr+XqpGTSB2afGOm2KXM7pB3lAqeX1CDWNTY3wYO/iYOt3JVoUN3Px9UN8+KEJZGVXNLTMxHh7y8zsgHwAdyP45E9kCc8c18chsxB2odI/IC2eDnXRULCgeFD279iEqA9TfK9vzjFuadcmNNUJZPIULsolt31iISWbtlGAQPgmbs7truW0HIc0xMPzQwlF8qsvTG3SQJpH6Wjr/vCSLQpArTbBsoIf2/tDqFmF1l4QLYFbeVSPYWsb5312GCSFRUOTrgidrHlhXhzXDzBki6pPl3fgW5gOZPo+bK02sWVaXynjdNLE8N/CHdzWWwD+xQueLaj6B7uK9WHuE3tAQeLQSY8dFHLheOTfaJDToN+anu3KICy/eNQcAsl0/6Yw2S9Jbf8ablzqmoXsfMLCdAw
x-ms-exchange-antispam-messagedata: ZBJgNLwkEZd/N21/oe+PzGwyWJSH5C4ZbySUsxu8bqDWZmCpWtIsXkCRQqizYYA+VsFwy5HLTe3SIpLmQ0SNj1q9QWlzDBrKKK9/TcZjjQ+Vpq7WKYnCcJoiAtGin3DzhiZ2YeWpTtBmEQOLlGaAoQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb3ec37-6180-40e3-0ce7-08d7a6807e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 19:05:09.9654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVsKj4T5w5310AwlKycK2jwcu+PUeVy1CKVOmfSG6Gaew6bNNra1EwkzOuJpVLPPqaA606SU6OUYkMbOK0kzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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
Content-Type: multipart/mixed; boundary="===============1788465859=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1788465859==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB391261E5E0B4ED644B27F85DF7070CH2PR12MB3912namp_"

--_000_CH2PR12MB391261E5E0B4ED644B27F85DF7070CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please make sure your kernel has this patch:

commit 46203a508f64b4bfa150a9d25eab1dc891e7e650
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Tue Oct 29 17:14:15 2019 -0400

    drm/amdgpu/gmc10: properly set BANK_SELECT and FRAGMENT_SIZE

    These were not aligned for optimal performance for GPUVM.

    Acked-by: Christian K=F6nig <christian.koenig@amd.com>
    Reviewed-by: Tianci Yin <tianci.yin@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Josh Fuh=
s <Joshua.Fuhs@pm.me>
Sent: Friday, January 31, 2020 12:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Asking for Direction

Hi all,

I am trying to use a Radeon RX 5700XT via OpenCL with kernel 5.3.0 (I have =
also tried kernel 5.3.18) on Ubuntu 18.04. I have noticed that this combina=
tion is much slower than expected. I'm trying to find out why, and how to f=
ix it.

If I'm in the wrong place to ask, would you be able to point me in the righ=
t direction?



If this is a known outstanding problem, a reference to a bug or something e=
lse that would let me dig into it would be great.

Thanks

Josh Fuhs

--_000_CH2PR12MB391261E5E0B4ED644B27F85DF7070CH2PR12MB3912namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please make sure your kernel has this patch:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>commit 46203a508f64b4bfa150a9d25eab1dc891e7e650<br>
</span>
<div>Author: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div>Date: &nbsp; Tue Oct 29 17:14:15 2019 -0400<br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; drm/amdgpu/gmc10: properly set BANK_SELECT and FRAGMENT_=
SIZE<br>
</div>
<div>&nbsp; &nbsp; <br>
</div>
<div>&nbsp; &nbsp; These were not aligned for optimal performance for GPUVM=
.<br>
</div>
<div>&nbsp; &nbsp; <br>
</div>
<div>&nbsp; &nbsp; Acked-by: Christian K=F6nig &lt;christian.koenig@amd.com=
&gt;<br>
</div>
<div>&nbsp; &nbsp; Reviewed-by: Tianci Yin &lt;tianci.yin@amd.com&gt;<br>
</div>
<div>&nbsp; &nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.co=
m&gt;<br>
</div>
<div><br>
</div>
<span></span>Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Josh Fuhs &lt;Joshua.Fuhs@pm.=
me&gt;<br>
<b>Sent:</b> Friday, January 31, 2020 12:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Asking for Direction</font>
<div>&nbsp;</div>
</div>
<div>
<div>Hi all,<br>
<br>
I am trying to use a Radeon RX 5700XT via OpenCL with kernel 5.3.0 (I have =
also tried kernel 5.3.18) on Ubuntu 18.04. I have noticed that this combina=
tion is much slower than expected. I'm trying to find out why, and how to f=
ix it.<br>
<br>
If I'm in the wrong place to ask, would you be able to point me in the righ=
t direction?<br>
</div>
<div class=3D"x_protonmail_signature_block x_protonmail_signature_block-emp=
ty">
<div class=3D"x_protonmail_signature_block-user x_protonmail_signature_bloc=
k-empty">
<br>
</div>
<div class=3D"x_protonmail_signature_block-proton x_protonmail_signature_bl=
ock-empty">
<br>
</div>
</div>
<div><br>
If this is a known outstanding problem, a reference to a bug or something e=
lse that would let me dig into it would be great.<br>
<br>
Thanks<br>
<br>
Josh Fuhs<br>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB391261E5E0B4ED644B27F85DF7070CH2PR12MB3912namp_--

--===============1788465859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1788465859==--
