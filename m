Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084C1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 17:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B5A6E0A2;
	Thu, 25 Nov 2021 17:52:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F486E0A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 17:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jstAfliId0A7gdngei6biRa1QWfUwzGZQMpBgKEK+fhbhQGK0ILWHWnuGzH/EizsMblN6vy0Otw+/3wW3zjVKYdi2nf4rRirK2LctqQsDaCeKmTJJPzXtYHtFOK45GymJLzr512RGdETmOjgBoFoC46Bcx64PVkRlY6cbPLWhnX57/ZTmPl6SLwOQuBMdrHpbaAGKHEETv8qxjk93ZXZahUbHHvYzAsEbERJwImmHYJKdYLZ15l0YlgYZ/1+/YXNX3t0ugrJh2xg017dgXWIJWpRmyKsKhqrdXvK4zmVSVnNiSfnRB4KMz6k8Gl2ArwibQxIwf1oPY+L2l378tQr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RDaH/hCW/7BTJivVz7/9g+SJsHXLWCi5tWlXgSPp+s=;
 b=T6rSpqMgBGNjI9WuuYM9K6l8tnFsh2LhIOuIhfJJRRyMXQdMyMSTfZkwuT7tz+j2tY/RckmbRhXm5y835Z1DcYy7PNZ/WXFnmhYCbnEIPThUw7FLm2MlDnOqegdtHHuFZ37q22nwVvERr9qyPDDZxi5OrNOuY6EPhjImUXk846luuWPcpoUMuD3NWsDBZYWkFiqkribHJDP7M0n5tI4kMh6awvqBfAfkzD7sfs1Tb8AivdsG0G6r7WjnLTA+FNWYfTq9anY+Cl+dMkR8RTDcPj92zxkqtissFG8bSkLq9j32625KlzN8lUGalQz6DrUlF9bo+gOha4W2p8BJyZfS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RDaH/hCW/7BTJivVz7/9g+SJsHXLWCi5tWlXgSPp+s=;
 b=1hBjlXy+Tl17QVe3ihlCRjl8WXclEjSxHFTkdwyBiTFHJFfc3IKXe7i4j0mydovZN1JmACyw3YB0+Qz69XKoCutqI9wgGlqGr5VKBkYO47lkiVw185JGnx97p3i2FN52tqNXYqhYU6kYSjbL6UMEXZo/oEyhjMtyNwPfB13T/wI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 17:52:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Thu, 25 Nov 2021
 17:52:54 +0000
