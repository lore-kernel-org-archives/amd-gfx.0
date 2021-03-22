Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899F3C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 15:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2349F619B0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 15:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2349F619B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A97E589DA9;
	Mon, 22 Mar 2021 15:01:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E6D89DA9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 15:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyRzyLbsaCx4whB7+2hu+eZsn7o2lCa8kBGcDoODWq48+I6aNquFn3Rwqw39vQ0xMOjfbM8ySfiB/vvk3a+c/ldKgBZ3eVCXn5ogFUank+WJRZeNcPKA7I47OBNr0CYJ7mm2MxIeolZ8G6LdPtvBVFglehhn+/Ox6T95cJEsqLxu7fOd2j4MZPX3otVmaNTPwzpy7uo70DYefYXeG7nH8jK9ILK6sAiZ/P+EuJY70eeRJ9Pgg/lfxodbYELsIkne3h9VAhPDaDO4q603CCbkn6gQDLQO6l/h9iF/zvAHNgwW0O3ygbsy2uzLw9U+FEAuo+3MnTvGIP/wnkLOiWLY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaUdS6hN24fQXHLoNA5N1ttbZVUMYT0pqTSS7+NjqSk=;
 b=f/DpGF08y39nf+yYH4m18ErIUce5FspbrR4+iOEzkH50a7tg5Pz4v6A7ydIR66SL3iSFbttL4a/InNW+byP77QWi2R89aRVPR7GPgV5VLQWEA2CO1yoIT0ZV1RNEAMMkCDW6SX2tTFxHuzGHkzVSj1kpyx3LSZlt+ET3heQcvvwEPqYPya+Iol9wCQyuL3FR8bmn0/RIimyTgOduk5qc7WVTnEDJRH3YXtHxgD/SXf3fUJwvtLyzVO/x3BI8dmPkU46vDQNXMqk5sSkXQ+8UdKpg/VRA0jO1T7gAuUdKJkADLBnhU169n8KE+m/dxXP4ESflEA30oW/NAhuSDshr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaUdS6hN24fQXHLoNA5N1ttbZVUMYT0pqTSS7+NjqSk=;
 b=XlsYPO4L8Czqulg//FqI8q1+FmMPpklSCKSpD/b9xoI9Ex4UfjCqG89+wh778Qqm+Y4p96HWxRbU9QhOj4OPGq7PJ3leJWsD/ZQtE/3RLu+KJeib+u1ok4Dcmoxs9FO0MjGYJRDjAOYUm4iSlGezHJEjSOkLVj7rOiTgwUSOeYY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 15:01:22 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 15:01:22 +0000
Subject: Re: [PATCH] drm/amd/dispaly: fix deadlock issue in amdgpu reset
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210322081138.3484804-1-Lang.Yu@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <3f417799-f923-7709-ddd3-823ec89126f9@amd.com>
Date: Mon, 22 Mar 2021 11:01:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210322081138.3484804-1-Lang.Yu@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:c00d:fba0:2b1c:d0ef]
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c00d:fba0:2b1c:d0ef]
 (2607:fea8:3edf:49b0:c00d:fba0:2b1c:d0ef) by
 YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Mon, 22 Mar 2021 15:01:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0df80dcb-b769-4949-9545-08d8ed435b17
