Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA26AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 08:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE34A64E36
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE34A64E36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E41E89FED;
	Mon,  1 Feb 2021 08:42:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F58E89FED
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 08:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9mIx9+8koFpr4izEDXF1C1JiWt3j2A8C6CeDBZvL1y+piL4vaDDdtPsPXaNHJZdiOdaWn1JnX8Z3u9kPg6AHs2NyXqu4IEeCcHcob7iqpCgf1KFgut6WZBBqYZQU7pY2i6AVO/AG3//nBxIsFamDp7An/weiduVzJSfomEBuqu/Qc+oZVxYO8y//+d42qaj/Nrkm/V5EJZiq5c01X5+NJZwd32IeznVcEN+d1i+0MFOa3cciRH5JihK0h8DgwznEHmIF1QaZoFOFkYrpoHXv6sJHQ4i8HT65AFOK08yyKw96KZmg6+jP/nsl0Mo58tuTja6ndxT7tkz93AdwlmnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC4OWoaZZ7DSTqgMilT+ea3VIicU0cISf4XRjTrCP0I=;
 b=i7F/v4ucpC3SW8kMOON+QpG7FZrnH8y//IhuGgRQhAxnaZbBGojCLfce3GCKM0s2GC6CRMRMLdeyLULpZ43/J8HfH2k6SAdU7No81W+p4xiXy7IixDBlMslExCLDuk/o4J0ujY3Yf9DpypNJcCepJBKmIDaRt2cI3uU+FzeTmxiZpOoq8a7oHp8dD830XZN9ivnHI3+4JWMLnDmTpSow+HsgOwAiZkz50EkyAjZixOyqhS7YW9YK4DqVe8LUffcGU7rNv2xncIYOEqW603fW8XGuozndMH7AP+JspeRAYWsalpcGa8K26Cybudi3dOfx5BIlPIkWQH8tjFcvpkSEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC4OWoaZZ7DSTqgMilT+ea3VIicU0cISf4XRjTrCP0I=;
 b=2v+guoTYQ+a0opaoNQ7sGLQxcMurBA86tXWdkvdw3FAc15b1IbvrTd1de2w4MZfA+r/+KBZBR9VTUf0NTb6+9wMHtZuTdBK+FErWblud7+qRr3YK4vLEPhNVi3Ht5nYLTn9WoWDOyPiYGU0MIfeNL6VPIqloyvRZgIKAFRpZyRA=
