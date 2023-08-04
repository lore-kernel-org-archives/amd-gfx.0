Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CDDC001DF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 16:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C66B10E735;
	Fri,  4 Aug 2023 16:26:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40BA10E735
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 16:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZVi8MZ61AjnZFaW3s5EFpJtGOKSnjRDVmd3zmriUBNR+4184damPqWtut7HINDCyyz5R2sA8Z9LNQyOUbfAwuomh8ZpvZgJqUQNHDV7mFuhCDLXVqhpZ7Z2+IoFc7kERii0ulwY3j3z/Vuw9Y2KZDCYqwZN8MLu0lEVgt61AEgP/px/boV47tceoNlmEm/Yyg1nQXFCchG7jN1jR9qIZc0vklopWwHP9Q1/9rOxyr/hG7P+eqm5+LTeKTTg3p0mIJC6dMhDHQpVas/U6RYXea8cd81MfMvSs65x0B3u1arwU+bX8iKyjT06ifKcNuAR6aq79f9Eza53MBwTPvei9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvUwQ9Pe4ERF1bQIFno277XMtuBrbmiMmopcxHFmcTs=;
 b=kTBT9EvzmY4VbmqFr3YUhAbgcD8DhUfH1coq4dmP5pOH/77/KOlkSr6BZaooa2XXGJecoPUtoxpGgZZLRjWaE/QaBP+AoC+zWcP/hFKktIbDAXX+mWWnXWHmF2SiiIO2IrmTwzmNrLYJ7Gz0j6XAFIm3TJLJNmvXZ8hEWACvPedd6jySVWdkHnc8W5J+LqJ/6cOh1ensXccgXacgTOFqbXRyl3IViPDO2wGGN7kYpQbZrAEiqMBOcwavhdZwccL4uMrai315dSLjwYEt/TFXT+/fKiqNmI76MH4iVzrTinFAWPIzX/JA5coLsd/a1kBkfpoe6UT31mUyYTh5tIzLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvUwQ9Pe4ERF1bQIFno277XMtuBrbmiMmopcxHFmcTs=;
 b=os+y8SP1p2t2O8OYdn2uPCfEntxRajvld9Qr4a8M0lIo62Fjfu36kL3ZgXpqUgOwKKTH1y7kqtAvhT202gUL4tiXPWGWy+qR2QFhEnG6OdIMRcTerH/fEGmlPVrn1KnWwDiDFOec0rQes6QGSbmVlA987Yw7D/3TDLEfI5SJd2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 16:26:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 16:26:37 +0000
