Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C060C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 22:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6FB10E21B;
	Tue,  8 Aug 2023 22:47:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B28D10E21B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 22:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7PVCFPLjSjoOA3ZWwoosssHxw+oSIJN/pvpP2QB6nM6khlmt7B4HyckXgjwIQrE7fGhucAmAfuNU7dCSV76ONZLZZW/I9+fJb5YSgXySyiEzCN94lHSAzoFmnPmBRQIs8gdfzDELbi/vosGrZKhkg7mqy44R9pgIqVNurZbXScU6WwkDUn9ETN3s2aItMHMlnaEzMb5cT6kpTMyZU4g0ZoZqWxI+MW431Z9o1+2IhK3YWW5oTKVV/utpsQ3dQyNKBLKJnYT5G9PyU2ERDGsgt50ooJ498hIyXqv9w5K5lmiv47jsgKA7fps09sX2c/bTlXLRo540e0a4ekJHCF5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoLr71XXqX86kM7K8t6jK2VhLb8AKB1LlX6/+DAitPg=;
 b=Y2KgC/qHHqRSxq/E36eP8W7HdhYl1kDceXfkcix2Xs24dpP5WMuc9uzMud54HGlB+BBpd3F838QldHc4AsTSA6lx1Fz9dYJr1U/B//PKocCbz8m7SeL48JmUmJEDTTazdmfn7JlYtCDF6TSdyJUTt6EENYD55mpgzZ3QMf+aN3CPrtJ5q3mw0cmaD68KYK+I2+ciG1adtJQoHrhSffPulx00vFjnk0Kxo5XTxU2puHiH2XXu+ySNMpE38g68fjsIuotvxJBHN002RiSq6wo4FQHJ0EDKbno4UaldusbwBXc8t9dN9nttDJEOYPCgozxxksL6GdRTb7xgpTKrF4mtSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoLr71XXqX86kM7K8t6jK2VhLb8AKB1LlX6/+DAitPg=;
 b=PLloOUDWcwlKPhpYokObxXCnyH1dsPUB/cC5/PBgTymz1ueuNX4yu+8VRUHwnzkfaFTT8MoHmY250u4CoMpQUp9+KizUbLQS5sEE81kHd5/SFV1McnBOkKC0Gv30dGF/hkeTW+3GCNrfEqvKO12RZyHqmURTnrXYGyrgZbDvpfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 22:47:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 22:47:10 +0000
