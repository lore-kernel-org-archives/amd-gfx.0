Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C55C02196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 14:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A9910E85C;
	Thu,  6 Feb 2025 14:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5FBBf06F";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BCB10E2F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 14:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ne23RbTJ1Q0hqc0HrIB0S6wi3rC0xogVrgHGjmt7t1i0KxmtW511Kbvy91fWklfjwUDhX/tD6em29OgELgj2DLa0bngiHLK95HyVXfx5Fn8AhU2UOtCJQJmJPDfGHeVIcnymAJlhGkxJZqfKItc4Tx/yGfqGTT1vDbYtWqOVShEcqz4t2diiYMsBH5yJjHmwCLxjfmpW+vny6VQPIVR+O0dzXzSg5unNBOXwk6Nx8eT9tT6q5s7nvOpwj84+eO+ywCn1pB1cOsep4fY+SI+YvA2VksQWHlP+PpyzAgsRRCtaj57HhZq0cWdOPEQqStad4TwngIpSGZnZA7Dr5JQgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh6MO1PcAW28++dZiQrt4I+BKAaEmXDgJ+pBM5zyZXI=;
 b=VS9sbAW0rTHF/R/3Z4/H6G5xBFm+OpVgUJb+MxWQpFxp1qiiEvE6ChymQE7P9qHtVKsSU1cTnqMxBNu4Ne487snaqh24H4uf8jWwasyA6WMkp0DhcHZEgz+m5sJl+gbJPQgcXpUmfVME/cAMSbCFVisFq+/huth4u9dIBBUTgf7EPQFgUrNw2HAnFYbhUnEB6oD67TdvZlhVO+CiVjBEqxCxegMx6g05cx70UACclbbupo5k026PxQFopzsYFRuLzYTme2DwlLBFeQX1MnmvvjSlNpW9EYwJqxEeryaOv5cMUpBkMAZht8WhnmKeQeLUVoPQH57ZSPWRiGOTVI82Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh6MO1PcAW28++dZiQrt4I+BKAaEmXDgJ+pBM5zyZXI=;
 b=5FBBf06Flq8YJ574v8tbl0WmqM95BCs0W44qXkM7ArUhyeybWRSA/78zYZyUXZRVISEH5lVhvGoUdjdjlzgRk+Aa2mOPhs0YJriIBSy0V3Ce4yLalGTruy43Y4AMlcpC41fP+lVVIzTu+IcqVLVK4XQSCJc3CHaOjkSF9FKqUk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 14:01:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 14:01:38 +0000
Message-ID: <a2e414a3-d30e-47cb-a607-e16e729e9310@amd.com>
Date: Thu, 6 Feb 2025 15:01:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/scheduler: Add drm_sched_cancel_all_jobs helper
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
 <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
 <67d2ebf31e78c7819fee6f8de917829957091a0d.camel@mailbox.org>
 <744abfb3-9edf-4ebb-b657-b811ef156001@amd.com>
 <37b0eef7-684e-4616-8d3d-d5e8932b8004@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <37b0eef7-684e-4616-8d3d-d5e8932b8004@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: ae470ee3-06e2-47ab-0421-08dd46b6c684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEdLVHRCUWl5TklpSDVjL3UrU0swRHpTQTdsZmhhWmRlTTFaMDRubytoRktS?=
 =?utf-8?B?Z0V5bHRQWWxzQTBCQXloR2ZmcFYyTXBIZHBWZnhkUDhrQ1N4aGk1RlhEeDR5?=
 =?utf-8?B?WkdyeGRsem1WaVZMeVpMemVhR2NNdnZrcERYRFZaRHcvVTlWb2ppWU1tSjFN?=
 =?utf-8?B?Q05sNTRLMmZyZ090eFd5WXFVUVRJVEN3UE1lVVZ4ODcvRTdnSitpMjBiNGFY?=
 =?utf-8?B?aVpiMmNwQTdUNVcvS2x0OE1VREFEU2lEUEd1RHpxczZSN3F5Wk40QnBXRDFB?=
 =?utf-8?B?UHFWNkc1WEpzWjE4dVdoOURTTHcrY0dSUUlQSVFDd1ZnaENWQnNHeFE0WW1J?=
 =?utf-8?B?OUdhOUdYbjdlQzNLTjNIRDAyaGF5V2RzVDhXb2Fmc1Ivb1M2UnVFUmpsZjdl?=
 =?utf-8?B?T3BWU1A1RzBneHVaRTJrN3czUFk4b3JET29wS3dFaDdsdDlDYlRPZVVZNG8w?=
 =?utf-8?B?eTZtLzJzRkZCUmNvSDNENU0vOS9ZaDVJUjYzNm1idkhlTHRBcG9hT0FJc0Nu?=
 =?utf-8?B?YURFOW9kOWkvYkdGL2o3ZVVmS3dYVmhwdTBFTHdGOHZPSi94MW45dkRER0NP?=
 =?utf-8?B?MFdTa3k4WGVVbThJRWdIRVh5OFhVTUREZE9MR21yK0w0Yko1VjBjdjAzenpq?=
 =?utf-8?B?d2NuR2c4UlRpTSs3cWlyVlcyZzE3WjZNM3R2UHdRQnFnbkJURXlxSitLaUZB?=
 =?utf-8?B?UnpHSS84YnRhYXVxTnFPZ3BrQ0MvRDVhTnhOTEQ3YzY1RERIZTA5UisySzk4?=
 =?utf-8?B?Sm1TdzcrSVgwWWpGb3hIQm1QdUxpM0kzQlFmYUFFQysxajN5ZjBvdVc3OW15?=
 =?utf-8?B?dFVWYUFLamdHN0xkdnBsSkNDRllhM251L2Jrd1hQUWJQaVBxUzhZNlhRbmIx?=
 =?utf-8?B?cGJiNVdKdUxoZHdYcE9kSmk2Qi85MGJGTGJjL1h5SXdad2lFaTl6K0FKTVF5?=
 =?utf-8?B?NTZRZldSbkdwUUg1QkJtRUozbmdadzBHZmo4TmlCMk4rVHZybnBmUGhPYnBm?=
 =?utf-8?B?RFF3SmQ4S0UwbUhVWEU5dkNPV2VmcWdFNlRrUkVxdzRTWEdmMWRwVG5keUpI?=
 =?utf-8?B?bWFSZDB1eXMrbnN6eXk4bGNvY1RKdVFDWVVudkJpSC9rMVdiQ0FuQjFBK3h2?=
 =?utf-8?B?WUMxelkwdWp6aERLeWszNXNiRmFOL1BGUGlzN1l2QU4zWW9ITWM2aWRtL093?=
 =?utf-8?B?clR6Z0ZjUitCYUNVRXB1Sk9zakhlMmZCa0g3eHMvODhma0x1MFJUUDJ4TjVG?=
 =?utf-8?B?Um9SdTVOc2lsdmlDOUxtaHBjQ2tsRlFFVk5qQ0xPRFVWWTkrQzlkRkZmTHBz?=
 =?utf-8?B?SlJWekt5Q0JJcVFabFpkQ0gyVlR3R3pIWExiaGZEUVJNOGovVkRlbXpJT2JN?=
 =?utf-8?B?TlFPSmFHRHFUSGkxZlkzcEdvd1hTVXQ1V1ptajdoU1dIcHlXNFNPcFZnOTZZ?=
 =?utf-8?B?SGlncmxzaFdLV2tnZXY4Tlh3dTlJV3BneFBKbHZQUEZqOU53S1pMekpEV2h0?=
 =?utf-8?B?T0FGZW9NeWIxNXEyQSs5SzZUMnlTckUvYW51Z2FYZmpScjN3bWlvNmdLSlBC?=
 =?utf-8?B?cGN6Z014WHMxYVFHb01ZRFAzUUVoc1UxaHEyUWwvWHYyWWY4RldCWENuUW9D?=
 =?utf-8?B?RXVGL1VyZnY5czlqTldSbk1vaGREZ2xSbzZuM2lLVkZqN2JVWGdyODRLTWUz?=
 =?utf-8?B?R0hFK2x3dUFuRWhvWnF0YUVmMGhxSmNMUXA2UlB0eFNDV2xGQ0xBRDZFVmJz?=
 =?utf-8?B?MG05N0FPc04vRHFDc1VMbXJkcCtRdUhSeHVXenl4Snc1SHpuRStDa1BhYTkv?=
 =?utf-8?B?VE9PRVp4Nlh2bDdKSkZyZTZ1QkhsbGhtY2JTZU16ZEwwM0U5TXpyckFnbUxD?=
 =?utf-8?Q?zLdafFLzgnNGv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhJeEdYdVRDZ0VoalBQYm0zL0tES2ROOUsyVTlHenRjMFZGOGh6R0dJRm1w?=
 =?utf-8?B?dU1BcnM4TEh6emIreXpIYVN5SEVPWWFoR25NYVU5dE9PbFVrRkVQWmRLbDM1?=
 =?utf-8?B?MUthZGZSbTV0RDlEL1NxaUdnbGVBRmJ6ZEN0MWpJTkhmQXNYazVEQUd5RERv?=
 =?utf-8?B?Z2pZeWV1Y2ZRam9XR1pnRTQ2emN6WHRXSHRXZVdxdUM3UUxzVnNtdDRZb0F2?=
 =?utf-8?B?a21PdVBJMXNQU2Vadmt3ekFRdWc3K2ZjN1NWZUh6RVVYNjRsNlM0UXdpaVcv?=
 =?utf-8?B?YzA3V3FKYTNKUkcyK25WKytxdk4ram55L0RNYitvU2dHR3c2dEVWNFNNOXlP?=
 =?utf-8?B?bUFVYXJXakowUFhHZTdEWEF1RTRjb2xYaGM5WVlYaC9sQkZVeW5jUWlNcktY?=
 =?utf-8?B?UkFCd3JqQjJjb0xYK0R5bytMaTVsQVJUUm9mU3dPRzk0VFhsTkl4RnFuVmRy?=
 =?utf-8?B?bnRmWGxWcmZoaW5RNFVxeDJqSk1tbkFsQngrbW5MbFZZUTE2RnhkTUlhZVhC?=
 =?utf-8?B?R2ZmSFdBQUFWNGh0OU94Z3U3OEd6TW8xZlRyWHdNMHY0ZzJpNHFxYVNxblJV?=
 =?utf-8?B?U1o5aTNhSjkzb2NGTXRQZDlvM0phTGNQMEcySVdXb1hYckN6V1VxQlordWlv?=
 =?utf-8?B?K0d5dEhGbmFuanpsdU9Ic3J3dVllRXJtRHJkdnRrWHV5NVFDcFFrYUtWTHVT?=
 =?utf-8?B?WHQyVVZidFVpZnRvNTlRaWw2aVBkOW9iaGdWVFJaRjg5dDJqbDdZOFNmVHhE?=
 =?utf-8?B?eWtzVXNoa0ZrME5GSzhoVzZSMVdUSGJHSUNHSHJXRnJtKzU4V0FCZnlsditB?=
 =?utf-8?B?bndpVFE1L3ZhYTRPMFY3T2NxcmM1SlFxMUVqZGd0YkpTT0dFdTMzWWhPdzFq?=
 =?utf-8?B?QzdmZkt6a2YyWDh4ak9acHVTcVh0TXJYU2cydnZINS9zbWNXQ2d4SkVQdXFT?=
 =?utf-8?B?R3cyM2F0M3BZdGpVTGpjOHhIS2dkVHNqVC9wSDVZZ1VHOTdWaE93MS9pSEhr?=
 =?utf-8?B?ZmxEYTFmc29HYjhJNkhlbkdFL2wwRWtEdTM0MlJ4a0EwMjNXMzZyUk5oTStl?=
 =?utf-8?B?WkU2TGNKdGh0aENpWms4M3N2TzVBMXYxNUNIZCs5dGplSC9WVGJzR2I0N1Az?=
 =?utf-8?B?dlUvOE9kREg4cVIyNkdxbzE0MGxOUGJmaFp0eHNkalBDeHhReldrL3FpQjMw?=
 =?utf-8?B?L2pTWjRKKzZLRERMaFcyTllJQUhWWVVTY2hrM1hDTXJSaDVEQWZhUnpEUEQ4?=
 =?utf-8?B?RjhYWVBpT3k3cXQ0K3VGY3NBUDVxQVpLLzBxN3JqZ09sblA3NTgraDByYTZ3?=
 =?utf-8?B?MHVjQWdBZXl3NGZTZ2xnZDdOWDMvZ2wxTGFaNHdIaTF0YTRJa3Z4bzN0WWR2?=
 =?utf-8?B?K1p5OHg1dXUrU0habFFRekNyc2hKd25SWlZaWWZZQS9xOXNjOEsyOGUxSWJ0?=
 =?utf-8?B?UUdoVmRFcWxoenYvTzZza2RqVU9OREpkemlUSUU5WlcwTW9MR2ZBdHdRUzlF?=
 =?utf-8?B?Qkp2bnBoYkhUSzdHWXRaN0lVSE5kRFRXbVRROE52M2g0aWpqSzh0K002UUUz?=
 =?utf-8?B?R3VuTkoyOHA3NmdLTy80d0JEQUtYb0dSWVZvcEpLYnpxbU44dDlISkZKMTZC?=
 =?utf-8?B?aXptZTFwWkEvUHk5TjEvbWFhTVZDNFY4MmpkeFFjTytNYW1kOGZsMVlwdGh2?=
 =?utf-8?B?TWVZbDJDMVY0aEh0RTRDWjBTVmxUZW40eFJJSExuaWJpVFpVOHpPd3VmNlow?=
 =?utf-8?B?TEhMOWFRMzAreW0xd0owVjNQTDJ3b0RkWGFhS3RPbXBkZlJsTjd6cDlTSGx3?=
 =?utf-8?B?RVFRbzloVGxDeVlQZzhjSUNhOEsrZVNYUDlKa3Bvc2U0bGpYWTQzRUM4WXV2?=
 =?utf-8?B?bVdHcEZYR05zTnJra2ZpL0lBWlhzNC85eGRsR2UzYTNhYzV3QjNPaUkwMDdJ?=
 =?utf-8?B?Y245Q2gxZlJYdWI2d3p2Sy9QKzVEL3hpWUxCUW93OW5kclFHTEdzL2VrKzc0?=
 =?utf-8?B?Q2RaMFpIaU1tVm1vWENuUk0zQW16K0hldk93eE8rdm45QjBpR3ZEM1g2RmxH?=
 =?utf-8?B?V3Bub0QwakVDWGNWN1lIM3k5bHI3bHlCK0ZlZ3c1Sm4vSWlUeGhrNzYzTVly?=
 =?utf-8?Q?/aSnuYlek4iyJCrQjwDHC/8Hl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae470ee3-06e2-47ab-0421-08dd46b6c684
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:01:38.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZF2d4c2FASo6tgxuCDP1zIa+a5E0BqGf3BEjOZ9KcxUPxMfvoT/Yo8Ko/1/4qV9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
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

