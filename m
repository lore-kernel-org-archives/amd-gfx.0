Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A1C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227E2611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227E2611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C09B6ECC5;
	Wed, 19 May 2021 02:55:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7956ECC5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 02:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkipapxncTRP/5VrAcp0TYEcQ+PaPCvXJTsjL0IgZgFak5M24TtdpPUw31D+l5X3r5STaUAfdc6ZnUfayJFDELWURUw1l/P9ZtYxC0ZSDQx/q3cgRes8M1orQquGj1DUyvGMoYqn9PI29WXOZwM5jgyvFUa3sbrL7KN9Rf021tkmJYN54jfa3tAm99Xnn4m0mP72/r+yZX+qWDlBeBcDmGpldgilvVHqF8YDaHbUJ+cn5ZaCFXq8I4zvWEeRweZxO2Ex3VL3lJr3mfBalFWB5zPRcWd105A482L5sYyVshpDN3Ta0HKeCdqRfxEHL3f03JrsDa8QskAaYu5k6DCG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgtqDZkhhn6u1Iyc0wx4N9P49EAjcigz+VeCNKFcGQE=;
 b=YCJIcWVDj1IXvMQuFHTAo4TFCB7NeBh+mBuEsO0j57Y5UZJZ+12mdvaqpW0R5DSujZ3X0pRDNQzufCXTAmDal5MWRY+GbQ6T6GgYzka7Xxdi0PfeAKr68MxEGU2M7IuOiipKujEYn5A9nzqbQHUNcZz4GoS0b0mWWgcHUEmKj2kjX48JBsdLVmEG1EiUqkMFY5CmbkjPuG2+8wdHJ1PbEvqOuc9SFjt5jbmlfmZPhrOt4s01qz5WgSmu2C0CN/Es0SWQ+MbDtcOeM/QMVFxAeqRcIsHYeCbt6nqkT21DQlCwKYrdi4qGxnkTPkIESrDTOhqNEXqVxghl+agkM9gc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgtqDZkhhn6u1Iyc0wx4N9P49EAjcigz+VeCNKFcGQE=;
 b=SFwEjIpB8PlmU3eotNe8QvfXPSEv08t1sqxzDTn9jEwIN0cyFk9c0Jz5QiDklkGqftXpmnQ0OGal8RlvoaUVeKiNVfmP8us2Iwgvyj5tT1GszEp2S0zphS1isr6EBtIk+LRQBpM+kjhmSzgRp6cV5XWDDmWF4QpY9aD5fAwbT7w=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 02:55:43 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 02:55:43 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Topic: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Index: AQHXSJn3h1m5Loi44kKsLBABvU+6i6rjBYuAgAQ0pgCAAAnH8IAC1bgAgAABwPCAAAdygIAAAIwg
Date: Wed, 19 May 2021 02:55:42 +0000
Message-ID: <MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
 <20210517062724.GA1853590@hr-amd>
 <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <CADnq5_OmpYjzaeGPUC4rUNkSo_CP+8zFfZQsF6d+2fLegtxUkQ@mail.gmail.com>,
 <MW2PR12MB46840D259987CA9265317F75FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <MN2PR12MB448807A739B82ED7721E4A5EF72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448807A739B82ED7721E4A5EF72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-19T02:52:44.691Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86a7fa30-97eb-41e9-8357-08d91a7197e7
