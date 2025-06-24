Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA25DC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 15:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740D610E067;
	Tue, 24 Jun 2025 15:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MjUYfUnh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F212E10E067
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 15:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NghQl3IQrnrih7vsA6g9K8CTPBvL4YuVWoJaEeMsM1XFgvks3nl87n9yt7MsBOI21k06yOLnSUSnHaM5dC70K4dl+NLrzh804eSGgKval0h6huxYsAIA5QOPo/c6bcDe0JJVy0MiPvQuIV6X+MC96BnDVMcgkUzyGXhxjCQGZLDaub2M6iw9IUjNaNGS5Xq7OH9Du0cOOFMEfaIb8GM2jULT448UTUFhHvxxDmVudu/kklgFm3+SpYba2u77kGdPuG+VXWbX4yNjDBnXv0re0gj8XkEF2U7vN+bvNVv7Q4lSnqlBqKZZMT7g0cm7GpSS0QYFzBJdnC3xpUUG8lvYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Emebu9cJdHOx6MkMLk0Wkt9F7YFvYfcM5oi5DSwg1S8=;
 b=U3sZzwDmPIhO5u0pRpKv64RJOjMMgZcsX5yd1/Swcg9Pa5nwfLBLGXsvxxTIu48FGiFxOx8uiLLDItfQ6PDgKY1dlWEc0bjL99a1eKnmQ5yV/wt1J1SMGBS9dqcLSk0nJUDlEeds3IwUl+vn3jB7iO9x6FukFIYeMWJ7hNhzR/U15BwcDzIRSLB+yhoGJkauFO+zzbeQ1ZkLsprjsaVtMP4YI3Su2K7lrC5ekdqzEmJdJtuJbuy9jDBlFx/oxrPs2/MlvKMc83qIJKRIhnIti5AnoRFPDIrMN7gOk2s3MfIML4qODA+S/GltqJjMbyn/V5mvBcJEyf7SPXTWQaPFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Emebu9cJdHOx6MkMLk0Wkt9F7YFvYfcM5oi5DSwg1S8=;
 b=MjUYfUnhJvicCWmM2F2iAGhLb4aEMXCDYATG4txJGfvdds+q16rOIv0KtN9MdAWLTyPcLhGihgDylta0m3WsiMqgTRj/VS1UZ06DixgeDqndBbzkl1tpej5YVHnjlx7Dwjf1vBH91fzwFV6Zpejfmu8uf3ki0WMvmq8K8A+XCxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 15:46:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8857.016; Tue, 24 Jun 2025
 15:46:59 +0000
