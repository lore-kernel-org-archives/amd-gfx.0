Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1F0C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 20:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B737910E8C4;
	Mon, 13 Dec 2021 20:20:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D3410E8C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 20:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py14EW1lO6+/rK+P1HHvpxk1sXheYUaitRt+KI1ZxC+xEIV5+ow5Of1K5FNrenhn2SOHA1dHlcatT0EQr0znLD3bJxv6E0v26vNFBhftimDevsLNPKQSyvZCIkBmulzGZ4PTUs+1WnNlcPKocaPeDXeLGax7x0wWvXfH6ZYIi47v543MzrO+Xt/I+L27B5EHt4mkUtIf+kjAAZcQK2STqN1bnJY8jInNTuxECqdB4NJjwRp4FccY2HDcUjiD0d65/c4V1RM6ay+wVXsYx5JAx5emSeP8SHD1f1brQXKfl/L0yf/EZIA9pN6/ffRMktxan7Zdtmk1zRCKg2ETmCZV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMNomkgdUS2hqIFmQ7EDScD+F7opKVgUKiTSqLKwayw=;
 b=FtcQyQJk0lpbnZGuJiZ2CNmde+pgLWIJI2+CqHeSCuLo+XDBAtNMSmQ4al1PCUJgFAvg5Ydgrg7ipyBbT+mL/IkrzSvtSVLSnljRjqwZQdLclKBM/fO/le/rRAHQeyJNM/M35Jk9RZVzzde59qIn8WqnyUfZgMr4tPBhtxW5+/danx9m21oDnFCeaQkJm1XjTpgzAUBmFuZOWITj/CUW3TFbfeMypxHTtrUIICs7qOL1MXHp4V5sD7uBJUUxVhNObjzErKzQpKbp8QBj+by4rVYvkf4Zl7CvurZjwcXQXMEhHes2TqisBf+y/o5RF3fNOTE3IqMBqq6Nh0oDL8TdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMNomkgdUS2hqIFmQ7EDScD+F7opKVgUKiTSqLKwayw=;
 b=eP9ZBv3+8vWHHxWUtMRKMnD1B+qX508xU1u4prLto1FN7HWmZ7eUhIDf1U9wQZ49OT0Cm8puLJxvy0zpwRdWD3MexKupN1LMVNIupyIiCr26yrWImcNd7l2FZwg5gk5c0GQ4tuH0rgG3TWbPndQwziOBSMoaI6tkpMOYDLhfYYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 20:20:21 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 20:20:21 +0000
Subject: Re: [PATCH v2 2/3] Documentation/gpu: include description of AMDGPU
 hardware structure
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
To: Yann Dirson <ydirson@free.fr>, amd-gfx@lists.freedesktop.org
References: <20211210182030.3834-1-ydirson@free.fr>
 <20211210182030.3834-3-ydirson@free.fr>
 <c5563e17-d978-58ee-8350-5b51593fb5bd@amd.com>