x-ms-traffictypediagnostic: MW3PR12MB4555:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB455515FB11A9A0E1A78377A2FD2B9@MW3PR12MB4555.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9g49EqY0VRrNy+uQNm+HvhWM7ofkMPuAP8VTZYGsfPZCe6EC/rgxCk8suZke+As/YeB2HmP6mWGw6Vg7aR2pxXd2YNrgViT/QpwuIZg3svJN70MjfLW3LUNgp+DN4PwBIql6iLTbtk/ybeK1V737kn2pG8Spd0WxZpETmPVksazbQV+ZdVvK+ZnGGkWl1UfPim5ALmUsClN0Hy1Hrpxr/NQFwSEtpguivnkYXs0k5/1jC4p6wIuKavvz9iy39xNS/aJR9k0fsgyYagcyZjzoyo0zbSL+MLLAXAO3a2jfrtbQw8H+XGuQ/ec0hkPaT9LQMK53Ard0qC/BTaXyygcRdJBT9W9aeDD+vkf9E7E144lgvIiJ93nMx1MgN3XdzpvF0RvAKxoUlxQuEk+5vM61rvq3MpoRPK3x+ae0oXcTZx9h/Z3mPP6sVJ06YKHKaLlCo2AYizaDJfqkad+1WOXQ0noeeY/dIHwNaXrWHR+0b8sgb6Jgyl98Z716TCuabbjVOt+wN/DFdKS5fOP8aXkVbeW/pAYhfI0syiyKiJ+J086sGkx9uIY7D6bxfFJK9Ul5soKBNrq032GmSEx0lY7jNjykAxlqMc9MGFoepyiTQke7urwIGyUtZrIX3JCXDQPQXU/82am9lBOUDerLnTzuaf4zbSE+aV8nmYsunJrIOiPuI5B5WhMfdiviCg96dEl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(376002)(366004)(346002)(136003)(2906002)(9686003)(38100700002)(66946007)(86362001)(166002)(26005)(66556008)(45080400002)(122000001)(54906003)(52536014)(5660300002)(66476007)(110136005)(316002)(966005)(8676002)(71200400001)(33656002)(6506007)(53546011)(478600001)(7696005)(55016002)(8936002)(66446008)(6636002)(64756008)(76116006)(4326008)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FS8YpHHTYl+M5AzyYDWqhHVb4L/YUgBXBFrb1JxZZwsrtbLPPDC21fqbzs17?=
 =?us-ascii?Q?iWzqBplZBmdPDRCacwBGxesN1bZXlTQhebvmyiwqzhKBHZUllMn6wFTevrGM?=
 =?us-ascii?Q?DU0xMqQHlSjgLrst8KJ7yRZKWA9sXx/Qd4aGXUsBOMBV1Dzj/xIy0HW32BCY?=
 =?us-ascii?Q?OicvLVF/3WHL9eyQmsiHi4KktVqafTd4ck9OlkF0yJI8O1JR5CwCMUdnbJd7?=
 =?us-ascii?Q?RlzkMp1G8gxm4usUUR+FWPX0ygkkF8PnwEo2/yoTLAKdVjm90u5hqcKsNF2S?=
 =?us-ascii?Q?WgXYNi3Os1yhJQDqoCTjVCtXtrXGWn/vMZZ7M5uHeU5nLWhvSPCXXyF6mdLM?=
 =?us-ascii?Q?K+Fzvb8yTNTouwEz+QgGtO3x/lAs9u6TbxcIBw9FnKsWc9ELBMsdr30ZO4tt?=
 =?us-ascii?Q?smcA2Rttu2BmxYp50wcoYLWQJoU12/ohbmbKj26nVl2wH9tmBIUEY3zKCr/o?=
 =?us-ascii?Q?te2USQ3YN6wtHpAqx7THb2cIgGkDKopEkMzZuLm0P2g7nNQmJrbSja5s9AyB?=
 =?us-ascii?Q?8PwbsdpyCleHMQ1Wcm9tyOOMvuorxX4wf4pB+F1/J2PvkiTmxlmk0DIsAlNF?=
 =?us-ascii?Q?umjQm0DRu7U99EwmdUg6J+WNyqjSdRXRhabVgCMHwMa4kCea8+kEBcPS9tQA?=
 =?us-ascii?Q?tCffXrppfLxA7r7safSCnMHo/0kK+iImNYDrBNlKGauEqcVv7LAuFSSGKdLM?=
 =?us-ascii?Q?JRPkopHAsj3BDWKn/PMp2x4Bm6vAS8qvKeUTJP4x4dFWsE8a17UXmsRTsnUZ?=
 =?us-ascii?Q?hoiYKf//cB01d+szFyMIu+Z7s1lRzRXBrnNbaCicz92BbId8AYdaz2vQYLgH?=
 =?us-ascii?Q?I13BNvnHo+MFQIM/OSJ++5JfF9dh9QXetA+7HnEYUsfEfen70TMfk6vePSlp?=
 =?us-ascii?Q?ChC4Wgv5etdPIi7p+j6HeYD9xzGFQVosw//oVp6RdeA4wgKPUsPziQR/+olR?=
 =?us-ascii?Q?JLCj53Hp+S/oMYsaltHVs9yyt4KO+8HJ1nzVxnS+1XczNev+XC6ZDgjND+x7?=
 =?us-ascii?Q?3u7v262zfZ7BC+3L431Xvy67DmlwoHQbxUTtamDJkGperc+eOO8uMeLjgDaw?=
 =?us-ascii?Q?q7xbqgbXQs+i2XXMV6td4Rhf37Ettw3Atd335+dkj7j74vpgmWf+q9Ba54GB?=
 =?us-ascii?Q?Fql+zHqnoqkQ1ZAc/QfOPpeONIfql4BAaq8qduPLXrduHAmxzg4sZfB1MhYe?=
 =?us-ascii?Q?qvPLPZmtzMJwX8B+MVl85iADHIq/801dvdGLdcBR9lpzpybhhBxYMMShI8NA?=
 =?us-ascii?Q?cizWvN5tkYnI/jY+x0BQ8ihzsAzu5xxL7dsT5JOmb+HV+7V2RlsMpN8ZPmIA?=
 =?us-ascii?Q?BiXALtYsMWt+U8slikGhQSS1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a7fa30-97eb-41e9-8357-08d91a7197e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 02:55:42.9785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9i+ixEVmzS5BmbGIoHeJLlGuvFCMUn0SjRjBrL6CAOHNJpU0fqZMvuBKYSNLUcBSddxm35kUv9sX07YrWgMUyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1814472293=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1814472293==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9MW2PR12MB4684namp_"