Message-ID: <b5c4d8b0-fd60-4830-988f-6cf559fd53b2@amd.com>
Date: Tue, 24 Jun 2025 11:46:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't call mmput from MMU notifier callback
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, Philip Yang <yangp@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250623165936.6178-1-Philip.Yang@amd.com>
 <77dbf577-d767-48e6-b087-61dfcc478c22@amd.com>
 <0212b140-0c83-71e2-a0ab-f925b2125e98@amd.com>
 <c5de58b9-d71a-4a4d-8027-8e7cad34ab20@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <c5de58b9-d71a-4a4d-8027-8e7cad34ab20@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6b4c9d-d1e4-4505-f1a6-08ddb3365b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1Z2dlh4UWduclJReXUxTC94MGlOQjBoQWVpNEFrTXB5MEd6bGR5VW1rNndS?=
 =?utf-8?B?VVdVOHd1bDJpb21rNnp6TllvLzZnemxpSHBnQWVpMERGdDhLa291eW5aQ1oz?=
 =?utf-8?B?RE1KUkw2T0dGWTRqWUFWZjA4YmdiZ1RxYjdqT0E5b1poNUpXUHBFY1A2WFJi?=
 =?utf-8?B?dE9QNnROQ1psejVZM0JJVXFSYW9kNFRyQ252WWFxb0lkRVIvaXYrMWhER2kz?=
 =?utf-8?B?WmJLTVZGWTFiOEp0Z0VpWXVBZ0NqMjdHam95SjVzVXkycE9ITW1keGdMQ0c1?=
 =?utf-8?B?QkVaTnFUd3I4RlIvbVVCSitRQWJ1TE90bEdVMm5rN2Q0STdEV2hCMTVHM1Rm?=
 =?utf-8?B?MGdScE11NGt5RGp0bkVDRGZxQkFLNXQ4dElUWDM2VGY1ZVEwTEt4V0ljcGxN?=
 =?utf-8?B?ZjRybVg1SGFhUkpIQXBVRjBIRGd3c0psWUZmb1J6TkR3MDR1Y1hycWpnTDZ2?=
 =?utf-8?B?aERIWks5Mm1rcmlHZWhuZmxSWFBnTW9Qb01UMlI0Ky9XWFFHOUNpTjRkUzZE?=
 =?utf-8?B?QTM2TWYvZUtybjNQcjd5ZjYvMmFpVm16YjFBRnRtOXJMdmtxbkI2Qm9jOExY?=
 =?utf-8?B?ZFQxSDZ3Q0hWUzM3aFFqRFFob3JONnF5RElyMVlxYkpoNzVTQm5SZkwxYlhm?=
 =?utf-8?B?SzBsYWhmb0tRSjVVOWJwMXk2M1BwaVJPdWY3VlU4QXJHeTlqdXdaclp0STNW?=
 =?utf-8?B?R1FGejN6K1NuUm1tN1FpVHBJdEdQc0dublY1RlJmYlp1amRBQU9mcUdvTld0?=
 =?utf-8?B?b21FbjBJSm0vTkRjRFVYcGFaNE8yUWE0WC96NXBHVktydExPZnVrY0RBd2F6?=
 =?utf-8?B?MXE3QW9oSURhaTdrRGdrUFpsY2dDN0NtSUZqajhINUxKb0tGbmV6ZStkZG9F?=
 =?utf-8?B?N01uUXRXMTN0Tk5yYXJST1ZNVGxXRjk5ZWJBN3ZrNjUrOTVnTUpZTnhubWdk?=
 =?utf-8?B?ZWRQWjZ0U2t2aW5vYS9VNmMrK2VvN2xmSURBZEFDMUE1eDduUUJaM0hhYnRQ?=
 =?utf-8?B?Rmc4N3VxU1cvZVFqSFhXc2RSM2xXbjRjTVFxQVhXNDZwUmxJc3oxL1A5OGdD?=
 =?utf-8?B?cVdSRW1odzBZUW52SUs4TTNzWTB1enBoWWwzMHA3R0czcVRVdTZydTRYR1RI?=
 =?utf-8?B?dm1GMW52Mm1SUkZ6Y2p0bVlCN3NQcngrdGhWc0lTWk1IVXM5MHVtNkM2aElo?=
 =?utf-8?B?dmRmelprUWoyTjcxeStjMVplUlB1bTY3WGVhdGlINEZBR1lYaXlvZ0ZlV0Y1?=
 =?utf-8?B?cjRGUFVaS3U2QUVnTVdOcWlJVUNMYmIrSE9BdXlNeGNPOENrVnNNMFBxcG9C?=
 =?utf-8?B?UklBMnk0ZFVQQXNNQXMzUU9aZGY3Q1M0SU01aklzM2Z2M0toWlNqRkNDZThn?=
 =?utf-8?B?aHBUcmd6MkZiSlNoMWdiRFI5cXJ3di9NSkZPK0RMTW9RWVlCRzBMRm9Lcncz?=
 =?utf-8?B?MlpEMHZoeXZIclp1Q2VsNXo5K21lcStYVGJaT1R5eFhkMEQ5U0VINkVaQnI2?=
 =?utf-8?B?VnBNTWpDdlREaEpMOERKM293U0V3RzhSVlZGS1RnL2ZFSEI3T0ljTlpNUWlo?=
 =?utf-8?B?WWxEVEdhZWEwTDZwMmVuRVAzUFEzcUliYzN5bE9uK3RmU3hBZ0RWMDUvZEZs?=
 =?utf-8?B?SnlMcndmbk9aV0NsMWk4QVIwNTJDbGNtd2FMNzdJMXRwOFlzV21RdDNiK0Fm?=
 =?utf-8?B?VERtd3lHTWhPTnpGTDJpSEV0QzkzTFQ4NTZxZXVVWDZIWG01Qk5vbk5XbmVO?=
 =?utf-8?B?bUZtcGVEM0tDYmI1bXN3M095UXpNSkh1RjRSZG1XZXdlb2FvYXJsU3Rpcld2?=
 =?utf-8?B?UjYvZno1UkFFalVXeUdBaVFXTG1KTldreUdKN0Q2OWxZWlFyUnFISkdENXk3?=
 =?utf-8?B?RHJtUVJsZWFJQ1c0aDMxV05zR3FSWkhITVpraG8yUml0c1VJbnA5WTF1RUkr?=
 =?utf-8?Q?afkOXYj3sv8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZwZ1JxQ1I4MDkyMVRlbStTNVJYYUtuWlEvVHQ5azR3djhpdnIvSTVVYUo1?=
 =?utf-8?B?SHFmRFkxTFlycGRnTmo1cGluSnBuc2lRYzNXWUE2VjVDQkxGSlArS2tKenhn?=
 =?utf-8?B?VzRsaHBVZFFOVytaTTl4VlV6SE1sSnYwZ0JaTzZ5SVBKZWpKU2NhME4vdUNj?=
 =?utf-8?B?SGNSK003SmEwMVRrL1huT3JNRVc3WHVzbFBaZTNpTS9UMVJaVGo0T21QaXBT?=
 =?utf-8?B?aU11WUJZblRZU0lEREhGWVBleThpN3hsbjdrS3JGdmhLeVNKWWJ1SjVRYjUy?=
 =?utf-8?B?QS9RQTlaZnJrRFgzeW0yMVZMS3FCK2FvOTc5TmpkSHRESFA4YnA5WUROWXJV?=
 =?utf-8?B?NFJUWm43bUx1bEhRVU0rRGJBUmJrTmExZGZvTENUOVlUMGgvbDAwTmR6VnlX?=
 =?utf-8?B?VmVPL2F4OWd5a2U0T1BJM0ZmV1UvTk16T05FM1BLK0JBQVNPT0xYMzBYdnEv?=
 =?utf-8?B?TjVLL3dtbEpZS2ViMHhNVVRvSVNTZW5pcHpTVVFRTCtIcS82OW5zaHhmV0Ji?=
 =?utf-8?B?OGQvWVV5RzliMUlYamtHY1hkV3Y2UExVeXkyd3VRWFpSbUliSDFXSkY5SHVh?=
 =?utf-8?B?bTBReE9YWVZwNmNYQ0lUeGhGdFRub0trVml0YVNlRWhhUjh0eS9HQ05OQ1g3?=
 =?utf-8?B?Qmd5SHVGdkRxM1RVdmQzbXZGclJTbGd4c3RoZThza20ySzNuMXFCZE9QYW9I?=
 =?utf-8?B?S2J0cXVCSktPakZJb0FSUGZkeHBWKzg3aERxNjBZcUZDWS9tUDUxMGd6YWJp?=
 =?utf-8?B?UG9NWisyT21XMFZrdmtFOVVJTzNnU1JyV00zTUZTUGhCckhrb1BoQzNWb0Qw?=
 =?utf-8?B?WWtrSDZqc3BmRUtoalpvY1c4QlREeTRZRnRDV3Z2VTBYN0E4bE1wU2V5N2U3?=
 =?utf-8?B?VStvbUxnWjlRVW1uNHhoQkpPcmE2UCs1c3FkelJ2dGVzeWVBTk96V2h4bjNI?=
 =?utf-8?B?YTdtb0pGc3JSZFR4dWV1dHpnajF2MHBtWG9sSmZGRU5BNWlnK2w1a25YS2pv?=
 =?utf-8?B?MnIvUzR5bjZ3YnZVTGZaVGF2akp6bWNxblNGR3g3THJjN1haNkpqLy9PSjY3?=
 =?utf-8?B?UVhSN1U5RHV3MDhOUUZRd0dVZzRKSGNhVmdoWGFBd3MxQjBaZ1JJdzVUN3ZE?=
 =?utf-8?B?bGtLeGp2Tm1qbEVReHVwaUQxd0cyS0J4SE8zRG45SmxncHhYYWFwazlKdTZy?=
 =?utf-8?B?cWlJd3l6OXh3ZGRJSDdRaTRnVFp6bmxRUFFURk1XOS9kRHFaS2xicUgxTDlS?=
 =?utf-8?B?QjduRksyUk9NVUV0Q2hoWDkzNWxYTmw0SjZIMVVaNFpzUnhtREFhelIrdXhO?=
 =?utf-8?B?VmdiSlhUYkl4aCs1d0hSRmIzcThRM2FxK3pRUW0rNDdxYXlTRWdERWprcFZq?=
 =?utf-8?B?bnl1NFI5RTd5Z3VublNkdS9Xem1XeWYxaVRuc3pqUlR0RVQrU0gzbCt2Uktm?=
 =?utf-8?B?b090V1FYQjh4Yk9LRzU5N3N3L3pXcEpSN201OGFmc2I1VzVZK28yM3hQblE1?=
 =?utf-8?B?WGNDeFRPeG5rdXhmc0pBMHJhQUdZMkxUcWNTV094NzVBYTJCZUwySFlTaTRa?=
 =?utf-8?B?VU9tTUdMRUhqSzh0WWgrdTRFaXpRMTRzUDk1dUFBOXRSS0hNdWpzeWR2STdK?=
 =?utf-8?B?T0lXUmFiUmtIS2Z4cHRtSW9NaFN1MTVFMUFPQ1RMTDVvTFZuMk9SdExTWG1j?=
 =?utf-8?B?T3VYYVVmRXZKT3FXeFAyT0FqRHhRek1wVkhJTUl0Z2F2UjVRbzNPL3c4ZjBL?=
 =?utf-8?B?bDNQZ2tOdXRCTitVTVV5U3BmUFVIaXhkSm0zUzYzQU9SbnFnbnJ0WE56ckl6?=
 =?utf-8?B?S2pBOXQrZFFtM3ZDWXp1cG1EVi9iTE8rdmtUeW1ENFlUemNoWU1NaGZ2Vk51?=
 =?utf-8?B?Sk8zOEtUcVJqU0Jmdi9iaFZrb045dTlEMUEwR1FZYnpjUDJiNERPWGd0ckJJ?=
 =?utf-8?B?ditlUWJoSVY5ZlBZVFVyODdaOHhKeUhQNkN4RUh6bHpvQ0k3OXkvTjRrUGo1?=
 =?utf-8?B?cVQ4bGJTVWFUUEpCSGdqdy9ZdUE0Qk5Xcmd6WXJDK3l3dklHNzJQeGpHWDln?=
 =?utf-8?B?dlR0NTZoSXRLdW1vM2lZblFLeG9lUEk2M3laVjRuVlFQK0VTanRnZVgybkdk?=
 =?utf-8?Q?PJCY8Ll86spQD65dZBcORmln9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6b4c9d-d1e4-4505-f1a6-08ddb3365b32
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:46:59.7857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYFp5bVKLhjfp9XebkUiIhyHurTEXuilRWISEaAEL5MEzuenIN7EEnpuHt9nz4keDRD0iuXXSVUXq3WDxwVVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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


