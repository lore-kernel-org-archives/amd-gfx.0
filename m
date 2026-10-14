Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BEACC6B24
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 07:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11CF10FB9E;
	Wed, 14 Oct 2026 07:11:57 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097B110E4BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 07:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2N7HYev2a4xyY1WvJLRBwwxUtyS3ab6FD2e55VxrBE2bLllOjywpIhJlOmPpl0K+68IQT2hZnEI33ckS+ap0ex/ryUrrBLSjDKP8lIsTNjoiDHAkgR1gX8VXlX7W4KQtl7c5OA+8UHLq5A+6meBgRcG0+UUy4zp8X+1ArvIatKVnYYGluIyDxpMEa2KmrHN6A0b9fP+fnVRKsC2nWa9Otz7He7HjTcI+jGc784JnXk7ABpu3oLC4TeZwjKnqbWOgFPzN0hmuhr/+bXWdvUfmEGZn/aPWwjfxEr0mg29Vy0DElEQfXjilBi8eAMBt/vJYTBIxz6Bkaddeb9N2liBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBpDRYLzDX+rsnNp6H3zByNdGSw+6Y/xEz3/lx5Uk4g=;
 b=YHOR297MQeI+FJ64dmvwc6fi/ThDB8XLZBzFb9ae9pWNWmJP2jlu9ayAPYMBv7EFL7tih8FrJMEpgi9EEvxbCyB8kZDGYoYyyjteqTLkG0ueTFROqIVE9QoeBzggZel62r0iwVq5UJwukyD66iMz2WQqX5++Amqovy5ztRJBGcFwURsX1UQ4ZrZ/HeTDwyJYY/OOKR3aFxkMvaJniBJCJYJTmiDpojeagdkOj6bqosGMod7LiKD7xctvdoxAopoDhagI1yB7mneDDfdBFAY1E+Rv7oTYAQBVFfoEbjChhcYPF32s/68uMqF4kQmy4HHjf9tLiQI92/B5NKj76/ohAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBpDRYLzDX+rsnNp6H3zByNdGSw+6Y/xEz3/lx5Uk4g=;
 b=wriEQYLk6QEBuRXFU4fdzfapsasfO2i+rP8PyWWKvxhHCZNFNlsKk569vDZGWOLsGm6UMkQSfJOTTDbqeAEtQkqnLCtMbieS3SZFygjSDU8p/MGF6/HlFdOrcogiy1T5rJtkgEBrsc+Z6JXsRszqCsiCdsGqr3oa+Roij+bm5hk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 07:11:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 07:11:47 +0000
