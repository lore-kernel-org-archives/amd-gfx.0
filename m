Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C02C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 04:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E87010E29A;
	Tue,  1 Sep 2026 04:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/3I13O1";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8228F10E29A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 04:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgVeazsLEweiB9tLrWe3FDkKvA1RZS3lG/RyoZ1f+YGb8CoxcQK/TEdrUZq1PGodCQP3aufTanYbLSG6N7FCUFUMctnl/UDLNY9iO43IAgpt1/idYs+sjBpR0vXj3vt7NAFyZDAEivzKimL1ch5eewCPHpUbi0wbtuiJSV0/vTtkO9TIriOd8IWPxYeihcNyn8r3nSHrBkQUkXEUGp96/BpwbczO/nQBVr4SZFbNI7zg3Fi3ss3/6xAHJhjj5LfnDxMAuXyMrn1oMXlpF4QbK4YR22LSeRz8dBuCdX9soVl5fS1wgY/9FyBbgwVfdX63EJJGZkBDPyWF5DJZLsqOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8HpBfy0TQGowULfOgkeTNtFK+mla93eqVhm3k1w6ow=;
 b=E5RoF2rrB/zQ5dG8JlLCxT8E6Fk27N2Z1a2OWZNW+LEKXuvbcqYqWDrTkwvxppjxb2c8HZuNhsShf8lSMOL61Pqd1+lXc7AlzmpxMJwVG21iax4PSzd/VJCfTnAzqZzmS0W0yXACYSBcqLuOJmr2ilo5gojiX5bP85f6mZoQO5kj7kwMWM2ZcE/DH0e84P9ViQjfiE8BOoq2e+zbWM+kRB4k6b5T9tJVUGMFELhBGsLbGLBerlz5dzZKVQyNK9XHJ8/8kkPVmtYhB00Oq+FzrucCHoob2PsXzDjXFy5BsUZvoHxRQ5uFuuugXHgM/5b6VWDiIza1OQ+8e9WhbFfxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8HpBfy0TQGowULfOgkeTNtFK+mla93eqVhm3k1w6ow=;
 b=v/3I13O1JSECY6Dqbpvv/vIXCz+E5tvUFKmovORyFON6YK+hxRkF8T/Ju3bF4WFVjw05ALNwAe6NSb/W4ymB2ZIIabliiu7i9QYgRl6E+O/yQPKRXmaJneJUC8ZYzGZr9CSqwpy4dhSyhZCtkAR4t9Z0dq0CVgCnlhblgxz3cis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 04:34:51 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 04:34:51 +0000
Message-ID: <08116b30-c131-4fec-9aea-a5d616863906@amd.com>
Date: Tue, 1 Sep 2026 12:34:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm/amdgpu: unify SVM notifier and VM eviction
 locking
