Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB118E77185
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 04:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D2510E165;
	Thu, 12 Dec 2024 04:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLANf22N";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0389B10E165
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 04:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnrjIuhtrt4Jwl4iWRy/GQaIEcMBlu7Za3nInhMDOrGJ/UR8LrFwLdIDkrlWIkxah3TztVT/QuUYfYEOltbihtYhkhPnBNCAu4DuaGM+0fSMYtzBHgLD9zJZCajkhqrUJKdwDbenC0XkApUKiUf4L6mTIx/MmqUrmjzctpqnMD9sPUzrnCB95DSyEjr+an4RUJ5vaklgX4KHnTFWs3ZCfUgV3XA+vVuRQH1d8XS+Sqt500VSrqkyGtD71uFgt1IP0ij3hdOipVlHeADFlV/SvrWg4XzPztY0yipLbAtRGubQrjITY588+hct4PfZscZpEReDHwe61o1Dyi/9QpWVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2X8prUEnCTBFfqG0nI6jDRy97ZDUZscWYDcE8tLwrg=;
 b=e6/Tez+flVOQZYr9oxVRT5k33glqv1fHLLGECSJeIf+8ZRdR693w/k/UvUZlftKZieUZm0uZya3b+SEcb/fLIb2mJwZiLlGM2kx2VOk8De1kRE0wkPSJIOS1u/Cx0LBA5XgjZA7x/TiaPgi5c50PvvhJ8qs0IA1pbnqYgmv+Q0Lgpjr8BhBLXlhyb6L8/PtwJxsBSZYbf74XYj7tB2Lp6liw9n6IOXbPQJKjwDZo17AlDr3LKUBKdTcW2X0hevRwNTvDfuuF/r4W3swH4/l5EpoR87umaXI6JfaKDLe9wlv3X0JyVuMaFyRsVe/RlqPnb8BqikJT/BxdE0KKomBjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2X8prUEnCTBFfqG0nI6jDRy97ZDUZscWYDcE8tLwrg=;
 b=OLANf22NplsA7tV/JuVJj9pUoZ2y+BZUNSQltlhveIFrvDFPkTQN9mHynHnYSj19txaa3B7RY4TtiABYM4JzNZYXL3e5znrJTaqLguyDBLsnDw6n8M19uX9rFTmpHc/qnCYuoJwAWtFx7EJJyRvSRp3tWcQgr8mzErPJeTKZTFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 04:19:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 04:19:30 +0000
Message-ID: <0a02fdfd-7771-4a8d-be15-1e8eaa6d631a@amd.com>
Date: Wed, 11 Dec 2024 23:19:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: wq_release signals dma_fence only when available
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241212030611.8513-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241212030611.8513-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0192.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 01825ada-481e-4da1-c3d6-08dd1a642c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1F3Qzl4WUQ5dnZSV3V1dUxPOXFDcDhWcEU5RTY0YmJCT1lBejRuWE5GV25y?=
 =?utf-8?B?ZkpkWnoydFBIV0QrdHBHTnFTZWdXQUpoQzZvRDJwRjBvUlhiZThhWU1vYU16?=
 =?utf-8?B?OEx4ekRmWllKRkVScVFvWTRZOFRLOC8yMC9hazBkZXVhK0J5L0pmQkpvUkRF?=
 =?utf-8?B?MERadCsrUXNNTHVhR3Q5SkRLNVJaS3Q4Z0JzdTA2NDlrV0k1WjUzcUFZbmpP?=
 =?utf-8?B?VUJCSjdkd05OTWxtVUljMlFMaG1DS3BDQmYrbnVBbWs3SEJybTZSQWlBczNQ?=
 =?utf-8?B?dHMyb0tLc2N2SXR3K3UyZzl4SkE3bmcrc0p0bUpxTzZyN0haWTRzQ2F1T09v?=
 =?utf-8?B?a1lwdFdNUXJnS3lZWGx5SGJrMlM2VU5MZWoza3daNDV1alMyQWVPdDgyUUpv?=
 =?utf-8?B?QVBycnZFaGlyam13SjkvTDY3ZHp3YUNscTlWaEh0SlNkRjZOdEMwUEhJYzlJ?=
 =?utf-8?B?ei9uYzFQNTJLQ1dYa2U4VVZTTkd2ZnlOajZpZTlCcFdRWmRpNmhzZ2xKeUY5?=
 =?utf-8?B?djhLVTI2aHJmekxXVUF4a2diOWw1VzRiSC9FZmN1aTFGWHlyT0ZFVytma2Rl?=
 =?utf-8?B?b1IwU25RQzdkaThiSm9zNEFLbDYvcGcyN2JveVlJMnNrZmNZdW82WW9pNk9z?=
 =?utf-8?B?VU9hN21JOS9sRkVMdE94cjlqdkhQOWhsZ1haYWNybEFxcTNibElaZmU1Z3dL?=
 =?utf-8?B?Z0p4dndPZDFOaUhHa0ZkRTc2SnRHYldTTWV6QlBVRmJ1bE45c1UwK3NjTXdr?=
 =?utf-8?B?cktsbGtaa01EZmpwZHZhZHhPcWplUFBOcHpxUUZFSUZ5eWpJanRNN1NlMzJ0?=
 =?utf-8?B?TW9GcVRmQTZ3MUtMTWVPcU1Nb3FKR3JvZE5ubk9CdXhZQ3RrNEY0NmVEZlRW?=
 =?utf-8?B?M0t2OUVNTlRqaVVRLzBWWEc2OUpEcjBFc2t1d2R1UWFXczMrdDJjUE5IK2ho?=
 =?utf-8?B?UU16RXYvS3o2KzZYUHEzVDdTSGlpSmFFaWFxTTA0NFlXNzJJenEyRUZ3anhM?=
 =?utf-8?B?NFhtMGxNbUJRcDRRMlVYMFRnamZyNU1ta2VybjFaanhCZ1RSTkk3SHdKNGVT?=
 =?utf-8?B?RERqOFlPYzBZQWZRWmxveTVDU3Zjd0tHd01ZbDhWM0xheFVoQnNBR3pPa2po?=
 =?utf-8?B?RHR4cTZmNGdLK29LZ2E4ZEs0b2RLMmFlZXB3S004NCtibVZ4d3RlVCsyeW81?=
 =?utf-8?B?dFFMT2NCMi9XYkVXMlgzNEZObEt1M2pGbVJMNTE2OTd5SEhlMkxZbUZJdk42?=
 =?utf-8?B?RGU2UFhlcWpPK0Y2Z08wcnA0Sk1ST2l6RFRodndidkZRTEM1amloZkY5THpj?=
 =?utf-8?B?WEJNNFFRQjJxQ0NLUE1IU3puaSt3MkVTYkhrTmhqUTB3c2dTbnI4dDVYbGFm?=
 =?utf-8?B?MTVhK0tDTm5Xai9ySzZ6Z0JIdzVmVXpRVkQ4bDFPN3hYMGlxUXNUeERSOC96?=
 =?utf-8?B?cUppSVFDUHJ5U1NHeXYwdG9mclc4bmhTdzNBSnY4eUdMWHNJNDlqN3hidytD?=
 =?utf-8?B?amJOaEtyazhUblBMVk5pUmdBLzBXbjZDa0xwY1hkelNPdkU5YW4rUTB1RGtH?=
 =?utf-8?B?VmtqYzE4ak00dWJGZ3RyT3FFMnliMmhxaFR3bUQ2eEJPL0QwbGo4ZVI1bGxE?=
 =?utf-8?B?NVlwTEJLWWMyamNDTnpJZ1NOTjFoanVqWGluQlRtWVF5bkt4cGxLZlZlRVgz?=
 =?utf-8?B?U1BhUGwrUnJhZjhXZ0JGZjZEQ25VSnljSFRDd0ZiSk9SbmYyUWVhMHlabDZl?=
 =?utf-8?Q?BncOG5wACude7YC2lo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUh4UHNQdXhnL0VCSTZSTEh3dXlBdjRZMm1BVFRSUUR4QXp2eHBONm00K3pB?=
 =?utf-8?B?M012b0Q5MlVBb1R6YlFMc3Y5eUpTZGREaUlpL0RvbERleDhTNFpER2pYWnZh?=
 =?utf-8?B?eUlHMGlMSG5oc1VJRVYrNHlHS1BSZFJZdWZLeDdEcWErUVUycDZJN2tPTENV?=
 =?utf-8?B?OVRxOHZhc1Qvamd6d0xiQ2ZYQ0NqbVdLMXBKa0tBbXhNbGF5ZUcvRW91TDR6?=
 =?utf-8?B?T2NJa0lJSHgvTDBMckR5N0JsR2Jlbzk1MFpldHcxbDdqS29jeHVvNldrWXd3?=
 =?utf-8?B?Nkd0WWVWL2wveHhMbVFVWVZwZW9rL05vTkoxT1FyeXI0RjN3SjRGcFp5dG0v?=
 =?utf-8?B?YWs5bGVwWWxJOFI5N3NVdVBjS0xYVGlwMW1qQXRTY0dpdjhCVUt1N0loMkRD?=
 =?utf-8?B?cEVNWGZTWmNkU2E3dTBkbEVnMUFJa1EwU0xmQ3pkaXlEbktKUGl3MkNVc1Zu?=
 =?utf-8?B?cmhERU1VVnFuUFlpTVZqTHR5QWRuNHhQdUtZdVFXYnJmbmwydURtVzVZbTU2?=
 =?utf-8?B?M2J2b0hiTmErUE0zMHRkcWI3cXdVWWJlTnFjbWsxZldNNGp3WWlQQTRpL3hN?=
 =?utf-8?B?QnZDcVNrUnYzRlRHNmc5bXBZY21kbTlOTUpidTcwK0ZBVkVPLzNJVGkrcXh3?=
 =?utf-8?B?SWdvTGNOVk44dG5KMXNsb05aNjFhVERnK2RxZlF1a3hxYnRsajI1MTgwZHlu?=
 =?utf-8?B?WFBZMSttdlo5T09maGpCb3A5YW4ySmtxamhNWmtJeWhsN1RVWTJBNzB3SGQz?=
 =?utf-8?B?dGkxMmFWd2NvdFRmeEUrS013Rys4eGlkck5HOW4rMGJwT01oT3BpNS9abldI?=
 =?utf-8?B?YmZmZkJ0dFRWZHhhWUdLNjJKZ212WU9rOEpRanFCY3YzL1JkSW42K0RYT24w?=
 =?utf-8?B?ajBuUFMyWHdJKzRqM1RjeVBpNnF6ZmhHejVMVUJ5MzE0eHhPaHpEOUJxL0Iz?=
 =?utf-8?B?SWlpeUdJTmRKSzhzZ0htaHQ3TG9FL0F3V3oxdlRFSzMrYUhIMmZta0cvcVpZ?=
 =?utf-8?B?MWZobnpGalVXRG5uV3hyc0JNNGY5NGprUHhsMzJzYW5jd0dJQXJwOXhBVzNu?=
 =?utf-8?B?YVVVRjNQZlRqbGFYdFNRRG5PVEN4cEczaktaU3Z5VVA3TTBZSnRkNC9aRHFP?=
 =?utf-8?B?eWR1b1hIblhZaUY5SHlIaFBEOWZMMzYyenZmekRkSXNYSElTOTdZYzhMQTN0?=
 =?utf-8?B?eENXWkxxMFh3N2hjK0JOQzdMZGxTTEFGakg4NisrUXdxaDd5eURJLy80TGUx?=
 =?utf-8?B?dWI1VnhjUFdUa2dwYUN3UkVjYlJ4bCs5Q0V0YkhaSm9UU2ZDZkJ3VXltWlFH?=
 =?utf-8?B?Vldsazl4SFNtelM2eE12dlVBMFhqaThHaVRIN0ZlUXhxQTNnUi9DMVBSS2pK?=
 =?utf-8?B?RllSK0tVQTVaOGFMRlltdFRvN3RzOTNpanc3SXJ1T0hlOXlaVGh3TUNmQ09k?=
 =?utf-8?B?RXNyaGJBcXZnLzBVVGhOdDUrU3dUZGNnRGtEUzZiblVjQjNxS3JCMG1jcFQ3?=
 =?utf-8?B?MVVHV1ZrblhpQmR4ZFpEN3BDR0dOdG1QYndwQThEbnhZTUkrdk5ONFZTaFYy?=
 =?utf-8?B?QmplVVQ0Q2hPZkxIL1RubEVyVEV2R1NlWmtjMlQwSkdUeTZJWGIwNGE2aUox?=
 =?utf-8?B?K3ZuVnlyNkhRTmF2WFBUOEN0V0txaGVmSjY5R051bmhUNmpSYUM2MFkvdldu?=
 =?utf-8?B?bnBQQjY5ZTRROWVYYTM2UVBmRllxL3lod21aMTd1Nk8vV1BXK0lWeVFxM092?=
 =?utf-8?B?d2hZNFBzRGdjN01xdko2aGFSRFNYL3c4bVlXcDRtQXZ4ajdDeG5TVVlMeit1?=
 =?utf-8?B?VXZmV3pBZG5tUGVRelRocWJaZmZrMVJkVVRWT3pDcWNVODYyZkpCeU5CWCtL?=
 =?utf-8?B?OU1BbG1EY1lEcXFTcy9qYTRxVjlycnBrYzR5RTJ5b0hxSHk2Tk1ZcFlyTktq?=
 =?utf-8?B?N1BaeTFEUngwZ3lkUEVJSkhOdlE4L3dMdU1YRFVrS1pNTVFnTitYZUlxbzFm?=
 =?utf-8?B?UWV4ZXNkRkpHZnZGL1NyYU51MlRpY3krbDlteGhsRG9qaC9VVTZWRmQ5Vmho?=
 =?utf-8?B?Rk12S1dFc3MzaktuVjFJMWtiaXRXMWw4enJzemIwN2dXL0V1dDZSZUNrS2JH?=
 =?utf-8?Q?qnqM1KhLrEo8kjJTa3VS8Vvub?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01825ada-481e-4da1-c3d6-08dd1a642c98
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 04:19:30.6453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1rYZbPXeazUFIz5gd6oGHB3bAEpyf/rkxWi6t5JFD0Z5hMisy/f6Rqon6BW6H7RcBB0/5yXcUP7j+WaPw1LJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
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



