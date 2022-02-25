Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E231AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 15:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4AD10E17C;
	Fri, 25 Feb 2022 15:28:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E58310E17C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 15:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wojkph4ICjeb/BZ1UAKl+C2xhtLD+FHOghsPz0JRRrKzFCQb/7L1pqDbn4ZXC6LShsIxyvmnAQNu/VHdc8BSfftz+LwhtvwtY9XWhW8/FB/B1KU37TL4l/jHbMAqtwU541YSz1i297CSGP6q7oaH0/oXWnUT1DiMaUrwlkQONwiltOK4ubugggU0fOwujA0h3H/fqYoy1tXvWCtrxyLmv+B1P48TGnXskHs9zX2lnhJi+nHkP7HraQxwULoytaCw5sCdx334kSTJY3dCswA09n7BO+PSwKuOOQHVg2JFdcfxuB+yJ3vzZGLL3lcKORsxyUxUAdq88inuFc08HwdC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH8en6uv7/A9xAyk/T3DxZ8kGUMma5LMpO6IzNp5Xsg=;
 b=i3ud+GWhOu2L9U4hIuluro4OJGGcqGK/dPJPD0eCkXohmrCrqwg0IiSQjgCMv1+bm2NvWnDUS4XcTF6/rgqeMaVtmgxhMGKXUPD67rSTZRdH9Vsmb/vVXaIwio2sZoIa9v8QD9acQZ+8v8HWUzNntmkEoEedQlT3vzq+vWqAIIpoJoHqFUwEZMzacTv3fZKXFkuxq5ak+QJX7kHF578gQX/9fmYJVGZh5Yaz8CSSmjx4/2UnEYDgmLAOn+9Eqt6C0U89WByZ0whtWs84foxDz9TsHxsIBpBns1n/IDqyti2sGhSdHstzp1XsM7IR5HCMEB9Th1DVxrKrHB47Qoxm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH8en6uv7/A9xAyk/T3DxZ8kGUMma5LMpO6IzNp5Xsg=;
 b=xqeD8wNzGQzZhblc3283gMiF3fQMWYxCbFOyjuk9GFyWs3T5F2wC4cWPNFOPzF0CFXRG5nx+draiwkYHBzXsOUBuRS9L+aCU+4hXtNcoVvPXNaRiyEe12Kkp+9zEVp0+BnSbZ4pe6ddXxRnD6DKku7mOjt8DyzD4aWFaVDhSaWs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 15:28:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%6]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 15:28:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add gfxoff support for smu 13.0.5
