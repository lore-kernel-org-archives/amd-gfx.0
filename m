Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461EFC4828D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 13:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC44F112362;
	Mon,  5 Feb 2024 13:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sJW+6jnL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091BC1122F0
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 13:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZTF9SCnZpQxHcuG5l5tTL7juZsBkLlWzvjUPdw4xQxvCbSS/1m6N+/NDqYhC4zPaY6HQsh3vAWJN488avyVOVAA/384DE+Qpe+DvYdmA/7LYLBwUoFU5UdgyXlFQvQiISj6Nd2d+cAttnS155y6N0MII9Ti18crN5Ytdm1h9RxWDsTabn5+f3ygBMlWNyZfAkRQYEmYODU06HTmCGnjBekaC/B4iltrva5WYS2WXhRjq51LLQFcOzBoPvet/nkYKAiNjzXuAX9xgJ3dpNowxC62opf/ZJutQfzcS6aTC7J8Te+aUAliiOW3qXmwqI6dDo35WJMbCgXbVxkodrSBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISYeWZeGRoq796ZngvtE95X2nqG6xa+Y20JRa+s88WU=;
 b=QU8C3dsQY7UheVyGbfbNz8SpNlk793vQOyuu2kKs6PahHaD3uVIExwOFo/Bl0veLNdXLHEG4r2FY3mzMFGGatuFotV73/cJKqxO5CvQsBUTBiX8Ui+mwaxuPVOTFdBuT2RUxnvwfSoxoO6tfQXqyuGKdsVLRIDemO3DDLC/m0D4TNg9E7SLs+gSeatof4go7Idbtf29h46ni5Jtxzxbn/wnSS6OCs+mP0ng1XnMGvKcjHWTTIhnkW8yMjdRN4dd83dAkU5G1kjR9/aFjx/ap2rF27okg6Drdko59nMP4Pn2g9PNhG+Y5YAPECl2dfT1gr/iSCcJ7Zip7XPa4wSVrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISYeWZeGRoq796ZngvtE95X2nqG6xa+Y20JRa+s88WU=;
 b=sJW+6jnL5mCizSYyZr8fgxmu50OUZm+0z83t6if6JQPsi1FcOMZ2nDjDRGt+C434IRBLCnPy98mLAuqfBOkwbV4JVQU+ovQScgIDa3wCBJNm+1QV4vStsFKGb5iHtQyVBCqZRZY1UTqySW3svASRPmzCFTjn6m2uulN4gpjiNGM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 13:54:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 13:54:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Clear phantom stream count and plane
 count
Thread-Topic: [PATCH] drm/amd/display: Clear phantom stream count and plane
 count