On 2025-06-24 11:37, Chen, Xiaogang wrote:
>
> On 6/24/2025 10:00 AM, Philip Yang wrote:
>>
>> On 2025-06-23 18:18, Chen, Xiaogang wrote:
>>>
>>>
>>> On 6/23/2025 11:59 AM, Philip Yang wrote:
>>>> If the process is exiting, the mmput inside mmu notifier callback from
>>>> compactd or fork or numa balancing could release the last reference
>>>> of mm struct to call exit_mmap and free_pgtable, this triggers deadlock
>>>> with below backtrace.
>>>>
>>>> The deadlock will leak kfd process as mmu notifier release is not called
>>>> and cause VRAM leaking.
>>>>
>>>> The fix is to take mm reference mmget_non_zero when adding prange to the
>>>> deferred list to pair with mmput in deferred list work.
>>>>
>>>> The backtrace of hung task:
>>>>
>>>>   INFO: task python:348105 blocked for more than 64512 seconds.
>>>>   Call Trace:
>>>>    __schedule+0x1c3/0x550
>>>>    schedule+0x46/0xb0
>>>>    rwsem_down_write_slowpath+0x24b/0x4c0
>>>>    unlink_anon_vmas+0xb1/0x1c0
>>>>    free_pgtables+0xa9/0x130
>>>>    exit_mmap+0xbc/0x1a0
>>>>    mmput+0x5a/0x140
>>>>    svm_range_cpu_invalidate_pagetables+0x2b/0x40 [amdgpu]
>>>>    mn_itree_invalidate+0x72/0xc0
>>>>    __mmu_notifier_invalidate_range_start+0x48/0x60
>>>>    try_to_unmap_one+0x10fa/0x1400
>>>>    rmap_walk_anon+0x196/0x460
>>>>    try_to_unmap+0xbb/0x210
>>>>    migrate_page_unmap+0x54d/0x7e0
>>>>    migrate_pages_batch+0x1c3/0xae0
>>>>    migrate_pages_sync+0x98/0x240
>>>>    migrate_pages+0x25c/0x520
>>>>    compact_zone+0x29d/0x590
>>>>    compact_zone_order+0xb6/0xf0
>>>>    try_to_compact_pages+0xbe/0x220
>>>>    __alloc_pages_direct_compact+0x96/0x1a0
>>>>    __alloc_pages_slowpath+0x410/0x930
>>>>    __alloc_pages_nodemask+0x3a9/0x3e0
>>>>    do_huge_pmd_anonymous_page+0xd7/0x3e0
>>>>    __handle_mm_fault+0x5e3/0x5f0
>>>>    handle_mm_fault+0xf7/0x2e0
>>>>    hmm_vma_fault.isra.0+0x4d/0xa0
>>>>    walk_pmd_range.isra.0+0xa8/0x310
>>>>    walk_pud_range+0x167/0x240
>>>>    walk_pgd_range+0x55/0x100
>>>>    __walk_page_range+0x87/0x90
>>>>    walk_page_range+0xf6/0x160
>>>>    hmm_range_fault+0x4f/0x90
>>>>    amdgpu_hmm_range_get_pages+0x123/0x230 [amdgpu]
>>>>    amdgpu_ttm_tt_get_user_pages+0xb1/0x150 [amdgpu]
>>>>    init_user_pages+0xb1/0x2a0 [amdgpu]
>>>>    amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x543/0x7d0 [amdgpu]
>>>>    kfd_ioctl_alloc_memory_of_gpu+0x24c/0x4e0 [amdgpu]
>>>>    kfd_ioctl+0x29d/0x500 [amdgpu]
>>>>
>>>> Fixes: fa582c6f3684 ("drm/amdkfd: Use mmget_not_zero in MMU notifier")
>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++------------
>>>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 10d1276f8e1c..5fe92f9a1ce1 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -2392,15 +2392,17 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
>>>>               prange->work_item.op != SVM_OP_UNMAP_RANGE)
>>>>               prange->work_item.op = op;
>>>>       } else {
>>>> -        prange->work_item.op = op;
>>>> -
>>>> -        /* Pairs with mmput in deferred_list_work */
>>>> -        mmget(mm);
>>>> -        prange->work_item.mm = mm;
>>>> -        list_add_tail(&prange->deferred_list,
>>>> - &prange->svms->deferred_range_list);
>>>> -        pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
>>>> -             prange, prange->start, prange->last, op);
>>>> +        /* Pairs with mmput in deferred_list_work.
>>>> +         * If process is exiting and mm is gone, don't update mmu notifier.
>>>> +         */
>>>> +        if (mmget_not_zero(mm)) {
>>> If process is exiting we not need do schedule_deferred_list_work neither. I think this part code need be reorganized with mmget_not_zero(mm) check.
>> yes, that is right, we could change svm_range_add_list_work to return true only if new work_item is added to the deferred list, and schedule deferred work. This optimization could be another patch, not related to the deadlock issue.
>>>> +            prange->work_item.mm = mm;
>>>> +            prange->work_item.op = op;
>>>> +            list_add_tail(&prange->deferred_list,
>>>> + &prange->svms->deferred_range_list);
>>>> +            pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
>>>> +                 prange, prange->start, prange->last, op);
>>>> +        }
>>>>       }
>>>>       spin_unlock(&svms->deferred_list_lock);
>>>>   }
>>>> @@ -2568,8 +2570,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>>>>         if (range->event == MMU_NOTIFY_RELEASE)
>>>>           return true;
>>>> -    if (!mmget_not_zero(mni->mm))
>>>> -        return true;
>>>
>>> Why remove mmget_not_zero(mni->mm) /mmput(mni->mm) here? I think they are for different purpose from mmget_not_zero(mm) at svm_range_add_list_work.
>>>
>> Yes, the mmget_non_zero/mmput inside MMU notifier was added to fix another issue that deferred work access invalid mm, to ensure deferred work_item.mm hold mm reference. But in the backtrace case, mmput inside MMU notifier callback release the last reference and cause deadlock.
>
> You have used mmget_not_zero at svm_range_add_list_work to prevent this deadlock. So mmput inside MMU notifier callback should not cause deadlock now. mmget_non_zero/mmput inside MMU notifier is used at up level to prevent invalid mm being used in all cases. They should be still there.

No, it's OK. We can use the mm pointer in the MMU notifier without calling mmget or mmget_not_zero, even when the refcount is 0. There are two refcounts in the mm_struct. The mmget/mmput refcount represents the lifetime of the address space. There is also mmgrab/mmdrop that protects the data structure itself from being freed. That refcount must be held by the caller of the MMU notifier. Otherwise they couldn't rely on the mm pointer themselves.

We need to take another mm reference whenever we store an mm pointer in our own data structures, such as a work item. Philip's change accomplishes that by only taking mmget_not_zero where we pass the mm pointer into a work item, and dropping the reference in the work item itself.

Regards,
  Felix


>
> Regards
>
> Xiaogang
>
>>
>> Regards,
>>
>> Philip
>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>>         start = mni->interval_tree.start;
>>>>       last = mni->interval_tree.last;
>>>> @@ -2596,7 +2596,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>>>>       }
>>>>         svm_range_unlock(prange);
>>>> -    mmput(mni->mm);
>>>>         return true;
>>>>   }
