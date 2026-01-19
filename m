Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49276CCF2E0
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 12:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9BE10E41A;
	Mon, 19 Jan 2026 12:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3LHw5YXN";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC83F10E41A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhJz5QT7GOnpgC7A7bHASQYfbs0Ik3Sx7PabVhBtQfLQKS5uh5/RI3Ke1rjaDxJmHo0yWl4fB6ob01bA7Rk7YpwQhjwlbxRhmJRJO+Kgm5+RRBRNf4nTV3Sd3uSeupEoEZjWFfk+gbzLFu37rm6y57SkCRAVNwiZTEC7KS2o9Qr7oM6cV49R7VvrAvpM9hucKad7tYp7BDBuokwT6evXhiGOihtQPElnMP0WkxeOzd21P/xrwLSTI8Ynq/fZCYxt5p4o5a1D0I0gHnYPqp0U/U6vvxiGFmG8u8xunQPumGgqm8I3hfqSwUByyz+KhulkYdkL2878HWlpT2tEFI2dUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBmH5011hXBAxymuipfNYKrd+V2q/btt9hYCpuD51TA=;
 b=xXloyWYce165ib158Iq89KjKW9Xg7tCpBbg8aebQrG8Y9WY2DmX8YeWj5BFarnq1L7w15Tv43ynGc4Pb7gMObZQxUg02EiMgOzK0tcNXxyhE7NWqWISfXyBs2oFrz2+pXY+4D6ifFwzY7B0X71oFPtqcW2HAg2dPZjQ+N+aBfigScYy77HFGzN+0yICoiajeOS7oJ9upx7FR9wPum9uYewudqGC2SBoaK+SUlzS8PLwU7GcyIDwYjLM4OC1L1rgAflWYOSBkeQZQgS2lfSzxOTTL08r0jD9Lix62wps9cPFZbeURj40AQUbNJt+HQVfZye5TvM63SLA1iR1uEKtbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBmH5011hXBAxymuipfNYKrd+V2q/btt9hYCpuD51TA=;
 b=3LHw5YXNjYaCCLruWZ9WpjhwvDkSdNnVm/YzHO3z4qnaNhzMu4FripNz8jPmZRnUDj7oDM3PFvDKTOctQHJbUX+A/cB1AqrLyfm5CcvzIdkTobuAyRaVR5MLzUr2DABXxOiR9EdjB4lwWVXeP7eRLV3XftP+PLF58S8EQQE6TAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:19:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:19:00 +0000
