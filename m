Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CFBC7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 20:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4298810E5C3;
	Thu,  1 Jun 2023 20:38:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3D110E5C8
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 20:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5NsdVv0GmuueTmN+JToZCgLLmZEZPnygPdjxPYISbIwUEACL7ewLBMseszeY16ybijamgUaJKkW65S9ZdMPb0gSIpOsKzfyG7T7bNYkG++wi+x2z7OVO9TbrHEGJZwqsZSTfjsl0Qguf8vHrd9e628DCTh69ZdYmEiioaETiqvWTiUhcr7F/ZaQ9qk9g5k7xoGQRrBastw6R15yYN06aSSSybBG7MkuktxX2wcqhBUz5EG40zKxuuVrGd4eBwNyKzipD1jhXw6Rs2At0hru0RCJGE1UrCIMcZN+zG19R1aBsNeVOSSTvFhJCmOU1rYxZOd+WZ1UhjXk4IvW3W6CjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpi7pv/3Ixu925hKrgJil/TjcAlNq4GEXnHFouWzVNE=;
 b=PkpQpjvG9gSZ7YoYmvZTAZTiNz76oQtXwxcTwXBlT77+DkMcSNttUhokf+vuG6It8F0EBmbvdJ0nb/yLgD4flVk0eRIXZ6Ky1lHYwm1QiRv+1xGZNQjuCnPorfsS/1LJGtaX/KW1yA5O0HQGLkkrgwp/klu/kaSD3+Cd5mK5CMq4+q6ZUEGN66TgEl8SZsufRcWwSJlL9dbiKC2TPOClbBQuHwflvhEW2caaNS65Jfx4eyRjGXWMecCYRu7hJlPbXldxxif6BidkKrdKbnqlndUj4EH+KSRmEZDUJtBzb0Bwbq/c2UuoRhUd+LdpLO9SLeZ91CXm5IGErWyhxiJMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpi7pv/3Ixu925hKrgJil/TjcAlNq4GEXnHFouWzVNE=;
 b=MF9QHlIZ6Tdml7rtLmIJ99yzyUYp5C+6krGDKo2I+h52I2VM7Ze82flUqWzEfgXsAUZpOEfk2pDE220FlaT6hjDltQumIqGfV6GaWlHvSsALIY/op46fcCldo6xozHcaLyCfBP0ifLNxq6HKydRHqyfr6K2HNznVxv2xjGR0j64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 20:37:57 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 20:37:57 +0000
Message-ID: <9265d40d-8f81-e64d-8da9-dc15c9951be2@amd.com>
Date: Thu, 1 Jun 2023 16:37:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] drm/amdgpu: Signal page table fence after gfx vm flush
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-4-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230601193117.13143-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::20) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb13251-79ae-4b41-7dca-08db62e01510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxWcsKP8LJbG88ODr0t3rAfWsoadwSM2bukkOEMvLjpSwFnqOfyEmBDxExIXHjTNFc/pTKCR0C0eth5FjLQBWScC6EycDjofC6dOsOb1wQbZqub9PzJk1YqdOfwu2FZ/ULGGdc68vDwB/XbDmxgU4rPU3mesTpfSLMTMCkt90JAfF0iuhI9e52rJV9ukftkf/7055h6PB4vxrLg/+A9WBEuSLjq0nMMkn8gZfjF7B38wbJ1MNWKEghvYUIHU0r1d2TG2aHoXjcUcFwL02VqqfvLnUNwAZSoatIdIt4Tal5IhwNjVOKg4ISipNxFnnF8iACyT2EAaS9c02kMTDjLla5wqAfJiXqpSq5o++tw6MGDvLFP3zU6BAnrfy6a9zwmWLlsh5E4Mg5bKE33djRpxhMzgD/iAzX4SCQJC99yvQv8ALO/7rlHP/kJEXvzG8N7XPOB1KCvrO26bd8VT++piV/gl5O9GRA/qrBb4xZr3hCUfoNfMZ3WJt9a0UZMA1E2PEg18rEhGDQpFR5HrZDQhn2t1g8LrnjjK+4Ma5cI7r1T00eO47WHGXh9VrSU9hqztSL33ch6xoOgqnvpQ8YUyyGPER2YoePFk3rcg56tDHyaY5108U4G88hJvIMEYtlu0YurpzOvJvjzpeH4QA1TujA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(478600001)(5660300002)(8676002)(44832011)(31696002)(2906002)(8936002)(36756003)(86362001)(4326008)(66556008)(66946007)(66476007)(316002)(41300700001)(2616005)(38100700002)(186003)(26005)(53546011)(6486002)(6506007)(36916002)(6512007)(6666004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVCMWNOQXd3N2xxVCt3RkpRRkJVZXhxWGw4U3AwcDlMRTB1cngyeGw0K0sw?=
 =?utf-8?B?K2Z0WXdudENrN00wYy9DQ085TEJWeENxYUlkdjErcVIvaFdkN2cwMHdPeENJ?=
 =?utf-8?B?ZEZSUURKekV5dm1NUnZzTjlpNmJqY3hEaTFyTlFyd25lVHllMENhcC9hTkRY?=
 =?utf-8?B?TkxjdjhDdEpVTkt2MG0zV1I3b3VBVWRTMUJaTkZSOG1BVU1WeW54NWFDWXJR?=
 =?utf-8?B?YWhBb2tVbzZ0c3JNeVBaVkRhaU45MnByWTYxYWVQY1ZMQU05MmZYSENtYUdH?=
 =?utf-8?B?QVB0N25RcGxnd0RBeFJ0V1pxQ3NZb0l5UUhFMi9nUWtHb3drNmwvRHpuRnE2?=
 =?utf-8?B?cjNKdGNhUjFUc0RnNVVqQklPQ1hjK2NWZHVZV1lKdTMvUUx5MjB0NlFVeTZu?=
 =?utf-8?B?dkJydmtKcmZLTS9IbUhOeHdEcXQweEpqY3VuOUg5RDVHYkVYNURYQjNFeVl6?=
 =?utf-8?B?TGdld0M1aUVVNE51Znlmb2VxdUY2YWt6eGxvbmJZUnpwQVdFTFBVcDdtVWJJ?=
 =?utf-8?B?NUZ3M0k1Z1BPc1FUVXdlRGUxOGdNK243OU81ZjNwUk5scGZpaGswd3pqQXNG?=
 =?utf-8?B?NHIwUlZKZ1hhcGtVWjk3WUR1Z1NDaG5ZV2pYVldnUmtHY1Q2cng0bm51b3Zq?=
 =?utf-8?B?Q3pHaEt3ZWZkYmtkclJCZ0lpcHRSeTJJSGlkMFlaR3EyTExrRXNWNDdNUUVX?=
 =?utf-8?B?MVJFeTF6b0RiWGtHaWduN0NMdEZLekRMRVJPbjltaGh6TmlrQXJiSE5pSWZD?=
 =?utf-8?B?eGs0YlVERExzMlovNUNDVUZFKzNJaER4TlkzdXpaS0FsMzBONHA3YWdwanNR?=
 =?utf-8?B?aksxc2wrOXdCZkEzRlpRNHBrQXFjV3NGMTZOeUV4SlZTWGhiY2JFdXJpem1F?=
 =?utf-8?B?bXUybTI2cHpBZFRTZGphNG51WTI5anJjUjhUVFNsSllCdFVPNncwYkt2WHl4?=
 =?utf-8?B?RHAyejhFYmV3VnBWVmRQbE9FYWZOb0V4UGFXV2xyZHVkWWpJVVJOZWtXS2ZM?=
 =?utf-8?B?dGUzSkY0cEM3eS9zUk5ZQ3dsWXNZRUJQc2lEWU1CYkhJRnFMYmtOdzFvSTF5?=
 =?utf-8?B?WUhib21BM3EvcEo2RjMyT1dkNlA2bGxsQ2p3SmdSNzdUNDgwYVE2Q0JtVE1F?=
 =?utf-8?B?OEwzalhNNDlicHY4c2F2c3ZtNEs1R2JhK2Y2ZHNvUUJFeXB5ZmRHUzJld3lO?=
 =?utf-8?B?SHBjVHVidldlMWszVWtRUElWNUFjVGhkaHpVekZMTk80SHFZOGZzNjArL0J6?=
 =?utf-8?B?aEE2NlB0cVQ5Um1YWXVmcHJjbHFIZmdhcGVQVzUvLzVMUjA1RFhSRU1yT0g2?=
 =?utf-8?B?bG13VGFvUTI3bnJIaHV4T2ovT1RiZ2Y4dW91azdJUVBLSDAwcXE5TGo1aGdY?=
 =?utf-8?B?OWVxSktKdzZJM0E0aFRqeHR5SEUxUnQ0U0J0ZHEvaHRWOTIrL2xKOUdMalZL?=
 =?utf-8?B?dTFaYW1HSTV4WjlodlQvMmdsWkxGb25JSTE2TXhuL3lLcWlsb2Q3L1dUQ2RD?=
 =?utf-8?B?NDI1QmYrWHViL2ZNb1orWWpHWXBNd2hDQ0RHZ21MMG02TlBkQ3M2MzFXNDlJ?=
 =?utf-8?B?OGl3VUMwVlpKNjFWdzZ3a1JGcFZjWW12RzBnWFc5MTdDSmFMMnhpdXZUbzdE?=
 =?utf-8?B?dUtzWndjQ01XZ05EY1BzMmRRczFXczRzTXZMY2huNDRWMU16OUJSdTZjSWIz?=
 =?utf-8?B?RmIxWUxlcnMwaXhGWXRmS0hCQnEyakQ3bXVGOEdudVh4QnVyN2NZUFcrancw?=
 =?utf-8?B?czM2WTFDbm1lM3F6WVRvSnhaYWRNWUYxVlRaQXkzaGQwOUZqd2lmem5qaVNw?=
 =?utf-8?B?S1BHYm0xY2FqY21pbnZZeExZVXhPTEhndVo3NkxvOFBibDBTTkFrVERLRkdX?=
 =?utf-8?B?VCt4WXdnRy9ISjdoQndFSEVHYW1oWTBWS3NpY201elBBdVRzL3lvK1k5bURi?=
 =?utf-8?B?amtHRzh4Z0RuNXh6bkhFeCtrYVJHc2VqeUhzTTBRRkFwL3ZaSGNuZ0l6QXA1?=
 =?utf-8?B?SUtUVlBmaFdEaUhoSndVL05MbU5seEZWYW5Sbk4xdkhleVhyMSt1MGpUcEds?=
 =?utf-8?B?eDVhZjFuRDh6UFdiUHVPZ0EwVlRzNXc1UDYzaFhIZllLc1pwMmljN1ZtUTNw?=
 =?utf-8?Q?rSMyxg1ua7NKNA1KrhFhHg5Qq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb13251-79ae-4b41-7dca-08db62e01510
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 20:37:56.9825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRGtJ79bz9vr0/QNMdvB50BFExariGopa4dY/BerbaKN9j25z4NiBzyVSjxKZpB5slkkQbVxM3CTnV/HglQxqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-01 15:31, Philip Yang wrote:
> To free page table BOs which are fenced and freed when updating page
> table.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index e0d3e3aa2e31..10d63256d26b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -219,6 +219,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   			amdgpu_ring_undo(ring);
>   			return r;
>   		}
> +
> +		if (vm) {
> +			/* Signal fence to free page table BO */
> +			dma_fence_signal(vm->pt_fence);
> +			dma_fence_put(vm->pt_fence);
> +			vm->pt_fence = amdgpu_pt_fence_create();
> +		}

I think this is too early. The TLB flush is not done at this point, it's 
only been emitted to the ring but not executed yet. You probably need to 
signal the PT fence in a fence callback from the fence "f" that signals 
when the IB completes.

Regards,
   Felix


>   	}
>   
>   	amdgpu_ring_ib_begin(ring);
