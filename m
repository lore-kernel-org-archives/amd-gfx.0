Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A0606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lLW72yuP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26561112342;
	Thu, 29 Oct 2026 14:25:04 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC4E11233A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKZPPXXxWV6MOHwCq96a72fG5e1We9ilL8iQsKCbw6Svk9HIkWe2o3auVwYt/WU4mOfKGh2EzbHeHDdCyamC3KRq7QrGMhEknCg9o6xeJvaukr8OR5CsauqWTWT7tLZNn5ghuiuuN56Y/vzEJLlsfoUqc0Zb1pVO7z+w32vO+LPE6VliZYUwQ1ZmLop3tLjv8TdmkVOezIYnCwnDgNxWhJUdrqFG/GDv/NBsUdmLSqx6howD3+MUF2mJNsIp4ufQxYnp7pHL23Tbw0uCTfzWSS/kyP/ZEPVIZ20ui7MGaeP6gSPi+gA+QAH/0lhtUPK7t5E1chxQOpr6LJX5oto6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6qwqRtyX+9ZKgO1M0mPgWEQjJTqnKS257w/RDT8YJY=;
 b=L/lf/xnQeIEnFW5+W0qLtXG4PBFLBoNEHxhLxsyHxWg7CuMcE7Tao+Lo86h5bWKPIcCpjKpl4Mne7NHar77civ3/EQhjRvB3IeEdlx0DORvp/qnEzbRjQjPbCbXEifL2nAbYeVa2lx61lkt++sC+fEcCMzk7Uvqaaug6Y38ez0kZwx6vklE2uKzmpWudrRt4g8q9I176VCPYk1rZ5sCTV8qnZUfRgmt9Zx0YNW7YJZ8ANJArrroyYMjhHHLa3Jtjg8ZUHAlO7GaPs+z4MIUd20l3iOJnUBVLhvK+lermJ0kwGjkv6dw/gAEjToaVh+rfP7afFU+yM5U1rahUELJTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6qwqRtyX+9ZKgO1M0mPgWEQjJTqnKS257w/RDT8YJY=;
 b=lLW72yuPAbgyMsEOaWagpcuFidVzI1bCFzGqR/1IgiggHuBPPr/nx7wZVs+Wl/XYiM1idC+AokNqP8bQlN5PV0YCtqM11OgpZkB2B2LKRmXjQcrMa0Skndz/f8Zz4B2ke/vDsOXPJRThnt1n2gm+ZOC+Lk/Wvake5sq8MPkUdog=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 14:24:53 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 14:24:52 +0000