--_000_MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9MW2PR12MB4684namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Alex,

This is the issue exposed by Nirmoy's patch that provided better load balan=
cing across queues.

BR,
Changfeng.

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, May 19, 2021 10:53 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; Alex Deucher <alexdeucher@gmail=
.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang


[Public]

+ Nirmoy

I thought we disabled all but one of the compute queues on raven due to thi=
s issue.  Maybe that patch never landed?  Wasn't this the same issue that w=
as exposed by Nirmoy's patch that provided better load balancing across que=
ues?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zhu, Changfeng <Changfeng.Zhu@amd.com=
<mailto:Changfeng.Zhu@amd.com>>
Sent: Tuesday, May 18, 2021 10:28 PM
To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>
Cc: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; amd-gfx list =
<amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang

[AMD Official Use Only - Internal Distribution Only]

Hi Alex.

I have submitted the patch: drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang

Do you mean we have something else to do for re-enabling the extra compute =
queues?

BR,
Changfeng.

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>
Sent: Wednesday, May 19, 2021 10:20 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
Cc: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; amd-gfx list =
<amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang

Care to submit a patch to re-enable the extra compute queues?

Alex

On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng <Changfeng.Zhu@amd.com<mailt=
o:Changfeng.Zhu@amd.com>> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Ray and Alex,
>
> I have confirmed it can enable the additional compute queues with this pa=
tch:
>
> [   41.823013] This is ring mec 1, pipe 0, queue 0, value 1
> [   41.823028] This is ring mec 1, pipe 1, queue 0, value 1
> [   41.823042] This is ring mec 1, pipe 2, queue 0, value 1
> [   41.823057] This is ring mec 1, pipe 3, queue 0, value 1
> [   41.823071] This is ring mec 1, pipe 0, queue 1, value 1
> [   41.823086] This is ring mec 1, pipe 1, queue 1, value 1
> [   41.823101] This is ring mec 1, pipe 2, queue 1, value 1
> [   41.823115] This is ring mec 1, pipe 3, queue 1, value 1
>
> BR,
> Changfeng.
>
>
> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>
> Sent: Monday, May 17, 2021 2:27 PM
> To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; Z=
hu, Changfeng
> <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.free=
desktop.org>>
> Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to
> avoid compute hang
>
> On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:
> > On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com<mailto:changfeng=
.zhu@amd.com>> wrote:
> > >
> > > From: changzhu <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
> > >
> > > From: Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
> > >
> > > There is problem with 3DCGCG firmware and it will cause compute
> > > test hang on picasso/raven1. It needs to disable 3DCGCG in driver
> > > to avoid compute hang.
> > >
> > > Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> > > Signed-off-by: Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@=
amd.com>>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.d=
eucher@amd.com>>
> >
> > WIth this applied, can we re-enable the additional compute queues?
> >
>
> I think so.
>
> Changfeng, could you please confirm this on all raven series?
>
> Patch is Reviewed-by: Huang Rui <ray.huang@amd.com<mailto:ray.huang@amd.c=
om>>
>
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
> > >  drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > index 22608c45f07c..feaa5e4a5538 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_gating(str=
uct amdgpu_device *adev,
> > >         amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >
> > >         /* Enable 3D CGCG/CGLS */
> > > -       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) =
{
> > > +       if (enable) {
> > >                 /* write cmd to clear cgcg/cgls ov */
> > >                 def =3D data =3D RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_=
OVERRIDE);
> > >                 /* unset CGCG override */ @@ -4959,8 +4959,12 @@
> > > static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *ade=
v,
> > >                 /* enable 3Dcgcg FSM(0x0000363f) */
> > >                 def =3D RREG32_SOC15(GC, 0,
> > > mmRLC_CGCG_CGLS_CTRL_3D);
> > >
> > > -               data =3D (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDL=
E_THRESHOLD__SHIFT) |
> > > -                       RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > +               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> > > +                       data =3D (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG=
_GFX_IDLE_THRESHOLD__SHIFT) |
> > > +                               RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > +               else
> > > +                       data =3D 0x0 <<
> > > + RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
> > > +
> > >                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
> > >                         data |=3D (0x000F << RLC_CGCG_CGLS_CTRL_3D__C=
GLS_REP_COMPANSAT_DELAY__SHIFT) |
> > >
> > > RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > index 4b660b2d1c22..080e715799d4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void *handle=
)
> > >                         adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
> > >                                 AMD_CG_SUPPORT_GFX_MGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_CGLS | @@
> > > -1413,7
> > > +1412,6 @@ static int soc15_common_early_init(void *handle)
> > >                                 AMD_CG_SUPPORT_GFX_MGLS |
> > >                                 AMD_CG_SUPPORT_GFX_RLC_LS |
> > >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_CGLS |
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > li
> > > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C0
> > > 1%
> > > 7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3dd8961
> > > fe
> > > 4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnknown%7CT
> > > WF
> > > pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> > > CI
> > > 6Mn0%3D%7C1000&amp;sdata=3DlBzswAPBguL0mWFglEk%2Bg2eDCEuhir7JfFjov%2
> > > BV
> > > 7pSY%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C6d2cfe6e59f54875f6fa08d91a6dd27f%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637569881259273626%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D33Is2P3sqdabI7PPuHFOmzuvXyFId%2BOTAMyJ8G5PhzI%3D&amp;reserved=3D0

