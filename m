Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8B5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 20:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A0B10E8A2;
	Mon, 13 Dec 2021 20:18:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C365810E8A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 20:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg3fQZ3k/GRhsSNIrlvuhgOnZ6KceXpPMDNzhJnoDXUW88yUChLNUGT4ZlqK1A2XL40VkkrkkdFJi768P63O93T3PtUT4QZMN/eV0AF4n9wJh9qlri7lAThyhg8pQdFyVqfKdYOKbckApV4/a3WAt6+E/EZYBMtO/WPfLeMEU4L2mDC1o30W0lBFLogN2QQJYjlyCDiKWF7tCU5Qyz3PVvnaEzyr67HnJyWGIXri3G0nNLsA4+A3Gh+GJWdmRxL7gsopClrB80MqSDXixv1CreUUjXElW51mWMQtZvqbDC1HkXhOWAeZO+8RLH3RAn2lq5/8q7cRp9EFtcuEPqroYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErPIhXYSLGiJQuepgslnSTxfR0Dq6jjAB+Mw4O7MMa8=;
 b=ev4h8Cxy564FbakanUJ41ZLv1q5B7gVQWQDDkelxRtKIKtSEZKkJKXX2C3g+x4Xf/TWDFdAevfKaI5W/bj+Pn+DnveLyLYqref7zZ4b5fERO/v5ekeA9zo+E6L3qp0VIdcdI5LsrvZ+KxPzk2KY1EVZXmvhStMFRGsLwQcHBwdO+qFVWZPge0fWOzrLbPF8a3jtNBWiWpRBQm5BrvlBQVAlIRkkAhXgXG0RzK+1v4zTtf7fpOjoSIoxpFOPMN+Sbt5cTlG3GrFa5VNuVLeDXLz949Yj059dd0O6xqTW6EgIHwvIX2H6BdmC8TRN9aAXYcDIpvBwhM9bNoglmyC1U0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErPIhXYSLGiJQuepgslnSTxfR0Dq6jjAB+Mw4O7MMa8=;
 b=UI4tsQCfzQCkJW6I/fGwQ8FJnV7eK/9G7Gww4/wm13FydLax2aIdvYTFGO2LXRLiO4QC7jlPpeKY9+uWRArIihgNutWZJhN9UVqhCislOwHSJ8VAQ387Co06E0GpAQbZ8Hi4rPh3N+1fMXnwb/LVl/Ao3KvTZTSBB+sLkXqt1Os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3325.namprd12.prod.outlook.com (2603:10b6:208:ce::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 20:18:43 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 20:18:43 +0000
Subject: Re: [PATCH v2 3/3] Documentation/gpu: include description of some of
 the GC microcontrollers
To: Yann Dirson <ydirson@free.fr>, amd-gfx@lists.freedesktop.org
References: <20211210182030.3834-1-ydirson@free.fr>
 <20211210182030.3834-4-ydirson@free.fr>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <7d315a14-20a8-f1a0-87ff-4bea2ab9069b@amd.com>
Date: Mon, 13 Dec 2021 15:18:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211210182030.3834-4-ydirson@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:208:d4::24) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f56d9f02-c3a7-46ac-e496-08d9be75c247
X-MS-TrafficTypeDiagnostic: MN2PR12MB3325:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33259DD5DB7A449ADC32F72E98749@MN2PR12MB3325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBWGuyoZWmvUnwX1FRyLF8pY073XAC9gXf3MTrC17lhJ+AMJgMEYYAD1TO4x3nWjQLNd6NFo3wyYPj8mRv6AVGc4OoSiihSz+Sp4bctoZ4ADRlnmsAHRlRPrkS4o0DFDsTi/GYlN4WhpBvj7J9V/j8E5f+3d0Q/lLfKN7dfyixO1zGVMwQbBbJQZQg8zVpIBsLRhFD5BRqpilFJyUH1eghQwHmw2Pcptv8LCMfktgVJpbvPDMlA7yRCGgRP/lOPDemGkGKlniNTPu4qakJO1OGY2Qkfx6puQ+hHljvSLMV9tKtr/epkoEV4OucBScHTyajJ0Ix/eUX04d5eAyB6374DEeBGcgmS4g6jPEaMsLYARua/pIBGlxu8LxSJpvOIcYHuLg2zONHLYajEjxLYXtauqfL85soJhijyfvExSDES5DvfUqIpLmfsHr+LC8Oqy74y1Hf67FSSfOsT08IG1mnFkz9MQxPO8iw2J/irgUpqJJLAcwMEosbFDkNu27FLqPVk4GurQhD53lIGOofPHJHjE2HDW84N+3BXu8K7N+SZLawBGrkNW6CAkbHdBI4RsVlWF51M8h878dj1J8/Q1QnVc/G28H2CLJCjDpE+V/AWJ4Yx1ejEp8MKleLeHOX+PfXw+bBbMtpCBlVLcw4lPDaj3YI0/tw7FMcVVo23jrzom1Irt4dtcvAGMsAt+WroqX7rZJ7oqjHtjJDdOo8l401t7a2yNcipvKfSxz7A+PY1LBv8NrLmpvH0b3skNTpZmBPpCNojYNnVs+XVt9SJOaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(8936002)(6512007)(2616005)(83380400001)(2906002)(36756003)(66476007)(38100700002)(53546011)(316002)(66946007)(5660300002)(66556008)(54906003)(6486002)(6506007)(186003)(31696002)(31686004)(4326008)(4001150100001)(508600001)(15866825006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BDemlPRGdvVkJQaUIweWs3VHpZUGJFaGNPKzRkMHhCdVFrcDU1MllsNUsw?=
 =?utf-8?B?SEdiY09WWFF5L2JzRDd3K3RzQWtrMGtldG95Nk51cDZObWltUHpqL3hWME15?=
 =?utf-8?B?VHlQelJtOEwwdUZReGpmVUo4cnhrSHFEQlZpRTVQSGFJTUdSZndhUWNFVkJE?=
 =?utf-8?B?UDdrbCtLMkRaWXgwd1pVbFdVa1owVllMZHJkVkxPU21HamVsY21MR3VHZ2VJ?=
 =?utf-8?B?bW9SWGs1WUVkWDZLbFFLV291T2ZnejBoTklDQnE5K3hvMW1vZlVCQzNIZEtt?=
 =?utf-8?B?QWg1djFoMHNLMndOeEcxbkk3Y1VOZGFUNStDN2xUY0ppNEkxa25CWEp3ZklV?=
 =?utf-8?B?cWFOcTJpSVVMOVZwZlRFYlVIY0cvZ3pkWVEybit5SStaTm9mLzVwTVo2VWdZ?=
 =?utf-8?B?ZEwyc3hybGtxZDVMaUhreVZUczRZMllEaGkvb0ExWDROWDhwTDNBVFd1aXU1?=
 =?utf-8?B?L3dkWDV0ZTFrOE4vTTgyMUQweVQ3U1ptVld4dW9URmhGMityaENHSncxOEhi?=
 =?utf-8?B?SUJ1NlNMRXg4elJPbE9tdCs4SndGa2lRKzloWXNVbEdoNklkd0YyQUtTYVEx?=
 =?utf-8?B?MVFMSEJHUHhjUGVUOFVncURvV0ZnOVhwdFVpRUdxMXo5d1ZsSHlPdTZDU2Fl?=
 =?utf-8?B?VW54WG9ZY2lIT0ZWTHc1dyszNmswbXVMdWVITC82MHc5c0I4eDdmVkUwZm9j?=
 =?utf-8?B?WlUzRDFBUXoyZ2N3MEJrMU1lL1p3WEFVR3hqQWhnWFFjQVVkRHlIRzlMR3lr?=
 =?utf-8?B?UXVlTUV3SHJEZWtmci8xNTBMMEN5ZDRNRVFqdnBqaE51RWk1b3FuNzRUcS9n?=
 =?utf-8?B?Z2VDNXM1L3kySWk1K0NMV054OWFJTlNiNEIvSlpRUjBzWSswY2ZDY29OQWlM?=
 =?utf-8?B?Q1ltZ3o4elRvVSs5VkpSbURUR0JBNHU1UXlYcGZteW1PUjhESnk1bWFLL2Jm?=
 =?utf-8?B?S25NUVVEZThDY1loUlM1MzNZaFFUbWlTUTJNMDIvZXg4RGg0NUR2NVhOZlZH?=
 =?utf-8?B?SE5QZGM4K0p1cGt1cVFsa1FxanpnamlIRXJrbXJlZ1RvRmU0cmR0ajZJUVRu?=
 =?utf-8?B?STFiM0Vsa1RKNmJ1Ly9qNG1xSWZRa3J3d1ZHcEJpL0w1UkRsVDZPQ1pGbi9I?=
 =?utf-8?B?NmUySXJIdFVnODZxZTZqQmdHSHRBajc2WWdJVVZ0d0FqRjB5SXlUTmwzalBJ?=
 =?utf-8?B?NFVsMmdIQ0ppUVVOYThCWDA5VU1KaVNHdlQ2TEF6RTNTT2pmWTRTeExmYWp3?=
 =?utf-8?B?OVZDQnc0S0J3b2Jpd1Bablk4TmFGMmZHMnpKNlVGenFBZWtlSy9ZTkRNUVRE?=
 =?utf-8?B?b2treUUvNzQxSnYwK21FaE1heEFMa1RXSTNZZi9JbHFhbDlZb0M2alZQSkd6?=
 =?utf-8?B?TEZjR0k4R0daWGRDMFBPZUFNclpzak9JQ3d2K09tT2xxdnZGendpeU9YY2p5?=
 =?utf-8?B?NDljTzZIbjFPalZJelhhakNlVm5HclZ3dXdCTVdNRUVDdWxDaDNlU05aeVMy?=
 =?utf-8?B?cmVUdTJSSk1oOFpPSk1qU1c3eUNpVTJqWnExSFZYSFVKZ3JzYWhnSDM3ZWky?=
 =?utf-8?B?aGE2L3R1ZCtKRjFZNnNyUlcvKzUxbUZEWndUVGltOVZmQ1ZRZGhwTW9XczNl?=
 =?utf-8?B?U3ZlR0lsYXUxVHU2Tm1ScE9SUkNpTktRZTRZbnhnL1BWTk1Cdit0SmdoV2lk?=
 =?utf-8?B?Ym4wUWdXclZTMDRzcmdwYkQ5S0RMMUdaZWdnWnFIY1k1cG5LZ1dKemtXeGpO?=
 =?utf-8?B?VTJvUklhRE85amFIQ21lVGg5M3lXdzM2ZUROV2lEWUplS0g0S0pwTiswSjRl?=
 =?utf-8?B?VkhDQlVjM25jVVlhRFdlS1B2QjYwbzRJRkZzOHdRS3JRNXpKaTUzYmNkTk5Z?=
 =?utf-8?B?anV3czB0QzZGMTVSb1kyc2UrMzQxNDVXakJYN0lZY3AwNmVuaDVIcGVtVXJz?=
 =?utf-8?B?OTVtd0NkM1VjU3o3aGc3c2lFczYzTDBFUWU4SGhxalZsdWg1ekNNSFQzTnY1?=
 =?utf-8?B?V0VuWUJOaHo3VmNEV2gyUFY3Vms5Q0cvT3BWUUdHSXpoMHZpY0IydXVqSnNy?=
 =?utf-8?B?WCt5bVZHb0ljMEM3dkJSMENZYVV1Y3ZDTC9pMnlPSFhzR0pvNGx3bFlHdDd3?=
 =?utf-8?B?TzB2b0liQnRKY2xIUW1wbjlHR0MycVJtQW1WM2FVV0RKUmxXU3BxUEFsWVZl?=
 =?utf-8?B?N0xJMTR5SFY2N1ViTUs5eXVTRWM3bjBsNXBmUHplZFRoZ0g4OUlsUmxMWXlE?=
 =?utf-8?Q?qidKIMmUivAX342mLYrAt1y/aF6DQa4Rwe0ANuLipM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56d9f02-c3a7-46ac-e496-08d9be75c247
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 20:18:43.1107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAqlsCX4evofktlhN52kXlAskgG/oNqiXKdBFxcvLrBun5d/MDBvK857lIHYLJYde3A/MThS0ntBCUdHU/m/bw==
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
> This is Alex' description from the "Looking for clarifications around gfx/kcq/kiq"
> thread, edited to fit as ReST.
> 
> Originally-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   Documentation/gpu/amdgpu/driver-core.rst | 35 ++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> index b870a63c64dd..942bc7c3eac9 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -75,6 +75,28 @@ VCN (Video Core Next)
>       decode.  It's exposed to userspace for user mode drivers (VA-API,
>       OpenMAX, etc.)
>   
> +Graphics and Compute microcontrollers
> +-------------------------------------

/microcontrollers/Microcontrollers/

> +
> +CP (Command Processor)
> +    The name for the hardware block that encompasses the front end of the
> +    GFX/Compute pipeline.  Consists mainly of a bunch of microcontrollers
> +    (PFP, ME, CE, MEC).  The firmware that runs on these microcontrollers
> +    provides the driver interface to interact with the GFX/Compute engine.
> +
> +    MEC (MicroEngine Compute)
> +        This is the microcontroller that controls the compute queues on the
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
>   Driver structure
>   ================
>   
> @@ -82,6 +104,19 @@ In general, the driver has a list of all of the IPs on a particular
>   SoC and for things like init/fini/suspend/resume, more or less just
>   walks the list and handles each IP.
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
>   .. _amdgpu_memory_domains:
>   
> 

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks
