Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BB0ECAAD5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 03:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FEEA10E945;
	Thu,  8 Sep 2022 03:54:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5493410E945
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 03:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA6VDKs0ZA4Bi4PByEd+pd8G9ECxP8+LIuW/0JlAGPsbyepwauEdwijRdfqFKBmGGcdQy52jmx/Yf/6fbakO6tbH8SzyBrHibAzRrY+QdRQaM5WW7u3qtzYwwHWWHGYuxmB1acwDh5qb7TPIZdOu6tMb4g410XZaXLMjWDTDfFNVzocTz1ogtXAIzxiJmmpL21DNdT81qTYtDXyuiniWblrFLmjEZjnWv20W2pmnB9ZT+uxz0/V0NEfnYSot0a3Dhfk/DM6uzhDAl7sbQ0JJGTcrYXPcyGM/rtL6Vwjd2iUuagizUeuq/Mszwpc0N/j093f3+8p/mDE9iAmSiekosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C88vF85NBuK3tskEd4ILo2VrzNe9Lldao/SBeKV3bmA=;
 b=JjNG/mvnrhQAQPdJJTLXfRscggw28Pp0Y5qY8C7Qngb2KEKkaxG7Nf4tY5hBXcqLtwiNI1u5l9iWcBY6EC/LJVXkjDmbK3gVLJTEgh4aq+asDZ5xLv0oLGhjyc690WTMj7LuJwVJReK2obXNkRkc8PbNoFRUb3/3PfhLWkMZV7L+ZL3Oa3edXs+QQaGKmxpRyKyci2uXCcrssLgRg7y4lvUn7ZsHvZOUB2fKiUk35begrlBaMWpMsMLDES/blSxTxP+trvm+skPlgnNGxc05AFUIJ82pmGA++xFaOz1iiI0n31+j4i1dULwWg18ekMiM65/hpDTzSA5gLRZJQ1dddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C88vF85NBuK3tskEd4ILo2VrzNe9Lldao/SBeKV3bmA=;
 b=u1EHkHaiqX3/Lv4eM3V6zEBLmMrGjItZjcFDiDC9K6OBvkPXg54i+PCybg+KXCIydL786xf95mU861HaURpTclApM6vJ/7VEg6Vkf2+W0CHLNSHy9e+mA4c48/rcHKqjxr4Fq++yXZWOAsCDCrA7T2/SxBQGdIKW/Nd2GkFX6k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 03:54:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 03:54:21 +0000
Message-ID: <4a97ca4d-8ca3-8143-43d1-8b4a33de675b@amd.com>
Date: Wed, 7 Sep 2022 23:54:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Enable full reset when RAS is supported on gc
 v11_0_0
