Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC65C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C398061168
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C398061168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314976E8C0;
	Wed, 10 Nov 2021 23:49:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAD66E8C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 23:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaRRJyr5pqLuwXEHe7MwFasswae6S0Ae1NZkmvGlY5t+WKl1ok4bTXmNtXGuEOKeo3z9RFOmVJxG3PINWtYRRKlpsjzNZSHgSd5WXB6mDTr+GQtQ6kfwq/HwFkfxvJJokpwUvGuoaQsV94xm9Xg/dLIek6CD7a1fv83p0Yy+QrP/iPMZLEVF8kA0IEZ9qLSwSwm/UrHN/5dyQOi/vvZz8a0uQbr6L0GxS3LNX2+YA5YVQfRoMs6d3jivxrfEVaH9umLRy8lTc+4riegJ+P2ynYGTOjrP9PwOlO0+GD2yd2YGxZzJ1B2gjWk2Z4fEbh9GhXhiWgqb/6P7c2AGEzFSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox48yYkTYGDNavgKcu1ualq8MLJ7A+15Lr+sii+iFkk=;
 b=Uu4u93W1VkdJ0Xp9HtIxJucPWPFxjFeWW/w67iK1jaczijB6Kmt/wD6TfacYuUqBpI2xkHaDxpqJd5YJU/gRl13pq7mSAYTqZyjEqhvnEnYsXmjxwg75253HlLWXHEME9a0/FmseekDhz804XHeC46CGa2yEbSR+dTCxuOJLEyV5M8KTMJcn+DwBsLD8umZG0Qa13q1RGpQmQgSWW5CglAzRVOUQ0330SAFmNgQJ+sd9FC5AvoSlptMmfZ7lCUdkX66iQ/QxB6O6p8zEffubA2Pyus8lIeasBO9SyE5xccWiNcKEtEjwzt6t//gWeWmvhYASCDEk19LBM4ppCg4Ekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox48yYkTYGDNavgKcu1ualq8MLJ7A+15Lr+sii+iFkk=;
 b=NGT6aTMbEMhZkDdF1Qlqud8laCE/KjxNZb4fFM64r1O61PAmHS9lXs3sDrGpUdzuRR20TM04K3THlay5JtuAtNI5kGU8xg0SaJP4aDw+oNT+Bchxqdj3F/zEgV2P4kz8AMLu30dSMjJQ1If0zvTEcN8kc0KDhn2ya4C8jUvJeY0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 23:48:59 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 23:48:59 +0000
