Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F030EB64DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 15:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3B510E0E3;
	Tue, 18 Jul 2023 15:09:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C1010E0E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 15:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwf/RcPw00d1OR9+5fgNwfcZfU94/r2zczMxYXTu9MWR+XyIaZFI3trhikrtHODXBrNxeKLckgb8bfEvOcsIc4dIJXh1aaG0Wq9DftDY6TvCf13j48A4GitIH9U9qVGMjeWwFtvnpA4ejhSoYlHTbUPOmL6PwJQiBcfcmcLqEVyHZ0BjS7UWa84BE4YdYe7kLUR6dD1LoUGKYpRhiuN6ulP4omfaGqUX1STj9y8ywLVmovioQn2jkVUBV7R21hCohL2ikNmnIw8ke39vdgy94CVzseQvnkiscqmR7tf4XqPsDmLXQNWRvGcQWF8N5qbzq+yKCJw92ZVhKNV0RXgUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohSmZjz/EIXW+jIftGVl13scammEFduxbTYMYADGk+g=;
 b=SOX3G73dny5cXtG2e4CTEL0fKJPPjjCEX4cSBfOTz4+KqeCmtYhmULsoWL1IzKtkMCEADmx4/4KcMKpQs7sQz2zzW+L/jlkIzDE861pKLVeAxzs1m02XkusyEYMPoM3ObdgpY2wp25K2CwTE1fJryk+FIO7j8LUIqP5kOeQSVhKnXVFGucbVKMZ5IF1PDiwxNXR4VWfWwGzt73H/C3s92nH+vAfDVvziRKo2+a+qM/8tqU9efBsUr7wbnnWQt5i4pL+DOIs5pxbLzI+AoT9cIO7AmMxdeS5e0/KaVoEg5qZCBunjWE+Ag6EMXeVr5RG1DyXEN7OrrxI2TnsLnoqb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohSmZjz/EIXW+jIftGVl13scammEFduxbTYMYADGk+g=;
 b=wZKPEZHjWKaxD92NTVVG3XK8fT3pnxQbruz/DvPuI8f2js0D+M6ELDMk22sAEYDNWofAnHvd9JGBEZlXo+9Nfdxnr4vcxkAqmS0pe+Bit9y9Jm1vRq1Ps7ntEyDSH9r3dao+QQyrtqAep8G2ozTEdABWb63BAd6DA/lU45Z0Uf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 15:09:32 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::bfee:712c:bc2f:8844]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::bfee:712c:bc2f:8844%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:09:32 +0000
