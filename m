Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B692C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCDB10E240;
	Fri, 18 Mar 2022 21:50:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB8310E240
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkkPI6EeUF/6FM3Sg7eVexA1P23SLA+SQ6LZTrV3310l1GfYomaQ7P80kldG3ImiczFnotp9Yf5JboWaRk0RjBRBnPJ9jMdnL+EMS8yIyS+Q41TQ6Wi0I0apzpWE4rF6MjVa1NmK7+IwRVpvjcTe/rMmFz4Q1p3o8vhG5Vt1vG0Lrsz8lFIHJorgkni2E+bTdxeat4c3Qg7jDwqRGzcnS5dDFnf9seKup9S14U+8dmpa6YIWtnPpufrbAkVnu6ANYPr2GZY7lNMmti8JlXS9SBleJNzWRWMUC2s7EHlHV7hM8ZRcGg2zjPHshoAFX1PWoZxY/8MY5Xxxm8biODmzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/uqN6y42HRsIG6+BUVVRBHg1YSG8xioDcWlqzucKlQ=;
 b=M8qrlwY6LTYt+I0pZse3ASSZE/UJSttK3GHwiMAxM6kZ/xIUBx76LYutuXN5rwMHa8yUtG+97UmPxe1OcjcM+hl+oo2LoggJa9n/HDt+ilKLfaDMxBpjjEQKShbocmBMOQa3bBXDRoNzk7i/43U82HWy4iTjfW/eu6pzJGZ9UA2pFf7DSHAZhfkRBE3J37M9IucLziYkdiI89dCMembOgoEgVrirVXLRBzRKc/wEuqwzhIufq4oWp22w4jttKmyAYbiXSycrgAHcy7GxWEGKBCAh1B5r35LVlulWho4Mk+Ui+AWegYICsv9gJymS6e/1bU2d85H427n8caHRulbT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/uqN6y42HRsIG6+BUVVRBHg1YSG8xioDcWlqzucKlQ=;
 b=EY+J4ljaIIeHHmuO8pxewq1by3+Eozot3+kf2bu53MtJc9gWJhj902w1HB5pF9MNBXNZDBcFTcsb9Oipyo974Z0EIpstazyLO8NnfXn8V7iVrkqMzi+hPcNEoXZ/WKNBIbqS1IlWqAmVvpaR82C5Yd829GV+J2dol3mkAYAB2hA=
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 21:50:30 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::c458:f902:1a9:cd1]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::c458:f902:1a9:cd1%7]) with mapi id 15.20.5061.028; Fri, 18 Mar 2022
 21:50:30 +0000
