Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1801CC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 21:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A67810E27C;
	Fri, 31 May 2024 21:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x4WQhwfP";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089D810E0C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 21:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/DL/hKshGvwlvE6uFzXTj9WwxoUhxOthK6ZAmQasHpxj0DndxbFzqeR+J5QO3DujLnHNaY6X5OaDo/walTfl6mI+s433A6VFFd9IpHvDzk9uL7xRBg16GireNLSi01z725U2HLIG7MSk2tkZ//3vmX78d7CqJEYIm3jlZvrFjLMm7ShHrEKA0dqE4QeRg95oezFwuNecOcPStm6rUC8iVyEkGbFSrkASzTyu8CGyh/TWNNa7wBU4iwpjBhE61IsUCdaH+rTktvc7qf936duTrUs23eMPNtkW9oc/2XBynhQjm2GJk0rx82qde/If5nnTbQahOBamThwJn+ZucV5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLxltv+/yGFCzkJ6mpjEUkxtCidqOzDrgYTGiy9bbEE=;
 b=IObQlIs06kphzKvYPao0xU9BWh6fCY4UwD5r+8iMkbZEVyjIoJbhQzP9neLno2dhEiXZJll/xr9GFH/OAAT1HmsawQ4k7/Ev/Pbgbzs61nRF/xq5CBiOt3ej6cTVuNNUMscgAkXKPkdKE3SJQOui1tJcQU8NxdCRkaaSTtD46+ykTfqciKx5l2ZipqXgtgrhaspUKH+2zYC1OSRjcyz5EfonBcHZbLdNJKxJcLKSyiaC/9LvkokrU2WWGnTBnxZLr2aMgCB+AOv50+coTjTalhRVMwqAH4i3agDm0Q+aVpURVDSFZPX9PfEto0hhnKDlWGjro2RbBnkOh4JjEuEPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLxltv+/yGFCzkJ6mpjEUkxtCidqOzDrgYTGiy9bbEE=;
 b=x4WQhwfPMV/KZUrb1SyR/7BqbMFt+0gH6omdRpD4IhqT5TxfCjPoFdEz4i4kn4cwPZTscjMWwci6w5tzcSgh2CvbPnJ0lkHU8ZkfpW6AxbkbWWr0r9jZCwOZkB32a58+143MfftDdUZAWJEvot75GjO28lQT5DanMoKY2RZMLrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 21:00:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 21:00:02 +0000
