Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60520C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 17:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA1310E5D6;
	Fri,  2 Jun 2023 17:14:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D3410E209
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 17:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGpJ+oukF29xWplJrLg0e4HTXS7NUji5eB7j5ZJs3DTXhc+7MLrmhe7oCq9a5zgdLk9BFRUFrWQ16Kbu3qmU8cxURlOALUWr47K94Z8W+6+0UnXBJL/O2SgDRty9jduEzUMke4lW877GNGwTsb+9B+LKQ8zH0a0PVi2j7liTX7Ezd8gz5yqdlbz0x0n/GwIiLiqr2jC49W+tRdU+Q8q/vcWJfAKP8y/uyd1DwBN3EmiKSPoGZOMU9JwMl0TtVHT+2tFXWe6mMZg1ItAooTZNQMJwHdHbaee9jgDX05WhZPllBiPSv2HTk7lYTzqOCgoFaYZ3s6JfNLLVFEZtQmetyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rWAOeyMlwIsfV5M8cKUy7VJq8B8F1t9KcTpbD3B0QU=;
 b=TDc9949Wp2oplDjSixUVNrzsirX+Ww7Hiqjfyy4X1v1C8uNUafOT1YrugvqK4V3lKI0Z9GXaMXwY5pX8Po96A/Z/1ynhtYCwdylp3qg7bd4/r4TX8yRfYMH2KYwV3xYP5/6mXx49X8mI3yXZ5N+lLZubcjVPHary1rtKdYySixFONPzFeu/cD9VECESerNO/X1+1D44Avtb5hy8TIXNpdDrel3A4EQjshNkwbTlhOABKIA0Yjk/Dbz9eOZxEfn5qWr5WhQserDIbRdBDKmk8KNbFnfHReB34f98GI2BlvEcAreUOtYWjfMBdnPAqYjPDs+jR2pfgk651uuvMwr4DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rWAOeyMlwIsfV5M8cKUy7VJq8B8F1t9KcTpbD3B0QU=;
 b=3NSs0WYb+eDo9QQw6w9QulPHz+b2DcG5OC5jjAjZe95msqAM1iDFWeyB4a7Atg1UKQXJgk5RK93t/LoePQUwNKaXNlN0bMI2EdmK40UPgUwYkkM2kwGpVbakUr/dFpqEx7XvKjTO3IHaeJIpyMP8oU16Z3OsgFgwFXIftB9N2GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 17:14:02 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::85b9:8b52:e814:211]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::85b9:8b52:e814:211%3]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 17:14:02 +0000
