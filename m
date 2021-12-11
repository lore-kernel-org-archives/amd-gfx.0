Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34091C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Dec 2021 01:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC2C10E697;
	Sat, 11 Dec 2021 01:11:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4A710E697
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Dec 2021 01:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE/SwdQ2YV7Km4Plj1IZm7/ToEINrVPuC10UgQEs/BIyUcbOh3/nwgNEaOYMvsqjrJLnRQV2udzNoigWWJFUND8+FnlvD4pwSdgCoTdsyvSAhpZrEAjK4QQhMO7UCxT1I0w8NWZaRzNUTEOMgHHRBtbp2z18uZAX1fuwpyZu41vI1dg0A0y1JrWKESKQG+5HaDMOMcqlG69McarfWMe0MTn3Av9/UX7D247gB6QFl+dH3DceN/mHsc2DAKzYdxYE2giNBY53/9tkM8m++Bz6Dea/UvYzIbN17Iv/RJ40D6IXXpZsusHaMnfL/4HuPpQZ9pr55++ijbQwkBVm0Q+ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozNB3NT3/3h5rNFpr+N6AWLzhIt30KcFS9/G7ZIiEJ8=;
 b=jn3dWXMozwWPJhnMLvOLC4AgGHA2S7YY8GW3wTpmG9lc7w50OlnlWgFgwIzyplPS3JaoBExK0/Zo6GPGOUz2O2LqfvQNZe6tCRj46v2yTlUQU/ohjaY42lmJor5aKmKSacFjaD/gKh4DyGw8zXZhkX6aPnYLIsGJIZmwCsyfWrquEMSPTHidINLwBt7wNi2uWHS4PnXYFdvXNiwjYPO83TQF0YYv5KFdzci9tvAnNWID9G5oaZajlyvPlvVoDX2wtMTMuWodgjSpdg4iQbWS/VSSBLU8tD0d2ayE401iJF9BnfAqyIdFPbErvXk4JZ4SCgbqUFrPH2l3Fa9/Rw6e/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozNB3NT3/3h5rNFpr+N6AWLzhIt30KcFS9/G7ZIiEJ8=;
 b=cwQOkPWlz/gSlHXKRzVPtgrHVdUFWEr88B6DgHSBGeQKTkl0kYP6jE13YEIedtXFg+Zv6OO8qwndHCHWNeICmGrr/mjF+/oXFl6HTaDh3/hIlDtDhPvwlj4/ZKieoy0lVXyoCCKp0G9A9mx6NRB6wTxJM2/4MBS3vPrHqc/ZiKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Sat, 11 Dec
 2021 01:11:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Sat, 11 Dec 2021
 01:11:24 +0000
Subject: Re: [PATCH v2] drm/amdkfd: fix svm_bo release invalid wait context
 warning
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130201321.22190-1-Philip.Yang@amd.com>
 <20211209211841.3768-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <f7ea80d3-691a-974f-0367-c5a08094ae00@amd.com>
