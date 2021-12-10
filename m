Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB3FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 15:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41CEB10E789;
	Fri, 10 Dec 2021 15:14:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D8E10E776
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDN9620nGm0iQmDWxIMrTqrNlEenGa9Tl6J0soxSmjOKO17DcXH1xmkqVKB5Mr4fI8W4/OtKd0UEEUIzTu5M9laYammjgglhTPGtXUGVamevzULi9drLTi6bRiMH3Y7eqZiJ2YAtS7B/365kOpLYCvLijFrSgco9km0ofubFfyr1RIpiedCIjbGnQ2rAvoz16+QXqfRL0P/mLRo3Q/n78wS9GWNO1ol69W2hknnPAbteUtdix6HKf5HPRFlST6FNSw5bRtu5qCs04hdv/Zf7L3BabOpLXt5XqfZLJjqkJOFPyAC8wIBPiJh1VPTvjh5tzQkz0XbkCxawcEErWroX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8CMOs+Lu1VWdT3EJ1r+egLNZEoS/uaVq1O0px+Y8QA=;
 b=hBEnX31KYvsF5rPAvxRuAl5VbXX5zEmDgbwq7mKV0YbHiDDnVL2kRwy6KLgPM8ImtTZimuKx9tX4xpdzcooT75IYkApdwPS/dLrbMgHvhtUGgHekyOXCacL2EUi+kuCUpHkv9ZcnwCZ0O74XSNOosL6LOIAYbDz94KJZIun5TLWABB0SqeZH9Ua/4+U82lRfJgE+snfJ1eHHNAdUeWVdjtvnfGRwxpvIKyKAwbDyGk0fvX75SW9TjXv2C4gVREwBcUgr9viof323k+jSr7lxmNZehSzGyjyPAN7auKuSbutlKLxVsrbg2/r6rVlGvfMz/x443ySYcGtLxaNRVS0Efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8CMOs+Lu1VWdT3EJ1r+egLNZEoS/uaVq1O0px+Y8QA=;
 b=C4nIFU4TcMC54gAIXnalmsljPR52Fvr6w4H9FaPOdlkamjoy6rZvCDUSqSsTOtVi27ec8NK+vR76vHD0dXgDw/CFM7/2TLw1nZoh7L6tcQpYUjABO8RnXH1iI/Gh9hd/rBN5HiNQCjQtDzt9uxl3t622ujlc3aIiPzbkx3rEZAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:13:59 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%6]) with mapi id 15.20.4755.021; Fri, 10 Dec 2021
 15:13:59 +0000
Message-ID: <dde84e03-fea1-dd81-00a9-c35f2b18749e@amd.com>
Date: Fri, 10 Dec 2021 10:13:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 2/3] Documentation/gpu: include description of AMDGPU
 hardware structure
To: Yann Dirson <ydirson@free.fr>, amd-gfx@lists.freedesktop.org
References: <20211209234717.8897-1-ydirson@free.fr>
 <20211209234717.8897-3-ydirson@free.fr>
