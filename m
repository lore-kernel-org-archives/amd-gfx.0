Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF2C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 16:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D56619B8
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 16:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D56619B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E0B89DE5;
	Tue, 23 Mar 2021 16:42:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF336E914
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 16:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHmcVzc6Buvk4Yd/5XlL75uVCSd8A+JUaGyg4YwBgSgmM+o9Q44P52qceNf+jFzRVbeR3T5I4Uki53hd2CrB9fctGs2wF5+IZtlz3SNf+U1ssObVxdwRvoonFnvxUzYq2PCKQjUdeoNGKG46frbj0LtjyAFo0hxHRPFRyF41ZaC8sfhtDV+isIi+YOKYy+X1bhJzcafy39yFCAywAa5y/16QdXkw1xxmwMo16HNa1uZtPXwfc4SlIvkeAiHWnsbrIN6SqB75TeZYcsXt9vTDqzfzWgFWDsnIDBd5sXSesWBtI91KQrlfX5WQ51hNE86phXgzbEVQxsVDDaBWpUC3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DcEmZji8kehVTmkRkR0jYQxYokOiR09TJJz3CiXqN0=;
 b=UpWeJSRVjQykKGib0N7AvKBgAJSCXvRtc4XpuiCrD5aoPTmiuWgTiqIC51wMqvpT8PnvD52nQcE7L/Oxbl253h2uw1AGgr7QXQE3ZM+r7qn/9aHGA5+LBnoZB2K5BbXadwCouQp1h32MO8XXReQqN8lixIdDJ/yqOgU6DlGNTrf8I0tpcgC3SqsGkDpe6tdLdiumZSf2Sz4rO67ixZOK7nziqqLQhuSLE8zn8P8ftwajkwzGAYVgz2vao+upYmj4s6kdRgonvwi58zpltqnKqvZ7bw7ALwKQ/et9JXUoKhn8VIzUq1NaibQAv5PJd+GsWW1mHxj16SLg98DT6G4WIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DcEmZji8kehVTmkRkR0jYQxYokOiR09TJJz3CiXqN0=;
 b=XRpaAa6in46XunCfJKnhS+Pl4lY6wXKwnSSEvTsmMg/9WsMrmpy4LoWNXFq69nrkuiyEGWylB25eeFp9NssLNGfsJ/WTHXoF0BQtM1C6v/OHiMN4EvWpYfCAiGm6jnoD9L3wzixuCqfMh2iFGdFm//pBRjecWyVGwtO84TxQvT4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Tue, 23 Mar
 2021 16:42:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Tue, 23 Mar 2021
 16:42:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: use zero as start for dummy resource walks
Thread-Topic: [PATCH 1/2] drm/amdgpu: use zero as start for dummy resource
 walks