Message-ID: <2750b51f-87ba-9393-8d75-711701a7437e@amd.com>
Date: Mon, 13 Dec 2021 15:20:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <c5563e17-d978-58ee-8350-5b51593fb5bd@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:208:d4::25) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a42b162-c172-485f-b76d-08d9be75fcb7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3151E5F6E568C5B45DB6A64E98749@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwp0QFCN+skPCKT2WX2RMJJIINYJRwNgyjiwyZQLYlHjsZQbAukzt2XIdP6Z2TRrynweEoPpRF6AVAUJjVo4GAxKiJnp7UBIasIKCrS0HhqyeGkb5Gi/Nz3F6pdivH49ey/3eQvyeftW61xet+sfNvi0SrMOJ9rUze+ROU9nJZxXpTILt8kSd3NUSTEO8ZVepf5uefeEGqhhy2OAmm8QRbmHp3PzKfZIS0gKYPzgSx1Sj47xqr16TFaidOeglsbcPJXgAo3GobB1ZV/dzoq5JjTqC4zXCNBD1B/skAXUMklaf7TRIguIHPKi+WjuybrB1NpPQXZPUwE37ezIulnoxADNtS69ltaQ9DQqIvZH17qajU6mkVp7QWtEvaZLN2fIWFCHjK8ZUhPYYK0hZ9DT2RrOxDC6Nt7zibIBzigplNuYaEg+pSmE4ihr1FOrqlV2uyXuwqkur3r5Fmusc9Qtuk8NSg2mROtsd+0tqp6dQZVMfj6MOVXhMHsMl0Dn27L9VTBthxeP1ewbBYjsrsBCFf6cWlAECpMt4GXVXmeK/Mx4cgMiATZJmeWlFzh2qabRTFIjLiQdqrhKZZws51jJ4JayUZuPHFnDtrevxLok1QvD0QYn3M84SiMKihlUKTa82+UVHgngJTqFSvG5H8hm+zK9C4mHCZlfapcWLU/fmDkIOynjtSyj7XqFvBBS3YVH91kfVB7GkbQjPCmJnzqSQBNqIFQwglZnpsf1aNOWYQ8XUSa/bMU6BM3HFj6drlI0aqQ1naKoF/tfiYHLhDhpBxjXq1mWwV2SXhwmcoKDC4L/aSDI3ojgN7sBoOCqdgYozrfjRuzHI00nX6HfVuQqeblPq//YRSjnb05h7Dp4hug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(54906003)(6486002)(4326008)(8936002)(966005)(83380400001)(31696002)(6512007)(508600001)(38100700002)(316002)(8676002)(66556008)(4001150100001)(2906002)(66476007)(53546011)(6506007)(31686004)(36756003)(2616005)(66946007)(5660300002)(45980500001)(43740500002)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdqT00wVkF0Z3U3TzhJRWorcnJHOVBwaGpDWGl0NlRsN3l2eGZXT0RibDhk?=
 =?utf-8?B?c2hZNUV3bFdoR3pFQ2U5aklOc3g5ZDVtZWFuenU1N0VuS0dMZ1FEUVpEOWZY?=
 =?utf-8?B?bUVuQXFwZ2Y0YjdtdG1IRnpvaW4rWlBRQjNMajdLK0VJMDZOVkp5aWFYeVJW?=
 =?utf-8?B?dDh2UXF6VnpBNzlHUzBlcXNmdTBieE1KL08vVlo1QjNDR012S1RVcVp5SnlM?=
 =?utf-8?B?ejROdXBYaTdsWTl6QUsyblFOcHlldld5Q09aMm1zV3BtMndyUUxoOHhnYi90?=
 =?utf-8?B?WDBtSndlMy9XNjhuUk1tRVo3YkNDbHhVNzBiWWtpdHdQeFlqWVhiSU04T2xU?=
 =?utf-8?B?ZnJoMlVtaFFVTG9Oek1zNERzMVFWL01ibVh0cE0rTnFRNFY0RUlPOVpPRi9n?=
 =?utf-8?B?dmxSQ0Q0NnJLQXAxeTNvMXc1VVNvRldSWVdXVkpPNkU0SFJDSklxUGZmeU9S?=
 =?utf-8?B?b2prYUtOeEhPRUJCaTRkcGFKcHl4Zy9sV1BwaExtT1hrVHpKTDBVd3o1ZG1C?=
 =?utf-8?B?bTA1MzE1Nk9YZGJsWEFQZ3UrbVpoRmJKd0dpcVMzMWJJS1FBMlVtTHprc3l2?=
 =?utf-8?B?cDFhNm14dmlzWU0yWmpEeThIaEY5UlhJZk9uQjJxWS9Fbjhacm5ZVExoVm1X?=
 =?utf-8?B?MzFHVGhJOGhrUTNUbXJrR3ZLL0VYYVBiU0kzclN4VWtNQVp4anpJakQ5K3RZ?=
 =?utf-8?B?TGtVdGFEOEdndlMrN2RSWS9DeFlUbVF4RWRSOFdpZzFScHlMZ3pWTzBTalhw?=
 =?utf-8?B?S3pMTFlvUHZiVlQreGk3ZVlxZ0R2MUpvc0ZydWJ6Y1Q0MWZQcjVFWTVBWlp1?=
 =?utf-8?B?TXNMOEdQNjN2RS9XNXloNnpiakI4ejFCeXRqMCt5VWhzc1hSRHYzZHJveXRQ?=
 =?utf-8?B?YTRoRzVMdXBUai9zTFZ1aTJ1bWtEN1JrSjVuWHR5ckpzSGVYK2c3aWFSdmkv?=
 =?utf-8?B?YUZyT0hxa3owdHhWZ1ZVSS9KbnpQOWRQMUhsb0k1T2tlS0NRSlpUQXBPdG9K?=
 =?utf-8?B?Ni95Nkprc0Zwa1FHR0liY2Q3a2cwRnkvenVVTWljeUZoU0RFREtTN0ZrUHIy?=
 =?utf-8?B?Zmc2MTNoczlkOWNsd0IwVXhQeThoOEFyd0dVYnlwNFBFTkNQYm5ieklCVDM0?=
 =?utf-8?B?THYxQVRXWXFtTHBEWTRGSGpETjZCeVlSaTlhUmN5RmZML2JjZmVmRmZwOXFx?=
 =?utf-8?B?bUowdTdzTDdjY0JocSs2WjBvVzVueFBxT0k0QUJZSmtBYlFEaitSQ1ZrZDNr?=
 =?utf-8?B?amE0VXVTSjZqNXgvYWtyaUpjWnowZlh0Yldic0txeUVqbzhrWlNNOWs3a3Ex?=
 =?utf-8?B?b2cwQjZ5T0N6UUlSNFN0VC9hRVk5Y1hBT203Sk85WHBEQmdPZEhqTkJ0TkNX?=
 =?utf-8?B?bmMrNXBQQWg1aGFiSkNTWmErU3JvTm01dmYrSDhBYjl2c3ZXNUduQWdFL3g3?=
 =?utf-8?B?ZlBPUWlDWFBjN2l5aUFvTC9xRDdxdXJJWE1sNjF0eFFRR1dNMllacW1seHFj?=
 =?utf-8?B?R1M2S1dPb1NGUFgrT09aMll1S2NZdTB2QTdLRjAvQ3NhUG1oSGxtaFJyU2dz?=
 =?utf-8?B?Q0cwUnRUWUlkV2pNRnFUeER1VkkxeXZIT3hwTUNPV0RBVjdYaUsyc3FUMzFH?=
 =?utf-8?B?WFpQbWI0aDNmR212cnBGSmhQUENIWG9FQ0xwTkx4UEUvQzJQeWNwdVprKzAz?=
 =?utf-8?B?RTkxZWJvREFLRkoyYlF6S0pvN3lRVDB5TGhBck92aXNQZ0tOUUlLVjFES1hw?=
 =?utf-8?B?YzJGWlpTYnhWR256TGpmOVdiVTZITDhMVTBla2FkUFFWUXc3MjA4VVpHUS9l?=
 =?utf-8?B?aDErU3FVZFQ3bWtjR3VuZ3Y2eWpKYXZpM1p1bUlNZktway9JdUN5dWFsQU94?=
 =?utf-8?B?bVhaT24vQnJucUNXY2ZuR2Z5b3F4Y3UzSHNOOXJvMUl6ejJRbElGS0lpcXV4?=
 =?utf-8?B?REhoT0R3WTVBSzNsaTIrRGNUbE8wNVBTYXdxV3dtQzNadkV2cWsyQ0VOWGh4?=
 =?utf-8?B?cndqeWZHbmxHaVZwVUs1aGJ5dFRSSEJDS0dPVWRXV2I0cm1OeWlTR0FZaDF0?=
 =?utf-8?B?UnpIY0tmQXM3cHc1TkNiZWpacldIVDNYalMyVDk5OWcwZjBpcGJMM3cyUElO?=
 =?utf-8?B?eWtVVFcwUy8vUzh0VzEzTitNa3c4Z05Zb2c0ditZMndVNHY5UzIzTEwxY2VK?=
 =?utf-8?B?aFF6bTVXdkRXM0tEZXFNdmFyU2hLZ2tXRWZ0Zm1vYXZIZDNwWWN4Wnh2YWEx?=
 =?utf-8?Q?pjwqU6GKgL247fW+gKbWIotDSAa3cKBqyzkUhym4Cc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a42b162-c172-485f-b76d-08d9be75fcb7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 20:20:21.1414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3na21anTDIfi5OmQZqYYY791Grr0UYdP+jd078Hk39k/fkz6ODnWUKKqma6SoQPUiH2Ihn1Wgn+R5AKhm1RRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-13 3:16 p.m., Rodrigo Siqueira Jordao wrote:
> 
> 
> On 2021-12-10 1:20 p.m., Yann Dirson wrote:
>> This is Alex' description from the "gpu block diagram" thread, edited to
>> fit as ReST.
> 
> Maybe you can improve this commit message by describing what you are 
> documenting and also adding a link to the original discussion. Perhaps 
> you can use this link:
> 
> https://www.spinics.net/lists/amd-gfx/msg71383.html
> 
> 
>> Originally-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Yann Dirson <ydirson@free.fr>
>> Acked-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>   Documentation/gpu/amdgpu/driver-core.rst | 81 ++++++++++++++++++++++++
>>   1 file changed, 81 insertions(+)
>>
>> diff --git a/Documentation/gpu/amdgpu/driver-core.rst 
>> b/Documentation/gpu/amdgpu/driver-core.rst
>> index 97f9a9b68924..b870a63c64dd 100644
>> --- a/Documentation/gpu/amdgpu/driver-core.rst
>> +++ b/Documentation/gpu/amdgpu/driver-core.rst
>> @@ -2,6 +2,87 @@
>>    Core Driver Infrastructure
>>   ============================
>> +GPU hardware structure
>> +======================
> 
> How about using the camel case in the titles? I mean "GPU Hardware 
> Structure".
> 
>> +
>> +Each ASIC is a collection of hardware blocks.  We refer to them as
>> +"IPs" (Intellectual Property blocks).  Each IP encapsulates certain
>> +functionality. IPs are versioned and can also be mixed and matched.
>> +E.g., you might have two different ASICs that both have SDMA 5.x IPs.
> 
> How about using "System DMA (SDMA) 5.x" instead of only saying SDMA?
> 
> Anyway, in general lgtm.
> 
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> 
> Thanks
> 
>> +The driver is arranged by IPs.  There are driver components to handle
>> +the initialization and operation of each IP.  There are also a bunch
>> +of smaller IPs that don't really need much if any driver interaction.
>> +Those end up getting lumped into the common stuff in the soc files.
>> +The soc files (e.g., vi.c, soc15.c nv.c) contain code for aspects of
>> +the SoC itself rather than specific IPs.  E.g., things like GPU resets
>> +and register access functions are SoC dependent.
>> +
>> +An APU contains more than just CPU and GPU, it also contains all of
>> +the platform stuff (audio, usb, gpio, etc.).  Also, a lot of
>> +components are shared between the CPU, platform, and the GPU (e.g.,
>> +SMU, PSP, etc.).  Specific components (CPU, GPU, etc.) usually have
>> +their interface to interact with those common components.  For things
>> +like S0i3 there is a ton of coordination required across all the
>> +components, but that is probably a bit beyond the scope of this
>> +section.
>> +
>> +With respect to the GPU, we have the following major IPs:
>> +
>> +GMC (Graphics Memory Controller)
>> +    This was a dedicated IP on older pre-vega chips, but has since
>> +    become somewhat decentralized on vega and newer chips.  They now
>> +    have dedicated memory hubs for specific IPs or groups of IPs.  We
>> +    still treat it as a single component in the driver however since
>> +    the programming model is still pretty similar.  This is how the
>> +    different IPs on the GPU get the memory (VRAM or system memory).
>> +    It also provides the support for per process GPU virtual address
>> +    spaces.
>> +
>> +IH (Interrupt Handler)
>> +    This is the interrupt controller on the GPU.  All of the IPs feed
>> +    their interrupts into this IP and it aggregates them into a set of
>> +    ring buffers that the driver can parse to handle interrupts from
>> +    different IPs.
>> +
>> +PSP (Platform Security Processor)
>> +    This handles security policy for the SoC and executes trusted
>> +    applications, and validates and loads firmwares for other blocks.
>> +
>> +SMU (System Management Unit)
>> +    This is the power management microcontroller.  It manages the entire
>> +    SoC.  The driver interacts with it to control power management
>> +    features like clocks, voltages, power rails, etc.
>> +
>> +DCN (Display Controller Next)
>> +    This is the display controller.  It handles the display hardware.

