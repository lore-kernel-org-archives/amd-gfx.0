Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6978CAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 11:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8991010E427;
	Mon, 22 Sep 2025 11:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a9q+62fA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C9910E424
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 11:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyItIvpbRpO7wTaiRks0TtcgbMNyTrhmq86iQ7ToX+BavyQTa3u3zY8qcCO6GuX3Zy7a2wavZCoOxXSOg3ePxbQJSQ5g8BBFNqpcDhEHmRBta9FGbQ7R4zzMfryeRTaO1b0OYzkScfZPVEp5aKFUjv/LfUPcMAv0ASxKHa5DdiI6lPurrcVCWAFsWN9XwDCnX6B4jKblRcbbOnd24TncxwaGgSNXx+vk0Mj61X3BlM99tNnFo2fXIsvShP5KvwEAi2bGyl0ClHY3+yQcNDf3BOPwupZ2mCeTJCmJKN5fOe7769O980QiZo8pyYsKsPcpvGDtTaeaHSMDWNVcqzFRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3pvWOrj4T3sgHf0zWpfTw0vyRiJ9pn7dZhwkt3/fAI=;
 b=EFbqjQFQcYLnw/klVazauTJZJcV6hrM3dIpwwtrxbjbZlpwui41zO2JPPytxDaHY7N2LjQQhHVLOKWz/lam/ZDZAAsLYjqg5aA1d7bLvXFAF8NDq5/LarMiQgk2u/XEEVvD51XGhWTntEnwKmi+vJMxey3aeul7xo9dos/O8gOxoeNqouigfdYB7AOIIWalEn7IR6BQbxrIVSAJpd3a2dl1UAFnO3Y7Ps+nYhAsVILmXymZEkWszPNcMA4J2xCiLPTXQGvo7Zydg799M6rwD/FsRr+Ioq8X/IRO8nk2wZ0gOKKIhiFjca97gt4dNCt5HxoMvGqiDkZyZ9ALSsBiTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3pvWOrj4T3sgHf0zWpfTw0vyRiJ9pn7dZhwkt3/fAI=;
 b=a9q+62fAabMXyMrEIq/j0Z0XKIWowWyrg15XZRLLIwHlLxHCJY43tcx/XL6FeZIFW0P2uEmVXf5PHxn0sf38ecR7QyamwnCFMfq6QLJEA6zqZnMmwjUOLN8Av9WMNF1TYzDK6irChBSBQ2phRAnPskLyFFSbvICp1ihnmAVMA1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 11:26:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 11:26:38 +0000
