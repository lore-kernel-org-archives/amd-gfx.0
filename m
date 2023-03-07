Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41707C678D4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 07:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E8D10E35A;
	Tue,  7 Mar 2023 07:04:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093B810E35A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 07:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev7OMq9dsU0tCIWgEQEgln0Xiky2lWtoKwt/7gphplgtNY8t2qWwdxjzZxDJaXzL2eN8YlKjwEsZw8MmSnJeqlZaeWSHXPtWpgoahkNaZD293LlpSLyg3oy4/qcFYqkICDipzVaLpLG9W6KkTVZ8GgkdEpjq/lqJR/4dpFOTeaW//jQPH6WJYQIjBELdxhBwg8GJ54395+T5ByOBOpgREtKEpGNeRZHpZ/MrW1BH7sRxe1IpCpJh/QbkaJpUCqXoBaGfrQ5r59IznPRyaBvYm/Pb7b5berWxkq7CQSsYMaYyEVNHNC8xgKscTK4BD5ppkXb1hb+jio89Sk8mxjcH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycXMW697e9XtrUa/vqwlPLhjzlkKYYic3LHK/cWTNYE=;
 b=IJIAzl3M467GiLNbowIBRK7uFFCR3P1NcQ0VmoEzRSdDfBnwqU8LAjaJ0xU1SwAZ35NdJU00uDhJ0/fjE1ZyQwZC5NO6VVuesiICDi5TfcBytWZcjAHSgXzu4EGeuAPPvojojTzTN+Ihz2yUerHxZR3fHCusklm9lBuTEERppyf3juhqOY5zLEt5kQIKWdGyyasvg8KeQnWFtp5kFvJoaypP3V8LHvnSwM4e9owyT0HENK/KzG3suXtHowlUPrPhZs67/A6h1nXNgsvvkRwslOOBdm0y0X+1+Ct0VPHgnAidoLPO1IKzFX7skU3DmmaErYR0FUXUs9uv4kNNz8RHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycXMW697e9XtrUa/vqwlPLhjzlkKYYic3LHK/cWTNYE=;
 b=ApwrqUGKPxmdow0rTNJst0Eq/ZiEM7fosBYp9sC/QJ5GT1u1rBqRDGR0kWOFOsZqQV0I9mRw11WNFJHDOEfs/flkaVSS9jsIa6h/LlPReKMLFp+OSjfrVNQSemk2NZkePN/P7L1fQDsCTlLsRbyMpi+f+Pl2ArLjoo98q1990b4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 07:04:38 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 07:04:38 +0000