Message-ID: <5028b598-b039-46b3-b4a5-9563ab0a252e@amd.com>
Date: Wed, 14 Oct 2026 09:11:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
References: <62280d57-3f63-4979-9e4c-f0eca7208b19@amd.com>
 <20261013185325.33682-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013185325.33682-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0306.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7414d5f1-02e1-43b0-3640-08df29c268d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|10067099003|22082099003|11063799006|4143699003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: evyywyo0v6FnC5/7+LuXvvGV6sE2YqvZIbYTVw69IvkZuxfKHwEbYIEJqxyPTT+iD/n1HrCD6Vwnv77rOV99uWVOTqYyvaxfxmdzoqzbmlfU5qahlCc7OW70dh+BkguMVlp9m9/nik8Wv/1LfJHMD8XxZuFPY0+HClpLNoLtfB2a8CLjwnkqatZI0UgMSoVxaXIjZaoEVLps9rTQNMNnJ21bGrXCk4ieJKFnHLJfCrs7omZUjmbe5k60JiNNGy30CH2wb7I/mywklrpY5bSVwTcEoX3cTrKzMMJernRSotsZCdGpd6jXEZWmaep6x8qAHTrlIhh4jM4QlWVI6TJ1FGrb3G/FXrq9nyOEsDY5xi0iSG8EXBITD0hs8v/Qeb6E6CuACckh6kooqsCUfF8id1GKi5A++bVrpGKgqSEpVO75sctvK2bZU008v4gqwnvTj4FNVQ5OR/XySwuB+8jxfPm37B8u0mTMb1SCv+KCuz6BSssJmKv/As/GhiQePZ6hhH+oJrnRY+85NUQKjZ8nD/iwx0D9E1zv7y0Kx13rbrvSesFvIZJEZbKGnp+az3sr7s6y40qEsAPPnRiq8IOBiriEEUE0H4wirxYG+CnhI1Zrn+8h4ngeJJaROraIcLgaj0n3A14scghxKKKa/kwbdb7UJ/sV8avgcOKVgpCRL7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkJtVjRBeDZ0aHMySTBLMjMyTENndjVEOGVRczliVzVQUXg0VThqb2ZNWkcy?=
 =?utf-8?B?VlFSU2V4VDlZelF3d2p4T1YrYkFtZkhwVHpCc3AzSE52N3o4dlFRN3NRdkE3?=
 =?utf-8?B?Tks5VHFaREUzWXJXNDBEejFsbkRNQUkrb2liVzVLUGttUmQ3Y3JienBNYWg2?=
 =?utf-8?B?MFJHWmVBeVVKVFFiVTkxZERhZ2YvaXZ1aWRiZWhKd1NYUnpLR1VuL2dZQ040?=
 =?utf-8?B?TjBML2h6NCsrMlpuWW5neU5wbGV4czMvZFpNMENGL21Obzl0Tm5WcU1ZSTlu?=
 =?utf-8?B?U3Faa2JtY21YdHNQZVp6K2JlK3ozNkFLck80Y0ErNis0czl0a2ZkbUZZWERG?=
 =?utf-8?B?eERuc0FPOEFLQ3NHUEd3bUVNMmMzV2xKejZNaDRPalFwU2hrbFFWZkJwbTFV?=
 =?utf-8?B?STVwRUhuNUUwajdxdXArWllLZVZJVW5IazBEUU81cWJqa0ZkOHdRUjdpSGkx?=
 =?utf-8?B?cnh0dmlGemZEcys3UmJWQzUyU2p3c2JEWklVZ0hiMEFkT2F1cEdwY0NwRmZT?=
 =?utf-8?B?Zy9sS05vcWQyaElwcCtaTDhTU2VvNmdZU0x5Z21ZYjhLNWF2Uk1IbVZEblFX?=
 =?utf-8?B?QjFRY2VCbEVwSEYrSEMzT2JqRStLMDBaWTVoalFNT2RmN3VibEZ6a3UxSE90?=
 =?utf-8?B?ZjBnQkI0Mk53UzZ2Ui9XS1dGa2xleHRndVl2MGxtRGtPR0JaS2Z2TldNTXBY?=
 =?utf-8?B?T1FJSEcvQXZQNTk3OGRDL2F3ZDY2Z0ExRmZOLzBNZDg1ODhNMEQrd2NvcVlI?=
 =?utf-8?B?Qkc3b1J2eGQyM2RGTTBDMTREN3JmYWZFcjhaT2hYZHhWdS9waUh1UjBHdEdj?=
 =?utf-8?B?eUNYWFpGSkl0RHhFOERoamx1QVlnYWh6SWhkK01RYU5KN1N3UC9jdjVQMTZm?=
 =?utf-8?B?TGxySjBpeWFVMFNmbkpNUFNEcysreGRKOXNnZE5vUzRHTE5PTGV4QUlINFRP?=
 =?utf-8?B?eGMydTcyTGVFcWxIbktjVUFTSytrZXpMNlZEMjBhbkJDTGw1WVJla1ZRcVQz?=
 =?utf-8?B?Wm9kSXdEMDlXZm0vVm1ySm9yUlRiQW1oZkFQTU9Wa3hxeWdRMFBxWjNMeVBJ?=
 =?utf-8?B?VFNFYnlnSVRRTEN1QkVyWTFiVFZnSExDSTlsc2EvNUdYRGJ3NmUzdmpGd1Jl?=
 =?utf-8?B?U3YyYXZaV2ZEZ2F6RDZCS0lTV25BdFRpeE12VzlNQWYvbnJjZjJpd29qb09B?=
 =?utf-8?B?MmkzYWsrWHN3UHVFTTFuNTlBQm5XTUF4R0ltcGYvdEdWT0lZeEE2NkczcnVt?=
 =?utf-8?B?dElwRFlTbEFDcWtFUklFcUdVWG5FNEdSRmc3OHhOcmJtOWR6SGREcUFoaVNB?=
 =?utf-8?B?MTV2czNXS2t6dS9iR3Izb1hlUHA4SDJIY3VnZVFKRWFRTVdmNndRdjZJYXhh?=
 =?utf-8?B?aVpiQTVOTUsyWFdwYk9xelZvMnM5YXNseDE0WURyUnRFWmliSHVQMUpsa1Rn?=
 =?utf-8?B?OXd2YzRzRXJUUkcxdXhCY1FrdmRKRFM1VTNQZXJlOVdOZjhsRTgzSnFlQVRI?=
 =?utf-8?B?WG9qSFVTTU9FMWZRNlZhTnRJM0cxK0lEVmQ2eXJoRUhJVEpLWENSWndiVlZi?=
 =?utf-8?B?ay94eDBTQSt2d0tBbjdaTlc2bC94VWRsYWs0UWx2VnFodmRvUWFNdlhjYmdX?=
 =?utf-8?B?ejZsNytvRU5VbTdma09EUDN5WWR1L3ZadFBSWS9pWE9qYXZsMEV4bVJKSHl0?=
 =?utf-8?B?bGVHOE9hbkd6QVR6QnFrb1Y4YnJweE5mTE9ZK1NidTl5dDlLWHVpSHNERlpW?=
 =?utf-8?B?dWtydytWZllCNDBwTnpkanlRcTNUUDZkZW5DdUt4UVBMbWFsTDFWZ3BHY0hT?=
 =?utf-8?B?Y3RwTE1CbXllc1UzbjRHMEhJbHRsYTZPdXJza0wvQWJ0Rk51dTRyeCtCSlls?=
 =?utf-8?B?Q3Erczd0K09qcEs1OHFwa1UvK28wOGhDT2RHVVBHc1B1SWtZR0FYa3l1cG9r?=
 =?utf-8?B?dWlXa0lidDRxQ1lMUTFZZmwydmJmNkNTcTVpMy91MkUzTHJiS3B1cXAzVStH?=
 =?utf-8?B?a0Y0YVZ4bnloek56MEVUQVhxZlpVc3BWWUVnNUV4MjJaSFRCZTF5SkxpSGpw?=
 =?utf-8?B?ek5LakQ5Mm9zZ2ViWVBUVXpRWXRvaDVOdFlzTmtDZ2V4dTU3cWNkaC9kM2lw?=
 =?utf-8?B?TkJNV2NZYW5PN01mQ1JrRVJtcWgzZmtBR1VxTmpqL3A1Vm5HcTQvbHljcGFG?=
 =?utf-8?B?MGRod0hyRGhpOG5GSEp0eU9paDRrREY3d3owVUtXTkI0Ny9KSUJ5YUVjTTJ4?=
 =?utf-8?B?VjBWRldxdENRbHk1R1Q1WVBTUUR0eVU5b2czbklpQ1BjTEY2OHpOMVhLQXJq?=
 =?utf-8?Q?yYFq86d/rYbFiguz+I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7414d5f1-02e1-43b0-3640-08df29c268d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:11:47.1022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsP5hL0dt4voHNCmHgJLiuhf0Pqcz8zOse3UU4B23YDHf3mUqu2wPi+bsMIGRase
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
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



