Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA3EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 23:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0506860C40
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 23:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0506860C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955626EC21;
	Mon,  1 Nov 2021 23:28:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F54D6EC1E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 23:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGCsQch8/Ag6TX4OkX8/HcBzzKLj2h5w6VyqaC7SVe79fKha89o9bWRKcjF6GAlRAwhBLDxj29cUzNuSs5XEAQ9wLO+aKYKvr5HXRMJVpm747nVv3IYRbnjfmHGpv2SUV9XtoxmvDNsh6D7Epb6Kbb+bAeJRpOYJjgTVYXA4JueS8+DYl6MXFKVFi+RHYdSyLiNIUBA2XGHWJlWj87mC3zc/3fVHZCge133Q8D728eGoe8Pz371Hztj1mU/iTNgTajlRvqqc1m7V1sv7NCLSJg42fRjf3mAdVlSDm4nhKiaUGrtjh3COBa2R1wIi9stRbzg45QJnGOLJm0nh2Jahbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYclPGJyfS4mUURsNQ5Bf28UW8oCOnPfyDDwDFe+XN0=;
 b=gBDcQSmv4ctPC0RdQ6jIuWQVECB0ZF6m9PqjUAqjQ2d9NsFyg0Ps4kV09oyAjSgO0Nx1Nowdz57V82NqdPrFlQYNuRhzDju6K0qaAj4TujYKXSBgN2UC0KiYXOHgGniqUxGvTQIN1jam/X7TK66a4Gj+fTQSH5GrIHC86R3g13jernJPnwJh/42FJdj3lUrHn+RQaAmH2ql2JORZnc7oibpJiXe5kUwe/Y/qqMdPbU5/2kpfD7pgrE5DYVHS4j3J4Zulc9QCggU+EkQ2E7TFu1+8zTSZNai/khrxwIvZkrf7w2Uh0QjQEycKYsXhtjpCf1VOM10pPcXopFuv6G5xCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYclPGJyfS4mUURsNQ5Bf28UW8oCOnPfyDDwDFe+XN0=;
 b=yyqVoXlSQU8o2mJbQMzQk+Lrv0fLj0ruNVyRti+xxRnhsJDb5Qnaw25fYJDwQ3k4sWgBPueO1NZWeNY9OCO3ZMIxGLAH7yjS+5oTsNh5jTis24NNNS2nZUX6O4DbCYGOYRgfkQtv2UnS/iqPd+JTzRFa5bJAYJU5Q+k2ryAXWZs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 23:28:54 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 23:28:54 +0000
