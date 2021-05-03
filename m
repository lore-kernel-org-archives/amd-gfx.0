Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622DCC433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 17:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AAA610E9
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 17:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AAA610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D17D6E9EF;
	Mon,  3 May 2021 17:37:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24016E9EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 17:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq1TTpcwUBuhe/FZmhAGtisH9RRAc0FYh9qcNFNxIPH/gXWa1n76gSPHC2Es91r62v2PxIwZXGqPCxHnYFcL2jzNtWsvew3WMl5NP4r8wEA4pfmvLhQw+EvE7zvTvJnaBcXHO0+Z+vEvw4keQXOEa6p2nYZFwd9U7wlepkYareC/Q7+8kLwThOdYnfvRbZUhfl20kdbVm25wqEhTNJe4dJ7HkUKONECNzk8RVhy3EfaUXywuZAFJODnvdgj3SK4DWNov+/aC5r1xOW7pjiP5mhweUa+KOA3PbJlQpdloUVPOuqzx69QAPTFoIx8S7M02Ft6VQMtWVgt7OyKcTtM5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XOXuOILUL/KuWZN7DPO+A2KUPWYBEyaT5A8UYTeUq4=;
 b=jLN5JhktH7xMfEvS7VEnUgDKvm0MzhpRp11Ij7C1Xus0f2G1WIIh7ZO6In1zXGX+V6sL7yo+WTqGAACVabiDzo1rVUyPmczsrypteQk56HNoMvyX+mCZmzmUaCenzTdatf1Ei+wdIcEMPFNpAhXzLKpCNfKDBlfIy/RZjWByxwAvX8QqLLpMAz1fEknY3hEecRLfDkdWokYiLjZDyu4pmEQ3L7SOIM/q5xlqyNUlE2VGGG9XvxQPJIOzIcRbMhfiTZddxogb3gbCeoeHYr+bIVbz6o+ETWZp9NJo9E70N2OSl5HmwbwBhBE8OtTp9yg2dKTWGUnI+K+893nu+AiCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XOXuOILUL/KuWZN7DPO+A2KUPWYBEyaT5A8UYTeUq4=;
 b=RgOi0DX1h2pQOLZZVgz/FkYoQIziD7gNJf8i9G8y1Wq/uO/yyLEOicfWZuLxMphjiIFfC3uu/Ie0nytpXgLrR39N7S0o55jaFFtgUC1v72yu1MEfJ+zr1mppdNs1qphvYjj5BYZzk7Rnwy3M3mOlPSE4wOBa7yRftHhZdmyOBtg=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 17:37:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 17:37:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Update NV SIMD-per-CU to 2