Date: Fri, 10 Dec 2021 20:11:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211209211841.3768-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Sat, 11 Dec 2021 01:11:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 323c3392-16e6-4f14-15e6-08d9bc43263b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5340:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53402083A9CE42ABDA58361D92729@BN9PR12MB5340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZjGcI8bYDFp7aiIj21xHxEjRE6fFf5oFX6QEvYGETBRb0RIbSx1VsJjeZI6gsRi+SJkuig5NGG5KjEH/b10h4ZnHiBoPYpTDiM2jup3bOa/SBvPgalWxZwYN7AsAtqwKQzuSil8yb4+2ewxp2/BgWA/DZ27oGgY4Di5IkO5r24beWVoZFzggvrVAl/lhry5qQcTt4ZXbmVM87n8yyUMqU1a8jgVcmdTsjZDSv+oGJf3FXxaEFo+rRfxLXGV+Gspjq7F5o1EWnApTGq2BnmbDObQhCG9QaKovSlTVUBZCqLFi4aIHCSmbTHi8D4ZNZGhRsR4fZCHUzJClicoqFUBGO11WGc7VHsHCbQgZg8Igb3aQmty55yrewU2tzPZm7SkFV+M8I0XYLXkjrmJsn53fua4AiQxcMvB4dacA6JXYjSOIB5+eCx08VkkZB/52hAJ+2MaJ+bBP0s54ohS5yi8xSbvfbaRPAhyWR/7ZSY/lRjIGnHegZng8DWHk0K8UYVaUUfVtLEIakqvCNRX16MBAWNJbzOh4IHoh/0YhdiEzCh73TD8ZxiSAabcPjnvtsNlnu4dqGZVIYWXPuBKQkvKJuH0RMfCIvywj7qIia/o2mkCqav1t+muXyhoBxpzVpNN34N1GgbgE1j0aLY44knYQpbDAaJqfeFQ+3M+AWnX8mKU3q/BOJUPyOH4zDbaKakBBB0ztSQsEpazNmA73hYzPiZrOdE8GFmreOSQ/hkDOFI9VDfoOACMq/LskeK88ICT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(8676002)(6486002)(2616005)(956004)(8936002)(36916002)(16576012)(508600001)(31696002)(2906002)(44832011)(83380400001)(66946007)(53546011)(316002)(5660300002)(26005)(38100700002)(186003)(86362001)(66476007)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ZvaDhCc25oQ1NCUzhyTGlZZ2hCaklVYU1VWFgyNGNGMWpyQVVIN1lmTlRP?=
 =?utf-8?B?RllpNkdIZVJtMVZJdFRkaGxjMlZhQzZIQjlWTUtBRitQMWlaQjNlWlN0YVNX?=
 =?utf-8?B?TlZ6M0lVUlJGR28zaFo2eExIa1hsQTBhV09jaklXNXh5aThMTnVWeno1VDky?=
 =?utf-8?B?N3RsOXdBUHdrdk5mNm5IMEw3WTAyVmVnUFF4bkVZS0ZlUWFRUlBVemZkVGFZ?=
 =?utf-8?B?bW9HUElzU0d3NjZQYlIxdlgxMG9ucy9nT1AzUXgvdStINlVlbW1rZ09DNnZV?=
 =?utf-8?B?aHA3S0NBWUNFclZsNDFLdkFuU2NnMUFkSENiVTVQM1VQbjZYOE1CODk4TVVG?=
 =?utf-8?B?NWxaeDF2aGRDaklIcytiT0xPOWNQNnpzTExlcUV4REZ5T0NEMnoyOU85c1Jy?=
 =?utf-8?B?SUcwazFzbGl1b0JpWHhBWDUrOTM1VlE5dk0rU2xjcjAxNVp2YjRvRFNmVERC?=
 =?utf-8?B?cDcxYlp4RXFRc1JQMUlQN0w5UVkvYXNDd2o4aU5aQWl1RW15TDF0SFJKanY3?=
 =?utf-8?B?dk5PVnBQblRQeDE4TWEvVVdoT0pMUXpqM1Y2anV1ZmNDQVJxUlF5ei8yMGVj?=
 =?utf-8?B?TlZycFI0c1o0dlk5ZEc5Q0FHRmdzeXl4eFRLVHJqemdDSmFyL1YwUWRDenJm?=
 =?utf-8?B?YjVvRThBNkhtbkVGeVFmNWtmSmY5U1ptVWpIL3ZIQzZXaXZIcFlrK2lYbHpH?=
 =?utf-8?B?bUFUc2VMSGxKS2JPelE3MXpyNitZVlBNWWUyd212bncyOTI3YVFuSWpmRFk1?=
 =?utf-8?B?Q1R2YmUybFhmRFZpTUNsZXVlVXpZalpzWkJZNjBtU01CL0dWczZVcUlaTFhU?=
 =?utf-8?B?ck8wYnMyT1lFMlV4aWNnU0QvcUxYNDZiQk1tVFRQbGtlaE0vVTRtZ3ovUjN6?=
 =?utf-8?B?c0phS1F0WmFzOVFnVS8vcGxGVEJxSmxmUkExbHQ5M3RvRXNmenZHdmpiVDV6?=
 =?utf-8?B?MHl1TkVpMXdFWHNWcHVrcmxMK1Q5b3F0TzdrZ2hhcUZ2bkViODhRSks4R2tm?=
 =?utf-8?B?Z29XeXk3QXFnUEVrc3dJL1c3V3NZdE84blRRbG1SZGUwTGdiS3Vzd3AyTE13?=
 =?utf-8?B?YlpDN0hFcWpNeTkxODFWSERpQ0Z5LzhBdDZZOTcxWkVYZlRBa0dUam8xMDVl?=
 =?utf-8?B?SHlpZ3JWbWRjSk1TcnM4b0NoeTFDbEJIY0JJaGRpU1BseEZobVdpbnFmMGQz?=
 =?utf-8?B?ejE3UXI4RkdRaDNRZlFIdk9xQUJvd0NzekRnTEdvekYyY1V0bTkyaHoxZ1Y0?=
 =?utf-8?B?Wms0TlBsc1dTR1d3SGRoekZoSW9SVk8zSW13T0g5UGlEWXJwZlk5SVV0aFhD?=
 =?utf-8?B?cllrOFVaWHJhbTQvYzIveFJoMmNZa1JRWnBpQ01CL3YwNUNvaEpyWm5YVlFB?=
 =?utf-8?B?eWEyQVJiYS9RVjViS3NXdjI4bjgwUzNyZG9BUG1NT1RKWGlhMzgxb0d4enhk?=
 =?utf-8?B?QVBKdlJYYUFoNGFtQWc5K1pTaUtEMkFweWhQMmxkUytha2JTY1h5bEdwaitZ?=
 =?utf-8?B?UmJxd3dzWlUvdEltUnFjMXlpK3c0Vk5zR253NFliSER1M3RxK2pkcUFsNVZG?=
 =?utf-8?B?SHBvL28wRlJFLzZQdm9hVlp4bVFuN09heEZFVUo1cktWd0FFcml6QnNYUTcw?=
 =?utf-8?B?QXRocXhnTkZFaHg4VGZGSEFpWE1EZ0R1SmJ6eHdCOWJ6MnhYU3FXVTN2ck9C?=
 =?utf-8?B?UzZMeFlqaVc5VnJyYVZLWDNpa1ZqUmo4M01xeXBBQ0JpRzJOUWlFbW5pc0VY?=
 =?utf-8?B?ODNBbk94Mk1CUWhwV0hkSVdsWFR0R3AwNVRhSkpoTW1JS0xCT2c0SForeDlK?=
 =?utf-8?B?eXgyZVBzR0dGOU05UDV5SGdCQnZBMkE1MmZFczk4YU4zMHdDVCtBR1B5dUJy?=
 =?utf-8?B?UDFubFVTNHp2QkRPbllxRlRMZjNxRktSRE42aWdqWmlJaHpmMFNldUJkRU55?=
 =?utf-8?B?VWdHYmxUazdzYmFJRjlHR0xQUGdRZTEvZEEvTGxuVEtUa0RQdXJEem93aTdt?=
 =?utf-8?B?WUlheTdKNGpZdTdXZ0JEajc5RWdJQVhZNVdzRVc2cUNLc21zcUI0RUxjREdX?=
 =?utf-8?B?U3RkbzQyUCtmaWNTL29vL1BGTzYzTkR5SjFFaHhSYTBTTHNwT2tERlFwWDBk?=
 =?utf-8?B?ZWNuRVBkODRXSldyU29lYXB4UDV6bUdObURPbFpkdWZieDZVVlZJNll1a1h1?=
 =?utf-8?Q?cmSpkbwr1JKSsMH+S2/ywS0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323c3392-16e6-4f14-15e6-08d9bc43263b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2021 01:11:24.1177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hO+0D5BkQ2XC5BXfwFdShOQH7w4BMuu9H5PrED0ZTmP4tuMufS6PIpuyMb9rCEb89tZa7uWNuD4ORDdO/FuuAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5340
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

