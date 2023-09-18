Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB31C46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 17:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440C410E2C1;
	Mon, 18 Sep 2023 17:52:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F4F10E2C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 17:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoZp4HZId831jplFvFG1e70uw/unYuXNGZ4LVO98UN9s16/3lUuL5hqU5JhpeY9KIoV9dNthLMTmawi+N+fP4Jk4h+qwzXZE+eVoOtGfxPz/z3AKNPxSv6ZjQD57E/PsZCMck/YlRmO47yut71JqZNnBjuCXlGUyFGjlTUOTTNIUofG2TrV+9n05WGauX+tMDl19zAbznM6RGqFLQLkiYSQVBWR+Lj18zx+LEFnD2owcNvMNuRMbG/RoLYS/MsN1xrjsXwYm8nFX6CvDgeuJ3UJKyaybo2hZJb7vHaAsh6IJO1l3Q8FdopZTRq1gNO4Sih1bQdDqCPRPLAOjLseWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+nXg2bs+oG1Drpuinr8kbC/3oRp/xxRnhd+JmcpKho=;
 b=MRRqnWr9M6HGF0Bd/68FoBqjWHmQmVo9D4sxDLzeW8SOsGJ/TDtLvs4FCt9/H5GGIi8kq9AOnOFwCpZuxciH6HE8iiIYMa4SuEwUPvsChf0yGxzg8ID5CeAOIG/zkGj4NXCPMpYxVn6ixcU7L3BFMUC516U/vDg1xI9IZgj2Y7e7+Z/nteNU2tMCIOcB1Ogct7wwJ0F+BVrGKRfCqLz9GdSdv78VSdX52xi2cVhMOkeR7S/mSkThrwL27lqDkqgBiPayM6Rwm4UfLx7y9Pwh+SzSWMho1SiDLn2am8g8TMmBjfosJYyapQLP3aqk3OCPMNahOQeGLXK12FJceDvx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+nXg2bs+oG1Drpuinr8kbC/3oRp/xxRnhd+JmcpKho=;
 b=fl4WzL19Gr5qOhUuf+MTsYS8fK8Bd4/PRklAmK3FfpWDcOLCx4bxAITjJnZW4xq0rdqhnVlboRw5MmlDXxE7gAQs/HwsvUS+wHkqK+l+N0VjvAXE4buVr+TP5wez44GmYE1KfqCgg1riH1Im2O10vzUacea5fXuk8Z6R7pOJbZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 17:52:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:52:47 +0000
