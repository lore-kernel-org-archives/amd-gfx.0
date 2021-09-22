Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 20:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECA060F12
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 20:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6ECA060F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0631B6E513;
	Wed, 22 Sep 2021 20:43:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F04C89DFC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 20:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6b39uGqq2RLun0Invr9jMsznp42GG1+HY/tIopQCwxtoqYn1TYSR62q0zRYuU0KxnzOwu+TKChOU6r3TatPwM/7dGe4D1jE9PWeh82XFN3hB2uFQGHlgesLVmgq0foDPlSr61ucxI/3xITdiNj0cMl1exDQ0jm95FVncZKiF59k2CTvzC+DrPRKxxgWCna8UI50MuA3E4AjlOSLUF6EV93e+87hDmVv7bL85EisrH5cXqtPbfI22v6qa2RZlyaE4MXms2SZ1pkNNvEJW5IG2ewUiHTPhRT1qRsjgzOxmvtb2j24KDQIjFU+DDlyt+ldPODhPEK+P3JBjXrGpGdtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CjMdUTbG7yrbBqMiRlETLuc8CwBsAj51dksvrzoU9c0=;
 b=VENZvOyKZ3pux68H3288fOHKiXtbCfJXdVm9tQal/x3NjfwEqKiwLCG6K+BB1mJKTY1dhH2PDroX+gAVnSn9bxRqSxlUZZvSlmcy0YkEJYh9qAUWHbC5HPaXBAqtb68ogPrZJPxyB2doG+he+J0wUjMM+JPSa2Gi0ueblHQ5sewbx+XTVeirle1ULqnOGwVqSv4R34O7SFTltfAt3zaFx/ZvUeYvGy63pqqOtwOwDpfA4eTpX1pT9aFHo80XGGryH+8zMdw1jyGzDmIduFGpHy/4lgBxCWCPM2JYIr+nkWYDVW0u23lFIMxkYvEqr35m/UWG1xgI6XfjGFjrAHaU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjMdUTbG7yrbBqMiRlETLuc8CwBsAj51dksvrzoU9c0=;
 b=P8ZBkzGSg5SMc5JIiJKHJ/njSfTGIgiWgIgZnpzdoXkgFppSLvxhTrN1WCRO2lGaPQqPxyDu0prVJ71FUI8hFZLf9FOUTuYcBg/5cHXTq4VrZG4LxR3iVfpySV6YLIJWA+ZE5fN2EBBrs2USRVItHr4kLoEjaEVjONxqU9i8YfY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 20:43:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 20:43:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 04/66] drm/amdgpu: fill in IP versions from IP discovery
 table
Thread-Topic: [PATCH 04/66] drm/amdgpu: fill in IP versions from IP discovery
 table
Thread-Index: AQHXrxOTQTTfWf050kmopBkUkwt/EKuwR+sAgAA+3SQ=
Date: Wed, 22 Sep 2021 20:43:25 +0000
Message-ID: <BL1PR12MB51440F26A76ED8F7EB64FD91F7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-5-alexander.deucher@amd.com>
 <2255611f-a086-366d-715d-85147b4fee4d@amd.com>
