Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBCDC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 01:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F266112A22;
	Tue, 19 Jul 2022 01:37:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95892112B5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 01:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCbRLnP9yKO4oKOColmX0IIVkK4xfPq3g422rVz+cuQwUk39V2KQKUtsZtP6r0zrEOTf4Aay/+axr51AF6BG16vy0p/bfoALnk2I5MumSRWG3Vh2MmQf444O4Irv0ByaPRvevlhjeww7DSfc76C952awjM+xL72xW/T3wu5r9pmkywQInYELKA0WUmGoa2jAuLOT0ddxXs9bcP0NxwkOrpkkDOvXEVfJLzbL4y92NsaRxbf9RVE+XWECbMu2Z3TQNkpFcWq3RWvPA0hRymSTeaabbLIaGSDfeu0kEbLy6Kxftnx+JBzAAxq58HaSu71cMNeqtKI7jWo+O1ZOnIow1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VYqVzel0jn9snzCI7nX4IHhA7Oqu5+tpPrgGkzhIJ0=;
 b=ccOyVyYVi7Q/BaAm0URxpVmADDLLuw05mjfMzTGkbvULg9jnsADyscGRIGgzaiwnxTmiVi7Wyio5SDdhJvA4yN03OHmhO0q/CAzYkoCEOz4+9IsT+ds80i+Ko+hubY0DhenPacedZGAbTMifc744SnNpZMwsReJUSW9bZD+/9WEj+ENGq856ymcUyoZ1ermVKC4IpwvxG44sgAiwT3H5+YGs5VXc0JWqi9xjdJZ+Bx5RAWupSzs8LfVEeTR4dboR7Mo0KjLaeQ5gN3zVtLEMQJyIdPkhjCVhOKQrTwxluRKNA8ggN7b2flgSVHj6tnH0HBURp1XkFlQTtWlFXqQzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VYqVzel0jn9snzCI7nX4IHhA7Oqu5+tpPrgGkzhIJ0=;
 b=khPwoKhjJRufJbx/pnBAj4fqtfOaappFHkF6QtPAr0mA3/TkHCEHuQLgpjIriEhB6U0sEzXN/TUmw2f65ZQl5HKVgKZ+h+d4e9sGhls4aGQBkZ0cEzVYAqN8gLk/QBC+BFA6LTJne34RjzLPf4fKlArkaEXhbUy9YGMuE/Yqroo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Tue, 19 Jul 2022 01:37:00 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::11ca:14fb:e8ea:627f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::11ca:14fb:e8ea:627f%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 01:37:00 +0000