Message-ID: <9da1c384-8860-6176-0d6c-b46a1a8240ab@amd.com>
Date: Fri, 2 Jun 2023 13:13:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] amd/amdkfd: drop unused KFD_IOCTL_SVM_FLAG_UNCACHED flag
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230602170139.18284-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20230602170139.18284-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::30) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 7441508c-19a8-4b03-676d-08db638cc2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSSKVEVZobe7KOvPMlj+y+UKwAfmKJd9HBT5gKHNLvwnp6mjfTGM4ix/jrMviTw7kDrQc5wXqc6kc5wQSns4DmdtbRgb4n8jRSgCnmpFzElJW3pIxtNA0hx64sn4iDhNbiKouxrx9tgI0FPEEW1tL2fspZ49hPtp7zECCnFB35plUDIJEkjXsgb5UyAIQaxuAdzlHBKGJ3W72sZsj49GzfPYIzFX9g8Q8pEwFie64yyfgurjGS61/yPyLnvcMThDFHF4mr7RWTrWYcJ9ijTbe7pfbDBOSPgvUMzLiCG0abNAksjC+lc8bpuX/DFCbSwzhlhNIy10Aabi0kIRZEP3FQLVOzc8X/Mwz8DBEEXAKcFCKlmobnAwVItIeCWmm7d7ANmi+/fQ0It9lpfkDpe+2F2cB6IWhVYQwQYdMLsp6f/SFuVsd5o+dRue5OJRv+RTNJqRqAUOPCDJ1tzmv1NU0gSGTeqlDrJE58RtItLBJr9x2Y9Q50wYlMGp5iijZb/O8Rx8OpL/lc2Fx0f/9fs3vFONpSHyuNpgMoA5BcJsRnXPzdB4uqgByZAU6lUWWIvVa22ueXcULTamtIGH4ur9zPvYDWpWSSOyJRExQZbYf277Wgu2aHY8urzAA2WE+dS2G936xKAMJNQ7Kil0Toju5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(5660300002)(8676002)(8936002)(478600001)(41300700001)(6486002)(86362001)(6666004)(316002)(4326008)(66899021)(53546011)(186003)(31686004)(66476007)(66556008)(66946007)(6506007)(31696002)(26005)(6512007)(2616005)(2906002)(83380400001)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlTRTRIa2U3MlZ2NkZiTW9CTEJMajJmeXZKUlBxUlpZdkJsbTlzamgxZGtn?=
 =?utf-8?B?ZmhNQllqVWJOVy9nbWpNRUt6VlA0NkxGcVNlSmZtMGllcnRhQ1UyN1Vad1hl?=
 =?utf-8?B?ZHphZFhtampFTG1MQ3NHc2JvajU5YnVWNmpTYlVSc2hJQjVBN1ZOYkR4RC9P?=
 =?utf-8?B?cXRuS1lzY2E0dUtveHZzSDhsTW1OS3hndGVteVBWNVQraXRaSWV0TVN1Z0kv?=
 =?utf-8?B?VWt5dWlBWVlRQ3psOUovOUZxenIxWlJEMnUxbXVtb2xNaklROXRjRmlsMHZW?=
 =?utf-8?B?WXRKZWpiYmFKQnQvN3BTallZb2JCWDUyRW1kV05Nd3hiamhCbWZvYnBPZ0xj?=
 =?utf-8?B?SUlCL0crcTdSVGtOWEoyZWlQWU5kb2pLcnJZbE9mZ3Q1c2lMb1duTWhxNk1j?=
 =?utf-8?B?NXF1ZzB6ZjdLcm0ybVpBS1YxNlFTT3hvZWl4VFNUOGptZUlwME1xRSs1TkRH?=
 =?utf-8?B?a2VYS2FxMGJQSDF4WE04QmRKL29NMkJQQjN6cnovZTQvdHJtdVQvRVd1dGlp?=
 =?utf-8?B?SDFMRWN2enlGYzZVbGNnT2NscVBUSWtZV1lMZ3M0c3ZwbG56UzJvaHMvc0tv?=
 =?utf-8?B?ZUlWUDZwZE9XS0t0V2NIMmFhTjB0dHJ2NnJ0cTk0a3pwQ0NzNEx5aUVJRHJm?=
 =?utf-8?B?VVJreVByU0tYOVZuOG8xSU9idDV4OWsreTh6VGNiMW1VZW5LdDAvU2NNM1Ru?=
 =?utf-8?B?ZlVKTnYzTTJZUmdhMWQxZUxXTldmR1R0cFBpRlhpMS82K1JibHE0dnBIU2Vh?=
 =?utf-8?B?WkRyT0F2aTBHN1lqMERTV0cwMzRBdDNpNjE0cEd1VElOTkFlWER2UTBKbTJY?=
 =?utf-8?B?WElxeVFMOWRrd0w3Q2d2ellYKzFqZUh1Ti9VVkxodFV1ak15S1NpbG9hVlpt?=
 =?utf-8?B?aEFOT245SU9oVElQOWNZM1JvNG1taHA3WGFobmNBNDdLWHVuSVdHaTRpdnAr?=
 =?utf-8?B?cmFWUkFxZGtpWHZSMXBjVS9URzZKNEpOWFpELy95NWtFYVVHQzhEZ01QU0FF?=
 =?utf-8?B?RDRST2V3cVhHeGkzVlBJM3Q4SW5qVGcra0NpQml3cG04WXNCMkZ5Ynh3VTB2?=
 =?utf-8?B?SzNmcVhwYTZGM3J1aEdjemdXNnRRZnlLR3AwZ2lkdEJTN09GaFIrazNRdjU0?=
 =?utf-8?B?T2JlMlpZbHRNRkxBaS9yY2hhbVZKd2lMQ1hGcXNQeHJDUFZwQXZjeWJGSDgw?=
 =?utf-8?B?MXp1cG1BOHlpZTQ0TENZRDRGVVpmQnFtckdmQ0lRa3JpcW5ZL3dVMmIwUldC?=
 =?utf-8?B?TWVUdU9SUTlHVkZaUEVZRVVDZTNyb1FsSnVVMzZlakR4MTE5dUhFc1lrSUU0?=
 =?utf-8?B?K3QveHVsTHp2eG9PZUsyRVdCVWNnaE5iUXlLREs3MEtLbU5pNnJ1c2kzc0Ry?=
 =?utf-8?B?UjdtZ1pueDR2SG5Lb2VFNXlIVEwyRk53YVBlaDlWUXVmOGhrSXhHSGF2aHNX?=
 =?utf-8?B?SUwwcG1aYy9jVTBKbnFlTzh2UkpLUWZmVEdXMW9PODAvNHhTUW16eGlFN0Rk?=
 =?utf-8?B?K2NuVS80TkZ2bGhHTHQweVV3ZGFwQW9FemR1QmpXRXlINFY1UW5MOWdpK0p4?=
 =?utf-8?B?cXdqcjgyMU1KeGVsQ2p6NlRmRVdlVytDMHBnOC8wUmdKWlZJRXVFY0h6bmpB?=
 =?utf-8?B?bTY2THNYMmdZMkxTSzgzcEVqRWtueitRaDY3dVNRUHA3c1QvaXo3ajFxT2lI?=
 =?utf-8?B?bjdscjN1QjQ2NmkrVGN2WE1pRnNIREc3c0pSVzFzSVVHdjB3czdBclNJTENI?=
 =?utf-8?B?VXoza1pnbGgrVEFQeFhObFdlbjdoSjRYQzZJMWRsT2tBVjROdGZVNU12bU1B?=
 =?utf-8?B?OU9ZZktOeS9aRGlvQkNWdFBsZlA5UTJoWmxhTUpOYmZpRDFaNjZqN0krdW1T?=
 =?utf-8?B?Z3J4di9QVkh6b3BzZVUza1JCdGtpam5rTDRMTnNSbU5UM1hVa3pTblliSTNz?=
 =?utf-8?B?SDVuTGthZlFSaU16aUIyQkxiK1VKWllQMitiemdtdjN2QTdiWmNQVjYxS3hF?=
 =?utf-8?B?Zm80d2hETWhOWmZweklEWUxnWFp5RHRwYTlIbkxYeWZGSjQ1Y1BQTW10QWhK?=
 =?utf-8?B?T2x4NGtlaE5RQ1llT0hZR1ZkemwyMVBVQnZEWjV1MWh3eGJxcDI0ekV3a2kx?=
 =?utf-8?Q?EVizvbbiD8wwae7ZmZTR8kERJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7441508c-19a8-4b03-676d-08db638cc2dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:14:02.0615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORLwKohXe2rr96IeBukUnamZFGixDYCSj9MmpR0s76WylQ+ogYIHGpg+8j2A+r+Z19F0M8mlKEdyiQQn7UP+4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think the case for MTYPE_UC still needs to be dealt with for svm 