On 2024-12-11 22:06, Zhu Lingshan wrote:
> kfd_process_wq_release() signals eviction fence by
> dma_fence_signal() which wanrs if dma_fence
> is NULL.

That's news to me. Looking at the dma_fence_signal implementation on amd-staging-drm-next, it just silently returns -EINVAL if the fence pointer is NULL. I see the same in Linux 6.12.4: https://elixir.bootlin.com/linux/v6.12.4/source/drivers/dma-buf/dma-fence.c#L467

Which branch are you on?

Regards,
  Felix

> 
> kfd_process->ef is initialized by kfd_process_device_init_vm()
> through ioctl. That means the fence is NULL for a new
> created kfd_process, and close a kfd_process right
> after open it will trigger the warning.
> 
> This commit conditionally signals the eviction fence
> in kfd_process_wq_release() only when it is available.
> 
> [  503.660882] WARNING: CPU: 0 PID: 9 at drivers/dma-buf/dma-fence.c:467 dma_fence_signal+0x74/0xa0
> [  503.782940] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
> [  503.789640] RIP: 0010:dma_fence_signal+0x74/0xa0
> [  503.877620] Call Trace:
> [  503.880066]  <TASK>
> [  503.882168]  ? __warn+0xcd/0x260
> [  503.885407]  ? dma_fence_signal+0x74/0xa0
> [  503.889416]  ? report_bug+0x288/0x2d0
> [  503.893089]  ? handle_bug+0x53/0xa0
> [  503.896587]  ? exc_invalid_op+0x14/0x50
> [  503.900424]  ? asm_exc_invalid_op+0x16/0x20
> [  503.904616]  ? dma_fence_signal+0x74/0xa0
> [  503.908626]  kfd_process_wq_release+0x6b/0x370 [amdgpu]
> [  503.914081]  process_one_work+0x654/0x10a0
> [  503.918186]  worker_thread+0x6c3/0xe70
> [  503.921943]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  503.926735]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  503.931527]  ? __kthread_parkme+0x82/0x140
> [  503.935631]  ? __pfx_worker_thread+0x10/0x10
> [  503.939904]  kthread+0x2a8/0x380
> [  503.943132]  ? __pfx_kthread+0x10/0x10
> [  503.946882]  ret_from_fork+0x2d/0x70
> [  503.950458]  ? __pfx_kthread+0x10/0x10
> [  503.954210]  ret_from_fork_asm+0x1a/0x30
> [  503.958142]  </TASK>
> [  503.960328] ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 87cd52cf4ee9..47d36f43ee8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1159,7 +1159,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>  	 */
>  	synchronize_rcu();
>  	ef = rcu_access_pointer(p->ef);
> -	dma_fence_signal(ef);
> +	if (ef)
> +		dma_fence_signal(ef);
>  
>  	kfd_process_remove_sysfs(p);
>  

