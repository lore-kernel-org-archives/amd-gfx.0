Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E69AC7EE2F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D1210E51E;
	Wed,  7 Jun 2023 17:17:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F7410E51E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftPX907pKU5k6gKKwsGQNSAbYU9SRb0UVMJPh7k0cxQ9Hx8mMe0RQmdFaGWegCrSey4yCW+3DnIH0Z3fjBwhLoFcc/K+8x4HogmbBYsCQw2rYdXiIt6G14Bx62HSVrFnnW5RbFs8j1+fuekWkPH0pq/V6VorwnVZW5qiQ6m2Uhx1/0VTa8y4NqywbL6aDM1tVSWpnXgE3LZY6NGHSYPLPDwwLGgoC805Nto9o6nhRWaZlnoc+5Ka+wTLjix1SgCDJO6quTAVO/Zl/hevdsLScvyWigcUXfKT5dHhTNFSq7/C9aPK7LTTpx3gAd0Br2e0m3WsGSHPx+ikoEb6J1XzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs9yzPk9w8QENXZ9sW6KUznrEXuS74lKkRM+umw472c=;
 b=MkMnjio3nU9SG8nVt0FXeFuLnGDgRohzYjI8Nk+jDNS1kHfJ8lkt1wwYKKeGu9kTYfsqibAjoPtmKu6IhqiOoTInaGhEaJFYN2MgS72OZi+18ikxjX13HAQSgLHS8reo/eb0ahMZy8O/0zMYYoNf+eiKLqs9m3EeNI/4KcYTD0N/11RPkLH0y1QENSNgy95CKa9WyLPJdmP/jeIyZgwY7ETbVyJGm0I2owu393Q9nIp74O++K5rn02dZgH4gSvDaU4KK6ifhjJ0BnudOiwmPuVkD1+nCIz7ru7S90hqQVtY/MjNIIACm0Sir71RGRQioDt0kDoCeo0811z3U7vSaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs9yzPk9w8QENXZ9sW6KUznrEXuS74lKkRM+umw472c=;
 b=QNDkMZJIXsX9OJlVbqzuiEHJlTWE/dRuchZ/fpFucGUMRCeb9qg1vt8CN4rRUI6fbiGh3lYb1bPCjw6qxZqD3mODzK/NRN31Oe0XT/VtkpZBLlxZB/vsuWFFb9zstXmtlIo4PWCwp33WycUctxRJhsuq3K1KCjvm5qg/vthD860=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:17:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:17:12 +0000
