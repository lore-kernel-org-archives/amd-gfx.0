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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E738C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3F8611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3F8611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703446ECB6;
	Wed, 19 May 2021 02:52:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D8D6ECB6
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 02:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq0rEan5fQ7+VRWLcnrdKcdTKt0fskYTYFGAE6v69UdLgxySoueNd9/IPFe7hgYYT4d/PhdM3wORuvOgLJLUR388HENe7u1yJMp3n4Pa+3t8H+yk6JMyrjpOHBcMqi3WfyCAGZEYWCkLe5JMxs6SCQnINUN5UzXzHJgg5w3kfMQWqpY8kYHixPgVfdRB56xTesHNNRA7EinWGu2hAAE8KmUA+xMgHInaxgXVVFeCgi0UjkP/b18lqnaKqBtMcYrGrXpdUa64h6R07ojB64K2bOTtdc1ndSftChJ0/9d1LHARf//+y28U374CuyTeRZ3r5uUMh5xob73zEu03AgjqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ODwh2Jz/GtlVQfgYPsSaKZaQGN8EWv+NceRxnxxcaM=;
 b=oSnWsOlB3vmyoJX/jyN+nRgBwUym7xG7FH38PRw1y/zQHxYmWzELoG82PGdrkpx+KhUzCX9Ww2NDRUsgYJFtqUU28TBAeqgjE2he4+6RIPSUuHPhZVa5O/kspzvWLM2qk+TuwDuAB6ZaiChhkplkF32e9xjm4zAOfXRwfyV6etivssq6UImFQnb/SlFcn7nc+tepNw9rm0EabOlvTwb2xWsudg6GMnT+XtN5/er/hs+vdUjLD6n5NiHsK/adx7G/rDoK3mlF6/q6G+mEyi+MPhiy3a0DlBkgg4rUd/QXd8NwhZ+ueTg7d6R1TEXhRhtrug2g/Zndu7SI4P0tttVCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ODwh2Jz/GtlVQfgYPsSaKZaQGN8EWv+NceRxnxxcaM=;
 b=eyD6jzYqi5gFnQCwSUooJXIYspAhK+uN6Nn2abhm0FZOdR8oQvvFN6DF+2bQ5kG7UnWDDErvZPuz3kHx60nw8prcOS7VpTQfGlNzAYpFHAfDV2S5aPsJPdGSejqlrV2lkxVn/oSQRYS7xWWRzRjlWmpXirQkb+MkywggG1JUQL0=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3984.namprd12.prod.outlook.com (2603:10b6:208:16f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 02:52:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 02:52:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Topic: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Index: AQHXSJn7ZKzTtOpbdU+CrPUZHuAuKqrjBYuAgAQ0pgCAABx1gIACwwoAgAACdICAAAYZcw==
Date: Wed, 19 May 2021 02:52:45 +0000
Message-ID: <MN2PR12MB448807A739B82ED7721E4A5EF72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
 <20210517062724.GA1853590@hr-amd>
 <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <CADnq5_OmpYjzaeGPUC4rUNkSo_CP+8zFfZQsF6d+2fLegtxUkQ@mail.gmail.com>,
 <MW2PR12MB46840D259987CA9265317F75FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
In-Reply-To: <MW2PR12MB46840D259987CA9265317F75FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
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
x-originating-ip: [204.111.139.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce0d625a-a08f-4962-3209-08d91a712e05
x-ms-traffictypediagnostic: MN2PR12MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3984EEA85D69E997F200D9ADF72B9@MN2PR12MB3984.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZKpcOj/DofPEitnHsXBV6Kwwu9Qqfw6XOXv+YkvHMYVgaAyko1dq+CwlnKuhsF1QtjebG/IqpVv7bqkPloX3w/surwonrIMOEksSWCASKyC3elQCVlT2v2/bIMDapuOzsLnOe8hhtZS01gE4XSSFiyhSkSkuxZgoCaBOGeYGYV3vuykY2FxWTHsyMVAD08BPU1b7OCNKFIjm0ZwAfQ5+T7zi7CG5PkBplvzDJKif5l9qFF2qEjFMsDFwLWxcJkWSrufZZvJ2ZzFbm0e2W1jWLYqauhF5RhQFvT6v7Lg1PsrqRGjITSnK/hAXzQsdd/sx6dbsfj+xM/wLCqwzB3pL3c+UZwj1lyrZYyskwvOkWVsJiQywGJwOM3ACQZc9Tk560EKtoMK//CtaDWozC21cqzcJKNFrs+0aESacpmjaIoxVPngI6BljP7NYriUGRbDNKiWeq7fjV6+GS89JP92rrEH3VSIR66hVaoVpZz4FRO8rOOuNXTi4MSfVT+39Bh8HIMr2S3DDj5CZKevt8KBt6cl4coMTbINMrEb5zU2xjxxvVk/h65uvilnGAkmqe3UmoaCZrFqYvs2NBiJkm90O7k5qa/m23tYJH0hBUKhT0QtUXdKV+mfyhBjoYaXRGCmfKTPZCZtpcZeH9FJoc7lOZjY8Pc8n9VPoOWjMw7qlS/iAY3aUJC9Z9vqRb4+2gZmt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(6506007)(8936002)(52536014)(6636002)(45080400002)(5660300002)(7696005)(316002)(9686003)(110136005)(2906002)(64756008)(71200400001)(66476007)(8676002)(66446008)(66556008)(55016002)(54906003)(26005)(186003)(4326008)(53546011)(19627405001)(76116006)(38100700002)(86362001)(66946007)(33656002)(478600001)(166002)(83380400001)(122000001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OYkPL2ZJTt49QY1B332o3caOxJHYrlnKfobvDhwgVq2ExyoFVnatxWhtPTyK?=
 =?us-ascii?Q?c+F+n+32ShdERuzapEcaFF9AR0CoxDMM4FMEyRyb8GCg2mA427fjUPJP934H?=
 =?us-ascii?Q?VAr0hfpXX1Kqb5TCT9iBAVrCsf6FmH4ZOOdf1U76w9a0CqHRbuzddXptncrh?=
 =?us-ascii?Q?DAuzQVJemx6UGMAwVY0ZzPsxi0usIt+tGWoKoohbAOidU3Ar3bvoypqYVRCk?=
 =?us-ascii?Q?XgSDFzJtLvyfGPuMvAday8H4xmhAdJumDImsS1QQ0iy+MXMVT1lBbmAYjg2V?=
 =?us-ascii?Q?YtgFAqmeY6IhMICCCznNiYDeL51CbT9GTxU3M6bmLF/KAs1tF0I8vjZBe42O?=
 =?us-ascii?Q?BwBqTnnPtE1ogJL488u9nFEWAYOZ5p/ceSYavJvvrVbpVycMU4Y+Xwx6zsj5?=
 =?us-ascii?Q?XrHlu6nmcVZeNHQvmxYVFYm34rVUODs9+oxiMluqO8Lk61gT8824E7FMdLQA?=
 =?us-ascii?Q?BBBta1FJr3yiiCgs1KOQpYAE9oylVu44j/OloU45dTBrnbsE5OZMwWzgtxo2?=
 =?us-ascii?Q?fqWQDRDsXE2D/tbyqaHqIxMOw+s4jxmiMgD5+/hA/Q9hCZexM1OlMg9LOAdO?=
 =?us-ascii?Q?RLHUzLA3ZVe/+RGRNETuLJ324p0E7BwzBfw8A/eHofKv2Hh8SVWZH5hO66io?=
 =?us-ascii?Q?SYeeUjPQXbA1L30hqNrS8/vTev9RD8yRMBt+4WWXfywlwA6KP4DoHM8XlNth?=
 =?us-ascii?Q?3GuSphMFSgp9jmjcE6EO8cWuwTcLRC9JlgDVVYym6hM493Mq/c1DXM63ZePB?=
 =?us-ascii?Q?fFye/c92l8xdL2SP9MTYQrlnk1DY0q8U9mp231YZT1HXYVkP3m4bOiA8o/Kq?=
 =?us-ascii?Q?6O5pk3em724MxU5U9lCIu13NAqGsgFgEXjR7+pDkKbqD9feuc6GBuyjpJh0e?=
 =?us-ascii?Q?XkIuGkuZ0R1OKeOKmvKeFhw392ZCjxODT74m8aEpQvDhfxsQLkcDtXdz1AaA?=
 =?us-ascii?Q?2rkHZKe8Hugqu5xsvHxPx58HIHRmMZRJu4TLGiGiVmR9oRNC6VZvd/HAupeh?=
 =?us-ascii?Q?cXi/b5FEsIvBBCMWy/CggIYnvoorTDLCdf7XBEpg6Z1sUy+WD1IFXd/lQ7mQ?=
 =?us-ascii?Q?QbhDuAFxOi0nZXMVB2BGvgVW/CSTqQkgyqnRT9pqqMDP+IsQkzZ0bXhlFyqJ?=
 =?us-ascii?Q?9LWFl24OoivJ/HATls1gvF1abVBhog1oFhm9vNqqInTNZ7vWJCNMfj/BUrX8?=
 =?us-ascii?Q?Tgvp237lRaMceCTnMWti6pI9xLU7YysRLnft8mnGaCpwCQrFVhsa32Q4KEQz?=
 =?us-ascii?Q?ixoq1V5iRUVKc+t8RnXVqcF8bWPmbV0xuexU2IdFjDn6Bln1/k26GzhEaoI/?=
 =?us-ascii?Q?EYhPjsMDfaX5WcTPLSO03X2h?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0d625a-a08f-4962-3209-08d91a712e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 02:52:45.3204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLmlOUJSYvh15TlqWR+mEMt7ooXke0sA9efh06gpG/zvF5cLggPbGD9aRovupHsDyONg0StaXjwHS9mIISLlRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3984
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
Content-Type: multipart/mixed; boundary="===============0834657390=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0834657390==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448807A739B82ED7721E4A5EF72B9MN2PR12MB4488namp_"

--_000_MN2PR12MB448807A739B82ED7721E4A5EF72B9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

+ Nirmoy

I thought we disabled all but one of the compute queues on raven due to thi=
s issue.  Maybe that patch never landed?  Wasn't this the same issue that w=
as exposed by Nirmoy's patch that provided better load balancing across que=
ues?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhu, Cha=
ngfeng <Changfeng.Zhu@amd.com>
Sent: Tuesday, May 18, 2021 10:28 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
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
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, May 19, 2021 10:20 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang

Care to submit a patch to re-enable the extra compute queues?

Alex

On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng <Changfeng.Zhu@amd.com> wrot=
e:
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
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, May 17, 2021 2:27 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Zhu, Changfeng
> <Changfeng.Zhu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to
> avoid compute hang
>
> On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:
> > On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com> wrote:
> > >
> > > From: changzhu <Changfeng.Zhu@amd.com>
> > >
> > > From: Changfeng <Changfeng.Zhu@amd.com>
> > >
> > > There is problem with 3DCGCG firmware and it will cause compute
> > > test hang on picasso/raven1. It needs to disable 3DCGCG in driver
> > > to avoid compute hang.
> > >
> > > Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> > > Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > WIth this applied, can we re-enable the additional compute queues?
> >
>
> I think so.
>
> Changfeng, could you please confirm this on all raven series?
>
> Patch is Reviewed-by: Huang Rui <ray.huang@amd.com>
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
> > > amd-gfx@lists.freedesktop.org
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
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C6d2cfe6e59f54875f6fa08d91a6dd27f%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637569881259273626%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D33Is2P3sqdabI7PPuHFOmzuvXyFId%2BOTAMyJ8G5PhzI%3D&amp;reserved=3D0

--_000_MN2PR12MB448807A739B82ED7721E4A5EF72B9MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
+ Nirmoy</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I thought we disabled all but one of the compute queues on raven due to thi=
s issue.&nbsp; Maybe that patch never landed?&nbsp; Wasn't this the same is=
sue that was exposed by Nirmoy's patch that provided better load balancing =
across queues?<br>
</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhu, Changfeng &lt;Changfeng.=
Zhu@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 18, 2021 10:28 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx list &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to=
 avoid compute hang</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
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
From: Alex Deucher &lt;alexdeucher@gmail.com&gt; <br>
Sent: Wednesday, May 19, 2021 10:20 AM<br>
To: Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
Cc: Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.fr=
eedesktop.org&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid =
compute hang<br>
<br>
Care to submit a patch to re-enable the extra compute queues?<br>
<br>
Alex<br>
<br>
On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt=
; wrote:<br>
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
&gt; From: Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
&gt; Sent: Monday, May 17, 2021 2:27 PM<br>
&gt; To: Alex Deucher &lt;alexdeucher@gmail.com&gt;; Zhu, Changfeng <br>
&gt; &lt;Changfeng.Zhu@amd.com&gt;<br>
&gt; Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to <=
br>
&gt; avoid compute hang<br>
&gt;<br>
&gt; On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:<br>
&gt; &gt; On Fri, May 14, 2021 at 4:20 AM &lt;changfeng.zhu@amd.com&gt; wro=
te:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There is problem with 3DCGCG firmware and it will cause comp=
ute <br>
&gt; &gt; &gt; test hang on picasso/raven1. It needs to disable 3DCGCG in d=
river <br>
&gt; &gt; &gt; to avoid compute hang.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87<br>
&gt; &gt; &gt; Signed-off-by: Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; &gt;<br>
&gt; &gt; WIth this applied, can we re-enable the additional compute queues=
?<br>
&gt; &gt;<br>
&gt;<br>
&gt; I think so.<br>
&gt;<br>
&gt; Changfeng, could you please confirm this on all raven series?<br>
&gt;<br>
&gt; Patch is Reviewed-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
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
&gt; &gt; &gt; amd-gfx@lists.freedesktop.org<br>
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
amd-gfx@lists.freedesktop.org<br>
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
I%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448807A739B82ED7721E4A5EF72B9MN2PR12MB4488namp_--

--===============0834657390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0834657390==--
