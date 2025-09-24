Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD1BCAC5A7
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 09:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D3810E6C1;
	Wed, 24 Sep 2025 09:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xjAxo5d7";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E25810E6C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 09:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8nrGQdLywTPROXmmASCES/834CmL9a2veM1Y91x0K7Vz4YcNQFilonN38L6CrgMcChFy/U6SH1fZ/DnPq3MrYVqKAJkDVsMCHYZj7hZ4WqCF8AdOKRqdB/sm4jgwXLONFfgkkV7b+/8GVlWkpMMkQGcsUDyQuZ1Eq2cRs2VQ3SS5gTSNXQs0hrUj/+4TnF4Vcw/jirTn5t+7odC2DArqNzpq2mu9e6ZwjnJxU9t3KCQ4bC4GRIKlRGD0GUgIbYu7Y+xcAerlDaK9H7qxg7lsIdx2xrJdJgDeHFvxLOthfhfbhtmbHfHyVDI4DkIrYHaC6GUGZ+oqvFcm2sM1ev1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s95InsFQ1kY79JO5C7Ib5OZJqPIAkhRR8BCtpd4BzQ=;
 b=RwqnBll3jWGYCM5FG71Q2rJ1qu7X21PxfR+yTs4VKgJgxoRd5tHa/nco3ilLVm7l/VQ4hfeRTz5F0SiqSoCsBw5chQGdXP1kCNfBVEvJ5XcsgBPhB0755vPwXb67MSqYv0+sunGxS9+wQuebZKCle+VeITtBIeRdJpnIbisKLKqCot7mZyntlbDJvthjI55jAfekKpdPj8ZBXtiaBgskO7s/Krpg+LKRFRoEyALn8aB0dN7bjJgjIJDYYyG0wAc2nuYJ7wf8iWiaCqa9Qpv4oMCa428MBBp3Zh9H/Pn/GTdc0bWNum64n17xlhyatljKagcSANdn9M0kfQ+0YVOZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s95InsFQ1kY79JO5C7Ib5OZJqPIAkhRR8BCtpd4BzQ=;
 b=xjAxo5d7jSjonVlavYfVEJQOGmssE2wwcyuomvCylZE41duYy4F8UoPlXxHDSK5UKzSW7roKawL0OXwhr9fepS/4WIjXQ+N8nUN3pT1ShVLHymfUNWmpuh3GQuZk4HI6ZLPMxP0mplPcDY2fPRfHJuwizdubpuwoKSoGZ7sSHas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:08:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 09:08:36 +0000
