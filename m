Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE95D10390
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 09:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020AA10E51F;
	Wed, 26 Nov 2025 09:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="whVknjxp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E958010E51F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 09:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFWNLR+1jw9+ivpairYmLxPVA3Iae1QnK3Ww8IrRT0ipVPxtIeHP5ujWH0emMQ5OHd4xsnxYrUv6t3JWqzwq1MT5N5ZFIjFWmDtK+ST7vnxVRncMSjMt0OV+i1aV8J33E6lworoqXx6grP2KYgA0RPP3QE39WRcvOjHHFYqN/8vBRNpcA0nyZ8OAoGPuh3l2/GJx2yESKldRpMl9Uk4vJbVaj2dxZAJc6Vngg/YfFNE9n0JlAwFklZ44t7yrKQZVRAyppXo39chXPV4+WkhyX1IPC8Qa4mxilPSEhIf2ii1uZRwIISwWZn0cnpusndiRAMeHM0QPFXBSTNJAsU2OGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWhGWcA2F/jbOxG7xJ7cy8WhbEMOhpzm7n4j4lliSLM=;
 b=Fju3QRhuvc7dLv39EMlZ6w9xC73scQx5JkkeuceMbpXoa/8vuXh/DV+yZ98gFCUJXtEAyQMGVuD8wGkY+CxcJBUrKQdIQUStpY8WZ3VIlWzf6k4lnbwImHIMBpWfnzOA8QQ+roQS30lOeJMoy/RhIYgFQhIPBLoOLREF960aM9d/u4/xqO/scIblTeFC3zKyspujd1AgUMu2Sy212pXQj3mFFEigWGFxPll7GHlZVZRVCRt/9GUla4INE4/asdT3Fd9r2Hm2qvXyaMflVymBEs44PlZpMnn1O+FtomFsfA2SsCV0pZYahTrbd5ju1I9kCpoKjZcagxFT23mqvRnEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWhGWcA2F/jbOxG7xJ7cy8WhbEMOhpzm7n4j4lliSLM=;
 b=whVknjxpaV8cKWSzekTNsWp9XXURp9UXT8Ge752fLX7oBc2aYyAYQoua4nHzd53M5KLpY8RRQwXaNEt0h3KqRRAfTfjtpQU248LnDO9FnWWpCD4k3+EnF1kYpShzxYFThtz1VCRZtjDCtY9be9Hd7XzZndWEBfuobraL5jHh3ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 09:00:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 09:00:31 +0000
