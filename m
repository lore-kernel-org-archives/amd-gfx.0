Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C65AC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 13:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADAF60EE8
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 13:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3ADAF60EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037EC6E86E;
	Tue,  3 Aug 2021 13:58:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA92F6E203
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 13:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrhl5DurkHKkMlTitw6ZAxsOZ5528uJnCbzaMu0EqOT1xYe37gzs4KtHfdMDI+d3IGvvhn1jyoZSTehNw00I7eIbsGR8+/ek+EtdR1yIIo85vpo5grOd2G3BwK7uN5x1jLa8GI7ffMeK+l1fjVgg8qqcuob2qjRFQjqWMkjiharFsSjuzfc2HNKBGqjG7vziL2d0i5kVP8pjlakFGx4EhTBBjIhTia8w7pBaP1fqJXrFsE5jogw2y72PPGt9RnEjcWAxMTUY7CZFdjPU03vDenyZbRdTuKVOjvnp+nhkzDdrw/EsoIUcQKAS2LRKr/NaK3Ss8ladJJxmvVvikmLZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtidfQNVvp6yHkRVI4IQUGk8OdjnyallvgccgFDXWzY=;
 b=hCXb5AMMEa7qZm/ilkbNZmagPTf32JKM6IKgkZTnHtLt2uVx9/n51vFUJDleY6vtzKBRIfoZDpVjmZYjY6nL6Ty/LZ9RpCsd5J/gq77N4GRM+i3xzqmY1mXX3WN3O7i3WRZ9nZh5to/fH+9KWKAfJW2D5BAyWemtdOUfUfY6uhcXl7sxPEozQMo+rnfEC+A8WGbGGm8QE2pkpkEb+yRTDfqRegeCCZQEDwWv6DdxIcVcgsh/ikfS4YevQhh0fSxto91INCagoqN7uQCJlf39wQd8sNyFw7s/5yW639jRc8yjNsOq0JCIS/QPYjvry1MDFpe9q2eeC2buchcGDBMBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtidfQNVvp6yHkRVI4IQUGk8OdjnyallvgccgFDXWzY=;
 b=TcSWRJNMW0hjbXtZuDIaDyzuvbE4DAezQ1zUqelnPPieOFFJ+b9PjtYz/5ov02CYCRkmXjD/rZCmZ43igzL6WxHrHmT9iokJAXXVN8dUJnzb3NcvtMgmtM4Ow6sfC0WXZ6xFXWooeNqCmE/7vm92LrTtp1yuMqAk4vrgPtFFoik=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB2506.namprd12.prod.outlook.com (2603:10b6:3:e7::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.22; Tue, 3 Aug 2021 13:58:30 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 13:58:29 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Topic: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Index: AdeITLg7attLKh5xSlmEVfidPAvHswAIhHnw
Date: Tue, 3 Aug 2021 13:58:29 +0000
Message-ID: <DM5PR12MB24697166AD67A6E7A60718AAF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <BN9PR12MB52265FFACD0557EC17C4FAE6FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52265FFACD0557EC17C4FAE6FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T13:58:27Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=623c2193-541a-4c8b-9b01-b34a9127cd24;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d60398a0-ba0b-4184-3eb0-08d95686c629
x-ms-traffictypediagnostic: DM5PR1201MB2506:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB25062AD7FF422CB7E4871652F1F09@DM5PR1201MB2506.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ry0Lrnbj4mq5yLQutPI/8b0/ymdOBBWLiAyW6bCYkAbXIHEDPafTDO8RyXAQCbXTqScuxOADNtHiqoU809NjR9cQJmI+oAVCsnPpGQD0MIDlgn5xK08mFPfq6RbgNj4NiFoizXgq83GrEW7eUXNOgPN0ETaDVnxVH7dAGwH2z20LqvBvj80e4TZvcErpdIVV96bCIneB+VKcBwZF8YyUIDmUoIlsCRrwwLxPrzuX1Gq6ki4CbGGIhbW8fit45CH8Z83JLOq+t4DInCOYNVNNCzNfARCYMlQFY+gxoBGPOa3IVqwikSCIGlmO7a8R8SPnG7MPDVGJbova3tlD+DZZaANAT0qUWWYDqkxS1q/KhUXq2HiIks7nwgLAwR2+p3CSY4hrDXGuSiN+S4dDhR63iyoFBYAbft2vgo0tK7XoWfYHUq3kBegsoXLmO0H0FIgSJ8DPP00fLvBJB0wo1Rwco9n+gBf41uaKAVXd3bTPTHr85axLHuEdeGXioBDPIA9FSgVT7+dtP8fUraCBmeqYLoAd13X8WFTX8PlS2tI8lbPUiPwaiL/5QfDHtSWnLN9yPTpMhqYfv3lhii6bSjRa5bA6XYEv2yhPJj+56YTrnsyC9icMHb+Uwcrb4CmmZpbZ1m2FK8Tkmwa4fT6sbpCSrWdpzud8QFbGWHdlmfVambBy57hYgNl/5wh9Qr1+AkikrAg2TXThW4yLNMrHkldO1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(8676002)(55016002)(316002)(478600001)(2906002)(186003)(54906003)(52536014)(4744005)(66556008)(66476007)(110136005)(66446008)(8936002)(64756008)(9686003)(122000001)(38100700002)(33656002)(76116006)(66946007)(4326008)(26005)(83380400001)(7696005)(53546011)(5660300002)(71200400001)(38070700005)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8eCMaqF3C8jitXe8dt44iawJ5wR04m+hgQWwXXB38AgwFW8UMechdc2FbPpM?=
 =?us-ascii?Q?0T3NbK9TMuhpfCAQPdxJlrSWvM2SrC9MlGDjhC39zYataiH4435WUrmYqvyI?=
 =?us-ascii?Q?ITUVD6LPbAQjJ2Lx27BQHvA3oy2myr21SBP0UxcO+ywfgSsvGyr9YEFfUAzV?=
 =?us-ascii?Q?t+BD1tv2lOIhFwjpu+AauY83Yb9x30h181tmDYl5MQXU4ffBKk4EdfvbuUsa?=
 =?us-ascii?Q?wMFCun3r99+/0hky1mWyubpMmFH4odWruVO0ZgobmPODxWOG/A9nKi2OhjW0?=
 =?us-ascii?Q?5EVbUNwG9K9HGIIqg4Dlz8y8gxvGgw3x9P3Ke/D4ALPMdQRi+0MkCPKw+TuX?=
 =?us-ascii?Q?pNWrkhWVB8CEamwlM5xfeG+6RNCCoyNXbIraDrQKCh2nSF1lxMSRa8z++bNS?=
 =?us-ascii?Q?baf2dqWj7Nab+0yzKkR71Lj8ASc7tx2m4UDcK0icmo5hdIUMMbB0rheeFnOP?=
 =?us-ascii?Q?QoKsTjEK5/shCAhV6ymsNKC+OwqzfMvBAGrSPeVtuuK46hsb16acpeHjsyMA?=
 =?us-ascii?Q?y2qrpXjZeds59OhmRxAqTSHR1ZFFRjILs4iyijdM8p8ApONscT7kP6daeU+T?=
 =?us-ascii?Q?SuHPfaR0If2BYvgDNeZlmDHBMQkBV06qc5OxAwlP9Lc/AhsET/pJatjIlwZJ?=
 =?us-ascii?Q?U95kR7IRCZ7eLV2YtnG9NcAulMU5E4kqUaexIr6mAfgtauDQisjylV9+5+Am?=
 =?us-ascii?Q?4uDmuMDm7QTLU8VNHt/0t4gPR0yFuhRG1EAe8lSMrU+DTpGY+Y08Qyl/ZJok?=
 =?us-ascii?Q?tBHhKolelzYJEId8BWxS9M42RsCO33R30/EorYyVj4lBjD7FDRBjiD44vv7k?=
 =?us-ascii?Q?9rCXQAUaSC2XqTHZtcXy2SgngVFxRLv2N87emlTslv9m19ac170BjeIg35fw?=
 =?us-ascii?Q?doLeIHs4MeNUeoDLuaxseLkL3RbTW0ZNNbJGpfLspTzpVDQDl1FYWcPRNhcJ?=
 =?us-ascii?Q?fOXsqSXc1TW8OBpX38TFazVM0LHa7iLi1Fv1yc4Ep6iDuq2NNWciLWak2SMj?=
 =?us-ascii?Q?eL6dSNvH4kl4mrZsYqW+BXxgMeMk528qx1313MCeNZ5Y8UvvDhl6X/ujXLaP?=
 =?us-ascii?Q?i3tBcryCH1T2PAFZH4S+Zae95rG53oH745E2GbNgQmYzheXZ4rKphsQnwsFb?=
 =?us-ascii?Q?ucCCpHZApGI6RXAFepevbPP2FBxe7zsbTHTWfbt2uax26rJucCYFf4nLCvy4?=
 =?us-ascii?Q?PTybV58AmeFN2GCmq1YV7mh1GehZ1V1Dg9cEIOZu1Cl9LvskMRP7Ze688Rgo?=
 =?us-ascii?Q?5y4T1QRi1LmrEQpqqMCKRt+YglBAsx8h9nCxLYXPpqubp6FsIp5fwp4yN1Yx?=
 =?us-ascii?Q?gwOjF9FoWTuETXsV3wuGnH1y?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB24697166AD67A6E7A60718AAF1F09DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60398a0-ba0b-4184-3eb0-08d95686c629
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 13:58:29.8165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJ1RtRp2ZObCDRay7NuAvvmuS8QZt4h9/j1GY88iHWXOucQA4Us8Bcp6UIcZj+Y/Gh73TN7rpRWJ2IpFR+E8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2506
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

--_000_DM5PR12MB24697166AD67A6E7A60718AAF1F09DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_DM5PR12MB24697166AD67A6E7A60718AAF1F09DM5PR12MB2469namp_
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
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
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
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Before calling into psp_cmd_submit_buf, a mutex psp-=
&gt;cmd_buf_mutex is there, and after entering psp_cmd_submit_buf, there is=
 another mutex psp-&gt;mutex, is it a bit redundant?<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, August 3, 2021 5:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Chen, Guchun =
&lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: added synchronization for psp cmd buf a=
ccess<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to synchronize access to psp cmd su=
bmission memory to resolve potential race conditions.<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB24697166AD67A6E7A60718AAF1F09DM5PR12MB2469namp_--
