Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79A5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 20:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C666E509;
	Thu, 25 Nov 2021 20:42:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295466E509
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 20:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp7TzPDxtJMRazYCbCuPzzdIJACXlLivjEa2+GBQt5QudU49uFFDOHRsZvaQm5p1Mj1dQVqxBLDqHLW51gZFGJOAe9FBlkL/bxhpxGbk5ztRSYsxxpqFIe6FJO0yuh8DUNIMT5zMZJrgU3bjOWgdlqnhF+rVSLEOcK9ExDXDPCkOkwz4S2hGREnvqWCQICuFzBjGUrz3GM0onHIBAk1X0shwDCexpuH/ejgWh7b8LpG/tplTGR37c2x0/sSxmlzZCdVNylWj9GmU5KIny1HCdiO6uZew0c5MnORY5f1rGXqzcfjYV6jmDvEVkFpGJPe3MP0t7hrBqa7FOk0FUHJEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ8p7qvJ9qQB47e2RLLij8AUabMQERsG7e+Za5NUy3E=;
 b=leQt8IUJY5xY6HPZGLf7c3op2yYtzodV6mLzxviulEq4TUAnqojfAfnqFppXzd9RoBw3tStBYXNxESD3nBDtIJsNnUMicWvZRQD1uZ+sIVqdpmmptyTPTMlCnw5c3aFDLl0QOdDypRSb2VdyZ0v+Z7kIODxq7M4pppuqeGFDxv/qaaNnqbJiRjcIa5d92oNRYNrwmZBSUS0k0DH90+78LKvKzA/Yjs/gi+ZGkfuv/ahyqycQY+8nI8PyD4WUi+7el/eKSqnjd9EJQ+MVHPMyAevw8LxTXGtVgmZB2IrQz2c6DCVxze8oNyyT3GMMnvQaSgBk2cEmzgZ+TpHnzA3Quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ8p7qvJ9qQB47e2RLLij8AUabMQERsG7e+Za5NUy3E=;
 b=NWY27Re0XYRGs7P3GOCeN7bhTeKjLWoV2doAXv877XXqeZPjV54pj5FTVrYCbAfJzZUXxgETAeIMxfxIdBJrkfFuqk9s3+GD1KalX6oYGXlcTr4jy/5Z5tlzFODYxM0OYoqr0XCq/wwJjf5ICaQ0X5Kq/wgNjHCj55jEE1pXpHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 20:42:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Thu, 25 Nov 2021
 20:42:00 +0000
