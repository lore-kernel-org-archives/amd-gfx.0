Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 07:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BCF60F51
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 07:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67BCF60F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062596EC08;
	Fri, 17 Sep 2021 07:35:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F886EC08
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 07:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRJO/pye0Uy2yUKDksDzP3nSD4vLQhmuK9QM+n25iw/YAM+VjjV+k+YcaTLRyVZdOHszMtsL8sAIGxdCNp/cfmk//6bljBG6dq8N2ZB9BAQGETQAQ60U2vjM6Kuytpyrm02/Flfrjn9P6MnOuJbklesoWimOpCYwzsP6PmFNtR9eAaOaboAshS99Im+hDktE6eM0I1kSc7un0iV1FCm8wW4CWAUiVLb9tycxyJRTCutKgEwxjxuoEfyzjF1NHLeGcqNlYCzqamikPr7XsUYrnbu61wfWXCkzwjbgAXLWmGiFMBqUPwOrzXAlgzPqBXVzlHto2WtQzMX01NQwmV7UlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=QjPGlifbGXwwHppTAmYCzMwoOnJ37gAiLKLZoDpEv0k=;
 b=a32Ay9J/csQyGHKqXMzHI6kjh5/ZeEhvS5X+llQ5/CgmIXf5Fj4RlghaQzgffa7d+diPdkRddnK2WFuhCLs5WaGTbIiMa5lVbLz7SOSPzfaGr0XeuxTlX0QvI7XCC6ssLM5UNydYjnWhiCq4CLLtTa0wJQDTXqOlc5xbTzMP/SxjeL00w4I4Yz6DEqbcDJTV07qnDz3bhD+7SekicYyw2dg1fgXCNNjIl8GcNe3vH+PxKxdW4xIIYkVLyq7yU+VlbJbbA4ArEaHmZ5h2wcRSvUR8okFlB9V/z8forYd6e36bXw3pEbweEOa8/YG/z64ENVb2icqYuQGjiAXlaJGQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjPGlifbGXwwHppTAmYCzMwoOnJ37gAiLKLZoDpEv0k=;
 b=qNdT8ntbdrRvmto3d9Liw3qkoG6fGHSEtpjv9jLo7A8WJOdPf9ir6rYIwG2zIBHuxTsdmxqcSG1imSVdVQiZ/WFslia1ksvjmUjKmrFZxYdEYbHXUI+Rjywr/s7MZzLGW1PO3v0bt2qhS9q70tBsLYdN6UzyW71E1MM81Fxlumk=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5262.namprd12.prod.outlook.com (2603:10b6:5:399::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Fri, 17 Sep 2021 07:35:12 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%9]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 07:35:12 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Let BO created in its allowed_domain
Thread-Topic: [PATCH] drm/amdgpu: Let BO created in its allowed_domain
Thread-Index: AQHXq5JUy5WVKjfp5Ey9U5r5OtNv26unzd4AgAAH3HY=
Date: Fri, 17 Sep 2021 07:35:12 +0000
Message-ID: <DM4PR12MB5165DDADEE756AA4B3BAD54987DD9@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20210917070444.4867-1-xinhui.pan@amd.com>
 <59a231be-f623-196e-e547-8d5c75d0f314@amd.com>
