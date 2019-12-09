Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B85C43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 22:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD701206D5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 22:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD701206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0576E56A;
	Mon,  9 Dec 2019 22:15:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136F86E56A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 22:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9Tt9FiyHc9uMocJb6bG45v/NPiNH1xwO/64LvzUqgew76AwuuRMqUkBWAr5dstrwYIryMrLLupVW7ZQw6ZW0CaSgnXwD8O8R2IbZ2WkBcfix/s6XRbaxx3CY3s5kYWZOx2VLZf+1yKz8wahXZxcgBKPMehv6v+IPAbphHDKr0CnCLroYWXlHIGmH9DU0ItvTD83Dg+aOIWMIoN5XvTkbZWYst4PM4f702yjEueaSzuFaw9csD4Q0HAo+JNaG3wkxWE3vr3vpozzjw7MGo5VmtPgylsDov+AOD6n7mP69KD3tI8jiBTAP+gn02ykU8vWSY4UKDc7bsgBkn1ppqaUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI8DTtRkSME1ita4AM1Yf4H4dpwigUhL+RSm/jibOLQ=;
 b=RZkcU/51Bvccb/J+Gl1knBp9A4QXrUIC92ef2nEHxLCnCX7JOUlykBTkYg1h70wmTvliBj1PxXCbks62dwE/NhedmRsRaTb4AWgyII7WKwsFrc0vLQ/sJLR+JlQN2a0XqL6cnQTUt4XSL2Iremt05Qa9WqHMD85IuFQ60MSH6Nso/HFFL0+ABk+wVfF4VWM/SrEGJD7CMldfRosO19Asdg03vWctaOx6YfFzRZk79+vr/PGAuYXqmnFC0hn7hdIBfO3pe104BnRicvIfU6HLa/CTUgHYMiu8vAGoRJkW40cHvmDpghF5VOSO0d3tCo7bLJ/93ZzYt8DafSHC/JY3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1806.namprd12.prod.outlook.com (10.175.52.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 22:00:35 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 22:00:35 +0000
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
Message-ID: <1f271be0-4b91-d612-b289-67eacea62652@amd.com>
Date: Mon, 9 Dec 2019 17:00:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <MN2PR12MB428581A895E0C2B26542CC1DF6580@MN2PR12MB4285.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7d210fa-c021-4d39-ca97-08d77cf337b1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1806:|MWHPR12MB1806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1806FE64B20D001E188B5385EA580@MWHPR12MB1806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(52314003)(110136005)(52116002)(81156014)(6506007)(66946007)(66476007)(66556008)(81166006)(8676002)(53546011)(36756003)(186003)(5660300002)(31686004)(6512007)(790700001)(6486002)(2906002)(478600001)(2616005)(26005)(86362001)(33964004)(31696002)(6666004)(6636002)(229853002)(8936002)(71190400001)(4326008)(316002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1806;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8C5DbgaRXSSDdzM15EPJ2ujaIsyBlvsW89OGHX8G8gurIm/fjy7v06jFW7Il56iexbxIHUhjGIr+0kBGvgcxBwBn1QUQ7wTAHYhpRhp2fDzsfu/Oh9eYRFIgKZXSX/sJkWG2sRhJjoFHe4DTzI+NE7q/pjvSInKB+maJQKgMgpsEUUNAhO/8H904qlS+scmNpqBtBPdkyVGxdTub9dpdyJW5is+McyoElP/uA92V5jbSPjeOENONHkB+m9KxdAA3Yx8+VRUl80/P9ft5LVAba9NFI4hOcMqplHQvsEYF669jfckJNwYto/j2ROo5nkZtXmhE8hTlM8yRYbzCuLyG2szKSH4csvBockVVzNwMHX8WQSWGXLztBvcnHhUYOJ+3RwCGcErwr0e9GqG1qQwyd5Nk9VffSQib0RgkzRIfVcFZPgnWP+eycywqwpmAhDIVj9TLfr+kIbv74A3QY7k9xzHMUsb2KGYj5naZwBaofxIXAHWuzGsR8BfckHheerqOT76BMS3ZAiqDyp/FkGJagg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d210fa-c021-4d39-ca97-08d77cf337b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 22:00:35.4278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3z6ts7HjK825mkDcW4WQyutUaIR00PbMEivnoanC8LF+hHUYojrbsRdqTxW7qvXZAKjbB2wTYvbCTFrWMqy3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1806
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI8DTtRkSME1ita4AM1Yf4H4dpwigUhL+RSm/jibOLQ=;
 b=TpzuDk6v8IXEmguT/7pUjFVCfDnDh+5MXlHweJ0+4hjCPZ7MSSdV2ElO3s7AxjFgfTY6VD6VvB6uoI+XIkkyEEXVO15R8yHJYp13xES7tCoK8ecqPFHSinE3gYtc4RiCM6PTzTYMVUDsJFofzCtpuxisj5R3hpBlhaBtpUR2dqE=
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
Content-Type: multipart/mixed; boundary="===============1562486652=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1562486652==
Content-Type: multipart/alternative;
 boundary="------------75ACAD8FC7EF0031518255DF"
Content-Language: en-US

--------------75ACAD8FC7EF0031518255DF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I reproduced the issue on my side - i consistently  observe amdgpu: 
[powerplay] Failed to send message 0x58, response 0x0 - Baco exit 
failure - do you know what is the strict time interval within which all 
the Baco enter/Exit messages needs to be sent to all the nodes in the hive ?

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

--------------75ACAD8FC7EF0031518255DF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>I reproduced the issue on my side - i consistently&nbsp; observe
      amdgpu: [powerplay] Failed to send message 0x58, response 0x0 -
      Baco exit failure - do you know what is the strict time interval
      within which all the Baco enter/Exit messages needs to be sent to
      all the nodes in the hive ?</p>
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

--------------75ACAD8FC7EF0031518255DF--

--===============1562486652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1562486652==--