Thread-Index: AQHaVm18VkU32OgioEOqEmuNOP+65rD7yJsV
Date: Mon, 5 Feb 2024 13:54:06 +0000
Message-ID: <BL1PR12MB5144A6B5116757AD3D053F09F7472@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240203003059.1333-1-mario.limonciello@amd.com>
In-Reply-To: <20240203003059.1333-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-05T13:54:05.723Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CYXPR12MB9426:EE_
x-ms-office365-filtering-correlation-id: ee35e0ba-ff93-4d01-5105-08dc2651eb50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59pXwxpZJLBnCTiwrxSgmhJxAE4GD4zBcZYwMdFZoUp8/yMP0n+bJnvURyA5LLFPBet1DP2gpHOdGZfoaiXa1hnWNIFC80c5AAJIVirt65hgI8ElJ7VtTO3XQIAltMAHwsZy+HpPJSCu2gDaLAg0miMT+R6DSFRVTXgcBPQPFfr30mEND4yAA5ee+niVayAc6SmbslO3tFIjXFxVMs2Gcjo0zuJSgzxV1T+UKxkSzmqtozSlV2By6Er6PaWhlXV2k0Zp/wPBP5cFZ3xVmq8uY6Cc9mz1GFhKUQMzReTzeAWotPYLpS1OgSMXV9Tgjjy/i0Gh0kgwp+mfyVVEPtB7yG4ODkpRXBhqWj+zLNIw1iNU59xI12708KA1Hn/wM2KLkjPQFFncizRr2xgEN8LRcjTWoXBGDk5VXvGGymcVs9Eh4xe1V1GjhrmstcWP5kWnTJbRXNcpe8ojsijONqYKvzaBRpzlEio5Hnekmd1JGhX7Pf++PSNfW/Z8Q2fhDMT87JhBg1qSUGwJrEqhs6LAzmsZ3brCsSIVZJxPnIe3W7yMZA1L2Q8kqdkhcXCr47MWGQm0XJaKDAtc+U2bML78SLGF5X9T9YRDU4AiIgDGAVL12PoiN2x7YjMJYMP6SEu2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(53546011)(9686003)(6506007)(38070700009)(7696005)(26005)(38100700002)(41300700001)(86362001)(122000001)(33656002)(71200400001)(8936002)(8676002)(2906002)(5660300002)(55016003)(52536014)(19627405001)(64756008)(66476007)(66946007)(66446008)(66556008)(316002)(110136005)(91956017)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?omibaDsygPgavqh8OnzgS+oRgiwDNT9MmPbP8VTZpdTUtK+iI8hArXf5fOXe?=
 =?us-ascii?Q?3WhKuMOlb2Ii37m/YOoqCKlQ0AVu57mpYeQEegBUAbAOY8/LeWIOJN7Xh9i8?=
 =?us-ascii?Q?iG5ZdYZSfTR0aDxQt8cvktx5WHySndIh4CmWp9x6M4wtaflQaC1w5Cse3J4Y?=
 =?us-ascii?Q?OdgUWHlZ1e0w+F/9iIdykS+fXmM2d0O2dLN+Xh5O8A0HbIWAhqQJJOvBmYjP?=
 =?us-ascii?Q?yRt9lTF/SP67YNxB9ikPuJJh+VxqwQIqII7ZljqrnCg1dS1WeMKqt7BIwD/b?=
 =?us-ascii?Q?bXolwtXGA4qwx+QLq8GBnMWp3BR4M2tTMxzucoLiVjFHMhe10dsVuRq5yHQy?=
 =?us-ascii?Q?eVRt4fBFNhWhRdz1b85l/Lbi5Kr/ybObdY1pvWuO9LjXfEF2dxx7wpWcHluL?=
 =?us-ascii?Q?sKWPbrKwyg98+56uMjNDcohoG4LrHQbfR8UW+wFyOkm7LvSUAayTOh+RUF0Y?=
 =?us-ascii?Q?jx5eRABQLCi2Nt+cm5NxoYodxxNBiLAyvYcV80lqvrGc8uxiPn1DyGjzYVGk?=
 =?us-ascii?Q?tPXz2dljvXd50NYt3hetIntS6M8Iu9fOnh17GRoD6yyb8UKjA6Sqyy8e+wtv?=
 =?us-ascii?Q?VI5823kL9xyNYXG5r8xmJ7cTX+53ILcDU+JRSV70qtlZVEZY52BN2yV2Jj7z?=
 =?us-ascii?Q?QIZhhTW4OhkFyoNBTMheL2ZTFTaoTWCQYhPcOjJnDNOVT1ArG9B2R3iNfYTo?=
 =?us-ascii?Q?eXv3GAUSRxrlVraGMClEvHOSX9F9Xj0MUyyeH053fyVKd2hOKqsWGF983Mhm?=
 =?us-ascii?Q?vC1lw/ROginMcAV0gOn16TOCX3hcBf/7JLhJnHpaHjrIU7XTnMKFazysGSR2?=
 =?us-ascii?Q?m5Gl8d8d6sK9D8egs/oZGoM+EEVar5ZSCULo/z6p+FfmVeiZDU/FoL8KZsRk?=
 =?us-ascii?Q?eMkYwA27Mgebh/n+Rj02jB4J/md2wLP3iw6Mwwn7aEf1eKn4rhuH7mgynm5I?=
 =?us-ascii?Q?O6ZlqfBQDnUV8feOAm1W7LiPK8K4rsireWrbq12m3+3LMc9egRDdG6BmtwzJ?=
 =?us-ascii?Q?lq3n+rQJK4Sb6BwhEXrzhJZffoisPozICxfcEs623t1rxtsIkOdnwoNZVZSF?=
 =?us-ascii?Q?5+REpVwYQA8ETYhg5WzaWhxdjahm9Kg5OPMd8jjV3JQMQQl1lGMDRo68gTGt?=
 =?us-ascii?Q?NQ1idt6rEvyb8tESy5Sy+W1B0A0T4s3L+qd10ig1ZwIxMYgwT0hFcbHGAp1u?=
 =?us-ascii?Q?Acgg6XzbFkUKo+3qQS5+QZ8mJR4W7/GwC2fXmlM8KI8/W4czomL9st2DbW+p?=
 =?us-ascii?Q?IX6DMXmCUo5DlE1cngB5/tZtw8kaoOT87zmMo8pgpGdVzYQbPGAmFtOiJ0AI?=
 =?us-ascii?Q?OCkCi5xuD43sX7cYu3mBnh7K4krcSF0xzoHRgJWgM7ylrTgyowVMfciuGrT5?=
 =?us-ascii?Q?ZFnUODjeIV3ueFUWstYdndZhUpOvHbH5DhSphqOPhsHpGJhQ1tlrBpOxTXfq?=
 =?us-ascii?Q?3LZYnPVbsLgcgn9IzmZ4OCQwgftTR2tz53gqgiRsSWnoIYJ98DaB6+j6nLm8?=
 =?us-ascii?Q?UmFuyKJnVGoAoLNPVM/RrsBrf911K0J8QwzsJOm2BLFUzkiNUUxL3noKk3pc?=
 =?us-ascii?Q?zqOsdiVuHrTJo/w0xsM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A6B5116757AD3D053F09F7472BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee35e0ba-ff93-4d01-5105-08dc2651eb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 13:54:06.1195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7ThByKh+YYezQOKyCjlybof02UxOrH/qFU7SxNbloUKIrkbol8qB18TfBS6e9VP5UT18+cytO0w91AGzU0vuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