Message-ID: <de46df60-71e3-f722-efa2-d4f7e077cc31@amd.com>
Date: Wed, 7 Jun 2023 13:17:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] drm/amdkfd: add event age tracking
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230606162418.1862540-1-James.Zhu@amd.com>
 <20230606162418.1862540-2-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230606162418.1862540-2-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f59909-24d0-4877-1f7e-08db677b0854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNav/gEVD17D+ViiCEdbZLoNiGLnIYV0bZdbD057YZzinrbyW2YPzqDhaGJcp4pZwf32+dKLhIINbrnsEdhy27UnUf8Kf6WUeUyOb+R/ZPzPBQgMX+hteb4jYhz0eRovKphwm6p/WaB0f8pFsBmwypo6EvY85gddAEQlphKXGPKb4nLhMC7CZ84F6F+Bk4aW48qe4D9AOnhOSK7C8jcfGSuqDNtOhZyZ7soDY8nYU3ySTWqQ4kHLLOYyBvn9+p0ndjtcA9/kkhaidJhAtQajKT7cSzm11r/AIkRkdIG5amQtBXJ3Xax4eyx3y8He3Rjf6uGw+R/zlX6cRG1kVFbHEYhjYWqD5t4Vhkfd3UnnRcwM682zy2TU9N81UzC2BKRxJla1+tqE5T9zcP+OWfsAX5TSecq826CqC2DfzfvZ2b4/N+h3syyq/6yoD/QkBdpckKKBQeRuVgekVnMV42zU+jpb67Am2J4ntRQKSnPZy9i6Cy2hSeS5jUFCmuMAe1Qv4JvqfPJLUHz3lfYS6nyRP+OkkDKZsWt2ufeopVci5ByaZzGrcLWfHF1fqR1+hAabn8608ZA60+rbACiGyuoMONRtutIlVCr1h9jybQorPVL1Yvyr/CoMSETWno291FAha2NpBgoBrsWy/SPQWg9URA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(41300700001)(31686004)(36756003)(8936002)(8676002)(5660300002)(44832011)(4326008)(66476007)(66946007)(66556008)(316002)(478600001)(2906002)(38100700002)(6486002)(36916002)(31696002)(53546011)(6506007)(26005)(186003)(6512007)(83380400001)(2616005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzBhL2Zub3FJdnR4RTgzRWhNbFgxNnhiZGM5cVozR3JOV1BJQUttcmRwTEh5?=
 =?utf-8?B?ZGJPdnptOTNJb0lQcG9VRVFOcFU1YlJnTTRiOTd0ZHBQbG1hR0hVRHNra2Mw?=
 =?utf-8?B?bk9YVlcycVJwYVQ2ZElMcElKVFBKQytEK2dtK3VjVGFDUks1WTdrTkpGRHN3?=
 =?utf-8?B?NzRiVm5ER09wN1RCb1dWTTZRNlpBYlBQWEhpT3lMR3phdXpFRlkrS29PbExF?=
 =?utf-8?B?RmNyK0F6TFMzSmFBUnVhUVpEMXBUZGN5RzJQM1hneWk4R2JmcmFGclJyZUtt?=
 =?utf-8?B?eUlZeU5ZUm44ajZEMHlvZCs0UUlTcXh1NmFEa1hKYzdaVU5aUWNqTlF1U09o?=
 =?utf-8?B?a0VNVzJDSEFjNFRQaGJnQnUyN2YranpIVEFtUGhBRWZIeEVES0lZZithZUw1?=
 =?utf-8?B?UXc2VWNRcU5mcG5xUVM1ZTdkQTA2WXljUndpblNNU0ZsNmhTVWtTaUhUNmta?=
 =?utf-8?B?SXVXK1EvUFhTWFM2VnBqamNpcDZUdUluZ3FKakxPOHlYcVNHblBLamFqT1BU?=
 =?utf-8?B?SmJrWUFTcXpiUkFNOHJheVdLR0N0bzZLeHJaYnFORXRBdjNMblhGU0ZLQTIx?=
 =?utf-8?B?Yk5hYWV0SDR5bVBSb05XcnlPU09VeWNqQVBsNHVrRHFKcndiV21zNko1YTM5?=
 =?utf-8?B?bDlkMHFTK3AxVWlDS1gyVEszU3E0S04xSG9KK1ZNam5YTVpRUExLWk1GajJj?=
 =?utf-8?B?N09yd2p5Q1BzWTF2OHVmTEFaSFBHeEtKa0pnRGlmMktGcmZlWXVBZDd0UDhN?=
 =?utf-8?B?K1cwWGc0VG8zR1puZjVLSXBmNzJNeER0WU5CaUpIa3JTL3Jrc0hPWkNNcWFi?=
 =?utf-8?B?dzM4cmNEcFowakU1cVlvVHF6ZzlKUUhLMStnQkp1VEU3bUtJWXp2YzNYOHlQ?=
 =?utf-8?B?MVB6TnRiTE5TaXpkTkROWEFNc0hOaHk4Z2t1OElTcEhJRlF4MXN6U0wza2lT?=
 =?utf-8?B?cnl1QzZlYnkyYTd4RXhhRGpWbnAwSDRnK3FZQ3hQQkwwWVZYdlM4a1ZSMmln?=
 =?utf-8?B?OHFpV0ZzZ1p6SVNCWWtRVnkra2h4RWx2TW53YWl5bjJSaGIzMzRzeTUrYVpu?=
 =?utf-8?B?anVlZU5GeVNaRGZFRXdndHVaK0JJVUR0WERkZHdJR1ZROUkrejd6SjROMTVk?=
 =?utf-8?B?dGhLdWZBdnZXTDJBZndSSWRaeVZwU1RNY1FFV1NwT1VGZTRpMFAvTEFVMnBi?=
 =?utf-8?B?T0hqY3Bkd2ZJMWdYZENHVzcrYlNsM24wSGRabUpwQnZPdDIzNW8veHlhWHhh?=
 =?utf-8?B?UnlaWVk3ZEhyaFJJbnV3NkhtT0JPY24vYmRzdUtsTjNBUWx2MTkvbHNVZCtB?=
 =?utf-8?B?NncyZ1RLTU5naXM2ZWVVQ055RlBKT3ZadmVXcE5WR1lvZldVYXh0blMvRks2?=
 =?utf-8?B?bjg4K2EzU3NaNjcxQldHZEt3Q1VRYzFZTVZuZUtoS29SbHhYbm1FRTZTZVZv?=
 =?utf-8?B?OE05NkluVU9kc1dNZDU2cFJIY1hjNGN2eWtvNGJDUjBadFRlOVVrMlNuQTI3?=
 =?utf-8?B?djR1MVZYTTY1Y3BkNCtjanZqN241QmtFNk9jU2JvRG84dXp0alRYNkozRDg2?=
 =?utf-8?B?SnFTN2tzVXMzajFueG5HZFovcXZoU25vcy9RM2IxdTljblJWb0hKNS9NeFZD?=
 =?utf-8?B?c1NWcUtpaTRnc0JIeCs1WGtIK25XOEthcGlkeTQ5Z2RtMGp4QnpuN3pOSWFh?=
 =?utf-8?B?MTQvZ0pDSWpDNWFJMlo2MXkydEJlSzgvS2tRR0VPVE44dU5mNU5kWEZlYmhT?=
 =?utf-8?B?OUxPRVp5VUxJRHNreEFCNUxoWURCQ2dQNXhOUE42M1pzdDVMRSs2ZHFpcVp4?=
 =?utf-8?B?amcxQWN2T0VJQ0ZpaWlXb3NZWUY3N09GbWIzeWZPNGx1aFQycUVBZXJQWW5C?=
 =?utf-8?B?Smo5NkVWTXpqdHVGVHRpYm4rbW91STJ2UHNqd1BDWXpWUnFULysyZWhhVHVj?=
 =?utf-8?B?VkViSHJLUnB3aTdGVmlCcXJ1bEJnNFEwdXZQY1ZhajhtVjhVWUxzc01yNjN6?=
 =?utf-8?B?czhhNDRvTGZCMjZVSExIM2pSSW5UVXIzTldrQ0RjZHdobEhhSFd6WUhDcXpE?=
 =?utf-8?B?WXZiZDRSc1V4c29OWlREenZpTGlrcEVVcUFpMExuYjAzUC9zQU9GVUdkZHNT?=
 =?utf-8?Q?+rBYe0r4P9o9Awm/c9vZLBPjA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f59909-24d0-4877-1f7e-08db677b0854
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:17:12.3171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApbNW9UStcQ///D/ZXZwGk3JrPfQ59riCmpflhMgmsz2BJT/xKJUynG0Gb/an9d6dXCNQg+vmUT02mhlQbLz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-06 12:24, James Zhu wrote:
> Add event age tracking
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   include/uapi/linux/kfd_ioctl.h | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 1781e7669982..eeb2fdcbdcb7 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -39,9 +39,10 @@
>    * - 1.11 - Add unified memory for ctx save/restore area
>    * - 1.12 - Add DMA buf export ioctl
>    * - 1.13 - Add debugger API
> + * - 1.14 - Update kfd_event_data
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 13
> +#define KFD_IOCTL_MINOR_VERSION 14

Bumping the version number should be done in the last patch in the 
series, once the feature is fully enabled.

Regards,
   Felix


>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
> @@ -320,12 +321,20 @@ struct kfd_hsa_hw_exception_data {
>   	__u32 gpu_id;
>   };
>   
> +/* hsa signal event data */
> +struct kfd_hsa_signal_event_data {
> +	__u64 last_event_age;	/* to and from KFD */
> +};
> +
>   /* Event data */
>   struct kfd_event_data {
>   	union {
> +		/* From KFD */
>   		struct kfd_hsa_memory_exception_data memory_exception_data;
>   		struct kfd_hsa_hw_exception_data hw_exception_data;
> -	};				/* From KFD */
> +		/* To and From KFD */
> +		struct kfd_hsa_signal_event_data signal_event_data;
> +	};
>   	__u64 kfd_event_data_ext;	/* pointer to an extension structure
>   					   for future exception types */
>   	__u32 event_id;		/* to KFD */
