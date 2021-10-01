Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 02:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C03360F6D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 02:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C03360F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5B26E4C4;
	Fri,  1 Oct 2021 02:21:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5B56E4C4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 02:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQcRoanPe8LEPL1EABMPsLLQZWldPoUWhzzt2xEYyKKDVI34SJ+mIdFQBKyM/MAEFzRQ2TuwqQlgsyzw9oqFzcDwlvkoowRzwwL226cr2kuBxoiOpnUYLy9EDb8WkSg8xE8Orhiwmy8fgDkmSGO3vmtohfM7ZICYj5VHrD0a8xaeFc/zHRnfWuwnyQ08Gq4V4lZdsFUytTi219y+40fADFngzcCrWDAYqihIqJyUGT579b7DTfhcK+fjIX9h/n6QIgN8DUILkBMkhtTM62VP3mQs7xpJhZpMjK6XTrn07Z/jgPknRpXtlLZfkwGzI4QGt6NmjRYbxIfYWWFMGbzzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRPjxDyY7/+PZkUkYuRmXfTBcM8fcb6o17/KTEcMBQ4=;
 b=i1i890tKOcryNI0jfnhA+c8dahOTrzojfZasEka0USyITXmI4LVE59sIsyLrdntOH8CA/HEZDfEwLg8m3zI/5//BC0MiJIXgJLkQR+RdoJhFVXsr8YiJemDfa+z8KXt+dRhNTwKtLBWrdZDy2pJ/NxNTf4ofHc4CQNaxf89Nl/WXv8NBx9VFJumsn+uUw44GxPaC/wYYmBWFlGZ6OBrAupOITsUBqU9TWJI/bOsP0z1GCEw96MTzC5UCWocWnDFIk/YqHVkTwvdXWCx/oTSAJo0p+PVTcHLURyjanMbP8wSlFB5FySc6jdptZTP8aGdVcG/m5h63L3HoNmERO4Hc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRPjxDyY7/+PZkUkYuRmXfTBcM8fcb6o17/KTEcMBQ4=;
 b=B9zyMCOYY4qTlNQW7gsO+3XcIQk5wru3GbDg//f3OrFa8qkt9WmAH+3oRVNQ3YJljJVTWNqt4GeoXUGX9DM8OLyVn5eInlhvxHjVWQ5G2Kg4TZBepyvTyaH4387We54WWeWqYeBq8sG+1OpSQLEnIQqncjnLR1fMewVPXXChRic=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 1 Oct
 2021 02:21:38 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4544.021; Fri, 1 Oct 2021
 02:21:38 +0000
