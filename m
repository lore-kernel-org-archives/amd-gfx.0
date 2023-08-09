Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEB0C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 19:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D3F10E49F;
	Wed,  9 Aug 2023 19:12:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A144310E49F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 19:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC9+u3sw6BrbzHN2I+IOwxh6tulQi6q4xRFv0os5CZI97QM13cmFxfDxIs+SiYAGlmbsaOp2eQIwIxTei0AKiTfFmAxt2umSzR93j1txEf87OktKg2ClKROE2tmaKermwDvSFI5ntEwmfcj68AozEa9cHQTBvJILHw4dToAZBFaIc9AmZ8l/fexTbO67PGzG/ivGqxnjp5Tm+9AAU1w1oLtdXUG4wuQiNGpfpnqJq+JvYxnaQqoJ4eh8BFQQDpfYffmKd+OCktxYbnYE6U8sJrrMKQekan9RuOKpwrazC+UohgD+76Zdy1VRFJxmCbuf6MlFm19fU8+VhxSiYK17qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va/qNRqpfVi5XE8vw9LwfzvuXKfx8GYR9tMMRelfX2c=;
 b=D63xWfMXWquDjp/QG4JoN3RG6Sa2SQFFzLkDzmSFRjYBQmrEw0aftudGJfu8++TLp9zEOfpghvm+C0ER5rWIOkfo2ncwwqruCoX3VVFs0wfJ5GikDJQ1vAqgmGicmdzUojB9JNl4UWky7oPGSYuQWgjrOCfdFrs8202ex/hRwCMuxnrjcc6EhKtkjGFRG8TRepInpcJPyErUVMaDMx0Hw3ayjzA34au/6jauBEqU0+8iEF9hF7tE+1f5p0RB2tGyvR8yxrvJRF3/95Uo3QRZj9WQ+/8p2R+D3+Quwdbh01ZpPWGbC0APNLpxvGdJlzp2DFgl6I3VKebnrBn/MgEecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va/qNRqpfVi5XE8vw9LwfzvuXKfx8GYR9tMMRelfX2c=;
 b=nsbJEogt3Zt3G7sw+FhGTIGwHXYxeg+UKDHnQS38kmcx+Ll1V+W20EcD4jaROCkkbyCfKqTjgO80g3Hv8RO5gcGVrCFk/IsrR6o03sbUjEW07Ji0Zw20IL1yIxwRIzM7PE7gWwDn6Jo0yST/pQ5Jhclq/3DjW2tLITtYOIDPiB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 19:12:20 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::aab4:88af:7781:60e3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::aab4:88af:7781:60e3%5]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 19:12:20 +0000
Message-ID: <44377060-25b4-adaa-d003-210434b94de2@amd.com>
Date: Wed, 9 Aug 2023 15:12:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amdkfd: Use memdup_user() rather than duplicating
 its implementation