Subject: Re: [PATCH v8] drm/amdgpu: handle IH ring1 overflow
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211125203003.18038-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d5862808-c97e-a1c2-4429-7d0216425fdf@amd.com>
Date: Thu, 25 Nov 2021 15:41:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211125203003.18038-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::49) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 20:41:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8b5c18c-158e-472d-69b6-08d9b0540752
X-MS-TrafficTypeDiagnostic: BN9PR12MB5132:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51321DA27C1632D88D7D65CC92629@BN9PR12MB5132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dApsbylODC6oF1JOyq66ctFGhm+eXpjraqMxdWZSues1uQdp+qGL0mNkm6iQ1RSrfteKyg5OymvW5vevA34XRKx4IWaQ1U65JcaaxpxRKALUdaCIcUnTzK4Dswm0CajQrG9bZZG1WV32Zn4lVkG3YG7ukahJM+WKXZvreoFpxEddKKxu7GOMqHgkPhlbAvXNWBQrWhNCdS6GLb5YsDa2uBMkyZArsCDP0hCdz7GtOYgqKnUhpWpJrr7bP7lFZQP+34yrZOMYnAmR4mChWVx+zs81+odPP7tNleFRwGh/iWwWCL+OBV9J9Zrc8OtY66vsebTljvPnBrqzzzmUOLrgy5AMGpBhamaYXYW6jKeJ/7do8Zx2ryzTCG8U48YAPppPN6DU2zhCOBPB/rEel9nFlb9AzAPP7ezB8k7cU5PN1Rkk0K3HvFDRVqrsoFjlbgm9HKCEYY3/GUidJGPEjdw2o55EzAG6EnoYXfPNSJbSzbI98U0kMH9hCjFPRqBvShPWkRzCBNpzkOUnUxapnbEq0jkrXzEMcKP1twp8+C7fCM/82NmA3JZMjYQOJiED7bG6tpjaAwPMq5oywycBcYQQXcxVW9aapPf6XciZRV19HvlWoKQWEP1ktQ4NwMdkf/XWajE+qXlIJ6LDfRCgQsIYrn9l+a8cNvnRgEqdLLGUkB1Y/ZBnpR92ESGMZHnpYmlGRdY47ZdE7MQ1jHhM4awEowkQyhKJXTuF6Bh/xGCvsXz5X+UZ5xcoE7AMA83I+gRR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(30864003)(66946007)(316002)(36756003)(4001150100001)(66476007)(66556008)(83380400001)(2616005)(4326008)(956004)(31696002)(16576012)(38100700002)(8676002)(508600001)(44832011)(5660300002)(8936002)(31686004)(26005)(186003)(86362001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxwWWtLczc5bTR3MkxyNzZSc1N4UjZGYnRFSDAyRGlZR1Q0dzRsR1hFVjRU?=
 =?utf-8?B?OEx1aTVKYis2cm9qWGtKM3N1YTlNZ0lCY2hjWDRscXhNMEdFbTE5Wlc1T21F?=
 =?utf-8?B?TDRCZnNrcGVrM0tpR2JhVlRNT1R0M1llUFJuSU13UmhvTUc1a0tXcUJZeVpo?=
 =?utf-8?B?Z1hxQWFQaGxFV2lYSXNHTHkvRFZmSVdpRlNvUyszOG5JenN6QXNJSXlya1R4?=
 =?utf-8?B?R09QNUdWU2hkelJCN0xseWJGZXlSeXN2cW9iZ05YVUFwK2p4SXE5UXRLMitT?=
 =?utf-8?B?NWNpK2NEMk1zZDhiNWQzTVlzNnpvTGVIQlVhWFcrS0l3dkx1NjZwV1ZubHNY?=
 =?utf-8?B?eGR6b2h2cVpzc0NIejErSDZWWkhERnRPaVVJYWxQNlBMczJRbkxiNmo0L2RF?=
 =?utf-8?B?cjdpaEs2S1hDaEYxa1ZoakFJSCtaMnpoQ2tCajR5Y3BHS25BMHIrVXR5MDhN?=
 =?utf-8?B?RTd6QS9PYkdaazA2bjNQWnRVQlJJSkRpTjFXYWsrWmlmdHpKUnZIYjArVllt?=
 =?utf-8?B?UXpGVHZ3eTBZWlF4cTdJNkY4TG01cHUwQlNDSjFkQ3RmczBzM0h4MVFqZGwr?=
 =?utf-8?B?V29UU2RST1J2eGQ5SjRlRmpldlMvSjBFOUV3c0NVRzJVMDVFS0VaYzhkRyth?=
 =?utf-8?B?L0d3M3lKTHNtUWpGUzkvUXo5VEpqbzVVeHc3ZlpWeUQ4NGpyUERaNCs3c2lM?=
 =?utf-8?B?dUZTbXBuVG5Ea0NoWk05QVY2SGpCb3RRQXM5UlpKc2RYcVVKMW1rcnE4WUJB?=
 =?utf-8?B?b1NjbzBNQWpqaW92V1U2ZmpwVitRUkI3cmdjNFBzcXdXbjhTeWhhMkIzbkxh?=
 =?utf-8?B?OXNaYVZBV0x4UEc5alpCZDF4aG50T0gvNUVzTDJCaTEvTXZGcmtQbEFoVTZW?=
 =?utf-8?B?dFZyT01Ga0VYK01xaG9JSmMwcDg0NTFTNEZhaytNQ0NNcW9xa2VYQTh4aGZz?=
 =?utf-8?B?TDdKVWdOTS9VQTVLQkRIN1BYZ3FybUVBVDlHUkkwREp6L3lOM2tTVEtvTHAw?=
 =?utf-8?B?bmpnamFKTDJ5aWx5RGpjZmt2UFpFV2U3UGZUcGNuVzh6bUFlREhMYmFvNDFR?=
 =?utf-8?B?M3ZvS1hFQ0xIcFovLzVPcGduV0c1VUxJUE5QdEgzSWZWejJ0OXZFNG5GUGZW?=
 =?utf-8?B?RkNzRXdJSXd3S2Y2Q0Z5ajFOUSt4QXo4dUltbGlXVHZ5ZE9Xc0hkNXVVTlpP?=
 =?utf-8?B?Umh5ZjdNSStISHVmb0VKWmtaOTBmNjY1UThCbnVvQlBqdEJmQ2tBSzcyeDA2?=
 =?utf-8?B?VlkzeDRnOFYzMmFyZVVaMk04OEVJNzdDMzZJbTRTNC96MVRKa2dwZENKZTVO?=
 =?utf-8?B?OUQvbzZhMzEyVGxCeFdjdTl5dDBEVm51WGdqalBFZ2J1dURCa0Y1Yy9ETXRE?=
 =?utf-8?B?U2NqRjJTQk9hV2JvTWYvMnNhUVcwenVQR2lOaEFXbmVhNG9HMVN0ckk1SDk3?=
 =?utf-8?B?N2dYQ05MTE9nUmNuUzhLUTFFdHhiT250RDZYMFdBdkFMT1BGbk1PalIzcllW?=
 =?utf-8?B?emptejhBckFhcWtJbGdtUERuR1htREZJOG5HeGJFVEpsQ3czaWZ4WXBhc29a?=
 =?utf-8?B?UWZidWdzdnIwalNFazZid1RCcUI0Kzh0aE92YmJ6MGNxMEZVdE5WZEVhd2Vz?=
 =?utf-8?B?ZUtldGlIMVRRQ2txcnpLREhITEljNnJzc1FEQ1p0QTBFMzAyQVA1Z0tIdVFV?=
 =?utf-8?B?YUVkL1FETDQ0SStrSWRHbEx1Wmxyd0lLTmR3M09DRW1vWmpuZjRVUjN1b3Fr?=
 =?utf-8?B?S1ZaNHBXbHVrMzk3NEJYY21aQ0dUQlNEVy9uZHZjcmpKcDRkS3RjT0NSR0Mr?=
 =?utf-8?B?dmR6RFpBOG1la0lLYjNYbVluS3ZQNHVpWkh4Rm00UUdFQVlTT2p0U3RPNkY5?=
 =?utf-8?B?akFVdklYaHcxeWlxZUNFYWVJcEVRYmRHUHFwK1dXcjlTV1o2Wit3SlVYb0JL?=
 =?utf-8?B?b0lOOHYwVmF2bGZPcHgyRWV6TUpvOGNsaFhMbkp5NTRYTm1vbCtYM3hSWFNy?=
 =?utf-8?B?cFNYSStaamVKYzM2blNBRjVIbUp2aGw0ek5RS1NvZFEveWZWY1haNjc3QXJj?=
 =?utf-8?B?WFFnb0pDbTU5dWtTVWVuVXBFQ0NXbk1HYWJqZld6MmZlV3dBTHhab1hSZXJy?=
 =?utf-8?B?dUI2QWZoemp5OEV3eis2ZHRobVM3OWczbDRYRVZKRm9DODFhTlZiaXFYSDla?=
 =?utf-8?Q?lfAzL03x0xOXF70BUBTvqY8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b5c18c-158e-472d-69b6-08d9b0540752
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 20:41:59.8996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QE6vJ4odEJvk6Ze0WJ+SsVtjfBbF2NLkvMP1a8JukR2/H9unq78yMbPt/PhVSTejmeXdnDfsd/JGFDwr/zOgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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

Am 2021-11-25 um 3:30 p.m. schrieb Philip Yang:
> IH ring1 is used to process GPU retry fault, overflow is enabled to
> drain retry fault because we want receive other interrupts while
> handling retry fault to recover range. There is no overflow flag set
> when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
> and drain retry fault.
>
> If fault timestamp goes backward, the fault is filtered and should not
> be processed. Drain fault is finished if processed_timestamp is equal to
> or larger than checkpoint timestamp.
>
> Add amdgpu_ih_function interface decode_iv_ts for different chips to get
> timestamp from IV entry with different iv size and timestamp offset.
> amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  8 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 55 +++++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 16 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
>  11 files changed, 57 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 45761d0328c7..403a968f3d2f 100644
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
> +	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
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
> index 0c7963dfacad..8050f7ba93ad 100644
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
> +		    !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts),
> +		    timeout);
>  }
>  
>  /**
> @@ -299,3 +279,18 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>  	/* wptr/rptr are in bytes! */
>  	ih->rptr += 32;
>  }
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
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 0649b59830a5..dd1c2eded6b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -68,20 +68,30 @@ struct amdgpu_ih_ring {
>  
>  	/* For waiting on IH processing at checkpoint. */
>  	wait_queue_head_t wait_process;
> +	uint64_t		processed_timestamp;
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index e9023687dc9a..571b11117992 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -521,6 +521,9 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>  	/* Send it to amdkfd as well if it isn't already handled */
>  	if (!handled)
>  		amdgpu_amdkfd_interrupt(adev, entry.iv_entry);
> +
> +	if (amdgpu_ih_ts_after(ih->processed_timestamp, entry.timestamp))
> +		ih->processed_timestamp = entry.timestamp;

OK. Dealing with processed timestamp rather than decoded timestamp fixes
the race condition where drain would have returned before the last fault
was processed. But we're still assuming that each interrupt has a unique
timestamp. We haven't seen evidence of the contrary. But I'd like to add
a check to be sure, in case that assumption becomes invalid on future
hardware. Something like this (before updating ih->processed_timestamp):

    WARN_ONCE(ih->processed_timestamp == entry.timestamp, "IH timestamps
are not unique");

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>  }
>  
>  /**
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
