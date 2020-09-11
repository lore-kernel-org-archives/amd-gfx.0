Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBDDC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 06:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD1E20735
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 06:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WE8h/AXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD1E20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBCF56E2E9;
	Fri, 11 Sep 2020 06:02:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B30A6E2E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 06:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y73JeSiEv19MAuLuxBG6tnLMA9alZm/14a1d1NwDW3s8OPFZWMm2vF9D1YVsI9bna4RTvrMEfX1Y4kQ1QJsTQNcvL77gVcDi6mCQiSEvoG3R2dn05JHu8JTQct4mRmkFsNgonv/CtKbdPcihFnE0UTUw8tikfNcnW6HAUl/RMIeFCAyX9VuxKbfU4F+YeKNRgQmZE9FtP22W0uRKAsoFcvuQdkWoWmv664tJQ7dQi6UPncxGW4FqUkOi6EYGMqDabIHpwGa/HTkwNqd2V/ymA2dpaIbkJIiMvj6WXT8saFwDuJ6BP0fs8ZBl7l3M57pW2YSOw9YVkzidUlLn9zYx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuNH+DndJ4k3EBfD+IDia0w0FrpNCzKQDjqWMHgth5w=;
 b=RZmwTkbpIL5q6ZdQnNoS7qUTv4N2+ZRL+XcCg1VynV3/AwZShvSaL26P2Xl6dg//35bH+oCxgF/rj3az96R8/iLjB6Lvver49sT/mwI9HPXCgxerjf66aq1OB7r5MhTn+5ZxITfyrztd+z2IneFT3vdYzB3JTjibg+7Ta4NWRWXbsa42kSyCwOF6noUdW1QkW4Z6R5SxhLeDiBcQ9Dk4Bogg7UvjO+UDeJ+ZEuMGBJv81cOEvxNbXBFF+dFhoieI5YuQbexhuIxXjiMeQfhXlLV6IakztwPjEvuioUbnGD9UqH4DvvIE9zKfM+2JoJ6nxL+VZU7lv/66yJAoKUfp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuNH+DndJ4k3EBfD+IDia0w0FrpNCzKQDjqWMHgth5w=;
 b=WE8h/AXclRmDEpT8ZTAH0Bdi8vaJ81AOV52Y23R6I8qjsPFUhYDg+HdCdEMCR3SKOza/LA6tSCXpAedyQQKAWFg0jImOVCBEHD/ptGlWlmKx/ogooPYi7a2iNXq18VH/08ijZKYPutcVHqmFSI2Dhuqv8B8g5G72QufEvcFd8ic=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Fri, 11 Sep 2020 06:02:15 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 06:02:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Topic: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Index: AdaH8EEPyluBF0UHTRSypdzG9nCpXwADO3aw
