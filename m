Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3713C32771
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 03:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EB62085B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 03:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gFcEWKjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EB62085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A4D88249;
	Fri,  3 Jan 2020 03:00:03 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A694E6E167
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 03:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCZEGbD9dWFuu+eiIrD0DKu81s/utduVEThwSKSS2yeeQzIbEFvakBJhBKv6oJ4RK3QfiIQhRqj2F5xShCUW8Hp9d8W7AEtiRl9GzSfUD8+sao1Pqd/YVPzg9g54psF4u5alePitnqcKGCb8GNxdki1nfXd3GiqEt+GCG8QxkfBmZLYnNtjkdIIub1Z9wfE6VJfFi+bPYQMvO/slIlF5BgbNfmTsNoykuSP3s6IWdEqYR28D8lToq7giyPbedKoz9gwm1MM5/MexQ5Wv0d7M35ke/o6GETeXsopeKrmNzHd/oM5Ygx4R1Y+6cN+H0B0B6wb3WLqhdzYlhl7fGbpYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjVZhjlTHrrwvWuPui4SVtvSUDK9GcJUGRd1w1ajlws=;
 b=UZigbDv7wnKHwUG5KjH234yQop+wxM3ij8s3dMpmfLnp9CqixY3KMIeGn930756af7mUEaB6gv5g0HdQfhYIGwDKSWQrowdpA29/sOYylMDizYValcnsfKhiJ2M4zftzwGPDjoLdG1haCZesc9//lG5it8etfdr3g1fPXnCyPIN3mNTIExC11GgVymCZN5tXac3OyBc0YTBf7/MrUGZf14aEeLmdr+fvO4dd5wUsNVCBh38755gKxkjK+Cn8ih1MlUbuikefPr+R9tfsoCUtyTQ8/hnJzE9/POh5mOXKlymxl9D++di/ElIRyp3Sg44QhVZWxTpv5DsiL2IlwUpjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjVZhjlTHrrwvWuPui4SVtvSUDK9GcJUGRd1w1ajlws=;
 b=gFcEWKjZzdt4iAUTsD5wqJcBJZaSQZrgcxP7gKm/Swyk/ux+uDa/MZ1lDRGqXtBlWDd5J6pOYxmNO8yuzyw1LdCtT8nm1RvITa3OERVccAKpWgUxNRS4P8rXeME23oGM1KkVMcAX1jhUpshnSp/JeUpYsSmR4cP9J8n2PxTkPLI=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3072.namprd12.prod.outlook.com (20.178.241.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 02:59:59 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.013; Fri, 3 Jan 2020
 02:59:59 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Index: AdXBV3Yg76uTyzhkQhyxmQ2h5s6tpQAh5jMwAAChY/A=
Date: Fri, 3 Jan 2020 02:59:59 +0000
Message-ID: <MN2PR12MB3663654EFF5093BE63FC0705FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB3663CB891846CB098EED1354FB200@MN2PR12MB3663.namprd12.prod.outlook.com>
 <MN2PR12MB3054E9B6217E994F836913B3B0230@MN2PR12MB3054.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3054E9B6217E994F836913B3B0230@MN2PR12MB3054.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-03T02:40:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=25f9a9b6-91d3-4a0a-91a7-0000b056759d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-03T02:59:53Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e9498613-4884-41d5-9a32-0000d2f2474f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db1ca304-0550-4efe-33bf-08d78ff90551
x-ms-traffictypediagnostic: MN2PR12MB3072:|MN2PR12MB3072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30724969623C5865BED87671FB230@MN2PR12MB3072.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(64756008)(66476007)(66946007)(478600001)(53546011)(6506007)(26005)(33656002)(2906002)(5660300002)(52536014)(66446008)(76116006)(66556008)(110136005)(316002)(71200400001)(8936002)(6636002)(86362001)(186003)(9686003)(81166006)(55016002)(81156014)(8676002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3072;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iN+4mSALhHTtH+9ZRMub9n4EqxpliWuK+EA+QnkptVR67SttZ3DsK0US7M5BpOTj8xXEQ+Atiw+ln7Yi8Xdf9AqPVm7M6nwC9IoUSu4GayAUD8zy7XCvjnrXsS32rE3SvZ8jJhxySl3So59hvKXVqoOKJQj6WBG8LJVO8pzH9vGYGkVCTFbYVDkFtzoeRJ2e/il9EaPOlojhL7MOIm+mXzjV7kjk6uQI5F3crDhzYOsMjRI7EXhzgo7JLorYEP9BWD9+TorGhs2kcO9X0C7bxtiPgwvSefys6gIwBaxs1PFWLpCMTLf+J1vbemGGhx6LUrb0VLp2AcZTKwr/EKuV6myZJu95Reu0iIbn0dFxkfBjDFMthjJ/2RIKutMEJ0qexOxc4PfLlmNFxmjVncn6YtyvZwaSeEq5M4THQ48LT9FQHCg8BzRtWcFLZM6nRbvQ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1ca304-0550-4efe-33bf-08d78ff90551
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 02:59:59.2692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/fi+LIEG9H1qLGSnpY60z+AA5gHtiLDtGz8gK5Nqyf1gTuqKGaqoP+HZ2jrdNAEPPG7aZ67ymK/zOAn3z6yuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3072
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
Content-Type: multipart/mixed; boundary="===============0215439782=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0215439782==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663654EFF5093BE63FC0705FB230MN2PR12MB3663namp_"

--_000_MN2PR12MB3663654EFF5093BE63FC0705FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hello Tao,

That is an interesting suggestion, I agree that there is a little bit of du=
plicate code with  the same for loops being used in multiple functions.

My only concern with implementing the loops in a macro is code readability.

I=1B$B!G=1B(Bll have to think about the trade off between the duplicate cod=
e and code readability more.

Thank you,
John Clements

From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, January 3, 2020 10:53 AM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query


[AMD Public Use]

I think we can implement it by only updating amdgpu_umc_for_each_channel ma=
cro, here is an example:

#define amdgpu_umc_for_each_channel(func)        \
        struct ras_err_data *err_data =3D \
                        (struct ras_err_data *)ras_error_status;        \
        uint32_t umc_inst, channel_inst, umc_reg_offset, channel_index; \
        for (umc_inst =3D 0; umc_inst < adev->umc.umc_inst_num;  \
                        umc_inst++) {   \
                umc_reg_offset =3D adev->umc.inst_offs * umc_inst;       \
                for (channel_inst =3D 0;  \
                        channel_inst < adev->umc.channel_inst_num;     \
                        channel_inst++) {       \
                        /* get channel index of interleaved memory */   \
                        channel_index =3D adev->umc.channel_idx_tbl[\
                                umc_inst * adev->umc.channel_inst_num + cha=
nnel_inst]; \
                        (func)(adev, err_data, umc_reg_offset, channel_inde=
x); \
                        /* increase register offset for next channel */ \
                        umc_reg_offset +=3D adev->umc.channel_offs;      \
                }       \
        }

Regards,
Tao
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: 2020=1B$BG/=1B(B1=1B$B7n=1B(B2=1B$BF|=1B(B 18:31
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Zhou1, =
Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Subject: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query


[AMD Official Use Only - Internal Distribution Only]

Added patch to resolve following issue where error counter detection was no=
t iterating over all UMC instances/channels.
Removed support for accessing UMC error counters via MMIO.

Thank you,
John Clements

--_000_MN2PR12MB3663654EFF5093BE63FC0705FB230MN2PR12MB3663namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;
	mso-fareast-language:JA;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle23
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;MS=
 PGothic&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Hello Tao,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">That is an interesting suggestion, I agree that ther=
e is a little bit of duplicate code with &nbsp;the same for loops being use=
d in multiple functions.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My only concern with implementing the loops in a mac=
ro is code readability.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I=1B$B!G=1B(Bll have to think about the trade off be=
tween the duplicate code and code readability more.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <b=
r>
<b>Sent:</b> Friday, January 3, 2020 10:53 AM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter=
 query<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:SimSun">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">I think we can implement it by only updating amdgpu_=
umc_for_each_channel macro, here is an example:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#define amdgpu_umc_for_each_channel(func)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ra=
s_err_data *err_data =3D \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (struct ras_err_data *)ras_error_status; &nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;\<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t =
umc_inst, channel_inst, umc_reg_offset, channel_index; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (umc_=
inst =3D 0; umc_inst &lt; adev-&gt;umc.umc_inst_num;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; umc_inst&#43;&#43;) {&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset =3D adev-&gt;umc.inst=
_offs * umc_inst;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (channel_inst =3D 0;&nbsp; \<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; channel_inst &lt; adev-&gt;umc.channel_inst_num;&nbsp;&nbsp;&nb=
sp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; channel_inst&#43;&#43;) {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \=
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* get channel index of interleaved memory */&nbsp;&nbsp; \<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; channel_index =3D adev-&gt;umc.channel_idx_tbl[\<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst * adev=
-&gt;umc.channel_inst_num &#43; channel_inst]; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &nbsp;(func)(adev, err_data, umc_reg_offset, channel_index); \<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* increase register offset for next channel */ \<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; umc_reg_offset &#43;=3D adev-&gt;umc.channel_offs;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Tao<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> 2020<span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-farea=
st-language:ZH-CN">=1B$BG/=1B(B</span>1<span lang=3D"ZH-CN" style=3D"font-f=
amily:SimSun;mso-fareast-language:ZH-CN">=1B$B7n=1B(B</span>2<span lang=3D"=
ZH-CN" style=3D"font-family:SimSun;mso-fareast-language:ZH-CN">=1B$BF|=1B(B=
</span>
 18:31<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zh=
ou1@amd.com">Tao.Zhou1@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter que=
ry<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Added patch to resolve following issue where error c=
ounter detection was not iterating over all UMC instances/channels.<o:p></o=
:p></p>
<p class=3D"MsoNormal">Removed support for accessing UMC error counters via=
 MMIO.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3663654EFF5093BE63FC0705FB230MN2PR12MB3663namp_--

--===============0215439782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0215439782==--
