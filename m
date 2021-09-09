Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C32CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5519360F5B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5519360F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C542389ED6;
	Thu,  9 Sep 2021 07:57:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F70189ED6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 07:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiVd8Ss7eTIwipn0/Sm/w9tnBhatLKV909aAnbg7laLyiEId4IaXzF8FZAZlCYi0NfQNIdIAwCNECa3Lqnd1fghGw4GUJxLWarS6iNPJuikjwCNMd7Mq2n+Hwyv/JxoEDwwVbjzRSxXgdKcyGszbugszUxS92BLnLaXdK2+QBCARfZOsONTCgDyk7SHcrnvVY1SVbR7ETMkBgeH9i/LWze2sKjn0vNiAkqAsy/pJtNKFwH7KqctmAqKUoOBBpS6lTosv0bq0KPXgz0PhMVRsABFNFoOrrp/0cykxOxRa/XDGExBwhsP3RQeob1DR5S39jSsKhhx2nemoe+EMyrlKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5lba+NIcADyIvR/N6BjrFDayeOZdzhGOhFiXmXIgqRg=;
 b=OBOoTclZPr68udW25npSGgFlrrqHulMRiyA6fBh8d37RhQ5wrrhqoyZAu8UMwWXDIqSD4oIQ4L2FDdK3PgtdM42aUNd7LU4qtPCANlg/OqG2/gLmjLP1GuqooggrsgeI6afGYf3cry14MtKp3mg4crRI8xvIYzFS9LP/d5RqxssLUYOr6VDYFBqiWysDViicBQFpujC6nmNy1hwA0t0BU84cd5OlXR8n+k7RRMQwoVumbePltPyyFv28x44bqd3bDXqnsr28M3c4w7v6JNQE79eta9275yo2njLcBEft3Sq1/8LpLSV6co8o6q0iKiCxTOQfKWh1l4srNRawv20ayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lba+NIcADyIvR/N6BjrFDayeOZdzhGOhFiXmXIgqRg=;
 b=S623xlScU7Ur1xZ9c6XCN0WdUknMZtdE2VPvewb36tefVo5OOAvG1qjfnOYkoMc25TP0RJvgDTuW3JC3qYs8iAchzkvu6uFz0zSnRoltk4zgXAP0qLAqW3jPW2AE/jI01zeV8e/LuOkDu2uhaepVW/WCDObCdHAmTwtjJ6VrYG0=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Thu, 9 Sep 2021 07:57:53 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 07:57:53 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size
Thread-Topic: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size
Thread-Index: AQHXpT8MSA2RqCNT5US18UJVCGUmXqubShmAgAALg+c=
Date: Thu, 9 Sep 2021 07:57:53 +0000
Message-ID: <DM4PR12MB51653E83408F2CA3F3D5029687D59@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <DM4PR12MB5165BCC3E4E26C7EE4E85F3B87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
 <8c56cc27-a99b-3ea5-1bf7-59cad134fe21@amd.com>
