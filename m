Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6E8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 13:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6527810E27A;
	Tue,  8 Mar 2022 13:58:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D40A10E20E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 13:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0fGRhq3rC5pfI8/Mr7NvYmT7NMw++ozwuw3ufVMxtWtgPohzo3S+LcXCvUkyWDRm23Aw2VCKF08cNq07l28xYebv26fTzQjDIr7HOR4mZW0A2zAclGbION8v+hX7n4/BxG2Lqe1GLl87q2jrbAM9NJxzQJ4jLsW6G9wN58tabU+5NDdh/U9qy75gfwc2lpoU/QaV1QSZKJzg9aYfCpuVcWii3mbB5N35i6QYX8YYq3wf0qaU4kVCZwwn7ZZDEeUUMmmpsOixwY82NGnu2XRmj43vzPlDtnSNqUowtkJ67zkwbbUhpY9pfUZgpFc54bmghKkRtSUMt08ZQBt20Fk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTy8OGEgcm0orrNelVoqRx1OGXVhTI03AC1+jLZHSPQ=;
 b=Y4H3icZhAnfEULS3JitM76pqbi+6PlDQd7q2VC1oS5btgpM9wFeKKupSE6nbnkNPRo2SR6LoeajA5eGlHbAVeKp30hxlhQi/UArJFnuOkLc5ZE8sOJBpm+/rkzGI15xghMnAsKMFfIFh+4YbZflgZWimSmigtEOiN0C+xG+zzohJ6D90bfuSV7vkYg0D5eHGcPO0F2Sllano07nw1o9goBsXjHnyFRCeMFkoA2bjH77fJr/18uJ8xUgidaPmrFVpSxE8wjw1N9ON4Hc9trA826mHFeImnFNLElacAZYBNR9x3HvAli43eKqsOLBrRObBXB9RH9C20Ow/g0w+cndRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTy8OGEgcm0orrNelVoqRx1OGXVhTI03AC1+jLZHSPQ=;
 b=CKqorZwNmwvYnKUGyeZ2sqhDJYl7KDk3mFXQgMBpr1ulOfS+pGMUiNc+/Glw0t4rys7voE+8Y5VgMiPTVDPQSMAjl8AVvX3b34L+M4PVWuwLQkEf3c3aayIiYVCyE1/wj4mXdLp0pCJoy2w/TPtrRK4cQ+E6Hcc1FPYiLgl2Wjs=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 13:58:08 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::5c69:23f1:b53a:7436]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::5c69:23f1:b53a:7436%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:58:08 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: fix dp kvm can't light up
Thread-Topic: [PATCH] drm/amd/display: fix dp kvm can't light up
Thread-Index: AQHYMrjGC3D/DS1v4Uyl7GUZFvWznay1guyAgAAAnmA=
Date: Tue, 8 Mar 2022 13:58:08 +0000
Message-ID: <DM4PR12MB5294ED933D4F7C91EB94919D95099@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20220308065006.164101-1-tianci.yin@amd.com>
 <a6c477ff-2122-6e10-1ea0-77285af4f3c1@amd.com>