Message-ID: <3a158e99-3415-590f-8543-865b0a67253b@amd.com>
Date: Fri, 4 Aug 2023 12:26:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdkfd: wrap dynamic debug call with
 CONFIG_DYNAMIC_DEBUG_CORE
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230804160545.28868-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230804160545.28868-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 233b14ca-b362-4351-7155-08db9507930c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AS1jsT6eXiXHvyimOXrfBrqJGimZMpD08emQBbhHmSiAdySbOafhCmVbgYLBki9/c3yWJGAb5rGtaN8p2aWWhEvyurpZ+GGTLtrQAKWUNcatfDREF2OB+xXt0b07E+nX0dvvEv52+z0DDBSyPRWd44iMpRWeJrgO2s/MgU7+EEIbttJCeDB8iRldwpJc+Oc0Y+Nm6UHdhf77nJZIWuyifoMAZTxbLAcdBW1+7aeJTSA90PMq4KtR56heFeewmfviObbvJDXTkhwGUMjoJpwvyoAlATFlCNKpOlBIcsWLpRaRTN9oaAun9BNcniNhTuhwbo4fmA5sJ0q4qtrmyBaf+4Imjlb/BxY4dHPJOwBX5hYFWUBRBJLIaKdfWaLFO1CFHdY35RA25YeDCQujH0Dlcp94DslkY2IMZ4QIy+SdQ7l78ysv9ZsQhOugZn+E9Bj/7lRm7t4uqR7VkRAxPlSB4a2bemr2OaSvS9jRwRQEaEjKD41j7PLPFsbTnm4stZv+RU//JhbZPaGcW4Z3Ydv9S5rhye/yqVH7HqM2au0o8ujWZkN6oDnddxvrSqQcyGjrPdwJUbSYAygZvUQ09mDOcMRemTLoLQsiAncmffxKHtFEyJivvk9yScNMam9BntLtwz0he8xUQAaZ62Befm+FsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(186006)(1800799003)(6666004)(6486002)(6512007)(86362001)(31696002)(6506007)(26005)(36756003)(2616005)(53546011)(83380400001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(31686004)(4326008)(2906002)(66556008)(66476007)(66946007)(316002)(478600001)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3BuSnYxK0gzWW5zN2hkV2U3WG9MUGJwejhHZE5WdGxrOHhEV2srL3k4YUFs?=
 =?utf-8?B?VFVYeHJjcGFiNDFyNEM2RVIybEJqbEdPQUkyejVieU5vNzhlUDF3aWprdTJk?=
 =?utf-8?B?OFZ2NWJFcXFGZlVJVXhVeUgrb2xjNHUwZlRKL2xnbnJVR0JZZnNUS0podVFZ?=
 =?utf-8?B?dDFEQjJWNll3VS9pQ1ZxY2dhdHhZZU5mayt5NThveUVXK3o5OHVBSTlFUXRP?=
 =?utf-8?B?cnlSOWpkWnFHL2hCNjRBZnVtZ0xoejVKdmQwQXc5OGxLOG02R1N4RWNBeG9w?=
 =?utf-8?B?U1FOZG1rMU1mUHZBMUJ3eklpd1B0MTRvOHgySHZzQWJGYnkvWmlvUzg5cVF2?=
 =?utf-8?B?VmYzU3E1bTdNRkF3NlBrS1lvZ3VoUGZ0ZjhFcUV3WkFOckpzVVUrTjRQZ1J1?=
 =?utf-8?B?UkVSb29QSGRETUdabWhSVUxBbzBuUCttWTM1dWhMdFpMaExtbTVXN1ByTjhs?=
 =?utf-8?B?K25RbnVhRHhRTzJDR1IrRXZtVXMrWVNuOGNrS001a3pTU2xIaUlFV3VYV296?=
 =?utf-8?B?VXhsRDVjcDR6RGVCMDZSZHEzMU1rVWZ6WTFCZlZ2ckwvanBQU3o5Z3JqODdp?=
 =?utf-8?B?V1AzYzZlOUFPVVdnNkhEa2IyQ3VhTUgvZm9ueVNMRzBJbytuMWMydlRyQ2xB?=
 =?utf-8?B?QTJZTmJLczhHN0ZmbGp1cTR4cjFZQTQwT1Rlb0kzVkdHT25KOTYvMmp0SGdX?=
 =?utf-8?B?dnBIUVhRdG1Ua3JJUE1aZDZvbVdkbjBLUHlFVXB0TEZnUWtIaXJXMjhLUkRV?=
 =?utf-8?B?SWRaUFV2c3puMmJpUkZsNHdiVi9yaXNWTG5tcDdjWGZPWVRNN29QTUhZUzBj?=
 =?utf-8?B?KzVpaDU5ZmpJSnVQeDd0T3FIeFlKdGMzbHhtVThUNXpZRi9xeUtQanhQV2lO?=
 =?utf-8?B?QkdoRzllbU1mc1FHMk1CMWNLbWl3ZDdLOW9STFQxdXRTbXBsbW1rL3J6UGZG?=
 =?utf-8?B?NGUvR3BjMXl2Vkl5T2lpekowZUZYQktOSE9LSGVIZTAzbENOK2g0MVVNVVNh?=
 =?utf-8?B?ZEtGMUdNWnB4Tnk1NU0yY0NTdlNCdDQ3Zzhub0F4QjREMmNLQWlpelFUeGMw?=
 =?utf-8?B?UzJQRUx4bjY0VUMyT2VqNTVlZFY4Qzg2dnZzWEtxbFhZN3FBVUJybXM3U0Rx?=
 =?utf-8?B?Q0FkNVZKbWg0NUdHeVpOSktzRVFqTm9JKzNEUWNyTkZJYmVpTTFpU044OStv?=
 =?utf-8?B?bEJXSjduVXdta3NBL0JVWU13UkNabE5VTElHZngvTTFPUWdlaWJzN0FzbXhq?=
 =?utf-8?B?RklEbXNjSEUrOWtQQ0QrUmhXbnRLMzZhVmVDYnVBSE5yY3d3VmhVUWVUNE9Z?=
 =?utf-8?B?bXg5aCtTeWhMZGVES0c2SmJiUmIwcUlIOE8yRlNxTjVmcEVhaWQzRU1iRGhS?=
 =?utf-8?B?M0lETDErSVJpOGM2RVc5WmhnL25zNWZnNTNyZHhvbUJmd0N1RkdqQzFTdUR2?=
 =?utf-8?B?ZnRtaWlrbE5GVStlQUxkQlJ2eE5XNXVqM2djSjg1ZHB2ZThoaGZpUzh1NytE?=
 =?utf-8?B?OTEwVmhQcytEektNZG5oVjZPQjBLMU94aThpOHNjVno4eFlMSkFGYWcyZE1i?=
 =?utf-8?B?dnRRVjB6T3R4clBoTWgybWxNUU0wUFBIcjNQc2hzK2JmY0ZZT05Fd1N0c2xG?=
 =?utf-8?B?TkV6VUU0SnZLbkppWUZGS0txc1QvbUE4UmhlQVZwOUo4T2lsMTZIa1lKSGl5?=
 =?utf-8?B?bThyZUlNS3lDT0hVVnpnVzQ5QTZ4TFNrVWdQdHFaRHYwWEg4QkRSL1hSenlZ?=
 =?utf-8?B?RnY0WkoyUHo4K0ZpL21XQ1VjYnNXdHJxMkF6VC9WZ3ZqR05FNkNQbGhrUXI3?=
 =?utf-8?B?NVl6aUtrV3FiYkNvazRyeXl4b09rSllvWTFDTis4U2xFa0hGN0IycDVQRnBQ?=
 =?utf-8?B?ODlDSWtKbTdQVzRDOTdKTFZiMzBLdFNMYzFaMXhxVDBsbGhaYmRjQ2lRK1FF?=
 =?utf-8?B?S3QzNEdaZnhseXE3bU15RHVJZzNSUUZmd25WSEZkOHJOQUFDR2trTzJvZldh?=
 =?utf-8?B?SERGSVNhOVZ1bUVPNm40SWs4RDRSc1VNejVHYzQrd1l4Mi9lNnVWUU9SUnZk?=
 =?utf-8?B?ektvL0s5dU1XSzBsWDlFUEFValI1Q3gvelY4Zml1NnhjNUpZR3RUeEt1VGto?=
 =?utf-8?Q?jI0SD2X2UX4VVpTdCZ19VVt6c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233b14ca-b362-4351-7155-08db9507930c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:26:37.0418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 361PDLj3LOj7MucliimnWL3o5I3Sv+vzPniThMQCs3HfnD1BLziEEAz8KJb2IR3Wrj1reDwjcE44l7fpZToWcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
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
Cc: mike@fireburn.co.uk, Arnd Bergmann <arnd@arndb.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I just applied Arnd Bergmann's patch "drm/amdkfd: fix build failure 
without CONFIG_DYNAMIC_DEBUG". This patch is no longer needed.

Regards,
   Felix

On 2023-08-04 12:05, Alex Sierra wrote:
> This causes error compilation if CONFIG_DYNAMIC_DEBUG_CORE is not
> defined.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index a69994ff1c2f..cde4cc6afa83 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -824,6 +824,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
>    *
>    * Context: The caller must hold svms->lock
>    */
> +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
>   static void svm_range_debug_dump(struct svm_range_list *svms)
>   {
>   	struct interval_tree_node *node;
> @@ -851,6 +852,7 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
>   		node = interval_tree_iter_next(node, 0, ~0ULL);
>   	}
>   }
> +#endif
>   
>   static void *
>   svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
> @@ -3594,7 +3596,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			break;
>   	}
>   
> +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
>   	dynamic_svm_range_dump(svms);
> +#endif
>   
>   	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
