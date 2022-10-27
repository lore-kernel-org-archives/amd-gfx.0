Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231F6ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 15:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8378410E686;
	Thu, 27 Oct 2022 15:38:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609AF10E686
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 15:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWMKya+fS6VHY+8oUCnHo5HA0PudDluHdX5OBarVSPSEtW2H3LMkb1vSFRrV6kUHr629Cuz3jpcj3qmS8JcLvm2OPI4ov+6iaw1IWkYx9Kgqt9CoPeER/1y02z7BZc1amar0aTPiXCL2BmD7tVkkdgs2OupoiulDpWUshfJIn7PGlnMINvUQjIe+tqxhNTkQeVaxHdE5ueuRtwaiglkCJtgXbdXpsjdCKSydDL/LYDiyYxTqbXmM/tMvZY/TOKODcu2ebC823ewA8sjZI8fVslZlXU7KMd57K1qDfhiXlCg9k4WtTCX37VrKBHZDIG0vv2v/Z6ASKnoXLBAtnM58Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lgHp7XxxVNFv/VMO3HBEL6kBwHhPd7TJwlogdHxepE=;
 b=IuJOork2sv7Bv6uNc0KeYG/VTDPu935IO9/q514uclocgzLYj7EXCmlbVPwqb/O4hlxrJ03O11ruzBN69G+45eK4EzxTJNfJwSPjVBmzYD5hJJwj7gBmUvKaq0/phgw95lrwQ8cF90AofcRIjgBpuSAQxRx4trywySRQdutBaxKc3DVGATqMAUF9FiuCQbgVn5LdlfQGXemxKi0bT0pRdMWijnVq+HfB2VX2U+m6Ygb2AJ/VTjKEdmEOPdoJkUCOHrUiwaa2Oxyy6XLnZv3IqVFiUeF15zkSNFZEnQEBHK77LKjtu8ZOQ58QpWZ9iOXwfqYPwuNA8wYQP6jXS7ljEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lgHp7XxxVNFv/VMO3HBEL6kBwHhPd7TJwlogdHxepE=;
 b=DhkQnV8Bz/YpfZMSqTSwqjyb2tsox3Ushpo5z5mQkos0C7J3ziocna6YxImDTuZI2zQ0+W+B79dCnODjpx0ru6j0UR87q840orxEBqaOap+nvkCOC4TLHHVXzIUqvAp3mudOUKtowmaBq8SQgr64QlB2xY/wZfDKpWi/lI0fwwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 15:38:06 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 15:38:06 +0000
Message-ID: <acd46ebe-c8b6-fcbd-504e-170836945f5a@amd.com>
Date: Thu, 27 Oct 2022 11:38:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 2/2] drm/amd/display: move remaining FPU code to dml
 folder
