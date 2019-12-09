Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35DC43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 15:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444F02077B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 15:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444F02077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC396E506;
	Mon,  9 Dec 2019 15:52:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B296E506
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 15:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmYbHvTwazhm4iEvSlF7nwdG3Ns5WgcfxYG7IktFbfcsI6E4wWx/r5kGhHXlJamoJcJ/j7ncZntqLaIK/Mzl5l6yjOF+z8Aaip5UO//jZqEm9idP1f2wEiB8RN9l0jd/ZmyXKPm8PW02+XgEs8BB00q8IWqzd+aXLy0DMwORyjCHuwatxb5KUjVi9GaYwqP/Q6Ui7GPQfnO6ht2kQZHhXGuZH8tqb8zMQFFDOAXLlUUAuHfSdeQLd4NTRa8VY8FqTzO6XjPKnFeBkt8CK/AOebfoG3jaMeL0Lli3crC/l/j1NbcbCBxTvAqpKlkDEUgmB9GiJLAclAuSdgVHLusG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VABdf5TGd+gvgRxV3ICeaSVdAqffEC2j+rpJ47snE30=;
 b=ggk1nxZBhXJglLxh2T7rJv3CD4Y763jyd2j7sxvB/xXgDTjLvdbEh2B+osxOoLzfHYYMoCW3RME0z/d1w36M/Ucg/DpQz3N4jsSSLYjDNRLaIxOK/xi10t/PKYyNE2MoMppz/2/QUm0PJF3S6H1o2sk9nO+VyVXEH47+0Jui/XIDaP/cIgEGIwmJAWPp6h7bc74DjOFWuCpzqGGFdbsLUju6LaeTwq7h/1EwRw0Oo2cqnY4l1Lcm6SKA/ock1yGuuGj4gX8za2TPiwJ4MsW0hMUY3K1zoN5NRhg+UkF1C02qwjBQ+JTtHWt8fbkObjQ6xZ40ABOY+JZXwPOkxvyxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1631.namprd12.prod.outlook.com (10.172.55.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 15:52:18 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 15:52:17 +0000
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-6-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
 <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
 <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
 <5b505116-17aa-383d-5cdf-246663a1f4f9@amd.com>
 <MN2PR12MB42855B198BB4064A0D311845F6420@MN2PR12MB4285.namprd12.prod.outlook.com>
 <2c4dd3f3-e2ce-9843-312b-1e5c05a51521@amd.com>
 <CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com>
 <0cf9f58a-3ce4-2a9c-cb1a-db3cb13760b9@amd.com>
 <MN2PR12MB42855296AE5C7EDA968AA442F65C0@MN2PR12MB4285.namprd12.prod.outlook.com>
 <a38e95ac-ca7e-20fd-0c2a-4d4310e8599a@amd.com>
 <MN2PR12MB428581A895E0C2B26542CC1DF6580@MN2PR12MB4285.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <b44fcb10-d1ed-c93a-8010-5b62aae74545@amd.com>
Date: Mon, 9 Dec 2019 10:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <MN2PR12MB428581A895E0C2B26542CC1DF6580@MN2PR12MB4285.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::32) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33cf54bb-72ac-46e4-e051-08d77cbfc48b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1631:|MWHPR12MB1631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1631E01388F8A47431D8050AEA580@MWHPR12MB1631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(199004)(189003)(52314003)(316002)(2906002)(4326008)(53546011)(71190400001)(186003)(6636002)(6506007)(229853002)(26005)(6486002)(86362001)(478600001)(8936002)(2616005)(110136005)(81166006)(31686004)(81156014)(8676002)(790700001)(6666004)(6512007)(52116002)(5660300002)(31696002)(33964004)(66946007)(36756003)(66476007)(66556008)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1631;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxXnRlRHIyriJ9NNeaQApqHZcMtLyHfTSecAwrCHKgL4CEUeKkI0frzrq35E3m7XcAWTHy3w4qVbs+ji4pK4X50alZN1C1g88sHOvH6WhQs7tzwlam4wB2e9fApKaNRK9rWJnYJtJuRAF5s5TJe/HZvp1KkQcbS0nNz6ExprUZJPPe/yKPJbJNS0p3Fj5QJi4us6iPUrnVLzobnBYx4T2x/1yrowJA5X94YLeSyJLiUJhiRKr3mqiyeTxlIPQQsUZIfpn6KKlh09RU424JmL49Yyqw4j7sKj30pjfUCMIp/p4H+Re0vcxyykknthxw1FBMYvJ7z4tmVTlB7Ro0yJRUj/t+9quPmOgeQUM3WAkp0SeUxsbT6sjEoMPIFZsfRCw0koew042MK3yudG+v11Nr9hiQRvGdoTwMKXGmlKzxiOws6eKUEsGUT+FRK/XdUDj2DNlkTop0E5QWUDWkO/EUCnK2aP72uUhg+P0+xiQhu9Cvg+JYQ2ZqLk7xdW+9yyICsjVSOI82yYLciew5F55Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cf54bb-72ac-46e4-e051-08d77cbfc48b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 15:52:17.6532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0zs2a6f8oxKLz2bSREtVn3ivxXFK1RBWloFmSeA5zOugvBWHxqXtwMUZw0mGVgWAxtO4E/3ESkfiIGpnYIMGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1631
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VABdf5TGd+gvgRxV3ICeaSVdAqffEC2j+rpJ47snE30=;
 b=PvrqdZq2wo6k7RFUPNxqVppSlyrySvzeUxOH9gsn+Ym3Je8ub2UpKUYIZJ236eYKeEExPNaWqenotGNKYEsA5fd0Mi3dzUe+r33ZuvuZT6tjjHQ9whdgfvUn3N8YwMuSrrh8u+GimLbvy8s324waoptrrJyfLoOPw506UnmlMjA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============1942912257=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1942912257==
