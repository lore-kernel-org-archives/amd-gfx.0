Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62460A3834
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m5Uvy/tg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ECAA10E6C3;
	Thu, 29 Oct 2026 18:10:23 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EED410E6C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 18:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ6hBrc0zhHS8rWYHFJqQk3k4OWmwQnkis4NCKFQTHq4R4AoLJ5NpKEFqUroKj1H0F8+W06T0fltRLc/dBST0PnGJxZt25dg4V0GJ9zkQV4T2Qy0O+LbcE57zR0K9D84h+cORwq/I2dcjlt8ZFM/yFXP3J+3NmfO8X1tuJME8/qs21zaMqVkuHtPxnfLpekKHeMrFznqxI5ecoXVAoq8HPI93TGK72gNngHOTMbk7SMvwJ5gPhdeBgwh8RkIDQUPa57Vw8HAQzzdM26//esIP8uM04x3tHOxSRfAcNkt2LqZS34Km7/G7ecqX3mV1R71sdvCY9JQjgkm2zKG79lhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDFtCaFM3msNLdICOv5A8pTIgducjle6eXxiqNLOyIA=;
 b=pTHbMlpllRAwFOsEj5QHNT3PxXVMS2/6xK9KImFmAVcPsuOi/XUzCBHkDCYdDtTcdfEBMX4IngScHDzEKzWDHSX8PAJh4fzkol3OYJp4iachpDVgh/lozN/1ZqmwgSAa0QJU+vwGSSN1wU0/0KyPQaFgHqIeZtW88XTcQ+KTRfsMJs+IFdsbNz3PzW0QHC+UXhQqybvB7u04fuLmmL9bD2bc/shBX7Y/7IiEYrsdFiHv7+ccW4uTbNq8x/rlj/R6em4G7h0XB1Yv+Pi4kZSxpsYsJxtHyniyHSOXxPQREtsVVmB9qO8VUth1i3TIZWIIJ6UzwhWLaNVEi6Okh81C5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDFtCaFM3msNLdICOv5A8pTIgducjle6eXxiqNLOyIA=;
 b=m5Uvy/tg/zyIeGawRHzzuIjKoicxYUZAWrvxx1tYXoicUiI5RRN/izrlg3U58ITst6vl1tzN7vlg2zVSuOUIFyBweRRZu6QL7+g6sBQvQg4SPNBTOeb8mJSU4evKHQ2rERTRp4C+uOOnrWxW8ljjBdyZpFi6n7BBOrMIEnWRChc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Thu, 29 Oct
 2026 18:10:12 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 18:10:11 +0000
Message-ID: <15edff8b-a5fc-428a-8e1c-7f0c5c5de3bd@amd.com>
Date: Thu, 29 Oct 2026 14:10:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
To: Apurv Mishra <Apurv.Mishra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Bing.Ma@amd.com, Felix.Kuehling@amd.com,
 Benjamin.Welton@amd.com