--_000_MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9MW2PR12MB4684namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is the issue exposed by <span style=3D"font-siz=
e:12.0pt;color:black">
Nirmoy's patch that provided better load balancing across queues.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">BR,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Changfe=
ng.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Wednesday, May 19, 2021 10:53 AM<br>
<b>To:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;; Alex Deucher &lt;a=
lexdeucher@gmail.com&gt;; Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx list &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">+ Nirmo=
y<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I thoug=
ht we disabled all but one of the compute queues on raven due to this issue=
.&nbsp; Maybe that patch never landed?&nbsp; Wasn't this the same issue tha=
t was exposed by Nirmoy's patch that provided
 better load balancing across queues?<o:p></o:p></span></p>
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
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Zhu=
@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, May 18, 2021 10:28 PM<br>
<b>To:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;<br>
<b>Cc:</b> Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop=
.org">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
Hi Alex.<br>
<br>
I have submitted the patch: drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang<br>
<br>
Do you mean we have something else to do for re-enabling the extra compute =
queues?<br>
<br>
BR,<br>
Changfeng.<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher=
@gmail.com</a>&gt;
<br>
Sent: Wednesday, May 19, 2021 10:20 AM<br>
To: Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Z=
hu@amd.com</a>&gt;<br>
Cc: Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@amd.com</=
a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">a=
md-gfx@lists.freedesktop.org</a>&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang<br>
<br>
Care to submit a patch to re-enable the extra compute queues?<br>
<br>
Alex<br>
<br>
On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng &lt;<a href=3D"mailto:Changf=
eng.Zhu@amd.com">Changfeng.Zhu@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;<br>
&gt; Hi Ray and Alex,<br>
&gt;<br>
&gt; I have confirmed it can enable the additional compute queues with this=
 patch:<br>