On 10/13/26 20:53, Olivier Kaloudoff wrote:
> Hi Christian,
> 
>> Fences *must* always signal especially when the device is hot removed.
> 
> Agreed in principle — but the observed failure is precisely the
> counter-case. During teardown the dying process's fault path submits
> an SDMA job to an already-killed drm_sched entity:
> 
>   drm_sched_rq_add_entity: Trying to push to a killed entity
> 
> The job never reaches a ring, nothing is left to signal its fence,
> and the uninterruptible wait in svm_migrate_copy_done() never
> returns. That orphaned fence is what kept the task in D state for
> good in the repro.

Yeah and you need to fix the fence orphaning and *NOT* the wait!

> 
>> a non interruptible wait with AMDGPU_FENCE_JIFFIES_TIMEOUT can
>> never fail.
> 
> The ret < 0 branch is indeed dead code — dropped it in v6, thanks.
> 
> The bound itself is needed for a subtler reason: the wait now runs
> inside a drm_dev_enter() critical section, and drm_dev_unplug()
> blocks until all such sections exit. An unbounded wait inside the
> section would deadlock the unplug path against any fence that fails
> to signal, for whatever reason.

Yes and that is completely intentional and mandatory!

Blocking for all fences is correct shutdown order. What is not correct is that the fences never signals.

There must be some problem with the error handling in the SDMA submission code.

> This is also the shape Felix asked
> for — guard HW access with dev_enter/exit and keep no unbounded
> fence waits inside those sections.

Clear NAK to that!

Regards,
Christian.

> 
> If you'd rather guarantee the invariant at the source — i.e. error
> out fences orphaned by jobs pushed to an already-killed entity in
> drm_sched — happy to look at that too, but it is a much wider change
> than the KFD-side guard.
> 
> Regards,
> Olivier

