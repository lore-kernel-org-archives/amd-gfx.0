Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA2BC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FB711B266;
	Thu, 30 Jun 2022 14:46:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1DB11B268
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsaA/aH5eyCkOmBuXHNhw24WhZclNE4rdEVKeqbgWbuz/LAarQcHS9xZjEWJek42sMqfRwJzQJYN3oVulD0Dchprn574eNlJ5enu9n6MkXyvnI0LEa7PULaF9/kLSrWHgIw3x5mh/BYZq7JGWmmCxZaxZvqgCa+fUA1wiSFB8rOltyeyDCV4bS5cOh8Pp85bgWCHUGsRBl6eGkwplxHmW0jTc3tTxFpl6LaPV91MB/l9jk6Et7+Vo5cpBXmZ+dHqBK71Gx3dC8hIy6Rro5DLIta2IKUsPWTPNpKgFLLPhChu0LNjtYIaN81G6eopZYRWsExCd6yCvtMIyqss4xABNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIUFuRwpj5rXYjmDHurawnawf0B6tvFCmnuj8LwWQfg=;
 b=QU/GMT/enwCgL53VUTiugx3MHsHUm7oBIKWUFqsjmcNJKtDmgP2BbNYqTL15Fla3vYMnzUQ1VwB9fYPQGAdcwsZHe0JrVITqy/GS18+HTWkHpot/OQCdtNZkwaiTAUg8FOlsR625v2c/oYgxSX23QaOXf3mnpQeDAeDHefyjJSBqZYkosfy2XM/PfzzlnCH7Jd3NlQbiYe5CT4POG+fpifXejMom+THTT33cPqBGQve2CKVCx2cqUI7wLXt/zPOUSzNWA6ys+4eWiGFfPUtQd1GWPmBFoWDoN/qqk9FbmPSHjhOJYsbyerNsSy9p/i1b0X0E5PZ+5Ibf5mUNMLKoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIUFuRwpj5rXYjmDHurawnawf0B6tvFCmnuj8LwWQfg=;
 b=uBVEIH3OE0bydIPM2Qc3LsxBLP6+Kp+HMTL35zMeLtcjWn+XJJsM0ijUXVHIA0AXl0dsTk3OGUq0zR6lm2FNWj+bMjZSFWIqixmwnl6mOHX6pc17w0aR7JL+oYo4p4/uOpip1DnpZCUhlKcns1l4KSsUSdcI/d5kFIK/Y4QjKnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 14:46:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 14:46:17 +0000
