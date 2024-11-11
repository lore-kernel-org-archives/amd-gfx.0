Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6640D2E9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 12:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A49F10E48F;
	Mon, 11 Nov 2024 12:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CavJlvGX";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAED10E48D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 12:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0o3dY5wLnKH0KGCROu74MSm8NbbqCEQs+HooPfJTeVzLomdtlFwYLFvwGHQIwcvXF3FcTEWu0WOxAPbwwQbqQnBoP2VBktnYwMPpuwyeFixJsbJyKL5TX0/4xJsqF9DzuK6sKq0DDd2gv4Z/ti6iF21oU9x8/v4glIyDRJTmBdUAaIzDizhCj43i9MYWC2t+G96DCZ0Ryrf3CJlmoYxfqczZlIos7XHJzvQl5ZQ09ZUhd0NhHbu6irvR9wtLSvQrFjcusErnDXwmh8PNxwaeFFhP0F4ERkG8r6hXMkaS6cdqWnBK1b82k5VVEkLz2RbBGPedvlGX/dOq7OKTJ2lUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YKWpFJTTEDs7hllu/IVnesghb1fGR66HUCZ2ImXAA4=;
 b=n865Ckx3ubhR5qCSL1Dfc0XB0k50hlrbd6ALZS0dokLBbOinusaxmX9FWO9C9KS2+bkiCZxHeSNxubAbuUE3GBQpVKp8pww3n17MmEYidrzYxBlF/MJRbXdtX014eLkHfwqnPdCh8AviX21UvW1vVsq+cQ8PLKLL8etSxd8ekZn2B7WH7+i0P11Qgho33HXdrzhXX1HdZ0He8V42gOY02KpFM6KarqLpHrKyhUfVsEsHMEJ0Yni/Chs9OVd49oeClAVB+H6qvvj2/z7e6RO7nT2EAF4IoMOZwzy8dHwaMBERhCncMOJghY9yCqcsV23dr27QgpUYxkNkxLzFHSZkxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YKWpFJTTEDs7hllu/IVnesghb1fGR66HUCZ2ImXAA4=;
 b=CavJlvGXpWJIQNtiLO7AEdOHJjhbTXVU6YJvuTbuLXZXdxJJ1rbXslr3B/S9zUmGeit2ImO56IhaMABZ69Epjx88/u9SIXIfbWUyfmx3Mo+7+OzRl8UaC3CyJ7IjUKrbk9KhftVSH6xKAi+pZZuCX8dvRppsqKtOOz4d32nNI+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Mon, 11 Nov 2024 12:29:36 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 12:29:36 +0000
Content-Type: multipart/alternative;
 boundary="------------a9ATPHjc1E9uXhJtiOeEigam"
Message-ID: <7c12a116-6017-4d7e-a784-48e9deb99719@amd.com>
Date: Mon, 11 Nov 2024 07:29:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu: Add missing 'inst' parameter to VCN
 v4.0.3 function interfaces
