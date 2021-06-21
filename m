Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4041C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 21:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2403F61245
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 21:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2403F61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73B36E420;
	Mon, 21 Jun 2021 21:02:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECCB6E420
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 21:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUuDDPLGdW9fSNGieUaKQBi6Eqc7sMHsuaVhLhLEBYxhKFk7ArpRGxLoi778ZkUk8Plur73jVAUn1tE7ovMzxanHsbMIJBf73KM5ciyOWGi3c8uMgZNnhzUROnfNGUBnb0dhjdEkUN6KxpBH7hLBphptstsmWKaMnKfqk6flUeE+NcqO2cG4eyJgBVACCMRXNHcPI1Rc9epfZq0VFpdcL0pwSBDZRJe+0D0LclXU6UJIq1lHlJx6JtA+DervC/zkHFti54mF1uRJUSQMjOO4bfLsUYjMCEQimuKCKGpDsdsHYmvp+J9xURe6CM4ixAj5Q4JXH3KF5nXBxmacMqV+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPFn3ymzVhroqaqHqJ5axEgeqfy9pJRotDhd/33PeIc=;
 b=DgB6AinUwi/aw+T/IgDsQh0VmEP7NaZQN+7o9Nw4iOSlkp4e14f/G3Fzy85/BhQFfxdCRL0k+mKdRTHkqUYsFKvob+tgAchATWvYyU5g4ZspMdcD5QEGdBJoKgQ7wtMcBU0yZANYhA2vknV1bbeI+RKoHQhr8tcbckDKkXnMryz9roIKmS+RMoGLvF4gW4Mv5pVGXQwAqKGRP+tF9mJB8OuqakQ8EYmL4sZvpEA+5JrWYE0YblgoZg4/2kSGB6vh1s6aATCp9SrUfEe/f7mhXxwklJ0HFBUvOSmeDN6U3DCwEvWkpBUkqjWnhxkjMlzri9rJghfHs3An0xolDTyOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPFn3ymzVhroqaqHqJ5axEgeqfy9pJRotDhd/33PeIc=;
 b=pesYNWBh64vL0XrLWDuRIKy3aDdLvG/rdBt/ShUw1pHgm2C2HnBg+8O8qrYQrDglRWAaVUJSSMG3tf4PlCM7VdXaC5XBilGVL+wINVkuGeWzkjHlAZvDowI5REdZRpCTBCPlE4SxCtMG49esSDFKX+zqQcBct9jycMFMrHLA1g0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 21:02:18 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 21:02:18 +0000
Subject: Re: [PATCH 08/10] drm/amdkfd: add invalid pages debug at vram
 migration
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621160423.3517-1-alex.sierra@amd.com>
 <20210621160423.3517-8-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <0812e835-6967-5cdb-9cca-e9679f8e14f0@amd.com>
