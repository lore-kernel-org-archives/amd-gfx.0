Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8B9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 15:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40ED10E677;
	Tue, 26 Apr 2022 15:13:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1172710E689
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 15:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhfEoqHAzorjC+Uigx+6Pev6InesKAQYy32OfRzhWcilAnEgY9yRM5prDLX9yum4BTnFfGju2yCb5OJ3OChSyQ7XiYLleF/A8WvBYBQTC9eiojxnIdhemMHqJUNn6MltbJadHv2QIhdNdL+OTsfMgu92Wculz+DXgU9MPb6pu0JW+ayODCRdS/Xz/hmC1TVbN7TXbIFvxwrlea8xZO/t0+FnYuJZDNCpBtPKsq6gx96pmpBf6ervVptpxUGen5ZxOaJS59TeAC4CO71vClS4+zvbMVoQHgX5/0I29UVAwLCVsjoD/um1CQZh7n+5MeyXQgDnEH6g1RP1ikHdwDdWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxZkRcwn0nWunt/TVxWr+o/4CKVO0DZxUVPOeXqNyRE=;
 b=bBIQbDI0sk2CGJZ/RcQoJ39UZXKXG+Dk4F5rivpN2yZab26aMcpRlW/JHEm33S9htkSXMuDYH8+5W4k8czEfoL1WKODaagwDbUCKAJWD3rsTQ4IKoJxWekV1Z8HwPY/0V91cdoCe7zDwPr3GAknQEKSmel8YagNfiAty4Nzrpg83/NUObPUU4RlQ8CINKiR7FdHAvXmWqvzbwTk3Y/JTa9HqFy28VoVYSbnY811jp3vN+P5d9UjSEC/wAC/Uy+T7q7q861wEnYyO1A4qgokbk3S5c4EVXcsYwbGpSDjFk1eAK81Xp/45g4ozMkJVLFLrXguKh+1uco6ztqA3rRAEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxZkRcwn0nWunt/TVxWr+o/4CKVO0DZxUVPOeXqNyRE=;
 b=URZvxHPNv4TAPQqla2Y9WwnpbCCjIOJlBvjdViRAK3HzSdmugMkZK0/eYFAY9qfqmnItm0ReS0vILAIZs6GlrmG2UShqH+3dDbNyBhsMdjhNcdByBDTyMsJcovPPtzpSpsW1kjTUjp3KJuPME7da/BKilqucg/vkGTxQzBU3pjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW2PR12MB2444.namprd12.prod.outlook.com (2603:10b6:907:11::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 15:13:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:13:05 +0000
Message-ID: <a6716152-b30c-720d-706c-af40e97e09d8@amd.com>
Date: Tue, 26 Apr 2022 11:13:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix updating IO links during device
 removal
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220422190232.2505589-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220422190232.2505589-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791ea4b5-5539-4004-39eb-08da27974390
X-MS-TrafficTypeDiagnostic: MW2PR12MB2444:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB24446154740E9883EA1FCA1492FB9@MW2PR12MB2444.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xflorg9g0BMTg17moaP2Dj8efCPxOZb7Mvy34tUqrHXQWEHs3IRDTul8EXixIimBtmqSUrxx9mQMNk1Tp7dpoxqwxVaEnExgd/dFfhROVSrJywcCNQ+2v6i5xc4nTinJRu4w9eDyJ2dyHYnUWMB2Mn6rcH0V/YpZQK5r6k9PfhzubWIzMWAeCoGTK7tsUje4t59+ZH2FK8fdTVwtAmasXLpXD5NxVUk29XENUlD1+tf0hobi/xobyZkrrEeOGyzCJMk8g+6dj1aWAz+XAWNWKf+cSdCznA+ODmK676DW9tu3ytwBU8tostFgd0vCuv8jUa4xExBZeVmJswMjx4zXDNlsPi0HYj00beIPETm7jiU1iYLMI83AwTNa8q4vvv0XDLHl/2X550G94mdAIQNCkgzF5cUM2Fcawx8GmTb+FCVyR3ow7rshzyiwCYr7E25gUlTQflJ7dMcJB6NauWWRow6fDEfQqunZN9F87i4sbQjGaH2Shkujokf7VapxrlMXv31i6Vr0tVUxuENgcTNbLIPY6HDBeCSIHS01+lsqeQlVMtTgRHPjM4bWTdNU0h+8/4r2D2sYNqJQGYA1rnE3kVuMj0euFN5yxU0VL1w4IDpNQ2PZp/lJhBFBhN1ko+VKk9G0s3fc2GQlpMWog8Dc9RDLaMmDbW+mImezfT+wo3iUsgRjlfjsKGJvNYeXNsS32pZLdttWNbLhNCXrwRXzTTnW53485EElo7QgtvlXOzxBaLU4VAG2DDagoQnppPn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(8676002)(186003)(2616005)(31686004)(66556008)(66946007)(36756003)(44832011)(5660300002)(8936002)(6512007)(26005)(83380400001)(316002)(86362001)(31696002)(6486002)(6506007)(508600001)(38100700002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZxTjFyUFdQMkxDTTk2SUZNOExYZkVZMHhZS1RjejNPUysvdG04OVcxY2l6?=
 =?utf-8?B?aWZjSE54Qll5MldUeHRXRitsSnVaQ2VOVnFPei92aDFyWUNmNTYwaFFQTnRW?=
 =?utf-8?B?VnVkeHcyVDMvUHpVUGZENDcwNnE4NCthaE5zeThIUzFwa1Rmc25UcTlwVWg5?=
 =?utf-8?B?Nzl4eTVUS2RxUlB3ODl1WkdVK1FVWjdPekdXM1cweGhuUk94VmFvWDcvODFE?=
 =?utf-8?B?dFlLelozU1AzY1BnY2xCcm1WdmIvSURBdXpMSk1WSUFiYkRrdDZSUkFUMTJY?=
 =?utf-8?B?emd4STBnNnBudzZPYTNDWFoybkUzQkRwZitSNGdKYVIvQjhrU1hlbWpka3lQ?=
 =?utf-8?B?eVJiTTd4L1dBeDN6T29qYVhuN3R6SU42Znp2RW1Cdk9HMGpFM1hTZ2tSUzJl?=
 =?utf-8?B?c1BOejYrZy9mKzA3T3ptKytxR1h0VmVHMEMwWDNZZlZCWUhHVWFkZUJabHhI?=
 =?utf-8?B?NFVCZHZaOXA5SzNIRUNUTzdpV1YvQ3JkYXBRTjhrK0lqdGl6Q2JsT0ZTOW5h?=
 =?utf-8?B?dXJ4ZWNUb2diWG9YcVFjdDZRQWIwUEFvMmJBaXlURHRlMFR5VFBTNGlzeUJF?=
 =?utf-8?B?V1RQbEZPS1drQ1lzbnBJQ2F3YVZhMVlKVEJPeVVXdGFGQ1M4STV1YXFoTmdx?=
 =?utf-8?B?QUEreUV3QUsva2RSYkVDU1NOL2JaSkhFMkgxaDdhS3VuUTF0dzJ2bzZ5NlVh?=
 =?utf-8?B?U29VeDVkK1dhM0o0dEl1dk5jTXM0akxqV2NPa2VlSktGU29XYWJhVE4rbmNu?=
 =?utf-8?B?WkVTM2U4ZUg0eTdGZUFIRnVsVWR0NWZ1T0sya1ZvOTd3bnoyZVV5anRnWjBM?=
 =?utf-8?B?SXdmeWlRMGo4VnBYOCtsUk1IdTdBem9TZVh3TTBTc0FWanR2S1RzSUFucEg2?=
 =?utf-8?B?cmovMGhnWTFXWThnTUE3TG1KZzVRcERDRlhleEtqWXQyTVJiZjJxRWNFSEd6?=
 =?utf-8?B?ZGNmakJSdGhpVldkWXc5eldTdmNpbk5VdjBxTWs2dDBEVjFkZWxVaFI5ZkFm?=
 =?utf-8?B?YlJ2SENIS1o2eC9oQ3VISzBBVWVJUXJMN2RSMkd0c015bWRzR2w3UmVJK0M4?=
 =?utf-8?B?R3hZMlYycC9OejMzY1R6MEhTL0FTdTVCbXVvZmV2T3lYZUt3UGwxd1NNYjFM?=
 =?utf-8?B?ZHJEakZ1MTc1RkFqZHVIRlRZb0pDUDFkbE9DY2ZrSHZEN2t5YWcrUkNpVWd2?=
 =?utf-8?B?Z3lDQlpjYVRKZ3RkbzdhUWx4anoyNmJxa01TeXVrVWkxWm1jalZnaVZVaXZ6?=
 =?utf-8?B?TUszdlhKSlVwemp5eWRGYVZjQXdRVGVleUtIRUpZS3lVZDlOSjY0WGZRRUNw?=
 =?utf-8?B?ZGdOWjhiSkFUMk1IYXFIU3hydTZPdmQrM0ZhMEkrL1Fpb21uUWdSeVFHcDh3?=
 =?utf-8?B?Qk1xRzQ1UGVWSGZqM1JoeXVCWVRXSmZZM0pOK2lKb3FENUZkdkZoWm5WcHYy?=
 =?utf-8?B?TlkyY3ZjZTI1T0E0dmJGYXdNT2JtYXdlbENSUkw5ZmxEMitueU03TGlZRzNv?=
 =?utf-8?B?cjBZcXN4M0trbFdCUm1jTG5MeHFEZHlwdHFvNlN6eVlKUmx2OHlaOXk4TGhQ?=
 =?utf-8?B?b3pYL0J3SGNMT1ZDWkJUcVJNaTFzRHBjS0c4TjY1Wi9jV0R6TTBMdXlLcm53?=
 =?utf-8?B?S2F6Qjlhalp5cHBjdFZScGZGUmczaThKUzB4cDNYU3lub21qRU5zZVVNcTBl?=
 =?utf-8?B?VG51cWVCa3lGc3FtUC9yZ2FWejNsOXRobVVkOStNYzd3NE1OY0lrYkJHWThW?=
 =?utf-8?B?R04xSWl3R3VoeG9adUcvTGl0cVBNS21zOTRHaU1VRGlhZHBWNE1pRzJKSDcw?=
 =?utf-8?B?dWhYZFhWaFRJcFR0TmxTV3VmWEdsUldoeEhpekRMMER5aGNxZ1pRQUQyU0x6?=
 =?utf-8?B?QTVWMkpROUZMaGorcXN6T1RxLzJRcHZBaVViTUpLLzBnc2EvbE9CWFlGL240?=
 =?utf-8?B?b2ZycWlNVEdJeVpIYzBESXVoL1JlTzArcjMvdi9LU0kranplei9jbjJWa3Q1?=
 =?utf-8?B?VE4vK0l6UE4yT0pBSE55WngyVW90bjFBQm9LM1BoZ2tsOEQ5VWpOK0pZNkQy?=
 =?utf-8?B?andWbExtaHVESlcvazRQa1N1dnV1VndxL0RUWHp6b3NMZUJ4TkM2VmFqb1M3?=
 =?utf-8?B?ODhaTVZrQWt6eGRaSnhaSDdmY0pBYzd6dHJGdTRkbTViMlg3UjI2aXMvc0lB?=
 =?utf-8?B?OS9KTTlRTEdJNzVoNC8wNU9yMVlDNmVFemt1M2tsTzQxOUNoQy81VUN2SFo5?=
 =?utf-8?B?WTkvR0ljUGF0b0RWeTdJVm8zdWVQSVo3Q2xyVVU5WVpwRkVaWEpXcWdud0Zl?=
 =?utf-8?B?dkpEWXBkTU5ocEhidzlLMkpicVdZVzNmMVh6VXhlbnN1UmRic0QrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791ea4b5-5539-4004-39eb-08da27974390
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 15:13:05.4822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELpFJbQ4Qt6WiaRXB1MRMlVkfxCVNFM2+mAlhcdRNj7wCGT6Iw3nqRUVEjffyn0A9AyVNrlYHJMv/wzQBxW6yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2444
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

Am 2022-04-22 um 15:02 schrieb Mukul Joshi:
> The logic to update the IO links when a KFD device
> is removed was not correct as it would miss updating
> the proximity domain values for some nodes where the
> node_from and node_to both were greater values than the
> proximity domain value of the KFD device being removed
> from topology.
>
> Fixes: 9be62cbcc62f ("drm/amdkfd: Cleanup IO links during KFD device removal")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 8b7710b4d3ed..4283afd60fa5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1534,13 +1534,13 @@ static void kfd_topology_update_io_links(int proximity_domain)
>   				list_del(&iolink->list);
>   				dev->io_link_count--;
>   				dev->node_props.io_links_count--;
> -			} else if (iolink->node_from > proximity_domain) {
> -				iolink->node_from--;
> -			} else if (iolink->node_to > proximity_domain) {
> -				iolink->node_to--;
> +			} else {
> +				if (iolink->node_from > proximity_domain)
> +					iolink->node_from--;
> +				if (iolink->node_to > proximity_domain)
> +					iolink->node_to--;
>   			}
>   		}
> -
>   	}
>   }
>   
