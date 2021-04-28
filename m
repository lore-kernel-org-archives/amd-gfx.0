Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E36C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 08:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D956141B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 08:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D956141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E17589F8E;
	Wed, 28 Apr 2021 08:32:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980E589F8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 08:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8/+P/109eTfUm8y+Qfk/WvJGXDS1wUmmujgOt8n7ustaLc15w9YGz/1I5iKhIlU+r+kiTysAwjnObkMSW9d5WbTndQb4LhWDTUfZxo8ajxMFguRblznawyjGmrJCSP0iXmP9IArOU/kBiF+7XKPK10Zpr2G8hPSWTlKCKK2G5YAzOPiEExZX3UqHRUJZ1a3DR2d1A/azzTAFKX0BlGVrcfMgwk3psgzqas7hu+wOFCEZDyqOClaR1xbZos5GCqLxVEgPm0BVJDoz7RkyI6M4Nk+ChGHRuwWAXGqYUngjsaClJl65vlvG/2o+ezjIdmMAMPD9/qAJh+Zb0iYA+q4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwLPP2oYdDETjJiU3+ragZsvaM6Hgb6aPZYB3/1/xNM=;
 b=J8UlqxygZDxwpCGYOZ1CmVyEJGX4GwBX2c5wuUWiK/WiA5g3d45bZmw0HtZVIqoOnn+rs4vkiNz+QtIhQ+LsY4CA/5KxI6NxDHrLPfDBtOPOg0dtxmbcTWOfhok9VTQGYGvWwP7w3cfRsbA6C+ybNjK8cfL6b/Hn0aM50HoWHANJygHzlpGZg33cjS1M1IutQr09lBBlygpQcokAEeebF/TG9L7KzUb9vWJgiahFNbTFseN0nNCWjxN7v8Klt4gm+5jkblPh5h2Ai0Y+BXS5RvQFDt5P/VuvOTdcxosA1JCBnQCZ8aW6hE79htdiNWVLWhMVA+Lqsvksld9A053I/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwLPP2oYdDETjJiU3+ragZsvaM6Hgb6aPZYB3/1/xNM=;
 b=SwcW4SXYf0v3Qg7K6Ps1nYAJ4MTOpiZHV3L5Pn2OB5V4GeQXrlcNSq2A0KBLlnS8jHZaUjdoGpt0nGG57/CutoeoSffJCldPxl7lW70dHoyu9pruz4cfoHRz+AH9DyO4WrrJ8qmN3U2GCPqwcdeyUz7Jd0GuxX0JUe+cbSTgkPA=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4803.namprd12.prod.outlook.com (2603:10b6:a03:1b0::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 08:32:21 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e%2]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 08:32:21 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Topic: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Index: AQHXOmUtl+qXW/2uo0uk6i4GpDgdCqrGW78AgADS6ACAAASOAIAAAiGAgAABC4CAAmZiAA==
Date: Wed, 28 Apr 2021 08:32:20 +0000
Message-ID: <BY5PR12MB41150F5816B764A3E619AB4F8F409@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
 <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
 <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <df0aa92d-87b9-7c27-f06f-9e1a10cead5d@gmail.com>
 <MN2PR12MB44880E0C0FA8C75D7E28884AF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44880E0C0FA8C75D7E28884AF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-26T19:51:45.324Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85b8cba9-b742-448d-b36a-08d90a20242c
