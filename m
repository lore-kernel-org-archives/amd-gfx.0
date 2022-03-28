Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFDBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5050010E6A3;
	Mon, 28 Mar 2022 13:16:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601FB10E6A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if+Y05o2hx1L0746GnW3q6Rf1tGFjLcgTjR6R4lKRAERDCnIqaN+fYfcg9TavBBSu8CUsF9AQWSY/b2Z1EcbJHQJp47GR5K0PaCw7aJDC7/R/XgBQjORDcoZzExhFh4mpwrq7AoKTx9OkcuD1Rd7tYf/Du4REoMhhxVhJET9a6XcoIMe8r2EKQiGHPJRawphv9N5V6VqC8lEyFIVMA0sTjw7y5PimW0ud6WLEsLSa0A552s/xw3WtY6t8S5eTvgZhmIRv11q70gWiV8R4g9s8uldkX6BC1ZeJ7M0QafcTAHKwwVtL7P4vGWNbPl445x+iegytECAXTAtLqWzqeHKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLgZ/3OQi77jQt0pma/lOoaPjwMw7W+JF36z03F5Pp0=;
 b=UYpg54goiKooyug13FXRScbq1zM7bJHUyoSiD5nns82bslQaFBFD69ucGHxnamcq97fdl+KnJtpk7ByIkMi90txyKZQuwOl7pTlZDU2l3qtvxn65hF+hkP4bD5HeUgs3tGETEjFzpd2VlHsODpD3Ga5Ox/PZJhniEUWH6A+rA2U+A7Yowa4vEkulmgkBDFI9IA4UbNxWRmuuk8nQ5CvZB7KtEK19AnqszQUg0+0DrLIlM1srgnuICn9Ieaz2R1OAMrYACFwGNzNYiIKJHAFxWRnnibP2N5/+mWKGAs6FxFcxqGnMvGUphk4F/LaOSx99wJPUBiEI80+pTUqF5Y/pnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLgZ/3OQi77jQt0pma/lOoaPjwMw7W+JF36z03F5Pp0=;
 b=HEIcpoX8YXrHVDREUNAd9KMah0QpaWwg7z4xGfzcjV4479InnOtz07IT9lRn1ij6Bb9FLMm8z23dc9vI6alJ/dx1uhOZ3pis2vTNvMxZRCgFN2h6mNYh2w0fzTgeqz5btblDGywbvAtVIKrYHNlZnyLAlsHSJML2gSWGSrAuuSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 13:16:11 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:16:11 +0000
