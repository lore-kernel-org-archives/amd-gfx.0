Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE6606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GUBoPMx/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC4B10E05E;
	Tue, 20 Oct 2026 17:00:32 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8641310E05E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 17:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIFClKGSpVJ1/EbRnVrzu3cBfnGChrFcVe04bRTvG78FdOmjxAlUSzARBFCt1e4/QWyX+BqJ59JhlTgUC7aHEp1LMeDqnxxU0dteuxz7PYbjEU6NptqFg94CrnNRbIgYaYWK9cczNodfQo4E2CwApLieiEKV7XpEbCO1cWTiHrBwb6uq/7HqMHA/9yK8TAPAxRx/mZjChgngAtDaT8fAgLhpptSE5lITf58mOUNHjpqneo9yxltbhaORoM5Gw/9n7fJbhth3WGjG0tF/Pp9epEF/KjoC7h1wj4imKoIvVAgbGRb6QRt3O1U0HQpxYuk8pZ7mMHCR4vX/P8gM+7elqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2waUYfDKFiTxiGMlXjvUeJo7Lome+phOjwhab4Ktsc=;
 b=b61Rib80J9KTLg63h96uNdtwyY0KsstCANm+4rPRIdL0ZGFnyggsOWsCyAqBR05D4UsmR2GBSj2ybE4nZXneOuD9cmVZHwR0IQPsh8fxoj4hT2s9Z9i/FXJiyxGxlZgnicybT5HHZfi7HNxHEdsX92YpB9VXnNZC3WaNkKjZD/nJYJ3WEorP4FexzsPyUBJixXQ8ksnlrl0xsiF0izhrGxLppotvBfM94SAiGFKYCYn4r2mPchjv/2adDas8UubhYpjzN1Znrr3aGPuFa+G7F/UZ1sIFmdYUsfs3Ak92d0flSh1xZcvrYoN7VavlDqAVW2efZ2T829P6+Un+m0+/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2waUYfDKFiTxiGMlXjvUeJo7Lome+phOjwhab4Ktsc=;
 b=GUBoPMx/+dMbby2ItlOwYpCQ2A6KtwPhCVCTGigI4Kdu31ECkjsUv1AykGWKAFFQWFu0efhGGom2XAns9FUVc13CxYmashG5hR65Et0AGtP3o6bA/C/N3JfxqyG0wJlM2/qFqbaqTh8IhzD0rskQBuPEoS5KRKsjmAgeY2aZNag=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CH9PR12MB721654.namprd12.prod.outlook.com
 (2603:10b6:610:339::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 17:00:24 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 17:00:23 +0000
Message-ID: <2e54259c-4ad2-4591-8c4d-f10727dfd4c1@amd.com>
Date: Tue, 20 Oct 2026 13:00:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Downgrade mmap lock in SVM restore work
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261020163116.1069749-1-Philip.Yang@amd.com>
 <20261020163116.1069749-2-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261020163116.1069749-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::23) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CH9PR12MB721654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3836d3-ba3b-4c6e-66c1-08df2ecba126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: lwTHVV1u9RzeIVQWYw7loY+tteC7WkaiZ3vRA9++RUn438zoLyRPHIu4BTdRJCpAxpI5bM+6rZ53ooJvXbi5vNQqOtkvccCKvyCmdiV3dEC+3tMd0AsAIrKJdoz4O8Me4MG//1M7ngLHFpRjlfLqWoZJ1OVRrrEucC43ZiZvxWFGqsL4P5CaswT44pwlmXeBxnhdnkbdPk9pWGsYsy9yXVXGYSimvKfsobwiTEh+cMwVteQjVgjQuHvkrC6bnGqO0kjN5xEdKAa6J4IY4HADe4b4cm3+sfb0439iRrJIiFerrG5wQ4Pha1NXh0ffhg+5NisC9yJ8dhE36wzylIBNGezPQ6pstu2oGZeKk9H/FyogFLdh9zGHVFYMsqrs35CJPwXnLLmJfJeqefeQfpUKtbVVg3C6AgWhA9A0KxG+KNx92+Ze/pohhKoiUNbYGHs1NfQMW+3oZZuKJfTi2vpSLZgl76teItNATuk7fpHRG9haUbApn4Rgd24kwAcR+6G+RAM20S2Tzf9s0YJ/LScATCZkQtE8FWJQrjXZTGYS/L/L/s0pIh8FSOMcVGQmtoczVTl2orXuF5JnWyhqEfRaytHfAvqgCRDNHz3U9J+A7gG+s1jI7Q1AKIg44Gu/9jFclknr2goWeQJ6gOXGZQMvkyX8mY6q3xQvNDpA8Z/SBx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhXanBuOHR1N2pGWitMUW50VGdVYnFTSVVqNXdPaCtPa042M0p6M3kxNVVP?=
 =?utf-8?B?Z3cyWDVyUXRpNksrTDdxMXg2MlcvK1lvNkU2QlBXWEtBN1ErMGJIQ0Y2ajJw?=
 =?utf-8?B?bVVrUXhNM3BJNlVPYndXYmxzcE1JVTZFMjNTbXNsL2lxbmdNMzhKZWJHKy90?=
 =?utf-8?B?SUlXRmRLQTA0MHk3QW9SR3I2cjQ4NFNkSkl3RDd4Z2VGMjUzbnlGOXV0ZEVt?=
 =?utf-8?B?RmJHcVZDYTZCaWNEQVMreVN6aGRBOXcvcURrSFhacGR3akwybGZPVEtoQU9C?=
 =?utf-8?B?bnZvTXhqSHJTU2xqcE5EV3hoQ20veWNVcENBRmQwNUYrd2JMWUtFMEFPK2Qx?=
 =?utf-8?B?K3ZnY2Yya3ErbkpYSEVmdndPVHRDdkRyaEJ3K2xpbmFDVSs3WDdRSmlpVzFi?=
 =?utf-8?B?Rk52RG1kU2xPM2xiOEdQZDcvamtIVEdubVN6dnprS0Y3bzNSMHZ2OENlTzVI?=
 =?utf-8?B?a3FHU1ZESFJVMWdLSVdaVXYvYzVCYlh2akNtL0h2anVzUnNRMFV5NXJTTDFK?=
 =?utf-8?B?QmVZRjUzbjAvS0o4U0Y4VU1ETnZnbExGaHVvY04vczB5UDF2dDhXNlUzNW1k?=
 =?utf-8?B?WFUvbkRSYTRQeldmdmtmMmJGaS9DNnFtSGZwQ24yQm9NL1NHaTlMUUgwMncx?=
 =?utf-8?B?UUR6VTArZFFaWWMrM0tudVI1R1l3Nlcxck5pWVllUTVtdU5iNDJDL3J0U1N4?=
 =?utf-8?B?SWJLcWdyb2JhMjBrQTMvMnhVZGZ1ZkdtOWk1a2VnaTA1d0VUSjQyeCt6RFV4?=
 =?utf-8?B?RzJzV3NJcTJuK0RhZVZuWUhNbC9pTHV6MnE5eVZJbjBJY0laKzJyRU9WbjZX?=
 =?utf-8?B?ZUlOd1habkNoR0hnMWJRcUtLbzFKKzJSSUdoZnp1dGdiSG1ZMVlJT0FDOVow?=
 =?utf-8?B?VmlnTTBjSlZNMlFxVUtROXpoRStqZFM1dUIwVDNVYUl0VGdBbkptQk1EK3E4?=
 =?utf-8?B?UjRhbkdxYXFYdGY4em0rMGJkalVhY1NkSnJ0NURuOXVURFBQTy9oMmFSUXBq?=
 =?utf-8?B?SlpoQmZpQTFBeWx1WFhKOENUb1dXaEc1SmpmbG9FOGNTRUZEM2NmclJmcFJI?=
 =?utf-8?B?RUpzWGwvZDE1WXNFa3ZYd3JhYnN5WmNOaElBb0NFdjgzcVFpRXA5MEhXSGNw?=
 =?utf-8?B?c0FOSGFhdmsxTTVPQ3hSSEFENmFBMzRsTDVYZTdXclN1M21keG1PeWt2emF0?=
 =?utf-8?B?VEpXSzBKTSs3ZzNmN1JFZ2dIYklYUG9lWWFlbVcvS0cwUU5MbzAwcHpjSmFD?=
 =?utf-8?B?MERzVWlRUE10TjU0WlJOMUpTRHFvWEw0OUdaTGlOU3pLOGNxUFNFb2RwRmdE?=
 =?utf-8?B?RGdubDRoQ2JhMFovN0pXOGp3RVR6RWw4OGNaVmxaMm9HS2dkQlJ1VFNUcTVI?=
 =?utf-8?B?S3RRSWNPcHEvR0xKQmxPVXg1NmQ0TXl3TVlkNkFFRVRteEsyQUx2b2ZhaVFV?=
 =?utf-8?B?SmhRN3dET29EUG42cG96SEZBOXdUQkNhSDRDRWwzZHZZN2RNKytpNlJCV3Iw?=
 =?utf-8?B?RFpTOEdjYkxjR0J5R1ByUE1YMjVFOS9yKzVqd1dVN1o5dXA5ZDJFdkYrWVE3?=
 =?utf-8?B?WGxaSWNaemhyVll1TjJvVkZ1VFh6VEFZMi9YSW93MExmTndxeGFPSS9MZUZi?=
 =?utf-8?B?elVaL0tvdXBQeVlEM1g1bVVSemY3RkxWRi82L2oxRFo4RlkwSGZWa3dMdXlR?=
 =?utf-8?B?UjA2MVA5R1VwdHFuaU1sT051ZFlwQjZlcjVOY1NIUC9wMkE1dmN6NjBOZ3Ex?=
 =?utf-8?B?TE9PeFRKQ1NIei84Nk40RnA0YmtiVEczbDVEMlYvcXVrQmh0UFprWmpFZmhR?=
 =?utf-8?B?TENXdDlEQk53QkZHSU1LWkZDaTVEOUxEMkVZLzI3NHluZE9lVWsvamxRRkpD?=
 =?utf-8?B?M1hyekZjZWRxa1dEeTNLc3U4OHVDUWVPaXNXNzRrdHV5cDh6UkNDM1NaMytt?=
 =?utf-8?B?cytnZ09GWTMyUWV2NHJ3eG5SRHlhcWN4MUZRREErRnhJNVJSQ3VYbFowelpK?=
 =?utf-8?B?Q2hITEdGbVI0SjZsM29xRkg5b0VBdklmRjZnajBIbXorTFVjSW4wWEozb2tx?=
 =?utf-8?B?dEo5OVR1S0hsNVlBcUJWdlY3bFB6SVJ5RmJwVGZoSDIzQjRUWjA3QTRDdmJ1?=
 =?utf-8?B?dlU4eTh5VkM1am8yMlNTc1ROM1Y4RTFWa2phK2hETnQ2K3lyRGNTZzJJMVhT?=
 =?utf-8?B?cHBMUUJMUEFTQXZ1am01QmtqRVQ5UHZWQ2tDS3B4R3RvSGo4YStlRWFOMTls?=
 =?utf-8?B?cWg0Tk56akhFWXBydDFzUFpxWGxoZ08wTnZyS0RuVkZ2aWdWanViczlRSXJk?=
 =?utf-8?B?WDhoOUE1Y3FCTEx0NXZxL21WbDdtYWVWM1MvMkxtQjhOd0EzUnJxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3836d3-ba3b-4c6e-66c1-08df2ecba126
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:00:22.8708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2yA/ozOW89Gwomqv52mQZ/b4W5P4TBFUrmufm378BN4Pv8jpr9/fV2Dfyv/6nN5DZaqc8fILOoDnplyx6AeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB721654
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 12:31, Philip Yang wrote:
> svm_range_restore_work holds the mmap write lock across the entire loop
> validating and mapping every invalid range, which blocks all mmap,
> munmap and page fault activity of the process, not only the KFD paths
> waiting for the same locks.
>
> Only the deferred work flush handshake in
> svm_range_list_lock_and_flush_work needs the write lock.
> svm_range_validate_and_map runs under the read lock, as
> svm_range_set_attr already does after its mmap_write_downgrade. The
> flush stays valid because svm_range_deferred_list_work takes the write
> lock, so it cannot run while the read lock is held.
>
> Downgrade the mmap lock before walking the range list.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 28b687133cf8..f63bd8cf4174 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1987,6 +1987,10 @@ static void svm_range_restore_work(struct work_struct *work)
>   
>   	mutex_lock(&process_info->lock);
>   	svm_range_list_lock_and_flush_work(svms, mm);
> +	/* Validate and map needs the read lock only, and deferred list work
> +	 * takes the write lock, so the flush above stays valid.
> +	 */
> +	mmap_write_downgrade(mm);
>   	mutex_lock(&svms->lock);
>   
>   	evicted_ranges = atomic_read(&svms->evicted_ranges);
> @@ -2045,7 +2049,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   					       AMDGPU_SVM_RANGE_RESTORE_DELAY_MAX_MS);
>   
>   	mutex_unlock(&svms->lock);
> -	mmap_write_unlock(mm);
> +	mmap_read_unlock(mm);
>   	mutex_unlock(&process_info->lock);
>   
>   	/* If validation failed, reschedule another attempt */
