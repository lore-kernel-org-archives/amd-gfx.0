Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9022EC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 11:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0920D10F0BC;
	Wed,  8 Jul 2026 11:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRHtEb9h";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6626610F0BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 11:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJgxzV7FoGEdwSYhUy+23Mz9ik2Ylw7NCOk0iohiu0naPsnMAGKMb850ifYcBy+Q6AqbWrxPeCzg2d8mJP1FW58Yw4FgJP3pT9N7B/+cy24TpCIKdzledaYwXg22SwAn3w0mDivZaYkYb+RKP9BdeooGNrMPmfyiiT2KF8mSGDBD6vHfEZ0qblsJNkV4fkZQsKF8O9yS5RVDo4RHazD4WGiy/0ZB+gxmrM84WsWt76lssVrgFOU1z5G20i78kLHj/oA2maOsvLjU9VIA5jHsty9AHdgQXtW25lFR4qzt5hC+WbrLLdhMwJP7Y5u4YPTUJeJf9Hpt2KwLCNvoMk1K7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjjKnglmfPSmOZH6s4ArYZz7FurgmsEV7ibeQkK4Bkg=;
 b=rGXKQ0YS7wMdBVpukI4ydcaoe1SWXQ6OGfGmrCfufj/rWT/Va4UV/GtINuDQQT+UxVw0pNX41HsABqgFpU8gW8jaVSx81rasfyh3oNGpYYHe3si0dfPjSClbwXtGDyXQWoakZN+0MTSQ+1EFBM/o+9CSIZrKZD9QYGfH3dDLxVgMQ26G0MXF54tQhDJ4/pxiMqJD0HNCng2TbFTEod/cd2XFordRID/LwMquNQlr5iDJMGMkPO3EcunpFijuTI9IguzXOa3GFq2V7BuRjIBx5IwJ85QKo4BX3H+ZSrvZzJ9xkIUJ1SzNrBE2p0B/EPH9TZ56vczh+01+jNngrQJDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjjKnglmfPSmOZH6s4ArYZz7FurgmsEV7ibeQkK4Bkg=;
 b=LRHtEb9hDSL0p/PZuP+NLZ9sU7aqh1fJJnZhrFrH3WW9M65hnbGMV6ZibGyFCEuNcVIpCO32fDOS3OExLynlB0IM+5WR1nSTh73jYfECWRysEf+Gh4Qw4ufHUzrhYA6vecbeXwVgiu8sb4pBNa5BT5L8tEGgNkVGMZ3FKLtoE/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Wed, 8 Jul
 2026 11:18:34 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 11:18:34 +0000