In-Reply-To: <8c56cc27-a99b-3ea5-1bf7-59cad134fe21@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T07:55:26.6587914Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15bae23c-00d3-4ed5-aa92-08d9736786f1
x-ms-traffictypediagnostic: DM8PR12MB5462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB5462948D3D3F3402C773E0F287D59@DM8PR12MB5462.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cGlU+n/6gPDPleVOCOLTqmLWQtijjupz1hZciSjc/TjFeWM/UOZPqgOEJzDIV79wF54AQz+7TILk4bB587dB4+boy3/mnlTuPItkcQ+DgbRQNWKFhEId1E99yyMRGDLX1EAu2VuY3BffexI0PAetWtPZtlA4gDsHr4CVJKTA9nVX1Z587yqrJH00+DXFSGOhSLClA7EV9+3xIDPKvAxS7ijgzzKEzmFmC2xfvucSfjD/7bI7dJTTTPD3seUwmL6IRHCbftKXMxoQj/rEnm28WaZcf1342kOkRGjbW8iVl03/3MIZpygBvXdSOH/w0eqX9giu6uqKJkpe/uH/Q5M9hptFbHpt5EECJ3M+c5FXhh1KPAIItkwdQ1sIDFzU9l6E7YmjxFAS2rRIHzjWUqqMQNkW8S7hpQRfhAPq9zPgfZCbqH779XbojC9hsIwg9daLQ2hzHKBpIg8a6rzH0TGfmGg3oA3btgBIma9BSboKYbtkHkvMqIt8qQly/jnkI2Wmq8ZOstcC1BdEMvIMFMqpM+33QzWWG4+cLtL1GsMiBnoiUr9u0WLt/nPg8KcZhmlDRtK3onf5BrUk3dk+qABYMDPAB0bpiMSZZKmOcitrhH4zwWkZSheKBKEZ9NdzCfaaoEx7rv+4WyyBG1NzgN6xkABy4VF+yvEszBP9To/g2dmp0H8P8pZCRAt800bdi6nuwyCocK87F5pKa6g88hHeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(4326008)(26005)(66556008)(71200400001)(53546011)(91956017)(66946007)(86362001)(5660300002)(76116006)(186003)(83380400001)(38070700005)(6636002)(9686003)(8936002)(55016002)(7696005)(64756008)(8676002)(33656002)(2906002)(6506007)(110136005)(52536014)(38100700002)(122000001)(316002)(66476007)(478600001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1D2wkZ1GTCulG58M3w9+XP/I7Uxs2FGW6XXthpkdzi0CZkRXCeGveBf/gvc6?=
 =?us-ascii?Q?O5WRqDfh4eSJJITEcZt09BmsEoiEoW5CANTf6QJhJtbW876M4r/lPrVDUaCv?=
 =?us-ascii?Q?qr5k/f/0YIPhJEvWCqNo/BKcgON47HgJQ7rrZgK5CEojhG3la1SLXH2MhcUj?=
 =?us-ascii?Q?RfX5x2x0Bp0MUOx3wbEKZd1xz4r6cISRQ3sMzdJUB0J88ngiaJcodAV5Idf8?=
 =?us-ascii?Q?SOIHjiKhvDtqOkNJCjXMtsaupX3xFB64G21sWnUR3wf5P2ToYlx0NKS2e9LN?=
 =?us-ascii?Q?WL9qvKQnGsKzMhGRXrm9MmbgI4B4WDnk5V5Hkge20XTAlF6C39zP3LfTmAMZ?=
 =?us-ascii?Q?hSvr6Irx9VdHFb+p1xSioyFTdKYkAf/+PaiJ4VnswtqTpC+tQE6xUaGikLsV?=
 =?us-ascii?Q?YwFurdQllVjH6lH1WrJqL1C+xLdtvWS5uZgjmndRwPzvxltWJ+5A9aVq9WGF?=
 =?us-ascii?Q?/1nmrSWvHb0gUcb4HlGmDtW3uUkj3d+m4t+thTuKW+Toit2BQs8R4eBr31ey?=
 =?us-ascii?Q?Q1VHzBL0ApWCq97wA+PK88+ins65175yULWaBOkHkhj+k3tsYxKKU7mhJmtB?=
 =?us-ascii?Q?ZolrNyCQrzGz4wnM/oH957SRfDV2NBWvzmS92g8ohOPIq4Y1Vi+OhkkkdEND?=
 =?us-ascii?Q?KQfOqYFNNDHadn4btlFhsw3Whi4DdS6J18xTJLD0s391QB8m/C1YsDDMzPHa?=
 =?us-ascii?Q?GUsis4XF2WVTKg83OpKyE2TI/Xbjw9EGoPyyN1zx1uq++jN0KsQfWK+HS++X?=
 =?us-ascii?Q?/xUeCo5Jonrp9xmJu8mCcqeV500CDAkNNc74zT1VDURUxJezN9nfe/7kHsdM?=
 =?us-ascii?Q?LtCYLcUYLlY1gedQ573rCMYo0/mi2jCqq9NK6eD/NDXDlJNYsgJNbm9q7WiC?=
 =?us-ascii?Q?5759JmXSM6ohvThYiXreshWWK0OHJ54T9baSsCtGJ01I5+F12s4RemcNZC+o?=
 =?us-ascii?Q?+A31knjG2nqcAZvNFdp+saUVpxr0d4hRuqJprXA22wLbosr2wfVBIBL61Hqm?=
 =?us-ascii?Q?dm+dQc/UkGopwRYGxaM8GmxclbOastaHUF8LQup5QhgxMByfP9azMLNgFQ/w?=
 =?us-ascii?Q?YB3ELGyv2o9n9NWJ9klv+UIMKUpcgEtGrkbUpU+1EByhC9PxK9drvrgF00rH?=
 =?us-ascii?Q?ecR+mhi0QJQFrdSoTfIIXjC0Qh3kkML3TPExT/AXpRToX7yhYegam+iCWjJ0?=
 =?us-ascii?Q?JpR1iuiAE4KGrws+RQkZKi1qJzehCw8Zdlq2oKc8ChFmp31rAMzQtjqarMkJ?=
 =?us-ascii?Q?Wp8r4/UXYvkFXxTOT9VxTfl6/78/aG4XJd1g/CZpNKwyYhJvx93XyncpG8wa?=
 =?us-ascii?Q?KBA+ICJ/3hpW8ncRfifNpn0JgAvDxAa0nCNfukY6JwgtFw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51653E83408F2CA3F3D5029687D59DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bae23c-00d3-4ed5-aa92-08d9736786f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 07:57:53.1271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwh9EaZJpBLIT1IwB8eLcmOGgCfUN3rWuDb3H5hm+RYaB++zFPaSONtXwyALAdwL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
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

--_000_DM4PR12MB51653E83408F2CA3F3D5029687D59DM4PR12MB5165namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

yep, vcn need 128kb extra memory.  I will make the pool size constant as 25=
6kb.
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, September 9, 2021 3:14:15 PM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size

Am 09.09.21 um 07:54 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> Direct IB pool is used for vce/uvd/vcn IB extra msg too. Increase its
> size to 64 pages.

Do you really run into issues with that? 64 pages are 256kiB on x86 and
the extra msg are maybe 2kiB.

Additional to that we should probably make this a constant independent
of the CPU page size.

Christian.

>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index c076a6b9a5a2..cd2c7073fdd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -308,7 +308,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>
>          for (i =3D 0; i < AMDGPU_IB_POOL_MAX; i++) {
>                  if (i =3D=3D AMDGPU_IB_POOL_DIRECT)
> -                       size =3D PAGE_SIZE * 6;
> +                       size =3D PAGE_SIZE * 64;
>                  else
>                          size =3D AMDGPU_IB_POOL_SIZE;
>
> --
> 2.25.1
>


--_000_DM4PR12MB51653E83408F2CA3F3D5029687D59DM4PR12MB5165namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0px; padding: 0px; font-=
family: sans-serif; font-size: 11pt; color: black; text-align: left;">
yep, vcn need 128kb extra memory.&nbsp; I will make the pool size constant =
as 256kb. </div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 9, 2021 3:14:15 PM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 09.09.21 um 07:54 schrieb Pan, Xinhui:<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt; Direct IB pool is used for vce/uvd/vcn IB extra msg too. Increase its<=
br>
&gt; size to 64 pages.<br>
<br>
Do you really run into issues with that? 64 pages are 256kiB on x86 and <br=
>
the extra msg are maybe 2kiB.<br>
<br>
Additional to that we should probably make this a constant independent <br>
of the CPU page size.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ib.c<br>
&gt; index c076a6b9a5a2..cd2c7073fdd9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; @@ -308,7 +308,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev=
)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; AMDGPU_IB_POOL_MAX; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D AMDGPU_IB_POOL_DIRECT)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D PA=
GE_SIZE * 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D PA=
GE_SIZE * 64;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; size =3D AMDGPU_IB_POOL_SIZE;<br>
&gt;<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB51653E83408F2CA3F3D5029687D59DM4PR12MB5165namp_--
