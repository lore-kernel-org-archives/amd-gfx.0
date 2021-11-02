Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C442C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 14:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DAE60EE3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 14:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66DAE60EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102B26E984;
	Tue,  2 Nov 2021 14:18:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBEAB6E984
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 14:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvMyX3jMYxHa6+kLi7Jp/L4ROW3uSunaRyGu/HJtp44z7dFcMGPYr7JnmIfTDMnSjOE6GdSqEQojTlTbWebKK/l9060zw4w+LGH0qCn+AOITdiewgOehr3e/8mERzhTD77RiXcdEpusJy0xvEKRD64oSjTIJq1zpFJl2XfX52RwJfT0+mjTLJfUCvxSJBpm3fCUlQbP4de0qDH55v/q3TRP1eYi3yQFxqrsvIXyjQhjyaxl5Kf6qXeFv7Ht4HwT7oZ4vxsMsSELLvZ7JjLrbF26ICH6XJyDn4OSLmfVFl8LQjEH2ErC1aqPROyR5q78vKCDMlGxkvpJy9EqGUFthqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFoakFlgA7kJCiAFzRoE9M+5SLoKqM6HkMJDKlip18s=;
 b=DQ54W7YN+z3kKZlDrOuJdK69sqnh0IgKdmsWu3uOBj4Y7tKiluEFmTjY6QJt5UAjpCdX75b+nHHA9PL8xX0R1VcsLa76RGIQrRAThY083T05ir5HXVTtwDMAR8TiJfOOIZiH+Qfia/ajYIzYi0nHjlA/myusS30qZ1THrJYxMnt+GOT5vkhUfb70933wdsRJzNbQEgatb835q7pzwSNGAt9MoywsoYlg2zKUvuylIVO+yfPJmahzo/dL05IoUdLaPGXP464yTStHeqVXRCctX2wp5E9WoY2WhaanHnAgbb1tvqf0pn9YZFo26xv+aeIKUpGaDLOm44jqcY8xQI58NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFoakFlgA7kJCiAFzRoE9M+5SLoKqM6HkMJDKlip18s=;
 b=zfAWXqFkgdU2beutXZuZRE+q2WJbZXIU0jN/uJ/rLbods2dbulI7jNJj0UeUvM0bDbhBMIdqfvlpB4msPd4NSg03g5JISY5yXArrKexjOhKCe176n6xq6eutwliYrypLtZeuCoisLDN5Rv0fhtqU7nIZIXTfuu4UYk9fnj4ZBDQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 14:18:52 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4669.010; Tue, 2 Nov 2021
 14:18:52 +0000