x-ms-traffictypediagnostic: BY5PR12MB4803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB480331FA85B3E7C8340354018F409@BY5PR12MB4803.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yF6j3yKE58HB/XpPY77lRKZuAgvF5ZpKmvNxTCFdIhFDKc8FI/0acxxjogv41anI43+5hdsDxW+GvZBwCZA9KF5ow/Le6C0Y7VCa5cGlpiDJ4ndE2r2yRamCZK00tj4ua7GvNUurr1t4vd71LM7wjCKfCxK266sWz1INfU5EEBJZisQwV/DfyAlhipo7alyW0eUNtQtBTFBH9VTV7nhqNTDqqYuhAo6YFBUTgtSrDHUlf7RaV3dpGU9InSmlEYlqvDJx5bf9mLDshwWFWVaU7O5VTkFDWFj/fY3bGXJhcDbwA+cI+1lOGsEric9X9mqgvQCJaP2FzyoJ6P2D197wWPU0u9w9UuAJWhfTnE7HEOjmfkI/AopOl190GkNL17AN1NyfcTG8Thv93rmTo9wNlZZU7N1wTEs2UWiK7BIqgtCjzNdruOCc12+XhisPWNmMDfvzwJGX1O5xaGSoPvV9QmT37amR4LamHq6dZEw55SGA2fw1UVOyRnKhkavZxjBFrkAmXUlh4Vw9dMygcZ782XPWDUlOrkI6JInjZc/OxJ6DSFr5cHdpORPA7P5A3o96pHy4dOMpot2iKEsHAikAtTZBxgibLVWGg+W6vFu8TBk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(8936002)(6506007)(110136005)(53546011)(9686003)(52536014)(7696005)(186003)(54906003)(2906002)(8676002)(86362001)(64756008)(5660300002)(66446008)(26005)(66556008)(76116006)(66476007)(316002)(4326008)(66946007)(83380400001)(33656002)(122000001)(38100700002)(478600001)(66574015)(71200400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?QY94VGD8RGXyUFZHCdjUE6cS3SiCDP7Px+rviMmDVlsPi1FpGZvuPv+tbo?=
 =?iso-8859-1?Q?K0ttk8/LF4+u2kr0Rc6Z2HiGPEQdvcip0VqTmDYc7H1dCPVRVZ+mGvWO7G?=
 =?iso-8859-1?Q?lOIzNEL2FCPst5f1qNCiazhA5P17dxR0udWWKyCFleBWWMkuRFY5QvWDrI?=
 =?iso-8859-1?Q?SRK6CMK6JIyZtI6YGxaytaF5IPz02aiHY+n7q73LEGvRkiiEObZ2+w3GX4?=
 =?iso-8859-1?Q?3bJ7i7q0fp8D+vR+Z3Dh+q4oVBtCyLw++VPPgjaAfONkoHXH9Br7esfJf1?=
 =?iso-8859-1?Q?+krJtUd1RvbxpZyf100tgjTTHq+q4g0nO1nOoXJQ6odsjhIS09OxiyPFcT?=
 =?iso-8859-1?Q?b1wS4QfUBb54LFFwsvYfrfvs26D2H/NS2NMY07KVx5l6Nvqe/Z1YP3/wub?=
 =?iso-8859-1?Q?/9ZDWDT6IbOf1mlzGkJHA3zsScCEU3q6rWoYAL4nhnXFDNI2evYd+yPmWS?=
 =?iso-8859-1?Q?Rha8NwUJ2uQT/gM8UXH6o1IQXgSqlQfcx0GGeUyIrwwWeaaU0DNfsDHH9T?=
 =?iso-8859-1?Q?Sf4Kzlfas6gPpawx14Tn9BBU0ifJ+377vWzZ+pvNclhBf6FMPuY6lP45dy?=
 =?iso-8859-1?Q?8t/PMwK380IHsFmNwAnavYCEy/e0071CCYie27TMYbtDRkWk2TUgscrXPW?=
 =?iso-8859-1?Q?Cyf6AAwVoYKERJGk9+j5+//qibRXhVZXOoyTjovVxM2BKxx+5+6Ywe8bqY?=
 =?iso-8859-1?Q?wnv/2KVNIZ8DCUbDvnzKRI+sVo2cPBf1oWzV/ZbLZwDKp1alFOqS8siWpi?=
 =?iso-8859-1?Q?I6p2rvdPqb7iix+Ti3RZY0cA1xGmyoJXF/cAtX3hqMmR+7y+s40xmze2kH?=
 =?iso-8859-1?Q?OrqkzsY0OG6YPJhqxi49+X2k1cNYVJg8a4YYIkYhqDliQjanqlW2586lBE?=
 =?iso-8859-1?Q?v7I2hjrxhWyS4YqudVF/tf4pjhkgJtj6nNYm716A5VlMvjZ25YzYj//R87?=
 =?iso-8859-1?Q?OAVhfh2Msn+oDdbSFXB3cisfzgkS6o5/ycjJwWwsw5pTbtWr2rNgRZAQgb?=
 =?iso-8859-1?Q?b+bbXq3uVWVvgPuovZGAbwTvTqA1uqzYfvtUPKLaEjhKmmuusMKZ5wu5sj?=
 =?iso-8859-1?Q?4DC/2TKu+LNz/lY8ukUdcU72KypvzwT2z0pfnuTMfNqlVPi4fOS5miFbpL?=
 =?iso-8859-1?Q?UxodLBg30qOH0YvMPjCgpuh7TJU6aq+Dj09atOZkpryvqgt/ABnFkzH8A6?=
 =?iso-8859-1?Q?gb0Kd/6pbiQXDb9qWdlVO2DkVRB+8bcTtdKPVAAESpqKE4BNg0Ym9dvnIJ?=
 =?iso-8859-1?Q?n4ozD7AhcQiIBffqR6RJCIw3yQCwprcWhHB5rJ7tqwiQSBgF7Ez8x/AHN+?=
 =?iso-8859-1?Q?4BzjtERbYYwFOmtC6zdhAE4sSb5v2ITODfr92PsD52UKG5qmlNlnxHG+sl?=
 =?iso-8859-1?Q?HxVDRnWgH0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b8cba9-b742-448d-b36a-08d90a20242c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 08:32:20.9994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1+/cf3pIJ7yZWY/xdybWeYWypDOMhiDzjkZbuJremSDG4LqkweYE5Kfk5IFWCFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4803
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Sun, Roy" <Roy.Sun@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============0836995778=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0836995778==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB41150F5816B764A3E619AB4F8F409BY5PR12MB4115namp_"

--_000_BY5PR12MB41150F5816B764A3E619AB4F8F409BY5PR12MB4115namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Alex and Christian,
What extra work Roy need to do about this patch? And fdinfo?

Best wishes
Emily Deng
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Tuesday, April 27, 2021 3:52 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Cc: Sun, Roy <Roy.Sun@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org=
>; Nieto, David M <David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

Fair point.  Either way works for me.

Alex
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Sent: Monday, April 26, 2021 3:48 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freede=
sktop.org>>; Sun, Roy <Roy.Sun@amd.com<mailto:Roy.Sun@amd.com>>; Nieto, Dav=
id M <David.Nieto@amd.com<mailto:David.Nieto@amd.com>>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track

My concern is more to get this tested from more people than just AMD.

Christian.
Am 26.04.21 um 21:40 schrieb Deucher, Alexander:

[AMD Official Use Only - Internal Distribution Only]

That said, it would be easier for me to merge through the AMD tree since a =
relatively big AMD feature depends on it.  Not sure how much conflict poten=
tial there is if this goes through the AMD tree.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com><mailto:Alexander.Deucher@amd.com>
Sent: Monday, April 26, 2021 3:24 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.lei=
chtzumerken@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freed=
esktop.org>; Sun, Roy <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>; Nieto, Dav=
id M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

No objections from me.

Thanks!

Alex

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Monday, April 26, 2021 2:49 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher=
@amd.com>
Cc: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>; Sun, =
Roy <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>; amd-gfx list <amd-gfx@lists.=
freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track

Hey Alex,

any objections that we merge those two patches through drm-misc-next?

Thanks,
Christian.

Am 26.04.21 um 08:27 schrieb Roy Sun:
> Update the timestamp of scheduled fence on HW
> completion of the previous fences
>
> This allow more accurate tracking of the fence
> execution in HW
>
> Signed-off-by: David M Nieto <david.nieto@amd.com><mailto:david.nieto@amd=
.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 92d8de24d0a1..f8e39ab0c41b 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler=
 *sched)