Message-ID: <8370cf91-66b5-d96b-fed8-a38eb488a011@amd.com>
Date: Tue, 8 Aug 2023 18:47:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: drm/amdkfd: Use memdup_user() rather than duplicating its
Content-Language: en-US
To: Atul Raut <rauji.raut@gmail.com>
References: <20230808205752.23704-1-rauji.raut@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230808205752.23704-1-rauji.raut@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::43) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: f118fbfa-5c16-4219-b4d7-08db9861669a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ap4CHnMPh+vkIGGu2cGKOI94IDDT6aH9VGch8wWJnereDZa1fXulAqWDwhiFzMx/9ISPgEB5GsYjIMpTAHpz1gi7IT75NL7ocU5Uaqdoe89az6CSejx0Z7+6FglWtgzr6yRR0olVHKiBWcKdjU1cmNiG6p75g5V2rf1DYRPMMhx0NpSoC0mABcgnWCr5JXC47Ky9QxqGLQUZqphTd0UJvz9MqZiKXHF5UYajOxAE6RhLU2R532XqwmrtPIrnPdxNkwtN/P+dCNIjjaSMAXljrNfm/6LkeysCwwfJOOD+syKmEi4ft8jRGz3V6OO48hA4ftDijTpkS3MQ3TSFnuYoVwMkhUXSf6ez7xAKNLvvUBIIgkZW33IYBFS4AmoVPoJozMMTCHF6eDt3Hfsh3bdVvn9qE7B0chAyIrP27VuS3iVOcj+aNkFVSv1CTeVsUKnmjnR2/4eUQFmCMTXmHw9/ad2wgSwB8dyHRWkJGsOrTwUKiMAh7JhLgUFN1WfQoDlkOM3rycSYPnVDI9zg0czjE0l4B0AG+alCxtZUV+qxkLOwHWpyoj+++6Q08jdbSZuArqXR7VIJyBwtPaBHtsArkJIEmKuc4aMnW5zjWBrXiR5ZJe6qEbkaCsGb3bqXhn21xuB0ProOyqE3HVM6o5lasg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(1800799006)(451199021)(186006)(83380400001)(316002)(66556008)(36916002)(44832011)(66946007)(66476007)(4326008)(41300700001)(6916009)(38100700002)(6486002)(26005)(8936002)(53546011)(6506007)(5660300002)(6512007)(8676002)(478600001)(86362001)(31696002)(2616005)(36756003)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JKVUxITmNIdWhUMWpnd1ZPYUxkVFcyQzdxT1NjVndaaFljSnpyQkFmQ01R?=
 =?utf-8?B?QkVpNWNMbmVaNUplTnRWYkcraSt1cjZEUXFnajZGbzVrSHhmWVVKdWl4dzhD?=
 =?utf-8?B?SW93Y0tTaC9kNEdzK1lZTTY0dC8xL0UxeEhURzNvWnFMbmVQazF6Ly9BaC91?=
 =?utf-8?B?d1hxRTVBNXpUOFF5TEs1RTZtak96UndxL1lYVWtKb1BhVnE1UGlzZEVYdFFR?=
 =?utf-8?B?MGpaL3lMSUZIa25KRUZUT0NtNWN1dnpVVUs0OXNRVWpEQ2hNYXJEVTNOVFls?=
 =?utf-8?B?Y2hPY0lIUW1UMS9qMmh1SllaU0tQSVRNei9BWHREZVJ4d3NTclBGWXJTN01G?=
 =?utf-8?B?WnNSOEVBeFNGRHZJenRrYm5ndWp1SU1mUFNCcFZvZWIzSUxVUlk1emM0QzRa?=
 =?utf-8?B?U1RsdnN4QjNXOEpmZDNQSlU5SFV4Qy9RV1FrUXBWTFFxUk1vR0xjVVJ6bWVj?=
 =?utf-8?B?N25XcU9JMXl1aTFPZTBRSHh5d2p4RktEaWE3elp2V2hZTWRQQ1I3TWFzc2lm?=
 =?utf-8?B?dXNGZjFNOXl3dkFmbTM5cjE2SjRGbkRGMnk1RlJTTFBnTHdtTDc3cFJtbm5x?=
 =?utf-8?B?a1hnQnY0VW45SmhFRmRad2poZEVYcytCa3JOY0s5NEs1c1FMV01pci8rOUIy?=
 =?utf-8?B?THhHak9XekJPZTFOMTRaVlBpSGFyNkR2WSt1RHR5SkFLOEI2a0dLcFpuRDBB?=
 =?utf-8?B?WksxRGhIQy9XVnk0YU0yK3BPdjN3VVNZOEo0UHp2bnJ2UEZPWGs0OWRzUHJo?=
 =?utf-8?B?bFVZcHJsbjBwaTFnRnVvN2pZekFoOExYNVZCZmxmakQxWmNPdTBwdWloN1NC?=
 =?utf-8?B?ekZSVFAyZU5kZWpISWVORFlVK1BHcW9WUTh3UXRrakFLakJnczdON2xNaFhn?=
 =?utf-8?B?bngxbDBRemFXL1NNTXh5UlpteXJkakwrbzNvclJWL3V1YkV3K0dMZzZKNytY?=
 =?utf-8?B?N1hOdTRkRkZXSGxtN2h5SzhRTHcxRmhhTXl4S1FxbGxYMEJxeEFoWXRIcXVL?=
 =?utf-8?B?aEVZSXJpU3o2d3grWnR3ODZTVEhoUUt5OTlhUnp5TTVMNDZ3U2I0b3NUb0Q3?=
 =?utf-8?B?ZTdGaWlycUphY25aeUVsSlc0dDRLa2lrbVFmTEpubzJOL1liWFhKck4zdkZF?=
 =?utf-8?B?ME5MV0kwUkFVQzlpV2w1VmFKYmVFSFBmQkFhTVdVT1ZrM2R3dnZVT1c5Q3Fp?=
 =?utf-8?B?bFlIM1FJS21kUHQ1amRDYTd5Y2VscE0va2dqWERvdm9YT0h1aytSYWpmOWFE?=
 =?utf-8?B?M0FIeTlZY1poNytXYVVwcCtGQjlTaFhESHYzMGhNYWc5amF2eThmVDNBeVM2?=
 =?utf-8?B?eXBoaVpSYndsYmVaUmNYZDFxbGhSTDRnZXpOK25TSG1CSHFsODRtZWR1cDNu?=
 =?utf-8?B?Y25NSW51UFJVWFhZRGU2VWRhMzFtOWxBT2xBczJhVG5FYjZBbkNSZkFDa0Fn?=
 =?utf-8?B?a2crWTlEdGZXczBxQUoyME85MmR1eXVmbHRvOFdvbUhhMDVYQUQ2UU10dGkv?=
 =?utf-8?B?OThGMGg0Z090WUM4ZTlMTHIwTVNKcjN4QzJLZDNpaXhjTWd3NitpMUNYaXpD?=
 =?utf-8?B?cGY2VWo1MEJiLzRQYUdUWW56emlMa05pWHhaYjBvZWViQ1BNcFRldlMzbk1z?=
 =?utf-8?B?RzFyRkZhc3lzOEJoQ0hkQlFCSVBHUVhQZFNEK3hMcENjODZHMlJ2ZWVMcURH?=
 =?utf-8?B?NnRJZC9ub3cvYUVqWHd3aWNzRXN6elQ5VUc5Z0haTDVFb0hWazdtNktEa1lO?=
 =?utf-8?B?cnVUc2l3Z2pXZW9jTU9YZCtNai96RnNZQnhURXliak5YS0NlVnJFaXNQY3Aw?=
 =?utf-8?B?ZnhOQ0Z0eWNncFFRQ2NyTVBEVCs3OFFjaTdybS9qWjZma3NnV1A5QU42K1FH?=
 =?utf-8?B?RVA2U3RoOFZxQSs1cFFWY2owR1AybEt2a2RYMktQUVhFOFhMMk5TMU0rOTdM?=
 =?utf-8?B?RFZxWDBLYUQ0cHRIVmxodmlTSjNRTFJHZmJYSUg1NTErZTRtVngxVXVxL21T?=
 =?utf-8?B?ZlFCbjM0TzZYUVpNQnBSR3lKbG5udUpWUU1QcnVmaW9kUlFwd04xOWJhUU1M?=
 =?utf-8?B?aXFVK1NzcUJndXhVY2ZHWi9UYWV5b0hlQ0lrSGIreEdmWGIwanBFcXU3Ujk4?=
 =?utf-8?Q?zudfrMh1n5BujI1B/d6zU9jzn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f118fbfa-5c16-4219-b4d7-08db9861669a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 22:47:10.4988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQsnqUeGXmqgh3Qvmj5uoWcTVZj5fvWS+jsEZJmVNK0YKFdRWbxSTXpQBMwCPupko+O4wh1MmQaPOhwmF5yU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569
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

On 2023-08-08 16:57, Atul Raut wrote:
> To prevent its redundant implementation and streamline
> code, use memdup_user.
>
> This fixes warnings reported by Coccinelle:
> ./drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:2811:13-20: WARNING opportunity for memdup_user
>
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2df153828ff4..51740e007e89 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2808,12 +2808,9 @@ static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array
>   	if (!usr_queue_id_array)
>   		return NULL;
>   
> -	queue_ids = kzalloc(array_size, GFP_KERNEL);
> -	if (!queue_ids)
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (copy_from_user(queue_ids, usr_queue_id_array, array_size))
> -		return ERR_PTR(-EFAULT);
> +	queue_ids = memdup_user(usr_queue_id_array, array_size);
> +	if (IS_ERR(Iqueue_ids))

You have a typo in the variable name here. Did you at least compile-test 
the patch?


> +		return ERR_PTR(queue_ids);

I think it should just return queue_ids here. That's already an ERR_PTR 
in case of errors. So you don't even need the "if". Just this should do 
the job:

     return memdup_user(usr_queue_id_array, array_size);

The error checking is done by the caller.

Regards,
   Felix


>   
>   	return queue_ids;
>   }