On 2021-12-09 4:18 p.m., Philip Yang wrote:
> Add svm_range_bo_unref_async to schedule work to wait for svm_bo
> eviction work done and then free svm_bo. __do_munmap put_page
> is atomic context, call svm_range_bo_unref_async to avoid warning
> invalid wait context. Other non atomic context call svm_range_bo_unref.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 31 +++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 ++-
>   3 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 9731151b67d6..d5d2cf2ee788 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -550,7 +550,7 @@ static void svm_migrate_page_free(struct page *page)
>   
>   	if (svm_bo) {
>   		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
> -		svm_range_bo_unref(svm_bo);
> +		svm_range_bo_unref_async(svm_bo);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c178d56361d6..b216842b5fe2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -332,6 +332,8 @@ static void svm_range_bo_release(struct kref *kref)
>   	struct svm_range_bo *svm_bo;
>   
>   	svm_bo = container_of(kref, struct svm_range_bo, kref);
> +	pr_debug("svm_bo 0x%p\n", svm_bo);
> +
>   	spin_lock(&svm_bo->list_lock);
>   	while (!list_empty(&svm_bo->range_list)) {
>   		struct svm_range *prange =
> @@ -365,12 +367,33 @@ static void svm_range_bo_release(struct kref *kref)
>   	kfree(svm_bo);
>   }
>   
> -void svm_range_bo_unref(struct svm_range_bo *svm_bo)
> +static void svm_range_bo_wq_release(struct work_struct *work)
>   {
> -	if (!svm_bo)
> -		return;
> +	struct svm_range_bo *svm_bo;
> +
> +	svm_bo = container_of(work, struct svm_range_bo, release_work);
> +	svm_range_bo_release(&svm_bo->kref);
> +}
> +
> +static void svm_range_bo_release_async(struct kref *kref)
> +{
> +	struct svm_range_bo *svm_bo;
> +
> +	svm_bo = container_of(kref, struct svm_range_bo, kref);
> +	pr_debug("svm_bo 0x%p\n", svm_bo);
> +	INIT_WORK(&svm_bo->release_work, svm_range_bo_wq_release);
> +	schedule_work(&svm_bo->release_work);
> +}
>   
> -	kref_put(&svm_bo->kref, svm_range_bo_release);
> +void svm_range_bo_unref_async(struct svm_range_bo *svm_bo)
> +{
> +	kref_put(&svm_bo->kref, svm_range_bo_release_async);
> +}
> +
> +static void svm_range_bo_unref(struct svm_range_bo *svm_bo)
> +{
> +	if (svm_bo)
> +		kref_put(&svm_bo->kref, svm_range_bo_release);
>   }
>   
>   static bool
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 6dc91c33e80f..2f8a95e86dcb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -48,6 +48,7 @@ struct svm_range_bo {
>   	struct work_struct		eviction_work;
>   	struct svm_range_list		*svms;
>   	uint32_t			evicting;
> +	struct work_struct		release_work;
>   };
>   
>   enum svm_work_list_ops {
> @@ -195,7 +196,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>    */
>   #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
>   
> -void svm_range_bo_unref(struct svm_range_bo *svm_bo);
> +void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   #else
>   
>   struct kfd_process;