Message-ID: <c963d1df-e1a3-4fa6-8514-3c4ab204088f@amd.com>
Date: Wed, 8 Jul 2026 16:48:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 Cursor <cursoragent@cursor.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
 <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
 <49ba42a4-b661-4673-95a0-c218ec1482e3@amd.com>
 <de530731-21de-4470-9316-dccb767c87ac@amd.com>
 <DS7PR12MB5768E211043CC584F05A16569BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <989fc4ae-cbac-4f17-94cd-5be270845081@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <989fc4ae-cbac-4f17-94cd-5be270845081@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0080.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::7) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e59ccfa-9138-40c7-ddbb-08dedce2a5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|5023799004|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: e/kTT+6cfcqNd9Xnmsaq62XsciMFFR/f72SpLykOQyz5MUVrxKZx1ZVmsvrwcdr6XxplphLcDSpZgqTEo8VWEfIuILrfE9pegwXYOPn9EAEsKHA2mbOwFFRcKqBkWLWOJKcyZ6njUAcFcI7wqvJju5Kbv/J/xr1N/Kg0vBoA5uR8o7pNZxUAZ0SQTVbLr6vs9TToM9wViJF6nSvVtGD4MTsMooFVHpNRKrxXSWT/GFI8EO0XSoBqkd8ypANBqUSESsqddPXVF157hnjRU3AQXfflcxsiZeRd6OZrEzdDwYsw+NR8xou7L4e4gsgdeiAjtyP9/SzY3n+u1BDSo50QyUx9aL4DTL2Vuqa+czQjmkdaa+gI/ceOIa6d8oeke+DMbGiaZza/A1pUCncdnII+D6fGGutWB+k2UXJeS/cER4BJeFU2XK6M6fFbSCXovZoibyhaaMY1Fwi+Q056fDiYvZd+vD3JsLbZppWmYvBDFUsMYAUyw8Ta98OJJulD2OtM0sHQapFzC9Mc2hOJLA/cRc5OjyYn+iyn2y7pCCThYw8kq0RYeFxACVOTLypJ06wZpQ6yFjAn529WufhpBGnpNKYwkMmX5jDZcOlNfmP+zpphQ4+OiMSYyMCoJ+UJym16S6jzH9Ie5IGdzSk7MSJf8VN2IpsP98QDYyB78P2gAWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1BaTV5clZIT04wbzgyaWRKTG9iUjRXNy9pdzlmTkJrOEYwYXNtMmNEaWRz?=
 =?utf-8?B?Rkt5bXB1cno4NDlzT0FibVJ0WWJJQ0NNZFkzSmQ2SjhHcjdSejg1QSt0dUYv?=
 =?utf-8?B?VTZxVm1DNmZhMjUwODI1UDB1U29LUUlyMTNidTIydmNBMmhwQVltendmeGlm?=
 =?utf-8?B?cmtwaDZLWDduVXR3QXhvbldMVnhucjJLYnRXZktVcVpEZ0JweCtxK01Kd0RQ?=
 =?utf-8?B?VEJlYXROYnUrSG5vNXdVUmdLMkYxbkJrYkZ5WU9TS2VMR0M4cEg5bTIzWk5W?=
 =?utf-8?B?R2JiTG90L295dDUzY0h3dHRJZWlTallnK3BsNUxmc28yMnJUcDNJeWppMU01?=
 =?utf-8?B?anY5dkEwOGFpZnJZdGZCbURTd3p4N1BQaFF5WGF6WjJFRFRHWklweVpXVVRa?=
 =?utf-8?B?UlBxWFRUa2pBR0d0UWtybkMxZ1VpYzl6SFhwSWl6aEx0SzNOYlJlMXlrTzVi?=
 =?utf-8?B?eWVURHI4amxEeXlkeDdKRDdiUm05SVAwZlllSnFNYXJ4R3ZyOTZCT0RoQVIv?=
 =?utf-8?B?YTIxTVYvYURlZVBDNHY4aGxOTVpUeGRISUFOUmVTZldvZ1dSa0N1Z01LZ3dv?=
 =?utf-8?B?aGpydmNLbHJYY3ByYmxCU29lUnhyVTQvNHBXaFQ5Q000c0VNYmdCemVIVklt?=
 =?utf-8?B?QXpraHVtVVRJemdPaTM2WGJwUHFOdjlGTE85b3JGN3FmWXRjb0ZlVjhKWGx3?=
 =?utf-8?B?MGtCdkRyNVQ4RHZHSTdENlppWVpGOTIvK2Jld2F2UHJoZTh6bDV0MDlsVitw?=
 =?utf-8?B?b1BjZm9sY0xMRjlBajB0L0NmMDJYT3QvY1NldjFDVFZKNXdQOVpzOWVJM2Y1?=
 =?utf-8?B?WTJXRjMwRjl1RThjcGdIRERuV0p6UVRiMHBSS0VITEh3Tk9YcEswNmg5dmJK?=
 =?utf-8?B?dTFoNmRPY2NYL0tRVXBkV1FYT2dXUlNVN1g1R1A3cjAvcTNFNm9CMytMT2Fq?=
 =?utf-8?B?L1NFUmROb2xZaS8rNHk4U2R2RDh6bzhMNG9kTkxRZ0JFeVpTQ0dOcmpaU0VS?=
 =?utf-8?B?cmdZeDBWbnJKZ1U3UUYzL2hOMlZnWGExTVhGMWxSQXBaOGEzZnVXMXlMdHNa?=
 =?utf-8?B?bTJCV2lZMzFPM0VGalFCOXFNVGE0NWVPUXZBSWowZEJuTHVZV2dVMjJVdWd6?=
 =?utf-8?B?N21mV2pCaForMExsMVl6bkpKM1Q4bjhSaUEwNW1JeWIraUNFYXZqc1NRSjhm?=
 =?utf-8?B?Sm9Fd2xsM2VRTGJKKzVzUWJBa2hka0NHaUxzNGNienQ0TWVJeEFhQUNUcjZt?=
 =?utf-8?B?OElCNkVSUGdGT2tvdFBTZG1HMFZlRGpzS3VVeWVZOU94cllFVzQyNmxQZkhv?=
 =?utf-8?B?di8vUEVFZnNCc0JuZlpVdGtEckx3eFlEZDJvbGRYU2ZqNTlEVTJ3Y2pGNXJq?=
 =?utf-8?B?MmVINm56Y3BVYmdnTmwwWlRmQ1ZUVDNaa1JwL2xpRnpHRVJHcjFONnlxUldr?=
 =?utf-8?B?NlRtYXQwNERGSkVZWWluNjVTYU1nMUovN2lEdVRpZHM3dDFZRmEzdjRUNVYz?=
 =?utf-8?B?cnZpSWRwQTQ4eDZka3RiNVl0Ni9wZExYVnpJU29wKytEcTRjZXlCbnlHN2NR?=
 =?utf-8?B?b0ZIRkh0aGs2aHJ2NmYydkNEN1VVcUVocnZnY2h4N2ZHRUt6K2l1NTZPczNa?=
 =?utf-8?B?VzE3bXFQVG5DZ1F2SzZhM3cxY052N2ZIbTNCcmF2SnRhUzRmSDRqclIxYTYy?=
 =?utf-8?B?c082Zy91bis5bjZLTUNiSkpWTVJlTTZmejZzcW4zMi90RWdKWkY4MmVFQWEv?=
 =?utf-8?B?VnNlRngzMm5qWVZjcGpqUVZpL0FpVWJJMFgvT3kxUE9tWm9ETjNTK3pMU1No?=
 =?utf-8?B?N283ZlBYdnQ0cUdIeDBXTGFhSWE4clFORFFnQjhDRVBtQXpibmVpZFpzY3pD?=
 =?utf-8?B?eExGWkJVdzRnR3hOenJtOVJmVEQyRUxmMzZQS0NHVTd2S0hmTlI2Tk1wcFAy?=
 =?utf-8?B?VGEzNjJJN0xQZjlUMGtqUFQxM3FCTFdGMTFWME5hSVlhSW9FNzRlWjdOaCs0?=
 =?utf-8?B?eXFyb29IYUNZUWg3T3FYMDFTU3lmS0FRS01hRFhBWEU3dVZHanVRYjFRV0Y4?=
 =?utf-8?B?V05mTTZOanRGU2NyVzl5aS8vU2Mzb3NmWmRSWGh0L0hpNFQvOEpPRlBxYlNs?=
 =?utf-8?B?dDZUdkQ2cTdjSWMwaldEL1o1bmxsOE9ReDQxWWhYd0hXZmtzOEVJMmgxVTd2?=
 =?utf-8?B?bU9MQ1p0S09hZ0lTcW1uQ0RVQWRHeFIxRkxGRUsvbC9BR2VWaGJDT1F2dTlm?=
 =?utf-8?B?ZlMrVUtEVk4yNmJLVGlnZEhLVzgwNHdqNWI3bVlVdlZJZkU5STdCTGw2UHBs?=
 =?utf-8?B?RDBzWUpTYk1OeVdVdGdWeWhnMnpDcUxqZHNieTh0RmtWOGY1NUcxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e59ccfa-9138-40c7-ddbb-08dedce2a5cb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 11:18:34.0089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 976qZIZQhVPy8w1/bhWTIntimUHWtIT9rFtm5p4RkHku2HGOspXoE0Yk2sVlpLH+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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



