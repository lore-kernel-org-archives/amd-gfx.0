Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3875BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 20:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E3A10E81C;
	Mon, 13 Dec 2021 20:16:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C0810E81C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 20:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT90chsV7FyXWo5drUUXxehWiKy8e3Uu0FvhCAG+UbBuR1KlhEFgNY8ozIW3gen9sLCAPZ1sKs+fKACFD91VteRR77Ophx6AyxhgTUb79h/C3ljfAg0ukKi4axW8EKzCIiY7DjZjRD4jk22PTrXt1cM3lyaGpObfn0dUE4nFfYdeCkU+Imd/bV0WiVK1i3eJKPTNNE0Qhc1JRpR1Iq5USpWExlvYeeT4IzaahOGYLqdwLoC1hQUlfGWPaGy/AtxlDhoDA+XEZ7MDkwrRsoylbxKwEzPRDEVR6/A0SwJNexOQTzi2ksGNyHyhq+HcG9dtXn6fvPU0JuyxHmPJm38KBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msoKE1khMD740RpZ6mcrAS+lUKrNIVcMMkAMlyx8UXk=;
 b=W8jzrjTGCKmVxn7waEEdKlDZNfhwW5q7yDORmKZM0tcno/jHHEq8TceQaJM6klOZtZp3zquV/B96tb9GQVfsWHpvxRmkjkFyH3gCcxqGq6QysYg9JT0EMdNGWD8jgE9ATOWHM8uP6KUN/JjN1VHBs/rDnZ91KgOd3a80bs8aShD8RheT6U6gJEFS0ZH8f831AJsBx7dIdoOVdL+FNo6uw57swotST7bKTIdN+ykh4f3wA1zsqtZWhWAAHFRwIrbLk0BtM9WOA98pkfRlChoSHkdsUiyxm3NmI6TU/L7h1yH0fqbminqkshybXQdiKa2pR3OstNBnt1guq0O1Bv+sRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msoKE1khMD740RpZ6mcrAS+lUKrNIVcMMkAMlyx8UXk=;
 b=2kqUYg5hvjeufUMLscJCVzvLjXIPr0xyLyvEeWAeXePqCDGIuviRyyhsNlbVQsnjpjYvsLUfPqbiTRu32TpnnJaL48tUYc9gyvxWhNBFW7YOjVvO21KnzoxgvwzN14iz0Yyivw2B7X6PFqAkqqZ1d9uRYTKQ4GEVuZXztS5sHzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3325.namprd12.prod.outlook.com (2603:10b6:208:ce::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 20:16:32 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 20:16:32 +0000
Subject: Re: [PATCH v2 2/3] Documentation/gpu: include description of AMDGPU
 hardware structure
To: Yann Dirson <ydirson@free.fr>, amd-gfx@lists.freedesktop.org
References: <20211210182030.3834-1-ydirson@free.fr>
 <20211210182030.3834-3-ydirson@free.fr>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <c5563e17-d978-58ee-8350-5b51593fb5bd@amd.com>
Date: Mon, 13 Dec 2021 15:16:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211210182030.3834-3-ydirson@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:610:5b::30) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 798a8e5e-fc21-46bd-db38-08d9be7573e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3325:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3325979C870E9C21FD86769A98749@MN2PR12MB3325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nifNjmPe38sPfl5CxXt69T4jbiyFQVWXkISZdUl5t/9Ws65Z0fOofY1wfRHfeRlmbBiEJSP0m1qgex2lr6gJ4VLoWfnbDynyiBs46cZRCb/CvUb7wMgqM+opTTtAuZ4ihxjIharmoBd9EEbssRNTWLZPxbwbIyfcRDh3GHZzHcy+AzRqTxJJNj5gGfrWKZ6YwaD3uP9mmowOwEfrwvYabrtx4vf8rg9oILOKWx9oyCF6X2qzFvl/QzcKkeHFYUV8l3awg6AkGj5PPTekuTwNpkcDYeMbOnhVQ2I85Vg3VRDgMlAApZZmiKdy0vKIgEPg/tlBpz1aeWDPLhzq2jF4dtvUGKNTOMGdsg/IPuUqmxB0eWui0EH/QvrLWeDsTbbqSDjtLsj7rAc92RKmO4EXYstLfkKvtbjZW8zgY+bj9ryo7Qdty83CBn5Q6JafvwPF2e0PEHAT/qh7/jDPd+FNKq3OLCIChQgZ9b8erB2zN12OSv2+wddfos7takeM8hduQEKorzyv2A6TYSRR9Z6n2l+mUDMWWvQevJ588NQMlvsPu7s2uDSTzNJ2IAdUc5WLJLwK9AdWGMBVJgofiwcWmEg+Q4SyudzBePPNLbFO1cRKXeyaHy/6tlTiI9vmGV0bQMewLDjDtyQznU3Axnk+uAPwDxZ3W6iCURcIwlHGOtV/UQ+OzIDN3N71o6R8Y+OLAKy7IDse4Lr5Rd/Umu5izJYgJlJyF1MhaHHlwBrEAAnJIWeRWsM8CINJra+5tF/O95A9nWrn23eWD96jb2r8jFh4ndU+5mOM6zsKLHAZXTBPmYN/+sgm59PLiufkvYs+yNZcMa0ZHhdVLKNJVMOVa3lannGVh+ZT1r3c+4BdzA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(8936002)(6512007)(6666004)(2616005)(83380400001)(2906002)(36756003)(66476007)(38100700002)(53546011)(316002)(66946007)(5660300002)(66556008)(54906003)(6486002)(6506007)(966005)(186003)(31696002)(31686004)(4326008)(4001150100001)(508600001)(15866825006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0wvY1pyT1VLYURqTmhjSWtPYmVGSkgyamd0Y0g0MGxZY3llcTBJQ3JDWG05?=
 =?utf-8?B?bHdxcG9oOXlZem5wOFArd0hwVTF3b2YvcCs5OVhXV21xbGExNndHSnloRlE0?=
 =?utf-8?B?elF6eVEwYmloYkdVekpUbi9pSG82NnhBTjlOY3ZLbm9HVUMrelZvYTlaREpO?=
 =?utf-8?B?YlZuR3dmeCszcDhjU3I4Z0kwTWVYOGlaTW1wako0cUJVeEZCTEIrNG1OeVk0?=
 =?utf-8?B?VmVucGtYejI4VmQySXYxK2o5NHNvUDlmUUxxaGpxZFBybFBGUGJNYzFSYjdM?=
 =?utf-8?B?TjdrVlpxNlVzT2lTYllSWGZEbm5kaXUzM05oMDZ2L1FvRzI3c05QNWNYNkF4?=
 =?utf-8?B?TXJTOFpPWENON1lvTTZnYVd4THY0bnBhRVJWUkxiTis2RDkzQVg3L2dEaDZw?=
 =?utf-8?B?cVVXV3BuaGI4VUo2ZzJPT21kQ2NMVXM0WDIrTUtNTEJSTUhOMVFRN1ppekdC?=
 =?utf-8?B?K0s1ZnY2YjFzUlcrY1V1TVlIQXlicjFldEczVkRLLytESEtBQzhncmdCdWdH?=
 =?utf-8?B?QU9aS3F4SlZObzAzMTZKblRVODAxdnRZUmtqNy92TE5KbzIxeWlHb2Fnb2oz?=
 =?utf-8?B?cmQyZjRNMkxISURFRlAwY3ZUMGp6eXpnR3FzQm1ZS3F5TW8wWXo5RmcxQ2Nn?=
 =?utf-8?B?a2JoOHRpQWVMSGtDWW1RY2dhU1B4MDZxcjE3dXkzdGllQWdjc2hSYzJQT1F2?=
 =?utf-8?B?dTlQZ2wxbyt5czBSTmJYUzFTRlBPNHQyZkxDWnBrd1R4anRMekhLRUE0SytZ?=
 =?utf-8?B?QTdvc2NUSHBVN3NlT1ZGRk85cjNJQ08yU3E0SE90ZWN3ck5kY09TWG1JTmor?=
 =?utf-8?B?SzJRZEJscnREWkNMK3M3Nmg4NTBnREZBOGJwcDA3MlFWMDdISEJqZWhDb3N3?=
 =?utf-8?B?SW9kTnpXZ3BoWG96eFpZcWUxTVJrUVhySlpKT2x6TnphNEtydFFNZmxLT1ZH?=
 =?utf-8?B?cXRVNEJIb1BYcXV2OWVrV1JRNVpsMC9TYSttTkhNazNHTFA0eGtzK0VyL2lm?=
 =?utf-8?B?aXgza0dwQm1UeWFVMFRPVTBVb01VREpGRjNrRHdoZTg3UnJxTkk0WHJvSCtS?=
 =?utf-8?B?N29VNWxRU1RLR0l1elVGc2oxbGtjYkNabEZJWHRTVXI0aDZhaVlLc1RYRTR3?=
 =?utf-8?B?aENXN3NmS1ByRkxNdW40NmxOeDlaNGhxeXFxckpUa25Bemg2dU01aVJNL0lL?=
 =?utf-8?B?OE9jTzQ5ZjhrL2UrY2RDV1VLNTdiMzJ3a1NRSk9SalZab2NtNkZONnVYMnBt?=
 =?utf-8?B?NEQraEVjS1hNQ2wrcitvNUFzQTdUTmpQQ0hEMXdIK05icFZHa3orby94eitM?=
 =?utf-8?B?TDRFeGVjbldJSTFXcXdsbzFLdjQ4QTJBdHR1dko0OEtEOHY4bHZYR2F1SjlO?=
 =?utf-8?B?eklvZW5LWjlac1BhM3FmcGpiWjNETlJNTVp2anVnT0NhcWtxNlVVcHN0UG1Z?=
 =?utf-8?B?WWRWL0lkTnZyMXkramwzbTJKZWlWam1PaTNmUEpOUG44VE9nZHl6OGRpQU94?=
 =?utf-8?B?OTAyS1k1R0w0Sk91R3dUWithMTJxWGpmYVlxVmJCQ2NOdW9sVFZnUENwUUlK?=
 =?utf-8?B?N1RFNFlkSGxHOHVKdHpxaG0weFJ0Tlp4dzhzWCswbGRaOHhMczBYeVpuYnNH?=
 =?utf-8?B?WW9HdFpaeGpJTlZDck5TYXJ6S3BQdVFsUVY0RENaNW1HZ3RDaks4OVNiZWx1?=
 =?utf-8?B?OGxoK1FZUVdUbXhBQXI3djBlL3prbjFwdCtLcVVYTFFSSWFwdTZJZVVMTThs?=
 =?utf-8?B?S216RW5mOTJlWEViS2lrSStibWFpRUtnd1FxUHVjYlh2dmxvWXFsUDJySGky?=
 =?utf-8?B?VnRSaWR0Z2UzZ1RhRk8xUVhXeVFjc3dicE43dFBEYXdsUG9qeG9mVVIzZlNj?=
 =?utf-8?B?Z25mR3h6VlEvYXhTalM3NlVnQjZlMjk5NWVMb2p5SnoyS0Nsbkc4M0NraDJ0?=
 =?utf-8?B?dDBEQ05aRnVzcG5ZUStoR2l3elNtUkRZSkVsWnJJRVdRdlpOUVM3b1MxZGJ1?=
 =?utf-8?B?bVZtY2NYNERXL3pmb1M3QmpsMWxwN0EzUzhwNzZyTmI3UW1vekZRNkt0RDU4?=
 =?utf-8?B?R3llQ1Y4cDFYV3JLUmQ4MHFyUHI1VFZmOWJSTEFNMlZ3dnphdjUzMTc5cGVX?=
 =?utf-8?B?K0VOeFhFMjdTYkdPSEk1L2RFTG9xZFlmRkdXOVFZUHR0K05GQXBvNU9JdE5j?=
 =?utf-8?B?OWJnQUp5V01MRHUvZDF4ZnEraTl3TzJvZFBTdVYxeTkraDVCOVdNRFpkdDVm?=
 =?utf-8?Q?ZKalHxbKQ8Nec7M+BGpjJJ48kziZ+G8FLn7RLFdt00=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798a8e5e-fc21-46bd-db38-08d9be7573e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 20:16:31.9467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efx4TURSAA3gUsX1xGOLmKHYVNwLijIxlvpoczbeL3DisUb7TVQQC34HPIvLvZB8PG++Pi6/Z5iicj0bjK7a5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3325
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



On 2021-12-10 1:20 p.m., Yann Dirson wrote:
> This is Alex' description from the "gpu block diagram" thread, edited to
> fit as ReST.

Maybe you can improve this commit message by describing what you are 
documenting and also adding a link to the original discussion. Perhaps 
you can use this link:

https://www.spinics.net/lists/amd-gfx/msg71383.html


> Originally-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   Documentation/gpu/amdgpu/driver-core.rst | 81 ++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> index 97f9a9b68924..b870a63c64dd 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -2,6 +2,87 @@
>    Core Driver Infrastructure
>   ============================
>   
> +GPU hardware structure
> +======================

How about using the camel case in the titles? I mean "GPU Hardware 
Structure".

> +
> +Each ASIC is a collection of hardware blocks.  We refer to them as
> +"IPs" (Intellectual Property blocks).  Each IP encapsulates certain
> +functionality. IPs are versioned and can also be mixed and matched.
> +E.g., you might have two different ASICs that both have SDMA 5.x IPs.

How about using "System DMA (SDMA) 5.x" instead of only saying SDMA?

Anyway, in general lgtm.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks

> +The driver is arranged by IPs.  There are driver components to handle
> +the initialization and operation of each IP.  There are also a bunch
> +of smaller IPs that don't really need much if any driver interaction.
> +Those end up getting lumped into the common stuff in the soc files.
> +The soc files (e.g., vi.c, soc15.c nv.c) contain code for aspects of
> +the SoC itself rather than specific IPs.  E.g., things like GPU resets
> +and register access functions are SoC dependent.
> +
> +An APU contains more than just CPU and GPU, it also contains all of
> +the platform stuff (audio, usb, gpio, etc.).  Also, a lot of
> +components are shared between the CPU, platform, and the GPU (e.g.,
> +SMU, PSP, etc.).  Specific components (CPU, GPU, etc.) usually have
> +their interface to interact with those common components.  For things
> +like S0i3 there is a ton of coordination required across all the
> +components, but that is probably a bit beyond the scope of this
> +section.
> +
> +With respect to the GPU, we have the following major IPs:
> +
> +GMC (Graphics Memory Controller)
> +    This was a dedicated IP on older pre-vega chips, but has since
> +    become somewhat decentralized on vega and newer chips.  They now
> +    have dedicated memory hubs for specific IPs or groups of IPs.  We
> +    still treat it as a single component in the driver however since
> +    the programming model is still pretty similar.  This is how the
> +    different IPs on the GPU get the memory (VRAM or system memory).
> +    It also provides the support for per process GPU virtual address
> +    spaces.
> +
> +IH (Interrupt Handler)
> +    This is the interrupt controller on the GPU.  All of the IPs feed
> +    their interrupts into this IP and it aggregates them into a set of
> +    ring buffers that the driver can parse to handle interrupts from
> +    different IPs.
> +
> +PSP (Platform Security Processor)
> +    This handles security policy for the SoC and executes trusted
> +    applications, and validates and loads firmwares for other blocks.
> +
> +SMU (System Management Unit)
> +    This is the power management microcontroller.  It manages the entire
> +    SoC.  The driver interacts with it to control power management
> +    features like clocks, voltages, power rails, etc.
> +
> +DCN (Display Controller Next)
> +    This is the display controller.  It handles the display hardware.
> +
> +SDMA (System DMA)
> +    This is a multi-purpose DMA engine.  The kernel driver uses it for
> +    various things including paging and GPU page table updates.  It's also
> +    exposed to userspace for use by user mode drivers (OpenGL, Vulkan,
> +    etc.)
> +
> +GC (Graphics and Compute)
> +    This is the graphics and compute engine, i.e., the block that
> +    encompasses the 3D pipeline and and shader blocks.  This is by far the
> +    largest block on the GPU.  The 3D pipeline has tons of sub-blocks.  In
> +    addition to that, it also contains the CP microcontrollers (ME, PFP,
> +    CE, MEC) and the RLC microcontroller.  It's exposed to userspace for
> +    user mode drivers (OpenGL, Vulkan, OpenCL, etc.)
> +
> +VCN (Video Core Next)
> +    This is the multi-media engine.  It handles video and image encode and
> +    decode.  It's exposed to userspace for user mode drivers (VA-API,
> +    OpenMAX, etc.)
> +
> +Driver structure
> +================
> +
> +In general, the driver has a list of all of the IPs on a particular
> +SoC and for things like init/fini/suspend/resume, more or less just
> +walks the list and handles each IP.
> +
> +
>   .. _amdgpu_memory_domains:
>   
>   Memory Domains
> 

