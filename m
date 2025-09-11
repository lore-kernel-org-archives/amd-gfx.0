Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECF4CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDC010E38A;
	Thu, 11 Sep 2025 14:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VBbHJPyA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AC610E38A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj5yGyx6XE93248hkRbzZq5UIVZMpz0MyeqXFGWynuZJv0WQ2W38cNm/5HI5cRjLY+FyJTRh0PsazAfcXopylkIm1dnoSFSnTTx0NvL1U8MdqrAlD2Gr75VtfEtHBKZhFtDr8AqwBDjqaLAKphHES94ZKO9LALs5c5h6Usho+uKAilMfqeieXrw5cnErqq0aEviONhcNavzb8kx9RShZshzPBya0fJ5XG9YXSkUc/UDz2n1Dj6xBU4jboB1Dim0a6ZtYLAnaSiGc65nBdo7/k1Yhumkc3FciXEe4AqFLK8mvEH0wbIezmMgpXfGTsAt4f8IuP/1zPZk+4sVeFnrc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BiUX7rRWk2I4NnFFa69XZmHV71XFxxYSxD4Ubxh1RE=;
 b=wgar5bzxnenm4oGgZK937uXqWn+U6crBNj/T+nOq2qSHnM9rc8MKFYkxAWwmuY2ufpAiGzYHcv+kHFpnVRJgNwfREmQJdud1+uee9R6oSiUDJdk7gRlmyXfQr+9aaJWKoemAjSyLOP88q//4B3/OUDFPhHGmnG8rs9OAcLnmnZ9ba5stg3nlsFl0XdYFa9k1rVufr8faDRnXZ0m76H8n0mxCtWjd788ohCeiyBueaR7viCwk26FaZrvCk03DG69qLwAuwKEJe7uLt/tjdPvN3f/2nZ5hx4S6PtjqojxDkhn3ygM3Flc28R0057qA/QBvcKSike3A1vL0/40Rgxlncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BiUX7rRWk2I4NnFFa69XZmHV71XFxxYSxD4Ubxh1RE=;
 b=VBbHJPyAfCQ7khyl+Hgi/Alwq4ilxm5owAUhqIbscqIJ8I/ih5sc1yyyLZSkmrJvRkp53q6boAX+S4L1S8VpYp7kqdZNO1AeBVp83NvidXOOHjm4rzPGGj945WYFu3OaUOC3OrVA8TH7cwUtskjnHZXwaLcxjL1+bw8oQNW/7B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:48:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:48:54 +0000