Subject: Re: [PATCH] drm/amdkfd: replace asic_family with asic_type
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211110232553.3815030-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <bb1fde9d-b52d-d21d-74ca-f385ba9a7345@amd.com>
Date: Wed, 10 Nov 2021 18:48:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211110232553.3815030-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PAYP264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::23) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 PAYP264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 23:48:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed7c2e13-a0e8-4234-0ef7-08d9a4a4aaca
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51914A6AFED2AA574D94ECE492939@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpxSLIU97xYtLRDIfCkIV+MTz4upaE6zInLEaf/rhWSpPvivGL1jn65UQOHfc6ufXm+L9fXMlpkKW/1K8PyQVnvXToY2RRHGHpFfiaEYR0jlEd+XIQxMj3ylAkFX7j3A/K1WBxZ+I4Cp3q5xUI1trF4O/iaIUjC/+qvtwX9BMaeERXWa5IVo5YfCpBMJjt09jFHcICRj5UZRT8cljfBYeEb4aOcPGuysx4hi5H0IIYOx5rRe+T3eo1a+71y0jiJKlL+cGrlFhIxDZh491SVEs0isBkP2cE8GBUg/qK1QczvMO27Q/aU4DNhtXOruX16kBYtQkw25eCnFugVc1l2TeDwTcpvyqwr26vv6pkx4JN5st0WIgbLIbnjqgURxertQU+iMx4TRrnqR2FeNH9ExuJatARwNV+O9yjMAQnJFZ9R81b5f6oxTe5BhI/j7IeUba71jgVVGJFI85CxMiU1G6HSsmrPbrUujSRUsKPr0neM0CqDvhtw8fBEO/9ZmLhTaaF8I5JfTsbJwfff/DA04SfA4jLeaACSVLD+ZS0sG/AAJ91cr4zvH02BixGGmKfthqW584pOIhTT8B74oEW5qFW6zftdB/d/R03a52pKtfldPS05oQVmOQ6Yt/tZkJJovWRClcvMDwl0CNIYWPb/BwdzVUuwa3kQRPIUCK99S560qiR/C7eISVMg0ny+2nNimupVbA3Or3Optj5BgQPVatF68YuJ9xNdC8kbdVzbAQIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(38100700002)(26005)(186003)(66556008)(8676002)(66476007)(66946007)(508600001)(36756003)(30864003)(5660300002)(2906002)(31696002)(6486002)(8936002)(53546011)(36916002)(4001150100001)(6666004)(316002)(86362001)(2616005)(44832011)(16576012)(956004)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3Y4dUQ2S2Q5ZVBRcHZ6dm9XZWplOVlRNUphRHJ1ZWU4bUtyNEY5S3BuUDc4?=
 =?utf-8?B?cEJkZGlxY3F5ZVBYbWptSzdocTVQbEtWQlhDcUd5MEhVT2VVSXR0cTIzZGc2?=
 =?utf-8?B?clJTODNYaEtza0pGZGNqa3lORVFqQWJobkhRWVhqaW1GdnR6R0hmRUpkNEZx?=
 =?utf-8?B?WVBKREE4ck9NemJKUTBRM09WTFNKY0haTENGRGVaM1RETjJmbnNlZWFXMDdm?=
 =?utf-8?B?YVhScjZhcjhzYU90YTMrTG9VNCs2SDI1S1p0OGZmWm5LaFQyM2tTdWNSUnIv?=
 =?utf-8?B?bkh6NmphUWFvSXdsT0h5WDBrR0V2R1E0NTM3OXB1TjJmSlFRblIwVVYzQXdT?=
 =?utf-8?B?MG1URnMyS0tDSWMxdUIwQmorckxCd0x6MHpYckg0cE9qVUNpSnBJSzVvcGtK?=
 =?utf-8?B?dFB2WTZFbjNQbGtaYnF0RjRJUUJCZHRsb1gvKzI3NEhQVHc4UnVRMHJ4dFBx?=
 =?utf-8?B?ejJkYVVYUnpJWFIwL21saHd3VHhFVXRWeS9hb3lBbVRCYVVpTWwrQnRsZUhG?=
 =?utf-8?B?TENGMmVFdm5RK01SekUrTDVURThFeWh6TmRMYlAyZXorYkJJWUFES0x3Yll2?=
 =?utf-8?B?ZkNVaTVRUW1jUDNhaXM0Wjc1TzJrMUswKzhEc1YwWDkxTVFmdnIzVURvRmZR?=
 =?utf-8?B?bmVVbEl5dzMzakZNWTVvM29Ya0JnNDhRNDJreEp1SjVyd3BHYkxZdjdndnV3?=
 =?utf-8?B?NUhmL2llWTM0SU9MaUFwUnBYdmsxcmlLWTJVNU9ucTY0ajE2Vy9tUjBaVFhk?=
 =?utf-8?B?WTFoUSszQStQQlNUN3NLdkttZUgrWHNMZWZMVk1YNTlCSlRpWjhxOGpFSGds?=
 =?utf-8?B?Y3hZQ0dNZFJBN01RM01oRHlRMm5xZXpjMlNobWJQS1psZytqcU00RmV0d1R6?=
 =?utf-8?B?YkpZVXdvTzlWdWIweXdiVHRBVWhUUlJCTEtLWWhWcDR6Wkt3MVlKQzdCUUR3?=
 =?utf-8?B?YXpWYnVsS1hIVWRxWW1YY1RhTmh2M1BNdVZQVER1MlMwZ0NVeUxXekZldkNE?=
 =?utf-8?B?Q0VYZEVKbFpsbTI0VEpYZ1RMVW0rWnIwdWRaRVBKbTJSN2pQQjRIb2Z0eHZG?=
 =?utf-8?B?OHF1NlRhdUhvVzhjR3ZsWWRQa2hyRkQ0WjVYbCs4cm1uTWlyRnVTTDZYemFj?=
 =?utf-8?B?VjQrQ2IwSW83SlB4TjdlTjRMYXR4M2oxa0p0ODd5U1lIcUU2YXBVK2c3QWRE?=
 =?utf-8?B?dmZpNFBPajVydzZNWnBjeXRRd0pxblRjN2RkNWp0Qk1qeGFKa0Z4OTRvOGN4?=
 =?utf-8?B?SzBNNmdwQVBsbTR2dWpWdnZiU0cwKys4Zlc0OGdsZVYxVmEyMEh1QWk5Z3pO?=
 =?utf-8?B?aEFyZWNJSTMzZnJIdmVwdFMxWEpaL3hkdExWU2NUVExaKzM5cGRsSmdDaGZS?=
 =?utf-8?B?TnlXOUZUMzBhVDJGN2JNemZPUGJzM2ZXeUl5WG0yWS9hSW81cUNrSkhhZlFr?=
 =?utf-8?B?WFRXSU5vN3FWYjdUbXltSHRIVDkwcWFZR3VvN2RLUE5pek9HcS9XOG9YcDU1?=
 =?utf-8?B?RkNra3hFZFlvSW9zWjZQbmw4OTIwZXRGWGZsd211RVA3UXRSV3lHajZaZjBh?=
 =?utf-8?B?ZlJQUjNXc2lKVENOMWZvN3JWNEl5RlMyaUVVWUF3VHVMN2lDVFYxNm1WelBm?=
 =?utf-8?B?RkFtVVhlS2N1R1U0cE5Xbk5vUnpPcjN5dW4yaFJydyttTzRMSlUyeTJqTFpQ?=
 =?utf-8?B?WTlOZTFWbUpHd3ZvYXhJMllSaHNlN01DVEIrRDRVdFJvVHA2c1VVaUNVbUta?=
 =?utf-8?B?eTY2N0JXY2k1RFM1aGFsNUpqRWVWN2FTUG9PT3BUOE52eGhqazNOSzZLR3hX?=
 =?utf-8?B?V0dzaDhMUkNFUE9OdTgxS1lQWDQ5TWh6SFo1djZxNDRNOWdrTDNONEhXdnpJ?=
 =?utf-8?B?S0hxWGh6MG9lTzlQWElpd3h4L28rVUZaZHJuelJzMngwdENGTEZVYXYwUFdz?=
 =?utf-8?B?czJ4cXRGL3JvL0lmbXVGOHFwaWVDaXcrMFVSWk5kWXM5U3drdzBZcWpVV2Z5?=
 =?utf-8?B?bWJUN2NtcWF2Umh1WG90eDMzMHE4NnRTZzVtVmF1WlE4UUtPVzltYVF1N3cw?=
 =?utf-8?B?TS9NRWhTR3AzRjBCc0pKR3k4RXZsLzdEU1dOZ2dOcExDWGsxeitMM3ZaVm12?=
 =?utf-8?B?cUxSWUJvWE5wTnhLZUg3K1h4YTA4RndPSFVpeDU4WDExNmRTaC8zWmFvS243?=
 =?utf-8?Q?UK/rJFeOVV7PzIb+PsU6EUM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7c2e13-a0e8-4234-0ef7-08d9a4a4aaca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 23:48:59.8289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E70V7RXztE1ciyST/K7oHRnuflEt9bhQm/9NRKzNILS47aRUZnkMMa6ExhY9Uf2m0QaqInv7U+dFGIKXe7GUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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

