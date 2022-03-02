Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F07C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 07:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268A610F005;
	Wed,  2 Mar 2022 07:47:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B699E10F005
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 07:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTiCNXDo2dveAlRNOdCS3kLd4sH8jPecXkGdLFczuJpOE4Gc/2CC19XY7HiVr2Nh/2XJUUAYtcIMSPxvkre0Gk06Vk5uoYj5f6Kco3qauekgIsN6Y+w5a/Ld87zVbjbKolaY3GtLDMmBTeJU5FIV5YmR/bAP27MB7TdNC7BLaT4J0aKtGOskMz2T1JPKovK27BnRIX+kUS+uq8sfsBuqRRGew0XfD5uOs7yu+GkDldRvGU162DNeZ99XRtIwj2z99AfteHUscEAYS412ag/qM2n7kyGDNF4XRWT2AImfnBUSDk4Zi9xK9WHD9RMZdN6RQiL9bXsscuklfNhIcQWjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/I3DnHqXPTUcbbZn+RVMMRiaiMcOHJ3X9Saayhp/y0=;
 b=eG7QRVphLdeUFFCsNRlFMh2S7ORYxfxOaHnr/3B6vqYBfnTUmyX3GSXmoKKfOq55fZ5NHzuJjrnijQxZETO/eIeun2vQ9csZV4GTJm8frDUkGP2y984aNHrYOU2qSumODpItCLkyaAHuj4lHEtCC8UTKsGyDhbTGVP+wnmotaVykxu3eB8gkUZ0fRbRM9NLWLGdhDQ+noth9MgL7XknYH2tYGIhDRugtX5dLjErIXFv7bh/WN6Y0X+LvdDDtqCEq5z+obIIF59EqWM1t8dYPtgxWhBhthTQl8yH7vdaVkSXAM+S0wp6wKPWNHOMVQg4gg3YeBOuM6BhaGrRaj0GouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/I3DnHqXPTUcbbZn+RVMMRiaiMcOHJ3X9Saayhp/y0=;
 b=JLEx0h0KDPNWGQ7vvSGY8Rq76IqNCv+u57ufu2cGct+ay9rpsdQQsmOAeAQqUAEURU1xvk38R+ee0CKAbJN+LQXAIq0vVSBy34D4QMtEF2oEDXq0+XEkn7RkuSLl2L6p+VPTzSjIpxVGZjFKblBh1HnqhLyvWb5SMdB2aKzYo1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 07:47:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 07:47:30 +0000
Message-ID: <082dd387-ecc5-1e87-4664-6aa7da53df8f@amd.com>
Date: Wed, 2 Mar 2022 08:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] drm/amdgpu: convert code name to ip version for
 noretry set
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220301150121.3785743-1-yifan1.zhang@amd.com>
 <20220301150121.3785743-2-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220301150121.3785743-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0042.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bc27549-c6a5-4b6e-90ba-08d9fc20e726