&gt;<br>
&gt; [&nbsp;&nbsp; 41.823013] This is ring mec 1, pipe 0, queue 0, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823028] This is ring mec 1, pipe 1, queue 0, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823042] This is ring mec 1, pipe 2, queue 0, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823057] This is ring mec 1, pipe 3, queue 0, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823071] This is ring mec 1, pipe 0, queue 1, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823086] This is ring mec 1, pipe 1, queue 1, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823101] This is ring mec 1, pipe 2, queue 1, value 1<=
br>
&gt; [&nbsp;&nbsp; 41.823115] This is ring mec 1, pipe 3, queue 1, value 1<=
br>
&gt;<br>
&gt; BR,<br>
&gt; Changfeng.<br>
&gt;<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;<br>
&gt; Sent: Monday, May 17, 2021 2:27 PM<br>
&gt; To: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeuc=
her@gmail.com</a>&gt;; Zhu, Changfeng
<br>
&gt; &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Zhu@amd.com</a>=
&gt;<br>
&gt; Cc: amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">=
amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to <=
br>
&gt; avoid compute hang<br>
&gt;<br>
&gt; On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:<br>
&gt; &gt; On Fri, May 14, 2021 at 4:20 AM &lt;<a href=3D"mailto:changfeng.z=
hu@amd.com">changfeng.zhu@amd.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: changzhu &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">=
Changfeng.Zhu@amd.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com"=
>Changfeng.Zhu@amd.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There is problem with 3DCGCG firmware and it will cause comp=
ute <br>
&gt; &gt; &gt; test hang on picasso/raven1. It needs to disable 3DCGCG in d=
river <br>
&gt; &gt; &gt; to avoid compute hang.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87<br>
&gt; &gt; &gt; Signed-off-by: Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu=
@amd.com">Changfeng.Zhu@amd.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher=
@amd.com">alexander.deucher@amd.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; WIth this applied, can we re-enable the additional compute queues=
?<br>
&gt; &gt;<br>
&gt;<br>
&gt; I think so.<br>
&gt;<br>
&gt; Changfeng, could you please confirm this on all raven series?<br>
&gt;<br>
&gt; Patch is Reviewed-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.co=
m">ray.huang@amd.com</a>&gt;<br>
&gt;<br>
&gt; &gt; Alex<br>
&gt; &gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---<=
br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp; |=
&nbsp; 2 --<br>
&gt; &gt; &gt;&nbsp; 2 files changed, 7 insertions(+), 5 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &gt; index 22608c45f07c..feaa5e4a5538 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &gt; @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_g=
ating(struct amdgpu_device *adev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_r=
lc_enter_safe_mode(adev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable 3D=
 CGCG/CGLS */<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; =
(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_3D_CGCG)) {<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write cmd to clear cgcg/cgls ov */<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC15(GC, 0, mm=
RLC_CGTT_MGCG_OVERRIDE);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unset CGCG override */ @@ -4959,8 +4=
959,12 @@ <br>
&gt; &gt; &gt; static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_de=
vice *adev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable 3Dcgcg FSM(0x0000363f) */<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D RREG32_SOC15(GC, 0, <br>
&gt; &gt; &gt; mmRLC_CGCG_CGLS_CTRL_3D);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; data =3D (0x36 &lt;&lt; RLC_CGCG_CGLS_CTRL_3D__CG=
CG_GFX_IDLE_THRESHOLD__SHIFT) |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
LC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_3D=
_CGCG)<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ata =3D (0x36 &lt;&lt; RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIF=
T) |<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RLC_CGCG_CGLS_CTRL_3D__CGCG_=
EN_MASK;<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ata =3D 0x0 &lt;&lt; <br>
&gt; &gt; &gt; + RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SUPP=
ORT_GFX_3D_CGLS)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; data |=3D (0x000F &lt;&lt; RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANS=
AT_DELAY__SHIFT) |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; &gt; &gt; RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &gt; &gt; index 4b660b2d1c22..080e715799d4 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &gt; &gt; @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(voi=
d *handle)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_MGLS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CP_LS |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX_3D_CGCG |=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_3D_CGLS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CGCG |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CGLS | @@ <br>
&gt; &gt; &gt; -1413,7<br>
&gt; &gt; &gt; +1412,6 @@ static int soc15_common_early_init(void *handle)<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_MGLS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_RLC_LS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CP_LS |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX_3D_CGCG |=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_3D_CGLS |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CGCG |<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_GFX=
_CGLS |<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.17.1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; amd-gfx mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lis=
ts.freedesktop.org</a><br>
&gt; &gt; &gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?u=
rl=3Dhttps%3A%2F%2F">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F</a><br=
>
&gt; &gt; &gt; li <br>
&gt; &gt; &gt; sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;d=
ata=3D04%7C0<br>
&gt; &gt; &gt; 1% <br>
&gt; &gt; &gt; 7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3=
dd8961<br>
&gt; &gt; &gt; fe <br>
&gt; &gt; &gt; 4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnkno=
wn%7CT<br>
&gt; &gt; &gt; WF <br>
&gt; &gt; &gt; pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXV<br>
&gt; &gt; &gt; CI <br>
&gt; &gt; &gt; 6Mn0%3D%7C1000&amp;amp;sdata=3DlBzswAPBguL0mWFglEk%2Bg2eDCEu=
hir7JfFjov%2<br>
&gt; &gt; &gt; BV<br>
&gt; &gt; &gt; 7pSY%3D&amp;amp;reserved=3D0<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C6d2cfe6e59f54875f6fa08d91a6dd27f%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569881259273626%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D33Is2P3sqdabI7PPuHFOmzuvXyFId%2BOTAMyJ8G5PhzI%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C6d2cfe6e59f54875f6fa08d91a6dd2=
7f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569881259273626%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3D33Is2P3sqdabI7PPuHFOmzuvXyFId%2BOTAMyJ8G5Phz=
I%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9MW2PR12MB4684namp_--

--===============1814472293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1814472293==--