Thread-Topic: [PATCH] Update NV SIMD-per-CU to 2
Thread-Index: AQHXQEFrnbQwv8xdEkmUbBGzXYlE0KrSA/YZ
Date: Mon, 3 May 2021 17:37:20 +0000
Message-ID: <MN2PR12MB44882D13ED7085DA125D6829F75B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210503172557.1130985-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20210503172557.1130985-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-03T17:37:20.361Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0ae609-595d-46ab-ac70-08d90e5a1af4
x-ms-traffictypediagnostic: MN2PR12MB3869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB386904776319CD0B813A6DBCF75B9@MN2PR12MB3869.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgJUhK4/NjFGYW3mIoV9XjsBsXPLZBw8+dQeKw5k2+Bu7xgjy/fABksKx/caByNuK8o1lUZa4BQxdk9CyjuBQf/9nVB5T2u1E9JS2cIyrRfDBchJ+xefM8scbuTBid4gPIgNKUvghHwpHME2yfit+Uuk+6DkoM+IutpUE+OiggbT9hHFRBesCnIp50LGFxjhxIutWl5g7nkSpnyoKWje58XTAn0G9kpAZD7pdFmDKNeJDq2dNHarBpvjqPH0qgUg7k9yGNhvSjR6PI7i1CrMUyN2z9YeYg4s+qtn1obnjW5Kdb6WpPTXz7GUqxR4hurs+kvTS5DSHH593s+c8gV/igqcM4iLyYn6QCL+HPCsxQqVJ2grKnE5OdL1AruE78FRYZFAjyYLAwrbEJQ28OlFLf41wNCHUpbnlqQpgATNJ8dmzKyCb9CInwso6AoZbXVpbwU1f3EAujwabnUJVteS5ln1ArV81blByyCsxioP4KrCXO1unbP4une67zMgAgNcP902eUvmfSfySC1ULOLpCw11VdTNxZlmaZEgl6MG5bFy2qi+Sg/htZ3cIo1uSnGSqIGfh5JD3ppjEybzweFw81itikjZNaMvQ0xqrC0s7hTX+VDNmjY5XLNP+/x5iQ5nlb/flyowlu00lZqBTFYoJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(4326008)(19627405001)(66556008)(52536014)(66446008)(53546011)(66946007)(76116006)(33656002)(86362001)(966005)(66476007)(26005)(7696005)(71200400001)(45080400002)(64756008)(6506007)(5660300002)(478600001)(9686003)(166002)(15650500001)(8676002)(110136005)(316002)(8936002)(83380400001)(55016002)(122000001)(38100700002)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/3+CN64JCFOUdAfEF+/BAYz6JnTBTd40UrKgrCnHYEHOh2re1JHnP8GqKBGA?=
 =?us-ascii?Q?54NxkntA3zBJ9Bk2XSgImZfm/dp15g+xofpCShYC7G+KKQE2EJoyS2NtA66Z?=
 =?us-ascii?Q?mNP5X7gYfdemL4+H0/9ztlwBviYxyF3pPc+87fJyU3HFzcC/UOrJKHzxUgln?=
 =?us-ascii?Q?iCwsQtcIfiM9dI0Fy2XP8ARkmxxNvSPz0giQtWh/Uv8tvu+ieFFSzfHNV4ac?=
 =?us-ascii?Q?xyDLOZB5KthUQHbypsZmh3aPK13FroBVOFhR03GAjYef78YD1FyAj7kGWDjI?=
 =?us-ascii?Q?pZY/pMW0kdeawcZxTPizXEJl9BeWT/Npq/z253BHV9raDPrenJtjblsBCqjV?=
 =?us-ascii?Q?7DgYv1d+tdlhcmpmZIdmIPwoNcKNzrTjdivlq710rHcLsEI6U3XCh9Wg9WfY?=
 =?us-ascii?Q?VIAogohTIWl9HQBTXdbngPIOxI9eaPvb9nS7bwW7tMvELhjow5HWw9Sfm1bZ?=
 =?us-ascii?Q?TbA5BgbAzJDDfL+Rmd2qYuewLHWiUGOPYbCymQkM/AwoqKiGsPFDPDJS481o?=
 =?us-ascii?Q?i3Bk/eS+vFrnx2AUrSvgOmOGF/Pa2vQwJKXbMlO20K6Qpnbxb+w+Ckafkrew?=
 =?us-ascii?Q?vbFTIRbPscVQe07wSs2JYEyE1VjovmaUzjc0NnSvHARSJ2XHj86y7ECnxZzP?=
 =?us-ascii?Q?0S4l0+nz3a/l9rLMwsPzk4GMEqgGTT7JdRnG+Wxv/IjyD2+hxg/9eQmsjZVz?=
 =?us-ascii?Q?u9MVYf9m1Oey9K4dgpPRzQaBmV0iT/l8bkFcIIzSRc5X766W4Z7M0JjKK1Q6?=
 =?us-ascii?Q?qCvDVFYCWu3ifmBwEUnY4ma0+r0V80p1o+ot+pYy1QBsXWkXX+xqXEBnxd8j?=
 =?us-ascii?Q?EBlbfN6qAG3PPw1Rq+pLQWG1zJG1HAjpYTpIDzOmECtDxfXARyULzyva9f11?=
 =?us-ascii?Q?ccjH6rm1ZH8z/yMhffaiX1kdlxwRFCk0KK4wiiP2rDt8qQtdCNV52rLUo9P6?=
 =?us-ascii?Q?kCr6mOJ0nvw67PGs9grtuvaKXBXB/zLtS26i67g5C2U/OcFlsu+KieBPY5KJ?=
 =?us-ascii?Q?JE93W0oWfW1DuytCim7NFF4oEAf9OJhmv/brGEVZ/f4NQzajGCPacFeEZ6LH?=
 =?us-ascii?Q?mupyNZcaFq4qoOIACU/830LKZXmR6t7JlBaU4sJmoed8Cnca9X7q8quf4O0v?=
 =?us-ascii?Q?BVgA/7VeMXv1DvKE9DzaeG3Iu1Wvzm+O3deWmu978Kl/jP7g7h8RTMOiPqOD?=
 =?us-ascii?Q?vKkZkIxpo9rs2ekGnj2CN2TNQg0fq29dl8OMQwN5rb9/hsTiJ1umdGLPHIib?=
 =?us-ascii?Q?R49Emn6YCJ0UJ7LcmN6uTIfCEkwdwit5ns9Vmx1MFQZ2fRfGL3acke+AbeF9?=
 =?us-ascii?Q?DfyJjscffUi9jJD5r4vHxn1V?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0ae609-595d-46ab-ac70-08d90e5a1af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 17:37:20.9125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WR39SHYcTN/svgghdYyFxAc4a+qCBCAIS1dSHONI4lkShphfDxhcJbGol3mNFiLkQdmvMDL0Xl2KZe+iiaGI9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
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
Content-Type: multipart/mixed; boundary="===============1722543555=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1722543555==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44882D13ED7085DA125D6829F75B9MN2PR12MB4488namp_"