References: <20261026184707.103933-1-Apurv.Mishra@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20261026184707.103933-1-Apurv.Mishra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::18) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8887b2-0bec-4f33-56f2-08df35e7df9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|5023799004|56012099006|261026140227099003|261021123027099003|261009221227099003|261009223027099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|10067099003|261022105027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: zLCIHYTrboygfjRsQPJjettYAQbOp8gAEIXg6zaMmPGhRhsvsNOxkrCvcvD4flRiQQmqk+f4A8A/hUAwppB/GrlFFil3OW5ioqHEFlqU8YvnI5KTVQU/h2PqXNjbxnMrZpkwyFCCR5eBz+I6ECVzJIn5XwRhpO0KSK1aydflyr2mwaP3AkFRfW7/n7v4SnCTM+IoZ5F6ibXHD36vHk1dH6u9mTyasRJ53A95Ri6GPc8LyiHOGn7LFQn3ur19SLHBTU0RmvIeHCVFfKkgnaqeLY6HteEfmGNPpnlN4Omae/NPs74w6HxWjx4Z3hdF0O7kS3zHNi70iYbi8G8m8J6wFUXTz3+AWlordNPJ1E/DI1t/RFUybJA6dUtI/GtJsX4SCPqQmlLVQqHPYqSmTVkBO153+cuaAlu7T1KW7d5gQZznZ7BYhPGAB5ZKhacSpchr53XiuusSF1OZzELoETfh4Pq1RzhO1C1APsTBTfWlbh+FbkDArAgCbC9dgHKJztowJffcQSoaZVxgnOeQZl50wGkGrZ6PIgAlIsbXf1ysdqeVF9nZ7g7+Ny+E24UKGQ72PTJXLHKdJbhyrXMLCIFM/ixsp716pGn4mBaWaDeB04ymon7y1NZFEm1QiRaZg80rb9Xw1v/CLBDCxpYRZtSwpKvRdlIAT06FhAZ9ynJlM24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(5023799004)(56012099006)(261026140227099003)(261021123027099003)(261009221227099003)(261009223027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZodWlNZnVORkFQSG9LanFacytxN3RJMnVRQ3JFTmc3dDhNYUZHZ0YvbEJY?=
 =?utf-8?B?SHN3TWk1TWFKMjVkNzEyaGkzWEJLZjV4K3k5bFFwNW9wM0tYMkIva0xCNUow?=
 =?utf-8?B?NDIwTktWdEZnNkV0VFl1ZEtzM3pDZC9HZ0orZytYMzFOQ2QybkVRQmdXQ1hp?=
 =?utf-8?B?SnE1cXJOa2dLemIxV3I4VENDUUFkUi9uQndGeXgvNkd4TXV3WVZsV2ZlVWF6?=
 =?utf-8?B?eWtCQmh6SnBjRDZ1QlVvRXVBNkhkYWxsQkQ5ckc5a3NTdk5sV1lJYmVVVVow?=
 =?utf-8?B?R0VMTFh4SUQ0MmFYMW5rMU1EZDcvWmZROUFBVGZ4eUJuVDRsSHFTVGtOTjBp?=
 =?utf-8?B?amNjM2p4UUNkSTlNNi82citpV01TbkpNUmtZdlp1UGVnbm1FbFRpYnllR1Ix?=
 =?utf-8?B?Z0NFV3A5Zk5ySkgyR0N3NlJ0dzJvRnZzOUxNa2drVFpGeFNxa1FsM0xtKzAz?=
 =?utf-8?B?a1lQZ20xUUt1NkhSZnljOTNGY25GbXFiaGdOSkp0OWFMWVdVSjAzSG51VHZh?=
 =?utf-8?B?NnNWRWs4dVREZnpkdzhOZE55QXJHazNFTXMyd2tWbldXQms4bDRKRUVIZENx?=
 =?utf-8?B?cHZjb3FIQlB2Vk5PVmhJT0xHaEdzRTJlN2IzQm1MMFNta2Nzai9jaWtMOHBH?=
 =?utf-8?B?K25BM2FvaEhjZ25Db1l6Tk5JSDg2UVNRcXBsT2oyOHFEa0E5NjF1RGxJR2dB?=
 =?utf-8?B?WGlyUDNNclM0TXZFR3d3OFJDdVZQWDRlcXRiRGRwbzJBSGJ1Y2dlbU01bVdR?=
 =?utf-8?B?RFRmQVlyMXdJaGdrcEl1aDM1ZUZLTVBSbGxBN3BtVkxxRUVqRStYNkROVzh1?=
 =?utf-8?B?UGVXMkxLU1pWY1lTU2NVRGRwMUdqRVR3S0NHL05jUDZtbkYzTnhMeEVXRWxS?=
 =?utf-8?B?T1dQQjVhQUNyWlFrVkVlSlJ0OEpwVnNhZDg1NWpDVTJ2Ulc1Z3h1M21Xd0xJ?=
 =?utf-8?B?SGtZb2pxMmE1SEtKcnlOeTIwQmhrZTZIQTdrWDVONVN4MXB3UFIzZjZxMlZM?=
 =?utf-8?B?RUdoUGg5eFN1ZVZUc3hYNFp2SFJOQ0lLay9uWUFiY1ZhN25YcVhrSUIvUGNB?=
 =?utf-8?B?WFRnemtNbWg1bG9va2FRMmJvMFI4QmtvMk1Yb1pkT0NqSlJMMmdPbyt5TXBR?=
 =?utf-8?B?Q0lYZmw4ckpwRGdJY3JkbGpjQU9FNlhucjhkTy91RGxxU20wR1krbGROclkz?=
 =?utf-8?B?ckM2VlRyVTV4QjhIcm9oQ3VWYkhVb0tpRHE2SVVlWWY0QndnWWlaUjlhSjdv?=
 =?utf-8?B?eUowQVI3eGFxL2JrVWxNOUgyWUdZYU50OVk2T09meUJKVExMUndJaXpGRjdt?=
 =?utf-8?B?akYxTDlJa09NcG1TMFhSZVR1dzNEaTdMLzFpR2I5MlZ6eENjK2h6THBCMTBl?=
 =?utf-8?B?NE5FWDFGN1ErUzd1OFZEOFM1ZlpaQW9PemlBUFVTUTFsRHRrN011dDVFY3ph?=
 =?utf-8?B?YmJkVCtld0xEY3BCeDNKRFV6cCthWXBTbDl5SE5zc0c5bVRFWWt0T1JGbUds?=
 =?utf-8?B?L3hIeUJUcVVLRlMzdFpoMHhTWUxNdnM5Y0VnQ0tLSUsyK3NaalAzMGtUM2lm?=
 =?utf-8?B?bzJ5NERCQUtyb1FqNFFMR0JkNy9FWEFzSktSR1pTRW45a3JLc1gybFNaRmRh?=
 =?utf-8?B?Sko5Z0xJdnNma0hFaS83c3Z5cGpMeDhQYktidGVQcm5HSXlvR3FBUUhTWGVB?=
 =?utf-8?B?UnVmNEZUQm9BVVFHTE5ZR2w3YnY3OWdlUjZPM1ZyL1BPYUZ1Q2kyaGxweDhB?=
 =?utf-8?B?em15dXVPMHByYXBJUFFZMmtKblMxTVJjRlVxaXNsN21kY0gzU2J3RjF6OXhj?=
 =?utf-8?B?aUh6YlVId29rWW1QUm90TkY5NjlUVlI0aTdneGFZazd1SjE4aXZLTTltQlhx?=
 =?utf-8?B?ZjlqNXhZaUNrUEVJdS9LbERjd3pocXQxS2NYTVBnQU0zbklXN2JadEs2UmtL?=
 =?utf-8?B?d2VTSGNtajBFdDNrZ0IyWkNJYS9vNVdLQ082ZkNmaERBcnN3OVpxWU1jck9Q?=
 =?utf-8?B?ZmdTa3RtSFdQTGp0c2RmaGZtaE1kVDcxTWZGYkxxSmFhd2dnSmdtUmhmM09F?=
 =?utf-8?B?UHhlRjFhaks4OHQ0aTUvdzRSMEtJTDBoYlRmTXBwZS9ZbTZ6c0Z2UXFTNjNH?=
 =?utf-8?B?UWxJL01pZlFmZG1jQlhMTUNuNFlLcGJYM2tlejVVemxjNWxiYnRIb1dMeU5w?=
 =?utf-8?B?SDM5cEk3dDYraTZZdXFGRXNZMjFVdC9qbmh6N0NlMkdGZm1nY3dhVzlHNDFL?=
 =?utf-8?B?WUk4eUh3T2pPSVpiTExMWE9zb2wrRWVXT20xWmR3eUNlVkRPa0RhOVI2Tzdu?=
 =?utf-8?Q?6zTDGfWKawtFLjKp3y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8887b2-0bec-4f33-56f2-08df35e7df9c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 18:10:11.7501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAgtXczUPzRdQiGuyV7tta0sXZCTp7I+7v4AvwYKsul+cO0zuoXCZVZyU9Ak8EKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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


On 2026-10-26 14:47, Apurv Mishra wrote:
> Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because
> RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing
> workaround (STABLE_STD) needs root and pins clocks.
>
> Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the
> perfmon clock on per XCC, holds GFXOFF off while overridden, and
> restores the previous state on last release, resume and reset.
>
> Use it from KFD_IOC_PROFILER_PMC:
> - lock=1 (device mode, CAP_PERFMON): held until unlock or exit.
> - lock=0, perfcount_enable=1 (dispatch mode): no CAP_PERFMON needed,
>    held until process exit.
>
> No DPM change, no new ioctl, no struct change.
> Bump KFD_IOC_PROFILER_VERSION_NUM to 2.
>
> Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 79 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 11 +++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 28 +++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 28 +++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 28 +++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 30 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  5 ++
>   include/uapi/linux/kfd_ioctl.h             | 10 ++-
>   10 files changed, 198 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5069042b5279..551051c5e6d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2773,6 +2773,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>   
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> +	amdgpu_gfx_perfmon_clk_restore(adev);
>   
>   	r = amdgpu_dpm_reapply_umd_profile(adev);
>   	if (r) {
> @@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->srbm_mutex);
>   	mutex_init(&adev->gfx.pipe_reserve_mutex);
>   	mutex_init(&adev->gfx.gfx_off_mutex);
> +	mutex_init(&adev->gfx.perfmon_clk_mutex);
>   	mutex_init(&adev->gfx.partition_mutex);
>   	mutex_init(&adev->grbm_idx_mutex);
>   	mutex_init(&adev->mn_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 0ae6e990c310..b1b3fbb49a9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1015,6 +1015,85 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable)
>   	amdgpu_gfx_do_off_ctrl(adev, enable, true);
>   }
>   
> +/* Force the perfmon clock on, or restore the saved state; @save records the old one. */
> +static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,
> +					   bool force_on, bool save)
> +{
> +	int i, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +	for (i = 0; i < num_xcc; i++) {
> +		bool on = force_on || test_bit(i, &adev->gfx.perfmon_clk_restore_mask);
> +		bool in_safe_mode = adev->gfx.rlc.in_safe_mode[i];
> +		bool was_on;
> +
> +		if (!in_safe_mode)
> +			amdgpu_gfx_rlc_enter_safe_mode(adev, i);
> +		was_on = adev->gfx.funcs->set_perfmon_clk_override(adev, i, on);
> +		if (!in_safe_mode)
> +			amdgpu_gfx_rlc_exit_safe_mode(adev, i);
> +
> +		if (save)
> +			assign_bit(i, &adev->gfx.perfmon_clk_restore_mask, was_on);
> +	}
> +	amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
> +/*
> + * Refcounted override that keeps the perfmon clock on for profilers. The last
> + * put restores the previous state. GFXOFF is held off meanwhile, as a GFXOFF
> + * exit restores the register. Returns -EOPNOTSUPP if the ASIC can't do it.
> + */
> +int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable)
> +{
> +	int r = 0;
> +
> +	if (amdgpu_sriov_vf(adev) || !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->set_perfmon_clk_override)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
> +	if (enable) {
> +		if (!adev->gfx.perfmon_clk_override_count++) {
> +			amdgpu_gfx_off_ctrl(adev, false);
> +			amdgpu_gfx_perfmon_clk_program(adev, true, true);
> +		}
> +	} else if (WARN_ON_ONCE(!adev->gfx.perfmon_clk_override_count)) {
> +		r = -EINVAL;
> +	} else if (!--adev->gfx.perfmon_clk_override_count) {
> +		amdgpu_gfx_perfmon_clk_program(adev, false, false);
[JZ] amdgpu_gfx_off_ctrl() takes gfx_off_mutex and, on 0 <-> 1 transitions,
pm.mutex. That's fine while the clock gating side is lockless, but once
it takes perfmon_clk_mutex (see defer() below) we get a cycle: clock
gating runs under pm.mutex (amdgpu_dpm_reapply_umd_profile(),
smu_enable_umd_pstate()), giving pm.mutex -> perfmon_clk_mutex ->
gfx_off_mutex -> pm.mutex. Taking one GFXOFF reference per hold outside
perfmon_clk_mutex (before locking in get, after unlocking in put) avoids
that, and also makes the pair in program() unnecessary.

> +		amdgpu_gfx_off_ctrl(adev, true);
> +	}
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
> +
> +	return r;
> +}
> +
> +/*
> + * While overridden, record the requested state for the final restore instead
> + * of programming it. Returns true if the caller must skip the register write.
> + */
> +bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int xcc_id, bool on)
> +{
> +	if (!READ_ONCE(adev->gfx.perfmon_clk_override_count))
> +		return false;
> [JZ] The count is read without perfmon_clk_mutex and the caller then does an
> unlocked read-modify-write, so this races with the override whenever
> clock gating changes at runtime (power_dpm_force_performance_level, UMD
> profile reapply during reset/resume):
> - the CG path sees 0, the override programs ON, then the CG path writes
>    OFF: the override is held but the clock is gated;
> - count++ happens before program(save=true) reads the old state, so a
>    request deferred in that window is overwritten by the stale value
>    (same window on the last release: count-- before the restore write).
>
> Suggest turning this into amdgpu_gfx_perfmon_clk_update(adev, xcc_id,
> on), which does the check and either the write or the deferral under
> perfmon_clk_mutex, and calling it from update_perf_clk().
>
> That still leaves the other read-modify-writes of RLC_CGTT_MGCG_OVERRIDE
> in the same CG sequence (MGCG, repeater/SRAM FGCG) unserialized against
> the override's write. Covering those would mean taking the same lock
> around *_update_gfx_clock_gating().
>
> +	assign_bit(xcc_id, &adev->gfx.perfmon_clk_restore_mask, on);
> +	return true;
> +}
> +
> +/* Re-apply the override after resume/reset reprogrammed clock gating. */
> +void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)
> +{
> +	if (!adev->gfx.funcs || !adev->gfx.funcs->set_perfmon_clk_override)
> +		return;
> +
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
> +	if (adev->gfx.perfmon_clk_override_count)
> +		amdgpu_gfx_perfmon_clk_program(adev, true, false);
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
> +}
> +
>   int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)
>   {
>   	int r = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 5939e1fb3b24..1690eb3e37bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {
>   				 u32 queue, u32 vmid, u32 xcc_id);
>   	void (*init_spm_golden)(struct amdgpu_device *adev);
>   	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
> +	/* set the perfmon clock, returns its previous state */
> +	bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xcc_id,
> +					 bool on);
>   	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
>   				   struct amdgpu_gfx_shadow_info *shadow_info,
>   				   bool skip_check);
> @@ -503,6 +506,11 @@ struct amdgpu_gfx {
>   	uint32_t                        gfx_off_residency;  /* last logged residency */
>   	uint64_t                        gfx_off_entrycount; /* count of times GPU has get into GFXOFF state */
>   
> +	/* perfmon clock override for profilers */
> +	struct mutex			perfmon_clk_mutex;
> +	uint32_t			perfmon_clk_override_count;
> +	unsigned long			perfmon_clk_restore_mask; /* per XCC */
> +
>   	/* pipe reservation */
>   	struct mutex			pipe_reserve_mutex;
>   	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> @@ -635,6 +643,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
>   					u8 me_id, u8 pipe_id, u8 queue_id);
>   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>   void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
> +int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable);
> +bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int xcc_id, bool on);
> +void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);
>   int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
>   int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
>   void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_if *ras_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 315dfd806d56..0a80dacd0932 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>   static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
>   static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
>   				      bool enable);
> +static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on);
>   
>   static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
>   {
> @@ -1147,6 +1149,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
>   	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
> +	.set_perfmon_clk_override = &gfx_v11_0_set_perfmon_clk_override,
>   	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
>   	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
>   	.detect_hung_queue = &gfx_v11_0_detect_hung_queue,
> @@ -5499,23 +5502,32 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
>   	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
>   }
>   
> -static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> -				      bool enable)
> +static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on)
>   {
>   	uint32_t def, data;
>   
> -	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -		return;
> -
>   	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
>   
> -	if (enable)
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> -	else
> +	if (on)
>   		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> +	else
> +		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
>   
>   	if (def != data)
>   		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> +				      bool enable)
> +{
> +	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
> +	    amdgpu_gfx_perfmon_clk_defer(adev, 0, !enable))
> +		return;
> +
> +	gfx_v11_0_set_perfmon_clk_override(adev, 0, !enable);
>   }
>   
>   static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index d334fb805020..8774dfd64022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>   static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
>   static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
>   				      bool enable);
> +static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on);
>   
>   static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>   					uint64_t queue_mask)
> @@ -957,6 +959,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
>   	.detect_hung_queue = &gfx_v12_0_detect_hung_queue,
>   	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
> +	.set_perfmon_clk_override = &gfx_v12_0_set_perfmon_clk_override,
>   	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
>   	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
>   };
> @@ -3938,23 +3941,32 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev,
>   	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
>   }
>   
> -static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> -				      bool enable)
> +static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on)
>   {
>   	uint32_t def, data;
>   
> -	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -		return;
> -
>   	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
>   
> -	if (enable)
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> -	else
> +	if (on)
>   		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> +	else
> +		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
>   
>   	if (def != data)
>   		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> +				      bool enable)
> +{
> +	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
> +	    amdgpu_gfx_perfmon_clk_defer(adev, 0, !enable))
> +		return;
> +
> +	gfx_v12_0_set_perfmon_clk_override(adev, 0, !enable);
>   }
>   
>   static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 1589fc6413af..0b9e41c26182 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -211,6 +211,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
>   				      bool enable);
>   static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
>   					 bool enable, int xcc_id);
> +static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on);
>   static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
>   static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>   	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
> @@ -746,6 +748,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
>   	.read_wave_vgprs = &gfx_v12_1_read_wave_vgprs,
>   	.select_me_pipe_q = &gfx_v12_1_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v12_1_update_perf_clk,
> +	.set_perfmon_clk_override = &gfx_v12_1_set_perfmon_clk_override,
>   	.get_xccs_per_xcp = &gfx_v12_1_get_xccs_per_xcp,
>   	.ih_node_to_logical_xcc = &gfx_v12_1_ih_to_xcc_inst,
>   };
> @@ -3155,23 +3158,32 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct amdgpu_device *adev,
>   		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
>   }
>   
> -static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
> -					  bool enable, int xcc_id)
> +static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on)
>   {
>   	uint32_t def, data;
>   
> -	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -		return;
> -
>   	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
>   
> -	if (enable)
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> -	else
> +	if (on)
>   		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> +	else
> +		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
>   
>   	if (def != data)
>   		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
> +					  bool enable, int xcc_id)
> +{
> +	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
> +	    amdgpu_gfx_perfmon_clk_defer(adev, xcc_id, !enable))
> +		return;
> +
> +	gfx_v12_1_set_perfmon_clk_override(adev, xcc_id, !enable);
>   }
>   
>   static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6c710e4a5220..8e3104ce181a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3410,6 +3410,7 @@ static inline int profile_lock_device(struct kfd_process *p,
>   	if (op == 1) {
>   		if (!kfd->profiler_process) {
>   			kfd->profiler_process = p;
> +			amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
[JZ]This now touches the hardware (SMU GFXOFF message, RLC registers), but
the pdd is looked up without kfd_bind_process_to_device(). pdds exist
for every GPU from kfd_init_apertures(), and the runtime PM reference is
only taken on bind, so on a runtime-suspended dGPU this programs a
suspended device (same for the put in kfd_process_destroy_pdds() when
the pdd was never bound). Suggest binding under p->mutex before taking
the override, here for op == 1 and in kfd_profiler_perfmon_clk(). That
makes lock=1 return -ENODEV on a GPU whose VM was never acquired, which
seems reasonable.

>   			status = 0;
>   			mutex_unlock(&kfd->profiler_lock);
>   			if (ptl->hw_supported_state == AMDGPU_PTL_HW_SUPPORTED) {
> @@ -3427,6 +3428,7 @@ static inline int profile_lock_device(struct kfd_process *p,
>   		}
>   	} else if (op == 0 && kfd->profiler_process == p) {
>   		kfd->profiler_process = NULL;
> +		amdgpu_gfx_perfmon_clk_override(kfd->adev, false);
>   		status = 0;
>   		mutex_unlock(&kfd->profiler_lock);
>   
> @@ -3444,6 +3446,30 @@ static inline int profile_lock_device(struct kfd_process *p,
>   	return status;
>   }
>   
> +static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id)
> +{
> +	struct kfd_process_device *pdd;
> +	struct kfd_dev *kfd;
> +	int r = 0;
> +
> +	mutex_lock(&p->mutex);
> +	pdd = kfd_process_device_data_by_id(p, gpu_id);
[JZ]Same binding comment as above.

> +	mutex_unlock(&p->mutex);
> +
> +	if (!pdd || !pdd->dev || !pdd->dev->kfd)
> +		return -EINVAL;
> +
> +	kfd = pdd->dev->kfd;
> +	mutex_lock(&kfd->profiler_lock);
> +	if (!pdd->perfmon_clk_req) {
> +		r = amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
> +		pdd->perfmon_clk_req = !r;
> +	}
[JZ]With a release path this could take an enable flag: if the pdd is
already in the requested state, return 0 for enable (idempotent) or
-ENOENT for disable; otherwise get or put.

This can also run while a GPU reset is in progress (KFD ioctls aren't
blocked during reset). If you guard it with reset_domain->sem, take it
before kfd->profiler_lock: post_reset -> kfd_resume() -> init_mqd()
takes profiler_lock with the reset lock held.

> +	mutex_unlock(&kfd->profiler_lock);
> +
> +	return r;
> +}
> +
>   static inline int kfd_profiler_pmc(struct kfd_process *p,
>   				   struct kfd_ioctl_pmc_settings *args)
>   {
> @@ -3451,6 +3477,10 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
>   	struct device_queue_manager *dqm;
>   	int status;
>   
> +	/* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON needed */
> +	if (!args->lock && args->perfcount_enable)
> +		return kfd_profiler_perfmon_clk(p, args->gpu_id);
> [JZ]
> - For the current lock holder, lock=0/perfcount_enable=1 used to unlock
>    the device and enable perfcount; now it keeps the lock. Probably
>    unused, but worth stating.
> - In this mode perfcount_enable=1 no longer enables perfcount on the
>    queues (no set_perfcount(), compute_perfcount_enable stays 0 in the
>    MQD). I assume aqlprofile sets COMPUTE_PERFCOUNT_ENABLE itself?
>
> To add the release suggested above, please update this to:
>
>          if (!args->lock) {
>                  /* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON needed */
>                  if (args->perfcount_enable)
>                          return kfd_profiler_perfmon_clk(p, args->gpu_id, true);
>                  /* Drop a dispatch-mode hold first; without one, unlock as before */
>                  if (!kfd_profiler_perfmon_clk(p, args->gpu_id, false))
>                          return 0;
>          }
>
> with kfd_profiler_perfmon_clk() taking the enable flag described above
> and returning -ENOENT when there is no hold to drop, so the existing
> unlock path still runs (and still needs CAP_PERFMON).
>
>   	/* Check if we have the correct permissions. */
>   	if (!perfmon_capable())
>   		return -EPERM;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f0ce5fc4a138..f753ecae842f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -895,6 +895,8 @@ struct kfd_process_device {
>   	u32 pasid;
>   	/* Indicates this process has requested PTL stay disabled */
>   	bool ptl_disable_req;
> +	/* Holds a perfmon clock override until the process exits */
> +	bool perfmon_clk_req;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ac18c2be6ecb..7a8da8d36962 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1180,6 +1180,11 @@ static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_proce
>   	if (pdd->dev->kfd->profiler_process == p) {
>   		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
>   		pdd->dev->kfd->profiler_process = NULL;
> +		amdgpu_gfx_perfmon_clk_override(pdd->dev->kfd->adev, false);
> +	}
> +	if (pdd->perfmon_clk_req) {
> +		amdgpu_gfx_perfmon_clk_override(pdd->dev->kfd->adev, false);
> +		pdd->perfmon_clk_req = false;
>   	}
>   	mutex_unlock(&pdd->dev->kfd->profiler_lock);
>   }
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 564faefe6978..d7fb52c30df0 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1558,7 +1558,15 @@ struct kfd_ioctl_dbg_trap_args {
>   	};
>   };
>   
> -#define KFD_IOC_PROFILER_VERSION_NUM 1
> +/*
> + * KFD_IOC_PROFILER_VERSION_NUM history:
> + * - 1 - initial version
> + * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until the
> + *       lock is released or the process exits. lock == 0 with
> + *       perfcount_enable == 1 forces it on without CAP_PERFMON and without
> + *       locking, until the process exits
> + */
> +#define KFD_IOC_PROFILER_VERSION_NUM 2
>   enum kfd_profiler_ops {
>   	KFD_IOC_PROFILER_PMC = 0,
>   	KFD_IOC_PROFILER_VERSION = 2,
>