Content-Type: multipart/alternative;
 boundary="------------BF766A78451A6146F08F7C6C"
Content-Language: en-US

--------------BF766A78451A6146F08F7C6C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks a lot Ma for trying - I think I have to have my own system to 
debug this so I will keep trying enabling XGMI - i still think the is 
the right and the generic solution for multiple nodes reset 
synchronization and in fact the barrier should also be used for 
synchronizing PSP mode 1 XGMI reset too.

Andrey

On 12/9/19 6:34 AM, Ma, Le wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Hi Andrey,
>
> I tried your patches on my 2P XGMI platform. The baco can work at most 
> time, and randomly got following error:
>
> [ 1701.542298] amdgpu: [powerplay] Failed to send message 0x25, 
> response 0x0
>
> This error usually means some sync issue exist for xgmi baco case. 
> Feel free to debug your patches on my XGMI platform.
>
> Regards,
>
> Ma Le
>
> *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *Sent:* Saturday, December 7, 2019 5:51 AM
> *To:* Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org; Zhou1, 
> Tao <Tao.Zhou1@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhang, 
> Hawking <Hawking.Zhang@amd.com>
> *Cc:* Chen, Guchun <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset 
> support for XGMI
>
> Hey Ma, attached a solution - it's just compiled as I still can't make 
> my XGMI setup work (with bridge connected only one device is visible 
> to the system while the other is not). Please try it on your system if 
> you have a chance.
>
> Andrey
>
> On 12/4/19 10:14 PM, Ma, Le wrote:
>
>     AFAIK it's enough for even single one node in the hive to to fail
>     the enter the BACO state on time to fail the entire hive reset
>     procedure, no ?
>
>     [Le]: Yeah, agree that. I’ve been thinking that make all nodes
>     entering baco simultaneously can reduce the possibility of node
>     failure to enter/exit BACO risk. For example, in an XGMI hive with
>     8 nodes, the total time interval of 8 nodes enter/exit BACO on 8
>     CPUs is less than the interval that 8 nodes enter BACO serially
>     and exit BACO serially depending on one CPU with yield capability.
>     This interval is usually strict for BACO feature itself. Anyway,
>     we need more looping test later on any method we will choose.
>
>     Any way - I see our discussion blocks your entire patch set - I
>     think you can go ahead and commit yours way (I think you got an RB
>     from Hawking) and I will look then and see if I can implement my
>     method and if it works will just revert your patch.
>
>     [Le]: OK, fine.
>
>     Andrey
>

