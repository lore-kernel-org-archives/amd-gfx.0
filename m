Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D662FC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 06:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1A760F92
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 06:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D1A760F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B84589B48;
	Mon, 30 Aug 2021 06:17:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B8489B48
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 06:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afuegmp2x5lszq8cK8pfKz/cwO9uTc7gt4BZCh1XgdbOLMizI81e5MH2L+9kVUK8k3zLzNbXhz9m8H3nuH9/8cNM9kMEBTqXf2nDwOy7h31raDnEgEcAuAmVhgDYCSvVyDhAw4GPNJ9egPFrm8aqZdyAYo21SlFAY4NEtHT6z29+llBTIe9jAnRuLW+UrAW4Xgzh2PQqczYew2S6CXs1D1NRqXAeAY6cbJXiWWbIiuOZ4GL0XrlR1g6xTG4kYutE2vPlMT7Hh5msfR/Y5g7dsNzQW0kYjR32WE2y1KPAaVChFLlgEdfVlnGRhRpTtvWRRVpwd7UHYD1C0PVR5gDokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RYH9ly5fS+C7aRYJffRpPzu2k6v9mtvr2aQMeVPnJA=;
 b=Xr5mQB5zw5jRmpOHloSCSWc+coz4MfzQc9Np+gpJnspmb5J0HvDF1gliFfW0AbDFOl4SP7sYPbEL4rEgnA99AukoYx9xZ3VOWfmsPWe7djZ33obNwASppf9n7PSeDgQD8FiFzSPlkt+1MyBmnmWrTQrmEf7pYYkoiiSemZtkW46BbiPHUhPR+oWKbRBGHkqgMf4EY22Pu2A3SaY88oqMiAw3mZn//QREjGgHHnQVbdd9fDz4CrJPgJ8UxjMNzdVH26d17liX7mhuDzy0VymIHqtJYUxFDKwmkmCWw0M0bhoKJBT3IfKS/6dOWYutjIi3yONYi3HiDa20Uq7aI+hH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RYH9ly5fS+C7aRYJffRpPzu2k6v9mtvr2aQMeVPnJA=;
 b=r6411v7zKgXGK/dnMH9/r4Fvh34pJJBk38a7FKhAF3nq3QsBT+nyTboW6cQ67XIA/cFInNIN+L7C3fATPVj3EI7HHWXNJMupbVslYS1RwsmQKo/+nled//YyP+QISG2gsUJa4K5q7DuRWG99+87PEjFi1xVU6uLZQFgMryX+1Dk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3727.namprd12.prod.outlook.com (2603:10b6:208:15a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 06:17:48 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 06:17:48 +0000