To: Christian.Koenig@amd.com, Ray.Huang@amd.com
Cc: amd-gfx@lists.freedesktop.org, Honglei Huang <honglei1.huang@amd.com>,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Junhua.Shen@amd.com, timur.kristof@gmail.com, natalie.vock@gmx.de
References: <cover.1788103444.git.honghuan@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <cover.1788103444.git.honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 026e03ca-f13b-4dcf-81fe-08df07e25c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 53rdY/fLpfMuwJJWWGARi2qf8Lrs1XzTljrjaKmepBn1RBbTpWrwB+et8u2wmrzJAi82MApQj6jfqm23MNqBp8F0KDo6wVFR4pp4Z9KnqcTmJZDrxz4BYQMjixP9+hNzD5+FIFOo7KBZGGSZ3LdKtBhbgQzCf6+WvyxmSlWM4ptmfdHmiaYR7OCNbR/g05bnvP9ly8u+HQBN6DttI8hovQa0gPYxBcvuXZhMEZsa9pqe7XEn1r9F0PjIfFrqKoSYavO0gUuIa/4zZa0OllKEF48fP3BE4EBO/oW59UZu4hSJyDK0om2/IAwBvI53UyNhA64YowGElSCtwqRS7PzqoyY6rUukkM/hhkYSMfSHkliYCvCmrX129D90bltSdk95frYVocm+RsY9ktNDONK1p61jzHf9BB6g50KX1vTVRUHUXDYbcM8Xwdu/nqsIGZSh+qAS8PsdcRwsvVzmF1YYGIOwUvDLyfXhmf8TuhZ5hMbUyhxIwEgEccdD6GmeSXp286klZkWHqG7ch0A0lwoOaZd9Rc1jmW6CKB+13+fI+5dvOYfijuiBHD+95RHMBdHxomygKDjUH71Iq1Epy0fTbo2VDUDXg2PAY/XEBSfTD6qYeTAuIU5knj3amQMC/EqgiFxSKTwRBNuXvTmcslYKlX+5re2EWKCON7cGXnM0JU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVVEMmdjSGNFN2w1YkZsTlhzNlp0YXRtaXdUNGlaRzV5NHFlM2pUMnZRTjBR?=
 =?utf-8?B?cmlFYmhUc0prNXFJOU1DK3ZLODdwWW52aXZJZjZqWk9IVElONGR6a3BDVEZi?=
 =?utf-8?B?NG5aVFM1ODdwU3Nuenh1OFVIZnpETmFKQ2NOb05yYXlXV1ZuZG90RGZocEFO?=
 =?utf-8?B?UTFHVUVpQnc2VHBodDQwUjhUQ0tmYjZ3a0NsK0VxNkF2Wmp2ZzhhRUU2cDYy?=
 =?utf-8?B?eUJiNzRXVytJYVFFVERWWEtoWlJFeGlISkVnSHJlaGhIekgrdDJVeHZLZDJ2?=
 =?utf-8?B?cTlqdWJEYTNSTkJvMm9FK2RqYkFWQmVRQnhldnhWV05PSTR0elJmUTl1TXl1?=
 =?utf-8?B?VENLTDhHaC9YUjlyQTZrSEx3a3JSYTlkWk83T0V2NFpUd2srZDFRSjB1NTBP?=
 =?utf-8?B?LzEybDRNaTM2ZFZCL21uRmhHK1BjMXhONCtzdFJXRU5laC9HUXNTVzhvSDNQ?=
 =?utf-8?B?ekhnOWJZL3RybG5YdGZQc0V0WFl1TUxZRVpmdnB1cnVrMFJvOGYzU1VhdDR0?=
 =?utf-8?B?TVZLV0JyczFmSW5HVTdjWlpIbWhrUVpjU0ptbE5JS3cvQVlqYzZkMjg5d1ll?=
 =?utf-8?B?RVVtQzFmd2E5WUR2Vllrd3NPVVlGUFdyZThoU1ZUQTdDdGR1TmRjSTBPakg1?=
 =?utf-8?B?K3MvcFBmY3FqSi9FVmVORjFUdG8vTlZEVHJzKytrUm1MZVhsT0xOZmpkcWdU?=
 =?utf-8?B?RmtvSFpGSkhUaGFTa2liNmZtbi81UmcrR0drYi96eHBObDNvZEJWczBQYW1k?=
 =?utf-8?B?cEZhS1hBdERyQXBwZ2NldDVUUW1SKzJBMG9wZENmelh3NlBrMkd3dTY1dWNL?=
 =?utf-8?B?NGZHUHkzSENBSURkNndaTDQ5TE9aR1VPQUt4K3RSOXY5dWNhMldGekFBbG9y?=
 =?utf-8?B?L3FjZ29iaEFlNUNXYzVOM2JZYTFXVjVMS2pSVTNRNGI2S3ZKNE50L0VHZ1hO?=
 =?utf-8?B?eGZJQm5FZGlRZklPcjkrNG9YeTRjTnlOcHdyM0xocHNQZE5NWjAvRVpneUx0?=
 =?utf-8?B?RHJuc3I3ZS9hSmlGeW9HSnltR2FoSE5XeThKWkpMWHN5eTFFL0ZlckF5NlZz?=
 =?utf-8?B?Q0dYNkduUmIwcVB0d2ZaejRwS1JkY1pGZmdDa2ZmMU5GWWZtTkRnbHBMZ1FS?=
 =?utf-8?B?V0ZhdEhpV0loMC9tYkZvZG1nSDF4cXVFM2J3TTdlZGd1Q0FhNWZqVlFwNFZy?=
 =?utf-8?B?Z1J2VGFkSWVsRWpkQ09tUlBnZld3cWJ2UTMySkh6UDRsMWwyQmx0RnZ2SUg3?=
 =?utf-8?B?ODA2c3pTUzF3dDFrQ0luMENManZIU201SDZCSktwUGJmMnRUS3NlR2owRExE?=
 =?utf-8?B?eTlQa0RTNWlwQXJ1MDBaTFlabFRCK0ErYUlsZjlsVnFoM0swZ1V5MVZZMVJR?=
 =?utf-8?B?RXlPV1pZWWVYZFp0cUoyVWUzODRUNDNvTWFwb3lBNEs1MDZYNUpSdlJqd01m?=
 =?utf-8?B?NFBUU2lLSTFCRDUrU3g1QjZ2aGNCRCtyWFpkOXlaU09JdldWYUJOVXZRR0kw?=
 =?utf-8?B?QXJPMFhaalZjbmdrZFEzTWRZMW9ubTY5M1ZRTFdtQ2E2VG45b0U5VkZoVTc2?=
 =?utf-8?B?dXZXenpwTVZBWVlLNC9DNnI2eXFvc2RvREhJUEtaVGVtWDdRL01NWjZRSTdS?=
 =?utf-8?B?SEdDL2JuT2pFM0dsM29Ybmp3T0V5eGwzR3RMOU8rZXFWUDNoRVg4QVZOejlE?=
 =?utf-8?B?K3h1akpSdHhZT1dwSWRBTmV0dFQ2VTIzS1dRMTBOWmh1N2IzT0dIdTNvaWxU?=
 =?utf-8?B?a08vaVVSQnRQMFllR3JPVmkrZzN1SytGWjUxTVpyMnl4bUZ5ck1TalIzeFUw?=
 =?utf-8?B?M3UwZFk4dXN0TC9LcXpIb3Bsb0RVUFczZ0x4L0hTcmdPY0tsQmdpZ3VnaVVK?=
 =?utf-8?B?dEIzMGF3cjZhalgxZW5ac0Nhb3dpMXFxYjkwUkR5L0RBMWZ6OVlWSGhzZTdD?=
 =?utf-8?B?bHE4bnQ5NDdmaTRqcTEyWGU3UVZhU3UyTFZkbzVTaDFQdENFak11UC9nMXVM?=
 =?utf-8?B?Y0hhYlNGUkFYREp5T05pTm1wM2J6SDI5TExzeUhJWFE4eTZ1UTdZazBWaksx?=
 =?utf-8?B?cW9Ld21pc0M1ZWZmMVNZM3Z4SXV1a0M4dEpXNUlpWmo2Mm5kbFVLZVUyaWpX?=
 =?utf-8?B?RUFaVGhmRE5PWEtCVE9sZURNeXJMRVJXbHczWExBN2tLSTQyOURrMlNTMHgz?=
 =?utf-8?B?aTBQdWJxeEV5T1JmSzZWSWxMQk9YY0lXY21ITWp4RVZWcVdXK0o3RTF3Ymxz?=
 =?utf-8?B?UUYyZmhURU5DcHZoOTU0WnF6VXE3b05CUVJmQkE5UXhsc3NmN0lhTzFWaldr?=
 =?utf-8?Q?K97vZKJgMHQfF9eizJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026e03ca-f13b-4dcf-81fe-08df07e25c88
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:34:50.9669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D662XTC3htJiqNW3DMegy1kdU9XrrPFqK+4Fi83YpIOujunnBuQmvFSqGmow2VO2nItO9kCTkKxgLTCZigAwvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
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