Message-ID: <92f89f03-dfa8-0f50-309c-69c7c22541d8@amd.com>
Date: Tue, 7 Mar 2023 08:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Content-Language: en-US
To: David Belanger <david.belanger@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230306215808.2903387-1-david.belanger@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230306215808.2903387-1-david.belanger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3dfdd5-e8b0-4ccf-17f3-08db1eda3766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mDqZjaLxeLSsslM7+3id+9L8196kLLSXU5u0BKrquGDZvt8DAb5tIs+IbQfIbjC44/L6WcnzP8C9hCtmimRuKFnH2FOsqjxyZmOZAKXlJhY2/gO9lnX8yhyl9KEFhlTsSNOzJhe+rAYUOg0XE3c/wAG9T/rYFR+1iXf+kJwkdnyAuOu/m1dQHCATHeAbkcFABdbLikwbh1IVh2iVlcx3J9KTUFI2LQM6K8Z0vHZWNx1jROyydY9nTwdu9avnsFJAD6oNQ13yCC8pxQ5JuRavqBBFCrKYEfPR9mtLVVpTWkdQlM/STx5dP34fA+Q4huuMjPf7ZfTGv5ORmOk5Mt82TxzcB8ZmxmnYMR6n7kyisRZU7Fok6/RfccDVB3ECkGwtNetQVSV5dEqiB7Yht2OUr/W9dkAzQxg1n9iSFjKNNt1oEMbPI5pe+g19HaauwU5W8SNgirmntKBIQv0riIuc5GqlWOkwlCHzaFepCU2F0qJ+bD4b04njhUirrNv7LhqAnvlrg58Ntu8wLw57qbWlmW3Jz09QDfwEIieGxiT/LyVhDqkOO7FVPIYHOoubkZhQnqRWc/ZyYWEsaUofc6xVr/biylFmnLmcI915LMawEe0P3CzqlfnOjqrAI4rHbxGOGVQHlmrIBQwVEO7123gBgtixg8JR0gC7OJVP7tEKotKTvtJR3YQYJY8kCbuVi99jrDDBW/5qVd+gtuw+4udFfHD+ZT++UFzFxX5wiaywYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(31686004)(5660300002)(2906002)(8936002)(41300700001)(66556008)(66476007)(66946007)(8676002)(83380400001)(316002)(6666004)(478600001)(6486002)(6506007)(31696002)(2616005)(86362001)(186003)(6512007)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BKcTFBNkx3RlIvL25Rek5lVS94WWFreXdya2taa0s0cHZLRHE1Z05nTzFk?=
 =?utf-8?B?QmlkNnB6cnBTTThFbU12L2V5akZBSGt2bFFXckExMWUxSjhFNk15QnZqZUVu?=
 =?utf-8?B?SWdpY1d4QmV6K3Y2Q2F0cmJ1Q3JkV21KN01CNXRtUkdBa3NSNTBheEp1V2NK?=
 =?utf-8?B?cTU3SmpyUGVyWWE2alV0Z0ptVG5OM21FcDBWRGE2V0pnd2NyeHJTUlpJNENY?=
 =?utf-8?B?UUxsUlZwTVRsbVFQcjR2dXh6LzVURWVJemkrdDR5bnErQmM0LzJrT3VYM2Vt?=
 =?utf-8?B?aVdRb0Y1Ry9WeDBreXRkcTFFdDNTVU9lWmlocmFqYk9JYUpRb3huMDhzNWZz?=
 =?utf-8?B?THpuNXgrR2FoVFhMZUd3dDF1ZEhtb2d1NytvbEprN1BQTWd3VVNWclhmYm1X?=
 =?utf-8?B?ZXB4YS9XUEVFNXNEQnRXOFp4djJ3Nis3QXJsMlA1eU5DZ040dyt6OVd5MVlR?=
 =?utf-8?B?bzUyNXhNMTdoM1MyOWpsRlltVkkreFV5OWhHL2hJR0o1SEpNVDY2OUEvM1Zl?=
 =?utf-8?B?RGZjM01DK3dSbkNHZUxIazQvQ0oxcFJkZFlubm5nbG1rMkZ0NE1hSmthekJn?=
 =?utf-8?B?QVpxTFpQaGl4SzZMSFJoV1VvWGhpTnp5Vm1wczU3bW5XVStUYUZHWWxmQmxh?=
 =?utf-8?B?U0VRWGdQeVp4S0RsRUYvMHduOUtySTlnN1lmR1BObDZWVThPaTBKUlZJdlkv?=
 =?utf-8?B?MEJwb3ZUUHBSMlE0QWU3MmVGd2VKaVJUbXpkZkpTU1RJR2k1UEhUS3FBYTZk?=
 =?utf-8?B?OXdIYUdXYTdHRUhiUUxSVmVETUVGMWZEVklMTG1haGVQQVowYnAzYW5mU1Fl?=
 =?utf-8?B?cGllS0VlZ1lGcDRkckxPYlE2Z1cyVXBnczQ4eFV4eEtReDgrL08wVXBvMU44?=
 =?utf-8?B?VzNXbTgxSjcxMXVaYWxYMXJhZ1FCbkowTDV3cjVidGJOb0RHN05iYytBWG5L?=
 =?utf-8?B?OG4vdE84d2lJYWFVTENIOCsvdE1GaG1aSG9sUmhIc2tJSUE0OERXYW9vdE4v?=
 =?utf-8?B?dDNjQXJKcm9hRkhqSXdVQWladFRER2tzR1ZLdFhHbVpySTFTTjFNMHhhNURo?=
 =?utf-8?B?dmttVkhRdVd2dkdnRC9ZYjltdDkvVkkzVnpHZGhYSE5KRy82Zi9Uclo2WWVD?=
 =?utf-8?B?clByWnF6Uk5RRktEMmdyT3hMY04rSDVjNkpkdDRrcmYwWjh2L2tpQnVYb0dM?=
 =?utf-8?B?MHUxU3ArRFhzOVFRNFcwS2lvRzUwMGdpY1hNeWpxU0J2WVBFN3k4bTdmbEVX?=
 =?utf-8?B?UGY0UFRHMENWQmR4TDZYdWd5UEViSGtsZHJKT1BTTHRwMHlvbEtCUjA1bGxs?=
 =?utf-8?B?N2lqc2w5eDcrRnBDRm9ucE9iZlNEamZHTVVxc0RvdE1VdEd5TnNnQWFVNkJp?=
 =?utf-8?B?Vzh2Mm9DTmRLRDhNMVptL2l0T2d1TE44bjNBckx1UGlSdCt3OGdCcTBYYWRX?=
 =?utf-8?B?NUN2SEJ5c0xoVmJuZDlXSm14UlczK2tsWlEyQ0YrZVo1c2Q0Wm5URExDcmhZ?=
 =?utf-8?B?SlZoNkZPQTcrRjdlVmp0TG85NzlUazQrMklraVhaZG1vMmlXbmZyazI2VUZ4?=
 =?utf-8?B?TFIxczVTaXI1NnRHMFI3OS9FbHZuMTVKUnhEZHkrNFI0bmt3Mmw3QTNMWDlD?=
 =?utf-8?B?eEFiVEpjVytHQUlxOWtjSWtsVjYzS1FTcjBLR3QzN1A3M3JlZ3lKbjA5bzU0?=
 =?utf-8?B?eWpWQW9rRElLZXZNNkF6dXZDaGVma2hIc0Y0TzBxakNuZDlkVDRFMGwrbDNP?=
 =?utf-8?B?WmlZdUxyd043MmlhZkVRUXZlKzVrNzAvQmI3ZzJSck4rdUlGM3hRTG1DV041?=
 =?utf-8?B?MzVQZmtPZXZaS3JNTWphRGlqdUZkb2FPaE1HZy9oRXdhaWw2MWJ4UFh3MWpw?=
 =?utf-8?B?QnRZRkkram42VE5vNmlxMWZRMmJUL3lydGN5d0F0U1pJNFRXTm83SkE5bTRU?=
 =?utf-8?B?WlEwRXl3YmRHeVBJa1Q3dm84QlhOWkc1US80TExQRVFvRlNCa2xleWJpVlcw?=
 =?utf-8?B?Q3h5SXJ4bFhwMU5HRkgwQ1lBV2hMSzhuSGU1azdIKzFBYzN3aEFEVnJMeFVI?=
 =?utf-8?B?b2pXbm8vQ2t2bmwrVHhyeWk4cVJTelZ3ZXpLMlVxNUdDWEJyaXB5bDlJekE5?=
 =?utf-8?B?RkRab0VYbDZPZXpPVHZIUDBUSGNGMXMzYzlKSHpQbFJEa0JmUVpQUjZPQVBo?=
 =?utf-8?Q?sHjXNpMTj6gTi0JzkTuzJCfYD+TIxVFZPt9dfCSVbVKi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3dfdd5-e8b0-4ccf-17f3-08db1eda3766
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 07:04:38.7479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meDQSoP1gbdEdOEV77gVLCwa9BnIscZPWXjYOJp0CpP2XzLzfMKIZO6bn/y5Ukr9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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

