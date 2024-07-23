Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F21C3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 05:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD0410E39B;
	Tue, 23 Jul 2024 05:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p3DdnhFr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D2510E39B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 05:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K80gpFSoo8b1gH7bE6iA0eLpSToOh5wngwsouJLVmuM+cKKWWhG6Y3jubxNGhq78KVorapEV/Y7BlOCniDKPHfWUMIYlnOE/zmPMqSz7gBjhKBECeuqs9EUqDPZl8fJMs8YuO9eXpVK/zXkXJyaP8AHNgXdpir6fJ/bp3K4YFcHCsN9f1Xox8A8r1zDua2RP1L2urfloXfezpHGZ8TNV3P+KKQiIzyi0OpMzQRZO8qSUggd+2losU7+60KX7LoRcUuDjbLNXAL/xgXIO7FJmo7IG8H85kTX13zEjPbU0mkdcv+TbcVvlwKQfC/skxC9foWT7haPkp5v0xcnvCfpH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqMQ7gR2WuNcScHw5X5NaQ/Bc3acJJA/P1bKqkJgPWs=;
 b=e+DIKI+SLRZcWbXEOfpcVG0S+yPH0d0zXfZfrAhTCb015oy1zTIvhDsKrOVozHp6WB75l7OvB2fzsJMxDFtcxA44Ef8c2nviz6HeGwUfgvOZ7/HcX//wjoGgX6l2PJ1tf3dzo7rgpUCIgh+w98oi8CHzXUxaXgmRGScCXnqd8Mf1mYOQFkuhiVEew89kp0Xr9ELjg/qoUAb86wLNNuNlf7KV5eDlJydPuYBT5f3DiqB3NjYbCcA5fypLBU/oZc0GWtALoK9gBOehU8QRjVmXXMXrgPSiaSfUUURqWHjDZ3Bw3uTf//hPi4ixRFEGzbeESOLyofvSwWQQP4avpwhzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqMQ7gR2WuNcScHw5X5NaQ/Bc3acJJA/P1bKqkJgPWs=;
 b=p3DdnhFrQjTLizlB8qAiDioRSYsqUKUJDbn6PqFIoEcJjwfSGam2TdBlFxRmpqU41JUs7ae1hPGNfTWUyZhAEB3fBh2e+9wHzcqxnkFE0GWhTqHeoUjy90x5aziNbW7eNnaIgVWCiy6ufZXVNbVV3ZqcK9eRAb07PDJwcAiImZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 05:29:06 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 05:29:06 +0000