Message-ID: <f19604a7-2c9f-4a27-90e9-cce881fea024@amd.com>
Date: Mon, 19 Jan 2026 13:18:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: fix type for wptr in ring backup
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260116162027.21550-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f345c37-5865-4756-b968-08de5754ed57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUEzcVpjdDJNUkdSUjdhbFFlSWIrQmIvYkxQZDdYckNoaUN4WkZRbjRqOHdK?=
 =?utf-8?B?VndaRmhYNnRGbWZSMG50S3VDQlI5djU4ZFJOS0t5bVkrZWdHWExsWE5VUE5z?=
 =?utf-8?B?YUk4dk1oZ2VUM2t3SjZDUkQ1WE9UYlVtMXp4OTVGT1VzRkYvNXVEbFR0VTEz?=
 =?utf-8?B?THhvNE5QZGZlQUtCK0wvbWUvU0VhREhCMkgrSW1mWEN2Zk1YcnFKR2JOM2dz?=
 =?utf-8?B?MFRqMnkxQXMzM053NWozZnQ4ZDc2NUFSdlRMbXlyZjNVTjhSWklON0VyWUxX?=
 =?utf-8?B?RmNZak1jaEJoaU5TNjlLYXJER0ZpK3BNZGlhd1dmODZwdW5qMVFYTjRhWXd2?=
 =?utf-8?B?WkV2LzZ3SUJHcExNaUZ1bWNZNmlzL0x6ZEc0M25nWHkwcDVFbEIyWFd2S1RJ?=
 =?utf-8?B?ZUptRmE1R01VeTFqOVlUOXhwWjA3OGo0aWRnS0szV3NsNEQ1b3lwRXprM1JF?=
 =?utf-8?B?M3AzQjRGSXRhMDNZOXUrZERDQWJnM1MweUZEU3N1WGovVEVhWnViWDV1SHFq?=
 =?utf-8?B?SnNvREJkS0dKR3gyNU5kZ1AydGY4V2NnNFhEcjBkVEpYOWpOMzkySTVQK0hP?=
 =?utf-8?B?YzBrS01DWEQ3OGRSWDY4RHd5Mm5mK1lnV054b0N5NEJoUnVVNkg2VTVpL1Ny?=
 =?utf-8?B?NGpXT1A1d1kyMVRTTUtIcE1oQk9icGYzQUZIbWNyOTJocVBkbjRkTmhUUnVv?=
 =?utf-8?B?N2NiQVlVaTdLMFgxVk95RW0yTEpxR0svUk1Rb3NOTlNwU0g0RUlKcFpSOTJC?=
 =?utf-8?B?S2VEZnpGTGpIU0VscEpWaGV5VDROVGlZN0lLSGpaSEl2dEw3TzMwWllJTWNZ?=
 =?utf-8?B?U3phOUMzR0sxS29CY0VpR1BjRDArdkFlaEhzQUFPUllndTg4bGRRbi9MUDFP?=
 =?utf-8?B?d3M3VWtzcGVtR2M5bnNIa0wzRTBsUVlGaVl5MUYrOENVd2I0c2dSbzRuaklz?=
 =?utf-8?B?MVc1c09oVGtqUXlnTTRmZER0alhVMHk5UkxXODdIRVk4N2tIM3NxazlYb2RY?=
 =?utf-8?B?djFFVWk4WWl3V3RYVHlkQ1NKNHBqU3ovV2lCdVZzVE5yRXAxSVd6SVRVWkhn?=
 =?utf-8?B?cDMxeCtuakxZM1d1WnFBVE1Ya2RYYmZ2UUc0bDhRdTBuc2JhcDlQdktLRnVX?=
 =?utf-8?B?QktWUmtlb1FlU1VhS3NyQ2w4ajdIajFOOGNmQVBPdWNjb1ZSdU02ZER0VlRM?=
 =?utf-8?B?ZTVnTVU2cU5HUEZvNWZTUXBaWGRqb1RwQVNEeFh5NFVEQVZNVXFic1Jja2Rz?=
 =?utf-8?B?ZW9FR2NPaWdONUt0NktzYjZ2UzcwaWJnai90M0hDNkZMelFjMk9oaTk4SkFJ?=
 =?utf-8?B?c2hoMlBldkxYR1hybW1WR25mUWZ4SXJWaG5IMk01NDdCYTVlb1Buakc0L1BI?=
 =?utf-8?B?NGZheW5mSTZPTkVyU0dXNUY0WGhnUkUrSGluSHVxYUtqOGw0K1l3dW5kaU1l?=
 =?utf-8?B?TUtOKzkvNTROT0FJSGNVdnlEREQrTmNZK1pNRXhsTU1CeGo3UTJCV1Y3Q3h0?=
 =?utf-8?B?TXhOT3lGVEpKMk9ZU1BURGxTUFNWa1Rubm81ekZrc1RzSkJMMGY2RVF4alh2?=
 =?utf-8?B?a3lURE96K3lHQ3ErUDd2TzlrUGVNNTVENUxOc3I2MzZldzBaZnZzWE5YU2Jm?=
 =?utf-8?B?eVBVd0Juc1VqVDRqajZNREw4Zk5BWm9sSzdtenpRNk9rMGhTanYrOU4rZGtD?=
 =?utf-8?B?Z29qVUhBL0R1RWhqalBJV2JETFk4WExvTFk1L1pCNFIxTVFpVUc5K0VGeXZ5?=
 =?utf-8?B?cklYMGUvZWl5NllLSjlvdUFsRjI4VFJVYVNYejdzUHdoUlFpUCsrajdkT25h?=
 =?utf-8?B?YkxtRUVibXVpM1V0YnNzOUt0M0NyRCtJY3g5dGM1WFRrbzBYUzRTSGI5MWRX?=
 =?utf-8?B?MUI3b3lmTjl1cXFsMDBxY3o0eFF4Um91SjhXRTlOMGNHRWFOMTNoQWJmRG51?=
 =?utf-8?B?S3loUW5RZ2czNHEvaytESjZFemhyWS9VNVpBTWZlQnpUcllzcDRFMU9UeWEy?=
 =?utf-8?B?eDFVeExTNzhTV3U4V3JMM3BKQk0xQmI1eG1aWEdHSDRZS2pjL0cwbGpLa3Ba?=
 =?utf-8?B?OExhd1k1RkF3MlpwZWxsUllZNUk0UnZXallwcEQ3MTN2NmJCYTBZSGJOeE04?=
 =?utf-8?Q?rpzA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFY5eEFyZUtqL2NXd0h0SDhzL2NTaGdCa0E3cjk1TnBPc0FnTEhZNDdxWFlH?=
 =?utf-8?B?Z3ZzMVlkN2ZnZG5LSHBCMjYzOWdsS01qL0Y1dEtQUDhTaEVjSkQ4eTdkRjNM?=
 =?utf-8?B?cVhBOUVxbUJiRWZBb3FYWGxNWituQWNJRndOSi9TTVZJcFVCWEJmSjllR21R?=
 =?utf-8?B?VEhXYUxrRTlMWTN0d2RscnF3cGoyU2JEbEdYTnVrMDRHenpFSUZqaDJTZUZn?=
 =?utf-8?B?NWVtZHVBZHhmVWpWZVFTMm9WTzN5SmN6L3pZcXRFVlhkRWxtcmxjcFdPbjAr?=
 =?utf-8?B?SEFVSU95TmxGR1QzcVBSd1JQK3U5ZDIvZXRyMmxuM1BrR3ovY0JqUm11djEv?=
 =?utf-8?B?OHJscTdqMHF1dEtWQSs2UnhVbHo3YmVZOHFzcDdqSVhiQ3lHK0RXbENEZkFN?=
 =?utf-8?B?TVVORnlvTHZkZFVKSDhQM3I4c2s1WUtEWXJ1aVVQOE1DSm5wdXByemhRQkV3?=
 =?utf-8?B?bzVnM1BycWxPeU5uaFJOR1RVS2FPSERVLzhHNG5JNkIvQ3ZJTWgzVW5Help1?=
 =?utf-8?B?V0p6bHhTZ1UzV3dOK0ZwZ1dJT3NQaUlidDJrekF5by9paXdEWC9uZkRBWlBR?=
 =?utf-8?B?elVoSFQ2c3UzKzlTYURVUWZNSXZueXhWLzU5MTFxUDBZdDlXQjVXeXV2R0kz?=
 =?utf-8?B?MWlqTDNIWTRGbTBkNHJwUlFIejFXMjExZnhrWC9lVVVBeU9VcCtRMG84a1JO?=
 =?utf-8?B?NkxMbFpMRkZxb3ZER3E4bFZ5WWRqU0FOV0llNG1melNrMnNNa1FUd1poTFZD?=
 =?utf-8?B?NmhwUnpzV3ZRYm8yaldvb0N4QjBpNTZUM1dyTFNrcHJTeVZhS0x0Ri9YdkJv?=
 =?utf-8?B?dVp4ZmtKM0tBTXBmT2wxOEJydUdBNWo1S1RLKzQxQ0lDRzJpdTlZZy9TREEz?=
 =?utf-8?B?T3ZFbzFlM0JEc0VXMWpWRWw4L20zMUQ5OW5jR3FKNkliLzNpS3BSZG1DTFM3?=
 =?utf-8?B?eUVUUnBUWmNlQ2x4MVVzWVNJakdmeVFac0lzb29qSWtGNm4yWkFWb3Job1pV?=
 =?utf-8?B?Q0lNTk5wdGJiZzZ3WExtZkVUbGZCdU1ScTBxWEwxSVI3WkFTek4ydnY0KzlT?=
 =?utf-8?B?QUVlRTlXUWdBMHBvbEFXMTFrSGtIRTN5R3FLNDFSRWRtTUo4ZU82TmNmK0hB?=
 =?utf-8?B?K3Byb3dXS2drM09GRkVDMlBML0N4NUFlbVkvRnlsckgzRk9sZlVtb05ISllI?=
 =?utf-8?B?UFlGV1FtUXhlUlExQVJtTVl2TjhydGtUSTJJeU9uUjRLWURCQ3JXNklSeXVs?=
 =?utf-8?B?bWlJYVp2ZjFkU2N2VXhQL2duRlg3ZHJ1Q0hTb0pSUCsxVE9wZUZoL29tVXMr?=
 =?utf-8?B?VWs0c2JkZDU0MERaYWpJT3ZWOEVudFB4V2RHeFhacEpQNnpjdE5yWE52WUwv?=
 =?utf-8?B?WU9udVRKUDNycW8wOXA2WWJUcFVYbklvc3BSWmNhQ2hKYUxlaVRLYTJUN0RX?=
 =?utf-8?B?cFZ2WU1Bc0NkS1pQbzRPR1BBSkw2NXRVVlduUmVhbGNJQjlqM2IvanJvejdm?=
 =?utf-8?B?bHUyWDM2MWtHSFE2SVdET3V6anpDYWdVUjNPVGQvVk5JR0JLZlRBWVdyMVJx?=
 =?utf-8?B?a3FCVm9ET2diRFRHUGdJN1dQeWNmb1g1SCtPTG1TL2ZNK2ZOZXplU09EdCtH?=
 =?utf-8?B?WklNMUM3akpyTmFYQ1NwckdRN1lkd01wZUt3M3lFZG5ocWNvZEZ2U0EvNGh0?=
 =?utf-8?B?TlhXOVdib0xaWmZqcDdYWHplWGJHeWEycUtDcXdxbktPRkhDQTJjV1NTTGdW?=
 =?utf-8?B?dUtvMjUrQ2Y1am9tQXRKVHlzNnY3U3AvUkJzNGFHSTlQSVFrRFF5OGo2cTh6?=
 =?utf-8?B?aVVFT1JvVVZmNHVVTE5JWHBlVnU2WlcvczE5RnROOVhmNVJFcjduNzlUc3NS?=
 =?utf-8?B?MUpaTUNxRWkyRXc2UldEdkt5d3h5N0ZkVUVzcVdabVZFM1ZLbmZFTUlGMmZq?=
 =?utf-8?B?SlJhMGdsUHhMWktNUmNDd3o0OHg0SHF4Yi9nY00rS3BqK1dFcUhTQndHajZr?=
 =?utf-8?B?YytTb05OZUFtNU1EeWxQUi85UG9wVGRnQXZNWGtrOTBpTCsxYnhXT3NkZjRF?=
 =?utf-8?B?OHhud3VMZ2kxTWk5RFg1NlZCN21KaUFpZzBaZDJHZkdYdzdVdDlTNnQyeTJj?=
 =?utf-8?B?WC96aXdCZW5oa2RvbWJ4SmZoakYyc0VEVk1manNEWFhjQTZzaGdqS3VUQ1JD?=
 =?utf-8?B?UXNvcFE5NWxjNTgxcW1uMXVLemUwem8ycUVpK3RhczRTdmdCNHJvOFlVajRW?=
 =?utf-8?B?VVdWM2t0UGt0a28vUEZES0F0UllYcVoyakNNM2pyMGZUYWZtVHZOTEdtQjF6?=
 =?utf-8?Q?RnBUDG/O7OZHj8abIR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f345c37-5865-4756-b968-08de5754ed57
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:19:00.7177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4N2JWzYDq8eusQQLbyduBUHT+QsMG7QrG+c/aYuA8uPTZY9h0PfxjJaiTgPSBbS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

On 1/16/26 17:20, Alex Deucher wrote:
> Needs to be a u64.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 3a23cce5f769a..f2f0288b7dce4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -764,7 +764,7 @@ void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>  }
>  
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
> -						   u64 start_wptr, u32 end_wptr)
> +						   u64 start_wptr, u64 end_wptr)
>  {
>  	unsigned int first_idx = start_wptr & ring->buf_mask;
>  	unsigned int last_idx = end_wptr & ring->buf_mask;

