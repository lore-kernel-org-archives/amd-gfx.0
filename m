Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F36C47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 20:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B851206E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gCsobklq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B851206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CB66E57E;
	Mon, 11 May 2020 20:20:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2024B6E56D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 20:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUmeqW3RJdcn/UXx4nnlxTsu3S9DKtvI/ipudM8zbIS8zAwhf7ayrCb/7TDTxN7dOxKRH7mn3Z7RoNzgNOMBuHlLjKy5FuOG9gka1S2dbD87XbYX9Mm7b7d+w2XsPYaVu6UJ6j3TlKTz813WMLgB/Cc5uKU1AqhKtNXbFeXW7M3NxjXA5Qj7PLxqmE3LlV/5avaaBeyu4CPy0Dm5Lq2D3E4m9D1cmocCAFjHpv18kt1vlgh0Udt1X5voBqfnRVAVGMt23w6A/BzD6ytuOwB0uWsh+GFBSdXD8ibtuK//kPNm90aNJv91aXna2WsEX6ctz4/8c6kTV/GDy/P2V4cZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUwDlzcXDEyVA8sd9Hwt2g6qegyq+IWPfqUNguv+JW8=;
 b=I0fcVxuNbLvEJaOLVjPZRFElR2ponsPE+tvY1eN2Ncs6rGYLqMUuNd/X7dc540pPdMeyxXffrBTblt46SzVk8PIVtCo0+SaZNS8EAy1p/847dFvMC8G9+7aRSPVCYcAbXreiaVJ7HXPSVP3Q/FoWyfmHaKtD9vm1jyP9I3VrVUS0ON+qd5ygyO/Syac6xO14ATK9kFnOX/h3z9NdGgdZzzZy7U7cCYeVsgrWAH4k0gvuXzwYUZ3zF4mshzt0UCzG8mDDVzxeH24V9dEJGtffHMNe8eZ38CmOuxYlFXnOwM46u4Zp78WyyQJImOpfiCQ/zq7wb1CagbPVJRxSWhKZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUwDlzcXDEyVA8sd9Hwt2g6qegyq+IWPfqUNguv+JW8=;
 b=gCsobklqSvoPgzixxcjmoRlInWjA+skIKZv79F8pAwEh2wMnAlJ+Ds9waa81i7X2aP2xcm+c7rVlI16GG2Cuyfjz3Lcn06GeLOlxpW7emzXXSfICh5yDgN2RQLIRz2x4Dh29UnclaIRBQhcrDDYJbTc5ogobtZ0DawT4bSFoh/A=
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Mon, 11 May
 2020 20:20:33 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::9de3:cd20:5d34:3ca]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::9de3:cd20:5d34:3ca%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 20:20:33 +0000
