Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE812C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 22:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388B210EFDA;
	Thu,  2 May 2024 22:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cf6urgKG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104F510EFDA
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 22:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+OioYXXO59QPi5mV1CPV+US5+BoJjcG5sm9uSNJDDh8BksZxWAEOUy6dQWmE4pAgrpe+0vDwIVILNakyE1KlWZiyx4B1HIEAgCXVGNzsPCg7haNBmPH1sPAdVqUKQJC6NWx3S7dwxTXjRfSGK7M2P/FVDo3n67asvL0K5q4UtZVji+PKnt1V9KE5HWodidTQ/iCZxgCLtLoLigB/XaxvKl2vautyh90hy99bNqmk7p0ya/2W4K3gZUUReF63iJyCx5Pm6BGOxCCxgJHm6dbNJno6QhB1E5a9rz02hbhUBG8fZk5z6BBdZRNTbwI+8YJ4jBSLEA109h9eQ4uuFAiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ghqmyj5kQ+4D3Bidi9P7FbQMh9YA1+U2/KNMJCAHQvA=;
 b=dVRNV0eGFppbhWhODkp7qH4o59z43HbtaEXq6g0Nyc6rL+JxqsNTUOd3rQ+cgX76FE/RDlDq/YATxkiMl/ajHvA8KSEn0qB2WU6aVAj2lmZhw1s8sL8XK3OdNhB2bqEL4o/dJK1iHys6WU3JNiB91+QIyWLmj2XzMsvSKlVT7po/FXXQ5Bwb+yLJedhCFJaQDhM9yXNcw9SI9h7ublFbXnQe4mt476V8Wby/EM8Fh2ksia2Nhs5oG/fi7Hbgo0Ue1G/eLc3qrRkFJNonI/mhODgdJM07b2vStNDMVyEhk+u5ObK5+fqVf5jBKuxZadAn9ViSF5C9OnP35B0xx1o5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghqmyj5kQ+4D3Bidi9P7FbQMh9YA1+U2/KNMJCAHQvA=;
 b=cf6urgKGSmSqyKbNY6xyfKDdhpdi5TYUapDtsUToPRi+u3gYazL1CjGTqBQcU+R6smML9lvT8PfOayRB9/89fcM/nDmSFDNkbWrGQ63PtQET8OeRGkeXJhuu7a07HpJxPcFS50/LHa9e31SHuB7ki3SLV7wSiQydrlvJnj8ArJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 22:01:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 22:01:12 +0000