Subject: Re: [PATCH] drm/amdkfd: avoid recursive lock in migrations back to RAM
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211102024040.11666-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ab3cc40c-7763-b41b-8a5e-24c535d287eb@amd.com>
Date: Tue, 2 Nov 2021 10:18:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211102024040.11666-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 2 Nov 2021 14:18:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23057909-9f3c-48ff-941a-08d99e0bb222
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4451B142AD61241CBD287EA7928B9@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbrEgychXKrVVshwpRTb3m7/Y/Y+kVliD3FfbqAw8VbrRcKs7m9sNWr7ds7Icjo/K+1W6XVvD9BZ4cupjRdNcviV3QR1xbiVgQPd4pBgCrFhxggIqMwLdZXUd3y/7rga0BeHPHNTCjGLr84lz0Aay1buDoLZWzfySoNGeRyoYm4CMrKykAorehic55VIDKSTn1PyRUubfbmyPYgHZSsT6F0udR4/GS4yNPnsuSeBjKsjn3z5LvYypb/eb7qDVN8SfekTR/CRPHqXrWnmSFwNz9Ql8TeuFLoA6sLPccHMdX03T8HMDKZsGzWKwOoLi2ldZNLRIYJrV/XkXCAM8fpo1hKLD+Fc/97VeNH+QRdET8y2wrQXZ/ESH1CBeqpKluZK2GjLyFbdCL78V2hj8NPrOYaXRdv/+cb43WYi4sKkebjAQX35RargwMOwFWm+4NnnFEGywfj7HKL9a2vI7jtMJeYvYrqeeg73pR39DNBK5m3YSa5hqnbmw8UkvbK8PXIl8b/P63SQUqfg1E1J3gZP+VSRW5vTZcFA5Inc5Eh6cZYCR6HB+vjf/nv5SSk/A8xASNY5XOvdvuHsn5LW5Qe4QxqC9l1+nXg5ZJQ/nGcBBk4W35CDydf9C0Nyvkr0SPQ81uAIAoMLHu9Vse6kBj9QAivIMGJsfZCGlGkeaVSKv5aG0ZnhOr5DuUg8kviGtDZMXNRzEixvy5Gy/3JoN4Moeje+qpdAnZUbb/jjE4rboPgmf1/x2uL5c4k/hbMw/hC/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(66946007)(31696002)(66476007)(16576012)(38100700002)(6486002)(31686004)(66556008)(86362001)(8676002)(508600001)(5660300002)(26005)(316002)(2906002)(8936002)(36756003)(956004)(186003)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JyQ3o0eSsvbkk3NmVaVmtOUkV0eVF2N1BYSFQwbWtFcUN2RWlvRHNqTk80?=
 =?utf-8?B?MnV2QzR5ZmZBZTI4ZE1kUU9na29YT2QwbWtheGdtMmdpc25Ld2IrVE9nVXh5?=
 =?utf-8?B?UXhuS1JMd2hkTmY4TG1rUXdZN1pNaVp4cGpneVc2K1l5bTUzQnFiM1Fic1lN?=
 =?utf-8?B?ZEVsNzFvUjBuVC9WeWQzSUwyL3YxRzgyeXUrMmZ6aE4vbE02RjRsc2J6aXJh?=
 =?utf-8?B?Nmd0SVM0cDBjT2JyVnZ2clcyN1JhUmFJZ0xBOVltRG9XSU1kR0VYMDNUNmwy?=
 =?utf-8?B?UDA3OC9ZNUVNWmJSQ2RXcTl5aGJLbjdKTnBZbFBVclpWcXlsaU5DU21YUFBT?=
 =?utf-8?B?NnJFVlJvMWVna0hTL2ZPcUNqdE92RjN6emJZZXA2KzZ0YUVDZkVQRHJ2M3hH?=
 =?utf-8?B?UHkzR0JwR2RuN1ZadUY1QzlLbjZNYkZQN0tsVVNPMFl1SlczOWw0RVVtUEND?=
 =?utf-8?B?Yk1EenBNSU9KVjloMDlJVndzbkY1enE2UGN0eStLZE9tU1k0ZWNsN2ZrSW1k?=
 =?utf-8?B?azBycVFnQ1N6U2dremtGMUxhUGJyUXpDZ3k1UTJvTzREOUorK3BSU2h5L2du?=
 =?utf-8?B?L2puNWIxVTFYRlRaV1lpQ29aaEkxVVlGVHVhSWlac3kxZGtrUzZwbDRsVkV0?=
 =?utf-8?B?dGplS0MrRjNSL3JGbGxWTXN0cWExWk5MZ1ovNDEzUVBnWlhMR1F6SFZHVU9n?=
 =?utf-8?B?ei9iM09BSnBJN0Yzb2hiZzBpQk1iQXd2OWoxVzFldU5NY0RzSWUvamZCQ1VG?=
 =?utf-8?B?czZRVGNPbm1leVVqcXREQkw5cXUrUGRUemhIcERxblZ4alE0S0djc0tuYmNx?=
 =?utf-8?B?a0I5ZHRtSjI1WXNrYWQ4RWltTG9xL0xPRHFtWmp2MUVocTBNSnpnZ1BxaDdU?=
 =?utf-8?B?M2Z4TXFVOUNpTENKSnNTdnkxVWljTUZ6czlsMUU2Vk1NRkpQTkZUR1AyZmZR?=
 =?utf-8?B?TkpJOFFDSVFWT0JrcXBnRW1YMzNSbFFQYnF4WjJRZVRyV2kzTlRHN2xYdits?=
 =?utf-8?B?N2daZW50aHRacksxZ25nUXljUTdRVU14dVFvNGlRNHRQbVV4WmRIaWNzMGVu?=
 =?utf-8?B?VG14RGhpcWtpMG5zNXVOOW9hN0M4Um9BM1FKRXpIVEQ4Y0ZtblVYeUNOZzln?=
 =?utf-8?B?Zi83RHhUZUc5RFMyb2ZyQ1d5SG5tNlM4MGZJVlVFMm1RcDYrSTJlNWdvcC8w?=
 =?utf-8?B?NWYzNElkcTVZZXl1RVl4VXJqbGp5OXgrTVVUU2oxSDNxYjhOajNWcVNBWFdv?=
 =?utf-8?B?NHVpTWRhYUJybGVNUWpCYzlweitzUENTa3dOTSt3U29VR2xjcTJVNGFab3Bl?=
 =?utf-8?B?VVh6NE0yWEQ3WnViUUVOd0JzWUllRmJsSFpsTU83ajloR1pvZ0l2enBGaGhF?=
 =?utf-8?B?T0dwanMvQ0U2ZStGcGU1TW5kOUplSHJEcmZqVHI4dWpVakJMOVZiTmp0ZGEr?=
 =?utf-8?B?ZlZCOWpSaUxDKzdaNHZLYlFldEErUjNXRjM0TkZ4ZnY4RDMwSjA5djFyMDRk?=
 =?utf-8?B?Y1BQZXRteklRUmIxTXJIenk1MXpkYlpKRXhxQUYvdEM5bSt6RC9MbVJuQ1lx?=
 =?utf-8?B?NVIyR3FxTXgrRStUb2RFNFdZMGNZSmFVUitYQndzeC9xclAzd1ZZUWtoemlu?=
 =?utf-8?B?Mm9WS1dLY3gwcUlxSmt0alJEakZvaTZEeExRNUJieGdhbTFRdml2YVdqLzhl?=
 =?utf-8?B?c3c2MTl5REFKQk5jcG5BMlVHbER3Z1RqNVN1Z3ppaEp2MGhOU2RNaENUUWRr?=
 =?utf-8?B?TDlIYVhGUXNFMVJXZnhSZ2U5Tmc3TjUrUzYzcW5JdnlFbGZ0djNKbjVuWm5E?=
 =?utf-8?B?WGFYaGZvM3d6Z09XK3hmSU9jak14RlNvUWdaYkVwcFdaam44UGtwb2Nla0R5?=
 =?utf-8?B?TWdoZlZWd243MXpXVi8zV1d0RTB5VTFnVzczbXhUNkpkZWFobkx5eXArZThQ?=
 =?utf-8?B?ZVRTczhrakpLazcrb09DcHRZUjFpNHFiRE1xeTN5ZkhWdXdZWlpFY3B0NDha?=
 =?utf-8?B?UHlVRWNBSTBXKzh2Y0lMbkN6KzdBa0d4Q3BlYk82aTd6dmpmcStTV0phdEZs?=
 =?utf-8?B?c1MvNEt6YjB4dEg1c0llQ2M2dnBaNW42SXhic2lSbjZXdVN6OWV6Ynd0SUFk?=
 =?utf-8?B?UVcrSElEZndPaDlSNmNXTDBUTE1ZazdSTXhtekEyU04rbUwyM1d2REEwSE9M?=
 =?utf-8?Q?Obkv5Bhkk1wQaePi++6B9cE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23057909-9f3c-48ff-941a-08d99e0bb222
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 14:18:52.2374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMX0dRlmhI41Gw75NwBk5qadbkfjPtnrTxy0h65FVsZjgVbqQDkysfsp+zdST3Mb+eID3tBcsWEDfIl7L3Lmsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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

Am 2021-11-01 um 10:40 p.m. schrieb Alex Sierra:
> [Why]:
> When we call hmm_range_fault to map memory after a migration, we don't
> expect memory to be migrated again as a result of hmm_range_fault. The
> driver ensures that all memory is in GPU-accessible locations so that
> no migration should be needed. However, there is one corner case where
> hmm_range_fault can unexpectedly cause a migration from DEVICE_PRIVATE
> back to system memory due to a write-fault when a system memory page in
> the same range was mapped read-only (e.g. COW). Ranges with individual
> pages in different locations are usually the result of failed page
> migrations (e.g. page lock contention). The unexpected migration back
> to system memory causes a deadlock from recursive locking in our
> driver.
>
> [How]:
> Creating a task reference new member under svm_range_list_init struct.

The _init is not part of the struct name. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> Setting this with "current" reference, right before the hmm_range_fault
> is called. This member is checked against "current" reference at
> svm_migrate_to_ram callback function. If equal, the migration will be
> ignored.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 2 ++
>  3 files changed, 7 insertions(+)
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
> index 939c863315ba..4031c2a67af4 100644
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
