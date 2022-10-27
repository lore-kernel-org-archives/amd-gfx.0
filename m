Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CCFECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 16:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6836010E696;
	Thu, 27 Oct 2022 16:05:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F7A10E6AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 16:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR/0mJvI9ldjcZpZTGBuWdWj/0lL7Bd4ikLtbLMeDr4hX2zhbLUvW2xO66UiQE4A59cNL6aoDK0k5AvJlqnMfLTzeqYZ/cnNwOLt8oKfe7VTrwZaJNv1MfMXLBjkF+orv8adKxSXTAIRnLTTphm6KZvc1rh7W2DDZZKgW+TI+2wvqAYc+MAKQD9Iy1D928+kr1jtn2/229M3BKg/FRGraEN1oijlUWXLX19h52yQ7QpTP4EhLV6UOiuuYQn6x41vikYYQcOng3AdqWVOpe5M9dyi4WFFbHHcK3iJsmqhAIZH4N03SSny/Wq8bgyo08Lyix2LVLN3dzvdXY+7ZGMXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIGI6qlDSGSqCWcUCB62YcsCK428OnYeZwNgSVrelgU=;
 b=Cli5uSoPj91DP9mRkpH6YVadZy8BOXvAjhOJ2gAhHmFjE+ExluA8DH+d57XfgO/boulu8WMowlSjiViQ/umQW4jev365pGa0S+7qg77U/GRUK0e8HJQ5Gbm0QhX70NlTKDNV0DAnBeGPdrRIk8zvchp9dLBq7fxAtzOzjRfantc9cILaSviPbhd3RoLbywx20tKhUCkIr+rJoOCf1yo/3ALf1H8qBZo6OgAOSXnJFQwO9HhnDzgpgfk0g1oe7PTAo6yrQxyxZU4iWDITaQSfM8aD7d1Jh+vUudc0Biu5mAMN6lBCBihx8KYFrkie371AXrNFufM8S5Ip6V3Rh/FNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIGI6qlDSGSqCWcUCB62YcsCK428OnYeZwNgSVrelgU=;
 b=IPcfH3PhqrBmWEGkpryC2ulSEUdFsPBkLJbIF5P8X1tA8F439eJh6ccJvkvLWyutymOa0Q8YDuB1PQAFrK45S07q6qjhackuAoMDEeUKlIM23ugFDo+KtnirAt4xZHPmG7F02aWET/SD7xk/IdoxS3KQZnT44iFahhzbVyDCRRw=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.27; Thu, 27 Oct 2022 16:05:22 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::905d:6b27:ab75:97e3]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::905d:6b27:ab75:97e3%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 16:05:22 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sider, Graham"
 <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11
