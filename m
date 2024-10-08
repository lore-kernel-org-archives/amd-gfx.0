Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB5CED273
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 06:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F9C10E46A;
	Tue,  8 Oct 2024 06:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHKLjdfz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B178610E46A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 06:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buL+oPWck14oZkUOz2d5kMbYPeJfMzl4nLC0vFPSJ3uXTFktlHSBFx7bmdXypILTZxLiMvUi+77j6R++1eMkEYFNH7sq7bvj1TocqL7UqS8dtNsDcDWYP1k+n4vQxXTiFewMEVGvVm98Z3OiNE+u+up+lfbkpikKkZCtAKftjDtkTWlLX1d+1HJdTY1/qg5Hhj+LV3r10HgUu8jYelvTvbi01S/LzZVeNW9vZtjE/WVXzti0cJYaOb0u7xNS6LAmOiDQBvYKwQbviMVuVBE6cuxxl8zJoai4o1xgUHgjuHGGXmGmEsmHOwjnZLL+zlcXa15Kgh8g6xQOKwgRfY+4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL0aBjczG8iAuHat5SpPYVFZB+8lHMelBtjOHtXaVwo=;
 b=ZsoIGDE+K6gRftnC4klipWSgqEy1F4cH0PiEGZUQjkDs/zBLUc9jzaws8Ps43iGGanB4aBQ5MzW8FFQiVSS+R4hTkSbGDP9gMSnJFXuWACJW2TXbTnrmG0+h1PS6mzaDTcPGu2G/xu5CjnKMJRJQz9so3b7z4S01ATkad8iMuFCq1WuSJkt9czk3DNpHu6P1UuF5a3L9f3LYK1qbFUrop6S1xZYT2c7oakfp0Q/yobLw0eavGlwGxPCs6WV53aZji0wR5ya8pf1Eafo6wfiOhu26BYgnM1lIgB+WWtBLxEKNmlkXj+9ZEfuMv0hF24iMjw6mpcXiywl7/sbOTY9D5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL0aBjczG8iAuHat5SpPYVFZB+8lHMelBtjOHtXaVwo=;
 b=vHKLjdfz0d3CWCoKCoRvdVzh5P6n7C/zdF5T6FqSe3ZqmbWCJ6krWFX6fWvVrYqHu/6VZqjPGAaGBU1UYeGuhLj84EbRuU+UU18ap4gCKXwU7ynqbWe3YL+K59cMx8v5dJoi6jNT5C6vMt4LfmL07Gru3NzCdOsHsbdDY7ZsMzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 06:58:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 06:58:13 +0000