In-Reply-To: <a6c477ff-2122-6e10-1ea0-77285af4f3c1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-08T13:58:07.484Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: b75b15b5-b9b7-ca60-0fdd-6922e03834f7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 300462b2-6815-47a4-c84a-08da010bad15
x-ms-traffictypediagnostic: BL0PR12MB2369:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2369E9E9223190EC6AC5889595099@BL0PR12MB2369.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CCpvJWRSzj5Y+fqivp66F3wIHKClpSBgIfiBoZfeIBor5dztoREg2JX5A/+XWQ2/umwQ6ranxLsjiCaJ5wVbJLr+qFE9oFGL9yh1z+MZwVrYG2VUDlkMoHo2J0xVDXjwmX7ev4G4E0CXB6d/O96E7EFZ4XM56jiR0jk4svG9OR4XtqCaKj4rBo6pN3HXcT6/Xq9jShSZGzFKQcv26ILS0ti0V/+G/NNR8eeIa5R1jg0o8ZrepD1OfFDxCFhcTXJJQTcVWKGV3MwX608yam5wilV0auq9LKsMcZWwMqzgUUrFshsLl+Hv3BzMxyGW50LYKWyr8L3AjpbTgZiWSq7CEh28+XK6+JydHNBWejkzwyOtHuFDiw75EDYtHdznnPUF9oe6X95dVZRh+3SJva4n5jLZSHnGzzrUalWvGkE0Goan1wym0zSJdoNeOeAg0bjTLXReY/FVuxp2SLv9H3oFq1GfIeoHTHfpCTljmwJVWVHTqnVfcqQv4ZykhPWkM+C2jXfEhLlIV/qwZtHy0zZ3qZCN9V9n4+taqfgoLOgRrFiWd2b7iayZ91IBkR2k1GNM0iWoo4TfwdGPrm5lV8dHgqGuqu5qFOXHQ6S9+3mgSqzzMX2xRJ4OWWXcHdELFGYSo5yEVBf1rlGdPU1r1VrIoMiX2/VKjnk7wzltv0YaV2ZZ6KQN6E5qL4wNEN/fFqjGZ5a1NHopPHzN+n7yI24X9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(33656002)(19627405001)(91956017)(508600001)(2906002)(6506007)(53546011)(7696005)(71200400001)(38070700005)(8936002)(26005)(38100700002)(122000001)(186003)(5660300002)(66476007)(66556008)(66946007)(66446008)(86362001)(76116006)(4326008)(8676002)(9686003)(64756008)(110136005)(52536014)(55016003)(316002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WiCM6lfIh3DzrrFeEu3ElRFrMBeMjyCFPxtRler5WEl7gUFnhiiwcVPqj31f?=
 =?us-ascii?Q?AS+abaEAVOH0pxYaFwK1nNap0/8mx279nJi8siU2RxiQHhU+E7fG5i8ZUELx?=
 =?us-ascii?Q?dnOGvZvxTuRS0DHtQXM1sxszzxxeaYIESqJLjYpJiB6/3/+3rWtvvY0X19Wv?=
 =?us-ascii?Q?yyHOvxfyHiu4+bV46X2XWmtf4etOSpHDTK2myf92/lIkf3fIvbs8UO20NUZS?=
 =?us-ascii?Q?KzRlsb9TQCSk5+8XAZNhFVXge3vrY0keKuYPc/Qlf0JfLNQ2zNm7Ipns5tbS?=
 =?us-ascii?Q?7BuFqoOLqo4zIwchpI6hX/lNK7k7jyfqJQVkCXvP2X5nn8lU59Fm8VgsaB3w?=
 =?us-ascii?Q?aUb6gLD56gi4XBCpihjJNP8bcAzjngSERuTTt8aVw6D93A6NgXWJxLobx8j2?=
 =?us-ascii?Q?6vOm04IeadEC5RfT7bnX5igzrJsLepL5AF6g5vcyv9EpJhl/nddcr0CALG5L?=
 =?us-ascii?Q?tcgInPm/GFowxIOmcN80HjSrtRT5lK+IVjthH84kHIlxt/zfrsU4E9oNivc7?=
 =?us-ascii?Q?rhxkl6LpIvlrBvKEgpMuqtw8S97fg6LeUpICe3dWBgAaP9Q1QeuTB2euox3g?=
 =?us-ascii?Q?Oo2V3XPzn8M+t8F11aennfpKpXCmKDUvcSFHX7RAry7fhTTaShA3Mno2raZH?=
 =?us-ascii?Q?Dc63F6hC2nIhxls39mFg9LDzWFL1Ov27iJPOyOVhO7VYXGyFO3NsWskYLBB/?=
 =?us-ascii?Q?gujz9AbH4JcZSqYWfBc4A1kMu/H99Tf87iHVR577zddKCset1FgdRMdzxhNa?=
 =?us-ascii?Q?fg0eQOZrJEgZqZJeZV8dY060Cu8FWM3LFFCY92OCcbUnerYHqs/9rEd9VGa4?=
 =?us-ascii?Q?XtIz0+L2hIrWgqc4LdhqTw6B0BmyLNLDIJM/YVrWgRGA6rrIIzDyEmk97UFO?=
 =?us-ascii?Q?6gaNKgibBRCdCITz42W/hZCCWqeZLazUU5vt5T4qq0SP9H9UILvHTAIRUE16?=
 =?us-ascii?Q?BXr5UBck6uJ+dCTqFSnI8dFJiScI13RbiKAlyD9ZMBRcBB3+4suymV4UWxw3?=
 =?us-ascii?Q?FuWy1inEMA5M9oVzqF8t9EV+yOqFffyWUJNZkK2lBgaRYL34uDw6lIyprBZi?=
 =?us-ascii?Q?V615Lqxqw5C3oJAvB/Ul4GVIrFudteWFDtrGxSHnEc8DjxZ07rj2KTlyQw/f?=
 =?us-ascii?Q?dVJdy0N8f19xmdk/m0MLaPtlW48xJfSjYvoULX1qG+IsTK0EIWlg0+MaZz6S?=
 =?us-ascii?Q?dRLIZr08UzsE7vloLET3ERi3xU6GEaxPrZmCRUm9kTRPnTMWEwlti+6rr6NV?=
 =?us-ascii?Q?R8tPUVbwCUe8zRNAn150pfGSB/LbfLgF0Rqe+jMcuJRXBbisSm/3H+kt3KrV?=
 =?us-ascii?Q?jLilhZxonW77w/3t2w02NWcbXW0o9AhZSAzqfRuiYRTrCPL7kXNm+TkpxLAM?=
 =?us-ascii?Q?CTOqGW0xDuJJe3ZR3/sWIvUoa52qp1vdUhm4peCM+A0oGJe8g/Fghpy0WR2R?=
 =?us-ascii?Q?9k8WLPsgNgBR/zYq05lgJ6WfWKAXozGfjRX5FrdnGvxYmG5jXRUHidTrDcwp?=
 =?us-ascii?Q?pCLoXpSWwPoqK7YiRwksuMxrpnSsE0OtNM1oAdtEH0u6CnKlL7V1OScapsM6?=
 =?us-ascii?Q?BxAu/WvTIWZpY0BZfBAGwLtFDn6+reWfLRpOk6845kd907xsD75Sq8YR4rjI?=
 =?us-ascii?Q?SVUdNDvUC5f5TT3d870zYHs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5294ED933D4F7C91EB94919D95099DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300462b2-6815-47a4-c84a-08da010bad15
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 13:58:08.4625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXmKiB1esIHtMKzrt9o7Sf4hAAw+Kv4CSjkNBU5ShgsDrN8+nQ0sZeUprm7/Q7ErQcYdtNxbDXVPx2A8+A2eOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Liu,
 Wenjing" <Wenjing.Liu@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5294ED933D4F7C91EB94919D95099DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thank you very much Harry!

Regards,
Rico
________________________________
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Tuesday, March 8, 2022 21:55
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Wang, Yu (Charlie) <Yu.Wang4@amd.com>; Zhuo, Qingqing (Lillian) <Qingqi=
ng.Zhuo@amd.com>; Liu, Wenjing <Wenjing.Liu@amd.com>; Chen, Guchun <Guchun.=
Chen@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix dp kvm can't light up

On 2022-03-08 01:50, Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> The DP KVM failed to light up, since the lttpr_mode is not reset to
> default value when failed to read LTTPR capabilities, and the
> variable max_link_rate retains a initial value zero, this cause variable
> link_rate be assigned to an error value zero, consquently pixel_clock
> get wrong value zero, and kvm can't light up.
>
> [how]
> Reset lttpr_mode to default value when failed to read LTTPR
> capabilities, so that the link_rate fallbacks to the minimum rate that
> supported by link encoder and sink.
>
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_link_dp.c
> index 5688b15ca9e6..f9ae06103241 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -5101,6 +5101,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
>                                sizeof(lttpr_dpcd_data));
>                if (status !=3D DC_OK) {
>                        DC_LOG_DP2("%s: Read LTTPR caps data failed.\n", _=
_func__);
> +                     link->lttpr_mode =3D LTTPR_MODE_NON_LTTPR;
>                        return false;
>                }
>


