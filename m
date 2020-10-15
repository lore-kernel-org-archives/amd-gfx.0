Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1334C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 12:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9E422258
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 12:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z1qQvhIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9E422258
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FC16ECDB;
	Thu, 15 Oct 2020 12:43:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797F16ECDB
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 12:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL4s/yeb41wrWGUN+/YF1106EzbvjCDAqbeePHHjLUekTYfPr3oeX4I+tPnVAqlrAc+3QG1iVukQ+ifXw7Z2mD1PsL8uaCIqd0/9dk9ZxbuSA7BYjlwz159u66oEB2FcIst5i1o6zeH3n0K5P087gM618KFmWpxrcr/lsoraT3EXoV+ZHLZPeRFNxydsWYVUkFQZTKZosE8lG4IYQOzr8vehKNGSLJfvTnhAd7tlhZ+fPFQAN6czisneStIuGJuNNjLHAuxXP/GZzuRwEZ9zbI7A/HomYkvou1VTdtScbDjqllEndE54WW0ag2PTZaWln2/BwS0SO6R6/tHYkOrNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iSXfLzvJkMsSN/Wvw7aYn0/n6x04w33vmaouFN/uEo=;
 b=WzLqzlnOEy/nG6QOqrBIifvhvn0qaGJbV7J+hxzcmbNTYyg0PlYEaWfzbN+YlkZcyZ6UcOMNN0A2mF6iDJan7ifC7mKpkloVP9cOStJTxL+oEFLYfSzOPt+MWdv/A8iaJp+KFzI5SZm0TzTHzSLGb+tLqxtbg2Tqd14dIkjLaA8ZakSi3nrxy1BF72dcc796o/fu0guHld76ced/AF1gs+ADW307NgnDBNIi23nRC5/hvhypJ9Fv0bOL5wiSHaOY182/aOh9W8pKjzfjrFk9M1XJtg9gaxPqvVtBR9zM+IMxy0Jy1aHfFDJDUF62VFIMdesRIID8A2nqKOnt6F6OKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iSXfLzvJkMsSN/Wvw7aYn0/n6x04w33vmaouFN/uEo=;
 b=z1qQvhIfw3KxT2ejiKYOp/p0CmQm/nc0ratPicxaEX53ZA5uUxkqBWYGH2NERc1+mKWAsMpGtPmipMLYnw7xFwfF6G6LoELda2yshpJJoAbxzk7F7ffqlI0BxrTCXUUKjUBljM6MljVh6TNy9bFpTHxIcL+sWRX8dhUjovRFeFM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4845.namprd12.prod.outlook.com (2603:10b6:208:183::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 15 Oct
 2020 12:43:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 12:43:48 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Topic: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Index: AQHWop8I16s93P7fcUCAxviGL3E7Z6mYnFHK
Date: Thu, 15 Oct 2020 12:43:48 +0000
Message-ID: <MN2PR12MB448879BFA15D8DE556E18422F7020@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201015025745.139041-1-likun.gao@amd.com>
In-Reply-To: <20201015025745.139041-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-15T12:43:47.915Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eda621da-ab4a-42c3-564b-08d87107f66b
x-ms-traffictypediagnostic: MN2PR12MB4845:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB484531A3BFD46684970BA434F7020@MN2PR12MB4845.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFUCR6VWzaxT1X9Q9lCyCardxtERwxzMTs3opAYTWWpsFgKxbFrkjAz8zCC10ip8liMZO5FcWrxzf2i1mQd3xw6vddFmSQLqV8deiYmX5pHlbx3M5NS02knZM0QcTDiOBFoBCp/teUrPJ8vRUZESEjDgCSpFpn5ksS7I+Vw6L8UnfDYll12NzyEMVYUO41ZuTATUReeZTRpJe4Oj6kg6mQkBM4m0F2q/IDWQa3UVlvwhiQZAvPwuZn+H32YZCAuAyNkJRqY/+TMvn3PNAvrLvtzLxf12f/RqM0Lnfpkn3KMdH7hs2A8boJmNYrDGg4kTT4X9d26X7HOsLJiWarHJ/y8go8pNxZ1BQd1Ik/2/TVY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(83380400001)(55016002)(33656002)(86362001)(8936002)(71200400001)(2906002)(110136005)(316002)(5660300002)(52536014)(186003)(66446008)(66476007)(9686003)(166002)(66556008)(26005)(19627405001)(66946007)(7696005)(8676002)(45080400002)(15650500001)(6506007)(4326008)(53546011)(966005)(478600001)(64756008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wL5hUMD8tuFPaHaC35E4EscSvAsgNRy8wfq5txKwu3qQrdjtYAdxpgoVAU/+jvfjgt6yGCgWCBJTTLzLn5yjQzuenv0sIZVUv4hciFQJ917110KBioQ6xQI5fOTI3xv9EW7zHYgxybF1eLfmyNuiukgQvA8kiue5rRo1HqODzhOApTh3I2/rxflGCV1pSC1CR4jB3DUYfgCxXLHvt/i8v+Grr9ojAapO+Npy9x551AzXvBXddEosgXMlnpLEHMBqWEXhDvq6U57XPAUJJ3hcCn2/y2x2OJx0u34lf1DO/9+Jqk6MOw7yv3IPya8DkKWE+1T/YdHlYQCqRLBsvhh/QgSLGycP+LnyPoSaJtbY4FX2iydNYfvVeiH6nd+Y5Mxb7chW7VuyeH+5HSQFU/4+3feBSXfOpky54o77gEwdeBRqB10/E3MdkwrBfYOGpg0ZlzD1pU6VdPTizpDv0x08ffsYk09LNeMH2Fz+hH0/uNcfI4zr/cD7WiqT3hI6D64amOI3O8U7JSPkIuN0ZmWGGeLVOCw7Q4utXHBLNjsTSCFIKFaMZLXU5woqQ23G1X9X8uQZtXjZfOf0UuayPuafeagr7DSiVyTMHtEeOZfZM8L9ZvkJqhQYObobSjiOBjwL6dVcrio8OBznGH+HhmQHrQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda621da-ab4a-42c3-564b-08d87107f66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 12:43:48.5406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1UBj84ezviISGN7lidO+OULZoOPEmhPQ6d3TrPMpf1jhqR59AgKPggUXql3RFz99x3W7f/aj1yLUNwi/uKtcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4845
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1950718953=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1950718953==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448879BFA15D8DE556E18422F7020MN2PR12MB4488namp_"

--_000_MN2PR12MB448879BFA15D8DE556E18422F7020MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Likun Ga=
o <likun.gao@amd.com>
Sent: Wednesday, October 14, 2020 10:57 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I9a1ad84c22748fc100a3327487c6287e237df490
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index c4e9db3be39a..69e995155594 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3138,6 +3138,7 @@ static const struct soc15_reg_golden golden_settings_=
gc_10_3[] =3D
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, =
0xffffffcf),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1=
008),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x10f80988=
),
+       SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020=
),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200=
007),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xff=
ffffff, 0x00000800),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x000=
00820),
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C1c27e62b5c5343737d4808d870b62790%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637383274974363126&amp;sdata=3D9HWTZz2G%2B2vTyLoQp=
9DuFltve2bSs2HFYai072wZB8A%3D&amp;reserved=3D0

