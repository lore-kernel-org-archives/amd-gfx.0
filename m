Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358FBC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 11:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB43110E0DF;
	Thu, 27 Apr 2023 11:34:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D15010E285
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 11:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6JP+T/S29ivtyTLRJ3szecoT7NwFZyJiIUzmFVGagftTjo3iYc7PqYlcMUQE6Y2ydwvXj9imsFa76gdnz9UTmG2nO7kzbv4ZvEM0XSV1zSE2wyiEzpmBTdddKevKY+M+/HIcvrx+cNaWZkBY773sw6KOAm6TPEcXNNeGYtNwSYK0qpeSnG0vcynEF4eA69DQgij/1HMFqwWlMqZ+77KZK6yFqpVO2YNwTke3Mhb2mg6C2VVfcAO4ohC7555WYMHYNxFlTYt6hmQ2FDpZmTqnN/ht55rYffcld7KjPdeSJObgzdq6on30Q9Sbh2bamPTdM09HVnASsifYrIoeHvmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7GuJLV1iPBxKsCsNrS+JrwVsvoqr8q5q1HeeN6lL+Q=;
 b=IQtL3WVd9nwTgUF+LaKbpsAFyBucHL9upk464aS9zDgDoOtuMwHZGHWq47j385M0bSBmcdh8NbnULNuVnAPcytuHi4ATmE98dr+zyQrQGeKAs5aEKxV6V/JbCvrCJfTJnDO6EBO3E3si0He4I41pd0Yc1408ZK0+pcqWk+uYGLN2GFicNiO3nQgRYM8jPaMKwrzXetLNw2JfDkGxwYUk5SszxnPLR2yPrEtVWUN10bxVNqis6Hg81lbPbj9PJnUHaAgWbC77byd7/o//1ITEtPLgDTgXRoAqH82aRYQ0OxkGd8jfzoAffuAFfifaHh7DZzMCpbFCpeqn87q9piL8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7GuJLV1iPBxKsCsNrS+JrwVsvoqr8q5q1HeeN6lL+Q=;
 b=yip6s8pLTA1VElzmoCK0LOjkVSm9HVFIeGZZ2/c1DLRTxf3b4xp06cFi+GDbomkjP98Awe3CuW83M0QWR/bJBM0eZm361FpjBgltr6gj9ZZsxEUUQHAG34gzbbgsdsdkzsyUlGXtlq3uZgF3ZojxhbHZp8RvI/RyD/uqOeOEb94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 11:34:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 11:34:18 +0000
Message-ID: <37e3f032-63f4-7872-559f-adf3cc76bf0a@amd.com>
Date: Thu, 27 Apr 2023 13:34:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Recover vram from vmbo->shadow rather than
 vmbo->bo
