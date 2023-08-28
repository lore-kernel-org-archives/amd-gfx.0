Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172BFC71153
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 17:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4FA110E091;
	Mon, 28 Aug 2023 17:59:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6B110E091
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 17:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INOvkjzx8bN+xNtS0ek384plDKmEgF3Cx/NeHBwaaeTW7RxyW9uDfUoKVSxjHhWcNcYdgSrSrdiARTIt94A/cR52xdqiGjogBuh1GtUn+hRsVJiO0TK2A9facgBj3bq558GiFnkJOhLFwl8s8S8DcBukREjIovrrn3oeNvh9H4y0LuJq/KdHQ9a4l5SZfpXqsbK3wVVc1Num978KIFQPa+dZwbFZrfliyIo8zPiTfocCYs9yRuGITdhupBIv/uPPeJRIiONhB7l7Cz25PuilU/jTQgAh+lSpZghA67jUN4A+gLjvb1YNQtZOtpXmwKYXEfLtK3CD8aeGuokJOOamdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTp3iXvuKErrXXv3RPAyjrbDcAnwkt98AiCQ8EIbijM=;
 b=PQl1L/g9Tqkfg9Vw6yeaUUNHMuR2QU+Jka1+676+8NjqXKAOrXzwncKTtiN4WKS93RxMS0b2g22PSO+9CNewwtIoxRmlCazIOqRrohyt3qXNpAwiGZB45PO96eqpnerA9HJpIyMTUTmoaRxaZ/DafcMgeOUPk2ww1oWmbfY7REEs0s/z026mq7ZxixfxiuaCMkEA4vZIxur9oAvMSaYd1OAQ47ymUkvRDhmi88jR8Jf2r/Sq/goldCCuqHDEt7g/GIZnt3EpjiTpwT7LzZo8gDJxZMTKBrX8ncnvbZN5AWvLGUS1d/iocHwX8PSLUQwmXFsn9ihx+zrThLAKe+gxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTp3iXvuKErrXXv3RPAyjrbDcAnwkt98AiCQ8EIbijM=;
 b=zoslL3yhdmj5A8Vkg73x4Ovt722l5OxQ4DITGI1n10XThV+4F6HeujLW8S5Xba44EU3utthkNaU/ya+QZxaVyUfCVCeZAegaDMsqX3wE3SMP1M+dHtmPk2V9lggfUkIPjjjTjFsR2TowY1/l4fGxGrUObTJJbazTmON6ih6KV4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Mon, 28 Aug
 2023 17:59:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 17:59:51 +0000
