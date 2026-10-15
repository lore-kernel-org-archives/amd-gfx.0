Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5328ECCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 18:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92275112437;
	Thu, 15 Oct 2026 18:59:26 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DF9112437
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 18:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpMdSwi0KChG8uWJBs8dESUHqkMrdymNX6M36VSx/jDIBtinlFbBTOWLkBJfqyl3yJU4g/DIS8mTDcyg78+o4LC7VaYpsOplFq/FT6e4FSD5PnXeDodqq5yZmkJ+0aUSzWlvzt2Wei+Jn9zkLYD48Uv83OBrUA6Aps9Bm82U6+VBiJ2qSIngO610JMY/tWNJK60lFkCIWCr6FpgX1zjTUEZcz8D0BnF1tinACyE4BU6wr/n1d9AA///itcYOVedYdyIU0XQcawd4RyI08VJfekgfUUsKWfDeG+OQ7rcLwrfW8O+XjsKJFFfJ/krenZFQkU0DC+vD0HDFOqOcaDTlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/FtHpG6u9W/SOdqZbP8CnGIwUHEy5OUc2kccmEhFos=;
 b=OiZ3Y0+chKMncVcfo5kLRADT5AXU3Bp7CRxBwV1lN2n+i8nUP3N3MrjlGSuLqrEQ8ASTYSuz0xdJ7stjJjkVtJ185GmkNWJYU39TsC2nux38pRbj2zf4/w7idoJQQ5jD83QAhCWOGKtRmoSL0MKeYVOGarkHcRkUBKPjDB4jlSGANKO/AiBeRbrMHXABz047hrOZv1SjDWiu2bnFy+j7cJU3dOerVz2OLfAq1zCUbXS9aO+S8qeS7bAGYSL84NjSexkNL1a4qd/wsaLKrax7zSEFeGPbNTD4jPIFfCIvq4JYCc3yxEmPkVKHYu/2ihRBoBqgY95YTjzjfayx6MrIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/FtHpG6u9W/SOdqZbP8CnGIwUHEy5OUc2kccmEhFos=;
 b=CAoYAzLH1Zbr7QR+zj3uLf49DTHn/krYhcHJLtySbGUKdcZEWA3/6K54fQJPskPs3k0uyGvCFRGEL7WCURvgWxRXA5Y+IPGCXGKsjg7Byb2BAXeV+joyruh5oqqT6cPxm9oF5dHFGQui2m+x8t7rJMbWEFuU4w3ckrm6MJFCPLY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 18:59:15 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 18:59:15 +0000
Message-ID: <0639b574-4af5-4639-9e6d-7ba276214713@amd.com>
Date: Thu, 15 Oct 2026 13:59:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
 VBIOS image