Message-ID: <fb039c69-df71-4dc3-ae89-41b19f4eed97@amd.com>
Date: Thu, 2 May 2024 18:01:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Reduce mem_type to domain double
 indirection
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240429164707.49196-2-tursulin@igalia.com>
 <20240430171636.61526-1-tursulin@igalia.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240430171636.61526-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 607de6c2-2ce4-4584-606f-08dc6af36124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUZGSmdwaE5tZGpUR2VUTDlZYTVTVkZvcWVETCtSR24zWUpsUkY5bVJmdWdF?=
 =?utf-8?B?YVVGa0V2VEc5WHJnci9Ia3hoeC9qOC9Ia21Wa1VoR3VSVUVQVHJMYWcrNXc3?=
 =?utf-8?B?dngxT2NzNFJ1a1RLVjZ1NytpcUhpdld4Q0tXRUl2NmFWN2V5ZHAwT3UybC9R?=
 =?utf-8?B?aENLSmFuZE4vSGhtM3o4T0lxTy83YmhlaFZGTXdyK2RNSDNWQ0U0YlJoYnMx?=
 =?utf-8?B?OEZuNnFpbnFuYjM5a1BwY3luTDdDaktaa0VwSCtBdXVkdVh3WklBdXBRSUFr?=
 =?utf-8?B?Mm5YazUxbVJNbFdHSmpJaHp2Z2dmeVB5R2JMUFNFZyt0NENMTDFkeUFtNTRu?=
 =?utf-8?B?b1RqSXM2SFNOb2xKMzNCUVpHVUczY2haRFpTS29ZeDBKSEhvUld5bHc4UGZJ?=
 =?utf-8?B?ME9BWVN0NDVBQllIZmYva3lFSjhUcDVuTXNLQlVzd0JuZmFPTzJneTQwUllu?=
 =?utf-8?B?dElHQVZycnQ5VU9JUVgvaXl4YTZ0ZHBYTEI5RUhFaTJvYW5QcERGSElrVU83?=
 =?utf-8?B?NG5NbmJPVzJYN01JQStRQyt5QTgyVkZrS1k4QmhJd0Q4eld5Z0sxT1V4YlBN?=
 =?utf-8?B?ZGM3bWtJM2FWemprVlZpekgrWlhLZmloL2RYaUlad0lSRTAxRWFHS3B4bCsw?=
 =?utf-8?B?QWpZTUJ2cXp5OW50c2RZZ0Y2YzhXdUx4N3lROXFqU3pUYWFCcDhzcWNPMzhJ?=
 =?utf-8?B?cmVuZ3N0bTh1NWhhL2lEUHVaR0NvcTdQNGM1SStWVFIxbG4zZVNWd0VENVo2?=
 =?utf-8?B?cGRKWEdMaE5Ha0M2TGVmcThhZWQreGFRc1pCNmtob3NNek51Q21oTm9Td3Bm?=
 =?utf-8?B?NjdZTUNvVUJWNkMwK2s2U1Rjb0I3aXJkcWpoT3I3dHBGb1lUSW5LVjFwZVpN?=
 =?utf-8?B?Rzc1ekorQitNYUlSWFhaMVlrd2RNeEQ3dmN4TlB3K1VrWWRtY1FvQkFsQmtY?=
 =?utf-8?B?eHFTVHJMZW4wa3Y5T292NEt1WDlNOXRZU2RtTmlpcEdjZUtDMm4xR1VwMGVR?=
 =?utf-8?B?Um85UkRzS1NEMnBRdGpmTE1SNXFkZjBjbzBUT0lQLzkrTHl1QXhnYzhFY3FQ?=
 =?utf-8?B?dDArajMrVnlHWXFCcmNMSGhoRzQwRmlFekVXWTI1aCtiQ1h0V0NvV0NXNHdz?=
 =?utf-8?B?enkyM2thUUpVRXJNb1U1UHdDSGlpSGR4dWg5RVhTd0JFdE1GRmZOQXhWZ1Bw?=
 =?utf-8?B?TkZwZ05qWlZHWXhiNzR4aU15V0JxYTNOSXNzaU5QN0xmbWlYcUVvRHRRUlUw?=
 =?utf-8?B?clFmTUo2YkcwMDBsTENGaTFBQWFTKzRlS0tEbFdUYWhKQVpZSEkycHF0WG9E?=
 =?utf-8?B?VWNWZ1BncUs3Y3JaYWd6RHR1bDdod3FidTdvSERoZUpZSVh1NDJaSUJrdkU3?=
 =?utf-8?B?MzgxLzNkWmlaQjkwTGQ5R04rdjZWeU81djkwcllPWG1UcFc0b0RoZlFoVjdV?=
 =?utf-8?B?Ri9PVllyeXJocjQ1b0lPeU9IUUNNNkwzUTZCQ1dBQkhFa1hJUjBsT0duY0dQ?=
 =?utf-8?B?eG1YV0VDdWtSLzJZTVY3OHl1bWNqYlg2amM4YitvbzQyTU4xUkNPNk1WbzQv?=
 =?utf-8?B?dzl6QTh6ZTdUVG1pSiswT2tzN3dldVh3dWY4bHhMYlRqQlhNV0xkTmJsYWtx?=
 =?utf-8?B?bFBTcDRobGMwVWdXbDBHWTR0dEs0WHFFNDBjbVRSeEJRVmprZWI2SjlmM0lt?=
 =?utf-8?B?aVF2MjNWKzJTN3Z0RUhiaXZnUVIycmc4bnpRa1loRXVqZUtrVEVzOFdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkE1VWR5ODk5bmZWeG5pbERSS2c5ckE0VEhubnB0bVhwY3B0eVRQcEV0UWpK?=
 =?utf-8?B?NThJMTRGSncwNnRIaG43bjZrMlZqWmhzYkxnT251MUtrMnowVFBoWm1maDBy?=
 =?utf-8?B?cXZNNUYvU0VoYURCR09ZeUNqMUtaU2lKM0hPcGZPZHlxQXU1ZFhiVkFtTThi?=
 =?utf-8?B?OGFXd21YaTkydFdURVk0Qk1Xd2RYdW9IUWVhZkQ5Q0dVaCtHc1dXMGI0VXFQ?=
 =?utf-8?B?Mlc4SG5RWnpzbXJadkdaa1BYdXF2Uzh2L0wxQjFCcnBjL2lWa243WXpCekto?=
 =?utf-8?B?Mkswdm0ySCt4V1lGL05nWUxyb094UE4yMndSclNPRm8wb3dNZ08ySGlPeTlY?=
 =?utf-8?B?STBXZmlpZnZxY0VJSlhDYVVqcTg0dVF2YWg3M0xTcGc1SURnSTBWWGJGMUU4?=
 =?utf-8?B?S1VxS3FIc3lIMUhwdFlBai8rR0VOZ0srakdnNXBxN2xwclhjb3dDSi85em9s?=
 =?utf-8?B?K1Jka1ZGMmRRdThUaG9vZEFFb1lYYVg3K2hmR2FoRnB0Z1hRVFVYRHFmZ3Na?=
 =?utf-8?B?NERzNjB5S1A2VnlqWVUrUFJnamJoM1JIOHBFK1BJUHdYZDJyS3FTWVltNU5S?=
 =?utf-8?B?UDFnMXFqZmdXdndPMGk4OGh1T2hwc3NERFVxNy92THNvNGJ1aEhLZzJ6bUVq?=
 =?utf-8?B?THowMHRzZWNTcTVyVnpiYmYwcUp6elNVVFoyNmFZYU9RZFM4NHB5UHdVOXk0?=
 =?utf-8?B?UEhYWFE1RURTMnlxNzAzWWVWUE9USHhjL1Q5L3V0aTlGN08yUXNQc0NuRXA5?=
 =?utf-8?B?RlNNWk9tOENhWDNlK2oxMGEvNE1FY0ZONEtLNE1ib2FGU09FNCtaUzRHQzU3?=
 =?utf-8?B?dVl3OWpFNTVaN2lweDd0SHIxOVRZaWUzVGw0THFPVm5iTDY0N0UzNFg0ZDhG?=
 =?utf-8?B?UmtWRFViK2hGNm9TQmswNnlSNlJkNHZQYk96cStsYVU4TW9SN0pGWCt2L0tx?=
 =?utf-8?B?cmIrYzg0RUhKdXJiaWhBUXJ1cWFVWE44UmxPeTJWcDBHenIyN0Z1SXlLYVoy?=
 =?utf-8?B?dUNFWlFjcGJFOHViMU9oSndmVTBmK3pYQU5DNUZVZEFxdEc3RDVYZUpQc1ds?=
 =?utf-8?B?cEZPeGJCS25hbFRPbzljbVh2SU1NUGRIMFhWVXZIZ25iSGVXV016Vk9qOVVN?=
 =?utf-8?B?b2EvUFNTTGNjVnZPYk1lcEVqRVZYenNCdkdBV3lGeXM1b2Qzd0V4NzI2L01m?=
 =?utf-8?B?dnR4NjVBd0M5REhoeUc5RitZNkVUMnlTT3ZzSXFUOUo2KzZCcjhVNzFXYlhz?=
 =?utf-8?B?L0RkRjFBR1RlY2gySUNSMm1aclZ4SEhyUEhrRXZrQXZXcWJUWms1UlVDckov?=
 =?utf-8?B?VUwvc01nbTlPR1hMSkFNdUFMcnlYZldseWpESVdWZnVMZ2hiM2lXYVIzK2xN?=
 =?utf-8?B?eTF2VHgvSEtnZmpNc3g0U25FOXVVcTNuTFFFMW5lSW93WE9yZEE5dHpTaTZv?=
 =?utf-8?B?SmVyR0FoSVF5MEdyN3R2dXVUVzYrMVJrR204QXZDYVpUSjFwMkVBTUhyM3dW?=
 =?utf-8?B?SDNkdzRNQXNHbDEyWTNyMnlBd2NNWERIYTVoUXRPWW4yTGs3Q0U0cjBRcXBX?=
 =?utf-8?B?WXNoS2hwWXZFYXhXeTZidS96NlM3cHZ4VXR4czk0a2lZdjdPaGFrZzAxMm0x?=
 =?utf-8?B?ekJUdWxMWVZpSjZ1SGVTamdzaWx1VkNDVUFKUkw1eEx0a3d0QkFwN1FadG41?=
 =?utf-8?B?aEJpYngxYnlrSVJPeHJpVTFqZEo4Y0pkd3lZQ3pvbGFjOTE0TitoNHl3dThs?=
 =?utf-8?B?Q09aSzdhdXBBNzFJcE9sOVIwRXUzbEdEOGhRN3NWUkorTlFVenlXWUpuVFg3?=
 =?utf-8?B?VXhFRUpGT1ZvSnNxZkJRODVsOEFLS1dQd0ZaU1Rpb2hWQkV4eTZOcVp2bnB3?=
 =?utf-8?B?ZGRNV2t3NElMUnJEaVlXNi9nS1ZjbFI1RUZsU3ZOMDZhT1RMOGhTeVdOWDF1?=
 =?utf-8?B?cDNjem80MUUvc28zQ0dBMUJnQTRpWklLNWxaN2ZCMEpFUWQzc3NYUnZHczRZ?=
 =?utf-8?B?aWVMc2pkMjcyY3YyZzdWZnhjMTJIcWxtbjM2N29SWGpJNi9ZaXNCUG16Y0NS?=
 =?utf-8?B?YnNoVW4wbUxwaTZpY1Q1TzdTemNDRUZFMUdkQ1lYSkNBbVBmQ1ZGQVE0TzJG?=
 =?utf-8?Q?THJhHkN+siuTqcF1W/7WG2G0E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607de6c2-2ce4-4584-606f-08dc6af36124
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 22:01:12.0409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkFXo1RKNa2gIXIpbRWx85/IBE4e+YvxLN6L1pWhfRdqZHUNzYUs3AoBosvZ4zQxOr+fQlemT4BezqotzoWcFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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