Content-Language: en-US
To: Atul Raut <rauji.raut@gmail.com>
References: <20230809053018.88004-1-rauji.raut@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230809053018.88004-1-rauji.raut@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::7) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b7592d-d940-4506-d16f-08db990c8e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmFhw59E6V8VPOXuxXN+hlm+iV/gLOVb503nCymbId6wm1L+V244rIlTHveLB/gim83ZfiWfEbjVSmuj+ZQLj0R7Oo3X5iLLRqmPQAuDW81QsvrjjG97YhkyLVnP54s2j6uZVtoTkuE8Z9naD4b9aXBQpUay4o/VCgtWcLGEGMSiDvGA0/DvDF8KS6FKQrHzT37KlF2msn//kXaTMtVRL7JNpWvhQcNZNGf1vM7LO4gvSEVNxydtJTHIWARDGMArLiloKucjVzU48EkUewS6/9W7uhqtDty7gNO3+NGKSDDsms+Oc8B7dLQZFSSA3n64rxaYVScgjc6/oYYkEyTc2rcgTomgKajTXuavHXt9dnWzYPMTIKKxIgAWHRMmZUnk/rQw3sBJmY3QRuvm4mh+41csBVOX+qhCIqPjHVtVsHNgRAgN0A4kvcHOIsIokqxFgNwM80vL0Vl0lnb1b/x5SRtxqUZ2/yFvo4a8JVXsXUAfKMV6PVayLhTWyBh88k0UNymRQRWy/6cySILxG37HUzDwvyrqVG0+rF1ZytPisj51Hz0WyAoafupqSKL2Xi30aGlmMbykHsjnbENOh/kj+Iu31TIp97/t6gV9r6LaPnyIDRqMA3AGEv+JsekGX/lgpAQ3xaimty2jdDxemnmfcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(1800799006)(186006)(31686004)(86362001)(4326008)(316002)(66476007)(66556008)(6916009)(31696002)(8936002)(8676002)(44832011)(2906002)(5660300002)(36756003)(41300700001)(66946007)(53546011)(38100700002)(83380400001)(6512007)(478600001)(6506007)(36916002)(26005)(6486002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnE4QkdzU3NqTGpQUmVkdGNXeDUvS2g0VHBpVEpjV3Fndkhyakt3U2lKd3pJ?=
 =?utf-8?B?WXJUdUlYcFFiUmhNU0Q5dlNGb25HYmlOai80cVozYkZsZ2FuQ29Jc0tEM2tB?=
 =?utf-8?B?bGFaQTdaaURjL1JKbmJ6ZC9hM2dCVkRDclQ4NE9DeXM1OE1kNEJIVk5WWEJX?=
 =?utf-8?B?NWFlbzVscWJFblRRZW9qak9peGY4bExQR0FoVC9UdVBVQ1Vlc1ZVKzFkdm9y?=
 =?utf-8?B?aWp3RUF4bGljTnFwSFNkd2lWNkZBN3VkMU5Nb1NQQWsrZEI5cVUyK2lSU1B3?=
 =?utf-8?B?WnFTa3RXTkFWclh1VHBWNmdyZXNIM3VDbkZBMExQZk5FRkdEcEFLd1YzWnVV?=
 =?utf-8?B?OEcrM2Mxek9vMGd3MGU0MzFwUDBHMi9QdkJBTFdxRFFGUTBNTHI2LzBpMzhU?=
 =?utf-8?B?RTBBYzAyWElPcldYOW9hTWhoNlRDMUZ3Z2EyUkwxRDJ2MVpEZ01POFYvYkw5?=
 =?utf-8?B?T096MkVXZDVWY2JDeE03UEdBZXFjRis3ZmRTU0VKd2Z0cFV3aU82bk9EaG4z?=
 =?utf-8?B?NC9RUXRFc1FpS0pQdlJNWVUzR2dKenVHMDByYVEwb01INHdydU1ZeXdIL21I?=
 =?utf-8?B?a0JGT1lJZTUyd09vWlJjalBiS1ZJUEMzNzI1Q2pGL2x6bkxhb3lvbmJVZVhY?=
 =?utf-8?B?N1Q3U3hKSVVBUFdYVUFGY3VSR24xNS9zWlNiMW0yK3kzTXhtSWNUMWhFUVl0?=
 =?utf-8?B?NVc2dlg1UzdYTmR5b01BQlptRFdaQnV0cUxIbGEvUTA3QmpjVnU0UGpEZkVJ?=
 =?utf-8?B?ZHJqUDljWlZTQldpdkNqSUlLUTNqZWdKcXZvSmxZTW1CMk1iV0ZFMko4RVk4?=
 =?utf-8?B?UWRqcFkxL2JBS2lma2NhVjVhdmhFVVRFRGhSUVdNb1NOUENPLzErRmU5UldQ?=
 =?utf-8?B?UDVvRDZPNHlXWThVbEVuRk5tanNaM0djNG9KNmpTaHVWVFRhRU9xTHZ3L1Bm?=
 =?utf-8?B?OEVyT25nQUFVQ09CY1BpdVNwQUJ5WXFaVUtBTmxaRS9VTm9mY1A4cGV0Q1RP?=
 =?utf-8?B?NzdTeWRzQjVNa1RMZUVPbERSZjNaR3JxUUhqWjc5RG12dTVvZDRIOFNXTHJn?=
 =?utf-8?B?U1J1K25nMTdKNEdUMktsb2g4bk9QWGV4U1dPTzRFVTRXd3lKUmdBWkVweUZn?=
 =?utf-8?B?QWtJVmJBQjZRTHZGWCtkaStBMU1TVmNhNktFQnpJdTVkRGwrelREN3hPUjYv?=
 =?utf-8?B?b2c5TVRSUmxVK3M5ZkFYOE1UU1FIVmJmRWxwTFlRZU1zWGswaHM5S0ZwYko2?=
 =?utf-8?B?S1MrQkllTXREZGZ0Sk5EZkhnTmNJWEJxRVRNUy9DMkxwQWczL3d3WnBwSEl1?=
 =?utf-8?B?SHlISHVXNnNNdnZFR1JSZWYzT1htVUhYV2FJVTE0YURhcU9wZ0VtdzZZU2hk?=
 =?utf-8?B?YkpqWDdGNEJrT2FWWjJMcjdvQStjOExRaDBNd3JxN01FaW1CaDJYRE1CZHpw?=
 =?utf-8?B?NHpOVS9mMTZlNnRUMi9ENEpDbmJHQWJYQm1KOVlpbCtTSE1TZklsb3hNV2U5?=
 =?utf-8?B?Nkp6cjdDVzVrWE1GbnFIOXNtRU00Z0YxNlNFYlA3MjNMbHZnY0tPMDU2Sk5k?=
 =?utf-8?B?WmlIVWI2bGErR1RrVE0vRzVNZU5kWm5VNXFxK1NUNTQxaDFTNjRVQVRuNHdP?=
 =?utf-8?B?WmdDazVzZ0t5SmRaTmtOWkhNWjYrVHc5dXRoVlBQTzN1ZDZicURsY2xiaFZi?=
 =?utf-8?B?UVRwTExaQVQ1dmtiY0pTZWFObGdvQlhNTXdIVElKT05CRDBsd0drRi9ROWt4?=
 =?utf-8?B?NkRtSW1KcndFS3VVOHVnakpvcnFHeGNZcThkdTg4SXVXL296a3UxK2Z2ck9u?=
 =?utf-8?B?d0JmMFRhUTQyTS9iK0hCTkFjMUh3NllIckovZmlPVHFJeXM5Y2UzYVExZktw?=
 =?utf-8?B?cHJTOXpOUFVqZFgzZlZrZWlseHEzWks5YXJQamlQZ0hWazM2YlNNT2VZYUJ1?=
 =?utf-8?B?NmZFRmtzNmFHTWJnNGpxbndhSGhaclNSMC84c3EvN0JMS0lxSHNhc21mRHhT?=
 =?utf-8?B?YVhFL2EzK2ZMcUthN3pBMk5FcDdxd240Q2d1MDBMREVRcFF6WU02VTg0UUV0?=
 =?utf-8?B?bjBSM2ZOTjJtZmEvYmVuakMzajdVOVFVbTg0UFVqL0NSWFZ4K3I4NFlaUTht?=
 =?utf-8?Q?l0l8A9MXbrrcjLMcNwnDGP23V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b7592d-d940-4506-d16f-08db990c8e13
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:12:20.7226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tViPOH9y8IrPWkq+HdAEwtBQF01/0cBy3qQPCGP0972zlHWSUKaddnRjhC9l9UMLEBceyi23q3AOB1F/Xrptlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152
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
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-08-09 01:30, Atul Raut wrote:
> To prevent its redundant implementation and streamline
> code, use memdup_user.
>
> This fixes warnings reported by Coccinelle:
> ./drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:2811:13-20: WARNING opportunity for memdup_user
>
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>

The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I'm applying it to amd-staging-drm-next.

Regards,
   Felix


> ---
> v1 -> v2
>    caller checks for errors, hence removed
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2df153828ff4..df9b618756e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2803,19 +2803,11 @@ static void copy_context_work_handler (struct work_struct *work)
>   static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
>   {
>   	size_t array_size = num_queues * sizeof(uint32_t);
> -	uint32_t *queue_ids = NULL;
>   
>   	if (!usr_queue_id_array)
>   		return NULL;
>   
> -	queue_ids = kzalloc(array_size, GFP_KERNEL);
> -	if (!queue_ids)
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (copy_from_user(queue_ids, usr_queue_id_array, array_size))
> -		return ERR_PTR(-EFAULT);
> -
> -	return queue_ids;
> +	return memdup_user(usr_queue_id_array, array_size);
>   }
>   
>   int resume_queues(struct kfd_process *p,
