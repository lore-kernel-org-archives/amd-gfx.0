Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02659C5517A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 16:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D3420731
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 16:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q2MuiZ28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D3420731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB30C89BAC;
	Tue, 10 Nov 2020 16:26:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92EA89BD5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 16:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXhyU0r0Hcw0LjX6MrIPdQQyvxD5RNp8btk2GymaoDX3/ls0xgVlw5hSSc3n9hG1vJETAz74d8y+1GYTSye904+YMh/1iW1iB1mr/NmKDw/ukipLjKrv09L7KVsp5Dz2vu2Two4dO6qpIawkPbbH6vEbXJsKgLiJoBQgoN3oLVsNigTLbFqBMnwXKweqoVf79JyoaDpmFBR+rhNnM1cMtY71lltZducxP/t1QxWbB8ZlzAv5+xB/yWryFCuDugPIY35AlRY6XUC04m1WjxeGHHgCa/Eop5G6bnZGOB7pqfM4NMLIAjQUNaauy+OdAF0s4z8Hw4zN+FD2ZkR8aUAXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PuXTcB/xqFbB2C+jtUJQKwgQM4XF73TCVJ5lM40tM8=;
 b=V54MXPEa0hFdHhDoq0fTKBVUgweRGQp3aWYdU1SR1PhU+HlUsOwYnmO58S4AoJ2vdHhNXaPKyE2EqdHBQTeCNLjk62NKx5PGozPlYYotwl9aEw9A1lDgFe4mbhIlEm0tNPfydTYYkG2rjJW2i1Y9R7A1/TEJzR8Fvc1S284trvrol5RSQ8S3ibWWE8r00qkjTDNmmD4pga6AR6lOr69TG2Qyn24SZgD1CRkbgnWN5wvj6S8JK753S8R7JI5ZgRo7VaKUHV6pj8dfGGYpFT5TkWtjloG+Fh8zs10+Cog269DNqrds6TeCPLCCgopPg/g8/vovh///lyLdkg3exwOipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PuXTcB/xqFbB2C+jtUJQKwgQM4XF73TCVJ5lM40tM8=;
 b=Q2MuiZ28NCDvV96hyAt9ugjGWaLM8tAW+RGHcYXdI9rjDux4ju8SbBVoSiTdWaH7Ryk0Dqqhlz67tiaIeg5yThDK/qL6iK5cveSse1fv96OWKMApbVVsApW+krgjnDwoXUiOu33CRd4jBOu8gBtgZ+sWUr877AjvjUm8Gi7jFZ8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 16:26:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 16:26:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Wang, Chao-kai (Stylon)"
 <Stylon.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Thread-Topic: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Thread-Index: AQHWtzYiDKk3grY1AESJrpD+rZ4szqnBbMwAgAAg+fU=
Date: Tue, 10 Nov 2020 16:26:36 +0000
Message-ID: <MN2PR12MB4488F51CB06882617DE3BD60F7E90@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201110074912.54097-1-stylon.wang@amd.com>,
 <df99166b-de59-5aad-f921-b4263c082ca8@amd.com>