In-Reply-To: <59a231be-f623-196e-e547-8d5c75d0f314@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-17T07:34:23.4182955Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0e8f095-ccc7-46f4-7063-08d979adaf1b
x-ms-traffictypediagnostic: DM4PR12MB5262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB526253E9160871490272B0B687DD9@DM4PR12MB5262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fl03m0XOVKtg7K63RNVN8MQ4KCRgmaEnrbieBNzVFU8Kr95cCPGOE5un4dZAgXj5Q8uiu5n3ZwyDow9IAyhfoDY0+9erAvm73/1xLrH7WXHNKVb8COHlv9ThdQEjr6Wy++4yF5nF13CceqwCYmvVPi9wEhRzSVoFLjbxxdgI0ux0aMoY9Yn0sW8dOCpysZw4wizswJhZWl1UdsPJjDQtq0I41XORF9oaEH1S9TcYZZJ3/x8fuXQN7blLOIhH27CeenHZhEAwytUCcpBiS+dZHyrN7bLNljTWtHUr5fGfWho1K+jJBFK4AxteYQv6WILnRiX1IyOYWp0DUD40dh3sGY7M7rG2PmviwVqPlaXncAgUive80QAmBw9hWmFCeVFeQK8O8p10wOClNpGDTYE9C/SfipOOhtfJLcqo1YJYjXiVgFn881ekhRjwaCa/20zYpnPcxZJtLBXVD+/CIRNu8MPAXNxsacrvrXyvrJApQb4YmihZ08nK4uPwANJxyQrbKsG5lj04l9K2dENLp9qTPfElthG46GTm7vD83ZUuwPv8t81S+dGFs0g/qjlxRF01hoaoRz7eHXW940ApGUKB6BBzJ0krfNY+jehnaHoz7ZQvlP3L6gxCGnxRY5YvCs1HbRJiyBHT6G0PXKOso8KAp5xVMFv9lIGkIHlGaioVeUvfVYBGZdrfpBGYa52xVUsSKmQDlapWQoc64xlBV4bLOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(38100700002)(122000001)(71200400001)(83380400001)(8936002)(8676002)(9686003)(186003)(55016002)(7696005)(53546011)(6506007)(26005)(316002)(6636002)(110136005)(478600001)(52536014)(64756008)(86362001)(76116006)(91956017)(66556008)(66476007)(66946007)(4326008)(66446008)(2906002)(33656002)(38070700005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7oxRWJzz/DAx7oBzboPEqHOqHSlcl5A4qsLE8FJa3xaBdgL0AQHN1ej2WB1Z?=
 =?us-ascii?Q?K6JYWniN+a19T5T78V6aB5zML3NDgaQeQwQeuT4hxDkU2HN0J8t0HG1wNR/1?=
 =?us-ascii?Q?N+l2F+FH/hwSQF8txXiEdJ5FcLk0hvZtdgpnjv/vsIgHh2iieXCY+tVME5zR?=
 =?us-ascii?Q?489pBsuztCDi8aP9OZWEwCkOHSrgUwvMLC2qSc0ehBxQr/qbVUREYmyYCNFc?=
 =?us-ascii?Q?G0P4K91fjb3iiSibo+TaS8jXTuGVa7PCbp0+19cPj5MghQTUNEbJJ+SbVJoq?=
 =?us-ascii?Q?4hytNIdvIcRlFn50SlPkL+n04sZAou6GD4XG2834M5sX7mnHwi4uYhYfKi2Y?=
 =?us-ascii?Q?P+Aq3b4kbiaLvDZKjzrJMMJqjxBKmIDRLeSHxekS5LUDMJxBi4HLkEwC6/rE?=
 =?us-ascii?Q?Fo9GB8rPodFulN4mssR93MI2MNXUoduPgY3s94a0/42mMoBFSl97yOsx2Q2x?=
 =?us-ascii?Q?ZMcmMWw1IQCv1SWErE+i5OQK+4OrmO/dqOgAqNLvCF2V1rQS9dY3bJgsql1x?=
 =?us-ascii?Q?Qy82Nu7A52YYOsbCkXjMzezS0F7hA6/ccf83bSraWfpiKFRVY3orGyMNqKbq?=
 =?us-ascii?Q?XFD0fgahFefuL3WPm0po/7vmfUA9rBd9TljJDfUkNhyDktctuZhSpDnqDn7s?=
 =?us-ascii?Q?5NRNs6fp7IfkBm90Gifnm9w1sxKHvTROATNa5IQHceOvZswgH2P6TsM8tLFF?=
 =?us-ascii?Q?/7ji27wUF5HW/G1edhCWK1xqjoicjntnYOs0V9elXGkOu33XOPwj19wmx5M+?=
 =?us-ascii?Q?fJQo2cWwkIfBYVKAapwsX50xAAyuYSp6Sc+S4orGbc7CnmOVGbKwYgIS5a8n?=
 =?us-ascii?Q?ahiTNiuswT1Onxnpxl4Blgthofr3feifBQ4+syAJzKZMLCDrgimutj38i599?=
 =?us-ascii?Q?fefLpswBjLZW4gwMAR1NFnBq6I0O3Mz6sgKpC330Sfa0DkYyFx8F/tLWa9nQ?=
 =?us-ascii?Q?bPwSH1bwmnzXHHwAhRm2H4HgBIqCvNZAB3sJGzMD+qYDokmbUAMyQzRKQ7bO?=
 =?us-ascii?Q?CEBdytBtq0THamKOa93mPbhuNlKAD73paHQav2Kx0pTxZdCHpcsAm3YRzuhl?=
 =?us-ascii?Q?LkYVQol3FmK2U+J/wkbokPw/feswgzS9i8PnvcK1pm/60ginFJ9bGN2Dx0EU?=
 =?us-ascii?Q?2KiBxk/j5zLnpk6soWdj52OcoFsfJWhKs2aSs6O/YmDFtfT2aNAkQG+L7Edy?=
 =?us-ascii?Q?ZpgNXd4Hn7OHn75CdXLDjSZvV74DOm0OLdJffHyoNUFQyKWz9H/0nWtPh4v3?=
 =?us-ascii?Q?jUYBa79KAYrlRV+dFOefwOZ7AonGRHottCr9dYCrYBnX6HDrGa7xrE4GNnKE?=
 =?us-ascii?Q?QtVw09qgzSYf6x+4nX31BIUa4BlTMYEQAZrBshTfDFXqPQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5165DDADEE756AA4B3BAD54987DD9DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e8f095-ccc7-46f4-7063-08d979adaf1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 07:35:12.2893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e88GpBsMWYIoykix3v+xxmJhCAhMN7jtFFDyA/LB7b3CPOMf8+WaX5Ke7KYAhCo1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5262
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

--_000_DM4PR12MB5165DDADEE756AA4B3BAD54987DD9DM4PR12MB5165namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Why? just to evict some inactive vram BOs?
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, September 17, 2021 3:06:16 PM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Let BO created in its allowed_domain

Am 17.09.21 um 09:04 schrieb xinhui pan:
> For any user BO, it is allowed to alloc memory in both GTT and VRAM
> domain. That means one VRAM BO could be eviced to GTT.
>
> Now if device is already lack of VRAM, this BO could alloc memory from
> GTT directly without evicting other VRAM BO. In this way we can reduce
> memory evictions.

NAK, that is intentional pressure on VRAM during allocation of new memory.

Christian.

>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 66bb8a53bb20..9a547bb38cda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -579,7 +579,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>                          AMDGPU_GEM_DOMAIN_GDS))
>                amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU)=
;
>        else
> -             amdgpu_bo_placement_from_domain(bo, bp->domain);
> +             amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>        if (bp->type =3D=3D ttm_bo_type_kernel)
>                bo->tbo.priority =3D 1;
>