On 08-Jul-26 4:18 PM, Christian König wrote:
> Hi Chong,
> 
> On 7/8/26 12:25, Li, Chong(Alan) wrote:
>> AMD General
>>
>> Hi, Christian.
>>
>> The code " early_full_gpu_access = (adev->virt.req_init_data_ver == 0);" is related to the ASIC type, not the host platform:
>>
>>
>> adev->virt.req_init_data_ver is initialized by amdgpu_virt_request_init_data().
>>
>> Some legacy ASICs, such as CHIP_VEGA20 and CHIP_ALDEBARAN, do not send amdgpu_virt_request_init_data() to the host.
>>
>> For those ASICs, the host dumps the early init data only after the guest requests full GPU access.
>> Therefore, those ASICs still need to request full GPU access before the guest driver can read the early init data from the VF FB.
> 
> No, exactly that is not the case as far as I can see. See the commit I mentioned below.
> 
> According to that starting from SIENNA_CICHLID the full GPU access is mandatory for reading the discovery table.
> 

It could also be because the legacy/existing way used mmindex/data, and 
that required full access including mmio register access.

In this commit, the statement is different.

"In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
VF_FB_EN and places early initialization data, such as IP
discovery, VBIOS, and PF-VF exchange data, in the VF FB"

It says FB access is enabled if init_data request is sent.