X-MS-TrafficTypeDiagnostic: SN1PR12MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2480F3B6DCF807EAC8534663EA659@SN1PR12MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qw4y+n09t6CbSDShj1Qf8bSk1cs+07qgxRXOppQR5uyFp/wh2UZ9TAGbBJrAbNTVRSMc7czEzjB9B18QrDFPSweOuO3Dlu9dTxd8qW3XwbpLWAVUmAR1tHhFUV77XvpXANtXb9m18hIpsng8IPeMOZhewUatn3uTETMZ7iMDvMcx/9gEFppuwhaE0l7X6cXbPkfDp6hRQU02IoGQpp46cONby58KfCp7Aulfb1GjILhUskjc4GQpdljNhOj7WrAmap+WrO2war9YX9ojnA/V6zR2KvYi7hct6O227ULlHYcOL3DWyyXeKYIrdZalR4CCrONJCmW71No3ocAF45NTpCsEdwtw3AO/fH4mTr6uEz/dafrsg001jkQ97Hx7hPd83JPMrwXidDtHf/MGjDoLc8RlrlccaMopAPkYvvHlMRhT5HSW3Dm9U0Dc9DRl00dGA44uj9rBXM8DDZp7pWobBNuiT9zwkqKUmXi2ZytJOV+FujZLcWe/iKkhq5xGQU1nXVcBR/+61WAJzW/RlYslFunMkCkAuZJnVjLDikVMfQjVfO8HUSzdZxM/KEf8A3sqmCmz+/6fm6qqNpR6RTLc/60j3SfzJV4v5iokvDGLlf8IAy08lkjUztfDZ/GhLB4xMWD9lkdQcY0iLgg/pThaAN6KwKpbOsm4AqwK8PqKhIKBtH/4nIPOYc9hBuMrt1dyxKlcMeqviAtgZvIEfHDMmFBRAql2PVYcbGAJddhVAkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(8676002)(31696002)(2906002)(53546011)(478600001)(4326008)(16526019)(186003)(8936002)(66946007)(83380400001)(66556008)(44832011)(2616005)(54906003)(66476007)(31686004)(86362001)(38100700001)(36756003)(6486002)(316002)(5660300002)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bFFWY0xOMEpPakJhS3o1eWszVUR6QXRLT244R1poVjZEalR0cERRWUFxaXMz?=
 =?utf-8?B?UUlvd1Q3OU5SdDhZTElmSWxsTHptOUNDVU1BUTZudlJpYlMxaUxtbmRBd2M1?=
 =?utf-8?B?YXNjbGdFNG1xdVJqUS9TWU5uaWYvNjNhRyszOVBKTFg0MWZnQmFQVXVDUzlP?=
 =?utf-8?B?bUl0RGtyR3ZPRHlOZHVUSWZ5dy9mdENtRFBLQzJ2dW1yYW5tbzA0T25NcGVp?=
 =?utf-8?B?enRQckRFRDZrYjdUTFZRUU82TW5waG1ZRGw2Wm1kL2pTZndVK3FJMkF6dTJH?=
 =?utf-8?B?aUdCMUh4dXBIbk5xYzYyZjNDUnhXa1dubEVvRlI3ZFpPckxkdEljSUpjTnNS?=
 =?utf-8?B?TGNBejh4SVFNcVZYRDdHdE9aL3pZSE1YY0NlQnBaa21ER1hXSHRqdHJnbXF6?=
 =?utf-8?B?am5wS1ZJZWpXQktmaWxBbHJVREY1UGZhYlN5dVQ3WVhHYStWcW5raVNSQ0Zv?=
 =?utf-8?B?QkVRdm1SdWw2OExQSmoyL2Z3TE1yVUZNMGdHaFFkZkwwWGpDdWlOQlpPeTBC?=
 =?utf-8?B?RkFGdDRQN3NXRTdOMjYybHB2NWNBVmZJcmd0WVlGQkdaVWxDMytkZEZ6aXZa?=
 =?utf-8?B?YjlNN0Q0ejNESGQ4bDlkNEFPeGMra0JHY3V4RFV6ck5tcWd1MFBvTkx1MUpz?=
 =?utf-8?B?MkM1UXNkcFhBL0J2R0hSVjZQZkc5cjdFOWthOHlSelZvM2FVbVBnVE5zS203?=
 =?utf-8?B?eHRWdm1pOEVJRi9sVzF5UGZCbUo0b2lxK05mRkNsaC9EbXBMbXhMak1lZUdO?=
 =?utf-8?B?bEJsMnNmMG5IUEtZTGlUdHJzUHB5RVhnTEZtL0VGQXI3Y1FYUEZzSFp5cWl6?=
 =?utf-8?B?aVZnTTNNYngyWlE4S0QyLzJSSWxpdTM5QmRyWC90WVpYM0dYaHdpcmxjekJy?=
 =?utf-8?B?VlFUZTZkRzM3Nzd3dW1XYStPYWZONlRqVzlCY0VBY0V1dGdPUEhYQkY4Zjhs?=
 =?utf-8?B?L2Q1VTRPc3Q3NFdkRDlJV3c3MmhrVGhPMXZVVzlCNHdrWENETHJtMWhuWGFW?=
 =?utf-8?B?KzRHY1IySWlZWVFUSTJIbFp6SGRVbUltbGpJYWp6YUpRWkNET1lnZjByK2d1?=
 =?utf-8?B?Y25oSC84emdaZ3FlNEQzbVlQZ1ZobEYvNGpoTFV1TDRDRDVsREUvSEVOVUsy?=
 =?utf-8?B?ZUd3b0wyQ2JJeUJtYVEvT2tLNnZ2SDVsMHEzZmZVd2lrMyt3UGlQVVRxUDg1?=
 =?utf-8?B?RjVwRTV4Ukw5MlhvbGFtWVpPV0ZsMnFHQnMybEQyVVdmWnhsWTVGaTgvT0Fp?=
 =?utf-8?B?djBuN2tCcHYwWVM1MGplSi81V3h6RER4T3gwazQ2KzNidUV5eEFMWDd0QWNq?=
 =?utf-8?B?d0xtdVE1eTFLTW5Kei8yS1NwQisySnpMMFVlVVlxZ1JiTEpYaG5KelpqS2lv?=
 =?utf-8?B?bnlESUt3TjQ2Tm5tLzc2T1VDWW1YVm90NjlLRTQ4c3VwaWFFYVhOU0RoQ2Rk?=
 =?utf-8?B?RDd5cGNpVlBJODY3cExzdHVpWXlmK1BGeS83aXprS09RejdkU1JUaGRYbHQ2?=
 =?utf-8?B?T2hvN0dHR1lRcE5vQkppaTZiWnRwTkUxYjE5VWJUU1dMU0JKWVpIVmRYSGI4?=
 =?utf-8?B?QjBURENXTnJRRS84Mk9TZGdBdHRMTW9HOTNGT3lyS1ljSXNtMU1jM3QrUFpx?=
 =?utf-8?B?ZzBMMDI5Wkp4ZTFUMk1nWkZoUnkzRDMxNGZRV3dlSzI5SGJoYkdqYmJtckh2?=
 =?utf-8?B?b0dXaktwWTBkbDNmcjNQcDV1bkFZZW5CcmNZTFhaWXhpOFM4T3BFVnRCZ1M1?=
 =?utf-8?B?SnI5OUlRYTR3QnZQS1hSbWZ0NE9XN1Nhdi85Y3dFTDJJSDJKQUdSUVVPVVJM?=
 =?utf-8?B?Rjd6Z0Naa3ljT0gvZUVEU3RDNW43YVYraDE3RGczNlR0MkUwSVIvRlNXc3p5?=
 =?utf-8?Q?mFrNWgGwir7o4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df80dcb-b769-4949-9545-08d8ed435b17
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 15:01:22.0898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqol9DD+TLjtkMJrFlN+Lw6jmbHCxr4BakiaR6yBSUZYwrZvO/jVttj6hg8gzK05qj0BdC8Ul6naSe7H79qI4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-03-22 4:11 a.m., Lang Yu wrote:
> In amdggpu reset, while dm.dc_lock is held by dm_suspend,
> handle_hpd_rx_irq tries to acquire it. Deadlock occurred!
> 
> Deadlock log:
> 
> [  104.528304] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
> 
> [  104.640084] ======================================================
> [  104.640092] WARNING: possible circular locking dependency detected
> [  104.640099] 5.11.0-custom #1 Tainted: G        W   E
> [  104.640107] ------------------------------------------------------
> [  104.640114] cat/1158 is trying to acquire lock:
> [  104.640120] ffff88810a09ce00 ((work_completion)(&lh->work)){+.+.}-{0:0}, at: __flush_work+0x2e3/0x450
> [  104.640144]
>                 but task is already holding lock:
> [  104.640151] ffff88810a09cc70 (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb2/0x1d0 [amdgpu]
> [  104.640581]
>                 which lock already depends on the new lock.
> 
> [  104.640590]
>                 the existing dependency chain (in reverse order) is:
> [  104.640598]
>                 -> #2 (&adev->dm.dc_lock){+.+.}-{3:3}:
> [  104.640611]        lock_acquire+0xca/0x390
> [  104.640623]        __mutex_lock+0x9b/0x930
> [  104.640633]        mutex_lock_nested+0x1b/0x20
> [  104.640640]        handle_hpd_rx_irq+0x9b/0x1c0 [amdgpu]
> [  104.640959]        dm_irq_work_func+0x4e/0x60 [amdgpu]
> [  104.641264]        process_one_work+0x2a7/0x5b0
> [  104.641275]        worker_thread+0x4a/0x3d0
> [  104.641283]        kthread+0x125/0x160
> [  104.641290]        ret_from_fork+0x22/0x30
> [  104.641300]
>                 -> #1 (&aconnector->hpd_lock){+.+.}-{3:3}:
> [  104.641312]        lock_acquire+0xca/0x390
> [  104.641321]        __mutex_lock+0x9b/0x930
> [  104.641328]        mutex_lock_nested+0x1b/0x20
> [  104.641336]        handle_hpd_rx_irq+0x67/0x1c0 [amdgpu]
> [  104.641635]        dm_irq_work_func+0x4e/0x60 [amdgpu]
> [  104.641931]        process_one_work+0x2a7/0x5b0
> [  104.641940]        worker_thread+0x4a/0x3d0
> [  104.641948]        kthread+0x125/0x160
> [  104.641954]        ret_from_fork+0x22/0x30
> [  104.641963]
>                 -> #0 ((work_completion)(&lh->work)){+.+.}-{0:0}:
> [  104.641975]        check_prev_add+0x94/0xbf0
> [  104.641983]        __lock_acquire+0x130d/0x1ce0
> [  104.641992]        lock_acquire+0xca/0x390
> [  104.642000]        __flush_work+0x303/0x450
> [  104.642008]        flush_work+0x10/0x20
> [  104.642016]        amdgpu_dm_irq_suspend+0x93/0x100 [amdgpu]
> [  104.642312]        dm_suspend+0x181/0x1d0 [amdgpu]
> [  104.642605]        amdgpu_device_ip_suspend_phase1+0x8a/0x100 [amdgpu]
> [  104.642835]        amdgpu_device_ip_suspend+0x21/0x70 [amdgpu]
> [  104.643066]        amdgpu_device_pre_asic_reset+0x1bd/0x1d2 [amdgpu]
> [  104.643403]        amdgpu_device_gpu_recover.cold+0x5df/0xa9d [amdgpu]
> [  104.643715]        gpu_recover_get+0x2e/0x60 [amdgpu]
> [  104.643951]        simple_attr_read+0x6d/0x110
> [  104.643960]        debugfs_attr_read+0x49/0x70
> [  104.643970]        full_proxy_read+0x5f/0x90
> [  104.643979]        vfs_read+0xa3/0x190
> [  104.643986]        ksys_read+0x70/0xf0
> [  104.643992]        __x64_sys_read+0x1a/0x20
> [  104.643999]        do_syscall_64+0x38/0x90
> [  104.644007]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  104.644017]
>                 other info that might help us debug this:
> 
> [  104.644026] Chain exists of:
>                   (work_completion)(&lh->work) --> &aconnector->hpd_lock --> &adev->dm.dc_lock
> 
> [  104.644043]  Possible unsafe locking scenario:
> 
> [  104.644049]        CPU0                    CPU1
> [  104.644055]        ----                    ----
> [  104.644060]   lock(&adev->dm.dc_lock);
> [  104.644066]                                lock(&aconnector->hpd_lock);
> [  104.644075]                                lock(&adev->dm.dc_lock);
> [  104.644083]   lock((work_completion)(&lh->work));
> [  104.644090]
>                  *** DEADLOCK ***
> 
> [  104.644096] 3 locks held by cat/1158:
> [  104.644103]  #0: ffff88810d0e4eb8 (&attr->mutex){+.+.}-{3:3}, at: simple_attr_read+0x4e/0x110
> [  104.644119]  #1: ffff88810a0a1600 (&adev->reset_sem){++++}-{3:3}, at: amdgpu_device_lock_adev+0x42/0x94 [amdgpu]
> [  104.644489]  #2: ffff88810a09cc70 (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb2/0x1d0 [amdgpu]
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e176ea84d75b..8727488df769 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2657,13 +2657,15 @@ static void handle_hpd_rx_irq(void *param)
>   		}
>   	}
>   
> -	mutex_lock(&adev->dm.dc_lock);
> +	if (!amdgpu_in_reset(adev))
> +		mutex_lock(&adev->dm.dc_lock);
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>   	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
>   #else
>   	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
>   #endif
> -	mutex_unlock(&adev->dm.dc_lock);
> +	if (!amdgpu_in_reset(adev))
> +		mutex_unlock(&adev->dm.dc_lock);

Why is it ok to stop locking if in GPU reset ?

Andrey

>   
>   out:
>   	if (result && !is_mst_root_connector) {
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