Message-ID: <c76b95ba-5a2c-4126-a22a-60a54d38b22b@amd.com>
Date: Wed, 24 Sep 2025 11:08:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] drm/amdgpu: Fix fence signaling race condition in userqueue
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250924090226.2343264-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250924090226.2343264-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:208:fc::36) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 2369c929-204f-4f8a-8566-08ddfb49f1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2NQQWwxK0s2OVJsbmJ1MWlsMmNmMWkzOWFaWWRzZ01odE9CSjRBQUR2Wk9E?=
 =?utf-8?B?QWV5VDU0SVhNbGFzbUlsNjQ4UVJpYlBBREJoSnlLZmx1RXNGUG54Y3ZkalZs?=
 =?utf-8?B?bTJuS2dlZnpteUh0MTBRU2IxVng4WHpkbFB2b1lHcTJHUE8ySXdUNVB2WXR4?=
 =?utf-8?B?OTVGM29xY3JYZnFLZzFPd2VCOWwwZVU0M21MK1BQMUkzYUxlbFlkMTArT2ZC?=
 =?utf-8?B?VVB1STdyQ1FzQjRzS1h5R3Z2K3dMQTNSOThpbVJTSC9pdHBacEFTQjZSUXM1?=
 =?utf-8?B?V1NmeDNHWmVZaCtlMFh4ZnJCK3gxVmM5V1dnVHdIeWVja3h3TEdheFljTWhu?=
 =?utf-8?B?OXF2UWswWE9RbW4rQkZ5bDFsbnMxT1lFSm9RT0Y2djdRc0swRjBoNkEvRXp5?=
 =?utf-8?B?TVYyMWNjY2d4WHQvZndvT2hSSlVlSSs3LzdnbG01YWswSkJ2bnJWeGk1ZFVL?=
 =?utf-8?B?alJrNFBrbEZzZFVNaXRaUGh0bEtBWlZNbFhpb3pDSmU2UHZ2MjVpTGRsVXhN?=
 =?utf-8?B?aWI1WG9acW5uaGNxN1lRTVlEY1lKRC9oSEFORG9yOFpDNkROZ0owM1RVbCtm?=
 =?utf-8?B?Q3d3UVhROWlyS3dnUm5kMi8wdFFUbURtY3pVaUxUQjJsSHd5U1l1a0RPaFZ6?=
 =?utf-8?B?UFZaMlo2N0pJK3crSnVqbGF1bVl2d0JaRFBERVlUS1pHbXlzUSswUFNEUW9o?=
 =?utf-8?B?L3YrTkVqdVluVXdDN1hQMCtPTUU4TlRlWkFleFdwQ3UvSWpaVk0wT2M3ZTZx?=
 =?utf-8?B?RjJpQTk3VlhUUUEvU3gyMEUxQ29yaEt1bHR1Uks0RDNFTklrUkRldUtqdGdS?=
 =?utf-8?B?TmZoalYrTk53ckJBazBGS3Q3QzdBMFNOaEtLMGxsWjFDNHFITkVrU2JmT3Fy?=
 =?utf-8?B?TE5WQkhXeTJXSmpud3R1b0t2aFRlMU1ZenpzTEx4dGt0UDdxYXMySTVFcEt1?=
 =?utf-8?B?L0xxK0VadnFkaVdPV1VOZTZZWG1ZYVNPOW9pby9Oem0xeEpnQ1ZBdnQ3WXBy?=
 =?utf-8?B?YlNOT2ZUYkpINENUbGlQT2FqU2E1bDVhT1dwMXBBSTg0NGFLQnhtOS9KQlVL?=
 =?utf-8?B?K2hUakxsbU9ab2lpSXlFbDFseG5INE5YdjJXUTR0T0EzRE1BQmVPQUlLNEtD?=
 =?utf-8?B?dTE1bEJneDFPbHZNWUJHcm5vQ2RtQWxMNzJISkpGYVhLR3ErV0tqcnBHQlhQ?=
 =?utf-8?B?TkM3cWpTOUNGd0tOdmFxdlBkdi9HMnZuRitCbGFlY052bG9UeHk3UUY2VWcx?=
 =?utf-8?B?c01INGFwcCswWENDRkREN2ZRN0k3Nk5ISm1RTktTUTg0YlVML1E4c3lNN3c2?=
 =?utf-8?B?K3Uvc21nN21EbEVCTk9BWVZPSTNDWHhnQ2hGdlgrNTB4NVN2RUNpa0NoQzZV?=
 =?utf-8?B?cHZxempTRW4xck50LzZuUmZSckQxUmJtcXA4L256RFR5cFhDc0h2aVVnaUhZ?=
 =?utf-8?B?ZytsQi9sTjJJLzViR2NwVlRvY1VTNmRsSHNhRUdNRmNuQ0dkcE55c3djbUdN?=
 =?utf-8?B?cFBYeTgrMlFnQllFczlLRlF3SWFkekM3TVM5WDVrT0VJNTVoWnZzTHJWNnE2?=
 =?utf-8?B?QjhZcjJkeXVaN2FTaEgyVk0xeXo0N0lKbmsvbHEvVDBQNE9WV2dhY0FGZ2Q2?=
 =?utf-8?B?R3RKcW1rbHRSTks2NThFREFPUlF0R0ZhT0tCejRFR2JlYnN4UUpoTVBHdmZs?=
 =?utf-8?B?YXN3MGZqZWNwV05ZQitJcG9VSzhqNkZLVmtCMkE2Z1B4NHhPYVJLYStvTVFP?=
 =?utf-8?B?bE9WenZWM0pSTk83VHU3aG5VZ0Q4UFEvNDRNNWVHRmZ0VHFUMzFHcFJzUWVi?=
 =?utf-8?B?SzNUY2RtRXlGNGVXM3cxeWdqVkUxMUczVC9QbXpoN3ljSUVKK0hHcysycFNT?=
 =?utf-8?B?M1lIMHdVWXEyaVNpVHNMZGcyNkptUGFyNjJ2Nm1tTVVHUWpvWjB1ZjlPRCs0?=
 =?utf-8?Q?aQJq3BXb+RE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUF0L1JVbm0rQU0zWGJOZThPTWtaNkZtUDhBcjN0czloNkNHdGR5RGpxYkZN?=
 =?utf-8?B?eXhBM1pwR1NqNVk4Q0RSUjRrMG96eDY3d3lOalRkVlF1dXcrY1NLVlY4K2lp?=
 =?utf-8?B?anFNV1pOQS80VnNrUFdhU05FYndtaHI4M1lZMmhzV3NYV2tBU2djVU9kMm9x?=
 =?utf-8?B?RzBDZE1IQkQvcE1mWmhzSGkvdnJQU1ZCbmo1aDlCY2hEWGoxY3NLWnM1N2RY?=
 =?utf-8?B?U2VMa2Vpb1NDQXhzWXVwQTJEZ2IvTzJFemw3TW1Sd1Q5TlMwMzE3ejJaZFJ1?=
 =?utf-8?B?UkxVdWNCS1RqRng0SCs0SDdkcGJMUXUxdjY0ZkpoakhkVFhFTmNrRlpSeHRU?=
 =?utf-8?B?NmZreTVidVNrb011RjJEaU5WMDZ1L3FoVmQzUGxZQll6eXIrYytQbytqQy9Z?=
 =?utf-8?B?ZHdhQXA3RVdVeGtJbHNVSGY1RmljaDhORGh6dVJXaWxZRkxucEVHQ0RZbzBk?=
 =?utf-8?B?QlJqVW9xSXI4eG5yVHRNemNsQUZzL3ZXYU5GbUFOOURrekRZREUxTityb2NB?=
 =?utf-8?B?QnlNZGpRT01UbXZxNFgzTlE0U2VhTEFmMWw3UkhjTnhkbDRWQXV6Q251R25k?=
 =?utf-8?B?Vm1uZ3ZNMlluVGNRNWNhZldSVnRrQWdTQ2tZaGp2SW55ck13MFNsNU0zc0lN?=
 =?utf-8?B?U1Z1cUlTa3Nhb1VuKzJmSWpDY3ZHRktlNm5ldys0VWQzV2QwS3RDVFJ4aU42?=
 =?utf-8?B?RVVDeHA1S0tXNjA4NjhEVVY3QTRJQUYzNDRCN1BKUU55TkwwaGQ1akpFK25I?=
 =?utf-8?B?aUNJNit0YmhQeEt0ZGhEVUxsYnEwMmM5MnNoSWpZdWxxditTR2F1a2M4VzRD?=
 =?utf-8?B?dEY3dzBtTHdNTk9Rd1oxaitkRFFkT2FIOUc5ZXJGalZ0bHZsaExSZDBabVFB?=
 =?utf-8?B?ZDhmQm54WkkvUU9EejBZMTZsdktZUk95d0JPVW4wWUlkWWZKa1lNOEV6b09o?=
 =?utf-8?B?eHduUkhaMlNlWGVnL3FlOStDQzFtRWN5TDhnUVlhaVEvclIvY3RqM1l6TXlr?=
 =?utf-8?B?eU11enVhcXl3eFVaYzZCTWd5YnRaMlJ2c2RsbVBQL1FBYUtjaG9mWnJhQTBC?=
 =?utf-8?B?UEF1Mi8xVTJnb3Q2UnBjMjB1NWJGYThnVThIUndQckxDQ2ZYM1ZUMjNUOVJs?=
 =?utf-8?B?ZklWSlV6YUY2QTZ5VlM1ZlJjQ29qRWFmVjlDOTdTL1IrNVZqTU9OSElKbFRV?=
 =?utf-8?B?cXhiV2FIOVorT3BZRmZBeXh0RzBvMGNBTmZiOE8xbVZ1eVNpNzdTNVJWajla?=
 =?utf-8?B?S3gxRmNZNU1Bd01YL29vNkEyUWF4Q2Y3ZTlNSW9FZHJhVnBXQVY5a1VuM3VT?=
 =?utf-8?B?TXVNdVR4b3BvZ1NKZll4T1Zrd1MwMTJUdTBIV0FZZnVtV0dDMmRWbGpwRmp1?=
 =?utf-8?B?K1VJMmMzeFdDbUJGRFhvVWpjTlBScWxOekZ4WTdWRjJKWlorbDAwQWoxZDll?=
 =?utf-8?B?Mll2N2RQRUMrUk1aVTVEb25VM3NSMEEwd1dLMm12VjVGSmlJdDJaaWplSGQx?=
 =?utf-8?B?SDRuWWQvbkRIS3ExUnVLOHBWWHk4aEhkK3AralBaTWJjRVBoRjdPOVhZdmx3?=
 =?utf-8?B?UmpJa1RCa3lvWlo0b29rZ2U2aTcxTjVzZERWVkhlNFZwWUs0ZXpXMFArZS9W?=
 =?utf-8?B?VXlyM3FTZGRmekcweU5tSkNTNGh3WFBUbE1lakkzUGhTNTlha0dHZmlUbTgv?=
 =?utf-8?B?UWtjcHhSTkNtNHNPR251Z0EwOFVZN3BqOHJHNlMxT2ZSdWlhVkF1TVJldC9B?=
 =?utf-8?B?NTVIRUxwWmp6K095UFh1cVJvaEp6QWo0WlA2REQ3Y3FnM0t5RTdaOXZERStu?=
 =?utf-8?B?eERzQU5UbWhDYUFhTDhSYlJCanBjQlFnSlo0a2dRb25QK2UvT0ZxRXQvSHZH?=
 =?utf-8?B?WEdwemY2bzlCZHM2MVVUbSsrRUFBUDZDZSt1L2hVUFFqdHVwV2FPcGFzb1lR?=
 =?utf-8?B?L3QxeVgrZ2ZIOUppNzJPamRSZlIvS1pKamVxL1QyWU1oQWFaQUdlbjBwV3pu?=
 =?utf-8?B?bmJuWjZUekxtcTRTOVJuWGF0WlIyUUszVnpLSk1tRTlxcXB5TzVsZTlNUmpp?=
 =?utf-8?B?czNPTUNVRjR2MWp3K3J0aDZaL2ZYYU9aQ3NpUk95QWh3VkNadTJKclFJOUlM?=
 =?utf-8?Q?1B9q58v5kPrMcDdrnUJzmNvIs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2369c929-204f-4f8a-8566-08ddfb49f1a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:08:36.3302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biHOU1gydEf5bNqAwy3W4jTQZ+IeVC0XcauWZXhMrER0OwBjUffeJuYfZWidSxMN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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



On 24.09.25 11:02, Jesse.Zhang wrote:
> This commit fixes a potential race condition in the userqueue fence
> signaling mechanism by replacing dma_fence_is_signaled_locked() with
> dma_fence_is_signaled().
> 
> The issue occurred because:
> 1. dma_fence_is_signaled_locked() should only be used when holding
>    the fence's individual lock, not just the fence list lock
> 2. Using the locked variant without the proper fence lock could lead
>    to double-signaling scenarios:
>    - Hardware completion signals the fence
>    - Software path also tries to signal the same fence
> 
> By using dma_fence_is_signaled() instead, we properly handle the
> locking hierarchy and avoid the race condition while still maintaining
> the necessary synchronization through the fence_list_lock.
> 
> v2: drop the comment (Christian)
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 59d0abbdfc2f..aab55f38d81f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -289,7 +289,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  
>  	/* Check if hardware has already processed the job */
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -	if (!dma_fence_is_signaled_locked(fence))
> +	if (!dma_fence_is_signaled(fence))
>  		list_add_tail(&userq_fence->link, &fence_drv->fences);
>  	else
>  		dma_fence_put(fence);