Message-ID: <1a023af5-21b4-46e7-bd61-94a7aca6e798@amd.com>
Date: Tue, 23 Jul 2024 13:28:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add null check for set_output_gamma
 in dcn30_set_output_transfer_func
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Roman Li <roman.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240716152445.228728-1-srinivasan.shanmugam@amd.com>
 <20240722114817.3935101-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240722114817.3935101-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5da032-7f1d-47df-3940-08dcaad85eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnhTbFpRNUdmUXRaYjBlMW9nU2x3cXE1cGxXc3pkbk5sMFFSdEhRaDRhZDhv?=
 =?utf-8?B?TFFGNEpNdzU3WXJRVjBEL2REWmlLNm5NbUU3RXFLZVlmT0p0QzVTaDUrUm9V?=
 =?utf-8?B?VWhmdEk3OUk4OElLOTk1ZlViQ2puSjB1a05GRWw2eE5mVzg2R0t5cU1CMEdY?=
 =?utf-8?B?ZFMwSlVPZmIyaEFOdEVLdGc5MFkzRFZmUU9IenJseStlVmRFU1ZtdURKVm50?=
 =?utf-8?B?L3ptVnFQenJaZm5lWUc4dDdQOEsyOG9XcEZzT0RrTG9CY2E3MkgyeWRhalFM?=
 =?utf-8?B?S3IrR0NaWEwrQUZVbVhuVDc4S253K3FYWWVlTjZiVWcwS3NoL2hRb0RNRGFi?=
 =?utf-8?B?eHNYNkhxRjV6c2V2d1M1cTJYaGJETTU1aU1FUGNpaWRUQXdNcGNCNTc1NkFu?=
 =?utf-8?B?djFRblllYmJSOTNhZkUxdDd2YlZZSFNuRFZZUjhIQ2IvdThTMDR6SUVySFVy?=
 =?utf-8?B?ZlovOXgwWlBzY1l1NFkzRWJsV3B3dG5qUlFDOUZFT2ZyTGl0ZGtMemFhZXdG?=
 =?utf-8?B?cnVsOVlSS3o0N3NqUjdhZW5rdUtHMUM3VGd2K1BkSTlDRFU3cTBEelZRNVVJ?=
 =?utf-8?B?RGNwT20xT3puVWRLQWNPRjNLNWxEZElvNnUwbWN5NnNmajdibE4xVStEU3ZH?=
 =?utf-8?B?YW5pUWs1K2xZTmRoY3daWm1MdzFOQ2tjRWxKSXFzT1Bka2preHNEb3hIcnk1?=
 =?utf-8?B?bGpXMG1pS3poZGNSVWV0c0c4ejJpdGEzbUtWN1FqMnAzeFF1OTk2dEhuWkFx?=
 =?utf-8?B?cTNVdXpBeUJxblQ4MkVMZmMzRjhLUDRnS3lBZzlYTi9HTmNQamQ5UEdZM1hY?=
 =?utf-8?B?M0YzazU2eTlnVFAyL2hwSmtDeW01UTFQQXJmSno1ZE1QQWlBQjB3OXRkQXFM?=
 =?utf-8?B?MHd2VzFnZ3RCNUtpYnFWbDF3cm9KbFJpM3J4cEU3S0VDQzR1NVpQWm1NKzk5?=
 =?utf-8?B?eGdKaXJaQUZ5M21YaUVxcFZyb0tyLy9GU3hsOXJaMkNhWU4zeHFPL3IvaVBk?=
 =?utf-8?B?S2E4d0QwNEVZRVBOY09QN2t1MlY0VFA0UEx1R3NzaE5rNzZDRW1mTTdoS0hG?=
 =?utf-8?B?eG5aSW9sQUlpSHpaNVVaQWcvdXJ1MXlDV0E1bFVuOUJoWWdJekFPOUppaWtQ?=
 =?utf-8?B?b3BzQm1uMndFTWxyMThWT1RGcy96MGtHTmVpbEV4VTlFNWJrcHB4andZb0VG?=
 =?utf-8?B?cjJ0TUtZVi9DRnVSeEJzUlpEVHlkMEg4YzY1TkZrajNqc1p0UXA2VXk3d0dN?=
 =?utf-8?B?MHdSUlRZRFlOVHlqZFc3aHlJUWp6ZndraENTY055OWdSUkZsRS96ckorN0Zz?=
 =?utf-8?B?WW9oOEJVMndQWDE4OW8yVi95LytpN0pVK2RIYzE5bTlDTTRMUnUrdHRyMDEw?=
 =?utf-8?B?N09LRG1xSFZsUXhBQjhNdFVFQjBFUzZYN3hLZjVEK3ZUMlNwZTB0eXFVYmNv?=
 =?utf-8?B?ZndTSE9la0VhVllnQU16a0kwQWV2SlVsUXJlTlMzZkRkOFNubWNaenhBVVJS?=
 =?utf-8?B?czVPTE9wdm5CZW83U0JkZlJRK0Zab1UydXEzWE5qRXRKM1AreG4zekRYdFYr?=
 =?utf-8?B?aVQ5NnkwcFYrVWJhUnIrWkRZSG9HRUxHNTY5b20xUENWTjFpV1MvMXJUcmFC?=
 =?utf-8?B?U1k3ZFVyZUVLL3hGeDFOc1o3R0JqTEVoWStPa3hzTXNTc21iK0RQYzhFbmxC?=
 =?utf-8?B?L1FmanZGTXQ4OWF3SzAyL3NvV2xaT2duV3Y1MWdrYjhyNWxpZ293RW5TRENk?=
 =?utf-8?B?aWVtRnNVS1BBYk4wNnVlN0k4Vm9hVXc2NUYxV0ZTT3Q0cHlYZGlUdmNjUVZR?=
 =?utf-8?B?MVNzbXJZdXdnOFdDdmEvQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9aUEVNVHBkKzBDc1NsQ1RpMzl5SHBoMldFSnViY0dZZDd5aHd6cjdEWEQr?=
 =?utf-8?B?aUdmajVSSnlHdmdXRkF5SmFKaytsNERjTWJaYUpKb0wzTFkwaWc4TEJYWTky?=
 =?utf-8?B?djhUczVTWG1Ybm0wOFJNcUd0bU1rWnRkRmxVS2FpNk1FZ0hrVjM2QWZMMVUw?=
 =?utf-8?B?Qnc5NkQ2RFJ6U0JOamR0cTh0YTZHWGtMUEg2UktldFhid2ZyZW04aHBQRU12?=
 =?utf-8?B?NkhuUmNLcmdVWmNITERqNmo4VERyd3lwMWNPOHlXbG4rYUhtRHNGNStWM1Vq?=
 =?utf-8?B?NStpeHIxYTJEK0w3M3Bzd3F5cXBiV0FZSU5ybG9SMEdBMFl6elhEbXUwL2dR?=
 =?utf-8?B?MUZaREFFUUw0YUVTZTg2aVAyOC9qL3dOeWtqRVhSWnZ2aitrVDdRRnNtRHBo?=
 =?utf-8?B?Yk9odEJJQVRHQVRBSmFqclpiRm9FZGlYSEhveHRIVCtFV2lNVEVsZXN5eWs0?=
 =?utf-8?B?Tm1LbkIvV3Z4b05oanYrVzR5SkVUS2w0YTc0VjFwWGd0bEcraVFOcEtxQ1Nk?=
 =?utf-8?B?SlNaKzNRb2s5bEx0UHR3aUhCSlQ3cUVSQkxXTWduOG5JU1pkWWlDWGlPUjZt?=
 =?utf-8?B?RGs2VEs1ZGd2VnJWYnFlRnFhOW1RaXdsRys1SmxlcGV4YitsMVlxbCtPSUJu?=
 =?utf-8?B?by9TcUUzbVh0QXZDZDQ1L3o2djJyVkZEWWJIdmNPNWVqQk5CVnU1Z0ljVHZH?=
 =?utf-8?B?ek1tRVczK3NIOHU5YlU4R1dDYko3dlcwVDNnRURyTUR4dlZTTnh6MFRVWDNr?=
 =?utf-8?B?LzJIV04yeFRMTTZLbzltYjBqOFlWaXFlSEtyVWR4Ym12YUFaSkZzTnRmTlor?=
 =?utf-8?B?S2NNcGc3d3BFUGhSTGxvaFBGbldvMmFiVmtLOTBBd1RKNUR0bGFENitwTElC?=
 =?utf-8?B?RkkxbHVuM0lmOGp5N3BHZmpHNTBPdWVOazVQQkNJV2RNRi9uRzlQbWhhQ0NL?=
 =?utf-8?B?WE90WDhveTFzTjI1SHpnUG1oMGpIaEhNQ2VFKzl1eUllZlBBL3hQak92aTJ4?=
 =?utf-8?B?WEwxZzI1d2pIamxOYlNwTzRkeWUwUUdRdjI0SjNXRCtaZ2MzbUhETEFNK2tt?=
 =?utf-8?B?blJWcG5Jb3p1TmlEUTMrV2RtOFVUK2F1TTNHR1dLQ2xOaytyejVMc29WRThC?=
 =?utf-8?B?NHFEd0FldnV3dXY5WHltM2V0OVExT1pDZFpBMFpqcFhSQXZ2WC9vYnhxWHF2?=
 =?utf-8?B?VHNpaC9oY09wZWM0T0lUd0VzWU81MG96UzluRmRzMmptVFg0dU1wSXlLR3Jz?=
 =?utf-8?B?RDJPRThaUFZQbHJMNmdDUEVBbnhBYkFCT3Nzb1pzU0taZHNUaitwMDU0bTZT?=
 =?utf-8?B?TGkyWnVlbHR5bExtNkVZaDlKUy9UcmhWQkphTXQ1czd1SCthLzBaNmVLTXF0?=
 =?utf-8?B?STlGZjRCWmYrQmxiYzNFZzNSNXovZVhVeWJHRVlIdFI4dFl2WTE5eVVxdkJG?=
 =?utf-8?B?T2F0bjJ6Nyt2Q29EY1lLajQ4VFdpakFWVXpoaEdjVUEzc0Q2RGJEb0tYZlVS?=
 =?utf-8?B?UDk5Y3hZaVV0alBFKzNQMU9aUTFiWWlmU1dua1BVbTIyT2ZtZDQvVDZlKzVq?=
 =?utf-8?B?MFdUay9xY0tGd0ovL0tNa1VlWDZXL1BlZHlTVUlRZWlwNlFUT1Eyb0RIL0Jv?=
 =?utf-8?B?T2ZLa1lyeHN6M3gvbWlLaUVNbUJkSlhRZGxHQ1BkdDdtc2RpZWVrbGZVRlRC?=
 =?utf-8?B?MER3aU1raEd3dE50OUU3cnB2OEJvU2tIV3pDTXJvekRuSUdzUXJCbGVNbFZy?=
 =?utf-8?B?ZGt2WEpld0JPYkNKNmN0OEhqUXZpSkd6eWpTdW0ycktaVFhQRmNxakptcEkx?=
 =?utf-8?B?blRzdUQ2MGtNWUd4bjBuTTQ1bTZKZDV0Sm83NnpDNGFXV2gvOXBxVlV6aHYy?=
 =?utf-8?B?aS9tUmJpNnNEUlhKTUEwcktlb2JRWVJ1WG1BdE5ZSFUvamlLUytGc0RuY0xP?=
 =?utf-8?B?MXNCOXJIa0I2d0MybWNlaWJGNDZFZjBvMzliaklmdXpGMkZXbHErdEk4MlF5?=
 =?utf-8?B?TWY0dE02YnpGdm5vcXhkdE9Yb202d2xMVVZGR1NFZGxjUkhpVUtyaVAvcTUv?=
 =?utf-8?B?YmQyMGZnSEgxbWJoM0ljL2ZobGRwVngzcU0ySXV3YndGNUNjTStJRW9YUXh3?=
 =?utf-8?Q?ux2NbrtmXKNEkaDKPYGNl5en7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5da032-7f1d-47df-3940-08dcaad85eff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 05:29:06.5844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6gvWRFc0gUWR4/YvJn4eeKPTrm3TFXWr10SNXZhfxBhs28ZGHZuHIv5IARBttOhw2j7HiqW6qpXlNXifQ5X7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/22/2024 7:48 PM, Srinivasan Shanmugam wrote:
> This commit adds a null check for the set_output_gamma function pointer
> in the  dcn30_set_output_transfer_func function. Previously,
> set_output_gamma was being checked for nullity at line 386, but then it
> was being dereferenced without any nullity check at line 401. This
> could potentially lead to a null pointer dereference error if
> set_output_gamma is indeed null.
>
> To fix this, we now ensure that set_output_gamma is not null before
> dereferencing it. We do this by adding a nullity check for
> set_output_gamma before the call to set_output_gamma at line 401. If
> set_output_gamma is null, we log an error message and do not call the
> function.
>
> This fix prevents a potential null pointer dereference error.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:401 dcn30_set_output_transfer_func()
> error: we previously assumed 'mpc->funcs->set_output_gamma' could be null (see line 386)
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c
>      373 bool dcn30_set_output_transfer_func(struct dc *dc,
>      374                                 struct pipe_ctx *pipe_ctx,
>      375                                 const struct dc_stream_state *stream)
>      376 {
>      377         int mpcc_id = pipe_ctx->plane_res.hubp->inst;
>      378         struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
>      379         const struct pwl_params *params = NULL;
>      380         bool ret = false;
>      381
>      382         /* program OGAM or 3DLUT only for the top pipe*/
>      383         if (pipe_ctx->top_pipe == NULL) {
>      384                 /*program rmu shaper and 3dlut in MPC*/
>      385                 ret = dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
>      386                 if (ret == false && mpc->funcs->set_output_gamma) {
>                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this is NULL
>
>      387                         if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
>      388                                 params = &stream->out_transfer_func.pwl;
>      389                         else if (pipe_ctx->stream->out_transfer_func.type ==
>      390                                         TF_TYPE_DISTRIBUTED_POINTS &&
>      391                                         cm3_helper_translate_curve_to_hw_format(
>      392                                         &stream->out_transfer_func,
>      393                                         &mpc->blender_params, false))
>      394                                 params = &mpc->blender_params;
>      395                          /* there are no ROM LUTs in OUTGAM */
>      396                         if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED)
>      397                                 BREAK_TO_DEBUGGER();
>      398                 }
>      399         }
>      400
> --> 401         mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Then it will crash
>
>      402         return ret;
>      403 }
>
> Fixes: d99f13878d6f ("drm/amd/display: Add DCN3 HWSEQ")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2: s/DRM_ERROR/DC_LOG_ERROR (Tom)
>
>   drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index 98a40d46aaae..42c52284a868 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -398,7 +398,11 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
>   		}
>   	}
>   
> -	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +	if (mpc->funcs->set_output_gamma)
> +		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +	else
> +		DC_LOG_ERROR("%s: set_output_gamma function pointer is NULL.\n", __func__);
> +
>   	return ret;
>   }
>   
