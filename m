Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECFAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 15:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B72810E73A;
	Fri, 10 Dec 2021 15:13:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5A210E72D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doDdKIjlJ1Rw4UJP/rV++Jj7anCC7mdbhdGmSWIt1Gv/l729Rd9PcZnvY6Pc6VzyRrIqXWud+tCbxupJ5obvLaSfXEDNwiSxik8jhsyiNshkVRMNZDuUlrxxcFXYx5v0NCaDF4XSH5S6Xlv2kjy2O67/TBAbLE/FFl3aXUt3D5NI+9rGvhL3L8cLN3PHgV2AalYsCHY+8UQJzYfQjKn41VV3ERjcVsWz1gWb1l06uZjPc/0TVHjrr0suWZqEBC74YLpH3b3gTPVS+1s7tra340C++wQ4PhLd1ZIqsdD6mfAGlOkqrmBZ8KNoydb1d8nINNMdZxA+zSkVBD7Gh5svzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaaAahjzAVE7iMSw63/hPzy3j8DnB3H2lWoV0pqPOFs=;
 b=YHmU5hIWN6adnTjr+tMVYc7IlZ235x5qYIuGFiiPKwDrIQ8VoQ54CqCDuVxnbdm1LVcwrRxBNppBUwrWrN5qO2T/GC9AURbCF5vla8GENETTySQBOYY5l8/Vzn/h+SIRd8AULFOvJfWD1x/K2wC0CpBOCxe6uIlLyxxSE83Q39dFA9EsMGORXWoqI0+phnXpaFoMu0CV9BWibG3r2Zb10jK7tZVzSr3sp+Caz6Y1AtHZKbT5jEDgcG0xQ0CwRIC5VP+MPGGO4m6MQZZdoszAclCxH2hVz0QvZZHdtS+ast8mIwFngPAWChjILOYC9ge70g2FIlMODWdov22XU8T0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaaAahjzAVE7iMSw63/hPzy3j8DnB3H2lWoV0pqPOFs=;
 b=eklAt4IlEcGx3O6OmfLjzocpWC3Bp5YWjBv7s41SX4as+J52/Zrj4xL0iCca3WAa8pUI6iumqVWuqk42hItWRxzJHLhkTMvyN5LJIxOvdErgtpzBCx9y5D/ZMLMDZ0utSngqBJmdZMXM0+CrYe29aSmcRZ9bM5guFkGd/XEIu3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:13:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%6]) with mapi id 15.20.4755.021; Fri, 10 Dec 2021
 15:13:18 +0000
Message-ID: <c8784af4-4036-a60a-350d-d1c60bf14ce7@amd.com>
Date: Fri, 10 Dec 2021 10:13:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/3] Documentation/gpu: include description of some of the
 GC microcontrollers
