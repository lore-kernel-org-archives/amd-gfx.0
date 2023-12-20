Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D23DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 14:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB5110E5BE;
	Wed, 20 Dec 2023 14:14:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF5710E5BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 14:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdp1XdB1ch3nOj1zzan7LCD4I+rO3RL2TETUYdSBOHsMSqDzA5n0ZiZIbl5LneYD5+e5Acix1Bdrwv30xREIWZoG7qlva8Xo/VXnV8MK2fB3K6v7st9shhCuizlBLIXmQZWDqP7SThzDhJM6ZVbpe6sNGrsLk7U+zJ7CG7MmcATd9inMSAQX2kcmqGVa6X2NHTZefeoYoGd7htvA2wSTs9Y0GxQlsQv4+d4kuHfCsB54hQXyDAOuM98aH5zJIRItvdGLGDuVSK84wKXFBJOEQilo0TD9H21Boi1Ltm/1Ak1dNd+VOQmyLJHQV7VLya84ISOHCzAOg5OZBCi/C0qVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdaeir8Nlmv8aVAGIGO73zmt4rPsaYP9r4+GaDdeOsI=;
 b=kWzEXDFclwLR/vokOfO33vfeT2UeV+ilJlfYT91mTaTqbi/kVdQ8cJrM56AtR1nlpPPrRqNiEUDyDcEEmeSvi6/S76lDF06Mlxnfajb8Re2t7l6zlu12odizXYMJhSn3jrr/vEZOcKSD6ROBhFExvYj+FVVqyrStRbk3nNzmYliMPdQr2LqCiAcOzUH63vjy72sVXo62D3Y79ZBvakTb7SGcGfVvITcP6CkXKlcPa+TpHTdb5meAnWUIAXY6LBw+IpACmJNEcLCzMYo76js8H4vRSVdv10aq+TIuch1qr+nf7EjkjFvAglc0247LeBlufBuN/FFXrNaemGAfB18CZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdaeir8Nlmv8aVAGIGO73zmt4rPsaYP9r4+GaDdeOsI=;
 b=IIg9eldmEh2iTyZE7KfAzPBykXLJuXnSwt6wy6Cl9cPI44l4f/ZcV/iEQu7nAVmi7C/6TqDJwntUXrHj+Yxa0f4da24JCl71EnAcdZ7J2hbb+4fZNIwaN2+k0QCEqq8Refpz3R1OY63VCSvVQnGYT2g2xftr4ZfYo9nwVVcJsfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 14:14:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:14:03 +0000