Message-ID: <f175e926-ac60-e1e6-3492-44b5a596ba30@amd.com>
Date: Thu, 30 Jun 2022 10:46:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/11] drm/amdkfd: Add KFD SMI event IDs and triggers
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628145020.26925-1-Philip.Yang@amd.com>
 <20220628145020.26925-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220628145020.26925-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da39f6a4-c2c3-433b-9124-08da5aa74a0c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMsPHyewSOz9M3KHhIXBiBemNh76mF6csbPdDotXFcwq96a7mc1eUsU6ZZ3m6gK7y30XWNh1GQuGxftvXzLGLPVVh0pVaSorO03AIxDUWeZJyoIpwAXv4j2iYdHPnspuznbflub9KXulapdi72taOtYl7ta6v3T/8VSXsTzBZ9ggS02lkahrcN+CljVHOqQJ6zAxBBHG3L4fRS3Bb9OWuTfK3zOtLJo/nlpy1PNbCbQGOgaxNk+unourVbri9KPDTU3CZY+YbzP4VAhCafjXr+9+Wht/MHLE/P6tk96PU7KTIDsRagCRWVmv4bWT7p1+xev/5LPaaWr4we4MW97IL+XNNXcYwwK6xU80fahkbs7XRXBjb55CVf9qAilehVB7FrOTZ7JPjSbukE4TPP7GcFSKsscaI+jCiuXPhzdxZzqrjoc8kkSHS9nZh2iQDn21sY5Sjiir4RfhRRwsI2ifKzSmjN+5XLkt/MKyMVylqCYEhWX5X8OdpMPLw9wQ69nkxJwb6+lSHYEO2ukhSgHiflIqS7W1nV/HUNCdDBUAutjTOmocB+EaFxlF07bsSQMjSXPdh8Ks9JW509sZtkuSrS4oB6OAE1sctHaR3HDRQOESJESd8arB1y2wnytyqM9W18ZnuBFHUojPq6fTkVHG/P4GFtEb5qJgpaPusNl3CbwT8Niw+OsssrrRVlCEHLxA4eR1lK3Ahw6FgsQixQxgpx0jHFBJRXkyy6ZlI6d4vB09xymwMqbjN0mQ9TFLsQobYXs6Aw1/WEZiT16t1/sdMPetwcWM2bYhGpvuthswTxCfACKTLxqDA8NH2Eq2nSVmLjyTo3AbPnSxLx8+wrmj6ct/uVNgQzNbqxqeUKEyRUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(8676002)(8936002)(26005)(66556008)(66476007)(316002)(6512007)(66946007)(38100700002)(31696002)(5660300002)(186003)(83380400001)(86362001)(36756003)(6506007)(41300700001)(31686004)(44832011)(6486002)(2906002)(478600001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1FGMjhpbGpZYUovVGFERk5RTStFc2ovWU81L3NWYWd5Ny9OOXlpcFhSNm9R?=
 =?utf-8?B?TjI1OEF5bWVWUlhtcWJSVld2TmJjM3Q4KzE3UWJqUEtidVhmc2llMG1wMmxo?=
 =?utf-8?B?WHRxNk9OcjBCM3RPTTZZMkczMjBsSlB3NDlwcmI2WklIU1lRamQwZ2lOeWZP?=
 =?utf-8?B?RHhaSE44c0VNV0VJemd5b0FJbDYyVC9NLzVQZHIvRldPTmtFOUQyVldSZWNS?=
 =?utf-8?B?QzRMaXZEbFpEc052akdIS1RBa3h0ajZ1SXVqZ01jbXJPb0F4a0VtZGVxT0VV?=
 =?utf-8?B?d2U2K2ZvWlVTRnNvb2l5T1dyeStvWE15YS9jYTVMVWNJa3U4NzY2Y0VHcEcx?=
 =?utf-8?B?aFVKQ1pNYUpFZFU5ckhHQ3pKRDNhZkN4UTFjUk1pVG0vNzZDV2oraXJHRmpu?=
 =?utf-8?B?Skw0T2s1ZVZsM2JEZWNweTcwNnZDRis2WUJGa1c1bFp2MjZ0ek05Wmd0TXdF?=
 =?utf-8?B?KzBkMElVaE1sYUFES2hOZjAxekN4c0ZHcEh0emdhR1pHd3hmZ1NBSk5LNEJX?=
 =?utf-8?B?RGd4ZEVabUlIWGg2WUlIZWJ3VTB1T1ZXeGpIVCtYenZnajZzazBlOEhsRjE5?=
 =?utf-8?B?VWlFUFlicERDZWdqQzZCaERkWUVUTHNOZUhjRVh6Wi9ONHBUNXNROHhaRUlF?=
 =?utf-8?B?N0o0N3plYkVSbHQxNnlsM1piUzBLSGp5TkVXcUtEck1IdEFJdHFpZXpUUlBx?=
 =?utf-8?B?TTd1S2dUQW12RURiTWt2QllIWTVMcGMrYlE1RmJqRy9CRkFKLzROVVlJckJn?=
 =?utf-8?B?Q1NPZDNzbFFac0c2WUtHYkZ0TWo0M2dzQzFKdG91RWUwWjNWQ2lJdCtUNkhT?=
 =?utf-8?B?OFJkSUg3dTJ0TUtFWklHbTg0TkdxV2ZVMitxbTdONmdXL2IvclBXU3RXSzB3?=
 =?utf-8?B?cGx6M3NYaURpOUMxRTBNM0tHQUtLY1FqK0d2UE9WdHJDMnFGdVpOMFJ0WG9T?=
 =?utf-8?B?U0pJVWhNcG5OM3FSZXQzYlhFY3hpL1Y0UkoyMmVTQUc0N1BlMFJwTGhGNXgx?=
 =?utf-8?B?K0VnMy9WVzZLYklqcVgwb2gwQW9oYklKRFhqT1E1RFlhVEd5aWpPcVFPNm0z?=
 =?utf-8?B?emkydUFScFhkeGFra2dBakp2aFB5TGdVR1ZXVko2OVhEYmNMd0RaWGVYSDVo?=
 =?utf-8?B?YnVTWUtMZDQ0Mm9hU3Y1anRGOWlEWEhSNnlqMmlZYUxNTmsvZ2d4RVdHVDV5?=
 =?utf-8?B?QjU4czFRZlozWmdVRThWbkxmS2FBam5JeVNneTI3RWMzYjh1bHhGQll4SjMr?=
 =?utf-8?B?QnEyTXl6QW11a3J5YUE1SjBHY0gwQnJZS3lzS01rUFBEWHlFRlU0USs4aXpL?=
 =?utf-8?B?VExQWFFUZU13eHBvSXh1cWY0UTVmVjhBNitKUUZSajVGaUhxajdXMm9wTnZU?=
 =?utf-8?B?WWg1UjJ2VitsK0VxTEFSSHNKZUJ3L3E5UXB0Q3V1U01nbUEvUHdZcElBdEh6?=
 =?utf-8?B?ZDlqSGdYNk1oNzVKcXpnQ1RKUFBBOWZIeUxXYktUbmZsY0R3YmZHNlB2djhX?=
 =?utf-8?B?YnVSekFDVWVHSE9qSXUwRnFtUEZXUHJOc3QwN1NzTy9aeEdGV2NGWEU4VHRY?=
 =?utf-8?B?Z2xOYXdCVHJqeWNkYnpGS2dMeGFSL0w5eG1ZTU5rTmp5bldCSDJ4eEJaODNZ?=
 =?utf-8?B?ZFNGaVN5enBKek03VmtUR3VXOTBRb21yNFpxd1FkYXFhQlVxeUJaTytRVjYw?=
 =?utf-8?B?VExyQWZaUFFLdnEyQzNlb3ZsY3oydWpCNklHaVJWSHlpdzJLakxtV25PRXpM?=
 =?utf-8?B?cmxGcEgvdW1Pa1FQck0zSGpQR3ltYWo5Rlc0MlIwL2lsVW5ZaFpnaFNzUDla?=
 =?utf-8?B?cnFlZDNDcmd6SUZIamNCeElKQUlRdGoyeWFpdDRxVG1xNGxQMHNJcDNMakl3?=
 =?utf-8?B?TStkRDVkTGdqQkYxREs1ejNCUG9BelVTZ3BnN2dpQmEyaDVRMTRkVDhZSnBp?=
 =?utf-8?B?ZnpTSndqUWdhSDdHeGZFR1Y0Z1VjWkVoajJXbk90T3V1R1R5SDlwSE1qRmlB?=
 =?utf-8?B?cTU4Ny9UK0xVTWgvYVdqQVFNQUtsMnRmd1FEK1hYMUo5dmJ3NHc4WVpsMmtJ?=
 =?utf-8?B?RXhqUU94L2RNN3h2KzgrVDcrMkJRcVZ5QUZJTXhteW84SUc3NGtnd1Z1OEFv?=
 =?utf-8?Q?LPTG00UgYDqLT2qUMMWrbz2eQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da39f6a4-c2c3-433b-9124-08da5aa74a0c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 14:46:17.5971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOMjFyUSLMTkAvzD+MU9mpD7jzeUNY+XV2SMePg0Wws9DyMrmDRlYBHFhN98Gp+L7b2P8lcTC+UjBjDHHyjGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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

Am 2022-06-28 um 10:50 schrieb Philip Yang:
> Define new system management interface event IDs for migration, GPU
> recoverable page fault, user queues eviction, restore and unmap from
> GPU events and corresponding event triggers, those will be implemented
> in the following patches.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   include/uapi/linux/kfd_ioctl.h | 37 ++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index c648ed7c5ff1..f239e260796b 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -468,6 +468,43 @@ enum kfd_smi_event {
>   	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
>   	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
>   	KFD_SMI_EVENT_GPU_POST_RESET = 4,
> +	KFD_SMI_EVENT_MIGRATE_START = 5,
> +	KFD_SMI_EVENT_MIGRATE_END = 6,
> +	KFD_SMI_EVENT_PAGE_FAULT_START = 7,
> +	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
> +	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
> +	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
> +	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
> +
> +	/*
> +	 * max event number, as a flag bit to get events from all processes,
> +	 * this requires super user permission, otherwise will not be able to
> +	 * receive event from any process. Without this flag to receive events
> +	 * from same process.
> +	 */
> +	KFD_SMI_EVENT_ALL_PROCESS = 64
> +};
> +
> +enum KFD_MIGRATE_TRIGGERS {
> +	KFD_MIGRATE_TRIGGER_PREFETCH,
> +	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> +	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
> +	KFD_MIGRATE_TRIGGER_TTM_EVICTION
> +};
> +
> +enum KFD_QUEUE_EVICTION_TRIGGERS {
> +	KFD_QUEUE_EVICTION_TRIGGER_SVM,
> +	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,
> +	KFD_QUEUE_EVICTION_TRIGGER_TTM,
> +	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,
> +	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,
> +	KFD_QUEUE_EVICTION_CRIU_RESTORE
> +};
> +
> +enum KFD_SVM_UNMAP_TRIGGERS {
> +	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,
> +	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,
> +	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU
>   };
>   
>   #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
