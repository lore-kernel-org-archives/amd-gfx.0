Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711CAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 15:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E0610E74B;
	Fri, 10 Dec 2021 15:13:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A995D10E74C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kablS+QAxXw5lmP2B//g1PY1B/ZnDm0b3nRfQG/XRlAgquTZ8UrzorAdmWR5q2ILZDD1CSkfA+PDOuvDZt2II+u5qriiR2q19HeynttmU+3Mzc8HME8BLzEKSABliR2pNhlPkMIkD5hc5eyq0lVh1jOKbZhTMeuZKItDCdgR10kh2JAmeQODKG3wJQxotp2sQ98ALQvSYfyTMLD9pV1vt5L1/9+PM4RRU42cpJ2qZ8sxmPn97koajaQ10rIRjOvX0304TFbwkHbnH8gIEysY105Xpmc6JieN7EpFms4VyIOhvQeEjybp1sb4egTU/t6pEvfmfCKkYW5XGJhrdyxMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8CMOs+Lu1VWdT3EJ1r+egLNZEoS/uaVq1O0px+Y8QA=;
 b=X60rzfvxXj0+BSduO/CdsopnSwIfjZ184+dNWY9SiKAZAN8iJ7GHTMC4f1qtBpQlIc0t58+t5Uzi5MP6K6eK4U6erc1pKWDQv4/fwXfIFXRzXjmeNghPUTi9dzU2B5F2VaAQpecgu5bRqgPvgL6ZPOAJa+xkligKOePnkDza35rmzwmFpfW2xHXwBAfEfZ8iMfCftxz9/mU06m5tsaiWCIVOHtcX0Q3RyzLhGIMcR4CvBOo+iiGSnwP+yMc9rH8mOJWL1vctuc+eozMUizuffUG9KnZjlLOqdCItKu10Px26vdOVdHcWvWlfi8C4jGO9tJE86mXAcKdrJ+r9Jz0wuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8CMOs+Lu1VWdT3EJ1r+egLNZEoS/uaVq1O0px+Y8QA=;
 b=jNEIe6MpedH2FVIWFJTl7ExASTSkqnOPQE1HfgGWEiHFNVXBl2izCZkBbeuHoGYuOI37Kg0Npl7G4nKil9vBDJWEgLqHLozF++h961mf5TdsNJV7EZSjVRbYBNdJQ9r5Rv1nZzfCqrT90bXYmhYCvWRrkUnvZ5xd4T3GLzrqrtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:13:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%6]) with mapi id 15.20.4755.021; Fri, 10 Dec 2021
 15:13:42 +0000
Message-ID: <bb2d3276-7b6f-b46a-d74b-b25021d2eb75@amd.com>
Date: Fri, 10 Dec 2021 10:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] Documentation/gpu: include description of AMDGPU
 hardware structure