Message-ID: <98ce8560-bc71-4869-8002-569f6193f725@amd.com>
Date: Fri, 31 May 2024 17:00:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdkfd: remove dead code in
 kfd_create_vcrat_image_gpu
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
References: <20240530035048.2341626-1-jesse.zhang@amd.com>
 <68258e83-6172-4755-94a2-a623cde6f8f9@amd.com>
 <DM4PR12MB51525ED43423A5B57D5BCC97E3FC2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <DM4PR12MB51525ED43423A5B57D5BCC97E3FC2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0283.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: eafdc042-4c87-43e2-955c-08dc81b4a3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXNrWGZUdkJLNDRCRmdreUZmUk5uS2NMckVCTWVOK1dVbkRQb0Z6b050cWIz?=
 =?utf-8?B?VUVLQnQrZDEzZkpQT3VNb1BHLzBySGlpMlNlbURHTDk1VW5ubStVYXhhbVJ5?=
 =?utf-8?B?bG5HZm05VzB1ZDFsRUxGUVR2VXQxdzJiTmpIU3hsSUZlb3JXRVBmY3RtVU5N?=
 =?utf-8?B?UzFGMlYxNmN2a2l2MWN3TW9SaHEvV3dROTVhSUR1cjdTZlczZDFLZ0xFdW1S?=
 =?utf-8?B?ZHhoQy9EMEcwNlFUM3p1S2xKb1hZcWx1Sm5qaE1pZHdrM1BOT0lDZGxDUVBy?=
 =?utf-8?B?TCt4akFaTnJhWEtKZEV2a0Y5aERwV3l0VzFjdThyT2dDazc2aEhLZmNqV0Fj?=
 =?utf-8?B?cmZsaXo2YU5WZ0RIbmN4Mi84a2RGcTFLK0poSFU1RWxad0tYUkNxaDF0Qk5N?=
 =?utf-8?B?c3BKa0VKaEFJaTg4OEpVUDZ6U1o0MHJXMEhJZ293Z2lrOTdHQTIvTmN5Y0tW?=
 =?utf-8?B?ZDJBQjZEbGxvZ3YwVHhxN2RBOHVWY2llcWZkU0k4TzBqYVF1R1N2L05CUTBp?=
 =?utf-8?B?VjhKcm5sR0JwUUVuQjhOYnNXd1lUeXNhcCsrbm1lNDkzOUplSDg1RWl0TFdN?=
 =?utf-8?B?aitoQS9iZmxPSUU0WFBmVUU1Y0tCVkRZYnFLeTRmaW1aQnU3ZGFTKzVWUDhP?=
 =?utf-8?B?Uk1lZCtxNVV2QnNaNkJiN2Z0MDZhdkFDTE1MWC9JM000TkQwYUxvOVNmTk1W?=
 =?utf-8?B?Ym5DZVhINERYbHpiZW9jT1E4UEZzbHdKekM5bFVORU9NVHhXRXhRVmlEdGZt?=
 =?utf-8?B?S3RRZHhyZkZFWFlsbVZFTU1TZ2xYMDN1ZnBHN3RxYysvTU9YVHJFMHN4R1U5?=
 =?utf-8?B?NEV3clplSUlqb0xvTGRQUUZzZ2ZhR3FzN1dKZ2tmT1JBZ1VvSnhOdUI4SC9R?=
 =?utf-8?B?RktVeC80ajFuamtFMklyT2lKRjc4MUZ6bXJyaG9iL2JPUVYvMjVkTVhyNk1Q?=
 =?utf-8?B?ZW9VckJXdmk5c0l1YW1adkVlUG0vb3Vpc0RkR25Vckl6dHhNVnRnWjR6RG8y?=
 =?utf-8?B?OEs3NTJBU0RmeWoydXBkQ0R6eDcrZEtHRXM0SWpsU09Ed0NYQzUvbDBWelc4?=
 =?utf-8?B?SnNYenpBb2ZYaCtwSU1OR3p6d1doQkpDMWwvWG1rY05jTSs3cVNwbTRtTGpR?=
 =?utf-8?B?SWdwdnhaMVZpRDhnTEdUNFU3c1ZSdDY0LzRiMXh6M3oyUkJDZ3VHMVcxTmZY?=
 =?utf-8?B?bklxcTRZSnh6eExzYVlhRnh0RlB0MzlTTzRyZ1hzS1NvWWVDUzFGVXRpdUZm?=
 =?utf-8?B?a3VwZisrSFFBK0YySVZkMDd4UVFGZDJIdW1ZeXQvaTh6MHVqQmJuSGRlV2Zq?=
 =?utf-8?B?eHNYYVVVNjZneVgzV3dkbndRUjhsTk8wbTM1eVlPc1dCWUpOdnV3VS9JbzlK?=
 =?utf-8?B?V3NDSXQvcUlYQktYeDZFZ2p4VXNGbXV2SGtxeGlaS3M2UlFXd0RFTE5DNGdJ?=
 =?utf-8?B?c1krcm11U3NKWEhpa2poU3ExOWpvWHZXNUFJL0N2bWorcGxLWlpQYit3RlA3?=
 =?utf-8?B?TmFTeS9pZlNQakVJSnNGQ0FDS2x0Nk1pSmJDWWFVZFN3d0N3QkJLTWFudVB0?=
 =?utf-8?B?ZGt6TXNTR1gzVWEycVYyMUorblBiNlowN1pSMGF0OHVzbTc5NXpxbjIwampi?=
 =?utf-8?B?ZUIwdW5NNW1qSGpCbitrb0FhLzhwSCsvLzA0Q0RRcUREVkE3eFFHTk5EZEdU?=
 =?utf-8?B?TVZQcjM1MWgrdlVMMFRFc3MwOHl5YXM5cnovNmpTNUkxcXZoYldTVEJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNUREphd2N0N3FqQmNIQlNzVlFyMjRQOFowcWpKYTJ1TGxEK1JPWVh3Qm5M?=
 =?utf-8?B?VE9OdlFOMitocERldkh4Lzc0VXJKNmVVWTE5bmM3QkpKSFVNVWNPUXh3TmNh?=
 =?utf-8?B?V2YwT2xINVFndHhaZGN6aklyTlNHeUZFaUwzKzNQTDJDTE02ZC9DTG9XVlVZ?=
 =?utf-8?B?Q0hwRFlYQjlPc3ZyMThyeXdOTTkrbSszK2tWcDdpM1lwd21FTk4zUkNscTNX?=
 =?utf-8?B?WTBWRkw1QkV1eFN3YzYwanJXdytXTnJ5Y0VPNnVGMjNZMXo0TmZ0cmt3eCtH?=
 =?utf-8?B?dWdtbXhkOHhlRkE1Y1lvaE5pU3lwOHlhTWIyRmdxaUN4b0V5YTZMbWZhMXdK?=
 =?utf-8?B?b0pMUG84bHV5KzMwZTJENkF5WFhMV2VpMHhWc25oN0JIRUJzdHViRkdQRHAx?=
 =?utf-8?B?K0pZbjAvczlZT3RnMTdVeTRlbU9VU2grV01lZEp3amUwV0h6cDJkdUdNeVFC?=
 =?utf-8?B?SDVqelJ1S2ZPTEF6N0dlQ3hTZFJkWW1FNGJjb1dWYWtkNXpsK09zb2dxaFZU?=
 =?utf-8?B?NG1MRFpiNlhMcWUyZzY0WGI0Z3h1QTNrUXZlYkVIQ25UcE5rbTh2MjVjck5O?=
 =?utf-8?B?TVdLUFVoZEtYYTJwSlcxWGtZazNNblpoQkxOQytKUjU4SGswM244ODd2NExL?=
 =?utf-8?B?TEVjWjlweVNzRlVPOUpQbFh0b0p0SEdpS3RhbUZuT0R2dHBFR0tZT1IvYTNU?=
 =?utf-8?B?eGRVVERQcnBMSU5XcDVnQm1hV0U1M3JjSllMaGFsaHJtdy9Zay9nSWdRb3RU?=
 =?utf-8?B?eEVXdXd5ZFFpWG1pS0lQRnhsWDZnc1ZKZWRCMXRON2xXMWRxWlpKT0xxSUtq?=
 =?utf-8?B?clVuZC9DYS9pOWlpN0dBQjBWRm45RzYxZVd0ZTl3b3l1SG1nV0IxeU5nUEZ3?=
 =?utf-8?B?OEQwa2NUY1lZTm4zYjRyaFNQTU5OK2NYeEd4NWhvM3g1TUdTcjFqOUlZV2Fx?=
 =?utf-8?B?MXVTMVlyMmQ0KzlwbFNqdW14UDNTTGV5NFdFUE9ZcDRReGtaUFZ3Ly9uMXN1?=
 =?utf-8?B?VUR6SDZBVjkyMUdkcWs4WmJCRExuQzB4bjBoeHpEeWtyVVI4S2I1bUg1NGww?=
 =?utf-8?B?aVVSQmZBSmhEc1E2KzVLYTlSbENNWmh0bWN6czhPeTRWL1k0UmRnbVc5THdn?=
 =?utf-8?B?L1FycFgyYXdnWmJ3YUoybk04eEJzQ2pCRHYxa1hPZG4xcU1mS3Q5TXIyazh4?=
 =?utf-8?B?cXJxUHNjZis2UkpyVzlWc3dJV0k3TkpEZjVMWmFLRzRWeS8xRVV4UTEzckNK?=
 =?utf-8?B?VEQ3NkhXWmxyUEVDOE4zSnRzM3BZL2VVNGJnLzlGc0ZaYmNvNm4xTjhFTzRY?=
 =?utf-8?B?aHMxZ25adkZMTXZ5WDNOSkhGWHBKdWdoNldrb3hxb1B3SnROODhQNXlHZ1Z3?=
 =?utf-8?B?a2RPcGVMNlJRMG1yemhJTFdGNkN4VDYxS3QyRjdOQXNqbVhaK1pTaysrQVYv?=
 =?utf-8?B?U0dISnNRWHExTWl5SEVXc0lyVU5JYTF4V0s1R29PRnM2dGxxeTFKTm54cXB3?=
 =?utf-8?B?K1ppSTQwUkwrVk1vS28rOTRHNkU5OVhqZDljd25HZUJhL1FxRG8vZ1RZTmVO?=
 =?utf-8?B?cmhpZE13Q3VUdU1RU2x6VE1UVkR4cUsxNWdXV3VDU2N1VlQ3UHB3cmpMckpQ?=
 =?utf-8?B?akxybUQyVTdGcVJoSS9xRnV3YUJBWXZabkpjMEErNVRTLy8zQXE4bDZNMGZH?=
 =?utf-8?B?MFVOUUU3Y0ErUjVwVi90VUVweEVFeWtVNStHenU3RmRwOUlvQXdWVVVNZjRz?=
 =?utf-8?B?bGVuZmh0ZmJNVlZnRk1IbXkzT1Z4OXl5UVNsemh0NVZtVGVWbkVFOUhzWm9Y?=
 =?utf-8?B?RDVjL1BWcmFXNnJ4NzFLcHRRSXlPN3BTYmlxdk9GTHhNVnhPM2lYLy9sSFBi?=
 =?utf-8?B?b2Nod1RDazc5ZnZ1RC8xeXBIQ0s5OGVjUDlmc0JHaHY3M1NIKzFXZlBzbFBE?=
 =?utf-8?B?b3ZPZUpXejgwWWc4Rk1OOWhMbWtvMnVKaVp5aE02NW5BblpoY1hZTHduVFRu?=
 =?utf-8?B?SXlSSXVxbll4aDh3RFdiQ3RsUmN6RUN6SFp4eFF3ZGwvdllYbFRqaFJDOHRE?=
 =?utf-8?B?b0JaS2tPdTNIYlpyRHU5b1JRQStBOUIyZDNodEcxdkFsWHNxUXFWWTYvTUVM?=
 =?utf-8?Q?d11tD5hRehdM1JxnKtNMPPF4e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafdc042-4c87-43e2-955c-08dc81b4a3f3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:00:02.5718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVmlaC0wp+qfZrioomX5rFBS2vOD7EZ9QY4gBoJgqwWW4b5fvSjEpCYpaZsqRp4fIUswBRp0UhRDo4CK7o4+xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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