X-MS-TrafficTypeDiagnostic: BN8PR12MB3124:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3124A462826065E9C839A0D583039@BN8PR12MB3124.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eH8pKiV4QQa0rfzRVNEL99y/Qveoc6iPeADGyN4gmm0w7RGgUzr6Oeu786BuSH9GFItmBIvOgOK8LCcYss3Zx3qgZc9z59r5k0rWzlgBp5yme9W2DH4vOn2De1d4rp2RokZxYMaE7nyG3KpES6M7m6ECtZwl3CuIcfm2NstlpH6Lwz1My7iwjnTI61Cff2zg7UvB4k7eYlqzb91b90WYwvxfVFXmQsNcBXYw4ShfXNLWjHf9lDXosB6b7R7r8h3+FGt9HmM3rSNJRbiiqYgIhTNLNCvYPZUPMCJdKe+EDMltUwWAAorXLtqZi3+CQT9diDe/lWu+A0Z3hgAUGyGzbd5lrBBX1Rpl0N29e5FIhO2E6E781iq6AAAos62v9TsvO6AOKQaYUfWlNRWbBYxVd0aq4ibjTPnROmsIhT2PlkH5rMbIGqEeJ7bBPBouvvnRGiD+vbDDJs4gx+7eZwKlddpfIyiuuwogm2oxS66YWvc6hBrcXuAu+95f7bM27+DnXbk4GZWetFW5n6zGwz80MuYOtdIt16EBhy3FzJ3ROXOB3n85ZetcTRkdGlDlauciWJh2N3nd5vs9zYXjsDPuOwFGo621GjdKHhT6bUEHjtqjFzD2HtQyJpmau/exigWqJS/NLKSbvKkssW2rr2Rmxo+LrKlk4cNhOrtk1FmII+zIils/Ld0DMVg4nnkzOjWQQAg3HU1KdSsQP435mwXLKFpO6XqmeKn+nOz/QEeJf6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2906002)(8936002)(6666004)(31686004)(508600001)(31696002)(2616005)(66946007)(8676002)(4326008)(66556008)(66476007)(316002)(36756003)(6486002)(83380400001)(5660300002)(38100700002)(6512007)(186003)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxXbmo3V3FzSE5yWm5EdHloeXNOWElFY01xLzY3YjhGUTdwTWlpRkhMb3RH?=
 =?utf-8?B?azAzMExQT2hoOHlKTlRMNjJIaHQ3WURqTEJGU04zVy8waGg3MW5UMmJpbjFu?=
 =?utf-8?B?OFZXanpwdjdFc1N6a2ZPQlBTNk5abUZjcDJFbTJNTnBLaFMrYVlrNHVlb1A4?=
 =?utf-8?B?bGVjZEZLdmdRdzVSSEVtZm9kbm51cVJpU2ZVU1VvaGY1VVF4b1AzS1FkdXRn?=
 =?utf-8?B?aE9sSVpaMHRpVGtYQ2R6eWNMdFJHU1Y2aEQ3aGtkVXQvVElZSjErdktPeXZu?=
 =?utf-8?B?ZCt3Wi9Od3F3eCtHVEFmTDRyQTJ5Q1N2M0tsaHJuTktqOW9hcjRKRTliZ2w3?=
 =?utf-8?B?RHcrcEhwUnZPeHczKzJ5THJuNTQxQVpOUysyekJFWU44SE5qWEIzUXFSekNM?=
 =?utf-8?B?ZHdqb2tjbi9JbXdjVVVjalMrRHdhQmpmZVBWZ2t4UDhUZmdhQ0I4N3BIWjdl?=
 =?utf-8?B?bHRDNlJ6emtaS1dhT2Z3Z3pWZkhpNFNiR2dBTHorK21JNEREMnVDMlRZaUVt?=
 =?utf-8?B?dzNiR0RPNmo1SFIwdUk2Q244NjhCcEtXeUFwMnB6NWxhUzZKdjBjVmVZYmN2?=
 =?utf-8?B?alppRlRoTXo4VlNUbTBYTHdqOU9FcUU5RmV5YXBBWVNTdXVNM1dIYURyVHR6?=
 =?utf-8?B?ajFCVGY2VWNLOGZyZ0hSRE5oczdOMDczSVh3ZzBXMjZLSE5MZDExVUljNzVz?=
 =?utf-8?B?bE9aR21RVHNSdU9RVWxlbkNDR3JLTHFjVk1GVExkL1g1UmNkUFBMcXByNjZr?=
 =?utf-8?B?NWZBemhYdi9KUTJrNk5LT3NNMHRPajl0ZkE4ckJtNDJHRCsvQkpWZ0lKOFFz?=
 =?utf-8?B?K1FDUzJLNWNYZG5LZkt5U1ZzWDlXVk9NUVJuWEoxQUNKWHY1M1VDYUlERDZu?=
 =?utf-8?B?OXpyWUZrVGZSeU04ZWFkVnZtMERESWYvQ2w4alI1V0xIZFpnVWFzbzFzN21V?=
 =?utf-8?B?TGNHeklnM1ZIdGtFSGdYWVRHeUs5OHBGNWV3aElPdnpDT0VybHllVnA5RVZQ?=
 =?utf-8?B?V0hTTUpzYXNGTUt4Q1lNN2hkYzZXVkFSRHBqVi9Ud2g0d2RTdmxNWm12bG9n?=
 =?utf-8?B?MFRiU3FIRkF1anVsTm9Cb243a2s0aElvTGRrZDJveU8ycC9VdHpRSzZGOVNG?=
 =?utf-8?B?cUVZZW4yY0tndStwZm00VXI0VkJOSEY5U0hha1NFU0pVd25PZnY1YnBYZHMr?=
 =?utf-8?B?clZHaGl1S29seURsWGx4ZnhJa1hwSVlLVjdoOVIySmtaNHk5LzZPck41ODNX?=
 =?utf-8?B?UlBwMHpXbEFXMjZERm5NdUpDTjF2RU0rUVZFcXhpTUdpckxiM0RFTHJxcUdV?=
 =?utf-8?B?T1QvTWZnTlZEV0M5YWg5WUZTamptdUpod3pWamNRMnZUU25nbm1qNXRzZHIv?=
 =?utf-8?B?UithM2YxYzgzZDRxbUQ4N255VWxtYUFQSHpaQ202cmlsdDlpSUdkT2Iva1du?=
 =?utf-8?B?NkVSNi9PaXFkOTF0UC83RzVxT2NxYmxGMmVZVXFKQkVaZHZybUFmUHJWU3Zo?=
 =?utf-8?B?VlViOFB5aGt3NUFRdFpad2QvN25rMFZTUVBZMmVFK0M0eWxRMHYrbDJBaVIy?=
 =?utf-8?B?dzZxcHByMzhTc1hhcDRlTjNmR0VRbGs5cEwyOFRYbHZUeW9UbW5WdzA4Z2Vv?=
 =?utf-8?B?dzhSQW1EckFVSmZHVTdoTDk1TE02SUkzWTJtS3VlVStOQkFZZTlxalI4cjNB?=
 =?utf-8?B?N1RWUkd4NjZFOXpnb3V0M0RuWVhYYXZBRlI0TWszOHBlV3Vkd3gxUjlMdFhV?=
 =?utf-8?B?RkZ0bGFKaUhJV1d3L3BVTml6ZTFYdG1nZlpiQ1c4aDlDRUhhOXdoRk1DY0l6?=
 =?utf-8?B?cE9RYkxjdWt1ZWJFYXh5YnY5TGRyb0U0Z3hJZzZaSytEam9lcHFCeDd1VkdX?=
 =?utf-8?B?b2QxQnRONVJsUkx1d2ZJaCs1QVUzcEE1Ynl2NDFSZW9BN2h5STdVby9LaTJ1?=
 =?utf-8?B?b2JxOFU3ZE5NMVVNRCtYWCt0YWprMFhab0JLSFp4RmdzcVJDZGdkQVZwdDlF?=
 =?utf-8?B?Q0JMZHlnVktRZHdOYWJnKzJ6SCtKcjhOMWpKOUhoNW4wUGxvSDI2clZ1Tm9Z?=
 =?utf-8?B?RDk1aGtzMFdoOUY4SVk1OEhNTWRQSGZZUkltclhDWGpCc2NCaDhXMi9ldGpO?=
 =?utf-8?B?SnJ2S25OY2lrcW02MHlQZWhTL1FwUWVmV1o2MnBVMDZPa3k5cC9zdHVQdVFZ?=
 =?utf-8?Q?ygaz4BBnx1WnC0E4FCqfoyg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc27549-c6a5-4b6e-90ba-08d9fc20e726
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 07:47:29.9196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewC9i9Tb/hpNo+Dt+OOMdQXBEQdDMGFLsHbdNkW2A7gFj2ErXhIcl9iMxgvRAR5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3124
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 01.03.22 um 16:01 schrieb Yifan Zhang:
> Use IP version rather than codename for noretry set.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ab75e189bc0b..fbc22b7b6315 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -559,14 +559,14 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_gmc *gmc = &adev->gmc;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_VEGA10:
> -	case CHIP_VEGA20:
> -	case CHIP_ARCTURUS:
> -	case CHIP_ALDEBARAN:
> -	case CHIP_BEIGE_GOBY:
> -	case CHIP_YELLOW_CARP:
> -	case CHIP_RENOIR:
> +	switch (adev->ip_versions[GC_HWIP][0]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +	case IP_VERSION(10, 3, 5):
> +	case IP_VERSION(10, 3, 3):
> +	case IP_VERSION(9, 3, 0):

Maybe sort those?

Apart from that Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>   		/*
>   		 * noretry = 0 will cause kfd page fault tests fail
>   		 * for some ASICs, so set default to 1 for these ASICs.
> @@ -576,7 +576,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>   		else
>   			gmc->noretry = amdgpu_noretry;
>   		break;
> -	case CHIP_RAVEN:
>   	default:
>   		/* Raven currently has issues with noretry
>   		 * regardless of what we decide for other