--_000_DM4PR12MB5294ED933D4F7C91EB94919D95099DM4PR12MB5294namp_
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
Thank you very&nbsp;much Harry!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wentland, Harry &lt;H=
arry.Wentland@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 8, 2022 21:55<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;; Zhuo, Qingqing (Lil=
lian) &lt;Qingqing.Zhuo@amd.com&gt;; Liu, Wenjing &lt;Wenjing.Liu@amd.com&g=
t;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: fix dp kvm can't light up</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2022-03-08 01:50, Tianci Yin wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt; <br>
&gt; [why]<br>
&gt; The DP KVM failed to light up, since the lttpr_mode is not reset to<br=
>
&gt; default value when failed to read LTTPR capabilities, and the<br>
&gt; variable max_link_rate retains a initial value zero, this cause variab=
le<br>
&gt; link_rate be assigned to an error value zero, consquently pixel_clock<=
br>
&gt; get wrong value zero, and kvm can't light up.<br>
&gt; <br>
&gt; [how]<br>
&gt; Reset lttpr_mode to default value when failed to read LTTPR<br>
&gt; capabilities, so that the link_rate fallbacks to the minimum rate that=
<br>
&gt; supported by link encoder and sink.<br>
&gt; <br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
<br>
Reviewed-by: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 +<br>
&gt;&nbsp; 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/driver=
s/gpu/drm/amd/display/dc/core/dc_link_dp.c<br>
&gt; index 5688b15ca9e6..f9ae06103241 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c<br>
&gt; @@ -5101,6 +5101,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(lttpr_dpcd_data));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (status !=3D DC_OK) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_LOG_=
DP2(&quot;%s: Read LTTPR caps data failed.\n&quot;, __func__);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link-&gt;lttpr_mode =3D=
 LTTPR_MODE_NON_LTTPR;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5294ED933D4F7C91EB94919D95099DM4PR12MB5294namp_--
