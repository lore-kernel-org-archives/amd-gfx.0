Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FABC32770
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 03:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED9C222C3
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 03:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mBbQy8Rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED9C222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5716E16D;
	Fri,  3 Jan 2020 03:09:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750083.outbound.protection.outlook.com [40.107.75.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC806E16B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 03:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwcpQ2gwIBduukh2AQpl6WB9pWwL+qKqnBlhWjIrdo2JZaARC+POaK9qH1r/lg3RKz7Dm+DRgBoPxkg87DMNqlsS+ZheP8iwfLOfz72AiYeWZIlrdvIjPyb2vkCf2HjqS5c6gDfLhsv+vyt4ewnA6/+OsTJEMNMs0WWfrDFmqYSiS4TXYEe3FWbQqKnK5PqewD3Gidy2rhJqpgttuhlJHh4Te2Pd7IqqSYIFQS/0r8xUgt4c0Rn21iQCH+T0caR9cHneiJKpwwZPN4s9km78MUNtNldgEPnRRDFbhOPHjdMJKECgtjVdYtkE0TCjEXHajGsF18kVrUu0CbCLLCcAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+esxn9vB7qsHSIlggwE+f7TFapFmAutiJUjWDo/bsk=;
 b=WcNCfYGXwP/ES05ZaHvKI95NyWZZ8VmigUccRqX1LVhPTzGV072xmpEJXmoZOYA4473Z4rcElKgdrkCDm3J36RQWB+nAECC7WYgF6/dHnzc7h7dSRKIWuyiZhDoYTWM6jJ6rzf52Il9PBHbJpH/2NtwrbOzwR4gKf5T/v5lKpSHgvnob6Xe0C1oDwPfa73CEoT/4to2e4lPpMkkqs6NORcjufXzU+jfbP8F6AcbtQmbJINd62z9MXeBjCOiOhj3KuHEjl7xwvfBkTXxNuUAXV7Akqftwd76k6xPwx6Mv4oKJ75a0Vh1Dal/ytPn5DaaEsYWwjkkN2EL2ISUYY6YNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+esxn9vB7qsHSIlggwE+f7TFapFmAutiJUjWDo/bsk=;
 b=mBbQy8RjbtpUa54dcnn0Le/KWoARFCoimkF1+SJSgQjjrTqFD7XCF3DY6slN5PeTEhyC5yr42oFuBCkddnw6JUGiJscjRKD4k5bSPivr8UjH5OGfvH7Zm5Tggchv/LRBanWqOSS6tQeP2TEcLqCg+NjZ6kSxn+D6zOXrIy7++F0=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB2871.namprd12.prod.outlook.com (20.179.94.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 3 Jan 2020 03:09:10 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2581.014; Fri, 3 Jan 2020
 03:09:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Index: AdXBV3Yg76uTyzhkQhyxmQ2h5s6tpQAEeliQABnzfSAAA/7Q8AAANbQA
Date: Fri, 3 Jan 2020 03:09:09 +0000
Message-ID: <BYAPR12MB2806CBF02EBBD878FC6D53BAF1230@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <MN2PR12MB3663CB891846CB098EED1354FB200@MN2PR12MB3663.namprd12.prod.outlook.com>
 <DM5PR12MB141870C643D7A615B4BE392AFC200@DM5PR12MB1418.namprd12.prod.outlook.com>
 <BYAPR12MB28062F0EE6CBCCC870BBFA88F1230@BYAPR12MB2806.namprd12.prod.outlook.com>
 <MN2PR12MB36633246687A079AE98979D5FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB36633246687A079AE98979D5FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-03T01:06:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4f61058f-43a8-4e9b-b873-000097358b83;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-03T03:09:07Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1167aaac-465a-4385-98b9-000014510fb5
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2971716d-64b6-41c2-e7bb-08d78ffa4d8a
x-ms-traffictypediagnostic: BYAPR12MB2871:|BYAPR12MB2871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2871578959C35932E5260B29F1230@BYAPR12MB2871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(81156014)(81166006)(6506007)(186003)(33656002)(26005)(53546011)(6636002)(55016002)(478600001)(7696005)(76116006)(52536014)(66446008)(2906002)(8676002)(66476007)(71200400001)(64756008)(66946007)(316002)(110136005)(9686003)(8936002)(86362001)(66556008)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2871;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BvNFz89eOyzBlMkd3aAnOMdGYiLp9c52Jw6VU+6+IJPglGESA+s66CyDd9hLgYika38qgeTUIFNhpFCmTczShjQYwEPydnPJ7se4SvHzjRndgJJd4yTjS4eXIcfCsm6i6Zv0mr2mDqeprJwO5sc1pIwtrbrET96FuROIlMQBgSMLFQadhikRPAQvj4s3ntyIbwOlkIU+AQ60mZTAu7ankZv/rqQEzJAPoTaoZF1HVnSMzdK5tRkNAOA6DDtbPZ3MgWGA5DbMVscSULrok4rG+LcjVB/EWXl33B24y1uIpBtUu7TUhrI6cjRDy+svtf3TKVij99jVkpZRAtDvA+mXVqwhksb63x4X8ap9LzfWG0GUe6lA6Zqy2Kg1qY1rsNBPbCbVbElcZUEUJtNGRdModtwMQDhSuKeccwHrniWvCQykByaPouuN+7J56XZOn9JD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2971716d-64b6-41c2-e7bb-08d78ffa4d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 03:09:10.0120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KS6PGqB3u2aDF+xiXgkYt8kr/t+D2hrqp/OKjQV1b6KOxXfqjzbSfcYfb/4RyVZjjjc73zJY2NQ5ufIIazkUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2871
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
Content-Type: multipart/mixed; boundary="===============0860427266=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0860427266==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2806CBF02EBBD878FC6D53BAF1230BYAPR12MB2806namp_"

--_000_BYAPR12MB2806CBF02EBBD878FC6D53BAF1230BYAPR12MB2806namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Yes, John, that concern is cleared after I look into the code.

One more issue is, it's better that function get_umc_reg_offset is one stat=
ic inline function? With this problem fixed, the patch is: Reviewed-by: Guc=
hun Chen <guchun.chen@amd.com>

uint32_t get_umc_reg_offset(struct amdgpu_device *adev,
+                                             uint32_t umc_inst,
+                                             uint32_t ch_inst)

Regards,
Guchun

From: Clements, John <John.Clements@amd.com>
Sent: Friday, January 3, 2020 10:58 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query


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

From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Friday, January 3, 2020 9:07 AM
To: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; C=
lements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; amd-gf=
x@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
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

--_000_BYAPR12MB2806CBF02EBBD878FC6D53BAF1230BYAPR12MB2806namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle26
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
	{mso-list-id:2111730997;
	mso-list-template-ids:-1756342664;}
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
<p class=3D"MsoNormal">Yes, John, that concern is cleared after I look into=
 the code.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">One more issue is, it&#8217;s better that function g=
et_umc_reg_offset is one static inline function? With this problem fixed, t=
he patch is: Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">uint32_t get_umc_reg_offset(struct amdgpu_device *ad=
ev,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; uint32_t umc=
_inst,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; uint32_t ch_=
inst)<o:p></o:p></p>
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
<b>Sent:</b> Friday, January 3, 2020 10:58 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhang, Hawking &lt;Haw=
king.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org; Zhou1, Tao &lt;Tao.Z=
hou1@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter=
 query<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;<a href=3D"mailto:Guch=
un.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, January 3, 2020 9:07 AM<br>
<b>To:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Clements, John &lt;<a href=3D"mailto:John.Clemen=
ts@amd.com">John.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.=
com</a>&gt;<br>
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

--_000_BYAPR12MB2806CBF02EBBD878FC6D53BAF1230BYAPR12MB2806namp_--

--===============0860427266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0860427266==--
