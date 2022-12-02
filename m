Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FF6C4321E
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Dec 2022 16:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB4910E708;
	Fri,  2 Dec 2022 16:43:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33DD10E708
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Dec 2022 16:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1ig/jntbKoLwpwJDak8S7r/szMTIbPyH0N2A/hYx4TlyJvxv/Eczskk3k8h3gPCulwjBGcKNfsCwMLiVIFfYpXwXQOvJpMD71G9TjwvP/vy+Jik3jzowR7Vjp0i+zdNmVdL6ORAQICbwid+7ljg1izotROFdp5VSt+UKABHnG3VHPmm/zQ8DSz0YSKAlNUDF7zAC31c5RX64srk+vs3Wj25nJhFURwV4Baf8hYq8xhds+Dvjbio66qzEBpBut0/Yh+bo2/DV0kSCqdJyy9E7Gw4ADKdVTXtox1LQBg1pKtINX7brSVzmdiXd2F+SDURvpbJz/qby6+SJLuoWwsQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJybx185hhoM1+3koXASAzyDLxDKitLKdImZGMePzNA=;
 b=W5yRHHZXBYRaw6IJ0DdebFLy/mhFnSLSTDqUaMKRAq232sExh3xt81LDV7N6FGY/1ZrFx78KPvwiE54AhPf30x2FQni++ThQPSJxN4zrYFJIQBbVpjkrRjoGastuCf23YCqbQ53qa1LzNVjfgOzUERqgPGIeo+7iqrHoD9yB2RzJAz0e8Cv6EMo9uPoGwnWoswVkqUAalbvsjTqv8DotA/4TFB7FD1FOPkatzlypUJ+jf3TjHyPyO33Sk3xxaw8qqQog8IsrWdlFuRG8gzswBLqOkmTiVqoQHh3CsFF0z/MkM88aulfcq1dPJpjVVU9Ala/ep6LJyXkYkQPB77yDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJybx185hhoM1+3koXASAzyDLxDKitLKdImZGMePzNA=;
 b=2+lg0LE6Uw32v9kEZLXB8LyqJ7qF279UmoE2ywfriT8+aMGW1X8TCqQIjN5yMIqJhva7NsYSoJgOVbEANngMhM9aEpv5wWwCFSQ+h1g04LYJEQBwCWmbJfO+yzHJ5/XV4ICV4k5Mcp2raRYbZ8HqoFjsSpopUX8oLIlio/roa3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 16:43:12 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::842b:9b87:df24:f848]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::842b:9b87:df24:f848%5]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 16:43:12 +0000
Message-ID: <84dac73b-5b6b-6f7b-9dba-c7352caef5bb@amd.com>
Date: Fri, 2 Dec 2022 11:43:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: add GART, GPUVM, and GTT to glossary
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221201214153.8453-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20221201214153.8453-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::29) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 47912d88-5cef-44dd-4ce6-08dad4844d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoTwwLUNKqSZl10OpbKsLNYX0Umk5jRu4GDm7SYncCSpfbVO223yw7W4r5gCC4+g6OrZ+zRyWW1XNieUZgGPVPUl8KZn/C/CgqHrtc+9Rv6z6OCtgXEISVrEHwmggobBYALCChW7Gw+p1rAgox36+oatlaO3Ox2XvPysqKjmFbqmIj5qsKLYues0oPgzMDnsi2+9b0kLLNtBQZLEIc3IrDt6ISwLFw0cvKuPoHcPsPtwZEwaB4T0wzc6CPlzeF0OqoeEfZXAbbvkfdHFvQEinnMFbxgWhSQ8vBS5XKEoxuSKQqFc5d1zuUxQh54ShIwtkqrG2ILLvkK1JOQuoIl7WeS/4IQd1BvzGqat5GXa5F/bF4PCLYh9uTz36aq0scYn+cxJN56lFJjYSfjhEUEMfTlzXiiM0GsqDYvPoZU39gQwH4il9DaOB6nQudGxyaxYCV4vIHyhrfYxWX+Ngp/sh2Jr8xvnQijNwGXcL/aLgKaATDYuUxc12iD9xcgwMhwE4LSl9rEWkObI7MFz+EzoCwT5yOgt096jBM+bjaPdPdFq9iQCp0wto4hiweoqAj0BUxGk6i1CrCCDUdqGPX1UsZqipRhksulsX0Arb77u8eL/G5PdWT3dErhcVJSbdX7aQQ51SILnOsUw8goNjniEDe7nVqbXOhXpIYwvV2XxAormp5MPAC0gtKMWxedIgGOL+ddagmTCBnr9HOCz5EYIR2YCFpA/rarU/k9KA7HET5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(26005)(186003)(6506007)(53546011)(66476007)(8676002)(66946007)(66556008)(478600001)(6486002)(4326008)(2616005)(41300700001)(5660300002)(8936002)(83380400001)(2906002)(38100700002)(36756003)(316002)(31696002)(86362001)(31686004)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFYN3MvbzRNaVlNQkhQV2c1bU1xZ0g0UURYRjdSSVR2azllQ3RMekxOSUp6?=
 =?utf-8?B?YWY4WGt4a0VDZXh5WXVsZzdBZVlzdDlkQndxUG9qVEh1enBLdjExWXNXMFB1?=
 =?utf-8?B?cHlZSlNHMUdxdk5kNlJRWXF2QVdZdmtTOCtnWCtiMnlrR0ZCMnZYSUVYSkdP?=
 =?utf-8?B?cW1EZWdHWTZsRDk4bVV4K3M1NysveUdJSFU0YUpSS0E0MnJBU04yY1ZsNnRk?=
 =?utf-8?B?OHU0VENHNFlpRmVwZ2kraWdGTjdHVTk2QlZ4V0J6SnJtbnRJT0hwYStDdEZG?=
 =?utf-8?B?SXBXZ1d0YWRENS8wa1FSMG1xM2JGSGtOVDdIQmo3RDdDWmFreG5Ya2pkNXo4?=
 =?utf-8?B?UEFNUnQ0bVVRODVWcGFPYlRZa2lpM21nQU96QUJ5QnBLaVhZZTh2Y015N09P?=
 =?utf-8?B?Rkl6RmJKeTZKa25xK0Y0RmVycS8xZEFmY1ZCb1pTVG5zdFljeDRxVUZjVTky?=
 =?utf-8?B?bktBOVZmUWJSMzFUYldJMUxqWm8zSHZqM0Ywa2NGdTF3ZDlxOTFFVXJSWkFX?=
 =?utf-8?B?eUlLdzFtVUFrNmo2V0pKeVJ6elNhYVM1TDQ2RmVkNU8wZnVqQzQ4QlNQN1Zi?=
 =?utf-8?B?UEpRd2xFZGFVdDB3MGpHMzNuTlRMTU53eUcwaDVCYXArL05RdG40U3lrbU5j?=
 =?utf-8?B?M0UvOHgyTXZnYVZ1aTRPcm1GTlM0amljK0RuUWFqdHQxVTJuZnJBckpKQWZp?=
 =?utf-8?B?QjBoR05zRlZqN2tLL09tSzhZNVZaQS9wNHNNSXk3L2dJa1ZPR1FSRFZqZDJq?=
 =?utf-8?B?cGkyZWx1WDY3ZFVrdTB1cGdqR0xYRlUrM1J2blZpZ2NFTFZWc1B3UVdTNCtU?=
 =?utf-8?B?bU9nQnB6MWdaSHp1TUNnOFVPc3kyc01TalE3bXc4b1huZmVscGlHTlArclJC?=
 =?utf-8?B?eE5nU0ZDQ2N3aFM5TGlNcXVhbE1vVlFuQysvUkhxS1RXalYxdk1hVEtOYktt?=
 =?utf-8?B?bjh0S0IzY0hhd0tscWhad2dUb0t5T3M3eklRRi9wb1F1cjgyaHp3N0tLZmFn?=
 =?utf-8?B?RXZHcURLZFZuZ2djWUhKeVF5dXEwVDlPKzlaWTdjeXVndzdUeHhaNXpWV2Fw?=
 =?utf-8?B?WHBUYmZqTi9ZT1BnTzN0NWIxVEV4ZzYvU2lBNE9sKzhHcEFBakxuQVArek9S?=
 =?utf-8?B?SjZKWlQxU2VBYjM0YzBvdFNnak5GTkVnNU9XZ1NDNFN1Nml4RnV2RW1YWUth?=
 =?utf-8?B?VU1jZGxFWmlQNzJnWEJLTVpyVEpaYXVzdzRoZXBJbm8zQU4xY3ZoL1VwRVhp?=
 =?utf-8?B?ZXAzVVp4V1NWdDRoYVlSTU1aR1U1U1hFbnUyZnpPNklYejAvZDdnak1ZME9Y?=
 =?utf-8?B?RlhZWk5sNHM2QXNRQU1LS3FmbmlvT2xpM1RTUUlBVGhQckdZUXBadzgwVG90?=
 =?utf-8?B?QnlLd1JlNEZpalhpQ21EeVRmVlJ1KzBtWGlWSk4xekwrZWpKaDdJUDA5L0V5?=
 =?utf-8?B?VHM1MXhRZVBGdmFVNDk0TXFsZ0ZJOGNlSUpHMVgyRTZ1c2M1QkQyL0I4NWFh?=
 =?utf-8?B?dFQvclZ5cXg2bjBqQnBqbG5PbU1XV1JTWHpnam1kUkV4TW5lVElGNjVoS3Bp?=
 =?utf-8?B?L0RCWG50SkhxU1hwZml6dGpHRk5hQ0dFY1FjaFYyWnYrZDl3MWkyUlA5Y1FD?=
 =?utf-8?B?WmM4RmNweEQ2SEFJb09wVzgxMW5qY2poYlp4NEJBNlI4TzZZTlpoWU5oSHBv?=
 =?utf-8?B?OXZ6NCtMb2M4UTBtTUFsTk8vWURFWG5WUGFHdkxiOHJvQ3lETE0vWEFGblpK?=
 =?utf-8?B?YUFtYy9lT1g2SEtvOHp3a3VBVExveHdDN25jNEtLRndrb1VBSzVaa1gwUnUz?=
 =?utf-8?B?UkN5S0RKNlVDTXNUdmZJR2k4U2k4eWpoWHZUaHVleVJCYmJqRGJlZXBMVzEz?=
 =?utf-8?B?ZVk4ZUpvK1N6SHVVSk52TFIxUVdTN0lJenB0YkZDcGdTVlBFb1dLUXVlaXJK?=
 =?utf-8?B?UWFObG9OSDh2ZVR0dERCZVJtTndLUnU1Z1RoVlorbFdlS2dXZXR0Y0xDR1Zx?=
 =?utf-8?B?UUlNSk5rRlBEVDgxTDNwNFd1VHJwVWtJRnZPR0dRTHQxK2hKREI0c2hYMDVC?=
 =?utf-8?B?bG54ZWxHQ2ZCRmx6OCtiN0tleEhud2JoRVZHc2lQNldpTFlxY2Z2RkpzeUdK?=
 =?utf-8?Q?uMX1oTd/15tv8wlnBEMXr03Tk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47912d88-5cef-44dd-4ce6-08dad4844d75
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 16:43:12.8213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npAnv31dqfEqe1So7ZYQxzmhdm859ZdmD/4LgCnInMbLMoL6i4H+SgVytX/7u8eKozG/YqVsUq6r6yl52/iHCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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
Cc: luben.tuikov@amd.com, Peter Maucher <bellosilicio@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Both patches are:

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 12/1/2022 4:41 PM, Alex Deucher wrote:
> Add definitions to clarify GPU virtual memory.
>
> v2: clarify the terms a bit more
>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> Suggested-by: Peter Maucher <bellosilicio@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   Documentation/gpu/amdgpu/amdgpu-glossary.rst | 23 ++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 326896e9800d..00a47ebb0b0f 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -30,12 +30,35 @@ we have a dedicated glossary for Display Core at
>       EOP
>         End Of Pipe/Pipeline
>   
> +    GART
> +      Graphics Address Remapping Table.  This is the name we use for the GPUVM
> +      page table used by the GPU kernel driver.  It remaps system resources
> +      (memory or MMIO space) into the GPU's address space so the GPU can access
> +      them.  The name GART harkens back to the days of AGP when the platform
> +      provided an MMU that the GPU could use to get a contiguous view of
> +      scattered pages for DMA.  The MMU has since moved on to the GPU, but the
> +      name stuck.
> +
>       GC
>         Graphics and Compute
>   
>       GMC
>         Graphic Memory Controller
>   
> +    GPUVM
> +      GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports multiple
> +      virtual address spaces that can be in flight at any given time.  These
> +      allow the GPU to remap VRAM and system resources into GPU virtual address
> +      spaces for use by the GPU kernel driver and applications using the GPU.
> +      These provide memory protection for different applications using the GPU.
> +
> +    GTT
> +      Graphics Translation Tables.  This is a memory pool managed through TTM
> +      which provides access to system resources (memory or MMIO space) for
> +      use by the GPU. These addresses can be mapped into the "GART" GPUVM page
> +      table for use by the kernel driver or into per process GPUVM page tables
> +      for application usage.
> +
>       IH
>         Interrupt Handler
>   
