Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363A0CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B96010ECC2;
	Thu, 28 May 2026 06:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tPIfpVML";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BC110ECC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE2O0C0WDoU9N12yEIGMOH5JtORCsdPHvL4rb3bnQ60EdfAqC/MUgIj2uYJLA3bbckW5wgdtwPYqPnZlg8y9kEFV5NjSw8qgTK5rz4We/PnsUfcqSoFFhNFH/vglmoLQA+GUQ3f7JPV0hAiMY6pef70wPArFJmeJ+2KxUlXW/7jZ5L8geEiI01iGooYsrarhYeYu70HhVYL8YKiZq4NCb9xcLI6fqQjGVLFoVaZ2/IDGf0WvSYf47dh9VgDpwL/zdKmcMniWJtQ1zOf/rv4P+rWv3E+5IlmgwrhYA3a0CDBSn5j467qbxzaENeWl68p2+0bdUP/ocf4CHPhxjrhfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVle2KGkAqhSrre8UsPnFouerLHZzXCdVHS8KRcDuxo=;
 b=HCObCATvMaWK5S4T2i2YVYupMeGI3AywDoeSPD9UbrWSqawg8xOHt0iheAijyRsaox2XVsa3qfOY4U9IL5enTOwHKlvOqD46/AJtesxBB/425ACbglPypVUW15NECO1Y8pQmv0dXnE5idg3hx09lQ9+BSrLsZr5btFQmfr9mwCcUEirU8gp3fYdWDzHYsE+YfMOkFs1MSdKFIbf5F8BC4nPUpPfUbzvhXOdx8pM0VIzAIVK/Vd1ae/+COvRX6AzYVXJ8FFI7OQ2JiIyjOSHRJTCwCpDrLKM+xqr46HcDG7K0Qj10hqqB+qhmiosiiJRQivtsKQ/A6R6XVCRvoDI4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVle2KGkAqhSrre8UsPnFouerLHZzXCdVHS8KRcDuxo=;
 b=tPIfpVMLMwrU7bkNoD1Z//xP7PT253wjtpwos5opkt+/Y/f7KdO0aMAB0pifyMUzf2u7uO0P+paHZnt1M8pazBUI+uh7ecbJVm7hew43bN9vXGhhh7adUtypv5r+yUPh8LVz0SFvy/U9b4RlvoOrfXC3r5/gZ+2oZbKzkmynWK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 06:53:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 06:53:51 +0000
Message-ID: <1e9480eb-24fa-4d97-9e4e-7120bf668f20@amd.com>
Date: Thu, 28 May 2026 08:53:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move notifier_seq read back inside retry loop
To: Honglei Huang <honghuan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Vitaly.Prosyak@amd.com,
 Jenny-Jing.Liu@amd.com