On 2021-11-10 6:25 p.m., Graham Sider wrote:
> asic_family was a duplicate of asic_type, both of type amd_asic_type.
> Replace all instances of device_info->asic_family with adev->asic_type
> and remove asic_family from device_info.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  8 ++---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 29 -------------------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 12 ++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  4 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 11 ++++---
>   10 files changed, 22 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index e31ea107e998..d60576ce10cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -43,7 +43,7 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>   	 */
>   	if ((ihre->source_id == CIK_INTSRC_GFX_PAGE_INV_FAULT ||
>   		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) &&
> -		dev->device_info->asic_family == CHIP_HAWAII) {
> +		dev->adev->asic_type == CHIP_HAWAII) {
>   		struct cik_ih_ring_entry *tmp_ihre =
>   			(struct cik_ih_ring_entry *)patched_ihre;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f70117b00b14..4bfc0c8ab764 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -580,7 +580,7 @@ static int kfd_ioctl_dbg_register(struct file *filep,
>   	if (!dev)
>   		return -EINVAL;
>   
> -	if (dev->device_info->asic_family == CHIP_CARRIZO) {
> +	if (dev->adev->asic_type == CHIP_CARRIZO) {
>   		pr_debug("kfd_ioctl_dbg_register not supported on CZ\n");
>   		return -EINVAL;
>   	}
> @@ -631,7 +631,7 @@ static int kfd_ioctl_dbg_unregister(struct file *filep,
>   	if (!dev || !dev->dbgmgr)
>   		return -EINVAL;
>   
> -	if (dev->device_info->asic_family == CHIP_CARRIZO) {
> +	if (dev->adev->asic_type == CHIP_CARRIZO) {
>   		pr_debug("kfd_ioctl_dbg_unregister not supported on CZ\n");
>   		return -EINVAL;
>   	}
> @@ -676,7 +676,7 @@ static int kfd_ioctl_dbg_address_watch(struct file *filep,
>   	if (!dev)
>   		return -EINVAL;
>   
> -	if (dev->device_info->asic_family == CHIP_CARRIZO) {
> +	if (dev->adev->asic_type == CHIP_CARRIZO) {
>   		pr_debug("kfd_ioctl_dbg_wave_control not supported on CZ\n");
>   		return -EINVAL;
>   	}
> @@ -784,7 +784,7 @@ static int kfd_ioctl_dbg_wave_control(struct file *filep,
>   	if (!dev)
>   		return -EINVAL;
>   
> -	if (dev->device_info->asic_family == CHIP_CARRIZO) {
> +	if (dev->adev->asic_type == CHIP_CARRIZO) {
>   		pr_debug("kfd_ioctl_dbg_wave_control not supported on CZ\n");
>   		return -EINVAL;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index b6d887edac85..f187596faf66 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1340,7 +1340,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>   	int ret;
>   	unsigned int num_cu_shared;
>   
> -	switch (kdev->device_info->asic_family) {
> +	switch (kdev->adev->asic_type) {
>   	case CHIP_KAVERI:
>   		pcache_info = kaveri_cache_info;
>   		num_of_cache_types = ARRAY_SIZE(kaveri_cache_info);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index feebd652a7a1..ce9f4e562bac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -55,7 +55,6 @@ extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
>   
>   #ifdef KFD_SUPPORT_IOMMU_V2
>   static const struct kfd_device_info kaveri_device_info = {
> -	.asic_family = CHIP_KAVERI,
>   	.asic_name = "kaveri",
>   	.gfx_target_version = 70000,
>   	.max_pasid_bits = 16,
> @@ -75,7 +74,6 @@ static const struct kfd_device_info kaveri_device_info = {
>   };
>   
>   static const struct kfd_device_info carrizo_device_info = {
> -	.asic_family = CHIP_CARRIZO,
>   	.asic_name = "carrizo",
>   	.gfx_target_version = 80001,
>   	.max_pasid_bits = 16,
> @@ -95,7 +93,6 @@ static const struct kfd_device_info carrizo_device_info = {
>   };
>   
>   static const struct kfd_device_info raven_device_info = {
> -	.asic_family = CHIP_RAVEN,
>   	.asic_name = "raven",
>   	.gfx_target_version = 90002,
>   	.max_pasid_bits = 16,
> @@ -116,7 +113,6 @@ static const struct kfd_device_info raven_device_info = {
>   
>   #ifdef CONFIG_DRM_AMDGPU_CIK
>   static const struct kfd_device_info hawaii_device_info = {
> -	.asic_family = CHIP_HAWAII,
>   	.asic_name = "hawaii",
>   	.gfx_target_version = 70001,
>   	.max_pasid_bits = 16,
> @@ -137,7 +133,6 @@ static const struct kfd_device_info hawaii_device_info = {
>   #endif
>   
>   static const struct kfd_device_info tonga_device_info = {
> -	.asic_family = CHIP_TONGA,
>   	.asic_name = "tonga",
>   	.gfx_target_version = 80002,
>   	.max_pasid_bits = 16,
> @@ -156,7 +151,6 @@ static const struct kfd_device_info tonga_device_info = {
>   };
>   
>   static const struct kfd_device_info fiji_device_info = {
> -	.asic_family = CHIP_FIJI,
>   	.asic_name = "fiji",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
> @@ -175,7 +169,6 @@ static const struct kfd_device_info fiji_device_info = {
>   };
>   
>   static const struct kfd_device_info fiji_vf_device_info = {
> -	.asic_family = CHIP_FIJI,
>   	.asic_name = "fiji",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
> @@ -195,7 +188,6 @@ static const struct kfd_device_info fiji_vf_device_info = {
>   
>   
>   static const struct kfd_device_info polaris10_device_info = {
> -	.asic_family = CHIP_POLARIS10,
>   	.asic_name = "polaris10",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
> @@ -214,7 +206,6 @@ static const struct kfd_device_info polaris10_device_info = {
>   };
>   
>   static const struct kfd_device_info polaris10_vf_device_info = {
> -	.asic_family = CHIP_POLARIS10,
>   	.asic_name = "polaris10",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
> @@ -233,7 +224,6 @@ static const struct kfd_device_info polaris10_vf_device_info = {
>   };
>   
>   static const struct kfd_device_info polaris11_device_info = {
> -	.asic_family = CHIP_POLARIS11,
>   	.asic_name = "polaris11",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
> @@ -252,7 +242,6 @@ static const struct kfd_device_info polaris11_device_info = {
>   };
>   
>   static const struct kfd_device_info polaris12_device_info = {
> -	.asic_family = CHIP_POLARIS12,
>   	.asic_name = "polaris12",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
> @@ -271,7 +260,6 @@ static const struct kfd_device_info polaris12_device_info = {
>   };
>   
>   static const struct kfd_device_info vegam_device_info = {
> -	.asic_family = CHIP_VEGAM,
>   	.asic_name = "vegam",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
> @@ -290,7 +278,6 @@ static const struct kfd_device_info vegam_device_info = {
>   };
>   
>   static const struct kfd_device_info vega10_device_info = {
> -	.asic_family = CHIP_VEGA10,
>   	.asic_name = "vega10",
>   	.gfx_target_version = 90000,
>   	.max_pasid_bits = 16,
> @@ -309,7 +296,6 @@ static const struct kfd_device_info vega10_device_info = {
>   };
>   
>   static const struct kfd_device_info vega10_vf_device_info = {
> -	.asic_family = CHIP_VEGA10,
>   	.asic_name = "vega10",
>   	.gfx_target_version = 90000,
>   	.max_pasid_bits = 16,
> @@ -328,7 +314,6 @@ static const struct kfd_device_info vega10_vf_device_info = {
>   };
>   
>   static const struct kfd_device_info vega12_device_info = {
> -	.asic_family = CHIP_VEGA12,
>   	.asic_name = "vega12",
>   	.gfx_target_version = 90004,
>   	.max_pasid_bits = 16,
> @@ -347,7 +332,6 @@ static const struct kfd_device_info vega12_device_info = {
>   };
>   
>   static const struct kfd_device_info vega20_device_info = {
> -	.asic_family = CHIP_VEGA20,
>   	.asic_name = "vega20",
>   	.gfx_target_version = 90006,
>   	.max_pasid_bits = 16,
> @@ -366,7 +350,6 @@ static const struct kfd_device_info vega20_device_info = {
>   };
>   
>   static const struct kfd_device_info arcturus_device_info = {
> -	.asic_family = CHIP_ARCTURUS,
>   	.asic_name = "arcturus",
>   	.gfx_target_version = 90008,
>   	.max_pasid_bits = 16,
> @@ -385,7 +368,6 @@ static const struct kfd_device_info arcturus_device_info = {
>   };
>   
>   static const struct kfd_device_info aldebaran_device_info = {
> -	.asic_family = CHIP_ALDEBARAN,
>   	.asic_name = "aldebaran",
>   	.gfx_target_version = 90010,
>   	.max_pasid_bits = 16,
> @@ -404,7 +386,6 @@ static const struct kfd_device_info aldebaran_device_info = {
>   };
>   
>   static const struct kfd_device_info renoir_device_info = {
> -	.asic_family = CHIP_RENOIR,
>   	.asic_name = "renoir",
>   	.gfx_target_version = 90012,
>   	.max_pasid_bits = 16,
> @@ -423,7 +404,6 @@ static const struct kfd_device_info renoir_device_info = {
>   };
>   
>   static const struct kfd_device_info navi10_device_info = {
> -	.asic_family = CHIP_NAVI10,
>   	.asic_name = "navi10",
>   	.gfx_target_version = 100100,
>   	.max_pasid_bits = 16,
> @@ -443,7 +423,6 @@ static const struct kfd_device_info navi10_device_info = {
>   };
>   
>   static const struct kfd_device_info navi12_device_info = {
> -	.asic_family = CHIP_NAVI12,
>   	.asic_name = "navi12",
>   	.gfx_target_version = 100101,
>   	.max_pasid_bits = 16,
> @@ -463,7 +442,6 @@ static const struct kfd_device_info navi12_device_info = {
>   };
>   
>   static const struct kfd_device_info navi14_device_info = {
> -	.asic_family = CHIP_NAVI14,
>   	.asic_name = "navi14",
>   	.gfx_target_version = 100102,
>   	.max_pasid_bits = 16,
> @@ -483,7 +461,6 @@ static const struct kfd_device_info navi14_device_info = {
>   };
>   
>   static const struct kfd_device_info sienna_cichlid_device_info = {
> -	.asic_family = CHIP_SIENNA_CICHLID,
>   	.asic_name = "sienna_cichlid",
>   	.gfx_target_version = 100300,
>   	.max_pasid_bits = 16,
> @@ -503,7 +480,6 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
>   };
>   
>   static const struct kfd_device_info navy_flounder_device_info = {
> -	.asic_family = CHIP_NAVY_FLOUNDER,
>   	.asic_name = "navy_flounder",
>   	.gfx_target_version = 100301,
>   	.max_pasid_bits = 16,
> @@ -523,7 +499,6 @@ static const struct kfd_device_info navy_flounder_device_info = {
>   };
>   
>   static const struct kfd_device_info vangogh_device_info = {
> -	.asic_family = CHIP_VANGOGH,
>   	.asic_name = "vangogh",
>   	.gfx_target_version = 100303,
>   	.max_pasid_bits = 16,
> @@ -543,7 +518,6 @@ static const struct kfd_device_info vangogh_device_info = {
>   };
>   
>   static const struct kfd_device_info dimgrey_cavefish_device_info = {
> -	.asic_family = CHIP_DIMGREY_CAVEFISH,
>   	.asic_name = "dimgrey_cavefish",
>   	.gfx_target_version = 100302,
>   	.max_pasid_bits = 16,
> @@ -563,7 +537,6 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
>   };
>   
>   static const struct kfd_device_info beige_goby_device_info = {
> -	.asic_family = CHIP_BEIGE_GOBY,
>   	.asic_name = "beige_goby",
>   	.gfx_target_version = 100304,
>   	.max_pasid_bits = 16,
> @@ -583,7 +556,6 @@ static const struct kfd_device_info beige_goby_device_info = {
>   };
>   
>   static const struct kfd_device_info yellow_carp_device_info = {
> -	.asic_family = CHIP_YELLOW_CARP,
>   	.asic_name = "yellow_carp",
>   	.gfx_target_version = 100305,
>   	.max_pasid_bits = 16,
> @@ -603,7 +575,6 @@ static const struct kfd_device_info yellow_carp_device_info = {
>   };
>   
>   static const struct kfd_device_info cyan_skillfish_device_info = {
> -	.asic_family = CHIP_CYAN_SKILLFISH,
>   	.asic_name = "cyan_skillfish",
>   	.gfx_target_version = 100103,
>   	.max_pasid_bits = 16,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c894cbe58a36..42b2cc999434 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -292,7 +292,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
>   				struct queue *q)
>   {
>   	/* On GFX v7, CP doesn't flush TC at dequeue */
> -	if (q->device->device_info->asic_family == CHIP_HAWAII)
> +	if (q->device->adev->asic_type == CHIP_HAWAII)
>   		if (flush_texture_cache_nocpsch(q->device, qpd))
>   			pr_err("Failed to flush TC\n");
>   
> @@ -1016,7 +1016,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
>   	pr_info("SW scheduler is used");
>   	init_interrupts(dqm);
>   	
> -	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
> +	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
>   		return pm_init(&dqm->packet_mgr, dqm);
>   	dqm->sched_running = true;
>   
> @@ -1025,7 +1025,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
>   
>   static int stop_nocpsch(struct device_queue_manager *dqm)
>   {
> -	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
> +	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
>   		pm_uninit(&dqm->packet_mgr, false);
>   	dqm->sched_running = false;
>   
> @@ -1861,7 +1861,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
>   	if (!dqm)
>   		return NULL;
>   
> -	switch (dev->device_info->asic_family) {
> +	switch (dev->adev->asic_type) {
>   	/* HWS is not available on Hawaii. */
>   	case CHIP_HAWAII:
>   	/* HWS depends on CWSR for timely dequeue. CWSR is not
> @@ -1924,7 +1924,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
>   		goto out_free;
>   	}
>   
> -	switch (dev->device_info->asic_family) {
> +	switch (dev->adev->asic_type) {
>   	case CHIP_CARRIZO:
>   		device_queue_manager_init_vi(&dqm->asic_ops);
>   		break;
> @@ -1953,7 +1953,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
>   			device_queue_manager_init_v9(&dqm->asic_ops);
>   		else {
>   			WARN(1, "Unexpected ASIC family %u",
> -			     dev->device_info->asic_family);
> +			     dev->adev->asic_type);
>   			goto out_free;
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index fa3ec3ed7e39..2e2b7ceb71db 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -394,7 +394,7 @@ int kfd_init_apertures(struct kfd_process *process)
>   			pdd->gpuvm_base = pdd->gpuvm_limit = 0;
>   			pdd->scratch_base = pdd->scratch_limit = 0;
>   		} else {
> -			switch (dev->device_info->asic_family) {
> +			switch (dev->adev->asic_type) {
>   			case CHIP_KAVERI:
>   			case CHIP_HAWAII:
>   			case CHIP_CARRIZO:
> @@ -411,7 +411,7 @@ int kfd_init_apertures(struct kfd_process *process)
>   					kfd_init_apertures_v9(pdd, id);
>   				else {
>   					WARN(1, "Unexpected ASIC family %u",
> -					     dev->device_info->asic_family);
> +					     dev->adev->asic_type);
>   					return -EINVAL;
>   				}
>   			}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 64b4ac339904..406479a369a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -91,7 +91,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,
>   	kq->pq_gpu_addr = kq->pq->gpu_addr;
>   
>   	/* For CIK family asics, kq->eop_mem is not needed */
> -	if (dev->device_info->asic_family > CHIP_MULLINS) {
> +	if (dev->adev->asic_type > CHIP_MULLINS) {
>   		retval = kfd_gtt_sa_allocate(dev, PAGE_SIZE, &kq->eop_mem);
>   		if (retval != 0)
>   			goto err_eop_allocate_vidmem;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 88dc0e451c45..1439420925a0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -223,7 +223,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>   
>   int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
>   {
> -	switch (dqm->dev->device_info->asic_family) {
> +	switch (dqm->dev->adev->asic_type) {
>   	case CHIP_KAVERI:
>   	case CHIP_HAWAII:
>   		/* PM4 packet structures on CIK are the same as on VI */
> @@ -243,7 +243,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
>   			pm->pmf = &kfd_v9_pm_funcs;
>   		else {
>   			WARN(1, "Unexpected ASIC family %u",
> -			     dqm->dev->device_info->asic_family);
> +			     dqm->dev->adev->asic_type);
>   			return -EINVAL;
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 352709034acf..1d3f012bcd2a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -195,7 +195,6 @@ struct kfd_event_interrupt_class {
>   };
>   
>   struct kfd_device_info {
> -	enum amd_asic_type asic_family;
>   	const char *asic_name;
>   	uint32_t gfx_target_version;
>   	const struct kfd_event_interrupt_class *event_interrupt_class;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 641e250dc95f..a3f590e17973 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -515,7 +515,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   				HSA_CAP_WATCH_POINTS_TOTALBITS_MASK);
>   		}
>   
> -		if (dev->gpu->device_info->asic_family == CHIP_TONGA)
> +		if (dev->gpu->adev->asic_type == CHIP_TONGA)
>   			dev->node_props.capability |=
>   					HSA_CAP_AQL_QUEUE_DOUBLE_MAP;
>   
> @@ -1217,8 +1217,7 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
>   	/* set gpu (dev) flags. */
>   	} else {
>   		if (!dev->gpu->pci_atomic_requested ||
> -				dev->gpu->device_info->asic_family ==
> -							CHIP_HAWAII)
> +				dev->gpu->adev->asic_type == CHIP_HAWAII)
>   			link->flags |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
>   				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
>   	}
> @@ -1406,7 +1405,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	kfd_fill_mem_clk_max_info(dev);
>   	kfd_fill_iolink_non_crat_info(dev);
>   
> -	switch (dev->gpu->device_info->asic_family) {
> +	switch (dev->gpu->adev->asic_type) {
>   	case CHIP_KAVERI:
>   	case CHIP_HAWAII:
>   	case CHIP_TONGA:
> @@ -1432,7 +1431,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
>   		else
>   			WARN(1, "Unexpected ASIC family %u",
> -			     dev->gpu->device_info->asic_family);
> +			     dev->gpu->adev->asic_type);
>   	}
>   
>   	/*
> @@ -1449,7 +1448,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	 *		because it doesn't consider masked out CUs
>   	 * max_waves_per_simd: Carrizo reports wrong max_waves_per_simd
>   	 */
> -	if (dev->gpu->device_info->asic_family == CHIP_CARRIZO) {
> +	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
>   		dev->node_props.simd_count =
>   			cu_info.simd_per_cu * cu_info.cu_active_number;
>   		dev->node_props.max_waves_per_simd = 10;
