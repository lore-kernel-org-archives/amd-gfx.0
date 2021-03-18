Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE864C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5501164F10
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5501164F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47D56E89D;
	Thu, 18 Mar 2021 07:53:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E3B6E89D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3zMhGZ/TZcnir8B+srXXkewoRge2RhZZMkmepkJ2arsY3s3XaMMdjEZ+j9QpC/MP/obv8uNX6/6pEovzdC7Y/lWuTiP82/g9vyB7lpnF3PFWWhZY9EIW7SdF6rUOZWQHh687ASGmwQJMXrh9ZhcrB4KdrhBiHaOJGdMjL8gOPZY8bvvBNVejP4i342FnN6n1vA8H7YDZ74KW8X/XjAN24nZsTc0/DjTfbeDKPFZWLtuASFvUNdLmQ1SjFSZN/okqEm5AmKoKciiBEP48R9UL+Ivt/bSBHMFUjhuX39GQy34nxWJMYQUS4QU+Jaxiloht3uwJyqMQsmqDOlhvjlPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7zm8OagMEHwwktbcOYN79QCyUORUNcPonAYhFf6DG0=;
 b=bwjVk3UYOMcgZYUhBBhUB12RpnRNo1FKlXmbB+CTYpCLdzLkAn05MUXWP6Lg79xnU4xaRfv2/nWjO/scR/qUtmzVBEhmFdFxiSu1XIRUEaAxX/safDVl5snMq8F6boBa8NqJ4EiDsXZBNc2Do0ek9VLJXUgakyEx8+q/WSiFfX9rmwZGDH5im1rEHx85XacTJlBjceFE9mX786iedEKK7tD5W3dilnd12yXoe8zOML9CQDELKpz0YUdDikKCaq/gY8xuwgbGl7t6iCeXofihvEyW8LUcw3Hv4VtNhdyzygU3roKnqXnPStWW3iWSB8c8RLJBnGppK5TRitTlNxdloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7zm8OagMEHwwktbcOYN79QCyUORUNcPonAYhFf6DG0=;
 b=Zia+UpkdW8nzVnkp/rEiHAuq2Ou+k69ZeqePCZWPccrVTgApVe5MU9eMro9enkOA6XLK0RQTsu4jcDYFUfsyqXHjhXZlTpAnIM8H/U5dmltXAyI/esOWeIawfJKjr7n2XL+fuAbQN1oUesE8Krc0+XI1MUnLXk3CvERR2iKkAsw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 07:53:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 07:53:45 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com