To: amd-gfx@lists.freedesktop.org
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
 <20241111024612.1881727-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241111024612.1881727-2-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: YT4PR01CA0403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::17) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9770a59e-5ee1-40de-02ae-08dd024c8119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnZiekxjV2c4MjBFeHpUc1l0RGtRa1BaaE9QSVo5dmU3U24rT2pjcjVMNUd5?=
 =?utf-8?B?NUovdWtVMzhKNEc0RkpLQ2lUaUxvdFQ5SnEza3JzL0hTU2hyQ0FMVTFoUEM1?=
 =?utf-8?B?WU1qdHM5cFFlelhqOENRUHJDNFlQekdOV2d0UnI3STl3TUhtSE16SVRqaDhB?=
 =?utf-8?B?aGF2T3BMbXltZEkvRi90WE8xWDFSR20xNlFWZk5rRUsyempRV0hjTGJINzIr?=
 =?utf-8?B?VFJUTU1nS2FSOVNBMlpzUHFLdGliamFvM3hJRkxmS1BtZUR1VXJTSFllbEJI?=
 =?utf-8?B?VXFQZHF6RDhuRjFia1VrNVloNVFIcllvNVZyRGhEaWNFRXFUbmtnU2ZiVkU0?=
 =?utf-8?B?TE4vQ3gxS0s0T1Njckc5SFN6MmFEZHZqWHpscEU2ZzllWmRoZFA3UThRS3pH?=
 =?utf-8?B?dkZqdzg0Z3p6blludjJURWtIdFFyU2FzcXNQSVk1LzdYZ0x2akJxSktjYmxP?=
 =?utf-8?B?SDVselBOVUJSUS9MVUhvTEhxa3RIdHJXYTZVeTVFNmRMWnNSVUVGRzZyWDJ0?=
 =?utf-8?B?c2JKT3l5bGJ2czRCSHdsMUdLckJvVjR6NFRzbmdwNXZWR2ZXUjYreGw0UGZ5?=
 =?utf-8?B?T2hMTUJLQ0Y0U0o4aS9uaDZrcncyRlg4TDhMMFJNekpqMHRKVTR5am80MUp5?=
 =?utf-8?B?V0JXbnBxbjlZOU9jbkFFb0ljK3p2c3RlQUk1b2ZDOEJZdXZGWnVwWGg2NzY2?=
 =?utf-8?B?MDhoODJpcXMyN1owbHVQUW5VaG5pMGVZbXViQ2d1dG8zTjJFNWxsNlRNbFo1?=
 =?utf-8?B?REhpUUdOdGt6UlBVb1VXQ1Z2Q2ZIaS9xVURqYzdrQjdGVmFoMC9kRDlXQnlO?=
 =?utf-8?B?YzJpK2Y2dlJWb0Z0S09MVWJVb1pDa0wvZndQSlJXQ1AwRjhHNHBVSXBrLzdn?=
 =?utf-8?B?bVY4MXlSeU5Mb0d2eml2TEtENnBVci9ZQnVGTUNydGtjYzd6L2hNUk9ReXRS?=
 =?utf-8?B?ZHVnekN0Q2FhRStMd0pjMDV2M21rTUhSZHdXZkRTK2FWWE5qQnlGQStOSmNu?=
 =?utf-8?B?VUlEM21nZ3lrWEs5RE80SWlkb2RpZDZoVGNDVkVySGJQbFpoVVh2a0x0a3Q1?=
 =?utf-8?B?U1I1MzQ2QVVpUkFLTXZWT2pQNnJWL2x6N094U0JpYWNKOWZxb1VodGxPNXNx?=
 =?utf-8?B?ZTJIOUZYTTJRRFlVY1BEOGVGa3gyWFpsR2FjUm5tUHc2WEFIN0xjc0phd0Ja?=
 =?utf-8?B?Q3BYQjFqNVVYVDZlTUJsOU9EOEFqQmQ4RGxZOTB0cm9STXJHTmxuQ0xnOEds?=
 =?utf-8?B?REdQUldQMGpBQ2RFOGtsUUUyb21LWTBtUEd5YjQ3VjEvemVvaFd2YnFRdHBO?=
 =?utf-8?B?WTJaL3c1a2tUNlREK1hwQ0l0OStpZGk0eHY5V0dyaTJFU3NPdVoxenM3eUZi?=
 =?utf-8?B?KzFYMmlFN1NnN04wVmNLK0FTV3VCUEFrNzkybXdFMmkvdVB6RzVOclc2cEZy?=
 =?utf-8?B?UmhhK0pVYzNQcEhId1FuT0tDaDltRTh3NUNSOTVYdXcycWJYUU5Hbm5BMDBM?=
 =?utf-8?B?K2drdkhNREwxYmFYMDlaK3RtYjM3NWRiVzVMTTZ4THdCNHdNYmVpc0ZjOW52?=
 =?utf-8?B?N2lBOGhkTTNjMjlhQk11SkVuNGlkQkY2bDFBQVpUckQwUjFhQS9RQ0d0cGdL?=
 =?utf-8?B?QVJpVjBEeE9POUM0QkdWT1M5V21xSzUweTIxVXp3ZklGK2ZKdmF3RFI5S1Q5?=
 =?utf-8?B?Vk5BRmpHZWczTVhlMHJwM0ZiNWo5QmhoOU1MeGswcVNmNGM0ZGhETENiQjJ4?=
 =?utf-8?Q?huRKt3jzBqX2aLvivqTLq3AIQ+0KT4XhUljM0dY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdzcUJMR05nZlp2czRzWGVRTDdydHVMLzc3d1JsL1JGb1M1MC95NDZ4K201?=
 =?utf-8?B?a2tLcUpVWTZSam1ZUWpnc2o2ZlRReEdPeVFyeFhzRmVlckhWVlRGbmt3NkRj?=
 =?utf-8?B?WEtFOXZwNVc0UnI1dXJqTm1GUDRJdUV3TzcyeFVIeFRUaklDOStlWEZ5b2tJ?=
 =?utf-8?B?dTkrUEtQQjRTb3UyVkJYMmtyYy80QWtsQUZRQTlLV0pZVFAyRE5ETEJ4U0d5?=
 =?utf-8?B?SUZHS2czN0kvMGVUc3l1SUFZYlVMc0hSRjFmcTB4SFhuUmNQREVkRFFHR1lB?=
 =?utf-8?B?eGdvS3BjVnlRTXM3djBHc1o3UllCV3F0ZElJTEZaSGt5R2c4cWdML2tEK3la?=
 =?utf-8?B?Y3NPMS96VU1Qa0tzdDdZQ3o4T0xneXhIOEFINzJhZXNFSVVsaWFKRnpFbmw5?=
 =?utf-8?B?aldieG9oaUpjSDR5bHNGN2g4NWRDbHNZVVgyZWl0NkZXNzR3MXV5M1NDZEVj?=
 =?utf-8?B?ZGRoR01pak50am9sd3pEOHZnSnUxTG9GaGkzT1h4dEdWVmZ2TUROKzVRdHRB?=
 =?utf-8?B?NEs0Zk1BOWQ1dTFvQ01FeTJrUEt5SmdXYlFaNFovVlZvVGIzRXFPU25ncmJz?=
 =?utf-8?B?eFNINWRKcDZZdExIZ2lzSVUzYW1vd1IyZjNTOWdmZnlhbEVkMHEwOUVMdTFr?=
 =?utf-8?B?TzBIZ2g5NC9hS1Z4Sk0wOXZ6TXpUTjRNY3g4b0ZXbi9Vc054aEhmZGZrWjY4?=
 =?utf-8?B?akg1eTY5c0tKY3BFSXZydVovTTVlTi9jOTA1Wm5yQ3RRNUJHaHhuUUQ2K0ta?=
 =?utf-8?B?Y1VFZVgrTVBUTGRqck9jTEdEajNuMFJvekhmRkhNSkdRejFvelJTUGt3ZWtF?=
 =?utf-8?B?aXhWUWdvK2x0WklyN292NXNXV3hqMjlSL2N3MzNNS3N5TUtKbVYxYTJnS1Vu?=
 =?utf-8?B?cWF5c3hOMU5Jb3VZcXlzVmZOODNhMGlFVVlPb29UMitBK1llNHAwUEM4d3dx?=
 =?utf-8?B?MW80SEVLQVZ2RmRYaHM1eCtZc1NnWnk4cXdIdXBhTjVHT2RkTlM2QklGaDBT?=
 =?utf-8?B?V1ZObk5hSDlGdGxlVTBjdVNRdnBxSTUxYVhSWW1oWm1yYjBESWZnMmNsMlQ2?=
 =?utf-8?B?dlFLL1ZQcFM2VDRUbWxINDZYT2U3cFBBMExMSzJpMU5UQUtleVVQV2RQZmhU?=
 =?utf-8?B?VlA2QVowbTQ5cmpyclVvNU1IVEl2YTdXc2I1c2xOQ20xbUkyRnFTRGlqU0Vv?=
 =?utf-8?B?UG10OC9HVmJCMmRHbDB6Z09abnpyMmVvOWFYK1ZSQng0UzhMQithYUg2MmFt?=
 =?utf-8?B?eW5OMnB3V2E1YkUrQ2hWR3FQbkc3SXhIUk50d2hWQVF0N3dIbGhocUFscWxZ?=
 =?utf-8?B?ZFV1N0NRMTBsRUJOZitoZXl1Z2tLNVNIdEJkdFIwbzk2c2IwaVhiVURpTGZ4?=
 =?utf-8?B?OEtEZDhCNWdXU1VvMTdvQTlMWU1FcHFFNzNSR3VDazJhc1pmbWpZMFAvdkcz?=
 =?utf-8?B?T01BYmtobmxrdEV1WlhxdTJ1WEVidWZjWjNXVFZST3dQK2hhall3bkJtdENn?=
 =?utf-8?B?bEo5T2swU3E1QmhTRWZKL3ZUR1FhOHBMOCtXejJkdnFEdGFoVDNwUkYrajgv?=
 =?utf-8?B?ZWdhQW93YkYrRitrZlNNanN2ZUVuOUJaNlM3TERmL2Y2K1B0d2RoNlVhM2Js?=
 =?utf-8?B?d2pEZWRDYUdNeTBPVDU5bFFJYVpseDhQUkNIUi9qcmI5UTFZWXllVVpaL29X?=
 =?utf-8?B?SkZWWmVadzVmb1hmdkNZandjU2RaalRmSG54Vk55V1lHZVo2cUErVHhsUFVI?=
 =?utf-8?B?SXhFOEVGblU5WUlUcklJWGUvVkpyY1J1Tzg5UWhyNldmcUl1T1JrejdFamw0?=
 =?utf-8?B?RllWWlJZSWVrdm5Zc1dnRkVnMVNrWDFKMHVHZFEwUVJpNVpqRGQ1ODR5QlYx?=
 =?utf-8?B?eUxRSWI0ZEdPc3lNOXB3ZlhXSDRrMDZEQ3JacDBtVDhRN1A2cEpTaU0vSkdL?=
 =?utf-8?B?V3Y5a0dJMVhSMjF6a2I5bTRRcG5EYmgvOC8zSnhkN3cyRVB2VXJ3cWE2aklU?=
 =?utf-8?B?M05vWStBSGRNZXhOWlZqNllFSHF3bzhtNWkyN1ljK0I2UEhlM0RnYVQreGlr?=
 =?utf-8?B?Rk9yczc4S09KZU5LbVNROG1JNG1CTHVkY2psNGJmRDM4NWgrUzVudm5YVzFo?=
 =?utf-8?Q?Syoh3nNGQ7T4MOh2F0uAf/7CM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9770a59e-5ee1-40de-02ae-08dd024c8119
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 12:29:36.4551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zXR9Jcy5DbH3AePMAfZCXqBhrNRGQBBJYQuKzsnNrz8NnnnXnFnnhQdD4CIbZvTifXq2Xej2tlRChgWrJ2ytA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

