Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ADEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB09610E7C3;
	Tue, 24 May 2022 17:27:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689DC10EFD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOe077DXLJd304pe4rrw9eACvH3jQY/JB6lmSFizRU4hKdoqY8sArRlEu7vtm3LkXTQllXOPDOmdJCUxywGBrleYE9lfs4alpTV+3Y6gMKXHiGLzJTIJOIGR8U5VMKtJdlWm7lHdcXRVpXHFOIUawcmWQh2cw2XTTdu1syRwA/nCljGK3S4dOikroA+/nf2pSDlVUh2ql4xYr6cn/qVoaXfWwx7MX5vL72sEbo5NPD49NSNfFjur8x5owSL4/S/7MlMLG+02G3Kkj4B8iwHXwSezYvU8fi5fVaGXPjN5Ksl39VDFgGVT9VTJPXXdGt+pfE8xWtbr1A7uR1gVWTc1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aksd4sPu6nDnBqjlr42FDfPW1GJs39GN0i7fwNdPlKY=;
 b=LbHfgB6RNu8rSm++wD1qX4EWGaRNomKECwVcy/DeAqUBudeNQkOVBLfhwRtNV/PESwnu6aAtCl6MydADsxnOB9tKYrMB7BqsjvjMwOrG7BR7xYW1Q20C8xlL7biwa3qsWreKHx+ro9yRG6Hp/uoSueqLjAgXnWwAT9Tn4X/A7HgmG1O3/S5spiU6xAOMqUv2HxPNM6JmF7CaHyHpap758jbCrQ9L+l+rwKYXK0FYvMi0Pp1NdMoBgSVIfb0NZhCc4PvgpzcXNXXQc3a0S6xwymAutYXVXHkK27G8fYBhJg78s5lI02tHoc881rTHweeDw+5vPqy6owWIzmQWnSB4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aksd4sPu6nDnBqjlr42FDfPW1GJs39GN0i7fwNdPlKY=;
 b=CxNkA7/m6PsKtzsozYNXb1bmqgluJJPr4nDJKR2mFgK1ALKnxeCeyGXJe/h+Jfg8ytWfemi7wnE6SXPsGe5GisOrqYlQF0awENn3SJS5E9S6Uiw1XClH1M3vXp9zrb+TSFckHy6RxboHEApOSsfPDY4auhGuET8ify9ClanMQJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4991.namprd12.prod.outlook.com (2603:10b6:208:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 17:27:49 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Tue, 24 May 2022
 17:27:49 +0000
Message-ID: <218d95f3-b38d-21ff-64fb-3f3df666babe@amd.com>
Date: Tue, 24 May 2022 19:27:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
 <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
 <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
 <2e8b9ebe-3d1f-40e5-73e3-54607a8045cb@amd.com>
 <7cdad508-17b9-17b0-59f2-de0bf98ed780@amd.com>
 <ae53629c-7922-6a17-c162-e9397386106b@amd.com>
 <2fb3744b-f23a-ebaf-98a3-34b4eb12df80@amd.com>
 <ee0413a6-c1bc-f927-92b9-d5b0ae4499d1@amd.com>
 <ed9a32cf-1cf4-2fdd-1e8d-5904c4d24837@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <ed9a32cf-1cf4-2fdd-1e8d-5904c4d24837@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb39c8ee-aa91-4dd5-b2f6-08da3daab971
X-MS-TrafficTypeDiagnostic: MN2PR12MB4991:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB49912F3A017DEE641331ED67F2D79@MN2PR12MB4991.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBFpPnKNpa5RTBDFG4xqHg8AkzmHnUXCHDfX0rsskAB3aXmhyLYIJWFtcK7cOKoc81LgyxnuSmrMct/rvhBGT+03yiVf2Y5H3n7oreE0g+dU8THDYOyha+aABzOHZNnwTI5AW1NGlsu6TfqqqD0YzxRpovR/c8m3jMp3iwANZs3wVBnDmQkraGtefAeHPvosPBiaLacjbYt7z1l4YdAGwSe8m31XyJNMQs+PQWyGokvtOPz4raSWnklRH+5i8qJ/3ESqCIWuHt+KyQBDslc4MchjKggj9elKGOQ5egxrFW73sy3QuyFT6h5NB9+GV/cQiwh1/l7bp9Exf4qVpKKWFXTwGMTYWIcAEX42ApSwVDisibBb7Ut6OUODQeJ4ffUtmVTKr3bHOQZgKtX78S5p0nWyGwkaxylvejEu/aIWXEpKU1Lq97ivA9hMVtF4iO8ve9bOV0BQkp8xAqPMHu9E22ompxnSI+N6SstiISv+nMUUYcd2gtL2qeUcv/i399y9Tr5b7JtsjqYjYFIhqFFeLNZ14fb8nGJLH22C4RbtuLeDAwDzSDVxdzdvs0+6pNswxmI5TpkeMXYsSqHVb0p8+He9ZiDlfiiq/nOBcm2dS9I0Ny7kW2D9E5WWO+1hsBs01+EkG38V7zlEirfS/JxxxNa+gALlxi7HLxWDmDGI2d9Epvx2ocXbhhYLw7y63ebTUV5F5zjcJnOCDTMhxFUm+pLk1qOqz3C7u1sQqXsLmb69YZKrkAfFvzcXiB+kcfX1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(6666004)(186003)(31686004)(8936002)(2906002)(36756003)(38100700002)(6506007)(6486002)(86362001)(2616005)(66476007)(66556008)(66946007)(31696002)(316002)(6512007)(110136005)(508600001)(4326008)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JmcElMMU03QWR0VjdlcjBVVWNuOVplaS9TUmZ5TmxGeG5XaTFaMjB5Mkhz?=
 =?utf-8?B?WGpqSDByRWU5RkI2T3JiWWdlcU5nSkl5L2RrVjlwakErT3ZLNE9HSVluWHFK?=
 =?utf-8?B?ZTF6VTZFdFJnMFR6NFRxemRmekhBeDhqT3cxbllseGF2Z2pFSFJBa2RUdEZk?=
 =?utf-8?B?ZG9nV1Bma3BZemJ2YlZTdTJzYzUrMWdIWWlXN2RjUWt6L3lBTEgzSU5LZGg5?=
 =?utf-8?B?Y2V6M1MwYjc1ZjhFREtVK0JJSitBTXNaMzFEMklVc2toS0IrRGJXZHUxRUdN?=
 =?utf-8?B?MHhId0p1cmJDYzUzSHVpcFhoM2lNVnFxenZ6cW40SU9PT2U0cC9WVG81ZE5F?=
 =?utf-8?B?SHJXaURoMGUzaEE2T0tIYjZYc0hTbndUdko3M04wMFE0cXlQa1czc09aNzJz?=
 =?utf-8?B?TXJIY1EyeXk3OW5qQzRXbHNBMm1yZTJnVGdtbWNLYUlTRXRNR3NsZXJKTkIr?=
 =?utf-8?B?OFZaL1NKU1dEUWZnTlAxQVVzbm54R2twbUJKY1Q4aVJWZ1ZmaHBmd2xmWHVr?=
 =?utf-8?B?SlJuYk1RdVl1b1dZM1ROR2xXbFhNTXhxOWRVKzNGeDl6S3ljZXVsUWU1eEp0?=
 =?utf-8?B?UG81SEIrOTVpcnFuYnhHK29SQVVIMHVHZDVjcGxaRGRJL3l2OFdyQ0c5bEJJ?=
 =?utf-8?B?Tks5akpZM0hhWWQ2bFJPMVR2MEpndG1xdm5rN2lwaTFnQ3MxakhBOFRPY1Bt?=
 =?utf-8?B?S0x5NjZrKzJGdlRUc0dyaVVRY3JyR1o5M3ExYWNTK3paUjJseTlQQUhXYnFY?=
 =?utf-8?B?Mkp5QmtPamlGSS9sWXN4NjlGY3E0UCtxbktqa01LN2NPUjR1L2M0cVA5anda?=
 =?utf-8?B?NS85SVRHRGJRdWFYTnNVcnM1WlYxODZvcThEZ1AwK3MxTHE1YmVSZDdqTHl4?=
 =?utf-8?B?WDJCWDBaYnVGSlVvbXBVdHcyRVZPajFFNzRMNlVvUmpIN2NjdmczQlFzSzVw?=
 =?utf-8?B?Vk53cEN2Wk5QZnBZZFNUVmFWMEN3YW1OaEw5amRneU10QnZyeFdBTFIrN1Uy?=
 =?utf-8?B?TDJWTFNoZzFSbnQwRzNnaWpwbEw3aXFoZ0w4eWJxUVhtUVR6N2VzaGtxOS9m?=
 =?utf-8?B?VTgra1ZUWWIrcHNjQ25sQmcwSEpvUVl1ems5ZEt1MkZ4UlZ3Z2pQNHBvdzRq?=
 =?utf-8?B?SFRXZnU4TzcvYnlDak5tMjJBY3JjaVRRK2duTGhPWEFtZE8rUVZ2eUVGMHNX?=
 =?utf-8?B?a3I4UGJVaVNPQ3lKZkhxemFIWlBGNFllRkIxYmYwVmIya0VJSXQrdlBOR29o?=
 =?utf-8?B?YW8weHd5L1I5eGlCWFIrclhoVW5oMzVoeGNnU1VLQ0M2ZlRFSVRLMnhZV1R4?=
 =?utf-8?B?RWxWdGtNMzZhbHhLTDFvVzE5ZVBUREU2d004OGJKMnAybmc0cTNueXY4eXJt?=
 =?utf-8?B?aUZXSW5aWENRUXFqcTZCRnk2UWo1eVN1SVQvUVBxd3k3YVhhNlI2UUU3RXFN?=
 =?utf-8?B?R1VCNkNoVEZFWjA1clJ0MVYzc3gzQmZTM3MreXN2eHdNTE5nUUU3WmpULzFr?=
 =?utf-8?B?Ni9Zc0NpalVJUURuNUVNa2d2SjhBMnV6dldVS3Vnbjh1a1JrcnNUSEFMYlQ3?=
 =?utf-8?B?cW9WUEdiTHZXWWtjSFloR09Tak1tNDlNZ1MxWENkY2NMRk5QRjFyT0VkNnkw?=
 =?utf-8?B?Wks5Z3BhSWFXei82MjNIZ0FwaTJQNThndTBkS2xadVMvcENlU1lJVnZ0cnFN?=
 =?utf-8?B?RXk3bDZ2ckU4emZna2VIWE02UFB1RVZEcUU2NmJuakZ4OXhWQTNjR085OTdF?=
 =?utf-8?B?VW5mZ0NLay9VVlpOUyttbVN3a3N5cUJsbElyelRHVWxoN2JYQjlLNDNoMDla?=
 =?utf-8?B?TUM1cTJpTlNVb0xMdTFPK1VyaDFPUnRVOW5lRmlML1h4MjBQSE4xOURCc29l?=
 =?utf-8?B?MEFSQ2JOVFE5ZHVkRjRmVXNLUXJpZWtLQVhBUW11WVFQWWpwU1hOS1VWWEt6?=
 =?utf-8?B?YTlGT0VwTEU3RGRtRHR2b1NmME1zYXFxcHNzTnJIa3p3L3VCREtWVGYzaEhW?=
 =?utf-8?B?eTB3WW0zWEJDMko5a2F3eU80ZFcyc0FjUEpZL1h2L09ac3NUekxWTGlVc1Vm?=
 =?utf-8?B?WERrNnZIamFVRFhWZ1J1YTVBaVVOcmhkTk96eDQ4VUIyZDNrYmtTR1VpYjRX?=
 =?utf-8?B?a3lPekc1aUl2bzh2RThzdm9mWnBqNE9BSlFTZTNsNWVBN09NcUxsVnozQ1pW?=
 =?utf-8?B?ZDlHYUxPc2xHSVZvenVFd2xGWDk4MmRSdEwzYmlmbXZlTVpVUGNsdkdxRmJQ?=
 =?utf-8?B?NGdQWlFxTTJpSXdmbjhrL3c0WFlSaVEwa1JpMXNmOXloLzR2UTltZzMyL0lI?=
 =?utf-8?B?Z1ZUeGtFMEZEeDlSeGVIUjlYZzVuU3FQMFNzbGFrMkRaRHVqK01RMlZXajR3?=
 =?utf-8?Q?48OOYkGhZ8bkp/AeKNbNOTktxBUwrYZVUWtoz9OnUprPP?=
X-MS-Exchange-AntiSpam-MessageData-1: bloee584basR6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb39c8ee-aa91-4dd5-b2f6-08da3daab971
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:27:49.4456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+3kRrkqTxrQBKHTm/1ezHWN4l/qmq/tUFDuUc9cljyIaqUl5KaGsxEF9TfX4aCx2wcp1YXn8qk7X4rwWuCaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4991
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

(snip)
> #ifdef CONFIG_DEV_COREDUMP
>                                  tmp_adev->reset_context_vram_lost = 
> vram_lost;
> tmp_adev->reset_context_task_info.pid = 0;
>                                  if (reset_context->job && 
> reset_context->job->vm)
> tmp_adev->reset_context_task_info =
> reset_context->job->vm->task_info;
> amdgpu_reset_capture_coredumpm(tmp_adev);
> #endif
> tmp_adev->reset_context_task_info refers to 
> reset_context->job->vm->task_info,
> i am not setting PID and process name separately, instead i am having 
> the reference to the reset_context->job->vm->task_info on valid VM.
> 

I think you are not getting my point. struct amdgpu_task_info has 3 more 
parameters: process_name, task_name and tgid.

When VRAM is not lost: we are getting the whole new amdgpu_task_info 
structure, and all parameters are valid.

When VRAM is lost: we should reset all parameters of amdgpu_task_info 
structure, not just pid. Else other params may contain garbage.

So what I mean is:
instead of
tmp_adev->reset_context_task_info.pid = 0;

do something like:
memset(&tmp_adev->reset_context_task_info.pid, 0, 
sizeof(reset_context_task_info));

- Shashank
