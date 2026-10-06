Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0358ACA5FFF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 19:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C1310E02E;
	Tue,  6 Oct 2026 19:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KzYrNsrz";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBC610E166
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 19:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSlhx99Lek1RbqwKqVmR/L1e5oB4tccwjGQPTaCIU8EA7/XY4Z/HF9UtWu6EfNg5dc07rKBz4iDqL2k9W2H0qgAqSDWnNJEqc3HN5v+q0ID6rleSShuTfwNHwO8XVgevnZx7op2XvFdoceuR0bQMz8jTTHzOiAkFI9XDsy/Az0Q3vUnx+lOIY27Z0oHzects2CgiFDdGrvQHpv4GXn9zB7CcPMXFvq89gHHbeM7VFTPIC/FLz8XYcc74kQZKS1XuIarVZCrHD1NPoqBRDR8n8FUzypEzcfWM5D/95wdjFpNqmb/F6vqbOJXPtZQrGToBFsmLpbUSKrWndf/hCbqiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0/JckMsIrpVT5xWIYOn1bsC/GGmMZMZxKGp+6+aoUU=;
 b=ZdmJIvS2jXoymQPwDuZorPWJoYpVaTOYki2FNVdkOPjhM1VlAbniZWb52wF75mJqbekyabJ2OKtyhu8HI0vRADQUkNZ5Z8I2mpW9XRIzrLGzpRwzsm9wtcD68lsDHCHbExSuSDLuGna/r/hAAVK0zXt8b1vMeUMRWGio7ODQc2/GQoEWOUnNRb0pOGTRQ0S6EuR1SS3v1Xo0HJnNgpXXXkQvfrGFRreqzL5T5cu5zDG5wyjiOtF3qR25A6b3gKAg7WfHyOWyp3R6eF0Pq7+JiwhBSjC6DW7fW68YIwpvWxBvprmCLgg7jdJDruEdXQUywpSCT4XLiIOaMw2IN8vrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0/JckMsIrpVT5xWIYOn1bsC/GGmMZMZxKGp+6+aoUU=;
 b=KzYrNsrz7EcgPM7pmJxZHTH3C3+cvJ6fuD/6djlrYNFeTZ/bydFQ5+JyHgTQBLJApCiWtHkZwI7ciYgEZW2lFOt7uxWkZfySHFv/nVBWT/sv5Kqg3wqQrVOju48dbLt8tHKlVCsgwD8+LoNPImgg2duB7W4E1MpfF7imnHZ5lms=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SN7PR12MB7250.namprd12.prod.outlook.com
 (2603:10b6:806:2aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 19:07:36 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 19:07:34 +0000
Message-ID: <5f3ab1e0-0ff3-4a68-94cd-7b66f1b53b1f@amd.com>
Date: Tue, 6 Oct 2026 15:07:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: stop userptr restore retries on device
 unplug
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20261006183356.68286-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261006183356.68286-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::9) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f61519-59ae-4715-2c12-08df23dd143b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: a8JSlP8z103IWcPf5dFAqSiiLxxss9BLauC/I6LTlt3mpZ82Z7IiEHcVB77kcKPz+uHny6BWLlMmYumCB77cI3dEaLuUW7bvDpISKVy+jGEL1+kz2bhZV6jo77EVc0iAE4KPG+86Mg3SRvQMuWv+XrXCDmGSHtZyGiz3VZIwFcinG54fCJlEc4+kI6Mm5zyo1qxkX041NtxXG1V9mhvAnCZpa0qDLBu+H0ytVQKgkHbmjRpbF6wFQolfvAdi5RmrJ5OKr41Ttb1mnWfi8q1J0RW2Yij6HCKKhDkheax9Jt8JrMzm8feccImFfrNzW+LrSEGeDxQ373k2nP4sG5xTpilNtPqbwkyOAU1V5e3ExjxfPS4wvGLTj+32mMJT7cMlMBXP9k7FAZzWyHUY6GL4nwSKPrM9XAUrA8cYT0VjoPcp7iF6azkX9+vs0UG6n5PR4/au/KvVxGQBDRNCwfDr6SPuZaEmXJlsm4M2Fyn/4n9K3fPq63D/PMyuHkXXjB+VAzqpn/jF6ktEfC/46nvVHmOXhmzYKb6+XScLq62SIO7m8l9hGy4oGQiNE68YRS0u7nbBfwlqzaByFQFopb39o8BndFZgAHaUfol81qn06neGGvWfnItQ4C+EVT+1jWsECaMNi6nu8sVrZyfq9DDU0Jbsu6AGalGM4Nco7iTKH8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21YMEUrWHA2S2Vtb1BlNTNFeVVNVlFoa3BwMUk4Q0RyUU9wQ3R2Uk9taEFD?=
 =?utf-8?B?US85WU5zM0pwTWJCSHluQ2N5eTV2MndvVnJOWmRGeWVNR1kwWlVSVStzWGEz?=
 =?utf-8?B?ZEUrb1VTREhPakhHOGZTdEtscTJhb2JPMHAxM0VKbHRycjNIbEY0d01HRzBm?=
 =?utf-8?B?UTIxSmhuYWhxNE5hb3N2M2F5Nll3ODRCZkhhNjErQ1FSS3A1Z3F1cWdoYlBn?=
 =?utf-8?B?QkVzZjdJTjYwemJ2eDNxenpkTHBITVRrdi9hZTJZS25aemhRNE9kQnVUY2x4?=
 =?utf-8?B?QVN0VXJlVkJBOWZ0QXN2aFJwWWxXTVVTVmMwbEhrVlpwSDhBUHE1VWp1bzNP?=
 =?utf-8?B?Y1JRWnJ0K2J1bUJ4K3BwNVBML3o3SjBKQ2h1TG44S2s2MUljOVdlSXdNakVF?=
 =?utf-8?B?QnRHZjErcjJLc2FlQWJNYitJOENmQWF0TkZCbW93b2hreFZrb1VpNTVOOE9U?=
 =?utf-8?B?VURtczBRTE5IWHlHWC9YM2o4dzVmeEgxaytSWXNmVDM5SW8zREFYRFgzQ2gv?=
 =?utf-8?B?bVcreEtiOEkxM2hUTU8vb3cwYlFaSXcyM0hYV0p3OG9Dc0xucTlaNk5vZDNy?=
 =?utf-8?B?dWR1SUpKb284M1BwcVVNRkp0T3MxaExrNlhqTWNhRjdjWXkwZk52SHpMUVhm?=
 =?utf-8?B?OTZIcHVzblhRN3hZVGZId1RJM1F2K25ES2ZxRjBRbks3MU9uTVVWMUZBL21s?=
 =?utf-8?B?RmxDNnNEdU5wdi9TMFNXRk1ydldNSHh3NHRWL1VPblg2eEJTeFpjcmlyMmk5?=
 =?utf-8?B?NGsweTlSYmJVOXV2M09yZG10TWh0TlRPakpxdHpPQ3VMcTlvbWxIcHVOQlBs?=
 =?utf-8?B?NzV1QVQ0d1ZCVTdHV1BHMUNwYUM2T3NaamMxS294WXFDOUx1RjdaN1ZaT1lK?=
 =?utf-8?B?VEpUV2ZQVjBtSGVEZUtKZHlFRWRGVW1hU1oxeUNRTm5sZi9INHhPRGk3ZUhm?=
 =?utf-8?B?S2NXcjhkMUVYdElrdTlIV3JVbkV3M3VTM1VTRitJR20zem5iWU1XNFIxelhC?=
 =?utf-8?B?QVMwMWUwV256bFZ1K2R2TzRycGd5TTQwVGJTRUxhQ1FNaExtbHBzMVdHcDZ0?=
 =?utf-8?B?blppVVlSblBId2wrY1RqblRtbmVyMjA1ZDlHQmw4L2tsazNpY1o1S3dseGYy?=
 =?utf-8?B?ZCs1TlcrbFBtQ0N5aW9tTnFRREhXaklxRE5MNHNFNkhua0orZ0ZsUTRVOXg1?=
 =?utf-8?B?NFdZRHpsVmxyVXA1ZGN3VFN5RjkxMEtoMExSK1FLL1c1QnpnUUdZaldmdHk3?=
 =?utf-8?B?Sk4zTStyZ0p0aUYvVnlnbnpNQTdBMHUrQXpLQVZxVHB4OHBxZ055dDdpVGNH?=
 =?utf-8?B?eVVscHBEM1drczJWRitnbFhMRWUzTUNzSWtCR2N3cGNxbmdRY0NKb0prTE5i?=
 =?utf-8?B?ZTBKWDBOZ1RaaGNCb3NITTRjNnZyanRFL0p5cElJcUZaY09qMXNTRHJ0K0xw?=
 =?utf-8?B?MHdCcFJ3cXVMekw3TjlaRTRXMy9qdDVDTGFmQUFJOS9acWxXcGJKcFNLNzZQ?=
 =?utf-8?B?R2NEcjlTdmh3RjZURnlPUHRXYjEzMitkcElEZkVnY3JXNVpPSFZXSnphQm1Q?=
 =?utf-8?B?NnpQTUJsTUxOSTFCcHJWak90NXh0KzMzQ2dkM1I1akNIR2pBdUFQY0o4RlN5?=
 =?utf-8?B?V0JSN1dHbnBONkc2UXRqRi8raDNmWTljQXdrVTg4Q0ZNSnpTVDBjN1AzT3ZF?=
 =?utf-8?B?anhFdTVrL3ZoYyt3NkI0K1UzaXBzVDZVdHg4dlp4d2YreVpuemRROW5YMFU2?=
 =?utf-8?B?WjIwRUtpVVk5SERBUDI5bUZUSGp5SHV4Z1BJSXhLZEtzQXNPaFBwY0dWMGlm?=
 =?utf-8?B?QXN0TVMyUDNiZE84WDdXOG5zQm01QW13Qmk0NE4xLzdsV1dEV1BtOUxpNmFQ?=
 =?utf-8?B?MURub2U1NDEzV1JPWXBYRm1UalV3cHlFOWo4a05tZHU3S0hsMHRZZDE3elRC?=
 =?utf-8?B?VWFQa2U2NHh1SWJoSDYyVUNyV0I5cFlJSTFrU0N6Zi9zTlhzWVdndEk1ZkZZ?=
 =?utf-8?B?bnFsRGIzUWkzdE84a1lQLzN0ZUIxZklTbVo4d2pyT1JRbGtVYTFFRXpZZUdL?=
 =?utf-8?B?R29VSXFnVzAzQzZ5NjZkOVNDam1xeUNqenNKajBGUDBaSFZFRHVMTzF4dnNs?=
 =?utf-8?B?Wm9OQXcwbzk1NGVGR1ZvZG9nT0lmaFJpTjlFbU5MMFJGditrL04yWmUyRGpN?=
 =?utf-8?B?dk1Zb1BxaTJtQjQ0SE9TSjduZ3MxRHFhL2ZFekU0ZmVQSHZLNmxQdnVRSnpJ?=
 =?utf-8?B?OFJrd1BuM0pYRjUyQ0gzbEVxYWp3YU52WmlRQUc5SEMvNFlyc3NBT0VRQ2Vn?=
 =?utf-8?B?UDk1dlh6cTNWQmsvbm5IdnJqNlJ0WGNkOGx5WHBINlFhOHpCS1JnQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f61519-59ae-4715-2c12-08df23dd143b
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 19:07:34.5253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFUgJIAlYsMr9yNZiBvCz6uKJraXbJ3DAN9t1i8N4sIFXuZ3eqYK8ijOe7AjlAkWKRuX+c7wQy0Ot94kQiSwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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

On 2026-10-06 14:33, Olivier Kaloudoff wrote:
> Hi Felix,
>
> The worker is only canceled when the last compute VM is destroyed in
> amdgpu_amdkfd_gpuvm_destroy_cb() — i.e., late in process exit. On
> surprise removal that window is unbounded: in my repro the SIGBUS
> exit path deadlocked in SVM migration (patch 3/3 in the v3 resend),
> so process termination never reached the destroy callback. The worker
> kept rescheduling at 1ms delay, ~11k cycles, taking process_info->lock
> and notifier_lock each round until the system soft-locked up.
>
> There's also a self-reschedule race with cancel_delayed_work_sync():
> if the handler is running when the cancel executes, it re-arms itself
> at the bottom of the function after cancel returns — then
> process_info is freed right after cancel_delayed_work_sync() in
> destroy_cb, leaving a pending delayed work on freed memory. The retry
> loop needs a stop condition; returning -ENODEV on a gone device is it,
> and it also avoids retrying validation that can never succeed again.

Shouldn't cancel_delayed_work_sync wait for the worker function to exit? 
I don't see how that can race with the re-scheduling in the worker 
function itself.

Regards,
   Felix


>
> Transient errors still reschedule as before.
>
> Olivier