Message-ID: <6e0ec1d4-2f71-a4b4-4a31-6a4da836522d@amd.com>
Date: Mon, 28 Aug 2023 13:59:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: Add missing gfx11 MQD manager callbacks
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230825213029.194197-1-Harish.Kasiviswanathan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230825213029.194197-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 086cfd29-5a7e-4b2d-3420-08dba7f093af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6POyv4G/0xSmqVxkYdgcmYvGzZt++hPclPqf830Jnd6AzBZXVRRVli+EPMmJ6b9HZrIscNStsZ9Cmh/B/cxRITQG1oeF2USldGRYsuuaLKnf1DxX7XSuxGrUV2w18manGVCOcDPVizG79GiBWXOVaJC2cKRfI5ghMGh/iYjCeDxHnwUPzrXUIgcWhAGIfTm23c5spYsJx5g2cbwZgQvmCxmRjW+XrgOraoHDGaMYMrNDNl+NsH84pyKt7fP5b7uMPd0oc9Pi/+TlzEPsCV205fDyENh2y2J2jaH7Ox1apzpZhqJf0QI5udx8bxZzMLNxEsRFrGr0gtRI+VdskfLkpA9gqTrIwDXmZIaNP/xeJmLx/rku8WR1HcMMtLMUwBClGKPiE/C4/XLvjXagBCd80MzjbRhA78BNWoQq1vFuc8xuq8DBO85SyePhFQiOqh74lE5kZV2qqkHFEBIZVD5kTSGgb2AZrXOly1KFfjKlcS4IzdCKLuzpt0FfLYwO9/Inb+UHKuJRuzco4kMK4rUloBZkxrN/nfDXBRIbVITIOLMmCkCuGTyjr8KNEamL+A/HDMVUlUHC4BzZXAjiKL3D3BEQUZWA1uBBWpg+ORC3esVWxZtbJaigFOqQ/cpSzK1xZfl3Po9z5DTUjMoGTb5/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(186009)(1800799009)(451199024)(36756003)(38100700002)(4326008)(8676002)(8936002)(31696002)(36916002)(6506007)(41300700001)(53546011)(316002)(6666004)(6486002)(66946007)(66556008)(86362001)(66476007)(6512007)(478600001)(26005)(44832011)(83380400001)(31686004)(2906002)(2616005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhkNFdva08wWjR4RFl2RXMwbS9xdWM0TnZnaXJyQldjVzB4NmwvdGlPWEdl?=
 =?utf-8?B?NlQxcS9WOGxwb2pwYjlWeVNwZExIVkF4Mnh3aVIySFNMVFArMmhIcktKM1Va?=
 =?utf-8?B?ZXpwWkpqUmpCMklWN2piYUEvVGZzeXBpS1ZYY3k0Y0I0SWEwQjhnemR0aC9G?=
 =?utf-8?B?K1lpUm5XMzVxRW82QkdCY3g2V3N6bEY1SHNIRWNLRnQyTThaR1hvWS85S3Aw?=
 =?utf-8?B?SUJ3SUdOaGNTdEpCYlM0Q0x4Rnl0UTVhd29Jb0UrdEVHcUxBa1Zvd1lRNVZV?=
 =?utf-8?B?WDF2L0V1WVowVmpYWlYya3VtRDNJeUdFRWdneStIc2FpM2ZMYkpNWHhKOGdK?=
 =?utf-8?B?QzVGdXFTWHBlRkJHMFRIeWR4Q2R1UjMvWUUySmpGSzlPaERzQ2NwMkQwWCtY?=
 =?utf-8?B?WWF2TmtuUWVreVY0aDc0TlB0WitCc1NEVW9hMWhOYXJ0QnhwalU3akxVZVR0?=
 =?utf-8?B?U3JVclE2cnIxTEVKbmRzSEZvbi9KREIrMTFmdTRKT0JFeUsvMi9TdjJtS2V2?=
 =?utf-8?B?eGthdUVSdm82bTVMNHhxZldHWTNpRi9oOVZra0g5czFrUE9yV2ZvbUhOQWxX?=
 =?utf-8?B?N1NWcytPSFJwb1gwcDlTZU54YUlHUEk4ZE5zNW1SRFptSkRyTk02WnRUemMv?=
 =?utf-8?B?N2M5NWdwTDh4RzI1emI0YlMzWHh3dlF4aTF5NVVwdGI4ZVhCUXd3M1VnWnla?=
 =?utf-8?B?a3NDRWkveXVUTGZXWXBKdXFiM2M1YWxtTm56OW9oc1lpTW5iSy80ckNkWFVq?=
 =?utf-8?B?dzBzZG05Zi94NkJ1U3Z3Yy9uOHZqcEhMQW5LZHAxUUJ6YThpQ2NCa2djYzh2?=
 =?utf-8?B?Mzd3VHRuSnR0V1B1N1gvMUxRK3hhbEJleDFMZTN5bDhkQ09JVVdZK1Q2cis0?=
 =?utf-8?B?N3Z1TCtDMFlRVjVPWXhMeEVFYmc3d1RDZWR5cEQ5M2doT2lkdFZoNVp3Ulpu?=
 =?utf-8?B?NzkyUUQ3UFhkT0wxUTdiWGEvdkN3aG1pK2hrTDgzZ0VTT00rSmprTndwVm5V?=
 =?utf-8?B?WEFCa0FxMnZXYjBwKy94ckdCUEZXQWZBMFZkeFJ3R2c4L2l4MkpRN0JyOW4w?=
 =?utf-8?B?eElUUkt1cDc3TTV3UzVMTzlkNmY0UDJnYVNaRUFudlJLR3FSaU1JSURoaXYr?=
 =?utf-8?B?dDZzK2YzUDdvb0RKTDhTUGtEZEI1VVJUejJoS0hKZ1lYU3hSK0NMWmlSSEFI?=
 =?utf-8?B?em4xNUt6anQ0cEUvQXhlTmxsNk1taURpdEVXcGQzYlQ3MW16SjBrbG9taUZq?=
 =?utf-8?B?TXJXdmpweGhsUEJGYWgvNzdBWTFlUVp1enlZc003Mzh6M0pzeCt4bjNLVmpp?=
 =?utf-8?B?YUpUZEh5ZFRia3JFNmMzUGpMYTBtbGdEN0JXZlFhbXVDRy9ZTVNEVjhWL0Fn?=
 =?utf-8?B?Vk9uV3I5cWl6Y290OXN6TUs2UVJwUWVUNTYxcU5YOE94V3I1NTk0WFBJVlJL?=
 =?utf-8?B?VGZrNmNTQ0Z0OVRjclJaMkY1cElZckxOTGczcmk3ZWpkVjZRK1FJNS9hMDhV?=
 =?utf-8?B?SFNhMm9zNEVWSTRXRks1engyc0xFTXdFS1RHSUdZT0pKNDdxblhJcmxWMW1l?=
 =?utf-8?B?RGNHamRZU2Y0ZUFYYjYvMWk5MjRLdCtta0NROFRMRnpleDBXTXpEcHJJSEQ0?=
 =?utf-8?B?QmU1R2wvS1l6SXgvRHlnQkV4bUJkK1FDTGtFV3RIZWNyaDBJWFY2b2JzeVY4?=
 =?utf-8?B?aVNFZWlqTVZxYktRbEEzdkFiNm9YNVBZaFdZRlpBR2V5eXFKZVpDa3VBckpL?=
 =?utf-8?B?RXpvZ0YrZjJ2ZGUyRWNreDF6di9mdGVSYzdPU2k5Mit4eVZqbXFKUzhsQkFZ?=
 =?utf-8?B?MnFLS0VPR3dQRlc0YnUyTUo1ZHM2SzhzV250ZldIMHZCM1k2UzNKVEJtcHVJ?=
 =?utf-8?B?SjRWbk9nQ3BEcWUvVXFzVWxta3UwbDk0VVRKK2QzbHZvM1pUNm1za3JwRzlQ?=
 =?utf-8?B?cEtqVUVqNFVxVU1Bek1ndGEvaDZVN1QrM1JhTDJ3RWV5c0RuZ0piTzlNNCt1?=
 =?utf-8?B?bng5WDU1ZVMwM0dLam9ua3MvMjlrblhLWFBrNDBRTW9HS0tQUTlWWWc0UjRW?=
 =?utf-8?B?VGpEQVJZZ1h2QUlzYTRUSDAyeGc3N01sUXk5OWl4WC9UeXB2YmJ2Smdsbkl2?=
 =?utf-8?Q?ta895vIivOr6PZb8I/UqiCzYA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086cfd29-5a7e-4b2d-3420-08dba7f093af
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 17:59:51.6505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6zNKdTZQrcFGgpa/GsovO80iyRKQRvjN3qwyNbQIrgrOzF5yTcx4q4PMYVTt+2z+1YfCOId9MTHAGG8/ebJFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194
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
Cc: Jay Cornwall <jay.cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-25 17:30, Harish Kasiviswanathan wrote:
> From: Jay Cornwall <jay.cornwall@amd.com>
>
> mqd_stride function was introduced in commit 129c7b6a0217
> ("drm/amdkfd: Update MQD management on multi XCC setup")
> but not assigned for gfx11. Fixes a NULL dereference in debugfs.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 2319467d2d95..0bbf0edbabd4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -457,6 +457,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
>   		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v11_compute_mqd);
>   		mqd->get_wave_state = get_wave_state;
> +		mqd->mqd_stride = kfd_mqd_stride;
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
>   #endif
> @@ -472,6 +473,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
>   		mqd->destroy_mqd = destroy_hiq_mqd;
>   		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v11_compute_mqd);
> +		mqd->mqd_stride = kfd_mqd_stride;
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
>   #endif
> @@ -501,6 +503,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
>   		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
>   		mqd->is_occupied = kfd_is_occupied_sdma;
>   		mqd->mqd_size = sizeof(struct v11_sdma_mqd);
> +		mqd->mqd_stride = kfd_mqd_stride;
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
>   #endif