Thread-Topic: [PATCH] drm/amdgpu: add gfxoff support for smu 13.0.5
Thread-Index: AQHYKiSyuLDsOSf41UibQhpxhkRkv6ykZGh8
Date: Fri, 25 Feb 2022 15:28:54 +0000
Message-ID: <BL1PR12MB5144ACF96FEF57D7760CF197F73E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220225084939.2096051-1-yifan1.zhang@amd.com>
In-Reply-To: <20220225084939.2096051-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-25T15:28:53.585Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 7c28a530-f36d-301d-f306-f75b8fcabbd7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e580111-9b78-463e-242b-08d9f873886b
x-ms-traffictypediagnostic: DM5PR12MB1354:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1354E2D3164BE27E2C6386B3F73E9@DM5PR12MB1354.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FtFbuwpnOrZ6el8PPpPPYV+v7wWS6iifvVa7JyMhjiEhZQhbUXWN8oiTsMbTZOK+WZrGWqhrHoFgf/wpBranzBlMDbAyEK+CFVBFRXUowUA+6EiUy2ATS4N//stwfSpYxJj/YVYnycPjHzJaCQtP195jgA/kwevc3c5u+UQwe3Qtd+pSSf9cr+0rpU0tJ4dKBzS3XZf+DTR+GTT52iZjizVbu/7FkW4uUuMe5mZx+yUeVkXWOlYVwmCbm6nKB8b8OKL8pV+0H1aOgbhnONcDnjTSclwJzoFAJsdFBMC/zJ6HwNBiRGV2JA0xuRFn2EyvVUcTtWnm8vGRRGpchBEJI7djhCC2bbyICYxlWCa7xd4R+EslQMjwTm6bB7AHz8BbeReIIFLqwvBf9lEE1R+Oog12Q0s4Aue1G1bBjP6VQpHYfY3H3vFQXPHndEPuPqdnatFVXTinw0Z2D5ZjA68I85JvMUJ7npWzsbblScNtgWDhvjP/8xEhS1xa4phd+ZFB3GM4wG3ZAD7YgCI7uGvSwLE7KFW1fKmFhvKJqbS3D9YsSSwS+rrTAdSSM3pcYuEvfJtcmqJvqat0IISKIyk1WXFIjKYlHc50rMcJEP3R1WVvPH2KLbryCtxScyICmodbAs7B2tOXuA+cRdsv+L0l2BGMkzwMSldR7vBcrMf6NcSMmq7/UNlKiAaKHwbC7RHyPbl7yjeHwtIc7N9mmgdLcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(71200400001)(6506007)(19627405001)(76116006)(38100700002)(66446008)(66476007)(66946007)(66556008)(64756008)(508600001)(33656002)(2906002)(26005)(186003)(110136005)(86362001)(4326008)(38070700005)(316002)(55016003)(52536014)(7696005)(5660300002)(8936002)(9686003)(53546011)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ifvPNinr7W6CR4cSblQadsWF15ljzpFDpF1Jhr1WJhn3/5II6kDxGtaSXeX?=
 =?us-ascii?Q?RT7cbZ/GFk4r8YjreqRpLJhabWmkq+Lz43xmg+/HyNSyo6es3jQthQ3cZSLI?=
 =?us-ascii?Q?lYg8I0yxoh8fpGPAxjiueaJmHAi7gDOPcRqLf9qSDscyxQKAxefBsm/AnVnA?=
 =?us-ascii?Q?U7dGYBIlTOL1hfICbu+sb7nII8yCc8edtEp1rNj8l1CQ52i25/USHT5syvdj?=
 =?us-ascii?Q?N2feF91ejarDcPAdoNUpzMK8FcxgW7FcT6epT8l3++ccqHiqBpOJ9Ekcj7T3?=
 =?us-ascii?Q?CbVQGI8IrjjTISCGzKlNmnCgUxrsR64sForXs2M4Fs9O4do66V5eX6i4GnIX?=
 =?us-ascii?Q?p26q+/rPYBG/Kl86zvbJokaTRbxAdANAkIvHvkI7YkCZQi/I+jvwcfJA3jpY?=
 =?us-ascii?Q?SI6RMgU8uRYP7cLI0GRzXdFMSHibXTqwoFhrD0k/DxPr7pOf4SUyrH2QmrtK?=
 =?us-ascii?Q?/G49ZzYvcbHD+MUGUY3IVAqSPRysiYZNaTkH72vyAsMXhJwRFMd1SpafFAlJ?=
 =?us-ascii?Q?DktCWDYZdwkvowDV/7+NIzO4SpOOhz/ZNcl8QgwBGZO3TSQ74zD4yste2hYi?=
 =?us-ascii?Q?uaIegI2yO7rCvxDrf+JjWhsQ6gKe6oV8xK2KfrMAJ6P3XoGURDBH5+zWh5Fj?=
 =?us-ascii?Q?PEy9ovFFywqlRaVWXLC6/UIrKWIiiBNGrlje8I+NqnAQFG5v40NQmFNZ97Nh?=
 =?us-ascii?Q?S6TsBgiCnn5nXOCezMfsOrKH7TWrvS3qkgTQ9xBjOhQZ+HoRlpChg2C4CGYN?=
 =?us-ascii?Q?OjHYbBfecXPgZwiGXgel6KDudpbyOVZ/o2S5F9uvxhcs2tIwSPedwTKVWdz7?=
 =?us-ascii?Q?LdmnYAtv8laVAHH8vabMlN03RzGvOybtos77QHyG/mSv7FZKR+zCcFauCrze?=
 =?us-ascii?Q?futYorWWznyfkeKgyyLPlru66XjwnxwJrTUafEOXQcn9j4rbJE5SYPrMrE1v?=
 =?us-ascii?Q?wL4hHPlolq9BzzZUqbZ3jHU9EJkATW1GbypDcPDNmTsazJ/4vrC0AA7AGRV6?=
 =?us-ascii?Q?T+hBQdTjxK65kXJMvJcZRmE7tJdVc6y6cPcErNJDzMhhYao12w+c6xlq0nZj?=
 =?us-ascii?Q?NY6ewtm/InOSpmD+ALwKqf3eJAYUjaAmyZe5Tkh6eaz1k3lwRWyec+ggooNi?=
 =?us-ascii?Q?+9+UGnPJyDu/zT7G/bs5KD3cadn5k1pox92MiXSziZVlw8TFTzYxJGP5ICrB?=
 =?us-ascii?Q?Vqpr76Pjfa1O3CAqsch6brmrsPm0VpCAy+ZdAQtRfXQKKny3vDC55/ZuOMe4?=
 =?us-ascii?Q?dZcg0es0ho81yDF6Rs/pxI7RZ65+6y6nhIHkjnHZ8KE17FeOVKVGGTMIJeZ1?=
 =?us-ascii?Q?Uk+iBE1C/sm0TtjMcZaGCdAoyBpF5I+XL13ejLpy6Lypdnb81xR2nErfEIWm?=
 =?us-ascii?Q?rOKfgpThgP23b+SLMcdJxjCqjQG5E6TeumrTUkD0bs/Ab1YIZwjRU8xUOIHz?=
 =?us-ascii?Q?8FAeygseTY9NUsQrToI/aUyzUxNOoP+wu6X2nP2Rcu7/JuBPO3YNTIUMkajJ?=
 =?us-ascii?Q?cXCj+ai49iWnCCmXZ1g7z+Iw6dwvvJQggRYyrNrndCfZKu0ZFlaSD/CN3965?=
 =?us-ascii?Q?1yuDlprFGabgeI2TeETA6oxSLaycsPmsMO9cg4ykJKALsVylivhSQXMGF4YC?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144ACF96FEF57D7760CF197F73E9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e580111-9b78-463e-242b-08d9f873886b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 15:28:54.2036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rck+9QZHmEv/I18a4vpWcEw5VHE1L4t6qwy7Zju2Q+HoidGJ7p0ErwVzgmuBhUOZm49DAjRnjuNEk6oJT8mGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144ACF96FEF57D7760CF197F73E9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Friday, February 25, 2022 3:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add gfxoff support for smu 13.0.5

this patch adds gfxoff support for smu 13.0.5

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 261a3749c089..4e557f4f7c4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -751,6 +751,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, =
bool enable)
         switch (adev->ip_versions[MP1_HWIP][0]) {
         case IP_VERSION(13, 0, 1):
         case IP_VERSION(13, 0, 3):
+       case IP_VERSION(13, 0, 5):
                 if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
                         return 0;
                 if (enable)
--
2.25.1


--_000_BL1PR12MB5144ACF96FEF57D7760CF197F73E9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Friday, February 25, 2022 3:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add gfxoff support for smu 13.0.5</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">this patch adds gfxoff support for smu 13.0.5<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 261a3749c089..4e557f4f7c4d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -751,6 +751,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, =
bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[MP1_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 5):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK))<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (enable)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144ACF96FEF57D7760CF197F73E9BL1PR12MB5144namp_--
