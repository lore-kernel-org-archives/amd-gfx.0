Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AC5C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 17:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F145110E27E;
	Tue, 25 Jan 2022 17:06:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F8010E27E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 17:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqyePUlLjqML78IW+egocfrE8ko79GFxt6CqmwRDxX7IwinbfN2wMZyfGwa8oBTf8DdTgLmf8uogR48W6NctUNjUpwKDMfZf2+xVFVDYujCG5jhC2+o2ydmlwWfkBiWrwAmtsNr0hnO7dlWwBGzpuLoDqDdy+pFpqBhhLrEfjzoQCrnJiQexRxv23hxMYY/j5miy4VLI9PCOv2u0Na4iTxr6BR9xJq/r7wFSB9UfdfGKBqIhYtgybZY5MbCT8p07zkwDUz6xJ/LiUeETqpE9lLDpq+RBB0PhKjKQQIsbaQLqgrj0FReS669IUnlTL4eH/06U8qYwolDYnNznily2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fjrSfcvbvvCMl3hwyIBnM0yjHKJ56M87eKRFnpQKzE=;
 b=ZnCoXvp4t1R+A2kYyc939woBlMV5tBG940aOFJAkTQNbct56/OKXC9PtMcRmzZ/0OFRQFDVVnc+lLnLFhbK7bbaLKF4VjsHtXlw814sT1plQ+x0fbF+FNOYb3F2escgkAOw7xdVAV/HaC4PC6HgarzImDmicBpMKbW7vhoz3UMp/EoJ3dkJqvI4Z7tUuAKQZLlrWvorm1l3Qwi3PCTKS0+utRJT6Fprz8MprkOXRNdF7ye75mVz/Nda/joHKn+pZ6KRN1cSzaF8BwiDCAs4gCswtNsmJaZ/xww6sUbQrcdKnc8s2f8JPzdZgX+2dGwBiYWyDAK75gWA8zqxIdBIGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fjrSfcvbvvCMl3hwyIBnM0yjHKJ56M87eKRFnpQKzE=;
 b=mdMro3ePUjIA7kaJJZ5EVjBTLfy5V0lmewC9z4ey+ATqPubvxETyiyJBNjqwDqE6ZrFArG5LMPx+Ehgmt5j3r7fs0iEFqCDuBrMFnyo9Ine/1TPpNFki6gnAuPiZKMJNK+YtcKBFQEezrAvTI0r+EIo+GPH7pN9be8G7mjwfh8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 17:05:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 17:05:57 +0000
