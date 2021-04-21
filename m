Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BC8C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B7461430
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B7461430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFC96E9CD;
	Wed, 21 Apr 2021 19:22:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B574D6E9CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 19:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USndEo6livQcqmj3jYkGYu5XmQi/294tDQCzVzcp8PmHSL+Kl9dBcKsNbd8WJsk2ZVirw74UWJSnoRps5RdINyuSh6dQ8tgJqHIyXgBIZzUPCvkZg/A6aM8sxJiSK1V1jwSoi3iw7qPRWNND5TvLzBceKCrxUm47Im708cbJRGar98//Y4jBV6+W2fzZ3TXRnhkocH6YdxlO3E9Efspb5LatTN6o2ynx61XJLZVnyfNT6NK7bRMQbi10v93MRO9tuNF5nFzxe1BEZIljTd3+81J6/J77ZtH3pOVSIOA4AbG0+U1JBIBx3rv+mdqNTMK/vvQptd6ZIHOpG7fAAkjiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIKzOt+hWynCjmVXrN8gaCtUBGyYDAcMgX6o7yA/+wI=;
 b=VaQiZfITpRp5qGAh+njKx0dArbibMeqeSNzor/7JAktc2NSlI7KMCbTJiKmCUS60lQgW+tyMEIZw4EA/qy6hul+lQcJvWEiZuyLZZN2ILj5XBJqx8GSTm6EnwLa/8i6FhC+brsBQXuve8wao1wybnBywfz4uAAV20gsRU1tEBw+U8uPoZuQfesWXQg4kLb69lvp/XROY+zajgQVfwTCR8iptpndvYpdoXEqxVfXVqjEioitNtVmMq2SwP8jZbLe732MSDpV1hPUMYX+YDZBxEnjSLN4cTyfju/1oNuyflkaZ38gqOfUL1H8J1A3l9yf3Zw1xTVx5GGONl/e6RcJ9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIKzOt+hWynCjmVXrN8gaCtUBGyYDAcMgX6o7yA/+wI=;
 b=iaWZ86PtoOG1WKlynxTWHwrRKBNzlz2fm6rKEtvwu+fv8fB9bnhH7/2rBaramPOvB4Ezf53v/YZrrhZF8xwwrb6LR1/EO9WeQ6feXzxgSOhxlvM/BOIAW24AIvnu6wHuaNc0816C5E4oJhA92jIwhCZP8UlM4YAva9H7SI/3WEI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 19:22:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 19:22:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: get socBB from VBIOS for dcn302
