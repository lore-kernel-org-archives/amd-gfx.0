Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 15:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C436124A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 15:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C9C436124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638C56E884;
	Mon,  1 Nov 2021 15:00:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD826E881
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 15:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmWYwWEBzIZJtRMJLBGTHKp53a/PR+X/qvqqr2yeHSZ0ESjPQ0qULGpaLHw3AYKrDwLP56951Zxzi/qIwQCV0cD45OoKotIQMJgZVoupMOTIZax0Jf0BSb+/rPABxmvi70RwuzWdZmd2wFcq4dxGfAnD0PzOWoo2TFrmxkj7rqhYk9WpxUZWz7fVNwnxo6+JYx3yJlC1SC1m1Mj76+Nftgg0089zOcODgWe6GZbMRSdQgGLchCqgVlyTfRXit2gE2ICXcHEyyqNYjeXE1MEE0/nTilSzUuYui6L4gRhFEwN25tihwszbYs5E5xkq/qNqhNy5NDH9AlPyH1RsgYBqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt5WybNRVsgp0NPkxqEF9TTF9yRWfkbqxpRK3xt41+M=;
 b=Cx7/7Qt7OguR0SCf2EAfCn9ks4of6igSkMHR1ZK5e/FrtsjWU/NlDRS9/8wayx4WciTDOC5QZUVniG6ZnKx2fVa9PDWXzk7TdQw0DoNtnsHOrhD/9b18MY11zDu/AQSj+i2Qv3p/Jj/6xWT19yTlE/NTEwgbW9lzDXkQ3OL4BzBycrf3ZHJkc+1xhHH2X31EK04fNZauAoeELYOEovAhadopmERVcWgUotSr046w/+8zOtqn84ySeL+rmcMfnsX6do/qHaz9TJt7huImRkvatKKlWijvE51Pg9iK+pjaLKHnEICsHr8QeDJEV8vFnRnxbUjKeid3ZN4WcYkyS+lamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt5WybNRVsgp0NPkxqEF9TTF9yRWfkbqxpRK3xt41+M=;
 b=VX0OM81HaPOC5hVZlYG8JUQJn76ljebCtnikxi1CZnjhcGQmXJb6MlOFNvKtV30xD+SaLruRWqxbW1Zk6XFGYe7wXt8bG0qnYyvwHIf4LxVPMGDpmVRQhe7fgRbpTFyNh47WGOvvH5ffl2GjqawsK4e7xaDmRVpWbEmzgh/8+sA=
Received: from BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 15:00:43 +0000
Received: from BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::95a:91ab:e851:36aa]) by BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::95a:91ab:e851:36aa%7]) with mapi id 15.20.4649.018; Mon, 1 Nov 2021
 15:00:42 +0000
From: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix error handling on waiting for
 completion
Thread-Topic: [PATCH] drm/amd/display: Fix error handling on waiting for
 completion
Thread-Index: AQHXylnIMPhvZ4IkM0uuRCA4/ZrKQ6vlbdcAgAlex0I=
Date: Mon, 1 Nov 2021 15:00:42 +0000
Message-ID: <BN9PR12MB5145DB44B7D71979F8277C0BFF8A9@BN9PR12MB5145.namprd12.prod.outlook.com>
References: <20211026110740.152936-1-stylon.wang@amd.com>
 <0087f1c6-733e-4c31-63c5-c39da51138c1@daenzer.net>
