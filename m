Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B15DC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 19:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EED619F3
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 19:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EED619F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503A16EA62;
	Wed, 24 Mar 2021 19:00:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025876EA76
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 19:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtKPxlxWEoKgYHrJYW/YjBbWBEV5KYllk/lZUXO7+ZeEYNMAtYPQ12w3olZsG+9qH+FWEHCYXfSiDef9+3wWUzcw5Yx8XQXoG4h2fvneQgMWjwvXk48chtrsovrpwmRbj3Db/j/bfuzBaLMFbTj+QMfwl1iLrL/wjV8IFuQPmwH/B6g0LBtIxNQx/6KMu97A4hthuphp06bSmKzczYVjsEbNMz3eevUT8SlaS+q8h0wlsuyJ2qt0TMiR+Ftid5RSCG99tHa8uizw5GJpRPKiY8gkbraIm8LeNxspfYHo1LR2LglVUQ9JtuWOLATRbdQ2NUhCrsDwn9/8xJ2PfTeeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMsWRwVg5xQCvTgFOSgjYmshlAE8zHmD+cLpm0tbqWs=;
 b=hHPInCh+d8hdvvzmQ+/5MVmv46H096qqejl30qYSSDih1mAJxy+oAQDOutl5CKzfIv3iPSrwmqGYNOevw54mSHs7T3ci6qYQDpuU3p8YWd+WaVmeckhkDzUTqhtim1damQVgeAeUARAgHtuzSpefxVyGHNQTk+/JY00OyKmbQa/h38mvqY/XGB21qjIO7hGRSdFAVfsk4asVvIIMg24ES6//LFP0noRGF3GBjksSv6NPSXjuGw+cymc4cGhOkovZFgb3rcMYX9dOVt4EdFMr13AWuOg+GlBZacBPGnQxVg54bbC7C2+XLKi/b0UfliMjT7WcXetsp+cOpm8FWvZ7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMsWRwVg5xQCvTgFOSgjYmshlAE8zHmD+cLpm0tbqWs=;
 b=JpXJqAuYzD9UXPUt0NiRrd7RBGQeNPRKcr4s29qLXMIKOzLN2hKlHp+7EOtzkbSIlxRko4baJEZ8VcTB8KUD6hdsgXJJZjM5oMQ5qax3dHtY0LKyizoL/GkX35sVhMimBVzs79A0riJuR6ZuX1AGyXlwR7LsdkX7mN3pY+bwNYY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3870.namprd12.prod.outlook.com (2603:10b6:208:166::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 19:00:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 19:00:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix check for RAS support
Thread-Topic: [PATCH] drm/amdgpu: Fix check for RAS support
Thread-Index: AQHXIGw0Qve+/LUyg0qieNrlk4AowaqTfvqu
Date: Wed, 24 Mar 2021 19:00:28 +0000
Message-ID: <MN2PR12MB4488F9EC41617665F91A3EC3F7639@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210324051136.28653-1-luben.tuikov@amd.com>
In-Reply-To: <20210324051136.28653-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-24T19:00:27.589Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5871c289-49e7-4c96-2a15-08d8eef71715
x-ms-traffictypediagnostic: MN2PR12MB3870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3870605E4E3AFB54C88A036BF7639@MN2PR12MB3870.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3x6zpCAK9X/lyvDJiUYI34RCv582HjOk4fd4bSW/LlOamsoGQaZ7b6o/5+6jvpniZoTDXQKkQ/do3OZkQueX1gXsfVAXBVuqFyTWEW/+QGzSCPrNUbCzhOV3USgGzYvqXTGEbbmmYsmdMQa3nZe2R07tG74Muxj2yJhG2/nORbtUDpU0tcwcHuZrhb3iN2aheFu+9S3BcSqVN6US7tVD4Z3cbWteQLyBUU/Vfl3b8yBPdFa2+Y/Mz0HbJp4gHMtT3O2hCsCtwTjnA+hxy/wMFYYu1GtBPNZ2meZ2hr7TZV5Z3uUqV4Ma/ZgRSs0QmWYlo33K4a5OMFG9dnyFEA7IRkVAp7DdAXTfk605jDs83/tDkeFiyQ/GLKZVp8Lq8zJzYecth0VWqPu9YhV41QmEmKwSkZdZ60lPRqTfHRPhijTCmoJdNpqA+hhCPN0ZESE5PT76/zm2sZ2CMl32B6vRXW5YS2oZnTh5S+n1lgQibfAoJUjVS3Ueb8/HLQeogUEiTQlKup/C6y2yiPE/I+gu1IYb5eyRdBiIytP5VMkrZqy3J1XaXEYIBXCyU8K6L/VVGBbJbrNTWFj7UQ5Zk9VNYDC2GPXD5N/ZD7z2rXOnvuLeBdNaB7UJGXyrZF09alTyhXNtYPL5itKCfvyP1SfxqIrbfQ9wMdYaP3N9D5OykT8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(19627405001)(66946007)(7696005)(26005)(76116006)(4326008)(64756008)(71200400001)(38100700001)(66446008)(186003)(9686003)(83380400001)(53546011)(2906002)(6506007)(66476007)(66556008)(55016002)(316002)(8676002)(5660300002)(110136005)(33656002)(86362001)(52536014)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?T+hhjZChPGdMmseTsNVkM0jGQFC5uO8lL9Sh69E4377hVRnsKFNHQCFdVna6?=
 =?us-ascii?Q?CpILydznsmG1LMe0X5wPY9M2y/YXwFkyGA9IvOTHCJfl8IKHtPRzQL3TZk5N?=
 =?us-ascii?Q?LAg7bzw3AUKxcLyk2a6EnXZjOfwIzfgljufnJGRrs7GYVBohly2dtfHS38sP?=
 =?us-ascii?Q?rdGyhp9FfYQhPLd/6RS60iOs/HH1/YV0FOujh2tDFlV+Q5J3Qysp6lfeSR6N?=
 =?us-ascii?Q?7AaOwbRjSgtd1PgbbNKNs+SC5W3VrduJ9lWMFq8zQ4EptMTkZtPILTpIIL/S?=
 =?us-ascii?Q?itVCRY+9xzurmwsj9zYD5eF+1E9T7wA8ngVlKWxpDB93bhIJO2OEyjX0Yr5a?=
 =?us-ascii?Q?c405aJGTWNYfdyfGGGsCqpWwwLy9iVUt0vNLlBTXHZFY5ymwPpEZG8/fZDP8?=
 =?us-ascii?Q?tlA0KJhKDRcyb7C8zI2k1W9GKvy+fdH0YK01xfzghJNypEyxwbqOEuy4t/kE?=
 =?us-ascii?Q?iKmja2N8RJ8gXhqE0NEmRhVqOaWVteN9yiPr5RhoDZPmSp8TqfQLWrlIUshp?=
 =?us-ascii?Q?T4ye91xoMVGIG2j7hbPvj873TDiWJmDHKCOvyei4cNZB5YqAFGsz11N1OAP+?=
 =?us-ascii?Q?fP8xLU6bY/sCoOnU3NCzx+y46deIvDhmnHUZvihzyxI13VyR8DRAWXAef0fq?=
 =?us-ascii?Q?/OOrpImV8523one2zQIYNGt7/lqKW2xtt98lPnvOIM0wIDETTOM3Zb4dZ3ov?=
 =?us-ascii?Q?N9lp1jalk9tEg64dBCWE9lUzDjpApcLVLtK8fkWU1hEmZ63U1/MuJ94ds1Ip?=
 =?us-ascii?Q?EaBGnZpZ084a/Abp5Q+4UhsxXaUtHn3L9MWYxhvLu58pzbc3Ajzvt1d0lhQH?=
 =?us-ascii?Q?sfwitwof4Ih6IDZEdHQ9Qoev5vpJZtm/87FRdl6bFl7r32VgmOqyeKYH7uCF?=
 =?us-ascii?Q?xyjAE2sW0CPZz6NVra4XjtPfXu2FYSyPmivyAn2+r8IM+P5WHDPewiGYJBK5?=
 =?us-ascii?Q?b0ERqR0Yp9Yop3OKg0WTs/2Xhxqk2XzOWkeROxD6SQ09D4KTlGE7iQcPrO3/?=
 =?us-ascii?Q?poV1egC/hFVghHnxlzPtMGlKN/AgG5rR8rhtp/s+xlHsoW577oADN2/lYQaL?=
 =?us-ascii?Q?X4598owqNLaKVvcgL8ZTeMPETrelwgGD4gUhf6YwpANuHlKZ9sMJWiiP3uhX?=
 =?us-ascii?Q?i0Zp1/3wiKr3NxETm5HyEj/KuqOqUxziqoUbQMs5RkKbNza4zIyf2/N5ro2O?=
 =?us-ascii?Q?jn9VEeNY1ca5I9g24DZCEGPHiDqU9ftb8oNp5yMrUfdYQIbuV3hmZ03B17nu?=
 =?us-ascii?Q?Izyvlw+xL59BFMOjjCDIUVqk8BnOD/kSFFCQ7lCcechJn/6rg9ZT5PxZaE9t?=
 =?us-ascii?Q?x+WvFdbl2vbuF/rDXe1JWLp6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5871c289-49e7-4c96-2a15-08d8eef71715
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 19:00:28.1962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4T/TPVcPaNrFQNaKX4eRHek6OFc26P74+KfiYAfI/H6oxejwPeXWd2BTxu+bUN7D0cAfbqyaWHwC9jYAEsrUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3870
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: multipart/mixed; boundary="===============0196664976=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0196664976==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488F9EC41617665F91A3EC3F7639MN2PR12MB4488namp_"

--_000_MN2PR12MB4488F9EC41617665F91A3EC3F7639MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, March 24, 2021 1:11 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Yang, Stanley <Stanley.Yang@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix check for RAS support

Use positive logic to check for RAS
support. Rename the function to actually indicate
what it is testing for. Essentially, make the
function a predicate with the correct name.

Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 0e16683876aa..17652972fd49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1933,15 +1933,12 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_=
device *adev,
         return 0;
 }