Date: Tue, 19 Jul 2022 09:36:51 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: limit the number of enabled gfx queues
Message-ID: <YtYKs6JybsV0sXQz@lang-desktop>
References: <20220714070645.99139-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714070645.99139-1-Lang.Yu@amd.com>
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 320365fc-e135-4889-108b-08da69272cc6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETxCNEQG+YvtOxDOokZ9k45u7K+Dhd2Fm23x4rYCNKZmsJjRqxui1SeC0wfXnuMNVtfMTTUpjwEjqWoYDnYVDWHHSQA06DLXIoNv69qF3ijgbwF5BWahJbko7x9OaQcUHBKiPQGXRAeAjNqdt/2c6wFEaleXrvuAhnKv0XicPV5Mvl44zhie2cmCaLS88ElGBhYYyOSkHgSI13T6tFitSfQ7Nlj6Z5u7QO5Z7Ei5PJjjcRDmlNcOmlqKmX/QreCs4hwJ5oTaiFUaQAdrUSaVN0v0RJDb07cGWBwSVsaaRw9etSPAC0/WdG3WxpPO12gpy7t/sWhGg7twMWoQsev7ClbdaYZs9Wpp07aSwKo+f5gLg1KYpY6UQe/nft2xlMca9YNLxQNZ+Yd6ZBWRT5hD6RrM1aq1REvoxQWhVh0+vg70BjBSObXRcOJ7NqpuO6Y8nU1mBlZ+liThZBdsUnblu7cKPhhulyfa/ai3Zsyme41Q3EaYoHhRWpi1+9CDqn0OY6mVfoXihl8kgBtZBADy1TSE73ImouOwmVz4BFb8rSlPja04z5+Ot/x13nVa6zQcbf/xp2l6DlT54PXW76awUbXpl+E7QqwRLq673b5z6E65Jely8k9+kWfZhE1XtgzuIAMZrt6QE6edsM67cHfghLohgde7rJ7tcPJCCJXyaLQCW4ALDEpOIG7vGp4P95H1lMdxtBasRZAHNSVNhR3OnOE6cyZI/O1kcWi07BoB5wVVbnlq9ovvcM2ngbxT/N+nq9M+cgOe3gadfI8DAPP4+q24zLrkX39UmsSXOcZlEBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(9686003)(2906002)(8676002)(478600001)(86362001)(186003)(6916009)(6512007)(6666004)(26005)(6506007)(83380400001)(8936002)(41300700001)(6486002)(33716001)(54906003)(66946007)(38100700002)(5660300002)(66556008)(316002)(66476007)(4326008)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?50C3F0uZOIa+OYs/yw1t4E7q4g+wQz7Odpb7VtUKZW0BLITWApcRxrVL6Ay8?=
 =?us-ascii?Q?y+GT+lB9SOBPW4JFoXpIn66bcxmh/RJztLPy3Ag5JRUznD89ALQTwkFyN28m?=
 =?us-ascii?Q?ngaB8M5hKRDF1p9Xi/fPdWWsTKgfjwePSjuacOlFi/axubkalpUc6E9f5Vqp?=
 =?us-ascii?Q?WQA6L35gnqM5Im3R7YPWE2cUELWeNZFkkbt84X0KXO0GM7g+Pd4UDjwYSewc?=
 =?us-ascii?Q?T6RwUzwIRgxsZFgZapNSrZBiSSuAcWVLgv/G0lgD0WCtGrxEx5nJY/WWDHLp?=
 =?us-ascii?Q?Oe+tE/g8GiO23wXJLnKehxRq+cnCMWFkP+A+TXUgk4ncqLOJUvNckRjSEekh?=
 =?us-ascii?Q?4Vja/V0+/YTl3x9qwfiy1q5O1E2aqKvEbimsYsDcxWHR54D/SQwb/gcJl9Li?=
 =?us-ascii?Q?uFWPvP54EWIWGSo+T+UqD1JDjX97oVoQ9+ngSPmYXCjebdVIZpD7V1FVlM1L?=
 =?us-ascii?Q?jzVzH2OAflqmQaSFmGcRPAFoL1xGOc/zCvrU+J/rn2jgkT5g4aB3ZIf+NXus?=
 =?us-ascii?Q?N+ffrKW47a2xjTGgGZmOrO5b8Dp6pCYfuuFcYETVzfsiPQU8jI/e1A9mRz0I?=
 =?us-ascii?Q?TtJbJX7FMyFyUvUHHrkwALylDRQ51kYsuyHoLq8ldSqFg9uQRzhlZSxpww+t?=
 =?us-ascii?Q?aY72qxOaYl/8AOLBVB0X27qdaMyhZmvN1Mgoe1KkdsNMq0CWdQ1QMDJ950t1?=
 =?us-ascii?Q?lubA/k+09kbW8Gi6SK/bbuKpguHAIPFLNbSBk+7X9SJudHgwdOMCU1B+Ryog?=
 =?us-ascii?Q?6k2F47VUYIXhUBpeCf+uZVvnthRJfNtm3M41DGsalFfn+Yu/ZMFJtlrbdkIc?=
 =?us-ascii?Q?1ZRO8hVVIWFMdJh+9Mw3yZ5oidIFrNjYzav+Mu1VGAJT6CPWDfprCzlFzO7m?=
 =?us-ascii?Q?d7w2+LHN/W8lAArh717FV/bg81Qco35S2olvaKhOYEdRqREi4DUCLOK5IRzE?=
 =?us-ascii?Q?orsrVlXRkiUIHlneb5CzkkBCoQcTSltBC06dxLd+TmvkVIFyDv54lRGf19PZ?=
 =?us-ascii?Q?Ja0GnvnMqFloprzcMX4rqUojqt/BqHgaxgFNn3iHY31WVDmj8iSrF3h+WHVe?=
 =?us-ascii?Q?xY9V1zzL2i0+C0dQlDvrT3yLHL5wQjywCZ/M66LCH1VkTXQ1V6egQoyE8G6H?=
 =?us-ascii?Q?vESZoCELm4/4EO5MExC9E4VbJYicRu1YtWBfwAvZkAPr0hTG2JZOyqIOcuBN?=
 =?us-ascii?Q?hL2YUnO71gc4lZlIjii8APy9PcQwTg4t1qm7fNCaiVHbSnAs1AG/mG7EJXf/?=
 =?us-ascii?Q?uYRqCoDKATWR3GPbAVaJgJk+qD21Rb97SFEY2D1Lb1srDEAFJN7d9hTOs8RJ?=
 =?us-ascii?Q?sjHK0fOKgOSEMj9UC16s4qNbYQ5weZhyt4IIk6K08CaNN5x3+0wFEa4TKJxJ?=
 =?us-ascii?Q?06GDe2HwELlZ0rSYgG1+6RQSAfrmYqlDUt45hyjKNb9x+u92cHC+AD9PrTi4?=
 =?us-ascii?Q?kD0aIVgalnBEaweFzoIU77/Dh53s1WV/1pMUVwBkBPzUbhyIE0WbirsXH9Wa?=
 =?us-ascii?Q?4Id94x91vI/agPb7gI8fZze8vWgVz0HLxiPHWDt5NkvypMe5MFIdf72taBnU?=
 =?us-ascii?Q?7gqIbrSbx1bvMtebIploXKFvEAwi/vqHBa59jjtg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320365fc-e135-4889-108b-08da69272cc6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 01:37:00.3897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fkq6xeFxE76pWogzObZFj6Mn/1Y56vZrUgbQ+Nj4NkUHbCYS4ltDPcj1oGVnnfsXJCVtKmE2SNZRCCmhi1N5KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping.

On 07/14/ , Lang Yu wrote:
> The driver can only support AMDGPU_MAX_GFX_RINGS gfx queues
> at the moment. Once enabled gfx queues exceed the limit,
> we will run into problems when setting up gfx rings in
> gfx_xxx_sw_init().
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 222d3d7ea076..ae3fe1d0df04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -229,8 +229,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
>  {
>  	int i, queue, pipe;
>  	bool multipipe_policy = amdgpu_gfx_is_graphics_multipipe_capable(adev);
> -	int max_queues_per_me = adev->gfx.me.num_pipe_per_me *
> -					adev->gfx.me.num_queue_per_pipe;
> +	int max_queues_per_me = min(adev->gfx.me.num_pipe_per_me *
> +				    adev->gfx.me.num_queue_per_pipe,
> +				    adev->gfx.num_gfx_rings);
>  
>  	if (multipipe_policy) {
>  		/* policy: amdgpu owns the first queue per pipe at this stage
> -- 
> 2.25.1
> 