Message-ID: <bf5b44d7-f7be-4d9a-aa3d-c2754d55fe80@amd.com>
Date: Wed, 26 Nov 2025 10:00:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Treat MMIO_REMAP BOs as linear in
 amdgpu_bo_set/_get_tiling_flags() v2
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251125053634.219308-1-srinivasan.shanmugam@amd.com>
 <20251125164345.224298-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251125164345.224298-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: b4938f71-d6f5-4cf4-5627-08de2cca405a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzNVa2Q0S2lwd1RDOEpLdHVsOVdCYXlQRi82UTFJMnlrMWpyK28vZGU0N2Yw?=
 =?utf-8?B?dCtTWTFBVjhRbERjQ1FkdEt1NEkwSGd4a0MrWXVGYWcyNWJyam50b2E0Vm5W?=
 =?utf-8?B?akpBN2ZBY0gzTXZZckZPSk40aG5Yb0x3NERvN0kwUzdEbjVoRDE2K1UraGlE?=
 =?utf-8?B?UU1SS0loWWVCSDdUM2pXRUtkVDRrdEFDN3o3YXpGNzVNaXZzUyt1L01sajVH?=
 =?utf-8?B?R0xmQTN5N29rZWNJaEE4N3NORVM5THMxQ3lMVGw1NGlHS3pCdjNJeDlLNG5P?=
 =?utf-8?B?a3d0djk3Wlkrc1FOdCtVRE43SmpyZExYRHFFOE51NEVXN1krb29lek9uNE4v?=
 =?utf-8?B?SnNvRHNCZnJSUCtLQUlJaHIwdjhVeWdHY0FuTzVRMC84NUI2N1A1aFJKQmVz?=
 =?utf-8?B?dVhqTG4vWkVaSVpINHBOZ3UremcvWmxoc3JNYWthREw0NUtOMit5UTdFTk1z?=
 =?utf-8?B?RXFGRDRQblNMWFFGdnNDOFFrMTJJa3Y2REh1ZmJrclFzVG1sYzBBVnJCQmlF?=
 =?utf-8?B?aGxwZ0xzbm1GbU9NeUZoMnViUThxdDBDMmZ1dTJOb1FDbUZnaDgyaXd3WkZ1?=
 =?utf-8?B?djc5TUkzT2I4NThHeDRQaFdvUkJrUjYzUTgwVDFEazJXREwrNjZTc1YzVCtL?=
 =?utf-8?B?a2IwWEQwNzRKUUVPaVcwdS9tTk9pcUtmUUN6MTdaSGJNLzlUbGFpTVY4MzlF?=
 =?utf-8?B?eHNpbXRhODduZUU0SitQaW55TXVCcWdMZmtwTEpvKzZ2NGU5Vk5ickx5UnZ2?=
 =?utf-8?B?K28wOVZzVUJyc2RXYitnUTNMYWpiTUZDVXVtZ0JEbk5sWlZZUDBWNS9BTHBH?=
 =?utf-8?B?aDdNQTd1Q2Z2RVBvTUxwWDhRZWZGcU1yL0xRYS92WlNweUwrY29BbGJMWXh3?=
 =?utf-8?B?ZG9mQzJpS0ZHRndKV2JmcmwzQzJiZnEwNmJndTdUL1ZGaUozMmNCbDd0SG16?=
 =?utf-8?B?VkNsRTdSNmI3OFpxWWF2ZUxKMStJcDNIVnZLQUo1RkE2aW1uUGpnSFpBR2FW?=
 =?utf-8?B?Tk9nR2NXY0ZxUERWUEUrMlV6bXNtcFpFWFZvNlN2NVY5RHhpb3FBalA4Smpo?=
 =?utf-8?B?TURyV2FOZHN5N3ZpMWxHMDgycERPeSttVnJqUVRuTE5MbzNHWW9URmtIcFhz?=
 =?utf-8?B?bnY1SjdVcW5LOStzTklZMU1FMmJ6MjJZR1ZOcWFleWZwS2lkemt3Ky9oSkls?=
 =?utf-8?B?OU9DYVcxL3IzZ3hMaGtSRzR6MkUrelg5VGxpK3UwbkxBbE13Vk5FektsaDRi?=
 =?utf-8?B?TkNVaTV0K2liT3FGOWQvemFDclExVDFpK1h5Z2xFejRaeG00RnZ3dDVXVGZJ?=
 =?utf-8?B?ZjExM0NueFJVcm1vblJHeC9CbUVyMVJYOVVTcW1pR0wwVE5OSFlnYkZkSThq?=
 =?utf-8?B?SEdMQWZLT290WTdRZ1pUckZNeW8vOGkwelI5MndWbXlkQk52TVRFYUVDQ2h2?=
 =?utf-8?B?clJjZG5KQnVhSklIMldrcUhxMXNxdnExVmZFZ2xmS3IxR1BoMDhKUEpYUzhF?=
 =?utf-8?B?ZWtmbHVneFh5RDdJQWVjYzA4SUhiRWxzT0NQVEhkZGpQZWdEN3U2RE4rei9U?=
 =?utf-8?B?NDNOcEcxRWh5Zk5FVWJiR05zam12RmpqZEQ5emJFWWc1VHpYdnI3TEppanBi?=
 =?utf-8?B?VmUyUzVzdlhvc25xalN1WW9RSFRVQ3hzUWlpL1ptTHJHcHB5Yi9JTDYzOEtw?=
 =?utf-8?B?MDNnUGVYWjRZWVZHbGJvTmswcFh0MTl3VXV4c1ZYVU9oR0k0OSttek1kTXU3?=
 =?utf-8?B?SEhQUUdYU0JlblZ0TTRjM1UvdlRHTUNOOG14eEpxanZnOStGcFJMUXNHVlZE?=
 =?utf-8?B?Y0VCOXJKM09yNjQ5TGJjZE83dEJxQkRCeHdtOGlsMjE0MFlXZ3N3ZFdjNFBN?=
 =?utf-8?B?VUJSa1lSNmF0eVVjcjJrdk9xc3ByZUw0NlJqQ1RSSFZQWEluaXBWTi8zb2l5?=
 =?utf-8?Q?B5o8hxCKo6RV1dj4o9n7Jm2MTlKHVVLB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2RqL2xmM3EvcGlTeSs1bnlWNVBCb29VUnBtRVE0Z0JWSG5HVDZ2UXFnMkwy?=
 =?utf-8?B?bVhQRlRQeE5VekdqN09aamVZVVBERnNVY2RQZGNEVU1IWjkzU016eG1sUXU2?=
 =?utf-8?B?SmhiMDAyUmc4VE44YlBkYVZVZVNYejFwNUJnOGRWamZ3TUpaMFdVeGcyMlRm?=
 =?utf-8?B?T290bVRTRjNHVUdyMHJmU0ZNRnFiSWdiZkI0TjdPOU4rT0JzNUdOdG1tQUJa?=
 =?utf-8?B?T0ovVm9DeWJidytlMlZBM0swWUx6ZFMySXlwVWJsWGROQkxyRnZMU3I1d3lT?=
 =?utf-8?B?ODNXNTVWRlBHQXRTeWJ0a2sxZkZiNHdsaHlZTnQyeFdFMnpKNEk0WVVONnBU?=
 =?utf-8?B?N1d4azFLN3BZcEZrWGxVS0lwN1E3TnJEL1R1VWV1anZldldteGhFMVhWRG5m?=
 =?utf-8?B?cnN5ZTA0M1E5S2N4V2hxYTExbGZ2QWZjdWc5Y1FVYVFlZ0R6eUdzdzNuT3BB?=
 =?utf-8?B?K2pMN3lCaXBBTlN2cUFZM2tqalBrRFR0U1hUUE1aWnFYMUlaRWg4QW5FdUlz?=
 =?utf-8?B?dUZWQ2d5TnlXOEQ5eXZDVk13ZzJnN29XZDlHZzBBd1pST0pNYVd4b0xBTnJZ?=
 =?utf-8?B?V0F4QUVyc3J3U3Q4MVR6TGdZTXhzc1pQazFrSlpCUGVyL3NiTS9vWUd4Ni9a?=
 =?utf-8?B?bG5RU05tbmZsdk9ITngvL1ptWFBUQ2NudWI3VWE5WGxNdjBTNUVocjR1QVNa?=
 =?utf-8?B?QnVOeUpETDhSNlMya3VrVDBtbEQzb1ZxQlpJcy9BMmplNmZGUG5oUmVoZXU5?=
 =?utf-8?B?U0pzeDVpU2lIdHFCUlNldktVTWZjTnBBOHNjN1k4RmVYb0RmbmNwVlpvV0Vq?=
 =?utf-8?B?ZHR1SXMvS1I0NW8wS1l2dHZXQWNXVWQvd2hCUjNiSy9sRTdhbDE3WitXTU1Z?=
 =?utf-8?B?dTVTenRJaTBBWFBZZXp0VDVEN3RpelpONFRnT0k0bmhHRXMyU1NFUm1aRElW?=
 =?utf-8?B?S1FvQWZ1OTlJYnF0c2p4cFVSNUpGUFU3VW5HUDVuTnRBYXRNTlFOUk1VNGFq?=
 =?utf-8?B?SWVwVjZyVVJNbXh6Z0g2RzFOWUZlVjR4ZWNMdkRXTEhqSk1YZTZYNlFsM2x6?=
 =?utf-8?B?ekRTRCtmRnZyQ2V4L0xwV0JzVlFHcm1CYmtydGo0dGxsZEM4U1EwMnhyNWox?=
 =?utf-8?B?NUxWUmkrNTVrb3U2VDEvRkc5R01kekpxQnhXNlNjZDhEWUI5ODJPeFZHbFR1?=
 =?utf-8?B?T25yWjlJcERRRExIUmRHZ3VZS1dialJGNjNXSnNwNnN1SVFPMEM1MG5DbGV5?=
 =?utf-8?B?dGZNR2hicXlrMHN0MGd6cmxrcGVZVnBsSWswNHJPSnZBM0MxL3JHb2w5b3ZI?=
 =?utf-8?B?VE5FUXhLTEJTSEx1ZytiREpsRVpxWDVMRXYzQ2FRQjZ2ZnFIVmFVVlQxeTFn?=
 =?utf-8?B?MjdnVDFLRzdBTkdKazB6MkVPUjZBakdHS2J2U2c2T3JiQzY5WitiVXNYZGRk?=
 =?utf-8?B?cXN0bmFkc2U0cGRwTUtweEhoWjZKWVg0d1JUTnJSaUJrdVFFcE11QngxV1U4?=
 =?utf-8?B?ZnByWjdyMVViTmJGOGhGNEZoYVA5QkFWTHJiU3dFYU04Yk9BM3FLTElLYVBJ?=
 =?utf-8?B?K3N1ZzdLS24rbEVNQ00rM1BsenNmNThicFgwTVJWc2QyYWhpUW5DUXVIcCt4?=
 =?utf-8?B?YlNaaEJBc1ZIZXNNMHR2NHFQZ2NIQTVMZjRrbDY2M2J0bllTQmpza1pZRHJ6?=
 =?utf-8?B?RXdNT0w2TlMxZ1JIaitOYUtPZ2tBVWdwYVB6MjE0OEZMM0dtVi9QZnpyMFhi?=
 =?utf-8?B?Z0lvVzhZcFNHUU5RNmVVaVV4cTV3VzlScHRxQzFuUVY4Q2EwbkpEUGozU0cz?=
 =?utf-8?B?ZEkwYUVBVGpiam1KeHFTZjNJSzhFb1VGUjdoTFgwcGl2MkRWYU15SmhrS2hm?=
 =?utf-8?B?cEZmY0ZlTEFJRmRjMkcrbmt4SzlVRFpZa1JpVXVFY0Z2RnFzMDhlbThaTlYx?=
 =?utf-8?B?SXAxQWRseTJqVjFqL05sckxvaklsMzhVRko5Sm11Q2RpVUo0eXJYOThOd3F1?=
 =?utf-8?B?R3A3WXpTNkg3WnNvNnRXNGQ0UjVDU2ovaVVUcStBdUZucXlwajZ0MTZGYzND?=
 =?utf-8?B?QlhKa0JEVjUwSUZBVG15dllxQmVqQk9tYXRqQmtXUE04UlA2U0E4VXFIb0tP?=
 =?utf-8?Q?ndT0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4938f71-d6f5-4cf4-5627-08de2cca405a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 09:00:31.1096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tumeSh0ZYtXChOuS2A4+fv3XdeqNM7dJXNMhrQUktcDe1GMmVFesmxCwFkzl07Fw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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

