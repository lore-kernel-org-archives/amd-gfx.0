Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196A606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iYWF+LZi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1F610E489;
	Tue, 27 Oct 2026 20:21:10 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8DB10E489
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oym07W29iv/l5Nyma3ETNCnyd/385uwTwr/Co/U2SBgyyrfVXb4y6trujZfyFLGnIXDQRaaobuZRjprvcWo1gpIN+uxuQeUtb4zEwGvpWGA9zO+Rxjd0Aj8pDm4geUKucCRMVmAbDcfhWnFqUgIAwamtxXrlO/uQmhIwWTYrV23uKjZ5BawiyM8Na7xGnM9S6WWEOV3yaZk+vfmhKCE+aDFC/+1BnmlclRwwUSAmQymQT0NauUA1bWBynBlVb1LKHFgrdoLwm6scLBhBa23JvhDkQpnJj+wiF/Ia7mBNqWQRZ3mcP0Q4rpJHBBibH6KpP/0oaPwskct/gcWd4cPBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxb7Lfkh9AUtbsbSdVa3UFcGoZX76cfaQwG1uaF7njo=;
 b=HkBA+M1fxbfkPZsICyn6vFaX/9wXW5ldAl3epXfx5K2G/TuRG4JbvIoCM48bAmqde3oSm1jnZdZ+SGikFb1/Js+2v/Ce8+IcaP/equd5toK72Z4R6wgnTjqsz2MeHZo1xHZr3sg8aj6UQhZEZYpnlwe7KT1JFUhzXsjmMyiGa+Vodr9kHUL11eAUYOE122T0MGOBYxmQ7CtFuS+TENE9SpkUndY9Aa60PrYX05zIrHvXoKVM4YjGm5yQpRlZFSatIxmPDGXK0i8VtjS61Is0vnoCY13J+JmysQ31VfYZ2pYMlCCMmNqGArrDRv8WjR0GVeb0y7mFntQ5ggF67YJIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxb7Lfkh9AUtbsbSdVa3UFcGoZX76cfaQwG1uaF7njo=;
 b=iYWF+LZiyovTrCYcBD2xbi+XwmC29/9pSVSbnXZAfiUg773M3jWE2MIlV5GZsTP1YuJB4/lu6NG2oaNY3O7tHqaK4wFybnyiyDJgmKnlf3BsAzvZr+QYjzx19PG7HY56m1Nl2Ntprmp8kozLigHd/EjTLvFVUWuXKd8sLw4TUmE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by BL3PR12MB6644.namprd12.prod.outlook.com
 (2603:10b6:208:3b1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:21:01 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:21:00 +0000
Message-ID: <fb48c3d4-2019-45bc-90b5-44d1e0c5b893@amd.com>
Date: Tue, 27 Oct 2026 16:20:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 5/8] drm/amdgpu: Set up UALink rings and metadata for
 loopback
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-6-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027195913.1794477-6-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::29) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1da305-71d2-43e7-d417-08df3467d0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|261026121527099003|18002099003|261021123027099003|56012099006|11063799006|4143699003|261022075727099003|10067099003|261009223027099003|261021121427099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: dkPAepPHaCoYu61LLV6ZQPwKKunXGY7HK0UJFdUIjBsTmHUF+VR8ERmICgkj5s007AdsmRvbksgExtcGsYtDJV1rt8XH6AgACDzPmroWY9jlWB4D0i4CyeVR67dfnZDHIBN/fC2+EaFj1lH2K5k7PRiWHxmSbnBXgzQhbqjwY0je75TekTrYOi8D6DvnoV0L7oe8DH8/lUY/N+757U8xwvlDMlNDSzJwaUfFlEwzXznpM8ji+xUwM1AY+9+whjP8dBwGAnDjG9vEqNjHZizfrw9ltI5tYc3QB+5R0nk+Yj4h7OFVKGD5bG8f38KVJgXL0VWcbAwqx8d/rkcb/abQIAgBU681UNz9MzkaiJTSk0tXsY3RtjjbmmKkAGeP5GbRihsA2kHwcqxztse9DTVe+CpSBv0gnOSbucMxs9zyjilBYt3ID4NihlKd59d+KxmPWoihRXxAzxdrRMVhdpXtCAj0gxQxF7WptyxxC7+Va85OwFcqr3AEb9G6XdJTUDEOtmq6N9duP2cg4bWlFAq6vTfYZBv4Ce7ThhEphB0amv6weaxJOSVvHcVUfRUH93otOQisYqQe2xYLHNBuZaFwZOjmF7WEjcgWKMeinYv93W+6sNUzYYHWG/zBhEJYi3EKCWhJ9PAw4gFgQ9W4QnMVayJPXWU3ryc8qlohYmPhtds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(261026121527099003)(18002099003)(261021123027099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(10067099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVLM1o2ZWhzSVlQSHRGeCtZNlhISGRRYzVVY2VQRTJjRUV4dVFaMEUxUkti?=
 =?utf-8?B?b2NadkFPaW91c1ZFVU9LYndINm5qQTZwK0FKQkxnYVVNZXdhOGQwdC8rUmN2?=
 =?utf-8?B?clpWYTBTSytsSnFvb1Bza0ZkKytaaUEvOUVGZ1hEaEREVkNYNUh0Z2ovcVNU?=
 =?utf-8?B?YTk5c1VQSUhoajVwNFp6czI0MHVqbHZTVm9HZlNzUXpzc0gzNmxibHZFTG9Y?=
 =?utf-8?B?czBsU3BHZGV0cmhFcGtlbTVKR3RLa1VZT1JiaFpzLzF1cHR2TkdhVHZqVVBj?=
 =?utf-8?B?c0MrREFLNjc2cGhCVHA0MnhOandWZDAwdnNtNzBSeW1vY2hsVEFvUnJONjlX?=
 =?utf-8?B?S1VFbU1UdHE4R0pBdWNHOXR4YlVGclRIeERkdWtpTDgxek1nU1loYlhTQmh4?=
 =?utf-8?B?MiswcjU4WUd6N0sxZWtrT2FKTlpreXRTemx3bWhGcU8zMXdYOUd6WFE4azVS?=
 =?utf-8?B?cUlRaHpEdUxMdHR2elVibEh6NndQUGJiMThvaFhleVJUcGNCKzNMYkNjSjA1?=
 =?utf-8?B?NVB0Vm5oeUNzWUZjRVkzRmM1b0orUk1zZTNRMEl0UklRSC9EVUNiKytSMTl2?=
 =?utf-8?B?WDFGQ3AxZ3I3cldtMkh5cXQ2cmF1bzlJTFA5bHpLeVVjczVHVllTYldKMmVU?=
 =?utf-8?B?dVliMDNxVFRtOVVTTjExclJhemJrdWRTWUFMU3UvVWwvZUdrOUFNRXNEY1d6?=
 =?utf-8?B?MzVIb2pxZjRWdnJuQU9iV1ZldWN6Z3pvbndnckgxK3REUDFFbXZsN1o0cVdp?=
 =?utf-8?B?SU1MbTA1dlpKSUpmUC9leThKVjFNRW1Db3Q0SC9ucUYzT2dGbVI5SnVmcnR4?=
 =?utf-8?B?OXJ3ZFkvMHFINHJYV3lqSTRwaE9IeTdEVkpUTVVIdFljR3dRL3NEcSswTktM?=
 =?utf-8?B?ajAwYXl4MU1aTVZVcUZDMUY3NHFlU0taSXZsU1IydHQ5MHJBWTRBL1F1aUpi?=
 =?utf-8?B?cVV0Q0dpYXpweGt2OUdWV3NQUlVhNUN6eHd3YSt6SnBLN25CMzFtekdRU2FJ?=
 =?utf-8?B?RmdTTGszaDJjczliUlhBY1J6bytzUWY3R2ZMa25nNmlZR3FJSEUrTkZOWlZX?=
 =?utf-8?B?WXZOdFRSeFB1RWRlalJ0ZzFqcGdxOXlwQVRiRlpuRktWT0JVTGVST0dwSFo1?=
 =?utf-8?B?N0l6LzhmV0Q4WjJZcncxcU9PUFBNK1p0MGx6UnhhNGpZTVFmbE56bzBucUNa?=
 =?utf-8?B?OExYRlQrSzF0ek8vL3Nsa2JVVW5SSC95Lzk1SlpEc2I3TkQxY205SWxza1FQ?=
 =?utf-8?B?bFJRbDBTdE1mUnYyYU1mN2F6NzFseXUyUEZaTkJYSDAwa1Y2YktmZHVCdi9h?=
 =?utf-8?B?eXZrdFpQUjJqbFdsdVpPa1JsaVBBR0hLSFVQWGRXZ0F3TEV1WENJK05DRWFD?=
 =?utf-8?B?ektkcEdSNkxBNG4wQ2pGQktMOWZKZnRsQXNIcVVHTTIxY09uVWNWRzhIM3Zw?=
 =?utf-8?B?YzdJQTVSSCs3bEEwN3RVTThrSHNKNmltY0xUWXNQclRzVlZkUk14ckpUa3RS?=
 =?utf-8?B?a1N6U3E4R09YUUZWR3FCSExsTFE1bW9LRW4wL28vYU4vOU16bEw4bnp1cVNL?=
 =?utf-8?B?NDE1QllPNTRFa3ppajQ4eVhYS1cvU3FZSjBwVm9NWE5RWTd3SWRiSFZjcE5R?=
 =?utf-8?B?ekdrLzFJckR2WHI1WVRQdmd0TWowejBjMEFmYzUra0h1ZWY5UC9tRDlPbGJN?=
 =?utf-8?B?QWtZUE93ZTdwOGZZeWNBT3RkQ0hrWGVLQThvZUJpOTVKOXVYUkZWazFOeHc1?=
 =?utf-8?B?cGxHaWlOVkQvVVhpckhhTzJvQ2lYR1lrNDlyQXREYWdCT3gxT1A4RUtxU2x3?=
 =?utf-8?B?REl5UEp0OTA1aDJYNllONTFFNEVOYU1oYnBVOThTdC9zRFREN0RydWNTUm43?=
 =?utf-8?B?dUpRMFFMeFZoRzc1TmZGWk5PemU3RWFxdEpRMlJvVUpWN0phSzlFMEhwRkFQ?=
 =?utf-8?B?M3NLcndQYXN4aElYSm5WMEZRaHNLakk0bURXSFFtTTl5M0RObVRoaUMrQ2Nz?=
 =?utf-8?B?c2JMZDRXK3V6U3c3a0tTVXFYT00yclNnUmZlckJLTGhxZGJHSlJMeithWWg2?=
 =?utf-8?B?WE5samplaTFlVW92bmVXS2cvYWtGOTB3N1VrS0hkRUU4d1B2N1ltb0l5eDg1?=
 =?utf-8?B?aG1jMXdibHQ4RVN3WmRKWWI2ZTZHckpZMk5hWm9RZUcrMnBTQnpFUUw1bFh6?=
 =?utf-8?B?TEpxcCt4SGxmN3dLa0xMbG01cFE4NGNUVEhBQ0hJRkFyNXhZblpseVE2R01P?=
 =?utf-8?B?SlAzUlRxY3IyKzAwUGlBOE9GRWp2RmZXTGFSRzdYWi9GVW5RZVZ0SEdUc0pG?=
 =?utf-8?B?Q05DWTM1QytXdjUxeXQrNTQxU0R0RXFlTHA1TFJCNU1FeklRVmZoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1da305-71d2-43e7-d417-08df3467d0ed
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:21:00.3027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z85VN/rIoDolGHk6r2QCS9h56MVZ6EgEV5OW5XddLZvtJxf4/ChsAyo7m4pssujs1usWxsqxqimuWidvKuKH9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 15:54, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer, and the only path the HW serves is importer -> exporter.
> Adjust the per-peer setup accordingly:
>
> - The importer's doorbell reaches the MP nHT stamped with the GPU ID of
>    the exporter, and the FW looks up the metadata entry by that ID. So
>    publish the importer's rings and tail pointers in metadata[exporter].
>
> - The local sender of the HW-served direction is the importer, so set
>    up (and tear down) the send rings with the importer as the source.
>
> - Skip the ring pointer resync. Both ends of every ring are on this
>    GPU, so there is no remote peer that can reboot and leave the
>    pointers stale.
>
> - Do not take the local dma-buf shortcut on import. It would bypass
>    the NPA path that loopback is meant to exercise.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 66 +++++++++++++++++-----
>   1 file changed, 51 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 96a6023f51c5..e6272446ff4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3965,7 +3965,13 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
>   		return -EINVAL;
>   	}
>   
> -	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
> +	/* In loopback mode the exporter and importer are the same GPU, but the
> +	 * import must still go through the full cross-domain NPA path (the
> +	 * dma_buf shortcut in amdgpu_ualink_local_import() bypasses NPA). Only
> +	 * take the local shortcut for genuine same-pod local accelerators.
> +	 */
> +	if (!adev->ualink.loopback.enabled &&
> +	    amdgpu_ualink_is_local_accel(adev, remote_acc_id))
>   		return amdgpu_ualink_local_import(adev, remote_acc_id,
>   						  &handle, fd_out);
>   
> @@ -5441,11 +5447,28 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
>   
>   	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
> +		struct amdgpu_ualink_metadata *md;
> +
>   		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>   
>   		if (accel_id == ualink_exp_accel_id(adev))
>   			continue;
>   
> +		/* In loopback the single MP nHT services the exporter half:
> +		 * the only messages delivered over HW are importer -> exporter
> +		 * (source = importer accel_id), while the exporter -> importer
> +		 * direction is emulated in SW and never reaches the MP nHT.
> +		 *
> +		 * The importer's doorbell reaches the MP nHT stamped with the
> +		 * GPU ID of the single physical station, the exporter, so the
> +		 * FW looks up metadata[exporter]. Publish the importer's rings
> +		 * and tail pointers in that entry.
> +		 */
> +		if (adev->ualink.loopback.enabled)
> +			md = &metadata[ualink_exp_accel_id(adev)];
> +		else
> +			md = &metadata[accel_id];
> +
>   		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>   
>   		if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
> @@ -5453,27 +5476,26 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   			wptr_gpu_addr += wptr_size * accel_id;
>   		}
>   
> -		metadata[accel_id].header = AMDGPU_UALINK_METADATA_HEADER;
> -		metadata[accel_id].rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
> +		md->header = AMDGPU_UALINK_METADATA_HEADER;
> +		md->rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
>   
>   		/*
>   		 * remote shootdown type is 0, remote command type is 1
>   		 * with 2MB ring buffer mapping, remote shootdown ring NPA is before interrupt
>   		 */
> -		metadata[accel_id].ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
> -		metadata[accel_id].tlb_inv_rb = rb_gpu_addr;
> +		md->ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
> +		md->tlb_inv_rb = rb_gpu_addr;
>   
> -		metadata[accel_id].tailptr_ri = wptr_gpu_addr +
> -						ualink_wptr_offset(adev, accel_id);
> -		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
> -						     ualink_tlb_wptr_offset(adev, accel_id);
> +		md->tailptr_ri = wptr_gpu_addr + ualink_wptr_offset(adev, accel_id);
> +		md->tailptr_tlb_inv = wptr_gpu_addr +
> +				      ualink_tlb_wptr_offset(adev, accel_id);
>   
> -		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
> -			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
> +		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, metadata entry %td, rb_size 0x%x\n",
> +			accel_id, ualink_exp_accel_id(adev), md - metadata, md->rb_size);
>   		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
> -			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
> +			md->ri_rb, md->tlb_inv_rb);
>   		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
> -			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
> +			md->tailptr_ri, md->tailptr_tlb_inv);
>   	}
>   
>   	r = adev->ualink.msg_ctl->send_metadata(adev,
> @@ -6058,6 +6080,12 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   	u64 int_wptr, tlb_wptr;
>   	int r;
>   
> +	/* UALink loopback: both ends of every ring live on this GPU, so there
> +	 * is no remote peer that can reboot and leave the pointers stale.
> +	 */
> +	if (adev->ualink.loopback.enabled)
> +		return 0;
> +
>   	/* ring->wptr and ring->rptr are owned by the send path. */
>   	guard(mutex)(&peer->lock);
>   
> @@ -6279,7 +6307,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *interrupt;
>   	struct amdgpu_ualink_ring *shootdown;
> -	u32 src_accel_id = ualink_exp_accel_id(adev);
> +	/* This sets up the send rings (local sender -> each remote dst). In
> +	 * loopback the HW-served direction is importer -> exporter, so the
> +	 * local sender is the importer; the skip below then skips the importer
> +	 * and sets up the peer[exporter] ring that the HW path needs.
> +	 */
> +	u32 src_accel_id = ualink_imp_accel_id(adev);

Why not do this in patch 1 where the function is introduced?


>   	u32 dst_accel_id;
>   	u64 npa, flags;
>   	int r = 0;
> @@ -6402,7 +6435,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>   {
>   	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 src_accel_id = ualink_exp_accel_id(adev);
> +	/* Mirror peer_remote_init: in loopback the local sender is the
> +	 * importer, so unmap the peer[exporter] send ring that was set up.
> +	 */
> +	u32 src_accel_id = ualink_imp_accel_id(adev);

Why not do this in patch 1 where the function is introduced?

Regards,
   Felix


>   	u32 dst_accel_id;
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *ring;