Content-Language: en-US
To: Oz Tiram <oz@shift-computing.de>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Min, Frank" <Frank.Min@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "Wang, YuBiao (Ethan)" <YuBiao.Wang@amd.com>
References: <20261014080523.186533-1-rezanikzadch@gmail.com>
 <BN9PR12MB51465FA6B74D63574BA3CCB6F79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <b6c30a27-4f8a-4c84-b227-0c54e5bf39b6@amd.com>
 <cadf8cf5-633b-4df5-a458-b020fcaefe7c@shift-computing.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cadf8cf5-633b-4df5-a458-b020fcaefe7c@shift-computing.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: ca403ad9-d7ed-4f21-ac5a-08df2aee6838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|4143699003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: s7IKxfAZizQtxTtbGlWz1A+WnWfAVPkNn/On7OYal91wyvNNimIkDigjbCwmuF8DMm/8Q7MH8fdKG/+zY8osrkCQE5xLkhHk52+5SsrhYuW15OWg6Uo5SmnCAuafbH1nc8oC3utOS+VFy2a92phLNv3FdwqKDAlRO0BdlvwWoZkRmB2tHqzS7D9xoOc0Lyj4qOoAoyzss5NP4+31gV8pHH4MN9qCQ4vSjI1n9wMPhSzurcPEEf8brmueQX9ZFQA/eo+pc3tr6l2N/DawbcOZkChAFg24BTikN0BjgK7Y/RhT2v1OcobXGSDlI0Ju3oiEUXruR7jgp39c7GaqPKY3wT3w72ayZbyEwQzYBUlmNG2PXR7AIvGPVq4QT7bDQbmk6PvhfGSFX/P0ILgyeahwG79a14lxkX+HkMUdjIWz1MQCi7vgbiWGI90528AkWP4S3+3AlcngCbWbLvA81NJR9k8OxfQebTrcA16VPxvi/1Spx5lBgJ1Fss1Zaxj3QAFEjFcHCHYnP0sAajiNWZjcbWkGlCYMptKb2uuQSPnyq/StDDTuts6HDiJD+kHQDhXsfRYKeM6Po5PC0dEgXNvveBRxonpZ1UQDLhE3ndBIzLGvXt66UztMLGlLT+JMRpqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(4143699003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0QzUm5VSzBRc29DS0RhMVp6THI1UWZlSGFlQk1PSGRtdTZYelAxRWZZamdl?=
 =?utf-8?B?YStySDZNNFlETVlKQWs3RzZhMzlQa2pOc3l5aDZLVGc2WlJ2dHJnK1ZoOEps?=
 =?utf-8?B?djNOWWVXZHRzL1BEblhkOW9hYitHbGdRb2Z5NlQvamFiZmM5QUpvSGxFeFhB?=
 =?utf-8?B?aG9CenVjWTdtYTFtc3NwWjhJVGRHZ3BRbS80Vnh3Q2xlKzZyc1k3aTIwT09t?=
 =?utf-8?B?eExPSFdFY0dkRG9Pam1jajJTUVhkMjRMa2JHb1hnRzl6dlVJeWNNaXJNc2tI?=
 =?utf-8?B?aFFCTldsN3djRmlGZi9HUFg0clVXUHVtSkljUXd4TXR3MG5seUZSTDJXbjE4?=
 =?utf-8?B?N1hNQ0l2eTkxWjhSa09FNWwzV0lHa0p5bGp0T1M3Ymk0Q2Yyam4xUFVjVTdI?=
 =?utf-8?B?Lzh0R0hkcnRONXhCc1U3L1JTcDVZaHpHbFEwQlhjVXJpVjZBNkorTm1YRkds?=
 =?utf-8?B?UDlTTXdhNXZhR0FrbXJhOVJlUTV0WlNTNThLTWtkbUtjSFVtb1laZHNoNE13?=
 =?utf-8?B?UlpPVk93ZGtFOXFnb0FTZHdqLzlSaDFVR08zeHZHa295WnJ4ZXpnRENxNW1r?=
 =?utf-8?B?RFpBYVZpbS93RzlWS2FCaHJYREc3K0k3Z3o5QVJxaTQzeXJCT1Q4ZUt3RDZj?=
 =?utf-8?B?ZkxORTB4V0hTUTBUOHZsQ3pDOWsyMGRvRW5VYkUxYlNkdzZmR0Vza0VIWFJW?=
 =?utf-8?B?TXZsNWZkaGtiY0dOLzdmb0g0UmVKMEc2bWFKSjJwOUhBZlRvR1JtUTZvT3NE?=
 =?utf-8?B?dW40ZDZDazB2aVY3d1AzQnljbWJmQy93R0NNOUd6eWwzTWhadUZHem1FR3JO?=
 =?utf-8?B?WDdMNFFLZTJOaUJVM3FOeWZxaWkvUldOU29NNzJ1Q0ZXZWk5b0RaSHY4T3FV?=
 =?utf-8?B?SmJLRDlGTzdPM1hZWVRLOE43b05GelovR295NzBNcTF4bStLSyszU3hmVWJ3?=
 =?utf-8?B?NmRBYStQU2QydU1ZOWxrNnl3Q1R4U1g5Z3BFOEQwT1RFQzA3MjRlR0xkd0Jh?=
 =?utf-8?B?bWZDcTM2R1lMRG1reXNEQXlnbHBTRFRIQUVvQWprWTBCV0hUUFBGMXlFK00w?=
 =?utf-8?B?eW93RkVuRWVwbm9sRThja0M3ZW1sMGxKMVRWd0ROZEI3dWxhMFhTR3pUYmR2?=
 =?utf-8?B?Q05VQ2p4RWNpNzM4NjR5Ymp2OTNEU1VQTklWb1NDbnZETHh3SE0vdjBqUG41?=
 =?utf-8?B?NWZBY01ORjF6WE9FNU5UOURzNWczd3dGcmRFNTRDQnl5bmJlYThsRUZ0YU5s?=
 =?utf-8?B?VTJkM0tBQm9WY1BaTVRpOGhvRUxqVXFndVp1VjhRNWlKUEZrVEpmb1dUUy9T?=
 =?utf-8?B?V0w2SGlGbXdXSTVSL2c5UXFTMkZCM1VOdTB0SjB1K2tRblNqR2pTL0FmN3pE?=
 =?utf-8?B?VkcwYk4yR2pQWXVma3hBcUxqRWdFcUhFaGlHZURUcVFJYWd4YWZmbXhaeVlP?=
 =?utf-8?B?NU5YYUFXQXVWSU9Oa3RBcmR5aEZDSnBLa05BSTVpRFNrQ2NhUUcyU3lYcXIv?=
 =?utf-8?B?VmkwajRyYnkrT0M0cSsrZkgwckZtN3gvSDhnVURZZWpvRTRIY3E2cWs3T2FJ?=
 =?utf-8?B?Q2ZFbUtGbnNFdERERVpiUVE0QkhkQzJuazJZbE00dWg3RnVrSTRuZmVVMmhO?=
 =?utf-8?B?TWlmblJzeG9FTUdZVHQ3bEswRGdjdDZMK3hZZ3VyRzhOMVltRSt2blppUFBu?=
 =?utf-8?B?cDJwUlVXWkZkby9HaTJkL3NpV3YxZjdsaGp1blBuUEZmUnI3elZHcTU1aUZt?=
 =?utf-8?B?bHFKOTRFb3psNXpja3UxbEIxaHRCNmtEdUVoUUJMQlpERmpOTGhvNGNKOVla?=
 =?utf-8?B?NTNHVWdOZkwrYU14VzQwak95QzVDL0sxbG5CUDdiZFZ5Q3h6UGljQ1dwWVdr?=
 =?utf-8?B?NW45RytrcWg5Y1ZFdnpFNmNLQjE1b2xEcjV3bS9hR3F2VURRSnJ0Qy8rU05z?=
 =?utf-8?B?aXlCeGJpNWsvd2o2WmZsT1NjQzRCaWRpQ1l6YTFWOCtVNFVZTGtmR0orRW5y?=
 =?utf-8?B?NjljV3VEU0ZaZWVSa3JjdVUrcFN2L3JjQ0QwK2JaRkE0T1U2S3cvNXI0ZXZM?=
 =?utf-8?B?ZmxsRlU4WFhDb2JZTGZsdjl1ZDhLamdEdGNndHBzWHJNVFI0aW5udDhQRzJ6?=
 =?utf-8?B?US9VZk1BU0NFYjlZbUJ5UG5CakFmdW9vSVNzVEVaam5ZZzFPNWlnL2V3bGl6?=
 =?utf-8?B?N0hhY2RtR3pFQmFvcHlUUEFiL0Y3YXgvc2xOUFZLNGk3eVY4bloyejl0d0xS?=
 =?utf-8?B?QzNmSU9vVXhZTWdRTDQrVC91aEcwUzhrdVBib09wKzdaNkI5S1kwRnd2ME00?=
 =?utf-8?B?K1VOUkRINXJQQU5xRmlHZjd4bkdOby95MndVMWpPUk53SjZ5VWRhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca403ad9-d7ed-4f21-ac5a-08df2aee6838
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:59:15.1441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHNNYDbA4tcN2EouLqjVLi6YMhogzqp39tga64ccPCbQdlOvrmsJSxPReBWG0YNz1dTO94kZ0itQUH/Q4ZDHYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
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



On 10/15/26 13:50, Oz Tiram wrote:
> Hi Mario,
> 
> pci=realloc,assign-busses was the fix for my problem.
> 
> Without it the dGPU is unusable.
> 
> Best regards (and a huge thanks)
> 

Can you check if 
https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/ 
helps your issue?

Note; I made a mistake that I forgot to include an EXPORT_SYMBOL() call 
which the bot raised.  You will probably need to include this if you 
compile amdgpu as a module.

I'm waiting to flag a v2 on whether Bjorn and Alex are open to this 
direction.

> Oz
> 
> On 10/15/26 04:52, Mario Limonciello wrote:
>> + Oz Tiram
>>
>> On 10/14/26 17:19, Deucher, Alexander wrote:
>>> Public
>>>
>>> + Mario
>>>
>>>> -----Original Message-----
>>>> From: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
>>>> Sent: Wednesday, October 14, 2026 4:05 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
>>>> Vetter <simona@ffwll.ch>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>>>> Min, Frank <Frank.Min@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>;
>>>> Wang, YuBiao (Ethan) <YuBiao.Wang@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
>>>> VBIOS image
>>>>
>>>> amdgpu_acpi_vfct_match() accepts an entry whose bus number differs from
>>>> the runtime bus number as long as vendor, device, slot and function 
>>>> match.
>>>> The caller takes the first entry that matches and stops.
>>>>
>>>> On systems with several GPUs of the same model (e.g. mining boards) 
>>>> every
>>>> card matches every entry on vendor/device/function, so an earlier 
>>>> entry is
>>>> selected for a later card even when the table contains an entry with 
>>>> the exact
>>>> bus number. The later card then runs with another board's VBIOS 
>>>> (different
>>>> power/clock/memory tables) and can fail to initialize, for example 
>>>> with "UVD
>>>> not responding" and a fatal error during GPU init.
>>>>
>>>> Search the table first for an exact bus match, and only if none 
>>>> exists fall back to
>>>> matching by device identity.
>>>>
>>>> Reproduced with two RX 580 (Polaris10, 1002:67df) from different 
>>>> vendors
>>>> on an ASUS B250 mining board: VFCT holds entries for bus 1 and bus 
>>>> 12, the
>>>> card at bus 12 was given the bus 1 image.
>>>>
>>>> Signed-off-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
>>>
>>> I think I'd prefer to just revert the change the loosened the 
>>> mapping.  The loosening was done to fix when someone sets pci=realloc 
>>> on the kernel command line.  I'd consider that to be more of a corner 
>>> case and presumably even that would potentially break on a system 
>>> like yours anyway.
>>>
>>> Alex
>>
>> Oz,
>>
>> Just to double check, it was pci=realloc that caused the issue right?  
>> I seem to think so.
>>
>> Another way we could do this is to only do the soft match when 
>> pci=realloc was set on kernel command line.  I think that would help 
>> both cases.
>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 71 +++++++++++++++-----
>>>> ----
>>>>   1 file changed, 46 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>> index f9315e047..d42485e6b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>> @@ -441,10 +441,15 @@ static bool amdgpu_read_disabled_bios(struct
>>>> amdgpu_device *adev)
>>>>    * the bus numbers disagree we accept the entry if the device 
>>>> identity
>>>>    * matches.
>>>>    *
>>>> + * @exact: if true, only an exact bus number match is accepted.  The
>>>> + caller
>>>> + * first searches the whole table with @exact set, and only retries
>>>> + with it
>>>> + * cleared when no entry matched exactly, so that an earlier entry for
>>>> + an
>>>> + * identical card on a different bus cannot shadow the correct one.
>>>> + *
>>>>    * Returns: 0 on match, -ENODEV on no match
>>>>    */
>>>>   static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>>> -                               VFCT_IMAGE_HEADER *vhdr)
>>>> +                               VFCT_IMAGE_HEADER *vhdr, bool exact)
>>>>   {
>>>>        /* Vendor and device IDs must always match */
>>>>        if (vhdr->VendorID != adev->pdev->vendor || @@ -459,6 +464,9 @@
>>>> static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>>>        if (vhdr->PCIBus == adev->pdev->bus->number)
>>>>                return 0;
>>>>
>>>> +     if (exact)
>>>> +             return -ENODEV;
>>>> +
>>>>        /* Bus mismatch but device identity matches (PCI renumbering 
>>>> case)
>>>> */
>>>>        dev_notice(adev->dev,
>>>>                   "VFCT bus number mismatch: table %u != runtime %u,
>>>> matching by device identity (vendor 0x%04x device 0x%04x)\n", @@ -474,6
>>>> +482,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>>>>        UEFI_ACPI_VFCT *vfct;
>>>>        unsigned int offset;
>>>>        bool r = false;
>>>> +     bool exact;
>>>>
>>>>        if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>>>>                return false;
>>>> @@ -484,38 +493,50 @@ static bool amdgpu_acpi_vfct_bios(struct
>>>> amdgpu_device *adev)
>>>>        }
>>>>
>>>>        vfct = (UEFI_ACPI_VFCT *)hdr;
>>>> -     offset = vfct->VBIOSImageOffset;
>>>>
>>>> -     while (offset < tbl_size) {
>>>> -             GOP_VBIOS_CONTENT *vbios = (GOP_VBIOS_CONTENT
>>>> *)((char *)hdr + offset);
>>>> -             VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
>>>> +     /*
>>>> +      * Pass 1 looks for an entry whose bus number matches 
>>>> exactly.  Only
>>>> if
>>>> +      * there is none does pass 2 accept an entry that matches by 
>>>> device
>>>> +      * identity alone.  Without this, on a system with several 
>>>> identical
>>>> +      * GPUs an earlier entry would be picked for a later card.
>>>> +      */
>>>> +     for (exact = true; ; exact = false) {
>>>> +             offset = vfct->VBIOSImageOffset;
>>>>
>>>> -             offset += sizeof(VFCT_IMAGE_HEADER);
>>>> -             if (offset > tbl_size) {
>>>> -                     dev_info(adev->dev, "ACPI VFCT image header
>>>> truncated,skipping\n");
>>>> -                     goto out;
>>>> -             }
>>>> +             while (offset < tbl_size) {
>>>> +                     GOP_VBIOS_CONTENT *vbios =
>>>> (GOP_VBIOS_CONTENT *)((char *)hdr + offset);
>>>> +                     VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
>>>>
>>>> -             offset += vhdr->ImageLength;
>>>> -             if (offset > tbl_size) {
>>>> -                     dev_info(adev->dev, "ACPI VFCT image
>>>> truncated,skipping\n");
>>>> -                     goto out;
>>>> -             }
>>>> +                     offset += sizeof(VFCT_IMAGE_HEADER);
>>>> +                     if (offset > tbl_size) {
>>>> +                             dev_info(adev->dev, "ACPI VFCT image
>>>> header truncated,skipping\n");
>>>> +                             goto out;
>>>> +                     }
>>>>
>>>> -             if (vhdr->ImageLength &&
>>>> -                 !amdgpu_acpi_vfct_match(adev, vhdr)) {
>>>> -                     adev->bios = kmemdup(&vbios->VbiosContent,
>>>> - vhdr->ImageLength,
>>>> -                                          GFP_KERNEL);
>>>> +                     offset += vhdr->ImageLength;
>>>> +                     if (offset > tbl_size) {
>>>> +                             dev_info(adev->dev, "ACPI VFCT image
>>>> truncated,skipping\n");
>>>> +                             goto out;
>>>> +                     }
>>>>
>>>> -                     if (!check_atom_bios(adev, vhdr->ImageLength)) {
>>>> -                             amdgpu_bios_release(adev);
>>>> +                     if (vhdr->ImageLength &&
>>>> +                         !amdgpu_acpi_vfct_match(adev, vhdr, exact)) {
>>>> +                             adev->bios = kmemdup(&vbios-
>>>>> VbiosContent,
>>>> + vhdr->ImageLength,
>>>> + GFP_KERNEL);
>>>> +
>>>> +                             if (!check_atom_bios(adev, vhdr-
>>>>> ImageLength)) {
>>>> + amdgpu_bios_release(adev);
>>>> +                                     goto out;
>>>> +                             }
>>>> +                             adev->bios_size = vhdr->ImageLength;
>>>> +                             r = true;
>>>>                                goto out;
>>>>                        }
>>>> -                     adev->bios_size = vhdr->ImageLength;
>>>> -                     r = true;
>>>> -                     goto out;
>>>>                }
>>>> +
>>>> +             if (!exact)
>>>> +                     break;
>>>>        }
>>>>
>>>>        dev_info(adev->dev, "ACPI VFCT table present but broken (too 
>>>> short
>>>> #2),skipping\n");
>>>> -- 
>>>> 2.53.0
>>>
>>