--_000_DM4PR12MB5165DDADEE756AA4B3BAD54987DD9DM4PR12MB5165namp_
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
Why? just to evict some inactive vram BOs?</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, September 17, 2021 3:06:16 PM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Let BO created in its allowed_domai=
n</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 17.09.21 um 09:04 schrieb xinhui pan:<br>
&gt; For any user BO, it is allowed to alloc memory in both GTT and VRAM<br=
>
&gt; domain. That means one VRAM BO could be eviced to GTT.<br>
&gt;<br>
&gt; Now if device is already lack of VRAM, this BO could alloc memory from=
<br>
&gt; GTT directly without evicting other VRAM BO. In this way we can reduce=
<br>
&gt; memory evictions.<br>
<br>
NAK, that is intentional pressure on VRAM during allocation of new memory.<=
br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index 66bb8a53bb20..9a547bb38cda 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -579,7 +579,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMDGPU_GEM_DOMAIN_GDS))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_C=
PU);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_bo_placement_from_domain(bo, bp-&gt;domain);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_bo_placement_from_domain(bo, bo-&gt;allowed_domains);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bp-&gt;type =3D=3D ttm_b=
o_type_kernel)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.priority =3D 1;<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5165DDADEE756AA4B3BAD54987DD9DM4PR12MB5165namp_--