Am 06.03.23 um 22:58 schrieb David Belanger:
> Handle case when module is unloaded (kfd_exit) before a process space
> (mm_struct) is released.

Well that should never ever happen in the first place. It sounds like we 
are missing grabbing module references.

Regards,
Christian.

>
> Signed-off-by: David Belanger <david.belanger@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  4 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 57 ++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> index 09b966dc3768..8ef4bd9e4f7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> @@ -26,6 +26,9 @@
>   #include "kfd_priv.h"
>   #include "amdgpu_amdkfd.h"
>   
> +void kfd_cleanup_processes(void);
> +
> +
>   static int kfd_init(void)
>   {
>   	int err;
> @@ -77,6 +80,7 @@ static int kfd_init(void)
>   
>   static void kfd_exit(void)
>   {
> +	kfd_cleanup_processes();
>   	kfd_debugfs_fini();
>   	kfd_process_destroy_wq();
>   	kfd_procfs_shutdown();
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ebabe92f7edb..b5b28a32639d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1181,6 +1181,17 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
>   		return;
>   
>   	mutex_lock(&kfd_processes_mutex);
> +	/*
> +	 * Do early return if p is not in the table.
> +	 *
> +	 * This could potentially happen if this function is called concurrently
> +	 * by mmu_notifier and by kfd_cleanup_pocesses.
> +	 *
> +	 */
> +	if (!hash_hashed(&p->kfd_processes)) {
> +		mutex_unlock(&kfd_processes_mutex);
> +		return;
> +	}
>   	hash_del_rcu(&p->kfd_processes);
>   	mutex_unlock(&kfd_processes_mutex);
>   	synchronize_srcu(&kfd_processes_srcu);
> @@ -1200,6 +1211,52 @@ static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
>   	.free_notifier = kfd_process_free_notifier,
>   };
>   
> +
> +void kfd_cleanup_processes(void)
> +{
> +	struct kfd_process *p;
> +	unsigned int temp;
> +
> +	/*
> +	 * Iterate over remaining processes in table, calling notifier release
> +	 * to free up notifier and process resources.
> +	 *
> +	 * This code handles the case when driver is unloaded before all mm_struct
> +	 * are released.
> +	 */
> +	int idx = srcu_read_lock(&kfd_processes_srcu);
> +
> +	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +		if (p) {
> +			/*
> +			 * Obtain a reference on p to avoid a late mmu_notifier release
> +			 * call triggering freeing the process.
> +			 */
> +
> +			kref_get(&p->ref);
> +
> +			srcu_read_unlock(&kfd_processes_srcu, idx);
> +
> +			kfd_process_notifier_release(&p->mmu_notifier, p->mm);
> +
> +			kfd_unref_process(p);
> +
> +			idx = srcu_read_lock(&kfd_processes_srcu);
> +		}
> +	}
> +	srcu_read_unlock(&kfd_processes_srcu, idx);
> +
> +	/*
> +	 * Must be called after all mmu_notifier_put are done and before
> +	 * kfd_process_wq is released.
> +	 *
> +	 * Ensures that all outstanding free_notifier gets called, triggering the release
> +	 * of the process.
> +	 */
> +	mmu_notifier_synchronize();
> +}
> +
> +
>   static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
>   {
>   	unsigned long  offset;