Date: Mon, 21 Jun 2021 17:02:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-8-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 21:02:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92a4f858-d482-4333-c100-08d934f7da9e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50992AC237E331153D2E0E2F920A9@BN9PR12MB5099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUxCcCibZalOecqXwG0+Eq3550EWcr0G8z0tRUmfqcVZ07B51nkWBMO7gzoK3cmRRxCVXlnKqXcFoKps4dM+nPrC1pWgJIy457YV7TqHKUQN8/gMDvpsE3pz34cd/pbUzsgZB8aBUpOt+Khs2+SKqUtDiJ4OBfDJGoAu31MlVDjITd2zYKzIoxp9TDRFsF+I2BA4itc6AFML4QxJESWEhKVs9foIae04lFwIEwvFota7Rv/5dnMDXPzUxtETZf7sFMjaklm/FZ47D2kiLTemibVyo0PbohdJMWm7cID39KxEIRRQbdJyDa+LICF7UyewSxgwXRulhP8ZwtPTwDHIqPZxXtn8Oxj6yT+1cbqyY52dteqiYV5P7jdPenOhHp/glmPZHGyUHHX4txFiA5KZv7Tdxo0UYf5LZQFqn964a9M2VvoDzXvUGKi7IxZ6Cs9FAKKQP4qQ4RWGQ2zSnSRbTVoufNN/E/iYOTmcYyOdVKOptYfCM0Nfwv07o5afufAv07S82Vt7a9Brh0SV8lO/0aC1nStPxnmqIf+dgC/qDyi/mvFL1IWsaE3hsovBMYYBXfTqZwvD1QgeWww3IeFmzj0twHG0tNCbMf3sRvKOG9++EQGCVMIAn0J3dMXp74cp57YIoDGYdtRTBCB20U2QYYpOShsD113x+T3EC2zREy5UHp4OYHVIogOkpzBT49DW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(2906002)(66946007)(31686004)(66556008)(316002)(36756003)(38100700002)(66476007)(16576012)(44832011)(8676002)(2616005)(53546011)(956004)(6486002)(26005)(5660300002)(8936002)(16526019)(186003)(31696002)(36916002)(86362001)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUxYMHQ2Z3RxeGkwWHlOLzJtVDl1YWdTUUxNN1gvQlRsSkJoRG9OVUhjT1hi?=
 =?utf-8?B?VVUwV3A4dmFxTXArZGsxdkp0V3JvSG5aVnF2Qy9UVEZINHRTb2M5RGw0SHpE?=
 =?utf-8?B?UzhaYndkc29KL3RFUWdJUVFkZWlGZWFYYUdKYStyZ3BNcVhSZjB0a0hwYU5m?=
 =?utf-8?B?aXduelNXWEZ4N0tvMU1mRjBQTGc0dzZ4UnNreThrTnRVdytURE52clA4Y1ZO?=
 =?utf-8?B?UWRtTlNDZHpBV3lBdkdob0NHTm5nNXA0b2hGVU1RUHVSQ3lrQ1IrTVBId2Vj?=
 =?utf-8?B?R0ZWcGVTTENBa0ZjQ015VkVMdi9XUHpyMlNwbm1ldzRHOUZMV21rdVNvdVlz?=
 =?utf-8?B?amNzZmZ5ak14Qy94TTMyOGQ3TVNtTXVDS0FZQnJ0TzM0bjQvTkpwMzcrUnNn?=
 =?utf-8?B?ZTRGMEFHNzc2ZFZHNEZQWDRvdDdQd253dTNsTk9xL21qajhnUXlTYmhCdVdK?=
 =?utf-8?B?VzlISHRHQmc5N1R2UWt3UXljb3ltOWFkUDFlblNpNVZVckVSRnp5RDAyQkhC?=
 =?utf-8?B?ZU9PNG1sSWxJeWl3eVpMVUUwZ0lXTXdmbVlFWDhMQkQ1ZGZhRzB0SHBqVWNa?=
 =?utf-8?B?MUxqMW0vME9sRkM3SE1CQXcxdlAzL1NrWVVxYkRqVURCdjA5dHNnQUUwdGlx?=
 =?utf-8?B?dzhPck4rL2lBTkl1SjRRdStkbVMzZCsyVE95dlgwNFZyV0hBMnJlcXp3dnd3?=
 =?utf-8?B?TG0rZUU3TWZJcjd3QkI4Q0diNVFxbnJWcVVkampxKzM2MFpaVXh6NWhpMnNY?=
 =?utf-8?B?WjFoa1h2T0ltOVRkbnp4L3pKcmRCUXlkTS9lSTdvRzJoQzIwTE92NUZubGFD?=
 =?utf-8?B?TE9IYSsxeTlvdzg0VnRkMEVsK1VXNnpkR2F4YStQeFd2eCs4VE4rcXAvV1M3?=
 =?utf-8?B?cUlRQ25SUnl3U2VnZjk4eG1VaUdyV3VMMUVBUUJNWVI2VlZzWGtScG81aGhv?=
 =?utf-8?B?ODc3LzRUNCt1VGU3eHZlQ3MvYzQ0ZE9sYml3NFRJekVWRG90emw2RFZKR3Y4?=
 =?utf-8?B?LzNvVzJITUI1UWZRaEd3UUh4bE5rWlBnWGRMNW1LeDVGY1VhYTgyZUw1b2lZ?=
 =?utf-8?B?YmVuUDFYa3dQczI2eTl6N0RkTEpxRU8vWHp3RUtNWEJBSmNGdXM3NkFYZUFF?=
 =?utf-8?B?QWtVc29ReSt0MDR4RGplNjJvUUxrN3hFSkx3MHVLRlBLeTB5QzNmR1dqTlhI?=
 =?utf-8?B?VGlDYzE2ZmtHSWpCTHFyQUVrN1ExL2VOQ09mQldPTzlDOUwrVXQxcXdJVFYy?=
 =?utf-8?B?UXJ6d1FHZFlEV0FMM2tPSHoyWlI3MitIVldPS0pJYkNXZ3VDM2V5eFdNUUhh?=
 =?utf-8?B?RG9hL2RGMVRKanFRdUZ5YUlsZXJiVUdLajVYSE9LNnNVcHd6ci9FOTZwOEJM?=
 =?utf-8?B?TFk5d2ROMmovaUFmNDRDbmR5dXp6MStaYStwUzIycGJvSXQxaU1EWHE1T0p4?=
 =?utf-8?B?MldyVlJyakZENGwzcUN6UjU3SndGWERVbmJwUEl4aEY2NGJPZ3RBZTUyUTho?=
 =?utf-8?B?RE5WbE03S2ZNRnpLcmF6c1krSUsxcklLWXBlMWdZc0Y0SFFaQzhEaXBuUUN6?=
 =?utf-8?B?TEpBbEl6N3d4SFRWbGpmSTJNb0RJTnpKYzVlbDJ1UzZMYmx4OFNOZW9PYldS?=
 =?utf-8?B?NUJxTk5jTDh6RUZKQXNCaWJVNE42bVEwdzVhSDdLdHBDeUVhSHBreWtoWkpz?=
 =?utf-8?B?dGNnUVNrTVptRDcwMDVoU1FicnNhTGVKa0tuNkJoMXdQekJubVN0OUFyeVJJ?=
 =?utf-8?Q?nD2ET0JIqAQ91XDrgfQ1gz/SYGxr+9dHXeNkRPy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a4f858-d482-4333-c100-08d934f7da9e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 21:02:18.0931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ax5HASpaGAEd4JpoYKk1zYcP2/u2geiL63Xml9MzBn8aaK05C5AdD67V8qoAmJn6h+4Yo/xXt33oOHSDrJUv1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-21 12:04 p.m., Alex Sierra wrote:
> This is for debug purposes only.
> It conditionally generates partial migrations to test mixed
> CPU/GPU memory domain pages in a prange easily.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8a3f21d76915..f71f8d7e2b72 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -404,6 +404,20 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   		}
>   	}
>   
> +#ifdef DEBUG_FORCE_MIXED_DOMAINS
> +	for (i = 0, j = 0; i < npages; i += 4, j++) {
> +		if (j & 1)
> +			continue;
> +		svm_migrate_put_vram_page(adev, dst[i]);
> +		migrate->dst[i] = 0;
> +		svm_migrate_put_vram_page(adev, dst[i + 1]);
> +		migrate->dst[i + 1] = 0;
> +		svm_migrate_put_vram_page(adev, dst[i + 2]);
> +		migrate->dst[i + 2] = 0;
> +		svm_migrate_put_vram_page(adev, dst[i + 3]);
> +		migrate->dst[i + 3] = 0;
> +	}
> +#endif
>   out:
>   	return r;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