Content-Language: en-US
In-Reply-To: <20211209234717.8897-3-ydirson@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.107) by
 YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 15:13:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83172c28-0ac6-4b6d-ce59-08d9bbefb132
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54101739DF3D8F8B9058EBAD8C719@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfuBMt0x6l4HJ50JrBBrhlNXKEnLbgmHPEW/PbJmymNRJrxsS2oVyrPwywZj54Xo5sPLin7B6S2Dzb+DhXXXD7BwRlP+hp7lWyaGtXQB6ljeudxRX2xZzaDSpXxUyY5fNQljiamwe85HtuNznyAMoUXM/5SQQGqpHqRuK99zWeW48AWdCUQQ7e3w3UOei23Sx9uVGvIraW5NrFns6S0Q85D45smqpwwhZVATBmtWqTOvDPYbIm8RbXylEkrS/vy4dDsebxurUy3KV0GFfCkOJAHQRW3hPKZnDKQmxOSipwlP/6939o0OUKHd4XNSxsfHaio8Ji4wxYrQZ2iGpBRp0e5bfr6msBpIglFPdVZa/wYa455z1yyAuLsGIiZsUgpCjXfGVWCo+St+C6vT3ytoc2xHnD/XtI4MA5EKPP8HUvT5zbA7nF8GGVwFCnI1pztRxNk148vVcaFLDvy2MG8nq8N9ZGltLVDpYUVasAZmL0dg84rclloiYPpcCfqganCM6R1YmeiN5ZtAIZXnPYEzQ1Q6pAe/3c8zR3G9o4v/JQ9/61hdU6sx79ypfwHWWvavkpjfbpEce4xWOYqUb/2dL+BEQSzMpJNCl28MHZ1l9qH2nQj/dCLDjmgt5ZWJCB4YPmHvQJvGQkBs5j0j7JQZeG9c2rGqI0CvpkgsRAg1sYZ49ZI7d8YH6zDVOzI6HWMFUP/RP0sR/9kHfp+tQXMk3zgQ5Eutbtzv7ycyOs/GVmOVU7iFnERu4uU+Sk1quV9cdR0f5A/uNRUJjugTQf7hsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(5660300002)(31696002)(66556008)(36756003)(6486002)(66476007)(2616005)(4326008)(8676002)(8936002)(86362001)(66946007)(186003)(83380400001)(53546011)(54906003)(2906002)(31686004)(956004)(26005)(44832011)(16576012)(508600001)(38100700002)(43740500002)(45980500001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUVqbXcvcUJUWVpXaVNTUGlPM29QdU9WSHo2UktNRzM5SmE1a2w1RmZoNXFr?=
 =?utf-8?B?YnNSamZpUFNlUmNlcHM1ejRtWXp5d1o1SGRHZG9VTm1QNk54V3g2NHJlSWhp?=
 =?utf-8?B?SXl2U3FFQnZlR05IblhaSllHNE1ZUDRmTGJ2b213c296N1orR3B2djF4WFpE?=
 =?utf-8?B?MDY5eUNmeENwSWpNcHNISEJRVUdrZ2xCbUIwZklIOXdEUWlCU1VIWDBTOWdk?=
 =?utf-8?B?ekhzOStESXN1NWlaTUc4Nis1WWVCamcvK1l1VGp2TW10OGtYVDlkbTF2ZGJT?=
 =?utf-8?B?V1ZsL0xzNytZMDhHVlNsYUo4SWNmTWEwaVBHNzNXaXBwUkVvRVRUSDVjQ2ZP?=
 =?utf-8?B?ck1RdHliaWlxcE1Mait3aGVQQlhzdVVkUnhKTVYydEpRT1RyZzZsL3VaZSs2?=
 =?utf-8?B?YmdiY3I0bHMyVzh0d0xhS1E3bkQrZ1lOVWtCQmt1RmJsM25WTFZ0dWN1V2Zi?=
 =?utf-8?B?aVFsZ2FjOE1Pbk90M0hZSE81UkVtZEVlUm0zTjhZU2RRNHNCNVRuOVFpaDR2?=
 =?utf-8?B?SHAyZE4xWkF0RGl1WXdzaEk3TS9wUFF1Mk5uMXVsOHdzTGp5RGovWW12YVZo?=
 =?utf-8?B?ZDBMVUdvSFArOFRDZGVadXBPZEtVb3BVSU02ZDlsZi9SMDVCL1dzZkdOVGty?=
 =?utf-8?B?M0RBenhGNVk3Tk5VRXRNVG1HelFCNGRBODN0d2tzODdOeW1nV1BTWkJMMjgx?=
 =?utf-8?B?bGhTaFh5cGlnb2t4b3lVb0xsUHl5bWlsSVl4WFMxUFEvbWRhY1BRRVpVMXlo?=
 =?utf-8?B?eHREZFFmaVlaYW03ZmppSXdmMG9jNEZ0MStpMnAxVEVieEhGUjRhTG9EZTZn?=
 =?utf-8?B?cjcrRFNGV3E5azgwdWNvTml2N0ZMbDl5K2hLYmdFZUY1K2VCRE1lMXEvdmls?=
 =?utf-8?B?ZjcyZGx4TGFvNVZqS3prSXErbzFtRkowcWNQSkJwUVhJS0RQcVNBRk0vZnNp?=
 =?utf-8?B?dkF4M09jRHI3QW13ZW03dFZhemV2WUk5TXhrbkxaQXltbjlaYWxSNFVRR3ZC?=
 =?utf-8?B?TzBHZzJKZVZtaEprTi8wUmlQdVM2bnNVYm01ZG54K3VlaGhuVTF2TnhhK05L?=
 =?utf-8?B?ZXBqZlVQM2VRSHQwMjA0RUdMT2VScHJLR0pzK2RzaXN5ekk1c3BCbElWamp4?=
 =?utf-8?B?aGJ1VTBsaDduaGNocncxeVhBbnZuQitnRG51eHNIa2lMeXd2VENad3Rza1Nh?=
 =?utf-8?B?cmhsWHVvdHNhRkJhMW5keWFFS3d1NG1nd3N6VXV1ZnNuWVBqUnRrWkhhUUl1?=
 =?utf-8?B?RzBvRDBzU2p6RDVEMFhHWTNMWG0xN0kyNTRhSGlKR2JlZVNWM2JvUzIvVFBU?=
 =?utf-8?B?eTh1RVFiM1BuZHpiZmRmazRjR3dvK0dPZmY0bDNLWWlPK0pNV3hXa0JmSzl2?=
 =?utf-8?B?ZDFpZWxkRlhrNTVkdEJlM2ZaK3N0eUpscjlvNVo4dVo1RUtHR0ZOQWhYQU1X?=
 =?utf-8?B?K3FkUGFIa2FqWERERmRTT0FabzFBdWxyTGpGOUZXTDdjZ1gwcnBiVEY5dnk1?=
 =?utf-8?B?K0paVWFvalVuTU1IbFBoM0FDb3FyY2ZkbFVuMkRleXlXdll6UW5Ld25ZdWVQ?=
 =?utf-8?B?a1dRaU9wbTh3QTh5YjEvUGN1WW1iUjRQRkJJcU56OU9Nenh1WGZJWVlUUjZL?=
 =?utf-8?B?OSt6WjVWRmMxdTd1RGJ5TTJuWjdhQkNKRWl6V3o2aG9VWUVCNEs3dU9HQzJQ?=
 =?utf-8?B?Qk81VGFZOHhJa1BkUGN0UTc5bk5Ka0ROZmlBOUpieVJra1N1enAvM2d4UGx3?=
 =?utf-8?B?cDRGUUI4RkpRRmxtWCszbnlxUWlYVThDdE1aczg2OE5YNGdSWSs2ZkllWmxa?=
 =?utf-8?B?MzYvZmhRdGRKcDcxMmRCc1A3c2VIbThrVlVFWjZyVEtGUWZadVZvaXRMY3Zs?=
 =?utf-8?B?TUVaQ2tKN00zcTNJdmlHNFR2NDk5NkFnQzVRQU1haldoVzdkNmZMalAxWTBZ?=
 =?utf-8?B?TmZTb2RKVFZBS2tUTzMwOGZzUGZHRTNXc085TENkdHpVajlJTkg0ZDZxUlZ5?=
 =?utf-8?B?eU5rdW5UZ083cGthdFcrckVueU15RzlBVTBvaG12RlF1OTVGQnJUdlRzbktq?=
 =?utf-8?B?STVCNEZKcHV2NHpRc3ZXeExNVjRub0VyczBhYlZ0Q1lZMDhiY2w3V05iVDRy?=
 =?utf-8?B?ZU9tN04wK2hIVi9hb3BUNEVRQ0lFNVBaRVBpOVk2TXowMEJlcHhEWEhtclhQ?=
 =?utf-8?Q?pHADzDPFLjXhksxb7AXNmnc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83172c28-0ac6-4b6d-ce59-08d9bbefb132
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:13:59.5245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11VXpUxCBWVtpYySNmYZJj1hUdz2nC1/NaU5DagJyy+q0xoW9Xl9miPz0/AErZb0geeUkNVdWENgTXo8zy8gmA==
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