In-Reply-To: <2255611f-a086-366d-715d-85147b4fee4d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-22T20:43:25.212Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 2230b4cb-b5bb-0d7b-de0f-4894d9fcb3cb
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 132db5c0-a930-41b9-96d6-08d97e09a06a
x-ms-traffictypediagnostic: BL1PR12MB5144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB514478DB7BCBCB26DE6E6E3BF7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyxSpmlkUbo6OPKkg/1UYGsbzIuZ62wN9PjlSGgDfOZYVOdCywruWnhug/E0wh0Va5YgzCy8ah1SfeXbwHJutjMtpWNLvu5S6OUkMcjTRKB2RaKQBHz38/xq1WzriCKy4vFlvz4ipyrsf6wX0q3Fr8rsC1Msd9R3ZvJ3o3w+9p3Jos9bZzdQAaNPuFNkGGUxQrYKS0idH+FiFCDaKV0PwMxsUIPeiq4zHR268UQsjZ5BMg43CyjV0VvaRrPCnn46BPCEmIC1lprdYwPsFqg6bvL3oaOd5rayyzBd169vLABbznIQT60Odp6xHGdZ3QPPrUW1RV/+Bx3wafTkADovcCpOhBy2REbv12cVznCAYkAgeqw37ZwQyncqkwK6aU+1rk9+uRiFvoILJuIQeBBsXgR2uHqBlz9dvSw8eRvNesNu/cYJ7XgHT/uTypgcbCVitfRT9QU38L0qX9e0iPsfRH+BLOnWCH/z16O4BqMOnqql1LoK3F7AbWsn7XTj2dW3x6lyWnd0kwIeb5gNnqNvam5ISJUw4XHUgE9dNGWvyiYN6n9LQn1AGKXYSbyd3baWhbVS9QINpWk7wLndQ7IIWj8+0+7K2YSVY7p+Wxx/nahUPMBOfwNeQa3Q2KUqvln6B3Sj+13OwLx9g1WoatzIxhpoQuPe6pBGoYmLivZBw1u+Bk7XPZYhY4Cdqo8w778NxvcOIZq5AYv2bDBKxXVsAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(186003)(53546011)(19627405001)(66476007)(508600001)(2906002)(38070700005)(7696005)(6506007)(38100700002)(66556008)(52536014)(86362001)(33656002)(66946007)(8676002)(64756008)(66446008)(83380400001)(26005)(9686003)(55016002)(71200400001)(110136005)(5660300002)(76116006)(122000001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q4QqhPJAxA/xxLkKXW7fjUENkDt/1BpnZFuS2umCxHu3IikNl/jFeLOx0Sse?=
 =?us-ascii?Q?fYBI+WqoD4SBtnkywxtAMmp6+MUeTHTUsptvI6drX4iufO6TLLkwHt/0MMe0?=
 =?us-ascii?Q?eoCz2ZxMZIuLw2X6tsbxuzqjeR8GZUqCsanmplDdJ02qx3MhFk09Hiu/t9p2?=
 =?us-ascii?Q?J2q+6SK9GV3Gt+ZYiHkZeIiBqIAGfUImWQtZJApu9XqiuSeFywDtg8OvCEn1?=
 =?us-ascii?Q?7/41ITqSXqJoJPJtDju7QprDjtB2gRT1ML7FJpyKQr13uTYcgQ7eiYb6i3GW?=
 =?us-ascii?Q?ulzkKGs296gM8l1YOzIM1lIWKZoAKO0+3Azxcc0i02oCiRksDskVQmRwF4S3?=
 =?us-ascii?Q?fNn1gQUu8hHWXLxjxQZb8gvkLtROfzhimf8ZyCvyrFfhh4xnxc1ijDzTpH8a?=
 =?us-ascii?Q?Xwb+4iKRKWDFU9YDQ/LEw8bDroSW5F2SwGvh0jlLv/+erYTQ41LL9kKsRmah?=
 =?us-ascii?Q?gXaCcR+PGmAjWPpsS120lvoHZMsXkaBJ1vxtoF3yzXLwdVIc87qlNYYiX6a3?=
 =?us-ascii?Q?TlS/Qq9PseaCjp+ZXjnEIGzHcMOmlBtqg5V88YAA14V0xl7W+XvpRlM0cDw5?=
 =?us-ascii?Q?vR4ncvfYISSnhZYRR0zUS27wkh4r57hvWhsCOSCPKB4d/G4OoW72HwwTnx/K?=
 =?us-ascii?Q?NVfYjR98TXIheIdWEOcv+2bizIAfA/Vonedh38JU0aqRof079zW2Du3Wx/Hv?=
 =?us-ascii?Q?9EVfzae65PH2QfzZKzE1MhwrgwYSWkHRoH1CDEE9mpa7191NBiPCuCKdbd5S?=
 =?us-ascii?Q?RNzRIgjfJg6xu/IxalTXisgzMT3zoTDEK7da7tcOn9snfn5arAiV0cmKyiPJ?=
 =?us-ascii?Q?xeGgEwqhNYGAtiri7YNupt10vR50Do8nlRvdLjOndfdkqi81O/MMoUOO9eon?=
 =?us-ascii?Q?6B/WztS42ACGk2FSbk5CBFGQuJqiEKnaCEeCIwI+nFgXZYUqqVA6MA7Qcf1+?=
 =?us-ascii?Q?tBDaIDZbEr/E3hK47TxfCIBbTphW29NWDGrdsVeQqXIqxnC8HFS+4/WGOo1/?=
 =?us-ascii?Q?07uwH0zfQQSDwori5pzQSKYUXpG3fUb60YZ0NuKYdEWfQYXfNwMQX/kGN7v8?=
 =?us-ascii?Q?CU6IIXvOw6gOsWxD3tpH2ora5scZv28Du0PZeR7eWlZlTmfVXg1UiCy+y1NY?=
 =?us-ascii?Q?EM5TCW4BDTscWWtDF0IP7/fsL1k7+ZpCHD+2CZnQk1MCBJ8qWVapIMSuwI6I?=
 =?us-ascii?Q?RAntdSw3tmZl9hXDrZkVLIs8AL2o73sUjvc/AkzEFrV1iv0UwUMf3cyKrSmF?=
 =?us-ascii?Q?iuAqKMmCLctLJ6ZETlOqL79GWHEtdsPSERzU+Ylw5+bUbTY4ixDTHXTv2awx?=
 =?us-ascii?Q?QQAJ8VemAK1gzE9KsNRb0xXA?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440F26A76ED8F7EB64FD91F7A29BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132db5c0-a930-41b9-96d6-08d97e09a06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 20:43:25.8899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSYx0xYkO+nGCbj7m09pQ61IOAqbHkRzgdcvkBc+Hwy8xUC8sRSQHGCPnDNQdKqr0wiT6GQOBlR3524hr2W1gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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

--_000_BL1PR12MB51440F26A76ED8F7EB64FD91F7A29BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Fixed locally.  Thanks!

Alex

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, September 22, 2021 12:58 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 04/66] drm/amdgpu: fill in IP versions from IP discover=
y table

Am 2021-09-21 um 2:06 p.m. schrieb Alex Deucher:
> Prerequisite for using IP versions in the driver rather
> than asic type.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 67e7a46f5020..ff52fcce1f93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -244,6 +244,11 @@ void amdgpu_discovery_fini(struct amdgpu_device *ade=
v)
>        adev->mman.discovery_bin =3D NULL;
>  }
>
> +static u32 amdgpu_discovery_convert_version(u32 major, u32 minor, u32 re=
vision)
> +{
> +     return (major << 16) | (minor << 8) | revision;

This does the same as the IP_VERSION macro defined in the previous
patch. Do you need this function at all?

Regards,
  Felix


> +}
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>        struct binary_header *bhdr;
> @@ -316,8 +321,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
>                                                        hw_id_names[le16_t=
o_cpu(ip->hw_id)]);
>                                        adev->reg_offset[hw_ip][ip->number=
_instance] =3D
>                                                ip->base_address;
> +                                     adev->ip_versions[hw_ip] =3D
> +                                             amdgpu_discovery_convert_ve=
rsion(ip->major, ip->minor, ip->revision);
>                                }
> -
>                        }
>
>                        ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_add=
ress - 1);

--_000_BL1PR12MB51440F26A76ED8F7EB64FD91F7A29BL1PR12MB5144namp_
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
Fixed locally.&nbsp; Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 22, 2021 12:58 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 04/66] drm/amdgpu: fill in IP versions from IP d=
iscovery table</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 2021-09-21 um 2:06 p.m. schrieb Alex Deucher:<b=
r>
&gt; Prerequisite for using IP versions in the driver rather<br>
&gt; than asic type.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++++-<br>
&gt;&nbsp; 1 file changed, 7 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; index 67e7a46f5020..ff52fcce1f93 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; @@ -244,6 +244,11 @@ void amdgpu_discovery_fini(struct amdgpu_device *=
adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.discovery_bin =
=3D NULL;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +static u32 amdgpu_discovery_convert_version(u32 major, u32 minor, u32=
 revision)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (major &lt;&lt; 16) | (minor &lt;&lt;=
 8) | revision;<br>
<br>
This does the same as the IP_VERSION macro defined in the previous<br>
patch. Do you need this function at all?<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)<b=
r>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *bhdr;<=
br>
&gt; @@ -316,8 +321,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_d=
evice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_id_names[le16_to_cpu(ip-&gt;hw_id)]);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;reg_offset[hw_ip][ip-&gt;number_instance] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip-&gt;base_a=
ddress;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;ip_versions[hw_ip] =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_convert_vers=
ion(ip-&gt;major, ip-&gt;minor, ip-&gt;revision);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_offs=
et +=3D sizeof(*ip) + 4 * (ip-&gt;num_base_address - 1);<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440F26A76ED8F7EB64FD91F7A29BL1PR12MB5144namp_--