From: "Ma, Hanghong" <Hanghong.Ma@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Update update_config() logic
Thread-Topic: [PATCH] drm/amd/amdgpu: Update update_config() logic
Thread-Index: AQHWJ8s/gnWcb/5VT0aeBl48VaUdAKijShQAgAAAP5CAAAE1AIAAB2uw
Date: Mon, 11 May 2020 20:20:33 +0000
Message-ID: <SA0PR12MB4349F814BCD3A437A34CE6E1F1A10@SA0PR12MB4349.namprd12.prod.outlook.com>
References: <20200511192853.11150-1-hanghong.ma@amd.com>
 <8954f030-f222-60d0-21ad-bb7155c67440@amd.com>,
 <SA0PR12MB43493D1ED5333EFF4170B001F1A10@SA0PR12MB4349.namprd12.prod.outlook.com>
 <MW3PR12MB45540F656CDB3770F88C964DF9A10@MW3PR12MB4554.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB45540F656CDB3770F88C964DF9A10@MW3PR12MB4554.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-11T19:51:28.089Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-11T20:20:32Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 34b8f86f-8690-437d-b02c-0000549e3747
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a004b156-b317-4792-0c8b-08d7f5e8c237
x-ms-traffictypediagnostic: SA0PR12MB4526:|SA0PR12MB4526:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4526EC76648A591BA90FEA20F1A10@SA0PR12MB4526.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpt0PoUcPaC6hiHTREQI+VgVp+EU38cUm8Vi9tfHAHfWOuK3CUyGY2Zw2GlXVf+2NhXuyT/jMk61n/iqx6HXiQeubmBOrqZtKmtCru7KHEV3YzGEQ8tHNthsh1QAXhtGnm8nbXtMqMFwFcFZiin1tu+DxdjV/Rkf1Y/UxT3b6Pkq2vAIjoCB+ufrAfLmOqo2gjJ1kUD1wkmrT0B7fWPP45fAMFVH8kc5EH/vRXY7Zgvo1J8NDpssgn7q2XrAlvO+pracYh8+PAaAy/1Dnvq5gMRTErWH7cGt8ibHZGVAixpUhJ/MWku/OZVE+c9BFPq/KF+yjN0hqHtkgYM7mFiQL6oiDcTQQBWboG7nmx+Wsk2UjkAOBqxCOuoYCni7Hda1L7OPJ5i0Hk6G2PBfulgzTebZ45QUWBWKvtUXCIwxDwe5fTQ2zcP+UNnpi2IWtf41SkxgUOBjglY+5r4aZQz5uZzc+JwKM7mC9o1xEDbEWKHDvG0ai7kQj1ToQV9Uxj2gbwfGTk83UQlW1UwxYsJfNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(33430700001)(26005)(55016002)(478600001)(53546011)(6506007)(66446008)(64756008)(66476007)(66556008)(66946007)(71200400001)(6636002)(33656002)(8676002)(15650500001)(5660300002)(9686003)(8936002)(186003)(4326008)(110136005)(316002)(7696005)(52536014)(76116006)(86362001)(2906002)(33440700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3nmDIskBv4tXRBvVh8JfXfTa/NhU38htJYmd90qAH6YSpefqtun4HVYHqcQD/wDNYriCLM6Fb3r5AXGOvmvlpghjKCrAcDOOhIxS5rjodqmKhPPN1GQH6rqiBDknB+sIV+LDyIKyQHUSK8wa/QP4cPdo+kYf2j8xb3fOeInxdB7NNpx8biUXfwIg+RYWn+tw68ZuA0Tk4cuvMHpzAiYBMtrmkkvL4PFVsPHnhCD4aFs0OA+xehag2aNVQr8RZ1oSWs2ZyHNktL7k8hU/Ub7P4FOKL8t/ekulZNOp8Ta9pC+suVveYQf3xQhdCwLTxCCKE4omeQg8k9gWa0+x51Cr/CHW/2e/Vie3xUvuviqiQuqeld3SLCGbbB9XzrafODPfkz2761Yu5pkZ8P/38Wc0LJYNV3tLJeC/QnKbX5bkPD7nrDIDICvbl2yOMTj+PABkV8/icTDZz7GyN97EmQ71EvJ08/iK1K4DZuS+AxdaJ80ma5dizwzGly9yxsFWL1ZY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a004b156-b317-4792-0c8b-08d7f5e8c237
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 20:20:33.5531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhG7KD/lC4fEASfOCE+joBceeI0roUcaE8a3mAqa13tribRSOdWa1x1h1SytC8m4FAz/iKL9/3bhuQQevGFv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1932300728=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1932300728==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA0PR12MB4349F814BCD3A437A34CE6E1F1A10SA0PR12MB4349namp_"

--_000_SA0PR12MB4349F814BCD3A437A34CE6E1F1A10SA0PR12MB4349namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

Merged.
Thanks for review.

-Leo
From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Sent: Monday, May 11, 2020 3:51 PM
To: Ma, Hanghong <Hanghong.Ma@amd.com>; Wentland, Harry <Harry.Wentland@amd=
.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/amdgpu: Update update_config() logic


[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpree=
t.Lakha@amd.com>>
________________________________
From: Ma, Hanghong <Hanghong.Ma@amd.com<mailto:Hanghong.Ma@amd.com>>
Sent: May 11, 2020 3:48 PM
To: Wentland, Harry <Harry.Wentland@amd.com<mailto:Harry.Wentland@amd.com>>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amd/amdgpu: Update update_config() logic

[AMD Official Use Only - Internal Distribution Only]

Thanks Harry.
I will drop the Change-Id before merging.

-Leo

-----Original Message-----
From: Wentland, Harry <Harry.Wentland@amd.com<mailto:Harry.Wentland@amd.com=
>>
Sent: Monday, May 11, 2020 3:46 PM
To: Ma, Hanghong <Hanghong.Ma@amd.com<mailto:Hanghong.Ma@amd.com>>; Lakha, =
Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@amd.com>>; =
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com<mailto:Harry.Wentland@amd.com>>
Subject: Re: [PATCH] drm/amd/amdgpu: Update update_config() logic

On 2020-05-11 3:28 p.m., Leo (Hanghong) Ma wrote:
> [Why]
> For MST case: when update_config is called to disable a stream, this
> clears the settings for all the streams on that link.
> We should only clear the settings for the stream that was disabled.
>
> [How]
> Clear the settings after the call to remove display is called.
>
> Change-Id: I8235998b8fac3d58d24edf86bb5d7cc030f1e375

Please drop the Change-Id before merging.

> Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com<mailto:hanghong.ma@=
amd.com>>

Reviewed-by: Harry Wentland <harry.wentland@amd.com<mailto:harry.wentland@a=
md.com>>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 10
> +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 78e1c11d4ae5..dcf84a61de37 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -398,15 +398,15 @@ static void update_config(void *handle, struct cp_p=
sp_stream_config *config)
>        struct mod_hdcp_display *display =3D &hdcp_work[link_index].displa=
y;
>        struct mod_hdcp_link *link =3D &hdcp_work[link_index].link;
>
> -     memset(display, 0, sizeof(*display));
> -     memset(link, 0, sizeof(*link));
> -
> -     display->index =3D aconnector->base.index;
> -
>        if (config->dpms_off) {
>                hdcp_remove_display(hdcp_work, link_index, aconnector);
>                return;
>        }
> +
> +     memset(display, 0, sizeof(*display));
> +     memset(link, 0, sizeof(*link));
> +
> +     display->index =3D aconnector->base.index;
>        display->state =3D MOD_HDCP_DISPLAY_ACTIVE;
>
>        if (aconnector->dc_sink !=3D NULL)
>

--_000_SA0PR12MB4349F814BCD3A437A34CE6E1F1A10SA0PR12MB4349namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
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
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Merged.<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks for review.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Leo<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakh=
a@amd.com&gt; <br>
<b>Sent:</b> Monday, May 11, 2020 3:51 PM<br>
<b>To:</b> Ma, Hanghong &lt;Hanghong.Ma@amd.com&gt;; Wentland, Harry &lt;Ha=
rry.Wentland@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Update update_config() logic<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Reviewe=
d-by: Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.com">Bh=
awanpreet.Lakha@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Ma, Hanghong &lt;<a href=3D"mailto:Hanghong.Ma@amd.=
com">Hanghong.Ma@amd.com</a>&gt;<br>
<b>Sent:</b> May 11, 2020 3:48 PM<br>
<b>To:</b> Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland@amd.com">Ha=
rry.Wentland@amd.com</a>&gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.c=
om">Bhawanpreet.Lakha@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/amdgpu: Update update_config() logic</s=
pan> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
Thanks Harry.<br>
I will drop the Change-Id before merging.<br>
<br>
-Leo<br>
<br>
-----Original Message-----<br>
From: Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland@amd.com">Harry.W=
entland@amd.com</a>&gt;
<br>
Sent: Monday, May 11, 2020 3:46 PM<br>
To: Ma, Hanghong &lt;<a href=3D"mailto:Hanghong.Ma@amd.com">Hanghong.Ma@amd=
.com</a>&gt;; Lakha, Bhawanpreet &lt;<a href=3D"mailto:Bhawanpreet.Lakha@am=
d.com">Bhawanpreet.Lakha@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland@amd.com">Harry.Wen=
tland@amd.com</a>&gt;<br>
Subject: Re: [PATCH] drm/amd/amdgpu: Update update_config() logic<br>
<br>
On 2020-05-11 3:28 p.m., Leo (Hanghong) Ma wrote:<br>
&gt; [Why]<br>
&gt; For MST case: when update_config is called to disable a stream, this <=
br>
&gt; clears the settings for all the streams on that link.<br>
&gt; We should only clear the settings for the stream that was disabled.<br=
>
&gt; <br>
&gt; [How]<br>
&gt; Clear the settings after the call to remove display is called.<br>
&gt; <br>
&gt; Change-Id: I8235998b8fac3d58d24edf86bb5d7cc030f1e375<br>
<br>
Please drop the Change-Id before merging.<br>
<br>
&gt; Signed-off-by: Leo (Hanghong) Ma &lt;<a href=3D"mailto:hanghong.ma@amd=
.com">hanghong.ma@amd.com</a>&gt;<br>
<br>
Reviewed-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland@amd.com">h=
arry.wentland@amd.com</a>&gt;<br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 10 <br>
&gt; &#43;&#43;&#43;&#43;&#43;-----<br>
&gt;&nbsp; 1 file changed, 5 insertions(&#43;), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c <b=
r>
&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&gt; index 78e1c11d4ae5..dcf84a61de37 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp=
.c<br>
&gt; @@ -398,15 &#43;398,15 @@ static void update_config(void *handle, stru=
ct cp_psp_stream_config *config)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display *dis=
play =3D &amp;hdcp_work[link_index].display;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_link *link =
=3D &amp;hdcp_work[link_index].link;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(display, 0, sizeof(*display));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(link, 0, sizeof(*link));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;index =3D aconnector-&gt;base.in=
dex;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (config-&gt;dpms_off) {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdcp_remove_display(hdcp_work, link_index, aconnector);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memset(display, 0, sizeof(*display));<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memset(link, 0, sizeof(*link));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;index =3D aconnector-&gt;bas=
e.index;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;state =3D MOD_HD=
CP_DISPLAY_ACTIVE;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aconnector-&gt;dc_sink !=
=3D NULL)<br>
&gt; <o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SA0PR12MB4349F814BCD3A437A34CE6E1F1A10SA0PR12MB4349namp_--

--===============1932300728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1932300728==--