>   EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>
>   /**
> - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of job=
s from mirror ring list
> + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of jo=
bs from pending list
>    *
>    * @sched: scheduler instance
>    * @max: job numbers to relaunch
> @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sch=
ed)
>   static struct drm_sched_job *
>   drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   {
> -     struct drm_sched_job *job;
> +     struct drm_sched_job *job, *next;
>
>        /*
>         * Don't destroy jobs while the timeout worker is running  OR thre=
ad
> @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *=
sched)
>        if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>                /* remove job from pending_list */
>                list_del_init(&job->list);
> We just need to record the scheduled time of the next job. So we
> need not to check the rest job.
> +             /* account for the next fence in the queue */
> +             next =3D list_first_entry_or_null(&sched->pending_list,
> +                             struct drm_sched_job, list);
> +             if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> +                     &job->s_fence->finished.flags)) {
> +                     next->s_fence->scheduled.timestamp =3D
> +                             job->s_fence->finished.timestamp;
> +             }
>        } else {
>                job =3D NULL;
>                /* queue timeout for next job */


--_000_BY5PR12MB41150F5816B764A3E619AB4F8F409BY5PR12MB4115namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Alex and Christian,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.0pt">What extra work Roy nee=
d to do about this patch? And fdinfo?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best wishes<o:p></o:p></p>
<p class=3D"MsoNormal">Emily Deng<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Tuesday, April 27, 2021 3:52 AM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Cc:</b> Sun, Roy &lt;Roy.Sun@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists=
.freedesktop.org&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Fair po=
int.&nbsp; Either way works for me.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Sent:</b> Monday, April 26, 2021 3:48 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Cc:</b> amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;; Sun, Roy &lt;<a href=3D"mailto:Roy=
.Sun@amd.com">Roy.Sun@amd.com</a>&gt;; Nieto, David M &lt;<a href=3D"mailto=
:David.Nieto@amd.com">David.Nieto@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">My concern is more to=
 get this tested from more people than just AMD.<br>
<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 26.04.21 um 21:40 schrieb Deucher, Alexander:<o:p=
></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">That sa=
id, it would be easier for me to merge through the AMD tree since a relativ=
ely big AMD feature depends on it.&nbsp; Not sure how much conflict potenti=
al there is if this goes through the AMD
 tree.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx
<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt;</a> on behalf of Deucher, Alexander
<a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&=
gt;</a><br>
<b>Sent:</b> Monday, April 26, 2021 3:24 PM<br>
<b>To:</b> Christian K=F6nig <a href=3D"mailto:ckoenig.leichtzumerken@gmail=
.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Cc:</b> amd-gfx list <a href=3D"mailto:amd-gfx@lists.freedesktop.org">&l=
t;amd-gfx@lists.freedesktop.org&gt;</a>; Sun, Roy
<a href=3D"mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a>; Nieto, Davi=
d M <a href=3D"mailto:David.Nieto@amd.com">
&lt;David.Nieto@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">No obje=
ctions from me.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks!=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig
<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumer=
ken@gmail.com&gt;</a><br>
<b>Sent:</b> Monday, April 26, 2021 2:49 AM<br>
<b>To:</b> Deucher, Alexander <a href=3D"mailto:Alexander.Deucher@amd.com">=
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Cc:</b> Nieto, David M <a href=3D"mailto:David.Nieto@amd.com">&lt;David.=
Nieto@amd.com&gt;</a>; Sun, Roy
<a href=3D"mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a>; amd-gfx lis=
t <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hey Alex,<br>
<br>
any objections that we merge those two patches through drm-misc-next?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.04.21 um 08:27 schrieb Roy Sun:<br>
&gt; Update the timestamp of scheduled fence on HW<br>
&gt; completion of the previous fences<br>
&gt;<br>
&gt; This allow more accurate tracking of the fence<br>
&gt; execution in HW<br>
&gt;<br>
&gt; Signed-off-by: David M Nieto <a href=3D"mailto:david.nieto@amd.com">&l=
t;david.nieto@amd.com&gt;</a><br>
&gt; Signed-off-by: Roy Sun <a href=3D"mailto:Roy.Sun@amd.com">&lt;Roy.Sun@=
amd.com&gt;</a><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--<b=
r>
&gt;&nbsp;&nbsp; 1 file changed, 10 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c<br>
&gt; index 92d8de24d0a1..f8e39ab0c41b 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_schedu=
ler *sched)<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of =
jobs from mirror ring list<br>
&gt; + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of=
 jobs from pending list<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @sched: scheduler instance<br>
&gt;&nbsp;&nbsp;&nbsp; * @max: job numbers to relaunch<br>
&gt; @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *=
sched)<br>
&gt;&nbsp;&nbsp; static struct drm_sched_job *<br>
&gt;&nbsp;&nbsp; drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)=
<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job, *next;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Don't destroy jobs w=
hile the timeout worker is running&nbsp; OR thread<br>
&gt; @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_schedule=
r *sched)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job &amp;&amp; dma_fence=
_is_signaled(&amp;job-&gt;s_fence-&gt;finished)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* remove job from pending_list */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; list_del_init(&amp;job-&gt;list);<br>
&gt; We just need to record the scheduled time of the next job. So we<br>
&gt; need not to check the rest job.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* account for the next fence in the queue */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; next =3D list_first_entry_or_null(&amp;sched-&gt;pending_list,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (next &amp;&amp; test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;job-&gt;s_fence-&g=
t;finished.flags)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next-&gt;s_fence-&gt;sc=
heduled.timestamp =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;s_fence-&gt;finished.timestamp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; job =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* queue timeout for next job */<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB41150F5816B764A3E619AB4F8F409BY5PR12MB4115namp_--

--===============0836995778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0836995778==--