In-Reply-To: <df99166b-de59-5aad-f921-b4263c082ca8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-10T16:26:36.217Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bf6c57d-e8da-4a64-419f-08d885956536
x-ms-traffictypediagnostic: MN2PR12MB4078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4078BB3187C595C184188152F7E90@MN2PR12MB4078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayiyLxAhdoAWq7yYwDwbQAs1uzK2CGjsziI/klAsed8IaxabMw9/hfOQWMBcHFvCqasWhE/AI97TGh6H1oDpCYVIUGbXfAEfyezr6hBqxRAhrX0p/KVv5FvfioczB74UowwXP5qrTBL/yDbsKJ1PpcR/nyYOuqGUN/N+DoupD/t5OGC+kh0FvM9vF9pX9yOWPB1EnV5l+j86yDqGc15E7RDhzVMnZW/D5h64z9cnr498nUSiaReAUuVpxUQdFhBX+3SbZP88KV+0ZxVkYUCeKzRoGVTocAKxs56gbWpFtzZ9q0HUYS14vd5V79RjXtJW1HcnJTlTcZnp7NQ5fMyits0kJxzEvgyVmj3Jhyoawz4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(8936002)(33656002)(7696005)(19627405001)(316002)(110136005)(8676002)(71200400001)(86362001)(478600001)(966005)(64756008)(66556008)(66476007)(66946007)(76116006)(9686003)(4326008)(53546011)(6506007)(4001150100001)(66446008)(26005)(5660300002)(52536014)(55016002)(186003)(166002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Ep5jQOSRvtBaJcTzsrAsNnZCENP/GQscrmrSdoGi35hk8zUnYY477ofetbtHZPHOdHHliMdvGaXAxXab6gXTvFV9d5lvdaPMD58aDMxcCCRaGqCOjzkYpqh7t45uZjp7JDsp7nb4/P86BYkApI4wROlrCIChatdjiuetDjcqPKj+Dm1qzSDMSEKLbyijmJg/YZ/T34R7Je0WOokCKx9diSPfTQTvFlNpezqmgcHLFA4B7eOxXTnmL5qVrbhTaaoDU3Ke+osoPZxSRZvaeFb3fjKHHW5MP7Lc5ZYccTDt2blgiRWRmswlSH/bTALrqt+zAWz9jMSLs3VTpb6//HNREnAOAwOVfiesHRBlml5qp4kwkXQK4EE5+yHjfsYvo0PDciIg70PJxbNwOl5XSWafCXnLJbme/m1sxi3ogtvFL9wIflnVif0Yizs5qhQ6Klu5wZ8sMcw5uAthIViI9HD4Pm0VcpxW/i1rsXXaJVN5rkMy5rtJvof+fFYaEs9k7zyc4zpY0XtqpkzXWopI+MFDT+d1IFYlyIWD2KflS0N71/cRKK+eYhKz67jhEUWbPgRk7uHPzXtKgQPECCvxFK4DjKq80gQmGYlPMRRoT72lpJyq8kHmwfTvmBLBFdEzkwHT6zRWZS13E0xWRCW6h+42zwJwzoJ/UN3ekmHffABr9F2sZDsMkkvW9QgNYo+1pkNkiIbtSeRf21JkdTvArkzj2I4qdryfVEndZ10+Agi7rqMA1qKRdM0fR7jPuUpCSu2Gmn92FeTFKg9K28NJR2zcLhNvGqzTEHJ3z6Q8+1h89xz1RQO5uTgLGIpJUzdHNq2NHMw/hUgbirDHl86iDdhMWaEt9J9Fak28kDYA4E6S0qsIMwbr7Q3AM071H36uAzJw8v/lvTVaENv8+ttNCPWkGQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf6c57d-e8da-4a64-419f-08d885956536
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 16:26:36.7172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRRHZiHfZL2jVom71rqmMnvPk4s+EibwSWWwUUz83euc+8ZP/fl9OtHclb9A7fWBgnYCXwko0OUTAiYkSGsYkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============1941562541=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1941562541==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488F51CB06882617DE3BD60F7E90MN2PR12MB4488namp_"

--_000_MN2PR12MB4488F51CB06882617DE3BD60F7E90MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Lee Starnes just sent the exact same patch yesterday.  Please review that o=
ne:
https://patchwork.freedesktop.org/patch/399497/

Alex

________________________________
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Tuesday, November 10, 2020 9:27 AM
To: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; amd-gfx@lists.freedeskto=
p.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander =
<Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume

On 2020-11-10 2:49 a.m., Stylon Wang wrote:
> EDID parsing in S3 resume pushes new display modes
> to probed_modes list but doesn't consolidate to actual
> mode list. This creates a race condition when
> amdgpu_dm_connector_ddc_get_modes() re-initializes the
> list head without walking the list and results in  memory leak.
>
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>

Looks reasonable to me but haven't had a chance to understand whether
this is the best solution.

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0b6adf23d316..715e0bd489f8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(
>
>                        drm_connector_update_edid_property(connector,
>                                                           aconnector->edi=
d);
> -                     drm_add_edid_modes(connector, aconnector->edid);
> +                     aconnector->num_modes =3D drm_add_edid_modes(connec=
tor, aconnector->edid);
> +                     drm_connector_list_update(connector);
>
>                        if (aconnector->dc_link->aux_mode)
>                                drm_dp_cec_set_edid(&aconnector->dm_dp_aux=
.aux,
>

--_000_MN2PR12MB4488F51CB06882617DE3BD60F7E90MN2PR12MB4488namp_
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
Lee Starnes just sent the exact same patch yesterday.&nbsp; Please review t=
hat one:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://patchwork.freedesktop.org/patch/399497/" id=3D"LPlnk2605=
81">https://patchwork.freedesktop.org/patch/399497/</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wentland, Harry &lt;H=
arry.Wentland@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 10, 2020 9:27 AM<br>
<b>To:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; amd-gfx@lis=
ts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deuche=
r, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-11-10 2:49 a.m., Stylon Wang wrote:<br>
&gt; EDID parsing in S3 resume pushes new display modes<br>
&gt; to probed_modes list but doesn't consolidate to actual<br>
&gt; mode list. This creates a race condition when<br>
&gt; amdgpu_dm_connector_ddc_get_modes() re-initializes the<br>
&gt; list head without walking the list and results in&nbsp; memory leak.<b=
r>
&gt; <br>
&gt; Signed-off-by: Stylon Wang &lt;stylon.wang@amd.com&gt;<br>
<br>
Looks reasonable to me but haven't had a chance to understand whether <br>
this is the best solution.<br>
<br>
Acked-by: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-<=
br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 0b6adf23d316..715e0bd489f8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(<br=
>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_con=
nector_update_edid_property(connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;edid);<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_add_edid_modes(conn=
ector, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;num_mode=
s =3D drm_add_edid_modes(connector, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_list_upda=
te(connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aco=
nnector-&gt;dc_link-&gt;aux_mode)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_cec_set_edid(&amp;aconnecto=
r-&gt;dm_dp_aux.aux,<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488F51CB06882617DE3BD60F7E90MN2PR12MB4488namp_--

--===============1941562541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1941562541==--