References: <20260528062902.362031-1-honghuan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260528062902.362031-1-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 89069064-363a-4268-e5cd-08debc85e016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5MdJapvthTROVlX5o8oF0jHc5ZtjjDW8R7rht++xgU/2m2UG9rh5vHde81mu28pUzbvrHjuk/3RUEsE/KXjEe4umwdU4N7axugB94Oi1AUR6aB1tAY0xlsMSvUWThgam4j+PCQANpJaq1cCZQlodXSs94XGXTvV1UYouxSZASPSRQOZQxgGvnGdNAmIPAeUXOmdP0WpkV19JX6Ch0QS1XWIDHK2z1tCFffiekgM3y2N9suS8QzUQwUOL48wukxT+7aWVO8Rd0FmML+WTfHKhIFJPTSsWvMY3Eq+kW7bajaFWQFPPzlochFBOp9xWMliO5VgtYPM2Q/t8u/syLi8516tgbl51+FNcgcccyN2vcjXDSYCHzBATJdhczX/UBihitjg1SwLc49KvZ0sVUKHcgyYqi9gTcCCiC8MPM9Cs2aGwPy1RyUGdf1C4VWiNUYNbiUR56vQpm5gHCku/xT7zBhxaL8jeJhaBc8ofjDvyc3nSsB/PHAezCG83AYPdhl/PLqFJXvMm4GyRQu2DeJ33ed+KYpMFQuMPGWiNUES022fJAmOhF0rQEHPalVgpiG11s1F2GXyviuk3YPmjh/iYGd/4nduJ4DtEH3RvNpvYgeRTbNNYVKg808EPz8+XqIriQY8hXzSt66fQe8MT/8PVtPlB/nYA/s4y5nhmzxpJ/lgQWM02F6LClGSWS7A+hbLw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkhYbTkyeTBvekJUQXJYNFdnRmd4Q1JyZm1yNGZmQURnZlZkNXlXT1NFTk1R?=
 =?utf-8?B?em10eklrQnYyK1lvVWwwSGNGckJKY1piYndZcGI5Sm4ycVpUaW1MTDR3YTZU?=
 =?utf-8?B?VGFnOXNJS2xvSklveWxaeUN3aGErc01UZS9WdE1wOUxKVUJmTHBielcwUXpR?=
 =?utf-8?B?YnQ1RnU2OU9nMks2YS9RT2UyVFFSK0xiZDYvejB5NWlWaXgwaTViWGRodEJz?=
 =?utf-8?B?UER2WFdhS2pwZW1lVmc1QTY4bTZYQnNrTFBxdEhlb0s5cENvZnJRbmZSWHRZ?=
 =?utf-8?B?S2RIazNUUnEweVdiNlgvYTJQMEh6OGFqK3FhTU02Vklsb05QK1FEUmVwNWs0?=
 =?utf-8?B?enVPNnVDOGY0cHk2Mjk5TnlVWDBFYTBMWGpIUTd2SmFmTkE5SmZqdDJycVZV?=
 =?utf-8?B?d2owNWpZRmpoaGcxMWk5enk2ZnoxM0RXQTkza2pKQkJiWkh6V1c5Y21jWTR3?=
 =?utf-8?B?eWpMZTVaYWpnbkJuNldZekVadFhxRUhjUTZ6L0JVa1VZTEd2UU1SdEtwV2l5?=
 =?utf-8?B?ZVFFVGVKQXV6eUVLbXdhRDY1bldLdlNBR2NnRzJvcndzVkU3OVpWbHkvVlI2?=
 =?utf-8?B?YmhSdTY3NkNHTUZkZC9OdmNQQmJ2bjh1eksrSnd2Ulh0bmFhVGNvVWxrSlFt?=
 =?utf-8?B?MkVlbUlCbnJIby8rUXZOS0hqdVNsbDhXNXFsYzhtRGxkT0lVa2tqd3FIM0FO?=
 =?utf-8?B?dkR3Ym1PcURyNTBZem05dFM3Rzg5cVlUUnRhaVJobGRYdUNZOTNZOVA2cXBJ?=
 =?utf-8?B?WnBKbXVCSjhuNGVzSVVPRXpobFpRVE9vUFd1c1oyV1lZOE5ldWhXWmtoSWJo?=
 =?utf-8?B?WUVKTEtxNUE3WFl3Z3JZcy9EcXpGSWxqbGJlQVdWNVJCcDRPcGp5STRUTWJi?=
 =?utf-8?B?NCt6OEE5eFVBUGF2ZDgyaEVmam5aMzVra254WFFtSTJNQzVkMFJKbU9BOWdh?=
 =?utf-8?B?ZFZnU1V3SG1UUUZYRkdhMzUxSjM0d3VJelVyZkk2cVlmUm9RQk9teWVvZmc2?=
 =?utf-8?B?TnNGYWhkR1h1Ny8xa3BQNHYraTdmOHIxVVNlWG9qUEQ5bFM5Y0NrcWZKWkY2?=
 =?utf-8?B?SFdMZElsMWRhL1JtMElwQ1ZQSkdTU3luZHNzcWV4UTBhQytCd2JyTXhvaXlU?=
 =?utf-8?B?WFlFU3IwYm9KVUg4N1dCRVZ0UHU1NzBoNlZrY0UyK3B3cEFwNjQzUjNWU0ZQ?=
 =?utf-8?B?aHB0THV6ZWtYSFc1aEM4ekJlK0V5bjFKNFY4YktITWozRUJqaFBydUhXYWJQ?=
 =?utf-8?B?K0JEWjVnTVNSUTd0OWdveXh3K3diV3pKN0xpb2FVMGVPSExhOEFjZFdrY09o?=
 =?utf-8?B?MmpPaGQ0TVh0MVJLQ2FoUUtqSGNUU2hGaXViMlhXa2VrcnFKVHJhU0Y0aldi?=
 =?utf-8?B?ZkJZemUvLzNzZUJoaTZON3hhT05mSURLdXFHOHZpdUErWnUvMkd4R2xMWVh0?=
 =?utf-8?B?aHZ0VWtSa2Q4M1dxZEc3WXdhZzRLeEw1blYraWZVRXhKV3k1eWFiWmt6UnFz?=
 =?utf-8?B?MFhuU0N2L2h5YWxIdlRhTktlUlVTam5CMWJOYmxxUUNHTHUxR2dhOVFHbWQz?=
 =?utf-8?B?NVUzTzJXei9CS0xkb0dXU1M0UXB4NFVxMmN6VXNCaGpaa1F2eHlhclJpN2NM?=
 =?utf-8?B?ZDhKWWJxUjVxZFVXRWE3QU50RHl6WEt0MVBnVVRhRTQxTEw3RUZyVVl5Y3Fn?=
 =?utf-8?B?TnNlMFpNOFhyWFN1WUErTWRDaEJNaS9FV0hib0lCK1k0WkRNSHp3Zi8wZmRE?=
 =?utf-8?B?eHVxSGE2blFEbThqNk5UQS9UQWRycUxJaW5jTE9oKzlhWkRoclBJZTh5Rlp2?=
 =?utf-8?B?dXRpM2puU0l3aXRYOXhrbGlkWW00VzVyV2dQL0RGQWFMV1VBb0hkb29ZeTg3?=
 =?utf-8?B?MDBzV2FhaThhU0JxeEZHNGdadm5qRktiWHQ3em9GUmYwWCszQ05EeUJBNTkv?=
 =?utf-8?B?TmNYOXNUZm5qdDJhcGN6dm9HeTBHL0hjUlhxc0R2NXpScUJ5KzBleFh1NzFj?=
 =?utf-8?B?b3o4cHpNNENOQld3bHJTdEdmRTdWb3ZqU2pzQjJpTmFleFdpaUlFNWVKSDd6?=
 =?utf-8?B?MTFmNWFKNWNCdGgweXRGMUdNMkZJR3V5WEFzWFYxQkM4ck1JVEpFVTZJZXE5?=
 =?utf-8?B?WTBzWFVFaWFXQ2pUbHNGQ0xvbk1zT2UvTHZNbDREM01RYVUwWm0wL0NYOFRQ?=
 =?utf-8?B?bmxNWG4xSmk3VHdmMXVSdFFuaGZQWmZVQitMTWEwd2RaeGFYVDMxOVBPc2xS?=
 =?utf-8?B?UjNybW1CWlg3bHJUZUNsUk9MUmdSZmsrdGpGTW13Tk00V2FvUlRQUCtMN1Iz?=
 =?utf-8?Q?r1j2CYlZ7QdCENcbDD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89069064-363a-4268-e5cd-08debc85e016
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:53:51.2556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqV4C2t/ZqeVR2RTi5dmzvitsXZC4dt61e9YCzn7eAYhULMWypJZpWOpX+5uKwh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
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

On 5/28/26 08:29, Honglei Huang wrote:
> Align with drm_gpusvm_get_pages() (drm_gpusvm.c line 1416, 1440) which
> refreshes notifier_seq via mmu_interval_read_begin() on each retry
> iteration. Without this, a stale sequence number causes
> hmm_range_fault() to perpetually return -EBUSY, leading to an infinite
> retry loop at the caller level.

Absolutely clear NAK.

This is exactly the bug 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages") tries to fix.

The sequence *must* be grabbed before the loop because it protects all pages and not just the one from the current grabbed chunk.

What probably needs to happen is that we need to move the retry label or just completely stop retrying at all.

Regards,
Christian.

> 
> Fixes: 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 5d72878c8..ec0fe9044 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -192,7 +192,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	end = start + npages * PAGE_SIZE;
>  	hmm_range->dev_private_owner = owner;
>  
> -	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>  	do {
>  		hmm_range->end = min(hmm_range->start + max_bytes, end);
>  
> @@ -202,6 +201,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>  
>  retry:
> +		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>  		r = hmm_range_fault(hmm_range);
>  		if (unlikely(r)) {
>  			if (r == -EBUSY && !time_after(jiffies, timeout))