In-Reply-To: <0087f1c6-733e-4c31-63c5-c39da51138c1@daenzer.net>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-01T15:00:42.832Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 1b300223-4998-47ce-799c-5dc172b2a979
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f8e4ba8-1d5c-440b-8a07-08d99d486058
x-ms-traffictypediagnostic: BN9PR12MB5066:
x-microsoft-antispam-prvs: <BN9PR12MB5066BDA68A7E69CF67482B03FF8A9@BN9PR12MB5066.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 850/M+9FoK4I3ATTN74TZFj4PD6/DbLYhMjcCOp5juHyw/MQR2ZSE9uZl91VfapQC2uHBUSE/2aHyQuzKjk2Kbr05QNdXRtILOEsQyMlmgpiZamaQ90I8KQCrya32cNLLTeEyY54JC+cIeKlm5sDirJqlQheZuBbTai6890ty16Pn7gWu40AeJvzzbFrRDtZ3s+c4IzJd8O2jRGduHBdTzIgUZAfDMGc982yF0IKWcw2VdVhqLtEdutcW5oTKoc2xH5ajrYeMxexECV+4W7yZg8wV6T/COxfrj87nNhy405SB3vNPeyS1k4RVeldhwK174R2Hof8Vv99wjXEW7sl0P7Q9E+8MIJMPpzLZT9A3x1xspBavBMpwUH9m+31se4ndSCLSEeV+WpE4e7BWMmHStR849giEdzbH9A69LtCuDGppVHrcQp1HcXgysDAyq9dW+WFwTMMicTjLR74pM3nwLRB3AVwvZV9tc/HCXflNSv5HwJ6S8fnwFDLYDqzrphsms88SIkYB8qVsFVArNbHVGDOcmueD4hmEMaq7kgj6lw0WeTvNayGYqnCBzCOXnhtA3AFL+gCr6aPawt4JDFXX6ymYm2B2ayVjjYxf+qGnUalgRHFVkRF17ar8YtgCnjMJFFnDRWRSwVoBQqNh3lcRTuDQuwW1eWVlPWLVjQAjhjKH6TsmyY+kcjmJQ1Wa9zIV6uhlzWHrZ2mZdV/mU8fNyjH6pFQSncdffX9u5BpuEIXwdHaModivZnhC24kl6RGPw4tCtPweV5DycsmHsQndlOXxAUmQRBFXz/99Emt5bsUbJzYTVx2oTJCFZ7PX3nceIU2x9rDYLWvF0v9y3b3pg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5145.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(38100700002)(2906002)(4001150100001)(7696005)(38070700005)(4326008)(55016002)(53546011)(6506007)(5660300002)(966005)(54906003)(508600001)(122000001)(83380400001)(66476007)(166002)(9686003)(71200400001)(86362001)(316002)(19627405001)(186003)(66946007)(110136005)(45080400002)(8936002)(33656002)(8676002)(52536014)(64756008)(66556008)(66446008)(76116006)(91956017)(66574015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pk6y3vAmdp1EbskDqyJioKAeCnD2fetSWiIp58Ubc+PdFU+R98ZwigvCFL?=
 =?iso-8859-1?Q?HNMuSf0TkWStJJO3Db/ZOkKD+uLROlwV3oxztTZcp7ZhgDvQLBu9fObhby?=
 =?iso-8859-1?Q?OZ0LGAlj3b2lxow5NefI7oZHNSkXdvDE1WQHpGVXjZTqdePlsK61QSLmYR?=
 =?iso-8859-1?Q?gCKitjcGJS+DB3PYNrbjglNE30T4JTgk7Bh6voXTWa0VdCWVdrDge+5yo8?=
 =?iso-8859-1?Q?03oNwa42JQKbA12w/751YVeBPRJ/f7HId+7o2beEWOvy46uv3VjOLMjknL?=
 =?iso-8859-1?Q?W75/fUmublwLnyDSAEjZEuhJnAYpHJgjeqSyPDZnrhLSOksHUxH09cxLLG?=
 =?iso-8859-1?Q?7rH4M9F/Aw+IuWog32CImGzMKKtgmNPcRKxHWZdf00tjxX4ft59B6zsn+V?=
 =?iso-8859-1?Q?unFWLEt8grrpaBsNnXGZNcLVHFpRalXKpqCAnNgowvRBNLEdLtzphxJQ5Q?=
 =?iso-8859-1?Q?vKqa9PSw4ox+zrTZzEwxQj1ukBQJXACtw7Bky/LvTEypYhBF5xvoegxS3r?=
 =?iso-8859-1?Q?IFesDyN6hxGKzTO7VT7si6HIBc0Fc9W1PNF3LfVAj8B+BXAGNC8DYlRXSf?=
 =?iso-8859-1?Q?Gt1GPNz+kDyhbHMrwJwYOXjOWnJXGWL5xACmXO6GpCBwfalm371Xk8kCCM?=
 =?iso-8859-1?Q?jbqQYZskSVWNmy1389vLAWSknh/+WGvl2z6UPxhzhW4Eli8LU9jmkwcEYi?=
 =?iso-8859-1?Q?HvBq46NU1OGd0c231SkQKzbVHM5gjXSjYVBab+yuNWh4bACoaNSvH2Kizu?=
 =?iso-8859-1?Q?2PeqlKeNUfHp/vozHgPN5mFj39siCdsaTOyoRRf7S8PRmSN7xSZ/pLQpkC?=
 =?iso-8859-1?Q?wFm4AAIUwSEGSMws73XjbDnSkKx+rP+No5OyX0NEnqnhR5zKeH+mcQFaQq?=
 =?iso-8859-1?Q?x5xgzxzGyE6A0lQPf2/Di++DWEWlphKUwHKbqGNXoWKHsDlJ1OJFtgRycg?=
 =?iso-8859-1?Q?H7Gijtkhxapyi0DnP9Ws+0RR3DHh+hqP7NheUs6E0AuQduSfFZQ5+MoGvc?=
 =?iso-8859-1?Q?xPE7/nIYRHRB37VW7jGWEWz3HkuKnCND4ANjivJBGC7a8jFvepLSx3c3qe?=
 =?iso-8859-1?Q?ETo3Qde/WwReauGXSxAhf/WbUsaPuBOH2Nz/i6igONU6T/1uyDsSNbICnN?=
 =?iso-8859-1?Q?CWPnJXMTzA8QbbWg7kRAscqAPDSnt1FYGFSRU7WLIY3PnDc8NhS+NUir8w?=
 =?iso-8859-1?Q?cQl67anrppTSIwI+2fCdLv9hdlBwg39S/hDyjxCStGfVE/lu33QDDtI5Y4?=
 =?iso-8859-1?Q?qU3yMOX1C0UdttR7AqL2DDst//anOKcuyU6xumJUrgvPrzj2i/2DI9n7/c?=
 =?iso-8859-1?Q?oV6CRZN4frBHqz87zrZ0dRHNOo/ebh+X1AIMenJPzN3rFZrp3cbfk0doia?=
 =?iso-8859-1?Q?ayXyIF0YSTQ5Qk+uP+FEElW7QhNPKE2b92CQqQ9yZJIxPl6NpbK30K5Kfs?=
 =?iso-8859-1?Q?df6MWCMDsAaphpHQb9M9OvXwCgZR4g6T12mJcC9kYUAn/kni2eOgMnem8E?=
 =?iso-8859-1?Q?YoYLIYhiUGLVd1LO0DHX//XTdEalvAnqrcoP9xQxJvhS09LhTt+JZC5QeZ?=
 =?iso-8859-1?Q?C422m0s4qTZ7J8uZ8Mwh4HAlZjQNwkWF/TP/zKZNnnAamqpUtCAPZ2rXHB?=
 =?iso-8859-1?Q?27SZLTUiupI2qTYIIVw0kaB4Pf4RSP571qxj8lC+zW3ONbrOesRIh4uvME?=
 =?iso-8859-1?Q?h9p1jbK4NJ1mVmYumrM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5145DB44B7D71979F8277C0BFF8A9BN9PR12MB5145namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5145.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8e4ba8-1d5c-440b-8a07-08d99d486058
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 15:00:42.7076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5YUg77koXpNamJ87CSVTEnX1YRPTfjkqXGL3XNNtgvT1EDS2eRiIyN+V9h4C1P/95wIU+KOa4EW7UfAPXUcyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "contact@emersion.fr" <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5145DB44B7D71979F8277C0BFF8A9BN9PR12MB5145namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Michel,

The problem with -ERESTARTSYS is the same half-baked atomic state with modi=
fications we made in the interrupted atomic check, is reused in the next re=
try and fails the atomic check. What we expect in the next retry is with th=
e original atomic state. I am going to dig deeper and see if at DRM side we=
 can go back to use to the original atomic state in the retry.


Regards

Stylon Wang

MTS Software Development Eng.  |  AMD
Display Solution Team

O +(886) 2-3789-3667 ext. 23667  C +(886) 921-897-142

---------------------------------------------------------------------------=
-------------------------------------------------------

6F, 3, YuanCyu St (NanKang Software Park) Taipei, Taiwan

Facebook<https://www.facebook.com/AMD> |  Twitter<https://twitter.com/AMD> =
|  amd.com<http://www.amd.com/>



________________________________
From: Michel D=E4nzer <michel@daenzer.net>
Sent: October 26, 2021 11:51 PM
To: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; amd-gfx@lists.freedeskto=
p.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrigo <Rodrigo.Si=
queira@amd.com>; contact@emersion.fr <contact@emersion.fr>; Kazlauskas, Nic=
holas <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix error handling on waiting for com=
pletion

On 2021-10-26 13:07, Stylon Wang wrote:
> [Why]
> In GNOME Settings->Display the switching from mirror mode to single displ=
ay
> occasionally causes wait_for_completion_interruptible_timeout() to return
> -ERESTARTSYS and fails atomic check.
>
> [How]
> Replace the call with wait_for_completion_timeout() since the waiting for
> hw_done and flip_done completion doesn't need to worry about interruption
> from signal.
>
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4cd64529b180..b8f4ff323de1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9844,10 +9844,10 @@ static int do_aquire_global_lock(struct drm_devic=
e *dev,
>                 * Make sure all pending HW programming completed and
>                 * page flips done
>                 */
> -             ret =3D wait_for_completion_interruptible_timeout(&commit->=
hw_done, 10*HZ);
> +             ret =3D wait_for_completion_timeout(&commit->hw_done, 10*HZ=
);
>
>                if (ret > 0)
> -                     ret =3D wait_for_completion_interruptible_timeout(
> +                     ret =3D wait_for_completion_timeout(
>                                        &commit->flip_done, 10*HZ);
>
>                if (ret =3D=3D 0)
>

The *_interruptible_* variant is needed so that the display manager process=
 can be killed while it's waiting here, which could take up to 10 seconds (=
per the timeout).

What's the problem with -ERESTARTSYS? Either the ioctl should be restarted =
automatically, or if it bounces back to user space, that needs to be able t=
o retry the ioctl while it returns -1 and errno =3D=3D EINTR. drmIoctl hand=
les this transparently.


--
Earthling Michel D=E4nzer            |                  https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
4%7C01%7Cstylon.wang%40amd.com%7C251ee7aba8574015713a08d998986a5f%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637708602663589383%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;sdata=3DLcSFyj%2FJ9VYbNfxJQRjpiRAcurbzTbD5yUVysxzpmXs%3D&amp;reserve=
d=3D0
Libre software enthusiast          |         Mesa and Xwayland developer

--_000_BN9PR12MB5145DB44B7D71979F8277C0BFF8A9BN9PR12MB5145namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Hi Michel,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
The problem with -ERESTARTSYS is the same half-baked atomic state with modi=
fications we made in the interrupted atomic check, is reused in the next re=
try and fails the atomic check. What we expect in the next retry is with th=
e original atomic state. I am going
 to dig deeper and see if at DRM side we can go back to use to the original=
 atomic state in the retry.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Regards</div>
<div id=3D"Signature">
<div>
<div></div>
<div></div>
<div></div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0px; margin-bottom:0px; margin-top:0; margin-bottom:=
0"></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><u><b>Stylon Wang</b></u></span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black">MTS Software Development Eng.&nbsp;&nbsp;|<b>&nbsp;&nbsp;AMD</b><=
br>
Display Solution Team</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><b style=3D"color:rgb(32,31,30); font-family:Calibri,sans-serif; =
font-size:14.6667px; background-color:rgb(255,255,255)"><span style=3D"marg=
in:0px; font-size:9pt; font-family:Arial,sans-serif; color:black">O</span><=
/b><span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; =
color:black; background-color:rgb(255,255,255)">&nbsp;+(886)
 2-3789-3667 ext. 23667&nbsp;&nbsp;<b>C</b>&nbsp;+(886) 921-897-142</span><=
br>
</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<b><span style=3D"margin:0px; font-size:9pt; color:rgb(242,101,34); letter-=
spacing:-1.4pt">-----------------------------------------------------------=
-----------------------------------------------------------------------</sp=
an></b><b><span style=3D"margin:0px; font-size:9pt; color:rgb(242,101,34)">=
</span></b></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><span tabindex=3D"0" style=3D"margin:0px; padding:1px 0px; border=
-width:0px 0px 1px; border-bottom-style:dashed">6F, 3, YuanCyu St (NanKang =
Software Park) Taipei, Taiwan</span></span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><a href=3D"https://www.facebook.com/AMD" target=3D"_blank" rel=3D=
"noopener noreferrer" style=3D"margin:0px"><span style=3D"margin:0px">Faceb=
ook</span></a>&nbsp;|&nbsp;&nbsp;<a href=3D"https://twitter.com/AMD" target=
=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin:0px"><span style=3D=
"margin:0px">Twitter</span></a>&nbsp;|&nbsp;&nbsp;<a href=3D"http://www.amd=
.com/" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin:0px"><=
span style=3D"margin:0px">amd.com</span></a></span><span style=3D"margin:0p=
x; font-size:10pt; font-family:Arial,sans-serif; color:black">&nbsp;</span>=
</p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
&nbsp;</p>
<p style=3D"margin-top:0px; margin-bottom:0px; margin-top:0; margin-bottom:=
0"></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michel D=E4nzer &lt;m=
ichel@daenzer.net&gt;<br>
<b>Sent:</b> October 26, 2021 11:51 PM<br>
<b>To:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; amd-gfx@lis=
ts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Siqueira, Rodrig=
o &lt;Rodrigo.Siqueira@amd.com&gt;; contact@emersion.fr &lt;contact@emersio=
n.fr&gt;; Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix error handling on waiting =
for completion</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2021-10-26 13:07, Stylon Wang wrote:<br>
&gt; [Why]<br>
&gt; In GNOME Settings-&gt;Display the switching from mirror mode to single=
 display<br>
&gt; occasionally causes wait_for_completion_interruptible_timeout() to ret=
urn<br>
&gt; -ERESTARTSYS and fails atomic check.<br>
&gt; <br>
&gt; [How]<br>
&gt; Replace the call with wait_for_completion_timeout() since the waiting =
for<br>
&gt; hw_done and flip_done completion doesn't need to worry about interrupt=
ion<br>
&gt; from signal.<br>
&gt; <br>
&gt; Signed-off-by: Stylon Wang &lt;stylon.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--<br>
&gt;&nbsp; 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 4cd64529b180..b8f4ff323de1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -9844,10 +9844,10 @@ static int do_aquire_global_lock(struct drm_de=
vice *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Make sure all pending HW programming completed =
and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * page flips done<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D wait_for_completion_interruptible_timeout(&amp;commit-&gt;hw_do=
ne, 10*HZ);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D wait_for_completion_timeout(&amp;commit-&gt;hw_done, 10*HZ);<br=
>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret &gt; 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D wait_for_comple=
tion_interruptible_timeout(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D wait_for_comple=
tion_timeout(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;commit-&gt;flip_done, 10*HZ);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0)<br>
&gt; <br>
<br>
The *_interruptible_* variant is needed so that the display manager process=
 can be killed while it's waiting here, which could take up to 10 seconds (=
per the timeout).<br>
<br>
What's the problem with -ERESTARTSYS? Either the ioctl should be restarted =
automatically, or if it bounces back to user space, that needs to be able t=
o retry the ioctl while it returns -1 and errno =3D=3D EINTR. drmIoctl hand=
les this transparently.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://nam11.safe=
links.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;amp;dat=
a=3D04%7C01%7Cstylon.wang%40amd.com%7C251ee7aba8574015713a08d998986a5f%7C3d=
d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637708602663589383%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C1000&amp;amp;sdata=3DLcSFyj%2FJ9VYbNfxJQRjpiRAcurbzTbD5yUVysxzpmXs%3D&am=
p;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.=
com%2F&amp;amp;data=3D04%7C01%7Cstylon.wang%40amd.com%7C251ee7aba8574015713=
a08d998986a5f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6377086026635893=
83%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DLcSFyj%2FJ9VYbNfxJQRjpiRAcurbzTbD=
5yUVysxzpmXs%3D&amp;amp;reserved=3D0</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and Xwayland de=
veloper<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5145DB44B7D71979F8277C0BFF8A9BN9PR12MB5145namp_--