--_000_MN2PR12MB448879BFA15D8DE556E18422F7020MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Likun Gao &lt;likun.gao@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, October 14, 2020 10:57 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gao, Likun &lt;Likun.Gao@amd.com&gt;; Zhang, Hawking &lt;Hawking=
.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update golden setting for sienna_cichli=
d</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
<br>
Update golden setting for sienna_cichlid.<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
Change-Id: I9a1ad84c22748fc100a3327487c6287e237df490<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index c4e9db3be39a..69e995155594 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3138,6 +3138,7 @@ static const struct soc15_reg_golden golden_settings_=
gc_10_3[] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmGL2C_CTRL3, 0xf7ffffff, 0x10f80988),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_C=
ONFIG,&nbsp; 0x00000020, 0x00000020),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000820),<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C1c27e62b5c5343737d4808d870b62790%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637383274974363126&amp;amp;sdata=3D=
9HWTZz2G%2B2vTyLoQp9DuFltve2bSs2HFYai072wZB8A%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C1c27e62b5c5343737d4808d870b62790%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637383274974363126&amp;amp;sdata=3D9HWTZz2G%2B2vTy=
LoQp9DuFltve2bSs2HFYai072wZB8A%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448879BFA15D8DE556E18422F7020MN2PR12MB4488namp_--

--===============1950718953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1950718953==--