-static int amdgpu_ras_check_asic_type(struct amdgpu_device *adev)
+static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 {
-       if (adev->asic_type !=3D CHIP_VEGA10 &&
-               adev->asic_type !=3D CHIP_VEGA20 &&
-               adev->asic_type !=3D CHIP_ARCTURUS &&
-               adev->asic_type !=3D CHIP_SIENNA_CICHLID)
-               return 1;
-       else
-               return 0;
+       return adev->asic_type =3D=3D CHIP_VEGA10 ||
+               adev->asic_type =3D=3D CHIP_VEGA20 ||
+               adev->asic_type =3D=3D CHIP_ARCTURUS ||
+               adev->asic_type =3D=3D CHIP_SIENNA_CICHLID;
 }

 /*
@@ -1960,7 +1957,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_=
device *adev,
         *supported =3D 0;

         if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
-               amdgpu_ras_check_asic_type(adev))
+           !amdgpu_ras_asic_supported(adev))
                 return;

         if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
--
2.31.0.97.g1424303384


--_000_MN2PR12MB4488F9EC41617665F91A3EC3F7639MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 24, 2021 1:11 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Yang, Stanley &lt;St=
anley.Yang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt=
;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix check for RAS support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use positive logic to check for RAS<br>
support. Rename the function to actually indicate<br>
what it is testing for. Essentially, make the<br>
function a predicate with the correct name.<br>
<br>
Cc: Stanley Yang &lt;Stanley.Yang@amd.com&gt;<br>
Cc: Alexander Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 ++++++---------<br>
&nbsp;1 file changed, 6 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 0e16683876aa..17652972fd49 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -1933,15 +1933,12 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int amdgpu_ras_check_asic_type(struct amdgpu_device *adev)<br>
+static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_VEGA=
10 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;asic_type !=3D CHIP_VEGA20 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;asic_type !=3D CHIP_ARCTURUS &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;asic_type !=3D CHIP_SIENNA_CICHLID)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;asic_type =3D=3D CHIP=
_VEGA10 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;asic_type =3D=3D CHIP_VEGA20 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;asic_type =3D=3D CHIP_ARCTURUS ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
@@ -1960,7 +1957,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *supported =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
|| !adev-&gt;is_atom_fw ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_check_asic_type(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_ras_a=
sic_supported(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_atomfirmware_me=
m_ecc_supported(adev)) {<br>
-- <br>
2.31.0.97.g1424303384<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488F9EC41617665F91A3EC3F7639MN2PR12MB4488namp_--

--===============0196664976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0196664976==--