--_000_BL1PR12MB5144A6B5116757AD3D053F09F7472BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Friday, February 2, 2024 7:30 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Clear phantom stream count and plane coun=
t

When dc_state_destruct() was refactored the new phantom_stream_count
and phantom_plane_count members weren't cleared.

Fixes: 012a04b1d6af ("drm/amd/display: Refactor phantom resource allocation=
")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/d=
rm/amd/display/dc/core/dc_state.c
index 88c6436b28b6..180ac47868c2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -291,11 +291,14 @@ void dc_state_destruct(struct dc_state *state)
                 dc_stream_release(state->phantom_streams[i]);
                 state->phantom_streams[i] =3D NULL;
         }
+       state->phantom_stream_count =3D 0;

         for (i =3D 0; i < state->phantom_plane_count; i++) {
                 dc_plane_state_release(state->phantom_planes[i]);
                 state->phantom_planes[i] =3D NULL;
         }
+       state->phantom_plane_count =3D 0;
+
         state->stream_mask =3D 0;
         memset(&state->res_ctx, 0, sizeof(state->res_ctx));
         memset(&state->pp_display_cfg, 0, sizeof(state->pp_display_cfg));
--
2.34.1


--_000_BL1PR12MB5144A6B5116757AD3D053F09F7472BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Friday, February 2, 2024 7:30 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Clear phantom stream count and pla=
ne count</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When dc_state_destruct() was refactored the new ph=
antom_stream_count<br>
and phantom_plane_count members weren't cleared.<br>
<br>
Fixes: 012a04b1d6af (&quot;drm/amd/display: Refactor phantom resource alloc=
ation&quot;)<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/d=
rm/amd/display/dc/core/dc_state.c<br>
index 88c6436b28b6..180ac47868c2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c<br>
@@ -291,11 +291,14 @@ void dc_state_destruct(struct dc_state *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc_stream_release(state-&gt;phantom_streams[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; state-&gt;phantom_streams[i] =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;phantom_stream_count =3D 0;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; state=
-&gt;phantom_plane_count; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc_plane_state_release(state-&gt;phantom_planes[i]);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; state-&gt;phantom_planes[i] =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;phantom_plane_count =3D 0;<=
br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;stream_mask =3D =
0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;state-&gt;res_=
ctx, 0, sizeof(state-&gt;res_ctx));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;state-&gt;pp_d=
isplay_cfg, 0, sizeof(state-&gt;pp_display_cfg));<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A6B5116757AD3D053F09F7472BL1PR12MB5144namp_--