Content-Language: en-US
To: Yann Dirson <ydirson@free.fr>, amd-gfx@lists.freedesktop.org
References: <20211209234717.8897-1-ydirson@free.fr>
 <20211209234717.8897-4-ydirson@free.fr>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211209234717.8897-4-ydirson@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.107) by
 YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 15:13:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 077550d5-d49c-4cb6-eb99-08d9bbef9814
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54107847A4C5BDF25CA728568C719@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQX3VaABJvZ/6MFI5FoIBZw1thr19yU7nToyoI+pGCw+wGs618QwCBVNNTUOaGaYu0gd3XESMbHNW+fxmJg8KR5p3uWD3efe0P6uf9iBl4HMRkT/UrspCEjuyFsmSoDOyPvRpROl4Q1KXCKwPKzCoLXSLg4F0MYnefl4crOV91hA9VCbzspYCzcZX6ei+cQGJezQ6J+BmmS0LxA+HfXsmdzPCswBRFfP84FyoHitfRRXDDl8yiyH3htj5W26KuwbEG6pHjhMo3p4ku1R1oC14rsmn4elbTB3vMmSjubppDtvSGpGpWunc1lKuAwGNiXVs6YAqLfBTqtzmcUFn+382pZzDg8ZF42MHAwrVwoBox00DEBmqTM9Exa1LVhTJm50SKf2rYpMjPb7nh28dib+Wi/awcgbq4KnivfohE84yxBOVTzvsESPO9LpkPIMe70GJC8nKhN5gq6xOLei+qeUtWkBG7ZNe14V9rVJRLVmuoLApvXWpDiN7R2y9RTPyIGMUe3chuRrlqIHZrBxJcCGyCy7geVpRlO5i3N48NBTaCOIooGfMyTNQ8s+nvJuOCjpPL9CoZCbI+Hj4S8QjqDg2n1DO/LLRfd4ow2Ic1Imbrl8rO2sRgGEAzWUjY7RDbw4hK+M+BbaE2+qljoTEGH/BxXBAryXy+mZQvIvjKO8A1tHjvAPQZEaN3BcYgLLk/K28vGxJFI2ObFMMYCVAmNna1Gh+IDDfZsyxP/60DbF0IEIOxwDN6OizldeAD98m04qaGFELX6jH5OTGTdVb9htYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(5660300002)(31696002)(66556008)(36756003)(6486002)(66476007)(2616005)(4326008)(8676002)(8936002)(86362001)(66946007)(6666004)(186003)(83380400001)(53546011)(54906003)(2906002)(31686004)(956004)(26005)(44832011)(16576012)(508600001)(38100700002)(43740500002)(45980500001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjBXRkJiL3UwS0NTSi9jUUdFOTQvdEw5U0dUemg2SjFRQ1B2UHZGWmFaOEpS?=
 =?utf-8?B?VUNTZzVBUnFWUFZkSHk5eFRjdnkzQm5SRithNzRZN0x1MkYvWVd1SHp4V1Bs?=
 =?utf-8?B?RlRHL2d2MmF5VHpQVkxTZVU4cVAxTjZKQ0h3NWtydXJMMGY4RHdDK0pQZmV6?=
 =?utf-8?B?MS80WDFuU3Z1VmpnaVRZRkRmR25JdXNtSFhPWEwyYTFXMlBwUDNiRFJDUjBw?=
 =?utf-8?B?MXZNWUZRR1dOVXUrK3Bwem40dHg3NVZWaGVQWWhlQWZPSENNMWFQYzdqOHFM?=
 =?utf-8?B?SFdzZzJST0NwOGR4TzgvWEhFeldEcnlBY1oweHhMcTBQQnptdUxOK0l5enBB?=
 =?utf-8?B?SllJN2kvOEVyalhhTzN1b2txNTcvUURUT0F4UjU3UUlxdzNDY0hlZThORlhW?=
 =?utf-8?B?OWF1TjI4a3ovOWxMUkxXdFJqNE0xc1Q1MnJoR2lHQk1ETEJrTHFuemZNdE9P?=
 =?utf-8?B?c0hKYlBXRFgwMU1FOXZtQTZ5V0g5Q0pSSDMzb0tBcWtZa1NwNlRnWDhNeUg4?=
 =?utf-8?B?azV3QUxvWm1UR3pZeXFZZjFscnJ4c0c3VS9tMjgraGp4YUhwUUQyeEtXQWlT?=
 =?utf-8?B?Q2FVYXROVGtjWllhS2gxbS9SS0FjM0toU2RiWnNTblBvSUtCTWE0U0FVSHJm?=
 =?utf-8?B?R3JFRkw1UE1BakZQS0RUVlRJejN6bk9rN0tTb25LQVBWamxRaHNYK0QxVkxk?=
 =?utf-8?B?UDNaTjFJV3NFOUk5OUJnSmRPMXJCQWZjbjhIY0FWUDUyeWJJWm1xaUJzR2FY?=
 =?utf-8?B?U3NTd1FuMUJiSXExZjBMSStuWm1CVWY5QmtEWnUyUHZpMXJoVjNsU2h6K3l3?=
 =?utf-8?B?YURTN2lDZUpjZ3hSU0Z0RDQvR0JYZmthaFlEaURjaVdvaHQrODJWdDlWOGlv?=
 =?utf-8?B?UW00TTVlL3Z1MkNQQzN3Q3NqR1BIUUdHK0ZRRyt3YUcySlZxeEtteEdjTldj?=
 =?utf-8?B?UnZmUEYrejN0bkdzNGl3bFhBYWlzUllSb2VuSW9pRU5VTHFuelVMVklNcTR2?=
 =?utf-8?B?ckZuVjUrMHVuUmJBK2VKc0NNKzZWODBZMGZraG5rVXNIZW1DMW5BTmUzbjZB?=
 =?utf-8?B?ZDd6WE1HNzNFa0FLVDJOZ1FiSnh2c2VYUko2by9vWGZKT0MyMTUrT1NLMTlZ?=
 =?utf-8?B?QWVqazhWY29GNDM3T0tuV3RTUzMvU2JZZEJvNHlWMWoxM1FQWkV1MzZ1aEth?=
 =?utf-8?B?aDM4ZVErMldJU2xIcWZySXp6VzN5eitXVDA5YUxVdGtINDczTVhQOUhMY3Bp?=
 =?utf-8?B?SE5IWDFJcXdnTnM5N3Q1cEVuVitkcklPVDh2YUlCVHZDZ2Z5U2ljR2NiaUha?=
 =?utf-8?B?SWhBTmZMSHZ4aFdzK3k2U2lZUTJyWGticTNicUhXcWp3UUdBK0VTMU85Mzdl?=
 =?utf-8?B?OGZNRlVVREc1elphWm1TRno5eEVUM1d3RXVMc0tWNXhIcVZ3Z2RwUmFXaytE?=
 =?utf-8?B?MkhDc3drV0tmRDBTV1hRcWJ0UDNqOVZVRHhQWmhkMS9SVHhVR1Y4ZEs5N296?=
 =?utf-8?B?bFE0QnYvSnk4Mk8vUEtZa0ovK3pjdThOUGlQM01NY0FyclpHL25SdFBmQjRN?=
 =?utf-8?B?cE5PQlUwOVRORTFiNjBoN3hQeVAyVVJHdUFtYmtUU29vYXhBWGw1YXZXOHd2?=
 =?utf-8?B?cWRjSERId1J3UGVLeEdxRjcyTE5PN2VvSWVkcFZHTTByaWl1YTBvQS9VSjM1?=
 =?utf-8?B?KzNFWFdESG5UQ3piRUF0UTlTNldYZHB5R08zM01vUXZpeHBxcFhRS0NZRWRL?=
 =?utf-8?B?eGpJLyt2aHRwTTNCdkZzTG1sL09ZTXlXejA1NjZ5dFlHTUxKaTlUS2lnd2JC?=
 =?utf-8?B?RWtibDRNR0xUcHg1dytWNGw4Mkx2Sk5XTG90cURCcHVYVGRCdjZlb2pwdHkx?=
 =?utf-8?B?UlVtb0VYei8wWFdoRjZHTEZHdUE3a2c3VHUzeHdrOUxvYWd0cVFnMFZFOWRG?=
 =?utf-8?B?OUlqaE83T3A4RGhOeFNFS0xrWW9iK3g5NjJTVkVMZTc1MDVyakgzbXpQT1Zw?=
 =?utf-8?B?M3V4SXVSd3k4UEdKQUZTQi9wK1l1VEJsaTlxM2ZoUnZ6d3hZM2FHRnJUREEr?=
 =?utf-8?B?SE52ZWZKc2lYOTlxMmtuRFczd2JPdnBMUnlFcTBHQzhkT29KMjRkVndRUzlZ?=
 =?utf-8?B?UlAyNTZTdmVwNU84OVh4VTlMeWJWazZrUW4zY2hBQ29GTmZVM1owUlM3Ni9Q?=
 =?utf-8?Q?vlut7nah5yr1bYf4f+jre0Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077550d5-d49c-4cb6-eb99-08d9bbef9814
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:13:17.9541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7yFV3VkReAzjvfKh2Vt4fUQFwccK47Qwxnajo/6f/UufoUXT4bgIYywNmmJBMxYoC5YiEiKaBzSv/4wIBRLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-09 18:47, Yann Dirson wrote:
> This is Alex' description from the "Looking for clarifications around gfx/kcq/kiq"
> thread, edited to fit as ReST.
> 
> Originally-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>  Documentation/gpu/amdgpu/driver-core.rst | 35 ++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> index 909b13fad6a8..453566c280c5 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -75,6 +75,28 @@ VCN (Video Core Next)
>      decode.  It's exposed to userspace for user mode drivers (VA-API,
>      OpenMAX, etc.)
>  
> +Graphics and Compute microcontrollers
> +-------------------------------------
> +
> +CP (Command Processor)
> +    The name for the hardware block that encompasses the front end of the
> +    GFX/Compute pipeline.  Consists mainly of a bunch of microcontrollers
> +    (PFP, ME, CE, MEC).  The firmware that runs on these microcontrollers
> +    provides the driver interface to interact with the GFX/Compute engine.
> +
> +    MEC (MicroEngine Compute)
> +        The is the microcontroller that controls the compute queues on the