Message-ID: <ef99d46a-937b-e64b-61ba-fdbf5ca080c3@amd.com>
Date: Mon, 28 Mar 2022 15:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Use atomic64_t type for pdd->tlb_seq
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328130700.29642-1-Philip.Yang@amd.com>
 <20220328130700.29642-3-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220328130700.29642-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0342.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df973f25-22a3-407d-a9d1-08da10bd20c5
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB548106B86414A7CB9D7919AE831D9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQsQp2JLAoJTt5qSj/6xr+6qLm72eBAVFYAMOra6wq3QmtDwdcB8JBJ0tBclp5Elje9do8EE6xjTtx5Hg10LAJ0WgO4F8XjKtdEFbL2Q29JNhPVJBGRW6L/BIUy+OPSi9G/6YJlAbxatMkhNP0UCXeuyVHBNPUd2fpAsG6XZjZteQJLnldPQMC0zuRNHAcdP9Jp09SMlon6pRTRLd1u29zUCXE8nz1mV7SLduJeWIwWWx2n6/3FKYaCP096+2rQhyB9HbEIkyB0J1xBosjW1Z8csgCxc1QuTq/ZfDf8ygJjpBwvAlFHAHcJvBO2wwF2C34NM18jd2HpEe34gOEi4IE5Tub9UDa1xjEUNz/40URRcM+dS/kWE9U9uaV94hSMfc+R4gW3gPSc9dwSAbkrfKkhHDv4bl5z60aJgnGdjU2GF0chNtkuo7I6X2jSY5ALvEaV50qGfzGwHTyxhnxNJ2ab13akak8m1VI7+lOAh+q7f/6oitB6Q4Vghr/2zk8Bg6Brpt3hsx6zw8+JiwgJ2O5Z0VV/9yEecWk1yETaslolZeAyuixdCpV2KDNcKAh4sJGiQrSNcCWgQg/FmYl5menl35E4eOC1ygrOhxdE/77qg1CHqq00BGIl615dd4ZIVBkS+uCrgtD8tK0mkm+TuKJ8zna1WwLIbYL9Vn3DD996UKHes+x+DXbNUu651L8ZwbYEF/nCjWTKOtrQwfyLRhPalxsLAEndjzCk7xbuALVmJHFhlY65k800p7t9y48B8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(86362001)(4326008)(38100700002)(8676002)(6486002)(66946007)(66556008)(6666004)(6512007)(6506007)(66476007)(5660300002)(8936002)(508600001)(31686004)(83380400001)(316002)(2906002)(2616005)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHQwOFhBK1ZydDBYdzIxRE0rUW5tdnNaa0kzT2NROEFZTEsycXBoVGpRS1RL?=
 =?utf-8?B?WFlTTVFPRUR0YVdVT1pnNG5Xem9DWW94bHBjRUZWN24yclVQSWdCbG1yVEZm?=
 =?utf-8?B?a25YamlwejRCNTFaVGVRR2ZZb3VlRk4wdUZrc1ZQSzB3NXJ2T0QyWjNyUElh?=
 =?utf-8?B?ZVF0NWZmN3pHU25MZ3R3bThFWHF2QWVvWEZlWW9XUjFxeGhoQjhZNTRETmpR?=
 =?utf-8?B?ZTBjZzlHc29iVGdNOUk5WUljTE9pUWR1M252ZXl3d2lqbTh5SlVTemNrbzc4?=
 =?utf-8?B?c3NSL2I3Z3FYLzVSVm5aNVBxVDNFczFvZS9rYldzOVBSZFRSWElYQnQrWjJ4?=
 =?utf-8?B?ZnVIOU9COWFXbisyM2V4bldtQUFLbHpEeDJmMnl6OC8vWTlsZjN2cnBQY3dr?=
 =?utf-8?B?YVBjYWMvRGVJWnY4WU9XWUFvNWplbVlVVFh3eUg5Q0MrditxSkV6ekYvT3dY?=
 =?utf-8?B?QkdvTlB4MVRjTkpxY3p1SEFGZ2pYbDBYbGRyR3pUc3pnT2ZsRXZxNlpTdHJx?=
 =?utf-8?B?RGcvL2ZybG1razRLWHJTYWMyK2ZoRG0wTlVJYm8wTDF2Umx5aGF4Vm9ta0xl?=
 =?utf-8?B?bzloZlNpdTNndnBUTXcySCt0VVc4cU5VajF3ZXlPUElBd1Q1elFDTWhiSXQ5?=
 =?utf-8?B?a0dtdmRUd2F5OW54WmhWTU9uTi9JSFphakRud0pJRXc5bmV3MXVTNW4wYlA5?=
 =?utf-8?B?R1ZKVUQxUFFUT3N4T000UHRFRHNQV1JHVjNYU04xaGdEeDl6cWJpWktUcU5L?=
 =?utf-8?B?YUw1ZkFkZmtWVHJZN1lrd1BVSk13L2xBS1hWS2xMbUVzd2xzU3FwV1ZQekho?=
 =?utf-8?B?V2hHdTVIVDRLMGtlQ0hoZEJxaER6dDRqUE1GRUhnWG9vMi9Ta3p0dTRmTXNs?=
 =?utf-8?B?YXE0SktSbXlJM3JiamJkT20vbzcwV3lmSkh3QlRiR2tSSnRxM01lK2s0UFRZ?=
 =?utf-8?B?VHdnQXF0T0xPQUdldEQxWDh6MmRuREpkOXhXaE5UdHBORFRxdnJiU1l3VndO?=
 =?utf-8?B?Z1A1anM1MTZJQmtYOFRVZWhIQmhxa2NWdGgzY3hjQ3BNSUZDZ0hBdHpHZHJo?=
 =?utf-8?B?TmpKbzFxc1FORDdyOGMvdFlYMWY2d3I1UUtZVzZFVkhLakZFUmljandvTXZT?=
 =?utf-8?B?eUo3bkFTekNWc1hUbEZ4RFg0T2luZktwTkR5L3dWVVlZaHFYWU1XbXl2aEZH?=
 =?utf-8?B?bUtlOE01QzEyRUsyNDUybXF5OFlUTUpaaExTQitOZXZNVHFaNzdZbTVqM2lU?=
 =?utf-8?B?azZVZTNoTEh5Undab0JheEdMQVNyWVlOMzJkeTcyeUJkVkthL3d5T2tSclor?=
 =?utf-8?B?TmN6ZzhYbVhoRjl4RWZlTHkrNGxHYzVpOGJQaTk2Q3FDV3YrRE9nOGJYT01L?=
 =?utf-8?B?QVJFVFhlTGFUM05Cdm10MnVwRU9ja1lQWjVteXptUHE4dU9KQkFVUXJIMHJZ?=
 =?utf-8?B?TDlwUTdTL2R0ZXhMbWVVVVJ2b0F3ck1DYjYvU2d5b3cyU3ptUnUrcGhjSUtU?=
 =?utf-8?B?VVBvMFJ0aEh0dUE1d3F2VHhMOURyaUt6b0dDVWxUNEpHZjJWK3NGTXcxTkhp?=
 =?utf-8?B?Q2MrKzl0cWdlcDhWcEx2alBmT0tRbmpOYkJOci9CVFQ2cm1ST2FBSmRDdkk0?=
 =?utf-8?B?aWh3TU1PaDdRUzNyWmk1V0dKUGd0SkJLMGZ0MzdQMGM5Y2RZL1k5bVRUUit4?=
 =?utf-8?B?WEI1dU1FL2xzT3Ruc2tZS2ZiZFVwRU5GVlZDdFNTNkN3dzVNTFBzK3BPTkoy?=
 =?utf-8?B?UGlrdVEyU1QwVlZFZXJoMEMyM1kxd1Y4YjEzV0x1RXNDd29JT2JKOEF1RUFP?=
 =?utf-8?B?SXVPSCtpWjkzVjhtUDRiMWVwL1FUdUpwNkdWNWJLQU8xUnA0UHVpSElFYWlu?=
 =?utf-8?B?NEFSQnN1akJnOEtJaW5sVkozMHZJQWRXUlNpc0NXbVNuTDlic0IzakpCTUpQ?=
 =?utf-8?B?K2Q0d3JEYWQ0amJIRmtjOTljbjdNOE5MVzVxbGU2NnN3UzlSbVU5RXFVczRu?=
 =?utf-8?B?UFlwWi93ZzBxU1BVWDZaR3k1YW91OVkwOERNTzJTSjRXQzVqeVFQYmNlOVRD?=
 =?utf-8?B?STZsY2VaclRDZjV4aGQwZENHNW5BdDVWdVIrUnp1Z05xeks3em1Gbm9mRWJq?=
 =?utf-8?B?bWl0cEFoczk1RVdxeDZ4RGVVc25VRk9nYXBaVUpyWER0M21sZVhOaFBPYndq?=
 =?utf-8?B?NGZBakxGd3JRQmcxdDVsYjJOT2ozL2xjZDhOY2lZTGNKdG40bnJFTDByaFkz?=
 =?utf-8?B?NG02T2p2SkR1TmZiZzhUVFpDUzFKRFhYN1hoVTdDZS9kQ3d1T1Z6ZWd2T1pl?=
 =?utf-8?B?Zzd0aWF5MXU1azZCQzY1aXk0eDZ5b1E1T0ZKOHlCbXNhQjJmcHBRUGdKcVhB?=
 =?utf-8?Q?omOWv7W5i4VMy2WHmEB3Fcq5dXb+jKRaA7TlLheD4RkEI?=