Message-ID: <0915e549-98c7-4ed8-b6fc-eeb476de2ce6@amd.com>
Date: Tue, 8 Oct 2024 08:58:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix dm_suspend/resume arguments to ip_block
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241008035953.595701-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241008035953.595701-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ad47c5-96ed-4c38-1822-08dce7669394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2xRZE5NVjZEeG1RUXg3MGxMaTV3MHNsdlJrWXdVWlhkTFZUaXlSeTB3bHNq?=
 =?utf-8?B?d2RtNFdwbWZJd3N6VU5JNW1HNkpieDdXZXU3aVNWdkgzOVZwZWN1RDN0SlZD?=
 =?utf-8?B?QWFWaUlSZjVBMi9veTVEdmtaUlB4ZnR5ZHBCVElJU2RWdE9OLzB5Zk5pbXF1?=
 =?utf-8?B?cG1CSjA0SGhOSTFpeE53aTl4NHBpZ3ZvUjh0czMreDNUbDgwZXNJNlhnRGRM?=
 =?utf-8?B?OHBHRVoxV3dWdkUvVzlMZ2dpb01CUmhieHhoNHEwdXlRYjJGdXIvc0RXK2hN?=
 =?utf-8?B?bWJzSWx1a29qdGY0N2xZMEEwc0dwRGpYNDRvYTNIN052S2tXRG9XeUhPUkJB?=
 =?utf-8?B?NHNZQVhoU1g1dSsyL3R2VkMyc1pNNXJUMmp2bDNNeGVMeHNXdVM1T3JSNFBq?=
 =?utf-8?B?ZXFkV2U0SmFHK3NPb3R2U1NIUnhQV1dQbWN1bktNa3Y1b3FKdmJhZGtDUEFw?=
 =?utf-8?B?QmhiTUVQYWRCQmQzMnloQjBBMHBkOWUvQlZpM1FEclFML3p1aDNmZmZlTlM0?=
 =?utf-8?B?L0oxZWNJL1c0SGREWGRLNE9KYWN2QWw4eTVQa2VsNE45RERBblBxZEVheWlt?=
 =?utf-8?B?Q3VLYUswYVIybUg5dCtLVytWOGYzSFpDejJ5U0t6d3Q3a25pK0UrSHc4bjBO?=
 =?utf-8?B?cXpLWkwyd29UYnVEaTgrUFJTamI4YWowTEhzZ20yOHMxSkppdUhYR1RtODNS?=
 =?utf-8?B?bjBLQnFVM3NPZWxFNXNkQ3hnSkc3RmNHRW94bFVOeDZJL2FhbmF5eS8zbko0?=
 =?utf-8?B?UlZGd0xJTkoyUzkvY3k5SlRzd3hHUDFsR0g2WE5vejZEenFwVFAzN1FEKy9S?=
 =?utf-8?B?QWpnVWcyYWREWFhYcFB6TjFRUU1PY3VDYUxJd3RWT0RNQkRMWkY0a3IwYVBJ?=
 =?utf-8?B?RWRtSHdXUnBTaXZWSXUwZlFGMUcycGJmamlPK0kwSXc4bFUraDRRUFpDTUdl?=
 =?utf-8?B?dGJTV1lIcEZndzczMHNCZldFRjlwWVpOMFpBYWdiaHl2RlU0M21TbmJkaWhy?=
 =?utf-8?B?bnNGOCt3SnJBRTJLNVRmZkM4RnpNTWlrS0d3czY4WFg4bE5SUkludWd1T1U0?=
 =?utf-8?B?VWc4eEVJbkhIMWV3eDhib3JWWFZQNzRDaW1ZcExxMS8rRlBGWW0vM0JMTk8r?=
 =?utf-8?B?WkJhV0Q4VTI0emhybllYaEkwZmpXUmNiamZ2Wi84SkZac0Rrcnd5U3FlZFRx?=
 =?utf-8?B?dUJxcXEzSjRPaC9leVFhMTdicE8zMUVoVi9iK3gyNmhFTVQ3ZHZmQmNBOG9r?=
 =?utf-8?B?UWxTQjU3Z3hkRS92SmVtdlF0b1c4OXhwcVcvWWVHKzRnL1VIL3JaTFI2QXha?=
 =?utf-8?B?RWdEWktjTXhCQkludm9GTU5OWjJsMXlZck44dFZrakNHL3hyUXA3NVR2STZj?=
 =?utf-8?B?YWNPWXdVU2N6WXZTNEtVQW5HbE1RSXoySktRS0d5Nk1NdXRwWVJNY3RXNEVo?=
 =?utf-8?B?eStwOFYrMXRLbUlSSWkxVkNLUUlFMVlxem8reE5WRlM5NlNnSWpxRUhXM3NE?=
 =?utf-8?B?VGhQNkFhQXBSNHAyQ2ZpR0Z0K3pwNDlXUTlOdXlpcTV0cWxGSHhBVFN2ektG?=
 =?utf-8?B?bzlaZGdJQ1UvRnRBK2ExQkZvemFWQXNuNHVWcVliREcwZmFMVHdMVlgvb3Vm?=
 =?utf-8?B?Y3NmL1ErRDZ2c3BNcW5rQm5YN3dSeDMrelJjOW5kY0lEcVBacmVLb0UzSjVH?=
 =?utf-8?B?VVNLUXB0dzFYRXAzRy83RDFqY2JwQi9pMlZqelAxZllxdFdzN25aQmtRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVqWWpSUm52QTgxU1Y3djlSUC9KYitQRTJuL1VCRlErbU05V2xiaWVJNTFa?=
 =?utf-8?B?eUNHV0VTZzI3U1hVZjVDbG5ma0JWWUJLVE5rNEUxMGZTY0ZNZEpWRnlMeXRi?=
 =?utf-8?B?TktjTXZpTzRYOXJtdGY3dDZ5OVhJcmNiZ0NUUWNOSHZhNS9oQVRwbUJBeU1v?=
 =?utf-8?B?WHVSYzBoaUZhcHBXTVFvRnNhbXQ4b0l3K3cvdFp0TkJScGkxL29Oa3FtbHBJ?=
 =?utf-8?B?U1NDbGJOSE5OMHRETVQ2OTg5QVJnY3QrVkYzUjkyMEp6amtQU3c5cUJRekpO?=
 =?utf-8?B?dzd3UFBMZzVqdFlSZTBBR2pId0FzbXViNS9Id3JWaEJ6b1lFbC9HNkc1WjJw?=
 =?utf-8?B?NDIyaUp3bEU3VUhRQjBoVW1aZmhlQ3BLNkdtTWE3Y2pSTWxUbUNrcU4veXlU?=
 =?utf-8?B?cFJBUGQzNWh0K2wralVSYk1JWmVwQUtSQk9PczR0YlBTUTBuckc2ZHpwTWxu?=
 =?utf-8?B?dEdWTFpQakJ4SGFvcGYwdU9rZDNuakNFZDN3RCswaUQ2RC9xMlIxVGc4TjNU?=
 =?utf-8?B?RW0vb1Q1aXVOTDJjcFR3WlJFU2xWRE1WZk8zY0xoRm5nT1Q0V3Qza0lKSldo?=
 =?utf-8?B?eDN2Q1FuL2thK1NZVDlhTEk5WTdGUmkwakJ0bWpiQ0lHRytJVDVSMjQxT0FH?=
 =?utf-8?B?QkZTemgzSGNiZDRkUDNKd0pnbllreGFQMlpuaitVZFJ5MUhaYUJQYkhpdStI?=
 =?utf-8?B?VUNGNnpiZExmbHQvMEVJWldaNU9USUJjYklSMjRYZnVJTWs0eVNNckppbWFP?=
 =?utf-8?B?cy9hVWVldHc3V0Evc0RxMkNnT0pQWFUybFpOd3pJN3RqZEZJcVIvN0Y0dXVr?=
 =?utf-8?B?bHJkOWhnSUE1TnI0QVpkNXZOTVN4alU0TEJORzlnTTBIY0IxczR0VW9ZU3kv?=
 =?utf-8?B?djZYVzRlbXM5MWkrVVp3N3lOMXpDSW5BV3gxS3R0OHhORCtKZG96MnVMOG1n?=
 =?utf-8?B?bXd3SlU3OUNMRDV5ei9wc0NyYU96dTk4WkRSVDc3aWNFWlBaVXVEZ0hKNHUr?=
 =?utf-8?B?VlU5WlpXeHYvVXpzd1JoOFA0MWRlTzBkSUFvaUV6UlZrQThSaEdrSjVyaVQw?=
 =?utf-8?B?em1iTGo1dCtaQ1JocVNUVlVGQncrMndSd0xhM1pYNEhIcEw1SFhXcEhoSlp5?=
 =?utf-8?B?TmFLOEFCNEhGSmxJL0t3L2h2TXhPK2dBdzJRS3A5ZjQrRi96MnBpM2hiZVNR?=
 =?utf-8?B?V25tMlJLUTRMR2dXazZuZmphT2trM01IdTNDaVloNHNkMjhkK1IrYXhKdmp5?=
 =?utf-8?B?RXRrVlVjZWRGSkRYNG5UUlBVOFRKSis2b3RsTXd4cXVhWHViVlFUWUs0bmpM?=
 =?utf-8?B?QXFJby9vUmN3bXRzV2dFdGN3OGxqVXR0S1VJOVMxeng5eE1UekhLZG1ZQVYz?=
 =?utf-8?B?ZVlEQmRjc1BOT3Z4VEgrTEhKcTljUCsvUSt3WDVjUnZIK2JEOHF3U0d0dm11?=
 =?utf-8?B?Uzl1ek5ab1Z4d3YrWjdLYXJJVnNjYVlhOGxyZ3VoV2RVQjVYbllGNFJndjhV?=
 =?utf-8?B?enVWOEhHcWV5VUYxMzVjK0Rad3l5aWFYMjhpNlVub1VKSTZYeUU2Rys2MEZG?=
 =?utf-8?B?T0FSUWM1U1AyV0hsYlYwYXArSDV6N1pnUkhHVWlDTmcvby9KenpXV2JTZWQ1?=
 =?utf-8?B?QjR6RmZsRmhnZzJvdDBROUp5VEJnREpuTU1maWJhTVpKRngycHdyN29NRU16?=
 =?utf-8?B?MEtlRUcySzhKcGN3bm8rNFM2MzlNNGk1VVhZVk5iQjFxeGJIZzNPaGsvQXBE?=
 =?utf-8?B?U0h0QnhEbEJicFRIUmFyNFZTa3NWLzRvZ0M5eTVEMFlQVGhrMHFuWCt5Zmhw?=
 =?utf-8?B?MmdNaHE4UXYyM0JXNURZUUNsK055U0lrUjRhbzBTU05jTE44VkhUOHdWQnY1?=
 =?utf-8?B?UDBHMEYxL0RobDFqWmxIRnVyV0pzN1EzSjNITnNGa0pNdGhVZmxxUFhvRkRo?=
 =?utf-8?B?OWhzOW9pd0xYNHRZYjJEMm51cTFNQnRiVjJRejdPUktLWmMxUHdSdWFUbFRa?=
 =?utf-8?B?UEJoTVE1elNTVDJhYXNqbmszdDRGTGxDY2YwSXBVd3ArOWF1bk94UStWSHpt?=
 =?utf-8?B?TFBuYVVzd3hTSUsvOGY5bGhKU2liL21peVJsMVd1REg2WHZDVHhvRlhQQ21D?=
 =?utf-8?Q?pRW8MFtFY5GVkMs+GqHEU8w9+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ad47c5-96ed-4c38-1822-08dce7669394
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 06:58:13.0895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRKsIopvl21iyRPlCkI//ZlBRfTXgVY/dgISz6DD8BzH2LXrIT6JcUGExGPwR9pM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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

Am 08.10.24 um 05:59 schrieb Sunil Khatri:
> "build failure after merge of the amdgpu tree"
> dm_suspend/dm_resume functions argument mismatch
> not caught in validation as it was under config
> CONFIG_DEBUG_KERNEL_DC which wasnt enabled by
> default.
>
> Change argument from adev to ip_block.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e4511f2fb929..6d5b899941af 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5201,15 +5201,20 @@ static ssize_t s3_debug_store(struct device *device,
>   	int s3_state;
>   	struct drm_device *drm_dev = dev_get_drvdata(device);
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +	struct amdgpu_ip_block *ip_block;
> +
> +	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE);
> +	if (!ip_block)
> +		return -EINVAL;
>   
>   	ret = kstrtoint(buf, 0, &s3_state);
>   
>   	if (ret == 0) {
>   		if (s3_state) {
> -			dm_resume(adev);
> +			dm_resume(ip_block);
>   			drm_kms_helper_hotplug_event(adev_to_drm(adev));
>   		} else
> -			dm_suspend(adev);
> +			dm_suspend(ip_block);
>   	}
>   
>   	return ret == 0 ? count : 0;