Message-ID: <70b92bff-727a-4e30-a8aa-933c115ec9c6@amd.com>
Date: Thu, 11 Sep 2025 16:48:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] drm/amdgpu/dma-buf: Treat MMIO_REMAP as fixed
 I/O; don't move it
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
 <20250911143815.825607-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250911143815.825607-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0417.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fcd160-448f-47d6-1ccc-08ddf1425450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVczZlpHVnplN0RTMWEra0k1dmwxOEV0TnE4b3hWZWJhd2JJc3dTZzJ3Umpi?=
 =?utf-8?B?UEp6azRrS0o3Rml2SXVHTWt0ZHd6MWVRNzBpUUhvK0pjQ3QzUTBNQzk0K1I1?=
 =?utf-8?B?UE9EeDBPZXV1YnpMNXZNYm5ZdWFjTTFmSk9Tekd6Um9wR05nclBGSm4wRCtD?=
 =?utf-8?B?WUgxSWxYKzhMTXVML2NRYm9LbTRTcnQwNFBCZk9iRVBGRk1rclZqYitUenJE?=
 =?utf-8?B?bkIwbi9pU0hGMEpLQTZQR1VFR2VsdWxLWWZGUDhWSWxzZTQ1cGFobUdaQnJN?=
 =?utf-8?B?S090Q2JXejhCQTRSUnlSN0tZT1RwdGJuSmpwTWJ1LzRWZjVzeUZrbGdRdXhh?=
 =?utf-8?B?VTZmcUNibG55SEZBZzh1a1NGaXg0SEZac3pBL2pqN0NrSjFFR043M3lPdzR0?=
 =?utf-8?B?eURGcExqZ1YvaGE4VVl6SGYrUlJpdG9EUW9RdkRMKzVNWkFmVmxPWWF0SXA4?=
 =?utf-8?B?aVFscGtrNGQ0K1l3dUdtMXk3THY1bFZ1UnUwa0pPM2JLU011eHptazNZMXln?=
 =?utf-8?B?cmtDNVAxT29JYVZ0NS95WHVPWWlEZ1hEZ3p0amgyTlFhZjRiU3ZCOTdjd21l?=
 =?utf-8?B?VzFMcmFXVWk4TGZrT0lrTVpWVUY2RDhKV3RIb3ZubnVDUTFiM0s0UHBGU2Rx?=
 =?utf-8?B?bml0RXVlMG0rOXd1LzlnMGlwV2NKR295QUlqNTVaNHdITzhXNGhNVWpaUlZx?=
 =?utf-8?B?eTVvcUFKdS9acURmTlZKZ1BraHlSUW1Xd2Fyc2Y1dmZhdnh5QlFVeDcvdlFC?=
 =?utf-8?B?TmNkandqeU5LOVlKMndjTXA0dGcxQ095T1NjOFZlZ0l3eDhjb3NDbndpTnVV?=
 =?utf-8?B?UnIrOFFubmQ4NDJHU1JKYVhMNXlKbWlyQjhUUHF5bjJvRXhwNENwck1Sd0JF?=
 =?utf-8?B?c05hTTBZd0F6alFqa2FJbXBEQk11M3dBS3E0YXdDcHUzM1dCdjVWSS9VcmxH?=
 =?utf-8?B?eUhSQlp5bUswNTh6dVI0bHFQVEpCUm1zQU9XUnNwcDhDdmI1eS9lRldTR0lY?=
 =?utf-8?B?OXRGTG9mVzVPUUNLQVNGQlh4Uyt6Ly9NTGVZb2RUd0lDN0VSR3RVUzlTQUxp?=
 =?utf-8?B?SVNtb0dvdkVXMlo4eWN4YURpelVCWmowVWI5TzN1cGx3aVZsTDE0OGxBdU9h?=
 =?utf-8?B?aklhVXltRFI1SXpRUWFOemdOY1pRaFJZZmdJdmdSSXBZdmR3YmI1cGJBRzJE?=
 =?utf-8?B?cS9Od1l4ZVVpYmVueFRjbzRrNW9wVFZwODZxTlU5QlVhWGo4M2s5VWNwK285?=
 =?utf-8?B?R2VMUnRiQTBFakE0NlMrSjk3NEtXL3NYcW5MN2h4YmExRE1IaVFqSmtTUSt1?=
 =?utf-8?B?QnFoVlFWbGRhaW5JZU1mdW9oMHBxaS9yVXpDYnpnQ2xnZnNxSkZBTDVWSmdW?=
 =?utf-8?B?VFBUZzVZR3BncU9xS2FFMkJUNXV3clQ4YmtQMEIvMURUZkdsV2F5RW5VT0Jq?=
 =?utf-8?B?Q0xJMThMQzNJc25PTDJOY2JpbWRnVWZjOVVZd0xVcml0MnpOVjFFamFIOWFB?=
 =?utf-8?B?NytBN2FHd21sYlE5MCtmd3Y3M1NRTUFEeThRZzc5T2xoT0ZaZkJQbVBlRHB4?=
 =?utf-8?B?bEhoWEVta0JjMnk3TXVXZjY2TkkydkRJdy8zM1lsL3NVdzNobW90eFBQdnQ5?=
 =?utf-8?B?c2g3NEprQWtuUlhpZTY0MUt3RUZuSnVFQUo3QVJOeUVuaWRScnByN0VXeUx6?=
 =?utf-8?B?eW9EcjBPODFkTFM1L0VjcHBnVzdkY3BxUmNWMjg4amNWTDArTXlURzJSR0t1?=
 =?utf-8?B?L085TXNscmhSbS9yRnJNSUtiWnZVZHlBY2RoaG5SRkFYQ3M3SXZleS9pMmk4?=
 =?utf-8?B?bzVCYXJUMEVsWDRIMUd6YmR3VVhyaFhkcFdpRVFvZjVyblNiRWVNRVdDZ1Vq?=
 =?utf-8?B?UzJtdFFXNzBIdVdWamF5bkFFazZER1loQWNwSUE2TUdCZDFwdzhhVzZlS0ZL?=
 =?utf-8?Q?37v43n51xmc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0xGd0dycFFSMUNQVUltUDEwYlhVcUdXdjQ2TEhRMS94QmYxZVlOZlE4SkQw?=
 =?utf-8?B?QmN2U1ZXeElhbkZYQU9PYmlKL1NGT2VycmFNT0ptaC9jRlNDZkhTZURiVEd5?=
 =?utf-8?B?a1V6WTBoN2NPemJNeUQzakdwZmUwSFdmcU9seDV3K2p5TjFDY3ZOL2tucWdz?=
 =?utf-8?B?YUZZb3hDaE15NnU3UHNEWEtySHp0bStNUXlyZ1pFT2haZWZLSlR5UmxhTVlq?=
 =?utf-8?B?R1dDYnlxSHFVellmNlhmOUJ6R1p0MTNxN1pPTzBDTXBaS1ZZUWtrc0ZmOVFp?=
 =?utf-8?B?aWRUb2R0MkN3YjhrNzVlOFZOTFIyeDlYK0twMXVmVm9iaFM2MjBQcWUxeUJD?=
 =?utf-8?B?SE9lV01HaU92ZmdhZ0hBVFNKM3p0aEdBRzhDbWNFdHpSOHp4c2RJNit6YVYv?=
 =?utf-8?B?OElRZlV6R3g1MHBwNTJnQ2hJeHVLRTBUeWdMMEpROXhZSnYwdm1IandFRGsz?=
 =?utf-8?B?OXR5MjJIaUtySkFrcFpQUGRBSzFySURoYVpxRk5rUTZ3R3JSZlBPYVBNVS83?=
 =?utf-8?B?a3RDVXZ5bFpUeXZpL1BONXNQZ3BIUUgwdWNBZlRLeVlrNFpBWXYvVjFTcjBl?=
 =?utf-8?B?K2NUbHp5VFpMQ2hRSkJHWE5TSXRuNzdydlRlNksrSy9RQzBaNWM1ODl3UjJx?=
 =?utf-8?B?Q2lOWEh6RmtzK3c0V0dnZlR6V1puVlN3SGN6SVBKUnA2UWJPMkc1bTZQd0Np?=
 =?utf-8?B?d014a2JjcUFEQ0MyM0lGdHA3clVoYldkd2F0b2ExUGxvTGJrNEZBMFlEa1Nh?=
 =?utf-8?B?djBwTUNNNng4bUVZOVFpYk81VkJqaDF1TnBZcW05QWw3SDEwWEpDbGFOWU1R?=
 =?utf-8?B?T1RERkxZb1pDV0NZckQ4MFRENjRkV3hoaGtYd2JmVEs0eGxsY3M4UDlJNDVl?=
 =?utf-8?B?aFJjVmRGNE5YMUJaeFNYdFlKYytscUV5Ty9SSFh2ODVqalRyR0ozOUx0MC9L?=
 =?utf-8?B?ZHh4M21FQWxoanBaZ0l5MzdhTnlzS1ltQzhOemZmQzhpU3BuZ0ZxaVh2aTVw?=
 =?utf-8?B?cFJ5VmdBU1FST1EvRncyRWxaZDkwb0RQakErMG42aGtGakwwNlIrYlN4ZmVX?=
 =?utf-8?B?S2FGZXhkWmhXWnYyb0kyZm9SalQ2NEVtdnpuWXNPc2JSRlJoQ0d4RUNpVVFH?=
 =?utf-8?B?NFY0cldISWI5cVlPOUExMXhpOUdZMElSQ1BUSWllNVphSWJ1OW9HNFd6cUFk?=
 =?utf-8?B?ampMdnpWQmRtMlpPTkd3aVcrMjJSSVZpZC91ekl2M3VYcHBtMkxvSHdnNGhN?=
 =?utf-8?B?OTZMWDlCc3FlYkVZbmZMWEdiVzVPMXFMYjVxTWxlK0ovVTI0MmxaNWNKY3Jp?=
 =?utf-8?B?WGhvdFZzazU4NUE2SEJFRTNzOUlITjZlOWNtd3ovWHYxeGk2c1VWaWk5eXFZ?=
 =?utf-8?B?aVo0Q0dFOU1GY3dDK0JmbU5DUDBLWjRrMkhEVlF2dnlrb29XTlhwRkNHVmR3?=
 =?utf-8?B?L0xxbXR1MXZBakcxOUZRVllYZ2VlWnBrYndxOW5XODZTN1g0dW5Sa3Z5MXlw?=
 =?utf-8?B?aHdIcGxsRHhzZlgzb2QzZVBWZk1lVnd3YXpybWdQbC82cGJtK2lpUis5eWJH?=
 =?utf-8?B?eVk4QXZNd24vMHpqUUIwTC9CdllOT1dDcUxHNlpZZ0M0a2M4OXJyK0xVU0dE?=
 =?utf-8?B?YXp4eUN1SVhaNktWMEJiSWpYNlNFVzJPc2dKU1V0YTU2d3loK2duWVpzM1dL?=
 =?utf-8?B?NlNnUXIxbjVYT1pJVnFpcjljZFBQZHZHQ2F6S0h0NnNTWWRLekIrMElxdGZa?=
 =?utf-8?B?RFhFeU5LQlRGNlVJQ1NWSy84dlAxUWJFbkt2UnJMcDFGV1BZYkh3U2N6QWdZ?=
 =?utf-8?B?bFZGUnpqQlBzYXVBelVWSExkakJHN2pNajZ5NlNVdmdBL1p1UDlsYWZuZGhQ?=
 =?utf-8?B?Y3RDWVNMWXFWMGFZenNJSVJXb1lBMU5jR1lRcHNuT0Y3dC9yUTdRdXR2MjRI?=
 =?utf-8?B?WlcyclgrblRJZitKWDFjb1hvbzNxbk9DRUNsSTgzNnU5NnprcFVOT25jcFc2?=
 =?utf-8?B?eTROM2JCbTdTMHp0cjhFZDU2V3ZRMmxsYzJ3SDdFdHJDQzJHWndLRXIwalZn?=
 =?utf-8?B?UjdETThibVpMOTQ5QmtjVTc3eVVEcHRNYyttaW82SGpvQ3YreU1FUnJZbi9k?=
 =?utf-8?Q?mK3n8cpf+DApEFkPt4AB0DsMH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fcd160-448f-47d6-1ccc-08ddf1425450
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:48:54.2793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGsWpRTgnbKEWYroi1CIAbfVtmSwjxWQNvJF3eK/L4n3xWnme/Ej169pBY87KJAv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
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