This should probably say "This is..." or "The MEC is..."

Again, really nice to see this. I can't vouch for the correctness of this
as this is outside my domain but it looks well enough to me.

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> +        GFX/compute engine.
> +
> +    MES (MicroEngine Scheduler)
> +        This is a new engine for managing queues.  This is currently unused.
> +
> +RLC (RunList Controller)
> +    This is another microcontroller in the GFX/Compute engine.  It handles
> +    power management related functionality within the GFX/Compute engine.
> +    The name is a vestige of old hardware where it was originally added
> +    and doesn't really have much relation to what the engine does now.
> +
>  Driver structure
>  ================
>  
> @@ -82,6 +104,19 @@ In general, the driver has a list of all of the IPs on a particular
>  SoC and for things like init/fini/suspend/resume, more or less just
>  walks the list and handles each IP.
>  
> +Some useful constructs:
> +
> +KIQ (Kernel Interface Queue)
> +    This is a control queue used by the kernel driver to manage other gfx
> +    and compute queues on the GFX/compute engine.  You can use it to
> +    map/unmap additional queues, etc.
> +
> +IB (Indirect Buffer)
> +    A command buffer for a particular engine.  Rather than writing
> +    commands directly to the queue, you can write the commands into a
> +    piece of memory and then put a pointer to the memory into the queue.
> +    The hardware will then follow the pointer and execute the commands in
> +    the memory, then returning to the rest of the commands in the ring.
>  
>  .. _amdgpu_memory_domains:
>  
> 