Date: Fri, 11 Sep 2020 06:02:15 +0000
Message-ID: <DM6PR12MB40756C546E49C8DD8BDE7924FC240@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB40324FF5E5D607A6CE8D4D50FB240@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB40324FF5E5D607A6CE8D4D50FB240@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-11T06:02:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b223e10b-7ff6-4a56-bca1-0000204d715d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-11T06:02:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d3219647-02e9-41d8-ab36-0000b653d3ba
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-11T06:02:11Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c5c74ecc-a396-4a21-9c32-00004cfa4fa1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d71b6ad-8c70-4bfe-9560-08d856183bb1
x-ms-traffictypediagnostic: DM5PR12MB1867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1867174581B3E8676D1A6425FC240@DM5PR12MB1867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 208nN3OjHFmfd25lg7QeZqUczPIArSxuRJFu9i64IlNAoYIqKAdrk7tddSVaK9Csa3P1D1C70GJwfjmkCWvq7GSD1HRvBS5hX3MXsg7Ac1ECANwi3UvRvi4fk0vZyub6B18tjpFyTqExOJu6p5VJv7RD6oK6M3iCB+WZVegOmm3dli7FHVFg7hA8KJn6dToJ+qPBc+UA9FsPDHTraJ58TsF+2FLwtm5rA3l7gtEiOrsONUTxpluR6J/LTx5QMabxgVicM0HzzfN6o5f1eZwzcijhlOO7TgrodH+wteupALkvLVg6SwamkFWY+TwTVkGj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(2906002)(52536014)(5660300002)(55016002)(8936002)(9686003)(86362001)(83380400001)(53546011)(8676002)(26005)(7696005)(4744005)(316002)(15650500001)(110136005)(76116006)(64756008)(33656002)(66476007)(6636002)(66946007)(186003)(66556008)(71200400001)(6506007)(478600001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BLZXeWqMJlMgHRgir8oFTg7uXTQxg1Pc66EwvC2OtpFOwtzvJU2U/U0Ft+D3HXGPKt+ZWLDAoJZoXqy2bNwF27ASiD+wTstYNk1t0ara2OQVQraZnPZI5aHLQhpDFYpM+chydErG9LRT2XTXJffzE5zSjnAuTEFBMzNFRyiy89DWjHSLABz1dYDpJqtZUgURbkvov+JSW548ffssG0JBSTGyp+equETDOuOv/K9FhOo7mv3QukG9koAddYoErNU8rhQFnDEZKK6Lsm5QoVEk3ZiLIxG65sGzMDfg/FNgJ30eIhmGwlq0H1kCZIHe/dxXiu1D0EvyFPPjLUrxLYQNCOaxEHoK0YrVi67WDw1zjwIVU5Mv3ucg1iFB13SJf6sTuEWs2XEbxw32YjBCcYWNT5pqwhDVJIrlLfheAxiiIneMv6wf5zbiYhowhbW6Qwpn3qh4R0McHYZuZU/FCW3YJ12IQXaiG7cCwhHWmXSGZeQbaR7xGiw7M3jbIwTxh+b4Fo0XdnsQfrgUwL3FKUwADmld5Ngc9dU5UZDPerK/VPC1PdUE6m3g5MbISN2kSH0ZmLPFxD7XzPg4kQ+NHhRdYEdQkxQbr+sKN9fOvw4ozHwe3D6hNuCgfo8OnxP+1lGqcf+/lG5xojH4EH7qAkpVPA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d71b6ad-8c70-4bfe-9560-08d856183bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 06:02:15.1840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+5EEJmceFJJgCxeyeviCLwhqZa4TdiCFaBZGEkkLqAVAwX49zwUzXf7m4cCpWMNzI0/TvB8Qq+nzn3UOy/hgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Content-Type: multipart/mixed; boundary="===============1337851131=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1337851131==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40756C546E49C8DD8BDE7924FC240DM6PR12MB4075namp_"

--_000_DM6PR12MB40756C546E49C8DD8BDE7924FC240DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

+                             {
+                                             dev_warn(psp->adev->dev, "RAS=
 Init Status: 0x%X\n", ras_cmd->ras_status);
+                             }
Please remove the redundant bracket.

Other than that, the patch is
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

In addition, please create another patch to move the nbio ras controller ir=
q source registry to sw_init, which is the consistent as what we did for ot=
her ip blocks, register the irq source in IP sw_init funcs.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Friday, September 11, 2020 12:03
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Chen, Guchun <Guchun.Chen=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS init handling


[AMD Official Use Only - Internal Distribution Only]

Added RAS status check and tear down RAS context if RAS init fails

--_000_DM6PR12MB40756C546E49C8DD8BDE7924FC240DM6PR12MB4075namp_
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
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(ps=
p-&gt;adev-&gt;dev, &quot;RAS Init Status: 0x%X\n&quot;, ras_cmd-&gt;ras_st=
atus);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">Please remove the redundant bracket. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Other than that, the patch is<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In addition, please create another patch to move the=
 nbio ras controller irq source registry to sw_init, which is the consisten=
t as what we did for other ip blocks, register the irq source in IP sw_init=
 funcs.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Friday, September 11, 2020 12:03<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Chen, Guchun=
 &lt;Guchun.Chen@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update RAS init handling<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Offi=
cial Use Only - Internal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Added RAS status check and tear down RAS context if =
RAS init fails<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40756C546E49C8DD8BDE7924FC240DM6PR12MB4075namp_--

--===============1337851131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1337851131==--