On 11.09.25 16:38, Srinivasan Shanmugam wrote:
> The HDP flush page (AMDGPU_PL_MMIO_REMAP) is an MMIO window, not RAM.
> It must not be migrated to GTT/VRAM by dma-buf paths.
> 
> This change makes pin/unpin no-ops for MMIO_REMAP and skips CPU-access
> migration, keeping the object fixed.

Just use ttm_bo_pin() while creating the BO, no need to modify anything here.

Regards,
Christian.

> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 31d78561ab95..4c75e296b57f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -109,6 +109,11 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>  	struct amdgpu_bo *bo = gem_to_amdgpu_bo(dmabuf->priv);
>  	u32 domains = bo->allowed_domains;
>  
> +	/* Already pinned at export; don't try to move I/O apertures */
> +	if (bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
> +		return 0;
> +
>  	dma_resv_assert_held(dmabuf->resv);
>  
>  	/* Try pinning into VRAM to allow P2P with RDMA NICs without ODP
> @@ -148,6 +153,10 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
>  	struct drm_gem_object *obj = attach->dmabuf->priv;
>  	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>  
> +	if (bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
> +		return;
> +
>  	amdgpu_bo_unpin(bo);
>  }
>  
> @@ -354,6 +363,11 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
>  	bool reads = (direction == DMA_BIDIRECTIONAL ||
>  		      direction == DMA_FROM_DEVICE);
>  
> +	/* Never migrate MMIO_REMAP for CPU access heuristics */
> +	if (bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
> +		return 0;
> +
>  	if (!reads || !(domain & AMDGPU_GEM_DOMAIN_GTT))
>  		return 0;
>  