Message-ID: <94449469-f883-4fe8-bc41-395c48b071ff@amd.com>
Date: Thu, 29 Oct 2026 09:24:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Ensure that harvest information gets set
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261029142209.3534836-1-kent.russell@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261029142209.3534836-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:8:44d::18) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f99a5e9-531c-48a3-696c-08df35c86575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|261022105027099003|261022113327099003|261021121427099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C0GASF5G/iSuF3/lQFYSwua683lIoQ8Io0txBWch+DZb2mhtW5S3XcKjLq3G0eXUCNlJ2j/6kWraDLuWhFmUvWou6CKVBKqA0DLtBROB+cc5a6LUVHFP8ODT0YYChHH7zyxAVfemUV9Mg10Hw/+tctUhctGKR+67IxhWnoG+dBJvkLiFkOmUS60PtikiRd5xVPdPMfeL5qCvQWe1/AwG12i2Pm+3PWDCgKtFSeIpgL7nR3apNVKpZAxt2CtTDMRgR9ucOI5DYHUgjdjdBwpy7s1zvj1qaKP8oSZSQj6oHf/6lZziApR3mDAGK8gfT9xLd/GTnuYkpOEFzBMMFXQc7x5+FkfRhbQIglEeXYsTy1YHdTt0YygC2+zgqVW6GQiBaDUfldBgobXvA7wpiRRAFLQKCxlHUlejNt8m67iHzv4g4ixVYZf5DGz8/rlscnO9KidB2il0t7J5w3LcKypAqv4oBV1clHgioQIx8I7Thn5bc5Eq1K5CjIIwc1+WetFqWQI9nSQCY2Fcde4mY2kkn4dPKJvIwNL3g578Uoh/QWqhiuRxTgZtNLSiFMSQ1lcaixBquBKiLBLExoHDYtbtmRZPU5FwAtok5NRzEzU4oQqoZ2WRP288U00hM8sWaIh507abBehCIym5OHoIatE3QfoCR0F2mXk0uSAv5mJBsqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022105027099003)(261022113327099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3JaZks1Wk9wcmZvb1U1cGhNUXp5VUdnKzdyR1VnYXVYL042RStQYTlNWnRS?=
 =?utf-8?B?cTl5QmZ6VG93dlk4cW9mZVhKWHliYWhWcVhmOVZIMjJHT0htbGJYSWtVQ0xk?=
 =?utf-8?B?SHBaR2QwSUdYR2ZBZFFBZUZNUnZuZER4dmxLVE01Ny9CS3d0YnhJWGhWU05r?=
 =?utf-8?B?R0g0aThHYjFSYW0vM1k5TkZLc3c2WGhXQ3lnemF5YTlGN3UyY2JaNnBsYzZK?=
 =?utf-8?B?MlRZcFFGN3QySWhQMmVMZHNMRUV4dExlcjBVWUhQcmJNNjVwTFFOb0IwTVE5?=
 =?utf-8?B?Z3lnc0djakhlVi8wME1xaE5wY3ZZYjNMYVJVUkwvMk04em1vQURhVmU0ZUhT?=
 =?utf-8?B?cmh0cFdwSFZneEVpS1pKaEdJTjRDcXh5cHhyTnBaRHd4MGsrNTRDUit3S0lD?=
 =?utf-8?B?TnBWYVA1dlhSTmwwNVpoZWlMNTlJY1RBZDNiVTM0bHJpd3F3eHpsYTNJdllF?=
 =?utf-8?B?bTBkb0RnQ2NpSmpRUXBVMlFRTEM2aFRvL2tCL0tXNHNkVlBlbUM4bVVOTXFI?=
 =?utf-8?B?ZDRkUTFkT09zRGZHM21saUNpNE8xU1BCN0hBeGR3ai92ektSRnl4Y0pJd0wv?=
 =?utf-8?B?dE9CZlZMeHNYcU8wTDNCOGdocjNPYlVheUxJZHd3NG9leEowYmgzbDBVeUZ4?=
 =?utf-8?B?WEVPSVhseEtHVkMxMjc1N2YvK3dxK3IxUFNNbU56ejhxS2E0YWtHK0tmZlZJ?=
 =?utf-8?B?RUY1WGZRKzlUSUlmdHBPUmNCc3NjYU1oSXp6czZpZDZqMjNmdWt0TEpvSTRQ?=
 =?utf-8?B?NWlBa1NFZVNrT0hYT2NwOUcrOGpvR0VQOXpMUzMyeXFOV0FkL3JCRU55Mmdq?=
 =?utf-8?B?V1JnLzBudGR3aFZDZXV2YWpZamVzK0duN3p1MS9vUlJSOVBsTisrSTFKdVBE?=
 =?utf-8?B?d1phdktUMmExYzlnV0U3SmJuRDZUR1puTzZ4N2lUOUtHL0JSYkIrcTAwVHJm?=
 =?utf-8?B?YTZnMnJJQWdEd0o1eG9qdmJxbng0UmovWGdKTnRidVhZUnQ1S0JiejlyYWRl?=
 =?utf-8?B?OGJjUzdHYkRKdmhLMmZqa2laOXJiaGxaOXJOU0ZEc3VESGN0dzNQT0lCcHFV?=
 =?utf-8?B?ekhQZHJWVTUwT1FSRnRxd0VkRzNSQzVKblNjZGk2eXZIN1hCRm83UzBVbEQr?=
 =?utf-8?B?T0RlOEs3SFNoWXExbmNQTWtORERIcUdySTJsY3JnQnpTM0ZaNUFyRjgzUHVV?=
 =?utf-8?B?ek5yUFNXbUxIbjBhUWQ5SGJzMTRPVllHV0w5Q1RMd3F1WjNwYy9BS1BBK1Zh?=
 =?utf-8?B?bEJJbHFQSkVPa1h6UGF2WFQrZmhYa1JNTFBCSTRzdXlpN0FUb2pWdGNJQ1lx?=
 =?utf-8?B?dEdHaFdwOHN6RzRyb0g5M1RRMllQUjU5dHVPQlZTcEZNV3R0ZnBLQTd1cHJK?=
 =?utf-8?B?cHdIMHcwZ2ZVU1BPVkF2akNXNStieXZRY3E2UjlYZG04a0ZMUUxJeWoxTzQ4?=
 =?utf-8?B?dDhlc2Jib1dHd3EweTBMZFl6WGhZOFJoMHJHcnR6SDhDMU9qUnJWaVEzdi9L?=
 =?utf-8?B?Z1ZjMk94RGhPSklaL203VGlYd1dlMitaTnc2djhxbmVQYlg4TWh4NGVFZXJQ?=
 =?utf-8?B?ejJZWkM1Tm1QMXIvWHdOQ3hoMWI3N3U3UkNKWFVlZCt6dW5jVFFlZWZ5UGZi?=
 =?utf-8?B?aWkvbEQvMHZJQUJaVVBKV0hZMGUxQm5xN0szQ0JqajZYRytiSHJicks3Y01v?=
 =?utf-8?B?RzJUQ2VpdjBrZU41MjFxaGRzd1RWTTZrVnhrU0RUV0doQ28xTFBWeEQwMm40?=
 =?utf-8?B?TE10enowY251cHp2cmtYQ05sK052bmN2c0pta1hRUXdYTEtwM3Q4amhIRzJU?=
 =?utf-8?B?YVpBc1ZIb29aajN0MTdhQm56aXpaVkNRZ2daYmZSazJwTHArZExHck1UbkJX?=
 =?utf-8?B?Nkt0MGpEcjNpajgxendkZTB3SnNEMmlta1ozZnJzL3BBRjV4TUVDWi9pajVi?=
 =?utf-8?B?QUZkZWNDeEdLMzlnWnlTNGdmOVQ5OFRleFlFTWwvZndpbkNDQm5DcUdGaTQ4?=
 =?utf-8?B?alU0OGNVVCsxcGNJd1kvZi9DUjVsdkg5QlJNWDBWZ0Y0cVpXdEF1cW5jQWdQ?=
 =?utf-8?B?ZEIvdDBHRXJrMlA2bGxSOWZSaVdGM0NkSk5uNEo1THJETkdsU2laY0dxS1N4?=
 =?utf-8?B?NkhJeVRjN1Nvem1QQnh5SWhOeEF5Q0tua0NuVEMySHNFRDZHY2x2aEw2OXFO?=
 =?utf-8?B?bXV1cGpMckZoQTgxT1RZakhIS2w2WjdkN2NVd2YzR0FJLzV2ZkVlQzNDVmQw?=
 =?utf-8?B?NmpVbUpnRFJKd1h4RldES0Q0QjVKMjY5WEF5c2Y4YW1xdDBnbHhBK2p2ZXFE?=
 =?utf-8?Q?WQEDUB1DxPf6yVw9N3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f99a5e9-531c-48a3-696c-08df35c86575
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:24:52.3643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FY5uCBxmJGlXyf53t/Q/Ft5x7JXmqWWgYDhxr7IdSMyyJ7cWIuIc6Yiy980Wmwj70NsaeD7KuogSi66bWCfHIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/26 09:22, Kent Russell wrote:
> After the earlier patch exported IP discovery on probe failure, there was
> an unexpected consequence where harvest info was not populated. The
> early-exit in amdgpu_discovery_sysfs_init meant that we never called
> amdgpu_discovery_get_harvest_info, which is where we set the actual
> harvest value. The first time we call amdgpu_discovery_sysfs_recurse
> with NULL instead of adev, most values can get set. The 2nd time
> amdgpu_discovery_sysfs_recurse is called, we bail early.
> 
> To keep the logic of the first patch intact, ensuring that older kernels
> can still discover the IP blocks, add a separate call in the early-exit
> section that sets the harvest information.
> 
> This should be the only functionality that is missed in this flow, as the
> rest of the calls either work fine with adev=NULL, or use the discovery_bin
> directly.
> 
> Fixes: 3ee1065e9830 ("drm/amdgpu: Export ip_discovery sysfs on probe failure")
> Assisted-by: LLM Claude
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 44 +++++++++++++++++--
>   1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 16e3129db6a1..79a2b1268b23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1469,6 +1469,40 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +#define list_to_kobj(el) container_of(el, struct kobject, entry)
> +
> +static void amdgpu_discovery_sysfs_update_harvest(struct amdgpu_device *adev)
> +{
> +	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
> +	struct ip_die_entry *ip_die_entry;
> +	struct list_head *el_die, *el_hw_id, *el_hw_inst;
> +	struct ip_hw_id *hw_id;
> +	struct kset *die_kset;
> +	struct ip_hw_instance *ip_inst;
> +
> +	if (!ip_top)
> +		return;
> +
> +	die_kset = &ip_top->die_kset;
> +
> +	guard(spinlock)(&die_kset->list_lock);
> +	list_for_each(el_die, &die_kset->list) {
> +		ip_die_entry = to_ip_die_entry(list_to_kobj(el_die));
> +
> +		list_for_each(el_hw_id, &ip_die_entry->ip_kset.list) {
> +			hw_id = to_ip_hw_id(list_to_kobj(el_hw_id));
> +
> +			list_for_each(el_hw_inst, &hw_id->hw_id_kset.list) {
> +				ip_inst = to_ip_hw_instance(list_to_kobj(el_hw_inst));
> +				ip_inst->harvest =
> +					amdgpu_discovery_get_harvest_info(
> +						adev, ip_inst->hw_id,
> +						ip_inst->num_instance);
> +			}
> +		}
> +	}
> +}
> +
>   static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   {
>   	uint8_t *discovery_bin = adev->discovery.bin;
> @@ -1479,9 +1513,13 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   	if (!discovery_bin)
>   		return -EINVAL;
>   
> -	/* If early init already created sysfs in standalone mode, skip normal init */
> -	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode)
> +	/* If early init already created sysfs in standalone mode, update harvest info
> +	 * now that adev is fully initialized, then skip the rest of normal init.
> +	 */
> +	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode) {
> +		amdgpu_discovery_sysfs_update_harvest(adev);
>   		return 0;
> +	}
>   
>   	ip_top = kzalloc_obj(*ip_top);
>   	if (!ip_top)
> @@ -1536,8 +1574,6 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   
>   /* -------------------------------------------------- */
>   
> -#define list_to_kobj(el) container_of(el, struct kobject, entry)
> -
>   static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)
>   {
>   	struct list_head *el, *tmp;