Subject: Re: [PATCH v7] drm/amdgpu: handle IH ring1 overflow
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211125151656.30514-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3730450a-1efe-4dcf-d785-1c24100b1c01@amd.com>
Date: Thu, 25 Nov 2021 12:52:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211125151656.30514-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 17:52:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 322adaa0-26a9-499a-b8b5-08d9b03c680d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5212:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5212A3A006F4CA934B1A1AF392629@BN9PR12MB5212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHK0AOrStFumzntLIElZiUtcQpLFsEqxsSoVd6peGB5jfnpiKjJWK9pe0zjWsPPfcjDNawBEV1963u21uY+7E7dKWepJ0tduRPiFSjmiwz0d6WVVC7FIM03j6iZ8qIwBb81AIOPfgN65svYP/hclTr5AjvigKtnNrFZAjb5MedwIZ0Q1IXBTeDnBZGv8yKuVW+dvaYzf+vI12mloQvQmsu6B3AnM37PQQtoy0nkrYFeoa8oSsDoRpkNzWs28/91tF19ZdFQ6EK6tp3gvCUJgMW44A2Zwa7iotDmDaritYToalfRed8pIHIdTOfdslhV14gFkwRUwqylwuQ1OFzfHfKPac/B5gG+HWdFTv+D1dU7WoBVWdDcVtWXNK+tGYuk+Z83yvWJeJ5KEHuSz6V8EH0d3K/LdtS7hxW8dRCMJi269qsJIkb5RhLsYF3x/khsg0r4Gge1WFDCsdLgfKUwfm72YYD6mPiX8+ACWC04Is+hcShEv16MrfgC93/zNyRuNnG4cXNXc8ZJ8vbdhuVDElAzlvZ+dkZmt7hcyffaUS/wO2UMA9L+TPpHxWKIQr2ZzgIbS8FakMMsWLjV6wyhXxszmn3IqpOf0VqV0T+XjjA9GvG4WEBn35PBqiQx2eb7GNOn2TI4U+AZhHcYfu1TajKOjXEnwTX7R22uUPkEC9J17ramBmQBmQWFvVntPUXt9E5cAAhUZm4m2nk0/kAPqwSGnqdPxzqUrYa5440GoCd825qKnXOKdXIL2yWCN4SN7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(316002)(4001150100001)(31686004)(66946007)(66476007)(66556008)(2616005)(8676002)(30864003)(86362001)(6486002)(4326008)(83380400001)(31696002)(2906002)(38100700002)(44832011)(508600001)(186003)(36756003)(26005)(8936002)(5660300002)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhPdlpuS3hXc016cGxLUG93eUdCcldSSjlMV1dSSVQ0VHR4Nk9JZkJkTFhF?=
 =?utf-8?B?eDJLZVYrb1RBdEFHWFlEZEN5Mm5UUUZ4WDdSYTNMb3EwRGJ0M3RhOWZBc3hH?=
 =?utf-8?B?d24xQW5mR1h0UEVoeGt5VURuU1VHKy9ERnZNclFPQzN0UTgyWkxHS2FhUE9k?=
 =?utf-8?B?d0xxSkQzcjRNSXJtNnVudFNjSHlzbCs4Y3BjMXRXU3VUcE4vZU1LY0FrVml0?=
 =?utf-8?B?U3VRUTF3T3FBdlFLOXdoWXlLKzhYV2tTVnk3YkQzaW52NjBXZzRVekdLRmR3?=
 =?utf-8?B?aFhBVDh0dEpuT3EzbTBuYTF5SkJTd3lzcXB3MUJqdVJTbGR1ZnJTbFB5ZDBi?=
 =?utf-8?B?NzZ6NkROQTFodERKaGJYNWZpM0NRYkRjbU0zNmJWRGswNnM1d0tMcVl3cXlx?=
 =?utf-8?B?TTE0WU0zQlpiY042K2VpRnhWK3paeTl1aXh4VS8yclFhMEpBNHFLa011MEx6?=
 =?utf-8?B?dHhsN0lBRThNY3FyRk5tODEweGNCbnV1aWJvOXZqUXp4dUxFRm1uQlBPdDVt?=
 =?utf-8?B?T0JmQVhwZVlGSmxCbk9tL0lqU25WZmlIWEpYZ1hhWWNjbXc1Z3pmSGtCalRD?=
 =?utf-8?B?ZFp2YThpNFJLMk9ldzI3a3cwRzlDdC90dWFPQ3JLZFRZTFkrMzQxN2dEMDBP?=
 =?utf-8?B?L3hNV1pXUzJWRnlMMTkyOXFROExuMjFIaUVzaU9pU0tYaFBXL2VOT0ZpMVRZ?=
 =?utf-8?B?R0VlQW4zdHJSMFF4STRhTE1jNFM3UGIzVlM4cEVucXJIWHRSMTlvZlFjUmM0?=
 =?utf-8?B?T2ZWd2ZYZHlXcXZQUWxSTVRGV0N5emtXVTRHTE1tYXpxQnFLQURhcU5sSkVX?=
 =?utf-8?B?MUl2NklkT0MxQTRKTXBrU1hoZmhPL3BtSTUrRUZUd2dvQWFkWHQ0aUdWN0ly?=
 =?utf-8?B?dzA1UXdFaHVpS3E3cGdkWVUvazFqT2N5VUJXTHF1K0JPNXd3Uld5MnpzbnRW?=
 =?utf-8?B?eHAySW9sVUZuSmZRSUVxMExPYUx4RU9zdnRTbnZYa1pvMFBPZElzZC9uV1pr?=
 =?utf-8?B?ZmJ0OHdmK095dnVIOWh4RVFWL28vWVB3TmRoTkwrUkpXTlprTEI5dml2V1lz?=
 =?utf-8?B?cGZqejcrNE1XWWU5SC9WVFhZTzdoZlp3OTgwSVJnQm40aHNGMFEzdmVOaUgw?=
 =?utf-8?B?bUppWE5hejNoRk8vQXJMM2F2aFU5azh6Tmh2b1BwWFR4bkgrS0ZUN01GSGRY?=
 =?utf-8?B?SXl5WERFRW53NFVDK0NPcEhBVnF4SDEzSWViTG9Rd0swTnpIWEpKekRMQkZv?=
 =?utf-8?B?QzdxM1JhaWFOdXNnUUplNFR2V25tdGloQmtvWnc2Zlk5Ky9mNjRQVUR2MVVl?=
 =?utf-8?B?N2hmV2cyYU0rZEhOaStJdkVKREZjK1F3U0Vsc01GV2N0VUhFcUUrK0x3bDQ5?=
 =?utf-8?B?Mi9xNTg3dGhBalJHeDM0emU2V0xjR0tXZmp6eDNJSm1Ib2NXblErT0ZKRDdl?=
 =?utf-8?B?cGZmYjJIWjdpRTduM2N2a3BqcnZleTZ6eHk0WkM3NS9aUzRMeVVmM1M3aXY4?=
 =?utf-8?B?clEveHRMMldyQVMwT3VrZC9hMmV6Z25XbW53L3NrTldXYXc3S2I2YVNMSFk3?=
 =?utf-8?B?cHByL0tnWENkcUJtYS9KczJWN0dGVW9pNHM1UnFLaUtvcVhTdkF4VXRzcGFw?=
 =?utf-8?B?VlA1UGNPY2pVbVdxa2F1UHlNMjgzelFTa0dVTDhHNkxyVSs0cUlWOTh3L3B3?=
 =?utf-8?B?VGlJYVB0cUx2cDY3cWVNK294RGM0azBXS2ZlMXcwTFNZTVlxdU9Sc1pveG9S?=
 =?utf-8?B?UFNqOWJaZG5CNjlIQUtJWFgxQVJxZ24wRE56TlZEUFNPN2ViUW9Xc2NmcWFx?=
 =?utf-8?B?TEw3ZmxRTFUzd0lJTnJBY05pZmtXOUlCc2JtTENXYmNIeVNLY0cwTStKaDNm?=
 =?utf-8?B?MUpsWUY3YURPckE0SGNmMjgrQ3Z6QjdmczgyS2VpbG9JaGprQ3YwbXlMRmJP?=
 =?utf-8?B?Y0FpOTNCMTdmd1hveElDbzVHWGFiTUxmUHA4bUtwTWVkU0xWcEt6LzBGa2hZ?=
 =?utf-8?B?TDFyMWpqL3NUdnkzeFdKRzRDWEJWbFp3S2ExT3JHSm9TSEszY2k2WXRHd01u?=
 =?utf-8?B?QkVwSnIzc21mQmZCYlhmckFaODAzWEVtY0o3c0ZtZTBYbEFzb3VuZGxFdlg3?=
 =?utf-8?B?TnBRR0t0OVNPaVpHVkhWbTQwVGlLUGJJZTNiTGFkWkVVVUZDQ3hoTDJZbmNH?=
 =?utf-8?Q?CzuazdS/N0930MvvyMaiteI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322adaa0-26a9-499a-b8b5-08d9b03c680d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:52:54.1823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLUIsgYverRlTZdThyiaL1Fg5JLvdBBIazt2WTfMDvCQpp3Sa5VKXdPWbScR5DBaBzB8natL0fSdl9WCmWQwYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-11-25 um 10:16 a.m. schrieb Philip Yang:
> IH ring1 is used to process GPU retry fault, overflow is enabled to
> drain retry fault because we want receive other interrupts while
> handling retry fault to recover range. There is no overflow flag set
> when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
> and drain retry fault.
>
> If fault timestamp goes backward, the fault is filtered and should not
> be processed. Drain fault is finished if latest_decoded_timestamp is
> equal to or larger than checkpoint timestamp.

If there can be multiple faults with the same time stamp, then this is
not sufficient because it would allow a stale fault with the same
timestamp to sneak through.

For example there are 3 faults with the same timestamp in the ring:

    ...     <- rptr
    ...
    fault1
    fault2
    fault3  <- wptr

The timestamp is taken from fault3, the current wptr.
amdgpu_ih_wait_on_checkpoint_process_ts returns when the rptr reaches
fault1 because it has the same timestamp.

    fault1  <- rptr
    fault2
    fault3  <- wptr

At that time fault2 and fault3 are still stale faults that could lead to
a VM fault.

You would need to wait for latest_decoded_timestamp to be truly greater
than the checkpoint (or the ring to be empty) to be sure that you've
seen all stale faults. Other than that, this patch looks good to me.

Regards,
  Felix


>
> Add amdgpu_ih_function interface decode_iv_ts for different chips to get
> timestamp from IV entry with different iv size and timestamp offset.
> amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  8 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 57 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 16 ++++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
>  10 files changed, 56 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 45761d0328c7..45e08677207d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -350,6 +350,7 @@ static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
>   * amdgpu_gmc_filter_faults - filter VM faults
>   *
>   * @adev: amdgpu device structure
> + * @ih: interrupt ring that the fault received from
>   * @addr: address of the VM fault
>   * @pasid: PASID of the process causing the fault
>   * @timestamp: timestamp of the fault
> @@ -358,7 +359,8 @@ static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
>   * True if the fault was filtered and should not be processed further.
>   * False if the fault is a new one and needs to be handled.
>   */
> -bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
> +bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
> +			      struct amdgpu_ih_ring *ih, uint64_t addr,
>  			      uint16_t pasid, uint64_t timestamp)
>  {
>  	struct amdgpu_gmc *gmc = &adev->gmc;
> @@ -366,6 +368,10 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>  	struct amdgpu_gmc_fault *fault;
>  	uint32_t hash;
>  
> +	/* Stale retry fault if timestamp goes backward */
> +	if (amdgpu_ih_ts_after(timestamp, ih->latest_decoded_timestamp))
> +		return true;
> +
>  	/* If we don't have space left in the ring buffer return immediately */
>  	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
>  		AMDGPU_GMC_FAULT_TIMEOUT;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index e55201134a01..8458cebc6d5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -316,7 +316,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
>  			      struct amdgpu_gmc *mc);
>  void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>  			     struct amdgpu_gmc *mc);
> -bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
> +bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
> +			      struct amdgpu_ih_ring *ih, uint64_t addr,
>  			      uint16_t pasid, uint64_t timestamp);
>  void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>  				     uint16_t pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index 0c7963dfacad..8d02f975f915 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -164,52 +164,32 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>  	}
>  }
>  
> -/* Waiter helper that checks current rptr matches or passes checkpoint wptr */
> -static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
> -					struct amdgpu_ih_ring *ih,
> -					uint32_t checkpoint_wptr,
> -					uint32_t *prev_rptr)
> -{
> -	uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
> -
> -	/* rptr has wrapped. */
> -	if (cur_rptr < *prev_rptr)
> -		cur_rptr += ih->ptr_mask + 1;
> -	*prev_rptr = cur_rptr;
> -
> -	/* check ring is empty to workaround missing wptr overflow flag */
> -	return cur_rptr >= checkpoint_wptr ||
> -	       (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
> -}
> -
>  /**
> - * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
> + * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up to checkpoint
>   *
>   * @adev: amdgpu_device pointer
>   * @ih: ih ring to process
>   *
>   * Used to ensure ring has processed IVs up to the checkpoint write pointer.
>   */
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>  					struct amdgpu_ih_ring *ih)
>  {
> -	uint32_t checkpoint_wptr, rptr;
> +	uint32_t checkpoint_wptr;
> +	uint64_t checkpoint_ts;
> +	long timeout = HZ;
>  
>  	if (!ih->enabled || adev->shutdown)
>  		return -ENODEV;
>  
>  	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -	/* Order wptr with rptr. */
> +	/* Order wptr with ring data. */
>  	rmb();
> -	rptr = READ_ONCE(ih->rptr);
> -
> -	/* wptr has wrapped. */
> -	if (rptr > checkpoint_wptr)
> -		checkpoint_wptr += ih->ptr_mask + 1;
> +	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
>  
> -	return wait_event_interruptible(ih->wait_process,
> -				amdgpu_ih_has_checkpoint_processed(adev, ih,
> -						checkpoint_wptr, &rptr));
> +	return wait_event_interruptible_timeout(ih->wait_process,
> +		    !amdgpu_ih_ts_after(ih->latest_decoded_timestamp, checkpoint_ts),
> +		    timeout);
>  }
>  
>  /**
> @@ -298,4 +278,21 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>  
>  	/* wptr/rptr are in bytes! */
>  	ih->rptr += 32;
> +	if (amdgpu_ih_ts_after(ih->latest_decoded_timestamp, entry->timestamp))
> +		ih->latest_decoded_timestamp = entry->timestamp;
> +}
> +
> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
> +				       signed int offset)
> +{
> +	uint32_t iv_size = 32;
> +	uint32_t ring_index;
> +	uint32_t dw1, dw2;
> +
> +	rptr += iv_size * offset;
> +	ring_index = (rptr & ih->ptr_mask) >> 2;
> +
> +	dw1 = le32_to_cpu(ih->ring[ring_index + 1]);
> +	dw2 = le32_to_cpu(ih->ring[ring_index + 2]);
> +	return dw1 | ((u64)(dw2 & 0xffff) << 32);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 0649b59830a5..322e1521287b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -68,20 +68,30 @@ struct amdgpu_ih_ring {
>  
>  	/* For waiting on IH processing at checkpoint. */
>  	wait_queue_head_t wait_process;
> +	uint64_t		latest_decoded_timestamp;
>  };
>  
> +/* return true if time stamp t2 is after t1 with 48bit wrap around */
> +#define amdgpu_ih_ts_after(t1, t2) \
> +		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
> +
>  /* provided by the ih block */
>  struct amdgpu_ih_funcs {
>  	/* ring read/write ptr handling, called from interrupt context */
>  	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>  			  struct amdgpu_iv_entry *entry);
> +	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
> +				 signed int offset);
>  	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  };
>  
>  #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
>  #define amdgpu_ih_decode_iv(adev, iv) \
>  	(adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
> +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
> +	(WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \
> +	(adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr), (offset)))
>  #define amdgpu_ih_set_rptr(adev, ih) (adev)->irq.ih_funcs->set_rptr((adev), (ih))
>  
>  int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> @@ -89,10 +99,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>  void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>  			  unsigned int num_dw);
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> -					struct amdgpu_ih_ring *ih);
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
> +					    struct amdgpu_ih_ring *ih);
>  int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>  				struct amdgpu_ih_ring *ih,
>  				struct amdgpu_iv_entry *entry);
> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
> +				       signed int offset);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3ec5ff5a6dbe..d696c4754bea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>  
>  		/* Process it onyl if it's the first fault for this address */
>  		if (entry->ih != &adev->irq.ih_soft &&
> -		    amdgpu_gmc_filter_faults(adev, addr, entry->pasid,
> +		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>  					     entry->timestamp))
>  			return 1;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..7490ce8295c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -523,7 +523,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  
>  		/* Process it onyl if it's the first fault for this address */
>  		if (entry->ih != &adev->irq.ih_soft &&
> -		    amdgpu_gmc_filter_faults(adev, addr, entry->pasid,
> +		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>  					     entry->timestamp))
>  			return 1;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 38241cf0e1f1..8ce5b8ca1fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -716,6 +716,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
>  static const struct amdgpu_ih_funcs navi10_ih_funcs = {
>  	.get_wptr = navi10_ih_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>  	.set_rptr = navi10_ih_set_rptr
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index a9ca6988009e..3070466f54e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -640,6 +640,7 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
>  static const struct amdgpu_ih_funcs vega10_ih_funcs = {
>  	.get_wptr = vega10_ih_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>  	.set_rptr = vega10_ih_set_rptr
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index f51dfc38ac65..3b4eb8285943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -688,6 +688,7 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
>  static const struct amdgpu_ih_funcs vega20_ih_funcs = {
>  	.get_wptr = vega20_ih_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>  	.set_rptr = vega20_ih_set_rptr
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 10868d5b549f..663489ae56d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1974,7 +1974,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>  
>  		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
>  
> -		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
> +		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
>  						     &pdd->dev->adev->irq.ih1);
>  		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>  	}