X-MS-Exchange-AntiSpam-MessageData-1: JC8+Eup6h/Ddnw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df973f25-22a3-407d-a9d1-08da10bd20c5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:16:11.2597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+HP3lOpgB8iq9b4ne4SGzglnCmFNFWHX4Nm8p44H6nXQoeggpB0y0gtQVrPTnfp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 28.03.22 um 15:07 schrieb Philip Yang:
> To support multi-thread update page table.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 945982a5d688..e1b7e6afa920 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -705,7 +705,7 @@ struct kfd_process_device {
>   	/* VM context for GPUVM allocations */
>   	struct file *drm_file;
>   	void *drm_priv;
> -	uint64_t tlb_seq;
> +	atomic64_t tlb_seq;
>   
>   	/* GPUVM allocations storage */
>   	struct idr alloc_idr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ac8123c1ee8f..43ed8ec1f975 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1560,7 +1560,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   		return ret;
>   	}
>   	pdd->drm_priv = drm_file->private_data;
> -	pdd->tlb_seq = 0;
> +	atomic64_set(&pdd->tlb_seq, 0);
>   
>   	ret = kfd_process_device_reserve_ib_mem(pdd);
>   	if (ret)
> @@ -1954,10 +1954,10 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>   	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>   	struct kfd_dev *dev = pdd->dev;
>   
> -	if (pdd->tlb_seq == tlb_seq)
> +	if (atomic64_read(&pdd->tlb_seq) == tlb_seq)
>   		return;
>   
> -	pdd->tlb_seq = tlb_seq;
> +	atomic64_set(&pdd->tlb_seq, tlb_seq);

That should probably use atomic64_xchg() instead of read+set or 
otherwise using an atomic doesn't make much sense.

Christian.

>   	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>   		/* Nothing to flush until a VMID is assigned, which
>   		 * only happens when the first queue is created.

