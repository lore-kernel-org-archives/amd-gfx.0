Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBE1CEACF1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 18:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406D710E0B4;
	Tue,  1 Oct 2024 18:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQoNGpfz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5889A10E0B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 18:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfoBYUkOdAX25SPVzn4pCdSDlro/p4EtdnH3vpLWS2p9GggZVR3wNaKrwFmzDlxiXhGmwOaHC4nvcqjzZ1ubJFDgcjxFCIbgCcGxYYqc0f4+ueUmkWXjHPxjvBBypwrKi4fFD2JUAAZdxrX9s/T0gvvY854jeBTkieHQ2hOR/lgNmQa47tX7LS9r3lnWw6iuY6Qp9ftbiJ+jQ39fhXVtNXCsjucmC+7aiktLjrxHdX9z+y1mslgZ21X/vnxqJnsAinVFLEB3iVRARbvRGtb7m9b070s5lCAR65D7JXMKgI8z5yzvMPxj3RpSDuT/RWH1euUwmDqcjf6IIYLsU0C40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL0UWoFrD+ZWVjDFwDTTatWIx8DUt2AxGRNO/R+hoyQ=;
 b=exn1dK8R0a/uv9enMzaEhM5WgJC8UKz+VgzHa3t+n2/pybuSmXDNb8epjIZBvFZAkRaF36dz9r9Mc1+A2BXiZDczOSrcNxQtsBb2+OpcFpZQeXAClI+H/6yU2rnxblVONqXo4I5FepMzzw5vHIWJnAMA6U5VW+qCG9/bwWQ8m0W5WWiAoYVC5LAKSZt9SG0CjuMqAFjsfte0L09P0sJRO9lYgvWCRI6TxkwNqNGFVY1I1JpYh0O4FPzFJ/s7DRJB2Zc/kVYB4qwMLnjrH3qMohXUqOxskOmYxPTkGiDCPCZiJjoGVIiikbf3jCV3RE2vVNqVhJVsLsbiuHQ/ZPI/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL0UWoFrD+ZWVjDFwDTTatWIx8DUt2AxGRNO/R+hoyQ=;
 b=xQoNGpfzNrV1R3Uuwjecotph8vIbIu64o5luKjN81chydbRdvqKlKfyV5jPp5ojcsRuNqN5IkuFYJPiBsSmbNvuC3HHVTWu21qGjJ6AWOorksiiKiFa/02uXRXKtx3pvcnuGTh7aOFmaki9XMky56VdqEUfP0WnEvtmA64owzqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:49:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:49:00 +0000
