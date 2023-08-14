Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B80C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 09:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66AA10E169;
	Mon, 14 Aug 2023 09:15:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005B710E169
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 09:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3rgWPqqde/1+iYUM1wGQptNf32b1Rt5u1oTwGwKanxXDtqw8Ooz9ht//0Jzr807YRK4ge9X05nweZcRMHJoGluGC7l180UfknhcKrJBQ7LMwWQQMNWYnzffi3SVZCZZLWC38eaXeHh51MVfpU9yNQyhH0A46ecav31lAXgheqLXjZKw+wjXoRIhfQdcQUWWtpKrwIIvjemYXP8MyFGDv62tAhvaVDZ/cOG+gP/+U8PRPXw1e0eMK7rsSaQ8SuvMdw5SwqcIrCACF8pOJS3yu3OTzJpCbE8Anmm69ctOJQVu5LcH2AGI+shAAz5sFGiChmFibeomL3DUQ9WlxJDPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acfSh/8icyj0NAGXoCC8BfSz1iNjJ/Buw77Gf9HQueM=;
 b=F5zci4ga7WqcpA9uoEZRIwJVhs3W4ReHFybqUAv+/yFarFLcE6LxXmDAl/2hfgsqCUkKMCtuHpZ7fnDbo0GfcgcDU1BqflfPc3Vnxa8HqPRWQi7/qIsU+LVRRlISKCm1e6SvwUTMhRf1REUcN1n9SEGCWAa7BVCfkk6aAuZ1EGojuk4R7Bh06pRza+Oyb8IuNqtJNvQJapMevpJfVcK3n03twFhg4LU474YCL1qyQ25/d6sdghG7QlDHAb8wct9GCPQ6yygBL2Ei7AyS0PQvj7D4DakWOVlKYCVR+0x5lhFZpMHa+3UqHaTTgbBGdw10jusfPla5kiYLxsAaIO1yJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acfSh/8icyj0NAGXoCC8BfSz1iNjJ/Buw77Gf9HQueM=;
 b=NjF+y8ZsTqx/zgSxsLnv4rC5ACdCZhYyYTUe64HAfux38KMyOmuqehTO3ldvH+LTgUForTWDJUCcAbi2p3xjsVKcrqUPS/AAKpPeUmgLj/dI4mRZ8Gzg4MlTf+MSdqgNupj7//L6LSPEMybyLmHZwN5LoXSwLCfjz0vfc+6//qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 09:15:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 09:15:45 +0000
