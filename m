Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F19C38A2A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 07:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437A9208D6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 07:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ovRv9ALc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437A9208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095396EA8C;
	Fri,  8 May 2020 07:10:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770077.outbound.protection.outlook.com [40.107.77.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571A96EA8C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 07:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T32P2Ad2lhDhGxyXLRaTVtDEzc0VjNqGsQZtQLu+10Q90vRINFOXoh3svvHAPkvdnnJTeFPH6+vwnCWX3CVfc4u4PM4xyFLcdjEV/pEum9YTRd8DriFziAhbZM37hEBFYO6LKiXwYu8Pnpfv5s3bx/79Ggdx3jZ7JqrX+wtt8fHidXn2290JGr2cIxfzvIi/IM0eAvI6wiR8DUJmd3YPIoFQJL4qnIiGavqmZG5XQBXlXvTPCO4+LyXgjppK2PXTe4OQkN8Sri9qFY6m+WNtUQtW7PI9gK5SaoYb9x1DpsLqLoEYTsFnZ7Pby+Bx2L3J8vZjXUfdAhp96y8xgcCBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxeuWethA+5wl+4Fzy6ypF7FXTPmBbaXqCl/SREZd+c=;
 b=g8XsCek3WyNtpA/+udSiJCtXPZWJLqyEbq4kBIBR60UOV7vNY9xsdFP/esswuaSwCMxdVG2LkHb9GeGlKkbS4ptSkPGg0zpxCuRWxC3Wtj4u1TuQ2pZXns9avOtAeH3/+RSeTLQhGPPkoHK1PXVg/Ih3tBW8kLvINW8QAAfIWhQ27E0at22cvVfuE27ftuvq+gygIQR5hvKIqCF/9wE6IhReBmS3y03d7OXTjEsZaciTw0/H7vOuq/bAvd7LBHlXSexDn/LDo8Bwsk0PXQEp2JpbltPnTIXDv/ygagphfmsoYfAXw592S+0B/KWRIyGmwyR7Dyv9a7ARSxmbmZhIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxeuWethA+5wl+4Fzy6ypF7FXTPmBbaXqCl/SREZd+c=;
 b=ovRv9ALcLyD9c8rCmo+4878CfzRtFHu24+2/Y6fDBEYP8eN9qacf39q08AIlFXRitmjtAV+hYIPHOCtYjmA12K2FNq252x0RVP/ZJt5ngpRsXpd4Z+yIW1PfFqWTxaW4tzAEmZ4VLrE861OhV2EyxMs+okolxA0CtY0tmVd3Gpo=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2716.namprd12.prod.outlook.com (2603:10b6:5:49::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Fri, 8 May 2020 07:10:55 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2958.034; Fri, 8 May 2020
 07:10:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Series to disallow XGMI link power down during RAS XGMI
 error injection   
Thread-Topic: [PATCH] Series to disallow XGMI link power down during RAS XGMI
 error injection   
Thread-Index: AdYlBM1jbW95+O6gQgCVQiz75SiPwQAAecYQ
Date: Fri, 8 May 2020 07:10:55 +0000
Message-ID: <DM6PR12MB4075E4C03FCCD8B0E453283EFCA20@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4032BA32212F2A8948471950FBA20@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032BA32212F2A8948471950FBA20@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-08T06:50:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=350d25b8-c3a3-4952-bf4d-0000925180f4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-08T07:10:53Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 53ed32d7-5859-484c-979c-00004d7addf7
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4f2f137-39ed-475d-a0f3-08d7f31ef39c
x-ms-traffictypediagnostic: DM6PR12MB2716:|DM6PR12MB2716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB271650A16BFF1A2DBB41C41EFCA20@DM6PR12MB2716.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dr55ok0EH4L+51V9g0qWIE8orBhOETXwOOYzkDHN0FlQTSTe/vfV2I/jKKMqjxwQ1LsUlK/Bcg7iqiZTFxt4H/KvSlvu/W3fugHFNSq1Kh305+ZTSU0YyYNiNW1I6ODeV68SEGtBkn6//zhFOrPAkWpPB0zhIqP6weuFe2QWaR3LBNagcc5BI87VQzy58tIW7pdxQAillSmHL6eRxsz3MRE8TJeRESJCPVfORYfyPHs/womJXjVo7NiejvLknQjZk+Py9xKOx8LVXAGv5N5uf2N8KFz6pNDyAvSPFuo+q7ueVKoq8zTyBcNE9Nshn2xRVMN2+SJTm3jxjVacFD3mX/1KmhQ6ouxBNkOsSPlQiviHdODJvut3sAyESL1RjPfnecNbDi7rJrd2v8xNtBGC/q+cTbM4vfLbjG+2WzJqgMQtJNTkp8wYJrfbT+80vOOEwNKK4etTUuwV/dM9+ioY7fqDHaHyKvmo89cDKfdJ/Y/l8pQVT4Oj8GT9/x6Gh7fhWFVXQbWVzH33zoa1ti9+Sbrcv8VBw7S0BSkC8VdmtNc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(33430700001)(33440700001)(8676002)(4744005)(71200400001)(33656002)(110136005)(83310400001)(8936002)(55016002)(83320400001)(83280400001)(5660300002)(66556008)(66476007)(66446008)(86362001)(53546011)(83290400001)(76116006)(64756008)(186003)(83300400001)(26005)(316002)(66946007)(478600001)(9686003)(2906002)(7696005)(52536014)(6506007)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: otdjpgmHOUf7kn/G+uhXG0528qU65Zo0UOYbRb/S0pphqCp78gzQw1iDup7MeDJVIWqLBeiiZsYfPhZXaPGfeCmxjlvLw+4H5/SHot5PtH3xEcMWIfr2sG0Txn7qumCpcdnTWLwLqbW753HL9uKcuembctCEtmgiFvXjIFmMFcKok4K9TvIZxYG46Nyz9sPjlepfcXknR2cQOT6bEKC3vWphccC6QrtGMpEYvCvUZfkiHsl1+N5wCZShX1cjvdgBcfFGB5N63vgmpTcUgONvcRyYflC+ggP9/P374xKzMsB4XwiZu39PSvQgnQ18vTClOJIv/dYW44Z10IIKd2ZeRKT0hH7EQVEO7XQn+s6PVnICwtdI8uqoydNkcfvHLYK2jSsCWlIWnRR+i6y1K4+rnMJ8PM2i6RBYAXQEbf3skTNJh40nwpcXZNWUFUN/DE1e/IEodgzfvPZznZpEuE00cGdeOWEtc/arktZBxtdQrWShBF8wnMLmEO49TDOTRU/w
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f2f137-39ed-475d-a0f3-08d7f31ef39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 07:10:55.7015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q64+8tdFj+IoaZxPL4iwYWQn7jsjsK8Y7XF10v3IZdd5knLnEwNqOBFXoVljbBV4LTBvUWLQ+Mb7LXfwMT39Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2716
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
Content-Type: multipart/mixed; boundary="===============0728824783=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0728824783==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075E4C03FCCD8B0E453283EFCA20DM6PR12MB4075namp_"

--_000_DM6PR12MB4075E4C03FCCD8B0E453283EFCA20DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Patch #1
+                             pr_err("[AllowXgmiPowerDown] failed!\n");
Please replace pr_xxx with dev_xxx to explicitly show device bdf in kernel =
message especially for mGPU use case

+             if (smu_version < 0x365000) {
Let's check pmfw 54.23.0 for backward compatibility.

Other than that, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Friday, May 8, 2020 14:51
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] Series to disallow XGMI link power down during RAS XGMI er=
ror injection


[AMD Official Use Only - Internal Distribution Only]

Submitting 3 patches for review:

  *   Added host to SMU FW cmd to enable/disable XGMI link power down
  *   Added DPM function for XGMI link power down control
  *   Disable XGMI link power down prior to issuing a XGMI RAS error

--_000_DM6PR12MB4075E4C03FCCD8B0E453283EFCA20DM6PR12MB4075namp_
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
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
	{mso-list-id:381831772;
	mso-list-type:hybrid;
	mso-list-template-ids:-1337145758 -291890196 67698691 67698693 67698689 67=
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
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-bidi-font-family:Symbol;}
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
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-bidi-font-family:Symbol;}
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
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
@list l1
	{mso-list-id:2074573187;
	mso-list-template-ids:-1303454106;}
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
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Patch #1<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;[AllowXgmiPower=
Down] failed!\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">Please replace pr_xxx with dev_xxx to explicitly sho=
w device bdf in kernel message especially for mGPU use case<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_version &lt; 0x365000) {<o:p></o:p></p>
<p class=3D"MsoNormal">Let&#8217;s check pmfw 54.23.0 for backward compatib=
ility.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Other than that, the series is<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Friday, May 8, 2020 14:51<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] Series to disallow XGMI link power down during RAS =
XGMI error injection
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting 3 patches for review:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo3">Added host to SMU FW cmd to enable/disable XGMI link power down<o:p><=
/o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:=
l0 level1 lfo3">Added DPM function for XGMI link power down control<o:p></o=
:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0=
 level1 lfo3">Disable XGMI link power down prior to issuing a XGMI RAS erro=
r<o:p></o:p></li></ul>
</div>
</body>
</html>

--_000_DM6PR12MB4075E4C03FCCD8B0E453283EFCA20DM6PR12MB4075namp_--

--===============0728824783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0728824783==--