Subject: Re: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com
References: <20211001020000.14501-1-guchun.chen@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <b7febaef-5442-1503-d743-24a6c50fa179@amd.com>
Date: Thu, 30 Sep 2021 22:21:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211001020000.14501-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:734e:479a:fb5d:ebed]
 (2607:fea8:3edf:49b0:734e:479a:fb5d:ebed) by
 YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 02:21:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df5b8f9d-29f9-480e-1e64-08d9848232d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42835F2F5C33BA60D1BEBA9CEAAB9@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwnhXOpP1PAMcg9J497nDFBxEW0tTCUzhVEl7xST7Bm1XEDMD2uy+XwKK9BfOc3A/NOz70GOnGTJkE3I9V4bos/xKSJmFks+6EffRASmwqY6ZndP4/yXobUJTtxzGBufy/XUVYQG5vXgkrfK4FiI4QMgawn2Uwb+8F8srs6DiIEavnFlyoCmv4vUrq9s7XpHZ21FI3G+LKKnMRrYTavG/mDmAZYN13lO7BUq4xzD2nUFj5AQLtZqd0NO+pvqtOVC4cOIbxI1oFJLA5u2fBC06Pp8De0whoqRvaIBdEcygoh3Onr36kLuaZ6uRwtRhirF0M78KaHLjpYXGTAtkmZ352/M6VRz6e+Bdr1WX3dQvqQuWLoaluD647amVrktFGIqFcoFqugJXkKmhJloLbtiiVRVmUmoPm3Gc9ZLW7W5S40tWCosNessmMpnPyLMGcrAO4yYzpcTP7vVW+/dK+cCmm+q4+mhOqOXOGBlBGLp+A0ae/Tcqk64EgF9jeH0DDMa+t9gxOPkPpz5GpLo+widOl6AtzFoyOrY4jZGlRHHH9PJwsc6F9v/vDXV9GGiyJJ4re3TI8L4/PsU+u4d8J/032kBg8dpwU13a1qL50RWZrtn6cbZgXTooMQfgOLSSNWk7glAHuuinx5F0ltKQ7qSbBNkHW5fx/slI5S3pOsELLIG9leE2Z4jOq78R6c8wwArmfD3FUuCqu0hYJTio8USqBNwxbsafb35Su4eSWIE5Og=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(31686004)(8676002)(66556008)(66476007)(66946007)(2906002)(86362001)(186003)(38100700002)(31696002)(5660300002)(44832011)(6486002)(6636002)(53546011)(316002)(8936002)(2616005)(83380400001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU9GL2J5ZDE0RFoycVlsREp1d1lndmQ1bFovY0ZRbTd2ZFpzbHdIZkd0Q0JG?=
 =?utf-8?B?NGptRXJsblZnVGl1R21KdnVyQ2dsbExJMzNudU0yYnBOdm5xTzdrRy9LT2da?=
 =?utf-8?B?TzlqSHFvT1RHM2tnVzBESG1GcEZZQVlNQjVjR0NWbzNsMm10Z2RCZUpjTUYr?=
 =?utf-8?B?a2tSbGJZV0pIZU8xaXRTZGVVVTZnd1JSU0ZPOG5kNkxVdUlPeGV6V3pUWktH?=
 =?utf-8?B?NVhrNmxNTDFiMnhCZGt2R3pjYTFNUjVwQ1pRTXRQOHVTUXR5MmJqdGIvSDhi?=
 =?utf-8?B?ekw0YndJQWlzcG9MYUdML1ZlNlBLK2RCUjc4RHluYkR6OVZsZGdaVXh6Zmtu?=
 =?utf-8?B?eXlBUHN3UjdxRSthZXJoa05veVh2Sll1SFl0LzdFeS9jREExZFBGcDF2blRr?=
 =?utf-8?B?OUZkaEREb1pkZnlNMkJjbCtMeGE1cTV6Q3BacU5rUVg5VUpub1BkTVhCRlhM?=
 =?utf-8?B?dktCbUlHZWx1M25vK05zaU4wZ3oveVVacW9Za2dZZlBFQ01XSlcwWnZQQ3VH?=
 =?utf-8?B?U1BJL0JPNUQzakRwWjBadXdlWTFndEN2SGhoT3dyN1REZU9hektmVTdkWWR1?=
 =?utf-8?B?b3ArY2xtVFB3MkpkQXAwMWp3bmswL1NTOERZWFRFN3h4VC9BVko0dmhKT2FL?=
 =?utf-8?B?MHlGc3lYc216VWs1MWQ2ZndpTk5lVmREcGNPaHVOb2NHekVaMnRzZEppZmVR?=
 =?utf-8?B?U2RhczViQVZ0ZW9tWUoycG5jRW9mM04rUFJlczRXMWZXWmw0WExHN2Z6N1JG?=
 =?utf-8?B?Y3dvWGRHazJLN3kxWS8xalFaMk4xRVIwbG1iaFpiYlEwNjlFRXBRaE9rd3hW?=
 =?utf-8?B?Z29CTVlldkVmaVJIY3JiSVB0dEsva1ZjMkFIWTZXN1U0Q1l1VGtwNnJMZUlH?=
 =?utf-8?B?R2hkMngvajE5S0RqdWdpR3d5eTZxSFlTZURyY0hkWXZpN2NHbU5ndG1lM29r?=
 =?utf-8?B?clJCSk1MR2ZmZEhJTTVnTXBxRHFKcURJQ1hldXBtRW1FYmd1VWN3WEtaajNt?=
 =?utf-8?B?N3J0QXppTTQ1aUVJSlcwNTBpck5oZ3NhM0ZwS3AwQkEwUmFoc21LU0k1dzNm?=
 =?utf-8?B?L0pvblp3ZjdDNk9hNlQ5UHlFSnRHZlRrY1dyNndCbXRJWDRrZllwYW9yem1I?=
 =?utf-8?B?eEJ1SklCQ3Z2cFZmVUpGemMvYk1Fek90TlRxdEJWWDJhZCt1YVV3Y05NZytx?=
 =?utf-8?B?NXQvWGtMc1hEVXpVS3VHYzJPQTdYWjJUT1ZTa2YyRm1QL0xESmJBQjNBaTRQ?=
 =?utf-8?B?dWYrKy9pVDEvR0JzQ1FldElCQTdpdUphdlYybW1pdFRaN29CbTUxUzlTM0Iy?=
 =?utf-8?B?bEY5dEVWQWd5NmRUR1J2UXFWN2tDc2lvZ1RGbFA2OUwwbmh3TWV3dzk5S0du?=
 =?utf-8?B?cnZuOE1iUTVVZkI1cnRtQXVlYmNSbE9jaTlRcUhzQUliUURoMk9ZSTlZMjhB?=
 =?utf-8?B?VVJSNlJRNzcwZktUL1FkR2ZlaklCcHExMURjMzduZy9VbnJ5bzlOWEZSYkNp?=
 =?utf-8?B?bFhVcm4rd1NjaVZyTUtEaHVISE5LT2JXUU1VWHh0SnU3N3RSTTVIQXQvMDA1?=
 =?utf-8?B?N1lJSjBmMFdtekwxVTBvUHp3SkdFYWVXU1daZlRRQlNVdzM2bW1GYmtnZ2VQ?=
 =?utf-8?B?ZTg1MnYzZWJPUHlLRXVCRnhBL0ZWcUNXT0R0ZWpyYTdEdFFEQmRhT2czN2lx?=
 =?utf-8?B?Z3JZYlpFUzFqTkkrekdsSGFhbThPNmZYWEZaRXIzRWVBamR1SHdjb2lYV3BV?=
 =?utf-8?B?ZE9ZT1B3dkdQbnFkNXluaUFZcnhYcGFpdFlOWEs4SHNhM1VwR2drcStad2d3?=
 =?utf-8?B?VHpNa3BJR09TVlQrbndUUkFrRkxneFNUWkloM1JEV1dTOWV2MnlyU216Qjl2?=
 =?utf-8?Q?hbbuPD4u6H3E7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5b8f9d-29f9-480e-1e64-08d9848232d9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 02:21:38.5999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgFLVoCPukguWuxFHY5Y7xnTUZqQPOye4006fudZM4AheHdzj3jAkw5704gEka532c/rRNwu3FWtFQxO5BhZ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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

On 2021-09-30 10:00 p.m., Guchun Chen wrote:

> When a PCI error state pci_channel_io_normal is detectd, it will
> report PCI_ERS_RESULT_CAN_RECOVER status to PCI driver, and PCI driver
> will continue the execution of PCI resume callback report_resume by
> pci_walk_bridge, and the callback will go into amdgpu_pci_resume
> finally, where write lock is releasd unconditionally without acquiring
> such lock.


Good catch but, the issue is even wider in scope, what about 
drm_sched_resubmit_jobs
and drm_sched_start called without being stopped before ? Better to put 
the entire scope
of code in this function under flag that set only in 
pci_channel_io_frozen. As far as i remember
we don't need to do anything in case of pci_channel_io_normal.

Andrey


>
> Fixes: c9a6b82f45e2("drm/amdgpu: Implement DPC recovery")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bb5ad2b6ca13..12f822d51de2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5370,6 +5370,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   
>   	switch (state) {
>   	case pci_channel_io_normal:
> +		amdgpu_device_lock_adev(adev, NULL);
>   		return PCI_ERS_RESULT_CAN_RECOVER;
>   	/* Fatal error, prepare for slot reset */
>   	case pci_channel_io_frozen:
