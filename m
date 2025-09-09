Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C71CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 15:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6210110E79A;
	Tue,  9 Sep 2025 15:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RC4rh6iX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C6D10E797
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 15:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw/BkelQMqfATgrYh4LTuv8ZGQ9UFjU1Oq8MQVjCXX5nkho8FtkJQj1IcsEQrHwGf/ACAbtiPknCvjt+GYuwdT/+jSwBkVQU88DtRKJiiyntHB7wwoROVPkfh3iCEEhjhGLZWrki+s01i0GWlZ7pORl9nV3VmMSINP7Zk1ntr6t//UtSULoyW7bOznVRpffRv1kb0iFYGD2fDuOPTXWxEHbZF/9lVc6I39lrQBpttgsFBCzG4EI8mCBhw21Ey02TI6GNwesalzaD74PmcgHZ5wUgZlibD43A0AWnIl7iZ1KSVl1OhbT+XcwahuZcV3axO70VIy6lZDr0XByF5coFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYFF93Uysn5EhQov96fdnZ9J2jvi6ekDQOfOTKl8kEI=;
 b=QSfB42larLc/GyJFgFTS6rlVSJFIc0R6IuFxyoDACJzscxsYHQ6o66bpS6jeMEiN21P0o/ZD2r19vJyk/NmoqKz8RAHDSuTQ/Dgcty0WBrIl4LdZaw7BiTuwmVffKUZyE7XeUizjBQghI1WBXJethcQnUh0Gwgl43gq2HNpiR0XOP02srLZWSdrO4FpfhED1VYIY7I5zsUcqfyaMUDYAfvwzMPmu/5Ez/aVkOwfXK5aUQj55DVspDxvOsl4qdnuUFbqOCqkcesjohgXVublgl1eEIh1Y1OxyNYgYD5ErwVk8BMegxTZVEJAzLCszQTvwkxftCQb+0gJjnMUFhECeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYFF93Uysn5EhQov96fdnZ9J2jvi6ekDQOfOTKl8kEI=;
 b=RC4rh6iXMCBJy+Er/oHsCrJzJ79/Rm0EYb6kFasr2+a/7f2LDZvxF/+YiC7tkDuMImAzkymS7UsJvO9EOODGoptj0LYv9hVGUUgI/N/hg3FkSvRuVtAlQ1ZlUt1MssVETh9anZ+F4p8wzN5kNltIgBVfzwhGlG/W2/DMUUirWo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:24:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:24:01 +0000