Received: from DM6PR12MB3018.namprd12.prod.outlook.com (20.178.30.11) by
 DM6PR12MB4266.namprd12.prod.outlook.com (10.141.186.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Mon, 1 Feb 2021 08:42:19 +0000
Received: from DM6PR12MB3018.namprd12.prod.outlook.com
 ([fe80::95c7:6e7d:17d2:ff99]) by DM6PR12MB3018.namprd12.prod.outlook.com
 ([fe80::95c7:6e7d:17d2:ff99%7]) with mapi id 15.20.3784.017; Mon, 1 Feb 2021
 08:42:19 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fill in the data member of v2 gpu metrics
 table for vangogh
Thread-Topic: [PATCH] drm/amd/pm: fill in the data member of v2 gpu metrics
 table for vangogh
Thread-Index: AQHW+HUFlH+MMclZqECmRJgC9yGTSKpC+0tC
Date: Mon, 1 Feb 2021 08:42:19 +0000
Message-ID: <DM6PR12MB3018DEDD016FA3612FBCFBC2A2B69@DM6PR12MB3018.namprd12.prod.outlook.com>
References: <20210201083340.28680-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210201083340.28680-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-01T08:42:18.801Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e106fa4-30b2-4a0e-3ebf-08d8c68d4968
x-ms-traffictypediagnostic: DM6PR12MB4266:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4266C8779413171EFBA4D055A2B69@DM6PR12MB4266.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XA7o2ITCVzDt6Zb2C91Hacfoq0MdveiA1cUD5r79Rxsx2/RG/lYdVtQ9qwORWgBmjythc05JqIPAG5tLHsuAZBAkINhx8PmRmuIZvcIP+Zyl60ID+zgMkmxozRQiOWTmUYrdF7PqzADpGj0NaI4zGEQJCvM44ugnfiNLSdV+ES+lVs0dWXoC8zamno662QWCujcWz/Z7g5kdJc2xZnMAYGogCH47Ix6SVnHCk6cNd0iDyHqFTtqLdw+DYHeEiBLDF6/qBWdYuLNkq3XvQL2Pyw9JeaCvV+D1DZGvgWMmSYEjYvuWV+TeMuFdb7OLy72u//LIHRYlNBg3dvySjQvSyqp8RuoNmfVmBqk7RBAst4sOdZJU9RvqoBwpI0sronpgeyVheViq3CoYbWr8TunKhoSkc8cY+8OfLtKCPz5VzSOANMkz1YkOtbZavIayCfK0g/BtuGV9d6I06xJI9wearjtNQxE9N+5f4p8kFfNJAcKwbUXZAw89PDq+jREJKBHs6RdBLxrHnEkRz/ebDog4pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(66446008)(66476007)(66556008)(5660300002)(64756008)(86362001)(8936002)(66946007)(8676002)(478600001)(53546011)(7696005)(76116006)(6506007)(2906002)(55016002)(316002)(91956017)(9686003)(26005)(33656002)(54906003)(110136005)(4326008)(186003)(19627405001)(71200400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?r2/iccTjho/es5cRlfUKbQnZNcfpotPdn+ywsRKmOcAGxnW8jDHaOuPCka?=
 =?iso-8859-1?Q?Uct8a/KEH+Z/LDsBwYd/1y5zMnl7Vax6LaGT2piGXLBZ8y5sb6+1x1G/k8?=
 =?iso-8859-1?Q?wCuhqit29nKPu3k9ApXkvEZLCtyu3q9AE/3nWOKw1HBod4CjPaMN/UXkcZ?=
 =?iso-8859-1?Q?j+/hkF/Oy/+yIpgdoNrV/C8kPWoyXbCA13cXyHg2ix5dt4h5n2MsIichq/?=
 =?iso-8859-1?Q?JhajxxEmZH4bsrqLplUF1MBLWtO1T3VG+xjqqhI1BtGAYKRhpaPREz/uaI?=
 =?iso-8859-1?Q?KsoGB3kA1F/xNLYs8QMNEq0p+L2xVahvG6ke7ylSQni8yEsORUNK7uwvZC?=
 =?iso-8859-1?Q?lz7NjylMSoYQ5vEu3i46GsWtncGsxVyfO1jD5cdEWrMpsbaysQacTXhScv?=
 =?iso-8859-1?Q?LL9cVLv/of7vA4SZgUFLDsrSOOl2NM9RlqzalWicvAfiHn1OrLah4rYASc?=
 =?iso-8859-1?Q?LUDye95JTrkpuWH47wXvdqWQkxCSTQDAqUrUwgPHUiEc7nwgkpWqIAJTNq?=
 =?iso-8859-1?Q?69F+claBl2oqam4cm8h83KJQ0QBaWBJ/4W0frDfVp/KqL4bxIZOujuyuwz?=
 =?iso-8859-1?Q?/PYL0+VuY94PdoCvgSlSt3QIZda8N+5h6SuP3rHb0JqOdcJ4M6+v07CnDH?=
 =?iso-8859-1?Q?z0coS9K7wTG4Hjy1codrJWtbx+bk4zZptPSldHYdTlZJeTvaKmPoVa4bYf?=
 =?iso-8859-1?Q?xqeRdIMSBzr8B/dGjvMzyEgHfL2O2GpTaOl2SB9LplP0v9vJKqt/Bn4POg?=
 =?iso-8859-1?Q?NU7GvThdVcjCB5UxsF6O8FM7N2TPGHrx24vnQv7wPSNLR0mLMWi9FaDwMP?=
 =?iso-8859-1?Q?zEKao/WwP+l2clVLtQjvbsRSwSR2UsyFvCkG5jC4p5rIvM5LC8jZ3K6Av6?=
 =?iso-8859-1?Q?wtrbqq4qZFN+N7rpaioWgh1m3rhOUMovuVUPRNyRSwbukXoriaZAenRWTX?=
 =?iso-8859-1?Q?+JypfSZg/x8b54e2AprLMxevBmlPO15WuH01teFTtnazvkwsLaKsYjoxff?=
 =?iso-8859-1?Q?r0u98Jc+9ti0kdJQe7Z4eNKniKJsQvyyobg07U22qqi9vP8XjlP8c24gwj?=
 =?iso-8859-1?Q?LZWJpYWs1MNPFEona9O+Ivl9cR8FX875cmA/OIRiLc0J?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e106fa4-30b2-4a0e-3ebf-08d8c68d4968
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 08:42:19.6022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvQFeZCf8QwZRJqYYhMy73cUY475AheH3U1uh5aM2wU2fsBTZasxH9vFKXYTBRnt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============2136326326=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2136326326==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3018DEDD016FA3612FBCFBC2A2B69DM6PR12MB3018namp_"

--_000_DM6PR12MB3018DEDD016FA3612FBCFBC2A2B69DM6PR12MB3018namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Monday, February 1, 2021 4:33 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, K=
evin(Yang) <Kevin1.Wang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/pm: fill in the data member of v2 gpu metrics tabl=
e for vangogh

This patch is to fill in the data member of v2 gpu metrics
table for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6d3c556dbe6b..4726cac8d824 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1422,14 +1422,17 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_c=
ontext *smu,
         gpu_metrics->average_socket_power =3D metrics.CurrentSocketPower;
         gpu_metrics->average_cpu_power =3D metrics.Power[0];
         gpu_metrics->average_soc_power =3D metrics.Power[1];
+       gpu_metrics->average_gfx_power =3D metrics.Power[2];
         memcpy(&gpu_metrics->average_core_power[0],
                 &metrics.CorePower[0],
                 sizeof(uint16_t) * 8);

         gpu_metrics->average_gfxclk_frequency =3D metrics.GfxclkFrequency;
         gpu_metrics->average_socclk_frequency =3D metrics.SocclkFrequency;
+       gpu_metrics->average_uclk_frequency =3D metrics.MemclkFrequency;
         gpu_metrics->average_fclk_frequency =3D metrics.MemclkFrequency;
         gpu_metrics->average_vclk_frequency =3D metrics.VclkFrequency;
+       gpu_metrics->average_dclk_frequency =3D metrics.DclkFrequency;

         memcpy(&gpu_metrics->current_coreclk[0],
                 &metrics.CoreFrequency[0],
--
2.17.1


--_000_DM6PR12MB3018DEDD016FA3612FBCFBC2A2B69DM6PR12MB3018namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">Reviewed-by: Kevin Wang
 &lt;kevin1.wang@amd.com&gt;</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">Best Regards,</span></div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">Kevin</span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Du, Xiaojian &lt;Xiao=
jian.Du@amd.com&gt;<br>
<b>Sent:</b> Monday, February 1, 2021 4:33 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Du, Xiaojian &lt=
;Xiaojian.Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: fill in the data member of v2 gpu metri=
cs table for vangogh</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This patch is to fill in the data member of v2 gpu=
 metrics<br>
table for vangogh.<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 6d3c556dbe6b..4726cac8d824 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1422,14 +1422,17 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_so=
cket_power =3D metrics.CurrentSocketPower;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_cp=
u_power =3D metrics.Power[0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_so=
c_power =3D metrics.Power[1];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_gfx_power =3D=
 metrics.Power[2];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;gpu_metrics-&g=
t;average_core_power[0],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &amp;metrics.CorePower[0],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sizeof(uint16_t) * 8);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_gf=
xclk_frequency =3D metrics.GfxclkFrequency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_so=
cclk_frequency =3D metrics.SocclkFrequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_uclk_frequenc=
y =3D metrics.MemclkFrequency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_fc=
lk_frequency =3D metrics.MemclkFrequency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_vc=
lk_frequency =3D metrics.VclkFrequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_dclk_frequenc=
y =3D metrics.DclkFrequency;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;gpu_metrics-&g=
t;current_coreclk[0],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &amp;metrics.CoreFrequency[0],<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB3018DEDD016FA3612FBCFBC2A2B69DM6PR12MB3018namp_--

--===============2136326326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2136326326==--