Thread-Topic: [PATCH] drm/amd/display: get socBB from VBIOS for dcn302
Thread-Index: AQHXNuMLhZvQlxBED0aZFbDJignluqq/WW8G
Date: Wed, 21 Apr 2021 19:22:15 +0000
Message-ID: <MN2PR12MB44888D35959B7BEF4B0B03E3F7479@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210421191746.126617-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210421191746.126617-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-21T19:22:14.862Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a82c782-dfc2-4c81-6428-08d904fac5bc
x-ms-traffictypediagnostic: MN2PR12MB4128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4128D6D1894F9534BBD90654F7479@MN2PR12MB4128.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBfsG3yBAQ4YuLFDG9VuSMjqIm8KCsFi6F2ox2ukZbMfHjkscpab/uEm1i7DoH2P3+yE3EPvJrTWPfill8cJ0UDPQ3TYSxcPgFrfAFZ/gs4IKHtZupXuZDr46fYwoZrOOct59ArSmWe8WkD63lZQ2Rlm3jegbsAVdd3ImjiDdPqoojaIKz2q3HmfzGfLEb1Id5/gpo82lLr9cULn7tmClzrNBuXm/bgXZ2h78flp0ln3R8bkXSnrpNg97QZPPgZ3ogB06xSMimxCwi41JlrMCu+eRbbZKvDbGi6CSHMFR7k4XfaZFqEEvOK9Ol+nvPkLnMkDB5lejxeSGYlYvzf7WK8K5slgXjOB+5UNybr9JIWOnUBuKpO/TT7wZAL/HOqqfbTSukmyZd9U7OdDh9emIUn0paqTJ4rIgtJYqoJvfp+7fy2K4UV3IH8DmSypY+YWcSwFDZWZr4iYBAKPJs5JIAIq36Ep0pzlJCV0U8pV5SAXp++igW72/yBXGQC1BOiHdp4gOwk46dv5aWGvK1x40Tylk6SMNnc+ZhLJaoeU1/G7cYkBOWgUx3dbx85EfOv7C2My1UjcqXOCR2RiVP0lLG7NAJo/0AYFf46fFodseCJAZjg7qCWrBsIgzYaw2omOW+/I75YoBP558rAPHJmRYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(4326008)(26005)(33656002)(478600001)(53546011)(966005)(45080400002)(166002)(66946007)(6506007)(66446008)(54906003)(7696005)(5660300002)(86362001)(186003)(66476007)(8676002)(52536014)(66556008)(38100700002)(316002)(83380400001)(9686003)(55016002)(110136005)(2906002)(71200400001)(122000001)(76116006)(8936002)(19627405001)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BgRDkm2aWrdun7LLFSporwGbM2zkdhqODEy4qeEWuoB3AoIVshyggJPP8JXt?=
 =?us-ascii?Q?TvJ4K8m/F7ZwRo2LBxPWXMav/ASA67TGgyrfoK985xzZCoZTY0/F+rNvVis/?=
 =?us-ascii?Q?bC4rkRIx6gnzP8QJjim1CbhYynCJqT4fQAm7PEvvq2Fj5INEDWGb5+GrMgB1?=
 =?us-ascii?Q?Um79f0k/QDUcbrNPEDYHSvHRUTF0DnmazK5thi3D2h/6j2JrN2zn0SAq2bFk?=
 =?us-ascii?Q?BLF3MGEqN947FBRZkpWJny7xjM7uDabJz3scXMSs4zxCvv+FkEwsPhbacZLD?=
 =?us-ascii?Q?DIF5UVTqvFFpgutohu4QsKW9YBCG6ef5uP4P4NkANIslueoyV+X/C8eixILw?=
 =?us-ascii?Q?K/lvj1FLfGcng+uiTZ+DCD1Pv0FrpkHwG8U1msAraIcWXc8BeGZcKsRFWaSK?=
 =?us-ascii?Q?X6WsTxuoVEnQz6hA1uxTSnnpCweHVPMDihniHZcE9CEN5g8eXV6jTT1nLFcI?=
 =?us-ascii?Q?WAgEITgUmssU2oIHs1xRIrCN3s7sxGLXSzSAF8uyVoJuoX5FExrjmhBD/Zs1?=
 =?us-ascii?Q?HCrkaTAy+e/WxRWaE8c90zpuQLl1QAuk+MXx3NeGPpLrEhXQxdFM2HzEmL5o?=
 =?us-ascii?Q?KKyUIZeTOeyLALXSVTcV9mk3N2pEFBxtcg60YTqBjRt9VDPZZAi2Ah2NBU67?=
 =?us-ascii?Q?vqb0zRmdD+B3pS61jCuTBkyf3wuPlx8b9TWDYWHP7qufOC3YUVn7Njqx6pRz?=
 =?us-ascii?Q?ZaOOqdHafrFAWhTfYNyoAyIb2VYXZvQuu8ruD+ZQqC1C0sdE0M4gq9njDUCi?=
 =?us-ascii?Q?o6RiAr9wjdnOnfyYiMIq7ZOK/d0ufDh7qs1nsV6EN8u4C9HQuEO+VLCatSzI?=
 =?us-ascii?Q?VkV3cxmzZgz9itYcAuS/lIQWE7+c69/ECWwwRH/A+W7D3kskZ95tvI4n7Doi?=
 =?us-ascii?Q?KG+2znbC2/iw7KHCEBowKMCK4VmZtxyGmx2j8nqudcnxckrYcvg6jtdYl9Ho?=
 =?us-ascii?Q?6niQzvkkshYNYHgNZIXL1cfpgpvySNEdBXwhaA+FXeI2oawVTnxukVg1hJng?=
 =?us-ascii?Q?Fb8COn63w7yZZ7MnM83gaojLE1D50pjlxLEoLmM5zTZNVrS5N8+VPX0UfNk3?=
 =?us-ascii?Q?C1ahVDw5I12CJpYmhdfbwotJCTTCB1wdgnNm7NXbnd9dzkoPZsQgC2cZXWYB?=
 =?us-ascii?Q?HPCAXBzwk8bCaO81cld3uIJ6V2PY3AIhyJfBl4jaIOBwdjo8lpfSCDRlnzxm?=
 =?us-ascii?Q?gwW0DKKDPrkO5yoWlDh3KhGq7lJuLLLUFtfDUK6ByNmcrZraUI7l46+QTCkG?=
 =?us-ascii?Q?EmCdLkwg6LDgzdFtHYL6lnxdoxZymb1FJ/+mtQoKNDpL3yj1loCYfoChLf3w?=
 =?us-ascii?Q?jJU2l97TFAVPvfL6DVzPMzdV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a82c782-dfc2-4c81-6428-08d904fac5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 19:22:15.4204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCKGpMA0aTJbtfmOol3025vukGgNkm5vc3aAlR+tuj834BYxZowUWD9FWtckNaBE5c7a6J5U+cg9BsUiIrvJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============1055859766=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1055859766==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44888D35959B7BEF4B0B03E3F7479MN2PR12MB4488namp_"