Message-ID: <750a0b2e-7a53-a572-549e-87426d04ab1b@amd.com>
Date: Mon, 14 Aug 2023 11:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Replace ternary operator with min() in
 'amdgpu_iomem_read'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230812144724.468189-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230812144724.468189-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fd1777-5be8-4279-8fbd-08db9ca70a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HA3aLlyYik5fZ7eQILaA/tUR80HvzQVAQXte/6UbAKUvTKQk8/vr0Uv5ta3owhCFCdG8A3Hk+imTWzqCV61Rsi4ztDS8GqbemyQHfpTlOkuRNbH5tFXFvoBAAq4CzD0ppiogNqDWp++JK37H9CcIpo6Y8wydW2lGsGHy9wS/FdTN51BZSGKDemoleh/rOAd6iTC1UaOp6tjaQpgPldcVP3O2Vdqne1YeM0+GDZ6lcGkbpPjXZdf3w87mnCKQsyIqhY45MgmpV58Ltr6hsfzhBXZCOcR0ICfGmvBodRw33KI0LypXFnUFfO0A5+pQJ5n1TbRXcCq98VXl+qtElcRY9rj2097t34CRWBSWlQJy14rYHgHv75D956jdR28Krz2tUTnzZfVbLYQNpI0gre5kdYMuEwBYTFbfKe2MdBFPzxYBpUC4sj4xZBjXbFFLVotgAfvl+V7mPnATBfh6Fnj/kA9BcMfqvq+3bwh9knYBGCuyZWRvGxLugcymW4jewrn62PJf/YH0YVgN2drC5NnZddCzcU0zFcHDAi+wuShgRiKjuxwP8VY1zQ6fmnwReJ/dl1g0jPTmX7arU89JHjlEtfC9DU32XnJvxRVGfBhFP80fChn+EwYRZo4U8RSq+dRGqYUNJ/17qjaVd1bMh4FV6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(186006)(1800799006)(451199021)(31686004)(6486002)(110136005)(6666004)(6512007)(36756003)(31696002)(86362001)(38100700002)(83380400001)(2906002)(478600001)(2616005)(66574015)(41300700001)(8936002)(8676002)(6506007)(5660300002)(316002)(66476007)(66556008)(4326008)(66946007)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0I1MFJ0NEpwMHBKdUI1Y1lITDkxRXJSQjRDcEk1WGpJUkdua01WeThVNUlS?=
 =?utf-8?B?emo1aWF6enlKS3hPMEI4dXlKZU5FRU1YS0xRbC9pRUZpSXU4NmpWeFVmcW13?=
 =?utf-8?B?OFpvYndYSmZDdDVoeWZFdU5SaUhwdkZTc3JtRmVLdVdqNzNlblFkV0I5YnBw?=
 =?utf-8?B?RTVEVnZRUW1OeXF0cFppSVVIWThnM1NlVHI5TDIwYkRqNXMzVk13dU8wQnFO?=
 =?utf-8?B?eVBMaDVUL0Z3YUVDa2RCaEpWY2owMjY5QXFSeWpBSHlCaVJVTkRvNFpxV2Ex?=
 =?utf-8?B?Ni90WDZRUnJoZDBzYW9SakliaFdpS0pWdHFUdndpRlQyRWZYMzM0Rm1OaWRC?=
 =?utf-8?B?M0RPMk01ZHQzYmhKY0lTbW5YeUF1djhMYThvMldzbURURWVsTFBHenlRb29N?=
 =?utf-8?B?THdTWVd3Rk1ScDBpWC9aam1aQUFhcVg2Z2pLRXdSU1pVV08ySkdlYTBTVysy?=
 =?utf-8?B?S3RSendEZ3RLd01TZlJ0a1Z6ZWFBMVpmSkVxeUNTNmFWMVo4MnVSV2lveWJw?=
 =?utf-8?B?MzdWS3cyVzBxSVM1TkFsZFhDUURoWG9jL2ZKN0VvOEt6ZHQ0RUFIVThlWUww?=
 =?utf-8?B?b2tYS1c4VTI4N25qUDA3NDJFS2VUaFVxS2FyZkdxM2ZmRU9pUGc0SmZZQ2pp?=
 =?utf-8?B?aUZSZmhXaDZMY0RBTnk5ZEU3ZWo4aTUrWTFpVlE2SFRSMmU4OURXQitFOEdO?=
 =?utf-8?B?R2hycitUYlRNNlAvZG95SUtuN3duZmhEaVZFdW52OEE2M29rL0lpSGhBcDZP?=
 =?utf-8?B?WTk2WjZQbCtPYTdtb3RHblZKWVlzMmxBYlh1NXJkZnVGVjlJL2tKYXJmUW5F?=
 =?utf-8?B?MXh1bVBkNjkvVzRVNDRWdzZKaGMvZDVBTkkyT0hrcjhwTS9WMmE2ekVqWjJi?=
 =?utf-8?B?SFhUcmhSMVM4M0tRRDR0Y1U0c0o0T1M4SzJoMW1leGI4aklxOGo5VHdaRkpE?=
 =?utf-8?B?cHMrYjQzOHI2VkNkeUNlTkdCcmZ4V2FSQ0l1T2pnUnBwNEtaMGtkaGZwamNn?=
 =?utf-8?B?Qzc4V0JzZ0VFOURJK08rV25lYm1FN3ZWRURTM2ZUdk54MllicHNaUXhNZHJI?=
 =?utf-8?B?NWp4UVU4SDIybGtEM1RFMDUrQlExUUlrRVFpMGhCUitidXlnQk5JRGZIcDY4?=
 =?utf-8?B?ajlod3AyWnV1MzVNVG9NSmRSc0lhZFpoZmF5bnRMY0tXbEprZnpYTlVLeTQv?=
 =?utf-8?B?dUZrMmJWUHFYRVB4cnRIeDJUTkhUc3loa2F0T0ZjMi9wUU1nclpuY0FrK3Bk?=
 =?utf-8?B?YkNyK3lCNi8xVEQrc2ovYjVLQTZGQUw5NGtwRmw0d3RiUDNZRHdudncvUVBN?=
 =?utf-8?B?MzE0bW1RRXVBVkxXcVNGYnl4WkJhSjM4RWl2eDIvdzNKY0kwZG84SDNoMDA5?=
 =?utf-8?B?VTYxNGxEVG9hU2RaYVBFY1VET0xFL0xLY1F2RzVUQ1JBUGdVZWtacWEvZDRq?=
 =?utf-8?B?L080VkRIdTdQbzZSUWhGcUpNNW5uRktHSUtrck5raURDS3NnM1kxcCt4UVZF?=
 =?utf-8?B?dExvRGdNaG5kMmgwSy9NeDRCbE5QNXVaU09haVVvR2hSSEtYWE84NFZzK2Zu?=
 =?utf-8?B?TktOZlJ4S3Y2RTlCd3RFNEFJU1ZDbnBOVyt6OUZEQjlrdmxxSDVRVnNua0g2?=
 =?utf-8?B?ZUNzRDU4elF0cXFpZkY2dDRMYyszdWh2ZGpTVmtGN1ptUENQNWNaaHVTY1o2?=
 =?utf-8?B?MGZFV2pBajVsREZEdCtid2tGbVp4RXpQZ1FRWmVuRlNGZjBITjlsQjNBZmZj?=
 =?utf-8?B?ZW9CejgrSXo3RzlkeGhtU3RjSDVhQ245Ky9udmlJVUVCdXdyME9yQWF1aUpk?=
 =?utf-8?B?aEF5N3g2RzZWM1E5MW1ZV2xBWHlQMGs4bW13ZFk0YzhQVXZoTHluSG1IcFh1?=
 =?utf-8?B?UjhMN2dISHFYMWszdlBaWCtRdjFKdkMxNG1XbXJVaDdJcUhkZm1FT2QxNGQv?=
 =?utf-8?B?OG9xSEo3RkMrcitjbllPNm9rL3lQN1lWcGZuL2I2MVpXbVljU3Bib0VsNnJy?=
 =?utf-8?B?dmx5TmxqdzlOYitGWmRQYlhONC9YU2ZlM0JicWFYTmovTzJua3h4Y0t5OGhn?=
 =?utf-8?B?SFZhanlVV21OMDg3Y2ovMXh5c2R2cVhSOFJTd3JVOXJ6T0dqR1NzYkFwNW1t?=
 =?utf-8?B?TXhkOTJFWUpqa3dPaUhtL21MamIvZExSV0hXUlZYT1F0dkxEZGpPY2NXOHNi?=
 =?utf-8?Q?s8IqFHSj3iB2v1E+amWNPCLPZLkeEP92UMMU5BS/UWDa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fd1777-5be8-4279-8fbd-08db9ca70a53
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 09:15:45.3591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsK7lqwbVXJOOu0AI/8EDyGjyrg8auuqN9Gf1HOL/bQIsygUPiX0ZZciP+nQqqXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.08.23 um 16:47 schrieb Srinivasan Shanmugam:
> Fixes the following coccicheck:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2427:16-17: WARNING opportunity for min()
>
> min() macro is defined in include/linux/minmax.h. It avoids multiple
> evaluations of the arguments when non-constant and performs strict
> type-checking.
>
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Please double check that we don't need min_t() here.

With that done this patch and the _write variant are Reviewed-by: 
Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index df32785a8b36..c03fe7ee555b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2424,7 +2424,7 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
>   		struct page *p;
>   		void *ptr;
>   
> -		bytes = bytes < size ? bytes : size;
> +		bytes = min(bytes, size);
>   
>   		/* Translate the bus address to a physical address.  If
>   		 * the domain is NULL it means there is no IOMMU active