Message-ID: <95c575a3-100c-4808-b451-b92f14598188@amd.com>
Date: Tue, 1 Oct 2024 13:48:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
To: John Rowley <lkml@johnrowley.me>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 regressions@lists.linux.dev
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:806:127::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5a0b25-5df4-44eb-b511-08dce249b666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzBFaThRUHBiQktkQitFeHYranB2ZnJUcjF3bHJmN2RwYlV1d2RtZldNbm9p?=
 =?utf-8?B?U3V1ZHpKSXkxMmRLczlvcGhpNUN6QUh0bTF3TjFPUDhoS29mcnJOZWp2YU5y?=
 =?utf-8?B?MWJndmxnYm9ld2t1ZDFjelo3Z1JSTm5zKy80bTJzVDJYMjdodFdlUGVQc2Mv?=
 =?utf-8?B?UmJBZFNRSEFxWjlKcnFhWTk5QWcwc1NuT0RIMmo2Mng1azNxeDYwM1QvYWFu?=
 =?utf-8?B?R1RVV2hzOUR3MlBoLzJLdkdVRU00TUNFcEJWblhHdnBlUVRzL0dTZzhpa1hV?=
 =?utf-8?B?SDFBQ2tsdzlUUUorajIwYkdNdnVwaVd1UTVDdjFBQjNKTmk0bU5OMnBDdHY2?=
 =?utf-8?B?QXI4SUtjNnhWNk5sU1VERVM1ZjdWdmQ1QlZrUUZ2bXFXQWphdUcyaFBKWWxL?=
 =?utf-8?B?TkZKSXBKZWdUSTFPT0FMdWFjWGxXMDhLZWRYbmFVTmswcGxoeFp5RXMrVEhK?=
 =?utf-8?B?UDYwWk40M3ZOQ1I1OFRRVzNOTC8vT1BucjluOXYrdWxZVUw4enRNUzZCa1Nt?=
 =?utf-8?B?Uy9nOTR6L0hYYW8xbkZSaHBxaDFXelZLYlZXMGp3Vlk0Zk8xSUJreUZRS0gz?=
 =?utf-8?B?VnpWWDNBY3o2Z05ETlhvS20zT2JLSjBjTVl4aDZ6S0g2TUJmU2NiaE9zWnps?=
 =?utf-8?B?c3VJYXhFOTI1M25JM2piSHZYYVpvbUNObTBNMnJWc2w1eDN4dUJBcGxUeTNJ?=
 =?utf-8?B?MzV4M1FFdkYzemxUaFQ5QjlwdENlVUZTaTlvYmdRMmVXNyt2blhoelVJb1hz?=
 =?utf-8?B?TDZYc3BMMWJsd3Y3UFRvZUFuUGRTQlBjanVoUEdXWFBHcmtYUDZhTXg0ZFk5?=
 =?utf-8?B?RStRQ1lsSG9LeWxtSGVlWG43eXM2UC9vT2MyUWt4aGIrOEo1UHpibVlucm5o?=
 =?utf-8?B?RW1HVi9YSVlIakpKQWZoeDN0TnFZY05EWHFYT0t2YXZGN3JQcHA3RGdFS3do?=
 =?utf-8?B?cU1XbEVySlFybWxRUDFBNTRKeFVCNmdOTkJtSi9oNzVrbm5DdzlNemVaVFpz?=
 =?utf-8?B?ZUJIeHBlUDljSjdETE5PMEYyYlRlMitZK2xSRm82Z3p6ZHBkWEYra1dVY25L?=
 =?utf-8?B?YWJDK2NVNVpoY2tmRkdFQWZ1MzlnZHRGcjFSSEx4b0ZjZ21JOFlLd0tPYldI?=
 =?utf-8?B?aDh2UFVicVY2RGxWcGl6aEFqZUJ0bWVPRVhsTkQwSmh2d0NxNFEralpseFlT?=
 =?utf-8?B?VHc1cThDWE1vSnJTdnhBU243RGV3amljL1pQSDdQdDZSWnhnN2doMDlVaFNt?=
 =?utf-8?B?cDhrRFY0ZC9vTjJBNlhERUE4ekQ2aExwR1MwNEp1bHk3SHc2Ymtvb0lNbE8w?=
 =?utf-8?B?SVE1eUdETW9qQWlHZC9sOW1BMFVDcVFNL1ZsL3VuYUFwVm5PNDdabjRZeC9O?=
 =?utf-8?B?MU52ZXMxbVh5dTRZc2tNeWcyWHU0UzZYQ3JPK2VoWjNSdFhtS0tETjc5cWdV?=
 =?utf-8?B?bkFYR1kxd0hNeXR4NlVqNEdkT1E3ZTlMSi8zSktjS0wzamRmQWRuZmVrOGFF?=
 =?utf-8?B?Rnc2eWVvaUtTODJqWTVoMjhCVnJlc2Y2TTJWU3JWdENiRkk5Q2JJZHRLQVJJ?=
 =?utf-8?B?OENpVFZ6VjdQZVV5cHBpTWplQ1JFUUlVWWU5R2hqRFlKclI5WFJRZHZjTnA4?=
 =?utf-8?B?VWd1cVB2dGw4SUhrd2JXdTlJczczeHZTWWxEN0dnK0NwVHM3bFB5Q3h1TFBa?=
 =?utf-8?B?VXlMWDJpUkhBaW4rY25Walc4ek91NFBFRmJLNWI5Mk1ZUUNNd3h6b3ArRFN1?=
 =?utf-8?B?QkZLREhFYTdjVlhLd0FzeUZuY21RbTNIMEk3ZDVvQjR2N1A0bWY5OWN1enBN?=
 =?utf-8?B?R3FSTG42UnVuNW16WUhCUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXFPRHRxMEk3RXc2Z0hoOVppaC9BK3QrZzRMUjlwR09LMlQ4RjVWZ1NnNVBh?=
 =?utf-8?B?UlNnWHhvWklsOWNoWE9WRVdtUlF4U1VRczFkT0FXSy82VTFrZzErWExtWW5C?=
 =?utf-8?B?bVQ5M2xYazZBSlN5RzlubFBMVWwwVkxOS01zNXhrQWtRKzJVVUIxR1NRLzQ4?=
 =?utf-8?B?TjhEU0xubjE0aEo3MVhkdU5uQXhrVFFVYzY0QVlmOXBZNUI3bjUxQkl5OVZF?=
 =?utf-8?B?WXI4Q2dmd1Y0N2JkTUhsRkV1N2owM3QxSktSSGxpaUl1TFJOWC80Z3VCNW9D?=
 =?utf-8?B?S09HTnZJbGMzN2hXRnpHbFRHRjVHSEhkWGFTeVB5U0JSQ3lJeHdPSjlCRS84?=
 =?utf-8?B?VVR2RjFpWm9CL0ZLOVFYcGJ1Tkw2RW5HWFV3L3doMURMYnVTYUJtT0N3WWk5?=
 =?utf-8?B?SFdGMjBOV0hyS1hpMWRxZFcvU0QyZVBONHlCWGowMVcwWWRwZmNjSmRVRmZn?=
 =?utf-8?B?V3BlWUpqaHJDWkJCdmFGK0l4aWl5WG1rOGpWZ3ZYalM1UHVndVlpQkFweVQv?=
 =?utf-8?B?cU4rNkl1YStHZFpxYndFTlhoWFE5TVZBenFlTUphSC9YbHV3TEE3N3d1MG5z?=
 =?utf-8?B?SndFMWEwZW1YcUJkeDhMeWx3REhWK21KQ3JDdHZMUm4vSkFoY21FVWJOSWlN?=
 =?utf-8?B?OW9IU0NGUWkzL2MzNzRSeEFTZDBTVGd0eXZ6U3YwRDRmMzdGeEErc3RPRmFr?=
 =?utf-8?B?N0ZGWXhjOHdlTmVPYVprV3NjSXlVc2JtbGFaZllWSE50VTAxSUxJcEN6c3N1?=
 =?utf-8?B?NDFWdkZQZU9XaWJud3cxSHd6TUpoRHNuR2F5MTVFRU1uS3N3clJiNk9XRHhF?=
 =?utf-8?B?Zy9QM251M1ZwbEhRUm1xSmFWcWNVczVtVnlHUjNXcHdTZk9VSWl5WklvRkxG?=
 =?utf-8?B?M1ZlSzRUdnJybkhhc0VoOFFTeTNQbEtLb2F6Y2ZZczVOcTVCeUdNajhYaFpS?=
 =?utf-8?B?WElYQkZkSloweThiV3BCb2s5UEJLbzVBRDlvME5kQThPSEV4SE15aW8yc0VK?=
 =?utf-8?B?R2VKeXJ5Z0JadEdBNEFib2JEbmpNaHp0T244S1ZhM3lURWNqZmdsL09qaURF?=
 =?utf-8?B?ZTdKMldBc25OYk5FNXpSOWZuZzliRG53cEFwazNVVFdxK0o1d2RnTkZoTlh1?=
 =?utf-8?B?bW5SbWdUVjhhd2RoQS95bXMwSVdHMFNHU25xTmxrYjBGTEwxQW1mZFZva3ds?=
 =?utf-8?B?cUFmWmFsNWt4UEQxOEpaaDNmQ2hoWmFqU2dLdHdHZUNrQWNLbjdiaFBoZkZE?=
 =?utf-8?B?Nm4yYnF0akNGMzd3MDJ3R3htVmNTRjdiTVlTK0NCNHFJRnVrQ1lZaTlWZ2F3?=
 =?utf-8?B?Qlh5d3QwOHRBYzk4ckxNSXBrT2thMmdPeG9OZW1ZWGhMUGN2YkVDZDJLc2FP?=
 =?utf-8?B?L29abk9IR3lBdkQ1SE10K3RudWFGUmE1MzdwSkNGcm1lSUtzZHJEdU5MQ0JO?=
 =?utf-8?B?bFVYdzVEZEFVU1l2eE1oZzlKOUhpM3NRaElwZm1DYUFRMEJEY2ZabUllOHpv?=
 =?utf-8?B?RVFoR0hjQ254RkdVNXdnRlllRHVVcmx2eFpKUE84dlAwQ3c1L0Y5aHg1UFp4?=
 =?utf-8?B?ZzE1UTVEbFd1Z21VRWJSVXFnR3lRUWxkbDRPS21sTm5vSDNJdjVhMkN2aE1h?=
 =?utf-8?B?bHQrYndQNUJiY1gvTkpWRTJudk55YVB3MGhsblQySkN0VC83d1ZPMFE4UG5R?=
 =?utf-8?B?NFV6ZDN4NkRYQjF5ZkdoT1RyNnFYU3VZbFR5QnF6L1lhTHg2MXg0d3lzMzht?=
 =?utf-8?B?OFMzSmM5cEpzWVh0VkNwcFBsVzRLemRaRzNYcGpka0NrTTUvdFJ3TDU2K2VC?=
 =?utf-8?B?MTBicVJmR2RZZXRvNEF6NEhLdUMzTlRGT3lFSGNXQThVeE9xNzJZUXR4VkpW?=
 =?utf-8?B?U2Z6aDEyd2VxaXI1UHBScU1KeUMzYVRIWFRWODZRekhuR1hsbmpUS1YzSnli?=
 =?utf-8?B?UW5wUXpzbGhPK2tSeW5YeVZ2Zlp3aUJoU2pzbFpMVUdtbHlHc2Jva2tTRHIy?=
 =?utf-8?B?bWtheG11bmRzckRnejdmdGljNnRmTnVuTDFBcUJqMmVMbVl5cHBLbGpCNUVW?=
 =?utf-8?B?VFNhb29VajRDUU1FcE1ieEEyaDdxZmhYWEIxbW5WbGh4UVA3VllGcTI5OFZl?=
 =?utf-8?Q?4eo85E8eyyY3W9m7nkBkDvnvL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5a0b25-5df4-44eb-b511-08dce249b666
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:49:00.3021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KslLd6Ab1e/WQbvbKtEuTv0SDLVm3L8rUBYLsjYMcuFz1Vk/PcbiaR+BqYkxXcwY5v+HoRRvEl5GMM5IIvoznw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

On 9/30/2024 13:42, John Rowley wrote:
> Oops, forgot to mention that I'm using the AMD variant of the Framework 13 laptop, which uses AMD Ryzen 7 7840U w/ Radeon 780M Graphics.
> 
> Thanks.
> 
> #regzbot introduced: 58a261bfc967
> 

Just to make sure we're looking at a pure kernel bug:

1) What version of power-profiles-daemon are you using?
2) What mode are you in, 'balanced' or 'power-saver'?  If 'power-saver' 
can you reproduce in 'balanced' as well?
