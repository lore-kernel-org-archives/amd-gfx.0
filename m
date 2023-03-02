Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E64AC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 21:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C7C10E57A;
	Thu,  2 Mar 2023 21:41:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73ED010E57A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 21:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8f38nFgcqhdIfT7WqBhuHkjPLMg1av+RbhK9mcww7z6UUSVJdnFfDcqgppDjaAHey1uJfTwB7t8g+EF1FTslgQz7E6yPiYuePYVo5mJHt1WKZ3ReYgVFrXIoHDfo5KqLUIM45v/EuudSfArhbgBvY7SWpgyaagYTt8x6zfRC0/V/9SwLZWDJzmbrFtVtJS6Rymhu6zM/aubuL9rNvf2INeBuoYrmxMBA4kANT6OemmRuPYB6frXrF6HAzrjWwg0dqTT8D6yY0MsUfLc5l44iC5/yrVztTsJYkVaOGcSPYP1JCLgUcEUGg4Sygjumfo6ReTu047tMWaJNyZYh28z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgd+ld+2EBbEbdHTgX9Adb/sU8rm81djhmn64p08HWE=;
 b=hK/i9xR68smafSOkd1GO+JsH1ndA5/HUA3XTWqlUP6GEX7cEamVl7be/m+1q83xySEhsuCxkm2llJK1adPJzloFTFCh6MaWKUMLFjEwASxMYkn5YBWAXEh2okgKozMipeK10afborZum0KUQtTH6UuX405XNrR5fC/SaxKdoRapWH/wkCQVog7BkMl5Q5pkU0ARUjjX1v+yERNHmHv+e6S3ne7jd8+hIevlpTV/mGuqfA+mSCSsl4Qv/si+dFkgwEeMOPa3LJJ9YpcCDkElTobqNhJZqnFqYbQsgUxnfyXvf+9xyv8aEKCGSH/UlwPa0faxyyjmERBX5oP5GnJIgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgd+ld+2EBbEbdHTgX9Adb/sU8rm81djhmn64p08HWE=;
 b=qu4WPFxIjYL3UJQ1ibWjRYNmUUsdhvU4CJAInYCKezAdSC+vIU9QSWJlaJx96+MtrYsWnZ4Xr3LF/P+M2GfqjCGUj/l+vXP35v2HGPv9Zaeci34ppVXv8RhuwMlNsYkLDjMPiwZ2yl3qDhoxbI97ogCGJpiaEyyWJaZ7VX9ng3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 21:41:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 21:41:22 +0000
