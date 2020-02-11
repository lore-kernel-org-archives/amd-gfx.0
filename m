Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB4C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5860120714
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZksN/hpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5860120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7426EE6E;
	Tue, 11 Feb 2020 14:29:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0ED6EE70
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 14:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMJi2YCVkf+6NZfh9E7AIXpWBQD6MIED+Leb2QbxhE5KRT1FQl4eNkQ12+krviPicFJDY9oZays/iCAIU5gCWRVNIvHU+vtvmncQFcNJHkCWkPmFyoiai5kFIAv0EHZX1IYKom8RIKj194gq6B2EWYrjtoc9iNcOFGLcyuAYruGepVTgqDSJqjLOLPzl8JP1wS//IGPsOIBBjVIWZCbIQSsnCNPi7Wp99z8Ag1Ys7S6XAbhmVC3NUs2y4XU7eFiEpdAdxFKu4VFH0dWh++NAkxJlHvBdw2P/Cy2c0G+LKubxorN4tVPGtpdD8KQKidiIjOaoSTC0VNYhuJKhaKaCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqatKQhpdRYnH8lVZudSulJOOwEgUav/RFEFcPqp5w0=;
 b=Ne1w2pkhgHefFk3ikowBAAYFRo1Y6ifEiRNQktZ4F4jwY/kH8rVBw7P/B1gI5A7NNI7k4RNC6vaewW2VTpPicQhzrbt8PI2QRDQAv5gkUN+TnMOE9QuoPJhmT7InVsbaznWcYuBWoT/kx5HNOrBEfUCBoHBVA+a6IS/6omJ+O8df3o0b1j5tRWSvJRwmsVUpF5NroOaWPalZGfQd3oLF0+mC9qMhtFybhBCILD/6l2/RdOA9w8k6ORzWKVwmbywJ6RGHw7f2vz0xbxKczovTrSIgH+KK3pQhPtbWLgXGfO9cHbyrVQTyep7lHO3n78PthTqsVj1M+AXgD7T7l61BOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqatKQhpdRYnH8lVZudSulJOOwEgUav/RFEFcPqp5w0=;
 b=ZksN/hpooMg1I7Wg7Hj3LtPkplhgg33gY0iz44bHOAMw5VL8ac6VpHP1ytScHtvOV/PQDR1AkrUXEXgITA9FGoSyM77uM0JVMMhc8qD1+jKH6Bwcdh3+N+GTfuAvBMTzIgy2RgV/inntFTu1ON03e8p008K+sIyYue+uiHemc5Y=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB4328.namprd12.prod.outlook.com (20.180.6.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 14:29:38 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:29:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu
 tests
Thread-Topic: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu
 tests
Thread-Index: AQHV4M2dMDJ+Dd/Zb0Oh6MhZzzoHHKgV3juAgAAvYbo=
Date: Tue, 11 Feb 2020 14:29:38 +0000
Message-ID: <CH2PR12MB39128F0E67FFB7E60C16B1ADF7180@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <1581420183-14223-1-git-send-email-ray.huang@amd.com>,
 <a54f6008-918a-dbf6-0000-f2f048cdaaff@gmail.com>
In-Reply-To: <a54f6008-918a-dbf6-0000-f2f048cdaaff@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-11T14:29:37.202Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 079bcaaa-6b7a-425d-9094-08d7aefed310
x-ms-traffictypediagnostic: CH2PR12MB4328:|CH2PR12MB4328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4328A9ED0EF29BF5E35B436FF7180@CH2PR12MB4328.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(8676002)(81156014)(55016002)(6506007)(53546011)(9686003)(186003)(7696005)(81166006)(8936002)(26005)(66574012)(71200400001)(2906002)(478600001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(33656002)(54906003)(19627405001)(52536014)(110136005)(5660300002)(316002)(4326008)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4328;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z16YwoDCBi9/WQmcakdPgXK7RNQI9rCUFL5E1FqcIMPPpxYhxfBEfNN82nBpJm+DX3xlVEGvRw8BEdvccWQO4EX1THHH1LKAh7v9pr2m2sVJlgOEVi7CSx472bhD+U+kOh1//rIzO2ElIvubXfsZ0cxCw4PyhAecBFd81adC7JEDKLxml1xrxOU9xSQNbeICBczs6uFXrG0uC4MiN/IKNpTbbmwf+jXEYWMEOrO6UQVE5QRwXSxmq04FWgCvablSsU7qiFH/3gdrxNaXvBrocmzdC21EwH/cMTBBOC+xoMR3VX7PqfVALifpbg7Wt/r14uxc/eU/TwhXsu+bvQlz0uFPA/3RO2L972oNWWpJ3RBEYT6BUu3tBSL41ZmIhd/R+hWrgilOUCmzLpowi/3lo38zTcpmVWGuDc3U3jEWQx0MpOBhZ/uiQyyk0IndGJK3
x-ms-exchange-antispam-messagedata: MDPtokX+py7DeIvvhviznzuCNK7FniYh3qaU2B7ik6QLN/RUWpwp05Pp9UoRPpcTl+EpXAXxTe3oy4bd0lVwARhmFrarJk7aTov144iTZFGE3CUDFl6OCFoYpaUVLApvt+GDel4ZpdyBJOUL6cLsbg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079bcaaa-6b7a-425d-9094-08d7aefed310
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 14:29:38.0349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: at89zFQMd1boHU62mgzmHQQ0UBWvTHEgy5qUFtRryP6zUTTaPRDGvZsEL1wahd6napDhMUxKgzK1Id9GkjNNGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============2047160900=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2047160900==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB39128F0E67FFB7E60C16B1ADF7180CH2PR12MB3912namp_"

--_000_CH2PR12MB39128F0E67FFB7E60C16B1ADF7180CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Also, libdrm changes should go through a gitlab MR now.

Alex

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, February 11, 2020 6:39 AM
To: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Olsak=
, Marek <Marek.Olsak@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Tuikov, Lube=
n <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; K=
oenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgp=
u tests

Looks good on first glance, but Marek and/or Pierre can probably better
judge than me.

Christian.

Am 11.02.20 um 12:22 schrieb Huang Rui:
> So far, the amdgpu_cs_submit_raw2 is used for MesaGL, however the amdgpu =
tests
> still use the legacy interface. So we would like to make amdgpu tests ver=
ify the
> amdgpu_cs_submit_raw2 API.
>
> Thanks,
> Ray
>
> Huang Rui (4):
>    amdgpu: use alloca for dependencies and sem_dependencies
>    amdgpu: use amdgpu_cs_submit_raw2 in amdgpu_cs_submit
>    amdgpu: remove the un-used chunk_array
>    amdgpu: clean up the cs structure variable
>
>   amdgpu/amdgpu_cs.c | 36 +++++++++++++-----------------------
>   1 file changed, 13 insertions(+), 23 deletions(-)
>


--_000_CH2PR12MB39128F0E67FFB7E60C16B1ADF7180CH2PR12MB3912namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Also, libdrm changes should go through a gitlab MR now.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, February 11, 2020 6:39 AM<br>
<b>To:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Pelloux-prayer, Pierre-eric &lt;Pierre-eric.Pelloux-prayer@amd.c=
om&gt;; Olsak, Marek &lt;Marek.Olsak@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@=
amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@=
amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 fo=
r amdgpu tests</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Looks good on first glance, but Marek and/or Pierr=
e can probably better
<br>
judge than me.<br>
<br>
Christian.<br>
<br>
Am 11.02.20 um 12:22 schrieb Huang Rui:<br>
&gt; So far, the amdgpu_cs_submit_raw2 is used for MesaGL, however the amdg=
pu tests<br>
&gt; still use the legacy interface. So we would like to make amdgpu tests =
verify the<br>
&gt; amdgpu_cs_submit_raw2 API.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Ray<br>
&gt;<br>
&gt; Huang Rui (4):<br>
&gt;&nbsp;&nbsp;&nbsp; amdgpu: use alloca for dependencies and sem_dependen=
cies<br>
&gt;&nbsp;&nbsp;&nbsp; amdgpu: use amdgpu_cs_submit_raw2 in amdgpu_cs_submi=
t<br>
&gt;&nbsp;&nbsp;&nbsp; amdgpu: remove the un-used chunk_array<br>
&gt;&nbsp;&nbsp;&nbsp; amdgpu: clean up the cs structure variable<br>
&gt;<br>
&gt;&nbsp;&nbsp; amdgpu/amdgpu_cs.c | 36 &#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;-----------------------<br>
&gt;&nbsp;&nbsp; 1 file changed, 13 insertions(&#43;), 23 deletions(-)<br>
&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB39128F0E67FFB7E60C16B1ADF7180CH2PR12MB3912namp_--

--===============2047160900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2047160900==--
