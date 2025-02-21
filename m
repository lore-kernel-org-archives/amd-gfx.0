Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CB1C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A32A10E0EE;
	Fri, 21 Feb 2025 16:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQEVXvbI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484A510E0EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7mbfHhbt+qwJVn7XSCfwZfTMPnZXsbWdJIr0QzJiIRBGMIseLhee0t5JWPSGKlvFPj+J0nXUq+q4u/G6tVhX6jQ94/XNs2IZy8eZp+ZixZ11vnJoEunWQmy2p0856KOCFP03ki6Q2XhE92dPS625+UXCAdbAsCkT+4PDA5WI0TFSb+1vkjXIB3NihfdeWPtq6dPrWk7yYBFOXaX5jN0SqYDQ8I9SW1+xFzUFiYr5ZtzRn4VdW6fs2r6HnQPHnJABNdCzNvffelmtefneYTrD0wwTpk9kYkSH02EgiDSnLXPGmwv1LzO00gwc3dN4HLeQN+e2SNSMiW/obn3YOdH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1iBKbpvJM5Qbsr0hntDTNYKtjHf+CVOQ2PbzBZikhQ=;
 b=J1ntNPMP1ykoPLGeVpahx9vVhmS68kzED462Bl/w/93jkp5cbwzzmwojFSw7GZ8NGDH1lgXEzEd4vB/puf8qcOUBvKseJClpjZIek4qLuBGV8ZO9a+630yXGCs2iqeGwTi6CblwjsOQjzuH21X6XFSXsGkfaPGT8p43tYhy28G7aoGp0IaRPAfIu9bC58VkyQ1iQ64VjQq/tVFyHGWrG1SikxRoq466RBbFd3SuIPX977qpueDNe2deUQTOcfojyUbZGYvs7Jt6w36BP5zVfroMoT/4R9zJHBp/nptySV6YzjfePpviW+B3K9Wk8vBbtKQTryTJvgkfrGF8f+ZK6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1iBKbpvJM5Qbsr0hntDTNYKtjHf+CVOQ2PbzBZikhQ=;
 b=hQEVXvbInn1Om1OTQIYu/eRQSo4cWQl0rKHPp0BYX6Jb6U81NvJq8VGvdmyHr4WSMbJdcJAktuad5n2lbyewM5U7gSO+sYTZHzdP3WeKgOhMP90yuLAE3E5QlQosYA1Owp30mNwgOPduHd4/6oYaqA+9CseT6PAJ2vsueiX+QP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:34:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:34:09 +0000