Message-ID: <a136b941-e885-43f2-aaa8-337da48d4439@amd.com>
Date: Tue, 9 Sep 2025 17:23:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Use memset32 for ring clearing
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250909144937.22452-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6117b09f-7bd7-45b5-5535-08ddefb4e749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDVkWG50ZDBQeUQ4QS83Rnl2U1laMzFpV3lXZk12alkrQzVnUUxNdWlXNTZt?=
 =?utf-8?B?eDFoNDNxMGpjOC9UWWtPaG1nUUI3dVhCdndBVjMreVZxYnlYck0wSWdVRFBh?=
 =?utf-8?B?M2Z2b0NpTVowNnR6WWRYa3E4aUdYUWYzcmRjbDMwVTNCbStXR2tHRktWUXRm?=
 =?utf-8?B?TUhZc3ExczdCeEZoSVN4NTNqTk1WOHJrUm9PTk1LQmZYSzZKVDdWRFpIS2My?=
 =?utf-8?B?MXk1bXBtOTBtRW5CbktsRURhaW9NZHQ3TXl0NHZyMHN1Z0Mrb1pScmcyMmxK?=
 =?utf-8?B?MUlra3AzUkN4b1hDcDNPSkVuOGpLVDdSeVJTTnJ1UTd5VVRia1Q3SVNWNnF1?=
 =?utf-8?B?VWhwY2pETkVXUGJLU0JEd3l5VTRqZUFjNnZkSVRvbmZlMzFkdzBGNnd0R1I0?=
 =?utf-8?B?TkVEMWpQUko0VUhnUC91U0VvS3VRQWhRMWdIZHcvdkpGR3pscDg5NEF3ckNU?=
 =?utf-8?B?MDgybWNhYkdER1JpQm5QR05md3Y5S0ovcTlCUzhGcE9ESm81RU9hWmc0enJ3?=
 =?utf-8?B?Ym9WYVBYTlFRVlNuNDNwMm5JR2g0bTBMNXhuMElmY0dpTzV4cDV5MThSd2RP?=
 =?utf-8?B?clpiSndsZENENXBZSE43TDluVzBxWG0yTUZMTG5LWDNNUFRQcXdnWlE0RWhD?=
 =?utf-8?B?bjBDNzR5Umx0Y2JhK3ZOYmhhUjRSdndVUVZtWW9Rdm12eVF6RHJLcEZKMmEz?=
 =?utf-8?B?b1drQmhvNXVrVSsvS3Vtd08xdE5iYlJickhudVYreXZOdStmNlNFN3gxaDZB?=
 =?utf-8?B?b2xHN090ZDRiOEkwa3pKTCtiNnBGTERQZ3dBVVd6SXF6d2JVK21jZ3VLTWNa?=
 =?utf-8?B?L0dtNTRLSVRWcDk0bWNYUHZJSTNpYWtGWXhPU3pLemlGV0tlSTBqSnl6V25M?=
 =?utf-8?B?WFNrODRPQjlGQ0JtS2xzMjU2N0hXZXNlU2JIeUFTdmFranV2VFJIRnQrM2ZC?=
 =?utf-8?B?dXZPbXB1MzBkMFg1U1R5UTh1N3lJRXpPNk02eFVYSFpwRE1nTTM1eWdNei9G?=
 =?utf-8?B?TGRHZENUYjIyYWloNEoxRzNpYmZoMHE2WGNqaXNCTzZlRlQ2Y3RMY1RyZUpk?=
 =?utf-8?B?S3ZOc2dRNEJOYmE0dXlwWVNURnBHZFpIeDdudVJXN1ZIR0VUSzNhdGt5cGQv?=
 =?utf-8?B?dklrdUVSWmFqQUo3SXlpdlhzbHZLQjFZQ1M1eDZ5WFo2RVpadG1KYW5pVkRy?=
 =?utf-8?B?VXM3WWgrdU5WQ0JzV21rN3BZai8rWjRXeU1tcnZ6bmk4NzR1ejZNM1NST1VU?=
 =?utf-8?B?UEtlU1J0cldWS09RYUdaK0FxWE5TQTdzZTEyZXp4eDZCYkd1ZXVicXM4Zkxo?=
 =?utf-8?B?THJmZi9pc3l3Q3IrUDhiQlo3bXZiLzNQK0lydDloV3JVZjFneC9SRXcyWHRG?=
 =?utf-8?B?VEF4YlYvQ3lQSXgyN2s0eGgrRUZWSjllU091Z2JLdnRVMHRoUFNIWC9OelR2?=
 =?utf-8?B?ckI2eGw0ZDl3YVhRZnNRb0g0d2VIb1B1U2ZmQi8zdWcrTHRrQnduL0hGazRL?=
 =?utf-8?B?Y1N3OWlBOVFESCtrU0c2U0pLZ0RqQ0l4N2hEdmZ0eTF1SE9EQ2EyNi9pemlE?=
 =?utf-8?B?QWJQUE8zUW5GMnJ0SDNhTEs5VzVGd0M0N2tKN25uc3dGR01OYmJXNW5RYm1i?=
 =?utf-8?B?YzBXTmh6YlBZeGI0b28zTEhJeEZtQlQvaUV2ckdvVEplNFAyVXIzU05OeVQx?=
 =?utf-8?B?cjY0MFR2NWVyYXhrOXR3Y0lFa1F0cmhyOS94akYrZjVBNXYxWFhwMytjdDJH?=
 =?utf-8?B?aHg1VDBmVThnUTlZdzRlMlhsVGRmZWpXU3VhZm5zcENSQ3JaQk9ad2Z5Z0w3?=
 =?utf-8?B?QTZXTk9NNzltZzVTUGhiWVU5cUpYeFVRK2E4Y3ZnMCtQQU9vdk0xVDlzYU1z?=
 =?utf-8?B?MU90eE5TKzhRU1hBVUM1enVyTzRwQnB3L21FbkxhRWYzbjQ0WUFEOUh0WExL?=
 =?utf-8?Q?bZdc2npQHko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW11NGEvN1hlRlBjY2xzVmM1dUtNZGJaZ0NtejFCa0dFQVA1aTFPeEw4RTEx?=
 =?utf-8?B?dDBxcWRPUmZLZm13Ti9uOFkzemRQalVuY0lycHNManp3dnZIMFlDZzdLUFUx?=
 =?utf-8?B?SGlsOTU1NDl1bXJQMVBNcHJXVWFxdlZ1bzhNMHlwSFNxbW1FR3liWk8rR2hp?=
 =?utf-8?B?bmpySE1HUElZMHFMeWtYdndsdVNWYXFOb0FoWjEzUWJNa3cxaVkzRjJyMjFa?=
 =?utf-8?B?a01GZ1ViUEw0SlJiV1AyZk9ISCs0YVl2K1FRS1hvNUxTTWdCMVFLbXgxVzdL?=
 =?utf-8?B?dWFENWFmeituVWtrZllIZnJ4TXNENnBwN2xFN2M1V0tXQ0k2cFF3UUhQZzM5?=
 =?utf-8?B?OHZOajQyNmdCZHYvblFCclp3NkZkSVQveVBneG9pZ090UmMzdXF1MkpnbUFZ?=
 =?utf-8?B?Z25ZSEdzdGJwaURKZU9xMTI3R0sxakJBMVBiSEtFTWdJd0dTWGtxOHUzTU4w?=
 =?utf-8?B?Yi9GTlgxT2tQeTlLdEFwYThTUGtXbmRQd3IyUDNkemtFb1JMQ0xFTDBWcEkx?=
 =?utf-8?B?NVE5NHZQZWRxWHdFVEhiZFdYc29XS3VBcjZpVzVBNmZtMHZiNDVENW5kdDQ5?=
 =?utf-8?B?UzhqWVluREY4WWg5amc5clFQRnpoSnN5Z05RUUFqQ2dkMGlHemVDWmE0ZjZk?=
 =?utf-8?B?RHQ2VFJqYmcwdDJiQUdvcWdpWTBLNE9odC85Wmd2QkdEUHJQejVxSTNDQlNu?=
 =?utf-8?B?aVFFMFpSN3FXa3FzWVluZktrR2M0ZVdueHZhUVBOR3FnMjVzc3B6N3AvbFFU?=
 =?utf-8?B?QWllS2ZreGdSQm5XY2wvUUc4d25aa2ZUZjF4V3JPVU41MG93ZVJiQVpiVSs2?=
 =?utf-8?B?b0ZRUTdJeVlDNjhrTXEzQ2lPTWFNMlJYR0MxQ3BiNWcwVjdHcGdFTHBSelZ3?=
 =?utf-8?B?QTIwelBsNWNyRjl5TFhBbFNTMW5nZmF0aEdFbWtFSGpJMDVwTFk5bWRQNXlW?=
 =?utf-8?B?SmE0dDBESnp6d0FqK3BqU0QxdGo0THF6ZkNHQk0rRHgzWjVLM3lLSy9qcTVy?=
 =?utf-8?B?NXNtRFJyeHlTRFNGL29UOHlPaDAyZW8zbWlSV1NXR1dVV3oxQlRtSDFTa2Iv?=
 =?utf-8?B?ZmQyYkU1MkZsKzZSWmh2V1RzeXZHdW5GeFo3QzQ0Rng0TU1iTHJrTFN5Y0xH?=
 =?utf-8?B?SG5uYmZ1SUZTbVFaWllTWkhaRVpUcXQzTlVwdVdEd2lKQjhhRE4wcjFKQ3hD?=
 =?utf-8?B?TlVYUDJpQndzbEp3aC8xRjVtam1HV21JSnQ2VDF1N3NCNkZjTUsyNXdXTHBN?=
 =?utf-8?B?UlU4THBsNTBtUHlBUFduWjlmQTVPcU5Da3dSVGkvbXlEV0RQTStaYzRJVjEy?=
 =?utf-8?B?Q29WL1RabzFKbk9SK2JoT3RyaWVUcEYwc3pQSElFSlpKNVNhRzYvOVlJSDNQ?=
 =?utf-8?B?czg4NEJOVC8xWUlHUXBhMG5Kb21IZGhIUGo2K2ltL0xGOEdEODRScnVCcVFz?=
 =?utf-8?B?ZGgxMU40YS9Kd1VkVFRBeUtkbCtZUzZWeWZNSUNmQUJrSW1EWStzL0ltRkc3?=
 =?utf-8?B?bzFHY3haSlE4c2dXQmFtYlVNdVA4UXhNWVZteGMvSWdlNFVWdmhYdm11NDR6?=
 =?utf-8?B?UHdWeU1NQi9TL2J1RGZWelRlakNwL3FWbDUvTFVyL0pyYjVpeGlWM2hQTDQ1?=
 =?utf-8?B?TXZPV1htK01IK1R5YzZDNmgwYWNHeDlvME1EbW1PemVzaGZmQjJXcFFVUGpo?=
 =?utf-8?B?cDRJQzFHa3NoeTg4QTFIRjhvM3Y1cC9xV0J5Z25VZnFlcTlwalhoUDNYeGtN?=
 =?utf-8?B?dWdzeUFWY3JGcVJseTFlalRnM0dld0tOQWVQdHM5MWVGcDJ4QUZCelNHejBI?=
 =?utf-8?B?WkhremZtZnY3bnY4U01aczh6d1VINDFycFBCRkc4UE5OQWFCL1RYdzM5dXJ3?=
 =?utf-8?B?SnYxR0xqRmRWa1grQVpDRGh1TVByOVQwd1JxTno3M1dBY0lWd3B3RldYYlhj?=
 =?utf-8?B?c2VuWTZMMnlGVDFTOGNUNERqZ2RPN3JicWQ5cm82T0hCV1VvYTN0MWdJQ2Z5?=
 =?utf-8?B?RmhJbVhYNHMwNFltTmovN2NmRzN5allocWI5UFhrR0tBZHhtQ092dHFhSGtm?=
 =?utf-8?B?WTRWRlNNK1dPZEg0R3RjajJVc3RNekp3RjBRM1JuekY2clZ0dnl4SXpwVWF6?=
 =?utf-8?Q?cKm62YEAasIwSPAZUmlknEFVP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6117b09f-7bd7-45b5-5535-08ddefb4e749
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:24:01.2791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDtMPxQpjzS3qDk7fg6U/5HmYcHRAuVcbRYpzI5jTOyw/Sl0Pbm+95VyUt+GRMO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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

On 09.09.25 16:49, Timur Kristóf wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Use memset32 instead of open coding it, just because it is
> a tiny bit nicer.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 12783ea3ba0f..20133ff43af3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -481,10 +481,7 @@ static inline void amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
>  
>  static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>  {
> -	int i = 0;
> -	while (i <= ring->buf_mask)
> -		ring->ring[i++] = ring->funcs->nop;
> -
> +	memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
>  }
>  
>  static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)

