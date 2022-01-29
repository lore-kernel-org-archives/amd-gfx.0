Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF50DC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 07:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF3E10F624;
	Sat, 29 Jan 2022 07:42:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2E110F624
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 07:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUlsxlodG+//N0gP490ub0JLiRhQ32FZP56/6JDpUuTbSdI2430Y0bp3Tsiy7A0kKeTHVjmrkONXGUfXyOGQ1VueYP6yhxfEj+iTGa38IsgCpsmjTnFztpmxgFFwjavopjudK1JVgkffWAeFBKkBRwWhfO0x3RerqFFRtQie23acv5KN48RkGzEkKSdqAem4W5HDT86Ib8ELKw9RxexQeMWyII2OSOylRtDRt9ji+vpVXMAr4BDt/WPyRxy6zPj8NcJMCJ67xFCZpplIIezcP3kezZN8NCw15GoCuxXiNW/+p/GVyE3FGMl9xw/gCPCrXmNNCloTb4qBy9KVHgrRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgJXvCRqzUZ+GoaJ5QHG/yNcORNz0RExsNJS6ZS40Ao=;
 b=Eo3bQhUIx6rNPPH1lH1jwRdJ7vmB07tyckPu3416E+VXILuooj/ZrotQ4MZytSWlKqWuYpOaXQHyqKDi5olWCcMbjeBkqPpCJzM7HGdwgKrepRrmwSblNtnEPjPNB0gS4o4mz8VxVrE/10M/OsuCFxKki0C92gcPA7hhmyY9dFgclTMFO1FCkgReZm8i/0WIxZgByUl+X3gpZ3y3ULGUcCaNPtcfwk95aMSHZVHMnfDiv6VPzpQ+teNYDtUHyy3zLQo3pzzXEGKUfH5eWjhDDu2u7WWpFYubml4d006eUZq4to0NxgpIBn+cHY28ADvldXPubZHXqvqXdOP5xp70kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgJXvCRqzUZ+GoaJ5QHG/yNcORNz0RExsNJS6ZS40Ao=;
 b=3d2G38vlDalWDWEwD0YDQp/Y3m3g5hBmASUhLKF0Jrvc71xb052YMXEzA726Z1FN9bgaiaT4EAGp05G70BYqgWtLx6wG1Z0QskQHAR6+uQsltbX1MPk4Yi1OKJ8fOiSUvQ7Z3UUVoPvwjZgikzgVQaKFflaQ2qV5m3o42BLfRAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Sat, 29 Jan 2022 07:42:39 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 07:42:38 +0000
