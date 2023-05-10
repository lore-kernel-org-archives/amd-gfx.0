Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D57C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 10:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E5410E067;
	Wed, 10 May 2023 10:54:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A2210E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 10:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX+vL+ZrVlFUAiP1bj9TyovqB22t3pFa3ydN++DZ2IbjXnaDcZ9uGFA09h7yVCGor4Pqv8HJucR9wZh4KFd0xljr26XDKQWMALKyPcJ3utjML96MwJ9XGqCTXsudPc+m57i9ccbGkFeWem3L+2qPZ8Ei82bT+aBlUmopXCGnJ2xH4qbuKgy7zkuHSQzVtIKT2nK3vnVc0gIDZI/6nBedGHa/axcWb4zlZtzZOLpgKRDnEqyjYwgnIPOQrKEiatuECE1Hp5+Jdwmgvp6q4rQ0nUil21Gyar35PlRLHBZxGQU3+csc/pRvCx0PF1P0+u+raKiNzlyyP+ZLIqgmAy5DHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lW1N1zttFzC3AcoIkVMtS8QXyQTDK1LUuvAMPkHF6V4=;
 b=KKyZn4nVlwC5XS1D1oajFvCzM29N0BpOTxyCcT/aeCpwQzX5W2D5pgQNGcqrB/6RIz8VJzurVsMUMgmj3hQezArBmSBVypRutFTAdBLhTbXm6GjS9OqOlT/orH3YGNSSE6u3l/SmSENdueDlV2El1xUNWRnAufpgaPW8iB6SvO97SiLUmGWeBiYxgdXHRdQzIEw4pUY0JU+IswbvEiEUZ5i8zNWtzkYMNYEscDE9bW/OB5A+vlBxdZo16RWSUYHlyN9ggD8J4zlrzTY6XnhDuMr5NnEk9i/8iI1sGlcA9DFvEBnZFyp2ilE0sO8rviv4D5zX4QhF72FG1JxEsthbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW1N1zttFzC3AcoIkVMtS8QXyQTDK1LUuvAMPkHF6V4=;
 b=z7cT6BFF1sD0dEvbCtXPE6LGsS7O63jjqAldtFD7QKS7DlSD37p7y6xstGZe5oz40IZDEToRNXmGsFdNNKjNje3izB8tHnhs7UQ1ZK4OAPLbL3ugdHq9Ny1oP740oHJI1+dqcmldcHFwEyuocnCqn45WUyR1pzs15JRndip2tmA=
Received: from SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 10:54:33 +0000
Received: from SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::18e1:c084:6d96:3228]) by SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::18e1:c084:6d96:3228%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 10:54:32 +0000
From: "Zhang, Horatio" <Hongkun.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Index: AQHZgZasx4yv7EsXXkiG6DYL4plGza9QNtUAgAAYHwCAAOhZcA==
Date: Wed, 10 May 2023 10:54:32 +0000
Message-ID: <SN1PR12MB2591B9BCFB27E5F48156EF5BF7779@SN1PR12MB2591.namprd12.prod.outlook.com>
References: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
 <DM5PR12MB17705E6C9957FABED1BA9765B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
 <BN9PR12MB5257E9F12A8C0FC2CF8B1A5CFC719@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257E9F12A8C0FC2CF8B1A5CFC719@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-10T10:54:30Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a490c4aa-82aa-485c-bbc1-c470b98a3163;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-10T10:54:30Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: c83c872b-6fdb-44f0-aaaf-b5e9c53c52e7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2591:EE_|IA1PR12MB6330:EE_