Message-ID: <c46296c4-0e7d-cba3-d3f9-0b120b32c326@amd.com>
Date: Tue, 25 Jan 2022 12:05:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/8] drm/amdkfd: Add KFD SMI event IDs and triggers
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120231322.10321-1-Philip.Yang@amd.com>
 <20220120231322.10321-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220120231322.10321-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57572ca6-586f-4aa4-7a3f-08d9e024f482
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB47225A67C85C2D8BA9F1BE9B925F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CGRu4tW3rsKIlmt+oQEerrBt3FVU9czF/n9lH60e5T6EqsHOS8ln82SM8NG+iHyh3XjTcxK2Dz51YskoejgDeuddKL6xznmfyN8IChBL7KKv/nAfU4fxofFR/RhdRmDCa4UnSS+ngLhm6tx2HGtboHZTzdFSPr3GLjmSZ7jnLeQthUKKu5cRx3PLhBTEpjwH4E2sCzfGdmaMuYpbYgl2dB2OFYIFEpdxy/yC0OIJ8dt68vVb7zF471h/4EpR9GDG0Np0b79/pR9cyM+Tb2jYYczICW2tcDyMbMLAXrxq26O0RgkDCEdZ0eIZ6N3Ivp56ZeSmWUSu2CrgJAKf3NT5uuuh1KUR0lUaqWCBd1qmLzbeFzsCNaSdd96amXvAEATVGMC3mEgUELuGsqC3ieg6dNmSq0qA3VHFtxH+99D7hSWQjX3Zx9eXWnn6K2SCv5oxp+7aIe+XJJ1W4qSLdHoezwiTpMOYrRh0dLvFZAOdKcRRYgCNgmQvMypl1alCsa5BHpUXJWEAHbXwm7xIEXpSw5yBclQdcgogIEcIBlPo9gLae9IBGHhbJfZkpDCgCuWW8iDsQ6k82CZpeusx1r4Xq5CcbT2y/U3fEYZ3ljZ2BwN3DtSf9AJl2XM7u27jTQczJ33BfhueOXn4aOO2yPK3fMlkCkywECQoHlxn5FKCuL9Pu2f59Oa5uVBX8R6pA5n4l9C+VChBkP7GMnjui81H1FxcbsczhgseQuJrI3zpUpx0jsKJJAa/pxDM4FGZLH0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(38100700002)(44832011)(5660300002)(2906002)(66476007)(66946007)(66556008)(31696002)(8676002)(8936002)(86362001)(31686004)(2616005)(83380400001)(508600001)(6486002)(26005)(36756003)(186003)(6506007)(6512007)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clA0NjR1ckdWNFZkUjhFbjZtMFpmb0pSdlp4S09wVjBkcm1kVm5MeTlGL0pH?=
 =?utf-8?B?NUc2MzY2TC9QekhCVkMwaG40RXlTUVh0Q1pWZHRmS0Zad0V2c3pTV2dvT3Vm?=
 =?utf-8?B?T1cwckFWc2xXd3BPcWhnM2hwWUFqdWJxL0pTYi9YVVVIbGlhM3h1dm1GZ0Zt?=
 =?utf-8?B?cFRkdnpVdjJacUdzbzd4d2lLQld1bFdKekRNZm9QdDZOZ1hiM0ZueCtNRDAy?=
 =?utf-8?B?N05kcEtvYlBNZmp1RGpySkk3d1M4SXJSNnJNYjZrTjJWdjFSYk9rMjZ3SE5p?=
 =?utf-8?B?OXJhU2pvNEUzMmNLU0hubGZSWGxybFgvek5rME5DV1dpaHdBRy9NL05OYUoy?=
 =?utf-8?B?a0plbDhRb2pUOXdzUFhhSS84U2NkcEJoY2lKaEgrZ2ovY2JRNjh6dWlYQVJh?=
 =?utf-8?B?cHF2cWpyS0NydVdLdm1USkl3ZGpHR0d3LzVTaE5aRmdxczI4L0IxVVZkNVEw?=
 =?utf-8?B?TGh2SnJLcUFsQ1pWSkFEUUZvRGUxYlhUbjlDWTdBTGVaa2Roa2RVUHMzd0E0?=
 =?utf-8?B?Z3F1RTNvNE1nVW5sSTZEL0F0WmM0c3Nodm9rK1hsUmY4cDBJbXJpaVprWmZY?=
 =?utf-8?B?czZHVGRDc00zNHAwajhGNHZjb2tZdW0wOE5Dd3JzdXdadUxuOThXYXVuUXpX?=
 =?utf-8?B?SmlLa28vNlQ0UnBFZUt5b01MaGNDNVFUS1VON1ZoYW9vdnFoQytrbHRTSTFa?=
 =?utf-8?B?T0ZGdlZZVUNoWExkeU4wRko2NTNFbVJ6WlNwSGFwaGdZUVJHVVM5bzZueU5x?=
 =?utf-8?B?c01uaTV5YXlSQlVzbzlwN2RSUHBUMUM5L2Eya3VQYlNrbFk4VlhmbDFxbnNH?=
 =?utf-8?B?NHdmUnduRDB0akQzWC9wdE8zR3B1ZG5Nd1R1cU5JSGw2T0s5UGwvLzNrUUMw?=
 =?utf-8?B?VEc1STNMSnpMVWxpNzArOU04bjBSMWxGNFdnSHRxNmUyUjBPY2EyMFZqSEp4?=
 =?utf-8?B?MW1GbjVtbUlPTGZNMWxuWTNVUzVudHdJRW5RS3BPU3FvK3pDL1dYTm4yY0ps?=
 =?utf-8?B?b21ZK0dyLzhrV0Z5U3lSNkZkN0pDajZyZ0dHVEsyKzBjYWdxN1kyZ25mN3JM?=
 =?utf-8?B?MXRsUVd4NVNSTVNuMkU2VnVuN0o1anVybVh0Y3hlaWtUSWNxUWtwb1hlYzlr?=
 =?utf-8?B?Zi9jakJaUUZadlg4aUNJdEk5UXlTNVhqZFdOTEZ2YUdwU3YxemZ0aW5OL2lT?=
 =?utf-8?B?TGt4RUlza3NwalFNSjdudlJzZUVvSU1BdUFMbUphN3hrYjlzSkJMNVI3Qmx5?=
 =?utf-8?B?bk5QL2s1N0lBMGNyTExMR2dJQWU3R2o2RHU0Qnd5MjdsM2plbmFOZnorazV6?=
 =?utf-8?B?R1REQmtTVDF4UTA3NGdDdnJyZU9QeHhXdFZadEF6bWZDOGlqK2dnNHZ0Mzl1?=
 =?utf-8?B?MmJUYXVWRGFjNzVaRC83SUVkZFNpeTI2VkowVDRqaGJhcGtGck81c096VzJ6?=
 =?utf-8?B?dWR6MjhONFNpQzJIa2pSY2ZzekNQcUdaOUQzeXliMFFYNTVjU0xWK2VNMEN5?=
 =?utf-8?B?MEJYQ1JxbjZiVTZJa2k4ZWxFNjM1RWpBZGcrbEVsWnNDbWcvakdzMkx6NXVZ?=
 =?utf-8?B?czdyeHpjNm5Uemp6UmxUVWVLVTNOUTVaZkNiQzhXbGN4cUt0WnFzbUM3NDN3?=
 =?utf-8?B?VDVjaldmRXZmVlRnbjViL2xjQzdIbUR5b1JhQVRmRWxFL3pmcUJWWFRiazdj?=
 =?utf-8?B?OUhSMzM5YVdibXB5YWdIeGFvcG56NnhQVWdtdHhMZFlENGxLYWExU0d4elg0?=
 =?utf-8?B?QnN3UFRtcHF5SXJpZWtvUjBZTnBzVnZZcis4Qi9RSldreEZ2WG1mQ1RhSXNm?=
 =?utf-8?B?V1BIMDFFajVUY2hyNDNUU1p4VkNHQXl5WjYrSWI3ejYza1UzUSt4OUw4cWhW?=
 =?utf-8?B?QlU0U0MyWStZVkRQSjcwcXdGMlczMTNzbThxNjlMTlBDTnZXZHpVSit5RGxQ?=
 =?utf-8?B?MndyWjVxK1NUUmcyVjhWVzIyWC9XWisrVVAvbDh3cFlVdGpkdTZ4VVRRYmUx?=
 =?utf-8?B?a043UUVmQURJRDZNMCs1L0g0SUJkUzIzM2h4MlkwdEpGRm9YZlFzajNTMlhs?=
 =?utf-8?B?WmFLNkNaRnpCaWN1L05wRmdpSExyTVlnc3hVM0NRSkpTdzgxZVVycFQ3eGpm?=
 =?utf-8?B?SEJ6S01hQVBlaWZOWXBuR2hwaTE5QnNXc2FoRTg2K2lOWXdvU1poL0tqQ3Y2?=
 =?utf-8?Q?uaxYE0QgDM+Cf96iGQiUUVU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57572ca6-586f-4aa4-7a3f-08d9e024f482
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 17:05:57.7615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj1lcxRkP8txJ7nOgmBnfZHurPCwjHP4g3tH6l7TBDyNQuEWlqkUU5YtXxlVCRBxZaQKFtuZKpmooGko8Q9wHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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


