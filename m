Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ABCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 00:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A6B10E49E;
	Tue, 11 Jan 2022 00:13:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1016710E49E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 00:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TguTAL7DDcpIu3Jf4B+iHc9r4Z5vvv9zxo9HwpxcmOtOmhPAKM62XlBhIQF3lPlrrvQcuulFpJMeGHFwbTjH0kWDZmo/gatJb5EVAYxylgQjYcDS/SRpLH/itknaDv/d26dWphLFgzoMaB2Q3XW2Tn9YuklkHTv4BVmu82TPyASGasQvzODMQw6g6SoJt1UBz0bT6igTt38AtTfVF9Y1Kk9szNN2yGhe6oqxvRjGRvqUQQfjwM2zSOmNjrApUMykI6lr6upX8i8VlyN5S/AFtlKHCiDXluhAZYXrKow7d3RzYg/cz474Vd4x5hgCrIUQzI73DpXzMIanoBs1UaNUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVqQx+4Y5jXuMdDGOuPQl342Mks10bx0aN/9Bn5aDyM=;
 b=HXwQeyXJTj+wrFxWQXRImqcdaIq5xtIGK8HZFbJWuAkM9dFyQp+kBUkpiAt9WHJj8/8fiEXfHuGFP6rgbV0msnfWxTjUzQ4jeC5i3iMs1p6mgcMGvkAt/4WcPUwnefyZX93q8OwXbvrjBPD997k80CNremPJosfMQedUtzGxhDFvKF+qdfCEVlg23MXw6aH4N3xB6kxHeHTHzY1oBgtS+583qdKK3efUL2oX91ZRs6rAgx3VSRuGIsefyyIRaeY8aG/aHuQG92CF0Nhe5od1+ZirrJGK8UF9V5JiVyzUbYHS1u4xrCIiOAR9P54wau4eJwImhhmoz5SWASSbs2MnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVqQx+4Y5jXuMdDGOuPQl342Mks10bx0aN/9Bn5aDyM=;
 b=FL5P0a2NFNm9la/M3jd9JMYVbhwizvLgInhWaCmdoJlrMZuMt2bLdmCnLwuNfK8hSHfcnwptei+NMtofMmrrjz7NZ8aRodjjRb7THAf9e34Kjl6l+PrcO71eD8BoAsFGnW0vBvb/7pVCasaNrsut635D8fEzzRRqj1K8uZlE7Nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 00:13:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 00:13:07 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix DQM asserts on Hawaii
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20211208082531.918062-1-Felix.Kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <007286ae-5d08-ff6d-123f-9c22a5f29eb7@amd.com>
Date: Mon, 10 Jan 2022 19:13:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211208082531.918062-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:208:237::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b85ac68-e55c-4106-d0d5-08d9d49724d7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5049:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5049328C023CE7528E167BD992519@BN9PR12MB5049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70N0HSJnAxVvycJwocmitBfArvhMpuGwzE6sNjMbpyceJluW5kKA/flwL2aeV3H7CixQx7d/3OtGVYaK4FEDNUHH/bHYcpT0DrQ0UgMyrlJAxA8osnTaCSliqpL2aZsSot6PMstBDGocUTqCPJyYD5IisfCjXGDKgS58vagUwPgaoILKoIGWsy3UjiJBRjUeHbUBR4WfSRxCUQNfYGexfUgapoU6hKjzs18Sxre17R/i6IhruJiP+w8Fd3a4MZTr/bFbPLegh+M1s1XqLUVLUi220cS5Qkn4ZaUorvlHg/yuwxFeMYwohiQtJ6QQLcphwymviMmTd+70B1p5WOAXzVJKfIOKnXd1BxJx5AfDn1FdhXUfoXg9JV0cwvuIxLWHUdMocxqPBojt4PrLbm1a6X+Lv0HRbCer1Me8bzCrBAwYNJTBUHiMB84ywA8BVNUGRPKTPgqs/42xL5cWn8TctGtRD2zzDbCbSKYFM1VzageBFiZRUzFsC69YXUsQPIpNBXBLxwHVfSOjCMp+TwFygtVO4KhP7p9G7T9H1XW76N0lLYm0fN3Cbww1H0HzS4q5aNPb1pbuXv/SntCxib8qk+4zuc4WVvVjHzCN+4bhzzMkytfWEmIBQGNudpA3U2cxCiy3uGZM6mwgW7u3ShT2+/ONJDu/bpQNt3ZdoTDuDssmQnreykR8zxHJ6xZpjDgcz1UJWgqtPSWPSItiQ5G+ldStxSUZMfNbTMzjFFHPx132XKv9hUHdok1BUbvePwT+usgiIS8piAzb46Y/41xs0OwkTWhvDPJew/IMUtovutNvCkSrWM6EWgKp++43OTFH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(2906002)(8676002)(31686004)(5660300002)(8936002)(38100700002)(508600001)(83380400001)(966005)(31696002)(86362001)(36756003)(186003)(6916009)(26005)(53546011)(6506007)(316002)(66946007)(36916002)(66556008)(66476007)(6512007)(6486002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cERXUnMvZFMxa2FlTUVxb1RlWVcwYVBzNkJsMlFUMVBtQ0NRdngvTVdHMGdj?=
 =?utf-8?B?TU9SOFQ3MGFucVFMRzlCNmNZaTd0RUtBR3hmdW1kRk9FczRUVndZUVRmUjNw?=
 =?utf-8?B?UStOaklITTd3bHdmcE1NWTlSblFISmh1WlI2czhlWnZRTFAveEpUZitjMFlL?=
 =?utf-8?B?RS9RNmlDcm1QTE4vekk5b1NxZlJJRE1XM0xTbk03Ykl4ekRybWVKcjVZdXVz?=
 =?utf-8?B?akMvUGREUVpqdlJXVEhHTENZRUZ5OXZiaDN4VEpGWGlhK1ZDZVhUNWNzV1lR?=
 =?utf-8?B?bGxod1BremFrV2N0a3VBQzNQOEgweE9VYmJzS2tMVzAyYWtGWXFBOTg0bkRi?=
 =?utf-8?B?c3orcEd3b2p3MnljTjE1SmFwRjhzZzhveXJTVjVMeE1ON3U4R0xlMnNRK2NN?=
 =?utf-8?B?bDM3aTJZalRobEdReXg3YjAvaFBxeWUrZE8yc3gwVTEyNUxNYTlMdnVXQ0ly?=
 =?utf-8?B?ZnFqWnlJejZkZnhlMlBITXRiRzFSOS9jK2Zxa0NuQ0xSbGlRRXp6Vk80Tkkv?=
 =?utf-8?B?bXFocjFHV0RFRDQySExZN0dSNUhseHlseERpRHAvWkw3akdmYlg4VzR2YkR1?=
 =?utf-8?B?YnozWHlTL0pkLytKSFBCMllJRUNXYnJiMThzTVhlN3UrS09hSmdmU1JUaEw1?=
 =?utf-8?B?UFFSWlFHQmIwZUhock5xcnpYNUJvWitIQjFWdjVaVUwyaGt5UklQK2djMVpJ?=
 =?utf-8?B?ekxnQnlHQ0VUd2JYZ3o0SVNwaFo4T3hWb2syTGhieHByV2duRytHaW04K3Bt?=
 =?utf-8?B?Vk1rcWMwWXlsbGNxWDhoSHcvSHVSMzNQU3l2T0t2YlZRNlowVTlJTjB0R1Ey?=
 =?utf-8?B?VVoxbFRabTVXeGsydkVwK25FeGlUS2tGbGlGSVVnS0c3c2djcTFrbmhUc01z?=
 =?utf-8?B?UFoydk9HQVVzdy9FZWMrYXF6cTROdWVyUnJ0QnF1ZWdQK2JNSy9jdWptQjRx?=
 =?utf-8?B?RU0zTUUyWktTckgra25WMmE0R2dmTXpaMjFKSUtubmNsMzJJUmhrSnVOQ1hF?=
 =?utf-8?B?c050THFJVkRHbHZ0RFlDZnBOK1dVQzVZZi9ZNHVoQklmOWpqWXZxd3RyNGFW?=
 =?utf-8?B?eUp1QVh0eGUxMGpRWU9EYVovUWFpVDFpVHlKaHhhcnJjTnVUZDRpT3NkMHFj?=
 =?utf-8?B?bnc0dmYxUWloYXJpUkdaUnpJRWpkd25WaDkreCtuRXNKSmFOd0ZINTA1aWZk?=
 =?utf-8?B?WkV6d2ZmeCtRTVBRazlxb2g2ckdaZGlXbFZvdGNhbnVnaTFyMU9HaVA1RUNk?=
 =?utf-8?B?dDFrbUZ2dGJwWUFWd0w1YzdHUmpheEE0eWt5YVpONzloT21SY2puZEt3V3JI?=
 =?utf-8?B?YWc4R2VkQmd2azdsR05nbHJxTzc2OG1PeEtKbngxSFUyK1FhM1RGU2hnTHRY?=
 =?utf-8?B?U25JN3k2RW8vYm1LNlYxWU1EK05KNlBnV2pWMDlYT1lRM3I2TGhJMVNmamdx?=
 =?utf-8?B?YmZSOUMxQTZyeU1qcXZPY1ZyK29wbG9BOWQwMnNQVlhLSXhjd0NXVXVvSGZZ?=
 =?utf-8?B?SjNpRzh4aGVVN2loVkVTVUEzTUNtZGlrdUUxaEZkZ016V0tUQXljOGt0Q2oz?=
 =?utf-8?B?eGZGaVBnMlRERmhqNXZzajNFTmYzZDExSnV6cDkvZjBwWmJmcEZQNU1ONDV5?=
 =?utf-8?B?NVkzYmUyZVhtbG9xV1JYQ2VCNU1sSWYrbU44M1BYY05WQ1phQnVtOFp4bEFL?=
 =?utf-8?B?UEhxc3hSSDZrYWpmenMwN2QwQnNFVUtLbjZhNzdxMGw4OHNseUdHZys4d2lp?=
 =?utf-8?B?dTNQRjhWSnFxQTBUcFcxcEtpUVZrRGMwaGNtWDFJcHRPb1FjVzl4V3lkOW1K?=
 =?utf-8?B?aUNNWEFPT3FpeGNURk15Wm9SRlpsU05xL3l0MUJFTkF1cmxnekYrTVREWUhw?=
 =?utf-8?B?clFtYko5MFRHQVhFTEtEQTdxbWlQSXk0TGJPWnRPSFNvY3VHcHd4UExWc01U?=
 =?utf-8?B?dnhDL2JjZE5mM0RnUHZlTjdXOWdXZUJtTTRDdUFYdVlSdnlTV0VHdFh3ZnFE?=
 =?utf-8?B?T2FoVDY1NVV0b1dWdUdVanpYZ2NURzhBVHQzdEdkR0l5R2VjUnR2b0Q3aUpC?=
 =?utf-8?B?WURLdFdtTUo5QjhUNUpHWkp0NHVKa1NZdDlIN3JnNXV3aklYNEdvQ2Y1Qml6?=
 =?utf-8?B?djRWeEh2cVdHRHhuaDdNUXl6NGZsZGthNlJZSjhCTk5hVDBHT2pmK3JLenZt?=
 =?utf-8?Q?6RNUWPTDyKzwQgXTgEqlGQI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b85ac68-e55c-4106-d0d5-08d9d49724d7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 00:13:07.5409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61Ss0wLVqTnIF10U8Q4OJGZU+igowFNDqXV0jCFaBHwAaW5My6QMsErIpXp5ajHro4HJyTxIXJH5KdqkYsAMQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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

Ping.

On 2021-12-08 3:25 a.m., Felix Kuehling wrote:

> start_nocpsch would never set dqm->sched_running on Hawaii due to an
> early return statement. This would trigger asserts in other functions
> and end up in inconsistent states.
>
> Bug: https://github.com/RadeonOpenCompute/ROCm/issues/1624
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index dd0b952f0173..104b70e61ba0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1004,14 +1004,17 @@ static void uninitialize(struct device_queue_manager *dqm)
>   
>   static int start_nocpsch(struct device_queue_manager *dqm)
>   {
> +	int r = 0;
> +
>   	pr_info("SW scheduler is used");
>   	init_interrupts(dqm);
>   	
>   	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
> -		return pm_init(&dqm->packet_mgr, dqm);
> -	dqm->sched_running = true;
> +		r = pm_init(&dqm->packet_mgr, dqm);
> +	if (!r)
> +		dqm->sched_running = true;
>   
> -	return 0;
> +	return r;
>   }
>   
>   static int stop_nocpsch(struct device_queue_manager *dqm)