Content-Language: en-US
To: Ao Zhong <hacc1225@gmail.com>
References: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
 <20221026111258.25000-2-hacc1225@gmail.com>
 <d9de68d8-1c9e-7cef-cd82-ad0a6de59817@amd.com>
 <79d354e7-f61f-1f82-819d-91f4f2141fe6@gmail.com>
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <79d354e7-f61f-1f82-819d-91f4f2141fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f7eb1d-89bc-4d67-de74-08dab8313dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZecVt3U85rj1M5KVHDkxb6JpX7hMaH4U7UeVKYHwpurHVT5jI6GwDk4J/3tsSsWrv6xx/eksDq+shntANQxHc0Sqj9zWYqD3k9UGLJhYG6H+83VpQaGH1Y9+qN6un3cFVZTu99OylwvTiRIexnzrxSlqeH6zhJ9AAHmsx5x7ilYZ9byJxE4+R/L2Kpphtzbod/jf8LaYFfSWgG91gDbbrIAITYVZckJw2CGQ7XJ4gAvSgkKc6BVCChYkPGSqWxGjWRx8Ts8fJXkVW24DQ0EB59d4BIaeEc2FFOAwFNk7SHkDwpo6yNVqkk7EtTdpWM9hHOEt/+EL2z76KPLlus2AhAi+woT2IjEzhKw+VykrVn6QjYl52Y73GU/364B+cbDsG6anMQJ+/MQdW0oG7XOYWk/JF2EIzMKy9HuLMNDhTzKXDWYfNh2tV7voiuaQmspUmflZKxrmFAZn0BFIqkXN/nYIbTklveTCVnt0BJ6yFqu/hM+4vAsgzi6vs5Vwg4Ol2I1YeE66qDMnJg0sH4l16R0zATwMXg2DK07ztoU//N4f/IO6WMM6ESjh+eUBlgA2LVD6d7o76U7H0XIeviPEQWmsSYbbPvqn6rpAkQrGVMMUfVefJiVfkBpryC+g/A34Bk81VFU60O+QDTLszL3iNmdr+uoR1RvZ+FSKoQ7QqTj6EwOkskAq/EjsEbV94VHZ66WBcRyQCGE9IRXEi/gyhoYjIDhyT07AHqVO2eqOthwmTYi84YN3uBFiOEORvdDauPpIW+AGqqIQ94oaiE17bNknLgaz3ypAdqY0TyZtuzjLMoSZILBvWBbIOIpNNHYL6vEazSKoz1mlnOSP0ipkWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(31696002)(6916009)(83380400001)(66574015)(38100700002)(66556008)(8936002)(5660300002)(66946007)(66476007)(2906002)(8676002)(6666004)(86362001)(41300700001)(6506007)(53546011)(478600001)(2616005)(6512007)(186003)(966005)(4326008)(45080400002)(316002)(31686004)(36756003)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllQVFVOQlBMTUMxNFBCSGJmcXZhYnpwUlI0a0o2bDM2Y28vWDUzN2orNUtW?=
 =?utf-8?B?OThmSjhIQ2V3QWFiajNscjRJbVdkVmlRYmhEdS9BeDFrekc5MERQdTFpTUlX?=
 =?utf-8?B?YTIvY0xRU08wTk96N1F2VGxJVHErU2xCZUcxaGxSNy8xS29FZkQ3MjZvSi9p?=
 =?utf-8?B?R2JUQmNOSXVQa1hwek5ZWnBJOUVhMEF4a2tXaDlGMGlVanRxR1k2SHE0bXV1?=
 =?utf-8?B?UE81MGllUTVMRUVaZi9vMEV0aGtLWG5VVWJmdUlpMXFXVG1BUkdyRVBzOHFQ?=
 =?utf-8?B?MGxOVHhPMlNmZG0rOXdGNHJvS0xBMy9XOHFqQ09wVmF5OXNmclBZcFhJV3Vo?=
 =?utf-8?B?UXEvUzhiZFRqSGVYZGQrdWVGQi9CYmdYakNQV242S3lsRlFLa2FFZmZIakJO?=
 =?utf-8?B?THBSckFVM1crT0tyMzl2WUJkb08ySmpUSTFHZEdWVzM1Qm10bWdSc2Qzdytx?=
 =?utf-8?B?SlZVOTZjR1M5NXN6YUVHOWs2WGtlamVONi9KdllrR1RRNGhPV3NEY1dTMFVT?=
 =?utf-8?B?UFJmbXhHUm80WDZtRTdOdHYvRW9SUHU0RDdNTitrNjhsZmpadVZqQmw0Szg3?=
 =?utf-8?B?aXJqODhDaW5hVDJ5bmtLSEZGVDdSR0tDUUU3R1MyVGYyODNJSUQ4cjFleDdj?=
 =?utf-8?B?TkkzV3lIdEYwc2FLRmF3L044SDllVndaaGxjTWd0Mk5WamIwU1dIcXZDVklY?=
 =?utf-8?B?VUwxcVN1MzdScjFPWUdKcDhLQjY0UFh3d1JyZll0VmEwaFRrTmdyWXV0czBG?=
 =?utf-8?B?Y0czYm1iLzRSM3dRT1NhSWRpcHJScmV3T25JM3duaElzZzdKbk4vcHpLbEZ2?=
 =?utf-8?B?djVuQTRBWTVPUW55cXlQSUNudENYZGw2ZW41NTZXNXRUb1RuMHNwcmJpa05n?=
 =?utf-8?B?UWswSVplUUtMc1lQUFk4ekwySHl4ODRtU1JOank4Z1FlOU10YmtQK0xDUnhi?=
 =?utf-8?B?ZWZmVEp1MVM0dDBvazJhQmJOMUZHSkZUb2J0VEhiRk1EbnJtOWNWUDM1TG5C?=
 =?utf-8?B?L1hQS1JQOURMY01JNVc4Qm1VZDJhMGZ6VzBLMVVwSVlsN2d0TXEwNEVjWGpV?=
 =?utf-8?B?cXBONXBJOGxEb01PT2xYVUdzV1ZBdmdQbEwvQjFMOCtiRGMvMkh5TXpqTVQy?=
 =?utf-8?B?eHpxeEM2U2t4VUJCQ3JINVZ0aVh1cDVHOWlOOWxUTG1RRlJ2V3kyQmp0U0pP?=
 =?utf-8?B?aFJiUU03aXZkLzl2UVU3R0NGakNjbmdaSUhaU2lJWHZZazNMZURPcVB6NjBD?=
 =?utf-8?B?SlpFd0NiL2lVcHJJeEF3SWxaTkw5TnlOdWMydGp3NmdEZk1XczVmL0xIYzlr?=
 =?utf-8?B?UkZUeDl1NGF6b3R3OG5OT2ZtQURsR2hnYXl0SUF4dlFveGJFelVZQmc0dDEv?=
 =?utf-8?B?eVZvTldLMGNrUWZyTUJXN3poMVdjWXV5eG82SWpDY2Q2YkpxdmR6Mzd5UkQx?=
 =?utf-8?B?NDFQd2NVODNUNkFZZThFK2ZZdFFhZ2dhRlRvQWhjT040a3RFaVZFTlNQUXRZ?=
 =?utf-8?B?akdCdDhYdmtjRHJzTGd4eW1Jc3VFTUNvMU5qSitrSWN0VEkwdktFWlVlYWpL?=
 =?utf-8?B?VmhqMzZoZ2NIbTZiSEdoRnI5TjR6bkh5VUkyVmtwbFA0OG1zaUlIWXVFY0NU?=
 =?utf-8?B?aUQ2Rzk0VVJaZ3piaEk0L2xLeHB1Z0l5TXNpT0JFSU9kTzR1VkFpWmQ2a0Rx?=
 =?utf-8?B?eEdWTnc2dnRFZkw3MHR2THd4L1RYOUxqM2g3amhtakJwRkI0SmZqWGhXQVZ3?=
 =?utf-8?B?U1JnTFNiRndvMXFQckhFSktmTTkwKzZ2eERQRmk2aDZMdjNvWmlXM0ZhY0ts?=
 =?utf-8?B?TVBrUVRqdW01WGJIcmlZUm9BRUNSY1VWSFVEdHU4M2pXTUo3RnMvd0prZFRU?=
 =?utf-8?B?UUIzRGp4YWE5UkxiOGFCcm1GMTJ3aGtHWkRzemo1RlpDVEYvdS9sOWpLMUhv?=
 =?utf-8?B?WVdzcFpyd21uMVlESmF4NkVkbDN6aDR2R3FzRTZYTlhDeldRcGdPTm5LZVR1?=
 =?utf-8?B?bDNsSmpUTW5BZ0lPZzN4TzRXb3MrY1JmTVVKYWY0T1VWRnBCd2xsblh2WUU4?=
 =?utf-8?B?R1V6UElKVlZhNWREdXV4ZXB0LzdOT3VjcElRckNScG9mT3EzYzlGaUFMc1NL?=
 =?utf-8?B?V3NqeWFrSFdiV1RKMitCWGlsNjBXaUp3RWNMeHZlOGZoamhHWU13cUd3Z2ZO?=
 =?utf-8?Q?8rXRctwczApYGl36FNlV4a0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f7eb1d-89bc-4d67-de74-08dab8313dfd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 15:38:06.1177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8Of3q4LJHjUmm7EMKD083rSy47VX4wE3iIwkjx9sAF6NA+72wU/ToqBXanluQf9CaBqWPiPX/Bjj1LNlszkfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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