Content-Language: en-US
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427032329.3195820-1-lincao12@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230427032329.3195820-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 915b1b6e-2ca4-4901-c04f-08db4713564b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuwTQgJYSFnQgn4CPXyxvjaYOG4HFxcNLnzgBqJGwHjwmlfsWSQrOAdcIFiYO7JXxGJQfn/gn5mJamWlv/rqz7MAq/ZwoDZNM2+WzWcnyGcjiFs+zmuLURxfh8/iI7MuxVqfoTWK6NHaPqdWy7A4TakuNR8R7LqS7pBL0WJHP49kcD+9dB8vpMXToYplXMnAXK1h2d1bttTv52mqKn7a7SJpKjFUIW7wDTkFdc6kshNG0wB6fgeb1ptAP3cZYskNIyCjFyIP9E31P5aHjwB3AEgU/R5p6mAVB3HV/gclbDAtvtK0JDq2qUOWmaIDzBgzXuFgGAgLZKW/3gduK+8my9KORH2kdRAoF3dGvf8ErS8KxshI5WD9DUbqhyx0JdVGT45EsnawLJfHWg88MyrHAV/BvWUJ7CM52TWuhjTbv7ic+hYWQ5ssreXG+/31F9BTnPcNFi356RLibIcOm12fXz+SPJe0Rknp1khs4iGGNRv6fvrpp9Ni/WiqP9pvpMtLDJh27xOdj02RGljm0vnKyV6mJ8c5J7GAV9oSx1TrYv6fYiB75NuYKX7zU4VRGUDSeJrPALdgBGp4qCl1kWnQyisU92YdGk0OaqEQ9BXv50PsdfPavg6//YFcQKopVYmIctWN9NDiLX9tD1pcxwUOwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(6506007)(31696002)(316002)(86362001)(66476007)(66946007)(2906002)(8936002)(8676002)(38100700002)(41300700001)(66556008)(5660300002)(186003)(6512007)(26005)(36756003)(4326008)(2616005)(83380400001)(31686004)(6666004)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2d6S3hnc2VkWTAyT0NNL3J6azJXZVBFZUZwZnNSbHdHNWpCMFZyRktYdmFz?=
 =?utf-8?B?N0dYelFPVU9DcGtPaVNZc3NMeDFPRFRCZy9Sd0t6V0FGOG02MUtrUzNPenNr?=
 =?utf-8?B?QTlFenlzSmRmSXNSN3hnTkJwb2I1anMwZmxndUcxYXhFc0wyYjJyQkdjVVhQ?=
 =?utf-8?B?NHA2eVNlRjdTdS9KNnJQTmtkQWdwMkxHZU5jWFBIMXZYaTRqV25VVG5vVlBl?=
 =?utf-8?B?elQ0SnhUZ0N4WmZCaTF4VW5yOHhJbW9oTVl6Ly9YeVVEcjBKcG1ZelVKd2xi?=
 =?utf-8?B?S05veXJDU052dTRNSEZsYllSU01INS9HcGU1LzZtcEIzT1grLytOWHg1NXBz?=
 =?utf-8?B?SS9HQUNUMGp6K3FUSUZsU054cDZrRXJ4QndzQmk1MUg1Yzh5YnBFYW5iOGJ0?=
 =?utf-8?B?OUd0WjFuU1VtUkhHM253QnZHTlFrdVU5TVNkTS80QnNoZHFrQWIrRFZFbTQ3?=
 =?utf-8?B?a3hzaVhpSFZvKzB4SjRCMkNQS0c4L3dZelV1UlZhMHprMVdUVE5ub3g1M0lD?=
 =?utf-8?B?a2NCK0pueGJiMThaS2ZFRXVhNllDNWFOY0pCRHZKTWpoUzR3QlVCUHpvc3Jq?=
 =?utf-8?B?T293RHJVald1R1pRTnhiT3N5OXFhWHhzeXR0NUJNL1ZGS3VORytpWjRjanps?=
 =?utf-8?B?YzBsY0RMYnRCSmNTZ0tOU2RUZWRtdzc1Y0JieDFzUjBHUU54dWpIQ25GTmRn?=
 =?utf-8?B?TytmT0lVZTg0eTFNZmFJSkliTUh3cU5uaTlHTkZFUXRub0k0SEx1TFZSMERR?=
 =?utf-8?B?QTJtakFvQ0dNTWYreTdPRU8wS1dTcFZxODNadTh6STFPMXZaZ2UrZncyYzBo?=
 =?utf-8?B?TzJKcWFMU2NtSUlzSHlHTE4xbG1Ec3J6UWVtN29JVGdrNEk5WFFBdm5yb3py?=
 =?utf-8?B?VTgxeHlDQzNTSWlkWTNnWk8ybG1tZG9YQWltRnFZSTRHZ25YbXF2c0ZXT3hZ?=
 =?utf-8?B?Z2VtZTYrUFp1UmRGMmtPR0ZwSjJZVjUxRVNmQ280d3RCWGhaNys0aVNnTjJD?=
 =?utf-8?B?dzk4SFBFNzQrOE9PdnNwQm9hL0JrK25kTStMeDViVUM5dzBoSWhFYkVVSDVw?=
 =?utf-8?B?cU9WK3p6OTRpVWpHbFFaUmFTS3BwdGpkTmJ5c0d2OWxoZ0lpa3JTNFoxelpx?=
 =?utf-8?B?US9IdzQrMHdnVW9td2JoRXZET3gxYmpvT2JUZytTZzVoaTVKbHcvRGlpbDA3?=
 =?utf-8?B?RDd1dTlDOTdkOTIrOVRQcEJXZDlmYXA2OG1QYS9JbzIrdWZ6VVBiWEVLOThY?=
 =?utf-8?B?K0lFcVRDUUpQVEZ0NmkzL1BIY1RrdE1CQVhmZS8vWHVIM2tGRE1WWFcwQkZ1?=
 =?utf-8?B?dXUyRVlHN2ZlV3dzZVRSUlFqcURQME80Zy9KY2dXRnp1VmR5a1crTlo5S1VE?=
 =?utf-8?B?RHlId21pR1pEUWZiTURpSjRkRjRFZ05XRDIyWXBYajZCTFdSalJGS3RYNTYw?=
 =?utf-8?B?UjI4UEtmUmZjSVhyUFIveTNYSFdEc2V4RUNoSW5SSjR1bXp0NWlnbzlOTjFL?=
 =?utf-8?B?aHJHU0tyTzMrNW1ZSC9DWmpOOExlQ3QvZ21zK01vT09GbElhUVhnaGxFT3Zl?=
 =?utf-8?B?eGZGWEpXTVJvM0NwMW5tb2dFN01BS25aQTlSVlNOa0JnZXpyd0dndHA0RUd2?=
 =?utf-8?B?dXNVVHBRSTF1K0JFTVRWcFFNSHRWWldkeXlLb012WmRJckliVzE5RVlVWkhP?=
 =?utf-8?B?RUhDRlgwb0ZHWSt4dnl1VW5oT0h4bGZFTmxvY2h5UmhWTTlnZHlObjdPYmZj?=
 =?utf-8?B?VGs0VWhrR1RmT01VR2JzaHptV3JjWXdVck56NW9KT0tIdDVZQlhOaGxMMW5o?=
 =?utf-8?B?UVE5OFlSZUhPa25PcUZ2RDVaNHVQZERvUzltZm0rM0hKdXZobDZLQllqUGto?=
 =?utf-8?B?Rjh3aW1zUGJuc0J1ZFRnbWxUbUFWd3paKzdNUFMyWFpuOTd3TlZkMGFXZlZl?=
 =?utf-8?B?NXVMSXFTOG55OUMvZi91SzRySFVsbjdSY2RXelgwa3pNc24zejhBVGZUM2l6?=
 =?utf-8?B?dnV4b3FDbm9xZHpzMlNqQi8zQmNQSzZjV2xGRm5BMWYyRTA5ZkRhd0lYdzcx?=
 =?utf-8?B?Ymc2ZmpyNWt1bnRnMk04NjVkWFp0Q25XU0N5SUVRWjJGZFB0ckNtSDBtMFRF?=
 =?utf-8?Q?8gTw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915b1b6e-2ca4-4901-c04f-08db4713564b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 11:34:18.3153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nxoPp/FMfHedCCSycvwCfyQvSbb60IT3uKfha47SLHwxRg4CTECz7tFSWktcNjW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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
Cc: zhenguo.yin@amd.com, jingwen.chen2@amd.com, Monk.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.04.23 um 05:23 schrieb Lin.Cao:
> Vmbo->shadow is used to back vram bo up when vram lost. So that we should set
> shadow as vmbo->shadow to recover vmbo->bo.

Good catch.

>
> Fix: 'commit e18aaea733da ("drm/amdgpu: move shadow_list to amdgpu_bo_vm")'
>
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e536886f6d42..a3c8216f554a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4501,7 +4501,13 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
>   	dev_info(adev->dev, "recover vram bo from shadow start\n");
>   	mutex_lock(&adev->shadow_list_lock);
>   	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
> -		shadow = &vmbo->bo;
> +
> +		/* If vm is compute context or adev is APU, shadow will be NULL */
> +		if (vmbo->shadow)
> +			shadow = vmbo->shadow;
> +		else
> +			continue;

Better write that as "if (!vmbo->shadow) continue;", apart from that 
looks good to me.

Christian.

> +
>   		/* No need to recover an evicted BO */
>   		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
>   		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||