x-ms-office365-filtering-correlation-id: 25144adf-640b-4502-c86b-08db5144efda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OJHEfJ8tSJWp4DHT8CLGUGpF6l9lZhte9OCy27VesxAsM4+RDxW7JdDOjvGk8uZhxB5Doubrs08UV3Pjgdq2ndyM1KETLFbkndEWZ8VdTbItJCgAyRLMoY6MF/UNirF66vDLAAjHx8m3Btv1v1GrTaYHjZKpqhpE2e+8/XuzYCtj+EPnSNKUKvdwOC4xhfRXaXpckFgHmBJ2XWladCcjYxNt9HlVb1WGIjgQ+C0uGTutLoZCbCcfaT6ym4blw0WskQBFe8H9OnXKm1eDY/PHPy+ziDUUz0YaBYfY0a8tFzwMlktNTnFN1KegdOcOHErBfusXI4fownzvfo2WNFnO8PJl5G2C2jKs08jIZiDbtTnUmUHjVss01P5NQycaYhei92wXrgT3mDeGPTwwCbTuP47MNcGh5QCf9MX3t/9JsXiei/w8ofMVk6MIa0DL6UibZC5SsuGDU3RJEEJzr9ZNVOI/9LNiN+2Iz+SAfeCkEhBexuod9c6lF1Euz/EWN9MQY2koErgtBYHHxmXaH/OJr/Oz9JKQ/e3b2/SSSk9H6jrNS4KXHMe0KYehfG7yMkaLoMFLeiaqBXGg+AJSpYDAXib8mugsEAuR37i5p7dUZ6ua7xi4c2MXgB2P8/X9M1+ho4K5/atDP+K4rBhCTbuvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2591.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(6506007)(26005)(9686003)(53546011)(83380400001)(55016003)(33656002)(38100700002)(122000001)(86362001)(38070700005)(186003)(7696005)(76116006)(54906003)(110136005)(316002)(41300700001)(8676002)(8936002)(71200400001)(478600001)(52536014)(4326008)(5660300002)(66476007)(66446008)(66556008)(66946007)(64756008)(2906002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3zKDPqUF24yEaZ6XwQs9S6sKBm+au1Ad6RfDbGkZPu/p6xoVT1ab/hN3O6M/?=
 =?us-ascii?Q?bQMF6WES0QE+87+BRld5KMHUfK5W6RdpTdzXfIqhaxBQPPy9Ic7xLlq5N2qX?=
 =?us-ascii?Q?FeUINFWhnplLk2465phJImrSEd//YAAy13yecQjMZGspP/KKKwwShsCGixeD?=
 =?us-ascii?Q?P0Id7fplua2bkasj4hC5SZTxZU6yJLLD1uSvLt6UAkXIjdaXHMZt0yHTkso+?=
 =?us-ascii?Q?wntvsUZJj88TEvIKq4bGdSeUQ9B9eKmKPQkfbf3H3WMfx7YNd8qOf+L5+rKv?=
 =?us-ascii?Q?jUWbitgHEoflDt0/u5GHnuRB/8QiQbWHuzNeBZL6wJuyq41xxJalPLWDHEwx?=
 =?us-ascii?Q?yoKV+XUdGoPf5l/hjcQ8RDaW+PFSzV3FEiC6Us43qqdEMmUdlNIMgWvXR/cu?=
 =?us-ascii?Q?30wSydPTvkoCcqy1MzmEsNPlVA3xBHsqqFOnWrTXb4JhBgkpWek5raoN49Kd?=
 =?us-ascii?Q?YUsx/5yo7Lu2s/b0dDAvVQ4AD1dx9WFahY1NBrzAv8mZcKqvkKTT4sUW63X/?=
 =?us-ascii?Q?eVvh3KusgdJ2emcRMq1gWU3nLP+INiV6p8S8wKOxKeaYaeVvJYI3wF1rDxej?=
 =?us-ascii?Q?/2N/y36bZywVkX4+EjZL4Sr5L5QH1oR6tuc/YiSdc2AG/HS4uTT32My6xwSR?=
 =?us-ascii?Q?5lyzI7ih09E6kXeySxceeCKAEzF/pRxv4ZycfEHgffKaxdUTWW5R9fhA7+vs?=
 =?us-ascii?Q?gwQdS3vKzbfT5SHkNZSaiIPIcRoPRskYtJzFoEDV8hi9m+/MC5u9uTJCl+gX?=
 =?us-ascii?Q?H7se0u0jsLvgSRdy5RGfmqQYcXfj7ju+PoG9UTsHN8v8WEYVRVISZim/S9Q3?=
 =?us-ascii?Q?aYYRaOs5hDYJyLTZg/TKqqSgERr9CNljui+WwtjOMSP8vnuZXS7P5zonmdS3?=
 =?us-ascii?Q?LpSQ1sZyxe/tMCX6LrLerjeei4A8VN/gjZHqdOiMcG6jP+uUN+6uFCLtsYHI?=
 =?us-ascii?Q?QSr926A5sJt5hiIL37knZ4yEErMez8SsL2Dv8DpSXvDhYdgt1JKyp9L3rnm+?=
 =?us-ascii?Q?2s6IBcCb3aEWqe6wBiH3myychLJUOQ6hQOb6NUz+O8c3tsI45ZHEl2DzQmCu?=
 =?us-ascii?Q?pfF9jVOgWQ2o/OaP2dVNoTqnR/mfgHpoiBNOzwH2YAi++AiYbeNpk+OR0ycs?=
 =?us-ascii?Q?62zE+t1QZmBlR33hghB8V98wOwjlfqyNFoj4bVcmwSD3eByMvBEgipFkLldg?=
 =?us-ascii?Q?Meu4Z9n1aV8Sb+Mc3Di3hw+o+4P/0LeVU20n37HUa9KmFSI5GhotJ7znY9ct?=
 =?us-ascii?Q?YXoCNQqPdfJVj1YRVNIEK2R8YzQ9sImebS1x3BwCgV3eCGGeqoBh5HpExQph?=
 =?us-ascii?Q?KwZK4/6u3YmqQbObG8bO70f7mbWq0G2cmi83lEbXTMWkbFGymCemKOw+ah5B?=
 =?us-ascii?Q?X4tYxa1w1ppcJl+4WVC/BuW6PbZP2Iqn1ba5Q3JKN2FnmlFHiS+dNSJWo+t4?=
 =?us-ascii?Q?7cWKuqBr8h8q9A/Y1KOMllk/AnmcmhHuzknIkTsMXhwwIzei81O3DnzcQd2j?=
 =?us-ascii?Q?LsX56Cf1it9aAjuHh8O5ts9yO/GArvSjERWiDtcD+GXNpmtxL6O0dKmde4H8?=
 =?us-ascii?Q?kfNUKdpN+SFCBhdwvHM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2591.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25144adf-640b-4502-c86b-08db5144efda
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 10:54:32.6479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vL7KVP9r+zOw1sakl3Ifpu60PePd7E0cbgLJ5923SgRn/BJUK5D87e/MEeYobVYvocmqxWY3ohyNDCmIIJrwmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Zhou,
 Bob" <Bob.Zhou@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Jiang, 
 Sonny" <Sonny.Jiang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Hawking,

When modprobe, the interrupt of jpeg/vcn was enabled in amdgpu_fence_driver=
_hw_init(). If the amdgpu_irq_get function is added in amdgpu_xxx_ras_late_=
init/xxx_v4_0_late_init, it will enable the instance interrupt twice.=20
My previous modification plan also had this issue. Perhaps we should remove=
 the amdgpu_irq_put function from jpeg/vcn_v4_0_hw_fini.

Regards,
Horatio

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Monday, May 8, 2023 8:32 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>;=
 amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonn=
y <Sonny.Jiang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Li=
u, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.=
com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

Shall we consider creating amdgpu_vcn_ras_late_init as a common helper for =
interrupt enablement, like other IP blocks. This also reduces further effor=
t when RAS feature is introduced in new version of vcn/jpeg

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, May 8, 2023 19:06
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciell=
o, Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.=
com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Horatio Zhang <Hongkun.Zhang@amd.com>
> Sent: Monday, May 8, 2023 6:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao=20
> <Tao.Zhou1@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo=20
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello,=20
> Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan)=20
> <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in=20
> jpeg_v4_0_hw_fini
>=20
> During the suspend, the jpeg_v4_0_hw_init function will use the=20
> amdgpu_irq_put to disable the irq of jpeg.inst, but it was not enabled=20
> during the resume process, which resulted in a call trace during the GPU =
reset process.
>=20
> [   50.497562] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
> [   50.497619] RSP: 0018:ffffaa2400fcfcb0 EFLAGS: 00010246
> [   50.497620] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 0000000000000000
> [   50.497621] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   50.497621] RBP: ffffaa2400fcfcd0 R08: 0000000000000000 R09:
> 0000000000000000
> [   50.497622] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff99b2105242d8
> [   50.497622] R13: 0000000000000000 R14: ffff99b210500000 R15:
> ffff99b210500000
> [   50.497623] FS:  0000000000000000(0000) GS:ffff99b518480000(0000)
> knlGS:0000000000000000
> [   50.497623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   50.497624] CR2: 00007f9d32aa91e8 CR3: 00000001ba210000 CR4:
> 0000000000750ee0
> [   50.497624] PKRU: 55555554
> [   50.497625] Call Trace:
> [   50.497625]  <TASK>
> [   50.497627]  jpeg_v4_0_hw_fini+0x43/0xc0 [amdgpu]
> [   50.497693]  jpeg_v4_0_suspend+0x13/0x30 [amdgpu]
> [   50.497751]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
> [   50.497802]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
> [   50.497854]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
> [   50.497905]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
> [   50.498005]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
> [   50.498060]  process_one_work+0x21f/0x400
> [   50.498063]  worker_thread+0x200/0x3f0
> [   50.498064]  ? process_one_work+0x400/0x400
> [   50.498065]  kthread+0xee/0x120
> [   50.498067]  ? kthread_complete_and_exit+0x20/0x20
> [   50.498068]  ret_from_fork+0x22/0x30
>=20
> Fixes: 86e8255f941e ("drm/amdgpu: add JPEG 4.0 RAS poison consumption
> handling")
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 77e1e64aa1d1..b5c14a166063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -66,6 +66,13 @@ static int jpeg_v4_0_early_init(void *handle)
>  	return 0;
>  }
>=20
> +static int jpeg_v4_0_late_init(void *handle) {
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +	return amdgpu_irq_get(adev, &adev->jpeg.inst->irq, 0); }
> +
>  /**
>   * jpeg_v4_0_sw_init - sw init for JPEG block
>   *
> @@ -696,7 +703,7 @@ static int jpeg_v4_0_process_interrupt(struct
> amdgpu_device *adev,  static const struct amd_ip_funcs jpeg_v4_0_ip_funcs=
 =3D {
>  	.name =3D "jpeg_v4_0",
>  	.early_init =3D jpeg_v4_0_early_init,
> -	.late_init =3D NULL,
> +	.late_init =3D jpeg_v4_0_late_init,
>  	.sw_init =3D jpeg_v4_0_sw_init,
>  	.sw_fini =3D jpeg_v4_0_sw_fini,
>  	.hw_init =3D jpeg_v4_0_hw_init,
> --
> 2.34.1=