Hi Ao,

Could you share a link that describe your workstation?

Thanks

On 10/26/22 17:17, Ao Zhong wrote:
> Hi Rodrigo,
> 
> Thanks for your review! This is my first time submitting a patch to the kernel.
> 
> I'm not very good at using these tools yet. 😂
> 
> Recently I got a Huawei Qingyun W510 (擎云 W510) ARM workstation
> 
> from the second-hand market in China. It's SBSA and has a Kunpeng 920 (3211k) SoC
> 
> with 24 Huawei-customized TSV110 cores. Since it's SFF form factor, and my machine
> 
> supports PCIe 4.0 (looks like some W510 have it disabled), I installed an RX 6400 on it
> 
> as my daily drive machine. It has decent performance. I uploaded a benchmark result on Geekbench.
> 
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbrowser.geekbench.com%2Fv5%2Fcpu%2F18237269&amp;data=05%7C01%7CRodrigo.Siqueira%40amd.com%7Cdaa18df14f004d2d621d08dab7977866%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638024158436988558%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Iyq4tWJL%2FfXuKB9xAUaVTQQmJQ0GRZ2rH%2F%2BXPTT%2F2tc%3D&amp;reserved=0
> 
> Ao
> 
> Am 26.10.22 um 18:12 schrieb Rodrigo Siqueira:
>>
>>
>> On 10/26/22 07:13, Ao Zhong wrote:
>>> pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>>> pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
>>> these two operations in dcn32/dcn32_resource.c still need to use FPU,
>>> This will cause compilation to fail on ARM64 platforms because
>>> -mgeneral-regs-only is enabled by default to disable the hardware FPU.
>>> Therefore, imitate the dcn31_zero_pipe_dcc_fraction function in
>>> dml/dcn31/dcn31_fpu.c, declare the dcn32_zero_pipe_dcc_fraction function
>>> in dcn32_fpu.c, and move above two operations into this function.
>>>
>>> Acked-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 5 +++--
>>>    drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 8 ++++++++
>>>    drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  | 3 +++
>>>    3 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
>>> index a88dd7b3d1c1..287b7fa9bf41 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
>>> @@ -1918,8 +1918,9 @@ int dcn32_populate_dml_pipes_from_context(
>>>            timing = &pipe->stream->timing;
>>>              pipes[pipe_cnt].pipe.src.gpuvm = true;
>>> -        pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>>> -        pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
>>> +        DC_FP_START();
>>> +        dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
>>> +        DC_FP_END();
>>>            pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
>>>            pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
>>>            pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
>>> index 819de0f11012..58772fce6437 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
>>> @@ -2521,3 +2521,11 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
>>>        }
>>>    }
>>>    +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
>>> +                  int pipe_cnt)
>>> +{
>>> +    dc_assert_fp_enabled();
>>> +
>>> +    pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>>> +    pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
>>> index 3a3dc2ce4c73..ab010e7e840b 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
>>> @@ -73,4 +73,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
>>>      void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
>>>    +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
>>> +                  int pipe_cnt);
>>> +
>>>    #endif
>>
>> Hi Ao,
>>
>> First of all, thanks a lot for your patchset.
>>
>> For both patches:
>>
>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>
>> And I also applied them to amd-staging-drm-next.
>>
>> Btw, if you are using git-send-email for sending patches, I recommend the following options:
>>
>> git send-email --annotate --cover-letter --thread --no-chain-reply-to --to="EMAILS" --cc="mailing@list.com" <SHA>
>>
>> Always add a cover letter, it makes it easier to follow the patchset, and you can also describe each change in the cover letter.
>>
>> When you send that other patch enabling ARM64, please add as many details as possible in the cover letter. Keep in mind that we have been working for isolating those FPU codes in a way that we do not regress any of our ASICs, which means that every change was well-tested on multiple devices. Anyway, maybe you can refer to this cover letter to write down the commit message:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&amp;data=05%7C01%7CRodrigo.Siqueira%40amd.com%7Cdaa18df14f004d2d621d08dab7977866%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638024158436988558%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0GMN1Uj9iuQv2ZjipDHnl29V0UvWk6IL4XwlehdPNLA%3D&amp;reserved=0
>>
>> Finally, do you have a use case for this change? I mean, ARM64 + AMD dGPU.
>>
>> Thanks again!
>> Siqueira
>>