Thread-Index: AQHXH/SCLTwqf/gAbUSXFqvtBRlp+aqRxwBE
Date: Tue, 23 Mar 2021 16:42:17 +0000
Message-ID: <MN2PR12MB4488265CA48E8991B90CDD26F7649@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210323145458.38910-1-christian.koenig@amd.com>
In-Reply-To: <20210323145458.38910-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-23T16:42:16.407Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0ca5fa1-de59-4411-d322-08d8ee1a9e9d
x-ms-traffictypediagnostic: MN2PR12MB4344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43443FA7CD13C68F2C42E467F7649@MN2PR12MB4344.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8tqmvIZgbHJ1HcoO0PhOj6NF1pdtzHfRDHIqoyjJ2dKJsya+iilXkU9aJOIxrGuo0ozKzOnbLcecadSXNa7ARccWDzPr9HZ5m4IY1mKyDPMkK+ZA02oPl9wG58ZjWHQdZn/amGPylnEWFUrtcGYRqOCNliysIgL+ZVHPcLVwBhSomLxv3Kzv1dOeMNXnPONbw2MiAozNYrsfanCti5xyQuxvSwhTPgPYN29Mvaj/Sopd4vAZDMZltO+V3lelsgTEQDXgqrf/BBGenhtwm4qxPZgtElqFHgFiYBx4MDqDObWuyLVbM608ekOCqullOjxlDarnRkWN6/l1Ug31FmIYUnDAStcQ1wZR/G2s9KsVxzPvo6PqW/yTThjR8/cn1c4gAVqGk/04MELMgf91+1XyTPe6NVNMCTSM+TcETUP6Kp9F7NF5LImLRKdl7jTIE4Vhp3bXFYf7NKtxdWlk7ZGiiPuKTQrtoJdRB2Kg4jTHFRK0Gbe6jxl0CGQFDh/fICW72UH8F93gwQGJGvemxDQNoUFZH2fxhXqNMmoonnppnxm3KI9N8huWLPH4FY0+QR1n3LhY+tod37hN1b3dLUlPeteZGVpomwmkmNKXrrN4qU8AbdyJC+L3zifiGRX/Bp4UOxTe9+OcozEGgDWhoT8tKnDL4PYDZt9RvrDT315jdIHFqIiz0+ENxfpz45gQ3UtCsAE4ksBG6rMwf3cdJ3KKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(53546011)(8676002)(5660300002)(38100700001)(4326008)(9686003)(66946007)(8936002)(55016002)(6506007)(2906002)(26005)(186003)(86362001)(66476007)(64756008)(498600001)(7696005)(66574015)(66556008)(110136005)(966005)(54906003)(19627405001)(66446008)(166002)(71200400001)(33656002)(45080400002)(83380400001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?2yOLw7Re7u3Cn4JvBmWGaLYhfEfm5ILh7rVvHIFxWkxfxb8nZ1sQQ9aZVZ?=
 =?iso-8859-1?Q?iOZOvTVbyLnUkB5EIIOjT4iisT8gbIOlI1s4sskktBcM1tCCdbZM1rdCgk?=
 =?iso-8859-1?Q?GpnopX73V6ttf+bFvDabUhJd+NQGZfZMpVi31SELdvP4YW8VPa/9WKbycp?=
 =?iso-8859-1?Q?ats+LAb0Ao18ozLM39wnDbJ+KjijZnamLpz+QlFt/oNNhYlS6tD6a1Oe2/?=
 =?iso-8859-1?Q?IsOxiGG3vg22tASF/XGHr98RbRp4/Rj5FIkh/Nw/bieZBoRSoVjo76dhkJ?=
 =?iso-8859-1?Q?ggR4/WmknHmjHjfcYHNvjDoWat2NPuD70tEmqXYGoTWUaaWZUWfO2mBOhc?=
 =?iso-8859-1?Q?XtKd+nftz5rFtN/htkYLHHNCITbqUAzzo9NppItNw56bJfWIEfenSzKvD/?=
 =?iso-8859-1?Q?mHEu89lgiY7BpyB/4uG2IRejrqeeFZSAd5HB2xvAnWRhct1E/PfSDOJv3X?=
 =?iso-8859-1?Q?QiGTmiWaqBhH2VZl27XPgEU68rAjPbabs11Pn8pD8oqvwQVXdi0mLjx5Op?=
 =?iso-8859-1?Q?g/xDOGVx2FW+dqLM/uFJp36zemNOIgS+6FvwN66w+5H6Mob2WA5AZT6yu5?=
 =?iso-8859-1?Q?folmIT+QWKYR69Wd1BK2slWlsXuT1J5wxrs3WDSWZ+ERNZ/ZS7h07vaZmZ?=
 =?iso-8859-1?Q?1hpEep7ISDu8wJQdZMUW8/1d/yJgKA8UxY4qLkJNaG22SDxO/L4nDEBymE?=
 =?iso-8859-1?Q?SGHNQUPIT/J4j5XdpE/OaM0Uq+UNhkFigDcMSnKcxxi5F+JFeUQt4qbrbo?=
 =?iso-8859-1?Q?lv6qGIw4Bf5p62FzSs4NqX4uAtL/R88VyvXRaS3RAg1vN7GQMQl8OEZRAy?=
 =?iso-8859-1?Q?6jN+GYSenX8kr+BWvhhL7wJEPQkRjdQCCCFEwjkEheuCv63sfQ8W5yhzli?=
 =?iso-8859-1?Q?LPnomvpAKZs8XSJ1Exg0nKkTWODomxEe1sFNi77n2Lg/Fhk1ODzBPssZAW?=
 =?iso-8859-1?Q?pn8/VISfCkF7N7PLphCU3BdZnNjXfITxGhUDaZKJsw89G75yS8IYjKNECT?=
 =?iso-8859-1?Q?14/NqnrwPsNdM+7VKFQpyEoQjdD1Sm0lWerdF2mu8B78UcYtNMdlQMLpYh?=
 =?iso-8859-1?Q?9t0lJSMvqAtsfGxtSYZd5wLPgZTFYUMdwLhw35RoBtCv7H1Jf/UN6N0KSY?=
 =?iso-8859-1?Q?SkysPARxQCxNqR/z94FpqmmEXNwnPeA5fFwZMw8lgv7VvU/DYSVe0fL/Ig?=
 =?iso-8859-1?Q?WXR8CKaJKTyt8rwMTd9X44kqj7Lb++A6pyc9K38X27yWiPQDg++JYEAsU8?=
 =?iso-8859-1?Q?frV+pycApj0tASskWWVCNNlE/cH4SNszLow4osMiLp+Q6UGyp2fTJCMkAv?=
 =?iso-8859-1?Q?GXrsvFBM83QHeiS/UxzAjfM3tzzsTp1AJItYNZe1mcfn9td+bmi289j1E1?=
 =?iso-8859-1?Q?PJKzOKRFv1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ca5fa1-de59-4411-d322-08d8ee1a9e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 16:42:17.0160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1Mo0FloMmJUVozO4/preRjLZBCdCeDNH2C7Qyz88qbtx9Dy1WfvjVjYJ+bZZfbhKgPfV+UZctcJTzfxleRtBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============1291778890=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1291778890==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488265CA48E8991B90CDD26F7649MN2PR12MB4488namp_"

--_000_MN2PR12MB4488265CA48E8991B90CDD26F7649MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, March 23, 2021 10:54 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: use zero as start for dummy resource walks

When we don't have a physically backing store we should use zero instead
of the virtual start address since that isn't necessary a valid physical
one.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_res_cursor.h
index 40f2adf305bc..e94362ccf9d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -54,7 +54,7 @@ static inline void amdgpu_res_first(struct ttm_resource *=
res,
         struct drm_mm_node *node;

         if (!res || !res->mm_node) {
-               cur->start =3D start;
+               cur->start =3D 0;
                 cur->size =3D size;
                 cur->remaining =3D size;
                 cur->node =3D NULL;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C44108ad9138645327a7708d8ee0ba373%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637521081047640112%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DbswNGifbeRgbvoBw89PSiDTpzLbCbhqtX5xqMIRYsq8%3D&amp;reserved=3D0

--_000_MN2PR12MB4488265CA48E8991B90CDD26F7649MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, March 23, 2021 10:54 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; Chen, Guchun &lt;Guchun.=
Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: use zero as start for dummy resourc=
e walks</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When we don't have a physically backing store we s=
hould use zero instead<br>
of the virtual start address since that isn't necessary a valid physical<br=
>
one.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_res_cursor.h<br>
index 40f2adf305bc..e94362ccf9d5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h<br>
@@ -54,7 +54,7 @@ static inline void amdgpu_res_first(struct ttm_resource *=
res,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *node;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!res || !res-&gt;mm_no=
de) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cur-&gt;start =3D start;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cur-&gt;start =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cur-&gt;size =3D size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cur-&gt;remaining =3D size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cur-&gt;node =3D NULL;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C44108ad9138645327a7708d8ee0ba373%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637521081047640112%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DbswNGifbeRgbvoBw89PSiDTpzLbCbhqtX5xqMIRYsq8%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C44108ad9138645327a7708d8ee0ba373=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637521081047640112%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DbswNGifbeRgbvoBw89PSiDTpzLbCbhqtX5xqMIRYsq8%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488265CA48E8991B90CDD26F7649MN2PR12MB4488namp_--

--===============1291778890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1291778890==--
