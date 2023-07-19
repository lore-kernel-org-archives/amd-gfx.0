Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAE5C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 21:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134B110E51D;
	Wed, 19 Jul 2023 21:27:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284DD10E51D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 21:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6y6uaqUTmG1HydbRzF51XIMvUqZBdT06LOE6qAXrRDYhEI+aHT92OKWNYkGyp1vMDRPFMk27XUbbxZIrQVaSrXgadLqUvdpEqBMvpbL3DciONdfMsoc/eagLK8RRvq4DGTAG7ITXR9/cZS7mbDeQ9/VXWvUxGoGU2azKaZJLFIB7z13n/qFFAv11/LULbLbCdEMWoN4kcX+4/Pm+ouRh55qTQ9s+8vCmCnqpoCjSoI3J1bVd8R4uKrQJRodxQSdNvC/y4mmbToow7WDk6J0DSMpmszqGNoWQDb9//+4t39bCoFH9MubC7/zuzNJ/U41Vg6Oplgp5z5X4+3aylKIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hde+2EhsoidZ/9m6DFgp1SL40LbdlCSRxOTUV1CT+LU=;
 b=nUdzx1oeON4pz3ip457vlIh2xdmwKDKE4w0FM+27w+1f1TMrjY7RwDfANkvOGqKEyZPJLTHetOkl7++vDC6SJUQubzmepcL/v2bEyX4tTOLQJuepM/bB7z8+nV776clWnjtE6wHkxQf0m5WLOEFVKE3OdfXZB8YryalY1fjSM0hfjTMwRp4vspnGUMXc/44oqhxMWXPEimqmIsrnl6VvbQpdqhFH5Q8vx4BijARP6tr3Ymbkjw2gz0M0uXGceN23Nda7jNi7h4PLkv/F3sIZ4Ss/XhJXRWj7RsVqB1Ay3z7Ca/tC4ynhNON8quyfVh7/2Xkp/NPp9d8M0SQJNU2DIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hde+2EhsoidZ/9m6DFgp1SL40LbdlCSRxOTUV1CT+LU=;
 b=frU81IXceyMka6hov/GvS1u1Ipe032IDa/Je0U63KJPoVKX+GDSs15+DeDYUcK8Fbrrm2sqPnQAwWqYsuoVDXwteWPAi57LoGtoHMf3jpZZWFQC7Zf4XTVEF+DkvbFZ+J+5fzAFK6s//RF9nBk6APLFy5dLB5wOSg8hW+JYJE38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 21:27:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 21:27:12 +0000