Content-Language: en-US
To: Yann Dirson <ydirson@free.fr>, amd-gfx@lists.freedesktop.org
References: <20211209234717.8897-1-ydirson@free.fr>
 <20211209234717.8897-3-ydirson@free.fr>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211209234717.8897-3-ydirson@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.107) by
 YT3PR01CA0098.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 15:13:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b43778a6-5e96-4594-592d-08d9bbefa6d0
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54101D613D9D8560D16967A88C719@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6PdTTW0YkBfIJMClbjNwMSz4YC8Vjq6xE5xK7w4KDkUA2SyuXHbIZEFldW0czA3TZ18WZPPr5kngczYERSZvOF1FYVyIDv1Pe4Ex/gTNB5u3h/PvJzpmeGTkiF1O/6PQR/1Sxnn97f/2UPXE59zbOyaDpSYsVSf+2s71zZSaEIo832TGe7XZV1Iy/xz26B5jB0jbIpLFA3/3pWeZsDWYB8WJj3q5WICeVNHum15WuQCzIjJeQKym2eOGp0R+rdiNjyVSa2rlzL+gRYnH+aduMxOdchZGY5aHwn70MtlE0mlZeJMy8bNoJbjcx4h6VeLzs6IKYybvYVHqRXACAdyj/eUAuIcFt2VGiAlTXmF3h//TccYeWga89bbChgyKgs5hjGzGKElUWcaxLIGQmHGEg5czug7D6bkl2gHRq+WjrQWKfxcCOAeiiLJmcz5i0YLim4zjY2mzKnMP8Kem1GUSRkPHBKOSkt3XKYdRGwe9liYZX/L2scFOpp2TYjVjZC8x+S00pHG7PiIeuzX3nXLiQrq8pdsRn6O+C3W6q9rsw0AYf3XE5ho3dxlfo/zo8jxj901wqI5+BkfNSg+0bOQ+vqpf/e62bc1x6uxzwUj3MzTKcEgX1w0d3V0yawZCvqsMPmp8I9EJpJZ4EfGtnh4E7VeUSOw76cLQV0MrfJgPP3ZlDR8skGKtoYUCBkIhDkIdPd0rbLrF346leSxRyPtZUPJL1qRvpRwMUhlNU5ukQiOoUR94nMF3ubsPMEg3xtJTIW31g/jk009sBcsZEDqXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(5660300002)(31696002)(66556008)(36756003)(6486002)(66476007)(2616005)(4326008)(8676002)(8936002)(86362001)(66946007)(186003)(83380400001)(53546011)(54906003)(2906002)(31686004)(956004)(26005)(44832011)(16576012)(508600001)(38100700002)(43740500002)(45980500001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y05JcThOWnBsY0JQMDFROTFscmJ2TnNjdXlqTTdjVEtTc1BERXFzTmlQL0xH?=
 =?utf-8?B?Tk0vM2NCRStxYnEvdlc1c2ZJTzFkL21xUVQ3bHFUZkwzUndsM3J0TExwa2JK?=
 =?utf-8?B?V25EK3RLUWUvQTllcUNzbGs4bmFwY25DWG9ycmhCNkphOVRrN1RONnNOQzN0?=
 =?utf-8?B?VE5Rc1Y1dmU1Q2xaNlR0ekVGTzFWck9VMkxMcjB6SVFLNGRkcjhDb0dES3lS?=
 =?utf-8?B?S3FraStYdWI5OTZRQXB5UGJxd0NYcVVtZ0gwQ2RMR2hzZzZDNTdMVnVUV2p4?=
 =?utf-8?B?SmRMci83bmw1NUg2TkN6dS9BOTBWSXNsOGlNVllRUHZpZ0ZvbGF6Q0VTZHlt?=
 =?utf-8?B?RXpxY2dIYTVVSE5rNnYvZmZFK1BLcHIzemZyVU4zblhJQjF5UFJmV2JpVFkw?=
 =?utf-8?B?cVlRL0xlU1NxNDNHcjlCb3d2K0s5RnkxWmRadDlIYU9YcHZpWXBiajNoT0NL?=
 =?utf-8?B?YTgzSUN5RFYvdFpqbmU5ZmlBU28yU1NsU0NCNXVRa3cybUNNbFVPakF6Q1hF?=
 =?utf-8?B?a1F2UU94WStsMlhuRE1BdXlxcTJHMElwWHg0bFlWQXJPQ0t2a25ZcFRHc2pk?=
 =?utf-8?B?MStWTnBSN1RjT2VQU2ZwbEF3SjhkZTZyaTNCODREQVkvV2ZwRndZSE9DRStn?=
 =?utf-8?B?dXBKTnh5MnVWdkw5eFEzZGVKL2k0MzVnTCtLT3VUbzdlc2JyQ05QWXoyR0hF?=
 =?utf-8?B?d1lNQTVRNTM1ZVpYYWwwL0FjSzVKMGY2Q2NlVWZ5OHlQcTIremNiOTNJWjZk?=
 =?utf-8?B?VFBTM2lMRUhnRHh4d0dkbHlrU0xvT01mVzJRb3ZIdmFuR0luMG9SQ2R3RUQv?=
 =?utf-8?B?SFV4NjhPS1hJaStJd2MyeU9vdHFlWGlxK0E1b2NDUW90REx3ZjhQaC8wcTJY?=
 =?utf-8?B?dzdHV1dQL1JRVzBDb1VqdGRFUi9PaklpUldVbVJ4eEdvbHZTaDFHRHpUTUVU?=
 =?utf-8?B?amMvLzJGYWhzbzVjT0d1Z1ZLTHY4SkQwTkE0c3k5WGxyVUcxbmFuTjlxYmF6?=
 =?utf-8?B?YmVJUGN5MFpDeG9HU3IwejNpOTdWaDVzbzViUlFHWSswbEdrWFZYWUl4M3Nl?=
 =?utf-8?B?dVBVZklIQUt0U2xPTXRLYUlJcXArRXY0R2R4b1BLbHFkZWZWRmV5bmg1OXhw?=
 =?utf-8?B?WEhYSzdJeks5MUtSTVg5amZML1VuQnNRMzFrY0F0Mkp2S1pKblU3cm44Skx3?=
 =?utf-8?B?SHBNZDZNelF3cWpSd2taekJDenc4NXVCZFU1Z2tzYUY0UHFGamM3NjkrUUxB?=
 =?utf-8?B?SmNOZ2ZxMk1SVDRaSS9ENmN3Q2ZVK1BVbTJkU3ZOeGRxRjNUZ2MrVmhsT2Zl?=
 =?utf-8?B?WVdYeVAvWENIdU5lWVpxZ0YxRE9kdkhRZEp6Smg5d3pYeUJpNXFXZ0hna1Na?=
 =?utf-8?B?NnBMNDlzU2RyY1hncTdYdjdJSDdRUGdyN0JRMWFIbDc2U3lxWFV5V1o1WW8v?=
 =?utf-8?B?bUtFVDFhTms2TkY4cjVNTWhaT09qT2o3ZWczNnZuWDUxb1o2YWUwVC80VHVQ?=
 =?utf-8?B?S3BoYXEwSXhqSTBKUFBhNitVM0lvTjdCeGp1Zks4OS9DRHMyUlEvNVAvSGNI?=
 =?utf-8?B?bWFLY3BpUDJ5RzRoSEpaU3p0cnptMEpZcHoxd0hWZHJ3MVB6bllLTXk0NTFP?=
 =?utf-8?B?Smo4RDhMbkU3OXhwMURJRWxOd0trSFJGdTFDS1p3SFVqVm9nc3pHUnVma0Mz?=
 =?utf-8?B?QkNvYzRRaEU5SVo0TUlGYTdkWnFoZ0VNMmp1eURUZ09FbmxLRTcwcWRpcSts?=
 =?utf-8?B?TzZzZXpSNG5IRmt1UWhKbHhTSGorUjhpSUdpOTlWRW13T1F0T3h0S29pU0Vw?=
 =?utf-8?B?RkxUU0ZaS1NJd1RvcUw0ZkEwTm1FS0ZGeTBQRkdZSFl5TlA0dVZrcFBUUit3?=
 =?utf-8?B?Uy9UOEpDV2ZuTjczZFZBSm5ZVkdNODM3c1FaNFpPNUpDSXl0c1BJNlJmTDBO?=
 =?utf-8?B?S2o3R1paVndxODN4bXNtS3V6N2VkUG1iM0hqaWJEcXlOQWpvM0tQRmw5aUxV?=
 =?utf-8?B?dTkxWFN0eEgxekh3VzhQZ2JEclBpQ0EyZ0JpSEViNVd5OHBXQStlSTQ1ZTM4?=
 =?utf-8?B?alVBWE5BNVhnSGRLYnAvdUtBblpGQ1RKSUNvNU9SQ0w0MzZOTnJQNi9FU05B?=
 =?utf-8?B?YWlXR253NjkyU2tNVU5RblYzRUpmem9JQUhZMFhTOVE5R1djVHFqYXRhdmFX?=
 =?utf-8?Q?KuHntiP8wvwH6FkSnZzGbKk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43778a6-5e96-4594-592d-08d9bbefa6d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:13:42.1747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPO6005cJo//x7Is7bTBSE6lrzXsotUmUb5yQJ64WBSYf+Tx26ppDZmLW26R4c/pA/JB8h6hPwhD27xCQgUqvg==
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
> This is Alex' description from the "gpu block diagram" thread, edited to
> fit as ReST.
> 
> Originally-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>  Documentation/gpu/amdgpu/driver-core.rst | 81 ++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> index 97f9a9b68924..909b13fad6a8 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -2,6 +2,87 @@
>   Core Driver Infrastructure
>  ============================
>  
> +GPU hardware structure
> +======================
> +
> +Each asic is a collection of hardware blocks.  We refer to them as

ASIC should probably be capitalized (here and below).

I've been wondering if it's appropriate to call our chips ASICs? I
know we do it all the time but our chips strike me more as general-
purpose use devices than application-specific devices.

I might be bike-shedding a bit. Overall this is a great summary of
AMD GPUs and will surely be helpful for people looking into amdgpu.

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> +"IPs" (Intellectual Property blocks).  Each IP encapsulates certain
> +functionality. IPs are versioned and can also be mixed and matched.
> +E.g., you might have two different asics that both have SDMA 5.x IPs.
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
> +    encompasses the 3D pipeline and and shader blocks.  The is by far the
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
>  .. _amdgpu_memory_domains:
>  
>  Memory Domains
> 