Message-ID: <ca2cc9b7-d0df-e570-46c3-7e28be75091b@amd.com>
Date: Mon, 18 Sep 2023 13:52:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Remove svm range validated_once flag
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230915201833.30416-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230915201833.30416-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::30)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c95c913-7144-453d-1e72-08dbb8701170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41h03brzX7u65RCHzjkjr0ggfMcAdf+eIEFg0J/ljsiFMcgdLodZJnM5v3W4KNegLgvzzteVDbgqncjxNtseneRXM7H2SkG/K+31Lo75dmwI73VZQEcuWLc4p2hKrgmgo/E6WG+68WVXta1ap8LSwQKSdl8jQW2BG+0X5JUH/PJ3nF4PWKplcTUfLZKNABaHw87y3x/zq5VnzrWZf3hdLuT5+ii/oSVxdVCvziQ9NDGIWkrDVQ0+9U/QZwJMS+z2Qso1Wf7LOcaOx/23tC18Vcwr7k/iTWmO1lxeXhrVJpfaFpVagwyMM/CUUTrmnIclH5B085CAUM1kj1a5Nb8j5kstHOzvd8McQFyc//XLo5Pc3Wyx425WZ35QIf9OQGW9nRO7g5na7hPFjqyKjdrqQhmwtFL3RFKGE8sZJufY+3fy9vTuwlGyNdHDE6njy0rMuz/dRZW421asyEAOtt7d1XNYK/KIoSTTf8NlUO6MV/oSSah0vcIxkYlpLVU0kIp8BAju2KXkF5QaoBIVOHnN/t8fsFDZ1CE9tr3JKDN7rrEHu3uq2Z/e5NHPYOd6qhhjHP1h/ftnKRgWvBs1t4phfFyK5ZQ2GR35jPSiTNM/icy7tA5Rs0lVPHJfEcOzXOFOIeRh36ljFPomcaC4KA6SCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199024)(186009)(1800799009)(66946007)(53546011)(6486002)(6506007)(66556008)(66476007)(44832011)(6512007)(316002)(41300700001)(31686004)(478600001)(6666004)(8936002)(8676002)(26005)(5660300002)(36756003)(38100700002)(83380400001)(15650500001)(2906002)(2616005)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhsamtBVnNFOEJTS3d1RTM4VHhtK0kzZEdIU0J2aFhrK2Z0SnA0RDhUejZu?=
 =?utf-8?B?M202dXpKSm1wb2JLaTRSNVd2M285NG1lZkltRTMvdm8yaVdCa0Y5Z3A0bXVO?=
 =?utf-8?B?YktLcFFjbzREbmIvWkk5UEtrTHptaVpuU3RSeFpmUW40clppMnU1dmk0Q1dt?=
 =?utf-8?B?Q0lDYjBmaXkwTmRCZnc4NlFZVFR4ejd2eXRpdFd5TmpXQlZJeUpRYUJQaDdp?=
 =?utf-8?B?cWdBdTYyMlo3QVJKd3lnbGlHRGlOTzNwUWNSVmRHYW1PWVBlckVuaDBJYlRi?=
 =?utf-8?B?bVhSZEhnK1JZdVBhNmt6N3pWczN1bmx0di9NS1Q4MGVnYzI1T0x0NGNyb1Ex?=
 =?utf-8?B?ZkE5WlFsdzRxaEJVS25CbmhlMzIyVWJqcW1nMEdZTkkrcktyRko5Tk9SVkUz?=
 =?utf-8?B?YzZnNkVOQWJ1Y05XWVJmY2R0RERKUTJiNklPVTBMOFRPUnpnb2NyYUk5TGZJ?=
 =?utf-8?B?cTdXb3JjM1orbnI0V2g2V3Vsb1drclNkZS9CRzkwN1V1WFR0Y1VMcFlsZXNG?=
 =?utf-8?B?QndPbG44djR6Z043YUdBdTU0TXNrVFlZYzFVenJWZ3RBbVU0TUxYSThWSXJ3?=
 =?utf-8?B?cXVqMWVsUEI1L3c4dkpERDArd1RwemFYb3M1bk80UTZmMXlBNVNXNUk0ZTdW?=
 =?utf-8?B?djU5NHhHZ2hqblBUeGNmOFpvTmpWLzExbS91emtIQjNwZEZuQlFBTWRMR0xE?=
 =?utf-8?B?U0tqekYvZ04zSlBiT3hUMHRrdDFDaGx0ZWtLdVQ5MmJ6SkVvTlpBQ3BHcFJM?=
 =?utf-8?B?aGNDTnV1NFBrSVB5aUR2dGF4UitUN1NjbGNwcW9FSE5kL1Z5d0VHdXYxT0Yy?=
 =?utf-8?B?NElBeTdhR1VpVXZ1RE9ML2IrMWpjaklva2lEYVUxNERUbjZOT3hSMVhlbHRF?=
 =?utf-8?B?d2lvek1TNURCVTJvUThpRExYMTlYa2E3eGp3OFVvY05rSGZkdFpFekdmeHZx?=
 =?utf-8?B?Y3dBYVlPWmZLY0FmK05La2dHSUYrcHppUG9maFJISW5qOEcyeUJ1aktqaENT?=
 =?utf-8?B?MEVUN3BqeENBM3RzUjFsVFovaFZFTUpXRkE1aktFUXZ2blRHSGNDWGcvNVdE?=
 =?utf-8?B?S3RSeDRzL0kvak9PbUhrbW9kNEtlMSt4VGtYaUhTNUdkTWhKNTdoV25HMkJY?=
 =?utf-8?B?OTRFOTlnN2ZSdkhWQUpPdTFza2EvNzRLL1pqUjhGeUpyQjdSRHhGWUN2Z2tV?=
 =?utf-8?B?QW8xZzBJenEyVGtobDhRRVRhWDV2bVBJTGpXeE50c0JxVTg4QkhUcjJUY1Uw?=
 =?utf-8?B?aFFlbWk5TTdVcjhtQ2FKVWg0QWVSODVJZVZtWDFsZG0zbEFsWUxiQlQveUxo?=
 =?utf-8?B?cXlmWVp3MUJ1QmpyaGhFUFFtSDc4enhSNTJHYmh2Nyt2ak1IbTcwb0RnUWh1?=
 =?utf-8?B?MUpBZUJiVkxrSzA3dXhFdHlvVTB2ak5Da3RRekRkK3NnL2hHZG5rVDd6R05K?=
 =?utf-8?B?VHJsRHluQWFydkw4VnRGZ01OV0VFeFhicERybkZXT09xdEdmRVJsK1ZENVNQ?=
 =?utf-8?B?ZjU3VXRBUDZpUUFENkdCbFpyMllnY0ZoMkhZUFJ6bFVJeUZlaXNaRjVpU0hv?=
 =?utf-8?B?NTY0VDZ5a1FuaFhKZG5qN0p0bTkxciswNTBwQTBYNDF0ZnJnM1BJN0htdVNr?=
 =?utf-8?B?ZFlDbmNDS1habnRkcm9jSjlEZWEreUNWclh3S01sMW5wY1NDZkN4WlBlSFZY?=
 =?utf-8?B?bkRkRkN6OEkyN2FIR1o0ZmVZRDFjSTYvK2JrU2M1N0ZMSWx2QkR5dlBRWEda?=
 =?utf-8?B?UTF0dmEwaW4xT2ZBTzA2TG9DMnNoN1czSVJXT21Dd0hjOTYyZEFMLzlHOHJi?=
 =?utf-8?B?SXllcE1WSTM4alFLNEgxZWs0MVFoa0MrdGtUZFdVOU5Db1JHUkVWdFRCMGUv?=
 =?utf-8?B?Tmx4Y3BzWlU3MWY0Y2w2QkNoZmw1Z1RWS0JyNXZWdTNkOURZUnhpV1ZKc3Nx?=
 =?utf-8?B?dmhpT2hnU2RJYnJWNVd5RitFcEc0R1gxZnZ6dkROVUFWcjJ0Wm0vNFZBamFh?=
 =?utf-8?B?Y2NnVXRhdlFSVDFuQzkvM2htVWsranpnL1o2SjE0ZnZUd0tiQWZKWHRJSnVD?=
 =?utf-8?B?QVhtR3ZOdXVCV3VwYUQzZk4zRFJkODBVWW92YzlGUk5Fd2MvTm00VFZhZS9O?=
 =?utf-8?Q?9pHEsXtgYmNbSIhk1eRr3CfeV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c95c913-7144-453d-1e72-08dbb8701170
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:52:47.2976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yM3ysB6EBTAKCCnNUSs6Pbq3GYLMh58V/vLuduI2Bb3/eTtME9EYs1YPiRADYnKH4QLI1MTcdrRiXt1MO5n/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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

On 2023-09-15 16:18, Philip Yang wrote:
> The validated_once flag is not used after the prefault was removed, The
> prefault was needed to ensure validate all system memory pages at least
> once before mapping or migrating the range to GPU.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 1 -
>   2 files changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 26018b1d6138..562da3c40515 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1730,9 +1730,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		addr = next;
>   	}
>   
> -	if (addr == end)
> -		prange->validated_once = true;
> -
>   unreserve_out:
>   	svm_range_unreserve_bos(ctx);
>   	if (!r)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 91715bf3233c..25f711905738 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -132,7 +132,6 @@ struct svm_range {
>   	struct list_head		child_list;
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
> -	bool				validated_once;
>   	bool				mapped_to_gpu;
>   };
>   