--------------a9ATPHjc1E9uXhJtiOeEigam
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-11-10 21:46, Srinivasan Shanmugam wrote:
> This patch adds the missing parameter descriptors to the functions
> vcn_v4_0_3 _start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1104: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_start'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1310: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_stop'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1545: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_set_unified_ring_funcs'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1732: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_set_irq_funcs'
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index aa06b2fdeb7a..af351f12c17b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1097,6 +1097,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
>    * vcn_v4_0_3_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: VCN instance index to be started
>    *
>    * Start VCN block
>    */
> @@ -1303,6 +1304,7 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_3_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: VCN instance index to be stopped
>    *
>    * Stop VCN block
>    */
> @@ -1538,6 +1540,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>    * vcn_v4_0_3_set_unified_ring_funcs - set unified ring functions
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block for which to set the ring functions
>    *
>    * Set unified ring functions
>    */
> @@ -1725,6 +1728,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
>    * vcn_v4_0_3_set_irq_funcs - set VCN block interrupt irq functions
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block for which to set the IRQ functions
>    *
>    * Set VCN block interrupt irq functions
>    */
--------------a9ATPHjc1E9uXhJtiOeEigam
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-11-10 21:46, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241111024612.1881727-2-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch adds the missing parameter descriptors to the functions
vcn_v4_0_3 _start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1104: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_start'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1310: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_stop'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1545: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_set_unified_ring_funcs'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1732: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_set_irq_funcs'

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <div tabindex="0" aria-label="Message body" class="XbIp4 jmmB7 GNqVo allowTextSelection OuGoX" id="UniqueMessageBody_29">
      <div>
        <div>
          <div>
            <p><font size="3" face="Times New Roman"><span style="font-size:12pt;"><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody">Reviewed-by</span>:
                      Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="0" id="LPlnk671546">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></span></font></p>
          </div>
        </div>
      </div>
    </div>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20241111024612.1881727-2-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index aa06b2fdeb7a..af351f12c17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1097,6 +1097,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
  * vcn_v4_0_3_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be started
  *
  * Start VCN block
  */
@@ -1303,6 +1304,7 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_3_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be stopped
  *
  * Stop VCN block
  */
@@ -1538,6 +1540,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
  * vcn_v4_0_3_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the ring functions
  *
  * Set unified ring functions
  */
@@ -1725,6 +1728,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
  * vcn_v4_0_3_set_irq_funcs - set VCN block interrupt irq functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the IRQ functions
  *
  * Set VCN block interrupt irq functions
  */
</pre>
    </blockquote>
  </body>
</html>

--------------a9ATPHjc1E9uXhJtiOeEigam--