On 2024-04-30 13:16, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> All apart from AMDGPU_GEM_DOMAIN_GTT memory domains map 1:1 to TTM
> placements. And the former be either AMDGPU_PL_PREEMPT or TTM_PL_TT,
> depending on AMDGPU_GEM_CREATE_PREEMPTIBLE.
>
> Simplify a few places in the code which convert the TTM placement into
> a domain by checking against the current placement directly.
>
> In the conversion AMDGPU_PL_PREEMPT either does not have to be handled
> because amdgpu_mem_type_to_domain() cannot return that value anyway.
>
> v2:
>   * Remove AMDGPU_PL_PREEMPT handling.
>
> v3:
>   * Rebase.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reviewed-by: Christian König <christian.koenig@amd.com> # v1
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com> # v2

I'm waiting for Christian to review patches 1 and 3. Then I can apply 
the whole series.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 29 +++++++++------------
>   2 files changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 055ba2ea4c12..0b3b10d21952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -165,8 +165,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		if (r)
>   			return ERR_PTR(r);
>   
> -	} else if (!(amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) &
> -		     AMDGPU_GEM_DOMAIN_GTT)) {
> +	} else if (bo->tbo.resource->mem_type != TTM_PL_TT) {
>   		return ERR_PTR(-EBUSY);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index b2a83c802bbd..c581e4952cbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -983,12 +983,11 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   
>   	ttm_bo_pin(&bo->tbo);
>   
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -	if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
> +	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
>   		atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
>   			     &adev->visible_pin_size);
> -	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
> +	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>   	}
>   
> @@ -1289,7 +1288,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   	struct ttm_resource *res = bo->tbo.resource;
>   	uint64_t size = amdgpu_bo_size(bo);
>   	struct drm_gem_object *obj;
> -	unsigned int domain;
>   	bool shared;
>   
>   	/* Abort if the BO doesn't currently have a backing store */
> @@ -1299,21 +1297,20 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   	obj = &bo->tbo.base;
>   	shared = drm_gem_object_is_shared_for_memory_stats(obj);
>   
> -	domain = amdgpu_mem_type_to_domain(res->mem_type);
> -	switch (domain) {
> -	case AMDGPU_GEM_DOMAIN_VRAM:
> +	switch (res->mem_type) {
> +	case TTM_PL_VRAM:
>   		stats->vram += size;
> -		if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
> +		if (amdgpu_res_cpu_visible(adev, res))
>   			stats->visible_vram += size;
>   		if (shared)
>   			stats->vram_shared += size;
>   		break;
> -	case AMDGPU_GEM_DOMAIN_GTT:
> +	case TTM_PL_TT:
>   		stats->gtt += size;
>   		if (shared)
>   			stats->gtt_shared += size;
>   		break;
> -	case AMDGPU_GEM_DOMAIN_CPU:
> +	case TTM_PL_SYSTEM:
>   	default:
>   		stats->cpu += size;
>   		if (shared)
> @@ -1326,7 +1323,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   			stats->requested_visible_vram += size;
>   
> -		if (domain != AMDGPU_GEM_DOMAIN_VRAM) {
> +		if (res->mem_type != TTM_PL_VRAM) {
>   			stats->evicted_vram += size;
>   			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   				stats->evicted_visible_vram += size;
> @@ -1600,20 +1597,18 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	u64 size;
>   
>   	if (dma_resv_trylock(bo->tbo.base.resv)) {
> -		unsigned int domain;
>   
> -		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -		switch (domain) {
> -		case AMDGPU_GEM_DOMAIN_VRAM:
> +		switch (bo->tbo.resource->mem_type) {
> +		case TTM_PL_VRAM:
>   			if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
>   				placement = "VRAM VISIBLE";
>   			else
>   				placement = "VRAM";
>   			break;
> -		case AMDGPU_GEM_DOMAIN_GTT:
> +		case TTM_PL_TT:
>   			placement = "GTT";
>   			break;
> -		case AMDGPU_GEM_DOMAIN_CPU:
> +		case TTM_PL_SYSTEM:
>   		default:
>   			placement = "CPU";
>   			break;