Thread-Topic: [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11
Thread-Index: AQHY6XcQRXC/5pNxdU2L8C7NGIyM864iROCAgAAj3FA=
Date: Thu, 27 Oct 2022 16:05:22 +0000
Message-ID: <CY8PR12MB70997C83CA4400B41968A4E88C339@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20221026201042.989337-1-Graham.Sider@amd.com>
 <BL1PR12MB5144244F27BC7BEBC1C0D92EF7339@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144244F27BC7BEBC1C0D92EF7339@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-27T16:05:20Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=acd44952-dd67-4c52-9eea-0fb41ea122ed;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DM4PR12MB6351:EE_
x-ms-office365-filtering-correlation-id: dcc39ecb-1823-4738-4c60-08dab8350da7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNLLNFpTDzuKC1Tx/puZokrp92gDXikg/heg//BJtGtYgTjdFDjczd+2eWMnwv4MFvLJSK7aibyDJZUz/5OnWukUIFtU7G5q9oM4vjzW8fwR+cdGWENRroXFcf8vos6vpv/KxqnkpyZr2W9VQhOdCBijdjMdZDnzgE0KAxSkWhefZjX9GoQlrnw9AJRwZUbmpd2VzputfTGGRx9hNj0QPGsYa+m8E2bb1Jb+QjTGCjwRU9zsD7cFy3rZBvWVjfsH3lYttGmRQxY0mTTe025pTNogUW8QR2waI2XuTMuh/SwpTRkle7CJpu/1tg7F08sv/FDQSro5sdwUPpoHXKmvyVbdpjOEsh3nfMLtoXQnqp1g9/dSBjQtKXLtRbB0rJjusCyN4fquLX7S7xjea2Ggbhawf0uLFbci3QkQupBC0nsJp4Ni43v6kCy8SbEOW8x8e6qd5tIQVWp1PqHm2pLyXxFo5eJdyjrIPN67BBUNiTgMHG1SzTz5GkvD7EUgwWCZNyCsMNOC0SlIu65b17hpZ5TcjGdc8YrfQ5rhCbUwCqcdn/beNTmNacSgFChBiPJSocm/uhhHAEp9E1XCrBNEXAGYBGDQWkHra7H8EjzvMukr6hpVy59Vuf72BtTsb5epzuumGgQgiCw+gnT0fgg4+byOSfm47qNfOIxI68gv+MeLRZGThzmQbsUT+GsT8Ias8NfMjl+VOfCqNVyBTKYaExGI4ZrtB6BFutJzSHl9btby5kWmX3QIi8tbViUF6f5iBtJ++zzrI79YV8KO3Z1GLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(71200400001)(8676002)(316002)(38070700005)(110136005)(186003)(83380400001)(38100700002)(6506007)(9686003)(26005)(53546011)(41300700001)(122000001)(8936002)(478600001)(5660300002)(7696005)(86362001)(52536014)(76116006)(66556008)(33656002)(55016003)(2906002)(66946007)(66446008)(66476007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XBni2Oebl1ljKogkV9GkpL73Goyv37x6SRDEYnbWQaEUYeYhfS+gWfXpKhFc?=
 =?us-ascii?Q?/sNnx40OwdkfV7uwOb41FUbOAn9U564NQ5r3ZFjY3ZIBnWUf5Qaa+xmaHqak?=
 =?us-ascii?Q?DAAH57mU8tICwYy3rOXDr1V/S6ug1LnjF2xdCPhyEgndwmbwmG+Y0l+Rs3P5?=
 =?us-ascii?Q?WE13y05INC0G0LKmOJI+Iz1rW2de/ZlA2it7zP4Ytg29hjbkr/u8TgBqsCVD?=
 =?us-ascii?Q?cab4gbnfSUo+3c3grCtF8kb88MZh8IqJt3su8036rhH47jts+2pJ2lrl+Jbx?=
 =?us-ascii?Q?bjHMxQnCTMTJIIjc3aCiBTkenmlfq/vzu0gRSddlvuEXgtMI8CoaoNGd/Ron?=
 =?us-ascii?Q?yquXMCssbyOXyfblxcCaH83f3Mg1qOQCZOXUguNpDCH5glMQiWzdx3H0NB7C?=
 =?us-ascii?Q?ZjqJeaLuFOIbkRJRWcXFhNxJNiv4fFF0cydasKigGjajPwFC2NAQ4Sp6ReKk?=
 =?us-ascii?Q?znzWrHNS4BkXCmXipjRViBH8GVpL3lIhA+JRKj06Ce2REn3dWrEEuc/1kv69?=
 =?us-ascii?Q?3i8d+Vox6odXYO3XjJEkJ2FS5tYORk49wX2iP66CxCb6JEKH8GtseaWklc4M?=
 =?us-ascii?Q?qgxazWQNzi42Gl954mk7FF7wF7XNWUKYOpYzD34ResI4/7YB7fuZPT6dXeHm?=
 =?us-ascii?Q?EYIcpR99sOVxlhlmm+X4h6o6mOT9xQViZ2SzgOIPr0DiQKt7ZVTL+EwXkw9G?=
 =?us-ascii?Q?arK12mjVSEv4e6xaOhxi1cOL+GkkF+jVES+Skzdjv67Mc7LajEl9UDUq+TKE?=
 =?us-ascii?Q?BRsfi/VhOqMUSe2jd9p7/3aItvUrLA6SKd+UR3JbNiD8K2K7tc5dvUxmveTr?=
 =?us-ascii?Q?LbB2e2e5jkwJxaqt/tW1Oa+Y2FaiOjsYEOWofDvQVpmgEpvc9xzHo3HaxU1v?=
 =?us-ascii?Q?eoENIBGZsdYpY806lutuFQ6KMUpULf8+YD/XDAUakTVedGEVWEIPGhma+i8u?=
 =?us-ascii?Q?aMQ0y5hbqyUFgANth9Fck1hQvCyAN45DzK1GDUXQoWXYFiDo5cRSIW4S0vcw?=
 =?us-ascii?Q?KcrWuG2fQgZZl8aLRzaEyKT3VvEzL0LM6voZhMxkehJyl7YYIHFytt1h5Y1e?=
 =?us-ascii?Q?zT18TmKOnmeqGfNHWDNwVdTxNAzsBJVaiizEknhhiFT626NUJ/hfcZk8EPK4?=
 =?us-ascii?Q?fyJNAlsMF9jszWJ9Gp4oLkHWqQDj6qsiveoKUimVtodqTDkEzO8pypAiuQzM?=
 =?us-ascii?Q?rfgHW8LhzV2NrB7QhRQ/QFeEZreWyvCwBXzmt+fOz2StS2dhL7Mr8ufrkFWF?=
 =?us-ascii?Q?omjYmOpQvFK+M6cDhELUfNGkidE1yedpZGJ2+67LO9PElfL4GLqwygh20Lm+?=
 =?us-ascii?Q?JLtetAcIcmBLjvH0dY3yMLBu2lmhOiFcDxkbkdIr7BKK0F0UwFI4TQROAjb2?=
 =?us-ascii?Q?2/iouxqLgMaWgby1DUDCKj4OyIrJ9akci95rfqZjZ1rHXZ6AXj+d0V7U4C54?=
 =?us-ascii?Q?HvppaL6HS1UxayYdTtDfJrYyqxXVmeE8LgpcPN2M9aVn87uwVP0csRZfW8KQ?=
 =?us-ascii?Q?rMJmG2gTul4Ip5VAdwfyMn6kiOsnEY6Z++AiW2tyovYAUur+YWTw1HSDFGlr?=
 =?us-ascii?Q?6yyy5yu3X7X/cwtkZFg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB70997C83CA4400B41968A4E88C339CY8PR12MB7099namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc39ecb-1823-4738-4c60-08dab8350da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 16:05:22.8191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3DA2KjenbUK91we+7gVPYKnFLXhFjiRswVEu8SG4P8Rc+pRAmZhovXdg49HBbG6+az8Usem083q8o11HYWmTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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

--_000_CY8PR12MB70997C83CA4400B41968A4E88C339CY8PR12MB7099namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Harish Kasiviswanathan  <Harish.Kasiviswanathan@amd.com>

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, October 27, 2022 9:56 AM
To: Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11


[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Graham Sider <Graham.Sider@amd.com<ma=
ilto:Graham.Sider@amd.com>>
Sent: Wednesday, October 26, 2022 4:10 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com<mailto:Harish.K=
asiviswanathan@amd.com>>; Sider, Graham <Graham.Sider@amd.com<mailto:Graham=
.Sider@amd.com>>
Subject: [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11

Temporary workaround to fix issues observed in some compute applications
when GFXOFF is enabled on GFX11.

Signed-off-by: Graham Sider <Graham.Sider@amd.com<mailto:Graham.Sider@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 37db39ba8718..0d764c15f6bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -706,6 +706,13 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev=
,

 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
+       /* Temporary workaround to fix issues observed in some
+        * compute applications when GFXOFF is enabled on GFX11.
+        */
+       if (IP_VERSION_MAJ(adev->ip_versions[GC_HWIP][0]) =3D=3D 11) {
+               pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
+               amdgpu_gfx_off_ctrl(adev, idle);
+       }
         amdgpu_dpm_switch_power_profile(adev,
                                         PP_SMC_POWER_PROFILE_COMPUTE,
                                         !idle);
--
2.25.1

--_000_CY8PR12MB70997C83CA4400B41968A4E88C339CY8PR12MB7099namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Harish Kasiviswanathan &nbsp;&lt;Harish=
.Kasiviswanathan@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, October 27, 2022 9:56 AM<br>
<b>To:</b> Sider, Graham &lt;Graham.Sider@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;<b=
r>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: disable GFXOFF during compute for G=
FX11<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">Acked-by: Alex Deucher &lt;<a href=3D"mailto:alexander.=
deucher@amd.com">alexander.deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Graham Sider &lt;<a href=3D"mailto:Graham.Sider@amd.com">Graham.Sider@amd=
.com</a>&gt;<br>
<b>Sent:</b> Wednesday, October 26, 2022 4:10 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;<a href=3D"mailto:Harish.Kasiviswana=
than@amd.com">Harish.Kasiviswanathan@amd.com</a>&gt;; Sider, Graham &lt;<a =
href=3D"mailto:Graham.Sider@amd.com">Graham.Sider@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11=
</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Temporary workaround =
to fix issues observed in some compute applications<br>
when GFXOFF is enabled on GFX11.<br>
<br>
Signed-off-by: Graham Sider &lt;<a href=3D"mailto:Graham.Sider@amd.com">Gra=
ham.Sider@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index 37db39ba8718..0d764c15f6bf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -706,6 +706,13 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev=
,<br>
&nbsp;<br>
&nbsp;void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool =
idle)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Temporary workaround to fix issues=
 observed in some<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * compute applications when GFX=
OFF is enabled on GFX11.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IP_VERSION_MAJ(adev-&gt;ip_versio=
ns[GC_HWIP][0]) =3D=3D 11) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;GFXOFF is %s\n&quot;, idle ? &quot;enabled&quot; =
: &quot;disabled&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_off_ctrl(adev, idle);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_switch_power_pr=
ofile(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_COMPUTE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; !idle);<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY8PR12MB70997C83CA4400B41968A4E88C339CY8PR12MB7099namp_--