Am 06.02.25 um 14:53 schrieb Tvrtko Ursulin:
>
> On 06/02/2025 13:46, Christian König wrote:
>> Am 06.02.25 um 14:35 schrieb Philipp Stanner:
>>> On Wed, 2025-02-05 at 15:33 +0000, Tvrtko Ursulin wrote:
>>>> The helper copies code from the existing
>>>> amdgpu_job_stop_all_jobs_on_sched
>>>> with the purpose of reducing the amount of driver code which directly
>>>> touch scheduler internals.
>>>>
>>>> If or when amdgpu manages to change the approach for handling the
>>>> permanently wedged state this helper can be removed.
>>> Have you checked how many other drivers might need such a helper?
>>>
>>> I have a bit mixed feelings about this, because, AFAICT, in the past
>>> helpers have been added for just 1 driver, such as
>>> drm_sched_wqueue_ready(), and then they have stayed for almost a
>>> decade.
>>>
>>> AFAIU this is just code move, and only really "decouples" amdgpu in the
>>> sense of having an official scheduler function that does what amdgpu
>>> used to do.
>>>
>>> So my tendency here would be to continue "allowing" amdgpu to touch the
>>> scheduler internals until amdgpu fixes this "permanently wedged
>>> state". And if that's too difficult, couldn't the helper reside in a
>>> amdgpu/sched_helpers.c or similar?
>>>
>>> I think that's better than adding 1 helper for just 1 driver and then
>>> supposedly removing it again in the future.
>>
>> Yeah, agree to that general approach.
>>
>> What amdgpu does here is kind of nasty and looks unnecessary, but 
>> changing it means we need time from Hawkings and his people involved 
>> on RAS for amdgpu.
>>
>> When we move the code to the scheduler we make it official scheduler 
>> interface to others to replicate and that is exactly what we should 
>> try to avoid.
>>
>> So my suggestion is to add a /* TODO: This is nasty and should be 
>> avoided */ to the amdgpu code instead.
>
> So I got a no go to export a low level queue pop helper, no go to move 
> the whole dodgy code to common (reasonable). Any third way to break 
> the status quo? What if I respin with just a change local to amdgpu 
> which would, instead of duplicating the to_drm_sched_job macro, 
> duplicate __drm_sched_entity_queue_pop from 3/4 of this series?