Message-ID: <02503452-0dbb-440d-8ee6-9764a152da09@amd.com>
Date: Wed, 20 Dec 2023 15:14:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use kvcalloc instead of kvmalloc_array in
 amdgpu_cs_parser_bos()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231220141028.953132-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231220141028.953132-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: e124732f-4407-46f3-41e2-08dc0165eb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a91SGSbIQjX5z5wrZ7BW3/gv7hYqgRsSpRA9ZavHTQzPwnHH7nHVn+a68zGDqFClZf3SdpH2R+ChfCsOo+kmWujOJpkNw9AsJw+GakBK6aHX49C7mqMKJkrvVv91lvn/0aBy2GNqN2E0fRQqT6Yw66lA0cAwT5TcCFSbuG2PZY+jWXmukSehd9O2385RC/wJqTYYSybeRpQ7UmJNGztn55uRrMfZcdS9/PZ1n5e2kGFoB808WF/2AO6aOmCGevQnXUC6B9+9I/qUSl5Z4AZY0f4aLg+Mk2UjXanQn/2LDqpLLZvMpJVHT8/fdfSsjoMORt/0VJkmK8M2Xn9zDNtiKK2CbekOtgmUE2raNnPbnvviszPIM8AGbVbE9zzvq7pjSf0uCVdXd6rD9scVuY9Yi/siCVAjWpGfyfEpcGOqM/PBdSpNy8+wA4+N3kYw8do+BOmpIsd7SQwy3rHyZnWYok5v+4ISlW1yqjaGl6+NC09Qon40EC44k6ZZtTmafK5/jjvpKgIcf52BJTuziqYmUmb3/wemYwU7ttDT5Rr+tgcfQb2pOL8X7cOFBEEfIoiJ8asb137LA5trbI3KzeAwcFCc2F2N8CKOoPhiAtPq6Rq6HPgVTiWe12HkIaV8dKI8GpJUML7s2bl8vJciy1U/dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6506007)(6512007)(6486002)(478600001)(26005)(2616005)(66574015)(83380400001)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(8676002)(4326008)(8936002)(110136005)(316002)(36756003)(6636002)(31696002)(86362001)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHgxaWFzcGVSNW9FWE1pRWVmb01PSENUbGlZbnVVUk5VRWFVRGVsMkRQTjlH?=
 =?utf-8?B?ZmF5cld5aVhQWHBQSnR1WTIrWEExL1dUQ1FyU0tiNUtkVkxQbzdJSVBVYjE4?=
 =?utf-8?B?b0NBbVBiUjREWDJ6Y1pFbUUvMko0QlE4eTdZcER5SXpVMmxCR1I0SkpEcXU4?=
 =?utf-8?B?Qm9iMGNacmljYjQ4MWtDSU96d051RVgwVm5kWTd1Mmw3S0pjeDFERER1Z01n?=
 =?utf-8?B?VlBFSHoyNXVvVTFPWTlidFJBZk5uc3Z6ajdDazBNeVVpV1NyaGduam5NSmxq?=
 =?utf-8?B?SUZicUl3bjhYK1o1b2FJNmYwa0RqNkRzc2RBbVRWYXVZN2dUUkJjWEwrOS9Q?=
 =?utf-8?B?RHB5cGxQL0ZuVEhOQ1FYd1IvK1VRRWU1OUpVL1hubFRHbURLTWl6UkgrVVNT?=
 =?utf-8?B?YXB5d1NteDZFbGhNWkZwRENDWFpRRE9XRXRVbjFlSFBBenpMeDlaVjNQdVYv?=
 =?utf-8?B?UFBKTXpBaHYwY091YXNLTlBjcGxvbzZFMHRvMDdSakdWZEE0RTdHNDA0UVI0?=
 =?utf-8?B?UUh2dkp1d2lsc0VKYUdDcVJmWjZyTnpDZ0ZBM3VQL1VzemRnREIrR0tONHY3?=
 =?utf-8?B?UDVuNjJ1K1pJS2t0Y21ZUVQ5MTF4alphREMvSVpNR0YvQkNya3lFUEcwT05N?=
 =?utf-8?B?Ym1sR2VEL0lEY0dNRzh6N0p5WWlsekpvM0pOVzBrVWxFNllUd2NUem16MzV1?=
 =?utf-8?B?SnRYNXJPQ0VNTG1qMEVjajhidDZhcVpzYlM1TUJHbWxPMU1YaFpUMCtJUXhP?=
 =?utf-8?B?OXAvK3BLdTIxaXE5QllRUUdQQjVuNlA4dndPeDZiVXE2d24xaTlidHUyenpu?=
 =?utf-8?B?VUdVQ0U0dmRRN2NqZXBVdFllbkRNa2RzV1FSYmVXajV0SjdJQURvckpOdUgr?=
 =?utf-8?B?b2hQR0pGaVJMbkp5UUJ5V0hOUnVnVFBwdVlFUm1oT0l6MVIxZDYwN0J6NGho?=
 =?utf-8?B?bmQ1T3JabU4zbnhLU0t4a3lmVjlydFQwb3hGczdYWWt0RnRqb0s3NTMydjF5?=
 =?utf-8?B?aWlRUWhZRnhzSmJxOThmRVFzMTlRMWVaNTFCbzRwNmlwV1B1YXdJcm05dFhX?=
 =?utf-8?B?M1RSY1prbmpTZkV0N3NWRy9pTGFUK1ZjS09SaExSNFpWOVBjVzdqNlMvRHpY?=
 =?utf-8?B?NnNFMFE0dlQ5b3hyT0lzNzhncjUwbkp0RGlUMDkxeTlQaWRmU05uUW5lV051?=
 =?utf-8?B?SXJRRU9ZSUJGazJReUdid1htMFhnMEJLWGVQVjBKZ3BCcFdwbjFlT05oTGdv?=
 =?utf-8?B?MkQ0cGs4Zkx0UUZQbGFkdTZrU004d1BvanFjQjh2RVNOeUVKSURya3pIYlFV?=
 =?utf-8?B?UDg1c3hscWNNZlQ3cWgrM0hnK25qWWZUS1k1T1lucG43WVlQSkczalc4eUU4?=
 =?utf-8?B?UlEwbzgvU0hCZVNVMU11M3FybE9Bc1BTL1VoUXRxNk9lTGJzNDkxWUZQbFFR?=
 =?utf-8?B?SDlrRjNzMjdmS2NVZWJSdjdHQUQ0eVBMVlJDUytDVEN5aWNoQXYxMkZZbzJR?=
 =?utf-8?B?WHcyaldFOUNaYmZhdFFSMWNQUnpVUkFydG95OTZEV2E3bUkxK2lMYjM3Z3By?=
 =?utf-8?B?c0dtRzMrUVRoREttVkFVcFJiOXk4aTV3aXlhb1J5WjcybDExUDh0SGd6YzJH?=
 =?utf-8?B?ZEVkZXlUNGJIWEx1UkVzbWI3WHRPNUFUa3JlSFdJZ2pyb1R6ZFdEYzR3Q21l?=
 =?utf-8?B?Um9tdjQ1MlJqcHJXbzdCSlpvcWJ1dGU3VmpwK1l4MXpya2VrcUxMeXdyeWpD?=
 =?utf-8?B?d2hTMStybU9Fb1VtYjNQU205ZFJGSWN0bisrVlpDa3Y3WXpYc05VRUxkU2dx?=
 =?utf-8?B?WGRFNlVyWksxakR1ZkwwTmtjVVYwZFBSY1NmdXVZd2lpeUhZeHhhdTlEbmZR?=
 =?utf-8?B?MVViOHhCQ2VPNjVibEhYVXNudkFVb0lORHluL0xBZVpndEx6My9LakRpMDBv?=
 =?utf-8?B?TzNyaDFPbGVabFhjQ3IvRFFEMFk0RnoyM3cxSjFIZUorUXlGTW55bHA5cUNJ?=
 =?utf-8?B?azBEYTRVdUxDaVhLMmZOT2trakZHMXEyMVdpeDZsV3ZzMXZ4dHN2c2w2eWdF?=
 =?utf-8?B?RTRKeThwK2NLS2lTMGNiSGlkQ3Jvd1h0cTBxS0d0WlBPZEcyeVRXMVBKUjdF?=
 =?utf-8?Q?dhUADqBtgx+kcCS6lE9Tfoyjl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e124732f-4407-46f3-41e2-08dc0165eb8f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:14:03.7227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXbKJM6LTP9N1445n3MpxFsTBi6ix4AwVliUlErdc9OodsN3mlnfuNiYVdib/qMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.12.23 um 15:10 schrieb Srinivasan Shanmugam:
> kvmalloc_array + __GFP_ZERO is the same with kvcalloc.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:873 amdgpu_cs_parser_bos() warn: Please consider using kvcalloc instead of kvmalloc_array
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index e50be6500030..83c7fc09218c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -870,9 +870,9 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		struct amdgpu_bo *bo = e->bo;
>   		int i;
>   
> -		e->user_pages = kvmalloc_array(bo->tbo.ttm->num_pages,
> -					sizeof(struct page *),
> -					GFP_KERNEL | __GFP_ZERO);
> +		e->user_pages = kvcalloc(bo->tbo.ttm->num_pages,
> +					 sizeof(struct page *),
> +					 GFP_KERNEL);
>   		if (!e->user_pages) {
>   			DRM_ERROR("kvmalloc_array failure\n");
>   			r = -ENOMEM;

