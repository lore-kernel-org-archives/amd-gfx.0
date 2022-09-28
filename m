Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97E3C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4C810E51E;
	Wed, 28 Sep 2022 17:44:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B04F10E51E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJdGy4hnYObi4u20GqUhnkO8SgKFfTRP+YfRxyXnFmPXrvEllz39hu9Lq6vCIvVsyboQ1lFu4aTSWS1nWJzgYh7dHtr7V57IC9EF9RY3bEW3AQFDwpB/q2apzOmIB/ZP0qx4UyBqw5rgrKpAhi4ALjLedSPsguoJTrqsyKGlfffK7XPRTPQArTJe6NBRG9SJGsNASQJljmpSv2Aj/3I4DLKlJl4nrfaaty4WEhooMAexPTfX/pOrJqp/QX1074QUtb0DumA2ei1t89z6rEThkES84+pZInJ6bW39HE7GMnCVgSeXvzaxJYOwUhowsw966cDQN1Vn1UR306hGLV5dqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0FyeR4E48bL3mLJ7seQKUczfp9oxHQ02IP8z3ZJjKM=;
 b=YbTns7l2UfLH6oO/7+CuaoVTxgd4MJEbvK0VBCyv6dyiwVer0/AoHXCPO/B9njPK8/U9EToH8rDc8BPyo3x6ryBzamBooEoNpHh3hsVuSZafPsRknfxyL5uDwAEkIZnRZIm0O6K2/E+ag8XKS6ITzgg0Dw3M8GfP8xG/z437VJiBuefqRrFK2hlDEXwmyTI8nH9hF5n6xWDWBSHuk5bsBanwPv1lIlJWEgfdAebLQa/LbONXFGcQNJ4IzOAeqOMTnl5ILAHZKz7hn1oHb0BPpJoACNu+Q5iBNifIqgujEQzlEn/3R5dtUhhFiFkf5a4hl9+IZiZHDaPNw+PK+LW/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0FyeR4E48bL3mLJ7seQKUczfp9oxHQ02IP8z3ZJjKM=;
 b=z6uB8hbCjj7LEQMWKbnENU4mggbg2kuVNqTNDqvpvVlgzQPez3P1qkTvafEBx87aOHT30z38+giZBhBKZHnuktZPuvxC30Fd7tmqjy9iBcN2/Hr225T9Nct8so6/tFk4SKm8KMxp04Ijf/NM9o8k2BZzIzJrQqvVCH7vYQglnNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 17:44:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5676.015; Wed, 28 Sep 2022
 17:44:28 +0000