Message-ID: <65ce5b38-57d2-4b09-97c0-d75ef5b67ace@amd.com>
Date: Mon, 22 Sep 2025 13:26:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu/ttm: Pin 4K MMIO_REMAP Singleton BO at
 Init
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
 <20250912111148.833465-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250912111148.833465-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ff8de4-bd90-4ba2-b58c-08ddf9cae552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2cxcjFRRFFXZU5RVzBYaUFGNElJNlN6a1hRZ1JUaTVXNXJiZ3lQc1VHbW44?=
 =?utf-8?B?Rm9iWGFuTWQwSkJMTkpweFdUQ1ZFbmxIcE5BZTQ2dHdxajllU1lGRk50eHFF?=
 =?utf-8?B?VW9FZ1FmQUsrbmdOZGdzRXREek0zNEl0RFQ3TWhqKzF4YmRRNFpGczN2WkJV?=
 =?utf-8?B?MjdzaURQempkaGhPaE4vL2FuSU9FOUxOcG1qajhCblFlZ2p5eTlxQ044WkVH?=
 =?utf-8?B?N1dtVGRsbmRDMVV5eGpCQlpaaEROcW5xZ1BDNlg4Vm14YkFIN3JRSFVGSUdC?=
 =?utf-8?B?MGxGTmFoeTgxT002NGNveWRqUTgxWWI3enBHMTV3Yys5dTExaTBWTjJVUXUy?=
 =?utf-8?B?aHpGK3FjbEtJajFPRm1BOEFnRHQzanFSMGk2R0hGR2ZtNGpJSndHaWpvQkUx?=
 =?utf-8?B?ODc5REVFcWZaMU5UZmtRcE0yUDVaNHdsSkpITExzVFA5ekc5WWRLRnovbGk1?=
 =?utf-8?B?WUttL2JJaC9Cd0krQjNBc1hhcEhhMFRPVGpLbWRGdEtwM2Q4Q3BLa21uVmFs?=
 =?utf-8?B?Mk1wRnkwcHR2NHptdnY2TEM5dXhCa2JjVjBRZGZ0UFkzR2NzcVo0Vy90NFRm?=
 =?utf-8?B?enFRcVZLSTRlZ20vMEdtVFZaVHg0dEVvWHZnSDRZRHVsVWpmdndhK3lBSlZx?=
 =?utf-8?B?V3UvZzBodTVTM3d4RmkzcjJHNjd1dDdjTGsvSGs5Vm1nODI3YmVPL2JIbkVH?=
 =?utf-8?B?VmpycE5MQUVRVGlYN1dRTitLajZrTHJ6T2ZDWkZ6dDk0djkrZTA0dWFmdkxr?=
 =?utf-8?B?QVVER21Za3plUGlpL3BBM3dqMnhOQnFXbnFWTkQxdzh5OGhDTWMzNitwcS9u?=
 =?utf-8?B?bG0rNDZ4TXVPSURQL3RWam8wOThLMDhhYklqd29SWjh2VHc2NlhvVG5JQjFP?=
 =?utf-8?B?TWdFSmVOb0RBRHloSVVMQjRhQlB0Sng0TG5TNTlYaXBxSlAwdjlkdUdBb0FD?=
 =?utf-8?B?eUpwWkRMTFVaY1F1ZmZsNDRIbmRnbGhkc04rL2d2Nmw5cWl1OGJZOHhmYzI2?=
 =?utf-8?B?QmZGVStrK2FuWk83TExHQy8rQnFGb2YrTHRuMnVQd2pnWHJFZ2VGa2RTdWZv?=
 =?utf-8?B?VXE5bDBYM0pxZnFXV1JkRDNyZll2QXVGUFZ1Sk02ZXJ3WUJzK2FGdSt0RXhF?=
 =?utf-8?B?czk4V25jMDM0VFZRMFRCY1luZ2IrNk0yYlp2bFo5S3d3S0ZIcjI5aGdWWXd4?=
 =?utf-8?B?aU9QejN5aXJYaTZNTW05TmdveFJZNENoTFlIbGlRSjdWTXBadlVXaXpacWJT?=
 =?utf-8?B?Z3J3UWZxbDkxeWlWRnNocThhZjJzSVBwdGdGQytQR29WRnVyeHN0ZUl3Z2FI?=
 =?utf-8?B?YnM0WkJVQjJnbXhGSzRRTksrRENaLy9mMjRwNi9CMWY3MTdLd2lBMDVkQTZl?=
 =?utf-8?B?TjZBNnEra2NNOHpPV0YvdjNIMjBFUVFJdHFoVE9naWdUQjQ0YXFVbVhpb3FF?=
 =?utf-8?B?d0F6cGtVR1AzMDFwdTJzVy9nRHFzd3hnRmZoRGFwSSsxdnRJd0tycWlacVZr?=
 =?utf-8?B?QmFqSCtnenI0OGVIVG84UXMvRWpLSXk3c3kvU2Z1U25HUmMwMytJcEwvSE4x?=
 =?utf-8?B?YXREaUlGQk1TblNoQW44NmRMNEhwdEFkanFBbVZIQlBnY1V5dS9MbmZpTHlX?=
 =?utf-8?B?S08ra2ppR1VkNU43Nm1uUDJ5OUdXRHRSMEFXZzlBcUZwdUgySGsvWXdjOFdH?=
 =?utf-8?B?SEk4SmYyM1A5ZkJwN2dUQkwrOGlXSVp0Vis3bWU5VVJpWEVkNTdUUnVqa1hH?=
 =?utf-8?B?NmJsajA2NHNnUlpseGNscWZMemhsY1dvblpyQ1dZN1ZYUGtUb3NSVFJJYnVx?=
 =?utf-8?B?S1R4UklsZXVMbDNwdWVpQnZZck4yRFRSQjVNS2JySzB2ODBzRGVHQUVIejBW?=
 =?utf-8?B?YkdibEhoRDN3OUQyK1FKVGZBZEcrcjFuRENUaEt0dy9CTFlTdW8rdGt3dS9R?=
 =?utf-8?Q?4S8ZIaW9w+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJqUVpDTjJ6RkowNGNKVjFrRnhjaTBRcWtIYTY5OXBHbnB0WmdZU3I1OW5F?=
 =?utf-8?B?NWpuUjFRWnA1UVI3WEZWWXVjS0xZeFFhczh6MEZTSm9rUTZwdEhIVEIxZU9R?=
 =?utf-8?B?ZjM3bWVxWDBXSFhTa3BuRTZlTHJhaDg1V2ZPcDc0QUx3WWNEb1JjTDcwREpU?=
 =?utf-8?B?NnlVRGFVZENDdG4yMks0OS92aGZpa2F4Nmp4d0lpbmhHWHZXRGxqbk54NHpP?=
 =?utf-8?B?bldMakhSK1BOUnViVU9pU1NzeTRqU0hTSnVwcnRtdEZoSFdhbU9TazNpOXBE?=
 =?utf-8?B?Ry9UcXZQNzNUMmdwYWd4Vjk4Nm1kbmx6K1dPRUszVGpXRlFMS0UwK3lxU2VJ?=
 =?utf-8?B?Mlp2UzVCVkMwOG9CV1V6Y3VDeUIxVWtrZm8wWmN2a0w1Sk05WUdrejBSR2tu?=
 =?utf-8?B?UFg2NWdtVHFzcjQ5Rmp2bXdXTGFpNjBhUi84bkFKSzRkREY1c0hJb3lERUxy?=
 =?utf-8?B?bnFGR3JldVVCVHRtRGRGNnJNcFlyekRFNUYxQklEVkxsTFVDZEtIb2ZqZjU4?=
 =?utf-8?B?QkdpRUdjeTIxaS8zRTBTY2Uwa21ZOEJYTmZwbWtodERUc3JEVjZ5Mms1UnZ2?=
 =?utf-8?B?YTQwY29tL1IvNm5CK1hCbysrMk5jTWgzMWs2amNGRUV6RXJBLzBhdzNISG04?=
 =?utf-8?B?Rk4wVDNUT1ZBdlRPc3EyVXZIYnU5V1l6RGwvVUFFRVRCZHVkWE5LSDVlRTl3?=
 =?utf-8?B?VEJnaEo2ZkRadmhFeFhVTWJ4amw0dTFoQWpJbEVwTnRGNmlOUCtxMW1xcm5w?=
 =?utf-8?B?Vy8xRkZjU0o5MitudGx1b0Z1OUw5VkxLMm9RY05qdUROeHJoNGVSc2Fxd2xw?=
 =?utf-8?B?VUJucGk3VzVJSXB6eDlyaFBaTWV3VGpQN2MyYnBobHlCa3U5SW5kYTRhZFZM?=
 =?utf-8?B?UHowWngvVW1BRzdXK2RvKzZzM3NYRldQRmFjTUhOUVphNGMzQVVFYmtvVGVm?=
 =?utf-8?B?TFJjVzRFcW9OaVB1VHRxRVNxbC8xMXNLYy9qL2JMMm91b3FmUSt2UGUvblJL?=
 =?utf-8?B?ZlhhK2tBS0ZNdjlYWUxFYjZET09qanR6Z25UNnFuVG9kaEpWcG9KSjZOQlFi?=
 =?utf-8?B?OUVUVDhybEpFRkdrQjJpRXhhNEgwc0M1Nk45TnhMWFZWV1ZER21MbTVYbTJP?=
 =?utf-8?B?Vm1nRjIwdEowdnNoNW1UdWdCY21BRHFmQ3h4bkJkWDBwNUhseE1VYWFKSWl4?=
 =?utf-8?B?NWhVS2tBR1dBdFh2TVVETDhzUEdoSEJNem1kMmQxdEYram9RbWw5V09TSStT?=
 =?utf-8?B?bVJwcG9BaXFxc29Ra0V4MTQ1ZUhBcHFUODZGbG5XdUVFeG9pNE44WEs4dUpu?=
 =?utf-8?B?Y3lKRmptb0VZd1BybmNOaXNEa2xwMVU0UVVaQk1XR2hJSzdLdnRKRDRIR2pD?=
 =?utf-8?B?bW1PZmNpcEYrWDdzTmJnay9SYTFUbHd4aTBGTk43TGFBM1l0VUtjd1VubmZ3?=
 =?utf-8?B?YkMvRnZKZXM4V3AzRHh6S2JYdnNYVnpTZGF1QXNWQk8xakVpWVg0dkpybmVU?=
 =?utf-8?B?N2RQaUFaeGhDZlo5WElEdXV1ejRjNkI3ZkJ3RW13aW9IaEhkSWVnZ3FBSkRw?=
 =?utf-8?B?TmVoSXRPTlVhc2VjRkpibEhHUklCN3RyV1NlbVFOYW1INjBYdEdXcTZCL2Vo?=
 =?utf-8?B?NVRIcmlIbldHbzg3dWJna0ExOHBKeE9qS1lkMXd0M3ZMK2RMYXVLK2U5anp2?=
 =?utf-8?B?WmVtaDA4NzE5ZFRoRFZjQWRGSmd0clkvZHVoVkl1K2pwRDZNSE45ZkNiL0lO?=
 =?utf-8?B?YXl1OWxHWmpEY3FNUzZZWHJHaHc3dFlHMy95cTh5aUhEQzNJSFRpUUU3V0Qx?=
 =?utf-8?B?TS9uaFNBUjBpVFJSOFBlRUZ1bWI4VWJmQW9MTU9scHpzVE4ycmQzVFZ2TGgy?=
 =?utf-8?B?dXkxNitkTFR2NEYwOEg4R3VXbUhUaWU1YkdhaGMyTUpHYmpKKzZHZ05BR1hz?=
 =?utf-8?B?NURYTnZnclhRSjlUQ0FpM05QdXNHc3hzT2hXdDFkMFNLaU9OTm1nOVZzTTdB?=
 =?utf-8?B?N1VqWG9FeUF3TDQ0RVoxNG42UWNyRUxyeldvQW1PSWNQMlpaM3psWHo3bE5q?=
 =?utf-8?B?K2p6WUlSOVRMcFFUQm5PcGczMkFtNDZQSVg2enlLMXN4YlMzWitsOXNLSEp0?=
 =?utf-8?Q?1gYJQ0gCGmh7bRFTxKP1mY+XJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ff8de4-bd90-4ba2-b58c-08ddf9cae552
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:26:38.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIzsmedw7Ccp+FqNdIdesUjGvmEKnaNoM3F++xFyrjgg1ZriUZNTjIoY6k3U5cTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

On 12.09.25 13:11, Srinivasan Shanmugam wrote:
> MMIO_REMAP (HDP flush page) is a hardware I/O window exposed via a PCI
> BAR.  It must not migrate or be evicted.
> 
> Allocate a single 4 KB GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP during TTM
> initialization when the hardware exposes a remap bus address and the
> host page size is <= 4 KiB. Reserve the BO and pin it at the TTM level
> so it remains fixed for its lifetime. No CPU mapping is established
> here.
> 
> On teardown, reserve, unpin, and free the BO if present.
> 
> This prepares the object to be shared (e.g., via dma-buf) without
> triggering placement changes or no CPU-access migration
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 +++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index f38bc9542cd6..5ce7c8b9ff39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1862,6 +1862,10 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
>   * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
>   * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
>   * GEM object (amdgpu_bo_create).
> + * 
> + * The BO is created as a normal GEM object via amdgpu_bo_create(), then
> + * reserved and pinned at the TTM level (ttm_bo_pin()) so it can never be
> + * migrated or evicted. No CPU mapping is established here.
>   *
>   * Return:
>   *  * 0 on success or intentional skip (feature not present/unsupported)
> @@ -1891,7 +1895,25 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_bo_reserve(adev->rmmio_remap.bo, true);
> +	if (r)
> +		goto err_unref;
> +
> +	/*
> +	 * MMIO_REMAP is a fixed I/O placement (AMDGPU_PL_MMIO_REMAP).
> +	 * Use TTM-level pin so the BO cannot be evicted/migrated,
> +	 * independent of GEM domains. This
> +	 * enforces the “fixed I/O window”
> +	 */
> +	ttm_bo_pin(&adev->rmmio_remap.bo->tbo);
> +
> +	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>  	return 0;
> +
> +err_unref:
> +	amdgpu_bo_unref(&adev->rmmio_remap.bo);
> +	adev->rmmio_remap.bo = NULL;
> +	return r;
>  }
>  
>  /**
> @@ -1903,6 +1925,10 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
>   */
>  static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
>  {
> +	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, true)) {
> +		ttm_bo_unpin(&adev->rmmio_remap.bo->tbo);
> +		amdgpu_bo_unreserve(adev->rmmio_remap.bo);
> +	}
>  	amdgpu_bo_unref(&adev->rmmio_remap.bo);
>  	adev->rmmio_remap.bo = NULL;
>  }