References: <20210318072339.28736-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
Date: Thu, 18 Mar 2021 08:53:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210318072339.28736-1-Dennis.Li@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:44e7:a99a:b86c:e453]
X-ClientProxiedBy: AM0PR02CA0217.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:44e7:a99a:b86c:e453]
 (2a02:908:1252:fb60:44e7:a99a:b86c:e453) by
 AM0PR02CA0217.eurprd02.prod.outlook.com (2603:10a6:20b:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 07:53:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc225ed0-d32f-481a-a90f-08d8e9e2f496
X-MS-TrafficTypeDiagnostic: BL0PR12MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4916440F64BA05BFA4383A6483699@BL0PR12MB4916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVCgPdRdiIt7iTdIo7vyFgPfOM3xXprZ7Lg67GTn1eiahSPtkwLsxF2mBdS/3LNAhJveZ6ldZcqGJxIW+Jqj3ueJI1ONhjuhwoPj+cvX561A6mHX95JPWJT9N0qJBT5UgKnaNh1lHB+nt0UsLYRcpVRInYrcSiwIE55tA78B4cZ9JUHVcByvaH1bggr5Z9CvI2wjqdjt02rEkQ0G8IVO+bdLblUk0WNsXFCgU/4RwZB7Pc8rmqaiSNtaMJEyqyAYvC8dDN7AGy79S28mH2noL0IOIc3ESbqUK6KhpiCvf2PaCbA9/yjdkGAGzt3cwfAlWXpLGN2mZFXKpmT6+dP74SoAQ52Pg8XZTRZZrIvh3qYjs4jP0LjBMw8Y2r7d7Sdz/+eQws/TZWpc6UwV/kcbqqZnISNF1Dqu94Wow7vhXSF2clKpDYFCN6koHZmEd1b75f+VAs7RrairwX1YmnQMLfGHst4Prom4LF28mnNf0jGRyU1JJ+O9HVWCjI/BIx8DyR4rfhd2NZe8fCWlf548EQAFLCGafv3ItysW7UKiLUHRmZBMujFkOtmOYwK96W1xOe03jRV/RtIOQV/ocr/MFQguli4d41uTkJuZEumG4jscN1HgIZCpXhF+cxboO9r+PBpo+7Kkds4InLDQgScMEEbvDgggJGdkT9+afkdpJPSZP6ZO1r8uJXTSxvmVEC/n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(52116002)(6666004)(31686004)(186003)(6486002)(8676002)(83380400001)(6636002)(478600001)(316002)(16526019)(8936002)(5660300002)(2616005)(36756003)(66476007)(86362001)(2906002)(31696002)(66556008)(66946007)(38100700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bDJTaTFEZ3dPb2FhTlpZQzRHZGdSUjg2Zm5QVHQ5aUg5OXczRmRlUVlpZytI?=
 =?utf-8?B?MmU0QWhnZzZMalVHdFBHRXFOenR0Y3ZoNzIvNnJBYkpnclByUlQyVlVCVDVI?=
 =?utf-8?B?RVJzaHBaaFBvV21HUVhXMWY2M0I1NWpuYjFNblZEQlNXS1BlTFRhMjU2djEr?=
 =?utf-8?B?Zjh0TTZFS29JUmhNZVdpSzhCQXR4V0dCYll6bkVucytWSm1ldGRFUTdQQXJS?=
 =?utf-8?B?RmJLaEFlRU1LNXhSQlFXM0JPMGp0MnhrWWdCZSt5TUMzcFlRSVByMTYxaUh1?=
 =?utf-8?B?aHJaMmVVUXZCdFFiWE1zQVBQNFN6L3doc0RRSHJtWVNxeTNHd1pNeEw0OVd3?=
 =?utf-8?B?eEJaOCtXam5nK0N4eExMTnZQd3R6VzV3cGx0Uyt4RE9JOEVLQ29hMkc4aXNk?=
 =?utf-8?B?MFE0SEdaUEJJSTh3MjFJK2NYUStsZ2tTM016K2VoaTJOWDlCVHNaRGpud2tk?=
 =?utf-8?B?U3lkaTV2c205dWVIYks3QnN1VmgwcENnbDRSVnk0bTZhbDB5NFR1NTYwcnZ5?=
 =?utf-8?B?M2lyRDY0T0FtdUtQSjRzWW1INURVZWEyOWR1eDd3Tm9aM2ZpNC9uV0xFQVMv?=
 =?utf-8?B?SWV3M1BLVE1xOE8zVFhyOHpQQ1NSNHRMbkRkZHhaZ0JKMUJCL3B3RVg4cGpn?=
 =?utf-8?B?WE03WDd0RlNnM0RvWmIzais3Rzg5alZzclJjTGhMTFhETHE1Z3A0TGdBOXFw?=
 =?utf-8?B?V1VDZnNKNmI1eHczTm5oa0N1dCs3R2xEU09mbWhCMGtLZkUwTTBsZ0FPeUR2?=
 =?utf-8?B?WnpqTSsrWFNjcUtnaVo2RERsT0gxSi9JTFBLaHJUTFp0bFZ6K3plbnY2Mld1?=
 =?utf-8?B?TXlnQWJxRXI3aStPOXdiZTZHTEhYME1XRklhbHN1b2FWelVQYXY4dWNNcE1X?=
 =?utf-8?B?WE1RbkRBRHYzcm1EY1ZaOXE0VzlZa3V0enBiVmdOU1lXQzltc01CMDNRd2Mx?=
 =?utf-8?B?Z2I2eC9lMXY0ZHdGL2dSenBhT1VMcnpkdjZCREhNNnY4MjV6SXhPNnEzRWFy?=
 =?utf-8?B?N24zaW1oc0FVU2tEM2JTQXhiR3BMVzVCQ3lpUFJheVU1TnI1clZGOXJva3dK?=
 =?utf-8?B?NkZVVUo1OVdLQlpCVnFpNUZ2UUtZeDV1SHppN3hvVXlKeGdQeE5mYmQ2ejZs?=
 =?utf-8?B?WjBPOHBYZE9lc3pIMFNXTWM1aWlnOS9ydFJZdCt4YWtvUTVqTlEycHZzaUFo?=
 =?utf-8?B?Tk1CeWV5WlNMektSSEhNSGFXdlZUSHZXN3JWaEVJS1hFUmlUSCtSWjkrTGNN?=
 =?utf-8?B?SmU5L1E0c083aVJMYVRmd05Xb0NrMERHa2hyT0czVjZSVjFSVmhCN0NmdWV4?=
 =?utf-8?B?UXVHUUpwa1hQaFEvVEw5bzVveVpiblJXMUZwOUVnVkpCeU5kdHRLdHlqV0dj?=
 =?utf-8?B?enRqcVFMZlNaK3RraGNrMWtwV3p1cHZyVzBhMmRHaFFHMllGeTRrNEFoNkZJ?=
 =?utf-8?B?a3dJWUZJaEE1VnluRTNlV0UzdzJMem40WWtJRm5RT1pZeGowWUhWYUlvT3NF?=
 =?utf-8?B?bUVZY29pakg5YWFNVEsxV0FpUG9pbmdWYWkvQ0JDSmRrcWhvVWhmTXRLcjhW?=
 =?utf-8?B?ZGY0Tlh1U25wOWpBQm1OYkdaS2hMZ0VOMVFRVmRoV1Njc0dmTnExSUNBWGpK?=
 =?utf-8?B?cVRndFBCOUtVckUvMFpEek5rMHpCUC80bGZSUHV4K3ZsS3R5VHFoZDByTWpZ?=
 =?utf-8?B?eVVpOXBNWVdPcDFWSkdId1VoMHhwK2lxZ2g0Umk2YitWRWV5MmQrTENyUjdV?=
 =?utf-8?B?TmdIcVZxMUF1NjRSQ0hoaXVTSS9MYzUyMkxVeDVRMDdJZlh4ODNxNysrVFpk?=
 =?utf-8?B?K1FHU0x2Rk1jRWVaQUw1Nkg4eEt5ZG9JcXlhdTd0VlN2TzZzUkpCTUE2Q0tB?=
 =?utf-8?Q?wso7YJeD5x9Sp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc225ed0-d32f-481a-a90f-08d8e9e2f496
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:53:45.0279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw45WxGh0BZibBabbXf5Mc0i2yxOqluUgh45rM/FzXqaKUTEd8QFOlHPoP8HQvS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.03.21 um 08:23 schrieb Dennis Li:
> We have defined two variables in_gpu_reset and reset_sem in adev object. The atomic type variable in_gpu_reset is used to avoid recovery thread reenter and make lower functions return more earlier when recovery start, but couldn't block recovery thread when it access hardware. The r/w semaphore reset_sem is used to solve these synchronization issues between recovery thread and other threads.
>
> The original solution locked registers' access in lower functions, which will introduce following issues:
>
> 1) many lower functions are used in both recovery thread and others. Firstly we must harvest these functions, it is easy to miss someones. Secondly these functions need select which lock (read lock or write lock) will be used, according to the thread it is running in. If the thread context isn't considered, the added lock will easily introduce deadlock. Besides that, in most time, developer easily forget to add locks for new functions.
>
> 2) performance drop. More lower functions are more frequently called.
>
> 3) easily introduce false positive lockdep complaint, because write lock has big range in recovery thread, but low level functions will hold read lock may be protected by other locks in other threads.
>
> Therefore the new solution will try to add lock protection for ioctls of kfd. Its goal is that there are no threads except for recovery thread or its children (for xgmi) to access hardware when doing GPU reset and resume. So refine recovery thread as the following:
>
> Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>     1). if failed, it means system had a recovery thread running, current thread exit directly;
>     2). if success, enter recovery thread;
>
> Step 1: cancel all delay works, stop drm schedule, complete all unreceived fences and so on. It try to stop or pause other threads.
>
> Step 2: call down_write(&adev->reset_sem) to hold write lock, which will block recovery thread until other threads release read locks.

Those two steps need to be exchanged or otherwise it is possible that 
new delayed work items etc are started before the lock is taken.

Just to make it clear until this is fixed the whole patch set is a NAK.

Regards,
Christian.

>
> Step 3: normally, there is only recovery threads running to access hardware, it is safe to do gpu reset now.
>
> Step 4: do post gpu reset, such as call all ips' resume functions;
>
> Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads and release write lock. Recovery thread exit normally.
>
> Other threads call the amdgpu_read_lock to synchronize with recovery thread. If it finds that in_gpu_reset is 1, it should release read lock if it has holden one, and then blocks itself to wait for recovery finished event. If thread successfully hold read lock and in_gpu_reset is 0, it continues. It will exit normally or be stopped by recovery thread in step 1.
>
> Dennis Li (4):
>    drm/amdgpu: remove reset lock from low level functions
>    drm/amdgpu: refine the GPU recovery sequence
>    drm/amdgpu: instead of using down/up_read directly
>    drm/amdkfd: add reset lock protection for kfd entry functions
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  14 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 173 +++++++++++++-----
>   .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   8 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   9 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |   5 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |   5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 172 ++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   4 +
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  17 ++
>   12 files changed, 345 insertions(+), 75 deletions(-)
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
