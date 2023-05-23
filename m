Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EA6C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 15:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BF210E354;
	Tue, 23 May 2023 15:02:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E5A10E44F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 15:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCDrVhSvtjx7xF/6T152G2q978h01BZnDyavuTlvlDflNgS8PWm0xugfZ6H9dPMeSQo5OIpTDlFsE1FHISEDxFsgwlIQnEbi8j63oAZViOkM/Rc0D32L9pGTS/p46+ZoYWLQdy1pXFsSQkd7H+viZlTzGMgiIM9DDyVr41474gB99mpTd1zOu8x42AiWIjg/vsIB6JvWt5ibeNhiQ0UOCCFya31kFH2gAP/qkhRrDYMpTsvp1LC/1Etl/34Rz0B/vI8NkjRr9mfguJr8O6lBQS+AYclm1ELCqVg9IXwFSH/g7+io4CzSNxnyy6c2jwnXLsFIqT0saYQozsxrVTWisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPtctamLN7h8vT9rgwH7gX0ny5mtBhPEolVPRRt5rbI=;
 b=l/6Vls0chktWmAJn/TML0bCcNqoifAvpPAqULPR4DelBpqqKhIpzqO9iQA58v+nmWfKrb8+rVBcteDkiYQv+N0KaNXX7CZVGLkz7KMpujYJgkL6aGrcl5Q0yd4RhVP/wby+8NBjYDpjaD6WLRTU9oCDmZVtqKC342NflupYsWrD5DEavCteKekGeLFTwPgLLylyKvpzw7XFQbbeXk+JOPy51REUQQTkacyQetJRp9+jG6kyKq6eOcu2EEj+YM38OYSDwWrKhR3SozAVf3H9ltbdQbjgER4GTZkPT1DwmvWSP2/IJEcPAAhJgqF3abJ24wZeC0HWF28+f3WG/b90YWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPtctamLN7h8vT9rgwH7gX0ny5mtBhPEolVPRRt5rbI=;
 b=QND2kt52ZHmQl83cTlGbzwUCVBikK10nAN0Gdc9gmRNXwD3spXs6tYQA3vDQ5HbmMBuVSI1erJ5FukPXg8S1Y022CTrt9pVw1hn1f44Dho9rE1wUEhBAUhzDd0wF9HRzV9NnAfLr112IbEAflPQqtNJNmHmxDi4zAgCZT5vL210=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 15:02:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 15:02:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: reverse mclk and fclk clocks levels for renoir
Thread-Topic: [PATCH] drm/amd/pm: reverse mclk and fclk clocks levels for
 renoir