On 11/25/25 17:43, Srinivasan Shanmugam wrote:
> MMIO_REMAP BOs are created for HDP flush and device<->device MMIO
> mapping.  They are backed by a TTM resource with mem_type ==
> AMDGPU_PL_MMIO_REMAP and are allocated as a plain struct amdgpu_bo, not
> as struct amdgpu_bo_user.
> 
> When such a BO is exported as a dma-buf and imported back, userspace can
> still issue DRM_IOCTL_AMDGPU_GEM_METADATA on it. That ioctl calls
> amdgpu_bo_get_tiling_flags(), which unconditionally casts the BO to
> struct amdgpu_bo_user and reads ubo->tiling_flags.
> 
> On MMIO_REMAP BOs this leads to a slab-out-of-bounds read. KASAN reports:
> 
>   BUG: KASAN: slab-out-of-bounds in amdgpu_bo_get_tiling_flags+0xbc/0xd0 [amdgpu]
>   Read of size 8 at addr ffff8881a19a9ab8 by task amd_bo/4574
> 
>   The buggy address is located 0 bytes to the right of
>   allocated 696-byte region [ffff8881a19a9800, ffff8881a19a9ab8)
>   which belongs to the cache kmalloc-1k of size 1024
> 
> Using gdb shows that the faulting load is the tiling_flags access:
> 
>   (gdb) list *amdgpu_bo_get_tiling_flags+0xbc
>     1150  BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
>     1151  dma_resv_assert_held(bo->tbo.base.resv);
>     1152  ubo = to_amdgpu_bo_user(bo);
>     1153
>     1154  if (tiling_flags)
>     1155          *tiling_flags = ubo->tiling_flags;
> 
>   (gdb) p sizeof(struct amdgpu_bo)
>   $1 = 696
> 
>   (gdb) ptype /o struct amdgpu_bo_user
>   ...
>   /*    696      |       8 */    u64 tiling_flags;
>   /*    704      |       8 */    u64 metadata_flags;
>   ...
> 
> So a plain struct amdgpu_bo is exactly 696 (0x2b8) bytes, and in struct
> amdgpu_bo_user the tiling_flags field lives at offset 696.  The
> MMIO_REMAP BO is only a plain struct amdgpu_bo allocated from
> kmalloc-1k; it does not include the larger amdgpu_bo_user layout.  When
> this MMIO_REMAP BO is treated as struct amdgpu_bo_user and the driver
> reads ubo->tiling_flags at +0x2b8, the read happens just past the end of
> the real object, which is what KASAN reports.
> 
> Fix this in the GEM tiling helpers:
> 
>   - In amdgpu_bo_get_tiling_flags(), if bo->tbo.resource exists and
>     mem_type == AMDGPU_PL_MMIO_REMAP, return early and (if requested)
>     report *tiling_flags = 0. MMIO_REMAP BOs are a fixed BAR I/O window and
>     are never tiled, so treating them as linear is correct and avoids
>     touching struct amdgpu_bo_user.
> 
> With these checks in place, the slab-out-of-bounds read is gone.
> 
> v2:
>   - Also guard amdgpu_bo_set_tiling_flags() for MMIO_REMAP and return
>     -EINVAL (Alex/Christian)
> 
> Fixes: 9e903e5bc958 ("drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register window; add TTM sg helpers; wire dma-buf")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 24ebba43a469..6c375f805866 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1126,6 +1126,11 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct amdgpu_bo_user *ubo;
>  
> +	/* MMIO_REMAP is BAR I/O space; tiling does not apply. */
> +	if (bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
> +		return -EINVAL;
> +
>  	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
>  	if (adev->family <= AMDGPU_FAMILY_CZ &&
>  	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
> @@ -1148,6 +1153,19 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
>  {
>  	struct amdgpu_bo_user *ubo;
>  
> +	/*
> +	 * MMIO_REMAP BOs are not real VRAM/GTT memory but a fixed BAR I/O window.
> +	 * They are allocated as plain struct amdgpu_bo, not amdgpu_bo_user.
> +	 * Therefore they have no tiling_flags field, and accessing it would cause
> +	 * a slab-out-of-bounds. Always report tiling = 0 (linear) and return.
> +	 */
> +	if (bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
> +		if (tiling_flags)
> +			*tiling_flags = 0; /* linear layout */
> +		return;
> +	}
> +

That here still needs to abort with an error.

You should probably add the check to the higher level amdgpu_gem_metadata_ioctl function instead and bail out early if somebody tries to get the metadata for the MMIO REMAP BO.

Regards,
Christian.


>  	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
>  	dma_resv_assert_held(bo->tbo.base.resv);
>  	ubo = to_amdgpu_bo_user(bo);