--------------BF766A78451A6146F08F7C6C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Thanks a lot Ma for trying - I think I have to have my own system
      to debug this so I will keep trying enabling XGMI - i still think
      the is the right and the generic solution for multiple nodes reset
      synchronization and in fact the barrier should also be used for
      synchronizing PSP mode 1 XGMI reset too.</p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 12/9/19 6:34 AM, Ma, Le wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB428581A895E0C2B26542CC1DF6580@MN2PR12MB4285.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.EmailStyle18
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
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p class="msipheadera92e061b" style="margin:0" align="Left"><span style="font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD
          Official Use Only - Internal Distribution Only]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Hi Andrey,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">I tried your
            patches on my 2P XGMI platform. The baco can work at most
            time, and randomly got following error:<o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-left:.5in"><span style="font-size:12.0pt;color:windowtext">[ 1701.542298]
            amdgpu: [powerplay] Failed to send message 0x25, response
            0x0<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">This error usually
            means some sync issue exist for xgmi baco case. Feel free to
            debug your patches on my XGMI platform.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Regards,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Ma Le<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> Grodzovsky, Andrey
                <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                <br>
                <b>Sent:</b> Saturday, December 7, 2019 5:51 AM<br>
                <b>To:</b> Ma, Le <a class="moz-txt-link-rfc2396E" href="mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Zhou1, Tao
                <a class="moz-txt-link-rfc2396E" href="mailto:Tao.Zhou1@amd.com">&lt;Tao.Zhou1@amd.com&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis
                <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>; Zhang, Hawking
                <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                <b>Cc:</b> Chen, Guchun <a class="moz-txt-link-rfc2396E" href="mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd.com&gt;</a><br>
                <b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add
                concurrent baco reset support for XGMI<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p>Hey Ma, attached a solution - it's just compiled as I still
          can't make my XGMI setup work (with bridge connected only one
          device is visible to the system while the other is not).
          Please try it on your system if you have a chance.
          <o:p></o:p></p>
        <p>Andrey<o:p></o:p></p>
        <div>
          <p class="MsoNormal">On 12/4/19 10:14 PM, Ma, Le wrote:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p>AFAIK it's enough for even single one node in the hive to
            to fail the enter the BACO state on time to fail the entire
            hive reset procedure, no ?<o:p></o:p></p>
          <p class="MsoNormal" style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span style="font-size:12.0pt;color:#203864">[Le]: Yeah, agree
              that. I’ve been thinking that make all nodes entering baco
              simultaneously can reduce the possibility of node failure
              to enter/exit BACO risk. For example, in an XGMI hive with
              8 nodes, the total time interval of 8 nodes enter/exit
              BACO on 8 CPUs is less than the interval that 8 nodes
              enter BACO serially and exit BACO serially depending on
              one CPU with yield capability. This interval is usually
              strict for BACO feature itself. Anyway, we need more
              looping test later on any method we will choose.</span><o:p></o:p></p>
          <p>Any way - I see our discussion blocks your entire patch set
            - I think you can go ahead and commit yours way (I think you
            got an RB from Hawking) and I will look then and see if I
            can implement my method and if it works will just revert
            your patch.<o:p></o:p></p>
          <p><span style="font-size:12.0pt;color:#203864">[Le]: OK,
              fine.</span><o:p></o:p></p>
          <p>Andrey<o:p></o:p></p>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------BF766A78451A6146F08F7C6C--

--===============1942912257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1942912257==--