On 2024-05-30 21:44, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Felix,
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, May 31, 2024 4:37 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: Re: [PATCH 8/8] drm/amdkfd: remove dead code in kfd_create_vcrat_image_gpu
>
>
> On 2024-05-29 23:50, Jesse Zhang wrote:
>> Since the value of avail_size is at least VCRAT_SIZE_FOR_GPU(16384),
>> minus struct crat_header(40UL) and struct crat_subtype_compute(40UL) it cannot be less than 0.
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 6 ------
>>    1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index 71150d503dc7..ead43386a7ef 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -2213,9 +2213,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>         * Modify length and total_entries as subunits are added.
>>         */
>>        avail_size -= sizeof(struct crat_header);
>> -     if (avail_size < 0)
>> -             return -ENOMEM;
>> -
> Avail_size is passed in from the caller through the *size parameter.
> You're making an assumption about the caller here.
>
> [Zhang, Jesse(Jie)]  avil_size is checked at the beginning of kfd_create_vcrat_image_gpu
> and it cannot be smaller than VCRAT_SIZE_FOR_GPU (16384).
>
>          if (!pcrat_image || avail_size < VCRAT_SIZE_FOR_GPU)
>                  return -EINVAL;

Ok, I missed that. Makes sense. Maybe mention it in the commit 
description that kfd_create_vcrat_image_gpu itself checks the avail_size 
at the start. The patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
>
> Regards
> Jesse
>
> Regards,
>     Felix
>
>
>>        memset(crat_table, 0, sizeof(struct crat_header));
>>
>>        memcpy(&crat_table->signature, CRAT_SIGNATURE, @@ -2229,9 +2226,6
>> @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>         * First fill in the sub type header and then sub type data
>>         */
>>        avail_size -= sizeof(struct crat_subtype_computeunit);
>> -     if (avail_size < 0)
>> -             return -ENOMEM;
>> -
>>        sub_type_hdr = (struct crat_subtype_generic *)(crat_table + 1);
>>        memset(sub_type_hdr, 0, sizeof(struct crat_subtype_computeunit));
>>