--_000_MN2PR12MB44888D35959B7BEF4B0B03E3F7479MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aurabind=
o Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, April 21, 2021 3:17 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Kazlauskas, Nicholas <N=
icholas.Kazlauskas@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH] drm/amd/display: get socBB from VBIOS for dcn302

[why]
Some SOC BB paramters may vary per SKU, and it does
not make sense for driver to hardcode these values.
This change was added for dcn30 and dcn301, but not
for dcn302

[how]
Parse the values from VBIOS if available, and use
them if valid

Fixes: 93669c8e48 ("drm/amd/display: get socBB from VBIOS")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dcn302/dcn302_resource.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fc2dea243d1b..f44814d15206 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1101,6 +1101,26 @@ static bool init_soc_bounding_box(struct dc *dc,  st=
ruct resource_pool *pool)
         loaded_ip->max_num_dpp =3D pool->pipe_count;
         loaded_ip->clamp_min_dcfclk =3D dc->config.clamp_min_dcfclk;
         dcn20_patch_bounding_box(dc, loaded_bb);
+
+       if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+               struct bp_soc_bb_info bb_info =3D { 0 };
+
+               if (dc->ctx->dc_bios->funcs->get_soc_bb_info(
+                           dc->ctx->dc_bios, &bb_info) =3D=3D BP_RESULT_OK=
) {
+                       if (bb_info.dram_clock_change_latency_100ns > 0)
+                               dcn3_02_soc.dram_clock_change_latency_us =
=3D
+                                       bb_info.dram_clock_change_latency_1=
00ns * 10;
+
+                       if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+                               dcn3_02_soc.sr_enter_plus_exit_time_us =3D
+                                       bb_info.dram_sr_enter_exit_latency_=
100ns * 10;
+
+                       if (bb_info.dram_sr_exit_latency_100ns > 0)
+                               dcn3_02_soc.sr_exit_time_us =3D
+                                       bb_info.dram_sr_exit_latency_100ns =
* 10;
+               }
+       }
+
         return true;
 }

--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cd4786559160d4972759e08d904fa2c5d%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637546294804838871%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DqVnczJLExg%2FX2JaAh4euZPDU%2F5HO1fKscQ0XYjVrk5I%3D&amp;reserved=3D0

--_000_MN2PR12MB44888D35959B7BEF4B0B03E3F7479MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aurabindo Pillai &lt;aurabind=
o.pillai@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 21, 2021 3:17 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Kazlauskas=
, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.co=
m&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: get socBB from VBIOS for dcn302</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[why]<br>
Some SOC BB paramters may vary per SKU, and it does<br>
not make sense for driver to hardcode these values.<br>
This change was added for dcn30 and dcn301, but not<br>
for dcn302<br>
<br>
[how]<br>
Parse the values from VBIOS if available, and use<br>
them if valid<br>
<br>
Fixes: 93669c8e48 (&quot;drm/amd/display: get socBB from VBIOS&quot;)<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;.../amd/display/dc/dcn302/dcn302_resource.c&nbsp;&nbsp; | 20 ++++++++=
+++++++++++<br>
&nbsp;1 file changed, 20 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
index fc2dea243d1b..f44814d15206 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
@@ -1101,6 +1101,26 @@ static bool init_soc_bounding_box(struct dc *dc,&nbs=
p; struct resource_pool *pool)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loaded_ip-&gt;max_num_dpp =
=3D pool-&gt;pipe_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loaded_ip-&gt;clamp_min_dc=
fclk =3D dc-&gt;config.clamp_min_dcfclk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_patch_bounding_box(d=
c, loaded_bb);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;funcs-=
&gt;get_soc_bb_info) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct bp_soc_bb_info bb_info =3D { 0 };<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;funcs-&gt;get_soc_bb_info(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dc-&gt;ctx-&gt;dc_bios, &amp;bb_info) =3D=3D BP_RESULT_OK) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_clock_change_latency_100ns &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.dram_clock_change_latency_us =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_clock_change_latency_100ns * 10;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_sr_enter_exit_latency_100ns &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.sr_enter_plus_exit_time_us =3D<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_sr_enter_exit_latency_100ns * 10;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_sr_exit_latency_100ns &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.sr_exit_time_us =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_sr_exit_latency_100ns * 10;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.31.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cd4786559160d4972759e08d904fa2c5d%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637546294804838871%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DqVnczJLExg%2FX2JaAh4euZPDU%2F5HO1fKscQ0XYjVrk5I%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7Cd4786559160d4972759e08d904fa=
2c5d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637546294804838871%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3DqVnczJLExg%2FX2JaAh4euZPDU%2F5HO1fKscQ0XYj=
Vrk5I%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44888D35959B7BEF4B0B03E3F7479MN2PR12MB4488namp_--

--===============1055859766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1055859766==--