Subject: Re: [PATCH] drm/amdkfd: avoid recursive lock in migrations back to RAM
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211101220435.9757-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <6c0d4b67-6f7a-c9c5-66e9-5a2fcfffa657@amd.com>
Date: Mon, 1 Nov 2021 19:28:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211101220435.9757-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 23:28:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5821f1e9-478e-4dc3-b62f-08d99d8f5e48
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148657911AE412D0BE2140D928A9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJ7tMqVYSwWBxWMlUu2SCrbzq3AjTk4InHrxAMawxHmTWL2QThjm0g0FirOFZxZaZaHdlW8dSUcvwppBZOqmy7V8f3h2Sdo0CWmUipapOOeAr8vPyYrSv3U6tnbio5GWm1IG96Is7XrpYI36CIrpJNnUIv9TYE7WsjDWlUZZvNu/4pOx/pZQxHGJUVN7/zydMp+/ShXjZJIQXthaWk/ItzONLX5Uujc0GjNqLrsJQD0FOX4WwymFECHBQZRy5s1SlVmazmXBp6s5pMY0o6UhLxTZSwzB0Jxs4EmcVmCjSITIydJnRly7v+XKBkTN6W+iYrxd3GdG8smTwA8Oocfq+fzLkGVYaqnfpNlZJ3/3t0+E7yYrFwNd3sOF99ju8CA0SLFQwYcV5/yyVCr0pVia5GYHMK2sDdKaNsD0WM/oEnUWK6FhaOiQ99q9DeawcueUDqOE+AhbXoREsH1+yHqtmax0jWw4nymM2Vziybxd7vyCpPzq5SraXDuj6APZ7QKsWqwHCE9i/KRS4ojD9d2yLg9+6lyqXE8nf9CVFzAhNx7bX4PTVK0s2hw5vaTJV0UuX38/eplWvv/Bsei5cJeCoYjn8BlfaaS216OZuziSPC27xQF+O8z2oYkcDXi47+fCDI3GCpZXBTANFxwmtRgmGLK3c/aVAvRcBCCsdJmx0eUcX99mHN2YJJY1OIout/5wkBUo1KjRGZg80c7kpvqEJBj8JeNG90FX/72MiNMKWYGqclUsxGZsYMG4XabFF7PY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(26005)(36756003)(508600001)(66946007)(31686004)(2906002)(31696002)(2616005)(956004)(83380400001)(5660300002)(316002)(66476007)(16576012)(66556008)(186003)(8676002)(86362001)(6486002)(8936002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEVDV0c4clRyNXJvMDFCdlpWMVdGRzFKa1llOHplN2FtbjFQNWF0M2hVdWxQ?=
 =?utf-8?B?R2NlZjM1TVZRNEZoL0pEWURiUms3ZjNzNjdsY1BPalpRTUdOVWdCdm9xemw0?=
 =?utf-8?B?Y0hKR2tGNFc0N01BQnUvUWdncVJENi96VStYVUNTTHkvelhyQmRzZk9LQnRp?=
 =?utf-8?B?SWNkQmozVnpKRitNVHFNeDNQVVRUSTVWemNxT3pla2dCR2NudDVsMDBsNXlV?=
 =?utf-8?B?STd3Ykg5d1k0MXVGQ0hLb1hrcm5vdERvM3p1cHp3eXVUT05nZTZ3ZXVIdkoz?=
 =?utf-8?B?c1NzQ0xSUEZaYi9RTU10Z0hPWGFTMmxhUENVNEtMblZLRlZuNWJsV1BkVzBY?=
 =?utf-8?B?M3hvNHgwRDJTTHZTaVhOck5XV2JwRy9ucS9uVVBYdm9jLzRwUjNDeGI1bWZq?=
 =?utf-8?B?c3VRdnE2ZWlWRENPLzZiS0VTdFhzdVRVSWJsUFF6OE12K2VQV2lSd3JmY2FE?=
 =?utf-8?B?UnVsNnZJb2V5RjdFMDlHUFMyVy9icSs0USt2eUNlWXcyUlp3Y3RsWEVrc2Rk?=
 =?utf-8?B?bXBGR2xNRk5kbmNWZEQ2UkJVcEtKTytidDZPZ3B3endWT3E0MjZwOENsNW9Z?=
 =?utf-8?B?ajg3b3dsR291Vy9yVGk1UUJySEF5UTk4a2w5QW9SRWNMOGg4RkNzMzRxNjcx?=
 =?utf-8?B?UGdNaURBK3h0QVdabDJpaFB1MFRDSGthaVo2ZGEyUTd2aXhldldOa3JOM050?=
 =?utf-8?B?UERnNmJ3K2dvUlNkYlNyMXJoK2xUN0g2Zm9CWHdQZndOWVNZOXhWeTRXMEY2?=
 =?utf-8?B?cjdvMlJyRE9tV0tFd3o3K3F6K0pXMW9DTG9MZUlrSkllYVdtS0NsbmpOV3NG?=
 =?utf-8?B?Q2JvNkFmRnJTN0VWN0Fzc0xPUEp0WE43Q1BkZGc4VGV3VGc4Y0VRemc0ekhm?=
 =?utf-8?B?TlRDem5Cck5QcXFaT0djYTB6UGFrM0NjaUVJQTlRQTBpNjZwN0pEdUMzeFNw?=
 =?utf-8?B?NEtZWEp0OTRFdW9Kd2ZHRzVxYUVjRlBFSCt5T0ZvcytpakMwaTJPVEJnS1Ar?=
 =?utf-8?B?SVlKUDVKVllBM1BaRjRsM0tjMmdjak1UcWtvRkVOUDI2WC9aS3o1REk3b2Qx?=
 =?utf-8?B?YzVtVmlsVFhyZENIMDU1T01QQmVhTFpUNVB1RGxjSWRncGlpaFJ1N3pjZjR1?=
 =?utf-8?B?SWxsdkVmUmI5WnMwbUFsalArRWthd3dTUWJNam12SlZDRE9xWVQ4MFlhTXpW?=
 =?utf-8?B?RlNxSkh3dVVaNjIwbzZLS1dGU3M4MzRza3BXVGZpNGFnU0tFMkFtcm9UU0ZI?=
 =?utf-8?B?UUdneFdOR1JzVFRjek1jZXFzWnIwcWlnQVB6WlU1a3hIbklMQXRoa0V6cDRV?=
 =?utf-8?B?bGtTbHJtTmRhTTBGUW5SbEMvYlVVVnRaZStWSHU3UW5IVXdpZXZyOUVteHhK?=
 =?utf-8?B?Y3U1ZHRlQXZ4ZExvZVZYdWdtTEsvaGlVSnc1SFVBUG1CbzNyRzZZeERIVkFw?=
 =?utf-8?B?Y0RJQXZHeDgyQlFJbDNTUnlqUW4zMjFMOGpRTmxJRnZIK2Z6M2QwOVcrYld4?=
 =?utf-8?B?ZVJKL1BESXZrVTRPbjI4T3RFUzgzQjB3ZVdTanY0VzI3MnFRWm5mUWlYSE1E?=
 =?utf-8?B?OWpSa1AwWElFOGthbEFvYVdKWCtNNDNMcVJFUHRzMHBYUkFYRlJIcnFldG9u?=
 =?utf-8?B?Vm0zUXhnRlFoOUtzck1BMzN2MGM4OGFlUG5YRFk3Q0NsQXByZGI5MmoyWTlE?=
 =?utf-8?B?R211eVQ0eEpKeHF3VFlGM1VpZHYyMGRhcUx1VDJxa2pnOUhXOXRycDQzcEhx?=
 =?utf-8?B?ZXIvbHdUNFNhSjJ3MjV5cmQ5ajVHazErR0tlL29GSDVuY082dXJ4cVFUMWo3?=
 =?utf-8?B?SWlXVU9TMm5CKzczcnpFVnRrTFQ3UWlwMDlpS2N1QXFHbGY2emN6OVZFUm1R?=
 =?utf-8?B?OU9uS1lRZWs4cFIxK1A1VWhFYzdqYTNpRU40d2tRSUJ6LzNCd0FUOG1WUUVj?=
 =?utf-8?B?ZmZWL2tnQTZGUFhBcGNuZGhEdkpwZ2VwZ0FLVWU0aWRDeFIwVE5ybnlWL0hi?=
 =?utf-8?B?VW85em9wUHNJU2lqRnlOcnFzWHdERkJnYjY4Q3ZHcWRvRExSa2FTSDUwV0JT?=
 =?utf-8?B?OTh1MFZrNnVqUTB5M05FMHJCWHdqcnBKbzRaOU9sR2IzWWljNGw1aUFJd1A5?=
 =?utf-8?B?YTVrVUd0bXJJbWhLR1pDV1h0enpkcXZ4QktKTnJ6bTNJdUxzQmhabThxUUNy?=
 =?utf-8?Q?3KH7tT4KF3YDdCT7N/5u6Qw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5821f1e9-478e-4dc3-b62f-08d99d8f5e48
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 23:28:53.9092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUcyTKBjaZoTVqqDCwMyzoWRWCpr4HoojTaHUxDEY7SGKOnewsQAXbRvuHQbWqB3dnw/U9a7wysgpY2eG6zbbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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

Am 2021-11-01 um 6:04 p.m. schrieb Alex Sierra:
> [Why]:
> During hmm_range_fault validation calls on VRAM migrations,

This sounds a bit confusing. I think the hmm_range_fault is not called
from a migration, but right after a migration, in the context of a GPU
page fault handler. I would explain this problem in a bit more detail:

When we call hmm_range_fault to map memory after a migration, we don't
expect memory to be migrated again as a result of hmm_range_fault. The
driver ensures that all memory is in GPU-accessible locations so that no
migration should be needed. However, there is one corner case where
hmm_range_fault can unexpectedly cause a migration from DEVICE_PRIVATE
back to system memory due to a write-fault when a system memory page in
the same range was mapped read-only (e.g. COW). Ranges with individual
pages in different locations are usually the result of failed page
migrations (e.g. page lock contention). The unexpected migration back to
system memory causes a deadlock from recursive locking in our driver.


>  there could
> be cases where some pages within the range could be marked as Read Only
> (COW) triggering a migration back to RAM. In this case, the migration to
> RAM will try to grab mutexes that have been held already before the
> hmm_range_fault call. Causing a recursive lock.
>
> [How]:
> Creating a task reference new member under prange struct. 

The task reference is not in the prange struct. It's in the
svm_range_list struct, which is a per-process structure.

One more nit-pick below.


> And setting
> this with "current" reference, right before the hmm_range_fault is
> called. This member is checked against "current" reference at
> svm_migrate_to_ram callback function. If equal, the migration will be
> ignored.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 3 +++
>  3 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index bff40e8bca67..eb19f44ec86d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -936,6 +936,10 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>  		pr_debug("failed find process at fault address 0x%lx\n", addr);
>  		return VM_FAULT_SIGBUS;
>  	}
> +	if (READ_ONCE(p->svms.faulting_task) == current) {
> +		pr_debug("skipping ram migration\n");
> +		return 0;
> +	}
>  	addr >>= PAGE_SHIFT;
>  	pr_debug("CPU page fault svms 0x%p address 0x%lx\n", &p->svms, addr);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f88666bdf57c..7b41a58b1ade 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -858,6 +858,7 @@ struct svm_range_list {
>  	atomic_t			evicted_ranges;
>  	struct delayed_work		restore_work;
>  	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
> +	struct task_struct 		*faulting_task;
>  };
>  
>  /* Process data */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 939c863315ba..e9eeee2e571c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1492,9 +1492,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  
>  		next = min(vma->vm_end, end);
>  		npages = (next - addr) >> PAGE_SHIFT;
> +		WRITE_ONCE(p->svms.faulting_task, current);
>  		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
>  					       addr, npages, &hmm_range,
>  					       readonly, true, owner);
> +		WRITE_ONCE(p->svms.faulting_task, NULL);
>  		if (r) {
>  			pr_debug("failed %d to get svm range pages\n", r);
>  			goto unreserve_out;
> @@ -2745,6 +2747,7 @@ int svm_range_list_init(struct kfd_process *p)
>  	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
>  	INIT_LIST_HEAD(&svms->deferred_range_list);
>  	spin_lock_init(&svms->deferred_list_lock);
> +	svms->faulting_task = NULL;

This initialization is redundant because the entire kfd_process
structure containing svms is 0-initialized when it's allocated with kzalloc.

Regards,
  Felix


>  
>  	for (i = 0; i < p->n_pdds; i++)
>  		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev))