--_000_MN2PR12MB44882D13ED7085DA125D6829F75B9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please fix the subject:
drm/amdgpu: Update NV SIMD-per-CU to 2
With that fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Joseph G=
reathouse <Joseph.Greathouse@amd.com>
Sent: Monday, May 3, 2021 1:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH] Update NV SIMD-per-CU to 2

Navi series GPUs have 2 SIMDs per CU (and then 2 CUs per WGP).
The NV enum headers incorrectly listed this as 4, which later meant
we were incorrectly reporting the number of SIMDs in the HSA
topology. This could cause problems down the line for user-space
applications that want to launch a fixed amount of work to each
SIMD.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: I94021ca71363a3d27330b2fda8e6acaac258017e
---
 drivers/gpu/drm/amd/include/navi10_enum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/navi10_enum.h b/drivers/gpu/drm/am=
d/include/navi10_enum.h
index d5ead9680c6e..84bcb96f76ea 100644
--- a/drivers/gpu/drm/amd/include/navi10_enum.h
+++ b/drivers/gpu/drm/amd/include/navi10_enum.h
@@ -430,7 +430,7 @@ ARRAY_2D_DEPTH                           =3D 0x00000001=
,
  */

 typedef enum ENUM_NUM_SIMD_PER_CU {
-NUM_SIMD_PER_CU                          =3D 0x00000004,
+NUM_SIMD_PER_CU                          =3D 0x00000002,
 } ENUM_NUM_SIMD_PER_CU;

 /*
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C0a03ae95bbda46750ed308d90e588bc6%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637556595746142277%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DJAHxu%2FPQTzHASsbie%2FnJGRX9B%2F17%2B6%2FXWeQnadzkj1I%3D&amp;reserved=
=3D0

--_000_MN2PR12MB44882D13ED7085DA125D6829F75B9MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please fix the subject:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
drm/amdgpu: <span class=3D"ITWTqi_23IoOPmK3O6ErT">Update NV SIMD-per-CU to =
2</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
With that fixed, the patch is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Joseph Greathouse &lt;Joseph.=
Greathouse@amd.com&gt;<br>
<b>Sent:</b> Monday, May 3, 2021 1:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Greathouse, Joseph &lt;Joseph.Greathouse@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] Update NV SIMD-per-CU to 2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Navi series GPUs have 2 SIMDs per CU (and then 2 C=
Us per WGP).<br>
The NV enum headers incorrectly listed this as 4, which later meant<br>
we were incorrectly reporting the number of SIMDs in the HSA<br>
topology. This could cause problems down the line for user-space<br>
applications that want to launch a fixed amount of work to each<br>
SIMD.<br>
<br>
Signed-off-by: Joseph Greathouse &lt;Joseph.Greathouse@amd.com&gt;<br>
Change-Id: I94021ca71363a3d27330b2fda8e6acaac258017e<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/navi10_enum.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/navi10_enum.h b/drivers/gpu/drm/am=
d/include/navi10_enum.h<br>
index d5ead9680c6e..84bcb96f76ea 100644<br>
--- a/drivers/gpu/drm/amd/include/navi10_enum.h<br>
+++ b/drivers/gpu/drm/amd/include/navi10_enum.h<br>
@@ -430,7 +430,7 @@ ARRAY_2D_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00000001,<br>
&nbsp; */<br>
&nbsp;<br>
&nbsp;typedef enum ENUM_NUM_SIMD_PER_CU {<br>
-NUM_SIMD_PER_CU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =3D 0x00000004,<br>
+NUM_SIMD_PER_CU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =3D 0x00000002,<br>
&nbsp;} ENUM_NUM_SIMD_PER_CU;<br>
&nbsp;<br>
&nbsp;/*<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C0a03ae95bbda46750ed308d90e588bc6%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637556595746142277%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DJAHxu%2FPQTzHASsbie%2FnJGRX9B%2F17%2B6%2FXWeQnadzkj1=
I%3D&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?=
url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&am=
p;amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C0a03ae95bbda46750ed308=
d90e588bc6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637556595746142277%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DJAHxu%2FPQTzHASsbie%2FnJGRX9B%2F17%2=
B6%2FXWeQnadzkj1I%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44882D13ED7085DA125D6829F75B9MN2PR12MB4488namp_--

--===============1722543555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1722543555==--