Message-ID: <e0a98571-a214-4140-a8d0-6ec793d51003@amd.com>
Date: Fri, 21 Feb 2025 10:34:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] drm/amd/display: Fix HPD after gpu reset
To: Zaeem Mohamed <zaeem.mohamed@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
 <20250221160145.1730752-23-zaeem.mohamed@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250221160145.1730752-23-zaeem.mohamed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0008.namprd05.prod.outlook.com
 (2603:10b6:803:40::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bab338-4d42-4824-13c1-08dd529590fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFlyeGlOdW1YWHdicFkwNUx1UjdUTVhPMEZJZFZETlRnR3Uwb0o2QjNuZHNT?=
 =?utf-8?B?TVREVDhKUjQvYXlPOWhtY0J0R2ZOMEpkeThZanY3QjZ0MnZ0YWlmTVFteURS?=
 =?utf-8?B?VlVmMndTNlRSM3JacVVBVGlMVVRBT3Z0cTEvVkNWYjgzMUIwVTJxQnduUEZl?=
 =?utf-8?B?QUk5NERGU3RIVzF2V0t6YkhLMG5GREc1WUVqajgxUGpveXh1TEZmeHpDMXdM?=
 =?utf-8?B?dFIvb0E3WWZNZndjS1RYQkdTNlJETG1kRkRsUnR1Ky9mQ0UzTnAyT1BZbVMv?=
 =?utf-8?B?bHlqV1FkeGo0bmVHZnM0bVVqazc5QUFjSWw4SHhkR1orOFNFajhBb1lqeCtX?=
 =?utf-8?B?Mm1ZZ09rUFI1WlJjeHdKNUFFWTdLQXgrMTBHdEhOMGJ4TkJDb09ySzNnbXVi?=
 =?utf-8?B?TVJuR3BHalcyWkVSdXE5SmlGSUxNZzVScitKTkUyVm9aZXg3eFQwZy9RaXBi?=
 =?utf-8?B?R21pTFhzM09OcGtVajVSZE1HVy9KcksrQm5ta29qL1VtSEJBbHhFSytEVElj?=
 =?utf-8?B?d2h0OHJ1NW5kT2RHbGx0YUdVVzNNQmxwRk1yQzlsOWN2M1BZZkVieFZLQzhk?=
 =?utf-8?B?K1BPKytuZ2NxbUI2QURQaVUrMVRDaUExaThHcWVwOEc2MHNEVGw5ZFplTEpj?=
 =?utf-8?B?dHVUcW5neUJlYlBjVTJ2YktzeDM0NU5XOXZwWEVxN0ZTckdQdkNKQlRWem1E?=
 =?utf-8?B?a0NtZjk5cXQzRnBqS3d2R0xyazlyekRjTXFkU3N0MDlFYURLMlh2NWFlUW9I?=
 =?utf-8?B?RUlFcFQwYmJCbmRwenNzcjdwNm9VdWdPVEkwSDB5cXZJTGhKb1FITm9IRUdG?=
 =?utf-8?B?enY3R3BseEVtbXhuYnhhN2lGMDVQcFNQN1BsclQrQ1RLN240UWlVT2hxSEJ4?=
 =?utf-8?B?V2xybkZpRjVTN2h3blBmMUQ5a29laFpMQlFxWU53N05aL0VTSGRFNUIrbnFR?=
 =?utf-8?B?ci9DNkhqbXJUYTFHUVk3aHhMeWFpUDZiSUp4Y1ZCT2d3NHpsa2JSNjB0Z1hj?=
 =?utf-8?B?WDlpbnhaOEhMV2xqZTVOSERXWGhNSFFEZitNblRjbTQyazhCbWRGa1g0ZlZI?=
 =?utf-8?B?VmNWTDFsQy8zRUU4bTNMb1pxQldNdldjczdPRm93djQycGcxZHBWZE5pS29B?=
 =?utf-8?B?YmhuZHJYZmlpbzZDaGlLUXpRRXI4WWhHcjdVT0dTVFdELzYzNUM5bHJtZ2pq?=
 =?utf-8?B?VDV2bFJqQjVoSDQ5UG5HS20zb2lEYVNnaWRZRkdoS1FxN3o4R0VzSmhqd2FD?=
 =?utf-8?B?OGdwUkNBMVdxZ3hzc0ZzZmtreGp5eUJ3bUNjWHJNU1J3QkpzdG1saHJtS1c1?=
 =?utf-8?B?bWNXYzZPZzNtZGsrU3lPTVovUDV5aWF0UmxZZ2x6cDVTdFIxZ2dGcXp5cEZ3?=
 =?utf-8?B?NS81N2dlTWhQa294c3dUNk5taCtSbTNydGJGbXBycnBuMlhvY2UrbkhUUkdp?=
 =?utf-8?B?YSsyM2xYTEk0Sm45TXJ4RGFNN0lQbXNyVnBOV2s5cHl6N3E1eDBJWDYrTWN3?=
 =?utf-8?B?cmpSTWJ2ZEpBajZia2cwK2kwa0ZycmxMcE9XNW1WOFFKblZYVy9Kd05QQ3ZS?=
 =?utf-8?B?UjNubHRWb05DWWlBSmNkTEtITzNqYkpUMzdBVUtNRlZud2hqNWNLQ0hLQktQ?=
 =?utf-8?B?ekFyMS9IY2k2dGErdTF2QStLWSsyU0E2YytBNnF3alFXSEJTSW8yNWlKVm9F?=
 =?utf-8?B?SUpFUE1zYW1WdTZWam9vUkRKSC9VR3BKVEEwZXlVZFFuSkxXOFIrdlJCc09a?=
 =?utf-8?B?VEY0blIwOENhRjUva3hZdWFaZzRtakcxSTlqZUF2U2wvRnJPNmYyeTVTaGxT?=
 =?utf-8?B?VGpoV0NNbDBPdnRScVZDQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1kc2phRmwwOGJhemR4dlRjaEtiRXFtM3BpOGI4RVRpb1FnRFFydXJodS9n?=
 =?utf-8?B?TGVaeit2L01TY3ZWNWI4RTZFelA4ZlR0dnJRUzk4d2oveXpRUkNsMlNsQ1dF?=
 =?utf-8?B?OE40MG9WRlM4WUdWS3Fla2hncExCRElWWnh5QnlleWhLNVJtZk1vUnNSRWhI?=
 =?utf-8?B?Z1VlVHhBUFM0alN4ZG8zVWUrL1JmMWROR2dkOWc1clN6Z2xFS0dNQ3BNRFQr?=
 =?utf-8?B?VDZNZUtEQWRQVk8waGJ0aVlhOTU5blNianVFNWdRUW0rbmxKQ1VEKzYrMVlR?=
 =?utf-8?B?T2xYblQ3TGk3K0xROHhMUCtFWU5aRVU1QWZiZzJpNWlvY1EyRWhqa0l4SWow?=
 =?utf-8?B?QWZ6UC9ubEJiN2xrblQxNXJaK2l0OU5FRE45SUJFdHNQQVVkMWNoVzZkVDl1?=
 =?utf-8?B?c1ZLUGhOYnI4N24vVmxxU3NkanR0emV5MXcrVVJ6aW5YRFRMTVFPR2VKV0Ji?=
 =?utf-8?B?cVBlN1BROCtpWEd2YzNVRk5ydy9zcWtRcllxWG9rYTZqbHcyY3RrWUlZZ2pF?=
 =?utf-8?B?dnRvZVFOdUVnN29KdTF5OXdtVnpydVRvNXdZeXpLMXhGSXpKS1pwMTNvejBQ?=
 =?utf-8?B?ZlBlam0zMGpyMXFWZjJrS3llZEJhOWN6NGdINCtDamJZUlNSMW5MUXJmd01M?=
 =?utf-8?B?eEE3aHRwRTNIa1F2U2REN09jOFRYN1lKVWsrYUQyb3VUck5xbmlIY012Zm5Y?=
 =?utf-8?B?eUk3ZUg5M293eUJnbW9DbnJIQUlydWJZYXpaRE5GZE5vWHY1K0VKRmFyZkJ4?=
 =?utf-8?B?a1RQUDl2RVZwamJwNVU5U1BEMExjWjBSY01BV1lsaDNKNmZtUmltMmNZYjhR?=
 =?utf-8?B?VXk2VXQyR29FZVprNjdzcktSeit0emxRSXUzV284ZFQ1R1ZNaEFONFkyQTZz?=
 =?utf-8?B?YThnK25WaTE0SmpMb092bUoxcU1lSTlnbzhjMkFhT3dFbDFicFl5Zm9yR2RL?=
 =?utf-8?B?cW9VKytmeDYrUlNqWmd0MmNPbHRlbm8vUlZ2Tm1SUEZXU2gzK01ldE5FQVht?=
 =?utf-8?B?WjlPbkxKRkpWT0Z0TWhoc3hMRG5nMVN1aTJ1dktpQlJuODdsMDc1dVN1YzFO?=
 =?utf-8?B?L3MxMFB6TmthNHZZSDg3L1FhclBWK0JLK1BIa1pGUmVuWmlBdEoxSzhUWHJB?=
 =?utf-8?B?dTdnVElJRmlDTFUwNGxTMHZYN1FYaFowYkhGVXNWRndjL0taNTcrYmxQV0Y4?=
 =?utf-8?B?NUkxRDk2dllXdTdPSm9kUi81ZStCajRhSnRpZG9DNkw2aVZ0d1lRVHFwWCt3?=
 =?utf-8?B?ZEJqNVAzSklZTlA0blp1cThlOVVZR2lNS2FYVmg0cVNIRGVvU3FxVytxMWdo?=
 =?utf-8?B?bEFYVUZvVU1kZmJIa1k2OXZBc0FmM29YZGFsVVZHd3YxcENVaVErOEFPOVc3?=
 =?utf-8?B?MVBvbWJuaE9XNkZwOEEvSzB0T2VyQkUyVEd6UHNDaWtMQllvK3VsaHdNZDdN?=
 =?utf-8?B?ZjdSSnhTaXRLK0JQWU9CYzI1dmtDbkh5V3FyYkgxcUR4b2pCMnJNM0JpZ21j?=
 =?utf-8?B?OEYxZUVIZFF5ZFBwN25NRzFScVd2V3RYMmkrVHZ6MldVaXdYOHZpUkxCd1J3?=
 =?utf-8?B?MlczOGt4d2kxaUFBQlMzTWZud3lIZ1ZaR1dicUVidTBxUjQvZUE5cFJFUGVQ?=
 =?utf-8?B?Sm1zVS9QUHpQakRrNHlpMStQWjVCMkhYenpycHcxdDlrUDgrZXpzMzZONDZQ?=
 =?utf-8?B?MGJxZGlUWmNiYnYxSEx1bG1LOGFqc1N3L1Z6VEgraFZibW5NT0MwUWtGeFBS?=
 =?utf-8?B?WEtlZXNsTTlhZWQyck9GaG5idGNjZU5qUkdhaURpMXBaVkZxaEthbmZnTkFU?=
 =?utf-8?B?UklZRFV1dFhSNUVFVFM2eVc0cnJ6c3JBTVJwdGk3d29kSFljYnFrT1ZHSCts?=
 =?utf-8?B?WU4wVkI1WllWVkhBbHNLTmN5VWpSZldwTmxoaFM1ck1DdVZlNVZDV1VaUUNj?=
 =?utf-8?B?eTZ6VVhHbnJOUWMxTWI5OHlHR2x0WUZQNS93VXdoa051TThvVElBQ2VGaGk1?=
 =?utf-8?B?SFVUSnJuWHowdTI4N0lLQmZYdXYwZ1dZb3NvK0lsMmdaT3NsNnh1dTl4anIv?=
 =?utf-8?B?NkpNR3k0cEJ4cnlLN3dLSWUxTWMza3RqVmdxQ2ROYkdqbURoTDJTOWtoaEo4?=
 =?utf-8?Q?PqNCrdOQGCiauSEDEZGJECu+S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bab338-4d42-4824-13c1-08dd529590fc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:34:09.4369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh8+PtK8Z3zXSkhxKB/lCRVChBEP+q7I/L/ud87Fy3Dtq/tSsE9gTj+4jGXRmLqwJxBydIq0nvZQcJ1+q6Cb+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

On 2/21/2025 10:01, Zaeem Mohamed wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> DC is not using amdgpu_irq_get/put to manage the HPD interrupt refcounts.
> So when amdgpu_irq_gpu_reset_resume_helper() reprograms all of the IRQs,
> HPD gets disabled.
> 
> [How]
> Use amdgpu_irq_get/put() for HPD init/fini in DM in order to sync refcounts
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>

We probably want this one stable too, it's actively got issues in the field.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3808

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 3390f0d8420a..c4a7fd453e5f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -894,6 +894,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>   	struct drm_device *dev = adev_to_drm(adev);
>   	struct drm_connector *connector;
>   	struct drm_connector_list_iter iter;
> +	int i;
>   
>   	drm_connector_list_iter_begin(dev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> @@ -920,6 +921,12 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>   		}
>   	}
>   	drm_connector_list_iter_end(&iter);
> +
> +	/* Update reference counts for HPDs */
> +	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
> +		if (amdgpu_irq_get(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
> +			drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n", i);
> +	}
>   }
>   
>   /**
> @@ -935,6 +942,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
>   	struct drm_device *dev = adev_to_drm(adev);
>   	struct drm_connector *connector;
>   	struct drm_connector_list_iter iter;
> +	int i;
>   
>   	drm_connector_list_iter_begin(dev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> @@ -960,4 +968,10 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
>   		}
>   	}
>   	drm_connector_list_iter_end(&iter);
> +
> +	/* Update reference counts for HPDs */
> +	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
> +		if (amdgpu_irq_put(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
> +			drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n", i);
> +	}
>   }