ranges but the UNCACHED flag here looks misplaced and should be removed 
, other than that it looks good, reviewed-by: Rajneesh Bhardwaj 
<rajneesh.bhardwaj@amd.com>

On 6/2/2023 1:01 PM, Alex Deucher wrote:
> Was leftover from GC 9.4.3 bring up and is currently
> unused.  Drop it for now.
>
> Cc: Philip.Yang@amd.com
> Cc: rajneesh.bhardwaj@amd.com
> Cc: Felix.Kuehling@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   include/uapi/linux/kfd_ioctl.h       | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 615eab3f78c9..5ff1a5a89d96 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1154,7 +1154,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   	uint64_t pte_flags;
>   	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
>   	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
> -	bool uncached = flags & KFD_IOCTL_SVM_FLAG_UNCACHED;
> +	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
>   	unsigned int mtype_local;
>   
>   	if (domain == SVM_RANGE_VRAM_DOMAIN)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 2a9671e1ddb5..2da5c3ad71bd 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -623,8 +623,6 @@ enum kfd_mmio_remap {
>   #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
>   /* Keep GPU memory mapping always valid as if XNACK is disable */
>   #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
> -/* Uncached access to memory */
> -#define KFD_IOCTL_SVM_FLAG_UNCACHED 0x00000080
>   
>   /**
>    * kfd_ioctl_svm_op - SVM ioctl operations