Message-ID: <fb311ba8-6051-bca6-6816-93c818ed7478@amd.com>
Date: Thu, 2 Mar 2023 16:41:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] amdkfd: Memory availability can never be negative
Content-Language: en-US
To: Daniel Phillips <daniel.phillips@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230302010926.51371-1-daniel.phillips@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230302010926.51371-1-daniel.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6bc891-b970-4abf-4dab-08db1b66dde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcCYfscNud+W2bRmZNMMOUudN3odXhFIz7CWYZbzwe5x0f/vuXQjEwPr/Qp/9QBTtsIISftt4wPrtbp8YXDNEoc61WVBU8uq/gnjnDyHHvRZbOd0LMgFOeBXBToMb8k1kUABdH+La5MnaYBYHZfrF1ceK7j4yHVq8uRpZBeaLpIJUbb+t1XwWU009OsU1mPGUw5Ywl66YKsJG6YBeTtZdRCHnZLLdi5y7x07ks94qz5eGh85OMS82iQVCh/Ge4lQsTQvEUBKKWmxCH1XXGdJDKcNGPompvon7q5T54ADNimU84DChYv+6848WHEvIVeu3N1r0XpAWx8Q5yP3/q2vkyz/CmVJbAVy0LXOxtXZDYqzxDHeKBf9wGKL9M42dICf6vavWR3NDTqVcnh7Zl3VTnXklbJhHJdp5EajLSoeowJCixL0desK5uu96ewKxlIk9kxTZD/grYADmb4kLOQRpNT58P9K2YyJzCTr9WCp8Za0pSkonGhgfGBvtxlzoJFTGRqRaNgIdVXkgu6esIkYwgbsbBmP8M34iL8bAhjguwubPFVEbHqsEYVTHbSAL+9hIcXKVlIBbdkMrIyeL+GP5aahYwZtRwkeCc4SZhVHw/ZS3aMCFQghPwIudoeZUy2HVmfDVRK3bh+okeIytAarHep6udF0AcN5Y8TGc0+8p77Uix3Rn3JEvR0z1lrDA7MpexSOx/09IjtcHBi3rwbAVY568l073GOA4AzoOoYJED8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(83380400001)(31686004)(36756003)(38100700002)(478600001)(8936002)(5660300002)(66556008)(86362001)(31696002)(26005)(186003)(2616005)(6486002)(6506007)(6512007)(8676002)(66476007)(2906002)(66946007)(44832011)(316002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHIxdER2d1NPdlZBMklMOGpiY3VnMXlzamVkNVcrUzdZWkZha2d4TWpCTEpo?=
 =?utf-8?B?MjA1czUxTVlhRGQ3OGRweDJSVnhtTlM4ejM4WUdrL0htRXgwNkdKcytDY0p6?=
 =?utf-8?B?bVV0MlQvcFM2UktVMHNlSzdYeHI3dm03bmh5ZzB2M0JhelBDRDlvcXkrTUxx?=
 =?utf-8?B?T0JCMnlJM2RjL0xUZFMxdXFtSklpVVFkdUV1eVF3YllwME5SMnpYN21NdG1F?=
 =?utf-8?B?dksxTkhZNWRkc0tMVmxESzhDdUpidGZlYjRmMDdIWHlGN3VFWXdqM0plQXZa?=
 =?utf-8?B?VUlBMm9kMHI5UExYOVhrbSt1NlIwUnVHcXZ6MnVINFVKVUd4YXNRUlRDRTlq?=
 =?utf-8?B?LzRxeUdVeWp1OHlNRHk3UWNzOG5pREpacDc5VDVHenRtUGJwVmdzYzVWY21I?=
 =?utf-8?B?QVhXWmpGbmwrN0tuUjkyM0ZFQVQ2eUlNOVJDenIrOXFBeG5pc1cwRFM1TWk3?=
 =?utf-8?B?MGZLdzh5Vnl2T0VlaUtQbE1oc1F0TFpXd0cxcGI5MWsrcnRDWHRmaW1mWWp0?=
 =?utf-8?B?Vjk3VVcxWHYrNlNxUFVzN0orV2l2R25rNHl1RW1OYVIyVmY5VzJ0VnVTdGU2?=
 =?utf-8?B?KzVMdXQraUFEWWNyRGhkTUIyM0JDWlp6QnphL3dFUUt0c2lnOHBFeFYvYjRV?=
 =?utf-8?B?K3VwQUVVc2RwQjd6K2NCcHhxMkpUa01QQlVIdDJQYk5oUmlKZ3lMaXNKbUlo?=
 =?utf-8?B?bWs5aDIzSlFDemJ4cmFPQVcxdGlOK0dORU95NGFDKzVJT0NGeTY3UWx1KzU5?=
 =?utf-8?B?dS84cWhKRlhNYnVhQ0NoeE5XS1RPV2hOSG5jY0xGcjdTRlBRc3M5MUtNeFZH?=
 =?utf-8?B?aUg5VUQrUFNNbTU1WUZKZGtkbzNDYmFoMDZSYzR2SGNuY0g2aVROV0FTZFds?=
 =?utf-8?B?MlRSZUlKZzZ3eXl4TUJmbzZrQXJhR21YNkxUNENhM29yak0wV1dZYldCN3JD?=
 =?utf-8?B?YnlDdmNnclZqR3N3dWFOWGs2emdKWHFTaFBrQkkvNkZvUEdJczBIdWtCaTFQ?=
 =?utf-8?B?TlpyVnJOa3JLTU9FeW5rbjVYYXhVYlNsQm53bG5mN1JsZERXaDdKbElIbGo5?=
 =?utf-8?B?ZXBLOGtFS1F2eUk5eVJaKzNCR1VOem16cWZOTW4xelpkYzhlZXh0eXozY1I2?=
 =?utf-8?B?Z3paTFNBV25hK0tUVHVjcjV3ZGQ3U2FnU2hnR1UyNWVlcWFNMHljRFBndmRL?=
 =?utf-8?B?bDBSQ3JDWDZOdjN4TkRwZW1Bb05SUlFYV01DaElWRSt3SDFoYUJRaGJvSjE3?=
 =?utf-8?B?SHhoY0lha245V0tTWjE5clI0eGJ1NHJwajV5U2pwSTh1M1dVRlV6M25mZUtv?=
 =?utf-8?B?R0JUbzhnK0JDSmsyNnd2aEpIUFd6S1lWYmQzSjdVR2V4MkZkU2NkVTBibE1I?=
 =?utf-8?B?RTJTaHdUWWN3eGdVazh6TkZXNEF2em9WTjg2NG5ibUgwTEZkNGhNbDkyNXFH?=
 =?utf-8?B?T0RkT0pnZ2U0dzRVblFoRlpQTTNENTlKWGh1a2lrN0RRckFJbE9XYnpmR1BV?=
 =?utf-8?B?QkdyT1RFRkkrdnhEQWl0K1NFbGdIeVhJYjRsaHBOMkdpSy8vd0NuTjI1RUw4?=
 =?utf-8?B?L29pRGpjVmlhVnlnVjNBZ3VFbGtRRW5pOXdMT2JjYWhZZjI1aHpvTXhEQzhu?=
 =?utf-8?B?OUVRZmhvZklnYjJSQUJyNTN0WG12cnR2T1huak8zMkE4SDRUV3RpTTczdk93?=
 =?utf-8?B?ZmszemJsNUlTMnFXR3hvUW5xYjRxQWo0bjNRWEtnTEpma3ZDakUrRFZtSU45?=
 =?utf-8?B?bkk3MHZkVDFnUm9vRHhDa1JqRVYvbldtbHZBRjRsUm5MZ1FoWWVpaGQ1SmVF?=
 =?utf-8?B?UE9LMjRWdGlyQkdmZjVEc1FZRTFnREFIcFJSMmRpRzFxZEphNVQ4WVNlZEp2?=
 =?utf-8?B?aGdNblNmV2hPbWg2SGFQcVJ5M0cyT0tXaDE4RUxQdHBFTGt1N1I2MWFGVFky?=
 =?utf-8?B?dDVqcFNUdUUrSlc1N01JZUtIdHVQSERRaTFTR3VhQzZxcTBFWElEczhJSDk1?=
 =?utf-8?B?MUdMVHphSFRaU2ZPTUc3NkIxK3lTMlc0MTFvbUp6Qy9ya0dPN1pKREE2Nlpl?=
 =?utf-8?B?MVdNR0NYK0Ercmo5MERQaG1RTFFmN0txYUtZZXE3bHZVTjlLdnRNTFgvVVlt?=
 =?utf-8?Q?Q866LPRE10R+MDa4A608HGqyY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6bc891-b970-4abf-4dab-08db1b66dde3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:41:22.7426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vi5d6pr+ICEskco9AG9U7qHsO7J1ia+R+wqKvUvrFjbwdslEDpp3m0YWw72iRnAoLCd0byR2VhOk6IbTVYhi4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
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

Am 2023-03-01 um 20:09 schrieb Daniel Phillips:
> Our assumptions about how much KFD memory is currently available for
> allocation may be violated by various complexities so we define the
> reported value as advisory, however we should never report negative
> availability.
>
> Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6f236ded5f12..ec74f0ad62a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1574,7 +1574,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>   {
>   	uint64_t reserved_for_pt =
>   		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> -	size_t available;
> +	ssize_t available;
>   
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>   	available = adev->gmc.real_vram_size
> @@ -1583,6 +1583,9 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>   		- reserved_for_pt;
>   	spin_unlock(&kfd_mem_limit.mem_limit_lock);
>   
> +	if (available < 0)
> +		available = 0;
> +
>   	return ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
>   }
>   