From: "Hung, Alex" <Alex.Hung@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/1] Title: DC Patches March 18, 2022
Thread-Topic: [PATCH 0/1] Title: DC Patches March 18, 2022
Thread-Index: AQHYOxFlvgu1CLrFu0eUlRHzxCEUTqzFrdvA
Date: Fri, 18 Mar 2022 21:50:30 +0000
Message-ID: <BYAPR12MB30489809234B8DA710EE38B1F7139@BYAPR12MB3048.namprd12.prod.outlook.com>
References: <20220318214434.3558191-1-alex.hung@amd.com>
In-Reply-To: <20220318214434.3558191-1-alex.hung@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-18T21:50:29.796Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: f8d9c8dd-05a8-ace1-aba9-25aac35dad49
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c098387-a7ed-45c6-dda9-08da09295242
x-ms-traffictypediagnostic: DM6PR12MB3514:EE_
x-microsoft-antispam-prvs: <DM6PR12MB35143607D278655A188CFACAF7139@DM6PR12MB3514.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUjo4ax9F3ec25O9iSdd2Dr6HspiEOe0efpsDcmzz59P2d7LXV8kuVXzYFLe6GSifBdL3z9Ru0fx9KfF6nnFpiooVbBiAE5WBGaf6FSSbzWuDfL+8POuuHJGHmnJ62j60vKZZ5UCmLbZ4SIvpdJXTNMwIXrCM/wp0mu1BMq8oJbEqRsE7k3OyCmLUY2RAFVfl9jmFvW88Pal108YEmFztyNEtd+V2UkVHqaZiwU71pnYZ/jP/Qpv/bOc21XC5Ap1JXjW/EIuqQlFmP9V2oTsYKsaWQYtn3d0gJ/nwcsT4/C5KnnP6cJ0IBvdjKQo+wladSuCvlYOfjN6jEdI9ZoLKTJ0MNIAKya55Izs1Lc/Fk2JR0vUhSJA7rqyBYC3cTOS5L4zlnVEn9+0gxCef5nAbiGSi8VjT6yjXfEZ+fNCj9E7IzwfXWyDaJTSsENAxi6Y281djRT16fSeMSRDnca1xb2L0mr6oFO/zrHiUVFsgyM/jGa2WCnTxdldmuYJsph/35oCda7cx/9xgRakUAIUsUsJLhw89kcNpRojnAk2NhhsTCB31dMwwm5dI6rBpUEeletQBkdsxornuC/gJpblBZqJ8e4MQjqU7taj6yyN5Dx/wtaPqRrRmIs021J8rge6rNMmOEkXElFSCnapI/WH4d+rScIi2JYttISfsMa+yGbFqR9MNCa4UoITIfJOmLKCf00P/FGV+9OTkvMOzB7mtA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(19627405001)(64756008)(71200400001)(508600001)(38100700002)(86362001)(8676002)(186003)(83380400001)(66556008)(52536014)(5660300002)(33656002)(66446008)(66476007)(91956017)(53546011)(66946007)(76116006)(6506007)(7696005)(316002)(9686003)(8936002)(55016003)(38070700005)(6916009)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H5i7LecF9CN+88gVUjo5fzCd7AWSAtKr1kpFVfFZanvZ1kEMtBOpgK2bkiIU?=
 =?us-ascii?Q?/jZ1jBNJTolXhvszbpv7hpx0DUDOsvLp5eBwyy0cmjnGBSWSukvAiuBbd8uH?=
 =?us-ascii?Q?BWjrrZrKHZVF+jMYklxZ7prewrXIO1/pspNengzJ0JS3uZcg4Cr/Z+yLZDiK?=
 =?us-ascii?Q?+BaO7OApY/FJxYZh9FaKP1Islc7+W3M46J4YNPhgOoQwmXXrlcKKIznCVyf0?=
 =?us-ascii?Q?X1pyxL6BjZZjhkg9SP1EzzpYm3FtjNviHtmQ+0xFkzeLfN9CfPY1t8dodXpF?=
 =?us-ascii?Q?YHxa3Z9OuFvPmkoHgqsPUDhWr3vkkeSmGNhc+prADZGL6aPtboTMtL4kIBJ9?=
 =?us-ascii?Q?v/+79OYMjkeAaKuyPcEF0BX9eMuHxZcfTWWXuagUZfss6sLFgOHhNbv30T6N?=
 =?us-ascii?Q?IdXB3eZvUPi96jwXqzwFRrLOXQyWD2IyxQ5bWqy/jnDqSXHV+ydhJSdgleB+?=
 =?us-ascii?Q?2SvP44bpc1UyGpTMY1KQVJVIe34Wm0fTbv3wZz0di9oh0TO+D8/JvYjG+D9s?=
 =?us-ascii?Q?XX1rwZv8kSfSa+EKddMSKRWaME844Mq8aE+91dosrGsrptxPYRNx+QmbWFDs?=
 =?us-ascii?Q?+QHk/R77KRttbpniwoxMfrlhx+h64QI1jUK76YkRHfYiXfmXnDMjMdxyT8BA?=
 =?us-ascii?Q?2pC3R+1I31RBwC5zURipvTY1BMvIri+tltWnKP4BR5X94MpJ6vEn4WLObnu5?=
 =?us-ascii?Q?S1VNqYv9glKf69h98POHYd5hG+jVu4aaYj7dFFLIqtZW5W7tIKIjhJMOcAjl?=
 =?us-ascii?Q?wYd3/sDlCQcAm+GVN9ux1nMu7QRVSKNzD1VwiyYYmnk6ncR8VzUfK9+mk3Hk?=
 =?us-ascii?Q?fRoetChkWuf6tMS+okdPYK0cAqp3K3su5BLoZfFhjv2EQjzUp/UX8f3Oc8nD?=
 =?us-ascii?Q?raoYeG9e6LSi4AI239mvrBzGkR1mNlbP5uMFSidew5rWXD2LYUdTtH7IbAYH?=
 =?us-ascii?Q?0QhKc5xEoYSrkMvTlg9aNOgZ2ZqPAwg3EC58uoLlHQP3V1c2CmEYYe1vap9Y?=
 =?us-ascii?Q?ocQ48WqFFkpROlzmU5AG84eHqOwMfGsvbgqsq1Y9WShfkzN6KfkLg5h8Q8IX?=
 =?us-ascii?Q?SR67eFRIcP0f0pkcIoRUEq1yFHR1XmYLt6iFq9TksWhxEbGXLiT/ugksJ1jc?=
 =?us-ascii?Q?hrsC9El1e0Z/XD/XQmxD2sIN36qAgf2VsdnJOLP4FVWjwagzVRnX2qrp2H81?=
 =?us-ascii?Q?lxf6MvASlBFETmcHuSrgs8fuRqyKlcwduUvSslaPrn1T3eWGELnwUfjkbNr/?=
 =?us-ascii?Q?Y5v5NzRZaxZ22pCAnkwI1MYFOA+HJXwfHS/g6VJ7G0BNle9kS8UH6LrGi4sB?=
 =?us-ascii?Q?oYBOv51I8rjodEnv6i33J6YW/v04spJcQ7np1m3Pk5kuwn9VJwHGGGdUT0SZ?=
 =?us-ascii?Q?A7bXCP6aGakpgGE0vJXK8KwnAxbwxGPoDNb6xWYMLeoiRIQeRCtL+8Itq4RC?=
 =?us-ascii?Q?ZBaUT008djzpF73scrLp1DQ/s3omyJ+CLWqAhRBOTL6PElxhHE+Jlw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB30489809234B8DA710EE38B1F7139BYAPR12MB3048namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c098387-a7ed-45c6-dda9-08da09295242
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 21:50:30.3207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3JD8hOyG5lpyy6QBCIhWVFJpMdf7YqEPqAzITdC/iOzVYpOSYcnKKnm6IupUZXDj6nvChZqwAnkuWDeORJe1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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

