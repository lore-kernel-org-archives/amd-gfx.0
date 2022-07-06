Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97951CCA481
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 15:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0542211A1D3;
	Wed,  6 Jul 2022 15:38:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2314A11A1D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 15:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWKa93BQtuZttF3JRSLI+li91okFBgsgzQBCWriGdJWMC7S4GaqVX3cBTecryOPHV0qoTpiWFyQlQhBzCSUeRaTf3Bhtreh0F92E1M96c6hiDOcsUitMJSEm/4+PIEY50T9NEqNATrEUdXvyGxdJMMat7eRh94VyVvHLb1Fw62+JdZiPxyTNOZ2cVmRdMiz+kiI+m+bZHdIssBxoLvsftrefaA20Ps4Zkkzpvr0kClnUb4yL/m96DYjoESzYtY4aCm0uDHKsJVwxQKyukAToljsTvCfLKS4MhUeCnciIvsHmcSu4YpS0Ak7/1or2J+QUtN9S6m12U3t9mdVYeY0xdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGKmA/eEi3De78KTt/uZy9xN9COMsJGrSRIb82U7lqI=;
 b=Vl6iS2IumJIMl0P61i71JuVYyRMn+Hrdw25eSSlOVXkgwpkjJqkTyYVcYUmHEX4GeEKxlZGJf1FnnD5qKAghSm7ANVL5++NEJT8jgbiJ1Nid+r4GU5bOqQqZBTwO5LUd9Whqn/jWHGaprIAVJCkNe+lckpWN/67yVLmEst/+FrVHVOT6teSwOIHh8Cojx/DH4j8vJIRWWAe3DmCxUlZHpMuDFNN8FNUcwc5l4i0t+W2/PI7eC5gcxWJMIY1GyThIivdmRPGMLKX4m5VsRXtz8r5eLQ11q1ZyJyy9bZdEjI37RviXuQZDOsrfgF0wuZEksOy1lTWBOpG9f1ZEKaDPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGKmA/eEi3De78KTt/uZy9xN9COMsJGrSRIb82U7lqI=;
 b=KC8ORO/NYn2GpCBQSzFrJBoM2pbzwP39vqtynVttXeizA3kz4slXQjDJq86SYbIJxv6nTaEoyqvFkFGTDHIDJ4LvI+2vfKJtqKB3KVIBKhYv3lOcwJvSOagCorS6ONAjSXxo6liagnyb2a4vh3yyjrG/0+2L3iwiN/cTXbm7P/c=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by MN2PR12MB4832.namprd12.prod.outlook.com (2603:10b6:208:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 15:38:47 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 15:38:47 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: remove stale debug setting
Thread-Topic: [PATCH] drm/amd/display: remove stale debug setting
Thread-Index: AQHYkUyUXTgoAHD+qUOMyG3cFp3d2K1xePWAgAABTfc=
Date: Wed, 6 Jul 2022 15:38:47 +0000
Message-ID: <CH0PR12MB5284D488666A83AFB2FFEC8B8B809@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20220706152507.1075669-1-aurabindo.pillai@amd.com>
 <BL1PR12MB51448A9C36B520C9C17F52DEF7809@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51448A9C36B520C9C17F52DEF7809@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-06T15:38:47.275Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3446cf42-e48f-42e8-4348-08da5f659e37
x-ms-traffictypediagnostic: MN2PR12MB4832:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QTqMJAefi4Sv9BAdtLqP2R0sim6AKPhNrAEUDfM6/a2j0D5c4sBkydBcSwAYvBMuBcgULMogSs5fQuiVIrhaiJ6G7XJX0nNLcwV7V3RRASxrHq3JMRNp00t4Z3vtQAjHqqV8zuA6hQZq4Ng5o8QJWaZFI9YCnW1liMvGVW8+iHamY3bMof7uc1KWAVAhUzKqflXGyUpzU6l7oYcyVM7tuORdzoTbp2y47KMBUsR+zxxbPKAsX/yJ7XdmFmkb0xHb+MOUkYoiJMH/XjuVzMoupXqWBGTz+8lTz40XBo2Rf97Nk6uY2IgbcX5gWC4v4Wqe4TLDgBkPiHFpiWhf3/Dahu5sZ4O8s0XgutBXWsx0NpPVZLV3VVbD1R/98Np6HT5NnycsXx9nN5bF4pioa4xxe3wAL98otKm0onmqG/bqBExqDebWiE708UqzdoUs3gLcNCddwPjERO67KEW3cUJz4dui94cITynTabGVM1Por8LcmAwwsUxxZF0NcRqK7QhOkJ7Lkkm3I8cwVxKCyOJ+HE6x80985ykKJ7Ue2In828R9xeb6U6dbf83jbDWzGo9q0dPcm345ZRUTXe21PGQgb1xTk88vDxgy/OD1RL/jazL5AvouqmOBqgyMDSPYr1OpFpokuD93AmHFEUERBEhwCDJllw1WMTNjt0aZSXY8g558V3Sx9aoU59qShfrvzynDzMN0fnQJPyHjDm1LLV6x40OHv3sfWo9niYSvq2TTcX4QW1Vu8d7+nXMYQ4MmdWbIwHwDwFykHwhS4OJQlfJST1WqgdMUXuYQsNYCXfyFnXXUS5SpPEOR/iwEVuL0XvAY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(52536014)(54906003)(19627405001)(110136005)(8936002)(5660300002)(4326008)(66946007)(66556008)(66476007)(66446008)(8676002)(316002)(64756008)(71200400001)(41300700001)(53546011)(6506007)(9686003)(7696005)(55016003)(478600001)(76116006)(2906002)(26005)(33656002)(186003)(83380400001)(38070700005)(86362001)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ESq1uPxfzaYwKKR/No5GcJF5GlNzJ/tzcWKv7B+mawwaiWQXoz5dV9O02+ld?=
 =?us-ascii?Q?dwP5kNd5MJjQyWesfBtMIyzm4V3E88jMsP9vDcTGsnVbMSnUPsGzPpbz4r49?=
 =?us-ascii?Q?aJUvJrxYxMZZqBfOAAXtUPp9FQsPQ4UirrgaRfIhYYJMESNkfT990g7TDiEW?=
 =?us-ascii?Q?waTpM9/lng7snyS1RyO6swP0HzsqSziH1VRzBWuN+c9wEHdn8s1dvpWKUExE?=
 =?us-ascii?Q?LRHJPKqk3iLofU7PTwzOSHpBaZLbKTKQNGGu/XUnx3p/bePPf1HEfrCPaErS?=
 =?us-ascii?Q?UHAEkj7fNC5eWzOchZJ992IJUmtV+rSjU8znib65sVGsbAxfB/WFp+NEMiV/?=
 =?us-ascii?Q?a0R7iptiy1+q4FBh2ZlglO/Gn6JwXSQURbDbmQjZzs3ZZ1+6qsShXGZ2wRoM?=
 =?us-ascii?Q?9AMJHxZIHDl4UfAxfZkVkP8tNPkdGGHCf7zGe7n7LEYxcPCuSZCU1ImfA4hk?=
 =?us-ascii?Q?EEi/OUqJaHLnxGET1ThJUYYDpD2uRsDrqT5ymCZeqwpQdlGfe1xCNVAzoQV6?=
 =?us-ascii?Q?b4Qs6m/GFwb51xjG5q8vCjutT3UuOivjzXHTVwN1ADYk4bBZhv/8ddj+pjpT?=
 =?us-ascii?Q?L2bo+NYFnG25Pn4gfvvD9qQLSkulugFDGjXUNMo+qsOPzed2VaKh9bmIiSoU?=
 =?us-ascii?Q?v2ntC5Z7/pDOdseNirFoDrkO2INYouGwVVDr4w9WSVC22GjVgaPJvMJKmf15?=
 =?us-ascii?Q?TBrF09iU0lKGAxj9ZzDRcU1ZM+i9/tC/Bczp7kioU/aQ8Wcbmgk3yALFmEVI?=
 =?us-ascii?Q?ExM29hCHTOPMQutrCcddVeI8NRTIeuz0i8Ice8R334EaSo1bFOaDg1C3PMaR?=
 =?us-ascii?Q?R7zBk3Cx8dssSpj1zkB69D2e0a4Fyy4yrYTMnLd6Kdrxa3l/K/XvF2IDyKXE?=
 =?us-ascii?Q?uhO5bg5g9Q40z7ODe+RUZRpAHo5D7RJ3/vsHVcrYXWthjtm0KHmAzFj1DlVm?=
 =?us-ascii?Q?oSqJNpVx6+WSry9wyHSYxr7KiICPaCViChvm8lsDa0P945rF1TC/eL3Fl3Ze?=
 =?us-ascii?Q?S17zFCN11ReQPGkkNqFWST0pB5zfzxYgjIJ/ZC5IZj9eMC1rfqA5Cilpwt16?=
 =?us-ascii?Q?1/iNs3AWzuNPBZGwJ/NJHqhTvymgoToDe3Dyr5nP8XGWWCzsIVAEmMxv3UNX?=
 =?us-ascii?Q?QRulCXukdUypoie47vhG534Lix+NYwppjXHnjjRca+shf3Ja+/kC3EVWJfTF?=
 =?us-ascii?Q?S9h+amdmHdMJH5sr1M+2knTBh5fLT9YHO07XGLBN1BPd985XU3sYK7D+hCR+?=
 =?us-ascii?Q?Vl4HwD3uZyIY1eh17C1E/n3wRT8cvBO/AcIUJxE/VNgiEyY7ADLQnp3pf3AE?=
 =?us-ascii?Q?VlY5oOU47vIV8yhlNCHOdD/QZPOilGSXjBJBUohQwE35GkX88N/mG0MtCSHs?=
 =?us-ascii?Q?OMPadgurAaZydVksNpzGekpU+xRiZw6/70JQGLZQCJ35IN5UQQd6merZ1hN4?=
 =?us-ascii?Q?rIj/5tH2FfyjCn46Q3kfAx1srG695gZJCIkqYumdIgXDU6QiR8Wb6EEU5Y7a?=
 =?us-ascii?Q?M83s4NWBYrlkbh4gEvbFpCy1ZuS8Bg3wcIcGbqULrzBOP9sD1zwFu/1cwywk?=
 =?us-ascii?Q?TNUe9eiUwSS5QTje3w4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284D488666A83AFB2FFEC8B8B809CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3446cf42-e48f-42e8-4348-08da5f659e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 15:38:47.6947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKxtr73ch3wWYEY2zfmdWsbKmloQ1v2iA647Lj6Z8p7Ta2GT0tIBSgwRpovZHg3xpLozyMk9RgXX4GH/HHRA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4832
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284D488666A83AFB2FFEC8B8B809CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks, will  merge with Cc and fixes tag

--

Regards,
Jay
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, July 6, 2022 11:33 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Wentland, Harry <Harry.We=
ntland@amd.com>
Subject: Re: [PATCH] drm/amd/display: remove stale debug setting


[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aurabind=
o Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, July 6, 2022 11:25 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: remove stale debug setting

[Why&How]
The debug option to disable idle power optimization can be dropped

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/g=
pu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index baaeaaff23df..1cc1296aed9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -736,7 +736,6 @@ void dcn32_init_hw(struct dc *dc)
         int edp_num;
         uint32_t backlight =3D MAX_BACKLIGHT_LEVEL;

-       dc->debug.disable_idle_power_optimizations =3D true;
         if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
                 dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);

--
2.37.0


--_000_CH0PR12MB5284D488666A83AFB2FFEC8B8B809CH0PR12MB5284namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Thanks, will&nbsp; merge with Cc and fixes tag<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 6, 2022 11:33 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Wentland, Ha=
rry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: remove stale debug setting</fo=
nt>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#008000=
; margin:15pt">
[Public]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,Arial,Helvetic=
a,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Aurabindo Pillai &lt;aurabi=
ndo.pillai@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 6, 2022 11:25 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aura=
bindo &lt;Aurabindo.Pillai@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: remove stale debug setting</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">[Why&amp;How]<br>
The debug option to disable idle power optimization can be dropped<br>
<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/g=
pu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
index baaeaaff23df..1cc1296aed9c 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
@@ -736,7 +736,6 @@ void dcn32_init_hw(struct dc *dc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int edp_num;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t backlight =3D MAX=
_BACKLIGHT_LEVEL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;debug.disable_idle_power_optim=
izations =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;clk_mgr &amp;&a=
mp; dc-&gt;clk_mgr-&gt;funcs-&gt;init_clocks)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc-&gt;clk_mgr-&gt;funcs-&gt;init_clocks(dc-&gt;clk_m=
gr);<br>
&nbsp;<br>
-- <br>
2.37.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB5284D488666A83AFB2FFEC8B8B809CH0PR12MB5284namp_--