Thread-Index: AQHZjTPiCB+aMgUr2E+NSpuSpWtHJK9n9Kk4
Date: Tue, 23 May 2023 15:02:21 +0000
Message-ID: <BL1PR12MB5144AFD5ED7D7A6F62FF8707F7409@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230523050230.2564839-1-Tim.Huang@amd.com>
In-Reply-To: <20230523050230.2564839-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-23T15:02:21.051Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB7845:EE_
x-ms-office365-filtering-correlation-id: 6e292958-7b34-432a-1fb5-08db5b9eb5b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: naDw3I3IcQPKcQga9uAK6doWazRlVeYhm8qijzHASbbm3CtDUE6+Z4B3LmduJTQKQg1HzNNoyrPCvHtP7tbkRVuaCTKGkX8g2zl+CoXDo7zcgcKoPjdhN2Bk5mh4i1xBFlxKJ1HrRpDVrcGOC8cvLxWFgReG4coUMGxR/1/GJOFwezO0NNMxkeXzCfj6kxSGcYcs6fWQrGOD0Yxdtp27/ovgIgZiwnzoQLEH3ycwpKxqGCHRAlMAvefsw/QAKRT76iL5T5pufrhCUvLF7tassqnfR7P0qZPpmFFXMN9LPp9oIkgV7m3IwnxdRZN1y4wNN4oVwmWSNW+LIq9jGU06dDkyIV3dx8mc5X6Bwx/hAzLiS4tSbcKJY4KvhiG7XylEASFAct1HrAb2rsJnBEIXElfMyfd5gwSRc4DFWd8PxOQEfc3vj3dZE+Rx5aLXApOMKW1Gc5lPv7UPAx3Nn0iUP57RwyBA3nGkc3X6YLuna+OKGy0sOD1tAjgHs1ZzpRrBqK18/oPDaB1cfK3V2oLaHQXSV5cSgyPVxzze7OEUr640P1O5fgn0XVbleHeGDNZI1GKyOX8GlQWqmkx7g5b5ondmcNviXWVuYBz6qnraK0OX4wQcAa1XolRlw+96wyYk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(316002)(71200400001)(38070700005)(66556008)(64756008)(66476007)(4326008)(66446008)(66946007)(76116006)(478600001)(19627405001)(110136005)(8676002)(8936002)(7696005)(86362001)(41300700001)(52536014)(5660300002)(38100700002)(26005)(6506007)(33656002)(83380400001)(122000001)(9686003)(53546011)(55016003)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mzlCgWzuY0OWm+7cHwiwd9abimCzGRkZ1NdAqgzgcTir6gqkRBljPpSNJNPc?=
 =?us-ascii?Q?T/Z0zTIN1hL2QUGkgMOlWld/LNGZO+GwHVS8Anox0q5V49fKHZvUEMI6ERu2?=
 =?us-ascii?Q?FyjE0Dj8XsV4vhhFdkwjIf+qn1GuzoC+d7zTgVYD5ibZnic0M3HbXkw1cAHt?=
 =?us-ascii?Q?oFkKfTpXikMvQ8ejtJkQd9FECX+xtFyNzGBtYD36HpECrFuYa8PEGDUrpLrC?=
 =?us-ascii?Q?dX6u+cebXuCcreToIXXBjGT3LOuAeL9xpXPkbOOGWUNgjOSESeGq+NC9qJbL?=
 =?us-ascii?Q?ZJuaKp/MA2VNB88qittX1OABOx0s715caHwCX4nDF/9YnAdBr1EBjGIgDhFi?=
 =?us-ascii?Q?FYviKup2uSXR3/nJ9ywldZNUE+XeyObIUNBqpodWT2TokBnfeAsAMnuLVaPh?=
 =?us-ascii?Q?VE3oJQF+WPHcyl86ZvZrnfB2fUy26FOrsxJar82ic5seua4DLwxNFmQNaRIq?=
 =?us-ascii?Q?Qy1Se1x0nLJdsI6f0n1O6SCg+nwPl+RWd6S/vC8y7ycxfLMNnV2hkTaCtWDq?=
 =?us-ascii?Q?dfv7jnm9ftB6PfjQMq/7nooqkcLh4J1frrByS0B9gbxphiffi+fULbv6lay3?=
 =?us-ascii?Q?g3YHw4KWaa7LAPNnO1RLYUmvijLUTnInJ9eDbMcXL3a3PS1ki47SCe/pkMwO?=
 =?us-ascii?Q?oABpG9ZmxFRqiOQDhhcZuVMs4VdSMcqk2ExgAiXpNdSMsKpdBqSI3VEpU7At?=
 =?us-ascii?Q?Sd9iATxq09WbVp9HDaZUpKdLfgWUkrbqsvN97h6n956HO+mmi1CVbMSulVkf?=
 =?us-ascii?Q?WLNuRX1VCykmFoxskO2j3bZYmdeqHmJcmb0Io2y1m126dRclYEkBXk0PLQGP?=
 =?us-ascii?Q?aT2zRxUaUOqB//FI7oIohDATox2lOJ6Fm57uW9ilJ5kQpNGMrhhP13mecNhh?=
 =?us-ascii?Q?8AJHlJ9YzytQCPBwkH4ht3tSj/sZh/OsXMzjRa7ZDjAQh96+qOQuLHjxBBdX?=
 =?us-ascii?Q?TEO8bE+RBc2FdC9RVhLjDEf+R9fH9vPSNpErM9bsAaeklgarObwF0uHiYTwt?=
 =?us-ascii?Q?R9gTWno+ANB51c7et4qRP02OWyMpioZE5iIyJ0h0ue/C8uEqxj2uNDE5ViVD?=
 =?us-ascii?Q?spzMbCJJ7385NyR4RlvzkBGecMFILPMGt4c4hoiopK8lAsgR8u1eyFahtQe6?=
 =?us-ascii?Q?W39T0hmz6QSaVcvJ1yhQfbZHfm+GygRlJiwfsPdXUYQKsU3BY89p1DCvAE7A?=
 =?us-ascii?Q?fhcj2g3PsMgnwK1P5rjFdN1H24+abU2hdjurqIidpCjHyFydicC6Y52kJZbR?=
 =?us-ascii?Q?GSNQ223Ow27o/ZqXkql1pXioKrq513ThEvhPGvalu3L6LPRQ48ZN+vdHyV+1?=
 =?us-ascii?Q?ie8TS2vg7c53+qflOdbraouh7KWL+K10La2yoZtupr2jXMy+72GL13oWmmrC?=
 =?us-ascii?Q?t+DzDMQzOt8jO8YcVozWalTcM/YiJeA/DQYqNWmlb6aAPFBhq67w0ZnuqS6o?=
 =?us-ascii?Q?ww8Qpwxlg9BgKhwGS9Ycd2+N5+k4YeAzAWpoE0g4UxPEomPeq2HYz9a8Y4Xu?=
 =?us-ascii?Q?4SaVWvTp6lN6HHJjnQ42htQsPy3Czjg9O5Rd5I7/9pG4ZN2oZfbxhFT+lH00?=
 =?us-ascii?Q?kl5zgW6Fe15WbpsnPuU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144AFD5ED7D7A6F62FF8707F7409BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e292958-7b34-432a-1fb5-08db5b9eb5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 15:02:21.4216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOuqlPX9nwJJ9665GC6qCWB7I/e0GlghM7UhNq6XhDsfNzD6SxSgtz/lEhU91Jhh5w236q2SXcq2YDAeNi0O1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144AFD5ED7D7A6F62FF8707F7409BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Tuesday, May 23, 2023 1:02 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: reverse mclk and fclk clocks levels for renoir