--_000_BYAPR12MB30489809234B8DA710EE38B1F7139BYAPR12MB3048namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

My apology to send incorrect one. Please ignore this. An updated one will b=
e sent.
________________________________
From: Hung, Alex <Alex.Hung@amd.com>
Sent: 18 March 2022 15:44
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 0/1] Title: DC Patches March 18, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* HDCP SEND AKI INIT error
* fix audio format not updated after edid updated
* Reduce stack size
* FEC check in timing validation
* Add fSMC_MSG_SetDtbClk support
* Update VTEM Infopacket definition
* [FW Promotion] Release 0.0.109.0
* Add support for zstate during extended vblank
* remove destructive verify link for TMDS
* move FPU related code from dcn31 to dml/dcn31 folder
* move FPU related code from dcn315 to dml/dcn31 folder
* move FPU related code from dcn316 to dml/dcn31 folder


Aric Cyr (1):
  drm/amd/display: 3.2.178

 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.35.1


--_000_BYAPR12MB30489809234B8DA710EE38B1F7139BYAPR12MB3048namp_
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
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
My apology to send incorrect one. Please ignore this. An updated one will b=
e sent.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hung, Alex &lt;Alex.H=
ung@amd.com&gt;<br>
<b>Sent:</b> 18 March 2022 15:44<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Hung, Alex &lt;Alex.Hung@amd.com&gt;<br>
<b>Subject:</b> [PATCH 0/1] Title: DC Patches March 18, 2022</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This DC patchset brings improvements in multiple a=
reas. In summary, we highlight:<br>
<br>
* HDCP SEND AKI INIT error<br>
* fix audio format not updated after edid updated<br>
* Reduce stack size<br>
* FEC check in timing validation<br>
* Add fSMC_MSG_SetDtbClk support<br>
* Update VTEM Infopacket definition<br>
* [FW Promotion] Release 0.0.109.0<br>
* Add support for zstate during extended vblank<br>
* remove destructive verify link for TMDS<br>
* move FPU related code from dcn31 to dml/dcn31 folder<br>
* move FPU related code from dcn315 to dml/dcn31 folder<br>
* move FPU related code from dcn316 to dml/dcn31 folder<br>
<br>
<br>
Aric Cyr (1):<br>
&nbsp; drm/amd/display: 3.2.178<br>
<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB30489809234B8DA710EE38B1F7139BYAPR12MB3048namp_--