Date: Sat, 29 Jan 2022 15:42:18 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix a potential GPU hang on cyan skillfish
Message-ID: <YfTv2jyXf7bpk35w@amd.com>
References: <20220128104323.1565796-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128104323.1565796-1-Lang.Yu@amd.com>
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 562ec3e8-0337-4d84-7bf7-08d9e2faec7a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4107:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4107F80648378BA935F58A1AEC239@DM6PR12MB4107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqYyNTHV1/mXiGD/uku/b4cryQ4ubN+zLzORVKVyjGsQU7x6o7H+pJB1Ipx16DAT/Z/AOH3VrtY3RLhdqqyZqfVoNLlL7WUcV1qRfMTsp7CVjGayIGbVp+edsLixr55PAFA8bCkHu9q4O+NQQ2Catw6PSjy70L03ueRYbYMHwISmGs9AjARLJkkjY/UZLhTEcGHSbeSx1CHxTyAj/JowGhxKTO/cYcE8fNs3uE396V41s92ouN//35dqoYO8ZbfTz6DKAngjspf9aALGdvcwX4FIRb3jCLT8KwhZYWJ5I/EQ9VuXs0j7xqgvsdo68fLVDr5MOoNslVnn37tWPDvYCl8TA2Yv7UEADysFh8POQ9Nj6MUl/oB+1puJs7fdCEzzCOetZza9hinllNbh/iyIN6uE1vGSQRP/4IIi+zW6QhFGpqCIWVL5daqBX4pyNx4Pj1wZKZQly3kLyeL6hwfpYHA2Fvfy6/CImogw8nEE8/WAwDctwvqYBDCZANc89QaRI1cKCKDldHoiwg++ES4BCgIMoG3IObdycb1JoE/gKHgHck/+OK4Ucc7XXOVoVW3u0Y2dS4GJ8pUK8NnCYlJMLliZ8nN2+7frK/L8Ov8F0HvRAiYLkdCileQclBBtO/Lj0I3iFogGE5p9rX2SMjG7qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(83380400001)(86362001)(186003)(2906002)(5660300002)(38100700002)(2616005)(6512007)(4326008)(6862004)(8936002)(8676002)(6506007)(66476007)(66556008)(66946007)(26005)(6666004)(316002)(6636002)(37006003)(54906003)(508600001)(6486002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lcyZzZ74r3Bv0WbXkyNtvlnX7hWLNYTCrvRNmJqq9e83deACzTrvRBIq1YdD?=
 =?us-ascii?Q?QmJVbJzlRdZF4puYHsj08ZdCOSsOw1NNUpaxzKm9IR+DPqqEO/gUj/R2jl0a?=
 =?us-ascii?Q?4tPaHGOhuG+a7Gek9rOk0CAJwagEWSSlO+amCXwULO3NZ4oS22tWmSveeNb0?=
 =?us-ascii?Q?os204n8G8IP2iP4u+7WavBNIgrgNaoExfjRt2HdP4bu5FiY9e8b6Lcgu3pEE?=
 =?us-ascii?Q?PbIH6ODNxLl/1gU3CYwGEnsyJ3alz+XmmHg7zNXia5OcjaIZmNLdJCIDC3CS?=
 =?us-ascii?Q?jxap+vS1msLuDZsL6Fg0VhqnPC+HzvXmp0mNVEThIS6KVr/I+/7Wlgv2xh2v?=
 =?us-ascii?Q?pMgrEgvxI413kRpxEu9iXkAFm74WtB4itvQhwiPr2GTJ4Y8OXNmyEIXJRy1x?=
 =?us-ascii?Q?SCYgUJ3kEUmIYmw0DGInGK37FTAWULKI+lnC3Bzfv45INI6db3YGWai2BZ4r?=
 =?us-ascii?Q?fvgbRcnrSm28ek7VfoOh6BPKp47mQQ53lKfRVNKFlQvAl0u0wydRdNStYWU7?=
 =?us-ascii?Q?Uc6hY9itiGXjfadx66Lc0IWDsHiwrzrZkLBQ8e4iLgCWf2YBmleJ2dAy0gOE?=
 =?us-ascii?Q?e8Szf8P6SDfV4nIyztPZyfJteu/qt41umbfzid4cw5yeWsqp4yCfRR7mLtrZ?=
 =?us-ascii?Q?6j13CSdzveCvpp3a3Gv1XTndnLxTBNGwW0dbAIRpU/1qHCT0Lu6WoJvqSygs?=
 =?us-ascii?Q?gR8AmOBOk5Dmih4obS5pVF4ky74jlbYHJhS7AidTH+O9H+7odr5ZNeVfKDoG?=
 =?us-ascii?Q?KPjyktIrH22GO0CIxKY7YBNVPQBw6qSfU9yc8Eyz0JTQUHaQhdj1MZvQlTz1?=
 =?us-ascii?Q?NTt5LK2Cp4zrAlQBpy2ctii7U3oL54i8uzmDimize0KqfLKrecS4fLF1ya75?=
 =?us-ascii?Q?1qcao4bb/LLnlEZtR1H6jeynU/1q1wh5jftttbm7HpC2tvhUooK+NMVsbn/H?=
 =?us-ascii?Q?dr6VBEVPC9Ykb0YzHnPHNcw21eQuKW9HzhPSNVRCuHS+JMBSe7tvFyiOpl8m?=
 =?us-ascii?Q?3lBwv/+tVt6qYw+NAXJoo0b1u6pdDXgS2w3QIJPShLFmiKP2uR/pqJw8a30j?=
 =?us-ascii?Q?Bcd8Vk5D48FU6N+lwIX4HnxBF77OiWM+0GARTY8XU6ZBjAjEHLTOsVweYjiy?=
 =?us-ascii?Q?nAkQGgdErdjrhvJJEOaXfKKCCU92B3tv78loCEDtN0F4aIXxjcEE2f1r8TJH?=
 =?us-ascii?Q?10BkstqNLARBYXpDuKIjsjXKoF2NK3i0XpmzqlGCzR1pi9NbXKQRo5MKhm10?=
 =?us-ascii?Q?G45qqk4x+yH/5rnmQSoHNFIL4uzt2SuAfZWqofbXP8aKs+gfI9Z7w0NEPGEi?=
 =?us-ascii?Q?WGLd7BP2UibeHpZTNHbTeNS+N/Ujg0Z7zv2C9zvQIij6BIrRUzG48Z56xE3B?=
 =?us-ascii?Q?+BxJW4TSjQc6hFzHczjBGdtvrapF2nxK9ewSGfApkj8p+eBv+RcUHHtc+nrJ?=
 =?us-ascii?Q?s4r5/zg7075YXyM8FoKKVNXtImk8vuQHVmXIVAwla7SDIfsvy76zES9maytW?=
 =?us-ascii?Q?F2ih+Oaf9We4xVSdr1wjd8UVY9MGLVZcQDjONzGlsc34dEOGX0aVMdZYXP7j?=
 =?us-ascii?Q?vBBEbFyVfGxgMoTdpqcBqRZZihDcUJAAaZUpCE0mMjIuNqB08sV5RQCtjTyl?=
 =?us-ascii?Q?GtDYDzj9zTAmxFXH4XxfYTo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562ec3e8-0337-4d84-7bf7-08d9e2faec7a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 07:42:38.8349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVZngno0wze+nimrR9Igpo/lFJQgEf4rDB4me35mjoLq9bwuWnOfZ970glGuSDaoREXZbYSCB/vPNWa/U03tMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 28, 2022 at 06:43:23PM +0800, Yu, Lang wrote:
> We observed a GPU hang when querying GMC CG state(i.e.,
> cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
> skillfish doesn't support any CG features.
> 
> Just prevent cyan skillfish from accessing GMC CG registers.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 73ab0eebe4e2..bddaf2417344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3))
> +		return;
> +
>  	adev->mmhub.funcs->get_clockgating(adev, flags);
>  
>  	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
> -- 
> 2.25.1
> 