Removing the necessity for queue to be the first memory is still a good 
idea.

I would add internal container_of helpers to the scheduler and then use 
explicit container_of in amdgpu. E.g. don't expose the scheduler 
helpers, but rather manually code them up.

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> P.
>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>> ---
>>>>   drivers/gpu/drm/scheduler/sched_main.c | 44
>>>> ++++++++++++++++++++++++++
>>>>   include/drm/gpu_scheduler.h            |  1 +
>>>>   2 files changed, 45 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>>> index a48be16ab84f..0363655db22d 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>> @@ -703,6 +703,50 @@ void drm_sched_start(struct drm_gpu_scheduler
>>>> *sched, int errno)
>>>>   }
>>>>   EXPORT_SYMBOL(drm_sched_start);
>>>> +/**
>>>> + * drm_sched_cancel_all_jobs - Cancel all queued and scheduled jobs
>>>> + *
>>>> + * @sched: scheduler instance
>>>> + * @errno: error value to set on signaled fences
>>>> + *
>>>> + * Signal all queued and scheduled jobs and set them to error state.
>>>> + *
>>>> + * Scheduler must be stopped before calling this.
>>>> + */
>>>> +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int
>>>> errno)
>>>> +{
>>>> +    struct drm_sched_entity *entity;
>>>> +    struct drm_sched_fence *s_fence;
>>>> +    struct drm_sched_job *job;
>>>> +    enum drm_sched_priority p;
>>>> +
>>>> +    drm_WARN_ON_ONCE(sched, !sched->pause_submit);
>>>> +
>>>> +    /* Signal all jobs not yet scheduled */
>>>> +    for (p = DRM_SCHED_PRIORITY_KERNEL; p < sched->num_rqs; p++)
>>>> {
>>>> +        struct drm_sched_rq *rq = sched->sched_rq[p];
>>>> +
>>>> +        spin_lock(&rq->lock);
>>>> +        list_for_each_entry(entity, &rq->entities, list) {
>>>> +            while ((job =
>>>> to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
>>>> +                s_fence = job->s_fence;
>>>> +                dma_fence_signal(&s_fence-
>>>>> scheduled);
>>>> +                dma_fence_set_error(&s_fence-
>>>>> finished, errno);
>>>> +                dma_fence_signal(&s_fence-
>>>>> finished);
>>>> +            }
>>>> +        }
>>>> +        spin_unlock(&rq->lock);
>>>> +    }
>>>> +
>>>> +    /* Signal all jobs already scheduled to HW */
>>>> +    list_for_each_entry(job, &sched->pending_list, list) {
>>>> +        s_fence = job->s_fence;
>>>> +        dma_fence_set_error(&s_fence->finished, errno);
>>>> +        dma_fence_signal(&s_fence->finished);
>>>> +    }
>>>> +}
>>>> +EXPORT_SYMBOL(drm_sched_cancel_all_jobs);
>>>> +
>>>>   /**
>>>>    * drm_sched_resubmit_jobs - Deprecated, don't use in new code!
>>>>    *
>>>> diff --git a/include/drm/gpu_scheduler.h
>>>> b/include/drm/gpu_scheduler.h
>>>> index a0ff08123f07..298513f8c327 100644
>>>> --- a/include/drm/gpu_scheduler.h
>>>> +++ b/include/drm/gpu_scheduler.h
>>>> @@ -579,6 +579,7 @@ void drm_sched_wqueue_stop(struct
>>>> drm_gpu_scheduler *sched);
>>>>   void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
>>>>   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct
>>>> drm_sched_job *bad);
>>>>   void drm_sched_start(struct drm_gpu_scheduler *sched, int errno);
>>>> +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int
>>>> errno);
>>>>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
>>>>   void drm_sched_increase_karma(struct drm_sched_job *bad);
>>>>   void drm_sched_reset_karma(struct drm_sched_job *bad);
>>