Message-ID: <11fa116f-87a7-38c4-f266-d19354bf69fc@amd.com>
Date: Wed, 19 Jul 2023 17:27:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230719212255.30960-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230719212255.30960-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 171ef6e1-46df-4def-7232-08db889eea8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRwvJByKJOiMY6TqddkkIns7/U6RQbbas4PLHvq11yN6A7DEOdHGbj4T83/N/A4bX2tGCdS+CU36ToitFiO1GO3co44c2ba7AUstg69vxvZ8HJ6N7gXJ/hENBBwAiYpJgBFlk5NiXZBHuVsjAa4d7j6MGdxUVVi3jnCbyAeSEdVScjgUDC34fIEODPtWviynnMEaxQOL0vuF55yJYW8juPUSQhyKyCVaxeQ8F8ArBO6AzS9dlAzyUrLjn+HchPu62gpecV9J32HWfQ5kg4MOQF/MD0iQEfOt7cb564ep5Vx4cXIYG1YEPXvC5GteYXkS6HbadA1/YV7ZigPOIuyDQA/RUuHfsSKrQgNQkcdmgXwAyZV1F95BYc6uNHiFNBwbkj6fw4aAAPy0ivy+KoJcBHXGn4sPnmERdC171agaRIRZpI9dX2ZZoIA26MJDz3R1hORsohh3btAH7nYWtntE87ncJE7hMAVv/hhPgn+5H+L/h4qGH4IxwbDl0h4PxegpzgG796VvOj0//Z1IiPMAoCtboZJaJPvSri6Oc5+x29gYduchd671KgJEjhSYAYNe/m68lgd7UOYaf6Ih7FcvgnOAUY8CxFexnZTVkfqPr+Wld58iO7c4/xUl4M/xJMoucENI1t7Vn+GOuCTFlwNl7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199021)(478600001)(26005)(6506007)(6512007)(6486002)(8676002)(8936002)(83380400001)(44832011)(5660300002)(2616005)(316002)(4326008)(41300700001)(86362001)(31696002)(2906002)(31686004)(186003)(38100700002)(36756003)(66556008)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVibHFZVXlydy91Um5GNExOQ1lzSFpsZGhJcStPdlJUWWtJZjhuSXBPWktX?=
 =?utf-8?B?aVVRbHdDM1NRZTR0WkVLVGQwaFY5RWNraGY2VDBPNlZkRTZ1VVpkU0lXNVFl?=
 =?utf-8?B?clpHdzVFQzQ3MkdaZmI0Q3VVbTZtWnlKQ3gySExVNDI0V0k1elVhU2h1NXB4?=
 =?utf-8?B?OUZ2S3AwVUV2dU9wZngydWl3bTJENTBBV3lvQklRUVd0ZVJBZG1zS3BpdE1n?=
 =?utf-8?B?RFN3WGtBTmlTR1VpQWc1QnpyQi9td0NSTnVjaFgwbG13eUVHZ1p5RXhWN1B1?=
 =?utf-8?B?Vk5HWHAvT3VwMDRaK0JOT3diRmNDb1lIVzJldGV0QXhHRlYycUc0d2Z5SDFS?=
 =?utf-8?B?VWhiSTk5VEpSQ29VaEJxaDBvazRSYzRtc2h5WmYwaStkckVoU0c5SHBxS2NZ?=
 =?utf-8?B?UnBES215cTdUSHlNYmVnL3ZDYVVKWjVFVVpuT1h5VTBhV1ErYW9ma1hxU2ly?=
 =?utf-8?B?TjhqaUh3L05lc2pDR0ZaeHV4anpXeERiQmQ1MFpKdHpBanNURDFYYkpTVUJV?=
 =?utf-8?B?YTYxa1hZcGNEUDJjSDBGdzgxSXJVK2VHejVNS3B3TklkSGdTaWVnOWNFQXBn?=
 =?utf-8?B?MWxOcHNDcWJ1dFpZTjBka3QzaGQwZEY5ZXRBV1VlVG1pSWx5OHlxalNIY0RS?=
 =?utf-8?B?eXJSazZicjFReEdMNEpIQkp5NWcwcmpwcStGellJSFFpcm5aM0hvR0o5NCts?=
 =?utf-8?B?cEJLcWlMSFFibUpYWDNtTlhHb0NOODZkN3BIRGFqakF2MUc2YVVtVDNlRUI1?=
 =?utf-8?B?Z0p0QVd4Tm52WVFjZ3NBeW1HbjFWRzJmeHBVTC9qcXJRMW16K1FxN2RxRlZy?=
 =?utf-8?B?SGhhS2pJVEp6Sk5MenBiNHpOcVFzODZwYmNCc1FoWVRoQlNNcldlUDgzcXZw?=
 =?utf-8?B?NGdBd0x5VmFoT09vY2d1Q3p4di9GanJMTnFVODVrMEcxMjljNVk5cWRxQUlC?=
 =?utf-8?B?SmZGLytSZmZtbzNjQzVCTWd2RkpkUDRnVVRURFMzNk82YzlRdjJBcGxzWTVp?=
 =?utf-8?B?RzNPalpzS0xRU3Jhdzh3d2lxZE1FbzArZ0tmSmlVaUZqcEN2dU44dXRnUFFw?=
 =?utf-8?B?V1M3Vlh4dk5wTUJPdWZvdjdqOVJzM2FRWnI1a0dQREM2YjMrQTFLOGVpZWZK?=
 =?utf-8?B?aVlWS09kb0VYV1ZUUWE1Nk5FYXVYUmdPa2piVW4yNHl3MnNTb1pSMWZpWnJk?=
 =?utf-8?B?YlVNUW85SXBnNjM0cDUzSnNhVFpVbkkwREtzMGo0MFpWRitWSnJNWCtSTWQr?=
 =?utf-8?B?b2Eya0hzdjB5RkF1UTU2OGhHbVpEdW5WdXlvcDY0L1NsV0ZTK2NWQThOb3NO?=
 =?utf-8?B?N3ZTNGpJKzlnZmMrNldaaS9NYUladVZUZEFUdU1mbCtFdFNRcHQvRmxFRU5q?=
 =?utf-8?B?V3JyZTUrSjRnNTZOb2FqbEFuVVF2dk1ZVzlPeHQraHZmcHc4VXlTa0JGN09p?=
 =?utf-8?B?VmxXOG1Jb2IzcDJpOEdjbUNpNlBrbmxvK3NxRXpQTSsvZS9sYVJIbHp1L2Zu?=
 =?utf-8?B?YitJWHFaYWpXS0lOMVhGWTgwQmNzV0wvUTE3dS9Cd0w4UTVGYWlRT3Q4bWVv?=
 =?utf-8?B?VGs5U1kwWEdnUEN2V2h0dG9wd1hWcHlDUHdNdVFidGZQa2YxczFDVm42TmpH?=
 =?utf-8?B?cWhVbVVQdkZyOUxxTjliSHV0OGMySW9TcHZVTjRVdmluTlpNakd1cHlJbkxy?=
 =?utf-8?B?dnZ5OVhZb2c0T0tpRnN2NjI1YzhRcWlzbmVUUExmeXdndGFsL3MwVm1PQ28x?=
 =?utf-8?B?VVVMQ0JIYkdwd05TcmRMMEduSERWWkVVODRlSnhUVFJhTXlVemtxN2gwUUFJ?=
 =?utf-8?B?TVp4Wm9XOGpldXFReE9mYTVQMDdLZ2ZlRkxoeXAxZnFoaUxnQ1pMbHBSUCtV?=
 =?utf-8?B?dCtySGxJa0JRMkh1bS9MM1VWRUxGWFQvOTdTbTZWcUJaZDM5T2x3b3U1YnVl?=
 =?utf-8?B?QWVRdU83QUNJTkZUcml0cUFwZ3R0a2w2NzNiSC9CejdJVE5MdVJVY0xaWHpt?=
 =?utf-8?B?RGhLMnErUjlqYVpoQ3AyYlFnWFgyTlFNblpINTdscWFnWFdrSmF0UXY1QVI3?=
 =?utf-8?B?YUljN1ozTFVrTmlZWmMxQllNbkc1R3RoMER6YmtFZ3plcWttMElQOG5WN0hV?=
 =?utf-8?Q?/pLfDFlc67auchxnn51Qdzx2R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171ef6e1-46df-4def-7232-08db889eea8e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 21:27:12.6383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqD8VUElPrQ9Hgt6xFGW/YlxRYNq5aFhzWtT++pmTLAZy8MQKpybb1gNcWHdc5BJxTEjN6gq3M3xUwLz3qBbJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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
Cc: Philip.Yang@amd.com, jakub.kurzak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-07-19 um 17:22 schrieb Alex Sierra:
> Set dynamic_svm_range_dump macro to avoid iterating over SVM lists
> from svm_range_debug_dump when dynamic debug is disabled. Otherwise,
> it could drop performance, specially with big number of SVM ranges.
> Make sure both svm_range_set_attr and svm_range_debug_dump functions
> are dynamically enabled to print svm_range_debug_dump debug traces.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Tested-by: Alex Sierra <alex.sierra@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

I don't think my name on a Signed-off-by is appropriate here. I didn't 
write the patch. And I'm not submitting it. However, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 479c4f66afa7..1b50eae051a4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -46,6 +46,8 @@
>    * page table is updated.
>    */
>   #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
> +#define dynamic_svm_range_dump(svms) \
> +	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
>   
>   /* Giant svm range split into smaller ranges based on this, it is decided using
>    * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and alignment to
> @@ -3563,7 +3565,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			break;
>   	}
>   
> -	svm_range_debug_dump(svms);
> +	dynamic_svm_range_dump(svms);
>   
>   	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