This patch reverses the DPM clocks levels output of pp_dpm_mclk
and pp_dpm_fclk for renoir.

On dGPUs and older APUs we expose the levels from lowest clocks
to highest clocks. But for some APUs, the clocks levels are
given the reversed orders by PMFW. Like the memory DPM clocks
that are exposed by pp_dpm_mclk.

It's not intuitive that they are reversed on these APUs. All tools
and software that talks to the driver then has to know different ways
to interpret the data depending on the asic.

So we need to reverse them to expose the clocks levels from the
driver consistently.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 5cdc07165480..8a8ba25c9ad7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -494,7 +494,7 @@ static int renoir_set_fine_grain_gfx_freq_parameters(st=
ruct smu_context *smu)
 static int renoir_print_clk_levels(struct smu_context *smu,
                         enum smu_clk_type clk_type, char *buf)
 {
-       int i, size =3D 0, ret =3D 0;
+       int i, idx, size =3D 0, ret =3D 0;
         uint32_t cur_value =3D 0, value =3D 0, count =3D 0, min =3D 0, max=
 =3D 0;
         SmuMetrics_t metrics;
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
@@ -594,7 +594,8 @@ static int renoir_print_clk_levels(struct smu_context *=
smu,
         case SMU_VCLK:
         case SMU_DCLK:
                 for (i =3D 0; i < count; i++) {
-                       ret =3D renoir_get_dpm_clk_limited(smu, clk_type, i=
, &value);
+                       idx =3D (clk_type =3D=3D SMU_FCLK || clk_type =3D=
=3D SMU_MCLK) ? (count - i - 1) : i;
+                       ret =3D renoir_get_dpm_clk_limited(smu, clk_type, i=
dx, &value);
                         if (ret)
                                 return ret;
                         if (!value)
--
2.34.1


--_000_BL1PR12MB5144AFD5ED7D7A6F62FF8707F7409BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 23, 2023 1:02 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: reverse mclk and fclk clocks levels for=
 renoir</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch reverses the DPM clocks levels output o=
f pp_dpm_mclk<br>
and pp_dpm_fclk for renoir.<br>
<br>
On dGPUs and older APUs we expose the levels from lowest clocks<br>
to highest clocks. But for some APUs, the clocks levels are<br>
given the reversed orders by PMFW. Like the memory DPM clocks<br>
that are exposed by pp_dpm_mclk.<br>
<br>
It's not intuitive that they are reversed on these APUs. All tools<br>
and software that talks to the driver then has to know different ways<br>
to interpret the data depending on the asic.<br>
<br>
So we need to reverse them to expose the clocks levels from the<br>
driver consistently.<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 5 +++--<br>
&nbsp;1 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index 5cdc07165480..8a8ba25c9ad7 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -494,7 +494,7 @@ static int renoir_set_fine_grain_gfx_freq_parameters(st=
ruct smu_context *smu)<br>
&nbsp;static int renoir_print_clk_levels(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
smu_clk_type clk_type, char *buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, size =3D 0, ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, idx, size =3D 0, ret =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value =3D 0, =
value =3D 0, count =3D 0, min =3D 0, max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t metrics;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
@@ -594,7 +594,8 @@ static int renoir_print_clk_levels(struct smu_context *=
smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; count; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D renoir_g=
et_dpm_clk_limited(smu, clk_type, i, &amp;value);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx =3D (clk_typ=
e =3D=3D SMU_FCLK || clk_type =3D=3D SMU_MCLK) ? (count - i - 1) : i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D renoir_g=
et_dpm_clk_limited(smu, clk_type, idx, &amp;value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
et)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
value)<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144AFD5ED7D7A6F62FF8707F7409BL1PR12MB5144namp_--