Message-ID: <010813c9-d415-45a4-fde9-9c8bf3966ff4@amd.com>
Date: Wed, 28 Sep 2022 19:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Content-Language: en-US
To: Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220928173733.12457-1-Vignesh.Chander@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220928173733.12457-1-Vignesh.Chander@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:50f::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca3e4e8-fff4-422a-6882-08daa1791709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dw+eb7/v/3K/fiet3rhewKoi34knDQbYOqgQfNfREDp/DtsnwMZUtBFtnSOKtWzv4XTz8p7I9jsLh6CKGYEcF8HhJpgZnu1pwA199RZ91KiAOUQq8Fzi222W8sUSiaMCc42CxtdXyr8AUzEIWYFjjOe6wwPEGoy8GNGvIQsMJPi9CwD1cb2nmORYga0gmczSe0zn45zlcXkO9jIMb6Loh+WqPLwXJQPqRTrD3fUzMmaFOgOA8+4OEdl6lX32sIaEBnEX7mD8EErPMWLZKBe5nYsx5Sp6wixErVIm0zmb1hGMTX4jczhyBErBcYkHyIgk08t46SE5IS+XJ6hF0auafbd9pGVYt8SKpYG93hNkiPu0xNftaQqKH1bmgqOZjTFqzfJXn3I2sX0H/74Td6DhwuG2Dj8UHFgTuPnxyrS2egyngSREj8vkX5w1UmhhkGlTBuAuguQQO1VH+WLCHbJs4A9HOAD9ssC4YrNNJs6e8a/zX7Y1NxaVYqJ2RBc3o22uqAeSt+ptIqYU+cSSJ35lNEN0wckWTIaUn7puXGNALJ2TuTFNH6fYMQOht6kqpE/zKcxsPmMRKvAukq5u30+ULxL2wgTg+N8/V4F8mTqr+zD+w8KDiEuRNS9YO0KAjp/1HUV7pj///7B1O5hloStxphhf7eElZEbgF4fUALQfzuAdu+QZxA0noKXO6qJT+i9kbRnggOINX+DNd7vX9tTSETlal+BzSzd5FPD9nrgBExDo8S137KqTDCkyuisGtCkNFFqbBrBb9yWrtlKozzS5gl+e98xgWRZSJYRS8m+Vg9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(186003)(4326008)(2616005)(31686004)(83380400001)(66946007)(8676002)(66556008)(6486002)(86362001)(478600001)(5660300002)(31696002)(38100700002)(36756003)(6666004)(6512007)(6506007)(66476007)(41300700001)(2906002)(316002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anM1Q2gvRDg2WDhZYnJ5bE81TlNzR1djRWs3NzJXbzJRRlR4bVhsTUFENGc1?=
 =?utf-8?B?L01EMW05UzdBV20zQXhmQUtOL1pEN1JWNmdnUUw3RWJvSHBOd0Z5MFpTd1g1?=
 =?utf-8?B?R2pkN2hMSHR5M0c2UThqRXhOcmtaQ2JzakhrTzJlR2RZMTRoRE4vcXZQYTVY?=
 =?utf-8?B?SDBJUy9ldG96K0h6Um10OGpVR3ZYWlMxRWtxV3h6QVNyVFozRzByKytaQ2JG?=
 =?utf-8?B?UlFjM3hHTUkvb0U3YUJFcjliLzBKWExhTzFTNTdML2RkeUNLVHo2cWNWMTBR?=
 =?utf-8?B?RlNYeWljb0Q2VXBmeTkxSlAwTmhLdlZCTG5pdmtLMW5nOTI3UW1GYmM3T1Fy?=
 =?utf-8?B?bGZhOGh5SDVCdk1KZHpITkY1UHo5Nk15UjJFYjZWanF1TlpDYkZ6RlQ4akhY?=
 =?utf-8?B?WGdzam1QUU0xb3JBK2NjdnBZNy95MERYVUxZQ0laVW1zVWRaQUdBR1NyR2Nh?=
 =?utf-8?B?Tm0yNmtVV3I1YWlQajJDMkdjQlo5Q1VKblA1b1R4NDVObjhnekgyYyt1VkQ4?=
 =?utf-8?B?aTNKYVVZNFhZN2ZWU0JQM3ZYcWNhcWdlZGtpWENMeXlmdTg4SGFuWXEzVG9q?=
 =?utf-8?B?TDRIK1BVaFY2d3o1bUtLK3pRRitFQVo0dko1eEthT1FuR2N1ckFtcVMrTitB?=
 =?utf-8?B?TzBaRW43SG8veHJFRnVzZzJPODR0S2pxZTZ0eGNRYm9tWi9KVzZlSC9rZ0RE?=
 =?utf-8?B?YlNVZUtYQWlGM0ZGa0lSdmRUckk0a1BpelY4ZjlwUEJXZG9ERmhHS09DWkN6?=
 =?utf-8?B?MXNSUTZyaXRpVzB6Nk9BRC9JYnN1eFA3RzUzMExuWjZEV0JXWHRvU29qN2Q5?=
 =?utf-8?B?VTVxaVpKa3RPb2drcnd3YmFaZ0gzYVFiOUt2TTNtMUpRMXQ4OHBaZlF5UytH?=
 =?utf-8?B?WWRxdCsvTHZUcXQ2ekJaaHVHb29NR2hDWUxtaVpQSFdsRGZFWENmS09mbS9m?=
 =?utf-8?B?YUNSTjc1Wll6d3F4cmhrM2tuQ2o4WUIvYXFDU2p5d0pxUWdwY0ZYM0Y2Ui9p?=
 =?utf-8?B?U0tXbGlDYWczQ1QvOUJQcTJYazBuMlBsaVY1UTdVbzRVeStOUURVUlN3VDhq?=
 =?utf-8?B?dmZpeldVVUpNaFRiMC9mcTZqL1Q2eFhULzFzUEt0eTBzY1AvUjZveGVLbnU3?=
 =?utf-8?B?VzhPUGN2aUNvbU9pVThDRG1PdjJqQWJGYXp5a1huSnFKeUszN01iUGY4TTQy?=
 =?utf-8?B?VVBCM3o3QzJkSG5LVnRrOFUrYVA3bThVOStTa3NMQTltTlhaWmNKdnNRTWM1?=
 =?utf-8?B?Z0R1OTk5L0FRTzYyUWdlZmFBcWpRRmxIUTFGTndFS1NSNnBKOERzR3VmVHNn?=
 =?utf-8?B?azN6bU80Q25qNlNKRUU2eFlnSHVSdnQ5SG9WSDRpOUlmWDJYWkQyNWFMdkJm?=
 =?utf-8?B?VEJKalFsdlc0ckdXdlovSHJJckp3ckJkL2pzSWxwNGN0cmt0eE1Hczdic0cy?=
 =?utf-8?B?MGNrbkRrc1FCK1BlQUpmMjFLM0Z2dDc0Tkl5VC9xbm1ZNWh3TU9RNlNwWjlE?=
 =?utf-8?B?RlNGWDVUNXdObVFsd3l4TldiMHlCMWJ3eGV1VVcvVUlubnpEYVFuVE5MQnZM?=
 =?utf-8?B?UHlPZlZzYVFnZHZSVWN1dTc3NXVDTkFQbGlja1RqM2xSaGdhUXNKVnA1Qk1B?=
 =?utf-8?B?WnpoNnZNYXZNWDhuSWhhaGlISmZ2UWZMMW15TVg0VjJycUNUWG1nMUVLZTZm?=
 =?utf-8?B?d09zdE1ZUEpvMlNQdTdYTnRkQjR3YUJXZnFlUzlKVHNlVXNhbU9RT1FKOEc4?=
 =?utf-8?B?bUhJUFlBZDBuT3E2WTJqbFNiVHQ5ckQ2eHJrNlJ0S21yOUY2WW5UTnRFZ3RW?=
 =?utf-8?B?OEFxZXlNTjRkNkxpNXhpSlM2RVljNyt5RDAxdStCUnovSjhlbXUwcEg1OHFW?=
 =?utf-8?B?T0pCTWVWL3BHWU5ick9GeWpENFpEZmx1TDhhWDRyenJzMTVEdENyVXF2RXVZ?=
 =?utf-8?B?eU8vcXZSbkIxbXg3eGphUXpRNmZra0RlNDVXcVNRMCtobWh3bTJMSE01Wlc4?=
 =?utf-8?B?a1NxcGdUbWFicklkUEtaOGNmQi96ajRoVHVoWU85SzhBa2QvUllnbHd4R1Vx?=
 =?utf-8?B?T0M4YzRjS3hUSXJEdUlJeVRRdmM5WjRLNVlnSWpTbFJpV09qc1JHRkl3dGJ5?=
 =?utf-8?B?NW5lNmYwSzd2bXJMeTJiL0RxL05EZlBiVDNSNGtQc2VCeHQ2ZU5VUWYxR0Fx?=
 =?utf-8?Q?2dfyo1AbdHBj/WbqXQvlWeZq4m0mIzuOy1jC21AG33Z+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca3e4e8-fff4-422a-6882-08daa1791709
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 17:44:28.3297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYfybUK46FoSN8qinQrNc8IJj8UvdoCOyN0topxxclFsfEE6X+sKuefFlJSelp2Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
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
Cc: Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 28.09.22 um 19:37 schrieb Vignesh Chander:
> Change-Id: Ifd6121fb94db3fadaa1dee61d35699abe1259409
> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 47159e9a0884..80fb6ef929e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -217,7 +217,8 @@ static void amdgpu_xgmi_hive_release(struct kobject *kobj)
>   	struct amdgpu_hive_info *hive = container_of(
>   		kobj, struct amdgpu_hive_info, kobj);
>   
> -	amdgpu_reset_put_reset_domain(hive->reset_domain);
> +	if (hive->reset_domain)
> +		amdgpu_reset_put_reset_domain(hive->reset_domain);

As general coding style rule _put functions are usually NULL pointer 
tolerant. So this shouldn't be necessary.

If that really is necessary then please adjust the 
amdgpu_reset_put_reset_domain() function instead.

Christian.

>   	hive->reset_domain = NULL;
>   
>   	mutex_destroy(&hive->hive_lock);