I forgot to ask you to add a link to the new DCN documentation here.

Thanks

>> +
>> +SDMA (System DMA)
>> +    This is a multi-purpose DMA engine.  The kernel driver uses it for
>> +    various things including paging and GPU page table updates.  It's 
>> also
>> +    exposed to userspace for use by user mode drivers (OpenGL, Vulkan,
>> +    etc.)
>> +
>> +GC (Graphics and Compute)
>> +    This is the graphics and compute engine, i.e., the block that
>> +    encompasses the 3D pipeline and and shader blocks.  This is by 
>> far the
>> +    largest block on the GPU.  The 3D pipeline has tons of 
>> sub-blocks.  In
>> +    addition to that, it also contains the CP microcontrollers (ME, PFP,
>> +    CE, MEC) and the RLC microcontroller.  It's exposed to userspace for
>> +    user mode drivers (OpenGL, Vulkan, OpenCL, etc.)
>> +
>> +VCN (Video Core Next)
>> +    This is the multi-media engine.  It handles video and image 
>> encode and
>> +    decode.  It's exposed to userspace for user mode drivers (VA-API,
>> +    OpenMAX, etc.)
>> +
>> +Driver structure
>> +================
>> +
>> +In general, the driver has a list of all of the IPs on a particular
>> +SoC and for things like init/fini/suspend/resume, more or less just
>> +walks the list and handles each IP.
>> +
>> +
>>   .. _amdgpu_memory_domains:
>>   Memory Domains
>>
> 

