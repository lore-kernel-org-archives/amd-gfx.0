Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97209D1CDB8
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 08:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C01910E61E;
	Tue, 22 Oct 2024 08:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZYwvfsH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1979E10E61E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 08:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSjO2mAlCvVNUv/FqBPapYcur61Yvsm2V2VKXbyW7WBDoFaIhykmcaTgLwHLIASLDZOc2eWqjc8ulXHg+jox5YNANOqvQz29Y9iQOQOWW0GvIfOo1F1GfMQmptgAHazEttAYJN5qTxhrmJLV9fpRPE/1+J/aj7IILB4yTV1bNH8cLinzOmYGtMA63UMUY0c2XB/TKsZdxQabHhCFWzFyvnaaqbVS/3ItXG6+gRhcpqPql6ebjLjk9SirBLfMRjEz5F2r2Vp9efAMQV6R5DVC+FgGT3QW8qrvVddf1YH2dK8RxuARGpD7IyD7mpipe+E/x3obiv4hTBHBnBZBKTfC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+0lR0bzqc2JKn/XsSMA6kUZmZRWE+NojlAjus585n0=;
 b=vW1JO/xNh9D8d9ADPPTAVenZ5N4hN92TvfmGLFFPJJAM9HkX7c/M91rFyHn2PqR3IKMmGp1/2k59HGbjdAFRd6uuvR9T5u66nJqtbUolZoJF+ra+6EtyfUOTOxTTgjrozKgUmakBsYzMSs2PWFT/e4Mu1/wM2Vt9LjSbvuqP4UtEZmVEjHqwL3H56EHEqN5FTqwqPZUam5XV02XN7T+PRM6QUMbZEet/xWhFFvb9/Bv8Qrhy6boWoEVz548ANIBQYVjxSva4is4UgWg4lyjjjM2gIt4CrO6tkuixiZOzLGpJPVUblj4SN3HuXJhINKVjqWKZorVrF9zrLV/1KXdjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+0lR0bzqc2JKn/XsSMA6kUZmZRWE+NojlAjus585n0=;
 b=tZYwvfsHshPyw/34GF0DUyarUZrrnTxXoeTnb6AxshsmwbNKeqzlKrkD17Nv5cZ8zJ/1SWKvfu/lqZFhsTTqfY0LzEQLQ4RRUk/IAzO4CU2asYy3sFuOeBp5J87Ky1HE1WBCq6bmkDewSIdTYrhcNiu3CpGM6tz76XPFiDa09ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 22 Oct
 2024 08:40:34 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:40:34 +0000
Subject: Re: [PATCH 28/32] drm/amdgpu: print_ip_state for each vcn instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
 <20241017132053.53214-29-boyuan.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <385a987f-856f-0c80-705e-dd074c30d7f7@amd.com>
Date: Tue, 22 Oct 2024 14:10:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241017132053.53214-29-boyuan.zhang@amd.com>
Content-Type: multipart/alternative;
 boundary="------------9F412ECD5155DF5304927C42"
Content-Language: en-US
X-ClientProxiedBy: PN0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2505f6ee-50fa-4e50-52e1-08dcf27531aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWlkNEpYbHM1eTV0SlhvaENqUk9SZGNTSzhiUmlNMjZZUU5yVzNQOTE1VHBC?=
 =?utf-8?B?Y1NhUnlwc2x3VDUvRHFGMDVKRVpVNmQybmp6Rm40R1BrZk9nUmRqMmpZYkZ5?=
 =?utf-8?B?SlVXUXJyQ014em1MYkhlVFJPQmprMGFmVkR2ME4xclRRbUtNd1o0bGhrSVp0?=
 =?utf-8?B?S09JY2l3czlUZGNwS2dIcmxvaWRxVjVkUFllQlRJSlVWNjQ2ZEVuOWlCYlBD?=
 =?utf-8?B?K1d2UzlmR0tmQXFnVXlRQnpXZWxkbnF4MGNHZm55cEZJL3lxalJWUWtQV1dI?=
 =?utf-8?B?M2FNZEVuekdON2dqVmxKbjVydzBNTVMwZzBvMkRSdXBDbXlpNm0zSmdveHdx?=
 =?utf-8?B?RldvdkdIVVBKNzZIL05yU05Vek9ZbmkxS3l3dk5POGcraXdkZWJNNXBCS09H?=
 =?utf-8?B?S3hZNjBFVE54QlRIZzFiSnlHcVBVMnV2R3FUUEJpYmNwRjBzWWw1YkcrWDNi?=
 =?utf-8?B?V1YxVlBXQU1USjNnRmJWZjNETlAxOTY2YzZyZ3p0cithZ2d3T3hxU3Baa3Vy?=
 =?utf-8?B?bzNZblVWbmIybGs1QXNSVlV5OWUwelJZeXBvL080OUhndjJUS3dpMTJQY3pz?=
 =?utf-8?B?L0paWFRxd2xDWTJ6enk0NkJXS1ZEdnJmUGtycWw1SmF5dVpxV0RpdHBnV21E?=
 =?utf-8?B?RVlnVXpGOVRDZEE3T0dYODBsYm8vZTZsaGt1OFFobWdXek9CUkJtYVBDQ0Qx?=
 =?utf-8?B?bUhCZWF0aFRNYklVTkpLOGdzcGpxTEs3bGN0SWQ3QXdSQTVBOWI3aEZTbVFr?=
 =?utf-8?B?dVROZUg5U0MwYUVwemNRRmhZcXhwYUZvUjhOM1BRQ0NiUm5md0h2ZVRnL3Ir?=
 =?utf-8?B?YUlKc1Q3bTNNRDNwenoxYnRmSktKcFhwKytEa1ltNVVGWXRRdnVWeUx0RGlB?=
 =?utf-8?B?WmJwUEpJK3dZczJmVm0xZlJudzh6ZzlxRXRLUUN3NloyN09TT1F5blljRjhq?=
 =?utf-8?B?bGhlVFhqOHB3VThRYU9ySUxCRTZDSUFOWmVpVVBoa0N5R3VWMzZOdFpkMmFP?=
 =?utf-8?B?MnNzelFHZDJhcWl6dlJxdnBTemhZUEF5aldqTjVZMkJtV1ZyalA4dlRhdzI2?=
 =?utf-8?B?cEtqRnRzblIySVI1d280eE9DdGk5LzFiRi8zdWZNYlZsNGVpa0RXd3RDQWYr?=
 =?utf-8?B?QWI0RW53aWwvNjFIWGp0WlRhaW1CRHdmZmlmRDMrSTBRV0xMaStPSlY0RjJX?=
 =?utf-8?B?cTU2cVphNVZNcm42UXdNQlpXSVErUVJweER5dTMvaEJYVzlHNVFJNG9Gdkdh?=
 =?utf-8?B?YnFKKzhCNHBBMnVGcFpyS3RDd1dpZjNEQWJPMDdHRTUyUG1RbUpuSDIrOCtO?=
 =?utf-8?B?RkhIRXZXY2QwdnRURndhQmJveFdJZG0yZUs2TmR2ejVHNWlzZ3FSc1ErQzZ0?=
 =?utf-8?B?dmNmN2xyTHFpR2FrMjMrM3hDRGJvSDFQVFQ5K0RIY3V2RUZzRWh1Y1RrZHpw?=
 =?utf-8?B?MmJKR1ZQbEhJSm1BdlIvc2V6R0NDNnFMcUd6VDEzWjJtU3IvU002d29TYUJa?=
 =?utf-8?B?NVlBRU5IaWVwczNMd0Y0RENFWUo2T0UwN2RxV2ZGYnVPTWpkQXNaTis4cXQ4?=
 =?utf-8?B?RjdwUGI0dm9qbHdXRmU4NUdqb0N6ZVM3aWRHK1N1WFlSVjVITHl5MUYvNWRa?=
 =?utf-8?B?M1NUNElVNG9OOWNybkZmd3duMmFKWHdIcHp0NTFrRFI4blljSDAxVjJCRzVQ?=
 =?utf-8?B?bng0eUZ1QjJzVFk2VE5zL3ptdUxhNGlrRXAyeW8rY3d5c0g3YVI2K0E5cGFw?=
 =?utf-8?Q?yMDwX7dbYSTnJC3nT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmkwMHFHTlF4c2krOFh5L1BWc1ZnQ2E3SWRZejB2WlVmSXFhTXBQdHVITlho?=
 =?utf-8?B?MjcwK3ppc3pWbjBldXdWWGhpUUVFOEhBa3RMR2dzQTNEcjhMNk51U09HT1JH?=
 =?utf-8?B?TldlNldEdGI1aC9SSk1RVFRpYU1vWWNRcUI2ZFI0NzJNL1pGMWpOMjh2enc1?=
 =?utf-8?B?MC9wSkRmV0Q2eXZuazFlbm1sNGczaVpjalM1OGtuc2RLMDQ1TEwzaGVZT0Zj?=
 =?utf-8?B?MnZpODdKTy9HNW1qbDB2dThmM2JqaHNOdmkwZ3BVenAzQUc0MXdWdVNXbDY4?=
 =?utf-8?B?VHhvbjQ4amtTUzIzL21mMnRxTUVrcXlLTzZNYTFjY0pNa2o3NmRqNjlZVDdl?=
 =?utf-8?B?THZqQnJrVWR0K3kxSmZVd1RrZFZseklHZkw3L1RodVk2TldCSmJTU2FVRndX?=
 =?utf-8?B?TjdrODRtOTRUVlNNYXNmWTJCNWJSbHd2elYrcmJkWkxsK2M2aGFMOXE1NkVh?=
 =?utf-8?B?cFcwZFlJbmpDWFE1bmloSlQ1OENSYzhZYS8yV3VqS08vaUwyZndmVDBQNWhD?=
 =?utf-8?B?aUc1WlYrbmE2WFJhSk1Ba3VWcVpsV1JXZkJldHBVOGU3RnF6QjZTRkM3V1Zq?=
 =?utf-8?B?OVRPYlg5RE9VWmZqNDhaMTFVNWtYYkdmcVpUZHRqOUZhck92MVRxeGVYZFZB?=
 =?utf-8?B?V2tiTXpjMXRJTWZ1OGxRQUczcHJWZFdNN2RzTDZjQmxpdnNmUlNWYmw5Rkpo?=
 =?utf-8?B?d21wZmFLYWdYOUdmbXFxaGx3WlB0emJtSnVFQUh5bS80SWVMQnlvZENjMmdN?=
 =?utf-8?B?TW00MEt0eUVqcTVVSWZQTVNralU5RGljdVZVYTR3QzNSbUtsb1RvOTAvM3VT?=
 =?utf-8?B?RVpUL2JlN2RwWEdLTlcvc3UyOVpYQTExSXBzN3B1K0ZNNzdCaThWcjlyUllF?=
 =?utf-8?B?SWh5cEFKMGJKRnhzaHZRZWN2aDErSkRMNXFZa2htZG1qQm9SQVZnWWVSSTZp?=
 =?utf-8?B?aEhTamkrUnZDcW5XMW9JWjZibmVsa0dYZ29EM3VsVS8zNGE0anhTY05hVXJF?=
 =?utf-8?B?bUoyUjh6MWVhSzdqN3lmOVZTTXBsK1ZzSHkrRG4rdVhFN2MrZUVQUWczQjE1?=
 =?utf-8?B?WU9FQS84QXVtRW9uc0c0WGlkRStGdWdwOWYzWUxHYTFPY092WUFzeGRoWjhV?=
 =?utf-8?B?SEtSU0hzalpPd0VHT3FORFlVOExORVh1YzJUazhSYWJRQW8zaGorejJsVm5W?=
 =?utf-8?B?QVhJYmRDWWFid2xWdFJjSmxZb2UxaU1VTHh6d1QwQ3FHMUQ0U2RNbFVnbENK?=
 =?utf-8?B?dE9kWnRSYjNxc2laYnhhbjV3NEgvRzVTaisrMmN1VGVWTnVYZlMvZ1M5bkFO?=
 =?utf-8?B?YVhxZ3hkMGoySlpHRDV5UVNyNEY0bTdNMTlsZGxEN0xTOW01VzlrdTNPcjFv?=
 =?utf-8?B?THU0NGtZNVB1MDlUblVOaUdKYlA1cFZDYkF6bEs2Nml4QnlzUHc4RExSbVNl?=
 =?utf-8?B?N0t5ZDhkekZIcHhIUFYyM2RtVVo1TkxQRmJmaVp6N3hjVGo4QTdKNlVNQSt1?=
 =?utf-8?B?THVHMmdpeE9jQ2x0MXp0NWNJZUVFNUtsNm5KdVFUcUhrUTVhZzRuMDhWcnJz?=
 =?utf-8?B?aGhtOWFyNHI0NFY2dEx1NEdTSlRKYUIyd2dnblltRDhVMmlzaCtZYU1wb2tV?=
 =?utf-8?B?UCtVRko4ek9obGIxclBmcHBaVXhoTW9XdjVLS0xmOWxtODlsbjh6YjdkMjBK?=
 =?utf-8?B?UGVPenNYYVIvaGlsdHRMWW4wR3FWbVQ3UWVPejVsZGdpNjdnSFNDNWgxMGQz?=
 =?utf-8?B?Mm5hVXBPWTVQK1BmRDlNVWFHZDVtNW5EekRjUktFL3hDcG1DZ1g3cW50QzJW?=
 =?utf-8?B?ZE1DVVkwcGFVVnd1TkdSZ25aR25mMHV2ZUJ5MmJQdkUxSy82eFE2aXc1WU1k?=
 =?utf-8?B?bStOcXJKSC9DTXFKRWEzY3kwa3V5TlpoUCt3NzBQOU4wOFR2cWd2b0VIVS9J?=
 =?utf-8?B?T3N3MkxmQ1FCTmZqTmM0TDl3bkhhMWNTU3dveTkvRW5PMEtoRVhBTFlKWVdp?=
 =?utf-8?B?YWZkcDdsUnNjemNFSDE0eVR4OFdsWHlJaXI0RVFXVnREMklYU1ZKVStvdDhW?=
 =?utf-8?B?cWV1bkpScjFqNUI4QTZPS0c2b1YvaDF2V0JmS2VaaThHb2F3OGJnMnMyUTll?=
 =?utf-8?Q?qfof37VUvzC7TgWWDOXrq7yBx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2505f6ee-50fa-4e50-52e1-08dcf27531aa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:40:34.3692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyyWsXmjvTvmMukRF2+LH1ABHCOtwhc/B110QHSUP+IB0QWPMeqKH5+ESANRfPJpoBLk1MlxB65UGkI79CGZyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
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

--------------9F412ECD5155DF5304927C42
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com 
<mailto:christian.koenig@amd.com>>

On 10/17/2024 6:50 PM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Perform print_ip_state only for the instance of the current vcn IP block,
> instead of perform it for all vcn instances.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 33 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 33 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 33 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 33 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 33 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 33 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 33 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 33 ++++++++++++-------------
>   8 files changed, 128 insertions(+), 136 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index ab06c4173b66..9255bcfc6c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1933,7 +1933,8 @@ void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>   static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
>   	uint32_t inst_off, is_powered;
>   
> @@ -1941,24 +1942,22 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   		return;
>   
>   	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_1_0[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (j = 0; j < reg_count; j++)
> +			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_1_0[j].reg_name,
> +				   adev->vcn.ip_dump[inst_off + j]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 59c6458c99af..94f000ed4895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -2041,7 +2041,8 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
>   static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
>   	uint32_t inst_off, is_powered;
>   
> @@ -2049,24 +2050,22 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   		return;
>   
>   	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_0[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (j = 0; j < reg_count; j++)
> +			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_0[j].reg_name,
> +				   adev->vcn.ip_dump[inst_off + j]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index b0d14330722b..7c9a0169215e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1915,7 +1915,8 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
>   static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>   	uint32_t inst_off, is_powered;
>   
> @@ -1923,24 +1924,22 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   		return;
>   
>   	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_5[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (j = 0; j < reg_count; j++)
> +			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_5[j].reg_name,
> +				   adev->vcn.ip_dump[inst_off + j]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 9a9acec4c4ce..061c958700d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -2237,7 +2237,8 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
>   static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
>   	uint32_t inst_off;
>   	bool is_powered;
> @@ -2246,24 +2247,22 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   		return;
>   
>   	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3_0[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (j = 0; j < reg_count; j++)
> +			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3_0[j].reg_name,
> +				   adev->vcn.ip_dump[inst_off + j]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index ff256fb4d054..fdf346bf3e34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -2146,7 +2146,8 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
>   static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
>   	uint32_t inst_off, is_powered;
>   
> @@ -2154,24 +2155,22 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   		return;
>   
>   	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (j = 0; j < reg_count; j++)
> +			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0[j].reg_name,
> +				   adev->vcn.ip_dump[inst_off + j]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 544c96e082b9..daaf2fb6b3e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1726,7 +1726,8 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
>   static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>   	uint32_t inst_off, is_powered;
>   
> @@ -1734,24 +1735,22 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
>   		return;
>   
>   	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_3[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (j = 0; j < reg_count; j++)
> +			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_3[j].reg_name,
> +				   adev->vcn.ip_dump[inst_off + j]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 880353f75296..ff8db22b9614 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1607,7 +1607,8 @@ static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
>   static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
>   	uint32_t inst_off, is_powered;
>   
> @@ -1615,24 +1616,22 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
>   		return;
>   
>   	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_5[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (j = 0; j < reg_count; j++)
> +			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_5[j].reg_name,
> +				   adev->vcn.ip_dump[inst_off + j]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index a4d1b9a086b2..c83a5c09f410 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1334,7 +1334,8 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
>   static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
>   	uint32_t inst_off, is_powered;
>   
> @@ -1342,24 +1343,22 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   		return;
>   
>   	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_5_0[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (j = 0; j < reg_count; j++)
> +			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_5_0[j].reg_name,
> +				   adev->vcn.ip_dump[inst_off + j]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   

--------------9F412ECD5155DF5304927C42
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p>
    </p>
    <p class="MsoPlainText">Reviewed-by: Sunil Khatri &lt;<a href="mailto:christian.koenig@amd.com">sunil.khatri@amd.com</a>&gt;</p>
    <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ascii-font-family:Aptos;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Aptos;
	mso-hansi-theme-font:minor-latin;
	mso-font-kerning:1.0pt;
	mso-ligatures:standardcontextual;}
</style>
<![endif]--></p>
    <div class="moz-cite-prefix">On 10/17/2024 6:50 PM,
      <a class="moz-txt-link-abbreviated" href="mailto:boyuan.zhang@amd.com">boyuan.zhang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241017132053.53214-29-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>

Perform print_ip_state only for the instance of the current vcn IP block,
instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 33 ++++++++++++-------------
 8 files changed, 128 insertions(+), 136 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index ab06c4173b66..9255bcfc6c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1933,7 +1933,8 @@ void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
 	uint32_t inst_off, is_powered;
 
@@ -1941,24 +1942,22 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, &quot;num_instances:%d\n&quot;, adev-&gt;vcn.num_vcn_inst);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i)) {
-			drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst)) {
+		drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, i);
-			for (j = 0; j &lt; reg_count; j++)
-				drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_1_0[j].reg_name,
-					   adev-&gt;vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, i);
-		}
+	if (is_powered) {
+		drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, inst);
+		for (j = 0; j &lt; reg_count; j++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_1_0[j].reg_name,
+				   adev-&gt;vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 59c6458c99af..94f000ed4895 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2041,7 +2041,8 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t inst_off, is_powered;
 
@@ -2049,24 +2050,22 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, &quot;num_instances:%d\n&quot;, adev-&gt;vcn.num_vcn_inst);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i)) {
-			drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst)) {
+		drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, i);
-			for (j = 0; j &lt; reg_count; j++)
-				drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_2_0[j].reg_name,
-					   adev-&gt;vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, i);
-		}
+	if (is_powered) {
+		drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, inst);
+		for (j = 0; j &lt; reg_count; j++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_2_0[j].reg_name,
+				   adev-&gt;vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b0d14330722b..7c9a0169215e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1915,7 +1915,8 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t inst_off, is_powered;
 
@@ -1923,24 +1924,22 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, &quot;num_instances:%d\n&quot;, adev-&gt;vcn.num_vcn_inst);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i)) {
-			drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst)) {
+		drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, i);
-			for (j = 0; j &lt; reg_count; j++)
-				drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_2_5[j].reg_name,
-					   adev-&gt;vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, i);
-		}
+	if (is_powered) {
+		drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, inst);
+		for (j = 0; j &lt; reg_count; j++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_2_5[j].reg_name,
+				   adev-&gt;vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9a9acec4c4ce..061c958700d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2237,7 +2237,8 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t inst_off;
 	bool is_powered;
@@ -2246,24 +2247,22 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, &quot;num_instances:%d\n&quot;, adev-&gt;vcn.num_vcn_inst);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i)) {
-			drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst)) {
+		drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, i);
-			for (j = 0; j &lt; reg_count; j++)
-				drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_3_0[j].reg_name,
-					   adev-&gt;vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, i);
-		}
+	if (is_powered) {
+		drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, inst);
+		for (j = 0; j &lt; reg_count; j++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_3_0[j].reg_name,
+				   adev-&gt;vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ff256fb4d054..fdf346bf3e34 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2146,7 +2146,8 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t inst_off, is_powered;
 
@@ -2154,24 +2155,22 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, &quot;num_instances:%d\n&quot;, adev-&gt;vcn.num_vcn_inst);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i)) {
-			drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst)) {
+		drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, i);
-			for (j = 0; j &lt; reg_count; j++)
-				drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_4_0[j].reg_name,
-					   adev-&gt;vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, i);
-		}
+	if (is_powered) {
+		drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, inst);
+		for (j = 0; j &lt; reg_count; j++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_4_0[j].reg_name,
+				   adev-&gt;vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 544c96e082b9..daaf2fb6b3e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1726,7 +1726,8 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t inst_off, is_powered;
 
@@ -1734,24 +1735,22 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 		return;
 
 	drm_printf(p, &quot;num_instances:%d\n&quot;, adev-&gt;vcn.num_vcn_inst);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i)) {
-			drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst)) {
+		drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, i);
-			for (j = 0; j &lt; reg_count; j++)
-				drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_4_0_3[j].reg_name,
-					   adev-&gt;vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, i);
-		}
+	if (is_powered) {
+		drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, inst);
+		for (j = 0; j &lt; reg_count; j++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_4_0_3[j].reg_name,
+				   adev-&gt;vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 880353f75296..ff8db22b9614 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1607,7 +1607,8 @@ static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t inst_off, is_powered;
 
@@ -1615,24 +1616,22 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 		return;
 
 	drm_printf(p, &quot;num_instances:%d\n&quot;, adev-&gt;vcn.num_vcn_inst);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i)) {
-			drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst)) {
+		drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, i);
-			for (j = 0; j &lt; reg_count; j++)
-				drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_4_0_5[j].reg_name,
-					   adev-&gt;vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, i);
-		}
+	if (is_powered) {
+		drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, inst);
+		for (j = 0; j &lt; reg_count; j++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_4_0_5[j].reg_name,
+				   adev-&gt;vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a4d1b9a086b2..c83a5c09f410 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1334,7 +1334,8 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
 	uint32_t inst_off, is_powered;
 
@@ -1342,24 +1343,22 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, &quot;num_instances:%d\n&quot;, adev-&gt;vcn.num_vcn_inst);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i)) {
-			drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst)) {
+		drm_printf(p, &quot;\nHarvested Instance:VCN%d Skipping dump\n&quot;, inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, i);
-			for (j = 0; j &lt; reg_count; j++)
-				drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_5_0[j].reg_name,
-					   adev-&gt;vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, i);
-		}
+	if (is_powered) {
+		drm_printf(p, &quot;\nActive Instance:VCN%d\n&quot;, inst);
+		for (j = 0; j &lt; reg_count; j++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;, vcn_reg_list_5_0[j].reg_name,
+				   adev-&gt;vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, &quot;\nInactive Instance:VCN%d\n&quot;, inst);
 	}
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------9F412ECD5155DF5304927C42--