On 8/30/2026 11:40 PM, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> This series follows Christian's suggestions and builds on his earlier
> fix work in the amdgpu VM critical section.
> My understanding of all amdgpu VM locking details may be incomplete, so
> review and confirmation from the VM maintainers would be appreciated.

Hi Christian,

We are preparing the V10 of amdgpu drmsvm, cause your fix series 
(drm/amdgpu: fix the HMM range handling for KFD SVM) is absolutely necessary
for the amdgpu drmsvm, so can we

- Include your fix series into the amdgpu drm svm series, cause it is 
easy to rebase / test / cherry pick.
- The hole series based on your locking unify design so will add 
suggested by you in entire amdgpu drm svm patches.
- Your fix series maybe need some base / change according to the latest 
amdgpu drm next, so can we add co-developed by in your fix series?


Regards,
Honglei

> 
> It is described that the ordering problem and why both paths need the
> same lock:
> 
>    "Originally the notifier_lock only made sure that the CPU page table
>     updates were done in order and originally the eviction lock made sure
>     that the GPU page table updates were done in order, but essentially we
>     need the order for both.
> 
>     The point is that the updates need to be serialized. In other words
>     when one CPU is doing a mapping operation and another CPU is doing an
>     unmap through an MMU notifier we somehow need to make sure that the
>     corresponding GPU page table updates execute in the correct order."
> 
> Before this series, the update flow uses two locks:
> 
>    map thread:
>      notifier_lock (lock A)
>        validate range
>          pt_alloc drops only eviction_lock (lock B)
>            allocation enters direct reclaim
>              MMU notifier tries notifier_lock (lock A again)
>                deadlock here
> 
> The allocation cannot finish because reclaim waits for a read lock that
> the same thread releases only after the allocation returns.
> The VM helper also cannot drop and revalidate the notifier lock because
> it only knows about the separate eviction lock.
> 
> After this series, all three paths use the same rwsem:
> 
>    map thread:
>      unified notifier/eviction lock for read (lock A)
>        validate range
>          pt_alloc drops lock A
>            allocation can enter reclaim
>              MMU notifier can take lock A for write and finish
>          reacquire lock A for read
>            revalidate range
>              range valid -> update PTEs and PDEs -> publish the mapping
>              range changed -> return -EAGAIN and retry
> 
>    MMU notifier / eviction:
>      unified notifier/eviction lock for write (lock A)
>        clear PTEs or evict page tables
> 
> The allocation no longer holds lock A during reclaim. If an MMU
> notifier invalidates the range while lock A is dropped, the map thread
> detects the changed range after reacquiring lock A and retries instead
> of installing stale PTEs.
> 
> The three patches make the VM eviction lock read/write, support a
> caller held lock with post allocation range revalidation, and use the
> drm_gpusvm notifier lock for SVM VMs. Non SVM callers pass NULL and keep
> the existing internal locking path.
> 
> The patches apply after the AMDGPU SVM build and VM fault-path
> integration patch.
> 
> Testing:
>      MI60: KFD svm test passed, 2 known attribute failures (attribute get refactor).
>      HIP catch_tests: 98% passed.
> 
> Honglei Huang (3):
>    drm/amdgpu: make VM eviction lock read/write to match notifier lock
>    drm/amdgpu: recheck range validity after page table allocation
>    drm/amdgpu: use drm_gpusvm notifier lock for VM eviction
> 
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 37 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 52 +++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 84 ++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 15 ++--
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 30 ++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 29 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  7 +-
>   11 files changed, 176 insertions(+), 86 deletions(-)
> 