Subject: Re: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini (v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, andrey.grodzovsky@amd.com, mike@fireburn.co.uk,
 alexander.deucher@amd.com
References: <20210830060855.12583-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7c472a80-9139-9ef7-8b22-a7b925c2fe89@amd.com>
Date: Mon, 30 Aug 2021 08:17:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210830060855.12583-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::42) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR01CA0101.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Mon, 30 Aug 2021 06:17:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e80c964-3214-4e62-c135-08d96b7de34a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3727:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37277AABC1C5C48DD7A489B783CB9@MN2PR12MB3727.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/+YGjkmwpNkeNDK3KaD+tciTmxJ+aNEwKLQSa72o4H92jM8Y83CIdxjufRblagAxehj4Y+TGU9UXetwQFVPPRDcGu4cKRAxFZF1/DUyy6jwQ29n8EDTVkeo5GzU1xYH5PPYSYWnwnb7rZNIVOaj6cyj6FdufjGDFR344D6MCTj94WiLTEuqbegCO8j+dYxq2p+LJ3gfc/3+6USEAPs6xlfEQv79A/QH2fwykKUy36RBYEmgr9EOVNufrOKmaoXuDyJi/G7RJvo2Cs6oO9UG+zXaM6EnemimbMXeaL/ShWJ69eaBY3cKLyarY2JElsh/EJq7p+kK8goky4/LS8JjHIH92LL7Dhs+j99K4dRVp1+G+Zidqww2uSu+2axv4Nre6p8QF+V1104nuWLA/WN1ThCVOHJfQwHl5Xo5bJZwF0p6kJceCX/MNL851J63JZIvCl4bgCOnCrGezVXnFon+6PPRAFx8HuGEnFrQvvXt94ytMySDULwPAX/IavdcmXoE7wJulXctzp/hV5poLzhf3UtR5TM7HoAVXdZkYOwASnudw/ENF+Kd0h7pf33DJkttZppstjikg+9+24qadtB7kotrxVYweCAbYJY1hFK2MvytvoEIGg4NhQgFwCwvLXMRhjGuiubRPVIKzhJJXOqiA6/ty1WlCq0a2Os8iOM4NLGgNmcBOqsnLe6uGQAnYxFgIQxptZ2vcKeQymZfr7AUkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(2906002)(956004)(6486002)(2616005)(6666004)(8936002)(31696002)(66476007)(66556008)(26005)(31686004)(66946007)(8676002)(186003)(38100700002)(36756003)(16576012)(478600001)(316002)(66574015)(86362001)(83380400001)(6636002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVhraklYZXNYQTdrMWtEdFZlekFIWU50R1FkRjB6MmpJbFQ3Rkpjb004QjJn?=
 =?utf-8?B?b3dqMWtkejFaVmhBc2xxczgrOHVWanE5ZlZ2V0lLc1ByOFZna0xuNGcxRjh6?=
 =?utf-8?B?aDBxQ21yNXFHVHBha0JhT0hFQ1YxTUwxeHRWR0doV0xtK0ZRenc5Y3BFWUF3?=
 =?utf-8?B?dXdJL0svdXF1Vkl4bjJ0OEFadmhVWjhMRXZVQkN0K0svdmZnRHppWTVMcHk1?=
 =?utf-8?B?SklIR0lMNklpd1FyWm10MmJpaFJLdzc0YnhvNHA3K2cwcGNrNHJ4eitYeWRD?=
 =?utf-8?B?T1RLKzdsN0Q4NGUxZWtzNFE2TnFKNjVPS3JJNTEyKy9GUml1SFJKT09id1Js?=
 =?utf-8?B?YkZGWjlWdSt3Z2ZZaUN2VkJ5dXovS1BNUnJrbTNpYy9ubVNxTGs3eGxNbDc1?=
 =?utf-8?B?S3NUMjdPQy9VOXczWUJoVEpORnVxaTh3eTFmTEFjMjl5NmkxSlBkcCt6TjJh?=
 =?utf-8?B?OXZPbURKSGJXdDlWaFVkRkJNNFQ4ZGFMKzlvOXFJLzJQOHJ5ZXV6M2pVN3Zm?=
 =?utf-8?B?eUV4VDQzRmRrRmxkTmF5QWNJeHR3b1F1bXBkYWZkUzNBV1RzVEVxcE9veEJ6?=
 =?utf-8?B?SU4vb3hCZk1TRUFzME5yT0xxcC9uQ2dZRGNOU1NEWjFEWmsxbUZOUDdWc3Fw?=
 =?utf-8?B?RC9aNUVaT1A4V0xaWXFUZm9HQzN5VTFDU3pMbjAvRlVQdnVJZmVxbC9uNFdW?=
 =?utf-8?B?ZHJrRlh6WkJMWSt3VEs2aUhBR3JUTzZ6V2UzVVNpVkVlek54RjJpRCtQZjlS?=
 =?utf-8?B?NDBOVnEya1o2em9nYVFnalEyWDVoZmhYLzM0ZmFNcHdtbkZUOUtaTlBrQkg1?=
 =?utf-8?B?c3VUNnVQdURSL1J2c0YrWUxYK2M1dUx0cW14STJqd2dqeUxKeFBRUmZmMHZU?=
 =?utf-8?B?WG15d29HTmdaZDM2bk5rSXRVNDA3RFg0NnY0YmduWHZEUzhtTjdHcFdVWk1G?=
 =?utf-8?B?Y1JTYlpqR3NsZFpibFVUeUtqM1dsOEJiYzhjaUJLcC9JSXc2K0hpaVpKbVpG?=
 =?utf-8?B?Vk5ya2hCUDZ3THRRelNmOFFBZFdDeDRWamYwUFc3SXFuaVdGT3ROU3Exay93?=
 =?utf-8?B?SytRS1d3R2tNSEtIL0JHSzJNL0FqckNJc21nZFlHc05vQkFwclNWYmhUU3Rn?=
 =?utf-8?B?SVN6ZjNNZ2pabFdHNm81Y3AyTHJPYkFnTUwydjBIWjhpZnhRUVMycXFTQlhj?=
 =?utf-8?B?TkxnQk50MlFncEdlMlJYMjRrVFR1Wk05VGFneklVYW9wRVA5ME5PZXJzWUdw?=
 =?utf-8?B?dHJiZThSNjY4YXRvdGY1TkVJSVhGQUxOVE0zWjV3ZGUwdEkydUlyTCt0RmRt?=
 =?utf-8?B?TWR3VENPaFF0aTc4VnlPSTZYK3hRT2wxdHVtNHBTZVJQWmQyRU85bXpkSU02?=
 =?utf-8?B?Ry9hRC9ZQzZoNXJBMkxQWFNzVC81eDZQeUV3elRHWWd0U2F3Mit0V1dnVXFP?=
 =?utf-8?B?eEtiYWM4NUJHVmZjV0VrbDZRb3VYTytzVDZ3MUZ5OHY0V2dYbUJqUE8zL21N?=
 =?utf-8?B?Zjd2MWdVS2NkU2psVFBiVFY2MEh0ZjhaNVdjdGRhL3RFVXpUeS9FQVZ1R205?=
 =?utf-8?B?L2czRzhidC9CMlJldHpYbUlQMkxRb1hPR3k0Z0tPdWw0dndQcHRBbGJJakhM?=
 =?utf-8?B?aVd5ZXNhbnBsTGJObG4veGRNK000bGlvQk9OQWlBMEhvSG5SU2gxNkNxeTV3?=
 =?utf-8?B?ZWs5eE1PQk5PRmFFdHBib3pmYXZKWCt4RWRDS1BOSEJqZW5NNzEzSE1nYXdh?=
 =?utf-8?Q?q1nq9B38bBksJzfTcKKH7Py6nnA5chect5xN0Ff?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e80c964-3214-4e62-c135-08d96b7de34a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 06:17:47.9506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcbHVwTpBoyr2Hnszv9mssEypyfDf2m6jvK9tqtbZN4YZXfYjQskcaqpg+mPQuGz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3727
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

Am 30.08.21 um 08:08 schrieb Guchun Chen:
> This gurantees no more work on the ring can be submitted
> to hardware in suspend/resume case, otherwise a potential
> race will occur and the ring will get no chance to stay
> empty before suspend.
>
> v2: Call drm_sched_resubmit_job before drm_sched_start to
> restart jobs from the pending list.
>
> Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index b439eb7d4177..fd4ba076ff8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -552,6 +552,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> +		if (!ring->no_scheduler)
> +			drm_sched_stop(&ring->sched, NULL);
> +
>   		/* You can't wait for HW to signal if it's gone */
>   		if (!drm_dev_is_unplugged(&adev->ddev))
>   			r = amdgpu_fence_wait_empty(ring);
> @@ -611,6 +614,11 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> +		if (!ring->no_scheduler) {
> +			drm_sched_resubmit_jobs(&ring->sched);
> +			drm_sched_start(&ring->sched, true);
> +		}
> +
>   		/* enable the interrupt */
>   		if (ring->fence_drv.irq_src)
>   			amdgpu_irq_get(adev, ring->fence_drv.irq_src,