Message-ID: <5de2cb5b-ccc2-68a6-aacf-f1882885817c@amd.com>
Date: Tue, 18 Jul 2023 11:09:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
 <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
 <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::10) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb845d0-cc30-4511-db41-08db87a0fd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48Crvju+OtKurYOOEtefhsTMIpMuckEo4fHv43RF3RBqRNz7Y4m/8UyJj+g+95Qq7jEQVCcd7Ugy4Oe6eULxyakPoEMG4s8/5BKBQtR7qKZpwV0pXtXUJg78q0DGXCjIpyVhwOTJjLf/DxVhkefr+SN22X/lHzMyuk+kZ9U3IIDDd/wwQnixtREHQEIVqrFZl0dSXRceX07ZbVNGoRX+8ZluiBOTupuahwB/oCuwZy/Wu3xSXvA3mHCAqMHE/Wr1FurHZmPzVj9QKH2QgrW3/0RIzeo+FG7TR+oLNQaIFYUn1Pv6GN23zIK14WgFHEezH0MZDcfIoI9ONhjst4jwliXwWfWo5MFAx61MBsqsNRcuID0mJE0B3xW3YcAL06uV/55FJXyVqAsJZkdKgjwrOyztJgC/rAtkrodvfQYdBZX54NXvf0MpUkXzyyI+CEvZLwT2YKu0C9g2/Ylj4w7RD+K45JtG96efvf8fwJmQXdTJRor5N6CAN0XodxFYaUfL1xOgfCCppPynM+qgnyxcYBOOvGyXwGPtgmN+u4s8pKsCyn9RSbaHk7Nen/h0Pc3neSiG1a+46gYPS4K/MdfgsXTMIexfcDVZSQ9xNbXPPRgHPwewoRruEo85cRaX5LHVpamwPt7a83l2/9dzrS0mPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(6512007)(8936002)(8676002)(41300700001)(6506007)(53546011)(26005)(4326008)(478600001)(66476007)(66556008)(316002)(66946007)(6666004)(36756003)(6486002)(36916002)(38100700002)(5660300002)(31686004)(83380400001)(15650500001)(31696002)(2906002)(2616005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpoMVdGbUx3UjMzNTFZSDhYVThQUFJkaE9QMWtVY3dZeThDclZPTW9oaFJL?=
 =?utf-8?B?Yk5LMWxtNnhTdlNKYXRpekJLL1ZxZFdtMjFYdFk5V1RvSExCQnJ5eXMwOHE0?=
 =?utf-8?B?dmhiNUZXRlF2MnIvblNMMDlXQkY3a3NoNEJyeVVqZ2draW5FRzhmeEt3dE5D?=
 =?utf-8?B?WUlTSFhabnVMcTN3VkZKWmJ4YmJIODVTbUZBR0NYMm9rYnhTcVRZNUZjVGll?=
 =?utf-8?B?ejg4Y0luejl2ZGwwaEptdUdHWlpPSnZlRHF4NnpRZjJRc0g4bFBLUmtEemxn?=
 =?utf-8?B?UDcrWnpXVXFPbXJGL0N5MGJIdzl2NEVNQlRhVGErVWZnNkNBbUh0c3E3M1Jl?=
 =?utf-8?B?czF0UUl1UWs0eUVCNzJydmdJSHNoRHo1NmhWMW9rOFFoMm5LL2Z4WG54UWxz?=
 =?utf-8?B?MHlodHpoVFVSNWE0SVVMWkYyWHNFTk1XM1gxZUVMN3FaWlhyMVNKMXpSVUs1?=
 =?utf-8?B?SGxBUmRmZHpwemFvSHRYK0x4M281L2RRWDlVOWcvZWl6ckYrVVo0TGtDbWY5?=
 =?utf-8?B?enNFNUJyNENSaHA1VThmK0xaL3B2SllvQmM4RGluMDVmTEdHSDBHMG1HSnd0?=
 =?utf-8?B?aXNqbHRBOGdSNzNSU3BIMDEyK3NlUXVyZjJTZURIZndCZUJMYkRtUGI0TXNM?=
 =?utf-8?B?RWF2NlVuTnhGVGtXcFQ5WSs2OTk3M0JXUFcwWWdSREZIS1RwK3ZLNFRiNVhF?=
 =?utf-8?B?TTludFg5djFsbVhNQmhsNnIwekFVRVFEcU1nYk94ekFHR0czdTFDZGRIVkwr?=
 =?utf-8?B?bmpWbmFPbFF2SFUreHNKbkpaQlgzOHdYTkh2VVdDcDdzTndNS1lFYzZFYjVu?=
 =?utf-8?B?ZlVuaHBNM3c2QzloRFhGUHA5cjNDVW5pYlNXKzZlUU5KRklCb1I2T3BodWpm?=
 =?utf-8?B?aFVCMFRvTGFZZmxZSHV0RVJKV1NGWFJONzA0Z1gzTWh3RWREY0tGQUk5aGRO?=
 =?utf-8?B?ampOTDRBYy90NEsrd2huQk83ZGtydUxtL2hzWFlIWWtWSmxEUk03NE1SWXBL?=
 =?utf-8?B?T3JtNEhiY2pmemNjaTV5QVNSREhsVmVJMlhhdzhsYWtZREtlT1Y1VHNJQnVB?=
 =?utf-8?B?cmJnajFEWStrMlNmRmx0Vm5nbGdia3ZTOG5Rb1doY3ZnS3BEOTZuUWRHZlZD?=
 =?utf-8?B?clR4MFlCVG4zeFZ0Qm50eUw0V3V3dEloSkFGLzNVSFF6MlF0dUtvcjhwcTZL?=
 =?utf-8?B?Y0VOZWJKK3hQR1VFbG1BeUlZL3lTSkJxa1lGR3lkSk04WjBHc2NUV2c5anJ1?=
 =?utf-8?B?aklpVmloL3hKdVFwVFNJZjJzMmhQVW1TU2xBU2ZnM1JlbFdBUGJ6QzNPS2Nj?=
 =?utf-8?B?ZHlYRXVyeDlKckpYUzcvWTgvVzVqb0lhRnFuQ3Qya1lTcGRQVWhlVlRWdVRa?=
 =?utf-8?B?bzdOTE9aMTZCZldmeVRxS2VKU0hySTlhMnFHSnByY24yMXNLWGtzSjUrV0VF?=
 =?utf-8?B?SFd0ZWVRVnF1alhtOWI3YUg0MHozNnNkSmdiWjFSSi8vUWo1Qmh6eGNLQ3c5?=
 =?utf-8?B?VDdRVk05SDd4V2R5bGlGZHhGa2kwMEcvcTJPT0VmVEl4aEppNjV5UUZ2SEho?=
 =?utf-8?B?RHlkVVltSE5KRmNWaHB3SzA0QjVGVDJSR3NCZi9XVUxQQ01vUFFxSHJ6Ny9X?=
 =?utf-8?B?K3llZU92OXBYUXpjQTRPb3NEK1IrZ0RJYkQ0SmhPL0lmNFBJeXQrcXUxVVdK?=
 =?utf-8?B?ZHIwSTdoUWZxUlIxSG9xUUxLL0duUU1CRlRCcytnRzJ0cTlaNGNRTE1UWkNi?=
 =?utf-8?B?UXk4Q1owZUxxbmExZk5Va0VqeVhkbzA2ZHJWR1BrRzB6bHZ4dGRjbDVpRmdP?=
 =?utf-8?B?UlUyV3J0S01iNmE1a09ScHdXdU9FYllqd3NyNzYwRGtEdnpVRzQwUURiMXZw?=
 =?utf-8?B?c3pEWjZmUzQ4SFVKYW81akFsNWRNL0lFSEp3eDE4SDNZeDAzVVNabkJwRFp1?=
 =?utf-8?B?MkZVcjh5Vy9qK2xzRjNESFNNN1JZYmozK1NZcjViKzZGb0dMQ2g2aFI5NzAw?=
 =?utf-8?B?NHRoK0xBQ2hlS1diSEJVV1AvekVSK1BVZmdaY0djVElzeS8rNmpHaStGa2Q1?=
 =?utf-8?B?VC9aVEF2Vk9RWXpDczQwTnRxSEI2ZW00VWVNTFRkT003Q2ZtVmpXMGEvaEpT?=
 =?utf-8?Q?LuZYl1ZMauKeRkP9wdMyC9w43?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb845d0-cc30-4511-db41-08db87a0fd99
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:09:32.4798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXtZY0BNbkcJsm/TuG9MKaVUjHb5SNybOc3XrvWnKy3RJJnml7jhixCfdktrhqgI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-18 10:19, Lazar, Lijo wrote:
>
>
> On 7/18/2023 7:30 PM, James Zhu wrote:
>>
>> On 2023-07-18 08:21, Lijo Lazar wrote:
>>> Not all rings have scheduler associated. Only update scheduler data for
>>> rings with scheduler. It could result in out of bound access as total
>>> rings are more than those associated with particular IPs.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c 
>>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> index 72b629a78c62..d0fc62784e82 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> @@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
>>>       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>           ring = adev->rings[i];
>>> -        if (!ring || !ring->sched.ready)
>>> +        if (!ring || !ring->sched.ready || ring->no_scheduler)
>> [JZ] any case for ring->no_scheduler = true, but ring->sched.ready = 
>> true?
>
> amdgpu_gfx_kiq_init_ring sets no_scheduler flag true for kiq rings. 
> amdgpu_device_init_schedulers inits schedulers only for rings which 
> doesn't have no_scheduler. However in gfx_v9_4_3_xcc_kiq_resume, the 
> ring is marked with ring->sched.ready = true;
>
> I'm not sure why it's done this way, but this is the case even for gfxv9.
[JZ] I think the sched.ready confuses people. here just means ring is 
ready be used.
> This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>

> Thanks,
> Lijo
>
>>>               continue;
>>>           aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
