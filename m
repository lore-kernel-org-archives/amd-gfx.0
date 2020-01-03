Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9FFC3276F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 02:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6051E2085B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 02:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J0l7NmPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6051E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0196E16B;
	Fri,  3 Jan 2020 02:57:51 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680059.outbound.protection.outlook.com [40.107.68.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433796E167
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 02:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8nGL+o5iQ4SaxgDT5xU6xIJXvcrHbJdLoXoXsZvRLOGOhuy1DmDPgHDGRx8MFG79+MjFTOyAIgwLVYPGjPnQkWOyP2bAt68GslhzHrM74gSLKsn+isvqdMoInh6KcTK4uDWNsAHRaB3mDGvH0TfdNqkkUrxwRKHK434rhFW3xNUtXOvlnZ5TA8ZwSSe8vhKra1/7oxJPDgcLMFyOZ0ne5aOmJEZiBKH3FH1EKUMQk4WP61Cb/PM92Fej5vBVMWALE+Yjezv/sU69wz2KhdOH5dFt+M786mFLLqM/jm+6rHi3l6WG8q5obp6+W0N23H1G+XGQEXP1gmmoAQLH+8Ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXXs+MLWKyb+SFcak+1knjizrqBYgLZb8bhhrF6Zf4Q=;
 b=TpRNPKJT+tLGILF4ebK/TSt5KlzufxBr5Rz1VqPSnDQEj5oZa7g8EZQ6LB1B/XqrD3xOCUzWS/hGR0cmHiL9GUJRBjj7DctW392v2Dzuku/BvjiYMekViLEjXdTblHjrK2oisd2zZ68DD2pYy3dMqGa5T81ld1Z7tPNGvYPh6Oc8z+yhmzH8oQl2Ud9pOzaN4fwIpG5Iw5I0dVwd4neYUnONi57zvqjH5QnW5D0HJVIi1k9LKoxa46GCpMaoRMoCjErjdV3OEqArofG89Ua35JyUfNtfGyQ9HY2RujipIsizcBfbFJle6NltwLi0WlGAt+Dp26IpMvxOffR8offx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXXs+MLWKyb+SFcak+1knjizrqBYgLZb8bhhrF6Zf4Q=;
 b=J0l7NmPuLyOcGea8jVSqy3HY9OeCGIDo/t7AZ34w8NiIaegGLp6DMr23IOdWNUr/z9WQsnTDrHY7Q/eTzmMBaOIYZVafCbfA2qgkSQddu7tpkQO0J6WzBL78yVIRN/hiJt3kST5iy0f+LajHVjf04owsj9sBI0ZzCzqmd7Y1N44=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3072.namprd12.prod.outlook.com (20.178.241.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 02:57:48 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.013; Fri, 3 Jan 2020
 02:57:47 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Index: AdXBV3Yg76uTyzhkQhyxmQ2h5s6tpQAEeliQABnzfSAAA/7Q8A==
Date: Fri, 3 Jan 2020 02:57:47 +0000
Message-ID: <MN2PR12MB36633246687A079AE98979D5FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB3663CB891846CB098EED1354FB200@MN2PR12MB3663.namprd12.prod.outlook.com>
 <DM5PR12MB141870C643D7A615B4BE392AFC200@DM5PR12MB1418.namprd12.prod.outlook.com>
 <BYAPR12MB28062F0EE6CBCCC870BBFA88F1230@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB28062F0EE6CBCCC870BBFA88F1230@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-03T01:06:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4f61058f-43a8-4e9b-b873-000097358b83;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-03T02:57:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6c69acd2-c94d-4abd-909a-0000634c050e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bda8bece-9ae4-416c-37bf-08d78ff8b6e0
x-ms-traffictypediagnostic: MN2PR12MB3072:|MN2PR12MB3072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3072BDC50DCF44B2A80CBC37FB230@MN2PR12MB3072.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(86362001)(6636002)(9686003)(81166006)(186003)(110136005)(316002)(8936002)(71200400001)(81156014)(8676002)(7696005)(55016002)(26005)(6506007)(53546011)(66946007)(64756008)(66476007)(478600001)(52536014)(66616009)(66556008)(66446008)(76116006)(2906002)(33656002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3072;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UB+IRy9t/9FUBgXTB5Jf1oDBprs/xd9Qurskla1WLNogSjlnyEivMpjAKLKXAfNxwaLla3MIcm+8LzNMG82VA1Y2C1+BgUHWI1+crmxIknc2DmtGGc2+dVrPlmDaUd2fu0CBS5byVYq9/pOC9Mkbr27yD0gNgsewpsmEcNMHDXjbHfip9SlhvrGj8LD0jJYdBlIxPF4GqnWAnqOuEn9omh+UVBFe4b9ewmy0p4PEZaQ+/DYvTKD4UZHlZ5+vrOiB0DXvT3ndtN2IAk3VCGbutaiTPAOb05R/yLhwupVb9359y7XRbANvVU0K9K+Ijl6rMXQwRq56K/nMj3hvMCVe+H0I+MDkAdIgKL3ADv6UI8LUJZ+Q3qBMKkkPMq1O6WNFLqSM7RClwZZBbVXPy37V38b+cM9sxWLcXGAUN5I24PQf0XZi4gGopa/r4U0s3DuJ
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda8bece-9ae4-416c-37bf-08d78ff8b6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 02:57:47.5935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifFA2JOV8D9PS1dJEzkHymU22QEqsIRybmDDwjbB118kLsi7EGIIcA43ftp5fwtyqv+bhGwovPsDJeW9SPcTeQ==
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_"

--_000_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hello GuChun/Hawking,

Thank you for your feedback, I have updated the patch with the following am=
endments:

  *   Remove +#define UMC_REG_OFFSET (I forgot to remove this in original p=
atch, I prefer the function over the macro)
  *   Updated the coding style of the braces in the for loops to have the s=
tarting brace on the same line as the for loop declaration

GuChun,
For your concern about the umc_v6_1_query_ras_error_count, in the UE/CE err=
or counter register reading, the local SW error counters can only be increm=
ented and not cleared throughout the iteration over the UMC error counter r=
egisters.

Thank you,
John Clements

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, January 3, 2020 9:07 AM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>; amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query


[AMD Public Use]

+#define UMC_REG_OFFSET(adev, ch_inst, umc_inst) ((adev)->umc.channel_offs =
* (ch_inst) + UMC_6_INST_DIST*(umc_inst))
Coding style problem, miss blank space around last "*".

+            for (umc_inst =3D 0; umc_inst < adev->umc.umc_inst_num; umc_in=
st++)
+            {
Another coding style problem. "{" should follow closely at the same line, n=
ot starting at one new line.

Thirdly, in umc_v6_1_query_ras_error_count, we use dual loops for query err=
or counter for all UMC channels. But we always use the same variable to do =
the query. So the value will be overwritten by new one? Then we will miss f=
ormer error counters if there are. Correct?

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Zhang, Hawking
Sent: Thursday, January 2, 2020 8:38 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zhou1, =
Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query


[AMD Official Use Only - Internal Distribution Only]

UMC_REG_OFFSET(adev, ch_inst, umc_inst) and the function get_umc_reg_offset=
 actually do the same thing? I guess you just want to keep either of them, =
right?

Regards,
Hawking

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Thursday, January 2, 2020 18:31
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

--_000_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle24
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle25
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
/* List Definitions */
@list l0
	{mso-list-id:1404836294;
	mso-list-type:hybrid;
	mso-list-template-ids:-655825146 -2082196856 67698691 67698693 67698689 67=
698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:DengXian;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1764915849;
	mso-list-template-ids:1904264244;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
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
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello GuChun/Hawking,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for your feedback, I have updated the patc=
h with the following amendments:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo3">Remove &#43;#define UMC_REG_OFFSET (I forgot to remove this in origin=
al patch, I prefer the function over the macro)<o:p></o:p></li><li class=3D=
"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 lfo3">Update=
d the coding style of the braces in the for loops to have the starting brac=
e on the same line as the for loop declaration<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">GuChun,<o:p></o:p></p>
<p class=3D"MsoNormal">For your concern about the umc_v6_1_query_ras_error_=
count, in the UE/CE error counter register reading, the local SW error coun=
ters can only be incremented and not cleared throughout the iteration over =
the UMC error counter registers.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Friday, January 3, 2020 9:07 AM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Clements, John &lt=
;John.Clements@amd.com&gt;; amd-gfx@lists.freedesktop.org; Zhou1, Tao &lt;T=
ao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter=
 query<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;#define UMC_REG_OFFSET(adev, ch_inst, umc_inst)=
 ((adev)-&gt;umc.channel_offs * (ch_inst) &#43; UMC_6_INST_DIST*(umc_inst))=
<o:p></o:p></p>
<p class=3D"MsoNormal">Coding style problem, miss blank space around last &=
#8220;*&#8221;.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (umc_inst =3D 0; umc_inst &lt; adev-&gt;umc.umc_ins=
t_num; umc_inst&#43;&#43;)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">Another coding style problem. &#8220;{&#8221; should=
 follow closely at the same line, not starting at one new line.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thirdly, in umc_v6_1_query_ras_error_count, we use d=
ual loops for query error counter for all UMC channels. But we always use t=
he same variable to do the query. So the value will be overwritten by new o=
ne? Then we will miss former error
 counters if there are. Correct?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Zhang, Hawking<br>
<b>Sent:</b> Thursday, January 2, 2020 8:38 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.=
com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter=
 query<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">UMC_REG_OFFSET(adev, ch_inst, umc_inst) and the func=
tion get_umc_reg_offset actually do the same thing? I guess you just want t=
o keep either of them, right?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, January 2, 2020 18:31<br>
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
</body>
</html>

--_000_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_--

--_004_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-bug-in-UMC-6-error-counter-query.patch"
Content-Description:  0001-drm-amdgpu-resolve-bug-in-UMC-6-error-counter-query.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-bug-in-UMC-6-error-counter-query.patch";
	size=8901; creation-date="Fri, 03 Jan 2020 02:54:00 GMT";
	modification-date="Fri, 03 Jan 2020 02:54:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhYjYzYWY3Y2YxNGIwYWRjYTNkMWIwZmRlN2E4MmQzNzE1NmE2ZTllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMyBKYW4gMjAyMCAxMDo0Nzo0MSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHJlc29sdmUgYnVnIGluIFVNQyA2IGVycm9yIGNvdW50ZXIgcXVlcnkKCml0ZXJh
dGUgb3ZlciBhbGwgZXJyb3IgY291bnRlciByZWdpc3RlcnMgaW4gU01OIHNwYWNlCgpyZW1vdmVk
IHN1cHBvcnQgZXJyb3IgY291bnRlciBhY2Nlc3MgdmlhIE1NSU8KCkNoYW5nZS1JZDogSTQ1Nzkz
OWZmOGQxMjUzNGExNTVmMzI0NDYwYjEyZmI3YzI5ZjdmMTIKU2lnbmVkLW9mZi1ieTogSm9obiBD
bGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91bWMuaCB8ICAzNSAtLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS91bWNfdjZfMS5jICAgfCAxMTcgKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDg5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuaAppbmRleCAzMjgzMDMyYTc4ZTUuLmE2MTVhMWViNzUw
YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VtYy5oCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuaApAQCAtMjEsMzggKzIx
LDYgQEAKICNpZm5kZWYgX19BTURHUFVfVU1DX0hfXwogI2RlZmluZSBfX0FNREdQVV9VTUNfSF9f
CiAKLS8qIGltcGxlbWVudCA2NCBiaXRzIFJFRyBvcGVyYXRpb25zIHZpYSAzMiBiaXRzIGludGVy
ZmFjZSAqLwotI2RlZmluZSBSUkVHNjRfVU1DKHJlZykJKFJSRUczMihyZWcpIHwgXAotCQkJCSgo
dWludDY0X3QpUlJFRzMyKChyZWcpICsgMSkgPDwgMzIpKQotI2RlZmluZSBXUkVHNjRfVU1DKHJl
ZywgdikJXAotCWRvIHsJXAotCQlXUkVHMzIoKHJlZyksIGxvd2VyXzMyX2JpdHModikpOwlcCi0J
CVdSRUczMigocmVnKSArIDEsIHVwcGVyXzMyX2JpdHModikpOwlcCi0JfSB3aGlsZSAoMCkKLQot
LyoKLSAqIHZvaWQgKCpmdW5jKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IHJh
c19lcnJfZGF0YSAqZXJyX2RhdGEsCi0gKgkJCQl1aW50MzJfdCB1bWNfcmVnX29mZnNldCwgdWlu
dDMyX3QgY2hhbm5lbF9pbmRleCkKLSAqLwotI2RlZmluZSBhbWRncHVfdW1jX2Zvcl9lYWNoX2No
YW5uZWwoZnVuYykJXAotCXN0cnVjdCByYXNfZXJyX2RhdGEgKmVycl9kYXRhID0gKHN0cnVjdCBy
YXNfZXJyX2RhdGEgKilyYXNfZXJyb3Jfc3RhdHVzOwlcCi0JdWludDMyX3QgdW1jX2luc3QsIGNo
YW5uZWxfaW5zdCwgdW1jX3JlZ19vZmZzZXQsIGNoYW5uZWxfaW5kZXg7CVwKLQlmb3IgKHVtY19p
bnN0ID0gMDsgdW1jX2luc3QgPCBhZGV2LT51bWMudW1jX2luc3RfbnVtOyB1bWNfaW5zdCsrKSB7
CVwKLQkJLyogZW5hYmxlIHRoZSBpbmRleCBtb2RlIHRvIHF1ZXJ5IGVyb3IgY291bnQgcGVyIGNo
YW5uZWwgKi8JXAotCQlhZGV2LT51bWMuZnVuY3MtPmVuYWJsZV91bWNfaW5kZXhfbW9kZShhZGV2
LCB1bWNfaW5zdCk7CVwKLQkJZm9yIChjaGFubmVsX2luc3QgPSAwOwlcCi0JCQljaGFubmVsX2lu
c3QgPCBhZGV2LT51bWMuY2hhbm5lbF9pbnN0X251bTsJXAotCQkJY2hhbm5lbF9pbnN0KyspIHsJ
XAotCQkJLyogY2FsYyB0aGUgcmVnaXN0ZXIgb2Zmc2V0IGFjY29yZGluZyB0byBjaGFubmVsIGlu
c3RhbmNlICovCVwKLQkJCXVtY19yZWdfb2Zmc2V0ID0gYWRldi0+dW1jLmNoYW5uZWxfb2ZmcyAq
IGNoYW5uZWxfaW5zdDsJXAotCQkJLyogZ2V0IGNoYW5uZWwgaW5kZXggb2YgaW50ZXJsZWF2ZWQg
bWVtb3J5ICovCVwKLQkJCWNoYW5uZWxfaW5kZXggPSBhZGV2LT51bWMuY2hhbm5lbF9pZHhfdGJs
WwlcCi0JCQkJdW1jX2luc3QgKiBhZGV2LT51bWMuY2hhbm5lbF9pbnN0X251bSArIGNoYW5uZWxf
aW5zdF07CVwKLQkJCShmdW5jKShhZGV2LCBlcnJfZGF0YSwgdW1jX3JlZ19vZmZzZXQsIGNoYW5u
ZWxfaW5kZXgpOwlcCi0JCX0JXAotCX0JXAotCWFkZXYtPnVtYy5mdW5jcy0+ZGlzYWJsZV91bWNf
aW5kZXhfbW9kZShhZGV2KTsKLQogc3RydWN0IGFtZGdwdV91bWNfZnVuY3MgewogCXZvaWQgKCpl
cnJfY250X2luaXQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKIAlpbnQgKCpyYXNfbGF0
ZV9pbml0KShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CkBAIC02MCw5ICsyOCw2IEBAIHN0
cnVjdCBhbWRncHVfdW1jX2Z1bmNzIHsKIAkJCQkJdm9pZCAqcmFzX2Vycm9yX3N0YXR1cyk7CiAJ
dm9pZCAoKnF1ZXJ5X3Jhc19lcnJvcl9hZGRyZXNzKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKIAkJCQkJdm9pZCAqcmFzX2Vycm9yX3N0YXR1cyk7Ci0Jdm9pZCAoKmVuYWJsZV91bWNfaW5k
ZXhfbW9kZSkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0JCQkJCXVpbnQzMl90IHVtY19p
bnN0YW5jZSk7Ci0Jdm9pZCAoKmRpc2FibGVfdW1jX2luZGV4X21vZGUpKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KTsKIAl2b2lkICgqaW5pdF9yZWdpc3RlcnMpKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KTsKIH07CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3VtY192Nl8xLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jCmluZGV4
IDIzMTc4Mzk5NjY3Yy4uMzVkMTUxOWJkZWI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS91bWNfdjZfMS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Vt
Y192Nl8xLmMKQEAgLTMyLDYgKzMyLDggQEAKIAogI2RlZmluZSBzbW5NQ0FfVU1DMF9NQ1VNQ19B
RERSVDAJMHg1MGYxMAogCisjZGVmaW5lIFVNQ182X0lOU1RfRElTVAkJCTB4NDAwMDAKKwogLyoK
ICAqIChhZGRyIC8gMjU2KSAqIDgxOTIsIHRoZSBoaWdoZXIgMjYgYml0cyBpbiBFcnJvckFkZHIK
ICAqIGlzIHRoZSBpbmRleCBvZiA4S0IgYmxvY2sKQEAgLTUwLDQxICs1MiwxMSBAQCBjb25zdCB1
aW50MzJfdAogCQl7OSwgMjUsIDAsIDE2fSwJCXsxNSwgMzEsIDYsIDIyfQogfTsKIAotc3RhdGlj
IHZvaWQgdW1jX3Y2XzFfZW5hYmxlX3VtY19pbmRleF9tb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAotCQkJCQkgICB1aW50MzJfdCB1bWNfaW5zdGFuY2UpCi17Ci0JdWludDMyX3QgcnNt
dV91bWNfaW5kZXg7Ci0KLQlyc211X3VtY19pbmRleCA9IFJSRUczMl9TT0MxNShSU01VLCAwLAot
CQkJbW1SU01VX1VNQ19JTkRFWF9SRUdJU1RFUl9OQklGX1ZHMjBfR1BVKTsKLQlyc211X3VtY19p
bmRleCA9IFJFR19TRVRfRklFTEQocnNtdV91bWNfaW5kZXgsCi0JCQlSU01VX1VNQ19JTkRFWF9S
RUdJU1RFUl9OQklGX1ZHMjBfR1BVLAotCQkJUlNNVV9VTUNfSU5ERVhfTU9ERV9FTiwgMSk7Ci0J
cnNtdV91bWNfaW5kZXggPSBSRUdfU0VUX0ZJRUxEKHJzbXVfdW1jX2luZGV4LAotCQkJUlNNVV9V
TUNfSU5ERVhfUkVHSVNURVJfTkJJRl9WRzIwX0dQVSwKLQkJCVJTTVVfVU1DX0lOREVYX0lOU1RB
TkNFLCB1bWNfaW5zdGFuY2UpOwotCXJzbXVfdW1jX2luZGV4ID0gUkVHX1NFVF9GSUVMRChyc211
X3VtY19pbmRleCwKLQkJCVJTTVVfVU1DX0lOREVYX1JFR0lTVEVSX05CSUZfVkcyMF9HUFUsCi0J
CQlSU01VX1VNQ19JTkRFWF9XUkVOLCAxIDw8IHVtY19pbnN0YW5jZSk7Ci0JV1JFRzMyX1NPQzE1
KFJTTVUsIDAsIG1tUlNNVV9VTUNfSU5ERVhfUkVHSVNURVJfTkJJRl9WRzIwX0dQVSwKLQkJCQly
c211X3VtY19pbmRleCk7Ci19Ci0KLXN0YXRpYyB2b2lkIHVtY192Nl8xX2Rpc2FibGVfdW1jX2lu
ZGV4X21vZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCi17Ci0JV1JFRzMyX0ZJRUxEMTUo
UlNNVSwgMCwgUlNNVV9VTUNfSU5ERVhfUkVHSVNURVJfTkJJRl9WRzIwX0dQVSwKLQkJCVJTTVVf
VU1DX0lOREVYX01PREVfRU4sIDApOwotfQotCi1zdGF0aWMgdWludDMyX3QgdW1jX3Y2XzFfZ2V0
X3VtY19pbnN0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQordWludDMyX3QgZ2V0X3VtY19y
ZWdfb2Zmc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorCQkJICAgIHVpbnQzMl90IHVt
Y19pbnN0LAorCQkJICAgIHVpbnQzMl90IGNoX2luc3QpCiB7Ci0JdWludDMyX3QgcnNtdV91bWNf
aW5kZXg7Ci0KLQlyc211X3VtY19pbmRleCA9IFJSRUczMl9TT0MxNShSU01VLCAwLAotCQkJCW1t
UlNNVV9VTUNfSU5ERVhfUkVHSVNURVJfTkJJRl9WRzIwX0dQVSk7Ci0JcmV0dXJuIFJFR19HRVRf
RklFTEQocnNtdV91bWNfaW5kZXgsCi0JCQkJUlNNVV9VTUNfSU5ERVhfUkVHSVNURVJfTkJJRl9W
RzIwX0dQVSwKLQkJCQlSU01VX1VNQ19JTkRFWF9JTlNUQU5DRSk7CisJcmV0dXJuIGFkZXYtPnVt
Yy5jaGFubmVsX29mZnMgKiBjaF9pbnN0ICsgVU1DXzZfSU5TVF9ESVNUKnVtY19pbnN0OwogfQog
CiBzdGF0aWMgdm9pZCB1bWNfdjZfMV9xdWVyeV9jb3JyZWN0YWJsZV9lcnJvcl9jb3VudChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKQEAgLTE3NCwyNSArMTQ2LDM2IEBAIHN0YXRpYyB2b2lk
IHVtY192Nl8xX3F1ZXJyeV91bmNvcnJlY3RhYmxlX2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2CiAJCSplcnJvcl9jb3VudCArPSAxOwogfQogCi1zdGF0aWMgdm9pZCB1bWNf
djZfMV9xdWVyeV9lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLQkJCQkJ
ICAgc3RydWN0IHJhc19lcnJfZGF0YSAqZXJyX2RhdGEsIHVpbnQzMl90IHVtY19yZWdfb2Zmc2V0
LAotCQkJCQkgICB1aW50MzJfdCBjaGFubmVsX2luZGV4KQotewotCXVtY192Nl8xX3F1ZXJ5X2Nv
cnJlY3RhYmxlX2Vycm9yX2NvdW50KGFkZXYsIHVtY19yZWdfb2Zmc2V0LAotCQkJCQkJICAgJihl
cnJfZGF0YS0+Y2VfY291bnQpKTsKLQl1bWNfdjZfMV9xdWVycnlfdW5jb3JyZWN0YWJsZV9lcnJv
cl9jb3VudChhZGV2LCB1bWNfcmVnX29mZnNldCwKLQkJCQkJCSAgJihlcnJfZGF0YS0+dWVfY291
bnQpKTsKLX0KLQogc3RhdGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfcmFzX2Vycm9yX2NvdW50KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkgICB2b2lkICpyYXNfZXJyb3Jfc3RhdHVz
KQogewotCWFtZGdwdV91bWNfZm9yX2VhY2hfY2hhbm5lbCh1bWNfdjZfMV9xdWVyeV9lcnJvcl9j
b3VudCk7CisJc3RydWN0IHJhc19lcnJfZGF0YSogZXJyX2RhdGEgPSAoc3RydWN0IHJhc19lcnJf
ZGF0YSopcmFzX2Vycm9yX3N0YXR1czsKKworCXVpbnQzMl90IHVtY19pbnN0ICAgICAgICA9IDA7
CisJdWludDMyX3QgY2hfaW5zdCAgICAgICAgID0gMDsKKwl1aW50MzJfdCB1bWNfcmVnX29mZnNl
dCAgPSAwOworCisJZm9yICh1bWNfaW5zdCA9IDA7IHVtY19pbnN0IDwgYWRldi0+dW1jLnVtY19p
bnN0X251bTsgdW1jX2luc3QrKykgeworCQlmb3IgKGNoX2luc3QgPSAwOyBjaF9pbnN0IDwgYWRl
di0+dW1jLmNoYW5uZWxfaW5zdF9udW07IGNoX2luc3QrKykgeworCQkJdW1jX3JlZ19vZmZzZXQg
PSBnZXRfdW1jX3JlZ19vZmZzZXQoYWRldiwKKwkJCQkJCQkgICAgdW1jX2luc3QsCisJCQkJCQkJ
ICAgIGNoX2luc3QpOworCisJCQl1bWNfdjZfMV9xdWVyeV9jb3JyZWN0YWJsZV9lcnJvcl9jb3Vu
dChhZGV2LAorCQkJCQkJCSAgICAgICB1bWNfcmVnX29mZnNldCwKKwkJCQkJCQkgICAgICAgJihl
cnJfZGF0YS0+Y2VfY291bnQpKTsKKwkJCXVtY192Nl8xX3F1ZXJyeV91bmNvcnJlY3RhYmxlX2Vy
cm9yX2NvdW50KGFkZXYsCisJCQkJCQkJCSAgdW1jX3JlZ19vZmZzZXQsCisJCQkJCQkJCSAgJihl
cnJfZGF0YS0+dWVfY291bnQpKTsKKwkJfQorCX0KIH0KIAogc3RhdGljIHZvaWQgdW1jX3Y2XzFf
cXVlcnlfZXJyb3JfYWRkcmVzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkJIHN0
cnVjdCByYXNfZXJyX2RhdGEgKmVycl9kYXRhLAotCQkJCQkgdWludDMyX3QgdW1jX3JlZ19vZmZz
ZXQsIHVpbnQzMl90IGNoYW5uZWxfaW5kZXgpCisJCQkJCSB1aW50MzJfdCB1bWNfcmVnX29mZnNl
dCwKKwkJCQkJIHVpbnQzMl90IGNoYW5uZWxfaW5kZXgsCisJCQkJCSB1aW50MzJfdCB1bWNfaW5z
dCkKIHsKIAl1aW50MzJfdCBsc2IsIG1jX3VtY19zdGF0dXNfYWRkcjsKIAl1aW50NjRfdCBtY191
bWNfc3RhdHVzLCBlcnJfYWRkciwgcmV0aXJlZF9wYWdlOwpAQCAtMjQ0LDcgKzIyNyw3IEBAIHN0
YXRpYyB2b2lkIHVtY192Nl8xX3F1ZXJ5X2Vycm9yX2FkZHJlc3Moc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCiAJCQllcnJfcmVjLT5lcnJfdHlwZSA9IEFNREdQVV9SQVNfRUVQUk9NX0VSUl9O
T05fUkVDT1ZFUkFCTEU7CiAJCQllcnJfcmVjLT5jdSA9IDA7CiAJCQllcnJfcmVjLT5tZW1fY2hh
bm5lbCA9IGNoYW5uZWxfaW5kZXg7Ci0JCQllcnJfcmVjLT5tY3VtY19pZCA9IHVtY192Nl8xX2dl
dF91bWNfaW5zdChhZGV2KTsKKwkJCWVycl9yZWMtPm1jdW1jX2lkID0gdW1jX2luc3Q7CiAKIAkJ
CWVycl9kYXRhLT5lcnJfYWRkcl9jbnQrKzsKIAkJfQpAQCAtMjU3LDEyICsyNDAsMzAgQEAgc3Rh
dGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfZXJyb3JfYWRkcmVzcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKIHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1ZXJ5X3Jhc19lcnJvcl9hZGRyZXNzKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkgICAgIHZvaWQgKnJhc19lcnJvcl9zdGF0
dXMpCiB7Ci0JYW1kZ3B1X3VtY19mb3JfZWFjaF9jaGFubmVsKHVtY192Nl8xX3F1ZXJ5X2Vycm9y
X2FkZHJlc3MpOworCXN0cnVjdCByYXNfZXJyX2RhdGEqIGVycl9kYXRhID0gKHN0cnVjdCByYXNf
ZXJyX2RhdGEqKXJhc19lcnJvcl9zdGF0dXM7CisKKwl1aW50MzJfdCB1bWNfaW5zdCAgICAgICAg
PSAwOworCXVpbnQzMl90IGNoX2luc3QgICAgICAgICA9IDA7CisJdWludDMyX3QgdW1jX3JlZ19v
ZmZzZXQgID0gMDsKKworCWZvciAodW1jX2luc3QgPSAwOyB1bWNfaW5zdCA8IGFkZXYtPnVtYy51
bWNfaW5zdF9udW07IHVtY19pbnN0KyspIHsKKwkJZm9yIChjaF9pbnN0ID0gMDsgY2hfaW5zdCA8
IGFkZXYtPnVtYy5jaGFubmVsX2luc3RfbnVtOyBjaF9pbnN0KyspIHsKKwkJCXVtY19yZWdfb2Zm
c2V0ID0gZ2V0X3VtY19yZWdfb2Zmc2V0KGFkZXYsCisJCQkJCQkJICAgIHVtY19pbnN0LAorCQkJ
CQkJCSAgICBjaF9pbnN0KTsKKworCQkJdW1jX3Y2XzFfcXVlcnlfZXJyb3JfYWRkcmVzcyhhZGV2
LAorCQkJCQkJICAgICBlcnJfZGF0YSwKKwkJCQkJCSAgICAgdW1jX3JlZ19vZmZzZXQsCisJCQkJ
CQkgICAgIGNoX2luc3QsCisJCQkJCQkgICAgIHVtY19pbnN0KTsKKwkJfQorCX0KKwogfQogCiBz
dGF0aWMgdm9pZCB1bWNfdjZfMV9lcnJfY250X2luaXRfcGVyX2NoYW5uZWwoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCi0JCQkJCSBzdHJ1Y3QgcmFzX2Vycl9kYXRhICplcnJfZGF0YSwKLQkJ
CQkJIHVpbnQzMl90IHVtY19yZWdfb2Zmc2V0LCB1aW50MzJfdCBjaGFubmVsX2luZGV4KQorCQkJ
CQkgICAgICB1aW50MzJfdCB1bWNfcmVnX29mZnNldCkKIHsKIAl1aW50MzJfdCBlY2NfZXJyX2Nu
dF9zZWwsIGVjY19lcnJfY250X3NlbF9hZGRyOwogCXVpbnQzMl90IGVjY19lcnJfY250X2FkZHI7
CkBAIC0zMDEsOSArMzAyLDE5IEBAIHN0YXRpYyB2b2lkIHVtY192Nl8xX2Vycl9jbnRfaW5pdF9w
ZXJfY2hhbm5lbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAogc3RhdGljIHZvaWQgdW1j
X3Y2XzFfZXJyX2NudF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewotCXZvaWQg
KnJhc19lcnJvcl9zdGF0dXMgPSBOVUxMOworCXVpbnQzMl90IHVtY19pbnN0ICAgICAgICA9IDA7
CisJdWludDMyX3QgY2hfaW5zdCAgICAgICAgID0gMDsKKwl1aW50MzJfdCB1bWNfcmVnX29mZnNl
dCAgPSAwOworCisJZm9yICh1bWNfaW5zdCA9IDA7IHVtY19pbnN0IDwgYWRldi0+dW1jLnVtY19p
bnN0X251bTsgdW1jX2luc3QrKykgeworCQlmb3IgKGNoX2luc3QgPSAwOyBjaF9pbnN0IDwgYWRl
di0+dW1jLmNoYW5uZWxfaW5zdF9udW07IGNoX2luc3QrKykgeworCQkJdW1jX3JlZ19vZmZzZXQg
PSBnZXRfdW1jX3JlZ19vZmZzZXQoYWRldiwKKwkJCQkJCQkgICAgdW1jX2luc3QsCisJCQkJCQkJ
ICAgIGNoX2luc3QpOwogCi0JYW1kZ3B1X3VtY19mb3JfZWFjaF9jaGFubmVsKHVtY192Nl8xX2Vy
cl9jbnRfaW5pdF9wZXJfY2hhbm5lbCk7CisJCQl1bWNfdjZfMV9lcnJfY250X2luaXRfcGVyX2No
YW5uZWwoYWRldiwgdW1jX3JlZ19vZmZzZXQpOworCQl9CisJfQogfQogCiBjb25zdCBzdHJ1Y3Qg
YW1kZ3B1X3VtY19mdW5jcyB1bWNfdjZfMV9mdW5jcyA9IHsKQEAgLTMxMSw2ICszMjIsNCBAQCBj
b25zdCBzdHJ1Y3QgYW1kZ3B1X3VtY19mdW5jcyB1bWNfdjZfMV9mdW5jcyA9IHsKIAkucmFzX2xh
dGVfaW5pdCA9IGFtZGdwdV91bWNfcmFzX2xhdGVfaW5pdCwKIAkucXVlcnlfcmFzX2Vycm9yX2Nv
dW50ID0gdW1jX3Y2XzFfcXVlcnlfcmFzX2Vycm9yX2NvdW50LAogCS5xdWVyeV9yYXNfZXJyb3Jf
YWRkcmVzcyA9IHVtY192Nl8xX3F1ZXJ5X3Jhc19lcnJvcl9hZGRyZXNzLAotCS5lbmFibGVfdW1j
X2luZGV4X21vZGUgPSB1bWNfdjZfMV9lbmFibGVfdW1jX2luZGV4X21vZGUsCi0JLmRpc2FibGVf
dW1jX2luZGV4X21vZGUgPSB1bWNfdjZfMV9kaXNhYmxlX3VtY19pbmRleF9tb2RlLAogfTsKLS0g
CjIuMTcuMQoK

--_004_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB36633246687A079AE98979D5FB230MN2PR12MB3663namp_--