Content-Language: en-US
To: Candice Li <candice.li@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220908011035.17145-1-candice.li@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220908011035.17145-1-candice.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc09a257-b8fa-4543-983e-08da914dcf5e
X-MS-TrafficTypeDiagnostic: DM4PR12MB6325:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56os7SYHm2JqIYapaGE/hp4+42xd7cRaCl0almgoqh7gOZOEDQJI5RXxDbemZYSdebXMd2ctW/XlpFpzMNgoemFzMCAsf3t6YogDd5YT/IUT5QOwXj+/9I+UDYFAr9P4Z/TXslRKH3kg2VWu4ZqsGrk+yjCURzWaLLfAyZewLUMkIsrD/p1f+ZgfUFN2u+jk0Ar6dP8A7Kwn5cv+wVnJ/UBUND7nh5X2xIssH8edrGifceGvYirco8tdDIjotjAjhN++HItOk8nz936e7iypgfd0lsMQ9/3X9Gugf48N6HFUigLPGqouWN/V8kv3Q/ZnoYSIs8V9jPEDQBTg5zaidpKWMl5/lt72KPtMsaJrScHbwpF3x9uoHpLOT1LiR9AbJ48y+DZoqP+Lc4qy7DjKKfvbzZGEf1WWW9ySZe0w1q+FWrvY8Jx7mXH9XIRIQmnhbr9taRMKSadrso6+bSnrzeqBdjTZ7ruuUjLx8j+qbwvEq9XnWKuAf9IFxPSgvxELNvylxxKZlk3NduROjHAlGi/zU0VFw8VITdqbBm3FcYUWxGd4qxGwlMvHtLUeQ5UMWpK/Wm2l1KNvJP/zxg+ZwnQ1YPc1FiHDdLbibuZBtjq5x69OwKnAJ6Gr2/j7pIR1hCbnzXY/gMIAB+Xj1zFMOicw+thdpmdWBagEaStrKhoGmRGPQn6pdkCzOXDjtiD9shUkSAlC/kmyh3uqmxy+2B0isAgmZixKtTd7tSyxMvFdaMKKnN0y9PSAfcsmduCU5EPz59xM4lOU3rmC1fGbj3TIGsCC4lVbZm6yn2pjyRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(31696002)(38100700002)(316002)(41300700001)(5660300002)(4744005)(2906002)(44832011)(8936002)(66946007)(6486002)(66476007)(8676002)(66556008)(186003)(2616005)(6666004)(83380400001)(478600001)(6506007)(31686004)(26005)(6512007)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZwdWlSV0g0SVdZcDdzUUtVSHhQalJxOTdpRTlMMkIxOUtWQmFYdjd3WkpR?=
 =?utf-8?B?REVJTU5XRmlxeDZIOFBLNlE1OTdwa0NldkM1eGJSZ0RLZXB3SktmR1RXS1F6?=
 =?utf-8?B?Z0h0RGdXN3ZZZCtndlRucmx2Ujdza2RHM0ZYVWF2dkpoMUtVV0hjQzNUSlZa?=
 =?utf-8?B?ZnZPdjlsaFNZVEdZNW4zR1VGY0VWTEQrbFQwT1d5QVJuOGhqUWttS0xtUGh4?=
 =?utf-8?B?WmRYZGVtOTd5RnhqNmNTR1Z5V2UyVEhRWFZWbE5yR3BmNzZvelRaMXJJeFJ2?=
 =?utf-8?B?c1lCM2d5cnVGK1MzTDUva0trUHFhVFk3cE1vdGFDY2dqY1c5dVY4aDdTT1kx?=
 =?utf-8?B?aFVRU1BCRlAzMGgxV3pvb1lRWEl2aUNLNkoyTjEvV1ZGZVFDYmNLcERrd3F4?=
 =?utf-8?B?YVArYXRySStnZTFhMG0vc0VadHdidEN1Lzk4WTlvRFptcnBoZ0poR2xsMmlk?=
 =?utf-8?B?NFhOKzc1ekhFem5valVHYVoxckRxWmljcnNVeEhZMmloRWxLSXJ1cnp5aGJh?=
 =?utf-8?B?b2RhMGs4emZVanNVT1EzeVNnNmoxdVhST25GWEkwV0crVFI3U0FNT3IvR3NM?=
 =?utf-8?B?MGJRRTBNRURaYlh2ak05ZzNDLzJBbnh4Z0U1azhmdGpyVzZQcE1YQWRUVHU5?=
 =?utf-8?B?M3hCYUszR0k1Q3FpM0lUbXhyWVJkejRBQzZHSzNJeTNHMTc4Wm4wTy9xN3or?=
 =?utf-8?B?RDc2ZWtvb2VoNWNjL2N1M0pRZlNYSTBxTUp0RS9oaS9IVFNiOEtKUDlTUmxi?=
 =?utf-8?B?ZjY2Vk9sbnBUOWJ5SjI0aDR5NnRpN0RKWkZPTXZ4bTJOaEFqczIxU1I2cmhm?=
 =?utf-8?B?VkN6QXRsQXJEN0dXR0QxdzVieEIrS1hlSExmQ0dDbUFPZVNpbG1vNXNZeFlz?=
 =?utf-8?B?eGk4QlkyUWhoZHJsTGIyVkxhbmwwUTdySTdIb2E3TWpyZ2U5ZjVhc3hkWFVW?=
 =?utf-8?B?dE5FdFB3bXZIR1Fab0dCaWRVQWtBMmRXK2VvR3o0T05yTUZpNldYaGJpUmtU?=
 =?utf-8?B?YU5GZ0FwaElqZDU1VS9FL2tjQlhOdXNNLzRiQi8vNnhwRHFyenVhZVNPM3hY?=
 =?utf-8?B?Mm9UR3M0cGo0T2h5Q29nZXU2SVlWRnhQOWlXMDk0S0lweGNJbnRJQ00xTXFy?=
 =?utf-8?B?R3dyZDFMZWRIUVNxT1dPUkRDYmw0WXhQbXB3Y3EveUEyUi9rU0E5SjN3MGg5?=
 =?utf-8?B?dnVDR1UvdGRPSkNiQmxIa2NhNjd5Y09rMTJhUjNaL25HSFFUK2U3WVJSMlpG?=
 =?utf-8?B?WC8rYk1DeGRnUGdXNGR0YjZVVVJ3UVhNdTJWbHpkMmNDS08wRjByTHZBOHlX?=
 =?utf-8?B?SGFMU0Q1RzJ0RDJKazh4VW9hb2o1eS9EaSsxUWs5RFFmZGtPQWZVem5tTEpq?=
 =?utf-8?B?WTR4NUVYckFNUHBzbllwZHhkTmhyZXBYdUxTTlRvVHFDd0NTOHBWOStMTEN5?=
 =?utf-8?B?QjNXVldzeWJOc0JibGJMbU5aYy8xNW8waC8zSXowZEIwR1dmY2NpVndJQkU2?=
 =?utf-8?B?QzRGdWdJMmNSbWp2ZWdETytKMElMSWtKakl5SjVkUnNzVE5rY1RLTHd2M0R3?=
 =?utf-8?B?cFQvSDdmMEN4TUxpOVRIQnduNUU5SFN0ZURZNjNwU0E1T25JRE52aW9nbktx?=
 =?utf-8?B?emFQb3lQM1hldE5xdUNNdFlhS1BMVlR4ZHVPSkFoMlc0N2RKVmNXczlGY0sx?=
 =?utf-8?B?eGdwbVdYV3R6UkJ3TEZhVHV4eDQ4TElYTlpVYVNZMEQxeEpjRjhUTEk3dEVZ?=
 =?utf-8?B?dVVDYzNiWDBEWSsxcC96Y04zMjdKbjZOQktXQ3hmQVZOdENEYUNPWjI2SUhy?=
 =?utf-8?B?b091bituQlR3Ui9YTFF0VWhvaWU0OE5RUHZ5VzdVazZFK0MySElLa2cveCtj?=
 =?utf-8?B?cnNha1hzM0Z3RlIvYkFLVXllNmo1bExBcUZ5MVAxbUJCZzN0c0NHQ2RwNWJl?=
 =?utf-8?B?V1NNSnV1ZnhMcFlybXVXdWtRQzl3cUU3SDB3WXllRVo1bGdEUVhrbm96VWF1?=
 =?utf-8?B?ODY3OVZIdDJ2UndJenloZE5NdjhwTUQzQUpmQ2NNelEzK1E3RnhxNk1rRU0y?=
 =?utf-8?B?Qi94RDJTa1YvY3E2S3VUNU5JL0xuZXM3cGhKU203WHdqdUF1U2dyK3FJbWFw?=
 =?utf-8?Q?uiI5OAVV3r48jqRz6BZuJBHKh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc09a257-b8fa-4543-983e-08da914dcf5e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 03:54:20.8807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+dSC0kLWiTT3s9vkuGc51IFXueWqVmDXlgEsDHb2qXlTHc4LTZgqIkGSYUoVn8i5sBVLmVpdTgqszB9HS+ebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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

Am 2022-09-07 um 21:10 schrieb Candice Li:
> Enable full reset for RAS supported configuration on gc v11_0_0.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index a26c5723c46e27..81f32d77c98cd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -421,6 +421,10 @@ static bool soc21_need_full_reset(struct amdgpu_device *adev)
>   {
>   	switch (adev->ip_versions[GC_HWIP][0]) {
>   	case IP_VERSION(11, 0, 0):
> +		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +			return true;
> +		else
> +			return false;

Is there a reason why this can't be written simply as

     return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC);


Regards,
   Felix


>   	case IP_VERSION(11, 0, 2):
>   		return false;
>   	default:
