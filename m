Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DD3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 05:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8354611B77A;
	Mon, 20 Dec 2021 05:43:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF0A11B759
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 05:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipieh97AXRuaX3qISBK7jVSC7yYUxtDu8wmKs0HTUMXB4EemxvNoHZtIAKohwjicGDFqrafxdpQX4BNbXMbVivSF47NCwFYPUcXX+aoqyHjzy+UkvDxLpKF9Nj/XlL791Z5w8VAYzRmFCVwsqFGx1eezDEYhCJ7Py776YD1yavMhIKoj35U0PJwRAGId6M8HSY3TIkcHxmnvLN2E+6LTPNTF4/IvjcWV4fahCVA9l7ZSjSwfE04OFIG46/leWdHHX0XbP9AaO8kJWfpy/mFi0841SwC3x8WGqA6c0hqlCiZsi587xYui+ZIImQp8q9Ro01/3UA/RyDqBHiSwgcuI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loy6nXstrCaFRfQ8AODo4RFjRUoCg+DngOGLro2qZsU=;
 b=EWD5LXqeYbyWGn/xn239oRkmUnP0WNpZoqg0cfy9dq+jxOF6zfR/ZDLz/akkwj3qp7GtlabcVu/Nn9kWQNX1460oMsHxg860apB6tChk00TQZHqtepJtezq5gbSZALD+/+m+A2zEkGpNus1PrxJpE9Q6SLq6FbEp5w+xx0FlqyQO2FQj3fCUBm0eBJny2PyzYptyKSz4UQbYdjcqo1ko8nmjjMkjZHBr2i9ciYdGkbYRNtXE9TrrNlkcmnDUVEP3qVp7w61Tx64Ssg4ALg5l8QLQ7wDyrz+W/bmbR5TCwBz+ljwflpxZFjDC8Gp3cVTyyvxX0AXje9iQKk96QnmjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loy6nXstrCaFRfQ8AODo4RFjRUoCg+DngOGLro2qZsU=;
 b=4bmSxYOMhRZ1xWktngZQ3xKVcZONwQFvJD+WHcSj4dkmJ/HW/EmyaxjTCh+hI8vlQ0g7S7UUxAshDqNfXst2aE8kBW6Eq/o1E4udD/CMqEaBR+9HklrNAG9ck3TtqCvQfnZ9fHnICVgseFoPcrrWC7PzyyAz3IHTslsQrweiivI=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM5PR12MB1467.namprd12.prod.outlook.com (2603:10b6:4:c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.20; Mon, 20 Dec 2021 05:43:34 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 05:43:33 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Index: AQHX9U73J+Gwhw9bDkC+52llWaYzZaw61QYQ
Date: Mon, 20 Dec 2021 05:43:33 +0000
Message-ID: <DM6PR12MB3163F586AB5EED14E56AA455857B9@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <20211220030849.32458-1-guchun.chen@amd.com>
In-Reply-To: <20211220030849.32458-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4282ab61-935b-4bf8-ae86-165425f380f0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-20T05:09:52Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: 5d354f12-252a-406a-8065-74c6c25151ce
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59ab5219-e0db-47f6-d867-08d9c37ba94b
x-ms-traffictypediagnostic: DM5PR12MB1467:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1467079439862868C99C7A45857B9@DM5PR12MB1467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2cxkUmnVb2t/T33qOLe68Vg82ue+aixEnbjuONlfBBFRigkcaGITvheL+zGMrMGacd6M7KxadZuColoJjJAuIJJC4xwGZN9NL8nx01ETiDx/k2LHtdeQhq7mB4cl4PWrHRWmbOgQbfWI9z25CoFpXpQEQOt/pdnn5IjPlbSpF1WRpwt2D4m7yhjkKkDexhZOUkk3wU0ImnBZ1ApelxTyjT4rSVHrDYrrIdGvsa/lq1AHKarnCt75G0PHCRDGqm774LFsmlRSNFZ/qp5J+k0Kn6TZWw7L0I+LgqoETuCZrcBpDLR0MaXVHdQXDpALNOhSuR12FvgpufZ+6es/YEmL8CtfbPLvUHXHxzmGKXS5rNmowiKgxe7r37rqEnl2aOsK2/g5W1JyM0+anyUVq6WhhYzTWnx9dYUqC2+u2AzfHrzSM9va+juofX36jJ59JAu1Rcs9O6upo0MrCHm0OOTPgAGLpYd011e8Zt/PJLIEjH0wciQTvYnNN9GuceZCZoz2fGIfC5bpO89XtoTjQUU2mVJGw6udnqJeL4ezrWi9S6g/qt+3pjvqQc5OD+mF1E5KqEML8BK0lfUh14yh/htcarxABfeh/84vicZGr4eqzu1JEEJpU7ooj5xWA1fryCZ+3TAU7sxBNPHh9AEw4G1PrG/LbMToNsjGFARGnd/F4BFDCPlBOgOaVDWXY0nF/SE3m8i1vXlaWD2LQ80e/h2aw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(38070700005)(66556008)(66476007)(186003)(9686003)(83380400001)(5660300002)(66446008)(316002)(76116006)(7696005)(71200400001)(52536014)(2906002)(6636002)(55016003)(66946007)(8676002)(8936002)(53546011)(38100700002)(6506007)(122000001)(110136005)(508600001)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a+RiykdwAq8NKz15KIwHBpj4xEHuBTbWOzC1T+J8uLtxf+4OlBqhS4AAFZzo?=
 =?us-ascii?Q?6v/62dnRJNIq+G1lWG0LMiNzHgJB6nLevyeuOw2wZEopeNaY8MIVcMRLtwA2?=
 =?us-ascii?Q?n5h0ULXGWpF63VItVHMMAF4XjvUgqbLf5zLYxHXr61hus6JJsll/03Wkl2xb?=
 =?us-ascii?Q?hVv3g3oKqPKnwx2hbF6iF3u1epgsS3oGyjUfo+rV2tYYz7eOVtqvewvR6RbT?=
 =?us-ascii?Q?IlPBfPR/Jv9DLY6K0sStD53z2KeYck6QFiQo2Hht5XikWvy64vyqN+u+brS2?=
 =?us-ascii?Q?MiFyu2KMjs3oE28PcG/5WdFJ8Sl4ZLBkwPtigXLU6emLtrqpgT94vyfL6wrC?=
 =?us-ascii?Q?x/MD/TLPVpdg7TGEpkAE06dj6sZzxp4MHNauaOmGNoChP8OLOS6ynjz5fDT1?=
 =?us-ascii?Q?l9k+eML3kGQ5n3Y1KmnlPPM7phOF68kwUtTQhDblkPeY6e+FMhxxe1AbOI1g?=
 =?us-ascii?Q?45ImIAFsbc20GrhYinBYY4xKW9js8qmApOnIiOc4aLGKm7IyLf8KIKlIz9sh?=
 =?us-ascii?Q?bHqQZI1gp552WVUeL7S+5GLQNgQMx7IF2U1YJkX+EYl2OrtxLJL9w7q8HPgm?=
 =?us-ascii?Q?0CHksdCBNc7T2UUGETxjGNG0HHBG7VOIFTBfxSm7Q9kFGgnklQqF2uS5TsIo?=
 =?us-ascii?Q?C1JpsAGUf0BkCJpyPnBwzyTjcAN6vfZ37RP4VsldKimf6IA5mXBXMkOaAehV?=
 =?us-ascii?Q?bBCNFmz0WkTCCzlXzcmRpVH7+dWuSJ9khAcZnvjOPEjUxVA31QEkLQF8vC8q?=
 =?us-ascii?Q?vskFUAklM3/e8k2KA9Yjyz2WNbUwDdy52Jikvr1QhvEyVEZQQOe2g8ytWOn/?=
 =?us-ascii?Q?BfYbmskfnvjL6523c+9aV45aNi+4+uqgVmXgFqMWWuqTR2tvnyPV7meP626L?=
 =?us-ascii?Q?rs3oETXTblC7TQIndEokHx6A3rn/ZcJj78R5ebQkRqn6SUVdTleHRhsgU9E4?=
 =?us-ascii?Q?loz+mk7oc0M5oiduq9xk4QQh+XeE1dDcBU5OmyYd+Vm3H0cYVvM7fXe5Bkdb?=
 =?us-ascii?Q?VkCVzk7FfMZ1YWgk0vG6bBxsgUOsbqvVqe6u/ghNhtx//JnXnSE/9qQTMiLr?=
 =?us-ascii?Q?j+B6dfCbn5/iEPAy392tKqOHq6no4FvOiLLn79+sdfzA5EZWyynH2HYNxukQ?=
 =?us-ascii?Q?+ihz3Vd24+pJwWwoFG2tghUEjQXP2zcX15WvKHORokP20QEGr84YqkMtLN3I?=
 =?us-ascii?Q?UG/a8fqeBccTNzZDoCU0gF86ZizbWLuQXpcxO3hu25DQIB8mCCkN98y1strX?=
 =?us-ascii?Q?r59K3RRDdfzdOlWMykfMgCY6u4NiXkDJkxiEGeI7rIEX4m2eqFcDd+Wz8rdJ?=
 =?us-ascii?Q?jXkdoI33bORwXNDGM+e7CNV3gY1D+1LlHrHqKxGQi9XE1u6UmfZw+wO7vAbI?=
 =?us-ascii?Q?AS2UiOVrTvzig2MTu3UlPihNlRYJW+k55GgblpZ1unvWhmJGnPNvbFVxoYAt?=
 =?us-ascii?Q?KnroA/ipy6vqmFCuEhbSMOGm/UybxZ3sFuimGpsFCT5MnV2ketNx7klE6nRP?=
 =?us-ascii?Q?gGbAqop81nXbDNTuj7VIH1aWFImj5BbGBVtIEVvRs3IdCLL0PWRmyrswhkBs?=
 =?us-ascii?Q?qGtdz55729tdM7H79nkoBNXOhoxdFQtGafOA/r9bTlD4wRnlrq81yx1/mwHD?=
 =?us-ascii?Q?B8OG3yIF3x9J0K36jZsClcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ab5219-e0db-47f6-d867-08d9c37ba94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 05:43:33.7099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e13Z3GrMyC44nEH0fPCt27KDlXDAeQFsoNOOJ1cuA3ZNbo6duUcmEv1dT3bk9APU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1467
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

[AMD Official Use Only]

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: December 19, 2021 10:09 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device
> init (v2)
>
> sdma queue number is not correct like on vega20, this patch promises the

I think you've also fixed Vega12 and Raven (they were being set to 8 before=
 rather than 2).  No need to mention this in your description, just double =
checking.

> setting keeps the same after code refactor.
> Additionally, improve code to use switch case to list IP version to compl=
ete
> kfd device_info structure filling.
> This keeps consistency with the IP parse code in amdgpu_discovery.c.
>
> v2: use dev_warn for the default switch case;
>     set default sdma queue per engine(8) and IH handler to v9. (Jonathan)
>
> Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Other than the missing checks for Raven when setting the interrupt class (s=
ee inline comments and reference kgd2kfd_probe in kfd_device.c) and one nit=
-pick inline, this looks good to me.

With those fixed, this patch is
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 77
> ++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index facc28f58c1f..36406a261203 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -59,11 +59,75 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>
>  static int kfd_resume(struct kfd_dev *kfd);
>
> +static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd) {
> +     uint32_t sdma_version =3D kfd->adev-
> >ip_versions[SDMA0_HWIP][0];
> +
> +     switch (sdma_version) {

Please pull in the indentation for all cases to line up with the switch blo=
ck.

> +             case IP_VERSION(4, 0, 0):/* VEGA10 */
> +             case IP_VERSION(4, 0, 1):/* VEGA12 */
> +             case IP_VERSION(4, 1, 0):/* RAVEN */
> +             case IP_VERSION(4, 1, 1):/* RAVEN */

As mentioned, you've also fixed Vega12 & Raven here I presume since afaik, =
they're based off Vega10?

> +             case IP_VERSION(4, 1, 2):/* RENIOR */
> +             case IP_VERSION(5, 2, 1):/* VANGOGH */
> +             case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
> +                     kfd->device_info.num_sdma_queues_per_engine =3D
> 2;
> +                     break;
> +             case IP_VERSION(4, 2, 0):/* VEGA20 */
> +             case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> +             case IP_VERSION(4, 4, 0):/* ALDEBARAN */
> +             case IP_VERSION(5, 0, 0):/* NAVI10 */
> +             case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
> +             case IP_VERSION(5, 0, 2):/* NAVI14 */
> +             case IP_VERSION(5, 0, 5):/* NAVI12 */
> +             case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> +             case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> +             case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
> +                     kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +                     break;
> +             default:
> +                     dev_warn(kfd_device,
> +                             "Default sdma queue per engine(8) is set du=
e
> to "
> +                             "mismatch of sdma ip
> block(SDMA_HWIP:0x%x).\n",
> +                                sdma_version);
> +                     kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +     }
> +}
> +
> +static void kfd_device_info_set_event_interrupt_class(struct kfd_dev
> +*kfd) {
> +     uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> +
> +     switch (gc_version) {
> +     case IP_VERSION(9, 0, 1): /* VEGA10 */

Missing check for case IP_VERSION(9, 1, 0): /* RAVEN */

> +     case IP_VERSION(9, 2, 1): /* VEGA12 */

Missing check for case IP_VERSION(9, 2, 2): /* RAVEN */

Thanks,

Jon

> +     case IP_VERSION(9, 3, 0): /* RENOIR */
> +     case IP_VERSION(9, 4, 0): /* VEGA20 */
> +     case IP_VERSION(9, 4, 1): /* ARCTURUS */
> +     case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> +     case IP_VERSION(10, 3, 1): /* VANGOGH */
> +     case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
> +     case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
> +     case IP_VERSION(10, 1, 10): /* NAVI10 */
> +     case IP_VERSION(10, 1, 2): /* NAVI12 */
> +     case IP_VERSION(10, 1, 1): /* NAVI14 */
> +     case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
> +     case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
> +     case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
> +     case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> +             kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
> +             break;
> +     default:
> +             dev_warn(kfd_device, "v9 event interrupt handler is set due
> to "
> +                     "mismatch of gc ip block(GC_HWIP:0x%x).\n",
> gc_version);
> +             kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
> +     }
> +}
> +
>  static void kfd_device_info_init(struct kfd_dev *kfd,
>                                bool vf, uint32_t gfx_target_version)  {
>       uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> -     uint32_t sdma_version =3D kfd->adev-
> >ip_versions[SDMA0_HWIP][0];
>       uint32_t asic_type =3D kfd->adev->asic_type;
>
>       kfd->device_info.max_pasid_bits =3D 16;
> @@ -75,16 +139,11 @@ static void kfd_device_info_init(struct kfd_dev
> *kfd,
>       if (KFD_IS_SOC15(kfd)) {
>               kfd->device_info.doorbell_size =3D 8;
>               kfd->device_info.ih_ring_entry_size =3D 8 * sizeof(uint32_t=
);
> -             kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
>               kfd->device_info.supports_cwsr =3D true;
>
> -             if ((sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> -                  sdma_version <=3D IP_VERSION(4, 2, 0)) ||
> -                  sdma_version =3D=3D IP_VERSION(5, 2, 1)  ||
> -                  sdma_version =3D=3D IP_VERSION(5, 2, 3))
> -                     kfd->device_info.num_sdma_queues_per_engine =3D
> 2;
> -             else
> -                     kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +             kfd_device_info_set_sdma_queue_num(kfd);
> +
> +             kfd_device_info_set_event_interrupt_class(kfd);
>
>               /* Raven */
>               if (gc_version =3D=3D IP_VERSION(9, 1, 0) ||
> --
> 2.17.1