Thanks
Lijo

> So I absolutely clearly have to reject your patch here.
> 
> As far as I can see this is a hack for ESXi and that is not going to fly.
> 
> Regards,
> Christian.
> 
>>
>>
>>
>>          static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
>>          {
>>                  ...
>>                  case CHIP_VEGA20:
>>                  case CHIP_ARCTURUS:
>>                  case CHIP_ALDEBARAN:
>>                          soc15_set_virt_ops(adev);
>>                          break;
>>                  case CHIP_NAVI10:
>>                  case CHIP_NAVI12:
>>                  case CHIP_SIENNA_CICHLID:
>>                  case CHIP_IP_DISCOVERY:
>>                          nv_set_virt_ops(adev);
>>                          /* try send GPU_INIT_DATA request to host */
>>                          amdgpu_virt_request_init_data(adev);
>>                          break;
>>                  ...
>>          }
>>
>> Thanks,
>> Chong.
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, July 8, 2026 6:24 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
>>
>> On 7/8/26 12:03, Lazar, Lijo wrote:
>>>
>>>
>>> On 08-Jul-26 3:23 PM, Christian König wrote:
>>>> On 7/8/26 11:35, Li, Chong(Alan) wrote:
>>>>> AMD General
>>>>>
>>>>> Hi, Christian.
>>>>>
>>>>> This version of the patch is not host-platform dependent; all host platforms follow the same path.
>>>>>
>>>>> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
>>>>>
>>>>> Distinguishing the host platform was a mistake, and I have explained
>>>>> the situation at the end of the patch email.
>>>>>
>>>>> I have pasted the content below:
>>>>>
>>>>>           Hi, Christian and Lijo.
>>>>>
>>>>>           Sorry, I made a mistake.
>>>>>           Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
>>>>>
>>>>>           I borrowed an ESXi server and tested this patch there.
>>>>>           The amdgpu driver works normally.
>>>>>
>>>>>           I rewrote the background. Is anything still unclear?
>>>>
>>>> You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".
>>>>
>>>> As far as I can see that is Hypervisor specific and a NO-GO.
>>>>
>>>
>>> I think this should be seen as a policy set by host driver on when a guest operation is allowed. Host driver could do it based on other conditions also, not specific to hypervisor environment.
>>
>> No, this was intentionally changed in 2020 because of a new feature. See this commit here:
>>
>> commit 00a979f3d69e0c275e88c741b854dbe0d5238ae0
>> Author: Wenhui Sheng <Wenhui.Sheng@amd.com>
>> Date:   Tue Jun 23 13:43:49 2020 +0800
>>
>>      drm/amdgpu: invoke req full access early enough
>>
>>      From SIENNA_CICHLID, HW introduce a new protection
>>      feature which can control the FB, doorbell and MMIO
>>      write access for VF, so guest driver should request
>>      full access before ip discovery, or we couldn't access
>>      ip discovery data in FB.
>>
>>      Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>      Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> So as far as I can see this change here will break older hypervisor versions and that is absolutely clear reason to NAK it.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Chong.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Wednesday, July 8, 2026 5:05 PM
>>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>;
>>>>> amd-gfx@lists.freedesktop.org
>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>>> <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Cursor
>>>>> <cursoragent@cursor.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>>> progress in sriov mode
>>>>>
>>>>> On 7/8/26 10:25, chong li wrote:
>>>>>> v2:
>>>>>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>>>>>> Only keep the full GPU access request early when request_init_data is not sent.
>>>>>>
>>>>>> v1:
>>>>>> Move the initialization of non-GPU resources out of the full GPU
>>>>>> access region during AMDGPU device initialization.
>>>>>>
>>>>>> Background:
>>>>>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>>>>>> VF_FB_EN and places early initialization data, such as IP
>>>>>> discovery, VBIOS, and PF-VF exchange data, in the VF FB. The guest
>>>>>> should then be able to read this data before requesting full GPU access.
>>>>>>
>>>>>> Before this patch, the VF still requested full GPU access in
>>>>>> amdgpu_device_ip_early_init(). At that point TTM is not initialized
>>>>>> yet, so the normal VRAM aperture mapping is unavailable and the
>>>>>> guest falls back to MM_INDEX/MM_DATA register access. That register
>>>>>> path requires full GPU access.
>>>>>>
>>>>>> Use the BAR0 framebuffer read path,
>>>>>> amdgpu_device_read_fb_via_bar0(), for the early init-data copy
>>>>>> instead of MM_INDEX/MM_DATA. This lets the driver delay the full
>>>>>> GPU access request until after the early init data has been copied.
>>>>>
>>>>> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
>>>>>
>>>>> So once more: We can't adjust the driver to the hypervisor!
>>>>>
>>>>> Either this works on all hypervisors or I have to reject the change.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
>>>>>> +++++++++++++++++----
>>>>>>    drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>>>>>    2 files changed, 19 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 610d82b79de3..ac66796e8634 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -38,6 +38,10 @@
>>>>>>    #include <linux/apple-gmux.h>
>>>>>>    #include <linux/nospec.h>
>>>>>>
>>>>>> +#ifdef CONFIG_X86
>>>>>> +#include <asm/hypervisor.h>
>>>>>> +#endif
>>>>>> +
>>>>>>    #include <drm/drm_atomic_helper.h>
>>>>>>    #include <drm/drm_client_event.h>
>>>>>>    #include <drm/drm_crtc_helper.h>
>>>>>> @@ -1987,16 +1991,19 @@ static int
>>>>>> amdgpu_device_ip_early_init(struct
>>>>>> amdgpu_device *adev)  {
>>>>>>         struct amdgpu_ip_block *ip_block;
>>>>>>         struct pci_dev *parent;
>>>>>> -     bool total, skip_bios;
>>>>>> +     bool total, skip_bios, early_full_gpu_access = false;
>>>>>>         uint32_t bios_flags;
>>>>>>         int i, r;
>>>>>>
>>>>>>         amdgpu_device_enable_virtual_display(adev);
>>>>>>
>>>>>>         if (amdgpu_sriov_vf(adev)) {
>>>>>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>> -             if (r)
>>>>>> -                     return r;
>>>>>> +             early_full_gpu_access = (adev->virt.req_init_data_ver
>>>>>> +== 0);
>>>>>> +             if (early_full_gpu_access) {
>>>>>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>> +                     if (r)
>>>>>> +                             return r;
>>>>>> +             }
>>>>>>
>>>>>>                 r = amdgpu_virt_init_critical_region(adev);
>>>>>>                 if (r)
>>>>>> @@ -2159,6 +2166,12 @@ static int
>>>>>> amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>>>>         if (!total)
>>>>>>                 return -ENODEV;
>>>>>>
>>>>>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>>>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>> +             if (r)
>>>>>> +                     return r;
>>>>>> +     }
>>>>>> +
>>>>>>         if (adev->gmc.xgmi.supported)
>>>>>>                 amdgpu_xgmi_early_init(adev);
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>> index 9a40107a0869..340703d89d6b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct
>>>>>> amdgpu_device *adev,
>>>>>>         } else if (req == IDH_REQ_GPU_INIT_DATA){
>>>>>>                 /* Dummy REQ_GPU_INIT_DATA handling */
>>>>>>                 r = xgpu_ai_poll_msg(adev,
>>>>>> IDH_REQ_GPU_INIT_DATA_READY);
>>>>>> -             /* version set to 0 since dummy */
>>>>>> -             adev->virt.req_init_data_ver = 0;
>>>>>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>>>>> +             adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>>>>>         }
>>>>>>
>>>>>>         return 0;
>>>>>
>>>>
>>>
>>
> 