Am 2022-01-20 um 18:13 schrieb Philip Yang:
> Define new system management interface event IDs, migration triggers and
> user queue eviction triggers, those will be implemented in the following
> patches.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   include/uapi/linux/kfd_ioctl.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index af96af174dc4..de0b5bb95db3 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -459,10 +459,37 @@ enum kfd_smi_event {
> 	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
>   	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
>   	KFD_SMI_EVENT_GPU_POST_RESET = 4,
> +	KFD_SMI_EVENT_MIGRATION = 5,
> +	KFD_SMI_EVENT_PAGE_FAULT_START = 6,
> +	KFD_SMI_EVENT_PAGE_FAULT_END = 7,
> +	KFD_SMI_EVENT_QUEUE_EVICTION = 8,
> +	KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE = 9,
> +	KFD_SMI_EVENT_UNMAP_FROM_GPU = 10,
> +
> +	/*
> +	 * max event number, as a flag bit to get events from all processes,
> +	 * this requires super user permission, otherwise will not be able to
> +	 * receive event from any process. Without this flag to receive events
> +	 * from same process.
> +	 */
> +	KFD_SMI_EVENT_ALL_PROCESS = 64
>   };
>   
>   #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
>   
> +enum KFD_MIGRATION_QUEUE_EVICTION_UNMAP_EVENT_TRIGGER {
> +	MIGRATION_TRIGGER_PREFETCH = 1,
> +	MIGRATION_TRIGGER_PAGEFAULT,

Call this KFD_MIGRATION_TRIGGER_PAGEFAULT_GPU for consistency. Add the 
KFD_ prefix to all the migration triggers.


> +	MIGRATION_TRIGGER_PAGEFAULT_CPU,
> +	MIGRATION_TRIGGER_TTM_EVICTION,
> +	SVM_RANGE_EVICTION,
> +	SVM_RANGE_MIGRATION,
> +	USERPTR_EVICTION,
> +	TTM_EVICTION,
> +	UNMAP_FROM_CPU,
> +	SUSPEND_EVICTION
Migration triggers and queue eviction triggers should be separate enums. 
The eviction triggers should have a consistent prefix: 
KFD_QUEUE_EVICTION_TRIGGER...

I'm not sure the distinction between SVM_RANGE_MIGRATION and 
SVM_RANGE_EVICTION is useful. It should be clear from the context, since 
migrations log their own events. If anything, the term 
SVM_RANGE_EVICTION is misleading. It's really any MMU notifier that's 
not MMU_NOTIFY_MIGRATE or MMU_NOTIFY_UNMAP.

I'd suggest the following names:

KFD_QUEUE_EVICTION_TRIGGER_SVM
KFD_QUEUE_EVICTION_TRIGGER_USERPTR
KFD_QUEUE_EVICTION_TRIGGER_TTM
KFD_QUEUE_EVICTION_TRIGGER_SUSPEND

Then there are triggers for unmapping from GPU, which seems to have some 
overlap with queue eviction in svm_range_evict. But that becomes a bit 
easier if you remove the distinction between SVM_RANGE_MIGRATION and 
SVM_RANGE_EVICTION. Then you are left with these two unmap triggers:

KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFIER
KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU

Regards,
   Felix


> +};
> +
>   struct kfd_ioctl_smi_events_args {
>   	__u32 gpuid;	/* to KFD */
>   	__u32 anon_fd;	/* from KFD */
